local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
local function loadAddon(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function manifest(path) assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path) end
loadAddon("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
loadAddon("Core/Constants.lua")
loadAddon("Core/Utils.lua")
loadAddon("Core/Theme.lua")
loadAddon("Data/Persistence/BoardManager.lua")
loadAddon("Data/Persistence/TaskRepository.lua")
loadAddon("Data/Persistence/Database.lua")
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
loadAddon("Data/Persistence/Favorites.lua")
loadAddon("Integrations/CollectionScanner.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local catalog = TDP.PatchCatalog
local passed = 0
local function test(name, callback)
    TODOPlannerDB = { settings = {} }
    TDP.Database:Init()
    TDP.CollectionScanner:ResetCache()
    catalog.sourceAchievementNames = nil
    GetAchievementInfo = nil
    TDP.collectionMapWindow, TDP.explorerWindow = nil, nil
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function click(button) button:GetScript("OnClick")(button) end
local function windows()
    local home = TDP.HomeWindow:New(TDP)
    local explorer = TDP.CollectionExplorerWindow:New(home)
    local favorites = TDP.FavoritesWindow:New(home)
    home:SetWindows(nil, explorer, favorites)
    explorer:Build()
    favorites:Build()
    return explorer, favorites
end
local function mount(patch, name)
    for _, entry in ipairs(catalog:GetEntries(patch, "mounts")) do
        if entry.name == name then return { collectionType = "mounts", patchKey = patch, entry = entry, name = name } end
    end
    error("Missing mount fixture: " .. patch .. "/" .. name)
end

test("row map shortcuts open the rewarding achievement inside the addon across expansions", function()
    local explorer, favorites = windows()
    local names = { [2136] = "Glory of the Hero", [11163] = "Glory of the Legion Hero",
        [16295] = "Glory of the Dragonflight Hero", [63715] = "Let Me Solo Him: Kindo'jan" }
    GetAchievementInfo = function(id)
        return id, names[id], 10, true, nil, nil, nil, "Achievement description", 0, 123
    end
    local nativeCalls, mapCalls = 0, 0
    TDP.Achievements = { OpenAchievement = function() nativeCalls = nativeCalls + 1 end }
    TDP.collectionMapWindow = { Open = function() mapCalls = mapCalls + 1 end }
    local taskCount = #TODOPlannerDB.tasks
    local savedStatus = TODOPlannerDB.settings.collectionStatusFilter
    for _, window in ipairs({ explorer, favorites }) do
        local row = window:BuildRow(window.listContent)
        for _, case in ipairs({ { "3.0", "Red Proto-Drake", 2136 }, { "7.0.0", "Leyfeather Hippogryph", 11163 },
            { "10.0", "Shellack", 16295 }, { "12.1.5", "Loa-Blessed Wayfarer", 63715 } }) do
            local data = mount(case[1], case[2])
            window:UpdateRow(row, data, 1, 0)
            assert(row.mapButton:IsShown(), "Map shortcut must be visible for " .. case[2])
            if window == explorer then
                assert(row.mapButton.explorerHelpTitle == "View Achievement")
                assert(row.mapButton.helpText:find("TODO-Planner", 1, true))
            end
            explorer.selectedExpansion, explorer.selectedPatch = "1", "1.0"
            explorer.selectedStatus, explorer.selectedAchievementCategory = "missing", "PvP"
            explorer.selectedCollectionType = "mounts"
            explorer.nearbySnapshot = { patchKeys = {}, entries = {} }
            explorer.searchEdit:SetText("unrelated search")
            click(row.mapButton)
            assert(explorer.selectedCollectionType == "achievements")
            assert(explorer.selectedPatch == case[1])
            assert(explorer.selectedRow.entry == case[3] and explorer.frame:IsShown())
            assert(explorer.selectedStatus == "all" and explorer.selectedAchievementCategory == "all")
            assert(explorer.nearbySnapshot == nil and not favorites.frame:IsShown())
        end
    end
    assert(nativeCalls == 0 and mapCalls == 0, "Reward shortcuts must stay inside the addon")
    assert(#TODOPlannerDB.tasks == taskCount and TODOPlannerDB.settings.collectionStatusFilter == savedStatus)
end)

test("faction-restricted achievement mounts keep their achievement action on both factions", function()
    local originalFaction = UnitFactionGroup
    local explorer, favorites = windows()
    local rewards = { [60118] = 614, [60119] = 619, [61996] = 2536, [61997] = 2537,
        [118737] = 6827, [130985] = 6828, [142266] = 8302, [142478] = 8304,
        [193695] = 11474, [204166] = 11474, [295386] = 13517, [295387] = 13517 }
    local checked = 0
    for _, faction in ipairs({ "Alliance", "Horde" }) do
        UnitFactionGroup = function() return faction end
        catalog:ResetCollectionSourceCache()
        for _, patch in ipairs(catalog:GetPatchKeys()) do
            for _, entry in ipairs(catalog:GetEntries(patch, "mounts")) do
                local expected = rewards[entry.spellId]
                if expected then
                    local data = { collectionType = "mounts", patchKey = patch, entry = entry, name = entry.name }
                    for _, window in ipairs({ explorer, favorites }) do
                        assert(window:GetCollectionMapAchievementId(data) == expected, "Reward action lost its achievement")
                        assert(window:OpenCollectionMap(data) == true)
                        assert(explorer.selectedRow.entry == expected, "Action must open the addon's achievement tab")
                        checked = checked + 1
                    end
                end
            end
        end
    end
    assert(checked == 48, "Every faction-specific achievement mount must be checked in both windows")
    UnitFactionGroup = originalFaction
    catalog:ResetCollectionSourceCache()
end)

test("achievement metadata works in every patch and existing mount locations do not override it", function()
    local explorer, favorites = windows()
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        local row = { collectionType = "mounts", patchKey = patch,
            entry = { name = "Test reward", spellId = 999999, sourceAchievementId = 63715 } }
        for _, window in ipairs({ explorer, favorites }) do
            assert(window:IsCollectionMapRow(row) == true, "Missing shortcut in " .. patch)
        end
    end
    -- These real catalog mounts already have locations for their achievement criteria.
    for _, window in ipairs({ explorer, favorites }) do
        for _, case in ipairs({ { "12.0", "Vivacious Chloroceros", 61263 },
            { "12.1.5", "Loa-Blessed Wayfarer", 63715 } }) do
            local data = mount(case[1], case[2])
            assert(catalog:HasCollectionMapPayload("mounts", case[1], data.entry))
            assert(window:GetCollectionMapAchievementId(data) == case[3])
            assert(window:OpenCollectionMap(data) == true)
            assert(explorer.selectedRow.entry == case[3])
        end
    end
end)

test("older faction and journal source descriptions resolve without relying on reward names", function()
    GetAchievementInfo = function(id)
        return id, id == 63715 and "Test Goal" or "Other " .. id
    end
    for _, source in ipairs({ "Test Goal for Alliance", "Test Goal for Horde",
        "Test Goal on a Horde account", "Test Goal on an Alliance account",
        "the Horde Test Goal achievement", "the Alliance Test Goal achievement",
        "Test Goal (300 mounts)", "Achievement: Test Goal / Category: Mounts",
        "Achievement: Test Goal Category: Legion" }) do
        assert(catalog:GetCollectionSourceAchievementId("mounts", "12.1.5",
            { name = "Test reward", sourceType = "Achievement", source = source }) == 63715, source)
    end
    assert(catalog:GetCollectionSourceAchievementId("mounts", "12.1.5",
        { name = "Test vendor", sourceType = "Vendor", source = "Merchant", mapAchievementId = 63715 }) == nil)
end)

test("mounts with generic catalog sources use exact achievement rewards", function()
    GetAchievementInfo = function(id)
        return id, "Goal " .. id, 10, false, nil, nil, nil, "Description", 0, 123,
            id == 63715 and "Mount: Test reward" or ""
    end
    local explorer = TDP.CollectionExplorerWindow:New()
    local data = { collectionType = "mounts", patchKey = "12.1.5",
        entry = { name = "Test reward", sourceType = "Patch mount collection", source = "Patch collection" } }
    assert(explorer:GetCollectionMapAchievementId(data) == 63715)
    assert(explorer:IsCollectionMapRow(data) == true)
    assert(catalog:GetCollectionSourceAchievementId("mounts", "12.1.5",
        { name = "Vendor mount", sourceType = "Vendor", source = "Merchant (63715)" }) == nil)
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5", data.entry) == nil,
        "Generic reward discovery is limited to mounts")
end)

test("reused row shortcuts and preview actions switch between achievement and map destinations", function()
    local explorer, favorites = windows()
    local mapPayloads, nativeCalls = {}, 0
    TDP.collectionMapWindow = { Open = function(_, payload) mapPayloads[#mapPayloads + 1] = payload end }
    TDP.Achievements = { OpenAchievement = function() nativeCalls = nativeCalls + 1 end }
    for _, window in ipairs({ explorer, favorites }) do
        local row = window:BuildRow(window.listContent)
        local reward = mount("12.1.5", "Loa-Blessed Wayfarer")
        window:UpdateRow(row, reward, 1, 0)
        window.selectedRow = reward
        window:RenderPreview()
        assert(window.previewMapButton:IsShown() and window.previewMapButton.label:GetText() == "Achievement")
        click(window.previewMapButton)
        assert(explorer.selectedCollectionType == "achievements" and explorer.selectedRow.entry == 63715)
        local vendorEntry = catalog:GetEntries("12.1.5", "mounts")[1]
        local vendor = { collectionType = "mounts", patchKey = "12.1.5", name = vendorEntry.name, entry = vendorEntry }
        window:UpdateRow(row, vendor, 1, 0)
        assert(row.mapButton:IsShown())
        if window == explorer then assert(row.mapButton.explorerHelpTitle == "Vendor Map") end
        click(row.mapButton)
        assert(mapPayloads[#mapPayloads].collectionType == "mounts" and #mapPayloads[#mapPayloads].pins > 0)
        window.selectedRow = vendor
        window:RenderPreview()
        assert(window.previewMapButton.label:GetText() == (window == explorer and "Open Map" or "Map"))
        click(window.previewMapButton)
        local noLocation = { collectionType = "mounts", patchKey = "unused", name = "Unknown mount",
            entry = { spellId = 999997, name = "Unknown mount" } }
        window:UpdateRow(row, noLocation, 1, 0)
        assert(not row.mapButton:IsShown(), "Reused rows must hide missing destinations")
        local achievement = { collectionType = "achievements", patchKey = "12.1.5", entry = 63715, name = "Goal" }
        window:UpdateRow(row, achievement, 1, 0)
        assert(row.mapButton:IsShown(), "Achievement rows retain their actual maps")
        click(row.mapButton)
        assert(mapPayloads[#mapPayloads].collectionType == "achievements")
        assert(window:GetCollectionMapAchievementId({ collectionType = "pets", patchKey = "12.1.5",
            entry = { sourceAchievementId = 63715 } }) == nil, "Only mount map shortcuts change")
    end
    assert(#mapPayloads == 6 and nativeCalls == 0)
end)

test("Favorites shortcuts use the addon explorer when there is no home window", function()
    local explorer = TDP.CollectionExplorerWindow:New()
    TDP.explorerWindow = explorer
    local favorites = TDP.FavoritesWindow:New()
    assert(favorites:OpenCollectionMap(mount("12.1.5", "Loa-Blessed Wayfarer")) == true)
    assert(explorer.selectedCollectionType == "achievements" and explorer.selectedRow.entry == 63715)
end)

print("Achievement mount navigation tests passed: " .. passed)
