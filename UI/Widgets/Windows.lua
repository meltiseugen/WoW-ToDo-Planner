local _, TDP = ...
local Widgets = getmetatable(TDP.Widgets)
local DEFAULT_WINDOW_STRATA = "DIALOG"

function Widgets:GetTopLevelWindow(frame)
    local current = frame
    while current do
        if current.todoPlannerTopLevelWindow then
            return current
        end
        if type(current.GetParent) ~= "function" then
            break
        end
        current = current:GetParent()
    end

    return nil
end

function Widgets:BringToFront(frame, relativeFrame)
    local window = self:GetTopLevelWindow(frame) or frame
    if not window then
        return
    end

    if type(window.SetFrameStrata) == "function" then
        local strata = window.todoPlannerFrameStrata
            or (type(window.GetFrameStrata) == "function" and window:GetFrameStrata())
            or DEFAULT_WINDOW_STRATA
        window:SetFrameStrata(strata)
    end
    if type(window.SetToplevel) == "function" then
        window:SetToplevel(true)
    end

    self.windowFrameLevel = (tonumber(self.windowFrameLevel) or 100) + 20
    if self.windowFrameLevel > 9000 then
        self.windowFrameLevel = 120
        for registeredWindow in pairs(self.windowFrames or {}) do
            if registeredWindow ~= window and registeredWindow.IsShown and registeredWindow:IsShown() and registeredWindow.SetFrameLevel then
                registeredWindow:SetFrameLevel(100)
            end
        end
    end

    local level = self.windowFrameLevel
    if relativeFrame and relativeFrame ~= window and type(relativeFrame.GetFrameLevel) == "function" then
        level = math.max(level, (tonumber(relativeFrame:GetFrameLevel()) or 0) + 20)
    end

    if type(window.SetFrameLevel) == "function" then
        window:SetFrameLevel(level)
    end
    local Theme = self:GetTheme()
    if Theme and type(Theme.RefreshArtFrameLevel) == "function" then
        Theme:RefreshArtFrameLevel(window)
    end
    if type(window.Raise) == "function" then
        window:Raise()
    end
end

function Widgets:HookFrameScript(frame, scriptName, handler)
    if not frame or type(handler) ~= "function" then
        return
    end

    if type(frame.HookScript) == "function" then
        frame:HookScript(scriptName, handler)
        return
    end

    if type(frame.GetScript) == "function" and type(frame.SetScript) == "function" then
        local previous = frame:GetScript(scriptName)
        frame:SetScript(scriptName, function(...)
            if previous then
                previous(...)
            end
            handler(...)
        end)
    end
end

function Widgets:RegisterTopLevelWindow(frame, options)
    if not frame then
        return
    end

    options = type(options) == "table" and options or {}
    self.windowFrames[frame] = true
    frame.todoPlannerTopLevelWindow = true
    frame.todoPlannerFrameStrata = options.strata or DEFAULT_WINDOW_STRATA

    if type(frame.SetFrameStrata) == "function" then
        frame:SetFrameStrata(frame.todoPlannerFrameStrata)
    end
    if type(frame.SetToplevel) == "function" then
        frame:SetToplevel(true)
    end

    self:HookFrameScript(frame, "OnMouseDown", function(target)
        self:BringToFront(target)
    end)
    self:HookFrameScript(frame, "OnDragStart", function(target)
        self:BringToFront(target)
    end)
    self:HookFrameScript(frame, "OnShow", function(target)
        self:BringToFront(target, options.relativeFrame)
    end)
end

function Widgets:RaiseParentWindowOnInteraction(frame)
    if not frame then
        return frame
    end

    self:HookFrameScript(frame, "OnMouseDown", function(target)
        local window = self:GetTopLevelWindow(target)
        if window then
            self:BringToFront(window)
        end
    end)
    return frame
end

