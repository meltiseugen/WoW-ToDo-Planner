local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow
local Widgets = TDP.Widgets
local DEFAULT_MAP_ID = CollectionMapWindow.Config.DEFAULT_MAP_ID
local DEFAULT_PIN_X = CollectionMapWindow.Config.DEFAULT_PIN_X
local DEFAULT_PIN_Y = CollectionMapWindow.Config.DEFAULT_PIN_Y
local ZOOM_STEP = CollectionMapWindow.Config.ZOOM_STEP
local IsCollectionType = CollectionMapWindow.Helpers.IsCollectionType

function CollectionMapWindow:OpenTest()
    self:Open({
        mapID = DEFAULT_MAP_ID,
        pins = {
            {
                mapID = DEFAULT_MAP_ID,
                x = DEFAULT_PIN_X / 100,
                y = DEFAULT_PIN_Y / 100,
                label = "Goretooth / Nagrand test pin",
            },
        },
    })
end

function CollectionMapWindow:Open(options)
    if not self.frame then
        self:Build()
    end

    options = options or {}
    if IsCollectionType(options.collectionType) and #(options.pins or {}) == 0 then
        self:SetStatus("No curated map location is available for this collection entry.")
        return
    end

    self.title = options.title
    self.collectionType = options.collectionType
    self.sourceSummary = options.sourceSummary
    self.acquisition = options.acquisition
    self.effect = options.effect
    self.tips = options.tips
    self.requirements = options.requirements
    self.cost = options.cost
    self.costs = options.costs
    self.availability = options.availability
    self.notes = options.notes
    self.researchNotes = options.researchNotes
    self.description = options.description
    self.criteria = options.criteria
    self.mapAchievementId = tonumber(options.mapAchievementId)
    self.showCompletedCriteriaPins = options.showCompletedCriteriaPins == true
    self.waypoints = options.waypoints
    self.icon = options.icon
    self.pins = options.allPins or options.pins or {}
    self.mapID = options.mapID or (self.pins[1] and self.pins[1].mapID) or self:GetDefaultMapID()
    self.initialMapID = self.mapID
    self:RefreshCriteriaProgress()
    self:UpdateCriteriaFilterControl()
    self.zoom = 1
    self.panX = 0
    self.panY = 0
    self.frame:Show()
    Widgets:BringToFront(self.frame)
    self:RenderMap()
end

