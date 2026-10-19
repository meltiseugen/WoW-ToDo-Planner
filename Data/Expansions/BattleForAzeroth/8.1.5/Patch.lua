local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.1.5", {
    cosmeticDetailGroups = {
        alliedRaceTabards = {
            acquisition = "Create the corresponding allied-race character after unlocking that race; its racial tabard is provided during the starting experience.",
            source = "Kul Tiran and Zandalari Troll recruitment rewards",
            sourceType = "Allied Race",
            tips = "Keep both faction variants in the tracker: one character cannot obtain both tabards.",
            waypoints = { "/way #1161 67.8 21.8 Boralus", "/way #1165 42.2 9.4 Dazar'alor" },
        },
        brawlersGarb = {
            acquisition = "Historically purchased after progressing through Brawler's Guild Season 4; each faction used its own ensemble item.",
            source = "Brawler's Guild Season 4 faction quartermasters",
            sourceType = "Brawler's Guild",
            tips = "This is retained as a historical patch collectible. Season 4 ended with the Shadowlands pre-patch; verify the current reintroduction source before planning a live acquisition route.",
            waypoints = { "/way #84 68.5 31.6 Bizmo's Brawlpub entrance", "/way #85 57.4 14.6 Brawl'gar Arena entrance" },
        },
        kulTiranHeritage = {
            acquisition = "Complete Heritage of the Kul Tirans on an eligible Kul Tiran to unlock all eight appearances.",
            source = "Kul Tiran heritage questline",
            sourceType = "Heritage Armor",
            tips = "Check Katherine Proudmoore in Boralus when the character meets the current heritage-quest requirements.",
            waypoints = { "/way #1161 67.8 21.8 Katherine Proudmoore / Boralus" },
        },
        zandalariHeritage = {
            acquisition = "Complete Heritage of the Zandalari on an eligible Zandalari Troll to unlock all eight appearances.",
            source = "Zandalari Troll heritage questline",
            sourceType = "Heritage Armor",
            tips = "Check Queen Talanji in Dazar'alor when the character meets the current heritage-quest requirements.",
            waypoints = { "/way #1165 42.2 9.4 Queen Talanji / Dazar'alor" },
        },
    },
    label = "Patch 8.1.5: Tides of Vengeance",
    sourceNotes = {
        "This audit compares the late 8.1 and 8.1.5 client snapshots, then assigns dormant records by when their content actually became obtainable.",
        "The catalogue retains permanent and historically trackable in-game collectibles and visible achievements. Shop, promotion, holiday, Darkmoon Faire, hidden-statistic, NPC-only pet, test, and unused records are excluded.",
        "Cosmetics tracks the Kul Tiran and Zandalari heritage sets, allied-race tabards, and the historical Brawler's Guild Season 4 faction ensembles; ordinary raid and dungeon stat gear is outside scope.",
    },
    sourceUrls = {
        collections = "https://www.wowhead.com/classic/news/new-collectible-mounts-pets-and-toys-in-patch-8-1-5-290618",
        notes = "https://www.wowhead.com/news/official-patch-notes-for-tides-of-vengeance-patch-8-1-5-290635",
        overview = "https://www.wowhead.com/news/patch-8-1-5-tides-of-vengeance-survival-guide-giveaway-290632",
        transmog = "https://www.wowhead.com/news/brawlers-guild-transmog-armor-in-patch-8-1-5-289622",
    },
    wowheadPatchId = 80105,
})
