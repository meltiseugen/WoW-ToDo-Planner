local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("8.1.5", "toys", {
    entries = {
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 500Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 500Timewarped Badge.",
            itemId = 168012,
            name = "Apexis Focusing Shard",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 500Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 500Timewarped Badge",
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 750Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 750Timewarped Badge.",
            itemId = 168014,
            name = "Banner of the Burning Blade",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 750Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 750Timewarped Badge",
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Quest: His Eye Upon You / Zone: Zuldazar / Quest: His Eye Upon You / Zone: Stormsong Valley.",
            itemId = 168123,
            name = "Twitching Eyeball",
            source = "Quest: His Eye Upon You / Zone: Zuldazar / Quest: His Eye Upon You / Zone: Stormsong Valley",
            tips = "For rare, cache, and rotating sources, verify the active Warfront, assault, island theme, or daily before starting the route.",
            waypoints = { "/way #942 59.2 69.0 Brennadam collection route", "/way #862 58.0 44.0 Zuldazar collection route" },
        },
    },
    details = {
        ["Apexis Focusing Shard"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 500Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 500Timewarped Badge.",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 500Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 500Timewarped Badge",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        ["Banner of the Burning Blade"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 750Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 750Timewarped Badge.",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 750Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 750Timewarped Badge",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        ["Twitching Eyeball"] = {
            acquisition = "Obtain this toy from the listed source: Quest: His Eye Upon You / Zone: Zuldazar / Quest: His Eye Upon You / Zone: Stormsong Valley.",
            source = "Quest: His Eye Upon You / Zone: Zuldazar / Quest: His Eye Upon You / Zone: Stormsong Valley",
            sourceType = "Toy Box Source",
            tips = "For rare, cache, and rotating sources, verify the active Warfront, assault, island theme, or daily before starting the route.",
            waypoints = { "/way #942 59.2 69.0 Brennadam collection route", "/way #862 58.0 44.0 Zuldazar collection route" },
        },
    },
})
