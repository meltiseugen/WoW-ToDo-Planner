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
loadAddon("Data/Persistence/BoardManager.lua")
loadAddon("Data/Persistence/TaskRepository.lua")
loadAddon("Data/Persistence/Database.lua")
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
loadAddon("Integrations/CollectionScanner.lua")
loadAddon("Data/Persistence/Favorites.lua")
assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, "UI/Collections/Shared.xml", "UI/Collections/Explorer/Explorer.xml")
assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, "UI/Collections/Favorites/Favorites.xml")
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
                    if catalog.collectionAvailability[kind][entry[field]] == record then counts[kind] = counts[kind] + 1 end
                    assert(record.reason and #record.reason > 15, "missing retirement reason")
                    assert(record.sourceUrl:match("^https://"), "missing research URL")
                    equal(record.reviewedAt, record.kind ~= "Unobtainable" and catalog.collectionAvailability[kind][entry[field]] == record
                        and "2026-10-13" or "2026-10-28", "review date")
                end
            end
        end
    end
    for kind, entries in pairs(catalog.collectionAvailability) do
        for id in pairs(entries) do assert(found[kind][id], "orphaned availability ID: " .. kind .. ":" .. id) end
    end
    equal(counts.mounts, 164, "retired mount candidates")
    equal(counts.pets, 5, "retired pet candidates")
    equal(counts.toys, 8, "retired toy candidates")
    equal(counts.cosmetics, 303, "retired cosmetic candidates")
end)

