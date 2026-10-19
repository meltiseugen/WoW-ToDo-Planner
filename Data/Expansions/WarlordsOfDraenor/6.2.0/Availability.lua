local _, TDP = ...

local shared = {}
shared["cosmetics 127365"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

TDP.CatalogRegistry:RegisterAvailability("6.2.0", {
    cosmetics = { [127365] = shared["cosmetics 127365"], [127366] = shared["cosmetics 127365"] },
    mounts = {
        [189043] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
