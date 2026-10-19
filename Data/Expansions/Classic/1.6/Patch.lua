local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.6", {
    label = "Assault on Blackwing Lair",
    sourceNotes = {
        "Patch 1.6.0 introduced Blackwing Lair and the Darkmoon Faire. The Faire's original permanent companions are Wood Frog, Tree Frog, and Jubling.",
        "Flik sells both frog boxes during the Faire, with Wood Frog Box on limited stock. Jubling requires Dark Iron Ale from Blackrock Depths, the Spawn of Jubjub quest from Morja, and a seven-day egg hatch.",
        "Blackwing Lair equipment, Darkmoon cards and consumable prizes, ordinary equipment, and later Faire additions are not attributed here. The Darkmoon Cannon arrived in patch 1.9 and Steam Tonks in patch 1.10; achievements did not yet exist.",
    },
    sourceUrls = {
        faire = "https://warcraft.wiki.gg/wiki/Darkmoon_Faire",
        jubling = "https://warcraft.wiki.gg/wiki/Spawn_of_Jubjub",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.6.0",
        treeFrog = "https://warcraft.wiki.gg/wiki/Tree_Frog_Box",
        woodFrog = "https://warcraft.wiki.gg/wiki/Wood_Frog_Box",
    },
    wowheadPatchId = 10600,
})
