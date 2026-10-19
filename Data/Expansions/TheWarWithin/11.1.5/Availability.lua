local _, TDP = ...

local shared = {}
shared["cosmetics 239442"] = {
    achievementIds = { 41950 },
    reason = "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/npc=234297/wodin-the-troll-servant",
}

shared["cosmetics 239504"] = {
    achievementIds = { 41949 },
    reason = "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/npc=234297/wodin-the-troll-servant",
}

shared["cosmetics 239506"] = {
    achievementIds = { 41948 },
    reason = "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/npc=234297/wodin-the-troll-servant",
}

TDP.CatalogRegistry:RegisterAvailability("11.1.5", {
    cosmetics = {
        [238624] = {
            achievementIds = { 41951 },
            reason = "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.wowhead.com/npc=234297/wodin-the-troll-servant",
        },
        [239442] = shared["cosmetics 239442"],
        [239503] = shared["cosmetics 239442"],
        [239504] = shared["cosmetics 239504"],
        [239505] = shared["cosmetics 239504"],
        [239506] = shared["cosmetics 239506"],
        [239507] = shared["cosmetics 239506"],
    },
    mounts = {
        [1227076] = {
            questIds = { 87552 },
            reason = "Dastardly Duos has ended. Only characters with the original Week 4 quest unlock can buy this mount from Wodin.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.wowhead.com/npc=234297/wodin-the-troll-servant",
        },
    },
})
