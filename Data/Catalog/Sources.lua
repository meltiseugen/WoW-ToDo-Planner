local _, TDP = ...
local Catalog = TDP.PatchCatalog
local FIELD_BY_TYPE = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }
local SOURCE_CACHE_LIMIT = 512
local EMPTY_RECORDS = {}
local QUEST_NAMES = {
    [28174] = "Burning Vengeance", [28416] = "Burning Vengeance", [28418] = "Burning Vengeance",
    [28415] = "SEVEN! YUP!", [28491] = "Not Fireflies, Flameflies",
    [27367] = "Gidwin Goldbraids", [27370] = "Tarenar Sunstrike", [27555] = "Fiona's Lucky Charm",
}
local NPC_NAMES = { [47811] = "John J. Keeshan", [48559] = "Ariok", [9177] = "Oralius", [10260] = "Kibler", [45417] = "Fiona" }

local function call(api, ...)
    if type(api) ~= "function" then return nil end
    local ok, a, b, c = pcall(api, ...)
    if ok then return a, b, c end
end

local function contains(values, value)
    for _, candidate in ipairs(values or {}) do if candidate == value then return true end end
    return false
end

local function matchesCharacter(record)
    if not Catalog.collectionSourceCharacter then
        local _, _, classID = call(UnitClass, "player")
        local _, _, raceID = call(UnitRace, "player")
        Catalog.collectionSourceCharacter = { faction = call(UnitFactionGroup, "player"), classID = classID, raceID = raceID }
    end
    local character = Catalog.collectionSourceCharacter
    local faction, classID, raceID = character.faction, character.classID, character.raceID
    if record.faction and faction and faction ~= "Neutral" and record.faction ~= faction then return false end
    if record.classes and classID and not contains(record.classes, classID) then return false end
    if record.races and raceID and not contains(record.races, raceID) then return false end
    return true
end

local function makeWaypoints(coords, label, record)
    local result = {}
    for _, point in ipairs(coords or {}) do
        local mapID, x, y = tonumber(point[1]), tonumber(point[2]), tonumber(point[3])
        if mapID and mapID > 0 and x and y and x >= 0 and x <= 100 and y >= 0 and y <= 100 then
            local mapInfo = call(C_Map and C_Map.GetMapInfo, mapID)
            result[#result + 1] = { mapID = mapID, mapName = mapInfo and mapInfo.name or TDP.CatalogMapNames[mapID],
                x = x / 100, y = y / 100, label = label,
                questID = record and record.questID, npcID = record and (record.npcID or (record.qgs or {})[1]),
                locationType = record and record.locationType }
        end
    end
    return result
end

local function questName(id)
    local name = call(C_QuestLog and C_QuestLog.GetTitleForQuestID, id)
    return type(name) == "string" and name ~= "" and name or QUEST_NAMES[id]
end

local function sourceQuest(id)
    local quest = (TDP.CollectionSourceIndex.quests or {})[id]
    if quest and quest.variants then
        for _, variant in ipairs(quest.variants) do if matchesCharacter(variant) then return variant end end
        return nil
    end
    return quest
end

function Catalog:ResetCollectionSourceCache(questsOnly)
    if questsOnly then
        for key, info in pairs(self.collectionSourceCache or {}) do
            if info and (info.questID or info.rewardQuestID) then self.collectionSourceCache[key] = nil end
        end
    else
        self.collectionSourceCache = nil
        self.collectionSourceCacheKeys = nil
        self.collectionSourceCacheSlots = nil
        self.collectionSourceCacheCursor = nil
        self.collectionSourceCharacter = nil
    end
    self.collectionCompletedQuests = nil
    self.collectionCompletedQuestsKnown = nil
    self.collectionSourceQuestFlags = nil
    self.collectionActiveSourceQuests = nil
end

