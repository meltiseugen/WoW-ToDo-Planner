local _, TDP = ...

local Utils = TDP.Utils
local Widgets = TDP.Widgets
local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local Favorites = TDP.Favorites

local CollectionExplorerWindow = {}
CollectionExplorerWindow.__index = CollectionExplorerWindow

local TYPE_OPTIONS = { "mounts", "pets", "toys", "achievements" }
local STATUS_OPTIONS = { "missing", "all", "collected" }
local MOUNT_CATEGORY_OPTIONS = { "all", "PvP", "Dungeon and Raids", "Quest Rewards", "Rare Drops", "Vendor", "Delves", "Achievements", "Trading Post", "Promotion", "Other" }
local ACHIEVEMENT_CATEGORY_OPTIONS = { "all", "Questing", "Exploration", "Delves", "Dungeons", "Raids", "PvP", "Pet Battles", "Reputation", "Professions", "Events", "Collections", "Feats of Strength", "Other" }
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

function CollectionExplorerWindow:New(homeWindow)
    return setmetatable({
        homeWindow = homeWindow,
        frame = nil,
        selectedPatch = "12.1",
        selectedCollectionType = "mounts",
        selectedStatus = TODOPlannerDB and TODOPlannerDB.settings and TODOPlannerDB.settings.collectionHideCollected == false and "all" or "missing",
        selectedAchievementCategory = "all",
        selectedRow = nil,
        visibleRows = {},
        rowPool = {},
        typeTabs = {},
    }, self)
end

function CollectionExplorerWindow:GetPatchOptions()
    return PatchCatalog and PatchCatalog:GetPatchKeys() or { "12.1" }
end

function CollectionExplorerWindow:GetTypeLabel(value)
    return TYPE_LABELS[value] or tostring(value)
end

function CollectionExplorerWindow:GetStatusLabel(value)
    if value == "missing" then
        return "Missing"
    elseif value == "collected" then
        return "Collected"
    end
    return "All"
end

function CollectionExplorerWindow:GetMountCategoryLabel(value)
    return value == "all" and "All Mount Sources" or tostring(value)
end

function CollectionExplorerWindow:GetMountSourceFilters()
    if not TODOPlannerDB or not TODOPlannerDB.settings then
        return {}
    end

    if type(TODOPlannerDB.settings.collectionMountSourceFilters) ~= "table" then
        TODOPlannerDB.settings.collectionMountSourceFilters = {}
    end

    return TODOPlannerDB.settings.collectionMountSourceFilters
end

function CollectionExplorerWindow:IsAllMountSourcesSelected()
    local filters = self:GetMountSourceFilters()
    for _, category in ipairs(MOUNT_CATEGORY_OPTIONS) do
        if category ~= "all" and filters[category] == true then
            return false
        end
    end
    return true
end

function CollectionExplorerWindow:GetMountSourceSelectionCount()
    local filters = self:GetMountSourceFilters()
    local count = 0
    for _, category in ipairs(MOUNT_CATEGORY_OPTIONS) do
        if category ~= "all" and filters[category] == true then
            count = count + 1
        end
    end
    return count
end

function CollectionExplorerWindow:GetMountSourceSelectionSummary()
    if self:IsAllMountSourcesSelected() then
        return "All"
    end

    local filters = self:GetMountSourceFilters()
    local count = self:GetMountSourceSelectionCount()
    if count == 1 then
        for _, category in ipairs(MOUNT_CATEGORY_OPTIONS) do
            if category ~= "all" and filters[category] == true then
                return category
            end
        end
    end

    return tostring(count) .. " selected"
end

function CollectionExplorerWindow:IsMountSourceChecked(category)
    if category == "all" then
        return self:IsAllMountSourcesSelected()
    end

    return self:GetMountSourceFilters()[category] == true
end

function CollectionExplorerWindow:SetAllMountSourcesSelected()
    local filters = self:GetMountSourceFilters()
    for category in pairs(filters) do
        filters[category] = nil
    end
