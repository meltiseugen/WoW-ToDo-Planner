local _, TDP = ...
local Widgets = TDP.Widgets
local Preview = {}
local MODEL_DEFAULT_FACING = 0.45
local MODEL_DEFAULT_ZOOM = 1.25
local MODEL_MIN_ZOOM = 0.65
local MODEL_MAX_ZOOM = 3.25
local MODEL_ZOOM_STEP = 0.15

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
    self.previewModel:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustPreviewModelZoom(delta > 0 and -MODEL_ZOOM_STEP or MODEL_ZOOM_STEP)
    end)

    Widgets:ConfigurePreviewModelDragging(self.previewModel, self)

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
    }) do
        windowClass[name] = assert(self[name], "Missing collection preview method: " .. name)
    end
end

TDP.CollectionPreview = Preview
