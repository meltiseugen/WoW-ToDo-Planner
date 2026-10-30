local _, TDP = ...
local OptionsWindow = TDP.OptionsWindow
local Widgets = TDP.Widgets

function OptionsWindow:SelectPage(pageID)
    local aliases = { General = "appearance", Achievements = "achievements" }
    pageID = aliases[pageID] or pageID
    if not self:GetPageDefinition(pageID) then pageID = "appearance" end
    self:HideHelp()
    Widgets:HideDropdownMenus()
    self:CancelReset()
    self.selectedPage = pageID
    TODOPlannerDB.settings.optionsWindow.page = pageID
    self.searchText = ""
    self.searchInput:SetText("")
    self.searchInput:ClearFocus()
    self.scrollFrame:SetVerticalScroll(0)
    self:Refresh()
end

-- Preserve callers that opened the old tabbed window.
function OptionsWindow:SelectTab(tabKey)
    self:SelectPage(tabKey)
end

function OptionsWindow:SetSearch(text)
    local query = (text or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    if query == self.searchText then return end
    self.searchText = query
    self:CancelReset()
    self:HideHelp()
    Widgets:HideDropdownMenus()
    self.scrollFrame:SetVerticalScroll(0)
    self:Refresh()
end

function OptionsWindow:CreatePages()
    for _, definition in ipairs(self.PageDefinitions) do
        local page = { definition = definition, sections = {} }
        for _, sectionSpec in ipairs(definition.sections) do
            local section = Widgets:CreatePanel(self.content, "section", "goldBorder")
            section.title = self:Text(section, sectionSpec.title, "GameFontNormal")
            section.title:SetPoint("TOPLEFT", 16, -14)
            section.definition = sectionSpec
            section.rows = {}
            for _, spec in ipairs(sectionSpec.settings) do
                section.rows[#section.rows + 1] = self:CreateSettingRow(section, spec)
            end
            page.sections[#page.sections + 1] = section
        end
        self.pages[definition.id] = page
    end
end

function OptionsWindow:Layout()
    if not self.frame or self.layingOut then return end
    self.layingOut = true
    local searching = self.searchText ~= ""
    local definition = self:GetPageDefinition(self.selectedPage)
    self.pageTitle:SetText(searching and "Search results" or definition.label)
    self.pageDescription:SetText(searching and "Matching settings from every page. Clear search to return to a page." or definition.description)
    local descriptionHeight = self.pageDescription:GetStringHeight()
    self.scrollFrame:SetPoint("TOPLEFT", self.body, "TOPLEFT", 16, -58 - descriptionHeight)
    local width = math.max(1, self.scrollFrame:GetWidth() - 12)
    self.content:SetWidth(width)
    local top, count = 0, 0
    for _, pageSpec in ipairs(self.PageDefinitions) do
        local page = self.pages[pageSpec.id]
        local matches = 0
        for _, section in ipairs(page.sections) do
            local visibleRows = {}
            for _, row in ipairs(section.rows) do
                local visible = (searching or pageSpec.id == self.selectedPage)
                    and self:SettingMatches(pageSpec, section.definition, row.spec)
                row:SetShown(visible)
                if visible then visibleRows[#visibleRows + 1] = row end
            end
            section:SetShown(#visibleRows > 0)
            if #visibleRows > 0 then
                section:ClearAllPoints()
                section:SetPoint("TOPLEFT", self.content, "TOPLEFT", 0, -top)
                section:SetWidth(width)
                section.title:SetWidth(width - 32)
                section.title:SetText(searching and (pageSpec.label .. " / " .. section.definition.title) or section.definition.title)
                local sectionTop = section.title:GetStringHeight() + 30
                for _, row in ipairs(visibleRows) do
                    row:ClearAllPoints()
                    row:SetPoint("TOPLEFT", section, "TOPLEFT", 16, -sectionTop)
                    sectionTop = sectionTop + self:LayoutSettingRow(row, width - 32) + 8
                    count, matches = count + 1, matches + 1
                end
                section:SetHeight(sectionTop + 4)
                top = top + sectionTop + 18
            end
        end
        page.button:SetText(pageSpec.label .. (searching and (" (" .. matches .. ")") or ""))
        self:ApplyTabVisualState(page.button, not searching and pageSpec.id == self.selectedPage)
    end
    self.emptyText:SetShown(count == 0)
    self.emptyText:SetWidth(width - 32)
    self.content:SetHeight(math.max(1, top, count == 0 and 100 or 0))
    Widgets:SetButtonEnabled(self.resetButton, not searching)
    self.resultText:SetText(searching and (count .. (count == 1 and " matching setting" or " matching settings")) or "Saved for your account")
    if self.scrollFrame.UpdateScrollChildRect then self.scrollFrame:UpdateScrollChildRect() end
    self.scrollFrame:SetVerticalScroll(math.min(self.scrollFrame:GetVerticalScroll(), self.scrollFrame:GetVerticalScrollRange()))
    self.layingOut = nil
end
