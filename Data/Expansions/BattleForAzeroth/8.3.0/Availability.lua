local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("8.3.0", {
    mounts = {
        [262027] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
        [302143] = {
            reason = "The Heroic N'Zoth quest mount reward ended at the Shadowlands launch.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=1202",
        },
    },
})
