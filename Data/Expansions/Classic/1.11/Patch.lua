local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.11", {
    cosmeticDetailGroups = {
        argentDawnTabard = {
            acquisition = "During the patch 1.11 Scourge Invasion, complete the Argent Dawn event quest or obtain the tabard from an Argent quartermaster.",
            availability = "No longer obtainable from the original patch 1.11 event.",
            source = "Original Scourge Invasion",
            sourceType = "Historical world event",
            tips = "The original invasion has ended, so this tabard is retained for historical collection tracking. Light's Hope Chapel is the central Argent Dawn location associated with the event and Naxxramas attunement.",
            waypoints = { "/way #23 75.3 52.1 Light's Hope Chapel / Argent Dawn" },
        },
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
        "Patch 1.11.0 introduced original Naxxramas and its Scourge Invasion. Its two eligible permanent appearance records are the invasion's Tabard of the Argent Dawn and the newly added Tabard of the Scarlet Crusade.",
        "The Argent Dawn tabard is retained as a limited historical reward and points to Light's Hope Chapel, while the Scarlet tabard points to Scarlet Monastery. The latter was removed in patch 5.0.4 and subsequently restored, but remains attributed to its original 1.11 introduction.",
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
