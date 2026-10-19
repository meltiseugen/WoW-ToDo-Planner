local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.0.0", {
    cosmeticDetailGroups = {
        cityTabards = {
            acquisition = "Build the matching faction building and purchase the city tabard.",
            source = "Dwarven Bunker or War Mill armor vendor",
            sourceType = "Garrison vendor",
            tips = "Alliance uses the Dwarven Bunker; Horde uses the War Mill.",
            waypoints = { "/way #582 40.0 37.0 Lunarfall", "/way #590 52.0 50.0 Frostwall" },
        },
        pvpTabards = {
            acquisition = "Earn the elite-season tabard during Warlords Season 1; retained for historical tracking.",
            source = "Warlords rated PvP Season 1",
            sourceType = "PvP season reward",
            tips = "The original elite-season source is no longer obtainable.",
        },
        reputationTabards = {
            acquisition = "Reach Exalted with the matching faction and purchase its tabard.",
            source = "Draenor faction quartermasters",
            sourceType = "Reputation reward",
            tips = "Combine daily objectives, quests, and Medallions of the Legion when available.",
            waypoints = { "/way #622 46.6 76.8 Stormshield", "/way #624 44.0 74.0 Warspear" },
        },
    },
    label = "Warlords of Draenor (Initial Release)",
    sourceNotes = {
        "This launch bucket includes the 6.0.2 Iron Tide systems update, the 6.0.3 expansion launch, Highmaul, and Blackrock Foundry—the complete initial Warlords collection tier before patch 6.1.",
        "The audit reconciles the final Legion-era client database with contemporary collection guides and All The Things source metadata. Store, Collector's Edition, promotion, calendar-event, hidden, test, NPC-only, and ordinary equipment records are excluded.",
        "Historical Challenge Mode, Brawler's Guild, Ashran, raid, and Warlords Season 1 rewards remain listed even when their original acquisition path has ended.",
    },
    sourceUrls = {
        mounts = "https://www.wowhead.com/guide/vanity-collections/mounts-from-the-garrison",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/15682579/the-iron-tide-602-patch-notes",
        overview = "https://www.wowhead.com/guide/warlords-of-draenor-an-expansion-overview-6120",
        pets = "https://www.wowhead.com/guide/battle-pets/battle-pet-updates-in-warlords-of-draenor",
        release = "https://worldofwarcraft.blizzard.com/en-us/news/16365525/patch-602-now-live-the-iron-tide-crashes-into-azeroth",
        toys = "https://www.wowhead.com/guide/toy-box-a-look-inside-the-box-2381",
    },
    wowheadPatchId = 60000,
})
