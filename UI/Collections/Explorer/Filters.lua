local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local PatchCatalog = TDP.PatchCatalog
local STATUS_OPTIONS = CollectionExplorerWindow.Config.STATUS_OPTIONS
local EXPANSION_LABELS = CollectionExplorerWindow.Config.EXPANSION_LABELS
local ALL_PATCHES = CollectionExplorerWindow.Config.ALL_PATCHES
local MOUNT_CATEGORY_OPTIONS = CollectionExplorerWindow.Config.MOUNT_CATEGORY_OPTIONS
local FACTION_BADGE_COLORS = CollectionExplorerWindow.Config.FACTION_BADGE_COLORS
local TYPE_LABELS = CollectionExplorerWindow.Config.TYPE_LABELS

function CollectionExplorerWindow:GetPatchOptions()
    local options = { ALL_PATCHES }
    if not PatchCatalog then
        options[#options + 1] = "12.1.5"
        return options
    end

    for _, patchKey in ipairs(PatchCatalog:GetPatchKeys()) do
        if self:GetExpansionForPatch(patchKey) == self.selectedExpansion then
            options[#options + 1] = patchKey
        end
    end
    return options
end

function CollectionExplorerWindow:GetExpansionForPatch(patchKey)
    return tostring(patchKey or ""):match("^(%d+)")
end

function CollectionExplorerWindow:GetExpansionLabel(value)
    return EXPANSION_LABELS[value] or tostring(value)
end

function CollectionExplorerWindow:GetPatchLabel(value)
    return value == ALL_PATCHES and "All Patches" or tostring(value)
end

function CollectionExplorerWindow:GetSelectedPatchKeys()
    if self.nearbySnapshot then
        return self.nearbySnapshot.patchKeys
    end
    if self.selectedPatch ~= ALL_PATCHES
        and self:GetExpansionForPatch(self.selectedPatch) == self.selectedExpansion then
        return { self.selectedPatch }
    end

    local patchKeys = {}
    for _, patchKey in ipairs(self:GetPatchOptions()) do
        if patchKey ~= ALL_PATCHES then
            patchKeys[#patchKeys + 1] = patchKey
        end
    end
    return patchKeys
end

function CollectionExplorerWindow:GetEntriesForView(patchKey, collectionType)
    local entries
    if self.nearbySnapshot then
        local patchEntries = self.nearbySnapshot.entries[patchKey]
        entries = patchEntries and patchEntries[collectionType] or {}
    else
        entries = PatchCatalog:GetEntries(patchKey, collectionType)
    end
    local visible = {}
    for _, entry in ipairs(entries) do
        if not PatchCatalog:IsCollectionHiddenInUI(collectionType, patchKey, entry) then
            visible[#visible + 1] = entry
        end
    end
    entries = visible
    if self.nearbySnapshot then return entries end
    local linked = self.linkedAchievement
    if linked and linked.patchKey == patchKey and collectionType == "achievements" then
        if PatchCatalog:IsCollectionHiddenInUI(collectionType, patchKey, linked.id) then return entries end
        for _, id in ipairs(entries) do
            if tonumber(id) == linked.id then return entries end
        end
        -- A linked reward may precede its catalog entry; keep it local to this window.
        local withLinked = {}
        for _, id in ipairs(entries) do withLinked[#withLinked + 1] = id end
        withLinked[#withLinked + 1] = linked.id
        return withLinked
    end
    return entries
end

function CollectionExplorerWindow:SetSelectedExpansion(expansionKey)
    if not EXPANSION_LABELS[expansionKey] then
        return false
    end

    self.selectedExpansion = expansionKey
    if self:GetExpansionForPatch(self.selectedPatch) ~= expansionKey then
        self.selectedPatch = ALL_PATCHES
    end
    return true
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

function CollectionExplorerWindow:GetRowStatusLabel(row)
    if row.unobtainable then
        return row.collected and "Collected - Unobtainable" or "Unobtainable"
    end
    return row.collected and "Collected" or "Missing"
end

function CollectionExplorerWindow:GetStatusOptions()
    return STATUS_OPTIONS
end

function CollectionExplorerWindow:SetSelectedStatus(value)
    local valid = false
    for _, option in ipairs(STATUS_OPTIONS) do
        if value == option then
            valid = true
            break
        end
    end
    if not valid then
        return false
    end
    self.selectedStatus = value
    if TODOPlannerDB and TODOPlannerDB.settings then
        TODOPlannerDB.settings.collectionHideCollected = value == "missing"
        TODOPlannerDB.settings.collectionStatusFilter = value
    end
    self.selectedRow = nil
    self:Render()
    return true
end

function CollectionExplorerWindow:GetFactionLabel(value)
    if value == "alliance" then
        return "Alliance"
    elseif value == "horde" then
        return "Horde"
    end
    return "All"
end

function CollectionExplorerWindow:GetFactionBadgeColor(value)
    return FACTION_BADGE_COLORS[value]
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
