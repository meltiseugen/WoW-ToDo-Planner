local _, TDP = ...

local shared = {}
shared["shared entries 1 waypoints"] = {
    "/way #205 66.6 41.4 Poseidus spawn",
    "/way #205 58.4 82.2 Poseidus spawn",
    "/way #205 46.6 50.0 Poseidus spawn",
    "/way #205 40.0 67.8 Poseidus spawn",
    "/way #204 41.4 76.3 Poseidus spawn",
}

TDP.CatalogRegistry:RegisterCollection("4.1.0", "mounts", {
    entries = {
        {
            acquisition = "Obtain Subdued Seahorse from Poseidus in Shimmering Expanse and Abyssal Depths.",
            category = "Rare Drops",
            name = "Subdued Seahorse",
            npcId = 50005,
            source = "Poseidus in Shimmering Expanse and Abyssal Depths",
            spellId = 98718,
            tips = "Patrol all five underwater spawn points or watch the Auction House. Poseidus began dropping the bind-on-equip reins in patch 4.1.",
            waypoints = shared["shared entries 1 waypoints"],
        },
        {
            acquisition = "Obtain Armored Razzashi Raptor from Bloodlord Mandokir in Zul'Gurub.",
            category = "Dungeon and Raids",
            name = "Armored Razzashi Raptor",
            npcId = 52151,
            source = "Bloodlord Mandokir in Zul'Gurub",
            spellId = 96491,
            tips = "Use the Cataclysm heroic-dungeon version of Zul'Gurub. The mount is a low-chance personal drop, so repeat the lockout on eligible characters.",
            waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" },
        },
        {
            acquisition = "Obtain Swift Zulian Panther from High Priestess Kilnara in Zul'Gurub.",
            category = "Dungeon and Raids",
            name = "Swift Zulian Panther",
            npcId = 52059,
            source = "High Priestess Kilnara in Zul'Gurub",
            spellId = 96499,
            tips = "Kill High Priestess Kilnara in the Cataclysm Zul'Gurub dungeon. The mount is a low-chance personal drop.",
            waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" },
        },
        {
            acquisition = "Complete the Zul'Aman timed run and loot Kasha's Bag after rescuing all four prisoners.",
            category = "Dungeon and Raids",
            name = "Amani Battle Bear",
            source = "the timed rescue event in Zul'Aman",
            spellId = 98204,
            tips = "Move directly between the first four bosses and avoid unnecessary trash. At high level the timer is generous, but every hostage must be rescued before time expires.",
            waypoints = { "/way #95 81.5 64.4 Zul'Aman entrance" },
        },
    },
    details = {
        ["Amani Battle Bear"] = {
            acquisition = "Complete the Zul'Aman timed run and loot Kasha's Bag after rescuing all four prisoners.",
            category = "Dungeon and Raids",
            source = "the timed rescue event in Zul'Aman",
            sourceType = "Patch mount collection",
            tips = "Move directly between the first four bosses and avoid unnecessary trash. At high level the timer is generous, but every hostage must be rescued before time expires.",
            waypoints = { "/way #95 81.5 64.4 Zul'Aman entrance" },
        },
        ["Armored Razzashi Raptor"] = {
            acquisition = "Obtain Armored Razzashi Raptor from Bloodlord Mandokir in Zul'Gurub.",
            category = "Dungeon and Raids",
            source = "Bloodlord Mandokir in Zul'Gurub",
            sourceType = "Patch mount collection",
            tips = "Use the Cataclysm heroic-dungeon version of Zul'Gurub. The mount is a low-chance personal drop, so repeat the lockout on eligible characters.",
            waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" },
        },
        ["Subdued Seahorse"] = {
            acquisition = "Obtain Subdued Seahorse from Poseidus in Shimmering Expanse and Abyssal Depths.",
            category = "Rare Drops",
            source = "Poseidus in Shimmering Expanse and Abyssal Depths",
            sourceType = "Patch mount collection",
            tips = "Patrol all five underwater spawn points or watch the Auction House. Poseidus began dropping the bind-on-equip reins in patch 4.1.",
            waypoints = shared["shared entries 1 waypoints"],
        },
        ["Swift Zulian Panther"] = {
            acquisition = "Obtain Swift Zulian Panther from High Priestess Kilnara in Zul'Gurub.",
            category = "Dungeon and Raids",
            source = "High Priestess Kilnara in Zul'Gurub",
            sourceType = "Patch mount collection",
            tips = "Kill High Priestess Kilnara in the Cataclysm Zul'Gurub dungeon. The mount is a low-chance personal drop.",
            waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" },
        },
    },
})