function CollectionMapWindow:Build()
    local frame = CreateFrame("Frame", "TODOPlannerCollectionMapFrame", UIParent, "BackdropTemplate")
    frame:SetSize(900, 560)
    Widgets:ApplyFramePosition(frame, "collectionMap")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(target)
        target:StopMovingOrSizing()
        Widgets:SaveFramePosition(target, "collectionMap")
    end)
    Widgets:RegisterTopLevelWindow(frame)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Collection Map")
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerCollectionMapFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })
        body = frame
        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
    end

    local toolbar = Widgets:CreatePanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", body, "TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", body, "TOPRIGHT", -12, -12)
    toolbar:SetHeight(42)

    local mapTitle = Widgets:CreateFontString(toolbar, "OVERLAY", "GameFontNormal")
    mapTitle:SetPoint("LEFT", toolbar, "LEFT", 12, 0)
    mapTitle:SetPoint("RIGHT", toolbar, "RIGHT", -540, 0)
    mapTitle:SetJustifyH("LEFT")
    if mapTitle.SetWordWrap then
        mapTitle:SetWordWrap(false)
    end

    local zoomInButton = Widgets:CreateButton(toolbar, 28, 24, "+", "neutral")
    zoomInButton:SetPoint("RIGHT", toolbar, "RIGHT", -14, 0)

    local resetButton = Widgets:CreateButton(toolbar, 64, 24, "Reset", "neutral")
    resetButton:SetPoint("RIGHT", zoomInButton, "LEFT", -6, 0)

    local zoomOutButton = Widgets:CreateButton(toolbar, 28, 24, "-", "neutral")
    zoomOutButton:SetPoint("RIGHT", resetButton, "LEFT", -6, 0)

    local initialMapButton = Widgets:CreateButton(toolbar, 82, 24, "Initial Map", "neutral")
    initialMapButton:SetPoint("RIGHT", zoomOutButton, "LEFT", -6, 0)

    local clearProjectButton = Widgets:CreateButton(toolbar, 70, 24, "Clear", "neutral")
    clearProjectButton:SetPoint("RIGHT", initialMapButton, "LEFT", -6, 0)

    local projectButton = Widgets:CreateButton(toolbar, 86, 24, "Project", "primary")
    projectButton:SetPoint("RIGHT", clearProjectButton, "LEFT", -6, 0)

    local completedPinsCheck = CreateFrame("CheckButton", nil, toolbar, "UICheckButtonTemplate")
    completedPinsCheck:SetSize(22, 22)
    completedPinsCheck:SetPoint("RIGHT", projectButton, "LEFT", -108, 0)
    completedPinsCheck:SetHitRectInsets(0, -102, 0, 0)
    completedPinsCheck.label = Widgets:CreateFontString(completedPinsCheck, "OVERLAY", "GameFontHighlightSmall")
    completedPinsCheck.label:SetPoint("LEFT", completedPinsCheck, "RIGHT", 3, 0)
    completedPinsCheck.label:SetText("Show completed")
    completedPinsCheck:Hide()

    local mapViewport = Widgets:CreatePanel(body, "input", "inputBorder")
    mapViewport:SetPoint("TOPLEFT", toolbar, "BOTTOMLEFT", 0, -10)
    mapViewport:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -286, 42)
    mapViewport:EnableMouse(true)
    mapViewport:EnableMouseWheel(true)
    if mapViewport.SetClipsChildren then
        mapViewport:SetClipsChildren(true)
    end

    local mapContent = CreateFrame("Frame", nil, mapViewport)
    mapContent:SetPoint("CENTER", mapViewport, "CENTER")
    mapContent:SetSize(1, 1)

    local detailPanel = Widgets:CreatePanel(body, "section", "goldBorder")
    detailPanel:SetPoint("TOPLEFT", mapViewport, "TOPRIGHT", 10, 0)
    detailPanel:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -12, 42)
    detailPanel.topAccent = Widgets:AddGoldTopAccent(detailPanel, 2, 0.18)

    local detailIcon = detailPanel:CreateTexture(nil, "ARTWORK")
    detailIcon:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -14)
    detailIcon:SetSize(42, 42)

    local detailTitle = Widgets:CreateFontString(detailPanel, "OVERLAY", "GameFontNormal")
    detailTitle:SetPoint("TOPLEFT", detailIcon, "TOPRIGHT", 10, -2)
    detailTitle:SetPoint("RIGHT", detailPanel, "RIGHT", -12, 0)
    detailTitle:SetJustifyH("LEFT")
    if detailTitle.SetWordWrap then
        detailTitle:SetWordWrap(true)
    end

    local detailMeta = Widgets:CreateFontString(detailPanel, "OVERLAY", "GameFontHighlightSmall")
    detailMeta:SetPoint("TOPLEFT", detailTitle, "BOTTOMLEFT", 0, -6)
    detailMeta:SetPoint("RIGHT", detailTitle, "RIGHT", 0, 0)
    detailMeta:SetJustifyH("LEFT")

    local detailScroll = CreateFrame("ScrollFrame", nil, detailPanel, "UIPanelScrollFrameTemplate")
    detailScroll:SetPoint("TOPLEFT", detailPanel, "TOPLEFT", 12, -68)
    detailScroll:SetPoint("BOTTOMRIGHT", detailPanel, "BOTTOMRIGHT", -28, 12)

    local detailContent = CreateFrame("Frame", nil, detailScroll)
    detailContent:SetSize(1, 1)
    detailScroll:SetScrollChild(detailContent)

    local detailText = Widgets:CreateFontString(detailContent, "OVERLAY", "GameFontHighlight")
    detailText:SetPoint("TOPLEFT", detailContent, "TOPLEFT", 0, 0)
    detailText:SetPoint("TOPRIGHT", detailContent, "TOPRIGHT", 0, 0)
    Widgets:ConfigurePreviewDetailText(detailText)

    detailPanel:SetScript("OnSizeChanged", function()
        Widgets:UpdateScrollablePreviewText(detailScroll, detailContent, detailText, detailText.rawPreviewText)
    end)

    local statusText = Widgets:CreateFontString(body, "OVERLAY", "GameFontHighlightSmall")
    statusText:SetPoint("BOTTOMLEFT", body, "BOTTOMLEFT", 18, 18)
    statusText:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -18, 18)
    statusText:SetJustifyH("LEFT")

    mapViewport:SetScript("OnMouseWheel", function(_, delta)
        self:AdjustZoom(delta > 0 and ZOOM_STEP or -ZOOM_STEP)
    end)

    mapViewport:SetScript("OnMouseDown", function(_, button)
        if button == "RightButton" then
            self:NavigateToParentMap()
            return
        end
        if button ~= "LeftButton" or type(GetCursorPosition) ~= "function" then
            return
        end
        self.dragging = true
        self.dragX, self.dragY = GetCursorPosition()
    end)

    mapViewport:SetScript("OnMouseUp", function()
        self.dragging = false
    end)

    mapViewport:SetScript("OnHide", function()
        self.dragging = false
    end)

    mapViewport:SetScript("OnUpdate", function()
        if not self.dragging or type(GetCursorPosition) ~= "function" then
            return
        end

        local cursorX, cursorY = GetCursorPosition()
        local previousX = self.dragX or cursorX
        local previousY = self.dragY or cursorY
        self.dragX, self.dragY = cursorX, cursorY
        self.panX = (self.panX or 0) + (cursorX - previousX)
        self.panY = (self.panY or 0) + (cursorY - previousY)
        self:UpdateCanvasPosition()
    end)

    mapViewport:SetScript("OnSizeChanged", function()
        self:RenderMap()
    end)

    zoomOutButton:SetScript("OnClick", function()
        self:AdjustZoom(-ZOOM_STEP)
    end)

    zoomInButton:SetScript("OnClick", function()
        self:AdjustZoom(ZOOM_STEP)
    end)

    resetButton:SetScript("OnClick", function()
        self:ResetView()
    end)

    initialMapButton:SetScript("OnClick", function()
        self:ResetToInitialMap()
    end)

    projectButton:SetScript("OnClick", function()
        self:ProjectToWorldMap()
    end)

    clearProjectButton:SetScript("OnClick", function()
        self:ClearWorldMapProjection()
    end)

    completedPinsCheck:SetScript("OnClick", function(target)
        self:SetShowCompletedCriteriaPins(target:GetChecked() == true)
    end)

    local criteriaEventFrame = CreateFrame("Frame")
    pcall(criteriaEventFrame.RegisterEvent, criteriaEventFrame, "CRITERIA_UPDATE")
    pcall(criteriaEventFrame.RegisterEvent, criteriaEventFrame, "ACHIEVEMENT_EARNED")
    criteriaEventFrame:SetScript("OnEvent", function()
        if not self.mapAchievementId then
            return
        end
        self:RefreshCriteriaProgress()
        self:UpdateCriteriaFilterControl()
        self:RefreshProjectedCriteriaPins()
        if self.frame and self.frame:IsShown() then
            self:RenderMap()
        end
    end)

    self.frame = frame
    self.body = body
    self.mapTitle = mapTitle
    self.mapViewport = mapViewport
    self.mapContent = mapContent
    self.detailPanel = detailPanel
    self.detailIcon = detailIcon
    self.detailTitle = detailTitle
    self.detailMeta = detailMeta
    self.detailScroll = detailScroll
    self.detailContent = detailContent
    self.detailText = detailText
    self.statusText = statusText
    self.zoomOutButton = zoomOutButton
    self.zoomInButton = zoomInButton
    self.resetButton = resetButton
    self.initialMapButton = initialMapButton
    self.projectButton = projectButton
    self.clearProjectButton = clearProjectButton
    self.completedPinsCheck = completedPinsCheck
    self.criteriaEventFrame = criteriaEventFrame

    frame:Hide()
    self:UpdateProjectionControls()
    return self
end

CollectionMapWindow:EnsureWorldMapProjectionMixins()
