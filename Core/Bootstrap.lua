local ADDON_NAME, TDP = ...

local COLLECTION_CACHE_EVENTS = {
    "NEW_MOUNT_ADDED",
    "MOUNT_JOURNAL_USABILITY_CHANGED",
    "PET_JOURNAL_LIST_UPDATE",
    "NEW_TOY_ADDED",
    "TOYS_UPDATED",
    "TRANSMOG_COLLECTION_UPDATED",
    "TRANSMOG_COLLECTION_SOURCE_ADDED",
    "ITEM_DATA_LOAD_RESULT",
    "BAG_UPDATE_DELAYED",
    "COMPANION_LEARNED",
    "LEARNED_SPELL_IN_TAB",
    "SPELLS_CHANGED",
    "ACHIEVEMENT_EARNED",
    "CRITERIA_UPDATE",
    "QUEST_LOG_UPDATE",
    "QUEST_DATA_LOAD_RESULT",
    "PLAYER_ENTERING_WORLD",
}

local COLLECTION_CACHE_EVENT_LOOKUP = {}
for _, eventName in ipairs(COLLECTION_CACHE_EVENTS) do
    COLLECTION_CACHE_EVENT_LOOKUP[eventName] = true
end

local MOUNT_JOURNAL_EVENTS = {
    NEW_MOUNT_ADDED = true, MOUNT_JOURNAL_USABILITY_CHANGED = true,
    COMPANION_LEARNED = true, LEARNED_SPELL_IN_TAB = true, SPELLS_CHANGED = true,
}
local PET_JOURNAL_EVENTS = { PET_JOURNAL_LIST_UPDATE = true, COMPANION_LEARNED = true }

local Bootstrap = {}
Bootstrap.__index = Bootstrap

function Bootstrap:New(addon)
    return setmetatable({
        addon = addon,
        frame = addon.EventFrame,
        collectionRefreshQueued = false,
    }, self)
end

function Bootstrap:RegisterCollectionCacheEvents()
    for _, eventName in ipairs(COLLECTION_CACHE_EVENTS) do
        pcall(self.frame.RegisterEvent, self.frame, eventName)
    end
end

function Bootstrap:RenderVisibleCollectionWindow(window)
    if not window or not window.frame or not window.frame:IsShown() or type(window.Render) ~= "function" then
        return
    end

    local ok, errorText = pcall(window.Render, window)
    if not ok and self.addon.Utils then
        self.addon.Utils:Msg("Collections refresh failed: " .. tostring(errorText), "warnings")
    end
end

function Bootstrap:RefreshCollectionCache(events)
    local dataOnly = events ~= nil
    local journals = { mounts = not events or events.PLAYER_ENTERING_WORLD, pets = not events or events.PLAYER_ENTERING_WORLD }
    for event in pairs(events or {}) do
        if event ~= "QUEST_DATA_LOAD_RESULT" and event ~= "ITEM_DATA_LOAD_RESULT" then dataOnly = false end
        if MOUNT_JOURNAL_EVENTS[event] then journals.mounts = true end
        if PET_JOURNAL_EVENTS[event] then journals.pets = true end
    end
    if self.addon.CollectionScanner and (journals.mounts or journals.pets) then
        self.addon.CollectionScanner:ResetCache(true, journals)
    end
    local catalog = self.addon.PatchCatalog
    if catalog and catalog.ResetCollectionSourceCache then
        if not events or events.PLAYER_ENTERING_WORLD then
            catalog:ResetCollectionSourceCache()
        elseif events.QUEST_LOG_UPDATE or events.QUEST_DATA_LOAD_RESULT then
            catalog:ResetCollectionSourceCache(true)
        end
    end

    local tasksChanged = not dataOnly and self.addon.CollectionTaskProgress
        and self.addon.CollectionTaskProgress:AutoCompleteTasks()
    if tasksChanged and self.addon.ui then
        self.addon.ui:Render()
    end

    self:RenderVisibleCollectionWindow(self.addon.explorerWindow)
    self:RenderVisibleCollectionWindow(self.addon.favoritesWindow)
    if self.addon.collectionMapWindow then
        if not dataOnly then self.addon.collectionMapWindow:RefreshSavedProjectionCriteria() end
        if self.addon.collectionMapWindow.RefreshSourceDestination then self.addon.collectionMapWindow:RefreshSourceDestination() end
    end
