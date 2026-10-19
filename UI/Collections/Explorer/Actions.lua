local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Utils = TDP.Utils
local PatchCatalog = TDP.PatchCatalog
local Favorites = TDP.Favorites

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

function CollectionExplorerWindow:GetCosmeticItemLink(row)
    if not row or row.collectionType ~= "cosmetics" then
        return nil
    end

    local itemId = type(row.entry) == "table" and tonumber(row.entry.itemId) or nil
    if not itemId then
        return nil
    end

    if C_Item and type(C_Item.GetItemLinkByID) == "function" then
        local ok, itemLink = pcall(C_Item.GetItemLinkByID, itemId)
        if ok and itemLink then
            return itemLink
        end
    end

    if type(GetItemInfo) == "function" then
        local ok, _, itemLink = pcall(GetItemInfo, itemId)
        if ok and itemLink then
            return itemLink
        end
    end

    return "item:" .. tostring(itemId)
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
