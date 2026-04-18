local ADDON_NAME = ...

local TDP = CreateFrame("Frame")

local function cloneThemeTable(source)
    local copy = {}
    if type(source) ~= "table" then
        return copy
    end

    for key, value in pairs(source) do
        if type(value) == "table" then
            local nested = {}
            for nestedKey, nestedValue in pairs(value) do
                if type(nestedValue) == "table" then
                    local inner = {}
                    for innerKey, innerValue in pairs(nestedValue) do
                        inner[innerKey] = innerValue
                    end
                    nested[nestedKey] = inner
                else
                    nested[nestedKey] = nestedValue
                end
            end
            copy[key] = nested
        else
            copy[key] = value
        end
    end

    return copy
end

local function createAddonTheme()
    if type(_G.JanisTheme) ~= "table" or type(_G.JanisTheme.New) ~= "function" then
        return nil
    end

    local colors = cloneThemeTable(_G.JanisTheme.defaultColors)
    colors.input = { 0.03, 0.04, 0.06, 0.94 }
    colors.inputFocus = { 0.05, 0.06, 0.08, 0.96 }
    colors.inputBorder = { 1.0, 1.0, 1.0, 0.08 }
    colors.inputBorderFocus = { 1.0, 0.82, 0.18, 0.26 }

    local buttonPalettes = cloneThemeTable(_G.JanisTheme.defaultButtonPalettes)
    buttonPalettes.subtle = {
        bg = { 0.09, 0.10, 0.14, 0.94 },
        border = { 1.0, 1.0, 1.0, 0.08 },
        hoverBg = { 0.12, 0.13, 0.18, 0.98 },
        hoverBorder = { 1.0, 0.82, 0.18, 0.22 },
        pressedBg = { 0.06, 0.07, 0.10, 0.98 },
        pressedBorder = { 1.0, 1.0, 1.0, 0.10 },
        selectedBg = { 0.18, 0.14, 0.08, 0.96 },
        selectedBorder = { 1.0, 0.82, 0.24, 0.48 },
        text = { 0.92, 0.94, 1.00 },
    }

    return _G.JanisTheme:New({
        addon = TDP,
        colors = colors,
        buttonPalettes = buttonPalettes,
    })
end

local Theme = createAddonTheme()
TDP.Theme = Theme

local ALL_BOARD_KEY = "ALL"
local ARCHIVED_BOARD_KEY = "ARCHIVED"
local GLOBAL_BOARD_KEY = "GLOBAL"

local STATUS_ORDER = { "TODO", "DOING", "DONE" }
local STATUS_LABELS = {
    TODO = "To Do",
    DOING = "In Progress",
    DONE = "Done",
}

local TASK_CATEGORIES = {
    "General",
    "Achievements",
    "Mounts",
    "Collections",
    "Reputation",
    "Other",
}

local FILTER_CATEGORIES = {
    "All",
    "General",
    "Achievements",
    "Mounts",
    "Collections",
    "Reputation",
    "Other",
}

local DEFAULT_DB = {
    version = 2,
    nextTaskId = 1,
    tasks = {},
    characters = {},
    settings = {
        filterCategory = "All",
        selectedBoard = false,
        frame = {
            point = "CENTER",
            x = 0,
            y = 0,
        },
    },
}

local function copyDefaults(target, defaults)
    if type(defaults) ~= "table" then
        return target
    end

    if type(target) ~= "table" then
        target = {}
    end

    for key, value in pairs(defaults) do
        if type(value) == "table" then
            target[key] = copyDefaults(target[key], value)
        elseif target[key] == nil then
            target[key] = value
        end
    end

    return target
end

