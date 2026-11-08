local _, TDP = ...

local shared = {}
shared["The Frozen Halls"] = {
    acquisition = "Complete the listed Forge of Souls, Pit of Saron, or Halls of Reflection clear or heroic mechanic.",
    source = "The Frozen Halls",
    sourceType = "Achievement",
    tips = "Set Heroic for mechanic achievements and avoid excessive damage until adds, casts, or the timed escape criterion has registered.",
    waypoints = { "/way #118 52.6 89.4 Frozen Halls entrance" },
}

shared["Icecrown Citadel"] = {
    acquisition = "Complete the listed Icecrown Citadel wing, difficulty, meta, or special encounter criterion.",
    source = "Icecrown Citadel",
    sourceType = "Achievement",
    tips = "Verify raid size and difficulty first. At high level, stop damage until mechanics register; Once Bitten, Twice Shy requires two clears with opposite vampire states.",
    waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
}

shared["Wrath raid and legendary feats"] = {
    acquisition = "Complete the Shadowmourne questline or learn the specified rare raid mount.",
    source = "Wrath raid and legendary feats",
    sourceType = "Achievement",
    tips = "Shadowmourne requires repeated 25-player Icecrown clears; Invincible and Mimiron's Head use weekly raid lockouts. Read the mount's required difficulty before starting.",
    waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
}

shared["Toravon in the Vault of Archavon"] = {
    acquisition = "Defeat Toravon in the listed original raid size.",
    source = "Toravon in the Vault of Archavon",
    sourceType = "Achievement",
    tips = "Vault access historically required Wintergrasp control.",
    waypoints = { "/way #123 50.0 11.0 Vault of Archavon entrance" },
}

