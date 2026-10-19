local _, TDP = ...

local shared = {}
shared["Wintergrasp"] = {
    acquisition = "Complete the listed Wintergrasp vehicle or elemental-control criterion.",
    source = "Wintergrasp",
    sourceType = "Achievement",
    tips = "Track the vehicle and elemental subcriteria across battles; control of the zone changes on the battle cycle.",
    waypoints = { "/way #123 50.0 11.0 Wintergrasp Fortress" },
}

shared["Companion and mount milestones"] = {
    acquisition = "Collect 75 companion pets or 100 mounts under the original account rules.",
    source = "Companion and mount milestones",
    sourceType = "Achievement",
    tips = "Use vendors, reputations, professions, and guaranteed achievement rewards before farming rare drops.",
}

shared["Azeroth critters"] = {
    acquisition = "Find and love or defeat every critter listed in the achievement criteria.",
    source = "Azeroth critters",
    sourceType = "Achievement",
    tips = "Track the list zone by zone and use a targeting macro for small critters.",
}

TDP.CatalogRegistry:RegisterCollection("3.0.8", "achievements", {
    entries = { ids = { 2456, 2476, 2496, 2516, 2536, 2537, 2556, 2557 }, rewardHighlights = { "Little Fawn", "Blue Dragonhawk", "Red Dragonhawk" } },
    details = {
        [2456] = {
            acquisition = "Complete the historical Vampire Hunter criterion during the pre-Wrath invasion.",
            source = "Scourge Invasion",
            sourceType = "Achievement",
            tips = "This limited event achievement is no longer obtainable and remains for historical tracking.",
        },
        [2476] = shared["Wintergrasp"],
        [2496] = shared["Wintergrasp"],
        [2516] = shared["Companion and mount milestones"],
        [2536] = shared["Companion and mount milestones"],
        [2537] = shared["Companion and mount milestones"],
        [2556] = shared["Azeroth critters"],
        [2557] = shared["Azeroth critters"],
    },
    categories = { [2456] = "Events", [2476] = "PvP", [2496] = "PvP", [2516] = "Collections", [2536] = "Collections", [2537] = "Collections", [2556] = "Exploration", [2557] = "Exploration" },
})
