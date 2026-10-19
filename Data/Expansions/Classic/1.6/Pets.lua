local _, TDP = ...

local shared = {}
shared["shared entries 3 waypoints"] = { "/way #407 56.0 70.9 Morja / Spawn of Jubjub", "/way #36 21.0 38.0 Blackrock Mountain / Dark Iron Ale source" }

TDP.CatalogRegistry:RegisterCollection("1.6", "pets", {
    entries = {
        {
            acquisition = "Buy the limited-stock Wood Frog Box from Flik for 1 gold while the Darkmoon Faire is active.",
            category = "Vendor",
            name = "Wood Frog",
            npcId = 7550,
            source = "Flik at the Darkmoon Faire",
            speciesId = 64,
            tips = "Flik walks a circuit through the faire. His Wood Frog Box has limited stock, so check again after a restock or on another realm if it is missing.",
            waypoints = { "/way #407 56.3 55.1 Flik / frog vendor" },
        },
        {
            acquisition = "Buy the Tree Frog Box from Flik for 1 gold while the Darkmoon Faire is active.",
            category = "Vendor",
            name = "Tree Frog",
            npcId = 7549,
            source = "Flik at the Darkmoon Faire",
            speciesId = 65,
            tips = "Flik is a moving child vendor. Use the waypoint as the center of his route and target him by name if he is not standing exactly on the pin.",
            waypoints = { "/way #407 56.3 55.1 Flik / frog vendor" },
        },
        {
            acquisition = "Bring Dark Iron Ale Mugs from Plugger Spazzring in Blackrock Depths, lure Jubjub back to Morja, complete Spawn of Jubjub, and wait seven days for the egg to hatch.",
            category = "Quest Rewards",
            name = "Jubling",
            npcId = 14878,
            source = "Spawn of Jubjub from Morja",
            speciesId = 106,
            tips = "Bring at least two mugs: one to lure Jubjub and one for the quest turn-in. Extra mugs make the hop-by-hop lure easier; dismiss any summoned Jubling nearby so it does not consume the bait.",
            waypoints = shared["shared entries 3 waypoints"],
        },
    },
    details = {
        Jubling = {
            acquisition = "Bring Dark Iron Ale Mugs from Plugger Spazzring in Blackrock Depths, lure Jubjub back to Morja, complete Spawn of Jubjub, and wait seven days for the egg to hatch.",
            source = "Spawn of Jubjub from Morja",
            sourceType = "Pet Journal Source",
            tips = "Bring at least two mugs: one to lure Jubjub and one for the quest turn-in. Extra mugs make the hop-by-hop lure easier; dismiss any summoned Jubling nearby so it does not consume the bait.",
            waypoints = shared["shared entries 3 waypoints"],
        },
        ["Tree Frog"] = {
            acquisition = "Buy the Tree Frog Box from Flik for 1 gold while the Darkmoon Faire is active.",
            source = "Flik at the Darkmoon Faire",
            sourceType = "Pet Journal Source",
            tips = "Flik is a moving child vendor. Use the waypoint as the center of his route and target him by name if he is not standing exactly on the pin.",
            waypoints = { "/way #407 56.3 55.1 Flik / frog vendor" },
        },
        ["Wood Frog"] = {
            acquisition = "Buy the limited-stock Wood Frog Box from Flik for 1 gold while the Darkmoon Faire is active.",
            source = "Flik at the Darkmoon Faire",
            sourceType = "Pet Journal Source",
            tips = "Flik walks a circuit through the faire. His Wood Frog Box has limited stock, so check again after a restock or on another realm if it is missing.",
            waypoints = { "/way #407 56.3 55.1 Flik / frog vendor" },
        },
    },
})
