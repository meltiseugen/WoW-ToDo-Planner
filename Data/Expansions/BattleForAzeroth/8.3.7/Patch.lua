local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.3.7", {
    label = "Patch 8.3.7: Battle for Azeroth Client Update",
    sourceNotes = {
        "The final 8.3.7 snapshot adds no eligible permanent in-game collection record in the five supported categories.",
        "The Steamscale Incinerator shop mount plus hidden account-wide Essence trackers and raid statistics are intentionally excluded.",
    },
    sourceUrls = { patch = "https://warcraft.wiki.gg/wiki/Patch_8.3.7" },
    wowheadPatchId = 80307,
})
