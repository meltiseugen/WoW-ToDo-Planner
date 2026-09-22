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

local function assertNear(actual, expected, tolerance, message)
    if math.abs(actual - expected) > tolerance then
        error(string.format(
            "%s: expected %s (+/- %s), got %s",
            message or "values differ",
            tostring(expected),
            tostring(tolerance),
            tostring(actual)
        ), 2)
    end
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
loadAddonFile("Core/MinimapButton.lua", TDP)
loadAddonFile("UI/CollectionMapWindow.lua", TDP)

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

test("Global tasks stay off character boards", function()
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
                title = "Global task",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 40,
                sourceType = "achievement",
                sourceId = 123,
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Character task",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 2,
                sourceType = "achievement",
                sourceId = 456,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local globalTask = TDP.Tasks:FindById(1)
    local globalTasks = TDP.Tasks:GetForStatus("TODO", "GLOBAL")
    local characterTasks = TDP.Tasks:GetForStatus("TODO", "Alt A")
    local allTasks = TDP.Tasks:GetForStatus("TODO", "ALL")

    assertEqual(#globalTasks, 1, "Global board count")
    assertEqual(globalTasks[1].id, 1, "Global board task")
    assertEqual(#characterTasks, 1, "character board count")
    assertEqual(characterTasks[1].id, 2, "character board task")
    assertEqual(#allTasks, 2, "aggregate board count")
    assertEqual(TDP.Tasks:IsVisibleOnBoard(globalTask, "Alt A"), false, "Global visibility on character board")
    assertEqual(TDP.Tasks:GetNextSortOrder("Alt A", "TODO"), 3, "character ordering ignores Global tasks")
    assertNil(TDP.Tasks:FindBySource("achievement", 123, "Alt A"), "Global source on character board")
    assertEqual(TDP.Tasks:FindBySource("achievement", 123, "GLOBAL").id, 1, "Global source on Global board")
end)

test("filtered views reject drag reordering and preserve hidden order", function()
    resetDatabase({
        nextTaskId = 4,
        characters = { "Alt A" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "Mounts",
        },
        tasks = {
            {
                id = 1,
                title = "Visible first",
                notes = "",
                category = "Mounts",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 1,
            },
            {
                id = 2,
                title = "Hidden middle",
                notes = "",
                category = "Reputation",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 2,
            },
            {
                id = 3,
                title = "Visible last",
                notes = "",
                category = "Mounts",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 3,
            },
        },
    })

    assertEqual(TDP.Tasks:MoveRelative(3, "TODO", "Alt A", 1, "before"), false, "filtered reorder result")
    assertEqual(TDP.Tasks:FindById(1).sortOrder, 1, "first order after rejected drag")
    assertEqual(TDP.Tasks:FindById(2).sortOrder, 2, "hidden order after rejected drag")
    assertEqual(TDP.Tasks:FindById(3).sortOrder, 3, "last order after rejected drag")
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
    local moved, reason = TDP.Tasks:MoveToBoard(sharedTask, "Alt B", "Alt A")
    assertTrue(moved, reason or "Global task should move to a character board")
    assertEqual(sharedTask.boardKey, "Alt B", "target board")
    assertEqual(sharedTask.status, "DOING", "preserved source-visible status")
    assertEqual(sharedTask.sortOrder, 6, "target status order")
    assertNil(sharedTask.statusByBoard, "cleared status overrides")
    assertNil(sharedTask.sortOrderByBoard, "cleared order overrides")
end)

test("board identity is case-insensitive and legacy duplicates are normalized", function()
    resetDatabase({
        nextTaskId = 2,
        characters = { "Farm", "farm" },
        favorites = {},
        settings = {
            selectedBoard = "FARM",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Case test",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "fArM",
                sortOrder = 1,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local matchingBoards = 0
    for _, boardKey in ipairs(TODOPlannerDB.characters) do
        if TDP.Boards:AreBoardKeysEqual(boardKey, "farm") then
            matchingBoards = matchingBoards + 1
        end
    end
    assertEqual(matchingBoards, 1, "deduplicated board count")
    assertEqual(TDP.Tasks:FindById(1).boardKey, "Farm", "canonical task board")
    assertEqual(TODOPlannerDB.settings.selectedBoard, "Farm", "canonical selected board")

    local boardKey, reason = TDP.Boards:CreateBoard("FARM")
    assertNil(boardKey, "case-only duplicate board")
    assertEqual(reason, "That board already exists.", "duplicate board error")
end)

test("character tasks can move to Global and between characters", function()
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
                title = "Move me",
                notes = "",
                category = "General",
                status = "DOING",
                boardKey = "Alt A",
                sortOrder = 1,
                createdAt = 10,
                updatedAt = 10,
            },
            {
                id = 2,
                title = "Existing Global task",
                notes = "",
                category = "General",
                status = "DOING",
                boardKey = "GLOBAL",
                sortOrder = 4,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local task = TDP.Tasks:FindById(1)
    local moved, reason = TDP.Tasks:MoveToBoard(task, "Alt B", "Alt A")
    assertTrue(moved, reason or "task should move between character boards")
    assertEqual(task.boardKey, "Alt B", "character destination")
    assertEqual(task.status, "DOING", "status after moving between characters")
    assertEqual(task.sortOrder, 5, "character destination order")

    moved, reason = TDP.Tasks:MoveToBoard(task, "GLOBAL", "Alt B")
    assertTrue(moved, reason or "character task should move to Global")
    assertEqual(task.boardKey, "GLOBAL", "Global destination")
    assertEqual(task.status, "DOING", "status after moving to Global")
    assertEqual(task.sortOrder, 5, "Global destination order")
end)

test("detailed task updates persist category status and board together", function()
    resetDatabase({
        nextTaskId = 2,
        characters = { "Alt A", "Alt B" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Before",
                notes = "Old notes",
                category = "General",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 1,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local task = TDP.Tasks:FindById(1)
    local updated, reason = TDP.Tasks:Update(task, {
        title = "After",
        notes = "New notes",
        category = "Mounts",
        status = "DOING",
        boardKey = "Alt B",
    }, "Alt A")

    assertTrue(updated, reason or "detailed update should succeed")
    assertEqual(task.title, "After", "updated title")
    assertEqual(task.notes, "New notes", "updated notes")
    assertEqual(task.category, "Mounts", "updated category")
    assertEqual(task.status, "DOING", "updated status")
    assertEqual(task.boardKey, "Alt B", "updated board")
end)

test("editing a Global task updates its Global status", function()
    resetDatabase({
        nextTaskId = 2,
        characters = { "Alt A" },
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
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local task = TDP.Tasks:FindById(1)
    local updated, reason = TDP.Tasks:Update(task, {
        title = "Shared update",
        notes = "Global only",
        category = "Reputation",
        status = "DOING",
        boardKey = "GLOBAL",
    }, "GLOBAL")

    assertTrue(updated, reason or "Global task update should succeed")
    assertEqual(task.boardKey, "GLOBAL", "Global ownership")
    assertEqual(task.status, "DOING", "updated Global status")
    assertNil(task.statusByBoard, "character status overrides")
    assertEqual(task.title, "Shared update", "updated title")
    assertEqual(task.category, "Reputation", "updated category")
end)

test("task movement rejects aggregate and current boards", function()
    resetDatabase({
        nextTaskId = 2,
        characters = { "Alt A" },
        favorites = {},
        settings = {
            selectedBoard = "Alt A",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Stay put",
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 3,
                createdAt = 10,
                updatedAt = 10,
            },
        },
    })

    local task = TDP.Tasks:FindById(1)
    assertEqual(TDP.Tasks:MoveToBoard(task, "ALL", "Alt A"), false, "All destination")
    assertEqual(TDP.Tasks:MoveToBoard(task, "ARCHIVED", "Alt A"), false, "Archived destination")
    assertEqual(TDP.Tasks:MoveToBoard(task, "Alt A", "Alt A"), false, "current destination")
    assertEqual(task.boardKey, "Alt A", "unchanged board after rejected moves")
    assertEqual(task.sortOrder, 3, "unchanged order after rejected moves")
end)

test("task ownership labels distinguish shared and local tasks", function()
    resetDatabase({
        nextTaskId = 3,
        characters = { "Alt A" },
        favorites = {},
        settings = {
            selectedBoard = "ALL",
            filterCategory = "All",
        },
        tasks = {
            {
                id = 1,
                title = "Shared",
                category = "General",
                status = "TODO",
                boardKey = "GLOBAL",
                sortOrder = 1,
            },
            {
                id = 2,
                title = "Local",
                category = "General",
                status = "TODO",
                boardKey = "Alt A",
                sortOrder = 2,
            },
        },
    })

    assertEqual(TDP.Tasks:GetOwnershipLabel(TDP.Tasks:FindById(1)), "Global", "Global ownership")
    assertEqual(TDP.Tasks:GetOwnershipLabel(TDP.Tasks:FindById(2)), "Alt A", "local ownership")
end)

test("minimap button drag uses the minimap effective scale", function()
    resetDatabase({
        characters = {},
        favorites = {},
        settings = {},
        tasks = {},
    })

    local point
    local button = {
        ClearAllPoints = function() end,
        SetPoint = function(_, _, _, _, x, y)
            point = { x = x, y = y }
        end,
    }

    Minimap = {
        GetCenter = function()
            return 100, 100
        end,
        GetEffectiveScale = function()
            return 2
        end,
        GetWidth = function()
            return 140
        end,
        GetHeight = function()
            return 140
        end,
    }
    UIParent = {
        GetEffectiveScale = function()
            return 1
        end,
    }
    GetCursorPosition = function()
        return 200, 400
    end

    TDP.MinimapButton.frame = button
    TDP.MinimapButton:UpdateDragPosition()

    assertNear(TODOPlannerDB.settings.minimapButton.angle, 90, 0.001, "drag angle")
    assertNear(point.x, 0, 0.001, "button x position")
    assertNear(point.y, 75, 0.001, "button y position")
end)

test("collection map pins preserve map coordinates while keeping a readable size", function()
    local pinSize
    local pinScale
    local pinPoint
    local iconSize
    local ringSize

    local icon = {
        SetTexture = function() end,
        SetTexCoord = function() end,
        SetVertexColor = function() end,
        SetAlpha = function() end,
        SetSize = function(_, width, height)
            iconSize = { width = width, height = height }
        end,
        Show = function() end,
    }
    local ring = {
        SetSize = function(_, width, height)
            ringSize = { width = width, height = height }
        end,
        Show = function() end,
    }
    local pin = {
        icon = icon,
        ring = ring,
        Hide = function() end,
        Show = function() end,
        ClearAllPoints = function() end,
        SetFrameLevel = function() end,
        SetScale = function(_, scale)
            pinScale = scale
        end,
        SetSize = function(_, width, height)
            pinSize = { width = width, height = height }
        end,
        SetPoint = function(_, point, relativeTo, relativePoint, x, y)
            pinPoint = {
                point = point,
                relativeTo = relativeTo,
                relativePoint = relativePoint,
                x = x,
                y = y,
            }
        end,
    }
    local mapContent = {
        GetFrameLevel = function()
            return 10
        end,
    }
    local window = TDP.CollectionMapWindow:New()
    window.layer = { layerWidth = 1000, layerHeight = 500 }
    window.mapContent = mapContent
    window.currentScale = 0.5
    window.mapID = 42
    window.pins = {
        { mapID = 42, x = 0.5, y = 0.5, icon = 12345 },
    }
    window.pinFrames = { pin }

    local rendered, total = window:RenderPins()

    assertEqual(rendered, 1, "rendered collection pin count")
    assertEqual(total, 1, "matching collection pin count")
    assertEqual(pinScale, 1, "pin inherits the map coordinate scale")
    assertNear(pinSize.width, 56, 0.001, "compensated pin width")
    assertNear(pinSize.height, 56, 0.001, "compensated pin height")
    assertNear(iconSize.width, 48, 0.001, "compensated icon width")
    assertNear(ringSize.width, 60, 0.001, "compensated ring width")
    assertEqual(pinPoint.relativeTo, mapContent, "pin anchor parent")
    assertNear(pinPoint.x, 500, 0.001, "pin map x offset")
    assertNear(pinPoint.y, -250, 0.001, "pin map y offset")
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

    assertTrue(TDP.Tasks:Unarchive(task), "restore archived task")
    assertEqual(#TDP.Tasks:GetForStatus("DOING", "GLOBAL"), 1, "restored active count")
    assertEqual(#TDP.Tasks:GetForStatus("DOING", "ARCHIVED"), 0, "restored archive count")
    assertEqual(TDP.Tasks:Unarchive(task), false, "already active restore result")
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
