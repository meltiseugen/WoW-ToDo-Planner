local root = arg and arg[1] or "."
local TDP = { Widgets = {}, EventFrame = {} }
local function loadAddon(path)
    assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP)
end
function UnitFullName() return "Collector", "Realm" end
function UnitName() return "Collector" end
function GetRealmName() return "Realm" end
function time() return 1000 end
loadAddon("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
loadAddon("Core/Constants.lua")
loadAddon("Core/Utils.lua")
loadAddon("Data/Persistence/BoardManager.lua")
loadAddon("Data/Persistence/TaskRepository.lua")
loadAddon("Data/Persistence/Database.lua")
loadAddon("Core/Theme.lua")
assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, "UI/Options/Options.xml")

local function equal(actual, expected, message)
    assert(actual == expected, message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function createTheme()
    -- A fresh manager simulates theme creation after a login/reload.
    return getmetatable(TDP.ThemeManager):New(TDP):Create()
end

TODOPlannerDB = nil
TDP.Database:Init()
equal(TODOPlannerDB.settings.visualTheme, "midnight", "fresh-install default")
equal(TODOPlannerDB.settings.midnightClassicDefaultApplied, true, "fresh-install migration marker")
equal(createTheme().key, "midnight", "fresh-install rendered theme")
equal(createTheme().displayName, "Midnight Classic", "rendered theme label")

for _, previousTheme in ipairs(TDP.Constants.VISUAL_THEME_OPTIONS) do
    TODOPlannerDB = {
        settings = { visualTheme = previousTheme, useProgressBars = false, worldMapPinScale = 2 },
        tasks = { { id = 7, title = "Keep my task", boardKey = "GLOBAL" } },
    }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.visualTheme, "midnight", "existing theme reset: " .. previousTheme)
    equal(createTheme().key, "midnight", "migrated rendered theme")
    equal(TODOPlannerDB.tasks[1].title, "Keep my task", "task preserved")
    equal(TODOPlannerDB.settings.useProgressBars, false, "progress setting preserved")
    equal(TODOPlannerDB.settings.worldMapPinScale, 2, "map setting preserved")

    TODOPlannerDB.settings.visualTheme = previousTheme
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.visualTheme, previousTheme, "later user selection survives reload")
    equal(createTheme().key, previousTheme, "later user selection renders")
end

for _, settings in ipairs({ {}, { visualTheme = "invalid" }, { visualTheme = "invalid", midnightClassicDefaultApplied = true } }) do
    TODOPlannerDB = { settings = settings }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.visualTheme, "midnight", "missing/invalid saved theme default")
    equal(createTheme().key, "midnight", "missing/invalid saved theme renders")
end

TODOPlannerDB = nil
equal(createTheme().key, "midnight", "theme fallback without saved variables")
TODOPlannerDB = { settings = { visualTheme = "invalid" } }
equal(createTheme().key, "midnight", "theme fallback with invalid selection")
TDP.OptionsWindow:New({}):EnsureSettings()
equal(TODOPlannerDB.settings.visualTheme, "midnight", "settings fallback")

print("PASS: Midnight Classic defaults, one-time reset, preserved data and later skin choices")
