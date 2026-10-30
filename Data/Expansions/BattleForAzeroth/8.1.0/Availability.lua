local _, TDP = ...

TDP.CatalogRegistry:RegisterAvailability("8.1.0", {
    mounts = {
        [237288] = { -- Onyx War Hyena
            kind = "Unconfirmed",
            reason = "Old PTR mount record with no confirmed live Mount Journal acquisition. The historical PvP label does not establish an obtainable reward.",
            reviewedAt = "2026-10-29",
            sourceUrl = "https://www.wowhead.com/news/patch-8-1-ptr-build-28151-new-mounts-nightsabers-chimaera-kodos-and-more-287976",
        },
        [262023] = {
            reason = "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
            reviewedAt = "2026-10-13",
            sourceUrl = "https://www.warcraftmounts.com/retired.php",
        },
    },
})
