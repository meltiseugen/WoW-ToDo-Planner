local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets

local function PreviewText(theme, parent, text, color)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    theme:ApplyFontTreatment(label)
    label:SetTextColor(unpack(theme:GetColor(color)))
    label:SetJustifyH("LEFT")
    label:SetText(text)
    return label
end

function OptionsWindow:CreateThemeGallery(row)
    row.cards = {}
    for _, key in ipairs(self.Config.VISUAL_THEME_OPTIONS) do
        local themeKey = key
        local spec = TDP.ThemeManager:BuildSpec(themeKey)
        local theme = _G.TODOPlannerThemeLibrary:New(spec)
        local card = Widgets:CreatePanel(row, "section", "goldBorder")
        card:SetHeight(174)
        local title = self:Text(card, self.Config.VISUAL_THEME_LABELS[key], "GameFontNormalSmall")
        title:SetPoint("TOPLEFT", 12, -12)
        title:SetPoint("TOPRIGHT", -12, -12)
        title:SetWordWrap(false)

        -- Independent theme instances preview real assets without changing TDP.Theme.
        local sample = theme:CreatePanel(card, "body", "goldBorderStrong")
        sample:SetPoint("TOPLEFT", 10, -36)
        sample:SetPoint("TOPRIGHT", -10, -36)
        sample:SetHeight(87)
        local heading = PreviewText(theme, sample, "Explore the world", "textStrong")
        heading:SetPoint("TOPLEFT", 10, -12)
        heading:SetPoint("TOPRIGHT", -10, -12)
        local criteria = PreviewText(theme, sample, "Treasures found   3 / 8", "text")
        criteria:SetPoint("TOPLEFT", 10, -35)
        criteria:SetPoint("TOPRIGHT", -10, -35)
        local track = sample:CreateTexture(nil, "ARTWORK")
        track:SetPoint("TOPLEFT", 10, -59)
        track:SetPoint("TOPRIGHT", -10, -59)
        track:SetHeight(6)
        track:SetColorTexture(unpack(theme:GetColor("input")))
        local fill = sample:CreateTexture(nil, "OVERLAY")
        fill:SetPoint("TOPLEFT", track, "TOPLEFT", 0, 0)
        fill:SetHeight(6)
        local accent = theme:GetColor("accentGold")
        fill:SetColorTexture(accent[1], accent[2], accent[3], 1)
        local choose = Widgets:CreateButton(card, 120, 26, "Use this skin", "neutral")
        choose:SetPoint("BOTTOMLEFT", 10, 10)
        choose:SetPoint("BOTTOMRIGHT", -10, 10)
        choose:SetScript("OnClick", function() self:SetVisualTheme(themeKey) end)
        self:BindHelp(choose, self.Config.VISUAL_THEME_LABELS[key], self.ThemeDescriptions[key]
            .. " Your choice takes effect after Reload UI.")
        card.choose, card.fill, card.themeKey = choose, fill, key
        row.cards[#row.cards + 1] = card
    end
    row.themeStatus = self:Text(row, "", "GameFontHighlightSmall", "textSoft")
    row.refreshControl = function(target)
        local selected = TODOPlannerDB.settings.visualTheme
        local active = TDP.Theme and TDP.Theme.key or selected
        for _, card in ipairs(target.cards) do
            local isSelected = card.themeKey == selected
            self:ApplyTabVisualState(card.choose, isSelected)
            card.choose:SetText(isSelected and (selected == active and "Active skin" or "Selected - reload") or "Use this skin")
            Widgets:ApplyPanelBackdrop(card, "section", isSelected and "goldBorderStrong" or "goldBorder")
        end
        target.themeStatus:SetText(self.Config.VISUAL_THEME_LABELS[selected]
            .. (selected == active and " is active." or " selected. Use Reload UI below to apply it."))
    end
    row.layoutControl = function(target, width, top)
        local columns = width >= 620 and 3 or 2
        local cardWidth = (width - (columns - 1) * 12) / columns
        for index, card in ipairs(target.cards) do
            card:ClearAllPoints()
            card:SetPoint("TOPLEFT", (index - 1) % columns * (cardWidth + 12), -top - math.floor((index - 1) / columns) * 186)
            card:SetWidth(cardWidth)
            card.fill:SetWidth((cardWidth - 40) * 3 / 8)
        end
        local bottom = top + math.ceil(#target.cards / columns) * 186
        target.themeStatus:ClearAllPoints()
        target.themeStatus:SetPoint("TOPLEFT", 0, -bottom)
        target.themeStatus:SetWidth(width)
        return bottom + target.themeStatus:GetStringHeight() + 12
    end
end

function OptionsWindow:CreateProgressPreview(row)
    local sample = Widgets:CreatePanel(row, "input", "inputBorder")
    sample:SetHeight(94)
    local caption = self:Text(sample, "Example criterion", "GameFontNormalSmall")
    caption:SetPoint("TOPLEFT", 12, -12)
    local label = self:Text(sample, "Discover hidden treasures", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 12, -34)
    local progress = self:Text(sample, "3 / 8", "GameFontHighlightSmall")
    progress:SetPoint("TOPRIGHT", -12, -34)
    local track = sample:CreateTexture(nil, "ARTWORK")
    track:SetPoint("TOPLEFT", 12, -62)
    track:SetPoint("TOPRIGHT", -12, -62)
    track:SetHeight(8)
    Widgets:SetTextureColor(track, "section")
    local fill = sample:CreateTexture(nil, "OVERLAY")
    fill:SetPoint("TOPLEFT", track, "TOPLEFT", 0, 0)
    fill:SetHeight(8)
    Widgets:SetTextureColor(fill, "accentGold")
    row.preview, row.track, row.fill = sample, track, fill
end

function OptionsWindow:CreateMapPreview(row)
    local sample = Widgets:CreatePanel(row, "input", "inputBorder")
    sample:SetHeight(128)
    local caption = self:Text(sample, "Pin size preview", "GameFontNormalSmall")
    caption:SetPoint("TOPLEFT", 12, -12)
    local pin = sample:CreateTexture(nil, "ARTWORK")
    pin:SetPoint("CENTER", sample, "CENTER", 0, -12)
    pin:SetTexture("Interface\\Icons\\INV_Misc_Map02")
    local ring = sample:CreateTexture(nil, "BACKGROUND")
    ring:SetPoint("CENTER", pin, "CENTER", 0, 0)
    ring:SetColorTexture(1.0, 0.82, 0.18, 0.22)
    row.preview, row.pin, row.ring = sample, pin, ring
end
