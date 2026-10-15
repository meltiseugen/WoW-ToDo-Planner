local root = arg and arg[1] or "."
local TDP = { Widgets = {} }
local function loadAddon(path)
    assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP)
end
function wipe(values)
    for key in pairs(values) do values[key] = nil end
end
function UnitFullName() return "Collector", "Realm" end
function UnitName() return "Collector" end
function GetRealmName() return "Realm" end
function time() return 1000 end
loadAddon("Core/Constants.lua")
loadAddon("Core/Utils.lua")
loadAddon("Data/BoardManager.lua")
loadAddon("Data/TaskRepository.lua")
loadAddon("Data/Database.lua")
loadAddon("Data/GeneratedPatchCollections.lua")
loadAddon("Data/Patch1215Collections.lua")
loadAddon("Data/PatchCatalog.lua")
loadAddon("Data/CollectionAvailability.lua")
loadAddon("Integrations/CollectionScanner.lua")
loadAddon("UI/CollectionExplorerWindow.lua")
local catalog = TDP.PatchCatalog
local function equal(actual, expected, message)
    assert(actual == expected, (message or "value") .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function retired(kind, id)
    local fields = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }
    return catalog:IsCollectionUnobtainable(kind, "unused", { [fields[kind]] = id })
end
local passed = 0
local function test(name, callback)
    GetAchievementInfo = nil
    C_QuestLog = nil
    TODOPlannerDB = { settings = {} }
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end

test("all audited IDs resolve to real catalog entries and have research metadata", function()
    local fields = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }
    local counts = { mounts = 0, pets = 0, toys = 0, cosmetics = 0 }
    local found = { mounts = {}, pets = {}, toys = {}, cosmetics = {} }
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        for kind, field in pairs(fields) do
            for _, entry in ipairs(catalog:GetEntries(patch, kind)) do
                local record = catalog:GetCollectionAvailability(kind, patch, entry)
                if record then
                    found[kind][entry[field]] = true
                    counts[kind] = counts[kind] + 1
                    assert(record.reason and #record.reason > 15, "missing retirement reason")
                    assert(record.sourceUrl:match("^https://"), "missing research URL")
                    equal(record.reviewedAt, "2026-10-13", "review date")
                end
            end
        end
    end
    for kind, entries in pairs(catalog.collectionAvailability) do
        for id in pairs(entries) do assert(found[kind][id], "orphaned availability ID: " .. kind .. ":" .. id) end
    end
    equal(counts.mounts, 158, "retired mount candidates")
    equal(counts.pets, 5, "retired pet candidates")
    equal(counts.toys, 8, "retired toy candidates")
    equal(counts.cosmetics, 303, "retired cosmetic candidates")
end)

