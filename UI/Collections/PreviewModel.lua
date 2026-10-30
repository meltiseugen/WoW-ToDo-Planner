local _, TDP = ...
local Widgets = TDP.Widgets
local Preview = {}
local MODEL_DEFAULT_FACING = 0.45
local MODEL_DEFAULT_ZOOM = 1.25
local MODEL_MIN_ZOOM = 0.65
local MODEL_MAX_ZOOM = 3.25
local MODEL_ZOOM_STEP = 0.15

function Preview:GetCosmeticItemLink(row)
    if not row or row.collectionType ~= "cosmetics" then return nil end
    local itemID = type(row.entry) == "table" and tonumber(row.entry.itemId)
    if not itemID then return nil end
    if C_Item and type(C_Item.GetItemLinkByID) == "function" then
        local ok, link = pcall(C_Item.GetItemLinkByID, itemID)
        if ok and link then return link end
    end
    local getItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
    if type(getItemInfo) == "function" then
        local ok, _, link = pcall(getItemInfo, itemID)
        if ok and link then return link end
    end
    return "item:" .. tostring(itemID)
end

function Preview:ApplyCosmeticPreviewAppearance()
    local model, row = self.cosmeticPreviewModel, self.selectedRow
    if not model or self.previewModel ~= model or not row or row.collectionType ~= "cosmetics"
        or not self.cosmeticPreviewUnitInitialized or self.applyingCosmeticPreview then return end

    local link = self:GetCosmeticItemLink(row)
    local previewKey = tostring(self:GetRowKey(row)) .. "|" .. tostring(link)
    if self.cosmeticPreviewAppliedKey == previewKey then return end
    -- Collection cache events rebuild row tables; their stable key identifies the outfit.
    self.cosmeticPreviewAppliedKey = previewKey
    self.cosmeticPreviewPendingItemID = nil
    local itemID = tonumber(row.entry.itemId)
    local needsItemData = false
    if C_Item and type(C_Item.IsItemDataCachedByID) == "function"
        and type(C_Item.RequestLoadItemDataByID) == "function" then
        local ok, cached = pcall(C_Item.IsItemDataCachedByID, itemID)
        needsItemData = ok and cached == false
    end

    self.applyingCosmeticPreview = true
    local ok, result = pcall(function()
        -- Queue the outfit directly, as Blizzard's wardrobe does. Geometry readiness
        -- includes outfit assets and must not gate TryOn or restart SetUnit.
        -- Start bare so equipped weapons never leak into an unrelated cosmetic.
        model:Undress()
        if needsItemData then return false end
        if row.entry.subtype == "effect" then return false end
        return model:TryOn(link)
    end)
    self.applyingCosmeticPreview = nil
    local success = ok and result ~= false
        and (result == nil or not Enum or not Enum.ItemTryOnReason or result == Enum.ItemTryOnReason.Success)
    self.previewModelMessage:SetText(needsItemData and "Loading item..."
        or success and "" or "This cosmetic cannot be previewed.")
    self.previewModelMessage:SetShown(not success)
    self:ApplyPreviewModelTransform()
    if needsItemData then
        self.cosmeticPreviewPendingItemID = itemID
        local requested = pcall(C_Item.RequestLoadItemDataByID, itemID)
        if not requested then
            self.cosmeticPreviewPendingItemID = nil
            self.previewModelMessage:SetText("This cosmetic cannot be previewed.")
        end
    end
end

function Preview:BindPreviewModelInput(model)
    model:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustPreviewModelZoom(delta > 0 and -MODEL_ZOOM_STEP or MODEL_ZOOM_STEP)
    end)
    Widgets:ConfigurePreviewModelDragging(model, self)
end

function Preview:GetCosmeticPreviewModel()
    if not self.cosmeticPreviewModel then
        local model = CreateFrame("DressUpModel", nil, self.previewVisual)
        model:SetAllPoints(self.previewVisual)
        model:EnableMouse(true)
        model:EnableMouseWheel(true)
        model:SetAutoDress(false)
        model:SetUseTransmogChoices(true)
        model:SetKeepModelOnHide(true)
        model:Hide()
        self.cosmeticPreviewModel = model
        self:BuildCosmeticPreviewMessage()
        self:BindPreviewModelInput(model)
        -- Model/outfit asset loads must not start another dressing pass.
        model:SetScript("OnModelLoaded", function()
            if self.previewModel == model then self:ApplyPreviewModelTransform() end
        end)
        model:RegisterEvent("ITEM_DATA_LOAD_RESULT")
        model:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
        model:SetScript("OnEvent", function(_, event, value, success)
            if event == "UNIT_MODEL_CHANGED" and value == "player" then
                self.cosmeticPreviewUnitInitialized = nil
                self.cosmeticPreviewAppliedKey = nil
                if self.previewModel == model and self.selectedRow then
                    self:RenderPreviewVisual(self.selectedRow)
                end
            elseif event == "ITEM_DATA_LOAD_RESULT" and value == self.cosmeticPreviewPendingItemID then
                self.cosmeticPreviewPendingItemID = nil
                if success then
                    self.cosmeticPreviewAppliedKey = nil
                    self:ApplyCosmeticPreviewAppearance()
                elseif self.previewModel == model then
                    self.previewModelMessage:SetText("This cosmetic cannot be previewed.")
                    self.previewModelMessage:Show()
                end
            end
        end)
        if self.previewModelControls.SetFrameLevel then
            self.previewModelControls:SetFrameLevel(model:GetFrameLevel() + 5)
        end
    end
    return self.cosmeticPreviewModel
end