end

function CollectionExplorerWindow:ToggleMountSource(category, checked)
    local filters = self:GetMountSourceFilters()
    if category == "all" then
        self:SetAllMountSourcesSelected()
    elseif checked then
        filters[category] = true
    else
        filters[category] = nil
    end

    self.selectedRow = nil
    self:Render()
end

function CollectionExplorerWindow:MountCategoryMatchesFilter(category)
    return self:IsAllMountSourcesSelected() or self:GetMountSourceFilters()[category] == true
end

function CollectionExplorerWindow:GetAchievementCategoryLabel(value)
    return value == "all" and "All Types" or tostring(value)
end

function CollectionExplorerWindow:GetMountCategory(row)
    if row and row.collectionType == "mounts" and PatchCatalog then
        return PatchCatalog:GetMountCategory(row.patchKey, row.entry)
    end
    return nil
end

function CollectionExplorerWindow:GetAchievementCategory(rowOrState)
    local staticCategory = rowOrState and rowOrState.achievementCategory
    if type(staticCategory) == "string" and staticCategory ~= "" then
        return staticCategory
    end

    local categoryName = rowOrState and rowOrState.categoryName
        or rowOrState and rowOrState.state and rowOrState.state.categoryName
    local parentCategoryName = rowOrState and rowOrState.parentCategoryName
        or rowOrState and rowOrState.state and rowOrState.state.parentCategoryName
    local achievementName = rowOrState and rowOrState.name
        or rowOrState and rowOrState.state and rowOrState.state.name
    local categoryText = table.concat({
        achievementName or "",
        categoryName or "",
        parentCategoryName or "",
    }, " ")

    if categoryText == "  " then
        return "Other"
    end

    local normalized = string.lower(categoryText)
    if normalized:find("event", 1, true) or normalized:find("holiday", 1, true) then
        return "Events"
    elseif normalized:find("delve", 1, true) or normalized:find("solo him", 1, true) then
        return "Delves"
    elseif normalized:find("raid", 1, true) or normalized:find("venomous abyss", 1, true) then
        return "Raids"
    elseif normalized:find("dungeon", 1, true) or normalized:find("mythic", 1, true) or normalized:find("keystone", 1, true) then
        return "Dungeons"
    elseif normalized:find("player vs", 1, true) or normalized:find("pvp", 1, true) or normalized:find("arena", 1, true) or normalized:find("battleground", 1, true) or normalized:find("gladiator", 1, true) or normalized:find("combatant", 1, true) or normalized:find("tour of duty", 1, true) then
        return "PvP"
    elseif normalized:find("pet", 1, true) or normalized:find("battle pet", 1, true) or normalized:find("safari", 1, true) or normalized:find("family battler", 1, true) then
        return "Pet Battles"
    elseif normalized:find("quest", 1, true) or normalized:find("story", 1, true) or normalized:find("campaign", 1, true) then
        return "Questing"
    elseif normalized:find("reputation", 1, true) or normalized:find("renown", 1, true) then
        return "Reputation"
    elseif normalized:find("profession", 1, true) then
        return "Professions"
    elseif normalized:find("treasure", 1, true) then
        return "Exploration"
    elseif normalized:find("exploration", 1, true) or normalized:find("outdoor", 1, true) or normalized:find("world", 1, true) then
        return "Exploration"
    elseif normalized:find("collection", 1, true) then
        return "Collections"
    elseif normalized:find("feat", 1, true) then
        return "Feats of Strength"
    end

    return "Other"
end

function CollectionExplorerWindow:GetAchievementCategoryForEntry(patchKey, entry, state)
    local staticCategory = PatchCatalog and PatchCatalog:GetAchievementCategory(patchKey, entry)
    if staticCategory then
        return staticCategory
    end

    return self:GetAchievementCategory(state)
end

