local _, TDP = ...


local CollectionExplorerWindow = {}
CollectionExplorerWindow.__index = CollectionExplorerWindow

local TYPE_OPTIONS = { "mounts", "pets", "toys", "cosmetics", "achievements" }
local STATUS_OPTIONS = { "missing", "all", "collected" }
local EXPANSION_OPTIONS = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" }
local EXPANSION_LABELS = {
    ["1"] = "Classic / Vanilla (1)",
    ["2"] = "The Burning Crusade (2)",
    ["3"] = "Wrath of the Lich King (3)",
    ["4"] = "Cataclysm (4)",
    ["5"] = "Mists of Pandaria (5)",
    ["6"] = "Warlords of Draenor (6)",
    ["7"] = "Legion (7)",
    ["8"] = "Battle for Azeroth (8)",
    ["9"] = "Shadowlands (9)",
    ["10"] = "Dragonflight (10)",
    ["11"] = "The War Within (11)",
    ["12"] = "Midnight (12)",
}
local ALL_PATCHES = "all"
local MOUNT_CATEGORY_OPTIONS = { "all", "PvP", "Dungeon and Raids", "Quest Rewards", "Rare Drops", "Vendor", "Delves", "Achievements", "Trading Post", "Promotion", "Other" }
local SOURCE_CATEGORY_OPTIONS = { "all", "PvP", "Dungeon and Raids", "Quest Rewards", "Rare Drops", "Vendor", "Delves", "Achievements", "Trading Post", "Black Market", "Promotion", "Pet Battles", "Professions", "Reputation", "Treasure", "Events", "Other" }
local ACHIEVEMENT_CATEGORY_OPTIONS = { "all", "Questing", "Exploration", "Delves", "Dungeons", "Raids", "PvP", "Pet Battles", "Reputation", "Professions", "Events", "Collections", "Feats of Strength", "Other" }
local COLLECTION_TYPES = { "mounts", "pets", "toys", "cosmetics", "achievements" }
local ROW_HEIGHT = 52
local ROW_GAP = 4
local LIST_WIDTH = 548
local LIST_CONTENT_WIDTH = 510
local FACTION_BADGE_COLORS = {
    alliance = { 0.18, 0.48, 1.00, 1.00 },
    horde = { 0.86, 0.12, 0.12, 1.00 },
}

local TYPE_LABELS = {
    mounts = "Mounts",
    pets = "Pets",
    toys = "Toys",
    cosmetics = "Cosmetics",
    achievements = "Achievements",
}

function CollectionExplorerWindow:New(homeWindow)
    local settings = TODOPlannerDB and TODOPlannerDB.settings or {}
    local saved = type(settings.collectionExplorerWindow) == "table" and settings.collectionExplorerWindow or {}
    local selectedType = "mounts"
    for _, collectionType in ipairs(TYPE_OPTIONS) do
        if saved.collectionType == collectionType then selectedType = collectionType end
    end
    local selectedStatus = settings.collectionStatusFilter
    if selectedStatus ~= "missing" and selectedStatus ~= "all" and selectedStatus ~= "collected" then
        selectedStatus = settings.collectionHideCollected == false and "all" or "missing"
    end
    return setmetatable({
        homeWindow = homeWindow,
        frame = nil,
        selectedExpansion = EXPANSION_LABELS[saved.expansion] and saved.expansion or "12",
        selectedPatch = type(saved.patch) == "string" and saved.patch or "12.1.5",
        selectedCollectionType = selectedType,
        selectedStatus = selectedStatus,
        selectedAchievementCategory = saved.achievementCategory or "all",
        sortKey = saved.sortKey or "name",
        previewCollapsed = saved.previewCollapsed == true,
        selectedRow = nil,
        visibleRows = {},
        rowPool = {},
        typeTabs = {},
    }, self)
end

CollectionExplorerWindow.Config = {
    TYPE_OPTIONS = TYPE_OPTIONS,
    STATUS_OPTIONS = STATUS_OPTIONS,
    EXPANSION_OPTIONS = EXPANSION_OPTIONS,
    EXPANSION_LABELS = EXPANSION_LABELS,
    ALL_PATCHES = ALL_PATCHES,
    MOUNT_CATEGORY_OPTIONS = MOUNT_CATEGORY_OPTIONS,
    SOURCE_CATEGORY_OPTIONS = SOURCE_CATEGORY_OPTIONS,
    ACHIEVEMENT_CATEGORY_OPTIONS = ACHIEVEMENT_CATEGORY_OPTIONS,
    COLLECTION_TYPES = COLLECTION_TYPES,
    ROW_HEIGHT = ROW_HEIGHT,
    ROW_GAP = ROW_GAP,
    LIST_WIDTH = LIST_WIDTH,
    LIST_CONTENT_WIDTH = LIST_CONTENT_WIDTH,
    FACTION_BADGE_COLORS = FACTION_BADGE_COLORS,
    TYPE_LABELS = TYPE_LABELS,
}

TDP.CollectionExplorerWindow = CollectionExplorerWindow

TDP.CollectionMetadata:Install(CollectionExplorerWindow)
TDP.CollectionPreview:Install(CollectionExplorerWindow, true)
