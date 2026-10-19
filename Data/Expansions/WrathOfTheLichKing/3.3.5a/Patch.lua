local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.3.5a", {
    label = "Wrath 3.3.5a Client Update",
    sourceNotes = {
        "Patch 3.3.5a was a corrective client update following 3.3.5 and introduced no separately attributable permanent mounts, pets, toys, cosmetics, or achievements.",
        "It remains selectable so the final historical Wrath build is represented without moving Ruby Sanctum or pre-Cataclysm event rewards out of their 3.3.5 bucket.",
    },
    sourceUrls = { patchNotes = "https://warcraft.wiki.gg/wiki/Patch_3.3.5a" },
    wowheadPatchId = 30305,
})
