local root = arg and arg[1] or "."
local TDP, window, mock, calls, measurements = assert(loadfile(root .. "/Tests/support/collection_profile.lua"))()
local catalog = TDP.PatchCatalog
local passed = 0
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end

test("real catalog scrolling has bounded allocations and does not build map payloads or sort patches", function()
    assert(measurements.allocated < 8, "200 warmed scroll updates must allocate less than 8 MB")
    assert(measurements.newObjects == 0, "Scrolling must reuse existing UI objects")
    assert(measurements.payloads == 0, "Painting list shortcuts must not construct map payloads")
    assert(measurements.patchSorts == 0, "Repeated scrolling must not sort patch keys per row")
    assert(measurements.allSourcesHeap < 30, "Full offline catalog/source heap exceeds the 30 MB budget")
    assert(math.abs(measurements.allSourcesGrowth) < 0.1, "Repeated source browsing must not retain new memory")
    local cached, slots = 0, 0
    for _ in pairs(catalog.collectionSourceCache or {}) do cached = cached + 1 end
    for _ in pairs(catalog.collectionSourceCacheSlots or {}) do slots = slots + 1 end
    assert(cached <= 512 and slots <= 512, "Rich source data must be evicted after 512 entries")
end)

test("map capability agrees with actual payloads for the entire catalog", function()
    local original = catalog.GetCollectionMapPayload
    local count = 0
    catalog.GetCollectionMapPayload = function(self, ...) count = count + 1; return original(self, ...) end
    for _, patch in ipairs(catalog:GetPatchKeys()) do
        for _, kind in ipairs({ "mounts", "pets", "toys", "cosmetics", "achievements" }) do
            for _, entry in ipairs(catalog:GetEntries(patch, kind)) do
                local expected = original(catalog, kind, patch, entry) ~= nil
                assert(catalog:HasCollectionMapPayload(kind, patch, entry) == expected, kind .. ":" .. patch)
            end
        end
    end
    assert(count == 0, "Capability checks must not build payloads")
    catalog.GetCollectionMapPayload = original
end)

test("missing achievement data cannot be requested repeatedly by painted rows", function()
    local oldApi, oldTime = GetAchievementInfo, GetTime
    local queries, now = 0, 100
    GetAchievementInfo = function() queries = queries + 1 end
    GetTime = function() return now end
    catalog.sourceAchievementNames = nil
    local entry = { name = "Missing reward", sourceType = "Achievement", source = "Missing goal" }
    catalog:GetCollectionSourceAchievementId("mounts", "12.1.5", entry)
    local first = queries
    assert(first > 0)
    for iteration = 1, 100 do catalog:GetCollectionSourceAchievementId("mounts", "12.1.5", entry) end
    assert(queries == first, "Missing names should not be retried on every row paint")
    now = 106
    catalog:GetCollectionSourceAchievementId("mounts", "12.1.5", entry)
    assert(queries == first * 2, "Unavailable API data can retry after the backoff")
    GetAchievementInfo, GetTime = oldApi, oldTime
end)

test("automatic collection refresh retains static seller destinations", function()
    local vendor, quest = { kind = "Vendor", waypoints = {} }, { kind = "Quest Rewards", questID = 1 }
    catalog.collectionSourceCache = { vendor = vendor, quest = quest }
    local mounts = {}
    TDP.CollectionScanner.mountSpellIndex, TDP.CollectionScanner.petSpeciesCounts = mounts, {}
    TDP.CollectionScanner:ResetCache(true, { pets = true })
    assert(TDP.CollectionScanner.mountSpellIndex == mounts and TDP.CollectionScanner.petSpeciesCounts == nil,
        "Pet changes must not invalidate the mount journal")
    TDP.CollectionScanner:ResetCache(true)
    assert(catalog.collectionSourceCache.vendor == vendor and catalog.collectionSourceCache.quest == quest)
    catalog:ResetCollectionSourceCache(true)
    assert(catalog.collectionSourceCache.vendor == vendor and catalog.collectionSourceCache.quest == nil)
    TDP.CollectionScanner:ResetCache()
    assert(catalog.collectionSourceCache == nil, "Explicit Refresh must still invalidate everything")
end)

test("unrelated data events do not rebuild lists and relevant events coalesce", function()
    local queued, renders, scans, tasks, resets = {}, 0, 0, 0, 0
    C_Timer = { After = function(_, callback) queued[#queued + 1] = callback end }
    local addon = {
        EventFrame = CreateFrame("Frame"),
        PatchCatalog = { collectionSourceQuestRequests = {}, collectionSourceCostItemRequests = { [789] = true },
            ResetCollectionSourceCache = function() resets = resets + 1 end },
        CollectionScanner = { ResetCache = function(_, preserve) assert(preserve); scans = scans + 1 end },
        CollectionTaskProgress = { AutoCompleteTasks = function() tasks = tasks + 1 end },
        explorerWindow = { frame = CreateFrame("Frame"), visibleRows = { { entry = { itemId = 123 } } },
            cosmeticTypeRequests = { [456] = true }, Render = function() renders = renders + 1 end },
    }
    assert(loadfile(root .. "/Core/Bootstrap.lua"))("TODO-Planner", addon)
    local event = addon.EventFrame:GetScript("OnEvent")
    for iteration = 1, 500 do
        event(nil, "ITEM_DATA_LOAD_RESULT", 999, true)
        event(nil, "QUEST_DATA_LOAD_RESULT", 999, true)
    end
    assert(#queued == 0 and renders == 0 and scans == 0)
    addon.PatchCatalog.collectionSourceQuestRequests[12] = true
    event(nil, "QUEST_DATA_LOAD_RESULT", 12, false)
    assert(#queued == 0 and addon.PatchCatalog.collectionSourceQuestRequests[12] == "failed")
    addon.PatchCatalog.collectionSourceQuestRequests[13] = true
    event(nil, "QUEST_DATA_LOAD_RESULT", 13, true)
    event(nil, "ITEM_DATA_LOAD_RESULT", 456, true) -- A filtered-out appearance classification.
    event(nil, "ITEM_DATA_LOAD_RESULT", 123, true)
    event(nil, "ITEM_DATA_LOAD_RESULT", 789, true) -- A barter cost in the inspected source.
    assert(#queued == 1)
    queued[1]()
    assert(renders == 1 and scans == 0 and tasks == 0 and resets == 1)
    event(nil, "QUEST_DATA_LOAD_RESULT", 13, true)
    event(nil, "ITEM_DATA_LOAD_RESULT", 789, true)
    assert(#queued == 1, "An already handled quest title must not trigger another refresh")
    event(nil, "QUEST_LOG_UPDATE")
    event(nil, "NEW_MOUNT_ADDED")
    assert(#queued == 2)
    queued[2]()
    assert(renders == 2 and scans == 1 and tasks == 1 and resets == 2)
    event(nil, "QUEST_LOG_UPDATE")
    queued[3]()
    assert(scans == 1 and tasks == 2 and resets == 3, "Quest activity must not rescan journals")
    event(nil, "PET_JOURNAL_LIST_UPDATE")
    queued[4]()
    assert(scans == 2, "Collection journal changes must still invalidate ownership")
    C_Timer = nil
end)

print("Collection performance tests passed: " .. passed)
