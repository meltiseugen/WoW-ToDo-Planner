local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.2.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Argent Crusader's Banner from Dame Evniki Kapsalis at the Argent Tournament.",
            category = "Vendor",
            itemId = 46843,
            name = "Argent Crusader's Banner",
            npcId = 34885,
            source = "Dame Evniki Kapsalis at the Argent Tournament",
            tips = "Earn the Crusader title, then purchase the banner with Champion's Seals.",
            waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
        },
        {
            acquisition = "Obtain Wormhole Generator: Northrend from Northrend Engineering.",
            category = "Professions",
            itemId = 48933,
            name = "Wormhole Generator: Northrend",
            source = "Northrend Engineering",
            tips = "Learn the schematic from a Northrend Engineering trainer and craft it. Use requires Northrend Engineering and sends you to a chosen Northrend zone.",
            waypoints = { "/way #125 58.6 39.6 Breanni / Magical Menagerie" },
        },
    },
    details = {
        ["Argent Crusader's Banner"] = {
            acquisition = "Obtain Argent Crusader's Banner from Dame Evniki Kapsalis at the Argent Tournament.",
            source = "Dame Evniki Kapsalis at the Argent Tournament",
            sourceType = "Toy Box Source",
            tips = "Earn the Crusader title, then purchase the banner with Champion's Seals.",
            waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
        },
        ["Wormhole Generator: Northrend"] = {
            acquisition = "Obtain Wormhole Generator: Northrend from Northrend Engineering.",
            source = "Northrend Engineering",
            sourceType = "Toy Box Source",
            tips = "Learn the schematic from a Northrend Engineering trainer and craft it. Use requires Northrend Engineering and sends you to a chosen Northrend zone.",
            waypoints = { "/way #125 58.6 39.6 Breanni / Magical Menagerie" },
        },
    },
})
