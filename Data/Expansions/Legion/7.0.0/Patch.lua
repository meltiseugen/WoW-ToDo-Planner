local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.0.0", {
    cosmeticDetailGroups = {
        legacyPvPArsenals = {
            acquisition = "Purchase the matching historical weapon arsenal with Marks of Honor from its legacy PvP vendor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP arsenal",
            tips = "Check the arsenal tooltip for class restrictions and already-known appearances before purchase.",
        },
        legacyPvPEnsembles = {
            acquisition = "Purchase the matching historical armor ensemble with Marks of Honor from its legacy PvP vendor.",
            source = "Legacy PvP ensemble vendors",
            sourceType = "PvP ensemble",
            tips = "Alliance and Horde wrappers can share a display name while retaining different item IDs; check armor and class restrictions before purchase.",
        },
        reputationTabards = {
            acquisition = "Raise the matching Broken Isles faction reputation and purchase its tabard from the quartermaster.",
            source = "Broken Isles faction quartermasters",
            sourceType = "Reputation reward",
            tips = "Complete zone quests and world quests for reputation, then verify the required standing before visiting the vendor.",
        },
    },
    label = "Legion (Initial Release)",
    sourceNotes = {
        "This launch audit includes the 7.0.3 pre-expansion systems and the initial Legion collection set available through the opening raid tier.",
        "The catalogue reconciles the final Legion client database with contemporary collection guides and All The Things source metadata. It retains permanent and historically trackable in-game rewards while excluding store, Collector's Edition, calendar-event, test, NPC-only, hidden-statistic, and ordinary equipment records.",
        "Wardrobe rows are stable ensemble, arsenal, and tabard item IDs. Individual quest, dungeon, raid, and PvP gear appearances remain outside the catalogue.",
    },
    sourceUrls = {
        mounts = "https://www.wowhead.com/guide/legion-mounts",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/20151961/legion-pre-expansion-patch-notes",
        pets = "https://www.wowhead.com/guide/battle-pets/legion/overview",
    },
    wowheadPatchId = 70000,
})
