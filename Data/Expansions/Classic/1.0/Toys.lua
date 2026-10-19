local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("1.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Orb of Deception from rare high-level world and dungeon drops.",
            category = "Drops",
            itemId = 1973,
            name = "Orb of Deception",
            source = "rare high-level world and dungeon drops",
            tips = "The Auction House is usually the efficient route. For self-farming, target dense high-level Vanilla enemies; Colossus of Zora is a notable source when available.",
            waypoints = { "/way #81 48.0 80.0 Silithus high-level world-drop route" },
        },
        {
            acquisition = "Obtain Piccolo of the Flaming Fire from Hearthsinger Forresten in Stratholme.",
            category = "Dungeon and Raids",
            itemId = 13379,
            name = "Piccolo of the Flaming Fire",
            npcId = 10558,
            source = "Hearthsinger Forresten in Stratholme",
            tips = "Hearthsinger Forresten is a rare spawn in Stratholme's main gate section and can appear in more than one location. Clear his spawn points, reset, and repeat.",
            waypoints = { "/way #23 27.1 11.6 Stratholme entrance" },
        },
    },
    details = {
        ["Orb of Deception"] = {
            acquisition = "Obtain Orb of Deception from rare high-level world and dungeon drops.",
            source = "rare high-level world and dungeon drops",
            sourceType = "Toy Box Source",
            tips = "The Auction House is usually the efficient route. For self-farming, target dense high-level Vanilla enemies; Colossus of Zora is a notable source when available.",
            waypoints = { "/way #81 48.0 80.0 Silithus high-level world-drop route" },
        },
        ["Piccolo of the Flaming Fire"] = {
            acquisition = "Obtain Piccolo of the Flaming Fire from Hearthsinger Forresten in Stratholme.",
            source = "Hearthsinger Forresten in Stratholme",
            sourceType = "Toy Box Source",
            tips = "Hearthsinger Forresten is a rare spawn in Stratholme's main gate section and can appear in more than one location. Clear his spawn points, reset, and repeat.",
            waypoints = { "/way #23 27.1 11.6 Stratholme entrance" },
        },
    },
})
