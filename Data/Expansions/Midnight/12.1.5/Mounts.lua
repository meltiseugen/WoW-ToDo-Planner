local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("12.1.5", "mounts", {
    entries = {
        { faction = "all", itemId = 276926, name = "Corrupted Swarmer", spellId = 1301331 },
        { faction = "all", itemId = 283363, name = "Loa-Blessed Wayfarer", spellId = 1314715 },
        { faction = "all", itemId = 282414, name = "Sporebearer Fungal Strider", spellId = 1313788 },
    },
    details = {
        ["Corrupted Swarmer"] = {
            acquisition = "Reach Exalted with the Aqir Research Enclave and buy the mount in Silvermoon City.",
            availability = "Currently available. Aqir Invasions may be temporary; no confirmed removal date at review.",
            category = "Vendor",
            cost = "2,500 Voidlight Marl.",
            requirements = "Exalted with Aqir Research Enclave (Aqir Research Associate).",
            reviewedAt = "2026-10-15",
            source = "Estelia Archtender / Aqir Research Enclave",
            sourceType = "Reputation Vendor",
            sourceUrl = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards",
            tips = "Use the active invasion icon in Eversong Woods or Zul'Aman at the top of the hour. Complete objectives and stay for the Monstrosity. Launch reports disagree about repeat-kill reputation; check your reputation log rather than assuming every kill awards 100.",
            waypoints = { "/way #2393 39.3 80.3 Estelia Archtender / Aqir Research Enclave" },
        },
        ["Loa-Blessed Wayfarer"] = {
            acquisition = "Defeat Kindo'jan solo on Tier 11 during Midnight Season 2.",
            availability = "Available during Midnight Season 2. The mount is separate from the first-week Fabled title.",
            category = "Delves",
            requirements = "Unlock the Labyrinth and Kindo'jan; no other players in the party for the Tier 11 kill.",
            reviewedAt = "2026-10-15",
            source = "Let Me Solo Him: Kindo'jan (63715)",
            sourceType = "Achievement",
            sourceUrl = "https://www.wowhead.com/guide/midnight/delves/labyrinth-of-kindojan-megadelve-nemesis-rewards",
            tips = "Open the Speaker's Chamber by clearing all nine chambers on Tier 8 or higher. Subsequent runs only need a route to Akil'zon's Roost. Clearing Tier 8 first can shorten setup for solo Tier 11 attempts.",
            waypoints = { "/way #2395 63.0 72.2 Labyrinth of Kindo'jan entrance" },
        },
        ["Sporebearer Fungal Strider"] = {
            acquisition = "Buy from Showena inside The Den. Mailbox and repair passengers are included; optional passengers are separate purchases.",
            availability = "Vendor purchase is announced for the remainder of Midnight. No future replacement source is assumed.",
            category = "Vendor",
            cost = "5,000,000 gold; optional Auction House 1,500,000 gold, Transmogrifier 500,000 gold.",
            reviewedAt = "2026-10-15",
            source = "Showena / The Den, Harandar",
            sourceType = "Gold Vendor",
            sourceUrl = "https://www.method.gg/guides/sporebearer-fungal-strider-5-million-gold-mount-vendor-location-in-wow-midnight",
            tips = "Hoshena nearby changes the active passenger combination after purchase. The Den uses interior map 2576; this is not an outdoor Harandar pin.",
            waypoints = { "/way #2576 62.05 68.34 Showena / The Den" },
        },
    },
})
