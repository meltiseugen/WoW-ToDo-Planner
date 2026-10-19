local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.8", {
    label = "Dragons of Nightmare",
    sourceNotes = {
        "Patch 1.8.0 introduced the four outdoor Dragons of Nightmare, the Silithus revamp, and Hallow's End, but no eligible non-seasonal permanent mount, companion, toy, tabard, or achievement.",
        "Dragon loot is ordinary equipment, while Hallow's End collectibles belong to a recurring seasonal event and remain excluded consistently with later patch buckets.",
    },
    sourceUrls = { dragons = "https://warcraft.wiki.gg/wiki/Dragons_of_Nightmare_(Classic)", patch = "https://warcraft.wiki.gg/wiki/Patch_1.8.0" },
    wowheadPatchId = 10800,
})
