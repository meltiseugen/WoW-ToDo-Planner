local _, TDP = ...

local shared = {}
shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking"] = {
    acquisition = "Obtain this toy from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking.",
    source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking",
    sourceType = "Toy Box Source",
    tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
    waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
}

TDP.CatalogRegistry:RegisterCollection("7.1.5", "toys", {
    entries = {
        {
            acquisition = "Obtain this toy from the listed source: Drop: High Botanist Tel'arn / Raid: The Nighthold.",
            itemId = 119211,
            name = "Golden Hearthstone Card: Lord Jaraxxus",
            source = "Drop: High Botanist Tel'arn / Raid: The Nighthold",
            tips = "Check the raid difficulty and weekly loot lockout before farming; use eligible alts where the source permits it.",
            waypoints = { "/way #680 44.2 59.8 Shal'Aran / Suramar hub" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Drop: Gul'dan / Raid: The Nighthold.",
            itemId = 143544,
            name = "Skull of Corruption",
            source = "Drop: Gul'dan / Raid: The Nighthold",
            tips = "Check the raid difficulty and weekly loot lockout before farming; use eligible alts where the source permits it.",
            waypoints = { "/way #680 44.2 59.8 Shal'Aran / Suramar hub" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking.",
            itemId = 144072,
            name = "Adopted Puppy Crate",
            source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking",
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking.",
            itemId = 144393,
            name = "Portable Yak Wash",
            source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking",
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
        },
    },
    details = {
        ["Adopted Puppy Crate"] = shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking"],
        ["Golden Hearthstone Card: Lord Jaraxxus"] = {
            acquisition = "Obtain this toy from the listed source: Drop: High Botanist Tel'arn / Raid: The Nighthold.",
            source = "Drop: High Botanist Tel'arn / Raid: The Nighthold",
            sourceType = "Toy Box Source",
            tips = "Check the raid difficulty and weekly loot lockout before farming; use eligible alts where the source permits it.",
            waypoints = { "/way #680 44.2 59.8 Shal'Aran / Suramar hub" },
        },
        ["Portable Yak Wash"] = shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Mists of Pandaria Timewalking"],
        ["Skull of Corruption"] = {
            acquisition = "Obtain this toy from the listed source: Drop: Gul'dan / Raid: The Nighthold.",
            source = "Drop: Gul'dan / Raid: The Nighthold",
            sourceType = "Toy Box Source",
            tips = "Check the raid difficulty and weekly loot lockout before farming; use eligible alts where the source permits it.",
            waypoints = { "/way #680 44.2 59.8 Shal'Aran / Suramar hub" },
        },
    },
})
