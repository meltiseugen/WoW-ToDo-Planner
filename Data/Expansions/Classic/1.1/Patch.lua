local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.1", {
    label = "World of Warcraft Launch",
    sourceNotes = {
        "Patch 1.1.0 was the North American commercial release build. For catalogue attribution, the shared pre-release collection is kept in the 1.0 baseline while 1.1 records the patch's explicit new collection additions: the Paladin Warhorse and tauren kodo mounts replacing Plainsrunning.",
        "Brown Kodo and Gray Kodo remain normal vendor mounts. Green Kodo and Teal Kodo were the original epic variants and became unobtainable when patch 1.4 introduced the Great Kodo replacements; original owners can still retain them.",
        "Molten Core, Onyxia's Lair, racial traits, ordinary raid equipment, temporary test loot, and Collector's Edition promotions do not add eligible permanent collection records to this bucket. Achievements did not yet exist.",
    },
    sourceUrls = {
        builds = "https://warcraft.wiki.gg/wiki/World_of_Warcraft_client_builds",
        kodos = "https://warcraft.wiki.gg/wiki/Kodo_mounts",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.1.0",
    },
    wowheadPatchId = 10100,
})
