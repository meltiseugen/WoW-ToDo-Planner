local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("12.1.5", {
    label = "Patch 12.1.5: The Promise of Tomorrow",
    sourceNotes = {
        "Audited against live 12.1.5.70391 and the preceding 12.1.0.69933 client tables on October 15, 2026.",
        "Includes the Labyrinth of Kindo'jan, Aqir Invasions, the Unbinding of Kith'ix, campaign appearance tokens, and the Sporebearer Fungal Strider.",
        "Shop, Trading Post, recurring calendar events, housing decor, ordinary equipment, hidden trackers, statistics, and unsourced appearance variants are excluded.",
        "First-week and Season 2 rewards are available at review time; limited duration is documented without marking them retired early.",
    },
    sourceUrls = {
        achievements = "https://wago.tools/db2/Achievement/csv?build=12.1.5.70391",
        aqir = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards",
        coordinates = "https://github.com/DFortun81/AllTheThings/tree/master/db/Standard/Categories",
        labyrinth = "https://www.wowhead.com/guide/midnight/delves/labyrinth-of-kindojan-megadelve-nemesis-rewards",
        mounts = "https://wago.tools/db2/Mount/csv?build=12.1.5.70391",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/24304162/1215-content-update-notes",
        pets = "https://wago.tools/db2/BattlePetSpecies/csv?build=12.1.5.70391",
        raid = "https://www.wowhead.com/guide/midnight/raids/the-unbinding-of-kithix-boss-strategy-abilities-rewards",
        strider = "https://www.method.gg/guides/sporebearer-fungal-strider-5-million-gold-mount-vendor-location-in-wow-midnight",
        toys = "https://wago.tools/db2/Toy/csv?build=12.1.5.70391",
    },
    wowheadPatchId = 120105,
})
