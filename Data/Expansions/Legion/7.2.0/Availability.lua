local _, TDP = ...

local shared = {}
shared["cosmetics 146218"] = {
    achievementIds = { 11578, 11579 },
    characterOnly = true,
    reason = "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor",
}

shared["cosmetics 147336"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

shared["cosmetics 147621"] = {
    achievementIds = { 11697, 11698 },
    characterOnly = true,
    reason = "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor",
}

TDP.CatalogRegistry:RegisterAvailability("7.2.0", {
    cosmetics = {
        [146218] = shared["cosmetics 146218"],
        [146219] = shared["cosmetics 146218"],
        [146220] = shared["cosmetics 146218"],
        [146221] = shared["cosmetics 146218"],
        [146222] = shared["cosmetics 146218"],
        [146223] = shared["cosmetics 146218"],
        [146224] = shared["cosmetics 146218"],
        [146225] = shared["cosmetics 146218"],
        [146226] = shared["cosmetics 146218"],
        [146227] = shared["cosmetics 146218"],
        [146228] = shared["cosmetics 146218"],
        [146229] = shared["cosmetics 146218"],
        [146230] = shared["cosmetics 146218"],
        [146231] = shared["cosmetics 146218"],
        [146232] = shared["cosmetics 146218"],
        [146233] = shared["cosmetics 146218"],
        [146234] = shared["cosmetics 146218"],
        [146235] = shared["cosmetics 146218"],
        [146236] = shared["cosmetics 146218"],
        [146237] = shared["cosmetics 146218"],
        [146238] = shared["cosmetics 146218"],
        [146239] = shared["cosmetics 146218"],
        [146270] = shared["cosmetics 146218"],
        [146271] = shared["cosmetics 146218"],
        [147336] = shared["cosmetics 147336"],
        [147337] = shared["cosmetics 147336"],
        [147621] = shared["cosmetics 147621"],
        [147622] = shared["cosmetics 147621"],
        [147623] = shared["cosmetics 147621"],
        [147624] = shared["cosmetics 147621"],
        [147625] = shared["cosmetics 147621"],
        [147626] = shared["cosmetics 147621"],
        [147627] = shared["cosmetics 147621"],
        [147628] = shared["cosmetics 147621"],
        [147629] = shared["cosmetics 147621"],
        [147630] = shared["cosmetics 147621"],
        [147631] = shared["cosmetics 147621"],
        [147632] = shared["cosmetics 147621"],
        [147633] = shared["cosmetics 147621"],
        [147634] = shared["cosmetics 147621"],
        [147635] = shared["cosmetics 147621"],
        [147636] = shared["cosmetics 147621"],
        [147637] = shared["cosmetics 147621"],
        [147638] = shared["cosmetics 147621"],
        [147639] = shared["cosmetics 147621"],
        [147640] = shared["cosmetics 147621"],
        [147641] = shared["cosmetics 147621"],
        [147642] = shared["cosmetics 147621"],
        [147643] = shared["cosmetics 147621"],
        [147644] = shared["cosmetics 147621"],
    },
    mounts = {
        [227989] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
