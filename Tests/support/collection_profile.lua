local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
mock.recording = false
local TDP = {}
local function load(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function manifest(path) assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path) end
local function heap() collectgarbage("collect"); return collectgarbage("count") / 1024 end
local base = heap()
load("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
load("Core/Constants.lua")
load("Core/Utils.lua")
load("Core/Theme.lua")
load("Data/Persistence/BoardManager.lua")
load("Data/Persistence/TaskRepository.lua")
load("Data/Persistence/Database.lua")
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
print(string.format("catalog_retained_mb=%.3f", heap() - base))
load("Data/Persistence/Favorites.lua")
load("Integrations/CollectionScanner.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local catalog = TDP.PatchCatalog
local calls = { payload = 0, keys = 0, achievement = 0 }
for name, counter in pairs({ GetCollectionMapPayload = "payload", GetPatchKeys = "keys" }) do
    local original = catalog[name]
    catalog[name] = function(self, ...) calls[counter] = calls[counter] + 1; return original(self, ...) end
end
GetAchievementInfo = function(id)
    calls.achievement = calls.achievement + 1
    return id, "Achievement " .. id, 0, false, nil, nil, nil, "", nil, nil, ""
end
TDP.CollectionScanner.GetState = function(_, _, entry) return { name = entry.name, collected = false } end
TDP.CollectionScanner.GetDisplayName = function(_, _, entry) return entry.name end
local w = TDP.CollectionExplorerWindow:New():Build()
w.selectedCollectionType, w.selectedStatus, w.selectedExpansion, w.selectedPatch = "mounts", "all", "9", "all"
w.listScroll.GetVerticalScroll = function(target) return target.testScroll or 0 end
w.listScroll.SetVerticalScroll = function(target, value) target.testScroll = value end
w:Render()
local function scrollWork()
    for iteration = 1, 200 do
        local offset = (iteration * 97) % 8000
        w.listScroll.testScroll = offset
        w:UpdateVisibleRows(offset)
    end
end
scrollWork() -- Warm all bindings and lazy data before measuring.
calls.payload, calls.keys, calls.achievement = 0, 0, 0
local frames, before = mock.serial, heap()
collectgarbage("stop")
local clock = os.clock()
scrollWork()
local seconds, allocated = os.clock() - clock, collectgarbage("count") / 1024 - before
collectgarbage("restart")
local scrollMetrics = { allocated = allocated, seconds = seconds, newObjects = mock.serial - frames,
    payloads = calls.payload, patchSorts = calls.keys, achievementQueries = calls.achievement }
print(string.format("mount_rows=%d scroll_200_seconds=%.4f allocated_mb=%.3f retained_mb=%.4f new_ui_objects=%d payloads=%d patch_sorts=%d achievement_queries=%d",
    #w.visibleRows, seconds, allocated, heap() - before, mock.serial - frames, calls.payload, calls.keys, calls.achievement))
local start, retained = os.clock(), heap()
for iteration = 1, 20 do TDP.CollectionScanner:ResetCache(); w:Render() end
print(string.format("refresh_20_seconds=%.4f retained_growth_mb=%.4f total_heap_mb=%.3f", os.clock() - start, heap() - retained, heap()))
for _, patch in ipairs(catalog:GetPatchKeys()) do
    for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics" }) do
        for _, entry in ipairs(catalog:GetEntries(patch, kind)) do catalog:GetCollectionSourceInfo(kind, patch, entry) end
    end
end
local allSources = heap()
for iteration = 1, 5 do
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics" }) do
            for _, entry in ipairs(catalog:GetEntries(patch, kind)) do catalog:GetCollectionSourceInfo(kind, patch, entry) end
        end
    end
end
local allSourcesHeap, allSourcesGrowth = heap(), heap() - allSources
print(string.format("all_sources_total_heap_mb=%.3f repeat_all_sources_growth_mb=%.4f", allSourcesHeap, allSourcesGrowth))
scrollMetrics.allSourcesHeap, scrollMetrics.allSourcesGrowth = allSourcesHeap, allSourcesGrowth
return TDP, w, mock, calls, scrollMetrics
