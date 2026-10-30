local _, TDP = ...
local CollectionMapWindow = TDP.CollectionMapWindow

function CollectionMapWindow:RefreshCriteriaProgress()
    local scanner = TDP.CollectionScanner
    local criteriaByAchievement = {}

    local function BuildCriteriaIndex(criteria)
        local criteriaByIndex = {}
        for fallbackIndex, criterion in ipairs(criteria or {}) do
            local criterionIndex = tonumber(criterion.index) or fallbackIndex
            criteriaByIndex[criterionIndex] = criterion
        end
        return criteriaByIndex
    end

    local function LoadAchievementCriteria(achievementId, fallbackCriteria)
        achievementId = tonumber(achievementId)
        if not achievementId or criteriaByAchievement[achievementId] then
            return fallbackCriteria
        end

        local criteria = fallbackCriteria
        if scanner and scanner.GetAchievementState then
            local state = scanner:GetAchievementState(achievementId)
            if state and type(state.criteria) == "table" and #state.criteria > 0 then
                criteria = state.criteria
            end
        end
        criteriaByAchievement[achievementId] = BuildCriteriaIndex(criteria)
        return criteria
    end

    local defaultAchievementId = tonumber(self.mapAchievementId)
    local fallbackCriteriaByIndex
    if defaultAchievementId then
        self.criteria = LoadAchievementCriteria(defaultAchievementId, self.criteria)
    else
        fallbackCriteriaByIndex = BuildCriteriaIndex(self.criteria)
    end

    for _, pinData in ipairs(self.pins or {}) do
        local achievementId = tonumber(pinData.criterionAchievementId)
        if achievementId and not criteriaByAchievement[achievementId] then
            LoadAchievementCriteria(achievementId)
        end
    end

    self.hasCriteriaPins = false
    for _, pinData in ipairs(self.pins or {}) do
        pinData.criterionCompleted = nil
        pinData.criterionText = nil
        local criterionIndex = tonumber(pinData.criterionIndex)
        if criterionIndex then
            self.hasCriteriaPins = true
            local achievementId = tonumber(pinData.criterionAchievementId) or defaultAchievementId
            local criteriaByIndex = achievementId and criteriaByAchievement[achievementId] or fallbackCriteriaByIndex
            criteriaByIndex = criteriaByIndex or {}
            local criterion = criteriaByIndex[criterionIndex]
            if criterion then
                pinData.criterionCompleted = criterion.completed == true
                pinData.criterionText = criterion.text
            end
        end
    end
end

function CollectionMapWindow:GetVisiblePins()
    local pins = {}
    for _, pinData in ipairs(self.pins or {}) do
        if self.showCompletedCriteriaPins or pinData.criterionCompleted ~= true then
            pins[#pins + 1] = pinData
        end
    end
    return pins
end

function CollectionMapWindow:UpdateCriteriaFilterControl()
    if not self.completedPinsCheck then
        return
    end

    self.completedPinsCheck:SetChecked(self.showCompletedCriteriaPins == true)
    if self.hasCriteriaPins then
        self.completedPinsCheck:Show()
    else
        self.completedPinsCheck:Hide()
    end
end

function CollectionMapWindow:RefreshProjectedCriteriaPins()
    local payload = self:CopyProjectionPayload()
    if self:FindProjection(payload) then
        self:AddProjection(payload)
        self:RefreshWorldMapProjection()
        self:RefreshMinimapProjection()
    end
end

function CollectionMapWindow:SetShowCompletedCriteriaPins(showCompleted)
    self.showCompletedCriteriaPins = showCompleted == true
    self:UpdateCriteriaFilterControl()
    self:RefreshProjectedCriteriaPins()
    self:RenderMap()
end
