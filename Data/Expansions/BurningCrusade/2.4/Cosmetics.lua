-- Catalogue entries and complete Retail research for 2.4.
local _, TDP = ...

local walkthroughs = {
    [35221] = {
        source = "Eldara Dawnrunner - original Isle of Quel'Danas staging area",
        npcId = 25032,
        requirements = "Shattered Sun Offensive Exalted on the buyer; either faction. Use the original island via Shattrath.",
        cost = "1 gold base, before applicable vendor discounts. The title donation is not required.",
        tips = "The map deliberately uses the original Isle of Quel'Danas (#122). The new Midnight island (#2424) and its dungeons are different destinations. Dungeon kills supply the reputation; this tabard itself does not grant championing.",
        waypoints = {
            { mapID = 111, x = 0.49, y = 0.423, step = 2, label = "Shattrath portal - original Isle of Quel'Danas" },
            {
                mapID = 122,
                x = 0.612,
                y = 0.309,
                step = 3,
                label = "Original Magisters' Terrace - Normal reputation farm",
                mapName = "Isle of Quel'Danas (Burning Crusade)",
            },
            {
                mapID = 122,
                x = 0.612,
                y = 0.309,
                step = 4,
                label = "Original Magisters' Terrace - repeat to Exalted",
                mapName = "Isle of Quel'Danas (Burning Crusade)",
            },
            {
                mapID = 122,
                x = 0.47200000000000003,
                y = 0.306,
                step = 5,
                label = "Eldara Dawnrunner - buy Tabard of the Shattered Sun",
                mapName = "Isle of Quel'Danas (Burning Crusade)",
            },
        },
        itemId = 35221,
        name = "Tabard of the Shattered Sun",
        stepCount = 6,
        acquisition = "Difficulty: Medium - Reach Exalted with repeatable legacy dungeon clears, then buy the tabard.\n\n1. Check Shattered Sun Offensive reputation; both factions can collect the tabard. If already Exalted, go to step 5. Use the original Burning Crusade Isle of Quel'Danas, map 122, rather than Midnight's new island and Magisters' Terrace.\n\n2. Go to Shattrath and take the portal to the Isle of Quel'Danas in the Terrace of Light alcove, around 49.0, 42.3. This is the Retail access to the old island even after Midnight. On arrival, pick up available Shattered Sun daily quests if you want to combine questing with the dungeon grind.\n\n3. Set Dungeon Difficulty to NORMAL and enter the original Magisters' Terrace at 61.2, 30.9. Clear the dungeon's trash and bosses through Kael'thas Sunstrider for Shattered Sun Offensive reputation. Use the exit orb after the final boss, leave, reset Normal instances and repeat.\n\n4. Continue Normal clears until Exalted. You can add a Heroic clear and the island dailies between runs; Heroic has a daily boss lockout. The comments' old claim that Normal bosses stop giving reputation at Revered was corrected in its replies. The Sunwell Plateau raid does not supply this reputation, and the old realm-wide island-building stages are not a prerequisite.\n\n5. At Exalted, visit Eldara Dawnrunner inside the building in the Shattered Sun staging area (47.2, 30.6). Buy Tabard of the Shattered Sun for up to 1 gold before discounts. This is the reputation quartermaster, not one of the island's legacy raid-gear vendors.\n\n6. Equip the tabard and check the appearance. You do not need to pay the separate 1,000-gold donation for the 'of the Shattered Sun' title. If you also want the Swift White Hawkstrider, that mount's Heroic drop restriction is separate from this tabard's repeatable Normal reputation route.",
        category = "Reputation",
        sourceType = "Reputation",
        effect = "Cosmetic tabard appearance. Wearing this tabard does not grant faction reputation in dungeons.",
        wowheadUrl = "https://www.wowhead.com/item=35221",
        difficultyReason = "Reach Exalted with repeatable legacy dungeon clears, then buy the tabard.",
        difficulty = "medium",
    },
}

TDP.CatalogRegistry:RegisterCollection("2.4", "cosmetics", {
    entries = {
        {
            detailKey = "shatteredSunTabard",
            itemId = 35221,
            name = "Tabard of the Shattered Sun",
            subtype = "tabard",
            walkthrough = walkthroughs[35221],
        },
    },
    details = { ["Tabard of the Shattered Sun"] = {} },
})
