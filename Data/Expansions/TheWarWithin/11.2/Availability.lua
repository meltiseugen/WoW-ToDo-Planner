local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("11.2", {
    mounts = {
        [472157] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
        [1242272] = {
            reason = "The Heroic Dimensius quest mount reward ended when Midnight launched on March 2, 2026. Mythic raid drop mounts remain obtainable.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://news.blizzard.com/en-us/article/24257262/what-to-tackle-in-the-war-within-before-the-launch-of-midnight",
        },
    },
})
