local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Dimensional Ripper - Area 52 from the Goblin Engineering schematic.",
            category = "Professions",
            itemId = 30542,
            name = "Dimensional Ripper - Area 52",
            source = "the Goblin Engineering schematic",
            tips = "Goblin Engineers can learn and craft the transporter. It can malfunction, so avoid using it when an unexpected transformation or fall would be dangerous.",
            waypoints = { "/way #109 32.5 66.7 Area 52 engineering trainers" },
        },
        {
            acquisition = "Obtain Ultrasafe Transporter: Toshley's Station from the Gnomish Engineering schematic.",
            category = "Professions",
            itemId = 30544,
            name = "Ultrasafe Transporter: Toshley's Station",
            source = "the Gnomish Engineering schematic",
            tips = "Gnomish Engineers can learn and craft the transporter at Toshley's Station. Like other transporters, it can produce side effects.",
            waypoints = { "/way #105 60.8 68.2 Toshley's Station" },
        },
        {
            acquisition = "Obtain Power Converter from Show Them Gnome Mercy!.",
            category = "Quests",
            itemId = 30690,
            name = "Power Converter",
            source = "Show Them Gnome Mercy!",
            tips = "Complete the Toshley's Station quest chain through Show Them Gnome Mercy! The reward was converted into a Toy Box collectible in patch 6.0.2.",
            waypoints = { "/way #105 60.8 68.2 Toshley's Station" },
        },
    },
    details = {
        ["Dimensional Ripper - Area 52"] = {
            acquisition = "Obtain Dimensional Ripper - Area 52 from the Goblin Engineering schematic.",
            source = "the Goblin Engineering schematic",
            sourceType = "Toy Box Source",
            tips = "Goblin Engineers can learn and craft the transporter. It can malfunction, so avoid using it when an unexpected transformation or fall would be dangerous.",
            waypoints = { "/way #109 32.5 66.7 Area 52 engineering trainers" },
        },
        ["Power Converter"] = {
            acquisition = "Obtain Power Converter from Show Them Gnome Mercy!.",
            source = "Show Them Gnome Mercy!",
            sourceType = "Toy Box Source",
            tips = "Complete the Toshley's Station quest chain through Show Them Gnome Mercy! The reward was converted into a Toy Box collectible in patch 6.0.2.",
            waypoints = { "/way #105 60.8 68.2 Toshley's Station" },
        },
        ["Ultrasafe Transporter: Toshley's Station"] = {
            acquisition = "Obtain Ultrasafe Transporter: Toshley's Station from the Gnomish Engineering schematic.",
            source = "the Gnomish Engineering schematic",
            sourceType = "Toy Box Source",
            tips = "Gnomish Engineers can learn and craft the transporter at Toshley's Station. Like other transporters, it can produce side effects.",
            waypoints = { "/way #105 60.8 68.2 Toshley's Station" },
        },
    },
})
