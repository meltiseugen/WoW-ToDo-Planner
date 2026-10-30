local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Utils = TDP.Utils
local PatchCatalog = TDP.PatchCatalog
local Favorites = TDP.Favorites

function CollectionExplorerWindow:OpenAchievement(achievementId, sourcePatch)
    achievementId = tonumber(achievementId)
    if not achievementId or achievementId <= 0 then return false end
    if not self.frame then self:Build() end

    local patchKey = PatchCatalog:GetAchievementPatchKey(achievementId, sourcePatch)
    if PatchCatalog:IsCollectionHiddenInUI("achievements", patchKey, achievementId) then return false end
    self.pendingSelectionKey = nil
    self.pendingListScroll = 0
    self.nearbySnapshot = nil
    self.linkedAchievement = { patchKey = patchKey, id = achievementId }
    self.selectedExpansion = self:GetExpansionForPatch(patchKey)
    self.selectedPatch = patchKey
    self.selectedCollectionType = "achievements"
    self.selectedStatus = "all"
    self.selectedAchievementCategory = "all"
    self.selectedRow = { collectionType = "achievements", patchKey = patchKey, entry = achievementId }
    self.changingView = true
    self.searchEdit:SetText(tostring(achievementId))
    self.changingView = false
    self.listScroll:SetVerticalScroll(0)
    if self.homeWindow then
        self.homeWindow:OpenExplorer()
    else
        self:Open()
    end
    return true
end

function CollectionExplorerWindow:ScanNearby()
    if not self.nearbySnapshot then
        self:SaveBrowserState()
        self:CaptureListState()
        self.browseCollectionType = self.selectedCollectionType
        self.browseSearchText = self.searchEdit and self.searchEdit:GetText() or ""
        self.browseState = { status = self.selectedStatus, achievementCategory = self.selectedAchievementCategory,
            sortKey = self.sortKey,
            sourceFilters = Utils:CopyDefaults({}, TODOPlannerDB.settings.collectionSourceFilters),
            mountSources = Utils:CopyDefaults({}, TODOPlannerDB.settings.collectionMountSourceFilters),
            cosmeticType = self:GetCosmeticTypeFilter() }
    end
    self.pendingSelectionKey = nil
    self.pendingListScroll = 0
    self.nearbySnapshot = TDP.NearbyCollections:Scan()
    self.selectedRow = nil
    self.changingView = true
    if self.searchEdit then
        self.searchEdit:SetText("")
    end
    self.changingView = false
    TDP.CollectionScanner:ResetCache()
    if self.listScroll then
        self.listScroll:SetVerticalScroll(0)
    end
    self:Render()
end

function CollectionExplorerWindow:BrowseCollections()
    self.nearbySnapshot = nil
    self.selectedCollectionType = self.browseCollectionType or "mounts"
    if self.browseState then
        self.selectedStatus = self.browseState.status
        self.selectedAchievementCategory = self.browseState.achievementCategory
        self.sortKey = self.browseState.sortKey
        TODOPlannerDB.settings.collectionStatusFilter = self.selectedStatus
        TODOPlannerDB.settings.collectionHideCollected = self.selectedStatus == "missing"
        TODOPlannerDB.settings.collectionSourceFilters = self.browseState.sourceFilters
        TODOPlannerDB.settings.collectionMountSourceFilters = self.browseState.mountSources
        TODOPlannerDB.settings.collectionCosmeticTypeFilter = self.browseState.cosmeticType
        self.selectedCosmeticType = self.browseState.cosmeticType
    end
    self:RestoreListState()
    self.changingView = true
    if self.searchEdit then
        self.searchEdit:SetText(self.browseSearchText or "")
    end
    self.changingView = false
    self:Render()
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
        and (self:GetCollectionMapAchievementId(row) ~= nil
            or PatchCatalog.HasCollectionMapPayload
                and PatchCatalog:HasCollectionMapPayload(row.collectionType, row.patchKey, row.entry))
end

function CollectionExplorerWindow:TryDressUpCosmetic(row, button)
    if button ~= "LeftButton"
        or type(IsControlKeyDown) ~= "function"
        or not IsControlKeyDown()
        or type(DressUpItemLink) ~= "function" then
        return false
    end

    local itemLink = self:GetCosmeticItemLink(row)
    if not itemLink then
        return false
    end

    return pcall(DressUpItemLink, itemLink)
end

function CollectionExplorerWindow:OpenCollectionMap(row)
    local achievementId = self:GetCollectionMapAchievementId(row)
    if achievementId then
        return self:OpenCollectionSourceAchievement(row, achievementId)
    end
    if not self:IsCollectionMapRow(row) then
        Utils:Msg("No curated map location is available for this collection entry.", "warnings")
        return
    end

    if not TDP.collectionMapWindow and TDP.CollectionMapWindow then
        TDP.collectionMapWindow = TDP.CollectionMapWindow:New()
    end
    if not TDP.collectionMapWindow or not PatchCatalog or not PatchCatalog.GetCollectionMapPayload then
        Utils:Msg("Collection map is unavailable.", "warnings")
        return
    end

    local payload = PatchCatalog:GetCollectionMapPayload(row.collectionType, row.patchKey, row.entry, row.state)
    if not payload then
        Utils:Msg("No curated map location is available for this collection entry.", "warnings")
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
        Utils:Msg("Could not update favorite.", "warnings")
        return
    end

    Utils:Msg((isNowFavorite and "Added favorite: " or "Removed favorite: ") .. (row.name or "Unknown"), "collections")
    self:RefreshFavoritesWindow()
    self:Render()
end
