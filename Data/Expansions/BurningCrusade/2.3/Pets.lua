local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.3", "pets", {
    entries = {
        {
            acquisition = "Obtain Mojo from Amani Hex Sticks used on Forest Frogs in Zul'Aman.",
            category = "Rare Drops",
            name = "Mojo",
            source = "Amani Hex Sticks used on Forest Frogs in Zul'Aman",
            speciesId = 165,
            tips = "Loot Amani Hex Sticks from Zul'Aman trash and use them on Forest Frogs. Most frogs reveal NPCs; Mojo is the rare transformation result.",
            waypoints = { "/way #95 81.5 64.4 Zul'Aman entrance" },
        },
        {
            acquisition = "Obtain Tiny Sporebat from Mycah at Exalted with Sporeggar.",
            category = "Reputation",
            name = "Tiny Sporebat",
            npcId = 18382,
            source = "Mycah at Exalted with Sporeggar",
            speciesId = 167,
            tips = "Reach Exalted with Sporeggar, then buy the pet from its quartermaster using Glowcaps.",
            waypoints = { "/way #102 17.9 51.2 Mycah / Sporeggar" },
        },
    },
    details = {
        Mojo = {
            acquisition = "Obtain Mojo from Amani Hex Sticks used on Forest Frogs in Zul'Aman.",
            source = "Amani Hex Sticks used on Forest Frogs in Zul'Aman",
            sourceType = "Pet Journal Source",
            tips = "Loot Amani Hex Sticks from Zul'Aman trash and use them on Forest Frogs. Most frogs reveal NPCs; Mojo is the rare transformation result.",
            waypoints = { "/way #95 81.5 64.4 Zul'Aman entrance" },
        },
        ["Tiny Sporebat"] = {
            acquisition = "Obtain Tiny Sporebat from Mycah at Exalted with Sporeggar.",
            source = "Mycah at Exalted with Sporeggar",
            sourceType = "Pet Journal Source",
            tips = "Reach Exalted with Sporeggar, then buy the pet from its quartermaster using Glowcaps.",
            waypoints = { "/way #102 17.9 51.2 Mycah / Sporeggar" },
        },
    },
})
