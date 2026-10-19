local _, TDP = ...
local Widgets = getmetatable(TDP.Widgets)
local C = TDP.Constants

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

function Widgets:ApplyTextColor(fontString, colorOrKey, fallback)
    if not fontString or type(fontString.SetTextColor) ~= "function" then
        return fontString
    end

    local Theme = self:GetTheme()
    if Theme and type(Theme.ApplyFontTreatment) == "function" then
        Theme:ApplyFontTreatment(fontString)
    end

    local color = self:GetThemeColor(colorOrKey, fallback or { 1, 1, 1, 1 })
    if type(color) == "table" then
        fontString:SetTextColor(color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1)
    end
    return fontString
end

function Widgets:CreateFontString(parent, layer, fontObject, colorKey)
    local fontString = parent:CreateFontString(nil, layer, fontObject)
    if colorKey == nil and type(fontObject) == "string" then
        if fontObject:find("Disable", 1, true) then
            colorKey = "textMuted"
        elseif fontObject:find("Normal", 1, true) then
            colorKey = "textStrong"
        elseif fontObject:find("HighlightSmall", 1, true) then
            colorKey = "textSoft"
        else
            colorKey = "text"
        end
    end
    return self:ApplyTextColor(fontString, colorKey or "text")
end

function Widgets:GetColorCode(colorOrKey, fallback)
    local color = self:GetThemeColor(colorOrKey, fallback or { 1, 1, 1, 1 })
    local function byte(value)
        return math.floor((math.max(0, math.min(1, tonumber(value) or 1)) * 255) + 0.5)
    end
    return string.format("|c%02x%02x%02x%02x", byte(color[4]), byte(color[1]), byte(color[2]), byte(color[3]))
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
        return self:RaiseParentWindowOnInteraction(Theme:CreatePanel(parent, bg, border))
    end

    local panel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    self:ApplyPanelBackdrop(panel, bg, border)
    return self:RaiseParentWindowOnInteraction(panel)
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

    return self:RaiseParentWindowOnInteraction(button)
end

function Widgets:CreateSelectorButton(parent, width, height, text)
    local button = self:CreateButton(parent, width, height, text, "neutral")
    local Theme = self:GetTheme()
    if Theme and type(Theme.ApplySelectorArt) == "function" then
        Theme:ApplySelectorArt(button, { arrow = true })
    end
    button.isSelector = true
    return button
end

function Widgets:CreateTabButton(parent, width, height, text)
    local button = self:CreateButton(parent, width, height, text, "neutral")
    local Theme = self:GetTheme()
    if Theme and type(Theme.ApplySelectorArt) == "function" then
        Theme:ApplySelectorArt(button, { arrow = false, centered = true })
    end
    button.isNavigationTab = true
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
    self:ApplyTextColor(editBox, "text")

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

    self:RaiseParentWindowOnInteraction(editBox)
    self:HookFrameScript(editBox, "OnEditFocusGained", function(target)
        local window = self:GetTopLevelWindow(target)
        if window then
            self:BringToFront(window)
        end
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
    local color = self:GetThemeColor("accentGold", { 1.0, 0.82, 0.18, 0.68 })
    accent:SetColorTexture(color[1] or 1, color[2] or 1, color[3] or 1, alpha or color[4] or 1)
    return accent
end

function Widgets:UpdateButtonLabel(button, prefix, value, formatter)
    local label = formatter and formatter(value) or tostring(value)
    button:SetText(prefix .. ": " .. label)
end

function Widgets:CreateBadge(parent)
    local badge = CreateFrame("Frame", nil, parent)
    badge:SetHeight(20)

    badge.background = badge:CreateTexture(nil, "BACKGROUND")
    badge.background:SetAllPoints(badge)

    badge.accent = badge:CreateTexture(nil, "ARTWORK")
    badge.accent:SetPoint("TOPLEFT", badge, "TOPLEFT", 0, 0)
    badge.accent:SetPoint("BOTTOMLEFT", badge, "BOTTOMLEFT", 0, 0)
    badge.accent:SetWidth(3)

    badge.text = self:CreateFontString(badge, "OVERLAY", "GameFontHighlightSmall")
    badge.text:SetPoint("LEFT", badge, "LEFT", 9, 0)
    badge.text:SetPoint("RIGHT", badge, "RIGHT", -6, 0)
    badge.text:SetJustifyH("LEFT")
    if badge.text.SetWordWrap then
        badge.text:SetWordWrap(false)
    end
    if badge.text.SetMaxLines then
        badge.text:SetMaxLines(1)
    end

    return badge
end

function Widgets:SetBadge(badge, text, backgroundColor, accentColor, textColor)
    if not badge then
        return
    end

    badge.text:SetText(text or "")
    self:SetTextureColor(badge.background, backgroundColor, { 0.10, 0.11, 0.15, 0.92 })
    self:SetTextureColor(badge.accent, accentColor, { 1.0, 0.82, 0.18, 1.0 })
    if type(textColor) == "table" then
        badge.text:SetTextColor(textColor[1] or 1, textColor[2] or 1, textColor[3] or 1, textColor[4] or 1)
    end
end
