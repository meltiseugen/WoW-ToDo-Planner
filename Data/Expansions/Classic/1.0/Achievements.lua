local _, TDP = ...

-- Content ownership was reviewed by achievement ID, name and criteria.
-- Name/criteria reference: https://wago.tools/db2/Achievement/csv
-- Retroactive Classic-content achievements live in 1.0 even when the
-- achievement record was introduced in 3.x. Neutral milestones live in General.
-- Permanently unavailable achievements are excluded from this catalogue.
-- Restored Retail sources are retained even when their achievements are Legacy.
TDP.CatalogRegistry:RegisterCollection("1.0", "achievements", {
    entries = {
        ids = {
            42, -- Eastern Kingdoms Explorer
            43, -- Kalimdor Explorer
            73, -- Disgracin' The Basin
            116, -- Professional Journeyman
            121, -- Journeyman Cook
            122, -- Expert Cook
            123, -- Classic Cook
            126, -- Journeyman Fisherman
            127, -- Expert Fisherman
            128, -- Artisan Fisherman
            150, -- The Fishing Diplomat
            154, -- Arathi Basin Victory
            155, -- Arathi Basin Veteran
            156, -- Territorial Dominance
            157, -- To The Rescue!
            158, -- Me and the Cappin' Makin' It Happen
            159, -- Let's Get This Done
            161, -- Resilient Victory
            162, -- We Had It All Along *cough*
            165, -- Arathi Basin Perfection
            166, -- Warsong Gulch Victory
            167, -- Warsong Gulch Veteran
            168, -- Warsong Gulch Perfection
            199, -- Capture the Flag
            200, -- Persistent Defender
            201, -- Warsong Expedience
            202, -- Quick Cap
            203, -- Not In My House
            204, -- Ironman
            206, -- Supreme Defender
            207, -- Save the Day
            218, -- Alterac Valley Victory
            219, -- Alterac Valley Veteran
            220, -- Stormpike Perfection
            221, -- Alterac Grave Robber
            222, -- Tower Defense
            223, -- The Sickly Gazelle
            224, -- Loyal Defender
            225, -- Everything Counts
            226, -- The Alterac Blitz
            306, -- Master Angler of Azeroth
            389, -- Gurubashi Arena Master
            396, -- Gurubashi Arena Grand Master
            424, -- Why? Because It's Red
            428, -- Thunderfury, Blessed Blade of the Windseeker
            429, -- Sulfuras, Hand of Ragnaros
            582, -- Alterac Valley All-Star
            583, -- Arathi Basin All-Star
            584, -- Arathi Basin Assassin
            611, -- Bleeding Bloodhoof
            616, -- Overthrow the Council
            627, -- Explore Dun Morogh
            628, -- Deadmines
            629, -- Ragefire Chasm
            630, -- Wailing Caverns
            631, -- Shadowfang Keep
            632, -- Blackfathom Deeps
            633, -- Stormwind Stockade
            634, -- Gnomeregan
            635, -- Razorfen Kraul
            636, -- Razorfen Downs
            637, -- Scarlet Monastery
            638, -- Uldaman
            639, -- Zul'Farrak
            640, -- Maraudon
            641, -- Sunken Temple
            642, -- Blackrock Depths
            643, -- Lower Blackrock Spire
            644, -- King of Dire Maul
            645, -- Scholomance
            646, -- Stratholme
            685, -- Blackwing Lair
            686, -- Molten Core
            687, -- Temple of Ahn'Qiraj
            689, -- Ruins of Ahn'Qiraj
            706, -- Frostwolf Howler
            707, -- Stormpike Battle Charger
            708, -- Hero of the Frostwolf Clan
            709, -- Hero of the Stormpike Guard
            710, -- The Defiler
            711, -- Knight of Arathor
            712, -- Warsong Outrider
            713, -- Silverwing Sentinel
            714, -- The Conqueror
            728, -- Explore Durotar
            729, -- Deathcharger's Reins
            731, -- Professional Expert
            732, -- Professional Classic Master
            736, -- Explore Mulgore
            750, -- Explore Northern Barrens
            761, -- Explore Arathi Highlands
            765, -- Explore Badlands
            766, -- Explore Blasted Lands
            768, -- Explore Tirisfal Glades
            769, -- Explore Silverpine Forest
            770, -- Explore Western Plaguelands
            771, -- Explore Eastern Plaguelands
            772, -- Explore Hillsbrad Foothills
            773, -- Explore The Hinterlands
            774, -- Explore Searing Gorge
            775, -- Explore Burning Steppes
            776, -- Explore Elwynn Forest
            777, -- Explore Deadwind Pass
            778, -- Explore Duskwood
            779, -- Explore Loch Modan
            780, -- Explore Redridge Mountains
            781, -- Explore Northern Stranglethorn
            782, -- Explore Swamp of Sorrows
            802, -- Explore Westfall
            841, -- Explore Wetlands
            842, -- Explore Teldrassil
            844, -- Explore Darkshore
            845, -- Explore Ashenvale
            846, -- Explore Thousand Needles
            847, -- Explore Stonetalon Mountains
            848, -- Explore Desolace
            849, -- Explore Feralas
            850, -- Explore Dustwallow Marsh
            851, -- Explore Tanaris
            852, -- Explore Azshara
            853, -- Explore Felwood
            854, -- Explore Un'Goro Crater
            855, -- Explore Moonglade
            856, -- Explore Silithus
            857, -- Explore Winterspring
            871, -- Avast Ye, Admiral!
            872, -- Frenzied Defender
            873, -- Frostwolf Perfection
            880, -- Swift Zulian Tiger
            881, -- Swift Razzashi Raptor
            907, -- The Justicar
            940, -- The Green Hills of Stranglethorn
            944, -- They Love Me In That Tunnel
            946, -- The Argent Dawn
            955, -- Hydraxian Waterlords
            956, -- Brood of Nozdormu
            957, -- Hero of the Zandalar Tribe
            1151, -- Loyal Defender
            1153, -- Overly Defensive
            1164, -- Everything Counts
            1166, -- To the Looter Go the Spoils
            1167, -- Master of Alterac Valley
            1169, -- Master of Arathi Basin
            1172, -- Master of Warsong Gulch
            1244, -- Well Read
            1251, -- Not In My House
            1252, -- Supreme Defender
            1259, -- Not So Fast
            1283, -- Classic Dungeonmaster
            1285, -- Classic Raider
            1502, -- Quick Cap
            1676, -- Loremaster of Eastern Kingdoms
            1678, -- Loremaster of Kalimdor
            1836, -- Old Crafty
            1837, -- Old Ironjaw
            2336, -- Insane in the Membrane
            3356, -- Winterspring Frostsaber
            3357, -- Venomhide Ravasaur
        },
        rewardHighlights = {},
    },
    details = {
        [42] = {
            name = "Eastern Kingdoms Explorer",
            acquisition = "Explore the regions of Eastern Kingdoms.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=42",
        },
        [43] = {
            name = "Kalimdor Explorer",
            acquisition = "Explore the regions of Kalimdor.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=43",
        },
        [73] = {
            name = "Disgracin' The Basin",
            acquisition = "Assault 3 bases in a single Arathi Basin battle.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=73",
        },
        [116] = {
            name = "Professional Journeyman",
            acquisition = "Obtain 150 skill points in a \"Classic\" category of a primary profession.",
            source = "Classic professions",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=116",
        },
        [121] = {
            acquisition = "1. Visit Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6) to train Classic Cooking.\n2. Cook Classic recipes that still grant skill, learning higher recipes as needed, until Classic Cooking reaches 150.\n3. Check the Classic skill bar specifically. Skill gained in a later expansion's Cooking category does not count for this milestone.",
            sourceType = "Achievement",
            source = "Stephen Ryback / Zamja",
            sourceURL = "https://www.wowhead.com/achievement=121#comments",
            waypoints = { "/way #84 76.8 53.6 Stephen Ryback - Alliance Classic Cooking", "/way #85 32.2 69.6 Zamja - Horde Classic Cooking" },
        },
        [122] = {
            acquisition = "1. Visit Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6) to train Classic Cooking.\n2. Cook Classic recipes that still grant skill, learning higher recipes as needed, until Classic Cooking reaches 225.\n3. Check the Classic skill bar specifically. Skill gained in a later expansion's Cooking category does not count for this milestone.",
            sourceType = "Achievement",
            source = "Stephen Ryback / Zamja",
            sourceURL = "https://www.wowhead.com/achievement=122#comments",
            waypoints = { "/way #84 76.8 53.6 Stephen Ryback - Alliance Classic Cooking", "/way #85 32.2 69.6 Zamja - Horde Classic Cooking" },
        },
        [123] = {
            acquisition = "1. Visit Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6) to train Classic Cooking.\n2. Cook Classic recipes that still grant skill, learning higher recipes as needed, until Classic Cooking reaches 300.\n3. Check the Classic skill bar specifically. Skill gained in a later expansion's Cooking category does not count for this milestone.",
            sourceType = "Achievement",
            source = "Stephen Ryback / Zamja",
            sourceURL = "https://www.wowhead.com/achievement=123#comments",
            waypoints = { "/way #84 76.8 53.6 Stephen Ryback - Alliance Classic Cooking", "/way #85 32.2 69.6 Zamja - Horde Classic Cooking" },
        },
        [126] = {
            acquisition = "1. Learn Classic Fishing from Arnold Leland in Stormwind (55.0, 69.6) or Lumak in Orgrimmar (66.6, 41.6).\n2. Fish in Classic waters until the Classic Fishing skill reaches 150. Cast, wait for the bobber's bite and loot each catch.\n3. The map marks the trainers as starting points. Fishing skill in Northrend, Outland or another expansion is tracked separately.",
            sourceType = "Achievement",
            source = "Arnold Leland / Lumak",
            sourceURL = "https://www.wowhead.com/achievement=126#comments",
            waypoints = { "/way #84 55.0 69.6 Arnold Leland - Alliance Classic Fishing", "/way #85 66.6 41.6 Lumak - Horde Classic Fishing" },
        },
        [127] = {
            acquisition = "1. Learn Classic Fishing from Arnold Leland in Stormwind (55.0, 69.6) or Lumak in Orgrimmar (66.6, 41.6).\n2. Fish in Classic waters until the Classic Fishing skill reaches 225. Cast, wait for the bobber's bite and loot each catch.\n3. The map marks the trainers as starting points. Fishing skill in Northrend, Outland or another expansion is tracked separately.",
            sourceType = "Achievement",
            source = "Arnold Leland / Lumak",
            sourceURL = "https://www.wowhead.com/achievement=127#comments",
            waypoints = { "/way #84 55.0 69.6 Arnold Leland - Alliance Classic Fishing", "/way #85 66.6 41.6 Lumak - Horde Classic Fishing" },
        },
        [128] = {
            acquisition = "1. Learn Classic Fishing from Arnold Leland in Stormwind (55.0, 69.6) or Lumak in Orgrimmar (66.6, 41.6).\n2. Fish in Classic waters until the Classic Fishing skill reaches 300. Cast, wait for the bobber's bite and loot each catch.\n3. The map marks the trainers as starting points. Fishing skill in Northrend, Outland or another expansion is tracked separately.",
            sourceType = "Achievement",
            source = "Arnold Leland / Lumak",
            sourceURL = "https://www.wowhead.com/achievement=128#comments",
            waypoints = { "/way #84 55.0 69.6 Arnold Leland - Alliance Classic Fishing", "/way #85 66.6 41.6 Lumak - Horde Classic Fishing" },
        },
        [150] = {
            name = "The Fishing Diplomat",
            acquisition = "Fish something up in Orgrimmar and Stormwind.",
            source = "Classic fishing",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=150",
        },
        [154] = {
            name = "Arathi Basin Victory",
            acquisition = "Win Arathi Basin.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=154",
        },
        [155] = {
            name = "Arathi Basin Veteran",
            acquisition = "Complete 100 victories in Arathi Basin.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=155",
        },
        [156] = {
            name = "Territorial Dominance",
            acquisition = "Win 10 Arathi Basin matches while controlling all 5 flags.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=156",
        },
        [157] = {
            name = "To The Rescue!",
            acquisition = "Come to the defense of a base in Arathi Basin 50 times by recapping the flag.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=157",
        },
        [158] = {
            name = "Me and the Cappin' Makin' It Happen",
            acquisition = "Take 50 flags in Arathi Basin.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=158",
        },
        [159] = {
            name = "Let's Get This Done",
            acquisition = "Win Arathi Basin in 6 minutes.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=159",
        },
        [161] = {
            name = "Resilient Victory",
            acquisition = "Overcome a 500 resource disadvantage in a match of Arathi Basin and claim victory.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=161",
        },
        [162] = {
            name = "We Had It All Along *cough*",
            acquisition = "Win Arathi Basin by 50 points or less.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=162",
        },
        [165] = {
            name = "Arathi Basin Perfection",
            acquisition = "Win Arathi Basin with a score of 1500 to 0.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=165",
        },
        [166] = {
            name = "Warsong Gulch Victory",
            acquisition = "Win Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=166",
        },
        [167] = {
            name = "Warsong Gulch Veteran",
            acquisition = "Complete 100 victories in Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=167",
        },
        [168] = {
            name = "Warsong Gulch Perfection",
            acquisition = "Win Warsong Gulch with a score of 3 to 0.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=168",
        },
        [199] = {
            name = "Capture the Flag",
            acquisition = "Personally carry and capture the flag in Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=199",
        },
        [200] = {
            name = "Persistent Defender",
            acquisition = "Return 50 flags as a defender in Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=200",
        },
        [201] = {
            name = "Warsong Expedience",
            acquisition = "Win Warsong Gulch in under 7 minutes.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=201",
        },
        [202] = {
            name = "Quick Cap",
            acquisition = "Grab the flag and capture it in under 75 seconds.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=202",
        },
        [203] = {
            name = "Not In My House",
            acquisition = "In a single Warsong Gulch battle, kill 2 flag carriers before they leave the Silverwing Flag Room.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=203",
        },
        [204] = {
            name = "Ironman",
            acquisition = "In a single Warsong Gulch battle, carry and capture the flag 3 times without dying.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=204",
        },
        [206] = {
            name = "Supreme Defender",
            acquisition = "Kill 100 flag carriers in Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=206",
        },
        [207] = {
            name = "Save the Day",
            acquisition = "Kill the enemy who is carrying your flag in the opposing team's flag room while the opposing team's flag is at their base, within their control.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=207",
        },
        [218] = {
            name = "Alterac Valley Victory",
            acquisition = "Win Alterac Valley.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=218",
        },
        [219] = {
            name = "Alterac Valley Veteran",
            acquisition = "Complete 100 victories in Alterac Valley.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=219",
        },
        [220] = {
            name = "Stormpike Perfection",
            acquisition = "Win Alterac Valley without losing a tower or captain. You must also control all of the Horde's towers.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=220",
        },
        [221] = {
            name = "Alterac Grave Robber",
            acquisition = "Take 50 graveyards in Alterac Valley.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=221",
        },
        [222] = {
            name = "Tower Defense",
            acquisition = "Defend 50 towers in Alterac Valley.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=222",
        },
        [223] = {
            name = "The Sickly Gazelle",
            acquisition = "In Alterac Valley, kill an enemy in the Field of Strife before they dismount.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=223",
        },
        [224] = {
            name = "Loyal Defender",
            acquisition = "In Alterac Valley, kill 50 enemy players in the Hall of the Frostwolf.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=224",
        },
        [225] = {
            name = "Everything Counts",
            acquisition = "Win Alterac Valley while your team controls both mines.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=225",
        },
        [226] = {
            name = "The Alterac Blitz",
            acquisition = "Win Alterac Valley in 6 minutes.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=226",
        },
        [306] = {
            name = "Master Angler of Azeroth",
            acquisition = "Win the Booty Bay fishing contest.",
            source = "Classic fishing",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=306",
        },
        [389] = {
            name = "Gurubashi Arena Master",
            acquisition = "Loot the Arena Master trinket from the Gurubashi Arena.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=389",
        },
        [396] = {
            name = "Gurubashi Arena Grand Master",
            acquisition = "Complete Short John Mithril's quest to obtain the Arena Grand Master trinket.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=396",
        },
        [424] = {
            name = "Why? Because It's Red",
            acquisition = "Obtain a Red Qiraji Resonating Crystal.",
            source = "Classic collections",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=424",
        },
        [428] = {
            name = "Thunderfury, Blessed Blade of the Windseeker",
            acquisition = "Wielder of Thunderfury, Blessed Blade of the Windseeker.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=428",
        },
        [429] = {
            name = "Sulfuras, Hand of Ragnaros",
            acquisition = "Wielder of Sulfuras, Hand of Ragnaros.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=429",
        },
        [582] = {
            name = "Alterac Valley All-Star",
            acquisition = "In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=582",
        },
        [583] = {
            name = "Arathi Basin All-Star",
            acquisition = "Assault and Defend 2 bases in a single Arathi Basin match.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=583",
        },
        [584] = {
            name = "Arathi Basin Assassin",
            acquisition = "Get five honorable kills at each of the bases in a single Arathi Basin battle.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=584",
        },
        [611] = {
            name = "Bleeding Bloodhoof",
            acquisition = "Kill Baine Bloodhoof.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=611",
        },
        [616] = {
            name = "Overthrow the Council",
            acquisition = "Kill Representatives Moira Thaurissan, Muradin Bronzebeard and Falstad Wildhammer.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=616",
        },
        [627] = {
            name = "Explore Dun Morogh",
            acquisition = "Explore Dun Morogh, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=627",
        },
        [628] = {
            name = "Deadmines",
            acquisition = "Defeat \"Captain\" Cookie.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=628",
        },
        [629] = {
            name = "Ragefire Chasm",
            acquisition = "Defeat Lava Guard Gordoth.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=629",
        },
        [630] = {
            name = "Wailing Caverns",
            acquisition = "Defeat Mutanus the Devourer.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=630",
        },
        [631] = {
            name = "Shadowfang Keep",
            acquisition = "Defeat Lord Godfrey.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=631",
        },
        [632] = {
            name = "Blackfathom Deeps",
            acquisition = "Defeat Aku'mai.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=632",
        },
        [633] = {
            name = "Stormwind Stockade",
            acquisition = "Defeat Hogger.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=633",
        },
        [634] = {
            name = "Gnomeregan",
            acquisition = "Defeat Mekgineer Thermaplugg.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=634",
        },
        [635] = {
            name = "Razorfen Kraul",
            acquisition = "Defeat Charlga Razorflank.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=635",
        },
        [636] = {
            name = "Razorfen Downs",
            acquisition = "Defeat Amnennar the Coldbringer.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=636",
        },
        [637] = {
            name = "Scarlet Monastery",
            acquisition = "Defeat High Inquisitor Whitemane in Scarlet Monastery.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=637",
        },
        [638] = {
            name = "Uldaman",
            acquisition = "Defeat Archaedas.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=638",
        },
        [639] = {
            name = "Zul'Farrak",
            acquisition = "Defeat Chief Ukorz Sandscalp.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=639",
        },
        [640] = {
            name = "Maraudon",
            acquisition = "Defeat Princess Theradras.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=640",
        },
        [641] = {
            name = "Sunken Temple",
            acquisition = "Defeat Shade of Eranikus.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=641",
        },
        [642] = {
            name = "Blackrock Depths",
            acquisition = "Defeat Emperor Dagran Thaurissan.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=642",
        },
        [643] = {
            name = "Lower Blackrock Spire",
            acquisition = "Defeat Overlord Wyrmthalak.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=643",
        },
        [644] = {
            name = "King of Dire Maul",
            acquisition = "Defeat each wing of Dire Maul.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=644",
        },
        [645] = {
            name = "Scholomance",
            acquisition = "Defeat Darkmaster Gandling.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=645",
        },
        [646] = {
            name = "Stratholme",
            acquisition = "Defeat the evil masterminds inhabiting Stratholme.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=646",
        },
        [685] = {
            name = "Blackwing Lair",
            acquisition = "Defeat Nefarian.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=685",
        },
        [686] = {
            name = "Molten Core",
            acquisition = "Defeat Ragnaros.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=686",
        },
        [687] = {
            name = "Temple of Ahn'Qiraj",
            acquisition = "Defeat C'Thun.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=687",
        },
        [689] = {
            name = "Ruins of Ahn'Qiraj",
            acquisition = "Defeat Ossirian the Unscarred.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=689",
        },
        [706] = {
            name = "Frostwolf Howler",
            acquisition = "Obtain a Frostwolf Howler.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=706",
        },
        [707] = {
            name = "Stormpike Battle Charger",
            acquisition = "Obtain a Stormpike Battle Charger.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=707",
        },
        [708] = {
            name = "Hero of the Frostwolf Clan",
            acquisition = "Gain exalted reputation with the Frostwolf Clan.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=708",
        },
        [709] = {
            name = "Hero of the Stormpike Guard",
            acquisition = "Gain exalted reputation with the Stormpike Guard.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=709",
        },
        [710] = {
            name = "The Defiler",
            acquisition = "Gain exalted reputation with The Forsaken Defilers.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=710",
        },
        [711] = {
            name = "Knight of Arathor",
            acquisition = "Gain exalted reputation with The League of Arathor.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=711",
        },
        [712] = {
            name = "Warsong Outrider",
            acquisition = "Gain exalted reputation with the Warsong Outriders.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=712",
        },
        [713] = {
            name = "Silverwing Sentinel",
            acquisition = "Gain exalted reputation with the Silverwing Sentinels.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=713",
        },
        [714] = {
            name = "The Conqueror",
            acquisition = "Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=714",
        },
        [728] = {
            name = "Explore Durotar",
            acquisition = "Explore Durotar, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=728",
        },
        [729] = {
            name = "Deathcharger's Reins",
            acquisition = "Obtain the Deathcharger's Reins from Rivendare in Stratholme.",
            source = "Classic collections",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=729",
        },
        [731] = {
            name = "Professional Expert",
            acquisition = "Obtain 225 skill points in a \"Classic\" category of a primary profession.",
            source = "Classic professions",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=731",
        },
        [732] = {
            name = "Professional Classic Master",
            acquisition = "Obtain 300 skill points in a \"Classic\" category of a primary profession.",
            source = "Classic professions",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=732",
        },
        [736] = {
            name = "Explore Mulgore",
            acquisition = "Explore Mulgore, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=736",
        },
        [750] = {
            name = "Explore Northern Barrens",
            acquisition = "Explore The Barrens, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=750",
        },
        [761] = {
            name = "Explore Arathi Highlands",
            acquisition = "Explore Arathi Highlands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=761",
        },
        [765] = {
            name = "Explore Badlands",
            acquisition = "Explore Badlands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=765",
        },
        [766] = {
            name = "Explore Blasted Lands",
            acquisition = "Explore Blasted Lands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=766",
        },
        [768] = {
            name = "Explore Tirisfal Glades",
            acquisition = "Explore Tirisfal Glades, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=768",
        },
        [769] = {
            name = "Explore Silverpine Forest",
            acquisition = "Explore Silverpine Forest, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=769",
        },
        [770] = {
            name = "Explore Western Plaguelands",
            acquisition = "Explore Western Plaguelands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=770",
        },
        [771] = {
            name = "Explore Eastern Plaguelands",
            acquisition = "Explore Eastern Plaguelands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=771",
        },
        [772] = {
            name = "Explore Hillsbrad Foothills",
            acquisition = "Explore Hillsbrad Foothills, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=772",
        },
        [773] = {
            name = "Explore The Hinterlands",
            acquisition = "Explore The Hinterlands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=773",
        },
        [774] = {
            name = "Explore Searing Gorge",
            acquisition = "Explore Searing Gorge, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=774",
        },
        [775] = {
            name = "Explore Burning Steppes",
            acquisition = "Explore Burning Steppes, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=775",
        },
        [776] = {
            name = "Explore Elwynn Forest",
            acquisition = "Explore Elwynn Forest, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=776",
        },
        [777] = {
            name = "Explore Deadwind Pass",
            acquisition = "Explore Deadwind Pass, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=777",
        },
        [778] = {
            name = "Explore Duskwood",
            acquisition = "Explore Duskwood, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=778",
        },
        [779] = {
            name = "Explore Loch Modan",
            acquisition = "Explore Loch Modan, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=779",
        },
        [780] = {
            name = "Explore Redridge Mountains",
            acquisition = "Explore Redridge Mountains, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=780",
        },
        [781] = {
            name = "Explore Northern Stranglethorn",
            acquisition = "Explore Northern Stranglethorn, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=781",
        },
        [782] = {
            name = "Explore Swamp of Sorrows",
            acquisition = "Explore Swamp of Sorrows, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=782",
        },
        [802] = {
            name = "Explore Westfall",
            acquisition = "Explore Westfall, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=802",
        },
        [841] = {
            name = "Explore Wetlands",
            acquisition = "Explore Wetlands, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=841",
        },
        [842] = {
            name = "Explore Teldrassil",
            acquisition = "Explore Teldrassil, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=842",
        },
        [844] = {
            name = "Explore Darkshore",
            acquisition = "Explore Darkshore, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=844",
        },
        [845] = {
            name = "Explore Ashenvale",
            acquisition = "Explore Ashenvale, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=845",
        },
        [846] = {
            name = "Explore Thousand Needles",
            acquisition = "Explore Thousand Needles, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=846",
        },
        [847] = {
            name = "Explore Stonetalon Mountains",
            acquisition = "Explore Stonetalon Mountains, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=847",
        },
        [848] = {
            name = "Explore Desolace",
            acquisition = "Explore Desolace, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=848",
        },
        [849] = {
            name = "Explore Feralas",
            acquisition = "Explore Feralas, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=849",
        },
        [850] = {
            name = "Explore Dustwallow Marsh",
            acquisition = "Explore Dustwallow Marsh, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=850",
        },
        [851] = {
            name = "Explore Tanaris",
            acquisition = "Explore Tanaris, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=851",
        },
        [852] = {
            name = "Explore Azshara",
            acquisition = "Explore Azshara, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=852",
        },
        [853] = {
            name = "Explore Felwood",
            acquisition = "Explore Felwood, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=853",
        },
        [854] = {
            name = "Explore Un'Goro Crater",
            acquisition = "Explore Un'Goro Crater, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=854",
        },
        [855] = {
            name = "Explore Moonglade",
            acquisition = "Explore Moonglade, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=855",
        },
        [856] = {
            name = "Explore Silithus",
            acquisition = "Explore Silithus, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=856",
        },
        [857] = {
            name = "Explore Winterspring",
            acquisition = "Explore Winterspring, revealing the covered areas of the world map.",
            source = "Classic exploration",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=857",
        },
        [871] = {
            name = "Avast Ye, Admiral!",
            acquisition = "Obtain the Bloodsail Admiral's Hat... and try to get some fresh air every now and then.",
            source = "Classic reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=871",
        },
        [872] = {
            name = "Frenzied Defender",
            acquisition = "Return 5 flags in a single Warsong Gulch battle.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=872",
        },
        [873] = {
            name = "Frostwolf Perfection",
            acquisition = "Win Alterac Valley without losing a tower or captain. You must also control all of the Alliance's towers.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=873",
        },
        [880] = {
            name = "Swift Zulian Tiger",
            acquisition = "Obtain the Swift Zulian Tiger from High Priest Thekal in Zul'Gurub.",
            source = "Classic collections",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=880",
        },
        [881] = {
            name = "Swift Razzashi Raptor",
            acquisition = "Obtain the Swift Razzashi Raptor from Bloodlord Mandokir in Zul'Gurub.",
            source = "Classic collections",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=881",
        },
        [907] = {
            name = "The Justicar",
            acquisition = "Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=907",
        },
        [940] = {
            name = "The Green Hills of Stranglethorn",
            acquisition = "Complete all of Hemet Nesingwary quests in Stranglethorn Vale up to and including Big Game Hunter.",
            source = "Classic quests",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=940",
        },
        [944] = {
            name = "They Love Me In That Tunnel",
            acquisition = "Earn Exalted status with Timbermaw Hold.",
            source = "Classic reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=944",
        },
        [946] = {
            name = "The Argent Dawn",
            acquisition = "Earn Exalted status with the Argent Dawn.",
            source = "Classic reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=946",
        },
        [955] = {
            name = "Hydraxian Waterlords",
            acquisition = "Earn Exalted status with the Hydraxian Waterlords.",
            source = "Classic reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=955",
        },
        [956] = {
            name = "Brood of Nozdormu",
            acquisition = "Earn Exalted status with the Brood of Nozdormu.",
            source = "Classic reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=956",
        },
        [957] = {
            name = "Hero of the Zandalar Tribe",
            acquisition = "Earn exalted status with the Zandalar Tribe.",
            source = "Zandalar Tribe reputation",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=957",
        },
        [1151] = {
            name = "Loyal Defender",
            acquisition = "In Alterac Valley, kill 50 enemy players in the Hall of the Stormpike.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1151",
        },
        [1153] = {
            name = "Overly Defensive",
            acquisition = "Defend 3 bases in a single Arathi Basin battle.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1153",
        },
        [1164] = {
            name = "Everything Counts",
            acquisition = "Win Alterac Valley while your team controls both mines.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1164",
        },
        [1166] = {
            name = "To the Looter Go the Spoils",
            acquisition = "Loot the Autographed Picture of Tigule in Alterac Valley.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1166",
        },
        [1167] = {
            name = "Master of Alterac Valley",
            acquisition = "Complete the Alterac Valley achievements listed below.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1167",
        },
        [1169] = {
            name = "Master of Arathi Basin",
            acquisition = "Complete the Arathi Basin achievements listed below.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1169",
        },
        [1172] = {
            name = "Master of Warsong Gulch",
            acquisition = "Complete the Warsong Gulch achievements listed below.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1172",
        },
        [1244] = {
            acquisition = "1. Track the unread titles in the achievement checklist and visit their original book objects in libraries, inns and dungeons.\n2. Click each original book to open and read it, then check that its title is credited before moving on. A later reprint with the same title may not count.\n3. Use the mapped book-source areas to plan your trip. Place names inside a book title describe its subject, not necessarily where that book is located.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1244#comments",
        },
        [1251] = {
            name = "Not In My House",
            acquisition = "In a single Warsong Gulch battle, kill 2 flag carriers before they leave the Warsong Flag Room.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1251",
        },
        [1252] = {
            name = "Supreme Defender",
            acquisition = "Kill 100 flag carriers in Warsong Gulch.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1252",
        },
        [1259] = {
            name = "Not So Fast",
            acquisition = "In Warsong Gulch, kill a player who is under the effects of the speed power-up.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1259",
        },
        [1283] = {
            name = "Classic Dungeonmaster",
            acquisition = "Complete the classic dungeon achievements listed below.",
            source = "Classic dungeons",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1283",
        },
        [1285] = {
            name = "Classic Raider",
            acquisition = "Complete the classic raid achievements listed below.",
            source = "Classic raids",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1285",
        },
        [1502] = {
            name = "Quick Cap",
            acquisition = "Grab the flag and capture it in under 75 seconds.",
            source = "Classic pvp",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1502",
        },
        [1676] = {
            name = "Loremaster of Eastern Kingdoms",
            acquisition = "Complete the Eastern Kingdoms quest achievements listed below.",
            source = "Classic quests",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1676",
        },
        [1678] = {
            name = "Loremaster of Kalimdor",
            acquisition = "Complete the Kalimdor quest achievements listed below.",
            source = "Classic quests",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1678",
        },
        [1836] = {
            name = "Old Crafty",
            acquisition = "Fish up Old Crafty in Orgrimmar.",
            source = "Classic fishing",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1836",
        },
        [1837] = {
            name = "Old Ironjaw",
            acquisition = "Fish up Old Ironjaw in Ironforge.",
            source = "Classic fishing",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1837",
        },
        [2336] = {
            acquisition = "1. Earn Honored with Bloodsail Buccaneers by killing Booty Bay guards. This lowers your Steamwheedle Cartel reputations, so do this before restoring the goblins.\n2. Farm Southsea pirates in Tanaris or on Fray Island in Northern Barrens to raise Booty Bay, Ratchet, Gadgetzan and Everlook toward Exalted without sacrificing Bloodsail reputation.\n3. For Ravenholdt, kill Syndicate enemies around Durnholde Keep in Hillsbrad until ordinary kills stop granting reputation. Then turn in Heavy Junkboxes at Ravenholdt Manor; a rogue can pickpocket the boxes for you.\n4. During Darkmoon Faire, complete its profession quests, dailies and other reputation activities until Exalted.\n5. Track all required factions on the character doing the achievement. Shen'dralar is not required. Avoid reputation turn-ins that undo your pirate progress while completing the other factions.",
            sourceType = "Achievement",
            source = "Insane in the Membrane",
            sourceURL = "https://www.wowhead.com/achievement=2336#comments",
        },
        [3356] = {
            acquisition = "Earn and learn the Winterspring Frostsaber mount.",
            source = "Winterspring Frostsaber",
            sourceType = "Achievement",
            tips = "Complete the Wintersaber Trainers reputation or modern replacement quest path in Winterspring.",
            waypoints = { "/way #83 46.6 17.6 Wintersaber Trainers" },
        },
        [3357] = {
            acquisition = "Raise a Venomhide hatchling through the Horde-only daily chain.",
            source = "Venomhide Ravasaur",
            sourceType = "Achievement",
            tips = "Keep the hatchling summoned for its daily and plan on 20 days of training.",
            waypoints = { "/way #78 71.6 73.8 Mor'vek" },
        },
    },
    categories = {
        [42] = "Exploration",
        [43] = "Exploration",
        [73] = "PvP",
        [116] = "Professions",
        [121] = "Professions",
        [122] = "Professions",
        [123] = "Professions",
        [126] = "Fishing",
        [127] = "Fishing",
        [128] = "Fishing",
        [150] = "Fishing",
        [154] = "PvP",
        [155] = "PvP",
        [156] = "PvP",
        [157] = "PvP",
        [158] = "PvP",
        [159] = "PvP",
        [161] = "PvP",
        [162] = "PvP",
        [165] = "PvP",
        [166] = "PvP",
        [167] = "PvP",
        [168] = "PvP",
        [199] = "PvP",
        [200] = "PvP",
        [201] = "PvP",
        [202] = "PvP",
        [203] = "PvP",
        [204] = "PvP",
        [206] = "PvP",
        [207] = "PvP",
        [218] = "PvP",
        [219] = "PvP",
        [220] = "PvP",
        [221] = "PvP",
        [222] = "PvP",
        [223] = "PvP",
        [224] = "PvP",
        [225] = "PvP",
        [226] = "PvP",
        [306] = "Fishing",
        [389] = "PvP",
        [396] = "PvP",
        [424] = "Collections",
        [428] = "Raids",
        [429] = "Raids",
        [582] = "PvP",
        [583] = "PvP",
        [584] = "PvP",
        [611] = "PvP",
        [616] = "PvP",
        [627] = "Exploration",
        [628] = "Dungeons",
        [629] = "Dungeons",
        [630] = "Dungeons",
        [631] = "Dungeons",
        [632] = "Dungeons",
        [633] = "Dungeons",
        [634] = "Dungeons",
        [635] = "Dungeons",
        [636] = "Dungeons",
        [637] = "Dungeons",
        [638] = "Dungeons",
        [639] = "Dungeons",
        [640] = "Dungeons",
        [641] = "Dungeons",
        [642] = "Dungeons",
        [643] = "Dungeons",
        [644] = "Dungeons",
        [645] = "Dungeons",
        [646] = "Dungeons",
        [685] = "Raids",
        [686] = "Raids",
        [687] = "Raids",
        [689] = "Raids",
        [706] = "PvP",
        [707] = "PvP",
        [708] = "PvP",
        [709] = "PvP",
        [710] = "PvP",
        [711] = "PvP",
        [712] = "PvP",
        [713] = "PvP",
        [714] = "PvP",
        [728] = "Exploration",
        [729] = "Collections",
        [731] = "Professions",
        [732] = "Professions",
        [736] = "Exploration",
        [750] = "Exploration",
        [761] = "Exploration",
        [765] = "Exploration",
        [766] = "Exploration",
        [768] = "Exploration",
        [769] = "Exploration",
        [770] = "Exploration",
        [771] = "Exploration",
        [772] = "Exploration",
        [773] = "Exploration",
        [774] = "Exploration",
        [775] = "Exploration",
        [776] = "Exploration",
        [777] = "Exploration",
        [778] = "Exploration",
        [779] = "Exploration",
        [780] = "Exploration",
        [781] = "Exploration",
        [782] = "Exploration",
        [802] = "Exploration",
        [841] = "Exploration",
        [842] = "Exploration",
        [844] = "Exploration",
        [845] = "Exploration",
        [846] = "Exploration",
        [847] = "Exploration",
        [848] = "Exploration",
        [849] = "Exploration",
        [850] = "Exploration",
        [851] = "Exploration",
        [852] = "Exploration",
        [853] = "Exploration",
        [854] = "Exploration",
        [855] = "Exploration",
        [856] = "Exploration",
        [857] = "Exploration",
        [871] = "Reputation",
        [872] = "PvP",
        [873] = "PvP",
        [880] = "Collections",
        [881] = "Collections",
        [907] = "PvP",
        [940] = "Quests",
        [944] = "Reputation",
        [946] = "Reputation",
        [955] = "Reputation",
        [956] = "Reputation",
        [957] = "Reputation",
        [1151] = "PvP",
        [1153] = "PvP",
        [1164] = "PvP",
        [1166] = "PvP",
        [1167] = "PvP",
        [1169] = "PvP",
        [1172] = "PvP",
        [1244] = "Exploration",
        [1251] = "PvP",
        [1252] = "PvP",
        [1259] = "PvP",
        [1283] = "Dungeons",
        [1285] = "Raids",
        [1502] = "PvP",
        [1676] = "Quests",
        [1678] = "Quests",
        [1836] = "Fishing",
        [1837] = "Fishing",
        [2336] = "Reputation",
        [3356] = "Collections",
        [3357] = "Collections",
    },
})
