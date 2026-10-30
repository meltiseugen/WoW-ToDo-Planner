local _, TDP = ...

-- Archive these rewards in the catalog; collection views exclude this category.
local plunderstorm = {
    kind = "Unobtainable",
    reason = "Plunderstorm has ended. This event-only reward currently has no acquisition source.",
    reviewedAt = "2026-10-28",
    sourceUrl = "https://worldofwarcraft.blizzard.com/en-us/news/24166265",
}

TDP.CatalogRegistry:RegisterAvailability("10.2.6", {
    pets = {
        [4425] = plunderstorm, -- Glamrok
        [4426] = plunderstorm, -- Bubbles
        [4435] = plunderstorm, -- Happy
    },
    mounts = {
        [254812] = plunderstorm, -- Royal Seafeather
        [300154] = plunderstorm, -- Silver Tidestallion
        [437162] = plunderstorm, -- Polly Roger
    },
})
