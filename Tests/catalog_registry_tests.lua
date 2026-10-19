local root = arg and arg[1] or "."
local TDP = {}
assert(loadfile(root .. "/Data/Catalog/Registry.lua"))("TODO-Planner", TDP)
local registry = TDP.CatalogRegistry
local catalog = TDP.PatchCatalog

local function rejects(callback, message)
    local ok, err = pcall(callback)
    assert(not ok and tostring(err):find(message, 1, true), "Expected rejection: " .. message)
end

rejects(function()
    registry:RegisterCollection("test", "mounts", { entries = {} })
end, "Register patch metadata before collections")

registry:RegisterPatch("test", { label = "Test patch", sourceUrls = { audit = "test-source" } })
assert(catalog.patches.test.sourceUrls.audit == "test-source")
assert(#catalog.patches.test.pets == 0)
assert(#catalog.patches.test.achievements.ids == 0)
rejects(function() registry:RegisterPatch("test", { label = "Duplicate" }) end, "Duplicate patch")
rejects(function() registry:RegisterCollection("test", "invalid", {}) end, "Unknown collection type")

local entries = { { spellId = 42, name = "Test mount" } }
local details = { ["Test mount"] = { source = "Test source" } }
registry:RegisterCollection("test", "mounts", { entries = entries, details = details })
assert(catalog.patches.test.mounts == entries)
assert(catalog.mountDetails.test == details)
rejects(function()
    registry:RegisterCollection("test", "mounts", { entries = {} })
end, "Duplicate collection")

registry:RegisterCollection("test", "achievements", {
    entries = { ids = { 100 }, rewardHighlights = { { achievementId = 100, reward = "Test" } } },
    categories = { [100] = "Exploration" }, details = { [100] = { source = "Test" } },
})
assert(catalog.achievementCategories.test[100] == "Exploration")
assert(catalog.achievementDetails.test[100].source == "Test")
assert(catalog.patches.test.achievements.rewardHighlights[1].achievementId == 100)

registry:RegisterAvailability("test", { mounts = { [42] = { reason = "Test retirement" } } })
assert(catalog.collectionAvailability.mounts[42].reason == "Test retirement")
rejects(function()
    registry:RegisterAvailability("test", { mounts = { [42] = {} } })
end, "Duplicate collection availability ID")
print("Catalog registry tests passed: load ordering, metadata, collections, achievements, and duplicate protection")
