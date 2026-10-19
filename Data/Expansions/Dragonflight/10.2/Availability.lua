local _, TDP = ...

local shared = {}
shared["cosmetics 210502"] = {
    achievementIds = { 19090, 19509 },
    characterOnly = true,
    reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/achievement=19090",
}

TDP.CatalogRegistry:RegisterAvailability("10.2", {
    cosmetics = {
        [210502] = shared["cosmetics 210502"],
        [210503] = shared["cosmetics 210502"],
        [210504] = shared["cosmetics 210502"],
        [210506] = shared["cosmetics 210502"],
        [210507] = shared["cosmetics 210502"],
        [210508] = shared["cosmetics 210502"],
        [210509] = shared["cosmetics 210502"],
        [210510] = shared["cosmetics 210502"],
        [210511] = shared["cosmetics 210502"],
        [210512] = shared["cosmetics 210502"],
        [210513] = shared["cosmetics 210502"],
        [210514] = shared["cosmetics 210502"],
        [210515] = shared["cosmetics 210502"],
        [210516] = shared["cosmetics 210502"],
        [210517] = shared["cosmetics 210502"],
        [210518] = shared["cosmetics 210502"],
        [210519] = shared["cosmetics 210502"],
        [210520] = shared["cosmetics 210502"],
        [210521] = shared["cosmetics 210502"],
    },
    mounts = {
        [425416] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
