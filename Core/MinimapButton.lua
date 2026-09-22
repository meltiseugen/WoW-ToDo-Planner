local _, TDP = ...

local MinimapButton = {}
MinimapButton.__index = MinimapButton

local BUTTON_EDGE_PADDING = 5
local DEFAULT_ANGLE = 225
local DIAGONAL_ROUNDING = 10

local MINIMAP_SHAPES = {
    ROUND = { true, true, true, true },
    SQUARE = { false, false, false, false },
    ["CORNER-TOPLEFT"] = { false, false, false, true },
    ["CORNER-TOPRIGHT"] = { false, false, true, false },
    ["CORNER-BOTTOMLEFT"] = { false, true, false, false },
    ["CORNER-BOTTOMRIGHT"] = { true, false, false, false },
    ["SIDE-LEFT"] = { false, true, false, true },
    ["SIDE-RIGHT"] = { true, false, true, false },
    ["SIDE-TOP"] = { false, false, true, true },
    ["SIDE-BOTTOM"] = { true, true, false, false },
    ["TRICORNER-TOPLEFT"] = { false, true, true, true },
    ["TRICORNER-TOPRIGHT"] = { true, false, true, true },
    ["TRICORNER-BOTTOMLEFT"] = { true, true, false, true },
    ["TRICORNER-BOTTOMRIGHT"] = { true, true, true, false },
}

local function atan2(y, x)
    if math.atan2 then
        return math.atan2(y, x)
    end

    if x > 0 then
        return math.atan(y / x)
    end
    if x < 0 and y >= 0 then
        return math.atan(y / x) + math.pi
    end
    if x < 0 and y < 0 then
        return math.atan(y / x) - math.pi
    end
    if y > 0 then
        return math.pi / 2
    end
    if y < 0 then
        return -math.pi / 2
    end

    return 0
end

function MinimapButton:New(addon)
    return setmetatable({
        addon = addon,
        frame = nil,
    }, self)
end

function MinimapButton:EnsureSettings()
    TODOPlannerDB.settings = TODOPlannerDB.settings or {}
    if type(TODOPlannerDB.settings.minimapButton) ~= "table" then
        TODOPlannerDB.settings.minimapButton = {}
    end
    if type(TODOPlannerDB.settings.minimapButton.hidden) ~= "boolean" then
        TODOPlannerDB.settings.minimapButton.hidden = false
    end
    if type(TODOPlannerDB.settings.minimapButton.angle) ~= "number" then
        TODOPlannerDB.settings.minimapButton.angle = DEFAULT_ANGLE
    end
end

function MinimapButton:GetSettings()
    self:EnsureSettings()
    return TODOPlannerDB.settings.minimapButton
end

function MinimapButton:UpdatePosition()
    if not self.frame or not Minimap then
        return
    end

    local settings = self:GetSettings()
    local radians = math.rad(settings.angle or DEFAULT_ANGLE)
    local x = math.cos(radians)
    local y = math.sin(radians)
    local quadrant = 1
    if x < 0 then
        quadrant = quadrant + 1
    end
    if y > 0 then
        quadrant = quadrant + 2
    end

    local horizontalRadius = (Minimap:GetWidth() / 2) + BUTTON_EDGE_PADDING
    local verticalRadius = (Minimap:GetHeight() / 2) + BUTTON_EDGE_PADDING
    local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
    local quadrantMap = MINIMAP_SHAPES[minimapShape] or MINIMAP_SHAPES.ROUND

    if quadrantMap[quadrant] then
        x = x * horizontalRadius
        y = y * verticalRadius
    else
        local diagonalHorizontalRadius = math.sqrt(2 * (horizontalRadius ^ 2)) - DIAGONAL_ROUNDING
        local diagonalVerticalRadius = math.sqrt(2 * (verticalRadius ^ 2)) - DIAGONAL_ROUNDING
        x = math.max(-horizontalRadius, math.min(x * diagonalHorizontalRadius, horizontalRadius))
        y = math.max(-verticalRadius, math.min(y * diagonalVerticalRadius, verticalRadius))
    end

    self.frame:ClearAllPoints()
    self.frame:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function MinimapButton:UpdateDragPosition()
    if not self.frame or not Minimap then
        return
    end

    local centerX, centerY = Minimap:GetCenter()
    if not centerX or not centerY then
        return
    end

    local cursorX, cursorY = GetCursorPosition()
    -- GetCenter() is expressed in the minimap's coordinate space, so the
    -- hardware cursor must use the minimap's effective scale as well. Using
    -- UIParent's scale makes the angle drift when the minimap is scaled.
    local scale = Minimap.GetEffectiveScale and Minimap:GetEffectiveScale()
    if not scale and UIParent and UIParent.GetEffectiveScale then
        scale = UIParent:GetEffectiveScale()
    end
    scale = scale or 1
    if scale == 0 then
        scale = 1
    end

    cursorX = cursorX / scale
    cursorY = cursorY / scale

    local angle = math.deg(atan2(cursorY - centerY, cursorX - centerX))
    self:GetSettings().angle = (angle + 360) % 360
    self:UpdatePosition()
