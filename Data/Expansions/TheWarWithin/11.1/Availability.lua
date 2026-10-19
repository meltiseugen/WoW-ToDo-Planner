local _, TDP = ...

local shared = {}
shared["cosmetics 232681"] = {
    achievementIds = { 40389 },
    reason = "The War Within Season 1 Rival I unlock can no longer be earned. Accounts with the original Rival I achievement can still buy this ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=232681",
}

TDP.CatalogRegistry:RegisterAvailability("11.1", {
    cosmetics = {
        [232681] = shared["cosmetics 232681"],
        [232682] = shared["cosmetics 232681"],
        [232683] = shared["cosmetics 232681"],
        [232684] = shared["cosmetics 232681"],
        [232685] = shared["cosmetics 232681"],
        [232686] = shared["cosmetics 232681"],
        [232687] = shared["cosmetics 232681"],
        [232688] = shared["cosmetics 232681"],
        [232689] = shared["cosmetics 232681"],
        [232690] = shared["cosmetics 232681"],
        [232691] = shared["cosmetics 232681"],
        [232692] = shared["cosmetics 232681"],
        [232693] = shared["cosmetics 232681"],
    },
    mounts = {
        [466144] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
