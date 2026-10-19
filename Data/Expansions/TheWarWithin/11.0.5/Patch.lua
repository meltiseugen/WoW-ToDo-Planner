local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("11.0.5", {
    cosmeticDetailGroups = {
        anniversaryColdflame = {
            acquisition = "Buy the four Blizzard service-award-inspired appearance tokens with Bronze Celebration Tokens during the anniversary event.",
            availability = "Seasonal anniversary inventory; originally introduced for the 20th anniversary celebration.",
            cost = "45 Bronze Celebration Tokens for all four.",
            source = "Historian Ma'di / 20th Anniversary Celebration camp",
            sourceType = "Anniversary Vendor",
            tips = "The crown, sword, and shield cost 10 tokens each; the back crest costs 15. Coldflame Ring is on the same vendor but is a toy, not a wardrobe appearance token.",
            waypoints = { "/way #71 62.7 50.4 Historian Ma'di / anniversary camp" },
        },
        anniversaryTierTwo = {
            acquisition = "Buy the Eternal Tier 2 class ensembles with Bronze Celebration Tokens during the anniversary celebration. Any class can purchase and learn every ensemble.",
            availability = "Originally available during the 20th anniversary event, October 22, 2024 through January 6, 2025; check the current anniversary vendor when the event returns.",
            costs = { "First ensemble: 60 Bronze Celebration Tokens", "Second: 40 after Upgraded Apparel", "Remaining ensembles: 20 each after Classy Dresser" },
            researchNotes = "The wrapper items are catalogued once; their internal armor appearances are not duplicated.",
            source = "Traeya / 20th Anniversary Celebration camp",
            sourceType = "Anniversary Vendor",
            tips = "The first ensemble costs 60 tokens and unlocks Upgraded Apparel; the second then costs 40 and unlocks Classy Dresser; every remaining ensemble costs 20. Purchase in that order before judging the total token requirement.",
            waypoints = { "/way #71 63.07 50.94 Traeya / anniversary camp" },
        },
        dragonflightLegacyPvP = {
            acquisition = "Buy the Crimson, Obsidian, and Verdant Aspirant/Gladiator ensemble wrappers from Seltherex, and the original elite recolors from Glamora when the character has the historic rating unlock.",
            costs = { "Armor ensemble: 12 Marks of Honor", "Weapon arsenal: 80 Marks of Honor" },
            requirements = "Elite armor originally required Rival I; elite weapon arsenals originally required Elite (2400 rating) in the matching Dragonflight season.",
            researchNotes = "All 99 consumable wrappers are explicitly generated from their contiguous Blizzard item-ID ranges. Individual weapons and armor taught by the wrappers are not duplicated.",
            source = "Seltherex and Glamora / Gladiator's Refuge, Valdrakken",
            sourceType = "Legacy PvP Vendors",
            tips = "Armor ensembles cost 12 Marks of Honor; weapon arsenals cost 80. There are 33 wrappers per Dragonflight season: four Aspirant armor types, thirteen Gladiator classes, thirteen Elite class sets, and three arsenals.",
            waypoints = { "/way #2112 44.6 37.0 Seltherex and Glamora / Gladiator's Refuge" },
        },
    },
    label = "Patch 11.0.5: 20th Anniversary Celebration",
    sourceNotes = {
        "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
        "Only disappearing learn-on-use appearance tokens, ensembles, and arsenals are included. Ordinary equippable anniversary gear and direct achievement rewards are excluded.",
        "The Cosmetics audit excludes Trading Post, Timewalking, and cross-game/crossover rewards, including Crests of the Kingdom, Prowler headgear, Blackrock Depths gear, and Golden Crests. Patch-native Timewalking mounts remain in the mounts catalog.",
        "Coldflame Ring is a toy and the Guest Relations thinking caps are not purple-arrow consumables, so neither is duplicated here.",
    },
    sourceUrls = {
        anniversary = "https://www.wowhead.com/guide/world-events/20th-anniversary-celebration-rewards",
        anniversaryOverview = "https://www.wowhead.com/guide/world-events/20th-anniversary-event",
        patch = "https://www.wowhead.com/guide/the-war-within/patch-11-0-5-overview",
        pvp = "https://www.wowhead.com/news/dragonflight-pvp-ensembles-coming-with-patch-11-0-5-elite-ensembles-included-346491",
    },
    wowheadPatchId = 110005,
})
