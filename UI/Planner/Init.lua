local _, TDP = ...


local MainWindow = {}
MainWindow.__index = MainWindow

local DROP_INDICATOR_WIDTH = 286
local DROP_INDICATOR_HEIGHT = 18
local COLUMN_GAP = 12
local COLUMN_MARGIN = 12

function MainWindow:New()
    local instance = {
        frame = nil,
        body = nil,
        toolbar = nil,
        subtitle = nil,
        boardButton = nil,
        filterButton = nil,
        createBoardButton = nil,
        deleteBoardButton = nil,
        collectionsButton = nil,
        favoritesButton = nil,
        homeButton = nil,
        optionsButton = nil,
        inputTitle = nil,
        saveButton = nil,
        detailedButton = nil,
        columns = {},
        detailWindow = nil,
        editWindow = nil,
        optionsWindow = nil,
        draggingTaskId = nil,
        dragSourceCard = nil,
        dropIndicator = nil,
    }
    return setmetatable(instance, self)
end

MainWindow.Config = {
    DROP_INDICATOR_WIDTH = DROP_INDICATOR_WIDTH,
    DROP_INDICATOR_HEIGHT = DROP_INDICATOR_HEIGHT,
    COLUMN_GAP = COLUMN_GAP,
    COLUMN_MARGIN = COLUMN_MARGIN,
}

TDP.MainWindow = MainWindow
