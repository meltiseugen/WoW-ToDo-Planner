local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.1", {
    label = "Patch 9.1: Chains of Domination",
    sourceNotes = {
        "This audited backfill covers eligible mounts, battle pets, toys, cosmetic items, and visible achievements introduced with Chains of Domination.",
        "The patch boundary was checked against the final 9.0.5 and 9.1.0 DB2 snapshots. The anniversary pet and toy, shop and promotional rewards, NPC-only pet species, hidden tracking, statistics, and unavailable records are excluded.",
        "Cosmetics use covenant ensemble wrappers instead of duplicating their internal set pieces, while individually collected glasses, Maw backs, shoulders, and Korthian cloaks remain separate entries.",
        "Ordinary stat-bearing raid, dungeon, PvP, and world-drop equipment is not duplicated in Cosmetics.",
    },
    sourceUrls = {
        mounts = "https://www.wowhead.com/guide/new-mounts-chains-of-domination-patch-9-1",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23685044",
        overview = "https://www.wowhead.com/guide/shadowlands-chains-of-domination-patch-9-1-features",
        pets = "https://www.wowhead.com/guide/battle-pets-chains-of-domination-shadowlands-patch-9-1",
        transmog = "https://www.wowhead.com/guide/transmog-updates-chains-of-domination-patch-9-1",
    },
    wowheadPatchId = 90100,
})
