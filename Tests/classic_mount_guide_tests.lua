local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
assert(loadfile(root .. "/Core/Constants.lua"))("TODO-Planner", TDP)
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP,
    "UI/Widgets/Widgets.xml", "UI/CollectionMap/CollectionMap.xml")
local catalog, passed = TDP.PatchCatalog, 0
TODOPlannerDB = { settings = {} }
GameTooltip = CreateFrame("Frame")
C_Map = {
    GetMapInfo = function(id) return { name = TDP.CatalogMapNames[id] or tostring(id) } end,
    GetMapArtLayers = function() return {{ layerWidth = 1000, layerHeight = 500, tileWidth = 1000, tileHeight = 500 }} end,
    GetMapArtLayerTextures = function() return { 1 } end,
}
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function entry(patch, id)
    for _, value in ipairs(catalog:GetEntries(patch, "mounts")) do
        if value.spellId == id then return value end
    end
    error("Missing mount " .. id)
end
local function payload(patch, id)
    return assert(catalog:GetCollectionMapPayload("mounts", patch, entry(patch, id)))
end

test("all 85 Classic mount entries expose Retail numbered guides and valid map buttons", function()
    local total = 0
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        if patch:match("^1%.") then
            for _, mount in ipairs(catalog:GetEntries(patch, "mounts")) do
                total = total + 1
                local guide = assert(catalog:GetCollectionWalkthrough("mounts", mount))
                local text = catalog:GetMountAcquisitionText(patch, mount)
                assert(text == guide.acquisition and text == mount.acquisition)
                assert(text == catalog:GetMountDetails(patch, mount).acquisition)
                assert(text:match("^1%. ") and not text:lower():find("profit", 1, true))
                for step = 2, guide.stepCount do assert(text:find("\n\n" .. step .. ". ", 1, true)) end
                assert(catalog:HasCollectionMapPayload("mounts", patch, mount))
                local map = payload(patch, mount.spellId)
                assert(#map.pins > 0 and #map.guideMaps > 0)
                assert(not map.sourceQuestID, "Reviewed route must not be replaced by a stale generic quest source")
                for _, pin in ipairs(map.pins) do
                    assert(pin.step >= 1 and pin.step <= guide.stepCount)
                    assert(pin.x >= 0 and pin.x <= 1 and pin.y >= 0 and pin.y <= 1)
                    assert(TDP.CatalogMapNames[pin.mapID], "Unknown Retail map: " .. tostring(pin.mapID))
                end
            end
        end
    end
    assert(total == 85)
end)

test("current Retail routes replace wrong vendors currency and historical raid destinations", function()
    local stallion = payload("1.0", 470)
    assert(stallion.sourceSummary:find("Katie Stokx", 1, true))
    local tiger = payload("1.7", 24252)
    assert(tiger.pins[1].mapID == 2393 and tiger.sourceSummary:find("Black Market", 1, true))
    assert(catalog:GetCollectionFaction("mounts", "1.7", entry("1.7", 24252)) == "all",
        "A neutral mount must not become Horde-only because its guide visits Silvermoon")
    assert(catalog:GetResearchedCollectionSourceKind("mounts", "1.7", entry("1.7", 24252)) == "Black Market")
    assert(catalog:GetMountDetails("1.7", entry("1.7", 24252)).sourceType == "Black Market")
    local frostwolf, stormpike = payload("1.5", 23509), payload("1.5", 23510)
    assert(frostwolf.cost == "15 Mark of Honor" and stormpike.cost == "15 Mark of Honor")
    assert(#frostwolf.pins == 1 and frostwolf.pins[1].label:find("Jorek", 1, true))
    assert(#stormpike.pins == 1 and stormpike.pins[1].label:find("Thanthaldis", 1, true))
    local saber = payload("1.0", 17229)
    assert(saber.acquisition:find("Bobadormu", 1, true) and saber.acquisition:find("20 whiskers", 1, true))
    local deathcharger = payload("1.0", 17481)
    assert(deathcharger.acquisition:find("Thuzadin Acolyte", 1, true))
    assert(math.abs(deathcharger.pins[1].x - 0.433) < 0.0001)
    assert(payload("1.0", 16082).acquisition:find("retired in Retail", 1, true))
end)

test("same-map guide pins share one dropdown entry and keep their actual step numbers", function()
    local map = payload("1.0", 470)
    assert(#map.guideMaps == 2 and #map.pins == 3)
    local window = TDP.CollectionMapWindow:New()
    window:Open(map)
    assert(window.sourceAreaButton:IsShown())
    assert(window.sourceAreaButton:GetText() == "Stormwind City - Steps 2, 4")
    assert(window.pinFrames[1].stepText:GetText() == "2")
    assert(window.pinFrames[2].stepText:GetText() == "4")
    local labels, selected = {}, nil
    local original = TDP.Widgets.ShowSingleSelectMenu
    TDP.Widgets.ShowSingleSelectMenu = function(_, _, maps, current, label, select)
        assert(#maps == 2 and current == 84)
        for _, id in ipairs(maps) do labels[#labels + 1] = label(id) end
        selected = select
    end
    window.sourceAreaButton:GetScript("OnClick")(window.sourceAreaButton)
    TDP.Widgets.ShowSingleSelectMenu = original
    assert(labels[2] == "Netherstorm - Step 3")
    window.zoom, window.panX, window.panY = 3, 50, 75
    selected(109)
    assert(window.mapID == 109 and window.zoom == 1 and window.panX == 0 and window.panY == 0)
    assert(window.sourceAreaButton:GetText() == "Netherstorm - Step 3")
    assert(window.pinFrames[1].stepText:GetText() == "3" and not window.pinFrames[2]:IsShown())
    assert(window:BuildDetailsText():find("Step 4: Katie Stokx", 1, true))
end)

test("one-map walkthroughs retain a selector and reopening clears stale guide controls and badges", function()
    local window = TDP.CollectionMapWindow:New()
    window:Open(payload("1.9", 26054))
    assert(window.sourceAreaButton:IsShown())
    assert(window.pinFrames[1].stepText:GetText() == "1")
    window:Open({ mapID = 84, pins = {{ mapID = 84, x = 0.5, y = 0.5 }} })
    assert(not window.sourceAreaButton:IsShown())
    assert(window.guideMaps == nil and window.pinFrames[1].stepText:GetText() == "")
    window:Open({ mapID = 84, areaOnly = true, sourceAreaMaps = {84, 85}, pins = {} })
    assert(window.sourceAreaButton:IsShown() and window.sourceAreaButton:GetText() == "Stormwind City")
end)

test("repeated visits to the same guide location share a readable numbered pin", function()
    local window = TDP.CollectionMapWindow:New()
    window:Open(payload("1.0", 17229))
    window.mapID = 83
    window:RenderMap()
    assert(window.sourceAreaButton:GetText() == "Winterspring - Steps 2, 5, 6")
    assert(window.pinFrames[1].stepText:GetText() == "2/5/6")
    assert(window.pins[2].steps[3] == 6)
    assert(window:BuildDetailsText():find("Steps 2, 5, 6:", 1, true))
    local saved = window:CopyProjectionPayload()
    assert(saved.allPins[2].steps[3] == 6)
end)

test("projection save and restore preserve map groups step labels and clear recycled pin badges", function()
    local window = TDP.CollectionMapWindow:New()
    window:Open(payload("1.0", 470))
    local copy = window:CopyProjectionPayload()
    assert(copy.guideMaps[1] == 84 and copy.allPins[1].step == 2 and copy.allPins[3].step == 4)
    window:Open(copy)
    assert(window.sourceAreaButton:GetText() == "Stormwind City - Steps 2, 4")
    local pin = window:CreateWorldMapPin(1)
    window:ConfigureWorldMapPin(pin, copy.allPins[1], copy)
    assert(pin.step == 2 and pin.stepText:GetText() == "2")
    window:ConfigureWorldMapPin(pin, { mapID = 84, x = 0.3, y = 0.4 }, { title = "Unnumbered" })
    assert(pin.step == nil and pin.stepText:GetText() == "")
end)

print("Classic Retail mount guide tests: " .. passed .. " passed")
