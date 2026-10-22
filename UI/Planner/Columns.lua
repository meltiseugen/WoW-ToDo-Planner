local _, TDP = ...
local MainWindow = TDP.MainWindow
local C = TDP.Constants
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements
local COLUMN_GAP = MainWindow.Config.COLUMN_GAP
local COLUMN_MARGIN = MainWindow.Config.COLUMN_MARGIN

function MainWindow:LayoutColumns()
    if not self.body or not self.columns then
        return
    end

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

    return column
end

function MainWindow:Render()
    if Achievements and Achievements:AutoCompleteTasks() then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end
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
        if #tasks == 0 then
            local filterCategory = TODOPlannerDB.settings.filterCategory or "All"
            column.emptyText:SetText(filterCategory == "All"
                and "No tasks in " .. C.STATUS_LABELS[status] .. "."
                or "No tasks match the " .. filterCategory .. " filter.")
            column.emptyText:Show()
        else
            column.emptyText:Hide()
        end

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
        column.content:SetSize(math.max(1, column:GetWidth() - 40), contentHeight)
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
