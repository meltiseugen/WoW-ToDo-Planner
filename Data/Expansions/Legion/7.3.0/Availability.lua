local _, TDP = ...

local shared = {}
shared["cosmetics 149442"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

shared["cosmetics 149454"] = {
    achievementIds = { 12090, 12135, 12198 },
    characterOnly = true,
    reason = "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor",
}

TDP.CatalogRegistry:RegisterAvailability("7.3.0", {
    cosmetics = {
        [149442] = shared["cosmetics 149442"],
        [149443] = shared["cosmetics 149442"],
        [149454] = shared["cosmetics 149454"],
        [149455] = shared["cosmetics 149454"],
        [149456] = shared["cosmetics 149454"],
        [149457] = shared["cosmetics 149454"],
        [149458] = shared["cosmetics 149454"],
        [149459] = shared["cosmetics 149454"],
        [149460] = shared["cosmetics 149454"],
        [149461] = shared["cosmetics 149454"],
        [149462] = shared["cosmetics 149454"],
        [149463] = shared["cosmetics 149454"],
        [149464] = shared["cosmetics 149454"],
        [149465] = shared["cosmetics 149454"],
        [149466] = shared["cosmetics 149454"],
        [149467] = shared["cosmetics 149454"],
        [149468] = shared["cosmetics 149454"],
        [149469] = shared["cosmetics 149454"],
        [149470] = shared["cosmetics 149454"],
        [149471] = shared["cosmetics 149454"],
        [149472] = shared["cosmetics 149454"],
        [149473] = shared["cosmetics 149454"],
        [149474] = shared["cosmetics 149454"],
        [149475] = shared["cosmetics 149454"],
        [149476] = shared["cosmetics 149454"],
        [149477] = shared["cosmetics 149454"],
    },
    mounts = {
        [227994] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
