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
local catalog = TDP.PatchCatalog
local passed = 0
local function test(name, callback)
    catalog.sourceAchievementNames = nil
    GetAchievementInfo = nil
    TDP.CollectionScanner:ResetCache()
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function contains(text, part) assert(text:find(part, 1, true), "Missing: " .. part .. " in " .. text) end

test("both windows show recorded currency amounts for every collection type", function()
    local explorer = TDP.CollectionExplorerWindow:New()
    local favorites = TDP.FavoritesWindow:New()
    for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics" }) do
        local entry = catalog:GetEntries("12.1.5", kind)[1]
        -- Use a direct override to exercise the same entry metadata for all types.
        local item = {}
        for key, value in pairs(entry) do item[key] = value end
        item.cost = "25 Test Currency and 3 Barter Tokens"
        item.costs = { "Alternate vendor: 40 Test Currency" }
        for _, window in ipairs({ explorer, favorites }) do
            local notes = window:GetRowNotes({ collectionType = kind, patchKey = "12.1.5", entry = item })
            contains(notes, "Cost: 25 Test Currency and 3 Barter Tokens")
            contains(notes, "Alternate vendor: 40 Test Currency")
            local _, count = notes:gsub("Cost: 25 Test Currency", "")
            assert(count == 1, "Cost must appear once")
        end
    end
    local mount = catalog:GetEntries("10.0.5", "mounts")[1]
    contains(favorites:GetRowNotes({ collectionType = "mounts", patchKey = "10.0.5", entry = mount }),
        "Cost: 150 Essence of the Storm and 3,000 Elemental Overflow.")
    assert(#catalog:GetCollectionCostLines("mounts", "unused", {}) == 0)
end)

test("source IDs resolve from metadata and links without mistaking vendor numbers", function()
    local function resolve(entry) return catalog:GetCollectionSourceAchievementId("mounts", "12.1.5", entry) end
    assert(resolve({ sourceAchievementId = 63715 }) == 63715)
    assert(resolve({ source = "|Hachievement:63715:0|h[Goal]|h" }) == 63715)
    assert(resolve({ sourceUrl = "https://www.wowhead.com/achievement=63715/goal" }) == 63715)
    assert(resolve({ sourceType = "Vendor", source = "Merchant (63715)" }) == nil)
    local mount = catalog:GetEntries("12.1.5", "mounts")[2]
    assert(resolve(mount) == 63715, "Achievement source with map locations must still resolve")
    assert(catalog:GetCollectionSourceAchievementId("achievements", "12.1.5", 63715) == nil)
end)

test("named and generic achievement sources resolve from live names and rewards", function()
    GetAchievementInfo = function(id)
        return id, id == 63715 and "Test Goal" or "Other " .. id, 10, false,
            nil, nil, nil, "Description", 0, 123, id == 63715 and "Named reward" or ""
    end
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5",
        { name = "Pet", sourceType = "Achievement", source = "the Test Goal achievement" }) == 63715)
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5",
        { name = "Named reward", sourceType = "Achievement", source = "Collection achievements" }) == 63715)
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5",
        { name = "Named reward", sourceType = "Vendor", source = "Merchant" }) == nil)
    catalog.sourceAchievementNames = nil
    GetAchievementInfo = function(id) return id, id == 63715 and "The Test Goal" or "Other " .. id end
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5",
        { name = "Pet", sourceType = "Achievement", source = "The Test Goal" }) == 63715)
end)

test("temporarily missing achievement names retry on the next selection", function()
    GetAchievementInfo = function() return nil end
    local entry = { name = "Pet", sourceType = "Achievement", source = "Test Goal" }
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5", entry) == nil)
    GetAchievementInfo = function(id) return id, id == 63715 and "Test Goal" or "Other " .. id end
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5", entry) == 63715)
end)

test("ambiguous names and reward names do not select an arbitrary achievement", function()
    GetAchievementInfo = function(id)
        return id, "Same Goal", 10, false, nil, nil, nil, "Description", 0, 123, "Same reward"
    end
    assert(catalog:GetCollectionSourceAchievementId("pets", "12.1.5",
        { name = "Same reward", sourceType = "Achievement", source = "Same Goal" }) == nil)
end)

