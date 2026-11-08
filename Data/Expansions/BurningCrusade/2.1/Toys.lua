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
            tips = "Buy a Time-Lost Offering or make one through the Skettis quest chain, summon Terokk at the Ancient Skull Pile on Terokk's Rest, and loot him for the rare toy. The figurine transforms you into an arakkoa. The quartermaster does not sell it, and there is no daily drop lockout.",
            waypoints = { "/way #108 66.1 77.6 Ancient Skull Pile / Terokk" },
        },
    },
    details = {
        ["Time-Lost Figurine"] = {
            acquisition = "Obtain Time-Lost Figurine from Terokk in Skettis.",
            source = "Terokk in Skettis",
            sourceType = "Toy Box Source",
            tips = "Buy a Time-Lost Offering or make one through the Skettis quest chain, summon Terokk at the Ancient Skull Pile on Terokk's Rest, and loot him for the rare toy. The figurine transforms you into an arakkoa. The quartermaster does not sell it, and there is no daily drop lockout.",
            waypoints = { "/way #108 66.1 77.6 Ancient Skull Pile / Terokk" },
        },
    },
})
