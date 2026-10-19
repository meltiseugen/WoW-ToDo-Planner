local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.0.0", {
    cosmeticDetailGroups = {
        alliedRaceTabards = {
            acquisition = "Create the corresponding allied-race character after unlocking that race; its racial tabard is provided during the starting experience.",
            source = "Dark Iron Dwarf and Mag'har Orc recruitment rewards",
            sourceType = "Allied Race",
            tips = "Keep both faction variants in the tracker: one character cannot obtain both tabards.",
            waypoints = { "/way #84 52.7 13.1 Stormwind Embassy", "/way #85 37.8 81.0 Orgrimmar Embassy" },
        },
        darkIronHeritage = {
            acquisition = "Complete Heritage o' the Dark Iron on an eligible Dark Iron Dwarf to unlock all eight appearances.",
            source = "Dark Iron Dwarf heritage questline",
            sourceType = "Heritage Armor",
            tips = "Check Moira Thaurissan at the Stormwind Embassy when the character meets the current heritage-quest requirements.",
            waypoints = { "/way #84 52.7 13.1 Moira Thaurissan / Stormwind Embassy" },
        },
        magharHeritage = {
            acquisition = "Complete Heritage of the Mag'har on an eligible Mag'har Orc to unlock the Blackrock, Frostwolf, and Warsong variants.",
            source = "Mag'har Orc heritage questline",
            sourceType = "Heritage Armor",
            tips = "The reward grants three color variants at once; check the Orgrimmar Embassy when eligible.",
            waypoints = { "/way #85 37.8 81.0 Orgrimmar Embassy" },
        },
    },
    label = "Patch 8.0: Battle for Azeroth",
    sourceNotes = {
        "The launch catalogue is keyed as 8.0.0 in TODO Planner; its record audit compares the final Legion 7.3.5 snapshot with the Battle for Azeroth 8.0.1 launch client.",
        "Permanent or historically trackable in-game mounts, pets, toys, Cosmetics, and visible achievements are retained. Shop, Collector's Edition, promotion, holiday, hidden-statistic, NPC-only pet, test, and unused records are excluded.",
        "Cosmetics covers the launch Dark Iron Dwarf and Mag'har Orc heritage sets and allied-race tabards. Ordinary quest, dungeon, raid, island, warfront, and PvP stat gear is outside this collection catalogue.",
    },
    sourceUrls = {
        collections = "https://www.wowhead.com/news/collection-updates-coming-in-the-8-0-battle-for-azeroth-pre-expansion-patch-285515",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/21959894/battle-for-azeroth-patch-notes",
        overview = "https://www.wowhead.com/guide/mount-collecting-battle-for-azeroth",
        pets = "https://www.wowhead.com/guide/collectable-pets-and-pet-items-in-battle-for-azeroth",
    },
    wowheadPatchId = 80001,
})
