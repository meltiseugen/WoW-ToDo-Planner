local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.5", "pets", {
    entries = {
        { name = "Reese", npcId = 216930, source = "Achievement: Just One More Thing", speciesId = 4411 },
        { name = "Hap'he", npcId = 216933, source = "Achievement: Finally At Rest", speciesId = 4412 },
    },
    details = {
        ["Hap'he"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Achievement: Finally At Rest", sourceType = "Pet Journal Source" },
        Reese = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Achievement: Just One More Thing", sourceType = "Pet Journal Source" },
    },
})
