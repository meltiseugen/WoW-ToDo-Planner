local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets
local C = TDP.Constants
local WORLD_MAP_PIN_DEFAULT_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_DEFAULT_SCALE
local WORLD_MAP_PIN_MIN_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_MIN_SCALE
local WORLD_MAP_PIN_MAX_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_MAX_SCALE

function OptionsWindow:EnsureSettings()
    TODOPlannerDB.settings = TODOPlannerDB.settings or {}
    TDP.Utils:EnsureChatLoggingSettings()
    if not C.VISUAL_THEME_KEYS[TODOPlannerDB.settings.visualTheme] then
        TODOPlannerDB.settings.visualTheme = C.DEFAULT_DB.settings.visualTheme
    end
    if type(TODOPlannerDB.settings.useProgressBars) ~= "boolean" then
        TODOPlannerDB.settings.useProgressBars = true
    end
    TODOPlannerDB.settings.worldMapPinScale = tonumber(TODOPlannerDB.settings.worldMapPinScale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if TODOPlannerDB.settings.worldMapPinScale < WORLD_MAP_PIN_MIN_SCALE then
        TODOPlannerDB.settings.worldMapPinScale = WORLD_MAP_PIN_MIN_SCALE
    elseif TODOPlannerDB.settings.worldMapPinScale > WORLD_MAP_PIN_MAX_SCALE then
        TODOPlannerDB.settings.worldMapPinScale = WORLD_MAP_PIN_MAX_SCALE
    end
    if type(TODOPlannerDB.settings.optionsWindow) ~= "table" then
        TODOPlannerDB.settings.optionsWindow = {}
    end
end

function OptionsWindow:Refresh()
    self:EnsureSettings()
    if not self.frame then return end
    for _, row in pairs(self.rows) do
        if row.refreshControl then row:refreshControl() end
        if row.spec.disabledWhenMuted and row.control then
            Widgets:SetButtonEnabled(row.control, TDP.Utils:IsChatLoggingEnabled("test"))
        end
    end
    local visualTheme = TODOPlannerDB.settings.visualTheme
    local displayName = self.Config.VISUAL_THEME_LABELS[visualTheme]
    local appliedTheme = TDP.Theme and TDP.Theme.key or visualTheme
    local needsReload = appliedTheme ~= visualTheme
    self.footerText:SetText(self.notice or (needsReload and (displayName .. " selected. Reload UI to apply.") or "Changes are saved automatically."))
    Widgets:SetButtonEnabled(self.reloadButton, needsReload)
    self:Layout()
end

function OptionsWindow:GetSettingValue(key)
    if key == "minimapButton" then
        local minimap = TODOPlannerDB.settings.minimapButton
        return not (type(minimap) == "table" and minimap.hidden == true)
    end
    return TODOPlannerDB.settings[key]
end

function OptionsWindow:ResetPage()
    local page = self:GetPageDefinition(self.selectedPage)
    if not page or self.searchText ~= "" then return end
    if not self.resetPending then
        self.resetPending = true
        self.resetButton:SetText("Confirm reset")
        self.footerText:SetText("Click Confirm reset to restore " .. page.label .. " preferences.")
        return
    end
    for _, section in ipairs(page.sections) do
        for _, spec in ipairs(section.settings) do
            if spec.setter == "SetLoggingOption" then
                self:SetLoggingOption(spec.key, spec.default)
            elseif spec.setter then
                self[spec.setter](self, spec.default)
            end
        end
    end
    self:CancelReset()
    self.notice = page.label .. " preferences restored."
    self:Refresh()
end

function OptionsWindow:CancelReset()
    self.resetPending = nil
    self.notice = nil
    if self.resetButton then self.resetButton:SetText("Reset this page") end
end

function OptionsWindow:SetMinimapButtonShown(shown)
    self:CancelReset()
    if TDP.MinimapButton then TDP.MinimapButton:SetShown(shown) end
    self.notice = nil
    self:Refresh()
end

function OptionsWindow:SetLoggingOption(key, value)
    local valid = key == "enableChatLogging" or key == "chatLogTimestamps"
    for _, category in ipairs(C.CHAT_LOG_CATEGORIES) do
        if category.key == key then valid = true end
    end
    if not valid then return end
    self:EnsureSettings()
    self:CancelReset()
    TODOPlannerDB.settings[key] = value == true
    self:Refresh()
end

function OptionsWindow:TestChatOutput()
    TDP.Utils:Msg("Chat logging is working. Choose your message categories in Options > Logging.", "test")
end

function OptionsWindow:SetVisualTheme(themeKey)
    self:EnsureSettings()
    if not C.VISUAL_THEME_KEYS[themeKey] then
        return
    end
    self:CancelReset()
    TODOPlannerDB.settings.visualTheme = themeKey
    self.notice = nil
    self:Refresh()
end

function OptionsWindow:SetProgressBarsEnabled(enabled)
    self:EnsureSettings()
    self:CancelReset()
    TODOPlannerDB.settings.useProgressBars = enabled == true
    self.notice = nil
    self:Refresh()

    local ui = self.ui
    if ui and ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown() then
        ui.detailWindow.frame:UpdateNotesLayout()
    end
end

function OptionsWindow:SetWorldMapPinScale(scale)
    self:EnsureSettings()
    self:CancelReset()
    scale = tonumber(scale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if scale ~= scale or scale == math.huge or scale == -math.huge then
        scale = WORLD_MAP_PIN_DEFAULT_SCALE
    end
    if scale < WORLD_MAP_PIN_MIN_SCALE then
        scale = WORLD_MAP_PIN_MIN_SCALE
    elseif scale > WORLD_MAP_PIN_MAX_SCALE then
        scale = WORLD_MAP_PIN_MAX_SCALE
    end

    TODOPlannerDB.settings.worldMapPinScale = scale
    self.notice = nil
    self:Refresh()

    local collectionMapWindow = TDP.collectionMapWindow
    if collectionMapWindow and collectionMapWindow.projectedPayload then
        collectionMapWindow:RefreshWorldMapProjection()
    end
end

function OptionsWindow:ResetMainWindowPosition()
    local positionedWindows = {
        { key = "home", window = TDP.ui },
        { key = "planner", window = self.ui or TDP.plannerWindow },
        { key = "explorer", window = TDP.explorerWindow },
        { key = "favorites", window = TDP.favoritesWindow },
        { key = "collectionMap", window = TDP.collectionMapWindow },
        { key = "options", window = self },
    }

    for _, positionedWindow in ipairs(positionedWindows) do
        local window = positionedWindow.window
        Widgets:ResetFramePosition(positionedWindow.key, window and window.frame)
    end
    self.notice = "Window positions reset."
    self:Refresh()
end
