local ADDON_NAME, TDP = ...

local COLLECTION_CACHE_EVENTS = {
    "NEW_MOUNT_ADDED",
    "MOUNT_JOURNAL_USABILITY_CHANGED",
    "PET_JOURNAL_LIST_UPDATE",
    "NEW_TOY_ADDED",
    "TOYS_UPDATED",
    "BAG_UPDATE_DELAYED",
    "COMPANION_LEARNED",
    "LEARNED_SPELL_IN_TAB",
    "SPELLS_CHANGED",
    "ACHIEVEMENT_EARNED",
    "CRITERIA_UPDATE",
}

local COLLECTION_CACHE_EVENT_LOOKUP = {}
for _, eventName in ipairs(COLLECTION_CACHE_EVENTS) do
    COLLECTION_CACHE_EVENT_LOOKUP[eventName] = true
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
        elseif event == "ACHIEVEMENT_EARNED" or event == "CRITERIA_UPDATE" then
            self.addon.Achievements:ScheduleAutoCompleteRefresh()
        end

        if COLLECTION_CACHE_EVENT_LOOKUP[event] then
            self:ScheduleCollectionCacheRefresh()
        end
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
