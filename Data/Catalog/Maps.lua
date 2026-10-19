local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local MAP_NAMES = TDP.CatalogMapNames

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
    if self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then
        return nil
    end

    local sourceSummary = self:GetCollectionSourceSummary(collectionType, patchKey, entry)
    local acquisition = self:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    local effect = self:GetCollectionUseText(collectionType, patchKey, entry)
    local tips = self:GetCollectionTips(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    local waypoints = self:GetCollectionWaypoints(collectionType, patchKey, entry)
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
                if type(details.waypointCriteria) == "table" then
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

    if #pins == 0 then
        return nil
    end

    return {
        title = (type(entry) == "table" and entry.name) or (state and state.name) or nil,
        collectionType = collectionType,
        sourceSummary = sourceSummary,
        acquisition = acquisition,
        effect = effect,
        tips = tips,
        requirements = requirements,
        cost = cost,
        costs = details.costs,
        availability = entryDetails.availability or details.availability,
        notes = notes,
        researchNotes = entryDetails.researchNotes or details.researchNotes,
        description = state and state.description,
        criteria = state and state.criteria,
        mapAchievementId = tonumber(details.mapAchievementId),
        waypoints = waypoints,
        pins = pins,
        mapID = pins[1] and pins[1].mapID or nil,
        icon = state and state.icon,
    }
end

function PatchCatalog:HasCollectionMapPayload(collectionType, patchKey, entry)
    local payload = self:GetCollectionMapPayload(collectionType, patchKey, entry)
    return payload and type(payload.pins) == "table" and #payload.pins > 0
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
