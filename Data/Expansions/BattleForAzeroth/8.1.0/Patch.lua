local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.1.0", {
    cosmeticDetailGroups = {
        bloodElfHeritage = {
            acquisition = "Complete the Blood Elf heritage questline on an eligible Blood Elf to unlock all ten Sin'dorei appearances.",
            source = "Blood Elf heritage questline ending with The Pride of the Sin'dorei",
            sourceType = "Heritage Armor",
            tips = "Begin at the Orgrimmar Embassy once the character meets the current heritage-quest requirements.",
            waypoints = { "/way #85 39.2 79.0 Orgrimmar Embassy" },
        },
        dwarfHeritage = {
            acquisition = "Complete the Dwarf heritage questline on an eligible Dwarf to unlock all eight Bronzebeard appearances.",
            source = "Dwarf heritage questline ending with Heritage o' the Bronzebeard",
            sourceType = "Heritage Armor",
            tips = "Begin at the Stormwind Embassy, then follow the quest route through Ironforge and Dun Morogh.",
            waypoints = { "/way #84 54.6 18.0 Stormwind Embassy" },
        },
    },
    label = "Patch 8.1: Tides of Vengeance",
    sourceNotes = {
        "This audit compares the 8.0.1 and 8.1.0 client snapshots and reconciles records with contemporary Tides of Vengeance collection guides.",
        "The catalogue retains permanent and historically trackable in-game collectibles and visible achievements. Shop, promotion, holiday, hidden-statistic, NPC-only pet, test, and unused records are excluded.",
        "Cosmetics tracks the Blood Elf and Dwarf heritage sets. Ordinary raid, dungeon, warfront, island, and PvP stat gear is outside this collection catalogue.",
    },
    sourceUrls = {
        mounts = "https://www.wowhead.com/news/the-mounts-of-tides-of-vengeance-mount-resources-updated-for-patch-8-1-289065",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/22926354/tides-of-vengeance-content-update-notes",
        overview = "https://www.wowhead.com/guide/tides-of-vengeance-bfa-patch-8-1-overview",
        pets = "https://www.wowhead.com/news/the-pet-smugglers-and-battle-pets-of-tides-of-vengeance-289323",
    },
    wowheadPatchId = 80100,
})
