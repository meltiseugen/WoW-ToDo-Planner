local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
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
load("Integrations/NearbyCollections.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local catalog = TDP.PatchCatalog
local mounts = {}
for index = 1, 500 do
    mounts[index] = { spellId = 900000 + index, name = string.format("Mount %03d", index), category = "Vendor" }
end
catalog.patches = {
    ["12.0"] = { mounts = { { spellId = 900001, name = "Earlier mount", category = "Vendor" } }, achievements = { ids = {} } },
    ["12.1.5"] = { mounts = mounts, pets = { { speciesId = 910001, name = "Pet", category = "Vendor" } },
        toys = { { itemId = 920001, name = "Toy", source = "Vendor" } }, achievements = { ids = {} } },
}
TDP.CollectionScanner.GetState = function(_, _, entry)
    return { name = entry.name, collected = false, modelId = entry.spellId and 12345 or nil }
end
TDP.CollectionScanner.GetDisplayName = function(_, _, _, state) return state.name end
local function equal(a, b, label) assert(a == b, label .. ": expected " .. tostring(b) .. ", got " .. tostring(a)) end
local passed = 0
local function test(name, callback)
    TODOPlannerDB.settings.collectionExplorerWindow = nil
    TODOPlannerDB.settings.collectionStatusFilter = "missing"
    TODOPlannerDB.settings.collectionMountSourceFilters = {}
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function scrollable(window)
    window.listScroll.GetVerticalScroll = function(target) return target.testScroll or 0 end
    window.listScroll.SetVerticalScroll = function(target, value) target.testScroll = value end
end
local function window()
    local value = TDP.CollectionExplorerWindow:New():Build()
    scrollable(value)
    value:Render()
    return value
end
local function click(button) button:GetScript("OnClick")(button) end

test("compact controls and readable inspector fit every supported size and skin", function()
    for _, themeKey in ipairs({ "midnight", "parchment", "quietBotanical", "quietArcane", "fieldLedger", "minimalVoidglass" }) do
        TODOPlannerDB.settings.visualTheme = themeKey
        TDP.ThemeManager.theme = nil
        TDP.Theme = TDP.ThemeManager:Create()
        equal(TDP.Theme.key, themeKey, "requested skin is active")
        local w = window()
        for _, size in ipairs({ { 1020, 620 }, { 1120, 740 }, { 1800, 1100 } }) do
            w.frame:SetSize(size[1], size[2])
            w.frame:GetScript("OnSizeChanged")(w.frame)
            local total = 40
            for _, control in ipairs({ w.expansionButton, w.patchButton, w.statusButton,
                w.sourceButton, w.nearbyButton, w.refreshButton }) do total = total + control:GetWidth() end
            equal(total, w.body:GetWidth(), "toolbar fits")
            assert(w.searchEdit:GetWidth() >= 200, "search remains usable")
            assert(w.previewTitle:GetWidth() >= 300, "model title spans the inspector")
            assert(w.previewDetailsScroll:GetHeight() >= 100, "model leaves readable acquisition space")
            click(w.typeTabs.cosmetics)
            assert(w.weaponTypeButton:IsShown() and w.armourTypeButton:IsShown(), "both cosmetic dropdowns visible")
            equal(w.searchEdit:GetWidth() + w.weaponTypeButton:GetWidth() + w.armourTypeButton:GetWidth() + 16,
                w.body:GetWidth(), "cosmetic filter row fits")
            assert(w.searchEdit:GetWidth() >= 200, "cosmetic search remains usable")
            click(w.typeTabs.mounts)
        end
    end
    TODOPlannerDB.settings.visualTheme = "midnight"
    TDP.ThemeManager.theme = nil
    TDP.Theme = TDP.ThemeManager:Create()
end)

test("icon entries reclaim the model area and model collapse stays collapsed on refresh", function()
    local w = window()
    local modelTop, modelHeight = w.inspectorDetailsTop, w.previewDetailsScroll:GetHeight()
    w.selectedRow = { collectionType = "toys", patchKey = "12.1.5", entry = { itemId = 920001 }, name = "Toy" }
    w:RenderPreview()
    assert(w.previewIcon:IsShown() and not w.previewVisual:IsShown())
    assert(w.inspectorDetailsTop < modelTop and w.previewDetailsScroll:GetHeight() > modelHeight)
    w.selectedRow = w.visibleRows[1]
    w:RenderPreview()
    click(w.previewToggleButton)
    assert(w.previewCollapsed and not w.previewVisual:IsShown())
    w:Render()
    assert(w.previewCollapsed and not w.previewVisual:IsShown(), "collection refresh preserves collapse")
    click(w.previewToggleButton)
    assert(w.previewVisual:IsShown(), "model can be restored")
end)

test("acquisition and currency precede optional metadata without losing notes", function()
    local w = window()
    w.GetRowNotes = function() return "Cosmetic Type: Appearance\nSource: Vendor\nHow to get: Buy it.\nCost: 600 currency\nResearch notes: Recorded evidence" end
    w:RenderPreview()
    local text = w.previewDetails.rawPreviewText
    assert(text:find("How to get", 1, true) < text:find("Source", 1, true))
    assert(text:find("Cost: 600 currency", 1, true))
    assert(not text:find("Recorded evidence", 1, true))
    click(w.previewMoreButton)
    assert(w.previewDetails.rawPreviewText:find("Recorded evidence", 1, true))
    assert(w.previewDetails.rawPreviewText:find("Cosmetic Type: Appearance", 1, true))
end)

test("large catalogs use a bounded pool and scroll rebinds shortcuts to the visible entries", function()
    local w = window()
    equal(#w.visibleRows, 500, "full catalog remains searchable")
    assert(#w.rowPool < 20, "offscreen entries do not create frames")
    w.listScroll:SetVerticalScroll(20000)
    w.listScroll:GetScript("OnVerticalScroll")(w.listScroll, 20000)
    local target = w.rowPool[2]
    assert(tonumber(target.rowData.entry.spellId) > 900300, "scroll reaches later entries")
    local selected = target.rowData
    click(target.favoriteButton)
    assert(TDP.Favorites:IsFavorite(selected.patchKey, selected.collectionType, selected.entry), "favorite targets the rebound entry")
    assert(#w.rowPool < 20, "scrolling reuses the bounded pool")
end)

test("refresh, favorite actions and recreation retain selection and scroll without changing tasks", function()
    local w = window()
    local tasks, favorites = TODOPlannerDB.tasks, TODOPlannerDB.favorites
    w.selectedRow = w.visibleRows[200]
    w.listScroll:SetVerticalScroll(10000)
    local key = w:GetRowKey(w.selectedRow)
    click(w.refreshButton)
    equal(w:GetRowKey(w.selectedRow), key, "refresh selection")
    equal(w.listScroll:GetVerticalScroll(), 10000, "refresh scroll")
    w.frame:SetSize(1280, 840)
    w:SaveBrowserState()
    local recreated = TDP.CollectionExplorerWindow:New():Build()
    scrollable(recreated)
    recreated:Render()
    equal(recreated:GetRowKey(recreated.selectedRow), key, "recreated selection")
    equal(recreated.listScroll:GetVerticalScroll(), 10000, "recreated scroll")
    equal(recreated.frame:GetWidth(), 1280, "saved size")
    equal(TODOPlannerDB.tasks, tasks, "tasks unchanged")
    equal(TODOPlannerDB.favorites, favorites, "favorites table unchanged")
end)

test("native scroll range changes during layout cannot replace the requested position", function()
    local w = window()
    w.listScroll:SetVerticalScroll(10000)
    w.selectedRow = w.visibleRows[200]
    local key = w:GetRowKey(w.selectedRow)
    -- Native layout can clamp the offset before the scroll-child rect is current.
    -- Unlike the basic frame mock, dispatch the resulting scroll notification.
    local function clampDuringLayout()
        w.listScroll:SetVerticalScroll(0)
        w.listScroll:GetScript("OnVerticalScroll")(w.listScroll, 0)
    end
    local setScrollSize = w.listScroll.SetSize
    w.listScroll.SetSize = function(target, ...)
        setScrollSize(target, ...)
        clampDuringLayout()
    end
    local setContentSize = w.listContent.SetSize
    w.listContent.SetSize = function(target, ...)
        setContentSize(target, ...)
        clampDuringLayout()
    end
    w:Render()
    equal(w.listScroll:GetVerticalScroll(), 10000, "refresh retains the position from before layout")
    equal(w:GetRowKey(w.selectedRow), key, "refresh retains selection")
    equal(TODOPlannerDB.settings.collectionExplorerWindow.scroll, 10000, "transient zero is not persisted")
    w:LayoutExplorer()
    equal(w.listScroll:GetVerticalScroll(), 10000, "resize retains the position from before layout")
end)

test("mount assets finish loading once and recover the camera after loading", function()
    local w = window()
    w.frame:Show()
    local model = w.creaturePreviewModel
    local loads = 0
    function model:SetDisplayInfo(id)
        assert(w.previewVisual:IsShown() and w.previewVisual:GetHeight() > 1,
            "lay out the visible model area before starting its asset load")
        loads = loads + 1
        self.displayID = id
    end
    function model:SetCamDistanceScale(value) self.cameraZoom = value end
    function model:SetFacing(value) self.cameraFacing = value end
    function model:SetViewTranslation(x, y) self.cameraX, self.cameraY = x, y end
    -- Switch away first so the next mount starts in a collapsed model container.
    local mount = w.selectedRow
    mount.state.modelId = 54321
    w.selectedRow = { collectionType = "toys", patchKey = "12.1.5", entry = { itemId = 920001 }, name = "Toy" }
    w:RenderPreview()
    w.selectedRow = mount
    w:RenderPreview()
    equal(loads, 1, "one load for the selected mount")
    w.previewModelFacing, w.previewModelPanX, w.previewModelPanY = 0.8, 12, 14
    w.previewModelZoom = 1.7
    -- Asset completion resets the native camera, after the initial SetDisplayInfo call.
    model.cameraZoom, model.cameraFacing, model.cameraX, model.cameraY = nil, nil, nil, nil
    local loaded = model:GetScript("OnModelLoaded")
    assert(loaded, "creature previews handle asynchronous model completion")
    loaded(model)
    equal(model.cameraZoom, 1.7, "camera restored after asynchronous loading")
    equal(model.cameraFacing, 0.8, "rotation restored after asynchronous loading")
    equal(model.cameraX, 12, "horizontal pan restored")
    equal(model.cameraY, 14, "vertical pan restored")
    for _ = 1, 10 do w:RenderPreview() end
    equal(loads, 1, "ordinary refreshes do not restart a pending or loaded model")
    click(w.previewToggleButton)
    click(w.previewToggleButton)
    equal(loads, 1, "collapse and expand keep the same model")
    assert(w.previewVisual:IsShown() and model:IsShown(), "expanded mount remains visible")
end)

test("tab changes restore each list and hiding the window closes all filter controls", function()
    local w = window()
    w.selectedRow = w.visibleRows[120]
    w.listScroll:SetVerticalScroll(6000)
    local key = w:GetRowKey(w.selectedRow)
    click(w.typeTabs.toys)
    equal(w.listScroll:GetVerticalScroll(), 0, "new tab starts at top")
    click(w.typeTabs.mounts)
    equal(w:GetRowKey(w.selectedRow), key, "mount selection restored")
    equal(w.listScroll:GetVerticalScroll(), 6000, "mount scroll restored")
    click(w.sourceButton)
    assert(TDP.Widgets.multiSelectMenuFrame:IsShown())
    w.frame:GetScript("OnHide")(w.frame)
    assert(not TDP.Widgets.multiSelectMenuFrame:IsShown())
end)

test("Nearby reads only on click and returns to the complete browsing view", function()
    local scans = 0
    TDP.NearbyCollections.Scan = function()
        scans = scans + 1
        return { mapID = 100, mapName = "Test zone", total = 1, patchKeys = { "12.1.5" },
            entries = { ["12.1.5"] = { mounts = { mounts[1] } } } }
    end
    local w = window()
    w.selectedRow = w.visibleRows[100]
    w.listScroll:SetVerticalScroll(5000)
    local key = w:GetRowKey(w.selectedRow)
    click(w.nearbyButton)
    equal(scans, 1, "explicit scan")
    w:ToggleSource("Rare Drops", true)
    click(w.refreshButton)
    w:Open()
    equal(scans, 1, "refresh and open do not scan")
    click(w.nearbyButton)
    equal(scans, 1, "cancel does not rescan")
    equal(w.nearbySnapshot, nil, "cancel exits Nearby mode")
    equal(w:GetRowKey(w.selectedRow), key, "Browse selection restored")
    equal(w.listScroll:GetVerticalScroll(), 5000, "Browse scroll restored")
    equal(w.selectedCollectionType, "mounts", "Browse tab restored")
    equal(w:GetSourceSelectionSummary(), "All", "Browse source filters restored")
end)

test("selection keys include patch and removed tabs do not return from saved settings", function()
    local w = window()
    w.selectedPatch = "all"
    w:Render()
    for _, row in ipairs(w.visibleRows) do
        if row.patchKey == "12.0" then w.selectedRow = row; break end
    end
    w:Render()
    equal(w.selectedRow.patchKey, "12.0", "same ID in another patch does not steal selection")
    TODOPlannerDB.settings.collectionExplorerWindow.collectionType = "all"
    local recreated = TDP.CollectionExplorerWindow:New():Build()
    equal(recreated.selectedCollectionType, "mounts", "legacy All selection normalized")
    equal(recreated.typeTabs.all, nil, "removed All tab stays removed")
end)

test("visible source dropdown exposes and clears restrictions without a Filters button", function()
    local w = window()
    w:ToggleSource("Vendor", true)
    equal(w.sourceButton.label:GetText(), "Sources: Vendor", "active source visible")
    equal(w.sourceButton:GetParent(), w.toolbar, "source directly in toolbar")
    equal(w.filtersButton, nil, "Filters button removed")
    equal(w.filterDrawer, nil, "drawer removed")
    w:ToggleSource("all", true)
    equal(w:GetSourceSelectionSummary(), "All", "sources reset")
    equal(w.selectedStatus, "missing", "status retained")
    equal(w.selectedExpansion, "12", "scope retained")
    equal(w.sourceButton.label:GetText(), "Sources: All", "cleared source visible")
end)

test("sorting preserves the selected entry and exposes only counts for matching rows", function()
    local w = window()
    w.selectedPatch = "all"
    w.sortKey = "patch"
    w:Render()
    equal(w.visibleRows[1].patchKey, "12.1.5", "newest patch first")
    w.searchEdit:SetText("Mount 499")
    w.searchEdit:GetScript("OnTextChanged")()
    equal(#w.visibleRows, 1, "search subset")
    equal(w.summaryText:GetText(), "1 matching mounts", "filtered result count")
    assert(w.summaryHelp:find("501 entries before", 1, true), "broader denominator is explicitly labeled")
end)

print("Collector window tests passed: " .. passed)
