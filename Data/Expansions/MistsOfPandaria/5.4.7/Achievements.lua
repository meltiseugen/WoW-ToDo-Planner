local _, TDP = ...

local shared = {}
shared["Patch 5.4.7: Mists PvP Season 15"] = { acquisition = "Complete the achievement's listed criteria.", source = "Patch 5.4.7: Mists PvP Season 15", sourceType = "Achievement" }

TDP.CatalogRegistry:RegisterCollection("5.4.7", "achievements", {
    entries = { ids = { 8450, 8451, 8641, 8642, 8658, 8659, 8666, 8667, 8668, 8669, 8670, 8707 }, rewardHighlights = { "Prideful Gladiator's Cloud Serpent", "Prideful Gladiator's Tabard" } },
    details = {
        [8450] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8451] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8641] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8642] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8658] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8659] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8666] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8667] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8668] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8669] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8670] = shared["Patch 5.4.7: Mists PvP Season 15"],
        [8707] = shared["Patch 5.4.7: Mists PvP Season 15"],
    },
    categories = {
        [8450] = "Other",
        [8451] = "Other",
        [8641] = "Other",
        [8642] = "Other",
        [8658] = "Other",
        [8659] = "Other",
        [8666] = "Other",
        [8667] = "Other",
        [8668] = "Other",
        [8669] = "Other",
        [8670] = "Other",
        [8707] = "Other",
    },
})
