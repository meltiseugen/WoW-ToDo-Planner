local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("8.1.0", {
    mounts = {
        [262023] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
