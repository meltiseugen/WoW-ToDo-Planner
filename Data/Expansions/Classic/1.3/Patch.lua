local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.3", {
    label = "Ruins of the Dire Maul",
    sourceNotes = {
        "Patch 1.3.0 opened Dire Maul, introduced Azuregos and Lord Kazzak as outdoor raid encounters, added Meeting Stones, and imposed dungeon player caps.",
        "Dire Maul books, class trinkets, tribute gear, recipes, consumables, and the outdoor bosses' equipment are ordinary equipment rather than eligible mount, battle-pet, Toy Box, standalone-cosmetic, or achievement records.",
        "No eligible permanent collection records remain for this patch, and achievements did not yet exist. The later Dreadsteed ritual used Dire Maul but is correctly attributed to patch 1.4, when that class quest was added.",
    },
    sourceUrls = { direMaul = "https://warcraft.wiki.gg/wiki/Dire_Maul_(original)", patch = "https://warcraft.wiki.gg/wiki/Patch_1.3.0" },
    wowheadPatchId = 10300,
})
