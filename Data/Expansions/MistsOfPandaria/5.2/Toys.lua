local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("5.2", "toys", {
    entries = {
        {
            acquisition = "Obtain Kirin Tor Beacon from The Storm Gathers Alliance quest.",
            category = "Quest Rewards",
            itemId = 95567,
            name = "Kirin Tor Beacon",
            source = "The Storm Gathers Alliance quest",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 64.4 72.7 Violet Rise" },
        },
        {
            acquisition = "Obtain Sunreaver Beacon from The Storm Gathers Horde quest.",
            category = "Quest Rewards",
            itemId = 95568,
            name = "Sunreaver Beacon",
            source = "The Storm Gathers Horde quest",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 33.2 32.4 Dawnseeker Promontory" },
        },
        {
            acquisition = "Obtain Glorious Standard of the Kirin Tor Offensive from Securing A Future at Kirin Tor Offensive Exalted.",
            category = "Reputation",
            itemId = 95589,
            name = "Glorious Standard of the Kirin Tor Offensive",
            source = "Securing A Future at Kirin Tor Offensive Exalted",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 64.4 72.7 Violet Rise" },
        },
        {
            acquisition = "Obtain Glorious Standard of the Sunreaver Onslaught from Life Blood at Sunreaver Onslaught Exalted.",
            category = "Reputation",
            itemId = 95590,
            name = "Glorious Standard of the Sunreaver Onslaught",
            source = "Life Blood at Sunreaver Onslaught Exalted",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 33.2 32.4 Dawnseeker Promontory" },
        },
    },
    details = {
        ["Glorious Standard of the Kirin Tor Offensive"] = {
            acquisition = "Obtain Glorious Standard of the Kirin Tor Offensive from Securing A Future at Kirin Tor Offensive Exalted.",
            source = "Securing A Future at Kirin Tor Offensive Exalted",
            sourceType = "Toy Box Source",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 64.4 72.7 Violet Rise" },
        },
        ["Glorious Standard of the Sunreaver Onslaught"] = {
            acquisition = "Obtain Glorious Standard of the Sunreaver Onslaught from Life Blood at Sunreaver Onslaught Exalted.",
            source = "Life Blood at Sunreaver Onslaught Exalted",
            sourceType = "Toy Box Source",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 33.2 32.4 Dawnseeker Promontory" },
        },
        ["Kirin Tor Beacon"] = {
            acquisition = "Obtain Kirin Tor Beacon from The Storm Gathers Alliance quest.",
            source = "The Storm Gathers Alliance quest",
            sourceType = "Toy Box Source",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 64.4 72.7 Violet Rise" },
        },
        ["Sunreaver Beacon"] = {
            acquisition = "Obtain Sunreaver Beacon from The Storm Gathers Horde quest.",
            source = "The Storm Gathers Horde quest",
            sourceType = "Toy Box Source",
            tips = "The faction-paired standards share collection credit in modern clients. Complete the Isle campaign and reputation before attempting the exalted finale.",
            waypoints = { "/way #504 33.2 32.4 Dawnseeker Promontory" },
        },
    },
})
