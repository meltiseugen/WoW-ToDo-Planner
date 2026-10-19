local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Utils = TDP.Utils
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local Favorites = TDP.Favorites
local COLLECTION_TYPES = FavoritesWindow.Config.COLLECTION_TYPES
local ROW_HEIGHT = FavoritesWindow.Config.ROW_HEIGHT
local ROW_GAP = FavoritesWindow.Config.ROW_GAP
local LIST_CONTENT_WIDTH = FavoritesWindow.Config.LIST_CONTENT_WIDTH

function FavoritesWindow:GetEntryId(collectionType, entry)
    return CollectionScanner:GetEntryKey(collectionType, entry)
end

function FavoritesWindow:GetCatalogEntry(favorite)
    return Favorites and Favorites:FindCatalogEntry(favorite)
end

function FavoritesWindow:GetFallbackEntry(favorite)
    local entryId = favorite and favorite.entryId
    if not favorite then
        return entryId
    end

    if favorite.collectionType == "mounts" then
        return { spellId = entryId, name = "Mount #" .. tostring(entryId) }
    elseif favorite.collectionType == "pets" then
        return { speciesId = entryId, name = "Pet #" .. tostring(entryId) }
    elseif favorite.collectionType == "toys" then
        return { itemId = entryId, name = "Toy #" .. tostring(entryId) }
    elseif favorite.collectionType == "cosmetics" then
        return { itemId = entryId, name = "Cosmetic #" .. tostring(entryId), subtype = "appearance" }
    elseif favorite.collectionType == "achievements" then
        return tonumber(entryId) or entryId
    end
    return entryId
end

function FavoritesWindow:GetCollectionTypes()
    if self.selectedCollectionType == "all" then
        return COLLECTION_TYPES
    end
    return { self.selectedCollectionType }
end

function FavoritesWindow:GetSourceType(collectionType)
    if collectionType == "achievements" then
        return "achievement"
    end
    return "patchCollection"
end

function FavoritesWindow:GetSourceId(row)
    local entryId = self:GetEntryId(row.collectionType, row.entry)
    if row.collectionType == "achievements" then
        return entryId
    end

    return string.format("%s:%s:%s", row.patchKey, row.collectionType, tostring(entryId or "unknown"))
end

function FavoritesWindow:GetRowKey(row)
    if not row then
        return nil
    end

    return string.format("%s:%s:%s", tostring(row.patchKey), tostring(row.collectionType), tostring(self:GetEntryId(row.collectionType, row.entry) or row.name or "unknown"))
end

function FavoritesWindow:BuildVisibleRows()
    wipe(self.visibleRows)

    local allowedTypes = {}
    for _, collectionType in ipairs(self:GetCollectionTypes()) do
        allowedTypes[collectionType] = true
    end

    local searchText = ""
    if self.searchEdit then
        searchText = string.lower(Utils:Trim(self.searchEdit:GetText() or ""))
    end

    local favorites = Favorites and Favorites:GetAll() or {}
    for _, favorite in ipairs(favorites) do
        if allowedTypes[favorite.collectionType] then
            local entry = self:GetCatalogEntry(favorite) or self:GetFallbackEntry(favorite)
            local state = CollectionScanner:GetState(favorite.collectionType, entry)
            local rewardEntry = favorite.collectionType == "achievements" and PatchCatalog:GetAchievementReward(favorite.patchKey, entry)
            local name = CollectionScanner:GetDisplayName(favorite.collectionType, entry, state, favorite.patchKey)
            local reward = (state and state.reward) or (rewardEntry and rewardEntry.reward)
            local collected = state and state.collected == true
            local mountCategory = favorite.collectionType == "mounts" and PatchCatalog:GetMountCategory(favorite.patchKey, entry) or nil
            local mountSource = favorite.collectionType == "mounts" and PatchCatalog:GetMountSourceSummary(favorite.patchKey, entry) or nil
            local mountAcquisition = favorite.collectionType == "mounts" and PatchCatalog:GetMountAcquisitionText(favorite.patchKey, entry) or nil
            local cosmeticSource = favorite.collectionType == "cosmetics" and PatchCatalog:GetCosmeticSourceSummary(favorite.patchKey, entry) or nil
            local cosmeticAcquisition = favorite.collectionType == "cosmetics" and PatchCatalog:GetCosmeticAcquisitionText(favorite.patchKey, entry) or nil
            local cosmeticSubtype = favorite.collectionType == "cosmetics" and type(entry) == "table" and entry.subtype or nil

            local searchMatches = searchText == ""
            if not searchMatches then
                local haystack = string.lower(table.concat({
                    name or "",
                    reward or "",
                    mountCategory or "",
                    mountSource or "",
                    mountAcquisition or "",
                    cosmeticSource or "",
                    cosmeticAcquisition or "",
                    cosmeticSubtype or "",
                    self:GetTypeLabel(favorite.collectionType),
                    tostring(self:GetEntryId(favorite.collectionType, entry) or favorite.entryId or ""),
                }, " "))
                searchMatches = haystack:find(searchText, 1, true) ~= nil
            end

            if searchMatches then
                self.visibleRows[#self.visibleRows + 1] = {
                    favorite = favorite,
                    patchKey = favorite.patchKey,
                    collectionType = favorite.collectionType,
                    entry = entry,
                    state = state,
                    name = name,
                    icon = state and state.icon,
                    collected = collected,
                    reward = reward,
                    mountCategory = mountCategory,
                    cosmeticSubtype = cosmeticSubtype,
                    addedAt = favorite.addedAt,
                }
            end
        end
    end

    table.sort(self.visibleRows, function(a, b)
        return (a.addedAt or 0) > (b.addedAt or 0)
    end)
