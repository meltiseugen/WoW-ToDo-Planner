local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local GUIDE_ID_FIELDS = { mounts = "spellId", pets = "speciesId", toys = "itemId" }
function PatchCatalog:GetCollectionGuideText(collectionType, entry)
    local guides = TDP.CollectionAcquisitionGuides and TDP.CollectionAcquisitionGuides[collectionType]
    local field = GUIDE_ID_FIELDS[collectionType]
    return guides and field and type(entry) == "table" and guides[entry[field]] or nil
end

function PatchCatalog:GetCollectionCostLines(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry) or {}
    local item = type(entry) == "table" and entry or {}
    local lines = {}
    local cost = item.cost or details.cost
    if not cost and self.GetCollectionSourceCost then cost = self:GetCollectionSourceCost(collectionType, patchKey, entry) end
    if cost and cost ~= "" then
        lines[#lines + 1] = "Cost: " .. tostring(cost)
    end
    local costs = item.costs or details.costs
    if type(costs) == "table" and #costs > 0 then
        lines[#lines + 1] = "Cost guide:"
        for _, costLine in ipairs(costs) do
            lines[#lines + 1] = "- " .. tostring(costLine)
        end
    end
    return lines
end

local function positiveId(value)
    local id = tonumber(value)
    return id and id > 0 and id == math.floor(id) and id or nil
end

local function normalize(text)
    return tostring(text or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        :gsub("^%s+", ""):gsub("%s+$", ""):lower()
end

local function indexUnique(index, name, id)
    if index[name] == nil then
        index[name] = id
    elseif index[name] ~= id then
        index[name] = false
    end
end

local function rewardName(text)
    return normalize(text):gsub("^mount:%s*", ""):gsub("^pet:%s*", "")
        :gsub("^toy:%s*", ""):gsub("^item:%s*", "")
end

function PatchCatalog:GetSourceAchievementIndex()
    if self.sourceAchievementIndex and self.sourceAchievementIndex.patches == self.patches then
        return self.sourceAchievementIndex
    end
    local index = { patches = self.patches, byName = {}, rewards = {} }
    for _, key in ipairs(self:GetPatchKeys()) do
        local patch = self:GetPatch(key)
        for _, reward in ipairs(patch.achievements and patch.achievements.rewardHighlights or {}) do
            local id = positiveId(reward.achievementId)
            local name, itemName = normalize(reward.name), rewardName(reward.reward)
            if id and name ~= "" and index.byName[name] == nil then index.byName[name] = id end
            if id and itemName ~= "" and index.rewards[itemName] == nil then index.rewards[itemName] = id end
        end
    end
    self.sourceAchievementIndex = index
    return index
end

function PatchCatalog:GetCollectionSourceAchievementId(collectionType, patchKey, entry)
    if collectionType == "achievements" then return nil end
    local item = type(entry) == "table" and entry or {}
    local details = self:GetCollectionDetails(collectionType, patchKey, entry) or {}
    local explicit = positiveId(item.sourceAchievementId) or positiveId(details.sourceAchievementId)
        or positiveId(item.achievementId) or positiveId(details.achievementId)
    if explicit then return explicit end

    local source = tostring(details.source or item.source or "")
    local linkId = source:match("achievement:(%d+)")
        or tostring(details.sourceUrl or item.sourceUrl or ""):match("/achievement=(%d+)")
    if positiveId(linkId) then return tonumber(linkId) end
    local sourceInfo = self.GetCollectionSourceInfo and self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    if sourceInfo and sourceInfo.kind == "Achievements" and positiveId(sourceInfo.achievementID) then
        return sourceInfo.achievementID
    end
    -- An achievement destination remains inspectable from the other faction.
    -- Keep acquisition eligibility in the source resolver; only use an
    -- unambiguous reward achievement when no source matches this character.
    if not sourceInfo and self.GetCollectionSourceRecords then
        local achievementId, ambiguous
        for _, record in ipairs(self:GetCollectionSourceRecords(collectionType, patchKey, entry)) do
            local id = record.kind == "Achievements" and positiveId(record.achievementID)
            if not id or achievementId and achievementId ~= id then ambiguous = true; break end
            achievementId = id
        end
        if achievementId and not ambiguous then return achievementId end
    end
    local sourceType = tostring(details.sourceType or item.sourceType or ""):lower()
    local category = tostring(details.category or item.category or ""):lower()
    local achievementSource = sourceType:find("achievement", 1, true) ~= nil or category == "achievements"
        or source:lower():find("achievement", 1, true) ~= nil
    -- Older and imported mount records can have a generic source label. An exact
    -- achievement reward match still identifies their destination safely.
    if not achievementSource and collectionType ~= "mounts" then return nil end

    local mapAchievementId = achievementSource and (positiveId(item.mapAchievementId) or positiveId(details.mapAchievementId))
    if mapAchievementId then return mapAchievementId end

    -- Only interpret a parenthesized number when the source is an achievement.
    local sourceId = achievementSource and positiveId(source:match("%((%d+)%)%s*$"))
    if sourceId then return sourceId end

    local sourceName = normalize(source)
    sourceName = sourceName:gsub("^achievement:%s*", "")
        :gsub("%s*/%s*category:.*$", ""):gsub("%s+category:.*$", "")
        :gsub("%s+for alliance$", ""):gsub("%s+for horde$", "")
        :gsub("%s+on an? alliance account$", ""):gsub("%s+on an? horde account$", "")
        :gsub("^the alliance%s+", ""):gsub("^the horde%s+", "")
        :gsub("%s+%(%d+ mounts%)$", "")
        :gsub("%s+collection achievement$", ""):gsub("%s+achievement$", "")
    local itemName = normalize(item.name)
    local function find(index)
        local nameId = achievementSource and (index.byName[sourceName]
            or index.byName[sourceName:gsub("^the ", "")]
            or index.byName[sourceName:match("^(.-) / ") or sourceName])
        return positiveId(nameId) or (itemName ~= "" and positiveId(index.rewards[itemName])) or nil
    end
    -- Prefer curated names. Journal names fill gaps in older patch catalogs.
    local curated = find(self:GetSourceAchievementIndex())
    if curated then return curated end
    if type(GetAchievementInfo) ~= "function" then return nil end
    self.sourceAchievementNames = self.sourceAchievementNames or {}
    local function findInPatch(key)
        local names = self.sourceAchievementNames[key]
        if not names or names.api ~= GetAchievementInfo then
            names = { byName = {}, rewards = {}, loaded = {}, api = GetAchievementInfo }
            self.sourceAchievementNames[key] = names
        end
        local now = type(GetTime) == "function" and GetTime() or nil
        if not names.complete and (not now or not names.retryAt or now >= names.retryAt) then
            local complete = true
            for _, id in ipairs(self:GetEntries(key, "achievements")) do
                if not names.loaded[id] then
                    local ok, _, name, _, _, _, _, _, _, _, _, reward = pcall(GetAchievementInfo, id)
                    if ok and name and name ~= "" then
                        indexUnique(names.byName, normalize(name), id)
                        if reward and reward ~= "" then indexUnique(names.rewards, rewardName(reward), id) end
                        names.loaded[id] = true
                    else
                        complete = false
                    end
                end
            end
            names.complete, names.retryAt = complete, now and now + 5
        end
        -- Missing journal data can retry later, never once per painted row.
        return find(names)
    end
    -- Query only this item's patch; opening a reward must not scan every expansion.
    return findInPatch(patchKey)
end

function PatchCatalog:GetAchievementPatchKey(achievementId, preferredPatch)
    local function contains(key)
        for _, id in ipairs(self:GetEntries(key, "achievements")) do
            if tonumber(id) == achievementId then return true end
        end
    end
    if contains(preferredPatch) then return preferredPatch end
    for _, key in ipairs(self:GetPatchKeys()) do
        if contains(key) then return key end
    end
    return preferredPatch
end