end

function MinimapButton:SetShown(shown)
    local settings = self:GetSettings()
    settings.hidden = shown ~= true
    self:UpdateVisibility()
end

function MinimapButton:IsShown()
    return self:GetSettings().hidden ~= true
end

function MinimapButton:UpdateVisibility()
    if not self.frame then
        return
    end

    self:UpdatePosition()
    if self:IsShown() then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

function MinimapButton:TogglePlanner()
    if self.addon.SlashCommands and self.addon.SlashCommands.ToggleMainFrame then
        self.addon.SlashCommands:ToggleMainFrame()
        return
    end

    local ui = self.addon.ui
    if not ui or not ui.frame then
        return
    end

    if ui.frame:IsShown() then
        ui.frame:Hide()
    else
        ui:SelectDefaultBoard()
        ui:ResetEditor()
        ui:Render()
        ui.frame:Show()
    end
end

function MinimapButton:OpenOptions()
    local ui = self.addon.ui
    if ui and ui.OpenOptions then
        ui:OpenOptions()
    end
end

function MinimapButton:Build()
    if self.frame or not Minimap then
        return self.frame
    end

    local button = CreateFrame("Button", "TODOPlannerMinimapButton", Minimap)
    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel((Minimap:GetFrameLevel() or 0) + 8)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local background = button:CreateTexture(nil, "BACKGROUND")
    background:SetSize(20, 20)
    background:SetPoint("CENTER", 0, 0)
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 0)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Note_01")
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    button.icon = icon

    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT", 0, 0)
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    button:SetScript("OnClick", function(target, mouseButton)
        if target.isDragging then
            target.isDragging = false
            return
        end

        if mouseButton == "RightButton" then
            self:OpenOptions()
        else
            self:TogglePlanner()
        end
    end)

    button:SetScript("OnDragStart", function()
        button.isDragging = true
        button:SetScript("OnUpdate", function()
            self:UpdateDragPosition()
        end)
    end)

    button:SetScript("OnDragStop", function()
        button:SetScript("OnUpdate", nil)
        self:UpdateDragPosition()
        if C_Timer and C_Timer.After then
            C_Timer.After(0.05, function()
                button.isDragging = false
            end)
        end
    end)

    button:SetScript("OnEnter", function(target)
        GameTooltip:SetOwner(target, "ANCHOR_LEFT")
        GameTooltip:SetText("TODO Planner")
        GameTooltip:AddLine("Left-click to open the planner.", 1, 1, 1, true)
        GameTooltip:AddLine("Right-click to open options.", 1, 1, 1, true)
        GameTooltip:AddLine("Drag to move this button.", 0.62, 0.66, 0.74, true)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    self.frame = button
    self:UpdateVisibility()
    return button
end

function MinimapButton:Init()
    self:EnsureSettings()
    self:Build()
end

TDP.MinimapButton = MinimapButton:New(TDP)