function Widgets:CreateWindowNavigation(parent, currentWindow, ownerWindow, options)
    options = type(options) == "table" and options or {}

    local destinations = {
        { key = "home", label = "Home", width = 72, method = "Open" },
        { key = "favorites", label = "Favorites", width = 86, method = "OpenFavorites" },
        { key = "collections", label = "Collections", width = 92, method = "OpenExplorer" },
        { key = "planner", label = "Planner", width = 78, method = "OpenPlanner" },
    }
    local visibleDestinations = {}
    for _, destination in ipairs(destinations) do
        if destination.key ~= currentWindow then
            visibleDestinations[#visibleDestinations + 1] = destination
        end
    end

    local buttons = {}
    local rightAnchor = options.anchorTo
    local gap = options.gap or 8

    local function createNavigationButton(buttonParent, destination)
        local button = self:CreateTabButton(buttonParent, destination.width, 24, destination.label)
        button:SetScript("OnClick", function()
            local sourceWindow = self:GetTopLevelWindow(button)
            if sourceWindow then
                sourceWindow:Hide()
            end

            local homeWindow = (ownerWindow and ownerWindow.homeWindow) or self.addon.ui
            local openMethod = homeWindow and homeWindow[destination.method]
            if type(openMethod) == "function" then
                openMethod(homeWindow)
            elseif self.addon.Utils then
                self.addon.Utils:Msg(destination.label .. " window is unavailable.")
            end
        end)
        buttons[destination.key] = button
        return button
    end

    if options.centered then
        local totalWidth = 0
        for _, destination in ipairs(visibleDestinations) do
            totalWidth = totalWidth + destination.width
        end
        totalWidth = totalWidth + (math.max(#visibleDestinations - 1, 0) * gap)

        local navigationFrame = CreateFrame("Frame", nil, parent)
        navigationFrame:SetSize(totalWidth, 24)
        navigationFrame:SetPoint(
            "CENTER",
            parent,
            "CENTER",
            options.centerOffsetX or 0,
            options.centerOffsetY or 0
        )

        local previousButton
        for _, destination in ipairs(visibleDestinations) do
            local button = createNavigationButton(navigationFrame, destination)
            if previousButton then
                button:SetPoint("LEFT", previousButton, "RIGHT", gap, 0)
            else
                button:SetPoint("LEFT", navigationFrame, "LEFT", 0, 0)
            end
            previousButton = button
        end

        buttons.frame = navigationFrame
        return buttons
    end

    for index = #visibleDestinations, 1, -1 do
        local destination = visibleDestinations[index]
        local button = createNavigationButton(parent, destination)
        if rightAnchor then
            button:SetPoint("RIGHT", rightAnchor, "LEFT", -gap, 0)
        else
            button:SetPoint("TOPRIGHT", parent, "TOPRIGHT", options.rightOffset or -12, options.topOffset or -12)
        end
        rightAnchor = button
    end

    return buttons
end

function Widgets:GetFramePositionTable()
    if not TODOPlannerDB or not TODOPlannerDB.settings then
        return nil
    end

    if type(TODOPlannerDB.settings.framePositions) ~= "table" then
        TODOPlannerDB.settings.framePositions = {}
    end

    return TODOPlannerDB.settings.framePositions
end

function Widgets:NormalizeFramePosition(position, defaultX, defaultY)
    position = type(position) == "table" and position or {}
    return {
        point = type(position.point) == "string" and position.point or "CENTER",
        x = tonumber(position.x) or (defaultX or 0),
        y = tonumber(position.y) or (defaultY or 0),
    }
end

function Widgets:GetSavedFramePosition(windowKey, defaultX, defaultY)
    local positions = self:GetFramePositionTable()
    local position = positions and positions[windowKey]

    if type(position) ~= "table"
        and (windowKey == "home" or windowKey == "planner")
        and TODOPlannerDB
        and TODOPlannerDB.settings then
        position = TODOPlannerDB.settings.frame
    end

    return self:NormalizeFramePosition(position, defaultX, defaultY)
end

function Widgets:ApplyFramePosition(frame, windowKey, defaultX, defaultY)
    local position = self:GetSavedFramePosition(windowKey, defaultX, defaultY)
    frame:ClearAllPoints()
    frame:SetPoint(position.point, UIParent, position.point, position.x, position.y)
end

function Widgets:SaveFramePosition(frame, windowKey)
    local point, _, _, x, y = frame:GetPoint(1)
    local position = self:NormalizeFramePosition({
        point = point,
        x = x,
        y = y,
    })

    if windowKey then
        local positions = self:GetFramePositionTable()
        if positions then
            positions[windowKey] = position
        end
    else
        TODOPlannerDB.settings.frame = position
    end

    if windowKey == "planner" then
        TODOPlannerDB.settings.frame = position
    end
end

function Widgets:ResetFramePosition(windowKey, frame, defaultX, defaultY)
    local position = self:NormalizeFramePosition(nil, defaultX, defaultY)
    local positions = self:GetFramePositionTable()
    if positions and windowKey then
        positions[windowKey] = position
    end

    if windowKey == "planner" or not windowKey then
        TODOPlannerDB.settings.frame = position
    end

    if frame then
        frame:ClearAllPoints()
        frame:SetPoint(position.point, UIParent, position.point, position.x, position.y)
    end
end
