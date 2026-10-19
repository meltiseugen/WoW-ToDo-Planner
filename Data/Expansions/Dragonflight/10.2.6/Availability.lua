local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("10.2.6", {
    mounts = {
        [424539] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
        [439138] = {
            reason = "The Dragonflight Season 4 Awakened raid mount reward ended with The War Within launch.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://news.blizzard.com/en-us/article/24115317/what-to-tackle-in-dragonflight-before-the-war-within",
        },
    },
})
