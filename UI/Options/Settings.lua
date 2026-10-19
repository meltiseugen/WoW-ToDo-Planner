local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets
local C = TDP.Constants
local VISUAL_THEME_LABELS = OptionsWindow.Config.VISUAL_THEME_LABELS
local WORLD_MAP_PIN_DEFAULT_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_DEFAULT_SCALE
local WORLD_MAP_PIN_MIN_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_MIN_SCALE
local WORLD_MAP_PIN_MAX_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_MAX_SCALE

function OptionsWindow:EnsureSettings()
    TODOPlannerDB.settings = TODOPlannerDB.settings or {}
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
end

function OptionsWindow:Refresh()
    self:EnsureSettings()
    if not self.controls then
        return
    end

    local useProgressBars = TODOPlannerDB.settings.useProgressBars ~= false
    self:ApplyTabVisualState(self.controls.progressBarsButton, useProgressBars)
    self:ApplyTabVisualState(self.controls.progressTextButton, not useProgressBars)
    local visualTheme = TODOPlannerDB.settings.visualTheme
    local displayName = VISUAL_THEME_LABELS[visualTheme] or VISUAL_THEME_LABELS[C.DEFAULT_DB.settings.visualTheme]
    if self.controls.themeSelector then
        self.controls.themeSelector:SetText(displayName)
    end
    local appliedTheme = TDP.Theme and TDP.Theme.key or visualTheme
    local needsReload = appliedTheme ~= visualTheme
    if self.controls.themeStatusText then
        self.controls.themeStatusText:SetText(
            needsReload and (displayName .. " selected - reload to apply.") or (displayName .. " is active.")
        )
    end
    if self.controls.reloadThemeButton then
        Widgets:SetButtonEnabled(self.controls.reloadThemeButton, needsReload)
    end
    if self.controls.worldMapPinScaleText then
        self.controls.worldMapPinScaleText:SetText(string.format("%d%%", math.floor((TODOPlannerDB.settings.worldMapPinScale * 100) + 0.5)))
    end
end

function OptionsWindow:SetVisualTheme(themeKey)
    self:EnsureSettings()
    if not C.VISUAL_THEME_KEYS[themeKey] then
        return
    end
    TODOPlannerDB.settings.visualTheme = themeKey
    self:Refresh()
end

function OptionsWindow:SetProgressBarsEnabled(enabled)
    self:EnsureSettings()
    TODOPlannerDB.settings.useProgressBars = enabled == true
    self:Refresh()

    local ui = self.ui
    if ui and ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown() then
        ui.detailWindow.frame:UpdateNotesLayout()
    end
end

function OptionsWindow:SetWorldMapPinScale(scale)
    self:EnsureSettings()
    scale = tonumber(scale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if scale < WORLD_MAP_PIN_MIN_SCALE then
        scale = WORLD_MAP_PIN_MIN_SCALE
    elseif scale > WORLD_MAP_PIN_MAX_SCALE then
        scale = WORLD_MAP_PIN_MAX_SCALE
    end

    TODOPlannerDB.settings.worldMapPinScale = scale
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
    }

    for _, positionedWindow in ipairs(positionedWindows) do
        local window = positionedWindow.window
        Widgets:ResetFramePosition(positionedWindow.key, window and window.frame)
    end
end
