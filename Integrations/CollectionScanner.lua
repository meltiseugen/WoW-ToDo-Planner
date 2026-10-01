local _, TDP = ...

local PatchCatalog = TDP.PatchCatalog

local CollectionScanner = {}
CollectionScanner.__index = CollectionScanner

function CollectionScanner:New()
    return setmetatable({
        mountSpellIndex = nil,
        petSpeciesCounts = nil,
    }, self)
end

function CollectionScanner:ResetCache()
    self.mountSpellIndex = nil
    self.petSpeciesCounts = nil
end

function CollectionScanner:Call(func, ...)
    if type(func) ~= "function" then
        return false
    end

    return pcall(func, ...)
end

function CollectionScanner:GetMountSpellIndex()
    if self.mountSpellIndex then
        return self.mountSpellIndex
    end

    local index = {}
    if C_MountJournal and type(C_MountJournal.GetMountIDs) == "function" then
        local ok, mountIds = self:Call(C_MountJournal.GetMountIDs)
        if ok and type(mountIds) == "table" then
            for _, mountId in ipairs(mountIds) do
                local mountInfo = self:GetMountInfo(mountId)
                if mountInfo and mountInfo.spellId then
                    local modelId
                    if type(C_MountJournal.GetMountInfoExtraByID) == "function" then
                        local extraOk, creatureDisplayInfoID = self:Call(C_MountJournal.GetMountInfoExtraByID, mountId)
                        modelId = extraOk and creatureDisplayInfoID or nil
                    end

                    index[tonumber(mountInfo.spellId)] = {
                        mountId = mountId,
                        name = mountInfo.name,
                        icon = mountInfo.icon,
                        collected = mountInfo.collected == true,
                        modelId = modelId,
                    }
                end
            end
        end
    end

    self.mountSpellIndex = index
    return index
end

function CollectionScanner:GetMountInfo(mountId)
    if not mountId or not C_MountJournal or type(C_MountJournal.GetMountInfoByID) ~= "function" then
        return nil
    end

    local ok,
        name,
        spellId,
        icon,
        isActive,
        isUsable,
        sourceType,
        isFavorite,
        isFactionSpecific,
        faction,
        shouldHideOnChar,
        isCollected = self:Call(C_MountJournal.GetMountInfoByID, mountId)

    if not ok then
        return nil
    end

    return {
        name = name,
        spellId = spellId,
        icon = icon,
        isActive = isActive,
        isUsable = isUsable,
        sourceType = sourceType,
        isFavorite = isFavorite,
        isFactionSpecific = isFactionSpecific,
        faction = faction,
        shouldHideOnChar = shouldHideOnChar,
        collected = isCollected == true,
    }
end

function CollectionScanner:GetPetSpeciesCounts()
    if self.petSpeciesCounts then
        return self.petSpeciesCounts
    end

    local counts = {}
    if C_PetJournal and type(C_PetJournal.GetNumPets) == "function" and type(C_PetJournal.GetPetInfoByIndex) == "function" then
        local ok, total = self:Call(C_PetJournal.GetNumPets)
        if ok and type(total) == "number" then
            for index = 1, total do
                local infoOk, _, speciesId, isOwned, _, _, _, _, name, icon = self:Call(C_PetJournal.GetPetInfoByIndex, index)
                if infoOk and speciesId and isOwned then
                    speciesId = tonumber(speciesId)
                    counts[speciesId] = counts[speciesId] or {
                        count = 0,
                        name = name,
                        icon = icon,
                    }
                    counts[speciesId].count = counts[speciesId].count + 1
                    counts[speciesId].name = counts[speciesId].name or name
                    counts[speciesId].icon = counts[speciesId].icon or icon
                end
            end
        end
    end

    self.petSpeciesCounts = counts
    return counts
end

function CollectionScanner:GetMountState(entry)
    local spellId = entry and tonumber(entry.spellId)
    local indexed

    if spellId and C_MountJournal and type(C_MountJournal.GetMountFromSpell) == "function" then
        local ok, mountId = self:Call(C_MountJournal.GetMountFromSpell, spellId)
        if ok and mountId then
            local mountInfo = self:GetMountInfo(mountId)
            if mountInfo then
                local modelId
                if type(C_MountJournal.GetMountInfoExtraByID) == "function" then
                    local extraOk, creatureDisplayInfoID = self:Call(C_MountJournal.GetMountInfoExtraByID, mountId)
                    modelId = extraOk and creatureDisplayInfoID or nil
                end

                indexed = {
                    mountId = mountId,
                    name = mountInfo.name,
                    icon = mountInfo.icon,
                    collected = mountInfo.collected == true,
                    modelId = modelId,
                }
            end
        end
    end

    indexed = indexed or (spellId and self:GetMountSpellIndex()[spellId])

    if indexed then
        return {
            collected = indexed.collected == true,
            name = indexed.name or entry.name,
            icon = indexed.icon,
            modelId = indexed.modelId,
            linkType = "spell",
            linkId = spellId,
        }
    end

    local icon
    if entry and entry.itemId and C_Item and type(C_Item.GetItemIconByID) == "function" then
        local ok, itemIcon = self:Call(C_Item.GetItemIconByID, entry.itemId)
        icon = ok and itemIcon or nil
    end

    return {
        collected = false,
        unknown = true,
        name = entry and entry.name,
        icon = icon,
        linkType = spellId and "spell" or "item",
        linkId = spellId or (entry and entry.itemId),
    }
