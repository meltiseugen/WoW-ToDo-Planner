local _, TDP = ...

local Widgets = TDP.Widgets

local OptionsWindow = {}
OptionsWindow.__index = OptionsWindow

local TAB_ORDER = { "General", "Achievements" }
local WORLD_MAP_PIN_DEFAULT_SCALE = 1.6
local WORLD_MAP_PIN_MIN_SCALE = 0.75
local WORLD_MAP_PIN_MAX_SCALE = 3
local WORLD_MAP_PIN_SCALE_STEP = 0.25

function OptionsWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
        settingsPanel = nil,
        controls = nil,
        tabs = nil,
        selectedTab = "General",
    }, self)
end

function OptionsWindow:EnsureSettings()
    TODOPlannerDB.settings = TODOPlannerDB.settings or {}
    if type(TODOPlannerDB.settings.useProgressBars) ~= "boolean" then
        TODOPlannerDB.settings.useProgressBars = true
    end
    TODOPlannerDB.settings.worldMapPinScale = tonumber(TODOPlannerDB.settings.worldMapPinScale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if TODOPlannerDB.settings.worldMapPinScale < WORLD_MAP_PIN_MIN_SCALE then
        TODOPlannerDB.settings.worldMapPinScale = WORLD_MAP_PIN_MIN_SCALE
    elseif TODOPlannerDB.settings.worldMapPinScale > WORLD_MAP_PIN_MAX_SCALE then
        TODOPlannerDB.settings.worldMapPinScale = WORLD_MAP_PIN_MAX_SCALE
    end
end

function OptionsWindow:ApplyTabVisualState(button, isSelected)
    if not button then
        return
    end

    if type(button.SetSelected) == "function" then
        button:SetSelected(isSelected == true)
    else
        button:SetEnabled(not isSelected)
    end
end

function OptionsWindow:SelectTab(tabKey)
    self.selectedTab = tabKey or "General"

    for _, key in ipairs(TAB_ORDER) do
        local tab = self.tabs and self.tabs[key]
        local isSelected = key == self.selectedTab
        if tab and tab.container then
            if isSelected then
                tab.container:Show()
                if tab.content then
                    local contentWidth = (tab.container:GetWidth() or 0) - 32
                    tab.content:SetWidth(math.max(1, contentWidth))
                end
                if tab.scrollFrame then
                    tab.scrollFrame:SetVerticalScroll(0)
                    if tab.scrollFrame.UpdateScrollChildRect then
                        tab.scrollFrame:UpdateScrollChildRect()
                    end
                end
            else
                tab.container:Hide()
            end
        end
        if tab and tab.button then
            self:ApplyTabVisualState(tab.button, isSelected)
        end
    end
end

function OptionsWindow:Refresh()
    self:EnsureSettings()
    if not self.controls then
        return
    end

    local useProgressBars = TODOPlannerDB.settings.useProgressBars ~= false
    self:ApplyTabVisualState(self.controls.progressBarsButton, useProgressBars)
    self:ApplyTabVisualState(self.controls.progressTextButton, not useProgressBars)
    if self.controls.worldMapPinScaleText then
        self.controls.worldMapPinScaleText:SetText(string.format("%d%%", math.floor((TODOPlannerDB.settings.worldMapPinScale * 100) + 0.5)))
    end
end

function OptionsWindow:CreateTab(panel, key)
    local container = CreateFrame("Frame", nil, panel)
    container:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -112)
    container:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -42, 18)
    container:Hide()

    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(target, delta)
        local nextScroll = target:GetVerticalScroll() - (delta * 40)
        local maxScroll = target:GetVerticalScrollRange()
        if nextScroll < 0 then
            nextScroll = 0
        elseif nextScroll > maxScroll then
            nextScroll = maxScroll
        end
        target:SetVerticalScroll(nextScroll)
    end)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1, 1)
    scrollFrame:SetScrollChild(content)

    container:SetScript("OnSizeChanged", function(_, width)
        content:SetWidth(math.max(1, width - 32))
    end)

    self.tabs[key] = {
        container = container,
        scrollFrame = scrollFrame,
        content = content,
        button = nil,
    }

    return self.tabs[key]
