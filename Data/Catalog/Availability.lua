local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local availability = PatchCatalog.collectionAvailability

local ID_FIELDS = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }

function PatchCatalog:GetCollectionAvailability(collectionType, patchKey, entry)
    local field = ID_FIELDS[collectionType]
    local id = field and type(entry) == "table" and tonumber(entry[field])
    return id and availability[collectionType][id] or nil
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
