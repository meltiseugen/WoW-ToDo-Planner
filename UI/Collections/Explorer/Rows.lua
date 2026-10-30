local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Utils = TDP.Utils
local Widgets = TDP.Widgets
local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local ALL_PATCHES = CollectionExplorerWindow.Config.ALL_PATCHES
local COLLECTION_TYPES = CollectionExplorerWindow.Config.COLLECTION_TYPES
local ROW_HEIGHT = CollectionExplorerWindow.Config.ROW_HEIGHT
local ROW_GAP = CollectionExplorerWindow.Config.ROW_GAP
local LIST_CONTENT_WIDTH = CollectionExplorerWindow.Config.LIST_CONTENT_WIDTH

function CollectionExplorerWindow:GetCollectionTypes()
    if self.selectedCollectionType == "all" then
        return COLLECTION_TYPES
    end
    return { self.selectedCollectionType }
end

function CollectionExplorerWindow:GetEntryId(collectionType, entry)
    return CollectionScanner:GetEntryKey(collectionType, entry)
end

function CollectionExplorerWindow:GetRowAchievementId(row)
    if not row or row.collectionType ~= "achievements" then
        return nil
    end

    return tonumber(self:GetEntryId(row.collectionType, row.entry))
end

function CollectionExplorerWindow:GetRowKey(row)
    if not row then
        return nil
    end

    return string.format("%s:%s:%s", tostring(row.patchKey), tostring(row.collectionType), tostring(self:GetEntryId(row.collectionType, row.entry) or "unknown"))
end

function CollectionExplorerWindow:GetExplorerRowMeta(row)
    local text
    if self.selectedCollectionType ~= "all" and row.collectionType == "mounts" then
        text = row.mountCategory or "Other"
    else
        text = self:GetRowMetaPrefix(row)
        if self.selectedCollectionType ~= "all" and (row.collectionType == "pets" or row.collectionType == "toys") then
            text = text:gsub("^" .. self:GetTypeLabel(row.collectionType) .. " %- ", "")
        end
    end
    text = text .. " - Patch " .. row.patchKey
    if self.selectedStatus == "all" or row.unobtainable then text = text .. " - " .. self:GetRowStatusLabel(row) end
    return text
end

function CollectionExplorerWindow:BuildRow(parent)
    local row = Widgets:CreatePanel(parent, "rowOdd", "chromeBorder")
    row:SetSize(self.listContentWidth or LIST_CONTENT_WIDTH, ROW_HEIGHT)
    row:EnableMouse(true)
    row.accent = row:CreateTexture(nil, "ARTWORK")
    row.accent:SetPoint("TOPLEFT", 0, -1)
    row.accent:SetPoint("BOTTOMLEFT", 0, 1)
    row.accent:SetWidth(3)
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetPoint("LEFT", 10, 0)
    row.icon:SetSize(32, 32)
    row.iconTooltip = CreateFrame("Frame", nil, row)
    row.iconTooltip:SetAllPoints(row.icon)
    row.iconTooltip:EnableMouse(true)
    row.iconTooltip:SetPropagateMouseClicks(true)
    row.iconTooltip:SetPropagateMouseMotion(true)
    row.factionBadge = Widgets:CreateFontString(row, "OVERLAY", "GameFontNormalSmall")
    row.factionBadge:SetPoint("TOPLEFT", 50, -10)
    row.factionBadge:Hide()
    row.title = Widgets:CreateFontString(row, "OVERLAY", "GameFontNormal")
    row.title:SetJustifyH("LEFT")
    row.title:SetWordWrap(true)
    row.meta = Widgets:CreateFontString(row, "OVERLAY", "GameFontHighlightSmall")
    row.meta:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -4)
    row.meta:SetJustifyH("LEFT")
    row.meta:SetWordWrap(true)
    row.mapButton = self:CreateCollectionShortcut(row, "map")
    row.mapButton:SetPoint("RIGHT", -8, 0)
    row.favoriteButton = self:CreateCollectionShortcut(row, "favorite")
    row.favoriteButton:SetPoint("RIGHT", row.mapButton, "LEFT", -4, 0)
    row:SetScript("OnMouseDown", function(target, button)
        if self:TryDressUpCosmetic(target.rowData, button) then return end
        Widgets:HideDropdownMenus()
        self.selectedRow = target.rowData
        self:RenderPreview()
        self:UpdateRowSelection()
        self:SaveBrowserState()
    end)
    row.iconTooltip:SetScript("OnEnter", function(target) self:ShowRowTooltip(target, row.rowData) end)
    row.iconTooltip:SetScript("OnLeave", function() self:HideRowTooltip() end)
    row.iconTooltip:SetScript("OnHide", function() self:HideRowTooltip() end)
    row.favoriteButton:SetScript("OnClick", function() self:ToggleFavorite(row.rowData) end)
    row.mapButton:SetScript("OnClick", function() self:OpenCollectionMap(row.rowData) end)
    return row
