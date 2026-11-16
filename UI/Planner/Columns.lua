local _, TDP = ...
local MainWindow = TDP.MainWindow
local C = TDP.Constants
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local COLUMN_GAP = MainWindow.Config.COLUMN_GAP
local COLUMN_MARGIN = MainWindow.Config.COLUMN_MARGIN

function MainWindow:LayoutColumns()
    if not self.body or not self.columns then
        return
    end

    self.layingOutColumns = true
    local bodyWidth = self.body:GetWidth()
    if not bodyWidth or bodyWidth < 900 then
        bodyWidth = 964
    end
    local availableWidth = bodyWidth - (COLUMN_MARGIN * 2) - (COLUMN_GAP * 2)
    local columnWidth = math.floor(availableWidth / 3)

    for index, status in ipairs(C.STATUS_ORDER) do
        local column = self.columns[status]
        local offsetX = COLUMN_MARGIN + ((index - 1) * (columnWidth + COLUMN_GAP))
        column:ClearAllPoints()
        column:SetPoint("TOPLEFT", self.body, "TOPLEFT", offsetX, -108)
        column:SetPoint("BOTTOMLEFT", self.body, "BOTTOMLEFT", offsetX, 12)
        column:SetWidth(columnWidth)
        column.content:SetWidth(math.max(1, columnWidth - 40))
    end
    self.layingOutColumns = nil
end

function MainWindow:CreateColumn(parent, status, offsetX)
    local column = Widgets:CreatePanel(parent, "panel", "goldBorder")
    column:SetSize(330, 456)
    column:SetPoint("TOPLEFT", offsetX, -108)
    column.topAccent = Widgets:AddGoldTopAccent(column, 3, 0.30)

    local title = Widgets:CreateFontString(column, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 14, -12)
    title:SetJustifyH("LEFT")
    title:SetText(C.STATUS_LABELS[status])

    local count = Widgets:CreateFontString(column, "OVERLAY", "GameFontDisableSmall")
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

    local emptyText = Widgets:CreateFontString(column, "OVERLAY", "GameFontDisableSmall")
    emptyText:SetPoint("TOPLEFT", scroll, "TOPLEFT", 12, -18)
    emptyText:SetPoint("TOPRIGHT", scroll, "TOPRIGHT", -12, -18)
    emptyText:SetJustifyH("CENTER")
    emptyText:SetText("No tasks.")
    emptyText:Hide()
    column.emptyText = emptyText

    Widgets:HookFrameScript(scroll, "OnVerticalScroll", function(_, offset)
        if not column.buildingCards and not self.layingOutColumns then
            self:UpdateVisibleColumnCards(column, offset)
        end
    end)
    return column
end

function MainWindow:ReleaseColumnCards()
    for _, column in pairs(self.columns) do
        for _, card in ipairs(column.cardPool) do
            card:Hide()
            card.taskId, card.boundTask = nil, nil
            card.titleText:SetText("")
            card.metaText:SetText("")
        end
        wipe(column.cards)
        column.tasks, column.taskGeometry, column.taskIndices = nil, nil, nil
    end
end