TDP.CatalogRegistry:RegisterCollection("3.3.0", "achievements", {
    entries = {
        ids = {
            4516, -- The Forge of Souls
            4517, -- The Pit of Saron
            4518, -- The Halls of Reflection
            4519, -- Heroic: The Forge of Souls
            4520, -- Heroic: The Pit of Saron
            4521, -- Heroic: The Halls of Reflection
            4522, -- Soul Power
            4523, -- Three Faced
            4526, -- We're Not Retreating; We're Advancing in a Different Direction.
            4527, -- The Frostwing Halls (10 player)
            4528, -- The Plagueworks (10 player)
            4529, -- The Crimson Hall (10 player)
            4530, -- The Frozen Throne (10 player)
            4531, -- Storming the Citadel (10 player)
            4532, -- Fall of the Lich King (10 player)
            4534, -- Boned (10 player)
            4535, -- Full House (10 player)
            4536, -- I'm on a Boat (10 player)
            4537, -- I've Gone and Made a Mess (10 player)
            4538, -- Dances with Oozes (10 player)
            4539, -- Once Bitten, Twice Shy (10 player)
            4577, -- Flu Shot Shortage (10 player)
            4578, -- Nausea, Heartburn, Indigestion... (10 player)
            4579, -- Portal Jockey (10 player)
            4580, -- All You Can Eat (10 player)
            4581, -- Neck-Deep in Vile (10 player)
            4582, -- The Orb Whisperer (10 player)
            4583, -- Bane of the Fallen King
            4584, -- The Light of Dawn
            4585, -- Toravon the Ice Watcher (10 player)
            4586, -- Toravon the Ice Watcher (25 player)
            4596, -- The Sword in the Skull
            4597, -- The Frozen Throne (25 player)
            4598, -- The Ashen Verdict
            4601, -- Been Waiting a Long Time for This (10 player)
            4602, -- Glory of the Icecrown Raider (10 player)
            4603, -- Glory of the Icecrown Raider (25 player)
            4604, -- Storming the Citadel (25 player)
            4605, -- The Plagueworks (25 player)
            4606, -- The Crimson Hall (25 player)
            4607, -- The Frostwing Halls (25 player)
            4608, -- Fall of the Lich King (25 player)
            4610, -- Boned (25 player)
            4611, -- Full House (25 player)
            4612, -- I'm on a Boat (25 player)
            4613, -- I've Gone and Made a Mess (25 player)
            4614, -- Dances with Oozes (25 player)
            4615, -- Flu Shot Shortage (25 player)
            4616, -- Nausea, Heartburn, Indigestion... (25 player)
            4617, -- The Orb Whisperer (25 player)
            4618, -- Once Bitten, Twice Shy (25 player)
            4619, -- Portal Jockey (25 player)
            4620, -- All You Can Eat (25 player)
            4621, -- Been Waiting a Long Time for This (25 player)
            4622, -- Neck-Deep in Vile (25 player)
            4623, -- Shadowmourne
            4625, -- Invincible's Reins
            4626, -- And I'll Form the Head!
            4628, -- Heroic: Storming the Citadel (10 player)
            4629, -- Heroic: The Plagueworks (10 player)
            4630, -- Heroic: The Crimson Hall (10 player)
            4631, -- Heroic: The Frostwing Halls (10 player)
            4632, -- Heroic: Storming the Citadel (25 player)
            4633, -- Heroic: The Plagueworks (25 player)
            4634, -- Heroic: The Crimson Hall (25 player)
            4635, -- Heroic: The Frostwing Halls (25 player)
            4636, -- Heroic: Fall of the Lich King (10 player)
            4637, -- Heroic: Fall of the Lich King (25 player)
        },
        rewardHighlights = {},
    },
    details = {
        [4516] = shared["The Frozen Halls"],
        [4517] = shared["The Frozen Halls"],
        [4518] = shared["The Frozen Halls"],
        [4519] = shared["The Frozen Halls"],
        [4520] = shared["The Frozen Halls"],
        [4521] = shared["The Frozen Halls"],
        [4522] = shared["The Frozen Halls"],
        [4523] = shared["The Frozen Halls"],
        [4526] = shared["The Frozen Halls"],
        [4527] = shared["Icecrown Citadel"],
        [4528] = shared["Icecrown Citadel"],
        [4529] = shared["Icecrown Citadel"],
        [4530] = shared["Icecrown Citadel"],
        [4531] = shared["Icecrown Citadel"],
        [4532] = shared["Icecrown Citadel"],
        [4534] = shared["Icecrown Citadel"],
        [4535] = shared["Icecrown Citadel"],
        [4536] = shared["Icecrown Citadel"],
        [4537] = shared["Icecrown Citadel"],
        [4538] = shared["Icecrown Citadel"],
        [4539] = shared["Icecrown Citadel"],
        [4577] = shared["Icecrown Citadel"],
        [4578] = shared["Icecrown Citadel"],
        [4579] = shared["Icecrown Citadel"],
        [4580] = shared["Icecrown Citadel"],
        [4581] = shared["Icecrown Citadel"],
        [4582] = shared["Icecrown Citadel"],
        [4583] = shared["Icecrown Citadel"],
        [4584] = shared["Icecrown Citadel"],
        [4585] = shared["Toravon in the Vault of Archavon"],
        [4586] = shared["Toravon in the Vault of Archavon"],
        [4596] = {
            acquisition = "Recover, reforge, purify, and present Quel'Delar through the Battered Hilt questline.",
            source = "Quel'Delar questline",
            sourceType = "Achievement",
            tips = "The Battered Hilt begins as a rare drop in the Frozen Halls and is tradeable; follow the chain through the Sunwell.",
            waypoints = { "/way #118 52.6 89.4 Frozen Halls entrance", "/way #122 44.0 45.0 Sunwell Plateau" },
        },
        [4597] = shared["Icecrown Citadel"],
        [4598] = {
            acquisition = "Reach Exalted with the Ashen Verdict in Icecrown Citadel.",
            source = "The Ashen Verdict",
            sourceType = "Achievement",
            tips = "Clear raid trash and bosses each week; the Shadowmourne chain also grants substantial reputation.",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
        },
        [4601] = {
            acquisition = "1. Enter Icecrown Citadel in the raid size named by this achievement, reach the Frozen Throne and speak to Tirion to start the encounter.\n2. Stand on the stairs with your back toward the throne. Stop attacking and let the Lich King summon adds; keep them alive for Necrotic Plague to jump between.\n3. Watch Necrotic Plague on yourself and the adds until it reaches at least 30 stacks. The boss's Plague Siphon buff is a different counter.\n4. Only then damage the Lich King. Let the final dialogue, resurrection and Tirion's intervention finish before dealing the killing blow.",
            sourceType = "Achievement",
            source = "Icecrown Citadel entrance",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
            sourceURL = "https://www.wowhead.com/achievement=4601#comments",
        },
        [4602] = shared["Icecrown Citadel"],
        [4603] = shared["Icecrown Citadel"],
        [4604] = shared["Icecrown Citadel"],
        [4605] = shared["Icecrown Citadel"],
        [4606] = shared["Icecrown Citadel"],
        [4607] = shared["Icecrown Citadel"],
        [4608] = shared["Icecrown Citadel"],
        [4610] = shared["Icecrown Citadel"],
        [4611] = shared["Icecrown Citadel"],
        [4612] = shared["Icecrown Citadel"],
        [4613] = shared["Icecrown Citadel"],
        [4614] = shared["Icecrown Citadel"],
        [4615] = shared["Icecrown Citadel"],
        [4616] = shared["Icecrown Citadel"],
        [4617] = shared["Icecrown Citadel"],
        [4618] = shared["Icecrown Citadel"],
        [4619] = shared["Icecrown Citadel"],
        [4620] = shared["Icecrown Citadel"],
        [4621] = {
            acquisition = "1. Enter Icecrown Citadel in the raid size named by this achievement, reach the Frozen Throne and speak to Tirion to start the encounter.\n2. Stand on the stairs with your back toward the throne. Stop attacking and let the Lich King summon adds; keep them alive for Necrotic Plague to jump between.\n3. Watch Necrotic Plague on yourself and the adds until it reaches at least 30 stacks. The boss's Plague Siphon buff is a different counter.\n4. Only then damage the Lich King. Let the final dialogue, resurrection and Tirion's intervention finish before dealing the killing blow.",
            sourceType = "Achievement",
            source = "Icecrown Citadel entrance",
            waypoints = { "/way #118 53.5 85.5 Icecrown Citadel entrance" },
            sourceURL = "https://www.wowhead.com/achievement=4621#comments",
        },
        [4622] = shared["Icecrown Citadel"],
        [4623] = shared["Wrath raid and legendary feats"],
        [4625] = shared["Wrath raid and legendary feats"],
        [4626] = shared["Wrath raid and legendary feats"],
        [4628] = shared["Icecrown Citadel"],
        [4629] = shared["Icecrown Citadel"],
        [4630] = shared["Icecrown Citadel"],
        [4631] = shared["Icecrown Citadel"],
        [4632] = shared["Icecrown Citadel"],
        [4633] = shared["Icecrown Citadel"],
        [4634] = shared["Icecrown Citadel"],
        [4635] = shared["Icecrown Citadel"],
        [4636] = shared["Icecrown Citadel"],
        [4637] = shared["Icecrown Citadel"],
    },
    categories = {
        [4516] = "Dungeons",
        [4517] = "Dungeons",
        [4518] = "Dungeons",
        [4519] = "Dungeons",
        [4520] = "Dungeons",
        [4521] = "Dungeons",
        [4522] = "Dungeons",
        [4523] = "Dungeons",
        [4526] = "Dungeons",
        [4527] = "Raids",
        [4528] = "Raids",
        [4529] = "Raids",
        [4530] = "Raids",
        [4531] = "Raids",
        [4532] = "Raids",
        [4534] = "Raids",
        [4535] = "Raids",
        [4536] = "Raids",
        [4537] = "Raids",
        [4538] = "Raids",
        [4539] = "Raids",
        [4577] = "Raids",
        [4578] = "Raids",
        [4579] = "Raids",
        [4580] = "Raids",
        [4581] = "Raids",
        [4582] = "Raids",
        [4583] = "Raids",
        [4584] = "Raids",
        [4585] = "Raids",
        [4586] = "Raids",
        [4596] = "Questing",
        [4597] = "Raids",
        [4598] = "Reputation",
        [4601] = "Raids",
        [4602] = "Raids",
        [4603] = "Raids",
        [4604] = "Raids",
        [4605] = "Raids",
        [4606] = "Raids",
        [4607] = "Raids",
        [4608] = "Raids",
        [4610] = "Raids",
        [4611] = "Raids",
        [4612] = "Raids",
        [4613] = "Raids",
        [4614] = "Raids",
        [4615] = "Raids",
        [4616] = "Raids",
        [4617] = "Raids",
        [4618] = "Raids",
        [4619] = "Raids",
        [4620] = "Raids",
        [4621] = "Raids",
        [4622] = "Raids",
        [4623] = "Feats of Strength",
        [4625] = "Feats of Strength",
        [4626] = "Feats of Strength",
        [4628] = "Raids",
        [4629] = "Raids",
        [4630] = "Raids",
        [4631] = "Raids",
        [4632] = "Raids",
        [4633] = "Raids",
        [4634] = "Raids",
        [4635] = "Raids",
        [4636] = "Raids",
        [4637] = "Raids",
    },
})
