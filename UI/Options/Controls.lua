local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets

function OptionsWindow:Text(parent, value, font, color)
    local label = Widgets:CreateFontString(parent, "OVERLAY", font or "GameFontHighlightSmall", color)
    label:SetJustifyH("LEFT")
    label:SetWordWrap(true)
    label:SetText(value)
    return label
end

function OptionsWindow:HideHelp()
    if GameTooltip then GameTooltip:Hide() end
end

function OptionsWindow:BindHelp(target, title, description, example, context)
    Widgets:HookFrameScript(target, "OnEnter", function(owner)
        if not GameTooltip then return end
        GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
        GameTooltip:SetText(title, 1, 0.82, 0.18, 1, true)
        GameTooltip:AddLine(description, 0.9, 0.92, 0.96, true)
        if example then GameTooltip:AddLine("Example: " .. example, 0.7, 0.8, 0.9, true) end
        local extra = context and context()
        if extra then GameTooltip:AddLine(extra, 0.8, 0.8, 0.8, true) end
        GameTooltip:Show()
    end)
    Widgets:HookFrameScript(target, "OnLeave", function() self:HideHelp() end)
end

function OptionsWindow:ApplyTabVisualState(button, selected)
    if button and button.SetSelected then button:SetSelected(selected == true) end
end

