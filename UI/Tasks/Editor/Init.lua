local _, TDP = ...


local TaskEditWindow = {}
TaskEditWindow.__index = TaskEditWindow

function TaskEditWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
    }, self)
end

TDP.TaskEditWindow = TaskEditWindow

TaskEditWindow.FrameMethods = {}
