local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local MAP_NAMES = TDP.CatalogMapNames
local LOCATION_ID_FIELDS = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId", achievements = "achievementId" }

function PatchCatalog:GetDescriptionMapLocations(collectionType, entry)
    local field = LOCATION_ID_FIELDS[collectionType]
    local id = field and (type(entry) == "table" and entry[field] or collectionType == "achievements" and entry)
    local locations = TDP.CollectionDescriptionLocations and TDP.CollectionDescriptionLocations[collectionType]
    return locations and locations[tonumber(id)] or nil
end

function PatchCatalog:ParseWaypoint(waypoint)
    if type(waypoint) == "table" then
        local mapID = tonumber(waypoint.mapID or waypoint.uiMapID)
        local x = tonumber(waypoint.x)
        local y = tonumber(waypoint.y)
        if not mapID or not x or not y then
            return nil
        end
        if x > 1 or y > 1 then
            x = x / 100
            y = y / 100
        end
        return {
            mapID = mapID,
            mapName = waypoint.mapName or waypoint.uiMapName,
            x = x,
            y = y,
            label = waypoint.label,
            waypoint = waypoint.waypoint,
        }
    end

    if type(waypoint) ~= "string" then
        return nil
    end

    local mapID, x, y, label = waypoint:match("^%s*/way%s+#(%d+)%s+([%d%.]+)%s+([%d%.]+)%s*(.-)%s*$")
    if not mapID then
        return nil
    end

    x = tonumber(x)
    y = tonumber(y)
    if not x or not y then
        return nil
    end

    return {
        mapID = tonumber(mapID),
        mapName = MAP_NAMES[tonumber(mapID)],
        x = x / 100,
        y = y / 100,
        label = label ~= "" and label or nil,
        waypoint = waypoint,
    }
end

