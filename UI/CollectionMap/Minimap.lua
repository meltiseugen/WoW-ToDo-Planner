local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local MINIMAP_PIN_BASE_SIZE = CollectionMapWindow.Config.MINIMAP_PIN_BASE_SIZE
local MINIMAP_PIN_EDGE_PADDING = CollectionMapWindow.Config.MINIMAP_PIN_EDGE_PADDING
local MINIMAP_UPDATE_INTERVAL = CollectionMapWindow.Config.MINIMAP_UPDATE_INTERVAL
local MINIMAP_NORMALIZED_EDGE_DISTANCE = CollectionMapWindow.Config.MINIMAP_NORMALIZED_EDGE_DISTANCE
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates
local PinMatchesMap = CollectionMapWindow.Helpers.PinMatchesMap

function CollectionMapWindow:HideMinimapPins()
    for _, pin in ipairs(self.minimapPins or {}) do
        pin:Hide()
    end
    if self.minimapFrame then
        self.minimapFrame:Hide()
    end
end

function CollectionMapWindow:ApplyMinimapPinSize(pin)
    local size = MINIMAP_PIN_BASE_SIZE
    pin:SetSize(size, size)
    if pin.icon then
        pin.icon:SetSize(size - 6, size - 6)
    end
    if pin.ring then
        pin.ring:SetSize(size + 8, size + 8)
    end
end

function CollectionMapWindow:CreateMinimapPin(index)
    self.minimapPins = self.minimapPins or {}
    local pin = self.minimapPins[index]
    if not pin then
        pin = CreateFrame("Button", nil, Minimap, "BackdropTemplate")
        pin:EnableMouse(true)
        if pin.SetIgnoreParentScale then
            pin:SetIgnoreParentScale(true)
        end

        pin.ring = pin:CreateTexture(nil, "ARTWORK")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetColorTexture(1.0, 0.82, 0.18, 0.24)

        pin.icon = pin:CreateTexture(nil, "OVERLAY")
        pin.icon:SetPoint("CENTER")

        pin:SetScript("OnEnter", function(target)
            self:ShowWorldMapPinTooltip(target)
        end)
        pin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        pin:SetScript("OnClick", function(target)
            self:SetUserWaypoint(target.mapID, target.x, target.y)
        end)

        self.minimapPins[index] = pin
    end

    pin.isMinimapPin = true
    pin:SetParent(Minimap)
    pin:SetFrameLevel((Minimap:GetFrameLevel() or 0) + 30)
    self:ApplyMinimapPinSize(pin)
    return pin
end

function CollectionMapWindow:GetPlayerMapPosition(mapID)
    if not C_Map or not C_Map.GetPlayerMapPosition then
        return nil, nil
    end

    local ok, position = pcall(C_Map.GetPlayerMapPosition, mapID, "player")
    if not ok or not position or type(position.GetXY) ~= "function" then
        return nil, nil
    end

    local x, y = position:GetXY()
    if not x or not y or (x == 0 and y == 0) then
        return nil, nil
    end
    return x, y
end

function CollectionMapWindow:GetBestPlayerMapID()
    if C_Map and C_Map.GetBestMapForUnit then
        local ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
        if ok and mapID then
            return mapID
        end
    end
    return nil
end

function CollectionMapWindow:EnsureMinimapProjectionFrame()
    if self.minimapFrame or not Minimap then
        return self.minimapFrame
    end

    local frame = CreateFrame("Frame", "TODOPlannerMinimapProjectionFrame", Minimap)
    frame:SetAllPoints(Minimap)
    frame:SetFrameLevel((Minimap:GetFrameLevel() or 0) + 20)
    frame:SetScript("OnUpdate", function(_, elapsed)
        self.minimapElapsed = (self.minimapElapsed or 0) + (elapsed or 0)
        if self.minimapElapsed < MINIMAP_UPDATE_INTERVAL then
            return
        end
        self.minimapElapsed = 0
        self:RefreshMinimapProjection()
    end)
    frame:Hide()

    self.minimapFrame = frame
    return frame
end

function CollectionMapWindow:RefreshMinimapProjection()
    local payload = self.projectedPayload
    local frame = self:EnsureMinimapProjectionFrame()
    if not payload or not frame or not Minimap then
        self:HideMinimapPins()
        return
    end

    local playerMapID = self:GetBestPlayerMapID()
    local playerX, playerY = playerMapID and self:GetPlayerMapPosition(playerMapID)
    if not playerMapID or not playerX or not playerY then
        for _, pin in ipairs(self.minimapPins or {}) do
            pin:Hide()
        end
        frame:Show()
        return
    end

    local radius = (math.min(Minimap:GetWidth() or 140, Minimap:GetHeight() or 140) * 0.5) - MINIMAP_PIN_EDGE_PADDING
    local pinIndex = 1
    for _, pinData in ipairs(payload.pins or {}) do
        if PinMatchesMap(pinData, playerMapID) then
            local x, y = GetPinCoordinates(pinData)
            if x and y then
                local dx = x - playerX
                local dy = y - playerY
                local distance = math.sqrt((dx * dx) + (dy * dy))
                local angle
                if math.atan2 then
                    angle = math.atan2(-dy, dx)
                else
                    angle = math.atan(-dy, dx)
                end
                if GetCVar and GetCVar("rotateMinimap") == "1" and GetPlayerFacing then
                    local facing = GetPlayerFacing()
                    if facing then
                        angle = angle + facing
                    end
                end
                local offsetDistance = math.min(distance / MINIMAP_NORMALIZED_EDGE_DISTANCE, 1) * radius
                local pin = self:CreateMinimapPin(pinIndex)
                self:ConfigureWorldMapPin(pin, {
                    mapID = pinData.mapID,
                    mapName = pinData.mapName,
                    x = x,
                    y = y,
                    label = pinData.label,
                    source = pinData.source,
                    acquisition = pinData.acquisition,
                    effect = pinData.effect,
                    tips = pinData.tips,
                    icon = pinData.icon,
                    criterionAchievementId = pinData.criterionAchievementId,
                    criterionIndex = pinData.criterionIndex,
                    criterionCompleted = pinData.criterionCompleted,
                    criterionText = pinData.criterionText,
                }, payload)
                pin:ClearAllPoints()
                pin:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * offsetDistance, math.sin(angle) * offsetDistance)
                pin:Show()
                pinIndex = pinIndex + 1
            end
        end
    end

    for index = pinIndex, #(self.minimapPins or {}) do
        self.minimapPins[index]:Hide()
    end
    frame:Show()
end
