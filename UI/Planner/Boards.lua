local _, TDP = ...
local MainWindow = TDP.MainWindow
local C = TDP.Constants
local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks

function MainWindow:GetSelectedBoardKey()
    local boardKey = Boards:ResolveKnownBoardKey(TODOPlannerDB.settings.selectedBoard)
    if boardKey ~= C.GLOBAL_BOARD_KEY and not Boards:IsKnownBoard(boardKey) then
        boardKey = Boards:GetPlayerBoardKey()
        Boards:EnsureKnownCharacter(boardKey)
        TODOPlannerDB.settings.selectedBoard = boardKey
    end
    return boardKey
end

function MainWindow:CanReorderSelectedBoard()
    local boardKey = self:GetSelectedBoardKey()
    local filterCategory = TODOPlannerDB.settings.filterCategory or "All"
    return boardKey ~= C.ALL_BOARD_KEY
        and boardKey ~= C.ARCHIVED_BOARD_KEY
        and filterCategory == "All"
end

function MainWindow:OpenCreateBoardDialog()
    StaticPopupDialogs["TODO_PLANNER_CREATE_BOARD"] = {
        text = "Create board",
        button1 = "Create",
        button2 = CANCEL,
        hasEditBox = true,
        maxLetters = 64,
        OnShow = function(dialog)
            local editBox = dialog.editBox or dialog.EditBox
            if editBox then
                editBox:SetText("")
                editBox:SetFocus()
            end
        end,
        OnAccept = function(dialog)
            local editBox = dialog.editBox or dialog.EditBox
            local boardName = editBox and Utils:Trim(editBox:GetText()) or ""
            local boardKey, errorText = Boards:CreateBoard(boardName)
            if not boardKey then
                Utils:Msg(errorText or "Could not create board.")
                return
            end

            TODOPlannerDB.settings.selectedBoard = boardKey
            self:ResetEditor()
            self:Render()
        end,
        EditBoxOnEnterPressed = function(editBox)
            StaticPopup_OnClick(editBox:GetParent(), 1)
        end,
        EditBoxOnEscapePressed = function(editBox)
            editBox:GetParent():Hide()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_CREATE_BOARD")
end

function MainWindow:ConfirmDeleteSelectedBoard()
    local boardKey = self:GetSelectedBoardKey()
    local canDelete, reason = Boards:CanDeleteBoard(boardKey)
    if not canDelete then
        Utils:Msg(reason or "That board cannot be deleted.")
        return
    end

    local taskCount = Boards:CountBoardTasks(boardKey)
    local taskText = taskCount == 1 and "1 task will move to Global." or tostring(taskCount) .. " tasks will move to Global."

    StaticPopupDialogs["TODO_PLANNER_DELETE_BOARD"] = {
        text = "Delete board \"" .. Boards:GetDisplayName(boardKey) .. "\"?\n" .. taskText,
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            local ok, errorText, movedTasks = Boards:DeleteBoard(boardKey)
            if not ok then
                Utils:Msg(errorText or "Could not delete board.")
                return
            end

            Tasks:SortStable(TODOPlannerDB.tasks)
            self:ResetEditor()
            self:Render()
            Utils:Msg("Deleted board. Moved " .. tostring(movedTasks or 0) .. " task(s) to Global.")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("TODO_PLANNER_DELETE_BOARD")
end
