local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.1", "pets", {
    entries = {
        {
            acquisition = "Obtain Firefly from Bogflare Needlers in Zangarmarsh.",
            category = "Rare Drops",
            name = "Firefly",
            npcId = 20197,
            source = "Bogflare Needlers in Zangarmarsh",
            speciesId = 146,
            tips = "Farm Bogflare Needlers around the marked northern Zangarmarsh routes. Captured Firefly has a very low drop rate, so a fast circular route and loot-a-rang help.",
            waypoints = { "/way #102 42.0 31.0 Bogflare Needler route", "/way #102 30.0 38.0 Bogflare Needler route" },
        },
    },
    details = {
        Firefly = {
            acquisition = "Obtain Firefly from Bogflare Needlers in Zangarmarsh.",
            source = "Bogflare Needlers in Zangarmarsh",
            sourceType = "Pet Journal Source",
            tips = "Farm Bogflare Needlers around the marked northern Zangarmarsh routes. Captured Firefly has a very low drop rate, so a fast circular route and loot-a-rang help.",
            waypoints = { "/way #102 42.0 31.0 Bogflare Needler route", "/way #102 30.0 38.0 Bogflare Needler route" },
        },
    },
})
