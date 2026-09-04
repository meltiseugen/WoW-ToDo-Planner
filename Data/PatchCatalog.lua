local _, TDP = ...

local PatchCatalog = {}

local COILED_ISLE_RARE_WAYPOINTS = {
    "/way #2512 54.02 72.34 Farthik the Plunderer",
    "/way #2512 25.01 73.73 Kari'zah the Forgotten",
    "/way #2512 43.82 50.82 Hisstara",
    "/way #2512 69.62 44.85 Garsecg",
    "/way #2512 58.34 65.23 Coin-Eye Skully",
    "/way #2512 57.25 40.39 Sss'alik",
    "/way #2512 50.43 69.39 Siltmouth",
    "/way #2512 31.82 56.62 Lockjaw",
    "/way #2512 52.57 42.80 Nar'zira / Tomb entrance",
    "/way #2512 70.05 63.40 Big Mon",
    "/way #2512 52.41 32.79 Destra",
    "/way #2613 38.64 16.92 Szarith the Fanged",
    "/way #2642 63.5 62.4 Nar'zira / inside Tomb",
}

local RALKALA_WAYPOINTS = {
    "/way #2512 58.21 48.72 Image of Astalor Bloodsworn / Curse of the Isle",
    "/way #2512 52.9 42.2 Ral'kala brazier area",
    "/way #2512 29.4 65.0 Ral'kala brazier area",
    "/way #2512 68.4 45.0 Ral'kala brazier area",
}

local UNFORTUNATE_SCOUT_SATCHEL_WAYPOINTS = {
    "/way #2512 21.4 64.3 Unfortunate Scout's Satchel",
    "/way #2512 26.4 54.8 Unfortunate Scout's Satchel",
    "/way #2512 27.4 59.9 Unfortunate Scout's Satchel",
    "/way #2512 33.4 84.2 Unfortunate Scout's Satchel",
    "/way #2512 36.5 45.2 Unfortunate Scout's Satchel",
    "/way #2512 40.0 45.7 Unfortunate Scout's Satchel",
    "/way #2512 42.5 24.6 Unfortunate Scout's Satchel",
    "/way #2512 44.7 25.5 Unfortunate Scout's Satchel",
    "/way #2512 45.6 50.0 Unfortunate Scout's Satchel",
    "/way #2512 46.0 46.2 Unfortunate Scout's Satchel",
    "/way #2512 46.3 61.8 Unfortunate Scout's Satchel",
    "/way #2512 49.2 38.3 Unfortunate Scout's Satchel",
    "/way #2512 49.4 69.3 Unfortunate Scout's Satchel",
    "/way #2512 50.0 56.0 Unfortunate Scout's Satchel",
    "/way #2512 52.2 31.8 Unfortunate Scout's Satchel",
    "/way #2512 54.8 42.1 Unfortunate Scout's Satchel",
    "/way #2512 57.9 33.7 Unfortunate Scout's Satchel",
    "/way #2512 57.9 79.7 Unfortunate Scout's Satchel",
    "/way #2512 58.4 83.6 Unfortunate Scout's Satchel",
    "/way #2512 59.4 37.4 Unfortunate Scout's Satchel",
    "/way #2512 60.1 38.1 Unfortunate Scout's Satchel",
    "/way #2512 61.9 31.9 Unfortunate Scout's Satchel",
    "/way #2512 62.6 38.2 Unfortunate Scout's Satchel",
    "/way #2512 62.9 82.4 Unfortunate Scout's Satchel",
    "/way #2512 63.1 32.5 Unfortunate Scout's Satchel",
    "/way #2512 64.1 40.7 Unfortunate Scout's Satchel",
    "/way #2512 64.4 48.5 Unfortunate Scout's Satchel",
    "/way #2512 64.7 64.6 Unfortunate Scout's Satchel",
    "/way #2512 64.8 43.6 Unfortunate Scout's Satchel",
    "/way #2512 65.5 62.7 Unfortunate Scout's Satchel",
    "/way #2512 65.7 75.8 Unfortunate Scout's Satchel",
    "/way #2512 66.0 55.9 Unfortunate Scout's Satchel",
    "/way #2512 66.3 68.4 Unfortunate Scout's Satchel",
    "/way #2512 66.4 29.4 Unfortunate Scout's Satchel",
    "/way #2512 66.9 35.2 Unfortunate Scout's Satchel",
    "/way #2512 68.5 81.9 Unfortunate Scout's Satchel",
    "/way #2512 69.7 57.4 Unfortunate Scout's Satchel",
    "/way #2512 70.1 77.2 Unfortunate Scout's Satchel",
}

local KIFAAN_WAYPOINTS = {
    "/way #2600 47.80 81.60 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.0 Kifaan / Val Umbral Base Camp",
}

local CONSTRUCT_VANORE_WAYPOINTS = {
    "/way #2393 55.8 65.8 Construct V'anore / Preyhunter vendor",
}

local JANSARI_WAYPOINTS = {
    "/way #2512 58.8 46.0 Jan'sari the Watchful",
}

local SECOND_MATE_SLUGGS_WAYPOINTS = {
    "/way #2512 51.6 49.8 Second Mate Sluggs / Captain Tokka",
}

local SKULL_OF_ERINYE_WAYPOINTS = {
    "/way #2509 51.2 62.4 Skull of Er'inye",
    "/way #2509 47.2 61.1 Warleader Abdumati / Skull unlock quest",
}

local LINDORMI_WAYPOINTS = {
    "/way #2393 42.2 58.8 Lindormi / Timelost Saddle vendor",
}

local TELEMANCER_ASTRANDIS_WAYPOINTS = {
    "/way #2393 52.6 78.8 Telemancer Astrandis",
}

local TRADING_POST_WAYPOINTS = {
    "/way #2393 48.77 78.02 Trading Post / Silvermoon City",
    "/way #2339 44.0 56.0 Trading Post / Dornogal",
    "/way #84 49.5 69.5 T&W Trading Post / Stormwind",
    "/way #85 43.1 42.2 Zen'shiri Trading Post / Orgrimmar",
}

local THE_VENOMOUS_ABYSS_WAYPOINTS = {
    "/way #2509 47.2 21.7 The Venomous Abyss Raid Entrance",
    "/way #2512 43.3 44.2 Gate of the Serpent Eye Entrance",
    "/way #2512 45.4 65.9 Gate of the Eastern Fang Entrance",
    "/way #2512 31.8 64.9 Gate of the Western Fang Entrance",
}

local ALTAR_OF_FANGS_WAYPOINTS = {
    "/way #2509 47.2 67.6 Altar of Fangs Entrance",
    "/way #2512 43.3 44.2 Gate of the Serpent Eye Entrance",
    "/way #2512 45.4 65.9 Gate of the Eastern Fang Entrance",
    "/way #2512 31.8 64.9 Gate of the Western Fang Entrance",
}

local SPOREFALL_WAYPOINTS = {
    "/way #2413 73.7 66.5 Sporefall Raid Entrance",
}

local AHUNE_WAYPOINTS = {
    "/way #102 49.0 36.0 Coilfang Reservoir / Slave Pens entrance",
}

local VENOMFALL_DEEPS_WAYPOINTS = {
    "/way #2393 52.6 78.8 Delver's Headquarters / seasonal quest",
    "/way #2512 51.2 31.0 Venomfall Deeps / Azta'rec",
}

local CURSE_SURGE_WAYPOINTS = {
    "/way #2512 26.62 64.90 The Looming Mutagenitor",
    "/way #2512 45.35 28.62 The Broodmother's Nest",
    "/way #2512 47.20 62.05 The Malformed Leviathan",
    "/way #2512 70.98 31.91 Mlurkkr Massacre",
    "/way #2512 67.47 77.89 Siege at the Whispering Marsh",
}

