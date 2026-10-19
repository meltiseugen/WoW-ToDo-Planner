local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("6.2.3", "toys", {
    entries = {
        {
            acquisition = "Purchase with Timewarped Badges during Cataclysm Timewalking.",
            itemId = 133511,
            name = "Gurboggle's Gleaming Bauble",
            source = "Kiatke / Cataclysm Timewalking",
            tips = "Visit Kiatke in Stormwind or Orgrimmar while the matching event is active.",
            waypoints = { "/way #84 76.2 17.0 Kiatke", "/way #85 52.6 41.8 Kiatke" },
        },
        {
            acquisition = "Purchase with Timewarped Badges during Cataclysm Timewalking.",
            itemId = 133542,
            name = "Tosselwrench's Mega-Accurate Simulation Viewfinder",
            source = "Kiatke / Cataclysm Timewalking",
            tips = "Check the Cataclysm vendor before the event ends; Timewarped Badges are account-wide only through transfers available in the current game.",
            waypoints = { "/way #84 76.2 17.0 Kiatke", "/way #85 52.6 41.8 Kiatke" },
        },
    },
    details = {
        ["Gurboggle's Gleaming Bauble"] = {
            acquisition = "Purchase with Timewarped Badges during Cataclysm Timewalking.",
            source = "Kiatke / Cataclysm Timewalking",
            sourceType = "Toy Box Source",
            tips = "Visit Kiatke in Stormwind or Orgrimmar while the matching event is active.",
            waypoints = { "/way #84 76.2 17.0 Kiatke", "/way #85 52.6 41.8 Kiatke" },
        },
        ["Tosselwrench's Mega-Accurate Simulation Viewfinder"] = {
            acquisition = "Purchase with Timewarped Badges during Cataclysm Timewalking.",
            source = "Kiatke / Cataclysm Timewalking",
            sourceType = "Toy Box Source",
            tips = "Check the Cataclysm vendor before the event ends; Timewarped Badges are account-wide only through transfers available in the current game.",
            waypoints = { "/way #84 76.2 17.0 Kiatke", "/way #85 52.6 41.8 Kiatke" },
        },
    },
})
