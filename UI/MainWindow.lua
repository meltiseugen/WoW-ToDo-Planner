local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

local MainWindow = {}
MainWindow.__index = MainWindow

function MainWindow:New()
    local instance = {
        frame = nil,
        body = nil,
        toolbar = nil,
        boardButton = nil,
        filterButton = nil,
        inputTitle = nil,
        saveButton = nil,
        detailedButton = nil,
        columns = {},
        editingTaskId = nil,
        detailWindow = nil,
    }
    return setmetatable(instance, self)
end

function MainWindow:ResetEditor()
    self.editingTaskId = nil
    self.inputTitle:SetText("")
    self.saveButton:SetText("Add Task")
end

function MainWindow:LoadEditor(task)
    self.editingTaskId = task.id
    self.inputTitle:SetText(task.title or "")
    self.saveButton:SetText("Save Task")
end

function MainWindow:ConfirmArchiveTask(taskRef)
    if not taskRef then
        return
    end

    StaticPopupDialogs["TODO_PLANNER_ARCHIVE_TASK"] = {
        text = "Archive task: \"" .. (taskRef.title or "") .. "\"?",
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
            if self.editingTaskId == task.id then
                self:ResetEditor()
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

function MainWindow:GetSelectedBoardKey()
    local boardKey = Boards:NormalizeBoardKey(TODOPlannerDB.settings.selectedBoard)
    if boardKey ~= C.GLOBAL_BOARD_KEY and not Boards:IsKnownBoard(boardKey) then
        boardKey = Boards:GetPlayerBoardKey()
        Boards:EnsureKnownCharacter(boardKey)
        TODOPlannerDB.settings.selectedBoard = boardKey
    end
    return boardKey
end

function MainWindow:OpenTaskDetail(task)
    if not self.detailWindow then
        self.detailWindow = TDP.TaskDetailWindow:New(self)
    end

    self.detailWindow:Open(task)
end

function MainWindow:CreateColumn(parent, status, offsetX)
    local column = Widgets:CreatePanel(parent, "panel", "goldBorder")
    column:SetSize(330, 456)
    column:SetPoint("TOPLEFT", offsetX, -108)
    column.topAccent = Widgets:AddGoldTopAccent(column, 3, 0.30)

    local title = column:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 14, -12)
    title:SetJustifyH("LEFT")
    title:SetText(C.STATUS_LABELS[status])

    local count = column:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    count:SetPoint("TOPRIGHT", column, "TOPRIGHT", -14, -16)
    count:SetJustifyH("RIGHT")

    local accent = column:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", column, "TOPLEFT", 1, -38)
    accent:SetPoint("TOPRIGHT", column, "TOPRIGHT", -1, -38)
    accent:SetHeight(2)
    Widgets:SetTextureColor(accent, C.STATUS_ACCENT_COLORS[status], { 1.0, 0.82, 0.18, 0.68 })

    local scroll = CreateFrame("ScrollFrame", nil, column, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 12, -46)
    scroll:SetPoint("BOTTOMRIGHT", -28, 12)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 1)
    scroll:SetScrollChild(content)

    column.status = status
    column.count = count
    column.scroll = scroll
    column.content = content
    column.cards = {}

    return column
end

function MainWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerMainFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(1100, 660)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target)
    end)

    local pos = TODOPlannerDB.settings.frame
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.point or "CENTER", pos.x or 0, pos.y or 0)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "TODO Planner")

        local subtitle = frame.headerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Character boards with shared Global tasks")

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerMainFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("TODO Planner")

        local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        subtitle:SetText("Character boards with shared Global tasks")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local toolbar = Widgets:CreatePanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(84)
    toolbar.topAccent = Widgets:AddGoldTopAccent(toolbar, 2, 0.20)

    local boardButton = Widgets:CreateButton(toolbar, 270, 24, "", "neutral")
    boardButton:SetPoint("TOPLEFT", 12, -12)

    local filterButton = Widgets:CreateButton(toolbar, 180, 24, "", "neutral")
    filterButton:SetPoint("LEFT", boardButton, "RIGHT", 8, 0)

    local inputTitle = Widgets:CreateEditBox(toolbar, 360, 24)
    inputTitle:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -48)
    inputTitle:SetMaxLetters(120)

    local titleLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    titleLabel:SetPoint("BOTTOMLEFT", inputTitle, "TOPLEFT", 4, 4)
    titleLabel:SetText("Task Name")

    local saveButton = Widgets:CreateButton(toolbar, 104, 24, "Add Task", "primary")
    saveButton:SetPoint("LEFT", inputTitle, "RIGHT", 8, 0)

    local detailedButton = Widgets:CreateButton(toolbar, 132, 24, "Create Detailed", "neutral")
    detailedButton:SetPoint("LEFT", saveButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.toolbar = toolbar
    self.boardButton = boardButton
    self.filterButton = filterButton
    self.inputTitle = inputTitle
    self.saveButton = saveButton
    self.detailedButton = detailedButton

    self.columns = {
        TODO = self:CreateColumn(body, "TODO", 12),
        DOING = self:CreateColumn(body, "DOING", 361),
        DONE = self:CreateColumn(body, "DONE", 710),
    }

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

    saveButton:SetScript("OnClick", function()
        local titleText = Utils:Trim(inputTitle:GetText())
        if titleText == "" then
            Utils:Msg("Task title is required.")
            return
        end

        if self.editingTaskId then
            local task = Tasks:FindById(self.editingTaskId)
            if task then
                task.title = titleText
                task.updatedAt = time()
            end
        else
            Tasks:CreateOnCurrentCharacterBoard({
                title = titleText,
                notes = "",
                category = "General",
                status = "TODO",
            })
        end

        Tasks:SortStable(TODOPlannerDB.tasks)
        self:ResetEditor()
        self:Render()
    end)

    detailedButton:SetScript("OnClick", function()
    end)

    inputTitle:SetScript("OnEnterPressed", function()
        saveButton:Click()
    end)

    self:ResetEditor()
    frame:Hide()

    return self
end

function MainWindow:Render()
    local boardKey = self:GetSelectedBoardKey()
    Widgets:UpdateButtonLabel(self.boardButton, "Board", boardKey, function(value)
        return Boards:GetDisplayName(value)
    end)
    Widgets:UpdateButtonLabel(self.filterButton, "Filter", TODOPlannerDB.settings.filterCategory or "All")

    for status, column in pairs(self.columns) do
        for _, oldCard in ipairs(column.cards) do
            oldCard:Hide()
            oldCard:SetParent(nil)
        end
        wipe(column.cards)

        local tasks = Tasks:GetForStatus(status, boardKey)
        column.count:SetText(tostring(#tasks))

        local y = -6
        for _, task in ipairs(tasks) do
            local card = TDP.TaskCards:Create(column.content, task, status, self)
            card:SetPoint("TOPLEFT", 4, y)
            y = y - 112
            column.cards[#column.cards + 1] = card
        end

        local minHeight = column.scroll:GetHeight()
        local contentHeight = math.max(minHeight, math.abs(y) + 12)
        column.content:SetSize(294, contentHeight)
    end

    if self.detailWindow and self.detailWindow.frame and self.detailWindow.frame:IsShown() and self.detailWindow.frame.taskId then
        local detailTask = Tasks:FindById(self.detailWindow.frame.taskId)
        if detailTask then
            self.detailWindow.frame:UpdateTask(detailTask)
        else
            self.detailWindow.frame:Hide()
        end
    end
end

TDP.MainWindow = MainWindow
