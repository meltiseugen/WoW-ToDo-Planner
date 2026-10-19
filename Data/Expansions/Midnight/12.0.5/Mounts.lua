local _, TDP = ...

local shared = {}
shared["Amethyst Mechsuit waypoints"] = {
    "/way #2393 42.2 58.4 Lindormi / Timelost Saddle vendor",
    "/way #2393 42.2 58.8 Lindormi / alternate Silvermoon position",
    "/way #2339 53.8 39.0 Lindormi / Dornogal",
    "/way #2112 53.0 56.8 Lindormi / Valdrakken",
    "/way #2112 53.2 56.2 Lindormi / alternate Valdrakken position",
}

shared["Lindormi / Timelost Saddle"] = {
    acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.",
    category = "Dungeon and Raids",
    source = "Lindormi / Timelost Saddle",
    sourceType = "Seasonal rating reward",
    waypoints = shared["Amethyst Mechsuit waypoints"],
}

shared["Dusk-Painted Sun Roc waypoints"] = {
    "/way #2393 48.77 78.02 Trading Post / Silvermoon City",
    "/way #2339 44.4 55.8 Trading Post / Dornogal",
    "/way #84 51.0 71.8 T&W Trading Post / Stormwind",
    "/way #85 48.4 76.0 Zen'shiri Trading Post / Orgrimmar",
}

shared["Future / patch-filtered Trading Post"] = {
    acquisition = "Patch-filtered mount with Trading Post-style availability; check monthly inventory and Outlet returns.",
    category = "Trading Post",
    source = "Future / patch-filtered Trading Post",
    sourceType = "Trading Post",
    waypoints = shared["Dusk-Painted Sun Roc waypoints"],
}

shared["China / Crimson Tide Treasure"] = {
    acquisition = "China-region promotional reward; no general-region in-world source is available.",
    category = "Promotion",
    source = "China / Crimson Tide Treasure",
    sourceType = "Regional promotion",
}

shared["Patch-filtered shop mount"] = {
    acquisition = "Purchase availability is handled through the shop, so there is no in-world map source.",
    category = "In-Game Shop",
    source = "Patch-filtered shop mount",
    sourceType = "Battle.net Shop",
}

shared["Wowhead 12.0.5 mount filter"] = {
    acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet.",
    category = "Other",
    source = "Wowhead 12.0.5 mount filter",
    sourceType = "Placeholder",
}

