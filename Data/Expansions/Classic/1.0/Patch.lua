local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.0", {
    label = "Original World of Warcraft Baseline",
    sourceNotes = {
        "This catalogue uses 1.0 as the base-game collection bucket for permanent collectibles already present before the commercial launch build. Blizzard's North American release itself was patch 1.1.0; client-build records identify 1.0.0 and 1.0.1 as the final open-beta builds.",
        "The baseline contains the original racial and class mounts, Winterspring Frostsaber, Rivendare's Deathcharger, vendor, quest, drop, and Engineering companions, plus Orb of Deception and Piccolo of the Flaming Fire, the two launch-era items now tracked by the modern Toy Box.",
        "The fourteen original unarmored level-60 racial mounts were retired in patch 1.4 and are excluded from the obtainable Retail catalogue. Collector's Edition, promotion, recurring-event and ordinary equipment records are excluded.",
        "Obtainable Retail achievements about Classic content are grouped in 1.0, regardless of the later patch that introduced the achievement record. This includes original dungeons and raids, Classic zones and reputations, and Classic profession milestones. Permanently unavailable achievement records are excluded. Expansion-neutral milestones and cross-expansion metas have their own General section.",
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
