local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("6.2.2", "mounts", {
    entries = {
        {
            acquisition = "Collect 300 mounts usable by one character.",
            category = "Achievements",
            name = "Heavenly Azure Cloud Serpent",
            source = "Lord of the Reins (300 mounts)",
            spellId = 127169,
            tips = "Use the Mount Journal's usable count on one character; faction and class restrictions can affect the achievement total.",
        },
        {
            acquisition = "Purchase during a Wrath of the Lich King Timewalking event.",
            category = "Vendor",
            name = "Ironbound Wraithcharger",
            source = "Auzin / Wrath Timewalking / 5,000 Timewarped Badges",
            spellId = 142910,
            tips = "Save badges across events and buy from Auzin in Northrend Dalaran while Wrath Timewalking is active.",
            waypoints = { "/way #125 50.4 46.6 Auzin" },
        },
        {
            acquisition = "Purchase during a Burning Crusade Timewalking event.",
            category = "Vendor",
            name = "Eclipse Dragonhawk",
            source = "Cupri / Burning Crusade Timewalking / 5,000 Timewarped Badges",
            spellId = 194464,
            tips = "Save badges across events and buy from Cupri in Shattrath while Burning Crusade Timewalking is active.",
            waypoints = { "/way #111 54.4 39.6 Cupri" },
        },
    },
    details = {
        ["Eclipse Dragonhawk"] = {
            acquisition = "Purchase during a Burning Crusade Timewalking event.",
            category = "Vendor",
            source = "Cupri / Burning Crusade Timewalking / 5,000 Timewarped Badges",
            sourceType = "Patch mount collection",
            tips = "Save badges across events and buy from Cupri in Shattrath while Burning Crusade Timewalking is active.",
            waypoints = { "/way #111 54.4 39.6 Cupri" },
        },
        ["Heavenly Azure Cloud Serpent"] = {
            acquisition = "Collect 300 mounts usable by one character.",
            category = "Achievements",
            source = "Lord of the Reins (300 mounts)",
            sourceType = "Patch mount collection",
            tips = "Use the Mount Journal's usable count on one character; faction and class restrictions can affect the achievement total.",
        },
        ["Ironbound Wraithcharger"] = {
            acquisition = "Purchase during a Wrath of the Lich King Timewalking event.",
            category = "Vendor",
            source = "Auzin / Wrath Timewalking / 5,000 Timewarped Badges",
            sourceType = "Patch mount collection",
            tips = "Save badges across events and buy from Auzin in Northrend Dalaran while Wrath Timewalking is active.",
            waypoints = { "/way #125 50.4 46.6 Auzin" },
        },
    },
})
