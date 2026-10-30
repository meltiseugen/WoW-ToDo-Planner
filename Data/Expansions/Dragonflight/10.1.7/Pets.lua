local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.1.7", "pets", {
    entries = {
        { name = "Arfus", npcId = 203463, source = "Drop: Headless Horseman / Zone: Scarlet Monastery", speciesId = 3491 },
        { name = "Tobias", npcId = 208643, source = "Achievement: Community Rumor Mill / Event: Secrets of Azeroth", speciesId = 4263 },
    },
    details = {
        Arfus = {
            source = "Drop: Headless Horseman / Zone: Scarlet Monastery",
            sourceType = "Pet Journal Source",
        },
        Tobias = {
            acquisition = "Uncover ten community-rumor satchels for Community Rumor Mill.",
            mapAchievementId = 18644,
            source = "Community Rumor Mill",
            sourceType = "Achievement",
            tips = "The Horde and Alliance Grizzly Hills pins are alternatives for the same criterion.",
            waypointCriteria = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 17 },
            waypoints = {
                "/way #23 55.2 59.4 Dirt Mound / Eastern Plaguelands",
                "/way #77 42.2 48.1 Dirt Mound / Felwood underwater",
                "/way #64 42.7 30.6 Dirt Mound / Thousand Needles underwater cave",
                "/way #539 35.3 48.9 Dirt Mound / Shadowmoon Valley",
                "/way #109 26.2 68.5 Dirt Mound / Netherstorm",
                "/way #376 56.7 21.4 Dirt Mound / Valley of the Four Winds",
                "/way #2024 25.2 71.4 Dirt Mound / Azure Span snowman",
                "/way #115 63.9 72.6 Dirt Mound / Dragonblight",
                "/way #10 46.0 50.6 Dirt Mound / Northern Barrens",
                "/way #17 64.6 55.4 Dirt Mound / Blasted Lands",
                "/way #107 57.88 26.33 Dirt Mound / Nagrand floating island",
                "/way #22 68.80 73.25 Dirt Mound / Western Plaguelands",
                "/way #650 53.36 87.52 Dirt Mound / Highmountain",
                "/way #115 73.15 39.48 Dirt Mound / Dragonblight",
                "/way #116 10.9 74.9 Dirt Mound / Horde Satchel route",
                "/way #116 20.2 81.2 Dirt Mound / Alliance Satchel route",
                "/way #554 38.7 54.9 Dirt Mound / Timeless Isle",
                "/way #895 74.6 86.1 Dirt Mound / Tiragarde Sound",
            },
        },
    },
})
