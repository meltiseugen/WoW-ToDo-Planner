local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.7", "cosmetics", {
    entries = {
        { detailKey = "draeneiHeritage", itemId = 211313, name = "Ensemble: Heritage of the Draenei", requirements = "Level 50+ Draenei character", subtype = "ensemble" },
        { detailKey = "darkspearHeritage", itemId = 211446, name = "Ensemble: Heritage of the Darkspear", requirements = "Level 50+ Darkspear Troll character", subtype = "ensemble" },
        {
            detailKey = "darkspearHeritage",
            itemId = 218105,
            name = "Loa's Blade-Blessing",
            requirements = "Complete the Darkspear heritage questline; a May 16, 2024 hotfix removed the original sword-user class restriction",
            subtype = "ensemble",
        },
        { detailKey = "harbingerWeapons", itemId = 213269, name = "Bow of the Ranger Captain", subtype = "appearance" },
        { detailKey = "harbingerWeapons", itemId = 217711, name = "Voidtouched Flail", subtype = "appearance" },
        { detailKey = "harbingerWeapons", itemId = 217712, name = "Voidtouched Apparatus", subtype = "appearance" },
        { detailKey = "harbingerWeapons", itemId = 217713, name = "Voidtouched Shield", subtype = "appearance" },
        { detailKey = "harbingerWeapons", itemId = 217714, name = "Voidtouched Scimitar", subtype = "appearance" },
        {
            cost = "1 Awakened Frost and 100 Dragon Isles Supplies",
            detailKey = "missingDracthyrPieces",
            itemId = 217891,
            name = "Cobalt Guardian's Cloak",
            requirements = "Cobalt Assembly power at High",
            subtype = "appearance",
        },
        { cost = "2,500 Elemental Overflow", detailKey = "missingDracthyrPieces", itemId = 217892, name = "Emerald Winglord's Shoulders", subtype = "appearance" },
        { cost = "2,500 Elemental Overflow", detailKey = "missingDracthyrPieces", itemId = 217893, name = "Emerald Winglord's Chain", subtype = "appearance" },
    },
})
