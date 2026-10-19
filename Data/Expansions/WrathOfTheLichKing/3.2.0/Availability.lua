local _, TDP = ...

local shared = {}
shared["cosmetics 45983"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

shared["mounts 65439"] = {
    reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftmounts.com/retired.php",
}

TDP.CatalogRegistry:RegisterAvailability("3.2.0", {
    cosmetics = { [45983] = shared["cosmetics 45983"], [49086] = shared["cosmetics 45983"] },
    mounts = {
        [65439] = shared["mounts 65439"],
        [67336] = shared["mounts 65439"],
        [68056] = {
            reason = "The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=252",
        },
        [68057] = {
            reason = "The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=251",
        },
        [68187] = { reason = "The A Tribute to Immortality mount reward was removed with Cataclysm.", reviewedAt = "2026-10-13", sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=253" },
        [68188] = { reason = "The A Tribute to Immortality mount reward was removed with Cataclysm.", reviewedAt = "2026-10-13", sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=254" },
    },
})
