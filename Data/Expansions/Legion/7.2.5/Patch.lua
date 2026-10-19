local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.2.5", {
    cosmeticDetailGroups = {
        chromieEnsembles = {
            acquisition = "Advance Chromie's scenario research and open its time-lost rewards for the four armor-type ensembles.",
            source = "The Deaths of Chromie",
            sourceType = "Scenario ensemble",
            tips = "Raise Chromie's reputation and research scenario talents first; faster clears create more opportunities to open reward containers.",
            waypoints = { "/way #115 60.0 49.0 Wyrmrest Temple / Chromie" },
        },
        pvpTabards = {
            acquisition = "Earn the Ferocious Gladiator tabard during its rated PvP season; retained for historical tracking.",
            source = "Legion rated PvP Season 4",
            sourceType = "PvP season reward",
            tips = "This elite seasonal reward may no longer be obtainable.",
        },
    },
    label = "Patch 7.2.5",
    sourceNotes = {
        "This audit assigns content by live availability: Tomb of Sargeras opened during 7.2.5, even where its records existed in the earlier client data.",
        "Permanent and historically trackable collectibles and visible achievements are retained. Calendar events, store items, promotions, test records, and ordinary stat gear are excluded.",
    },
    sourceUrls = {
        collections = "https://www.wowhead.com/news/patch-7-2-5-collectors-guide-pets-toys-titles-and-more-265853",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/20812012/world-of-warcraft-725-patch-notes",
        overview = "https://www.wowhead.com/guide/patch-7-2-5-overview-5771",
    },
    wowheadPatchId = 70205,
})
