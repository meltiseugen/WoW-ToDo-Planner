local _, TDP = ...

local C = TDP.Constants

local OptionsWindow = {}
OptionsWindow.__index = OptionsWindow

local TAB_ORDER = { "General", "Achievements" }
local VISUAL_THEME_OPTIONS = C.VISUAL_THEME_OPTIONS
local VISUAL_THEME_LABELS = C.VISUAL_THEME_LABELS
local WORLD_MAP_PIN_DEFAULT_SCALE = 1.6
local WORLD_MAP_PIN_MIN_SCALE = 0.75
local WORLD_MAP_PIN_MAX_SCALE = 3
local WORLD_MAP_PIN_SCALE_STEP = 0.25

function OptionsWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
        settingsPanel = nil,
        controls = nil,
        tabs = nil,
        selectedTab = "General",
    }, self)
end

OptionsWindow.Config = {
    TAB_ORDER = TAB_ORDER,
    VISUAL_THEME_OPTIONS = VISUAL_THEME_OPTIONS,
    VISUAL_THEME_LABELS = VISUAL_THEME_LABELS,
    WORLD_MAP_PIN_DEFAULT_SCALE = WORLD_MAP_PIN_DEFAULT_SCALE,
    WORLD_MAP_PIN_MIN_SCALE = WORLD_MAP_PIN_MIN_SCALE,
    WORLD_MAP_PIN_MAX_SCALE = WORLD_MAP_PIN_MAX_SCALE,
    WORLD_MAP_PIN_SCALE_STEP = WORLD_MAP_PIN_SCALE_STEP,
}

TDP.OptionsWindow = OptionsWindow
