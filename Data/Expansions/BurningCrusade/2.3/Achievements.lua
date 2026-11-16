-- Catalogue entries and complete Retail research for 2.3.
local _, TDP = ...

local walkthroughs = {
    [11708] = {
        achievementId = 11708,
        name = "With a Vengeance",
        category = "Collections",
        sourceType = "Achievement",
        source = "With a Vengeance",
        acquisition = "Difficulty: Medium - Earn 12 Marks of Honor and learn an ordinary legacy armor ensemble; no historical Arena rating is required.\n\n1. Use a character with an original Burning Crusade class armor set and collect 12 Marks of Honor. These are the item currency from PvP rewards, not the Honor points on the currency tab. No original season rating or title is required.\n\n2. Visit Kitzie Crankshot inside Area 52's PvP-vendor building in Netherstorm (33.0, 64.2). Buy the Vengeful Gladiator ARMOR Ensemble for your class. A weapon Arsenal does not finish the armor-set achievement.\n\n3. Use the Ensemble from your bags to permanently learn the complete set. If you already own most appearances, compare the price of the individual missing pieces before buying the ensemble; the full eight-piece individual purchase costs more than 12 Marks.\n\n4. Check the achievement after learning the set. For individual refundable purchases, wait for the refund timer to expire or permanently bind the items before expecting credit. Do not return them for a refund and assume the appearance remains collected.",
        stepCount = 4,
        waypoints = { { mapID = 109, x = 0.33, y = 0.642, step = 2, label = "Kitzie Crankshot - Vengeful Gladiator armor Ensemble" } },
        tips = "Monks, Death Knights, Demon Hunters and Evokers have no original Burning Crusade class tier; use an eligible original class to collect its class set.",
        sources = { "https://www.wowhead.com/achievement=11708#comments:id=2477571" },
        wowheadUrl = "https://www.wowhead.com/achievement=11708",
        sourceURL = "https://www.wowhead.com/achievement=11708#comments",
        difficultyReason = "Earn 12 Marks of Honor and learn an ordinary legacy armor ensemble; no historical Arena rating is required.",
        difficulty = "medium",
    },
}

TDP.CatalogRegistry:RegisterCollection("2.3", "achievements", {
    entries = { ids = { 11708 }, rewardHighlights = {} },
    details = {
        [11708] = {
            name = "With a Vengeance",
            acquisition = "Collect 12 Marks of Honor and visit Kitzie Crankshot inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Vengeful Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Kitzie Crankshot / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11708",
            waypoints = { "/way #109 33.0 64.2 Kitzie Crankshot - Vengeful Gladiator armor ensemble" },
            walkthrough = walkthroughs[11708],
        },
    },
    categories = { [11708] = "Collections" },
    research = {
        originalNotes = "-- Later achievements tied to this Burning Crusade content patch.\n-- Retroactive records moved from Wrath are owned only by the 2.0 bucket.\n            11708, -- With a Vengeance",
    },
})
