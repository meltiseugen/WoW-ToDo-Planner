local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("1.5", "toys", {
    entries = {
        {
            acquisition = "Obtain Dimensional Ripper - Everlook from Zap Farflinger in Everlook.",
            category = "Professions",
            itemId = 18984,
            name = "Dimensional Ripper - Everlook",
            source = "Zap Farflinger in Everlook",
            tips = "Goblin Engineers learn this transporter from Zap Farflinger. It can malfunction, so use it somewhere safe.",
            waypoints = { "/way #83 61.3 37.1 Everlook Engineering trainers" },
        },
        {
            acquisition = "Obtain Ultrasafe Transporter: Gadgetzan from Jhordy Lapforge in Gadgetzan.",
            category = "Professions",
            itemId = 18986,
            name = "Ultrasafe Transporter: Gadgetzan",
            source = "Jhordy Lapforge in Gadgetzan",
            tips = "Gnomish Engineers learn this transporter from Jhordy Lapforge. Its possible malfunctions make a safe departure point worthwhile.",
            waypoints = { "/way #71 52.5 27.3 Gadgetzan Engineering trainers" },
        },
    },
    details = {
        ["Dimensional Ripper - Everlook"] = {
            acquisition = "Obtain Dimensional Ripper - Everlook from Zap Farflinger in Everlook.",
            source = "Zap Farflinger in Everlook",
            sourceType = "Toy Box Source",
            tips = "Goblin Engineers learn this transporter from Zap Farflinger. It can malfunction, so use it somewhere safe.",
            waypoints = { "/way #83 61.3 37.1 Everlook Engineering trainers" },
        },
        ["Ultrasafe Transporter: Gadgetzan"] = {
            acquisition = "Obtain Ultrasafe Transporter: Gadgetzan from Jhordy Lapforge in Gadgetzan.",
            source = "Jhordy Lapforge in Gadgetzan",
            sourceType = "Toy Box Source",
            tips = "Gnomish Engineers learn this transporter from Jhordy Lapforge. Its possible malfunctions make a safe departure point worthwhile.",
            waypoints = { "/way #71 52.5 27.3 Gadgetzan Engineering trainers" },
        },
    },
})
