local ADDON_NAME, TDP = ...

local Bootstrap = {}
Bootstrap.__index = Bootstrap

function Bootstrap:New(addon)
    return setmetatable({
        addon = addon,
        frame = addon.EventFrame,
    }, self)
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
        self.addon.SlashCommands:Init()
        self.addon.Achievements:Init()
        self.frame:RegisterEvent("ACHIEVEMENT_EARNED")
        self.frame:RegisterEvent("CRITERIA_UPDATE")

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
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
