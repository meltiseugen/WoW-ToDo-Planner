local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
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
local function entry(id)
    local patch = (id == 64 or id == 65 or id == 106) and "1.6" or "1.0"
    for _, pet in ipairs(catalog:GetEntries(patch, "pets")) do
        if pet.speciesId == id then return pet, patch end
    end
    error("Missing Classic pet " .. id)
end
local function payload(id)
    local pet, patch = entry(id)
    return assert(catalog:GetCollectionMapPayload("pets", patch, pet))
end

test("all 36 Classic species expose the reviewed text source category and working map payload", function()
    local total = 0
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        if patch:match("^1%.") then
            for _, pet in ipairs(catalog:GetEntries(patch, "pets")) do
                total = total + 1
                local guide = assert(catalog:GetCollectionWalkthrough("pets", pet))
                local details = catalog:GetPetDetails(patch, pet)
                local text = catalog:GetPetAcquisitionText(patch, pet)
                assert(text == guide.acquisition and text == pet.acquisition and text == details.acquisition)
                assert(text:match("^1%. ") and not text:lower():find("profit", 1, true))
                for step = 2, guide.stepCount do assert(text:find("\n\n" .. step .. ". ", 1, true)) end
                assert(catalog:GetPetSourceSummary(patch, pet) == guide.source)
                assert(catalog:GetResearchedCollectionSourceKind("pets", patch, pet) == guide.category)
                assert(details.sourceType == guide.category)
                local info = catalog:GetCollectionSourceInfo("pets", patch, pet)
                assert(info.kind == guide.category and info.source == guide.source)
                assert(info.acquisition == text and info.walkthrough)
                assert(catalog:GetCollectionSourceCost("pets", patch, pet) == guide.cost)
                assert(#catalog:GetCollectionSourceNotes("pets", patch, pet, true) == 0,
                    "Old imported source instructions must not precede the reviewed guide")
                assert(catalog:GetCollectionFaction("pets", patch, pet) == "all")
                assert(not catalog:IsCollectionUnobtainable("pets", patch, pet))
                assert(catalog:HasCollectionMapPayload("pets", patch, pet))
                local map = payload(pet.speciesId)
                assert(#map.pins > 0 and #map.guideMaps > 0 and not map.sourceQuestID)
                assert(map.sourceSummary == guide.source and map.acquisition == text)
                for _, pin in ipairs(map.pins) do
                    assert(TDP.CatalogMapNames[pin.mapID], "Unknown Retail map " .. pin.mapID)
                    assert(pin.step >= 1 and pin.step <= guide.stepCount)
                    assert(pin.x >= 0 and pin.x <= 1 and pin.y >= 0 and pin.y <= 1)
                end
                assert(catalog:GetWowheadUrl("pets", pet) == "https://www.wowhead.com/item=" .. guide.itemId)
            end
        end
    end
    assert(total == 36)
end)

test("current vendor and drop identities replace obsolete Retail sources", function()
    local siamese, egg = entry(44), entry(90)
    assert(siamese.npcId == 20980 and payload(44).pins[1].mapID == 109)
    assert(payload(44).sourceSummary:find("Dealer Rashaad", 1, true))
    assert(egg.itemId == 68673 and egg.npcId == 10596)
    assert(catalog:GetWowheadUrl("pets", egg) == "https://www.wowhead.com/item=68673")
    assert(entry(67).itemId == 8501 and entry(68).itemId == 8500)
    assert(entry(64).itemId == 11027 and entry(65).itemId == 11026)
    assert(payload(67).pins[1].mapID == 84, "Owl guide should offer Stormwind before old Darnassus")
    assert(math.abs(payload(46).pins[1].x - 0.4694) < 0.00001)
end)

test("each whelpling and zone-drop pet keeps its own actual farming locations", function()
    local dark, azure, crimson, emerald = payload(56), payload(57), payload(58), payload(59)
    assert(#dark.guideMaps == 2 and dark.pins[1].mapID == 56 and dark.pins[2].mapID == 15)
    assert(#azure.pins == 1 and azure.pins[1].mapID == 83 and azure.pins[1].x == 0.56)
    assert(#crimson.pins == 1 and crimson.pins[1].mapID == 56 and crimson.pins[1].x == 0.68)
    assert(#emerald.pins == 1 and emerald.pins[1].mapID == 69 and emerald.pins[1].x == 0.48)
    assert(payload(49).pins[1].label:find("Bloodsail", 1, true))
    assert(payload(87).pins[1].label:find("Gordunni", 1, true))
end)

test("same-map farm alternatives share a selector with the guide's real step badges", function()
    local map, window = payload(42), TDP.CollectionMapWindow:New()
    assert(#map.guideMaps == 1 and #map.pins == 2)
    window:Open(map)
    assert(window.sourceAreaButton:IsShown())
    assert(window.sourceAreaButton:GetText() == "Hillsbrad Foothills - Steps 2, 3")
    assert(window.pinFrames[1].stepText:GetText() == "2")
    assert(window.pinFrames[2].stepText:GetText() == "3")
end)

test("OOX dropdown reaches every zone and retains repeated turn-in step numbers", function()
    local map, window = payload(83), TDP.CollectionMapWindow:New()
    assert(#map.guideMaps == 4 and #map.pins == 5)
    window:Open(map)
    assert(window.sourceAreaButton:GetText() == "Feralas - Steps 2, 3")
    assert(window.pinFrames[1].stepText:GetText() == "2/3")
    local selected
    local original = TDP.Widgets.ShowSingleSelectMenu
    TDP.Widgets.ShowSingleSelectMenu = function(_, _, maps, current, label, choose)
        assert(#maps == 4 and current == 69)
        assert(label(26) == "The Hinterlands - Step 5")
        selected = choose
    end
    window.sourceAreaButton:GetScript("OnClick")(window.sourceAreaButton)
    TDP.Widgets.ShowSingleSelectMenu = original
    selected(26)
    assert(window.mapID == 26 and window.pinFrames[1].stepText:GetText() == "5")
    assert(window.pinFrames[2].stepText:GetText() == "5")
    selected(210)
    assert(window.pinFrames[1].stepText:GetText() == "6/7")
    local saved = window:CopyProjectionPayload()
    window:Open(saved)
    assert(window.sourceAreaButton:GetText() == "The Cape of Stranglethorn - Steps 6, 7")
end)

test("interaction and timed quest guides preserve concrete prerequisites and omit money-making steps", function()
    local ancona, cluck, jubling = payload(52), payload(84), payload(106)
    assert(ancona.acquisition:find("blue circle", 1, true) and ancona.acquisition:find("1 gold", 1, true))
    assert(cluck.acquisition:find("/chicken", 1, true) and cluck.acquisition:find("/cheer", 1, true))
    assert(cluck.acquisition:find("egg placed on the ground", 1, true))
    assert(not cluck.acquisition:find("Tol Barad", 1, true))
    assert(#jubling.guideMaps == 2 and jubling.acquisition:find("7 real days", 1, true))
    assert(jubling.acquisition:find("at least 2", 1, true) and jubling.acquisition:find("ground target", 1, true))
    assert(payload(83).acquisition:find("25475", 1, true) and payload(83).acquisition:find("25476", 1, true))
    assert(payload(86).acquisition:find("both levels", 1, true))
    assert(payload(95).cost:find("4 Thorium Widgets", 1, true))
end)

print("Classic Retail pet guide tests: " .. passed .. " passed")
