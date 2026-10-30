local _, TDP = ...
local Explorer = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets

local function updateFilterHighlight(button, active)
    if not button.filterHighlight then
        local highlight = button:CreateTexture(nil, "ARTWORK")
        highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -1)
        highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 1)
        local color = Widgets:GetThemeColor("accentGold", { 1, 0.82, 0.18, 1 })
        highlight:SetColorTexture(color[1], color[2], color[3], 0.24)
        button.filterHighlight = highlight
    end
    button:SetSelected(active)
    button.filterHighlight:SetShown(active)
end

function Explorer:UpdateSearchControl()
    local hasText = self.searchEdit:GetText() ~= ""
    local focused = self.searchHasFocus
    self.searchHint:SetShown(not hasText)
    self.searchClearButton:SetShown(hasText)
    if self.searchControlHasText ~= hasText then
        self.searchControlHasText = hasText
        self.searchEdit:SetTextInsets(9, hasText and 34 or 9, 0, 0)
    end
    if hasText then
        local theme = Widgets:GetTheme()
        local palette = theme and theme:GetPalette("primary")
        Widgets:ApplyPanelBackdrop(self.searchEdit, palette and palette.selectedBg or "inputFocus",
            palette and palette.selectedBorder or "inputBorderFocus")
        Widgets:ApplyTextColor(self.searchEdit, palette and (palette.selectedText or palette.text) or "text")
    else
        Widgets:ApplyPanelBackdrop(self.searchEdit, focused and "inputFocus" or "input",
            focused and "inputBorderFocus" or "inputBorder")
        Widgets:ApplyTextColor(self.searchEdit, "text")
    end
end