test("retirement is explicit and does not affect current seasons or alternate sources", function()
    for _, id in ipairs({ 37015, 59976, 129552, 189999, 302143, 1242272, 1262840, 1268949, 1301775 }) do
        equal(retired("mounts", id), true, "historical mount " .. id)
    end
    for _, id in ipairs({
        24252, -- Swift Zulian Tiger: Black Market
        60021, -- Plagued Proto-Drake: Black Market
        223341, -- Vicious Gilnean Warhorse: Vicious Saddle
        394737, -- Vicious Sabertooth
        316637, -- Awakened Mindborer: Timelost Saddle
        358319, -- Soultwisted Deathwalker: Timelost Saddle
        434462, -- Infinite Armoredon: Timelost Saddle
        1257058, -- Calamitous Carrion: prior Keystone rewards
        1296731, -- Cerulean Deathwalker: Timelost Saddle
        1301070, -- Midnight Season 2 Keystone mount
        1266211, -- Midnight Season 2 Gladiator mount
        368158, -- Mythic Jailer drop: reduced drop rate is not removal
        1264621, -- current Brawler's Guild reward
    }) do
        equal(retired("mounts", id), false, "available mount " .. id)
    end
    for _, id in ipairs({ 85, 239, 802, 1142, 1449, 1889, 2022, 4958 }) do
        equal(retired("pets", id), false, "alternate source / tradable pet " .. id)
    end
    equal(retired("pets", 4579), true, "non-cageable Remix pet")
    equal(retired("cosmetics", 248218), false, "Twilight Ascension retained vendor")
    equal(retired("cosmetics", 167891), false, "returning Brawler's Garb")
    equal(retired("cosmetics", 151524), false, "Hammer of Vigilance remains a raid drop")
    equal(retired("cosmetics", 241489), false, "ordinary Runebound raid appearances remain farmable")
    equal(retired("cosmetics", 253382), true, "exclusive Felforged Knight appearances")
    equal(retired("toys", 206267), true, "ended Solo Shuffle pennant")
    equal(retired("toys", 225547), true, "removed Delve quest reward")
    equal(retired("toys", 134032), false, "Legion Honor pennant retains its source")
    equal(retired("toys", 275988), false, "current Season 2 Nemesis reward")
    equal(catalog:IsCollectionUnobtainable("achievements", "12.1", 12345), false, "achievement scope unchanged")
    equal(catalog:GetCollectionAvailability("mounts", "12.1", nil), nil, "nil entry")
    equal(catalog:IsCollectionUnobtainable("mounts", "12.1", { spellId = 999999, name = "Retired Gladiator" }), false, "no name heuristic")
    equal(retired("mounts", "37015"), true, "string ID normalization")
end)

test("legacy PvP eligibility distinguishes character and account unlocks", function()
    local completed, earnedByMe = {}, {}
    GetAchievementInfo = function(id)
        return id, "Historical rating", 0, completed[id] == true, nil, nil, nil, "", 0, 0, "", false, earnedByMe[id] == true
    end
    equal(retired("cosmetics", 146218), true, "new Legion collector")
    completed[11579] = true
    equal(retired("cosmetics", 146218), true, "other character's Legion rating")
    earnedByMe[11579] = true
    equal(retired("cosmetics", 146218), false, "Legion Season 2 shared set unlock")
    equal(retired("cosmetics", 231137), true, "new Verdant collector")
    completed[19493], earnedByMe[19493] = true, true
    equal(retired("cosmetics", 231137), false, "Dragonflight Season 4 shared armor unlock")
    completed[19509], earnedByMe[19509] = true, true
    equal(retired("cosmetics", 231152), false, "Dragonflight Season 4 shared weapon unlock")
    completed[40389] = true
    equal(retired("cosmetics", 232681), false, "account Rival I unlock")
    equal(retired("cosmetics", 225856), true, "Rival I does not grant Duelist weapons")
    completed[40391] = true
    equal(retired("cosmetics", 225856), false, "account Duelist weapon unlock")
    GetAchievementInfo = function() error("API unavailable") end
    equal(retired("cosmetics", 232681), true, "failed API is safe")
end)

test("Dastardly Duos retains original quest and achievement vendor access", function()
    equal(retired("mounts", 1227076), true, "new Duos collector")
    C_QuestLog = { IsQuestFlaggedCompleted = function(id) return id == 87552 end }
    equal(retired("mounts", 1227076), false, "original Week 4 unlock")
    equal(retired("cosmetics", 238624), true, "quest does not grant cosmetic achievement")
    GetAchievementInfo = function(id) return id, "Defeat the Dastardlies", 0, id == 41951 end
    equal(retired("cosmetics", 238624), false, "original eight-boss unlock")
end)

local owned = {}
TDP.CollectionScanner.GetState = function(_, kind, entry)
    local id = TDP.CollectionScanner:GetEntryKey(kind, entry)
    return { name = type(entry) == "table" and entry.name or tostring(entry), collected = owned[id] == true }
end
local function windowFor(expansion, patch, kind)
    local window = TDP.CollectionExplorerWindow:New()
    window.selectedExpansion, window.selectedPatch, window.selectedCollectionType = expansion, patch, kind
    return window
