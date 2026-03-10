local ADDON_NAME = ...

local TDP = CreateFrame("Frame")

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
    version = 1,
    nextTaskId = 1,
    tasks = {},
    settings = {
        filterCategory = "All",
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
        local aStatus = a.status or "TODO"
        local bStatus = b.status or "TODO"
        if aStatus ~= bStatus then
            return aStatus < bStatus
        end
        return (a.id or 0) < (b.id or 0)
    end)
end

local function getTasksForStatus(status)
    local filtered = {}
    local filterCategory = TODOPlannerDB.settings.filterCategory or "All"

    for _, task in ipairs(TODOPlannerDB.tasks) do
        if task.status == status then
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

local function getDateStamp(timestamp)
    if not timestamp then
        return ""
    end
    return date("%Y-%m-%d", timestamp)
end

local function indexOf(list, value)
    for i, item in ipairs(list) do
        if item == value then
            return i
        end
    end
    return nil
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

local function resetEditor(ui)
    ui.editingTaskId = nil
    ui.inputTitle:SetText("")
    ui.inputNotes:SetText("")
    ui.selectedCategoryIndex = 1
    ui.categoryButton:SetText("Category: " .. TASK_CATEGORIES[ui.selectedCategoryIndex])
    ui.saveButton:SetText("Add Task")
end

