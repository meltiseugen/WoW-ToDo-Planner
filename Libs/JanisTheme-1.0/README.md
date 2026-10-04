# TODO Planner theme library

This is TODO Planner's private theme renderer. It deliberately uses
`_G.TODOPlannerThemeLibrary` instead of the shared `_G.JanisTheme` global so
another addon embedding a different JanisTheme build cannot replace its art
and widget behavior according to addon load order.

## Embedded Usage

Load the library before your addon UI files:

```toc
Libs/JanisTheme-1.0/JanisTheme-1.0.lua
```

Then create an addon-local theme instance:

```lua
local _, NS = ...
NS.Theme = _G.TODOPlannerThemeLibrary:New({ addon = NS.MyAddon })
```

Use it from windows:

```lua
local Theme = NS.Theme

local frame = CreateFrame("Frame", "MyAddonWindow", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(700, 480)
frame:SetPoint("CENTER")
frame:SetFrameStrata("DIALOG")
frame:SetToplevel(true)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")

local chrome = Theme:ApplyWindowChrome(frame, "My Window")

local body = Theme:CreatePanel(frame, "panel", "goldBorder")
body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)

local button = Theme:CreateButton(body, 120, 24, "Run", "primary")
button:SetPoint("TOPLEFT", body, "TOPLEFT", 14, -14)
```