function Explorer:BuildExplorerToolbar(body)
    local toolbar = CreateFrame("Frame", nil, body)
    self.toolbar = toolbar
    self:BuildTypeTabs(toolbar)
    self.searchEdit = Widgets:CreateEditBox(toolbar, 240, 28)
    self.searchEdit:SetMaxLetters(80)
    self.searchHint = Widgets:CreateFontString(self.searchEdit, "OVERLAY", "GameFontHighlightSmall", "textMuted")
    self.searchHint:SetPoint("LEFT", 10, 0)
    self.searchHint:SetPoint("RIGHT", -10, 0)
    self.searchHint:SetJustifyH("LEFT")
    self.searchClearButton = Widgets:CreateButton(self.searchEdit, 22, 22, "×", "close")
    self.searchClearButton:SetPoint("RIGHT", self.searchEdit, "RIGHT", -3, 0)
    self.searchClearButton:Hide()
    self.searchClearButton:SetScript("OnClick", function()
        self.searchEdit:SetText("")
        self.searchEdit:SetFocus()
    end)
    self:BindExplorerHelp(self.searchClearButton, "Clear search", "Clear the search text and show entries matching the other filters.")

    self.expansionButton = Widgets:CreateSelectorButton(toolbar, 190, 28, "")
    self.patchButton = Widgets:CreateSelectorButton(toolbar, 126, 28, "")
    self.statusButton = Widgets:CreateSelectorButton(toolbar, 118, 28, "")
    self.sourceButton = Widgets:CreateSelectorButton(toolbar, 208, 28, "")
    self.achievementCategoryButton = Widgets:CreateSelectorButton(toolbar, 208, 28, "")
    self.weaponTypeButton = Widgets:CreateSelectorButton(toolbar, 230, 28, "")
    self.armourTypeButton = Widgets:CreateSelectorButton(toolbar, 230, 28, "")
    self.nearbyButton = Widgets:CreateButton(toolbar, 86, 28, "Nearby", "nearby")
    local nearbyIcon = self.nearbyButton:CreateTexture(nil, "ARTWORK")
    nearbyIcon:SetSize(16, 16)
    nearbyIcon:SetPoint("LEFT", self.nearbyButton, "LEFT", 7, 0)
    if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo("Waypoint-MapPin-Untracked") then
        nearbyIcon:SetAtlas("Waypoint-MapPin-Untracked")
    else
        nearbyIcon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    end
    self.nearbyButton.locationIcon = nearbyIcon
    local nearbyLabel = self.nearbyButton.label or self.nearbyButton:GetFontString()
    nearbyLabel:ClearAllPoints()
    nearbyLabel:SetPoint("LEFT", self.nearbyButton, "LEFT", 27, 0)
    nearbyLabel:SetPoint("RIGHT", self.nearbyButton, "RIGHT", -5, 0)
    self.refreshButton = Widgets:CreateButton(toolbar, 78, 28, "Refresh", "neutral")
    self.browseButton = Widgets:CreateButton(toolbar, 132, 24, "Return to Browse", "neutral")
    self.browseButton:Hide()
    self.toolbarLabels = {}
    for _, field in ipairs({ { self.expansionButton, "Expansion" }, { self.patchButton, "Patch" },
        { self.statusButton, "Status" }, { self.searchEdit, "Search" },
        { self.weaponTypeButton, "Weapons" }, { self.armourTypeButton, "Armour" } }) do
        local label = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall", "textMuted")
        label:SetPoint("BOTTOMLEFT", field[1], "TOPLEFT", 0, 4)
        label:SetText(field[2])
        self.toolbarLabels[#self.toolbarLabels + 1] = label
        if field[2] == "Weapons" then self.weaponTypeLabel = label end
        if field[2] == "Armour" then self.armourTypeLabel = label end
    end

    self.expansionButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self.Config.EXPANSION_OPTIONS, self.selectedExpansion,
            function(value) return self:GetExpansionLabel(value) end, function(value)
                self:CaptureListState()
                self:SetSelectedExpansion(value)
                self:RestoreListState()
                self:Render()
            end)
    end)
    self.patchButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self:GetPatchOptions(), self.selectedPatch,
            function(value) return self:GetPatchLabel(value) end, function(value)
                self:CaptureListState()
                self.selectedPatch = value
                self:RestoreListState()
                self:Render()
            end)
    end)
    self.statusButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self:GetStatusOptions(), self.selectedStatus,
            function(value) return self:GetStatusLabel(value) end, function(value)
                self:ResetListScroll()
                self:SetSelectedStatus(value)
            end)
    end)
    self.sourceButton:SetScript("OnClick", function(owner)
        Widgets:ShowMultiSelectMenu(owner, self:GetSourceOptions(), function(value) return self:IsSourceChecked(value) end,
            function(value) return self:GetSourceCategoryLabel(value) end, function(value, checked)
                self:ResetListScroll()
                self:ToggleSource(value, checked)
            end)
    end)
    for _, field in ipairs({ { "weapons", self.weaponTypeButton }, { "armour", self.armourTypeButton } }) do
        local group, button = field[1], field[2]
        button:SetScript("OnClick", function(owner)
            Widgets:ShowSingleSelectMenu(owner, self:GetCosmeticGroupOptions(group), self:GetCosmeticGroupSelection(group),
                function(value) return self:GetCosmeticGroupOptionLabel(group, value) end, function(value)
                    self:ResetListScroll()
                    self:SetCosmeticTypeFilter(value)
                end)
        end)
        self:BindExplorerHelp(button, group == "weapons" and "Weapons" or "Armour",
            "Choose a type from this group. Choosing a weapon or armour type replaces the other group's selection. All cosmetic types clears the type filter.")
    end
    self.achievementCategoryButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self.Config.ACHIEVEMENT_CATEGORY_OPTIONS, self.selectedAchievementCategory,
            function(value) return self:GetAchievementCategoryLabel(value) end, function(value)
                self.selectedAchievementCategory = value
                self:ResetListScroll()
                self:Render()
            end)
    end)
    self.refreshButton:SetScript("OnClick", function()
        self.cosmeticTypeRequests = nil
        TDP.CollectionScanner:ResetCache()
        self:Render()
    end)
    self.nearbyButton:SetScript("OnClick", function()
        if self.nearbySnapshot then self:BrowseCollections() else self:ScanNearby() end
    end)
    self.browseButton:SetScript("OnClick", function() self:BrowseCollections() end)
    self.searchEdit:SetScript("OnTextChanged", function()
        local text = self.searchEdit:GetText() or ""
        if text == self.lastSearchText then return end
        self.lastSearchText = text
        self:UpdateSearchControl()
        if self.changingView then return end
        self:ResetListScroll()
        self:Render()
    end)
    Widgets:HookFrameScript(self.searchEdit, "OnEditFocusGained", function()
        self.searchHasFocus = true
        Widgets:HideDropdownMenus()
        self:UpdateSearchControl()
    end)
    Widgets:HookFrameScript(self.searchEdit, "OnEditFocusLost", function()
        self.searchHasFocus = false
        self:UpdateSearchControl()
    end)
    self:BindExplorerHelp(self.expansionButton, "Expansion", function()
        return self.nearbySnapshot and "Nearby covers all expansions. Cancel Nearby to choose an expansion."
            or "Choose an expansion. All Patches includes only patches from this expansion."
    end)
    self:BindExplorerHelp(self.patchButton, "Patch", function()
        return self.nearbySnapshot and "Nearby covers all matching patches in the scanned area."
            or "Choose a patch within the selected expansion."
    end)
    self:BindExplorerHelp(self.statusButton, "Collection status", "Missing shows uncollected, obtainable catalog entries. Collected shows owned entries, and All includes both.")
    self:BindExplorerHelp(self.sourceButton, "Sources", "Select one or more acquisition sources. All Sources clears the source restrictions for this tab.")
    self:BindExplorerHelp(self.nearbyButton, "Scan Nearby", function()
        return self.nearbySnapshot and "Cancel Nearby and restore your previous browsing view, filters and selection."
            or "Scan the current map and its local zone across all collection types and expansions. Click again to cancel Nearby and return to your previous browsing view."
    end)
    self:BindExplorerHelp(self.refreshButton, "Refresh collection state", "Refresh ownership and cached item information. This does not rescan your location.")
end

function Explorer:UpdateExplorerFilters()
    self:UpdateSourceControl()
    self:UpdateCosmeticTypeControl()
    self:UpdateAchievementCategoryControl()
    updateFilterHighlight(self.patchButton, not self.nearbySnapshot and self.selectedPatch ~= self.Config.ALL_PATCHES)
    updateFilterHighlight(self.statusButton, self.selectedStatus ~= "all")
    updateFilterHighlight(self.sourceButton, self:HasSourceFilter() and not self:IsSourceChecked("all"))
    updateFilterHighlight(self.weaponTypeButton, self.selectedCollectionType == "cosmetics"
        and self:GetCosmeticGroupSelection("weapons") ~= "all")
    updateFilterHighlight(self.armourTypeButton, self.selectedCollectionType == "cosmetics"
        and self:GetCosmeticGroupSelection("armour") ~= "all")
    self.nearbyButton:SetText(self.nearbySnapshot and "Cancel" or "Nearby")
    self.nearbyButton:SetSelected(self.nearbySnapshot ~= nil)
    self.nearbyButton.explorerHelpTitle = self.nearbySnapshot and "Cancel Nearby" or "Scan Nearby"
    self.browseButton:SetShown(self.nearbySnapshot ~= nil)
    self.searchHint:SetText("Search " .. self.selectedCollectionType .. "...")
    self:UpdateSearchControl()
end
