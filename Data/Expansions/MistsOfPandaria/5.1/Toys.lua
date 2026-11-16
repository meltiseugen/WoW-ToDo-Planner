-- Catalogue entries and complete Retail research for 5.1.
local _, TDP = ...

local walkthroughs = {
    [91904] = {
        category = "Vendor",
        source = "Sally Fizzlefury at Nesingwary's Safari",
        description = "Places a stackable stag toy.",
        difficulty = "easy",
        difficultyReason = "A direct vendor purchase without reputation or random loot.",
        cost = "1,000 gold",
        waypoints = {
            {
                mapID = 376,
                x = 0.16,
                y = 0.83,
                step = 1,
                label = "Sally Fizzlefury - Stackable Stag",
                mapName = "Valley of the Four Winds",
            },
        },
        tips = "Sally sells both existing catalogue toys separately; buying one does not teach the other.",
        reviewedAt = "2026-11-13",
        itemId = 91904,
        name = "Stackable Stag",
        wowheadUrl = "https://www.wowhead.com/item=91904",
        sourceType = "Vendor",
        provenance = "Wowhead item 88802 comment 5919263; 91904 comments; NPC 55143 comments 2016547 and reply, 3149332 and replies. Existing source price retained.",
        stepCount = 3,
        acquisition = "Difficulty: Easy - A direct vendor purchase without reputation or random loot.\n\n1. Travel to Nesingwary's Safari in southwest Valley of the Four Winds. Find Sally Fizzlefury, the gnome Engineering trainer, at 16.0,83.0. She is not at Halfhill Market or Galleon's spawn.\n\n2. Open Sally's goods/vendor window rather than only the Engineering training list. Buy Stackable Stag for 1,000 gold. You do not need Engineering to collect these vendor toys.\n\n3. Use the purchased item to add it to the Toy Box. If Sally is unavailable in your current quest phase, finish any active nearby safari introduction and return; a reputation grind is not the normal purchase route.",
    },
}

TDP.CatalogRegistry:RegisterCollection("5.1", "toys", {
    entries = {
        {
            acquisition = walkthroughs[91904]["acquisition"],
            category = "Vendor",
            itemId = 91904,
            name = "Stackable Stag",
            source = "Sally Fizzlefury at Nesingwary's Safari",
            tips = "Sally sells both existing catalogue toys separately; buying one does not teach the other.",
            description = "Places a stackable stag toy.",
            sourceType = "Vendor",
            cost = "1,000 gold",
            waypoints = walkthroughs[91904]["waypoints"],
            difficulty = "easy",
            difficultyReason = "A direct vendor purchase without reputation or random loot.",
            reviewedAt = "2026-11-13",
            wowheadUrl = "https://www.wowhead.com/item=91904",
            walkthrough = walkthroughs[91904],
        },
    },
    details = {
        ["Stackable Stag"] = {
            acquisition = walkthroughs[91904]["acquisition"],
            source = "Sally Fizzlefury at Nesingwary's Safari",
            sourceType = "Vendor",
            tips = "Sally sells both existing catalogue toys separately; buying one does not teach the other.",
            description = "Places a stackable stag toy.",
            category = "Vendor",
            cost = "1,000 gold",
            waypoints = walkthroughs[91904]["waypoints"],
            difficulty = "easy",
            difficultyReason = "A direct vendor purchase without reputation or random loot.",
            reviewedAt = "2026-11-13",
            wowheadUrl = "https://www.wowhead.com/item=91904",
        },
    },
})
