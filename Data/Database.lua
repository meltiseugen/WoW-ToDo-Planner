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

    if type(TODOPlannerDB.favorites) ~= "table" then
        TODOPlannerDB.favorites = {}
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

    for index, task in ipairs(TODOPlannerDB.tasks) do
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
        if type(task.sortOrder) ~= "number" then
            task.sortOrder = type(task.id) == "number" and task.id or index
        end
        if task.archivedAt ~= nil and type(task.archivedAt) ~= "number" then
            task.archivedAt = nil
        end

        if task.boardKey ~= C.GLOBAL_BOARD_KEY then
            trackCharacter(task.boardKey)
        end

        local normalizedStatusByBoard = nil
        if task.boardKey == C.GLOBAL_BOARD_KEY and type(task.statusByBoard) == "table" then
            for boardKey, status in pairs(task.statusByBoard) do
                local normalizedBoardKey = Boards:NormalizeBoardKey(boardKey)
                if normalizedBoardKey ~= C.ALL_BOARD_KEY
                    and normalizedBoardKey ~= C.ARCHIVED_BOARD_KEY
                    and normalizedBoardKey ~= C.GLOBAL_BOARD_KEY then
                    normalizedStatusByBoard = normalizedStatusByBoard or {}
                    normalizedStatusByBoard[normalizedBoardKey] = Tasks:NormalizeStatus(status)
                    trackCharacter(normalizedBoardKey)
                end
            end
        end
        task.statusByBoard = normalizedStatusByBoard

        local normalizedSortOrderByBoard = nil
        if task.boardKey == C.GLOBAL_BOARD_KEY and type(task.sortOrderByBoard) == "table" then
            for boardKey, sortOrder in pairs(task.sortOrderByBoard) do
                local normalizedBoardKey = Boards:NormalizeBoardKey(boardKey)
                if normalizedBoardKey ~= C.ALL_BOARD_KEY
                    and normalizedBoardKey ~= C.ARCHIVED_BOARD_KEY
                    and normalizedBoardKey ~= C.GLOBAL_BOARD_KEY
                    and type(sortOrder) == "number" then
                    normalizedSortOrderByBoard = normalizedSortOrderByBoard or {}
                    normalizedSortOrderByBoard[normalizedBoardKey] = sortOrder
                    trackCharacter(normalizedBoardKey)
                end
            end
        end
        task.sortOrderByBoard = normalizedSortOrderByBoard
    end

    local normalizedFavorites = {}
    for key, favorite in pairs(TODOPlannerDB.favorites) do
        if type(favorite) == "table"
            and type(favorite.patchKey) == "string"
            and type(favorite.collectionType) == "string"
            and favorite.entryId ~= nil then
            favorite.key = string.format("%s:%s:%s", favorite.patchKey, favorite.collectionType, tostring(favorite.entryId))
            favorite.addedAt = type(favorite.addedAt) == "number" and favorite.addedAt or time()
            normalizedFavorites[favorite.key] = favorite
        end
    end
    TODOPlannerDB.favorites = normalizedFavorites

    Boards:SortCharacterBoards(characters)
    TODOPlannerDB.characters = characters
    Tasks:SortStable(TODOPlannerDB.tasks)

    if type(TODOPlannerDB.nextTaskId) ~= "number" or TODOPlannerDB.nextTaskId <= highestId then
        TODOPlannerDB.nextTaskId = highestId + 1
    end

    if not Utils:IndexOf(C.FILTER_CATEGORIES, TODOPlannerDB.settings.filterCategory) then
        TODOPlannerDB.settings.filterCategory = "All"
    end

    if type(TODOPlannerDB.settings.useProgressBars) ~= "boolean" then
        TODOPlannerDB.settings.useProgressBars = true
    end

    local function normalizeFramePosition(position)
        position = type(position) == "table" and position or {}
        position.point = type(position.point) == "string" and position.point or "CENTER"
        position.x = tonumber(position.x) or 0
        position.y = tonumber(position.y) or 0
        return position
    end

    TODOPlannerDB.settings.frame = normalizeFramePosition(TODOPlannerDB.settings.frame)
    if type(TODOPlannerDB.settings.framePositions) ~= "table" then
        TODOPlannerDB.settings.framePositions = {}
    else
        for windowKey, position in pairs(TODOPlannerDB.settings.framePositions) do
            if type(windowKey) ~= "string" or type(position) ~= "table" then
                TODOPlannerDB.settings.framePositions[windowKey] = nil
            else
                TODOPlannerDB.settings.framePositions[windowKey] = normalizeFramePosition(position)
            end
        end
    end

    TODOPlannerDB.settings.worldMapPinScale = tonumber(TODOPlannerDB.settings.worldMapPinScale) or 1.6
    if TODOPlannerDB.settings.worldMapPinScale < 0.75 then
        TODOPlannerDB.settings.worldMapPinScale = 0.75
    elseif TODOPlannerDB.settings.worldMapPinScale > 3 then
        TODOPlannerDB.settings.worldMapPinScale = 3
    end

    if type(TODOPlannerDB.settings.collectionHideCollected) ~= "boolean" then
        TODOPlannerDB.settings.collectionHideCollected = true
    end

    if type(TODOPlannerDB.settings.collectionMountSourceFilters) ~= "table" then
        TODOPlannerDB.settings.collectionMountSourceFilters = {}
    else
        for source, enabled in pairs(TODOPlannerDB.settings.collectionMountSourceFilters) do
            if type(source) ~= "string" or enabled ~= true then
                TODOPlannerDB.settings.collectionMountSourceFilters[source] = nil
            end
        end
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
