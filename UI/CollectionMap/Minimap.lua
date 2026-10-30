local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local MINIMAP_PIN_BASE_SIZE = CollectionMapWindow.Config.MINIMAP_PIN_BASE_SIZE
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates

function CollectionMapWindow:HideMinimapPins()
    local library = self:GetMapPinLibrary()
    if library then
        library:RemoveAllMinimapIcons(self)
    end
    for _, pin in ipairs(self.minimapPins or {}) do
        pin:Hide()
    end
end

function CollectionMapWindow:ApplyMinimapPinSize(pin)
    local size = MINIMAP_PIN_BASE_SIZE
    pin:SetSize(size, size)
    if pin.icon then
        pin.icon:SetSize(size - 2, size - 2)
    end
    if pin.ring then
        pin.ring:SetSize(size + 2, size + 2)
    end
end

function CollectionMapWindow:CreateMinimapPin(index)
    local library = self:GetMapPinLibrary()
    local minimap = library and library.Minimap or Minimap
    self.minimapPins = self.minimapPins or {}
    local pin = self.minimapPins[index]
    if not pin then
        pin = CreateFrame("Button", nil, minimap)
        pin:EnableMouse(true)
        pin:RegisterForClicks("LeftButtonUp")

        pin.icon = pin:CreateTexture(nil, "ARTWORK")
        pin.icon:SetPoint("CENTER")
        pin.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

        pin.mask = pin:CreateMaskTexture()
        pin.mask:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        pin.mask:SetAllPoints(pin.icon)
        pin.icon:AddMaskTexture(pin.mask)

        pin.ring = pin:CreateTexture(nil, "OVERLAY")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetAtlas("worldquest-icon-ring")

        pin:SetScript("OnEnter", function(target)
            self:ShowWorldMapPinTooltip(target)
        end)
        pin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        pin:SetScript("OnClick", function(target)
            self:SetUserWaypoint(target.mapID, target.x, target.y)
        end)
        pin:Hide()

        self.minimapPins[index] = pin
    end

    pin.isMinimapPin = true
    pin:SetParent(minimap)
    pin:SetFrameLevel((minimap:GetFrameLevel() or 0) + 5)
    self:ApplyMinimapPinSize(pin)
    return pin
end

function CollectionMapWindow:RefreshMinimapProjection()
    self:HideMinimapPins()
    local library = self:GetMapPinLibrary()
    if #self.projectedPayloads == 0 or not library or not Minimap then
        return
    end

    local pinIndex = 1
    for pinData, payload in self:EnumerateProjectedPins() do
        local mapID = tonumber(pinData.mapID)
        local x, y = GetPinCoordinates(pinData)
        if mapID and mapID > 0 and x and y then
            local pin = self:CreateMinimapPin(pinIndex)
            self:ConfigureWorldMapPin(pin, {
                mapID = mapID,
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
            -- HBD owns range, zoom, rotation, shape, and zone visibility. Distant
            -- collection pins hide instead of accumulating on the minimap rim.
            if library:AddMinimapIconMap(self, pin, mapID, x, y, false, false) then
                pinIndex = pinIndex + 1
            end
        end
    end
end
