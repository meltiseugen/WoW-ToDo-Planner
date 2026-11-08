local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.3.0", {
    cosmeticDetailGroups = {
        lightbringerTabard = {
            acquisition = "Complete Shadowmourne, defeat the Lich King with it equipped, open the sealed chest, and use the Badge of the Silver Hand to begin Uther's quest.",
            source = "The Lightbringer's Redemption",
            sourceType = "Shadowmourne quest reward",
            tips = "The sealed chest is awarded once per Shadowmourne completion; its quest-starting items and rewards can be traded.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
    },
    label = "Fall of the Lich King",
    sourceNotes = {
        "This bucket covers patch 3.3.x before 3.3.5: Dungeon Finder, the Frozen Halls, Icecrown Citadel, the Ashen Verdict, Shadowmourne, Toravon, Arena Season 8, and the phased opening of the final raid tier.",
        "Shadowmourne's sealed chest provides the Crimson Deathcharger, Tabard of the Lightbringer, Muradin's Favor, and Sylvanas' Music Box represented here. Jaina's Locket is useful but is not a Toy Box collectible and is therefore excluded.",
        "Recurring holiday rewards, store and promotional collectibles, hidden statistics, and ordinary equipment are excluded. Obtainable legendary and raid-mount feats remain listed; retired realm-first, ranked-season rewards and the two Pit of Saron mechanic achievements retired in 12.0.1 are excluded. The Normal and Heroic Pit of Saron clear achievements remain.",
    },
    sourceUrls = {
        achievements = "https://www.wowhead.com/achievement=4608/fall-of-the-lich-king-25-player",
        frozo = "https://warcraft.wiki.gg/wiki/Frozo_the_Renowned",
        icecrown = "https://www.wowhead.com/wotlk/zone=4812/icecrown-citadel",
        overview = "https://warcraft.wiki.gg/wiki/Fall_of_the_Lich_King",
        patch333Items = "https://warcraft.wiki.gg/wiki/Patch_3.3.3_(undocumented_changes)",
        shadowmourne = "https://www.wowhead.com/wotlk/guide/raids/icecrown-citadel/shadowmourne",
    },
    wowheadPatchId = 30300,
})
