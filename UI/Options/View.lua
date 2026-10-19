local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets
local TAB_ORDER = OptionsWindow.Config.TAB_ORDER
local VISUAL_THEME_OPTIONS = OptionsWindow.Config.VISUAL_THEME_OPTIONS
local VISUAL_THEME_LABELS = OptionsWindow.Config.VISUAL_THEME_LABELS
local WORLD_MAP_PIN_DEFAULT_SCALE = OptionsWindow.Config.WORLD_MAP_PIN_DEFAULT_SCALE
local WORLD_MAP_PIN_SCALE_STEP = OptionsWindow.Config.WORLD_MAP_PIN_SCALE_STEP

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

    local frame = CreateFrame("Frame", "TODOPlannerOptionsWindow", UIParent, "BackdropTemplate")
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
    Widgets:HookFrameScript(frame, "OnHide", function()
        Widgets:HideDropdownMenus()
    end)

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

        local title = Widgets:CreateFontString(frame, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Options")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    end

    local title = Widgets:CreateFontString(body, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("TODO Planner")

    local subtitle = Widgets:CreateFontString(body, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetText("Separate Global and character task boards.")

    self.tabs = {}
    local previousTabButton
    for index, tabName in ipairs(TAB_ORDER) do
        local tabButton = Widgets:CreateTabButton(body, 118, 24, tabName)
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
    Widgets:SetTextureColor(tabsUnderline, "accentGold", { 1, 0.82, 0, 0.35 })
    tabsUnderline:SetAlpha(0.48)
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

    local resetPositionText = Widgets:CreateFontString(generalWindowSection, "ARTWORK", "GameFontHighlightSmall")
    resetPositionText:SetPoint("LEFT", resetPositionButton, "RIGHT", 12, 0)
    resetPositionText:SetPoint("RIGHT", generalWindowSection, "RIGHT", -14, 0)
    resetPositionText:SetJustifyH("LEFT")
    resetPositionText:SetText("Move TODO Planner windows back to the center.")

    local appearanceSection = self:CreateSection(
        generalContent,
        generalWindowSection,
        "Appearance",
        "Choose a visual system. The selection is applied safely after a UI reload.",
        132
    )

    local themeLabel = Widgets:CreateFontString(appearanceSection, "ARTWORK", "GameFontNormalSmall")
    themeLabel:SetPoint("TOPLEFT", appearanceSection, "TOPLEFT", 14, appearanceSection.contentTopOffset)
    themeLabel:SetText("Design")

    local themeSelector = Widgets:CreateSelectorButton(appearanceSection, 210, 24, "")
    themeSelector:SetPoint("TOPLEFT", themeLabel, "BOTTOMLEFT", 0, -8)
    themeSelector:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, VISUAL_THEME_OPTIONS, TODOPlannerDB.settings.visualTheme, function(themeKey)
            return VISUAL_THEME_LABELS[themeKey] or tostring(themeKey)
        end, function(themeKey)
            self:SetVisualTheme(themeKey)
        end)
    end)

    local reloadThemeButton = Widgets:CreateButton(appearanceSection, 86, 24, "Reload UI", "primary")
    reloadThemeButton:SetPoint("LEFT", themeSelector, "RIGHT", 12, 0)
    reloadThemeButton:SetScript("OnClick", function()
        ReloadUI()
    end)

    local themeStatusText = Widgets:CreateFontString(appearanceSection, "ARTWORK", "GameFontHighlightSmall")
    themeStatusText:SetPoint("TOPLEFT", themeSelector, "BOTTOMLEFT", 0, -10)
    themeStatusText:SetPoint("RIGHT", appearanceSection, "RIGHT", -14, 0)
    themeStatusText:SetJustifyH("LEFT")

    local mapSection = self:CreateSection(generalContent, appearanceSection, "Collection Map", "Adjust TODO pins projected onto the Blizzard world map.", 124)

    local mapPinLabel = Widgets:CreateFontString(mapSection, "ARTWORK", "GameFontNormalSmall")
    mapPinLabel:SetPoint("TOPLEFT", mapSection, "TOPLEFT", 14, mapSection.contentTopOffset)
    mapPinLabel:SetText("Blizzard map pin size")

    local pinScaleDownButton = Widgets:CreateButton(mapSection, 28, 24, "-", "neutral")
    pinScaleDownButton:SetPoint("TOPLEFT", mapPinLabel, "BOTTOMLEFT", 0, -8)
    pinScaleDownButton:SetScript("OnClick", function()
        self:SetWorldMapPinScale((TODOPlannerDB.settings.worldMapPinScale or WORLD_MAP_PIN_DEFAULT_SCALE) - WORLD_MAP_PIN_SCALE_STEP)
    end)

    local pinScaleText = Widgets:CreateFontString(mapSection, "ARTWORK", "GameFontHighlight")
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

    local mapPinHelp = Widgets:CreateFontString(mapSection, "ARTWORK", "GameFontHighlightSmall")
    mapPinHelp:SetPoint("LEFT", pinScaleResetButton, "RIGHT", 12, 0)
    mapPinHelp:SetPoint("RIGHT", mapSection, "RIGHT", -14, 0)
    mapPinHelp:SetJustifyH("LEFT")
    mapPinHelp:SetText("Changes apply immediately to projected pins.")
    generalContent:SetHeight(396)

    local achievementsContent = self.tabs.Achievements.content
    local progressSection = self:CreateSection(achievementsContent, nil, "Progress Display", "Choose how achievement criteria progress is shown in task details.", 126)

    local progressLabel = Widgets:CreateFontString(progressSection, "ARTWORK", "GameFontNormalSmall")
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
        themeSelector = themeSelector,
        reloadThemeButton = reloadThemeButton,
        themeStatusText = themeStatusText,
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
