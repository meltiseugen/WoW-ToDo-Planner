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

local function equal(actual, expected, message)
    assert(actual == expected, message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local passed = 0
local function test(name, callback)
    C_Item, C_TransmogCollection, GetItemInfoInstant = nil, nil, nil
    TODOPlannerDB = { settings = {} }
    TDP.Database:Init()
    TDP.CollectionScanner:ResetCache()
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function filterWindow(collectionType)
    local window = TDP.CollectionExplorerWindow:New()
    window.selectedCollectionType = collectionType
    window.Render = function() end
    return window
end

test("source selections are independent, compose, reset to All, and survive recreation", function()
    TODOPlannerDB.settings.collectionMountSourceFilters = { PvP = true }
    local window = filterWindow("pets")
    window:ToggleSource("Vendor", true)
    window:ToggleSource("Quest Rewards", true)
    equal(window:GetSourceSelectionSummary(), "2 selected", "multi-selection")
    equal(window:SourceCategoryMatchesFilter("pets", "Vendor"), true, "first source matches")
    equal(window:SourceCategoryMatchesFilter("pets", "Quest Rewards"), true, "second source matches")
    equal(window:SourceCategoryMatchesFilter("pets", "Treasure"), false, "unselected source")
    window.selectedCollectionType = "toys"
    equal(window:IsSourceChecked("all"), true, "toys start unfiltered")
    window:ToggleSource("Professions", true)
    window.selectedCollectionType = "cosmetics"
    window:ToggleSource("Delves", true)
    TDP.Database:Init()
    local restored = filterWindow("pets")
    equal(restored:IsSourceChecked("Vendor"), true, "restored pet source")
    restored.selectedCollectionType = "toys"
    equal(restored:GetSourceSelectionSummary(), "Professions", "restored toy source")
    restored.selectedCollectionType = "cosmetics"
    equal(restored:GetSourceSelectionSummary(), "Delves", "restored cosmetic source")
    restored.selectedCollectionType = "mounts"
    equal(restored:GetSourceSelectionSummary(), "PvP", "legacy mount selection retained")
    restored.selectedCollectionType = "all"
    equal(restored:SourceCategoryMatchesFilter("pets", "Treasure"), true, "hidden filters do not restrict All tab")
    restored.selectedCollectionType = "pets"
    restored:ToggleSource("all", true)
    equal(restored:IsSourceChecked("all"), true, "All clears selections")
    equal(restored:IsSourceChecked("Vendor"), false, "old check cleared")
end)

test("sources use catalog acquisition methods and imported journal descriptions", function()
    local window = filterWindow("pets")
    local function category(kind, source)
        return window:GetSourceCategory(kind, "unused", { name = "Vendor Quest Raid Hat", source = source })
    end
    equal(category("pets", "Vendor: Collector / Zone: Test"), "Vendor", "vendor")
    equal(category("pets", "Pet Battle: Emerald Dream"), "Pet Battles", "wild pet")
    equal(category("toys", "Profession: Engineering"), "Professions", "crafted toy")
    equal(category("toys", "Quest: Delivery / Zone: Test"), "Quest Rewards", "quest toy")
    equal(category("toys", "Treasure: Hidden Cache"), "Treasure", "treasure toy")
    equal(category("cosmetics", "Raid Bonus Loot"), "Dungeon and Raids", "raid takes precedence over drop")
    equal(category("toys", "not recorded"), "Other", "unknown source remains reachable")
    equal(window:GetSourceCategory("pets", "10.2", { name = "Flooftalon" }), "Pet Battles", "Pet Journal metadata")
    equal(window:GetSourceCategory("pets", "10.2", { name = "Sergeant Quackers" }), "Achievements", "raid achievement is an achievement reward")
    equal(window:GetSourceCategory("cosmetics", "12.1.5", { name = "Amani Effigy" }), "Delves", "Delve treasure")
    equal(window:GetSourceCategory("cosmetics", "12.1.5", { name = "Blade of the Blood Knight Matriarch" }), "Quest Rewards", "campaign reward")
end)

test("cosmetic types use item classes, equipment slots, and learned appearance categories", function()
    local window = filterWindow("cosmetics")
    C_Item = { GetItemInfoInstant = function(id)
        if id == 1 then return id, "Localized", "Localized", "INVTYPE_RANGED", nil, 2, 2 end
        if id == 2 then return id, "Localized", "Localized", "INVTYPE_WEAPON", nil, 2, 7 end
        if id == 3 then return id, "Localized", "Localized", "INVTYPE_ROBE", nil, 4, 1 end
        if id == 4 then return id, "Localized", "Localized", "INVTYPE_CLOAK", nil, 4, 1 end
        if id == 5 then return id, "Localized", "Localized", "INVTYPE_LEGS", nil, 4, 1 end
        return id, "Consumable", "Other", "", nil, 0, 8
    end }
    C_TransmogCollection = {
        GetItemInfo = function(id) if id == 6 then return 123, 456 end end,
        GetCategoryForItem = function(sourceID) equal(sourceID, 456, "source ID, not appearance ID"); return 2 end,
    }
    equal(window:GetCosmeticType({ itemId = 1 }), "weapons:bows", "bow")
    equal(window:GetCosmeticType({ itemId = 2 }), "weapons:1hSwords", "one-handed sword")
    equal(window:GetCosmeticType({ itemId = 3 }), "armour:chest", "robes are chest armour")
    equal(window:GetCosmeticType({ itemId = 4 }), "armour:back", "back")
    equal(window:GetCosmeticType({ itemId = 5 }), "armour:legs", "legs")
    equal(window:GetCosmeticType({ itemId = 6 }), "armour:shoulders", "appearance token")
    equal(window:GetCosmeticType({ itemId = 7, subtype = "ensemble" }), "armour:sets", "ensemble")
    equal(window:GetCosmeticType({ itemId = 8, subtype = "arsenal" }), "weapons:sets", "arsenal")
    equal(window:GetCosmeticType({ itemId = 9, subtype = "illusion" }), "weapons:illusions", "illusion")
    window:SetCosmeticTypeFilter("weapons")
    equal(window:CosmeticTypeMatchesFilter("weapons:bows"), true, "Weapons includes bows")
    equal(window:CosmeticTypeMatchesFilter("armour:legs"), false, "Weapons excludes armour")
    window:SetCosmeticTypeFilter("armour:back")
    equal(window:CosmeticTypeMatchesFilter("armour:back"), true, "specific armour slot")
    equal(window:CosmeticTypeMatchesFilter("armour:legs"), false, "different armour slot")
    TDP.Database:Init()
    equal(filterWindow("cosmetics"):GetCosmeticTypeFilter(), "armour:back", "saved type restored")
    equal(window:SetCosmeticTypeFilter("invalid"), false, "invalid selection rejected")
end)

test("unavailable item data remains in All and is reclassified after it loads", function()
    local window = filterWindow("cosmetics")
    local loaded, requests = false, 0
    C_Item = {
        GetItemInfoInstant = function(id)
            if loaded then return id, "Armour", "Plate", "INVTYPE_LEGS", nil, 4, 4 end
        end,
        IsItemDataCachedByID = function() return loaded end,
        RequestLoadItemDataByID = function() requests = requests + 1 end,
    }
    equal(window:GetCosmeticType({ itemId = 100 }), "other", "pending classification")
    equal(window:CosmeticTypeMatchesFilter("other"), true, "All retains pending items")
    window:GetCosmeticType({ itemId = 100 })
    equal(requests, 1, "one load request per item")
    loaded = true
    equal(window:GetCosmeticType({ itemId = 100 }), "armour:legs", "retry succeeds without recreating window")
    C_Item.GetItemInfoInstant = function() error("unavailable API") end
    equal(window:GetCosmeticType({ itemId = 100 }), "other", "API failure is safe")
end)

test("source and cosmetic filters combine with status, search, patch, and Nearby snapshots", function()
    local window = filterWindow("cosmetics")
    window.searchEdit = { GetText = function() return "target" end }
    window.selectedStatus = "missing"
    window.nearbySnapshot = {
        patchKeys = { "12.1.5" },
        entries = { ["12.1.5"] = { cosmetics = {
            { itemId = 990001, name = "Target bow", source = "Vendor: A" },
            { itemId = 990002, name = "Target bow drop", source = "Drop: B" },
            { itemId = 990003, name = "Target legs", source = "Vendor: A" },
            { itemId = 990004, name = "Different bow", source = "Vendor: A" },
            { itemId = 990005, name = "Target collected bow", source = "Vendor: A" },
        } } },
    }
    C_Item = { GetItemInfoInstant = function(id)
        if id == 990003 then return id, "Armour", "Plate", "INVTYPE_LEGS", nil, 4, 4 end
        return id, "Weapon", "Bow", "INVTYPE_RANGED", nil, 2, 2
    end }
    C_TransmogCollection = { PlayerHasTransmogByItemInfo = function(id) return id == 990005 end }
    window:ToggleSource("Vendor", true)
    window:SetCosmeticTypeFilter("weapons:bows")
    window:BuildVisibleRows()
    equal(#window.visibleRows, 1, "all filters intersect")
    equal(window.visibleRows[1].entry.itemId, 990001, "correct matching entry")
    equal(window.visibleRows[1].patchKey, "12.1.5", "patch preserved")
    window.selectedCollectionType = "all"
    window:BuildVisibleRows()
    equal(#window.visibleRows, 3, "All ignores hidden source and type filters")
end)

test("dropdowns appear on the right tabs, apply immediately, scroll, and close on tab changes", function()
    local window = TDP.CollectionExplorerWindow:New():Build()
    for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics", "achievements" }) do
        window.typeTabs[kind]:GetScript("OnClick")()
        equal(window.sourceButton:IsShown(), window:HasSourceFilter(kind), kind .. " Sources visibility")
        equal(window.weaponTypeButton:IsShown(), kind == "cosmetics", kind .. " Weapons visibility")
        equal(window.armourTypeButton:IsShown(), kind == "cosmetics", kind .. " Armour visibility")
        equal(window.achievementCategoryButton:IsShown(), kind == "achievements", kind .. " achievement visibility")
    end
    window.typeTabs.pets:GetScript("OnClick")()
    window.sourceButton:GetScript("OnClick")(window.sourceButton)
    local sources = TDP.Widgets.multiSelectMenuFrame
    local vendorIndex = TDP.Utils:IndexOf(window:GetSourceOptions(), "Vendor")
    local checkbox = sources.checkboxes[vendorIndex]
    checkbox.GetChecked = function() return true end
    checkbox:GetScript("OnClick")(checkbox)
    equal(window:IsSourceChecked("Vendor"), true, "source checkbox applies")
    equal(sources:IsShown(), true, "multi-select stays open")
    window.typeTabs.cosmetics:GetScript("OnClick")()
    equal(sources:IsShown(), false, "changing category closes old menu")
    equal(window.weaponTypeButton:GetParent(), window.toolbar, "Weapons directly in toolbar")
    equal(window.armourTypeButton:GetParent(), window.toolbar, "Armour directly in toolbar")
    equal(window.filtersButton, nil, "no Filters button")
    window.weaponTypeButton:GetScript("OnClick")(window.weaponTypeButton)
    local menu = TDP.Widgets.menuFrame
    equal(menu.buttons[2].label:GetText(), "All Weapons", "Weapons group at top")
    equal(menu.buttons[3].label:GetText(), "Bows", "weapon types only")
    menu.buttons[3]:GetScript("OnClick")()
    equal(window:GetCosmeticTypeFilter(), "weapons:bows", "Weapons selection applies")
    equal(window.weaponTypeButton.label:GetText(), "Bows", "selected weapon remains visible")
    equal(window.armourTypeButton.label:GetText(), "All types", "Armour is inactive")
    window.armourTypeButton:GetScript("OnClick")(window.armourTypeButton)
    equal(menu.buttons[2].label:GetText(), "All Armour", "Armour group at top")
    local index = TDP.Utils:IndexOf(window:GetCosmeticGroupOptions("armour"), "armour:back")
    for _ = 1, index - 1 do menu:GetScript("OnMouseWheel")(menu, -1) end
    menu.buttons[1]:GetScript("OnClick")()
    equal(window:GetCosmeticTypeFilter(), "armour:back", "scrolled Type selection")
    equal(window.weaponTypeButton.label:GetText(), "All types", "weapon restriction clears")
    equal(window.armourTypeButton.label:GetText(), "Back", "selected armour remains visible")
    equal(menu:IsShown(), false, "single-select closes after selection")
    local recreated = TDP.CollectionExplorerWindow:New():Build()
    recreated:Render()
    equal(recreated:GetCosmeticTypeFilter(), "armour:back", "type selection survives recreation")
    equal(recreated.armourTypeButton.label:GetText(), "Back", "restored selection visible")
end)

test("Collections and Favorites list sources and cosmetic slots in each row, including All", function()
    C_Item = { GetItemInfoInstant = function(id)
        if id == 284052 then return id, "Armour", "Other", "INVTYPE_HOLDABLE", nil, 4, 0 end
    end }
    local expected = {
        ["Aqir Razorwing"] = "Pets - Reputation Vendor - Missing",
        ["Curse of the Aqir"] = "Toys - Reputation Vendor - Missing",
        ["Amani Effigy"] = "Armour: Off-Hands - Delve Treasure - Missing",
    }
    for kind, name in pairs({ pets = "Aqir Razorwing", toys = "Curse of the Aqir", cosmetics = "Amani Effigy" }) do
        for _, entry in ipairs(TDP.PatchCatalog:GetEntries("12.1.5", kind)) do
            if entry.name == name then TDP.Favorites:Add("12.1.5", kind, entry) end
        end
    end
    local explorer = TDP.CollectionExplorerWindow:New():Build()
    explorer.selectedCollectionType = "all"
    explorer:Render()
    local favorites = TDP.FavoritesWindow:New():Build()
    favorites:Render()
    for _, window in ipairs({ explorer, favorites }) do
        local found = 0
        for _, row in ipairs(window.rowPool) do
            local name = row.rowData and row.rowData.name
            if expected[name] then
                local text = window == explorer and expected[name]:gsub(" %- Missing$", " - Patch 12.1.5") or expected[name]
                equal(row.meta:GetText(), text, name .. " row metadata")
                found = found + 1
            end
        end
        equal(found, 3, "all three screenshot examples rendered")
    end
    favorites.searchEdit:SetText("Reputation")
    favorites:Render()
    equal(#favorites.visibleRows, 2, "displayed source descriptions are searchable")
    explorer.selectedPatch = "all"
    explorer:Render()
    for _, row in ipairs(explorer.rowPool) do
        if row:IsShown() and row.rowData.name == "Amani Effigy" then
            equal(row.meta:GetText(), expected["Amani Effigy"]:gsub(" %- Missing$", " - Patch 12.1.5"), "patch scope retained beside source and type")
        end
    end
end)

test("wrapped row metadata grows the row and advances following rows in both windows", function()
    for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
        local window = class:New():Build()
        window.selectedStatus = "all"
        window.visibleRows = {
            { collectionType = "cosmetics", patchKey = "12.1.5", entry = { itemId = 990001 }, name = "Long metadata",
                cosmeticType = "weapons:1hSwords", sourceCategory = "Dungeon and Raids", collected = true },
            { collectionType = "toys", patchKey = "12.1.5", entry = { itemId = 990002 }, name = "Short metadata", sourceCategory = "Vendor" },
        }
        local first, second = window:BuildRow(window.listContent), window:BuildRow(window.listContent)
        first.meta.GetStringHeight = function() return 48 end
        local secondOffset
        local setPoint = second.SetPoint
        second.SetPoint = function(self, point, relative, relativePoint, x, y)
            secondOffset = y
            setPoint(self, point, relative, relativePoint, x, y)
        end
        window.rowPool = { first, second }
        if class == TDP.CollectionExplorerWindow then
            window:BuildRows()
            window.rowMeasureMeta.GetStringHeight = function(target)
                return target:GetText():find("One-Handed", 1, true) and 48 or 16
            end
        end
        window:BuildRows()
        assert(first:GetHeight() > window.Config.ROW_HEIGHT, "wrapped row must grow")
        assert(secondOffset <= -(first:GetHeight() + window.Config.ROW_GAP), "next row must clear wrapped metadata")
        local expected = class == TDP.CollectionExplorerWindow
            and "Weapons: One-Handed Swords - Dungeon and Raids - Patch 12.1.5 - Collected"
            or "Weapons: One-Handed Swords - Dungeon and Raids - Collected"
        equal(first.meta:GetText(), expected, "source, type and status retained")
    end
end)

print("Collection filter tests passed: " .. passed)