PatchCatalog.patches = {
    ["12.0"] = {
        label = "Patch 12.0: Midnight Launch",
        wowheadPatchId = 120000,
        sourceNotes = {
            "Wowhead Added in Patch filters for base Midnight launch mounts and battle pets.",
            "Wowhead Midnight mount and pet guides for curated source notes.",
            "Wowhead Midnight transformation toy roundup and item comments for launch toy notes.",
            "Base achievement IDs use the reliable 12.0.1 launch filter slice to avoid unrelated embedded page data.",
        },
        sourceUrls = {
            mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120000",
            mountGuide = "https://www.wowhead.com/guide/collections/midnight-mounts-locations-appearances",
            mountCrossCheck = "https://www.icy-veins.com/wow/midnight-mounts-patch120",
            pets = "https://www.wowhead.com/battle-pets?filter=3;3;120000",
            toys = "https://www.wowhead.com/news/midnight-transformation-toys-roundup-potatoads-pangos-and-saptors-381211",
            achievements = "https://www.wowhead.com/achievements?filter=17;3;120001",
        },
        mounts = {
            { spellId = 1242904, itemId = 246590, name = "Ashes of Belo'ren" },
            { spellId = 1243003, itemId = 246594, name = "Light-Forged Mechsuit" },
            { spellId = 1243593, itemId = 246734, name = "Fierce Grimlynx" },
            { spellId = 1243597, itemId = 246735, name = "Rootstalker Grimlynx" },
            { spellId = 1251433, itemId = 250782, name = "Amani Sunfeather" },
            { spellId = 1251630, itemId = 250889, name = "Amani Windcaller" },
            { spellId = 1253927, itemId = 252012, name = "Vibrant Petalwing" },
            { spellId = 1253929, itemId = 252014, name = "Cerulean Sporeglider" },
            { spellId = 1253938, itemId = 252017, name = "Ruddy Sporeglider" },
            { spellId = 1257058, itemId = 262620, name = "Calamitous Carrion" },
            { spellId = 1257081, itemId = 262621, name = "Convalescent Carrion" },
            { spellId = 1260354, itemId = 256423, name = "Untainted Grove Crawler" },
            { spellId = 1260356, itemId = 256424, name = "Echo of Aln'sharan" },
            { spellId = 1261155, itemId = 257085, name = "Augmented Stormray" },
            { spellId = 1261291, itemId = 257142, name = "Fiery Dragonhawk" },
            { spellId = 1261293, itemId = 257143, name = "Peridot Dragonhawk" },
            { spellId = 1261302, itemId = 257147, name = "Cobalt Dragonhawk" },
            { spellId = 1261316, itemId = 257152, name = "Amani Sharptalon" },
            { spellId = 1261322, itemId = 257154, name = "Crimson Silvermoon Hawkstrider" },
            { spellId = 1261323, itemId = 257156, name = "Cerulean Hawkstrider" },
            { spellId = 1261332, itemId = 257176, name = "Duskbrute Harrower" },
            { spellId = 1261336, itemId = 257191, name = "Preyseeker's Hubris" },
            { spellId = 1261337, itemId = 257192, name = "Preyseeker's Wrath" },
            { spellId = 1261338, itemId = 257193, name = "Preyseeker's Nightmare" },
            { spellId = 1261348, itemId = 257197, name = "Blessed Amani Burrower" },
            { spellId = 1261351, itemId = 257200, name = "Witherbark Pango" },
            { spellId = 1261357, itemId = 257219, name = "Amani Blessed Bear" },
            { spellId = 1261360, itemId = 257223, name = "Ancestral War Bear" },
            { spellId = 1261391, itemId = 257240, name = "Relinquished Scarlet Charger" },
            { spellId = 1261576, itemId = 257444, name = "Hexed Vilefeather Eagle" },
            { spellId = 1261584, itemId = 257447, name = "Prowling Shredclaw" },
            { spellId = 1261585, itemId = 257448, name = "Frenzied Shredclaw" },
            { spellId = 1261629, itemId = 257502, name = "Vicious Snaplizard" },
            { spellId = 1261648, itemId = 257504, name = "Vicious Snaplizard" },
            { spellId = 1262840, itemId = 260228, name = "Galactic Gladiator's Goredrake" },
            { spellId = 1265784, itemId = 260231, name = "Lucent Hawkstrider" },
            { spellId = 1266700, itemId = 260635, name = "Sanguine Harrower" },
            { spellId = 1266980, itemId = 260887, name = "Tenebrous Harrower" },
            { spellId = 1268919, itemId = 262496, name = "Delver's Arcane Golem" },
            { spellId = 1268924, itemId = 262500, name = "Silvermoon's Arcane Defender" },
            { spellId = 1268926, itemId = 262502, name = "Elven Arcane Guardian" },
            { spellId = 1268949, itemId = 263222, name = "Arcanovoid Construct" },
            { spellId = 1270675, itemId = 263580, name = "Vivid Chloroceros" },
            { spellId = 1276650, itemId = 265656, name = "Anu'shalla, Shadow's Guidance" },
        },
        pets = {
            { speciesId = 4891, npcId = 250573, name = "Wrathful Wyrm" },
            { speciesId = 4892, npcId = 250680, name = "Riftblade Familiar" },
            { speciesId = 4876, npcId = 249816, name = "Mud Potadpole" },
            { speciesId = 4884, npcId = 249825, name = "Pangolil" },
            { speciesId = 4912, npcId = 254885, name = "Silvermoon Broom" },
            { speciesId = 4965, npcId = 256565, name = "Sleepy Mandrake" },
            { speciesId = 4889, npcId = 250571, name = "Nether Familiar" },
            { speciesId = 4944, npcId = 255750, name = "Gummi the Glow Wyrm" },
            { speciesId = 4887, npcId = 249488, name = "Dundun" },
            { speciesId = 4874, npcId = 249812, name = "Akil Fledgling" },
            { speciesId = 4878, npcId = 249818, name = "Ebon Snapling" },
            { speciesId = 4967, npcId = 256567, name = "Gortham" },
            { speciesId = 4956, npcId = 256237, name = "Spormilian" },
            { speciesId = 4958, npcId = 256265, name = "Ominous Domanus" },
            { speciesId = 4862, npcId = 248495, name = "Smoldering Valor" },
            { speciesId = 4951, npcId = 256201, name = "Bubbly Snapling" },
            { speciesId = 4875, npcId = 249815, name = "Rootling Nester" },
            { speciesId = 4953, npcId = 256264, name = "Sporbie" },
            { speciesId = 4976, npcId = 257546, name = "Voldy" },
            { speciesId = 4790, npcId = 240014, name = "Devouring Runt" },
            { speciesId = 4890, npcId = 250572, name = "Vibrant Manaling" },
            { speciesId = 4959, npcId = 256278, name = "Hexed Bunny" },
            { speciesId = 4880, npcId = 249820, name = "Swamp Biter" },
            { speciesId = 4974, npcId = 246696, name = "Dali" },
            { speciesId = 4879, npcId = 249819, name = "Blistercreepling" },
            { speciesId = 4795, npcId = 241439, name = "Voidcrawler" },
            { speciesId = 4966, npcId = 256566, name = "Screechy Mandrake" },
            { speciesId = 4985, npcId = 258281, name = "Princess Bloodshed" },
            { speciesId = 4883, npcId = 249824, name = "Dragonhawk Mosswing" },
            { speciesId = 4882, npcId = 249822, name = "Azure Sporebat" },
            { speciesId = 4971, npcId = 256759, name = "Luma" },
            { speciesId = 3277, npcId = 241500, name = "Amber Treeflitter" },
            { speciesId = 4963, npcId = 256559, name = "Grumpy Mandrake" },
            { speciesId = 4929, npcId = 255295, name = "Munchy" },
            { speciesId = 4886, npcId = 249827, name = "Silkcrawler" },
            { speciesId = 4885, npcId = 249826, name = "Gloom Toad" },
            { speciesId = 4972, npcId = 256985, name = "Willie" },
            { speciesId = 4981, npcId = 257695, name = "Nova" },
            { speciesId = 5003, npcId = 259728, name = "Sunwing Hatchling" },
            { speciesId = 4803, npcId = 242452, name = "Niblet" },
            { speciesId = 4888, npcId = 250583, name = "Naloki" },
            { speciesId = 4877, npcId = 249817, name = "Violet Chick" },
            { speciesId = 4927, npcId = 255119, name = "Percival" },
            { speciesId = 4968, npcId = 256663, name = "Lil' Staropod" },
            { speciesId = 4957, npcId = 256282, name = "Lost Star" },
            { speciesId = 4906, npcId = 253399, name = "Scruffbeak" },
            { speciesId = 4954, npcId = 256276, name = "Ziorg'pharon" },
            { speciesId = 4982, npcId = 257857, name = "Flicker" },
            { speciesId = 4952, npcId = 256271, name = "Blitzcreek" },
            { speciesId = 4928, npcId = 255257, name = "Dragonhawk Munchkin" },
            { speciesId = 4948, npcId = 256059, name = "Perturbed Sporebat" },
            { speciesId = 4984, npcId = 257802, name = "Medusa" },
            { speciesId = 4816, npcId = 245043, name = "Hawkstrider Hatchling" },
            { speciesId = 4930, npcId = 255522, name = "Lil' Preyseeker" },
            { speciesId = 4983, npcId = 257908, name = "Kai" },
            { speciesId = 4945, npcId = 255832, name = "Aud'rei III" },
            { speciesId = 4955, npcId = 256272, name = "Kreepah'zoyd" },
            { speciesId = 4950, npcId = 256107, name = "Fidoficus" },
            { speciesId = 4946, npcId = 255921, name = "Linda the Lucky" },
            { speciesId = 4977, npcId = 257616, name = "Emberwing Hatchling" },
            { speciesId = 4910, npcId = 254689, name = "Do, Child of Filo" },
            { speciesId = 4975, npcId = 257493, name = "Razeshi C." },
            { speciesId = 4960, npcId = 256238, name = "Treja'saka" },
            { speciesId = 4942, npcId = 255689, name = "Distorted Memory" },
            { speciesId = 4881, npcId = 258803, name = "Nether Siphoner" },
            { speciesId = 4947, npcId = 256014, name = "Assistant Botanist Leafy" },
            { speciesId = 4909, npcId = 254647, name = "Emerald Hatchling" },
            { speciesId = 4902, npcId = 252686, name = "Auspicious Pixiu" },
            { speciesId = 4961, npcId = 256269, name = "Nibblesworth" },
            { speciesId = 4943, npcId = 255736, name = "Star the Lucky Dragon" },
            { speciesId = 4913, npcId = 254979, name = "Moon Darter" },
            { speciesId = 4964, npcId = 256560, name = "Plump Mandrake" },
            { speciesId = 4914, npcId = 254986, name = "Chillcrawler" },
        },
        toys = {
            { itemId = 252265, name = "Hexed Potatoad Mucus", source = "Atal'Aman delve Sturdy Chest", acquisition = "Loot one-time Sturdy Chests inside the Atal'Aman delve; comments point to a chest near the Restoration Stone in the Toadly Unbecoming variant." },
            { itemId = 251903, name = "Potatoad Egg", source = "The Blinding Vale dungeon secret", acquisition = "Get Hexed Potatoad Mucus first, enter The Blinding Vale, reach the lower river path before Ziekket, use the mucus to transform, then interact with Gravid Potatoad." },
            { itemId = 268717, name = "Pango Plating", source = "Treasures of Zul'Aman achievement", acquisition = "Complete Treasures of Zul'Aman. Wowhead comments note Abandoned Ritual Skull was removed from the requirement after March 5." },
            { itemId = 256552, name = "Verdant Rutaani Seed", source = "Hara'ti Renown vendor", acquisition = "Reach Renown 13 with the Hara'ti, then buy it from Naynar in Harandar." },
            { itemId = 268728, name = "Saptor Salve", source = "The Blinding Vale dungeon", acquisition = "Drops from Ziekket on Mythic difficulty; comments say it also became obtainable through Mythic+ once The Blinding Vale entered the Season 2 rotation." },
        },
        achievements = {
            ids = {
                62273, 62288, 62289, 62290, 62291, 62292, 62293, 62294, 62295, 62296, 62324, 62325, 62326, 62329, 62330, 62331,
                62332, 62333, 62336, 62337, 62338, 62339, 62340, 62341, 62342, 62343, 62351, 62352, 62357, 62358, 62359, 62360,
                62361, 62362, 62363, 62364, 62365, 62366, 62369, 62370, 62371, 62373, 62374, 62375, 62376, 62377, 62378, 62383,
                62385, 62386, 62388, 62400, 62403, 62406, 62489, 62493, 62494, 62496, 62514, 62516, 62517, 62603, 62612, 62620,
                62653, 62654, 62655, 62656, 62657, 62658, 62659, 62660, 62688, 62839,
            },
            rewardHighlights = {
                { achievementId = 62386, name = "Light Up the Night", reward = "Mount: Brilliant Petalwing" },
                { achievementId = 62385, name = "Staring Into The Void", reward = "Mount: Lab-Grown Stormray" },
                { achievementId = 62403, name = "'Tis But A Scratch", reward = "Achievement reward noted in Midnight launch data" },
            },
        },
    },
    ["12.1"] = {
        label = "Patch 12.1: Curse of Ula'tek",
        wowheadPatchId = 120100,
        sourceNotes = {
            "Wowhead PTR 12.1.0 Added in Patch filters for mounts, battle pets, and achievements.",
            "Wowhead and Warcraft Mounts Patch 12.1 guides for curated mount source notes.",
            "Wowhead Patch 12.1 toy datamine article for toy item IDs.",
        },
        sourceUrls = {
            mounts = "https://www.wowhead.com/ptr/spells/mounts?filter=21;3;120100",
            mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-1-models-locations",
            mountCrossCheck = "https://www.warcraftmounts.com/patch12.1.0.php",
            tradingPost = "https://news.blizzard.com/en-gb/article/24295383/september-is-a-great-month-to-celebrate-friendship-at-the-trading-post",
            blizzconBundle = "https://news.blizzard.com/en-gb/article/24280280/celebrate-blizzcon-2026-with-the-world-of-warcraft-blizzcon-bundle",
            venomousAbyss = "https://www.wowhead.com/guide/midnight/raids/the-venomous-abyss-overview-location-rewards-bosses",
            altarOfFangs = "https://www.wowhead.com/guide/midnight/altar-of-fangs-dungeon-overview-location-rewards",
            sporefall = "https://www.wowhead.com/guide/midnight/raids/sporefall-overview-location-rewards-boss",
            curseSurges = "https://www.wowhead.com/news/the-300-cursed-surge-achievement-takes-a-very-very-long-time-382464",
            pets = "https://www.wowhead.com/ptr/battle-pets?filter=3;3;120100",
            petGuide = "https://www.wowhead.com/guide/collections/curse-of-ulatek-patch-12-1-all-pets-locations-sources",
            toys = "https://www.wowhead.com/news/new-toys-and-treasures-datamined-on-the-patch-12-1-ptr-381966",
            treasureGuide = "https://www.method.gg/guides/treasures-of-the-coiled-isle-locations-in-wow-midnight",
            corrosiveVendorGuide = "https://www.method.gg/guides/skull-of-er-inye-corrosive-coins-vendor-location-and-rewards-in-wow-midnight",
            reputationGuide = "https://www.method.gg/guides/zuljarras-forces-reputation-guide-for-wow-midnight",
            achievements = "https://www.wowhead.com/ptr/achievements?filter=17;3;120100",
        },
        mounts = {
            { spellId = 1296734, itemId = 275442, name = "Amethyst Mechsuit" },
            { spellId = 1297404, itemId = 275657, name = "Apophic Soul Crusher" },
            { spellId = 1297224, itemId = 275656, name = "Auriferous Venomfang" },
            { spellId = 1294767, itemId = 274681, name = "Badlands Buzzard" },
            { spellId = 1292344, itemId = 273651, name = "Bilgewater X-TREME Firework Rocket" },
            { spellId = 1292102, itemId = 273317, name = "Blackwater X-TREME Firework Rocket" },
            { spellId = 1296756, itemId = 275444, name = "Blue-Chip Shreddertank" },
            { spellId = 1301070, itemId = 276881, name = "Breath of Blight" },
            { spellId = 1301074, itemId = 276882, name = "Breath of Ruin" },
            { spellId = 1296731, itemId = 275440, name = "Cerulean Deathwalker" },
            { spellId = 1298808, itemId = 276162, name = "Corroded Soul Crusher" },
            { spellId = 1305206, itemId = 278574, name = "Crested Aqua Leafmimic" },
            { spellId = 1305204, itemId = 278573, name = "Crested Ember Leafmimic" },
            { spellId = 1305207, itemId = 278575, name = "Crested Verdant Leafmimic" },
            { spellId = 1297220, itemId = 275652, name = "Crimson Venomfang" },
            { spellId = 1243582, itemId = 246731, name = "Dusk Grimlynx" },
            { spellId = 1299965, itemId = 276553, name = "Emerald Skyfang" },
            { spellId = 1297407, itemId = 275659, name = "Hexflame Reaver" },
            { spellId = 1296759, itemId = 275446, name = "High-Yield Shreddertank" },
            { spellId = 1300778, itemId = 276802, name = "Indigo Coiled Horror" },
            { spellId = 1284973, itemId = 269240, name = "Luminous Sporeglider" },
            { spellId = 1294663, itemId = 274650, name = "Netherforged Nullframe" },
            { spellId = 1297408, itemId = 275660, name = "Preyhunter's Fury" },
            { spellId = 1297405, itemId = 275658, name = "Primeval Skyfriend" },
            { spellId = 1296758, itemId = 275445, name = "Profit-Green Shreddertank" },
            { spellId = 1300779, itemId = 276803, name = "Ruby Writhe" },
            { spellId = 1264184, itemId = 258884, name = "Spawn of Vyranoth" },
            { spellId = 1296760, itemId = 275447, name = "Speculative Shreddertank" },
            { spellId = 1292668, itemId = 273838, name = "Spirit of Tok'jara" },
            { spellId = 1298439, itemId = 275464, name = "Sun Festival's Painted Roc" },
            { spellId = 1300776, itemId = 276804, name = "The Writhing Brood" },
            { spellId = 1299961, itemId = 276549, name = "Topaz Skyfang" },
            { spellId = 1297427, itemId = 275664, name = "Tortured Gorger" },
            { spellId = 1301775, itemId = 277192, name = "Umbral Ashes" },
            { spellId = 1297217, itemId = 275654, name = "Venom Serpent - Green" },
            { spellId = 1297216, itemId = 275653, name = "Venom Serpent - Purple" },
            { spellId = 1300777, itemId = 276801, name = "Venomous Coiler" },
            { spellId = 1266211, itemId = 275302, name = "Venomous Gladiator's Goredrake" },
            { spellId = 1296672, itemId = 275432, name = "Vicious Lightbloom Boar" },
            { spellId = 1296670, itemId = 275433, name = "Vicious Lightbloom Boar" },
            { spellId = 1299963, itemId = 276551, name = "Violet-Backed Skyfang" },
            { spellId = 1294648, itemId = 274649, name = "Voidmancer's Starcarver" },
        },
        pets = {
            { speciesId = 5035, npcId = 262248, name = "Autumn Snapling" },
            { speciesId = 5134, npcId = 271163, name = "Cauldron Concoction" },
            { speciesId = 5031, npcId = 262247, name = "Caustic Writhling" },
            { speciesId = 5071, npcId = 266464, name = "Corrosive Writhling" },
            { speciesId = 5029, npcId = 262226, name = "Cursed Spawn" },
            { speciesId = 5027, npcId = 262220, name = "Furiostraza" },
            { speciesId = 5030, npcId = 262246, name = "Jaundiced Slitherer" },
            { speciesId = 5131, npcId = 270857, name = "Ki'clak" },
            { speciesId = 5137, npcId = 271772, name = "Lil' Mon" },
            { speciesId = 5026, npcId = 262210, name = "Lil'Kruul" },
            { speciesId = 5032, npcId = 262245, name = "Nightfur Kapara" },
            { speciesId = 5126, npcId = 269712, name = "Pale Hexscale" },
            { speciesId = 5133, npcId = 271106, name = "Poison Dart Frog" },
            { speciesId = 5028, npcId = 262222, name = "Poisoned Parasite" },
            { speciesId = 5076, npcId = 266833, name = "Preyhunter's Prismguard" },
            { speciesId = 5078, npcId = 266835, name = "Preyhunter's Riftbreaker" },
            { speciesId = 5033, npcId = 262244, name = "Sleek Snakebiter" },
            { speciesId = 5129, npcId = 270147, name = "Slitherfang" },
            { speciesId = 5093, npcId = 267805, name = "Snek'zali" },
            { speciesId = 5125, npcId = 269501, name = "Soulcoil Remnant" },
            { speciesId = 5034, npcId = 262243, name = "Steady Croakfrog" },
            { speciesId = 3526, npcId = 269295, name = "Three-Eyed Fish" },
            { speciesId = 5130, npcId = 270425, name = "Ula'took" },
            { speciesId = 5070, npcId = 265786, name = "Venom Elemental" },
            { speciesId = 5092, npcId = 267689, name = "Vibrant Venomfang" },
            { speciesId = 5072, npcId = 266469, name = "Volatile Venomfang" },
            { speciesId = 5011, npcId = 260792, name = "Zan" },
            { speciesId = 5132, npcId = 271086, name = "Zesty" },
        },
        toys = {
            { itemId = 279052, name = "Ancient Amani Mask" },
            { itemId = 276258, name = "Companion Command Crystal" },
            { itemId = 275988, name = "Corrosive Victory" },
            { itemId = 276189, name = "Effigy of Dundun" },
            { itemId = 279021, name = "Forgotten Memento" },
            { itemId = 279054, name = "Idol of Blue Water and Blue Sky" },
            { itemId = 276925, name = "Idol of Ula'tek" },
            { itemId = 277954, name = "Jaktu's Cursed Blade" },
            { itemId = 268504, name = "Malfunctioning Staff" },
            { itemId = 278557, name = "Otoola's Recognition" },
            { itemId = 274921, name = "Pearl of Jubilation" },
            { itemId = 276207, name = "Preyhunter's Masquerade" },
            { itemId = 276229, name = "Preyhunter's Trophy Stand" },
            { itemId = 275825, name = "Ula'tek's Sssacrificial Rain" },
        },
        achievements = {
            ids = {
                61335, 61336, 61442, 61463, 62282, 62283, 62284, 62285, 62286, 62287, 62297, 62410, 62411, 62412, 62414,
                62416, 62417, 62418, 62419, 62420, 62421, 62422, 62423, 62424, 62425, 62426, 62427, 62428, 62429, 62430,
                62431, 62432, 62433, 62434, 62435, 62436, 62437, 62438, 62439, 62440, 62441, 62442, 62443, 62444, 62445,
                62446, 62447, 62448, 62449, 62460, 62461, 62466, 62467, 62468, 62469, 62470, 62471, 62472, 62473, 62474,
                62475, 62476, 62477, 62478, 62479, 62480, 62481, 62482, 62483, 62487, 62488, 62492, 62497, 62566, 62567,
                62600, 62601, 62604, 62606, 62607, 62608, 62609, 62610, 62649, 62842, 62857, 62858, 62859, 62860, 62861,
                62862, 62863, 62864, 62865, 62866, 62867, 62871, 62872, 62873, 62874, 62875, 62876, 62877, 62878, 62879,
                62880, 62881, 62882, 62883, 62887, 62889, 62890, 62891, 62892, 62893, 62894, 62895, 62896, 62897, 62898,
                62899, 62900, 62901, 62903, 62904, 62905, 62909, 62911, 62912, 62913, 62914, 62915, 62916, 62917, 62919,
                62921, 62922, 62923, 62924, 62925, 62926, 62927, 62928, 62929, 62930, 62931, 62932, 62940, 62941, 62942,
                62943, 62944, 62945, 62949, 62950, 62951, 62952, 62953, 62954, 62955, 63097, 63099, 63103, 63104, 63164,
                63167, 63170, 63171, 63182, 63233, 63234, 63235, 63236, 63237, 63240, 63241, 63242, 63246, 63247, 63250,
                63253, 63254, 63263, 63264, 63323, 63325, 63326, 63332, 63333, 63334, 63343, 63348, 63349, 63358, 63359,
                63381, 63382, 63383, 63384, 63385, 63386, 63390, 63391, 63394, 63395, 63397, 63400, 63415, 63416, 63418,
                63420, 63421, 63422, 63423, 63424, 63425, 63426, 63427, 63428, 63430, 63432, 63433, 63434, 63435, 63436,
                63437, 63438, 63439, 63440, 63441, 63451, 63452, 63453, 63454, 63457, 63472, 63473, 63476, 63510, 63512,
                63520, 63521, 63522, 63523, 63524, 63525, 63526, 63527, 63528, 63529, 63530, 63531, 63532, 63533, 63534,
                63535, 63536, 63537, 63538, 63539, 63540, 63541, 63547, 63548, 63549, 63550, 63551, 63552, 63553, 63554,
                63555, 63556, 63557, 63558, 63559, 63560, 63561, 63562, 63563, 63564, 63565, 63566, 63567, 63568, 63569,
                63596, 63598, 63599, 63600, 63601, 63605, 63606, 63608, 63609, 63610, 63611, 63613, 63614, 63615, 63616,
                63619, 63620, 63621, 63622, 63623, 63624, 63625, 63626, 63627, 63628, 63629, 63630, 63631, 63632, 63633,
                63634, 63635, 63636, 63639, 63640, 63641, 63642, 63643, 63644, 63645, 63646, 63647, 63648, 63650, 63651,
                63652, 63653, 63656, 63662, 63669, 63670, 63679, 63681, 63682, 63683, 63686, 63687, 63688, 63695, 63696,
                63697, 63698, 63699,
            },
            rewardHighlights = {
                { achievementId = 63633, name = "A Stack of Snacks", reward = "Pet: Ki'clak" },
                { achievementId = 63630, name = "Assault the Vault", reward = "Mount: Venomous Coiler" },
                { achievementId = 63334, name = "Fabled Let Me Solo Him: Azta'rec", reward = "Title: Fabled Vanquisher of Azta'rec" },
                { achievementId = 62461, name = "Family Battler of Cataclysm", reward = "Pet: Furiostraza" },
                { achievementId = 62460, name = "Family Battler of Outland", reward = "Pet: Lil'Kruul" },
                { achievementId = 63254, name = "Glory of the Venomous Raider", reward = "Mount: Crimson Venomfang" },
                { achievementId = 63333, name = "Let Me Solo Him: Azta'rec", reward = "Reward: Apophic Soul Crusher" },
                { achievementId = 61463, name = "Master of the Turbulent Timeways V", reward = "Mount: Spawn of Vyranoth" },
                { achievementId = 62449, name = "Midnight Keystone Legend: Season 2", reward = "Mount: Breath of Ruin" },
                { achievementId = 62447, name = "Midnight Keystone Master: Season 2", reward = "Mount: Breath of Blight" },
                { achievementId = 63609, name = "No Egg Scramble", reward = "Companion Pet: Ula'took" },
                { achievementId = 63653, name = "Pro Poison Patroller", reward = "Mount: Emerald Skyfang" },
                { achievementId = 62492, name = "The Coiled Isle Safari", reward = "Pet: Zesty" },
                { achievementId = 63167, name = "Tour of Duty: The Coiled Isle", reward = "Toy: Ula'tek's Sssacrificial Rain" },
                { achievementId = 63359, name = "Treasures of the Coiled Isle", reward = "Mount: Auriferous Venomfang" },
                { achievementId = 63104, name = "Umbral Champion: Midnight Season 1", reward = "Mount: Umbral Ashes" },
                { achievementId = 63099, name = "Venomous Combatant", reward = "Vicious Lightbloom Boar" },
                { achievementId = 63103, name = "Venomous Combatant", reward = "Vicious Lightbloom Boar" },
            },
        },
    },
    ["Unknown"] = {
        label = "Unknown",
        sourceNotes = {
            "Collectibles with unknown, placeholder, future rotation, shop, promotion, or regional availability are grouped here until their acquisition source is confirmed.",
            "Trading Post entries remain here when they are only listed for a future rotation instead of a known monthly offering.",
        },
        sourceUrls = {},
        mounts = {
            { spellId = 1238827, name = "Swift Spectral Dragonhawk" },
            { spellId = 1258573, itemId = 254735, name = "Thunderhoof Celestial" },
            { spellId = 1258574, itemId = 254736, name = "Stormgilded Celestial" },
            { spellId = 1266993, itemId = 260893, name = "Arboreal Pseudoshell" },
            { spellId = 1266997, itemId = 260894, name = "Cabbage Pseudoshell" },
            { spellId = 1267002, itemId = 260895, name = "Lavender Pseudoshell" },
            { spellId = 1267004, itemId = 260896, name = "Accented Pseudoshell" },
            { spellId = 1268809, itemId = 262438, name = "Fantastical Goblin Waveshredder" },
            { spellId = 1269181, itemId = 262661, name = "Ghastropod" },
            { spellId = 1269273, itemId = 262705, name = "Vicious Snapvine" },
            { spellId = 1269277, itemId = 262706, name = "Ferocious Snapvine" },
            { spellId = 1269279, itemId = 262707, name = "Blooded Snapvine" },
            { spellId = 1269280, itemId = 262708, name = "Savage Snapvine" },
            { spellId = 1269556, itemId = 262909, name = "Hypo-Speed X6000" },
            { spellId = 1270520, itemId = 263449, name = "Fluffy Comfy Flying Quilt" },
            { spellId = 1270521, itemId = 263450, name = "Gruffy Comfy Flying Quilt" },
            { spellId = 1270522, itemId = 263451, name = "Comfy Bel'ameth Flying Quilt" },
            { spellId = 1270523, itemId = 263452, name = "Comfy Silvermoon Flying Quilt" },
            { spellId = 1271549, itemId = 264273, name = "Fel Spirehawk" },
            { spellId = 1284640, itemId = 269009, name = "Golden Ashened Cataclysm" },
            { spellId = 1294677, name = "[PH] Horse with Hat" },
            { spellId = 1261369, name = "Amani Hex Bear" },
            { spellId = 1296724, itemId = 275551, name = "Autumnal Witchwick's Rider" },
            { spellId = 1296988, itemId = 275573, name = "Blushing Witchwick's Rider" },
            { spellId = 1296989, itemId = 275574, name = "Carmine Witchwick's Rider" },
            { spellId = 1305209, itemId = 278576, name = "Crested Violet Leafmimic" },
            { spellId = 1292342, itemId = 273650, name = "Green Rocket Mount [PH]" },
            { spellId = 1296986, itemId = 275571, name = "Moonlit Witchwick's Rider" },
            { spellId = 1296985, itemId = 275570, name = "Mossy Witchwick's Rider" },
            { spellId = 1292345, itemId = 273652, name = "Pink Rocket Mount [PH]" },
            { spellId = 1293456, itemId = 274260, name = "Rabbit'ath" },
            { spellId = 1267077, itemId = 262344, name = "Scarlet Lady" },
            { spellId = 1296987, itemId = 275572, name = "Scarlet Witchwick's Rider" },
            { spellId = 1299156, itemId = 276245, name = "Shadow Spirehawk" },
            { spellId = 1285897, itemId = 269640, name = "Sha-Warped Owl" },
            { spellId = 1284679, itemId = 269012, name = "Sha-Warped Riding Wolf" },
            { spellId = 1291315, itemId = 272920, name = "Spring Panda" },
            { spellId = 1279352, itemId = 267078, name = "Stoneforged Sentinel" },
            { spellId = 1292356, itemId = 273655, name = "Sunflare Driftmoth" },
            { spellId = 1295958, name = "Swift Spectral Eagle" },
            { spellId = 1266982, itemId = 269659, name = "The Sire's Palanquin" },
            { spellId = 1297223, itemId = 275655, name = "Venom Serpent - White" },
            { spellId = 1301817, itemId = 277261, name = "Whoofle Bramblewing" },
            { spellId = 1309340, itemId = 280581, name = "Wintry Witchwick's Rider" },
            { spellId = 1283837, itemId = 268833, name = "Zothwing Darkseeker" },
            { spellId = 1283838, itemId = 268834, name = "Zothwing Deepseeker" },
        },
        pets = {
            { speciesId = 5119, npcId = 268676, name = "Amewbisath" },
            { speciesId = 5077, npcId = 266834, name = "ArcaneGolem2 Pet - Red" },
            { speciesId = 5115, npcId = 268636, name = "Archmage's Familiar" },
            { speciesId = 5116, npcId = 268671, name = "Catsramas" },
            { speciesId = 5117, npcId = 268672, name = "Cat'Thuzad" },
            { speciesId = 5061, npcId = 264280, name = "Crabbers" },
            { speciesId = 5114, npcId = 268609, name = "Kirin Tor Kitty" },
            { speciesId = 5118, npcId = 268675, name = "Mewkahen" },
            { speciesId = 5064, npcId = 264863, name = "Murk'atath" },
            { speciesId = 5052, npcId = 263995, name = "Sunflicker Driftmoth" },
        },
        toys = {},
        achievements = {
            ids = {},
            rewardHighlights = {},
        },
    },
}

