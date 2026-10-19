local _, TDP = ...
local Widgets = TDP.Widgets
local Preview = TDP.CollectionPreview
local PREVIEW_VISUAL_WIDTH = 300
local PREVIEW_VISUAL_HEIGHT = 240
local PREVIEW_DETAIL_TOP_OFFSET = -254

function Preview:BuildPreviewPanel(previewPanel, includeAchievement)
    local previewVisual = CreateFrame("Frame", nil, previewPanel)
    previewVisual:SetPoint("TOPLEFT", previewPanel, "TOPLEFT", 12, -12)
    previewVisual:SetSize(PREVIEW_VISUAL_WIDTH, PREVIEW_VISUAL_HEIGHT)

    local previewIcon = previewVisual:CreateTexture(nil, "ARTWORK")
    previewIcon:SetPoint("CENTER", previewVisual, "CENTER", 0, 4)
    previewIcon:SetSize(112, 112)

    local previewModel = CreateFrame("PlayerModel", nil, previewVisual)
    previewModel:SetAllPoints(previewVisual)
    previewModel:EnableMouse(true)
    previewModel:EnableMouseWheel(true)
    previewModel:Hide()

    local previewModelControls = CreateFrame("Frame", nil, previewVisual)
    previewModelControls:SetPoint("BOTTOMLEFT", previewVisual, "BOTTOMLEFT", 4, 4)
    previewModelControls:SetPoint("BOTTOMRIGHT", previewVisual, "BOTTOMRIGHT", -4, 4)
    previewModelControls:SetHeight(22)
    if previewModelControls.SetFrameLevel and previewModel.GetFrameLevel then
        previewModelControls:SetFrameLevel((previewModel:GetFrameLevel() or 1) + 5)
    end
    previewModelControls:Hide()

    local modelZoomOutButton = Widgets:CreateButton(previewModelControls, 24, 20, "-", "neutral")
    modelZoomOutButton:SetPoint("LEFT", previewModelControls, "LEFT", 0, 0)

    local modelResetButton = Widgets:CreateButton(previewModelControls, 56, 20, "Reset", "neutral")
    modelResetButton:SetPoint("LEFT", modelZoomOutButton, "RIGHT", 4, 0)

    local modelZoomInButton = Widgets:CreateButton(previewModelControls, 24, 20, "+", "neutral")
    modelZoomInButton:SetPoint("LEFT", modelResetButton, "RIGHT", 4, 0)

    local previewTitle = Widgets:CreateFontString(previewPanel, "OVERLAY", "GameFontNormalLarge")
    previewTitle:SetPoint("TOPLEFT", previewVisual, "TOPRIGHT", 12, -8)
    previewTitle:SetPoint("RIGHT", previewPanel, "RIGHT", -18, 0)
    previewTitle:SetJustifyH("LEFT")
    if previewTitle.SetWordWrap then
        previewTitle:SetWordWrap(true)
    end

    local previewMeta = Widgets:CreateFontString(previewPanel, "OVERLAY", "GameFontHighlightSmall")
    previewMeta:SetPoint("TOPLEFT", previewTitle, "BOTTOMLEFT", 0, -8)
    previewMeta:SetPoint("RIGHT", previewTitle, "RIGHT", 0, 0)
    previewMeta:SetJustifyH("LEFT")

    local previewStatus = Widgets:CreateFontString(previewPanel, "OVERLAY", "GameFontNormal")
    previewStatus:SetPoint("TOPLEFT", previewMeta, "BOTTOMLEFT", 0, -10)
    previewStatus:SetJustifyH("LEFT")

    local previewAchievementButton
    if includeAchievement then
        previewAchievementButton = Widgets:CreateButton(previewPanel, 142, 24, "Open Achievement", "primary")
        previewAchievementButton:SetPoint("TOPLEFT", previewStatus, "BOTTOMLEFT", 0, -8)
        previewAchievementButton:Hide()
    end

    local detailPanel = Widgets:CreatePanel(previewPanel, "input", "inputBorder")
    detailPanel:SetPoint("TOPLEFT", previewPanel, "TOPLEFT", 18, PREVIEW_DETAIL_TOP_OFFSET)
    detailPanel:SetPoint("BOTTOMRIGHT", previewPanel, "BOTTOMRIGHT", -18, 58)

    local detailHeading = Widgets:CreateFontString(detailPanel, "OVERLAY", "GameFontNormal")
    detailHeading:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -10)
    detailHeading:SetText("Collection Details")

    local detailDivider = detailPanel:CreateTexture(nil, "ARTWORK")
    detailDivider:SetPoint("TOPLEFT", detailHeading, "BOTTOMLEFT", 0, -7)
    detailDivider:SetPoint("RIGHT", detailPanel, "RIGHT", -12, 0)
    detailDivider:SetHeight(1)
    Widgets:SetTextureColor(detailDivider, { 1.0, 0.82, 0.18, 0.20 })

    local previewDetailsScroll = CreateFrame("ScrollFrame", nil, detailPanel, "UIPanelScrollFrameTemplate")
    previewDetailsScroll:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -38)
    previewDetailsScroll:SetPoint("BOTTOMRIGHT", detailPanel, "BOTTOMRIGHT", -28, 12)

    local previewDetailsContent = CreateFrame("Frame", nil, previewDetailsScroll)
    previewDetailsContent:SetSize(1, 1)
    previewDetailsScroll:SetScrollChild(previewDetailsContent)

    local previewDetails = Widgets:CreateFontString(previewDetailsContent, "OVERLAY", "GameFontHighlight")
    previewDetails:SetPoint("TOPLEFT", previewDetailsContent, "TOPLEFT", 0, 0)
    previewDetails:SetPoint("TOPRIGHT", previewDetailsContent, "TOPRIGHT", 0, 0)
    Widgets:ConfigurePreviewDetailText(previewDetails)

    detailPanel:SetScript("OnSizeChanged", function()
        Widgets:UpdateScrollablePreviewText(previewDetailsScroll, previewDetailsContent, previewDetails, previewDetails.rawPreviewText)
    end)

    self.previewVisual = previewVisual
    self.previewIcon = previewIcon
    self.previewModel = previewModel
    self.previewModelControls = previewModelControls
    self.modelZoomOutButton = modelZoomOutButton
    self.modelResetButton = modelResetButton
    self.modelZoomInButton = modelZoomInButton
    self.previewTitle = previewTitle
    self.previewMeta = previewMeta
    self.previewStatus = previewStatus
    self.previewDetailsScroll = previewDetailsScroll
    self.previewDetailsContent = previewDetailsContent
    self.previewDetails = previewDetails
    self.previewAchievementButton = previewAchievementButton
end
