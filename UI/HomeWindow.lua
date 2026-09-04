local _, TDP = ...

local Widgets = TDP.Widgets
local PatchCatalog = TDP.PatchCatalog
local Favorites = TDP.Favorites

local HomeWindow = {}
HomeWindow.__index = HomeWindow

function HomeWindow:New(addon)
    return setmetatable({
        addon = addon,
        frame = nil,
        plannerWindow = nil,
        explorerWindow = nil,
        favoritesWindow = nil,
    }, self)
end

function HomeWindow:SetWindows(plannerWindow, explorerWindow, favoritesWindow)
    self.plannerWindow = plannerWindow
    self.explorerWindow = explorerWindow
    self.favoritesWindow = favoritesWindow
    if self.plannerWindow then
        self.plannerWindow.homeWindow = self
    end
    if self.explorerWindow then
        self.explorerWindow.homeWindow = self
    end
    if self.favoritesWindow then
        self.favoritesWindow.homeWindow = self
    end
end

function HomeWindow:GetSummaryText()
    if not PatchCatalog then
        return "Patch catalog unavailable"
    end

    local launchSummary = PatchCatalog:GetSummary("12.0")
    local patchSummary = PatchCatalog:GetSummary("12.1")
    local favoriteCount = 0
    if Favorites then
        favoriteCount = #Favorites:GetAll()
    end
    return string.format(
        "Catalogs: 12.0 has %d mounts/%d pets, 12.1 has %d mounts/%d pets  |  %d favorite(s)",
        launchSummary.mounts or 0,
        launchSummary.pets or 0,
        patchSummary.mounts or 0,
        patchSummary.pets or 0,
        favoriteCount
    )
end

function HomeWindow:OpenPlanner()
    if self.frame then
        self.frame:Hide()
    end
    if self.explorerWindow and self.explorerWindow.frame then
        self.explorerWindow.frame:Hide()
    end
    if self.favoritesWindow and self.favoritesWindow.frame then
        self.favoritesWindow.frame:Hide()
    end
    if self.plannerWindow then
        self.plannerWindow:Render()
        self.plannerWindow.frame:Show()
        if TDP.Theme then
            TDP.Theme:BringToFront(self.plannerWindow.frame)
        end
    end
end

function HomeWindow:OpenExplorer()
    if self.frame then
        self.frame:Hide()
    end
    if self.plannerWindow and self.plannerWindow.frame then
        self.plannerWindow.frame:Hide()
    end
    if self.favoritesWindow and self.favoritesWindow.frame then
        self.favoritesWindow.frame:Hide()
    end
    if self.explorerWindow then
        local ok, errorText = pcall(self.explorerWindow.Open, self.explorerWindow)
        if not ok then
            self:Open()
            if TDP.Utils then
                TDP.Utils:Msg("Could not open Collections: " .. tostring(errorText))
            end
        end
    else
        self:Open()
        if TDP.Utils then
            TDP.Utils:Msg("Collections window is unavailable.")
        end
    end
end

function HomeWindow:OpenFavorites()
    if self.frame then
        self.frame:Hide()
    end
    if self.plannerWindow and self.plannerWindow.frame then
        self.plannerWindow.frame:Hide()
    end
    if self.explorerWindow and self.explorerWindow.frame then
        self.explorerWindow.frame:Hide()
    end
    if self.favoritesWindow then
        self.favoritesWindow:Open()
    end
end

function HomeWindow:OpenOptions()
    if self.plannerWindow then
        self.plannerWindow:OpenOptions()
    end
end

function HomeWindow:Render()
    if self.summaryText then
        self.summaryText:SetText(self:GetSummaryText())
    end
    if self.plannerWindow and self.plannerWindow.frame and self.plannerWindow.frame:IsShown() then
        self.plannerWindow:Render()
    end
    if self.explorerWindow and self.explorerWindow.frame and self.explorerWindow.frame:IsShown() then
        self.explorerWindow:Render()
    end
    if self.favoritesWindow and self.favoritesWindow.frame and self.favoritesWindow.frame:IsShown() then
        self.favoritesWindow:Render()
    end
end

function HomeWindow:Open()
    if not self.frame then
        self:Build()
    end

    self:Render()
    self.frame:Show()
    if TDP.Theme then
        TDP.Theme:BringToFront(self.frame)
    end
end

function HomeWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerHomeFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(760, 300)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target)
    end)

    local pos = TODOPlannerDB.settings.frame
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.point or "CENTER", pos.x or 0, pos.y or 0)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "TODO Planner")
        local subtitle = frame.headerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Choose where to start")

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerHomeFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
    end

    local explorerButton = Widgets:CreateButton(body, 220, 74, "Collections", "primary")
    explorerButton:SetPoint("TOPLEFT", body, "TOPLEFT", 20, -34)

    local plannerButton = Widgets:CreateButton(body, 220, 74, "Planner", "neutral")
    plannerButton:SetPoint("LEFT", explorerButton, "RIGHT", 16, 0)

    local favoritesButton = Widgets:CreateButton(body, 220, 74, "Favorites", "neutral")
    favoritesButton:SetPoint("LEFT", plannerButton, "RIGHT", 16, 0)

    local explorerText = body:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    explorerText:SetPoint("TOPLEFT", explorerButton, "BOTTOMLEFT", 4, -10)
    explorerText:SetPoint("RIGHT", explorerButton, "RIGHT", -4, 0)
    explorerText:SetJustifyH("CENTER")
    explorerText:SetText("Browse patch rewards")

    local plannerText = body:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    plannerText:SetPoint("TOPLEFT", plannerButton, "BOTTOMLEFT", 4, -10)
    plannerText:SetPoint("RIGHT", plannerButton, "RIGHT", -4, 0)
    plannerText:SetJustifyH("CENTER")
    plannerText:SetText("Open the task board")

    local favoritesText = body:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    favoritesText:SetPoint("TOPLEFT", favoritesButton, "BOTTOMLEFT", 4, -10)
    favoritesText:SetPoint("RIGHT", favoritesButton, "RIGHT", -4, 0)
    favoritesText:SetJustifyH("CENTER")
    favoritesText:SetText("Saved collection targets")

    local summaryText = body:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    summaryText:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 20, 28)
    summaryText:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -20, 28)
    summaryText:SetJustifyH("CENTER")
    self.summaryText = summaryText

    explorerButton:SetScript("OnClick", function()
        self:OpenExplorer()
    end)

    plannerButton:SetScript("OnClick", function()
        self:OpenPlanner()
    end)

    favoritesButton:SetScript("OnClick", function()
        self:OpenFavorites()
    end)

    self.frame = frame
    self.body = body
    frame:Hide()
    self:Render()
    return self
end

TDP.HomeWindow = HomeWindow
