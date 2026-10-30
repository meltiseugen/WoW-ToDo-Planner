local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local availability = PatchCatalog.collectionAvailability

local ID_FIELDS = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }

function PatchCatalog:GetCollectionAvailability(collectionType, patchKey, entry)
    local field = ID_FIELDS[collectionType]
    local id = field and type(entry) == "table" and tonumber(entry[field])
    local known = id and availability[collectionType][id]
    if known then return known end
    local index = TDP.CollectionSourceIndex
    for _, source in ipairs(id and index and index[collectionType] and index[collectionType][id] or {}) do
        if source.availability then return source.availability end
    end
    return nil
end

function PatchCatalog:HasOriginalCollectionUnlock(record)
    if not record then
        return false
    end
    if type(GetAchievementInfo) == "function" then
        for _, id in ipairs(record.achievementIds or {}) do
            local ok, _, _, _, completed, _, _, _, _, _, _, _, _, earnedByMe = pcall(GetAchievementInfo, id)
            if ok and (record.characterOnly and earnedByMe == true or not record.characterOnly and completed == true) then
                return true
            end
        end
    end
    if C_QuestLog and type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
        for _, id in ipairs(record.questIds or {}) do
            local ok, completed = pcall(C_QuestLog.IsQuestFlaggedCompleted, id)
            if ok and completed == true then
                return true
            end
        end
    end
    return false
end

function PatchCatalog:IsCollectionUnobtainable(collectionType, patchKey, entry)
    local record = self:GetCollectionAvailability(collectionType, patchKey, entry)
    return record ~= nil and not self:HasOriginalCollectionUnlock(record)
end

function PatchCatalog:IsCollectionHiddenInUI(collectionType, patchKey, entry)
    local field = ID_FIELDS[collectionType]
    local id = collectionType == "achievements"
        and (type(entry) == "table" and entry.achievementId or entry)
        or field and type(entry) == "table" and entry[field]
    local excluded = TDP.CollectionUIExclusions and TDP.CollectionUIExclusions[collectionType]
    if excluded and excluded[tonumber(id)] then return true end
    -- Every collection view uses the same availability decision as its status.
    -- Ownership does not restore an ended source; original purchase unlocks can.
    -- Keep the catalog and saved favorites intact.
    return self:IsCollectionUnobtainable(collectionType, patchKey, entry)
end
