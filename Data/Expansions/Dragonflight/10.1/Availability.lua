local _, TDP = ...

local shared = {}
shared["cosmetics 206044"] = {
    achievementIds = { 17831 },
    characterOnly = true,
    reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/achievement=17831",
}

shared["toys 206267"] = {
    reason = "The original Dragonflight Solo Shuffle season has ended. Its Legend pennant reward can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://warcraft.wiki.gg/wiki/Obsidian_Legend%27s_Pennant",
}

TDP.CatalogRegistry:RegisterAvailability("10.1", {
    cosmetics = {
        [206044] = shared["cosmetics 206044"],
        [206137] = shared["cosmetics 206044"],
        [206146] = shared["cosmetics 206044"],
        [206147] = shared["cosmetics 206044"],
        [206148] = shared["cosmetics 206044"],
        [206149] = shared["cosmetics 206044"],
        [206150] = shared["cosmetics 206044"],
        [206151] = shared["cosmetics 206044"],
        [206152] = shared["cosmetics 206044"],
        [206153] = shared["cosmetics 206044"],
        [206154] = shared["cosmetics 206044"],
    },
    mounts = {
        [408977] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
    toys = { [206267] = shared["toys 206267"], [206343] = shared["toys 206267"] },
})
