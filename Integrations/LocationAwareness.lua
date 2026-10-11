local _, TDP = ...

local Boards = TDP.Boards
local Tasks = TDP.Tasks
local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local Utils = TDP.Utils

local COLLECTION_TYPES = {
    mounts = true,
    pets = true,
    toys = true,
    cosmetics = true,
    achievements = true,
}

local LocationAwareness = {}
LocationAwareness.__index = LocationAwareness

function LocationAwareness:New(addon)
    return setmetatable({
        addon = addon,
        currentMapID = nil,
        currentMapName = nil,
        lastAnnouncedMapID = nil,
        nearbyTasks = {},
        nearbyTaskIds = {},
        taskMapCache = {},
        achievementPatchById = nil,
        refreshQueued = false,
    }, self)
end

function LocationAwareness:ResetCache()
    self.taskMapCache = {}
    self.achievementPatchById = nil
end

function LocationAwareness:GetCurrentMapID()
    if not C_Map or type(C_Map.GetBestMapForUnit) ~= "function" then
        return nil
    end

    local ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
    return ok and tonumber(mapID) or nil
end

function LocationAwareness:GetMapInfo(mapID)
    if not mapID or not C_Map or type(C_Map.GetMapInfo) ~= "function" then
        return nil
    end

    local ok, mapInfo = pcall(C_Map.GetMapInfo, mapID)
    return ok and type(mapInfo) == "table" and mapInfo or nil
end

function LocationAwareness:GetMapName(mapID)
    local mapInfo = self:GetMapInfo(mapID)
    if mapInfo and mapInfo.name and mapInfo.name ~= "" then
        return mapInfo.name
    end
    return "Map " .. tostring(mapID or "Unknown")
end

function LocationAwareness:GetMapHierarchy(mapID)
    local mapIDs = {}
    local currentMapID = tonumber(mapID)
    local remaining = 20

    while currentMapID and currentMapID > 0 and not mapIDs[currentMapID] and remaining > 0 do
        mapIDs[currentMapID] = true
        remaining = remaining - 1

        local mapInfo = self:GetMapInfo(currentMapID)
        local parentMapID = mapInfo and tonumber(mapInfo.parentMapID) or nil
        if not parentMapID or parentMapID <= 0 or parentMapID == currentMapID then
            break
        end
        currentMapID = parentMapID
    end

    return mapIDs
end

function LocationAwareness:BuildAchievementPatchIndex()
    if self.achievementPatchById then
        return self.achievementPatchById
    end

    local index = {}
    if PatchCatalog then
        for _, patchKey in ipairs(PatchCatalog:GetPatchKeys()) do
            for _, achievementId in ipairs(PatchCatalog:GetEntries(patchKey, "achievements")) do
                index[tostring(achievementId)] = patchKey
            end
        end
    end

    self.achievementPatchById = index
    return index
end

function LocationAwareness:GetTaskCollection(task)
    if not task then
        return nil
    end

    if task.sourceType == "achievement" then
        local achievementId = tonumber(task.sourceId)
        local patchKey = achievementId and self:BuildAchievementPatchIndex()[tostring(achievementId)] or nil
        if patchKey then
            return patchKey, "achievements", achievementId
        end
        return nil
    end

    if task.sourceType ~= "patchCollection" then
        return nil
    end

    local patchKey, collectionType, entryId = tostring(task.sourceId or ""):match("^([^:]+):([^:]+):(.+)$")
    if not patchKey or not COLLECTION_TYPES[collectionType] then
        return nil
    end

    return patchKey, collectionType, entryId
end

function LocationAwareness:FindCollectionEntry(patchKey, collectionType, entryId)
    if collectionType == "achievements" then
        for _, achievementId in ipairs(PatchCatalog:GetEntries(patchKey, collectionType)) do
            if tostring(achievementId) == tostring(entryId) then
                return achievementId
            end
        end
        return nil
    end

    for _, entry in ipairs(PatchCatalog:GetEntries(patchKey, collectionType)) do
        if tostring(CollectionScanner:GetEntryKey(collectionType, entry) or "") == tostring(entryId or "") then
            return entry
        end
    end

    return nil
end

function LocationAwareness:GetTaskMapIDs(task)
    if not task then
        return {}
    end

    local cacheKey = tostring(task.sourceType or "") .. ":" .. tostring(task.sourceId or "")
    if self.taskMapCache[cacheKey] then
        return self.taskMapCache[cacheKey]
    end

    local mapIDs = {}
    local patchKey, collectionType, entryId = self:GetTaskCollection(task)
    local entry = patchKey and self:FindCollectionEntry(patchKey, collectionType, entryId) or nil
    local waypoints = entry and PatchCatalog:GetCollectionWaypoints(collectionType, patchKey, entry) or nil

    if type(waypoints) == "table" then
        for _, waypoint in ipairs(waypoints) do
            local pin = PatchCatalog:ParseWaypoint(waypoint)
            local mapID = pin and tonumber(pin.mapID) or nil
            if mapID then
                mapIDs[mapID] = true
            end
        end
    end

    self.taskMapCache[cacheKey] = mapIDs
    return mapIDs
