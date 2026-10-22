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

function CollectionExplorerWindow:BuildRow(parent)
    local row = Widgets:CreatePanel(parent, "rowOdd", "goldBorder")
    row:SetSize(LIST_CONTENT_WIDTH, ROW_HEIGHT)
    row:EnableMouse(true)

    local accent = row:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -1)
    accent:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 1)
    accent:SetWidth(3)
    row.accent = accent

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("LEFT", row, "LEFT", 10, 0)
    icon:SetSize(32, 32)
    row.icon = icon

    local factionBadge = row:CreateTexture(nil, "OVERLAY")
    factionBadge:SetTexture("Interface\\Buttons\\WHITE8X8")
    factionBadge:SetPoint("LEFT", icon, "RIGHT", 8, 7)
    factionBadge:SetSize(10, 10)
    factionBadge:Hide()
    row.factionBadge = factionBadge

    local title = Widgets:CreateFontString(row, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", factionBadge, "TOPRIGHT", 6, 1)
    title:SetPoint("RIGHT", row, "RIGHT", -136, 0)
    title:SetJustifyH("LEFT")
    if title.SetWordWrap then
        title:SetWordWrap(false)
    end
    row.title = title

    local meta = Widgets:CreateFontString(row, "OVERLAY", "GameFontHighlightSmall")
    meta:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    meta:SetPoint("RIGHT", title, "RIGHT", 0, 0)
    meta:SetJustifyH("LEFT")
    row.meta = meta

    local favoriteButton = Widgets:CreateButton(row, 54, 22, "Fav", "neutral")
    favoriteButton:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    row.favoriteButton = favoriteButton

    local mapButton = Widgets:CreateButton(row, 54, 22, "Map", "neutral")
    mapButton:SetPoint("RIGHT", favoriteButton, "LEFT", -6, 0)
    row.mapButton = mapButton

    row:SetScript("OnMouseDown", function(target, button)
        if self:TryDressUpCosmetic(target.rowData, button) then
            return
        end

        self.selectedRow = target.rowData
        self:RenderPreview()
        self:UpdateRowSelection()
    end)

    row:SetScript("OnEnter", function(target)
        self:ShowRowTooltip(target)
    end)

    row:SetScript("OnLeave", function()
        self:HideRowTooltip()
    end)

    row:SetScript("OnHide", function()
        self:HideRowTooltip()
    end)

    favoriteButton:SetScript("OnClick", function(target)
        self:ToggleFavorite(target:GetParent().rowData)
    end)

    mapButton:SetScript("OnClick", function(target)
        self:OpenCollectionMap(target:GetParent().rowData)
    end)

    return row
end

function CollectionExplorerWindow:UpdateRow(row, rowData, index)
    row.rowData = rowData
    row:SetParent(self.listContent)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", self.listContent, "TOPLEFT", 0, -((index - 1) * (ROW_HEIGHT + ROW_GAP)))

    local icon = rowData.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
    row.icon:SetTexture(icon)
    row.title:SetText(rowData.name)
    local factionColor = self:GetFactionBadgeColor(rowData.faction)
    if factionColor then
        row.factionBadge:SetVertexColor(factionColor[1], factionColor[2], factionColor[3], factionColor[4])
        row.factionBadge:Show()
    else
        row.factionBadge:Hide()
    end
    local metaPrefix = self:GetTypeLabel(rowData.collectionType)
    if rowData.collectionType == "mounts" then
        metaPrefix = (rowData.mountCategory or "Other") .. " mount"
    elseif rowData.collectionType == "cosmetics" then
        metaPrefix = ((rowData.cosmeticSubtype or "appearance"):gsub("^%l", string.upper)) .. " cosmetic"
    elseif rowData.collectionType == "achievements" then
        metaPrefix = (rowData.achievementCategory or "Other") .. " achievement"
    end
    local metaText = string.format("%s - %s", metaPrefix, self:GetRowStatusLabel(rowData))
    if self.nearbySnapshot or self.selectedPatch == ALL_PATCHES then
        metaText = string.format("Patch %s - %s", rowData.patchKey, metaText)
    end
    row.meta:SetText(metaText)
    Widgets:SetTextureColor(row.accent, rowData.collected and { 0.28, 0.82, 0.42, 0.74 }
        or rowData.unobtainable and { 0.92, 0.36, 0.28, 0.74 } or "accentGold")

    local isFavorite = self:IsFavoriteRow(rowData)
    row.favoriteButton:SetText(isFavorite and "Unfav" or "Fav")
    Widgets:SetButtonEnabled(row.favoriteButton, true)
    if self:IsCollectionMapRow(rowData) then
        row.mapButton:Show()
        Widgets:SetButtonEnabled(row.mapButton, true)
    else
        row.mapButton:Hide()
    end
    row:Show()
end

function CollectionExplorerWindow:UpdateRowSelection()
    for _, row in ipairs(self.rowPool) do
        if row.rowData then
            local isSelected = self.selectedRow
                and row.rowData.collectionType == self.selectedRow.collectionType
                and tostring(self:GetEntryId(row.rowData.collectionType, row.rowData.entry)) == tostring(self:GetEntryId(self.selectedRow.collectionType, self.selectedRow.entry))
            if row.SetBackdropColor then
                local color = Widgets:GetThemeColor(isSelected and "rowSelected" or "rowOdd")
                row:SetBackdropColor(color[1], color[2], color[3], color[4])
            end
            Widgets:ApplyTextColor(row.title, isSelected and "selectionText" or "textStrong")
            Widgets:ApplyTextColor(row.meta, isSelected and "selectionTextSoft" or "textSoft")
        end
    end
end

function CollectionExplorerWindow:BuildRows()
    for _, row in ipairs(self.rowPool) do
        row:Hide()
    end

    local y = 0
    for index, rowData in ipairs(self.visibleRows) do
        local row = self.rowPool[index]
        if not row then
            row = self:BuildRow(self.listContent)
            self.rowPool[index] = row
        end
        self:UpdateRow(row, rowData, index)
        y = y + ROW_HEIGHT + ROW_GAP
    end

    self.listContent:SetSize(LIST_CONTENT_WIDTH, math.max(self.listScroll:GetHeight() or 1, y + 6))
    self:UpdateRowSelection()
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
                local mountSource = collectionType == "mounts" and PatchCatalog:GetMountSourceSummary(patchKey, entry) or nil
                local mountAcquisition = collectionType == "mounts" and PatchCatalog:GetMountAcquisitionText(patchKey, entry) or nil
                local achievementCategory = collectionType == "achievements" and self:GetAchievementCategoryForEntry(patchKey, entry, state) or nil
                local petSource = collectionType == "pets" and PatchCatalog:GetPetSourceSummary(patchKey, entry) or nil
                local petAcquisition = collectionType == "pets" and PatchCatalog:GetPetAcquisitionText(patchKey, entry) or nil
                local toySource = collectionType == "toys" and PatchCatalog:GetToySourceSummary(patchKey, entry) or nil
                local toyAcquisition = collectionType == "toys" and PatchCatalog:GetToyAcquisitionText(patchKey, entry) or nil
                local toyEffect = collectionType == "toys" and PatchCatalog:GetToyUseText(patchKey, entry) or nil
                local cosmeticSource = collectionType == "cosmetics" and PatchCatalog:GetCosmeticSourceSummary(patchKey, entry) or nil
                local cosmeticAcquisition = collectionType == "cosmetics" and PatchCatalog:GetCosmeticAcquisitionText(patchKey, entry) or nil
                local cosmeticSubtype = collectionType == "cosmetics" and type(entry) == "table" and entry.subtype or nil
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
                    or self.selectedStatus == "unobtainable" and unobtainable
                local mountCategoryMatches = collectionType ~= "mounts"
                    or self.selectedCollectionType ~= "mounts"
                    or self:MountCategoryMatchesFilter(mountCategory)
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
                        unobtainable and "Unobtainable" or "",
                        availability and availability.reason or "",
                        self:GetFactionLabel(faction),
                        self:GetTypeLabel(collectionType),
                        tostring(self:GetEntryId(collectionType, entry) or ""),
                    }, " "))
                    searchMatches = haystack:find(searchText, 1, true) ~= nil
                end

                if statusMatches and mountCategoryMatches and achievementCategoryMatches and searchMatches then
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
                        cosmeticSubtype = cosmeticSubtype,
                        achievementCategory = achievementCategory,
                        faction = faction,
                    }
                end
            end
        end
    end

    table.sort(self.visibleRows, function(a, b)
        if a.collectionType ~= b.collectionType then
            return self:GetTypeLabel(a.collectionType) < self:GetTypeLabel(b.collectionType)
        end
        if a.patchKey ~= b.patchKey then
            return (patchOrder[a.patchKey] or math.huge) < (patchOrder[b.patchKey] or math.huge)
        end
        return (a.name or "") < (b.name or "")
    end)

    return totalCount, collectedCount, missingCount, unobtainableCount
end
