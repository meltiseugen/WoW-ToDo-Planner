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
    self.visibleItemRows = {}

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
            local state = CollectionScanner:GetState(favorite.collectionType, entry, true)
            local rewardEntry = favorite.collectionType == "achievements" and PatchCatalog:GetAchievementReward(favorite.patchKey, entry)
            local name = CollectionScanner:GetDisplayName(favorite.collectionType, entry, state, favorite.patchKey)
            local reward = (state and state.reward) or (rewardEntry and rewardEntry.reward)
            local collected = state and state.collected == true
            local mountCategory = favorite.collectionType == "mounts" and PatchCatalog:GetMountCategory(favorite.patchKey, entry) or nil
            local sourceCategory = favorite.collectionType ~= "achievements" and self:GetSourceCategory(favorite.collectionType, favorite.patchKey, entry) or nil
            local cosmeticType = favorite.collectionType == "cosmetics" and self:GetCosmeticType(entry) or nil
            local mountSource = searchText ~= "" and favorite.collectionType == "mounts" and PatchCatalog:GetCollectionBrowseSourceSummary(favorite.collectionType, favorite.patchKey, entry) or nil
            local cosmeticSource = searchText ~= "" and favorite.collectionType == "cosmetics" and PatchCatalog:GetCollectionBrowseSourceSummary(favorite.collectionType, favorite.patchKey, entry) or nil
            local cosmeticSubtype = favorite.collectionType == "cosmetics" and type(entry) == "table" and entry.subtype or nil

            local searchMatches = searchText == ""
            if not searchMatches then
                local haystack = string.lower(table.concat({
                    name or "",
                    reward or "",
                    mountCategory or "",
                    mountSource or "",
                    cosmeticSource or "",
                    cosmeticSubtype or "",
                    sourceCategory or "",
                    cosmeticType and self:GetCosmeticTypeLabel(cosmeticType) or "",
                    self:GetRowMetaPrefix({ collectionType = favorite.collectionType, patchKey = favorite.patchKey,
                        entry = entry, sourceCategory = sourceCategory, cosmeticType = cosmeticType, cosmeticSubtype = cosmeticSubtype }),
                    self:GetTypeLabel(favorite.collectionType),
                    tostring(self:GetEntryId(favorite.collectionType, entry) or favorite.entryId or ""),
                }, " "))
                searchMatches = haystack:find(searchText, 1, true) ~= nil
            end

            if searchMatches and not PatchCatalog:IsCollectionHiddenInUI(favorite.collectionType, favorite.patchKey, entry) then
                local itemID = type(entry) == "table" and tonumber(entry.itemId)
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
                    sourceCategory = sourceCategory,
                    cosmeticType = cosmeticType,
                    cosmeticSubtype = cosmeticSubtype,
                    addedAt = favorite.addedAt,
                }
                if itemID and (CollectionScanner.itemDataRequests and CollectionScanner.itemDataRequests[itemID] == true
                    or self.cosmeticTypeRequests and self.cosmeticTypeRequests[itemID] == true) then
                    self.visibleItemRows[itemID] = self.visibleItemRows[itemID] or {}
                    table.insert(self.visibleItemRows[itemID], self.visibleRows[#self.visibleRows])
                end
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
    title:SetPoint("TOPLEFT", row, "TOPLEFT", 52, -8)
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
    meta:SetWordWrap(true)
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
            Utils:Msg("Added collection task: " .. rowData.name, "collections")
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

function FavoritesWindow:UpdateRow(row, rowData, index, offsetY)
    if row.rowData == rowData and row.boundGeometryVersion == self.rowGeometryVersion then return end
    row.rowData = rowData
    row.boundGeometryVersion = self.rowGeometryVersion
    local _, mapHelp = self:GetCollectionMapActionHelp(rowData)
    row.mapButton.tooltipText = mapHelp
    row:SetParent(self.listContent)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", self.listContent, "TOPLEFT", 0, -(offsetY or ((index - 1) * (ROW_HEIGHT + ROW_GAP))))
    row.icon:SetTexture(rowData.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    row.title:SetText(rowData.name)
    self:SetRowMeta(row, rowData.favoriteMeta, ROW_HEIGHT)
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

function FavoritesWindow:ReleaseRows()
    for _, row in ipairs(self.rowPool) do
        row:Hide()
        row.rowData = nil
        row.title:SetText("")
        row.meta:SetText("")
        row.icon:SetTexture(nil)
    end
    self.rowGeometry = nil
    self.visibleItemRows = nil
    wipe(self.visibleRows)
end

function FavoritesWindow:UpdateVisibleRows(scroll)
    if not self.rowGeometry or self.updatingVisibleRows then return end
    self.updatingVisibleRows = true
    scroll = math.max(0, tonumber(scroll) or self.listScroll:GetVerticalScroll())
    local bottom = scroll + self.listScroll:GetHeight()
    local low, high = 1, #self.visibleRows
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local geometry = self.rowGeometry[middle]
        if geometry.top + geometry.height < scroll then low = middle + 1 else high = middle - 1 end
    end
    local poolIndex = 0
    for index = math.max(1, low - 1), #self.visibleRows do
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

function FavoritesWindow:BuildRows()
    if self.buildingRows then return end
    self.buildingRows = true
    local scroll = self.listScroll:GetVerticalScroll()
    if not self.rowMeasureTitle then
        self.rowMeasureTitle = Widgets:CreateFontString(self.listContent, "OVERLAY", "GameFontNormal")
        self.rowMeasureMeta = Widgets:CreateFontString(self.listContent, "OVERLAY", "GameFontHighlightSmall")
        self.rowMeasureTitle:SetWordWrap(false)
        self.rowMeasureMeta:SetWordWrap(true)
        self.rowMeasureTitle:SetWidth(LIST_CONTENT_WIDTH - 258)
        self.rowMeasureMeta:SetWidth(LIST_CONTENT_WIDTH - 258)
        self.rowMeasureTitle:Hide()
        self.rowMeasureMeta:Hide()
    end
    self.rowGeometryVersion = (self.rowGeometryVersion or 0) + 1
    self.rowGeometry = {}
    local y = 0
    for index, rowData in ipairs(self.visibleRows) do
        rowData.favoriteMeta = string.format("%s - %s", self:GetRowMetaPrefix(rowData), rowData.collected and "Collected" or "Missing")
        self.rowMeasureTitle:SetText(rowData.name)
        self.rowMeasureMeta:SetText(rowData.favoriteMeta)
        local height = math.max(ROW_HEIGHT, math.ceil(self.rowMeasureTitle:GetStringHeight() + self.rowMeasureMeta:GetStringHeight()) + 20)
        self.rowGeometry[index] = { top = y, height = height }
        y = y + height + ROW_GAP
    end
    local viewport = math.max(1, self.listScroll:GetHeight())
    self.listContent:SetSize(LIST_CONTENT_WIDTH, math.max(viewport, y + 6))
    if self.listScroll.UpdateScrollChildRect then self.listScroll:UpdateScrollChildRect() end
    scroll = math.max(0, math.min(scroll, y + 6 - viewport))
    self.listScroll:SetVerticalScroll(scroll)
    self:UpdateVisibleRows(scroll)
    self.emptyText:SetShown(#self.visibleRows == 0)
    self.buildingRows = nil
end
