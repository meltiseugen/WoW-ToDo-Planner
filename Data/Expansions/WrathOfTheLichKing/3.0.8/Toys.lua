local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.0.8", "toys", {
    entries = {
        {
            acquisition = "Obtain Tiny Green Ragdoll from Jepetto Joybuzz and city toy vendors.",
            category = "Vendor",
            itemId = 54437,
            name = "Tiny Green Ragdoll",
            npcId = 29478,
            source = "Jepetto Joybuzz and city toy vendors",
            tips = "Buy the modern replacement item from a toy vendor. The original item 44849 was introduced in 3.0.8 and replaced in 3.3.3.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
    },
    details = {
        ["Tiny Green Ragdoll"] = {
            acquisition = "Obtain Tiny Green Ragdoll from Jepetto Joybuzz and city toy vendors.",
            source = "Jepetto Joybuzz and city toy vendors",
            sourceType = "Toy Box Source",
            tips = "Buy the modern replacement item from a toy vendor. The original item 44849 was introduced in 3.0.8 and replaced in 3.3.3.",
            waypoints = { "/way #125 44.0 45.0 Jepetto Joybuzz / Wonderworks" },
        },
    },
})
