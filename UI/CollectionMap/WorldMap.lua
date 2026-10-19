local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local Widgets = TDP.Widgets
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates
local PinMatchesMap = CollectionMapWindow.Helpers.PinMatchesMap

function CollectionMapWindow:UpdateProjectionControls()
    if self.clearProjectButton then
        Widgets:SetButtonEnabled(self.clearProjectButton, self.projectedPayload ~= nil)
    end
end

function CollectionMapWindow:CopyProjectionPayload()
    local pins = {}
    local allPins = {}

    local function copyPin(pinData)
        local x, y = GetPinCoordinates(pinData)
        if x and y then
            return {
                mapID = pinData.mapID,
                mapName = pinData.mapName,
                x = x,
                y = y,
                label = pinData.label,
                waypoint = pinData.waypoint,
                icon = pinData.icon,
                source = pinData.source,
                acquisition = pinData.acquisition,
                effect = pinData.effect,
                tips = pinData.tips,
                criterionAchievementId = pinData.criterionAchievementId,
                criterionIndex = pinData.criterionIndex,
                criterionCompleted = pinData.criterionCompleted,
                criterionText = pinData.criterionText,
            }
        end
        return nil
    end

    for _, pinData in ipairs(self.pins or {}) do
        local copiedPin = copyPin(pinData)
        if copiedPin then
            allPins[#allPins + 1] = copiedPin
        end
    end
    for _, pinData in ipairs(self:GetVisiblePins()) do
        local copiedPin = copyPin(pinData)
        if copiedPin then
            pins[#pins + 1] = copiedPin
        end
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
        tips = self.tips,
        description = self.description,
        criteria = self.criteria,
        mapAchievementId = self.mapAchievementId,
        showCompletedCriteriaPins = self.showCompletedCriteriaPins,
        waypoints = waypoints,
        pins = pins,
        allPins = allPins,
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
    if worldMap and worldMap.GetCanvasContainer then
        return worldMap:GetCanvasContainer(), worldMap
    end
    local scrollContainer = worldMap and worldMap.ScrollContainer
    return scrollContainer and scrollContainer.Child, worldMap
end

function CollectionMapWindow:GetWorldMapControlsParent(worldMap, canvas)
    if worldMap and worldMap.ScrollContainer then
        return worldMap.ScrollContainer
    end
    return canvas or worldMap
end

function CollectionMapWindow:CreateWorldMapControls(worldMap, canvas)
    local parent = self:GetWorldMapControlsParent(worldMap, canvas)
    if not parent then
        return nil
    end

    local controls = self.worldMapControls
    if not controls then
        controls = CreateFrame("Frame", "TODOPlannerWorldMapControls", parent, "BackdropTemplate")
        controls:SetSize(236, 32)
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
    elseif controls:GetParent() ~= parent then
        controls:SetParent(parent)
    end

    controls:ClearAllPoints()
    controls:SetSize(236, 32)
    controls:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -24, 24)
    controls:SetFrameLevel((parent:GetFrameLevel() or worldMap:GetFrameLevel() or 0) + 120)
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
    local child = self:GetWorldMapContent()
    self:CreateWorldMapControls(worldMap, child)
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
    if #(self.projectedPayload.pins or {}) == 0 then
        self.projectedPayload = nil
        self:SetStatus("No valid curated pins are available to project.")
        return false
    end
    self.projectedPayload.mapID = self.projectedPayload.mapID or (self.projectedPayload.pins[1] and self.projectedPayload.pins[1].mapID)

    if self:OpenWorldMapToProjectedMap() then
        self:RefreshMinimapProjection()
        self:SetStatus(string.format("%d TODO pin(s) projected on the Blizzard map.", #self.projectedPayload.pins))
        self:UpdateProjectionControls()
        return true
    end

    return false
end

function CollectionMapWindow:ClearWorldMapProjection()
    self.projectedPayload = nil
    self:HideWorldMapPins()
    self:HideMinimapPins()
    if self.worldMapControls then
        self.worldMapControls:Hide()
    end
    self:UpdateProjectionControls()
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
    if not payload or not worldMap or not worldMap:IsShown() then
        self:HideWorldMapPins()
        if self.worldMapControls then
            self.worldMapControls:Hide()
        end
        return
    end

    local controls = self:CreateWorldMapControls(worldMap, child)
    if not controls then
        return
    end
    controls:Show()

    local provider = self:EnsureWorldMapProjectionProvider(worldMap)
    if provider then
        self:HideLegacyWorldMapPins()
        provider:RefreshAllData()
        self:UpdateProjectionControls()
        return
    end

    if not child then
        self:HideWorldMapPins()
        controls:Hide()
        return
    end

    local currentMapID = worldMap.GetMapID and worldMap:GetMapID() or payload.mapID
    local width = math.max(child:GetWidth() or 1, 1)
    local height = math.max(child:GetHeight() or 1, 1)
    local pinIndex = 1

    self:HideLegacyWorldMapPins()
    for _, pinData in ipairs(payload.pins or {}) do
        if PinMatchesMap(pinData, currentMapID) then
            local x, y = GetPinCoordinates(pinData)
            if x and y then
                local pin = self:CreateWorldMapPin(pinIndex, child)
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
                pin:SetPoint("CENTER", child, "TOPLEFT", x * width, -(y * height))
                pin:Show()
                pinIndex = pinIndex + 1
            end
        end
    end
    self:UpdateProjectionControls()
end