TDP.CatalogRegistry:RegisterCollection("12.0.5", "mounts", {
    entries = {
        { itemId = 257225, name = "Witherbark Warbear Mother", spellId = 1261362 },
        { itemId = 269659, name = "The Sire's Palanquin", spellId = 1266982 },
        { itemId = 262344, name = "Scarlet Lady", spellId = 1267077 },
        { itemId = 264348, name = "Unbound Manawyrm", spellId = 1271698 },
        { itemId = 268360, name = "Gilnean Iron Charger", spellId = 1282268 },
        { itemId = 268362, name = "Gilnean Copper Charger", spellId = 1282274 },
        { itemId = 268363, name = "Pyrewood Rebel's Rouncey", spellId = 1282275 },
        { itemId = 268364, name = "Gilneas Loyalist's Rouncey", spellId = 1282276 },
        { itemId = 268472, name = "Blossomback Arboon", spellId = 1282450 },
        { itemId = 268474, name = "Amberback Arboon", spellId = 1282453 },
        { itemId = 268481, name = "Breaker Bee", spellId = 1282471 },
        { itemId = 268578, name = "Void-Corrupted Hawkstrider", spellId = 1282936 },
        { itemId = 268833, name = "Zothwing Darkseeker", spellId = 1283837 },
        { itemId = 268834, name = "Zothwing Deepseeker", spellId = 1283838 },
        { itemId = 268878, name = "[PH] Giant Eagle Sunwalker Mount Blue", spellId = 1283906 },
        { itemId = 268877, name = "Dusk-Painted Sun Roc", spellId = 1283908 },
        { itemId = 268876, name = "Flame-Painted Sun Roc", spellId = 1283910 },
        { itemId = 268875, name = "[PH] Giant Eagle Sunwalker Mount White", spellId = 1283911 },
        { itemId = 269012, name = "Sha-Warped Riding Wolf", spellId = 1284679 },
        { itemId = 269640, name = "Sha-Warped Owl", spellId = 1285897 },
        { itemId = 269828, name = "Void-Corrupted Hex Eagle", spellId = 1286606 },
        { itemId = 270041, name = "Void-Touched Snapdragon", spellId = 1287357 },
        { itemId = 270058, name = "Void-Corrupted Lynx", spellId = 1287359 },
        { itemId = 275440, name = "Cerulean Deathwalker", spellId = 1296731 },
        { itemId = 275442, name = "Amethyst Mechsuit", spellId = 1296734 },
        { itemId = 275444, name = "Blue-Chip Shreddertank", spellId = 1296756 },
        { itemId = 275445, name = "Profit-Green Shreddertank", spellId = 1296758 },
        { itemId = 275446, name = "High-Yield Shreddertank", spellId = 1296759 },
        { itemId = 275447, name = "Speculative Shreddertank", spellId = 1296760 },
    },
    details = {
        ["Amberback Arboon"] = {
            acquisition = "Purchase the Amberback Arboon through the Battle.net Shop; there is no in-world location.",
            category = "In-Game Shop",
            source = "Azeroth Blossoms Anew",
            sourceType = "Battle.net Shop",
        },
        ["Amethyst Mechsuit"] = shared["Lindormi / Timelost Saddle"],
        ["Blossomback Arboon"] = {
            acquisition = "Purchase the Blossomback Arboon through the Battle.net Shop; there is no in-world location.",
            category = "In-Game Shop",
            source = "Azeroth Blossoms Anew",
            sourceType = "Battle.net Shop",
        },
        ["Blue-Chip Shreddertank"] = shared["Lindormi / Timelost Saddle"],
        ["Breaker Bee"] = {
            acquisition = "Originally bought as Magister's Spell Bee Comb for 600 Illusionary Coins from Gamesmaster Fleurian.",
            category = "Vendor",
            source = "Gamesmaster Fleurian",
            sourceType = "Decor Duels",
            tips = "Decor Duels was removed in Patch 12.1, and Blizzard did not confirm a replacement source for the mount. Treat it as currently unavailable unless the reward returns.",
            waypoints = { "/way #2393 31.6 76.7 Gamesmaster Fleurian / Decor Duels rewards" },
        },
        ["Cerulean Deathwalker"] = shared["Lindormi / Timelost Saddle"],
        ["Dusk-Painted Sun Roc"] = {
            acquisition = "Originally sold for 700 Trader's Tender in June 2026. Check future Trading Post or Outlet returns.",
            category = "Trading Post",
            source = "June 2026 Trading Post",
            sourceType = "Trading Post",
            waypoints = shared["Dusk-Painted Sun Roc waypoints"],
        },
        ["Flame-Painted Sun Roc"] = {
            acquisition = "Awarded for completing the June 2026 Traveler's Log. It is no longer in the active monthly reward slot; watch for a future return.",
            category = "Trading Post",
            source = "June 2026 Traveler's Log",
            sourceType = "Traveler's Log",
            waypoints = shared["Dusk-Painted Sun Roc waypoints"],
        },
        ["Gilnean Copper Charger"] = shared["Future / patch-filtered Trading Post"],
        ["Gilnean Iron Charger"] = shared["Future / patch-filtered Trading Post"],
        ["Gilneas Loyalist's Rouncey"] = shared["Future / patch-filtered Trading Post"],
        ["High-Yield Shreddertank"] = shared["Lindormi / Timelost Saddle"],
        ["Profit-Green Shreddertank"] = shared["Lindormi / Timelost Saddle"],
        ["Pyrewood Rebel's Rouncey"] = shared["Future / patch-filtered Trading Post"],
        ["Scarlet Lady"] = shared["China / Crimson Tide Treasure"],
        ["Sha-Warped Owl"] = shared["China / Crimson Tide Treasure"],
        ["Sha-Warped Riding Wolf"] = shared["China / Crimson Tide Treasure"],
        ["Speculative Shreddertank"] = shared["Lindormi / Timelost Saddle"],
        ["The Sire's Palanquin"] = shared["China / Crimson Tide Treasure"],
        ["Unbound Manawyrm"] = {
            acquisition = "Complete Void Response Team and Ritual Site Disruptor, then buy from Sergeant Vornin for 6000 Voidlight Marl.",
            category = "Vendor",
            source = "Sergeant Vornin",
            sourceType = "Vendor",
            tips = "Both metas span weekly rotations: the assault requires Eversong and Zul'Aman, while only one Ritual Site is active each week.",
            waypoints = { "/way #2393 48.6 50.6 Sergeant Vornin / Void Assault and Ritual Site rewards" },
        },
        ["Void-Corrupted Hawkstrider"] = {
            acquisition = "Reach Ritual Sites Renown 8, then buy from Sergeant Vornin for 4500 Voidlight Marl.",
            category = "Vendor",
            source = "Sergeant Vornin",
            sourceType = "Vendor",
            waypoints = { "/way #2393 48.6 50.6 Sergeant Vornin / Void Assault and Ritual Site rewards" },
        },
        ["Void-Corrupted Hex Eagle"] = {
            acquisition = "In Broken Throne Tier 2 or higher, carry the nearby Misplaced Ritual Candle to the ritual circle, activate the candles, and kill the summoned Hex Eagle for a chance at the mount.",
            category = "Rare Drops",
            source = "Broken Throne",
            sourceType = "Ritual Site drop",
            tips = "Learn this mount before attempting the Void-Scarred Eaglet secret in the tornado nest.",
            waypoints = { "/way #2585 50.6 47.3 Ritual Circle / Void-Corrupted Hex Eagle", "/way #2585 51.5 47.8 Misplaced Ritual Candle" },
        },
        ["Void-Corrupted Lynx"] = {
            acquisition = "Crafted by Leatherworking. Both the Rope Lynx Harness pattern and the Broken Lynx Leash bind-on-pickup material come from Treasure and Rare Spoils in Ritual Sites.",
            category = "Professions",
            source = "Rope Lynx Harness",
            sourceType = "Leatherworking",
            waypoints = { "/way #2395 34.9 65.4 Daggerspine Point Ritual Site", "/way #2437 29.7 78.2 Broken Throne Ritual Site" },
        },
        ["Void-Touched Snapdragon"] = {
            acquisition = "During a Daggerspine Point run, click Washed Up Kelp around the interior shoreline; a kelp can spawn the Void-Touched Snapdragon rare, which has a chance to drop the mount.",
            category = "Rare Drops",
            source = "Daggerspine Point",
            sourceType = "Ritual Site drop",
            tips = "The updated Ritual Site guide lists this on any difficulty. Sweep every marked internal kelp point because only a small number may be active in a run.",
            waypoints = {
                "/way #2594 46.0 45.0 Washed Up Kelp",
                "/way #2594 50.0 54.0 Washed Up Kelp",
                "/way #2594 61.0 77.0 Washed Up Kelp",
                "/way #2594 47.0 72.0 Washed Up Kelp",
                "/way #2594 66.0 74.0 Washed Up Kelp",
                "/way #2594 41.0 73.0 Washed Up Kelp",
                "/way #2594 38.0 64.0 Washed Up Kelp",
                "/way #2594 53.0 55.0 Washed Up Kelp",
                "/way #2594 30.1 63.1 Soggy Nest / Void-Corrupted Snapdragon",
            },
        },
        ["Witherbark Warbear Mother"] = {
            acquisition = "In Tier 2 or higher, feed 1 Practically Pork to the Lost Bear Cub to obtain Chubs. Bring 5 more pork to the northern meat piles with Chubs summoned, spawn the Angry Amani Warbear, and defeat it for the mount chance.",
            category = "Rare Drops",
            source = "Broken Throne",
            sourceType = "Ritual Site secret",
            tips = "Gather all 6 Practically Pork before starting so you can complete the pet prerequisite and mount event in the same run.",
            waypoints = { "/way #2585 55.8 49.6 Lost Bear Cub", "/way #2585 55.8 38.8 Angry Amani Warbear" },
        },
        ["Zothwing Darkseeker"] = shared["Patch-filtered shop mount"],
        ["Zothwing Deepseeker"] = shared["Patch-filtered shop mount"],
        ["[PH] Giant Eagle Sunwalker Mount Blue"] = shared["Wowhead 12.0.5 mount filter"],
        ["[PH] Giant Eagle Sunwalker Mount White"] = shared["Wowhead 12.0.5 mount filter"],
    },
})
