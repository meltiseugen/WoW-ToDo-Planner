local root = arg and arg[1] or "."
local TDP = {}
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
local catalog = TDP.PatchCatalog
local done, faction = {}, "Alliance"
UnitFactionGroup = function() return faction end
C_QuestLog = { IsQuestFlaggedCompleted = function(id) return done[id] == true end, IsOnQuest = function() return false end }
local passed = 0
local function test(name, callback)
    done, faction = {}, "Alliance"
    catalog:ResetCollectionSourceCache()
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function entry(patch, kind, name)
    for _, item in ipairs(catalog:GetEntries(patch, kind)) do if item.name == name then return item end end
    error("Missing fixture: " .. name)
end
local function source(patch, kind, name)
    return catalog:GetCollectionSourceInfo(kind, patch, entry(patch, kind, name))
end

test("wild-pet areas use the primary zone rather than an adjacent inherited map", function()
    local info = source("5.1", "pets", "Harpy Youngling")
    assert(info.kind == "Pet Battles" and info.areaMaps[1] == 10, "Northern Barrens, not Southern Barrens")
    assert(info.areaOnly and #info.waypoints == 0, "Do not fabricate a precise spawn")
end)

test("raid pets navigate to the outdoor instance entrance", function()
    local info = source("7.3.0", "pets", "Blazehound")
    assert(info.kind == "Dungeon and Raids")
    assert(info.waypoints[1].mapID == 198 and math.abs(info.waypoints[1].x - 0.473) < 0.001)
    local payload = catalog:GetCollectionMapPayload("pets", "7.3.0", entry("7.3.0", "pets", "Blazehound"))
    assert(payload.pins[1].locationType == "Instance entrance")
end)

test("ensemble constructors preserve individual sellers and purchase costs", function()
    local info = source("9.1", "cosmetics", "Ensemble: Garb of the Azure Dusk")
    assert(info.kind == "Vendor" and info.npcID == 174914)
    assert(info.waypoints[1].mapID == 1701 and math.abs(info.waypoints[1].x - 0.602) < 0.001)
    assert(info.cost[1][1] == "c" and info.cost[1][2] == 1813 and info.cost[1][3] == 10000)
end)

test("expanded source data retains existing cosmetic clue and material routes", function()
    local payload = catalog:GetCollectionMapPayload("cosmetics", "10.1.7", entry("10.1.7", "cosmetics", "Tyr's Titan Key"))
    assert(payload and #payload.pins == 4 and payload.pins[2].mapName == "The Waking Shores")
end)

test("island rewards select the character's actual expedition queue", function()
    for _, case in ipairs({ { "Alliance", 1161, 143968 }, { "Horde", 1165, 143967 } }) do
        faction = case[1]; catalog:ResetCollectionSourceCache()
        local info = source("8.0.0", "pets", "Scuttle")
        assert(info.npcID == case[3] and #info.waypoints == 1 and info.waypoints[1].mapID == case[2])
        assert(info.instructions:find("queue", 1, true))
    end
end)

test("faction quartermasters and current legacy sellers have precise destinations", function()
    local info = source("5.0", "cosmetics", "August Celestials Tabard")
    assert(info.npcID == 64032 and info.npcName == "Sage Whiteheart" and info.waypoints[1].mapID == 390)
    faction = "Horde"; catalog:ResetCollectionSourceCache()
    info = source("5.0", "cosmetics", "August Celestials Tabard")
    assert(info.npcID == 64001 and math.abs(info.waypoints[1].x - 0.627) < 0.001)
    info = source("11.2", "mounts", "Delver's Mana-Skimmer")
    assert(info.kind == "Vendor" and info.npcID == 226250 and info.npcName == "Reno Jackson")
    assert(info.waypoints[1].mapID == 2339 and info.cost[1][2] == 2815 and info.cost[1][3] == 10000)
    assert(catalog:GetMountAcquisitionText("11.2", entry("11.2", "mounts", "Delver's Mana-Skimmer")):find("Buy", 1, true),
        "Current purchase guidance must replace the obsolete quest instructions")
end)

test("trainer opponents and unimplemented items cannot be mistaken for missing collectible spawns", function()
    local item = entry("11.0", "pets", "Tiny Cragling")
    local info = source("11.0", "pets", "Tiny Cragling")
    assert(catalog:IsCollectionUnobtainable("pets", "11.0", item))
    assert(info.npcName == "Collector Dyna" and info.instructions:find("cannot be captured", 1, true))
    assert(info.waypoints[1].mapID == 2248)
    item = entry("11.0", "pets", "Caustic Oozeling")
    assert(catalog:IsCollectionUnobtainable("pets", "11.0", item))
    assert(not catalog:HasCollectionMapPayload("pets", "11.0", item))
    item = entry("8.0.0", "toys", "Jinyu Light Globe")
    assert(catalog:IsCollectionUnobtainable("toys", "8.0.0", item))
    assert(not catalog:HasCollectionMapPayload("toys", "8.0.0", item))
end)

test("automatic unlocks and shop rewards do not fabricate NPC pins", function()
    local info = source("9.1.5", "mounts", "Lightforged Ruinstrider")
    assert(info.kind == "Class Unlock" and #info.waypoints == 0 and not info.areaOnly)
    info = source("10.2.6", "toys", "Swarthy Warning Sign")
    assert(info.kind == "PvP" and info.instructions:find("Plunderstore", 1, true) and #info.waypoints == 0)
end)

test("Jenafur advances through the secret's real prerequisite flags", function()
    local info = source("8.2.5", "pets", "Jenafur")
    assert(info.questID == 58076 and info.progressType == "secret" and info.waypoints[1].mapID == 63)
    done[58076] = true; catalog:ResetCollectionSourceCache(true)
    info = source("8.2.5", "pets", "Jenafur")
    assert(info.questID == 58098 and info.waypoints[1].mapID == 37)
    done[58098] = true; catalog:ResetCollectionSourceCache(true)
    info = source("8.2.5", "pets", "Jenafur")
    assert(info.questID == 58099 and info.waypoints[1].mapID == 42)
end)

test("Dog's secret advances from the bowl to the pet and respects the garrison faction", function()
    for id in pairs(TDP.CollectionSourceIndex.quests) do done[id] = true end
    done[83093], done[83094] = nil, nil
    local info = source("11.0", "pets", "Faithful Dog")
    assert(info.questID == 83093 and info.waypoints[1].mapID == 2248)
    done[83093] = true; catalog:ResetCollectionSourceCache(true)
    info = source("11.0", "pets", "Faithful Dog")
    assert(info.questID == 83094 and info.npcID == 225486)
    done[46952], done[83093] = nil, nil
    faction = "Horde"; catalog:ResetCollectionSourceCache()
    info = source("11.0", "pets", "Faithful Dog")
    assert(info.questID == 46952 and info.waypoints[1].mapID == 590)
end)

test("repeatable chance rewards remain actionable after previous quest completions", function()
    for id in pairs(TDP.CollectionSourceIndex.quests) do done[id] = true end
    local info = source("9.2", "toys", "Firim's Specimen Container")
    assert(info.questID == 64717 and not info.questComplete and info.repeatableReward)
    assert(info.waypoints[1].mapID == 1970)
    assert(table.concat(catalog:GetCollectionSourceNotes("toys", "9.2", entry("9.2", "toys", "Firim's Specimen Container")), " "):find("chance", 1, true))
end)

test("the idol chain has an actionable item-started quest destination", function()
    local info = source("10.1.7", "toys", "Idol of Ohn'ahra")
    assert(info.questID == 77303 and info.waypoints[1].mapID == 2112)
    done[77303] = true; catalog:ResetCollectionSourceCache(true)
    info = source("10.1.7", "toys", "Idol of Ohn'ahra")
    assert(info.questID == 77304 and info.waypoints[1].mapID == 2023)
end)

test("all sixteen motes and unconfirmed source distinctions are retained", function()
    local info = source("10.1", "pets", "Mote of Nasz'uro")
    assert(#info.waypoints == 16 and info.waypoints[16].mapID == 2151)
    info = source("12.0", "pets", "Aud'rei III")
    assert(info.kind == "Unverified" and #info.waypoints == 0)
    info = source("11.1", "pets", "Gleam")
    assert(info.kind == "Unverified" and info.areaOnly and info.instructions:find("unverified", 1, true))
end)

print("Collection location research tests passed: " .. passed)
