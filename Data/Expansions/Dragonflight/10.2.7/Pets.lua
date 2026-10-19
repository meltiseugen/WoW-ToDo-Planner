local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.7", "pets", {
    entries = {
        { name = "Muskpaw Calf", npcId = 223785, source = "Achievement: Pandaria: Remix - Townlong Steppes", speciesId = 4579 },
        { name = "Astral Emperor's Serpentling", npcId = 223810, source = "Achievement: Pandaria: Remix - Timeless Isle", speciesId = 4580 },
    },
    details = {
        ["Astral Emperor's Serpentling"] = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Pandaria: Remix - Timeless Isle",
            sourceType = "Pet Journal Source",
        },
        ["Muskpaw Calf"] = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Pandaria: Remix - Townlong Steppes",
            sourceType = "Pet Journal Source",
        },
    },
})
