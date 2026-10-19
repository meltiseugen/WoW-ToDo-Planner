local _, TDP = ...

local shared = {}
shared["cosmetics 272317"] = {
    reason = "Decor Duels ended in patch 12.1. This appearance token has no current source; housing decor remains available.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels",
}

shared["toys 268455"] = {
    reason = "Decor Duels ended in patch 12.1. This toy has no current source; the retained vendor inventory is housing decor.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels",
}

TDP.CatalogRegistry:RegisterAvailability("12.0.5", {
    cosmetics = {
        [272317] = shared["cosmetics 272317"],
        [272318] = shared["cosmetics 272317"],
        [272320] = shared["cosmetics 272317"],
        [272321] = shared["cosmetics 272317"],
        [272336] = shared["cosmetics 272317"],
        [272337] = shared["cosmetics 272317"],
        [272338] = shared["cosmetics 272317"],
    },
    mounts = {
        [1282471] = {
            reason = "Decor Duels ended in patch 12.1. The mount reward has no current source; only housing decor was retained for Voidlight Marl.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels",
        },
    },
    toys = { [268455] = shared["toys 268455"], [268456] = shared["toys 268455"] },
})
