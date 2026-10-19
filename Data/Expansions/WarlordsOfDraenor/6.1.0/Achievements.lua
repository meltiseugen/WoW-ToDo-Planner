local _, TDP = ...

local shared = {}
shared["Patch 6.1 legendary and bodyguard adventures"] = {
    acquisition = "Complete Chapter III of Khadgar's legendary quest or the listed bodyguard dungeon journey.",
    source = "Patch 6.1 legendary and bodyguard adventures",
    sourceType = "Achievement",
    tips = "For the bodyguard achievement, keep the same level-3 bodyguard active through every required dungeon; Chapter III's original legendary quest is historical.",
    waypoints = { "/way #582 40.0 37.0 Lunarfall", "/way #590 52.0 50.0 Frostwall" },
}

shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"] = {
    acquisition = "Complete the listed Garrison visitor, invasion, mission, music-roll, relic, follower, or S.E.L.F.I.E. criteria.",
    source = "Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography",
    sourceType = "Achievement",
    tips = "Check rotating visitors and missions daily; use the achievement criteria to plan music-roll and Field Photographer travel efficiently.",
    waypoints = { "/way #582 40.0 37.0 Lunarfall", "/way #590 52.0 50.0 Frostwall" },
}

shared["Heirloom collection"] = {
    acquisition = "Collect and upgrade the listed number or level of heirlooms.",
    source = "Heirloom collection",
    sourceType = "Achievement",
    tips = "Open the Heirlooms tab to confirm which appearances count; Heirloom Hoarder awards the faction-appropriate chauffeured mount.",
}

TDP.CatalogRegistry:RegisterCollection("6.1.0", "achievements", {
    entries = {
        ids = { 9642, 9824, 9825, 9827, 9828, 9833, 9836, 9838, 9858, 9897, 9900, 9901, 9906, 9908, 9909, 9911, 9912, 9914, 9923, 9924, 9928, 10015, 10016 },
        rewardHighlights = { "Chauffeured Mechano-Hog", "Chauffeured Mekgineer's Chopper", "K'ute", "Trans-Dimensional Bird Whistle" },
    },
    details = {
        [9642] = shared["Patch 6.1 legendary and bodyguard adventures"],
        [9824] = {
            acquisition = "Collect all listed pets from Black Temple, Hyjal Summit, and Sunwell Plateau.",
            source = "Raiding with Leashes III: Drinkin' From the Sunwell",
            sourceType = "Achievement",
            tips = "Use eligible alts for additional weekly raid attempts and learn each pet before checking the meta.",
            waypoints = { "/way #104 71.0 46.0 Black Temple", "/way #198 47.0 78.0 Hyjal Summit", "/way #122 44.0 45.0 Sunwell Plateau" },
        },
        [9825] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9827] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9828] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9833] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9836] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9838] = shared["Patch 6.1 legendary and bodyguard adventures"],
        [9858] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9897] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9900] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9901] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9906] = shared["Heirloom collection"],
        [9908] = shared["Heirloom collection"],
        [9909] = shared["Heirloom collection"],
        [9911] = shared["Heirloom collection"],
        [9912] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9914] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9923] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9924] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [9928] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [10015] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
        [10016] = shared["Patch 6.1 Garrison collections, invasions, missions, relics, jukebox, and photography"],
    },
    categories = {
        [9642] = "Questing and Dungeons",
        [9824] = "Pet Battles",
        [9825] = "Garrisons",
        [9827] = "Garrisons",
        [9828] = "Garrisons",
        [9833] = "Garrisons",
        [9836] = "Garrisons",
        [9838] = "Questing and Dungeons",
        [9858] = "Garrisons",
        [9897] = "Garrisons",
        [9900] = "Garrisons",
        [9901] = "Garrisons",
        [9906] = "Collections",
        [9908] = "Collections",
        [9909] = "Collections",
        [9911] = "Collections",
        [9912] = "Garrisons",
        [9914] = "Garrisons",
        [9923] = "Garrisons",
        [9924] = "Garrisons",
        [9928] = "Garrisons",
        [10015] = "Garrisons",
        [10016] = "Garrisons",
    },
})
