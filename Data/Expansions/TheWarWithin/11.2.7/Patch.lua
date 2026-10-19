local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("11.2.7", {
    cosmeticDetailGroups = {
        pandarenHeritage = {
            acquisition = "On a level-50 or higher Pandaren, begin Invitation to the Spirit Festival at your faction embassy and complete the heritage storyline through A New Tradition.",
            source = "A New Tradition / Pandaren Heritage",
            sourceType = "Heritage Questline",
            tips = "The questline takes roughly 25-60 minutes depending on dialogue and grouping. The reward teaches the faction-colored Tushui or Huojin set plus the neutral Wandering Isle tint; use the ensemble from your bags if it is not learned automatically.",
            waypoints = { "/way #1519 52.6 13.8 Aysa Cloudsinger / Stormwind Embassy", "/way #1637 38.0 80.2 Ji Firepaw / Orgrimmar Embassy" },
        },
        slTimewalking1200 = {
            acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 1,200 Timewarped Badges.",
            source = "Collector Ta'steld / Oribos",
            sourceType = "Timewalking Vendor",
            tips = "The vendor is available only during Shadowlands Timewalking. Check the collection state before spending badges because the item is consumed on use.",
            waypoints = { "/way #1670 64.2 68.0 Collector Ta'steld / Oribos" },
        },
        slTimewalking1500 = {
            acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 1,500 Timewarped Badges.",
            source = "Collector Ta'steld / Oribos",
            sourceType = "Timewalking Vendor",
            tips = "Farm the event's first-dungeon quest and repeated Timewalking runs while the rotation is active. Use the token from your bags after purchase.",
            waypoints = { "/way #1670 64.2 68.0 Collector Ta'steld / Oribos" },
        },
        slTimewalking2200 = {
            acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 2,200 Timewarped Badges.",
            source = "Collector Ta'steld / Oribos",
            sourceType = "Timewalking Vendor",
            tips = "Collector Ta'steld appears only while Shadowlands Timewalking is active. The two greathammers are the most expensive appearance tokens in this inventory; ordinary equippable weapons sold nearby are not part of Cosmetics.",
            waypoints = { "/way #1670 64.2 68.0 Collector Ta'steld / Oribos" },
        },
        slTimewalking450 = {
            acquisition = "During Shadowlands Timewalking, buy this learn-on-use shoulder appearance from Collector Ta'steld for 450 Timewarped Badges.",
            source = "Collector Ta'steld / Oribos",
            sourceType = "Timewalking Vendor",
            tips = "Collector Ta'steld is present only for the Shadowlands rotation. These cosmetic tokens disappear after teaching the appearance.",
            waypoints = { "/way #1670 64.2 68.0 Collector Ta'steld / Oribos" },
        },
        slTimewalking600 = {
            acquisition = "During Shadowlands Timewalking, buy this learn-on-use back appearance from Collector Ta'steld for 600 Timewarped Badges.",
            source = "Collector Ta'steld / Oribos",
            sourceType = "Timewalking Vendor",
            tips = "These are cosmetic quiver or back tokens, not wearable bag-slot items. Use the token after purchase.",
            waypoints = { "/way #1670 64.2 68.0 Collector Ta'steld / Oribos" },
        },
    },
    label = "Patch 11.2.7: The Warning",
    sourceNotes = {
        "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
        "Cosmetics are limited to learn-on-use items. Ordinary Timewalking gear, Brawler's Guild shirts, housing decor, and every Trading Post reward are excluded.",
        "Shadowlands Timewalking records come from Collector Ta'steld's permanent rotation inventory; the Pandaren ensembles come from the level-50 heritage questline.",
    },
    sourceUrls = {
        overview = "https://www.wowhead.com/guide/the-war-within/patch-11-2-7-overview",
        pandarenHeritage = "https://www.wowhead.com/guide/transmogrification/pandaren-heritage-armor",
        shadowlandsTimewalking = "https://www.wowhead.com/guide/world-events/shadowlands-timewalking",
        timewalkingCosts = "https://www.wowhead.com/blue-tracker/news/eu/take-a-ride-on-turbulent-timeways-now-live-world-of-warcraft-blizzard-news-24242437",
    },
    wowheadPatchId = 110207,
})
