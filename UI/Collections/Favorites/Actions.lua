local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Utils = TDP.Utils
local Tasks = TDP.Tasks
local PatchCatalog = TDP.PatchCatalog
local Favorites = TDP.Favorites
local CATEGORY_BY_TYPE = FavoritesWindow.Config.CATEGORY_BY_TYPE

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

function FavoritesWindow:CreateTask(row)
    if not row or row.collected or self:FindTask(row) then
        return false
    end

    local task = Tasks:CreateOnSelectedBoard({
        title = row.name,
        notes = self:GetRowNotes(row),
        category = CATEGORY_BY_TYPE[row.collectionType] or "Collections",
        status = "TODO",
        sourceType = self:GetSourceType(row.collectionType),
        sourceId = self:GetSourceId(row),
    })
    if TDP.CollectionTaskProgress and TDP.CollectionTaskProgress:AutoCompleteTask(task) then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end

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
