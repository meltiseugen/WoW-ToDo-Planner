local _, TDP = ...
local MainWindow = TDP.MainWindow
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

function MainWindow:ResetEditor()
    self.inputTitle:SetText("")
    self.saveButton:SetText("+")
end

function MainWindow:ConfirmArchiveTask(taskRef)
    if not taskRef then
        return
    end

    local scopeText = Tasks:IsGlobalTask(taskRef)
        and "\nBoard: Global"
        or "\nBoard: " .. Tasks:GetOwnershipLabel(taskRef)

    StaticPopupDialogs["TODO_PLANNER_ARCHIVE_TASK"] = {
        text = "Archive task: \"" .. (taskRef.title or "") .. "\"?" .. scopeText,
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            local task = Tasks:FindById(taskRef.id)
            if not task then
                return
            end

            Tasks:Archive(task)

            if self.detailWindow and self.detailWindow.frame and self.detailWindow.frame.taskId == task.id then
                self.detailWindow.frame:Hide()
            end
            self:Render()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_ARCHIVE_TASK")
end

function MainWindow:ConfirmRestoreTask(taskRef)
    if not taskRef then
        return
    end

    StaticPopupDialogs["TODO_PLANNER_RESTORE_TASK"] = {
        text = "Restore task: \"" .. (taskRef.title or "") .. "\"?\nBoard: " .. Tasks:GetOwnershipLabel(taskRef),
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            local task = Tasks:FindById(taskRef.id)
            if not task then
                return
            end

            Tasks:Unarchive(task)
            Tasks:SortStable(TODOPlannerDB.tasks)
            if self.detailWindow and self.detailWindow.frame and self.detailWindow.frame.taskId == task.id then
                self.detailWindow.frame:Hide()
            end
            self:Render()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_RESTORE_TASK")
end

function MainWindow:HideChildWindows()
    local childWindows = { self.detailWindow, self.editWindow, self.optionsWindow }
    for _, childWindow in ipairs(childWindows) do
        if childWindow and childWindow.frame then
            childWindow.frame:Hide()
        end
    end
    Widgets:HideDropdownMenus()
end

function MainWindow:OpenTaskDetail(task)
    if Achievements and Achievements:AutoCompleteTask(task) then
        Tasks:SortStable(TODOPlannerDB.tasks)
        self:Render()
        task = Tasks:FindById(task.id)
    end

    if not self.detailWindow then
        self.detailWindow = TDP.TaskDetailWindow:New(self)
    end

    self.detailWindow:Open(task)
end

function MainWindow:OpenTaskEdit(task)
    if not self.editWindow then
        self.editWindow = TDP.TaskEditWindow:New(self)
    end

    self.editWindow:Open(task)
end

function MainWindow:OpenTaskCreate(fields)
    if not self.editWindow then
        self.editWindow = TDP.TaskEditWindow:New(self)
    end

    self.editWindow:OpenCreate(fields)
end

function MainWindow:OpenOptions()
    if not self.optionsWindow then
        self.optionsWindow = TDP.OptionsWindow:New(self)
    end

    self.optionsWindow:Open()
end
