local _, TDP = ...

-- Keep original identities, details and guides, including rewards already owned.
local plunderstorm = {
    kind = "Unobtainable",
    reason = "Plunderstorm has ended. This event-only reward currently has no acquisition source.",
    reviewedAt = "2026-10-28",
    sourceUrl = "https://worldofwarcraft.blizzard.com/en-us/news/24166265",
}

TDP.CatalogRegistry:RegisterAvailability("11.0.7", {
    pets = {
        [4692] = plunderstorm, -- Sparklesnap
        [4695] = plunderstorm, -- Parley
        [4725] = { -- Titan Orb
            kind = "Unconfirmed",
            reason = "Datamined Siren Isle species removed from the collectible journal before release; no confirmed acquisition. This is a different species from Teeny Titan Orb.",
            reviewedAt = "2026-10-29",
        },
    },
    mounts = {
        [471696] = plunderstorm, -- Hooktalon
        [457656] = plunderstorm, -- Plunderlord's Midnight Crocolisk
    },
})