end

function FavoritesWindow:BuildRow(parent)
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

    local title = Widgets:CreateFontString(row, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -6)
    title:SetPoint("RIGHT", row, "RIGHT", -206, 0)
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

    local removeButton = Widgets:CreateButton(row, 72, 22, "Remove", "danger")
    removeButton:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    row.removeButton = removeButton

    local addButton = Widgets:CreateButton(row, 54, 22, "Add", "primary")
    addButton:SetPoint("RIGHT", removeButton, "LEFT", -6, 0)
    row.addButton = addButton

    local mapButton = Widgets:CreateButton(row, 54, 22, "Map", "neutral")
    mapButton:SetPoint("RIGHT", addButton, "LEFT", -6, 0)
    row.mapButton = mapButton

    row:SetScript("OnMouseDown", function(target)
        self.selectedRow = target.rowData
        self:RenderPreview()
        self:UpdateRowSelection()
    end)

    addButton:SetScript("OnClick", function(target)
        local rowData = target:GetParent().rowData
        if self:CreateTask(rowData) then
            Tasks:SortStable(TODOPlannerDB.tasks)
            Utils:Msg("Added collection task: " .. rowData.name)
            if self.homeWindow and self.homeWindow.plannerWindow then
                self.homeWindow.plannerWindow:Render()
            end
            self:Render()
        end
    end)

    removeButton:SetScript("OnClick", function(target)
        self:RemoveFavorite(target:GetParent().rowData)
    end)

    mapButton:SetScript("OnClick", function(target)
        self:OpenCollectionMap(target:GetParent().rowData)
    end)

    return row
end

function FavoritesWindow:UpdateRow(row, rowData, index)
    row.rowData = rowData
    row:SetParent(self.listContent)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", self.listContent, "TOPLEFT", 0, -((index - 1) * (ROW_HEIGHT + ROW_GAP)))
    row.icon:SetTexture(rowData.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    row.title:SetText(rowData.name)
    local metaPrefix = self:GetTypeLabel(rowData.collectionType)
    if rowData.collectionType == "mounts" then
        metaPrefix = (rowData.mountCategory or "Other") .. " mount"
    elseif rowData.collectionType == "cosmetics" then
        metaPrefix = ((rowData.cosmeticSubtype or "appearance"):gsub("^%l", string.upper)) .. " cosmetic"
    end
    row.meta:SetText(string.format("%s - %s", metaPrefix, rowData.collected and "Collected" or "Missing"))
    Widgets:SetTextureColor(row.accent, rowData.collected and { 0.28, 0.82, 0.42, 0.74 } or "accentGold")

    local existingTask = self:FindTask(rowData)
    row.addButton:SetText(existingTask and "Added" or "Add")
    Widgets:SetButtonEnabled(row.addButton, not rowData.collected and existingTask == nil)
    if self:IsCollectionMapRow(rowData) then
        row.mapButton:Show()
        Widgets:SetButtonEnabled(row.mapButton, true)
    else
        row.mapButton:Hide()
    end
    row:Show()
end

function FavoritesWindow:UpdateRowSelection()
    for _, row in ipairs(self.rowPool) do
        if row.rowData then
            local isSelected = self.selectedRow
                and row.rowData.favorite
                and self.selectedRow.favorite
                and row.rowData.favorite.key == self.selectedRow.favorite.key
            if row.SetBackdropColor then
                local color = Widgets:GetThemeColor(isSelected and "rowSelected" or "rowOdd")
                row:SetBackdropColor(color[1], color[2], color[3], color[4])
            end
            Widgets:ApplyTextColor(row.title, isSelected and "selectionText" or "textStrong")
            Widgets:ApplyTextColor(row.meta, isSelected and "selectionTextSoft" or "textSoft")
        end
    end
end

function FavoritesWindow:BuildRows()
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
    if #self.visibleRows == 0 then
        self.emptyText:Show()
    else
        self.emptyText:Hide()
    end
    self:UpdateRowSelection()
end
