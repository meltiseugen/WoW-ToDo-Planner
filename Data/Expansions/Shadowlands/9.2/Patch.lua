local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.2", {
    label = "Patch 9.2: Eternity's End",
    sourceNotes = {
        "This audited backfill covers eligible mounts, battle pets, toys, cosmetic items, and visible achievements introduced with Eternity's End.",
        "The patch boundary was checked against the final 9.1.5 and 9.2.0 DB2 snapshots, then corrected for source activation: the two Vicious Warstalkers belong to Shadowlands Season 4 in patch 9.2.5.",
        "Darkmoon Dance Competition, WoW Anniversary, promotion, shop, crossover, hidden tracking, placeholder, unavailable, and ordinary equippable-drop records are excluded.",
        "Cosmetics include the permanent Cosmetic-class Torghast weapons, the Domination Cache greatsword, and Enlightened paragon-cache cloaks and weapons; normal stat-bearing Zereth Mortis gear is not duplicated.",
    },
    sourceUrls = {
        enlightened = "https://www.wowhead.com/guide/the-enlightened-reputation-rewards-zereth-mortis",
        mawswornCosmetics = "https://www.wowhead.com/news/new-cosmetic-mawsworn-themed-weapon-transmogs-in-patch-9-2-325124",
        mounts = "https://www.wowhead.com/guide/shadowlands-mount-guide-10510",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23770462",
        protoform = "https://www.wowhead.com/guide/protoform-synthesis-crafting-system-mounts-pets-zereth-mortis",
        zerethMortis = "https://www.wowhead.com/guide/zereth-mortis-activities-how-to-unlock",
    },
    wowheadPatchId = 90200,
})
