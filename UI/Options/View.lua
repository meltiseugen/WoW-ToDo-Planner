local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets

function OptionsWindow:Build()
    if self.frame then return self.frame end
    self:EnsureSettings()
    local saved = TODOPlannerDB.settings.optionsWindow
    local frame = CreateFrame("Frame", "TODOPlannerOptionsWindow", UIParent, "BackdropTemplate")
    frame:SetSize(math.max(860, math.min(1400, tonumber(saved.width) or 1000)),
        math.max(540, math.min(1000, tonumber(saved.height) or 720)))
    Widgets:ApplyFramePosition(frame, "options", 0, 40)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetResizeBounds(860, 540, 1400, 1000)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(target)
        Widgets:BringToFront(target)
        target:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "options")
    end)
    Widgets:RegisterTopLevelWindow(frame)

    local chrome = frame
    if TDP.Theme then
        chrome = TDP.Theme:ApplyWindowChrome(frame, "Options", { closeButtonKey = "optionsCloseButton" })
        TDP.Theme:RegisterSpecialFrame("TODOPlannerOptionsWindow")
    else
        Widgets:ApplyPanelBackdrop(frame, "chrome", "chromeBorder")
        local title = self:Text(frame, "Options", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 18, -16)
        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)
        close:SetScript("OnClick", function() frame:Hide() end)
        UISpecialFrames[#UISpecialFrames + 1] = "TODOPlannerOptionsWindow"
    end

    local sidebar = Widgets:CreatePanel(frame, "body", "goldBorder")
    sidebar:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
    sidebar:SetPoint("BOTTOMLEFT", chrome, "BOTTOMLEFT", 12, 54)
    sidebar:SetWidth(190)
    local searchLabel = self:Text(sidebar, "Find a setting", "GameFontNormalSmall")
    searchLabel:SetPoint("TOPLEFT", 12, -14)
    local search = Widgets:CreateEditBox(sidebar, 140, 28)
    search:SetPoint("TOPLEFT", 12, -36)
    search:SetMaxLetters(100)
    self:BindHelp(search, "Find a setting", "Search every page by setting name, description, example, or skin name.", "Try pin, progress, minimap, or Botanical.")
    local clear = Widgets:CreateButton(sidebar, 24, 28, "X", "neutral")
    clear:SetPoint("LEFT", search, "RIGHT", 4, 0)
    clear:SetScript("OnClick", function() search:SetText(""); self:SetSearch("") end)
    self:BindHelp(clear, "Clear search", "Return to the page you were viewing before searching.")
    search:SetScript("OnTextChanged", function(input) self:SetSearch(input:GetText()) end)
    search:SetScript("OnEscapePressed", function(input)
        input:SetText(""); input:ClearFocus(); self:SetSearch("")
    end)
    search:SetScript("OnEnterPressed", function(input) input:ClearFocus() end)
    self.searchInput = search

    self.body = Widgets:CreatePanel(frame, "body", "goldBorder")
    self.body:SetPoint("TOPLEFT", sidebar, "TOPRIGHT", 10, 0)
    self.body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 54)
    self.pageTitle = self:Text(self.body, "", "GameFontNormalLarge")
    self.pageTitle:SetPoint("TOPLEFT", 16, -16)
    self.pageTitle:SetPoint("TOPRIGHT", -16, -16)
    self.pageDescription = self:Text(self.body, "", "GameFontHighlightSmall", "textSoft")
    self.pageDescription:SetPoint("TOPLEFT", 16, -42)
    self.pageDescription:SetPoint("TOPRIGHT", -16, -42)

    local scroll = CreateFrame("ScrollFrame", nil, self.body, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 16, -82)
    scroll:SetPoint("BOTTOMRIGHT", -34, 34)
    scroll:EnableMouseWheel(true)
    scroll:SetScript("OnMouseWheel", function(target, delta)
        target:SetVerticalScroll(math.max(0, math.min(target:GetVerticalScrollRange(), target:GetVerticalScroll() - delta * 40)))
    end)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 1)
    scroll:SetScrollChild(content)
    self.scrollFrame, self.content = scroll, content
    self.emptyText = self:Text(content, "No settings match your search.\nTry a shorter term, or clear search to browse the pages.", "GameFontHighlightSmall", "textSoft")
    self.emptyText:SetPoint("TOPLEFT", 16, -22)
    self.resultText = self:Text(self.body, "", "GameFontHighlightSmall", "textMuted")
    self.resultText:SetPoint("BOTTOMLEFT", 16, 12)
    self.resultText:SetPoint("BOTTOMRIGHT", -16, 12)

    self:CreatePages()
    for index, definition in ipairs(self.PageDefinitions) do
        local pageID = definition.id
        local button = Widgets:CreateButton(sidebar, 166, 34, definition.label, "neutral")
        button:SetPoint("TOPLEFT", 12, -88 - (index - 1) * 42)
        button:SetScript("OnClick", function() self:SelectPage(pageID) end)
        self:BindHelp(button, definition.label, definition.description)
        self.pages[pageID].button = button
    end
    local hint = self:Text(sidebar, "/tdp options\nOpen settings anytime.", "GameFontHighlightSmall", "textMuted")
    hint:SetPoint("BOTTOMLEFT", 12, 16)
    hint:SetWidth(166)

    self.resetButton = Widgets:CreateButton(frame, 144, 28, "Reset this page", "neutral")
    self.resetButton:SetPoint("BOTTOMLEFT", chrome, "BOTTOMLEFT", 12, 14)
    self.resetButton:SetScript("OnClick", function() self:ResetPage() end)
    self:BindHelp(self.resetButton, "Reset this page", "Restore the selected page's preferences. Click twice to confirm. Tasks, characters, favorites, and collection filters are kept. Center windows remains a separate action. Clear search to enable page resets.")
    self.resetButton:SetMotionScriptsWhileDisabled(true)
    self.reloadButton = Widgets:CreateButton(frame, 104, 28, "Reload UI", "primary")
    self.reloadButton:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 14)
    self.reloadButton:SetScript("OnClick", function() ReloadUI() end)
    if self.reloadButton.SetMotionScriptsWhileDisabled then self.reloadButton:SetMotionScriptsWhileDisabled(true) end
    self:BindHelp(self.reloadButton, "Reload UI", "Reload the interface to apply the selected skin to all addon windows. This button is enabled when your selected skin differs from the active skin.")
    self.footerText = self:Text(frame, "", "GameFontHighlightSmall", "textSoft")
    self.footerText:SetPoint("LEFT", self.resetButton, "RIGHT", 14, 0)
    self.footerText:SetPoint("RIGHT", self.reloadButton, "LEFT", -14, 0)

    local resize = CreateFrame("Button", nil, frame)
    resize:SetSize(16, 16)
    resize:SetPoint("BOTTOMRIGHT", -2, 2)
    resize:SetFrameLevel(frame:GetFrameLevel() + 20)
    resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    resize:SetScript("OnMouseDown", function(_, button) if button == "LeftButton" then frame:StartSizing("BOTTOMRIGHT") end end)
    resize:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)
    self:BindHelp(resize, "Resize Options", "Drag to resize. The window remembers its size and position after reload.")

    self.frame = frame
    frame:SetScript("OnSizeChanged", function(target)
        saved.width, saved.height = target:GetSize()
        self:Layout()
    end)
    self.body:SetScript("OnSizeChanged", function() self:Layout() end)
    frame:SetScript("OnHide", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "options")
        saved.width, saved.height = target:GetSize()
        self:CancelReset()
        self:HideHelp()
        search:ClearFocus()
        Widgets:HideDropdownMenus()
    end)
    self:BuildSettingsPanel()
    self:SelectPage(saved.page or "appearance")
    frame:Hide()
    return frame
end

function OptionsWindow:BuildSettingsPanel()
    if self.settingsPanel then return end
    local panel = CreateFrame("Frame", "TODOPlannerOptionsPanel", UIParent)
    local title = self:Text(panel, "Planner & Collection Tracker", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    local subtitle = self:Text(panel, "Appearance, achievements, maps, windows, and logging preferences are managed in a searchable Options window.")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -12)
    subtitle:SetWidth(580)
    local open = Widgets:CreateButton(panel, 190, 28, "Open Options Window", "primary")
    open:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -18)
    open:SetScript("OnClick", function() self:Open() end)
    self:BindHelp(open, "Open Options", "Open the standalone settings window. You can also use /tdp options.")
    self.settingsPanel = panel
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        self.optionsCategory = Settings.RegisterCanvasLayoutCategory(panel, "Planner & Collection Tracker")
        Settings.RegisterAddOnCategory(self.optionsCategory)
    end
end

function OptionsWindow:Open(pageID)
    local frame = self:Build()
    if pageID then self:SelectPage(pageID) end
    self:Refresh()
    frame:Show()
    Widgets:BringToFront(frame, self.ui and self.ui.frame)
end
