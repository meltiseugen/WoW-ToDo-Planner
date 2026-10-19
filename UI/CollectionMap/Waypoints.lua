local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow

function CollectionMapWindow:SetUserWaypoint(mapID, x, y)
    x = tonumber(x)
    y = tonumber(y)
    if not x or not y then
        self:SetStatus("This pin does not have valid coordinates.")
        return false
    end

    if not C_Map or not C_Map.SetUserWaypoint or not UiMapPoint or not UiMapPoint.CreateFromCoordinates then
        self:SetStatus("This client cannot set user waypoints from addons.")
        return false
    end

    if C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(mapID) then
        self:SetStatus("This map cannot accept a user waypoint.")
        return false
    end

    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
    if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    end
    self:SetStatus("Waypoint set.")
    return true
end
