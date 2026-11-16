-- Catalogue entries and complete Retail research for 3.0.8.
local _, TDP = ...

local walkthroughs = {
    [54437] = {
        description = "Places a small green ragdoll on the ground; 30-minute cooldown.",
        category = "Vendor",
        source = "Jepetto Joybuzz or his Clockwork Assistant - The Wonderworks, Northrend Dalaran",
        npcId = 29478,
        requirements = "Either faction; enough gold for the vendor price.",
        cost = "20 gold before reputation discounts.",
        tips = "The Wonderworks is the toy shop, not Breanni's pet shop. Reputation discounts explain some lower prices quoted in comments. Buy the current item 54437. Older comments may link the replaced item 44849; you do not need that retired version. The green and blue dolls have separate cooldowns.",
        effect = "Places a small green ragdoll on the ground; 30-minute cooldown.",
        waypoints = {
            {
                mapID = 125,
                x = 0.446,
                y = 0.45799999999999996,
                step = 2,
                label = "The Wonderworks - Jepetto and Clockwork Assistant",
                mapName = "Dalaran (Northrend)",
            },
        },
        itemId = 54437,
        name = "Tiny Green Ragdoll",
        stepCount = 4,
        acquisition = "Difficulty: Easy - Buy the inexpensive toy from its year-round Dalaran vendor.\n\n1. Travel to Dalaran above Crystalsong Forest in Northrend. The portal to Crystalsong Forest in your capital's portal room reaches this city; the Dalaran Hearthstone reaches the Legion city instead.\n\n2. Enter The Wonderworks on the western side of Runeweaver Square, around 44.6, 45.8. Speak to Jepetto Joybuzz or the Clockwork Assistant inside the toy shop.\n\n3. Find Tiny Green Ragdoll in the vendor's pages and buy it for 20 gold before Kirin Tor discounts. It is a regular gold purchase; no tournament progress or seasonal event is required.\n\n4. Use Tiny Green Ragdoll from your bags to add it to the account-wide Toy Box. Buy the current item 54437. Older comments may link the replaced item 44849; you do not need that retired version. The green and blue dolls have separate cooldowns.",
        sourceType = "Vendor",
        wowheadUrl = "https://www.wowhead.com/item=54437",
        difficultyReason = "Buy the inexpensive toy from its year-round Dalaran vendor.",
        difficulty = "easy",
    },
}

TDP.CatalogRegistry:RegisterCollection("3.0.8", "toys", {
    entries = {
        {
            acquisition = walkthroughs[54437]["acquisition"],
            category = "Vendor",
            itemId = 54437,
            name = "Tiny Green Ragdoll",
            npcId = 29478,
            source = "Jepetto Joybuzz or his Clockwork Assistant - The Wonderworks, Northrend Dalaran",
            tips = walkthroughs[54437]["tips"],
            waypoints = walkthroughs[54437]["waypoints"],
            requirements = "Either faction; enough gold for the vendor price.",
            cost = "20 gold before reputation discounts.",
            description = "Places a small green ragdoll on the ground; 30-minute cooldown.",
            effect = "Places a small green ragdoll on the ground; 30-minute cooldown.",
            difficulty = "easy",
            difficultyReason = "Buy the inexpensive toy from its year-round Dalaran vendor.",
            walkthrough = walkthroughs[54437],
        },
    },
    details = {
        ["Tiny Green Ragdoll"] = {
            acquisition = walkthroughs[54437]["acquisition"],
            source = "Jepetto Joybuzz or his Clockwork Assistant - The Wonderworks, Northrend Dalaran",
            sourceType = "Vendor",
            tips = walkthroughs[54437]["tips"],
            waypoints = walkthroughs[54437]["waypoints"],
            npcId = 29478,
            requirements = "Either faction; enough gold for the vendor price.",
            cost = "20 gold before reputation discounts.",
            category = "Vendor",
            description = "Places a small green ragdoll on the ground; 30-minute cooldown.",
            effect = "Places a small green ragdoll on the ground; 30-minute cooldown.",
            difficulty = "easy",
            difficultyReason = "Buy the inexpensive toy from its year-round Dalaran vendor.",
        },
    },
})
