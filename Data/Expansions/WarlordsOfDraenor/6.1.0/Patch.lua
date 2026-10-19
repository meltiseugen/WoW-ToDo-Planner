local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.1.0", {
    label = "Patch 6.1: Garrisons Update",
    sourceNotes = {
        "This bucket follows live availability on February 24, 2015: the heirloom collection, Garrison visitors and missions, the S.E.L.F.I.E. camera, jukebox rewards, Raiding with Leashes III, and Edge of Reality portals.",
        "Darkmoon Faire, Winter Veil, store, promotion, test, and ordinary equipment records are excluded under the catalogue-wide rules.",
        "Blackrock Foundry itself remains in the initial-release bucket because the raid opened before patch 6.1; Chapter III is here because its legendary-quest achievement arrived with this client patch.",
    },
    sourceUrls = {
        garrison = "https://www.wowhead.com/guide/garrisons/upcoming-patch-6-1-garrison-changes",
        official = "https://worldofwarcraft.blizzard.com/news/17953992/patch-61-now-live",
        pets = "https://www.wowhead.com/guide/battle-pets/6-1-battle-pet-updates",
        toys = "https://www.wowhead.com/guide/toy-box-a-look-inside-the-box-2381",
    },
    wowheadPatchId = 60100,
})
