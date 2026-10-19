local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.2.0", {
    cosmeticDetailGroups = {
        classArsenals = {
            acquisition = "Complete the matching class campaign requirements and obtain the arsenal on the eligible class.",
            source = "Broken Shore class campaign",
            sourceType = "Class campaign arsenal",
            tips = "These arsenals are class restricted. Finish the Order Hall campaign and Broken Shore progression before checking the class source.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        legacyPvPArsenals = {
            acquisition = "Purchase the matching historical weapon arsenal with Marks of Honor from its legacy PvP vendor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP arsenal",
            tips = "Check the arsenal tooltip before purchase; class restrictions and already-known appearances can change its value.",
        },
        legionfallTabard = {
            acquisition = "Reach Exalted with the Armies of Legionfall and purchase the Legionfall Tabard from the faction quartermaster.",
            source = "Armies of Legionfall",
            sourceType = "Reputation reward",
            tips = "Prioritize Broken Shore world quests, Legion Assaults, and reputation tokens.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        pvpEnsembles = {
            acquisition = "Purchase the matching historical armor ensemble with Marks of Honor from its legacy PvP vendor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP ensemble",
            tips = "Many rows have Alliance and Horde item IDs with the same display name. Keep both IDs because the collection API tracks the wrapper items separately.",
        },
        pvpTabards = {
            acquisition = "Earn the tabard during its rated PvP season; retained here for historical collection tracking.",
            source = "Legion rated PvP seasons",
            sourceType = "PvP season reward",
            tips = "Seasonal elite rewards may no longer be obtainable on a new character.",
        },
    },
    label = "Patch 7.2: The Tomb of Sargeras",
    sourceNotes = {
        "This audit combines the historical 7.3.5 client database with contemporary Patch 7.2 collection guides and the official patch notes.",
        "The catalogue keeps permanent and historically trackable in-game collectibles and visible achievements. Store, Collector's Edition, calendar-event, test, NPC-only, hidden-statistic, and unused records are excluded.",
        "The 7.2 wardrobe additions include actual ensemble and arsenal wrapper items. Ordinary raid, dungeon, quest, and PvP equipment is outside this collection catalogue; artifact appearances without a stable item ID are represented by their associated achievements instead.",
    },
    sourceUrls = {
        brokenShore = "https://www.wowhead.com/news/everything-to-do-on-the-broken-shore-in-patch-7-2-260962",
        classMounts = "https://www.wowhead.com/news/power-ascended-artifact-rewards-in-7-2-class-mounts-pets-toys-260678",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/20629899",
        overview = "https://www.wowhead.com/guide/patch-7-2-overview-5775",
        pets = "https://www.wowhead.com/guide/pet-battle-dungeon-and-7-2-pets-4993",
    },
    wowheadPatchId = 70200,
})
