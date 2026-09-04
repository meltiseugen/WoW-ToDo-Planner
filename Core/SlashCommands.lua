local _, TDP = ...

local Utils = TDP.Utils

local SlashCommands = {}
SlashCommands.__index = SlashCommands

function SlashCommands:New(addon)
    return setmetatable({
        addon = addon,
    }, self)
end

function SlashCommands:ToggleMainFrame()
    local ui = self.addon.ui
    if not ui then
        return
    end

    if self:IsAnyWindowShown() then
        self:HideAllWindows()
    else
        ui:Open()
    end
end

function SlashCommands:GetManagedWindows()
    return {
        self.addon.ui,
        self.addon.plannerWindow,
        self.addon.explorerWindow,
        self.addon.favoritesWindow,
        self.addon.collectionMapWindow,
    }
end

function SlashCommands:IsAnyWindowShown()
    for _, window in ipairs(self:GetManagedWindows()) do
        if window and window.frame and window.frame:IsShown() then
            return true
        end
    end
    return false
end

function SlashCommands:HideAllWindows()
    for _, window in ipairs(self:GetManagedWindows()) do
        if window and window.frame then
            window.frame:Hide()
        end
    end
end

function SlashCommands:ResetWindowPosition()
    local ui = self.addon.ui
    if not ui then
        return
    end

    TODOPlannerDB.settings.frame.point = "CENTER"
    TODOPlannerDB.settings.frame.x = 0
    TODOPlannerDB.settings.frame.y = 0

    for _, window in ipairs(self:GetManagedWindows()) do
        if window and window.frame then
            window.frame:ClearAllPoints()
            window.frame:SetPoint("CENTER")
        end
    end
end

function SlashCommands:Init()
    SLASH_TODOPLANNER1 = "/todoplanner"
    SLASH_TODOPLANNER2 = "/tdp"

    SlashCmdList.TODOPLANNER = function(message)
        local cmd = Utils:Trim((message or ""):lower())

        if cmd == "" or cmd == "toggle" then
            self:ToggleMainFrame()
            return
        end

        if cmd == "show" then
            self:HideAllWindows()
            self.addon.ui:Open()
            return
        end

        if cmd == "hide" then
            self:HideAllWindows()
            return
        end

        if cmd == "planner" then
            self:HideAllWindows()
            self.addon.ui:OpenPlanner()
            return
        end

        if cmd == "explorer" or cmd == "collections" then
            self:HideAllWindows()
            self.addon.ui:OpenExplorer()
            return
        end

        if cmd == "favorites" or cmd == "favourites" then
            self:HideAllWindows()
            self.addon.ui:OpenFavorites()
            return
        end

        if cmd == "maptest" then
            self:HideAllWindows()
            if self.addon.collectionMapWindow then
                Utils:Msg("Opening map prototype...")
                self.addon.collectionMapWindow:OpenTest()
            else
                Utils:Msg("Collection map prototype is unavailable.")
            end
            return
        end

        if cmd == "resetpos" then
            self:ResetWindowPosition()
            Utils:Msg("Window position reset.")
            return
        end

        if cmd == "options" then
            self.addon.ui:OpenOptions()
            return
        end

        if cmd == "help" then
            Utils:Msg("/tdp toggle - Show/hide TODO Planner")
            Utils:Msg("/tdp show - Show home")
            Utils:Msg("/tdp hide - Hide TODO Planner windows")
            Utils:Msg("/tdp planner - Open task board")
            Utils:Msg("/tdp explorer - Open collection explorer")
            Utils:Msg("/tdp favorites - Open favorites")
            Utils:Msg("/tdp maptest - Open standalone collection map prototype")
            Utils:Msg("/tdp options - Open options")
            Utils:Msg("/tdp resetpos - Reset window position")
            return
        end

        Utils:Msg("Unknown command. Use /tdp help")
    end
end

TDP.SlashCommands = SlashCommands:New(TDP)
