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

    if ui.frame:IsShown() then
        ui.frame:Hide()
    else
        ui:Render()
        ui.frame:Show()
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

    ui.frame:ClearAllPoints()
    ui.frame:SetPoint("CENTER")
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
            if not self.addon.ui.frame:IsShown() then
                self:ToggleMainFrame()
            end
            return
        end

        if cmd == "hide" then
            if self.addon.ui.frame:IsShown() then
                self:ToggleMainFrame()
            end
            return
        end

        if cmd == "resetpos" then
            self:ResetWindowPosition()
            Utils:Msg("Window position reset.")
            return
        end

        if cmd == "help" then
            Utils:Msg("/tdp toggle - Show/hide planner")
            Utils:Msg("/tdp show - Show planner")
            Utils:Msg("/tdp hide - Hide planner")
            Utils:Msg("/tdp resetpos - Reset window position")
            return
        end

        Utils:Msg("Unknown command. Use /tdp help")
    end
end

TDP.SlashCommands = SlashCommands:New(TDP)
