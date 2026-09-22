local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

local TaskEditWindow = {}
TaskEditWindow.__index = TaskEditWindow

function TaskEditWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
    }, self)
end

function TaskEditWindow:Build()
    local ui = self.ui
    local frame = CreateFrame("Frame", "TODOPlannerTaskEditFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(620, 520)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    Widgets:RegisterTopLevelWindow(frame)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Edit Task")
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerTaskEditFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Edit Task")
        frame.windowTitleText = title

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local titleLabel = body:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    titleLabel:SetPoint("TOPLEFT", 16, -18)
    titleLabel:SetText("Title")

    local titleEdit = Widgets:CreateEditBox(body, 480, 26)
    titleEdit:SetPoint("TOPLEFT", titleLabel, "BOTTOMLEFT", 0, -6)
    titleEdit:SetPoint("TOPRIGHT", body, "TOPRIGHT", -16, -40)
    titleEdit:SetMaxLetters(120)
    frame.titleEdit = titleEdit

    local categoryLabel = body:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    categoryLabel:SetPoint("TOPLEFT", titleEdit, "BOTTOMLEFT", 0, -16)
    categoryLabel:SetText("Category")

    local categoryButton = Widgets:CreateButton(body, 150, 26, "", "neutral")
    categoryButton:SetPoint("TOPLEFT", categoryLabel, "BOTTOMLEFT", 0, -6)
    frame.categoryButton = categoryButton

    local statusLabel = body:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    statusLabel:SetPoint("TOPLEFT", categoryLabel, "TOPLEFT", 164, 0)
    statusLabel:SetText("Status")

    local statusButton = Widgets:CreateButton(body, 140, 26, "", "neutral")
    statusButton:SetPoint("TOPLEFT", statusLabel, "BOTTOMLEFT", 0, -6)
    frame.statusButton = statusButton

    local boardLabel = body:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    boardLabel:SetPoint("TOPLEFT", statusLabel, "TOPLEFT", 154, 0)
    boardLabel:SetText("Board")

    local boardButton = Widgets:CreateButton(body, 170, 26, "", "neutral")
    boardButton:SetPoint("TOPLEFT", boardLabel, "BOTTOMLEFT", 0, -6)
    boardButton:SetPoint("RIGHT", body, "RIGHT", -16, 0)
    frame.boardButton = boardButton

    local descriptionLabel = body:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    descriptionLabel:SetPoint("TOPLEFT", categoryButton, "BOTTOMLEFT", 0, -18)
    descriptionLabel:SetText("Description")

    local descriptionPanel = Widgets:CreatePanel(body, "input", "inputBorder")
    descriptionPanel:SetPoint("TOPLEFT", descriptionLabel, "BOTTOMLEFT", 0, -6)
    descriptionPanel:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -16, 56)
    descriptionPanel:EnableMouse(true)
    frame.descriptionPanel = descriptionPanel

    local descriptionScroll = CreateFrame("ScrollFrame", nil, descriptionPanel, "UIPanelScrollFrameTemplate")
    descriptionScroll:SetPoint("TOPLEFT", 8, -8)
    descriptionScroll:SetPoint("BOTTOMRIGHT", -28, 8)
    frame.descriptionScroll = descriptionScroll

    local descriptionEdit = CreateFrame("EditBox", nil, descriptionScroll)
    descriptionEdit:SetMultiLine(true)
    descriptionEdit:SetAutoFocus(false)
    descriptionEdit:SetMaxLetters(4000)
    descriptionEdit:SetTextInsets(0, 0, 0, 0)
    descriptionEdit:SetJustifyH("LEFT")
    descriptionEdit:SetJustifyV("TOP")
    if GameFontHighlightSmall then
        descriptionEdit:SetFontObject(GameFontHighlightSmall)
    end
    descriptionScroll:SetScrollChild(descriptionEdit)
    frame.descriptionEdit = descriptionEdit

    local function syncDescriptionLayout()
        local width = descriptionScroll:GetWidth()
        if not width or width < 200 then
            width = 456
        end
        local height = descriptionScroll:GetHeight()
        if not height or height < 100 then
            height = 240
        end
        local lineCount = descriptionEdit.GetNumLines and descriptionEdit:GetNumLines() or 1
        descriptionEdit:SetWidth(width)
        descriptionEdit:SetHeight(math.max(height, (lineCount * 16) + 16))
    end

    descriptionPanel:SetScript("OnMouseDown", function()
        descriptionEdit:SetFocus()
    end)
    descriptionEdit:SetScript("OnEscapePressed", function(target)
        target:ClearFocus()
    end)
    descriptionEdit:SetScript("OnTextChanged", syncDescriptionLayout)
    frame:SetScript("OnSizeChanged", syncDescriptionLayout)
    frame:SetScript("OnHide", function()
        Widgets:HideDropdownMenus()
    end)

    local cancelButton = Widgets:CreateButton(body, 82, 24, "Cancel", "neutral")
    cancelButton:SetPoint("BOTTOMRIGHT", -16, 18)
    cancelButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local saveButton = Widgets:CreateButton(body, 92, 24, "Save", "primary")
    saveButton:SetPoint("RIGHT", cancelButton, "LEFT", -8, 0)
    saveButton:SetScript("OnClick", function()
        frame:SaveTask()
    end)
    frame.saveButton = saveButton

    function frame:GetBoardOptions()
        local options = { C.GLOBAL_BOARD_KEY }
        for _, boardKey in ipairs(Boards:GetCharacterBoardOptions()) do
            options[#options + 1] = boardKey
        end
        return options
    end

    function frame:UpdateFieldButtons()
        self.categoryButton:SetText(self.selectedCategory or "General")
        self.statusButton:SetText(Tasks:FormatStatus(self.selectedStatus))
        self.boardButton:SetText(Boards:GetDisplayName(self.selectedBoardKey))
    end

    categoryButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, C.TASK_CATEGORIES, frame.selectedCategory, nil, function(category)
            frame.selectedCategory = category
            frame:UpdateFieldButtons()
        end)
    end)

    statusButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, C.STATUS_ORDER, frame.selectedStatus, function(status)
            return Tasks:FormatStatus(status)
        end, function(status)
            frame.selectedStatus = status
            frame:UpdateFieldButtons()
        end)
    end)

    boardButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, frame:GetBoardOptions(), frame.selectedBoardKey, function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(boardKey)
            frame.selectedBoardKey = boardKey
            frame:UpdateFieldButtons()
        end)
    end)

    function frame:SaveTask()
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

    function frame:OpenTask(task)
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
        syncDescriptionLayout()

        self:ClearAllPoints()
        local anchor = ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown()
            and ui.detailWindow.frame
            or ui.frame
        self:SetPoint("CENTER", anchor, "CENTER", 0, 0)
        self:Show()
        self.titleEdit:SetFocus()

        Widgets:BringToFront(self, anchor)
    end

    function frame:OpenCreate(fields)
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
        syncDescriptionLayout()

        self:ClearAllPoints()
        self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
        self:Show()
        self.titleEdit:SetFocus()

        Widgets:BringToFront(self, ui.frame)
    end

    frame:Hide()
    self.frame = frame
    return frame
end

function TaskEditWindow:Open(task)
    if not self.frame then
        self:Build()
    end

    self.frame:OpenTask(task)
end

function TaskEditWindow:OpenCreate(fields)
    if not self.frame then
        self:Build()
    end

    self.frame:OpenCreate(fields)
end

TDP.TaskEditWindow = TaskEditWindow
