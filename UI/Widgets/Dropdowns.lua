local _, TDP = ...
local Widgets = getmetatable(TDP.Widgets)

function Widgets:ShowDropdownDismissFrame(menuFrame)
    if not self.dropdownDismissFrame then
        local dismissFrame = CreateFrame("Frame", nil, UIParent)
        dismissFrame:SetAllPoints(UIParent)
        dismissFrame:EnableMouse(true)
        dismissFrame:SetScript("OnMouseDown", function()
            self:HideDropdownMenus()
        end)
        dismissFrame:Hide()
        self.dropdownDismissFrame = dismissFrame
    end

    local dismissFrame = self.dropdownDismissFrame
    local menuLevel = menuFrame.GetFrameLevel and (tonumber(menuFrame:GetFrameLevel()) or 0) or 0
    if menuLevel < 1 and menuFrame.SetFrameLevel then
        menuLevel = 1
        menuFrame:SetFrameLevel(menuLevel)
    end

    if dismissFrame.SetFrameStrata and menuFrame.GetFrameStrata then
        dismissFrame:SetFrameStrata(menuFrame:GetFrameStrata())
    end
    if dismissFrame.SetFrameLevel then
        dismissFrame:SetFrameLevel(math.max(0, menuLevel - 1))
    end
    dismissFrame:Show()
end

