local _, TDP = ...

local shared = {}
shared["cosmetics 149446"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

shared["mounts 227995"] = {
    reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftmounts.com/retired.php",
}

TDP.CatalogRegistry:RegisterAvailability("7.3.5", {
    cosmetics = { [149446] = shared["cosmetics 149446"], [149447] = shared["cosmetics 149446"], [149450] = shared["cosmetics 149446"], [149451] = shared["cosmetics 149446"] },
    mounts = {
        [227995] = shared["mounts 227995"],
        [243201] = shared["mounts 227995"],
        [253639] = {
            reason = "The Heroic Argus quest mount reward ended at the Battle for Azeroth launch.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=797",
        },
    },
})
