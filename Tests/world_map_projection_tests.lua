local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = { Widgets = {} }
local function loadAddon(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function equal(actual, expected, message)
    assert(actual == expected, message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function near(actual, expected, message)
    assert(math.abs(actual - expected) < 0.00001, message .. ": got " .. tostring(actual))
end
local function count(values)
    local total = 0
    for _ in pairs(values or {}) do total = total + 1 end
    return total
end

-- Model native canvas acquisition/pooling; use the bundled HBD libraries for
-- coordinate conversion, providers, minimap range, zoom, rotation, and shapes.
function Mixin(target, ...)
    for index = 1, select("#", ...) do
        for key, value in pairs(select(index, ...)) do target[key] = value end
    end
    return target
end
function CreateFromMixins(...) return Mixin({}, ...) end
function CreateFramePool() return { freePins = {} } end
MapCanvasPinMixin = {
    GetMap = function(pin) return pin.owningMap end,
    SetPosition = function(pin, x, y) pin.positionX, pin.positionY = x, y end,
    UseFrameLevelType = function(pin, value) pin.frameLevelType = value end,
    SetScalingLimits = function(pin) pin.loadCount = (pin.loadCount or 0) + 1 end,
}
MapCanvasDataProviderMixin = {
    GetMap = function(provider) return provider.map end,
    OnAdded = function(provider, map) provider.map = map end,
}
local map = CreateFrame("Frame", "WorldMapFrame", UIParent)
map.mapID, map.activePins, map.dataProviders, map.pinPools = 2395, {}, {}, {}
function map:GetMapID() return self.mapID end
function map:GetCanvas() return self end
function map:GetCanvasContainer() return self end
function map:AddDataProvider(provider)
    self.dataProviders[provider] = true
    provider:OnAdded(self)
end
function map:SetMapID(mapID)
    self.mapID = mapID
    for provider in pairs(self.dataProviders) do provider:RefreshAllData() end
end
function map:EnumeratePinsByTemplate(template)
    local snapshot, index = {}, 0
    for _, pin in ipairs(self.activePins) do
        if pin.pinTemplate == template then snapshot[#snapshot + 1] = pin end
    end
    return function() index = index + 1; return snapshot[index] end
end
function map:RemovePin(pin)
    local pool = assert(self.pinPools[pin.pinTemplate])
    for index, active in ipairs(self.activePins) do
        if active == pin then table.remove(self.activePins, index); break end
    end
    pool.resetFunc(pool, pin)
    pool.freePins[#pool.freePins + 1] = pin
end
function map:RemoveAllPinsByTemplate(template)
    for pin in self:EnumeratePinsByTemplate(template) do self:RemovePin(pin) end
end
function map:AcquirePin(template, ...)
    equal(template, "HereBeDragonsPinsTemplate", "HBD owns the canvas pin template")
    local pool = assert(self.pinPools[template])
    local pin = table.remove(pool.freePins)
    if not pin then
        pin = pool.createFunc()
        assert(not pin:GetScript("OnEnter") and not pin:GetScript("OnLeave"), "native canvas owns container hover scripts")
        pin:OnLoad()
    end
    pin.pinTemplate, pin.owningMap = template, self
    pin:OnAcquired(...)
    self.activePins[#self.activePins + 1] = pin
    return pin
end
local nativeShow, nativeHide = map.Show, map.Hide
function map:Show()
    nativeShow(self)
    for provider in pairs(self.dataProviders) do provider:RefreshAllData() end
    local handler = self:GetScript("OnShow")
    if handler then handler(self) end
end
function map:Hide()
    nativeHide(self)
    local handler = self:GetScript("OnHide")
    if handler then handler(self) end
end

local playerMapID, playerX, playerY, playerInstance = 2395, -400, -600, 1
local zoom, radius, facing, rotating, shape = 0, 100, 0, false, "ROUND"
WOW_PROJECT_ID = 1
Enum = { UIMapType = { Zone = 3, Dungeon = 4, Micro = 5, Continent = 2 } }
function CreateVector2D(x, y) return { GetXY = function() return x, y end } end
function UnitPosition() return playerY, playerX, 0, playerInstance end
function IsLoggedIn() return true end
function securecallfunction(callback, ...) return callback(...) end
function GetPlayerFacing() return facing end
function GetMinimapShape() return shape end
function GetCVar(name) return name == "rotateMinimap" and (rotating and "1" or "0") or "0" end
C_Timer = { After = function(delay, callback) if delay == 0 then callback() end end }
C_Minimap = { GetViewRadius = function() return radius end }
C_Map = {
    GetBestMapForUnit = function() return playerMapID end,
    GetMapInfo = function(mapID)
        if mapID == 2395 or mapID == 2647 then
            return { name = "Test zone", mapType = Enum.UIMapType.Zone, parentMapID = 0 }
        end
    end,
    GetMapChildrenInfo = function() return {} end,
    GetMapWorldSize = function() return 1000, 1000 end,
    GetWorldPosFromMapPos = function(mapID, position)
        local x, y = position:GetXY()
        return mapID == 2395 and 1 or 2, CreateVector2D(-y * 1000, -x * 1000)
    end,
    GetPlayerMapPosition = function() error("minimap projection must use HBD world coordinates") end,
    OpenWorldMap = function() error("the restricted C API must not be called") end,
}
Minimap = CreateFrame("Frame", "Minimap", UIParent)
Minimap:SetSize(140, 140)
function Minimap:GetZoom() return zoom end
function Minimap:SetZoom(value) zoom = value end
loadAddon("Libs/LibStub/LibStub.lua")
loadAddon("Libs/CallbackHandler-1.0/CallbackHandler-1.0.lua")
loadAddon("Libs/HereBeDragons/HereBeDragons-2.0.lua")
loadAddon("Libs/HereBeDragons/HereBeDragons-Pins-2.0.lua")
local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")
loadAddon("UI/CollectionMap/Init.lua")
loadAddon("UI/CollectionMap/Navigation.lua")
loadAddon("UI/CollectionMap/Projections.lua")
loadAddon("UI/CollectionMap/WorldMapPins.lua")
loadAddon("UI/CollectionMap/Minimap.lua")
loadAddon("UI/CollectionMap/WorldMap.lua")
loadAddon("UI/CollectionMap/Criteria.lua")
loadAddon("UI/CollectionMap/View.lua")
TODOPlannerDB = { settings = { worldMapPinScale = 1 } }
loadAddon("Core/Constants.lua")
loadAddon("Core/Utils.lua")
loadAddon("Data/Persistence/BoardManager.lua")
loadAddon("Data/Persistence/TaskRepository.lua")
loadAddon("Data/Persistence/Database.lua")
TDP.Database:Init()
TDP.EventFrame = CreateFrame("Frame")
loadAddon("Core/Bootstrap.lua")
local function updateMinimap()
    HBDPins.updateFrame:GetScript("OnUpdate")(HBDPins.updateFrame, 1.1)
end
local function offset(pin)
    for index = #mock.trace, 1, -1 do
        local entry = mock.trace[index]
        if entry[1] == pin.id and entry[2] == "SetPoint" then return entry[6], entry[7] end
    end
    error("Minimap pin has not been positioned")
end
local windows, passed = {}, 0
local function newWindow()
    local window = TDP.CollectionMapWindow:New()
    window.mapID, window.title, window.icon = 2395, "Test projection", 123
    window.pins = {
        { mapID = 2395, x = 0.4, y = 0.6, label = "Here" },
        { mapID = 2395, x = 0.42, y = 0.6, label = "Nearby" },
        { mapID = 2395, x = 0.7, y = 0.6, label = "Distant" },
        { mapID = 2647, x = 0.2, y = 0.8, label = "Other zone" },
    }
    window.FormatPinCoordinates = function(_, pin) return tostring(pin.x) .. ", " .. tostring(pin.y) end
    window.CreateWorldMapControls = function(self)
        self.worldMapControls = self.worldMapControls or CreateFrame("Frame", nil, map)
        return self.worldMapControls
    end
    window.SetStatus = function(self, value) self.status = value end
    windows[#windows + 1] = window
    return window
end
local function test(name, callback)
    playerMapID, playerX, playerY, playerInstance = 2395, -400, -600, 1
    zoom, radius, facing, rotating, shape = 0, 100, 0, false, "ROUND"
    TODOPlannerDB.settings.worldMapPinScale = 1
    OpenWorldMap = function(mapID) map:Show(); map:SetMapID(mapID) end
    ToggleWorldMap = function() map:Show() end
    HBD.UpdateCurrentPosition()
    HBDPins.updateFrame:GetScript("OnEvent")(HBDPins.updateFrame, "CVAR_UPDATE", "rotateMinimap", "0")
    callback()
    for _, window in ipairs(windows) do window:ClearWorldMapProjection() end
    windows = {}
    passed = passed + 1
    print("PASS: " .. name)
end

test("Project uses the bundled HBD APIs for both maps", function()
    local window = newWindow()
    equal(window:ProjectToWorldMap(), true, "projection succeeds")
    equal(count(HBDPins.worldmapPinRegistry[window]), 4, "all world-map icons registered with HBD")
    equal(count(HBDPins.minimapPinRegistry[window]), 4, "all minimap icons registered with HBD")
    equal(#map.activePins, 3, "world map shows its zone's pins")
    equal(window.minimapPins[1]:IsShown(), false, "only HBD may show minimap pins")
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), true, "nearby minimap pin shown")
    equal(window.minimapPins[3]:IsShown(), false, "distant minimap pin hidden")
    equal(window.minimapPins[4]:IsShown(), false, "other zone minimap pin hidden")
    equal(HBDPins.minimapPins[window.minimapPins[3]].floatOnEdge, false, "no rim clamping")
    equal(window.minimapFrame, nil, "no addon minimap polling frame")
    equal(window.worldMapDataProvider, nil, "no custom world-map provider")
    equal(count(map.dataProviders), 1, "HBD is the only map provider")
end)

test("world-map navigation and pooled canvas pins are owned by HBD", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    local icon = window.worldMapPins[4]
    equal(icon:IsShown(), false, "other zone icon starts hidden")
    map:SetMapID(2647)
    equal(#map.activePins, 1, "only the new zone's pin acquired")
    equal(icon:IsShown(), true, "HBD shows other zone's icon")
    equal(map.activePins[1].icon, icon, "HBD container owns the icon")
    near(map.activePins[1].positionX, 0.2, "native canvas horizontal position")
    near(map.activePins[1].positionY, 0.8, "native canvas vertical position")
    map:SetMapID(2395)
    for _, pin in ipairs(map.activePins) do equal(pin.loadCount, 1, "pooled pin initialized once") end
    equal(#map.activePins, 3, "original zone's pins restored")
end)

test("saved world-map sizing and compact circular minimap art are preserved", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    TODOPlannerDB.settings.worldMapPinScale = 0.75
    window:RefreshWorldMapProjection()
    equal(window.worldMapPins[1]:GetWidth(), 23, "saved world-map size applies")
    local pin = window.minimapPins[1]
    equal(pin:GetWidth(), 18, "compact minimap frame")
    equal(pin.icon:GetWidth(), 16, "compact minimap icon")
    equal(pin.icon.mask, pin.mask, "minimap icon clipped to circle")
    for _, entry in ipairs(mock.trace) do
        if entry[1] == pin.ring.id then assert(entry[2] ~= "SetColorTexture", "no solid square background") end
    end
end)

test("both map icons retain tooltip and waypoint interactions", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    local hovers, clicks = 0, 0
    window.ShowWorldMapPinTooltip = function(_, pin) equal(pin.label, "Here", "tooltip payload"); hovers = hovers + 1 end
    window.SetUserWaypoint = function(_, mapID, x, y)
        equal(mapID, 2395, "waypoint map"); equal(x, 0.4, "waypoint x"); equal(y, 0.6, "waypoint y")
        clicks = clicks + 1
    end
    GameTooltip = { Hide = function() end }
    for _, pin in ipairs({ window.worldMapPins[1], window.minimapPins[1] }) do
        pin:GetScript("OnEnter")(pin)
        pin:GetScript("OnLeave")(pin)
        pin:GetScript("OnClick")(pin, "LeftButton")
    end
    equal(hovers, 2, "both tooltips work")
    equal(clicks, 2, "both icons set waypoints")
end)

test("minimap offsets use world yards and react to movement, zoom, and rotation", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    updateMinimap()
    local pin = window.minimapPins[2]
    local x, y = offset(pin)
    near(x, 14, "20 yards at 100-yard radius"); near(y, 0, "same north/south coordinate")
    playerX = -410
    updateMinimap()
    x = offset(pin)
    near(x, 7, "movement updates world-space distance")
    zoom, radius = 1, 50
    updateMinimap()
    x = offset(pin)
    near(x, 14, "zoom uses new view radius")
    rotating, facing = true, math.pi / 2
    HBDPins.updateFrame:GetScript("OnEvent")(HBDPins.updateFrame, "CVAR_UPDATE", "rotateMinimap", "1")
    updateMinimap()
    x, y = offset(pin)
    near(x, 0, "rotated horizontal position"); near(y, -14, "rotated vertical position")
    equal(window.minimapPins[3]:IsShown(), false, "distant pin stays hidden")
end)

test("HBD recovers unavailable positions and displays pins after zone changes", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    updateMinimap()
    playerX = nil
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), false, "unavailable position hides pin")
    playerX = -399
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), true, "movement after position recovery restores pin")
    playerMapID, playerX, playerY, playerInstance = 2647, -200, -800, 2
    HBD.UpdateCurrentPosition()
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), false, "previous zone's pin hidden")
    equal(window.minimapPins[4]:IsShown(), true, "new zone's pin shown without re-projecting")
end)

test("round and square minimaps use HBD shape boundaries", function()
    local window = newWindow()
    window.pins = { { mapID = 2395, x = 0.48, y = 0.68 } }
    window:ProjectToWorldMap()
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), false, "diagonal outside round minimap")
    shape, playerX = "SQUARE", -401
    updateMinimap()
    equal(window.minimapPins[1]:IsShown(), true, "diagonal inside square minimap")
