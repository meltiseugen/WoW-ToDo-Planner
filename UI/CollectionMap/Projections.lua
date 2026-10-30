local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates

local PAYLOAD_FIELDS = {
    "projectionKey", "title", "collectionType", "sourceSummary", "acquisition",
    "effect", "tips", "requirements", "cost", "costs", "availability", "notes",
    "researchNotes", "description", "criteria", "mapAchievementId", "waypoints", "icon",
}
local PIN_FIELDS = {
    "mapName", "label", "waypoint", "icon", "source", "acquisition", "effect", "tips",
    "criterionAchievementId", "criterionIndex", "criterionCompleted", "criterionText",
}

-- SavedVariables must contain data only, independent of frames and catalog tables.
local function CopyData(value, depth)
    local kind = type(value)
    if kind == "string" or kind == "boolean" then return value end
    if kind == "number" then
        if value == value and math.abs(value) < math.huge then return value end
    elseif kind == "table" and (depth or 0) < 10 then
        local result = {}
        for key, child in pairs(value) do
            if type(key) == "string" or (type(key) == "number" and key == key and math.abs(key) < math.huge) then
                result[key] = CopyData(child, (depth or 0) + 1)
            end
        end
        return result
    end
end

local function CopyPins(pins)
    local result = {}
    for _, source in ipairs(type(pins) == "table" and pins or {}) do
        local mapID = type(source) == "table" and tonumber(source.mapID)
        local x, y = GetPinCoordinates(source)
        if mapID and mapID > 0 and mapID < math.huge and mapID == math.floor(mapID)
            and x and y and x == x and y == y then
            local pin = { mapID = mapID, x = x, y = y }
            for _, field in ipairs(PIN_FIELDS) do pin[field] = CopyData(source[field]) end
            result[#result + 1] = pin
        end
    end
    return result
end

local function GetProjectionKey(payload)
    if type(payload.projectionKey) == "string" and payload.projectionKey ~= "" then
        return payload.projectionKey
    end
    local identity = payload.title or payload.mapAchievementId
    if not identity then
        local pin = (payload.allPins or payload.pins or {})[1] or {}
        identity = string.format("%s:%.6f:%.6f", tostring(pin.mapID), pin.x or 0, pin.y or 0)
    end
    return tostring(payload.collectionType or "locations") .. ":" .. tostring(identity)
end

local function FilterPins(payload)
    payload.pins = {}
    for _, pin in ipairs(payload.allPins) do
        if payload.showCompletedCriteriaPins or pin.criterionCompleted ~= true then
            payload.pins[#payload.pins + 1] = pin
        end
    end
end

local function NormalizePayload(source)
    if type(source) ~= "table" then return nil end
    local payload = {}
    for _, field in ipairs(PAYLOAD_FIELDS) do payload[field] = CopyData(source[field]) end
    payload.allPins = CopyPins(source.allPins or source.pins)
    if #payload.allPins == 0 then return nil end
    payload.mapID = tonumber(source.mapID) or payload.allPins[1].mapID
    payload.showCompletedCriteriaPins = source.showCompletedCriteriaPins == true
    payload.projectionKey = GetProjectionKey(payload)
    FilterPins(payload)
    return payload
end

function CollectionMapWindow:CopyProjectionPayload()
    local source = {}
    for _, field in ipairs(PAYLOAD_FIELDS) do source[field] = self[field] end
    source.allPins = self.pins
    source.mapID = self.mapID
    source.showCompletedCriteriaPins = self.showCompletedCriteriaPins
    return NormalizePayload(source) or { pins = {}, allPins = {} }
end

function CollectionMapWindow:GetProjectedPayloads()
    return self.projectedPayloads
end

function CollectionMapWindow:FindProjection(payload)
    local key = GetProjectionKey(payload)
    for index, existing in ipairs(self.projectedPayloads) do
        if existing.projectionKey == key then return existing, index end
    end
end

function CollectionMapWindow:EnumerateProjectedPins()
    local payloadIndex, pinIndex = 1, 0
    return function()
        while self.projectedPayloads[payloadIndex] do
            local payload = self.projectedPayloads[payloadIndex]
            pinIndex = pinIndex + 1
            local pin = payload.pins[pinIndex]
            if pin then return pin, payload end
            payloadIndex, pinIndex = payloadIndex + 1, 0
        end
    end
end

function CollectionMapWindow:SaveProjections()
    if type(TODOPlannerDB) ~= "table" then return end
    TODOPlannerDB.mapProjections = {}
    for _, payload in ipairs(self.projectedPayloads) do
        TODOPlannerDB.mapProjections[#TODOPlannerDB.mapProjections + 1] = NormalizePayload(payload)
    end
end

function CollectionMapWindow:AddProjection(payload)
    payload = NormalizePayload(payload)
    if not payload then return false end
    local _, index = self:FindProjection(payload)
    if index then table.remove(self.projectedPayloads, index) end
    self.projectedPayloads[#self.projectedPayloads + 1] = payload
    self.projectedPayload = payload
    self:SaveProjections()
    return true
end

local function RefreshPayloadCriteria(payload)
    local snapshot = CollectionMapWindow:New()
    snapshot.mapAchievementId = payload.mapAchievementId
    snapshot.criteria = payload.criteria
    snapshot.pins = payload.allPins
    local previous = {}
    for index, pin in ipairs(snapshot.pins) do
        previous[index] = { pin.criterionCompleted, pin.criterionText }
    end
    snapshot:RefreshCriteriaProgress()
    payload.criteria = snapshot.criteria
    FilterPins(payload)
    for index, pin in ipairs(snapshot.pins) do
        if pin.criterionCompleted ~= previous[index][1] or pin.criterionText ~= previous[index][2] then
            return true
        end
    end
    return false
end

function CollectionMapWindow:RefreshSavedProjectionCriteria()
    local changed = false
    for _, payload in ipairs(self.projectedPayloads) do
        if RefreshPayloadCriteria(payload) then changed = true end
    end
    if changed then
        self:SaveProjections()
        self:RefreshWorldMapProjection()
        self:RefreshMinimapProjection()
    end
end

function CollectionMapWindow:RestoreProjections()
    self:HideWorldMapPins()
    self:HideMinimapPins()
    self.projectedPayloads = {}
    self.projectedPayload = nil
    local saved = type(TODOPlannerDB) == "table" and TODOPlannerDB.mapProjections
    for _, source in ipairs(type(saved) == "table" and saved or {}) do
        local payload = NormalizePayload(source)
        if payload then
            RefreshPayloadCriteria(payload)
            -- Use the same update semantics for duplicate saved entries.
            local _, index = self:FindProjection(payload)
            if index then table.remove(self.projectedPayloads, index) end
            self.projectedPayloads[#self.projectedPayloads + 1] = payload
            self.projectedPayload = payload
        end
    end
    self:SaveProjections()
    if #self.projectedPayloads > 0 then
        self:HookWorldMap(self:LoadWorldMap())
        self:RefreshWorldMapProjection()
        self:RefreshMinimapProjection()
    end
    self:UpdateProjectionControls()
end
