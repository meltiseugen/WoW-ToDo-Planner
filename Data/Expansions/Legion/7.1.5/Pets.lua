local _, TDP = ...

local shared = {}
shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h"] = {
    acquisition = "Obtain this battle pet from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h.",
    source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h",
    sourceType = "Pet Journal Source",
    tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
    waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
}

TDP.CatalogRegistry:RegisterCollection("7.1.5", "pets", {
    entries = {
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Conjuror Margoss / Zone: Dalaran / Faction: Conjuror Margoss - Best Friend / Cost: 50 currency.",
            name = "Trashy",
            npcId = 117371,
            source = "Vendor: Conjuror Margoss / Zone: Dalaran / Faction: Conjuror Margoss - Best Friend / Cost: 50 currency",
            speciesId = 2004,
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #627 48.6 62.8 Dalaran collection vendors" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h.",
            name = "Infinite Hatchling",
            npcId = 118060,
            source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h",
            speciesId = 2017,
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h.",
            name = "Paradox Spirit",
            npcId = 118063,
            source = "Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h",
            speciesId = 2018,
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #554 43.0 55.2 Mistweaver Xia" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Quackenbush / Zone: Deeprun Tram / Cost: 500 currency / Reputation: Bizmo's Brawlpub, Rank 3 / Vendor: Paul North / Zone: Brawl'gar Arena / Cost: 500 currency / Reputation: Brawl'gar Arena, Rank 3.",
            name = "Tylarr Gronnden",
            npcId = 119040,
            source = "Vendor: Quackenbush / Zone: Deeprun Tram / Cost: 500 currency / Reputation: Bizmo's Brawlpub, Rank 3 / Vendor: Paul North / Zone: Brawl'gar Arena / Cost: 500 currency / Reputation: Brawl'gar Arena, Rank 3",
            speciesId = 2022,
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #85 70.6 31.6 Brawl'gar Arena entrance" },
        },
    },
    details = {
        ["Infinite Hatchling"] = shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h"],
        ["Paradox Spirit"] = shared["Vendor: Mistweaver Xia / Zone: Timeless Isle / Cost: 2200 currency|h"],
        Trashy = {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Conjuror Margoss / Zone: Dalaran / Faction: Conjuror Margoss - Best Friend / Cost: 50 currency.",
            source = "Vendor: Conjuror Margoss / Zone: Dalaran / Faction: Conjuror Margoss - Best Friend / Cost: 50 currency",
            sourceType = "Pet Journal Source",
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #627 48.6 62.8 Dalaran collection vendors" },
        },
        ["Tylarr Gronnden"] = {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Quackenbush / Zone: Deeprun Tram / Cost: 500 currency / Reputation: Bizmo's Brawlpub, Rank 3 / Vendor: Paul North / Zone: Brawl'gar Arena / Cost: 500 currency / Reputation: Brawl'gar Arena, Rank 3.",
            source = "Vendor: Quackenbush / Zone: Deeprun Tram / Cost: 500 currency / Reputation: Bizmo's Brawlpub, Rank 3 / Vendor: Paul North / Zone: Brawl'gar Arena / Cost: 500 currency / Reputation: Brawl'gar Arena, Rank 3",
            sourceType = "Pet Journal Source",
            tips = "Confirm the required reputation, currency, and vendor phase before travelling.",
            waypoints = { "/way #85 70.6 31.6 Brawl'gar Arena entrance" },
        },
    },
})
