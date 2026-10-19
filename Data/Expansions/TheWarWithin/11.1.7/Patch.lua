local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("11.1.7", {
    cosmeticDetailGroups = {
        adornedHalfShell = {
            acquisition = "The original promotion required watching four hours of eligible World of Warcraft streams with linked Battle.net and Twitch accounts, then claiming the drop.",
            availability = "Original promotion ran July 14-August 19, 2025 after Blizzard extended the end date; it is no longer claimable.",
            requirements = "Claimed during the original Twitch Drop window or a future reissue.",
            researchNotes = "No map waypoint is supplied because acquisition occurred outside the game and the token arrived through the promotion.",
            source = "Adorned Half Shell promotion",
            sourceType = "WoW Twitch Drop",
            tips = "This was a WoW-only promotional appearance rather than a cross-game reward, but the original claim window has ended. Keep the record for collection diagnosis and any future return.",
        },
        ahune = {
            acquisition = "Queue for Ahune while Midsummer is active and open the daily Satchel of Chilled Goods for a chance at the crown or one of the four scythe/staff appearance tokens.",
            availability = "Annual Midsummer Fire Festival only.",
            requirements = "Midsummer Fire Festival active and eligible for the holiday dungeon reward.",
            researchNotes = "Five separate consumable items: one crown, two polearms, and two staves. They are not bundle components.",
            source = "Ahune / Satchel of Chilled Goods",
            sourceType = "Holiday Dungeon Drop",
            tips = "The first daily satchel is the meaningful attempt and uses bad-luck protection according to the event guide; later character runs may have only a very small chance. The polearms and staves are distinct appearances despite their paired names.",
            waypoints = { "/way #85 45.9 37.4 Orgrimmar Midsummer festival / queue hub", "/way #84 50.0 72.0 Stormwind Midsummer festival / queue hub" },
        },
        midsummerVendor = {
            acquisition = "Earn Burning Blossoms by honoring friendly flames, desecrating enemy flames, and completing holiday activities, then buy the three learn-on-use Fire Festival armor tokens.",
            availability = "Annual Midsummer Fire Festival; the 2025 window was June 21-July 5. Check the current calendar.",
            costs = { "Grand Helm: 350 Burning Blossoms", "Grand Mantle: 350 Burning Blossoms", "Grand Belt: 150 Burning Blossoms" },
            requirements = "Midsummer Fire Festival active.",
            source = "Midsummer Fire Festival vendors",
            sourceType = "Holiday Vendor",
            tips = "The helm and mantle cost 350 blossoms each; the belt costs 150. Route bonfires across expansions before spending so the one-time blossom supply covers the desired pieces.",
            waypoints = { "/way #85 45.9 37.4 Orgrimmar Midsummer festival", "/way #84 50.0 72.0 Stormwind Midsummer festival" },
        },
        redDawn = {
            acquisition = "Start Trouble in the Highlands from Faerin Lothar outside the Dornogal inn, finish the Rise of the Red Dawn story, then complete Past Glory for the learn-on-use pauldrons.",
            availability = "Permanent story questline as of the audited data.",
            requirements = "Complete the Rise of the Red Dawn questline through Past Glory.",
            source = "Past Glory / Rise of the Red Dawn",
            sourceType = "Campaign Quest",
            tips = "Follow the chain into Arathi Highlands; the shoulder token is from the finale, not a random mob drop. Use it from the bag after turn-in.",
            waypoints = { "/way #2339 46.0 49.6 Faerin Lothar / Trouble in the Highlands", "/way #14 36.7 58.0 Rise of the Red Dawn / High Perch area" },
        },
    },
    label = "Patch 11.1.7",
    sourceNotes = {
        "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
        "Timewalking appearance tokens are excluded from Cosmetics; Chrono Corsair remains in the mounts catalog as a patch-native Timewalking reward.",
        "Cross-game and crossover promotional rewards are excluded, including the Greedy Emissary / Diablo collection. Trading Post rewards are also excluded.",
        "The remaining Cosmetics record is the permanent Rise of the Red Dawn reward; Midsummer and Twitch-promotion appearances are excluded.",
    },
    sourceUrls = {
        adornedHalfShell = "https://www.wowhead.com/blue-tracker/news/us/updated-8-5-twitch-drop-get-the-adorned-half-shell-transmog-world-of-warcraft-24223309",
        midsummer = "https://www.wowhead.com/guide/world-events/holidays/midsummer-fire-festival",
        midsummerOfficial = "https://www.wowhead.com/blue-tracker/news/eu/embrace-the-heat-during-the-midsummer-fire-festival-world-of-warcraft-blizzard-24213951",
        redDawn = "https://www.wowhead.com/news/earn-arathi-themed-rewards-from-the-rise-of-the-red-dawn-questline-in-patch-11-1-377299",
    },
    wowheadPatchId = 110107,
})
