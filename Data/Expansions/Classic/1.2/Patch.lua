local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.2", {
    label = "Mysteries of Maraudon",
    sourceNotes = {
        "Patch 1.2.0 opened Maraudon and added interface options for hiding helm and cloak graphics. Its dungeon loot is ordinary equipment rather than a mount, battle pet, Toy Box item, standalone cosmetic, or achievement reward.",
        "The patch also began recurring seasonal and Gurubashi Arena content, which remains excluded under the catalogue-wide recurring-event rule. The Piccolo of the Flaming Fire received a behavior adjustment here but stays attributed to the 1.0 source collection rather than duplicated.",
        "No eligible permanent collection records remain after those exclusions, and achievements did not yet exist.",
    },
    sourceUrls = { maraudon = "https://warcraft.wiki.gg/wiki/Maraudon", patch = "https://warcraft.wiki.gg/wiki/Patch_1.2.0", piccolo = "https://warcraft.wiki.gg/wiki/Piccolo_of_the_Flaming_Fire" },
    wowheadPatchId = 10200,
})
