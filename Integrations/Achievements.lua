local _, TDP = ...

local Utils = TDP.Utils
local Boards = TDP.Boards
local Tasks = TDP.Tasks
local Widgets = TDP.Widgets

local AchievementIntegration = {}
AchievementIntegration.__index = AchievementIntegration

function AchievementIntegration:New(addon)
    return setmetatable({
        addon = addon,
        initialized = false,
        urlDialog = nil,
    }, self)
end

function AchievementIntegration:GetInfoSafe(achievementId)
    if type(GetAchievementInfo) ~= "function" then
        return nil
    end

    local ok, id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy =
        pcall(GetAchievementInfo, achievementId)
    if not ok or not id then
        return nil
    end

    return {
        id = id,
        name = name,
        points = points,
        completed = completed,
        month = month,
        day = day,
        year = year,
        description = description,
        flags = flags,
        icon = icon,
        rewardText = rewardText,
        isGuild = isGuild,
        wasEarnedByMe = wasEarnedByMe,
        earnedBy = earnedBy,
    }
end

function AchievementIntegration:GetLinkSafe(achievementId)
    if type(GetAchievementLink) ~= "function" then
        return nil
    end

    local ok, link = pcall(GetAchievementLink, achievementId)
    if ok then
        return link
    end

    return nil
end

function AchievementIntegration:GetTaskAchievementId(task)
    if not task then
        return nil
    end

    if task.sourceType == "achievement" then
        return tonumber(task.sourceId)
    end

    local notes = task.notes or ""
    return tonumber(notes:match("Achievement ID:%s*(%d+)"))
end

function AchievementIntegration:GetWowheadUrl(achievementId)
    return "https://www.wowhead.com/achievement=" .. tostring(achievementId)
end

