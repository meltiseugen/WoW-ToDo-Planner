local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.6", "toys", {
    entries = {
        { itemId = 216881, name = "Duck Disguiser", source = "Quest:Just a Waddle Away / Zone: Durotar / Quest: Just a Waddle Away / Zone: Elwynn Forest" },
        { itemId = 170197, name = "Swarthy Warning Sign", source = "Faction: Keg Leg's Crew / Renown: 16" },
    },
    details = {
        ["Duck Disguiser"] = {
            source = "Quest:Just a Waddle Away / Zone: Durotar / Quest: Just a Waddle Away / Zone: Elwynn Forest",
            sourceType = "Toy Box Source",
        },
        ["Swarthy Warning Sign"] = { source = "Faction: Keg Leg's Crew / Renown: 16", sourceType = "Toy Box Source" },
    },
})
