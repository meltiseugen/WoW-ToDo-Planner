local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.0", {
    label = "Original World of Warcraft Baseline",
    sourceNotes = {
        "This catalogue uses 1.0 as the base-game collection bucket for permanent collectibles already present before the commercial launch build. Blizzard's North American release itself was patch 1.1.0; client-build records identify 1.0.0 and 1.0.1 as the final open-beta builds.",
        "The baseline contains the original racial and class mounts, Winterspring Frostsaber, Rivendare's Deathcharger, vendor, quest, drop, and Engineering companions, plus Orb of Deception and Piccolo of the Flaming Fire, the two launch-era items now tracked by the modern Toy Box.",
        "Fourteen original level-60 racial mounts are retained as Legacy records because patch 1.4 removed them from vendors without deleting copies already owned. Collector's Edition, promotion, recurring-event, ordinary equipment, and later retroactive achievement records are excluded; achievements did not exist in 1.0.",
    },
    sourceUrls = {
        builds = "https://warcraft.wiki.gg/wiki/World_of_Warcraft_client_builds",
        companions = "https://warcraft.wiki.gg/wiki/Companions_by_source",
        kodo = "https://warcraft.wiki.gg/wiki/Kodo_mounts",
        mounts = "https://warcraft.wiki.gg/wiki/Mount",
        species = "https://warcraft.wiki.gg/wiki/BattlePetSpeciesID",
        toys = "https://warcraft.wiki.gg/wiki/List_of_toys_by_source",
        winterspring = "https://warcraft.wiki.gg/wiki/Reins_of_the_Winterspring_Frostsaber",
    },
    wowheadPatchId = 10000,
})