function Widgets:ShowSingleSelectMenu(owner, options, selectedValue, getLabel, onSelect)
    if self.multiSelectMenuFrame then
        self.multiSelectMenuFrame:Hide()
    end

    if not self.menuFrame then
        self.menuFrame = self:CreatePanel(UIParent, "popupChrome", "goldBorderStrong")
        self.menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        self.menuFrame:SetClampedToScreen(true)
        self.menuFrame:EnableMouse(true)
        self.menuFrame:EnableMouseWheel(true)
        self.menuFrame.buttons = {}
        self.menuFrame.scrollHint = self:CreateFontString(self.menuFrame, "OVERLAY", "GameFontDisableSmall")
        self.menuFrame.scrollHint:SetJustifyH("CENTER")
        local Theme = self:GetTheme()
        if Theme and type(Theme.ApplyPopupArt) == "function" then
            Theme:ApplyPopupArt(self.menuFrame)
        end
        self:HookFrameScript(self.menuFrame, "OnHide", function()
            if self.dropdownDismissFrame then
                self.dropdownDismissFrame:Hide()
            end
        end)
        self.menuFrame:Hide()
    end

    local menuFrame = self.menuFrame
    local optionHeight = 24
    local optionGap = 0
    local maxVisibleOptions = 12
    local ownerWidth = owner and owner.GetWidth and owner:GetWidth() or 180
    local width = math.max(180, ownerWidth)
    local visibleCount = math.min(#options, maxVisibleOptions)
    local hasOverflow = #options > maxVisibleOptions
    local hintHeight = hasOverflow and 20 or 0
    local height = (visibleCount * optionHeight)
        + (math.max(visibleCount - 1, 0) * optionGap)
        + hintHeight
        + 20

    local selectedIndex
    for index, value in ipairs(options) do
        if value == selectedValue then
            selectedIndex = index
            break
        end
    end
    local maxOffset = math.max(0, #options - visibleCount)
    local scrollOffset = selectedIndex and math.max(0, selectedIndex - visibleCount) or 0
    scrollOffset = math.min(scrollOffset, maxOffset)

    for _, button in ipairs(menuFrame.buttons) do
        button:Hide()
        button:SetParent(menuFrame)
    end

    for slotIndex = 1, visibleCount do
        local button = menuFrame.buttons[slotIndex]
        if not button then
            button = self:CreateButton(menuFrame, width - 20, optionHeight, "", "menu")
            button.label:ClearAllPoints()
            button.label:SetPoint("LEFT", button, "LEFT", 24, 0)
            button.label:SetPoint("RIGHT", button, "RIGHT", -8, 0)
            button.label:SetJustifyH("LEFT")
            button.selectedMark = button:CreateTexture(nil, "OVERLAY")
            button.selectedMark:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            button.selectedMark:SetSize(18, 18)
            button.selectedMark:SetPoint("CENTER", button, "LEFT", 12, 0)
            menuFrame.buttons[slotIndex] = button
        end
        button:SetSize(width - 20, optionHeight)
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", 10, -10 - ((slotIndex - 1) * (optionHeight + optionGap)))
    end

    local function refreshVisibleOptions()
        for slotIndex = 1, visibleCount do
            local optionIndex = scrollOffset + slotIndex
            local optionValue = options[optionIndex]
            local button = menuFrame.buttons[slotIndex]
            local label = getLabel and getLabel(optionValue) or tostring(optionValue)
            local isSelected = optionValue == selectedValue
            button:SetText(label)
            button.selectedMark:SetShown(isSelected)
            if button.SetSelected then
                button:SetSelected(isSelected)
            end
            button:SetScript("OnClick", function()
                menuFrame:Hide()
                onSelect(optionValue)
            end)
            button:Show()
        end

        if hasOverflow then
            menuFrame.scrollHint:SetText(string.format(
                "Mouse wheel to scroll  |  %d-%d of %d",
                scrollOffset + 1,
                scrollOffset + visibleCount,
                #options
            ))
            menuFrame.scrollHint:Show()
        else
            menuFrame.scrollHint:Hide()
        end
    end

    menuFrame:SetScript("OnMouseWheel", function(_, delta)
        if not hasOverflow then
            return
        end
        scrollOffset = math.max(0, math.min(maxOffset, scrollOffset - delta))
        refreshVisibleOptions()
    end)

    menuFrame:SetSize(width, height)
    menuFrame.scrollHint:ClearAllPoints()
    menuFrame.scrollHint:SetPoint("BOTTOMLEFT", menuFrame, "BOTTOMLEFT", 6, 5)
    menuFrame.scrollHint:SetPoint("BOTTOMRIGHT", menuFrame, "BOTTOMRIGHT", -6, 5)
    menuFrame:ClearAllPoints()
    menuFrame:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", -2, -6)
    refreshVisibleOptions()
    menuFrame:Show()

    local Theme = self:GetTheme()
    if Theme then
        Theme:BringToFront(menuFrame, owner)
    end
    self:ShowDropdownDismissFrame(menuFrame)
end

function Widgets:HideDropdownMenus()
    if self.menuFrame then
        self.menuFrame:Hide()
    end
    if self.multiSelectMenuFrame then
        self.multiSelectMenuFrame:Hide()
    end
    if self.dropdownDismissFrame then
        self.dropdownDismissFrame:Hide()
    end
end

function Widgets:ShowMultiSelectMenu(owner, options, isSelected, getLabel, onToggle)
    if self.menuFrame then
        self.menuFrame:Hide()
    end

    if not self.multiSelectMenuFrame then
        self.multiSelectMenuFrame = self:CreatePanel(UIParent, "popupChrome", "goldBorderStrong")
        self.multiSelectMenuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        self.multiSelectMenuFrame:SetClampedToScreen(true)
        self.multiSelectMenuFrame:EnableMouse(true)
        self.multiSelectMenuFrame.checkboxes = {}
        local Theme = self:GetTheme()
        if Theme and type(Theme.ApplyPopupArt) == "function" then
            Theme:ApplyPopupArt(self.multiSelectMenuFrame)
        end
        self:HookFrameScript(self.multiSelectMenuFrame, "OnHide", function()
            if self.dropdownDismissFrame then
                self.dropdownDismissFrame:Hide()
            end
        end)
        self.multiSelectMenuFrame:Hide()
    end

    local menuFrame = self.multiSelectMenuFrame
    local optionHeight = 24
    local optionGap = 0
    local ownerWidth = owner and owner.GetWidth and owner:GetWidth() or 220
    local width = math.max(220, ownerWidth)
    local height = (#options * optionHeight) + (math.max(#options - 1, 0) * optionGap) + 20

    local function updateChecks()
        for optionIndex, value in ipairs(options) do
            local checkbox = menuFrame.checkboxes[optionIndex]
            if checkbox then
                local checked = isSelected and isSelected(value) == true
                checkbox:SetChecked(checked)
                checkbox.Check:SetShown(checked)
            end
        end
    end

    for _, checkbox in ipairs(menuFrame.checkboxes) do
        checkbox:Hide()
        checkbox:SetParent(menuFrame)
    end

    for optionIndex, value in ipairs(options) do
        local optionValue = value
        local checkbox = menuFrame.checkboxes[optionIndex]
        if not checkbox then
            checkbox = CreateFrame("CheckButton", nil, menuFrame, "BackdropTemplate")
            checkbox:SetSize(18, 18)
            checkbox:EnableMouse(true)
            self:ApplyPanelBackdrop(checkbox, "input", "goldBorderStrong")
            checkbox.Check = checkbox:CreateTexture(nil, "OVERLAY")
            checkbox.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            checkbox.Check:SetPoint("CENTER")
            checkbox.Check:SetSize(18, 18)
            checkbox.Text = checkbox.Text or self:CreateFontString(checkbox, "OVERLAY", "GameFontHighlightSmall")
            checkbox.Text:SetPoint("LEFT", checkbox, "RIGHT", 8, 0)
            self:ApplyTextColor(checkbox.Text, "textSoft")
            checkbox:SetScript("OnEnter", function(target)
                self:ApplyPanelBackdrop(target, "inputFocus", "inputBorderFocus")
            end)
            checkbox:SetScript("OnLeave", function(target)
                self:ApplyPanelBackdrop(target, "input", "goldBorderStrong")
            end)
            menuFrame.checkboxes[optionIndex] = checkbox
        end

        checkbox:ClearAllPoints()
        checkbox:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", 10, -10 - ((optionIndex - 1) * (optionHeight + optionGap)))
        checkbox:SetHitRectInsets(0, -(width - 34), 0, 0)
        checkbox.Text:SetText(getLabel and getLabel(optionValue) or tostring(optionValue))
        local checked = isSelected and isSelected(optionValue) == true
        checkbox:SetChecked(checked)
        checkbox.Check:SetShown(checked)
        checkbox:SetScript("OnClick", function(target)
            if onToggle then
                onToggle(optionValue, target:GetChecked() == true)
            end
            updateChecks()
        end)
        checkbox:Show()
    end

    menuFrame:SetSize(width, height)
    menuFrame:ClearAllPoints()
    menuFrame:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", -2, -6)
    menuFrame:Show()

    local Theme = self:GetTheme()
    if Theme then
        Theme:BringToFront(menuFrame, owner)
    end
    self:ShowDropdownDismissFrame(menuFrame)
end