end

function CollectionExplorerWindow:UpdateRow(row, data, index, offsetY)
    local width = self.listContentWidth or LIST_CONTENT_WIDTH
    if row.rowData == data and row.boundWidth == width and row.boundOffset == offsetY
        and row.boundGeometryVersion == self.rowGeometryVersion then return end
    row.rowData = data
    row.boundWidth, row.boundOffset, row.boundGeometryVersion = width, offsetY, self.rowGeometryVersion
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", self.listContent, "TOPLEFT", 0, -(offsetY or 0))
    row:SetWidth(self.listContentWidth or LIST_CONTENT_WIDTH)
    row.icon:SetTexture(data.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    local faction = self:GetFactionBadgeColor(data.faction)
    row.factionBadge:SetShown(faction ~= nil)
    if faction then
        row.factionBadge:SetText(data.faction == "alliance" and "A" or "H")
        row.factionBadge:SetTextColor(faction[1], faction[2], faction[3], faction[4])
    end
    local titleLeft = faction and 64 or 50
    row.title:ClearAllPoints()
    row.title:SetPoint("TOPLEFT", row, "TOPLEFT", titleLeft, -9)
    row.title:SetWidth((self.listContentWidth or LIST_CONTENT_WIDTH) - titleLeft - 76)
    row.meta:SetWidth((self.listContentWidth or LIST_CONTENT_WIDTH) - titleLeft - 76)
    row.title:SetText(data.name)
    self:SetRowMeta(row, data.explorerMeta or self:GetExplorerRowMeta(data), ROW_HEIGHT)
    local favorite = self:IsFavoriteRow(data)
    row.favoriteButton.icon:SetAlpha(favorite and 1 or 0.45)
    row.favoriteButton.helpText = favorite and "Remove this collection from Favorites." or "Save this collection to Favorites."
    if not data.mapActionChecked then
        data.mapActionTitle, data.mapActionHelp = self:GetCollectionMapActionHelp(data)
        data.hasMapAction = self:IsCollectionMapRow(data) == true
        data.mapActionChecked = true
    end
    row.mapButton.explorerHelpTitle, row.mapButton.helpText = data.mapActionTitle, data.mapActionHelp
    row.mapButton:SetShown(data.hasMapAction)
    Widgets:SetTextureColor(row.accent, data.unobtainable and "previewHeading" or data.collected and "previewSuccess" or "accentGold")
    row:Show()
end

function CollectionExplorerWindow:UpdateRowSelection()
    local selectedKey = self:GetRowKey(self.selectedRow)
    for _, row in ipairs(self.rowPool) do
        if row.rowData then
            local selected = selectedKey == self:GetRowKey(row.rowData)
            local color = Widgets:GetThemeColor(selected and "rowSelected" or "rowOdd")
            row:SetBackdropColor(color[1], color[2], color[3], color[4])
            row.accent:SetShown(selected or row.rowData.collected or row.rowData.unobtainable)
            Widgets:ApplyTextColor(row.title, selected and "selectionText" or "textStrong")
            Widgets:ApplyTextColor(row.meta, selected and "selectionTextSoft" or "textSoft")
        end
    end
end

function CollectionExplorerWindow:UpdateVisibleRows(scroll)
    if not self.rowGeometry or self.updatingVisibleRows then return end
    self.updatingVisibleRows = true
    scroll = math.max(0, tonumber(scroll) or self.listScroll:GetVerticalScroll())
    if self.renderedListScroll ~= scroll then self:HideRowTooltip() end
    self.renderedListScroll = scroll
    local bottom = scroll + (self.listViewportHeight or self.listScroll:GetHeight())
    local first, last, low, high = 1, #self.visibleRows, 1, #self.visibleRows
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local geometry = self.rowGeometry[middle]
        if geometry.top + geometry.height < scroll then low = middle + 1 else high = middle - 1 end
    end
    first = math.max(1, low - 1) -- One overscan row prevents gaps during wheel scrolling.
    local poolIndex = 0
    for index = first, last do
        local geometry = self.rowGeometry[index]
        if geometry.top > bottom + ROW_HEIGHT then break end
        poolIndex = poolIndex + 1
        local row = self.rowPool[poolIndex]
        if not row then row = self:BuildRow(self.listContent); self.rowPool[poolIndex] = row end
        self:UpdateRow(row, self.visibleRows[index], index, geometry.top)
    end
    for index = poolIndex + 1, #self.rowPool do
        self.rowPool[index]:Hide()
        self.rowPool[index].rowData = nil
    end
    self:UpdateRowSelection()
    self.updatingVisibleRows = nil
end

function CollectionExplorerWindow:BuildRows(scroll)
    if self.buildingRows then return end
    self.buildingRows = true
    -- Capture the requested offset before native size/range callbacks can clamp it.
    scroll = tonumber(scroll) or tonumber(self.pendingListScroll) or self.listScroll:GetVerticalScroll()
    local width = self.listContentWidth or LIST_CONTENT_WIDTH
    if not self.rowMeasureTitle then
        self.rowMeasureTitle = Widgets:CreateFontString(self.listContent, "OVERLAY", "GameFontNormal")
        self.rowMeasureMeta = Widgets:CreateFontString(self.listContent, "OVERLAY", "GameFontHighlightSmall")
        self.rowMeasureTitle:SetWordWrap(true)
        self.rowMeasureMeta:SetWordWrap(true)
        self.rowMeasureTitle:Hide()
        self.rowMeasureMeta:Hide()
    end
    local y = 0
    self.rowGeometryVersion = (self.rowGeometryVersion or 0) + 1
    self.rowGeometry = {}
    for index, data in ipairs(self.visibleRows) do
        local textWidth = width - (self:GetFactionBadgeColor(data.faction) and 64 or 50) - 76
        self.rowMeasureTitle:SetWidth(textWidth)
        self.rowMeasureMeta:SetWidth(textWidth)
        self.rowMeasureTitle:SetText(data.name)
        data.explorerMeta = self:GetExplorerRowMeta(data)
        self.rowMeasureMeta:SetText(data.explorerMeta)
        local height = math.max(ROW_HEIGHT, math.ceil(self.rowMeasureTitle:GetStringHeight() + self.rowMeasureMeta:GetStringHeight()) + 20)
        self.rowGeometry[index] = { top = y, height = height }
        y = y + height + ROW_GAP
    end
    local viewport = self.listViewportHeight or self.listScroll:GetHeight()
    self.listContent:SetSize(width, math.max(viewport, y))
    if self.listScroll.UpdateScrollChildRect then self.listScroll:UpdateScrollChildRect() end
    scroll = math.max(0, math.min(scroll, y - viewport))
    self.pendingListScroll = nil
    self.listScroll:SetVerticalScroll(scroll)
    self:UpdateVisibleRows(scroll)
    self.hasBuiltRows = true
    self.buildingRows = nil
end

function CollectionExplorerWindow:BuildVisibleRows()
    wipe(self.visibleRows)

    local searchText = ""
    if self.searchEdit then
        searchText = string.lower(Utils:Trim(self.searchEdit:GetText() or ""))
    end

    local collectedCount = 0
    local missingCount = 0
    local unobtainableCount = 0
    local totalCount = 0
    local selectedPatchKeys = self:GetSelectedPatchKeys()
    local patchOrder = {}
    for index, patchKey in ipairs(selectedPatchKeys) do
        patchOrder[patchKey] = index
    end

    for _, collectionType in ipairs(self:GetCollectionTypes()) do
        for _, patchKey in ipairs(selectedPatchKeys) do
            for _, entry in ipairs(self:GetEntriesForView(patchKey, collectionType)) do
                local state = CollectionScanner:GetState(collectionType, entry)
                local rewardEntry = collectionType == "achievements" and PatchCatalog:GetAchievementReward(patchKey, entry)
                local name = CollectionScanner:GetDisplayName(collectionType, entry, state, patchKey)
                local reward = (state and state.reward) or (rewardEntry and rewardEntry.reward)
                local collected = state and state.collected == true
                local availability = PatchCatalog.GetCollectionAvailability
                    and PatchCatalog:GetCollectionAvailability(collectionType, patchKey, entry)
                local unobtainable = PatchCatalog.IsCollectionUnobtainable
                    and PatchCatalog:IsCollectionUnobtainable(collectionType, patchKey, entry) or false
                local mountCategory = collectionType == "mounts" and PatchCatalog:GetMountCategory(patchKey, entry) or nil
                local sourceCategory = self:HasSourceFilter(collectionType) and (mountCategory or self:GetSourceCategory(collectionType, patchKey, entry)) or nil
                local mountSource = searchText ~= "" and collectionType == "mounts" and PatchCatalog:GetMountSourceSummary(patchKey, entry) or nil
                local mountAcquisition = searchText ~= "" and collectionType == "mounts" and PatchCatalog:GetMountAcquisitionText(patchKey, entry) or nil
                local achievementCategory = collectionType == "achievements" and self:GetAchievementCategoryForEntry(patchKey, entry, state) or nil
                local petSource = searchText ~= "" and collectionType == "pets" and PatchCatalog:GetPetSourceSummary(patchKey, entry) or nil
                local petAcquisition = searchText ~= "" and collectionType == "pets" and PatchCatalog:GetPetAcquisitionText(patchKey, entry) or nil
                local toySource = searchText ~= "" and collectionType == "toys" and PatchCatalog:GetToySourceSummary(patchKey, entry) or nil
                local toyAcquisition = searchText ~= "" and collectionType == "toys" and PatchCatalog:GetToyAcquisitionText(patchKey, entry) or nil
                local toyEffect = searchText ~= "" and collectionType == "toys" and PatchCatalog:GetToyUseText(patchKey, entry) or nil
                local cosmeticSource = searchText ~= "" and collectionType == "cosmetics" and PatchCatalog:GetCosmeticSourceSummary(patchKey, entry) or nil
                local cosmeticAcquisition = searchText ~= "" and collectionType == "cosmetics" and PatchCatalog:GetCosmeticAcquisitionText(patchKey, entry) or nil
                local cosmeticSubtype = collectionType == "cosmetics" and type(entry) == "table" and entry.subtype or nil
                local cosmeticType = collectionType == "cosmetics" and self:GetCosmeticType(entry) or nil
                local faction = PatchCatalog:GetCollectionFaction(collectionType, patchKey, entry, state)
                totalCount = totalCount + 1

                if unobtainable then
                    unobtainableCount = unobtainableCount + 1
                end
                if collected then
                    collectedCount = collectedCount + 1
                elseif not unobtainable then
                    missingCount = missingCount + 1
                end

                local statusMatches = self.selectedStatus == "all"
                    or self.selectedStatus == "collected" and collected
                    or self.selectedStatus == "missing" and not collected and not unobtainable
                local sourceCategoryMatches = self:SourceCategoryMatchesFilter(collectionType, sourceCategory)
                local cosmeticTypeMatches = collectionType ~= "cosmetics" or self:CosmeticTypeMatchesFilter(cosmeticType)
                local achievementCategoryMatches = collectionType ~= "achievements"
                    or self.selectedCollectionType ~= "achievements"
                    or self.selectedAchievementCategory == "all"
                    or achievementCategory == self.selectedAchievementCategory

                local searchMatches = searchText == ""
                if not searchMatches then
                    local haystack = string.lower(table.concat({
                        name or "",
                        reward or "",
                        patchKey,
                        self:GetExpansionLabel(self:GetExpansionForPatch(patchKey)),
                        mountCategory or "",
                        sourceCategory or "",
                        mountSource or "",
                        mountAcquisition or "",
                        achievementCategory or "",
                        state and state.categoryName or "",
                        state and state.parentCategoryName or "",
                        petSource or "",
                        petAcquisition or "",
                        toySource or "",
                        toyAcquisition or "",
                        toyEffect or "",
                        cosmeticSource or "",
                        cosmeticAcquisition or "",
                        cosmeticSubtype or "",
                        cosmeticType and self:GetCosmeticTypeLabel(cosmeticType) or "",
                        unobtainable and "Unobtainable" or "",
                        availability and availability.reason or "",
                        self:GetFactionLabel(faction),
                        self:GetTypeLabel(collectionType),
                        tostring(self:GetEntryId(collectionType, entry) or ""),
                    }, " "))
                    searchMatches = haystack:find(searchText, 1, true) ~= nil
                end

                if statusMatches and sourceCategoryMatches and cosmeticTypeMatches and achievementCategoryMatches and searchMatches then
                    self.visibleRows[#self.visibleRows + 1] = {
                        patchKey = patchKey,
                        collectionType = collectionType,
                        entry = entry,
                        state = state,
                        name = name,
                        icon = state and state.icon,
                        collected = collected,
                        unobtainable = unobtainable,
                        availability = availability,
                        reward = reward,
                        mountCategory = mountCategory,
                        sourceCategory = sourceCategory,
                        cosmeticType = cosmeticType,
                        cosmeticSubtype = cosmeticSubtype,
                        achievementCategory = achievementCategory,
                        faction = faction,
                    }
                end
            end
        end
    end

    table.sort(self.visibleRows, function(a, b)
        if self.sortKey == "source" then
            local sourceA, sourceB = a.sourceCategory or a.achievementCategory or "", b.sourceCategory or b.achievementCategory or ""
            if sourceA ~= sourceB then return sourceA < sourceB end
        elseif self.sortKey == "status" then
            local statusA, statusB = self:GetRowStatusLabel(a), self:GetRowStatusLabel(b)
            if statusA ~= statusB then return statusA < statusB end
        elseif self.sortKey == "patch" and a.patchKey ~= b.patchKey then
            return (patchOrder[a.patchKey] or math.huge) > (patchOrder[b.patchKey] or math.huge)
        end
        local nameA, nameB = string.lower(a.name or ""), string.lower(b.name or "")
        if nameA ~= nameB then return nameA < nameB end
        if a.collectionType ~= b.collectionType then return a.collectionType < b.collectionType end
        if a.patchKey ~= b.patchKey then return (patchOrder[a.patchKey] or math.huge) < (patchOrder[b.patchKey] or math.huge) end
        return tostring(self:GetEntryId(a.collectionType, a.entry)) < tostring(self:GetEntryId(b.collectionType, b.entry))
    end)

    return totalCount, collectedCount, missingCount, unobtainableCount
end
