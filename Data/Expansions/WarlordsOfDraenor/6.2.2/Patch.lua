local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.2", {
    label = "Patch 6.2.2: Draenor Flying",
    sourceNotes = {
        "This bucket includes Draenor flying availability, the Burning Crusade and Wrath Timewarped Badge vendors, the three flying-access Nagrand pets, and collection achievements introduced by the 6.2.2 client.",
        "Season 3 and Cataclysm Timewalking records present in the client are moved to 6.2.3, when players could actually obtain them.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/19828438",
        overview = "https://warcraft.wiki.gg/wiki/Patch_6.2.2",
        release = "https://worldofwarcraft.blizzard.com/en-us/news/19881984/prepare-for-lift-off-patch-622-takes-flight-september-1",
    },
    wowheadPatchId = 60202,
})