function CollectionExplorerWindow:GetMountSourceSummary(row)
    if row and row.collectionType == "mounts" and PatchCatalog then
        return PatchCatalog:GetMountSourceSummary(row.patchKey, row.entry)
    end
    return nil
end

function CollectionExplorerWindow:BuildTypeTabs(parent)
    local widths = {
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

function CollectionExplorerWindow:UpdateTypeTabs()
    for value, button in pairs(self.typeTabs) do
        if button.SetSelected then
            button:SetSelected(value == self.selectedCollectionType)
        end
    end
end

function CollectionExplorerWindow:UpdateMountCategoryControl()
    if not self.mountCategoryButton then
        return
    end

    if self.selectedCollectionType == "mounts" then
        self.mountCategoryButton:Show()
        Widgets:UpdateButtonLabel(self.mountCategoryButton, "Sources", self:GetMountSourceSelectionSummary())
    else
        self.mountCategoryButton:Hide()
    end
end

function CollectionExplorerWindow:UpdateAchievementCategoryControl()
    if not self.achievementCategoryButton then
        return
    end

    if self.selectedCollectionType == "achievements" then
        self.achievementCategoryButton:Show()
        Widgets:UpdateButtonLabel(self.achievementCategoryButton, "Ach Type", self.selectedAchievementCategory, function(value)
            return self:GetAchievementCategoryLabel(value)
        end)
    else
        self.achievementCategoryButton:Hide()
    end
end

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

function CollectionExplorerWindow:ClampPreviewModelZoom(value)
    value = tonumber(value) or MODEL_DEFAULT_ZOOM
    if value < MODEL_MIN_ZOOM then
        return MODEL_MIN_ZOOM
    elseif value > MODEL_MAX_ZOOM then
        return MODEL_MAX_ZOOM
    end
    return value
end

function CollectionExplorerWindow:ApplyPreviewModelTransform()
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

function CollectionExplorerWindow:ResetPreviewModelTransform(rowKey)
    self.previewModelRowKey = rowKey or self.previewModelRowKey
    self.previewModelZoom = MODEL_DEFAULT_ZOOM
    self.previewModelFacing = MODEL_DEFAULT_FACING
    self:ApplyPreviewModelTransform()
end

function CollectionExplorerWindow:AdjustPreviewModelZoom(delta)
    self.previewModelZoom = self:ClampPreviewModelZoom((self.previewModelZoom or MODEL_DEFAULT_ZOOM) + delta)
    self:ApplyPreviewModelTransform()
end

function CollectionExplorerWindow:GetRowWowheadUrl(row)
    if not PatchCatalog or not row then
        return nil
    end

    return PatchCatalog:GetWowheadUrl(row.collectionType, row.entry)
end

function CollectionExplorerWindow:IsCollectionMapRow(row)
    return row
        and PatchCatalog
        and PatchCatalog.HasCollectionMapPayload
        and PatchCatalog:HasCollectionMapPayload(row.collectionType, row.patchKey, row.entry)
end

function CollectionExplorerWindow:OpenCollectionMap(row)
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

function CollectionExplorerWindow:IsFavoriteRow(row)
    return row and Favorites and Favorites:IsFavorite(row.patchKey, row.collectionType, row.entry)
end

function CollectionExplorerWindow:RefreshFavoritesWindow()
    if self.homeWindow and self.homeWindow.favoritesWindow and self.homeWindow.favoritesWindow.frame and self.homeWindow.favoritesWindow.frame:IsShown() then
        self.homeWindow.favoritesWindow:Render()
    end
end

function CollectionExplorerWindow:ToggleFavorite(row)
    if not row or not Favorites then
        return
    end

    local ok, isNowFavorite = Favorites:Toggle(row.patchKey, row.collectionType, row.entry)
    if not ok then
        Utils:Msg("Could not update favorite.")
        return
    end

    Utils:Msg((isNowFavorite and "Added favorite: " or "Removed favorite: ") .. (row.name or "Unknown"))
    self:RefreshFavoritesWindow()
    self:Render()
end

function CollectionExplorerWindow:GetRowNotes(row)
    local lines = {}

    if row.collectionType == "mounts" then
        local sourceSummary = self:GetMountSourceSummary(row)
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
    elseif row.collectionType == "achievements" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetAchievementSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetAchievementAcquisitionText(row.patchKey, row.entry)
        local waypoints = PatchCatalog and PatchCatalog:GetAchievementWaypoints(row.patchKey, row.entry)
        if row.achievementCategory then
            lines[#lines + 1] = "Achievement Type: " .. row.achievementCategory
        end
        if row.state and row.state.categoryName then
            lines[#lines + 1] = "WoW Category: " .. row.state.categoryName
        end
        if row.state and row.state.parentCategoryName then
            lines[#lines + 1] = "WoW Parent Category: " .. row.state.parentCategoryName
        end
        if sourceSummary then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
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
    end

    if row.reward then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Reward: " .. row.reward
    end

    return table.concat(lines, "\n")
end

function CollectionExplorerWindow:TryShowGameTooltip(methodName, ...)
    if not GameTooltip or type(GameTooltip[methodName]) ~= "function" then
        return false
    end

    GameTooltip:ClearLines()
    local ok = pcall(GameTooltip[methodName], GameTooltip, ...)
    return ok and (type(GameTooltip.NumLines) ~= "function" or GameTooltip:NumLines() > 0)
end

function CollectionExplorerWindow:TryShowGameTooltipLink(link)
    if not link or not GameTooltip or type(GameTooltip.SetHyperlink) ~= "function" then
        return false
    end

    GameTooltip:ClearLines()
    local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, link)
    return ok and (type(GameTooltip.NumLines) ~= "function" or GameTooltip:NumLines() > 0)
end

function CollectionExplorerWindow:GetBattlePetName(speciesId, row)
    if C_PetJournal and type(C_PetJournal.GetPetInfoBySpeciesID) == "function" and speciesId then
        local ok, name = pcall(C_PetJournal.GetPetInfoBySpeciesID, speciesId)
        if ok and name then
            return name
        end
    end
    return row and row.name
end

function CollectionExplorerWindow:TryShowBattlePetTooltip(owner, speciesId, row)
    speciesId = tonumber(speciesId)
    if not speciesId then
        return false
    end

    local tooltip = _G.FloatingBattlePetTooltip or _G.BattlePetTooltip
    if tooltip and type(tooltip.SetOwner) == "function" then
        tooltip:SetOwner(owner, "ANCHOR_RIGHT")
    end

    local showTooltip = _G.BattlePetTooltip_Show or _G.BattlePetToolTip_Show
    if type(showTooltip) == "function" then
        local ok = pcall(showTooltip, speciesId, 1, 3, 0, 0, 0, self:GetBattlePetName(speciesId, row))
        if ok then
            if GameTooltip then
                GameTooltip:Hide()
            end
            return "battlepet"
        end
    end

    return self:TryShowGameTooltipLink("battlepet:" .. tostring(speciesId) .. ":1:3:0:0:0:0")
end

function CollectionExplorerWindow:ShowFallbackTooltip(row)
    if not GameTooltip or not row then
        return
    end

    GameTooltip:ClearLines()
    GameTooltip:SetText(row.name or "Unknown", 1, 0.82, 0.18)
    GameTooltip:AddLine(self:GetTypeLabel(row.collectionType), 0.86, 0.88, 0.94)
    GameTooltip:AddLine(row.collected and "Collected" or "Missing", row.collected and 0.28 or 0.92, row.collected and 0.82 or 0.72, row.collected and 0.42 or 0.28)
    local notes = self:GetRowNotes(row)
    if notes and notes ~= "" then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(notes, 0.86, 0.88, 0.94, true)
    end
    GameTooltip:Show()
end

function CollectionExplorerWindow:HideRowTooltip()
    if GameTooltip then
        GameTooltip:Hide()
    end

    local hideTooltip = _G.BattlePetTooltip_Hide or _G.BattlePetToolTip_Hide
    if type(hideTooltip) == "function" then
        pcall(hideTooltip)
    end

    if _G.FloatingBattlePetTooltip and _G.FloatingBattlePetTooltip.Hide then
        _G.FloatingBattlePetTooltip:Hide()
    end
    if _G.BattlePetTooltip and _G.BattlePetTooltip.Hide then
        _G.BattlePetTooltip:Hide()
    end
end

function CollectionExplorerWindow:ShowRowTooltip(owner)
    local row = owner and owner.rowData
    if not row or not GameTooltip then
        return
    end

    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")

    local entry = row.entry
    local state = row.state or {}
    local itemId = type(entry) == "table" and tonumber(entry.itemId) or nil
    local spellId = type(entry) == "table" and tonumber(entry.spellId) or nil
    local speciesId = type(entry) == "table" and tonumber(entry.speciesId) or nil
    local achievementId = self:GetRowAchievementId(row)
    local shown = false

    if row.collectionType == "mounts" then
        shown = (itemId and self:TryShowGameTooltip("SetItemByID", itemId))
            or (spellId and self:TryShowGameTooltip("SetMountBySpellID", spellId))
            or (spellId and self:TryShowGameTooltip("SetSpellByID", spellId))
            or (itemId and self:TryShowGameTooltipLink("item:" .. tostring(itemId)))
            or (spellId and self:TryShowGameTooltipLink("spell:" .. tostring(spellId)))
    elseif row.collectionType == "pets" then
        shown = speciesId and self:TryShowBattlePetTooltip(owner, speciesId, row)
    elseif row.collectionType == "toys" then
        shown = (itemId and self:TryShowGameTooltip("SetToyByItemID", itemId))
            or (itemId and self:TryShowGameTooltip("SetItemByID", itemId))
            or (itemId and self:TryShowGameTooltipLink("item:" .. tostring(itemId)))
    elseif row.collectionType == "achievements" then
        shown = (achievementId and self:TryShowGameTooltip("SetAchievementByID", achievementId))
    end

    if not shown and state.linkType and state.linkId then
        local linkType = tostring(state.linkType)
        if linkType == "battle-pet" or linkType == "battlepet" then
            shown = self:TryShowBattlePetTooltip(owner, state.linkId, row)
        else
            shown = self:TryShowGameTooltipLink(linkType .. ":" .. tostring(state.linkId))
        end
    end

    if shown and shown ~= "battlepet" then
        GameTooltip:Show()
    elseif shown == "battlepet" then
        return
    else
        self:ShowFallbackTooltip(row)
    end
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

    local title = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -6)
    title:SetPoint("RIGHT", row, "RIGHT", -136, 0)
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

    local favoriteButton = Widgets:CreateButton(row, 54, 22, "Fav", "neutral")
    favoriteButton:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    row.favoriteButton = favoriteButton

    local mapButton = Widgets:CreateButton(row, 54, 22, "Map", "neutral")
    mapButton:SetPoint("RIGHT", favoriteButton, "LEFT", -6, 0)
    row.mapButton = mapButton

    row:SetScript("OnMouseDown", function(target)
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
    local metaPrefix = self:GetTypeLabel(rowData.collectionType)
    if rowData.collectionType == "mounts" then
        metaPrefix = (rowData.mountCategory or "Other") .. " mount"
    elseif rowData.collectionType == "achievements" then
        metaPrefix = (rowData.achievementCategory or "Other") .. " achievement"
    end
    row.meta:SetText(string.format("%s - %s", metaPrefix, rowData.collected and "Collected" or "Missing"))
    Widgets:SetTextureColor(row.accent, rowData.collected and { 0.28, 0.82, 0.42, 0.74 } or "accentGold")

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
                local color = isSelected and { 0.12, 0.11, 0.08, 0.92 } or { 0.07, 0.08, 0.11, 0.72 }
                row:SetBackdropColor(color[1], color[2], color[3], color[4])
            end
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
    local totalCount = 0

    for _, collectionType in ipairs(self:GetCollectionTypes()) do
        for _, entry in ipairs(PatchCatalog:GetEntries(self.selectedPatch, collectionType)) do
            local state = CollectionScanner:GetState(collectionType, entry)
            local rewardEntry = collectionType == "achievements" and PatchCatalog:GetAchievementReward(self.selectedPatch, entry)
            local name = CollectionScanner:GetDisplayName(collectionType, entry, state, self.selectedPatch)
            local reward = (state and state.reward) or (rewardEntry and rewardEntry.reward)
            local collected = state and state.collected == true
            local mountCategory = collectionType == "mounts" and PatchCatalog:GetMountCategory(self.selectedPatch, entry) or nil
            local mountSource = collectionType == "mounts" and PatchCatalog:GetMountSourceSummary(self.selectedPatch, entry) or nil
            local mountAcquisition = collectionType == "mounts" and PatchCatalog:GetMountAcquisitionText(self.selectedPatch, entry) or nil
            local achievementCategory = collectionType == "achievements" and self:GetAchievementCategoryForEntry(self.selectedPatch, entry, state) or nil
            local petSource = collectionType == "pets" and PatchCatalog:GetPetSourceSummary(self.selectedPatch, entry) or nil
            local petAcquisition = collectionType == "pets" and PatchCatalog:GetPetAcquisitionText(self.selectedPatch, entry) or nil
            local toySource = collectionType == "toys" and PatchCatalog:GetToySourceSummary(self.selectedPatch, entry) or nil
            local toyAcquisition = collectionType == "toys" and PatchCatalog:GetToyAcquisitionText(self.selectedPatch, entry) or nil
            local toyEffect = collectionType == "toys" and PatchCatalog:GetToyUseText(self.selectedPatch, entry) or nil
            totalCount = totalCount + 1

            if collected then
                collectedCount = collectedCount + 1
            else
                missingCount = missingCount + 1
            end

            local statusMatches = self.selectedStatus == "all"
                or self.selectedStatus == "collected" and collected
                or self.selectedStatus == "missing" and not collected
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
                    self:GetTypeLabel(collectionType),
                    tostring(self:GetEntryId(collectionType, entry) or ""),
                }, " "))
                searchMatches = haystack:find(searchText, 1, true) ~= nil
            end

            if statusMatches and mountCategoryMatches and achievementCategoryMatches and searchMatches then
                self.visibleRows[#self.visibleRows + 1] = {
                    patchKey = self.selectedPatch,
                    collectionType = collectionType,
                    entry = entry,
                    state = state,
                    name = name,
                    icon = state and state.icon,
                    collected = collected,
                    reward = reward,
                    mountCategory = mountCategory,
                    achievementCategory = achievementCategory,
                }
            end
        end
    end

    table.sort(self.visibleRows, function(a, b)
        if a.collectionType ~= b.collectionType then
            return self:GetTypeLabel(a.collectionType) < self:GetTypeLabel(b.collectionType)
        end
        return (a.name or "") < (b.name or "")
    end)

    return totalCount, collectedCount, missingCount
