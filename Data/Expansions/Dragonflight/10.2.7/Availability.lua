local _, TDP = ...

local shared = {}
shared["mounts 127178"] = {
    reason = "Pandaria Remix has ended. This event-specific mount has no current acquisition source.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://news.blizzard.com/en-us/article/24115317/what-to-tackle-in-dragonflight-before-the-war-within",
}

shared["pets 4579"] = {
    reason = "Pandaria Remix has ended. This achievement pet cannot be caged or traded.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.warcraftpets.com/news/new-pets-remix-mists-of-pandaria-coming-soon/",
}

TDP.CatalogRegistry:RegisterAvailability("10.2.7", {
    mounts = {
        [127178] = shared["mounts 127178"],
        [435044] = shared["mounts 127178"],
        [435082] = shared["mounts 127178"],
        [435084] = shared["mounts 127178"],
        [435103] = shared["mounts 127178"],
        [435107] = shared["mounts 127178"],
        [435108] = shared["mounts 127178"],
        [435109] = shared["mounts 127178"],
        [435115] = shared["mounts 127178"],
        [435118] = shared["mounts 127178"],
        [435123] = shared["mounts 127178"],
        [435124] = shared["mounts 127178"],
        [435125] = shared["mounts 127178"],
        [435126] = shared["mounts 127178"],
        [435127] = shared["mounts 127178"],
        [435128] = shared["mounts 127178"],
        [435131] = shared["mounts 127178"],
        [435133] = shared["mounts 127178"],
        [435145] = shared["mounts 127178"],
        [435146] = shared["mounts 127178"],
        [435147] = shared["mounts 127178"],
        [435149] = shared["mounts 127178"],
        [435150] = shared["mounts 127178"],
        [435153] = shared["mounts 127178"],
        [435160] = shared["mounts 127178"],
        [435161] = shared["mounts 127178"],
        [441794] = shared["mounts 127178"],
        [446017] = shared["mounts 127178"],
        [446022] = shared["mounts 127178"],
    },
    pets = { [4579] = shared["pets 4579"], [4580] = shared["pets 4579"] },
})
