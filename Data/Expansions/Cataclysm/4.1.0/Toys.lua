local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("4.1.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Vrykul Drinking Horn from a rare Vrykul Archaeology project.",
            category = "Professions",
            itemId = 69775,
            name = "Vrykul Drinking Horn",
            source = "a rare Vrykul Archaeology project",
            tips = "Focus Vrykul dig sites in Northrend until the rare solve appears.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
        {
            acquisition = "Obtain Ancient Amber from a rare Fossil Archaeology project.",
            category = "Professions",
            itemId = 69776,
            name = "Ancient Amber",
            source = "a rare Fossil Archaeology project",
            tips = "Keep solving Fossil projects until Ancient Amber appears.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
        {
            acquisition = "Obtain Haunted War Drum from a rare Troll Archaeology project.",
            category = "Professions",
            itemId = 69777,
            name = "Haunted War Drum",
            source = "a rare Troll Archaeology project",
            tips = "Focus Troll dig sites and use Troll Tablets as keystones.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
    },
    details = {
        ["Ancient Amber"] = {
            acquisition = "Obtain Ancient Amber from a rare Fossil Archaeology project.",
            source = "a rare Fossil Archaeology project",
            sourceType = "Toy Box Source",
            tips = "Keep solving Fossil projects until Ancient Amber appears.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
        ["Haunted War Drum"] = {
            acquisition = "Obtain Haunted War Drum from a rare Troll Archaeology project.",
            source = "a rare Troll Archaeology project",
            sourceType = "Toy Box Source",
            tips = "Focus Troll dig sites and use Troll Tablets as keystones.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
        ["Vrykul Drinking Horn"] = {
            acquisition = "Obtain Vrykul Drinking Horn from a rare Vrykul Archaeology project.",
            source = "a rare Vrykul Archaeology project",
            sourceType = "Toy Box Source",
            tips = "Focus Vrykul dig sites in Northrend until the rare solve appears.",
            waypoints = { "/way #84 82.6 25.5 Archaeology trainer", "/way #85 49.0 70.6 Archaeology trainer" },
        },
    },
})
