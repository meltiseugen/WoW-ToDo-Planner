local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.2.7", {
    label = "Patch 9.2.7: Auction House Update",
    sourceNotes = {
        "No eligible collection records were introduced by patch 9.2.7 after the audit exclusions are applied.",
        "The Frostbrood Proto-Wyrm is a Wrath of the Lich King Classic promotion, and achievement 16414 is hidden raid-portal tracking; both are intentionally excluded.",
        "Shadowlands Season 4 rewards remain assigned to 9.2.5, where their client records and season content shipped.",
    },
    sourceUrls = { official = "https://worldofwarcraft.blizzard.com/en-us/news/23833174" },
    wowheadPatchId = 90207,
})
