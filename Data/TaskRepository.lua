local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards

local TaskRepository = {}
TaskRepository.__index = TaskRepository

function TaskRepository:New()
    return setmetatable({}, self)
end

function TaskRepository:NormalizeStatus(status)
    if Utils:IndexOf(C.STATUS_ORDER, status) then
        return status
    end
    return "TODO"
end

function TaskRepository:GetStatusIndex(status)
    return Utils:IndexOf(C.STATUS_ORDER, self:NormalizeStatus(status)) or 1
end

function TaskRepository:GetSortOrder(task)
    if task and type(task.sortOrder) == "number" then
        return task.sortOrder
    end
    return task and task.id or 0
end

function TaskRepository:CompareTaskOrder(a, b)
    local aOrder = self:GetSortOrder(a)
    local bOrder = self:GetSortOrder(b)
    if aOrder ~= bOrder then
        return aOrder < bOrder
    end
    return (a.id or 0) < (b.id or 0)
end

function TaskRepository:FindById(taskId)
    for index, task in ipairs(TODOPlannerDB.tasks) do
        if task.id == taskId then
            return task, index
        end
    end
    return nil, nil
end

function TaskRepository:MoveStatus(currentStatus, direction)
    local currentIndex
    for idx, status in ipairs(C.STATUS_ORDER) do
        if status == currentStatus then
            currentIndex = idx
            break
        end
    end

    if not currentIndex then
        return currentStatus
    end

    local target = currentIndex + direction
    if target < 1 then
        target = 1
    elseif target > #C.STATUS_ORDER then
        target = #C.STATUS_ORDER
    end

    return C.STATUS_ORDER[target]
end

function TaskRepository:SortStable(tasks)
    table.sort(tasks, function(a, b)
        local aIndex = self:GetStatusIndex(a.status)
        local bIndex = self:GetStatusIndex(b.status)
        if aIndex ~= bIndex then
            return aIndex < bIndex
        end
        return self:CompareTaskOrder(a, b)
    end)
end

function TaskRepository:GetBoardKey(task)
    return Boards:NormalizeBoardKey(task and task.boardKey or C.GLOBAL_BOARD_KEY)
end

function TaskRepository:IsArchived(task)
    return task and task.archivedAt ~= nil
end

function TaskRepository:IsVisibleOnBoard(task, boardKey)
    local taskBoardKey = self:GetBoardKey(task)
    boardKey = Boards:NormalizeBoardKey(boardKey)

    if boardKey == C.ALL_BOARD_KEY or boardKey == C.ARCHIVED_BOARD_KEY then
        return true
    end

    return taskBoardKey == boardKey
end

function TaskRepository:GetStatus(task)
    return self:NormalizeStatus(task and task.status)
end

function TaskRepository:GetNextSortOrder(boardKey, status)
    boardKey = Boards:NormalizeBoardKey(boardKey)
    status = self:NormalizeStatus(status)

    local maxOrder = 0
    for _, task in ipairs(TODOPlannerDB.tasks) do
        if self:GetBoardKey(task) == boardKey and self:GetStatus(task) == status then
            maxOrder = math.max(maxOrder, self:GetSortOrder(task))
        end
    end

    return maxOrder + 1
end

function TaskRepository:MatchesBoardView(task, boardKey)
    boardKey = Boards:NormalizeBoardKey(boardKey)
    local archiveStateMatches = boardKey == C.ARCHIVED_BOARD_KEY and self:IsArchived(task)
        or boardKey ~= C.ARCHIVED_BOARD_KEY and not self:IsArchived(task)

    return archiveStateMatches and self:IsVisibleOnBoard(task, boardKey)
end

function TaskRepository:SetStatus(task, status)
    status = self:NormalizeStatus(status)
    task.boardKey = self:GetBoardKey(task)
    task.statusByBoard = nil
    if self:GetStatus(task) ~= status or type(task.sortOrder) ~= "number" then
        task.sortOrder = self:GetNextSortOrder(task.boardKey, status)
    end
    task.status = status
    task.updatedAt = time()
end

function TaskRepository:MoveToBoard(task, targetBoardKey)
    local visibleStatus = self:GetStatus(task)
    local normalizedTargetBoardKey = Boards:NormalizeBoardKey(targetBoardKey)
    local targetSortOrder = self:GetNextSortOrder(normalizedTargetBoardKey, visibleStatus)

    task.boardKey = normalizedTargetBoardKey
    task.status = visibleStatus
    task.statusByBoard = nil
    task.sortOrder = targetSortOrder
    task.updatedAt = time()

    if task.boardKey ~= C.GLOBAL_BOARD_KEY then
        Boards:EnsureKnownCharacter(task.boardKey)
    end
end

