local _, TDP = ...

local shared = {}
shared["toys 54651"] = {
    reason = "The Operation: Gnomeregan / Zalazane's Fall pre-Cataclysm event questline was removed.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://warcraft.wiki.gg/wiki/Gnomeregan_Pride",
}

TDP.CatalogRegistry:RegisterAvailability("3.3.5", { toys = { [54651] = shared["toys 54651"], [54653] = shared["toys 54651"] } })
