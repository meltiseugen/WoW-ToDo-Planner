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
    entries = { ids = { 4786, 4790, 4815, 4816, 4817, 4818 }, rewardHighlights = {} },
    details = {
        [4786] = {
            acquisition = "Complete the historical Alliance pre-Cataclysm liberation event.",
            source = "Operation: Gnomeregan",
            sourceType = "Achievement",
            tips = "The original limited event and its Gnomeregan Pride reward are no longer obtainable.",
            waypoints = { "/way #87 69.0 49.0 Historical event staging area" },
        },
        [4790] = {
            acquisition = "Complete the historical Horde pre-Cataclysm liberation event.",
            source = "Zalazane's Fall",
            sourceType = "Achievement",
            tips = "The original limited event and its Darkspear Pride reward are no longer obtainable.",
            waypoints = { "/way #1 55.8 74.8 Historical event staging area" },
        },
        [4815] = shared["The Ruby Sanctum"],
        [4816] = shared["The Ruby Sanctum"],
        [4817] = shared["The Ruby Sanctum"],
        [4818] = shared["The Ruby Sanctum"],
    },
    categories = { [4786] = "Events", [4790] = "Events", [4815] = "Raids", [4816] = "Raids", [4817] = "Raids", [4818] = "Raids" },
})
