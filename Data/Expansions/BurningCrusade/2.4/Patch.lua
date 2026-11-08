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
        "The 2.4 bucket covers the obtainable 2.4.x collection: Isle of Quel'Danas, Magisters' Terrace, Shattered Sun Offensive, Shattrath fishing rewards and the 2.4.3 Nether Ray Fry. Retired original Arena-season rewards are excluded.",
        "The Black War Elekk is included at its documented patch 2.4.0 boundary rather than in the 2.0 racial launch set.",
        "The Swift White Hawkstrider, Phoenix Hatchling, and Orb of the Sin'dorei retain the original Magisters' Terrace entrance and farming guidance; the Shattered Sun tabard points to its island quartermaster.",
        "Trading-card, promotion, recurring holiday, unused, NPC-only and ordinary equipment records are excluded. Shared Burning Crusade-content achievements, including instance clears, Shattered Sun reputation and fishing dailies, are registered in 2.0. This patch retains the Sunwell raid-pet collection meta and the Sunwell and regular Brutal Gladiator appearance-set achievements.",
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
