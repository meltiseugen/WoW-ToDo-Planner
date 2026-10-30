local _, TDP = ...
local Widgets = TDP.Widgets
local Preview = TDP.CollectionPreview
local PREVIEW_VISUAL_WIDTH = 300
local PREVIEW_VISUAL_HEIGHT = 240
local PREVIEW_DETAIL_TOP_OFFSET = -254

function Preview:GetPreviewAchievementId(row)
    if not row then return nil end
    if row.collectionType == "achievements" then
        return tonumber(type(row.entry) == "table" and row.entry.achievementId or row.entry)
    end
    return TDP.PatchCatalog:GetCollectionSourceAchievementId(row.collectionType, row.patchKey, row.entry)
end

function Preview:GetCollectionMapAchievementId(row)
    if row and row.collectionType ~= "achievements" then
        local info = TDP.PatchCatalog.GetCollectionSourceInfo and TDP.PatchCatalog:GetCollectionSourceInfo(row.collectionType, row.patchKey, row.entry)
        if info and info.kind == "Vendor" then return nil end
        return self:GetPreviewAchievementId(row)
    end
end

function Preview:GetCollectionMapActionHelp(row)
    if self:GetCollectionMapAchievementId(row) then
        return "View Achievement", "Open the rewarding achievement in TODO-Planner's Achievements tab."
    end
    local details = row and TDP.PatchCatalog.GetCollectionDetails
        and TDP.PatchCatalog:GetCollectionDetails(row.collectionType, row.patchKey, row.entry)
    if details and details.automaticUnlock then
        return "Automatic Unlock", "Learned automatically on the required race and class. There is no vendor, quest giver or drop location to visit."
    end
    local info = row and TDP.PatchCatalog.GetCollectionSourceInfo
        and TDP.PatchCatalog:GetCollectionSourceInfo(row.collectionType, row.patchKey, row.entry)
    local recorded = row and TDP.PatchCatalog.GetDescriptionMapLocations
        and TDP.PatchCatalog:GetDescriptionMapLocations(row.collectionType, row.entry)
    if info and info.areaOnly or recorded and recorded.areaMaps then
        return "Source Area", "Open the known source area. A precise NPC or object position is not recorded."
    elseif info and info.progressType == "secret" then
        return "Secret Map", "Open this character's next unfinished secret step."
    elseif info and info.questID then
        return "Quest Map", "Open this character's next unfinished quest or current quest objective."
    elseif info and info.kind == "Vendor" then
        return "Vendor Map", "Open the seller's recorded location."
    end
    return "Open Map", self:IsCollectionMapRow(row) and "Open the recorded catalog locations for this collection."
        or "No catalog location is recorded for this collection."
end

function Preview:OpenCollectionSourceAchievement(row, achievementId)
    local explorer = self.OpenAchievement and self
        or self.homeWindow and self.homeWindow.explorerWindow or TDP.explorerWindow
    if explorer then
        return explorer:OpenAchievement(achievementId, row.patchKey)
    end
    TDP.Utils:Msg("Collections window is unavailable.", "warnings")
    return false
end

function Preview:UpdatePreviewAchievementButton(row)
    local button = self.previewAchievementButton
    if not button then return end
    local achievementId = self:GetPreviewAchievementId(row)
    button:SetShown(achievementId ~= nil)
    if achievementId then
        button:SetText(row.collectionType == "achievements" and "Open Achievement" or "View Achievement")
        Widgets:SetButtonEnabled(button, true)
    end
end

function Preview:OpenPreviewAchievement()
    local row = self.selectedRow
    local achievementId = self:GetPreviewAchievementId(row)
    if not achievementId then return end
    if row.collectionType == "achievements" then
        if not TDP.Achievements or not TDP.Achievements:OpenAchievement(achievementId) then
            TDP.Utils:Msg("Could not open that achievement in the achievement window.", "warnings")
        end
        return
    end
    self:OpenCollectionSourceAchievement(row, achievementId)
end

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
    previewModel:SetKeepModelOnHide(true)
    previewModel:Hide()
    previewModel:SetScript("OnModelLoaded", function(model)
        if self.previewModel ~= model then return end
        self:ApplyPreviewModelTransform()
    end)

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
        previewAchievementButton:SetScript("OnClick", function() self:OpenPreviewAchievement() end)
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
    self.creaturePreviewModel = previewModel
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

function Preview:BuildCosmeticPreviewMessage()
    local controls = self.previewModelControls
    local message = Widgets:CreateFontString(controls, "OVERLAY", "GameFontHighlightSmall")
    message:SetPoint("BOTTOMLEFT", controls, "TOPLEFT", 0, 6)
    message:SetPoint("RIGHT", controls, "RIGHT", 0, 0)
    message:SetJustifyH("CENTER")
    message:SetWordWrap(true)
    message:Hide()
    self.previewModelMessage = message
end
