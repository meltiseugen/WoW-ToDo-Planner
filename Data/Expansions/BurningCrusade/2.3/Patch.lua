local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.3", {
    label = "The Gods of Zul'Aman",
    sourceNotes = {
        "The obtainable patch 2.3 collection includes Mojo, the Cenarion War Hippogryph, Tiny Sporebat and the engineering flying machines. The removed Zul'Aman timed-raid bear and original Arena-season mount are excluded.",
        "The Paper Flying Machine Kit and other trading-card, promotion, recurring holiday, unused, NPC-only and ordinary equipment records are excluded. Shared Burning Crusade-content achievements, including the cooking dailies, are registered in 2.0; the regular Vengeful Gladiator appearance-set achievement remains here. The retired original Zul'Aman and seasonal title achievements are excluded.",
    },
    sourceUrls = {
        flyingMachine = "https://warcraft.wiki.gg/wiki/Flying_Machine",
        mojo = "https://warcraft.wiki.gg/wiki/Mojo_(companion)",
        patch = "https://warcraft.wiki.gg/wiki/2.3",
        undocumented = "https://warcraft.wiki.gg/wiki/Patch_2.3.0_(undocumented_changes)",
    },
    wowheadPatchId = 20300,
})