end)

test("re-projecting and criterion changes replace registrations on both maps", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    local oldWorld, oldMini = window.worldMapPins[4], window.minimapPins[4]
    window.mapAchievementId = 100
    window.pins = {
        { mapID = 2395, x = 0.4, y = 0.6 },
        { mapID = 2395, x = 0.41, y = 0.6, criterionCompleted = true },
    }
    window:ProjectToWorldMap()
    equal(HBDPins.worldmapPins[oldWorld], nil, "stale world-map registration removed")
    equal(HBDPins.minimapPins[oldMini], nil, "stale minimap registration removed")
    equal(count(HBDPins.worldmapPinRegistry[window]), 1, "completed world-map pin filtered")
    equal(count(HBDPins.minimapPinRegistry[window]), 1, "completed minimap pin filtered")
    window.showCompletedCriteriaPins = true
    window:RefreshProjectedCriteriaPins()
    updateMinimap()
    equal(count(HBDPins.worldmapPinRegistry[window]), 2, "completed world-map pin included on request")
    equal(count(HBDPins.minimapPinRegistry[window]), 2, "completed minimap pin included on request")
    equal(window.minimapPins[2]:IsShown(), true, "completed nearby pin visible")
end)

test("invalid coordinates and unknown maps do not leave unregistered visible icons", function()
    local window = newWindow()
    window.pins = {
        { mapID = 2395, x = -1, y = 0.6 },
        { mapID = 2999, x = 0.4, y = 0.6 },
        { mapID = 0, x = 0.4, y = 0.6 },
        { mapID = 2395, x = 0.4, y = 0.6 },
    }
    window:ProjectToWorldMap()
    updateMinimap()
    equal(count(HBDPins.worldmapPinRegistry[window]), 1, "one valid world-map registration")
    equal(count(HBDPins.minimapPinRegistry[window]), 1, "one valid minimap registration")
    equal(#map.activePins, 1, "one valid canvas pin")
end)

test("Clear unregisters both maps and preserves other owners' HBD pins", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    local otherOwner = {}
    local otherWorld, otherMini = CreateFrame("Button", nil, UIParent), CreateFrame("Button", nil, Minimap)
    HBDPins:AddWorldMapIconMap(otherOwner, otherWorld, 2395, 0.4, 0.6, 0)
    HBDPins:AddMinimapIconMap(otherOwner, otherMini, 2395, 0.4, 0.6, false, false)
    window:ClearWorldMapProjection()
    updateMinimap()
    equal(count(HBDPins.worldmapPinRegistry[window]), 0, "own world-map registrations cleared")
    equal(count(HBDPins.minimapPinRegistry[window]), 0, "own minimap registrations cleared")
    equal(#map.activePins, 1, "other owner's world-map pin remains")
    equal(otherWorld:IsShown(), true, "other owner's world-map icon visible")
    equal(otherMini:IsShown(), true, "other owner's minimap icon visible")
    for _, pin in ipairs(window.minimapPins) do equal(pin:IsShown(), false, "cleared minimap pin stays hidden") end
    equal(window.projectedPayload, nil, "projection payload cleared")
    HBDPins:RemoveAllWorldMapIcons(otherOwner)
    HBDPins:RemoveAllMinimapIcons(otherOwner)
end)

test("world-map close and reopen preserve projection and native Blizzard layering", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    map:Hide()
    updateMinimap()
    equal(count(HBDPins.worldmapPinRegistry[window]), 4, "world-map registrations retained while closed")
    equal(window.minimapPins[1]:IsShown(), true, "minimap active with world map closed")
    map:Show()
    equal(#map.activePins, 3, "world-map pins return without duplication")
    for _, entry in ipairs(mock.trace) do
        if entry[1] == map.id then
            assert(entry[2] ~= "SetFrameStrata" and entry[2] ~= "SetFrameLevel" and entry[2] ~= "SetToplevel" and entry[2] ~= "Raise", "Blizzard frame layering stays native")
        end
    end
end)

test("projection uses the Lua opener without invoking the restricted C API", function()
    local opens, toggles = 0, 0
    OpenWorldMap = function(mapID) opens = opens + 1; map:Show(); map:SetMapID(mapID) end
    ToggleWorldMap = function() toggles = toggles + 1; map:Show() end
    map:Hide()
    local window = newWindow()
    equal(window:ProjectToWorldMap(), true, "projection succeeds")
    equal(opens, 1, "Lua helper opens map")
    equal(toggles, 0, "no fallback after helper")
    equal(window:ProjectToWorldMap(), true, "already-open map projects again")
    equal(map:IsShown(), true, "already-open map stays open")
    equal(#map.activePins, 3, "repeat projection has no duplicate pins")
end)

test("map opening fallback and refused opening retain their behavior", function()
    OpenWorldMap = nil
    local toggles = 0
    ToggleWorldMap = function() toggles = toggles + 1; map:Show() end
    map:Hide()
    local window = newWindow()
    equal(window:ProjectToWorldMap(), true, "older-client fallback works")
    equal(window:ProjectToWorldMap(), true, "already-open fallback works")
    equal(toggles, 1, "already-open map is not toggled closed")
    window:ClearWorldMapProjection()
    OpenWorldMap = function() end
    ToggleWorldMap = function() error("do not bypass the helper's refusal to open") end
    map:Hide()
    equal(window:ProjectToWorldMap(), false, "refused opening reported")
    equal(window.status, "The Blizzard world map could not be opened.", "useful failure status")
    equal(count(HBDPins.worldmapPinRegistry[window]), 0, "no world-map registrations after refusal")
    equal(count(HBDPins.minimapPinRegistry[window]), 0, "no minimap registrations after refusal")
end)

local function serialize(value)
    local kind = type(value)
    if kind == "string" then return string.format("%q", value) end
    if kind == "number" or kind == "boolean" then return tostring(value) end
    assert(kind == "table", "SavedVariables must contain serializable data, got " .. kind)
    local parts = { "{" }
    for key, child in pairs(value) do
        parts[#parts + 1] = "[" .. serialize(key) .. "]=" .. serialize(child) .. ","
    end
    parts[#parts + 1] = "}"
    return table.concat(parts)
end

test("different items accumulate on both maps and re-projecting updates only that item", function()
    local window = newWindow()
    window.projectionKey, window.title, window.icon, window.sourceSummary = "toys:101", "First item", 101, "First source"
    window.pins = { { mapID = 2395, x = 0.4, y = 0.6 } }
    window:ProjectToWorldMap()
    window.projectionKey, window.title, window.icon, window.sourceSummary = "pets:202", "Second item", 202, "Second source"
    window.pins = { { mapID = 2395, x = 0.41, y = 0.6 } }
    window:ProjectToWorldMap()
    updateMinimap()
    equal(count(HBDPins.worldmapPinRegistry[window]), 2, "both world-map items retained")
    equal(count(HBDPins.minimapPinRegistry[window]), 2, "both minimap items retained")
    equal(window.worldMapPins[1].title, "First item", "first tooltip title retained")
    equal(window.minimapPins[2].source, "Second source", "second tooltip source retained")
    equal(#TODOPlannerDB.mapProjections, 2, "both items saved")
    equal(TODOPlannerDB.mapProjections[1].icon, 101, "first icon retained")
    equal(TODOPlannerDB.mapProjections[2].icon, 202, "second icon retained")
    window.projectionKey, window.title, window.icon = "toys:101", "Renamed first item", 303
    window.pins = { { mapID = 2395, x = 0.42, y = 0.6 } }
    window:ProjectToWorldMap()
    equal(#window.projectedPayloads, 2, "same item updated without duplication")
    equal(count(HBDPins.worldmapPinRegistry[window]), 2, "no duplicate world-map pins")
    equal(TODOPlannerDB.mapProjections[1].projectionKey, "pets:202", "other item unchanged")
    equal(TODOPlannerDB.mapProjections[2].pins[1].x, 0.42, "updated item's new location saved")
    window.projectionKey = "toys:404"
    window:ProjectToWorldMap()
    equal(#window.projectedPayloads, 3, "different IDs with the same title are distinct items")
end)

test("saved snapshots are independent of mutable catalog and view data", function()
    local window = newWindow()
    window.projectionKey = "toys:301"
    window.requirements = { "Original requirement" }
    window.costs = { { currencyId = 1, amount = 20 } }
    window.availability = { summary = "Original availability" }
    window.notes, window.researchNotes = "Original note", "Original research"
    window.requirements.callback = function() end
    window:ProjectToWorldMap()
    window.pins[1].x = 0.9
    window.requirements[1] = "Changed requirement"
    window.costs[1].amount = 999
    local saved = TODOPlannerDB.mapProjections[1]
    equal(saved.pins[1].x, 0.4, "saved coordinates do not reference view pins")
    equal(saved.requirements[1], "Original requirement", "requirements copied")
    equal(saved.requirements.callback, nil, "functions excluded from saved data")
    equal(saved.costs[1].amount, 20, "nested costs copied")
    equal(saved.notes, "Original note", "notes retained")
    equal(saved.researchNotes, "Original research", "research retained")
    assert(serialize(TODOPlannerDB), "saved database serializes")
end)

test("serialized projections restore onto both maps without opening either window", function()
    local window = newWindow()
    window.projectionKey, window.title = "toys:401", "First saved item"
    window.pins = { { mapID = 2395, x = 0.4, y = 0.6 } }
    window:ProjectToWorldMap()
    window.projectionKey, window.title = "pets:402", "Second saved item"
    window.pins = { { mapID = 2395, x = 0.41, y = 0.6 } }
    window:ProjectToWorldMap()
    TODOPlannerDB.tasks = { { id = 901, title = "Keep my task", boardKey = "GLOBAL" } }
    TODOPlannerDB.favorites = { kept = { patchKey = "12.1", collectionType = "toys", entryId = 99 } }
    local savedDatabase = serialize(TODOPlannerDB)
    window:HideWorldMapPins()
    window:HideMinimapPins()
    window.projectedPayload, window.projectedPayloads = nil, {}
    map:Hide()
    TODOPlannerDB = assert(loadstring("return " .. savedDatabase))()
    TDP.Database:Init()
    OpenWorldMap = function() error("restoring pins must not open the world map") end
    local restored = newWindow()
    restored:RestoreProjections()
    updateMinimap()
    equal(map:IsShown(), false, "world map stays closed during restore")
    equal(restored.frame, nil, "collection map is not built during restore")
    equal(count(HBDPins.worldmapPinRegistry[restored]), 2, "both world-map items restored")
    equal(count(HBDPins.minimapPinRegistry[restored]), 2, "both minimap items restored")
    equal(restored.minimapPins[1]:IsShown(), true, "nearby restored minimap item visible")
    equal(restored.minimapPins[2].title, "Second saved item", "restored tooltip keeps its own item")
    equal(restored.projectedPayload.projectionKey, "pets:402", "last projected item retained for details")
    equal(TODOPlannerDB.tasks[1].title, "Keep my task", "tasks survive restoration")
    equal(count(TODOPlannerDB.favorites), 1, "favorites survive restoration")
    map:Show()
    equal(#map.activePins, 2, "restored world-map icons visible on later open")
    restored:RestoreProjections()
    equal(count(HBDPins.worldmapPinRegistry[restored]), 2, "repeated restore has no duplicate registrations")
end)

test("clearing projections persists an empty set after a serialized reload", function()
    local window = newWindow()
    window:ProjectToWorldMap()
    window:ClearWorldMapProjection()
    local savedDatabase = serialize(TODOPlannerDB)
    TODOPlannerDB = assert(loadstring("return " .. savedDatabase))()
    local restored = newWindow()
    restored:RestoreProjections()
    equal(#TODOPlannerDB.mapProjections, 0, "saved projections cleared")
    equal(#restored.projectedPayloads, 0, "cleared projections do not return after reload")
    equal(count(HBDPins.minimapPinRegistry[restored]), 0, "no restored minimap registrations")
    equal(count(HBDPins.worldmapPinRegistry[restored]), 0, "no restored world-map registrations")
end)

test("restoration rejects malformed pins and collapses duplicate item identities", function()
    TODOPlannerDB.mapProjections = {
        false,
        { projectionKey = "bad", pins = { false, { mapID = 0, x = 0.3, y = 0.3 } } },
        { projectionKey = "toys:501", title = "Old", pins = { { mapID = 2395, x = 0.3, y = 0.6 } } },
        { projectionKey = "toys:501", title = "Updated", pins = { { mapID = 2395, x = 0.4, y = 0.6 } } },
    }
    local window = newWindow()
    window:RestoreProjections()
    equal(#window.projectedPayloads, 1, "one valid distinct item restored")
    equal(window.projectedPayload.title, "Updated", "latest duplicate wins")
    equal(#TODOPlannerDB.mapProjections, 1, "normalized saved set written back")
    TODOPlannerDB.mapProjections = "invalid"
    TDP.Database:Init()
    window:RestoreProjections()
    equal(#window.projectedPayloads, 0, "malformed saved root becomes an empty set")
end)

test("criterion events update every projected item while another item is being browsed", function()
    local window = newWindow()
    local completed = {}
    TDP.CollectionScanner = {
        ResetCache = function() end,
        GetAchievementState = function(_, achievementID)
            return { criteria = { { index = 1, text = "Objective", completed = completed[achievementID] == true } } }
        end,
    }
    window.projectionKey, window.mapAchievementId = "achievements:601", 601
    window.pins = { { mapID = 2395, x = 0.4, y = 0.6, criterionIndex = 1 } }
    window:ProjectToWorldMap()
    window.projectionKey, window.mapAchievementId = "achievements:602", 602
    window.pins = { { mapID = 2395, x = 0.41, y = 0.6, criterionIndex = 1 } }
    window:ProjectToWorldMap()
    window.projectionKey, window.title = "toys:unprojected", "Browsing only"
    completed[601] = true
    TDP.collectionMapWindow = window
    TDP.Bootstrap:RefreshCollectionCache()
    equal(#window.projectedPayloads, 2, "completed items retain their saved source pins")
    equal(count(HBDPins.worldmapPinRegistry[window]), 1, "completed objective removed from world map")
    equal(count(HBDPins.minimapPinRegistry[window]), 1, "completed objective removed from minimap")
    equal(#TODOPlannerDB.mapProjections[1].pins, 0, "criterion filtering saved")
    window:RefreshProjectedCriteriaPins()
    equal(#window.projectedPayloads, 2, "browsing does not implicitly project another item")
    window:HideWorldMapPins()
    window:HideMinimapPins()
    local restored = newWindow()
    restored:RestoreProjections()
    equal(count(HBDPins.minimapPinRegistry[restored]), 1, "restoration refreshes achievement completion")
    TDP.collectionMapWindow, TDP.CollectionScanner = nil, nil
end)

test("addon startup restores saved projections through the actual bootstrap", function()
    local seed = newWindow()
    seed:ProjectToWorldMap()
    seed:HideWorldMapPins()
    seed:HideMinimapPins()
    seed.projectedPayload, seed.projectedPayloads = nil, {}
    map:Hide()
    local restored
    local emptyClass = { New = function()
        return { Build = function(self) return self end, SetWindows = function() end }
    end }
    local initialize = { Init = function() end }
    local addon = {
        EventFrame = CreateFrame("Frame"), Database = TDP.Database,
        ThemeManager = { Create = function() end }, MainWindow = emptyClass,
        OptionsWindow = emptyClass, CollectionExplorerWindow = emptyClass,
        FavoritesWindow = emptyClass, HomeWindow = emptyClass,
        CollectionMapWindow = { New = function() restored = newWindow(); return restored end },
        MinimapButton = initialize, SlashCommands = initialize, Achievements = initialize,
        Utils = { Msg = function() end },
    }
    OpenWorldMap = function() error("startup restoration must not open the map") end
    local bootstrap = getmetatable(TDP.Bootstrap):New(addon)
    bootstrap:OnAddonLoaded("TODO-Planner")
    equal(addon.collectionMapWindow, restored, "bootstrap owns restored window")
    equal(#restored.projectedPayloads, 1, "startup restored the saved item")
    equal(count(HBDPins.worldmapPinRegistry[restored]), 4, "startup registered saved world-map pins")
    equal(count(HBDPins.minimapPinRegistry[restored]), 4, "startup registered saved minimap pins")
    equal(map:IsShown(), false, "startup leaves world map closed")
end)

test("opening a projected item retains its saved completed-pin filter", function()
    local window = newWindow()
    window.projectionKey = "achievements:701"
    window.showCompletedCriteriaPins = true
    window:ProjectToWorldMap()
    window.frame = CreateFrame("Frame", nil, UIParent)
    window.RenderMap = function() end
    TDP.Widgets.BringToFront = function() end
    window:Open({
        projectionKey = "achievements:701", title = "Opened again", collectionType = "achievements",
        mapID = 2395, mapAchievementId = 701,
        pins = { { mapID = 2395, x = 0.4, y = 0.6, criterionIndex = 1 } },
    })
    equal(window.showCompletedCriteriaPins, true, "view honors the saved projection filter")
    window:SetShowCompletedCriteriaPins(false)
    equal(TODOPlannerDB.mapProjections[1].showCompletedCriteriaPins, false, "explicit toggle updates the saved item")
    TDP.Widgets.BringToFront = nil
end)

test("invalid or refused additions preserve already projected and saved items", function()
    local window = newWindow()
    window.projectionKey = "toys:801"
    window:ProjectToWorldMap()
    local original = window.projectedPayload
    window.projectionKey, window.pins = "toys:802", { { mapID = 2395, x = -1, y = 0.5 } }
    equal(window:ProjectToWorldMap(), false, "invalid addition rejected")
    equal(window.projectedPayload, original, "current details retained")
    equal(#TODOPlannerDB.mapProjections, 1, "saved projection retained")
    window.pins = { { mapID = 2395, x = 0.5, y = 0.6 } }
    OpenWorldMap = function() end
    map:Hide()
    equal(window:ProjectToWorldMap(), false, "refused map opening reported")
    equal(#window.projectedPayloads, 1, "existing projection retained")
    equal(window.projectedPayload, original, "details roll back after refused opening")
    equal(count(HBDPins.minimapPinRegistry[window]), 4, "existing minimap registrations retained")
    equal(TODOPlannerDB.mapProjections[1].projectionKey, "toys:801", "failed addition was not saved")
end)

print("World map projection tests passed: " .. passed)
