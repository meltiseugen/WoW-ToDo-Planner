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
    "PLAYER_ENTERING_WORLD",
}

local COLLECTION_CACHE_EVENT_LOOKUP = {}
for _, eventName in ipairs(COLLECTION_CACHE_EVENTS) do
    COLLECTION_CACHE_EVENT_LOOKUP[eventName] = true
end

local LOCATION_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA",
}

local LOCATION_EVENT_LOOKUP = {}
for _, eventName in ipairs(LOCATION_EVENTS) do
    LOCATION_EVENT_LOOKUP[eventName] = true
end

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
    for _, eventName in ipairs(LOCATION_EVENTS) do
        if not COLLECTION_CACHE_EVENT_LOOKUP[eventName] then
            pcall(self.frame.RegisterEvent, self.frame, eventName)
        end
    end
end

function Bootstrap:RenderVisibleCollectionWindow(window)
    if not window or not window.frame or not window.frame:IsShown() or type(window.Render) ~= "function" then
        return
    end

    local ok, errorText = pcall(window.Render, window)
    if not ok and self.addon.Utils then
        self.addon.Utils:Msg("Collections refresh failed: " .. tostring(errorText))
    end
end

function Bootstrap:RefreshCollectionCache()
    if self.addon.CollectionScanner then
        self.addon.CollectionScanner:ResetCache()
    end

    local tasksChanged = self.addon.CollectionTaskProgress
        and self.addon.CollectionTaskProgress:AutoCompleteTasks()
    if self.addon.LocationAwareness then
        self.addon.LocationAwareness:Refresh(false)
    end
    if tasksChanged and self.addon.ui then
        self.addon.ui:Render()
    end

    self:RenderVisibleCollectionWindow(self.addon.explorerWindow)
    self:RenderVisibleCollectionWindow(self.addon.favoritesWindow)
end

function Bootstrap:ScheduleCollectionCacheRefresh()
    if self.collectionRefreshQueued then
        return
    end

    self.collectionRefreshQueued = true
    local refresh = function()
        self.collectionRefreshQueued = false
        self:RefreshCollectionCache()
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
        self.addon.ui = self.addon.HomeWindow:New(self.addon):Build()
        self.addon.ui:SetWindows(self.addon.plannerWindow, self.addon.explorerWindow, self.addon.favoritesWindow)
        self.addon.MinimapButton:Init()
        self.addon.SlashCommands:Init()
        self.addon.Achievements:Init()
        self:RegisterCollectionCacheEvents()
        self:ScheduleCollectionCacheRefresh()
        if self.addon.LocationAwareness then
            self.addon.LocationAwareness:ScheduleRefresh(true)
        end

        self.addon.Utils:Msg("Loaded. Use /tdp to open your board.")
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
            self:ScheduleCollectionCacheRefresh()
        end
        if LOCATION_EVENT_LOOKUP[event] and self.addon.LocationAwareness then
            self.addon.LocationAwareness:ScheduleRefresh(true)
        end
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
