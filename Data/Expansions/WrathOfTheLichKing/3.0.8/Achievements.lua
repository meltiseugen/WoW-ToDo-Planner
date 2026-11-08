local _, TDP = ...

local shared = {}
shared["Wintergrasp"] = {
    acquisition = "Complete the listed Wintergrasp vehicle or elemental-control criterion.",
    source = "Wintergrasp",
    sourceType = "Achievement",
    tips = "Track the vehicle and elemental subcriteria across battles; control of the zone changes on the battle cycle.",
    waypoints = { "/way #123 50.0 11.0 Wintergrasp Fortress" },
}

shared["Azeroth critters"] = {
    acquisition = "Find and love or defeat every critter listed in the achievement criteria.",
    source = "Azeroth critters",
    sourceType = "Achievement",
    tips = "Track the list zone by zone and use a targeting macro for small critters.",
}

TDP.CatalogRegistry:RegisterCollection("3.0.8", "achievements", {
    entries = { ids = {
            2476, -- Destruction Derby
            2557, -- To All The Squirrels Who Shared My Life
        }, rewardHighlights = { "Little Fawn", "Blue Dragonhawk", "Red Dragonhawk" } },
    details = {
        [2476] = shared["Wintergrasp"],
        [2557] = shared["Azeroth critters"],
    },
    categories = {
        [2476] = "PvP",
        [2557] = "Exploration",
    },
})
