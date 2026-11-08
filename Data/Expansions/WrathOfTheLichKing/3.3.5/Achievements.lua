local _, TDP = ...

local shared = {}
shared["The Ruby Sanctum"] = {
    acquisition = "Defeat Halion in the listed 10- or 25-player normal or Heroic mode.",
    source = "The Ruby Sanctum",
    sourceType = "Achievement",
    tips = "Defeat all three lieutenants to spawn Halion. In the final phase, balance damage between the physical and twilight realms.",
    waypoints = { "/way #115 59.8 54.6 Ruby Sanctum entrance" },
}

TDP.CatalogRegistry:RegisterCollection("3.3.5", "achievements", {
    entries = { ids = {
            4815, -- The Twilight Destroyer (25 player)
            4816, -- Heroic: The Twilight Destroyer (25 player)
            4817, -- The Twilight Destroyer (10 player)
            4818, -- Heroic: The Twilight Destroyer (10 player)
        }, rewardHighlights = {} },
    details = {
        [4815] = shared["The Ruby Sanctum"],
        [4816] = shared["The Ruby Sanctum"],
        [4817] = shared["The Ruby Sanctum"],
        [4818] = shared["The Ruby Sanctum"],
    },
    categories = {
        [4815] = "Raids",
        [4816] = "Raids",
        [4817] = "Raids",
        [4818] = "Raids",
    },
})