function OptionsWindow:CreateSettingRow(parent, spec)
    local row = CreateFrame("Frame", nil, parent)
    row.spec = spec
    row.label = self:Text(row, spec.label, "GameFontNormal")
    row.description = self:Text(row, spec.description, "GameFontHighlightSmall", "textSoft")
    row.help = Widgets:CreateButton(row, 22, 22, "?", "neutral")
    local function context()
        local text = spec.defaultText and ("Default: " .. spec.defaultText) or ""
        if spec.disabledWhenMuted and not TDP.Utils:IsChatLoggingEnabled("test") then
            text = text .. "\nEnable chat logging to use this control. Your choices stay saved while chat is muted."
        end
        return text ~= "" and text or nil
    end
    self:BindHelp(row.help, spec.label, spec.details, spec.example, context)
    local function help(control)
        self:BindHelp(control, spec.label, spec.details, spec.example, context)
        return control
    end

    if spec.kind == "theme" then
        self:CreateThemeGallery(row)
    elseif spec.kind == "progress" then
        row.bars = help(Widgets:CreateButton(row, 128, 28, "Bars", "neutral"))
        row.text = help(Widgets:CreateButton(row, 128, 28, "Text", "neutral"))
        row.bars:SetScript("OnClick", function() self:SetProgressBarsEnabled(true) end)
        row.text:SetScript("OnClick", function() self:SetProgressBarsEnabled(false) end)
        self:CreateProgressPreview(row)
        row.refreshControl = function(target)
            local bars = TODOPlannerDB.settings.useProgressBars ~= false
            self:ApplyTabVisualState(target.bars, bars)
            self:ApplyTabVisualState(target.text, not bars)
            target.track:SetShown(bars)
            target.fill:SetShown(bars)
        end
        row.layoutControl = function(target, width, top)
            target.bars:SetPoint("TOPLEFT", 0, -top)
            target.text:SetPoint("TOPLEFT", 140, -top)
            target.preview:SetPoint("TOPLEFT", 0, -top - 42)
            target.preview:SetWidth(width)
            target.fill:SetWidth((width - 24) * 3 / 8)
            return top + 148
        end
    elseif spec.kind == "scale" then
        row.down = Widgets:CreateButton(row, 30, 28, "-", "neutral")
        row.input = Widgets:CreateEditBox(row, 70, 28)
        row.input:SetMaxLetters(8)
        row.unit = self:Text(row, "%", "GameFontHighlightSmall")
        row.up = Widgets:CreateButton(row, 30, 28, "+", "neutral")
        row.down:SetMotionScriptsWhileDisabled(true)
        row.up:SetMotionScriptsWhileDisabled(true)
        row.reset = Widgets:CreateButton(row, 128, 28, "Default: 160%", "neutral")
        help(row.input)
        self:BindHelp(row.down, "Smaller pins", "Decrease pin size by 25 percentage points, down to 75%.")
        self:BindHelp(row.up, "Larger pins", "Increase pin size by 25 percentage points, up to 300%.")
        self:BindHelp(row.reset, "Restore pin size", "Set projected world map pins to the default size of 160%.")
        row.down:SetScript("OnClick", function()
            self:SetWorldMapPinScale(TODOPlannerDB.settings.worldMapPinScale - self.Config.WORLD_MAP_PIN_SCALE_STEP)
        end)
        row.up:SetScript("OnClick", function()
            self:SetWorldMapPinScale(TODOPlannerDB.settings.worldMapPinScale + self.Config.WORLD_MAP_PIN_SCALE_STEP)
        end)
        row.reset:SetScript("OnClick", function() self:SetWorldMapPinScale(spec.default) end)
        local function restoreInput(input)
            input:SetText(tostring(math.floor(TODOPlannerDB.settings.worldMapPinScale * 100 + 0.5)))
        end
        row.input:SetScript("OnEnterPressed", function(input)
            local value = tonumber(input:GetText())
            if value then self:SetWorldMapPinScale(value / 100) end
            input:ClearFocus()
            restoreInput(input)
        end)
        row.input:SetScript("OnEscapePressed", function(input) input:ClearFocus(); restoreInput(input) end)
        Widgets:HookFrameScript(row.input, "OnEditFocusLost", restoreInput)
        self:CreateMapPreview(row)
        row.refreshControl = function(target)
            local scale = TODOPlannerDB.settings.worldMapPinScale
            if not target.input.HasFocus or not target.input:HasFocus() then restoreInput(target.input) end
            Widgets:SetButtonEnabled(target.down, scale > self.Config.WORLD_MAP_PIN_MIN_SCALE)
            Widgets:SetButtonEnabled(target.up, scale < self.Config.WORLD_MAP_PIN_MAX_SCALE)
            local size = math.floor(30 * scale + 0.5)
            target.pin:SetSize(math.max(size - 8, 12), math.max(size - 8, 12))
            target.ring:SetSize(size + 10, size + 10)
        end
        row.layoutControl = function(target, width, top)
            target.down:SetPoint("TOPLEFT", 0, -top)
            target.input:SetPoint("TOPLEFT", 40, -top)
            target.unit:SetPoint("LEFT", target.input, "RIGHT", 5, 0)
            target.up:SetPoint("TOPLEFT", 134, -top)
            target.reset:SetPoint("TOPLEFT", 176, -top)
            target.preview:SetPoint("TOPLEFT", 0, -top - 42)
            target.preview:SetWidth(width)
            return top + 182
        end
    elseif spec.kind == "check" then
        row.control = help(Widgets:CreateButton(row, 86, 24, "", "neutral"))
        row.control:SetMotionScriptsWhileDisabled(true)
        row.control:SetScript("OnClick", function()
            if spec.disabledWhenMuted and not TDP.Utils:IsChatLoggingEnabled("test") then return end
            self:SetLoggingOption(spec.key, not self:GetSettingValue(spec.key))
        end)
        row.refreshControl = function(target)
            local enabled = self:GetSettingValue(spec.key) == true
            target.control:SetText(enabled and "On" or "Off")
            self:ApplyTabVisualState(target.control, enabled)
        end
        row.layoutControl = function(target, _, top)
            target.control:SetPoint("TOPRIGHT", -34, 0)
            return top + 2
        end
    elseif spec.kind == "toggle" then
        row.control = help(Widgets:CreateButton(row, 140, 28, "", "neutral"))
        row.control:SetScript("OnClick", function() self:SetMinimapButtonShown(not self:GetSettingValue(spec.key)) end)
        row.refreshControl = function(target)
            local shown = self:GetSettingValue(spec.key)
            target.control:SetText(shown and "Shown" or "Hidden")
            self:ApplyTabVisualState(target.control, shown)
        end
    elseif spec.kind == "action" then
        row.control = help(Widgets:CreateButton(row, 160, 28, spec.text, "neutral"))
        row.control:SetMotionScriptsWhileDisabled(true)
        row.control:SetScript("OnClick", function()
            if spec.disabledWhenMuted and not TDP.Utils:IsChatLoggingEnabled("test") then return end
            self[spec.action](self)
        end)
    end
    if not row.layoutControl then
        row.layoutControl = function(target, _, top)
            target.control:SetPoint("TOPLEFT", 0, -top)
            return top + 40
        end
    end
    self.rows[spec.key] = row
    return row
end

function OptionsWindow:LayoutSettingRow(row, width)
    row:SetWidth(width)
    row.label:SetPoint("TOPLEFT", 0, -2)
    row.label:SetWidth(width - (row.spec.kind == "check" and 136 or 36))
    row.help:SetPoint("TOPRIGHT", 0, 0)
    local top = math.max(24, row.label:GetStringHeight()) + 7
    row.description:SetPoint("TOPLEFT", 0, -top)
    row.description:SetWidth(width)
    top = top + row.description:GetStringHeight() + 16
    local height = row:layoutControl(width, top)
    row:SetHeight(height)
    return height
end
