local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks

local Database = {}
Database.__index = Database

function Database:New()
    return setmetatable({}, self)
end

function Database:Init()
    if type(TODOPlannerDB) ~= "table" then
        TODOPlannerDB = {}
    end

    TODOPlannerDB = Utils:CopyDefaults(TODOPlannerDB, C.DEFAULT_DB)

    if type(TODOPlannerDB.tasks) ~= "table" then
        TODOPlannerDB.tasks = {}
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        TODOPlannerDB.characters = {}
    end

    local highestId = 0
    local currentBoardKey = Boards:GetPlayerBoardKey()
    local seenCharacters = {}
    local characters = {}

    local function trackCharacter(boardKey)
        boardKey = Boards:NormalizeBoardKey(boardKey)
        if boardKey == C.ALL_BOARD_KEY
            or boardKey == C.ARCHIVED_BOARD_KEY
            or boardKey == C.GLOBAL_BOARD_KEY
            or seenCharacters[boardKey] then
            return
        end

        seenCharacters[boardKey] = true
        characters[#characters + 1] = boardKey
    end

    trackCharacter(currentBoardKey)

    for _, boardKey in ipairs(TODOPlannerDB.characters) do
        trackCharacter(boardKey)
    end

    for _, task in ipairs(TODOPlannerDB.tasks) do
        if type(task.id) == "number" and task.id > highestId then
            highestId = task.id
        end

        task.boardKey = Boards:NormalizeBoardKey(task.boardKey or C.GLOBAL_BOARD_KEY)
        if task.boardKey == C.ALL_BOARD_KEY or task.boardKey == C.ARCHIVED_BOARD_KEY then
            task.boardKey = C.GLOBAL_BOARD_KEY
        end
        task.status = Tasks:NormalizeStatus(task.status)
        task.category = Utils:IndexOf(C.TASK_CATEGORIES, task.category) and task.category or "Other"
        task.title = task.title or "Untitled"
        task.notes = task.notes or ""
        task.createdAt = task.createdAt or time()
        task.updatedAt = task.updatedAt or task.createdAt
        if task.archivedAt ~= nil and type(task.archivedAt) ~= "number" then
            task.archivedAt = nil
        end

        if task.boardKey ~= C.GLOBAL_BOARD_KEY then
            trackCharacter(task.boardKey)
        end

        if type(task.statusByBoard) == "table" then
            for boardKey, status in pairs(task.statusByBoard) do
                local normalizedBoardKey = Boards:NormalizeBoardKey(boardKey)
                if normalizedBoardKey ~= C.ALL_BOARD_KEY
                    and normalizedBoardKey ~= C.ARCHIVED_BOARD_KEY
                    and normalizedBoardKey ~= C.GLOBAL_BOARD_KEY then
                    if task.boardKey == C.GLOBAL_BOARD_KEY and normalizedBoardKey == currentBoardKey then
                        task.status = Tasks:NormalizeStatus(status)
                    end
                    trackCharacter(normalizedBoardKey)
                end
            end
        end
        task.statusByBoard = nil
    end

    Boards:SortCharacterBoards(characters)
    TODOPlannerDB.characters = characters
    Tasks:SortStable(TODOPlannerDB.tasks)

    if type(TODOPlannerDB.nextTaskId) ~= "number" or TODOPlannerDB.nextTaskId <= highestId then
        TODOPlannerDB.nextTaskId = highestId + 1
    end

    if not Utils:IndexOf(C.FILTER_CATEGORIES, TODOPlannerDB.settings.filterCategory) then
        TODOPlannerDB.settings.filterCategory = "All"
    end

    local selectedBoard = TODOPlannerDB.settings.selectedBoard
    if type(selectedBoard) ~= "string" or Utils:Trim(selectedBoard) == "" then
        selectedBoard = currentBoardKey
    else
        selectedBoard = Boards:NormalizeBoardKey(selectedBoard)
    end

    if selectedBoard ~= C.ALL_BOARD_KEY
        and selectedBoard ~= C.ARCHIVED_BOARD_KEY
        and selectedBoard ~= C.GLOBAL_BOARD_KEY
        and not seenCharacters[selectedBoard] then
        selectedBoard = currentBoardKey
    end

    TODOPlannerDB.settings.selectedBoard = selectedBoard
    TODOPlannerDB.version = C.DEFAULT_DB.version
end

TDP.Database = Database:New()
