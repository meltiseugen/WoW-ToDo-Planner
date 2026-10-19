local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.3.0", "toys", {
    entries = {
        {
            acquisition = "Obtain Muradin's Favor from Muradin's Lament from the Shadowmourne sealed chest.",
            category = "Quest Rewards",
            itemId = 52201,
            name = "Muradin's Favor",
            source = "Muradin's Lament from the Shadowmourne sealed chest",
            tips = "After completing Shadowmourne and the Lich King follow-up, use Arthas' Training Sword from the sealed chest to start the quest.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
        {
            acquisition = "Obtain Sylvanas' Music Box from Sylvanas' Vengeance from the Shadowmourne sealed chest.",
            category = "Quest Rewards",
            itemId = 52253,
            name = "Sylvanas' Music Box",
            source = "Sylvanas' Vengeance from the Shadowmourne sealed chest",
            tips = "After completing Shadowmourne and the Lich King follow-up, use the Blood of Sylvanas from the sealed chest to start the quest.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
        {
            acquisition = "Obtain Blue Crashin' Thrashin' Racer Controller from Jepetto Joybuzz in Dalaran.",
            category = "Vendor",
            itemId = 54343,
            name = "Blue Crashin' Thrashin' Racer Controller",
            npcId = 29478,
            source = "Jepetto Joybuzz in Dalaran",
            tips = "Buy the controller from the Wonderworks for gold. Summon it in an open area and use its controls to crash into other racers.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
        {
            acquisition = "Obtain Tiny Blue Ragdoll from Jepetto Joybuzz in Dalaran.",
            category = "Vendor",
            itemId = 54438,
            name = "Tiny Blue Ragdoll",
            npcId = 29478,
            source = "Jepetto Joybuzz in Dalaran",
            tips = "Buy the ragdoll from the Wonderworks for gold; it places a small interactive doll on the ground.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
    },
    details = {
        ["Blue Crashin' Thrashin' Racer Controller"] = {
            acquisition = "Obtain Blue Crashin' Thrashin' Racer Controller from Jepetto Joybuzz in Dalaran.",
            source = "Jepetto Joybuzz in Dalaran",
            sourceType = "Toy Box Source",
            tips = "Buy the controller from the Wonderworks for gold. Summon it in an open area and use its controls to crash into other racers.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
        ["Muradin's Favor"] = {
            acquisition = "Obtain Muradin's Favor from Muradin's Lament from the Shadowmourne sealed chest.",
            source = "Muradin's Lament from the Shadowmourne sealed chest",
            sourceType = "Toy Box Source",
            tips = "After completing Shadowmourne and the Lich King follow-up, use Arthas' Training Sword from the sealed chest to start the quest.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
        ["Sylvanas' Music Box"] = {
            acquisition = "Obtain Sylvanas' Music Box from Sylvanas' Vengeance from the Shadowmourne sealed chest.",
            source = "Sylvanas' Vengeance from the Shadowmourne sealed chest",
            sourceType = "Toy Box Source",
            tips = "After completing Shadowmourne and the Lich King follow-up, use the Blood of Sylvanas from the sealed chest to start the quest.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
        ["Tiny Blue Ragdoll"] = {
            acquisition = "Obtain Tiny Blue Ragdoll from Jepetto Joybuzz in Dalaran.",
            source = "Jepetto Joybuzz in Dalaran",
            sourceType = "Toy Box Source",
            tips = "Buy the ragdoll from the Wonderworks for gold; it places a small interactive doll on the ground.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
    },
})
