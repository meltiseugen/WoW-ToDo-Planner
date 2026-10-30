local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
local function load(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function manifest(path) assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path) end
load("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
load("Core/Constants.lua")
load("Core/Utils.lua")
load("Core/Theme.lua")
load("Data/Persistence/BoardManager.lua")
load("Data/Persistence/TaskRepository.lua")
load("Data/Persistence/Database.lua")
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
load("Data/Persistence/Favorites.lua")
load("Integrations/CollectionScanner.lua")
load("Integrations/NearbyCollections.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local catalog, done = TDP.PatchCatalog, {}
local passed = 0
local function test(name, callback)
    done = {}
    C_QuestLog = { IsQuestFlaggedCompleted = function(id) return done[id] == true end }
    catalog:ResetCollectionSourceCache()
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local fields = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }
local function entry(kind, patch, id)
    for _, value in ipairs(catalog:GetEntries(patch, kind)) do
        if (type(value) == "table" and value[fields[kind]] or value) == id then return value end
    end
    error("Missing fixture " .. id)
end
local function row(kind, patch, id)
    return { collectionType = kind, patchKey = patch, entry = entry(kind, patch, id), name = "Test collection" }
end

test("coordinate guides have working Map actions in Collections and Favorites", function()
    local explorer, favorites = TDP.CollectionExplorerWindow:New(), TDP.FavoritesWindow:New()
    local calls = {}
    TDP.collectionMapWindow = { Open = function(_, payload) calls[#calls + 1] = payload end }
    for _, case in ipairs({
        { "mounts", "10.1", 408651 }, { "mounts", "10.1.7", 424082 }, { "mounts", "10.2", 428060 },
        { "mounts", "11.0", 448979 }, { "mounts", "11.1.5", 428068 }, { "mounts", "11.1.5", 1218317 },
        { "toys", "10.1", 206008 }, { "toys", "11.1.5", 239007 }, { "toys", "11.1.5", 239018 },
        { "pets", "11.2.5", 4801 }, { "pets", "11.2.5", 4802 }, { "toys", "11.2.5", 131717 },
    }) do
        local data = row(unpack(case))
        for _, window in ipairs({ explorer, favorites }) do
            assert(window:IsCollectionMapRow(data) == true, "Missing map action for " .. case[3])
            window:OpenCollectionMap(data)
            local payload = calls[#calls]
            assert(payload and (#payload.pins > 0 or payload.areaOnly), "Button must open a destination")
        end
    end
    assert(#calls == 24)
    TDP.collectionMapWindow = nil
end)

test("multi-stage guides retain every described destination", function()
    local payload = catalog:GetCollectionMapPayload("mounts", "10.1.7", entry("mounts", "10.1.7", 424082))
    local maps = {}
    for _, pin in ipairs(payload.pins) do maps[pin.mapID] = true end
    assert(#payload.pins == 5 and maps[210] and maps[77] and maps[17] and maps[2112])
    local parts = catalog:GetCollectionMapPayload("mounts", "11.0", entry("mounts", "11.0", 448186))
    assert(parts.pins[1].mapID == 2214 and parts.pins[1].label:find("crafting parts", 1, true))
end)

test("fishing zones use area navigation and never fabricate a central pin", function()
    local fish = entry("pets", "5.2", 1207)
    local payload = catalog:GetCollectionMapPayload("pets", "5.2", fish)
    assert(payload.areaOnly and #payload.pins == 0 and #payload.sourceAreaMaps == 3)
    assert(payload.mapID == 554)
    assert(TDP.NearbyCollections:EntryMatches("pets", "5.2", fish, { [554] = true }))
    assert(not TDP.NearbyCollections:EntryMatches("pets", "5.2", fish, { [84] = true }))
end)

test("profession quests retain real quest-chain navigation", function()
    local beacon = entry("toys", "11.2.5", 131717)
    local info = catalog:GetCollectionSourceInfo("toys", "11.2.5", beacon)
    assert(info.kind == "Quest Rewards" and info.rewardQuestID == 41173)
    local payload = catalog:GetCollectionMapPayload("toys", "11.2.5", beacon)
    assert(payload.sourceQuestID and #payload.pins > 0)
    local grotto = entry("mounts", "10.2", 431049)
    info = catalog:GetCollectionSourceInfo("mounts", "10.2", grotto)
    assert(info.rewardQuestID == 76465 and info.questID and #info.waypoints > 0)
    for id in pairs(TDP.CollectionSourceIndex.quests) do if id ~= 76465 then done[id] = true end end
    catalog:ResetCollectionSourceCache(true)
    payload = catalog:GetCollectionMapPayload("mounts", "10.2", grotto)
    assert(payload.sourceQuestID == 76465 and payload.pins[1].mapID == 634)
end)

test("achievement descriptions route to the actual instance entrances", function()
    for _, case in ipairs({ { "7.0.0", 10856 }, { "8.0.0", 12489 }, { "8.0.0", 13007 } }) do
        local payload = catalog:GetCollectionMapPayload("achievements", case[1], case[2])
        assert(payload and #payload.pins > 0)
        for _, pin in ipairs(payload.pins) do assert(pin.label:find("entrance", 1, true)) end
    end
end)

test("arena vendor pins follow the character faction", function()
    local original = UnitFactionGroup
    for _, faction in ipairs({ "Alliance", "Horde" }) do
        UnitFactionGroup = function() return faction end
        catalog:ResetCollectionSourceCache()
        for _, id in ipairs({ 1264621, 1264643 }) do
            local payload = catalog:GetCollectionMapPayload("mounts", "11.2.7", entry("mounts", "11.2.7", id))
            assert(#payload.pins == 1 and payload.pins[1].mapID == (faction == "Alliance" and 500 or 503))
        end
    end
    UnitFactionGroup = original
end)

test("both factions can click the row and preview maps for both Vicious mount variants", function()
    local originalFaction, originalClass, originalRace = UnitFactionGroup, UnitClass, UnitRace
    local explorer, favorites = TDP.CollectionExplorerWindow:New(), TDP.FavoritesWindow:New()
    explorer:Build()
    favorites:Build()
    local opened, calls = nil, 0
    TDP.collectionMapWindow = { Open = function(_, payload) opened = payload; calls = calls + 1 end }
    for _, faction in ipairs({ "Alliance", "Horde" }) do
        UnitFactionGroup = function() return faction end
        UnitClass = function() return "Warrior", "WARRIOR", 1 end
        UnitRace = function() return "Audit", "Audit", faction == "Alliance" and 1 or 2 end
        catalog:ResetCollectionSourceCache()
        for _, case in ipairs({
            { "11.0", 447405, 85, 41.8, 73.0, "Horde" }, { "11.0", 449325, 84, 76.8, 65.6, "Alliance" },
            { "11.1", 466145, 85, 41.8, 73.0, "Horde" }, { "11.1", 466146, 84, 76.8, 65.6, "Alliance" },
        }) do
            local data = row("mounts", case[1], case[2])
            data.name = data.entry.name
            local info = catalog:GetCollectionSourceInfo("mounts", case[1], data.entry)
            if faction == case[6] then assert(info and info.kind == "Vendor", "Saddle sellers must not be drops")
            else assert(not info, "Map fallback must preserve character acquisition restrictions") end
            for _, window in ipairs({ explorer, favorites }) do
                local listRow = window:BuildRow(window.listContent)
                window:UpdateRow(listRow, data, 1, 0)
                assert(listRow.mapButton:IsShown(), faction .. " row has no Map icon for " .. case[2])
                window.selectedRow = data
                window:RenderPreview()
                assert(window.previewMapButton:IsShown() and window.previewMapButton:IsEnabled(), "Preview Map is disabled")
                for _, button in ipairs({ listRow.mapButton, window.previewMapButton }) do
                    opened = nil
                    button:GetScript("OnClick")(button)
                    assert(opened and #opened.pins == 1, "Map click must open a vendor destination")
                    local pin = opened.pins[1]
                    assert(pin.mapID == case[3] and math.abs(pin.x * 100 - case[4]) < 0.01
                        and math.abs(pin.y * 100 - case[5]) < 0.01, "Map must match the displayed guide")
                end
            end
        end
    end
    assert(calls == 32)
    UnitFactionGroup, UnitClass, UnitRace = originalFaction, originalClass, originalRace
    TDP.collectionMapWindow = nil
end)

test("inspecting class and race rewards preserves guide destinations without bypassing eligibility", function()
    local originalFaction, originalClass, originalRace = UnitFactionGroup, UnitClass, UnitRace
    UnitFactionGroup = function() return "Alliance" end
    UnitClass = function() return "Warrior", "WARRIOR", 1 end
    UnitRace = function() return "Human", "Human", 1 end
    catalog:ResetCollectionSourceCache()
    local cases = {
        { "mounts", "10.1", 407555, 2025, 65.7, 12.6 },
        { "pets", "7.2.0", 2035, 648, 54.8, 28.9 },
        { "cosmetics", "5.0", 83080, 85, 68.6, 40.2 },
    }
    for _, case in ipairs(cases) do
        local data = row(case[1], case[2], case[3])
        assert(not catalog:GetCollectionSourceInfo(case[1], case[2], data.entry), "Acquisition restriction was removed")
        local payload = catalog:GetCollectionMapPayload(case[1], case[2], data.entry)
        assert(payload and #payload.pins > 0, "Missing inspection destination")
        local pin = payload.pins[1]
        assert(pin.mapID == case[4] and math.abs(pin.x * 100 - case[5]) < 0.01 and math.abs(pin.y * 100 - case[6]) < 0.01)
    end
    UnitFactionGroup, UnitClass, UnitRace = originalFaction, originalClass, originalRace
end)

test("map capability uses compiled destinations without parsing guide text", function()
    local original = catalog.GetCollectionAcquisitionText
    catalog.GetCollectionAcquisitionText = function() error("Map visibility must not parse the acquisition guide") end
    local jets = entry("mounts", "10.1.7", 424082)
    for _ = 1, 100 do assert(catalog:HasCollectionMapPayload("mounts", "10.1.7", jets)) end
    catalog.GetCollectionAcquisitionText = original
    assert(catalog:GetDescriptionMapLocations("mounts", { spellId = -100 }) == nil)
end)

test("non-spatial event shops and unimplemented species do not gain fake pins", function()
    assert(not catalog:HasCollectionMapPayload("toys", "10.2.6", entry("toys", "10.2.6", 170197)))
    assert(not catalog:HasCollectionMapPayload("pets", "11.0.7", entry("pets", "11.0.7", 4725)))
    assert(catalog:IsCollectionHiddenInUI("mounts", "11.0.7", entry("mounts", "11.0.7", 471696)))
end)
print("Description location tests passed: " .. passed)
