local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.2.0", {
    cosmeticDetailGroups = {
        argentCrusaderTabard = {
            acquisition = "Earn the Crusader title and buy the tabard with Champion's Seals.",
            source = "Dame Evniki Kapsalis",
            sourceType = "Argent Tournament vendor",
            tips = "The tabard can teleport its wearer to the Argent Tournament Grounds.",
            waypoints = { "/way #118 75.8 24.4 Dame Evniki Kapsalis" },
        },
        conquestTabards = {
            acquisition = "Complete the faction-specific Isle of Conquest meta achievement.",
            source = "Master of Isle of Conquest",
            sourceType = "Battleground achievement",
            tips = "Many criteria need active battleground coordination; track vehicle, node, bomb, and location requirements separately.",
        },
        tournamentTabards = {
            acquisition = "Reach Exalted with the matching faction, unlock its tournament vendor, and purchase the tabard.",
            source = "Silver Covenant or Sunreavers quartermaster",
            sourceType = "Argent Tournament reputation",
            tips = "Champion every home city while doing the tournament dailies so Crusader rewards unlock in parallel.",
            waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
        },
    },
    label = "Call of the Crusade",
    sourceNotes = {
        "Patch 3.2 expands the Argent Tournament, opens Trial of the Champion and Trial of the Crusader, adds Isle of Conquest, and revamps Onyxia's Lair. Retired Arena mounts, elite tabards and tribute mounts are excluded after the 2026-11-04 Retail review.",
        "All eight raptor hatchlings remain obtainable. Follow the current Retail nest, dungeon, world-drop or Auction House routes in their individual walkthroughs.",
        "Shop, trading-card, convention, recurring holiday, unused, NPC-only, hidden-statistic, and ordinary equipment records are excluded. Obtainable faction achievement variants remain; retired ranked-season, limited-attempt tribute and emblem achievements are excluded.",
    },
    sourceUrls = {
        argentTournament = "https://www.wowhead.com/wotlk/guide/argent-tournament/rewards",
        patchNotes = "https://www.engadget.com/2009-08-04-world-of-warcraft-patch-3-2-release-patch-notes.html",
        raidAchievements = "https://www.wowhead.com/guide/the-crusaders-coliseum-trial-of-the-crusader-achievements-828",
        tournamentChanges = "https://www.wowhead.com/news/argent-tournament-changes-in-3-2-102771",
    },
    wowheadPatchId = 30200,
})