function MainWindow:UpdateVisibleColumnCards(column, scroll)
    if not self.frame:IsShown() or not column.taskGeometry or column.updatingCards then return end
    column.updatingCards = true
    scroll = math.max(0, tonumber(scroll) or column.scroll:GetVerticalScroll())
    local bottom = scroll + column.scroll:GetHeight()
    local low, high = 1, #column.tasks
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local geometry = column.taskGeometry[middle]
        if geometry.top + geometry.height < scroll then low = middle + 1 else high = middle - 1 end
    end
    local used, poolIndex = {}, 0
    -- A dragged frame keeps its task identity even if it leaves the viewport.
    if self.dragSourceCard and self.dragSourceCard:GetParent() == column.content then used[self.dragSourceCard] = true end
    wipe(column.cards)
    for index = math.max(1, low - 1), #column.tasks do
        local geometry = column.taskGeometry[index]
        if geometry.top > bottom + 104 then break end
        local task, card = column.tasks[index]
        if task.id == self.draggingTaskId then
            card = self.dragSourceCard
        else
            repeat
                poolIndex = poolIndex + 1
                card = column.cardPool[poolIndex]
            until card ~= self.dragSourceCard or not card
            if not card then
                card = TDP.TaskCards:Create(column.content, task, column.status, self)
                column.cardPool[poolIndex] = card
            end
        end
        if card then
            if card.boundTask ~= task or card.boundGeometryVersion ~= column.geometryVersion then
                TDP.TaskCards:Update(card, task, column.status, self)
                card:ClearAllPoints()
                card:SetPoint("TOPLEFT", column.content, "TOPLEFT", 4, -geometry.top)
                card:SetHeight(geometry.height)
                card.boundTask, card.boundGeometryVersion = task, column.geometryVersion
            end
            if card == self.dragSourceCard then card:SetAlpha(0.72) end
            card:Show()
            used[card] = true
            column.cards[#column.cards + 1] = card
        end
    end
    for _, card in ipairs(column.cardPool) do
        if not used[card] then
            card:Hide()
            card.taskId, card.boundTask = nil, nil
        end
    end
    column.updatingCards = nil
end

function MainWindow:BuildColumnCards(column, tasks, scroll)
    column.buildingCards = true
    column.tasks, column.taskGeometry, column.taskIndices = tasks, {}, {}
    column.geometryVersion = (column.geometryVersion or 0) + 1
    local width = math.max(252, column:GetWidth() - 48)
    local showOwnershipBadge = TDP.TaskCards:ShouldShowOwnershipBadge(self)
    local y = 6
    for index, task in ipairs(tasks) do
        local height = TDP.TaskCards:MeasureHeight(task, width, showOwnershipBadge)
        column.taskGeometry[index] = { top = y, height = height }
        column.taskIndices[task.id] = index
        y = y + height + 8
    end
    local viewport = math.max(1, column.scroll:GetHeight())
    column.content:SetSize(math.max(1, column:GetWidth() - 40), math.max(viewport, y + 12))
    if column.scroll.UpdateScrollChildRect then column.scroll:UpdateScrollChildRect() end
    scroll = math.max(0, math.min(scroll or 0, y + 12 - viewport))
    column.scroll:SetVerticalScroll(scroll)
    column.buildingCards = nil
    self:UpdateVisibleColumnCards(column, scroll)
end

function MainWindow:Render()
    if not self.frame or not self.frame:IsShown() or self.rendering then return end
    self.rendering = true
    if self.subtitle then
        self.subtitle:SetText("Separate Global and character task boards")
    end

    local boardKey = self:GetSelectedBoardKey()
    Widgets:UpdateButtonLabel(self.boardButton, "Board", boardKey, function(value)
        return Boards:GetDisplayName(value)
    end)
    Widgets:UpdateButtonLabel(self.filterButton, "Filter", TODOPlannerDB.settings.filterCategory or "All")
    local canDeleteBoard = Boards:CanDeleteBoard(boardKey)
    Widgets:SetButtonEnabled(self.deleteBoardButton, canDeleteBoard == true)

    local viewKey = boardKey .. ":" .. (TODOPlannerDB.settings.filterCategory or "All")
    for _, status in ipairs(C.STATUS_ORDER) do
        local column = self.columns[status]
        local scroll = self.renderedViewKey == viewKey and column.scroll:GetVerticalScroll() or 0
        local tasks = Tasks:GetForStatus(status, boardKey)
        column.count:SetText(tostring(#tasks))
        if #tasks == 0 then
            local filterCategory = TODOPlannerDB.settings.filterCategory or "All"
            column.emptyText:SetText(filterCategory == "All"
                and "No tasks in " .. C.STATUS_LABELS[status] .. "."
                or "No tasks match the " .. filterCategory .. " filter.")
            column.emptyText:Show()
        else
            column.emptyText:Hide()
        end

        self:BuildColumnCards(column, tasks, scroll)
    end
    self.renderedViewKey = viewKey

    if self.detailWindow and self.detailWindow.frame and self.detailWindow.frame:IsShown() and self.detailWindow.frame.taskId then
        local detailTask = Tasks:FindById(self.detailWindow.frame.taskId)
        if detailTask then
            self.detailWindow.frame:UpdateTask(detailTask)
        else
            self.detailWindow.frame:Hide()
        end
    end
    self.rendering = nil
end
