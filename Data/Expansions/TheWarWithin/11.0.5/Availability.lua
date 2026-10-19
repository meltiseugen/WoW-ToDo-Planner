local _, TDP = ...

local shared = {}
shared["cosmetics 230886"] = {
    achievementIds = { 15952 },
    characterOnly = true,
    reason = "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=230886",
}

shared["cosmetics 230968"] = {
    achievementIds = { 17795 },
    characterOnly = true,
    reason = "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=230968",
}

shared["cosmetics 231137"] = {
    achievementIds = { 19133, 19493 },
    characterOnly = true,
    reason = "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    reviewedAt = "2026-10-13",
    sourceUrl = "https://www.wowhead.com/item=231137",
}

TDP.CatalogRegistry:RegisterAvailability("11.0.5", {
    cosmetics = {
        [230886] = shared["cosmetics 230886"],
        [230887] = shared["cosmetics 230886"],
        [230888] = shared["cosmetics 230886"],
        [230889] = shared["cosmetics 230886"],
        [230890] = shared["cosmetics 230886"],
        [230891] = shared["cosmetics 230886"],
        [230892] = shared["cosmetics 230886"],
        [230893] = shared["cosmetics 230886"],
        [230894] = shared["cosmetics 230886"],
        [230895] = shared["cosmetics 230886"],
        [230896] = shared["cosmetics 230886"],
        [230897] = shared["cosmetics 230886"],
        [230898] = shared["cosmetics 230886"],
        [230901] = {
            achievementIds = { 15984 },
            characterOnly = true,
            reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.wowhead.com/achievement=15984",
        },
        [230968] = shared["cosmetics 230968"],
        [230969] = shared["cosmetics 230968"],
        [230970] = shared["cosmetics 230968"],
        [230971] = shared["cosmetics 230968"],
        [230972] = shared["cosmetics 230968"],
        [230973] = shared["cosmetics 230968"],
        [230974] = shared["cosmetics 230968"],
        [230975] = shared["cosmetics 230968"],
        [230976] = shared["cosmetics 230968"],
        [230977] = shared["cosmetics 230968"],
        [230978] = shared["cosmetics 230968"],
        [230979] = shared["cosmetics 230968"],
        [230980] = shared["cosmetics 230968"],
        [230983] = {
            achievementIds = { 17831 },
            characterOnly = true,
            reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.wowhead.com/achievement=17831",
        },
        [231137] = shared["cosmetics 231137"],
        [231138] = shared["cosmetics 231137"],
        [231139] = shared["cosmetics 231137"],
        [231140] = shared["cosmetics 231137"],
        [231141] = shared["cosmetics 231137"],
        [231142] = shared["cosmetics 231137"],
        [231143] = shared["cosmetics 231137"],
        [231144] = shared["cosmetics 231137"],
        [231145] = shared["cosmetics 231137"],
        [231146] = shared["cosmetics 231137"],
        [231147] = shared["cosmetics 231137"],
        [231148] = shared["cosmetics 231137"],
        [231149] = shared["cosmetics 231137"],
        [231152] = {
            achievementIds = { 19090, 19509 },
            characterOnly = true,
            reason = "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.wowhead.com/achievement=19090",
        },
    },
})
