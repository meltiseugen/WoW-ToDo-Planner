local _, TDP = ...

-- Later achievements tied to this Burning Crusade content patch.
-- Retroactive records moved from Wrath are owned only by the 2.0 bucket.
TDP.CatalogRegistry:RegisterCollection("2.1", "achievements", {
    entries = {
        ids = {
            11707, -- No Mercy
            11748, -- Black is the New Black
        },
        rewardHighlights = {},
    },
    details = {
        [11707] = {
            name = "No Mercy",
            acquisition = "Collect 12 Marks of Honor and visit Izzee the 'Clutch' inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Merciless Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Izzee the 'Clutch' / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11707",
            waypoints = { "/way #109 33.0 64.2 Izzee the 'Clutch' - Merciless Gladiator armor ensemble" },
        },
        [11748] = {
            name = "Black is the New Black",
            acquisition = "Collect any class armor set from Black Temple. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Black Temple",
            sourceURL = "https://www.wowhead.com/achievement=11748",
            waypoints = { "/way #104 71 46.5 Black Temple entrance" },
        },
    },
    categories = {
        [11707] = "Collections",
        [11748] = "Collections",
    },
})
