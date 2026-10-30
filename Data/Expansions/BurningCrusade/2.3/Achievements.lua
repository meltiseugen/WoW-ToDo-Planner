local _, TDP = ...

-- Group retroactive achievements with the content they guide.
-- The achievement system arrived later; the original release records
-- remain intact so saved favorites and old patch links keep working.
TDP.CatalogRegistry:RegisterCollection("2.3", "achievements", {
    entries = {
        ids = {
            877, -- The Cake Is Not A Lie
            906, -- Kickin' It Up a Notch
            11708, -- With a Vengeance
        },
        rewardHighlights = {},
    },
    details = {
        [877] = {
            acquisition = "1. Complete cooking daily quests for The Rokk in Shattrath (61.6, 15.8), or your faction's cook in Northrend Dalaran.\n2. Open the daily reward containers until Recipe: Delicious Chocolate Cake drops. Learn the recipe on the character doing this achievement.\n3. Gather its ingredients and personally bake the cake. Buying or eating a finished cake does not satisfy the baking objective.",
            sourceType = "Achievement",
            name = "The Cake Is Not A Lie",
            sourceURL = "https://www.wowhead.com/achievement=877#comments",
            source = "The Rokk / Katherine Lee / Awilo Lon'gomba",
            waypoints = { "/way #111 61.6 15.8 The Rokk - Shattrath cooking daily quests", "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [906] = {
            name = "Kickin' It Up a Notch",
            acquisition = "Complete each of The Rokk's 4 cooking daily quests listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=906",
        },
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
        [877] = "Professions",
        [906] = "Quests",
        [11708] = "Collections",
    },
})
