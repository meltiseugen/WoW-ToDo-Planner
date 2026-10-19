local _, TDP = ...
local TaskEditWindow = TDP.TaskEditWindow
local C = TDP.Constants
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

function TaskEditWindow:Build()
    local ui = self.ui
    local frame = CreateFrame("Frame", "TODOPlannerTaskEditFrame", UIParent, "BackdropTemplate")
    frame.todoPlannerOwner = self
    for name, method in pairs(TaskEditWindow.FrameMethods) do
        frame[name] = method
    end
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

        local title = Widgets:CreateFontString(frame, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Edit Task")
        frame.windowTitleText = title

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local titleLabel = Widgets:CreateFontString(body, "OVERLAY", "GameFontDisableSmall")
    titleLabel:SetPoint("TOPLEFT", 16, -18)
    titleLabel:SetText("Title")

    local titleEdit = Widgets:CreateEditBox(body, 480, 26)
    titleEdit:SetPoint("TOPLEFT", titleLabel, "BOTTOMLEFT", 0, -6)
    titleEdit:SetPoint("TOPRIGHT", body, "TOPRIGHT", -16, -40)
    titleEdit:SetMaxLetters(120)
    frame.titleEdit = titleEdit

    local categoryLabel = Widgets:CreateFontString(body, "OVERLAY", "GameFontDisableSmall")
    categoryLabel:SetPoint("TOPLEFT", titleEdit, "BOTTOMLEFT", 0, -16)
    categoryLabel:SetText("Category")

    local categoryButton = Widgets:CreateSelectorButton(body, 150, 26, "")
    categoryButton:SetPoint("TOPLEFT", categoryLabel, "BOTTOMLEFT", 0, -6)
    frame.categoryButton = categoryButton

    local statusLabel = Widgets:CreateFontString(body, "OVERLAY", "GameFontDisableSmall")
    statusLabel:SetPoint("TOPLEFT", categoryLabel, "TOPLEFT", 164, 0)
    statusLabel:SetText("Status")

    local statusButton = Widgets:CreateSelectorButton(body, 140, 26, "")
    statusButton:SetPoint("TOPLEFT", statusLabel, "BOTTOMLEFT", 0, -6)
    frame.statusButton = statusButton

    local boardLabel = Widgets:CreateFontString(body, "OVERLAY", "GameFontDisableSmall")
    boardLabel:SetPoint("TOPLEFT", statusLabel, "TOPLEFT", 154, 0)
    boardLabel:SetText("Board")

    local boardButton = Widgets:CreateSelectorButton(body, 170, 26, "")
    boardButton:SetPoint("TOPLEFT", boardLabel, "BOTTOMLEFT", 0, -6)
    boardButton:SetPoint("RIGHT", body, "RIGHT", -16, 0)
    frame.boardButton = boardButton

    local descriptionLabel = Widgets:CreateFontString(body, "OVERLAY", "GameFontDisableSmall")
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
    Widgets:ApplyTextColor(descriptionEdit, "text")
    descriptionScroll:SetScrollChild(descriptionEdit)
    frame.descriptionEdit = descriptionEdit

    local function syncDescriptionLayout()
        frame:SyncDescriptionLayout()
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
