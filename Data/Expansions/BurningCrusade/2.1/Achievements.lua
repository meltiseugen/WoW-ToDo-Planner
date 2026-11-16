-- Catalogue entries and complete Retail research for 2.1.
local _, TDP = ...

local walkthroughs = {
    [11707] = {
        achievementId = 11707,
        name = "No Mercy",
        category = "Collections",
        sourceType = "Achievement",
        source = "No Mercy",
        acquisition = "Difficulty: Medium - Earn 12 Marks of Honor and learn an ordinary legacy armor ensemble; no historical Arena rating is required.\n\n1. Use a character with an original Burning Crusade class armor set and collect 12 Marks of Honor. These are the item currency from PvP rewards, not the Honor points on the currency tab. No original season rating or title is required.\n\n2. Visit Izzee the 'Clutch' inside Area 52's PvP-vendor building in Netherstorm (33.0, 64.2). Buy the Merciless Gladiator ARMOR Ensemble for your class. A weapon Arsenal does not finish the armor-set achievement.\n\n3. Use the Ensemble from your bags to permanently learn the complete set. If you already own most appearances, compare the price of the individual missing pieces before buying the ensemble; the full eight-piece individual purchase costs more than 12 Marks.\n\n4. Check the achievement after learning the set. For individual refundable purchases, wait for the refund timer to expire or permanently bind the items before expecting credit. Do not return them for a refund and assume the appearance remains collected.",
        stepCount = 4,
        waypoints = {
            { mapID = 109, x = 0.33, y = 0.642, step = 2, label = "Izzee the 'Clutch' - Merciless Gladiator armor Ensemble" },
        },
        tips = "Monks, Death Knights, Demon Hunters and Evokers have no original Burning Crusade class tier; use an eligible original class to collect its class set.",
        sources = { "https://www.wowhead.com/achievement=11707#comments:id=2477567" },
        wowheadUrl = "https://www.wowhead.com/achievement=11707",
        sourceURL = "https://www.wowhead.com/achievement=11707#comments",
        difficultyReason = "Earn 12 Marks of Honor and learn an ordinary legacy armor ensemble; no historical Arena rating is required.",
        difficulty = "medium",
    },
    [11748] = {
        achievementId = 11748,
        name = "Black is the New Black",
        category = "Collections",
        sourceType = "Achievement",
        source = "Black is the New Black",
        acquisition = "Difficulty: Hard - Collect a complete class appearance set through random weekly raid drops and the relevant token exchanges.\n\n1. Open Collections > Appearances > Sets and select a complete Tier 6 / Black Temple appearance set for an original Burning Crusade class. Pin down its missing slots before farming; five tier pieces alone may leave required matching boots, belt or bracers unfinished.\n\n2. In Battle for Mount Hyjal inside the Caverns of Time, finish the camp waves and kill Azgalor for gloves and Archimonde for the helm. Outdoor Cataclysm Hyjal is the wrong map.\n\n3. In original Black Temple, kill Mother Shahraz for shoulders, the Illidari Council for legs and Illidan for the chest. This appearance set combines Hyjal and Black Temple; the three later Sunwell tier extensions belong to a separate appearance achievement.\n\n4. Use eligible class tokens to create the armor, choosing the appropriate loot specialization. Where a token offers a choice, collect the PvE appearance, not its alternative PvP reward. A modern class with no original tier set cannot create that old class's tier pieces for itself.\n\n5. For every remaining slot in the SETS tab, inspect its specific appearance source and farm or craft that item. Matching off-pieces vary by class. Repeat after weekly resets for random drops; the armor set's visual checklist, not just its set-bonus count, is the goal.\n\n6. Permanently learn the final appearances. A trade/refund timer can delay credit. If all slots are learned but the achievement has not refreshed, relog; comments also report applying the complete set as a transmog refreshes credit. Do not buy or delete duplicate items before checking the actual missing slot.",
        stepCount = 6,
        waypoints = {
            {
                mapID = 75,
                x = 0.36,
                y = 0.161,
                step = 2,
                label = "Battle for Mount Hyjal - helm / gloves",
                mapName = "Caverns of Time",
            },
            { mapID = 329, x = 0.3574, y = 0.3785, step = 2, label = "Azgalor - glove tokens", mapName = "Hyjal Summit" },
            {
                mapID = 329,
                x = 0.7728,
                y = 0.28309999999999996,
                step = 2,
                label = "Archimonde - helm tokens",
                mapName = "Hyjal Summit",
            },
            { mapID = 104, x = 0.71, y = 0.465, step = 3, label = "Black Temple - shoulders / legs / chest" },
            {
                mapID = 344,
                x = 0.6754000000000001,
                y = 0.3677,
                step = 3,
                label = "Mother Shahraz - shoulder tokens",
                mapName = "Black Temple - Den of Mortal Delights",
            },
            {
                mapID = 345,
                x = 0.4733,
                y = 0.4385,
                step = 3,
                label = "Illidari Council - leg tokens",
                mapName = "Black Temple - Chamber of Command",
            },
            {
                mapID = 346,
                x = 0.5277000000000001,
                y = 0.7045999999999999,
                step = 3,
                label = "Illidan - chest tokens",
                mapName = "Black Temple - Temple Summit",
            },
        },
        sources = {
            "https://www.wowhead.com/achievement=11748#comments:id=2479720",
            "https://www.wowhead.com/achievement=11748#comments",
        },
        wowheadUrl = "https://www.wowhead.com/achievement=11748",
        sourceURL = "https://www.wowhead.com/achievement=11748#comments",
        difficultyReason = "Collect a complete class appearance set through random weekly raid drops and the relevant token exchanges.",
        difficulty = "hard",
    },
}

TDP.CatalogRegistry:RegisterCollection("2.1", "achievements", {
    entries = { ids = { 11707, 11748 }, rewardHighlights = {} },
    details = {
        [11707] = {
            name = "No Mercy",
            acquisition = "Collect 12 Marks of Honor and visit Izzee the 'Clutch' inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Merciless Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Izzee the 'Clutch' / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11707",
            waypoints = { "/way #109 33.0 64.2 Izzee the 'Clutch' - Merciless Gladiator armor ensemble" },
            walkthrough = walkthroughs[11707],
        },
        [11748] = {
            name = "Black is the New Black",
            acquisition = "Collect any class armor set from Black Temple. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Black Temple",
            sourceURL = "https://www.wowhead.com/achievement=11748",
            waypoints = { "/way #104 71 46.5 Black Temple entrance" },
            walkthrough = walkthroughs[11748],
        },
    },
    categories = { [11707] = "Collections", [11748] = "Collections" },
    research = {
        originalNotes = "-- Later achievements tied to this Burning Crusade content patch.\n-- Retroactive records moved from Wrath are owned only by the 2.0 bucket.\n            11707, -- No Mercy\n            11748, -- Black is the New Black",
    },
})
