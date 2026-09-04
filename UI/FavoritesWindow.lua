local _, TDP = ...

local Utils = TDP.Utils
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local Favorites = TDP.Favorites

local FavoritesWindow = {}
FavoritesWindow.__index = FavoritesWindow

local TYPE_OPTIONS = { "all", "mounts", "pets", "toys", "achievements" }
local COLLECTION_TYPES = { "mounts", "pets", "toys", "achievements" }
local ROW_HEIGHT = 48
local ROW_GAP = 5
local LIST_WIDTH = 548
local LIST_CONTENT_WIDTH = 510
local MODEL_DEFAULT_FACING = 0.45
local MODEL_DEFAULT_ZOOM = 1.65
local MODEL_MIN_ZOOM = 0.65
local MODEL_MAX_ZOOM = 3.25
local MODEL_ZOOM_STEP = 0.15
local PREVIEW_VISUAL_WIDTH = 240
local PREVIEW_VISUAL_HEIGHT = 176
local PREVIEW_DETAIL_TOP_OFFSET = -190

local TYPE_LABELS = {
    all = "All",
    mounts = "Mounts",
    pets = "Pets",
    toys = "Toys",
    achievements = "Achievements",
}

local CATEGORY_BY_TYPE = {
    mounts = "Mounts",
    pets = "Collections",
    toys = "Collections",
    achievements = "Achievements",
}

function FavoritesWindow:New(homeWindow)
    return setmetatable({
        homeWindow = homeWindow,
        frame = nil,
        selectedCollectionType = "all",
        selectedRow = nil,
        visibleRows = {},
        rowPool = {},
        typeTabs = {},
    }, self)
end

function FavoritesWindow:GetTypeLabel(value)
    return TYPE_LABELS[value] or tostring(value)
end

function FavoritesWindow:BuildTypeTabs(parent)
    local widths = {
        all = 54,
        mounts = 82,
        pets = 64,
        toys = 64,
        achievements = 118,
    }
    local previous

    for _, value in ipairs(TYPE_OPTIONS) do
        local button = Widgets:CreateButton(parent, widths[value] or 82, 24, self:GetTypeLabel(value), "neutral")
        if previous then
            button:SetPoint("LEFT", previous, "RIGHT", 6, 0)
        else
            button:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -12)
        end
        button:SetScript("OnClick", function()
            self.selectedCollectionType = value
            self.selectedRow = nil
            self:Render()
        end)
        self.typeTabs[value] = button
        previous = button
    end
end

function FavoritesWindow:UpdateTypeTabs()
    for value, button in pairs(self.typeTabs) do
        if button.SetSelected then
            button:SetSelected(value == self.selectedCollectionType)
        end
    end
end

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

function FavoritesWindow:ClampPreviewModelZoom(value)
    value = tonumber(value) or MODEL_DEFAULT_ZOOM
    if value < MODEL_MIN_ZOOM then
        return MODEL_MIN_ZOOM
    elseif value > MODEL_MAX_ZOOM then
        return MODEL_MAX_ZOOM
    end
    return value
end

function FavoritesWindow:ApplyPreviewModelTransform()
    if not self.previewModel then
        return
    end

    if self.previewModel.SetCamDistanceScale then
        pcall(self.previewModel.SetCamDistanceScale, self.previewModel, self.previewModelZoom or MODEL_DEFAULT_ZOOM)
    end
    if self.previewModel.SetFacing then
        pcall(self.previewModel.SetFacing, self.previewModel, self.previewModelFacing or MODEL_DEFAULT_FACING)
    end
end

function FavoritesWindow:ResetPreviewModelTransform(rowKey)
    self.previewModelZoom = MODEL_DEFAULT_ZOOM
    self.previewModelFacing = MODEL_DEFAULT_FACING
    self.previewModelRowKey = rowKey
    self:ApplyPreviewModelTransform()
end

function FavoritesWindow:AdjustPreviewModelZoom(delta)
    self.previewModelZoom = self:ClampPreviewModelZoom((self.previewModelZoom or MODEL_DEFAULT_ZOOM) + delta)
    self:ApplyPreviewModelTransform()
end

