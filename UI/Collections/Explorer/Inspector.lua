local _, TDP = ...
local Explorer = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets

local PRIMARY_ORDER = { "Availability", "Unobtainable", "Original acquisition", "How to get", "Source", "Quest chain", "Quest giver", "Location", "Locations",
    "Requirements", "Cost", "Cost guide", "Effect", "Appearance Progress", "Tips", "Reward" }
local ACHIEVEMENT_ORDER = { "Availability", "Description", "Reward", "Criteria", "How to get", "Source", "Tips" }
local FIELD_NAMES = { "Availability", "Unobtainable", "Original acquisition", "How to get", "Source", "Quest chain", "Quest giver", "Location", "Locations", "Requirements",
    "Cost", "Cost guide", "Effect", "Appearance Progress", "Tips", "Reward", "Description", "Criteria",
    "Cosmetic Type", "Achievement Type", "WoW Category", "WoW Parent Category", "Item notes", "Research notes" }
local KNOWN_FIELDS = {}
for _, name in ipairs(FIELD_NAMES) do KNOWN_FIELDS[name] = true end

-- Reorder the existing notes for reading; retain all catalog text and cost lines.
function Explorer:GetInspectorNotes(row)
    if not row then return "", "" end
    local sections, ordered, current = {}, {}, nil
    for line in (self:GetRowNotes(row) .. "\n"):gmatch("(.-)\n") do
        local label = line:match("^([^:]+):")
        if label and KNOWN_FIELDS[label] then
            current = { label = label, lines = {} }
            sections[#sections + 1] = current
        elseif not current then
            current = { lines = {} }
            sections[#sections + 1] = current
        end
        current.lines[#current.lines + 1] = line
    end
    local used = {}
    local function text(section)
        return table.concat(section.lines, "\n"):gsub("%s+$", "")
    end
    local order = row.collectionType == "achievements" and ACHIEVEMENT_ORDER or PRIMARY_ORDER
    for _, label in ipairs(order) do
        for index, section in ipairs(sections) do
            if section.label == label then
                ordered[#ordered + 1] = text(section)
                used[index] = true
            end
        end
    end
    local additional = {}
    for index, section in ipairs(sections) do
        if not used[index] and text(section) ~= "" then additional[#additional + 1] = text(section) end
    end
    return table.concat(ordered, "\n\n"), table.concat(additional, "\n\n")
end

function Explorer:BuildExplorerInspector(panel)
    self:BuildPreviewPanel(panel, true)
    -- Reuse the model and input contracts, with an Explorer-owned layout.
    self.previewDetailsScroll:GetParent():Hide()
    self.previewDetailsScroll:SetParent(panel)
    self.previewIcon:SetParent(panel)
    self.previewIcon:SetSize(48, 48)
    self.previewTitle:SetJustifyH("LEFT")
    self.previewTitle:SetWordWrap(true)
    self.previewMeta:SetWordWrap(true)
    self.previewToggleButton = Widgets:CreateButton(panel, 100, 22, "Hide preview", "neutral")
    self.previewToggleButton:SetScript("OnClick", function()
        self.previewCollapsed = not self.previewCollapsed
        self:SaveBrowserState()
        self:RenderPreview()
    end)
    self:BindExplorerHelp(self.previewToggleButton, "Model preview", "Collapse the model for more reading space. Your preview preference is remembered.")
    self.previewMoreButton = Widgets:CreateButton(panel, 174, 22, "Additional details", "neutral")
    self.previewMoreButton:SetScript("OnClick", function()
        self.previewDetailsExpanded = not self.previewDetailsExpanded
        self:UpdateExplorerInspectorText()
    end)
    self:BindExplorerHelp(self.previewMoreButton, "Additional catalog details", "Expand the remaining category information, item notes and research notes for this entry.")
    self.inspectorDivider = panel:CreateTexture(nil, "ARTWORK")
    Widgets:SetTextureColor(self.inspectorDivider, "goldBorderStrong")
    self.inspectorDivider:SetHeight(1)
    self.previewActionDivider = panel:CreateTexture(nil, "ARTWORK")
    Widgets:SetTextureColor(self.previewActionDivider, "goldBorderStrong")
    self.previewActionDivider:SetHeight(1)
    self.previewActionDivider:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 16, 50)
    self.previewActionDivider:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -16, 50)
    self.previewWowheadButton = Widgets:CreateButton(panel, 100, 28, "Wowhead", "neutral")
    self.previewFavoriteButton = Widgets:CreateButton(panel, 136, 28, "Set Favorite", "primary")
    self.previewMapButton = Widgets:CreateButton(panel, 100, 28, "Open Map", "neutral")
    self.previewFavoriteButton:SetScript("OnClick", function() self:ToggleFavorite(self.selectedRow) end)
    self.previewMapButton:SetScript("OnClick", function() self:OpenCollectionMap(self.selectedRow) end)
    self.previewWowheadButton:SetScript("OnClick", function()
        local url = self:GetRowWowheadUrl(self.selectedRow)
        if url and TDP.Achievements then TDP.Achievements:ShowCopyUrlDialog(url) end
    end)
    self:BindExplorerHelp(self.previewMapButton, "Open Map", function()
        local _, description = self:GetCollectionMapActionHelp(self.selectedRow)
        return description
    end)
    self:BindExplorerHelp(self.previewWowheadButton, "Wowhead", "Copy the Wowhead link for this entry.")
    self:BindPreviewModelControls()
end

function Explorer:LayoutExplorerInspector()
    if not self.previewPanel then return end
    local panel = self.previewPanel
    local width = self.inspectorWidth or panel:GetWidth()
    local height = self.inspectorHeight or panel:GetHeight()
    local hasModel = self.selectedRow and self.previewHasModel
    local showModel = hasModel and not self.previewCollapsed
    local iconHeader = self.selectedRow and not showModel
    self.previewIcon:ClearAllPoints()
    self.previewIcon:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -16)
    self.previewIcon:SetShown(iconHeader == true)
    if iconHeader then self.previewIcon:SetTexture(self.selectedRow.icon or "Interface\\Icons\\INV_Misc_QuestionMark") end
    local titleLeft = iconHeader and 76 or 16
    self.previewTitle:ClearAllPoints()
    self.previewTitle:SetPoint("TOPLEFT", panel, "TOPLEFT", titleLeft, -16)
    self.previewTitle:SetWidth(width - titleLeft - 16)
    local titleHeight = math.max(20, self.previewTitle:GetStringHeight())
    self.previewMeta:ClearAllPoints()
    self.previewMeta:SetPoint("TOPLEFT", panel, "TOPLEFT", titleLeft, -(22 + titleHeight))
    self.previewMeta:SetWidth(width - titleLeft - 16)
    local metaHeight = math.max(14, self.previewMeta:GetStringHeight())
    self.previewStatus:ClearAllPoints()
    self.previewStatus:SetPoint("TOPLEFT", panel, "TOPLEFT", titleLeft, -(28 + titleHeight + metaHeight))
    self.previewStatus:SetWidth(width - titleLeft - 16)
    local headerHeight = math.max(80, titleHeight + metaHeight + 54)
    if self.previewAchievementButton:IsShown() then
        self.previewAchievementButton:ClearAllPoints()
        self.previewAchievementButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -headerHeight)
        headerHeight = headerHeight + 32
    end
    local modelHeight = showModel and math.max(110, math.min(226, height - headerHeight - 232)) or 0
    self.previewVisual:ClearAllPoints()
    self.previewVisual:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -headerHeight)
    self.previewVisual:SetSize(width - 32, math.max(1, modelHeight))
    self.previewVisual:SetShown(showModel == true)
    self.previewToggleButton:ClearAllPoints()
    if showModel then
        self.previewToggleButton:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -16, -(headerHeight + modelHeight + 4))
    else
        self.previewToggleButton:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -16, -headerHeight)
    end
    self.previewToggleButton:SetText(showModel and "Hide preview" or "Show preview")
    self.previewToggleButton:SetShown(hasModel == true)
    self.previewModelControls:ClearAllPoints()
    self.previewModelControls:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -(headerHeight + modelHeight + 4))
    self.previewModelControls:SetSize(math.max(1, width - 150), 22)
    self.previewModelControls:SetShown(showModel == true)
    local detailsTop = headerHeight + (showModel and (modelHeight + 34) or (hasModel and 30 or 0)) + 10
    self.inspectorDetailsTop = detailsTop
    self.inspectorDivider:ClearAllPoints()
    self.inspectorDivider:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -(detailsTop - 6))
    self.inspectorDivider:SetWidth(width - 32)
    local moreHeight = self.inspectorAdditional and self.inspectorAdditional ~= "" and 30 or 0
    self.previewDetailsScroll:ClearAllPoints()
    self.previewDetailsScroll:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -detailsTop)
    self.previewDetailsScroll:SetSize(width - 52, math.max(40, height - detailsTop - 62 - moreHeight))
    self.previewMoreButton:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 16, 58)
    local actionWidth = (width - 48) / 3
    for index, button in ipairs({ self.previewFavoriteButton, self.previewMapButton, self.previewWowheadButton }) do
        button:ClearAllPoints()
        button:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 16 + (index - 1) * (actionWidth + 8), 14)
        button:SetWidth(actionWidth)
    end
end

function Explorer:UpdateExplorerInspectorText()
    local primary, additional = self:GetInspectorNotes(self.selectedRow)
    self.inspectorAdditional = additional
    self.previewMoreButton:SetShown(additional ~= "")
    self.previewMoreButton:SetText(self.previewDetailsExpanded and "Fewer details" or "Additional details")
    local text = primary
    if self.previewDetailsExpanded and additional ~= "" then text = text .. "\n\n" .. additional end
    if self.selectedRow and text == "" then text = "Acquisition details are not recorded for this entry." end
    local scroll = self.previewDetailsScroll:GetVerticalScroll()
    local preserve = self.inspectorTextRowKey == self:GetRowKey(self.selectedRow) and self.previewDetails.rawPreviewText == text
    self:LayoutExplorerInspector()
    Widgets:UpdateScrollablePreviewText(self.previewDetailsScroll, self.previewDetailsContent, self.previewDetails, text)
    if preserve then self.previewDetailsScroll:SetVerticalScroll(math.min(scroll, self.previewDetailsScroll:GetVerticalScrollRange())) end
    self.inspectorTextRowKey = self:GetRowKey(self.selectedRow)
end
