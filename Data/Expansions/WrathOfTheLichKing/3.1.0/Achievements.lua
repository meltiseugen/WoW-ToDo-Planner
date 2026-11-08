local _, TDP = ...

local shared = {}
shared["Argent Tournament"] = {
    acquisition = "Complete the listed aspirant, valiant, champion, reputation, jousting, or meta criterion.",
    source = "Argent Tournament",
    sourceType = "Achievement",
    tips = "Progress one home city at a time, complete tournament dailies, and retain Champion's Seals for mounts, pets, banners, and tabards.",
    waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
}

shared["Ulduar"] = {
    acquisition = "Complete the Val'anyr legendary questline or Herald of the Titans' level and equipment restrictions.",
    source = "Ulduar",
    sourceType = "Achievement",
    tips = "Ulduar uses its unified Retail raid. Check the individual guide: Val'anyr requires repeated fragment farming, while Herald requires a level-30 group with restricted equipment.",
    waypoints = { "/way #120 41.6 18.2 Ulduar entrance" },
}

shared["Emalon in the Vault of Archavon"] = {
    acquisition = "Defeat Emalon in the listed original raid size.",
    source = "Emalon in the Vault of Archavon",
    sourceType = "Achievement",
    tips = "Vault access historically required Wintergrasp control; defeat overcharged adds before their explosion.",
    waypoints = { "/way #123 50.0 11.0 Vault of Archavon entrance" },
}

shared["Dalaran fishing dailies and Northrend pools"] = {
    acquisition = "Complete every Marcia Chase daily or fish up a Sea Turtle from a Northrend pool.",
    source = "Dalaran fishing dailies and Northrend pools",
    sourceType = "Achievement",
    tips = "Do the Dalaran daily whenever available and pool-hop with Find Fish for the Sea Turtle.",
    waypoints = { "/way #125 53.0 64.9 Marcia Chase" },
}

TDP.CatalogRegistry:RegisterCollection("3.1.0", "achievements", {
    entries = {
        ids = {
            2756, -- Argent Aspiration
            2758, -- Argent Valor
            2760, -- Exalted Champion of Darnassus
            2761, -- Exalted Champion of the Exodar
            2762, -- Exalted Champion of Gnomeregan
            2763, -- Exalted Champion of Ironforge
            2764, -- Exalted Champion of Stormwind
            2765, -- Exalted Champion of Orgrimmar
            2766, -- Exalted Champion of Sen'jin
            2767, -- Exalted Champion of Silvermoon City
            2768, -- Exalted Champion of Thunder Bluff
            2769, -- Exalted Champion of the Undercity
            2770, -- Exalted Champion of the Alliance
            2771, -- Exalted Champion of the Horde
            2772, -- Tilted!
            2773, -- It's Just a Flesh Wound
            2777, -- Champion of Darnassus
            2778, -- Champion of the Exodar
            2779, -- Champion of Gnomeregan
            2780, -- Champion of Ironforge
            2781, -- Champion of Stormwind
            2782, -- Champion of the Alliance
            2783, -- Champion of Orgrimmar
            2784, -- Champion of Sen'jin
            2785, -- Champion of Silvermoon City
            2786, -- Champion of Thunder Bluff
            2787, -- Champion of the Undercity
            2788, -- Champion of the Horde
            2816, -- Exalted Argent Champion of the Horde
            2817, -- Exalted Argent Champion of the Alliance
            2836, -- Lance a Lot
            3136, -- Emalon the Storm Watcher (10 player)
            3137, -- Emalon the Storm Watcher (25 player)
            3142, -- Val'anyr, Hammer of Ancient Kings
            3217, -- Chasing Marcia
            3218, -- Turtles All the Way Down
            3296, -- Cooking with Style
            3316, -- Herald of the Titans
        },
        rewardHighlights = { "Rusted Proto-Drake", "Ironbound Proto-Drake", "Mimiron's Head", "Argent Squire", "Argent Gruntling" },
    },
    details = {
        [2756] = shared["Argent Tournament"],
        [2758] = shared["Argent Tournament"],
        [2760] = shared["Argent Tournament"],
        [2761] = shared["Argent Tournament"],
        [2762] = shared["Argent Tournament"],
        [2763] = shared["Argent Tournament"],
        [2764] = shared["Argent Tournament"],
        [2765] = shared["Argent Tournament"],
        [2766] = shared["Argent Tournament"],
        [2767] = shared["Argent Tournament"],
        [2768] = shared["Argent Tournament"],
        [2769] = shared["Argent Tournament"],
        [2770] = shared["Argent Tournament"],
        [2771] = shared["Argent Tournament"],
        [2772] = shared["Argent Tournament"],
        [2773] = shared["Argent Tournament"],
        [2777] = shared["Argent Tournament"],
        [2778] = shared["Argent Tournament"],
        [2779] = shared["Argent Tournament"],
        [2780] = shared["Argent Tournament"],
        [2781] = shared["Argent Tournament"],
        [2782] = shared["Argent Tournament"],
        [2783] = shared["Argent Tournament"],
        [2784] = shared["Argent Tournament"],
        [2785] = shared["Argent Tournament"],
        [2786] = shared["Argent Tournament"],
        [2787] = shared["Argent Tournament"],
        [2788] = shared["Argent Tournament"],
        [2816] = shared["Argent Tournament"],
        [2817] = shared["Argent Tournament"],
        [2836] = shared["Argent Tournament"],
        [3136] = shared["Emalon in the Vault of Archavon"],
        [3137] = shared["Emalon in the Vault of Archavon"],
        [3142] = shared["Ulduar"],
        [3217] = shared["Dalaran fishing dailies and Northrend pools"],
        [3218] = shared["Dalaran fishing dailies and Northrend pools"],
        [3296] = {
            acquisition = "Purchase and equip a Chef's Hat using Dalaran Cooking Awards.",
            source = "Chef's Hat",
            sourceType = "Achievement",
            tips = "Complete Dalaran cooking dailies and save awards after buying recipes needed for other cooking achievements.",
            waypoints = { "/way #125 40.6 65.8 Dalaran cooking daily hub" },
        },
        [3316] = shared["Ulduar"],
    },
    categories = {
        [2756] = "Questing",
        [2758] = "Questing",
        [2760] = "Questing",
        [2761] = "Questing",
        [2762] = "Questing",
        [2763] = "Questing",
        [2764] = "Questing",
        [2765] = "Questing",
        [2766] = "Questing",
        [2767] = "Questing",
        [2768] = "Questing",
        [2769] = "Questing",
        [2770] = "Questing",
        [2771] = "Questing",
        [2772] = "Questing",
        [2773] = "Questing",
        [2777] = "Questing",
        [2778] = "Questing",
        [2779] = "Questing",
        [2780] = "Questing",
        [2781] = "Questing",
        [2782] = "Questing",
        [2783] = "Questing",
        [2784] = "Questing",
        [2785] = "Questing",
        [2786] = "Questing",
        [2787] = "Questing",
        [2788] = "Questing",
        [2816] = "Questing",
        [2817] = "Questing",
        [2836] = "Questing",
        [3136] = "Raids",
        [3137] = "Raids",
        [3142] = "Raids",
        [3217] = "Fishing",
        [3218] = "Fishing",
        [3296] = "Cooking",
        [3316] = "Raids",
    },
})
