local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.4", "toys", {
    entries = {
        {
            acquisition = "Obtain Orb of the Sin'dorei from bosses in Heroic Magisters' Terrace.",
            category = "Dungeon and Raids",
            itemId = 35275,
            name = "Orb of the Sin'dorei",
            source = "bosses in Heroic Magisters' Terrace",
            tips = "Farm Heroic Magisters' Terrace bosses; Kael'thas has the highest listed chance. The orb disguises the user as a blood elf.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
    },
    details = {
        ["Orb of the Sin'dorei"] = {
            acquisition = "Obtain Orb of the Sin'dorei from bosses in Heroic Magisters' Terrace.",
            source = "bosses in Heroic Magisters' Terrace",
            sourceType = "Toy Box Source",
            tips = "Farm Heroic Magisters' Terrace bosses; Kael'thas has the highest listed chance. The orb disguises the user as a blood elf.",
            waypoints = { "/way #122 61.2 30.9 Magisters' Terrace entrance" },
        },
    },
})
