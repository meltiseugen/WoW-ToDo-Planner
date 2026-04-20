local _, TDP = ...

local ThemeManager = {}
ThemeManager.__index = ThemeManager

function ThemeManager:New(addon)
    local instance = {
        addon = addon,
        theme = nil,
    }
    return setmetatable(instance, self)
end

function ThemeManager:CloneThemeTable(source)
    local copy = {}
    if type(source) ~= "table" then
        return copy
    end

    for key, value in pairs(source) do
        if type(value) == "table" then
            local nested = {}
            for nestedKey, nestedValue in pairs(value) do
                if type(nestedValue) == "table" then
                    local inner = {}
                    for innerKey, innerValue in pairs(nestedValue) do
                        inner[innerKey] = innerValue
                    end
                    nested[nestedKey] = inner
                else
                    nested[nestedKey] = nestedValue
                end
            end
            copy[key] = nested
        else
            copy[key] = value
        end
    end

    return copy
end

function ThemeManager:Create()
    if self.theme then
        return self.theme
    end

    if type(_G.JanisTheme) ~= "table" or type(_G.JanisTheme.New) ~= "function" then
        return nil
    end

    local colors = self:CloneThemeTable(_G.JanisTheme.defaultColors)
    colors.input = { 0.03, 0.04, 0.06, 0.94 }
    colors.inputFocus = { 0.05, 0.06, 0.08, 0.96 }
    colors.inputBorder = { 1.0, 1.0, 1.0, 0.08 }
    colors.inputBorderFocus = { 1.0, 0.82, 0.18, 0.26 }

    local buttonPalettes = self:CloneThemeTable(_G.JanisTheme.defaultButtonPalettes)
    buttonPalettes.subtle = {
        bg = { 0.09, 0.10, 0.14, 0.94 },
        border = { 1.0, 1.0, 1.0, 0.08 },
        hoverBg = { 0.12, 0.13, 0.18, 0.98 },
        hoverBorder = { 1.0, 0.82, 0.18, 0.22 },
        pressedBg = { 0.06, 0.07, 0.10, 0.98 },
        pressedBorder = { 1.0, 1.0, 1.0, 0.10 },
        selectedBg = { 0.18, 0.14, 0.08, 0.96 },
        selectedBorder = { 1.0, 0.82, 0.24, 0.48 },
        text = { 0.92, 0.94, 1.00 },
    }

    self.theme = _G.JanisTheme:New({
        addon = self.addon.EventFrame,
        colors = colors,
        buttonPalettes = buttonPalettes,
    })
    self.addon.Theme = self.theme

    return self.theme
end

TDP.ThemeManager = ThemeManager:New(TDP)
TDP.ThemeManager:Create()
