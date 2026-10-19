local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("2.3", {
    mounts = {
        [43688] = {
            reason = "The original Zul'Aman timed raid was removed. Amani Battle Bear is a different mount.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=134",
        },
        [44744] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