local function trim(input)
    if type(input) ~= "string" then
        return ""
    end
    return (input:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function msg(text)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00d1b2TODO Planner|r: " .. text)
    else
        print("TODO Planner: " .. text)
    end
end

local function indexOf(list, value)
    for i, item in ipairs(list) do
        if item == value then
            return i
        end
    end
    return nil
end

local function normalizeStatus(status)
    if indexOf(STATUS_ORDER, status) then
        return status
    end
    return "TODO"
end

local function getStatusIndex(status)
    return indexOf(STATUS_ORDER, normalizeStatus(status)) or 1
end

local function getPlayerBoardKey()
    local name, realm = UnitFullName("player")
    if not name or name == "" then
        name = UnitName("player") or "Unknown"
    end

    if not realm or realm == "" then
        realm = GetRealmName() or ""
    end

    realm = trim(realm)
    if realm ~= "" then
        return name .. " - " .. realm
    end

    return name
end

local function normalizeBoardKey(boardKey)
    if type(boardKey) ~= "string" then
        return GLOBAL_BOARD_KEY
    end

    boardKey = trim(boardKey)
    if boardKey == "" then
        return GLOBAL_BOARD_KEY
    end

    if boardKey:lower() == "all" then
        return ALL_BOARD_KEY
    end

    if boardKey:lower() == "archive"
        or boardKey:lower() == "archives"
        or boardKey:lower() == "archived" then
        return ARCHIVED_BOARD_KEY
    end

    return boardKey
end

local function getBoardDisplayName(boardKey)
    boardKey = normalizeBoardKey(boardKey)
    if boardKey == ALL_BOARD_KEY then
        return "All"
    end
    if boardKey == ARCHIVED_BOARD_KEY then
        return "Archived"
    end
    if boardKey == GLOBAL_BOARD_KEY then
        return "Global"
    end
    return boardKey
end

local function sortCharacterBoards(characters)
    local currentBoardKey = getPlayerBoardKey()

    table.sort(characters, function(a, b)
        if a == currentBoardKey and b ~= currentBoardKey then
            return true
        end
        if b == currentBoardKey and a ~= currentBoardKey then
            return false
        end
        return a < b
    end)
end

local function isKnownBoard(boardKey)
    boardKey = normalizeBoardKey(boardKey)
    if boardKey == ALL_BOARD_KEY or boardKey == ARCHIVED_BOARD_KEY or boardKey == GLOBAL_BOARD_KEY then
        return true
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        return false
    end

    return indexOf(TODOPlannerDB.characters, boardKey) ~= nil
end

local function ensureKnownCharacter(boardKey)
    boardKey = normalizeBoardKey(boardKey)
    if boardKey == ALL_BOARD_KEY or boardKey == ARCHIVED_BOARD_KEY or boardKey == GLOBAL_BOARD_KEY then
        return
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        TODOPlannerDB.characters = {}
    end

    if not indexOf(TODOPlannerDB.characters, boardKey) then
        table.insert(TODOPlannerDB.characters, boardKey)
        sortCharacterBoards(TODOPlannerDB.characters)
    end
end

local function getBoardOptions()
    local boards = { ALL_BOARD_KEY, GLOBAL_BOARD_KEY, ARCHIVED_BOARD_KEY }
    local characters = {}
    local seen = {
        [ALL_BOARD_KEY] = true,
        [ARCHIVED_BOARD_KEY] = true,
        [GLOBAL_BOARD_KEY] = true,
    }

    if type(TODOPlannerDB.characters) == "table" then
        for _, boardKey in ipairs(TODOPlannerDB.characters) do
            boardKey = normalizeBoardKey(boardKey)
            if boardKey ~= ALL_BOARD_KEY
                and boardKey ~= ARCHIVED_BOARD_KEY
                and boardKey ~= GLOBAL_BOARD_KEY
                and not seen[boardKey] then
                seen[boardKey] = true
                characters[#characters + 1] = boardKey
            end
        end
    end

    sortCharacterBoards(characters)
    for _, boardKey in ipairs(characters) do
        boards[#boards + 1] = boardKey
    end

    return boards
end

local function getCharacterBoardOptions()
    local boards = {}
    for _, boardKey in ipairs(getBoardOptions()) do
        boardKey = normalizeBoardKey(boardKey)
        if boardKey ~= ALL_BOARD_KEY and boardKey ~= ARCHIVED_BOARD_KEY and boardKey ~= GLOBAL_BOARD_KEY then
            boards[#boards + 1] = boardKey
        end
    end
    return boards
end

local FALLBACK_BACKDROP = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
    insets = { left = 1, right = 1, top = 1, bottom = 1 },
}

local STATUS_ACCENT_COLORS = {
    TODO = "accentGold",
    DOING = "accentGold",
    DONE = "accentGold",
}

local function getThemeColor(colorOrKey, fallback)
    if Theme then
        return Theme:GetColor(colorOrKey, fallback)
    end
    if type(colorOrKey) == "table" then
        return colorOrKey
    end
    return fallback
end

local function applyPanelBackdrop(frame, bg, border)
    if Theme then
        Theme:ApplyBackdrop(frame, bg, border)
        return
    end

    local resolvedBg = getThemeColor(bg, { 0.05, 0.05, 0.06, 0.95 })
    local resolvedBorder = getThemeColor(border, { 1, 1, 1, 0.10 })

    frame:SetBackdrop(FALLBACK_BACKDROP)
    frame:SetBackdropColor(resolvedBg[1] or 0, resolvedBg[2] or 0, resolvedBg[3] or 0, resolvedBg[4] or 1)
    frame:SetBackdropBorderColor(
        resolvedBorder[1] or 1,
        resolvedBorder[2] or 1,
        resolvedBorder[3] or 1,
        resolvedBorder[4] or 1
    )
end

local function createPanel(parent, bg, border)
    if Theme then
        return Theme:CreatePanel(parent, bg, border)
    end

    local panel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    applyPanelBackdrop(panel, bg, border)
    return panel
end

local function createThemedButton(parent, width, height, text, paletteKey)
    local button
    if Theme then
        button = Theme:CreateButton(parent, width, height, text, paletteKey or "neutral")
        if button.label then
            button.label:ClearAllPoints()
            button.label:SetPoint("LEFT", button, "LEFT", 8, 0)
            button.label:SetPoint("RIGHT", button, "RIGHT", -8, 0)
            button.label:SetJustifyH("CENTER")
            if button.label.SetWordWrap then
                button.label:SetWordWrap(false)
            end
        end
    else
        button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        button:SetSize(width, height)
        button:SetText(text or "")
    end

    return button
end

local function setButtonEnabled(button, enabled)
    button:SetEnabled(enabled)
    button:SetAlpha(enabled and 1 or 0.48)
    if button.label then
        button.label:SetAlpha(enabled and 1 or 0.42)
    end
end

local function createThemedEditBox(parent, width, height)
    local editBox = CreateFrame("EditBox", nil, parent, "BackdropTemplate")
    editBox:SetSize(width, height)
    editBox:SetAutoFocus(false)
    editBox:SetTextInsets(9, 9, 0, 0)
    if GameFontHighlightSmall then
        editBox:SetFontObject(GameFontHighlightSmall)
    end

    applyPanelBackdrop(editBox, "input", "inputBorder")

    editBox:SetScript("OnEditFocusGained", function(self)
        applyPanelBackdrop(self, "inputFocus", "inputBorderFocus")
    end)
    editBox:SetScript("OnEditFocusLost", function(self)
        applyPanelBackdrop(self, "input", "inputBorder")
    end)
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)

    return editBox
end

local function setTextureColor(texture, colorOrKey, fallback)
    local color = getThemeColor(colorOrKey, fallback or { 1, 1, 1, 1 })
    texture:SetColorTexture(color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1)
end

local function addGoldTopAccent(frame, height, alpha)
    local accent = frame:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
    accent:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    accent:SetHeight(height or 2)
    setTextureColor(accent, { 1.0, 0.82, 0.18, alpha or 0.22 })
    return accent
end

local function saveFramePosition(frame)
    local point, _, _, x, y = frame:GetPoint(1)
    TODOPlannerDB.settings.frame.point = point or "CENTER"
    TODOPlannerDB.settings.frame.x = x or 0
    TODOPlannerDB.settings.frame.y = y or 0
end

local function getDateStamp(timestamp)
    if not timestamp then
        return ""
    end
    return date("%Y-%m-%d", timestamp)
end

local function getDateTimeStamp(timestamp)
    if not timestamp then
        return "Unknown"
    end
    return date("%Y-%m-%d %H:%M", timestamp)
end

local function findTaskById(taskId)
    for index, task in ipairs(TODOPlannerDB.tasks) do
        if task.id == taskId then
            return task, index
        end
    end
    return nil, nil
end

local function moveStatus(currentStatus, direction)
    local currentIndex
    for idx, status in ipairs(STATUS_ORDER) do
        if status == currentStatus then
            currentIndex = idx
            break
        end
    end

    if not currentIndex then
        return currentStatus
    end

    local target = currentIndex + direction
    if target < 1 then
        target = 1
    elseif target > #STATUS_ORDER then
        target = #STATUS_ORDER
    end

    return STATUS_ORDER[target]
end

local function sortTasksStable(tasks)
    table.sort(tasks, function(a, b)
        local aIndex = getStatusIndex(a.status)
        local bIndex = getStatusIndex(b.status)
        if aIndex ~= bIndex then
            return aIndex < bIndex
        end
        return (a.id or 0) < (b.id or 0)
    end)
end

local function getTaskBoardKey(task)
    return normalizeBoardKey(task and task.boardKey or GLOBAL_BOARD_KEY)
end

local function isTaskArchived(task)
    return task and task.archivedAt ~= nil
end

local function isTaskVisibleOnBoard(task, boardKey)
    local taskBoardKey = getTaskBoardKey(task)
    boardKey = normalizeBoardKey(boardKey)

    if boardKey == ALL_BOARD_KEY or boardKey == ARCHIVED_BOARD_KEY then
        return true
    end

    return taskBoardKey == boardKey
end

local function getTaskStatus(task, boardKey)
    return normalizeStatus(task and task.status)
end

local function setTaskStatus(task, boardKey, status)
    status = normalizeStatus(status)
    task.boardKey = getTaskBoardKey(task)
    task.status = status
    task.statusByBoard = nil
    task.updatedAt = time()
end

local function moveTaskToBoard(task, sourceBoardKey, targetBoardKey)
    local visibleStatus = getTaskStatus(task, sourceBoardKey)

    task.boardKey = normalizeBoardKey(targetBoardKey)
    task.status = visibleStatus
    task.statusByBoard = nil
    task.updatedAt = time()

    if task.boardKey ~= GLOBAL_BOARD_KEY then
        ensureKnownCharacter(task.boardKey)
    end
end

local function getTasksForStatus(status, boardKey)
    local filtered = {}
    local filterCategory = TODOPlannerDB.settings.filterCategory or "All"
    boardKey = normalizeBoardKey(boardKey)

    for _, task in ipairs(TODOPlannerDB.tasks) do
        local archiveStateMatches = boardKey == ARCHIVED_BOARD_KEY and isTaskArchived(task)
            or boardKey ~= ARCHIVED_BOARD_KEY and not isTaskArchived(task)
        if archiveStateMatches
            and isTaskVisibleOnBoard(task, boardKey)
            and getTaskStatus(task, boardKey) == status then
            if filterCategory == "All" or task.category == filterCategory then
                filtered[#filtered + 1] = task
            end
        end
    end

    table.sort(filtered, function(a, b)
        return (a.id or 0) < (b.id or 0)
    end)

    return filtered
end

local function showSingleSelectMenu(owner, options, selectedValue, getLabel, onSelect)
    if not TDP.menuFrame then
        TDP.menuFrame = createPanel(UIParent, "section", "goldBorder")
        TDP.menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        TDP.menuFrame:SetClampedToScreen(true)
        TDP.menuFrame:EnableMouse(true)
        TDP.menuFrame.buttons = {}
        TDP.menuFrame:Hide()
    end

    local menuFrame = TDP.menuFrame
    local optionHeight = 24
    local optionGap = 4
    local ownerWidth = owner and owner.GetWidth and owner:GetWidth() or 180
    local width = math.max(180, ownerWidth)
    local height = (#options * optionHeight) + (math.max(#options - 1, 0) * optionGap) + 12

    for _, button in ipairs(menuFrame.buttons) do
        button:Hide()
        button:SetParent(menuFrame)
    end

    for optionIndex, value in ipairs(options) do
        local optionValue = value
        local button = menuFrame.buttons[optionIndex]
        if not button then
            button = createThemedButton(menuFrame, width - 12, optionHeight, "", "neutral")
            menuFrame.buttons[optionIndex] = button
        end

        local label = getLabel and getLabel(optionValue) or tostring(optionValue)
        local isSelected = optionValue == selectedValue
        button:SetSize(width - 12, optionHeight)
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", 6, -6 - ((optionIndex - 1) * (optionHeight + optionGap)))
        button:SetText((isSelected and "* " or "") .. label)
        if button.SetSelected then
            button:SetSelected(isSelected)
        end
        button:SetScript("OnClick", function()
            menuFrame:Hide()
            onSelect(optionValue)
        end)
        button:Show()
    end

    menuFrame:SetSize(width, height)
    menuFrame:ClearAllPoints()
    menuFrame:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", 0, -4)
    menuFrame:Show()
    if Theme then
        Theme:BringToFront(menuFrame, owner)
    end
end

local function updateButtonLabel(button, prefix, value, formatter)
    local label = formatter and formatter(value) or tostring(value)
    button:SetText(prefix .. ": " .. label)
end

local function resetEditor(ui)
    ui.editingTaskId = nil
    ui.inputTitle:SetText("")
    ui.saveButton:SetText("Add Task")
end

local function loadEditor(ui, task)
    ui.editingTaskId = task.id
    ui.inputTitle:SetText(task.title or "")
    ui.saveButton:SetText("Save Task")
end

local function confirmArchiveTask(ui, taskRef)
    if not taskRef then
        return
    end

    StaticPopupDialogs["TODO_PLANNER_ARCHIVE_TASK"] = {
        text = "Archive task: \"" .. (taskRef.title or "") .. "\"?",
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            local task = findTaskById(taskRef.id)
            if not task then
                return
            end

            task.archivedAt = time()
            task.updatedAt = task.archivedAt

            if ui.detailFrame and ui.detailFrame.taskId == task.id then
                ui.detailFrame:Hide()
            end
            if ui.editingTaskId == task.id then
                resetEditor(ui)
            end

            ui:Render()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_ARCHIVE_TASK")
end

local function formatStatus(status)
    status = normalizeStatus(status)
    return STATUS_LABELS[status] or status
end

local function configureDetailText(fontString, allowWrap)
    fontString:SetJustifyH("LEFT")
    if fontString.SetWordWrap then
        fontString:SetWordWrap(allowWrap == true)
    end
    if allowWrap and fontString.SetNonSpaceWrap then
        fontString:SetNonSpaceWrap(true)
    end
end

local function createTaskDetailWindow(ui)
    local frame = CreateFrame("Frame", "TODOPlannerTaskDetailFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(540, 500)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    local body
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Task Details")
        body = createPanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = addGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerTaskDetailFrame")
    else
        applyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

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
    configureDetailText(titleText, false)
    frame.titleText = titleText

    local details = createPanel(body, "section", "goldBorder")
    details:SetPoint("TOPLEFT", 14, -54)
    details:SetPoint("TOPRIGHT", -14, -54)
    details:SetHeight(126)
    details.topAccent = addGoldTopAccent(details, 2, 0.18)

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
        configureDetailText(value, false)

        rowY = rowY - 22
        return value
    end

    frame.idValue = addDetailRow("ID")
    frame.statusValue = addDetailRow("Status")
    frame.categoryValue = addDetailRow("Category")
    frame.createdValue = addDetailRow("Created")
    frame.updatedValue = addDetailRow("Updated")

    local notes = createPanel(body, "section", "goldBorder")
    notes:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -12)
    notes:SetPoint("BOTTOMRIGHT", body, "BOTTOMRIGHT", -14, 52)
    notes.topAccent = addGoldTopAccent(notes, 2, 0.18)

    local notesLabel = notes:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    notesLabel:SetPoint("TOPLEFT", 12, -10)
    notesLabel:SetText("Notes")

    local notesValue = notes:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    notesValue:SetPoint("TOPLEFT", 12, -32)
    notesValue:SetPoint("BOTTOMRIGHT", notes, "BOTTOMRIGHT", -12, 12)
    configureDetailText(notesValue, true)
    notesValue:SetJustifyV("TOP")
    frame.notesValue = notesValue

    local closeButton = createThemedButton(body, 76, 24, "Close", "neutral")
    closeButton:SetPoint("BOTTOMRIGHT", -14, 16)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local editButton = createThemedButton(body, 76, 24, "Edit", "primary")
    editButton:SetPoint("RIGHT", closeButton, "LEFT", -8, 0)
    editButton:SetScript("OnClick", function()
        local task = findTaskById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        if not ui.frame:IsShown() then
            ui:Render()
            ui.frame:Show()
        end

        loadEditor(ui, task)
        ui.inputTitle:SetFocus()
        frame:Hide()
    end)

    local archiveButton = createThemedButton(body, 86, 24, "Archive", "danger")
    archiveButton:SetPoint("RIGHT", editButton, "LEFT", -8, 0)
    archiveButton:SetScript("OnClick", function()
        local task = findTaskById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        confirmArchiveTask(ui, task)
    end)
    frame.archiveButton = archiveButton

    local moveBoardButton = createThemedButton(body, 180, 24, "Move to Board", "neutral")
    moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
    moveBoardButton:SetScript("OnClick", function(self)
        local task = findTaskById(frame.taskId)
        if not task or getTaskBoardKey(task) ~= GLOBAL_BOARD_KEY then
            return
        end

        local boardOptions = getCharacterBoardOptions()
        if #boardOptions == 0 then
            msg("No character boards are available.")
            return
        end

        showSingleSelectMenu(self, boardOptions, nil, getBoardDisplayName, function(targetBoardKey)
            task = findTaskById(frame.taskId)
            if not task then
                frame:Hide()
                return
            end

            moveTaskToBoard(task, ui:GetSelectedBoardKey(), targetBoardKey)
            TODOPlannerDB.settings.selectedBoard = targetBoardKey
            sortTasksStable(TODOPlannerDB.tasks)
            ui:Render()
            frame:UpdateTask(task)
        end)
    end)
    frame.moveBoardButton = moveBoardButton

    function frame:UpdateTask(task)
        local taskBoardKey = getTaskBoardKey(task)
        local visibleStatus = getTaskStatus(task)
        local notesText = trim(task.notes or "")

        self.taskId = task.id
        self.titleText:SetText(task.title or "(Untitled)")
        self.idValue:SetText("#" .. tostring(task.id or "?"))
        self.statusValue:SetText(formatStatus(visibleStatus))
        self.categoryValue:SetText(task.category or "Other")
        self.createdValue:SetText(getDateTimeStamp(task.createdAt))
        self.updatedValue:SetText(getDateTimeStamp(task.updatedAt))
        self.notesValue:SetText(notesText ~= "" and notesText or "No notes.")

        if isTaskArchived(task) then
            self.archiveButton:Hide()
        else
            self.archiveButton:Show()
        end

        if taskBoardKey == GLOBAL_BOARD_KEY then
            self.moveBoardButton:Show()
        else
            self.moveBoardButton:Hide()
        end
    end

    function frame:OpenTask(task)
        self:UpdateTask(task)
        self:ClearAllPoints()
        self:SetPoint("CENTER", ui.frame, "CENTER", 0, 0)
        self:Show()
        if Theme then
            Theme:BringToFront(self, ui.frame)
        end
    end

    frame:Hide()
    return frame
end

local function openTaskDetailWindow(ui, task)
    if not ui.detailFrame then
        ui.detailFrame = createTaskDetailWindow(ui)
    end

    ui.detailFrame:OpenTask(task)
end

local function createTaskCard(parent, task, status, ui)
    local card = createPanel(parent, "rowOdd", "goldBorder")
    card:SetSize(286, 104)
    addGoldTopAccent(card, 2, 0.18)

    local accent = card:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -1)
    accent:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 1)
    accent:SetWidth(3)
    setTextureColor(accent, STATUS_ACCENT_COLORS[status], { 1.0, 0.82, 0.18, 0.68 })

    local title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 12, -10)
    title:SetPoint("TOPRIGHT", -12, -10)
    title:SetJustifyH("LEFT")
    if title.SetWordWrap then
        title:SetWordWrap(false)
    end
    title:SetText(task.title or "(Untitled)")

    local meta = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    meta:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    meta:SetPoint("RIGHT", card, "RIGHT", -12, 0)
    meta:SetJustifyH("LEFT")

    local notes = task.notes and trim(task.notes) or ""
    local notePreview = notes ~= "" and (" - " .. notes:sub(1, 32)) or ""
    if #notes > 32 then
        notePreview = notePreview .. "..."
    end

    meta:SetText(string.format("Category: %s%s", task.category or "Other", notePreview))

    local stamp = card:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    stamp:SetPoint("TOPLEFT", meta, "BOTTOMLEFT", 0, -4)
    stamp:SetText("Added " .. getDateStamp(task.createdAt))

    local leftBtn = createThemedButton(card, 26, 22, "<", "subtle")
    leftBtn:SetPoint("BOTTOMLEFT", 12, 10)
    leftBtn.tooltipText = "Move left"

    local rightBtn = createThemedButton(card, 26, 22, ">", "subtle")
    rightBtn:SetPoint("LEFT", leftBtn, "RIGHT", 4, 0)
    rightBtn.tooltipText = "Move right"

    local openBtn = createThemedButton(card, 52, 22, "Open", "neutral")

    local archiveBtn = createThemedButton(card, 66, 22, "Archive", "subtle")
    archiveBtn.tooltipText = "Archive"

    local deleteBtn = createThemedButton(card, 62, 22, "Delete", "danger")
    deleteBtn:SetPoint("BOTTOMRIGHT", -12, 10)
    archiveBtn:SetPoint("RIGHT", deleteBtn, "LEFT", -4, 0)
    openBtn:SetPoint("RIGHT", archiveBtn, "LEFT", -4, 0)

    local statusIndex = indexOf(STATUS_ORDER, status) or 1
    setButtonEnabled(leftBtn, statusIndex > 1)
    setButtonEnabled(rightBtn, statusIndex < #STATUS_ORDER)
    setButtonEnabled(archiveBtn, not isTaskArchived(task))

    leftBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask then
            return
        end

        local boardKey = ui:GetSelectedBoardKey()
        local currentStatus = getTaskStatus(dbTask, boardKey)
        setTaskStatus(dbTask, boardKey, moveStatus(currentStatus, -1))
        ui:Render()
    end)

    rightBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask then
            return
        end

        local boardKey = ui:GetSelectedBoardKey()
        local currentStatus = getTaskStatus(dbTask, boardKey)
        setTaskStatus(dbTask, boardKey, moveStatus(currentStatus, 1))
        ui:Render()
    end)

    openBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask then
            return
        end

        openTaskDetailWindow(ui, dbTask)
    end)

    archiveBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask or isTaskArchived(dbTask) then
            return
        end

        confirmArchiveTask(ui, dbTask)
    end)

    deleteBtn:SetScript("OnClick", function()
        local taskRef = task
        StaticPopupDialogs["TODO_PLANNER_DELETE_TASK"] = {
            text = "Delete task: \"" .. (taskRef.title or "") .. "\"?",
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                local _, index = findTaskById(taskRef.id)
                if index then
                    table.remove(TODOPlannerDB.tasks, index)
                    if ui.detailFrame and ui.detailFrame.taskId == taskRef.id then
                        ui.detailFrame:Hide()
                    end
                    if ui.editingTaskId == taskRef.id then
                        resetEditor(ui)
                    end
                    ui:Render()
                end
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("TODO_PLANNER_DELETE_TASK")
    end)

    return card
end

local function createColumn(parent, status, offsetX)
    local column = createPanel(parent, "panel", "goldBorder")
    column:SetSize(330, 456)
    column:SetPoint("TOPLEFT", offsetX, -108)
    column.topAccent = addGoldTopAccent(column, 3, 0.30)

    local title = column:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 14, -12)
    title:SetJustifyH("LEFT")
    title:SetText(STATUS_LABELS[status])

    local count = column:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    count:SetPoint("TOPRIGHT", column, "TOPRIGHT", -14, -16)
    count:SetJustifyH("RIGHT")

    local accent = column:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", column, "TOPLEFT", 1, -38)
    accent:SetPoint("TOPRIGHT", column, "TOPRIGHT", -1, -38)
    accent:SetHeight(2)
    setTextureColor(accent, STATUS_ACCENT_COLORS[status], { 1.0, 0.82, 0.18, 0.68 })

    local scroll = CreateFrame("ScrollFrame", nil, column, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 12, -46)
    scroll:SetPoint("BOTTOMRIGHT", -28, 12)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 1)
    scroll:SetScrollChild(content)

    column.status = status
    column.count = count
    column.scroll = scroll
    column.content = content
    column.cards = {}

    return column
