local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets
local TYPE_OPTIONS = CollectionExplorerWindow.Config.TYPE_OPTIONS

function CollectionExplorerWindow:BuildTypeTabs(parent)
    local widths = {
        all = 54,
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
    tabGroup:SetPoint("TOP", parent, "TOP", 0, -12)

    local previous

    for _, value in ipairs(TYPE_OPTIONS) do
        local button = Widgets:CreateTabButton(tabGroup, widths[value] or 82, 24, self:GetTypeLabel(value))
        if previous then
            button:SetPoint("LEFT", previous, "RIGHT", gap, 0)
        else
            button:SetPoint("LEFT", tabGroup, "LEFT", 0, 0)
        end
        button:SetScript("OnClick", function()
            self.selectedCollectionType = value
            self.selectedRow = nil
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

function CollectionExplorerWindow:UpdateMountCategoryControl()
    if not self.mountCategoryButton then
        return
    end

    if self.selectedCollectionType == "mounts" then
        self.mountCategoryButton:Show()
        Widgets:UpdateButtonLabel(self.mountCategoryButton, "Sources", self:GetMountSourceSelectionSummary())
    else
        self.mountCategoryButton:Hide()
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
