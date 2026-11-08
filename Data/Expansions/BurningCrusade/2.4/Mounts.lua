local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.4", "mounts", {
    entries = {
        {
            acquisition = "Obtain Swift White Hawkstrider from Kael'thas Sunstrider in Heroic Magisters' Terrace.",
            category = "Dungeon and Raids",
            name = "Swift White Hawkstrider",
            npcId = 24664,
            source = "Kael'thas Sunstrider in Heroic Magisters' Terrace",
            spellId = 46628,
            tips = "Defeat Kael'thas on Heroic difficulty. The rare mount can be attempted on each eligible character's daily dungeon lockout.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
        {
            acquisition = "Buy Reins of the Black War Elekk from Lieutenant Karter in Stormwind for 15 Marks of Honor.",
            category = "PvP",
            name = "Black War Elekk",
            npcId = 12783,
            source = "Lieutenant Karter for 15 Marks of Honor",
            spellId = 48027,
            tips = "This is the Alliance PvP elekk. No Exodar reputation or Arena rating is required; Marks of Honor are item tokens, not Honor currency.",
            waypoints = { "/way #84 76.4 65.4 Lieutenant Karter / Stormwind" },
        },
    },
    details = {
        ["Black War Elekk"] = {
            acquisition = "Buy Reins of the Black War Elekk from Lieutenant Karter in Stormwind for 15 Marks of Honor.",
            category = "PvP",
            source = "Lieutenant Karter for 15 Marks of Honor",
            sourceType = "Patch mount collection",
            tips = "This is the Alliance PvP elekk. No Exodar reputation or Arena rating is required; Marks of Honor are item tokens, not Honor currency.",
            waypoints = { "/way #84 76.4 65.4 Lieutenant Karter / Stormwind" },
        },
        ["Swift White Hawkstrider"] = {
            acquisition = "Obtain Swift White Hawkstrider from Kael'thas Sunstrider in Heroic Magisters' Terrace.",
            category = "Dungeon and Raids",
            source = "Kael'thas Sunstrider in Heroic Magisters' Terrace",
            sourceType = "Patch mount collection",
            tips = "Defeat Kael'thas on Heroic difficulty. The rare mount can be attempted on each eligible character's daily dungeon lockout.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
    },
})
