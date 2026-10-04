local _, TDP = ...

local C = TDP.Constants
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

local TaskCardFactory = {}
TaskCardFactory.__index = TaskCardFactory

local CARD_WIDTH = 286
local MIN_CARD_HEIGHT = 104
local CARD_INSET = 12
local CARD_ACTION_GAP = 14
local CARD_ACTION_HEIGHT = 22
local OWNERSHIP_BADGE_HEIGHT = 20
local TITLE_WIDTH = CARD_WIDTH - (CARD_INSET * 2)
local TITLE_MEASURE_HEIGHT = 120

function TaskCardFactory:New()
    return setmetatable({}, self)
end

function TaskCardFactory:ShouldShowOwnershipBadge(ui)
    if not ui or type(ui.GetSelectedBoardKey) ~= "function" then
        return false
    end

    local selectedBoardKey = ui:GetSelectedBoardKey()
    return selectedBoardKey == C.ALL_BOARD_KEY
        or selectedBoardKey == C.ARCHIVED_BOARD_KEY
end

function TaskCardFactory:Create(parent, task, status, ui)
    local card = Widgets:CreatePanel(parent, "rowOdd", "goldBorder")
    card:SetSize(CARD_WIDTH, MIN_CARD_HEIGHT)
    card.taskId = task.id
    card.status = status
    card:EnableMouse(true)
    card:SetMovable(true)
    card:RegisterForDrag("LeftButton")
    card:SetScript("OnDragStart", function(target)
        ui:BeginTaskDrag(target)
    end)
    card:SetScript("OnDragStop", function(target)
        ui:EndTaskDrag(target)
    end)
    Widgets:AddGoldTopAccent(card, 2, 0.18)

    local accent = card:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -1)
    accent:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 1)
    accent:SetWidth(3)
    card.accent = accent

    local title = Widgets:CreateFontString(card, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", CARD_INSET, -10)
    title:SetPoint("TOPRIGHT", -CARD_INSET, -10)
    title:SetWidth(TITLE_WIDTH)
    title:SetJustifyH("LEFT")
    if title.SetWordWrap then
        title:SetWordWrap(true)
    end
    if title.SetNonSpaceWrap then
        title:SetNonSpaceWrap(true)
    end
    card.titleText = title

    local ownershipBadge = Widgets:CreateBadge(card)
    ownershipBadge:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    ownershipBadge:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -6)
    card.ownershipBadge = ownershipBadge

    local meta = Widgets:CreateFontString(card, "OVERLAY", "GameFontHighlightSmall")
    meta:SetPoint("TOPLEFT", ownershipBadge, "BOTTOMLEFT", 0, -5)
    meta:SetPoint("TOPRIGHT", ownershipBadge, "BOTTOMRIGHT", 0, -5)
    meta:SetJustifyH("LEFT")
    card.metaText = meta

    local dragHint = Widgets:CreateFontString(card, "OVERLAY", "GameFontDisableSmall")
    dragHint:SetPoint("LEFT", card, "BOTTOMLEFT", CARD_INSET, 21)
    dragHint:SetJustifyH("LEFT")
    dragHint:SetText("Drag & drop")
    card.dragHint = dragHint

    local openBtn = Widgets:CreateButton(card, 46, 22, "Open", "neutral")

    local archiveBtn = Widgets:CreateButton(card, 58, 22, "Archive", "subtle")
    archiveBtn.tooltipText = "Archive"

    local deleteBtn = Widgets:CreateButton(card, 52, 22, "Delete", "danger")
    deleteBtn:SetPoint("BOTTOMRIGHT", -12, 10)
    archiveBtn:SetPoint("RIGHT", deleteBtn, "LEFT", -4, 0)
    openBtn:SetPoint("RIGHT", archiveBtn, "LEFT", -4, 0)

    card.openBtn = openBtn
    card.archiveBtn = archiveBtn
    card.deleteBtn = deleteBtn

    openBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(card.taskId)
        if not dbTask then
            return
        end

        ui:OpenTaskDetail(dbTask)
    end)

    archiveBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(card.taskId)
        if not dbTask then
            return
        end

        if Tasks:IsArchived(dbTask) then
            ui:ConfirmRestoreTask(dbTask)
        else
            ui:ConfirmArchiveTask(dbTask)
        end
    end)

    deleteBtn:SetScript("OnClick", function()
        local taskRef = Tasks:FindById(card.taskId)
        if not taskRef then
            return
        end

        local taskId = taskRef.id
        local scopeText = Tasks:IsGlobalTask(taskRef)
            and "\nBoard: Global"
            or "\nBoard: " .. Tasks:GetOwnershipLabel(taskRef)
        StaticPopupDialogs["TODO_PLANNER_DELETE_TASK"] = {
            text = "Delete task: \"" .. (taskRef.title or "") .. "\"?" .. scopeText,
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                if Tasks:Delete(taskId) then
                    if ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame.taskId == taskId then
                        ui.detailWindow.frame:Hide()
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

    self:Update(card, task, status, ui)
    return card
end

function TaskCardFactory:Update(card, task, status, ui)
    card.taskId = task.id
    card.status = status

    local parentWidth = card:GetParent() and card:GetParent():GetWidth() or CARD_WIDTH + 8
    local cardWidth = math.max(252, parentWidth - 8)
    card:SetWidth(cardWidth)

    Widgets:SetTextureColor(card.accent, C.STATUS_ACCENT_COLORS[status], { 1.0, 0.82, 0.18, 0.68 })

    card.titleText:SetWidth(math.max(1, cardWidth - (CARD_INSET * 2)))
    if card.titleText.SetWordWrap then
        card.titleText:SetWordWrap(true)
    end
    if card.titleText.SetNonSpaceWrap then
        card.titleText:SetNonSpaceWrap(true)
    end
    if card.titleText.SetMaxLines then
        card.titleText:SetMaxLines(0)
    end
    card.titleText:SetHeight(TITLE_MEASURE_HEIGHT)
    card.titleText:SetText(task.title or "(Untitled)")
    card.titleText:SetHeight(math.max(14, math.ceil(card.titleText:GetStringHeight() or 14)))

    local boardKey = Tasks:GetBoardKey(task)
    local isGlobal = boardKey == C.GLOBAL_BOARD_KEY
    local showOwnershipBadge = self:ShouldShowOwnershipBadge(ui)
    if showOwnershipBadge then
        local ownershipText = isGlobal
            and "GLOBAL TASK"
            or "BOARD  |  " .. Boards:GetDisplayName(boardKey)
        Widgets:SetBadge(
            card.ownershipBadge,
            ownershipText,
            isGlobal and { 0.34, 0.23, 0.04, 0.94 } or { 0.02, 0.20, 0.24, 0.94 },
            isGlobal and { 1.0, 0.82, 0.18, 1.0 } or { 0.0, 0.82, 0.70, 1.0 },
            isGlobal and { 1.0, 0.90, 0.48, 1.0 } or { 0.62, 1.0, 0.92, 1.0 }
        )
        card.ownershipBadge:Show()
    else
        card.ownershipBadge:Hide()
    end

    card.metaText:ClearAllPoints()
    if showOwnershipBadge then
        card.metaText:SetPoint("TOPLEFT", card.ownershipBadge, "BOTTOMLEFT", 0, -5)
        card.metaText:SetPoint("TOPRIGHT", card.ownershipBadge, "BOTTOMRIGHT", 0, -5)
    else
        card.metaText:SetPoint("TOPLEFT", card.titleText, "BOTTOMLEFT", 0, -6)
        card.metaText:SetPoint("TOPRIGHT", card.titleText, "BOTTOMRIGHT", 0, -6)
    end
    card.metaText:SetText(string.format("Category: %s", task.category or "Other"))

    local contentBottom = 10
        + (card.titleText:GetHeight() or 14)
        + 6
        + (showOwnershipBadge and OWNERSHIP_BADGE_HEIGHT + 5 or 0)
        + math.ceil(card.metaText:GetStringHeight() or 12)
    local actionTop = 10 + CARD_ACTION_HEIGHT + CARD_ACTION_GAP
    card:SetHeight(math.max(MIN_CARD_HEIGHT, contentBottom + actionTop))

    local canDrag = ui
        and type(ui.CanReorderSelectedBoard) == "function"
        and ui:CanReorderSelectedBoard()
    if canDrag then
        card.dragHint:Show()
    else
        card.dragHint:Hide()
    end

    local isArchived = Tasks:IsArchived(task)
    card.archiveBtn:SetText(isArchived and "Restore" or "Archive")
    card.archiveBtn.tooltipText = isArchived and "Restore to active boards" or "Archive"
    if card.archiveBtn.SetPalette then
        card.archiveBtn:SetPalette(isArchived and "neutral" or "subtle")
    end
    Widgets:SetButtonEnabled(card.archiveBtn, true)
    card:SetAlpha(1)
    card:Show()
end

TDP.TaskCards = TaskCardFactory:New()
