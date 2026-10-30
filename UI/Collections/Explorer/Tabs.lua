local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets
local TYPE_OPTIONS = CollectionExplorerWindow.Config.TYPE_OPTIONS

function CollectionExplorerWindow:BuildTypeTabs(parent)
    local widths = {
        mounts = 82,
        pets = 64,
        toys = 64,
        cosmetics = 96,
        achievements = 118,
    }
    local gap = 6
    local totalWidth = 0
    for index, value in ipairs(TYPE_OPTIONS) do
        totalWidth = totalWidth + (widths[value] or 82)
        if index > 1 then
            totalWidth = totalWidth + gap
        end
    end

    local tabGroup = CreateFrame("Frame", nil, parent)
    tabGroup:SetSize(totalWidth, 24)
    tabGroup:SetPoint("TOP", parent, "TOP", 0, -2)

    local previous

    for _, value in ipairs(TYPE_OPTIONS) do
        local button = Widgets:CreateTabButton(tabGroup, widths[value] or 82, 24, self:GetTypeLabel(value))
        if previous then
            button:SetPoint("LEFT", previous, "RIGHT", gap, 0)
        else
            button:SetPoint("LEFT", tabGroup, "LEFT", 0, 0)
        end
        button:SetScript("OnClick", function()
            Widgets:HideDropdownMenus()
            self:CaptureListState()
            self.selectedCollectionType = value
            self:RestoreListState()
            self:Render()
        end)
        self.typeTabs[value] = button
        previous = button
    end
end

function CollectionExplorerWindow:UpdateTypeTabs()
    for value, button in pairs(self.typeTabs) do
        if button.SetSelected then
            button:SetSelected(value == self.selectedCollectionType)
        end
    end
end

function CollectionExplorerWindow:UpdateSourceControl()
    if not self.sourceButton then
        return
    end

    if self:HasSourceFilter() then
        self.sourceButton:Show()
        Widgets:UpdateButtonLabel(self.sourceButton, "Sources", self:GetSourceSelectionSummary())
    else
        self.sourceButton:Hide()
    end
end

function CollectionExplorerWindow:UpdateCosmeticTypeControl()
    local isCosmetics = self.selectedCollectionType == "cosmetics"
    for _, field in ipairs({ { "weapons", self.weaponTypeButton, self.weaponTypeLabel },
        { "armour", self.armourTypeButton, self.armourTypeLabel } }) do
        local selected = self:GetCosmeticGroupSelection(field[1])
        field[2]:SetShown(isCosmetics)
        field[3]:SetShown(isCosmetics)
        field[2]:SetText(selected == "all" and "All types" or self:GetCosmeticGroupOptionLabel(field[1], selected))
        field[2]:SetSelected(selected ~= "all")
    end
end

function CollectionExplorerWindow:UpdateAchievementCategoryControl()
    if not self.achievementCategoryButton then
        return
    end

    if self.selectedCollectionType == "achievements" then
        self.achievementCategoryButton:Show()
        Widgets:UpdateButtonLabel(self.achievementCategoryButton, "Ach Type", self.selectedAchievementCategory, function(value)
            return self:GetAchievementCategoryLabel(value)
        end)
    else
        self.achievementCategoryButton:Hide()
    end
end
