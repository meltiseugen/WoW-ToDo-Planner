local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local ALLIANCE_FACTION_MARKERS = {
    "alliance", "stormwind", "ironforge", "darnassus", "the exodar", "exodar",
    "boralus", "kul tiras", "proudmoore admiralty", "7th legion",
    "order of embers", "storm's wake", "lion's watch", "lunarfall", "stormshield",
    "silverwing", "wildhammer stronghold", "honor hold", "violet rise",
    "allied races: dark iron dwarf", "allied races: kul tiran", "allied races: lightforged draenei",
    "allied races: mechagnome", "allied races: void elf",
    "private's tabard", "knight's colors",
}

local HORDE_FACTION_MARKERS = {
    "horde", "orgrimmar", "thunder bluff", "undercity", "silvermoon", "dazar'alor",
    "zuldazar", "zandalari empire", "voldunai", "talanji's expedition", "the honorbound",
    "warspear", "frostwall", "vol'mar", "thrallmar", "domination point", "echo isles",
    "sen'jin", "bloodhoof village", "brill", "mor'shan", "garadar",
    "allied races: highmountain tauren", "allied races: mag'har orc", "allied races: nightborne",
    "allied races: vulpera", "allied races: zandalari troll",
    "scout's tabard", "stone guard's herald", "venomhide ravasaur",
}

local function NormalizeCollectionFaction(value)
    if value == 0 then
        return "horde"
    elseif value == 1 then
        return "alliance"
    end

    value = string.lower(tostring(value or ""))
    if value == "alliance" or value == "horde" or value == "all" then
        return value
    end
    return nil
end

local function AppendFactionText(parts, value)
    if type(value) == "string" and value ~= "" then
        parts[#parts + 1] = value
    elseif type(value) == "table" then
        for _, nestedValue in ipairs(value) do
            if type(nestedValue) == "string" then
                parts[#parts + 1] = nestedValue
            elseif type(nestedValue) == "table" then
                AppendFactionText(parts, nestedValue.label or nestedValue.waypoint)
            end
        end
    end
end

local function HasFactionMarker(text, markers)
    for _, marker in ipairs(markers) do
        if text:find(marker, 1, true) then
            return true
        end
    end
    return false
end

function PatchCatalog:GetCollectionFaction(collectionType, patchKey, entry, state)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    local rewardEntry = collectionType == "achievements" and self:GetAchievementReward(patchKey, entry) or nil
    local explicitFaction = NormalizeCollectionFaction(type(entry) == "table" and entry.faction)
        or NormalizeCollectionFaction(details and details.faction)
        or NormalizeCollectionFaction(rewardEntry and rewardEntry.faction)
        or NormalizeCollectionFaction(state and state.faction)
    if explicitFaction then
        return explicitFaction
    end

    local parts = {}
    if type(entry) == "table" then
        AppendFactionText(parts, entry.name)
        AppendFactionText(parts, entry.source)
        AppendFactionText(parts, entry.acquisition)
        AppendFactionText(parts, entry.detailKey)
        AppendFactionText(parts, entry.waypoints)
    end
    if details then
        AppendFactionText(parts, details.source)
        AppendFactionText(parts, details.acquisition)
        AppendFactionText(parts, details.waypoints)
    end
    if rewardEntry then
        AppendFactionText(parts, rewardEntry.name)
        AppendFactionText(parts, rewardEntry.reward)
        AppendFactionText(parts, rewardEntry.source)
    end
    AppendFactionText(parts, state and state.name)
    AppendFactionText(parts, state and state.description)

    local text = string.lower(table.concat(parts, " "))
    local targetsAlliance = text:find("slay all of the alliance", 1, true)
        or text:find("kill alliance players", 1, true)
        or text:find("defeat alliance players", 1, true)
        or text:find("alliance slayer", 1, true)
    local targetsHorde = text:find("slay all of the horde", 1, true)
        or text:find("kill horde players", 1, true)
        or text:find("defeat horde players", 1, true)
        or text:find("horde slayer", 1, true)
    if targetsAlliance and not targetsHorde then
        return "horde"
    elseif targetsHorde and not targetsAlliance then
        return "alliance"
    end

    local isAlliance = HasFactionMarker(text, ALLIANCE_FACTION_MARKERS)
    local isHorde = HasFactionMarker(text, HORDE_FACTION_MARKERS)
    if isAlliance ~= isHorde then
        return isAlliance and "alliance" or "horde"
    end
    return "all"
end

function PatchCatalog:IsAchievementSourcedCollection(collectionType, patchKey, entry)
    if collectionType == "achievements" then
        return false
    end

    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    if type(details) ~= "table" then
        return false
    end

    local waypoints = self:GetCollectionWaypoints(collectionType, patchKey, entry)
    if type(waypoints) == "table" and #waypoints > 0 then
        return false
    end

    local sourceType = tostring(details.sourceType or ""):lower()
    local category = tostring(details.category or ""):lower()
    return sourceType:find("achievement", 1, true) ~= nil or category == "achievements"
end

