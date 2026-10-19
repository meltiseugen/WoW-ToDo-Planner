local _, TDP = ...

local shared = {}
shared["shared entries 1 waypoints"] = { "/way #84 38.7 32.9 Stormwind Cathedral / Paladin trainers", "/way #85 48.2 45.4 Cleft of Shadow / Warlock trainers" }

TDP.CatalogRegistry:RegisterCollection("1.1", "mounts", {
    entries = {
        {
            acquisition = "Learn Warhorse automatically on an eligible Human or Dwarf Paladin.",
            category = "Class Mounts",
            name = "Warhorse",
            source = "Human and dwarf Paladin class training",
            spellId = 13819,
            tips = "The Paladin mount arrived with the commercial launch build alongside Paladin talents. It is restricted to eligible Alliance Paladins.",
            waypoints = shared["shared entries 1 waypoints"],
        },
        {
            acquisition = "Obtain Gray Kodo from Harb Clawhoof in Mulgore.",
            category = "Vendor",
            name = "Gray Kodo",
            source = "Harb Clawhoof in Mulgore",
            spellId = 18989,
            tips = "Purchase the kodo from Harb Clawhoof after meeting the current riding and reputation requirements.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        {
            acquisition = "Obtain Brown Kodo from Harb Clawhoof in Mulgore.",
            category = "Vendor",
            name = "Brown Kodo",
            source = "Harb Clawhoof in Mulgore",
            spellId = 18990,
            tips = "Purchase the kodo from Harb Clawhoof after meeting the current riding and reputation requirements.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        {
            acquisition = "Obtain Green Kodo from the original tauren epic-mount vendor.",
            category = "Legacy",
            name = "Green Kodo",
            source = "the original tauren epic-mount vendor",
            spellId = 18991,
            tips = "Added with the launch-version kodo system and retired in patch 1.4. It remains usable only by original owners.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        {
            acquisition = "Obtain Teal Kodo from the original tauren epic-mount vendor.",
            category = "Legacy",
            name = "Teal Kodo",
            source = "the original tauren epic-mount vendor",
            spellId = 18992,
            tips = "Added with the launch-version kodo system and retired in patch 1.4. It remains usable only by original owners.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
    },
    details = {
        ["Brown Kodo"] = {
            acquisition = "Obtain Brown Kodo from Harb Clawhoof in Mulgore.",
            category = "Vendor",
            source = "Harb Clawhoof in Mulgore",
            sourceType = "Patch mount collection",
            tips = "Purchase the kodo from Harb Clawhoof after meeting the current riding and reputation requirements.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        ["Gray Kodo"] = {
            acquisition = "Obtain Gray Kodo from Harb Clawhoof in Mulgore.",
            category = "Vendor",
            source = "Harb Clawhoof in Mulgore",
            sourceType = "Patch mount collection",
            tips = "Purchase the kodo from Harb Clawhoof after meeting the current riding and reputation requirements.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        ["Green Kodo"] = {
            acquisition = "Obtain Green Kodo from the original tauren epic-mount vendor.",
            category = "Legacy",
            source = "the original tauren epic-mount vendor",
            sourceType = "Patch mount collection",
            tips = "Added with the launch-version kodo system and retired in patch 1.4. It remains usable only by original owners.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        ["Teal Kodo"] = {
            acquisition = "Obtain Teal Kodo from the original tauren epic-mount vendor.",
            category = "Legacy",
            source = "the original tauren epic-mount vendor",
            sourceType = "Patch mount collection",
            tips = "Added with the launch-version kodo system and retired in patch 1.4. It remains usable only by original owners.",
            waypoints = { "/way #7 47.6 58.6 Harb Clawhoof / Bloodhoof Village" },
        },
        Warhorse = {
            acquisition = "Learn Warhorse automatically on an eligible Human or Dwarf Paladin.",
            category = "Class Mounts",
            source = "Human and dwarf Paladin class training",
            sourceType = "Patch mount collection",
            tips = "The Paladin mount arrived with the commercial launch build alongside Paladin talents. It is restricted to eligible Alliance Paladins.",
            waypoints = shared["shared entries 1 waypoints"],
        },
    },
})
