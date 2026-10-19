local _, TDP = ...


local TaskDetailWindow = {}
TaskDetailWindow.__index = TaskDetailWindow
local DETAIL_COMPACT_HEIGHT = 88
local DETAIL_ROW_HEIGHT = 24
local DETAIL_HEIGHT_PADDING = 18

function TaskDetailWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
    }, self)
end

TaskDetailWindow.Config = {
    DETAIL_COMPACT_HEIGHT = DETAIL_COMPACT_HEIGHT,
    DETAIL_ROW_HEIGHT = DETAIL_ROW_HEIGHT,
    DETAIL_HEIGHT_PADDING = DETAIL_HEIGHT_PADDING,
}

TDP.TaskDetailWindow = TaskDetailWindow

TaskDetailWindow.FrameMethods = {}
