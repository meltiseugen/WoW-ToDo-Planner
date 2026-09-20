local root = arg and arg[1] or "."

local function loadAddonFile(path, addon)
    local chunk, loadError = loadfile(root .. "/" .. path)
    assert(chunk, loadError)
    chunk("TODO-Planner", addon)
end

local function assertEqual(actual, expected, message)
    if actual ~= expected then
        error(string.format(
            "%s: expected %s, got %s",
            message or "values differ",
            tostring(expected),
            tostring(actual)
        ), 2)
    end
end

local function assertTrue(value, message)
    assertEqual(value, true, message)
end

local function assertNil(value, message)
    assertEqual(value, nil, message)
end

local function contains(list, expected)
    for _, value in ipairs(list) do
        if value == expected then
            return true
        end
    end
    return false
end

local clock = 1000
function time()
    clock = clock + 1
    return clock
end

function UnitFullName()
    return "Current", "Realm"
end

function UnitName()
    return "Current"
end

function GetRealmName()
    return "Realm"
end

local TDP = {
    Widgets = {},
}

loadAddonFile("Core/Constants.lua", TDP)
loadAddonFile("Core/Utils.lua", TDP)
loadAddonFile("Data/BoardManager.lua", TDP)
loadAddonFile("Data/TaskRepository.lua", TDP)
loadAddonFile("Data/Database.lua", TDP)
loadAddonFile("Integrations/Achievements.lua", TDP)

local tests = {}

local function test(name, callback)
    tests[#tests + 1] = {
        name = name,
        callback = callback,
    }
end

local function resetDatabase(database)
    TODOPlannerDB = database
    TDP.Database:Init()
end

