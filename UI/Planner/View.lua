local _, TDP = ...
local MainWindow = TDP.MainWindow
local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

function MainWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(1100, 660)
    frame:SetResizable(true)
    if frame.SetResizeBounds then
        frame:SetResizeBounds(1000, 580, 1500, 920)
    elseif frame.SetMinResize then
        frame:SetMinResize(1000, 580)
        if frame.SetMaxResize then
            frame:SetMaxResize(1500, 920)
        end
    end
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "planner")
    end)
    Widgets:RegisterTopLevelWindow(frame)

    Widgets:ApplyFramePosition(frame, "planner")

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "TODO Planner")

        local subtitle = Widgets:CreateFontString(frame.headerBar, "OVERLAY", "GameFontHighlightSmall", "titleText")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Separate Global and character task boards")
        self.subtitle = subtitle

        body = CreateFrame("Frame", nil, frame)
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        Theme:RegisterSpecialFrame("TODOPlannerMainFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = Widgets:CreateFontString(frame, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("TODO Planner")

        local subtitle = Widgets:CreateFontString(frame, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        subtitle:SetText("Separate Global and character task boards")
        self.subtitle = subtitle

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local toolbar = CreateFrame("Frame", nil, body)
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(84)

    local boardButton = Widgets:CreateSelectorButton(toolbar, 270, 24, "")
    boardButton:SetPoint("TOPLEFT", 12, -12)

    local filterButton = Widgets:CreateSelectorButton(toolbar, 180, 24, "")
    filterButton:SetPoint("LEFT", boardButton, "RIGHT", 8, 0)

    local createBoardButton = Widgets:CreateButton(toolbar, 94, 24, "New Board", "neutral")

    local deleteBoardButton = Widgets:CreateButton(toolbar, 104, 24, "Delete Board", "danger")
    deleteBoardButton:SetPoint("BOTTOMRIGHT", toolbar, "BOTTOMRIGHT", -12, 12)
    createBoardButton:SetPoint("RIGHT", deleteBoardButton, "LEFT", -8, 0)

    local optionsButton = Widgets:CreateButton(toolbar, 96, 24, "Options", "neutral")
    optionsButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -12)

    local navigationButtons = Widgets:CreateWindowNavigation(frame.headerBar or toolbar, "planner", self, {
        centered = frame.headerBar ~= nil,
        anchorTo = frame.headerBar and nil or optionsButton,
    })

    local inputTitle = Widgets:CreateEditBox(toolbar, 360, 24)
    inputTitle:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -48)
    inputTitle:SetMaxLetters(120)

    local titleLabel = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall")
    titleLabel:SetPoint("BOTTOMLEFT", inputTitle, "TOPLEFT", 4, 4)
    titleLabel:SetText("Task Name")

    local saveButton = Widgets:CreateButton(toolbar, 36, 24, "+", "primary")
    saveButton:SetPoint("LEFT", inputTitle, "RIGHT", 8, 0)

    local detailedButton = Widgets:CreateButton(toolbar, 132, 24, "Create Detailed", "neutral")
    detailedButton:SetPoint("LEFT", saveButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.toolbar = toolbar
    self.boardButton = boardButton
    self.filterButton = filterButton
    self.createBoardButton = createBoardButton
    self.deleteBoardButton = deleteBoardButton
    self.collectionsButton = navigationButtons.collections
    self.favoritesButton = navigationButtons.favorites
    self.homeButton = navigationButtons.home
    self.optionsButton = optionsButton
    self.inputTitle = inputTitle
    self.saveButton = saveButton
    self.detailedButton = detailedButton

    self.columns = {
        TODO = self:CreateColumn(body, "TODO", 12),
        DOING = self:CreateColumn(body, "DOING", 361),
        DONE = self:CreateColumn(body, "DONE", 710),
    }
    self:LayoutColumns()

    frame:SetScript("OnSizeChanged", function()
        self:LayoutColumns()
        if frame:IsShown() then
            self:Render()
        end
    end)
    frame:SetScript("OnHide", function()
        self:HideChildWindows()
    end)

    local resizeButton = CreateFrame("Button", nil, frame)
    resizeButton:SetSize(18, 18)
    resizeButton:SetPoint("BOTTOMRIGHT", -5, 5)
    resizeButton:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
    resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    resizeButton:SetScript("OnMouseDown", function()
        frame:StartSizing("BOTTOMRIGHT")
    end)
    resizeButton:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
    end)
    self.resizeButton = resizeButton

    boardButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, Boards:GetBoardOptions(), self:GetSelectedBoardKey(), function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(boardKey)
            TODOPlannerDB.settings.selectedBoard = boardKey
            self:ResetEditor()
            self:Render()
        end)
    end)

    filterButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, C.FILTER_CATEGORIES, TODOPlannerDB.settings.filterCategory or "All", nil, function(category)
            TODOPlannerDB.settings.filterCategory = category
            self:Render()
        end)
    end)

    createBoardButton:SetScript("OnClick", function()
        self:OpenCreateBoardDialog()
    end)

    deleteBoardButton:SetScript("OnClick", function()
        self:ConfirmDeleteSelectedBoard()
    end)

    optionsButton:SetScript("OnClick", function()
        self:OpenOptions()
    end)

    saveButton:SetScript("OnClick", function()
        local titleText = Utils:Trim(inputTitle:GetText())
        if titleText == "" then
            Utils:Msg("Task title is required.", "warnings")
            return
        end

        Tasks:CreateOnSelectedBoard({
            title = titleText,
            notes = "",
            category = "General",
            status = "TODO",
        })

        Tasks:SortStable(TODOPlannerDB.tasks)
        self:ResetEditor()
        self:Render()
    end)

    detailedButton:SetScript("OnClick", function()
        self:OpenTaskCreate({
            title = Utils:Trim(inputTitle:GetText()),
            notes = "",
        })
    end)

    inputTitle:SetScript("OnEnterPressed", function()
        saveButton:Click()
    end)

    self:ResetEditor()
    frame:Hide()

    return self
end
