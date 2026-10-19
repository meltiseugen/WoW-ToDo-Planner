local _, TDP = ...
local TaskDetailWindow = TDP.TaskDetailWindow
local Widgets = TDP.Widgets
local DETAIL_COMPACT_HEIGHT = TaskDetailWindow.Config.DETAIL_COMPACT_HEIGHT

function TaskDetailWindow:Build()
    local ui = self.ui
    local frame = CreateFrame("Frame", "TODOPlannerTaskDetailFrame", UIParent, "BackdropTemplate")
    frame.todoPlannerOwner = self
    for name, method in pairs(TaskDetailWindow.FrameMethods) do
        frame[name] = method
    end
    frame:SetSize(620, 620)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    if frame.SetResizable then
        frame:SetResizable(true)
    end
    if frame.SetResizeBounds then
        frame:SetResizeBounds(520, 560, 1000, 900)
    elseif frame.SetMinResize then
        frame:SetMinResize(520, 560)
        if frame.SetMaxResize then
            frame:SetMaxResize(1000, 900)
        end
    end
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    Widgets:RegisterTopLevelWindow(frame)

    local body
    local Theme = TDP.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Task Details")
        body = Widgets:CreatePanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = Widgets:AddGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerTaskDetailFrame")
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = Widgets:CreateFontString(frame, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Task Details")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local titleText = Widgets:CreateFontString(body, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOPLEFT", 16, -16)
    titleText:SetPoint("TOPRIGHT", -16, -16)
    Widgets:ConfigureDetailText(titleText, false)
    frame.titleText = titleText

    local ownershipBadge = Widgets:CreateBadge(body)
    ownershipBadge:SetPoint("TOPLEFT", body, "TOPLEFT", 16, -42)
    ownershipBadge:SetPoint("TOPRIGHT", body, "TOPRIGHT", -16, -42)
    frame.ownershipBadge = ownershipBadge

    local details = Widgets:CreatePanel(body, "section", "goldBorder")
    details:SetPoint("TOPLEFT", 14, -74)
    details:SetPoint("TOPRIGHT", -14, -74)
    details:SetHeight(DETAIL_COMPACT_HEIGHT)
    details.topAccent = Widgets:AddGoldTopAccent(details, 2, 0.18)
    frame.detailsPanel = details

    frame.detailRows = {}
    local function addDetailRow(key, labelText, alwaysVisible, allowWrap)
        local label = Widgets:CreateFontString(details, "OVERLAY", "GameFontDisableSmall")
        label:SetWidth(86)
        label:SetJustifyH("LEFT")
        label:SetText(labelText)

        local value = Widgets:CreateFontString(details, "OVERLAY", "GameFontHighlightSmall")
        Widgets:ConfigureDetailText(value, allowWrap == true)
        value:SetJustifyV("TOP")

        local row = {
            key = key,
            label = label,
            value = value,
            alwaysVisible = alwaysVisible == true,
        }
        frame.detailRows[#frame.detailRows + 1] = row
        return row
    end

    frame.idValue = addDetailRow("id", "ID", true).value
    frame.statusValue = addDetailRow("status", "Status", true).value
    frame.boardValue = addDetailRow("board", "Board", true).value
    frame.categoryValue = addDetailRow("category", "Category", true).value
    frame.createdValue = addDetailRow("created", "Created", true).value
    frame.updatedValue = addDetailRow("updated", "Updated", true).value
    addDetailRow("progress", "Progress")
    addDetailRow("achievementCategory", "Ach. Category")
    addDetailRow("guild", "Guild")
    addDetailRow("earnedBy", "Earned By")

    local notes = Widgets:CreatePanel(body, "section", "goldBorder")
    notes:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -12)
    notes:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -14, 82)
    notes.topAccent = Widgets:AddGoldTopAccent(notes, 2, 0.18)

    local notesLabel = Widgets:CreateFontString(notes, "OVERLAY", "GameFontDisableSmall")
    notesLabel:SetPoint("TOPLEFT", 12, -10)
    notesLabel:SetText("Description")

    local notesScroll = CreateFrame("ScrollFrame", nil, notes, "UIPanelScrollFrameTemplate")
    notesScroll:SetPoint("TOPLEFT", 10, -30)
    notesScroll:SetPoint("BOTTOMRIGHT", notes, "BOTTOMRIGHT", -28, 10)

    local notesContent = CreateFrame("Frame", nil, notesScroll)
    notesContent:SetSize(1, 1)
    notesScroll:SetScrollChild(notesContent)

    local notesValue = Widgets:CreateFontString(notesContent, "OVERLAY", "GameFontHighlightSmall")
    notesValue:SetPoint("TOPLEFT", 0, 0)
    notesValue:SetWidth(532)
    Widgets:ConfigureDetailText(notesValue, true)
    notesValue:SetJustifyV("TOP")
    local criteriaLabel = Widgets:CreateFontString(notesContent, "OVERLAY", "GameFontNormalSmall")
    criteriaLabel:SetText("Criteria")
    criteriaLabel:SetJustifyH("LEFT")
    criteriaLabel:Hide()
    local criteriaDivider = CreateFrame("Frame", nil, notesContent)
    criteriaDivider:SetHeight(22)
    criteriaDivider.line = criteriaDivider:CreateTexture(nil, "BACKGROUND")
    criteriaDivider.line:SetPoint("LEFT", 0, 0)
    criteriaDivider.line:SetPoint("RIGHT", 0, 0)
    criteriaDivider.line:SetHeight(1)
    Widgets:SetTextureColor(criteriaDivider.line, "accentGold", { 1, 0.82, 0.18, 0.22 })
    criteriaDivider.line:SetAlpha(0.32)
    criteriaDivider:Hide()

    frame.notesLabel = notesLabel
    frame.notesScroll = notesScroll
    frame.notesContent = notesContent
    frame.notesValue = notesValue
    frame.criteriaLabel = criteriaLabel
    frame.criteriaDivider = criteriaDivider
    frame.criteriaRows = {}

    if frame.StartSizing then
        local resizeButton = CreateFrame("Button", nil, frame)
        resizeButton:SetSize(18, 18)
        resizeButton:SetPoint("BOTTOMRIGHT", -5, 5)
        resizeButton:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
        resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
        resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
        resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
        resizeButton:SetScript("OnMouseDown", function()
            frame:StartSizing("BOTTOMRIGHT")
        end)
        resizeButton:SetScript("OnMouseUp", function()
            frame:StopMovingOrSizing()
            frame:UpdateNotesLayout()
        end)
        frame.resizeButton = resizeButton
    end

    self:BuildActions(frame, body)

    frame:SetScript("OnSizeChanged", function(target)
        target:UpdateDetailRows()
        target:UpdateNotesLayout()
    end)
    frame:SetScript("OnHide", function()
        Widgets:HideDropdownMenus()
    end)

    frame:Hide()
    self.frame = frame
    return frame
end

function TaskDetailWindow:Open(task)
    if not self.frame then
        self:Build()
    end

    self.frame:OpenTask(task)
end
