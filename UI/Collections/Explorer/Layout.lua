local _, TDP = ...
local Explorer = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets

function Explorer:LayoutExplorer(skipRows)
    if not self.frame or not self.listPanel or self.layingOut then return end
    local scroll = tonumber(self.pendingListScroll) or self.listScroll:GetVerticalScroll()
    self.layingOut = true
    local width, height = self.frame:GetSize()
    local bodyWidth, bodyHeight = width - 36, height - 76
    local toolbarHeight = 126
    self.body:SetSize(bodyWidth, bodyHeight)
    self.toolbar:SetPoint("TOPLEFT", self.body, "TOPLEFT", 0, 0)
    self.toolbar:SetSize(bodyWidth, toolbarHeight)
    local selectorWidth = math.max(168, math.min(220, bodyWidth * 0.18))
    local sourceWidth = bodyWidth - selectorWidth - 126 - 112 - 84 - 76 - 40
    local controls = {
        { self.expansionButton, selectorWidth },
        { self.patchButton, 126 }, { self.statusButton, 112 },
        { self.sourceButton, sourceWidth }, { self.nearbyButton, 84 }, { self.refreshButton, 76 },
    }
    local x = 0
    for _, field in ipairs(controls) do
        field[1]:ClearAllPoints()
        field[1]:SetPoint("TOPLEFT", self.toolbar, "TOPLEFT", x, -46)
        field[1]:SetSize(field[2], 28)
        x = x + field[2] + 8
    end
    self.achievementCategoryButton:ClearAllPoints()
    self.achievementCategoryButton:SetPoint("TOPLEFT", self.sourceButton, "TOPLEFT", 0, 0)
    self.achievementCategoryButton:SetSize(sourceWidth, 28)
    local isCosmetics = self.selectedCollectionType == "cosmetics"
    local searchWidth = bodyWidth - (isCosmetics and 476 or 0) - (self.nearbySnapshot and 140 or 0)
    self.searchEdit:ClearAllPoints()
    self.searchEdit:SetPoint("TOPLEFT", self.toolbar, "TOPLEFT", 0, -94)
    self.searchEdit:SetSize(searchWidth, 28)
    self.weaponTypeButton:ClearAllPoints()
    self.weaponTypeButton:SetPoint("LEFT", self.searchEdit, "RIGHT", 8, 0)
    self.armourTypeButton:ClearAllPoints()
    self.armourTypeButton:SetPoint("LEFT", self.weaponTypeButton, "RIGHT", 8, 0)
    self.browseButton:SetPoint("TOPRIGHT", self.toolbar, "TOPRIGHT", 0, -96)

    local panelHeight = bodyHeight - toolbarHeight - 12
    local listWidth = math.floor((bodyWidth - 12) * 0.54)
    local inspectorWidth = bodyWidth - listWidth - 12
    self.listPanel:SetPoint("TOPLEFT", self.body, "TOPLEFT", 0, -(toolbarHeight + 12))
    self.listPanel:SetSize(listWidth, panelHeight)
    self.previewPanel:SetPoint("TOPLEFT", self.listPanel, "TOPRIGHT", 12, 0)
    self.previewPanel:SetSize(inspectorWidth, panelHeight)
    self.inspectorWidth, self.inspectorHeight = inspectorWidth, panelHeight
    self.summaryText:SetWidth(listWidth - 166)
    local listHeaderHeight = math.max(38, self.summaryText:GetStringHeight() + 22)
    self.listScroll:SetPoint("TOPLEFT", self.listPanel, "TOPLEFT", 10, -listHeaderHeight)
    self.listScroll:SetSize(listWidth - 38, panelHeight - listHeaderHeight - 34)
    self.listContentWidth = listWidth - 42
    self.listViewportHeight = panelHeight - listHeaderHeight - 34
    self.scopeText:SetWidth(listWidth - 24)
    self:LayoutExplorerInspector()
    if self.hasBuiltRows and not skipRows then self:BuildRows(scroll) end
    self.layingOut = nil
end

function Explorer:BuildExplorerResizeHandle()
    local resize = CreateFrame("Button", nil, self.frame)
    resize:SetSize(16, 16)
    resize:SetPoint("BOTTOMRIGHT", -1, 1)
    resize:SetFrameLevel(self.frame:GetFrameLevel() + 20)
    resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    resize:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then self.frame:StartSizing("BOTTOMRIGHT") end
    end)
    resize:SetScript("OnMouseUp", function()
        self.frame:StopMovingOrSizing()
        self:SaveBrowserState()
    end)
    self:BindExplorerHelp(resize, "Resize Collections", "Drag to resize. Your window size and browsing choices are remembered after reload.")
end
