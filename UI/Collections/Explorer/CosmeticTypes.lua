local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow

local TYPE_OPTIONS = { "all", "weapons", "armour", "weapons:bows", "weapons:crossbows", "weapons:guns",
    "weapons:1hSwords", "weapons:2hSwords", "weapons:1hAxes", "weapons:2hAxes",
    "weapons:1hMaces", "weapons:2hMaces", "weapons:daggers", "weapons:fists",
    "weapons:polearms", "weapons:staves", "weapons:wands", "weapons:warglaives",
    "weapons:paired", "weapons:sets", "weapons:illusions", "armour:head",
    "armour:shoulders", "armour:back", "armour:chest", "armour:wrists", "armour:hands",
    "armour:waist", "armour:legs", "armour:feet", "armour:shirts", "armour:tabards",
    "armour:shields", "armour:offHands", "armour:sets", "other" }
local TYPE_LABELS = TDP.CollectionMetadata.COSMETIC_TYPE_LABELS

function CollectionExplorerWindow:GetCosmeticTypeOptions()
    return TYPE_OPTIONS
end

function CollectionExplorerWindow:GetCosmeticGroupOptions(group)
    local options = { "all", group }
    for _, value in ipairs(TYPE_OPTIONS) do
        if value:match("^([^:]+):") == group then options[#options + 1] = value end
    end
    options[#options + 1] = "other"
    return options
end

function CollectionExplorerWindow:GetCosmeticGroupOptionLabel(group, value)
    if value == "all" then return "All cosmetic types" end
    if value == group then return group == "weapons" and "All Weapons" or "All Armour" end
    return self:GetCosmeticTypeLabel(value):gsub("^[^:]+:%s*", "")
end

function CollectionExplorerWindow:GetCosmeticGroupSelection(group)
    local value = self:GetCosmeticTypeFilter()
    if value == "other" then return value end
    return (value == group or value:match("^([^:]+):") == group) and value or "all"
end

function CollectionExplorerWindow:GetCosmeticTypeFilter()
    local settings = TODOPlannerDB and TODOPlannerDB.settings
    local value = settings and settings.collectionCosmeticTypeFilter or self.selectedCosmeticType
    return TYPE_LABELS[value] and value or "all"
end

function CollectionExplorerWindow:SetCosmeticTypeFilter(value)
    if not TYPE_LABELS[value] then return false end
    local settings = TODOPlannerDB and TODOPlannerDB.settings
    if settings then settings.collectionCosmeticTypeFilter = value end
    self.selectedCosmeticType = value
    self.selectedRow = nil
    self:Render()
    return true
end

function CollectionExplorerWindow:CosmeticTypeMatchesFilter(cosmeticType)
    if self.selectedCollectionType ~= "cosmetics" then return true end
    local selected = self:GetCosmeticTypeFilter()
    return selected == "all" or selected == cosmeticType
        or (selected == "weapons" or selected == "armour") and cosmeticType:match("^([^:]+):") == selected
end
