local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.3.0", "pets", {
    entries = {
        {
            acquisition = "Obtain Perky Pug from the Looking For Multitudes achievement.",
            category = "Achievements",
            name = "Perky Pug",
            source = "the Looking For Multitudes achievement",
            speciesId = 250,
            tips = "Finish random heroic dungeons through Dungeon Finder with 100 different random players. The pet arrives through in-game mail.",
            waypoints = { "/way #118 52.6 89.4 Frozen Halls entrance" },
        },
        {
            acquisition = "Obtain Blue Clockwork Rocket Bot from Jepetto Joybuzz in Dalaran.",
            category = "Vendor",
            name = "Blue Clockwork Rocket Bot",
            npcId = 29478,
            source = "Jepetto Joybuzz in Dalaran",
            speciesId = 254,
            tips = "Buy the pet from the Wonderworks for gold. It is cageable, so the Auction House is an alternative.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
    },
    details = {
        ["Blue Clockwork Rocket Bot"] = {
            acquisition = "Obtain Blue Clockwork Rocket Bot from Jepetto Joybuzz in Dalaran.",
            source = "Jepetto Joybuzz in Dalaran",
            sourceType = "Pet Journal Source",
            tips = "Buy the pet from the Wonderworks for gold. It is cageable, so the Auction House is an alternative.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
        ["Perky Pug"] = {
            acquisition = "Obtain Perky Pug from the Looking For Multitudes achievement.",
            source = "the Looking For Multitudes achievement",
            sourceType = "Pet Journal Source",
            tips = "Finish random heroic dungeons through Dungeon Finder with 100 different random players. The pet arrives through in-game mail.",
            waypoints = { "/way #118 52.6 89.4 Frozen Halls entrance" },
        },
    },
})
