local _, TDP = ...

local shared = {}
shared["Covenant callings, heirloom vendors, and Legion Timewalking"] = {
    acquisition = "Obtain the toy from its permanent covenant-calling, heirloom-map vendor, or Legion Timewalking source.",
    source = "Covenant callings, heirloom vendors, and Legion Timewalking",
    sourceType = "Patch 9.1.5 Collection",
}

TDP.CatalogRegistry:RegisterCollection("9.1.5", "toys", {
    entries = {
        { itemId = 187419, name = "Steward's First Feather" },
        { itemId = 187512, name = "Tome of Small Sins" },
        { itemId = 187591, name = "Nightborne Guard's Vigilance" },
        { itemId = 187705, name = "Choofa's Call" },
        { itemId = 187840, name = "Sparkle Wings" },
        { itemId = 187869, name = "Scouting Map: Into the Shadowlands" },
        { itemId = 187875, name = "Scouting Map: United Fronts of the Broken Isles" },
        { itemId = 187895, name = "Scouting Map: The Dangers of Draenor" },
        { itemId = 187896, name = "Scouting Map: A Stormstout's Guide to Pandaria" },
        { itemId = 187897, name = "Scouting Map: Cataclysm's Consequences" },
        { itemId = 187898, name = "Scouting Map: True Cost of the Northrend Campaign" },
        { itemId = 187899, name = "Scouting Map: The Many Curiosities of Outland" },
        { itemId = 187900, name = "Scouting Map: The Wonders of Kul Tiras and Zandalar" },
        { itemId = 187913, name = "Apprentice Slimemancer's Boots" },
    },
    details = {
        ["Apprentice Slimemancer's Boots"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Choofa's Call"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Nightborne Guard's Vigilance"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: A Stormstout's Guide to Pandaria"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: Cataclysm's Consequences"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: Into the Shadowlands"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: The Dangers of Draenor"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: The Many Curiosities of Outland"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: The Wonders of Kul Tiras and Zandalar"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: True Cost of the Northrend Campaign"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Scouting Map: United Fronts of the Broken Isles"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Sparkle Wings"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Steward's First Feather"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
        ["Tome of Small Sins"] = shared["Covenant callings, heirloom vendors, and Legion Timewalking"],
    },
})
