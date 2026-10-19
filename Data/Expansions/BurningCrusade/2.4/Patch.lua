local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.4", {
    cosmeticDetailGroups = {
        shatteredSunTabard = {
            acquisition = "Reach Exalted with the Shattered Sun Offensive and buy the tabard for gold.",
            source = "Eldara Dawnrunner on the Isle of Quel'Danas",
            sourceType = "Reputation vendor",
            tips = "Run Magisters' Terrace and complete Isle daily quests together; both contribute reputation while you farm the dungeon collectibles.",
            waypoints = { "/way #122 47.2 30.6 Eldara Dawnrunner" },
        },
    },
    label = "Fury of the Sunwell",
    sourceNotes = {
        "The 2.4 bucket covers the complete 2.4.x line: Isle of Quel'Danas, Magisters' Terrace, Shattered Sun Offensive, Shattrath fishing rewards, the 2.4.3 Nether Ray Fry, and Arena Seasons 3 and 4.",
        "The Black War Elekk is included at its documented patch 2.4.0 boundary rather than in the 2.0 racial launch set.",
        "The Swift White Hawkstrider, Phoenix Hatchling, and Orb of the Sin'dorei retain the original Magisters' Terrace entrance and farming guidance; the Shattered Sun tabard points to its island quartermaster.",
        "Trading-card, promotion, recurring holiday, unused, NPC-only, and ordinary equipment records are excluded. Achievements did not exist during patch 2.4; later retroactive Sunwell and arena feats remain in the 3.0 achievement-system bucket.",
    },
    sourceUrls = {
        burningCrusadeCollections = "https://news.blizzard.com/en-us/article/23523203/burning-crusade-mounts-pets-and-more",
        magistersTerrace = "https://warcraft.wiki.gg/wiki/Magisters%27_Terrace_loot",
        orb = "https://warcraft.wiki.gg/wiki/Orb_of_the_Sin%27dorei",
        patch = "https://warcraft.wiki.gg/wiki/Patch_2.4.0",
        tabard = "https://warcraft.wiki.gg/wiki/Tabard_of_the_Shattered_Sun",
    },
    wowheadPatchId = 20400,
})
