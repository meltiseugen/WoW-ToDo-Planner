local _, TDP = ...

local Widgets = TDP.Widgets

local CollectionMapWindow = {}
CollectionMapWindow.__index = CollectionMapWindow

local DEFAULT_MAP_ID = 107
local DEFAULT_PIN_X = 41.4
local DEFAULT_PIN_Y = 41.4
local MIN_ZOOM = 1
local MAX_ZOOM = 3
local ZOOM_STEP = 0.25
local WORLD_MAP_PIN_SIZE = 30

local TYPE_LABELS = {
    mounts = "Mount",
    pets = "Pet",
    toys = "Toy",
}

local function IsNonEmptyText(value)
    return type(value) == "string" and value ~= ""
end

local function IsCollectionType(value)
    return value == "mounts" or value == "pets" or value == "toys"
end

function CollectionMapWindow:New()
    return setmetatable({
        frame = nil,
        mapID = DEFAULT_MAP_ID,
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
        waypoints = nil,
        icon = nil,
        projectedPayload = nil,
        worldMapPins = {},
        worldMapControls = nil,
        worldMapEventFrame = nil,
        worldMapHooksInstalled = false,
    }, self)
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

function CollectionMapWindow:GetCollectionTypeLabel()
    return TYPE_LABELS[self.collectionType] or "Collection"
end

function CollectionMapWindow:FormatPinCoordinates(pinData)
    return string.format("#%s %.1f %.1f", tostring(pinData.mapID), (pinData.x or 0) * 100, (pinData.y or 0) * 100)
end

