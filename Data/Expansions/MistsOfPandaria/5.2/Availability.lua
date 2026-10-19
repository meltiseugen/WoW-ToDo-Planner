local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("5.2", {
    cosmetics = {
        [98162] = {
            reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
        },
    },
    mounts = {
        [148618] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
