local _, TDP = ...

local Widgets = TDP.Widgets

local OptionsWindow = {}
OptionsWindow.__index = OptionsWindow

local TAB_ORDER = { "General", "Achievements" }

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

function OptionsWindow:ResetMainWindowPosition()
    TODOPlannerDB.settings.frame = TODOPlannerDB.settings.frame or {}
    TODOPlannerDB.settings.frame.point = "CENTER"
    TODOPlannerDB.settings.frame.x = 0
    TODOPlannerDB.settings.frame.y = 0

    local ui = self.ui
    if ui and ui.frame then
        ui.frame:ClearAllPoints()
        ui.frame:SetPoint("CENTER")
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
    frame:SetFrameStrata("DIALOG")
    if frame.SetToplevel then
        frame:SetToplevel(true)
    end
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
    subtitle:SetText("Character boards with shared Global tasks.")

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
    resetPositionText:SetText("Move the main planner window back to the center.")
    generalContent:SetHeight(116)

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
    if frame.Raise then
        frame:Raise()
    end
    if TDP.Theme then
        TDP.Theme:BringToFront(frame, self.ui and self.ui.frame)
    end
end

TDP.OptionsWindow = OptionsWindow
