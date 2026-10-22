local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets
local ALL_PATCHES = CollectionExplorerWindow.Config.ALL_PATCHES

function CollectionExplorerWindow:RenderPreview()
    local row = self.selectedRow
    if not row then
        if self.previewModel then
            self.previewModel:Hide()
        end
        if self.previewModelControls then
            self.previewModelControls:Hide()
        end
        self.previewIcon:Show()
        self.previewIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        self.previewTitle:SetText("Select an entry")
        self.previewMeta:SetText("")
        self.previewStatus:SetText("")
        self.previewStatus:Hide()
        Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, "")
        if self.previewAchievementButton then
            self.previewAchievementButton:Hide()
        end
        Widgets:SetButtonEnabled(self.previewWowheadButton, false)
        Widgets:SetButtonEnabled(self.previewFavoriteButton, false)
        self.previewMapButton:Hide()
        return
    end

    local didShowModel = false
    if self.previewModel and self.previewModel.SetDisplayInfo and row.state and row.state.modelId then
        local ok = pcall(self.previewModel.SetDisplayInfo, self.previewModel, row.state.modelId)
        if ok then
            local rowKey = self:GetRowKey(row)
            if self.previewModelRowKey ~= rowKey then
                self:ResetPreviewModelTransform(rowKey)
            else
                self:ApplyPreviewModelTransform()
            end
            self.previewModel:Show()
            if self.previewModelControls then
                self.previewModelControls:Show()
            end
            self.previewIcon:Hide()
            didShowModel = true
        end
    end

    if not didShowModel then
        if self.previewModel then
            self.previewModel:Hide()
        end
        if self.previewModelControls then
            self.previewModelControls:Hide()
        end
        self.previewIcon:Show()
        self.previewIcon:SetTexture(row.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
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
    self.previewStatus:SetText(row.unobtainable and self:GetRowStatusLabel(row) or "")
    self.previewStatus:SetShown(row.unobtainable == true)
    if self.previewAchievementButton then
        if self:GetRowAchievementId(row) then
            self.previewAchievementButton:Show()
            Widgets:SetButtonEnabled(self.previewAchievementButton, true)
        else
            self.previewAchievementButton:Hide()
        end
    end

    Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, self:GetRowNotes(row))

    local isFavorite = self:IsFavoriteRow(row)
    self.previewFavoriteButton:SetText(isFavorite and "Remove Favorite" or "Set Favorite")
    Widgets:SetButtonEnabled(self.previewWowheadButton, self:GetRowWowheadUrl(row) ~= nil)
    Widgets:SetButtonEnabled(self.previewFavoriteButton, true)
    if self:IsCollectionMapRow(row) then
        self.previewMapButton:Show()
        Widgets:SetButtonEnabled(self.previewMapButton, true)
    else
        self.previewMapButton:Hide()
    end
end
