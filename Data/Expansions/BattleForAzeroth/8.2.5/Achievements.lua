local _, TDP = ...

local shared = {}
shared["The Fourth War"] = {
    acquisition = "Complete the War Campaign in Battle for Azeroth.",
    source = "The Fourth War",
    sourceType = "Achievement",
    tips = "Open the achievement in game and work through each incomplete criterion; faction variants and seasonal PvP rows may require the matching character or season.",
}

TDP.CatalogRegistry:RegisterCollection("8.2.5", "achievements", {
    entries = { ids = { 13924, 13925 }, rewardHighlights = {} },
    details = { [13924] = shared["The Fourth War"], [13925] = shared["The Fourth War"] },
    categories = { [13924] = "Quests", [13925] = "Quests" },
})
