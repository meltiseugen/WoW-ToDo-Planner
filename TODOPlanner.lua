local ADDON_NAME = ...

local TDP = CreateFrame("Frame")

local GLOBAL_BOARD_KEY = "GLOBAL"

local STATUS_ORDER = { "TODO", "DOING", "DONE" }
local STATUS_LABELS = {
    TODO = "To Do",
    DOING = "In Progress",
    DONE = "Done",
}

local TASK_CATEGORIES = {
    "Achievements",
    "Mounts",
    "Collections",
    "Reputation",
    "Other",
}

local FILTER_CATEGORIES = {
    "All",
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

    return boardKey
end

local function getBoardDisplayName(boardKey)
    boardKey = normalizeBoardKey(boardKey)
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
    if boardKey == GLOBAL_BOARD_KEY then
        return true
    end

    if type(TODOPlannerDB.characters) ~= "table" then
        return false
    end

    return indexOf(TODOPlannerDB.characters, boardKey) ~= nil
end

local function ensureKnownCharacter(boardKey)
    boardKey = normalizeBoardKey(boardKey)
    if boardKey == GLOBAL_BOARD_KEY then
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
    local boards = { GLOBAL_BOARD_KEY }
    local characters = {}
    local seen = {
        [GLOBAL_BOARD_KEY] = true,
    }

    if type(TODOPlannerDB.characters) == "table" then
        for _, boardKey in ipairs(TODOPlannerDB.characters) do
            boardKey = normalizeBoardKey(boardKey)
            if boardKey ~= GLOBAL_BOARD_KEY and not seen[boardKey] then
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

local function setBackdrop(frame, r, g, b, a)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    frame:SetBackdropColor(r, g, b, a)
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

local function isTaskVisibleOnBoard(task, boardKey)
    local taskBoardKey = getTaskBoardKey(task)
    boardKey = normalizeBoardKey(boardKey)

    if taskBoardKey == GLOBAL_BOARD_KEY then
        return true
    end

    return boardKey ~= GLOBAL_BOARD_KEY and taskBoardKey == boardKey
end

local function getTaskStatus(task, boardKey)
    local defaultStatus = normalizeStatus(task and task.status)
    local taskBoardKey = getTaskBoardKey(task)
    boardKey = normalizeBoardKey(boardKey)

    if taskBoardKey == GLOBAL_BOARD_KEY and boardKey ~= GLOBAL_BOARD_KEY then
        local overrides = type(task.statusByBoard) == "table" and task.statusByBoard or nil
        if overrides and overrides[boardKey] then
            return normalizeStatus(overrides[boardKey])
        end
    end

    return defaultStatus
end

local function setTaskStatus(task, boardKey, status)
    boardKey = normalizeBoardKey(boardKey)
    status = normalizeStatus(status)
    task.boardKey = getTaskBoardKey(task)

    if task.boardKey == GLOBAL_BOARD_KEY and boardKey ~= GLOBAL_BOARD_KEY then
        task.status = normalizeStatus(task.status)
        task.statusByBoard = type(task.statusByBoard) == "table" and task.statusByBoard or {}

        if status == task.status then
            task.statusByBoard[boardKey] = nil
        else
            task.statusByBoard[boardKey] = status
        end

        if not next(task.statusByBoard) then
            task.statusByBoard = nil
        end
    else
        task.status = status
        if task.boardKey ~= GLOBAL_BOARD_KEY then
            task.statusByBoard = nil
        end
    end

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
        if isTaskVisibleOnBoard(task, boardKey) and getTaskStatus(task, boardKey) == status then
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
        TDP.menuFrame = CreateFrame("Frame", "TODOPlannerMenuFrame", UIParent, "UIDropDownMenuTemplate")
    end

    local menu = {}
    for _, value in ipairs(options) do
        local optionValue = value
        menu[#menu + 1] = {
            text = getLabel and getLabel(optionValue) or tostring(optionValue),
            checked = optionValue == selectedValue,
            func = function()
                onSelect(optionValue)
            end,
            keepShownOnClick = false,
            isNotRadio = false,
        }
    end

    EasyMenu(menu, TDP.menuFrame, owner, 0, 0, "MENU")
end

local function updateButtonLabel(button, prefix, value, formatter)
    local label = formatter and formatter(value) or tostring(value)
    button:SetText(prefix .. ": " .. label)
end

local function resetEditor(ui)
    ui.editingTaskId = nil
    ui.inputTitle:SetText("")
    ui.inputNotes:SetText("")
    ui.selectedCategoryIndex = 1
    ui.selectedLocationKey = ui:GetSelectedBoardKey()
    updateButtonLabel(ui.categoryButton, "Category", TASK_CATEGORIES[ui.selectedCategoryIndex])
    updateButtonLabel(ui.locationButton, "Location", ui.selectedLocationKey, getBoardDisplayName)
    ui.saveButton:SetText("Add Task")
end

local function loadEditor(ui, task)
    ui.editingTaskId = task.id
    ui.inputTitle:SetText(task.title or "")
    ui.inputNotes:SetText(task.notes or "")

    local categoryIndex = indexOf(TASK_CATEGORIES, task.category or "") or 1
    ui.selectedCategoryIndex = categoryIndex
    ui.selectedLocationKey = getTaskBoardKey(task)

    updateButtonLabel(ui.categoryButton, "Category", TASK_CATEGORIES[ui.selectedCategoryIndex])
    updateButtonLabel(ui.locationButton, "Location", ui.selectedLocationKey, getBoardDisplayName)
    ui.saveButton:SetText("Save Task")
end

local function createTaskCard(parent, task, status, ui)
    local card = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    card:SetSize(300, 92)
    setBackdrop(card, 0.08, 0.08, 0.10, 0.95)

    local title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 10, -10)
    title:SetPoint("TOPRIGHT", -10, -10)
    title:SetJustifyH("LEFT")
    title:SetText(task.title or "(Untitled)")

    local meta = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    meta:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    meta:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    meta:SetJustifyH("LEFT")

    local notes = task.notes and trim(task.notes) or ""
    local notePreview = notes ~= "" and (" | " .. notes:sub(1, 36)) or ""
    if #notes > 36 then
        notePreview = notePreview .. "..."
    end

    local locationPrefix = getTaskBoardKey(task) == GLOBAL_BOARD_KEY and "Global | " or ""
    meta:SetText(string.format("%s%s%s", locationPrefix, task.category or "Other", notePreview))

    local stamp = card:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    stamp:SetPoint("TOPLEFT", meta, "BOTTOMLEFT", 0, -4)
    stamp:SetText("Created: " .. getDateStamp(task.createdAt))

    local leftBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    leftBtn:SetSize(24, 20)
    leftBtn:SetPoint("BOTTOMLEFT", 10, 10)
    leftBtn:SetText("<")

    local rightBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    rightBtn:SetSize(24, 20)
    rightBtn:SetPoint("LEFT", leftBtn, "RIGHT", 4, 0)
    rightBtn:SetText(">")

    local openBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    openBtn:SetSize(44, 20)
    openBtn:SetPoint("BOTTOMRIGHT", -56, 10)
    openBtn:SetText("Open")

    local deleteBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    deleteBtn:SetSize(40, 20)
    deleteBtn:SetPoint("LEFT", openBtn, "RIGHT", 4, 0)
    deleteBtn:SetText("Del")

    local statusIndex = indexOf(STATUS_ORDER, status) or 1
    leftBtn:SetEnabled(statusIndex > 1)
    rightBtn:SetEnabled(statusIndex < #STATUS_ORDER)

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

        loadEditor(ui, dbTask)
        ui.inputTitle:SetFocus()
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

local function createColumn(parent, titleText, offsetX, offsetY)
    local column = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    column:SetSize(335, 442)
    column:SetPoint("TOPLEFT", offsetX, offsetY)
    setBackdrop(column, 0.05, 0.05, 0.06, 0.95)

    local title = column:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText(titleText)

    local scroll = CreateFrame("ScrollFrame", nil, column, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 10, -40)
    scroll:SetPoint("BOTTOMRIGHT", -28, 10)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 1)
    scroll:SetScrollChild(content)

    column.scroll = scroll
    column.content = content
    column.cards = {}

    return column
