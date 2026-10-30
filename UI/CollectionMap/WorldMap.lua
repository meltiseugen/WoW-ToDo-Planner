local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local Widgets = TDP.Widgets
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates

function CollectionMapWindow:UpdateProjectionControls()
    if self.clearProjectButton then
        Widgets:SetButtonEnabled(self.clearProjectButton, #self.projectedPayloads > 0)
    end
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

        local clearButton = Widgets:CreateButton(controls, 104, 24, "Clear All Pins", "neutral")
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
        if self.worldMapControls then
            self.worldMapControls:Hide()
        end
    end)
end

function CollectionMapWindow:OpenWorldMapToProjectedMap()
    local worldMap = self:LoadWorldMap()
    if not worldMap then
        self:SetStatus("The Blizzard world map is unavailable.")
        return false
    end

    local targetMapID = self.projectedPayload and self.projectedPayload.mapID
    -- C_Map.OpenWorldMap is restricted; use Blizzard's Lua UI entry point.
    if type(OpenWorldMap) == "function" then
        OpenWorldMap(targetMapID)
    else
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
    end

    if not worldMap:IsShown() then
        self:SetStatus("The Blizzard world map could not be opened.")
        return false
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

    local payload = self:CopyProjectionPayload()
    if #(payload.pins or {}) == 0 then
        self:SetStatus("No valid curated pins are available to project.")
        return false
    end
    payload.mapID = payload.mapID or payload.pins[1].mapID
    local previousPayload = self.projectedPayload
    self.projectedPayload = payload

    if self:OpenWorldMapToProjectedMap() then
        self:AddProjection(payload)
        self:RefreshWorldMapProjection()
        self:RefreshMinimapProjection()
        self:SetStatus(string.format("%d item(s) projected on the Blizzard world map and minimap.", #self.projectedPayloads))
        self:UpdateProjectionControls()
        return true
    end

    self.projectedPayload = previousPayload
    return false
end

function CollectionMapWindow:ClearWorldMapProjection()
    self.projectedPayload = nil
    self.projectedPayloads = {}
    self:SaveProjections()
    self:HideWorldMapPins()
    self:HideMinimapPins()
    if self.worldMapControls then
        self.worldMapControls:Hide()
    end
    self:UpdateProjectionControls()
    self:SetStatus("All projected TODO pins cleared from the Blizzard world map and minimap.")
end

function CollectionMapWindow:OpenProjectedDetails()
    if not self.projectedPayload then
        return
    end

    self:Open(self.projectedPayload)
end

function CollectionMapWindow:RefreshWorldMapProjection()
    local child, worldMap = self:GetWorldMapContent()
    if #self.projectedPayloads == 0 or not worldMap then
        self:HideWorldMapPins()
        if self.worldMapControls then
            self.worldMapControls:Hide()
        end
        return
    end
    local shown = worldMap:IsShown()
    local controls = shown and self:CreateWorldMapControls(worldMap, child) or self.worldMapControls
    local library = self:GetMapPinLibrary()
    self:HideWorldMapPins()
    if not library then
        if controls then controls:Hide() end
        return
    end
    if controls then controls:SetShown(shown) end

    local pinIndex = 1
    for pinData, payload in self:EnumerateProjectedPins() do
        local mapID = tonumber(pinData.mapID)
        local x, y = GetPinCoordinates(pinData)
        if mapID and mapID > 0 and x and y then
            local pin = self:CreateWorldMapPin(pinIndex)
            self:ConfigureWorldMapPin(pin, pinData, payload)
            -- Register every zone; HBD's canvas provider owns visibility and
            -- positions the icon as the Blizzard map is navigated or zoomed.
            if library:AddWorldMapIconMap(self, pin, mapID, x, y, 0) then
                pinIndex = pinIndex + 1
            end
        end
    end
    self:UpdateProjectionControls()
end
