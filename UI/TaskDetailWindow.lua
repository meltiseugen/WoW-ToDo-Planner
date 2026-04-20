local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

local TaskDetailWindow = {}
TaskDetailWindow.__index = TaskDetailWindow

function TaskDetailWindow:New(ui)
    return setmetatable({
        ui = ui,
        frame = nil,
    }, self)
end

function TaskDetailWindow:Build()
    local ui = self.ui
    local frame = CreateFrame("Frame", "TODOPlannerTaskDetailFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(620, 620)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

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

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Task Details")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local titleText = body:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOPLEFT", 16, -16)
    titleText:SetPoint("TOPRIGHT", -16, -16)
    Widgets:ConfigureDetailText(titleText, false)
    frame.titleText = titleText

    local details = Widgets:CreatePanel(body, "section", "goldBorder")
    details:SetPoint("TOPLEFT", 14, -54)
    details:SetPoint("TOPRIGHT", -14, -54)
    details:SetHeight(126)
    details.topAccent = Widgets:AddGoldTopAccent(details, 2, 0.18)

    local rowY = -14
    local function addDetailRow(labelText)
        local label = details:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        label:SetPoint("TOPLEFT", 12, rowY)
        label:SetWidth(92)
        label:SetJustifyH("LEFT")
        label:SetText(labelText)

        local value = details:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        value:SetPoint("TOPLEFT", 112, rowY)
        value:SetPoint("RIGHT", details, "RIGHT", -12, 0)
        Widgets:ConfigureDetailText(value, false)

        rowY = rowY - 22
        return value
    end

    frame.idValue = addDetailRow("ID")
    frame.statusValue = addDetailRow("Status")
    frame.categoryValue = addDetailRow("Category")
    frame.createdValue = addDetailRow("Created")
    frame.updatedValue = addDetailRow("Updated")

    local notes = Widgets:CreatePanel(body, "section", "goldBorder")
    notes:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -12)
    notes:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -14, 52)
    notes.topAccent = Widgets:AddGoldTopAccent(notes, 2, 0.18)

    local notesLabel = notes:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    notesLabel:SetPoint("TOPLEFT", 12, -10)
    notesLabel:SetText("Notes")

    local notesScroll = CreateFrame("ScrollFrame", nil, notes, "UIPanelScrollFrameTemplate")
    notesScroll:SetPoint("TOPLEFT", 10, -30)
    notesScroll:SetPoint("BOTTOMRIGHT", notes, "BOTTOMRIGHT", -28, 10)

    local notesContent = CreateFrame("Frame", nil, notesScroll)
    notesContent:SetSize(1, 1)
    notesScroll:SetScrollChild(notesContent)

    local notesValue = notesContent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    notesValue:SetPoint("TOPLEFT", 0, 0)
    notesValue:SetWidth(532)
    Widgets:ConfigureDetailText(notesValue, true)
    notesValue:SetJustifyV("TOP")
    frame.notesLabel = notesLabel
    frame.notesScroll = notesScroll
    frame.notesContent = notesContent
    frame.notesValue = notesValue

    local closeButton = Widgets:CreateButton(body, 76, 24, "Close", "neutral")
    closeButton:SetPoint("BOTTOMRIGHT", -14, 16)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local editButton = Widgets:CreateButton(body, 76, 24, "Edit", "primary")
    editButton:SetPoint("RIGHT", closeButton, "LEFT", -8, 0)
    editButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        if not ui.frame:IsShown() then
            ui:Render()
            ui.frame:Show()
        end

        ui:LoadEditor(task)
        ui.inputTitle:SetFocus()
        frame:Hide()
    end)

    local archiveButton = Widgets:CreateButton(body, 86, 24, "Archive", "danger")
    archiveButton:SetPoint("RIGHT", editButton, "LEFT", -8, 0)
    archiveButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        ui:ConfirmArchiveTask(task)
    end)
    frame.archiveButton = archiveButton

    local wowheadButton = Widgets:CreateButton(body, 94, 24, "Wowhead", "neutral")
    wowheadButton:SetPoint("BOTTOMLEFT", 14, 16)
    wowheadButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        local achievementId = Achievements:GetTaskAchievementId(task)
        if not achievementId then
            return
        end

        Achievements:CopyWowheadAchievementUrl(achievementId)
    end)
    frame.wowheadButton = wowheadButton

    local moveBoardButton = Widgets:CreateButton(body, 180, 24, "Move to Board", "neutral")
    moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
    moveBoardButton:SetScript("OnClick", function(owner)
        local task = Tasks:FindById(frame.taskId)
        if not task or Tasks:GetBoardKey(task) ~= C.GLOBAL_BOARD_KEY then
            return
        end

        local boardOptions = Boards:GetCharacterBoardOptions()
        if #boardOptions == 0 then
            Utils:Msg("No character boards are available.")
            return
        end

        Widgets:ShowSingleSelectMenu(owner, boardOptions, nil, function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(targetBoardKey)
            task = Tasks:FindById(frame.taskId)
            if not task then
                frame:Hide()
                return
            end

            Tasks:MoveToBoard(task, targetBoardKey)
            TODOPlannerDB.settings.selectedBoard = targetBoardKey
            Tasks:SortStable(TODOPlannerDB.tasks)
            ui:Render()
            frame:UpdateTask(task)
        end)
    end)
    frame.moveBoardButton = moveBoardButton

    function frame:UpdateTask(task)
        local taskBoardKey = Tasks:GetBoardKey(task)
        local visibleStatus = Tasks:GetStatus(task)
        local achievementId = Achievements:GetTaskAchievementId(task)
        local notesText = achievementId and Achievements:BuildDetailText(task) or Utils:Trim(task.notes or "")

        self.taskId = task.id
        self.titleText:SetText(task.title or "(Untitled)")
        self.idValue:SetText("#" .. tostring(task.id or "?"))
        self.statusValue:SetText(Tasks:FormatStatus(visibleStatus))
        self.categoryValue:SetText(task.category or "Other")
        self.createdValue:SetText(Utils:GetDateTimeStamp(task.createdAt))
        self.updatedValue:SetText(Utils:GetDateTimeStamp(task.updatedAt))
        self.notesLabel:SetText(achievementId and "Achievement Details" or "Notes")
        local notesWidth = self.notesScroll:GetWidth()
        if not notesWidth or notesWidth < 200 then
            notesWidth = 532
        end
        self.notesValue:SetWidth(notesWidth - 8)
        self.notesValue:SetText(notesText ~= "" and notesText or "No notes.")
        self.notesContent:SetSize(notesWidth, math.max(self.notesScroll:GetHeight(), self.notesValue:GetStringHeight() + 8))

        if Tasks:IsArchived(task) then
            self.archiveButton:Hide()
        else
            self.archiveButton:Show()
        end

        if taskBoardKey == C.GLOBAL_BOARD_KEY then
            self.moveBoardButton:Show()
        else
            self.moveBoardButton:Hide()
        end

        if achievementId then
            self.wowheadButton:Show()
            self.moveBoardButton:ClearAllPoints()
            self.moveBoardButton:SetPoint("LEFT", self.wowheadButton, "RIGHT", 8, 0)
        else
            self.wowheadButton:Hide()
            self.moveBoardButton:ClearAllPoints()
            self.moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
        end
    end

    function frame:OpenTask(task)
        self:UpdateTask(task)
        self:ClearAllPoints()
        self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
        self:Show()
        if TDP.Theme then
            TDP.Theme:BringToFront(self, ui.frame)
        end
    end

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

TDP.TaskDetailWindow = TaskDetailWindow
