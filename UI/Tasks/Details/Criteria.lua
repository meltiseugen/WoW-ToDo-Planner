local _, TDP = ...
local TaskDetailWindow = TDP.TaskDetailWindow
local FrameMethods = TaskDetailWindow.FrameMethods
local C = TDP.Constants
local Utils = TDP.Utils
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

function FrameMethods:GetCriteriaRow(index)
    local row = self.criteriaRows[index]
    if row then
        return row
    end

    row = CreateFrame("Frame", nil, self.notesContent)
    row:SetHeight(30)
    row.bg = row:CreateTexture(nil, "BACKGROUND")
    row.bg:SetAllPoints(row)
    row.bg:SetColorTexture(1, 1, 1, 0.035)

    row.title = Widgets:CreateFontString(row, "OVERLAY", "GameFontHighlightSmall")
    row.title:SetPoint("TOPLEFT", 8, -6)
    row.title:SetJustifyH("LEFT")
    if row.title.SetWordWrap then
        row.title:SetWordWrap(false)
    end

    row.meta = Widgets:CreateFontString(row, "OVERLAY", "GameFontDisableSmall")
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
    row.progressBar.text = Widgets:CreateFontString(row.progressBar, "OVERLAY", "GameFontHighlightSmall", "titleText")
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
            Utils:Msg("Could not open that achievement in the achievement window.", "warnings")
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

function FrameMethods:UpdateNotesLayout()
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
        local completedCriteria = 0
        for _, criteriaRow in ipairs(criteriaRows) do
            if criteriaRow.completed then
                completedCriteria = completedCriteria + 1
            end
        end

        self.criteriaLabel:ClearAllPoints()
        self.criteriaLabel:SetPoint("TOPLEFT", self.notesContent, "TOPLEFT", 0, nextY)
        self.criteriaLabel:SetWidth(contentWidth)
        self.criteriaLabel:SetText(string.format(
            "Criteria  %d/%d complete",
            completedCriteria,
            #criteriaRows
        ))
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
            local meta = criteriaRow.progress or ""
            local showProgressBar = TODOPlannerDB.settings.useProgressBars ~= false
                and criteriaRow.progressValue
                and criteriaRow.progressMax
            local hasSecondaryLine = showProgressBar or meta ~= ""
            local rowHeight = showProgressBar and 46 or (hasSecondaryLine and 38 or 30)
            local rightInset = criteriaRow.canOpen and 154 or 8
            local textWidth = math.max(1, contentWidth - 8 - rightInset)
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", self.notesContent, "TOPLEFT", 0, nextY)
            row:SetSize(contentWidth, rowHeight)
            if criteriaRow.completed then
                row.bg:SetColorTexture(0.08, 0.34, 0.12, 0.24)
            else
                row.bg:SetColorTexture(1, 1, 1, 0.035)
            end

            row.title:ClearAllPoints()
            if hasSecondaryLine then
                row.title:SetPoint("TOPLEFT", row, "TOPLEFT", 8, -5)
            else
                row.title:SetPoint("LEFT", row, "LEFT", 8, 0)
            end
            row.title:SetWidth(textWidth)
            row.meta:ClearAllPoints()
            row.meta:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -4)
            row.meta:SetWidth(textWidth)
            row.progressBar:ClearAllPoints()
            if criteriaRow.canOpen then
                row.openButton:Show()
                row.wowheadButton:Show()
                row.openButton:ClearAllPoints()
                row.openButton:SetPoint("RIGHT", row, "RIGHT", -6, 0)
                row.wowheadButton:ClearAllPoints()
                row.wowheadButton:SetPoint("RIGHT", row.openButton, "LEFT", -6, 0)
            else
                row.openButton:Hide()
                row.wowheadButton:Hide()
            end

            local statusText = criteriaRow.completed
                and "|cff63d58aDONE|r"
                or "|cff99a3b5TODO|r"
            row.title:SetText(string.format("%s  %s", statusText, criteriaRow.name or "Unknown"))
            row.meta:SetText(meta)
            if showProgressBar then
                row.meta:Hide()
                row.progressBar:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -6)
                row.progressBar:SetWidth(textWidth)
                row.progressBar:SetMinMaxValues(0, criteriaRow.progressMax)
                row.progressBar:SetValue(criteriaRow.progressValue)
                row.progressBar.text:SetText(string.format("%d / %d", criteriaRow.progressValue, criteriaRow.progressMax))
                row.progressBar:Show()
            else
                row.meta:Show()
                row.progressBar:Hide()
            end
            row:Show()
            nextY = nextY - rowHeight - 6
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

    local scrollHeight = self.notesScroll:GetHeight() or 1
    local contentHeight = math.max(scrollHeight, math.abs(nextY) + 8)
    self.notesContent:SetSize(notesWidth, contentHeight)
    if self.notesScroll.UpdateScrollChildRect then
        self.notesScroll:UpdateScrollChildRect()
    end

    local scrollBar = self.notesScroll.ScrollBar or self.notesScroll.scrollBar
    if scrollBar then
        local hasOverflow = contentHeight > scrollHeight
        if scrollBar.SetShown then
            scrollBar:SetShown(hasOverflow)
        elseif hasOverflow then
            scrollBar:Show()
        else
            scrollBar:Hide()
        end
    end
end
