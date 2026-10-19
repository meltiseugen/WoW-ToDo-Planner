-- Minimal headless frame API. It records construction and explicit interactions;
-- it does not emulate WoW rendering, secure execution, or automatic UI events.
local Mock = { trace = {}, serial = 0 }
local methods = {}
local function record(frame, method, ...)
    local entry = { frame.id, method }
    for index = 1, select("#", ...) do
        local value = select(index, ...)
        if type(value) == "table" then
            value = value.id and ("frame:" .. value.id) or "table"
        elseif type(value) == "function" then
            value = "function"
        elseif value == nil then
            value = "nil"
        end
        entry[#entry + 1] = value
    end
    Mock.trace[#Mock.trace + 1] = entry
end
local metatable = { __index = function(frame, key)
    if methods[key] then return methods[key] end
    if key:match("^Set") or key:match("^Enable") or key:match("^Register")
        or key:match("^Clear") or key:match("^Start") or key:match("^Stop")
        or key == "Raise" or key == "Disable" or key == "HighlightText" then
        return function(self, ...) record(self, key, ...) end
    end
end }
function Mock:Create(kind, name, parent, template)
    self.serial = self.serial + 1
    local frame = setmetatable({
        id = self.serial, kind = kind, name = name, parent = parent,
        scripts = {}, children = {}, width = 600, height = 400, shown = true,
        level = 1, strata = "MEDIUM", text = "", points = {},
    }, metatable)
    record(frame, "Create", kind, name, parent, template)
    if parent then parent.children[#parent.children + 1] = frame end
    if name then _G[name] = frame end
    return frame
end
function methods:CreateTexture(name, layer) return Mock:Create("Texture", name, self, layer) end
function methods:CreateFontString(name, layer, font) return Mock:Create("FontString", name, self, font or layer) end
function methods:SetScript(event, callback) self.scripts[event] = callback; record(self, "SetScript", event, callback) end
function methods:GetScript(event) return self.scripts[event] end
function methods:HookScript(event, callback)
    local previous = self.scripts[event]
    self.scripts[event] = function(...)
        if previous then previous(...) end
        callback(...)
    end
    record(self, "HookScript", event)
end
function methods:SetSize(width, height) self.width = width; self.height = height; record(self, "SetSize", width, height) end
function methods:SetWidth(width) self.width = width; record(self, "SetWidth", width) end
function methods:SetHeight(height) self.height = height; record(self, "SetHeight", height) end
function methods:GetWidth() return self.width end
function methods:GetHeight() return self.height end
function methods:GetSize() return self.width, self.height end
function methods:SetText(text) self.text = tostring(text or ""); record(self, "SetText", text) end
function methods:GetText() return self.text end
function methods:GetStringHeight() return self.text == "" and 0 or 16 end
function methods:GetStringWidth() return #self.text * 6 end
function methods:GetNumLines() return 1 end
function methods:GetParent() return self.parent end
function methods:GetChildren() return unpack(self.children) end
function methods:SetParent(parent) self.parent = parent; record(self, "SetParent", parent) end
function methods:GetName() return self.name end
function methods:GetObjectType() return self.kind end
function methods:GetFrameLevel() return self.level end
function methods:SetFrameLevel(level) self.level = level; record(self, "SetFrameLevel", level) end
function methods:GetFrameStrata() return self.strata end
function methods:SetFrameStrata(strata) self.strata = strata; record(self, "SetFrameStrata", strata) end
function methods:GetEffectiveScale() return 1 end
function methods:GetScale() return 1 end
function methods:GetCenter() return 500, 300 end
function methods:GetPoint() return "CENTER", UIParent, "CENTER", 0, 0 end
function methods:GetLeft() return 0 end
function methods:GetRight() return self.width end
function methods:GetTop() return self.height end
function methods:GetBottom() return 0 end
function methods:IsShown() return self.shown end
function methods:IsVisible() return self.shown end
function methods:Show() self.shown = true; record(self, "Show") end
function methods:Hide() self.shown = false; record(self, "Hide") end
function methods:SetShown(shown) if shown then self:Show() else self:Hide() end end
function methods:GetVerticalScroll() return 0 end
function methods:GetHorizontalScroll() return 0 end
function methods:GetVerticalScrollRange() return 0 end
function methods:GetFont() return "test-font", 12, "" end
function methods:GetFontString() return self end
function methods:HasScript() return true end

CreateFrame = function(...) return Mock:Create(...) end
UIParent = Mock:Create("Frame", "UIParent")
UISpecialFrames = {}
StaticPopupDialogs = {}
YES, NO = "Yes", "No"
GameFontNormal, GameFontDisableSmall = "GameFontNormal", "GameFontDisableSmall"
GameFontHighlight, GameFontHighlightSmall = "GameFontHighlight", "GameFontHighlightSmall"
function time() return 1000 end
function date() return "2026-10-18" end
function UnitFullName() return "Collector", "Realm" end
function UnitName() return "Collector" end
function GetRealmName() return "Realm" end
function GetCursorPosition() return 0, 0 end
function IsMouseButtonDown() return false end
function wipe(values) for key in pairs(values) do values[key] = nil end end
return Mock
