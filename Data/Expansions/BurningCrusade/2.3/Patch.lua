local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.3", {
    label = "The Gods of Zul'Aman",
    sourceNotes = {
        "Patch 2.3 opens Zul'Aman and adds its timed Amani War Bear and Mojo rewards, the Cenarion War Hippogryph, Tiny Sporebat, engineering flying machines, and the Arena Season 2 mount.",
        "Merciless Nether Drake uses the durable current mount spell 44744; an additional historical DB2 record with the same display name is not a separate player collection mount.",
        "The Paper Flying Machine Kit and other trading-card, promotion, recurring holiday, unused, NPC-only, and ordinary equipment records are excluded. Achievements did not exist during patch 2.3; later retroactive Burning Crusade feats remain in the 3.0 achievement-system bucket.",
    },
    sourceUrls = {
        flyingMachine = "https://warcraft.wiki.gg/wiki/Flying_Machine",
        mojo = "https://warcraft.wiki.gg/wiki/Mojo_(companion)",
        patch = "https://warcraft.wiki.gg/wiki/2.3",
        undocumented = "https://warcraft.wiki.gg/wiki/Patch_2.3.0_(undocumented_changes)",
        warBear = "https://warcraft.wiki.gg/wiki/Amani_War_Bear",
    },
    wowheadPatchId = 20300,
})
