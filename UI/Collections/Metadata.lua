local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog
local Metadata = {}

local TYPE_LABELS = {
    all = "All Types", weapons = "Weapons: All", armour = "Armour: All", other = "Other / Unknown",
    ["weapons:bows"] = "Weapons: Bows", ["weapons:crossbows"] = "Weapons: Crossbows",
    ["weapons:guns"] = "Weapons: Guns", ["weapons:1hSwords"] = "Weapons: One-Handed Swords",
    ["weapons:2hSwords"] = "Weapons: Two-Handed Swords", ["weapons:1hAxes"] = "Weapons: One-Handed Axes",
    ["weapons:2hAxes"] = "Weapons: Two-Handed Axes", ["weapons:1hMaces"] = "Weapons: One-Handed Maces",
    ["weapons:2hMaces"] = "Weapons: Two-Handed Maces", ["weapons:daggers"] = "Weapons: Daggers",
    ["weapons:fists"] = "Weapons: Fist Weapons", ["weapons:polearms"] = "Weapons: Polearms",
    ["weapons:staves"] = "Weapons: Staves", ["weapons:wands"] = "Weapons: Wands",
    ["weapons:warglaives"] = "Weapons: Warglaives", ["weapons:paired"] = "Weapons: Paired Weapons",
    ["weapons:sets"] = "Weapons: Arsenals", ["weapons:illusions"] = "Weapons: Illusions",
    ["armour:head"] = "Armour: Head", ["armour:shoulders"] = "Armour: Shoulders",
    ["armour:back"] = "Armour: Back", ["armour:chest"] = "Armour: Chest",
    ["armour:wrists"] = "Armour: Wrists", ["armour:hands"] = "Armour: Hands",
    ["armour:waist"] = "Armour: Waist", ["armour:legs"] = "Armour: Legs",
    ["armour:feet"] = "Armour: Feet", ["armour:shirts"] = "Armour: Shirts",
    ["armour:tabards"] = "Armour: Tabards", ["armour:shields"] = "Armour: Shields",
    ["armour:offHands"] = "Armour: Off-Hands", ["armour:sets"] = "Armour: Ensembles",
}

-- TransmogCollectionType values from Blizzard's TransmogSharedDocumentation.
local TRANSMOG_TYPES = {
    [1] = "armour:head", [2] = "armour:shoulders", [3] = "armour:back", [4] = "armour:chest",
    [5] = "armour:shirts", [6] = "armour:tabards", [7] = "armour:wrists", [8] = "armour:hands",
    [9] = "armour:waist", [10] = "armour:legs", [11] = "armour:feet", [12] = "weapons:wands",
    [13] = "weapons:1hAxes", [14] = "weapons:1hSwords", [15] = "weapons:1hMaces",
    [16] = "weapons:daggers", [17] = "weapons:fists", [18] = "armour:shields",
    [19] = "armour:offHands", [20] = "weapons:2hAxes", [21] = "weapons:2hSwords",
    [22] = "weapons:2hMaces", [23] = "weapons:staves", [24] = "weapons:polearms",
    [25] = "weapons:bows", [26] = "weapons:guns", [27] = "weapons:crossbows",
    [28] = "weapons:warglaives", [29] = "weapons:paired",
}
local WEAPON_TYPES = {
    [0] = "weapons:1hAxes", [1] = "weapons:2hAxes", [2] = "weapons:bows", [3] = "weapons:guns",
    [4] = "weapons:1hMaces", [5] = "weapons:2hMaces", [6] = "weapons:polearms",
    [7] = "weapons:1hSwords", [8] = "weapons:2hSwords", [9] = "weapons:warglaives",
    [10] = "weapons:staves", [13] = "weapons:fists", [15] = "weapons:daggers",
    [18] = "weapons:crossbows", [19] = "weapons:wands",
}
local ARMOUR_SLOTS = {
    INVTYPE_HEAD = "armour:head", INVTYPE_SHOULDER = "armour:shoulders", INVTYPE_CLOAK = "armour:back",
    INVTYPE_CHEST = "armour:chest", INVTYPE_ROBE = "armour:chest", INVTYPE_WRIST = "armour:wrists",
    INVTYPE_HAND = "armour:hands", INVTYPE_WAIST = "armour:waist", INVTYPE_LEGS = "armour:legs",
    INVTYPE_FEET = "armour:feet", INVTYPE_BODY = "armour:shirts", INVTYPE_TABARD = "armour:tabards",
    INVTYPE_SHIELD = "armour:shields", INVTYPE_HOLDABLE = "armour:offHands",
}

