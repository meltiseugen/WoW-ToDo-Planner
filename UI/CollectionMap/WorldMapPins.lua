local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local WORLD_MAP_PIN_BASE_SIZE = CollectionMapWindow.Config.WORLD_MAP_PIN_BASE_SIZE
local WORLD_MAP_PIN_DEFAULT_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_DEFAULT_SCALE
local WORLD_MAP_PIN_MIN_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_MIN_SCALE
local WORLD_MAP_PIN_MAX_SCALE = CollectionMapWindow.Config.WORLD_MAP_PIN_MAX_SCALE
local WORLD_MAP_PIN_TEMPLATE = CollectionMapWindow.Config.WORLD_MAP_PIN_TEMPLATE
local IsNonEmptyText = CollectionMapWindow.Helpers.IsNonEmptyText
local CopyTableContents = CollectionMapWindow.Helpers.CopyTableContents
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates
local PinMatchesMap = CollectionMapWindow.Helpers.PinMatchesMap

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

function CollectionMapWindow:HideLegacyWorldMapPins()
    for _, pin in ipairs(self.worldMapPins or {}) do
        pin:Hide()
    end
end

function CollectionMapWindow:HideWorldMapPins()
    self:HideLegacyWorldMapPins()
    if self.worldMapDataProvider and self.worldMapDataProvider.RemoveAllData then
        self.worldMapDataProvider:RemoveAllData()
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

function CollectionMapWindow:CreateWorldMapPin(index, parent)
    self.worldMapPins = self.worldMapPins or {}
    local pin = self.worldMapPins[index]
    if not pin then
        pin = CreateFrame("Button", nil, parent, "BackdropTemplate")
        pin:EnableMouse(true)
        if pin.SetIgnoreParentScale then
            pin:SetIgnoreParentScale(true)
        end

        pin.ring = pin:CreateTexture(nil, "ARTWORK")
        pin.ring:SetPoint("CENTER")
        pin.ring:SetColorTexture(1.0, 0.82, 0.18, 0.22)

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

        self.worldMapPins[index] = pin
    elseif pin:GetParent() ~= parent then
        pin:SetParent(parent)
    end

    pin:SetFrameLevel((parent:GetFrameLevel() or 0) + 60)
    self:ApplyWorldMapPinSize(pin)
    return pin
end

