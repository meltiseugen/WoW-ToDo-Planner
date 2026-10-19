local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("1.4", "toys", {
    entries = {
        {
            acquisition = "Obtain World Enlarger from Gnomish Engineering.",
            category = "Professions",
            itemId = 18660,
            name = "World Enlarger",
            source = "Gnomish Engineering",
            tips = "Farm the schematic from Weapon Technicians in Blackrock Depths, then craft it as a Gnomish Engineer. It was added in patch 1.4 and entered the Toy Box in patch 6.0.2.",
            waypoints = { "/way #36 21.0 38.0 Blackrock Mountain / Lower Blackrock Spire" },
        },
    },
    details = {
        ["World Enlarger"] = {
            acquisition = "Obtain World Enlarger from Gnomish Engineering.",
            source = "Gnomish Engineering",
            sourceType = "Toy Box Source",
            tips = "Farm the schematic from Weapon Technicians in Blackrock Depths, then craft it as a Gnomish Engineer. It was added in patch 1.4 and entered the Toy Box in patch 6.0.2.",
            waypoints = { "/way #36 21.0 38.0 Blackrock Mountain / Lower Blackrock Spire" },
        },
    },
})
