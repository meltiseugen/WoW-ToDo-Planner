local _, TDP = ...

local C = TDP.Constants
local Utils = TDP.Utils
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

local TaskCardFactory = {}
TaskCardFactory.__index = TaskCardFactory

function TaskCardFactory:New()
    return setmetatable({}, self)
end

function TaskCardFactory:Create(parent, task, status, ui)
    local card = Widgets:CreatePanel(parent, "rowOdd", "goldBorder")
    card:SetSize(286, 104)
    Widgets:AddGoldTopAccent(card, 2, 0.18)

    local accent = card:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -1)
    accent:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 1)
    accent:SetWidth(3)
    Widgets:SetTextureColor(accent, C.STATUS_ACCENT_COLORS[status], { 1.0, 0.82, 0.18, 0.68 })

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
    meta:SetText(string.format("Category: %s", task.category or "Other"))

    local leftBtn = Widgets:CreateButton(card, 26, 22, "<", "subtle")
    leftBtn:SetPoint("BOTTOMLEFT", 12, 10)
    leftBtn.tooltipText = "Move left"

    local rightBtn = Widgets:CreateButton(card, 26, 22, ">", "subtle")
    rightBtn:SetPoint("LEFT", leftBtn, "RIGHT", 4, 0)
    rightBtn.tooltipText = "Move right"

    local openBtn = Widgets:CreateButton(card, 52, 22, "Open", "neutral")

    local archiveBtn = Widgets:CreateButton(card, 66, 22, "Archive", "subtle")
    archiveBtn.tooltipText = "Archive"

    local deleteBtn = Widgets:CreateButton(card, 62, 22, "Delete", "danger")
    deleteBtn:SetPoint("BOTTOMRIGHT", -12, 10)
    archiveBtn:SetPoint("RIGHT", deleteBtn, "LEFT", -4, 0)
    openBtn:SetPoint("RIGHT", archiveBtn, "LEFT", -4, 0)

    local statusIndex = Utils:IndexOf(C.STATUS_ORDER, status) or 1
    Widgets:SetButtonEnabled(leftBtn, statusIndex > 1)
    Widgets:SetButtonEnabled(rightBtn, statusIndex < #C.STATUS_ORDER)
    Widgets:SetButtonEnabled(archiveBtn, not Tasks:IsArchived(task))

    leftBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(task.id)
        if not dbTask then
            return
        end

        local currentStatus = Tasks:GetStatus(dbTask)
        Tasks:SetStatus(dbTask, Tasks:MoveStatus(currentStatus, -1))
        ui:Render()
    end)

    rightBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(task.id)
        if not dbTask then
            return
        end

        local currentStatus = Tasks:GetStatus(dbTask)
        Tasks:SetStatus(dbTask, Tasks:MoveStatus(currentStatus, 1))
        ui:Render()
    end)

    openBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(task.id)
        if not dbTask then
            return
        end

        ui:OpenTaskDetail(dbTask)
    end)

    archiveBtn:SetScript("OnClick", function()
        local dbTask = Tasks:FindById(task.id)
        if not dbTask or Tasks:IsArchived(dbTask) then
            return
        end

        ui:ConfirmArchiveTask(dbTask)
    end)

    deleteBtn:SetScript("OnClick", function()
        local taskRef = task
        StaticPopupDialogs["TODO_PLANNER_DELETE_TASK"] = {
            text = "Delete task: \"" .. (taskRef.title or "") .. "\"?",
            button1 = YES,
            button2 = NO,
            OnAccept = function()
                if Tasks:Delete(taskRef.id) then
                    if ui.detailWindow and ui.detailWindow.frame and ui.detailWindow.frame.taskId == taskRef.id then
                        ui.detailWindow.frame:Hide()
                    end
                    if ui.editingTaskId == taskRef.id then
                        ui:ResetEditor()
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

TDP.TaskCards = TaskCardFactory:New()
