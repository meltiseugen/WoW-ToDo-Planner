local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.4", {
    label = "Patch 6.2.4",
    sourceNotes = {
        "The official 6.2.4 notes contain infrastructure, client, and bug-fix changes but no eligible permanent collection records.",
        "Warcraft movie promotional weapon appearances are excluded by the catalogue's promotion rule, so this is an explicit audited empty bucket.",
    },
    sourceUrls = { official = "https://worldofwarcraft.blizzard.com/en-us/news/20095769/world-of-warcraft-patch-6-2-4" },
    wowheadPatchId = 60204,
})
