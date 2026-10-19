local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

local function FilterCollection(entries, keep)
    local filtered = {}
    for _, entry in ipairs(entries or {}) do
        if keep(entry) then
            filtered[#filtered + 1] = entry
        end
    end
    return filtered
end


local PROHIBITED_DETAIL_TERMS = {
    "trading post", "traveler's log", "in-game shop", "battle.net shop",
    "promotion", "promotional", "twitch", "discord quest", "blizzcon",
    "china-only", "regional promotion", "subscription bundle",
    "holiday", "midsummer", "winter veil", "noblegarden", "children's week",
    "brewfest", "hallow's end", "lunar festival", "love is in the air",
    "headless horseman", "abominable greench",
}

local function IsProhibitedDetail(details)
    if type(details) ~= "table" then
        return false
    end
    local text = table.concat({
        tostring(details.category or ""),
        tostring(details.sourceType or ""),
        tostring(details.source or ""),
        tostring(details.availability or ""),
    }, " "):lower()
    for _, term in ipairs(PROHIBITED_DETAIL_TERMS) do
        if text:find(term, 1, true) then
            return true
        end
    end
    return false
end

for patchKey, patch in pairs(PatchCatalog.patches) do
    patch.mounts = FilterCollection(patch.mounts, function(entry)
        return not IsProhibitedDetail(PatchCatalog.mountDetails[patchKey] and PatchCatalog.mountDetails[patchKey][entry.name])
    end)
    patch.pets = FilterCollection(patch.pets, function(entry)
        return not IsProhibitedDetail(PatchCatalog.petDetails[patchKey] and PatchCatalog.petDetails[patchKey][entry.name])
    end)
    patch.toys = FilterCollection(patch.toys, function(entry)
        return not IsProhibitedDetail(PatchCatalog.toyDetails[patchKey] and PatchCatalog.toyDetails[patchKey][entry.name])
    end)
    patch.cosmetics = FilterCollection(patch.cosmetics, function(entry)
        local details = PatchCatalog.cosmeticDetails[patchKey]
        details = details and (details[entry.name] or details[entry.detailKey])
        return not IsProhibitedDetail(details)
    end)
    patch.achievements.ids = FilterCollection(patch.achievements.ids, function(achievementId)
        return not IsProhibitedDetail(PatchCatalog.achievementDetails[patchKey] and PatchCatalog.achievementDetails[patchKey][achievementId])
    end)
    patch.achievements.rewardHighlights = FilterCollection(patch.achievements.rewardHighlights, function(entry)
        for _, achievementId in ipairs(patch.achievements.ids) do
            if achievementId == entry.achievementId then
                return true
            end
        end
        return false
    end)
end