end

function CollectionExplorerWindow:RenderPreview()
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
        self.previewTitle:SetText("Select an entry")
        self.previewMeta:SetText("")
        self.previewStatus:SetText("")
        self.previewStatus:Hide()
        Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, "")
        if self.previewAchievementButton then
            self.previewAchievementButton:Hide()
        end
        Widgets:SetButtonEnabled(self.previewWowheadButton, false)
        Widgets:SetButtonEnabled(self.previewFavoriteButton, false)
        self.previewMapButton:Hide()
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
            self.previewModel:Show()
            if self.previewModelControls then
                self.previewModelControls:Show()
            end
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
    elseif row.collectionType == "achievements" then
        previewMeta = (row.achievementCategory or "Other") .. " achievement"
    end
    self.previewMeta:SetText(previewMeta)
    self.previewStatus:SetText("")
    self.previewStatus:Hide()
    if self.previewAchievementButton then
        if self:GetRowAchievementId(row) then
            self.previewAchievementButton:Show()
            Widgets:SetButtonEnabled(self.previewAchievementButton, true)
        else
            self.previewAchievementButton:Hide()
        end
    end

    Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, self:GetRowNotes(row))

    local isFavorite = self:IsFavoriteRow(row)
    self.previewFavoriteButton:SetText(isFavorite and "Remove Favorite" or "Set Favorite")
    Widgets:SetButtonEnabled(self.previewWowheadButton, self:GetRowWowheadUrl(row) ~= nil)
    Widgets:SetButtonEnabled(self.previewFavoriteButton, true)
    if self:IsCollectionMapRow(row) then
        self.previewMapButton:Show()
        Widgets:SetButtonEnabled(self.previewMapButton, true)
    else
        self.previewMapButton:Hide()
    end