test("reward buttons in both windows navigate inside the addon despite active filters", function()
    local home = TDP.HomeWindow:New(TDP)
    local explorer = TDP.CollectionExplorerWindow:New(home)
    local favorites = TDP.FavoritesWindow:New(home)
    home:SetWindows(nil, explorer, favorites)
    explorer:Build()
    favorites:Build()
    local nativeCalls = 0
    TDP.Achievements = { OpenAchievement = function() nativeCalls = nativeCalls + 1; return true end }
    GetAchievementInfo = function(id)
        return id, "Goal " .. id, 10, true, nil, nil, nil, "Live description", 0, 123
    end
    local taskCount = #TODOPlannerDB.tasks
    local savedStatus = TODOPlannerDB.settings.collectionStatusFilter
    for _, window in ipairs({ explorer, favorites }) do
        explorer.selectedExpansion = "1"
        explorer.selectedStatus = "unobtainable"
        explorer.selectedAchievementCategory = "PvP"
        explorer.nearbySnapshot = { entries = {}, patchKeys = {} }
        explorer.searchEdit:SetText("unrelated search")
        window.selectedRow = { collectionType = "mounts", patchKey = "12.1.5",
            entry = catalog:GetEntries("12.1.5", "mounts")[2] }
        window:RenderPreview()
        assert(window.previewAchievementButton:IsShown())
        assert(window.previewAchievementButton.label:GetText() == "View Achievement")
        window.previewAchievementButton:GetScript("OnClick")()
        assert(explorer.selectedCollectionType == "achievements")
        assert(explorer.selectedPatch == "12.1.5" and explorer.selectedExpansion == "12")
        assert(explorer.selectedStatus == "all" and explorer.selectedAchievementCategory == "all")
        assert(explorer.nearbySnapshot == nil)
        assert(explorer.selectedRow.entry == 63715 and explorer.frame:IsShown())
        contains(explorer.previewDetails:GetText(), "Live description")
        assert(not favorites.frame:IsShown())
    end
    assert(nativeCalls == 0, "Reward links must use the addon")
    assert(#TODOPlannerDB.tasks == taskCount, "Viewing must not create tasks")
    assert(TODOPlannerDB.settings.collectionStatusFilter == savedStatus, "Saved filter default stays intact")
    explorer.previewAchievementButton:GetScript("OnClick")()
    assert(nativeCalls == 1, "The existing native button on achievement rows remains available")
end)

test("linked achievements use their catalog patch and unlisted IDs stay local", function()
    local explorer = TDP.CollectionExplorerWindow:New()
    explorer:OpenAchievement(63715, "3.0")
    assert(explorer.selectedPatch == "12.1.5" and explorer.selectedRow.entry == 63715)
    local originalCount = #catalog:GetEntries("12.1.5", "achievements")
    explorer:OpenAchievement(999999, "12.1.5")
    assert(explorer.selectedRow.entry == 999999)
    assert(#catalog:GetEntries("12.1.5", "achievements") == originalCount)
    assert(#explorer:GetEntriesForView("12.1.5", "achievements") == originalCount + 1)
    assert(#TDP.CollectionExplorerWindow:New():GetEntriesForView("12.1.5", "achievements") == originalCount)
end)

test("source buttons hide when selection is cleared or a vendor item is selected", function()
    for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
        local window = class:New()
        window:Build()
        window.selectedRow = { collectionType = "mounts", patchKey = "12.1.5",
            entry = catalog:GetEntries("12.1.5", "mounts")[2] }
        window:RenderPreview()
        assert(window.previewAchievementButton:IsShown())
        window.selectedRow.entry = catalog:GetEntries("12.1.5", "mounts")[1]
        window:RenderPreview()
        assert(not window.previewAchievementButton:IsShown())
        window.selectedRow = nil
        window:RenderPreview()
        assert(not window.previewAchievementButton:IsShown())
    end
end)
print("Collection acquisition tests passed: " .. passed)