function Metadata:GetCosmeticTypeLabel(value)
    return TYPE_LABELS[value] or TYPE_LABELS.all
end

function Metadata:GetCosmeticType(entry)
    if type(entry) ~= "table" then return "other" end
    if entry.subtype == "ensemble" then return "armour:sets"
    elseif entry.subtype == "arsenal" then return "weapons:sets"
    elseif entry.subtype == "illusion" then return "weapons:illusions"
    elseif entry.subtype == "effect" then return "other" end

    local itemID = tonumber(entry.itemId)
    if not itemID then return "other" end
    local getInfo = C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant
    if type(getInfo) == "function" then
        local ok, _, _, _, equipLoc, _, classID, subClassID = pcall(getInfo, itemID)
        if ok then
            if classID == 2 and WEAPON_TYPES[subClassID] then return WEAPON_TYPES[subClassID] end
            if ARMOUR_SLOTS[equipLoc] then return ARMOUR_SLOTS[equipLoc] end
        end
    end

    -- Appearance tokens can lack an equipment slot; ask for the learned appearance's category.
    if C_TransmogCollection and type(C_TransmogCollection.GetItemInfo) == "function"
        and type(C_TransmogCollection.GetCategoryForItem) == "function" then
        local ok, _, sourceID = pcall(C_TransmogCollection.GetItemInfo, itemID)
        if ok and sourceID then
            local categoryOK, category = pcall(C_TransmogCollection.GetCategoryForItem, sourceID)
            if categoryOK and TRANSMOG_TYPES[category] then return TRANSMOG_TYPES[category] end
        end
    end

    -- The existing ITEM_DATA_LOAD_RESULT refresh will retry classification after loading.
    if C_Item and type(C_Item.IsItemDataCachedByID) == "function"
        and type(C_Item.RequestLoadItemDataByID) == "function" then
        local ok, cached = pcall(C_Item.IsItemDataCachedByID, itemID)
        if ok and not cached then
            self.cosmeticTypeRequests = self.cosmeticTypeRequests or {}
            if not self.cosmeticTypeRequests[itemID] then
                self.cosmeticTypeRequests[itemID] = true
                pcall(C_Item.RequestLoadItemDataByID, itemID)
            end
        end
    end
    return "other"
end

-- Classify the acquisition method, never the item name or incidental instructions.
local function categoryFromSource(text)
    text = string.lower(text or "")
    if text:find("trading post", 1, true) then return "Trading Post"
    elseif text:find("promotion", 1, true) or text:find("shop", 1, true) or text:find("blizzcon", 1, true) then return "Promotion"
    elseif text:find("pvp", 1, true) or text:find("honor", 1, true) or text:find("arena", 1, true) then return "PvP"
    elseif text:find("delve", 1, true) then return "Delves"
    elseif text:find("vendor", 1, true) then return "Vendor"
    elseif text:find("achievement", 1, true) then return "Achievements"
    elseif text:find("quest", 1, true) then return "Quest Rewards"
    elseif text:find("pet battle", 1, true) or text:find("wild", 1, true) then return "Pet Battles"
    elseif text:find("profession", 1, true) or text:find("craft", 1, true) or text:find("synthesis", 1, true) or text:find("fishing", 1, true) then return "Professions"
    elseif text:find("dungeon", 1, true) or text:find("raid", 1, true) then return "Dungeon and Raids"
    elseif text:find("treasure", 1, true) or text:find("discovery", 1, true) then return "Treasure"
    elseif text:find("drop", 1, true) then return "Rare Drops"
    elseif text:find("reputation", 1, true) or text:find("renown", 1, true) or text:find("paragon", 1, true) then return "Reputation"
    elseif text:find("event", 1, true) or text:find("timewalking", 1, true) or text:find("grand hunt", 1, true) then return "Events"
    end
