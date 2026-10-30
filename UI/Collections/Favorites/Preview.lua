local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Widgets = TDP.Widgets

function FavoritesWindow:RenderPreview()
    local row = self.selectedRow
    local achievementId = self:GetCollectionMapAchievementId(row)
    local _, mapHelp = self:GetCollectionMapActionHelp(row)
    self.previewMapButton.tooltipText = mapHelp
    local mapLabel = achievementId and "Achievement" or "Map"
    local mapButtonLabel = self.previewMapButton.label or self.previewMapButton
    if mapButtonLabel:GetText() ~= mapLabel then self.previewMapButton:SetText(mapLabel) end
    local mapWidth = achievementId and 100 or 74
    if self.previewMapButton:GetWidth() ~= mapWidth then self.previewMapButton:SetWidth(mapWidth) end
    self:RenderPreviewVisual(row)
    self:UpdatePreviewAchievementButton(row)
    if not row then
        self.previewTitle:SetText("Select a favorite")
        self.previewMeta:SetText("")
        self.previewStatus:SetText("")
        self.previewStatus:Hide()
        Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, "")
        Widgets:SetButtonEnabled(self.previewWowheadButton, false)
        self.previewMapButton:Hide()
        Widgets:SetButtonEnabled(self.previewRemoveButton, false)
        return
    end

    self.previewTitle:SetText(row.name or "Unknown")
    local previewMeta = self:GetTypeLabel(row.collectionType)
    if row.collectionType == "mounts" then
        previewMeta = (row.mountCategory or "Other") .. " mount"
    elseif row.collectionType == "cosmetics" then
        previewMeta = ((row.cosmeticSubtype or "appearance"):gsub("^%l", string.upper)) .. " cosmetic"
    end
    self.previewMeta:SetText(previewMeta)
    self.previewStatus:SetText("")
    self.previewStatus:Hide()
    Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, self:GetRowNotes(row))

    Widgets:SetButtonEnabled(self.previewWowheadButton, self:GetRowWowheadUrl(row) ~= nil)
    self.previewRemoveButton:ClearAllPoints()
    if self:IsCollectionMapRow(row) then
        self.previewMapButton:Show()
        Widgets:SetButtonEnabled(self.previewMapButton, true)
        self.previewRemoveButton:SetPoint("LEFT", self.previewMapButton, "RIGHT", 8, 0)
    else
        self.previewMapButton:Hide()
        self.previewRemoveButton:SetPoint("LEFT", self.previewWowheadButton, "RIGHT", 8, 0)
    end
    Widgets:SetButtonEnabled(self.previewRemoveButton, true)
end
