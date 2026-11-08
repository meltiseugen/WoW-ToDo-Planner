local _, TDP = ...

-- Achievement ownership follows the activity, not the introduction of the system.
-- Classic and Burning Crusade records have moved to 1.0 and 2.0.
-- Neutral milestones and cross-expansion metas have moved to General.
local shared = {}
shared["Wrath launch achievement system"] = {
    acquisition = "Complete the achievement's exact in-game criteria.",
    source = "Wrath launch achievement system",
    sourceType = "Achievement",
    tips = "Northrend and Wrath-content achievements. Classic and Burning Crusade content is registered in 1.0 and 2.0; neutral milestones and cross-expansion metas live in General. Use the individual Retail walkthrough before committing a timed or weekly attempt.",
}

shared["Wrath heroic dungeons"] = {
    acquisition = "Complete the listed heroic-dungeon encounter mechanic or Glory of the Hero criterion.",
    source = "Wrath heroic dungeons",
    sourceType = "Achievement",
    tips = "Set Heroic and read the criterion before attacking; at high level, stop damage until required adds, debuffs, or timers register.",
}

shared["The Oculus drake challenges"] = {
    acquisition = "Defeat Ley-Guardian Eregos in the Oculus on Heroic without anyone in the party using the drake color prohibited by this achievement.",
    source = "The Oculus",
    sourceType = "Achievement",
    tips = "Check the individual color restriction before choosing an essence. These are dungeon achievements for Eregos, not raid achievements for Malygos.",
    waypoints = { "/way #114 28.6 27.5 The Oculus - upper Coldarra portal" },
}

shared["The Obsidian Sanctum"] = {
    acquisition = "Complete the listed Lava Strike avoidance or twilight-drake challenge in the original raid size.",
    source = "The Obsidian Sanctum",
    sourceType = "Achievement",
    tips = "For drake achievements, pull Sartharion while the required drakes remain alive.",
    waypoints = { "/way #115 59.8 54.6 Obsidian Sanctum below Wyrmrest Temple" },
}

shared["Wrath mount collection"] = {
    acquisition = "Learn, buy, or earn the mount named by the achievement.",
    source = "Wrath mount collection",
    sourceType = "Achievement",
    tips = "Check the named mount's vendor, reputation or raid-drop requirements, then use its reins to learn it.",
}

shared["Dalaran fountain coins"] = {
    acquisition = "Fish the required copper, silver, or gold coins from the Dalaran fountain.",
    source = "Dalaran fountain coins",
    sourceType = "Achievement",
    tips = "Use the original Northrend Dalaran fountain. Loot each named coin for credit and throw back a gold coin to maintain Lucky; duplicates do not fill missing names.",
    waypoints = { "/way #125 52.5 66.2 Dalaran fountain" },
}

shared["Naxxramas"] = {
    acquisition = "Complete the listed Naxxramas boss checklist or encounter mechanic in the original raid size.",
    source = "Naxxramas",
    sourceType = "Achievement",
    tips = "Select 10 or 25 players outside the instance. Read the individual mechanic before attacking; several achievements require keeping worshippers, spores or abominations alive.",
    waypoints = { "/way #115 87.3 50.9 Naxxramas entrance" },
}