end

test("status filtering preserves ownership and separates unobtainable from Missing", function()
    owned[65439] = true
    local window = windowFor("3", "3.2.0", "mounts")
    window.selectedStatus = "all"
    local total, collected, missing, unavailable = window:BuildVisibleRows()
    equal(total, 14, "total")
    equal(collected, 1, "collected retired mount")
    equal(missing, 8, "obtainable missing mounts")
    equal(unavailable, 6, "unobtainable total includes owned mounts")
    equal(#window.visibleRows, 14, "All retains historical entries")
    window.selectedStatus = "missing"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 8, "Missing excludes retired rewards")
    for _, row in ipairs(window.visibleRows) do equal(row.unobtainable, false) end
    window.selectedStatus = "unobtainable"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 6, "Unobtainable includes every retired reward")
    window.selectedStatus = "collected"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 1, "Collected retains retired ownership")
    equal(window:GetRowStatusLabel(window.visibleRows[1]), "Collected - Unobtainable", "owned retirement label")
    local notes = window:GetRowNotes(window.visibleRows[1])
    assert(notes:find("Unobtainable:", 1, true), "retirement reason in preview")
    assert(notes:find("Original acquisition:", 1, true), "historic directions labeled")
    window.selectedStatus = "unobtainable"
    window.searchEdit = { GetText = function() return "Furious" end }
    window:BuildVisibleRows()
    equal(#window.visibleRows, 1, "search composes with retirement")
    owned[65439] = nil
end)

test("filter applies to pets toys cosmetics and still scopes by expansion patch and source", function()
    for _, case in ipairs({
        { "10", "10.2.7", "pets", 2 },
        { "3", "3.3.5", "toys", 2 },
        { "11", "11.2.5", "cosmetics", 73 },
        { "12", "12.0.5", "cosmetics", 7 },
    }) do
        local window = windowFor(case[1], case[2], case[3])
        window.selectedStatus = "unobtainable"
        window:BuildVisibleRows()
        equal(#window.visibleRows, case[4], case[3] .. " retired filter")
        for _, row in ipairs(window.visibleRows) do
            equal(row.patchKey, case[2], "patch scope")
            equal(row.collectionType, case[3], "type scope")
        end
    end
    local window = windowFor("3", "3.2.0", "mounts")
    window.selectedStatus = "unobtainable"
    window.MountCategoryMatchesFilter = function(_, category) return category == "PvP" end
    window:BuildVisibleRows()
    equal(#window.visibleRows, 2, "PvP source filter composes with retirement")
end)

test("dropdown selection refreshes rows and persists across reload with legacy migration", function()
    TODOPlannerDB = { settings = { collectionHideCollected = false } }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.collectionStatusFilter, "all", "legacy show-all migration")
    local window = TDP.CollectionExplorerWindow:New()
    equal(window.selectedStatus, "all", "migrated selection")
    local options = window:GetStatusOptions()
    equal(options[4], "unobtainable", "new dropdown option")
    equal(window:GetStatusLabel(options[4]), "Unobtainable", "literal label")
    local renders = 0
    window.Render = function() renders = renders + 1 end
    window.selectedRow = {}
    equal(window:SetSelectedStatus("unobtainable"), true, "select new option")
    equal(window.selectedRow, nil, "old preview is cleared")
    equal(renders, 1, "selection renders immediately")
    TDP.Database:Init()
    equal(TDP.CollectionExplorerWindow:New().selectedStatus, "unobtainable", "reload selection")
    equal(window:SetSelectedStatus("invalid"), false, "unknown status rejected")
    equal(renders, 1, "invalid selection does not render")
    TODOPlannerDB = { settings = { collectionHideCollected = true, collectionStatusFilter = "invalid" } }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.collectionStatusFilter, "missing", "invalid saved status migration")
end)

print(string.format("Collection availability tests passed: %d", passed))
