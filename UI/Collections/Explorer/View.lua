local _, TDP = ...
local Explorer = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets
local SORT_OPTIONS = { "name", "patch", "source", "status" }
local SORT_LABELS = { name = "Name", patch = "Newest Patch", source = "Source", status = "Status" }

function Explorer:Render()
    if not self.frame then return end
    self.lastSearchText = self.searchEdit:GetText() or ""
    local scroll = tonumber(self.pendingListScroll) or self.listScroll:GetVerticalScroll()
    local total, collected, missing, unobtainable = self:BuildVisibleRows()
    self.expansionButton:SetText(self.nearbySnapshot and "All Expansions"
        or self:GetExpansionLabel(self.selectedExpansion):gsub(" %(%d+%)$", ""))
    self.patchButton:SetText(self.nearbySnapshot and "All Patches" or self:GetPatchLabel(self.selectedPatch))
    self.statusButton:SetText(self:GetStatusLabel(self.selectedStatus))
    self:UpdateTypeTabs()
    self:UpdateExplorerFilters()
    Widgets:SetButtonEnabled(self.expansionButton, self.nearbySnapshot == nil)
    Widgets:SetButtonEnabled(self.patchButton, self.nearbySnapshot == nil)
    self.sortButton:SetText("Sort: " .. SORT_LABELS[self.sortKey])
    local typeLabel = self.selectedCollectionType == "all" and "collections" or self.selectedCollectionType
    local scope = self.nearbySnapshot and ("Nearby in " .. (self.nearbySnapshot.mapName or "unknown area"))
        or (self:GetExpansionLabel(self.selectedExpansion):gsub(" %(%d+%)$", "") .. " / " .. self:GetPatchLabel(self.selectedPatch))
    local summary = string.format("%d matching %s", #self.visibleRows, typeLabel)
    if self.nearbySnapshot then summary = scope .. ": " .. #self.visibleRows end
    self.summaryText:SetText(summary)
    self.summaryHelp = string.format("Catalog scope: %s\n%d entries before search, source and status filters.\n%d collected, %d obtainable missing.",
        scope, total, collected, missing)
    if unobtainable > 0 then
        self.summaryHelp = self.summaryHelp .. string.format("\n%d unobtainable (may include collected entries).", unobtainable)
    end
    self.scopeText:SetText(scope .. "  |  " .. self:GetStatusLabel(self.selectedStatus))
    self.emptyText:SetShown(#self.visibleRows == 0)
    self.emptyText:SetText(self.nearbySnapshot and (self.nearbySnapshot.error
        or (self.nearbySnapshot.total == 0 and "No catalog locations found for this area."
            or "No nearby collections match these filters.")) or "No collections match these filters. Try clearing your search or filters.")

    local selectedKey = self.pendingSelectionKey or self:GetRowKey(self.selectedRow)
    self.selectedRow = nil
    for _, row in ipairs(self.visibleRows) do
        if self:GetRowKey(row) == selectedKey then self.selectedRow = row; break end
    end
    self.pendingSelectionKey = nil
    if not self.selectedRow then self.selectedRow = self.visibleRows[1] end
    self:LayoutExplorer(true)
    self:BuildRows(scroll)
    self:RenderPreview()
    self.hasRendered = true
    self:SaveBrowserState()
end

function Explorer:Build()
    local saved = self:GetBrowserSettings()
    local frame = CreateFrame("Frame", "TODOPlannerCollectionExplorerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(math.max(1020, math.min(1800, tonumber(saved.width) or 1120)),
        math.max(620, math.min(1100, tonumber(saved.height) or 740)))
    frame:SetResizable(true)
    frame:SetResizeBounds(1020, 620, 1800, 1100)
    Widgets:ApplyFramePosition(frame, "explorer")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "explorer")
    end)
    Widgets:RegisterTopLevelWindow(frame)
    if TDP.Theme then
        TDP.Theme:ApplyWindowChrome(frame, "Collection Explorer")
        TDP.Theme:RegisterSpecialFrame("TODOPlannerCollectionExplorerFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, "chrome", "chromeBorder")
    end
    self.frame = frame
    self.body = CreateFrame("Frame", nil, frame)
    self.body:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -58)
    self:BuildExplorerToolbar(self.body)
    local navigation = Widgets:CreateWindowNavigation(frame.headerBar or self.toolbar, "collections", self, {
        centered = frame.headerBar ~= nil,
    })
    self.homeButton, self.favoritesButton, self.plannerButton = navigation.home, navigation.favorites, navigation.planner

    self.listPanel = Widgets:CreatePanel(self.body, "section", "goldBorder")
    self.summaryText = Widgets:CreateFontString(self.listPanel, "OVERLAY", "GameFontHighlightSmall", "textSoft")
    self.summaryText:SetPoint("TOPLEFT", 12, -12)
    self.summaryText:SetJustifyH("LEFT")
    self.summaryText:SetWordWrap(true)
    self.sortButton = Widgets:CreateSelectorButton(self.listPanel, 138, 24, "Sort: Name")
    self.sortButton:SetPoint("TOPRIGHT", -12, -6)
    self.sortButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, SORT_OPTIONS, self.sortKey,
            function(value) return SORT_LABELS[value] end, function(value)
                self.sortKey = value
                self:ResetListScroll()
                self:Render()
            end)
    end)
    self.listScroll = CreateFrame("ScrollFrame", nil, self.listPanel, "UIPanelScrollFrameTemplate")
    self.listContent = CreateFrame("Frame", nil, self.listScroll)
    self.listContent:SetSize(self.Config.LIST_CONTENT_WIDTH, 1)
    self.listScroll:SetScrollChild(self.listContent)
    Widgets:HookFrameScript(self.listScroll, "OnVerticalScroll", function(_, offset)
        if self.layingOut or self.buildingRows then return end
        self:UpdateVisibleRows(offset)
        self:SaveBrowserState()
    end)
    self.scopeText = Widgets:CreateFontString(self.listPanel, "OVERLAY", "GameFontHighlightSmall", "textMuted")
    self.scopeText:SetPoint("BOTTOMLEFT", 12, 10)
    self.scopeText:SetJustifyH("LEFT")
    self.scopeText:SetWordWrap(false)
    self.scopeHelpFrame = CreateFrame("Frame", nil, self.listPanel)
    self.scopeHelpFrame:SetPoint("BOTTOMLEFT", 8, 4)
    self.scopeHelpFrame:SetPoint("BOTTOMRIGHT", -8, 4)
    self.scopeHelpFrame:SetHeight(22)
    self.scopeHelpFrame:EnableMouse(true)
    self:BindExplorerHelp(self.scopeHelpFrame, "Collection scope", function() return self.summaryHelp end)
    self.emptyText = Widgets:CreateFontString(self.listPanel, "OVERLAY", "GameFontHighlightSmall", "textSoft")
    self.emptyText:SetPoint("TOPLEFT", 20, -56)
    self.emptyText:SetPoint("TOPRIGHT", -34, -56)
    self.emptyText:SetJustifyH("CENTER")
    self.emptyText:SetWordWrap(true)
    self.emptyText:Hide()

    self.previewPanel = Widgets:CreatePanel(self.body, "section", "goldBorder")
    self:BuildExplorerInspector(self.previewPanel)
    self:BuildExplorerResizeHandle()
    self:RestoreBrowserState()
    self:LayoutExplorer()
    frame:SetScript("OnSizeChanged", function()
        self:LayoutExplorer()
        self:UpdateExplorerInspectorText()
        self:SaveBrowserState()
    end)
    Widgets:HookFrameScript(frame, "OnHide", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "explorer")
        self:SaveBrowserState()
        self.searchEdit:ClearFocus()
        self:HideRowTooltip()
        Widgets:HideDropdownMenus()
    end)
    frame:Hide()
    return self
end

function Explorer:Open()
    if not self.frame then self:Build() end
    TDP.CollectionScanner:ResetCache()
    self.frame:Show()
    Widgets:BringToFront(self.frame)
    local ok, errorText = pcall(self.Render, self)
    if not ok then TDP.Utils:Msg("Collections render failed: " .. tostring(errorText), "warnings") end
end
