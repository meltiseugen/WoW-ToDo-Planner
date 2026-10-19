local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local DEFAULT_MAP_ID = CollectionMapWindow.Config.DEFAULT_MAP_ID
local MIN_ZOOM = CollectionMapWindow.Config.MIN_ZOOM
local MAX_ZOOM = CollectionMapWindow.Config.MAX_ZOOM

function CollectionMapWindow:ClampZoom(value)
    value = tonumber(value) or 1
    if value < MIN_ZOOM then
        return MIN_ZOOM
    elseif value > MAX_ZOOM then
        return MAX_ZOOM
    end
    return value
end

function CollectionMapWindow:GetMapName(mapID)
    if C_Map and C_Map.GetMapInfo then
        local mapInfo = C_Map.GetMapInfo(mapID)
        if mapInfo and mapInfo.name then
            return mapInfo.name
        end
    end
    return "Map " .. tostring(mapID)
end

function CollectionMapWindow:NavigateToParentMap()
    local mapInfo = nil
    if C_Map and C_Map.GetMapInfo then
        local ok, result = pcall(C_Map.GetMapInfo, self.mapID)
        if ok then
            mapInfo = result
        end
    end

    local parentMapID = mapInfo and tonumber(mapInfo.parentMapID)
    if not parentMapID or parentMapID <= 0 or parentMapID == tonumber(self.mapID) then
        self:SetStatus("This map has no parent map.")
        return false
    end

    self.mapID = parentMapID
    self.zoom = 1
    self.panX = 0
    self.panY = 0
    self.dragging = false
    self:RenderMap()
    return true
end

function CollectionMapWindow:GetDefaultMapID()
    if C_Map and C_Map.GetBestMapForUnit then
        local ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
        if ok and mapID then
            return mapID
        end
    end
    return DEFAULT_MAP_ID
end

function CollectionMapWindow:SetStatus(text)
    if self.statusText then
        self.statusText:SetText(text or "")
    end
end

function CollectionMapWindow:AdjustZoom(delta)
    self.zoom = self:ClampZoom((self.zoom or 1) + delta)
    self:RenderMap()
end

function CollectionMapWindow:ResetView()
    self.dragging = false
    self.dragX = nil
    self.dragY = nil
    self.zoom = 1
    self.panX = 0
    self.panY = 0
    self:RenderMap()
end

function CollectionMapWindow:ResetToInitialMap()
    if not self.initialMapID then
        self:SetStatus("No initial map is available.")
        return false
    end

    self.mapID = self.initialMapID
    self.dragging = false
    self:ResetView()
    return true
end
