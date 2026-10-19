local _, TDP = ...

local shared = {}
shared["Gamesmaster Fleurian"] = {
    acquisition = "Originally sold for 300 Illusionary Coins from Gamesmaster Fleurian in Falconwing Square.",
    source = "Gamesmaster Fleurian",
    sourceType = "Decor Duels",
    tips = "Decor Duels was removed in Patch 12.1. Blizzard confirmed decor rewards would remain available, but did not confirm a replacement source for this toy; treat it as currently unavailable unless it returns.",
    waypoints = { "/way #2393 31.6 76.7 Gamesmaster Fleurian / Decor Duels rewards" },
}

TDP.CatalogRegistry:RegisterCollection("12.0.5", "toys", {
    entries = { { itemId = 268455, name = "Enchanted Hourglass" }, { itemId = 268456, name = "Animated Bench" } },
    details = {
        ["Animated Bench"] = shared["Gamesmaster Fleurian"],
        ["Enchanted Hourglass"] = shared["Gamesmaster Fleurian"],
        ["Nap Mat"] = {
            acquisition = "During Children's Week, buy from Jepetto Joybuzz or another holiday vendor for 1 Well-loved Figurine.",
            effect = "Places an interactable mat that lets a player lie down with a sleep effect; 20-minute cooldown.",
            source = "Children's Week",
            sourceType = "World Event vendor",
            tips = "A Well-loved Figurine is awarded instead of choosing a companion pet from an orphan questline. The item is sold in Silvermoon, Stormwind, Orgrimmar, and Dornogal during the holiday.",
        },
    },
})
