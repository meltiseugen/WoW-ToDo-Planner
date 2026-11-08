local _, TDP = ...

local shared = {}
shared["shared entries 3 waypoints"] = { "/way #104 36.7 55.0 Niobe Whizzlespark / Wildhammer Stronghold", "/way #104 29.2 28.6 Jonathan Garrett / Shadowmoon Village" }

TDP.CatalogRegistry:RegisterCollection("2.3", "mounts", {
    entries = {
        {
            acquisition = "Obtain Cenarion War Hippogryph from Fedryen Swiftspear at Exalted with the Cenarion Expedition.",
            category = "Reputation",
            name = "Cenarion War Hippogryph",
            npcId = 17904,
            source = "Fedryen Swiftspear at Exalted with the Cenarion Expedition",
            spellId = 43927,
            tips = "Reach Exalted with the Cenarion Expedition through Outland quests and dungeon reputation, then buy the mount for gold.",
            waypoints = { "/way #102 79.3 63.8 Fedryen Swiftspear / Cenarion Refuge" },
        },
        {
            acquisition = "Obtain Turbo-Charged Flying Machine from Outland Engineering.",
            category = "Professions",
            name = "Turbo-Charged Flying Machine",
            source = "Outland Engineering",
            spellId = 44151,
            tips = "Train the epic schematic and craft the machine. It requires Outland Engineering to learn and remains Engineering-restricted when summoned.",
            waypoints = shared["shared entries 3 waypoints"],
        },
        {
            acquisition = "Obtain Flying Machine from Outland Engineering.",
            category = "Professions",
            name = "Flying Machine",
            source = "Outland Engineering",
            spellId = 44153,
            tips = "Train the standard schematic and craft the machine from Outland engineering parts. It requires Outland Engineering to use.",
            waypoints = shared["shared entries 3 waypoints"],
        },
    },
    details = {
        ["Cenarion War Hippogryph"] = {
            acquisition = "Obtain Cenarion War Hippogryph from Fedryen Swiftspear at Exalted with the Cenarion Expedition.",
            category = "Reputation",
            source = "Fedryen Swiftspear at Exalted with the Cenarion Expedition",
            sourceType = "Patch mount collection",
            tips = "Reach Exalted with the Cenarion Expedition through Outland quests and dungeon reputation, then buy the mount for gold.",
            waypoints = { "/way #102 79.3 63.8 Fedryen Swiftspear / Cenarion Refuge" },
        },
        ["Flying Machine"] = {
            acquisition = "Obtain Flying Machine from Outland Engineering.",
            category = "Professions",
            source = "Outland Engineering",
            sourceType = "Patch mount collection",
            tips = "Train the standard schematic and craft the machine from Outland engineering parts. It requires Outland Engineering to use.",
            waypoints = shared["shared entries 3 waypoints"],
        },
        ["Turbo-Charged Flying Machine"] = {
            acquisition = "Obtain Turbo-Charged Flying Machine from Outland Engineering.",
            category = "Professions",
            source = "Outland Engineering",
            sourceType = "Patch mount collection",
            tips = "Train the epic schematic and craft the machine. It requires Outland Engineering to learn and remains Engineering-restricted when summoned.",
            waypoints = shared["shared entries 3 waypoints"],
        },
    },
})