function PatchCatalog:GetCollectionMapPayload(collectionType, patchKey, entry, state)
    if collectionType ~= "mounts" and collectionType ~= "pets" and collectionType ~= "toys" and collectionType ~= "cosmetics" and collectionType ~= "achievements" then
        return nil
    end
    local sourceInfo = self.GetCollectionSourceInfo and self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    local recordedLocations = self:GetDescriptionMapLocations(collectionType, entry)
    local sourceWaypoints = sourceInfo and self:UseCollectionSourceWaypoints(collectionType, patchKey, entry, sourceInfo) and sourceInfo.waypoints
    if not sourceWaypoints and not recordedLocations and self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then
        return nil
    end

    local sourceSummary = self:GetCollectionSourceSummary(collectionType, patchKey, entry)
    local acquisition = self:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    local effect = self:GetCollectionUseText(collectionType, patchKey, entry)
    local tips = self:GetCollectionTips(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    local waypoints = sourceWaypoints or self:GetCollectionWaypoints(collectionType, patchKey, entry)
    local pins = {}

    local entryDetails = type(entry) == "table" and entry or {}
    details = type(details) == "table" and details or {}
    local requirements = entryDetails.requirements or details.requirements
    local cost = entryDetails.cost or details.cost
    local notes = entryDetails.notes or details.notes

    if type(waypoints) == "table" then
        for waypointIndex, waypoint in ipairs(waypoints) do
            local pin = self:ParseWaypoint(waypoint)
            if pin then
                pin.icon = state and state.icon
                pin.source = sourceSummary
                pin.acquisition = acquisition
                pin.effect = effect
                pin.tips = tips
                local waypointInfo = type(waypoint) == "table" and waypoint or {}
                pin.questID, pin.npcID, pin.locationType = waypointInfo.questID, waypointInfo.npcID, waypointInfo.locationType
                if not sourceWaypoints and type(details.waypointCriteria) == "table" then
                    local criterionMapping = details.waypointCriteria[waypointIndex]
                    if type(criterionMapping) == "table" then
                        pin.criterionIndex = tonumber(criterionMapping.criterionIndex or criterionMapping.index)
                        pin.criterionAchievementId = tonumber(criterionMapping.achievementId)
                    else
                        pin.criterionIndex = tonumber(criterionMapping)
                    end
                end
                pins[#pins + 1] = pin
            end
        end
    end

    local sourceAreas = sourceInfo and sourceInfo.areaOnly and sourceInfo.areaMaps
        or recordedLocations and recordedLocations.areaMaps
    local areaOnly = #pins == 0 and type(sourceAreas) == "table" and #sourceAreas > 0
    if #pins == 0 and not areaOnly then
        return nil
    end

    local entryID = entry
    if type(entry) == "table" then
        if collectionType == "mounts" then
            entryID = entry.spellId or entry.itemId
        elseif collectionType == "pets" then
            entryID = entry.speciesId
        elseif collectionType == "achievements" then
            entryID = entry.achievementId
        else
            entryID = entry.itemId
        end
    end

    return {
        projectionKey = entryID and (collectionType .. ":" .. tostring(entryID)) or nil,
        title = (type(entry) == "table" and entry.name) or (state and state.name) or nil,
        collectionType = collectionType,
        sourceSummary = sourceSummary,
        acquisition = acquisition,
        effect = effect,
        tips = tips,
        requirements = requirements,
        cost = cost or (self.GetCollectionSourceCost and self:GetCollectionSourceCost(collectionType, patchKey, entry)),
        costs = details.costs,
        availability = entryDetails.availability or details.availability,
        notes = notes,
        researchNotes = entryDetails.researchNotes or details.researchNotes,
        description = state and state.description,
        criteria = state and state.criteria,
        mapAchievementId = not sourceWaypoints and tonumber(details.mapAchievementId) or nil,
        waypoints = waypoints,
        pins = pins,
        mapID = pins[1] and pins[1].mapID or areaOnly and sourceAreas[1] or nil,
        areaOnly = areaOnly or nil,
        sourceAreaMaps = areaOnly and sourceAreas or nil,
        icon = state and state.icon,
        sourceQuestID = sourceInfo and sourceInfo.questID,
        sourcePatchKey = sourceInfo and (sourceWaypoints or areaOnly) and patchKey or nil,
        sourceEntry = sourceInfo and (sourceWaypoints or areaOnly) and entry or nil,
        sourceNotes = sourceInfo and table.concat(self:GetCollectionSourceNotes(collectionType, patchKey, entry), "\n")
            or recordedLocations and recordedLocations.historical and "Original recorded acquisition location; the source is historical." or nil,
    }
end

function PatchCatalog:HasCollectionMapPayload(collectionType, patchKey, entry)
    if collectionType ~= "mounts" and collectionType ~= "pets" and collectionType ~= "toys"
        and collectionType ~= "cosmetics" and collectionType ~= "achievements" then return false end
    local info = self.GetCollectionSourceInfo and self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    local recordedLocations = self:GetDescriptionMapLocations(collectionType, entry)
    local sourceWaypoints = info and self:UseCollectionSourceWaypoints(collectionType, patchKey, entry, info)
    if not sourceWaypoints and not recordedLocations and self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then return false end
    local waypoints = sourceWaypoints and info.waypoints or self:GetCollectionWaypoints(collectionType, patchKey, entry)
    for _, point in ipairs(waypoints or {}) do
        if type(point) == "table" then
            if tonumber(point.mapID or point.uiMapID) and tonumber(point.x) and tonumber(point.y) then return true end
        elseif type(point) == "string" then
            local map, x, y = point:match("^%s*/way%s+#(%d+)%s+([%d%.]+)%s+([%d%.]+)%s*.-%s*$")
            if map and tonumber(x) and tonumber(y) then return true end
        end
    end
    return info ~= nil and info.areaOnly == true and tonumber(info.areaMaps[1]) ~= nil
        or recordedLocations ~= nil and type(recordedLocations.areaMaps) == "table" and tonumber(recordedLocations.areaMaps[1]) ~= nil
end

function PatchCatalog:GetWowheadUrl(collectionType, entry)
    if collectionType == "mounts" and entry and entry.spellId then
        return "https://www.wowhead.com/spell=" .. tostring(entry.spellId)
    elseif collectionType == "pets" and entry and entry.speciesId then
        return "https://www.wowhead.com/battle-pet=" .. tostring(entry.speciesId)
    elseif (collectionType == "toys" or collectionType == "cosmetics") and entry and entry.itemId then
        return "https://www.wowhead.com/item=" .. tostring(entry.itemId)
    elseif collectionType == "achievements" and entry then
        local achievementId = type(entry) == "table" and entry.achievementId or entry
        return "https://www.wowhead.com/achievement=" .. tostring(achievementId)
    end

    return nil
end
