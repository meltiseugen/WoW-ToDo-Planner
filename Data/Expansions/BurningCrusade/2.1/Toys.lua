local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.1", "toys", {
    entries = {
        {
            acquisition = "Obtain Time-Lost Figurine from Terokk in Skettis.",
            category = "Rare Drops",
            itemId = 32782,
            name = "Time-Lost Figurine",
            npcId = 21838,
            source = "Terokk in Skettis",
            tips = "Complete Skettis activities for a Time-Lost Offering, summon Terokk at the skull pile, and defeat him. The figurine is a rare drop and transforms you into an arakkoa.",
            waypoints = { "/way #108 64.3 66.2 Grella / Sha'tari Skyguard quartermaster" },
        },
    },
    details = {
        ["Time-Lost Figurine"] = {
            acquisition = "Obtain Time-Lost Figurine from Terokk in Skettis.",
            source = "Terokk in Skettis",
            sourceType = "Toy Box Source",
            tips = "Complete Skettis activities for a Time-Lost Offering, summon Terokk at the skull pile, and defeat him. The figurine is a rare drop and transforms you into an arakkoa.",
            waypoints = { "/way #108 64.3 66.2 Grella / Sha'tari Skyguard quartermaster" },
        },
    },
})
