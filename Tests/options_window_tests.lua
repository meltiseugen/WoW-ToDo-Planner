local root = arg and arg[1] or "."
local create = assert(loadfile(root .. "/Tests/support/options_ui.lua"))()
local window, TDP = create(root)
local function equal(actual, expected, message)
    assert(actual == expected, message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function click(button) button:GetScript("OnClick")(button) end

TODOPlannerDB.tasks = { { id = 71, title = "Keep this task" } }
TODOPlannerDB.favorites = { saved = true }
TODOPlannerDB.characters = { main = { level = 80 } }
local settings = TODOPlannerDB.settings
local tasks, favorites, characters = TODOPlannerDB.tasks, TODOPlannerDB.favorites, TODOPlannerDB.characters
settings.collectionStatusFilter = "all"
settings.collectionSourceFilters = { rare = true }
local sourceFilters = settings.collectionSourceFilters

window.searchInput:SetText("Botanical")
equal(window.resultText:GetText(), "1 matching setting", "skin names searchable")
equal(window.rows.visualTheme:IsShown(), true, "matching theme visible")
equal(window.rows.worldMapPinScale:IsShown(), false, "unrelated setting hidden")
equal(window.resetButton:IsEnabled(), false, "page reset disabled for global results")
window.searchInput:SetText("3 of 8")
equal(window.rows.useProgressBars:IsShown(), true, "examples searchable")
window.searchInput:SetText("no-such-setting")
equal(window.emptyText:IsShown(), true, "empty search feedback")
click(window.pages.maps.button)
equal(window.searchInput:GetText(), "", "navigation clears search")
equal(window.selectedPage, "maps", "navigation selects page")
print("PASS: global search, examples, no results, navigation, and reset availability")

local mapRefreshes, detailRefreshes = 0, 0
TDP.collectionMapWindow = { projectedPayload = {}, RefreshWorldMapProjection = function() mapRefreshes = mapRefreshes + 1 end }
window.ui.detailWindow = { frame = { IsShown = function() return true end, UpdateNotesLayout = function() detailRefreshes = detailRefreshes + 1 end } }
local scale = window.rows.worldMapPinScale
scale.input:SetText("250"); scale.input:GetScript("OnEnterPressed")(scale.input)
equal(settings.worldMapPinScale, 2.5, "percent entry")
equal(mapRefreshes, 1, "existing projection updated")
window:SetWorldMapPinScale(99)
equal(settings.worldMapPinScale, 3, "upper clamp")
equal(scale.up:IsEnabled(), false, "upper limit disabled")
window:SetWorldMapPinScale(0.1)
equal(settings.worldMapPinScale, 0.75, "lower clamp")
equal(scale.down:IsEnabled(), false, "lower limit disabled")
scale.input:SetText("invalid"); scale.input:GetScript("OnEnterPressed")(scale.input)
equal(scale.input:GetText(), "75", "invalid input restored")
scale.input:SetText("220"); scale.input:GetScript("OnEscapePressed")(scale.input)
equal(settings.worldMapPinScale, 0.75, "escape cancels input")
click(scale.reset)
equal(settings.worldMapPinScale, 1.6, "individual scale reset")
click(window.rows.useProgressBars.text)
equal(settings.useProgressBars, false, "text mode saved")
equal(detailRefreshes, 1, "open details updated")
equal(window.rows.useProgressBars.track:IsShown(), false, "text sample hides bar")
print("PASS: percentage entry, bounds, invalid input, cancellation, and live setting callbacks")

window:SetVisualTheme("quietBotanical")
equal(TDP.Theme.key, "midnight", "preview leaves active theme intact")
equal(window.reloadButton:IsEnabled(), true, "pending reload enabled")
equal(#window.rows.visualTheme.cards, 6, "all six skin previews")
window:SelectPage("achievements")
click(window.resetButton)
equal(settings.useProgressBars, false, "reset requires second click")
click(window.pages.maps.button)
equal(window.resetPending, nil, "navigation cancels reset")
window:SelectPage("achievements")
click(window.resetButton); click(window.resetButton)
equal(settings.useProgressBars, true, "page default restored")
equal(settings.visualTheme, "quietBotanical", "other page retained")
equal(TODOPlannerDB.tasks, tasks, "tasks preserved")
equal(TODOPlannerDB.favorites, favorites, "favorites preserved")
equal(TODOPlannerDB.characters, characters, "characters preserved")
equal(settings.collectionSourceFilters, sourceFilters, "collection filters preserved")
equal(settings.collectionStatusFilter, "all", "collection status preserved")
print("PASS: isolated previews and confirmed page reset preserve saved data and other preferences")

settings.minimapButton = { hidden = false, angle = 92 }
window:SelectPage("windows")
click(window.rows.minimapButton.control)
equal(settings.minimapButton.hidden, true, "minimap visibility saved")
equal(settings.minimapButton.angle, 92, "minimap position preserved")
click(window.resetButton); click(window.resetButton)
equal(settings.minimapButton.hidden, false, "windows reset restores shortcut")
settings.framePositions.explorer = { point = "TOPLEFT", x = 700, y = -400 }
click(window.rows.resetPositions.control)
equal(settings.framePositions.explorer.x, 0, "closed window position reset")
equal(settings.framePositions.options.x, 0, "options position reset")
equal(settings.minimapButton.angle, 92, "recovery preserves minimap angle")
window.frame:SetSize(1120, 810)
window:SelectPage("maps")
local rebuilt = TDP.OptionsWindow:New({})
rebuilt:Open()
equal(rebuilt.frame:GetWidth(), 1120, "resized width restored")
equal(rebuilt.frame:GetHeight(), 810, "resized height restored")
equal(rebuilt.selectedPage, "maps", "selected page restored")
local help = rebuilt.rows.worldMapPinScale.help
help:GetScript("OnEnter")(help)
assert(table.concat(GameTooltip.lines, " "):find("Default: 160%%"), "tooltip includes default")
rebuilt.frame:Hide()
equal(GameTooltip.shown, false, "closing hides tooltip")
equal(rebuilt.resetPending, nil, "closing cancels pending reset")
print("PASS: minimap visibility, window recovery, saved size/page, help, and close cleanup")

window:SelectPage("logging")
local messages = {}
DEFAULT_CHAT_FRAME = { AddMessage = function(_, text) messages[#messages + 1] = text end }
click(window.rows.testChatLogging.control)
equal(#messages, 1, "test chat delivers")
click(window.rows.enableChatLogging.control)
equal(settings.enableChatLogging, false, "master chat toggle saved")
equal(window.rows.chatLogWarnings.control:IsEnabled(), false, "category disabled while muted")
equal(window.rows.testChatLogging.control:IsEnabled(), false, "test disabled while muted")
local loggingHelp = window.rows.chatLogWarnings.help
loggingHelp:GetScript("OnEnter")(loggingHelp)
assert(table.concat(GameTooltip.lines, " "):find("Enable chat logging", 1, true), "disabled reason in help")
click(window.rows.testChatLogging.control)
equal(#messages, 1, "muted test produces no output")
equal(settings.chatLogWarnings, true, "muting preserves category")
click(window.resetButton); click(window.resetButton)
equal(settings.enableChatLogging, true, "logging page reset restores master")
equal(settings.chatLogStartup, false, "logging page reset restores quiet startup")
equal(settings.chatLogNavigation, false, "logging page reset restores quiet navigation")
equal(settings.visualTheme, "quietBotanical", "logging reset preserves selected skin")
DEFAULT_CHAT_FRAME = nil
print("PASS: Logging controls, test output, disabled reasons, and isolated reset")

local layouts = 0
for _, skin in ipairs(TDP.Constants.VISUAL_THEME_OPTIONS) do
    local options, addon, mock = create(root, skin)
    options.frame:SetSize(860, 540)
    assert(options.scrollFrame:GetHeight() > 200, "usable viewport at minimum height")
    assert(options.scrollFrame:GetVerticalScrollRange() > 0, "small windows can scroll the skin gallery")
    for _, width in ipairs({ 860, 1000, 1400 }) do
        options.frame:SetSize(width, 720)
        for _, page in ipairs(options.PageDefinitions) do
            options:SelectPage(page.id)
            for _, row in pairs(options.rows) do
                if row:IsShown() then
                    assert(row:GetWidth() >= 400, "usable content width at " .. skin .. "/" .. width)
                    if row.cards then
                        for _, card in ipairs(row.cards) do
                            assert(card:GetWidth() >= 195, "readable skin cards")
                            local x, w = card:Bounds("x")
                            local rx, rw = row:Bounds("x")
                            assert(x >= rx and x + w <= rx + rw + 0.01, "skin card within row")
                        end
                    end
                    local _, height = row:Bounds("y")
                    assert(height > 60, "row expands to fit its controls")
                end
            end
            if OPTIONS_UI_EXPORT then OPTIONS_UI_EXPORT(options, addon, mock.widgets, skin, width, page.id) end
            layouts = layouts + 1
        end
    end
end
print("PASS: " .. layouts .. " options layouts across all six skins and three window widths")
