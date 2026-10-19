local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.2", {
    cosmeticDetailGroups = {
        pvpTabard = {
            acquisition = "Earn the elite Tyrannical Gladiator's Tabard during Mists PvP Season 13.",
            source = "Mists PvP Season 13",
            sourceType = "Elite PvP season reward",
            tips = "The original elite-season source is no longer obtainable.",
        },
        thunderTabards = {
            acquisition = "Reach Exalted with the matching faction and purchase its tabard.",
            source = "Isle of Thunder factions",
            sourceType = "Reputation tabard",
            tips = "Kirin Tor Offensive is Alliance, Sunreaver Onslaught is Horde, and Shado-Pan Assault reputation comes primarily from Throne of Thunder.",
        },
    },
    label = "Patch 5.2: The Thunder King",
    sourceNotes = {
        "This bucket covers the Isle of Thunder, Isle of Giants, Throne of Thunder, Zandalari Warbringers, Beasts of Fable, the green-fire quest, and Mists PvP Season 13.",
        "Original live availability is used for mounts and pets. Event, shop, TCG, promotion, hidden-statistic, NPC-only, and ordinary equipment records are excluded; historical raid and PvP rewards remain visible.",
        "Toys use their current Toy Box item IDs even where the object was converted to a toy in a later expansion.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/8896363/52-the-thunder-king-patch-notes",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.2.0",
        throne = "https://warcraft.wiki.gg/wiki/Throne_of_Thunder",
        thunder = "https://warcraft.wiki.gg/wiki/Isle_of_Thunder",
    },
    wowheadPatchId = 50200,
})