function Catalog:CacheCollectionSourceInfo(key, info)
    self.collectionSourceCache = self.collectionSourceCache or {}
    self.collectionSourceCacheKeys = self.collectionSourceCacheKeys or {}
    self.collectionSourceCacheSlots = self.collectionSourceCacheSlots or {}
    if not self.collectionSourceCacheSlots[key] then
        local slot = (self.collectionSourceCacheCursor or 0) % SOURCE_CACHE_LIMIT + 1
        local previous = self.collectionSourceCacheKeys[slot]
        if previous then
            self.collectionSourceCache[previous] = nil
            self.collectionSourceCacheSlots[previous] = nil
        end
        self.collectionSourceCacheKeys[slot] = key
        self.collectionSourceCacheSlots[key] = slot
        self.collectionSourceCacheCursor = slot
    end
    self.collectionSourceCache[key] = info or false
    return info
end

function Catalog:IsSourceQuestCompleted(id, seen)
    seen = seen or {}
    if seen[id] then return false end
    seen[id] = true
    if not self.collectionCompletedQuests then
        self.collectionCompletedQuests = {}
        -- Query only the quests used by these sources. Reading the entire quest
        -- history on every collection refresh is needlessly expensive.
        local completed = not (C_QuestLog and type(C_QuestLog.IsQuestFlaggedCompleted) == "function")
            and call(C_QuestLog and C_QuestLog.GetAllCompletedQuestIDs) or nil
        self.collectionCompletedQuestsKnown = type(completed) == "table"
        for _, completedID in ipairs(self.collectionCompletedQuestsKnown and completed or {}) do
            self.collectionCompletedQuests[completedID] = true
        end
    end
    if self.collectionCompletedQuests[id] then return true end
    if not self.collectionCompletedQuestsKnown then
        self.collectionSourceQuestFlags = self.collectionSourceQuestFlags or {}
        local complete = self.collectionSourceQuestFlags[id]
        if complete == nil then
            complete = call(C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted, id) == true
            self.collectionSourceQuestFlags[id] = complete
        end
        if complete then return true end
    end
    local quest = sourceQuest(id)
    for _, alternateID in ipairs(quest and quest.altQuests or {}) do
        if self:IsSourceQuestCompleted(alternateID, seen) then return true end
    end
    return false
end

function Catalog:IsSourceQuestActive(id)
    self.collectionActiveSourceQuests = self.collectionActiveSourceQuests or {}
    local active = self.collectionActiveSourceQuests[id]
    if active == nil then
        active = call(C_QuestLog and C_QuestLog.IsOnQuest, id)
        if type(active) ~= "boolean" then active = (tonumber(call(C_QuestLog and C_QuestLog.GetLogIndexForQuestID, id)) or 0) > 0 end
        self.collectionActiveSourceQuests[id] = active
    end
    return active
end

