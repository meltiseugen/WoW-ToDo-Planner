local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.3.5", "toys", {
    entries = {
        {
            acquisition = "Obtain Gnomeregan Pride from the historical Operation: Gnomeregan questline.",
            category = "Quest Rewards",
            itemId = 54651,
            name = "Gnomeregan Pride",
            source = "the historical Operation: Gnomeregan questline",
            tips = "This was awarded by the limited pre-Cataclysm Alliance event and is no longer obtainable from its original source.",
            waypoints = { "/way #87 69.0 49.0 Operation: Gnomeregan historical staging area" },
        },
        {
            acquisition = "Obtain Darkspear Pride from the historical Zalazane's Fall questline.",
            category = "Quest Rewards",
            itemId = 54653,
            name = "Darkspear Pride",
            source = "the historical Zalazane's Fall questline",
            tips = "This was awarded by the limited pre-Cataclysm Horde event and is no longer obtainable from its original source.",
            waypoints = { "/way #1 55.8 74.8 Zalazane's Fall historical staging area" },
        },
    },
    details = {
        ["Darkspear Pride"] = {
            acquisition = "Obtain Darkspear Pride from the historical Zalazane's Fall questline.",
            source = "the historical Zalazane's Fall questline",
            sourceType = "Toy Box Source",
            tips = "This was awarded by the limited pre-Cataclysm Horde event and is no longer obtainable from its original source.",
            waypoints = { "/way #1 55.8 74.8 Zalazane's Fall historical staging area" },
        },
        ["Gnomeregan Pride"] = {
            acquisition = "Obtain Gnomeregan Pride from the historical Operation: Gnomeregan questline.",
            source = "the historical Operation: Gnomeregan questline",
            sourceType = "Toy Box Source",
            tips = "This was awarded by the limited pre-Cataclysm Alliance event and is no longer obtainable from its original source.",
            waypoints = { "/way #87 69.0 49.0 Operation: Gnomeregan historical staging area" },
        },
    },
})
