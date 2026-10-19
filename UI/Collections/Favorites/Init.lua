local _, TDP = ...


local FavoritesWindow = {}
FavoritesWindow.__index = FavoritesWindow

local TYPE_OPTIONS = { "all", "mounts", "pets", "toys", "cosmetics", "achievements" }
local COLLECTION_TYPES = { "mounts", "pets", "toys", "cosmetics", "achievements" }
local ROW_HEIGHT = 48
local ROW_GAP = 5
local LIST_WIDTH = 548
local LIST_CONTENT_WIDTH = 510

local TYPE_LABELS = {
    all = "All",
    mounts = "Mounts",
    pets = "Pets",
    toys = "Toys",
    cosmetics = "Cosmetics",
    achievements = "Achievements",
}

local CATEGORY_BY_TYPE = {
    mounts = "Mounts",
    pets = "Collections",
    toys = "Collections",
    cosmetics = "Collections",
    achievements = "Achievements",
}

function FavoritesWindow:New(homeWindow)
    return setmetatable({
        homeWindow = homeWindow,
        frame = nil,
        selectedCollectionType = "all",
        selectedRow = nil,
        visibleRows = {},
        rowPool = {},
        typeTabs = {},
    }, self)
end

FavoritesWindow.Config = {
    TYPE_OPTIONS = TYPE_OPTIONS,
    COLLECTION_TYPES = COLLECTION_TYPES,
    ROW_HEIGHT = ROW_HEIGHT,
    ROW_GAP = ROW_GAP,
    LIST_WIDTH = LIST_WIDTH,
    LIST_CONTENT_WIDTH = LIST_CONTENT_WIDTH,
    TYPE_LABELS = TYPE_LABELS,
    CATEGORY_BY_TYPE = CATEGORY_BY_TYPE,
}

TDP.FavoritesWindow = FavoritesWindow

TDP.CollectionPreview:Install(FavoritesWindow, false)
