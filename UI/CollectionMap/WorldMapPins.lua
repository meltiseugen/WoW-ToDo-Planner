local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local WORLD_MAP_PIN_BASE_SIZE = CollectionMapWindow.Config.WORLD_MAP_PIN_BASE_SIZE
local WORLD_MAP_PIN_DEFAULT_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_DEFAULT_SCALE
local WORLD_MAP_PIN_MIN_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_MIN_SCALE
local WORLD_MAP_PIN_MAX_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_MAX_SCALE
local IsNonEmptyText = CollectionMapWindow.Helpers.IsNonEmptyText

function CollectionMapWindow:GetMapPinLibrary()
    return LibStub and LibStub("HereBeDragons-Pins-2.0", true)
end

function CollectionMapWindow:GetWorldMapPinScale()
    local settings = TODOPlannerDB and TODOPlannerDB.settings
    local scale = settings and tonumber(settings.worldMapPinScale) or WORLD_MAP_PIN_DEFAULT_SCALE
    if scale < WORLD_MAP_PIN_MIN_SCALE then
        return WORLD_MAP_PIN_MIN_SCALE
    elseif scale > WORLD_MAP_PIN_MAX_SCALE then
        return WORLD_MAP_PIN_MAX_SCALE
    end
    return scale
end

function CollectionMapWindow:GetWorldMapPinSize()
    return math.floor((WORLD_MAP_PIN_BASE_SIZE * self:GetWorldMapPinScale()) + 0.5)
end

function CollectionMapWindow:ApplyWorldMapPinSize(pin)
    local size = self:GetWorldMapPinSize()
    pin:SetSize(size, size)
    local icon = pin.icon or pin.Icon
    if icon then
        icon:SetSize(math.max(size - 8, 12), math.max(size - 8, 12))
    end
    local ring = pin.ring or pin.Ring
    if ring then
        ring:SetSize(size + 10, size + 10)
    end
end

function CollectionMapWindow:HideWorldMapPins()
    local library = self:GetMapPinLibrary()
    if library then
        library:RemoveAllWorldMapIcons(self)
    end
    for _, pin in ipairs(self.worldMapPins or {}) do
        pin:Hide()
    end
end

function CollectionMapWindow:ShowWorldMapPinTooltip(pin)
    GameTooltip:SetOwner(pin, "ANCHOR_RIGHT")
    GameTooltip:SetText(pin.title or pin.label or "Collection location", 1, 0.82, 0.18)
    if IsNonEmptyText(pin.label) and pin.label ~= pin.title then
        GameTooltip:AddLine("Location: " .. pin.label, 0.86, 0.88, 0.94, true)
    end
    if pin.criterionIndex then
        local criterionLabel = pin.criterionText or ("Achievement criterion " .. tostring(pin.criterionIndex))
        local marker = pin.criterionCompleted and "[Done] " or "[ ] "
        GameTooltip:AddLine(marker .. criterionLabel, 0.72, 0.86, 0.72, true)
    end
    GameTooltip:AddLine(pin.coordinates or "", 0.82, 0.86, 0.92)
    if IsNonEmptyText(pin.source) then
        GameTooltip:AddLine("Source: " .. pin.source, 0.86, 0.88, 0.94, true)
    end
    if IsNonEmptyText(pin.acquisition) then
        GameTooltip:AddLine("How to get: " .. pin.acquisition, 0.86, 0.88, 0.94, true)
    end
    if IsNonEmptyText(pin.effect) then
        GameTooltip:AddLine("Effect: " .. pin.effect, 0.86, 0.88, 0.94, true)
    end
    if IsNonEmptyText(pin.tips) then
        GameTooltip:AddLine("Tips: " .. pin.tips, 0.86, 0.88, 0.94, true)
    end
    GameTooltip:AddLine("Click to set waypoint.", 1, 0.82, 0.18)
    GameTooltip:Show()
end

function CollectionMapWindow:ConfigureWorldMapPin(pin, pinData, payload)
    pin.mapID = pinData.mapID
    pin.mapName = pinData.mapName
    pin.x = pinData.x
    pin.y = pinData.y
    pin.title = payload.title
    pin.label = pinData.label
    pin.source = pinData.source or payload.sourceSummary
    pin.acquisition = pinData.acquisition or payload.acquisition
    pin.effect = pinData.effect or payload.effect
    pin.tips = pinData.tips or payload.tips
    pin.criterionAchievementId = pinData.criterionAchievementId
    pin.criterionIndex = pinData.criterionIndex
    pin.criterionCompleted = pinData.criterionCompleted
    pin.criterionText = pinData.criterionText
    pin.coordinates = self:FormatPinCoordinates(pinData)

    local icon = pin.icon or pin.Icon
    if icon then
        if pinData.icon then
            icon:SetTexture(pinData.icon)
        elseif payload.icon then
            icon:SetTexture(payload.icon)
        else
            icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
        end
        if icon.SetVertexColor then
            icon:SetVertexColor(1, 1, 1, 1)
        end
        icon:Show()
    end

    local ring = pin.ring or pin.Ring
    if ring then
        if ring.SetVertexColor then
            ring:SetVertexColor(1.0, 0.82, 0.18, 0.9)
        end
        ring:Show()
    end

    if pin.isMinimapPin then
        self:ApplyMinimapPinSize(pin)
    else
        self:ApplyWorldMapPinSize(pin)
    end
end

function CollectionMapWindow:CreateWorldMapPin(index)
    self.worldMapPins = self.worldMapPins or {}
    local pin = self.worldMapPins[index]
    if not pin then
        pin = CreateFrame("Button", nil, UIParent)
        pin:EnableMouse(true)
        pin:RegisterForClicks("LeftButtonUp")
        if pin.SetIgnoreParentScale then
            pin:SetIgnoreParentScale(true)
        end

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

        self.worldMapPins[index] = pin
    end

    self:ApplyWorldMapPinSize(pin)
    return pin
end
