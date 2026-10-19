local _, TDP = ...

local shared = {}
shared["shared entries 3 waypoints"] = {
    "/way #525 46.0 42.0 Frostfire Ridge",
    "/way #543 45.0 76.0 Gorgrond",
    "/way #535 46.2 74.1 Talador",
    "/way #542 46.5 46.8 Spires of Arak",
    "/way #550 50.0 55.0 Nagrand",
    "/way #539 45.0 69.0 Shadowmoon Valley",
}

TDP.CatalogRegistry:RegisterCollection("6.1.0", "mounts", {
    entries = {
        {
            acquisition = "Obtain Chauffeured Mechano-Hog from Heirloom Hoarder on a Horde account.",
            category = "Achievements",
            name = "Chauffeured Mechano-Hog",
            source = "Heirloom Hoarder on a Horde account",
            spellId = 179244,
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
        },
        {
            acquisition = "Obtain Chauffeured Mekgineer's Chopper from Heirloom Hoarder on an Alliance account.",
            category = "Achievements",
            name = "Chauffeured Mekgineer's Chopper",
            source = "Heirloom Hoarder on an Alliance account",
            spellId = 179245,
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
        },
        {
            acquisition = "Obtain Voidtalon of the Dark Star from a rare Edge of Reality portal in a Draenor outdoor zone.",
            category = "Rare Drops",
            name = "Voidtalon of the Dark Star",
            source = "a rare Edge of Reality portal in a Draenor outdoor zone",
            spellId = 179478,
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
            waypoints = shared["shared entries 3 waypoints"],
        },
    },
    details = {
        ["Chauffeured Mechano-Hog"] = {
            acquisition = "Obtain Chauffeured Mechano-Hog from Heirloom Hoarder on a Horde account.",
            category = "Achievements",
            source = "Heirloom Hoarder on a Horde account",
            sourceType = "Patch mount collection",
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
        },
        ["Chauffeured Mekgineer's Chopper"] = {
            acquisition = "Obtain Chauffeured Mekgineer's Chopper from Heirloom Hoarder on an Alliance account.",
            category = "Achievements",
            source = "Heirloom Hoarder on an Alliance account",
            sourceType = "Patch mount collection",
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
        },
        ["Voidtalon of the Dark Star"] = {
            acquisition = "Obtain Voidtalon of the Dark Star from a rare Edge of Reality portal in a Draenor outdoor zone.",
            category = "Rare Drops",
            source = "a rare Edge of Reality portal in a Draenor outdoor zone",
            sourceType = "Patch mount collection",
            tips = "For Voidtalon, patrol low-population Draenor zones and enter the purple portal immediately; it despawns quickly and only the first entrant can claim the scenario.",
            waypoints = shared["shared entries 3 waypoints"],
        },
    },
})
