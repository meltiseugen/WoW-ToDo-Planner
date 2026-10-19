local _, TDP = ...
local TaskDetailWindow = TDP.TaskDetailWindow
local FrameMethods = TaskDetailWindow.FrameMethods
local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements
local DETAIL_COMPACT_HEIGHT = TaskDetailWindow.Config.DETAIL_COMPACT_HEIGHT
local DETAIL_ROW_HEIGHT = TaskDetailWindow.Config.DETAIL_ROW_HEIGHT
local DETAIL_HEIGHT_PADDING = TaskDetailWindow.Config.DETAIL_HEIGHT_PADDING

function FrameMethods:UpdateDetailRows()
    local detailsWidth = self.detailsPanel:GetWidth()
    if not detailsWidth or detailsWidth < 400 then
        detailsWidth = 560
    end

    local outerPadding = 12
    local columnGap = 18
    local labelWidth = 86
    local columnWidth = (detailsWidth - (outerPadding * 2) - columnGap) / 2
    local valueWidth = math.max(90, columnWidth - labelWidth - 8)
    local visibleRows = 0

    for _, row in ipairs(self.detailRows) do
        local value = row.currentValue
        if row.alwaysVisible or (value and value ~= "") then
            visibleRows = visibleRows + 1
            local gridRow = math.floor((visibleRows - 1) / 2)
            local column = (visibleRows - 1) % 2
            local columnX = outerPadding + (column * (columnWidth + columnGap))
            local rowY = -14 - (gridRow * DETAIL_ROW_HEIGHT)

            row.label:ClearAllPoints()
            row.label:SetPoint("TOPLEFT", self.detailsPanel, "TOPLEFT", columnX, rowY)
            row.label:SetWidth(labelWidth)
            row.value:ClearAllPoints()
            row.value:SetPoint("TOPLEFT", self.detailsPanel, "TOPLEFT", columnX + labelWidth + 8, rowY)
            row.value:SetWidth(valueWidth)
            row.value:SetText(value or "")
            row.label:Show()
            row.value:Show()
        else
            row.label:Hide()
            row.value:Hide()
        end
    end

    local gridRows = math.floor((visibleRows + 1) / 2)
    local targetHeight = (gridRows * DETAIL_ROW_HEIGHT) + DETAIL_HEIGHT_PADDING
    self.detailsPanel:SetHeight(math.max(DETAIL_COMPACT_HEIGHT, targetHeight))
end

function FrameMethods:UpdateTask(task)
    local ui = self.todoPlannerOwner.ui
    if Achievements:AutoCompleteTask(task) then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end
    local visibleStatus = Tasks:GetStatus(task, ui:GetSelectedBoardKey())
    local achievementId = Achievements:GetTaskAchievementId(task)
    local notesText = achievementId and Achievements:BuildDetailText(task) or Utils:Trim(task.notes or "")
    local criteriaRows = achievementId and Achievements:GetAchievementCriteriaRows(achievementId) or {}

    self.taskId = task.id
    self.titleText:SetText(task.title or "(Untitled)")
    self.notesLabel:SetFontObject(achievementId and GameFontNormal or GameFontDisableSmall)
    Widgets:ApplyTextColor(self.notesLabel, achievementId and "textStrong" or "textMuted")
    self.notesLabel:SetText(achievementId and "Achievement Details" or "Description")
    self.currentCriteriaRows = criteriaRows
    self.notesValue:SetFontObject(achievementId and GameFontHighlight or GameFontHighlightSmall)
    Widgets:ApplyTextColor(self.notesValue, achievementId and "text" or "textSoft")

    local boardKey = Tasks:GetBoardKey(task)
    local isGlobal = boardKey == C.GLOBAL_BOARD_KEY
    Widgets:SetBadge(
        self.ownershipBadge,
        isGlobal and "GLOBAL TASK" or "BOARD  |  " .. Boards:GetDisplayName(boardKey),
        isGlobal and { 0.34, 0.23, 0.04, 0.94 } or { 0.02, 0.20, 0.24, 0.94 },
        isGlobal and { 1.0, 0.82, 0.18, 1.0 } or { 0.0, 0.82, 0.70, 1.0 },
        isGlobal and { 1.0, 0.90, 0.48, 1.0 } or { 0.62, 1.0, 0.92, 1.0 }
    )

    local detailValues = {
        id = "#" .. tostring(task.id or "?"),
        status = Tasks:FormatStatus(visibleStatus),
        board = Tasks:GetOwnershipLabel(task),
        category = task.category or "Other",
        created = Utils:GetDateTimeStamp(task.createdAt),
        updated = Utils:GetDateTimeStamp(task.updatedAt),
    }

    if achievementId then
        local summaryFields = Achievements:BuildSummaryFields(achievementId)
        if summaryFields then
            for key, value in pairs(summaryFields) do
                detailValues[key] = value
            end
        end
    end

    for _, row in ipairs(self.detailRows) do
        row.currentValue = detailValues[row.key]
    end
    self:UpdateDetailRows()

    self.notesValue:SetText(notesText ~= "" and notesText or (#criteriaRows > 0 and "" or "No description."))
    self.notesScroll:SetVerticalScroll(0)
    self:UpdateNotesLayout()

    local isArchived = Tasks:IsArchived(task)
    self.archiveButton:SetText(isArchived and "Restore" or "Archive")
    if self.archiveButton.SetPalette then
        self.archiveButton:SetPalette(isArchived and "neutral" or "danger")
    end
    self.archiveButton:Show()

    if achievementId then
        self.wowheadButton:Show()
        self.openAchievementButton:Show()
        self.wowheadButton:ClearAllPoints()
        self.wowheadButton:SetPoint("BOTTOMLEFT", 14, 16)
        self.openAchievementButton:ClearAllPoints()
        self.openAchievementButton:SetPoint("LEFT", self.wowheadButton, "RIGHT", 8, 0)

        self.moveBoardButton:Show()
        self.moveBoardButton:ClearAllPoints()
        self.moveBoardButton:SetPoint("BOTTOMLEFT", 14, 44)
    else
        self.wowheadButton:Hide()
        self.openAchievementButton:Hide()
        self.moveBoardButton:Show()
        self.moveBoardButton:ClearAllPoints()
        self.moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
    end
end

function FrameMethods:OpenTask(task)
    local ui = self.todoPlannerOwner.ui
    self:UpdateTask(task)
    self:ClearAllPoints()
    self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
    self:Show()
    Widgets:BringToFront(self, ui.frame)
end
