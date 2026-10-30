local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local COLLECTION_TYPES = { "mounts", "pets", "toys", "cosmetics", "achievements" }
local NearbyCollections = {}

function NearbyCollections:GetMapInfo(mapID)
    if not C_Map or type(C_Map.GetMapInfo) ~= "function" then
        return nil
    end
    local ok, info = pcall(C_Map.GetMapInfo, mapID)
    return ok and type(info) == "table" and info or nil
end

function NearbyCollections:GetLocalMaps(mapID)
    local maps = {}
    local zoneType = Enum and Enum.UIMapType and Enum.UIMapType.Zone or 3
    local continentType = Enum and Enum.UIMapType and Enum.UIMapType.Continent or 2
    for _ = 1, 20 do
        if not mapID or mapID <= 0 or maps[mapID] then
            break
        end
        local info = self:GetMapInfo(mapID)
        -- Never expand a local search to a whole continent or world.
        if info and info.mapType and info.mapType <= continentType then
            break
        end
        maps[mapID] = true
        if info and info.mapType == zoneType then
            break
        end
        mapID = info and tonumber(info.parentMapID) or nil
    end
    return maps
end

function NearbyCollections:EntryMatches(collectionType, patchKey, entry, maps)
    if PatchCatalog:IsCollectionHiddenInUI(collectionType, patchKey, entry) then
        return false
    end
    for _, waypoint in ipairs(PatchCatalog:GetCollectionWaypoints(collectionType, patchKey, entry) or {}) do
        local pin = PatchCatalog:ParseWaypoint(waypoint)
        if pin and maps[tonumber(pin.mapID)] then
            return true
        end
    end
    local source = PatchCatalog.GetCollectionSourceInfo and PatchCatalog:GetCollectionSourceInfo(collectionType, patchKey, entry)
    local recorded = PatchCatalog:GetDescriptionMapLocations(collectionType, entry)
    local areas = source and source.areaOnly and source.areaMaps or recorded and recorded.areaMaps
    for _, mapID in ipairs(areas or {}) do
        if maps[mapID] then return true end
    end
    return false
end

-- A scan is a snapshot. Nothing registers events, schedules timers, or reads the
-- player's position until the Collections window explicitly requests a scan.
function NearbyCollections:Scan()
    local snapshot = { patchKeys = {}, entries = {}, total = 0 }
    local ok, mapID
    if C_Map and type(C_Map.GetBestMapForUnit) == "function" then
        ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
    end
    mapID = ok and tonumber(mapID) or nil
    if not mapID or mapID <= 0 then
        snapshot.error = "Current map unavailable. Click Nearby to try again."
        return snapshot
    end

    snapshot.mapID = mapID
    local info = self:GetMapInfo(mapID)
    snapshot.mapName = info and info.name or ("Map " .. mapID)
    local maps = self:GetLocalMaps(mapID)
    for _, patchKey in ipairs(PatchCatalog:GetPatchKeys()) do
        local patchEntries = {}
        local count = 0
        for _, collectionType in ipairs(COLLECTION_TYPES) do
            local entries = {}
            for _, entry in ipairs(PatchCatalog:GetEntries(patchKey, collectionType)) do
                if self:EntryMatches(collectionType, patchKey, entry, maps) then
                    entries[#entries + 1] = entry
                    count = count + 1
                end
            end
            patchEntries[collectionType] = entries
        end
        if count > 0 then
            snapshot.patchKeys[#snapshot.patchKeys + 1] = patchKey
            snapshot.entries[patchKey] = patchEntries
            snapshot.total = snapshot.total + count
        end
    end
    return snapshot
end

TDP.NearbyCollections = NearbyCollections
