local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("6.2.3", "mounts", {
    entries = {
        {
            acquisition = "Earn Gladiator during Warlords PvP Season 3.",
            category = "PvP",
            name = "Warmongering Gladiator's Felblood Gronnling",
            source = "Gladiator: Warlords Season 3",
            spellId = 189044,
            tips = "Historical limited reward; it is no longer obtainable from its original rated-PvP source.",
        },
        {
            acquisition = "During the original availability window, defeat Heroic Archimonde and complete Dark Waters in Moonglade.",
            category = "Quest Rewards",
            name = "Grove Warden",
            source = "Quest: Dark Waters after defeating Heroic Archimonde",
            spellId = 189999,
            tips = "Historical limited reward; the quest was removed with the Legion pre-patch.",
            waypoints = { "/way #80 48.6 40.2 Moonglade" },
        },
        {
            acquisition = "Loot the rare mount from any Timewalking dungeon boss.",
            category = "Dungeon and Raids",
            name = "Infinite Timereaver",
            source = "Any Timewalking dungeon boss",
            spellId = 201098,
            tips = "Run fast Timewalking dungeons on tank or healer queues; every boss, not only the final boss, can drop it.",
        },
    },
    details = {
        ["Grove Warden"] = {
            acquisition = "During the original availability window, defeat Heroic Archimonde and complete Dark Waters in Moonglade.",
            category = "Quest Rewards",
            source = "Quest: Dark Waters after defeating Heroic Archimonde",
            sourceType = "Patch mount collection",
            tips = "Historical limited reward; the quest was removed with the Legion pre-patch.",
            waypoints = { "/way #80 48.6 40.2 Moonglade" },
        },
        ["Infinite Timereaver"] = {
            acquisition = "Loot the rare mount from any Timewalking dungeon boss.",
            category = "Dungeon and Raids",
            source = "Any Timewalking dungeon boss",
            sourceType = "Patch mount collection",
            tips = "Run fast Timewalking dungeons on tank or healer queues; every boss, not only the final boss, can drop it.",
        },
        ["Warmongering Gladiator's Felblood Gronnling"] = {
            acquisition = "Earn Gladiator during Warlords PvP Season 3.",
            category = "PvP",
            source = "Gladiator: Warlords Season 3",
            sourceType = "Patch mount collection",
            tips = "Historical limited reward; it is no longer obtainable from its original rated-PvP source.",
        },
    },
})
