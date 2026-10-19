local _, TDP = ...
local TaskEditWindow = TDP.TaskEditWindow
local FrameMethods = TaskEditWindow.FrameMethods
local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

function FrameMethods:GetBoardOptions()
    local options = { C.GLOBAL_BOARD_KEY }
    for _, boardKey in ipairs(Boards:GetCharacterBoardOptions()) do
        options[#options + 1] = boardKey
    end
    return options
end

function FrameMethods:UpdateFieldButtons()
    self.categoryButton:SetText(self.selectedCategory or "General")
    self.statusButton:SetText(Tasks:FormatStatus(self.selectedStatus))
    self.boardButton:SetText(Boards:GetDisplayName(self.selectedBoardKey))
end

function FrameMethods:SaveTask()
    local ui = self.todoPlannerOwner.ui
    local titleText = Utils:Trim(self.titleEdit:GetText())
    if titleText == "" then
        Utils:Msg("Task title is required.")
        self.titleEdit:SetFocus()
        return
    end

    local category = Utils:IndexOf(C.TASK_CATEGORIES, self.selectedCategory) and self.selectedCategory or "General"
    local status = Tasks:NormalizeStatus(self.selectedStatus)
    local targetBoardKey = Boards:ResolveKnownBoardKey(self.selectedBoardKey)
    if targetBoardKey == C.ALL_BOARD_KEY or targetBoardKey == C.ARCHIVED_BOARD_KEY then
        Utils:Msg("Choose Global or a character board.")
        return
    end

    local existingTask = self.mode ~= "create" and Tasks:FindById(self.taskId) or nil
    if self.mode ~= "create" and not existingTask then
        self:Hide()
        return
    end

    local function persistTask()
        local task
        if self.mode == "create" then
            task = Tasks:Create({
                title = titleText,
                notes = self.descriptionEdit:GetText() or "",
                category = category,
                status = status,
                boardKey = targetBoardKey,
            })
            ui:ResetEditor()
        else
            task = Tasks:FindById(self.taskId)
            if not task then
                self:Hide()
                return
            end

            local sourceBoardKey = ui:GetSelectedBoardKey()
            local currentBoardKey = Tasks:GetBoardKey(task)
            local updated, errorText = Tasks:Update(task, {
                title = titleText,
                notes = self.descriptionEdit:GetText() or "",
                category = category,
                status = status,
                boardKey = targetBoardKey,
            }, sourceBoardKey)
            if not updated then
                Utils:Msg(errorText or "Could not update that task.")
                return
            end
            if currentBoardKey ~= targetBoardKey then
                TODOPlannerDB.settings.selectedBoard = targetBoardKey
            end
        end

        Tasks:SortStable(TODOPlannerDB.tasks)
        ui:Render()

        if self.mode ~= "create" and ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown() then
            ui.detailWindow.frame:UpdateTask(task)
        end

        self:Hide()
    end

    if existingTask
        and Tasks:IsGlobalTask(existingTask)
        and targetBoardKey ~= C.GLOBAL_BOARD_KEY then
        StaticPopupDialogs["TODO_PLANNER_EDIT_MOVE_GLOBAL_TASK"] = {
            text = string.format(
                "Move Global task \"%s\" to %s?\nIt will leave the Global board and appear on the selected character board.",
                existingTask.title or "",
                Boards:GetDisplayName(targetBoardKey)
            ),
            button1 = YES,
            button2 = NO,
            OnAccept = persistTask,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("TODO_PLANNER_EDIT_MOVE_GLOBAL_TASK")
        return
    end

    persistTask()
end

function FrameMethods:OpenTask(task)
    local ui = self.todoPlannerOwner.ui
    self.mode = "edit"
    self.taskId = task.id
    if self.headerTitleText then
        self.headerTitleText:SetText("Edit Task")
    elseif self.windowTitleText then
        self.windowTitleText:SetText("Edit Task")
    end
    self.saveButton:SetText("Save")
    self.titleEdit:SetText(task.title or "")
    self.descriptionEdit:SetText(task.notes or "")
    self.selectedCategory = task.category or "General"
    self.selectedStatus = Tasks:GetStatus(task, ui:GetSelectedBoardKey())
    self.selectedBoardKey = Tasks:GetBoardKey(task)
    self:UpdateFieldButtons()
    self:SyncDescriptionLayout()

    self:ClearAllPoints()
    local anchor = ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown()
        and ui.detailWindow.frame
        or ui.frame
    self:SetPoint("CENTER", anchor, "CENTER", 0, 0)
    self:Show()
    self.titleEdit:SetFocus()

    Widgets:BringToFront(self, anchor)
end

function FrameMethods:OpenCreate(fields)
    local ui = self.todoPlannerOwner.ui
    fields = fields or {}
    self.mode = "create"
    self.taskId = nil
    if self.headerTitleText then
        self.headerTitleText:SetText("Create Task")
    elseif self.windowTitleText then
        self.windowTitleText:SetText("Create Task")
    end
    self.saveButton:SetText("Create")
    self.titleEdit:SetText(fields.title or "")
    self.descriptionEdit:SetText(fields.notes or "")
    self.selectedCategory = Utils:IndexOf(C.TASK_CATEGORIES, fields.category) and fields.category or "General"
    self.selectedStatus = Tasks:NormalizeStatus(fields.status)
    self.selectedBoardKey = Boards:ResolveKnownBoardKey(fields.boardKey or Tasks:GetSelectedCreationBoardKey())
    self:UpdateFieldButtons()
    self:SyncDescriptionLayout()

    self:ClearAllPoints()
    self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
    self:Show()
    self.titleEdit:SetFocus()

    Widgets:BringToFront(self, ui.frame)
end

function FrameMethods:SyncDescriptionLayout()
    local width = self.descriptionScroll:GetWidth()
    if not width or width < 200 then
        width = 456
    end
    local height = self.descriptionScroll:GetHeight()
    if not height or height < 100 then
        height = 240
    end
    local lineCount = self.descriptionEdit.GetNumLines and self.descriptionEdit:GetNumLines() or 1
    self.descriptionEdit:SetSize(width, math.max(height, (lineCount * 16) + 16))
end
