-- Geometry and explicit UI events for the real Options code. This is an offline
-- layout aid, not a substitute for WoW's rendering or input handling.
return function(root, skin)
    local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
    local create = mock.Create
    mock.widgets = {}
    function mock:Create(kind, name, parent, template)
        local frame = create(self, kind, name, parent, template)
        self.widgets[#self.widgets + 1] = frame
        frame.width, frame.height = nil, nil
        frame.fontSize = template and template:find("Large") and 16 or 12
        frame.template = template
        function frame:SetPoint(point, relative, relativePoint, x, y)
            if type(relative) == "number" then
                x, y, relative, relativePoint = relative, relativePoint, self.parent, point
            end
            for i, old in ipairs(self.points) do
                if old[1] == point then table.remove(self.points, i); break end
            end
            self.points[#self.points + 1] = { point, relative or self.parent, relativePoint or point, x or 0, y or 0 }
        end
        function frame:ClearAllPoints() self.points = {}; self.allPoints = nil end
        function frame:SetAllPoints(target) self.allPoints = target or self.parent end
        local function factor(point, axis)
            if axis == "x" then return point:find("LEFT") and 0 or point:find("RIGHT") and 1 or 0.5 end
            return point:find("TOP") and 0 or point:find("BOTTOM") and 1 or 0.5
        end
        function frame:Bounds(axis)
            if self == UIParent then return 0, axis == "x" and 1600 or 1100 end
            if self.allPoints then return self.allPoints:Bounds(axis) end
            local size = axis == "x" and self.width or self.height
            if axis == "y" and self.kind == "FontString" and not size then size = self:GetStringHeight() end
            local first, second
            for _, p in ipairs(self.points) do
                local pos, extent
                if p[2] == UIParent then pos, extent = 0, axis == "x" and 1600 or 1100
                else pos, extent = p[2]:Bounds(axis) end
                local candidate = { factor(p[1], axis), pos + factor(p[3], axis) * extent + (axis == "x" and p[4] or -p[5]) }
                if not first then first = candidate elseif candidate[1] ~= first[1] then second = candidate end
            end
            if second then size = (second[2] - first[2]) / (second[1] - first[1]) end
            size = size or (axis == "x" and 100 or 24)
            return first and first[2] - first[1] * size or 0, size
        end
        function frame:GetWidth() local _, value = self:Bounds("x"); return value end
        function frame:GetHeight() local _, value = self:Bounds("y"); return value end
        function frame:GetSize() return self:GetWidth(), self:GetHeight() end
        function frame:SetWordWrap(value) self.wordWrap = value end
        function frame:SetJustifyH(value) self.justify = value end
        function frame:GetStringHeight()
            if self.text == "" then return 0 end
            if self.wordWrap == false then return self.fontSize + 3 end
            local width = math.max(1, self:GetWidth())
            if OPTIONS_MEASURE then return OPTIONS_MEASURE(self.text, width, self.fontSize) end
            return math.max(1, math.ceil(#self.text * 6 / width)) * (self.fontSize + 3)
        end
        function frame:GetFont() return "test-font", self.fontSize, "" end
        function frame:SetText(value)
            self.text = tostring(value or "")
            if self.scripts.OnTextChanged then self.scripts.OnTextChanged(self) end
        end
        function frame:SetSize(w, h)
            self.width, self.height = w, h
            if self.scripts.OnSizeChanged then self.scripts.OnSizeChanged(self, w, h) end
        end
        function frame:SetBackdrop(backdrop) self.backdrop = backdrop end
        function frame:SetBackdropColor(...) self.fillColor = { ... } end
        function frame:SetColorTexture(...) self.fillColor = { ... } end
        function frame:SetTextColor(...) self.color = { ... } end
        function frame:SetTexture(texture) self.texture = texture end
        function frame:SetAlpha(alpha) self.alpha = alpha end
        function frame:SetEnabled(value) self.enabled = value end
        function frame:IsEnabled() return self.enabled ~= false end
        function frame:ClearFocus()
            self.focused = false
            if self.scripts.OnEditFocusLost then self.scripts.OnEditFocusLost(self) end
        end
        function frame:HasFocus() return self.focused == true end
        function frame:SetScrollChild(child)
            self.child = child
            child:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
        end
        function frame:SetVerticalScroll(value) self.scroll = value end
        function frame:GetVerticalScroll() return self.scroll or 0 end
        function frame:GetVerticalScrollRange() return math.max(0, self.child:GetHeight() - self:GetHeight()) end
        function frame:UpdateScrollChildRect() end
        function frame:Hide()
            local shown = self.shown
            self.shown = false
            if shown and self.scripts.OnHide then self.scripts.OnHide(self) end
        end
        return frame
    end
    GameTooltip = { lines = {} }
    function GameTooltip:SetOwner(owner) self.owner = owner end
    function GameTooltip:SetText(value) self.lines = { value } end
    function GameTooltip:AddLine(value) self.lines[#self.lines + 1] = value end
    function GameTooltip:Show() self.shown = true end
    function GameTooltip:Hide() self.shown = false end
    local TDP = {}
    local function load(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
    load("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
    load("Core/Constants.lua")
    load("Core/Utils.lua")
    load("Core/Theme.lua")
    load("Core/MinimapButton.lua")
    TODOPlannerDB = TDP.Utils:CopyDefaults({}, TDP.Constants.DEFAULT_DB)
    TODOPlannerDB.settings.visualTheme = skin or "midnight"
    TDP.ThemeManager:Create()
    assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, "UI/Widgets/Widgets.xml", "UI/Options/Options.xml")
    local window = TDP.OptionsWindow:New({})
    window:Build()
    window:Open()
    return window, TDP, mock
end
