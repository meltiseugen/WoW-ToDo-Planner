local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("4.1.0", {
    cosmeticDetailGroups = {
        guildTabards = {
            acquisition = "Reach the required guild reputation and purchase the matching guild tabard.",
            source = "Guild vendors in Stormwind and Orgrimmar",
            sourceType = "Guild reputation vendor",
            tips = "The tabards increase guild reputation gains rather than representing a specific guild design; check both reputation and vendor eligibility.",
            waypoints = { "/way #84 67.4 72.8 Guild vendor", "/way #85 48.4 75.6 Guild vendor" },
        },
    },
    label = "Patch 4.1: Rise of the Zandalari",
    sourceNotes = {
        "This bucket covers the rebuilt Zul'Aman and Zul'Gurub heroic dungeons, their timed rescue and boss rewards, the new Stranglethorn quest continuation, two Archaeology pets, and the guild challenge update.",
        "The audit uses original live availability and current durable collection IDs. Trading-card, promotion, calendar-event, hidden-statistic, unused, and ordinary equipment records are excluded.",
        "Retired guild-challenge and other historical achievements remain listed; the Zandalari dungeon mounts and pets retain their current collection identifiers.",
    },
    sourceUrls = {
        live = "https://worldofwarcraft.blizzard.com/en-gb/news/9984237",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/2514161/patch-41-content-preview-rise-of-the-zandalari",
        vanity = "https://www.wowhead.com/news/a-guide-to-patch-4-1s-vanity-items-and-a-wowhead-comic-188009",
    },
    wowheadPatchId = 40100,
})
