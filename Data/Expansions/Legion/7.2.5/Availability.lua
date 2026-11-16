local _, TDP = ...

local shared = {}
shared["cosmetics 147338"] = {
    reason = "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183",
}

TDP.CatalogRegistry:RegisterAvailability("7.2.5", {
    cosmetics = { [147338] = shared["cosmetics 147338"], [147339] = shared["cosmetics 147338"] },
})