end

function CollectionScanner:GetPetState(entry)
    local speciesId = entry and tonumber(entry.speciesId)
    local speciesInfo = speciesId and self:GetPetSpeciesCounts()[speciesId]
    local fallbackName, fallbackIcon
    local fallbackDisplayId
    local directCount

    if C_PetJournal and type(C_PetJournal.GetPetInfoBySpeciesID) == "function" and speciesId then
        local ok, name, icon, _, _, _, _, _, _, _, _, _, displayId = self:Call(C_PetJournal.GetPetInfoBySpeciesID, speciesId)
        if ok then
            fallbackName = name
            fallbackIcon = icon
            fallbackDisplayId = displayId
        end
    end

    if C_PetJournal and type(C_PetJournal.GetNumCollectedInfo) == "function" and speciesId then
        local ok, numCollected = self:Call(C_PetJournal.GetNumCollectedInfo, speciesId)
        if ok and type(numCollected) == "number" then
            directCount = numCollected
        end
    end

    local count = directCount or (speciesInfo and speciesInfo.count) or 0
    return {
        collected = count > 0,
        count = count,
        name = (speciesInfo and speciesInfo.name) or fallbackName or (entry and entry.name),
        icon = (speciesInfo and speciesInfo.icon) or fallbackIcon,
        modelId = fallbackDisplayId,
        linkType = "battle-pet",
        linkId = speciesId,
    }
end

function CollectionScanner:GetToyState(entry)
    local itemId = entry and tonumber(entry.itemId)
    local collected = false
    local name = entry and entry.name
    local icon

    if itemId and type(PlayerHasToy) == "function" then
        local ok, hasToy = self:Call(PlayerHasToy, itemId)
        collected = ok and hasToy == true
    end

    if C_ToyBox and type(C_ToyBox.GetToyInfo) == "function" and itemId then
        local ok, itemIdFromToy, toyName, toyIcon = self:Call(C_ToyBox.GetToyInfo, itemId)
        if ok then
            name = toyName or name
            icon = toyIcon
            itemId = itemIdFromToy or itemId
        end
    elseif C_Item and type(C_Item.GetItemIconByID) == "function" and itemId then
        local ok, itemIcon = self:Call(C_Item.GetItemIconByID, itemId)
        icon = ok and itemIcon or nil
    end

    return {
        collected = collected,
        name = name,
        icon = icon,
        linkType = "item",
        linkId = itemId,
    }
end

function CollectionScanner:GetItemNameAndIcon(entry)
    local itemId = entry and tonumber(entry.itemId)
    local name = entry and entry.name
    local icon

    if itemId and C_Item then
        if type(C_Item.GetItemNameByID) == "function" then
            local ok, itemName = self:Call(C_Item.GetItemNameByID, itemId)
            if ok then
                name = itemName or name
            end
        end
        if type(C_Item.GetItemIconByID) == "function" then
            local ok, itemIcon = self:Call(C_Item.GetItemIconByID, itemId)
            if ok then
                icon = itemIcon
            end
        end
        if (not name or not icon) and type(C_Item.RequestLoadItemDataByID) == "function" then
            self:Call(C_Item.RequestLoadItemDataByID, itemId)
        end
    end

    if itemId and type(GetItemInfo) == "function" and (not name or not icon) then
        local ok, itemName, _, _, _, _, _, _, _, _, itemIcon = self:Call(GetItemInfo, itemId)
        if ok then
            name = itemName or name
            icon = itemIcon or icon
        end
    end

    return name, icon
end

