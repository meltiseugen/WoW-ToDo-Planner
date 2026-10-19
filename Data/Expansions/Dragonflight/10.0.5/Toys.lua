local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.0.5", "toys", {
    entries = { { itemId = 202020, name = "Chasing Storm" }, { itemId = 202207, name = "Reusable Oversized Bobber" }, { itemId = 202309, name = "Defective Doomsday Device" } },
    details = {
        ["Chasing Storm"] = {
            acquisition = "Buy from Brendormi after farming the permanent Storm's Fury event.",
            cost = "75 Essence of the Storm and 1,200 Elemental Overflow.",
            source = "Brendormi / Storm's Fury",
            sourceType = "Event vendor",
            waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" },
        },
        ["Defective Doomsday Device"] = {
            acquisition = "Craft with Dragon Isles Engineering or obtain the finished toy through a crafting order.",
            source = "Dragon Isles Engineering",
            sourceType = "Profession",
            waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" },
        },
        ["Reusable Oversized Bobber"] = { acquisition = "Complete Discombobberlated by using oversized bobbers at the required Dragon Isles fishing holes.", source = "Discombobberlated", sourceType = "Achievement" },
    },
})
