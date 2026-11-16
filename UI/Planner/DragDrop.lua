local _, TDP = ...
local MainWindow = TDP.MainWindow
local C = TDP.Constants
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local DROP_INDICATOR_WIDTH = MainWindow.Config.DROP_INDICATOR_WIDTH
local DROP_INDICATOR_HEIGHT = MainWindow.Config.DROP_INDICATOR_HEIGHT

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
    local top = column.scroll:GetTop()
    if not top then return nil, "end" end
    local contentY = top - cursorY + column.scroll:GetVerticalScroll()
    local tasks, geometry = column.tasks or {}, column.taskGeometry or {}
    local low, high = 1, #tasks
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local position = geometry[middle]
        if contentY > position.top + position.height / 2 then low = middle + 1 else high = middle - 1 end
    end
    for index = low, #tasks do
        if tasks[index].id ~= draggedTaskId then return tasks[index].id, "before" end
    end
    for index = low - 1, 1, -1 do
        if tasks[index].id ~= draggedTaskId then return tasks[index].id, "after" end
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

    local index = column.taskIndices and column.taskIndices[anchorTaskId]
    local geometry = index and column.taskGeometry[index]
    if geometry then
        if placement == "before" then return -geometry.top + 4 end
        return -geometry.top - geometry.height - 4
    end

    return -6
end

function MainWindow:UpdateDropIndicator()
    if not self.draggingTaskId or not self:CanReorderSelectedBoard() then
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
    indicator:SetSize(math.max(1, column.content:GetWidth() - 8), DROP_INDICATOR_HEIGHT)
    indicator:Show()
end

function MainWindow:HideDropIndicator()
    if self.dropIndicator then
        self.dropIndicator:Hide()
    end
end

function MainWindow:BeginTaskDrag(card)
    if not card or not card.taskId or not self:CanReorderSelectedBoard() then
        return
    end

    self.draggingTaskId = card.taskId
    self.dragSourceCard = card
    card:SetAlpha(0.72)
    self.frame:SetScript("OnUpdate", function()
        if not IsMouseButtonDown("LeftButton") then
            self:EndTaskDrag(self.dragSourceCard)
            return
        end
        self:UpdateDropIndicator()
    end)
    self:UpdateDropIndicator()
end

function MainWindow:CancelTaskDrag()
    if self.dragSourceCard then
        self.dragSourceCard:SetAlpha(1)
    end
    self.frame:SetScript("OnUpdate", nil)
    self:HideDropIndicator()
    self.draggingTaskId = nil
    self.dragSourceCard = nil
end

function MainWindow:EndTaskDrag(card)
    if not card or not card.taskId or self.draggingTaskId ~= card.taskId then
        self:CancelTaskDrag()
        return
    end
    local targetColumn, anchorTaskId, placement = self:GetDropTarget(card.taskId)
    if targetColumn and self:CanReorderSelectedBoard() then
        Tasks:MoveRelative(card.taskId, targetColumn.status, self:GetSelectedBoardKey(), anchorTaskId, placement)
    end
    self:CancelTaskDrag()
    self:Render()
end
