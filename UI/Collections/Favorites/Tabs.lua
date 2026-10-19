local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local Widgets = TDP.Widgets
local TYPE_OPTIONS = FavoritesWindow.Config.TYPE_OPTIONS
local TYPE_LABELS = FavoritesWindow.Config.TYPE_LABELS

function FavoritesWindow:GetTypeLabel(value)
    return TYPE_LABELS[value] or tostring(value)
end

function FavoritesWindow:BuildTypeTabs(parent)
    local widths = {
        all = 54,
        mounts = 82,
        pets = 64,
        toys = 64,
        cosmetics = 96,
        achievements = 118,
    }
    local previous

    for _, value in ipairs(TYPE_OPTIONS) do
        local button = Widgets:CreateTabButton(parent, widths[value] or 82, 24, self:GetTypeLabel(value))
        if previous then
            button:SetPoint("LEFT", previous, "RIGHT", 6, 0)
        else
            button:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -12)
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

function FavoritesWindow:UpdateTypeTabs()
    for value, button in pairs(self.typeTabs) do
        if button.SetSelected then
            button:SetSelected(value == self.selectedCollectionType)
        end
    end
end
