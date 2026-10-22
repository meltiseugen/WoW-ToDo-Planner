local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
local function loadAddon(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function manifest(path) assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path) end
local reads, mapID, scans, messages = 0, 200, 0, 0
C_Map = {
    GetBestMapForUnit = function(unit)
        assert(unit == "player")
        reads = reads + 1
        return mapID
    end,
    GetMapInfo = function(id)
        local maps = {
            [200] = { name = "Test Subzone", mapType = 5, parentMapID = 100 },
            [100] = { name = "Test Zone", mapType = 3, parentMapID = 10 },
            [10] = { name = "Continent", mapType = 2, parentMapID = 1 },
            [300] = { name = "Other Zone", mapType = 3, parentMapID = 10 },
        }
        return maps[id]
    end,
}
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
loadAddon("Integrations/CollectionTaskProgress.lua")
loadAddon("Integrations/NearbyCollections.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
TDP.Utils.Msg = function() messages = messages + 1 end

local catalog = TDP.PatchCatalog
catalog.patches = {
    ["1.0"] = {
        mounts = { { spellId = 910001 }, { spellId = 910002 }, { spellId = 910003 } },
        pets = { { speciesId = 910004 } },
        toys = { { itemId = 910005 } },
        cosmetics = { { itemId = 910006 } },
        achievements = { ids = { 910007 } },
    },
    ["12.1.5"] = {
        mounts = { { spellId = 910008 }, { spellId = 910009 }, { spellId = 910010 } },
        toys = { { itemId = 910011 } },
        achievements = { ids = {} },
    },
}
local locations = {
    [910001] = { "/way #200 50 50 Exact", "/way #100 20 20 Duplicate location" },
    [910002] = { "/way #300 50 50 Elsewhere" },
    [910003] = { "/way #10 50 50 Whole continent" },
    [910004] = { "/way #100 50 50 Parent zone" },
    [910005] = { "/way #200 50 50 Toy" },
    [910006] = { "/way #100 50 50 Cosmetic" },
    [910007] = { "/way #200 50 50 Achievement" },
    [910008] = { "/way #100 50 50 Collected mount" },
    [910009] = { "invalid waypoint" },
    -- 910010 has no known location.
    [910011] = { "/way #100 50 50 Retired toy" },
}
local scanner = TDP.CollectionScanner
catalog.GetCollectionWaypoints = function(_, kind, _, entry)
    return locations[scanner:GetEntryKey(kind, entry)]
end
scanner.GetState = function(_, kind, entry)
    local id = scanner:GetEntryKey(kind, entry)
    return { name = "Entry " .. id, collected = id == 910008 }
end
scanner.GetDisplayName = function(_, _, _, state) return state.name end
catalog.IsCollectionUnobtainable = function(_, kind, _, entry)
    return scanner:GetEntryKey(kind, entry) == 910011
end
local originalScan = TDP.NearbyCollections.Scan
TDP.NearbyCollections.Scan = function(self)
    scans = scans + 1
    return originalScan(self)
end

local function equal(actual, expected, label)
    assert(actual == expected, label .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local passed = 0
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function click(button) button:GetScript("OnClick")(button) end
local window = TDP.CollectionExplorerWindow:New()

test("opening Collections does not read the player location or scan nearby entries", function()
    window:Build()
    window:Open()
    equal(reads, 0, "map reads")
    equal(scans, 0, "nearby scans")
    assert(window.nearbyButton and window.typeTabs.all)
    equal(window.browseButton:IsShown(), false, "Browse hidden")
end)

test("Nearby captures all five types across patches and excludes distant or unknown locations", function()
    window.selectedExpansion, window.selectedPatch = "12", "12.1.5"
    window.selectedCollectionType = "mounts"
    window.searchEdit:SetText("saved search")
    window:SetSelectedStatus("all")
    click(window.nearbyButton)
    equal(reads, 1, "one location lookup")
    equal(scans, 1, "one nearby scan")
    equal(window.nearbySnapshot.mapID, 200, "captured map")
    equal(window.selectedCollectionType, "all", "all types selected")
    equal(#window.visibleRows, 7, "nearby entries, including collected and retired")
    equal(window.nearbySnapshot.total, 7, "snapshot count")
    equal(#window:GetSelectedPatchKeys(), 2, "all matching patches")
    equal(window.searchEdit:GetText(), "", "old search cleared")
    local found = {}
    for _, row in ipairs(window.visibleRows) do found[row.collectionType] = true end
    for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics", "achievements" }) do
        assert(found[kind], "missing nearby type: " .. kind)
    end
    equal(window.browseButton:IsShown(), true, "Browse available")
    assert(window.summaryText:GetText():find("Test Subzone", 1, true))
end)

test("movement, Refresh, reopening, and collection events never rescan location", function()
    mapID = 300
    window:Render()
    click(window.refreshButton)
    window:Open()
    local registered = {}
    TDP.EventFrame = CreateFrame("Frame")
    TDP.EventFrame.RegisterEvent = function(_, event) registered[event] = true end
    loadAddon("Core/Bootstrap.lua")
    TDP.Bootstrap:RegisterCollectionCacheEvents()
    TDP.explorerWindow = window
    TDP.Bootstrap:RefreshCollectionCache()
    TDP.EventFrame:GetScript("OnEvent")(TDP.EventFrame, "ZONE_CHANGED")
    equal(registered.ZONE_CHANGED, nil, "no subzone listener")
    equal(registered.ZONE_CHANGED_INDOORS, nil, "no indoor listener")
    equal(registered.ZONE_CHANGED_NEW_AREA, nil, "no zone listener")
    equal(reads, 1, "no location lookup")
    equal(scans, 1, "no rescan")
    equal(window.nearbySnapshot.mapID, 200, "snapshot location stays fixed")
    equal(#window.visibleRows, 7, "original results retained")
    equal(messages, 0, "no chat reminders")
end)

test("type, status, and search filters operate on the captured nearby list", function()
    click(window.typeTabs.pets)
    equal(#window.visibleRows, 1, "pet filter")
    click(window.typeTabs.all)
    window:SetSelectedStatus("missing")
    equal(#window.visibleRows, 5, "missing excludes collected and retired")
    window.searchEdit:SetText("Classic")
    window.searchEdit:GetScript("OnTextChanged")()
    equal(#window.visibleRows, 5, "search uses each row's expansion")
    window.searchEdit:SetText("910007")
    window.searchEdit:GetScript("OnTextChanged")()
    equal(#window.visibleRows, 1, "search within nearby results")
    equal(window.visibleRows[1].collectionType, "achievements", "matching achievement")
    equal(reads, 1, "filters do not read position")
end)

test("existing Map and Favorite actions work on nearby entries", function()
    local row = window.visibleRows[1]
    local payload
    TDP.collectionMapWindow = { Open = function(_, value) payload = value end }
    window:OpenCollectionMap(row)
    equal(payload.pins[1].mapID, 200, "original map pin")
    window:ToggleFavorite(row)
    assert(TDP.Favorites:IsFavorite(row.patchKey, row.collectionType, row.entry), "favorite saved")
    equal(reads, 1, "actions do not read position")
end)

test("a second Nearby click captures the new location and Browse restores catalog choices", function()
    click(window.nearbyButton)
    equal(reads, 2, "second location lookup")
    equal(scans, 2, "second scan")
    equal(window.nearbySnapshot.mapID, 300, "new location")
    equal(#window.visibleRows, 1, "new zone results")
    click(window.browseButton)
    equal(window.nearbySnapshot, nil, "nearby mode cleared")
    equal(window.selectedCollectionType, "mounts", "previous type restored")
    equal(window.selectedExpansion, "12", "previous expansion retained")
    equal(window.selectedPatch, "12.1.5", "previous patch retained")
    equal(window.searchEdit:GetText(), "saved search", "previous search restored")
    equal(reads, 2, "Browse does not read position")
end)

test("unavailable maps and empty zones show useful empty states without chat", function()
    local previousMessages = messages
    mapID = nil
    click(window.nearbyButton)
    equal(#window.visibleRows, 0, "unknown map has no unrelated rows")
    assert(window.emptyText:IsShown() and window.emptyText:GetText():find("unavailable", 1, true))
    mapID = 900
    click(window.nearbyButton)
    equal(#window.visibleRows, 0, "unmapped area")
    equal(window.emptyText:GetText(), "No catalog locations found for this area.", "empty zone message")
    equal(messages, previousMessages, "no chat output")
    C_Map.GetBestMapForUnit = function() error("map temporarily unavailable") end
    click(window.nearbyButton)
    assert(window.nearbySnapshot.error, "map API failure handled")
end)

print(string.format("Nearby collections tests: %d passed, 0 failed", passed))
