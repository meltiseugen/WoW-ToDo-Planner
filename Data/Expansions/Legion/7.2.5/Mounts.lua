-- Catalogue entries and complete Retail research for 7.2.5.
local _, TDP = ...

local walkthroughs = {
    [232519] = {
        category = "Dungeon and Raids",
        mountCategory = "Drops",
        source = "Mistress Sassz'ine, Tomb of Sargeras (Raid Finder, Normal, Heroic or Mythic)",
        description = "A rare legacy raid mount. The original current-content guaranteed-drop rules, where applicable, have ended.",
        difficulty = "hard",
        difficultyReason = "Weekly loot limits and a low random drop chance can require many resets.",
        commentIds = { 2474949 },
        tips = "The map pin is the entrance, not the boss's room. Do not spend Seal of Broken Fate bonus rolls expecting these mounts. An existing learned mount does not prevent additional raid copies from dropping.",
        waypoints = {
            { mapID = 646, x = 0.6459999999999999, y = 0.168, step = 2, label = "Tomb of Sargeras - raid entrance" },
            { mapID = 627, x = 0.637, y = 0.55, step = 2, label = "Archmage Timear - The Gates of Hell" },
        },
        reviewedAt = "2026-11-15",
        itemId = 143643,
        name = "Abyss Worm",
        wowheadUrl = "https://www.wowhead.com/item=143643",
        sourceUrls = { "https://www.wowhead.com/item=143643" },
        sourceType = "Dungeon and Raids",
        stepCount = 4,
        acquisition = "Difficulty: Hard - Weekly loot limits and a low random drop chance can require many resets.\n\n1. Choose a high-level character and the correct raid difficulty: Raid Finder, Normal, Heroic or Mythic. Travel to the Broken Isles zone marked on the map. Legacy combat is easier above the expansion's level range.\n\n2. Enter Tomb of Sargeras at the marked entrance and clear to Mistress Sassz'ine. For the optional LFR chance, speak to Archmage Timear outside Violet Hold in Legion Dalaran and choose The Gates of Hell.\n\n3. Defeat Mistress Sassz'ine and loot the boss or its reward chest. Abyss Worm is a random drop now, including on an otherwise trivial legacy kill. In a group, agree who receives a mount drop before starting; shared legacy loot is not one guaranteed personal mount per player.\n\n4. Learn the mount if it drops. Otherwise use another eligible character or return after the weekly reset. Normal, Heroic, Mythic and LFR loot opportunities are separate where this particular mount is eligible; repeating a looted difficulty on the same character is not another mount roll.",
    },
}

TDP.CatalogRegistry:RegisterCollection("7.2.5", "mounts", {
    entries = {
        {
            acquisition = walkthroughs[232519]["acquisition"],
            category = "Drops",
            name = "Abyss Worm",
            source = "Mistress Sassz'ine, Tomb of Sargeras (Raid Finder, Normal, Heroic or Mythic)",
            spellId = 232519,
            tips = walkthroughs[232519]["tips"],
            waypoints = walkthroughs[232519]["waypoints"],
            itemId = 143643,
            description = "A rare legacy raid mount. The original current-content guaranteed-drop rules, where applicable, have ended.",
            sourceType = "Dungeon and Raids",
            difficulty = "hard",
            difficultyReason = "Weekly loot limits and a low random drop chance can require many resets.",
            reviewedAt = "2026-11-15",
            wowheadUrl = "https://www.wowhead.com/item=143643",
            sourceUrls = walkthroughs[232519]["sourceUrls"],
            commentIds = walkthroughs[232519]["commentIds"],
            walkthrough = walkthroughs[232519],
        },
    },
    details = {
        ["Abyss Worm"] = {
            acquisition = walkthroughs[232519]["acquisition"],
            category = "Drops",
            source = "Mistress Sassz'ine, Tomb of Sargeras (Raid Finder, Normal, Heroic or Mythic)",
            sourceType = "Dungeon and Raids",
            tips = walkthroughs[232519]["tips"],
            waypoints = walkthroughs[232519]["waypoints"],
            itemId = 143643,
            description = "A rare legacy raid mount. The original current-content guaranteed-drop rules, where applicable, have ended.",
            difficulty = "hard",
            difficultyReason = "Weekly loot limits and a low random drop chance can require many resets.",
            reviewedAt = "2026-11-15",
            wowheadUrl = "https://www.wowhead.com/item=143643",
            sourceUrls = walkthroughs[232519]["sourceUrls"],
            commentIds = walkthroughs[232519]["commentIds"],
        },
    },
})
