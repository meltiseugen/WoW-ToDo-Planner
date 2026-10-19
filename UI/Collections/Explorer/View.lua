local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Utils = TDP.Utils
local Widgets = TDP.Widgets
local CollectionScanner = TDP.CollectionScanner
local EXPANSION_OPTIONS = CollectionExplorerWindow.Config.EXPANSION_OPTIONS
local MOUNT_CATEGORY_OPTIONS = CollectionExplorerWindow.Config.MOUNT_CATEGORY_OPTIONS
local ACHIEVEMENT_CATEGORY_OPTIONS = CollectionExplorerWindow.Config.ACHIEVEMENT_CATEGORY_OPTIONS
local LIST_WIDTH = CollectionExplorerWindow.Config.LIST_WIDTH
local LIST_CONTENT_WIDTH = CollectionExplorerWindow.Config.LIST_CONTENT_WIDTH

function CollectionExplorerWindow:Render()
    if not self.frame then
        return
    end

    local totalCount, collectedCount, missingCount, unobtainableCount = self:BuildVisibleRows()
    Widgets:UpdateButtonLabel(self.expansionButton, "Expansion", self.selectedExpansion, function(value)
        return self:GetExpansionLabel(value)
    end)
    Widgets:UpdateButtonLabel(self.patchButton, "Patch", self.selectedPatch, function(value)
        return self:GetPatchLabel(value)
    end)
    Widgets:UpdateButtonLabel(self.statusButton, "Status", self.selectedStatus, function(value)
        return self:GetStatusLabel(value)
    end)
    self:UpdateTypeTabs()
    self:UpdateMountCategoryControl()
    self:UpdateAchievementCategoryControl()

    self.summaryText:SetText(string.format(
        "%d shown  |  %d total  |  %d missing\n%d collected  |  %d unobtainable",
        #self.visibleRows,
        totalCount,
        missingCount,
        collectedCount,
        unobtainableCount
    ))

    if self.selectedRow then
        local stillVisible = false
        for _, row in ipairs(self.visibleRows) do
            if row.collectionType == self.selectedRow.collectionType
                and tostring(self:GetEntryId(row.collectionType, row.entry)) == tostring(self:GetEntryId(self.selectedRow.collectionType, self.selectedRow.entry)) then
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

function CollectionExplorerWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerCollectionExplorerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(1120, 700)
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
    Widgets:HookFrameScript(frame, "OnHide", function()
        Widgets:HideDropdownMenus()
    end)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Collection Explorer")
        local subtitle = Widgets:CreateFontString(frame.headerBar, "OVERLAY", "GameFontHighlightSmall", "titleText")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Patch collection scanner")

        body = CreateFrame("Frame", nil, frame)
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        Theme:RegisterSpecialFrame("TODOPlannerCollectionExplorerFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
    end

    local toolbar = CreateFrame("Frame", nil, body)
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(124)

    self:BuildTypeTabs(toolbar)

    local filterDivider = toolbar:CreateTexture(nil, "ARTWORK")
    filterDivider:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -44)
    filterDivider:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -44)
    filterDivider:SetHeight(1)
    Widgets:SetTextureColor(filterDivider, { 1.0, 0.82, 0.18, 0.24 })

    local expansionButton = Widgets:CreateSelectorButton(toolbar, 220, 24, "")
    expansionButton:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -52)

    local patchButton = Widgets:CreateSelectorButton(toolbar, 130, 24, "")
    patchButton:SetPoint("LEFT", expansionButton, "RIGHT", 8, 0)

    local statusButton = Widgets:CreateSelectorButton(toolbar, 174, 24, "")
    statusButton:SetPoint("LEFT", patchButton, "RIGHT", 8, 0)

    local mountCategoryButton = Widgets:CreateSelectorButton(toolbar, 208, 24, "")
    mountCategoryButton:SetPoint("LEFT", statusButton, "RIGHT", 8, 0)

    local achievementCategoryButton = Widgets:CreateSelectorButton(toolbar, 208, 24, "")
    achievementCategoryButton:SetPoint("LEFT", statusButton, "RIGHT", 8, 0)
    achievementCategoryButton:Hide()

    local refreshButton = Widgets:CreateButton(toolbar, 82, 24, "Refresh", "neutral")
    refreshButton:SetPoint("LEFT", mountCategoryButton, "RIGHT", 8, 0)

    local navigationButtons = Widgets:CreateWindowNavigation(frame.headerBar or toolbar, "collections", self, {
        centered = frame.headerBar ~= nil,
    })

    local searchLabel = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall")
    searchLabel:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 16, -80)
    searchLabel:SetText("Search")

    local searchEdit = Widgets:CreateEditBox(toolbar, 360, 24)
    searchEdit:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -96)
    searchEdit:SetMaxLetters(80)

    local summaryText = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontHighlightSmall")
    summaryText:SetPoint("LEFT", searchEdit, "RIGHT", 16, 0)
    summaryText:SetPoint("RIGHT", toolbar, "RIGHT", -110, 0)
    summaryText:SetJustifyH("LEFT")

    local listPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    listPanel:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -148)
    listPanel:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 12, 12)
    listPanel:SetWidth(LIST_WIDTH)
    listPanel.topAccent = Widgets:AddGoldTopAccent(listPanel, 2, 0.18)

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

    local previewFavoriteButton = Widgets:CreateButton(previewPanel, 124, 24, "Set Favorite", "neutral")
    previewFavoriteButton:SetPoint("LEFT", previewWowheadButton, "RIGHT", 8, 0)

    local previewMapButton = Widgets:CreateButton(previewPanel, 74, 24, "Map", "neutral")
    previewMapButton:SetPoint("LEFT", previewFavoriteButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.expansionButton = expansionButton
    self.patchButton = patchButton
    self.statusButton = statusButton
    self.mountCategoryButton = mountCategoryButton
    self.achievementCategoryButton = achievementCategoryButton
    self.refreshButton = refreshButton
    self.homeButton = navigationButtons.home
    self.favoritesButton = navigationButtons.favorites
    self.plannerButton = navigationButtons.planner
    self.searchEdit = searchEdit
    self.summaryText = summaryText
    self.listScroll = listScroll
    self.listContent = listContent
    self.previewWowheadButton = previewWowheadButton
    self.previewFavoriteButton = previewFavoriteButton
    self.previewMapButton = previewMapButton

    expansionButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, EXPANSION_OPTIONS, self.selectedExpansion, function(value)
            return self:GetExpansionLabel(value)
        end, function(expansionKey)
            self:SetSelectedExpansion(expansionKey)
            self.selectedRow = nil
            self:Render()
        end)
    end)

    patchButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self:GetPatchOptions(), self.selectedPatch, function(value)
            return self:GetPatchLabel(value)
        end, function(patchKey)
            self.selectedPatch = patchKey
            self.selectedRow = nil
            self:Render()
        end)
    end)

    statusButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self:GetStatusOptions(), self.selectedStatus, function(value)
            return self:GetStatusLabel(value)
        end, function(value)
            self:SetSelectedStatus(value)
        end)
    end)

    mountCategoryButton:SetScript("OnClick", function(owner)
        Widgets:ShowMultiSelectMenu(owner, MOUNT_CATEGORY_OPTIONS, function(value)
            return self:IsMountSourceChecked(value)
        end, function(value)
            return self:GetMountCategoryLabel(value)
        end, function(value, checked)
            self:ToggleMountSource(value, checked)
        end)
    end)

    achievementCategoryButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, ACHIEVEMENT_CATEGORY_OPTIONS, self.selectedAchievementCategory, function(value)
            return self:GetAchievementCategoryLabel(value)
        end, function(value)
            self.selectedAchievementCategory = value
            self.selectedRow = nil
            self:Render()
        end)
    end)

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

    previewFavoriteButton:SetScript("OnClick", function()
        self:ToggleFavorite(self.selectedRow)
    end)

    previewMapButton:SetScript("OnClick", function()
        self:OpenCollectionMap(self.selectedRow)
    end)

    self:BindPreviewModelControls()

    self.previewAchievementButton:SetScript("OnClick", function()
        local achievementId = self:GetRowAchievementId(self.selectedRow)
        if not achievementId then
            return
        end

        if not TDP.Achievements or not TDP.Achievements:OpenAchievement(achievementId) then
            Utils:Msg("Could not open that achievement in the achievement window.")
        end
    end)

    frame:Hide()
    return self
end

function CollectionExplorerWindow:Open()
    if not self.frame then
        self:Build()
    end

    CollectionScanner:ResetCache()
    self.frame:Show()
    Widgets:BringToFront(self.frame)

    local ok, errorText = pcall(self.Render, self)
    if not ok then
        Utils:Msg("Collections render failed: " .. tostring(errorText))
    end
end
