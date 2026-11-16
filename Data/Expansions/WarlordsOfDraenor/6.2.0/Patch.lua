local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.0", {
    cosmeticDetailGroups = {
        reputationEnsembles = {
            acquisition = "Reach Revered with Hand of the Prophet or Vol'jin's Headhunters and buy the matching class-restricted ensemble.",
            source = "Vindicator Krethos or Shadow Hunter Denjai in Tanaan Jungle",
            sourceType = "Reputation",
            tips = "Use the ensemble to learn its permanent appearances. Finishing the weekly Tanaan campaign is not required.",
        },
        reputationTabards = {
            acquisition = "Reach Exalted with the matching faction and purchase its tabard.",
            source = "Tanaan Jungle faction quartermasters",
            sourceType = "Reputation reward",
            tips = "Use the matching faction's reviewed daily, weekly or kill-reputation method; Medallions and Timewalking tokens are alternatives.",
        },
    },
    label = "Patch 6.2: Fury of Hellfire",
    sourceNotes = {
        "This catalogue covers Tanaan Jungle, Hellfire Citadel, the Garrison Shipyard and naval missions, Warlords PvP Season 2, and the permanent collection records released with Fury of Hellfire.",
        "Records are assigned by live availability. Store, Collector's Edition, promotion, calendar-event, test, NPC-only, hidden-statistic, and ordinary equipment records are excluded. Wild Gladiator's Tabards (127365 and 127366) are removed because their elite season has ended.",
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
