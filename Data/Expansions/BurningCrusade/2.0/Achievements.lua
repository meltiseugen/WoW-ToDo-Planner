local _, TDP = ...

-- Group retroactive achievements with the content they guide.
-- The achievement system arrived later; the original release records
-- remain intact so saved favorites and old patch links keep working.
TDP.CatalogRegistry:RegisterCollection("2.0", "achievements", {
    entries = {
        ids = {
            44, -- Outland Explorer
            124, -- Outland Cook
            129, -- Outland Fisherman
            144, -- The Lurker Above
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
            690, -- Karazhan
            692, -- Gruul's Lair
            693, -- Magtheridon's Lair
            694, -- Serpentshrine Cavern
            695, -- The Battle for Mount Hyjal
            696, -- Tempest Keep
            726, -- Mr. Pinchy's Magical Crawdad Box
            733, -- Professional Outland Master
            763, -- The Burning Crusader
            764, -- The Burning Crusader
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
            882, -- Fiery Warhorse's Reins
            885, -- Ashes of Al'ar
            893, -- Cenarion War Hippogryph
            899, -- Oh My, Kurenai
            900, -- The Czar of Sporeggar
            901, -- Mag'har of Draenor
            902, -- Chief Exalted Officer
            903, -- Shattrath Divided
            939, -- Hills Like White Elekk
            953, -- Guardian of Cenarius
            959, -- The Scale of the Sands
            960, -- The Violet Eye
            1165, -- My Storage is "Gigantique"
            1189, -- To Hellfire and Back
            1190, -- Mysteries of the Marsh
            1191, -- Terror of Terokkar
            1192, -- Nagrand Slam
            1193, -- On the Blade's Edge
            1194, -- Into the Nether
            1195, -- Shadow of the Betrayer
            1205, -- Hero of Shattrath
            1225, -- Outland Angler
            1262, -- Loremaster of Outland
            1271, -- To Hellfire and Back
            1272, -- Terror of Terokkar
            1273, -- Nagrand Slam
            1284, -- Outland Dungeonmaster
            1286, -- Outland Raider
            1287, -- Outland Dungeon Hero
            1311, -- Medium Rare
            1312, -- Bloody Rare
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
        [882] = {
            name = "Fiery Warhorse's Reins",
            acquisition = "Obtain the Fiery Warhorse's Reins from Attumen the Huntsman in Karazhan.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=882",
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
        [939] = {
            name = "Hills Like White Elekk",
            acquisition = "Complete all of Hemet Nesingwary quests in Nagrand up to and including The Ultimate Bloodsport. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=939",
        },
        [953] = {
            name = "Guardian of Cenarius",
            acquisition = "Earn Exalted status with the Cenarion Circle and Cenarion Expedition. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=953",
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
        [690] = "Raids",
        [692] = "Raids",
        [693] = "Raids",
        [694] = "Raids",
        [695] = "Raids",
        [696] = "Raids",
        [726] = "Collections",
        [733] = "Professions",
        [763] = "Reputation",
        [764] = "Reputation",
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
        [882] = "Collections",
        [885] = "Collections",
        [893] = "Reputation",
        [899] = "Reputation",
        [900] = "Reputation",
        [901] = "Reputation",
        [902] = "Reputation",
        [903] = "Reputation",
        [939] = "Quests",
        [953] = "Reputation",
        [959] = "Reputation",
        [960] = "Reputation",
        [1165] = "Collections",
        [1189] = "Quests",
        [1190] = "Quests",
        [1191] = "Quests",
        [1192] = "Quests",
        [1193] = "Quests",
        [1194] = "Quests",
        [1195] = "Quests",
        [1205] = "Reputation",
        [1225] = "Professions",
        [1262] = "Quests",
        [1271] = "Quests",
        [1272] = "Quests",
        [1273] = "Quests",
        [1284] = "Dungeons",
        [1286] = "Raids",
        [1287] = "Dungeons",
        [1311] = "Exploration",
        [1312] = "Exploration",
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
