local _, TDP = ...

local shared = {}
shared["mounts 15779"] = {
    reason = "The original unarmored epic mount was removed from vendors in patch 1.4. Existing owners retain it.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftmounts.com/retired.php",
}

TDP.CatalogRegistry:RegisterAvailability("1.0", {
    mounts = {
        [15779] = shared["mounts 15779"],
        [16055] = shared["mounts 15779"],
        [16056] = shared["mounts 15779"],
        [16080] = shared["mounts 15779"],
        [16081] = shared["mounts 15779"],
        [16082] = shared["mounts 15779"],
        [16083] = shared["mounts 15779"],
        [16084] = shared["mounts 15779"],
        [17450] = shared["mounts 15779"],
        [17459] = shared["mounts 15779"],
        [17460] = shared["mounts 15779"],
        [17461] = shared["mounts 15779"],
    },
})