end

function Metadata:GetSourceCategory(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return PatchCatalog:GetMountCategory(patchKey, entry)
    end
    local researched = PatchCatalog.GetResearchedCollectionSourceKind
        and PatchCatalog:GetResearchedCollectionSourceKind(collectionType, patchKey, entry)
    if researched then
        if researched == "Unavailable" or researched == "Unverified" or researched == "Historical Reward" then return "Other" end
        return researched
    end
    local details = PatchCatalog:GetCollectionDetails(collectionType, patchKey, entry) or {}
    -- Imported journal records store the actual method in source rather than sourceType.
    local category = categoryFromSource(details.sourceType)
    if category then return category end
    local sourceInfo = PatchCatalog.GetCollectionSourceInfo and PatchCatalog:GetCollectionSourceInfo(collectionType, patchKey, entry)
    if sourceInfo then return sourceInfo.kind end
    return categoryFromSource(details.source or (type(entry) == "table" and entry.source)) or "Other"
end

function Metadata:GetRowMetaPrefix(row)
    if row.collectionType == "mounts" then
        return (row.mountCategory or "Other") .. " mount"
    elseif row.collectionType == "achievements" and row.achievementCategory then
        return row.achievementCategory .. " achievement"
    elseif row.collectionType == "pets" or row.collectionType == "toys" or row.collectionType == "cosmetics" then
        local details = PatchCatalog:GetCollectionDetails(row.collectionType, row.patchKey, row.entry) or {}
        local source = PatchCatalog.GetResearchedCollectionSourceKind
            and PatchCatalog:GetResearchedCollectionSourceKind(row.collectionType, row.patchKey, row.entry) or details.sourceType
        if not source or source == "Pet Journal Source" or source == "Toy Box Source" or source:find("Unknown", 1, true) then
            source = row.sourceCategory or self:GetSourceCategory(row.collectionType, row.patchKey, row.entry)
            local sourceInfo = PatchCatalog.GetCollectionSourceInfo and PatchCatalog:GetCollectionSourceInfo(row.collectionType, row.patchKey, row.entry)
            if sourceInfo then source = sourceInfo.summary
            elseif details.source and details.source ~= "" then source = details.source
            elseif source == "Other" then source = "Acquisition details not recorded" end
        end
        local itemType = self:GetTypeLabel(row.collectionType)
        if row.collectionType == "cosmetics" then
            local cosmeticType = row.cosmeticType or self:GetCosmeticType(row.entry)
            itemType = cosmeticType ~= "other" and self:GetCosmeticTypeLabel(cosmeticType)
                or ((row.cosmeticSubtype or "appearance"):gsub("^%l", string.upper)) .. " cosmetic"
        end
        return itemType .. " - " .. source
    end
    return self:GetTypeLabel(row.collectionType)
end

function Metadata:SetRowMeta(row, text, minimumHeight)
    row.meta:SetText(text)
    row:SetHeight(math.max(minimumHeight, math.ceil(row.title:GetStringHeight() + row.meta:GetStringHeight()) + 20))
end

Metadata.COSMETIC_TYPE_LABELS = TYPE_LABELS

function Metadata:Install(windowClass)
    for _, name in ipairs({ "GetSourceCategory", "GetCosmeticType", "GetCosmeticTypeLabel", "GetRowMetaPrefix", "SetRowMeta" }) do
        windowClass[name] = self[name]
    end
end

TDP.CollectionMetadata = Metadata
