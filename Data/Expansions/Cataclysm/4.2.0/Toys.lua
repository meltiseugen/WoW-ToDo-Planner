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
            tips = "Recruit both groups, complete Filling the Moonwell and Nourishing Waters, then buy the chair from Ayla for the displayed gold price.",
            waypoints = { "/way #198 27.6 56.3 Molten Front portal", "/way #338 44.6 86.2 Ayla Shadowstorm / Mushroom Chair" },
        },
        {
            acquisition = "Obtain Mylune's Call from Varlan Highbough after Calling the Ancients.",
            category = "Vendor",
            itemId = 70159,
            name = "Mylune's Call",
            npcId = 53882,
            source = "Varlan Highbough after Calling the Ancients",
            tips = "Recruit both groups, complete Calling the Ancients and Aid of the Ancients, then purchase the toy from Varlan for gold. Marks pay for the unlock.",
            waypoints = { "/way #198 27.6 56.3 Molten Front portal", "/way #338 44.5 88.6 Varlan Highbough / Mylune's Call" },
        },
        {
            acquisition = "Complete the Smoke-Stained Locket and Leyara story through The Rest is History.",
            category = "Quest Rewards",
            itemId = 71259,
            name = "Leyara's Locket",
            source = "The Rest is History quest",
            tips = "After Filling the Moonwell, complete Into the Depths and check the mailed Smoke-Stained Locket. Follow the memory chain through Moonglade, Ashenvale and Hyjal, then return to Malfurion.",
            waypoints = { "/way #338 47.0 90.7 Malfurion Stormrage", "/way #80 51.6 44.8 Rabine Saturna", "/way #63 40.5 53.3 Night Elf Grave", "/way #198 7.6 34.5 Small Gravestone" },
        },
    },
    details = {
        ["Leyara's Locket"] = {
            acquisition = "Complete the Smoke-Stained Locket and Leyara story through The Rest is History.",
            source = "The Rest is History quest",
            sourceType = "Toy Box Source",
            tips = "After Filling the Moonwell, complete Into the Depths and check the mailed Smoke-Stained Locket. Follow the memory chain through Moonglade, Ashenvale and Hyjal, then return to Malfurion.",
            waypoints = { "/way #338 47.0 90.7 Malfurion Stormrage", "/way #80 51.6 44.8 Rabine Saturna", "/way #63 40.5 53.3 Night Elf Grave", "/way #198 7.6 34.5 Small Gravestone" },
        },
        ["Mushroom Chair"] = {
            acquisition = "Obtain Mushroom Chair from Ayla Shadowstorm after Filling the Moonwell.",
            source = "Ayla Shadowstorm after Filling the Moonwell",
            sourceType = "Toy Box Source",
            tips = "Recruit both groups, complete Filling the Moonwell and Nourishing Waters, then buy the chair from Ayla for the displayed gold price.",
            waypoints = { "/way #198 27.6 56.3 Molten Front portal", "/way #338 44.6 86.2 Ayla Shadowstorm / Mushroom Chair" },
        },
        ["Mylune's Call"] = {
            acquisition = "Obtain Mylune's Call from Varlan Highbough after Calling the Ancients.",
            source = "Varlan Highbough after Calling the Ancients",
            sourceType = "Toy Box Source",
            tips = "Recruit both groups, complete Calling the Ancients and Aid of the Ancients, then purchase the toy from Varlan for gold. Marks pay for the unlock.",
            waypoints = { "/way #198 27.6 56.3 Molten Front portal", "/way #338 44.5 88.6 Varlan Highbough / Mylune's Call" },
        },
    },
})