test("retirement is explicit and does not affect current seasons or alternate sources", function()
    for _, id in ipairs({ 37015, 59976, 129552, 189999, 302143, 1242272, 1262840, 1268949, 1301775,
        254812, 300154, 437162, 471696, 457656, 332482 }) do
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

test("unobtainable archive hides Plunderstorm and unreleased mounts even when collected", function()
    local cases = {
        { "10", "10.2.6", 254812 }, { "10", "10.2.6", 300154 }, { "10", "10.2.6", 437162 },
        { "11", "11.0.7", 471696 }, { "11", "11.0.7", 457656 }, { "11", "11.2.7", 332482 },
    }
    local favorites = TDP.FavoritesWindow:New()
    for _, case in ipairs(cases) do
        local expansion, patch, id = unpack(case)
        local entries = catalog:GetEntries(patch, "mounts")
        local archived
        for _, entry in ipairs(entries) do if entry.spellId == id then archived = entry; break end end
        assert(archived, "archived mount must remain in its original patch: " .. id)
        assert(catalog:GetMountAcquisitionText(patch, archived), "archived guide is retained")
        equal(catalog:GetCollectionAvailability("mounts", patch, archived).kind, "Unobtainable", "archive category")
        TDP.Favorites:Add(patch, "mounts", archived)
        local window = windowFor(expansion, patch, "mounts")
        for _, collected in ipairs({ false, true }) do
            owned[id] = collected
            for _, status in ipairs({ "all", "missing", "collected" }) do
                window.selectedStatus = status
                window:BuildVisibleRows()
                for _, row in ipairs(window.visibleRows) do assert(row.entry.spellId ~= id, "archive leaked into " .. status) end
            end
            window.selectedStatus = "all"
            window.searchEdit = { GetText = function() return archived.name end }
            window:BuildVisibleRows()
            equal(#window.visibleRows, 0, "name search cannot reveal archived mount")
            window.searchEdit = nil
            window.nearbySnapshot = { patchKeys = { patch }, entries = { [patch] = { mounts = entries } } }
            window:BuildVisibleRows()
            for _, row in ipairs(window.visibleRows) do assert(row.entry.spellId ~= id, "archive leaked into saved Nearby snapshot") end
            window.nearbySnapshot = nil
        end
        equal(catalog:GetEntries(patch, "mounts"), entries, "catalog array is preserved")
        owned[id] = nil
    end
    for _, kind in ipairs({ "all", "mounts" }) do
        favorites.selectedCollectionType = kind
        favorites:BuildVisibleRows()
        equal(#favorites.visibleRows, 0, "archived favorites stay hidden")
    end
    equal(#TDP.Favorites:GetAll(), #cases, "saved archive favorites remain intact")
    -- A recurring Timewalking vendor and a returning Brawler's Guild reward
    -- must not be retired merely because other event mounts are archived.
    equal(retired("mounts", 1263369), false, "Skypaw Timewalking purchase retained")
    equal(retired("mounts", 1264621), false, "current Brawler reward retained")
end)

test("all mount statuses hide retired rewards while retaining the complete catalog", function()
    owned[65439] = true
    local entries = catalog:GetEntries("3.2.0", "mounts")
    local available
    for _, entry in ipairs(entries) do
        if not catalog:IsCollectionUnobtainable("mounts", "3.2.0", entry) then available = entry; break end
    end
    assert(available, "obtainable mount fixture")
    owned[available.spellId] = true
    local window = windowFor("3", "3.2.0", "mounts")
    window.selectedStatus = "all"
    local total, collected, missing, unavailable = window:BuildVisibleRows()
    equal(total, 8, "visible catalog total")
    equal(collected, 1, "only obtainable ownership counted")
    equal(missing, 7, "obtainable missing mounts")
    equal(unavailable, 0, "hidden rewards excluded from summary")
    equal(#window.visibleRows, 8, "All excludes historical entries")
    for _, row in ipairs(window.visibleRows) do equal(row.unobtainable, false) end
    window.selectedStatus = "missing"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 7, "Missing excludes retired and owned rewards")
    for _, row in ipairs(window.visibleRows) do equal(row.unobtainable, false) end
    window.selectedStatus = "collected"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 1, "Collected excludes owned retired rewards")
    equal(window.visibleRows[1].entry, available, "obtainable ownership retained")
    window.selectedStatus = "all"
    window.searchEdit = { GetText = function() return "Furious" end }
    window:BuildVisibleRows()
    equal(#window.visibleRows, 0, "search cannot reveal retired rewards")
    equal(catalog:GetEntries("3.2.0", "mounts"), entries, "catalog array unchanged")
    equal(#entries, 14, "historical entries retained")
    owned[65439] = nil
    owned[available.spellId] = nil
end)

test("other collection types keep their entries and availability metadata", function()
    for _, case in ipairs({
        { "10", "10.2.7", "pets", 2 },
        { "3", "3.3.5", "toys", 2 },
        { "11", "11.2.5", "cosmetics", 73 },
        { "12", "12.0.5", "cosmetics", 7 },
    }) do
        local window = windowFor(case[1], case[2], case[3])
        window.selectedStatus = "all"
        window:BuildVisibleRows()
        local retiredCount = 0
        for _, row in ipairs(window.visibleRows) do
            if row.unobtainable then retiredCount = retiredCount + 1 end
            equal(row.patchKey, case[2], "patch scope")
            equal(row.collectionType, case[3], "type scope")
        end
        equal(retiredCount, case[4], case[3] .. " retired entries retained")
    end
end)

test("combined and captured Nearby views cannot reveal historical mounts", function()
    local window = windowFor("3", "3.2.0", "mounts")
    window.selectedStatus = "all"
    window.selectedCollectionType = "all"
    window:BuildVisibleRows()
    local mountCount = 0
    for _, row in ipairs(window.visibleRows) do
        if row.collectionType == "mounts" then
            mountCount = mountCount + 1
            equal(row.unobtainable, false, "combined view hides historical mounts")
        end
    end
    equal(mountCount, 8, "combined view retains obtainable mounts")
    window.selectedCollectionType = "mounts"
    window.nearbySnapshot = { patchKeys = { "3.2.0" }, entries = {
        ["3.2.0"] = { mounts = catalog:GetEntries("3.2.0", "mounts") },
    } }
    window:BuildVisibleRows()
    equal(#window.visibleRows, 8, "captured snapshot respects visibility")
end)

test("historical favorites are hidden without removing saved records", function()
    local retiredEntry, available
    for _, entry in ipairs(catalog:GetEntries("3.2.0", "mounts")) do
        if catalog:IsCollectionUnobtainable("mounts", "3.2.0", entry) then retiredEntry = entry
        else available = entry end
    end
    assert(retiredEntry and available, "favorite fixtures")
    TDP.Favorites:Add("3.2.0", "mounts", retiredEntry)
    TDP.Favorites:Add("3.2.0", "mounts", available)
    local store = TODOPlannerDB.favorites
    local retiredKey = TDP.Favorites:GetKey("3.2.0", "mounts", retiredEntry)
    local savedRecord = store[retiredKey]
    owned[retiredEntry.spellId] = true
    local window = TDP.FavoritesWindow:New()
    for _, kind in ipairs({ "all", "mounts" }) do
        window.selectedCollectionType = kind
        window:BuildVisibleRows()
        equal(#window.visibleRows, 1, "only obtainable favorite displayed")
        equal(window.visibleRows[1].entry, available, "obtainable favorite retained")
    end
    equal(TODOPlannerDB.favorites, store, "favorites store preserved")
    equal(store[retiredKey], savedRecord, "historical favorite preserved")
    equal(#TDP.Favorites:GetAll(), 2, "both saved favorites retained")
    owned[retiredEntry.spellId] = nil
end)

test("dropdown selection refreshes rows and persists across reload with legacy migration", function()
    TODOPlannerDB = { settings = { collectionHideCollected = false } }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.collectionStatusFilter, "all", "legacy show-all migration")
    local window = TDP.CollectionExplorerWindow:New()
    equal(window.selectedStatus, "all", "migrated selection")
    local options = window:GetStatusOptions()
    equal(#options, 3, "only supported statuses remain")
    equal(options[1], "missing", "Missing option")
    equal(options[2], "all", "All option")
    equal(options[3], "collected", "Collected option")
    local renders = 0
    window.Render = function() renders = renders + 1 end
    window.selectedRow = {}
    equal(window:SetSelectedStatus("collected"), true, "select supported option")
    equal(window.selectedRow, nil, "old preview is cleared")
    equal(renders, 1, "selection renders immediately")
    TDP.Database:Init()
    equal(TDP.CollectionExplorerWindow:New().selectedStatus, "collected", "reload selection")
    equal(window:SetSelectedStatus("unobtainable"), false, "removed status rejected")
    equal(window:SetSelectedStatus("invalid"), false, "unknown status rejected")
    equal(renders, 1, "invalid selection does not render")
    TODOPlannerDB = { settings = { collectionHideCollected = true, collectionStatusFilter = "invalid" } }
    TDP.Database:Init()
    equal(TODOPlannerDB.settings.collectionStatusFilter, "missing", "invalid saved status migration")
    for _, hideCollected in ipairs({ true, false }) do
        TODOPlannerDB = { settings = { collectionHideCollected = hideCollected, collectionStatusFilter = "unobtainable" } }
        local fallback = hideCollected and "missing" or "all"
        equal(TDP.CollectionExplorerWindow:New().selectedStatus, fallback, "constructor ignores removed status")
        TDP.Database:Init()
        equal(TODOPlannerDB.settings.collectionStatusFilter, fallback, "removed saved status migration")
    end
end)

print(string.format("Collection availability tests passed: %d", passed))
