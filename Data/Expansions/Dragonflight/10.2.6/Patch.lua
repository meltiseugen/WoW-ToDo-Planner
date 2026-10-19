local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("10.2.6", {
    label = "Patch 10.2.6: Plunderstorm / Dragonflight Season 4",
    sourceNotes = {
        "This mounts-only audit covers permanent, seasonal, Timewalking, and original Plunderstorm rewards introduced with patch 10.2.6.",
        "Calendar holidays, Trading Post, shop, promotional, crossover, hidden, and unavailable records are excluded.",
        "Pets, toys, and achievements are audited. Cosmetics has no eligible learn-on-use rows because Plunderstorm appearances are granted directly to the wardrobe.",
    },
    sourceUrls = {
        overview = "https://warcraft.wiki.gg/wiki/Patch_10.2.6",
        plunderstorm = "https://worldofwarcraft.blizzard.com/en-us/news/24057476",
        seasonFour = "https://worldofwarcraft.blizzard.com/en-us/news/24066682",
    },
    wowheadPatchId = 100206,
})
