local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("7.3.5", "toys", {
    entries = {
        {
            acquisition = "Obtain this toy from the listed source: Achievement: Priority Mail.",
            itemId = 156833,
            name = "Katy's Stampwhistle",
            source = "Achievement: Priority Mail",
            tips = "Open the linked achievement in game and plan its incomplete criteria before travelling; some requirements need a group, a specific difficulty, or multiple weeks.",
        },
    },
    details = {
        ["Katy's Stampwhistle"] = {
            acquisition = "Obtain this toy from the listed source: Achievement: Priority Mail.",
            source = "Achievement: Priority Mail",
            sourceType = "Toy Box Source",
            tips = "Open the linked achievement in game and plan its incomplete criteria before travelling; some requirements need a group, a specific difficulty, or multiple weeks.",
        },
    },
})
