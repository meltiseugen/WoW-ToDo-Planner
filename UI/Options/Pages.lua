local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow

OptionsWindow.ThemeDescriptions = {
    midnight = "Dark panels with warm gold accents.",
    parchment = "Warm parchment with ink and ember details.",
    quietBotanical = "Light paper with soft green botanical details.",
    quietArcane = "Deep blue surfaces with arcane highlights.",
    fieldLedger = "A weathered field journal in brown and brass.",
    minimalVoidglass = "Dark glass with violet highlights.",
}

-- Content and behavior live together; layout and search consume the same definitions.
OptionsWindow.PageDefinitions = {
    {
        id = "appearance", label = "Appearance",
        description = "Choose how your planner and collection windows look.",
        sections = {{ title = "Visual theme", settings = {{
            key = "visualTheme", kind = "theme", label = "Choose a skin",
            description = "Compare all six skins below. Your choice is saved immediately; reload the UI to apply it to every window.",
            details = "Each preview uses that skin's own textures, colors, and font treatment. The surrounding Options window keeps its active skin until you reload.",
            example = "Select Quiet Botanical for a light interface, then press Reload UI.",
            defaultText = "Midnight Classic", default = "midnight", setter = "SetVisualTheme",
        }}}},
    },
    {
        id = "achievements", label = "Achievements",
        description = "Make achievement criteria easy to read in task details.",
        sections = {{ title = "Task details", settings = {{
            key = "useProgressBars", kind = "progress", label = "Criteria progress",
            description = "Show numeric achievement progress as a filled bar or as compact text.",
            details = "Applies immediately to achievement criteria with numeric progress in the task details window. Completed criteria and your saved achievement tasks are kept.",
            example = "For a criterion at 3 of 8, Bars shows a partially filled bar; Text shows 3 / 8.",
            defaultText = "Bars", default = true, setter = "SetProgressBarsEnabled",
        }}}},
    },
    {
        id = "maps", label = "Maps",
        description = "Adjust collection markers on the Blizzard world map.",
        sections = {{ title = "World map markers", settings = {{
            key = "worldMapPinScale", kind = "scale", label = "Blizzard map pin size",
            description = "Make projected collection pins smaller or larger. Changes apply immediately to pins already on the world map.",
            details = "Enter a percentage and press Enter, or use the minus and plus buttons. Range: 75% to 300%. This controls projected Blizzard world map pins; collection coordinates and map zoom stay the same.",
            example = "160% is the default. Try 200% if a collection marker is difficult to see.",
            defaultText = "160%", default = 1.6, setter = "SetWorldMapPinScale",
        }}}},
    },
    {
        id = "windows", label = "Windows",
        description = "Manage your minimap shortcut and recover moved windows.",
        sections = {
            { title = "Minimap shortcut", settings = {{
                key = "minimapButton", kind = "toggle", label = "Show minimap button",
                description = "Keep a shortcut beside the minimap. Left-click opens the planner; right-click opens Options.",
                details = "Drag the minimap button to move it around the edge. Hiding it preserves its saved position. You can always open these settings with /tdp options.",
                example = "Hide the button for a quieter minimap and use /tdp to open the addon.",
                defaultText = "Shown", default = true, setter = "SetMinimapButtonShown",
            }}},
            { title = "Window recovery", settings = {{
                key = "resetPositions", kind = "action", label = "Reset window positions",
                text = "Center windows",
                description = "Return Home, Planner, Explorer, Favorites, Collection Map, and Options to the center of the screen.",
                details = "Replaces the saved positions of these windows, including windows that are currently closed. Your tasks, characters, favorites, filters, and selected skin are kept.",
                example = "Use this after changing monitors or if a window is difficult to reach.",
                action = "ResetMainWindowPosition",
            }}},
        },
    },
}

