local _, TDP = ...

local shared = {}
shared["cosmetics 202123"] = {
    achievementIds = { 15984 },
    characterOnly = true,
    reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/achievement=15984",
}

TDP.CatalogRegistry:RegisterAvailability("10.0", {
    cosmetics = {
        [202123] = shared["cosmetics 202123"],
        [202124] = shared["cosmetics 202123"],
        [202125] = shared["cosmetics 202123"],
        [202126] = shared["cosmetics 202123"],
        [202127] = shared["cosmetics 202123"],
        [202128] = shared["cosmetics 202123"],
        [202129] = shared["cosmetics 202123"],
        [202130] = shared["cosmetics 202123"],
        [202131] = shared["cosmetics 202123"],
        [202132] = shared["cosmetics 202123"],
        [202133] = shared["cosmetics 202123"],
        [202134] = shared["cosmetics 202123"],
        [202135] = shared["cosmetics 202123"],
        [202136] = shared["cosmetics 202123"],
        [202137] = shared["cosmetics 202123"],
        [202138] = shared["cosmetics 202123"],
        [202139] = shared["cosmetics 202123"],
        [202140] = shared["cosmetics 202123"],
    },
    mounts = {
        [377071] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