function AchievementIntegration:GetClipboardText()
    local clipboardTargets = {}
    if C_Clipboard then
        clipboardTargets[#clipboardTargets + 1] = C_Clipboard
    end
    if ClipboardUtil then
        clipboardTargets[#clipboardTargets + 1] = ClipboardUtil
    end

    local methodNames = {
        "GetClipboard",
        "GetText",
        "GetClipboardText",
    }

    for _, target in ipairs(clipboardTargets) do
        if type(target) == "table" then
            for _, methodName in ipairs(methodNames) do
                local ok, value = Utils:CallMaybeMethod(target, target[methodName])
                if ok and type(value) == "string" then
                    return value
                end
            end
        end
    end

    for _, globalName in ipairs(methodNames) do
        local ok, value = Utils:CallMaybeMethod(nil, _G[globalName])
        if ok and type(value) == "string" then
            return value
        end
    end

    return nil
end

function AchievementIntegration:CopyTextToClipboard(text)
    local clipboardTargets = {}
    if C_Clipboard then
        clipboardTargets[#clipboardTargets + 1] = C_Clipboard
    end
    if ClipboardUtil then
        clipboardTargets[#clipboardTargets + 1] = ClipboardUtil
    end

    local methodNames = {
        "SetClipboard",
        "SetText",
        "SetClipboardText",
        "CopyText",
        "CopyToClipboard",
    }

    for _, target in ipairs(clipboardTargets) do
        if type(target) == "table" then
            for _, methodName in ipairs(methodNames) do
                local ok, result = Utils:CallMaybeMethod(target, target[methodName], text)
                if ok and result ~= false and self:GetClipboardText() == text then
                    return true
                end
            end
        end
    end

    for _, globalName in ipairs(methodNames) do
        local ok, result = Utils:CallMaybeMethod(nil, _G[globalName], text)
        if ok and result ~= false and self:GetClipboardText() == text then
            return true
        end
    end

    return false
end

function AchievementIntegration:TryOpenExternalUrl(url)
    local openers = {}
    if C_StoreSecure and C_StoreSecure.OpenURL then
        openers[#openers + 1] = C_StoreSecure.OpenURL
    end
    if C_System and C_System.OpenURL then
        openers[#openers + 1] = C_System.OpenURL
    end

    for _, opener in ipairs(openers) do
        local ok, result = pcall(opener, url)
        if ok and result ~= false then
            return true
        end
    end

    return false
end

function AchievementIntegration:CreateUrlDialog()
    local frame = CreateFrame("Frame", "TODOPlannerUrlDialog", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(560, 145)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    local Theme = self.addon.Theme
    if Theme then
        local chrome = Theme:ApplyWindowChrome(frame, "Wowhead Link")
        frame.content = Widgets:CreatePanel(frame, "body", "goldBorder")
        frame.content:SetPoint("TOPLEFT", chrome, "TOPLEFT", 12, -54)
        frame.content:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", -12, 12)
    else
        Widgets:ApplyPanelBackdrop(frame, { 0.02, 0.02, 0.03, 0.98 }, { 1, 1, 1, 0.10 })

        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("Wowhead Link")

        local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -6, -6)
        frame.content = frame
    end

    local content = frame.content
    local label = content:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    label:SetPoint("TOPLEFT", 12, -12)
    label:SetText("Press Ctrl+C to copy the selected link.")

    local urlEditBox = Widgets:CreateEditBox(content, 500, 24)
    urlEditBox:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -8)
    urlEditBox:SetPoint("RIGHT", content, "RIGHT", -12, 0)
    urlEditBox:SetScript("OnEditFocusGained", function(target)
        Widgets:ApplyPanelBackdrop(target, "inputFocus", "inputBorderFocus")
        target:HighlightText()
    end)
    urlEditBox:SetScript("OnMouseUp", function(target)
        target:SetFocus()
        target:HighlightText()
    end)
    urlEditBox:SetScript("OnEscapePressed", function(target)
        target:ClearFocus()
        frame:Hide()
    end)
    frame.urlEditBox = urlEditBox

    if Theme then
        Theme:RegisterSpecialFrame("TODOPlannerUrlDialog")
    end

    frame:Hide()
    return frame
end

function AchievementIntegration:ShowCopyUrlDialog(url)
    if not self.urlDialog then
        self.urlDialog = self:CreateUrlDialog()
    end

    self.urlDialog.urlEditBox:SetText(url or "")
    self.urlDialog:ClearAllPoints()
    self.urlDialog:SetPoint("CENTER")
    self.urlDialog:Show()
    self.urlDialog.urlEditBox:SetFocus()
    self.urlDialog.urlEditBox:HighlightText()

    local Theme = self.addon.Theme
    if Theme then
        Theme:BringToFront(self.urlDialog)
    end
end

function AchievementIntegration:CopyWowheadAchievementUrl(achievementId)
    local url = self:GetWowheadUrl(achievementId)
    if self:CopyTextToClipboard(url) then
        Utils:Msg("Copied Wowhead link to clipboard.")
    else
        self:ShowCopyUrlDialog(url)
    end
end

function AchievementIntegration:OpenAchievement(achievementId)
    achievementId = tonumber(achievementId)
    if not achievementId then
        return false
    end

    if C_AddOns and type(C_AddOns.IsAddOnLoaded) == "function" and type(C_AddOns.LoadAddOn) == "function" then
        local ok, loaded = pcall(C_AddOns.IsAddOnLoaded, "Blizzard_AchievementUI")
        if ok and not loaded then
            pcall(C_AddOns.LoadAddOn, "Blizzard_AchievementUI")
        end
    end

    if type(KrowiAF_SelectAchievementFromID) == "function" then
        local ok = pcall(KrowiAF_SelectAchievementFromID, achievementId)
        if ok then
            return true
        end
    end

    if type(AchievementFrame_ToggleAchievementFrame) == "function"
        and AchievementFrame
        and not AchievementFrame:IsShown() then
        pcall(AchievementFrame_ToggleAchievementFrame)
    elseif AchievementFrame and not AchievementFrame:IsShown() then
        if type(ShowUIPanel) == "function" then
            pcall(ShowUIPanel, AchievementFrame)
        else
            AchievementFrame:Show()
        end
    end

    if type(AchievementFrame_SelectAchievement) == "function" then
        local ok = pcall(AchievementFrame_SelectAchievement, achievementId)
        return ok
    end

    return false
end

function AchievementIntegration:SafeGetAchievementCategory(achievementId)
    if type(GetAchievementCategory) ~= "function" then
        return nil
    end

    local ok, categoryId = pcall(GetAchievementCategory, achievementId)
    if ok then
        return categoryId
    end

    return nil
end

function AchievementIntegration:SafeGetCategoryInfo(categoryId)
    if type(GetCategoryInfo) ~= "function" or not categoryId then
        return nil, nil
    end

    local ok, name, parentId = pcall(GetCategoryInfo, categoryId)
    if ok then
        return name, parentId
    end

    return nil, nil
end

function AchievementIntegration:GetCategoryPath(achievementId)
    local categoryId = self:SafeGetAchievementCategory(achievementId)
    if not categoryId then
        return "Unknown"
    end

    local parts = {}
    local safety = 0
    while categoryId and safety < 10 do
        safety = safety + 1
        local name, parentId = self:SafeGetCategoryInfo(categoryId)
        if not name or name == "" then
            parts[#parts + 1] = "#" .. tostring(categoryId)
            break
        end

        table.insert(parts, 1, name)
        if not parentId or parentId == -1 or parentId == categoryId then
            break
        end
        categoryId = parentId
    end

    return table.concat(parts, " / ")
end

function AchievementIntegration:SafeGetNumCriteria(achievementId)
    if type(GetAchievementNumCriteria) ~= "function" then
        return 0
    end

    local ok, numCriteria = pcall(GetAchievementNumCriteria, achievementId)
    if ok and type(numCriteria) == "number" then
        return numCriteria
    end

    return 0
end

function AchievementIntegration:SafeGetCriteriaInfo(achievementId, index)
    if type(GetAchievementCriteriaInfo) ~= "function" then
        return nil
    end

    local ok, criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetId, quantityString, criteriaId, eligible, duration, elapsed =
        pcall(GetAchievementCriteriaInfo, achievementId, index)
    if not ok then
        return nil
    end

    return {
        criteriaString = criteriaString,
        criteriaType = criteriaType,
        completed = completed,
        quantity = quantity,
        reqQuantity = reqQuantity,
        charName = charName,
        flags = flags,
        assetId = assetId,
        quantityString = quantityString,
        criteriaId = criteriaId,
        eligible = eligible,
        duration = duration,
        elapsed = elapsed,
    }
end

function AchievementIntegration:GetProgressSummary(achievementId)
    local numCriteria = self:SafeGetNumCriteria(achievementId)
    if numCriteria == 0 then
        local info = self:GetInfoSafe(achievementId)
        if info and info.completed then
            return "Completed"
        end
        return "No criteria"
    end

    local completed = 0
    for index = 1, numCriteria do
        local criteria = self:SafeGetCriteriaInfo(achievementId, index)
        if criteria and criteria.completed then
            completed = completed + 1
        end
    end

    return string.format("%d/%d criteria", completed, numCriteria)
end

function AchievementIntegration:ParseProgressRatio(progressText)
    if type(progressText) ~= "string" then
        return nil, nil
    end

    local current, maximum = progressText:match("(%d+)%s*/%s*(%d+)")
    current = tonumber(current)
    maximum = tonumber(maximum)
    if not current or not maximum or maximum <= 1 then
        return nil, nil
    end

    return current, maximum
end

function AchievementIntegration:IsSubAchievementCriteria(criteria)
    return criteria
        and CRITERIA_TYPE_ACHIEVEMENT
        and criteria.criteriaType == CRITERIA_TYPE_ACHIEVEMENT
        and criteria.assetId
end

function AchievementIntegration:GetAchievementCriteriaRows(achievementId)
    local rows = {}
    local numCriteria = self:SafeGetNumCriteria(achievementId)

    for index = 1, numCriteria do
        local criteria = self:SafeGetCriteriaInfo(achievementId, index)
        if criteria then
            if self:IsSubAchievementCriteria(criteria) then
                local subAchievementId = tonumber(criteria.assetId)
                local subInfo = subAchievementId and self:GetInfoSafe(subAchievementId)
                local isCompleted = (subInfo and subInfo.completed == true) or criteria.completed == true
                local progress = subAchievementId and self:GetProgressSummary(subAchievementId) or ""
                local progressValue, progressMax = self:ParseProgressRatio(progress)

                rows[#rows + 1] = {
                    id = subAchievementId,
                    order = index,
                    name = subInfo and subInfo.name or criteria.criteriaString or "Unknown achievement",
                    completed = isCompleted,
                    progress = progress,
                    progressValue = progressValue,
                    progressMax = progressMax,
                    canOpen = subAchievementId ~= nil,
                }
            else
                local progress = ""
                if criteria.quantityString and criteria.quantityString ~= "" then
                    progress = criteria.quantityString
                elseif criteria.reqQuantity and criteria.reqQuantity > 0 then
                    progress = string.format("%s/%s", tostring(criteria.quantity or 0), tostring(criteria.reqQuantity))
                end
                if progress == "0" or progress == "1" then
                    progress = ""
                end
                local progressValue, progressMax = self:ParseProgressRatio(progress)

                rows[#rows + 1] = {
                    order = index,
                    name = criteria.criteriaString or ("Criteria " .. tostring(index)),
                    completed = criteria.completed == true,
                    progress = progress,
                    progressValue = progressValue,
                    progressMax = progressMax,
                    canOpen = false,
                }
            end
        end
    end

    table.sort(rows, function(left, right)
        if left.completed ~= right.completed then
            return left.completed == false
        end
        return (left.order or 0) < (right.order or 0)
    end)

    return rows
end

function AchievementIntegration:IsAchievementComplete(achievementId)
    achievementId = tonumber(achievementId)
    if not achievementId then
        return false
    end

    local info = self:GetInfoSafe(achievementId)
    if info and info.completed == true then
        return true
    end

    local rows = self:GetAchievementCriteriaRows(achievementId)
    if #rows == 0 then
        return false
    end

    for _, row in ipairs(rows) do
        if row.completed ~= true then
            return false
        end
    end

    return true
end

function AchievementIntegration:AutoCompleteTask(task)
    if not task or Tasks:IsArchived(task) or Tasks:GetStatus(task) == "DONE" then
        return false
    end

    local achievementId = self:GetTaskAchievementId(task)
    if not achievementId or not self:IsAchievementComplete(achievementId) then
        return false
    end

    Tasks:SetStatus(task, "DONE")
    return true
end

function AchievementIntegration:AutoCompleteTasks()
    if type(TODOPlannerDB) ~= "table" or type(TODOPlannerDB.tasks) ~= "table" then
        return false
    end

    local changed = false
    for _, task in ipairs(TODOPlannerDB.tasks) do
        if self:AutoCompleteTask(task) then
            changed = true
        end
    end

    if changed then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end

    return changed
end

function AchievementIntegration:ScheduleAutoCompleteRefresh()
    if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
            if self:AutoCompleteTasks() and self.addon.ui then
                self.addon.ui:Render()
            end
        end)
    elseif self:AutoCompleteTasks() and self.addon.ui then
        self.addon.ui:Render()
    end
end

function AchievementIntegration:FormatDate(info)
    if not info or not info.completed then
        return "Not completed"
    end

    if info.month and info.day and info.year then
        return string.format("%04d-%02d-%02d", info.year, info.month, info.day)
    end

    return "Completed"
end

function AchievementIntegration:BuildSummaryFields(achievementId)
    achievementId = tonumber(achievementId)
    local info = achievementId and self:GetInfoSafe(achievementId)
    if not info then
        return nil
    end

    return {
        achievementStatus = self:FormatDate(info),
        progress = self:GetProgressSummary(achievementId),
        achievementCategory = self:GetCategoryPath(achievementId),
        guild = info.isGuild and "Yes" or nil,
        earnedByMe = info.wasEarnedByMe and "Yes" or "No",
        flags = tostring(info.flags or "Unknown"),
        earnedBy = info.earnedBy ~= "" and info.earnedBy or nil,
    }
end

function AchievementIntegration:AppendSeries(lines, achievementId)
    if type(GetPreviousAchievement) ~= "function" and type(GetNextAchievement) ~= "function" then
        return
    end

    local firstId = achievementId
    if type(GetPreviousAchievement) == "function" then
        local safety = 0
        while firstId and safety < 30 do
            safety = safety + 1
            local ok, previousId = pcall(GetPreviousAchievement, firstId)
            if not ok or not previousId then
                break
            end
            firstId = previousId
        end
    end

    if firstId == achievementId then
        local ok, nextId = type(GetNextAchievement) == "function" and pcall(GetNextAchievement, achievementId)
        if not ok or not nextId then
            return
        end
    end

    lines[#lines + 1] = ""
    lines[#lines + 1] = "Series"

    local currentId = firstId
    local index = 1
    local safety = 0
    while currentId and safety < 30 do
        safety = safety + 1
        local info = self:GetInfoSafe(currentId)
        if info then
            local currentMarker = currentId == achievementId and " <- current" or ""
            lines[#lines + 1] = string.format("%d. %s%s", index, info.name or "Unknown", currentMarker)
        end

        if type(GetNextAchievement) ~= "function" then
            break
        end

        local ok, nextId = pcall(GetNextAchievement, currentId)
        if not ok or not nextId then
            break
        end
        currentId = nextId
        index = index + 1
    end
end

function AchievementIntegration:BuildDetailText(task)
    local achievementId = self:GetTaskAchievementId(task)
    local info = achievementId and self:GetInfoSafe(achievementId)
    if not achievementId or not info then
        return Utils:Trim(task.notes or "") ~= "" and Utils:Trim(task.notes or "") or "Achievement data is not available yet."
    end

    local lines = {}

    if info.description and info.description ~= "" then
        lines[#lines + 1] = info.description
    end

    if info.rewardText and info.rewardText ~= "" then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Reward"
        lines[#lines + 1] = info.rewardText
    end

    if self:SafeGetNumCriteria(achievementId) == 0 then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Criteria"
        lines[#lines + 1] = "No visible criteria."
    end

    self:AppendSeries(lines, achievementId)

    local manualNotes = Utils:Trim(task.notes or "")
    if manualNotes ~= "" and not manualNotes:match("^Achievement ID:") then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Task Notes"
        lines[#lines + 1] = manualNotes
    end

    return table.concat(lines, "\n")
end

function AchievementIntegration:ExtractAchievementId(value)
    if type(value) ~= "table" then
        return nil
    end

    local achievementId = value.id
        or value.achievementID
        or value.achievementId
        or value.Id
        or value.key

    if not achievementId and type(value.Achievement) == "table" then
        achievementId = value.Achievement.Id or value.Achievement.id
    end

    return tonumber(achievementId)
end

function AchievementIntegration:GetAchievementIdFromRow(row)
    if not row then
        return nil
    end

    local achievementId = tonumber(row.id)
        or tonumber(row.achievementID)
        or tonumber(row.achievementId)

    if achievementId then
        return achievementId
    end

    if type(row.Achievement) == "table" then
        achievementId = tonumber(row.Achievement.Id or row.Achievement.id)
        if achievementId then
            return achievementId
        end
    end

    if row.GetElementData then
        achievementId = self:ExtractAchievementId(row:GetElementData())
        if achievementId then
            return achievementId
        end
    end

    achievementId = self:ExtractAchievementId(row.elementData)
    if achievementId then
        return achievementId
    end

    return tonumber(row.TODOPlannerAchievementId)
end

function AchievementIntegration:IsValidAchievementId(achievementId)
    if not achievementId then
        return false
    end

    if C_AchievementInfo and type(C_AchievementInfo.IsValidAchievement) == "function" then
        local ok, isValid = pcall(C_AchievementInfo.IsValidAchievement, achievementId)
        return ok and isValid == true
    end

    return true
end

function AchievementIntegration:FormatTaskNotes(info)
    local notes = {}

    local description = Utils:Trim(info.description)
    if description ~= "" then
        notes[#notes + 1] = description
    end

    local rewardText = Utils:Trim(info.rewardText)
    if rewardText ~= "" then
        notes[#notes + 1] = "Reward: " .. rewardText
    end

    return table.concat(notes, "\n")
end

function AchievementIntegration:CreateTask(achievementId)
    achievementId = tonumber(achievementId)
    if not self:IsValidAchievementId(achievementId) then
        Utils:Msg("Achievement information is not available.")
        return nil, false
    end

    local targetBoardKey = Tasks:GetSelectedCreationBoardKey()
    local existingTask = Tasks:FindBySource("achievement", achievementId, targetBoardKey)
    if existingTask then
        TODOPlannerDB.settings.selectedBoard = targetBoardKey
        if self.addon.ui then
            self.addon.ui:Render()
        end
        Utils:Msg("That achievement already has a task on " .. Boards:GetDisplayName(targetBoardKey) .. ".")
        return existingTask, false
    end

    local info = self:GetInfoSafe(achievementId)
    if not info or Utils:Trim(info.name) == "" then
        Utils:Msg("Achievement information is not available yet.")
        return nil, false
    end

    local task = Tasks:CreateOnSelectedBoard({
        title = "Achievement: " .. info.name,
        notes = self:FormatTaskNotes(info),
        category = "Achievements",
        status = "TODO",
        sourceType = "achievement",
        sourceId = achievementId,
    })
    self:AutoCompleteTask(task)
    Tasks:SortStable(TODOPlannerDB.tasks)

    if self.addon.ui then
        self.addon.ui:Render()
    end
    self:RefreshButtons()

    Utils:Msg("Added achievement task: " .. info.name)
    return task, true
end

function AchievementIntegration:AnchorTaskButton(row)
    local button = row and row.TODOPlannerTaskButton
    if not button then
        return
    end

    button:ClearAllPoints()
    button:SetFrameLevel((row:GetFrameLevel() or 0) + 50)
    local rowHeight = row:GetHeight() or 0
    local buttonHeight = button:GetHeight() or 22
    local yOffset = -8
    if rowHeight > buttonHeight + 16 then
        yOffset = -(rowHeight - buttonHeight - 8)
    end

    button:SetPoint("TOPRIGHT", row, "TOPRIGHT", -10, yOffset)
end

function AchievementIntegration:UpdateTaskButton(row)
    local button = row and row.TODOPlannerTaskButton
    if not button then
        return
    end

    local achievementId = self:GetAchievementIdFromRow(row)
    if not self:IsValidAchievementId(achievementId) then
        button.achievementId = nil
        button:Hide()
        return
    end

    row.TODOPlannerAchievementId = achievementId
    button.achievementId = achievementId

    local targetBoardKey = Tasks:GetSelectedCreationBoardKey()
    local existingTask = Tasks:FindBySource("achievement", achievementId, targetBoardKey)
    button.existingTaskId = existingTask and existingTask.id or nil
    button:SetText(existingTask and "Added" or "Add Task")
    button.targetBoardName = Boards:GetDisplayName(targetBoardKey)
    button:Show()
    self:AnchorTaskButton(row)
end

function AchievementIntegration:ScheduleTaskButtonUpdate(row)
    if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
            if row and row:IsShown() then
                self:UpdateTaskButton(row)
            end
        end)
    else
        self:UpdateTaskButton(row)
    end
end

function AchievementIntegration:DecorateRow(row, elementData)
    if not row then
        return
    end

    local achievementId = self:ExtractAchievementId(elementData)
    if achievementId then
        row.TODOPlannerAchievementId = achievementId
    end

    if not row.TODOPlannerTaskButton then
        local button = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        button:SetSize(82, 22)
        button:SetFrameLevel((row:GetFrameLevel() or 0) + 20)
        button:RegisterForClicks("LeftButtonUp")
        button:SetScript("OnClick", function(target)
            self:CreateTask(target.achievementId or self:GetAchievementIdFromRow(target:GetParent()))
            self:UpdateTaskButton(target:GetParent())
        end)
        button:SetScript("OnEnter", function(target)
            GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
            if target.existingTaskId then
                GameTooltip:SetText("TODO Planner")
                GameTooltip:AddLine("Task already exists on " .. (target.targetBoardName or "this board") .. ".", 1, 1, 1, true)
            else
                GameTooltip:SetText("Add to TODO Planner")
                GameTooltip:AddLine("Create a task on " .. (target.targetBoardName or "the selected board") .. ".", 1, 1, 1, true)
            end
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        row.TODOPlannerTaskButton = button
    end

    if not row.TODOPlannerTaskHooksInstalled then
        row.TODOPlannerTaskHooksInstalled = true
        row:HookScript("OnShow", function(target)
            self:ScheduleTaskButtonUpdate(target)
        end)
        row:HookScript("OnSizeChanged", function(target)
            self:AnchorTaskButton(target)
        end)

        if type(row.Init) == "function" then
            hooksecurefunc(row, "Init", function(target)
                self:ScheduleTaskButtonUpdate(target)
            end)
        end
        if type(row.Update) == "function" then
            hooksecurefunc(row, "Update", function(target)
                self:ScheduleTaskButtonUpdate(target)
            end)
        end
    end

    self:ScheduleTaskButtonUpdate(row)
end

function AchievementIntegration:DecorateScrollBox(scrollBox)
    if not scrollBox then
        return
    end

    if scrollBox.ForEachFrame then
        scrollBox:ForEachFrame(function(row, elementData)
            self:DecorateRow(row, elementData)
        end)
    end

    if not scrollBox.TODOPlannerTaskDecorated then
        scrollBox.TODOPlannerTaskDecorated = true
        scrollBox:HookScript("OnShow", function(target)
            if target.ForEachFrame then
                target:ForEachFrame(function(row, elementData)
                    self:DecorateRow(row, elementData)
                end)
            end
        end)

        if scrollBox.RegisterCallback and BaseScrollBoxEvents and BaseScrollBoxEvents.OnLayout then
            scrollBox:RegisterCallback(BaseScrollBoxEvents.OnLayout, function(target)
                if target.ForEachFrame then
                    target:ForEachFrame(function(row, elementData)
                        self:DecorateRow(row, elementData)
                    end)
                end
            end, scrollBox)
        end
    end

    local view = scrollBox.GetView and scrollBox:GetView()
    if view
        and view ~= scrollBox.TODOPlannerTaskDecoratedView
        and view.RegisterCallback
        and ScrollBoxListViewMixin
        and ScrollBoxListViewMixin.Event
        and ScrollBoxListViewMixin.Event.OnAcquiredFrame then
        scrollBox.TODOPlannerTaskDecoratedView = view
        view:RegisterCallback(ScrollBoxListViewMixin.Event.OnAcquiredFrame, function(_, frame, elementData)
            self:DecorateRow(frame, elementData)
        end, self.addon.EventFrame)
    end
end

function AchievementIntegration:CollectScrollBoxes()
    local scrollBoxes = {}
    local seen = {}

    local function add(scrollBox)
        if scrollBox and not seen[scrollBox] then
            seen[scrollBox] = true
            scrollBoxes[#scrollBoxes + 1] = scrollBox
        end
    end

    local function addFrameScrollBox(frame)
        if frame then
            add(frame.ScrollBox)
        end
    end

    if AchievementFrameAchievements then
        add(AchievementFrameAchievements.ScrollBox)
    end

    if AchievementFrame and AchievementFrame.SearchResults then
        add(AchievementFrame.SearchResults.ScrollBox)
        if AchievementFrame.SearchResults.ScrollContainer then
            add(AchievementFrame.SearchResults.ScrollContainer.ScrollBox)
        end
    end

    addFrameScrollBox(KrowiAF_AchievementsFrame)
    if KrowiAF_SummaryFrame then
        addFrameScrollBox(KrowiAF_SummaryFrame.AchievementsFrame)
    end

    return scrollBoxes
end

function AchievementIntegration:InstallKrowiRefreshHook(frame, updateHooks)
    if not frame or frame.TODOPlannerRefreshHooksInstalled then
        return
    end

    frame.TODOPlannerRefreshHooksInstalled = true
    frame:HookScript("OnShow", function()
        self:ScheduleRefresh()
    end)

    for _, hookName in ipairs(updateHooks) do
        if type(frame[hookName]) == "function" then
            hooksecurefunc(frame, hookName, function()
                self:ScheduleRefresh()
            end)
        end
    end
end

function AchievementIntegration:InstallKrowiHooks()
    self:InstallKrowiRefreshHook(KrowiAF_AchievementsFrame, {
        "Update",
        "ForceUpdate",
    })

    if KrowiAF_SummaryFrame then
        self:InstallKrowiRefreshHook(KrowiAF_SummaryFrame, {
            "Update",
            "UpdateAchievementsOnNextShow",
        })
        self:InstallKrowiRefreshHook(KrowiAF_SummaryFrame.AchievementsFrame, {
            "Update",
        })
    end
end

function AchievementIntegration:RefreshButtons()
    self:InstallKrowiHooks()

    for _, scrollBox in ipairs(self:CollectScrollBoxes()) do
        self:DecorateScrollBox(scrollBox)
        if scrollBox.ForEachFrame then
            scrollBox:ForEachFrame(function(row)
                self:UpdateTaskButton(row)
            end)
        end
    end
end

function AchievementIntegration:ScheduleRefresh()
    if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
            self:RefreshButtons()
        end)
    else
        self:RefreshButtons()
    end
end

function AchievementIntegration:Init()
    if not AchievementFrame then
        return
    end

    if not self.initialized then
        self.initialized = true
        AchievementFrame:HookScript("OnShow", function()
            self:ScheduleRefresh()
        end)

        local updateHooks = {
            "AchievementFrame_ForceUpdate",
            "AchievementFrameAchievements_Update",
            "AchievementFrame_SelectAchievement",
            "AchievementFrame_UpdateTabs",
        }

        for _, hookName in ipairs(updateHooks) do
            if type(_G[hookName]) == "function" then
                hooksecurefunc(hookName, function()
                    self:ScheduleRefresh()
                end)
            end
        end
    end

    self:ScheduleRefresh()
end

TDP.Achievements = AchievementIntegration:New(TDP)
