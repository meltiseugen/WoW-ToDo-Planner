local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Widgets = TDP.Widgets
local CollectionScanner = TDP.CollectionScanner
local Favorites = TDP.Favorites
local LIST_WIDTH = FavoritesWindow.Config.LIST_WIDTH
local LIST_CONTENT_WIDTH = FavoritesWindow.Config.LIST_CONTENT_WIDTH

function FavoritesWindow:Render()
    if not self.frame then
        return
    end

    self:BuildVisibleRows()
    self:UpdateTypeTabs()
    self.summaryText:SetText(string.format("%d favorite(s) shown", #self.visibleRows))

    if self.selectedRow then
        local stillVisible = false
        for _, row in ipairs(self.visibleRows) do
            if row.favorite and self.selectedRow.favorite and row.favorite.key == self.selectedRow.favorite.key then
                self.selectedRow = row
                stillVisible = true
                break
            end
        end
        if not stillVisible then
            self.selectedRow = nil
        end
    end

    if not self.selectedRow and self.visibleRows[1] then
        self.selectedRow = self.visibleRows[1]
    end

    self:BuildRows()
    self:RenderPreview()
end

function FavoritesWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerFavoritesFrame", UIParent, "BackdropTemplate")
    frame:SetSize(1120, 700)
    Widgets:ApplyFramePosition(frame, "favorites")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "favorites")
    end)
    Widgets:RegisterTopLevelWindow(frame)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Favorites")
        local subtitle = Widgets:CreateFontString(frame.headerBar, "OVERLAY", "GameFontHighlightSmall", "titleText")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Saved collection targets")

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerFavoritesFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
    end

    local toolbar = Widgets:CreatePanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(84)
    toolbar.topAccent = Widgets:AddGoldTopAccent(toolbar, 2, 0.20)

    self:BuildTypeTabs(toolbar)

    local refreshButton = Widgets:CreateButton(toolbar, 82, 24, "Refresh", "neutral")
    refreshButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -12)

    local navigationButtons = Widgets:CreateWindowNavigation(frame.headerBar or toolbar, "favorites", self, {
        centered = frame.headerBar ~= nil,
    })

    local searchLabel = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall")
    searchLabel:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 16, -36)
    searchLabel:SetText("Search")

    local searchEdit = Widgets:CreateEditBox(toolbar, 360, 24)
    searchEdit:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -52)
    searchEdit:SetMaxLetters(80)

    local summaryText = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall")
    summaryText:SetPoint("LEFT", searchEdit, "RIGHT", 16, 0)
    summaryText:SetPoint("RIGHT", toolbar, "RIGHT", -110, 0)
    summaryText:SetJustifyH("LEFT")

    local listPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    listPanel:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -108)
    listPanel:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 12, 12)
    listPanel:SetWidth(LIST_WIDTH)
    listPanel.topAccent = Widgets:AddGoldTopAccent(listPanel, 2, 0.18)

    local emptyText = Widgets:CreateFontString(listPanel, "OVERLAY", "GameFontHighlight")
    emptyText:SetPoint("CENTER", listPanel, "CENTER", 0, 0)
    emptyText:SetText("No favorites yet")

    local listScroll = CreateFrame("ScrollFrame", nil, listPanel, "UIPanelScrollFrameTemplate")
    listScroll:SetPoint("TOPLEFT", 14, -14)
    listScroll:SetPoint("BOTTOMRIGHT", -28, 14)

    local listContent = CreateFrame("Frame", nil, listScroll)
    listContent:SetSize(LIST_CONTENT_WIDTH, 1)
    listScroll:SetScrollChild(listContent)

    local previewPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    previewPanel:SetPoint("TOPLEFT", listPanel, "TOPRIGHT", 12, 0)
    previewPanel:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -12, 12)
    previewPanel.topAccent = Widgets:AddGoldTopAccent(previewPanel, 2, 0.18)

    self:BuildPreviewPanel(previewPanel, true)

    local previewWowheadButton = Widgets:CreateButton(previewPanel, 96, 24, "Wowhead", "neutral")
    previewWowheadButton:SetPoint("BOTTOMLEFT", previewPanel, "BOTTOMLEFT", 18, 20)

    local previewMapButton = Widgets:CreateButton(previewPanel, 74, 24, "Map", "neutral")
    previewMapButton:SetPoint("LEFT", previewWowheadButton, "RIGHT", 8, 0)

    local previewRemoveButton = Widgets:CreateButton(previewPanel, 124, 24, "Remove", "danger")
    previewRemoveButton:SetPoint("LEFT", previewMapButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.refreshButton = refreshButton
    self.homeButton = navigationButtons.home
    self.collectionsButton = navigationButtons.collections
    self.plannerButton = navigationButtons.planner
    self.searchEdit = searchEdit
    self.summaryText = summaryText
    self.emptyText = emptyText
    self.listScroll = listScroll
    self.listContent = listContent
    self.previewWowheadButton = previewWowheadButton
    self.previewMapButton = previewMapButton
    self.previewRemoveButton = previewRemoveButton

    refreshButton:SetScript("OnClick", function()
        CollectionScanner:ResetCache()
        self:Render()
    end)

    searchEdit:SetScript("OnTextChanged", function()
        self.selectedRow = nil
        self:Render()
    end)

    previewWowheadButton:SetScript("OnClick", function()
        local url = self:GetRowWowheadUrl(self.selectedRow)
        if url and TDP.Achievements then
            TDP.Achievements:ShowCopyUrlDialog(url)
        end
    end)

    previewMapButton:SetScript("OnClick", function()
        self:OpenCollectionMap(self.selectedRow)
    end)

    previewRemoveButton:SetScript("OnClick", function()
        self:RemoveFavorite(self.selectedRow)
    end)

    self:BindPreviewModelControls()

    frame:Hide()
    self:Render()
    return self
end

function FavoritesWindow:Open()
    if not self.frame then
        self:Build()
    end

    CollectionScanner:ResetCache()
    self:Render()
    self.frame:Show()
    Widgets:BringToFront(self.frame)
end
