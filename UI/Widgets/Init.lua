local _, TDP = ...


local Widgets = {}
Widgets.__index = Widgets

function Widgets:New(addon)
    return setmetatable({
        addon = addon,
        menuFrame = nil,
        dropdownDismissFrame = nil,
        windowFrameLevel = 100,
        windowFrames = {},
    }, self)
end

TDP.Widgets = Widgets:New(TDP)
