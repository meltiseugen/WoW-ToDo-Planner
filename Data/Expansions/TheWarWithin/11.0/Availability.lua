local _, TDP = ...

local shared = {}
shared["cosmetics 225856"] = {
    achievementIds = { 40391 },
    reason = "The War Within Season 1 Duelist unlock can no longer be earned. Accounts with the original Duelist achievement retain legacy weapon access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/achievement=40391",
}

shared["toys 225547"] = {
    reason = "The original War Within Delve storyline quest reward was removed in patch 12.0.1.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://warcraft.wiki.gg/wiki/Category:Removed_in_patch_12.0.1",
}

TDP.CatalogRegistry:RegisterAvailability("11.0", {
    cosmetics = {
        [225856] = shared["cosmetics 225856"],
        [225857] = shared["cosmetics 225856"],
        [225858] = shared["cosmetics 225856"],
        [225859] = shared["cosmetics 225856"],
        [225860] = shared["cosmetics 225856"],
        [225861] = shared["cosmetics 225856"],
        [225863] = shared["cosmetics 225856"],
        [225864] = shared["cosmetics 225856"],
        [225865] = shared["cosmetics 225856"],
        [225866] = shared["cosmetics 225856"],
        [225867] = shared["cosmetics 225856"],
        [225868] = shared["cosmetics 225856"],
        [225869] = shared["cosmetics 225856"],
        [225870] = shared["cosmetics 225856"],
        [225871] = shared["cosmetics 225856"],
        [225872] = shared["cosmetics 225856"],
        [225874] = shared["cosmetics 225856"],
    },
    mounts = {
        [441324] = {
            reason = "The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=1733",
        },
        [441325] = {
            reason = "The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/mount.php?mountid=1734",
        },
        [449466] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
    toys = { [225547] = shared["toys 225547"], [230727] = shared["toys 225547"] },
})
