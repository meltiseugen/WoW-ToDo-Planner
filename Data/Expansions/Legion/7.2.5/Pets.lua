local _, TDP = ...

local shared = {}
shared["Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie"] = {
    acquisition = "Obtain this battle pet from the listed source: Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie.",
    source = "Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie",
    sourceType = "Pet Journal Source",
    tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
}

shared["Drop: Pickpocket"] = {
    acquisition = "Obtain this battle pet from the listed source: Drop: Pickpocket.",
    source = "Drop: Pickpocket",
    sourceType = "Pet Journal Source",
    tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
}

shared["Vendor: Marcus \"Bagman\" Brown / Zone: Westfall"] = {
    acquisition = "Obtain this battle pet from the listed source: Vendor: Marcus \"Bagman\" Brown / Zone: Westfall.",
    source = "Vendor: Marcus \"Bagman\" Brown / Zone: Westfall",
    sourceType = "Pet Journal Source",
    tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
    waypoints = { "/way #52 42.6 71.8 Moonbrook / Deadmines entrance" },
}

TDP.CatalogRegistry:RegisterCollection("7.2.5", "pets", {
    entries = {
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Marcus \"Bagman\" Brown / Zone: Westfall.",
            name = "Pocket Cannon",
            npcId = 119794,
            source = "Vendor: Marcus \"Bagman\" Brown / Zone: Westfall",
            speciesId = 2041,
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #52 42.6 71.8 Moonbrook / Deadmines entrance" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Marcus \"Bagman\" Brown / Zone: Westfall.",
            name = "Tricorne",
            npcId = 122612,
            source = "Vendor: Marcus \"Bagman\" Brown / Zone: Westfall",
            speciesId = 2057,
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #52 42.6 71.8 Moonbrook / Deadmines entrance" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Pickpocket.",
            name = "Sneaky Marmot",
            npcId = 124389,
            source = "Drop: Pickpocket",
            speciesId = 2063,
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Pet Battle Challenge: Deadmines.",
            name = "Mining Monkey",
            npcId = 124589,
            source = "Achievement: Pet Battle Challenge: Deadmines",
            speciesId = 2064,
            tips = "Bring a level-25 capture team and weaken wild pets below 35% health before trapping. Weather, secondary-spawn, or zone conditions can affect availability.",
            waypoints = { "/way #52 42.6 71.8 Deadmines entrance" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Pickpocket.",
            name = "Dig Rat",
            npcId = 124594,
            source = "Drop: Pickpocket",
            speciesId = 2065,
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie.",
            name = "Bronze Proto-Whelp",
            npcId = 124858,
            source = "Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie",
            speciesId = 2071,
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie.",
            name = "Ageless Bronze Drake",
            npcId = 124944,
            source = "Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie",
            speciesId = 2072,
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Vendor: Marcus \"Bagman\" Brown / Zone: Westfall.",
            name = "Foe Reaper 0.9",
            npcId = 122629,
            source = "Vendor: Marcus \"Bagman\" Brown / Zone: Westfall",
            speciesId = 2058,
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #52 42.6 71.8 Moonbrook / Deadmines entrance" },
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Drop: Oddly-Colored Egg.",
            name = "Sun Darter Hatchling",
            npcId = 61087,
            source = "Drop: Oddly-Colored Egg",
            speciesId = 382,
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Glory of the Tomb Raider.",
            name = "Micronax",
            npcId = 63724,
            source = "Achievement: Glory of the Tomb Raider",
            speciesId = 666,
            tips = "Check the required raid difficulty and weekly loot lockout before the run. Use eligible alts for additional attempts where the reward remains a random drop.",
        },
    },
    details = {
        ["Ageless Bronze Drake"] = shared["Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie"],
        ["Bronze Proto-Whelp"] = shared["Drop: Time-Lost Wallet / Scenario: The Deaths of Chromie"],
        ["Dig Rat"] = shared["Drop: Pickpocket"],
        ["Foe Reaper 0.9"] = shared["Vendor: Marcus \"Bagman\" Brown / Zone: Westfall"],
        Micronax = {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Glory of the Tomb Raider.",
            source = "Achievement: Glory of the Tomb Raider",
            sourceType = "Pet Journal Source",
            tips = "Check the required raid difficulty and weekly loot lockout before the run. Use eligible alts for additional attempts where the reward remains a random drop.",
        },
        ["Mining Monkey"] = {
            acquisition = "Obtain this battle pet from the listed source: Achievement: Pet Battle Challenge: Deadmines.",
            source = "Achievement: Pet Battle Challenge: Deadmines",
            sourceType = "Pet Journal Source",
            tips = "Bring a level-25 capture team and weaken wild pets below 35% health before trapping. Weather, secondary-spawn, or zone conditions can affect availability.",
            waypoints = { "/way #52 42.6 71.8 Deadmines entrance" },
        },
        ["Pocket Cannon"] = shared["Vendor: Marcus \"Bagman\" Brown / Zone: Westfall"],
        ["Sneaky Marmot"] = shared["Drop: Pickpocket"],
        ["Sun Darter Hatchling"] = {
            acquisition = "Obtain this battle pet from the listed source: Drop: Oddly-Colored Egg.",
            source = "Drop: Oddly-Colored Egg",
            sourceType = "Pet Journal Source",
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        Tricorne = shared["Vendor: Marcus \"Bagman\" Brown / Zone: Westfall"],
    },
})
