local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

local TaskDetailWindow = {}
TaskDetailWindow.__index = TaskDetailWindow
local DETAIL_COMPACT_HEIGHT = 88
local DETAIL_ROW_HEIGHT = 24
local DETAIL_HEIGHT_PADDING = 18

function TaskDetailWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
    }, self)
end

function TaskDetailWindow:Build()
    local ui = self.ui
    local frame = CreateFrame("Frame", "TODOPlannerTaskDetailFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(620, 620)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    if frame.SetResizable then
        frame:SetResizable(true)
    end
    if frame.SetResizeBounds then
        frame:SetResizeBounds(520, 560, 1000, 900)
    elseif frame.SetMinResize then
        frame:SetMinResize(520, 560)
        if frame.SetMaxResize then
            frame:SetMaxResize(1000, 900)
        end
    end
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Task Details")
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerTaskDetailFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Task Details")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local titleText = body:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOPLEFT", 16, -16)
    titleText:SetPoint("TOPRIGHT", -16, -16)
    Widgets:ConfigureDetailText(titleText, false)
    frame.titleText = titleText

    local details = Widgets:CreatePanel(body, "section", "goldBorder")
    details:SetPoint("TOPLEFT", 14, -54)
    details:SetPoint("TOPRIGHT", -14, -54)
    details:SetHeight(DETAIL_COMPACT_HEIGHT)
    details.topAccent = Widgets:AddGoldTopAccent(details, 2, 0.18)
    frame.detailsPanel = details

    frame.detailRows = {}
    local function addDetailRow(key, labelText, alwaysVisible, allowWrap)
        local label = details:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        label:SetWidth(86)
        label:SetJustifyH("LEFT")
        label:SetText(labelText)

        local value = details:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        Widgets:ConfigureDetailText(value, allowWrap == true)
        value:SetJustifyV("TOP")

        local row = {
            key = key,
            label = label,
            value = value,
            alwaysVisible = alwaysVisible == true,
        }
        frame.detailRows[#frame.detailRows + 1] = row
        return row
    end

    frame.idValue = addDetailRow("id", "ID", true).value
    frame.statusValue = addDetailRow("status", "Status", true).value
    frame.categoryValue = addDetailRow("category", "Category", true).value
    frame.createdValue = addDetailRow("created", "Created", true).value
    frame.updatedValue = addDetailRow("updated", "Updated", true).value
    addDetailRow("achievementStatus", "Ach. Status")
    addDetailRow("progress", "Progress")
    addDetailRow("achievementCategory", "Ach. Category")
    addDetailRow("earnedByMe", "Earned Here")
    addDetailRow("flags", "Flags")
    addDetailRow("guild", "Guild")
    addDetailRow("earnedBy", "Earned By")

    local notes = Widgets:CreatePanel(body, "section", "goldBorder")
    notes:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -12)
    notes:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -14, 82)
    notes.topAccent = Widgets:AddGoldTopAccent(notes, 2, 0.18)

    local notesLabel = notes:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    notesLabel:SetPoint("TOPLEFT", 12, -10)
    notesLabel:SetText("Notes")

    local notesScroll = CreateFrame("ScrollFrame", nil, notes, "UIPanelScrollFrameTemplate")
    notesScroll:SetPoint("TOPLEFT", 10, -30)
    notesScroll:SetPoint("BOTTOMRIGHT", notes, "BOTTOMRIGHT", -28, 10)

    local notesContent = CreateFrame("Frame", nil, notesScroll)
    notesContent:SetSize(1, 1)
    notesScroll:SetScrollChild(notesContent)

    local notesValue = notesContent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    notesValue:SetPoint("TOPLEFT", 0, 0)
    notesValue:SetWidth(532)
    Widgets:ConfigureDetailText(notesValue, true)
    notesValue:SetJustifyV("TOP")
    if notesValue.SetHyperlinksEnabled then
        notesValue:SetHyperlinksEnabled(true)
    end
    local canHandleHyperlinkClick = notesValue.GetScript
        and notesValue.SetScript
        and pcall(notesValue.GetScript, notesValue, "OnHyperlinkClick")
    if canHandleHyperlinkClick then
        notesValue:SetScript("OnHyperlinkClick", function(_, link, text, button)
            if type(SetItemRef) == "function" then
                SetItemRef(link, text, button)
            end
        end)
    end
    local criteriaLabel = notesContent:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    criteriaLabel:SetText("Criteria")
    criteriaLabel:SetJustifyH("LEFT")
    criteriaLabel:Hide()
    local criteriaDivider = CreateFrame("Frame", nil, notesContent)
    criteriaDivider:SetHeight(22)
    criteriaDivider.line = criteriaDivider:CreateTexture(nil, "BACKGROUND")
    criteriaDivider.line:SetPoint("LEFT", 0, 0)
    criteriaDivider.line:SetPoint("RIGHT", 0, 0)
    criteriaDivider.line:SetHeight(1)
    criteriaDivider.line:SetColorTexture(1, 0.82, 0.18, 0.22)
    criteriaDivider:Hide()

    frame.notesLabel = notesLabel
    frame.notesScroll = notesScroll
    frame.notesContent = notesContent
    frame.notesValue = notesValue
    frame.criteriaLabel = criteriaLabel
    frame.criteriaDivider = criteriaDivider
    frame.criteriaRows = {}

    if frame.StartSizing then
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
            frame:UpdateNotesLayout()
        end)
        frame.resizeButton = resizeButton
    end

    local closeButton = Widgets:CreateButton(body, 76, 24, "Close", "neutral")
    closeButton:SetPoint("BOTTOMRIGHT", -14, 16)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local editButton = Widgets:CreateButton(body, 76, 24, "Edit", "primary")
    editButton:SetPoint("RIGHT", closeButton, "LEFT", -8, 0)
    editButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        if not ui.frame:IsShown() then
            ui:Render()
            ui.frame:Show()
        end

        ui:LoadEditor(task)
        ui.inputTitle:SetFocus()
        frame:Hide()
    end)

    local archiveButton = Widgets:CreateButton(body, 86, 24, "Archive", "danger")
    archiveButton:SetPoint("RIGHT", editButton, "LEFT", -8, 0)
    archiveButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        ui:ConfirmArchiveTask(task)
    end)
    frame.archiveButton = archiveButton

    local wowheadButton = Widgets:CreateButton(body, 94, 24, "Wowhead", "neutral")
    wowheadButton:SetPoint("BOTTOMLEFT", 14, 16)
    wowheadButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        local achievementId = Achievements:GetTaskAchievementId(task)
        if not achievementId then
            return
        end

        Achievements:CopyWowheadAchievementUrl(achievementId)
    end)
    frame.wowheadButton = wowheadButton

    local openAchievementButton = Widgets:CreateButton(body, 132, 24, "Open Achievement", "primary")
    openAchievementButton:SetPoint("LEFT", wowheadButton, "RIGHT", 8, 0)
    openAchievementButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        local achievementId = Achievements:GetTaskAchievementId(task)
        if not achievementId then
            return
        end

        if not Achievements:OpenAchievement(achievementId) then
            Utils:Msg("Could not open that achievement in the achievement window.")
        end
    end)
    frame.openAchievementButton = openAchievementButton

    local moveBoardButton = Widgets:CreateButton(body, 180, 24, "Move to Board", "neutral")
    moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
    moveBoardButton:SetScript("OnClick", function(owner)
        local task = Tasks:FindById(frame.taskId)
        if not task or Tasks:GetBoardKey(task) ~= C.GLOBAL_BOARD_KEY then
            return
        end

        local boardOptions = Boards:GetCharacterBoardOptions()
        if #boardOptions == 0 then
            Utils:Msg("No character boards are available.")
            return
        end

        Widgets:ShowSingleSelectMenu(owner, boardOptions, nil, function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(targetBoardKey)
            task = Tasks:FindById(frame.taskId)
            if not task then
                frame:Hide()
                return
            end

            Tasks:MoveToBoard(task, targetBoardKey)
            TODOPlannerDB.settings.selectedBoard = targetBoardKey
            Tasks:SortStable(TODOPlannerDB.tasks)
            ui:Render()
            frame:UpdateTask(task)
        end)
    end)
    frame.moveBoardButton = moveBoardButton

    function frame:GetCriteriaRow(index)
        local row = self.criteriaRows[index]
        if row then
            return row
        end

        row = CreateFrame("Frame", nil, self.notesContent)
        row:SetHeight(50)
        row.bg = row:CreateTexture(nil, "BACKGROUND")
        row.bg:SetAllPoints(row)
        row.bg:SetColorTexture(1, 1, 1, 0.035)

        row.title = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.title:SetPoint("TOPLEFT", 8, -6)
        row.title:SetJustifyH("LEFT")
        if row.title.SetWordWrap then
            row.title:SetWordWrap(false)
        end

        row.meta = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.meta:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -4)
        row.meta:SetJustifyH("LEFT")
        if row.meta.SetWordWrap then
            row.meta:SetWordWrap(false)
        end

        row.progressBar = CreateFrame("StatusBar", nil, row, "BackdropTemplate")
        row.progressBar:SetSize(220, 14)
        row.progressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        row.progressBar:SetStatusBarColor(0.0, 0.55, 0.08, 1)
        row.progressBar:SetMinMaxValues(0, 1)
        row.progressBar:SetValue(0)
        row.progressBar:SetBackdrop(C.FALLBACK_BACKDROP)
        row.progressBar:SetBackdropColor(0, 0, 0, 0.85)
        row.progressBar:SetBackdropBorderColor(0.85, 0.68, 0.18, 0.85)
        row.progressBar.bg = row.progressBar:CreateTexture(nil, "BACKGROUND")
        row.progressBar.bg:SetAllPoints(row.progressBar)
        row.progressBar.bg:SetColorTexture(0.02, 0.08, 0.02, 0.88)
        row.progressBar.text = row.progressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.progressBar.text:SetPoint("CENTER", row.progressBar, "CENTER", 0, 0)
        row.progressBar:Hide()

        row.openButton = Widgets:CreateButton(row, 58, 22, "Open", "primary")
        row.openButton:SetPoint("RIGHT", row, "RIGHT", -6, 0)
        row.title:SetPoint("RIGHT", row.openButton, "LEFT", -8, 0)
        row.meta:SetPoint("RIGHT", row.openButton, "LEFT", -8, 0)
        row.openButton:SetScript("OnClick", function(target)
            local achievementId = target:GetParent().achievementId
            if not achievementId then
                return
            end

            if not Achievements:OpenAchievement(achievementId) then
                Utils:Msg("Could not open that achievement in the achievement window.")
            end
        end)

        self.criteriaRows[index] = row
        return row
    end

    function frame:UpdateNotesLayout()
        local notesWidth = self.notesScroll:GetWidth()
        if not notesWidth or notesWidth < 200 then
            notesWidth = 532
        end

        local contentWidth = notesWidth - 8
        self.notesValue:SetWidth(contentWidth)

        local textHeight = self.notesValue:GetStringHeight()
        local nextY = textHeight > 0 and -(textHeight + 16) or 0
        local criteriaRows = self.currentCriteriaRows or {}

        if #criteriaRows > 0 then
            self.criteriaLabel:ClearAllPoints()
            self.criteriaLabel:SetPoint("TOPLEFT", self.notesContent, "TOPLEFT", 0, nextY)
            self.criteriaLabel:SetWidth(contentWidth)
            self.criteriaLabel:Show()
            nextY = nextY - 20

            local showedCompletedDivider = false
            for index, criteriaRow in ipairs(criteriaRows) do
                if criteriaRow.completed and not showedCompletedDivider and index > 1 then
                    showedCompletedDivider = true
                    self.criteriaDivider:ClearAllPoints()
                    self.criteriaDivider:SetPoint("TOPLEFT", self.notesContent, "TOPLEFT", 0, nextY)
                    self.criteriaDivider:SetSize(contentWidth, 22)
                    self.criteriaDivider:Show()
                    nextY = nextY - 28
                end

                local row = self:GetCriteriaRow(index)
                row.achievementId = criteriaRow.id
                Widgets:SetButtonEnabled(row.openButton, criteriaRow.canOpen == true)
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", self.notesContent, "TOPLEFT", 0, nextY)
                row:SetSize(contentWidth, 50)
                if criteriaRow.completed then
                    row.bg:SetColorTexture(0.08, 0.34, 0.12, 0.24)
                else
                    row.bg:SetColorTexture(1, 1, 1, 0.035)
                end

                row.title:ClearAllPoints()
                row.title:SetPoint("TOPLEFT", row, "TOPLEFT", 8, -6)
                row.meta:ClearAllPoints()
                row.meta:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -4)
                row.progressBar:ClearAllPoints()
                if criteriaRow.canOpen then
                    row.openButton:Show()
                    row.title:SetPoint("RIGHT", row.openButton, "LEFT", -8, 0)
                    row.meta:SetPoint("RIGHT", row.openButton, "LEFT", -8, 0)
                else
                    row.openButton:Hide()
                    row.title:SetPoint("RIGHT", row, "RIGHT", -8, 0)
                    row.meta:SetPoint("RIGHT", row, "RIGHT", -8, 0)
                end

                row.title:SetText(string.format(
                    "%s %s",
                    criteriaRow.completed and "[x]" or "[ ]",
                    criteriaRow.name or "Unknown"
                ))
                local meta = ""
                if criteriaRow.progress and criteriaRow.progress ~= "" then
                    meta = criteriaRow.progress
                end
                row.meta:SetText(meta)
                if TODOPlannerDB.settings.useProgressBars ~= false and criteriaRow.progressValue and criteriaRow.progressMax then
                    row.meta:Hide()
                    row.progressBar:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -6)
                    row.progressBar:SetPoint("RIGHT", criteriaRow.canOpen and row.openButton or row, criteriaRow.canOpen and "LEFT" or "RIGHT", criteriaRow.canOpen and -8 or -8, 0)
                    row.progressBar:SetMinMaxValues(0, criteriaRow.progressMax)
                    row.progressBar:SetValue(criteriaRow.progressValue)
                    row.progressBar.text:SetText(string.format("%d / %d", criteriaRow.progressValue, criteriaRow.progressMax))
                    row.progressBar:Show()
                else
                    row.meta:Show()
                    row.progressBar:Hide()
                end
                row:Show()
                nextY = nextY - 56
            end

            for index = #criteriaRows + 1, #self.criteriaRows do
                self.criteriaRows[index]:Hide()
            end
            if not showedCompletedDivider then
                self.criteriaDivider:Hide()
            end
        else
            self.criteriaLabel:Hide()
            self.criteriaDivider:Hide()
            for _, row in ipairs(self.criteriaRows) do
                row:Hide()
            end
        end

        self.notesContent:SetSize(
            notesWidth,
            math.max(self.notesScroll:GetHeight(), math.abs(nextY) + 8)
        )
    end

    function frame:UpdateDetailRows()
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

    frame:SetScript("OnSizeChanged", function(target)
        target:UpdateDetailRows()
        target:UpdateNotesLayout()
    end)

    function frame:UpdateTask(task)
        local taskBoardKey = Tasks:GetBoardKey(task)
        if Achievements:AutoCompleteTask(task) then
            Tasks:SortStable(TODOPlannerDB.tasks)
        end
        local visibleStatus = Tasks:GetStatus(task)
        local achievementId = Achievements:GetTaskAchievementId(task)
        local notesText = achievementId and Achievements:BuildDetailText(task) or Utils:Trim(task.notes or "")
        local criteriaRows = achievementId and Achievements:GetAchievementCriteriaRows(achievementId) or {}

        self.taskId = task.id
        self.titleText:SetText(task.title or "(Untitled)")
        self.notesLabel:SetText(achievementId and "Achievement Details" or "Notes")
        self.currentCriteriaRows = criteriaRows
        self.notesValue:SetFontObject(achievementId and GameFontHighlight or GameFontHighlightSmall)

        local detailValues = {
            id = "#" .. tostring(task.id or "?"),
            status = Tasks:FormatStatus(visibleStatus),
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

        self.notesValue:SetText(notesText ~= "" and notesText or (#criteriaRows > 0 and "" or "No notes."))
        self:UpdateNotesLayout()

        if Tasks:IsArchived(task) then
            self.archiveButton:Hide()
        else
            self.archiveButton:Show()
        end

        if achievementId then
            self.wowheadButton:Show()
            self.openAchievementButton:Show()
            self.wowheadButton:ClearAllPoints()
            self.wowheadButton:SetPoint("BOTTOMLEFT", 14, 16)
            self.openAchievementButton:ClearAllPoints()
            self.openAchievementButton:SetPoint("LEFT", self.wowheadButton, "RIGHT", 8, 0)

            if taskBoardKey == C.GLOBAL_BOARD_KEY then
                self.moveBoardButton:Show()
                self.moveBoardButton:ClearAllPoints()
                self.moveBoardButton:SetPoint("BOTTOMLEFT", 14, 44)
            else
                self.moveBoardButton:Hide()
            end
        else
            self.wowheadButton:Hide()
            self.openAchievementButton:Hide()
            if taskBoardKey == C.GLOBAL_BOARD_KEY then
                self.moveBoardButton:Show()
                self.moveBoardButton:ClearAllPoints()
                self.moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
            else
                self.moveBoardButton:Hide()
            end
        end
    end

    function frame:OpenTask(task)
        self:UpdateTask(task)
        self:ClearAllPoints()
        self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
        self:Show()
        if TDP.Theme then
            TDP.Theme:BringToFront(self, ui.frame)
        end
    end

    frame:Hide()
    self.frame = frame
    return frame
end

function TaskDetailWindow:Open(task)
    if not self.frame then
        self:Build()
    end

    self.frame:OpenTask(task)
end

TDP.TaskDetailWindow = TaskDetailWindow
