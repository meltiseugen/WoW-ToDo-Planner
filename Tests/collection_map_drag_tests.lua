local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
assert(loadfile(root .. "/Core/Constants.lua"))("TODO-Planner", TDP)
assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP,
    "UI/Widgets/Widgets.xml", "UI/CollectionMap/CollectionMap.xml")
TODOPlannerDB = { settings = {} }
GameTooltip = CreateFrame("Frame")

local cursorX, cursorY, leftDown = 100, 100, false
function GetCursorPosition() return cursorX, cursorY end
function IsMouseButtonDown(button) return button == "LeftButton" and leftDown end
C_Map = { GetMapInfo = function() return { parentMapID = 7 } end }

local function near(actual, expected, message)
    assert(math.abs(actual - expected) < 0.00001,
        message .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function event(frame, name, ...)
    assert(frame:GetScript(name), "Missing " .. name)(frame, ...)
end
local function setup(uiScale, zoom)
    cursorX, cursorY, leftDown = 100, 100, true
    local window = TDP.CollectionMapWindow:New()
    window:Build()
    window.layer = { layerWidth = 1000, layerHeight = 500 }
    window.zoom = zoom or 1
    function window.mapContent:SetScale(scale) self.scale = scale end
    function window.mapContent:GetEffectiveScale() return self.scale * (uiScale or 1) end
    function window.mapContent:SetPoint(_, _, _, x, y) self.offsetX, self.offsetY = x, y end
    window.RenderMap = window.UpdateCanvasPosition
    window:UpdateCanvasPosition()
    return window
end
local function assertStopped(window)
    assert(not window.dragging, "drag stopped")
    assert(window.dragX == nil and window.dragY == nil, "cursor coordinates cleared")
    assert(window.mapViewport:GetScript("OnUpdate") == nil, "no idle drag updates")
end

local failures, passed = {}, 0
local function test(name, callback)
    local ok, message = pcall(callback)
    if ok then
        passed = passed + 1
        print("PASS: " .. name)
    else
        failures[#failures + 1] = name .. ": " .. tostring(message)
        print("FAIL: " .. failures[#failures])
    end
end

test("map follows cursor across UI scales and zoom levels", function()
    for _, uiScale in ipairs({ 0.65, 1, 1.25 }) do
        for _, zoom in ipairs({ 1, 2, 3 }) do
            local window = setup(uiScale, zoom)
            event(window.mapViewport, "OnMouseDown", "LeftButton")
            cursorX, cursorY = 160, 70
            event(window.mapViewport, "OnUpdate")
            local scale = window.mapContent:GetEffectiveScale()
            near(window.mapContent.offsetX * scale, 60, "horizontal screen movement")
            near(window.mapContent.offsetY * scale, -30, "vertical screen movement")
            -- The last movement can arrive between the final update and release.
            cursorX, cursorY, leftDown = 170, 80, false
            event(window.mapViewport, "OnMouseUp", "LeftButton")
            near(window.mapContent.offsetX * scale, 70, "final horizontal movement")
            assertStopped(window)
        end
    end
end)

test("drag can start on a pin without placing a waypoint", function()
    local window = setup(0.8, 2)
    local pin = window:GetPin(1)
    local waypoints = 0
    window.SetUserWaypoint = function() waypoints = waypoints + 1 end
    event(pin, "OnMouseDown", "LeftButton")
    -- A quick drag can finish without a single OnUpdate.
    cursorX, cursorY, leftDown = 140, 120, false
    event(pin, "OnMouseUp", "LeftButton")
    event(pin, "OnClick", "LeftButton")
    near(window.mapContent.offsetX * window.mapContent:GetEffectiveScale(), 40, "pin horizontal drag")
    near(window.mapContent.offsetY * window.mapContent:GetEffectiveScale(), 20, "pin vertical drag")
    assert(waypoints == 0, "drag must not set a waypoint")
    assertStopped(window)
end)

test("pin clicks tolerate small pointer movement after a previous drag", function()
    local window = setup()
    local pin = window:GetPin(1)
    pin.mapID, pin.x, pin.y = 42, 0.4, 0.6
    local waypoints = 0
    window.SetUserWaypoint = function(_, mapID, x, y)
        assert(mapID == 42 and x == 0.4 and y == 0.6, "original waypoint coordinates")
        waypoints = waypoints + 1
    end
    event(pin, "OnMouseDown", "LeftButton")
    cursorX = 150
    event(window.mapViewport, "OnUpdate")
    cursorX, leftDown = 100, false
    event(pin, "OnMouseUp", "LeftButton")
    event(pin, "OnClick", "LeftButton")
    assert(waypoints == 0, "returning to the starting position still counts as a drag")
    leftDown = true
    event(pin, "OnMouseDown", "LeftButton")
    cursorX, cursorY, leftDown = 102, 101, false
    event(pin, "OnMouseUp", "LeftButton")
    event(pin, "OnClick", "LeftButton")
    assert(waypoints == 1, "a later ordinary click still sets a waypoint")
end)

test("right-button release preserves left drag and outside release stops it", function()
    local window = setup()
    event(window.mapViewport, "OnMouseDown", "LeftButton")
    event(window.mapViewport, "OnMouseUp", "RightButton")
    assert(window.dragging, "right-button release must not end left dragging")
    cursorX = 130
    event(window.mapViewport, "OnUpdate")
    local pan = window.panX
    cursorX, leftDown = 200, false
    event(window.mapViewport, "OnUpdate")
    near(window.panX, pan, "no movement after release outside the map")
    assertStopped(window)
end)

test("reset navigation hide and reopen clear active dragging", function()
    for _, action in ipairs({ "reset", "parent", "hide", "open" }) do
        local window = setup()
        event(window.mapViewport, "OnMouseDown", "LeftButton")
        cursorX = 130
        event(window.mapViewport, "OnUpdate")
        if action == "reset" then window:ResetView()
        elseif action == "parent" then window:NavigateToParentMap()
        elseif action == "hide" then event(window.mapViewport, "OnHide")
        else window:Open({ mapID = 42 }) end
        assertStopped(window)
    end
end)

test("right click on pins and background still navigates once", function()
    local window = setup()
    local pin = window:GetPin(1)
    local navigations = 0
    window.NavigateToParentMap = function() navigations = navigations + 1 end
    event(window.mapViewport, "OnMouseDown", "RightButton")
    event(window.mapViewport, "OnMouseUp", "RightButton")
    assert(navigations == 1, "background navigation")
    event(pin, "OnMouseDown", "RightButton")
    event(pin, "OnMouseUp", "RightButton")
    event(pin, "OnClick", "RightButton")
    assert(navigations == 2, "pin navigation")
end)

assert(#failures == 0, table.concat(failures, "\n"))
print("Collection map drag tests passed: " .. passed)
