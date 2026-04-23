local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

local MainWindow = {}
MainWindow.__index = MainWindow

local DROP_INDICATOR_WIDTH = 286
local DROP_INDICATOR_HEIGHT = 18

function MainWindow:New()
    local instance = {
        frame = nil,
        body = nil,
        toolbar = nil,
        boardButton = nil,
        filterButton = nil,
        createBoardButton = nil,
        deleteBoardButton = nil,
        optionsButton = nil,
        inputTitle = nil,
        saveButton = nil,
        detailedButton = nil,
        columns = {},
        editingTaskId = nil,
        detailWindow = nil,
        editWindow = nil,
        optionsWindow = nil,
        draggingTaskId = nil,
        dragSourceCard = nil,
        dropIndicator = nil,
    }
    return setmetatable(instance, self)
end

function MainWindow:ResetEditor()
    self.editingTaskId = nil
    self.inputTitle:SetText("")
    self.saveButton:SetText("+")
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

function MainWindow:OpenCreateBoardDialog()
    StaticPopupDialogs["TODO_PLANNER_CREATE_BOARD"] = {
        text = "Create board",
        button1 = "Create",
        button2 = CANCEL,
        hasEditBox = true,
        maxLetters = 64,
        OnShow = function(dialog)
            local editBox = dialog.editBox or dialog.EditBox
            if editBox then
                editBox:SetText("")
                editBox:SetFocus()
            end
        end,
        OnAccept = function(dialog)
            local editBox = dialog.editBox or dialog.EditBox
            local boardName = editBox and Utils:Trim(editBox:GetText()) or ""
            local boardKey, errorText = Boards:CreateBoard(boardName)
            if not boardKey then
                Utils:Msg(errorText or "Could not create board.")
                return
            end

            TODOPlannerDB.settings.selectedBoard = boardKey
            self:ResetEditor()
            self:Render()
        end,
        EditBoxOnEnterPressed = function(editBox)
            StaticPopup_OnClick(editBox:GetParent(), 1)
        end,
        EditBoxOnEscapePressed = function(editBox)
            editBox:GetParent():Hide()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_CREATE_BOARD")
end

function MainWindow:ConfirmDeleteSelectedBoard()
    local boardKey = self:GetSelectedBoardKey()
    local canDelete, reason = Boards:CanDeleteBoard(boardKey)
    if not canDelete then
        Utils:Msg(reason or "That board cannot be deleted.")
        return
    end

    local taskCount = Boards:CountBoardTasks(boardKey)
    local taskText = taskCount == 1 and "1 task will move to Global." or tostring(taskCount) .. " tasks will move to Global."

    StaticPopupDialogs["TODO_PLANNER_DELETE_BOARD"] = {
        text = "Delete board \"" .. Boards:GetDisplayName(boardKey) .. "\"?\n" .. taskText,
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            local ok, errorText, movedTasks = Boards:DeleteBoard(boardKey)
            if not ok then
                Utils:Msg(errorText or "Could not delete board.")
                return
            end

            Tasks:SortStable(TODOPlannerDB.tasks)
            self:ResetEditor()
            self:Render()
            Utils:Msg("Deleted board. Moved " .. tostring(movedTasks or 0) .. " task(s) to Global.")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_DELETE_BOARD")
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
    column.cardPool = {}

    return column
end

function MainWindow:GetScaledCursorPosition()
    local x, y = GetCursorPosition()
    local scale = UIParent and UIParent:GetEffectiveScale() or 1
    if scale == 0 then
        scale = 1
    end

    return x / scale, y / scale
end

function MainWindow:IsCursorInsideFrame(frame)
    if not frame or not frame:IsShown() then
        return false
    end

    local left = frame:GetLeft()
    local right = frame:GetRight()
    local top = frame:GetTop()
    local bottom = frame:GetBottom()
    if not left or not right or not top or not bottom then
        return false
    end

    local x, y = self:GetScaledCursorPosition()
    return x >= left and x <= right and y >= bottom and y <= top
end

function MainWindow:GetDropColumn()
    for _, status in ipairs(C.STATUS_ORDER) do
        local column = self.columns[status]
        if self:IsCursorInsideFrame(column) or self:IsCursorInsideFrame(column.scroll) then
            return column
        end
    end

    return nil
end

function MainWindow:GetDropAnchor(column, draggedTaskId)
    local _, cursorY = self:GetScaledCursorPosition()
    local lastTaskId = nil

    for _, card in ipairs(column.cards) do
        if card.taskId ~= draggedTaskId then
            local top = card:GetTop()
            local bottom = card:GetBottom()
            if top and bottom then
                local midpoint = bottom + ((top - bottom) / 2)
                if cursorY >= midpoint then
                    return card.taskId, "before"
                end
                lastTaskId = card.taskId
            end
        end
    end

    if lastTaskId then
        return lastTaskId, "after"
    end

    return nil, "end"
end

function MainWindow:GetDropTarget(draggedTaskId)
    local column = self:GetDropColumn()
    if not column then
        return nil, nil, nil
    end

    local anchorTaskId, placement = self:GetDropAnchor(column, draggedTaskId)
    return column, anchorTaskId, placement
end

function MainWindow:CreateDropIndicator()
    if self.dropIndicator then
        return self.dropIndicator
    end

    local indicator = CreateFrame("Frame", nil, self.body)
    indicator:SetSize(DROP_INDICATOR_WIDTH, DROP_INDICATOR_HEIGHT)
    indicator:SetFrameStrata("DIALOG")
    indicator:SetFrameLevel(500)
    indicator:Hide()

    indicator.glow = indicator:CreateTexture(nil, "BACKGROUND")
    indicator.glow:SetAllPoints(indicator)
    Widgets:SetTextureColor(indicator.glow, { 1.0, 0.82, 0.18, 0.20 })

    indicator.line = indicator:CreateTexture(nil, "OVERLAY")
    indicator.line:SetPoint("LEFT", 0, 0)
    indicator.line:SetPoint("RIGHT", 0, 0)
    indicator.line:SetHeight(5)
    Widgets:SetTextureColor(indicator.line, "accentGold", { 1.0, 0.86, 0.20, 1.0 })

    indicator.leftCap = indicator:CreateTexture(nil, "OVERLAY")
    indicator.leftCap:SetPoint("LEFT", indicator.line, "LEFT", -5, 0)
    indicator.leftCap:SetSize(11, 11)
    Widgets:SetTextureColor(indicator.leftCap, "accentGold", { 1.0, 0.86, 0.20, 1.0 })

    indicator.rightCap = indicator:CreateTexture(nil, "OVERLAY")
    indicator.rightCap:SetPoint("RIGHT", indicator.line, "RIGHT", 5, 0)
    indicator.rightCap:SetSize(11, 11)
    Widgets:SetTextureColor(indicator.rightCap, "accentGold", { 1.0, 0.86, 0.20, 1.0 })

    self.dropIndicator = indicator
    return indicator
end

function MainWindow:GetIndicatorOffset(column, anchorTaskId, placement)
    if not anchorTaskId then
        return -6
    end

    for _, card in ipairs(column.cards) do
        if card.taskId == anchorTaskId then
            local _, _, _, _, yOffset = card:GetPoint(1)
            yOffset = yOffset or 0
            if placement == "before" then
                return yOffset + 4
            end
            return yOffset - card:GetHeight() - 4
        end
    end

    return -6
end

function MainWindow:UpdateDropIndicator()
    if not self.draggingTaskId then
        self:HideDropIndicator()
        return
    end

    local column, anchorTaskId, placement = self:GetDropTarget(self.draggingTaskId)
    if not column then
        self:HideDropIndicator()
        return
    end

    local indicator = self:CreateDropIndicator()
    indicator:SetParent(column.content)
    indicator:SetFrameLevel((column.content:GetFrameLevel() or 0) + 200)
    indicator:ClearAllPoints()
    indicator:SetPoint(
        "TOPLEFT",
        column.content,
        "TOPLEFT",
        4,
        self:GetIndicatorOffset(column, anchorTaskId, placement) + (DROP_INDICATOR_HEIGHT / 2)
    )
    indicator:SetSize(DROP_INDICATOR_WIDTH, DROP_INDICATOR_HEIGHT)
    indicator:Show()
end

function MainWindow:HideDropIndicator()
    if self.dropIndicator then
        self.dropIndicator:Hide()
    end
end

function MainWindow:BeginTaskDrag(card)
    if not card or not card.taskId then
        return
    end

    self.draggingTaskId = card.taskId
    self.dragSourceCard = card
    card:SetAlpha(0.72)
    self.frame:SetScript("OnUpdate", function()
        self:UpdateDropIndicator()
    end)
    self:UpdateDropIndicator()
end

function MainWindow:EndTaskDrag(card)
    if not card or not card.taskId then
        if self.dragSourceCard then
            self.dragSourceCard:SetAlpha(1)
        end
        self.frame:SetScript("OnUpdate", nil)
        self:HideDropIndicator()
        self.draggingTaskId = nil
        self.dragSourceCard = nil
        return
    end

    local targetColumn, anchorTaskId, placement = self:GetDropTarget(card.taskId)
    if targetColumn then
        Tasks:MoveRelative(card.taskId, targetColumn.status, self:GetSelectedBoardKey(), anchorTaskId, placement)
    end

    if self.dragSourceCard then
        self.dragSourceCard:SetAlpha(1)
    end
    self.frame:SetScript("OnUpdate", nil)
    self:HideDropIndicator()
    self.draggingTaskId = nil
    self.dragSourceCard = nil
    self:Render()
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

    local createBoardButton = Widgets:CreateButton(toolbar, 94, 24, "New Board", "neutral")
    createBoardButton:SetPoint("LEFT", filterButton, "RIGHT", 8, 0)

    local deleteBoardButton = Widgets:CreateButton(toolbar, 104, 24, "Delete Board", "danger")
    deleteBoardButton:SetPoint("LEFT", createBoardButton, "RIGHT", 8, 0)

    local optionsButton = Widgets:CreateButton(toolbar, 96, 24, "Options", "neutral")
    optionsButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -12)

    local inputTitle = Widgets:CreateEditBox(toolbar, 360, 24)
    inputTitle:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -48)
    inputTitle:SetMaxLetters(120)

    local titleLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
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
    self.optionsButton = optionsButton
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
            Tasks:CreateOnSelectedBoard({
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

function MainWindow:Render()
    if Achievements and Achievements:AutoCompleteTasks() then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end

    local boardKey = self:GetSelectedBoardKey()
    Widgets:UpdateButtonLabel(self.boardButton, "Board", boardKey, function(value)
        return Boards:GetDisplayName(value)
    end)
    Widgets:UpdateButtonLabel(self.filterButton, "Filter", TODOPlannerDB.settings.filterCategory or "All")
    local canDeleteBoard = Boards:CanDeleteBoard(boardKey)
    Widgets:SetButtonEnabled(self.deleteBoardButton, canDeleteBoard == true)

    for _, status in ipairs(C.STATUS_ORDER) do
        local column = self.columns[status]
        for _, child in ipairs({ column.content:GetChildren() }) do
            if child ~= self.dropIndicator then
                child:Hide()
            end
        end
        wipe(column.cards)

        local tasks = Tasks:GetForStatus(status, boardKey)
        column.count:SetText(tostring(#tasks))

        local y = -6
        for index, task in ipairs(tasks) do
            local card = column.cardPool[index]
            if card then
                card:SetParent(column.content)
                TDP.TaskCards:Update(card, task, status, self)
            else
                card = TDP.TaskCards:Create(column.content, task, status, self)
                column.cardPool[index] = card
            end

            card:ClearAllPoints()
            card:SetPoint("TOPLEFT", 4, y)
            y = y - card:GetHeight() - 8
            column.cards[#column.cards + 1] = card
        end

        for index = #tasks + 1, #column.cardPool do
            local card = column.cardPool[index]
            if card then
                card:ClearAllPoints()
                card:Hide()
            end
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