function CollectionMapWindow:EnsureWorldMapProjectionMixins()
    self:LoadWorldMap()
    if type(CreateFromMixins) ~= "function" or not MapCanvasPinMixin or not MapCanvasDataProviderMixin then
        return false
    end

    if not _G.TODOPlannerWorldMapPinMixin or _G.TODOPlannerWorldMapPinMixin.todoPlannerReady ~= true then
        local pinMixin = CreateFromMixins(MapCanvasPinMixin)
        pinMixin.todoPlannerReady = true

        function pinMixin.OnLoad(pin)
            if pin.UseFrameLevelType then
                pin:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
            end
            if pin.SetScalingLimits then
                pin:SetScalingLimits(1, 1.0, 1.2)
            end
            if pin.RegisterForClicks then
                pin:RegisterForClicks("LeftButtonUp")
            end
            if pin.SetIgnoreGlobalPinScale then
                pin:SetIgnoreGlobalPinScale(true)
            end
        end

        function pinMixin.OnAcquired(pin, dataProvider, pinData)
            pin.dataProvider = dataProvider
            pin.pinData = pinData
            if pin.SetMouseClickEnabled then
                pin:SetMouseClickEnabled(true)
            end
            if pin.SetMouseMotionEnabled then
                pin:SetMouseMotionEnabled(true)
            end
            if pin.SetIgnoreGlobalPinScale then
                pin:SetIgnoreGlobalPinScale(true)
            end
            if dataProvider and dataProvider.addon and dataProvider.payload then
                dataProvider.addon:ConfigureWorldMapPin(pin, pinData, dataProvider.payload)
            end
            pin:Show()
        end

        function pinMixin.OnReleased(pin)
            if MapCanvasPinMixin.OnReleased then
                MapCanvasPinMixin.OnReleased(pin)
            end
            pin.dataProvider = nil
            pin.pinData = nil
        end

        function pinMixin.OnMouseEnter(pin)
            if pin.dataProvider and pin.dataProvider.addon then
                pin.dataProvider.addon:ShowWorldMapPinTooltip(pin)
            end
        end

        function pinMixin.OnMouseLeave()
            GameTooltip:Hide()
        end

        function pinMixin.OnMouseClickAction(pin, button)
            if button ~= "LeftButton" or not pin.dataProvider or not pin.dataProvider.addon then
                return
            end
            pin.dataProvider.addon:SetUserWaypoint(pin.mapID, pin.x, pin.y)
        end

        function pinMixin.ShouldMouseButtonBePassthrough(_, button)
            return button == "RightButton"
        end

        CopyTableContents(_G.TODOPlannerWorldMapPinMixin, pinMixin)
    end

    if not _G.TODOPlannerWorldMapDataProviderMixin
        or _G.TODOPlannerWorldMapDataProviderMixin.todoPlannerReady ~= true then
        local providerMixin = CreateFromMixins(MapCanvasDataProviderMixin)
        providerMixin.todoPlannerReady = true

        function providerMixin.RemoveAllData(provider)
            local map = provider:GetMap()
            if map and map.RemoveAllPinsByTemplate then
                map:RemoveAllPinsByTemplate(WORLD_MAP_PIN_TEMPLATE)
            elseif map and map.RemovePin then
                for _, pin in ipairs(provider.acquiredPins or {}) do
                    map:RemovePin(pin)
                end
            end
            for _, pin in ipairs(provider.acquiredPins or {}) do
                if pin and pin.Hide then
                    pin:Hide()
                end
            end
            provider.acquiredPins = {}
        end

        function providerMixin.RefreshAllData(provider)
            provider:RemoveAllData()
            local map = provider:GetMap()
            local payload = provider.addon and provider.addon.projectedPayload
            if not map or not map.GetMapID or not payload then
                return
            end

            local currentMapID = map:GetMapID()
            if not currentMapID then
                return
            end

            provider.payload = payload
            provider.acquiredPins = {}
            for _, pinData in ipairs(payload.pins or {}) do
                if PinMatchesMap(pinData, currentMapID) then
                    local x, y = GetPinCoordinates(pinData)
                    if x and y then
                        local projectedPinData = {
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
                        }
                        local pin = map:AcquirePin(WORLD_MAP_PIN_TEMPLATE, provider, projectedPinData)
                        pin:SetPosition(x, y)
                        provider.acquiredPins[#provider.acquiredPins + 1] = pin
                    end
                end
            end
        end

        function providerMixin.OnMapChanged(provider)
            provider:RefreshAllData()
        end

        function providerMixin.OnShow(provider)
            provider:RefreshAllData()
        end

        function providerMixin.OnCanvasSizeChanged(provider)
            provider:RefreshAllData()
        end

        CopyTableContents(_G.TODOPlannerWorldMapDataProviderMixin, providerMixin)
    end

    return true
end

function CollectionMapWindow:EnsureWorldMapProjectionProvider(worldMap)
    if not worldMap or not worldMap.AddDataProvider or not self:EnsureWorldMapProjectionMixins() then
        return nil
    end

    if not self.worldMapDataProvider then
        local provider = CreateFromMixins(_G.TODOPlannerWorldMapDataProviderMixin)
        provider.addon = self
        worldMap:AddDataProvider(provider)
        self.worldMapDataProvider = provider
    elseif worldMap.dataProviders and not worldMap.dataProviders[self.worldMapDataProvider] then
        worldMap:AddDataProvider(self.worldMapDataProvider)
    end

    return self.worldMapDataProvider
end
