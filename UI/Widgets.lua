local _, TDP = ...

local C = TDP.Constants

local Widgets = {}
Widgets.__index = Widgets

function Widgets:New(addon)
    return setmetatable({
        addon = addon,
        menuFrame = nil,
    }, self)
end

function Widgets:GetTheme()
    return self.addon.Theme
end

function Widgets:GetThemeColor(colorOrKey, fallback)
    local Theme = self:GetTheme()
    if Theme then
        return Theme:GetColor(colorOrKey, fallback)
    end
    if type(colorOrKey) == "table" then
        return colorOrKey
    end
    return fallback
end

function Widgets:ApplyPanelBackdrop(frame, bg, border)
    local Theme = self:GetTheme()
    if Theme then
        Theme:ApplyBackdrop(frame, bg, border)
        return
    end

    local resolvedBg = self:GetThemeColor(bg, { 0.05, 0.05, 0.06, 0.95 })
    local resolvedBorder = self:GetThemeColor(border, { 1, 1, 1, 0.10 })

    frame:SetBackdrop(C.FALLBACK_BACKDROP)
    frame:SetBackdropColor(resolvedBg[1] or 0, resolvedBg[2] or 0, resolvedBg[3] or 0, resolvedBg[4] or 1)
    frame:SetBackdropBorderColor(
        resolvedBorder[1] or 1,
        resolvedBorder[2] or 1,
        resolvedBorder[3] or 1,
        resolvedBorder[4] or 1
    )
end

function Widgets:CreatePanel(parent, bg, border)
    local Theme = self:GetTheme()
    if Theme then
        return Theme:CreatePanel(parent, bg, border)
    end

    local panel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    self:ApplyPanelBackdrop(panel, bg, border)
    return panel
end

function Widgets:CreateButton(parent, width, height, text, paletteKey)
    local Theme = self:GetTheme()
    local button
    if Theme then
        button = Theme:CreateButton(parent, width, height, text, paletteKey or "neutral")
        if button.label then
            button.label:ClearAllPoints()
            button.label:SetPoint("LEFT", button, "LEFT", 8, 0)
            button.label:SetPoint("RIGHT", button, "RIGHT", -8, 0)
            button.label:SetJustifyH("CENTER")
            if button.label.SetWordWrap then
                button.label:SetWordWrap(false)
            end
        end
    else
        button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        button:SetSize(width, height)
        button:SetText(text or "")
    end

    button:EnableMouse(true)
    if button.RegisterForClicks then
        button:RegisterForClicks("LeftButtonUp")
    end

    return button
end

function Widgets:SetButtonEnabled(button, enabled)
    button:SetEnabled(enabled)
    button:SetAlpha(enabled and 1 or 0.48)
    if button.label then
        button.label:SetAlpha(enabled and 1 or 0.42)
    end
end

function Widgets:CreateEditBox(parent, width, height)
    local editBox = CreateFrame("EditBox", nil, parent, "BackdropTemplate")
    editBox:SetSize(width, height)
    editBox:SetAutoFocus(false)
    editBox:SetTextInsets(9, 9, 0, 0)
    if GameFontHighlightSmall then
        editBox:SetFontObject(GameFontHighlightSmall)
    end

    self:ApplyPanelBackdrop(editBox, "input", "inputBorder")

    editBox:SetScript("OnEditFocusGained", function(target)
        self:ApplyPanelBackdrop(target, "inputFocus", "inputBorderFocus")
    end)
    editBox:SetScript("OnEditFocusLost", function(target)
        self:ApplyPanelBackdrop(target, "input", "inputBorder")
    end)
    editBox:SetScript("OnEscapePressed", function(target)
        target:ClearFocus()
    end)

    return editBox
end

function Widgets:SetTextureColor(texture, colorOrKey, fallback)
    local color = self:GetThemeColor(colorOrKey, fallback or { 1, 1, 1, 1 })
    texture:SetColorTexture(color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1)
end

function Widgets:AddGoldTopAccent(frame, height, alpha)
    local accent = frame:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
    accent:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    accent:SetHeight(height or 2)
    self:SetTextureColor(accent, { 1.0, 0.82, 0.18, alpha or 0.22 })
    return accent
