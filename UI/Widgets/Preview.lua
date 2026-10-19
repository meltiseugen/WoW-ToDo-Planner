local _, TDP = ...
local Widgets = getmetatable(TDP.Widgets)

local PREVIEW_FIELD_LABELS = {
    ["Collection Type"] = "Type",
    ["Mount Source Category"] = "Source Category",
    ["Cosmetic Type"] = "Cosmetic Type",
    ["Appearance Progress"] = "Appearance Progress",
    ["Achievement Type"] = "Achievement Type",
    ["WoW Category"] = "WoW Category",
    ["WoW Parent Category"] = "WoW Parent Category",
    ["Description"] = "Description",
    ["Criteria"] = "Criteria",
    ["Source"] = "Source",
    ["How to get"] = "How to Get",
    ["Effect"] = "Effect",
    ["Requirements"] = "Requirements",
    ["Cost"] = "Cost",
    ["Cost guide"] = "Cost Guide",
    ["Availability"] = "Availability",
    ["Item notes"] = "Item Notes",
    ["Research notes"] = "Research Notes",
    ["Tips"] = "Tips",
    ["Reward"] = "Reward",
    ["Wowhead"] = "Wowhead",
}

local COLOR_END = "|r"

-- View translation uses UI units, so panning follows the cursor at any UI scale.
function Widgets:ConfigurePreviewModelDragging(model, owner)
    local function stopDragging()
        owner.previewModelDragButton = nil
        owner.previewModelDragX = nil
        owner.previewModelDragY = nil
    end

    model:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" and button ~= "RightButton" then
            return
        end
        owner.previewModelDragButton = button
        owner.previewModelDragX, owner.previewModelDragY = GetCursorPosition()
    end)

    model:SetScript("OnMouseUp", function(_, button)
        if button == owner.previewModelDragButton then
            stopDragging()
        end
    end)
    model:SetScript("OnHide", stopDragging)

    model:SetScript("OnUpdate", function()
        local button = owner.previewModelDragButton
        if not button then
            return
        end
        -- Also catch releases outside the viewer to avoid a stuck drag.
        if not IsMouseButtonDown(button) then
            stopDragging()
            return
        end

        local cursorX, cursorY = GetCursorPosition()
        local scale = model:GetEffectiveScale()
        local deltaX = (cursorX - owner.previewModelDragX) / scale
        local deltaY = (cursorY - owner.previewModelDragY) / scale
        owner.previewModelDragX, owner.previewModelDragY = cursorX, cursorY
        if button == "RightButton" then
            owner.previewModelPanX = (owner.previewModelPanX or 0) + deltaX
            owner.previewModelPanY = (owner.previewModelPanY or 0) + deltaY
        else
            owner.previewModelFacing = (owner.previewModelFacing or 0.45) + deltaX * 0.01
        end
        owner:ApplyPreviewModelTransform()
    end)
end

function Widgets:ConfigureDetailText(fontString, allowWrap)
    fontString:SetJustifyH("LEFT")
    if fontString.SetWordWrap then
        fontString:SetWordWrap(allowWrap == true)
    end
    if allowWrap and fontString.SetNonSpaceWrap then
        fontString:SetNonSpaceWrap(true)
    end
end

function Widgets:ConfigurePreviewDetailText(fontString)
    if GameFontHighlight then
        fontString:SetFontObject(GameFontHighlight)
    end
    self:ApplyTextColor(fontString, "text")
    fontString:SetJustifyH("LEFT")
    fontString:SetJustifyV("TOP")
    if fontString.SetWordWrap then
        fontString:SetWordWrap(true)
    end
    if fontString.SetNonSpaceWrap then
        fontString:SetNonSpaceWrap(true)
    end
    if fontString.SetSpacing then
        fontString:SetSpacing(3)
    end
end


function Widgets:FormatPreviewNotes(text)
    local formatted = {}
    local hasContent = false
    local previewHeadingColor = self:GetColorCode("previewHeading", { 1.0, 0.82, 0.36, 1.0 })
    local previewBodyColor = self:GetColorCode("previewBody", { 0.88, 0.90, 0.94, 1.0 })
    local previewMutedColor = self:GetColorCode("previewMuted", { 0.60, 0.64, 0.71, 1.0 })
    local previewSuccessColor = self:GetColorCode("previewSuccess", { 0.39, 0.84, 0.54, 1.0 })

    local function addSpacer()
        if hasContent and formatted[#formatted] ~= "" then
            formatted[#formatted + 1] = ""
        end
    end

    local function addBodyLine(line)
        local completedText = line:match("^%[Done%]%s*(.*)$")
        local pendingText = line:match("^%[ %]%s*(.*)$")
        local bulletText = line:match("^%-%s+(.*)$")

        if completedText then
            formatted[#formatted + 1] = previewSuccessColor .. "DONE" .. COLOR_END
                .. "  " .. previewBodyColor .. completedText .. COLOR_END
        elseif pendingText then
            formatted[#formatted + 1] = previewMutedColor .. "TODO" .. COLOR_END
                .. "  " .. previewBodyColor .. pendingText .. COLOR_END
        elseif bulletText then
            formatted[#formatted + 1] = previewHeadingColor .. "-" .. COLOR_END
                .. "  " .. previewBodyColor .. bulletText .. COLOR_END
        else
            formatted[#formatted + 1] = previewBodyColor .. line .. COLOR_END
        end
        hasContent = true
    end

    text = tostring(text or ""):gsub("\r\n", "\n"):gsub("\r", "\n")
    for line in (text .. "\n"):gmatch("(.-)\n") do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            local label, value = trimmed:match("^([^:]+):%s*(.*)$")
            local displayLabel = label and PREVIEW_FIELD_LABELS[label]
            if displayLabel then
                addSpacer()
                formatted[#formatted + 1] = previewHeadingColor .. string.upper(displayLabel) .. COLOR_END
                hasContent = true
                if value and value ~= "" then
                    addBodyLine(value)
                end
            else
                addBodyLine(trimmed)
            end
        end
    end

    return table.concat(formatted, "\n")
end

function Widgets:UpdateScrollablePreviewText(scrollFrame, content, fontString, text)
    if not scrollFrame or not content or not fontString then
        return
    end

    local width = math.max(1, (scrollFrame:GetWidth() or 1) - 4)
    fontString.rawPreviewText = tostring(text or "")
    fontString:SetWidth(width)
    fontString:SetText(self:FormatPreviewNotes(fontString.rawPreviewText))

    local textHeight = fontString.GetStringHeight and fontString:GetStringHeight() or 1
    local scrollHeight = scrollFrame:GetHeight() or 1
    local hasOverflow = textHeight + 12 > scrollHeight
    content:SetSize(width, math.max(scrollHeight, textHeight + 12))
    scrollFrame:SetVerticalScroll(0)
    if scrollFrame.UpdateScrollChildRect then
        scrollFrame:UpdateScrollChildRect()
    end

    local scrollBar = scrollFrame.ScrollBar or scrollFrame.scrollBar
    if scrollBar then
        if scrollBar.SetShown then
            scrollBar:SetShown(hasOverflow)
        elseif hasOverflow then
            scrollBar:Show()
        else
            scrollBar:Hide()
        end
    end
end
