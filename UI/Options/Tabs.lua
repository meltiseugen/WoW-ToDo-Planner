local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets
local TAB_ORDER = OptionsWindow.Config.TAB_ORDER

function OptionsWindow:ApplyTabVisualState(button, isSelected)
    if not button then
        return
    end

    if type(button.SetSelected) == "function" then
        button:SetSelected(isSelected == true)
    else
        button:SetEnabled(not isSelected)
    end
end

function OptionsWindow:SelectTab(tabKey)
    self.selectedTab = tabKey or "General"

    for _, key in ipairs(TAB_ORDER) do
        local tab = self.tabs and self.tabs[key]
        local isSelected = key == self.selectedTab
        if tab and tab.container then
            if isSelected then
                tab.container:Show()
                if tab.content then
                    local contentWidth = (tab.container:GetWidth() or 0) - 32
                    tab.content:SetWidth(math.max(1, contentWidth))
                end
                if tab.scrollFrame then
                    tab.scrollFrame:SetVerticalScroll(0)
                    if tab.scrollFrame.UpdateScrollChildRect then
                        tab.scrollFrame:UpdateScrollChildRect()
                    end
                end
            else
                tab.container:Hide()
            end
        end
        if tab and tab.button then
            self:ApplyTabVisualState(tab.button, isSelected)
        end
    end
end

function OptionsWindow:CreateTab(panel, key)
    local container = CreateFrame("Frame", nil, panel)
    container:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -112)
    container:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -42, 18)
    container:Hide()

    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(target, delta)
        local nextScroll = target:GetVerticalScroll() - (delta * 40)
        local maxScroll = target:GetVerticalScrollRange()
        if nextScroll < 0 then
            nextScroll = 0
        elseif nextScroll > maxScroll then
            nextScroll = maxScroll
        end
        target:SetVerticalScroll(nextScroll)
    end)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1, 1)
    scrollFrame:SetScrollChild(content)

    container:SetScript("OnSizeChanged", function(_, width)
        content:SetWidth(math.max(1, width - 32))
    end)

    self.tabs[key] = {
        container = container,
        scrollFrame = scrollFrame,
        content = content,
        button = nil,
    }

    return self.tabs[key]
end

function OptionsWindow:CreateSection(parent, previousSection, titleText, descriptionText, height)
    local section = Widgets:CreatePanel(parent, "section", "goldBorder")
    if previousSection then
        section:SetPoint("TOPLEFT", previousSection, "BOTTOMLEFT", 0, -12)
        section:SetPoint("TOPRIGHT", previousSection, "BOTTOMRIGHT", 0, -12)
    else
        section:SetPoint("TOPLEFT", parent, "TOPLEFT", 4, -6)
        section:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -12, -6)
    end
    section:SetHeight(height)
    section.topAccent = Widgets:AddGoldTopAccent(section, 2, 0.18)
    section.contentTopOffset = (type(descriptionText) == "string" and descriptionText ~= "") and -54 or -40

    local title = Widgets:CreateFontString(section, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", section, "TOPLEFT", 14, -12)
    title:SetPoint("TOPRIGHT", section, "TOPRIGHT", -14, -12)
    title:SetJustifyH("LEFT")
    title:SetText(titleText or "")

    if type(descriptionText) == "string" and descriptionText ~= "" then
        local description = Widgets:CreateFontString(section, "OVERLAY", "GameFontHighlightSmall")
        description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        description:SetPoint("TOPRIGHT", section, "TOPRIGHT", -14, 0)
        description:SetJustifyH("LEFT")
        Widgets:ApplyTextColor(description, "textMuted")
        description:SetText(descriptionText)
    end

    return section
end
