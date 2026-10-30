local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local DEFAULT_MAP_ID = CollectionMapWindow.Config.DEFAULT_MAP_ID
local MIN_ZOOM = CollectionMapWindow.Config.MIN_ZOOM
local MAX_ZOOM = CollectionMapWindow.Config.MAX_ZOOM

function CollectionMapWindow:StartMapDrag(source)
    if type(GetCursorPosition) ~= "function" or not self.mapContent then
        return
    end

    self:StopMapDrag()
    self.dragging = true
    self.dragSource = source
    source.suppressMapClick = nil
    self.dragX, self.dragY = GetCursorPosition()
    self.dragStartX, self.dragStartY = self.dragX, self.dragY
    self.mapViewport:SetScript("OnUpdate", function()
        -- MouseUp may be missed when the pointer is released outside the map.
        if not IsMouseButtonDown("LeftButton") then
            self:StopMapDrag()
            return
        end
        self:UpdateMapDrag()
    end)
    if GameTooltip then
        GameTooltip:Hide()
    end
end

function CollectionMapWindow:UpdateMapDrag()
    if not self.dragging then
        return
    end

    local cursorX, cursorY = GetCursorPosition()
    local startDeltaX, startDeltaY = cursorX - self.dragStartX, cursorY - self.dragStartY
    -- Allow a little pointer jitter when clicking a waypoint pin.
    if startDeltaX * startDeltaX + startDeltaY * startDeltaY > 16 then
        self.dragMoved = true
    end

    -- Anchor offsets belong to mapContent, including its map zoom and UI scale.
    local scale = self.mapContent:GetEffectiveScale()
    self.panX = (self.panX or 0) + (cursorX - self.dragX) / scale
    self.panY = (self.panY or 0) + (cursorY - self.dragY) / scale
    self.dragX, self.dragY = cursorX, cursorY
    self:UpdateCanvasPosition()
end

function CollectionMapWindow:StopMapDrag()
    if self.dragSource then
        self.dragSource.suppressMapClick = self.dragMoved == true
    end
    self.dragging = false
    self.dragSource = nil
    self.dragMoved = nil
    self.dragX, self.dragY = nil, nil
    self.dragStartX, self.dragStartY = nil, nil
    if self.mapViewport then
        self.mapViewport:SetScript("OnUpdate", nil)
    end
end

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
    self:StopMapDrag()
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
    self:StopMapDrag()
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
    self:ResetView()
    return true
end
