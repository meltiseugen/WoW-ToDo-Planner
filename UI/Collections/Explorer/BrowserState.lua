local _, TDP = ...
local Explorer = TDP.CollectionExplorerWindow
local Widgets = TDP.Widgets

function Explorer:GetBrowserSettings()
    if not TODOPlannerDB or not TODOPlannerDB.settings then return {} end
    local settings = TODOPlannerDB.settings
    if type(settings.collectionExplorerWindow) ~= "table" then settings.collectionExplorerWindow = {} end
    return settings.collectionExplorerWindow
end

function Explorer:GetListStateKey()
    local scope = self.nearbySnapshot and ("nearby:" .. tostring(self.nearbySnapshot.mapID))
        or (self.selectedExpansion .. ":" .. self.selectedPatch)
    return scope .. ":" .. self.selectedCollectionType
end

function Explorer:CaptureListState()
    self.listStates = self.listStates or {}
    self.listStates[self:GetListStateKey()] = {
        rowKey = self:GetRowKey(self.selectedRow),
        scroll = self.listScroll and self.listScroll:GetVerticalScroll() or 0,
    }
end

function Explorer:RestoreListState()
    local state = self.listStates and self.listStates[self:GetListStateKey()]
    if type(state) ~= "table" then state = nil end
    self.pendingSelectionKey = state and state.rowKey
    self.pendingListScroll = state and state.scroll or 0
    self.selectedRow = nil
end

function Explorer:SaveBrowserState()
    local saved = self:GetBrowserSettings()
    if self.frame then saved.width, saved.height = self.frame:GetSize() end
    saved.previewCollapsed = self.previewCollapsed == true
    if not self.hasRendered then return end
    if self.nearbySnapshot then return end -- A saved window never scans location on open.
    self:CaptureListState()
    saved.expansion, saved.patch = self.selectedExpansion, self.selectedPatch
    saved.collectionType, saved.achievementCategory = self.selectedCollectionType, self.selectedAchievementCategory
    saved.search = self.searchEdit and self.searchEdit:GetText() or ""
    saved.sortKey = self.sortKey
    saved.rowKey = self:GetRowKey(self.selectedRow)
    saved.scroll = self.listScroll and self.listScroll:GetVerticalScroll() or 0
    saved.listStates = {}
    for key, state in pairs(self.listStates) do
        if not key:match("^nearby:") then saved.listStates[key] = state end
    end
end

function Explorer:RestoreBrowserState()
    local saved = self:GetBrowserSettings()
    if not TDP.Utils:IndexOf(self:GetPatchOptions(), self.selectedPatch) then self.selectedPatch = "all" end
    if not TDP.Utils:IndexOf(self.Config.ACHIEVEMENT_CATEGORY_OPTIONS, self.selectedAchievementCategory) then
        self.selectedAchievementCategory = "all"
    end
    if not ({ name = true, patch = true, source = true, status = true })[self.sortKey] then self.sortKey = "name" end
    self.listStates = type(saved.listStates) == "table" and saved.listStates or {}
    self.pendingSelectionKey = type(saved.rowKey) == "string" and saved.rowKey or nil
    self.pendingListScroll = math.max(0, tonumber(saved.scroll) or 0)
    self.changingView = true
    self.searchEdit:SetText(type(saved.search) == "string" and saved.search:sub(1, 80) or "")
    self.changingView = false
end

function Explorer:ResetListScroll()
    self.pendingListScroll = 0
end

function Explorer:BindExplorerHelp(control, title, description)
    if control.SetMotionScriptsWhileDisabled then control:SetMotionScriptsWhileDisabled(true) end
    control.explorerHelpTitle, control.explorerHelp = title, description
    Widgets:HookFrameScript(control, "OnEnter", function(target)
        if not GameTooltip then return end
        GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
        GameTooltip:SetText(target.explorerHelpTitle or title, 1, 1, 1, 1, true)
        local text = target.explorerHelp
        if type(text) == "function" then text = text() end
        GameTooltip:AddLine(text or "", 0.86, 0.88, 0.94, true)
        GameTooltip:Show()
    end)
    Widgets:HookFrameScript(control, "OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
end

function Explorer:CreateCollectionShortcut(parent, kind)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(26, 26)
    button:RegisterForClicks("LeftButtonUp")
    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetSize(18, 18)
    button.icon:SetPoint("CENTER")
    local atlas = kind == "favorite" and "auctionhouse-icon-favorite" or "Waypoint-MapPin-Untracked"
    if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas) then
        button.icon:SetAtlas(atlas)
    else
        button.icon:SetTexture(kind == "favorite" and "Interface\\COMMON\\ReputationStar"
            or "Interface\\WorldMap\\WorldMapPartyIcon")
    end
    self:BindExplorerHelp(button, kind == "favorite" and "Favorite" or "Open Map", function()
        return button.helpText or (kind == "favorite" and "Save this collection to Favorites."
            or "Open the recorded catalog locations for this collection.")
    end)
    return Widgets:RaiseParentWindowOnInteraction(button)
end
