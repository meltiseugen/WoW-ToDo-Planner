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
    Widgets:RegisterTopLevelWindow(frame)

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

    local ownershipBadge = Widgets:CreateBadge(body)
    ownershipBadge:SetPoint("TOPLEFT", body, "TOPLEFT", 16, -42)
    ownershipBadge:SetPoint("TOPRIGHT", body, "TOPRIGHT", -16, -42)
    frame.ownershipBadge = ownershipBadge

    local details = Widgets:CreatePanel(body, "section", "goldBorder")
    details:SetPoint("TOPLEFT", 14, -74)
    details:SetPoint("TOPRIGHT", -14, -74)
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
    frame.boardValue = addDetailRow("board", "Board", true).value
    frame.categoryValue = addDetailRow("category", "Category", true).value
    frame.createdValue = addDetailRow("created", "Created", true).value
    frame.updatedValue = addDetailRow("updated", "Updated", true).value
    addDetailRow("progress", "Progress")
    addDetailRow("achievementCategory", "Ach. Category")
    addDetailRow("guild", "Guild")
    addDetailRow("earnedBy", "Earned By")

    local notes = Widgets:CreatePanel(body, "section", "goldBorder")
    notes:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -12)
    notes:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -14, 82)
    notes.topAccent = Widgets:AddGoldTopAccent(notes, 2, 0.18)

    local notesLabel = notes:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    notesLabel:SetPoint("TOPLEFT", 12, -10)
    notesLabel:SetText("Description")

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

        ui:OpenTaskEdit(task)
    end)

    local archiveButton = Widgets:CreateButton(body, 86, 24, "Archive", "danger")
    archiveButton:SetPoint("RIGHT", editButton, "LEFT", -8, 0)
    archiveButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        if Tasks:IsArchived(task) then
            ui:ConfirmRestoreTask(task)
        else
            ui:ConfirmArchiveTask(task)
        end
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
        if not task then
            return
        end

        local currentBoardKey = Tasks:GetBoardKey(task)
        local boardOptions = {}
        if currentBoardKey ~= C.GLOBAL_BOARD_KEY then
            boardOptions[#boardOptions + 1] = C.GLOBAL_BOARD_KEY
        end
        for _, boardKey in ipairs(Boards:GetCharacterBoardOptions()) do
            if boardKey ~= currentBoardKey then
                boardOptions[#boardOptions + 1] = boardKey
            end
        end

        if #boardOptions == 0 then
            Utils:Msg("No other boards are available.")
            return
        end

        Widgets:ShowSingleSelectMenu(owner, boardOptions, nil, function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(targetBoardKey)
            local taskId = frame.taskId
            local sourceBoardKey = ui:GetSelectedBoardKey()
            local function moveTask()
                local currentTask = Tasks:FindById(taskId)
                if not currentTask then
                    frame:Hide()
                    return
                end

                local moved, errorText = Tasks:MoveToBoard(currentTask, targetBoardKey, sourceBoardKey)
                if not moved then
                    Utils:Msg(errorText or "Could not move that task.")
                    return
                end

                TODOPlannerDB.settings.selectedBoard = targetBoardKey
                Tasks:SortStable(TODOPlannerDB.tasks)
                ui:Render()
                frame:UpdateTask(currentTask)
            end

            if currentBoardKey == C.GLOBAL_BOARD_KEY and targetBoardKey ~= C.GLOBAL_BOARD_KEY then
                StaticPopupDialogs["TODO_PLANNER_MOVE_GLOBAL_TASK"] = {
                    text = string.format(
                        "Move Global task \"%s\" to %s?\nIt will leave the Global board and appear on the selected character board.",
                        task.title or "",
                        Boards:GetDisplayName(targetBoardKey)
                    ),
                    button1 = YES,
                    button2 = NO,
                    OnAccept = moveTask,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    preferredIndex = 3,
                }
                StaticPopup_Show("TODO_PLANNER_MOVE_GLOBAL_TASK")
            else
                moveTask()
            end
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
        row.wowheadButton = Widgets:CreateButton(row, 76, 22, "Wowhead", "neutral")
        row.wowheadButton:SetPoint("RIGHT", row.openButton, "LEFT", -6, 0)
        row.title:SetPoint("RIGHT", row.wowheadButton, "LEFT", -8, 0)
        row.meta:SetPoint("RIGHT", row.wowheadButton, "LEFT", -8, 0)
        row.openButton:SetScript("OnClick", function(target)
            local achievementId = target:GetParent().achievementId
            if not achievementId then
                return
            end

            if not Achievements:OpenAchievement(achievementId) then
                Utils:Msg("Could not open that achievement in the achievement window.")
            end
        end)
        row.wowheadButton:SetScript("OnClick", function(target)
            local achievementId = target:GetParent().achievementId
            if not achievementId then
                return
            end

            Achievements:CopyWowheadAchievementUrl(achievementId)
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
                Widgets:SetButtonEnabled(row.wowheadButton, criteriaRow.canOpen == true)
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
                    row.wowheadButton:Show()
                    row.openButton:ClearAllPoints()
                    row.openButton:SetPoint("RIGHT", row, "RIGHT", -6, 0)
                    row.wowheadButton:ClearAllPoints()
                    row.wowheadButton:SetPoint("RIGHT", row.openButton, "LEFT", -6, 0)
                    row.title:SetPoint("RIGHT", row.wowheadButton, "LEFT", -8, 0)
                    row.meta:SetPoint("RIGHT", row.wowheadButton, "LEFT", -8, 0)
                else
                    row.openButton:Hide()
                    row.wowheadButton:Hide()
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
                    row.progressBar:SetPoint("RIGHT", criteriaRow.canOpen and row.wowheadButton or row, criteriaRow.canOpen and "LEFT" or "RIGHT", criteriaRow.canOpen and -8 or -8, 0)
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
    frame:SetScript("OnHide", function()
        Widgets:HideDropdownMenus()
    end)

    function frame:UpdateTask(task)
        if Achievements:AutoCompleteTask(task) then
            Tasks:SortStable(TODOPlannerDB.tasks)
        end
        local visibleStatus = Tasks:GetStatus(task, ui:GetSelectedBoardKey())
        local achievementId = Achievements:GetTaskAchievementId(task)
        local notesText = achievementId and Achievements:BuildDetailText(task) or Utils:Trim(task.notes or "")
        local criteriaRows = achievementId and Achievements:GetAchievementCriteriaRows(achievementId) or {}

        self.taskId = task.id
        self.titleText:SetText(task.title or "(Untitled)")
        self.notesLabel:SetText(achievementId and "Achievement Details" or "Description")
        self.currentCriteriaRows = criteriaRows
        self.notesValue:SetFontObject(achievementId and GameFontHighlight or GameFontHighlightSmall)

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

    function frame:OpenTask(task)
        self:UpdateTask(task)
        self:ClearAllPoints()
        self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
        self:Show()
        Widgets:BringToFront(self, ui.frame)
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