function CollectionScanner:GetCosmeticSetState(entry, name, icon)
    local itemId = entry and tonumber(entry.itemId)
    local setId = entry and tonumber(entry.transmogSetId)
    if not setId and itemId and C_Item and type(C_Item.GetItemLearnTransmogSet) == "function" then
        local ok, learnedSetId = self:Call(C_Item.GetItemLearnTransmogSet, itemId)
        if ok then
            setId = tonumber(learnedSetId)
        end
    end

    local sourceIds
    if setId and C_TransmogSets and type(C_TransmogSets.GetAllSourceIDs) == "function" then
        local ok, returnedSourceIds = self:Call(C_TransmogSets.GetAllSourceIDs, setId)
        if ok and type(returnedSourceIds) == "table" then
            sourceIds = returnedSourceIds
        end
    end

    local collectedCount = 0
    local totalCount = 0
    local appearanceStates = {}
    if sourceIds then
        for _, sourceId in ipairs(sourceIds) do
            local appearanceId = tonumber(sourceId) or tostring(sourceId)
            local isCollected = false
            if C_TransmogCollection and type(C_TransmogCollection.GetAppearanceInfoBySource) == "function" then
                local ok, appearanceInfo = self:Call(C_TransmogCollection.GetAppearanceInfoBySource, sourceId)
                if ok and type(appearanceInfo) == "table" then
                    appearanceId = tonumber(appearanceInfo.appearanceID) or appearanceId
                    isCollected = appearanceInfo.appearanceIsCollected == true or appearanceInfo.isCollected == true
                end
            end
            if not isCollected and C_TransmogCollection and type(C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance) == "function" then
                local ok, hasAppearance = self:Call(C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance, sourceId)
                isCollected = ok and hasAppearance == true
            end

            appearanceStates[appearanceId] = appearanceStates[appearanceId] == true or isCollected
        end
    end

    for _, isCollected in pairs(appearanceStates) do
        totalCount = totalCount + 1
        if isCollected then
            collectedCount = collectedCount + 1
        end
    end

    local collected = totalCount > 0 and collectedCount == totalCount
    local unknown = totalCount == 0
    if unknown and setId and C_TransmogSets and type(C_TransmogSets.GetSetInfo) == "function" then
        local ok, setInfo = self:Call(C_TransmogSets.GetSetInfo, setId)
        if ok and type(setInfo) == "table" and type(setInfo.collected) == "boolean" then
            collected = setInfo.collected
            unknown = false
        end
    end

    return {
        collected = collected,
        unknown = unknown,
        name = name,
        icon = icon,
        setId = setId,
        collectedCount = collectedCount,
        totalCount = totalCount,
        linkType = "item",
        linkId = itemId,
    }
end

function CollectionScanner:GetCosmeticState(entry)
    local itemId = entry and tonumber(entry.itemId)
    local subtype = entry and entry.subtype or "appearance"
    local name, icon = self:GetItemNameAndIcon(entry)

    if subtype == "ensemble" or subtype == "arsenal" then
        return self:GetCosmeticSetState(entry, name, icon)
    elseif subtype == "illusion" then
        local illusionId = entry and tonumber(entry.illusionId)
        local collected = false
        local unknown = true
        if illusionId and C_TransmogCollection and type(C_TransmogCollection.GetIllusionInfo) == "function" then
            local ok, visualId, sourceId, illusionIcon, isCollected, illusionName = self:Call(C_TransmogCollection.GetIllusionInfo, illusionId)
            if ok then
                if type(visualId) == "table" then
                    local info = visualId
                    icon = info.icon or icon
                    name = info.name or name
                    collected = info.isCollected == true
                    unknown = type(info.isCollected) ~= "boolean"
                else
                    icon = illusionIcon or icon
                    name = illusionName or name
                    collected = isCollected == true
                    unknown = type(isCollected) ~= "boolean"
                end
            end
        end
        return {
            collected = collected,
            unknown = unknown,
            name = name,
            icon = icon,
            illusionId = illusionId,
            linkType = "item",
            linkId = itemId,
        }
    elseif subtype == "effect" then
        local questId = entry and tonumber(entry.questId)
        local collected = false
        local unknown = true
        if questId and C_QuestLog then
            if type(C_QuestLog.IsQuestFlaggedCompletedOnAccount) == "function" then
                local ok, isCompleted = self:Call(C_QuestLog.IsQuestFlaggedCompletedOnAccount, questId)
                if ok then
                    collected = isCompleted == true
                    unknown = false
                end
            end
            if not collected and type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
                local ok, isCompleted = self:Call(C_QuestLog.IsQuestFlaggedCompleted, questId)
                if ok then
                    collected = isCompleted == true
                    unknown = false
                end
            end
        end
        return {
            collected = collected,
            unknown = unknown,
            name = name,
            icon = icon,
            linkType = "item",
            linkId = itemId,
        }
    end

    local collected = false
    local unknown = true
    if itemId and C_TransmogCollection and type(C_TransmogCollection.PlayerHasTransmogByItemInfo) == "function" then
        local ok, hasAppearance = self:Call(C_TransmogCollection.PlayerHasTransmogByItemInfo, itemId)
        if ok then
            collected = hasAppearance == true
            unknown = false
        end
    end

    return {
        collected = collected,
        unknown = unknown,
        name = name,
        icon = icon,
        linkType = "item",
        linkId = itemId,
    }
