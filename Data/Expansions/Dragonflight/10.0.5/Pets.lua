local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.0.5", "pets", {
    entries = { { name = "Time-Lost Vorquin Foal", npcId = 191298, speciesId = 3334 } },
    details = {
        ["Time-Lost Vorquin Foal"] = {
            acquisition = "Complete Storm's Fury events in Primalist Tomorrow, then buy the pet from Brendormi.",
            cost = "105 Essence of the Storm and 1,500 Elemental Overflow.",
            source = "Brendormi / Storm's Fury",
            sourceType = "Event vendor",
            waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" },
        },
    },
})