end

local function buildUI()
    local frame = CreateFrame("Frame", "TODOPlannerMainFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(1100, 660)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        saveFramePosition(self)
    end)

    local pos = TODOPlannerDB.settings.frame
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.point or "CENTER", pos.x or 0, pos.y or 0)

    local body
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "TODO Planner")

        local subtitle = frame.headerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("LEFT", frame.headerBar, "LEFT", 15, -12)
        subtitle:SetText("Character boards with shared Global tasks")

        body = createPanel(frame, "body", "goldBorder")
        body:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        body:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
        body.topAccent = addGoldTopAccent(body, 3, 0.22)
        Theme:RegisterSpecialFrame("TODOPlannerMainFrame")
    else
        applyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("TODO Planner")

        local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        subtitle:SetText("Character boards with shared Global tasks")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)

        body = frame
    end

    local toolbar = createPanel(body, "section", "goldBorder")
    toolbar:SetPoint("TOPLEFT", 12, -12)
    toolbar:SetPoint("TOPRIGHT", -12, -12)
    toolbar:SetHeight(84)
    toolbar.topAccent = addGoldTopAccent(toolbar, 2, 0.20)

    local boardButton = createThemedButton(toolbar, 270, 24, "", "neutral")
    boardButton:SetPoint("TOPLEFT", 12, -12)

    local filterButton = createThemedButton(toolbar, 180, 24, "", "neutral")
    filterButton:SetPoint("LEFT", boardButton, "RIGHT", 8, 0)

    local inputTitle = createThemedEditBox(toolbar, 360, 24)
    inputTitle:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 12, -48)
    inputTitle:SetMaxLetters(120)

    local titleLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    titleLabel:SetPoint("BOTTOMLEFT", inputTitle, "TOPLEFT", 4, 4)
    titleLabel:SetText("Task Name")

    local saveButton = createThemedButton(toolbar, 104, 24, "Add Task", "primary")
    saveButton:SetPoint("LEFT", inputTitle, "RIGHT", 8, 0)

    local detailedButton = createThemedButton(toolbar, 132, 24, "Create Detailed", "neutral")
    detailedButton:SetPoint("LEFT", saveButton, "RIGHT", 8, 0)

    local ui = {
        frame = frame,
        body = body,
        toolbar = toolbar,
        boardButton = boardButton,
        filterButton = filterButton,
        inputTitle = inputTitle,
        saveButton = saveButton,
        detailedButton = detailedButton,
        editingTaskId = nil,
    }

    function ui:GetSelectedBoardKey()
        local boardKey = normalizeBoardKey(TODOPlannerDB.settings.selectedBoard)
        if boardKey ~= GLOBAL_BOARD_KEY and not isKnownBoard(boardKey) then
            boardKey = getPlayerBoardKey()
            ensureKnownCharacter(boardKey)
            TODOPlannerDB.settings.selectedBoard = boardKey
        end
        return boardKey
    end

    local colTodo = createColumn(body, "TODO", 12)
    local colDoing = createColumn(body, "DOING", 361)
    local colDone = createColumn(body, "DONE", 710)

    ui.columns = {
        TODO = colTodo,
        DOING = colDoing,
        DONE = colDone,
    }

    boardButton:SetScript("OnClick", function(self)
        showSingleSelectMenu(self, getBoardOptions(), ui:GetSelectedBoardKey(), getBoardDisplayName, function(boardKey)
            TODOPlannerDB.settings.selectedBoard = boardKey
            resetEditor(ui)
            ui:Render()
        end)
    end)

    filterButton:SetScript("OnClick", function(self)
        showSingleSelectMenu(self, FILTER_CATEGORIES, TODOPlannerDB.settings.filterCategory or "All", nil, function(category)
            TODOPlannerDB.settings.filterCategory = category
            ui:Render()
        end)
    end)

    saveButton:SetScript("OnClick", function()
        local titleText = trim(inputTitle:GetText())
        if titleText == "" then
            msg("Task title is required.")
            return
        end

        if ui.editingTaskId then
            local task = findTaskById(ui.editingTaskId)
            if task then
                task.title = titleText
                task.updatedAt = time()
            end
        else
            local targetBoardKey = getPlayerBoardKey()
            ensureKnownCharacter(targetBoardKey)

            local newTask = {
                id = TODOPlannerDB.nextTaskId,
                title = titleText,
                notes = "",
                category = "General",
                status = "TODO",
                boardKey = targetBoardKey,
                createdAt = time(),
                updatedAt = time(),
            }

            TODOPlannerDB.nextTaskId = TODOPlannerDB.nextTaskId + 1
            table.insert(TODOPlannerDB.tasks, newTask)
            TODOPlannerDB.settings.selectedBoard = targetBoardKey
        end

        sortTasksStable(TODOPlannerDB.tasks)
        resetEditor(ui)
        ui:Render()
    end)

    detailedButton:SetScript("OnClick", function()
    end)

    inputTitle:SetScript("OnEnterPressed", function()
        saveButton:Click()
    end)

    function ui:Render()
        local boardKey = self:GetSelectedBoardKey()
        updateButtonLabel(boardButton, "Board", boardKey, getBoardDisplayName)
        updateButtonLabel(filterButton, "Filter", TODOPlannerDB.settings.filterCategory or "All")

        for status, column in pairs(self.columns) do
            for _, oldCard in ipairs(column.cards) do
                oldCard:Hide()
                oldCard:SetParent(nil)
            end
            wipe(column.cards)

            local tasks = getTasksForStatus(status, boardKey)
            column.count:SetText(tostring(#tasks))

            local y = -6
            for _, task in ipairs(tasks) do
                local card = createTaskCard(column.content, task, status, self)
                card:SetPoint("TOPLEFT", 4, y)
                y = y - 112
                column.cards[#column.cards + 1] = card
            end

            local minHeight = column.scroll:GetHeight()
            local contentHeight = math.max(minHeight, math.abs(y) + 12)
            column.content:SetSize(294, contentHeight)
        end

        if self.detailFrame and self.detailFrame:IsShown() and self.detailFrame.taskId then
            local detailTask = findTaskById(self.detailFrame.taskId)
            if detailTask then
                self.detailFrame:UpdateTask(detailTask)
            else
                self.detailFrame:Hide()
            end
        end
    end

    resetEditor(ui)
    frame:Hide()

    return ui
end

local function toggleMainFrame()
    if not TDP.ui then
        return
    end

    if TDP.ui.frame:IsShown() then
        TDP.ui.frame:Hide()
    else
        TDP.ui:Render()
        TDP.ui.frame:Show()
    end
end

local function resetWindowPosition()
    TODOPlannerDB.settings.frame.point = "CENTER"
    TODOPlannerDB.settings.frame.x = 0
    TODOPlannerDB.settings.frame.y = 0

    TDP.ui.frame:ClearAllPoints()
    TDP.ui.frame:SetPoint("CENTER")
end

local function initSlashCommands()
    SLASH_TODOPLANNER1 = "/todoplanner"
    SLASH_TODOPLANNER2 = "/tdp"

    SlashCmdList.TODOPLANNER = function(message)
        local cmd = trim((message or ""):lower())

        if cmd == "" or cmd == "toggle" then
            toggleMainFrame()
            return
        end

        if cmd == "show" then
            if not TDP.ui.frame:IsShown() then
                toggleMainFrame()
            end
            return
        end

        if cmd == "hide" then
            if TDP.ui.frame:IsShown() then
                toggleMainFrame()
            end
            return
        end

        if cmd == "resetpos" then
            resetWindowPosition()
            msg("Window position reset.")
            return
        end

        if cmd == "help" then
            msg("/tdp toggle - Show/hide planner")
            msg("/tdp show - Show planner")
            msg("/tdp hide - Hide planner")
            msg("/tdp resetpos - Reset window position")
            return
        end

        msg("Unknown command. Use /tdp help")
    end
end

local function initDatabase()
    if type(TODOPlannerDB) ~= "table" then
        TODOPlannerDB = {}
    end

    TODOPlannerDB = copyDefaults(TODOPlannerDB, DEFAULT_DB)

    if type(TODOPlannerDB.tasks) ~= "table" then
        TODOPlannerDB.tasks = {}
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        TODOPlannerDB.characters = {}
    end

    local highestId = 0
    local currentBoardKey = getPlayerBoardKey()
    local seenCharacters = {}
    local characters = {}

    local function trackCharacter(boardKey)
        boardKey = normalizeBoardKey(boardKey)
        if boardKey == ALL_BOARD_KEY
            or boardKey == ARCHIVED_BOARD_KEY
            or boardKey == GLOBAL_BOARD_KEY
            or seenCharacters[boardKey] then
            return
        end

        seenCharacters[boardKey] = true
        characters[#characters + 1] = boardKey
    end

    trackCharacter(currentBoardKey)

    for _, boardKey in ipairs(TODOPlannerDB.characters) do
        trackCharacter(boardKey)
    end

    for _, task in ipairs(TODOPlannerDB.tasks) do
        if type(task.id) == "number" and task.id > highestId then
            highestId = task.id
        end

        task.boardKey = normalizeBoardKey(task.boardKey or GLOBAL_BOARD_KEY)
        if task.boardKey == ALL_BOARD_KEY or task.boardKey == ARCHIVED_BOARD_KEY then
            task.boardKey = GLOBAL_BOARD_KEY
        end
        task.status = normalizeStatus(task.status)
        task.category = indexOf(TASK_CATEGORIES, task.category) and task.category or "Other"
        task.title = task.title or "Untitled"
        task.notes = task.notes or ""
        task.createdAt = task.createdAt or time()
        task.updatedAt = task.updatedAt or task.createdAt
        if task.archivedAt ~= nil and type(task.archivedAt) ~= "number" then
            task.archivedAt = nil
        end

        if task.boardKey ~= GLOBAL_BOARD_KEY then
            trackCharacter(task.boardKey)
        end

        if type(task.statusByBoard) == "table" then
            for boardKey, status in pairs(task.statusByBoard) do
                local normalizedBoardKey = normalizeBoardKey(boardKey)
                if normalizedBoardKey ~= ALL_BOARD_KEY
                    and normalizedBoardKey ~= ARCHIVED_BOARD_KEY
                    and normalizedBoardKey ~= GLOBAL_BOARD_KEY then
                    if task.boardKey == GLOBAL_BOARD_KEY and normalizedBoardKey == currentBoardKey then
                        task.status = normalizeStatus(status)
                    end
                    trackCharacter(normalizedBoardKey)
                end
            end
        end
        task.statusByBoard = nil
    end

    sortCharacterBoards(characters)
    TODOPlannerDB.characters = characters
    sortTasksStable(TODOPlannerDB.tasks)

    if type(TODOPlannerDB.nextTaskId) ~= "number" or TODOPlannerDB.nextTaskId <= highestId then
        TODOPlannerDB.nextTaskId = highestId + 1
    end

    if not indexOf(FILTER_CATEGORIES, TODOPlannerDB.settings.filterCategory) then
        TODOPlannerDB.settings.filterCategory = "All"
    end

    local selectedBoard = TODOPlannerDB.settings.selectedBoard
    if type(selectedBoard) ~= "string" or trim(selectedBoard) == "" then
        selectedBoard = currentBoardKey
    else
        selectedBoard = normalizeBoardKey(selectedBoard)
    end

    if selectedBoard ~= ALL_BOARD_KEY
        and selectedBoard ~= ARCHIVED_BOARD_KEY
        and selectedBoard ~= GLOBAL_BOARD_KEY
        and not seenCharacters[selectedBoard] then
        selectedBoard = currentBoardKey
    end

    TODOPlannerDB.settings.selectedBoard = selectedBoard
    TODOPlannerDB.version = DEFAULT_DB.version
end

TDP:RegisterEvent("ADDON_LOADED")
TDP:SetScript("OnEvent", function(_, event, addonName)
    if event ~= "ADDON_LOADED" or addonName ~= ADDON_NAME then
        return
    end

    initDatabase()
    TDP.ui = buildUI()
    initSlashCommands()

    msg("Loaded. Use /tdp to open your board.")
end)