end

function CollectionScanner:GetAchievementState(achievementId)
    achievementId = tonumber(achievementId)
    local name
    local icon
    local completed = false
    local rewardText
    local categoryId
    local categoryName
    local parentCategoryName
    local achievementDescription
    local criteria = {}

    if achievementId then
        local ok,
            returnedAchievementId,
            achievementName,
            points,
            isCompleted,
            month,
            day,
            year,
            description,
            flags,
            achievementIcon,
            apiRewardText,
            isGuild,
            wasEarnedByMe,
            earnedBy =
            self:Call(GetAchievementInfo, achievementId)
        if ok then
            name = achievementName
            icon = achievementIcon
            achievementDescription = description
            completed = isCompleted == true
                or wasEarnedByMe == true
                or (type(earnedBy) == "string" and earnedBy ~= "")
        end

        if type(GetAchievementCategory) == "function" then
            local categoryOk, returnedCategoryId = self:Call(GetAchievementCategory, achievementId)
            if categoryOk then
                categoryId = returnedCategoryId
            end
        end

        if categoryId and type(GetCategoryInfo) == "function" then
            local categoryOk, returnedCategoryName, parentCategoryId = self:Call(GetCategoryInfo, categoryId)
            if categoryOk then
                categoryName = returnedCategoryName
                if parentCategoryId then
                    local parentOk, returnedParentCategoryName = self:Call(GetCategoryInfo, parentCategoryId)
                    if parentOk then
                        parentCategoryName = returnedParentCategoryName
                    end
                end
            end
        end

        local rewardOk, reward = self:Call(GetAchievementReward, achievementId)
        if rewardOk then
            rewardText = reward
        end

        if type(GetAchievementNumCriteria) == "function" and type(GetAchievementCriteriaInfo) == "function" then
            local countOk, criteriaCount = self:Call(GetAchievementNumCriteria, achievementId)
            if countOk then
                for criteriaIndex = 1, tonumber(criteriaCount) or 0 do
                    local criteriaOk,
                        criteriaText,
                        criteriaType,
                        criteriaCompleted,
                        quantity,
                        requiredQuantity,
                        characterName,
                        criteriaFlags,
                        assetId,
                        quantityText = self:Call(GetAchievementCriteriaInfo, achievementId, criteriaIndex)
                    if criteriaOk and type(criteriaText) == "string" and criteriaText ~= "" then
                        criteria[#criteria + 1] = {
                            index = criteriaIndex,
                            assetId = tonumber(assetId) or assetId,
                            text = criteriaText,
                            completed = criteriaCompleted == true,
                            quantity = tonumber(quantity),
                            requiredQuantity = tonumber(requiredQuantity),
                            quantityText = quantityText,
                        }
                    end
                end
            end
        end
    end

    return {
        collected = completed,
        name = name,
        icon = icon,
        categoryId = categoryId,
        categoryName = categoryName,
        parentCategoryName = parentCategoryName,
        description = achievementDescription,
        criteria = criteria,
        reward = rewardText,
        linkType = "achievement",
        linkId = achievementId,
    }
end

function CollectionScanner:GetState(collectionType, entry)
    if collectionType == "mounts" then
        return self:GetMountState(entry)
    elseif collectionType == "pets" then
        return self:GetPetState(entry)
    elseif collectionType == "toys" then
        return self:GetToyState(entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticState(entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementState(entry)
    end

    return {}
end

function CollectionScanner:GetEntryKey(collectionType, entry)
    if collectionType == "mounts" then
        return entry and (entry.spellId or entry.itemId)
    elseif collectionType == "pets" then
        return entry and entry.speciesId
    elseif collectionType == "toys" then
        return entry and entry.itemId
    elseif collectionType == "cosmetics" then
        return entry and entry.itemId
    elseif collectionType == "achievements" then
        return type(entry) == "table" and entry.achievementId or entry
    end

    return nil
end

function CollectionScanner:GetDisplayName(collectionType, entry, state, patchKey)
    if state and state.name then
        return state.name
    end

    if type(entry) == "table" and entry.name then
        return entry.name
    end

    if collectionType == "achievements" then
        local reward = PatchCatalog and PatchCatalog:GetAchievementReward(patchKey, entry)
        if reward and reward.name then
            return reward.name
        end
        return "Achievement #" .. tostring(entry)
    end

    return "Unknown"
end

TDP.CollectionScanner = CollectionScanner:New()
