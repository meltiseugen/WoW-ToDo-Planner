local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.2.5", {
    label = "Patch 9.2.5: Shadowlands Season 4",
    sourceNotes = {
        "This audited backfill covers the permanent racial quest rewards, Return to Lordaeron reward, two permanent toys, and Shadowlands Season 4 collections and achievements shipped in the 9.2.5 client.",
        "The Season 4 records include the two Vicious Warstalkers that were preloaded earlier but did not become obtainable until Season 4.",
        "Winter Veil, esports-viewing, Diablo crossover, Dragonflight promotion, shop, hidden tracking, and unavailable records are excluded.",
        "Cosmetics use the three collection wrappers rather than duplicating their internal armor and weapon appearances.",
    },
    sourceUrls = {
        darkRanger = "https://www.wowhead.com/guide/dark-ranger-customizations-transmog-how-to-unlock",
        mounts = "https://www.wowhead.com/guide/shadowlands-mount-guide-10510",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23789456",
        overview = "https://worldofwarcraft.blizzard.com/en-us/news/23801631/shadowlands-925-content-update-is-now-live",
    },
    wowheadPatchId = 90205,
})
