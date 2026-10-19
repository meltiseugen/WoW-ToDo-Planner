local _, TDP = ...

local shared = {}
shared["mounts 49193"] = {
    reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftmounts.com/retired.php",
}

TDP.CatalogRegistry:RegisterAvailability("2.4", { mounts = { [49193] = shared["mounts 49193"], [58615] = shared["mounts 49193"] } })
