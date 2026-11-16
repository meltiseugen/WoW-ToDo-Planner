local ADDON_NAME, TDP = ...

local Bootstrap = {}
Bootstrap.__index = Bootstrap

function Bootstrap:New(addon)
    return setmetatable({ addon = addon, frame = addon.EventFrame, itemDataWindows = {} }, self)
end

-- Ownership is read on user actions. This listener only finishes item metadata
-- explicitly requested by an open browser; it never checks tasks or quests.
function Bootstrap:SetCollectionItemDataActive(window, active)
    self.itemDataWindows[window] = active and true or nil
    if not active then window.pendingLoadedItemIDs = nil end
    if next(self.itemDataWindows) then
        self.frame:RegisterEvent("ITEM_DATA_LOAD_RESULT")
    else
        self.frame:UnregisterEvent("ITEM_DATA_LOAD_RESULT")
    end
end

function Bootstrap:OnItemDataLoaded(id, success)
    local requests = self.addon.CollectionScanner.itemDataRequests
    local requested = requests and requests[id] == true
    if requested then requests[id] = success and "loaded" or nil end
    for window in pairs(self.itemDataWindows) do
        local cosmeticRequested = window.cosmeticTypeRequests and window.cosmeticTypeRequests[id] == true
        if cosmeticRequested then window.cosmeticTypeRequests[id] = success and "loaded" or nil end
        if success and (requested or cosmeticRequested) and window.visibleItemRows and window.visibleItemRows[id] then
            window.pendingLoadedItemIDs = window.pendingLoadedItemIDs or {}
            window.pendingLoadedItemIDs[id] = true
            if not window.itemMetadataRefreshQueued then
                window.itemMetadataRefreshQueued = true
                local owner = window
                local function finishMetadata()
                    owner.itemMetadataRefreshQueued = nil
                    local ids = owner.pendingLoadedItemIDs
                    owner.pendingLoadedItemIDs = nil
                    if ids and owner.frame:IsShown() then owner:RefreshLoadedCollectionItems(ids) end
                end
                if C_Timer and C_Timer.After then C_Timer.After(0, finishMetadata) else finishMetadata() end
            end
        end
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
        elseif event == "ITEM_DATA_LOAD_RESULT" then
            self:OnItemDataLoaded(...)
        end
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
