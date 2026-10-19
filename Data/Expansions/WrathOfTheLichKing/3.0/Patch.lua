local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.0", {
    cosmeticDetailGroups = {
        launchAchievementTabards = {
            acquisition = "Complete the corresponding achievement and collect the mailed tabard reward.",
            source = "Wrath launch achievement system",
            sourceType = "Achievement reward",
            tips = "Loremaster and Explorer are account-scale projects; finish one continent or zone group at a time.",
        },
        wrathReputationTabards = {
            acquisition = "Reach Friendly with the matching Wrath faction and buy its tabard, then wear it in eligible dungeons to earn reputation.",
            source = "Argent Crusade, Knights of the Ebon Blade, Wyrmrest Accord, or Kirin Tor quartermaster",
            sourceType = "Reputation vendor",
            tips = "Buying the tabard early lets dungeon runs contribute reputation while you pursue other launch achievements.",
        },
    },
    label = "Wrath of the Lich King",
    sourceNotes = {
        "The 3.0 bucket is the catalogue's initial Wrath release set: Northrend launch rewards plus the achievement system's original permanent and historical records.",
        "Mount, pet, toy, and cosmetic IDs were reconciled against a later client DB2 snapshot so retired rewards remain visible. Modern replacement ID 54437 is kept with 3.0.8, where the original Tiny Green Ragdoll was introduced.",
        "Recurring holiday, shop, trading-card, Collector's Edition, convention, promotional, unused, NPC-only, hidden-statistic, and ordinary equipment records are excluded. One-time historical raid, PvP, realm-first, and launch-event achievements are retained.",
    },
    sourceUrls = {
        expansion = "https://warcraft.wiki.gg/wiki/World_of_Warcraft:_Wrath_of_the_Lich_King",
        mounts = "https://www.wowhead.com/wotlk/guide/mount-collecting-the-completionist-guide",
        patch = "https://warcraft.wiki.gg/wiki/Patch_3.0.2",
        pets = "https://www.wowhead.com/wotlk/guide/companion-pets-collectibles",
    },
    wowheadPatchId = 30000,
})