function FavoritesWindow:FindTask(row)
    local boardKey = Tasks:GetSelectedCreationBoardKey()
    return Tasks:FindBySource(self:GetSourceType(row.collectionType), self:GetSourceId(row), boardKey)
end

function FavoritesWindow:GetRowWowheadUrl(row)
    if not PatchCatalog or not row then
        return nil
    end

    return PatchCatalog:GetWowheadUrl(row.collectionType, row.entry)
end

function FavoritesWindow:IsCollectionMapRow(row)
    return row
        and PatchCatalog
        and PatchCatalog.HasCollectionMapPayload
        and PatchCatalog:HasCollectionMapPayload(row.collectionType, row.patchKey, row.entry)
end

function FavoritesWindow:OpenCollectionMap(row)
    if not self:IsCollectionMapRow(row) then
        Utils:Msg("No curated map location is available for this collection entry.")
        return
    end

    if not TDP.collectionMapWindow and TDP.CollectionMapWindow then
        TDP.collectionMapWindow = TDP.CollectionMapWindow:New()
    end
    if not TDP.collectionMapWindow or not PatchCatalog or not PatchCatalog.GetCollectionMapPayload then
        Utils:Msg("Collection map is unavailable.")
        return
    end

    local payload = PatchCatalog:GetCollectionMapPayload(row.collectionType, row.patchKey, row.entry, row.state)
    if not payload then
        Utils:Msg("No curated map location is available for this collection entry.")
        return
    end
    payload.title = row.name or payload.title
    payload.collectionType = row.collectionType
    payload.icon = row.icon or payload.icon
    TDP.collectionMapWindow:Open(payload)
end