function Preview:RenderPreviewVisual(row)
    local model = self.creaturePreviewModel
    local isCosmetic = row and row.collectionType == "cosmetics" and self:GetCosmeticItemLink(row) ~= nil
    if isCosmetic then model = self:GetCosmeticPreviewModel() end
    if self.previewModel ~= model then self.previewModel:Hide() end
    self.previewModel = model
    if self.previewModelMessage and not isCosmetic then self.previewModelMessage:Hide() end

    local displayID = row and row.state and tonumber(row.state.modelId)
    if displayID and displayID <= 0 then displayID = nil end
    local hasModel = isCosmetic or (displayID ~= nil and model.SetDisplayInfo ~= nil)
    self.previewHasModel = hasModel
    -- The Explorer may have collapsed this parent while showing an icon. Give
    -- PlayerModel its real viewport before loading the next creature's assets.
    if hasModel and self.LayoutExplorerInspector then self:LayoutExplorerInspector() end
    if hasModel and not model:IsShown() then model:Show() end

    local didShowModel = false
    if isCosmetic then
        if self.cosmeticPreviewUnitInitialized == nil then
            local ok, success = pcall(model.SetUnit, model, "player", false)
            self.cosmeticPreviewUnitInitialized = ok and success ~= false
        end
        didShowModel = self.cosmeticPreviewUnitInitialized
    elseif displayID and model.SetDisplayInfo then
        didShowModel = self.creaturePreviewDisplayID == displayID
        if not didShowModel then
            didShowModel = pcall(model.SetDisplayInfo, model, displayID)
            self.creaturePreviewDisplayID = didShowModel and displayID or nil
        end
    end
    self.previewHasModel = didShowModel == true

    if didShowModel then
        local rowKey = self:GetRowKey(row)
        if self.previewModelRowKey ~= rowKey then self:ResetPreviewModelTransform(rowKey)
        else self:ApplyPreviewModelTransform() end
        self.previewModelControls:Show()
        self.previewIcon:Hide()
        if isCosmetic then
            self:ApplyCosmeticPreviewAppearance()
        end
    else
        model:Hide()
        if hasModel and self.LayoutExplorerInspector then self:LayoutExplorerInspector() end
        self.previewModelControls:Hide()
        self.previewIcon:Show()
        self.previewIcon:SetTexture(row and row.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    end
end

function Preview:ClampPreviewModelZoom(value)
    value = tonumber(value) or MODEL_DEFAULT_ZOOM
    if value < MODEL_MIN_ZOOM then
        return MODEL_MIN_ZOOM
    elseif value > MODEL_MAX_ZOOM then
        return MODEL_MAX_ZOOM
    end
    return value
end

function Preview:ApplyPreviewModelTransform()
    if not self.previewModel then
        return
    end

    if self.previewModel.SetCamDistanceScale then
        pcall(self.previewModel.SetCamDistanceScale, self.previewModel, self.previewModelZoom or MODEL_DEFAULT_ZOOM)
    end
    if self.previewModel.SetFacing then
        pcall(self.previewModel.SetFacing, self.previewModel, self.previewModelFacing or MODEL_DEFAULT_FACING)
    end
    if self.previewModel.SetViewTranslation then
        self.previewModel:SetViewTranslation(self.previewModelPanX or 0, self.previewModelPanY or 0)
    end
end

function Preview:ResetPreviewModelTransform(rowKey)
    if not self.preservePreviewModelRowKey or rowKey then
        self.previewModelRowKey = rowKey
    end
    self.previewModelZoom = MODEL_DEFAULT_ZOOM
    self.previewModelFacing = MODEL_DEFAULT_FACING
    self.previewModelPanX = 0
    self.previewModelPanY = 0
    self.previewModelDragButton = nil
    self.previewModelDragX = nil
    self.previewModelDragY = nil
    self:ApplyPreviewModelTransform()
end

function Preview:AdjustPreviewModelZoom(delta)
    self.previewModelZoom = self:ClampPreviewModelZoom((self.previewModelZoom or MODEL_DEFAULT_ZOOM) + delta)
    self:ApplyPreviewModelTransform()
end

function Preview:BindPreviewModelControls()
    self:BindPreviewModelInput(self.previewModel)

    self.modelZoomOutButton:SetScript("OnClick", function()
        self:AdjustPreviewModelZoom(MODEL_ZOOM_STEP)
    end)

    self.modelZoomInButton:SetScript("OnClick", function()
        self:AdjustPreviewModelZoom(-MODEL_ZOOM_STEP)
    end)

    self.modelResetButton:SetScript("OnClick", function()
        self:ResetPreviewModelTransform(self:GetRowKey(self.selectedRow))
    end)
end

function Preview:Install(windowClass, preserveRowKey)
    windowClass.preservePreviewModelRowKey = preserveRowKey == true
    for _, name in ipairs({
        "ClampPreviewModelZoom", "ApplyPreviewModelTransform",
        "ResetPreviewModelTransform", "AdjustPreviewModelZoom",
        "BuildPreviewPanel", "BindPreviewModelControls",
        "GetPreviewAchievementId", "UpdatePreviewAchievementButton", "OpenPreviewAchievement",
        "GetCollectionMapAchievementId", "OpenCollectionSourceAchievement",
        "GetCollectionMapActionHelp",
        "GetCosmeticItemLink", "BuildCosmeticPreviewMessage",
        "ApplyCosmeticPreviewAppearance", "BindPreviewModelInput", "GetCosmeticPreviewModel", "RenderPreviewVisual",
    }) do
        windowClass[name] = assert(self[name], "Missing collection preview method: " .. name)
    end
end

TDP.CollectionPreview = Preview
