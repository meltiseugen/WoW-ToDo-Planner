local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("6.2.2", "pets", {
    entries = {
        {
            acquisition = "Obtain Energized Manafiend from Drop: Rukdug / Nagrand.",
            name = "Energized Manafiend",
            npcId = 98236,
            source = "Drop: Rukdug / Nagrand",
            speciesId = 1764,
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 25.9 34.7 Rukdug" },
        },
        {
            acquisition = "Obtain Empyreal Manafiend from Drop: Guk / Nagrand.",
            name = "Empyreal Manafiend",
            npcId = 98238,
            source = "Drop: Guk / Nagrand",
            speciesId = 1765,
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 23.7 38.5 Guk" },
        },
        {
            acquisition = "Obtain Empowered Manafiend from Drop: Pugg / Nagrand.",
            name = "Empowered Manafiend",
            npcId = 98237,
            source = "Drop: Pugg / Nagrand",
            speciesId = 1766,
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 28.1 29.6 Pugg" },
        },
    },
    details = {
        ["Empowered Manafiend"] = {
            acquisition = "Obtain Empowered Manafiend from Drop: Pugg / Nagrand.",
            source = "Drop: Pugg / Nagrand",
            sourceType = "Pet Journal Source",
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 28.1 29.6 Pugg" },
        },
        ["Empyreal Manafiend"] = {
            acquisition = "Obtain Empyreal Manafiend from Drop: Guk / Nagrand.",
            source = "Drop: Guk / Nagrand",
            sourceType = "Pet Journal Source",
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 23.7 38.5 Guk" },
        },
        ["Energized Manafiend"] = {
            acquisition = "Obtain Energized Manafiend from Drop: Rukdug / Nagrand.",
            source = "Drop: Rukdug / Nagrand",
            sourceType = "Pet Journal Source",
            tips = "Bring a capture team for wild pets; for drops and vendors, check the stated lockout, currency, or prerequisite before travelling.",
            waypoints = { "/way #550 25.9 34.7 Rukdug" },
        },
    },
})