end

function Bootstrap:IsRelevantCollectionDataEvent(event, id, success)
    if event == "QUEST_DATA_LOAD_RESULT" then
        local catalog = self.addon.PatchCatalog
        local requests = catalog and catalog.collectionSourceQuestRequests
        if not requests or requests[id] ~= true then return false end
        requests[id] = success and "loaded" or "failed"
        return success == true
    elseif event == "ITEM_DATA_LOAD_RESULT" then
        if not success then return false end
        local catalog = self.addon.PatchCatalog
        local costRequests = catalog and catalog.collectionSourceCostItemRequests
        local costLoaded = costRequests and costRequests[id] == true
        if costLoaded then costRequests[id] = "loaded" end
        for _, name in ipairs({ "explorerWindow", "favoritesWindow" }) do
            local window = self.addon[name]
            if window and window.frame and window.frame:IsShown() then
                if costLoaded then return true end
                if window.cosmeticTypeRequests and window.cosmeticTypeRequests[id] == true then
                    window.cosmeticTypeRequests[id] = "loaded"
                    return true
                end
                for _, row in ipairs(window.visibleRows or {}) do
                    if type(row.entry) == "table" and tonumber(row.entry.itemId) == tonumber(id) then return true end
                end
            end
        end
        return false
    end
    return true
end

function Bootstrap:ScheduleCollectionCacheRefresh(event, id, success)
    if event and not self:IsRelevantCollectionDataEvent(event, id, success) then return end
    self.pendingCollectionEvents = self.pendingCollectionEvents or {}
    self.pendingCollectionEvents[event or "PLAYER_ENTERING_WORLD"] = true
    if self.collectionRefreshQueued then
        return
    end

    self.collectionRefreshQueued = true
    local refresh = function()
        local events = self.pendingCollectionEvents
        self.pendingCollectionEvents = nil
        self.collectionRefreshQueued = false
        self:RefreshCollectionCache(events)
    end

    local timer = _G.C_Timer
    if timer and type(timer.After) == "function" then
        timer.After(0.1, refresh)
    else
        refresh()
    end
end

function Bootstrap:OnAddonLoaded(addonName)
    if addonName == ADDON_NAME then
        self.addon.Database:Init()
        self.addon.ThemeManager:Create()
        self.addon.plannerWindow = self.addon.MainWindow:New():Build()
        self.addon.plannerWindow.optionsWindow = self.addon.OptionsWindow:New(self.addon.plannerWindow)
        self.addon.plannerWindow.optionsWindow:Build()
        self.addon.explorerWindow = self.addon.CollectionExplorerWindow:New():Build()
        self.addon.favoritesWindow = self.addon.FavoritesWindow:New():Build()
        self.addon.collectionMapWindow = self.addon.CollectionMapWindow:New()
        self.addon.collectionMapWindow:RestoreProjections()
        self.addon.ui = self.addon.HomeWindow:New(self.addon):Build()
        self.addon.ui:SetWindows(self.addon.plannerWindow, self.addon.explorerWindow, self.addon.favoritesWindow)
        self.addon.MinimapButton:Init()
        self.addon.SlashCommands:Init()
        self.addon.Achievements:Init()
        self:RegisterCollectionCacheEvents()
        self:ScheduleCollectionCacheRefresh()

        self.addon.Utils:Msg("Loaded. Use /tdp to open your board.", "startup")
    elseif addonName == "Blizzard_AchievementUI" or addonName == "Krowi_AchievementFilter" then
        self.addon.Achievements:Init()
    end
end

function Bootstrap:Init()
    self.frame:RegisterEvent("ADDON_LOADED")
    self.frame:SetScript("OnEvent", function(_, event, ...)
        if event == "ADDON_LOADED" then
            self:OnAddonLoaded(...)
        end

        if COLLECTION_CACHE_EVENT_LOOKUP[event] then
            self:ScheduleCollectionCacheRefresh(event, ...)
        end
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
