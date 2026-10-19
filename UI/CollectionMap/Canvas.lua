local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local Widgets = TDP.Widgets
local COLLECTION_MAP_PIN_SIZE = CollectionMapWindow.Config.COLLECTION_MAP_PIN_SIZE
local COLLECTION_MAP_PIN_ICON_SIZE = CollectionMapWindow.Config.COLLECTION_MAP_PIN_ICON_SIZE
local COLLECTION_MAP_PIN_RING_SIZE = CollectionMapWindow.Config.COLLECTION_MAP_PIN_RING_SIZE
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates
local PinMatchesMap = CollectionMapWindow.Helpers.PinMatchesMap

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
        pin:SetSize(COLLECTION_MAP_PIN_SIZE, COLLECTION_MAP_PIN_SIZE)
        pin:EnableMouse(true)
        pin:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        pin.icon = pin:CreateTexture(nil, "OVERLAY")
        pin.icon:SetPoint("CENTER")
        pin.icon:SetSize(COLLECTION_MAP_PIN_ICON_SIZE, COLLECTION_MAP_PIN_ICON_SIZE)
        pin.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
        pin.icon:SetTexCoord(0, 1, 0, 1)
        pin.ring = pin:CreateTexture(nil, "ARTWORK")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetSize(COLLECTION_MAP_PIN_RING_SIZE, COLLECTION_MAP_PIN_RING_SIZE)
        pin.ring:SetColorTexture(1.0, 0.82, 0.18, 0.18)
        pin:SetScript("OnEnter", function(target)
            self:ShowWorldMapPinTooltip(target)
        end)
        pin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        pin:SetScript("OnClick", function(target, button)
            if button == "RightButton" then
                self:NavigateToParentMap()
                return
            end
            self:SetUserWaypoint(target.mapID, target.x, target.y)
        end)
        self.pinFrames[index] = pin
    end
    return pin
end

function CollectionMapWindow:ApplyCollectionMapPinSize(pin, mapScale)
    mapScale = tonumber(mapScale) or 1
    if mapScale <= 0 then
        mapScale = 1
    end

    -- The pin must keep its parent's scale so its anchor offsets remain in the
    -- map art's coordinate system. Compensate only its dimensions to keep the
    -- visible marker a constant size as the map zoom changes.
    local sizeScale = 1 / mapScale
    pin:SetScale(1)
    pin:SetSize(COLLECTION_MAP_PIN_SIZE * sizeScale, COLLECTION_MAP_PIN_SIZE * sizeScale)
    pin.icon:SetSize(COLLECTION_MAP_PIN_ICON_SIZE * sizeScale, COLLECTION_MAP_PIN_ICON_SIZE * sizeScale)
    pin.ring:SetSize(COLLECTION_MAP_PIN_RING_SIZE * sizeScale, COLLECTION_MAP_PIN_RING_SIZE * sizeScale)
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

    self.currentScale = scale
    -- Keep child positions in raw map pixels; the content frame owns zoom/fill scaling.
    self.mapContent:SetScale(scale)
    self.mapContent:SetSize(layerWidth, layerHeight)
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
                texture:SetPoint("TOPLEFT", self.mapContent, "TOPLEFT", (col - 1) * tileWidth, -((row - 1) * tileHeight))
                texture:SetSize(width, height)
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
                            (exploredTextureInfo.offsetX or 0) + (tileWidth * (col - 1)),
                            -((exploredTextureInfo.offsetY or 0) + (tileHeight * (row - 1)))
                        )
                        texture:SetSize(texturePixelWidth, texturePixelHeight)
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
        return 0, 0
    end

    self:HidePins()
    local scale = self.currentScale or 1
    local layerWidth = self.layer.layerWidth or 1
    local layerHeight = self.layer.layerHeight or 1
    local pinIndex = 1
    local totalPins = 0
    for _, pinData in ipairs(self:GetVisiblePins()) do
        if PinMatchesMap(pinData, self.mapID) then
            totalPins = totalPins + 1
            local x, y = GetPinCoordinates(pinData)
            if x and y then
                local pin = self:GetPin(pinIndex)
                pin.mapID = pinData.mapID
                pin.mapName = pinData.mapName
                pin.x = x
                pin.y = y
                pin.label = pinData.label
                pin.title = self.title
                pin.source = pinData.source
                pin.acquisition = pinData.acquisition
                pin.effect = pinData.effect
                pin.tips = pinData.tips
                pin.criterionAchievementId = pinData.criterionAchievementId
                pin.criterionIndex = pinData.criterionIndex
                pin.criterionCompleted = pinData.criterionCompleted
                pin.criterionText = pinData.criterionText
                pin.coordinates = self:FormatPinCoordinates(pinData)
                if pinData.icon then
                    pin.icon:SetTexture(pinData.icon)
                elseif self.icon then
                    pin.icon:SetTexture(self.icon)
                elseif not pin.icon.SetAtlas or not pcall(pin.icon.SetAtlas, pin.icon, "VignetteLoot", true) then
                    pin.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
                end
                -- SetAtlas changes texture coordinates. Reset them whenever a
                -- normal icon texture is used or it can render as an empty crop.
                if pinData.icon or self.icon then
                    pin.icon:SetTexCoord(0, 1, 0, 1)
                end
                pin.icon:SetVertexColor(1, 1, 1, 1)
                pin.icon:SetAlpha(1)
                pin.icon:Show()
                pin.ring:Show()
                pin:ClearAllPoints()
                self:ApplyCollectionMapPinSize(pin, scale)
                pin:SetFrameLevel((self.mapContent:GetFrameLevel() or 0) + 40)
                pin:SetPoint("CENTER", self.mapContent, "TOPLEFT", x * layerWidth, -(y * layerHeight))
                pin:Show()
                pinIndex = pinIndex + 1
            end
        end
    end
    return pinIndex - 1, totalPins
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
    local renderedPinCount, pinCount = self:RenderPins()
    local allPinCount = 0
    for _, pinData in ipairs(self.pins or {}) do
        if PinMatchesMap(pinData, self.mapID) then
            allPinCount = allPinCount + 1
        end
    end
    local hiddenCompletedPinCount = math.max(allPinCount - pinCount, 0)
    if self.projectButton then
        Widgets:SetButtonEnabled(self.projectButton, renderedPinCount > 0)
    end

    if hiddenCompletedPinCount > 0 and pinCount == 0 then
        self:SetStatus(string.format("All %d completed location pin(s) are hidden. Enable Show completed to display them. Zoom %.2fx", hiddenCompletedPinCount, self.zoom or 1))
    elseif hiddenCompletedPinCount > 0 and renderedPinCount > 0 then
        self:SetStatus(string.format("%d incomplete location pin(s) rendered; %d completed hidden. Click a pin to set a waypoint. Zoom %.2fx", renderedPinCount, hiddenCompletedPinCount, self.zoom or 1))
    elseif pinCount > 0 and renderedPinCount > 0 then
        self:SetStatus(string.format("%d of %d location pin(s) rendered. Click a pin to set your user waypoint or project them to the Blizzard map. Zoom %.2fx", renderedPinCount, pinCount, self.zoom or 1))
    elseif pinCount > 0 then
        self:SetStatus(string.format("%d of %d location pin(s) rendered. Valid coordinates are required before pins can be used as waypoints. Zoom %.2fx", renderedPinCount, pinCount, self.zoom or 1))
    else
        self:SetStatus(string.format("No curated waypoint pins yet. Showing details with fallback map. Zoom %.2fx", self.zoom or 1))
    end
end
