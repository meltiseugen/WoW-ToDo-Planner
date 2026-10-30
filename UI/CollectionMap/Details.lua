local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local Widgets = TDP.Widgets
local TYPE_LABELS = CollectionMapWindow.Config.TYPE_LABELS
local IsNonEmptyText = CollectionMapWindow.Helpers.IsNonEmptyText
local GetPinCoordinates = CollectionMapWindow.Helpers.GetPinCoordinates

function CollectionMapWindow:GetCollectionTypeLabel()
    return TYPE_LABELS[self.collectionType] or "Collection"
end

function CollectionMapWindow:FormatPinCoordinates(pinData)
    local x, y = GetPinCoordinates(pinData)
    if not x or not y then
        local mapID = type(pinData) == "table" and pinData.mapID or "?"
        return "#" .. tostring(mapID) .. " coordinates unavailable"
    end
    return string.format("#%s %.1f %.1f", tostring(pinData.mapID), x * 100, y * 100)
end

function CollectionMapWindow:AddDetailsSection(lines, title, body)
    if not IsNonEmptyText(body) then
        return
    end

    if #lines > 0 then
        lines[#lines + 1] = ""
    end
    lines[#lines + 1] = title .. ":"
    lines[#lines + 1] = body
end

function CollectionMapWindow:BuildDetailsText()
    local lines = {}

    self:AddDetailsSection(lines, "Source", self.sourceSummary)
    self:AddDetailsSection(lines, "Source details", self.sourceNotes)
    self:AddDetailsSection(lines, "How to get", self.acquisition)
    self:AddDetailsSection(lines, "Effect", self.effect)
    self:AddDetailsSection(lines, "Tips", self.tips)
    self:AddDetailsSection(lines, "Requirements", self.requirements)
    self:AddDetailsSection(lines, "Cost", self.cost)
    if type(self.costs) == "table" and #self.costs > 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Cost guide:"
        for _, costLine in ipairs(self.costs) do
            lines[#lines + 1] = "- " .. tostring(costLine)
        end
    end
    self:AddDetailsSection(lines, "Availability", self.availability)
    self:AddDetailsSection(lines, "Item notes", self.notes)
    self:AddDetailsSection(lines, "Research notes", self.researchNotes)
    self:AddDetailsSection(lines, "Description", self.description)

    if type(self.criteria) == "table" and #self.criteria > 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Criteria:"
        for _, criterion in ipairs(self.criteria) do
            local marker = criterion.completed and "[Done] " or "[ ] "
            local progress = ""
            if IsNonEmptyText(criterion.quantityText) then
                progress = " (" .. criterion.quantityText .. ")"
            elseif tonumber(criterion.requiredQuantity) and criterion.requiredQuantity > 1 then
                progress = string.format(" (%d/%d)", tonumber(criterion.quantity) or 0, criterion.requiredQuantity)
            end
            lines[#lines + 1] = marker .. tostring(criterion.text or "Objective") .. progress
        end
    end

    local visiblePins = self:GetVisiblePins()
    if #visiblePins > 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Locations:"
        for index, pinData in ipairs(visiblePins) do
            local mapName = pinData.mapName or self:GetMapName(pinData.mapID)
            local label = IsNonEmptyText(pinData.label) and pinData.label or (self.title or "Collection location")
            lines[#lines + 1] = string.format("%d. %s", index, label)
            lines[#lines + 1] = "   Map: " .. mapName .. " #" .. tostring(pinData.mapID)
            local x, y = GetPinCoordinates(pinData)
            if x and y then
                lines[#lines + 1] = "   Coordinates: " .. string.format("%.1f, %.1f", x * 100, y * 100)
            else
                lines[#lines + 1] = "   Coordinates: unavailable"
            end

            if IsNonEmptyText(pinData.source) and pinData.source ~= self.sourceSummary then
                lines[#lines + 1] = "   Source: " .. pinData.source
            end
            if IsNonEmptyText(pinData.acquisition) and pinData.acquisition ~= self.acquisition then
                lines[#lines + 1] = "   How to get: " .. pinData.acquisition
            end
            if IsNonEmptyText(pinData.effect) and pinData.effect ~= self.effect then
                lines[#lines + 1] = "   Effect: " .. pinData.effect
            end
            if IsNonEmptyText(pinData.tips) and pinData.tips ~= self.tips then
                lines[#lines + 1] = "   Tips: " .. pinData.tips
            end
        end
    end

    if not self.sourceSummary and not self.acquisition and not self.effect and not self.tips and (#(self.pins or {}) == 0) then
        lines[#lines + 1] = "No curated source details are available for this entry yet."
    end

    return table.concat(lines, "\n")
end

function CollectionMapWindow:RenderDetails()
    if not self.detailTitle then
        return
    end

    self.detailIcon:SetTexture(self.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    self.detailTitle:SetText(self.title or "Collection location")
    self.detailMeta:SetText(self:GetCollectionTypeLabel())
    if self.sourceAreaButton and self.sourceAreaButton:IsShown() then self:UpdateSourceAreaControl() end
    Widgets:UpdateScrollablePreviewText(self.detailScroll, self.detailContent, self.detailText, self:BuildDetailsText())
end