local loggingPage = {
    id = "logging", label = "Logging",
    description = "Choose which addon messages appear in your default chat frame. Changes apply immediately.",
    sections = {
        { title = "Chat output", settings = {
            {
                key = "enableChatLogging", kind = "check", label = "Enable chat logging",
                description = "Master switch for addon messages, warnings, and command replies.",
                details = "Turning this off silences all Planner chat output, including warnings, /tdp help, and the Test chat button. Your category choices stay saved. It does not stop tasks, collection scanning, or map actions, and it does not create a separate log file.",
                example = "Turn this off for quiet chat, then turn it back on to restore your selected categories.",
                defaultText = "On", default = true, setter = "SetLoggingOption",
            },
            {
                key = "chatLogTimestamps", kind = "check", label = "Show chat timestamps",
                description = "Prefix each message with local time in HH:MM:SS format.",
                details = "Uses the game client's local clock. Turn this off if your chat addon already adds timestamps.",
                example = "14:25:09 TODO Planner [Tasks] Added achievement task...",
                defaultText = "Off", default = false, setter = "SetLoggingOption", disabledWhenMuted = true,
            },
            {
                key = "testChatLogging", kind = "action", label = "Test chat output", text = "Test chat",
                description = "Send one sample message using the master switch and timestamp preference.",
                details = "Tests delivery to your default chat frame. This sample bypasses individual category switches; the master switch must be on. Your tasks and collection state stay the same.",
                example = "Enable chat logging and click Test chat to see a message labeled Test.",
                action = "TestChatOutput", disabledWhenMuted = true,
            },
        }},
        { title = "Message categories", settings = {} },
    },
}
local categoryHelp = {
    startup = { "Startup message", "Show the Loaded reminder at login and after /reload. Off by default.",
        "Controls the existing one-line /tdp reminder when the addon loads.", "Enable this to see the /tdp reminder after each reload." },
    tasks = { "Task & board actions", "Achievement tasks, duplicate-task notices, and board deletion summaries.",
        "Controls existing success and duplicate-task feedback. Failed edits, missing titles, and unavailable achievements use Warnings & errors.", "Keep this on to confirm that an achievement was added to your planner." },
    collections = { "Collection actions", "Favorite additions/removals and collection-task confirmations.",
        "Controls existing collection action messages. It does not add scan summaries or per-item messages. Missing map locations and failed actions use Warnings & errors.", "Turn this off while adding many favorites." },
    navigation = { "Maps & navigation", "Collection map opening confirmations. Off by default.",
        "Controls the existing /tdp maptest opening message. Missing maps and unavailable windows use Warnings & errors. This switch does not add location tracking or waypoint messages.", "Enable this if you want the collection map opening confirmation in chat." },
    warnings = { "Warnings & errors", "Failed actions, unavailable windows, missing locations, and invalid task input.",
        "Keeps actionable problems visible when routine confirmations are off. The master chat switch can silence warnings too. Lua error dialogs and other addons' messages are independent.", "Leave this on to see why a collection entry has no curated map location." },
    commands = { "Command & action replies", "Slash-command help, unknown-command replies, and general action feedback.",
        "Controls /tdp help, unknown commands, window-reset confirmations, and copied Wowhead-link confirmations. Specialized task, collection, navigation, and warning messages use their own categories.", "Leave this on if you use /tdp help to inspect available commands." },
}
for _, category in ipairs(TDP.Constants.CHAT_LOG_CATEGORIES) do
    local help = categoryHelp[category.id]
    local default = TDP.Constants.DEFAULT_DB.settings[category.key]
    local list = loggingPage.sections[2].settings
    list[#list + 1] = {
        key = category.key, kind = "check", label = help[1], description = help[2],
        details = help[3], example = help[4], defaultText = default and "On" or "Off",
        default = default, setter = "SetLoggingOption", disabledWhenMuted = true,
    }
end
OptionsWindow.PageDefinitions[#OptionsWindow.PageDefinitions + 1] = loggingPage

function OptionsWindow:GetPageDefinition(pageID)
    for _, page in ipairs(self.PageDefinitions) do
        if page.id == pageID then return page end
    end
end

function OptionsWindow:SettingMatches(page, section, spec)
    if self.searchText == "" then return true end
    local text = table.concat({ page.label, page.description, section.title, spec.label,
        spec.description, spec.details or "", spec.example or "", spec.defaultText or "" }, " ")
    if spec.kind == "theme" then
        for key, label in pairs(self.Config.VISUAL_THEME_LABELS) do
            text = text .. " " .. label .. " " .. self.ThemeDescriptions[key]
        end
    end
    return text:lower():find(self.searchText, 1, true) ~= nil
end
