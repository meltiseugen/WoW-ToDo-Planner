local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("7.3.5", "pets", {
    entries = {
        {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Priority Mail.",
            name = "Mailemental",
            npcId = 132366,
            source = "Achievement: Priority Mail",
            speciesId = 2158,
            tips = "Open the linked achievement in game and plan its incomplete criteria before travelling; some requirements need a group, a specific difficulty, or multiple weeks.",
        },
    },
    details = {
        Mailemental = {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Priority Mail.",
            source = "Achievement: Priority Mail",
            sourceType = "Pet Journal Source",
            tips = "Open the linked achievement in game and plan its incomplete criteria before travelling; some requirements need a group, a specific difficulty, or multiple weeks.",
        },
    },
})
