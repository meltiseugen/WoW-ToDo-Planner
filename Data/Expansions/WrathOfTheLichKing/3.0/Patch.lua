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
        "The 3.0 bucket contains Northrend launch rewards and Wrath-content achievements. Retroactive Classic and Burning Crusade achievements belong to 1.0 and 2.0; neutral milestones and cross-expansion metas live in General. The introduction of the achievement system does not assign older or neutral content to Wrath.",
        "The 2026-11-04 Retail review excludes permanently retired collectibles. Plagued Proto-Drake remains through the Black Market; Black Proto-Drake has no replacement source. Modern replacement ID 54437 is kept with 3.0.8, where the original Tiny Green Ragdoll was introduced.",
        "Recurring holiday, shop, trading-card, Collector's Edition, convention, promotional, unused, NPC-only, hidden-statistic, and ordinary equipment records are excluded. The achievement catalogue contains only achievements still earnable in Retail; retired realm-first, launch-event, original-season, original Ulduar size-specific, and removed-system achievements are excluded.",
    },
    sourceUrls = {
        expansion = "https://warcraft.wiki.gg/wiki/World_of_Warcraft:_Wrath_of_the_Lich_King",
        mounts = "https://www.wowhead.com/wotlk/guide/mount-collecting-the-completionist-guide",
        patch = "https://warcraft.wiki.gg/wiki/Patch_3.0.2",
        pets = "https://www.wowhead.com/wotlk/guide/companion-pets-collectibles",
    },
    wowheadPatchId = 30000,
})
