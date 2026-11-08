local _, TDP = ...

local shared = {}
shared["Argent Tournament"] = {
    acquisition = "Complete the listed faction-reputation, city-champion, or Argent Pony tournament criterion.",
    source = "Argent Tournament",
    sourceType = "Achievement",
    tips = "Work toward every home-city champion rank while banking Champion's Seals; this unlocks Crusader vendors and the faction pavilion rewards together.",
    waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
}

shared["Isle of Conquest"] = {
    acquisition = "Complete the listed Isle of Conquest victory, vehicle, node, bomb, kill-location, or meta criterion.",
    source = "Isle of Conquest",
    sourceType = "Achievement",
    tips = "Track each objective separately and coordinate vehicle or node requirements with the team; some achievements require a single battleground.",
}

shared["Trial of the Champion"] = {
    acquisition = "Complete Trial of the Champion or its listed heroic encounter mechanic.",
    source = "Trial of the Champion",
    sourceType = "Achievement",
    tips = "Set Heroic where required. For Argent Confessor, the memory opponent varies between visits, so the achievement needs several clears.",
    waypoints = { "/way #118 75.0 21.8 Crusaders' Coliseum entrance" },
}

shared["Trial of the Crusader and Trial of the Grand Crusader"] = {
    acquisition = "Complete the listed raid clear or encounter mechanic in the required raid size and difficulty.",
    source = "Trial of the Crusader and Trial of the Grand Crusader",
    sourceType = "Achievement",
    tips = "Read the exact mechanic before dealing damage. Several achievements require leaving adds alive or delaying the boss kill; set the required difficulty before entering.",
    waypoints = { "/way #118 75.0 21.8 Trial of the Crusader entrance" },
}

shared["Vault of Archavon"] = {
    acquisition = "Defeat Koralon or complete the listed multi-Watcher timing criterion in the original raid size.",
    source = "Vault of Archavon",
    sourceType = "Achievement",
    tips = "Vault access historically required Wintergrasp control. Earth, Wind & Fire needs the three Watchers defeated within one minute.",
    waypoints = { "/way #123 50.0 11.0 Vault of Archavon entrance" },
}

shared["Onyxia's Lair"] = {
    acquisition = "Defeat the level-80 Onyxia encounter or complete its listed speed, whelp, or Deep Breath criterion.",
    source = "Onyxia's Lair",
    sourceType = "Achievement",
    tips = "For Many Whelps, allow the required eggs to hatch before killing Onyxia. For Deep Breath, avoid the center line during the air phase.",
    waypoints = { "/way #70 52.0 76.0 Onyxia's Lair entrance" },
}

