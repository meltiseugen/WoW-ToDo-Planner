local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.9", {
    label = "The Gates of Ahn'Qiraj",
    sourceNotes = {
        "Patch 1.9.0 introduced Ahn'Qiraj. The obtainable Retail catalogue retains the four resonating-crystal battle tanks from Temple trash; the retired Black Qiraji Battle Tank is excluded.",
        "Blue, green, red, and yellow tanks can only be summoned inside the Temple of Ahn'Qiraj; the red crystal is the rare variant. The black tank was usable elsewhere but required Bang a Gong! during the ten-hour window after the first gong strike and is no longer obtainable.",
        "Ahn'Qiraj armor, weapons, quest rewards and the recurring Lunar Festival are excluded under the established catalogue rules. Retroactive Ahn'Qiraj achievements are grouped with Classic content in 1.0.",
    },
    sourceUrls = {
        blackCrystal = "https://warcraft.wiki.gg/wiki/Black_Qiraji_Resonating_Crystal",
        gates = "https://warcraft.wiki.gg/wiki/Gates_of_Ahn%27Qiraj",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.9.0",
        silithidMounts = "https://warcraft.wiki.gg/wiki/Silithid_mounts",
        templeLoot = "https://warcraft.wiki.gg/wiki/Temple_of_Ahn%27Qiraj_loot",
    },
    wowheadPatchId = 10900,
})
