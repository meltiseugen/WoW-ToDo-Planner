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
        seasonSevenTabard = {
            acquisition = "Earn the original elite-rating Relentless Gladiator tabard during Arena Season 7.",
            source = "Wrath Arena Season 7",
            sourceType = "Ranked PvP",
            tips = "The original seasonal source is no longer obtainable.",
        },
        seasonSixTabard = {
            acquisition = "Earn the original elite-rating Furious Gladiator tabard during Arena Season 6.",
            source = "Wrath Arena Season 6",
            sourceType = "Ranked PvP",
            tips = "The original seasonal source is no longer obtainable.",
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
        "Patch 3.2 expands the Argent Tournament, opens Trial of the Champion and Trial of the Crusader, adds Isle of Conquest, revamps Onyxia's Lair, and covers Wrath Arena Seasons 6 and 7 collection rewards.",
        "The eight original raptor hatchlings are retained with their historical sources and coordinates. Several nest or dungeon sources changed with Cataclysm, so their tips explicitly mark removed acquisition paths.",
        "Shop, trading-card, convention, recurring holiday, unused, NPC-only, hidden-statistic, and ordinary equipment records are excluded. Faction duplicates and no-longer-obtainable ranked or tribute rewards remain for historical completeness.",
    },
    sourceUrls = {
        argentTournament = "https://www.wowhead.com/wotlk/guide/argent-tournament/rewards",
        patchNotes = "https://www.engadget.com/2009-08-04-world-of-warcraft-patch-3-2-release-patch-notes.html",
        raidAchievements = "https://www.wowhead.com/guide/the-crusaders-coliseum-trial-of-the-crusader-achievements-828",
        tournamentChanges = "https://www.wowhead.com/news/argent-tournament-changes-in-3-2-102771",
    },
    wowheadPatchId = 30200,
})