function TaskRepository:MoveRelative(taskId, targetStatus, boardKey, anchorTaskId, placement)
    local task = self:FindById(taskId)
    if not task then
        return false
    end

    boardKey = Boards:NormalizeBoardKey(boardKey)
    targetStatus = self:NormalizeStatus(targetStatus)
    placement = placement == "before" and "before" or placement == "after" and "after" or "end"

    if boardKey ~= C.ALL_BOARD_KEY and boardKey ~= C.ARCHIVED_BOARD_KEY then
        task.boardKey = boardKey
        if boardKey ~= C.GLOBAL_BOARD_KEY then
            Boards:EnsureKnownCharacter(boardKey)
        end
    end

    task.status = targetStatus
    task.statusByBoard = nil
    task.updatedAt = time()

    local ordered = {}
    for _, candidate in ipairs(TODOPlannerDB.tasks) do
        if candidate.id ~= task.id
            and self:GetStatus(candidate) == targetStatus
            and self:MatchesBoardView(candidate, boardKey) then
            ordered[#ordered + 1] = candidate
        end
    end

    table.sort(ordered, function(a, b)
        return self:CompareTaskOrder(a, b)
    end)

    local reordered = {}
    local inserted = false

    if placement == "end" or not anchorTaskId then
        for _, candidate in ipairs(ordered) do
            reordered[#reordered + 1] = candidate
        end
        reordered[#reordered + 1] = task
        inserted = true
    else
        for _, candidate in ipairs(ordered) do
            if not inserted and candidate.id == anchorTaskId and placement == "before" then
                reordered[#reordered + 1] = task
                inserted = true
            end

            reordered[#reordered + 1] = candidate

            if not inserted and candidate.id == anchorTaskId and placement == "after" then
                reordered[#reordered + 1] = task
                inserted = true
            end
        end
    end

    if not inserted then
        reordered[#reordered + 1] = task
    end

    for index, candidate in ipairs(reordered) do
        candidate.sortOrder = index
    end

    self:SortStable(TODOPlannerDB.tasks)
    return true
end

function TaskRepository:Create(fields)
    fields = fields or {}

    local targetBoardKey = Boards:NormalizeBoardKey(fields.boardKey or Boards:GetPlayerBoardKey())
    if targetBoardKey == C.ALL_BOARD_KEY or targetBoardKey == C.ARCHIVED_BOARD_KEY then
        targetBoardKey = Boards:GetPlayerBoardKey()
    end

    if targetBoardKey ~= C.GLOBAL_BOARD_KEY then
        Boards:EnsureKnownCharacter(targetBoardKey)
    end

    local now = time()
    local title = Utils:Trim(fields.title)
    if title == "" then
        title = "Untitled"
    end

    local newTask = {
        id = TODOPlannerDB.nextTaskId,
        title = title,
        notes = fields.notes or "",
        category = Utils:IndexOf(C.TASK_CATEGORIES, fields.category) and fields.category or "General",
        status = self:NormalizeStatus(fields.status),
        boardKey = targetBoardKey,
        sortOrder = self:GetNextSortOrder(targetBoardKey, fields.status),
        createdAt = now,
        updatedAt = now,
    }

    if fields.sourceType then
        newTask.sourceType = fields.sourceType
    end
    if fields.sourceId then
        newTask.sourceId = fields.sourceId
    end

    TODOPlannerDB.nextTaskId = TODOPlannerDB.nextTaskId + 1
    table.insert(TODOPlannerDB.tasks, newTask)
    TODOPlannerDB.settings.selectedBoard = targetBoardKey
    self:SortStable(TODOPlannerDB.tasks)

    return newTask
end

function TaskRepository:CreateOnCurrentCharacterBoard(fields)
    fields = fields or {}
    fields.boardKey = Boards:GetPlayerBoardKey()
    return self:Create(fields)
end

function TaskRepository:GetSelectedCreationBoardKey()
    local selectedBoard = Boards:NormalizeBoardKey(TODOPlannerDB.settings and TODOPlannerDB.settings.selectedBoard)
    if selectedBoard == C.ALL_BOARD_KEY or selectedBoard == C.ARCHIVED_BOARD_KEY then
        return Boards:GetPlayerBoardKey()
    end

    return selectedBoard
end

function TaskRepository:CreateOnSelectedBoard(fields)
    fields = fields or {}
    fields.boardKey = self:GetSelectedCreationBoardKey()
    return self:Create(fields)
end

function TaskRepository:FindBySource(sourceType, sourceId, boardKey)
    boardKey = Boards:NormalizeBoardKey(boardKey or Boards:GetPlayerBoardKey())

    for _, task in ipairs(TODOPlannerDB.tasks) do
        if task.sourceType == sourceType
            and tostring(task.sourceId or "") == tostring(sourceId or "")
            and self:GetBoardKey(task) == boardKey
            and not self:IsArchived(task) then
            return task
        end
    end

    return nil
end

function TaskRepository:GetForStatus(status, boardKey)
    local filtered = {}
    local filterCategory = TODOPlannerDB.settings.filterCategory or "All"
    boardKey = Boards:NormalizeBoardKey(boardKey)

    for _, task in ipairs(TODOPlannerDB.tasks) do
        local archiveStateMatches = boardKey == C.ARCHIVED_BOARD_KEY and self:IsArchived(task)
            or boardKey ~= C.ARCHIVED_BOARD_KEY and not self:IsArchived(task)
        if archiveStateMatches
            and self:IsVisibleOnBoard(task, boardKey)
            and self:GetStatus(task) == status then
            if filterCategory == "All" or task.category == filterCategory then
                filtered[#filtered + 1] = task
            end
        end
    end

    table.sort(filtered, function(a, b)
        return self:CompareTaskOrder(a, b)
    end)

    return filtered
end

function TaskRepository:FormatStatus(status)
    status = self:NormalizeStatus(status)
    return C.STATUS_LABELS[status] or status
end

function TaskRepository:Archive(task)
    if not task then
        return
    end

    task.archivedAt = time()
    task.updatedAt = task.archivedAt
end

function TaskRepository:Delete(taskId)
    local _, index = self:FindById(taskId)
    if index then
        table.remove(TODOPlannerDB.tasks, index)
        return true
    end
    return false
end

TDP.Tasks = TaskRepository:New()
