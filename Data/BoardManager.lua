local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils

local BoardManager = {}
BoardManager.__index = BoardManager

function BoardManager:New()
    return setmetatable({}, self)
end

function BoardManager:GetPlayerBoardKey()
    local name, realm = UnitFullName("player")
    if not name or name == "" then
        name = UnitName("player") or "Unknown"
    end

    if not realm or realm == "" then
        realm = GetRealmName() or ""
    end

    realm = Utils:Trim(realm)
    if realm ~= "" then
        return name .. " - " .. realm
    end

    return name
end

function BoardManager:NormalizeBoardKey(boardKey)
    if type(boardKey) ~= "string" then
        return C.GLOBAL_BOARD_KEY
    end

    boardKey = Utils:Trim(boardKey)
    if boardKey == "" then
        return C.GLOBAL_BOARD_KEY
    end

    if boardKey:lower() == "all" then
        return C.ALL_BOARD_KEY
    end

    if boardKey:lower() == "global" then
        return C.GLOBAL_BOARD_KEY
    end

    if boardKey:lower() == "archive"
        or boardKey:lower() == "archives"
        or boardKey:lower() == "archived" then
        return C.ARCHIVED_BOARD_KEY
    end

    return boardKey
end

function BoardManager:IsSpecialBoard(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    return boardKey == C.ALL_BOARD_KEY
        or boardKey == C.ARCHIVED_BOARD_KEY
        or boardKey == C.GLOBAL_BOARD_KEY
end

function BoardManager:GetDisplayName(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    if boardKey == C.ALL_BOARD_KEY then
        return "All"
    end
    if boardKey == C.ARCHIVED_BOARD_KEY then
        return "Archived"
    end
    if boardKey == C.GLOBAL_BOARD_KEY then
        return "Global"
    end
    return boardKey
end

function BoardManager:RemoveKnownBoard(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    if type(TODOPlannerDB.characters) ~= "table" then
        return false
    end

    for index, knownBoardKey in ipairs(TODOPlannerDB.characters) do
        if self:NormalizeBoardKey(knownBoardKey) == boardKey then
            table.remove(TODOPlannerDB.characters, index)
            return true
        end
    end

    return false
end

function BoardManager:SortCharacterBoards(characters)
    local currentBoardKey = self:GetPlayerBoardKey()

    table.sort(characters, function(a, b)
        if a == currentBoardKey and b ~= currentBoardKey then
            return true
        end
        if b == currentBoardKey and a ~= currentBoardKey then
            return false
        end
        return a < b
    end)
end

function BoardManager:IsKnownBoard(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    if boardKey == C.ALL_BOARD_KEY or boardKey == C.ARCHIVED_BOARD_KEY or boardKey == C.GLOBAL_BOARD_KEY then
        return true
    end

    if type(TODOPlannerDB) ~= "table" or type(TODOPlannerDB.characters) ~= "table" then
        return false
    end

    return Utils:IndexOf(TODOPlannerDB.characters, boardKey) ~= nil
end

function BoardManager:EnsureKnownCharacter(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    if self:IsSpecialBoard(boardKey) then
        return
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        TODOPlannerDB.characters = {}
    end

    if not Utils:IndexOf(TODOPlannerDB.characters, boardKey) then
        table.insert(TODOPlannerDB.characters, boardKey)
        self:SortCharacterBoards(TODOPlannerDB.characters)
    end
end

function BoardManager:CreateBoard(boardName)
    if Utils:Trim(boardName) == "" then
        return nil, "Board name is required."
    end

    local boardKey = self:NormalizeBoardKey(boardName)
    if self:IsSpecialBoard(boardKey) then
        return nil, "That board name is reserved."
    end
    if self:IsKnownBoard(boardKey) then
        return nil, "That board already exists."
    end

    self:EnsureKnownCharacter(boardKey)
    return boardKey, nil
end

function BoardManager:CanDeleteBoard(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    if self:IsSpecialBoard(boardKey) then
        return false, "Built-in boards cannot be deleted."
    end
    if boardKey == self:GetPlayerBoardKey() then
        return false, "The current character board cannot be deleted."
    end
    if not self:IsKnownBoard(boardKey) then
        return false, "That board does not exist."
    end

    return true, nil
end

function BoardManager:CountBoardTasks(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    local count = 0

    if type(TODOPlannerDB.tasks) ~= "table" then
        return count
    end

    for _, task in ipairs(TODOPlannerDB.tasks) do
        if self:NormalizeBoardKey(task.boardKey) == boardKey then
            count = count + 1
        end
    end

    return count
end

function BoardManager:DeleteBoard(boardKey)
    boardKey = self:NormalizeBoardKey(boardKey)
    local canDelete, reason = self:CanDeleteBoard(boardKey)
    if not canDelete then
        return false, reason, 0
    end

    local movedTasks = 0
    if type(TODOPlannerDB.tasks) == "table" then
        for _, task in ipairs(TODOPlannerDB.tasks) do
            if self:NormalizeBoardKey(task.boardKey) == boardKey then
                task.boardKey = C.GLOBAL_BOARD_KEY
                task.updatedAt = time()
                movedTasks = movedTasks + 1
            end
        end
    end

    self:RemoveKnownBoard(boardKey)

    if self:NormalizeBoardKey(TODOPlannerDB.settings.selectedBoard) == boardKey then
        TODOPlannerDB.settings.selectedBoard = C.GLOBAL_BOARD_KEY
    end

    return true, nil, movedTasks
end

function BoardManager:GetBoardOptions()
    local boards = { C.ALL_BOARD_KEY, C.GLOBAL_BOARD_KEY, C.ARCHIVED_BOARD_KEY }
    local characters = {}
    local seen = {
        [C.ALL_BOARD_KEY] = true,
        [C.ARCHIVED_BOARD_KEY] = true,
        [C.GLOBAL_BOARD_KEY] = true,
    }

    if type(TODOPlannerDB.characters) == "table" then
        for _, boardKey in ipairs(TODOPlannerDB.characters) do
            boardKey = self:NormalizeBoardKey(boardKey)
            if boardKey ~= C.ALL_BOARD_KEY
                and boardKey ~= C.ARCHIVED_BOARD_KEY
                and boardKey ~= C.GLOBAL_BOARD_KEY
                and not seen[boardKey] then
                seen[boardKey] = true
                characters[#characters + 1] = boardKey
            end
        end
    end

    self:SortCharacterBoards(characters)
    for _, boardKey in ipairs(characters) do
        boards[#boards + 1] = boardKey
    end

    return boards
end

function BoardManager:GetCharacterBoardOptions()
    local boards = {}
    for _, boardKey in ipairs(self:GetBoardOptions()) do
        boardKey = self:NormalizeBoardKey(boardKey)
        if boardKey ~= C.ALL_BOARD_KEY and boardKey ~= C.ARCHIVED_BOARD_KEY and boardKey ~= C.GLOBAL_BOARD_KEY then
            boards[#boards + 1] = boardKey
        end
    end
    return boards
end

TDP.Boards = BoardManager:New()
