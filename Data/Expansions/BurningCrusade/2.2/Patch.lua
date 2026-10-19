local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.2", {
    label = "Voice Chat",
    sourceNotes = {
        "Patch 2.2.0 focused on integrated voice chat, chat-interface changes, balance work, profession recipes, and corrections to existing items and companions.",
        "The official and undocumented notes add no eligible permanent mount, companion, Toy Box item, tabard, or achievement. Existing collection items changed by the patch remain attributed to the patch in which they became obtainable.",
    },
    sourceUrls = { patch = "https://warcraft.wiki.gg/wiki/Patch_2.2.0", undocumented = "https://warcraft.wiki.gg/wiki/Patch_2.2.0_(undocumented_changes)" },
    wowheadPatchId = 20200,
})
