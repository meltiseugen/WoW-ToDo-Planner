local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("8.2.5", "mounts", {
    entries = {
        {
            acquisition = "Obtain this mount from the listed source: Quest: Leaving the Hive: Harvester / Zone: Stormsong Valley.",
            name = "Honeyback Harvester",
            source = "Quest: Leaving the Hive: Harvester / Zone: Stormsong Valley",
            spellId = 259741,
            tips = "Check the relevant rare, reputation, achievement, profession, or quest prerequisite before starting the farm.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
    },
    details = {
        ["Honeyback Harvester"] = {
            acquisition = "Obtain this mount from the listed source: Quest: Leaving the Hive: Harvester / Zone: Stormsong Valley.",
            category = "Other",
            source = "Quest: Leaving the Hive: Harvester / Zone: Stormsong Valley",
            sourceType = "Patch mount collection",
            tips = "Check the relevant rare, reputation, achievement, profession, or quest prerequisite before starting the farm.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
    },
})
