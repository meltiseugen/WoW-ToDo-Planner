-- Catalogue entries and complete Retail research for 2.4.
local _, TDP = ...

local walkthroughs = {
    [35275] = {
        source = "All four bosses in original Heroic Magisters' Terrace",
        category = "Dungeon and Raids",
        faction = "all",
        requirements = "Access to original Heroic Magisters' Terrace; a character capable of clearing the legacy dungeon. No Blood Elf race or Horde faction requirement.",
        cost = "No purchase cost; daily Heroic loot opportunities per character.",
        tips = "Loot Selin, Vexallus, Delrissa and Kael'thas for four chances per clear. The disguise changes appearance, not faction: opposing guards can still attack you. The Shattrath portal reaches the original island and dungeon in Retail.",
        effect = "Disguises you as a Blood Elf for 5 minutes while showing your equipped appearance; 30-minute cooldown. It changes appearance, not faction access.",
        waypoints = {
            { mapID = 111, x = 0.486, y = 0.42, step = 1, label = "Shattrath portal - original Isle of Quel'Danas" },
            {
                mapID = 122,
                x = 0.612,
                y = 0.309,
                step = 2,
                label = "Original Magisters' Terrace entrance - set Heroic",
                mapName = "Isle of Quel'Danas (original)",
            },
            {
                mapID = 349,
                x = 0.424,
                y = 0.223,
                step = 3,
                label = "Selin Fireheart - first orb chance",
                mapName = "Magisters' Terrace (original): Observation Grounds",
            },
            {
                mapID = 349,
                x = 0.8340000000000001,
                y = 0.264,
                step = 4,
                label = "Vexallus - second orb chance",
                mapName = "Magisters' Terrace (original): Observation Grounds",
            },
            {
                mapID = 348,
                x = 0.397,
                y = 0.557,
                step = 5,
                label = "Priestess Delrissa - third orb chance",
                mapName = "Magisters' Terrace (original): Grand Magister's Asylum",
            },
            {
                mapID = 348,
                x = 0.086,
                y = 0.502,
                step = 6,
                label = "Kael'thas Sunstrider - fourth orb chance",
                mapName = "Magisters' Terrace (original): Grand Magister's Asylum",
            },
        },
        itemId = 35275,
        name = "Orb of the Sin'dorei",
        stepCount = 8,
        acquisition = "Difficulty: Hard - Farm a rare drop from original Heroic Magisters' Terrace, subject to daily boss loot lockouts.\n\n1. Go to Shattrath City in Outland and take the portal at 48.6, 42.0 to the ORIGINAL Isle of Quel'Danas. Post-Midnight Retail comments confirm that this still reaches the Burning Crusade island. Use this route to the legacy dungeon rather than the new Midnight version of Magisters' Terrace.\n\n2. Before entering original Magisters' Terrace at 61.2, 30.9 on Isle of Quel'Danas (#122), set Dungeon Difficulty to HEROIC through your character portrait menu. Check the difficulty after entering. The orb farming route is Heroic, and every one of its four bosses can drop it; do not plan repeated Normal resets for this toy.\n\n3. Follow the entrance route to Selin Fireheart at 42.4, 22.3 on the Observation Grounds floor. Kill him, finish any nearby enemies pulled into the fight, and LOOT his body. He can drop the orb, including in recent Retail reports, so skipping his loot throws away a chance.\n\n4. Continue through the mana-wyrm hall to Vexallus at 83.4, 26.4 on Observation Grounds. Defeat and loot him for another chance. If the encounter lasts long enough to spawn Pure Energy, kill the adds and finish the boss before continuing through the courtyard.\n\n5. On the Grand Magister's Asylum floor, reach Priestess Delrissa at 39.7, 55.7. Defeat her and ALL four companions to complete the encounter and open the way onward. Loot Delrissa; the orb is not exclusive to Kael'thas, despite some older Dungeon Journal interpretations.\n\n6. Enter Kael'thas Sunstrider's chamber at 8.6, 50.2 on Grand Magister's Asylum. Defeat him and loot his body for the fourth chance. If Gravity Lapse begins, move away from the floating damaging spheres and finish him when possible. This run can also supply Swift White Hawkstrider and Phoenix Hatchling, so check the rest of the loot too.\n\n7. If the orb did not drop, use the exit orb behind Kael'thas to leave. Return after the daily Heroic reset or run another eligible character. Reset All Instances does not refresh a completed Heroic lockout. Clear and loot all four bosses on each fresh attempt; no particular boss order or promised number of runs guarantees the toy.\n\n8. Use Orb of the Sin'dorei from your bags to add it to the Toy Box. Both factions can collect and use it. Activate the disguise on the ground; a Blood Elf may see little or no appearance change, but the collection unlock still counts.",
        sourceType = "Dungeon and Raids",
        wowheadUrl = "https://www.wowhead.com/item=35275",
        difficultyReason = "Farm a rare drop from original Heroic Magisters' Terrace, subject to daily boss loot lockouts.",
        difficulty = "hard",
    },
}

TDP.CatalogRegistry:RegisterCollection("2.4", "toys", {
    entries = {
        {
            acquisition = "Obtain Orb of the Sin'dorei from bosses in Heroic Magisters' Terrace.",
            category = "Dungeon and Raids",
            itemId = 35275,
            name = "Orb of the Sin'dorei",
            source = "bosses in Heroic Magisters' Terrace",
            tips = "Reach the original island through Shattrath's portal, enter Heroic Magisters' Terrace, and loot all four bosses for chances at the orb. Heroic loot resets daily per character. The orb disguises you as a Blood Elf.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
            walkthrough = walkthroughs[35275],
        },
    },
    details = {
        ["Orb of the Sin'dorei"] = {
            acquisition = "Obtain Orb of the Sin'dorei from bosses in Heroic Magisters' Terrace.",
            source = "bosses in Heroic Magisters' Terrace",
            sourceType = "Toy Box Source",
            tips = "Reach the original island through Shattrath's portal, enter Heroic Magisters' Terrace, and loot all four bosses for chances at the orb. Heroic loot resets daily per character. The orb disguises you as a Blood Elf.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
    },
})