end

function Widgets:SaveFramePosition(frame)
    local point, _, _, x, y = frame:GetPoint(1)
    TODOPlannerDB.settings.frame.point = point or "CENTER"
    TODOPlannerDB.settings.frame.x = x or 0
    TODOPlannerDB.settings.frame.y = y or 0
end

function Widgets:ShowSingleSelectMenu(owner, options, selectedValue, getLabel, onSelect)
    if self.multiSelectMenuFrame then
        self.multiSelectMenuFrame:Hide()
    end

    if not self.menuFrame then
        self.menuFrame = self:CreatePanel(UIParent, "section", "goldBorder")
        self.menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        self.menuFrame:SetClampedToScreen(true)
        self.menuFrame:EnableMouse(true)
        self.menuFrame.buttons = {}
        self.menuFrame:Hide()
    end

    local menuFrame = self.menuFrame
    local optionHeight = 24
    local optionGap = 4
    local ownerWidth = owner and owner.GetWidth and owner:GetWidth() or 180
    local width = math.max(180, ownerWidth)
    local height = (#options * optionHeight) + (math.max(#options - 1, 0) * optionGap) + 12

    for _, button in ipairs(menuFrame.buttons) do
        button:Hide()
        button:SetParent(menuFrame)
    end

    for optionIndex, value in ipairs(options) do
        local optionValue = value
        local button = menuFrame.buttons[optionIndex]
        if not button then
            button = self:CreateButton(menuFrame, width - 12, optionHeight, "", "neutral")
            menuFrame.buttons[optionIndex] = button
        end

        local label = getLabel and getLabel(optionValue) or tostring(optionValue)
        local isSelected = optionValue == selectedValue
        button:SetSize(width - 12, optionHeight)
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", 6, -6 - ((optionIndex - 1) * (optionHeight + optionGap)))
        button:SetText((isSelected and "* " or "") .. label)
        if button.SetSelected then
            button:SetSelected(isSelected)
        end
        button:SetScript("OnClick", function()
            menuFrame:Hide()
            onSelect(optionValue)
        end)
        button:Show()
    end

    menuFrame:SetSize(width, height)
    menuFrame:ClearAllPoints()
    menuFrame:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", 0, -4)
    menuFrame:Show()

    local Theme = self:GetTheme()
    if Theme then
        Theme:BringToFront(menuFrame, owner)
    end
end

function Widgets:ShowMultiSelectMenu(owner, options, isSelected, getLabel, onToggle)
    if self.menuFrame then
        self.menuFrame:Hide()
    end

    if not self.multiSelectMenuFrame then
        self.multiSelectMenuFrame = self:CreatePanel(UIParent, "section", "goldBorder")
        self.multiSelectMenuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        self.multiSelectMenuFrame:SetClampedToScreen(true)
        self.multiSelectMenuFrame:EnableMouse(true)
        self.multiSelectMenuFrame.checkboxes = {}
        self.multiSelectMenuFrame:Hide()
    end

    local menuFrame = self.multiSelectMenuFrame
    local optionHeight = 24
    local optionGap = 4
    local ownerWidth = owner and owner.GetWidth and owner:GetWidth() or 220
    local width = math.max(220, ownerWidth)
    local doneHeight = 24
    local height = (#options * optionHeight) + (math.max(#options - 1, 0) * optionGap) + doneHeight + 20

    local function updateChecks()
        for optionIndex, value in ipairs(options) do
            local checkbox = menuFrame.checkboxes[optionIndex]
            if checkbox then
                checkbox:SetChecked(isSelected and isSelected(value) == true)
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
            checkbox = CreateFrame("CheckButton", nil, menuFrame, "UICheckButtonTemplate")
            checkbox:SetSize(24, 24)
            checkbox:EnableMouse(true)
            checkbox.Text = checkbox.Text or checkbox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            checkbox.Text:SetPoint("LEFT", checkbox, "RIGHT", 4, 0)
            checkbox.Text:SetTextColor(0.86, 0.88, 0.94)
            menuFrame.checkboxes[optionIndex] = checkbox
        end

        checkbox:ClearAllPoints()
        checkbox:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", 8, -8 - ((optionIndex - 1) * (optionHeight + optionGap)))
        checkbox:SetHitRectInsets(0, -(width - 34), 0, 0)
        checkbox.Text:SetText(getLabel and getLabel(optionValue) or tostring(optionValue))
        checkbox:SetChecked(isSelected and isSelected(optionValue) == true)
        checkbox:SetScript("OnClick", function(target)
            if onToggle then
                onToggle(optionValue, target:GetChecked() == true)
            end
            updateChecks()
        end)
        checkbox:Show()
    end

    if not menuFrame.doneButton then
        menuFrame.doneButton = self:CreateButton(menuFrame, width - 16, doneHeight, "Done", "primary")
        menuFrame.doneButton:SetScript("OnClick", function()
            menuFrame:Hide()
        end)
    end

    menuFrame.doneButton:SetSize(width - 16, doneHeight)
    menuFrame.doneButton:ClearAllPoints()
    menuFrame.doneButton:SetPoint("BOTTOMLEFT", menuFrame, "BOTTOMLEFT", 8, 8)
    menuFrame.doneButton:Show()

    menuFrame:SetSize(width, height)
    menuFrame:ClearAllPoints()
    menuFrame:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", 0, -4)
    menuFrame:Show()

    local Theme = self:GetTheme()
    if Theme then
        Theme:BringToFront(menuFrame, owner)
    end
end

function Widgets:UpdateButtonLabel(button, prefix, value, formatter)
    local label = formatter and formatter(value) or tostring(value)
    button:SetText(prefix .. ": " .. label)
end

function Widgets:ConfigureDetailText(fontString, allowWrap)
    fontString:SetJustifyH("LEFT")
    if fontString.SetWordWrap then
        fontString:SetWordWrap(allowWrap == true)
    end
    if allowWrap and fontString.SetNonSpaceWrap then
        fontString:SetNonSpaceWrap(true)
    end
end

function Widgets:ConfigurePreviewDetailText(fontString)
    if GameFontHighlight then
        fontString:SetFontObject(GameFontHighlight)
    end
    fontString:SetTextColor(0.86, 0.88, 0.94)
    fontString:SetJustifyH("LEFT")
    fontString:SetJustifyV("TOP")
    if fontString.SetWordWrap then
        fontString:SetWordWrap(true)
    end
    if fontString.SetNonSpaceWrap then
        fontString:SetNonSpaceWrap(true)
    end
    if fontString.SetSpacing then
        fontString:SetSpacing(3)
    end
end

function Widgets:FormatPreviewNotes(text)
    text = tostring(text or "")
    text = text:gsub("\nCollection Type:", "\nType:")
    text = text:gsub("\nMount Source Category:", "\nSource Category:")
    text = text:gsub("\nSource:", "\n\nSource:")
    text = text:gsub("\nHow to get:%s*", "\n\nHow to get:\n")
    text = text:gsub("\nEffect:%s*", "\n\nEffect:\n")
    text = text:gsub("\nReward:", "\n\nReward:")
    text = text:gsub("\nWowhead:%s*", "\n\nWowhead:\n")
    return text
end

function Widgets:UpdateScrollablePreviewText(scrollFrame, content, fontString, text)
    if not scrollFrame or not content or not fontString then
        return
    end

    local width = math.max(1, (scrollFrame:GetWidth() or 1) - 4)
    fontString.rawPreviewText = tostring(text or "")
    fontString:SetWidth(width)
    fontString:SetText(self:FormatPreviewNotes(fontString.rawPreviewText))

    local textHeight = fontString.GetStringHeight and fontString:GetStringHeight() or 1
    local scrollHeight = scrollFrame:GetHeight() or 1
    content:SetSize(width, math.max(scrollHeight, textHeight + 12))
    scrollFrame:SetVerticalScroll(0)
    if scrollFrame.UpdateScrollChildRect then
        scrollFrame:UpdateScrollChildRect()
    end
end

TDP.Widgets = Widgets:New(TDP)
