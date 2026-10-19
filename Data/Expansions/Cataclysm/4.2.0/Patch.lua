local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("4.2.0", {
    label = "Patch 4.2: Rage of the Firelands",
    sourceNotes = {
        "This bucket covers the Regrowth and Molten Front campaign, Elemental Bonds, Firelands, Dragonwrath, revised companion-pet milestones, Baradin Hold's Occu'thar, and Cataclysm PvP Season 10.",
        "Original live availability is used. Shop, trading-card, promotion, calendar-event, hidden-statistic, unused, and ordinary equipment records are excluded; retired raid, guild, realm-first, and ranked-PvP rewards remain visible.",
        "Molten Front coordinates identify unlock hubs and vendors. The campaign is phased and requires Marks of the World Tree across multiple daily resets.",
    },
    sourceUrls = {
        live = "https://worldofwarcraft.blizzard.com/en-gb/news/9993013/patch-42-rage-of-the-firelands-now-live",
        moltenFront = "https://www.wowhead.com/guide/a-guide-to-the-molten-front-and-respective-quests-58",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/2993743/rage-of-the-firelands-patch-42-notes-updated-628",
        vanity = "https://www.wowhead.com/news/vanity-roundup-and-guides-for-4-2-190985",
    },
    wowheadPatchId = 40200,
})