end

function OptionsWindow:CreateSection(parent, previousSection, titleText, descriptionText, height)
    local section = Widgets:CreatePanel(parent, "section", "goldBorder")
    if previousSection then
        section:SetPoint("TOPLEFT", previousSection, "BOTTOMLEFT", 0, -12)
        section:SetPoint("TOPRIGHT", previousSection, "BOTTOMRIGHT", 0, -12)
    else
        section:SetPoint("TOPLEFT", parent, "TOPLEFT", 4, -6)
        section:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -12, -6)
    end
    section:SetHeight(height)
    section.topAccent = Widgets:AddGoldTopAccent(section, 2, 0.18)
    section.contentTopOffset = (type(descriptionText) == "string" and descriptionText ~= "") and -54 or -40

    local title = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", section, "TOPLEFT", 14, -12)
    title:SetPoint("TOPRIGHT", section, "TOPRIGHT", -14, -12)
    title:SetJustifyH("LEFT")
    title:SetText(titleText or "")

    if type(descriptionText) == "string" and descriptionText ~= "" then
        local description = section:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        description:SetPoint("TOPRIGHT", section, "TOPRIGHT", -14, 0)
        description:SetJustifyH("LEFT")
        description:SetTextColor(0.62, 0.66, 0.74)
        description:SetText(descriptionText)
    end

    return section
end

function OptionsWindow:SetProgressBarsEnabled(enabled)
    self:EnsureSettings()
    TODOPlannerDB.settings.useProgressBars = enabled == true
    self:Refresh()

    local ui = self.ui
    if ui and ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame:IsShown() then
        ui.detailWindow.frame:UpdateNotesLayout()
    end
end

