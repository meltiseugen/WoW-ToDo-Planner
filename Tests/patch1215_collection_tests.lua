local root = arg and arg[1] or "."
local TDP = { Widgets = {} }
local function loadAddon(path)
    assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP)
end
function wipe(values) for key in pairs(values) do values[key] = nil end end
loadAddon("Core/Utils.lua")
loadAddon("Data/GeneratedPatchCollections.lua")
loadAddon("Data/Patch1215Collections.lua")
loadAddon("Data/PatchCatalog.lua")
loadAddon("Data/CollectionAvailability.lua")
loadAddon("Integrations/CollectionScanner.lua")
loadAddon("UI/CollectionExplorerWindow.lua")

local catalog = TDP.PatchCatalog
local function equal(actual, expected, message)
    assert(actual == expected, message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local passed = 0
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end

test("live collection IDs are unique across patches and have complete details", function()
    local counts = { mounts = 3, pets = 3, toys = 10, cosmetics = 11, achievements = 38 }
    local fields = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }
    for kind, count in pairs(counts) do
        equal(#catalog:GetEntries("12.1.5", kind), count, kind .. " live count")
        local seen = {}
        for _, patch in ipairs(catalog:GetPatchKeys()) do
            for _, entry in ipairs(catalog:GetEntries(patch, kind)) do
                local id = fields[kind] and entry[fields[kind]] or entry
                assert(not seen[id], "duplicate " .. kind .. ":" .. id)
                seen[id] = true
                if patch == "12.1.5" then
                    local info = catalog:GetCollectionDetails(kind, patch, entry)
                    assert(info and info.source and info.acquisition and info.tips, "missing acquisition detail")
                    equal(info.reviewedAt, "2026-10-15", "research date")
                    assert(info.sourceUrl:match("^https://"), "missing source URL")
                    equal(catalog:GetCollectionFaction(kind, patch, entry), "all", "shared Midnight reward")
                    equal(catalog:IsCollectionUnobtainable(kind, patch, entry), false, "new live reward is not retired early")
                end
            end
        end
    end
    local wartorn = catalog:GetAchievementDetails("8.0.0", 12812)
    assert(wartorn.tips:find("no longer required", 1, true), "existing BfA meta needs live 12.1.5 criteria notes")
    equal(catalog:GetMountDetails("8.0.0", { name = "Obsidian Krolusk" }).tips, wartorn.tips, "mount and meta share updated requirements")
end)

test("achievement audit includes all 38 eligible IDs and excludes tracking and calendar records", function()
    local expected = {
        63519, 63657, 63658, 63659, 63680, 63690, 63692, 63693, 63694,
        63715, 63716, 63717, 63718, 63719, 63720, 63721, 63722, 63723,
        63724, 63727, 63728, 63830, 63846, 63847, 63848, 63849, 63850,
        63851, 63852, 63853, 63863, 63864, 63865, 64039, 64118, 64167, 64168, 64169,
    }
    local ids = catalog:GetEntries("12.1.5", "achievements")
    equal(#ids, #expected, "eligible achievement count")
    for index, id in ipairs(expected) do
        equal(ids[index], id, "achievement attribution")
        local name = TDP.CollectionScanner:GetDisplayName("achievements", id, {}, "12.1.5")
        assert(not name:find("Achievement #", 1, true), "offline achievement name missing")
    end
    assert(catalog:GetAchievementDetails("12.1.5", 64039).tips:find("first regional weekly reset", 1, true), "first-week deadline missing")
end)

test("map payloads distinguish entrances, vendors, and partial interior treasure coverage", function()
    local treasure = catalog:GetCollectionMapPayload("achievements", "12.1.5", 63717)
    equal(#treasure.pins, 20, "entrance plus 19 researched chest positions")
    equal(treasure.pins[1].mapID, 2395, "outdoor Labyrinth entrance map")
    equal(treasure.pins[2].mapID, 2647, "interior Labyrinth map")
    equal(treasure.mapAchievementId, nil, "no guessed criterion completion mapping")
    local raid = catalog:GetCollectionMapPayload("toys", "12.1.5", { itemId = 284159, name = "Libram of the Matriarch" })
    equal(raid.pins[1].mapID, 2613, "raid entrance is in the Underbelly")
    local mount = catalog:GetCollectionMapPayload("mounts", "12.1.5", { spellId = 1313788, name = "Sporebearer Fungal Strider" })
    equal(mount.pins[1].mapID, 2576, "Showena is in The Den interior")
end)

test("Explorer exposes the live patch and all five collection tabs", function()
    local window = TDP.CollectionExplorerWindow:New()
    equal(window.selectedPatch, "12.1.5", "default patch")
    local options = window:GetPatchOptions()
    equal(options[#options], "12.1.5", "patch selector includes live update")
    window.selectedStatus = "all"
    for kind, count in pairs({ mounts = 3, pets = 3, toys = 10, cosmetics = 11, achievements = 38 }) do
        window.selectedCollectionType = kind
        window:BuildVisibleRows()
        equal(#window.visibleRows, count, kind .. " visible rows")
    end
end)

print(string.format("Patch 12.1.5 collection tests passed: %d", passed))
