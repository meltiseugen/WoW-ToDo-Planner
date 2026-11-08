local _, TDP = ...

-- Later achievements tied to this Burning Crusade content patch.
-- Retroactive records moved from Wrath are owned only by the 2.0 bucket.
TDP.CatalogRegistry:RegisterCollection("2.3", "achievements", {
    entries = {
        ids = {
            11708, -- With a Vengeance
        },
        rewardHighlights = {},
    },
    details = {
        [11708] = {
            name = "With a Vengeance",
            acquisition = "Collect 12 Marks of Honor and visit Kitzie Crankshot inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Vengeful Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Kitzie Crankshot / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11708",
            waypoints = { "/way #109 33.0 64.2 Kitzie Crankshot - Vengeful Gladiator armor ensemble" },
        },
    },
    categories = {
        [11708] = "Collections",
    },
})
