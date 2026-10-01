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
loadAddonFile("Data/GeneratedPatchCollections.lua", TDP)
loadAddonFile("Data/PatchCatalog.lua", TDP)
loadAddonFile("Data/Favorites.lua", TDP)
loadAddonFile("Integrations/CollectionScanner.lua", TDP)
loadAddonFile("Integrations/Achievements.lua", TDP)
loadAddonFile("Core/MinimapButton.lua", TDP)
loadAddonFile("UI/CollectionMapWindow.lua", TDP)
loadAddonFile("UI/CollectionExplorerWindow.lua", TDP)
loadAddonFile("UI/FavoritesWindow.lua", TDP)

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

test("achievement details do not repeat generated task notes", function()
    local originalGetInfoSafe = TDP.Achievements.GetInfoSafe
    local originalSafeGetNumCriteria = TDP.Achievements.SafeGetNumCriteria
    local originalAppendSeries = TDP.Achievements.AppendSeries

    TDP.Achievements.GetInfoSafe = function()
        return {
            description = "Trigger each listed blessing effect.",
            rewardText = "Blessed cache",
        }
    end
    TDP.Achievements.SafeGetNumCriteria = function()
        return 5
    end
    TDP.Achievements.AppendSeries = function()
    end

    local generatedNotes = "Trigger each listed blessing effect.\nReward: Blessed cache"
    local generatedDetailText = TDP.Achievements:BuildDetailText({
        sourceType = "achievement",
        sourceId = 123,
        notes = generatedNotes,
    })
    assertEqual(
        generatedDetailText,
        "Trigger each listed blessing effect.\n\nReward\nBlessed cache",
        "generated achievement notes are not repeated"
    )

    local customDetailText = TDP.Achievements:BuildDetailText({
        sourceType = "achievement",
        sourceId = 123,
        notes = generatedNotes .. "\nCheck this on Tuesday.",
    })
    assertEqual(
        customDetailText,
        "Trigger each listed blessing effect.\n\nReward\nBlessed cache\n\nTask Description\nCheck this on Tuesday.",
        "custom text remains after the generated prefix"
    )

    TDP.Achievements.GetInfoSafe = originalGetInfoSafe
    TDP.Achievements.SafeGetNumCriteria = originalSafeGetNumCriteria
    TDP.Achievements.AppendSeries = originalAppendSeries
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

test("collection map right-click navigation opens the parent map and resets the view", function()
    local previousMapAPI = C_Map
    C_Map = {
        GetMapInfo = function(mapID)
            if mapID == 42 then
                return { parentMapID = 7 }
            end
            return { parentMapID = 0 }
        end,
    }

    local renderCount = 0
    local window = TDP.CollectionMapWindow:New()
    window.mapID = 42
    window.zoom = 2
    window.panX = 80
    window.panY = -35
    window.dragging = true
    window.RenderMap = function()
        renderCount = renderCount + 1
    end

    assertEqual(window:NavigateToParentMap(), true, "parent navigation result")
    assertEqual(window.mapID, 7, "parent map ID")
    assertEqual(window.zoom, 1, "parent map zoom")
    assertEqual(window.panX, 0, "parent map horizontal pan")
    assertEqual(window.panY, 0, "parent map vertical pan")
    assertEqual(window.dragging, false, "parent map dragging state")
    assertEqual(renderCount, 1, "parent map render count")

    local status
    window.SetStatus = function(_, text)
        status = text
    end
    assertEqual(window:NavigateToParentMap(), false, "root map navigation result")
    assertEqual(window.mapID, 7, "root map remains selected")
    assertEqual(renderCount, 1, "root map does not rerender")
    assertEqual(status, "This map has no parent map.", "root map status")

    C_Map = previousMapAPI
end)

test("collection map can return to its initial map", function()
    local renderCount = 0
    local window = TDP.CollectionMapWindow:New()
    window.initialMapID = 42
    window.mapID = 7
    window.zoom = 2
    window.panX = 80
    window.panY = -35
    window.dragging = true
    window.RenderMap = function()
        renderCount = renderCount + 1
    end

    assertEqual(window:ResetToInitialMap(), true, "initial map reset result")
    assertEqual(window.mapID, 42, "restored initial map ID")
    assertEqual(window.zoom, 1, "initial map zoom")
    assertEqual(window.panX, 0, "initial map horizontal pan")
    assertEqual(window.panY, 0, "initial map vertical pan")
    assertEqual(window.dragging, false, "initial map dragging state")
    assertEqual(renderCount, 1, "initial map render count")
end)

test("achievement criteria retain stable indices and asset IDs", function()
    local previousAchievementInfo = GetAchievementInfo
    local previousNumCriteria = GetAchievementNumCriteria
    local previousCriteriaInfo = GetAchievementCriteriaInfo

    GetAchievementInfo = function(achievementId)
        return achievementId, "Treasure Test", 10, false, nil, nil, nil, "Test description", 0, 12345, nil, false, false, nil
    end
    GetAchievementNumCriteria = function()
        return 1
    end
    GetAchievementCriteriaInfo = function()
        return "Test Treasure", 0, true, 1, 1, nil, 0, 98765, "1/1"
    end

    local state = TDP.CollectionScanner:GetAchievementState(63359)
    assertEqual(state.criteria[1].index, 1, "achievement criterion index")
    assertEqual(state.criteria[1].assetId, 98765, "achievement criterion asset ID")

    GetAchievementInfo = previousAchievementInfo
    GetAchievementNumCriteria = previousNumCriteria
    GetAchievementCriteriaInfo = previousCriteriaInfo
end)

test("Coiled Isle treasure pins follow achievement completion", function()
    local mount
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("12.1", "mounts")) do
        if entry.name == "Auriferous Venomfang" then
            mount = entry
            break
        end
    end

    local payload = TDP.PatchCatalog:GetCollectionMapPayload("mounts", "12.1", mount, { icon = 7002 })
    assertTrue(type(payload) == "table", "Auriferous Venomfang map payload")
    assertEqual(payload.mapAchievementId, 63359, "Coiled Isle tracking achievement")
    assertEqual(#payload.pins, 35, "Coiled Isle treasure and helper pin count")
    assertEqual(payload.pins[1].criterionIndex, 1, "Amani cache criterion")
    assertEqual(payload.pins[4].criterionIndex, 1, "Amani helper criterion")
    assertEqual(payload.pins[15].criterionIndex, 11, "Vul'zahn treasure criterion")
    assertEqual(payload.pins[17].criterionIndex, 11, "Vul'zahn helper criterion")
    assertEqual(payload.pins[23].criterionIndex, 14, "Brine chest criterion")
    assertEqual(payload.pins[27].criterionIndex, 14, "Brine helper criterion")
    assertEqual(payload.pins[35].criterionIndex, 22, "Zul'jan criterion")

    local criteria = {}
    for criterionIndex = 1, 22 do
        criteria[criterionIndex] = {
            index = criterionIndex,
            text = "Treasure " .. tostring(criterionIndex),
            completed = criterionIndex == 1 or criterionIndex == 11 or criterionIndex == 14,
        }
    end

    local window = TDP.CollectionMapWindow:New()
    window.pins = payload.pins
    window.criteria = criteria
    window.mapAchievementId = payload.mapAchievementId
    window:RefreshCriteriaProgress()
    assertTrue(window.hasCriteriaPins, "criterion-aware pin set")
    assertEqual(#window:GetVisiblePins(), 23, "completed treasure and helper pins hidden")
    assertEqual(window.pins[2].criterionCompleted, true, "Amani helper completion")
    assertEqual(window.pins[16].criterionCompleted, true, "Vul'zahn helper completion")
    assertEqual(window.pins[25].criterionCompleted, true, "Brine helper completion")
    local filteredProjection = window:CopyProjectionPayload()
    assertEqual(#filteredProjection.pins, 23, "projection uses filtered treasure pins")
    assertEqual(#filteredProjection.allPins, 35, "projection retains pins for Show completed")

    window.showCompletedCriteriaPins = true
    assertEqual(#window:GetVisiblePins(), 35, "Show completed restores every pin")
end)

test("achievement-backed collection routes map pins to their objectives", function()
    local function FindEntry(patchKey, collectionType, name)
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, collectionType)) do
            if entry.name == name then
                return entry
            end
        end
        error("Missing collection entry: " .. tostring(name))
    end

    local sootpaw = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "12.0",
        FindEntry("12.0", "pets", "Sootpaw"),
        { icon = 7003 }
    )
    assertEqual(sootpaw.mapAchievementId, 61960, "Eversong treasure achievement")
    assertEqual(#sootpaw.pins, 12, "Eversong treasure and helper pin count")
    assertEqual(sootpaw.pins[6].criterionIndex, 6, "Eversong safebox criterion")
    assertEqual(sootpaw.pins[9].criterionIndex, 6, "Eversong safebox key criterion")
    assertEqual(sootpaw.pins[12].criterionIndex, 9, "Eversong Stone Vat criterion")

    local doPet = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "12.0",
        FindEntry("12.0", "pets", "Do, Child of Filo"),
        { icon = 7009 }
    )
    assertEqual(doPet.mapAchievementId, 61091, "Midnight Safari achievement")
    assertEqual(#doPet.pins, 64, "Midnight Safari spawn pin count")
    assertEqual(doPet.pins[1].criterionIndex, 1, "Akil Fledgling criterion")
    assertEqual(doPet.pins[28].criterionIndex, 8, "Striped Snakebiter alternate criterion")
    assertEqual(doPet.pins[64].criterionIndex, 21, "Waddles criterion")

    local pango = TDP.PatchCatalog:GetCollectionMapPayload(
        "toys",
        "12.0",
        FindEntry("12.0", "toys", "Pango Plating"),
        { icon = 7004 }
    )
    assertEqual(pango.mapAchievementId, 62125, "Zul'Aman treasure achievement")
    assertEqual(#pango.pins, 15, "Zul'Aman treasure and helper pin count")
    assertEqual(pango.pins[5].criterionIndex, 1, "Honored Warrior helper criterion")
    assertEqual(pango.pins[13].criterionIndex, 5, "Twilight Blade helper criterion")
    assertEqual(pango.pins[15].criterionIndex, 7, "Secret Formula criterion")

    local chloroceros = TDP.PatchCatalog:GetCollectionMapPayload(
        "mounts",
        "12.0",
        FindEntry("12.0", "mounts", "Vivacious Chloroceros"),
        { icon = 7005 }
    )
    assertEqual(chloroceros.mapAchievementId, 61263, "Harandar treasure achievement")
    assertEqual(#chloroceros.pins, 16, "Harandar treasure and helper pin count")
    assertEqual(chloroceros.pins[14].criterionIndex, 8, "Gift of the Cycle helper criterion")
    assertEqual(chloroceros.pins[16].criterionIndex, 9, "Sporespawned Cache criterion")

    local zesty = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "12.1",
        FindEntry("12.1", "pets", "Zesty"),
        { icon = 7006 }
    )
    assertEqual(zesty.mapAchievementId, 62492, "Coiled Isle Safari achievement")
    assertEqual(#zesty.pins, 34, "Coiled Isle Safari spawn pin count")
    assertEqual(zesty.pins[1].criterionIndex, 1, "Poisoned Parasite criterion")
    assertEqual(zesty.pins[12].criterionIndex, 3, "Nightfur Kapara criterion")
    assertEqual(zesty.pins[34].criterionIndex, 8, "Autumn Snapling criterion")

    local peaks = TDP.PatchCatalog:GetCollectionMapPayload("achievements", "12.0", 62288, { icon = 7007 })
    assertEqual(peaks.mapAchievementId, 62288, "Highest Peaks achievement")
    assertEqual(#peaks.pins, 5, "Highest Peaks telescope count")
    assertEqual(peaks.pins[1].criterionIndex, 1, "first Highest Peaks telescope")
    assertEqual(peaks.pins[5].criterionIndex, 5, "last Highest Peaks telescope")
end)

test("multi-achievement glyph pins use their zone completion", function()
    local mount
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("12.0", "mounts")) do
        if entry.name == "Crimson Dragonhawk" then
            mount = entry
            break
        end
    end

    local payload = TDP.PatchCatalog:GetCollectionMapPayload("mounts", "12.0", mount, { icon = 7008 })
    assertEqual(payload.mapAchievementId, 61584, "Midnight Glyph Hunter meta-achievement")
    assertEqual(#payload.pins, 42, "Midnight glyph pin count")
    assertEqual(payload.pins[1].criterionAchievementId, 61576, "Eversong glyph achievement")
    assertEqual(payload.pins[11].criterionIndex, 11, "last Eversong glyph criterion")
    assertEqual(payload.pins[12].criterionAchievementId, 61581, "Zul'Aman glyph achievement")
    assertEqual(payload.pins[23].criterionAchievementId, 61582, "Harandar glyph achievement")
    assertEqual(payload.pins[32].criterionAchievementId, 61583, "Voidstorm glyph achievement")
    assertEqual(payload.pins[42].criterionIndex, 11, "last Voidstorm glyph criterion")

    local previousGetAchievementState = TDP.CollectionScanner.GetAchievementState
    TDP.CollectionScanner.GetAchievementState = function(_, achievementId)
        local criterionCounts = {
            [61576] = 11,
            [61581] = 11,
            [61582] = 9,
            [61583] = 11,
        }
        local criteria = {}
        for criterionIndex = 1, criterionCounts[achievementId] or 0 do
            criteria[criterionIndex] = {
                index = criterionIndex,
                text = "Glyph " .. tostring(achievementId) .. ":" .. tostring(criterionIndex),
                completed = criterionIndex == 1,
            }
        end
        return { criteria = criteria }
    end

    local window = TDP.CollectionMapWindow:New()
    window.pins = payload.pins
    window.mapAchievementId = payload.mapAchievementId
    window:RefreshCriteriaProgress()
    TDP.CollectionScanner.GetAchievementState = previousGetAchievementState

    assertEqual(#window:GetVisiblePins(), 38, "one completed glyph hidden per zone")
    assertTrue(window.pins[1].criterionCompleted, "Eversong completion applied")
    assertTrue(window.pins[12].criterionCompleted, "Zul'Aman completion applied")
    assertTrue(window.pins[23].criterionCompleted, "Harandar completion applied")
    assertTrue(window.pins[32].criterionCompleted, "Voidstorm completion applied")
    assertTrue(not window.pins[2].criterionCompleted, "unfinished glyph remains visible")

    local projected = window:CopyProjectionPayload()
    assertEqual(projected.allPins[12].criterionAchievementId, 61581, "projection keeps criterion achievement")
end)

test("older checklist maps expose stable achievement criteria", function()
    local function FindEntry(patchKey, collectionType, name)
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, collectionType)) do
            if entry.name == name then
                return entry
            end
        end
        error("Missing collection entry: " .. tostring(name))
    end

    local salaranga = TDP.PatchCatalog:GetCollectionMapPayload(
        "mounts",
        "9.1",
        FindEntry("9.1", "mounts", "Hand of Salaranga"),
        { icon = 7101 }
    )
    assertEqual(salaranga.mapAchievementId, 15064, "Breaking the Chains achievement")
    assertEqual(#salaranga.pins, 18, "Korthia meta and treasure pin count")
    assertEqual(salaranga.pins[1].criterionIndex, 1, "first Korthia meta criterion")
    assertEqual(salaranga.pins[9].criterionAchievementId, 15099, "first Korthia treasure achievement")
    assertEqual(salaranga.pins[9].criterionIndex, 1, "first Korthia treasure criterion")
    assertEqual(salaranga.pins[18].criterionIndex, 10, "last Korthia treasure criterion")

    local aurelid = TDP.PatchCatalog:GetCollectionMapPayload(
        "mounts",
        "9.2",
        FindEntry("9.2", "mounts", "Cryptic Aurelid"),
        { icon = 7102 }
    )
    assertEqual(aurelid.mapAchievementId, 15336, "From A to Zereth achievement")
    assertEqual(#aurelid.pins, 33, "Zereth meta and treasure pin count")
    assertEqual(aurelid.pins[6].criterionIndex, 7, "Synthe-fived meta criterion")
    assertEqual(aurelid.pins[7].criterionAchievementId, 15331, "first Zereth treasure achievement")
    assertEqual(aurelid.pins[7].criterionIndex, 1, "first Zereth treasure criterion")
    assertEqual(aurelid.pins[33].criterionIndex, 27, "last Zereth treasure criterion")

    local dragonSafari = TDP.PatchCatalog:GetCollectionMapPayload("achievements", "10.0", 16519, { icon = 7103 })
    assertEqual(#dragonSafari.pins, 23, "Dragon Isles Safari pin count")
    assertEqual(dragonSafari.pins[1].criterionIndex, 1, "first Dragon Isles pet criterion")
    assertEqual(dragonSafari.pins[23].criterionIndex, 23, "last Dragon Isles pet criterion")

    local tobias = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "10.1.7",
        FindEntry("10.1.7", "pets", "Tobias"),
        { icon = 7104 }
    )
    assertEqual(tobias.mapAchievementId, 18644, "Community Rumor Mill achievement")
    assertEqual(#tobias.pins, 18, "Community Rumor Mill pin count")
    assertEqual(tobias.pins[15].criterionIndex, 15, "Horde rumor criterion")
    assertEqual(tobias.pins[16].criterionIndex, 15, "Alliance rumor alternative criterion")
    assertEqual(tobias.pins[18].criterionIndex, 17, "last rumor criterion")

    local waxwick = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "11.0",
        FindEntry("11.0", "pets", "Waxwick"),
        { icon = 7105 }
    )
    assertEqual(waxwick.mapAchievementId, 40194, "Khaz Algar Safari achievement")
    assertEqual(#waxwick.pins, 30, "Khaz Algar Safari pin count")
    assertEqual(waxwick.pins[30].criterionIndex, 30, "last Khaz Algar pet criterion")

    local lettuce = TDP.PatchCatalog:GetCollectionMapPayload(
        "pets",
        "11.1",
        FindEntry("11.1", "pets", "Lettuce"),
        { icon = 7106 }
    )
    assertEqual(lettuce.mapAchievementId, 41092, "Undermine Safari achievement")
    assertEqual(#lettuce.pins, 12, "Undermine Safari pin count")
    assertEqual(lettuce.pins[12].criterionIndex, 12, "last Undermine pet criterion")

    local previousGetAchievementState = TDP.CollectionScanner.GetAchievementState
    TDP.CollectionScanner.GetAchievementState = function(_, achievementId)
        local criterionCount = achievementId == 15064 and 9 or achievementId == 15099 and 10 or 0
        local criteria = {}
        for criterionIndex = 1, criterionCount do
            criteria[criterionIndex] = {
                index = criterionIndex,
                text = "Older criterion " .. tostring(achievementId) .. ":" .. tostring(criterionIndex),
                completed = criterionIndex == 1,
            }
        end
        return { criteria = criteria }
    end

    local window = TDP.CollectionMapWindow:New()
    window.pins = salaranga.pins
    window.mapAchievementId = salaranga.mapAchievementId
    window:RefreshCriteriaProgress()
    TDP.CollectionScanner.GetAchievementState = previousGetAchievementState

    assertEqual(#window:GetVisiblePins(), 16, "completed Korthia meta and treasure pins hidden")
    assertTrue(window.pins[1].criterionCompleted, "Korthia meta completion applied")
    assertTrue(window.pins[9].criterionCompleted, "Korthia child-achievement completion applied")
    assertTrue(not window.pins[10].criterionCompleted, "unfinished Korthia treasure remains visible")
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

test("patch cosmetics exclude Trading Post entries and have details", function()
    local expectedCounts = {
        ["10.0"] = 341,
        ["10.0.5"] = 7,
        ["10.0.7"] = 29,
        ["10.1"] = 18,
        ["10.1.5"] = 119,
        ["10.1.7"] = 23,
        ["10.2"] = 123,
        ["10.2.5"] = 51,
        ["10.2.7"] = 11,
        ["11.0"] = 126,
        ["11.0.5"] = 99,
        ["11.0.7"] = 77,
        ["11.1"] = 136,
        ["11.1.5"] = 57,
        ["11.1.7"] = 1,
        ["11.2"] = 72,
        ["11.2.5"] = 191,
        ["11.2.7"] = 24,
        ["12.0"] = 93,
        ["12.0.5"] = 67,
        ["12.0.7"] = 74,
        ["12.1"] = 33,
    }

    for patchKey, expectedCount in pairs(expectedCounts) do
        local entries = TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")
        assertEqual(#entries, expectedCount, patchKey .. " cosmetic count")

        local seenIds = {}
        for _, entry in ipairs(entries) do
            assertTrue(type(entry.itemId) == "number", "cosmetic item ID")
            assertTrue(not seenIds[entry.itemId], "unique cosmetic item ID in " .. patchKey)
            seenIds[entry.itemId] = true

            local details = TDP.PatchCatalog:GetCosmeticDetails(patchKey, entry)
            assertTrue(type(details) == "table", "cosmetic details for " .. tostring(entry.name))
            local sourceText = string.lower(table.concat({ details.sourceType or "", details.source or "" }, " "))
            assertEqual(sourceText:find("trading post", 1, true), nil, "Trading Post cosmetic exclusion")

            if patchKey == "10.0" or patchKey == "10.0.5" or patchKey == "10.0.7" or patchKey == "10.1" or patchKey == "10.1.5" or patchKey == "10.1.7" or patchKey == "10.2" or patchKey == "10.2.5" or patchKey == "10.2.7" or patchKey == "11.0" or patchKey == "11.0.5" or patchKey == "11.0.7" or patchKey == "11.1.7" then
                local exclusionText = string.lower(table.concat({ entry.name or "", details.sourceType or "", details.source or "" }, " "))
                assertEqual(exclusionText:find("timewalking", 1, true), nil, patchKey .. " Timewalking cosmetic exclusion")
                assertEqual(exclusionText:find("diablo", 1, true), nil, patchKey .. " cross-game cosmetic exclusion")
                assertEqual(exclusionText:find("greedy emissary", 1, true), nil, patchKey .. " crossover cosmetic exclusion")
            end
        end
    end

    local excluded100 = { [193069] = true, [197101] = true, [199665] = true, [202190] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.0", "cosmetics")) do
        assertEqual(excluded100[entry.itemId], nil, "10.0 unavailable, manuscript, or unverified cosmetic exclusion")
        assertTrue(entry.itemId < 198742 or entry.itemId > 198773, "10.0 expedition ensemble-component exclusion")
        assertTrue(entry.itemId < 199864 or entry.itemId > 199871, "10.0 Tuskarr ensemble-component exclusion")
    end

    local excluded1007 = { [203693] = true, [203694] = true, [203695] = true, [203696] = true, [204081] = true, [204082] = true, [204086] = true, [204182] = true, [204888] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "cosmetics")) do
        assertEqual(excluded1007[entry.itemId], nil, "10.0.7 unavailable, RAF, or shop cosmetic exclusion")
    end

    local excluded1015 = { [206800] = true, [206806] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.1.5", "cosmetics")) do
        assertEqual(excluded1015[entry.itemId], nil, "10.1.5 unavailable PTR cosmetic exclusion")
        assertTrue(entry.itemId < 206888 or entry.itemId > 206925, "10.1.5 Ulderoth wrapper-component exclusion")
        assertTrue(entry.itemId < 207050 or entry.itemId > 207082, "10.1.5 Time Rift container exclusion")
    end

    local excluded1017 = { [208147] = true, [208148] = true, [208759] = true, [208761] = true, [208762] = true, [208832] = true, [209038] = true, [209039] = true, [209040] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.1.7", "cosmetics")) do
        assertEqual(excluded1017[entry.itemId], nil, "10.1.7 Trading Post or wrapper-component exclusion")
    end

    local expectedSubtypes = {
        [205363] = "ensemble",
        [205971] = "appearance",
        [207046] = "ensemble",
        [208785] = "arsenal",
        [209065] = "appearance",
        [208831] = "arsenal",
    }
    for _, patchKey in ipairs({ "10.1", "10.1.5", "10.1.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")) do
            if expectedSubtypes[entry.itemId] then
                assertEqual(entry.subtype, expectedSubtypes[entry.itemId], patchKey .. " mixed-group cosmetic subtype")
                expectedSubtypes[entry.itemId] = nil
            end
        end
    end
    assertEqual(next(expectedSubtypes), nil, "all mixed-group subtype fixtures found")

    local excluded1025 = { [211877] = true, [211881] = true, [211928] = true, [211352] = true, [211359] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.2.5", "cosmetics")) do
        assertEqual(excluded1025[entry.itemId], nil, "10.2.5 calendar-event cosmetic exclusion")
    end

    local excluded1027 = { [220785] = true, [224459] = true, [215320] = true, [217819] = true, [218120] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.2.7", "cosmetics")) do
        assertEqual(excluded1027[entry.itemId], nil, "10.2.7 event, Trading Post, and PTR-only exclusion")
    end
end)

test("Shadowlands 9.1 through 9.1.7 collections are audited and exclude holidays and promotions", function()
    local expectedCounts = {
        ["9.1"] = { mounts = 45, pets = 45, toys = 23, cosmetics = 94, achievements = 113 },
        ["9.1.5"] = { mounts = 3, pets = 0, toys = 14, cosmetics = 2, achievements = 9 },
        ["9.1.7"] = { mounts = 0, pets = 0, toys = 0, cosmetics = 0, achievements = 0 },
    }

    for patchKey, counts in pairs(expectedCounts) do
        for collectionType, expectedCount in pairs(counts) do
            assertEqual(#TDP.PatchCatalog:GetEntries(patchKey, collectionType), expectedCount, patchKey .. " " .. collectionType .. " count")
        end

        local seenMounts = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "mounts")) do
            assertTrue(type(entry.spellId) == "number", patchKey .. " mount spell ID")
            assertTrue(not seenMounts[entry.spellId], patchKey .. " unique mount spell ID")
            seenMounts[entry.spellId] = true
            assertTrue(type(TDP.PatchCatalog:GetMountDetails(patchKey, entry)) == "table", patchKey .. " mount details for " .. entry.name)
        end

        local seenPets = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "pets")) do
            assertTrue(type(entry.speciesId) == "number", patchKey .. " pet species ID")
            assertTrue(not seenPets[entry.speciesId], patchKey .. " unique pet species ID")
            seenPets[entry.speciesId] = true
            assertTrue(type(TDP.PatchCatalog:GetPetDetails(patchKey, entry)) == "table", patchKey .. " pet details for " .. entry.name)
        end

        local seenToys = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertTrue(type(entry.itemId) == "number", patchKey .. " toy item ID")
            assertTrue(not seenToys[entry.itemId], patchKey .. " unique toy item ID")
            seenToys[entry.itemId] = true
            assertTrue(type(TDP.PatchCatalog:GetToyDetails(patchKey, entry)) == "table", patchKey .. " toy details for " .. entry.name)
        end

        local seenCosmetics = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")) do
            assertTrue(type(entry.itemId) == "number", patchKey .. " cosmetic item ID")
            assertTrue(not seenCosmetics[entry.itemId], patchKey .. " unique cosmetic item ID")
            seenCosmetics[entry.itemId] = true
            assertTrue(type(TDP.PatchCatalog:GetCosmeticDetails(patchKey, entry)) == "table", patchKey .. " cosmetic details for " .. entry.name)
        end

        local seenAchievements = {}
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertTrue(type(achievementId) == "number", patchKey .. " achievement ID")
            assertTrue(not seenAchievements[achievementId], patchKey .. " unique achievement ID")
            seenAchievements[achievementId] = true
            assertTrue(type(TDP.PatchCatalog:GetAchievementDetails(patchKey, achievementId)) == "table", patchKey .. " achievement details")
            assertTrue(type(TDP.PatchCatalog:GetAchievementCategory(patchKey, achievementId)) == "string", patchKey .. " achievement category")
        end
    end

    local excludedMountSpells = {
        [347812] = true, -- Sapphire Skyblazer: promotion
        [350529] = true, -- unused DNT mount record
        [356488] = true, -- Sarge's Tale: Hearthstone promotion
        [359317] = true, -- Wen Lo: shop
        [359843] = true, -- Tangled Dreamweaver: promotion
        [363608] = true, -- incomplete duplicate Lightforged record
    }
    local excludedPetSpecies = {
        [3089] = true, [3090] = true, [3091] = true, -- NPC-only records
        [3100] = true, -- anniversary reward
        [3153] = true, [3177] = true, -- shop and promotion
        [3155] = true, [3156] = true, [3158] = true, [3188] = true, -- unavailable records
    }
    local excludedToyIds = {
        [186501] = true, -- anniversary reward
        [187422] = true, [187834] = true, [187861] = true, [187957] = true,
        [187958] = true, [187959] = true, [188680] = true, [188694] = true,
        [188695] = true, [188698] = true, [188699] = true, [188701] = true,
    }
    local excludedAchievementIds = {
        [14934] = true, [14942] = true, [14944] = true, [14954] = true,
        [15068] = true, [15071] = true, [15111] = true, [15136] = true,
        [15181] = true, [15186] = true, [15192] = true, [15226] = true,
        [15227] = true, [15247] = true, [15312] = true, [15313] = true,
        [15323] = true, [15395] = true, [15403] = true,
    }
    local excludedCosmeticIds = {
        [184828] = true, [184829] = true, -- shop cosmetics
        [185303] = true, -- ordinary equippable gear
        [186093] = true, [187914] = true, -- unavailable records
        [188135] = true, [188136] = true, -- shop cosmetics
        [188236] = true, [188237] = true, [188243] = true, [188244] = true,
        [188248] = true, [188249] = true, -- Trial of Style event rewards
    }

    for _, patchKey in ipairs({ "9.1", "9.1.5", "9.1.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "mounts")) do
            assertEqual(excludedMountSpells[entry.spellId], nil, patchKey .. " shop, promotion, or unavailable mount exclusion")
        end
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "pets")) do
            assertEqual(excludedPetSpecies[entry.speciesId], nil, patchKey .. " holiday, shop, promotion, NPC-only, or unavailable pet exclusion")
        end
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertEqual(excludedToyIds[entry.itemId], nil, patchKey .. " holiday, esports, placeholder, or unavailable toy exclusion")
        end
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")) do
            assertEqual(excludedCosmeticIds[entry.itemId], nil, patchKey .. " holiday, shop, unavailable, or ordinary-gear cosmetic exclusion")
        end
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertEqual(excludedAchievementIds[achievementId], nil, patchKey .. " holiday, promotion, hidden, DNT, or statistics achievement exclusion")
        end
    end

    local patchKeys = TDP.PatchCatalog:GetPatchKeys()
    assertEqual(patchKeys[1], "9.1", "semantic patch ordering starts with 9.1")
    assertEqual(patchKeys[2], "9.1.5", "semantic patch ordering keeps 9.1.5 second")
    assertEqual(patchKeys[3], "9.1.7", "semantic patch ordering keeps 9.1.7 third")
end)

test("Shadowlands 9.2 through 9.2.7 collections are audited and exclude holidays and promotions", function()
    local expectedCounts = {
        ["9.2"] = { mounts = 41, pets = 53, toys = 13, cosmetics = 22, achievements = 107 },
        ["9.2.5"] = { mounts = 7, pets = 0, toys = 2, cosmetics = 3, achievements = 45 },
        ["9.2.7"] = { mounts = 0, pets = 0, toys = 0, cosmetics = 0, achievements = 0 },
    }

    for patchKey, counts in pairs(expectedCounts) do
        for collectionType, expectedCount in pairs(counts) do
            assertEqual(#TDP.PatchCatalog:GetEntries(patchKey, collectionType), expectedCount, patchKey .. " " .. collectionType .. " count")
        end

        local seenMounts = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "mounts")) do
            assertTrue(type(entry.spellId) == "number", patchKey .. " mount spell ID")
            assertTrue(not seenMounts[entry.spellId], patchKey .. " unique mount spell ID")
            seenMounts[entry.spellId] = true
            assertTrue(type(TDP.PatchCatalog:GetMountDetails(patchKey, entry)) == "table", patchKey .. " mount details for " .. entry.name)
        end

        local seenPets = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "pets")) do
            assertTrue(type(entry.speciesId) == "number", patchKey .. " pet species ID")
            assertTrue(not seenPets[entry.speciesId], patchKey .. " unique pet species ID")
            seenPets[entry.speciesId] = true
            assertTrue(type(TDP.PatchCatalog:GetPetDetails(patchKey, entry)) == "table", patchKey .. " pet details for " .. entry.name)
        end

        local seenToys = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertTrue(type(entry.itemId) == "number", patchKey .. " toy item ID")
            assertTrue(not seenToys[entry.itemId], patchKey .. " unique toy item ID")
            seenToys[entry.itemId] = true
            assertTrue(type(TDP.PatchCatalog:GetToyDetails(patchKey, entry)) == "table", patchKey .. " toy details for " .. entry.name)
        end

        local seenCosmetics = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")) do
            assertTrue(type(entry.itemId) == "number", patchKey .. " cosmetic item ID")
            assertTrue(not seenCosmetics[entry.itemId], patchKey .. " unique cosmetic item ID")
            seenCosmetics[entry.itemId] = true
            assertTrue(type(TDP.PatchCatalog:GetCosmeticDetails(patchKey, entry)) == "table", patchKey .. " cosmetic details for " .. entry.name)
        end

        local seenAchievements = {}
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertTrue(type(achievementId) == "number", patchKey .. " achievement ID")
            assertTrue(not seenAchievements[achievementId], patchKey .. " unique achievement ID")
            seenAchievements[achievementId] = true
            assertTrue(type(TDP.PatchCatalog:GetAchievementDetails(patchKey, achievementId)) == "table", patchKey .. " achievement details")
            assertTrue(type(TDP.PatchCatalog:GetAchievementCategory(patchKey, achievementId)) == "string", patchKey .. " achievement category")
        end
    end

    local excludedMountSpells = {
        [369476] = true, -- Amalgam of Rage: Diablo IV crossover
        [369451] = true, -- Jade, Bright Foreseer: shop
        [367676] = true, -- Nether-Gorged Greatwyrm: shop
        [370770] = true, -- Tuskarr Shoreglider: promotion
        [386452] = true, -- Frostbrood Proto-Wyrm: Wrath Classic promotion
    }
    for _, patchKey in ipairs({ "9.2", "9.2.5", "9.2.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "mounts")) do
            assertEqual(excludedMountSpells[entry.spellId], nil, patchKey .. " crossover, shop, or promotion mount exclusion")
        end
    end

    local excludedPetSpecies = { [3175] = true, [3246] = true, [3248] = true, [3249] = true }
    for _, patchKey in ipairs({ "9.2", "9.2.5", "9.2.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "pets")) do
            assertEqual(excludedPetSpecies[entry.speciesId], nil, patchKey .. " promotion, shop, or unavailable pet exclusion")
        end
    end

    local excludedToyIds = {
        [187689] = true, -- Dance Dance Darkmoon: Darkmoon Faire
        [191925] = true, -- Falling Star Flinger: Winter Veil
        [191937] = true, -- Falling Star Catcher: Winter Veil
        [193588] = true, -- Timewalker's Hearthstone: Dragonflight promotion
    }
    for _, patchKey in ipairs({ "9.2", "9.2.5", "9.2.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertEqual(excludedToyIds[entry.itemId], nil, patchKey .. " holiday or promotion toy exclusion")
        end
    end

    local excludedAchievementIds = {
        [15212] = true, [15213] = true, [15214] = true, [15215] = true, [15216] = true,
        [15217] = true, [15218] = true, [15221] = true, [15222] = true, [15223] = true,
        [15344] = true, [15557] = true, [15594] = true, [15640] = true, [15645] = true,
        [15653] = true, [16414] = true,
    }
    for _, patchKey in ipairs({ "9.2", "9.2.5", "9.2.7" }) do
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertEqual(excludedAchievementIds[achievementId], nil, patchKey .. " holiday, promotion, crossover, or hidden achievement exclusion")
        end
    end

    local excludedCosmeticIds = {
        [188256] = true, [188257] = true, [188258] = true, [188259] = true, [188260] = true,
        [191616] = true, [191617] = true, [191618] = true, [191619] = true, [191620] = true,
        [191621] = true, [191622] = true, [191627] = true, [191628] = true, [191774] = true,
        [191775] = true, [191776] = true, [191779] = true, [193610] = true,
    }
    for _, patchKey in ipairs({ "9.2", "9.2.5", "9.2.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "cosmetics")) do
            assertEqual(excludedCosmeticIds[entry.itemId], nil, patchKey .. " shop or promotion cosmetic exclusion")
            assertTrue(entry.itemId ~= 190007 and entry.itemId ~= 190735, patchKey .. " ordinary equippable-drop exclusion")
        end
    end

    local patchKeys = TDP.PatchCatalog:GetPatchKeys()
    assertEqual(patchKeys[4], "9.2", "semantic patch ordering keeps 9.2 fourth")
    assertEqual(patchKeys[5], "9.2.5", "semantic patch ordering keeps 9.2.5 fifth")
    assertEqual(patchKeys[6], "9.2.7", "semantic patch ordering keeps 9.2.7 sixth")
end)

test("Dragonflight 10.0 through 10.0.7 collections are audited and exclude holiday rewards", function()
    local expectedCounts = {
        ["10.0"] = { mounts = 39, pets = 99, toys = 59, cosmetics = 341, achievements = 631 },
        ["10.0.5"] = { mounts = 1, pets = 1, toys = 3, cosmetics = 7, achievements = 116 },
        ["10.0.7"] = { mounts = 4, pets = 18, toys = 15, cosmetics = 29, achievements = 103 },
    }

    for patchKey, counts in pairs(expectedCounts) do
        for collectionType, expectedCount in pairs(counts) do
            assertEqual(#TDP.PatchCatalog:GetEntries(patchKey, collectionType), expectedCount, patchKey .. " " .. collectionType .. " count")
        end

        local seenMounts = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "mounts")) do
            assertTrue(type(entry.spellId) == "number", patchKey .. " mount spell ID")
            assertTrue(not seenMounts[entry.spellId], patchKey .. " unique mount spell ID")
            seenMounts[entry.spellId] = true
            assertTrue(type(TDP.PatchCatalog:GetMountDetails(patchKey, entry)) == "table", patchKey .. " mount details for " .. entry.name)
        end

        local seenPets = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "pets")) do
            assertTrue(type(entry.speciesId) == "number", patchKey .. " pet species ID")
            assertTrue(not seenPets[entry.speciesId], patchKey .. " unique pet species ID")
            seenPets[entry.speciesId] = true
            assertTrue(type(TDP.PatchCatalog:GetPetDetails(patchKey, entry)) == "table", patchKey .. " pet details for " .. entry.name)
        end

        local seenToys = {}
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertTrue(type(entry.itemId) == "number", patchKey .. " toy item ID")
            assertTrue(not seenToys[entry.itemId], patchKey .. " unique toy item ID")
            seenToys[entry.itemId] = true
            assertTrue(type(TDP.PatchCatalog:GetToyDetails(patchKey, entry)) == "table", patchKey .. " toy details for " .. entry.name)
        end

        local seenAchievements = {}
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertTrue(type(achievementId) == "number", patchKey .. " achievement ID")
            assertTrue(not seenAchievements[achievementId], patchKey .. " unique achievement ID")
            seenAchievements[achievementId] = true
            assertTrue(type(TDP.PatchCatalog:GetAchievementDetails(patchKey, achievementId)) == "table", patchKey .. " achievement details")
            assertTrue(type(TDP.PatchCatalog:GetAchievementCategory(patchKey, achievementId)) == "string", patchKey .. " achievement category")
        end
    end

    local excludedToyIds = {
        [199337] = true, -- Bag of Furious Winds: Dragonflight pre-patch only
        [200142] = true, -- Generous Goblin Grenade: removed/unverified
        [202711] = true, -- Lost Compass: unverified launch source
        [197961] = true, -- Whelps on Strings: placeholder at launch
        [203716] = true, -- Thundering Banner of the Aspects: unobtainable record
        [204675] = true, -- A Drake's Big Basket of Eggs: Noblegarden
    }
    for _, patchKey in ipairs({ "10.0", "10.0.5", "10.0.7" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "toys")) do
            assertEqual(excludedToyIds[entry.itemId], nil, patchKey .. " limited, unverified, or holiday toy exclusion")
        end
    end

    for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries("10.0.5", "achievements")) do
        assertTrue(achievementId ~= 17321, "10.0.5 Elders of the Dragon Isles holiday achievement exclusion")
    end
    for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "achievements")) do
        assertTrue(achievementId ~= 17426, "10.0.7 Recruit-a-Friend achievement exclusion")
        assertTrue(achievementId < 17344 or achievementId > 17361, "10.0.7 Warcraft Rumble crossover achievement exclusion")
    end


    local requiredLaunchAchievements = { [15325] = false, [15638] = false }
    for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries("10.0", "achievements")) do
        if requiredLaunchAchievements[achievementId] ~= nil then
            requiredLaunchAchievements[achievementId] = true
        end
    end
    assertTrue(requiredLaunchAchievements[15325], "10.0 Alliance Dracthyr, Awaken achievement")
    assertTrue(requiredLaunchAchievements[15638], "10.0 Horde Dracthyr, Awaken achievement")

    local required1007Toys = { [202253] = false, [202283] = false, [204405] = false }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "toys")) do
        if required1007Toys[entry.itemId] ~= nil then
            required1007Toys[entry.itemId] = true
        end
    end
    assertTrue(required1007Toys[202253], "10.0.7 Primal Stave of Claw and Fur toy")
    assertTrue(required1007Toys[202283], "10.0.7 Reading Glasses toy")
    assertTrue(required1007Toys[204405], "10.0.7 Stuffed Bear toy")

    local excludedCosmeticIds = { [203693] = true, [203694] = true, [203695] = true, [203696] = true, [204888] = true }
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "cosmetics")) do
        assertEqual(excludedCosmeticIds[entry.itemId], nil, "10.0.7 unavailable or Recruit-a-Friend cosmetic exclusion")
    end

    local skyskin = TDP.PatchCatalog:GetEntries("10.0.5", "mounts")[1]
    assertEqual(skyskin.spellId, 352926, "Skyskin Hornstrider spell ID")
    assertEqual(skyskin.itemId, 192800, "Skyskin Hornstrider item ID")
    assertEqual(TDP.PatchCatalog:GetMountDetails("10.0.5", skyskin).cost, "150 Essence of the Storm and 3,000 Elemental Overflow.", "Skyskin Hornstrider cost")

    local mossyMammoth
    for _, entry in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "mounts")) do
        if entry.name == "Mossy Mammoth" then
            mossyMammoth = entry
            break
        end
    end
    local mossyPayload = TDP.PatchCatalog:GetCollectionMapPayload("mounts", "10.0.7", mossyMammoth, { icon = 7001 })
    assertTrue(type(mossyPayload) == "table", "Mossy Mammoth map payload")
    assertEqual(mossyPayload.pins[1].mapName, "The Forbidden Reach", "Mossy Mammoth map")

    local timeLostFoal = TDP.PatchCatalog:GetEntries("10.0.5", "pets")[1]
    assertEqual(timeLostFoal.speciesId, 3334, "Time-Lost Vorquin Foal species ID")
    assertEqual(TDP.PatchCatalog:GetPetDetails("10.0.5", timeLostFoal).cost, "105 Essence of the Storm and 1,500 Elemental Overflow.", "Time-Lost Vorquin Foal cost")
end)

test("Dragonflight 10.1 through The War Within 11.2.7 mounts are audited", function()
    local expectedCounts = {
        ["10.1"] = 15,
        ["10.1.5"] = 11,
        ["10.1.7"] = 4,
        ["10.2"] = 25,
        ["10.2.5"] = 3,
        ["10.2.6"] = 18,
        ["10.2.7"] = 29,
        ["11.0"] = 36,
        ["11.0.5"] = 1,
        ["11.0.7"] = 14,
        ["11.1"] = 31,
        ["11.1.5"] = 12,
        ["11.1.7"] = 4,
        ["11.2"] = 24,
        ["11.2.5"] = 44,
        ["11.2.7"] = 12,
    }
    local excludedSpellIds = {
        [171840] = true, -- Coldflame Infernal: Trading Post
        [213349] = true, -- Flarecore Infernal: Trading Post
        [358072] = true, -- Bound Blizzard: promotion
        [400976] = true, -- Gleaming Moonbeast: shop
        [405623] = true, -- Armadillo Roller: removed legacy tracking record
        [411565] = true, -- Felcrystal Scorpion: Trading Post
        [412088] = true, -- duplicate/non-live Grotto Netherwing record
        [413409] = true, -- duplicate dragonriding journal record
        [414986] = true, -- Royal Swarmer: Trading Post
        [417245] = true, -- Trading Post reward
        [417888] = true, -- Algarian Stormrider: expansion promotion
        [418286] = true, -- Auspicious Arborwyrm: shop
        [419002] = true, -- TEMP placeholder
        [419345] = true, -- Trading Post reward
        [419567] = true, -- shop reward
        [420097] = true, -- Azure Worldchiller: anniversary holiday
        [424009] = true, -- Runebound Firelord: promotion
        [427435] = true, -- Crimson Glimmerfur: Trading Post
        [428005] = true, -- Jeweled Copper Scarab: Trading Post
    }

    local total = 0
    local seenSpellIds = {}
    for patchKey, expectedCount in pairs(expectedCounts) do
        local entries = TDP.PatchCatalog:GetEntries(patchKey, "mounts")
        assertEqual(#entries, expectedCount, patchKey .. " mount count")
        total = total + #entries

        for _, entry in ipairs(entries) do
            assertTrue(type(entry.spellId) == "number", patchKey .. " mount spell ID")
            assertTrue(type(entry.name) == "string" and entry.name ~= "", patchKey .. " mount name")
            assertEqual(excludedSpellIds[entry.spellId], nil, patchKey .. " holiday, shop, promotion, Trading Post, duplicate, or placeholder exclusion")
            assertEqual(seenSpellIds[entry.spellId], nil, patchKey .. " mount spell ID first appears in only one patch")
            seenSpellIds[entry.spellId] = patchKey

            local details = TDP.PatchCatalog:GetMountDetails(patchKey, entry)
            assertTrue(type(details) == "table", patchKey .. " mount details for " .. entry.name)
            assertTrue(type(details.category) == "string", patchKey .. " mount category for " .. entry.name)
            assertTrue(type(details.source) == "string", patchKey .. " mount source for " .. entry.name)
            assertTrue(type(details.acquisition) == "string", patchKey .. " mount acquisition for " .. entry.name)
        end
    end
    assertEqual(total, 283, "10.1 through 11.2.7 audited mount total")

    local patchKeys = TDP.PatchCatalog:GetPatchKeys()
    local positions = {}
    for index, patchKey in ipairs(patchKeys) do
        positions[patchKey] = index
    end
    assertEqual(positions["10.2.6"], positions["10.2.5"] + 1, "10.2.6 follows 10.2.5")
    assertEqual(positions["10.2.7"], positions["10.2.6"] + 1, "10.2.7 follows 10.2.6")
end)

test("10.1 through 11.2.7 pets toys and achievements are populated and globally unique", function()
    local expectedCounts = {
        ["10.1"] = { pets = 42, toys = 12, achievements = 228 },
        ["10.1.5"] = { pets = 17, toys = 8, achievements = 47 },
        ["10.1.7"] = { pets = 1, toys = 8, achievements = 135 },
        ["10.2"] = { pets = 29, toys = 6, achievements = 246 },
        ["10.2.5"] = { pets = 2, toys = 1, achievements = 12 },
        ["10.2.6"] = { pets = 3, toys = 2, achievements = 68 },
        ["10.2.7"] = { pets = 2, toys = 2, achievements = 158 },
        ["11.0"] = { pets = 111, toys = 31, achievements = 910 },
        ["11.0.5"] = { pets = 0, toys = 0, achievements = 0 },
        ["11.0.7"] = { pets = 15, toys = 4, achievements = 56 },
        ["11.1"] = { pets = 46, toys = 18, achievements = 230 },
        ["11.1.5"] = { pets = 4, toys = 4, achievements = 123 },
        ["11.1.7"] = { pets = 2, toys = 2, achievements = 29 },
        ["11.2"] = { pets = 22, toys = 7, achievements = 200 },
        ["11.2.5"] = { pets = 3, toys = 3, achievements = 254 },
        ["11.2.7"] = { pets = 1, toys = 3, achievements = 87 },
    }

    for patchKey, counts in pairs(expectedCounts) do
        for collectionType, expectedCount in pairs(counts) do
            assertEqual(#TDP.PatchCatalog:GetEntries(patchKey, collectionType), expectedCount, patchKey .. " " .. collectionType .. " count")
        end
        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertTrue(type(TDP.PatchCatalog:GetAchievementCategory(patchKey, achievementId)) == "string", patchKey .. " achievement category")
        end
    end

    assertNil(TDP.PatchCatalog:GetPatch("Unknown"), "Unknown placeholder patch exclusion")

    local idFields = {
        mounts = "spellId",
        pets = "speciesId",
        toys = "itemId",
        cosmetics = "itemId",
    }
    local seen = { mounts = {}, pets = {}, toys = {}, cosmetics = {}, achievements = {} }
    local prohibitedTerms = {
        "trading post", "traveler's log", "in-game shop", "battle.net shop",
        "promotion", "twitch", "discord quest", "blizzcon", "china-only",
        "holiday", "midsummer", "winter veil", "noblegarden", "children's week",
        "brewfest", "hallow's end", "lunar festival", "love is in the air",
        "headless horseman", "abominable greench",
    }

    for _, patchKey in ipairs(TDP.PatchCatalog:GetPatchKeys()) do
        for collectionType, idField in pairs(idFields) do
            for _, entry in ipairs(TDP.PatchCatalog:GetEntries(patchKey, collectionType)) do
                local id = entry[idField]
                assertNil(seen[collectionType][id], collectionType .. " ID appears in only one patch")
                seen[collectionType][id] = patchKey

                local details = TDP.PatchCatalog:GetCollectionDetails(collectionType, patchKey, entry)
                assertTrue(type(details) == "table", patchKey .. " " .. collectionType .. " detail coverage")
                local detailText = string.lower(table.concat({
                    details.category or "", details.sourceType or "", details.source or "", details.availability or "",
                }, " "))
                for _, term in ipairs(prohibitedTerms) do
                    assertNil(detailText:find(term, 1, true), patchKey .. " excludes " .. term)
                end
            end
        end

        for _, achievementId in ipairs(TDP.PatchCatalog:GetEntries(patchKey, "achievements")) do
            assertNil(seen.achievements[achievementId], "achievement ID appears in only one patch")
            seen.achievements[achievementId] = patchKey
            assertTrue(type(TDP.PatchCatalog:GetAchievementDetails(patchKey, achievementId)) == "table", patchKey .. " achievement detail coverage")
        end
    end
end)

test("cosmetic scanner tracks single appearances and set progress", function()
    local previousItem = C_Item
    local previousCollection = C_TransmogCollection
    local previousSets = C_TransmogSets

    C_Item = {
        GetItemNameByID = function(itemId)
            return "Item " .. tostring(itemId)
        end,
        GetItemIconByID = function()
            return 12345
        end,
        GetItemLearnTransmogSet = function()
            return 77
        end,
    }
    C_TransmogCollection = {
        PlayerHasTransmogByItemInfo = function(itemId)
            return itemId == 100
        end,
        GetAppearanceInfoBySource = function(sourceId)
            return {
                appearanceID = sourceId == 12 and 11 or sourceId,
                appearanceIsCollected = sourceId == 11 or sourceId == 12,
            }
        end,
        PlayerHasTransmogItemModifiedAppearance = function()
            return false
        end,
    }
    C_TransmogSets = {
        GetAllSourceIDs = function()
            return { 11, 12, 13 }
        end,
    }

    local single = TDP.CollectionScanner:GetState("cosmetics", { itemId = 100, name = "Single", subtype = "appearance" })
    assertTrue(single.collected, "single appearance collection state")
    assertEqual(single.icon, 12345, "single appearance icon")

    local ensemble = TDP.CollectionScanner:GetState("cosmetics", { itemId = 200, name = "Set", subtype = "ensemble" })
    assertEqual(ensemble.setId, 77, "ensemble set ID")
    assertEqual(ensemble.totalCount, 2, "deduplicated ensemble appearance count")
    assertEqual(ensemble.collectedCount, 1, "ensemble collected appearance count")
    assertEqual(ensemble.collected, false, "incomplete ensemble state")

    C_Item = previousItem
    C_TransmogCollection = previousCollection
    C_TransmogSets = previousSets
end)

test("cosmetic map payload includes curated acquisition and pins", function()
    local entry = TDP.PatchCatalog:GetEntries("12.1", "cosmetics")[1]
    local payload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "12.1", entry, { icon = 9876 })
    assertTrue(type(payload) == "table", "cosmetic map payload")
    assertTrue(type(payload.pins) == "table" and #payload.pins > 0, "cosmetic map pins")
    assertEqual(payload.collectionType, "cosmetics", "cosmetic map type")
    assertEqual(payload.pins[1].icon, 9876, "cosmetic map icon")
    assertTrue(type(payload.acquisition) == "string" and payload.acquisition ~= "", "cosmetic acquisition text")

    local launchEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("11.0", "cosmetics")) do
        if candidate.itemId == 218345 then
            launchEntry = candidate
            break
        end
    end
    local launchPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "11.0", launchEntry, { icon = 5432 })
    assertTrue(type(launchPayload) == "table", "11.0 cosmetic map payload")
    assertEqual(launchPayload.cost, "1,625 Resonance Crystals", "item-specific cosmetic map cost")
    assertEqual(launchPayload.requirements, "Council of Dornogal Renown 5", "item-specific cosmetic map requirement")
    assertTrue(type(launchPayload.researchNotes) == "string" and launchPayload.researchNotes ~= "", "cosmetic map research notes")

    local mapWindow = TDP.CollectionMapWindow:New()
    mapWindow.sourceSummary = launchPayload.sourceSummary
    mapWindow.acquisition = launchPayload.acquisition
    mapWindow.requirements = launchPayload.requirements
    mapWindow.cost = launchPayload.cost
    mapWindow.researchNotes = launchPayload.researchNotes
    mapWindow.pins = launchPayload.pins
    local detailText = mapWindow:BuildDetailsText()
    assertTrue(detailText:find("Requirements:", 1, true) ~= nil, "map detail requirements")
    assertTrue(detailText:find("Cost:", 1, true) ~= nil, "map detail cost")
    assertTrue(detailText:find("Research notes:", 1, true) ~= nil, "map detail research notes")

    local treasureEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.2.5", "cosmetics")) do
        if candidate.itemId == 213006 then
            treasureEntry = candidate
            break
        end
    end
    local treasurePayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.2.5", treasureEntry, { icon = 6789 })
    assertTrue(type(treasurePayload) == "table", "10.2.5 treasure map payload")
    assertEqual(#treasurePayload.pins, 11, "Bel'ameth treasure pin count")
    assertEqual(treasurePayload.pins[1].mapName, "Amirdrassil", "Bel'ameth map name")

    local moltenEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.1", "cosmetics")) do
        if candidate.itemId == 205981 then
            moltenEntry = candidate
            break
        end
    end
    local moltenPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.1", moltenEntry, { icon = 6790 })
    assertTrue(type(moltenPayload) == "table", "10.1 Molten Hoard map payload")
    assertEqual(#moltenPayload.pins, 2, "Molten Hoard entrance and chest pins")
    assertEqual(moltenPayload.pins[1].mapName, "Zaralek Cavern", "Molten Hoard map name")

    local brackenhideEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.0", "cosmetics")) do
        if candidate.itemId == 201363 then
            brackenhideEntry = candidate
            break
        end
    end
    local brackenhidePayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.0", brackenhideEntry, { icon = 6794 })
    assertTrue(type(brackenhidePayload) == "table", "10.0 Brackenhide map payload")
    assertEqual(#brackenhidePayload.pins, 2, "Brackenhide route pin count")
    assertEqual(brackenhidePayload.pins[1].mapName, "The Azure Span", "Brackenhide map name")
    assertTrue(type(brackenhidePayload.researchNotes) == "string" and brackenhidePayload.researchNotes ~= "", "Brackenhide research notes")

    local zulGurubEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.0.7", "cosmetics")) do
        if candidate.itemId == 203974 then
            zulGurubEntry = candidate
            break
        end
    end
    local zulGurubPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.0.7", zulGurubEntry, { icon = 6795 })
    assertTrue(type(zulGurubPayload) == "table", "10.0.7 Zul'Gurub map payload")
    assertEqual(#zulGurubPayload.pins, 2, "Zul'Gurub unlock and vendor pin count")
    assertEqual(zulGurubPayload.pins[1].mapName, "Northern Stranglethorn", "Zul'Gurub entrance map name")
    assertEqual(zulGurubPayload.pins[2].mapName, "Dazar'alor", "Zul'Gurub vendor map name")

    local ulderothEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.1.5", "cosmetics")) do
        if candidate.itemId == 207046 then
            ulderothEntry = candidate
            break
        end
    end
    local ulderothPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.1.5", ulderothEntry, { icon = 6791 })
    assertTrue(type(ulderothPayload) == "table", "10.1.5 Ulderoth map payload")
    assertEqual(#ulderothPayload.pins, 2, "Ulderoth event and vendor pins")
    assertEqual(ulderothPayload.pins[1].mapName, "Thaldraszus", "Ulderoth map name")

    local titanKeyEntry
    local manariEntry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("10.1.7", "cosmetics")) do
        if candidate.itemId == 208831 then
            titanKeyEntry = candidate
        elseif candidate.itemId == 208686 then
            manariEntry = candidate
        end
    end
    local titanKeyPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.1.7", titanKeyEntry, { icon = 6792 })
    assertTrue(type(titanKeyPayload) == "table", "10.1.7 Titan Key map payload")
    assertEqual(#titanKeyPayload.pins, 4, "Titan Key clue and material pins")
    assertEqual(titanKeyPayload.pins[2].mapName, "The Waking Shores", "Titan Key material map name")

    local manariPayload = TDP.PatchCatalog:GetCollectionMapPayload("cosmetics", "10.1.7", manariEntry, { icon = 6793 })
    assertTrue(type(manariPayload) == "table", "10.1.7 Man'ari map payload")
    assertEqual(manariPayload.cost, "100 Empyrium, 5 Argulite, and 90 Veiled Argunite", "Man'ari item-specific material cost")
    assertEqual(manariPayload.pins[1].mapName, "Krokuun", "Man'ari vendor map name")
end)

test("collection map details omit raw waypoint commands", function()
    local mapWindow = TDP.CollectionMapWindow:New()
    mapWindow.sourceSummary = "Test source"
    mapWindow.waypoints = { "/way #2395 50.0 60.0 Test location" }
    mapWindow.pins = {
        {
            mapID = 2395,
            mapName = "Eversong Woods",
            x = 0.5,
            y = 0.6,
            label = "Test location",
            waypoint = "/way #2395 50.0 60.0 Test location",
        },
    }

    local detailText = mapWindow:BuildDetailsText()
    assertTrue(detailText:find("Locations:", 1, true) ~= nil, "map details retain structured locations")
    assertTrue(detailText:find("Waypoints:", 1, true) == nil, "map details omit waypoint heading")
    assertTrue(detailText:find("/way", 1, true) == nil, "map details omit raw waypoint commands")

    mapWindow.hasCriteriaPins = true
    detailText = mapWindow:BuildDetailsText()
    assertTrue(detailText:find("/way", 1, true) == nil, "criteria map details omit raw waypoint commands")
end)

test("collection previews omit raw waypoint commands", function()
    local entry
    for _, candidate in ipairs(TDP.PatchCatalog:GetEntries("12.1", "mounts")) do
        if candidate.name == "Topaz Skyfang" then
            entry = candidate
            break
        end
    end
    assertTrue(type(entry) == "table", "Topaz Skyfang collection entry")

    local row = {
        collectionType = "mounts",
        patchKey = "12.1",
        entry = entry,
    }
    local explorerText = TDP.CollectionExplorerWindow:New():GetRowNotes(row)
    local favoritesText = TDP.FavoritesWindow:New():GetRowNotes(row)

    assertTrue(explorerText:find("How to get:", 1, true) ~= nil, "Explorer keeps acquisition text")
    assertTrue(explorerText:find("/way", 1, true) == nil, "Explorer omits raw waypoint commands")
    assertTrue(favoritesText:find("How to get:", 1, true) ~= nil, "Favorites keeps acquisition text")
    assertTrue(favoritesText:find("/way", 1, true) == nil, "Favorites omits raw waypoint commands")
end)

test("collection explorer expansion selection scopes patch options", function()
    local previousWipe = wipe
    wipe = function(values)
        for key in pairs(values) do
            values[key] = nil
        end
    end

    local window = TDP.CollectionExplorerWindow:New()
    assertEqual(window:GetExpansionLabel("9"), "Shadowlands (9)", "Shadowlands expansion label")
    assertEqual(window:GetPatchLabel("all"), "All Patches", "all-patches label")

    window:SetSelectedExpansion("9")
    local patchOptions = window:GetPatchOptions()
    assertEqual(patchOptions[1], "all", "all-patches option comes first")
    assertEqual(patchOptions[2], "9.1", "Shadowlands patch options start at the first catalog patch")
    assertEqual(patchOptions[#patchOptions], "9.2.7", "Shadowlands patch options end at the last catalog patch")
    for index = 2, #patchOptions do
        assertEqual(window:GetExpansionForPatch(patchOptions[index]), "9", "Shadowlands options exclude other expansions")
    end

    assertEqual(window.selectedPatch, "all", "changing expansions selects all patches")
    local selectedPatchKeys = window:GetSelectedPatchKeys()
    assertEqual(#selectedPatchKeys, #patchOptions - 1, "all patches includes every patch in the selected expansion")

    window.selectedCollectionType = "mounts"
    window.selectedStatus = "all"
    local expectedMounts = 0
    for _, patchKey in ipairs(selectedPatchKeys) do
        expectedMounts = expectedMounts + #TDP.PatchCatalog:GetEntries(patchKey, "mounts")
    end
    local totalCount = window:BuildVisibleRows()
    assertEqual(totalCount, expectedMounts, "all patches aggregates the selected expansion")
    assertEqual(#window.visibleRows, expectedMounts, "all-patches rows include the full expansion")
    for _, row in ipairs(window.visibleRows) do
        assertEqual(window:GetExpansionForPatch(row.patchKey), "9", "aggregated rows retain their source patch")
    end

    window.selectedPatch = "9.2"
    selectedPatchKeys = window:GetSelectedPatchKeys()
    assertEqual(#selectedPatchKeys, 1, "single patch selection returns one patch")
    assertEqual(selectedPatchKeys[1], "9.2", "single patch selection is retained")
    totalCount = window:BuildVisibleRows()
    assertEqual(totalCount, #TDP.PatchCatalog:GetEntries("9.2", "mounts"), "single patch selection limits visible rows")

    assertEqual(window:SetSelectedExpansion("13"), false, "unknown expansions are rejected")
    assertEqual(window.selectedExpansion, "9", "rejected expansion does not change selection")

    wipe = previousWipe
end)

test("cosmetic rows support control-click dress-up", function()
    local previousItemApi = C_Item
    local previousControlKeyDown = IsControlKeyDown
    local previousDressUpItemLink = DressUpItemLink
    local dressedItemLink

    C_Item = {
        GetItemLinkByID = function(itemId)
            return "item:" .. tostring(itemId)
        end,
    }
    IsControlKeyDown = function()
        return true
    end
    DressUpItemLink = function(itemLink)
        dressedItemLink = itemLink
    end

    local window = TDP.CollectionExplorerWindow:New()
    local cosmeticRow = {
        collectionType = "cosmetics",
        entry = { itemId = 12345 },
    }

    assertTrue(window:TryDressUpCosmetic(cosmeticRow, "LeftButton"), "control-left-click is handled")
    assertEqual(dressedItemLink, "item:12345", "cosmetic item link is dressed")

    dressedItemLink = nil
    assertEqual(window:TryDressUpCosmetic(cosmeticRow, "RightButton"), false, "right-click is ignored")
    assertNil(dressedItemLink, "right-click does not dress the item")

    assertEqual(window:TryDressUpCosmetic({ collectionType = "toys", entry = { itemId = 12345 } }, "LeftButton"), false, "non-cosmetic rows are ignored")

    C_Item = previousItemApi
    IsControlKeyDown = previousControlKeyDown
    DressUpItemLink = previousDressUpItemLink
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