end

local function buildUI()
    local frame = CreateFrame("Frame", "TODOPlannerMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(1080, 640)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        saveFramePosition(self)
    end)

    setBackdrop(frame, 0.02, 0.02, 0.03, 0.98)

    local pos = TODOPlannerDB.settings.frame
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.point or "CENTER", pos.x or 0, pos.y or 0)

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("TODO Planner")

    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    subtitle:SetText("Character boards with shared Global tasks")

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -6, -6)

    local boardButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    boardButton:SetSize(260, 22)
    boardButton:SetPoint("TOPLEFT", 16, -52)

    local filterButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    filterButton:SetSize(170, 22)
    filterButton:SetPoint("LEFT", boardButton, "RIGHT", 8, 0)

    local inputTitle = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    inputTitle:SetSize(190, 20)
    inputTitle:SetPoint("TOPLEFT", boardButton, "BOTTOMLEFT", 0, -18)
    inputTitle:SetAutoFocus(false)
    inputTitle:SetMaxLetters(120)

    local titleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    titleLabel:SetPoint("BOTTOMLEFT", inputTitle, "TOPLEFT", 4, 4)
    titleLabel:SetText("Task")

    local inputNotes = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    inputNotes:SetSize(230, 20)
    inputNotes:SetPoint("LEFT", inputTitle, "RIGHT", 8, 0)
    inputNotes:SetAutoFocus(false)
    inputNotes:SetMaxLetters(160)

    local notesLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    notesLabel:SetPoint("BOTTOMLEFT", inputNotes, "TOPLEFT", 4, 4)
    notesLabel:SetText("Notes")

    local categoryButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    categoryButton:SetSize(140, 22)
    categoryButton:SetPoint("LEFT", inputNotes, "RIGHT", 8, 0)

    local locationButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    locationButton:SetSize(220, 22)
    locationButton:SetPoint("LEFT", categoryButton, "RIGHT", 8, 0)

    local saveButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    saveButton:SetSize(95, 22)
    saveButton:SetPoint("LEFT", locationButton, "RIGHT", 8, 0)
    saveButton:SetText("Add Task")

    local clearButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    clearButton:SetSize(95, 22)
    clearButton:SetPoint("LEFT", saveButton, "RIGHT", 6, 0)
    clearButton:SetText("Clear")

    local ui = {
        frame = frame,
        boardButton = boardButton,
        filterButton = filterButton,
        inputTitle = inputTitle,
        inputNotes = inputNotes,
        categoryButton = categoryButton,
        locationButton = locationButton,
        saveButton = saveButton,
        clearButton = clearButton,
        selectedCategoryIndex = 1,
        selectedLocationKey = GLOBAL_BOARD_KEY,
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

    local colTodo = createColumn(frame, STATUS_LABELS.TODO, 16, -150)
    local colDoing = createColumn(frame, STATUS_LABELS.DOING, 372, -150)
    local colDone = createColumn(frame, STATUS_LABELS.DONE, 728, -150)

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

    categoryButton:SetScript("OnClick", function(self)
        showSingleSelectMenu(self, TASK_CATEGORIES, TASK_CATEGORIES[ui.selectedCategoryIndex], nil, function(category)
            ui.selectedCategoryIndex = indexOf(TASK_CATEGORIES, category) or 1
            updateButtonLabel(ui.categoryButton, "Category", TASK_CATEGORIES[ui.selectedCategoryIndex])
        end)
    end)

    locationButton:SetScript("OnClick", function(self)
        showSingleSelectMenu(self, getBoardOptions(), ui.selectedLocationKey, getBoardDisplayName, function(boardKey)
            ui.selectedLocationKey = boardKey
            updateButtonLabel(ui.locationButton, "Location", ui.selectedLocationKey, getBoardDisplayName)
        end)
    end)

    saveButton:SetScript("OnClick", function()
        local titleText = trim(inputTitle:GetText())
        local notesText = trim(inputNotes:GetText())
        if titleText == "" then
            msg("Task title is required.")
            return
        end

        local category = TASK_CATEGORIES[ui.selectedCategoryIndex]
        local targetBoardKey = normalizeBoardKey(ui.selectedLocationKey or ui:GetSelectedBoardKey())

        if ui.editingTaskId then
            local task = findTaskById(ui.editingTaskId)
            if task then
                local originalBoardKey = getTaskBoardKey(task)
                task.title = titleText
                task.notes = notesText
                task.category = category

                if originalBoardKey ~= targetBoardKey then
                    moveTaskToBoard(task, ui:GetSelectedBoardKey(), targetBoardKey)
                else
                    task.updatedAt = time()
                end
            end
        else
            local newTask = {
                id = TODOPlannerDB.nextTaskId,
                title = titleText,
                notes = notesText,
                category = category,
                status = "TODO",
                boardKey = targetBoardKey,
                createdAt = time(),
                updatedAt = time(),
            }

            if targetBoardKey ~= GLOBAL_BOARD_KEY then
                ensureKnownCharacter(targetBoardKey)
            end

            TODOPlannerDB.nextTaskId = TODOPlannerDB.nextTaskId + 1
            table.insert(TODOPlannerDB.tasks, newTask)
        end

        sortTasksStable(TODOPlannerDB.tasks)
        resetEditor(ui)
        ui:Render()
    end)

    clearButton:SetScript("OnClick", function()
        resetEditor(ui)
    end)

    inputTitle:SetScript("OnEnterPressed", function()
        saveButton:Click()
    end)

    function ui:Render()
        local boardKey = self:GetSelectedBoardKey()
        updateButtonLabel(boardButton, "Board", boardKey, getBoardDisplayName)
        updateButtonLabel(filterButton, "Filter", TODOPlannerDB.settings.filterCategory or "All")
        updateButtonLabel(categoryButton, "Category", TASK_CATEGORIES[self.selectedCategoryIndex])
        updateButtonLabel(locationButton, "Location", self.selectedLocationKey or boardKey, getBoardDisplayName)

        for status, column in pairs(self.columns) do
            for _, oldCard in ipairs(column.cards) do
                oldCard:Hide()
                oldCard:SetParent(nil)
            end
            wipe(column.cards)

            local tasks = getTasksForStatus(status, boardKey)
            local y = -4
            for _, task in ipairs(tasks) do
                local card = createTaskCard(column.content, task, status, self)
                card:SetPoint("TOPLEFT", 4, y)
                y = y - 98
                column.cards[#column.cards + 1] = card
            end

            local minHeight = column.scroll:GetHeight()
            local contentHeight = math.max(minHeight, math.abs(y) + 12)
            column.content:SetSize(292, contentHeight)
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
        if boardKey == GLOBAL_BOARD_KEY or seenCharacters[boardKey] then
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
        task.status = normalizeStatus(task.status)
        task.category = indexOf(TASK_CATEGORIES, task.category) and task.category or "Other"
        task.title = task.title or "Untitled"
        task.notes = task.notes or ""
        task.createdAt = task.createdAt or time()
        task.updatedAt = task.updatedAt or task.createdAt

        if task.boardKey ~= GLOBAL_BOARD_KEY then
            trackCharacter(task.boardKey)
        end

        if type(task.statusByBoard) == "table" then
            local cleanedStatusByBoard = {}
            for boardKey, status in pairs(task.statusByBoard) do
                local normalizedBoardKey = normalizeBoardKey(boardKey)
                if normalizedBoardKey ~= GLOBAL_BOARD_KEY then
                    cleanedStatusByBoard[normalizedBoardKey] = normalizeStatus(status)
                    trackCharacter(normalizedBoardKey)
                end
            end

            task.statusByBoard = next(cleanedStatusByBoard) and cleanedStatusByBoard or nil
        else
            task.statusByBoard = nil
        end
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

    if selectedBoard ~= GLOBAL_BOARD_KEY and not seenCharacters[selectedBoard] then
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
