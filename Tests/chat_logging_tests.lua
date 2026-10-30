local root = arg and arg[1] or "."
local TDP = {}
assert(loadfile(root .. "/Core/Constants.lua"))("TODO-Planner", TDP)
assert(loadfile(root .. "/Core/Utils.lua"))("TODO-Planner", TDP)
local Utils, C = TDP.Utils, TDP.Constants
local messages = {}
DEFAULT_CHAT_FRAME = { AddMessage = function(_, text) messages[#messages + 1] = text end }
local function equal(actual, expected, description)
    assert(actual == expected, description .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
function date(format) equal(format, "%H:%M:%S", "timestamp format"); return "14:25:09" end

TODOPlannerDB = nil
equal(Utils:Msg("Loaded", "startup"), false, "startup quiet by default before DB initialization")
equal(Utils:Msg("Opening", "navigation"), false, "navigation quiet by default")
equal(Utils:Msg("An actionable warning", "warnings"), true, "warnings enabled by default")
equal(Utils:Msg("Legacy command reply"), true, "legacy callers use command category")
assert(messages[1]:find("%[Warning%]"), "category label attached")
equal(TODOPlannerDB, nil, "logging does not create saved data")
print("PASS: default routing works before database initialization")

TODOPlannerDB = { settings = Utils:CopyDefaults({}, C.DEFAULT_DB.settings) }
local settings = TODOPlannerDB.settings
for _, selected in ipairs(C.CHAT_LOG_CATEGORIES) do
    for _, category in ipairs(C.CHAT_LOG_CATEGORIES) do settings[category.key] = category == selected end
    messages = {}
    for _, category in ipairs(C.CHAT_LOG_CATEGORIES) do Utils:Msg(category.id, category.id) end
    equal(#messages, 1, "independent category filter for " .. selected.id)
    assert(messages[1]:find(selected.label, 1, true), "selected category label")
end
settings.enableChatLogging = false
messages = {}
for _, category in ipairs(C.CHAT_LOG_CATEGORIES) do equal(Utils:Msg("muted", category.id), false, "master switch") end
equal(Utils:Msg("muted test", "test"), false, "test honors master switch")
equal(#messages, 0, "master suppresses all output")
equal(settings.chatLogCommands, true, "master preserves category selections")
settings.enableChatLogging = true
for _, category in ipairs(C.CHAT_LOG_CATEGORIES) do settings[category.key] = false end
equal(Utils:Msg("Delivery check", "test"), true, "test bypasses individual categories")
equal(Utils:Msg("Unclassified reply", "unknown"), false, "unknown category follows command switch")
print("PASS: all six categories, master mute, preserved preferences, and test delivery")

settings.chatLogTimestamps = true
messages = {}
Utils:Msg("Timestamp check", "test")
assert(messages[1]:find("14:25:09 ", 1, true) == 1, "local timestamp prefix")
settings.chatLogTimestamps = false
messages = {}
Utils:Msg("Without timestamps", "test")
assert(not messages[1]:find("14:25:09", 1, true), "timestamp can be removed")
local originalPrint, fallback = print, nil
DEFAULT_CHAT_FRAME = nil
print = function(text) fallback = text end
Utils:Msg("Fallback delivery", "test")
print = originalPrint
assert(fallback:find("Fallback delivery", 1, true), "print fallback when chat frame unavailable")
settings.chatLogWarnings = "bad value"
settings.chatLogStartup = true
settings.enableChatLogging = false
Utils:EnsureChatLoggingSettings()
equal(settings.chatLogWarnings, true, "invalid boolean normalized")
equal(settings.chatLogStartup, true, "saved opt-in retained")
equal(settings.enableChatLogging, false, "saved master mute retained")
print("PASS: optional timestamps, fallback output, and saved preference normalization")
