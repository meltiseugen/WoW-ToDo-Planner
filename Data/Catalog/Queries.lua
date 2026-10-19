local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

function PatchCatalog:GetPatch(patchKey)
    return self.patches[patchKey]
end

function PatchCatalog:GetPatchKeys()
    local keys = {}
    for patchKey in pairs(self.patches) do
        keys[#keys + 1] = patchKey
    end
    table.sort(keys, function(left, right)
        local leftParts = {}
        local rightParts = {}
        for value in tostring(left):gmatch("%d+") do
            leftParts[#leftParts + 1] = tonumber(value) or 0
        end
        for value in tostring(right):gmatch("%d+") do
            rightParts[#rightParts + 1] = tonumber(value) or 0
        end
        if #leftParts == 0 or #rightParts == 0 then
            if #leftParts == #rightParts then
                return tostring(left) < tostring(right)
            end
            return #leftParts > 0
        end
        local partCount = math.max(#leftParts, #rightParts)
        for index = 1, partCount do
            local leftValue = leftParts[index] or 0
            local rightValue = rightParts[index] or 0
            if leftValue ~= rightValue then
                return leftValue < rightValue
            end
        end
        return tostring(left) < tostring(right)
    end)
    return keys
end

function PatchCatalog:GetEntries(patchKey, collectionType)
    local patch = self:GetPatch(patchKey)
    if not patch then
        return {}
    end

    if collectionType == "achievements" then
        return patch.achievements and patch.achievements.ids or {}
    end

    return patch[collectionType] or {}
end

function PatchCatalog:GetCount(patchKey, collectionType)
    return #self:GetEntries(patchKey, collectionType)
end

function PatchCatalog:GetSummary(patchKey)
    return {
        mounts = self:GetCount(patchKey, "mounts"),
        pets = self:GetCount(patchKey, "pets"),
        toys = self:GetCount(patchKey, "toys"),
        cosmetics = self:GetCount(patchKey, "cosmetics"),
        achievements = self:GetCount(patchKey, "achievements"),
    }
end

function PatchCatalog:GetAchievementReward(patchKey, achievementId)
    local patch = self:GetPatch(patchKey)
    local highlights = patch and patch.achievements and patch.achievements.rewardHighlights
    if not highlights then
        return nil
    end

    achievementId = tonumber(achievementId)
    for _, entry in ipairs(highlights) do
        if entry.achievementId == achievementId then
            return entry
        end
    end

    return nil
end

function PatchCatalog:GetAchievementCategory(patchKey, achievementId)
    local categories = self.achievementCategories and self.achievementCategories[patchKey]
    if type(achievementId) == "table" then
        achievementId = achievementId.achievementId
    end
    achievementId = tonumber(achievementId)
    return categories and categories[achievementId] or nil
end

function PatchCatalog:GetAchievementDetails(patchKey, entry)
    local detailsById = self.achievementDetails and self.achievementDetails[patchKey]
    if not detailsById then
        return nil
    end

    local achievementId = type(entry) == "table" and entry.achievementId or entry
    achievementId = tonumber(achievementId)
    return achievementId and detailsById[achievementId] or nil
end

function PatchCatalog:GetDetailsByName(detailsTable, patchKey, entry)
    if type(entry) ~= "table" then
        return nil
    end

    local detailsByName = detailsTable and detailsTable[patchKey]
    return detailsByName and detailsByName[entry.name] or nil
end

function PatchCatalog:GetPetDetails(patchKey, entry)
    return self:GetDetailsByName(self.petDetails, patchKey, entry)
end

function PatchCatalog:GetToyDetails(patchKey, entry)
    return self:GetDetailsByName(self.toyDetails, patchKey, entry)
end

function PatchCatalog:GetCosmeticDetails(patchKey, entry)
    local details = self:GetDetailsByName(self.cosmeticDetails, patchKey, entry)
    if details or type(entry) ~= "table" then
        return details
    end

    local patch = self:GetPatch(patchKey)
    local detailGroups = patch and patch.cosmeticDetailGroups
    return detailGroups and detailGroups[entry.detailKey] or nil
end

function PatchCatalog:GetSourceSummary(details)
    if not details then
        return nil
    end

    if details.sourceType and details.source then
        return details.sourceType .. ": " .. details.source
    end
    return details.source or details.sourceType
end

function PatchCatalog:GetPetSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetPetDetails(patchKey, entry))
end

function PatchCatalog:GetPetAcquisitionText(patchKey, entry)
    local details = self:GetPetDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetPetWaypoints(patchKey, entry)
    local details = self:GetPetDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetToySourceSummary(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return self:GetSourceSummary(details) or (entry and entry.source)
end

function PatchCatalog:GetToyAcquisitionText(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.acquisition or (entry and entry.acquisition)
end

function PatchCatalog:GetToyUseText(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.effect or nil
end

function PatchCatalog:GetToyWaypoints(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetCosmeticSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetCosmeticDetails(patchKey, entry))
end

function PatchCatalog:GetCosmeticAcquisitionText(patchKey, entry)
    local details = self:GetCosmeticDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetCosmeticWaypoints(patchKey, entry)
    local details = self:GetCosmeticDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetAchievementSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetAchievementDetails(patchKey, entry))
end

function PatchCatalog:GetAchievementAcquisitionText(patchKey, entry)
    local details = self:GetAchievementDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetAchievementWaypoints(patchKey, entry)
    local details = self:GetAchievementDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetMountDetails(patchKey, entry)
    return self:GetDetailsByName(self.mountDetails, patchKey, entry)
end

function PatchCatalog:GetMountCategory(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    if details and details.category then
        return details.category
    end
    return "Other"
end

function PatchCatalog:GetMountSourceSummary(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return self:GetSourceSummary(details)
end

function PatchCatalog:GetMountAcquisitionText(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetMountWaypoints(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetCollectionSourceSummary(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountSourceSummary(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetSourceSummary(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToySourceSummary(patchKey, entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticSourceSummary(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementSourceSummary(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountAcquisitionText(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetAcquisitionText(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyAcquisitionText(patchKey, entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticAcquisitionText(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementAcquisitionText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionUseText(collectionType, patchKey, entry)
    if collectionType == "toys" then
        return self:GetToyUseText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionTips(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    return details and details.tips or nil
end

function PatchCatalog:GetCollectionWaypoints(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountWaypoints(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetWaypoints(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyWaypoints(patchKey, entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticWaypoints(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementWaypoints(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionDetails(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountDetails(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetDetails(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyDetails(patchKey, entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticDetails(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementDetails(patchKey, entry)
    end
    return nil
end

