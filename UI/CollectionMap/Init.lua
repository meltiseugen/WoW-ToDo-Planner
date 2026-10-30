local _, TDP = ...


local CollectionMapWindow = {}
CollectionMapWindow.__index = CollectionMapWindow

local DEFAULT_MAP_ID = 107
local DEFAULT_PIN_X = 41.4
local DEFAULT_PIN_Y = 41.4
local MIN_ZOOM = 1
local MAX_ZOOM = 3
local ZOOM_STEP = 0.25
local COLLECTION_MAP_PIN_SIZE = 28
local COLLECTION_MAP_PIN_ICON_SIZE = 24
local COLLECTION_MAP_PIN_RING_SIZE = 30
local WORLD_MAP_PIN_BASE_SIZE = 30
local WORLD_MAP_PIN_DEFAULT_SCALE = 1.6
local WORLD_MAP_PIN_MIN_SCALE = 0.75
local WORLD_MAP_PIN_MAX_SCALE = 3
local MINIMAP_PIN_BASE_SIZE = 18

local TYPE_LABELS = {
    mounts = "Mount",
    pets = "Pet",
    toys = "Toy",
    cosmetics = "Cosmetic",
    achievements = "Achievement",
}

local function IsNonEmptyText(value)
    return type(value) == "string" and value ~= ""
end

local function IsCollectionType(value)
    return value == "mounts" or value == "pets" or value == "toys" or value == "cosmetics" or value == "achievements"
end

local function GetPinCoordinates(pinData)
    if type(pinData) ~= "table" then
        return nil, nil
    end
    local x = tonumber(pinData.x)
    local y = tonumber(pinData.y)
    if not x or not y then
        return nil, nil
    end
    if x > 1 or y > 1 then
        x = x / 100
        y = y / 100
    end
    if x < 0 or x > 1 or y < 0 or y > 1 then
        return nil, nil
    end
    return x, y
end

local function PinMatchesMap(pinData, mapID)
    return type(pinData) == "table" and tonumber(pinData.mapID) == tonumber(mapID)
end

function CollectionMapWindow:New()
    return setmetatable({
        frame = nil,
        mapID = DEFAULT_MAP_ID,
        initialMapID = nil,
        pins = {},
        tileTextures = {},
        exploredTileTextures = {},
        pinFrames = {},
        zoom = 1,
        panX = 0,
        panY = 0,
        title = nil,
        collectionType = nil,
        sourceSummary = nil,
        acquisition = nil,
        effect = nil,
        tips = nil,
        requirements = nil,
        cost = nil,
        costs = nil,
        availability = nil,
        notes = nil,
        researchNotes = nil,
        description = nil,
        criteria = nil,
        mapAchievementId = nil,
        showCompletedCriteriaPins = false,
        hasCriteriaPins = false,
        waypoints = nil,
        icon = nil,
        projectedPayload = nil,
        projectedPayloads = {},
        worldMapPins = {},
        minimapPins = {},
        worldMapControls = nil,
        criteriaEventFrame = nil,
        worldMapHooksInstalled = false,
    }, self)
end

CollectionMapWindow.Config = {
    DEFAULT_MAP_ID = DEFAULT_MAP_ID,
    DEFAULT_PIN_X = DEFAULT_PIN_X,
    DEFAULT_PIN_Y = DEFAULT_PIN_Y,
    MIN_ZOOM = MIN_ZOOM,
    MAX_ZOOM = MAX_ZOOM,
    ZOOM_STEP = ZOOM_STEP,
    COLLECTION_MAP_PIN_SIZE = COLLECTION_MAP_PIN_SIZE,
    COLLECTION_MAP_PIN_ICON_SIZE = COLLECTION_MAP_PIN_ICON_SIZE,
    COLLECTION_MAP_PIN_RING_SIZE = COLLECTION_MAP_PIN_RING_SIZE,
    WORLD_MAP_PIN_BASE_SIZE = WORLD_MAP_PIN_BASE_SIZE,
    WORLD_MAP_PIN_DEFAULT_SCALE = WORLD_MAP_PIN_DEFAULT_SCALE,
    WORLD_MAP_PIN_MIN_SCALE = WORLD_MAP_PIN_MIN_SCALE,
    WORLD_MAP_PIN_MAX_SCALE = WORLD_MAP_PIN_MAX_SCALE,
    MINIMAP_PIN_BASE_SIZE = MINIMAP_PIN_BASE_SIZE,
    TYPE_LABELS = TYPE_LABELS,
}

CollectionMapWindow.Helpers = {
    IsNonEmptyText = IsNonEmptyText,
    IsCollectionType = IsCollectionType,
    GetPinCoordinates = GetPinCoordinates,
    PinMatchesMap = PinMatchesMap,
}

TDP.CollectionMapWindow = CollectionMapWindow
