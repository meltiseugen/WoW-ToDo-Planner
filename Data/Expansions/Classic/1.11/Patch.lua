local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.11", {
    cosmeticDetailGroups = {
        scarletCrusadeTabard = {
            acquisition = "Defeat Scarlet Trainees in the Scarlet Monastery of Old for a chance to loot the tabard. It can also drop from Armsmaster Harlan in Scarlet Halls.",
            source = "Scarlet Trainees in Scarlet Monastery of Old",
            sourceType = "Dungeon drop",
            tips = "Use the old Scarlet Monastery entrance when targeting the restored original source. Equip the tabard before visiting the Scarlet Quartermaster at Darkmoon Faire if you also want the related modern appearances.",
            waypoints = { "/way #18 85.6 30.8 Scarlet Monastery entrance" },
        },
    },
    label = "Shadow of the Necropolis",
    sourceNotes = {
        "Patch 1.11.0 introduced original Naxxramas and its Scourge Invasion. Tabard of the Scarlet Crusade is the retained obtainable cosmetic; the retired Tabard of the Argent Dawn is excluded.",
        "The Scarlet tabard has Retail routes through the restored Old Scarlet Monastery and Scarlet Halls, and remains attributed to its original 1.11 introduction. Argent Dawn tabard replacements for eligible original owners do not provide a new-collector acquisition route.",
        "Naxxramas raid armor, Atiesh, Haunted Memento, temporary invasion effects, seasonal rewards, and ordinary equipment are not separate collection records here. Later Feats of Strength remain in the 3.0 achievement-system bucket.",
    },
    sourceUrls = {
        argentTabard = "https://warcraft.wiki.gg/wiki/Tabard_of_the_Argent_Dawn",
        invasion = "https://warcraft.wiki.gg/wiki/Scourge_Invasion",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.11.0",
        scarletTabard = "https://warcraft.wiki.gg/wiki/Tabard_of_the_Scarlet_Crusade",
    },
    wowheadPatchId = 11100,
})
