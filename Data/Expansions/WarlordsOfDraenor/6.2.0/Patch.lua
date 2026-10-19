local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.0", {
    cosmeticDetailGroups = {
        campaignSets = {
            acquisition = "Complete the matching faction campaign reward path and open the packaged cosmetic set.",
            source = "Faction Tanaan campaign",
            sourceType = "Campaign cosmetic set",
            tips = "Alliance and Horde rewards require their respective campaign.",
        },
        pvpTabards = {
            acquisition = "Earn the faction tabard during Warlords PvP Season 2; retained for historical collection tracking.",
            source = "Warlords rated PvP Season 2",
            sourceType = "PvP season reward",
            tips = "This original elite-season reward is no longer obtainable.",
        },
        reputationTabards = {
            acquisition = "Reach Exalted with the matching faction and purchase its tabard.",
            source = "Tanaan Jungle faction quartermasters",
            sourceType = "Reputation reward",
            tips = "Combine Tanaan daily objectives with Medallions of the Legion.",
            waypoints = { "/way #534 57.6 59.4 Lion's Watch", "/way #534 61.0 45.8 Vol'mar" },
        },
    },
    label = "Patch 6.2: Fury of Hellfire",
    sourceNotes = {
        "This catalogue covers Tanaan Jungle, Hellfire Citadel, the Garrison Shipyard and naval missions, Warlords PvP Season 2, and the permanent collection records released with Fury of Hellfire.",
        "Records are assigned by live availability. Store, Collector's Edition, promotion, calendar-event, test, NPC-only, hidden-statistic, and ordinary equipment records are excluded; historical raid and PvP rewards remain visible.",
        "Cosmetics are limited to durable tabards and packaged cosmetic sets. Ordinary Hellfire Citadel, quest, and PvP stat gear remains outside the catalogue.",
    },
    sourceUrls = {
        notes = "https://worldofwarcraft.blizzard.com/en-us/news/18539917",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/19803325/patch-6-2-fury-of-hellfire-arrives-june-23",
        overview = "https://www.wowhead.com/guide/tanaan-jungle",
        pets = "https://www.wowhead.com/guide/battle-pets/new-6-2-pets",
        toys = "https://www.wowhead.com/guide/vanity-collections/new-toys-in-patch-6-2",
    },
    wowheadPatchId = 60200,
})
