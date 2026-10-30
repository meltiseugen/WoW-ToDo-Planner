local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
mock.recording = false
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
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local catalog = TDP.PatchCatalog
GetAchievementInfo = function(id)
    return id, "Achievement " .. id, 10, false, nil, nil, nil, "Live journal description", 0, 123, ""
end
GetAchievementNumCriteria = function() return 0 end
local passed = 0
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function click(button) button:GetScript("OnClick")(button) end

test("generic achievement guides retain researched zone, instance, delve and event destinations", function()
    for _, case in ipairs({
        { "11.0", 19559, 2255, true }, { "11.0", 20118, 2248, true },
        { "11.0", 40232, 2255, false }, { "11.0", 40103, 2213, false },
        { "11.0.7", 40959, 1527, true }, { "11.0.7", 41152, 2257, true },
        { "11.1", 41214, 2346, true }, { "11.1.5", 41725, 2339, true },
    }) do
        assert(catalog:GetAchievementAcquisitionText(case[1], case[2]) == "Complete the achievement's listed criteria.")
        local payload = catalog:GetCollectionMapPayload("achievements", case[1], case[2])
        assert(payload and payload.mapID == case[3], "Generic text discarded the known location for " .. case[2])
        if case[4] then assert(payload.areaOnly and #payload.pins == 0, "Area records must not invent pins")
        else assert(#payload.pins > 0) end
    end
end)

test("hidden character copies use canonical raid locations and documented quest criteria", function()
    for _, case in ipairs({ { 40023, 885 }, { 40024, 120 }, { 40031, 1148 },
        { 40047, 1525 }, { 40056, 2025 }, { 40888, 2025 } }) do
        local payload = catalog:GetCollectionMapPayload("achievements", "11.0", case[1])
        assert(payload and payload.mapID == case[2], "Encounter and Journal IDs must not send a raid to a different instance")
    end
    local quest = catalog:GetCollectionMapPayload("achievements", "11.0", 39919)
    assert(quest and #quest.pins == 8 and quest.pins[1].mapID == 115)
    assert(quest.pins[1].label == "The Warden's Task", "Quest criteria must have usable pin labels")
    local mount = catalog:GetCollectionMapPayload("achievements", "11.0", 40459)
    assert(mount and mount.pins[1].mapID == 2339, "Collection criteria must resolve their real acquisition source")
end)

local function verifyExpansionMaps(expansion, total, minimumMapped)
    local explorer, favorites = TDP.CollectionExplorerWindow:New():Build(), TDP.FavoritesWindow:New():Build()
    explorer.selectedCollectionType, explorer.selectedStatus = "achievements", "all"
    explorer.selectedExpansion, explorer.selectedPatch = expansion, "all"
    explorer.selectedAchievementCategory = "all"
    explorer:Render()
    assert(#explorer.visibleRows == total, "The real expansion and type filters must be exercised")
    local previewCalls = 0
    local opened
    TDP.collectionMapWindow = { Open = function(_, payload) opened = payload; previewCalls = previewCalls + 1 end }
    for _, faction in ipairs({ "Alliance", "Horde" }) do
        UnitFactionGroup = function() return faction end
        catalog:ResetCollectionSourceCache()
        local mapped = 0
        for _, window in ipairs({ explorer, favorites }) do
            local painted = window:BuildRow(window.listContent)
            for _, data in ipairs(explorer.visibleRows) do
                window:UpdateRow(painted, data, 1, 0)
                local expected = catalog:GetCollectionMapPayload("achievements", data.patchKey, data.entry, data.state)
                assert(painted.mapButton:IsShown() == (expected ~= nil), "Rendered row Map visibility disagrees for " .. data.entry)
                if expected then
                    mapped = mapped + 1
                    window.selectedRow = data
                    window:RenderPreview()
                    assert(window.previewMapButton:IsShown() and window.previewMapButton:IsEnabled(), "Achievement preview Map is disabled")
                    for _, button in ipairs({ painted.mapButton, window.previewMapButton }) do
                        opened = nil
                        click(button)
                        assert(opened and opened.collectionType == "achievements" and opened.mapID == expected.mapID,
                            "Achievement Map click did not open the researched destination")
                    end
                end
            end
        end
        assert(mapped >= minimumMapped * 2, "Researched achievement maps must remain available in each window")
    end
    assert(previewCalls >= minimumMapped * 8, "Both controls must be clicked for every mapped row in both windows and factions")
    TDP.collectionMapWindow = nil
end

test("the actual War Within achievement tab renders and opens every researched row and preview map", function()
    verifyExpansionMaps("11", 1889, 1418)
end)

test("the actual Midnight achievement tab renders and opens every researched row and preview map", function()
    verifyExpansionMaps("12", 461, 381)
end)

test("Midnight criteria map to every named dungeon and to the correct activity starting points", function()
    for _, case in ipairs({ { 62438, 2405 }, { 62439, 2437 }, { 62440, 2393 },
        { 62441, 2509 }, { 62442, 2022 }, { 62443, 864 }, { 62444, 862 } }) do
        local payload = catalog:GetCollectionMapPayload("achievements", "12.1", case[1])
        assert(payload and #payload.pins == 1 and payload.pins[1].mapID == case[2], "Missing or incorrect dungeon entrance")
    end
    local pool = catalog:GetCollectionMapPayload("achievements", "12.1", 62417)
    assert(pool and #pool.pins == 8, "A resilient keystone requires all eight named dungeons")
    local trainers = catalog:GetCollectionMapPayload("achievements", "12.1", 62476)
    local trainerMaps = { ["Brok"] = { [198] = true }, ["Goz Banefury"] = { [241] = true },
        ["Bordin Steadyfist"] = { [207] = true }, ["Obalis"] = { [249] = true, [1527] = true } }
    local found = {}
    assert(trainers and #trainers.pins >= 4, "Pet battle creature criteria must retain all four trainers")
    for _, pin in ipairs(trainers.pins) do
        assert(trainerMaps[pin.label] and trainerMaps[pin.label][pin.mapID], "A trainer must not be pinned at a quest giver in another city")
        found[pin.label] = true
    end
    for name in pairs(trainerMaps) do assert(found[name], "Missing trainer: " .. name) end
    local fires = catalog:GetCollectionMapPayload("achievements", "12.1", 61335)
    assert(fires and #fires.pins == 5 and fires.pins[1].mapID == 2395, "Midnight events must use the revamped zones")
    local prey = catalog:GetCollectionMapPayload("achievements", "12.1", 63451)
    assert(prey and prey.pins[1].mapID == 2393 and prey.pins[1].label:find("choose", 1, true), "A hunt starts at Astalor, not an invented boss spawn")
    local lumber = catalog:GetCollectionMapPayload("achievements", "12.0", 62362)
    assert(lumber and lumber.areaOnly and lumber.mapID == 550 and #lumber.pins == 0, "Harvesting Shadowmoon Lumber must open Draenor Nagrand")
    local souvenirs = catalog:GetCollectionMapPayload("achievements", "12.1", 63606)
    assert(souvenirs and souvenirs.areaOnly and #souvenirs.sourceAreaMaps == 2, "The housing meta must include both neighborhoods")
end)

test("achievement map visibility never needs a journal description or parses guide text", function()
    local original = catalog.GetCollectionAcquisitionText
    catalog.GetCollectionAcquisitionText = function() error("A painted achievement must not parse its guide") end
    GetAchievementInfo = nil
    for _, id in ipairs({ 19559, 20118, 40098, 40103, 40232 }) do
        assert(catalog:HasCollectionMapPayload("achievements", "11.0", id))
    end
    assert(not catalog:HasCollectionMapPayload("achievements", "11.0", 999999999), "Unknown achievements must not gain a fabricated map")
    assert(not catalog:HasCollectionMapPayload("achievements", "11.0", 19459), "Reaching level 80 has no mandatory map destination")
    assert(not catalog:HasCollectionMapPayload("achievements", "11.0", 19467), "An internal level counter must not invent a map")
    catalog.GetCollectionAcquisitionText = original
end)
print("Achievement location tests passed: " .. passed)
