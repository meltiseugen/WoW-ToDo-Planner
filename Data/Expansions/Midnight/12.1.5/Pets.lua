local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("12.1.5", "pets", {
    entries = {
        { faction = "all", itemId = 274927, name = "Aqir Wingreaver", npcId = 265755, speciesId = 5068 },
        { faction = "all", itemId = 274923, name = "Aqir Scuttler", npcId = 265740, speciesId = 5066 },
        { faction = "all", itemId = 276927, name = "Aqir Razorwing", npcId = 268483, speciesId = 5100 },
    },
    details = {
        ["Aqir Razorwing"] = {
            acquisition = "Reach Revered with Aqir Research Enclave, then purchase and learn this companion.",
            cost = "2,000 Voidlight Marl.",
            requirements = "Revered with Aqir Research Enclave.",
            reviewedAt = "2026-10-15",
            source = "Estelia Archtender / Aqir Research Enclave",
            sourceType = "Reputation Vendor",
            sourceUrl = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards",
            tips = "All three pets use the same vendor. They are peaceful companion collectibles; do not plan a pet-battle capture route.",
            waypoints = { "/way #2393 39.3 80.3 Estelia Archtender / Aqir Research Enclave" },
        },
        ["Aqir Scuttler"] = {
            acquisition = "Reach Honored with Aqir Research Enclave, then purchase and learn this companion.",
            cost = "1,000 Voidlight Marl.",
            requirements = "Honored with Aqir Research Enclave.",
            reviewedAt = "2026-10-15",
            source = "Estelia Archtender / Aqir Research Enclave",
            sourceType = "Reputation Vendor",
            sourceUrl = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards",
            tips = "All three pets use the same vendor. They are peaceful companion collectibles; do not plan a pet-battle capture route.",
            waypoints = { "/way #2393 39.3 80.3 Estelia Archtender / Aqir Research Enclave" },
        },
        ["Aqir Wingreaver"] = {
            acquisition = "Reach Friendly with Aqir Research Enclave, then purchase and learn this companion.",
            cost = "1,000 Voidlight Marl.",
            requirements = "Friendly with Aqir Research Enclave.",
            reviewedAt = "2026-10-15",
            source = "Estelia Archtender / Aqir Research Enclave",
            sourceType = "Reputation Vendor",
            sourceUrl = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards",
            tips = "All three pets use the same vendor. They are peaceful companion collectibles; do not plan a pet-battle capture route.",
            waypoints = { "/way #2393 39.3 80.3 Estelia Archtender / Aqir Research Enclave" },
        },
    },
})