TDP.CatalogRegistry:RegisterCollection("3.0", "achievements", {
    entries = {
        ids = {
            33, -- Nothing Boring About Borean
            34, -- I've Toured the Fjord
            35, -- Might of Dragonblight
            36, -- The Empire of Zul'Drak
            37, -- Fo' Grizzle My Shizzle
            38, -- The Summit of Storm Peaks
            39, -- Into the Basin
            40, -- Icecrown: The Final Goal
            41, -- Loremaster of Northrend
            45, -- Northrend Explorer
            125, -- Northrend Cook
            130, -- Northrend Fisherman
            137, -- Stocking Up
            141, -- Ultimate Triage
            477, -- Utgarde Keep
            478, -- The Nexus
            479, -- The Culling of Stratholme
            480, -- Azjol-Nerub
            481, -- Ahn'kahet: The Old Kingdom
            482, -- Drak'Tharon Keep
            483, -- The Violet Hold
            484, -- Gundrak
            485, -- Halls of Stone
            486, -- Halls of Lightning
            487, -- The Oculus
            488, -- Utgarde Pinnacle
            489, -- Heroic: Utgarde Keep
            490, -- Heroic: The Nexus
            491, -- Heroic: Azjol-Nerub
            492, -- Heroic: Ahn'kahet: The Old Kingdom
            493, -- Heroic: Drak'Tharon Keep
            494, -- Heroic: The Violet Hold
            495, -- Heroic: Gundrak
            496, -- Heroic: Halls of Stone
            497, -- Heroic: Halls of Lightning
            498, -- Heroic: The Oculus
            499, -- Heroic: Utgarde Pinnacle
            500, -- Heroic: The Culling of Stratholme
            547, -- Veteran of the Wrathgate
            561, -- D.E.H.T.A's Little P.I.T.A.
            562, -- The Arachnid Quarter (10 player)
            563, -- The Arachnid Quarter (25 player)
            564, -- The Construct Quarter (10 player)
            565, -- The Construct Quarter (25 player)
            566, -- The Plague Quarter (10 player)
            567, -- The Plague Quarter (25 player)
            568, -- The Military Quarter (10 player)
            569, -- The Military Quarter (25 player)
            572, -- Sapphiron's Demise (10 player)
            573, -- Sapphiron's Demise (25 player)
            574, -- Kel'Thuzad's Defeat (10 player)
            575, -- Kel'Thuzad's Defeat (25 player)
            576, -- The Fall of Naxxramas (10 player)
            577, -- The Fall of Naxxramas (25 player)
            578, -- The Dedicated Few (10 player)
            579, -- The Dedicated Few (25 player)
            622, -- The Spellweaver's Downfall (10 player)
            623, -- The Spellweaver's Downfall (25 player)
            624, -- Less Is More (10 player)
            625, -- Besting the Black Dragonflight (25 player)
            734, -- Professional Northrend Master
            735, -- Working In the Cold
            938, -- The Snows of Northrend
            947, -- The Argent Crusade
            949, -- Tuskarrmageddon
            950, -- Frenzyheart Tribe
            951, -- The Oracles
            952, -- Mercenary of Sholazar
            961, -- Honorary Frenzyheart
            962, -- Savior of the Oracles
            1007, -- The Wyrmrest Accord
            1008, -- The Kirin Tor
            1009, -- Knights of the Ebon Blade
            1010, -- Northrend Vanguard
            1011, -- The Winds of the North
            1012, -- The Winds of the North
            1254, -- Friend or Fowl?
            1263, -- Explore Howling Fjord
            1264, -- Explore Borean Tundra
            1265, -- Explore Dragonblight
            1266, -- Explore Grizzly Hills
            1267, -- Explore Zul'Drak
            1268, -- Explore Sholazar Basin
            1269, -- Explore Storm Peaks
            1270, -- Explore Icecrown
            1277, -- Rapid Defense
            1288, -- Northrend Dungeonmaster
            1289, -- Northrend Dungeon Hero
            1296, -- Watch Him Die
            1297, -- Hadronox Denied
            1356, -- I've Toured the Fjord
            1357, -- Fo' Grizzle My Shizzle
            1358, -- Nothing Boring About Borean
            1359, -- Might of Dragonblight
            1428, -- Mine Sweeper
            1457, -- Explore Crystalsong Forest
            1517, -- Northrend Angler
            1596, -- Guru of Drakuru
            1658, -- Champion of the Frozen Wastes
            1717, -- Wintergrasp Victory
            1718, -- Wintergrasp Veteran
            1721, -- Archavon the Stone Watcher (25 player)
            1722, -- Archavon the Stone Watcher (10 player)
            1723, -- Vehicular Gnomeslaughter
            1727, -- Leaning Tower
            1737, -- Destruction Derby
            1751, -- Didn't Stand a Chance
            1752, -- Master of Wintergrasp
            1755, -- Within Our Grasp
            1777, -- The Northrend Gourmet
            1778, -- The Northrend Gourmet
            1779, -- The Northrend Gourmet
            1780, -- Second That Emotion
            1781, -- Critter Gitter
            1782, -- Our Daily Bread
            1783, -- Our Daily Bread
            1785, -- Dinner Impossible
            1816, -- Defenseless
            1817, -- The Culling of Time
            1834, -- Lightning Struck
            1856, -- Make Quick Werk of Him (10 player)
            1857, -- Make Quick Werk of Him (25 player)
            1858, -- Arachnophobia (10 player)
            1859, -- Arachnophobia (25 player)
            1860, -- Gotta Go!
            1862, -- Volazj's Quick Demise
            1864, -- What the Eck?
            1865, -- Lockdown!
            1866, -- Good Grief
            1867, -- Timely Death
            1868, -- Make It Count
            1869, -- A Poke in the Eye (10 player)
            1870, -- A Poke in the Eye (25 player)
            1871, -- Experienced Drake Rider
            1872, -- Zombiefest!
            1873, -- Lodi Dodi We Loves the Skadi
            1874, -- You Don't Have an Eternity (10 player)
            1875, -- You Don't Have an Eternity (25 player)
            1876, -- Besting the Black Dragonflight (10 player)
            1877, -- Less Is More (25 player)
            1919, -- On The Rocks
            1956, -- Higher Learning
            1957, -- There's Gold In That There Fountain
            1958, -- I Smell A Giant Rat
            1996, -- The Safety Dance (10 player)
            1997, -- Momma Said Knock You Out (10 player)
            2016, -- Grizzled Veteran
            2017, -- Grizzled Veteran
            2036, -- Intense Cold
            2037, -- Chaos Theory
            2038, -- Respect Your Elders
            2039, -- Better Off Dred
            2040, -- Less-rabi
            2041, -- Dehydration
            2042, -- Shatter Resistant
            2043, -- The Incredible Hulk
            2044, -- Ruby Void
            2045, -- Emerald Void
            2046, -- Amber Void
            2047, -- Gonna Go When the Volcano Blows (10 player)
            2048, -- Gonna Go When the Volcano Blows (25 player)
            2049, -- Twilight Assist (10 player)
            2050, -- Twilight Duo (10 player)
            2051, -- The Twilight Zone (10 player)
            2052, -- Twilight Assist (25 player)
            2053, -- Twilight Duo (25 player)
            2054, -- The Twilight Zone (25 player)
            2056, -- Volunteer Work
            2057, -- Oh Novos!
            2058, -- Snakes. Why'd It Have To Be Snakes?
            2076, -- Armored Brown Bear
            2077, -- Wooly Mammoth
            2078, -- Traveler's Tundra Mammoth
            2080, -- Black War Mammoth
            2081, -- Grand Black War Mammoth
            2082, -- Ice Mammoth
            2083, -- Grand Ice Mammoth
            2084, -- Ring of the Kirin Tor
            2094, -- A Penny For Your Thoughts
            2095, -- Silver in the City
            2096, -- The Coin Master
            2097, -- Get to the Choppa!
            2136, -- Glory of the Hero
            2137, -- Glory of the Raider (10 player)
            2138, -- Glory of the Raider (25 player)
            2139, -- The Safety Dance (25 player)
            2140, -- Momma Said Knock You Out (25 player)
            2146, -- The Hundred Club (10 player)
            2147, -- The Hundred Club (25 player)
            2148, -- Denyin' the Scion (10 player)
            2149, -- Denyin' the Scion (25 player)
            2150, -- Split Personality
            2151, -- Consumption Junction
            2152, -- Share The Love
            2153, -- A Void Dance
            2154, -- Brann Spankin' New
            2155, -- Abuse the Ooze
            2156, -- My Girl Loves to Skadi All the Time
            2157, -- King's Bane
            2176, -- And They Would All Go Down Together (10 player)
            2177, -- And They Would All Go Down Together (25 player)
            2178, -- Shocking! (10 player)
            2179, -- Shocking! (25 player)
            2180, -- Subtraction (10 player)
            2181, -- Subtraction (25 player)
            2182, -- Spore Loser (10 player)
            2183, -- Spore Loser (25 player)
            2184, -- Just Can't Get Enough (10 player)
            2185, -- Just Can't Get Enough (25 player)
            2199, -- Wintergrasp Ranger
            2256, -- Northern Exposure
            2257, -- Frostbitten
        },
        rewardHighlights = { "Red Proto-Drake", "Kirin Tor Familiar", "Tabard of the Explorer" },
    },
    details = {
        [33] = shared["Wrath launch achievement system"],
        [34] = shared["Wrath launch achievement system"],
        [35] = shared["Wrath launch achievement system"],
        [36] = shared["Wrath launch achievement system"],
        [37] = shared["Wrath launch achievement system"],
        [38] = shared["Wrath launch achievement system"],
        [39] = shared["Wrath launch achievement system"],
        [40] = shared["Wrath launch achievement system"],
        [41] = shared["Wrath launch achievement system"],
        [45] = shared["Wrath launch achievement system"],
        [125] = {
            acquisition = "1. Visit Katherine Lee (Alliance) or Awilo Lon'gomba (Horde) in Northrend Dalaran and learn Northrend Cooking.\n2. Cook recipes that still grant Northrend skill until that expansion's skill reaches 75. Cooking from a different expansion does not advance this achievement.\n3. Use the Dalaran cooking daily rewards to buy additional Northrend recipes and Northern Spices when trainer recipes stop granting skill.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=125#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [130] = {
            acquisition = "1. Learn Northrend Fishing from Marcia Chase by the fountain in Northrend Dalaran (52.6, 65.6).\n2. Fish in Northrend waters until the Northrend Fishing skill reaches 75. Progress in Classic, Outland or Broken Isles Fishing is separate.",
            sourceType = "Achievement",
            source = "Marcia Chase",
            sourceURL = "https://www.wowhead.com/achievement=130#comments",
            waypoints = { "/way #125 52.6 65.6 Marcia Chase - Northrend Fishing and daily quests" },
        },
        [137] = {
            acquisition = "1. Learn Northrend Tailoring and the Heavy Frostweave Bandage recipe. First Aid was removed; this recipe now belongs to Tailoring.\n2. Collect or buy Frostweave Cloth, then craft Heavy Frostweave Bandages until you have created 500. Purchased finished bandages do not count.",
            sourceType = "Achievement",
            source = "Darin Goodstitch",
            sourceURL = "https://www.wowhead.com/achievement=137#comments",
            waypoints = { "/way #125 38.78 41.56 Darin Goodstitch - Northrend Tailoring" },
        },
        [141] = shared["Wrath launch achievement system"],
        [477] = shared["Wrath launch achievement system"],
        [478] = shared["Wrath launch achievement system"],
        [479] = shared["Wrath launch achievement system"],
        [480] = shared["Wrath launch achievement system"],
        [481] = shared["Wrath launch achievement system"],
        [482] = shared["Wrath launch achievement system"],
        [483] = shared["Wrath launch achievement system"],
        [484] = shared["Wrath launch achievement system"],
        [485] = shared["Wrath launch achievement system"],
        [486] = shared["Wrath launch achievement system"],
        [487] = shared["Wrath launch achievement system"],
        [488] = shared["Wrath launch achievement system"],
        [489] = shared["Wrath launch achievement system"],
        [490] = shared["Wrath launch achievement system"],
        [491] = shared["Wrath launch achievement system"],
        [492] = shared["Wrath launch achievement system"],
        [493] = shared["Wrath launch achievement system"],
        [494] = shared["Wrath launch achievement system"],
        [495] = shared["Wrath launch achievement system"],
        [496] = shared["Wrath launch achievement system"],
        [497] = shared["Wrath launch achievement system"],
        [498] = shared["Wrath launch achievement system"],
        [499] = shared["Wrath launch achievement system"],
        [500] = shared["Wrath launch achievement system"],
        [547] = shared["Wrath launch achievement system"],
        [561] = shared["Wrath launch achievement system"],
        [562] = shared["Wrath launch achievement system"],
        [563] = shared["Wrath launch achievement system"],
        [564] = shared["Wrath launch achievement system"],
        [565] = shared["Wrath launch achievement system"],
        [566] = shared["Wrath launch achievement system"],
        [567] = shared["Wrath launch achievement system"],
        [568] = shared["Wrath launch achievement system"],
        [569] = shared["Wrath launch achievement system"],
        [572] = shared["Wrath launch achievement system"],
        [573] = shared["Wrath launch achievement system"],
        [574] = shared["Wrath launch achievement system"],
        [575] = shared["Wrath launch achievement system"],
        [576] = shared["Wrath launch achievement system"],
        [577] = shared["Wrath launch achievement system"],
        [578] = shared["Wrath launch achievement system"],
        [579] = shared["Wrath launch achievement system"],
        [622] = shared["Wrath launch achievement system"],
        [623] = shared["Wrath launch achievement system"],
        [624] = shared["Wrath launch achievement system"],
        [625] = shared["Wrath launch achievement system"],
        [734] = shared["Wrath launch achievement system"],
        [735] = shared["Wrath launch achievement system"],
        [938] = shared["Wrath launch achievement system"],
        [947] = shared["Wrath launch achievement system"],
        [949] = shared["Wrath launch achievement system"],
        [950] = shared["Wrath launch achievement system"],
        [951] = shared["Wrath launch achievement system"],
        [952] = shared["Wrath launch achievement system"],
        [961] = shared["Wrath launch achievement system"],
        [962] = shared["Wrath launch achievement system"],
        [1007] = shared["Wrath launch achievement system"],
        [1008] = shared["Wrath launch achievement system"],
        [1009] = shared["Wrath launch achievement system"],
        [1010] = shared["Wrath launch achievement system"],
        [1011] = shared["Wrath launch achievement system"],
        [1012] = shared["Wrath launch achievement system"],
        [1254] = {
            acquisition = "1. Go to the Fjord Turkey packs beside the road west of Explorer's League Outpost, Howling Fjord (69, 64).\n2. Bind /target Fjord Turkey and a quick damaging ability to convenient keys. Start where you can see several living turkeys.\n3. Kill 15 Fjord Turkeys within three minutes, moving along the road and using respawns when needed. Pilgrim's Bounty turkeys do not count.",
            sourceType = "Achievement",
            source = "Fjord Turkeys",
            sourceURL = "https://www.wowhead.com/achievement=1254#comments",
            waypoints = { "/way #117 69.0 64.0 Fjord Turkeys - west of Explorer's League Outpost" },
        },
        [1263] = shared["Wrath launch achievement system"],
        [1264] = shared["Wrath launch achievement system"],
        [1265] = shared["Wrath launch achievement system"],
        [1266] = shared["Wrath launch achievement system"],
        [1267] = shared["Wrath launch achievement system"],
        [1268] = shared["Wrath launch achievement system"],
        [1269] = shared["Wrath launch achievement system"],
        [1270] = shared["Wrath launch achievement system"],
        [1277] = shared["Wrath launch achievement system"],
        [1288] = shared["Wrath launch achievement system"],
        [1289] = shared["Wrath launch achievement system"],
        [1296] = shared["Wrath launch achievement system"],
        [1297] = shared["Wrath launch achievement system"],
        [1356] = shared["Wrath launch achievement system"],
        [1357] = shared["Wrath launch achievement system"],
        [1358] = shared["Wrath launch achievement system"],
        [1359] = shared["Wrath launch achievement system"],
        [1428] = shared["Wrath launch achievement system"],
        [1457] = shared["Wrath launch achievement system"],
        [1517] = shared["Wrath launch achievement system"],
        [1596] = shared["Wrath launch achievement system"],
        [1658] = shared["Wrath launch achievement system"],
        [1717] = shared["Wrath launch achievement system"],
        [1718] = shared["Wrath launch achievement system"],
        [1721] = shared["Wrath launch achievement system"],
        [1722] = shared["Wrath launch achievement system"],
        [1723] = shared["Wrath launch achievement system"],
        [1727] = shared["Wrath launch achievement system"],
        [1737] = shared["Wrath launch achievement system"],
        [1751] = shared["Wrath launch achievement system"],
        [1752] = shared["Wrath launch achievement system"],
        [1755] = shared["Wrath launch achievement system"],
        [1777] = {
            acquisition = "1. Learn Northrend Cooking and start with the recipes taught by Katherine Lee or Awilo Lon'gomba in Northrend Dalaran.\n2. Complete their cooking dailies for awards, then buy missing recipes and Northern Spices from the nearby recipe vendors. Learn Northern Stew through a Northrend starter-zone cooking quest and collect other quest recipes as needed.\n3. Personally cook 15 different recipes from this achievement's checklist. Track missing dishes as you work; buying or eating somebody else's cooking does not count.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1777#comments",
        },
        [1778] = {
            acquisition = "1. Learn Northrend Cooking and start with the recipes taught by Katherine Lee or Awilo Lon'gomba in Northrend Dalaran.\n2. Complete their cooking dailies for awards, then buy missing recipes and Northern Spices from the nearby recipe vendors. Learn Northern Stew through a Northrend starter-zone cooking quest and collect other quest recipes as needed.\n3. Personally cook 30 different recipes from this achievement's checklist. Track missing dishes as you work; buying or eating somebody else's cooking does not count.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1778#comments",
        },
        [1779] = {
            acquisition = "1. Learn Northrend Cooking and start with the recipes taught by Katherine Lee or Awilo Lon'gomba in Northrend Dalaran.\n2. Complete their cooking dailies for awards, then buy missing recipes and Northern Spices from the nearby recipe vendors. Learn Northern Stew through a Northrend starter-zone cooking quest and collect other quest recipes as needed.\n3. Personally cook 45 different recipes from this achievement's checklist. Track missing dishes as you work; buying or eating somebody else's cooking does not count.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1779#comments",
        },
        [1780] = shared["Wrath launch achievement system"],
        [1781] = {
            acquisition = "1. Cook or buy at least ten Critter Bites before travelling to the Fjord Turkey packs in Howling Fjord (69, 64).\n2. Find ten separate living critters close together. Target each one and use a Critter Bite, moving quickly between them.\n3. Coerce ten critters within three minutes. Feed the turkeys before killing them if you also want Friend or Fowl? on the same visit.",
            sourceType = "Achievement",
            source = "Fjord Turkeys",
            sourceURL = "https://www.wowhead.com/achievement=1781#comments",
            waypoints = { "/way #117 69.0 64.0 Fjord Turkeys - west of Explorer's League Outpost" },
        },
        [1782] = shared["Wrath launch achievement system"],
        [1783] = shared["Wrath launch achievement system"],
        [1785] = shared["Wrath launch achievement system"],
        [1816] = shared["Wrath launch achievement system"],
        [1817] = shared["Wrath launch achievement system"],
        [1834] = shared["Wrath launch achievement system"],
        [1856] = shared["Wrath launch achievement system"],
        [1857] = shared["Wrath launch achievement system"],
        [1858] = shared["Wrath launch achievement system"],
        [1859] = shared["Wrath launch achievement system"],
        [1860] = shared["Wrath launch achievement system"],
        [1862] = shared["Wrath launch achievement system"],
        [1864] = shared["Wrath launch achievement system"],
        [1865] = shared["Wrath launch achievement system"],
        [1866] = shared["Wrath launch achievement system"],
        [1867] = shared["Wrath launch achievement system"],
        [1868] = shared["Wrath launch achievement system"],
        [1869] = shared["Wrath launch achievement system"],
        [1870] = shared["Wrath launch achievement system"],
        [1871] = shared["Wrath launch achievement system"],
        [1872] = shared["Wrath launch achievement system"],
        [1873] = shared["Wrath launch achievement system"],
        [1874] = shared["Wrath launch achievement system"],
        [1875] = shared["Wrath launch achievement system"],
        [1876] = shared["Wrath launch achievement system"],
        [1877] = shared["Wrath launch achievement system"],
        [1919] = shared["Wrath launch achievement system"],
        [1956] = shared["Wrath launch achievement system"],
        [1957] = shared["Wrath launch achievement system"],
        [1958] = shared["Wrath launch achievement system"],
        [1996] = shared["Wrath launch achievement system"],
        [1997] = shared["Wrath launch achievement system"],
        [2016] = shared["Wrath launch achievement system"],
        [2017] = shared["Wrath launch achievement system"],
        [2036] = shared["Wrath heroic dungeons"],
        [2037] = shared["Wrath heroic dungeons"],
        [2038] = shared["Wrath heroic dungeons"],
        [2039] = shared["Wrath heroic dungeons"],
        [2040] = shared["Wrath heroic dungeons"],
        [2041] = shared["Wrath heroic dungeons"],
        [2042] = shared["Wrath heroic dungeons"],
        [2043] = shared["Wrath heroic dungeons"],
        [2044] = shared["The Oculus drake challenges"],
        [2045] = shared["The Oculus drake challenges"],
        [2046] = shared["The Oculus drake challenges"],
        [2047] = shared["The Obsidian Sanctum"],
        [2048] = shared["The Obsidian Sanctum"],
        [2049] = shared["The Obsidian Sanctum"],
        [2050] = shared["The Obsidian Sanctum"],
        [2051] = shared["The Obsidian Sanctum"],
        [2052] = shared["The Obsidian Sanctum"],
        [2053] = shared["The Obsidian Sanctum"],
        [2054] = shared["The Obsidian Sanctum"],
        [2056] = shared["Wrath heroic dungeons"],
        [2057] = shared["Wrath heroic dungeons"],
        [2058] = shared["Wrath heroic dungeons"],
        [2076] = shared["Wrath mount collection"],
        [2077] = shared["Wrath mount collection"],
        [2078] = shared["Wrath mount collection"],
        [2080] = shared["Wrath mount collection"],
        [2081] = shared["Wrath mount collection"],
        [2082] = shared["Wrath mount collection"],
        [2083] = shared["Wrath mount collection"],
        [2084] = shared["Wrath launch achievement system"],
        [2094] = shared["Dalaran fountain coins"],
        [2095] = shared["Dalaran fountain coins"],
        [2096] = shared["Dalaran fountain coins"],
        [2097] = {
            acquisition = "1. Obtain a Mekgineer's Chopper for Alliance or Mechano-hog for Horde. You can buy the finished mount from an engineer or the auction house; Engineering is not required to use it.\n2. To craft one yourself, learn its schematic with Northrend Engineering and Exalted Alliance Vanguard or Horde Expedition reputation. Gather Titansteel Bars, Cobalt Bolts and Arctic Fur.\n3. The engineer buys the specialized motorcycle parts from Roxi Ramrocket in K3, Storm Peaks (40.6, 84.8), then crafts the mount.\n4. Use the finished mount item to learn it. Older comments claiming that crafting or mailing it alone grants achievement credit are outdated.",
            sourceType = "Achievement",
            source = "Roxi Ramrocket",
            sourceURL = "https://www.wowhead.com/achievement=2097#comments",
            waypoints = { "/way #120 40.6 84.8 Roxi Ramrocket - motorcycle crafting components" },
        },
        [2136] = shared["Wrath heroic dungeons"],
        [2137] = shared["Naxxramas"],
        [2138] = shared["Naxxramas"],
        [2139] = shared["Naxxramas"],
        [2140] = shared["Naxxramas"],
        [2146] = shared["Naxxramas"],
        [2147] = shared["Naxxramas"],
        [2148] = shared["Naxxramas"],
        [2149] = shared["Naxxramas"],
        [2150] = shared["Wrath heroic dungeons"],
        [2151] = shared["Wrath heroic dungeons"],
        [2152] = shared["Wrath heroic dungeons"],
        [2153] = shared["Wrath heroic dungeons"],
        [2154] = shared["Wrath heroic dungeons"],
        [2155] = shared["Wrath heroic dungeons"],
        [2156] = shared["Wrath heroic dungeons"],
        [2157] = shared["Wrath heroic dungeons"],
        [2176] = shared["Naxxramas"],
        [2177] = shared["Naxxramas"],
        [2178] = shared["Naxxramas"],
        [2179] = shared["Naxxramas"],
        [2180] = shared["Naxxramas"],
        [2181] = shared["Naxxramas"],
        [2182] = shared["Naxxramas"],
        [2183] = shared["Naxxramas"],
        [2184] = shared["Naxxramas"],
        [2185] = shared["Naxxramas"],
        [2199] = shared["Wrath launch achievement system"],
        [2256] = shared["Wrath launch achievement system"],
        [2257] = shared["Wrath launch achievement system"],
    },
    categories = {
        [33] = "Legacy and Wrath Launch",
        [34] = "Legacy and Wrath Launch",
        [35] = "Legacy and Wrath Launch",
        [36] = "Legacy and Wrath Launch",
        [37] = "Legacy and Wrath Launch",
        [38] = "Legacy and Wrath Launch",
        [39] = "Legacy and Wrath Launch",
        [40] = "Legacy and Wrath Launch",
        [41] = "Legacy and Wrath Launch",
        [45] = "Legacy and Wrath Launch",
        [125] = "Legacy and Wrath Launch",
        [130] = "Legacy and Wrath Launch",
        [137] = "Legacy and Wrath Launch",
        [141] = "Legacy and Wrath Launch",
        [477] = "Legacy and Wrath Launch",
        [478] = "Legacy and Wrath Launch",
        [479] = "Legacy and Wrath Launch",
        [480] = "Legacy and Wrath Launch",
        [481] = "Legacy and Wrath Launch",
        [482] = "Legacy and Wrath Launch",
        [483] = "Legacy and Wrath Launch",
        [484] = "Legacy and Wrath Launch",
        [485] = "Legacy and Wrath Launch",
        [486] = "Legacy and Wrath Launch",
        [487] = "Legacy and Wrath Launch",
        [488] = "Legacy and Wrath Launch",
        [489] = "Legacy and Wrath Launch",
        [490] = "Legacy and Wrath Launch",
        [491] = "Legacy and Wrath Launch",
        [492] = "Legacy and Wrath Launch",
        [493] = "Legacy and Wrath Launch",
        [494] = "Legacy and Wrath Launch",
        [495] = "Legacy and Wrath Launch",
        [496] = "Legacy and Wrath Launch",
        [497] = "Legacy and Wrath Launch",
        [498] = "Legacy and Wrath Launch",
        [499] = "Legacy and Wrath Launch",
        [500] = "Legacy and Wrath Launch",
        [547] = "Legacy and Wrath Launch",
        [561] = "Legacy and Wrath Launch",
        [562] = "Legacy and Wrath Launch",
        [563] = "Legacy and Wrath Launch",
        [564] = "Legacy and Wrath Launch",
        [565] = "Legacy and Wrath Launch",
        [566] = "Legacy and Wrath Launch",
        [567] = "Legacy and Wrath Launch",
        [568] = "Legacy and Wrath Launch",
        [569] = "Legacy and Wrath Launch",
        [572] = "Legacy and Wrath Launch",
        [573] = "Legacy and Wrath Launch",
        [574] = "Legacy and Wrath Launch",
        [575] = "Legacy and Wrath Launch",
        [576] = "Legacy and Wrath Launch",
        [577] = "Legacy and Wrath Launch",
        [578] = "Legacy and Wrath Launch",
        [579] = "Legacy and Wrath Launch",
        [622] = "Legacy and Wrath Launch",
        [623] = "Legacy and Wrath Launch",
        [624] = "Legacy and Wrath Launch",
        [625] = "Legacy and Wrath Launch",
        [734] = "Legacy and Wrath Launch",
        [735] = "Legacy and Wrath Launch",
        [938] = "Legacy and Wrath Launch",
        [947] = "Legacy and Wrath Launch",
        [949] = "Legacy and Wrath Launch",
        [950] = "Legacy and Wrath Launch",
        [951] = "Legacy and Wrath Launch",
        [952] = "Legacy and Wrath Launch",
        [961] = "Legacy and Wrath Launch",
        [962] = "Legacy and Wrath Launch",
        [1007] = "Legacy and Wrath Launch",
        [1008] = "Legacy and Wrath Launch",
        [1009] = "Legacy and Wrath Launch",
        [1010] = "Legacy and Wrath Launch",
        [1011] = "Legacy and Wrath Launch",
        [1012] = "Legacy and Wrath Launch",
        [1254] = "Legacy and Wrath Launch",
        [1263] = "Legacy and Wrath Launch",
        [1264] = "Legacy and Wrath Launch",
        [1265] = "Legacy and Wrath Launch",
        [1266] = "Legacy and Wrath Launch",
        [1267] = "Legacy and Wrath Launch",
        [1268] = "Legacy and Wrath Launch",
        [1269] = "Legacy and Wrath Launch",
        [1270] = "Legacy and Wrath Launch",
        [1277] = "Legacy and Wrath Launch",
        [1288] = "Legacy and Wrath Launch",
        [1289] = "Legacy and Wrath Launch",
        [1296] = "Legacy and Wrath Launch",
        [1297] = "Legacy and Wrath Launch",
        [1356] = "Legacy and Wrath Launch",
        [1357] = "Legacy and Wrath Launch",
        [1358] = "Legacy and Wrath Launch",
        [1359] = "Legacy and Wrath Launch",
        [1428] = "Legacy and Wrath Launch",
        [1457] = "Legacy and Wrath Launch",
        [1517] = "Legacy and Wrath Launch",
        [1596] = "Legacy and Wrath Launch",
        [1658] = "Legacy and Wrath Launch",
        [1717] = "Legacy and Wrath Launch",
        [1718] = "Legacy and Wrath Launch",
        [1721] = "Legacy and Wrath Launch",
        [1722] = "Legacy and Wrath Launch",
        [1723] = "Legacy and Wrath Launch",
        [1727] = "Legacy and Wrath Launch",
        [1737] = "Legacy and Wrath Launch",
        [1751] = "Legacy and Wrath Launch",
        [1752] = "Legacy and Wrath Launch",
        [1755] = "Legacy and Wrath Launch",
        [1777] = "Legacy and Wrath Launch",
        [1778] = "Legacy and Wrath Launch",
        [1779] = "Legacy and Wrath Launch",
        [1780] = "Legacy and Wrath Launch",
        [1781] = "Legacy and Wrath Launch",
        [1782] = "Legacy and Wrath Launch",
        [1783] = "Legacy and Wrath Launch",
        [1785] = "Legacy and Wrath Launch",
        [1816] = "Legacy and Wrath Launch",
        [1817] = "Legacy and Wrath Launch",
        [1834] = "Legacy and Wrath Launch",
        [1856] = "Legacy and Wrath Launch",
        [1857] = "Legacy and Wrath Launch",
        [1858] = "Legacy and Wrath Launch",
        [1859] = "Legacy and Wrath Launch",
        [1860] = "Legacy and Wrath Launch",
        [1862] = "Legacy and Wrath Launch",
        [1864] = "Legacy and Wrath Launch",
        [1865] = "Legacy and Wrath Launch",
        [1866] = "Legacy and Wrath Launch",
        [1867] = "Legacy and Wrath Launch",
        [1868] = "Legacy and Wrath Launch",
        [1869] = "Legacy and Wrath Launch",
        [1870] = "Legacy and Wrath Launch",
        [1871] = "Legacy and Wrath Launch",
        [1872] = "Legacy and Wrath Launch",
        [1873] = "Legacy and Wrath Launch",
        [1874] = "Legacy and Wrath Launch",
        [1875] = "Legacy and Wrath Launch",
        [1876] = "Legacy and Wrath Launch",
        [1877] = "Legacy and Wrath Launch",
        [1919] = "Legacy and Wrath Launch",
        [1956] = "Legacy and Wrath Launch",
        [1957] = "Legacy and Wrath Launch",
        [1958] = "Legacy and Wrath Launch",
        [1996] = "Legacy and Wrath Launch",
        [1997] = "Legacy and Wrath Launch",
        [2016] = "Legacy and Wrath Launch",
        [2017] = "Legacy and Wrath Launch",
        [2036] = "Dungeons",
        [2037] = "Dungeons",
        [2038] = "Dungeons",
        [2039] = "Dungeons",
        [2040] = "Dungeons",
        [2041] = "Dungeons",
        [2042] = "Dungeons",
        [2043] = "Dungeons",
        [2044] = "Dungeons",
        [2045] = "Dungeons",
        [2046] = "Dungeons",
        [2047] = "Raids",
        [2048] = "Raids",
        [2049] = "Raids",
        [2050] = "Raids",
        [2051] = "Raids",
        [2052] = "Raids",
        [2053] = "Raids",
        [2054] = "Raids",
        [2056] = "Dungeons",
        [2057] = "Dungeons",
        [2058] = "Dungeons",
        [2076] = "Collections",
        [2077] = "Collections",
        [2078] = "Collections",
        [2080] = "Collections",
        [2081] = "Collections",
        [2082] = "Collections",
        [2083] = "Collections",
        [2084] = "Legacy and Wrath Launch",
        [2094] = "Fishing",
        [2095] = "Fishing",
        [2096] = "Fishing",
        [2097] = "Collections",
        [2136] = "Dungeons",
        [2137] = "Raids",
        [2138] = "Raids",
        [2139] = "Raids",
        [2140] = "Raids",
        [2146] = "Raids",
        [2147] = "Raids",
        [2148] = "Raids",
        [2149] = "Raids",
        [2150] = "Dungeons",
        [2151] = "Dungeons",
        [2152] = "Dungeons",
        [2153] = "Dungeons",
        [2154] = "Dungeons",
        [2155] = "Dungeons",
        [2156] = "Dungeons",
        [2157] = "Dungeons",
        [2176] = "Raids",
        [2177] = "Raids",
        [2178] = "Raids",
        [2179] = "Raids",
        [2180] = "Raids",
        [2181] = "Raids",
        [2182] = "Raids",
        [2183] = "Raids",
        [2184] = "Raids",
        [2185] = "Raids",
        [2199] = "Legacy and Wrath Launch",
        [2256] = "Legacy and Wrath Launch",
        [2257] = "Legacy and Wrath Launch",
    },
})
