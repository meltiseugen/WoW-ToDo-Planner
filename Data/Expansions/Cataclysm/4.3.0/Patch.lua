local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("4.3.0", {
    label = "Patch 4.3: Hour of Twilight",
    sourceNotes = {
        "This bucket covers End Time, Well of Eternity, Hour of Twilight, Dragon Soul, Raid Finder, Fangs of the Father, Worgen vendor mounts, Baradin Hold's Alizabal, and Cataclysm PvP Season 11.",
        "Original live availability and current durable IDs are used. Darkmoon Faire and other calendar-event additions, shop and promotional rewards, trading-card records, hidden statistics, and ordinary equipment are excluded under the catalogue's established rules.",
        "Historical guild, realm-first, heroic-raid, and ranked-PvP achievements remain available for collection-history tracking even when their original source has ended.",
    },
    sourceUrls = { guide = "https://www.wowhead.com/news/wowheads-patch-4-3-guide-197962", official = "https://worldofwarcraft.blizzard.com/en-us/news/3964563/43-hour-of-twilight-patch-notes" },
    wowheadPatchId = 40300,
})
