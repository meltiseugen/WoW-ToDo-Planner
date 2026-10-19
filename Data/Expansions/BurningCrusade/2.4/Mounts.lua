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
            acquisition = "Obtain Black War Elekk from Raider Bork for honor.",
            category = "PvP",
            name = "Black War Elekk",
            npcId = 12796,
            source = "Raider Bork for honor",
            spellId = 48027,
            tips = "Purchase the blood elf PvP mount with honor from Raider Bork. It was added in patch 2.4.0 alongside the matching racial war mounts.",
            waypoints = { "/way #85 38.8 70.0 Raider Bork / Orgrimmar" },
        },
        {
            acquisition = "Obtain Vengeful Nether Drake from the top-ranked Arena Season 3 reward.",
            category = "PvP",
            name = "Vengeful Nether Drake",
            source = "the top-ranked Arena Season 3 reward",
            spellId = 49193,
            tips = "This original top-0.5-percent arena reward was added in patch 2.4.2 and is no longer obtainable.",
        },
        {
            acquisition = "Obtain Brutal Nether Drake from the top-ranked Arena Season 4 reward.",
            category = "PvP",
            name = "Brutal Nether Drake",
            source = "the top-ranked Arena Season 4 reward",
            spellId = 58615,
            tips = "This original top-0.5-percent arena reward belongs to the 2.4.3 season and is no longer obtainable.",
        },
    },
    details = {
        ["Black War Elekk"] = {
            acquisition = "Obtain Black War Elekk from Raider Bork for honor.",
            category = "PvP",
            source = "Raider Bork for honor",
            sourceType = "Patch mount collection",
            tips = "Purchase the blood elf PvP mount with honor from Raider Bork. It was added in patch 2.4.0 alongside the matching racial war mounts.",
            waypoints = { "/way #85 38.8 70.0 Raider Bork / Orgrimmar" },
        },
        ["Brutal Nether Drake"] = {
            acquisition = "Obtain Brutal Nether Drake from the top-ranked Arena Season 4 reward.",
            category = "PvP",
            source = "the top-ranked Arena Season 4 reward",
            sourceType = "Patch mount collection",
            tips = "This original top-0.5-percent arena reward belongs to the 2.4.3 season and is no longer obtainable.",
        },
        ["Swift White Hawkstrider"] = {
            acquisition = "Obtain Swift White Hawkstrider from Kael'thas Sunstrider in Heroic Magisters' Terrace.",
            category = "Dungeon and Raids",
            source = "Kael'thas Sunstrider in Heroic Magisters' Terrace",
            sourceType = "Patch mount collection",
            tips = "Defeat Kael'thas on Heroic difficulty. The rare mount can be attempted on each eligible character's daily dungeon lockout.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
        ["Vengeful Nether Drake"] = {
            acquisition = "Obtain Vengeful Nether Drake from the top-ranked Arena Season 3 reward.",
            category = "PvP",
            source = "the top-ranked Arena Season 3 reward",
            sourceType = "Patch mount collection",
            tips = "This original top-0.5-percent arena reward was added in patch 2.4.2 and is no longer obtainable.",
        },
    },
})
