local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.1.5", {
    cosmeticDetailGroups = {
        brawlerShirts = {
            acquisition = "Defeat the associated Brawler's Guild opponent or buy the unlocked shirt from the guild vendor.",
            source = "Brawler's Guild",
            sourceType = "Brawler's Guild cosmetic",
            tips = "Brawler's Guild seasons rotate and may be inactive; retained here for historical collection tracking.",
            waypoints = { "/way #85 70.6 31.6 Brawl'gar Arena entrance" },
        },
        legacyPvPArsenals = {
            acquisition = "Purchase the matching historical weapon arsenal with Marks of Honor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP arsenal",
            tips = "Check class restrictions and already-known appearances before purchase.",
        },
        legacyPvPEnsembles = {
            acquisition = "Purchase the matching historical armor ensemble with Marks of Honor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP ensemble",
            tips = "Many rows have faction variants with the same display name but distinct wrapper IDs.",
        },
    },
    label = "Patch 7.1.5",
    sourceNotes = {
        "This bucket includes Nighthold because the raid opened during the 7.1.5 period, plus the renewed Brawler's Guild season and Mists of Pandaria Timewalking collection rewards.",
        "Ordinary raid and PvP gear is excluded; stable ensemble, arsenal, shirt, mount, pet, toy, and visible achievement records remain directly trackable.",
    },
    sourceUrls = {
        notes = "https://worldofwarcraft.blizzard.com/en-gb/news/20457825/patch-notes-world-of-warcraft-patch-7-1-5",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/20457780/patch-7-1-5-now-live",
        overview = "https://www.wowhead.com/ptr/guide/patch-7-1-5-overview-5774",
    },
    wowheadPatchId = 70105,
})
