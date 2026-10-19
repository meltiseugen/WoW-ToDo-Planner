local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("12.0", {
    mounts = {
        [1262840] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
        [1268949] = {
            reason = "Midnight Season 1 has ended. The Let Me Solo Him: Nullaeus mount reward can no longer be earned.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://news.blizzard.com/en-us/article/24293280/the-clock-is-ticking-on-midnight-season-1-achievements-and-rewards",
        },
    },
})
