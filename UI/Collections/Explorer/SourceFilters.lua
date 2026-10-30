local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local SOURCE_CATEGORY_OPTIONS = CollectionExplorerWindow.Config.SOURCE_CATEGORY_OPTIONS

local SOURCE_TYPES = { mounts = true, pets = true, toys = true, cosmetics = true }

function CollectionExplorerWindow:HasSourceFilter(collectionType)
    return SOURCE_TYPES[collectionType or self.selectedCollectionType] == true
end

function CollectionExplorerWindow:GetSourceOptions()
    return self.selectedCollectionType == "mounts" and self.Config.MOUNT_CATEGORY_OPTIONS or SOURCE_CATEGORY_OPTIONS
end

function CollectionExplorerWindow:GetSourceFilters()
    if self.selectedCollectionType == "mounts" then
        return self:GetMountSourceFilters()
    end
    if not self:HasSourceFilter() then
        return {}
    end
    local settings = TODOPlannerDB and TODOPlannerDB.settings
    if not settings then
        return {}
    end
    if type(settings.collectionSourceFilters) ~= "table" then
        settings.collectionSourceFilters = {}
    end
    local filters = settings.collectionSourceFilters
    if type(filters[self.selectedCollectionType]) ~= "table" then
        filters[self.selectedCollectionType] = {}
    end
    return filters[self.selectedCollectionType]
end

function CollectionExplorerWindow:GetSourceSelectionSummary()
    local filters = self:GetSourceFilters()
    local count, onlyCategory = 0, nil
    for _, category in ipairs(self:GetSourceOptions()) do
        if category ~= "all" and filters[category] == true then
            count, onlyCategory = count + 1, category
        end
    end
    if count == 0 then return "All" end
    return count == 1 and onlyCategory or tostring(count) .. " selected"
end

function CollectionExplorerWindow:IsSourceChecked(category)
    if category == "all" then
        return self:GetSourceSelectionSummary() == "All"
    end
    return self:GetSourceFilters()[category] == true
end

function CollectionExplorerWindow:GetSourceCategoryLabel(category)
    return category == "all" and "All Sources" or category
end

function CollectionExplorerWindow:ToggleSource(category, checked)
    if not TDP.Utils:IndexOf(self:GetSourceOptions(), category) then return end
    local filters = self:GetSourceFilters()
    if category == "all" then
        for key in pairs(filters) do filters[key] = nil end
    else
        filters[category] = checked == true or nil
    end
    self.selectedRow = nil
    self:Render()
end

function CollectionExplorerWindow:SourceCategoryMatchesFilter(collectionType, category)
    if self.selectedCollectionType ~= collectionType or not self:HasSourceFilter(collectionType) then
        return true
    end
    if collectionType == "mounts" then
        return self:MountCategoryMatchesFilter(category)
    end
    return self:IsSourceChecked("all") or self:IsSourceChecked(category)
end

