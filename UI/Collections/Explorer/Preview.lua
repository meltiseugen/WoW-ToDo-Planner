local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets
local ALL_PATCHES = CollectionExplorerWindow.Config.ALL_PATCHES

function CollectionExplorerWindow:RenderPreview()
    local row = self.selectedRow
    local rowKey = self:GetRowKey(row)
    if self.inspectorRowKey ~= rowKey then
        self.previewDetailsExpanded = false
        self.inspectorRowKey = rowKey
    end
    local achievementId = self:GetCollectionMapAchievementId(row)
    local mapLabel = achievementId and "Achievement" or "Open Map"
    local mapButtonLabel = self.previewMapButton.label or self.previewMapButton
    if mapButtonLabel:GetText() ~= mapLabel then self.previewMapButton:SetText(mapLabel) end
    self.previewMapButton.explorerHelpTitle = self:GetCollectionMapActionHelp(row)
    self:RenderPreviewVisual(row)
    if not row then
        self.previewTitle:SetText("Select an entry")
        self.previewMeta:SetText("")
        self.previewStatus:SetText("")
        self.previewStatus:Hide()
        if self.previewAchievementButton then
            self.previewAchievementButton:Hide()
        end
        self:UpdateExplorerInspectorText()
        Widgets:SetButtonEnabled(self.previewWowheadButton, false)
        Widgets:SetButtonEnabled(self.previewFavoriteButton, false)
        Widgets:SetButtonEnabled(self.previewMapButton, false)
        return
    end

    self.previewTitle:SetText(row.name or "Unknown")
    local previewMeta = self:GetTypeLabel(row.collectionType)
    if row.collectionType == "mounts" then
        previewMeta = (row.mountCategory or "Other") .. " mount"
    elseif row.collectionType == "cosmetics" then
        previewMeta = ((row.cosmeticSubtype or "appearance"):gsub("^%l", string.upper)) .. " cosmetic"
    elseif row.collectionType == "achievements" then
        previewMeta = (row.achievementCategory or "Other") .. " achievement"
    end
    if self.nearbySnapshot or self.selectedPatch == ALL_PATCHES then
        previewMeta = string.format("Patch %s - %s", row.patchKey, previewMeta)
    end
    self.previewMeta:SetText(previewMeta)
    self.previewStatus:SetText(self:GetRowStatusLabel(row))
    self.previewStatus:Show()
    self:UpdatePreviewAchievementButton(row)

    self:UpdateExplorerInspectorText()

    local isFavorite = self:IsFavoriteRow(row)
    self.previewFavoriteButton:SetText(isFavorite and "Remove Favorite" or "Set Favorite")
    Widgets:SetButtonEnabled(self.previewWowheadButton, self:GetRowWowheadUrl(row) ~= nil)
    Widgets:SetButtonEnabled(self.previewFavoriteButton, true)
    Widgets:SetButtonEnabled(self.previewMapButton, self:IsCollectionMapRow(row) == true)
end
