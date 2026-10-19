local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.1.0", {
    cosmeticDetailGroups = {
        chosenDeadEnsembles = {
            acquisition = "Obtain the matching Chosen Dead ensemble from Trial of Valor's difficulty-specific reward path.",
            source = "Trial of Valor",
            sourceType = "Raid ensemble",
            tips = "The four armor types and multiple difficulty colors use separate wrapper IDs; verify the intended color before farming.",
        },
    },
    label = "Patch 7.1: Return to Karazhan",
    sourceNotes = {
        "This bucket follows live availability: Return to Karazhan, Trial of Valor, Insurrection, Falcosaur content, Raiding with Leashes IV, and Legion PvP Season 2 are assigned to 7.1.",
        "Nighthold records that existed in the 7.1 client data are assigned to 7.1.5 below because the raid opened after that patch went live.",
    },
    sourceUrls = {
        alcaz = "https://www.wowhead.com/news/patch-7-1-new-adventures-in-the-broken-isles-and-alcaz-island-spotlight-257053",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/20335228/notas-do-patch-71-de-world-of-warcraft-retorno-a-karazhan",
        overview = "https://www.wowhead.com/news/patch-7-1-survival-guide-return-to-karazhan-suramar-campaign-raiding-with-257057?page=5",
    },
    wowheadPatchId = 70100,
})
