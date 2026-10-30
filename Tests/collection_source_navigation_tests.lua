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
local catalog, index = TDP.PatchCatalog, TDP.CollectionSourceIndex
local done, active, faction = {}, {}, "Alliance"
local passed = 0
local function test(name, callback)
    done, active, faction = {}, {}, "Alliance"
    UnitFactionGroup = function() return faction end
    UnitClass, UnitRace = nil, nil
    C_QuestLog = {
        IsQuestFlaggedCompleted = function(id) return done[id] == true end,
        IsQuestFlaggedCompletedOnAccount = function() return true end,
        IsOnQuest = function(id) return active[id] == true end,
    }
    catalog:ResetCollectionSourceCache()
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function entry(patch, kind, name)
    for _, record in ipairs(catalog:GetEntries(patch, kind)) do if record.name == name then return record end end
    error("Missing fixture: " .. name)
end
local flamefly = entry("4.0.0", "pets", "Tiny Flamefly")
local function flameSource() return catalog:GetCollectionSourceInfo("pets", "4.0.0", flamefly) end

test("Tiny Flamefly starts at the correct faction's first required quest", function()
    for _, case in ipairs({ { "Alliance", 28174, 47811, 17.2, 52 }, { "Horde", 28418, 48559, 17.4, 51.6 } }) do
        faction = case[1]
        catalog:ResetCollectionSourceCache()
        local source = flameSource()
        assert(source.kind == "Quest Rewards" and source.questID == case[2], case[1] .. " chain start: " .. tostring(source.questID))
        assert(source.npcID == case[3] and source.npcName)
        local payload = catalog:GetCollectionMapPayload("pets", "4.0.0", flamefly)
        assert(payload.mapID == 36 and #payload.pins == 1)
        assert(math.abs(payload.pins[1].x * 100 - case[4]) < 0.001 and math.abs(payload.pins[1].y * 100 - case[5]) < 0.001)
        assert(payload.sourceNotes:find(source.npcName, 1, true))
        assert(payload.mapAchievementId == nil and payload.pins[1].criterionIndex == nil)
    end
end)

test("completed prerequisites advance the destination without using account completion", function()
    done[28416] = true -- Alternate Alliance introduction, selected by the Redridge story.
    local source = flameSource()
    assert(source.questID ~= 28174 and source.questID ~= 28416, "Alternative introductions are interchangeable")
    local visited = {}
    for step = 1, 80 do
        source = flameSource()
        assert(not visited[source.questID], "Quest chain must advance rather than loop")
        visited[source.questID] = true
        if source.questID == 28415 then break end
        assert(source.questID ~= 28491 and source.questStatus ~= "complete", "Horde and account-wide flags must not advance this character")
        done[source.questID] = true
        TDP.CollectionScanner:ResetCache()
    end
    assert(source.questID == 28415, "The chain reaches the Alliance reward")
    done[28415] = true
    TDP.CollectionScanner:ResetCache()
    assert(flameSource().questComplete == true and flameSource().questStatus == "complete")
end)

test("an active quest uses Blizzard's next objective with a quest-giver fallback", function()
    active[28415] = true
    C_QuestLog.GetNextWaypoint = function(id) assert(id == 28415); return 36, 0.64, 0.60 end
    local source = flameSource()
    assert(source.questID == 28415 and source.questStatus == "active")
    assert(source.waypoints[1].x == 0.64 and source.waypoints[1].locationType == "Quest objective")
    C_QuestLog.GetNextWaypoint = function() error("Not streamed yet") end
    catalog:ResetCollectionSourceCache()
    source = flameSource()
    assert(math.abs(source.waypoints[1].x - 0.718) < 0.001, "Fall back to the actual quest giver")
end)

test("both windows replace the unknown source with quest and seller information", function()
    local cat = entry("1.0", "pets", "Bombay Cat")
    local vendor = catalog:GetCollectionSourceInfo("pets", "1.0", cat)
    assert(vendor.kind == "Vendor" and vendor.npcID == 6367)
    local payload = catalog:GetCollectionMapPayload("pets", "1.0", cat)
    assert(payload.mapID == 37 and payload.pins[1].npcID == 6367)
    assert(math.abs(payload.pins[1].x - 0.442) < 0.001 and math.abs(payload.pins[1].y - 0.532) < 0.001)
    for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
        local window = class:New()
        local row = { collectionType = "pets", patchKey = "4.0.0", entry = flamefly }
        local text = window:GetRowMetaPrefix(row)
        assert(text:find("Quest Rewards", 1, true) and not text:find("unknown", 1, true))
        assert(window:IsCollectionMapRow(row))
        local notes = window:GetRowNotes(row)
        assert(notes:find("John J. Keeshan", 1, true) and notes:find("17.2, 52.0", 1, true))
        row.patchKey, row.entry = "1.0", cat
        text = window:GetRowMetaPrefix(row)
        assert(text:find("Vendor", 1, true) and text:find("Donni Anthania", 1, true))
        assert(window:IsCollectionMapRow(row))
    end
end)

test("crafting and achievement rewards retain their acquisition type without fabricated pins", function()
    local squirrel = entry("1.0", "pets", "Mechanical Squirrel")
    local source = catalog:GetCollectionSourceInfo("pets", "1.0", squirrel)
    assert(source.kind == "Professions")
    assert(source.summary:find("Engineering", 1, true))
    local stinker = entry("3.0", "pets", "Stinker")
    source = catalog:GetCollectionSourceInfo("pets", "3.0", stinker)
    assert(source.kind == "Achievements" and source.achievementID)
    assert(catalog:GetCollectionSourceAchievementId("pets", "3.0", stinker) == source.achievementID)
    assert(#source.waypoints == 0, "An achievement does not have an invented map location")
end)

test("imported gold and currency costs work and recorded cost guides take precedence", function()
    local toy = { itemId = 999901, name = "Synthetic vendor fixture" }
    index.toys[999901] = { { kind = "Vendor", npcID = 6367, coords = { { 37, 44.2, 53.2 } }, cost = 125000 } }
    local cost = catalog:GetCollectionSourceCost("toys", "unused", toy)
    assert(cost:find("12g 50s 0c", 1, true))
    toy.cost = "3 Specific Tokens"
    local lines = catalog:GetCollectionCostLines("toys", "unused", toy)
    assert(lines[1] == "Cost: 3 Specific Tokens")
    index.toys[999901][1].cost = { { "c", 241, 25 }, { "i", 123, 3 } }
    catalog:ResetCollectionSourceCache()
    cost = catalog:GetCollectionSourceCost("toys", "unused", toy)
    assert(cost:find("25 |Hcurrency:241", 1, true) and cost:find("3 |Hitem:123", 1, true))
    index.toys[999901] = nil
end)

test("quest data is requested only for inspected entries and failed data keeps the chain start", function()
    local requests = 0
    C_QuestLog.GetTitleForQuestID = function() return nil end
    C_QuestLog.RequestLoadQuestByID = function() requests = requests + 1 end
    done[28174] = true
    local source = flameSource()
    assert(not source.questName)
    catalog:GetCollectionMapPayload("pets", "4.0.0", flamefly)
    catalog:HasCollectionMapPayload("pets", "4.0.0", flamefly)
    assert(requests == 0, "Listing map buttons must not request every quest")
    catalog:GetCollectionSourceNotes("pets", "4.0.0", flamefly, true)
    catalog:GetCollectionSourceNotes("pets", "4.0.0", flamefly, true)
    assert(requests == 1, "Selected quest requests are deduplicated")
    C_QuestLog.GetTitleForQuestID = function(id) return "Loaded quest " .. id end
    TDP.CollectionScanner:ResetCache()
    assert(flameSource().questName:find("Loaded quest", 1, true))
    C_QuestLog = nil
    catalog:ResetCollectionSourceCache()
    assert(flameSource().questID == 28174, "Unavailable quest APIs keep a usable chain start")
end)

test("an open collection map advances on quest changes and leaves stable destinations alone", function()
    local window = TDP.CollectionMapWindow:New():Build()
    window:Open(catalog:GetCollectionMapPayload("pets", "4.0.0", flamefly))
    local initial = window.sourceQuestID
    window.zoom = 2
    window:RefreshSourceDestination()
    assert(window.zoom == 2, "Unchanged sources retain map navigation")
    done[initial] = true
    TDP.CollectionScanner:ResetCache()
    window:RefreshSourceDestination()
    assert(window.sourceQuestID ~= initial and window.sourceQuestID ~= 28491)
    window.frame:Hide()
    local previous = window.sourceQuestID
    done[previous] = true
    TDP.CollectionScanner:ResetCache()
    window:RefreshSourceDestination()
    assert(window.sourceQuestID == previous, "Hidden maps do not update")
end)

test("source-area maps have no invented pins and expose the recorded area choices", function()
    local item = { itemId = 999902, name = "Area source fixture" }
    index.toys[999902] = { { kind = "Rare Drops", maps = { 23, 36 }, coords = {} } }
    local payload = catalog:GetCollectionMapPayload("toys", "unused", item)
    assert(payload.areaOnly and payload.mapID == 23 and #payload.pins == 0)
    assert(catalog:HasCollectionMapPayload("toys", "unused", item))
    local owner = TDP.CollectionExplorerWindow:New()
    local helpTitle, help = owner:GetCollectionMapActionHelp({ collectionType = "toys", patchKey = "unused", entry = item })
    assert(helpTitle == "Source Area" and help:find("precise", 1, true))
    local window = TDP.CollectionMapWindow:New():Build()
    window:Open(payload)
    assert(window.sourceAreaButton:IsShown() and #window:GetVisiblePins() == 0)
    assert(window:ProjectToWorldMap() == false, "Area maps cannot create fake projected waypoints")
    window.sourceAreaButton:GetScript("OnClick")(window.sourceAreaButton)
    assert(TDP.Widgets.menuFrame:IsShown())
    window.frame:Hide()
    window.frame:GetScript("OnHide")(window.frame)
    assert(not TDP.Widgets.menuFrame:IsShown())
    index.toys[999902] = nil
end)

test("quest-gated container drops guide the unlock and then show their real farming area", function()
    local grubbs = entry("4.0.0", "pets", "Mr. Grubbs")
    local source = catalog:GetCollectionSourceInfo("pets", "4.0.0", grubbs)
    assert(source.kind == "Rare Drops" and source.questID and source.npcID == 45417)
    assert(source.waypoints[1].mapID == 23)
    for step = 1, 30 do
        source = catalog:GetCollectionSourceInfo("pets", "4.0.0", grubbs)
        if not source.questID then break end
        done[source.questID] = true
        catalog:ResetCollectionSourceCache()
    end
    assert(not source.questID and source.areaOnly and source.areaMaps[1] == 23)
    local notes = table.concat(catalog:GetCollectionSourceNotes("pets", "4.0.0", grubbs), "\n")
    assert(notes:find("Fiona's Lucky Charm", 1, true) and notes:find("chance reward", 1, true))
    local payload = catalog:GetCollectionMapPayload("pets", "4.0.0", grubbs)
    assert(payload.areaOnly and payload.mapID == 23 and #payload.pins == 0)
end)

test("available sellers take priority over alternate quest sources and respect character restrictions", function()
    local item = { itemId = 999903, name = "Multiple source fixture" }
    UnitClass = function() return "Paladin", "PALADIN", 2 end
    index.toys[999903] = {
        { kind = "Quest Rewards", questID = 28415 },
        { kind = "Vendor", npcID = 1, faction = "Horde", classes = { 2 }, coords = { { 85, 40, 50 } } },
        { kind = "Vendor", npcID = 2, faction = "Alliance", classes = { 8 }, coords = { { 84, 30, 40 } } },
        { kind = "Vendor", npcID = 3, faction = "Alliance", classes = { 2 }, coords = { { 84, 50, 60 } } },
    }
    local info = catalog:GetCollectionSourceInfo("toys", "unused", item)
    assert(info.kind == "Vendor" and info.npcID == 3 and #info.waypoints == 1)
    assert(info.waypoints[1].x == 0.5 and info.waypoints[1].y == 0.6)
    index.toys[999903] = nil
end)

test("source-area quest refreshes preserve navigation while the destination is unchanged", function()
    local item = { itemId = 999904, name = "Automatic quest fixture" }
    index.quests[999904] = { questID = 999904, coords = {}, maps = { 23, 36 } }
    index.toys[999904] = { { kind = "Quest Rewards", questID = 999904 } }
    local window = TDP.CollectionMapWindow:New():Build()
    window:Open(catalog:GetCollectionMapPayload("toys", "unused", item))
    window.mapID, window.zoom, window.panX = 36, 2, 25
    window:RefreshSourceDestination()
    assert(window.mapID == 36 and window.zoom == 2 and window.panX == 25)
    index.quests[999904], index.toys[999904] = nil, nil
end)

test("alternative prerequisite counts do not require every branch", function()
    index.quests[999910] = { questID = 999910, coords = { { 23, 20, 30 } }, sourceQuests = { 999911, 999912 }, sqreq = 1 }
    index.quests[999911] = { questID = 999911, coords = { { 23, 30, 40 } } }
    index.quests[999912] = { questID = 999912, coords = { { 23, 40, 50 } } }
    done[999911] = true
    local quest = catalog:GetNextCollectionSourceQuest(999910)
    assert(quest.questID == 999910, "One completed alternative unlocks the next quest")
    index.quests[999910].sqreq = nil
    quest = catalog:GetNextCollectionSourceQuest(999910)
    assert(quest.questID == 999912, "All parallel requirements apply when no alternate count is recorded")
    index.quests[999910], index.quests[999911], index.quests[999912] = nil, nil, nil
end)

test("shared quest chains reuse character and quest-state reads until cache refresh", function()
    local factions, completions, activeReads = 0, {}, {}
    UnitFactionGroup = function() factions = factions + 1; return "Alliance" end
    C_QuestLog.IsQuestFlaggedCompleted = function(id) completions[id] = (completions[id] or 0) + 1; return false end
    C_QuestLog.IsOnQuest = function(id) activeReads[id] = (activeReads[id] or 0) + 1; return false end
    for i = 1, 30 do catalog:GetNextCollectionSourceQuest(28415) end
    assert(factions == 1)
    for _, count in pairs(completions) do assert(count == 1, "Completed state is queried once per quest") end
    for _, count in pairs(activeReads) do assert(count == 1, "Active state is queried once per quest") end
    catalog:ResetCollectionSourceCache()
    catalog:GetNextCollectionSourceQuest(28415)
    assert(factions == 2 and completions[28415] == 2, "Quest events invalidate the cached state")
end)

test("shared quest IDs select faction-specific giver and coordinate data", function()
    index.quests[999920] = { questID = 999920, variants = {
        { questID = 999920, faction = "Alliance", qgs = { 1 }, coords = { { 84, 30, 40 } } },
        { questID = 999920, faction = "Horde", qgs = { 2 }, coords = { { 85, 50, 60 } } },
    } }
    local quest = catalog:GetNextCollectionSourceQuest(999920)
    assert(quest.qgs[1] == 1 and quest.coords[1][1] == 84)
    faction = "Horde"
    catalog:ResetCollectionSourceCache()
    quest = catalog:GetNextCollectionSourceQuest(999920)
    assert(quest.qgs[1] == 2 and quest.coords[1][1] == 85)
    index.quests[999920] = nil
end)

test("the bundled source index references existing catalog entries and valid locations", function()
    for kind, field in pairs({ mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }) do
        local known = {}
        for _, patch in ipairs(catalog:GetPatchKeys()) do
            for _, item in ipairs(catalog:GetEntries(patch, kind)) do known[item[field]] = true end
        end
        for id, records in pairs(index[kind]) do
            assert(known[id], "Source index must not add catalog entries")
            for _, record in ipairs(records) do
                for _, point in ipairs(record.coords or {}) do
                    assert(point[1] > 0 and point[2] >= 0 and point[2] <= 100 and point[3] >= 0 and point[3] <= 100)
                end
                if record.questID then assert(index.quests[record.questID], "Reward quest must be included") end
                if record.unlockQuestID then assert(index.quests[record.unlockQuestID], "Unlock quest must be included") end
            end
        end
    end
end)

print("Collection source navigation tests passed: " .. passed)