end

function CollectionExplorerWindow:Render()
    if not self.frame then
        return
    end

    local totalCount, collectedCount, missingCount = self:BuildVisibleRows()
    Widgets:UpdateButtonLabel(self.patchButton, "Patch", self.selectedPatch)
    Widgets:UpdateButtonLabel(self.statusButton, "Status", self.selectedStatus, function(value)
        return self:GetStatusLabel(value)
    end)
    self:UpdateTypeTabs()
    self:UpdateMountCategoryControl()
    self:UpdateAchievementCategoryControl()

    self.summaryText:SetText(string.format(
        "%d shown  |  %d total  |  %d missing  |  %d collected",
        #self.visibleRows,
        totalCount,
        missingCount,
        collectedCount
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
    local frame = CreateFrame("Frame", "TODOPlannerCollectionExplorerFrame", UIParent, "BasicFrameTemplateWithInset")
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
        local subtitle = frame.headerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Patch collection scanner")

        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerCollectionExplorerFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
    end

    local toolbar = Widgets:CreatePanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(112)
    toolbar.topAccent = Widgets:AddGoldTopAccent(toolbar, 2, 0.20)

    self:BuildTypeTabs(toolbar)

    local patchButton = Widgets:CreateButton(toolbar, 150, 24, "", "neutral")
    patchButton:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -44)

    local statusButton = Widgets:CreateButton(toolbar, 150, 24, "", "neutral")
    statusButton:SetPoint("LEFT", patchButton, "RIGHT", 8, 0)

    local mountCategoryButton = Widgets:CreateButton(toolbar, 208, 24, "", "neutral")
    mountCategoryButton:SetPoint("LEFT", statusButton, "RIGHT", 8, 0)

    local achievementCategoryButton = Widgets:CreateButton(toolbar, 208, 24, "", "neutral")
    achievementCategoryButton:SetPoint("LEFT", statusButton, "RIGHT", 8, 0)
    achievementCategoryButton:Hide()

    local refreshButton = Widgets:CreateButton(toolbar, 82, 24, "Refresh", "neutral")
    refreshButton:SetPoint("LEFT", mountCategoryButton, "RIGHT", 8, 0)

    local homeButton = Widgets:CreateButton(toolbar, 82, 24, "Home", "neutral")
    homeButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", -12, -12)

    local searchLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    searchLabel:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 16, -68)
    searchLabel:SetText("Search")

    local searchEdit = Widgets:CreateEditBox(toolbar, 360, 24)
    searchEdit:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -84)
    searchEdit:SetMaxLetters(80)

    local summaryText = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    summaryText:SetPoint("LEFT", searchEdit, "RIGHT", 16, 0)
    summaryText:SetPoint("RIGHT", toolbar, "RIGHT", -110, 0)
    summaryText:SetJustifyH("LEFT")

    local listPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    listPanel:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -136)
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

    local previewAchievementButton = Widgets:CreateButton(previewPanel, 142, 24, "Open Achievement", "primary")
    previewAchievementButton:SetPoint("TOPLEFT", previewStatus, "BOTTOMLEFT", 0, -8)
    previewAchievementButton:Hide()

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

    local previewFavoriteButton = Widgets:CreateButton(previewPanel, 124, 24, "Set Favorite", "neutral")
    previewFavoriteButton:SetPoint("LEFT", previewWowheadButton, "RIGHT", 8, 0)

    local previewMapButton = Widgets:CreateButton(previewPanel, 74, 24, "Map", "neutral")
    previewMapButton:SetPoint("LEFT", previewFavoriteButton, "RIGHT", 8, 0)

    self.frame = frame
    self.body = body
    self.patchButton = patchButton
    self.statusButton = statusButton
    self.mountCategoryButton = mountCategoryButton
    self.achievementCategoryButton = achievementCategoryButton
    self.refreshButton = refreshButton
    self.homeButton = homeButton
    self.searchEdit = searchEdit
    self.summaryText = summaryText
    self.listScroll = listScroll
    self.listContent = listContent
    self.previewIcon = previewIcon
    self.previewVisual = previewVisual
    self.previewModel = previewModel
    self.previewModelControls = previewModelControls
    self.modelZoomOutButton = modelZoomOutButton
    self.modelResetButton = modelResetButton
    self.modelZoomInButton = modelZoomInButton
    self.previewTitle = previewTitle
    self.previewMeta = previewMeta
    self.previewStatus = previewStatus
    self.previewAchievementButton = previewAchievementButton
    self.previewDetailsScroll = previewDetailsScroll
    self.previewDetailsContent = previewDetailsContent
    self.previewDetails = previewDetails
    self.previewWowheadButton = previewWowheadButton
    self.previewFavoriteButton = previewFavoriteButton
    self.previewMapButton = previewMapButton

    patchButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, self:GetPatchOptions(), self.selectedPatch, nil, function(patchKey)
            self.selectedPatch = patchKey
            self.selectedRow = nil
            self:Render()
        end)
    end)

    statusButton:SetScript("OnClick", function(owner)
        Widgets:ShowSingleSelectMenu(owner, STATUS_OPTIONS, self.selectedStatus, function(value)
            return self:GetStatusLabel(value)
        end, function(value)
            self.selectedStatus = value
            if TODOPlannerDB and TODOPlannerDB.settings then
                TODOPlannerDB.settings.collectionHideCollected = value == "missing"
            end
            self.selectedRow = nil
            self:Render()
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

    previewFavoriteButton:SetScript("OnClick", function()
        self:ToggleFavorite(self.selectedRow)
    end)

    previewMapButton:SetScript("OnClick", function()
        self:OpenCollectionMap(self.selectedRow)
    end)

    previewModel:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustPreviewModelZoom(delta > 0 and -MODEL_ZOOM_STEP or MODEL_ZOOM_STEP)
    end)

    previewModel:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" or type(GetCursorPosition) ~= "function" then
            return
        end

        self.previewModelDragging = true
        self.previewModelDragX = GetCursorPosition()
    end)

    previewModel:SetScript("OnMouseUp", function()
        self.previewModelDragging = false
    end)

    previewModel:SetScript("OnHide", function()
        self.previewModelDragging = false
    end)

    previewModel:SetScript("OnUpdate", function()
        if not self.previewModelDragging or type(GetCursorPosition) ~= "function" then
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

    previewAchievementButton:SetScript("OnClick", function()
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

TDP.CollectionExplorerWindow = CollectionExplorerWindow
