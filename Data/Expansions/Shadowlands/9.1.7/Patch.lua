local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.1.7", {
    label = "Patch 9.1.7: Not Released",
    sourceNotes = {
        "Retail World of Warcraft did not release a 9.1.7 client; patch chronology proceeds directly from 9.1.5 to 9.2.0.",
        "This explicit empty entry preserves the requested patch sequence without misassigning late 9.1.5 records or 9.2 PTR data.",
    },
    sourceUrls = { chronology = "https://warcraft.wiki.gg/wiki/Patch_9.1.5" },
    wowheadPatchId = 90107,
})