function OptionsWindow:SetWorldMapPinScale(scale)
    self:EnsureSettings()
    scale = tonumber(scale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if scale < WORLD_MAP_PIN_MIN_SCALE then
        scale = WORLD_MAP_PIN_MIN_SCALE
    elseif scale > WORLD_MAP_PIN_MAX_SCALE then
        scale = WORLD_MAP_PIN_MAX_SCALE
    end

    TODOPlannerDB.settings.worldMapPinScale = scale
    self:Refresh()

    local collectionMapWindow = TDP.collectionMapWindow
    if collectionMapWindow and collectionMapWindow.projectedPayload then
        collectionMapWindow:RefreshWorldMapProjection()
    end
end

function OptionsWindow:ResetMainWindowPosition()
    local positionedWindows = {
        { key = "home", window = TDP.ui },
        { key = "planner", window = self.ui or TDP.plannerWindow },
        { key = "explorer", window = TDP.explorerWindow },
        { key = "favorites", window = TDP.favoritesWindow },
        { key = "collectionMap", window = TDP.collectionMapWindow },
    }

    for _, positionedWindow in ipairs(positionedWindows) do
        local window = positionedWindow.window
        Widgets:ResetFramePosition(positionedWindow.key, window and window.frame)
    end
end

function OptionsWindow:Build()
    if self.frame then
        return self.frame
    end

    self:EnsureSettings()

    local settingsPanel = CreateFrame("Frame", "TODOPlannerOptionsPanel", UIParent)
    local settingsTitle = settingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    settingsTitle:SetPoint("TOPLEFT", 16, -16)
    settingsTitle:SetText("TODO Planner")

    local settingsSubtitle = settingsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    settingsSubtitle:SetPoint("TOPLEFT", settingsTitle, "BOTTOMLEFT", 0, -8)
    settingsSubtitle:SetWidth(620)
    settingsSubtitle:SetJustifyH("LEFT")
    settingsSubtitle:SetText("Options are managed in a standalone addon window.")

    local openWindowButton = CreateFrame("Button", nil, settingsPanel, "UIPanelButtonTemplate")
    openWindowButton:SetSize(180, 24)
    openWindowButton:SetPoint("TOPLEFT", settingsSubtitle, "BOTTOMLEFT", 0, -18)
    openWindowButton:SetText("Open Options Window")
    openWindowButton:SetScript("OnClick", function()
        self:Open()
    end)

    local frame = CreateFrame("Frame", "TODOPlannerOptionsWindow", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(720, 500)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
    frame:SetMovable(true)
    if frame.SetResizable then
        frame:SetResizable(true)
    end
    if frame.SetResizeBounds then
        frame:SetResizeBounds(620, 420, 980, 760)
    elseif frame.SetMinResize then
        frame:SetMinResize(620, 420)
    end
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnMouseDown", function(target)
        if target.Raise then
            target:Raise()
        end
    end)
    frame:SetScript("OnDragStart", function(target)
        if target.Raise then
            target:Raise()
        end
        target:StartMoving()
    end)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    Widgets:RegisterTopLevelWindow(frame)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Options", {
            closeButtonKey = "optionsCloseButton",
        })
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerOptionsWindow")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Options")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    end

    local title = body:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("TODO Planner")

    local subtitle = body:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetText("Separate Global and character task boards.")

    self.tabs = {}
    local previousTabButton
    for index, tabName in ipairs(TAB_ORDER) do
        local tabButton = Widgets:CreateButton(body, 118, 24, tabName, "neutral")
        tabButton:SetID(index)
        tabButton:ClearAllPoints()
        if previousTabButton then
            tabButton:SetPoint("LEFT", previousTabButton, "RIGHT", 8, 0)
        else
            tabButton:SetPoint("TOPLEFT", body, "TOPLEFT", 16, -78)
        end
        tabButton:SetScript("OnClick", function()
            self:SelectTab(tabName)
        end)

        local tab = self:CreateTab(body, tabName)
        tab.button = tabButton
        previousTabButton = tabButton
    end

    local tabsUnderline = body:CreateTexture(nil, "ARTWORK")
    tabsUnderline:SetColorTexture(1, 0.82, 0, 0.35)
    tabsUnderline:SetPoint("TOPLEFT", body, "TOPLEFT", 16, -112)
    tabsUnderline:SetPoint("TOPRIGHT", body, "TOPRIGHT", -16, -112)
    tabsUnderline:SetHeight(1)

    local generalContent = self.tabs.General.content
    local generalWindowSection = self:CreateSection(generalContent, nil, "Window", "Quick window actions for TODO Planner.", 104)

    local resetPositionButton = Widgets:CreateButton(generalWindowSection, 150, 24, "Reset Position", "neutral")
    resetPositionButton:SetPoint("TOPLEFT", generalWindowSection, "TOPLEFT", 14, generalWindowSection.contentTopOffset)
    resetPositionButton:SetScript("OnClick", function()
        self:ResetMainWindowPosition()
    end)

    local resetPositionText = generalWindowSection:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    resetPositionText:SetPoint("LEFT", resetPositionButton, "RIGHT", 12, 0)
    resetPositionText:SetPoint("RIGHT", generalWindowSection, "RIGHT", -14, 0)
    resetPositionText:SetJustifyH("LEFT")
    resetPositionText:SetText("Move TODO Planner windows back to the center.")

    local mapSection = self:CreateSection(generalContent, generalWindowSection, "Collection Map", "Adjust TODO pins projected onto the Blizzard world map.", 124)

    local mapPinLabel = mapSection:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    mapPinLabel:SetPoint("TOPLEFT", mapSection, "TOPLEFT", 14, mapSection.contentTopOffset)
    mapPinLabel:SetText("Blizzard map pin size")

    local pinScaleDownButton = Widgets:CreateButton(mapSection, 28, 24, "-", "neutral")
    pinScaleDownButton:SetPoint("TOPLEFT", mapPinLabel, "BOTTOMLEFT", 0, -8)
    pinScaleDownButton:SetScript("OnClick", function()
        self:SetWorldMapPinScale((TODOPlannerDB.settings.worldMapPinScale or WORLD_MAP_PIN_DEFAULT_SCALE) - WORLD_MAP_PIN_SCALE_STEP)
    end)

    local pinScaleText = mapSection:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    pinScaleText:SetSize(58, 24)
    pinScaleText:SetPoint("LEFT", pinScaleDownButton, "RIGHT", 8, 0)
    pinScaleText:SetJustifyH("CENTER")

    local pinScaleUpButton = Widgets:CreateButton(mapSection, 28, 24, "+", "neutral")
    pinScaleUpButton:SetPoint("LEFT", pinScaleText, "RIGHT", 8, 0)
    pinScaleUpButton:SetScript("OnClick", function()
        self:SetWorldMapPinScale((TODOPlannerDB.settings.worldMapPinScale or WORLD_MAP_PIN_DEFAULT_SCALE) + WORLD_MAP_PIN_SCALE_STEP)
    end)

    local pinScaleResetButton = Widgets:CreateButton(mapSection, 72, 24, "Reset", "neutral")
    pinScaleResetButton:SetPoint("LEFT", pinScaleUpButton, "RIGHT", 8, 0)
    pinScaleResetButton:SetScript("OnClick", function()
        self:SetWorldMapPinScale(WORLD_MAP_PIN_DEFAULT_SCALE)
    end)

    local mapPinHelp = mapSection:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    mapPinHelp:SetPoint("LEFT", pinScaleResetButton, "RIGHT", 12, 0)
    mapPinHelp:SetPoint("RIGHT", mapSection, "RIGHT", -14, 0)
    mapPinHelp:SetJustifyH("LEFT")
    mapPinHelp:SetText("Changes apply immediately to projected pins.")
    generalContent:SetHeight(252)

    local achievementsContent = self.tabs.Achievements.content
    local progressSection = self:CreateSection(achievementsContent, nil, "Progress Display", "Choose how achievement criteria progress is shown in task details.", 126)

    local progressLabel = progressSection:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    progressLabel:SetPoint("TOPLEFT", progressSection, "TOPLEFT", 14, progressSection.contentTopOffset)
    progressLabel:SetText("Criteria progress")

    local barsButton = Widgets:CreateButton(progressSection, 112, 24, "Bars", "neutral")
    barsButton:SetPoint("TOPLEFT", progressLabel, "BOTTOMLEFT", 0, -8)
    barsButton:SetScript("OnClick", function()
        self:SetProgressBarsEnabled(true)
    end)

    local textButton = Widgets:CreateButton(progressSection, 112, 24, "Text", "neutral")
    textButton:SetPoint("LEFT", barsButton, "RIGHT", 8, 0)
    textButton:SetScript("OnClick", function()
        self:SetProgressBarsEnabled(false)
    end)

    self.controls = {
        progressBarsButton = barsButton,
        progressTextButton = textButton,
        worldMapPinScaleText = pinScaleText,
    }
    achievementsContent:SetHeight(138)

    self.frame = frame
    self.settingsPanel = settingsPanel

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(settingsPanel, "TODO Planner")
        Settings.RegisterAddOnCategory(category)
        self.optionsCategory = category
    end

    if frame.StartSizing then
        local resizeButton = CreateFrame("Button", nil, frame)
        resizeButton:SetSize(18, 18)
        resizeButton:SetPoint("BOTTOMRIGHT", -5, 5)
        resizeButton:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
        resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
        resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
        resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
        resizeButton:SetScript("OnMouseDown", function()
            frame:StartSizing("BOTTOMRIGHT")
        end)
        resizeButton:SetScript("OnMouseUp", function()
            frame:StopMovingOrSizing()
        end)
    end

    frame:Hide()
    self:SelectTab("General")
    self:Refresh()

    return frame
end

function OptionsWindow:Open()
    local frame = self:Build()
    self:Refresh()
    frame:Show()
    Widgets:BringToFront(frame, self.ui and self.ui.frame)
end

TDP.OptionsWindow = OptionsWindow
