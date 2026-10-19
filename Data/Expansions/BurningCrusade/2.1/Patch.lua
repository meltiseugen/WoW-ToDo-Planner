local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.1", {
    cosmeticDetailGroups = {
        ogrilaTabard = {
            acquisition = "Reach Exalted with Ogri'la and buy the tabard with Apexis Shards.",
            source = "Jho'nass at Ogri'la",
            sourceType = "Reputation vendor",
            tips = "Complete the Ogri'la daily circuit and keep spare Apexis Shards for the purchase.",
            waypoints = { "/way #105 27.6 58.8 Jho'nass" },
        },
        skyguardTabard = {
            acquisition = "Reach Exalted with the Sha'tari Skyguard and buy the tabard.",
            source = "Grella in Skettis",
            sourceType = "Reputation vendor",
            tips = "Stack Skettis daily quests and Terokk summons with the nether-ray mount grind.",
            waypoints = { "/way #108 64.3 66.2 Grella" },
        },
    },
    label = "The Black Temple",
    sourceNotes = {
        "Patch 2.1 adds the Netherwing and Sha'tari Skyguard daily hubs, their eleven reputation drakes and nether rays, Raven Lord, the Arena Season 1 Swift Nether Drake, Captured Firefly, Time-Lost Figurine, and the Skyguard and Ogri'la tabards.",
        "The Black Temple itself adds raid equipment but no separate permanent mount, pet, toy, or tabard record under this catalogue's rules. Swift Flight Form is a druid form rather than a Mount Journal collectible.",
        "Achievements were not yet available. Trading-card, promotional, recurring holiday, unused, NPC-only, temporary, and ordinary equipment records remain excluded.",
    },
    sourceUrls = {
        capturedFirefly = "https://warcraft.wiki.gg/wiki/Captured_Firefly",
        patch = "https://warcraft.wiki.gg/wiki/Patch_2.1.0",
        swiftNetherDrake = "https://warcraft.wiki.gg/wiki/Swift_Nether_Drake",
        timeLostFigurine = "https://warcraft.wiki.gg/wiki/Time-Lost_Figurine",
        undocumented = "https://warcraft.wiki.gg/wiki/Patch_2.1.0_(undocumented_changes)",
    },
    wowheadPatchId = 20100,
})
