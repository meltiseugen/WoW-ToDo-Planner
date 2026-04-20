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
        return (a.id or 0) < (b.id or 0)
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

function TaskRepository:SetStatus(task, status)
    status = self:NormalizeStatus(status)
    task.boardKey = self:GetBoardKey(task)
    task.status = status
    task.statusByBoard = nil
    task.updatedAt = time()
end

function TaskRepository:MoveToBoard(task, targetBoardKey)
    local visibleStatus = self:GetStatus(task)

    task.boardKey = Boards:NormalizeBoardKey(targetBoardKey)
    task.status = visibleStatus
    task.statusByBoard = nil
    task.updatedAt = time()

    if task.boardKey ~= C.GLOBAL_BOARD_KEY then
        Boards:EnsureKnownCharacter(task.boardKey)
    end
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
        return (a.id or 0) < (b.id or 0)
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