function FavoritesWindow:GetRowNotes(row)
    local lines = {}

    if row.collectionType == "mounts" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetMountSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetMountAcquisitionText(row.patchKey, row.entry)
        local waypoints = PatchCatalog and PatchCatalog:GetMountWaypoints(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
        if waypoints then
            for _, waypoint in ipairs(waypoints) do
                lines[#lines + 1] = waypoint
            end
        end
    elseif row.collectionType == "pets" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetPetSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetPetAcquisitionText(row.patchKey, row.entry)
        local waypoints = PatchCatalog and PatchCatalog:GetPetWaypoints(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
        if waypoints then
            for _, waypoint in ipairs(waypoints) do
                lines[#lines + 1] = waypoint
            end
        end
    elseif row.collectionType == "toys" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetToySourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetToyAcquisitionText(row.patchKey, row.entry)
        local effect = PatchCatalog and PatchCatalog:GetToyUseText(row.patchKey, row.entry)
        local waypoints = PatchCatalog and PatchCatalog:GetToyWaypoints(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
        if effect then
            lines[#lines + 1] = "Effect: " .. effect
        end
        if waypoints then
            for _, waypoint in ipairs(waypoints) do
                lines[#lines + 1] = waypoint
            end
        end
    elseif row.collectionType == "achievements" and row.achievementCategory then
        lines[#lines + 1] = "Achievement Type: " .. row.achievementCategory
    end

    if row.reward then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Reward: " .. row.reward
    end

    return table.concat(lines, "\n")
end

function FavoritesWindow:CreateTask(row)
    if not row or row.collected or self:FindTask(row) then
        return false
    end

    Tasks:CreateOnSelectedBoard({
        title = row.name,
        notes = self:GetRowNotes(row),
        category = CATEGORY_BY_TYPE[row.collectionType] or "Collections",
        status = "TODO",
        sourceType = self:GetSourceType(row.collectionType),
        sourceId = self:GetSourceId(row),
    })

    return true
end

function FavoritesWindow:RemoveFavorite(row)
    if not row or not Favorites then
        return
    end

    if Favorites:Remove(row.patchKey, row.collectionType, row.entry) then
        Utils:Msg("Removed favorite: " .. (row.name or "Unknown"))
        self.selectedRow = nil
        if self.homeWindow and self.homeWindow.explorerWindow and self.homeWindow.explorerWindow.frame and self.homeWindow.explorerWindow.frame:IsShown() then
            self.homeWindow.explorerWindow:Render()
        end
        self:Render()
    end
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

            local searchMatches = searchText == ""
            if not searchMatches then
                local haystack = string.lower(table.concat({
                    name or "",
                    reward or "",
                    mountCategory or "",
                    mountSource or "",
                    mountAcquisition or "",
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

    local title = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -6)
    title:SetPoint("RIGHT", row, "RIGHT", -206, 0)
    title:SetJustifyH("LEFT")
    if title.SetWordWrap then
        title:SetWordWrap(false)
    end
    row.title = title

    local meta = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
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
                local color = isSelected and { 0.12, 0.11, 0.08, 0.92 } or { 0.07, 0.08, 0.11, 0.72 }
                row:SetBackdropColor(color[1], color[2], color[3], color[4])
            end
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

function FavoritesWindow:RenderPreview()
    local row = self.selectedRow
    if not row then
        if self.previewModel then
            self.previewModel:Hide()
        end
        if self.previewModelControls then
            self.previewModelControls:Hide()
        end
        self.previewIcon:Show()
        self.previewIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        self.previewTitle:SetText("Select a favorite")
        self.previewMeta:SetText("")
        self.previewStatus:SetText("")
        self.previewStatus:Hide()
        Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, "")
        Widgets:SetButtonEnabled(self.previewWowheadButton, false)
        self.previewMapButton:Hide()
        Widgets:SetButtonEnabled(self.previewRemoveButton, false)
        return
    end

    local didShowModel = false
    if self.previewModel and self.previewModel.SetDisplayInfo and row.state and row.state.modelId then
        local ok = pcall(self.previewModel.SetDisplayInfo, self.previewModel, row.state.modelId)
        if ok then
            local rowKey = self:GetRowKey(row)
            if self.previewModelRowKey ~= rowKey then
                self:ResetPreviewModelTransform(rowKey)
            else
                self:ApplyPreviewModelTransform()
            end
            if self.previewModelControls then
                self.previewModelControls:Show()
            end
            self.previewModel:Show()
            self.previewIcon:Hide()
            didShowModel = true
        end
    end

    if not didShowModel then
        if self.previewModel then
            self.previewModel:Hide()
        end
        if self.previewModelControls then
            self.previewModelControls:Hide()
        end
        self.previewIcon:Show()
        self.previewIcon:SetTexture(row.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    end

    self.previewTitle:SetText(row.name or "Unknown")
    local previewMeta = self:GetTypeLabel(row.collectionType)
    if row.collectionType == "mounts" then
        previewMeta = (row.mountCategory or "Other") .. " mount"
    end
    self.previewMeta:SetText(previewMeta)
    self.previewStatus:SetText("")
    self.previewStatus:Hide()
    Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, self:GetRowNotes(row))

    Widgets:SetButtonEnabled(self.previewWowheadButton, self:GetRowWowheadUrl(row) ~= nil)
    self.previewRemoveButton:ClearAllPoints()
    if self:IsCollectionMapRow(row) then
        self.previewMapButton:Show()
        Widgets:SetButtonEnabled(self.previewMapButton, true)
        self.previewRemoveButton:SetPoint("LEFT", self.previewMapButton, "RIGHT", 8, 0)
    else
        self.previewMapButton:Hide()
        self.previewRemoveButton:SetPoint("LEFT", self.previewWowheadButton, "RIGHT", 8, 0)
    end
    Widgets:SetButtonEnabled(self.previewRemoveButton, true)
end

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
    local frame = CreateFrame("Frame", "TODOPlannerFavoritesFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(1120, 700)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Favorites")
        local subtitle = frame.headerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
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
    refreshButton:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 410, -12)

    local homeButton = Widgets:CreateButton(toolbar, 82, 24, "Home", "neutral")
    homeButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -12)

    local searchLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    searchLabel:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 16, -36)
    searchLabel:SetText("Search")

    local searchEdit = Widgets:CreateEditBox(toolbar, 360, 24)
    searchEdit:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -52)
    searchEdit:SetMaxLetters(80)

    local summaryText = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    summaryText:SetPoint("LEFT", searchEdit, "RIGHT", 16, 0)
    summaryText:SetPoint("RIGHT", toolbar, "RIGHT", -110, 0)
    summaryText:SetJustifyH("LEFT")

    local listPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    listPanel:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -108)
    listPanel:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 12, 12)
    listPanel:SetWidth(LIST_WIDTH)
    listPanel.topAccent = Widgets:AddGoldTopAccent(listPanel, 2, 0.18)

    local emptyText = listPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
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

    local previewVisual = CreateFrame("Frame", nil, previewPanel)
    previewVisual:SetPoint("TOPLEFT", previewPanel, "TOPLEFT", 12, -12)
    previewVisual:SetSize(PREVIEW_VISUAL_WIDTH, PREVIEW_VISUAL_HEIGHT)

    local previewIcon = previewVisual:CreateTexture(nil, "ARTWORK")
    previewIcon:SetPoint("CENTER", previewVisual, "CENTER", 0, 4)
    previewIcon:SetSize(112, 112)

    local previewModel = CreateFrame("PlayerModel", nil, previewVisual)
    previewModel:SetAllPoints(previewVisual)
    previewModel:EnableMouse(true)
    previewModel:EnableMouseWheel(true)
    previewModel:Hide()

    local previewModelControls = CreateFrame("Frame", nil, previewVisual)
    previewModelControls:SetPoint("BOTTOMLEFT", previewVisual, "BOTTOMLEFT", 4, 4)
    previewModelControls:SetPoint("BOTTOMRIGHT", previewVisual, "BOTTOMRIGHT", -4, 4)
    previewModelControls:SetHeight(22)
    if previewModelControls.SetFrameLevel and previewModel.GetFrameLevel then
        previewModelControls:SetFrameLevel((previewModel:GetFrameLevel() or 1) + 5)
    end
    previewModelControls:Hide()

    local modelZoomOutButton = Widgets:CreateButton(previewModelControls, 24, 20, "-", "neutral")
    modelZoomOutButton:SetPoint("LEFT", previewModelControls, "LEFT", 0, 0)

    local modelResetButton = Widgets:CreateButton(previewModelControls, 56, 20, "Reset", "neutral")
    modelResetButton:SetPoint("LEFT", modelZoomOutButton, "RIGHT", 4, 0)

    local modelZoomInButton = Widgets:CreateButton(previewModelControls, 24, 20, "+", "neutral")
    modelZoomInButton:SetPoint("LEFT", modelResetButton, "RIGHT", 4, 0)

    local previewTitle = previewPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    previewTitle:SetPoint("TOPLEFT", previewVisual, "TOPRIGHT", 12, -8)
    previewTitle:SetPoint("RIGHT", previewPanel, "RIGHT", -18, 0)
    previewTitle:SetJustifyH("LEFT")
    if previewTitle.SetWordWrap then
        previewTitle:SetWordWrap(true)
    end

    local previewMeta = previewPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    previewMeta:SetPoint("TOPLEFT", previewTitle, "BOTTOMLEFT", 0, -8)
    previewMeta:SetPoint("RIGHT", previewTitle, "RIGHT", 0, 0)
    previewMeta:SetJustifyH("LEFT")

    local previewStatus = previewPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    previewStatus:SetPoint("TOPLEFT", previewMeta, "BOTTOMLEFT", 0, -10)
    previewStatus:SetJustifyH("LEFT")

    local detailPanel = Widgets:CreatePanel(previewPanel, "input", "inputBorder")
    detailPanel:SetPoint("TOPLEFT", previewPanel, "TOPLEFT", 18, PREVIEW_DETAIL_TOP_OFFSET)
    detailPanel:SetPoint("BOTTOMRIGHT", previewPanel, "BOTTOMRIGHT", -18, 58)

    local previewDetailsScroll = CreateFrame("ScrollFrame", nil, detailPanel, "UIPanelScrollFrameTemplate")
    previewDetailsScroll:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -12)
    previewDetailsScroll:SetPoint("BOTTOMRIGHT", detailPanel, "BOTTOMRIGHT", -28, 12)

    local previewDetailsContent = CreateFrame("Frame", nil, previewDetailsScroll)
    previewDetailsContent:SetSize(1, 1)
    previewDetailsScroll:SetScrollChild(previewDetailsContent)

    local previewDetails = previewDetailsContent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    previewDetails:SetPoint("TOPLEFT", previewDetailsContent, "TOPLEFT", 0, 0)
    previewDetails:SetPoint("TOPRIGHT", previewDetailsContent, "TOPRIGHT", 0, 0)
    Widgets:ConfigurePreviewDetailText(previewDetails)

    detailPanel:SetScript("OnSizeChanged", function()
        Widgets:UpdateScrollablePreviewText(previewDetailsScroll, previewDetailsContent, previewDetails, previewDetails.rawPreviewText)
    end)

    local previewWowheadButton = Widgets:CreateButton(previewPanel, 96, 24, "Wowhead", "neutral")
    previewWowheadButton:SetPoint("BOTTOMLEFT", previewPanel, "BOTTOMLEFT", 18, 20)

    local previewMapButton = Widgets:CreateButton(previewPanel, 74, 24, "Map", "neutral")
    previewMapButton:SetPoint("LEFT", previewWowheadButton, "RIGHT", 8, 0)

    local previewRemoveButton = Widgets:CreateButton(previewPanel, 124, 24, "Remove", "danger")
    previewRemoveButton:SetPoint("LEFT", previewMapButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.refreshButton = refreshButton
    self.homeButton = homeButton
    self.searchEdit = searchEdit
    self.summaryText = summaryText
    self.emptyText = emptyText
    self.listScroll = listScroll
    self.listContent = listContent
    self.previewVisual = previewVisual
    self.previewIcon = previewIcon
    self.previewModel = previewModel
    self.previewModelControls = previewModelControls
    self.modelZoomOutButton = modelZoomOutButton
    self.modelResetButton = modelResetButton
    self.modelZoomInButton = modelZoomInButton
    self.previewTitle = previewTitle
    self.previewMeta = previewMeta
    self.previewStatus = previewStatus
    self.previewDetailsScroll = previewDetailsScroll
    self.previewDetailsContent = previewDetailsContent
    self.previewDetails = previewDetails
    self.previewWowheadButton = previewWowheadButton
    self.previewMapButton = previewMapButton
    self.previewRemoveButton = previewRemoveButton

    refreshButton:SetScript("OnClick", function()
        CollectionScanner:ResetCache()
        self:Render()
    end)

    homeButton:SetScript("OnClick", function()
        frame:Hide()
        if self.homeWindow then
            self.homeWindow:Open()
        end
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

    previewModel:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustPreviewModelZoom(delta > 0 and -MODEL_ZOOM_STEP or MODEL_ZOOM_STEP)
    end)

    previewModel:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" then
            return
        end

        self.previewModelDragging = true
        self.previewModelDragX = GetCursorPosition()
    end)

    previewModel:SetScript("OnMouseUp", function(_, button)
        if button ~= "LeftButton" then
            return
        end

        self.previewModelDragging = false
        self.previewModelDragX = nil
    end)

    previewModel:SetScript("OnHide", function()
        self.previewModelDragging = false
        self.previewModelDragX = nil
    end)

    previewModel:SetScript("OnUpdate", function()
        if not self.previewModelDragging then
            return
        end

        local cursorX = GetCursorPosition()
        local previousX = self.previewModelDragX or cursorX
        self.previewModelDragX = cursorX
        self.previewModelFacing = (self.previewModelFacing or MODEL_DEFAULT_FACING) + ((cursorX - previousX) * 0.01)
        self:ApplyPreviewModelTransform()
    end)

    modelZoomOutButton:SetScript("OnClick", function()
        self:AdjustPreviewModelZoom(MODEL_ZOOM_STEP)
    end)

    modelZoomInButton:SetScript("OnClick", function()
        self:AdjustPreviewModelZoom(-MODEL_ZOOM_STEP)
    end)

    modelResetButton:SetScript("OnClick", function()
        self:ResetPreviewModelTransform(self:GetRowKey(self.selectedRow))
    end)

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
    if TDP.Theme then
        TDP.Theme:BringToFront(self.frame)
    end
end

TDP.FavoritesWindow = FavoritesWindow