function Catalog:GetNextCollectionSourceQuest(rewardID, repeatableReward)
    local visiting = {}
    local function nextQuest(id, depth)
        local quest = sourceQuest(id)
        if not quest or not matchesCharacter(quest) or quest.isBreadcrumb or visiting[id] or depth > 80 then return nil end
        if not (repeatableReward and id == rewardID) and self:IsSourceQuestCompleted(id) then return nil end
        if self:IsSourceQuestActive(id) then
            return quest, "active"
        end
        visiting[id] = true
        local prerequisites, satisfied = {}, 0
        for _, prerequisiteID in ipairs(quest.sourceQuests or {}) do
            local prerequisite = sourceQuest(prerequisiteID)
            if not prerequisite or not matchesCharacter(prerequisite) or prerequisite.isBreadcrumb
                or self:IsSourceQuestCompleted(prerequisiteID) then
                satisfied = satisfied + 1
            else
                prerequisites[#prerequisites + 1] = prerequisiteID
            end
        end
        if satisfied < (tonumber(quest.sqreq) or #(quest.sourceQuests or {})) then
            for _, prerequisiteID in ipairs(prerequisites) do
                local prerequisite, status = nextQuest(prerequisiteID, depth + 1)
                if prerequisite then visiting[id] = nil; return prerequisite, status end
            end
        end
        visiting[id] = nil
        return quest, "available"
    end
    local quest, status = nextQuest(rewardID, 0)
    if quest then return quest, status end
    return sourceQuest(rewardID), self:IsSourceQuestCompleted(rewardID) and "complete" or "unavailable"
end

function Catalog:GetCollectionSourceRecords(collectionType, patchKey, entry)
    local field = FIELD_BY_TYPE[collectionType]
    local id = field and type(entry) == "table" and tonumber(entry[field])
    local index = TDP.CollectionSourceIndex or {}
    return id and index[collectionType] and index[collectionType][id] or EMPTY_RECORDS
end

function Catalog:UseCollectionSourceWaypoints(collectionType, patchKey, entry, info)
    if not info or #info.waypoints == 0 then return false end
    local details = self:GetCollectionDetails(collectionType, patchKey, entry) or {}
    local waypoints = details.waypoints
    if collectionType == "cosmetics" and type(waypoints) == "table" and #waypoints > 0 then return false end
    if info.questID then return true end
    if type(waypoints) ~= "table" or #waypoints == 0 then return true end
    -- Existing cosmetic guides include researched approaches, unlocks and route
    -- landmarks. Retain those guides while filling entries without locations.
    if info.kind == "Vendor" then return true end
    return details.sourceType == "Pet Journal Source" or details.sourceType == "Toy Box Source"
end

local METHOD_ORDER = { Vendor = 1, ["Quest Rewards"] = 2, ["Dungeon and Raids"] = 3,
    ["Rare Drops"] = 4, Treasure = 5, ["Pet Battles"] = 6, Achievements = 7,
    Professions = 8, Reputation = 9, Delves = 10, Events = 11, PvP = 12,
    ["Black Market"] = 20, ["Trading Post"] = 21, Promotion = 22 }

function Catalog:GetResearchedCollectionSourceKind(collectionType, patchKey, entry)
    local selected, score
    for _, record in ipairs(self:GetCollectionSourceRecords(collectionType, patchKey, entry)) do
        if record.researched and matchesCharacter(record) then
            local rank = METHOD_ORDER[record.kind] or 30
            if not score or rank < score then selected, score = record.kind, rank end
        end
    end
    return selected
end

function Catalog:GetCollectionSourceInfo(collectionType, patchKey, entry)
    if not FIELD_BY_TYPE[collectionType] or type(entry) ~= "table" then return nil end
    local key = collectionType .. ":" .. tostring(patchKey) .. ":" .. tostring(entry[FIELD_BY_TYPE[collectionType]])
    self.collectionSourceCache = self.collectionSourceCache or {}
    local cached = self.collectionSourceCache[key]
    if cached ~= nil then return cached or nil end
    local candidates, selected, score = {}, nil, math.huge
    for _, record in ipairs(self:GetCollectionSourceRecords(collectionType, patchKey, entry)) do
        if matchesCharacter(record) then
            candidates[#candidates + 1] = record
            local value = METHOD_ORDER[record.kind] or 30
            if value < score then selected, score = record, value end
        end
    end
    if not selected then return self:CacheCollectionSourceInfo(key, nil) end
    local details = self:GetCollectionDetails(collectionType, patchKey, entry) or {}
    local recordedSource = selected.sourceName or details.source or entry.source
    if recordedSource and (recordedSource:match("^Patch ") or recordedSource:match("^Unknown")
        or recordedSource == "Pet Journal" or recordedSource == "Toy Box") then recordedSource = nil end
    local info = { kind = selected.kind, npcID = selected.npcID, npcName = selected.npcName, achievementID = selected.achievementID,
        source = recordedSource, waypoints = {}, areaMaps = {}, records = candidates, cost = selected.cost,
        instructions = selected.instructions, progressType = selected.progressType, repeatableReward = selected.repeatableReward }
    local gateQuest, gateStatus
    if selected.unlockQuestID then
        gateQuest, gateStatus = self:GetNextCollectionSourceQuest(selected.unlockQuestID)
    end
    local unfinishedUnlock = gateQuest and gateQuest.questID ~= selected.unlockQuestID
    if selected.progressQuestID or selected.kind == "Quest Rewards" and selected.questID or unfinishedUnlock then
        local quest, status = gateQuest, gateStatus
        if not unfinishedUnlock then quest, status = self:GetNextCollectionSourceQuest(selected.progressQuestID or selected.questID, selected.repeatableReward) end
        info.rewardQuestID, info.questStatus = selected.questID, status
        if quest and status ~= "unavailable" then
            info.questID, info.questName = quest.questID, questName(quest.questID) or quest.name
            info.npcID = (quest.qgs or {})[1]
            info.npcName = quest.npcName
            local action = status == "complete" and "Reward quest" or status == "active" and "Current quest" or "Next quest"
            if selected.repeatableReward and quest.questID == selected.questID then action = "Repeatable quest" end
            if selected.progressType == "secret" then action = status == "complete" and "Final secret step" or "Next secret step" end
            info.source = action .. (info.questName and ": " .. info.questName or " in the quest chain")
            if quest.instructions then info.instructions = quest.instructions end
            info.waypoints = makeWaypoints(quest.coords, info.source, quest)
            if status == "active" then
                local mapID, x, y = call(C_QuestLog and C_QuestLog.GetNextWaypoint, quest.questID)
                if tonumber(mapID) and tonumber(mapID) > 0 and tonumber(x) and tonumber(y)
                    and x >= 0 and x <= 1 and y >= 0 and y <= 1 then
                    info.waypoints = { { mapID = mapID, x = x, y = y, label = info.source,
                        questID = quest.questID, npcID = info.npcID, locationType = "Quest objective" } }
                end
            end
            info.questComplete = status == "complete"
            info.areaMaps = quest.maps or {}
        end
    else
        local seen = {}
        local seenMaps = {}
        for _, record in ipairs(candidates) do
            if record.kind == selected.kind then
                local label = record.locationType or record.npcName or record.sourceName or recordedSource or record.kind
                for _, waypoint in ipairs(makeWaypoints(record.coords, label, record)) do
                    local pinKey = string.format("%d:%.5f:%.5f", waypoint.mapID, waypoint.x, waypoint.y)
                    if not seen[pinKey] then info.waypoints[#info.waypoints + 1] = waypoint; seen[pinKey] = true end
                end
                for _, mapID in ipairs(record.maps or {}) do
                    if mapID > 0 and not seenMaps[mapID] then info.areaMaps[#info.areaMaps + 1] = mapID; seenMaps[mapID] = true end
                end
            end
        end
    end
    info.npcName = info.npcName or NPC_NAMES[info.npcID]
    if info.npcName and info.questID then
        for _, waypoint in ipairs(info.waypoints) do waypoint.label = info.source .. " - " .. info.npcName end
    end
    info.summary = info.kind .. (info.source and ": " .. info.source or "")
    if info.waypoints[1] then
        local point = info.waypoints[1]
        local mapInfo = call(C_Map and C_Map.GetMapInfo, point.mapID)
        info.mapName = mapInfo and mapInfo.name or TDP.CatalogMapNames[point.mapID]
        info.location = string.format("%s%s%.1f, %.1f", info.mapName or "", info.mapName and " - " or "", point.x * 100, point.y * 100)
    elseif info.areaMaps[1] then
        local mapInfo = call(C_Map and C_Map.GetMapInfo, info.areaMaps[1])
        info.mapName = mapInfo and mapInfo.name or TDP.CatalogMapNames[info.areaMaps[1]]
        info.location = info.mapName and (info.mapName .. " - source area") or "Source area"
        info.areaOnly = true
    end
    if selected.researched and selected.kind ~= "Achievements" and info.instructions and info.instructions ~= "" then
        info.acquisition = info.instructions
    end
    return self:CacheCollectionSourceInfo(key, info)
end

function Catalog:GetResearchedCollectionAcquisition(collectionType, patchKey, entry)
    local info = self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    return info and info.acquisition
end

function Catalog:GetActionableCollectionSourceSummary(collectionType, patchKey, entry)
    local info = self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    return info and info.summary
end

function Catalog:GetCollectionSourceNotes(collectionType, patchKey, entry, requestData)
    local info = self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    if not info then return {} end
    local lines = {}
    if info.questID then
        if requestData and not info.questName and C_QuestLog and type(C_QuestLog.RequestLoadQuestByID) == "function" then
            self.collectionSourceQuestRequests = self.collectionSourceQuestRequests or {}
            if not self.collectionSourceQuestRequests[info.questID] then
                self.collectionSourceQuestRequests[info.questID] = true
                call(C_QuestLog.RequestLoadQuestByID, info.questID)
            end
        end
        lines[#lines + 1] = (info.progressType == "secret" and "Secret chain: " or "Quest chain: ")
            .. (info.repeatableReward and "Repeat eligible quests for a chance at the reward."
                or info.questComplete and "Completed on this character. Check your bags or learned collection for the reward."
                or "Continue from this character's first unfinished prerequisite.")
    end
    if info.npcName then lines[#lines + 1] = (info.questID and "Quest giver: " or info.kind == "Vendor" and "Vendor: " or "Source NPC: ") .. info.npcName end
    if info.location then lines[#lines + 1] = "Location: " .. info.location end
    if #info.waypoints > 1 then lines[#lines + 1] = "Locations: " .. #info.waypoints .. " recorded locations are available on the map." end
    if info.areaOnly then
        lines[#lines + 1] = "Location: This map identifies the source area. A precise NPC or object position is not recorded."
    end
    if info.instructions then lines[#lines + 1] = "How to get: " .. info.instructions end
    return lines
end

function Catalog:GetCollectionSourceCost(collectionType, patchKey, entry)
    local info = self:GetCollectionSourceInfo(collectionType, patchKey, entry)
    local parts = {}
    local costs = info and info.cost
    if type(costs) == "number" then costs = { { "g", costs } } end
    for _, component in ipairs(type(costs) == "table" and costs or {}) do
        if type(component) ~= "table" then return nil end
        local kind, id, amount = component[1], component[2], component[3]
        if kind == "g" and tonumber(id) then
            local copper = tonumber(id)
            local money = call(GetCoinTextureString, copper)
            parts[#parts + 1] = money or string.format("%dg %ds %dc", math.floor(copper / 10000), math.floor(copper / 100) % 100, copper % 100)
        elseif (kind == "c" or kind == "i") and tonumber(id) and tonumber(amount) then
            local name, link
            if kind == "c" then
                local currency = call(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo, id)
                name = currency and currency.name
                link = call(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyLink, id, amount)
            else
                name = call(C_Item and C_Item.GetItemNameByID, id)
                if not name then name, link = call(GetItemInfo, id) end
                if not name then
                    self.collectionSourceCostItemRequests = self.collectionSourceCostItemRequests or {}
                    if not self.collectionSourceCostItemRequests[id] then self.collectionSourceCostItemRequests[id] = true end
                end
            end
            local label = link or (kind == "c" and ("|Hcurrency:" .. id .. "|h[" .. (name or "Currency") .. "]|h")
                or ("|Hitem:" .. id .. "|h[" .. (name or "Barter item") .. "]|h"))
            parts[#parts + 1] = tostring(amount) .. " " .. label
        end
    end
    return #parts > 0 and table.concat(parts, " and ") or nil
end
