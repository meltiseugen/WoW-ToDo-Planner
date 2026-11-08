local _, TDP = ...

-- Retroactive Burning Crusade achievements are owned by their content,
-- not the 3.x patch that introduced the achievement system.
-- Name/criteria reference: https://wago.tools/db2/Achievement/csv
-- Records moved from Wrath live only here; existing detailed guides are kept.
-- Outland and blood elf/draenei starting-zone achievements belong here.
-- Retired seasons, removed quests and other unobtainable feats are excluded.
-- Neutral riding/rating milestones and cross-expansion metas live in General.
TDP.CatalogRegistry:RegisterCollection("2.0", "achievements", {
    entries = {
        ids = {
            44, -- Outland Explorer
            124, -- Outland Cook
            129, -- Outland Fisherman
            144, -- The Lurker Above
            208, -- Eye of the Storm Victory
            209, -- Eye of the Storm Veteran
            211, -- Storm Glory
            212, -- Storm Capper
            213, -- Stormtrooper
            214, -- Flurry
            216, -- Bound for Glory
            233, -- Bloodthirsty Berserker
            426, -- Warglaives of Azzinoth
            587, -- Stormy Assassin
            613, -- Killed in Quel'Thalas
            618, -- Putting Out the Light
            647, -- Hellfire Ramparts
            648, -- The Blood Furnace
            649, -- The Slave Pens
            650, -- Underbog
            651, -- Mana-Tombs
            652, -- The Escape From Durnholde
            653, -- Sethekk Halls
            654, -- Shadow Labyrinth
            655, -- Opening of the Dark Portal
            656, -- The Steamvault
            657, -- The Shattered Halls
            658, -- The Mechanar
            659, -- The Botanica
            660, -- The Arcatraz
            661, -- Magister's Terrace
            666, -- Auchenai Crypts
            667, -- Heroic: Hellfire Ramparts
            668, -- Heroic: The Blood Furnace
            669, -- Heroic: The Slave Pens
            670, -- Heroic: Underbog
            671, -- Heroic: Mana-Tombs
            672, -- Heroic: Auchenai Crypts
            673, -- Heroic: The Escape From Durnholde
            674, -- Heroic: Sethekk Halls
            675, -- Heroic: Shadow Labyrinth
            676, -- Heroic: Opening of the Dark Portal
            677, -- Heroic: The Steamvault
            678, -- Heroic: The Shattered Halls
            679, -- Heroic: The Mechanar
            680, -- Heroic: The Botanica
            681, -- Heroic: The Arcatraz
            682, -- Heroic: Magister's Terrace
            690, -- Karazhan
            692, -- Gruul's Lair
            693, -- Magtheridon's Lair
            694, -- Serpentshrine Cavern
            695, -- The Battle for Mount Hyjal
            696, -- Tempest Keep
            697, -- The Black Temple
            698, -- Sunwell Plateau
            725, -- Thori'dal, the Stars' Fury
            726, -- Mr. Pinchy's Magical Crawdad Box
            733, -- Professional Outland Master
            763, -- The Burning Crusader
            764, -- The Burning Crusader
            783, -- The Perfect Storm
            784, -- Eye of the Storm Domination
            843, -- Explore Netherstorm
            858, -- Explore Ghostlands
            859, -- Explore Eversong Woods (Burning Crusade)
            860, -- Explore Azuremyst Isle
            861, -- Explore Bloodmyst Isle
            862, -- Explore Hellfire Peninsula
            863, -- Explore Zangarmarsh
            864, -- Explore Shadowmoon Valley
            865, -- Explore Blade's Edge Mountains
            866, -- Explore Nagrand
            867, -- Explore Terokkar Forest
            868, -- Explore Isle of Quel'Danas
            877, -- The Cake Is Not A Lie
            882, -- Fiery Warhorse's Reins
            883, -- Reins of the Raven Lord
            884, -- Swift White Hawkstrider
            885, -- Ashes of Al'ar
            893, -- Cenarion War Hippogryph
            894, -- Flying High Over Skettis
            896, -- A Quest a Day Keeps the Ogres at Bay
            897, -- You're So Offensive
            898, -- On Wings of Nether
            899, -- Oh My, Kurenai
            900, -- The Czar of Sporeggar
            901, -- Mag'har of Draenor
            902, -- Chief Exalted Officer
            903, -- Shattrath Divided
            905, -- Old Man Barlowned
            906, -- Kickin' It Up a Notch
            939, -- Hills Like White Elekk
            958, -- Sworn to the Deathsworn
            959, -- The Scale of the Sands
            960, -- The Violet Eye
            1165, -- My Storage is "Gigantique"
            1171, -- Master of Eye of the Storm
            1189, -- To Hellfire and Back
            1190, -- Mysteries of the Marsh
            1191, -- Terror of Terokkar
            1192, -- Nagrand Slam
            1193, -- On the Blade's Edge
            1194, -- Into the Nether
            1195, -- Shadow of the Betrayer
            1205, -- Hero of Shattrath
            1225, -- Outland Angler
            1258, -- Take a Chill Pill
            1262, -- Loremaster of Outland
            1271, -- To Hellfire and Back
            1272, -- Terror of Terokkar
            1273, -- Nagrand Slam
            1275, -- Bombs Away
            1276, -- Blade's Edge Bomberman
            1284, -- Outland Dungeonmaster
            1286, -- Outland Raider
            1287, -- Outland Dungeon Hero
            1311, -- Medium Rare
            1312, -- Bloody Rare
            1638, -- Skyshattered
            1800, -- The Outland Gourmet
            1801, -- Captain Rumsey's Lager
            4908, -- Ghostlands Quests
            4926, -- Bloodmyst Isle Quests
            6587, -- Outland Safari
            6604, -- Taming Outland
            6614, -- Outland Tamer
            8293, -- Raiding with Leashes II: Attunement Edition
            11706, -- The Original
            11746, -- Outlandish Style
            11747, -- Merely a Set
            18721, -- Outland Master of All
            18729, -- Working in Hellfire
            18894, -- Free Stylin'
            62460, -- Family Battler of Outland
            62466, -- Aquatic Battler of Outland
            62467, -- Beast Battler of Outland
            62468, -- Critter Battler of Outland
            62469, -- Dragonkin Battler of Outland
            62470, -- Elemental Battler of Outland
            62471, -- Flying Battler of Outland
            62472, -- Humanoid Battler of Outland
            62473, -- Magic Battler of Outland
            62474, -- Mechanical Battler of Outland
            62475, -- Undead Battler of Outland
        },
        rewardHighlights = {},
    },
    details = {
        [44] = {
            name = "Outland Explorer",
            acquisition = "Explore the regions of Outland. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=44",
        },
        [124] = {
            acquisition = "1. Learn Outland Cooking from Gaston in Honor Hold or Baxter in Thrallmar, Hellfire Peninsula.\n2. Cook Outland recipes that still grant skill, learning higher recipes from trainers, vendors and quests as needed, until Outland Cooking reaches 75.\n3. Track the Outland skill bar. Later expansions' Cooking skill does not advance this achievement.",
            sourceType = "Achievement",
            name = "Outland Cook",
            sourceURL = "https://www.wowhead.com/achievement=124#comments",
            waypoints = { "/way #100 54.0 63.6 Gaston - Alliance Outland Cooking", "/way #100 56.8 37.4 Baxter - Horde Outland Cooking" },
            source = "Gaston / Baxter",
        },
        [129] = {
            acquisition = "1. Visit Juno Dufrain at Cenarion Refuge, Zangarmarsh (78.5, 63.0), and learn Outland Fishing.\n2. Fish in Outland waters until Outland Fishing reaches 75. Zangarmarsh's lakes and schools let you work on the skill and Outland Angler together.\n3. Check the Outland skill bar; Classic and Northrend Fishing have separate progression.",
            sourceType = "Achievement",
            name = "Outland Fisherman",
            sourceURL = "https://www.wowhead.com/achievement=129#comments",
            waypoints = { "/way #102 78.5 63.0 Juno Dufrain - Outland Fishing" },
            source = "Juno Dufrain",
        },
        [144] = {
            name = "The Lurker Above",
            acquisition = "Enter the original Burning Crusade version of Serpentshrine Cavern. Fish up The Lurker Below in Serpentshrine Cavern. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Serpentshrine Cavern",
            sourceURL = "https://www.wowhead.com/achievement=144",
            waypoints = { "/way #102 50.2 41 Serpentshrine Cavern entrance", "/way #102 51.9 32.9 Serpentshrine Cavern entrance" },
        },
        [208] = {
            name = "Eye of the Storm Victory",
            acquisition = "Win Eye of the Storm.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=208",
        },
        [209] = {
            name = "Eye of the Storm Veteran",
            acquisition = "Complete 100 victories in Eye of the Storm.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=209",
        },
        [211] = {
            name = "Storm Glory",
            acquisition = "While your team holds 4 of the bases in Eye of the Storm, personally grab the flag and capture it.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=211",
        },
        [212] = {
            name = "Storm Capper",
            acquisition = "Personally carry and capture the flag in Eye of the Storm.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=212",
        },
        [213] = {
            name = "Stormtrooper",
            acquisition = "Kill 5 flag carriers in a single Eye of the Storm battle.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=213",
        },
        [214] = {
            name = "Flurry",
            acquisition = "Win Eye of the Storm in under 6 minutes.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=214",
        },
        [216] = {
            name = "Bound for Glory",
            acquisition = "In a single Eye of the Storm match, capture the flag 3 times without dying.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=216",
        },
        [233] = {
            name = "Bloodthirsty Berserker",
            acquisition = "Get a killing blow while under the effects of the berserker buff in Eye of the Storm.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=233",
        },
        [426] = {
            name = "Warglaives of Azzinoth",
            acquisition = "Wielder of a set of Warglaives of Azzinoth.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=426",
        },
        [587] = {
            name = "Stormy Assassin",
            acquisition = "In a single Eye of the Storm battle, get 5 honorable kills at each of the bases.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=587",
        },
        [613] = {
            name = "Killed in Quel'Thalas",
            acquisition = "Kill Lor'themar Theron.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=613",
        },
        [618] = {
            name = "Putting Out the Light",
            acquisition = "Kill Prophet Velen.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=618",
        },
        [647] = {
            name = "Hellfire Ramparts",
            acquisition = "Enter the original Burning Crusade version of Hellfire Ramparts. Defeat Omor the Unscarred. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Hellfire Ramparts",
            sourceURL = "https://www.wowhead.com/achievement=647",
            waypoints = { "/way #100 47.65 53.57 Hellfire Ramparts entrance" },
        },
        [648] = {
            name = "The Blood Furnace",
            acquisition = "Enter the original Burning Crusade version of The Blood Furnace. Defeat Keli'dan the Breaker. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Blood Furnace",
            sourceURL = "https://www.wowhead.com/achievement=648",
            waypoints = { "/way #100 46.06 51.74 The Blood Furnace entrance" },
        },
        [649] = {
            name = "The Slave Pens",
            acquisition = "Enter the original Burning Crusade version of The Slave Pens. Defeat Quagmirran. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Slave Pens",
            sourceURL = "https://www.wowhead.com/achievement=649",
            waypoints = { "/way #102 48.95 35.84 The Slave Pens entrance" },
        },
        [650] = {
            name = "Underbog",
            acquisition = "Enter the original Burning Crusade version of The Underbog. Defeat The Black Stalker. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Underbog",
            sourceURL = "https://www.wowhead.com/achievement=650",
            waypoints = { "/way #102 54.24 34.45 The Underbog entrance" },
        },
        [651] = {
            name = "Mana-Tombs",
            acquisition = "Enter the original Burning Crusade version of Mana-Tombs. Defeat Nexus-Prince Shaffar. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Mana-Tombs",
            sourceURL = "https://www.wowhead.com/achievement=651",
            waypoints = { "/way #108 39.63 57.67 Mana-Tombs entrance" },
        },
        [652] = {
            name = "The Escape From Durnholde",
            acquisition = "Enter the original Burning Crusade version of Old Hillsbrad Foothills. Defeat Epoch Hunter. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Old Hillsbrad Foothills",
            sourceURL = "https://www.wowhead.com/achievement=652",
            waypoints = { "/way #75 26.8 36.8 Old Hillsbrad Foothills entrance" },
        },
        [653] = {
            name = "Sethekk Halls",
            acquisition = "Enter the original Burning Crusade version of Sethekk Halls. Defeat Talon King Ikiss. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Sethekk Halls",
            sourceURL = "https://www.wowhead.com/achievement=653",
            waypoints = { "/way #108 44.93 65.61 Sethekk Halls entrance" },
        },
        [654] = {
            name = "Shadow Labyrinth",
            acquisition = "Enter the original Burning Crusade version of Shadow Labyrinth. Defeat Murmur. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Shadow Labyrinth",
            sourceURL = "https://www.wowhead.com/achievement=654",
            waypoints = { "/way #108 39.63 73.55 Shadow Labyrinth entrance" },
        },
        [655] = {
            name = "Opening of the Dark Portal",
            acquisition = "Enter the original Burning Crusade version of The Black Morass. Defeat Aeonus. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Black Morass",
            sourceURL = "https://www.wowhead.com/achievement=655",
            waypoints = { "/way #75 37.2 83.3 The Black Morass entrance" },
        },
        [656] = {
            name = "The Steamvault",
            acquisition = "Enter the original Burning Crusade version of The Steamvault. Defeat Warlord Kalithresh. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Steamvault",
            sourceURL = "https://www.wowhead.com/achievement=656",
            waypoints = { "/way #102 50.35 33.39 The Steamvault entrance" },
        },
        [657] = {
            name = "The Shattered Halls",
            acquisition = "Enter the original Burning Crusade version of The Shattered Halls. Defeat Warchief Kargath Bladefist. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Shattered Halls",
            sourceURL = "https://www.wowhead.com/achievement=657",
            waypoints = { "/way #100 47.66 51.98 The Shattered Halls entrance" },
        },
        [658] = {
            name = "The Mechanar",
            acquisition = "Enter the original Burning Crusade version of The Mechanar. Defeat Pathaleon the Calculator. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Mechanar",
            sourceURL = "https://www.wowhead.com/achievement=658",
            waypoints = { "/way #109 70.61 69.75 The Mechanar entrance" },
        },
        [659] = {
            name = "The Botanica",
            acquisition = "Enter the original Burning Crusade version of The Botanica. Defeat Warp Splinter. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Botanica",
            sourceURL = "https://www.wowhead.com/achievement=659",
            waypoints = { "/way #109 71.74 54.95 The Botanica entrance" },
        },
        [660] = {
            name = "The Arcatraz",
            acquisition = "Enter the original Burning Crusade version of The Arcatraz. Defeat Harbinger Skyriss. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Arcatraz",
            sourceURL = "https://www.wowhead.com/achievement=660",
            waypoints = { "/way #109 74.42 57.72 The Arcatraz entrance" },
        },
        [661] = {
            name = "Magister's Terrace",
            acquisition = "Enter the original Burning Crusade version of Magisters' Terrace. Defeat Kael'thas Sunstrider. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Magisters' Terrace",
            sourceURL = "https://www.wowhead.com/achievement=661",
            waypoints = { "/way #122 61.23 30.94 Magisters' Terrace entrance" },
        },
        [666] = {
            name = "Auchenai Crypts",
            acquisition = "Enter the original Burning Crusade version of Auchenai Crypts. Defeat Exarch Maladaar. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Auchenai Crypts",
            sourceURL = "https://www.wowhead.com/achievement=666",
            waypoints = { "/way #108 34.34 65.61 Auchenai Crypts entrance" },
        },
        [667] = {
            name = "Heroic: Hellfire Ramparts",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Hellfire Ramparts. Defeat the leaders of Hellfire Ramparts on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Hellfire Ramparts",
            sourceURL = "https://www.wowhead.com/achievement=667",
            waypoints = { "/way #100 47.65 53.57 Hellfire Ramparts entrance" },
        },
        [668] = {
            name = "Heroic: The Blood Furnace",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Blood Furnace. Defeat Keli'dan the Breaker on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Blood Furnace",
            sourceURL = "https://www.wowhead.com/achievement=668",
            waypoints = { "/way #100 46.06 51.74 The Blood Furnace entrance" },
        },
        [669] = {
            name = "Heroic: The Slave Pens",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Slave Pens. Defeat Quagmirran on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Slave Pens",
            sourceURL = "https://www.wowhead.com/achievement=669",
            waypoints = { "/way #102 48.95 35.84 The Slave Pens entrance" },
        },
        [670] = {
            name = "Heroic: Underbog",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Underbog. Defeat The Black Stalker on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Underbog",
            sourceURL = "https://www.wowhead.com/achievement=670",
            waypoints = { "/way #102 54.24 34.45 The Underbog entrance" },
        },
        [671] = {
            name = "Heroic: Mana-Tombs",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Mana-Tombs. Defeat Nexus-Prince Shaffar on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Mana-Tombs",
            sourceURL = "https://www.wowhead.com/achievement=671",
            waypoints = { "/way #108 39.63 57.67 Mana-Tombs entrance" },
        },
        [672] = {
            name = "Heroic: Auchenai Crypts",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Auchenai Crypts. Defeat Exarch Maladaar on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Auchenai Crypts",
            sourceURL = "https://www.wowhead.com/achievement=672",
            waypoints = { "/way #108 34.34 65.61 Auchenai Crypts entrance" },
        },
        [673] = {
            name = "Heroic: The Escape From Durnholde",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Old Hillsbrad Foothills. Defeat Epoch Hunter on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Old Hillsbrad Foothills",
            sourceURL = "https://www.wowhead.com/achievement=673",
            waypoints = { "/way #75 26.8 36.8 Old Hillsbrad Foothills entrance" },
        },
        [674] = {
            name = "Heroic: Sethekk Halls",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Sethekk Halls. Defeat Talon King Ikiss on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Sethekk Halls",
            sourceURL = "https://www.wowhead.com/achievement=674",
            waypoints = { "/way #108 44.93 65.61 Sethekk Halls entrance" },
        },
        [675] = {
            name = "Heroic: Shadow Labyrinth",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Shadow Labyrinth. Defeat Murmur on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Shadow Labyrinth",
            sourceURL = "https://www.wowhead.com/achievement=675",
            waypoints = { "/way #108 39.63 73.55 Shadow Labyrinth entrance" },
        },
        [676] = {
            name = "Heroic: Opening of the Dark Portal",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Black Morass. Defeat Aeonus on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Black Morass",
            sourceURL = "https://www.wowhead.com/achievement=676",
            waypoints = { "/way #75 37.2 83.3 The Black Morass entrance" },
        },
        [677] = {
            name = "Heroic: The Steamvault",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Steamvault. Defeat Warlord Kalithresh on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Steamvault",
            sourceURL = "https://www.wowhead.com/achievement=677",
            waypoints = { "/way #102 50.35 33.39 The Steamvault entrance" },
        },
        [678] = {
            name = "Heroic: The Shattered Halls",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Shattered Halls. Defeat Warchief Kargath Bladefist on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Shattered Halls",
            sourceURL = "https://www.wowhead.com/achievement=678",
            waypoints = { "/way #100 47.66 51.98 The Shattered Halls entrance" },
        },
        [679] = {
            name = "Heroic: The Mechanar",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Mechanar. Defeat Pathaleon the Calculator on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Mechanar",
            sourceURL = "https://www.wowhead.com/achievement=679",
            waypoints = { "/way #109 70.61 69.75 The Mechanar entrance" },
        },
        [680] = {
            name = "Heroic: The Botanica",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Botanica. Defeat Warp Splinter on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Botanica",
            sourceURL = "https://www.wowhead.com/achievement=680",
            waypoints = { "/way #109 71.74 54.95 The Botanica entrance" },
        },
        [681] = {
            name = "Heroic: The Arcatraz",
            acquisition = "Set dungeon difficulty to Heroic before entering the original The Arcatraz. Defeat Harbinger Skyriss on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "The Arcatraz",
            sourceURL = "https://www.wowhead.com/achievement=681",
            waypoints = { "/way #109 74.42 57.72 The Arcatraz entrance" },
        },
        [682] = {
            name = "Heroic: Magister's Terrace",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Magisters' Terrace. Defeat Kael'thas Sunstrider on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Magisters' Terrace",
            sourceURL = "https://www.wowhead.com/achievement=682",
            waypoints = { "/way #122 61.23 30.94 Magisters' Terrace entrance" },
        },
        [690] = {
            name = "Karazhan",
            acquisition = "Enter the original Burning Crusade version of Karazhan. Defeat Prince Malchezaar in Karazhan. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Karazhan",
            sourceURL = "https://www.wowhead.com/achievement=690",
            waypoints = { "/way #42 46.87 74.69 Karazhan entrance" },
        },
        [692] = {
            name = "Gruul's Lair",
            acquisition = "Enter the original Burning Crusade version of Gruul's Lair. Defeat Gruul the Dragonkiller in Gruul's Lair. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Gruul's Lair",
            sourceURL = "https://www.wowhead.com/achievement=692",
            waypoints = { "/way #105 69.31 23.67 Gruul's Lair entrance" },
        },
        [693] = {
            name = "Magtheridon's Lair",
            acquisition = "Enter the original Burning Crusade version of Magtheridon's Lair. Defeat Magtheridon in Magtheridon's Lair. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Magtheridon's Lair",
            sourceURL = "https://www.wowhead.com/achievement=693",
            waypoints = { "/way #100 47.51 52.08 Magtheridon's Lair entrance" },
        },
        [694] = {
            name = "Serpentshrine Cavern",
            acquisition = "Enter the original Burning Crusade version of Serpentshrine Cavern. Defeat Lady Vashj in Serpentshrine Cavern. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Serpentshrine Cavern",
            sourceURL = "https://www.wowhead.com/achievement=694",
            waypoints = { "/way #102 50.2 41 Serpentshrine Cavern entrance", "/way #102 51.9 32.9 Serpentshrine Cavern entrance" },
        },
        [695] = {
            name = "The Battle for Mount Hyjal",
            acquisition = "Enter the original Burning Crusade version of Tempest Keep: The Eye. Defeat Archimonde in The Battle for Mount Hyjal. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Tempest Keep: The Eye",
            sourceURL = "https://www.wowhead.com/achievement=695",
            waypoints = { "/way #71 64.7 49.9 Tempest Keep: The Eye entrance", "/way #75 36 16.1 Tempest Keep: The Eye entrance" },
        },
        [696] = {
            name = "Tempest Keep",
            acquisition = "Enter the original Burning Crusade version of The Battle for Mount Hyjal. Defeat Kael'thas Sunstrider in Tempest Keep. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "The Battle for Mount Hyjal",
            sourceURL = "https://www.wowhead.com/achievement=696",
            waypoints = { "/way #109 73.73 63.71 The Battle for Mount Hyjal entrance" },
        },
        [697] = {
            name = "The Black Temple",
            acquisition = "Enter the original Burning Crusade version of Black Temple. Defeat Illidan Stormrage in The Black Temple. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Black Temple",
            sourceURL = "https://www.wowhead.com/achievement=697",
            waypoints = { "/way #104 71 46.5 Black Temple entrance" },
        },
        [698] = {
            name = "Sunwell Plateau",
            acquisition = "Enter the original Burning Crusade version of Sunwell Plateau. Defeat Kil'jaeden in Sunwell Plateau. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Sunwell Plateau",
            sourceURL = "https://www.wowhead.com/achievement=698",
            waypoints = { "/way #122 44.28 45.71 Sunwell Plateau entrance" },
        },
        [725] = {
            name = "Thori'dal, the Stars' Fury",
            acquisition = "Wielder of Thori'dal, the Stars' Fury.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=725",
        },
        [726] = {
            name = "Mr. Pinchy's Magical Crawdad Box",
            acquisition = "Fish your way to Mr. Pinchy's Magical Crawdad Box.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=726",
        },
        [733] = {
            name = "Professional Outland Master",
            acquisition = "Obtain 75 skill points in an \"Outland\" category of a primary profession. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=733",
        },
        [763] = {
            name = "The Burning Crusader",
            acquisition = "Raise all of The Burning Crusade dungeon reputations to Exalted. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=763",
        },
        [764] = {
            name = "The Burning Crusader",
            acquisition = "Raise all of The Burning Crusade dungeon reputations to Exalted. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=764",
        },
        [783] = {
            name = "The Perfect Storm",
            acquisition = "Win Eye of the Storm with a score of 1500 to 0.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=783",
        },
        [784] = {
            name = "Eye of the Storm Domination",
            acquisition = "Win Eye of the Storm 10 times while holding 4 bases.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=784",
        },
        [843] = {
            name = "Explore Netherstorm",
            acquisition = "Explore Netherstorm, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=843",
        },
        [858] = {
            name = "Explore Ghostlands",
            acquisition = "Explore Ghostlands, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=858",
        },
        [859] = {
            name = "Explore Eversong Woods (Burning Crusade)",
            acquisition = "Explore Eversong Woods, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=859",
        },
        [860] = {
            name = "Explore Azuremyst Isle",
            acquisition = "Explore Azuremyst Isle, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=860",
        },
        [861] = {
            name = "Explore Bloodmyst Isle",
            acquisition = "Explore Bloodmyst Isle, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=861",
        },
        [862] = {
            name = "Explore Hellfire Peninsula",
            acquisition = "Explore Hellfire Peninsula, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=862",
        },
        [863] = {
            name = "Explore Zangarmarsh",
            acquisition = "Explore Zangarmarsh, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=863",
        },
        [864] = {
            name = "Explore Shadowmoon Valley",
            acquisition = "Explore Shadowmoon Valley, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=864",
        },
        [865] = {
            name = "Explore Blade's Edge Mountains",
            acquisition = "Explore Blade's Edge Mountains, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=865",
        },
        [866] = {
            name = "Explore Nagrand",
            acquisition = "Explore Nagrand, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=866",
        },
        [867] = {
            name = "Explore Terokkar Forest",
            acquisition = "Explore Terokkar Forest, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=867",
        },
        [868] = {
            name = "Explore Isle of Quel'Danas",
            acquisition = "Explore Isle of Quel'Danas, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=868",
        },
        [877] = {
            acquisition = "1. Complete cooking daily quests for The Rokk in Shattrath (61.6, 15.8), or your faction's cook in Northrend Dalaran.\n2. Open the daily reward containers until Recipe: Delicious Chocolate Cake drops. Learn the recipe on the character doing this achievement.\n3. Gather its ingredients and personally bake the cake. Buying or eating a finished cake does not satisfy the baking objective.",
            sourceType = "Achievement",
            name = "The Cake Is Not A Lie",
            sourceURL = "https://www.wowhead.com/achievement=877#comments",
            source = "The Rokk / Katherine Lee / Awilo Lon'gomba",
            waypoints = { "/way #111 61.6 15.8 The Rokk - Shattrath cooking daily quests", "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [882] = {
            name = "Fiery Warhorse's Reins",
            acquisition = "Obtain the Fiery Warhorse's Reins from Attumen the Huntsman in Karazhan.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=882",
        },
        [883] = {
            name = "Reins of the Raven Lord",
            acquisition = "Obtain the Reins of the Raven Lord from Anzu in Sethekk Halls.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=883",
        },
        [884] = {
            name = "Swift White Hawkstrider",
            acquisition = "Obtain the Swift White Hawkstrider from Kael'thas Sunstrider in Magisters' Terrace.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=884",
        },
        [885] = {
            name = "Ashes of Al'ar",
            acquisition = "Obtain the Ashes of Al'ar from Kael'thas Sunstrider in Tempest Keep.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=885",
        },
        [893] = {
            name = "Cenarion War Hippogryph",
            acquisition = "Obtain the Cenarion War Hippogryph from the Cenarion Expedition in Zangarmarsh. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=893",
        },
        [894] = {
            name = "Flying High Over Skettis",
            acquisition = "Earn Exalted status within the Sha'tari Skyguard. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=894",
        },
        [896] = {
            name = "A Quest a Day Keeps the Ogres at Bay",
            acquisition = "Earn Exalted status within Ogri'la. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=896",
        },
        [897] = {
            name = "You're So Offensive",
            acquisition = "Earn Exalted status with the Shattered Sun Offensive. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=897",
        },
        [898] = {
            name = "On Wings of Nether",
            acquisition = "Earn Exalted status with Netherwing. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=898",
        },
        [899] = {
            name = "Oh My, Kurenai",
            acquisition = "Earn Exalted status with the Kurenai. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=899",
        },
        [900] = {
            name = "The Czar of Sporeggar",
            acquisition = "Earn Exalted status with Sporeggar. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=900",
        },
        [901] = {
            name = "Mag'har of Draenor",
            acquisition = "Earn Exalted status with The Mag'har. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=901",
        },
        [902] = {
            name = "Chief Exalted Officer",
            acquisition = "Earn Exalted status with The Consortium. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=902",
        },
        [903] = {
            name = "Shattrath Divided",
            acquisition = "Earn Exalted status with The Scryers or The Aldor. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=903",
        },
        [905] = {
            name = "Old Man Barlowned",
            acquisition = "Complete each of Old Man Barlo's 5 fishing daily quests listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=905",
        },
        [906] = {
            name = "Kickin' It Up a Notch",
            acquisition = "Complete each of The Rokk's 4 cooking daily quests listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=906",
        },
        [939] = {
            name = "Hills Like White Elekk",
            acquisition = "Complete all of Hemet Nesingwary quests in Nagrand up to and including The Ultimate Bloodsport. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=939",
        },
        [958] = {
            name = "Sworn to the Deathsworn",
            acquisition = "Earn Exalted status with the Ashtongue Deathsworn. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=958",
        },
        [959] = {
            name = "The Scale of the Sands",
            acquisition = "Earn Exalted status with The Scale of the Sands. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=959",
        },
        [960] = {
            name = "The Violet Eye",
            acquisition = "Earn Exalted status with The Violet Eye. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=960",
        },
        [1165] = {
            name = "My Storage is \"Gigantique\"",
            acquisition = "Equip Haris Pilton's \"Gigantique\" Bag.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=1165",
        },
        [1171] = {
            name = "Master of Eye of the Storm",
            acquisition = "Complete the Eye of the Storm achievements listed below.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1171",
        },
        [1189] = {
            name = "To Hellfire and Back",
            acquisition = "Complete the Hellfire Peninsula storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1189",
        },
        [1190] = {
            name = "Mysteries of the Marsh",
            acquisition = "Complete the Zangarmarsh storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1190",
        },
        [1191] = {
            name = "Terror of Terokkar",
            acquisition = "Complete the Terokkar Forest storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1191",
        },
        [1192] = {
            name = "Nagrand Slam",
            acquisition = "Complete the Nagrand storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1192",
        },
        [1193] = {
            name = "On the Blade's Edge",
            acquisition = "Complete the Blade's Edge Mountains storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1193",
        },
        [1194] = {
            name = "Into the Nether",
            acquisition = "Complete the Netherstorm storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1194",
        },
        [1195] = {
            name = "Shadow of the Betrayer",
            acquisition = "Complete the Shadowmoon Valley storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1195",
        },
        [1205] = {
            name = "Hero of Shattrath",
            acquisition = "Gained exalted status with The Scryers and The Aldor. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=1205",
        },
        [1225] = {
            name = "Outland Angler",
            acquisition = "Catch a fish in each of the specific nodes listed below. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=1225",
        },
        [1258] = {
            name = "Take a Chill Pill",
            acquisition = "In Eye of the Storm, kill a player who is under the effects of the Berserker power-up.",
            source = "Burning Crusade pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1258",
        },
        [1262] = {
            name = "Loremaster of Outland",
            acquisition = "Complete the Outland quest achievements listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1262",
        },
        [1271] = {
            name = "To Hellfire and Back",
            acquisition = "Complete the Hellfire Peninsula storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1271",
        },
        [1272] = {
            name = "Terror of Terokkar",
            acquisition = "Complete the Terokkar Forest storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1272",
        },
        [1273] = {
            name = "Nagrand Slam",
            acquisition = "Complete the Nagrand storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1273",
        },
        [1275] = {
            name = "Bombs Away",
            acquisition = "Complete the Fires Over Skettis quest in under 2 minutes 15 seconds while not in a group. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1275",
        },
        [1276] = {
            name = "Blade's Edge Bomberman",
            acquisition = "Complete the Bomb Them Again! quest in under 2 minutes 15 seconds while not in a group. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1276",
        },
        [1284] = {
            name = "Outland Dungeonmaster",
            acquisition = "Defeat the final encounter in each of the 16 original Burning Crusade five-player dungeons, including Magisters' Terrace. Normal or Heroic clears credit this meta. Track its child achievements to identify the remaining dungeons.",
            sourceType = "Achievement",
            source = "Burning Crusade dungeons",
            sourceURL = "https://www.wowhead.com/achievement=1284",
            waypoints = { "/way #108 34.34 65.61 Auchenai Crypts entrance", "/way #100 47.65 53.57 Hellfire Ramparts entrance", "/way #122 61.23 30.94 Magisters' Terrace entrance", "/way #108 39.63 57.67 Mana-Tombs entrance", "/way #75 26.8 36.8 Old Hillsbrad Foothills entrance", "/way #108 44.93 65.61 Sethekk Halls entrance", "/way #108 39.63 73.55 Shadow Labyrinth entrance", "/way #109 74.42 57.72 The Arcatraz entrance", "/way #75 37.2 83.3 The Black Morass entrance", "/way #100 46.06 51.74 The Blood Furnace entrance", "/way #109 71.74 54.95 The Botanica entrance", "/way #109 70.61 69.75 The Mechanar entrance", "/way #100 47.66 51.98 The Shattered Halls entrance", "/way #102 48.95 35.84 The Slave Pens entrance", "/way #102 50.35 33.39 The Steamvault entrance", "/way #102 54.24 34.45 The Underbog entrance" },
        },
        [1286] = {
            name = "Outland Raider",
            acquisition = "Clear the eight original Burning Crusade raids: Karazhan, Gruul's Lair, Magtheridon's Lair, Serpentshrine Cavern, Tempest Keep, the Battle for Mount Hyjal, Black Temple and Sunwell Plateau. The original Zul'Aman raid is no longer required.",
            sourceType = "Achievement",
            source = "Burning Crusade raids",
            sourceURL = "https://www.wowhead.com/achievement=1286",
            waypoints = { "/way #42 46.87 74.69 Karazhan entrance", "/way #105 69.31 23.67 Gruul's Lair entrance", "/way #100 47.51 52.08 Magtheridon's Lair entrance", "/way #102 50.2 41 Serpentshrine Cavern entrance", "/way #102 51.9 32.9 Serpentshrine Cavern entrance", "/way #109 73.73 63.71 The Battle for Mount Hyjal entrance", "/way #71 64.7 49.9 Tempest Keep: The Eye entrance", "/way #75 36 16.1 Tempest Keep: The Eye entrance", "/way #104 71 46.5 Black Temple entrance", "/way #122 44.28 45.71 Sunwell Plateau entrance" },
        },
        [1287] = {
            name = "Outland Dungeon Hero",
            acquisition = "Defeat the final encounter in each of the 16 original Burning Crusade five-player dungeons, including Magisters' Terrace. Set every dungeon to Heroic before entering; Normal clears do not count for this meta.",
            sourceType = "Achievement",
            source = "Burning Crusade dungeons",
            sourceURL = "https://www.wowhead.com/achievement=1287",
            waypoints = { "/way #108 34.34 65.61 Auchenai Crypts entrance", "/way #100 47.65 53.57 Hellfire Ramparts entrance", "/way #122 61.23 30.94 Magisters' Terrace entrance", "/way #108 39.63 57.67 Mana-Tombs entrance", "/way #75 26.8 36.8 Old Hillsbrad Foothills entrance", "/way #108 44.93 65.61 Sethekk Halls entrance", "/way #108 39.63 73.55 Shadow Labyrinth entrance", "/way #109 74.42 57.72 The Arcatraz entrance", "/way #75 37.2 83.3 The Black Morass entrance", "/way #100 46.06 51.74 The Blood Furnace entrance", "/way #109 71.74 54.95 The Botanica entrance", "/way #109 70.61 69.75 The Mechanar entrance", "/way #100 47.66 51.98 The Shattered Halls entrance", "/way #102 48.95 35.84 The Slave Pens entrance", "/way #102 50.35 33.39 The Steamvault entrance", "/way #102 54.24 34.45 The Underbog entrance" },
        },
        [1311] = {
            name = "Medium Rare",
            acquisition = "Kill one of the extremely rare and hard to find Outland creatures listed below. Travel between the Outland rare-creature spawn areas and kill the required rares. Spawns are shared and may be absent; return on another pass and track the remaining named criteria.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=1311",
        },
        [1312] = {
            name = "Bloody Rare",
            acquisition = "Kill all of the extremely rare and hard to find Outland creatures listed below. Travel between the Outland rare-creature spawn areas and kill the required rares. Spawns are shared and may be absent; return on another pass and track the remaining named criteria.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=1312",
        },
        [1638] = {
            name = "Skyshattered",
            acquisition = "Defeat Captain Skyshatter in the Dragonmaw race on Netherwing Ledge. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1638",
        },
        [1800] = {
            name = "The Outland Gourmet",
            acquisition = "Cook each of the Outland cooking recipes listed below. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=1800",
        },
        [1801] = {
            acquisition = "1. Do Marcia Chase's fishing daily in Northrend Dalaran and open the Bag of Fishing Treasures for a chance at Recipe: Captain Rumsey's Lager. Outland and Northrend cooking daily containers are another source.\n2. Learn the recipe, then buy a Skin of Dwarven Stout and a Flagon of Dwarven Mead from an innkeeper or drink vendor.\n3. Brew Captain Rumsey's Lager yourself. Purchasing a finished drink does not complete the brewing objective.",
            sourceType = "Achievement",
            name = "Captain Rumsey's Lager",
            sourceURL = "https://www.wowhead.com/achievement=1801#comments",
            source = "Marcia Chase / The Rokk / Katherine Lee / Awilo Lon'gomba",
            waypoints = { "/way #125 52.6 65.6 Marcia Chase - Northrend Fishing and daily quests", "/way #111 61.6 15.8 The Rokk - Shattrath cooking daily quests", "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [4908] = {
            name = "Ghostlands Quests",
            acquisition = "Complete the Ghostlands storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=4908",
        },
        [4926] = {
            name = "Bloodmyst Isle Quests",
            acquisition = "Complete the Bloodmyst Isle storylines listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=4926",
        },
        [6587] = {
            name = "Outland Safari",
            acquisition = "Catch every battle pet in Outland. Find each listed species in its Outland habitat, weaken it in a wild pet battle and capture it with a trap. Defeating a wild pet without capturing it does not add that species to your collection.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=6587",
        },
        [6604] = {
            name = "Taming Outland",
            acquisition = "Defeat all of the Pet Tamers in Outland listed below. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=6604",
        },
        [6614] = {
            name = "Outland Tamer",
            acquisition = "Capture a battle pet in each of the Outland zones listed below. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=6614",
        },
        [8293] = {
            name = "Raiding with Leashes II: Attunement Edition",
            acquisition = "Collect all of the battle pets listed below from Karazhan, Serpentshrine Cavern, and Tempest Keep.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=8293",
        },
        [11706] = {
            name = "The Original",
            acquisition = "Collect 12 Marks of Honor and visit Kezzik the Striker inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Kezzik the Striker / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11706",
            waypoints = { "/way #109 33.0 64.2 Kezzik the Striker - Gladiator armor ensemble" },
        },
        [11746] = {
            name = "Outlandish Style",
            acquisition = "Collect any class armor set from Gruul's Lair, Karazhan, and Magtheridon's Lair. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Karazhan / Gruul's Lair / Magtheridon's Lair",
            sourceURL = "https://www.wowhead.com/achievement=11746",
            waypoints = { "/way #42 46.87 74.69 Karazhan entrance", "/way #105 69.31 23.67 Gruul's Lair entrance", "/way #100 47.51 52.08 Magtheridon's Lair entrance" },
        },
        [11747] = {
            name = "Merely a Set",
            acquisition = "Collect any class armor set from Serpentshrine Cavern and The Eye. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Serpentshrine Cavern / Tempest Keep: The Eye",
            sourceURL = "https://www.wowhead.com/achievement=11747",
            waypoints = { "/way #102 50.2 41 Serpentshrine Cavern entrance", "/way #102 51.9 32.9 Serpentshrine Cavern entrance", "/way #71 64.7 49.9 Tempest Keep: The Eye entrance", "/way #75 36 16.1 Tempest Keep: The Eye entrance" },
        },
        [18721] = {
            name = "Outland Master of All",
            acquisition = "Raise all primary professions to 75 skill points in the \"Outland\" category. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=18721",
        },
        [18729] = {
            name = "Working in Hellfire",
            acquisition = "Obtain 75 skill points in an \"Outland\" category of two primary professions. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=18729",
        },
        [18894] = {
            name = "Free Stylin'",
            acquisition = "Start a fashion trend by crafting each of the following stylin' hats listed below. Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement.",
            sourceType = "Achievement",
            source = "Burning Crusade professions",
            sourceURL = "https://www.wowhead.com/achievement=18894",
        },
        [62460] = {
            name = "Family Battler of Outland",
            acquisition = "Complete the following achievements. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62460",
        },
        [62466] = {
            name = "Aquatic Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Aquatic pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62466",
        },
        [62467] = {
            name = "Beast Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Beast pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62467",
        },
        [62468] = {
            name = "Critter Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Beast pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62468",
        },
        [62469] = {
            name = "Dragonkin Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Dragonkin pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62469",
        },
        [62470] = {
            name = "Elemental Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Elemental pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62470",
        },
        [62471] = {
            name = "Flying Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Flying pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62471",
        },
        [62472] = {
            name = "Humanoid Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Humanoid pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62472",
        },
        [62473] = {
            name = "Magic Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Magic pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62473",
        },
        [62474] = {
            name = "Mechanical Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Mechanical pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62474",
        },
        [62475] = {
            name = "Undead Battler of Outland",
            acquisition = "Defeat the trainers of Outland with a team of all level 25 Undead pets. Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements.",
            sourceType = "Achievement",
            source = "Burning Crusade pet battles",
            sourceURL = "https://www.wowhead.com/achievement=62475",
        },
    },
    categories = {
        [44] = "Exploration",
        [124] = "Professions",
        [129] = "Professions",
        [144] = "Raids",
        [208] = "PvP",
        [209] = "PvP",
        [211] = "PvP",
        [212] = "PvP",
        [213] = "PvP",
        [214] = "PvP",
        [216] = "PvP",
        [233] = "PvP",
        [426] = "Collections",
        [587] = "PvP",
        [613] = "PvP",
        [618] = "PvP",
        [647] = "Dungeons",
        [648] = "Dungeons",
        [649] = "Dungeons",
        [650] = "Dungeons",
        [651] = "Dungeons",
        [652] = "Dungeons",
        [653] = "Dungeons",
        [654] = "Dungeons",
        [655] = "Dungeons",
        [656] = "Dungeons",
        [657] = "Dungeons",
        [658] = "Dungeons",
        [659] = "Dungeons",
        [660] = "Dungeons",
        [661] = "Dungeons",
        [666] = "Dungeons",
        [667] = "Dungeons",
        [668] = "Dungeons",
        [669] = "Dungeons",
        [670] = "Dungeons",
        [671] = "Dungeons",
        [672] = "Dungeons",
        [673] = "Dungeons",
        [674] = "Dungeons",
        [675] = "Dungeons",
        [676] = "Dungeons",
        [677] = "Dungeons",
        [678] = "Dungeons",
        [679] = "Dungeons",
        [680] = "Dungeons",
        [681] = "Dungeons",
        [682] = "Dungeons",
        [690] = "Raids",
        [692] = "Raids",
        [693] = "Raids",
        [694] = "Raids",
        [695] = "Raids",
        [696] = "Raids",
        [697] = "Raids",
        [698] = "Raids",
        [725] = "Collections",
        [726] = "Collections",
        [733] = "Professions",
        [763] = "Reputation",
        [764] = "Reputation",
        [783] = "PvP",
        [784] = "PvP",
        [843] = "Exploration",
        [858] = "Exploration",
        [859] = "Exploration",
        [860] = "Exploration",
        [861] = "Exploration",
        [862] = "Exploration",
        [863] = "Exploration",
        [864] = "Exploration",
        [865] = "Exploration",
        [866] = "Exploration",
        [867] = "Exploration",
        [868] = "Exploration",
        [877] = "Professions",
        [882] = "Collections",
        [883] = "Collections",
        [884] = "Collections",
        [885] = "Collections",
        [893] = "Reputation",
        [894] = "Reputation",
        [896] = "Reputation",
        [897] = "Reputation",
        [898] = "Reputation",
        [899] = "Reputation",
        [900] = "Reputation",
        [901] = "Reputation",
        [902] = "Reputation",
        [903] = "Reputation",
        [905] = "Quests",
        [906] = "Quests",
        [939] = "Quests",
        [958] = "Reputation",
        [959] = "Reputation",
        [960] = "Reputation",
        [1165] = "Collections",
        [1171] = "PvP",
        [1189] = "Quests",
        [1190] = "Quests",
        [1191] = "Quests",
        [1192] = "Quests",
        [1193] = "Quests",
        [1194] = "Quests",
        [1195] = "Quests",
        [1205] = "Reputation",
        [1225] = "Professions",
        [1258] = "PvP",
        [1262] = "Quests",
        [1271] = "Quests",
        [1272] = "Quests",
        [1273] = "Quests",
        [1275] = "Quests",
        [1276] = "Quests",
        [1284] = "Dungeons",
        [1286] = "Raids",
        [1287] = "Dungeons",
        [1311] = "Exploration",
        [1312] = "Exploration",
        [1638] = "Quests",
        [1800] = "Professions",
        [1801] = "Professions",
        [4908] = "Quests",
        [4926] = "Quests",
        [6587] = "Pet Battles",
        [6604] = "Pet Battles",
        [6614] = "Pet Battles",
        [8293] = "Collections",
        [11706] = "Collections",
        [11746] = "Collections",
        [11747] = "Collections",
        [18721] = "Professions",
        [18729] = "Professions",
        [18894] = "Professions",
        [62460] = "Pet Battles",
        [62466] = "Pet Battles",
        [62467] = "Pet Battles",
        [62468] = "Pet Battles",
        [62469] = "Pet Battles",
        [62470] = "Pet Battles",
        [62471] = "Pet Battles",
        [62472] = "Pet Battles",
        [62473] = "Pet Battles",
        [62474] = "Pet Battles",
        [62475] = "Pet Battles",
    },
})
