-- Catalogue entries and complete Retail research for 2.1.
local _, TDP = ...

local walkthroughs = {
    [146] = {
        source = "Bogflare Needlers - northern Serpent Lake, Zangarmarsh",
        category = "Rare Drops",
        npcId = 20197,
        requirements = "Either faction; able to kill and loot Bogflare Needlers.",
        cost = "No purchase cost when farming; player prices vary.",
        tips = "This is a very rare drop with widely varying kill counts. A route makes more eligible kills available but does not guarantee a drop after a fixed number. The pins mark a farming circuit, not individual permanent spawns.",
        waypoints = {
            {
                mapID = 102,
                x = 0.38799999999999996,
                y = 0.39399999999999996,
                step = 2,
                label = "Bogflare Needlers - western shore start",
            },
            { mapID = 102, x = 0.435, y = 0.355, step = 2, label = "Bogflare Needlers - northwest shore" },
            { mapID = 102, x = 0.496, y = 0.314, step = 3, label = "Bogflare Needlers - northern shore" },
            {
                mapID = 102,
                x = 0.586,
                y = 0.36200000000000004,
                step = 3,
                label = "Bogflare Needlers - northeast end of circuit",
            },
            { mapID = 102, x = 0.596, y = 0.462, step = 3, label = "Bogflare Needlers - optional southeastern cluster" },
        },
        itemId = 29960,
        name = "Firefly",
        stepCount = 5,
        acquisition = "Difficulty: Hard - The direct route is a very rare Bogflare Needler drop; buying a tradable pet can bypass the farm.\n\n1. Travel to northern Zangarmarsh in Outland. The target enemy is Bogflare Needler (20197), and the item you need is Captured Firefly (29960). Other glowing insects, wild battle pets and the similarly named Tiny Flamefly do not unlock this species.\n\n2. Start on the western shore of Serpent Lake around 38.8, 39.4. Kill and loot Bogflare Needlers as you follow the shore north toward 43.5, 35.5. Check the nameplate before pulling; the surrounding sporebats are useful for other materials but do not drop this pet.\n\n3. Continue east along the northern shore through 49.6, 31.4 toward 58.6, 36.2. Make a return pass through the same spawn belt; you can also check the smaller southeastern cluster around 59.6, 46.2 while the northern groups respawn.\n\n4. Loot every Needler before moving on and repeat the circuit. If the whole route is dead, wait for respawns or return later. Keep Glowcaps you find if you also want Tiny Sporebat, which costs 30 Glowcaps at Sporeggar Exalted. Vendor ordinary insect parts to keep bag space available.\n\n5. Use Captured Firefly when it drops. The learned species is named Firefly in the Pet Journal, so search under F. You can also buy the item or matching caged Firefly from another player; check the species before paying.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=29960",
        difficultyReason = "The direct route is a very rare Bogflare Needler drop; buying a tradable pet can bypass the farm.",
        difficulty = "hard",
    },
}

TDP.CatalogRegistry:RegisterCollection("2.1", "pets", {
    entries = {
        {
            acquisition = walkthroughs[146]["acquisition"],
            category = "Rare Drops",
            name = "Firefly",
            npcId = 20197,
            source = "Bogflare Needlers - northern Serpent Lake, Zangarmarsh",
            speciesId = 146,
            tips = walkthroughs[146]["tips"],
            waypoints = walkthroughs[146]["waypoints"],
            itemId = 29960,
            requirements = "Either faction; able to kill and loot Bogflare Needlers.",
            cost = "No purchase cost when farming; player prices vary.",
            faction = "all",
            difficulty = "hard",
            difficultyReason = "The direct route is a very rare Bogflare Needler drop; buying a tradable pet can bypass the farm.",
            walkthrough = walkthroughs[146],
        },
    },
    details = {
        Firefly = {
            acquisition = walkthroughs[146]["acquisition"],
            source = "Bogflare Needlers - northern Serpent Lake, Zangarmarsh",
            sourceType = "Rare Drops",
            tips = walkthroughs[146]["tips"],
            waypoints = walkthroughs[146]["waypoints"],
            itemId = 29960,
            npcId = 20197,
            requirements = "Either faction; able to kill and loot Bogflare Needlers.",
            cost = "No purchase cost when farming; player prices vary.",
            category = "Rare Drops",
            faction = "all",
            difficulty = "hard",
            difficultyReason = "The direct route is a very rare Bogflare Needler drop; buying a tradable pet can bypass the farm.",
        },
    },
})