PatchCatalog.achievementCategories = {
    ["12.1"] = {
        [61463] = "Events",
        [62447] = "Dungeons",
        [62449] = "Dungeons",
        [62460] = "Pet Battles",
        [62461] = "Pet Battles",
        [62492] = "Pet Battles",
        [63099] = "PvP",
        [63103] = "PvP",
        [63104] = "Dungeons",
        [63167] = "PvP",
        [63254] = "Raids",
        [63333] = "Delves",
        [63334] = "Delves",
        [63359] = "Exploration",
        [63609] = "Pet Battles",
        [63630] = "Questing",
        [63633] = "Pet Battles",
        [63653] = "Questing",
    },
}

PatchCatalog.petDetails = {
    ["12.1"] = {
        ["Autumn Snapling"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet around the southeast shoreline of Gnarldor Isle, including the small island and nearby shoreline.", waypoints = { "/way #2512 67.8 81.4 Autumn Snapling", "/way #2512 70.6 78.6 Autumn Snapling" } },
        ["Cauldron Concoction"] = { sourceType = "Discovery", source = "Ofi's Offerings / Mixing Mysteries", acquisition = "Complete the Mixing Mysteries activity with Ofi the Sly. Open Handful of Esoteric Ingredients, combine ingredients into offerings, then turn in the offering containers for a low chance at the pet.", waypoints = { "/way #2512 61.0 32.6 Ofi the Sly / Swamp", "/way #2512 57.4 48.7 Ofi the Sly / Tokka's Landing" } },
        ["Caustic Writhling"] = { sourceType = "Wild caught", source = "Vaults of Atal'Utek", acquisition = "Click-capture this peaceful pet inside the Vaults of Atal'Utek sub-zone.", waypoints = { "/way #2509 39.0 28.2 Caustic Writhling" } },
        ["Corrosive Writhling"] = { sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy from Skull of Er'inye for 5000 Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Cursed Spawn"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle.", waypoints = { "/way #2512 47.2 59.8 Cursed Spawn", "/way #2512 46.20 27.11 Cursed Spawn" } },
        ["Furiostraza"] = { sourceType = "Achievement", source = "Family Battler of Cataclysm", acquisition = "Defeat every Cataclysm trainer with teams composed of each pet battle family." },
        ["Jaundiced Slitherer"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle. Wowhead notes phasing issues: complete the active campaign quest in the area if it is not appearing.", waypoints = { "/way #2512 45.2 31.2 Jaundiced Slitherer" } },
        ["Ki'clak"] = { sourceType = "Achievement", source = "A Stack of Snacks", acquisition = "Complete the world quest Ki'clak Snack Attack 5 times while feeding Ki'clak. The guide notes this unlocks after the storyline that starts with Ghosts of the Ring." },
        ["Lil' Mon"] = { sourceType = "Drop", source = "Big Mon", acquisition = "Drops from Big Mon on the Coiled Isle.", waypoints = { "/way #2512 70.0 63.6 Big Mon" } },
        ["Lil'Kruul"] = { sourceType = "Achievement", source = "Family Battler of Outland", acquisition = "Defeat every Outland trainer with teams composed of each pet battle family." },
        ["Nightfur Kapara"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful rare pet in the southern grassy area of Gnarldor Isle. It patrols between the shrine and the delve and has a longer respawn.", waypoints = { "/way #2512 62.6 84.0 Nightfur Kapara", "/way #2512 61.6 81.8 Nightfur Kapara" } },
        ["Pale Hexscale"] = { sourceType = "Drop", source = "Ral'kala / Nightmare Prey", acquisition = "Chance to drop from Ral'kala during Curse of the Isle. Farm Ossified Relics, contribute at the Haunted Brazier so you get credit, and watch Group Finder for Ral'kala or Haunted Brazier groups when the progress bar is moving.", waypoints = RALKALA_WAYPOINTS },
        ["Poison Dart Frog"] = { sourceType = "Treasure", source = "Unfortunate Scout's Satchel", acquisition = "Chance from Unfortunate Scout's Satchels after the satchel activity unlocks at Zul'jarra's Forces Renown 9. Route the listed spawn points and loot each satchel you find.", waypoints = UNFORTUNATE_SCOUT_SATCHEL_WAYPOINTS },
        ["Poisoned Parasite"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle.", waypoints = { "/way #2512 62.2 40.8 Poisoned Parasite", "/way #2512 65.2 49.2 Poisoned Parasite" } },
        ["Preyhunter's Prismguard"] = { sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Prey Renown level 8, then buy from Construct V'anore for 1200 Remnant of Anguish. Prey world quests and trap farming near active Prey objectives are the steady Remnant sources.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyhunter's Riftbreaker"] = { sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Prey Renown level 8, then buy from Construct V'anore for 1200 Remnant of Anguish. Prey world quests and trap farming near active Prey objectives are the steady Remnant sources.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Sleek Snakebiter"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle.", waypoints = { "/way #2512 65.81 45.75 Sleek Snakebiter" } },
        ["Slitherfang"] = { sourceType = "Secret", source = "Altar of Fangs Mythic", acquisition = "In Mythic Altar of Fangs, bring a full group. Before the first boss, have 4 players pick up Reversal Charms and 1 pick up the Ritual Reagent under the waterfalls. Kill the first two bosses, clear the room after boss two, avoid clicking the totems, then use the extra action interactions on the snake.", waypoints = ALTAR_OF_FANGS_WAYPOINTS },
        ["Snek'zali"] = { sourceType = "Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 12 with Zul'jarra's Forces, then buy from Jan'sari the Watchful for 2500 Voidlight Marl.", waypoints = JANSARI_WAYPOINTS },
        ["Soulcoil Remnant"] = { sourceType = "Drop", source = "Nek'zali the Soulcoiler / The Venomous Abyss", acquisition = "Drops from Nek'zali the Soulcoiler, the first boss of The Venomous Abyss, on raid difficulties. The pet is cageable, so the Auction House is a backup route.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Steady Croakfrog"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet around the northeast water/coastline of the island.", waypoints = { "/way #2512 65.8 32.8 Steady Croakfrog", "/way #2512 69.23 46.35 Steady Croakfrog" } },
        ["Three-Eyed Fish"] = { sourceType = "Quest", source = "Tipping the Scaled", acquisition = "Requires Venom Trawler friendship rank with Captain Tokka. Buy the Eerie Bauble from Second Mate Sluggs, fish in Coiled Isle pools until the quest-giver appears, then complete Tipping the Scaled.", waypoints = SECOND_MATE_SLUGGS_WAYPOINTS },
        ["Ula'took"] = { sourceType = "Achievement", source = "No Egg Scramble", acquisition = "Earn No Egg Scramble in The Venomous Abyss; Wowhead lists it as part of Glory of the Venomous Raider." },
        ["Venom Elemental"] = { sourceType = "Vendor", source = "Second Mate Sluggs", acquisition = "Reach Venom Trawler rank with Captain Tokka, then buy from Second Mate Sluggs for 100 gold.", waypoints = SECOND_MATE_SLUGGS_WAYPOINTS },
        ["Vibrant Venomfang"] = { sourceType = "Drop", source = "Wriggling Venom-Soaked Satchel / Curse Surges", acquisition = "Very rare chance from Wriggling Venom-Soaked Satchel, which can replace the normal Venom-Soaked Satchel after completing Curse Surge events. Watch the map Events tab, arrive before the 45-minute surge starts, and repeat the five surge locations.", waypoints = CURSE_SURGE_WAYPOINTS },
        ["Volatile Venomfang"] = { sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy from Skull of Er'inye for 5000 Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Zan"] = { sourceType = "Quest", source = "Strange Friends in Odd Places", acquisition = "Complete the side questline that starts with Dealing with Pests from Ofi the Sly, then finish A Little Kindness for Zan.", waypoints = { "/way #2512 61.0 32.6 Ofi the Sly / Dealing with Pests", "/way #2512 57.4 48.7 Ofi the Sly / alternate daily position" } },
        ["Zesty"] = { sourceType = "Achievement", source = "The Coiled Isle Safari", acquisition = "Capture every wild pet required for The Coiled Isle Safari. Wowhead notes the achievement does not include some rare pets." },
    },
    ["Unknown"] = {
        ["Amewbisath"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["ArcaneGolem2 Pet - Red"] = { sourceType = "Unknown / PTR placeholder", source = "Wowhead PTR pet and item pages", acquisition = "The scraped Wowhead and WoWDB pages only list this as a PTR pet with unknown location/source; no reliable acquisition method was found." },
        ["Archmage's Familiar"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Catsramas"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Cat'Thuzad"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Crabbers"] = { sourceType = "Unknown / unobtainable", source = "Wowhead PTR NPC page", acquisition = "The scraped Wowhead page says this battle pet cannot be tamed and its location is unknown; no reliable collection method was found." },
        ["Kirin Tor Kitty"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Mewkahen"] = { sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a future Trading Post pet. Check the monthly Trading Post inventory and use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Murk'atath"] = { sourceType = "Promotion", source = "BlizzCon 2026 Ultimate Collection", acquisition = "Available through the BlizzCon 2026 Ultimate Collection or by linking an eligible BlizzCon Pass to a Battle.net account before the stated deadline. This has no in-world collection location." },
        ["Sunflicker Driftmoth"] = { sourceType = "In-Game Shop", source = "Battle.net Shop / subscription bundle", acquisition = "Listed as an In-Game Shop pet and matching companion for the Sunflare Driftmoth promotion. It may also be bundled with subscription offers depending on region/time." },
    },
}

PatchCatalog.toyDetails = {
    ["12.1"] = {
        ["Ancient Amani Mask"] = { sourceType = "Treasure", source = "Sunken Diver's Chest / The Coiled Isle", acquisition = "During Cursed Surges, farm Glittering Grouper Brintails around the northern water for 3 Diver's Key Fragments, combine them into a Diver's Key, then open the Sunken Diver's Chest.", effect = "Adds an Amani mask to your character for about 10 minutes; the effect cannot be manually removed.", waypoints = { "/way #2512 65.41 5.58 Sunken Diver's Chest", "/way #2512 70.0 33.0 Ss'akrithos / Cursed Surge area" } },
        ["Companion Command Crystal"] = { sourceType = "Prey", source = "Preyhunter's Journey Season 2 Rank 4", acquisition = "Reach Preyhunter's Journey Season 2 Rank 4, then buy from Construct V'anore for 600 Remnant of Anguish.", effect = "Commands your active companion pet to attack a nearby critter.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Corrosive Victory"] = { sourceType = "Delves", source = "Fangs for the Memories / Azta'rec", acquisition = "Pick up the Season 2 delve questline at Delver's Headquarters, then defeat Azta'rec in Venomfall Deeps on any difficulty to complete Fangs for the Memories.", effect = "Applies a snake-themed visual illusion around your character.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        ["Effigy of Dundun"] = { sourceType = "Delves", source = "Telemancer Astrandis", acquisition = "Reach Delver's Journey Season 2 Rank 3, then buy the toy from Telemancer Astrandis in Silvermoon City.", effect = "Transforms your character into Dundun for 30 minutes.", waypoints = TELEMANCER_ASTRANDIS_WAYPOINTS },
        ["Forgotten Memento"] = { sourceType = "Treasure", source = "Grave of Someone Forgotten / The Coiled Isle", acquisition = "Loot the Grave of Someone Forgotten, then speak with the nearby related spirits if the treasure interaction is not complete.", effect = "Transforms your character into a ghostly Amani troll and changes your display name to Unknown.", waypoints = { "/way #2512 67.21 48.38 Grave of Someone Forgotten", "/way #2512 69.07 52.71 Zuzan", "/way #2512 70.38 58.45 Nan'ja", "/way #2512 66.38 57.24 Ru'ko" } },
        ["Idol of Blue Water and Blue Sky"] = { sourceType = "Treasure", source = "Abandoned Amani Privateer's Cache / The Coiled Isle", acquisition = "Use the nearby water treasures in order around the privateer cache area, then loot the Abandoned Amani Privateer's Cache.", effect = "Turns you into a dolphin and greatly increases underwater swim speed on the Coiled Isle.", waypoints = { "/way #2512 71.82 66.66 Abandoned Amani Privateer's Cache", "/way #2512 73.27 65.88 Grisly Cod Pool", "/way #2512 73.09 67.02 Waterlogged Crate", "/way #2512 72.45 68.40 Broken Urn" } },
        ["Idol of Ula'tek"] = { sourceType = "Renown", source = "Jan'sari the Watchful", acquisition = "Reach Renown 13 with Zul'jarra's Forces, then buy from Jan'sari the Watchful for 4000 Voidlight Marl.", effect = "Transforms your character into a Child of Ula'tek.", waypoints = JANSARI_WAYPOINTS },
        ["Jaktu's Cursed Blade"] = { sourceType = "Treasure", source = "Jaktu's Cursed Blade / The Coiled Isle", acquisition = "Loot Jaktu's Cursed Blade at the marked spot on The Coiled Isle.", effect = "Haunts you for 10 minutes; Jak'tu occasionally appears and laughs.", waypoints = { "/way #2512 60.41 59.49 Jaktu's Cursed Blade" } },
        ["Malfunctioning Staff"] = { sourceType = "Treasure", source = "Malfunctioning Staff / The Coiled Isle", acquisition = "Loot the Malfunctioning Staff at the marked spot on The Coiled Isle.", effect = "Summons a dancing mage image.", waypoints = { "/way #2512 75.38 68.37 Malfunctioning Staff" } },
        ["Otoola's Recognition"] = { sourceType = "Vendor", source = "Navigator Otoola, Tokka's Landing", acquisition = "Buy from Navigator Otoola in Tokka's Landing for 10 Pristine Polygon.", effect = "Pins a gold starfish to a friend or foe.", waypoints = { "/way #2512 57.2 48.3 Navigator Otoola" } },
        ["Pearl of Jubilation"] = { sourceType = "Treasure", source = "Brine-Crusted Chest / The Coiled Isle", acquisition = "Open the Bubbling Clams near the coast, then loot the Brine-Crusted Chest.", effect = "Transforms your character into a dancing crab.", waypoints = { "/way #2512 70.61 76.70 Brine-Crusted Chest", "/way #2512 68.05 80.31 Bubbling Clam", "/way #2512 69.57 82.48 Bubbling Clam", "/way #2512 70.90 81.63 Bubbling Clam", "/way #2512 71.30 83.29 Bubbling Clam" } },
        ["Preyhunter's Masquerade"] = { sourceType = "Drop", source = "Ral'kala / Prey System", acquisition = "Drops from Ral'kala during Curse of the Isle. Contribute Ossified Relics at the Haunted Brazier for credit, then kill Ral'kala when the event completes.", effect = "Transforms your character into a floating mask.", waypoints = RALKALA_WAYPOINTS },
        ["Preyhunter's Trophy Stand"] = { sourceType = "Prey", source = "Preyhunter's Journey Season 2 Rank 4", acquisition = "Reach Preyhunter's Journey Season 2 Rank 4, then buy from Construct V'anore for 800 Remnant of Anguish.", effect = "Summons a trophy stand for displaying earned Prey achievement trophies.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ula'tek's Sssacrificial Rain"] = { sourceType = "PvP", source = "Tour of Duty: The Coiled Isle", acquisition = "Earn Tour of Duty: The Coiled Isle by killing enemy players on The Coiled Isle.", effect = "While active, enemy players killed near you melt into a pile of goo." },
    },
}

PatchCatalog.mountDetails = {
    ["12.0"] = {
        ["Arcanovoid Construct"] = { category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Nullaeus", acquisition = "Defeat Nullaeus, the Midnight Season 1 Delve Nemesis, solo on the required high tier." },
        ["Light-Forged Mechsuit"] = { category = "Achievements", sourceType = "Achievement", source = "Achievement 42300", acquisition = "Complete the Feat of Strength tied to killing all 19 Twilight's Blade rare bosses. Wowhead item comments describe a fixed rare rotation and confirm the mount as the reward." },
        ["Elven Arcane Guardian"] = { category = "Delves", sourceType = "Vendor", source = "Naleidea Rivergleam, Delver's Headquarters in Silvermoon", acquisition = "Buy with Undercoin from Naleidea Rivergleam in Silvermoon." },
        ["Silvermoon's Arcane Defender"] = { category = "Delves", sourceType = "Vendor", source = "Telemancer Astrandis, Delver's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Delver's Journey Rank 5, then buy from Telemancer Astrandis." },
        ["Giganto Manis"] = { category = "Delves", sourceType = "Achievement", source = "Glory of the Midnight Delver", acquisition = "Complete the Midnight delve meta-achievement, including delve story, sturdy chest, curio, and Nemesis objectives." },
        ["Preyseeker's Hubris"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 5, then buy with Remnant of Anguish." },
        ["Preyseeker's Wrath"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 10, then buy with Remnant of Anguish." },
        ["Preyseeker's Nightmare"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Prey: Nightmare Mode III", acquisition = "Defeat every Midnight Prey target on Nightmare difficulty." },
        ["Calamitous Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Master: Season 1", acquisition = "Earn at least 2000 Mythic+ rating during Midnight Season 1." },
        ["Convalescent Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Legend: Season 1", acquisition = "Earn at least 3000 Mythic+ rating during Midnight Season 1." },
        ["Lucent Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Degentrius in Magisters' Terrace", acquisition = "Chance to drop from Degentrius on Mythic difficulty, or from the Magisters' Terrace Mythic+ Challenger's Cache." },
        ["Spectral Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Restless Heart in Windrunner's Spire", acquisition = "Chance to drop from Restless Heart on Mythic difficulty, or from the Windrunner's Spire Mythic+ Challenger's Cache." },
        ["Crimson Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Midnight Glyph Hunter", acquisition = "Collect all Skyriding Glyphs in Quel'Thalas and adjacent Midnight zones." },
        ["Cerulean Hawkstrider"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Chance to drop from rare mobs in Eversong Woods." },
        ["Cobalt Dragonhawk"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Chance to drop from rare mobs in Eversong Woods." },
        ["Amani Sharptalon"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Chance to drop from rare mobs in Zul'Aman." },
        ["Witherbark Pango"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Chance to drop from rare mobs in Zul'Aman." },
        ["Rootstalker Grimlynx"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Chance to drop from rare mobs in Harandar." },
        ["Vibrant Petalwing"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Chance to drop from rare mobs in Harandar." },
        ["Ruddy Sporeglider"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Peculiar Cauldron in Harandar", acquisition = "Open the Peculiar Cauldron around /way #2413 40.7 28.1 after collecting 150 of the required cauldron items from small river treasures nearby. Wowhead comments recommend farming along the river from the northern lake toward the Den.", waypoints = { "/way #2413 40.7 28.1 Peculiar Cauldron", "/way #2413 40.0 21.4 River treasure route start", "/way #2413 49.32 51.16 River treasure route end" } },
        ["Untainted Grove Crawler"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Sporespawned Cache in Harandar", acquisition = "Use the Fungal Mallet in Fungara Village to gain the buff, then ring the nearby Mycelium Gong. The Sporespawned Cache appears next to the gong and can contain the mount.", waypoints = { "/way #2413 41.31 67.90 Fungal Mallet", "/way #2413 46.65 67.78 Mycelium Gong / Sporespawned Cache" } },
        ["Echo of Aln'sharan"] = { category = "Quest Rewards", sourceType = "Hidden turn-in", source = "Kuri in Harandar", acquisition = "After completing the relevant Harandar storyline, farm 500 rare skyshards from Harandar mobs and delves, then turn them in to Kuri. Comments note Kuri is airborne near the edge of the zone and you may need to dismount to interact.", waypoints = { "/way #2413 66.15 25.47 Kuri" } },
        ["Augmented Stormray"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Chance to drop from rare mobs in Voidstorm." },
        ["Sanguine Harrower"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Chance to drop from rare mobs in Voidstorm." },
        ["Ancestral War Bear"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Honored Warrior's Cache in Zul'Aman", acquisition = "Interact with Honored Warrior's Cache, collect four key items from guardian urn events across Zul'Aman, then return to open the cache.", waypoints = { "/way #2437 21.45 77.38 Honored Warrior's Cache", "/way #2437 32.69 83.50 Nalorakk's Cache", "/way #2437 34.55 33.46 Halazzi's Cache", "/way #2437 54.78 22.39 Jan'alai's Cache", "/way #2437 51.58 84.92 Akil'zon's Cache" } },
        ["Hexed Vilefeather Eagle"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Abandoned Ritual Skull in Zul'Aman", acquisition = "Open the Abandoned Ritual Skull treasure after farming the required Vile Essence from nearby mobs." },
        ["Relinquished Scarlet Charger"] = { category = "Quest Rewards", sourceType = "Quest", source = "Relinquishing Relics", acquisition = "Complete the Relinquishing Relics questline." },
        ["Ashes of Belo'ren"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Midnight Falls in March on Quel'Danas", acquisition = "Drops from Midnight Falls on Mythic difficulty. Wowhead notes three mounts are guaranteed per kill." },
        ["Tenebrous Harrower"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Glory of the Midnight Raider", acquisition = "Complete the raid meta-achievement across The Dreamrift, Voidspire, and March on Quel'Danas." },
        ["Crimson Silvermoon Hawkstrider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 17, then buy from Caeris Fairdawn in Eversong Woods." },
        ["Fiery Dragonhawk"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 19, then buy from Caeris Fairdawn in Eversong Woods." },
        ["Peridot Dragonhawk"] = { category = "Quest Rewards", sourceType = "Quest reward", source = "Midnight launch quest content", acquisition = "Wowhead's filtered mount list marks this as a quest-sourced mount, but the public spell/item comments did not expose a more precise quest chain during this scrape." },
        ["Amani Blessed Bear"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 17, then buy from Magovu in Zul'Aman." },
        ["Amani Windcaller"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 19, then buy from Magovu in Zul'Aman." },
        ["Fierce Grimlynx"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 16, then buy from Naynar in Harandar." },
        ["Cerulean Sporeglider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 19, then buy from Naynar in Harandar." },
        ["Ravenous Shredclaw"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 17, then buy from Void Researcher Anomander in Voidstorm." },
        ["Voidbound Stormray"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 19, then buy from Void Researcher Anomander in Voidstorm." },
        ["Lab-Grown Stormray"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Staring Into The Void", acquisition = "Spend Uncontaminated Void Samples at the Void Research Console in Voidstorm after progressing The Singularity Renown." },
        ["Frenzied Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy from Thraxadar in Voidstorm." },
        ["Prowling Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy from Thraxadar in Voidstorm." },
        ["Umbral Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Life of the Party", acquisition = "Earn the Life of the Party achievement." },
        ["Duskbrute Harrower"] = { category = "Rare Drops", sourceType = "Paragon Cache", source = "Slayer's Duellum Trove", acquisition = "Chance to drop from the Slayer's Duellum paragon cache." },
        ["Amani Sunfeather"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Earn Unalloyed Abundance from the Abundance world event, then buy from Chel the Chip at Abundance cavern entrances." },
        ["Blessed Amani Burrower"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Earn Unalloyed Abundance from the Abundance world event, then buy from Chel the Chip at Abundance cavern entrances." },
        ["Delver's Arcane Golem"] = { category = "Delves", sourceType = "Sturdy Chest", source = "Gnarldor Isle delve", acquisition = "Wowhead item comments report this from a Sturdy Chest in the Gnarldor Isle delve, especially the chest around /way #2635 60.43 68.11. Some players report receiving the item by mail after leaving the delve.", waypoints = { "/way #2635 28.44 38.15 Sturdy Chest", "/way #2635 52.41 40.87 Sturdy Chest", "/way #2635 60.43 68.11 Sturdy Chest" } },
        ["Vivid Chloroceros"] = { category = "Vendor", sourceType = "Vendor currency", source = "Harandar treasure currency vendor", acquisition = "Collect 120 Harandar treasures for the related achievement and spend the zone currency at the associated Hara'ti vendor. Comments note treasure visibility is gated by Hara'ti renown." },
        ["Anu'shalla, Shadow's Guidance"] = { category = "Achievements", sourceType = "Collection achievement", source = "Mount collection achievement", acquisition = "Wowhead comments identify this as a high mount-count achievement reward; treat as a mount collection milestone reward." },
        ["Galactic Gladiator's Goredrake"] = { category = "PvP", sourceType = "Achievement", source = "Gladiator: Midnight Season 1", acquisition = "Win 50 3v3 arena games while at Elite rank during Midnight Season 1." },
        ["Vicious Snaplizard"] = { category = "PvP", sourceType = "Achievement", source = "Midnight Season 1 Rated PvP", acquisition = "Win rated PvP matches while at 1000+ rating during Midnight Season 1." },
    },
    ["12.1"] = {
        ["Amethyst Mechsuit"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn the high Mythic+ seasonal rating reward choice, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Apophic Soul Crusher"] = { category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Azta'rec", acquisition = "Defeat Azta'rec, the Season 2 Delve Nemesis, solo on the required high tier." },
        ["Badlands Buzzard"] = { category = "Trading Post", sourceType = "Trading Post", source = "August 2026 Trading Post", acquisition = "Available from the August 2026 Trading Post for 550 Trader's Tender. Check the standard Trading Post stalls or future Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Bilgewater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "July 2026 Traveler's Log", acquisition = "Earned as the July 2026 Traveler's Log completion reward through the Trading Post interface.", waypoints = TRADING_POST_WAYPOINTS },
        ["Blackwater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Trading Post / Traveler's Log", source = "Trading Post", acquisition = "Trading Post reward. Check the monthly Trading Post inventory and Outlet returns; use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Blue-Chip Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Corroded Soul Crusher"] = { category = "Delves", sourceType = "Vendor", source = "Telemancer Astrandis", acquisition = "Reach Delver's Journey Rank 5 in Season 2, then buy from Telemancer Astrandis in Silvermoon.", waypoints = TELEMANCER_ASTRANDIS_WAYPOINTS },
        ["Breath of Blight"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Master: Season 2", acquisition = "Earn 2000 Mythic+ rating during Midnight Season 2." },
        ["Breath of Ruin"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Legend: Season 2", acquisition = "Earn 3000 Mythic+ rating during Midnight Season 2." },
        ["Cerulean Deathwalker"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn the high Mythic+ seasonal rating reward choice, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Crested Aqua Leafmimic"] = { category = "Trading Post", sourceType = "Trading Post", source = "September 2026 Trading Post", acquisition = "Available from the September 2026 Trading Post for 500 Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Crested Ember Leafmimic"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "September 2026 Trading Post", acquisition = "Earned as the September 2026 Traveler's Log completion reward from the Trading Post.", waypoints = TRADING_POST_WAYPOINTS },
        ["Crested Verdant Leafmimic"] = { category = "Trading Post", sourceType = "Trading Post", source = "September 2026 Trading Post", acquisition = "Available from the September 2026 Trading Post for 500 Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Hexflame Reaver"] = { category = "Rare Drops", sourceType = "Drop", source = "Ral'kala, Prey: A Ghostly Nightmare", acquisition = "Chance to drop from Ral'kala during Curse of the Isle. Farm Ossified Relics, contribute at the Haunted Brazier for credit, and kill Ral'kala once the event completes. Group Finder Ral'kala or Haunted Brazier groups make the farm much faster.", waypoints = RALKALA_WAYPOINTS },
        ["Dusk Grimlynx"] = { category = "Quest Rewards", sourceType = "Questline", source = "Legacy of the Amani / Hagar's Invitation", acquisition = "Wowhead comments report accepting Hagar's Invitation from Orweyna in Silvermoon and progressing the Legacy of the Amani questline; comments also mention the Suggested Content tab workaround for The Preparations Are Complete.", waypoints = { "/way #2393 45.6 70.0 Orweyna" } },
        ["High-Yield Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Luminous Sporeglider"] = { category = "Dungeon and Raids", sourceType = "Drop / weekly combine", source = "Rotmire / Sporefall", acquisition = "Defeat Rotmire in Sporefall once per weekly reset to earn one Delicious Sporesnack, then combine four Delicious Sporesnacks to learn the mount. Difficulty changes gear rewards, not the four-week mount timeline.", waypoints = SPOREFALL_WAYPOINTS },
        ["Netherforged Nullframe"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Preyhunter's Fury"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Preyhunter's Journey Season 2 Rank 10, then buy from Construct V'anore with Remnant of Anguish. Prey world quests and trap farming near active Prey objectives are the steady Remnant sources.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Profit-Green Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Spawn of Vyranoth"] = { category = "Achievements", sourceType = "Achievement", source = "Master of the Turbulent Timeways V", acquisition = "Earn Master of the Turbulent Timeways V; Wowhead reward data lists Spawn of Vyranoth as the mount reward." },
        ["Speculative Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Sun Festival's Painted Roc"] = { category = "World Events", sourceType = "Holiday boss", source = "Frost Lord Ahune / Midsummer Fire Festival", acquisition = "During Midsummer Fire Festival, queue for The Frost Lord Ahune or speak to an Earthen Ring Elder at a main Midsummer camp. The first eligible Satchel of Chilled Goods each day across the Warband can contain the mount, with bad-luck protection increasing the chance after misses.", waypoints = AHUNE_WAYPOINTS },
        ["Tortured Gorger"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Venom Serpent - Green"] = { category = "Vendor", sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy the green caustic venom serpent recolor from Skull of Er'inye with Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Venom Serpent - Purple"] = { category = "Vendor", sourceType = "Vendor", source = "Second Mate Sluggs", acquisition = "Buy the purple Sea-Dwelling Isle Serpent recolor from Second Mate Sluggs after progressing Captain Tokka / Venom Trawler friendship.", waypoints = SECOND_MATE_SLUGGS_WAYPOINTS },
        ["Venomous Gladiator's Goredrake"] = { category = "PvP", sourceType = "Achievement", source = "Gladiator: Midnight Season 2", acquisition = "Win 50 3v3 arena games while at Elite rank during Midnight Season 2." },
        ["Vicious Lightbloom Boar"] = { category = "PvP", sourceType = "Achievement", source = "Venomous Combatant", acquisition = "Win rated PvP matches while at 1000+ rating during Midnight Season 2. Alliance and Horde have separate entries." },
        ["Crimson Venomfang"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Glory of the Venomous Raider", acquisition = "Complete The Venomous Abyss raid meta-achievement." },
        ["Primeval Skyfriend"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Ula'tek / The Venomous Abyss", acquisition = "Drops from Ula'tek, the final boss of The Venomous Abyss, on Mythic difficulty only.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["The Writhing Brood"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Zul'jan / Altar of Fangs", acquisition = "Drops from Zul'jan, the final boss of Altar of Fangs, on Mythic and Mythic+ difficulty.", waypoints = ALTAR_OF_FANGS_WAYPOINTS },
        ["Indigo Coiled Horror"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Jan'sari the Watchful, Zul'jarra's Forces", acquisition = "Reach Zul'jarra's Forces Renown 17, then buy from Jan'sari the Watchful.", waypoints = { "/way #2512 58.8 46.0 Jan'sari the Watchful" } },
        ["Violet-Backed Skyfang"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Jan'sari the Watchful, Zul'jarra's Forces", acquisition = "Reach Zul'jarra's Forces Renown 19, then buy from Jan'sari the Watchful.", waypoints = { "/way #2512 58.8 46.0 Jan'sari the Watchful" } },
        ["Spirit of Tok'jara"] = { category = "Quest Rewards", sourceType = "Questline", source = "Du'gal / Zul'jarra's Forces Renown 10", acquisition = "Reach Zul'jarra's Forces Renown 10, then start Du'gal's time-gated six-quest chain from Ancestral Gems through The Innocent Essence.", waypoints = { "/way #2509 50.43 63.65 Du'gal / Ancestral Gems" } },
        ["Auriferous Venomfang"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Treasures of the Coiled Isle", acquisition = "Discover the hidden treasures across the Coiled Isle." },
        ["Ruby Writhe"] = { category = "Rare Drops", sourceType = "Drop", source = "Coiled Isle rares", acquisition = "Very low chance from Coiled Isle rares. Wowhead guide notes roughly 0.3% and about a 10-minute rare respawn; loot each rare once per day per character.", waypoints = COILED_ISLE_RARE_WAYPOINTS },
        ["Topaz Skyfang"] = { category = "Rare Drops", sourceType = "Drop", source = "Coiled Isle rares", acquisition = "Very low chance from Coiled Isle rares. Wowhead guide notes roughly 0.3% and about a 10-minute rare respawn; loot each rare once per day per character.", waypoints = COILED_ISLE_RARE_WAYPOINTS },
        ["Emerald Skyfang"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Pro Poison Patroller", acquisition = "Complete 250 patrols within the Vaults of Atal'Utek." },
        ["Venomous Coiler"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Assault the Vault", acquisition = "Complete the Vaults of Atal'Utek achievement set." },
        ["Voidmancer's Starcarver"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Umbral Ashes"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Umbral Champion", acquisition = "Earn the regional top-percent Mythic+ seasonal achievement." },
        ["Caustic Venomfang"] = { category = "Vendor", sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy from Skull of Er'inye in the Vaults of Atal'Utek with Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
    },
    ["Unknown"] = {
        ["Swift Spectral Dragonhawk"] = { category = "Promotion", sourceType = "Datamined spell", source = "Wowhead spell page", acquisition = "No reliable public acquisition method is listed on the Wowhead spell page yet; track the spell/item page for future promotion, store, or event details." },
        ["Thunderhoof Celestial"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable public acquisition method was found during this scrape." },
        ["Stormgilded Celestial"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable public acquisition method was found during this scrape." },
        ["Arboreal Pseudoshell"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable acquisition steps were present in the embedded Wowhead comments during this scrape." },
        ["Cabbage Pseudoshell"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Lavender Pseudoshell"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Accented Pseudoshell"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Fantastical Goblin Waveshredder"] = { category = "Promotion", sourceType = "Unknown / promotion", source = "Wowhead item page", acquisition = "No reliable public acquisition method was found during this scrape; name/model suggest this may be a special promotion or trading-post style reward, but that is not confirmed in the scraped data." },
        ["Ghastropod"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Vicious Snapvine"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "Embedded comments were cosmetic/reaction comments only; no reliable acquisition steps were found during this scrape." },
        ["Ferocious Snapvine"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Blooded Snapvine"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Savage Snapvine"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Hypo-Speed X6000"] = { category = "Promotion", sourceType = "Unknown / promotion", source = "Wowhead item comments", acquisition = "Embedded comments only speculate about a regional/promotion source; no reliable acquisition method was found during this scrape." },
        ["Fluffy Comfy Flying Quilt"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No embedded Wowhead comments or reliable public acquisition steps were found during this scrape." },
        ["Gruffy Comfy Flying Quilt"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable acquisition steps were found during this scrape." },
        ["Comfy Bel'ameth Flying Quilt"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item comments", acquisition = "Embedded comments were cosmetic/reaction comments only; no reliable acquisition steps were found during this scrape." },
        ["Comfy Silvermoon Flying Quilt"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable acquisition steps were found during this scrape." },
        ["Fel Spirehawk"] = { category = "Promotion", sourceType = "Unknown / regional", source = "Wowhead item comments", acquisition = "Embedded comments speculate about regional availability, but no reliable acquisition method was found during this scrape." },
        ["Golden Ashened Cataclysm"] = { category = "Promotion", sourceType = "Regional promotion", source = "Wowhead item comments", acquisition = "Embedded comments describe this as datamined for China-only availability; no general-region acquisition method was found during this scrape." },
        ["[PH] Horse with Hat"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead PTR spell page", acquisition = "Placeholder spell with no reliable acquisition method found in Wowhead list data or embedded comments during this scrape." },
        ["Amani Hex Bear"] = { category = "Other", sourceType = "Unknown", source = "Wowhead PTR spell page", acquisition = "No learning item or reliable public acquisition method is exposed yet. Public comments speculate about Den of Nalorakk, but that is not confirmed, so no map pin is attached." },
        ["Autumnal Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Blushing Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Carmine Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Crested Violet Leafmimic"] = { category = "Trading Post", sourceType = "Trading Post", source = "Future Trading Post rotation", acquisition = "Listed as a Trading Post leafmimic mount. Check the monthly inventory and Outlet returns; use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Green Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined as a Trading Post rocket recolor with a placeholder name. Check future monthly inventories and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Moonlit Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Mossy Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Pink Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined as a Trading Post rocket recolor with a placeholder name. Check future monthly inventories and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Rabbit'ath"] = { category = "Promotion", sourceType = "BlizzCon 2026 Bundle", source = "Battle.net Shop", acquisition = "Included in the World of Warcraft BlizzCon 2026 Bundle and BlizzCon Ultimate Collection. This is shop/promotion delivery with no in-world map source." },
        ["Scarlet Lady"] = { category = "Promotion", sourceType = "China-only promotion / unassigned", source = "Crimson Tide Treasure event", acquisition = "Warcraft Mounts lists this appearance with the China-only Crimson Tide Treasure event/unassigned group. No general-region in-world source is available." },
        ["Scarlet Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Shadow Spirehawk"] = { category = "Promotion", sourceType = "Unknown / promotion", source = "Unassigned appearance", acquisition = "Listed as an upcoming or unassigned promotional appearance. No reliable in-world acquisition method is available yet." },
        ["Sha-Warped Owl"] = { category = "Promotion", sourceType = "China-only promotion / unassigned", source = "Crimson Tide Treasure event", acquisition = "Warcraft Mounts lists this appearance with the China-only Crimson Tide Treasure event/unassigned group. No general-region in-world source is available." },
        ["Sha-Warped Riding Wolf"] = { category = "Promotion", sourceType = "China-only promotion / unassigned", source = "Crimson Tide Treasure event", acquisition = "Warcraft Mounts lists this appearance with the China-only Crimson Tide Treasure event/unassigned group. No general-region in-world source is available." },
        ["Spring Panda"] = { category = "Promotion", sourceType = "China-only promotion / unassigned", source = "Lucky Bamboo Cards promotion", acquisition = "Warcraft Mounts lists this appearance with the China-only Lucky Bamboo Cards promotion/unassigned group. No general-region in-world source is available." },
        ["Stoneforged Sentinel"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Purchase the customizable Stoneforged Sentinel through the In-Game Shop or Battle.net Shop. This has no in-world map source." },
        ["Sunflare Driftmoth"] = { category = "In-Game Shop", sourceType = "In-Game Shop / subscription bundle", source = "Battle.net Shop", acquisition = "Listed as an In-Game Shop mount and matching promotion for Sunflicker Driftmoth. Purchase or bundle availability is handled through the shop, so there is no in-world map source." },
        ["Swift Spectral Eagle"] = { category = "Achievements", sourceType = "Achievement", source = "Legacy achievement / pending exact achievement", acquisition = "Listed by collection trackers as granted from an achievement, but the exact public achievement source is not reliable yet. Achievement rewards intentionally do not get map buttons." },
        ["The Sire's Palanquin"] = { category = "Promotion", sourceType = "China-only promotion / unassigned", source = "Crimson Tide Treasure event", acquisition = "Warcraft Mounts lists this appearance with the China-only Crimson Tide Treasure event/unassigned group. No general-region in-world source is available." },
        ["Venom Serpent - White"] = { category = "Other", sourceType = "Unknown", source = "Wowhead item page", acquisition = "No reliable public acquisition method was found during this scrape." },
        ["Whoofle Bramblewing"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Wintry Witchwick's Rider"] = { category = "In-Game Shop", sourceType = "In-Game Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as an In-Game Shop broom mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Zothwing Darkseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as a Battle.net Shop / In-Game Shop zothwing mount. Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Zothwing Deepseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Battle.net Shop / In-Game Shop", acquisition = "Listed as a Battle.net Shop / In-Game Shop zothwing mount. Purchase availability is handled through the shop, so there is no in-world map source." },
    },
}

function PatchCatalog:GetPatch(patchKey)
    return self.patches[patchKey]
end

function PatchCatalog:GetPatchKeys()
    local keys = {}
    for patchKey in pairs(self.patches) do
        keys[#keys + 1] = patchKey
    end
    table.sort(keys)
    return keys
end

function PatchCatalog:GetEntries(patchKey, collectionType)
    local patch = self:GetPatch(patchKey)
    if not patch then
        return {}
    end

    if collectionType == "achievements" then
        return patch.achievements and patch.achievements.ids or {}
    end

    return patch[collectionType] or {}
end

function PatchCatalog:GetCount(patchKey, collectionType)
    return #self:GetEntries(patchKey, collectionType)
end

function PatchCatalog:GetSummary(patchKey)
    return {
        mounts = self:GetCount(patchKey, "mounts"),
        pets = self:GetCount(patchKey, "pets"),
        toys = self:GetCount(patchKey, "toys"),
        achievements = self:GetCount(patchKey, "achievements"),
    }
end

function PatchCatalog:GetAchievementReward(patchKey, achievementId)
    local patch = self:GetPatch(patchKey)
    local highlights = patch and patch.achievements and patch.achievements.rewardHighlights
    if not highlights then
        return nil
    end

    achievementId = tonumber(achievementId)
    for _, entry in ipairs(highlights) do
        if entry.achievementId == achievementId then
            return entry
        end
    end

    return nil
end

function PatchCatalog:GetAchievementCategory(patchKey, achievementId)
    local categories = self.achievementCategories and self.achievementCategories[patchKey]
    if type(achievementId) == "table" then
        achievementId = achievementId.achievementId
    end
    achievementId = tonumber(achievementId)
    return categories and categories[achievementId] or nil
end

function PatchCatalog:GetDetailsByName(detailsTable, patchKey, entry)
    if type(entry) ~= "table" then
        return nil
    end

    local detailsByName = detailsTable and detailsTable[patchKey]
    return detailsByName and detailsByName[entry.name] or nil
end

function PatchCatalog:GetPetDetails(patchKey, entry)
    return self:GetDetailsByName(self.petDetails, patchKey, entry)
end

function PatchCatalog:GetToyDetails(patchKey, entry)
    return self:GetDetailsByName(self.toyDetails, patchKey, entry)
end

function PatchCatalog:GetSourceSummary(details)
    if not details then
        return nil
    end

    if details.sourceType and details.source then
        return details.sourceType .. ": " .. details.source
    end
    return details.source or details.sourceType
end

function PatchCatalog:GetPetSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetPetDetails(patchKey, entry))
end

function PatchCatalog:GetPetAcquisitionText(patchKey, entry)
    local details = self:GetPetDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetPetWaypoints(patchKey, entry)
    local details = self:GetPetDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetToySourceSummary(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return self:GetSourceSummary(details) or (entry and entry.source)
end

function PatchCatalog:GetToyAcquisitionText(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.acquisition or (entry and entry.acquisition)
end

function PatchCatalog:GetToyUseText(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.effect or nil
end

function PatchCatalog:GetToyWaypoints(patchKey, entry)
    local details = self:GetToyDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetMountDetails(patchKey, entry)
    return self:GetDetailsByName(self.mountDetails, patchKey, entry)
end

function PatchCatalog:GetMountCategory(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    if details and details.category then
        return details.category
    end
    return "Other"
end

function PatchCatalog:GetMountSourceSummary(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return self:GetSourceSummary(details)
end

function PatchCatalog:GetMountAcquisitionText(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetMountWaypoints(patchKey, entry)
    local details = self:GetMountDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetCollectionSourceSummary(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountSourceSummary(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetSourceSummary(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToySourceSummary(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountAcquisitionText(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetAcquisitionText(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyAcquisitionText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionUseText(collectionType, patchKey, entry)
    if collectionType == "toys" then
        return self:GetToyUseText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionWaypoints(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountWaypoints(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetWaypoints(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyWaypoints(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionDetails(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountDetails(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetDetails(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyDetails(patchKey, entry)
    end
    return nil
end

function PatchCatalog:IsAchievementSourcedCollection(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    if type(details) ~= "table" then
        return false
    end

    local sourceType = tostring(details.sourceType or ""):lower()
    local category = tostring(details.category or ""):lower()
    return sourceType:find("achievement", 1, true) ~= nil or category == "achievements"
end

function PatchCatalog:ParseWaypoint(waypoint)
    if type(waypoint) ~= "string" then
        return nil
    end

    local mapID, x, y, label = waypoint:match("^%s*/way%s+#(%d+)%s+([%d%.]+)%s+([%d%.]+)%s*(.-)%s*$")
    if not mapID then
        return nil
    end

    x = tonumber(x)
    y = tonumber(y)
    if not x or not y then
        return nil
    end

    return {
        mapID = tonumber(mapID),
        x = x / 100,
        y = y / 100,
        label = label ~= "" and label or nil,
        waypoint = waypoint,
    }
end

function PatchCatalog:GetCollectionMapPayload(collectionType, patchKey, entry, state)
    if collectionType ~= "mounts" and collectionType ~= "pets" and collectionType ~= "toys" then
        return nil
    end
    if self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then
        return nil
    end

    local sourceSummary = self:GetCollectionSourceSummary(collectionType, patchKey, entry)
    local acquisition = self:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    local effect = self:GetCollectionUseText(collectionType, patchKey, entry)
    local waypoints = self:GetCollectionWaypoints(collectionType, patchKey, entry)
    local pins = {}

    if type(waypoints) == "table" then
        for _, waypoint in ipairs(waypoints) do
            local pin = self:ParseWaypoint(waypoint)
            if pin then
                pin.icon = state and state.icon
                pin.source = sourceSummary
                pin.acquisition = acquisition
                pin.effect = effect
                pins[#pins + 1] = pin
            end
        end
    end

    if #pins == 0 then
        return nil
    end

    return {
        title = type(entry) == "table" and entry.name or nil,
        collectionType = collectionType,
        sourceSummary = sourceSummary,
        acquisition = acquisition,
        effect = effect,
        waypoints = waypoints,
        pins = pins,
        mapID = pins[1] and pins[1].mapID or nil,
        icon = state and state.icon,
    }
end

function PatchCatalog:HasCollectionMapPayload(collectionType, patchKey, entry)
    local payload = self:GetCollectionMapPayload(collectionType, patchKey, entry)
    return payload and type(payload.pins) == "table" and #payload.pins > 0
end

function PatchCatalog:GetWowheadUrl(collectionType, entry)
    if collectionType == "mounts" and entry and entry.spellId then
        return "https://www.wowhead.com/spell=" .. tostring(entry.spellId)
    elseif collectionType == "pets" and entry and entry.speciesId then
        return "https://www.wowhead.com/battle-pet=" .. tostring(entry.speciesId)
    elseif collectionType == "toys" and entry and entry.itemId then
        return "https://www.wowhead.com/item=" .. tostring(entry.itemId)
    elseif collectionType == "achievements" and entry then
        local achievementId = type(entry) == "table" and entry.achievementId or entry
        return "https://www.wowhead.com/achievement=" .. tostring(achievementId)
    end

    return nil
end

TDP.PatchCatalog = PatchCatalog
