local _, TDP = ...
local TaskDetailWindow = TDP.TaskDetailWindow
local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets
local Achievements = TDP.Achievements

function TaskDetailWindow:BuildActions(frame, body)
    local ui = self.ui
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

        ui:OpenTaskEdit(task)
    end)

    local archiveButton = Widgets:CreateButton(body, 86, 24, "Archive", "danger")
    archiveButton:SetPoint("RIGHT", editButton, "LEFT", -8, 0)
    archiveButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        if not task then
            frame:Hide()
            return
        end

        if Tasks:IsArchived(task) then
            ui:ConfirmRestoreTask(task)
        else
            ui:ConfirmArchiveTask(task)
        end
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

    local openAchievementButton = Widgets:CreateButton(body, 132, 24, "Open Achievement", "primary")
    openAchievementButton:SetPoint("LEFT", wowheadButton, "RIGHT", 8, 0)
    openAchievementButton:SetScript("OnClick", function()
        local task = Tasks:FindById(frame.taskId)
        local achievementId = Achievements:GetTaskAchievementId(task)
        if not achievementId then
            return
        end

        if not Achievements:OpenAchievement(achievementId) then
            Utils:Msg("Could not open that achievement in the achievement window.", "warnings")
        end
    end)
    frame.openAchievementButton = openAchievementButton

    local moveBoardButton = Widgets:CreateSelectorButton(body, 180, 24, "Move to Board")
    moveBoardButton:SetPoint("BOTTOMLEFT", 14, 16)
    moveBoardButton:SetScript("OnClick", function(owner)
        local task = Tasks:FindById(frame.taskId)
        if not task then
            return
        end

        local currentBoardKey = Tasks:GetBoardKey(task)
        local boardOptions = {}
        if currentBoardKey ~= C.GLOBAL_BOARD_KEY then
            boardOptions[#boardOptions + 1] = C.GLOBAL_BOARD_KEY
        end
        for _, boardKey in ipairs(Boards:GetCharacterBoardOptions()) do
            if boardKey ~= currentBoardKey then
                boardOptions[#boardOptions + 1] = boardKey
            end
        end

        if #boardOptions == 0 then
            Utils:Msg("No other boards are available.", "warnings")
            return
        end

        Widgets:ShowSingleSelectMenu(owner, boardOptions, nil, function(boardKey)
            return Boards:GetDisplayName(boardKey)
        end, function(targetBoardKey)
            local taskId = frame.taskId
            local sourceBoardKey = ui:GetSelectedBoardKey()
            local function moveTask()
                local currentTask = Tasks:FindById(taskId)
                if not currentTask then
                    frame:Hide()
                    return
                end

                local moved, errorText = Tasks:MoveToBoard(currentTask, targetBoardKey, sourceBoardKey)
                if not moved then
                    Utils:Msg(errorText or "Could not move that task.", "warnings")
                    return
                end

                TODOPlannerDB.settings.selectedBoard = targetBoardKey
                Tasks:SortStable(TODOPlannerDB.tasks)
                ui:Render()
                frame:UpdateTask(currentTask)
            end

            if currentBoardKey == C.GLOBAL_BOARD_KEY and targetBoardKey ~= C.GLOBAL_BOARD_KEY then
                StaticPopupDialogs["TODO_PLANNER_MOVE_GLOBAL_TASK"] = {
                    text = string.format(
                        "Move Global task \"%s\" to %s?\nIt will leave the Global board and appear on the selected character board.",
                        task.title or "",
                        Boards:GetDisplayName(targetBoardKey)
                    ),
                    button1 = YES,
                    button2 = NO,
                    OnAccept = moveTask,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    preferredIndex = 3,
                }
                StaticPopup_Show("TODO_PLANNER_MOVE_GLOBAL_TASK")
            else
                moveTask()
            end
        end)
    end)
    frame.moveBoardButton = moveBoardButton
end
