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
        self.addon.ui = self.addon.MainWindow:New():Build()
        self.addon.SlashCommands:Init()
        self.addon.Achievements:Init()

        self.addon.Utils:Msg("Loaded. Use /tdp to open your board.")
    elseif addonName == "Blizzard_AchievementUI" then
        self.addon.Achievements:Init()
    end
end

function Bootstrap:Init()
    self.frame:RegisterEvent("ADDON_LOADED")
    self.frame:SetScript("OnEvent", function(_, event, ...)
        if event == "ADDON_LOADED" then
            self:OnAddonLoaded(...)
        end
    end)
end

TDP.Bootstrap = Bootstrap:New(TDP)
TDP.Bootstrap:Init()