TDP.CatalogRegistry:RegisterCollection("3.2.0", "achievements", {
    entries = {
        ids = {
            3676, -- A Silver Confidant
            3677, -- The Sunreavers
            3736, -- Pony Up!
            3776, -- Isle of Conquest Victory
            3777, -- Isle of Conquest Veteran
            3778, -- Trial of the Champion
            3797, -- Upper Back Pain (10 player)
            3798, -- Resilience Will Fix It (10 player)
            3799, -- Salt and Pepper (10 player)
            3800, -- The Traitor King (10 player)
            3802, -- Argent Confessor
            3803, -- The Faceroller
            3804, -- I've Had Worse
            3812, -- Call of the Grand Crusade (25 player)
            3813, -- Upper Back Pain (25 player)
            3815, -- Salt and Pepper (25 player)
            3816, -- The Traitor King (25 player)
            3836, -- Koralon the Flame Watcher (10 player)
            3837, -- Koralon the Flame Watcher (25 player)
            3845, -- Isle of Conquest All-Star
            3846, -- Resource Glut
            3847, -- Four Car Garage
            3848, -- A-bomb-inable
            3849, -- A-bomb-ination
            3850, -- Mowed Down
            3851, -- Mine
            3852, -- Cut the Blue Wire... No the Red Wire!
            3853, -- All Over the Isle
            3854, -- Back Door Job
            3855, -- Glaive Grave
            3856, -- Demolition Derby
            3857, -- Master of Isle of Conquest
            3916, -- Call of the Crusade (25 player)
            3917, -- Call of the Crusade (10 player)
            3918, -- Call of the Grand Crusade (10 player)
            3936, -- Not One, But Two Jormungars (10 player)
            3937, -- Not One, But Two Jormungars (25 player)
            3957, -- Master of Isle of Conquest
            3996, -- Three Sixty Pain Spike (10 player)
            3997, -- Three Sixty Pain Spike (25 player)
            4016, -- Earth, Wind & Fire (10 player)
            4017, -- Earth, Wind & Fire (25 player)
            4176, -- Resource Glut
            4177, -- Mine
            4256, -- Demolition Derby
            4296, -- Trial of the Champion
            4297, -- Heroic: Trial of the Champion
            4298, -- Heroic: Trial of the Champion
            4396, -- Onyxia's Lair (10 player)
            4397, -- Onyxia's Lair (25 player)
            4402, -- More Dots! (10 player)
            4403, -- Many Whelps! Handle It! (10 player)
            4404, -- She Deep Breaths More (10 player)
            4405, -- More Dots! (25 player)
            4406, -- Many Whelps! Handle It! (25 player)
            4407, -- She Deep Breaths More (25 player)
        },
        rewardHighlights = {},
    },
    details = {
        [3676] = shared["Argent Tournament"],
        [3677] = shared["Argent Tournament"],
        [3736] = shared["Argent Tournament"],
        [3776] = shared["Isle of Conquest"],
        [3777] = shared["Isle of Conquest"],
        [3778] = shared["Trial of the Champion"],
        [3797] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3798] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3799] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3800] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3802] = shared["Trial of the Champion"],
        [3803] = shared["Trial of the Champion"],
        [3804] = shared["Trial of the Champion"],
        [3812] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3813] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3815] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3816] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3836] = shared["Vault of Archavon"],
        [3837] = shared["Vault of Archavon"],
        [3845] = shared["Isle of Conquest"],
        [3846] = shared["Isle of Conquest"],
        [3847] = shared["Isle of Conquest"],
        [3848] = shared["Isle of Conquest"],
        [3849] = shared["Isle of Conquest"],
        [3850] = shared["Isle of Conquest"],
        [3851] = shared["Isle of Conquest"],
        [3852] = shared["Isle of Conquest"],
        [3853] = shared["Isle of Conquest"],
        [3854] = shared["Isle of Conquest"],
        [3855] = shared["Isle of Conquest"],
        [3856] = shared["Isle of Conquest"],
        [3857] = shared["Isle of Conquest"],
        [3916] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3917] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3918] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3936] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3937] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3957] = shared["Isle of Conquest"],
        [3996] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [3997] = shared["Trial of the Crusader and Trial of the Grand Crusader"],
        [4016] = shared["Vault of Archavon"],
        [4017] = shared["Vault of Archavon"],
        [4176] = shared["Isle of Conquest"],
        [4177] = shared["Isle of Conquest"],
        [4256] = shared["Isle of Conquest"],
        [4296] = shared["Trial of the Champion"],
        [4297] = shared["Trial of the Champion"],
        [4298] = shared["Trial of the Champion"],
        [4396] = shared["Onyxia's Lair"],
        [4397] = shared["Onyxia's Lair"],
        [4402] = shared["Onyxia's Lair"],
        [4403] = shared["Onyxia's Lair"],
        [4404] = shared["Onyxia's Lair"],
        [4405] = shared["Onyxia's Lair"],
        [4406] = shared["Onyxia's Lair"],
        [4407] = shared["Onyxia's Lair"],
    },
    categories = {
        [3676] = "Questing",
        [3677] = "Questing",
        [3736] = "Questing",
        [3776] = "PvP",
        [3777] = "PvP",
        [3778] = "Dungeons",
        [3797] = "Raids",
        [3798] = "Raids",
        [3799] = "Raids",
        [3800] = "Raids",
        [3802] = "Dungeons",
        [3803] = "Dungeons",
        [3804] = "Dungeons",
        [3812] = "Raids",
        [3813] = "Raids",
        [3815] = "Raids",
        [3816] = "Raids",
        [3836] = "Raids",
        [3837] = "Raids",
        [3845] = "PvP",
        [3846] = "PvP",
        [3847] = "PvP",
        [3848] = "PvP",
        [3849] = "PvP",
        [3850] = "PvP",
        [3851] = "PvP",
        [3852] = "PvP",
        [3853] = "PvP",
        [3854] = "PvP",
        [3855] = "PvP",
        [3856] = "PvP",
        [3857] = "PvP",
        [3916] = "Raids",
        [3917] = "Raids",
        [3918] = "Raids",
        [3936] = "Raids",
        [3937] = "Raids",
        [3957] = "PvP",
        [3996] = "Raids",
        [3997] = "Raids",
        [4016] = "Raids",
        [4017] = "Raids",
        [4176] = "PvP",
        [4177] = "PvP",
        [4256] = "PvP",
        [4296] = "Dungeons",
        [4297] = "Dungeons",
        [4298] = "Dungeons",
        [4396] = "Raids",
        [4397] = "Raids",
        [4402] = "Raids",
        [4403] = "Raids",
        [4404] = "Raids",
        [4405] = "Raids",
        [4406] = "Raids",
        [4407] = "Raids",
    },
})
