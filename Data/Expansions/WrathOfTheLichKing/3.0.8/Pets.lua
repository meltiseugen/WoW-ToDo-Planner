-- Catalogue entries and complete Retail research for 3.0.8.
local _, TDP = ...

local walkthroughs = {
    [203] = {
        category = "Achievements",
        source = "Lil' Game Hunter - collect 75 unique species",
        sourceAchievementId = 2516,
        sourceComments = { 584665, 1707150, 1838589 },
        requirements = "75 unique collected pet species across your account; duplicates do not add progress.",
        cost = "No reward purchase. Optional vendor pets and Auction House purchases cost gold.",
        tips = "Wild battle-pet captures count. Learn each new species before checking progress; an unlearned cage in your bags does not count. Retail adds this reward directly to the Pet Journal.",
        waypoints = {
            {
                mapID = 109,
                x = 0.435,
                y = 0.35200000000000004,
                step = 2,
                label = "Dealer Rashaad - seven optional missing-species purchases",
                mapName = "Netherstorm",
            },
            {
                mapID = 125,
                x = 0.586,
                y = 0.396,
                step = 3,
                label = "Breanni - optional vendor species for collection progress",
                mapName = "Dalaran (Northrend)",
            },
        },
        itemId = 44841,
        name = "Little Fawn",
        stepCount = 6,
        acquisition = "Difficulty: Medium - Collect the required number of distinct pet species; ordinary vendors and traded pets provide reliable progress.\n\n1. Open Achievements > Pet Battles > Collect and track Lil' Game Hunter. Check Collections > Pet Journal for Little Fawn first. Your target is 75 different collected species, not 75 pets including duplicates.\n\n2. For a compact vendor stop, visit Dealer Rashaad on the upper Stormspire platform in Netherstorm (43.5, 35.2). Compare his seven pets with your journal: Mana Wyrmling, Brown Rabbit, Siamese Cat, Cockroach, Crimson Snake, Red Moth and Blue Dragonhawk Hatchling. Buy and learn only species you are missing.\n\n3. Visit Breanni inside the Magical Menagerie in Northrend Dalaran (58.6, 39.6). Check Calico Cat, Obsidian Hatchling and Albino Snake against your collection. Learning these vendor pets also counts; buying a second color counts only when it is a different journal species.\n\n4. Fill the remaining gap with missing wild species or inexpensive level-1 caged pets. For a wild capture, learn Battle Pet Training from a pet trainer, take a battle team, weaken a capturable opponent until the Trap action is available, and finish the battle after trapping it. Select species marked Not Collected rather than repeatedly capturing the same species.\n\n5. Keep checking the tracked achievement until it reaches 75 unique species. You can combine pets learned on different characters because the journal is shared. You do not need to assemble the entire collection on one character or buy rare promotional pets.\n\n6. Search the Pet Journal for Little Fawn and summon it. The old item/mail instructions on the original reward page predate Retail's automatic journal reward; do not wait for Breanni to mail a carrier or salt lick.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=44841",
        difficultyReason = "Collect the required number of distinct pet species; ordinary vendors and traded pets provide reliable progress.",
        difficulty = "medium",
        description = "A young deer awarded automatically when your account collects 75 different pet species.",
    },
}

TDP.CatalogRegistry:RegisterCollection("3.0.8", "pets", {
    entries = {
        {
            acquisition = walkthroughs[203]["acquisition"],
            category = "Achievements",
            name = "Little Fawn",
            source = "Lil' Game Hunter - collect 75 unique species",
            speciesId = 203,
            tips = walkthroughs[203]["tips"],
            itemId = 44841,
            requirements = "75 unique collected pet species across your account; duplicates do not add progress.",
            cost = "No reward purchase. Optional vendor pets and Auction House purchases cost gold.",
            waypoints = walkthroughs[203]["waypoints"],
            faction = "all",
            sourceAchievementId = 2516,
            description = "A young deer awarded automatically when your account collects 75 different pet species.",
            difficulty = "medium",
            difficultyReason = "Collect the required number of distinct pet species; ordinary vendors and traded pets provide reliable progress.",
            walkthrough = walkthroughs[203],
        },
    },
    details = {
        ["Little Fawn"] = {
            acquisition = walkthroughs[203]["acquisition"],
            source = "Lil' Game Hunter - collect 75 unique species",
            sourceType = "Achievements",
            tips = walkthroughs[203]["tips"],
            itemId = 44841,
            requirements = "75 unique collected pet species across your account; duplicates do not add progress.",
            cost = "No reward purchase. Optional vendor pets and Auction House purchases cost gold.",
            category = "Achievements",
            waypoints = walkthroughs[203]["waypoints"],
            faction = "all",
            sourceAchievementId = 2516,
            description = "A young deer awarded automatically when your account collects 75 different pet species.",
            difficulty = "medium",
            difficultyReason = "Collect the required number of distinct pet species; ordinary vendors and traded pets provide reliable progress.",
        },
    },
})