end

function LocationAwareness:IsTaskRelevantToMap(task, mapHierarchy)
    for mapID in pairs(self:GetTaskMapIDs(task)) do
        if mapHierarchy[mapID] then
            return true
        end
    end
    return false
end

function LocationAwareness:GetNearbyTasks(mapID)
    local nearbyTasks = {}
    if type(TODOPlannerDB) ~= "table" or type(TODOPlannerDB.tasks) ~= "table" or not mapID then
        return nearbyTasks
    end

    local mapHierarchy = self:GetMapHierarchy(mapID)
    for _, task in ipairs(TODOPlannerDB.tasks) do
        local boardKey = Tasks:GetBoardKey(task)
        if not Tasks:IsArchived(task)
            and Tasks:GetStatus(task, boardKey) ~= "DONE"
            and self:IsTaskRelevantToMap(task, mapHierarchy) then
            nearbyTasks[#nearbyTasks + 1] = task
        end
    end

    table.sort(nearbyTasks, function(left, right)
        local leftBoard = Boards:GetDisplayName(Tasks:GetBoardKey(left))
        local rightBoard = Boards:GetDisplayName(Tasks:GetBoardKey(right))
        if leftBoard ~= rightBoard then
            return leftBoard < rightBoard
        end
        return tostring(left.title or "") < tostring(right.title or "")
    end)

    return nearbyTasks
end

function LocationAwareness:AnnounceNearbyTasks()
    if #self.nearbyTasks == 0 then
        return
    end

    local taskLabels = {}
    local shownCount = math.min(3, #self.nearbyTasks)
    for index = 1, shownCount do
        local task = self.nearbyTasks[index]
        taskLabels[#taskLabels + 1] = string.format(
            "%s [%s]",
            task.title or "Untitled",
            Boards:GetDisplayName(Tasks:GetBoardKey(task))
        )
    end

    local remainingText = #self.nearbyTasks > shownCount
        and string.format(" +%d more", #self.nearbyTasks - shownCount)
        or ""
    Utils:Msg(string.format(
        "Nearby in %s: %s%s",
        self.currentMapName or self:GetMapName(self.currentMapID),
        table.concat(taskLabels, ", "),
        remainingText
    ))
end

function LocationAwareness:Refresh(announceOnMapChange)
    local mapID = self:GetCurrentMapID()
    local mapChanged = mapID ~= self.currentMapID
    self.currentMapID = mapID
    self.currentMapName = mapID and self:GetMapName(mapID) or nil
    self.nearbyTasks = self:GetNearbyTasks(mapID)
    self.nearbyTaskIds = {}
    for _, task in ipairs(self.nearbyTasks) do
        self.nearbyTaskIds[task.id] = true
    end

    if announceOnMapChange and mapID and mapID ~= self.lastAnnouncedMapID then
        self.lastAnnouncedMapID = mapID
        self:AnnounceNearbyTasks()
    end

    return mapChanged, #self.nearbyTasks
end

function LocationAwareness:IsTaskNearby(task)
    return task and self.nearbyTaskIds[task.id] == true
end

function LocationAwareness:GetSummaryText()
    if not self.currentMapID or #self.nearbyTasks == 0 then
        return nil
    end

    return string.format(
        "Nearby in %s: %d unfinished %s",
        self.currentMapName or self:GetMapName(self.currentMapID),
        #self.nearbyTasks,
        #self.nearbyTasks == 1 and "task" or "tasks"
    )
end

function LocationAwareness:ScheduleRefresh(announceOnMapChange)
    if self.refreshQueued then
        return
    end

    self.refreshQueued = true
    local refresh = function()
        self.refreshQueued = false
        local previousAnnouncedMapID = self.lastAnnouncedMapID
        local mapChanged = self:Refresh(announceOnMapChange)
        local announcementMapChanged = announceOnMapChange
            and self.lastAnnouncedMapID ~= previousAnnouncedMapID
        if (mapChanged or announcementMapChanged) and self.addon.ui then
            self.addon.ui:Render()
        end
    end

    local timer = _G.C_Timer
    if timer and type(timer.After) == "function" then
        timer.After(0.2, refresh)
    else
        refresh()
    end
end

TDP.LocationAwareness = LocationAwareness:New(TDP)