test("deleting a board removes owned tasks and Global overrides durably", function()
    resetDatabase({
        nextTaskId = 3,
        characters = { "Farm", "Other" },
        favorites = {},
        settings = {
            selectedBoard = "Farm",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Owned",
                notes = "",
                category = "General",
                status = "DOING",
                boardKey = "Farm",
                sortOrder = 4,
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Shared",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
                statusByBoard = {
                    Farm = "DOING",
                    Other = "DONE",
                },
                sortOrderByBoard = {
                    Farm = 2,
                    Other = 3,
                },
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local ok, reason, movedTasks = TDP.Boards:DeleteBoard("Farm")
    local ownedTask = TDP.Tasks:FindById(1)
    local sharedTask = TDP.Tasks:FindById(2)
    assertTrue(ok, reason or "board deletion should succeed")
    assertEqual(movedTasks, 1, "owned task move count")
    assertEqual(ownedTask.boardKey, "GLOBAL", "owned task destination")
    assertEqual(ownedTask.status, "DOING", "owned task status")
    assertNil(sharedTask.statusByBoard.Farm, "deleted status override")
    assertNil(sharedTask.sortOrderByBoard.Farm, "deleted order override")
    assertEqual(sharedTask.statusByBoard.Other, "DONE", "unrelated status override")
    assertEqual(TODOPlannerDB.settings.selectedBoard, "GLOBAL", "selection after deletion")

    TDP.Database:Init()
    assertEqual(contains(TODOPlannerDB.characters, "Farm"), false, "deleted board after reload")
    assertTrue(contains(TODOPlannerDB.characters, "Other"), "unrelated board after reload")
end)

test("deleting an override-only board removes empty override tables", function()
    resetDatabase({
        nextTaskId = 2,
        characters = { "Overrides Only" },
        favorites = {},
        settings = {
            selectedBoard = "GLOBAL",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Shared",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
                statusByBoard = {
                    ["Overrides Only"] = "DOING",
                },
                sortOrderByBoard = {
                    ["Overrides Only"] = 1,
                },
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local ok, reason, movedTasks = TDP.Boards:DeleteBoard("Overrides Only")
    local sharedTask = TDP.Tasks:FindById(1)
    assertTrue(ok, reason or "override-only board deletion should succeed")
    assertEqual(movedTasks, 0, "override-only move count")
    assertNil(sharedTask.statusByBoard, "empty status override table")
    assertNil(sharedTask.sortOrderByBoard, "empty order override table")

    TDP.Database:Init()
    assertEqual(contains(TODOPlannerDB.characters, "Overrides Only"), false, "override-only board after reload")
end)

test("completed Global achievements normalize stale character statuses", function()
    resetDatabase({
        nextTaskId = 3,
        characters = { "Alt A", "Alt B" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Completed achievement",
                notes = "",
                category = "Achievements",
                status = "DONE",
                boardKey = "GLOBAL",
                sortOrder = 1,
                statusByBoard = {
                    ["Alt A"] = "TODO",
                    ["Alt B"] = "DONE",
                },
                sortOrderByBoard = {
                    ["Alt A"] = 2,
                    ["Alt B"] = 1,
                },
                sourceType = "achievement",
                sourceId = 123,
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Existing done task",
                notes = "",
                category = "General",
                status = "DONE",
                boardKey = "GLOBAL",
                sortOrder = 2,
                statusByBoard = {
                    ["Alt A"] = "DONE",
                },
                sortOrderByBoard = {
                    ["Alt A"] = 5,
                },
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local originalCompletionCheck = TDP.Achievements.IsAchievementComplete
    TDP.Achievements.IsAchievementComplete = function()
        return true
    end

    local achievementTask = TDP.Tasks:FindById(1)
    local changed = TDP.Achievements:AutoCompleteTask(achievementTask)
    assertTrue(changed, "stale character override should change")
    assertEqual(achievementTask.status, "DONE", "base achievement status")
    assertEqual(achievementTask.statusByBoard["Alt A"], "DONE", "stale character status")
    assertEqual(achievementTask.statusByBoard["Alt B"], "DONE", "existing character status")
    assertEqual(achievementTask.sortOrderByBoard["Alt A"], 6, "completed character sort order")
    assertEqual(TDP.Achievements:AutoCompleteTask(achievementTask), false, "already normalized task")

    TDP.Achievements.IsAchievementComplete = originalCompletionCheck
end)

test("archived achievement tasks remain unchanged", function()
    resetDatabase({
        nextTaskId = 2,
        characters = {},
        favorites = {},
        settings = {
            selectedBoard = "GLOBAL",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Archived achievement",
                notes = "",
                category = "Achievements",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
                sourceType = "achievement",
                sourceId = 456,
                archivedAt = 20,
                createdAt = 10,
                updatedAt = 20,
            },
        },
    })

    local originalCompletionCheck = TDP.Achievements.IsAchievementComplete
    TDP.Achievements.IsAchievementComplete = function()
        return true
    end

    local archivedTask = TDP.Tasks:FindById(1)
    assertEqual(TDP.Achievements:AutoCompleteTask(archivedTask), false, "archived task result")
    assertEqual(archivedTask.status, "TODO", "archived task status")

    TDP.Achievements.IsAchievementComplete = originalCompletionCheck
end)

test("Global task status and ordering remain character-specific", function()
    resetDatabase({
        nextTaskId = 3,
        characters = { "Alt A" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Shared first",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Shared second",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 2,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local firstTask = TDP.Tasks:FindById(1)
    TDP.Tasks:SetStatus(firstTask, "DOING", "Alt A")
    assertEqual(firstTask.status, "TODO", "Global base status")
    assertEqual(TDP.Tasks:GetStatus(firstTask, "Alt A"), "DOING", "character status")

    assertTrue(TDP.Tasks:MoveRelative(2, "DOING", "Alt A", 1, "before"), "relative move")
    local doingTasks = TDP.Tasks:GetForStatus("DOING", "Alt A")
    assertEqual(#doingTasks, 2, "character doing count")
    assertEqual(doingTasks[1].id, 2, "relative order first task")
    assertEqual(doingTasks[2].id, 1, "relative order second task")
    assertEqual(TDP.Tasks:GetStatus(TDP.Tasks:FindById(2), "GLOBAL"), "TODO", "unchanged Global status")
end)

test("moving a Global task to a character preserves visible status and clears overrides", function()
    resetDatabase({
        nextTaskId = 3,
        characters = { "Alt A", "Alt B" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Shared",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
                statusByBoard = {
                    ["Alt A"] = "DOING",
                    ["Alt B"] = "DONE",
                },
                sortOrderByBoard = {
                    ["Alt A"] = 3,
                    ["Alt B"] = 4,
                },
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Existing Alt B task",
                notes = "",
                category = "General",
                status = "DOING",
                boardKey = "Alt B",
                sortOrder = 5,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local sharedTask = TDP.Tasks:FindById(1)
    TDP.Tasks:MoveToBoard(sharedTask, "Alt B", "Alt A")
    assertEqual(sharedTask.boardKey, "Alt B", "target board")
    assertEqual(sharedTask.status, "DOING", "preserved source-visible status")
    assertEqual(sharedTask.sortOrder, 6, "target status order")
    assertNil(sharedTask.statusByBoard, "cleared status overrides")
    assertNil(sharedTask.sortOrderByBoard, "cleared order overrides")
end)

test("archived tasks leave active boards and appear in Archived", function()
    resetDatabase({
        nextTaskId = 2,
        characters = {},
        favorites = {},
        settings = {
            selectedBoard = "GLOBAL",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Archive me",
                notes = "",
                category = "General",
                status = "DOING",
                boardKey = "GLOBAL",
                sortOrder = 1,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local task = TDP.Tasks:FindById(1)
    TDP.Tasks:Archive(task)
    assertEqual(#TDP.Tasks:GetForStatus("DOING", "GLOBAL"), 0, "active Global count")

    local archivedTasks = TDP.Tasks:GetForStatus("DOING", "ARCHIVED")
    assertEqual(#archivedTasks, 1, "Archived count")
    assertEqual(archivedTasks[1].id, 1, "Archived task")
end)

local passed = 0
for _, currentTest in ipairs(tests) do
    local ok, errorText = pcall(currentTest.callback)
    if not ok then
        io.stderr:write("FAIL: " .. currentTest.name .. "\n" .. tostring(errorText) .. "\n")
        os.exit(1)
    end

    passed = passed + 1
    print("PASS: " .. currentTest.name)
end

print(string.format("Planner data tests passed: %d", passed))
