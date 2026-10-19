local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Widgets = TDP.Widgets

function FavoritesWindow:RenderPreview()
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
            if self.previewModelControls then
                self.previewModelControls:Show()
            end
            self.previewModel:Show()
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
