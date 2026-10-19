local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("4.2.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Mushroom Chair from Ayla Shadowstorm after Filling the Moonwell.",
            category = "Vendor",
            itemId = 70161,
            name = "Mushroom Chair",
            npcId = 53881,
            source = "Ayla Shadowstorm after Filling the Moonwell",
            tips = "Unlock the Moonwell arm of the Molten Front, then purchase the chair from Ayla.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
        {
            acquisition = "Obtain Mylune's Call from Varlan Highbough after Calling the Ancients.",
            category = "Vendor",
            itemId = 70159,
            name = "Mylune's Call",
            npcId = 53882,
            source = "Varlan Highbough after Calling the Ancients",
            tips = "Unlock Calling the Ancients, then purchase the toy with Marks of the World Tree.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
        {
            acquisition = "Complete the Smoke-Stained Locket and Leyara story through The Rest is History.",
            category = "Quest Rewards",
            itemId = 71259,
            name = "Leyara's Locket",
            source = "The Rest is History quest",
            tips = "The starting locket is tied to the Molten Front progression. Finish the daily-hub unlocks if the follow-up quest is not yet visible.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
    },
    details = {
        ["Leyara's Locket"] = {
            acquisition = "Complete the Smoke-Stained Locket and Leyara story through The Rest is History.",
            source = "The Rest is History quest",
            sourceType = "Toy Box Source",
            tips = "The starting locket is tied to the Molten Front progression. Finish the daily-hub unlocks if the follow-up quest is not yet visible.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
        ["Mushroom Chair"] = {
            acquisition = "Obtain Mushroom Chair from Ayla Shadowstorm after Filling the Moonwell.",
            source = "Ayla Shadowstorm after Filling the Moonwell",
            sourceType = "Toy Box Source",
            tips = "Unlock the Moonwell arm of the Molten Front, then purchase the chair from Ayla.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
        ["Mylune's Call"] = {
            acquisition = "Obtain Mylune's Call from Varlan Highbough after Calling the Ancients.",
            source = "Varlan Highbough after Calling the Ancients",
            sourceType = "Toy Box Source",
            tips = "Unlock Calling the Ancients, then purchase the toy with Marks of the World Tree.",
            waypoints = { "/way #338 47.0 90.0 Malfurion's Breach", "/way #338 44.4 88.4 Zen'Vorka" },
        },
    },
})