function CollectionMapWindow:AddDetailsSection(lines, title, body)
    if not IsNonEmptyText(body) then
        return
    end

    if #lines > 0 then
        lines[#lines + 1] = ""
    end
    lines[#lines + 1] = title .. ":"
    lines[#lines + 1] = body
end

function CollectionMapWindow:BuildDetailsText()
    local lines = {}

    self:AddDetailsSection(lines, "Source", self.sourceSummary)
    self:AddDetailsSection(lines, "How to get", self.acquisition)
    self:AddDetailsSection(lines, "Effect", self.effect)

    if type(self.pins) == "table" and #self.pins > 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Locations:"
        for index, pinData in ipairs(self.pins) do
            local mapName = self:GetMapName(pinData.mapID)
            local label = IsNonEmptyText(pinData.label) and pinData.label or (self.title or "Collection location")
            lines[#lines + 1] = string.format("%d. %s", index, label)
            lines[#lines + 1] = "   Map: " .. mapName .. " #" .. tostring(pinData.mapID)
            lines[#lines + 1] = "   Coordinates: " .. string.format("%.1f, %.1f", (pinData.x or 0) * 100, (pinData.y or 0) * 100)

            if IsNonEmptyText(pinData.source) and pinData.source ~= self.sourceSummary then
                lines[#lines + 1] = "   Source: " .. pinData.source
            end
            if IsNonEmptyText(pinData.acquisition) and pinData.acquisition ~= self.acquisition then
                lines[#lines + 1] = "   How to get: " .. pinData.acquisition
            end
            if IsNonEmptyText(pinData.effect) and pinData.effect ~= self.effect then
                lines[#lines + 1] = "   Effect: " .. pinData.effect
            end
        end
    end

    if type(self.waypoints) == "table" and #self.waypoints > 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Waypoints:"
        for _, waypoint in ipairs(self.waypoints) do
            lines[#lines + 1] = waypoint
        end
    elseif not self.sourceSummary and not self.acquisition and not self.effect and (#(self.pins or {}) == 0) then
        lines[#lines + 1] = "No curated source details are available for this entry yet."
    end

    return table.concat(lines, "\n")
end

function CollectionMapWindow:RenderDetails()
    if not self.detailTitle then
        return
    end

    self.detailIcon:SetTexture(self.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    self.detailTitle:SetText(self.title or "Collection location")
    self.detailMeta:SetText(self:GetCollectionTypeLabel())
    Widgets:UpdateScrollablePreviewText(self.detailScroll, self.detailContent, self.detailText, self:BuildDetailsText())
end

function CollectionMapWindow:HideTiles()
    for _, texture in ipairs(self.tileTextures) do
        texture:Hide()
    end
end

function CollectionMapWindow:HideExploredTiles()
    for _, texture in ipairs(self.exploredTileTextures or {}) do
        texture:Hide()
    end
end

function CollectionMapWindow:HidePins()
    for _, pin in ipairs(self.pinFrames) do
        pin:Hide()
    end
end

function CollectionMapWindow:GetTile(index)
    local texture = self.tileTextures[index]
    if not texture then
        texture = self.mapContent:CreateTexture(nil, "BACKGROUND")
        texture:SetHorizTile(false)
        texture:SetVertTile(false)
        self.tileTextures[index] = texture
    end
    return texture
end

function CollectionMapWindow:GetExploredTile(index)
    self.exploredTileTextures = self.exploredTileTextures or {}
    local texture = self.exploredTileTextures[index]
    if not texture then
        texture = self.mapContent:CreateTexture(nil, "ARTWORK")
        if texture.SetDrawLayer then
            texture:SetDrawLayer("ARTWORK", -1)
        end
        self.exploredTileTextures[index] = texture
    end
    return texture
end

function CollectionMapWindow:GetPin(index)
    local pin = self.pinFrames[index]
    if not pin then
        pin = CreateFrame("Button", nil, self.mapContent, "BackdropTemplate")
        pin:SetSize(28, 28)
        pin.icon = pin:CreateTexture(nil, "OVERLAY")
        pin.icon:SetPoint("CENTER")
        pin.icon:SetSize(24, 24)
        if not pin.icon.SetAtlas or not pcall(pin.icon.SetAtlas, pin.icon, "VignetteLoot", true) then
            pin.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
        end
        pin.ring = pin:CreateTexture(nil, "ARTWORK")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetSize(30, 30)
        pin.ring:SetColorTexture(1.0, 0.82, 0.18, 0.18)
        pin:SetScript("OnEnter", function(target)
            GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
            GameTooltip:SetText(target.title or target.label or "Collection location", 1, 0.82, 0.18)
            GameTooltip:Show()
        end)
        pin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        pin:SetScript("OnClick", function(target)
            self:SetUserWaypoint(target.mapID, target.x, target.y)
        end)
        self.pinFrames[index] = pin
    end
    return pin
end

function CollectionMapWindow:SetUserWaypoint(mapID, x, y)
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

function CollectionMapWindow:CopyProjectionPayload()
    local pins = {}
    for _, pinData in ipairs(self.pins or {}) do
        pins[#pins + 1] = {
            mapID = pinData.mapID,
            x = pinData.x,
            y = pinData.y,
            label = pinData.label,
            waypoint = pinData.waypoint,
            icon = pinData.icon,
            source = pinData.source,
            acquisition = pinData.acquisition,
            effect = pinData.effect,
        }
    end

    local waypoints = nil
    if type(self.waypoints) == "table" then
        waypoints = {}
        for _, waypoint in ipairs(self.waypoints) do
            waypoints[#waypoints + 1] = waypoint
        end
    end

    return {
        title = self.title,
        collectionType = self.collectionType,
        sourceSummary = self.sourceSummary,
        acquisition = self.acquisition,
        effect = self.effect,
        waypoints = waypoints,
        pins = pins,
        mapID = self.mapID,
        icon = self.icon,
    }
end

function CollectionMapWindow:LoadWorldMap()
    if C_AddOns and C_AddOns.LoadAddOn then
        pcall(C_AddOns.LoadAddOn, "Blizzard_WorldMap")
        pcall(C_AddOns.LoadAddOn, "Blizzard_MapCanvas")
    elseif LoadAddOn then
        pcall(LoadAddOn, "Blizzard_WorldMap")
        pcall(LoadAddOn, "Blizzard_MapCanvas")
    end

    return WorldMapFrame
end

function CollectionMapWindow:GetWorldMapContent()
    local worldMap = self:LoadWorldMap()
    local scrollContainer = worldMap and worldMap.ScrollContainer
    return scrollContainer and scrollContainer.Child, worldMap
end

function CollectionMapWindow:HideWorldMapPins()
    for _, pin in ipairs(self.worldMapPins or {}) do
        pin:Hide()
    end
end

function CollectionMapWindow:CreateWorldMapPin(index, parent)
    self.worldMapPins = self.worldMapPins or {}
    local pin = self.worldMapPins[index]
    if not pin then
        pin = CreateFrame("Button", nil, parent, "BackdropTemplate")
        pin:SetSize(WORLD_MAP_PIN_SIZE, WORLD_MAP_PIN_SIZE)
        pin:EnableMouse(true)

        pin.ring = pin:CreateTexture(nil, "ARTWORK")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetSize(WORLD_MAP_PIN_SIZE + 6, WORLD_MAP_PIN_SIZE + 6)
        pin.ring:SetColorTexture(1.0, 0.82, 0.18, 0.22)

        pin.icon = pin:CreateTexture(nil, "OVERLAY")
        pin.icon:SetPoint("CENTER")
        pin.icon:SetSize(WORLD_MAP_PIN_SIZE - 4, WORLD_MAP_PIN_SIZE - 4)

        pin:SetScript("OnEnter", function(target)
            GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
            GameTooltip:SetText(target.title or target.label or "Collection location", 1, 0.82, 0.18)
            if IsNonEmptyText(target.label) and target.label ~= target.title then
                GameTooltip:AddLine("Location: " .. target.label, 0.86, 0.88, 0.94, true)
            end
            GameTooltip:AddLine(target.coordinates or "", 0.82, 0.86, 0.92)
            if IsNonEmptyText(target.source) then
                GameTooltip:AddLine("Source: " .. target.source, 0.86, 0.88, 0.94, true)
            end
            if IsNonEmptyText(target.acquisition) then
                GameTooltip:AddLine("How to get: " .. target.acquisition, 0.86, 0.88, 0.94, true)
            end
            if IsNonEmptyText(target.effect) then
                GameTooltip:AddLine("Effect: " .. target.effect, 0.86, 0.88, 0.94, true)
            end
            GameTooltip:AddLine("Click to set waypoint.", 1, 0.82, 0.18)
            GameTooltip:Show()
        end)
        pin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        pin:SetScript("OnClick", function(target)
            self:SetUserWaypoint(target.mapID, target.x, target.y)
        end)

        self.worldMapPins[index] = pin
    elseif pin:GetParent() ~= parent then
        pin:SetParent(parent)
    end

    pin:SetFrameLevel((parent:GetFrameLevel() or 0) + 60)
    return pin
end

function CollectionMapWindow:CreateWorldMapControls(worldMap)
    if self.worldMapControls then
        return self.worldMapControls
    end

    local controls = CreateFrame("Frame", "TODOPlannerWorldMapControls", worldMap, "BackdropTemplate")
    controls:SetSize(236, 32)
    controls:SetPoint("TOPRIGHT", worldMap.BorderFrame or worldMap, "TOPRIGHT", -44, -34)
    controls:SetFrameLevel((worldMap:GetFrameLevel() or 0) + 80)
    Widgets:ApplyPanelBackdrop(controls, { 0.02, 0.02, 0.03, 0.88 }, { 1.0, 0.82, 0.18, 0.28 })

    local detailsButton = Widgets:CreateButton(controls, 116, 24, "TODO Details", "primary")
    detailsButton:SetPoint("LEFT", controls, "LEFT", 5, 0)
    detailsButton:SetScript("OnClick", function()
        self:OpenProjectedDetails()
    end)

    local clearButton = Widgets:CreateButton(controls, 104, 24, "Clear Pins", "neutral")
    clearButton:SetPoint("LEFT", detailsButton, "RIGHT", 6, 0)
    clearButton:SetScript("OnClick", function()
        self:ClearWorldMapProjection()
    end)

    controls.detailsButton = detailsButton
    controls.clearButton = clearButton
    controls:Hide()

    self.worldMapControls = controls
    return controls
end

function CollectionMapWindow:HookWorldMap(worldMap)
    if self.worldMapHooksInstalled or not worldMap then
        return
    end

    self.worldMapHooksInstalled = true
    worldMap:HookScript("OnShow", function()
        self:RefreshWorldMapProjection()
    end)
    worldMap:HookScript("OnHide", function()
        self:HideWorldMapPins()
        if self.worldMapControls then
            self.worldMapControls:Hide()
        end
    end)

    if worldMap.SetMapID and hooksecurefunc then
        pcall(hooksecurefunc, worldMap, "SetMapID", function()
            self:RefreshWorldMapProjection()
        end)
    end

    if worldMap.ScrollContainer then
        worldMap.ScrollContainer:HookScript("OnSizeChanged", function()
            self:RefreshWorldMapProjection()
        end)
    end

    self.worldMapEventFrame = CreateFrame("Frame")
    pcall(self.worldMapEventFrame.RegisterEvent, self.worldMapEventFrame, "WORLD_MAP_UPDATE")
    pcall(self.worldMapEventFrame.RegisterEvent, self.worldMapEventFrame, "ZONE_CHANGED_NEW_AREA")
    pcall(self.worldMapEventFrame.RegisterEvent, self.worldMapEventFrame, "PLAYER_ENTERING_WORLD")
    self.worldMapEventFrame:SetScript("OnEvent", function()
        self:RefreshWorldMapProjection()
    end)
end

function CollectionMapWindow:OpenWorldMapToProjectedMap()
    local worldMap = self:LoadWorldMap()
    if not worldMap then
        self:SetStatus("The Blizzard world map is unavailable.")
        return false
    end

    local targetMapID = self.projectedPayload and self.projectedPayload.mapID
    if C_Map and C_Map.OpenWorldMap and targetMapID then
        pcall(C_Map.OpenWorldMap, targetMapID)
    end

    if not worldMap:IsShown() then
        if ToggleWorldMap then
            ToggleWorldMap()
        elseif ShowUIPanel then
            ShowUIPanel(worldMap)
        else
            worldMap:Show()
        end
    end

    if targetMapID and worldMap.SetMapID then
        pcall(worldMap.SetMapID, worldMap, targetMapID)
    end

    self:HookWorldMap(worldMap)
    self:CreateWorldMapControls(worldMap)
    self:RefreshWorldMapProjection()
    if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
            self:RefreshWorldMapProjection()
        end)
    end
    return true
end

function CollectionMapWindow:ProjectToWorldMap()
    if type(self.pins) ~= "table" or #self.pins == 0 then
        self:SetStatus("No curated pins are available to project.")
        return false
    end

    self.projectedPayload = self:CopyProjectionPayload()
    self.projectedPayload.mapID = self.projectedPayload.mapID or (self.projectedPayload.pins[1] and self.projectedPayload.pins[1].mapID)

    if self:OpenWorldMapToProjectedMap() then
        self:SetStatus(string.format("%d TODO pin(s) projected on the Blizzard map.", #self.projectedPayload.pins))
        return true
    end

    return false
end

function CollectionMapWindow:ClearWorldMapProjection()
    self.projectedPayload = nil
    self:HideWorldMapPins()
    if self.worldMapControls then
        self.worldMapControls:Hide()
    end
    self:SetStatus("Projected TODO pins cleared from the Blizzard map.")
end

function CollectionMapWindow:OpenProjectedDetails()
    if not self.projectedPayload then
        return
    end

    self:Open(self.projectedPayload)
end

function CollectionMapWindow:RefreshWorldMapProjection()
    local payload = self.projectedPayload
    local child, worldMap = self:GetWorldMapContent()
    if not payload or not child or not worldMap or not worldMap:IsShown() then
        self:HideWorldMapPins()
        if self.worldMapControls then
            self.worldMapControls:Hide()
        end
        return
    end

    local controls = self:CreateWorldMapControls(worldMap)
    controls:Show()

    local currentMapID = worldMap.GetMapID and worldMap:GetMapID() or payload.mapID
    local width = math.max(child:GetWidth() or 1, 1)
    local height = math.max(child:GetHeight() or 1, 1)
    local pinIndex = 1

    self:HideWorldMapPins()
    for _, pinData in ipairs(payload.pins or {}) do
        if pinData.mapID == currentMapID then
            local pin = self:CreateWorldMapPin(pinIndex, child)
            pin.mapID = pinData.mapID
            pin.x = pinData.x
            pin.y = pinData.y
            pin.title = payload.title
            pin.label = pinData.label
            pin.source = pinData.source or payload.sourceSummary
            pin.acquisition = pinData.acquisition or payload.acquisition
            pin.effect = pinData.effect or payload.effect
            pin.coordinates = self:FormatPinCoordinates(pinData)

            if pinData.icon then
                pin.icon:SetTexture(pinData.icon)
            elseif payload.icon then
                pin.icon:SetTexture(payload.icon)
            else
                pin.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
            end

            pin:ClearAllPoints()
            pin:SetPoint("CENTER", child, "TOPLEFT", (pinData.x or 0) * width, -((pinData.y or 0) * height))
            pin:Show()
            pinIndex = pinIndex + 1
        end
    end
end

function CollectionMapWindow:LoadMapArt(mapID)
    if C_AddOns and C_AddOns.LoadAddOn then
        pcall(C_AddOns.LoadAddOn, "Blizzard_MapCanvas")
    elseif LoadAddOn then
        pcall(LoadAddOn, "Blizzard_MapCanvas")
    end

    if not C_Map or not C_Map.GetMapArtLayers or not C_Map.GetMapArtLayerTextures then
        self:HideTiles()
        self:HideExploredTiles()
        self:SetStatus("C_Map map art APIs are unavailable.")
        return nil
    end

    local layers = C_Map.GetMapArtLayers(mapID)
    local layer = layers and layers[1]
    if not layer then
        self:HideTiles()
        self:HideExploredTiles()
        self:SetStatus("No map art layer for " .. tostring(mapID) .. ".")
        return nil
    end

    local textureFileIDs = C_Map.GetMapArtLayerTextures(mapID, 1)
    if type(textureFileIDs) ~= "table" or #textureFileIDs == 0 then
        self:HideTiles()
        self:HideExploredTiles()
        self:SetStatus("No map tile textures for " .. tostring(mapID) .. ".")
        return nil
    end

    return layer, textureFileIDs
end

function CollectionMapWindow:UpdateCanvasPosition()
    if not self.layer or not self.mapViewport or not self.mapContent then
        return
    end

    local viewportWidth = math.max(self.mapViewport:GetWidth() or 1, 1)
    local viewportHeight = math.max(self.mapViewport:GetHeight() or 1, 1)
    local layerWidth = self.layer.layerWidth or 1
    local layerHeight = self.layer.layerHeight or 1
    local fitScale = math.min(viewportWidth / layerWidth, viewportHeight / layerHeight)
    local scale = fitScale * self:ClampZoom(self.zoom)
    local scaledWidth = layerWidth * scale
    local scaledHeight = layerHeight * scale

    self.currentScale = scale
    self.mapContent:SetSize(scaledWidth, scaledHeight)
    self.mapContent:ClearAllPoints()
    self.mapContent:SetPoint("CENTER", self.mapViewport, "CENTER", self.panX or 0, self.panY or 0)
end

function CollectionMapWindow:RenderTiles()
    if not self.layer or not self.textureFileIDs then
        return
    end

    local layerWidth = self.layer.layerWidth or 1
    local layerHeight = self.layer.layerHeight or 1
    local tileWidth = self.layer.tileWidth or 256
    local tileHeight = self.layer.tileHeight or 256
    local cols = math.ceil(layerWidth / tileWidth)
    local rows = math.ceil(layerHeight / tileHeight)
    local scale = self.currentScale or 1
    local textureIndex = 1

    self:HideTiles()
    for row = 1, rows do
        for col = 1, cols do
            local fileID = self.textureFileIDs[textureIndex]
            if fileID then
                local texture = self:GetTile(textureIndex)
                local remainingWidth = layerWidth - ((col - 1) * tileWidth)
                local remainingHeight = layerHeight - ((row - 1) * tileHeight)
                local width = math.min(tileWidth, remainingWidth)
                local height = math.min(tileHeight, remainingHeight)
                texture:SetTexture(fileID)
                texture:ClearAllPoints()
                texture:SetPoint("TOPLEFT", self.mapContent, "TOPLEFT", (col - 1) * tileWidth * scale, -((row - 1) * tileHeight * scale))
                texture:SetSize(width * scale, height * scale)
                texture:Show()
            end
            textureIndex = textureIndex + 1
        end
    end
end

function CollectionMapWindow:RenderExploredTiles()
    if not self.layer or not self.mapContent then
        return
    end

    self:HideExploredTiles()
    if not C_MapExplorationInfo or not C_MapExplorationInfo.GetExploredMapTextures then
        return
    end

    local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(self.mapID)
    if type(exploredMapTextures) ~= "table" then
        return
    end

    local tileWidth = self.layer.tileWidth or 256
    local tileHeight = self.layer.tileHeight or 256
    local scale = self.currentScale or 1
    local overlayIndex = 1

    for _, exploredTextureInfo in ipairs(exploredMapTextures) do
        local textureWidth = exploredTextureInfo.textureWidth or 0
        local textureHeight = exploredTextureInfo.textureHeight or 0
        local fileDataIDs = exploredTextureInfo.fileDataIDs
        if textureWidth > 0 and textureHeight > 0 and type(fileDataIDs) == "table" then
            local cols = math.ceil(textureWidth / tileWidth)
            local rows = math.ceil(textureHeight / tileHeight)
            for row = 1, rows do
                local texturePixelHeight = row < rows and tileHeight or (textureHeight % tileHeight)
                if texturePixelHeight == 0 then
                    texturePixelHeight = tileHeight
                end
                local textureFileHeight = 16
                while textureFileHeight < texturePixelHeight do
                    textureFileHeight = textureFileHeight * 2
                end

                for col = 1, cols do
                    local texturePixelWidth = col < cols and tileWidth or (textureWidth % tileWidth)
                    if texturePixelWidth == 0 then
                        texturePixelWidth = tileWidth
                    end
                    local textureFileWidth = 16
                    while textureFileWidth < texturePixelWidth do
                        textureFileWidth = textureFileWidth * 2
                    end

                    local fileID = fileDataIDs[((row - 1) * cols) + col]
                    if fileID then
                        local texture = self:GetExploredTile(overlayIndex)
                        texture:SetTexture(fileID, nil, nil, "TRILINEAR")
                        texture:SetTexCoord(0, texturePixelWidth / textureFileWidth, 0, texturePixelHeight / textureFileHeight)
                        texture:ClearAllPoints()
                        texture:SetPoint(
                            "TOPLEFT",
                            self.mapContent,
                            "TOPLEFT",
                            ((exploredTextureInfo.offsetX or 0) + (tileWidth * (col - 1))) * scale,
                            -(((exploredTextureInfo.offsetY or 0) + (tileHeight * (row - 1))) * scale)
                        )
                        texture:SetSize(texturePixelWidth * scale, texturePixelHeight * scale)
                        texture:Show()
                        overlayIndex = overlayIndex + 1
                    end
                end
            end
        end
    end
end

function CollectionMapWindow:RenderPins()
    if not self.layer or not self.mapContent then
        return
    end

    self:HidePins()
    local scale = self.currentScale or 1
    local layerWidth = self.layer.layerWidth or 1
    local layerHeight = self.layer.layerHeight or 1
    local pinIndex = 1
    for _, pinData in ipairs(self.pins or {}) do
        if pinData.mapID == self.mapID then
            local pin = self:GetPin(pinIndex)
            pin.mapID = pinData.mapID
            pin.x = pinData.x
            pin.y = pinData.y
            pin.label = pinData.label
            pin.title = self.title
            pin.source = pinData.source
            pin.acquisition = pinData.acquisition
            pin.effect = pinData.effect
            if pinData.icon then
                pin.icon:SetTexture(pinData.icon)
            elseif self.icon then
                pin.icon:SetTexture(self.icon)
            elseif not pin.icon.SetAtlas or not pcall(pin.icon.SetAtlas, pin.icon, "VignetteLoot", true) then
                pin.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
            end
            pin:ClearAllPoints()
            pin:SetPoint("CENTER", self.mapContent, "TOPLEFT", pinData.x * layerWidth * scale, -(pinData.y * layerHeight * scale))
            pin:Show()
            pinIndex = pinIndex + 1
        end
    end
end

function CollectionMapWindow:RenderMap()
    if not self.frame then
        return
    end

    self.mapTitle:SetText((self.title or self:GetMapName(self.mapID)) .. "  -  " .. self:GetMapName(self.mapID) .. "  #" .. tostring(self.mapID))
    self:RenderDetails()
    local layer, textureFileIDs = self:LoadMapArt(self.mapID)
    self.layer = layer
    self.textureFileIDs = textureFileIDs

    if not layer then
        self.mapContent:Hide()
        return
    end

    self.mapContent:Show()
    self:UpdateCanvasPosition()
    self:RenderTiles()
    self:RenderExploredTiles()
    self:RenderPins()
    local pinCount = #(self.pins or {})
    if self.projectButton then
        Widgets:SetButtonEnabled(self.projectButton, pinCount > 0)
    end

    if pinCount > 0 then
        self:SetStatus(string.format("%d location pin(s). Click a pin to set your user waypoint or project them to the Blizzard map. Zoom %.2fx", pinCount, self.zoom or 1))
    else
        self:SetStatus(string.format("No curated waypoint pins yet. Showing details with fallback map. Zoom %.2fx", self.zoom or 1))
    end
end

function CollectionMapWindow:AdjustZoom(delta)
    self.zoom = self:ClampZoom((self.zoom or 1) + delta)
    self:RenderMap()
end

function CollectionMapWindow:ResetView()
    self.zoom = 1
    self.panX = 0
    self.panY = 0
    self:RenderMap()
end

function CollectionMapWindow:OpenTest()
    self:Open({
        mapID = DEFAULT_MAP_ID,
        pins = {
            {
                mapID = DEFAULT_MAP_ID,
                x = DEFAULT_PIN_X / 100,
                y = DEFAULT_PIN_Y / 100,
                label = "Goretooth / Nagrand test pin",
            },
        },
    })
end

function CollectionMapWindow:Open(options)
    if not self.frame then
        self:Build()
    end

    options = options or {}
    if IsCollectionType(options.collectionType) and #(options.pins or {}) == 0 then
        self:SetStatus("No curated map location is available for this collection entry.")
        return
    end

    self.title = options.title
    self.collectionType = options.collectionType
    self.sourceSummary = options.sourceSummary
    self.acquisition = options.acquisition
    self.effect = options.effect
    self.waypoints = options.waypoints
    self.icon = options.icon
    self.pins = options.pins or self.pins or {}
    self.mapID = options.mapID or (self.pins[1] and self.pins[1].mapID) or self:GetDefaultMapID()
    self.zoom = 1
    self.panX = 0
    self.panY = 0
    self.frame:Show()
    if TDP.Theme then
        TDP.Theme:BringToFront(self.frame)
    end
    self:RenderMap()
end

function CollectionMapWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerCollectionMapFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(900, 560)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
    end)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Collection Map")
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerCollectionMapFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
    end

    local toolbar = Widgets:CreatePanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", body, "TOPRIGHT", -12, -12)
    toolbar:SetHeight(42)

    local mapTitle = toolbar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mapTitle:SetPoint("LEFT", toolbar, "LEFT", 12, 0)
    mapTitle:SetPoint("RIGHT", toolbar, "RIGHT", -284, 0)
    mapTitle:SetJustifyH("LEFT")
    if mapTitle.SetWordWrap then
        mapTitle:SetWordWrap(false)
    end

    local zoomOutButton = Widgets:CreateButton(toolbar, 28, 24, "-", "neutral")
    zoomOutButton:SetPoint("RIGHT", toolbar, "RIGHT", -132, 0)

    local projectButton = Widgets:CreateButton(toolbar, 96, 24, "Project", "primary")
    projectButton:SetPoint("RIGHT", zoomOutButton, "LEFT", -8, 0)

    local resetButton = Widgets:CreateButton(toolbar, 72, 24, "Reset", "neutral")
    resetButton:SetPoint("LEFT", zoomOutButton, "RIGHT", 6, 0)

    local zoomInButton = Widgets:CreateButton(toolbar, 28, 24, "+", "neutral")
    zoomInButton:SetPoint("LEFT", resetButton, "RIGHT", 6, 0)

    local mapViewport = Widgets:CreatePanel(body, "input", "inputBorder")
    mapViewport:SetPoint("TOPLEFT", toolbar, "BOTTOMLEFT", 0, -10)
    mapViewport:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -286, 42)
    mapViewport:EnableMouse(true)
    mapViewport:EnableMouseWheel(true)
    if mapViewport.SetClipsChildren then
        mapViewport:SetClipsChildren(true)
    end

    local mapContent = CreateFrame("Frame", nil, mapViewport)
    mapContent:SetPoint("CENTER", mapViewport, "CENTER")
    mapContent:SetSize(1, 1)

    local detailPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    detailPanel:SetPoint("TOPLEFT", mapViewport, "TOPRIGHT", 10, 0)
    detailPanel:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -12, 42)
    detailPanel.topAccent = Widgets:AddGoldTopAccent(detailPanel, 2, 0.18)

    local detailIcon = detailPanel:CreateTexture(nil, "ARTWORK")
    detailIcon:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -14)
    detailIcon:SetSize(42, 42)

    local detailTitle = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    detailTitle:SetPoint("TOPLEFT", detailIcon, "TOPRIGHT", 10, -2)
    detailTitle:SetPoint("RIGHT", detailPanel, "RIGHT", -12, 0)
    detailTitle:SetJustifyH("LEFT")
    if detailTitle.SetWordWrap then
        detailTitle:SetWordWrap(true)
    end

    local detailMeta = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    detailMeta:SetPoint("TOPLEFT", detailTitle, "BOTTOMLEFT", 0, -6)
    detailMeta:SetPoint("RIGHT", detailTitle, "RIGHT", 0, 0)
    detailMeta:SetJustifyH("LEFT")

    local detailScroll = CreateFrame("ScrollFrame", nil, detailPanel, "UIPanelScrollFrameTemplate")
    detailScroll:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -68)
    detailScroll:SetPoint("BOTTOMRIGHT", detailPanel, "BOTTOMRIGHT", -28, 12)

    local detailContent = CreateFrame("Frame", nil, detailScroll)
    detailContent:SetSize(1, 1)
    detailScroll:SetScrollChild(detailContent)

    local detailText = detailContent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    detailText:SetPoint("TOPLEFT", detailContent, "TOPLEFT", 0, 0)
    detailText:SetPoint("TOPRIGHT", detailContent, "TOPRIGHT", 0, 0)
    Widgets:ConfigurePreviewDetailText(detailText)

    detailPanel:SetScript("OnSizeChanged", function()
        Widgets:UpdateScrollablePreviewText(detailScroll, detailContent, detailText, detailText.rawPreviewText)
    end)

    local statusText = body:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    statusText:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 18, 18)
    statusText:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -18, 18)
    statusText:SetJustifyH("LEFT")

    mapViewport:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustZoom(delta > 0 and ZOOM_STEP or -ZOOM_STEP)
    end)

    mapViewport:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" or type(GetCursorPosition) ~= "function" then
            return
        end
        self.dragging = true
        self.dragX, self.dragY = GetCursorPosition()
    end)

    mapViewport:SetScript("OnMouseUp", function()
        self.dragging = false
    end)

    mapViewport:SetScript("OnHide", function()
        self.dragging = false
    end)

    mapViewport:SetScript("OnUpdate", function()
        if not self.dragging or type(GetCursorPosition) ~= "function" then
            return
        end

        local cursorX, cursorY = GetCursorPosition()
        local previousX = self.dragX or cursorX
        local previousY = self.dragY or cursorY
        self.dragX, self.dragY = cursorX, cursorY
        self.panX = (self.panX or 0) + (cursorX - previousX)
        self.panY = (self.panY or 0) + (cursorY - previousY)
        self:UpdateCanvasPosition()
    end)

    mapViewport:SetScript("OnSizeChanged", function()
        self:RenderMap()
    end)

    zoomOutButton:SetScript("OnClick", function()
        self:AdjustZoom(-ZOOM_STEP)
    end)

    zoomInButton:SetScript("OnClick", function()
        self:AdjustZoom(ZOOM_STEP)
    end)

    resetButton:SetScript("OnClick", function()
        self:ResetView()
    end)

    projectButton:SetScript("OnClick", function()
        self:ProjectToWorldMap()
    end)

    self.frame = frame
    self.body = body
    self.mapTitle = mapTitle
    self.mapViewport = mapViewport
    self.mapContent = mapContent
    self.detailPanel = detailPanel
    self.detailIcon = detailIcon
    self.detailTitle = detailTitle
    self.detailMeta = detailMeta
    self.detailScroll = detailScroll
    self.detailContent = detailContent
    self.detailText = detailText
    self.statusText = statusText
    self.zoomOutButton = zoomOutButton
    self.zoomInButton = zoomInButton
    self.resetButton = resetButton
    self.projectButton = projectButton

    frame:Hide()
    return self
end

TDP.CollectionMapWindow = CollectionMapWindow
