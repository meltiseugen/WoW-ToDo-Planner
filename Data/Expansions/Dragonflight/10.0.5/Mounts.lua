local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.0.5", "mounts", {
    entries = { { itemId = 192800, name = "Skyskin Hornstrider", spellId = 352926 } },
    details = {
        ["Skyskin Hornstrider"] = {
            acquisition = "Complete Storm's Fury events in Primalist Tomorrow, then buy the mount from Brendormi.",
            category = "Events",
            cost = "150 Essence of the Storm and 3,000 Elemental Overflow.",
            source = "Brendormi / Storm's Fury",
            sourceType = "Event vendor",
            waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" },
        },
    },
})
