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

TDP.Widgets = Widgets:New(TDP)
