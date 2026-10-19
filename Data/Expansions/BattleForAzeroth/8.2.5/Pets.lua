local _, TDP = ...

local shared = {}
shared["Drop: Fresh Jelly Deposit / Zone: Stormsong Valley"] = {
    acquisition = "Obtain this battle pet from the listed source: Drop: Fresh Jelly Deposit / Zone: Stormsong Valley.",
    source = "Drop: Fresh Jelly Deposit / Zone: Stormsong Valley",
    sourceType = "Pet Journal Source",
    tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
    waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
}

TDP.CatalogRegistry:RegisterCollection("8.2.5", "pets", {
    entries = {
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Fresh Jelly Deposit / Zone: Stormsong Valley.",
            name = "Papi",
            npcId = 158681,
            source = "Drop: Fresh Jelly Deposit / Zone: Stormsong Valley",
            speciesId = 2792,
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Fresh Jelly Deposit / Zone: Stormsong Valley.",
            name = "Sunsoaked Flitter",
            npcId = 158683,
            source = "Drop: Fresh Jelly Deposit / Zone: Stormsong Valley",
            speciesId = 2793,
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Honey Smasher / Zone: Stormsong Valley.",
            name = "Crimson Skipper",
            npcId = 158685,
            source = "Drop: Honey Smasher / Zone: Stormsong Valley",
            speciesId = 2794,
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Jenafur.",
            name = "Jenafur",
            npcId = 159783,
            source = "Drop: Jenafur",
            speciesId = 2795,
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
        },
    },
    details = {
        ["Crimson Skipper"] = {
            acquisition = "Obtain this battle pet from the listed source: Drop: Honey Smasher / Zone: Stormsong Valley.",
            source = "Drop: Honey Smasher / Zone: Stormsong Valley",
            sourceType = "Pet Journal Source",
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
            waypoints = { "/way #942 62.5 26.0 Honeyback Hive" },
        },
        Jenafur = {
            acquisition = "Obtain this battle pet from the listed source: Drop: Jenafur.",
            source = "Drop: Jenafur",
            sourceType = "Pet Journal Source",
            tips = "Rare drops and paragon-cache pets can take repeated attempts; wild pets may require clearing critter spawns to force battle-pet respawns.",
        },
        Papi = shared["Drop: Fresh Jelly Deposit / Zone: Stormsong Valley"],
        ["Sunsoaked Flitter"] = shared["Drop: Fresh Jelly Deposit / Zone: Stormsong Valley"],
    },
})
