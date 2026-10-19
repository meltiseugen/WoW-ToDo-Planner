local _, TDP = ...

local shared = {}
shared["mounts 18991"] = {
    reason = "The original unarmored epic mount was removed from vendors in patch 1.4. Existing owners retain it.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftmounts.com/retired.php",
}

TDP.CatalogRegistry:RegisterAvailability("1.1", { mounts = { [18991] = shared["mounts 18991"], [18992] = shared["mounts 18991"] } })