local function loadEditor(ui, task)
    ui.editingTaskId = task.id
    ui.inputTitle:SetText(task.title or "")
    ui.inputNotes:SetText(task.notes or "")

    local categoryIndex = indexOf(TASK_CATEGORIES, task.category or "") or 1
    ui.selectedCategoryIndex = categoryIndex
    ui.categoryButton:SetText("Category: " .. TASK_CATEGORIES[ui.selectedCategoryIndex])
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
    local notePreview = notes ~= "" and (" | " .. notes:sub(1, 45)) or ""
    if #notes > 45 then
        notePreview = notePreview .. "..."
    end

    meta:SetText(string.format("%s%s", task.category or "Other", notePreview))

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

    local editBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    editBtn:SetSize(38, 20)
    editBtn:SetPoint("BOTTOMRIGHT", -52, 10)
    editBtn:SetText("Edit")

    local deleteBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    deleteBtn:SetSize(40, 20)
    deleteBtn:SetPoint("LEFT", editBtn, "RIGHT", 4, 0)
    deleteBtn:SetText("Del")

    local statusIndex = indexOf(STATUS_ORDER, status) or 1
    leftBtn:SetEnabled(statusIndex > 1)
    rightBtn:SetEnabled(statusIndex < #STATUS_ORDER)

    leftBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask then
            return
        end
        dbTask.status = moveStatus(dbTask.status, -1)
        dbTask.updatedAt = time()
        ui:Render()
    end)

    rightBtn:SetScript("OnClick", function()
        local dbTask = findTaskById(task.id)
        if not dbTask then
            return
        end
        dbTask.status = moveStatus(dbTask.status, 1)
        dbTask.updatedAt = time()
        ui:Render()
    end)

    editBtn:SetScript("OnClick", function()
        loadEditor(ui, task)
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

local function createColumn(parent, titleText, offsetX)
    local column = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    column:SetSize(335, 470)
    column:SetPoint("TOPLEFT", offsetX, -130)
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
    subtitle:SetText("Account-wide Kanban for achievements, mounts, collections, reputation, and more")

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -6, -6)

    local filterButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    filterButton:SetSize(210, 22)
    filterButton:SetPoint("TOPLEFT", 16, -52)

    local inputTitle = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    inputTitle:SetSize(250, 20)
    inputTitle:SetPoint("TOPLEFT", filterButton, "BOTTOMLEFT", 0, -14)
    inputTitle:SetAutoFocus(false)
    inputTitle:SetMaxLetters(120)

    local titleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    titleLabel:SetPoint("BOTTOMLEFT", inputTitle, "TOPLEFT", 4, 4)
    titleLabel:SetText("Task")

    local inputNotes = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    inputNotes:SetSize(360, 20)
    inputNotes:SetPoint("LEFT", inputTitle, "RIGHT", 8, 0)
    inputNotes:SetAutoFocus(false)
    inputNotes:SetMaxLetters(160)

    local notesLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    notesLabel:SetPoint("BOTTOMLEFT", inputNotes, "TOPLEFT", 4, 4)
    notesLabel:SetText("Notes")

    local categoryButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    categoryButton:SetSize(160, 22)
    categoryButton:SetPoint("LEFT", inputNotes, "RIGHT", 8, 0)

    local saveButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    saveButton:SetSize(95, 22)
    saveButton:SetPoint("LEFT", categoryButton, "RIGHT", 8, 0)
    saveButton:SetText("Add Task")

    local clearButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    clearButton:SetSize(95, 22)
    clearButton:SetPoint("LEFT", saveButton, "RIGHT", 6, 0)
    clearButton:SetText("Clear")

    local ui = {
        frame = frame,
        filterButton = filterButton,
        inputTitle = inputTitle,
        inputNotes = inputNotes,
        categoryButton = categoryButton,
        saveButton = saveButton,
        clearButton = clearButton,
        selectedCategoryIndex = 1,
        editingTaskId = nil,
    }

    local colTodo = createColumn(frame, STATUS_LABELS.TODO, 16)
    local colDoing = createColumn(frame, STATUS_LABELS.DOING, 372)
    local colDone = createColumn(frame, STATUS_LABELS.DONE, 728)

    ui.columns = {
        TODO = colTodo,
        DOING = colDoing,
        DONE = colDone,
    }

    local function cycleFilter(delta)
        local current = TODOPlannerDB.settings.filterCategory or "All"
        local index = indexOf(FILTER_CATEGORIES, current) or 1
        index = index + delta
        if index < 1 then
            index = #FILTER_CATEGORIES
        elseif index > #FILTER_CATEGORIES then
            index = 1
        end
        TODOPlannerDB.settings.filterCategory = FILTER_CATEGORIES[index]
        filterButton:SetText("Filter: " .. TODOPlannerDB.settings.filterCategory)
        ui:Render()
    end

    local function cycleTaskCategory(delta)
        ui.selectedCategoryIndex = ui.selectedCategoryIndex + delta
        if ui.selectedCategoryIndex < 1 then
            ui.selectedCategoryIndex = #TASK_CATEGORIES
        elseif ui.selectedCategoryIndex > #TASK_CATEGORIES then
            ui.selectedCategoryIndex = 1
        end
        categoryButton:SetText("Category: " .. TASK_CATEGORIES[ui.selectedCategoryIndex])
    end

    filterButton:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            cycleFilter(-1)
        else
            cycleFilter(1)
        end
    end)
    filterButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    categoryButton:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            cycleTaskCategory(-1)
        else
            cycleTaskCategory(1)
        end
    end)
    categoryButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    saveButton:SetScript("OnClick", function()
        local titleText = trim(inputTitle:GetText())
        local notesText = trim(inputNotes:GetText())
        if titleText == "" then
            msg("Task title is required.")
            return
        end

        local category = TASK_CATEGORIES[ui.selectedCategoryIndex]
        if ui.editingTaskId then
            local task = findTaskById(ui.editingTaskId)
            if task then
                task.title = titleText
                task.notes = notesText
                task.category = category
                task.updatedAt = time()
            end
        else
            local newTask = {
                id = TODOPlannerDB.nextTaskId,
                title = titleText,
                notes = notesText,
                category = category,
                status = "TODO",
                createdAt = time(),
                updatedAt = time(),
            }
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
        filterButton:SetText("Filter: " .. (TODOPlannerDB.settings.filterCategory or "All"))

        for status, column in pairs(self.columns) do
            for _, oldCard in ipairs(column.cards) do
                oldCard:Hide()
                oldCard:SetParent(nil)
            end
            wipe(column.cards)

            local tasks = getTasksForStatus(status)
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
    filterButton:SetText("Filter: " .. (TODOPlannerDB.settings.filterCategory or "All"))
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

    local highestId = 0
    for _, task in ipairs(TODOPlannerDB.tasks) do
        if type(task.id) == "number" and task.id > highestId then
            highestId = task.id
        end
        task.status = task.status or "TODO"
        task.category = task.category or "Other"
        task.title = task.title or "Untitled"
        task.notes = task.notes or ""
        task.createdAt = task.createdAt or time()
        task.updatedAt = task.updatedAt or task.createdAt
    end

    sortTasksStable(TODOPlannerDB.tasks)

    if type(TODOPlannerDB.nextTaskId) ~= "number" or TODOPlannerDB.nextTaskId <= highestId then
        TODOPlannerDB.nextTaskId = highestId + 1
    end
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
