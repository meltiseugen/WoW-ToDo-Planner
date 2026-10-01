local _, TDP = ...

local PatchCatalog = {}
local GeneratedPatchCollections = TDP.GeneratedPatchCollections or {}

local MAP_NAMES = {
    [1] = "Durotar",
    [10] = "Northern Barrens",
    [14] = "Arathi Highlands",
    [17] = "Blasted Lands",
    [18] = "Tirisfal Glades",
    [22] = "Western Plaguelands",
    [23] = "Eastern Plaguelands",
    [37] = "Elwynn Forest",
    [50] = "Northern Stranglethorn",
    [64] = "Thousand Needles",
    [71] = "Tanaris",
    [77] = "Felwood",
    [84] = "Stormwind City",
    [85] = "Orgrimmar",
    [87] = "Ironforge",
    [90] = "Undercity",
    [100] = "Hellfire Peninsula",
    [102] = "Zangarmarsh",
    [104] = "Shadowmoon Valley (Outland)",
    [105] = "Blade's Edge Mountains",
    [107] = "Nagrand (Outland)",
    [108] = "Terokkar Forest",
    [109] = "Netherstorm",
    [111] = "Shattrath City",
    [115] = "Dragonblight",
    [116] = "Grizzly Hills",
    [198] = "Mount Hyjal",
    [207] = "Deepholm",
    [2248] = "Isle of Dorn",
    [241] = "Twilight Highlands",
    [249] = "Uldum",
    [371] = "The Jade Forest",
    [376] = "Valley of the Four Winds",
    [379] = "Kun-Lai Summit",
    [388] = "Townlong Steppes",
    [390] = "Vale of Eternal Blossoms",
    [418] = "Krasarang Wilds",
    [539] = "Shadowmoon Valley (Draenor)",
    [554] = "Timeless Isle",
    [627] = "Dalaran (Broken Isles)",
    [650] = "Highmountain",
    [862] = "Zuldazar",
    [895] = "Tiragarde Sound",
    [830] = "Krokuun",
    [1519] = "Stormwind City",
    [1637] = "Orgrimmar",
    [1670] = "Oribos",
    [1960] = "The Maw",
    [1961] = "Korthia",
    [1970] = "Zereth Mortis",
    [1165] = "Dazar'alor",
    [1527] = "Uldum (Battle for Azeroth)",
    [2024] = "The Azure Span",
    [2023] = "Ohn'ahran Plains",
    [2025] = "Thaldraszus",
    [2022] = "The Waking Shores",
    [2107] = "The Forbidden Reach",
    [2112] = "Valdrakken",
    [2133] = "Zaralek Cavern",
    [2151] = "The Forbidden Reach",
    [2200] = "Emerald Dream",
    [2239] = "Amirdrassil",
    [2254] = "Barrows of Reverie",
    [2213] = "City of Threads (Umbral Bazaar)",
    [2214] = "The Ringing Deeps",
    [2215] = "Hallowfall",
    [2216] = "City of Threads",
    [2255] = "Azj-Kahet",
    [2256] = "City of Threads",
    [2339] = "Dornogal",
    [2369] = "Siren Isle",
    [2375] = "Siren Isle (Seafury Tempest)",
    [2346] = "Undermine",
    [2403] = "Horrific Vision of Orgrimmar",
    [2404] = "Horrific Vision of Stormwind",
    [2371] = "K'aresh",
    [2472] = "Tazavesh, the Veiled Market",
    [2393] = "Silvermoon City",
    [2395] = "Eversong Woods",
    [2405] = "Voidstorm",
    [2413] = "Harandar",
    [2424] = "Isle of Quel'Danas",
    [2437] = "Zul'Aman",
    [2444] = "Slayer's Rise",
    [2509] = "Vaults of Atal'Utek",
    [2535] = "Atal'Aman",
    [2536] = "Atal'Aman",
    [2512] = "The Coiled Isle",
    [2576] = "The Blinding Vale",
    [2585] = "Broken Throne",
    [2594] = "Ritual Site",
    [2599] = "Val",
    [2600] = "Naigtal",
    [2613] = "The Underbelly",
    [2621] = "Forgotten Depths",
    [2635] = "Gnarldor Isle",
    [2636] = "Vault of Restless Bones",
    [2642] = "Tomb of the Forgotten Priest",
    [2646] = "Vilaldoun Crypt",
}

local SILVERMOON_DELVES_WAYPOINTS = {
    "/way #2393 52.4 78.6 Telemancer Astrandis / Delver's Headquarters",
    "/way #2393 52.6 78.6 Naleidea Rivergleam / Delver's Headquarters",
}

local SILVERMOON_COURT_WAYPOINTS = {
    "/way #2395 43.4 47.4 Caeris Fairdawn / Silvermoon Court rewards",
}

local AMANI_TRIBE_WAYPOINTS = {
    "/way #2437 45.8 65.8 Magovu / Amani Tribe rewards",
}

local HARATI_WAYPOINTS = {
    "/way #2413 51.0 50.8 Naynar / Hara'ti rewards",
}

local SINGULARITY_WAYPOINTS = {
    "/way #2405 52.6 72.8 Void Researcher Anomander / The Singularity rewards",
}

local SLAYERS_DUELLUM_WAYPOINTS = {
    "/way #2444 39.2 81.0 Thraxadar / Slayer's Duellum rewards",
}

local ABUNDANCE_WAYPOINTS = {
    "/way #2395 56.78 65.79 Eversong Woods / Abundance entrance",
    "/way #2437 31.62 26.14 Zul'Aman / Loaknit Den entrance",
    "/way #2413 66.14 61.69 Harandar / Floaret Grotto entrance",
    "/way #2405 38.82 53.31 Voidstorm / Abundant Voidburrow entrance",
}

local MIDNIGHT_DELVE_DROP_WAYPOINTS = {
    "/way #2424 46.8 40.9 Parhelion Plaza delve entrance",
    "/way #2395 45.5 86.0 The Shadow Enclave delve entrance",
    "/way #2395 63.7 80.1 Atal'Aman delve entrance",
    "/way #2393 40.6 53.7 Collegiate Calamity delve entrance",
    "/way #2393 39.3 31.7 The Darkway delve entrance",
    "/way #2437 25.4 84.4 Twilight Crypts delve entrance",
    "/way #2413 36.7 49.6 The Gulf of Memory delve entrance",
    "/way #2413 70.4 64.8 The Grudge Pit delve entrance",
    "/way #2405 37.1 49.1 Shadowguard Point delve entrance",
    "/way #2405 54.8 47.1 Sunkiller Sanctum delve entrance",
    "/way #2393 52.4 78.6 Telemancer Astrandis / one-time surprise bag",
}

local TWILIGHT_ASCENSION_WAYPOINTS = {
    "/way #241 49.6 81.2 Materialist Ophinell / Twilight Ascension rewards",
}

local ATAL_AMAN_QUEST_WAYPOINTS = {
    "/way #2437 45.7 65.3 Zul'jarra / Bloodstains questline",
    "/way #2536 34.4 25.5 Lynx Loa avatar / In Their Own Blood",
}

local EVERSONG_RARE_WAYPOINTS = {
    "/way #2395 51.84 74.07 Warden of Weeds",
    "/way #2395 45.20 79.15 Harried Hawkstrider",
    "/way #2395 54.66 60.76 Overfester Hydra",
    "/way #2395 36.48 63.81 Bloated Snapdragon",
    "/way #2395 63.05 49.85 Cre'van / patrol area",
    "/way #2395 36.55 36.24 Coralfang",
    "/way #2395 36.62 77.32 Lady Liminus",
    "/way #2395 40.17 85.32 Terrinor",
    "/way #2395 48.99 87.79 Bad Zed / inside the building",
    "/way #2395 34.85 20.91 Waverly / click Lovely Sunflower",
    "/way #2395 56.40 77.12 Banuran",
    "/way #2395 59.33 79.26 Lost Guardian",
    "/way #2395 42.58 69.27 Duskburn / patrol area",
    "/way #2395 51.73 45.70 Malfunctioning Construct",
    "/way #2395 45.62 38.78 Dame Bloodshed / patrol area",
}

local ZULAMAN_RARE_WAYPOINTS = {
    "/way #2437 34.42 33.07 Necrohexxer Raz'ka",
    "/way #2437 51.45 18.44 The Snapping Scourge",
    "/way #2437 51.82 72.88 Skullcrusher Harak",
    "/way #2437 28.73 23.97 Lightwood Borer",
    "/way #2437 50.80 65.19 Mrrlokk",
    "/way #2437 39.01 50.02 Poacher Rav'ik",
    "/way #2437 30.65 45.07 Spinefrill / underwater",
    "/way #2437 46.43 51.90 Oophaga / cave entrance",
    "/way #2437 47.88 34.21 Tiny Vermin",
    "/way #2437 21.27 70.64 Voidtouched Crustacean",
    "/way #2437 39.49 20.11 The Devouring Invader / cave entrance",
    "/way #2437 33.69 88.98 Elder Oaktalon",
    "/way #2437 47.76 20.97 Depthborn Eelamental",
    "/way #2437 46.69 43.45 The Decaying Diamondback",
    "/way #2437 45.11 41.48 Asha the Empowered",
}

local ZULAMAN_TREASURE_WAYPOINTS = {
    "/way #2437 46.83 81.86 Honored Warrior's Cache / start and turn in",
    "/way #2437 32.67 83.51 Nalorakk's Chosen / Honored Warrior's Cache",
    "/way #2437 34.56 33.46 Halazzi's Chosen / Honored Warrior's Cache",
    "/way #2437 54.75 22.39 Jan'alai's Chosen / Honored Warrior's Cache",
    "/way #2437 51.55 84.88 Akil'zon's Chosen / Honored Warrior's Cache",
    "/way #2437 20.84 66.54 Bait and Tackle",
    "/way #2437 52.33 65.99 Mrruk's Mangy Trove",
    "/way #2437 42.64 52.44 Abandoned Nest",
    "/way #2437 26.10 80.68 Puzzle 1 / Sealed Twilight Blade Bounty",
    "/way #2437 23.98 78.89 Puzzle 2 / Sealed Twilight Blade Bounty",
    "/way #2437 24.05 75.68 Puzzle 3 / Sealed Twilight Blade Bounty",
    "/way #2437 26.10 74.06 Puzzle 4 / Sealed Twilight Blade Bounty",
    "/way #2437 21.89 77.38 Sealed Twilight Blade Bounty",
    "/way #2437 41.99 47.78 Burrow Bounty",
    "/way #2437 40.48 35.96 Secret Formula",
}

local ZULAMAN_TREASURE_CRITERIA = {
    1, 1, 1, 1, 1,
    2, 3, 4,
    5, 5, 5, 5, 5,
    6, 7,
}

local HARANDAR_RARE_WAYPOINTS = {
    "/way #2413 51.17 45.34 Rhazul",
    "/way #2413 68.66 39.04 Chironex / patrol area",
    "/way #2413 69.03 59.95 Ha'kalawe / patrol area",
    "/way #2413 72.64 69.34 Tallcap the Truthspreader",
    "/way #2413 59.86 47.02 Queen Lashtongue",
    "/way #2413 64.43 47.52 Chlorokyll",
    "/way #2413 65.77 32.86 Stumpy",
    "/way #2413 56.82 34.09 Serrasa / pond patrol",
    "/way #2413 45.61 29.69 Mindrot / patrol area",
    "/way #2413 40.65 43.13 Dracaena",
    "/way #2413 36.56 74.83 Treetop",
    "/way #2413 28.10 81.83 Oro'ohna",
    "/way #2413 27.38 71.39 Pterrock / cave entrance",
    "/way #2413 39.66 60.76 Ahl'ua'huhi",
    "/way #2413 44.42 15.99 Annulus the Worldshaker / patrol",
}

local HARANDAR_TREASURE_WAYPOINTS = {
    "/way #2413 71.69 31.04 Failed Shroom Jumper's Satchel",
    "/way #2413 73.63 65.29 Sporelord's Fight Prize",
    "/way #2413 55.69 39.43 Kemet's Simmering Cauldron",
    "/way #2413 27.51 67.97 Impenetrably Sealed Gourd",
    "/way #2413 40.61 27.99 Peculiar Cauldron",
    "/way #2413 47.00 50.33 Burning Branch of the World Tree",
    "/way #2413 62.92 51.17 Reliquary's Lost Paintbrush",
    "/way #2413 51.15 58.56 Altar of Wisdom / Gift of the Cycle",
    "/way #2413 51.42 56.01 A Rolled-Up Pillow / Gift of the Cycle",
    "/way #2413 47.18 53.14 Altar of Vigor / Gift of the Cycle",
    "/way #2413 45.14 54.12 A Lost Hunting Knife / Gift of the Cycle",
    "/way #2413 51.14 47.48 Altar of Innocence / Gift of the Cycle",
    "/way #2413 51.10 50.49 A Tattered Ball / Gift of the Cycle",
    "/way #2413 47.30 51.00 Gift of the Cycle",
    "/way #2413 41.30 67.90 Fungal Mallet / Sporespawned Cache",
    "/way #2413 46.60 67.80 Sporespawned Cache",
}

local HARANDAR_TREASURE_CRITERIA = {
    1, 2, 3, 4, 5, 6, 7,
    8, 8, 8, 8, 8, 8, 8,
    9, 9,
}

local VOIDSTORM_RARE_WAYPOINTS = {
    "/way #2405 29.52 50.05 Sundereth the Caller",
    "/way #2405 34.12 82.13 Territorial Voidscythe",
    "/way #2405 35.68 81.16 Tremora / cave entrance",
    "/way #2405 43.69 51.48 Screammaxa the Matriarch",
    "/way #2405 47.16 79.77 Bane of the Vilebloods / cave entrance",
    "/way #2405 39.49 64.61 Aeonelle Blackstar / cave entrance",
    "/way #2405 37.88 71.79 Lotus Darkblossom",
    "/way #2405 55.70 79.47 Queen o' War / click Crown of the Lost Queen",
    "/way #2405 48.81 53.00 Ravengerus",
    "/way #2444 46.36 40.96 Rakshur the Bonegrinder",
    "/way #2405 35.62 49.37 Bilemaw / cave entrance",
    "/way #2444 41.03 89.14 Eruundi / Master's Perch patrol",
    "/way #2405 40.19 41.40 Nightbrood",
    "/way #2405 53.96 62.73 Far'thana the Mad",
}

local MIDNIGHT_GLYPH_WAYPOINTS = {
    "/way #2393 48.05 6.12 The Shining Span Skyriding Glyph",
    "/way #2395 58.96 19.50 Silvermoon City Skyriding Glyph",
    "/way #2395 49.47 48.03 Path of Dawn Skyriding Glyph",
    "/way #2395 62.63 62.78 Dawnstar Spire Skyriding Glyph",
    "/way #2395 33.43 65.36 Daggerspine Point Skyriding Glyph",
    "/way #2395 43.26 46.36 Fairbreeze Village Skyriding Glyph",
    "/way #2395 65.14 32.57 Brightwing Estate Skyriding Glyph",
    "/way #2395 39.93 59.79 Goldenmist Village Skyriding Glyph",
    "/way #2395 39.35 45.55 Sunsail Anchorage Skyriding Glyph",
    "/way #2395 52.49 67.62 Tranquillien Skyriding Glyph",
    "/way #2395 58.39 58.30 Suncrown Tree Skyriding Glyph",
    "/way #2437 19.20 70.72 Revantusk Sedge Skyriding Glyph",
    "/way #2437 53.19 81.89 Temple of Akil'zon Skyriding Glyph",
    "/way #2437 53.27 54.52 Strait of Hexx'alor Skyriding Glyph",
    "/way #2437 30.43 84.73 Nalorakk's Prowl Skyriding Glyph",
    "/way #2395 63.83 81.47 Amani Pass Skyriding Glyph",
    "/way #2437 42.75 80.17 Spiritpaw Burrow Skyriding Glyph",
    "/way #2437 42.93 34.35 Shadebasin Watch Skyriding Glyph",
    "/way #2437 51.59 23.75 Temple of Jan'alai Skyriding Glyph",
    "/way #2437 39.54 19.67 Witherbark Bluffs Skyriding Glyph / below bridge",
    "/way #2437 27.98 28.82 Zeb'Alar Lumberyard Skyriding Glyph",
    "/way #2437 46.69 82.17 Solemn Valley Skyriding Glyph",
    "/way #2413 59.69 43.94 Blossoming Terrace Skyriding Glyph / top root",
    "/way #2413 34.50 23.60 Roots of Teldrassil Skyriding Glyph / top root",
    "/way #2413 54.12 35.58 Blooming Lattice Skyriding Glyph / under root",
    "/way #2413 44.56 62.86 Fungara Village Skyriding Glyph / top root",
    "/way #2413 61.84 67.50 Rift of Aln Skyriding Glyph / highest root",
    "/way #2413 47.13 53.14 The Cradle Skyriding Glyph / above den",
    "/way #2413 69.31 45.80 Roots of Amirdrassil Skyriding Glyph / under root",
    "/way #2413 73.12 25.81 Roots of Nordrassil Skyriding Glyph / under root",
    "/way #2413 26.52 61.37 Roots of Shaladrassil Skyriding Glyph / mushroom top",
    "/way #2405 51.35 62.65 The Voidspire Skyriding Glyph",
    "/way #2405 35.64 61.17 The Ingress Skyriding Glyph",
    "/way #2405 55.09 45.41 Gnawing Reach Skyriding Glyph",
    "/way #2405 38.85 76.16 Ethereum Refinery Skyriding Glyph",
    "/way #2405 65.25 71.90 Obscurion Citadel Skyriding Glyph",
    "/way #2405 49.19 87.63 The Gorging Pit Skyriding Glyph",
    "/way #2405 37.16 49.84 The Molt Skyriding Glyph",
    "/way #2405 39.96 70.93 The Bladeburrows Skyriding Glyph",
    "/way #2444 36.16 45.01 Hanaar Outpost Skyriding Glyph",
    "/way #2405 45.25 52.21 Masters' Perch Skyriding Glyph",
    "/way #2405 36.23 37.18 Shadowguard Point Skyriding Glyph",
}

-- Midnight Glyph Hunter is a meta-achievement. Each pin follows a criterion
-- from its zone achievement rather than one of the meta's four criteria.
local MIDNIGHT_GLYPH_CRITERIA = {}
for _, group in ipairs({
    { achievementId = 61576, count = 11 },
    { achievementId = 61581, count = 11 },
    { achievementId = 61582, count = 9 },
    { achievementId = 61583, count = 11 },
}) do
    for criterionIndex = 1, group.count do
        MIDNIGHT_GLYPH_CRITERIA[#MIDNIGHT_GLYPH_CRITERIA + 1] = {
            achievementId = group.achievementId,
            criterionIndex = criterionIndex,
        }
    end
end

local MIDNIGHT_SAFARI_WAYPOINTS = {}
local MIDNIGHT_SAFARI_CRITERIA = {}
local function AddMidnightSafariWaypoints(criterionIndex, waypoints)
    for _, waypoint in ipairs(waypoints) do
        MIDNIGHT_SAFARI_WAYPOINTS[#MIDNIGHT_SAFARI_WAYPOINTS + 1] = waypoint
        MIDNIGHT_SAFARI_CRITERIA[#MIDNIGHT_SAFARI_CRITERIA + 1] = criterionIndex
    end
end

AddMidnightSafariWaypoints(1, {
    "/way #2437 52.8 80.6 Akil Fledgling",
    "/way #2437 47.0 75.8 Akil Fledgling",
    "/way #2437 49.6 81.6 Akil Fledgling",
})
AddMidnightSafariWaypoints(2, {
    "/way #2413 64.0 45.6 Azure Sporebat",
    "/way #2413 56.6 54.6 Azure Sporebat",
    "/way #2413 70.0 64.4 Azure Sporebat",
})
AddMidnightSafariWaypoints(3, {
    "/way #2405 51.1 77.4 Devouring Runt",
    "/way #2405 40.2 37.6 Devouring Runt",
    "/way #2405 57.2 71.0 Devouring Runt",
})
AddMidnightSafariWaypoints(4, {
    "/way #2437 41.4 48.4 Ebon Snapling",
    "/way #2437 32.6 45.6 Ebon Snapling",
    "/way #2437 42.0 59.6 Ebon Snapling",
})
AddMidnightSafariWaypoints(5, {
    "/way #2437 29.0 41.8 Gloom Toad",
    "/way #2437 37.4 64.8 Gloom Toad",
    "/way #2437 45.2 73.0 Gloom Toad",
})
AddMidnightSafariWaypoints(6, {
    "/way #2424 43.6 15.6 Nether Familiar",
    "/way #2424 29.0 29.0 Nether Familiar",
    "/way #2424 29.0 28.4 Nether Familiar",
})
AddMidnightSafariWaypoints(7, {
    "/way #2413 60.4 20.7 Rootling Nester",
    "/way #2413 40.6 43.2 Rootling Nester",
    "/way #2413 52.8 80.2 Rootling Nester",
})
AddMidnightSafariWaypoints(8, {
    "/way #2437 39.6 51.8 Striped Snakebiter",
    "/way #2437 51.6 67.0 Striped Snakebiter",
    "/way #2437 51.8 61.6 Striped Snakebiter",
    "/way #2437 38.67 47.24 Striped Snakebiter / alternate spawn",
    "/way #2437 48.61 49.79 Striped Snakebiter / alternate spawn",
    "/way #2437 42.24 63.38 Striped Snakebiter / alternate spawn",
    "/way #2437 50.34 57.72 Striped Snakebiter / alternate spawn",
})
AddMidnightSafariWaypoints(9, {
    "/way #2395 46.0 36.2 Vibrant Manaling",
    "/way #2395 53.8 55.4 Vibrant Manaling",
    "/way #2395 39.4 56.6 Vibrant Manaling",
})
AddMidnightSafariWaypoints(10, {
    "/way #2405 30.6 66.4 Voidcrawler",
    "/way #2405 28.2 53.0 Voidcrawler",
    "/way #2405 48.0 60.0 Voidcrawler",
})
AddMidnightSafariWaypoints(11, {
    "/way #2424 41.0 33.0 Wrathful Wyrm",
    "/way #2424 49.2 22.8 Wrathful Wyrm",
})
AddMidnightSafariWaypoints(12, {
    "/way #2395 42.8 38.6 Amber Treeflitter",
    "/way #2395 40.8 46.6 Amber Treeflitter",
    "/way #2395 50.0 59.6 Amber Treeflitter",
})
AddMidnightSafariWaypoints(13, {
    "/way #2405 62.8 67.2 Blistercreepling",
    "/way #2405 33.0 48.4 Blistercreepling",
    "/way #2405 65.4 59.4 Blistercreepling",
})
AddMidnightSafariWaypoints(14, {
    "/way #2437 50.6 24.8 Dragonhawk Mosswing",
    "/way #2437 51.8 28.8 Dragonhawk Mosswing",
    "/way #2437 51.6 18.2 Dragonhawk Mosswing",
})
AddMidnightSafariWaypoints(15, {
    "/way #2437 40.8 54.2 Pangolil",
    "/way #2437 48.2 54.6 Pangolil",
    "/way #2437 40.2 54.2 Pangolil",
})
AddMidnightSafariWaypoints(16, {
    "/way #2413 70.5 32.2 Mud Potadpole",
    "/way #2413 69.6 32.2 Mud Potadpole",
    "/way #2413 71.6 31.2 Mud Potadpole",
})
AddMidnightSafariWaypoints(17, {
    "/way #2405 63.2 73.6 Riftblade Familiar",
    "/way #2405 60.0 72.4 Riftblade Familiar",
})
AddMidnightSafariWaypoints(18, {
    "/way #2413 41.4 69.8 Silkcrawler",
    "/way #2413 36.6 26.6 Silkcrawler",
    "/way #2413 41.6 69.6 Silkcrawler",
})
AddMidnightSafariWaypoints(19, {
    "/way #2437 51.4 65.0 Swamp Biter",
    "/way #2437 44.6 40.4 Swamp Biter",
    "/way #2437 51.6 65.0 Swamp Biter",
})
AddMidnightSafariWaypoints(20, {
    "/way #2395 46.0 36.4 Violet Chick",
    "/way #2395 38.0 57.8 Violet Chick",
})
AddMidnightSafariWaypoints(21, {
    "/way #2413 60.4 20.9 Waddles",
    "/way #2413 60.6 20.8 Waddles",
    "/way #2413 61.4 18.6 Waddles",
})

local EVERSONG_TREASURE_WAYPOINTS = {
    "/way #2393 24.38 69.58 Rookery Cache / buy and place Tasty Meat",
    "/way #2395 40.96 19.45 Gift of the Phoenix / collect 5 embers",
    "/way #2395 44.62 45.55 Gilded Armillary Sphere / upper floor",
    "/way #2395 60.69 67.29 Farstrider's Lost Quiver",
    "/way #2395 48.74 75.44 Burbling Paint Pot",
    "/way #2395 38.89 76.09 Triple-Locked Safebox",
    "/way #2395 40.23 75.83 Tarnished Safebox Key",
    "/way #2395 37.64 74.83 Tarnished Safebox Key",
    "/way #2395 38.44 73.45 Tarnished Safebox Key",
    "/way #2395 43.28 69.48 Forgotten Ink and Quill / upper floor",
    "/way #2395 52.34 45.43 Antique Nobleman's Signet Ring / lower floor",
    "/way #2395 40.44 60.90 Stone Vat / grapes and yeast",
}

local EVERSONG_TREASURE_CRITERIA = {
    1, 2, 3, 4, 5,
    6, 6, 6, 6,
    7, 8, 9,
}

local HIGHEST_PEAKS_CRITERIA = { 1, 2, 3, 4, 5 }

local EVERSONG_HIGHEST_PEAKS_WAYPOINTS = {
    "/way #2393 20.12 79.73 Eversong Highest Peaks Telescope",
    "/way #2395 40.40 10.08 Eversong Highest Peaks Telescope",
    "/way #2395 54.59 51.02 Eversong Highest Peaks Telescope",
    "/way #2395 37.40 47.87 Eversong Highest Peaks Telescope",
    "/way #2395 50.21 85.45 Eversong Highest Peaks Telescope",
}

local ZULAMAN_HIGHEST_PEAKS_WAYPOINTS = {
    "/way #2437 27.79 70.01 Zul'Aman Highest Peaks Telescope",
    "/way #2437 53.02 81.97 Zul'Aman Highest Peaks Telescope",
    "/way #2437 57.69 21.23 Zul'Aman Highest Peaks Telescope",
    "/way #2437 24.63 58.30 Zul'Aman Highest Peaks Telescope",
    "/way #2437 41.86 41.64 Zul'Aman Highest Peaks Telescope",
}

local HARANDAR_HIGHEST_PEAKS_WAYPOINTS = {
    "/way #2413 53.47 58.60 Harandar Highest Peaks Telescope",
    "/way #2413 49.38 75.94 Harandar Highest Peaks Telescope",
    "/way #2413 69.20 46.38 Harandar Highest Peaks Telescope",
    "/way #2413 69.38 63.37 Harandar Highest Peaks Telescope",
    "/way #2413 68.20 25.93 Harandar Highest Peaks Telescope",
}

local VOIDSTORM_HIGHEST_PEAKS_WAYPOINTS = {
    "/way #2405 41.75 70.26 Voidstorm Highest Peaks Telescope",
    "/way #2405 39.66 61.18 Voidstorm Highest Peaks Telescope",
    "/way #2405 55.46 67.20 Voidstorm Highest Peaks Telescope",
    "/way #2405 37.80 54.98 Voidstorm Highest Peaks Telescope",
    "/way #2405 36.49 44.33 Voidstorm Highest Peaks Telescope",
}

local SILVERMOON_BROOM_WAYPOINTS = {
    "/way #2393 30.0 75.0 Silvermoon Broom",
    "/way #2393 31.2 75.2 Silvermoon Broom",
    "/way #2393 32.4 75.6 Silvermoon Broom",
}

local MIDNIGHT_DUNGEON_WAYPOINTS = {
    "/way #2576 27.8 77.9 The Blinding Vale entrance",
    "/way #2393 36.8 68.4 Silvermoon portal to Harandar",
}

local RITUAL_SITE_ENTRANCE_WAYPOINTS = {
    "/way #2395 34.9 65.4 Daggerspine Point Ritual Site",
    "/way #2437 29.7 78.2 Broken Throne Ritual Site",
}

local SERGEANT_VORNIN_WAYPOINTS = {
    "/way #2393 48.6 50.6 Sergeant Vornin / Void Assault and Ritual Site rewards",
}

local FIELD_ACCOLADE_WAYPOINTS = {
    "/way #2393 48.1 49.7 Ranger Captain Lilatha / Void Assault intro",
    "/way #2393 48.2 49.6 Maren Silverwing and Triam Dawnsetter / Field Accolade vendors",
}

local DECOR_DUELS_WAYPOINTS = {
    "/way #2393 31.6 76.7 Gamesmaster Fleurian / Decor Duels rewards",
}

local LOST_ARMAMENT_WAYPOINTS = {
    "/way #2393 48.2 49.6 Field Accolade hub / Cosmetic Equipment Salvager",
    "/way #2395 34.9 65.4 Daggerspine Point Ritual Site",
    "/way #2437 29.7 78.2 Broken Throne Ritual Site",
}

local UMBRAL_BASE_CAMP_WAYPOINTS = {
    "/way #2600 48.0 82.0 Naigtal Umbral Base Camp / Kifaan, Fieldsmith Ventem, and Zuronar",
    "/way #2599 62.0 15.0 Val Umbral Base Camp / Kifaan, Fieldsmith Ventem, and Zuronar",
}

local ICE_GUARDIAN_SLEETBLADE_WAYPOINTS = {
    "/way #2599 61.4 78.8 Ice Guardian cave entrance / Heroic Val",
    "/way #2599 70.5 84.3 Ice Guardian's Sleetblade hilt / inside the cave",
}

local COSMIC_EXTERMINATOR_WAYPOINTS = {
    "/way #2395 50.0 51.0 Void Rift: Tranquil Repose / corrupted wildlife",
    "/way #2395 36.3 36.3 Void Rift: Sunstrider Isle / corrupted wildlife",
    "/way #2395 52.0 81.0 Void Rift: South Eversong Woods / corrupted wildlife",
    "/way #2437 31.0 42.0 Void Rift: Bitter Bark / corrupted wildlife",
}

local COSMIC_SLAYER_WAYPOINTS = {
    "/way #2395 53.0 39.4 Void Ritual: Springclaw / advanced corruption",
    "/way #2395 56.0 76.8 Void Ritual: Croaker / advanced corruption",
    "/way #2437 32.0 71.6 Void Ritual: Grizzly / advanced corruption",
}

local BROKEN_THRONE_HEX_EAGLE_WAYPOINTS = {
    "/way #2585 50.6 47.3 Ritual Circle / Void-Corrupted Hex Eagle",
    "/way #2585 51.5 47.8 Misplaced Ritual Candle",
}

local WITHERBARK_WARBEAR_WAYPOINTS = {
    "/way #2585 55.8 49.6 Lost Bear Cub",
    "/way #2585 55.8 38.8 Angry Amani Warbear",
}

local RITUAL_SITE_RUSTLING_BUSH_WAYPOINTS = {
    "/way #2594 66.40 52.46 Rustling Bush",
    "/way #2594 55.00 79.30 Rustling Bush",
    "/way #2594 35.10 44.50 Rustling Bush",
    "/way #2594 68.46 37.62 Rustling Bush",
    "/way #2594 63.58 65.58 Rustling Bush",
    "/way #2594 42.03 80.03 Rustling Bush",
    "/way #2594 41.76 49.69 Rustling Bush",
    "/way #2594 43.31 57.99 Rustling Bush",
    "/way #2594 42.99 49.68 Rustling Bush",
    "/way #2585 54.37 72.49 Rustling Bush",
    "/way #2585 48.10 83.10 Rustling Bush",
    "/way #2585 52.85 83.40 Rustling Bush",
    "/way #2585 58.22 79.36 Rustling Bush",
    "/way #2585 60.10 66.10 Rustling Bush",
    "/way #2585 48.46 76.90 Rustling Bush",
    "/way #2585 40.90 67.50 Rustling Bush",
    "/way #2585 51.45 44.84 Rustling Bush",
    "/way #2585 58.50 49.60 Rustling Bush",
    "/way #2585 39.00 45.00 Rustling Bush",
    "/way #2585 42.00 45.00 Rustling Bush",
}

local MIDNIGHT_RAID_WAYPOINTS = {
    "/way #2413 61.69 62.77 The Dreamrift entrance",
    "/way #2405 45.05 64.71 The Voidspire entrance",
    "/way #2424 52.60 87.50 March on Quel'Danas entrance",
}

local BROKEN_THRONE_PETS_WAYPOINTS = {
    "/way #2585 55.8 49.6 Chubs / Lost Bear Cub",
    "/way #2585 49.5 78.3 Void-Scarred Eaglet / tornado nest",
}

local DAGGERSPINE_POINT_PETS_WAYPOINTS = {
    "/way #2594 46.0 45.0 Washed Up Kelp",
    "/way #2594 50.0 54.0 Washed Up Kelp",
    "/way #2594 61.0 77.0 Washed Up Kelp",
    "/way #2594 47.0 72.0 Washed Up Kelp",
    "/way #2594 66.0 74.0 Washed Up Kelp",
    "/way #2594 41.0 73.0 Washed Up Kelp",
    "/way #2594 38.0 64.0 Washed Up Kelp",
    "/way #2594 53.0 55.0 Washed Up Kelp",
    "/way #2594 30.1 63.1 Soggy Nest / Void-Corrupted Snapdragon",
}

local VOID_TOUCHED_CHICK_WAYPOINTS = {
    "/way #2594 74.3 49.6 Void-Touched Egg / waterfall spawn",
    "/way #2594 52.3 63.8 End of the egg's drift route",
}

local ABYSS_ANGLERS_WAYPOINTS = {
    "/way #2437 78.0 15.0 Depthdiver Jeju / Abyss Anglers island",
}

local NAIGTAL_VAL_INVASION_WAYPOINTS = {
    "/way #2393 47.61 51.08 Maella / Invasion Point introductions",
    "/way #2405 51.44 71.27 Portal to Naigtal and Val",
    "/way #2600 47.8 81.6 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.0 Kifaan / Val Umbral Base Camp",
}

local VAL_RARE_WAYPOINTS = {
    "/way #2599 61.68 78.91 Sleet-Rune Hollow entrance",
    "/way #2599 68.68 85.93 Sleet-Rune",
    "/way #2599 37.92 76.25 Atomus",
    "/way #2599 56.13 49.98 Frost Chitter Grotto entrance",
    "/way #2599 66.98 42.02 Broodmother Egg Sac",
    "/way #2599 49.66 78.58 Mercilus",
    "/way #2599 29.12 73.90 Xirah the Burning Heart",
    "/way #2599 46.23 48.41 Krilkan patrol",
    "/way #2599 35.32 38.89 Opprimius",
    "/way #2599 30.41 38.64 Lost Holdout entrance",
    "/way #2599 22.79 41.66 Nelgothar",
    "/way #2599 43.32 70.90 Portal to Forgotten Depths",
    "/way #2621 43.00 61.74 The Horror Below",
    "/way #2599 46.48 59.56 Shadowguard Destroyer",
}

local NAIGTAL_RARE_WAYPOINTS = {
    "/way #2600 37.45 63.20 Interminable Uarn",
    "/way #2600 43.66 50.44 Broxion",
    "/way #2600 77.91 38.62 Swalewing Matriarch",
    "/way #2600 67.08 62.89 Lomelith",
    "/way #2600 28.08 50.52 Auredar / inside the building",
    "/way #2600 70.31 76.36 Warp Agent Xi'grivr",
    "/way #2600 53.07 54.98 Indomitable Mk XII patrol",
    "/way #2600 57.03 60.24 Slaipaan patrol",
    "/way #2600 29.83 19.42 Warbringer Thal'kuur",
    "/way #2600 49.54 48.51 Voidwarped Sporebat",
}

local SHOWDOWN_RARE_WAYPOINTS = {}
for _, waypoint in ipairs(VAL_RARE_WAYPOINTS) do
    SHOWDOWN_RARE_WAYPOINTS[#SHOWDOWN_RARE_WAYPOINTS + 1] = waypoint
end
for _, waypoint in ipairs(NAIGTAL_RARE_WAYPOINTS) do
    SHOWDOWN_RARE_WAYPOINTS[#SHOWDOWN_RARE_WAYPOINTS + 1] = waypoint
end

local SHOWDOWN_WORLD_BOSS_WAYPOINTS = {
    "/way #2599 40.83 74.58 Imperator Pertinax / Void Acropolis interior",
    "/way #2600 77.3 71.7 Nexus-Captain Leth'ir / Command Point Primos",
}

local SLEEPY_MANDRAKE_WAYPOINTS = {
    "/way #2600 67.51 53.98 Sleeper's Grotto entrance",
    "/way #2600 68.25 51.61 Sleepy Mandrake",
    "/way #2600 33.40 59.70 Path to Highland",
    "/way #2600 28.90 61.76 Highland",
    "/way #2600 27.91 49.96 Vilaldoun Crypt entrance",
    "/way #2646 22.72 61.30 Dusty",
    "/way #2600 75.64 38.14 Marshwalker Refuge cave entrance",
    "/way #2600 71.42 37.05 Marshy",
    "/way #2600 78.50 40.00 Swalewing Matriarch / Partially-Digested",
    "/way #2600 89.31 29.49 Bouncy Mushroom",
    "/way #2600 95.09 26.67 Airy",
}

local EMBERLYN_WAYPOINTS = {
    "/way #2437 55.00 18.39 Loa Speaker Brek / Egg Hatching questline",
}

local BATTERY_BOMBARDMENT_WAYPOINTS = {
    "/way #2437 47.0 42.0 Battery Rush / pylon route",
    "/way #2437 30.0 36.0 Battery Rush / pylon route",
}

local COILED_ISLE_RARE_WAYPOINTS = {
    "/way #2512 53.80 72.07 Farthik / click Unguarded Treasure Chest to ground him",
    "/way #2512 25.01 73.73 Kari'zah the Forgotten / southwest coast",
    "/way #2512 43.82 50.82 Hisstara / inside the Venom Rise building",
    "/way #2512 69.62 44.85 Garsecg / Mlurkkr Mire",
    "/way #2512 58.34 65.23 Coin-Eye Skully / fast water patrol",
    "/way #2512 59.34 39.74 Sss'alik / north end of patrol",
    "/way #2512 57.25 40.39 Sss'alik / south end of patrol",
    "/way #2512 50.43 69.39 Siltmouth / shallow venom pool",
    "/way #2512 31.82 56.62 Lockjaw / river by The Forum",
    "/way #2509 47.14 11.31 The Underbelly entrance / route to Szarith",
    "/way #2613 38.14 16.92 Szarith the Fanged / left side deep inside",
    "/way #2512 52.57 42.80 Tomb of the Forgotten Priest entrance",
    "/way #2642 63.44 61.69 Nar'zira / downstairs then left",
    "/way #2512 70.05 63.40 Big Mon / Whispering Marsh path",
    "/way #2512 52.41 32.79 Destra / Blistering Terrace venom pool",
}

local VAULTS_ASSAULT_WAYPOINTS = {
    "/way #2512 43.72 44.19 Gate of the Serpent's Eye / north entrance",
    "/way #2512 31.29 64.18 Gate of the Western Fang / west entrance",
    "/way #2512 45.67 64.90 Gate of the Eastern Fang / east entrance",
    "/way #2509 47.24 61.09 Warleader Abdumati / unlock Vault activities",
    "/way #2509 51.20 62.60 Altar of Corrosion / Fully Corroded",
    "/way #2509 47.22 54.42 Ritual Altar / Ritual Behavior",
    "/way #2509 47.14 11.31 The Underbelly entrance / Soft Underbelly",
    "/way #2613 38.14 16.92 Szarith the Fanged / Soft Underbelly",
    "/way #2509 39.70 48.19 Vault of Restless Bones entrance",
    "/way #2636 77.01 36.87 To Comrades inscription / inside the vault",
}

local RALKALA_WAYPOINTS = {
    "/way #2512 58.22 48.70 Image of Astalor Bloodsworn / enable Curse of the Isle",
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
    "/way #2600 47.4 81.4 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.6 Kifaan / Val Umbral Base Camp",
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
    "/way #2509 51.13 62.37 Skull of Er'inye",
    "/way #2509 47.24 61.09 Warleader Abdumati / Skull unlock quest",
}

local LINDORMI_WAYPOINTS = {
    "/way #2393 42.2 58.4 Lindormi / Timelost Saddle vendor",
    "/way #2393 42.2 58.8 Lindormi / alternate Silvermoon position",
    "/way #2339 53.8 39.0 Lindormi / Dornogal",
    "/way #2112 53.0 56.8 Lindormi / Valdrakken",
    "/way #2112 53.2 56.2 Lindormi / alternate Valdrakken position",
}

local TELEMANCER_ASTRANDIS_WAYPOINTS = {
    "/way #2393 52.4 78.6 Telemancer Astrandis",
}

local TRADING_POST_WAYPOINTS = {
    "/way #2393 48.77 78.02 Trading Post / Silvermoon City",
    "/way #2339 44.4 55.8 Trading Post / Dornogal",
    "/way #84 51.0 71.8 T&W Trading Post / Stormwind",
    "/way #85 48.4 76.0 Zen'shiri Trading Post / Orgrimmar",
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

local COILED_ISLE_SAFARI_WAYPOINTS = {
    "/way #2512 62.2 40.8 Poisoned Parasite",
    "/way #2512 65.2 49.2 Poisoned Parasite",
    "/way #2512 68.35 76.08 Poisoned Parasite",
    "/way #2512 65.42 53.86 Poisoned Parasite",
    "/way #2512 65.8 32.8 Steady Croakfrog",
    "/way #2512 69.23 46.35 Steady Croakfrog",
    "/way #2512 62.6 84.0 Nightfur Kapara",
    "/way #2512 61.6 81.8 Nightfur Kapara",
    "/way #2512 62.5 83.0 Nightfur Kapara",
    "/way #2512 62.59 81.58 Nightfur Kapara",
    "/way #2512 62.95 81.68 Nightfur Kapara",
    "/way #2512 61.0 81.0 Nightfur Kapara",
    "/way #2509 39.0 28.2 Caustic Writhling",
    "/way #2509 41.96 34.23 Caustic Writhling",
    "/way #2509 43.66 31.63 Caustic Writhling",
    "/way #2509 41.78 34.54 Caustic Writhling",
    "/way #2509 32.3 29.4 Caustic Writhling",
    "/way #2512 47.2 59.8 Cursed Spawn",
    "/way #2512 46.20 27.11 Cursed Spawn",
    "/way #2512 41.9 21.2 Cursed Spawn",
    "/way #2512 51.5 52.9 Cursed Spawn",
    "/way #2512 65.81 45.75 Sleek Snakebiter",
    "/way #2512 41.31 43.63 Sleek Snakebiter",
    "/way #2512 65.76 45.55 Sleek Snakebiter",
    "/way #2512 56.06 51.44 Sleek Snakebiter",
    "/way #2512 60.62 77.81 Sleek Snakebiter",
    "/way #2512 47.39 74.19 Sleek Snakebiter",
    "/way #2512 45.2 31.2 Jaundiced Slitherer",
    "/way #2512 45.16 31.37 Jaundiced Slitherer",
    "/way #2512 49.83 55.87 Jaundiced Slitherer",
    "/way #2512 67.8 81.4 Autumn Snapling",
    "/way #2512 70.6 78.6 Autumn Snapling",
    "/way #2512 70.61 78.71 Autumn Snapling",
    "/way #2512 65.35 70.88 Autumn Snapling",
}

local COILED_ISLE_SAFARI_CRITERIA = {
    1, 1, 1, 1,
    2, 2,
    3, 3, 3, 3, 3, 3,
    4, 4, 4, 4, 4,
    5, 5, 5, 5,
    6, 6, 6, 6, 6, 6,
    7, 7, 7,
    8, 8, 8, 8,
}

local CATACLYSM_FAMILY_BATTLER_WAYPOINTS = {
    "/way #198 61.4 32.8 Brok",
    "/way #207 49.8 57.0 Bordin Steadyfist",
    "/way #241 56.6 56.8 Goz Banefury",
    "/way #249 56.6 41.8 Obalis / old Uldum phase",
    "/way #1527 54.4 37.6 Obalis / Battle for Azeroth Uldum phase",
}

local OUTLAND_FAMILY_BATTLER_WAYPOINTS = {
    "/way #100 64.4 49.2 Nicki Tinytech",
    "/way #102 17.2 50.6 Ras'an",
    "/way #107 61.0 49.4 Narrok",
    "/way #111 59.0 70.0 Morulu the Elder",
    "/way #104 30.6 41.8 Bloodknight Antari",
}

local CURSE_SURGE_WAYPOINTS = {
    "/way #2512 26.7 64.8 The Looming Mutagenitor",
    "/way #2512 45.2 28.6 The Broodmother's Nest / Vassti",
    "/way #2512 46.9 62.2 The Malformed Leviathan",
    "/way #2512 71.2 31.3 Mlurkkr Massacre / Ss'akrithos",
    "/way #2512 67.6 77.8 Siege at the Whispering Marsh / Ori'kassi",
}

local COILED_ISLE_TREASURE_WAYPOINTS = {
    "/way #2512 71.82 66.66 Amani Privateer's Cache",
    "/way #2512 73.27 65.88 Grisly Cod Pool / Privateer's Cache",
    "/way #2512 73.09 67.02 Waterlogged Crate / Privateer's Cache",
    "/way #2512 72.45 68.40 Broken Urn / Privateer's Cache",
    "/way #2512 65.41 5.58 Sunken Diver's Chest",
    "/way #2512 43.56 67.51 Profane Ritual Spoils",
    "/way #2512 31.38 83.60 Possessed Vase",
    "/way #2512 55.20 37.96 Tarnished Amani Glaive",
    "/way #2512 68.05 65.89 Lost Spirit",
    "/way #2512 70.25 64.45 Forgotten Trinket / Lost Spirit",
    "/way #2512 46.86 29.62 Damaged Loa Trinket",
    "/way #2512 66.92 28.05 Ornate Bottle",
    "/way #2512 49.33 31.96 Waterlogged Basket",
    "/way #2512 73.35 56.67 Crumbling Urn",
    "/way #2512 58.14 45.76 Vul'zahn's Smuggled Treasure",
    "/way #2512 57.97 48.75 Witherbark Cook / Smuggled Treasure",
    "/way #2512 57.25 48.49 Apothecary Dezi / Smuggled Treasure",
    "/way #2512 45.90 66.20 Fangbound Sack",
    "/way #2512 67.21 48.38 Grave of Someone Forgotten",
    "/way #2512 69.07 52.71 Zuzan / Grave of Someone Forgotten",
    "/way #2512 70.38 58.45 Nan'ja / Grave of Someone Forgotten",
    "/way #2512 66.38 57.24 Ru'ko / Grave of Someone Forgotten",
    "/way #2512 70.61 76.70 Brine-Crusted Chest",
    "/way #2512 68.05 80.31 Bubbling Clam / Brine-Crusted Chest",
    "/way #2512 69.57 82.48 Bubbling Clam / Brine-Crusted Chest",
    "/way #2512 70.90 81.63 Bubbling Clam / Brine-Crusted Chest",
    "/way #2512 71.30 83.29 Bubbling Clam / Brine-Crusted Chest",
    "/way #2512 75.38 68.37 Malfunctioning Staff",
    "/way #2512 60.41 59.49 Jaktu's Cursed Blade",
    "/way #2512 58.14 43.62 Cracked Skull",
    "/way #2512 64.71 36.65 Venomjade Necklace",
    "/way #2512 53.15 43.14 Stinking Vessel",
    "/way #2512 29.53 67.08 Smoldering Incense",
    "/way #2512 64.92 79.00 Forgotten Mask",
    "/way #2512 44.01 26.60 Zul'jan's Stash",
}

-- Achievement 63359 exposes 22 criteria, while several treasures need extra
-- setup locations. Map every setup pin to its parent criterion so the map can
-- hide the entire route after that treasure has been collected.
local COILED_ISLE_TREASURE_CRITERIA = {
    1, 1, 1, 1,
    2, 3, 4, 5,
    6, 6,
    7, 8, 9, 10,
    11, 11, 11,
    12,
    13, 13, 13, 13,
    14, 14, 14, 14, 14,
    15, 16, 17, 18, 19, 20, 21, 22,
}

local COILED_ISLE_GLYPH_WAYPOINTS = {
    "/way #2512 37.4 60.5 The Fangs Skyriding Glyph",
    "/way #2512 28.8 75.2 The Wreck of Sethralis's Scales Skyriding Glyph",
    "/way #2512 45.9 64.9 Gate of the Eastern Fang Skyriding Glyph",
    "/way #2512 64.1 60.7 The Whispering Marsh Skyriding Glyph",
    "/way #2512 52.1 38.6 The Serpent's Tail Skyriding Glyph",
    "/way #2512 43.9 44.2 Gate of the Serpent's Eye Skyriding Glyph",
    "/way #2512 26.6 63.2 The Forum Skyriding Glyph",
    "/way #2512 40.6 90.5 Southern Island Skyriding Glyph",
    "/way #2512 58.9 48.9 Tokka's Landing Skyriding Glyph",
    "/way #2512 70.1 48.3 The Wreck of Paku's Talon Skyriding Glyph",
    "/way #2512 42.9 30.6 Blistering Terrace Skyriding Glyph",
}

local COILED_ISLE_LORE_WAYPOINTS = {
    "/way #2512 42.5 65.0 Coiled Isle Lore Object",
    "/way #2512 70.0 65.9 Coiled Isle Lore Object",
    "/way #2512 31.6 83.7 Coiled Isle Lore Object",
    "/way #2512 25.0 67.8 Coiled Isle Lore Object",
    "/way #2512 71.9 44.9 Coiled Isle Lore Object",
    "/way #2512 57.4 80.3 Coiled Isle Lore Object",
    "/way #2512 50.7 68.4 Coiled Isle Lore Object",
    "/way #2512 45.8 47.9 Coiled Isle Lore Object",
    "/way #2512 34.1 36.5 Coiled Isle Lore Object",
    "/way #2512 32.5 63.7 Coiled Isle Lore Object",
}

local KARESH_PHASE_VENDOR_WAYPOINTS = {
    "/way #2371 50.36 36.31 Shad'anis / Phase Diving Merchant",
}

local KARESH_TRUST_WAYPOINTS = {
    "/way #2472 40.6 29.0 Om'sirik / K'aresh Trust quartermaster",
}

local MANAFORGE_CLOAK_WAYPOINTS = {
    "/way #2371 41.96 22.43 Ba'choso / Shadow Point",
}

local MOONLIGHTER_WAYPOINTS = {
    "/way #2472 48.56 57.78 Constable Zo'ardaz / Warrant board",
}

local UNDERMINE_WEAPONRY_WAYPOINTS = {
    "/way #2339 47.49 43.67 Sir Finley Mrrgglton / Delver's Headquarters",
}

local PHASE_ORB_WAYPOINTS = {
    "/way #2371 51.02 69.12 Phase Orb route / Eco-Dome Primus",
    "/way #2371 45.74 51.53 Phase Orb route",
    "/way #2371 43.75 25.60 Phase Orb route / Overlook Zo'Shuul",
    "/way #2371 49.34 18.96 Phase Orb route / Shadow Point",
    "/way #2472 42.77 50.34 Phase Orb route / Tazavesh",
}

local LEGION_REMIX_BAZAAR_WAYPOINTS = {
    "/way #627 47.70 69.81 Infinite Bazaar portal",
    "/way #627 45.48 67.84 Pythagorus / raid ensembles",
    "/way #627 45.50 68.39 Unicus and Larah Treebender",
    "/way #627 45.44 68.03 Arturos / dungeon ensembles",
    "/way #627 45.43 67.70 Agos / Lost and Found Apparel",
    "/way #627 45.39 67.78 Freddie Threads / cloak ensembles",
}

local PANDAREN_HERITAGE_WAYPOINTS = {
    "/way #1519 52.6 13.8 Aysa Cloudsinger / Stormwind Embassy",
    "/way #1637 38.0 80.2 Ji Firepaw / Orgrimmar Embassy",
}

local SHADOWLANDS_TIMEWALKING_WAYPOINTS = {
    "/way #1670 64.2 68.0 Collector Ta'steld / Oribos",
}

local function BuildCosmeticEntries(groups)
    local entries = {}
    for _, group in ipairs(groups) do
        for _, item in ipairs(group.items) do
            local entry = {
                itemId = item[1],
                name = item[2],
                subtype = group.subtype,
                detailKey = group.detailKey,
            }
            if item[3] then
                for key, value in pairs(item[3]) do
                    entry[key] = value
                end
            end
            table.insert(entries, entry)
        end
    end
    return entries
end

local PATCH_9_1_COSMETICS = BuildCosmeticEntries({
    { detailKey = "covenantEnsembles", subtype = "ensemble", items = {
        { 186497, "Ensemble: Garb of Pure Spirit" },
        { 186498, "Ensemble: Garb of the Azure Dusk" },
        { 186499, "Ensemble: Garb of Fall's Promise" },
        { 186500, "Ensemble: Garb of the Twilight Grove" },
        { 186502, "Ensemble: Marileth's Assistant Vestments" },
        { 186503, "Ensemble: Initiate's Necromantle Vestments" },
        { 186504, "Ensemble: Frontline Necromancer's Vestments" },
        { 186505, "Ensemble: Rogue Necromancer's Vestments" },
        { 186507, "Ensemble: Harvester's Court Attire" },
        { 186508, "Ensemble: Court Inquisitor's Vestments" },
        { 186509, "Ensemble: Sinful Venthyr Attire" },
        { 186510, "Ensemble: Sinful Inquisitor's Vestments" },
        { 186511, "Ensemble: Renathal's Battlefield Attire" },
        { 186512, "Ensemble: Renathal's Field Inquisitor's Vestments" },
        { 186513, "Ensemble: Radiant Court Attire" },
        { 186514, "Ensemble: Redeemed Inquisitor's Vestments" },
        { 186515, "Ensemble: Aspiring Aspirant's Regalia" },
        { 186516, "Ensemble: Devoted Aspirant's Regalia" },
        { 186517, "Ensemble: Battlefield Messenger's Regalia" },
        { 186518, "Ensemble: Foresworn Aspirant's Regalia" },
    } },
    { detailKey = "cityEyeglasses", subtype = "appearance", items = {
        { 186090, "Simple Glasses" },
        { 186091, "Onyx Glare-Reducers" },
        { 186092, "Historical Perspective Shifters" },
        { 187009, "Dazzling Spectacles" },
        { 187010, "Tasteful Eyeglasses" },
    } },
    { detailKey = "mawBacks", subtype = "appearance", items = {
        { 186562, "Tormentor's Manacled Backplate" },
        { 186977, "Beastcaller's Skull Crescent" },
        { 186978, "Borrowed Eye Crescent" },
        { 187025, "Painbringer's Back-Prison" },
        { 187026, "Field Warden's Torture Kit" },
        { 187034, "Gilded Agony Cage" },
        { 187035, "Cold Burden of the Damned" },
        { 187081, "Blackflame Skull Crescent" },
        { 187082, "Gilded Skull Crescent" },
        { 187083, "Gilded Eye Crescent" },
        { 187084, "Jailer's Eye Crescent" },
        { 187240, "Field Warden's Watchful Eye" },
        { 187241, "Watchful Eye of the Damned" },
        { 187242, "Exterminator's Crest of the Damned" },
        { 187243, "Shadehunter's Crescent" },
    } },
    { detailKey = "mawShoulders", subtype = "appearance", items = {
        { 187011, "Mawsworn Enforcer's Shoulder-Spires" },
        { 187013, "Interceptor's Pauldrons" },
        { 187014, "Shackler's Spiked Shoulders" },
        { 187015, "Soulfeeder's Shoulderguards" },
        { 187016, "Eviscerator's Spiked Mantle" },
        { 187017, "Brutalizer's Mantle" },
        { 187018, "Ritualist's Shoulder-Scythes" },
        { 187019, "Infiltrator's Shoulderguards" },
        { 187020, "Necrobinder's Shoulderpads" },
        { 187021, "Punisher's Spiked Mantle" },
        { 187022, "Mawsworn Lieutenant's Shoulderguards" },
        { 187023, "Instructor's Mantle" },
        { 187024, "Necromancer's Mantle" },
        { 187027, "Skoldus' Shoulder Skewers" },
        { 187030, "Deathsworn Shoulderguards" },
        { 187031, "Towering Mantle of the Maw" },
        { 187032, "Spaulders of Prophetic Death" },
        { 187038, "Shoulders of Vehement Slicing" },
        { 187039, "Malleare's Stygian Pauldrons" },
        { 187040, "Twin-Scythe Spaulders" },
        { 187041, "Shoulders of Unbreakable Demise" },
        { 187042, "Occultist's Ornamental Gorget" },
        { 187043, "Spiked Citadel Shoulderguards" },
        { 187044, "Deathbringer's Epaulettes" },
        { 187045, "Veiled Tormentor's Mantle" },
        { 187046, "Pauldrons of Immaculate Laceration" },
        { 187085, "Sterling Shoulder Skewers" },
        { 187086, "Deathsworn's Sterling Shoulderguards" },
        { 187087, "Sterling Impaler's Mantle" },
        { 187088, "Sterling Skullwing Shoulders" },
        { 187089, "Sterling Blade-Tipped Spaulders" },
        { 187090, "Sterling Wingblade Pauldrons" },
        { 187091, "Gilded Twin-Scythe Shoulders" },
        { 187092, "Gilded Shoulder-Shields" },
        { 187093, "Gilded Ornamental Mantle" },
        { 187094, "Gilded Spike Fortresses" },
        { 187095, "Sterling Spiked Pauldrons" },
        { 187096, "Adamant Vault Shoulderplates" },
        { 187097, "Construct's Shoulderplates" },
        { 187098, "Sterling Twin-Scythe Shoulders" },
        { 187099, "Sterling Fortress Spaulders" },
        { 187100, "Sterling Ornamental Mantle" },
        { 187101, "Sterling Shoulder-Shields" },
        { 187245, "Death-Enveloped Spires" },
        { 187246, "Death-Enveloped Pauldrons" },
        { 187247, "Death-Enveloped Shoulder Spikes" },
        { 187248, "Kroke's Gleaming Spaulders" },
        { 187250, "Kroke's Wingspiked Pauldrons" },
        { 187251, "Shaded Skull Shoulderguards" },
        { 187252, "Ritualist's Spiked Mantle" },
        { 187253, "Maw Guard's Spiked Spaulders" },
    } },
    { detailKey = "korthianCloaks", subtype = "appearance", items = {
        { 187409, "Cloak of the Korthian Scholar" },
        { 187410, "Death's Advance Battlefield Drape" },
        { 187411, "Mantle of Death's Advance" },
    } },
})

local PATCH_9_1_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "legionTimewalkingCosmetics", subtype = "appearance", items = {
        { 187562, "Replica Aegis of Aggramar" },
        { 188209, "Ensemble: Ravencrest's Battleplate" },
    } },
})

local PATCH_9_2_COSMETICS = BuildCosmeticEntries({
    { detailKey = "torghastMawswornWeapons", subtype = "appearance", items = {
        { 188737, "Ebon Mawsworn Crossbow" },
        { 188743, "Ashen Mawsworn Crossbow" },
        { 188744, "Ebon Mawsworn Maul" },
        { 188745, "Ashen Mawsworn Maul" },
        { 188746, "Ebon Mawsworn Halberd" },
        { 188747, "Ashen Mawsworn Halberd" },
        { 188748, "Ebon Mawsworn Staff" },
        { 188749, "Ashen Mawsworn Staff" },
        { 188750, "Burnished Mawsworn Greatsword" },
        { 188752, "Argent Mawsworn Greatsword" },
        { 188753, "Gilded Mawsworn Greatsword" },
    } },
    { detailKey = "dominationCache", subtype = "appearance", items = {
        { 190638, "Tormented Mawsteel Greatsword" },
    } },
    { detailKey = "enlightenedParagonCloaks", subtype = "appearance", items = {
        { 190928, "Sandtails Drape" },
        { 190929, "Ebony Protocloak" },
        { 190930, "Dark Shawl of the Enlightened" },
        { 190931, "Cape of the Regal Wanderer" },
        { 190932, "Protohide Drape" },
        { 190933, "Majestic Oracle's Drape" },
    } },
    { detailKey = "enlightenedParagonWeapons", subtype = "appearance", items = {
        { 190934, "Standard of the Wandering Brokers" },
        { 190937, "Edge of the Enlightened" },
        { 190939, "Walking Staff of the Enlightened Journey" },
        { 190951, "Distinguished Blade of Cartel Al" },
    } },
})

local PATCH_9_2_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "lavaforgeArmaments", subtype = "arsenal", items = {
        { 184922, "Arsenal: Lavaforge Armaments", { requirements = "Dark Iron dwarf; complete Heritage o' the Dark Iron" } },
    } },
    { detailKey = "bloodKnightDedication", subtype = "ensemble", items = {
        { 191565, "Ensemble: Blood Knight's Dedication", { requirements = "Blood elf paladin; level 60 and Exalted with Silvermoon City" } },
    } },
    { detailKey = "darkRangerAttire", subtype = "ensemble", items = {
        { 191658, "Ensemble: Dark Ranger's Attire", { requirements = "Hunter; complete the Return to Lordaeron questline on that hunter" } },
    } },
})

local PATCH_10_0_COSMETICS = BuildCosmeticEntries({
    { detailKey = "dragonscaleExpeditionTools", subtype = "appearance", items = {
        { 198718, "Excavator's Chisel", { requirements = "Dragonscale Expedition Renown 3" } },
        { 198387, "Excavator's Mallet", { requirements = "Dragonscale Expedition Renown 3" } },
        { 198717, "Excavator's Punch", { requirements = "Dragonscale Expedition Renown 3" } },
        { 199746, "Excavator's Trowel", { requirements = "Dragonscale Expedition Renown 3" } },
        { 194102, "Expedition Excavator", { requirements = "Dragonscale Expedition Renown 7" } },
        { 194325, "Researcher's Magnifier", { requirements = "Dragonscale Expedition Renown 7" } },
        { 194326, "Trusty Sweeper", { requirements = "Dragonscale Expedition Renown 7" } },
    } },
    { detailKey = "dragonscaleExpeditionCloaks", subtype = "appearance", items = {
        { 199873, "Renowned Expeditioner's Cape", { requirements = "Dragonscale Expedition Renown 4" } },
        { 199874, "Renowned Expeditioner's Cloak", { requirements = "Dragonscale Expedition Renown 4" } },
        { 199875, "Renowned Expeditioner's Drape", { requirements = "Dragonscale Expedition Renown 4" } },
        { 199876, "Renowned Expeditioner's Armored Shawl", { requirements = "Dragonscale Expedition Renown 4" } },
    } },
    { detailKey = "dragonscaleExpeditionArmor", subtype = "ensemble", items = {
        { 198775, "Ensemble: Renowned Expeditioner's Cloth Armor", { requirements = "Dragonscale Expedition Renown 14" } },
        { 198776, "Ensemble: Renowned Expeditioner's Leather Armor", { requirements = "Dragonscale Expedition Renown 14" } },
        { 198777, "Ensemble: Renowned Expeditioner's Mail Armor", { requirements = "Dragonscale Expedition Renown 14" } },
        { 198778, "Ensemble: Renowned Expeditioner's Plate Armor", { requirements = "Dragonscale Expedition Renown 14" } },
    } },
    { detailKey = "valdrakkenCooking", subtype = "appearance", items = {
        { 199648, "Dragon Dinner Fork", { requirements = "Valdrakken Accord Renown 3" } },
        { 200750, "Dragon Dinner Knife", { requirements = "Valdrakken Accord Renown 3" } },
        { 200751, "Simple Silver Dragon Goblet", { requirements = "Valdrakken Accord Renown 3" } },
        { 200752, "Jeweled Silver Dragon Goblet", { requirements = "Valdrakken Accord Renown 3" } },
        { 200753, "Simple Gold Dragon Goblet", { requirements = "Valdrakken Accord Renown 3" } },
        { 200754, "Jeweled Gold Dragon Goblet", { requirements = "Valdrakken Accord Renown 3" } },
    } },
    { detailKey = "valdrakkenGardening", subtype = "appearance", items = {
        { 199647, "Dragon Garden Fork", { requirements = "Valdrakken Accord Renown 6" } },
        { 199651, "Dragon Garden Hoe", { requirements = "Valdrakken Accord Renown 6" } },
        { 199652, "Dragon Garden Rake", { requirements = "Valdrakken Accord Renown 6" } },
        { 199653, "Dragon Garden Hand Shovel", { requirements = "Valdrakken Accord Renown 6" } },
        { 199654, "Dragon Garden Shovel", { requirements = "Valdrakken Accord Renown 6" } },
    } },
    { detailKey = "valdrakkenDragonspawnArmor", subtype = "appearance", items = {
        { 199655, "Black Dragonspawn Shoulderpads", { requirements = "Valdrakken Accord Renown 10" } },
        { 199656, "Blue Dragonspawn Shoulderpads", { requirements = "Valdrakken Accord Renown 10" } },
        { 199657, "Bronze Dragonspawn Shoulderpads", { requirements = "Valdrakken Accord Renown 10" } },
        { 199658, "Green Dragonspawn Shoulderpads", { requirements = "Valdrakken Accord Renown 10" } },
        { 199659, "Red Dragonspawn Shoulderpads", { requirements = "Valdrakken Accord Renown 10" } },
        { 199682, "Bronze Drakonid Helmet", { requirements = "Valdrakken Accord Renown 17" } },
        { 199681, "Cobalt Drakonid Helmet", { requirements = "Valdrakken Accord Renown 17" } },
        { 199684, "Crimson Drakonid Helmet", { requirements = "Valdrakken Accord Renown 17" } },
        { 199680, "Obsidian Drakonid Helmet", { requirements = "Valdrakken Accord Renown 17" } },
        { 199683, "Verdant Drakonid Helmet", { requirements = "Valdrakken Accord Renown 17" } },
        { 199662, "Amber Jeweled Shoulderpads", { requirements = "Valdrakken Accord Renown 28" } },
        { 199661, "Azure Jeweled Shoulderpads", { requirements = "Valdrakken Accord Renown 28" } },
        { 199663, "Emerald Jeweled Shoulderpads", { requirements = "Valdrakken Accord Renown 28" } },
        { 199660, "Obsidian Jeweled Shoulderpads", { requirements = "Valdrakken Accord Renown 28" } },
        { 199664, "Ruby Jeweled Shoulderpads", { requirements = "Valdrakken Accord Renown 28" } },
        { 199670, "Black Drakonid Shoulderplates", { requirements = "Valdrakken Accord Renown 28" } },
        { 199672, "Bronze Drakonid Shoulderplates", { requirements = "Valdrakken Accord Renown 28" } },
        { 199671, "Cobalt Drakonid Shoulderplates", { requirements = "Valdrakken Accord Renown 28" } },
        { 199674, "Crimson Drakonid Shoulderplates", { requirements = "Valdrakken Accord Renown 28" } },
        { 199673, "Verdant Drakonid Shoulderplates", { requirements = "Valdrakken Accord Renown 28" } },
    } },
    { detailKey = "valdrakkenTitanWeapons", subtype = "appearance", items = {
        { 199774, "Ancient Titan Blunderbuss", { requirements = "Valdrakken Accord Renown 13" } },
        { 199772, "Titan Gatekeeper's Shield", { requirements = "Valdrakken Accord Renown 13" } },
        { 199775, "Titan Keeper's Gladius", { requirements = "Valdrakken Accord Renown 13" } },
        { 199776, "Titan Watcher's Broadsword", { requirements = "Valdrakken Accord Renown 13" } },
        { 199773, "Titan Watcher's Scepter", { requirements = "Valdrakken Accord Renown 13" } },
    } },
    { detailKey = "valdrakkenClothing", subtype = "ensemble", items = {
        { 199754, "Ensemble: Azure Valdrakken Clothing", { requirements = "Valdrakken Accord Renown 20" } },
        { 199753, "Ensemble: Black Valdrakken Clothing", { requirements = "Valdrakken Accord Renown 20" } },
        { 199756, "Ensemble: Bronze Valdrakken Clothing", { requirements = "Valdrakken Accord Renown 20" } },
        { 199752, "Ensemble: Crimson Valdrakken Clothing", { requirements = "Valdrakken Accord Renown 20" } },
        { 199755, "Ensemble: Green Valdrakken Clothing", { requirements = "Valdrakken Accord Renown 20" } },
    } },
    { detailKey = "valdrakkenCivilianTools", subtype = "appearance", items = {
        { 199742, "A Mender's Mentality", { requirements = "Valdrakken Accord Renown 25" } },
        { 199744, "Academy Student's Journal", { requirements = "Valdrakken Accord Renown 25" } },
        { 199741, "Compendium of Advanced Spells", { requirements = "Valdrakken Accord Renown 25" } },
        { 199745, "Everflame Night Torch", { requirements = "Valdrakken Accord Renown 25" } },
        { 194320, "Reinforced Lavender Bottle", { requirements = "Valdrakken Accord Renown 25" } },
        { 199743, "Runic Symbols and their Meaning", { requirements = "Valdrakken Accord Renown 25" } },
        { 198388, "Swirling Draconian Concoction", { requirements = "Valdrakken Accord Renown 25" } },
        { 198389, "Weighted Potion Cylinder", { requirements = "Valdrakken Accord Renown 25" } },
    } },
    { detailKey = "valdrakkenDragonWeapons", subtype = "appearance", items = {
        { 199736, "Amber Dragonflame Blade", { requirements = "Valdrakken Accord Renown 29" } },
        { 199739, "Emerald Dragonflame Blade", { requirements = "Valdrakken Accord Renown 29" } },
        { 199738, "Ruby Dragonflame Blade", { requirements = "Valdrakken Accord Renown 29" } },
        { 200456, "Valdrakken Armor Opener", { requirements = "Valdrakken Accord Renown 29" } },
        { 199825, "Valdrakken Belt Knife", { requirements = "Valdrakken Accord Renown 29" } },
        { 199700, "Valdrakken Bladewing Decapitator", { requirements = "Valdrakken Accord Renown 29" } },
        { 199730, "Valdrakken Bladewing Staff", { requirements = "Valdrakken Accord Renown 29" } },
        { 201796, "Valdrakken Drakonid's Claw", { requirements = "Valdrakken Accord Renown 29" } },
        { 199823, "Valdrakken Gatekeeper's Polearm", { requirements = "Valdrakken Accord Renown 29" } },
        { 199702, "Valdrakken Guard's Barrier", { requirements = "Valdrakken Accord Renown 29" } },
        { 201795, "Valdrakken Guard's Claw", { requirements = "Valdrakken Accord Renown 29" } },
        { 199734, "Valdrakken Guard's Cutlass", { requirements = "Valdrakken Accord Renown 29" } },
        { 199820, "Valdrakken Guard's Skullsplitter", { requirements = "Valdrakken Accord Renown 29" } },
        { 199705, "Valdrakken Guard's Spear", { requirements = "Valdrakken Accord Renown 29" } },
        { 199821, "Valdrakken Serrated Shortsword", { requirements = "Valdrakken Accord Renown 29" } },
        { 199726, "Valdrakken Spellweaver's Scepter", { requirements = "Valdrakken Accord Renown 29" } },
        { 199728, "Valdrakken Spellweaver's Stave", { requirements = "Valdrakken Accord Renown 29" } },
        { 199732, "Valdrakken Wing Glaive", { requirements = "Valdrakken Accord Renown 29" } },
        { 199707, "Valdrakken Wingguard Polearm", { requirements = "Valdrakken Accord Renown 29" } },
    } },
    { detailKey = "iskaaraCookingAndHats", subtype = "appearance", items = {
        { 200749, "Tuskarr Clobbering Board", { requirements = "Iskaara Tuskarr Renown 4" } },
        { 200748, "Tuskarr Ulu Knife", { requirements = "Iskaara Tuskarr Renown 4" } },
        { 199531, "Red Stocking Cap", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199532, "Grey Stocking Cap", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199533, "Green Stocking Cap", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199534, "Blue Stocking Cap", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199535, "Crimson Ear Warmer", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199536, "Ocean Grey Ear Warmer", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199537, "Forest Green Ear Warmer", { requirements = "Iskaara Tuskarr Renown 6" } },
        { 199538, "Azure Ear Warmer", { requirements = "Iskaara Tuskarr Renown 6" } },
    } },
    { detailKey = "iskaaraTraderGear", subtype = "appearance", items = {
        { 199877, "Ensemble: Tuskarr Trader's Leather Armor", { subtype = "ensemble", requirements = "Iskaara Tuskarr Renown 12" } },
        { 199872, "Tuskarr Trader's Cloak", { requirements = "Iskaara Tuskarr Renown 12" } },
        { 199852, "Rustic Fisherman's Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199853, "Tan Fisherman's Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199854, "Dark Fisherman's Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199855, "Burgundy Fisherman's Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199856, "Rustic Tuskarr Traders Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199857, "Tan Tuskarr Traders Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199858, "Dark Tuskarr Traders Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199859, "Burgundy Tuskarr Traders Pack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199860, "Rustic Tuskarr Backpack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199861, "Tan Tuskarr Backpack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199862, "Dark Tuskarr Backpack", { requirements = "Iskaara Tuskarr Renown 16" } },
        { 199863, "Burgundy Tuskarr Backpack", { requirements = "Iskaara Tuskarr Renown 16" } },
    } },
    { detailKey = "iskaaraWeaponsAndShoulders", subtype = "appearance", items = {
        { 199878, "Tuskarr Timber Splitter", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199879, "Tuskarr Fisherman's Dagger", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199880, "Tuskarr Leviathan's Hook", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199881, "Tuskarr Fisherman's Harpoon", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199882, "Tuskarr Mystic's Stave", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199883, "Tuskarr Sharktooth Bolthrower", { requirements = "Iskaara Tuskarr Renown 24" } },
        { 199539, "Blue Tufted Shoulderpads", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199540, "Green Tufted Shoulderpads", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199541, "Grey Tufted Shoulderpads", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199542, "Red Tufted Shoulderpads", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199543, "Azure Depths Shoulderguards", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199544, "Murky Depths Shoulderguards", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199545, "Grey Depths Shoulderguards", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199546, "Crimson Depths Shoulderguards", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199547, "Spine Reinforced Spaulders", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199548, "Rugged Seaspawn Spaulders", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199549, "Depth Delvers Spaulders", { requirements = "Iskaara Tuskarr Renown 28" } },
        { 199550, "Bloody Shorestalker's Spaulders", { requirements = "Iskaara Tuskarr Renown 28" } },
    } },
    { detailKey = "iskaaraPawPacks", subtype = "appearance", items = {
        { 198337, "Azure Paw Pack", { requirements = "Iskaara Tuskarr Renown 29" } },
        { 198338, "Black Print Paw Pack", { requirements = "Iskaara Tuskarr Renown 29" } },
        { 198339, "Dark Blue Paw Pack", { requirements = "Iskaara Tuskarr Renown 29" } },
        { 198340, "Red Print Paw Pack", { requirements = "Iskaara Tuskarr Renown 29" } },
        { 198341, "Tan Paw Pack", { requirements = "Iskaara Tuskarr Renown 29" } },
    } },
    { detailKey = "bigKinookLadle", subtype = "appearance", items = {
        { 200882, "Big Kinook's Spare Ladle", { requirements = "Leftovers' Revenge achievement" } },
    } },
    { detailKey = "maruukArmor", subtype = "appearance", items = {
        { 200481, "Ohn'ir Midnight Helm" }, { 200482, "Shikaar Harrier's Visor" }, { 200483, "Nokhud Battle Helm" },
        { 200484, "Ohn'ir Dawnlight Hat" }, { 200485, "Ohn'ir Dusklight Cap" }, { 200486, "Ohn'ir Daylight Visor" },
        { 200487, "Shikaar Hunter's Visor" }, { 200488, "Shikaar Huntmaster's Visor" }, { 200489, "Shikaar Scout's Visor" },
        { 200490, "Nokhud Reaver's Helm" }, { 200491, "Nokhud Champion's Helm" }, { 200492, "Nokhud Warlord's Helm" },
        { 200493, "Ohn'ir Daylight Shoulderpads" }, { 200494, "Shikaar Scout's Shoulderpads" }, { 200495, "Nokhud Warlord's Shoulderpads" },
        { 200496, "Shikaar Huntmaster's Shoulderpads" }, { 200497, "Shikaar Hunter's Shoulderpads" }, { 200498, "Shikaar Harrier's Shoulderpads" },
        { 200499, "Nokhud Battle Shoulderpads" }, { 200500, "Nokhud Champion's Shoulderpads" }, { 200501, "Nokhud Reaver's Shoulderpads" },
        { 200502, "Ohn'ir Midnight Shoulderpads" }, { 200503, "Ohn'ir Dusklight Shoulderpads" }, { 200504, "Ohn'ir Dawnlight Shoulderpads" },
    } },
    { detailKey = "maruukWeapons", subtype = "appearance", items = {
        { 200510, "Huntstrider Spear" }, { 200511, "Stonework Greatspear" }, { 200512, "Teerai Warspear" },
        { 200517, "Nokhud Warspear" }, { 200518, "Nokhud Goliath's Spear" }, { 200520, "Mammothbone Knife" },
        { 200521, "Maruuk Boneblade" }, { 200522, "Maruukai Smith's Tongs" }, { 200523, "Smith's Stoneworked Mallet" },
        { 200524, "Nokhud Warhammer" }, { 200525, "Massive Stone Sledgehammer" }, { 200534, "Toghus Poleaxe" },
        { 200539, "Khansguard Shield" }, { 200540, "Improvised Maruuk Barrier" }, { 200541, "Fur-Lined Safeguard" },
    } },
    { detailKey = "cobaltAssemblyArmor", subtype = "appearance", items = {
        { 191829, "Cobalt Guardian's Hauberk", { requirements = "Cobalt Assembly High power" } },
        { 191830, "Cobalt Guardian's Grips", { requirements = "Cobalt Assembly High power" } },
        { 191831, "Cobalt Guardian's Helm", { requirements = "Cobalt Assembly High power" } },
        { 191832, "Cobalt Guardian's Leggings", { requirements = "Cobalt Assembly High power" } },
        { 191833, "Cobalt Guardian's Pauldron", { requirements = "Cobalt Assembly High power" } },
        { 191834, "Cobalt Guardian's Belt", { requirements = "Cobalt Assembly High power" } },
        { 191835, "Cobalt Guardian's Bracers", { requirements = "Cobalt Assembly High power" } },
        { 191836, "Cobalt Guardian's Cover", { requirements = "Cobalt Assembly High power" } },
    } },
    { detailKey = "cobaltAssemblyWeapons", subtype = "appearance", items = {
        { 199735, "Cobalt Guardian's Cutlass", { requirements = "Cobalt Assembly Maximum power" } },
        { 200559, "Cobalt Duelist's Saber", { requirements = "Cobalt Assembly Maximum power" } },
        { 199737, "Cobalt Dragonflame Blade", { requirements = "Cobalt Assembly Maximum power" } },
        { 199733, "Cobalt Defender's Wingglaive", { requirements = "Cobalt Assembly Maximum power" } },
        { 199731, "Cobalt Bladewing Staff", { requirements = "Cobalt Assembly Maximum power" } },
        { 199729, "Cobalt Essence Weaver's Staff", { requirements = "Cobalt Assembly Maximum power" } },
        { 199727, "Cobalt Essence Weaver's Scepter", { requirements = "Cobalt Assembly Maximum power" } },
        { 199708, "Cobalt Wingguard's Polearm", { requirements = "Cobalt Assembly Maximum power" } },
        { 199706, "Cobalt Stalker's Lancet", { requirements = "Cobalt Assembly Maximum power" } },
        { 199703, "Steadfast Cobalt Bulwark", { requirements = "Cobalt Assembly Maximum power" } },
        { 201371, "Cobalt Defender's Shredder", { requirements = "Cobalt Assembly Maximum power" } },
        { 199701, "Cobalt Dragonwing Decapitator", { requirements = "Cobalt Assembly Maximum power" } },
    } },
    { detailKey = "blackDragonReputation", subtype = "appearance", items = {
        { 200952, "Ensemble: Obsidian Dracthyr Battlegear Mail Armor", { subtype = "ensemble", requirements = "Wrathion Cohort" } },
        { 200963, "Ensemble: Sabellian's Battlegear Cloth Armor", { subtype = "ensemble", requirements = "Sabellian Ally" } },
        { 200996, "Obsidian Guard's Claw", { requirements = "Wrathion or Sabellian Fang" } },
        { 199740, "Onyx Dragonflame Blade", { requirements = "Wrathion or Sabellian Fang" } },
        { 200997, "Obsidian Guard's Saber", { requirements = "Wrathion Fang" } },
        { 200998, "Obsidian Wing Glaive", { requirements = "Wrathion Fang" } },
        { 200985, "Obsidian Wingedguard Polearm", { requirements = "Wrathion Fang" } },
        { 200987, "Obsidian Spellcarver's Stave", { requirements = "Wrathion Fang" } },
        { 200992, "Obsidian Spellweaver's Scepter", { requirements = "Wrathion Fang" } },
        { 200990, "Obsidian Guard's Cutlass", { requirements = "Sabellian Fang" } },
        { 200993, "Obsidian Guard's Barrier", { requirements = "Sabellian Fang" } },
        { 200986, "Obsidian Spellweaver's Stave", { requirements = "Sabellian Fang" } },
        { 200988, "Obsidian Guard's Skullsplitter", { requirements = "Sabellian Fang" } },
        { 200983, "Obsidian Wingguard Polearm", { requirements = "Sabellian Fang" } },
    } },
    { detailKey = "dragonflightIllusions", subtype = "illusion", items = {
        { 200883, "Illusion: Primal Air" }, { 200905, "Illusion: Primal Earth" }, { 200906, "Illusion: Primal Fire" },
        { 200907, "Illusion: Primal Frost" }, { 200470, "Illusion: Primal Mastery" },
    } },
    { detailKey = "dragonflightJewelcrafting", subtype = "appearance", items = {
        { 193371, "\"Rhinestone\" Sunglasses" }, { 194748, "Split-Lens Specs" },
    } },
    { detailKey = "lifePoolsWateringCan", subtype = "appearance", items = {
        { 194418, "Life Pools Watering Can", { requirements = "Level 58; complete A Better Start" } },
    } },
    { detailKey = "brackenhideWorldDrops", subtype = "appearance", items = {
        { 201363, "Brackenhide Hollow Maul" }, { 201365, "Brackenhide Gnoll Guard" }, { 201367, "Hollow Hunter's Sticker" },
        { 201368, "Brackenhide Hollow Barbslinger" }, { 201369, "Hollow Greatwood Pestilence" }, { 201370, "Brackenhide Skullcracker" },
    } },
    { detailKey = "imbuWorldDrops", subtype = "appearance", items = {
        { 201372, "Imbu Tuskarr Axe" }, { 201373, "Imbu Net Cutter" }, { 201374, "Tuskarr Fishing Pike" },
        { 201375, "Imbu Warrior's Club" }, { 201376, "Imbu Tuskarr Mace" }, { 201377, "Tuskarr Elder's Staff" },
        { 201378, "Tuskarr Angler's Crossbow" },
    } },
    { detailKey = "nokhudWorldDrops", subtype = "appearance", items = {
        { 201380, "Nokhud Hunter's Bow" }, { 201381, "Nokhud Battle-Knife" }, { 201382, "Centaur Warglaives" },
        { 201383, "Nokhud Stalker's Spear" }, { 201384, "Centaur Tracker's Javelin" }, { 201385, "Nokhud Centaur Warstaff" },
        { 201024, "Nokhudon Mantle" }, { 201025, "Nokhudon Harness" }, { 201027, "Nokhudon Breeches" },
        { 201028, "Nokhudon Boots" }, { 201029, "Nokhudon Hood" }, { 201030, "Nokhudon Grips" },
        { 201031, "Nokhudon Cloak" }, { 201032, "Nokhudon Wraps" }, { 201034, "Nokhudon Girdle" },
    } },
    { detailKey = "drakonidWorldDrops", subtype = "appearance", items = {
        { 201386, "Drakonid Defender's Pike" }, { 201387, "Drakonid Stalker's Halberd" }, { 201388, "Dragonspawn Wingtipped Staff" },
        { 201389, "Wingcrest Battle Staff" }, { 201390, "Devastating Drakonid Waraxe" }, { 201391, "Drakonid Enforcer's Hidesplitter" },
        { 201392, "Drakonid Striker's Cutlass" }, { 201393, "Dragonspawn Spellweaver's Focus" }, { 201394, "Drakonid's Jade Bulwark" },
        { 201395, "Wingcrest Scimitar" }, { 201396, "Hidepiercing Claw Extensions" },
    } },
    { detailKey = "obsidianWorldDrops", subtype = "appearance", items = {
        { 201429, "Obsidian Fist" }, { 201430, "Burning Mallet" }, { 201431, "Obsidian Tyrant's Mace" },
        { 201432, "Obsidian Dragontooth" }, { 201433, "Citadel Warden's Mace" }, { 201434, "Obsidian Barrier" },
        { 201035, "Citadel Crusher's Pauldrons" }, { 201036, "Citadel Crusher's Chestplate" }, { 201037, "Citadel Crusher's Legguards" },
        { 201038, "Citadel Crusher's Footwraps" }, { 201039, "Citadel Crusher's Helm" }, { 201040, "Citadel Crusher's Gauntlets" },
        { 201041, "Citadel Crusher's Cloak" }, { 201042, "Obsidian Crusher's Bracers" }, { 201043, "Obsidian Crusher's Belt" },
    } },
    { detailKey = "tyrholdWorldDrops", subtype = "appearance", items = {
        { 201455, "Tyrhold Broadsword" }, { 201456, "Tyrhold Carbine" }, { 201457, "Tyrhold Relic" },
        { 201458, "Aegis of Tyrhold" }, { 201459, "Tyrhold Shortsword" }, { 201460, "Gavel of Tyrhold" }, { 201461, "Tyrhold Pinnacle" },
        { 201048, "Tyrhold Epaulets" }, { 201049, "Tyrhold Robe" }, { 201050, "Tyrhold Leggings" },
        { 201051, "Tyrhold Slippers" }, { 201052, "Tyrhold Visage" }, { 201053, "Tyrhold Gloves" },
        { 201054, "Tyrhold Drape" }, { 201055, "Tyrhold Bindings" }, { 201056, "Tyrhold Sash" },
    } },
    { detailKey = "crimsonEliteWeapons", subtype = "appearance", items = {
        { 202123, "Crimson Gladiator's Greatbow" }, { 202124, "Crimson Gladiator's Crossbow" },
        { 202125, "Crimson Gladiator's Greatstaff" }, { 202126, "Crimson Gladiator's Spellblade" },
        { 202127, "Crimson Gladiator's Censer" }, { 202128, "Crimson Gladiator's Rod" },
        { 202129, "Crimson Gladiator's Barrier" }, { 202130, "Crimson Gladiator's Bulwark" },
        { 202131, "Crimson Gladiator's Sword" }, { 202132, "Crimson Gladiator's Warhammer" },
        { 202133, "Crimson Gladiator's Blade" }, { 202134, "Crimson Gladiator's Glaive" },
        { 202135, "Crimson Gladiator's Poleaxe" }, { 202136, "Crimson Gladiator's Quarterstaff" },
        { 202137, "Crimson Gladiator's Greataxe" }, { 202138, "Crimson Gladiator's Greatmace" },
        { 202139, "Crimson Gladiator's Scepter" }, { 202140, "Crimson Gladiator's Claw" },
    } },
    { detailKey = "shadowlandsPvP", subtype = "ensemble", items = {
        { 201841, "Ensemble: Cosmic Aspirant's Plate Armor" }, { 201842, "Ensemble: Cosmic Aspirant's Mail Armor" },
        { 201843, "Ensemble: Cosmic Aspirant's Leather Armor" }, { 201844, "Ensemble: Cosmic Aspirant's Cloth Armor" },
        { 201845, "Ensemble: Cosmic Gladiator's Warrior Armor" }, { 201846, "Ensemble: Cosmic Gladiator's Warlock Armor" },
        { 201847, "Ensemble: Cosmic Gladiator's Shaman Armor" }, { 201848, "Ensemble: Cosmic Gladiator's Rogue Armor" },
        { 201849, "Ensemble: Cosmic Gladiator's Priest Armor" }, { 201850, "Ensemble: Cosmic Gladiator's Paladin Armor" },
        { 201851, "Ensemble: Cosmic Gladiator's Monk Armor" }, { 201852, "Ensemble: Cosmic Gladiator's Mage Armor" },
        { 201853, "Ensemble: Cosmic Gladiator's Hunter Armor" }, { 201854, "Ensemble: Cosmic Gladiator's Druid Armor" },
        { 201855, "Ensemble: Cosmic Gladiator's Demon Hunter Armor" }, { 201856, "Ensemble: Cosmic Gladiator's Death Knight Armor" },
        { 201857, "Ensemble: Unchained Aspirant's Plate Armor" }, { 201858, "Ensemble: Unchained Aspirant's Mail Armor" },
        { 201859, "Ensemble: Unchained Aspirant's Leather Armor" }, { 201860, "Ensemble: Unchained Aspirant's Cloth Armor" },
        { 201861, "Ensemble: Unchained Gladiator's Plate Armor" }, { 201862, "Ensemble: Unchained Gladiator's Mail Armor" },
        { 201863, "Ensemble: Unchained Gladiator's Leather Armor" }, { 201864, "Ensemble: Unchained Gladiator's Cloth Armor" },
        { 201865, "Ensemble: Sinful Aspirant's Plate Armor" }, { 201866, "Ensemble: Sinful Aspirant's Mail Armor" },
        { 201867, "Ensemble: Sinful Aspirant's Leather Armor" }, { 201868, "Ensemble: Sinful Aspirant's Cloth Armor" },
        { 201869, "Ensemble: Sinful Gladiator's Plate Armor" }, { 201870, "Ensemble: Sinful Gladiator's Mail Armor" },
        { 201871, "Ensemble: Sinful Gladiator's Leather Armor" }, { 201872, "Ensemble: Sinful Gladiator's Cloth Armor" },
        { 201873, "Arsenal: Cosmic Gladiator's Weapons", { subtype = "arsenal" } },
        { 201875, "Arsenal: Cosmic Aspirant's Weapons", { subtype = "arsenal" } },
        { 201876, "Arsenal: Unchained Gladiator's Weapons", { subtype = "arsenal" } },
        { 201877, "Arsenal: Unchained Aspirant's Weapons", { subtype = "arsenal" } },
        { 201878, "Arsenal: Sinful Aspirant's Weapons", { subtype = "arsenal" } },
        { 201879, "Arsenal: Sinful Gladiator's Revendreth Weapons", { subtype = "arsenal" } },
        { 201880, "Arsenal: Sinful Gladiator's Maldraxxus Weapons", { subtype = "arsenal" } },
        { 201881, "Arsenal: Sinful Gladiator's Bastion Weapons", { subtype = "arsenal" } },
        { 201882, "Arsenal: Sinful Gladiator's Ardenweald Weapons", { subtype = "arsenal" } },
    } },
})

local PATCH_10_0_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "stormsFury", subtype = "appearance", items = {
        { 201442, "Primal Revenant's Frostblade" }, { 201443, "Primal Revenant's Icewall" },
        { 201444, "Primal Revenant's Earthblade" }, { 201445, "Primal Revenant's Emberblade" },
        { 201446, "Primal Revenant's Firewall" }, { 201447, "Primal Revenant's Breezeblade" },
        { 201448, "Primal Revenant's Windwall" },
    } },
})

local PATCH_10_0_7_COSMETICS = BuildCosmeticEntries({
    { detailKey = "humanHeritage", subtype = "ensemble", items = {
        { 203211, "Ensemble: Lion's Heritage Blue Armor Set" },
        { 203212, "Ensemble: Lion's Heritage Scarlet Armor Set" },
        { 203213, "Ensemble: Lion's Heritage White Armor Set" },
    } },
    { detailKey = "orcHeritage", subtype = "ensemble", items = {
        { 203214, "Ensemble: Wolf's Heritage Blackrock Armor Set" },
        { 203215, "Ensemble: Wolf's Heritage Frostwolf Armor Set" },
        { 203216, "Ensemble: Wolf's Heritage Warsong Armor Set" },
    } },
    { detailKey = "oldHatreds", subtype = "appearance", items = {
        { 203679, "Ancestral Bloodhoof Totem" }, { 204084, "Ancestor's Might" },
    } },
    { detailKey = "oldZulGurub", subtype = "ensemble", items = {
        { 203974, "Ensemble: Zandalar Haruspec" }, { 203975, "Ensemble: Zandalar Predator" },
        { 203976, "Ensemble: Zandalar Illusionist" }, { 203977, "Ensemble: Zandalar Freethinker" },
        { 203978, "Ensemble: Zandalar Confessor" }, { 203979, "Ensemble: Zandalar Madcap" },
        { 203980, "Ensemble: Zandalar Augur" }, { 203981, "Ensemble: Zandalar Demoniac" },
        { 203982, "Ensemble: Zandalar Vindicator" }, { 203983, "Ensemble: Bloodtinged Cloth" },
        { 203984, "Ensemble: Blooddrenched Leather" }, { 203985, "Ensemble: Bloodstained Mail" },
        { 203986, "Ensemble: Bloodsoaked Plate" },
    } },
    { detailKey = "forbiddenReachTreysh", subtype = "appearance", items = {
        { 204562, "Maruuk Maul", { cost = "5,000 Elemental Overflow" } },
        { 204563, "Morqut Club", { cost = "5,000 Elemental Overflow" } },
        { 204564, "Dragonscale Expeditioner's Rifle", { cost = "5,000 Elemental Overflow" } },
        { 204566, "Journal of the Forbidden Reach", { cost = "5,000 Elemental Overflow" } },
        { 204569, "Valdrakken Talons", { cost = "5,000 Elemental Overflow" } },
        { 204570, "Valdrakken Pocketknife", { cost = "5,000 Elemental Overflow" } },
        { 204571, "Bulwark of the Forbidden Reach", { cost = "5,000 Elemental Overflow" } },
    } },
    { detailKey = "squareHolders", subtype = "appearance", items = {
        { 204404, "Square Holders", { requirements = "Classic Jewelcrafting 300 to craft" } },
    } },
})

local PATCH_10_1_COSMETICS = BuildCosmeticEntries({
    { detailKey = "blackDragonflightVestments", subtype = "ensemble", items = {
        { 204447, "Ensemble: Black Dragonflight's Vestments" },
    } },
    { detailKey = "loammRenown", subtype = "ensemble", items = {
        { 205363, "Ensemble: Ornate Black Dragon Labwear", { requirements = "Loamm Niffen Renown 16", cost = "250 Dragon Isles Supplies" } },
        { 205971, "Rock Breaking Digger", { subtype = "appearance", requirements = "Loamm Niffen Renown 18", cost = "200 Dragon Isles Supplies" } },
        { 205972, "Decorative Niffen Sword", { subtype = "appearance", requirements = "Loamm Niffen Renown 18", cost = "200 Dragon Isles Supplies" } },
    } },
    { detailKey = "ponzoTopper", subtype = "appearance", items = {
        { 205421, "Ponzo's Scheming Topper", { requirements = "Loamm Niffen Renown 12", cost = "249 Barter Boulders after negotiating" } },
    } },
    { detailKey = "azureRenewal", subtype = "ensemble", items = {
        { 205958, "Ensemble: Azure Renewal Finery" },
    } },
    { detailKey = "moltenHoard", subtype = "appearance", items = {
        { 205981, "Molten Primal Fang" },
    } },
    { detailKey = "obsidianEliteWeapons", subtype = "appearance", items = {
        { 206044, "Obsidian Gladiator's Axe" },
        { 206137, "Obsidian Gladiator's Dagger" },
        { 206146, "Obsidian Gladiator's Warglaive" },
        { 206147, "Obsidian Gladiator's Polearm" },
        { 206148, "Obsidian Gladiator's Staff" },
        { 206149, "Obsidian Gladiator's Rifle" },
        { 206150, "Obsidian Gladiator's Mace" },
        { 206151, "Obsidian Gladiator's Rod" },
        { 206152, "Obsidian Gladiator's Shield" },
        { 206153, "Obsidian Gladiator's Claws" },
        { 206154, "Obsidian Gladiator's Bow" },
    } },
})

local PATCH_10_1_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "timeRiftAzmourne", subtype = "appearance", items = {
        { 206778, "Northern Ballista" },
        { 206783, "Bonegale Greataxe" },
        { 206784, "Blighted Greatbow" },
        { 206786, "Scourge Victorious Tabard" },
        { 206793, "Upraised Headstone" },
        { 206797, "Frostspire" },
        { 206802, "Plague-Touched Stave" },
        { 206803, "Cursed Blade of the Scourge" },
    } },
    { detailKey = "timeRiftAzeroth", subtype = "appearance", items = {
        { 206777, "Energy Projection Regulator" },
        { 206779, "Steel-Lined Locking System" },
        { 206780, "Overclocked Hand Cannon" },
        { 206785, "Defect Retirement Tool" },
        { 206796, "Energetic Power Knife" },
        { 206804, "Clockwork Mallet" },
        { 206807, "Order-Powered Mechblade" },
    } },
    { detailKey = "timeRiftAzewrath", subtype = "appearance", items = {
        { 206764, "Fel-Infused Polearm" },
        { 206766, "Jagged Treason" },
        { 206781, "Demonic Bone-Crusher" },
        { 206789, "Heart-Slicer" },
        { 206790, "Fel-Ridden Divider" },
        { 206791, "Branded Greatmaul" },
        { 206801, "Inferna Rod" },
    } },
    { detailKey = "timeRiftAzqroth", subtype = "appearance", items = {
        { 206765, "Its Focused Gaze" },
        { 206768, "Serrated Parasite" },
        { 206769, "Unknown Horror's Arm" },
        { 206770, "Consuming Claws" },
        { 206776, "Heretical Gavel" },
        { 206792, "Subjugator's Shield" },
        { 206799, "Pauldrons of the Fire Lord" },
    } },
    { detailKey = "timeRiftUlderoth", subtype = "appearance", items = {
        { 206767, "Valhalas Peacekeeper" },
        { 206782, "Titanic Hourglass" },
        { 206788, "Utopian Tabard" },
        { 206794, "Hand of Order" },
        { 206795, "Titan Watcher's Shortblade" },
        { 206798, "Valhalas Heartstriker" },
        { 207046, "Ensemble: Valhalas Ceremonial Armor", { subtype = "ensemble" } },
        { 207047, "Ensemble: Hauberk of Discipline", { subtype = "ensemble" } },
        { 207048, "Ensemble: Lifegiver's Garms", { subtype = "ensemble" } },
        { 207049, "Ensemble: Decorous Garments", { subtype = "ensemble" } },
    } },
    { detailKey = "timeRiftWarlands", subtype = "appearance", items = {
        { 206808, "Warmonger's Robe" },
        { 206809, "Warmonger's Wristwraps" },
        { 206810, "Warmonger's Cord" },
        { 206812, "Warmonger's Epaulettes" },
        { 206814, "Warmonger's Leggings" },
        { 206816, "Warmonger's Skullcap" },
        { 206817, "Warmonger's Mitts" },
        { 206818, "Warmonger's Treads" },
        { 206819, "Warmonger's Shroud" },
        { 206821, "Jingoist's Robe" },
        { 206822, "Jingoist's Wristwraps" },
        { 206823, "Jingoist's Cord" },
        { 206824, "Jingoist's Epaulettes" },
        { 206825, "Jingoist's Leggings" },
        { 206826, "Jingoist's Hood" },
        { 206827, "Jingoist's Mitts" },
        { 206828, "Jingoist's Treads" },
        { 206829, "Jingoist's Shroud" },
        { 206831, "Jingoist's Cloak" },
        { 206832, "Jingoist's Boots" },
        { 206833, "Jingoist's Gloves" },
        { 206834, "Jingoist's Headcover" },
        { 206835, "Jingoist's Pantaloons" },
        { 206836, "Jingoist's Spaulders" },
        { 206837, "Jingoist's Belt" },
        { 206838, "Jingoist's Bracers" },
        { 206839, "Jingoist's Cuirass" },
        { 206840, "Warmonger's Cuirass" },
        { 206841, "Warmonger's Bracers" },
        { 206842, "Warmonger's Belt" },
        { 206843, "Warmonger's Spaulders" },
        { 206845, "Warmonger's Pantaloons" },
        { 206846, "Warmonger's Headcover" },
        { 206847, "Warmonger's Gloves" },
        { 206848, "Warmonger's Boots" },
        { 206849, "Warmonger's Cloak" },
        { 206850, "Warmonger's Drape" },
        { 206851, "Warmonger's Footpads" },
        { 206852, "Warmonger's Grips" },
        { 206853, "Warmonger's Casque" },
        { 206854, "Warmonger's Legguards" },
        { 206855, "Warmonger's Mantle" },
        { 206856, "Warmonger's Clasp" },
        { 206857, "Warmonger's Bonds" },
        { 206858, "Warmonger's Chainmail" },
        { 206860, "Jingoist's Chainmail" },
        { 206861, "Jingoist's Bonds" },
        { 206862, "Jingoist's Clasp" },
        { 206863, "Jingoist's Mantle" },
        { 206864, "Jingoist's Legguards" },
        { 206865, "Jingoist's Casque" },
        { 206866, "Jingoist's Grips" },
        { 206867, "Jingoist's Footpads" },
        { 206868, "Jingoist's Drape" },
        { 206870, "Jingoist's Cape" },
        { 206871, "Jingoist's Warboots" },
        { 206872, "Jingoist's Gauntlets" },
        { 206873, "Jingoist's Greathelm" },
        { 206874, "Jingoist's Legplates" },
        { 206875, "Jingoist's Pauldrons" },
        { 206876, "Jingoist's Girdle" },
        { 206877, "Jingoist's Vambraces" },
        { 206878, "Jingoist's Breastplate" },
        { 206879, "Warmonger's Breastplate" },
        { 206880, "Warmonger's Vambraces" },
        { 206881, "Warmonger's Girdle" },
        { 206882, "Warmonger's Pauldrons" },
        { 206883, "Warmonger's Legplates" },
        { 206884, "Warmonger's Greathelm" },
        { 206885, "Warmonger's Gauntlets" },
        { 206886, "Warmonger's Warboots" },
        { 206887, "Warmonger's Cape" },
        { 207014, "Jingoist's Slicer" },
        { 207015, "Warmonger's Ripper" },
    } },
    { detailKey = "eonsFringeHammers", subtype = "appearance", items = {
        { 206926, "Off-Sync Off-Hammer", { cost = "600 Dragon Isles Supplies" } },
        { 206927, "Depleted Chronoforged Mallet", { cost = "600 Dragon Isles Supplies" } },
        { 206928, "Echoing Temporadic Gavel", { cost = "600 Dragon Isles Supplies" } },
    } },
    { detailKey = "gildedSunglasses", subtype = "appearance", items = {
        { 206997, "Gilded Sunglasses" },
    } },
    { detailKey = "riftMenderVestments", subtype = "ensemble", items = {
        { 207020, "Ensemble: Rift-Mender's Vestments", { requirements = "Soridormi reputation rank 3: Rift-Mender" } },
    } },
    { detailKey = "infiniteAcolyte", subtype = "ensemble", items = {
        { 208490, "Ensemble: Infinite Acolyte's Regalia" },
    } },
})

local PATCH_10_1_7_COSMETICS = BuildCosmeticEntries({
    { detailKey = "nightElfHeritage", subtype = "ensemble", items = {
        { 208879, "Ensemble: Kaldorei Protector's Adornment" },
        { 208785, "Traditionalist's Kaldorei Blades", { subtype = "arsenal" } },
    } },
    { detailKey = "forsakenHeritage", subtype = "ensemble", items = {
        { 208475, "Ensemble: Forsaken Champion's Attire" },
        { 209065, "Forsaken Champion's Tabard", { subtype = "appearance" } },
        { 209068, "Queen Loyalist's Tabard", { subtype = "appearance" } },
    } },
    { detailKey = "manariArtifacts", subtype = "appearance", items = {
        { 208662, "Lightforged Seeker", { cost = "50 Empyrium, 30 Fiendish Leather, and 90 Veiled Argunite" } },
        { 208677, "Eredath Crystal Hammer", { cost = "75 Lightweave Cloth, 15 Argulite, and 90 Veiled Argunite" } },
        { 208683, "Arinor Ritual Baton", { cost = "50 Astral Glory, 40 Fiendish Leather, and 90 Veiled Argunite" } },
        { 208684, "Anchorite's Sorrow", { cost = "40 Astral Glory, 5 Labradorite, and 90 Veiled Argunite" } },
        { 208685, "Recovered Kaarinos Blade", { cost = "50 Empyrium, 15 Labradorite, and 90 Veiled Argunite" } },
        { 208686, "Velenite Claymore", { cost = "100 Empyrium, 5 Argulite, and 90 Veiled Argunite" } },
        { 208688, "Telaasti Mining Pick", { cost = "75 Empyrium, 5 Florid Malachite, and 90 Veiled Argunite" } },
        { 208755, "Ancient Soulpriest's Staff", { cost = "75 Lightweave Cloth, 15 Argulite, and 90 Veiled Argunite" } },
    } },
    { detailKey = "temporalBurdens", subtype = "ensemble", items = {
        { 210024, "Ensemble: Temporal Burdens" },
    } },
    { detailKey = "secretsCaps", subtype = "appearance", items = {
        { 208149, "Brown Tweed Cap", { requirements = "Complete The Inquisitive" } },
        { 208150, "Blue Tweed Cap", { requirements = "Complete Community Rumors by finding five buried satchels" } },
    } },
    { detailKey = "tyrsTitanKey", subtype = "arsenal", items = {
        { 208831, "Tyr's Titan Key" },
    } },
    { detailKey = "chromaticCalibration", subtype = "ensemble", items = {
        { 209062, "Ensemble: Chromatically Calibrated Holo-Gogs", { requirements = "Achievement 18901: Chromatic Calibration: Holo-Gogs" } },
        { 209063, "Ensemble: Chromatically Calibrated Bio-Optic Killshades", { requirements = "Achievement 18908: Chromatic Calibration: Bio-Optic Killshades" } },
        { 209064, "Ensemble: Chromatically Calibrated Retinal Armor", { requirements = "Achievement 18905: Chromatic Calibration: Retinal Armor" } },
        { 209066, "Ensemble: Chromatically Calibrated Cranial Cannons", { requirements = "Achievement 18906: Chromatic Calibration: Cranial Cannons" } },
        { 209067, "Ensemble: Chromatically Calibrated Ectoplasmic Specs", { requirements = "Achievement 18907: Chromatic Calibration: Ectoplasmic Specs" } },
    } },
    { detailKey = "tyrsGuardBulwark", subtype = "appearance", items = {
        { 208198, "Tyr's Guard Bulwark" },
    } },
})

local PATCH_10_2_COSMETICS = BuildCosmeticEntries({
    { detailKey = "tyrsGuard", subtype = "appearance", items = {
        { 208199, "Tabard of the Tyr's Guard" },
    } },
    { detailKey = "raimentOfAmirdrassil", subtype = "ensemble", items = {
        { 209604, "Ensemble: Raiment of Amirdrassil" },
    } },
    { detailKey = "emeraldBounties", subtype = "appearance", items = {
        { 209960, "Ceremonial Jacaranda Gown" },
        { 209961, "Ceremonial Jacaranda Cape" },
        { 209962, "Ceremonial Jacaranda Sandals" },
        { 209963, "Ceremonial Jacaranda Gloves" },
        { 209964, "Ceremonial Jacaranda Crown" },
        { 209965, "Ceremonial Jacaranda Pantaloons" },
        { 209966, "Ceremonial Jacaranda Branches" },
        { 209967, "Ceremonial Jacaranda Belt" },
        { 209968, "Ceremonial Jacaranda Wraps" },
        { 209969, "Vest of the Dreamfused Skull" },
        { 209970, "Pelt of the Dreamfused Skull" },
        { 209971, "Clogs of the Dreamfused Skull" },
        { 209972, "Grips of the Dreamfused Skull" },
        { 209973, "Visage of the Dreamfused Skull" },
        { 209974, "Leggings of the Dreamfused Skull" },
        { 209975, "Pauldrons of the Dreamfused Skull" },
        { 209976, "Buckle of the Dreamfused Skull" },
        { 209977, "Bracers of the Dreamfused Skull" },
        { 209978, "Barkbloom Tunic" },
        { 209979, "Barkbloom Cloak" },
        { 209980, "Barkbloom Talons" },
        { 209981, "Barkbloom Claws" },
        { 209982, "Barkbloom Mask" },
        { 209983, "Barkbloom Breeches" },
        { 209984, "Barkbloom Shoulderpads" },
        { 209985, "Barkbloom Sash" },
        { 209986, "Barkbloom Wristguards" },
        { 209987, "Overgrown Freyan Plate" },
        { 209988, "Overgrown Freyan Drape" },
        { 209989, "Overgrown Freyan Boots" },
        { 209990, "Overgrown Freyan Handguards" },
        { 209991, "Overgrown Freyan Helm" },
        { 209992, "Overgrown Freyan Legguards" },
        { 209993, "Overgrown Freyan Shoulderguards" },
        { 209994, "Overgrown Freyan Girdle" },
        { 209995, "Overgrown Freyan Vambraces" },
        { 210029, "Overgrown Freyan Hatchet" },
        { 210030, "Bow of the Dreamfused Skull" },
        { 210031, "Spike of the Dreamfused Skull" },
        { 210032, "Overgrown Freyan Smasher" },
        { 210033, "Essence of the Dreamfused Skull" },
        { 210034, "Overgrown Freyan Pike" },
        { 210035, "Ceremonial Jacaranda Crook" },
        { 210036, "Barkbloom Saber" },
        { 210037, "Ceremonial Jacaranda Slab" },
        { 210038, "Ceremonial Jacaranda Bloom" },
        { 210039, "Barkbloom Warglaive" },
    } },
    { detailKey = "emeraldDreamTreasures", subtype = "appearance", items = {
        { 210414, "Forest Lord's Antlers", { requirements = "Complete Treasures of the Emerald Dream" } },
        { 210434, "Visage of Ursol", { requirements = "Reach the Statue of the Bear Lord while the one-minute Bear Spirit Guardian buff is active; druids in Bear Form and Pandaren can also interact directly" } },
        { 210631, "Branch of Ashamane", { requirements = "Reach the Statue of the Ashen Panther while the one-minute Panther Spirit Guardian buff is active; druids in Cat Form/stealth can also interact directly" } },
        { 210659, "Branch of Aviana", { requirements = "Reach the Statue of the Sky Mistress while the one-minute Winged Spirit Guardian buff is active; druids in Flight Form and Dracthyr can also interact directly" } },
        { 210660, "Claw of Lo'Gosh", { requirements = "Reach the Statue of the Great Wolf while the one-minute Wolf Spirit Guardian buff is active; Worgen can also interact directly" } },
    } },
    { detailKey = "aurostor", subtype = "appearance", items = {
        { 210433, "Visage of Aurostor" },
    } },
    { detailKey = "verdantEliteWeapons", subtype = "appearance", items = {
        { 210502, "Verdant Gladiator's Axe", { cost = "5 Marks of Honor" } },
        { 210503, "Verdant Gladiator's Dagger", { cost = "5 Marks of Honor" } },
        { 210504, "Verdant Gladiator's Sickle", { cost = "5 Marks of Honor" } },
        { 210506, "Verdant Gladiator's Warglaive", { cost = "5 Marks of Honor" } },
        { 210507, "Verdant Gladiator's Scythe", { cost = "5 Marks of Honor" } },
        { 210508, "Verdant Gladiator's Staff", { cost = "5 Marks of Honor" } },
        { 210509, "Verdant Gladiator's Greatstaff", { cost = "5 Marks of Honor" } },
        { 210510, "Verdant Gladiator's Axestaff", { cost = "5 Marks of Honor" } },
        { 210511, "Verdant Gladiator's Rifle", { cost = "5 Marks of Honor" } },
        { 210512, "Verdant Gladiator's Scepter", { cost = "5 Marks of Honor" } },
        { 210513, "Verdant Gladiator's Censer", { cost = "5 Marks of Honor" } },
        { 210514, "Verdant Gladiator's Shield", { cost = "5 Marks of Honor" } },
        { 210515, "Verdant Gladiator's Bulwark", { cost = "5 Marks of Honor" } },
        { 210516, "Verdant Gladiator's Claws", { cost = "5 Marks of Honor" } },
        { 210517, "Verdant Gladiator's Bow", { cost = "5 Marks of Honor" } },
        { 210518, "Verdant Gladiator's Greatsword", { cost = "5 Marks of Honor" } },
        { 210519, "Verdant Gladiator's Pulverizer", { cost = "5 Marks of Honor" } },
        { 210520, "Verdant Gladiator's Sword", { cost = "5 Marks of Honor" } },
        { 210521, "Verdant Gladiator's Shotel", { cost = "5 Marks of Honor" } },
    } },
    { detailKey = "wolfAncient", subtype = "appearance", items = {
        { 210552, "Cowl of the Wolf Ancient", { requirements = "Orc or Mag'har Orc character" } },
    } },
    { detailKey = "superbloom", subtype = "appearance", items = {
        { 210661, "Dreamcatcher's Crescent" },
        { 210662, "Ochre Ornament of the Grove" },
        { 210663, "Circlet of the Mother Tree" },
        { 210664, "Frost Sapling's Adornment" },
        { 210666, "Crest of the Seething Flamekeeper" },
    } },
    { detailKey = "dreamWardenTools", subtype = "appearance", items = {
        { 210675, "Gardener's Lightstaff", { cost = "300 Dragon Isles Supplies" } },
        { 210676, "Elderwood Cane", { cost = "300 Dragon Isles Supplies" } },
        { 210677, "Survivalist's Shovel", { cost = "300 Dragon Isles Supplies" } },
        { 210678, "Verdant Gleaner's Scythe", { cost = "300 Dragon Isles Supplies" } },
        { 210679, "Cultivator's Watering Can", { cost = "300 Dragon Isles Supplies" } },
        { 210680, "Caretaker's Trowel", { cost = "300 Dragon Isles Supplies" } },
        { 210682, "Camper's Knife", { cost = "300 Dragon Isles Supplies" } },
        { 210685, "Ranger's Longbow", { cost = "300 Dragon Isles Supplies" } },
        { 210686, "Grovekeeper's Barrier", { cost = "300 Dragon Isles Supplies" } },
    } },
    { detailKey = "greenDragonOuterwear", subtype = "ensemble", items = {
        { 210790, "Ensemble: Elegant Green Dragon Outerwear", { requirements = "Dream Wardens Renown 16", cost = "500 Dragon Isles Supplies" } },
    } },
    { detailKey = "dragonflightWarModeSets", subtype = "ensemble", items = {
        { 211100, "Ensemble: Drakebreaker's Plate Armor" },
        { 211134, "Ensemble: Scalewarden's Plate Armor" },
        { 211135, "Ensemble: Drakebreaker's Mail Armor" },
        { 211136, "Ensemble: Scalewarden's Mail Armor" },
        { 211138, "Ensemble: Drakebreaker's Leather Armor" },
        { 211139, "Ensemble: Scalewarden's Leather Armor" },
        { 211140, "Ensemble: Drakebreaker's Cloth Armor" },
        { 211141, "Ensemble: Scalewarden's Cloth Armor" },
        { 211143, "Arsenal: Drakebreaker's Spiked Hammer" },
        { 211144, "Arsenal: Drakebreaker's Club" },
        { 211146, "Arsenal: Drakebreaker's Knife" },
        { 211147, "Arsenal: Drakebreaker's Warglaive" },
        { 211148, "Arsenal: Drakebreaker's Axe" },
        { 211150, "Arsenal: Drakebreaker's Shield" },
        { 211152, "Arsenal: Drakebreaker's Polearm" },
        { 211153, "Arsenal: Drakebreaker's Greatsword" },
        { 211154, "Arsenal: Drakebreaker's Stave" },
        { 211155, "Arsenal: Drakebreaker's Offhand" },
        { 211156, "Arsenal: Drakebreaker's Wand" },
        { 211157, "Arsenal: Drakebreaker's Gun" },
        { 211165, "Arsenal: Scalewarden's Gun" },
        { 211166, "Arsenal: Scalewarden's Wand" },
        { 211167, "Arsenal: Scalewarden's Offhand" },
        { 211168, "Arsenal: Scalewarden's Stave" },
        { 211169, "Arsenal: Scalewarden's Greatsword" },
        { 211170, "Arsenal: Scalewarden's Polearm" },
        { 211171, "Arsenal: Scalewarden's Shield" },
        { 211172, "Arsenal: Scalewarden's Axe" },
        { 211173, "Arsenal: Scalewarden's Warglaive" },
        { 211174, "Arsenal: Scalewarden's Dagger" },
        { 211175, "Arsenal: Scalewarden's Mace" },
        { 211176, "Arsenal: Scalewarden's Club" },
        { 211177, "Arsenal: Scalewarden's Shortsword" },
    } },
})

local PATCH_10_2_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "azerothianArchives", subtype = "appearance", items = {
        { 208450, "Coiled Archivist's Rope", { cost = "10,000 Mysterious Fragments" } },
        { 208451, "Archivist's Buckled Cap", { requirements = "Complete the Azerothian Archives introductory questline", cost = "1 Mysterious Fragment after the introduction" } },
        { 208452, "Historian's Dapper Cap", { cost = "15,000 Mysterious Fragments" } },
        { 208453, "Archivist's Super Scooper", { cost = "10,000 Mysterious Fragments" } },
        { 208454, "Archivist's Mining Pick", { cost = "10,000 Mysterious Fragments" } },
        { 208455, "Archivist's Sturdy Hook", { cost = "10,000 Mysterious Fragments" } },
        { 208456, "Archivist's Elegant Bag", { cost = "15,000 Mysterious Fragments" } },
        { 208457, "Archivist's Spelunking Torch", { cost = "10,000 Mysterious Fragments" } },
        { 208458, "Archivist's Extravagant Lantern", { cost = "10,000 Mysterious Fragments" } },
        { 208459, "Archivist's Improvised Cudgel", { cost = "10,000 Mysterious Fragments" } },
        { 208546, "Archivist's Rose-Tinted Glasses", { cost = "12,000 Mysterious Fragments" } },
        { 208547, "Archivist's Reading Spectacles", { cost = "12,000 Mysterious Fragments" } },
        { 212633, "Historian's Fitted Vest", { cost = "7,000 Mysterious Fragments" } },
        { 212634, "Historian's Fingerless Gloves", { cost = "5,000 Mysterious Fragments" } },
        { 212635, "Historian's Utility Belt", { cost = "5,000 Mysterious Fragments" } },
        { 212636, "Historian's Trousers", { cost = "7,000 Mysterious Fragments" } },
        { 212637, "Historian's Striders", { cost = "5,000 Mysterious Fragments" } },
        { 212638, "Excavator's Work Shirt", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212639, "Excavator's Glovelettes", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212640, "Excavator's Trusty Satchel", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212641, "Excavator's Rugged Pants", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212642, "Excavator's Boots", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212692, "Excavator's Dusky Fedora", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212793, "Excavator's Pack of Findings", { requirements = "Drop from Doomshadow or Big Dig tome rewards" } },
        { 212794, "Historian's Hefty Habersack", { cost = "15,000 Mysterious Fragments" } },
        { 212870, "Archivist's Stone Chisel", { cost = "10,000 Mysterious Fragments" } },
        { 212941, "Archivist's \"Light Touch\"", { cost = "10,000 Mysterious Fragments" } },
        { 213274, "Archivist's Pathfinder", { cost = "10,000 Mysterious Fragments" } },
        { 213275, "Archivist's Rockpuller", { cost = "10,000 Mysterious Fragments" } },
        { 213276, "Archivist's Magnifying Mace", { cost = "10,000 Mysterious Fragments" } },
    } },
    { detailKey = "gilneasReclamation", subtype = "appearance", items = {
        { 211790, "Gilnean Noble's Shoes" },
        { 211791, "Gilnean Noble's Buckle" },
        { 211792, "Gilnean Noble's Vest" },
        { 211793, "Gilnean Noble's Top Hat" },
        { 211794, "Gilnean Noble's Trousers" },
        { 211795, "Gilnean Noble's Mantle" },
    } },
    { detailKey = "belamethQuest", subtype = "appearance", items = {
        { 212981, "Violet Kaldorei Bedroll" },
        { 213004, "Violet Kaldorei Backpack" },
    } },
    { detailKey = "belamethTreasures", subtype = "appearance", items = {
        { 213003, "Blue Kaldorei Bedroll" },
        { 213005, "Blue Kaldorei Backpack" },
        { 213006, "Night Elven Horn" },
        { 213007, "Night Elven Signal" },
        { 213008, "Kaldorei Bow Carver" },
        { 213009, "Violet Kaldorei Pouch" },
        { 213010, "Blue Kaldorei Pouch" },
        { 213011, "Night Elven Shield" },
        { 213012, "Night Elven Spear" },
        { 213013, "Kaldorei Sentinel's Spyglass" },
        { 213160, "Kaldorei Moon Bow" },
    } },
    { detailKey = "darnassianCosmetics", subtype = "appearance", items = {
        { 210415, "Darnassian Moonsilver Spaulders", { requirements = "Alliance character", cost = "250 Dragon Isles Supplies" } },
        { 210418, "Darnassian Cloak", { requirements = "Alliance character", cost = "250 Dragon Isles Supplies" } },
    } },
})

local PATCH_10_2_7_COSMETICS = BuildCosmeticEntries({
    { detailKey = "draeneiHeritage", subtype = "ensemble", items = {
        { 211313, "Ensemble: Heritage of the Draenei", { requirements = "Level 50+ Draenei character" } },
    } },
    { detailKey = "darkspearHeritage", subtype = "ensemble", items = {
        { 211446, "Ensemble: Heritage of the Darkspear", { requirements = "Level 50+ Darkspear Troll character" } },
        { 218105, "Loa's Blade-Blessing", { requirements = "Complete the Darkspear heritage questline; a May 16, 2024 hotfix removed the original sword-user class restriction" } },
    } },
    { detailKey = "harbingerWeapons", subtype = "appearance", items = {
        { 213269, "Bow of the Ranger Captain" },
        { 217711, "Voidtouched Flail" },
        { 217712, "Voidtouched Apparatus" },
        { 217713, "Voidtouched Shield" },
        { 217714, "Voidtouched Scimitar" },
    } },
    { detailKey = "missingDracthyrPieces", subtype = "appearance", items = {
        { 217891, "Cobalt Guardian's Cloak", { requirements = "Cobalt Assembly power at High", cost = "1 Awakened Frost and 100 Dragon Isles Supplies" } },
        { 217892, "Emerald Winglord's Shoulders", { cost = "2,500 Elemental Overflow" } },
        { 217893, "Emerald Winglord's Chain", { cost = "2,500 Elemental Overflow" } },
    } },
})

local PATCH_11_0_COSMETICS = BuildCosmeticEntries({
    { detailKey = "osidionEnsembles", subtype = "ensemble", items = {
        { 219134, "Mossy Cartographer's Orientation" },
        { 219133, "Deep Cartographer's Orientation" },
        { 219131, "Oceanic Cartographer's Orientation" },
        { 219130, "Saffron Cartographer's Orientation" },
        { 219129, "Sooty Artisan's Talent" },
        { 219128, "Stained Artisan's Talent" },
        { 219127, "Cast Artisan's Talent" },
        { 219126, "Woven Artisan's Talent" },
        { 219124, "Toiler's Navy Uniform" },
        { 219123, "Toiler's Beige Uniform" },
        { 219122, "Toiler's Burgundy Uniform" },
        { 219121, "Toiler's Ochre Uniform" },
        { 219120, "Toiler's Khaki Uniform" },
        { 219119, "Occult Peddler's Trinkets" },
        { 219118, "Peculiar Peddler's Trinkets" },
        { 219117, "Curious Peddler's Trinkets" },
        { 219116, "Arcane Peddler's Trinkets" },
        { 219114, "Court Patron's Elegance" },
        { 219113, "Celestial Patron's Elegance" },
        { 219112, "Verdant Patron's Elegance" },
        { 219111, "Royal Patron's Elegance" },
        { 219105, "Sandy Quotidian Wear", { requirements = "Osidion purchase or Lost and Found achievement" } },
        { 219109, "Taupe Quotidian Wear" },
        { 219108, "Umber Quotidian Wear" },
        { 219107, "Earthy Quotidian Wear" },
        { 219106, "Maroon Quotidian Wear" },
        { 219104, "Midnight Educator's Knowledge" },
        { 219103, "Cobalt Educator's Knowledge" },
        { 219102, "Leafy Educator's Knowledge" },
        { 219101, "Lilac Educator's Knowledge" },
        { 219100, "Cardinal Educator's Knowledge" },
    } },
    { detailKey = "launchRenownCosmetics", subtype = "appearance", items = {
        { 218345, "Honorary Councilmember's Cloak", { requirements = "Council of Dornogal Renown 5", cost = "1,625 Resonance Crystals" } },
        { 218346, "Honorary Councilmember's Tabard", { requirements = "Council of Dornogal Renown 10 reward" } },
        { 218344, "Honorary Councilmember's Spaulders", { requirements = "Council of Dornogal Renown 15", cost = "3,250 Resonance Crystals" } },
        { 218342, "Shawl of the Assembly", { requirements = "Assembly of the Deeps Renown 6", cost = "1,625 Resonance Crystals" } },
        { 218343, "Tabard of the Assembly", { requirements = "Assembly of the Deeps Renown 10 reward" } },
        { 218341, "Shoulderguards of the Assembly", { requirements = "Assembly of the Deeps Renown 14", cost = "3,250 Resonance Crystals" } },
        { 218351, "Expeditionary Cape", { requirements = "Hallowfall Arathi Renown 2", cost = "1,625 Resonance Crystals" } },
        { 218352, "Expeditionary Tabard", { requirements = "Hallowfall Arathi Renown 10 reward" } },
        { 218350, "Expeditionary Spaulders", { requirements = "Hallowfall Arathi Renown 13", cost = "3,250 Resonance Crystals" } },
        { 218348, "Thread-Bearer's Cloak", { requirements = "Severed Threads Renown 7", cost = "565 Kej" } },
        { 218349, "Tabard of the Severed Threads", { requirements = "Severed Threads Renown 10 reward" } },
        { 218347, "Thread-Bearer's Pauldrons", { requirements = "Severed Threads Renown 16", cost = "1,125 Kej" } },
    } },
    { detailKey = "launchDelveArmor", subtype = "appearance", items = {
        { 225379, "Torchbearer's Chainmail", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225380, "Torchbearer's Cinch", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225381, "Torchbearer's Striders", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225382, "Torchbearer's Grips", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225383, "Torchbearer's Coif", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225384, "Torchbearer's Greaves", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225385, "Torchbearer's Shoulderguards", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225386, "Torchbearer's Bracers", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225387, "Cave Topographer's Vestment", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225388, "Cave Topographer's Sandals", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225389, "Cave Topographer's Handwraps", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225390, "Cave Topographer's Cowl", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225391, "Cave Topographer's Leggings", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225392, "Cave Topographer's Shoulders", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225393, "Cave Topographer's Cord", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225394, "Cave Topographer's Cuffs", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225395, "Treasure-Seeker's Vest", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225396, "Treasure-Seeker's Boots", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225397, "Treasure-Seeker's Grips", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225398, "Treasure-Seeker's Helm", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225399, "Treasure-Seeker's Breeches", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225400, "Treasure-Seeker's Epaulets", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225401, "Treasure-Seeker's Sash", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225402, "Treasure-Seeker's Bindings", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225403, "Secret-Dredger's Breastplate", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225404, "Secret-Dredger's Sabatons", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225405, "Secret-Dredger's Gauntlets", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225406, "Secret-Dredger's Helm", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225407, "Secret-Dredger's Legguards", { cost = "3,250 Resonance Crystals or 875 Undercoin" } },
        { 225408, "Secret-Dredger's Mantle", { cost = "2,600 Resonance Crystals or 750 Undercoin" } },
        { 225409, "Secret-Dredger's Girdle", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225410, "Secret-Dredger's Armplates", { cost = "1,300 Resonance Crystals or 625 Undercoin" } },
        { 225411, "Secret-Dredger's Cloak", { cost = "1,300 Resonance Crystals or 500 Undercoin" } },
        { 225412, "Torchbearer's Greatcloak", { cost = "1,300 Resonance Crystals or 500 Undercoin" } },
        { 225413, "Treasure-Seeker's Shawl", { cost = "1,300 Resonance Crystals or 500 Undercoin" } },
        { 225414, "Cave Topographer's Drape", { cost = "1,300 Resonance Crystals or 500 Undercoin" } },
    } },
    { detailKey = "launchDelveWeapons", subtype = "appearance", items = {
        { 225497, "Torchlit Pickaxe", { cost = "1,250 Undercoin" } },
        { 225498, "Umbral Artist's Chisel", { cost = "1,250 Undercoin" } },
        { 225499, "Lapidarius Gemcutter", { cost = "1,250 Undercoin" } },
        { 225500, "Bedrock Breaker", { cost = "565 Undercoin" } },
        { 225501, "Pathfinder's Stonecarver", { cost = "1,250 Undercoin" } },
        { 225502, "Mountain Shaper's Greataxe", { cost = "3,000 Undercoin" } },
        { 225503, "Trailblazer's Hookshoot", { cost = "3,000 Undercoin" } },
        { 225504, "Skypiercing Drillstaff", { cost = "3,000 Undercoin" } },
        { 225505, "Luminous Lampspire", { cost = "3,000 Undercoin" } },
        { 225506, "Mana-Lined Slab Slicer", { cost = "3,000 Undercoin" } },
        { 225507, "Brilliant Beacon", { cost = "1,250 Undercoin" } },
        { 225508, "Unhinged Vault-Hatch", { cost = "1,250 Undercoin" } },
    } },
    { detailKey = "launchDelveDrops", subtype = "appearance", items = {
        { 212162, "Bitter Shroom Cap" },
        { 212163, "Soporific Shroom Cap" },
        { 212164, "Shallow Nautic Helm" },
        { 212165, "Deep Nautic Helm" },
        { 212166, "Coral Nautic Helm" },
        { 212167, "Taken Candle" },
        { 212168, "Cinderbee Wax Candle Hat" },
        { 212169, "Mint-Scented Candle Hat" },
        { 212171, "Zekvir's Raptorial Spine", { requirements = "Defeat Zekvir in Zekvir's Lair" } },
        { 212172, "Ajul'Nerub Raptorial Spine" },
        { 212173, "Rulk'Nerub Raptorial Spine" },
    } },
    { detailKey = "hallowfallFishingDerby", subtype = "ensemble", items = {
        { 224717, "Ensemble: Cerulean Dredger", { cost = "500 Mereldar Derby Marks" } },
    } },
    { detailKey = "hallowfallFishingDerby", subtype = "appearance", items = {
        { 224727, "Dasher's Trophy Fish", { cost = "250 Mereldar Derby Marks" } },
        { 217375, "Frenzied Hat of the Crimson Seas", { cost = "100 Mereldar Derby Marks" } },
        { 225763, "Fallen Dalaran Defender", { cost = "50 Mereldar Derby Marks" } },
        { 226376, "Dasher's Violet Rucksack", { cost = "50 Mereldar Derby Marks" } },
        { 226378, "Mereldar Artisan's Shoulderbag", { cost = "50 Mereldar Derby Marks" } },
        { 226379, "Keen-eye 'Noculars", { cost = "50 Mereldar Derby Marks" } },
    } },
    { detailKey = "forgedEliteWeapons", subtype = "appearance", items = {
        { 225856, "Forged Gladiator's Axe", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225857, "Forged Gladiator's Dagger", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225858, "Forged Gladiator's Pincer", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225859, "Forged Gladiator's Warglaive", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225860, "Forged Gladiator's Spear", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225861, "Forged Gladiator's Staff", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225863, "Forged Gladiator's Battlestaff", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225864, "Forged Gladiator's Crossbow", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225865, "Forged Gladiator's Scepter", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225866, "Forged Gladiator's Focus", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225867, "Forged Gladiator's Shield", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225868, "Forged Gladiator's Bulwark", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225869, "Forged Gladiator's Claws", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225870, "Forged Gladiator's Bow", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225871, "Forged Gladiator's Greataxe", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225872, "Forged Gladiator's Pulverizer", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
        { 225874, "Forged Gladiator's Wither-Blade", { requirements = "Duelist (2,100 rating) during The War Within Season 1", cost = "5 Marks of Honor" } },
    } },
})

local function BuildDragonflightLegacyPvPCosmetics()
    local entries = {}
    local armorTypes = { "Cloth", "Leather", "Mail", "Plate" }
    local classes = { "Death Knight", "Demon Hunter", "Druid", "Evoker", "Hunter", "Mage", "Monk", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior" }
    local seasons = {
        { name = "Crimson", firstId = 230869, originalSeason = "Dragonflight Season 1" },
        { name = "Obsidian", firstId = 230951, originalSeason = "Dragonflight Season 2" },
        { name = "Verdant", firstId = 231120, originalSeason = "Dragonflight Season 3" },
    }

    for _, season in ipairs(seasons) do
        for index, armorType in ipairs(armorTypes) do
            table.insert(entries, {
                itemId = season.firstId + index - 1,
                name = string.format("Ensemble: %s Aspirant's %s Armor", season.name, armorType),
                subtype = "ensemble",
                detailKey = "dragonflightLegacyPvP",
                cost = "12 Marks of Honor",
            })
        end
        for index, className in ipairs(classes) do
            table.insert(entries, {
                itemId = season.firstId + 3 + index,
                name = string.format("Ensemble: %s Gladiator's %s Armor", season.name, className),
                subtype = "ensemble",
                detailKey = "dragonflightLegacyPvP",
                cost = "12 Marks of Honor",
            })
        end
        for index, className in ipairs(classes) do
            table.insert(entries, {
                itemId = season.firstId + 16 + index,
                name = string.format("Ensemble: Elite %s Gladiator's %s Armor", season.name, className),
                subtype = "ensemble",
                detailKey = "dragonflightLegacyPvP",
                cost = "12 Marks of Honor",
                requirements = string.format("Originally required Rival I during %s", season.originalSeason),
            })
        end
        table.insert(entries, {
            itemId = season.firstId + 30,
            name = string.format("Arsenal: %s Aspirant's Weapons", season.name),
            subtype = "arsenal",
            detailKey = "dragonflightLegacyPvP",
            cost = "80 Marks of Honor",
        })
        table.insert(entries, {
            itemId = season.firstId + 31,
            name = string.format("Arsenal: %s Gladiator's Weapons", season.name),
            subtype = "arsenal",
            detailKey = "dragonflightLegacyPvP",
            cost = "80 Marks of Honor",
        })
        table.insert(entries, {
            itemId = season.firstId + 32,
            name = string.format("Arsenal: Elite %s Gladiator's Weapons", season.name),
            subtype = "arsenal",
            detailKey = "dragonflightLegacyPvP",
            cost = "80 Marks of Honor",
            requirements = string.format("Originally required Elite (2400 rating) during %s", season.originalSeason),
        })
    end

    return entries
end

local PATCH_11_0_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "anniversaryTierTwo", subtype = "ensemble", items = {
        { 228197, "Ensemble: Eternal Battlegear of Wrath" },
        { 228198, "Ensemble: Eternal Judgment Armor" },
        { 228199, "Ensemble: Eternal Stormrage Armor" },
        { 228200, "Ensemble: Dragonstalker's Eternal Armor" },
        { 228201, "Ensemble: Eternal Netherwind Regalia" },
        { 228202, "Ensemble: Eternal Bloodfang Armor" },
        { 228203, "Ensemble: Eternal Ten Storms" },
        { 228204, "Ensemble: Eternal Vestments of Transcendence" },
        { 228205, "Ensemble: Pale Rider's Eternal Armor" },
        { 228206, "Ensemble: Netherwalker's Eternal Armor" },
        { 228207, "Ensemble: Earth-Warder's Eternal Armor" },
        { 228208, "Ensemble: Eternal Battlegear of the August Acolyte" },
        { 228209, "Ensemble: Eternal Nemesis Raiment" },
    } },
    { detailKey = "anniversaryColdflame", subtype = "appearance", items = {
        { 228784, "Coldflame's Edge", { cost = "10 Bronze Celebration Tokens" } },
        { 228785, "Coldflame Bulwark", { cost = "10 Bronze Celebration Tokens" } },
        { 228786, "Coldflame Winged Crown", { cost = "10 Bronze Celebration Tokens" } },
        { 228788, "Coldflame Edged Crest", { cost = "15 Bronze Celebration Tokens" } },
    } },
})

for _, entry in ipairs(BuildDragonflightLegacyPvPCosmetics()) do
    table.insert(PATCH_11_0_5_COSMETICS, entry)
end

local PATCH_11_0_7_COSMETICS = BuildCosmeticEntries({
    { detailKey = "soweezi", subtype = "ensemble", items = {
        { 221543, "Ensemble: Pink Tropical", { cost = "4,500 Flame-Blessed Iron" } },
        { 222960, "Ensemble: Pink Tropical Swimwear", { cost = "4,500 Flame-Blessed Iron" } },
        { 234523, "Ensemble: Salvage Rig Garments", { cost = "2,000 Flame-Blessed Iron" } },
        { 234522, "Ensemble: Southsea Cruise Loungewear", { cost = "2,000 Flame-Blessed Iron" } },
        { 234521, "Ensemble: Rusty Bruiser's Outfit", { cost = "2,000 Flame-Blessed Iron" } },
        { 234520, "Ensemble: Sun-Soaked Clothing", { cost = "1,500 Flame-Blessed Iron" } },
        { 234519, "Ensemble: Paradise Beach Loungewear", { cost = "2,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "soweezi", subtype = "appearance", items = {
        { 220655, "Water Blaster P.K.", { cost = "1,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "ailenda", subtype = "ensemble", items = {
        { 234518, "Ensemble: Sacred Wayfarer's Attire", { cost = "3,000 Flame-Blessed Iron" } },
        { 234517, "Ensemble: Adventurous Lamplighter's Attire", { cost = "3,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "ailenda", subtype = "appearance", items = {
        { 233925, "Arathi Knight's Shoulderguard", { cost = "350 Flame-Blessed Iron" } },
        { 233922, "Arathi Knight's Headguard", { cost = "350 Flame-Blessed Iron" } },
        { 233924, "Arathi Champion's Shoulderguard", { cost = "350 Flame-Blessed Iron" } },
        { 233921, "Arathi Champion's Headguard", { cost = "350 Flame-Blessed Iron" } },
        { 233923, "Arathi Footman's Shoulderguard", { cost = "350 Flame-Blessed Iron" } },
        { 233920, "Arathi Footman's Headguard", { cost = "350 Flame-Blessed Iron" } },
        { 233917, "Sacredite's Ceremonial Cowl", { cost = "350 Flame-Blessed Iron" } },
        { 233918, "Sacredite Scholar's Hood", { cost = "350 Flame-Blessed Iron" } },
        { 233919, "Sacredite Expeditionary Hood", { cost = "350 Flame-Blessed Iron" } },
        { 233812, "Arathi Youngling's Training Sword", { cost = "350 Flame-Blessed Iron" } },
        { 233823, "Mereldar Smithing Mallet", { cost = "350 Flame-Blessed Iron", notes = "Main-hand appearance token." } },
        { 235412, "Mereldar Smithing Mallet", { cost = "200 Flame-Blessed Iron", notes = "Off-hand appearance token; distinct item ID from the main-hand version." } },
        { 233836, "Sacredite's Facet Gouge", { cost = "350 Flame-Blessed Iron" } },
        { 233835, "Priory Tongs", { cost = "200 Flame-Blessed Iron" } },
        { 233828, "Sacredite's Ceremonial Brush", { cost = "200 Flame-Blessed Iron" } },
    } },
    { detailKey = "hoodedPurveyor", subtype = "ensemble", items = {
        { 234524, "Ensemble: Awakened Ambassador's Uniform", { cost = "3,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "hoodedPurveyor", subtype = "appearance", items = {
        { 233978, "Earthen Soot-Stained Workpack", { cost = "500 Flame-Blessed Iron" } },
        { 233979, "Stonebound Worker's Backpack", { cost = "500 Flame-Blessed Iron" } },
        { 233980, "Noble's Forgegrounds Worksack", { cost = "500 Flame-Blessed Iron" } },
        { 233981, "Underground Machinist Toolbag", { cost = "500 Flame-Blessed Iron" } },
        { 235297, "Smuggled Councilor's Chalice", { cost = "350 Flame-Blessed Iron", notes = "Main-hand appearance token." } },
        { 233829, "Smuggled Councilor's Chalice", { cost = "200 Flame-Blessed Iron", notes = "Off-hand appearance token." } },
        { 235298, "Smuggled Forgegrounds Hammer", { cost = "350 Flame-Blessed Iron", notes = "Main-hand appearance token." } },
        { 233824, "Smuggled Forgegrounds Hammer", { cost = "200 Flame-Blessed Iron", notes = "Off-hand appearance token." } },
        { 235299, "Smuggled Meadery Pitcher", { cost = "350 Flame-Blessed Iron", notes = "Main-hand appearance token." } },
        { 233822, "Smuggled Meadery Pitcher", { cost = "200 Flame-Blessed Iron", notes = "Off-hand appearance token." } },
    } },
    { detailKey = "taljoriPirate", subtype = "ensemble", items = {
        { 234536, "Ensemble: Bilgeswabby's Garb", { cost = "3,000 Flame-Blessed Iron" } },
        { 234537, "Ensemble: Pilfered Mariner's Garb", { cost = "3,000 Flame-Blessed Iron" } },
        { 234538, "Ensemble: Salt-Stained Garb", { cost = "3,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "taljoriPirate", subtype = "appearance", items = {
        { 233845, "Quilted Long-Sleeved Sea Tunic", { cost = "350 Flame-Blessed Iron" } },
        { 233844, "Quilted Sea Vest", { cost = "350 Flame-Blessed Iron" } },
        { 233912, "Bilge Rat Pirate Hat", { cost = "350 Flame-Blessed Iron" } },
        { 233903, "Knife Juggler's Bicorne", { cost = "350 Flame-Blessed Iron" } },
        { 233902, "Tattered Rat Hat", { cost = "350 Flame-Blessed Iron" } },
        { 233911, "Bloodstained Rat Cap", { cost = "350 Flame-Blessed Iron" } },
        { 233892, "Quilted Waist Wrap", { cost = "200 Flame-Blessed Iron" } },
    } },
    { detailKey = "taljoriVrykulNaga", subtype = "ensemble", items = {
        { 234513, "Ensemble: Rune Scribe's Vestments", { cost = "3,000 Flame-Blessed Iron" } },
        { 234514, "Ensemble: Bloodscout Outfit", { cost = "3,000 Flame-Blessed Iron" } },
        { 234515, "Ensemble: Hydraflayer Regalia", { cost = "3,000 Flame-Blessed Iron" } },
        { 234516, "Ensemble: Tidecrasher Armor", { cost = "3,000 Flame-Blessed Iron" } },
    } },
    { detailKey = "taljoriVrykulNaga", subtype = "appearance", items = {
        { 234414, "Runescribe's Ritual Tunic", { cost = "500 Flame-Blessed Iron" } },
        { 233818, "Vrykul Blacksmith's Gavel", { cost = "350 Flame-Blessed Iron" } },
        { 233819, "Stormtouched Blacksmith's Gavel", { cost = "350 Flame-Blessed Iron" } },
        { 233807, "Bloodwake Hullrender", { cost = "350 Flame-Blessed Iron" } },
        { 233806, "Burly Vrykul's Greatsword", { cost = "350 Flame-Blessed Iron" } },
        { 233857, "Bloodwake Sailpiercer", { cost = "350 Flame-Blessed Iron" } },
        { 233856, "Hydraflayer's Longbow", { cost = "350 Flame-Blessed Iron" } },
        { 233961, "Bloodstained War Buckler", { cost = "350 Flame-Blessed Iron" } },
        { 233805, "Vrykul Pyromancer's Wand", { cost = "350 Flame-Blessed Iron" } },
        { 233832, "Tidestalker's Gutter", { cost = "350 Flame-Blessed Iron" } },
        { 233809, "Myrmidon's Wave Slasher", { cost = "350 Flame-Blessed Iron" } },
        { 233810, "Barnacle Breaker's Falchion", { cost = "350 Flame-Blessed Iron" } },
        { 233982, "Tideflayer's Wave Piercer", { cost = "350 Flame-Blessed Iron" } },
        { 233963, "Myrmidon's Pearlwall", { cost = "350 Flame-Blessed Iron" } },
        { 233817, "Crackling Wavelord's Trident", { cost = "350 Flame-Blessed Iron" } },
        { 233816, "Enchantress Scrying Rod", { cost = "350 Flame-Blessed Iron" } },
    } },
    { detailKey = "sirenIsleTreasures", subtype = "appearance", items = {
        { 233910, "Salt-Stained Sweatcap", { requirements = "Loot the Barnacle-Encrusted Chest underwater" } },
        { 233916, "Ashvane Issued Workboots", { requirements = "Loot the boots beneath the Azerite excavation steps" } },
        { 233834, "Stone Carver's Scramseax", { requirements = "Use the Radiant Citrine inside the Forgotten Vault, then reach the hidden cache before the two-minute buff expires" } },
    } },
    { detailKey = "bygoneRiches", subtype = "appearance", items = {
        { 233827, "Bilge Rat Meat Tenderizer" },
        { 233814, "Bilge Rat Swabbie's Brush" },
        { 233815, "Bilge Rat Swabbie's Mop" },
        { 233825, "Goblin Screwdriver" },
        { 233915, "Plated Sea Boots" },
        { 233820, "Seawashed Zuldazar Mallet" },
        { 233914, "Tarnished Vrykul Cleaver" },
        { 233821, "Zandalari Tongs" },
    } },
    { detailKey = "winterVeil2024", subtype = "appearance", items = {
        { 234398, "Festive Green Holiday Belt", { cost = "15 gold" } },
        { 234399, "Festive Red Holiday Belt", { cost = "15 gold" } },
        { 234400, "Festive Red Holiday Coat", { cost = "30 gold" } },
        { 234401, "Festive Green Holiday Coat", { cost = "30 gold" } },
        { 234402, "Festive Red Holiday Pants", { cost = "25 gold" } },
        { 234403, "Festive Green Holiday Pants", { cost = "25 gold" } },
        { 234404, "Festive Red Holiday Shorts", { cost = "25 gold" } },
        { 234405, "Festive Green Holiday Shorts", { cost = "25 gold" } },
        { 234406, "Festive Red Holiday Boots", { cost = "15 gold" } },
        { 234407, "Festive Green Holiday Boots", { cost = "15 gold" } },
        { 234593, "Festive Green Holiday Vest", { cost = "30 gold" } },
        { 234594, "Festive Red Holiday Vest", { cost = "30 gold" } },
        { 234595, "Festive Red Holiday Sweater", { cost = "30 gold" } },
        { 234596, "Festive Green Holiday Sweater", { cost = "30 gold" } },
        { 234597, "Festive Green Holiday Shirt", { cost = "30 gold" } },
        { 234598, "Festive Red Holiday Shirt", { cost = "30 gold" } },
    } },
})

local PATCH_11_1_COSMETICS = BuildCosmeticEntries({
    { detailKey = "cartelsRenown", subtype = "appearance", items = {
        { 231737, "Undermine Enforcer's Padding", { requirements = "Cartels of Undermine Renown 10 reward" } },
        { 231743, "Undermine Enforcer's Helmet", { requirements = "Cartels of Undermine Renown 17", cost = "1,625 Resonance Crystals" } },
        { 231749, "Undermine Enforcer's Spikes", { requirements = "Cartels of Undermine Renown 17", cost = "3,250 Resonance Crystals" } },
        { 237034, "Smartest in Town's Attire", { requirements = "Cartels of Undermine Renown 17", cost = "9,750 Resonance Crystals" } },
        { 237102, "Slickest in Town's Attire", { requirements = "Cartels of Undermine Renown 17", cost = "9,750 Resonance Crystals" } },
        { 237112, "Craftiest in Town's Attire", { requirements = "Cartels of Undermine Renown 17", cost = "9,750 Resonance Crystals" } },
        { 237122, "Toughest in Town's Attire", { requirements = "Cartels of Undermine Renown 17", cost = "9,750 Resonance Crystals" } },
        { 232515, "Experimental Goblin Jetpack", { requirements = "Cartels of Undermine Renown 18", cost = "3,250 Resonance Crystals" } },
    } },
    { detailKey = "greexitBruiser", subtype = "appearance", items = {
        { 231734, "Blackwater Bruiser's Tabard", { cost = "500 gold before discounts" } },
        { 231735, "Steamwheedle Bruiser's Tabard", { cost = "500 gold before discounts" } },
        { 231736, "Bilgewater Bruiser's Tabard", { cost = "500 gold before discounts" } },
        { 231738, "Venture Co. Bruiser's Tabard", { cost = "500 gold before discounts" } },
        { 231740, "Steamwheedle Bruiser's Helm", { cost = "200 gold before discounts" } },
        { 231741, "Blackwater Bruiser's Helm", { cost = "200 gold before discounts" } },
        { 231742, "Bilgewater Bruiser's Helm", { cost = "200 gold before discounts" } },
        { 231744, "Venture Co. Bruiser's Helm", { cost = "200 gold before discounts" } },
        { 231746, "Blackwater Bruiser's Spaulders", { cost = "100 gold before discounts" } },
        { 231747, "Steamwheedle Bruiser's Spaulders", { cost = "100 gold before discounts" } },
        { 231748, "Bilgewater Bruiser's Spaulders", { cost = "100 gold before discounts" } },
        { 231750, "Venture Co. Bruiser's Spaulders", { cost = "100 gold before discounts" } },
    } },
    { detailKey = "cartelExaltedTabards", subtype = "appearance", items = {
        { 231526, "Bilgewater Undermine Tabard", { requirements = "Exalted with Bilgewater Cartel", cost = "1,625 Resonance Crystals" } },
        { 231527, "Steamwheedle Undermine Tabard", { requirements = "Exalted with Steamwheedle Cartel", cost = "1,625 Resonance Crystals" } },
        { 231528, "Blackwater Undermine Tabard", { requirements = "Exalted with Blackwater Cartel", cost = "1,625 Resonance Crystals" } },
        { 231542, "Venture Co. Undermine Tabard", { requirements = "Exalted with Venture Co.", cost = "1,625 Resonance Crystals" } },
    } },
    { detailKey = "gallagioWeapons", subtype = "appearance", items = {
        { 238688, "Gallagio Radier's Venture Co. Torchblade" },
        { 238689, "Gallagio Radier's Bilgewater Torchblade" },
        { 238690, "Gallagio Radier's Blackwater Torchblade" },
        { 238691, "Gallagio Radier's Darkfuse Torchblade" },
        { 238692, "Gallagio Raider's Venture Co. Coilstaff" },
        { 238693, "Gallagio Raider's Bilgewater Coilstaff" },
        { 238694, "Gallagio Raider's Blackwater Coilstaff" },
        { 238695, "Gallagio Raider's Darkfuse Coilstaff" },
        { 238696, "Gallagio Raider's Venture Co. Boomfist" },
        { 238697, "Gallagio Raider's Bilgewater Boomfist" },
        { 238698, "Gallagio Raider's Blackwater Boomfist" },
        { 238699, "Gallagio Raider's Darkfuse Boomfist" },
        { 238700, "Gallagio Raider's Venture Co. Shockbow" },
        { 238701, "Gallagio Raider's Bilgewater Shockbow" },
        { 238702, "Gallagio Raider's Blackwater Shockbow" },
        { 238703, "Gallagio Raider's Darkfuse Shockbow" },
        { 238704, "Gallagio Raider's Venture Co. Generator" },
        { 238705, "Gallagio Raider's Bilgewater Generator" },
        { 238706, "Gallagio Raider's Blackwater Generator" },
        { 238707, "Gallagio Raider's Darkfuse Generator" },
        { 238708, "Gallagio Raider's Venture Co. Shivlighter" },
        { 238709, "Gallagio Raider's Bilgewater Shivlighter" },
        { 238710, "Gallagio Raider's Blackwater Shivlighter" },
        { 238711, "Gallagio Raider's Darkfuse Shivlighter" },
        { 238712, "Gallagio Raider's Venture Co. Motorshield" },
        { 238713, "Gallagio Raider's Bilgewater Motorshield" },
        { 238714, "Gallagio Raider's Blackwater Motorshield" },
        { 238715, "Gallagio Raider's Darkfuse Motorshield" },
        { 238716, "Gallagio Raider's Venture Co. Chainsaw" },
        { 238717, "Gallagio Raider's Bilgewater Chainsaw" },
        { 238718, "Gallagio Raider's Blackwater Chainsaw" },
        { 238719, "Gallagio Raider's Darkfuse Chainsaw" },
        { 238741, "Gallagio Raider's Venture Co. Zapdagger" },
        { 238742, "Gallagio Raider's Bilgewater Zapdagger" },
        { 238743, "Gallagio Raider's Blackwater Zapdagger" },
        { 238744, "Gallagio Raider's Darkfuse Zapdagger" },
        { 238745, "Gallagio Raider's Venture Co. Eelspire" },
        { 238746, "Gallagio Raider's Bilgewater Eelspire" },
        { 238747, "Gallagio Raider's Blackwater Eelspire" },
        { 238748, "Gallagio Raider's Darkfuse Eelspire" },
        { 238749, "Gallagio Raider's Venture Co. Exhaustglaive" },
        { 238750, "Gallagio Raider's Bilgewater Exhaustglaive" },
        { 238751, "Gallagio Raider's Blackwater Exhaustglaive" },
        { 238752, "Gallagio Raider's Darkfuse Exhaustglaive" },
        { 238753, "Gallagio Raider's Venture Co. Gold Digger" },
        { 238754, "Gallagio Raider's Bilgewater Gold Digger" },
        { 238755, "Gallagio Raider's Blackwater Gold Digger" },
        { 238756, "Gallagio Raider's Darkfuse Gold Digger" },
        { 238757, "Gallagio Raider's Venture Co. Thing-a-ma-tool" },
        { 238758, "Gallagio Raider's Bilgewater Thing-a-ma-tool" },
        { 238759, "Gallagio Raider's Blackwater Thing-a-ma-tool" },
        { 238760, "Gallagio Raider's Darkfuse Thing-a-ma-tool" },
        { 238761, "Gallagio Raider's Bootleg Lever" },
        { 238762, "Gallagio Raider's Venture Co. Gyroclub" },
        { 238763, "Gallagio Raider's Bilgewater Gyroclub" },
        { 238764, "Gallagio Raider's Blackwater Gyroclub" },
        { 238765, "Gallagio Raider's Darkfuse Gyroclub" },
        { 238766, "Gallagio Raider's Venture Co. Naval Mine" },
        { 238767, "Gallagio Raider's Bilgewater Naval Mine" },
        { 238768, "Gallagio Raider's Blackwater Naval Mine" },
        { 238769, "Gallagio Raider's Darkfuse Naval Mine" },
        { 238770, "Gallagio Raider's Venture Co. Repeater" },
        { 238771, "Gallagio Raider's Bilgewater Repeater" },
        { 238772, "Gallagio Raider's Blackwater Repeater" },
        { 238773, "Gallagio Raider's Darkfuse Repeater" },
        { 238774, "Gallagio Raider's Knuckle Dusters" },
        { 238775, "Gallagio Raider's Venture Co. Blasthammer" },
        { 238776, "Gallagio Raider's Bilgewater Blasthammer" },
        { 238777, "Gallagio Raider's Blackwater Blasthammer" },
        { 238778, "Gallagio Raider's Darkfuse Blasthammer" },
    } },
    { detailKey = "undermineCampaign", subtype = "appearance", items = {
        { 235516, "The Severance Package", { requirements = "Complete My Top Gal in the Undermine campaign" } },
        { 234125, "Public Defender's Coat", { requirements = "Complete Oh, That Casino! after the campaign and Gallywix" } },
    } },
    { detailKey = "darkfuseCoat", subtype = "appearance", items = {
        { 231550, "Darkfuse Lowdown Coat", { requirements = "Exalted with Darkfuse Solutions", cost = "3,250 Resonance Crystals" } },
    } },
    { detailKey = "shippingCoat", subtype = "appearance", items = {
        { 231556, "Breakneck Cabbie's Coat" },
    } },
    { detailKey = "chettPack", subtype = "appearance", items = {
        { 237900, "C.H.E.T.T. Pack", { requirements = "C.H.E.T.T.mate / Part Timer progression", cost = "1,000 Resonance Crystals" } },
    } },
    { detailKey = "garbageJetpack", subtype = "appearance", items = {
        { 235854, "Gold-Inlaid Jetpack" },
    } },
    { detailKey = "delveSeasonOne", subtype = "ensemble", items = {
        { 234382, "Ensemble: Unkindled Waxweave Panoply", { cost = "5,000 Undercoin" } },
        { 234383, "Ensemble: Myconic Shell", { cost = "5,000 Undercoin" } },
        { 234384, "Ensemble: Chains of the Stygian Sea", { cost = "5,000 Undercoin" } },
        { 234385, "Ensemble: Aegis of Hidden Stars", { cost = "5,000 Undercoin" } },
    } },
    { detailKey = "delveSeasonOne", subtype = "arsenal", items = {
        { 234388, "Arsenal: Hallowfall Weaponry", { cost = "5,000 Undercoin" } },
    } },
    { detailKey = "forgedAspirant", subtype = "ensemble", items = {
        { 232664, "Ensemble: Forged Aspirant's Cloth Armor", { cost = "12 Marks of Honor" } },
        { 232665, "Ensemble: Forged Aspirant's Leather Armor", { cost = "12 Marks of Honor" } },
        { 232666, "Ensemble: Forged Aspirant's Mail Armor", { cost = "12 Marks of Honor" } },
        { 232667, "Ensemble: Forged Aspirant's Plate Armor", { cost = "12 Marks of Honor" } },
    } },
    { detailKey = "forgedAspirant", subtype = "arsenal", items = {
        { 232864, "Arsenal: Forged Aspirant's Weapons", { cost = "80 Marks of Honor" } },
    } },
    { detailKey = "forgedGladiator", subtype = "ensemble", items = {
        { 232668, "Ensemble: Forged Gladiator's Death Knight Armor", { cost = "12 Marks of Honor" } },
        { 232669, "Ensemble: Forged Gladiator's Demon Hunter Armor", { cost = "12 Marks of Honor" } },
        { 232670, "Ensemble: Forged Gladiator's Druid Armor", { cost = "12 Marks of Honor" } },
        { 232671, "Ensemble: Forged Gladiator's Evoker Armor", { cost = "12 Marks of Honor" } },
        { 232672, "Ensemble: Forged Gladiator's Hunter Armor", { cost = "12 Marks of Honor" } },
        { 232673, "Ensemble: Forged Gladiator's Mage Armor", { cost = "12 Marks of Honor" } },
        { 232674, "Ensemble: Forged Gladiator's Monk Armor", { cost = "12 Marks of Honor" } },
        { 232675, "Ensemble: Forged Gladiator's Paladin Armor", { cost = "12 Marks of Honor" } },
        { 232676, "Ensemble: Forged Gladiator's Priest Armor", { cost = "12 Marks of Honor" } },
        { 232677, "Ensemble: Forged Gladiator's Rogue Armor", { cost = "12 Marks of Honor" } },
        { 232678, "Ensemble: Forged Gladiator's Shaman Armor", { cost = "12 Marks of Honor" } },
        { 232679, "Ensemble: Forged Gladiator's Warlock Armor", { cost = "12 Marks of Honor" } },
        { 232680, "Ensemble: Forged Gladiator's Warrior Armor", { cost = "12 Marks of Honor" } },
    } },
    { detailKey = "eliteForgedGladiator", subtype = "ensemble", items = {
        { 232681, "Ensemble: Elite Forged Gladiator's Death Knight Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232682, "Ensemble: Elite Forged Gladiator's Demon Hunter Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232683, "Ensemble: Elite Forged Gladiator's Druid Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232684, "Ensemble: Elite Forged Gladiator's Evoker Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232685, "Ensemble: Elite Forged Gladiator's Hunter Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232686, "Ensemble: Elite Forged Gladiator's Mage Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232687, "Ensemble: Elite Forged Gladiator's Monk Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232688, "Ensemble: Elite Forged Gladiator's Paladin Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232689, "Ensemble: Elite Forged Gladiator's Priest Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232690, "Ensemble: Elite Forged Gladiator's Rogue Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232691, "Ensemble: Elite Forged Gladiator's Shaman Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232692, "Ensemble: Elite Forged Gladiator's Warlock Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
        { 232693, "Ensemble: Elite Forged Gladiator's Warrior Armor", { requirements = "Earn Rival I during The War Within Season 1", cost = "12 Marks of Honor" } },
    } },
})

local PATCH_11_1_5_COSMETICS = BuildCosmeticEntries({
    { detailKey = "torieVisions", subtype = "appearance", items = {
        { 174361, "Black Dragonscale Backpack", { cost = "2,000 Displaced Corrupted Mementos" } },
        { 238255, "Bronze Dragonscale Backpack", { cost = "5,000 Displaced Corrupted Mementos" } },
        { 238666, "Ashjra'kamas, the Corrupted", { cost = "1,000 Displaced Corrupted Mementos" } },
        { 238667, "Ashjra'kamas, the Purified", { cost = "1,500 Displaced Corrupted Mementos" } },
        { 238668, "Ashjra'kamas, the Celestial", { cost = "2,000 Displaced Corrupted Mementos" } },
        { 236973, "Vision Manipulator's Footwraps", { cost = "400 Displaced Corrupted Mementos" } },
        { 236974, "Vision Manipulator's Handwraps", { cost = "400 Displaced Corrupted Mementos" } },
        { 236975, "Vision Manipulator's Leggings", { cost = "400 Displaced Corrupted Mementos" } },
        { 236976, "Vision Manipulator's Cinch", { cost = "400 Displaced Corrupted Mementos" } },
        { 236977, "Vision Manipulator's Wristwraps", { cost = "200 Displaced Corrupted Mementos" } },
        { 236978, "Footpads of the Insatiable Vision", { cost = "400 Displaced Corrupted Mementos" } },
        { 236979, "Grips of the Insatiable Vision", { cost = "400 Displaced Corrupted Mementos" } },
        { 236980, "Legwraps of the Insatiable Vision", { cost = "400 Displaced Corrupted Mementos" } },
        { 236981, "Waistguard of the Insatiable Vision", { cost = "400 Displaced Corrupted Mementos" } },
        { 236982, "Wristwraps of the Insatiable Vision", { cost = "200 Displaced Corrupted Mementos" } },
        { 236983, "Vision Tormentor's Footguards", { cost = "400 Displaced Corrupted Mementos" } },
        { 236984, "Vision Tormentor's Handguards", { cost = "400 Displaced Corrupted Mementos" } },
        { 236985, "Vision Tormentor's Legguards", { cost = "400 Displaced Corrupted Mementos" } },
        { 236986, "Vision Tormentor's Belt", { cost = "400 Displaced Corrupted Mementos" } },
        { 236987, "Vision Tormentor's Vambraces", { cost = "200 Displaced Corrupted Mementos" } },
        { 236988, "Malignant Vision's Stompers", { cost = "400 Displaced Corrupted Mementos" } },
        { 236989, "Malignant Vision's Crushers", { cost = "400 Displaced Corrupted Mementos" } },
        { 236990, "Malignant Vision's Wargreaves", { cost = "400 Displaced Corrupted Mementos" } },
        { 236991, "Malignant Vision's Greatbelt", { cost = "400 Displaced Corrupted Mementos" } },
        { 236992, "Malignant Vision's Armguards", { cost = "200 Displaced Corrupted Mementos" } },
        { 236993, "Vision Manipulator's Robe", { cost = "600 Displaced Corrupted Mementos" } },
        { 236994, "Vision Manipulator's Cowl", { cost = "600 Displaced Corrupted Mementos" } },
        { 236995, "Vision Manipulator's Mantle", { cost = "600 Displaced Corrupted Mementos" } },
        { 236996, "Chestguard of the Insatiable Vision", { cost = "600 Displaced Corrupted Mementos" } },
        { 236997, "Guise of the Insatiable Vision", { cost = "600 Displaced Corrupted Mementos" } },
        { 236998, "Shoulderpads of the Insatiable Vision", { cost = "600 Displaced Corrupted Mementos" } },
        { 236999, "Vision Tormentor's Breastplate", { cost = "600 Displaced Corrupted Mementos" } },
        { 237000, "Vision Tormentor's Mask", { cost = "600 Displaced Corrupted Mementos" } },
        { 237001, "Vision Tormentor's Spaulders", { cost = "600 Displaced Corrupted Mementos" } },
        { 237002, "Malignant Vision's Chestplate", { cost = "600 Displaced Corrupted Mementos" } },
        { 237003, "Malignant Vision's Headguard", { cost = "600 Displaced Corrupted Mementos" } },
        { 237004, "Malignant Vision's Spaulders", { cost = "600 Displaced Corrupted Mementos" } },
        { 237005, "Malignant Vision's Drape", { cost = "400 Displaced Corrupted Mementos" } },
        { 237006, "Vision Tormentor's Tentacles", { cost = "400 Displaced Corrupted Mementos" } },
        { 237007, "Cloak of the Insatiable Vision", { cost = "400 Displaced Corrupted Mementos" } },
        { 237008, "Vision Manipulator's Cloak", { cost = "400 Displaced Corrupted Mementos" } },
    } },
    { detailKey = "facelessMasks", subtype = "appearance", items = {
        { 174342, "Mask of the Burned Bridge", { requirements = "With one mask active, complete the Valley of Wisdom objective" } },
        { 172952, "Mask of the Long Night", { requirements = "Complete all five objectives in a single Horrific Vision" } },
        { 173524, "Mask of the Pained", { requirements = "With one mask active, complete the Old Town objective" } },
        { 173955, "Mask of the Daredevil", { requirements = "With one mask active, complete the Valley of Honor objective" } },
        { 173953, "Mask of the Dark Imagination", { requirements = "With one mask active, complete the Mage Quarter objective" } },
    } },
    { detailKey = "flamesRadiance", subtype = "appearance", items = {
        { 238824, "Radiant Traveler's Backpack", { requirements = "Flame's Radiance Renown 7", cost = "3,250 Resonance Crystals" } },
        { 233297, "Radiant Recruit's Buckle", { requirements = "Flame's Radiance introductory quest / Renown 1" } },
        { 233298, "Radiant Stalwart's Buckle", { requirements = "Flame's Radiance Renown 5 quest: A Frocking Good Job" } },
        { 233299, "Sacred Templar's Buckle", { requirements = "Flame's Radiance Renown 10 quest: Defender of the Sacred Flame" } },
    } },
    { detailKey = "dastardlyDuos", subtype = "appearance", items = {
        { 238624, "Dastardly Pinchzapper", { requirements = "Defeat 8 Dastardlies / Week 4 unlock", cost = "500 Resonance Crystals" } },
        { 239442, "Black Dastardly Epaulet", { requirements = "Defeat 6 Dastardlies / Week 3 unlock", cost = "500 Resonance Crystals" } },
        { 239503, "Blue Dastardly Epaulet", { requirements = "Defeat 6 Dastardlies / Week 3 unlock", cost = "500 Resonance Crystals" } },
        { 239504, "Green Dastardly Epaulet", { requirements = "Defeat 4 Dastardlies", cost = "500 Resonance Crystals" } },
        { 239505, "Purple Dastardly Epaulet", { requirements = "Defeat 4 Dastardlies", cost = "500 Resonance Crystals" } },
        { 239506, "Red Dastardly Epaulet", { requirements = "Defeat 2 Dastardlies", cost = "500 Resonance Crystals" } },
        { 239507, "Yellow Dastardly Epaulet", { requirements = "Defeat 2 Dastardlies", cost = "500 Resonance Crystals" } },
    } },
    { detailKey = "childrensWeek", subtype = "arsenal", items = {
        { 242260, "Arsenal: Children's Stormwind Guard Weapon Set", { cost = "Final quest choice or 1 Well-loved Figurine", includedAppearances = { "Painted Wooden Sword", "Wooden Stormwind Shield", "Painted Wooden Dagger", "Painted Fighting Prop" } } },
        { 242265, "Arsenal: Children's Orgrimmar Guard Weapon Set", { cost = "Final quest choice or 1 Well-loved Figurine", includedAppearances = { "Painted Wooden Axe", "Wooden Orgrimmar Shield", "Painted Wooden Hatchet", "Painted Axe Prop" } } },
    } },
})

local PATCH_11_1_7_COSMETICS = BuildCosmeticEntries({
    { detailKey = "redDawn", subtype = "appearance", items = {
        { 239137, "Lamplighter's Pauldrons", { requirements = "Complete Past Glory at the end of Rise of the Red Dawn" } },
    } },
    { detailKey = "midsummerVendor", subtype = "appearance", items = {
        { 242740, "Grand Helm of the Fire Festival", { cost = "350 Burning Blossoms" } },
        { 242741, "Grand Mantle of the Fire Festival", { cost = "350 Burning Blossoms" } },
        { 242742, "Grand Belt of the Fire Festival", { cost = "150 Burning Blossoms" } },
    } },
    { detailKey = "ahune", subtype = "appearance", items = {
        { 244356, "Crown of the Frost Lord" },
        { 244422, "Glazfuris, Scythe of the Deep Chill" },
        { 244423, "Rethfuras, Scorched Scythe of Cinders" },
        { 246570, "Rethfuras, Scorched Stave of Cinders" },
        { 246571, "Glazfuris, Spire of the Deep Chill" },
    } },
    { detailKey = "adornedHalfShell", subtype = "appearance", items = {
        { 235987, "Adorned Half Shell", { availability = "Twitch promotion ended August 19, 2025" } },
    } },
})

local PATCH_9_1_ACHIEVEMENTS = {
    14943, 14961, 14966, 14967, 14968, 14969, 14970, 14971, 14972, 14973,
    14974, 14975, 14976, 14998, 14999, 15000, 15001, 15003, 15004, 15032,
    15033, 15034, 15035, 15036, 15037, 15039, 15040, 15041, 15042, 15043,
    15044, 15045, 15046, 15047, 15048, 15049, 15050, 15051, 15052, 15053,
    15054, 15055, 15056, 15057, 15058, 15059, 15064, 15065, 15066, 15067,
    15069, 15073, 15075, 15076, 15077, 15078, 15079, 15080, 15081, 15082,
    15083, 15084, 15087, 15088, 15089, 15091, 15092, 15093, 15094, 15095,
    15096, 15099, 15102, 15105, 15106, 15107, 15108, 15109, 15110, 15112,
    15113, 15114, 15115, 15116, 15117, 15118, 15119, 15120, 15121, 15122,
    15123, 15124, 15125, 15126, 15127, 15128, 15130, 15131, 15132, 15133,
    15134, 15135, 15177, 15178, 15179, 15182, 15183, 15184, 15185, 15190,
    15191, 15196, 15197,
}

local PATCH_9_1_5_ACHIEVEMENTS = {
    15232, 15233, 15234, 15241, 15308, 15309, 15310, 15327, 15388,
}

local PATCH_9_2_ACHIEVEMENTS = {
    15211, 15220, 15224, 15229, 15251, 15252, 15253, 15254, 15255, 15256,
    15257, 15258, 15259, 15314, 15315, 15316, 15317, 15318, 15319, 15320,
    15322, 15324, 15331, 15336, 15346, 15347, 15348, 15349, 15350, 15351,
    15352, 15353, 15354, 15355, 15356, 15378, 15379, 15380, 15381, 15384,
    15386, 15391, 15392, 15396, 15397, 15398, 15399, 15400, 15401, 15402,
    15404, 15406, 15407, 15408, 15409, 15410, 15411, 15416, 15417, 15418,
    15419, 15468, 15469, 15470, 15471, 15472, 15473, 15474, 15475, 15476,
    15478, 15479, 15480, 15481, 15482, 15483, 15484, 15485, 15486, 15487,
    15488, 15489, 15490, 15491, 15492, 15493, 15494, 15496, 15498, 15499,
    15500, 15502, 15506, 15508, 15509, 15511, 15512, 15513, 15514, 15515,
    15518, 15539, 15540, 15541, 15542, 15543, 15544,
}

local PATCH_9_2_5_ACHIEVEMENTS = {
    15579, 15598, 15599, 15600, 15601, 15602, 15603, 15604, 15605, 15606,
    15607, 15608, 15609, 15610, 15612, 15639, 15646, 15647, 15648, 15649,
    15650, 15651, 15652, 15654, 15663, 15664, 15665, 15667, 15668, 15669,
    15681, 15682, 15683, 15684, 15685, 15687, 15688, 15689, 15690, 15691,
    15692, 15693, 15694, 15695, 15756,
}

local PATCH_10_0_5_ACHIEVEMENTS = {
    16696, 16697, 16698, 16699, 16700, 16701, 16702, 16704, 16705, 16706,
    16707, 16708, 16710, 16711, 16712, 16723, 16724, 16725, 16726, 16727,
}
for achievementId = 17120, 17206 do
    PATCH_10_0_5_ACHIEVEMENTS[#PATCH_10_0_5_ACHIEVEMENTS + 1] = achievementId
end
for _, achievementId in ipairs({ 17207, 17330, 17331, 17332, 17335, 17336, 17342, 17343, 17345 }) do
    PATCH_10_0_5_ACHIEVEMENTS[#PATCH_10_0_5_ACHIEVEMENTS + 1] = achievementId
end

local PATCH_10_0_7_ACHIEVEMENTS = {}
for achievementId = 17214, 17225 do
    PATCH_10_0_7_ACHIEVEMENTS[#PATCH_10_0_7_ACHIEVEMENTS + 1] = achievementId
end
for achievementId = 17237, 17281 do
    PATCH_10_0_7_ACHIEVEMENTS[#PATCH_10_0_7_ACHIEVEMENTS + 1] = achievementId
end
for _, achievementId in ipairs({
    17284, 17286, 17287, 17288, 17289, 17290, 17294, 17296, 17298,
    17315, 17366, 17367, 17397, 17398, 17399, 17400, 17401, 17402, 17403,
    17404, 17405, 17406, 17410, 17411, 17412, 17413, 17427, 17496, 17497,
    17498, 17499, 17509, 17524, 17525, 17526, 17527, 17528, 17529, 17530,
    17531, 17532, 17534, 17540, 17541, 17543, 17546,
}) do
    PATCH_10_0_7_ACHIEVEMENTS[#PATCH_10_0_7_ACHIEVEMENTS + 1] = achievementId
end

PatchCatalog.patches = {
    ["9.1"] = {
        label = "Patch 9.1: Chains of Domination",
        wowheadPatchId = 90100,
        sourceNotes = {
            "This audited backfill covers eligible mounts, battle pets, toys, cosmetic items, and visible achievements introduced with Chains of Domination.",
            "The patch boundary was checked against the final 9.0.5 and 9.1.0 DB2 snapshots. The anniversary pet and toy, shop and promotional rewards, NPC-only pet species, hidden tracking, statistics, and unavailable records are excluded.",
            "Cosmetics use covenant ensemble wrappers instead of duplicating their internal set pieces, while individually collected glasses, Maw backs, shoulders, and Korthian cloaks remain separate entries.",
            "Ordinary stat-bearing raid, dungeon, PvP, and world-drop equipment is not duplicated in Cosmetics.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23685044",
            overview = "https://www.wowhead.com/guide/shadowlands-chains-of-domination-patch-9-1-features",
            mounts = "https://www.wowhead.com/guide/new-mounts-chains-of-domination-patch-9-1",
            pets = "https://www.wowhead.com/guide/battle-pets-chains-of-domination-shadowlands-patch-9-1",
            transmog = "https://www.wowhead.com/guide/transmog-updates-chains-of-domination-patch-9-1",
        },
        mounts = {
            { spellId = 215545, name = "Mastercraft Gravewing" },
            { spellId = 332904, name = "Harvester's Dredwing" },
            { spellId = 339956, name = "Mawsworn Charger" },
            { spellId = 339957, name = "Hand of Hrestimorak" },
            { spellId = 343550, name = "Battle-Hardened Aquilon" },
            { spellId = 346554, name = "Tazavesh Gearglider" },
            { spellId = 347250, name = "Lord of the Corpseflies" },
            { spellId = 347251, name = "Soaring Razorwing" },
            { spellId = 347536, name = "Tamed Mauler" },
            { spellId = 347810, name = "Beryl Shardhide" },
            { spellId = 348769, name = "Vicious War Gorm" },
            { spellId = 348770, name = "Vicious War Gorm" },
            { spellId = 351195, name = "Vengeance" },
            { spellId = 352309, name = "Hand of Bahmethra" },
            { spellId = 352441, name = "Wild Hunt Legsplitter" },
            { spellId = 352742, name = "Undying Darkhound" },
            { spellId = 353036, name = "Unchained Gladiator's Soul Eater" },
            { spellId = 353263, name = "Cartel Master's Gearglider" },
            { spellId = 353856, name = "Ardenweald Wilderling" },
            { spellId = 353857, name = "Autumnal Wilderling" },
            { spellId = 353858, name = "Winter Wilderling" },
            { spellId = 353859, name = "Summer Wilderling" },
            { spellId = 353866, name = "Obsidian Gravewing" },
            { spellId = 353872, name = "Sinfall Gravewing" },
            { spellId = 353873, name = "Pale Gravewing" },
            { spellId = 353875, name = "Elysian Aquilon" },
            { spellId = 353877, name = "Foresworn Aquilon" },
            { spellId = 353880, name = "Ascendant's Aquilon" },
            { spellId = 353883, name = "Maldraxxian Corpsefly" },
            { spellId = 353884, name = "Regal Corpsefly" },
            { spellId = 353885, name = "Battlefield Swarmer" },
            { spellId = 354351, name = "Sanctum Gloomcharger" },
            { spellId = 354352, name = "Soulbound Gloomcharger" },
            { spellId = 354353, name = "Fallen Charger" },
            { spellId = 354354, name = "Hand of Nilganihmaht" },
            { spellId = 354355, name = "Hand of Salaranga" },
            { spellId = 354356, name = "Amber Shardhide" },
            { spellId = 354357, name = "Crimson Shardhide" },
            { spellId = 354358, name = "Darkmaul" },
            { spellId = 354359, name = "Fierce Razorwing" },
            { spellId = 354360, name = "Garnet Razorwing" },
            { spellId = 354361, name = "Dusklight Razorwing" },
            { spellId = 354362, name = "Maelie, the Wanderer" },
            { spellId = 356501, name = "Rampaging Mauler" },
            { spellId = 358319, name = "Soultwisted Deathwalker" },
        },
        pets = {
            { speciesId = 3092, npcId = 176662, name = "Squibbles" },
            { speciesId = 3097, npcId = 178216, name = "Flawless Amethyst Baubleworm" },
            { speciesId = 3098, npcId = 179008, name = "Lil'Abom" },
            { speciesId = 3099, npcId = 179025, name = "Infused Etherwyrm" },
            { speciesId = 3101, npcId = 179083, name = "Sly" },
            { speciesId = 3102, npcId = 179131, name = "Animite Broodling" },
            { speciesId = 3103, npcId = 179132, name = "Copperback Etherwyrm" },
            { speciesId = 3104, npcId = 179137, name = "Ruby Baubleworm" },
            { speciesId = 3105, npcId = 179138, name = "Turquoise Baubleworm" },
            { speciesId = 3106, npcId = 179139, name = "Topaz Baubleworm" },
            { speciesId = 3107, npcId = 179140, name = "Gurgl" },
            { speciesId = 3108, npcId = 179164, name = "Curious Purrkin" },
            { speciesId = 3109, npcId = 179165, name = "Silver Purrkin" },
            { speciesId = 3110, npcId = 179166, name = "Gizmo" },
            { speciesId = 3111, npcId = 179167, name = "Damp Skrat" },
            { speciesId = 3112, npcId = 179168, name = "Scavenging Skrat" },
            { speciesId = 3113, npcId = 179169, name = "Rarity" },
            { speciesId = 3114, npcId = 179171, name = "Fodder" },
            { speciesId = 3115, npcId = 179179, name = "Clinging Remains" },
            { speciesId = 3116, npcId = 179180, name = "Invasive Buzzer" },
            { speciesId = 3117, npcId = 179181, name = "Amaranthine Stinger" },
            { speciesId = 3118, npcId = 179182, name = "Scurrying Mawrat" },
            { speciesId = 3119, npcId = 179183, name = "Lost Limb" },
            { speciesId = 3120, npcId = 179219, name = "Grip of Terror" },
            { speciesId = 3121, npcId = 179220, name = "Grappling Gauntlet" },
            { speciesId = 3122, npcId = 179222, name = "Irongrasp" },
            { speciesId = 3123, npcId = 179226, name = "Deathroach" },
            { speciesId = 3124, npcId = 179227, name = "Vile Deathroach" },
            { speciesId = 3125, npcId = 179228, name = "Golden Eye" },
            { speciesId = 3126, npcId = 179229, name = "Eye of Affliction" },
            { speciesId = 3127, npcId = 179230, name = "Chompy" },
            { speciesId = 3128, npcId = 179232, name = "Eye of Allseeing" },
            { speciesId = 3129, npcId = 179233, name = "Eye of Extermination" },
            { speciesId = 3130, npcId = 179239, name = "Gilded Darknight" },
            { speciesId = 3131, npcId = 179240, name = "Mawsworn Minion" },
            { speciesId = 3132, npcId = 179241, name = "Mord'al Eveningstar" },
            { speciesId = 3133, npcId = 179242, name = "Rook" },
            { speciesId = 3134, npcId = 179248, name = "Anxious Nibbler" },
            { speciesId = 3135, npcId = 179250, name = "Young Garnetgullet" },
            { speciesId = 3136, npcId = 179251, name = "Korthian Specimen" },
            { speciesId = 3137, npcId = 179252, name = "Mosscoated Gromit" },
            { speciesId = 3138, npcId = 179253, name = "Domestic Aunian" },
            { speciesId = 3139, npcId = 179256, name = "Devourling" },
            { speciesId = 3140, npcId = 179255, name = "Gnashtooth" },
            { speciesId = 3141, npcId = 179329, name = "Wild Corpsefly" },
        },
        toys = {
            { itemId = 186686, name = "Pallid Oracle Bones" },
            { itemId = 186702, name = "Pallid Bone Flute" },
            { itemId = 186973, name = "Anima-ted Leash" },
            { itemId = 186985, name = "Elusive Pet Treat" },
            { itemId = 186974, name = "Experimental Anima Cell" },
            { itemId = 187075, name = "Box of Rattling Chains" },
            { itemId = 187176, name = "Vesper of Harmony" },
            { itemId = 187184, name = "Vesper of Clarity" },
            { itemId = 187185, name = "Vesper of Faith" },
            { itemId = 187416, name = "Jailer's Cage" },
            { itemId = 187417, name = "Adamant Vaults Cell" },
            { itemId = 187113, name = "Personal Ball and Chain" },
            { itemId = 187159, name = "Shadow Slicing Shortsword" },
            { itemId = 187154, name = "Ancient Korthian Runes" },
            { itemId = 187155, name = "Guise of the Changeling" },
            { itemId = 187140, name = "Ring of Duplicity" },
            { itemId = 187344, name = "Offering Kit Maker" },
            { itemId = 187339, name = "Silver Shardhide Whistle" },
            { itemId = 187174, name = "Shaded Judgment Stone" },
            { itemId = 187051, name = "Forgotten Feather" },
            { itemId = 187139, name = "Bottled Shade Heart" },
            { itemId = 187420, name = "Maw-Ocular Viewfinder" },
            { itemId = 183901, name = "Bonestorm Top" },
        },
        cosmetics = PATCH_9_1_COSMETICS,
        achievements = { ids = PATCH_9_1_ACHIEVEMENTS },
    },
    ["9.1.5"] = {
        label = "Patch 9.1.5: Shadowlands Content Update",
        wowheadPatchId = 90105,
        sourceNotes = {
            "This audit covers eligible collection records introduced by the 9.1.5 client, including Legion Timewalking, Mage Tower, covenant-callings, scouting maps, and the Lightforged draenei paladin mount.",
            "Winter Veil, Noblegarden, Midsummer, Trial of Style, esports, shop, subscription, promotion, hidden tracking, placeholders, and unavailable records are excluded.",
            "The incomplete duplicate Lightforged Ruinstrider mount record is excluded in favor of the collectible mount-journal spell.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23731242",
            overview = "https://www.wowhead.com/guide/shadowlands-patch-9-1-5-features",
            timewalking = "https://www.wowhead.com/news/legion-timewalking-vendor-rewards-includes-nightborne-weapons-and-toy-324199",
        },
        mounts = {
            { spellId = 359013, name = "Val'sharah Hippogryph" },
            { spellId = 359318, name = "Soaring Spelltome" },
            { spellId = 363613, name = "Lightforged Ruinstrider" },
        },
        pets = {},
        toys = {
            { itemId = 187419, name = "Steward's First Feather" },
            { itemId = 187512, name = "Tome of Small Sins" },
            { itemId = 187591, name = "Nightborne Guard's Vigilance" },
            { itemId = 187705, name = "Choofa's Call" },
            { itemId = 187840, name = "Sparkle Wings" },
            { itemId = 187869, name = "Scouting Map: Into the Shadowlands" },
            { itemId = 187875, name = "Scouting Map: United Fronts of the Broken Isles" },
            { itemId = 187895, name = "Scouting Map: The Dangers of Draenor" },
            { itemId = 187896, name = "Scouting Map: A Stormstout's Guide to Pandaria" },
            { itemId = 187897, name = "Scouting Map: Cataclysm's Consequences" },
            { itemId = 187898, name = "Scouting Map: True Cost of the Northrend Campaign" },
            { itemId = 187899, name = "Scouting Map: The Many Curiosities of Outland" },
            { itemId = 187900, name = "Scouting Map: The Wonders of Kul Tiras and Zandalar" },
            { itemId = 187913, name = "Apprentice Slimemancer's Boots" },
        },
        cosmetics = PATCH_9_1_5_COSMETICS,
        achievements = { ids = PATCH_9_1_5_ACHIEVEMENTS },
    },
    ["9.1.7"] = {
        label = "Patch 9.1.7: Not Released",
        wowheadPatchId = 90107,
        sourceNotes = {
            "Retail World of Warcraft did not release a 9.1.7 client; patch chronology proceeds directly from 9.1.5 to 9.2.0.",
            "This explicit empty entry preserves the requested patch sequence without misassigning late 9.1.5 records or 9.2 PTR data.",
        },
        sourceUrls = {
            chronology = "https://warcraft.wiki.gg/wiki/Patch_9.1.5",
        },
        mounts = {},
        pets = {},
        toys = {},
        cosmetics = {},
        achievements = { ids = {} },
    },
    ["9.2"] = {
        label = "Patch 9.2: Eternity's End",
        wowheadPatchId = 90200,
        sourceNotes = {
            "This audited backfill covers eligible mounts, battle pets, toys, cosmetic items, and visible achievements introduced with Eternity's End.",
            "The patch boundary was checked against the final 9.1.5 and 9.2.0 DB2 snapshots, then corrected for source activation: the two Vicious Warstalkers belong to Shadowlands Season 4 in patch 9.2.5.",
            "Darkmoon Dance Competition, WoW Anniversary, promotion, shop, crossover, hidden tracking, placeholder, unavailable, and ordinary equippable-drop records are excluded.",
            "Cosmetics include the permanent Cosmetic-class Torghast weapons, the Domination Cache greatsword, and Enlightened paragon-cache cloaks and weapons; normal stat-bearing Zereth Mortis gear is not duplicated.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23770462",
            mounts = "https://www.wowhead.com/guide/shadowlands-mount-guide-10510",
            zerethMortis = "https://www.wowhead.com/guide/zereth-mortis-activities-how-to-unlock",
            protoform = "https://www.wowhead.com/guide/protoform-synthesis-crafting-system-mounts-pets-zereth-mortis",
            enlightened = "https://www.wowhead.com/guide/the-enlightened-reputation-rewards-zereth-mortis",
            mawswornCosmetics = "https://www.wowhead.com/news/new-cosmetic-mawsworn-themed-weapon-transmogs-in-patch-9-2-325124",
        },
        mounts = {
            { spellId = 342668, itemId = 187666, name = "Desertwing Hunter" },
            { spellId = 342671, itemId = 187639, name = "Pale Regal Cervid" },
            { spellId = 342678, itemId = 187660, name = "Vespoid Flutterer" },
            { spellId = 342680, itemId = 187676, name = "Deepstar Aurelid" },
            { spellId = 346719, itemId = 187669, name = "Serenade" },
            { spellId = 347255, itemId = 187680, name = "Vicious War Croaker" },
            { spellId = 347256, itemId = 187681, name = "Vicious War Croaker" },
            { spellId = 359229, itemId = 187629, name = "Heartlight Vombata" },
            { spellId = 359230, itemId = 187630, name = "Curious Crystalsniffer" },
            { spellId = 359231, itemId = 187631, name = "Darkened Vombata" },
            { spellId = 359232, itemId = 187632, name = "Adorned Vombata" },
            { spellId = 359278, itemId = 187638, name = "Deathrunner" },
            { spellId = 359277, itemId = 187641, name = "Sundered Zerethsteed" },
            { spellId = 359276, itemId = 187640, name = "Anointed Protostag" },
            { spellId = 359367, itemId = 187664, name = "Forged Spiteflyer" },
            { spellId = 359366, itemId = 187665, name = "Buzz" },
            { spellId = 359364, itemId = 187663, name = "Bronzewing Vespoid" },
            { spellId = 359372, itemId = 187667, name = "Mawdapted Raptora" },
            { spellId = 359373, itemId = 187668, name = "Raptora Swooper" },
            { spellId = 359376, itemId = 187670, name = "Bronze Helicid" },
            { spellId = 359377, itemId = 187671, name = "Unsuccessful Prototype Fleetpod" },
            { spellId = 359378, itemId = 187672, name = "Scarlet Helicid" },
            { spellId = 359401, itemId = 187677, name = "Genesis Crawler" },
            { spellId = 359402, itemId = 187678, name = "Tarachnid Creeper" },
            { spellId = 359403, itemId = 187679, name = "Ineffable Skitterer" },
            { spellId = 359407, itemId = 187682, name = "Wastewarped Deathwalker" },
            { spellId = 359413, itemId = 187683, name = "Goldplate Bufonid" },
            { spellId = 359379, itemId = 187675, name = "Shimmering Aurelid" },
            { spellId = 359381, itemId = 187673, name = "Cryptic Aurelid" },
            { spellId = 359545, itemId = 190771, name = "Carcinized Zerethsteed" },
            { spellId = 363297, itemId = 188736, name = "Colossal Soulshredder Mawrat" },
            { spellId = 363178, itemId = 188700, name = "Colossal Umbrahide Mawrat" },
            { spellId = 363136, itemId = 188696, name = "Colossal Ebonclaw Mawrat" },
            { spellId = 363701, itemId = 188808, name = "Patient Bufonid" },
            { spellId = 363703, itemId = 188809, name = "Prototype Leaper" },
            { spellId = 363706, itemId = 188810, name = "Russet Bufonid" },
            { spellId = 365559, itemId = 189507, name = "Cosmic Gladiator's Soul Eater" },
            { spellId = 367673, itemId = 190580, name = "Heartbond Lupine" },
            { spellId = 368105, itemId = 190765, name = "Colossal Plaguespew Mawrat" },
            { spellId = 368128, itemId = 190766, name = "Colossal Wraithbound Mawrat" },
            { spellId = 368158, itemId = 190768, name = "Zereth Overseer" },
        },
        pets = {
            { speciesId = 3169, npcId = 181308, name = "Archetype of Focus" },
            { speciesId = 3170, npcId = 181335, name = "Resonant Echo" },
            { speciesId = 3171, npcId = 181336, name = "Omnipotential Core" },
            { speciesId = 3172, npcId = 181337, name = "Geordy" },
            { speciesId = 3173, npcId = 181362, name = "Bufonid Croaker" },
            { speciesId = 3174, npcId = 181488, name = "Archetype of Discovery" },
            { speciesId = 3176, npcId = 181547, name = "Tunneling Vombata" },
            { speciesId = 3178, npcId = 181578, name = "Archetype of Motion" },
            { speciesId = 3179, npcId = 181615, name = "Archetype of Animation" },
            { speciesId = 3180, npcId = 182019, name = "Venomous Bufonid" },
            { speciesId = 3181, npcId = 182081, name = "Archetype of Serenity" },
            { speciesId = 3189, npcId = 182183, name = "Archetype of Multiplicity" },
            { speciesId = 3190, npcId = 182216, name = "Vicious Leporid" },
            { speciesId = 3191, npcId = 182234, name = "Timid Leporid" },
            { speciesId = 3196, npcId = 182260, name = "Proto Avian Fledgling" },
            { speciesId = 3197, npcId = 182264, name = "Archetype of Metamorphosis" },
            { speciesId = 3200, npcId = 182294, name = "Scarlet Proto Avian" },
            { speciesId = 3201, npcId = 182393, name = "Archetype of Predation" },
            { speciesId = 3202, npcId = 182437, name = "Tarachnid Stalker" },
            { speciesId = 3203, npcId = 182473, name = "Tarachnid Ambusher" },
            { speciesId = 3204, npcId = 182504, name = "Archetype of Survival" },
            { speciesId = 3205, npcId = 182568, name = "Metallic Scarabid" },
            { speciesId = 3206, npcId = 182691, name = "Emerald Scarabid" },
            { speciesId = 3207, npcId = 182735, name = "Archetype of Cunning" },
            { speciesId = 3208, npcId = 182758, name = "Red Viperid" },
            { speciesId = 3209, npcId = 182760, name = "King Viperid" },
            { speciesId = 3210, npcId = 182768, name = "Green Viperid" },
            { speciesId = 3211, npcId = 182840, name = "Archetype of Malice" },
            { speciesId = 3212, npcId = 182876, name = "Bloodsucker Vespoid" },
            { speciesId = 3213, npcId = 183142, name = "Vombata Pup" },
            { speciesId = 3214, npcId = 183158, name = "Momma Vombata" },
            { speciesId = 3215, npcId = 183230, name = "Mawtouched Geomental" },
            { speciesId = 3216, npcId = 183277, name = "Ambystan Snapper" },
            { speciesId = 3217, npcId = 183281, name = "Aurelid Floater" },
            { speciesId = 3218, npcId = 183285, name = "Enraged Poultrid" },
            { speciesId = 3219, npcId = 183292, name = "Predatory Helicid" },
            { speciesId = 3220, npcId = 183557, name = "Archetype of Satisfaction" },
            { speciesId = 3221, npcId = 183772, name = "Lightless Tormentor" },
            { speciesId = 3222, npcId = 184196, name = "Shelly" },
            { speciesId = 3223, npcId = 184183, name = "Ambystan Darter" },
            { speciesId = 3224, npcId = 184184, name = "Fierce Scarabid" },
            { speciesId = 3225, npcId = 184189, name = "Violent Poultrid" },
            { speciesId = 3226, npcId = 184190, name = "Multichicken" },
            { speciesId = 3227, npcId = 184191, name = "Stabilized Geomental" },
            { speciesId = 3229, npcId = 184186, name = "Archetype of Renewal" },
            { speciesId = 3230, npcId = 184192, name = "Terror Jelly" },
            { speciesId = 3231, npcId = 184193, name = "Prototickles" },
            { speciesId = 3232, npcId = 184194, name = "Leaping Leporid" },
            { speciesId = 3233, npcId = 184187, name = "Archetype of Vigilance" },
            { speciesId = 3234, npcId = 184197, name = "Viperid Menace" },
            { speciesId = 3235, npcId = 184195, name = "Microlicid" },
            { speciesId = 3237, npcId = 184923, name = "E'rnee" },
            { speciesId = 3247, npcId = 185477, name = "Pocopoc" },
        },
        toys = {
            { itemId = 187793, name = "Personal Containment Trap" },
            { itemId = 187860, name = "Mortis Mover" },
            { itemId = 188952, name = "Dominated Hearthstone" },
            { itemId = 190177, name = "Sphere of Enlightened Cogitation" },
            { itemId = 190196, name = "Enlightened Hearthstone" },
            { itemId = 190237, name = "Broker Translocation Matrix" },
            { itemId = 190238, name = "Xy'rath's Booby-Trapped Cache" },
            { itemId = 190333, name = "Jiro Circle of Song" },
            { itemId = 190457, name = "Protopological Cube" },
            { itemId = 190734, name = "Makaris's Satchel of Mines" },
            { itemId = 190754, name = "Firim's Specimen Container" },
            { itemId = 190853, name = "Bushel of Mysterious Fruit" },
            { itemId = 190926, name = "Infested Automa Core" },
        },
        cosmetics = PATCH_9_2_COSMETICS,
        achievements = { ids = PATCH_9_2_ACHIEVEMENTS },
    },
    ["9.2.5"] = {
        label = "Patch 9.2.5: Shadowlands Season 4",
        wowheadPatchId = 90205,
        sourceNotes = {
            "This audited backfill covers the permanent racial quest rewards, Return to Lordaeron reward, two permanent toys, and Shadowlands Season 4 collections and achievements shipped in the 9.2.5 client.",
            "The Season 4 records include the two Vicious Warstalkers that were preloaded earlier but did not become obtainable until Season 4.",
            "Winter Veil, esports-viewing, Diablo crossover, Dragonflight promotion, shop, hidden tracking, and unavailable records are excluded.",
            "Cosmetics use the three collection wrappers rather than duplicating their internal armor and weapon appearances.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23789456",
            overview = "https://worldofwarcraft.blizzard.com/en-us/news/23801631/shadowlands-925-content-update-is-now-live",
            mounts = "https://www.wowhead.com/guide/shadowlands-mount-guide-10510",
            darkRanger = "https://www.wowhead.com/guide/dark-ranger-customizations-transmog-how-to-unlock",
        },
        mounts = {
            { spellId = 334482, itemId = 192557, name = "Restoration Deathwalker" },
            { spellId = 349824, itemId = 187644, name = "Vicious Warstalker" },
            { spellId = 349823, itemId = 187642, name = "Vicious Warstalker" },
            { spellId = 366791, itemId = 190170, name = "Jigglesworth Sr." },
            { spellId = 369666, itemId = 191123, name = "Grimhowl" },
            { spellId = 370346, itemId = 191290, name = "Eternal Gladiator's Soul Eater" },
            { spellId = 370620, itemId = 191566, name = "Elusive Emerald Hawkstrider" },
        },
        pets = {},
        toys = {
            { itemId = 192099, name = "Earpieces of Tranquil Focus" },
            { itemId = 192485, name = "Stored Wisdom Device" },
        },
        cosmetics = PATCH_9_2_5_COSMETICS,
        achievements = { ids = PATCH_9_2_5_ACHIEVEMENTS },
    },
    ["9.2.7"] = {
        label = "Patch 9.2.7: Auction House Update",
        wowheadPatchId = 90207,
        sourceNotes = {
            "No eligible collection records were introduced by patch 9.2.7 after the audit exclusions are applied.",
            "The Frostbrood Proto-Wyrm is a Wrath of the Lich King Classic promotion, and achievement 16414 is hidden raid-portal tracking; both are intentionally excluded.",
            "Shadowlands Season 4 rewards remain assigned to 9.2.5, where their client records and season content shipped.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23833174",
        },
        mounts = {},
        pets = {},
        toys = {},
        cosmetics = {},
        achievements = { ids = {} },
    },
    ["10.0"] = {
        label = "Patch 10.0: Dragonflight",
        wowheadPatchId = 100000,
        sourceNotes = {
            "This backfill covers audited mounts, battle pets, toys, Cosmetics, and achievements.",
            "The catalog was checked against the final 10.0.2 ItemSparse snapshot. It includes permanent renown, reputation, profession, quest, PvP-wrapper, and regional world-drop appearance consumables.",
            "Trading Post, Timewalking, crossover, shop, calendar-event, limited pre-patch, dragonriding-manuscript, ordinary equippable-drop, and direct appearance rewards are excluded.",
            "Ensembles and arsenals are represented by their learn-on-use wrappers; their internal component records are not duplicated.",
            "Unreleased or unverified records such as Climber's Pack, the Dead Man's armor, and several alpha off-hands are deliberately excluded.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23876529",
            dragonscale = "https://www.wowhead.com/guide/reputation/dragonscale-expedition-renown-rewards",
            valdrakken = "https://www.wowhead.com/guide/reputation/valdrakken-accord-renown-rewards",
            iskaara = "https://www.wowhead.com/guide/reputation/iskaara-tuskarr-renown-rewards",
            maruuk = "https://www.wowhead.com/guide/reputation/maruuk-centaur-renown-rewards",
            cobalt = "https://www.wowhead.com/guide/reputation/cobalt-assembly-rewards",
            blackDragon = "https://www.wowhead.com/guide/reputation/wrathion-sabellian-rewards",
            enchanting = "https://www.wowhead.com/guide/professions/enchanting/recipes-dragonflight",
            wateringCan = "https://www.wowhead.com/quest=66737/a-better-start",
            shadowlandsPvP = "https://warcraft.wiki.gg/wiki/Zo%27sorg",
            pvp = "https://www.wowhead.com/guide/pvp/dragonflight-season-1-rewards",
            mounts = "https://www.wowhead.com/guide/mounts-dragonflight",
            pets = "https://www.wowhead.com/guide/pet-battles/dragonflight-collection-overview",
            wildPets = "https://www.wowhead.com/guide/pet-battles/dragonflight-wild-pets",
            toys = "https://www.wowhead.com/guide/dragonflight-toybox",
        },
        mounts = {
            { spellId = 376912, itemId = 198654, name = "Otterworldly Ottuk Carrier" },
            { spellId = 394219, itemId = 201720, name = "Bronze Vorquin" },
            { spellId = 394216, itemId = 201702, name = "Crimson Vorquin" },
            { spellId = 394220, itemId = 201719, name = "Obsidian Vorquin" },
            { spellId = 394218, itemId = 201704, name = "Sapphire Vorquin" },
            { spellId = 385131, itemId = 198809, name = "Armored Vorquin Leystrider" },
            { spellId = 384963, itemId = 198808, name = "Guardian Vorquin" },
            { spellId = 385134, itemId = 198810, name = "Swift Armored Vorquin" },
            { spellId = 385115, itemId = 198811, name = "Majestic Armored Vorquin" },
            { spellId = 368896, itemId = 194034, name = "Renewed Proto-Drake" },
            { spellId = 368899, itemId = 194549, name = "Windborne Velocidrake" },
            { spellId = 360954, itemId = 194106, name = "Highland Drake" },
            { spellId = 368901, itemId = 194521, name = "Cliffside Wylderdrake" },
            { spellId = 387231, itemId = 199412, name = "Hailstorm Armoredon" },
            { spellId = 377071, itemId = 202086, name = "Crimson Gladiator's Drake" },
            { spellId = 394737, itemId = 201789, name = "Vicious Sabertooth" },
            { spellId = 394738, itemId = 201788, name = "Vicious Sabertooth" },
            { spellId = 376875, itemId = 198872, name = "Brown Scouting Ottuk" },
            { spellId = 376880, itemId = 200118, name = "Yellow Scouting Ottuk" },
            { spellId = 376910, itemId = 201426, name = "Brown War Ottuk" },
            { spellId = 376913, itemId = 201425, name = "Yellow War Ottuk" },
            { spellId = 374034, itemId = 192762, name = "Azure Skitterfly" },
            { spellId = 374032, itemId = 192761, name = "Tamed Skitterfly" },
            { spellId = 374048, itemId = 192764, name = "Verdant Skitterfly" },
            { spellId = 385266, itemId = 198825, name = "Zenet Hatchling" },
            { spellId = 359622, itemId = 201440, name = "Liberated Slyvern" },
            { spellId = 373859, itemId = 192601, name = "Loyal Magmammoth" },
            { spellId = 374196, itemId = 192791, name = "Plainswalker Bearer" },
            { spellId = 374098, itemId = 192775, name = "Stormhide Salamanther" },
            { spellId = 395644, itemId = 198821, name = "Divine Kiss of Ohn'ahra" },
            { spellId = 374247, itemId = 192799, name = "Lizi, Thunderspine Tramper" },
            { spellId = 374162, itemId = 192786, name = "Scrappy Worldsnail" },
            { spellId = 385738, itemId = 201454, name = "Temperamental Skyclaw" },
            { spellId = 359409, itemId = 198871, name = "Iskaara Trader's Ottuk" },
            { spellId = 374275, itemId = 192806, name = "Raging Magmammoth" },
            { spellId = 376879, itemId = 198873, name = "Ivory Trader's Ottuk" },
            { spellId = 374155, itemId = 192784, name = "Shellack" },
            { spellId = 376873, itemId = 198870, name = "Otto" },
            { spellId = 350219, itemId = 192777, name = "Magmashell" },
        },
        pets = {
            { speciesId = 3357, npcId = 192265, name = "Azure Crystalspine" },
            { speciesId = 3358, npcId = 192268, name = "Crimsonspine" },
            { speciesId = 3313, npcId = 189153, name = "Grassland Stomper" },
            { speciesId = 3295, npcId = 189121, name = "Igneoid" },
            { speciesId = 3366, npcId = 193000, name = "Kindlet" },
            { speciesId = 3296, npcId = 189122, name = "Palamanther" },
            { speciesId = 3272, npcId = 189093, name = "Pricklefury Hare" },
            { speciesId = 3280, npcId = 189102, name = "Shyfly" },
            { speciesId = 3353, npcId = 192254, name = "Stoneshell" },
            { speciesId = 3328, npcId = 189658, name = "Tiny Timbertooth" },
            { speciesId = 3288, npcId = 189110, name = "Trunkalumpf" },
            { speciesId = 3301, npcId = 189136, name = "Wild Duckling" },
            { speciesId = 3403, npcId = 197629, name = "Blue Dasher" },
            { speciesId = 3367, npcId = 193024, name = "Emberling" },
            { speciesId = 3351, npcId = 194720, name = "Grizzlefur Cub" },
            { speciesId = 3300, npcId = 189131, name = "Ironbeak Duck" },
            { speciesId = 3273, npcId = 189094, name = "Magma Slug" },
            { speciesId = 3404, npcId = 197637, name = "Polliswog" },
            { speciesId = 3281, npcId = 189103, name = "Scruffy Ottuk" },
            { speciesId = 3283, npcId = 189107, name = "Snowlemental" },
            { speciesId = 3282, npcId = 189104, name = "Swoglet" },
            { speciesId = 3276, npcId = 189097, name = "Treeflitter" },
            { speciesId = 3336, npcId = 191323, name = "Vorquin Runt" },
            { speciesId = 3322, npcId = 189157, name = "Woodbiter Piculet" },
            { speciesId = 3274, npcId = 189095, name = "Alvin" },
            { speciesId = 3411, npcId = 198272, name = "Blaze Spirit" },
            { speciesId = 3410, npcId = 198271, name = "Dust Spirit" },
            { speciesId = 3412, npcId = 198273, name = "Gale Spirit" },
            { speciesId = 3409, npcId = 198269, name = "Tide Spirit" },
            { speciesId = 3345, npcId = 191384, name = "Jeweled Amber Whelpling" },
            { speciesId = 3347, npcId = 191386, name = "Jeweled Emerald Whelpling" },
            { speciesId = 3256, npcId = 186844, name = "Jeweled Onyx Whelpling" },
            { speciesId = 3344, npcId = 191383, name = "Jeweled Sapphire Whelpling" },
            { speciesId = 3346, npcId = 191385, name = "Jeweled Ruby Whelpling" },
            { speciesId = 3306, npcId = 189142, name = "Quack-E" },
            { speciesId = 3390, npcId = 197089, name = "Sophic Amalgamation" },
            { speciesId = 3269, npcId = 189663, name = "Azure Frillfish" },
            { speciesId = 3321, npcId = 189156, name = "Blackfeather Nester" },
            { speciesId = 3275, npcId = 189096, name = "Chestnut" },
            { speciesId = 3415, npcId = 198480, name = "Cubbly" },
            { speciesId = 3365, npcId = 192369, name = "Roseate Hopper" },
            { speciesId = 3309, npcId = 189133, name = "Viridescent Duck" },
            { speciesId = 3326, npcId = 189655, name = "Backswimmer Timbertooth" },
            { speciesId = 3284, npcId = 189105, name = "Whiskuk" },
            { speciesId = 3380, npcId = 196409, name = "Black Skitterbug" },
            { speciesId = 3381, npcId = 194893, name = "Gray Marmoni" },
            { speciesId = 3379, npcId = 196305, name = "Crimson Proto-Whelp" },
            { speciesId = 3378, npcId = 196304, name = "Magic Nibbler" },
            { speciesId = 3317, npcId = 189154, name = "Hoofhelper" },
            { speciesId = 3279, npcId = 189101, name = "Bronze Racing Enthusiast" },
            { speciesId = 3406, npcId = 197969, name = "Lady Feathersworth" },
            { speciesId = 3316, npcId = 189152, name = "Lubbins" },
            { speciesId = 3265, npcId = 188901, name = "Mister Muskoxeles" },
            { speciesId = 3263, npcId = 188861, name = "Secretive Frogduck" },
            { speciesId = 3262, npcId = 188849, name = "Violet Violence" },
            { speciesId = 3264, npcId = 188885, name = "Crystalline Mini-Monster" },
            { speciesId = 3376, npcId = 195896, name = "Chip" },
            { speciesId = 3287, npcId = 189111, name = "Ghostflame" },
            { speciesId = 3270, npcId = 189695, name = "Jean's Lucky Fish" },
            { speciesId = 3303, npcId = 189140, name = "Mallard Duckling" },
            { speciesId = 3414, npcId = 198316, name = "Obsidian Proto-Whelp" },
            { speciesId = 3408, npcId = 198077, name = "Petal" },
            { speciesId = 3417, npcId = 198543, name = "Pinkie" },
            { speciesId = 3278, npcId = 189099, name = "Pistachio" },
            { speciesId = 3407, npcId = 192108, name = "Scout" },
            { speciesId = 3382, npcId = 196666, name = "Stormie" },
            { speciesId = 3416, npcId = 198511, name = "Troubled Tome" },
            { speciesId = 3355, npcId = 192258, name = "Echo of the Cave" },
            { speciesId = 3299, npcId = 189130, name = "Echo of the Depths" },
            { speciesId = 3310, npcId = 189132, name = "Echo of the Heights" },
            { speciesId = 3289, npcId = 189112, name = "Echo of the Inferno" },
            { speciesId = 3405, npcId = 197963, name = "Living Mud Mask" },
            { speciesId = 3350, npcId = 191627, name = "Lord Basilton" },
            { speciesId = 3286, npcId = 189108, name = "Mister Toots" },
            { speciesId = 3368, npcId = 194004, name = "Shiverweb Broodling" },
            { speciesId = 3319, npcId = 189204, name = "Yipper" },
            { speciesId = 3302, npcId = 189138, name = "Pilot" },
            { speciesId = 3325, npcId = 189159, name = "Bakar Companion" },
            { speciesId = 3311, npcId = 189134, name = "Ohuna Companion" },
        },
        toys = {
            { itemId = 202019, name = "Golden Dragon Goblet" },
            { itemId = 202022, name = "Yennu's Kite" },
            { itemId = 201927, name = "Gleaming Arcanocrystal" },
            { itemId = 200878, name = "Wheeled Floaty Boaty Controller" },
            { itemId = 200869, name = "Ohn Lite Branded Horn" },
            { itemId = 200857, name = "Talisman of Sargha" },
            { itemId = 200160, name = "Notfar's Favorite Food" },
            { itemId = 198409, name = "Personal Shell" },
            { itemId = 200148, name = "A Collection of Me" },
            { itemId = 200999, name = "The Super Shellkhan Gang" },
            { itemId = 201933, name = "Black Dragon's Challenge Dummy" },
            { itemId = 200198, name = "Primalist Prison" },
            { itemId = 200640, name = "Obsidian Egg Clutch" },
            { itemId = 199902, name = "Wayfinder's Compass" },
            { itemId = 199649, name = "Dragon Tea Set" },
            { itemId = 199897, name = "Blue-Covered Beanbag" },
            { itemId = 194885, name = "Ohuna Perch" },
            { itemId = 199650, name = "Whale Bone Tea Set" },
            { itemId = 199892, name = "Tuskarr Traveling Soup Pot" },
            { itemId = 199899, name = "Iskaara Tug Sled" },
            { itemId = 198827, name = "Magical Snow Sled" },
            { itemId = 198728, name = "Explorers' League Banner" },
            { itemId = 200551, name = "Comfortable Pile of Pelts" },
            { itemId = 198402, name = "Maruuk Cooking Pot" },
            { itemId = 200550, name = "Very Comfortable Pelt" },
            { itemId = 199894, name = "Fisherman's Folly" },
            { itemId = 198720, name = "Soft Purple Pillow" },
            { itemId = 198721, name = "Skinny Reliquary Pillow" },
            { itemId = 198722, name = "Small Triangular Pillow" },
            { itemId = 198729, name = "Reliquary Banner" },
            { itemId = 199767, name = "Red Dragon Banner" },
            { itemId = 199769, name = "Blue Dragon Banner" },
            { itemId = 199770, name = "Bronze Dragon Banner" },
            { itemId = 199771, name = "Green Dragon Banner" },
            { itemId = 199768, name = "Black Dragon Banner" },
            { itemId = 199896, name = "Rubbery Fish Head" },
            { itemId = 202042, name = "Aquatic Shades" },
            { itemId = 202021, name = "Breaker's Flag of Victory" },
            { itemId = 198646, name = "Ornate Dragon Statue" },
            { itemId = 201435, name = "Shuffling Sands" },
            { itemId = 200960, name = "Seed of Renewed Souls" },
            { itemId = 198474, name = "Artist's Easel" },
            { itemId = 200926, name = "Compendium of Love" },
            { itemId = 200597, name = "Lover's Bouquet" },
            { itemId = 201815, name = "Cloak of Many Faces" },
            { itemId = 191891, name = "Professor Chirpsnide's Im-PECK-able Harpy Disguise" },
            { itemId = 198537, name = "Taivan's Trumpet" },
            { itemId = 198857, name = "Lucky Duck" },
            { itemId = 200628, name = "Somewhat-Stabilized Arcana" },
            { itemId = 198039, name = "Rock of Appreciation" },
            { itemId = 200630, name = "Ohn'ir Windsage's Hearthstone" },
            { itemId = 197986, name = "Murglasses" },
            { itemId = 200631, name = "Happy Tuskarr Palooza" },
            { itemId = 198428, name = "Tuskarr Dinghy" },
            { itemId = 198090, name = "Jar of Excess Slime" },
            { itemId = 194056, name = "Duck-Stuffed Duck Lovie" },
            { itemId = 194059, name = "Market Tent" },
            { itemId = 193476, name = "Gnoll Tent" },
            { itemId = 194060, name = "Dragonscale Expedition's Expedition Tent" },
            { itemId = 197719, name = "Artisan's Sign" },
            { itemId = 193478, name = "Tuskarr Beanbag" },
            { itemId = 194057, name = "Cushion of Time Travel" },
            { itemId = 198206, name = "Environmental Emulator" },
            { itemId = 192443, name = "Element-Infused Rocket Helmet" },
            { itemId = 194058, name = "Cold Cushion" },
            { itemId = 200469, name = "Khadgar's Disenchanting Rod" },
            { itemId = 198264, name = "Centralized Precipitation Emitter" },
            { itemId = 194052, name = "Forlorn Funeral Pall" },
            { itemId = 198227, name = "Giggle Goggles" },
            { itemId = 193033, name = "Convergent Prism" },
            { itemId = 193032, name = "Jeweled Offering" },
            { itemId = 199554, name = "S.E.A.T." },
            { itemId = 192495, name = "Malfunctioning Stealthman 54" },
            { itemId = 200178, name = "Infected Ichor" },
            { itemId = 200249, name = "Mage's Chewed Wand" },
            { itemId = 200636, name = "Primal Invocation Quintessence" },
            { itemId = 200116, name = "Everlasting Horn of Lavaswimming" },
        },
        cosmetics = PATCH_10_0_COSMETICS,
        cosmeticDetailGroups = {
            dragonscaleExpeditionTools = {
                sourceType = "Renown Vendor",
                source = "Rae'ana / Dragonscale Basecamp",
                acquisition = "Reach Dragonscale Expedition Renown 3 for the four excavation hand tools or Renown 7 for the excavator, magnifier, and sweeper, then purchase each appearance token from Rae'ana.",
                tips = "The Renown 3 tools cost 150 Dragon Isles Supplies plus three profession materials. The Renown 7 tools cost 600 supplies plus a small material fee. Check each tooltip before buying because every token teaches only its own appearance.",
                cost = "150 or 600 Dragon Isles Supplies plus listed crafting materials.",
                waypoints = { "/way #2022 47.8 82.0 Rae'ana / Dragonscale Basecamp" },
            },
            dragonscaleExpeditionCloaks = {
                sourceType = "Renown Vendor",
                source = "Pathfinder Jeb / Dragonscale Basecamp",
                acquisition = "Reach Dragonscale Expedition Renown 4 and buy the four expedition cloak appearance tokens from Pathfinder Jeb.",
                tips = "Each cloak costs 75 Dragon Isles Supplies and 10 Tattered Wildercloth. These are four independent appearances, not a single ensemble.",
                requirements = "Dragonscale Expedition Renown 4.",
                cost = "75 Dragon Isles Supplies and 10 Tattered Wildercloth each.",
                waypoints = { "/way #2022 47.2 83.4 Pathfinder Jeb / Dragonscale Basecamp" },
            },
            dragonscaleExpeditionArmor = {
                sourceType = "Renown Vendor",
                source = "Cataloger Jakes / Dragonscale Basecamp",
                acquisition = "Reach Dragonscale Expedition Renown 14 and purchase the wrapper matching the armor type you want to learn.",
                tips = "Each wrapper teaches its whole expedition outfit, so the internal piece records are intentionally omitted. The price is 750 Dragon Isles Supplies plus 40 cloth or 20 of the matching leather, scales, or ore.",
                requirements = "Dragonscale Expedition Renown 14.",
                cost = "750 Dragon Isles Supplies plus an armor-type material fee.",
                waypoints = { "/way #2022 47.1 82.6 Cataloger Jakes / Dragonscale Basecamp" },
            },
            valdrakkenCooking = {
                sourceType = "Renown Vendor",
                source = "Erugosa / Valdrakken",
                acquisition = "Reach Valdrakken Accord Renown 3, then buy the six dinner-utensil and goblet appearance tokens from Erugosa.",
                tips = "The silver pieces use Serevite Ore and the gold pieces use Draconium Ore in addition to Dragon Isles Supplies. These are one-at-a-time appearance consumables.",
                requirements = "Valdrakken Accord Renown 3.",
                waypoints = { "/way #2112 46.5 46.2 Erugosa / Roasted Ram" },
            },
            valdrakkenGardening = {
                sourceType = "Renown Vendor",
                source = "Gryrmpech / Valdrakken",
                acquisition = "Reach Valdrakken Accord Renown 6 and purchase the five gardening-tool appearance tokens.",
                tips = "Bring Dragon Isles Supplies and basic ore or wood-like profession materials. The hand shovel and full shovel are distinct collection appearances.",
                requirements = "Valdrakken Accord Renown 6.",
                waypoints = { "/way #2112 36.2 49.6 Valdrakken Accord cosmetic vendors / Obsidian Enclave" },
            },
            valdrakkenDragonspawnArmor = {
                sourceType = "Renown Vendor",
                source = "Armorsmith Terisk / Valdrakken",
                acquisition = "Unlock basic shoulders at Renown 10, drakonid helms at Renown 17, and jeweled or plated shoulders at Renown 28; buy each color separately from Armorsmith Terisk.",
                tips = "There are twenty individual tokens across the three ranks. Compare the learned status in the collection window before paying the supply and material cost for another color.",
                requirements = "Valdrakken Accord Renown 10, 17, or 28 depending on the item.",
                waypoints = { "/way #2112 36.2 49.6 Armorsmith Terisk / Obsidian Enclave" },
            },
            valdrakkenTitanWeapons = {
                sourceType = "Renown Vendor",
                source = "Weaponmaster Vordak / Valdrakken",
                acquisition = "Reach Valdrakken Accord Renown 13 and purchase each Titan-themed weapon appearance token from Weaponmaster Vordak.",
                tips = "These are separate consumables for a gun, shield, sword, two-handed sword, and scepter. Bring Dragon Isles Supplies and the material shown on the vendor tooltip.",
                requirements = "Valdrakken Accord Renown 13.",
                waypoints = { "/way #2112 36.2 49.6 Weaponmaster Vordak / Obsidian Enclave" },
            },
            valdrakkenClothing = {
                sourceType = "Renown Vendor",
                source = "Valdrakken Accord quartermasters",
                acquisition = "Reach Valdrakken Accord Renown 20 and buy each color wrapper to teach the matching civilian Valdrakken outfit.",
                tips = "The five wrappers are tracked instead of every hidden component they teach. Inspect all five colors before choosing because each is a separate purchase.",
                requirements = "Valdrakken Accord Renown 20.",
                waypoints = { "/way #2112 36.2 49.6 Valdrakken Accord cosmetic vendors / Obsidian Enclave" },
            },
            valdrakkenCivilianTools = {
                sourceType = "Renown Vendor",
                source = "Valdrakken civilian profession vendors",
                acquisition = "Reach Valdrakken Accord Renown 25 and buy the eight civilian book, torch, bottle, and alchemy-tool appearance tokens.",
                tips = "The stock is divided among profession-themed vendors around the Artisan's Market and Obsidian Enclave. Use the market pin as the starting point and check learned status before buying duplicate-looking off-hands.",
                requirements = "Valdrakken Accord Renown 25.",
                waypoints = { "/way #2112 30.8 61.4 Artisan's Market / civilian cosmetic vendors" },
            },
            valdrakkenDragonWeapons = {
                sourceType = "Renown Vendor",
                source = "Weaponmaster Vordak / Valdrakken",
                acquisition = "Reach Valdrakken Accord Renown 29 and buy the nineteen dragon-themed weapon appearance consumables.",
                tips = "This is the largest Accord cosmetic tier. Each token normally costs Dragon Isles Supplies plus a profession material, so bring a mixed stack of Dragon Isles crafting goods or use the Auction House nearby.",
                requirements = "Valdrakken Accord Renown 29.",
                cost = "Usually 600 Dragon Isles Supplies plus a listed crafting material per weapon.",
                waypoints = { "/way #2112 36.2 49.6 Weaponmaster Vordak / Obsidian Enclave" },
            },
            iskaaraCookingAndHats = {
                sourceType = "Renown Vendor",
                source = "Iskaara Tuskarr renown vendors / Iskaara",
                acquisition = "Reach Iskaara Tuskarr Renown 4 for the two cooking tools and Renown 6 for the eight stocking-cap and ear-warmer colors, then buy each token in Iskaara.",
                tips = "The cosmetic stock is split among profession and clothing vendors. The four stocking caps and four ear warmers are individual tokens despite their similar silhouettes.",
                requirements = "Iskaara Tuskarr Renown 4 or 6.",
                waypoints = { "/way #2024 13.8 49.2 Iskaara renown cosmetic vendors" },
            },
            iskaaraTraderGear = {
                sourceType = "Renown Vendor",
                source = "Iskaara Tuskarr renown vendors / Iskaara",
                acquisition = "Reach Renown 12 for the trader ensemble and cloak, then Renown 16 for twelve fisherman, trader, and backpack color variants.",
                tips = "The Renown 12 ensemble is one wrapper and its learned pieces are not duplicated. At Renown 16 there are three backpack shapes with four colors each; verify both shape and tint before buying.",
                requirements = "Iskaara Tuskarr Renown 12 or 16.",
                waypoints = { "/way #2024 13.8 49.2 Iskaara renown cosmetic vendors" },
            },
            iskaaraWeaponsAndShoulders = {
                sourceType = "Renown Vendor",
                source = "Tatto / Iskaara cosmetic vendors",
                acquisition = "Reach Iskaara Tuskarr Renown 24 for six weapon tokens and Renown 28 for twelve shoulder tokens, then buy them in Iskaara.",
                tips = "The shoulder tier contains cloth-like pads, depth guards, and heavier spaulders. Every color is separate; none of these rows is an ensemble wrapper.",
                requirements = "Iskaara Tuskarr Renown 24 or 28.",
                waypoints = { "/way #2024 13.8 49.2 Iskaara renown cosmetic vendors" },
            },
            iskaaraPawPacks = {
                sourceType = "Renown Vendor",
                source = "Iskaara Tuskarr renown vendors / Iskaara",
                acquisition = "Reach Iskaara Tuskarr Renown 29 and purchase the five Paw Pack color tokens.",
                tips = "All five are back appearances learned on use. Compare the print and base-color names carefully because several icons are nearly identical.",
                requirements = "Iskaara Tuskarr Renown 29.",
                waypoints = { "/way #2024 13.8 49.2 Iskaara renown cosmetic vendors" },
            },
            bigKinookLadle = {
                sourceType = "Achievement Reward",
                source = "Leftovers' Revenge / Community Feast",
                acquisition = "During a legendary-quality Community Feast, defeat Bisquius to earn Leftovers' Revenge and receive Big Kinook's Spare Ladle.",
                tips = "The feast must reach Legendary before Bisquius can be summoned. Join an active shard before the timer starts, follow every Yes, Chef! task quickly, and prioritize the boss when it appears.",
                requirements = "Leftovers' Revenge during a legendary-quality Community Feast.",
                waypoints = { "/way #2024 13.5 48.6 Big Kinook / Community Feast" },
            },
            maruukArmor = {
                sourceType = "Renown Vendor",
                source = "Quartermaster Huseng / Maruukai",
                acquisition = "Raise Maruuk Centaur renown to unlock the four helm sets and four shoulder sets, then purchase each individual clan/color token in Maruukai.",
                tips = "These twenty-four appearances are not wrappers. Vendor prices combine Dragon Isles Supplies with hides, scales, wool, or other materials; check learned status before buying a visually similar clan tint.",
                requirements = "Maruuk Centaur renown milestones for helms and shoulders.",
                waypoints = { "/way #2023 60.9 39.2 Quartermaster Huseng / Maruukai" },
            },
            maruukWeapons = {
                sourceType = "Renown Vendor",
                source = "Weaponmaster Aloom and Farrier Rondare / Maruukai",
                acquisition = "Unlock Maruuk weapon cosmetics through renown and purchase the fifteen spear, blade, tool, mace, axe, and shield appearance tokens.",
                tips = "A renown quest can grant one choice for free; buy the remaining appearances individually. Most cost 600 Dragon Isles Supplies plus a regional crafting material.",
                requirements = "Maruuk Centaur weapon-cosmetic renown unlock.",
                cost = "Usually 600 Dragon Isles Supplies plus a listed crafting material.",
                waypoints = { "/way #2023 62.4 42.2 Weaponmaster Aloom / Maruukai", "/way #2023 60.9 39.2 Maruukai vendor hub" },
            },
            cobaltAssemblyArmor = {
                sourceType = "Reputation Vendor",
                source = "Steiz / Cobalt Assembly",
                acquisition = "Complete Welcome to the Assembly, farm Cobalt Assembly power to High, and buy the eight Cobalt Watcher armor tokens from Steiz.",
                tips = "Kill Sundered Flame enemies in a group, loot immediately because corpses can despawn quickly, and take useful Wild Arcana powers as they drop. Group Finder is much faster than solo farming.",
                requirements = "Cobalt Assembly High power.",
                cost = "100 Dragon Isles Supplies and 1 Awakened Frost each.",
                waypoints = { "/way #2024 49.4 22.6 Steiz / Cobalt Assembly", "/way #2024 48.0 18.0 Cobalt Assembly elite farm" },
            },
            cobaltAssemblyWeapons = {
                sourceType = "Reputation Vendor",
                source = "Steiz / Cobalt Assembly",
                acquisition = "Reach Maximum power with the Cobalt Assembly and purchase the twelve Cobalt weapon appearance tokens from Steiz.",
                tips = "The power grind uses the same Sundered Flame farm as the armor tier. Keep farming after High until the Maximum vendor tier opens; loot every Arcana orb and corpse promptly.",
                requirements = "Cobalt Assembly Maximum power.",
                waypoints = { "/way #2024 49.4 22.6 Steiz / Cobalt Assembly", "/way #2024 48.0 18.0 Cobalt Assembly elite farm" },
            },
            blackDragonReputation = {
                sourceType = "Reputation Vendor",
                source = "Wrathion and Sabellian quartermasters / Obsidian Citadel",
                acquisition = "At level 70, choose Allegiance to One each week, turn in Restored Obsidian Keys, and raise both Wrathion and Sabellian. Ensembles unlock at Cohort or Ally; weapons unlock at Fang.",
                tips = "You can change allegiance on a later weekly reset and eventually max both reputations. A Restored Obsidian Key needs 30 Key Fragments and 3 Key Framings. The claw and Onyx blade are shared; the remaining weapon stock differs by patron.",
                requirements = "Level 70 and the listed Wrathion or Sabellian reputation rank.",
                cost = "Ensembles: 750 supplies plus materials; weapons: usually 600 supplies plus materials.",
                waypoints = { "/way #2022 26.5 62.5 Wrathion quartermaster / Obsidian Citadel", "/way #2022 27.7 56.2 Sabellian quartermaster / Obsidian Citadel" },
            },
            dragonflightIllusions = {
                sourceType = "Crafted Illusion",
                source = "Dragon Isles Enchanting / Crafting Orders",
                acquisition = "Have an enchanter craft the illusion or place a crafting order. The four elemental formulas come from Primal Storm enemies; Formula: Primal Mastery drops from Kurog Grimtotem in Vault of the Incarnates.",
                tips = "The crafter needs Dragon Isles Enchanting 50. You do not need Enchanting to learn the finished illusion, so compare Auction House and crafting-order prices before farming the formula yourself.",
                requirements = "Dragon Isles Enchanting 50 for the crafter.",
                waypoints = { "/way #2112 30.8 61.4 Enchanting crafting orders / Artisan's Market", "/way #2022 72.0 56.0 Vault of the Incarnates entrance" },
            },
            dragonflightJewelcrafting = {
                sourceType = "Crafted Appearance",
                source = "Dragon Isles Jewelcrafting / Crafting Orders",
                acquisition = "Craft the cosmetic glasses with Dragon Isles Jewelcrafting, buy the finished token from the Auction House, or place a public or personal crafting order.",
                tips = "The finished items are consumed to teach their appearances. Search by exact quoted name for Rhinestone Sunglasses because generic searches can mix in ordinary equippable eyewear.",
                waypoints = { "/way #2112 30.8 61.4 Jewelcrafting orders / Artisan's Market", "/way #2112 42.5 59.9 Valdrakken Auction House" },
            },
            lifePoolsWateringCan = {
                sourceType = "Quest Reward",
                source = "A Better Start / Life-Binder Conservatory",
                acquisition = "Complete the Ruby Lifecalling side story through Leave Bee Alone and Just a Trim, then accept A Better Start from Adazius and choose the Life Pools Watering Can.",
                tips = "The quest only asks you to plant six nearby seeds, but it will not appear until the two prerequisite garden quests are complete. Choose the watering can rather than the alternate herb pouch.",
                requirements = "Level 58; complete A Better Start (quest 66737).",
                waypoints = { "/way #2022 61.9 73.8 Ruby Lifecalling story start", "/way #2022 55.2 63.7 Adazius / A Better Start" },
            },
            brackenhideWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Brackenhide gnolls and Brackenhide-area containers / Azure Span",
                acquisition = "Farm Brackenhide gnolls and regional containers around Brackenhide Hollow, or buy the bind-on-equip appearance token from the Auction House.",
                tips = "The open-world camps are faster to reset than the dungeon. Pull dense gnoll packs, check rares and containers on the route, and search the Auction House by exact item name if one weapon refuses to drop.",
                researchNotes = "These are learn-on-use cosmetic tokens, not ordinary dungeon weapons. Drop pools are broad and individual rates are low.",
                waypoints = { "/way #2024 11.6 48.8 Brackenhide Hollow entrance", "/way #2024 13.0 32.0 Brackenhide open-world gnoll camps" },
            },
            imbuWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Imbu Primalists and Tuskarr containers / Azure Span",
                acquisition = "Farm hostile Primalists around Imbu and nearby Tuskarr containers for the seven Imbu weapon tokens, or purchase them from the Auction House.",
                tips = "Use a circular route through the ruins and loot every chest. Current-client Tuskarr Chest pools can also contain these appearances, so check containers even if the nearby mobs are already dead.",
                researchNotes = "The items were present in the launch snapshot; container availability and loot tables have changed in later patches.",
                waypoints = { "/way #2024 59.5 66.9 Imbu Primalist farm" },
            },
            nokhudWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Nokhud enemies, Clan Chests, and elemental chests / Ohn'ahran Plains",
                acquisition = "Farm Nokhud forces and open Clan Chests or elemental event chests across the plains for the weapon and Nokhudon armor tokens; the bind-on-equip tokens may also be bought on the Auction House.",
                tips = "Combine the farm with Nokhudon Hold rares and chest routes. The nine Nokhudon armor pieces are separate use-to-learn tokens rather than a single ensemble.",
                waypoints = { "/way #2023 30.7 35.5 Nokhudon Hold", "/way #2023 60.9 39.2 Maruukai / Nokhud Offensive staging" },
            },
            drakonidWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Dragonspawn and drakonid enemies / Dragon Isles",
                acquisition = "Loot dragonspawn and drakonid enemies and their regional containers across the Dragon Isles, or buy the bind-on-equip appearance tokens from the Auction House.",
                tips = "These eleven weapons have broad thematic drop pools rather than a single guaranteed mob. Farm dense drakonid areas while completing other objectives and use exact-name Auction House searches to finish gaps.",
                researchNotes = "The historical item snapshot confirms all eleven as launch use-to-learn appearance tokens; no narrow guaranteed drop is asserted.",
                waypoints = { "/way #2022 28.0 60.0 Obsidian Citadel drakonid routes", "/way #2025 57.0 58.0 Tyrhold dragonspawn routes" },
            },
            obsidianWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Djaradin, Djaradin Caches, and Obsidian Citadel containers / Waking Shores",
                acquisition = "Farm Djaradin and their caches around the Obsidian Citadel and Dragonheart Outpost for the weapon and Citadel Crusher armor tokens, or purchase the bind-on-equip tokens.",
                tips = "Djaradin Caches can award multiple armor pieces at once. Include the ruined-tent cache near Dragonheart Outpost in the route, then sweep the denser Citadel camps and rares.",
                researchNotes = "The nine Citadel Crusher pieces remain individual cosmetic consumables; there is no ensemble wrapper to substitute for them.",
                waypoints = { "/way #2022 28.0 60.0 Obsidian Citadel Djaradin farm", "/way #2022 71.3 44.6 Dragonheart Outpost cache area" },
            },
            tyrholdWorldDrops = {
                sourceType = "Regional World Drop",
                source = "Titan constructs and Titan containers / Tyrhold",
                acquisition = "Farm Titan constructs and containers around Tyrhold for the seven weapon and nine cloth-armor appearance tokens, or buy the bind-on-equip tokens from the Auction House.",
                tips = "Run the exterior construct circuit while checking rares and treasure spawns. All nine armor slots are separate consumables, so confirm learned status before buying a piece with a similar icon.",
                waypoints = { "/way #2025 57.0 58.0 Tyrhold construct and container route" },
            },
            crimsonEliteWeapons = {
                sourceType = "Legacy Elite PvP Reward",
                source = "Dragonflight Season 1 Elite weapon appearances",
                acquisition = "These tokens were unlocked by reaching 2,400 rating during Dragonflight Season 1. Accounts that earned the entitlement can inspect Glamora and the legacy PvP vendors in Gladiator's Refuge.",
                tips = "The original Elite entitlement is no longer earnable. Do not confuse these eighteen purple-arrow tokens with current Mark-of-Honor arsenals; confirm the Crimson name and learned state on the vendor tooltip.",
                requirements = "Dragonflight Season 1 Elite weapon appearance entitlement, originally earned at 2,400 rating.",
                availability = "Legacy access only for accounts that earned the Season 1 Elite entitlement.",
                waypoints = { "/way #2112 43.1 42.3 Gladiator's Refuge / legacy PvP vendors" },
            },
            shadowlandsPvP = {
                sourceType = "Legacy PvP Vendor",
                source = "Zo'sorg and Purveyor Zo'kuul / Oribos",
                acquisition = "Purchase the Shadowlands Season 1, 2, and 3 Aspirant or Gladiator ensembles and weapon arsenals with Marks of Honor from the legacy PvP vendors in Oribos.",
                tips = "Armor ensembles generally cost 12 Marks of Honor and weapon arsenals 80. The four Sinful Gladiator arsenals are covenant-colored; covenant membership or the legacy Renown 80 account unlock may affect which appearances a character can use.",
                cost = "Armor ensembles: 12 Marks of Honor; weapon arsenals: 80 Marks of Honor.",
                researchNotes = "Dragonflight introduced these permanent use-to-learn wrappers. Internal set pieces are deliberately omitted, and item 201874 is not part of the sequence.",
                waypoints = { "/way #1670 34.8 57.6 Zo'sorg and Purveyor Zo'kuul / Oribos" },
            },
        },
        achievements = {},
    },
    ["10.0.5"] = {
        label = "Patch 10.0.5: Storm's Fury",
        wowheadPatchId = 100005,
        sourceNotes = {
            "This backfill covers the permanent Storm's Fury mount, pet, toy, achievement, and Cosmetic rewards plus the patch's other permanent collectible additions.",
            "The seven Primal Revenant appearance tokens were preloaded in launch data but are assigned here because their permanent acquisition source, Storm's Fury, opened in patch 10.0.5.",
            "Trading Post, Timewalking, crossover, Trial of Style, other calendar-event rewards, and ordinary equippable items are excluded.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23892227",
            stormsFury = "https://www.wowhead.com/guide/storms-fury-event-rewards",
        },
        mounts = {
            { spellId = 352926, itemId = 192800, name = "Skyskin Hornstrider" },
        },
        pets = {
            { speciesId = 3334, npcId = 191298, name = "Time-Lost Vorquin Foal" },
        },
        toys = {
            { itemId = 202020, name = "Chasing Storm" },
            { itemId = 202207, name = "Reusable Oversized Bobber" },
            { itemId = 202309, name = "Defective Doomsday Device" },
        },
        cosmetics = PATCH_10_0_5_COSMETICS,
        cosmeticDetailGroups = {
            stormsFury = {
                sourceType = "Permanent World Event",
                source = "Primal caches / Storm's Fury, Primalist Tomorrow",
                acquisition = "Enter Primalist Tomorrow through the Temporal Conflux while Storm's Fury is active, close four portals, defeat the final boss, and open the event's Primal caches for a chance at the seven weapon or shield appearance tokens.",
                tips = "Pick up the event quest before entering, join a group, and keep moving between portals so the Freezing meter does not overwhelm you. The tokens are chance rewards rather than direct currency purchases, so repeat later event cycles and check the Auction House for bind-on-equip gaps.",
                requirements = "Level 70; Storm's Fury must be active.",
                researchNotes = "Storm's Fury is a permanent recurring Dragonflight system, not a limited calendar event. Its rewards belong to 10.0.5 even though the item records existed in the launch client.",
                waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / portal to Primalist Tomorrow" },
            },
        },
        achievements = {
            ids = PATCH_10_0_5_ACHIEVEMENTS,
            rewardHighlights = {
                { achievementId = 17207, name = "Discombobberlated", reward = "Toy: Reusable Oversized Bobber" },
            },
        },
    },
    ["10.0.7"] = {
        label = "Patch 10.0.7: Return to the Forbidden Reach",
        wowheadPatchId = 100007,
        sourceNotes = {
            "This backfill covers permanent 10.0.7 mounts, battle pets, toys, achievements, and Cosmetics.",
            "Trading Post, Timewalking, crossover, Recruit-a-Friend, shop, and unavailable PTR rewards are excluded.",
            "The four elemental-storm ensembles 203693-203696 and Cloak of Dark Descent are excluded because no verified live acquisition existed.",
            "Zul'Gurub, heritage, Baine, Forbidden Reach, and Square Holders wrappers are permanent content; internal ensemble components are not duplicated.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23923483",
            notes = "https://worldofwarcraft.blizzard.com/news/23923813/dragonflight-1007-content-update-notes-now-live",
            humanHeritage = "https://www.wowhead.com/guide/transmogrification/human-heritage-armor",
            orcHeritage = "https://www.wowhead.com/guide/transmogrification/orc-heritage-armor",
            oldHatreds = "https://warcraft.wiki.gg/wiki/A_Final_Word",
            zulGurub = "https://www.wowhead.com/guide/collections/unlock-access-old-zulgurub",
            forbiddenReach = "https://www.icy-veins.com/wow/forbidden-reach-zone-guide",
            squareHolders = "https://www.wowhead.com/item=204406/ancient-design-square-holders",
            overview = "https://www.wowhead.com/guide/dragonflight-patch-10-0-7-overview",
            zskeraVaults = "https://www.wowhead.com/guide/forbidden-reach/zskera-vault",
            battlePets = "https://www.wowhead.com/guide/dragonflight-the-forbidden-reach-pet-battle-collection-overview-19434",
            mounts = "https://warcraftmounts.com/patch10.0.7.php",
        },
        mounts = {
            { spellId = 349935, itemId = 204382, name = "Noble Bruffalon" },
            { spellId = 374090, itemId = 192772, name = "Ancient Salamanther" },
            { spellId = 374157, itemId = 192785, name = "Gooey Snailemental" },
            { spellId = 374194, itemId = 192790, name = "Mossy Mammoth" },
        },
        pets = {
            { speciesId = 3293, npcId = 189118, name = "Ashenwing" },
            { speciesId = 3285, npcId = 189106, name = "Luvvy" },
            { speciesId = 3291, npcId = 189115, name = "Scruffles" },
            { speciesId = 3261, npcId = 188821, name = "Wakyn" },
            { speciesId = 3331, npcId = 189694, name = "Emmah" },
            { speciesId = 3338, npcId = 191435, name = "Kobaldt" },
            { speciesId = 3333, npcId = 191287, name = "Berylmane" },
            { speciesId = 3323, npcId = 189158, name = "Brightfeather" },
            { speciesId = 3332, npcId = 189696, name = "Patos" },
            { speciesId = 3476, npcId = 202484, name = "Gilded Mechafrog" },
            { speciesId = 3330, npcId = 189661, name = "Buckie" },
            { speciesId = 3427, npcId = 200259, name = "Driftling" },
            { speciesId = 3259, npcId = 188709, name = "Shaggy" },
            { speciesId = 3290, npcId = 189113, name = "Bunbo" },
            { speciesId = 3449, npcId = 200772, name = "Flow" },
            { speciesId = 3447, npcId = 200770, name = "Tremblor" },
            { speciesId = 3446, npcId = 200769, name = "Vortex" },
            { speciesId = 3448, npcId = 200771, name = "Wildfire" },
        },
        toys = {
            { itemId = 202253, name = "Primal Stave of Claw and Fur" },
            { itemId = 202283, name = "Reading Glasses" },
            { itemId = 203725, name = "Display of Strength" },
            { itemId = 203757, name = "Brazier of Madness" },
            { itemId = 203734, name = "Snow Blanket" },
            { itemId = 202360, name = "Dented Can" },
            { itemId = 204170, name = "Clan Banner" },
            { itemId = 204256, name = "Holoviewer: The Scarlet Queen" },
            { itemId = 204257, name = "Holoviewer: The Lady of Dreams" },
            { itemId = 204262, name = "Holoviewer: The Timeless One" },
            { itemId = 199900, name = "Secondhand Survey Tools" },
            { itemId = 203852, name = "Spore-Bound Essence" },
            { itemId = 201930, name = "H.E.L.P." },
            { itemId = 204687, name = "Obsidian Battle Horn" },
            { itemId = 204405, name = "Stuffed Bear" },
        },
        cosmetics = PATCH_10_0_7_COSMETICS,
        cosmeticDetailGroups = {
            humanHeritage = {
                sourceType = "Heritage Questline",
                source = "An Urgent Matter / Human Heritage Armor",
                acquisition = "On a level-50-or-higher Human, begin An Urgent Matter in Stormwind and complete the Human heritage questline through The New Guard to receive the three Lion's Heritage ensemble wrappers.",
                tips = "Modern heritage quests no longer require Exalted reputation. If the summons is absent, visit the Stormwind Embassy and confirm the character is a core-race Human rather than Kul Tiran.",
                requirements = "Level 50 or higher Human; complete The New Guard.",
                waypoints = { "/way #84 54.4 20.8 Stormwind Embassy / Human heritage start" },
            },
            orcHeritage = {
                sourceType = "Heritage Questline",
                source = "A People in Need of Healing / Orc Heritage Armor",
                acquisition = "On a level-50-or-higher Orc, begin the heritage chain in Orgrimmar and complete A Blessing for the Future to receive the three Wolf's Heritage clan ensemble wrappers.",
                tips = "The chain asks you to choose a clan, but completion awards the Blackrock, Frostwolf, and Warsong ensemble wrappers together. Visit the Orgrimmar Embassy if the starting summons is missing.",
                requirements = "Level 50 or higher Orc; complete A Blessing for the Future.",
                waypoints = { "/way #85 39.1 79.0 Orgrimmar Embassy / Orc heritage start" },
            },
            oldHatreds = {
                sourceType = "Questline Reward",
                source = "Old Hatreds / A Final Word",
                acquisition = "Start the Baine Bloodhoof storyline from Mayla Highmountain in Valdrakken, follow it through the Ohn'ahran Plains, and complete A Final Word with Baine.",
                tips = "The Ancestral Bloodhoof Totem and Ancestor's Might are both appearance consumables. Use a Tauren or Highmountain Tauren on a class able to learn two-handed mace appearances to ensure the weapon reward is offered; other characters can receive a toy instead.",
                requirements = "Level 70; Tauren or Highmountain Tauren and a two-handed-mace-capable class for both appearances.",
                waypoints = { "/way #2112 50.8 57.9 Mayla Highmountain / questline start", "/way #2023 72.7 56.1 Baine Bloodhoof / A Final Word" },
            },
            oldZulGurub = {
                sourceType = "Secret Unlock and Vendor",
                source = "Rin'wosho / Yojamba Exchange, Dazar'alor",
                acquisition = "At level 70, enter Heroic Zul'Gurub, loot the Shattered Hakkari Bijou below the gong, kill two bosses, start Jin'do and reach the spirit phase, then loot the Fragmented Hakkari Bijou below the gong. Combine and turn it in to Rin'wosho to unlock the ensembles.",
                tips = "After earning Relics of a Fallen Empire, exchange classic Hakkari Bijous and Zandalar Bargaining Tokens at Rin'wosho. Bargaining Tokens come from coin-set turn-ins and Tribute Piles; the corresponding-color bijous drop inside Zul'Gurub.",
                requirements = "Level 70 and Relics of a Fallen Empire account unlock.",
                cost = "Class ensembles: 6 matching Hakkari Bijous and 4 Bargaining Tokens; armor ensembles: 4 bijous and 6 tokens.",
                researchNotes = "The thirteen wrappers are tracked once each; the many appearances taught by them are intentionally not duplicated.",
                waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance", "/way #1165 55.0 86.8 Rin'wosho / Yojamba Exchange" },
            },
            forbiddenReachTreysh = {
                sourceType = "Currency Vendor",
                source = "Treysh / Morqut Village, Forbidden Reach",
                acquisition = "Collect Elemental Overflow from Primalist enemies and Forbidden Reach activities, then buy each of the seven appearance tokens from Treysh in Morqut Village.",
                tips = "Rare groups and Primalist event clusters provide Overflow quickly. All seven tokens use similar purple-arrow item framing, so inspect learned status before spending another 5,000 currency.",
                cost = "5,000 Elemental Overflow each.",
                waypoints = { "/way #2151 36.6 59.5 Treysh / Morqut Village" },
            },
            squareHolders = {
                sourceType = "Crafted Appearance",
                source = "Classic Jewelcrafting / Ancient Design from Gahz'rilla",
                acquisition = "First unlock Relics of a Fallen Empire through old Zul'Gurub. Farm Ancient Design: Square Holders from Gahz'rilla in Normal Zul'Farrak, then craft the appearance token with Classic Jewelcrafting 300 or commission a crafter.",
                tips = "The recipe is the real farm; once learned, the craft needs 2 Azerothian Diamonds, 6 Truesilver Bars, 2 Thorium Settings, and 1 Massive Mojo. Normal Zul'Farrak is sufficient for Gahz'rilla.",
                requirements = "Relics of a Fallen Empire unlock; Classic Jewelcrafting 300 for the crafter.",
                cost = "2 Azerothian Diamond, 6 Truesilver Bar, 2 Thorium Setting, and 1 Massive Mojo.",
                waypoints = { "/way #71 39.2 21.4 Zul'Farrak entrance / Gahz'rilla recipe farm" },
            },
        },
        achievements = {
            ids = PATCH_10_0_7_ACHIEVEMENTS,
            rewardHighlights = {
                { achievementId = 17543, name = "You Know How to Reach Me", reward = "Title: The Forbidden" },
            },
        },
    },
    ["10.1"] = {
        label = "Patch 10.1: Embers of Neltharion",
        wowheadPatchId = 100100,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only permanent use-to-learn appearance items and ensemble wrappers are included. Ordinary equippable drops and direct appearance grants are excluded.",
            "Trading Post, Timewalking, crossover, and limited-event rewards are excluded.",
            "The Black and Blue Dragonflight ensembles are represented by their wrappers; the appearances learned inside them are not duplicated.",
            "Obsidian Gladiator weapon tokens remain listed for owners of the original Dragonflight Season 2 Elite entitlement; that entitlement can no longer be earned.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23935248",
            overview = "https://www.wowhead.com/guide/dragonflight-patch-10-1-embers-of-neltharion-overview",
            zaralek = "https://www.wowhead.com/guide/zaralek-cavern",
            loamm = "https://www.icy-veins.com/wow/loamm-niffen-reputation-guide",
            blueDragonflight = "https://www.wowhead.com/guide/lore/blue-dragonflight-embers-neltharion",
            moltenHoard = "https://www.wowhead.com/object=398814/molten-hoard",
            pvp = "https://www.wowhead.com/guide/pvp/dragonflight-season-2-rewards",
        },
        mounts = {
            { spellId = 368893, name = "Winding Slitherdrake" },
            { spellId = 371176, name = "Subterranean Magmammoth" },
            { spellId = 374138, name = "Seething Slug" },
            { spellId = 406637, name = "Inferno Armoredon" },
            { spellId = 407555, name = "Tarecgosa's Visage" },
            { spellId = 408313, name = "Big Slick in the City" },
            { spellId = 408627, name = "Igneous Shalewing" },
            { spellId = 408647, name = "Cobalt Shalewing" },
            { spellId = 408649, name = "Shadowflame Shalewing" },
            { spellId = 408651, name = "Cataloged Shalewing" },
            { spellId = 408653, name = "Boulder Hauler" },
            { spellId = 408655, name = "Morsel Sniffer" },
            { spellId = 408977, name = "Obsidian Gladiator's Slitherdrake" },
            { spellId = 409034, name = "Vicious War Snail" },
            { spellId = 409032, name = "Vicious War Snail" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_1_COSMETICS,
        cosmeticDetailGroups = {
            blackDragonflightVestments = {
                sourceType = "Campaign Quest Reward",
                source = "With Our Powers Combined / Zaralek Cavern campaign",
                acquisition = "Complete the Embers of Neltharion campaign through Chapter 5 and turn in With Our Powers Combined to receive the ensemble.",
                tips = "If the chapter is unavailable, continue the Zaralek campaign from Loamm and complete the preceding Black Dragonflight quests. Use the wrapper from the bag; it teaches the matching shoulder, cloak, and tabard appearances together.",
                requirements = "Complete With Our Powers Combined (quest 72925).",
                researchNotes = "The ensemble is tracked once. Its three internal appearance records are deliberately excluded to avoid duplicate collection rows.",
                waypoints = { "/way #2133 56.5 55.6 Loamm campaign hub" },
            },
            loammRenown = {
                sourceType = "Renown Vendor",
                source = "Harlowe Marl / Loamm",
                acquisition = "Reach Loamm Niffen Renown 16 for the labwear ensemble and Renown 18 for the two digging-themed weapon tokens, then buy them from Harlowe Marl.",
                tips = "The renown unlock is account-wide, but the vendor stock can be easiest to inspect on the character that completed the campaign. Bring Dragon Isles Supplies before traveling; the two Renown 18 items are separate appearance consumables.",
                requirements = "Loamm Niffen Renown 16 or 18, depending on the item.",
                researchNotes = "Contemporary price references disagree on an early labwear price; the catalog records the 250-supply live listing and keeps the per-item costs visible.",
                waypoints = { "/way #2133 56.48 55.63 Harlowe Marl / Loamm" },
            },
            ponzoTopper = {
                sourceType = "Bartering Reward",
                source = "Ponzo / Loamm",
                acquisition = "Reach Loamm Niffen Renown 12 to unlock Barter Boulders, then speak with Ponzo and negotiate his 9,999-boulder opening offer down to 249 Barter Boulders.",
                tips = "Select the negotiation dialogue instead of accepting the joke price. Barter Boulders replaced the earlier weekly Barter Brick economy at higher renown, so convert or earn enough before visiting Ponzo.",
                requirements = "Loamm Niffen Renown 12.",
                cost = "249 Barter Boulders after negotiating.",
                waypoints = { "/way #2133 58.0 53.8 Ponzo / Loamm" },
            },
            azureRenewal = {
                sourceType = "Questline Reward",
                source = "Blue Dragonflight reunion / A Peaceful Farewell",
                acquisition = "Begin Keeper of the Ossuary from Kalecgos at the Seat of the Aspects, complete the Blue Dragonflight reunion chapters across the Dragon Isles, and finish A Peaceful Farewell at the Azure Archives.",
                tips = "The chain travels through several old blue-dragon locations and is longer than its opening suggests. If Kalecgos has no quest, reach level 70 and check the Seat of the Aspects; current versions no longer require the full 10.1 campaign.",
                requirements = "Level 70; complete the Blue Dragonflight questline through A Peaceful Farewell.",
                researchNotes = "The wrapper teaches the full Azure Renewal outfit and is tracked instead of its internal components.",
                waypoints = {
                    "/way #2112 61.6 36.2 Kalecgos / Seat of the Aspects",
                    "/way #2024 39.2 63.6 Azure Archives / finale",
                },
            },
            moltenHoard = {
                sourceType = "One-time Treasure",
                source = "Molten Hoard / Aberrus Approach, Zaralek Cavern",
                acquisition = "Enter the small opening beside the lavafall at the Aberrus Approach, move through the grating passage, and loot the Molten Hoard for the sword appearance token.",
                tips = "The chest is behind the visible lavafall rather than on the upper ledge. Follow the entrance pin first, then the interior chest pin. If the item cannot be learned on the looting character, mail the warbound token to a character that can learn one-handed sword appearances.",
                researchNotes = "The two pins distinguish the cave entrance from the chest's interior/vertical position, which otherwise makes the map marker misleading.",
                waypoints = {
                    "/way #2133 48.5 16.6 Molten Hoard entrance by lavafall",
                    "/way #2133 48.2 17.1 Molten Hoard chest inside",
                },
            },
            obsidianEliteWeapons = {
                sourceType = "Legacy Elite PvP Reward",
                source = "Dragonflight Season 2 Elite weapon appearances",
                acquisition = "These tokens were unlocked by reaching 2,400 rating during Dragonflight Season 2. On an entitled account, inspect Glamora and the legacy PvP vendors in Gladiator's Refuge for the corresponding appearance tokens.",
                tips = "The historical Elite entitlement is account-bound and no longer earnable. Do not spend Marks of Honor until the vendor tooltip confirms the correct Obsidian token and your collection does not already know it; legacy vendor packaging has changed since the season.",
                requirements = "Dragonflight Season 2 Elite weapon appearance entitlement, originally earned at 2,400 rating.",
                availability = "Legacy access only for accounts that earned the Season 2 Elite entitlement.",
                researchNotes = "The eleven item IDs are the original purple-arrow weapon appearance tokens. No current generic Mark price is asserted because later arsenal and entitlement-gated listings are easy to conflate.",
                waypoints = { "/way #2112 43.1 42.3 Gladiator's Refuge / legacy PvP vendors" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.1.5"] = {
        label = "Patch 10.1.5: Fractures in Time",
        wowheadPatchId = 100105,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Permanent Time Rift, Eon's Fringe, Soridormi, and Dawn of the Infinite rewards are included; calendar events, Trading Post, Timewalking, and crossover rewards are excluded.",
            "Time Rift appearances can drop from their matching timeline boss or be bought from that timeline's vendor for Paracausal Flakes.",
            "The four Ulderoth armor ensembles are tracked by wrapper only. Their 38 internal component records are not duplicated.",
            "Quantum transformation tokens, vendor container bags, and the unavailable Arcane Detection Rod and Part Dislocator are deliberately excluded.",
        },
        sourceUrls = {
            official = "https://news.blizzard.com/en-us/article/23968772/dragonflight-fractures-in-time-content-update-notes",
            overview = "https://www.wowhead.com/guide/dragonflight-patch-10-1-5-fractures-in-time-overview",
            timeRifts = "https://www.wowhead.com/guide/time-rifts-dragonflight",
            eonsFringe = "https://www.wowhead.com/guide/eons-fringe-quests",
            dawn = "https://www.wowhead.com/guide/mythic-plus-dungeons/dawn-of-the-infinite-loot",
            infiniteAchievement = "https://www.wowhead.com/achievement=18706/put-that-thing-back-where-it-came-from",
            unavailableRod = "https://warcraft.wiki.gg/wiki/Arcane_Detection_Rod",
        },
        mounts = {
            { spellId = 413825, name = "Scarlet Pterrordax" },
            { spellId = 413827, name = "Harbor Gryphon" },
            { spellId = 413922, name = "Valiance" },
            { spellId = 414316, name = "White War Wolf" },
            { spellId = 414323, name = "Ravenous Black Gryphon" },
            { spellId = 414324, name = "Gold-Toed Albatross" },
            { spellId = 414326, name = "Felstorm Dragon" },
            { spellId = 414327, name = "Sulfur Hound" },
            { spellId = 414328, name = "Perfected Juggernaut" },
            { spellId = 414334, name = "Scourgebound Vanquisher" },
            { spellId = 418078, name = "Pattie" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_1_5_COSMETICS,
        cosmeticDetailGroups = {
            timeRiftAzmourne = {
                sourceType = "Time Rift Reward",
                source = "Baron Silver / Azmourne timeline",
                acquisition = "Complete Time Rifts for a chance to enter Azmourne and defeat its final boss, or buy the matching Scourge-themed tokens from Baron Silver with Paracausal Flakes.",
                tips = "Time Rifts begin hourly at Tyrhold Reservoir. Arrive before the portal phase, fill the public-event meter, then enter the Azmourne portal. Encapsulated Destiny can guarantee a collection reward on a run, but not which timeline will open.",
                cost = "Generally 1,000-1,500 Paracausal Flakes each, depending on slot.",
                researchNotes = "Every listed weapon and tabard is its own learn-on-use token; ordinary gear and profession patterns from the timeline are excluded.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Time Rift timeline vendors" },
            },
            timeRiftAzeroth = {
                sourceType = "Time Rift Reward",
                source = "Gill the Drill / A.Z.E.R.O.T.H. timeline",
                acquisition = "Defeat the final boss when the titan-machine A.Z.E.R.O.T.H. timeline opens, or buy its seven mechanical weapon tokens from Gill the Drill with Paracausal Flakes.",
                tips = "Check the portal name before entering and loot the boss even if you already completed the weekly quest. Save flakes for missing pieces because boss drops can duplicate owned appearances.",
                cost = "Generally 1,000-1,050 Paracausal Flakes each.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Gill the Drill / timeline vendors" },
            },
            timeRiftAzewrath = {
                sourceType = "Time Rift Reward",
                source = "Falara Nightsong / Azewrath timeline",
                acquisition = "Defeat the final boss in the Legion-victory Azewrath timeline, or buy its seven fel-themed weapon tokens from Falara Nightsong with Paracausal Flakes.",
                tips = "Run every hourly Rift you can while this group is incomplete; the portal timeline is random. Compare collection status before buying visually similar fel weapons.",
                cost = "Generally 1,000-1,050 Paracausal Flakes each.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Falara Nightsong / timeline vendors" },
            },
            timeRiftAzqroth = {
                sourceType = "Time Rift Reward",
                source = "Provisioner Qorra / Azq'roth timeline",
                acquisition = "Defeat the final boss in the Black Empire Azq'roth timeline, or buy its seven void/fire-themed tokens from Provisioner Qorra with Paracausal Flakes.",
                tips = "Pauldrons of the Fire Lord cost more than a basic one-handed token, so leave a flake buffer. The shoulders are a cosmetic consumable, not the similarly named Firelands armor model.",
                cost = "Generally 1,000-1,100 Paracausal Flakes each.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Provisioner Qorra / timeline vendors" },
            },
            timeRiftUlderoth = {
                sourceType = "Time Rift Reward",
                source = "Sorotis / Ulderoth timeline",
                acquisition = "Defeat the final boss in the titan-utopia Ulderoth timeline, or buy its weapons, tabard, and four armor ensembles from Sorotis with Paracausal Flakes.",
                tips = "The four ensembles each teach a complete armor-type family and cost substantially more than a weapon. Buy only the wrapper for the armor type you want; its component tokens are not separate collectibles.",
                cost = "Weapons about 1,000-1,050 flakes, Utopian Tabard 1,500, and each ensemble 2,500.",
                researchNotes = "The ensemble wrappers replace internal Decorous, Lifegiver, Hauberk, and Valhalas components in this catalog.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Sorotis / timeline vendors" },
            },
            timeRiftWarlands = {
                sourceType = "Time Rift Reward",
                source = "Warden Krizzik / Warlands timeline",
                acquisition = "Defeat the final boss in the faction-war Warlands timeline or buy the Warmonger and Jingoist armor tokens and two weapons from Warden Krizzik with Paracausal Flakes.",
                tips = "One faction's learned armor appearance also unlocks its opposite-faction counterpart. Head, chest, and legs are sold directly; paired waist/feet, hands/wrists, and shoulder/cloak pieces are delivered through slot bags. Use characters of all four armor types to expose and learn the whole matrix.",
                cost = "Direct major pieces are typically 1,050 flakes; paired slot bags are typically 1,150 flakes.",
                researchNotes = "All 72 armor component tokens plus the two faction weapons are retained because they have independent item and learned states. The non-cosmetic container bags themselves are excluded.",
                waypoints = { "/way #2025 51.1 57.1 Time Rift start / Soridormi", "/way #2025 51.0 56.0 Warden Krizzik / timeline vendors" },
            },
            eonsFringeHammers = {
                sourceType = "Quest Unlock Vendor",
                source = "Ironus Coldsteel / Eon's Fringe",
                acquisition = "Complete The Chronosmith questline from Temporal Investigator Tempo, then buy each of Ironus Coldsteel's three hammer appearance tokens for 600 Dragon Isles Supplies.",
                tips = "The vendor stock is phased behind the full Chronosmith chain. If Ironus is present but the hammers are missing, finish every follow-up in his story before checking again.",
                requirements = "Complete The Chronosmith storyline.",
                cost = "600 Dragon Isles Supplies each.",
                waypoints = { "/way #2025 55.2 82.6 Temporal Investigator Tempo / Eon's Fringe", "/way #2025 52.5 81.5 Everywhen Inn / Ironus Coldsteel" },
            },
            gildedSunglasses = {
                sourceType = "Questline Reward",
                source = "Melly Teletone / Eon's Fringe",
                acquisition = "Complete Melly Teletone's Eon's Fringe story through Feats Per Minute to receive the Gilded Sunglasses cosmetic token.",
                tips = "This is a multi-step side story, not a random Time Rift drop. Start near the Everywhen Inn and clear the local story markers if Melly's next quest is not immediately visible.",
                requirements = "Complete Feats Per Minute.",
                waypoints = { "/way #2025 54.9 81.6 Melly Teletone / Eon's Fringe" },
            },
            riftMenderVestments = {
                sourceType = "Reputation Quest Reward",
                source = "Soridormi / Tyrhold Reservoir",
                acquisition = "Raise Soridormi reputation to rank 3, Rift-Mender, then complete A Recognition of Skill to receive the ensemble.",
                tips = "Farm reputation through repeated Time Rifts and complete the weekly quest. The reward wrapper teaches its tabard, cape, and shoulder appearances together.",
                requirements = "Soridormi reputation rank 3: Rift-Mender.",
                researchNotes = "The three internal appearance items are omitted because the ensemble teaches them in one use.",
                waypoints = { "/way #2025 51.1 57.1 Soridormi / Time Rift reservoir" },
            },
            infiniteAcolyte = {
                sourceType = "Dungeon Achievement Reward",
                source = "Put That Thing Back Where It Came From / Dawn of the Infinite",
                acquisition = "In one full Mythic Dawn of the Infinite run, have four different players carry the temporal artifacts found after bosses 2, 5, 6, and 7, restore them at Deios's portals, and complete the run without any carrier dying.",
                tips = "Assign one artifact to each player before the run and keep carriers alive; a death invalidates that carrier's object. Do not leave the dungeon between wings. The achievement mails or grants one ensemble that teaches all four armor-type sets.",
                requirements = "Complete achievement 18706, Put That Thing Back Where It Came From.",
                researchNotes = "The achievement ensemble is stable and deterministic. Random Quantum transformation tokens from the dungeon are excluded from this category.",
                waypoints = { "/way #2025 61.5 84.6 Dawn of the Infinite entrance" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.1.7"] = {
        label = "Patch 10.1.7: Fury Incarnate",
        wowheadPatchId = 100107,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only permanent learn-on-use appearance items and ensemble wrappers are included. Ordinary equippable gear and direct collection grants are excluded.",
            "The Cosmetics audit excludes Trading Post, Timewalking, crossover, and limited calendar-event rewards; the mounts audit retains Sandy Shalewing as a patch-native Timewalking reward.",
            "Secrets of Azeroth launched as a scheduled mystery but all included rewards remain permanently obtainable; the two Trading Post tweed caps are excluded.",
            "Heritage, Temporal Burdens, Tyr's Titan Key, and Engineering ensembles are represented by wrapper only, not by the appearances each wrapper teaches.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/23987385",
            overview = "https://www.wowhead.com/guide/dragonflight-patch-10-1-7-fury-incarnate-overview",
            nightElf = "https://www.wowhead.com/guide/transmogrification/night-elf-heritage-armor",
            forsaken = "https://www.wowhead.com/guide/transmogrification/forsaken-heritage-armor",
            manari = "https://www.wowhead.com/news/new-eredar-transmogs-available-manari-eredar-questline-335033",
            secrets = "https://www.wowhead.com/guide/world-events/secrets-of-azeroth",
            tyrGuard = "https://www.wowhead.com/guide/lore/dragonflight-reforging-tyrs-guard-storyline",
            holoGogs = "https://www.wowhead.com/achievement=18901/chromatic-calibration-holo-gogs",
        },
        mounts = {
            { spellId = 374278, name = "Renewed Magmammoth" },
            { spellId = 385262, name = "Duskwing Ohuna" },
            { spellId = 408654, name = "Sandy Shalewing" },
            { spellId = 424082, name = "Mimiron's Jumpjets" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_1_7_COSMETICS,
        cosmeticDetailGroups = {
            nightElfHeritage = {
                sourceType = "Heritage Questline",
                source = "The Clarion Call / Stormwind Embassy",
                acquisition = "On a level-50 or higher Night Elf, begin The Clarion Call from the scroll at Stormwind Embassy and complete the heritage story through the final ceremony.",
                tips = "Both the armor ensemble and Traditionalist's Kaldorei Blades are consumable rewards. Use the blade wrapper once to learn all three glaive appearances; do not search separately for its internal Duskrune, Blood Moon, and Moonlight tokens.",
                requirements = "Level 50+ Night Elf character.",
                researchNotes = "The two wrappers are tracked independently because the armor and weapon family have separate learned states.",
                waypoints = { "/way #84 52.4 14.2 Stormwind Embassy / Clarion Call scroll" },
            },
            forsakenHeritage = {
                sourceType = "Heritage Questline",
                source = "Lilian Voss / Ruins of Lordaeron",
                acquisition = "On a level-50 or higher Forsaken who has completed Return to Lordaeron, take Unliving Summons from Lilian Voss and finish the 15-step heritage chain through I Am Forsaken.",
                tips = "The finale awards the armor ensemble and both tabard tokens. If Lilian does not offer the chain, complete Return to Lordaeron first and ensure the character is a standard Forsaken rather than another undead-form race.",
                requirements = "Level 50+ Forsaken; complete Return to Lordaeron.",
                researchNotes = "The ensemble's armor components are excluded, while both tabards remain separate rows because each is a separately consumed appearance item.",
                waypoints = { "/way #18 63.0 68.0 Lilian Voss / Ruins of Lordaeron" },
            },
            manariArtifacts = {
                sourceType = "Quest-unlocked Vendor",
                source = "Gaal / Destiny Point, Krokuun",
                acquisition = "Complete Seeing Red and the follow-up Scavenged Artifacts, then trade Legion-era Argus materials to Gaal for the eight eredar weapon appearance tokens.",
                tips = "Stockpile Veiled Argunite before traveling: every item costs 90 in addition to Empyrium, Astral Glory, Lightweave Cloth, leather, Argulite, Labradorite, or Florid Malachite. The per-item material recipe is preserved on each collection row.",
                requirements = "Complete Seeing Red and Scavenged Artifacts.",
                researchNotes = "These are permanent quest-unlocked cosmetics. They are not Trading Post stock even though their acquisition is through a vendor.",
                waypoints = { "/way #830 56.8 68.6 Gaal / Destiny Point" },
            },
            temporalBurdens = {
                sourceType = "Questline Reward",
                source = "No Limits / Bronze reconciliation story",
                acquisition = "Complete the Bronze and Infinite dragonflight reconciliation storyline beginning with No Limits and ending with Infinity and Beyond to receive the ensemble.",
                tips = "Check Chromie at the Temporal Conflux if the Valdrakken breadcrumb is missing. The ensemble teaches both Morchie's Timeworn and Chromie's Timespun shoulder appearances.",
                requirements = "Complete the No Limits storyline through Infinity and Beyond.",
                researchNotes = "The two shoulder tokens taught by the wrapper are deliberately not duplicated.",
                waypoints = { "/way #2025 65.4 80.2 Temporal Conflux / Chromie" },
            },
            secretsCaps = {
                sourceType = "Permanent Secret Achievements",
                source = "Secrets of Azeroth investigation and Community Rumors",
                acquisition = "Complete the Secrets of Azeroth investigation chain for The Inquisitive and find five buried satchels for Community Rumors to earn the Brown and Blue Tweed Cap tokens.",
                tips = "The original daily rollout has ended, so clues can now be worked through without waiting for the launch schedule. Begin with Preservationist Kathos and Bobby Carlisle in the Roasted Ram; use the community-rumor satchel clues for the blue cap.",
                requirements = "The Inquisitive for Brown; five buried satchels/Community Rumors for Blue.",
                availability = "Permanently obtainable after the original Secrets of Azeroth rollout.",
                researchNotes = "Yellow and Burgundy Tweed Caps are excluded because they were Trading Post rewards.",
                waypoints = { "/way #2112 46.5 46.3 Roasted Ram / Secrets of Azeroth clues" },
            },
            tyrsTitanKey = {
                sourceType = "Secrets of Azeroth Quest Reward",
                source = "A Key to Reforg(ing) / Valdrakken and The Waking Shores",
                acquisition = "Follow the Titan Key clue from Bobby Carlisle, collect Rose Gold Dust and Igneous Flux in the Waking Shores, use the Earth-Warder's Forge, and finish A Key to Reforg(ing).",
                tips = "Pin the two ingredients before leaving Valdrakken. Rose Gold Dust is near 48.3, 46.1; Igneous Flux is far southwest near 21.3, 76.7. Bring both to the forge at 24.5, 60.8. The key wrapper teaches all four weapon variants.",
                researchNotes = "The four internal Tyr's Titan Key appearance records are excluded because item 208831 teaches them together.",
                waypoints = {
                    "/way #2112 46.5 46.3 Bobby Carlisle / Roasted Ram",
                    "/way #2022 48.3 46.1 Rose Gold Dust",
                    "/way #2022 21.3 76.7 Igneous Flux",
                    "/way #2022 24.5 60.8 Earth-Warder's Forge",
                },
            },
            chromaticCalibration = {
                sourceType = "Profession Achievement Rewards",
                source = "Chromatic Calibration Engineering achievements",
                acquisition = "Craft every goggle named by the matching account-wide Chromatic Calibration achievement. Completing it awards or mails the corresponding ensemble wrapper.",
                tips = "Use an Engineer and check achievement progress before crafting duplicates. Bio-Optic and Retinal recipes are trainer-driven; Cranial Cannons require the Legion Engineering chain and Skullblaster recipe container; Ectoplasmic recipes come from Machinist Au'gur at Shadowlands Engineering 85. Holo-Gogs is the longest list and includes rare or specialization recipes.",
                requirements = "Achievements 18901, 18908, 18905, 18906, and 18907, one per ensemble.",
                researchNotes = "Holo-Gogs needs 34 Outland/Northrend crafts, Bio-Optic 7 Cataclysm crafts, Retinal 7 Pandaria crafts, Cranial Cannons 12 Legion crafts, and Ectoplasmic Specs 4 Shadowlands crafts. The ensembles may arrive by mail. The Holo-Gogs Hyper-Vision schematic is bind-on-pickup from Mo'arg Weaponsmiths, so farm it on the Engineer.",
                waypoints = {
                    "/way #104 22.2 35.4 Mo'arg Weaponsmiths / Hyper-Vision schematic",
                    "/way #376 16.1 83.1 Sally Fizzlefury / Pandaria Engineering",
                    "/way #1670 38.1 44.7 Machinist Au'gur / Shadowlands Engineering",
                },
            },
            tyrsGuardBulwark = {
                sourceType = "Questline Reward",
                source = "Walking the Path of Tyr / Reforging the Tyr's Guard",
                acquisition = "Progress the Reforging the Tyr's Guard storyline to Walking the Path of Tyr, equip the four recruits, and turn in the quest for the shield appearance token.",
                tips = "Stand close to each recruit when distributing gear; the quest can credit the nearest recruit rather than the one selected. The token is warbound, so mail it to a shield-using character if the looting character cannot learn shield appearances.",
                requirements = "Complete Walking the Path of Tyr (quest 76171).",
                researchNotes = "This is the use-to-learn shield token from the 10.1.7 chapter, not the later Tabard of the Tyr's Guard from patch 10.2.",
                waypoints = { "/way #2025 60.0 58.7 Tyr's Rest / Tyr's Guard storyline" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.2"] = {
        label = "Patch 10.2: Guardians of the Dream",
        wowheadPatchId = 100200,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only consumable appearance unlocks, ensembles, and arsenals are included. Ordinary equippable gear and appearances granted directly without an item are excluded.",
            "Trading Post, Timewalking, crossover rewards, and limited calendar-event rewards are excluded.",
            "The Dreamseed pool contains 47 separate use-to-learn tokens. The Green Dragon ensemble is represented by its wrapper only, not the three appearances learned from it.",
            "The Drakebreaker and Scalewarden bundles were added as collection-friendly wrappers for Dragonflight Season 1 War Mode appearances; vendor stock and alternate Mark of Honor pricing have moved over time.",
        },
        sourceUrls = {
            official = "https://news.blizzard.com/en-us/article/24020034/dragonflight-guardians-of-the-dream-content-update-notes",
            emeraldDream = "https://www.wowhead.com/guide/emerald-dream",
            dreamWardens = "https://www.wowhead.com/guide/reputation/dream-wardens-renown-rewards",
            treasures = "https://www.wowhead.com/news/new-transmog-recolors-from-emerald-dream-treasures-emerald-dream-zone-guide-336008",
            aurostor = "https://www.wowhead.com/item=210433/visage-of-aurostor",
            tyr = "https://www.wowhead.com/news/tabard-of-the-tyrs-guard-quest-now-live-with-weekly-reset-336404",
        },
        mounts = {
            { spellId = 422486, name = "Verdant Armoredon" },
            { spellId = 423871, name = "Blossoming Dreamstag" },
            { spellId = 423873, name = "Suntouched Dreamstag" },
            { spellId = 423877, name = "Rekindled Dreamstag" },
            { spellId = 423891, name = "Lunar Dreamstag" },
            { spellId = 424474, name = "Shadow Dusk Dreamsaber" },
            { spellId = 424476, name = "Winter Night Dreamsaber" },
            { spellId = 424479, name = "Evening Sun Dreamsaber" },
            { spellId = 424482, name = "Morning Flourish Dreamsaber" },
            { spellId = 424484, name = "Anu'relos, Flame's Guidance" },
            { spellId = 424534, name = "Vicious Moonbeast" },
            { spellId = 424535, name = "Vicious Moonbeast" },
            { spellId = 425338, name = "Flourishing Whimsydrake" },
            { spellId = 425416, name = "Verdant Gladiator's Slitherdrake" },
            { spellId = 426955, name = "Springtide Dreamtalon" },
            { spellId = 427041, name = "Ochre Dreamtalon" },
            { spellId = 427043, name = "Snowfluff Dreamtalon" },
            { spellId = 427222, name = "Delugen" },
            { spellId = 427224, name = "Talont" },
            { spellId = 427226, name = "Stargrazer" },
            { spellId = 427546, name = "Mammyth" },
            { spellId = 427549, name = "Imagiwing" },
            { spellId = 427724, name = "Salatrancer" },
            { spellId = 428060, name = "Golden Regal Scarab" },
            { spellId = 431049, name = "Grotto Netherwing Drake" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_2_COSMETICS,
        cosmeticDetailGroups = {
            tyrsGuard = {
                sourceType = "Quest Reward",
                source = "Logotyrapy / Tyr's Rest, Tyrhold",
                acquisition = "Finish the Tyr questline through Logotyrapy. After the next weekly reset, read Valunei's mailed invitation or the Sealed Letter at Tyr's Guard headquarters, then complete the short conversation to receive the tabard token.",
                tips = "If the mail has not arrived, confirm Logotyrapy is complete and that a weekly reset has passed. The letter on the headquarters table is the usual fallback for lost or deleted mail.",
                requirements = "Complete the Tyr questline and wait for the following weekly reset.",
                researchNotes = "The tabard is a consumable appearance item. It is not the directly equipped tabard with a similar presentation in the quest UI.",
                waypoints = { "/way #2025 60.0 58.7 Tyr's Rest / Sealed Letter" },
            },
            raimentOfAmirdrassil = {
                sourceType = "Quest Reward",
                source = "Tyrande Whisperwind / Central Encampment",
                acquisition = "On a Night Elf, finish the Guardians of the Dream campaign and its New Beginnings epilogue, then complete A Personal Offering to receive the ensemble.",
                tips = "The offer is race-restricted and may not appear until the campaign epilogue is complete. Check Tyrande at the Central Encampment after finishing the Amirdrassil story.",
                requirements = "Night Elf character; complete the Emerald Dream campaign and New Beginnings.",
                researchNotes = "The ensemble wrapper is tracked once; its internal armor appearances are deliberately not duplicated.",
                waypoints = { "/way #2200 50.8 61.5 Tyrande Whisperwind / Central Encampment" },
            },
            emeraldBounties = {
                sourceType = "Dreamseed Reward",
                source = "Emerald Bounties and Talisa Whisperbloom / Central Encampment",
                acquisition = "Plant Dreamseeds and contribute Dewdrops to Emerald Bounties, then loot the bloom cache for a chance at one of the 47 appearance tokens. Missing pieces can also be bought from Talisa Whisperbloom for one Seedbloom each.",
                tips = "Participate in active seed plots while moving around the zone and always return for the cache. Seedbloom is limited by weekly activities, so check collection status before buying duplicates and prioritize the weapon or armor tint you want most.",
                cost = "1 Seedbloom each from Talisa Whisperbloom, or a chance from Emerald Bounty caches.",
                researchNotes = "The pool is four nine-piece armor families plus eleven weapons. Every row is a separate purple-arrow consumable, not equippable gear.",
                waypoints = { "/way #2200 49.8 62.1 Talisa Whisperbloom / Central Encampment" },
            },
            emeraldDreamTreasures = {
                sourceType = "Treasure and Exploration",
                source = "Emerald Dream spirit-statue puzzles and Treasures of the Emerald Dream",
                acquisition = "For each spirit treasure, touch the matching Mark to gain a one-minute guardian buff and reach its statue before the buff expires. Forest Lord's Antlers is the meta reward for finding all ten treasures required by Treasures of the Emerald Dream.",
                tips = "Use a fast ground mount and set both the Mark and statue pins before starting. Ursol uses the Bear Mark; Aviana the Winged Mark; Lo'Gosh the Wolf Mark. Ashamane is inside the Barrows of Reverie—enter through the Emerald Dream cave, then use the interior pins. Druids and matching races/forms can bypass some Mark runs as described on the item.",
                requirements = "Spirit pieces require the matching guardian buff or eligible form/race interaction; antlers require the ten-treasure achievement.",
                researchNotes = "Exact Mark-to-statue routes are retained because the one-minute buff is the meaningful collection constraint.",
                waypoints = {
                    "/way #2200 48.0 52.5 Mark of Ursol",
                    "/way #2200 47.1 53.1 Statue of the Bear Lord",
                    "/way #2200 59.9 19.0 Mark of Aviana",
                    "/way #2200 64.2 19.2 Statue of the Sky Mistress",
                    "/way #2200 34.5 82.7 Mark of Goldrinn",
                    "/way #2200 33.0 83.2 Statue of the Great Wolf",
                    "/way #2200 33.1 82.4 Goldrinn route cave entrance",
                    "/way #2200 63.5 71.6 Barrows of Reverie entrance",
                    "/way #2254 39.0 66.6 Mark of Ashamane",
                    "/way #2254 62.9 35.1 Statue of the Ashen Panther",
                },
            },
            aurostor = {
                sourceType = "World Boss Drop",
                source = "Aurostor the Hibernator / Emerald Dream",
                acquisition = "Defeat Aurostor when he is the active Emerald Dream world boss and loot the weekly reward for a chance at the appearance token.",
                tips = "Aurostor rotates with the other Dragonflight world bosses. Use the group finder shortly after weekly reset and remember that the character's loot chance is weekly, not per kill.",
                availability = "Available only during Aurostor's world-boss rotation.",
                researchNotes = "This records the learn-on-use Visage token, not Aurostor's ordinary armor drops.",
                waypoints = { "/way #2200 40.0 54.6 Aurostor the Hibernator" },
            },
            verdantEliteWeapons = {
                sourceType = "Legacy Elite PvP Vendor",
                source = "Glamora / Gladiator's Refuge, Valdrakken",
                acquisition = "After earning the Dragonflight Season 3 Elite weapon entitlement, buy each Verdant Gladiator appearance token from Glamora for five Marks of Honor.",
                tips = "The entitlement was earned at 2,400 rating during Dragonflight Season 3. The vendor can show the tokens on eligible characters/accounts, but the historical Elite requirement is not earnable after the season.",
                requirements = "Dragonflight Season 3 Elite weapon appearance entitlement (originally 2,400 rating).",
                cost = "5 Marks of Honor each.",
                availability = "Legacy purchase for accounts that earned the Season 3 Elite entitlement.",
                researchNotes = "These are the 19 consumable Verdant weapon appearance tokens, not equippable PvP weapons.",
                waypoints = { "/way #2112 45.4 38.4 Glamora / Gladiator's Refuge" },
            },
            wolfAncient = {
                sourceType = "Treasure",
                source = "Cowl of the Wolf Ancient / Emerald Dream cave",
                acquisition = "On an Orc or Mag'har Orc, enter the cave in the southwest Emerald Dream and loot the cowl treasure.",
                tips = "The treasure is race-gated rather than a random drop. If it cannot be interacted with, retry on an eligible Orc-family character after completing the zone introduction.",
                requirements = "Orc or Mag'har Orc character.",
                waypoints = { "/way #2200 33.0 81.0 Cowl of the Wolf Ancient cave" },
            },
            superbloom = {
                sourceType = "Superbloom Drop",
                source = "Veritistrasz's Superbloom finale / Emerald Dream",
                acquisition = "Join the hourly Superbloom escort from Sprucecrown near the Central Encampment, fill activity stages, and defeat the final boss Verlann Timbercrush for a chance at the five appearance tokens.",
                tips = "The event starts near the top of each hour. Join early for more activity credit, follow Sprucecrown west, and complete the weekly Superbloom quest at the same time. The tokens are chance drops, so expect repeat weeks.",
                researchNotes = "Only the five consumable cosmetic tokens from the event are included; equippable Superbloom gear is excluded.",
                waypoints = { "/way #2200 51.4 59.6 Superbloom start / Sprucecrown" },
            },
            dreamWardenTools = {
                sourceType = "Renown Vendor",
                source = "Moon Priestess Lasara / Dream Wardens",
                acquisition = "Reach Dream Wardens Renown 16, then buy each garden-tool appearance token from Moon Priestess Lasara for 300 Dragon Isles Supplies.",
                tips = "Lasara originally stood at the Central Encampment and later moved to Bel'ameth; both pins are retained. These are consumed to teach weapon appearances and are not profession tools.",
                requirements = "Dream Wardens Renown 16.",
                cost = "300 Dragon Isles Supplies each.",
                waypoints = {
                    "/way #2200 50.3 61.6 Moon Priestess Lasara / original location",
                    "/way #2239 46.5 70.6 Moon Priestess Lasara / current location",
                },
            },
            greenDragonOuterwear = {
                sourceType = "Renown Vendor",
                source = "Moon Priestess Lasara / Dream Wardens",
                acquisition = "Reach Dream Wardens Renown 16 and buy the Elegant Green Dragon Outerwear ensemble from Moon Priestess Lasara.",
                tips = "Use the ensemble from the bag to learn all three outerwear appearances. Lasara's original Emerald Dream and later Bel'ameth positions are both mapped.",
                requirements = "Dream Wardens Renown 16.",
                cost = "500 Dragon Isles Supplies.",
                researchNotes = "Only item 210790 is collectible. Its three taught component records are intentionally excluded.",
                waypoints = {
                    "/way #2200 50.3 61.6 Moon Priestess Lasara / original location",
                    "/way #2239 46.5 70.6 Moon Priestess Lasara / current location",
                },
            },
            dragonflightWarModeSets = {
                sourceType = "Legacy War Mode Bundles",
                source = "Warkeeper Gresh and Dragonflight PvP quartermasters / Valdrakken",
                acquisition = "Buy the Drakebreaker or Scalewarden ensemble and arsenal wrappers from the legacy Dragonflight War Mode vendors. The wrappers consolidate the Season 1 Bloody Token and upgraded Trophy of Strife appearance families.",
                tips = "Vendor stock and alternate Mark of Honor prices have changed between seasons. Check both Warkeeper Gresh and the nearby legacy PvP vendors; verify collection state before spending because several arsenal names describe one weapon family rather than a single appearance.",
                cost = "Historically 3,000 Bloody Tokens for armor ensembles; weapon arsenals varied by slot, commonly 300, 500, or 800 Bloody Tokens. Later legacy stock may use Marks of Honor.",
                researchNotes = "The bundle items were added in 10.2 as collection wrappers for earlier Season 1 appearances. They are catalogued by wrapper patch, while their underlying visual family is older.",
                waypoints = { "/way #2112 43.1 42.3 Dragonflight War Mode vendors" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.2.5"] = {
        label = "Patch 10.2.5: Seeds of Renewal",
        wowheadPatchId = 100205,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only consumable appearance unlocks are included. Ordinary equippable gear and direct appearance grants are excluded.",
            "Trading Post, Timewalking, crossover, and calendar-event rewards are excluded.",
            "The Outland Cup collection, its achievement tabard, the unsourced plain Riders of Azeroth tabard, and all six Love is in the Air roses are deliberately excluded as event rewards.",
            "Bel'ameth treasure coordinates and individual archive acquisition notes are retained even where the UI currently displays only the shared group summary.",
        },
        sourceUrls = {
            official = "https://news.blizzard.com/en-us/article/24046540/dragonflight-seeds-of-renewal-content-update-notes",
            archives = "https://www.wowhead.com/guide/azerothian-archives-public-event",
            provisioner = "https://warcraft.wiki.gg/wiki/Provisioner_Aristta",
            gilneas = "https://www.wowhead.com/guide/lore/dragonflight-reclamation-gilneas-story-walkthrough",
            belameth = "https://www.wowhead.com/item=213006/night-elven-horn",
            darnassian = "https://warcraft.wiki.gg/wiki/Darnassian_Moonsilver_Spaulders",
        },
        mounts = {
            { spellId = 374204, name = "Explorer's Stonehide Packbeast" },
            { spellId = 430225, name = "Gilnean Prowler" },
            { spellId = 432610, name = "Clayscale Hornstrider" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_2_5_COSMETICS,
        cosmeticDetailGroups = {
            azerothianArchives = {
                sourceType = "Azerothian Archives",
                source = "Big Dig, archive tomes, and Provisioner Aristta / Traitor's Rest",
                acquisition = "Complete To the Archives! and the introductory dig tutorial, then earn Mysterious Fragments from Big Dig public events, archive world quests, tome turn-ins, and the weekly quest. Buy the listed stock from Provisioner Aristta; the remaining tokens come from Big Dig reward bags, tome milestones, or the event boss.",
                tips = "Big Dig begins at half past the hour and runs for roughly ten minutes. The weekly A History of Dragon Isles awards a large fragment payout once per account; world quests and tome discoveries fill the gap. Several pieces are drops rather than vendor stock, so continue opening event rewards after buying the priced items.",
                requirements = "Complete the Azerothian Archives introduction to unlock the event, tome turn-ins, and Provisioner Aristta.",
                researchNotes = "The 30 records mix fixed-price purchases with random or milestone rewards. A cost is attached only where the vendor price was independently confirmed; blank-cost entries should not be assumed to be vendor purchases.",
                waypoints = { "/way #2025 61.4 31.4 Azerothian Archives / Provisioner Aristta" },
            },
            gilneasReclamation = {
                sourceType = "Questline Reward",
                source = "Reclaiming Gilneas / Beginning a New Dawn",
                acquisition = "At level 70, complete the Reclaiming Gilneas storyline through Beginning a New Dawn. The finale awards the six Gilnean Noble cosmetic tokens.",
                tips = "Alliance characters can begin from Greyguard Elite near the Valdrakken fountain and continue with Genn Greymane at Stormwind Harbor. Horde characters are directed from Orgrimmar; the Adventure Guide can also surface the start. Finish the whole scenario before checking the bag for every component.",
                requirements = "Level 70 character.",
                researchNotes = "Contemporary guides often describe one outfit reward, but the live data contains six separate use-to-learn component items; all six are tracked because each can have its own learned state.",
                waypoints = {
                    "/way #2112 59.2 42.7 Greyguard Elite / Alliance breadcrumb",
                    "/way #85 52.2 88.5 Deathguard Elite / Horde breadcrumb",
                },
            },
            belamethQuest = {
                sourceType = "Quest Reward",
                source = "A Place Beneath the Boughs / Bel'ameth",
                acquisition = "Unlock Bel'ameth through the post-Amirdrassil story and complete A Place Beneath the Boughs and its follow-up conversation to receive the Violet Kaldorei Bedroll and Backpack tokens.",
                tips = "Complete New Beginnings first if the Bel'ameth quest is missing. The two violet tokens are quest rewards; the blue variants and field props are separate one-time treasures mapped below.",
                requirements = "Complete the Amirdrassil epilogue and Bel'ameth introduction.",
                waypoints = { "/way #2239 48.2 76.4 Bel'ameth quest hub" },
            },
            belamethTreasures = {
                sourceType = "One-time Treasures",
                source = "Bel'ameth and Amirdrassil",
                acquisition = "After unlocking Bel'ameth, find the eleven small Kaldorei objects placed on the ground, tables, racks, and structures around the settlement and northern Amirdrassil. Each object grants its matching consumable appearance token.",
                tips = "Use the pins one at a time and inspect surfaces closely; several objects blend into the scenery. If an object is absent, finish the Bel'ameth introduction or change phase, then return. The northern spyglass and western Moon Bow are much farther from the central cluster.",
                researchNotes = "All eleven coordinates are retained individually for the map window, including the remote Spyglass and Moon Bow locations. Item 213160 was originally named Night Elven Bow in the 10.2.5 client and is now displayed as Kaldorei Moon Bow.",
                waypoints = {
                    "/way #2239 54.69 77.20 Blue Kaldorei Bedroll",
                    "/way #2239 52.54 17.72 Blue Kaldorei Backpack",
                    "/way #2239 58.43 51.87 Night Elven Horn",
                    "/way #2239 49.14 70.33 Night Elven Signal",
                    "/way #2239 31.30 16.12 Kaldorei Bow Carver",
                    "/way #2239 48.28 76.40 Violet Kaldorei Pouch",
                    "/way #2239 55.30 64.31 Blue Kaldorei Pouch",
                    "/way #2239 47.88 56.85 Night Elven Shield",
                    "/way #2239 53.46 55.73 Night Elven Spear",
                    "/way #2239 51.89 5.89 Kaldorei Sentinel's Spyglass",
                    "/way #2239 29.04 28.83 Kaldorei Moon Bow",
                },
            },
            darnassianCosmetics = {
                sourceType = "Faction Cosmetic Vendor",
                source = "Moon Priestess Lasara / Bel'ameth",
                acquisition = "On an Alliance character, buy the Darnassian Moonsilver Spaulders and Darnassian Cloak appearance tokens from Moon Priestess Lasara.",
                tips = "Lasara moved from the Emerald Dream Central Encampment to Bel'ameth. If her stock is unavailable, finish the Bel'ameth introduction and revisit on an Alliance character.",
                requirements = "Alliance character with Bel'ameth unlocked.",
                cost = "250 Dragon Isles Supplies each.",
                researchNotes = "These are normal permanent faction-vendor cosmetics, not Trading Post inventory.",
                waypoints = { "/way #2239 46.5 70.6 Moon Priestess Lasara" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.2.6"] = {
        label = "Patch 10.2.6: Plunderstorm / Dragonflight Season 4",
        wowheadPatchId = 100206,
        sourceNotes = {
            "This mounts-only audit covers permanent, seasonal, Timewalking, and original Plunderstorm rewards introduced with patch 10.2.6.",
            "Calendar holidays, Trading Post, shop, promotional, crossover, hidden, and unavailable records are excluded.",
            "Pets, toys, and achievements are audited. Cosmetics has no eligible learn-on-use rows because Plunderstorm appearances are granted directly to the wardrobe.",
        },
        sourceUrls = {
            plunderstorm = "https://worldofwarcraft.blizzard.com/en-us/news/24057476",
            seasonFour = "https://worldofwarcraft.blizzard.com/en-us/news/24066682",
            overview = "https://warcraft.wiki.gg/wiki/Patch_10.2.6",
        },
        mounts = {
            { spellId = 351408, name = "Bestowed Thunderspine Packleader" },
            { spellId = 373967, name = "Stormtouched Bruffalon" },
            { spellId = 374071, name = "Bestowed Sandskimmer" },
            { spellId = 374097, name = "Coralscale Salamanther" },
            { spellId = 374172, name = "Bestowed Trawling Mammoth" },
            { spellId = 376898, name = "Bestowed Ottuk Vanguard" },
            { spellId = 385260, name = "Bestowed Ohuna Spotter" },
            { spellId = 408648, name = "Calescent Shalewing" },
            { spellId = 424539, name = "Draconic Gladiator's Drake" },
            { spellId = 424607, name = "Taivan" },
            { spellId = 434462, name = "Infinite Armoredon" },
            { spellId = 434470, name = "Vicious Dreamtalon" },
            { spellId = 434477, name = "Vicious Dreamtalon" },
            { spellId = 439138, name = "Voyaging Wilderling" },
            { spellId = 440444, name = "Zovaal's Soul Eater" },
            { spellId = 254812, name = "Royal Seafeather" },
            { spellId = 300154, name = "Silver Tidestallion" },
            { spellId = 437162, name = "Polly Roger" },
        },
        pets = {},
        toys = {},
        cosmetics = {},
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["10.2.7"] = {
        label = "Patch 10.2.7: Dark Heart",
        wowheadPatchId = 100207,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only permanent consumable appearance unlocks and heritage ensembles are included. Ordinary equippable gear and direct appearance grants are excluded.",
            "Trading Post, unrelated Timewalking, crossover, and calendar-holiday rewards are excluded.",
            "Pandaria Remix mounts are included as core 10.2.7 content; Midsummer and the Trading Post class recolor bundles remain excluded. The Exodar Peacekeeper arsenal is also excluded because it appeared on PTR but never became obtainable on live realms.",
            "Darkspear masks and Draenei armor components are learned by their heritage ensemble wrappers and are not duplicated as independent collectibles.",
        },
        sourceUrls = {
            official = "https://news.blizzard.com/en-us/article/24066682/dragonflight-dark-heart-content-update-notes",
            overview = "https://www.wowhead.com/guide/dragonflight-10-2-7-patch-overview",
            harbinger = "https://www.wowhead.com/news/voidtouched-weapon-appearances-from-hunt-the-harbinger-questline-339266",
            draenei = "https://www.wowhead.com/guide/transmogrification/draenei-heritage-armor",
            darkspear = "https://www.wowhead.com/guide/transmogrification/troll-heritage-armor",
            exodarPtrOnly = "https://warcraft.wiki.gg/wiki/Arsenal%3A_Exodar_Peacekeeper%27s_Armaments",
            cobaltCloak = "https://www.wowhead.com/item=217891/cobalt-guardians-cloak",
        },
        mounts = {
            { spellId = 127178, name = "Jungle Riding Crane" },
            { spellId = 435044, name = "Golden Discus" },
            { spellId = 435082, name = "Mogu Hazeblazer" },
            { spellId = 435084, name = "Sky Surfer" },
            { spellId = 435108, name = "Daystorm Windsteed" },
            { spellId = 435107, name = "Forest Windsteed" },
            { spellId = 435103, name = "Dashing Windsteed" },
            { spellId = 435109, name = "Feathered Windsurfer" },
            { spellId = 435115, name = "Guardian Quilen" },
            { spellId = 435118, name = "Marble Quilen" },
            { spellId = 435123, name = "Gilded Riding Crane" },
            { spellId = 435128, name = "Pale Riding Crane" },
            { spellId = 435127, name = "Rose Riding Crane" },
            { spellId = 435126, name = "Silver Riding Crane" },
            { spellId = 435124, name = "Luxurious Riding Crane" },
            { spellId = 435125, name = "Tropical Riding Crane" },
            { spellId = 435131, name = "Snowy Riding Goat" },
            { spellId = 435133, name = "Little Red Riding Goat" },
            { spellId = 435145, name = "Bloody Skyscreamer" },
            { spellId = 435146, name = "Night Pterrorwing" },
            { spellId = 435147, name = "Jade Pterrordax" },
            { spellId = 435149, name = "Cobalt Juggernaut" },
            { spellId = 435150, name = "Fel Iron Juggernaut" },
            { spellId = 435153, name = "Purple Shado-Pan Riding Tiger" },
            { spellId = 435160, name = "Riverwalker Mushan" },
            { spellId = 435161, name = "Palehide Mushan Beast" },
            { spellId = 441794, name = "Amber Pterrordax" },
            { spellId = 446017, name = "August Phoenix" },
            { spellId = 446022, name = "Astral Emperor's Serpent" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_10_2_7_COSMETICS,
        cosmeticDetailGroups = {
            draeneiHeritage = {
                sourceType = "Heritage Questline",
                source = "An Artificer's Appeal / Stormwind Embassy",
                acquisition = "On a level-50 or higher Draenei, accept An Artificer's Appeal from the Magically-Sealed Parcel at the Stormwind Embassy or through the Adventure Guide, then complete the Draenei heritage storyline.",
                tips = "The chain returns to Draenor and Argus-related locations, so allow travel time. If the parcel is missing, confirm the character is a standard Draenei—not Lightforged—and meets the level requirement.",
                requirements = "Level 50+ Draenei character.",
                researchNotes = "Track the ensemble wrapper only; its internal heritage armor records are not separate bag collectibles.",
                waypoints = { "/way #1519 54.5 18.4 Stormwind Embassy / Magically-Sealed Parcel" },
            },
            darkspearHeritage = {
                sourceType = "Heritage Questline",
                source = "Zi'guma / Valley of Spirits, Orgrimmar",
                acquisition = "On a level-50 or higher Darkspear Troll, speak with Zi'guma and complete the Darkspear heritage storyline. The finale grants the heritage ensemble; Loa's Blade-Blessing is a separate use-to-learn weapon token tied to the chain.",
                tips = "The ensemble teaches both armor tints and the associated mask appearances, so do not hunt the mask records separately. At launch the sword was limited to Death Knights, Hunters, and Warriors; a May 16, 2024 hotfix granted it to any eligible Darkspear that completed the chain. Log into the character that completed it if the appearance is still missing.",
                requirements = "Level 50+ Darkspear Troll character.",
                researchNotes = "Internal Darkspear armor and mask tokens—including Kevo ya Siti's Mask of Cunning and Lukou's Mask of Regeneration—are excluded because item 211446 teaches them. The separate Loa sword remains included because it has its own cosmetic item record and collection state.",
                waypoints = { "/way #85 32.7 64.7 Zi'guma / Valley of Spirits" },
            },
            harbingerWeapons = {
                sourceType = "Questline Reward",
                source = "Hunt for the Harbinger / Null and Void",
                acquisition = "Complete the Hunt for the Harbinger campaign through Null and Void. The finale supplies the Bow of the Ranger Captain and the four Voidtouched weapon appearance tokens together.",
                tips = "Start from the Adventure Guide or Khadgar and Alleria in Dalaran. Finish the entire Telogrus Rift sequence before checking collection progress; the five tokens can arrive together and must be used from the bag.",
                requirements = "Complete Hunt for the Harbinger through Null and Void.",
                researchNotes = "All five records are permanent consumable appearance tokens. Nearby quest weapons that equip normally are not included.",
                waypoints = { "/way #627 42.2 64.0 Khadgar / Hunt for the Harbinger start" },
            },
            missingDracthyrPieces = {
                sourceType = "Legacy Faction Vendors",
                source = "Steiz / Cobalt Assembly and Treysh / Forbidden Reach",
                acquisition = "Reach High power with the Cobalt Assembly to buy the Cobalt Guardian's Cloak from Steiz. Buy the Emerald Winglord shoulder and chain tokens from Treysh on the Forbidden Reach for Elemental Overflow.",
                tips = "The cloak uses an Awakened Frost plus supplies, so bring the material before traveling. Treysh stands in the Morqut Village hub; Elemental Overflow is most efficiently gathered from Forbidden Reach rares and elemental events.",
                requirements = "Cobalt Assembly High power for the cloak; Forbidden Reach access for Treysh.",
                researchNotes = "These three use-to-learn items filled gaps in the earlier Dracthyr cosmetic families and were added to live data in 10.2.7.",
                waypoints = {
                    "/way #2024 49.4 22.6 Steiz / Cobalt Assembly",
                    "/way #2151 35.6 59.5 Treysh / Morqut Village",
                },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.0"] = {
        label = "Patch 11.0: The War Within",
        wowheadPatchId = 110000,
        sourceNotes = {
            "The permanent Incognitro secret and legacy Dragonflight PvP Cosmetics are retained; anniversary-event mounts, pets, toys, Cosmetics, and achievements are excluded.",
            "Only disappearing learn-on-use appearance tokens and ensembles are included. Ordinary equippable gear and appearances granted directly by quests or achievements are excluded.",
            "Trading Post, Timewalking, and cross-game/crossover rewards are excluded.",
            "Season 1 Delve armor was sold both for Resonance Crystals and, in the original season, for Undercoin; both launch-era routes are preserved in item details.",
        },
        sourceUrls = {
            official = "https://news.blizzard.com/en-us/article/24130678/the-war-within-content-update-notes",
            osidion = "https://www.wowhead.com/guide/the-war-within/transmog/dornogal-civilian-appearances",
            delves = "https://www.wowhead.com/guide/the-war-within/delves-season-1",
            delveRewards = "https://www.wowhead.com/guide/the-war-within/delves-rewards",
            renown = "https://warcraft.wiki.gg/wiki/The_War_Within_reputation_rewards",
            fishing = "https://www.wowhead.com/guide/the-war-within/professions/the-hallowfall-fishing-derby",
            pvp = "https://www.wowhead.com/guide/the-war-within/pvp/season-1-rewards-gear-mounts",
        },
        mounts = {
            { spellId = 441324, name = "Remembered Golden Gryphon" },
            { spellId = 441325, name = "Remembered Wind Rider" },
            { spellId = 442358, name = "Stonevault Mechsuit" },
            { spellId = 446052, name = "Delver's Dirigible" },
            { spellId = 447057, name = "Smoldering Cinderbee" },
            { spellId = 447405, name = "Vicious Skyflayer" },
            { spellId = 448186, name = "Crowd Pummeler 2-30" },
            { spellId = 448188, name = "Machine Defense Unit 1-11" },
            { spellId = 447176, name = "Cyan Glowmite" },
            { spellId = 447151, name = "Soaring Meaderbee" },
            { spellId = 447160, name = "Raging Cinderbee" },
            { spellId = 448680, name = "Widow's Undercrawler" },
            { spellId = 448685, name = "Heritage Undercrawler" },
            { spellId = 448689, name = "Royal Court Undercrawler" },
            { spellId = 447213, name = "Alunira" },
            { spellId = 447185, name = "Aquamarine Swarmite" },
            { spellId = 447190, name = "Shadowed Swarmite" },
            { spellId = 447195, name = "Swarmite Skyhunter" },
            { spellId = 447957, name = "Ferocious Jawcrawler" },
            { spellId = 448939, name = "Shackled Shadow" },
            { spellId = 448941, name = "Beledar's Spawn" },
            { spellId = 448978, name = "Vermillion Imperial Lynx" },
            { spellId = 448979, name = "Dauntless Imperial Lynx" },
            { spellId = 449264, name = "Wick" },
            { spellId = 449258, name = "Ol' Mole Rufus" },
            { spellId = 449269, name = "Crimson Mudnose" },
            { spellId = 449325, name = "Vicious Skyflayer" },
            { spellId = 449418, name = "Shale Ramolith" },
            { spellId = 449415, name = "Slatestone Ramolith" },
            { spellId = 449466, name = "Forged Gladiator's Fel Bat" },
            { spellId = 451486, name = "Sureki Skyrazor" },
            { spellId = 451489, name = "Siesbarg" },
            { spellId = 451491, name = "Ascendant Skyrazor" },
            { spellId = 452779, name = "Ivory Goliathus" },
            { spellId = 453785, name = "Earthen Ordinant's Ramolith" },
            { spellId = 458335, name = "Diamond Mechsuit" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_0_COSMETICS,
        cosmeticDetailGroups = {
            osidionEnsembles = {
                sourceType = "Ensemble Vendor",
                source = "Osidion / Forgegrounds, Dornogal",
                acquisition = "Buy each civilian ensemble for one Earth-Encrusted Gem or 9,750 Resonance Crystals. Ten gems are available across the four original Khaz Algar Renown tracks, so collecting all 31 still requires crystals.",
                tips = "Plan gem purchases around the colors you want first. Council of Dornogal grants gems at Renown 4, 8, and 20; Assembly of the Deeps at 4, 15, and 20; Hallowfall Arathi at 5 and 20; Severed Threads at 9 and 20. Sandy Quotidian Wear also comes from Lost and Found.",
                requirements = "Reach the listed faction Renown thresholds for free Earth-Encrusted Gems, or farm Resonance Crystals.",
                cost = "1 Earth-Encrusted Gem or 9,750 Resonance Crystals each.",
                researchNotes = "All 31 records are the consumable ensemble items themselves, not their internal chest, head, or accessory appearances.",
                waypoints = { "/way #2339 57.2 60.8 Osidion / Forgegrounds" },
            },
            launchRenownCosmetics = {
                sourceType = "Renown Rewards",
                source = "Original Khaz Algar faction quartermasters",
                acquisition = "Raise the matching faction's Renown, then claim its tabard reward or purchase the unlocked cloak and shoulder appearance tokens from the quartermaster.",
                tips = "The Council, Assembly, and Hallowfall pieces use Resonance Crystals; Severed Threads pieces use Kej. Tabards are Renown rewards rather than normal vendor purchases. If Auralia has moved during her side story, check her second Mereldar position.",
                requirements = "Renown 2-16 depending on faction and slot; see each item.",
                researchNotes = "These are purple-arrow consumable appearances. Stat gear sold by the same quartermasters is deliberately excluded.",
                waypoints = {
                    "/way #2339 39.4 24.6 Auditor Balwurz / Council of Dornogal",
                    "/way #2214 47.3 32.9 Waxmonger Squick / Assembly of the Deeps",
                    "/way #2215 41.2 53.0 Auralia Steelstrike / Hallowfall Arathi",
                    "/way #2215 42.4 55.0 Auralia Steelstrike / alternate position",
                    "/way #2255 55.2 41.2 Lady Vinazian / Severed Threads",
                },
            },
            launchDelveArmor = {
                sourceType = "Delve Vendors",
                source = "Reno Jackson and Sir Finley Mrrgglton / Delver's Headquarters",
                acquisition = "Buy the individual Season 1 Torchbearer, Cave Topographer, Treasure-Seeker, and Secret-Dredger use-to-learn armor tokens. Reno takes Resonance Crystals; Sir Finley's original Season 1 stock used Undercoin.",
                tips = "Undercoin comes from Delve treasure rooms and Zekvir-influenced enemy packs. Chest, head, and legs are the expensive armor slots; wrists, waist, and cloaks are cheapest. Patch 11.1 later added full-set catch-up ensembles, but these individual launch tokens remain catalogued here.",
                costs = { "Chest, head, legs: 3,250 Resonance Crystals or 875 Undercoin", "Feet, hands, shoulders: 2,600 Resonance Crystals or 750 Undercoin", "Waist and wrists: 1,300 Resonance Crystals or 625 Undercoin", "Cloaks: 1,300 Resonance Crystals or 500 Undercoin" },
                researchNotes = "The 36 tokens cover eight pieces for each armor style plus four cosmetic cloaks. Their later ensemble wrappers are separate patch-era catch-up items and are not substituted here.",
                waypoints = {
                    "/way #2339 48.0 43.8 Delver's Headquarters",
                    "/way #2339 47.7 43.8 Reno Jackson and Sir Finley Mrrgglton",
                },
            },
            launchDelveWeapons = {
                sourceType = "Delve Vendor",
                source = "Sir Finley Mrrgglton / Delver's Headquarters",
                acquisition = "Spend Season 1 Undercoin on the individual learn-on-use Delve weapon appearance tokens.",
                tips = "One-hand, off-hand, and shield tokens are cheaper than the 3,000-Undercoin two-hand and ranged weapons. Undercoin was seasonal; later versions of the vendor may show Resonance Crystal or legacy pricing instead.",
                costs = { "Bedrock Breaker: 565 Undercoin", "One-hand, off-hand, and shield tokens: 1,250 Undercoin", "Two-hand and ranged tokens: 3,000 Undercoin" },
                researchNotes = "Hookshoot is the database spelling. These are appearance-token item IDs, not the stat-bearing gear variants with the same models.",
                waypoints = { "/way #2339 47.7 43.8 Sir Finley Mrrgglton / Delver's Headquarters" },
            },
            launchDelveDrops = {
                sourceType = "Delve Treasure",
                source = "Heavy Trunks and other end-of-Delve chests",
                acquisition = "Complete Delves and loot the free end chests for the rare mushroom, diving-helmet, candle-hat, and raptorial-spine cosmetic tokens. Zekvir's red spine comes specifically from Zekvir's Lair.",
                tips = "Community reports confirm the generic hats and the purple/blue spines can drop on low tiers and do not require a Bountiful Coffer key, making quick Tier 1 clears a valid farming route. The drop rate is low, so rotate short Delves rather than spending keys solely for these tokens.",
                requirements = "Zekvir's Raptorial Spine requires access to and a kill in Zekvir's Lair; the remaining random tokens come from normal Delve completion chests.",
                researchNotes = "Brann's Spare Hat is excluded from this launch group because it belongs to the later Underpin season.",
                waypoints = {
                    "/way #2339 48.0 43.8 Delver's Headquarters / choose a short active Delve",
                    "/way #2216 9.8 33.8 Zekvir's Lair entrance",
                },
            },
            hallowfallFishingDerby = {
                sourceType = "Weekly Event Vendor",
                source = "Captain Oathmyt / Hallowfall Fishing Derby",
                acquisition = "On Saturdays, accept the Derby quest from Captain Oathmyt and catch the three requested trophy fish before the one-hour Derby Dasher buff expires. Spend the Warband-transferable marks on the seven consumable appearance rewards.",
                tips = "The quest awards marks and each unique Khaz Algar fish caught while Derby Dasher is active can add another. The one-hour timer continues while logged out and cannot be restarted that week, so prepare lures and a route before accepting. Careless Dasher's Treasure can also provide marks outside the event.",
                availability = "The Derby quest is available for 24 hours every Saturday; its personal fishing buff lasts one real-time hour.",
                costs = { "Cerulean Dredger: 500 marks", "Dasher's Trophy Fish: 250", "Frenzied Hat: 100", "Shield, two backpacks, and Keen-eye 'Noculars: 50 each" },
                researchNotes = "Hallowfall Harvester's Pitchfork is normal equippable gear and is excluded even though it is sold beside these purple-arrow tokens.",
                waypoints = { "/way #2215 44.22 61.59 Captain Oathmyt / Saturdays" },
            },
            forgedEliteWeapons = {
                sourceType = "Historical Elite PvP Vendor",
                source = "Rogurn / Contender's Gate, Dornogal",
                acquisition = "After reaching Duelist in rated PvP during The War Within Season 1, buy the individual learn-on-use Elite Forged Gladiator weapon appearances from Rogurn for Marks of Honor.",
                tips = "These were account-wide cosmetic tokens, so only buy weapon types that remain uncollected. Rogurn is in the right-hand room of Contender's Gate with Maara and Ledonir.",
                requirements = "Earn Duelist (2,100 rating) during The War Within Season 1; level 80.",
                cost = "5 Marks of Honor per weapon token.",
                availability = "Original Season 1 purchase route. Patch 11.1 added an 80-Mark Arsenal: Elite Forged Gladiator's Weapons for eligible players, consolidating the same 17 appearances.",
                researchNotes = "All 17 records are the original purple-arrow consumables. The later 11.1 arsenal is kept in its own patch because it is a distinct catch-up wrapper, not substituted for this launch-era acquisition record.",
                waypoints = { "/way #2339 59.9 69.9 Rogurn / Elite Conquest Quartermaster" },
            },
        },
        achievements = {},
    },
    ["11.0.5"] = {
        label = "Patch 11.0.5: 20th Anniversary Celebration",
        wowheadPatchId = 110005,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only disappearing learn-on-use appearance tokens, ensembles, and arsenals are included. Ordinary equippable anniversary gear and direct achievement rewards are excluded.",
            "The Cosmetics audit excludes Trading Post, Timewalking, and cross-game/crossover rewards, including Crests of the Kingdom, Prowler headgear, Blackrock Depths gear, and Golden Crests. Patch-native Timewalking mounts remain in the mounts catalog.",
            "Coldflame Ring is a toy and the Guest Relations thinking caps are not purple-arrow consumables, so neither is duplicated here.",
        },
        sourceUrls = {
            anniversary = "https://www.wowhead.com/guide/world-events/20th-anniversary-celebration-rewards",
            anniversaryOverview = "https://www.wowhead.com/guide/world-events/20th-anniversary-event",
            pvp = "https://www.wowhead.com/news/dragonflight-pvp-ensembles-coming-with-patch-11-0-5-elite-ensembles-included-346491",
            patch = "https://www.wowhead.com/guide/the-war-within/patch-11-0-5-overview",
        },
        mounts = {
            { spellId = 428013, name = "Incognitro, the Indecipherable Felcycle" },
            { spellId = 452645, name = "Amani Hunting Bear" },
            { spellId = 468353, name = "Enchanted Spellweave Carpet" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_0_5_COSMETICS,
        cosmeticDetailGroups = {
            anniversaryTierTwo = {
                sourceType = "Anniversary Vendor",
                source = "Traeya / 20th Anniversary Celebration camp",
                acquisition = "Buy the Eternal Tier 2 class ensembles with Bronze Celebration Tokens during the anniversary celebration. Any class can purchase and learn every ensemble.",
                tips = "The first ensemble costs 60 tokens and unlocks Upgraded Apparel; the second then costs 40 and unlocks Classy Dresser; every remaining ensemble costs 20. Purchase in that order before judging the total token requirement.",
                availability = "Originally available during the 20th anniversary event, October 22, 2024 through January 6, 2025; check the current anniversary vendor when the event returns.",
                costs = { "First ensemble: 60 Bronze Celebration Tokens", "Second: 40 after Upgraded Apparel", "Remaining ensembles: 20 each after Classy Dresser" },
                researchNotes = "The wrapper items are catalogued once; their internal armor appearances are not duplicated.",
                waypoints = { "/way #71 63.07 50.94 Traeya / anniversary camp" },
            },
            anniversaryColdflame = {
                sourceType = "Anniversary Vendor",
                source = "Historian Ma'di / 20th Anniversary Celebration camp",
                acquisition = "Buy the four Blizzard service-award-inspired appearance tokens with Bronze Celebration Tokens during the anniversary event.",
                tips = "The crown, sword, and shield cost 10 tokens each; the back crest costs 15. Coldflame Ring is on the same vendor but is a toy, not a wardrobe appearance token.",
                availability = "Seasonal anniversary inventory; originally introduced for the 20th anniversary celebration.",
                cost = "45 Bronze Celebration Tokens for all four.",
                waypoints = { "/way #71 62.7 50.4 Historian Ma'di / anniversary camp" },
            },
            dragonflightLegacyPvP = {
                sourceType = "Legacy PvP Vendors",
                source = "Seltherex and Glamora / Gladiator's Refuge, Valdrakken",
                acquisition = "Buy the Crimson, Obsidian, and Verdant Aspirant/Gladiator ensemble wrappers from Seltherex, and the original elite recolors from Glamora when the character has the historic rating unlock.",
                tips = "Armor ensembles cost 12 Marks of Honor; weapon arsenals cost 80. There are 33 wrappers per Dragonflight season: four Aspirant armor types, thirteen Gladiator classes, thirteen Elite class sets, and three arsenals.",
                requirements = "Elite armor originally required Rival I; elite weapon arsenals originally required Elite (2400 rating) in the matching Dragonflight season.",
                costs = { "Armor ensemble: 12 Marks of Honor", "Weapon arsenal: 80 Marks of Honor" },
                researchNotes = "All 99 consumable wrappers are explicitly generated from their contiguous Blizzard item-ID ranges. Individual weapons and armor taught by the wrappers are not duplicated.",
                waypoints = { "/way #2112 44.6 37.0 Seltherex and Glamora / Gladiator's Refuge" },
            },
        },
        achievements = {},
    },
    ["11.0.7"] = {
        label = "Patch 11.0.7: Siren Isle",
        wowheadPatchId = 110007,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only disappearing learn-on-use appearance tokens and ensembles are included. Ordinary equippable gear and direct wardrobe unlocks are excluded.",
            "The Cosmetics audit excludes Trading Post, Timewalking, Plunderstorm direct unlocks, and cross-game/crossover rewards. The mounts audit retains the new Plunderlord's Midnight Crocolisk in this patch; returning Season 1 mounts remain catalogued under 10.2.6.",
            "Pincer of the Tidestalker and the Siren Isle faction tabards are ordinary equippable items, so they are not included even though some reward lists describe them as transmog.",
        },
        sourceUrls = {
            official = "https://worldofwarcraft.blizzard.com/en-us/news/24165042",
            siren = "https://www.wowhead.com/guide/the-war-within/siren-isle-rewards-guide",
            overview = "https://www.wowhead.com/guide/the-war-within/siren-isle-guide",
            iron = "https://www.method.gg/guides/flame-blessed-iron-vendor-location-and-rewards",
            winterVeil = "https://www.wowhead.com/news/new-winter-veil-rewards-coming-soon-battle-pet-and-festive-transmog-items-349682",
        },
        mounts = {
            { spellId = 303767, name = "Honeyback Hivemother" },
            { spellId = 448934, name = "Shadow of Doubt" },
            { spellId = 471538, name = "Timely Buzzbee" },
            { spellId = 471562, name = "Thrayir, Eyes of the Siren" },
            { spellId = 471696, name = "Hooktalon" },
            { spellId = 472752, name = "The Breaker's Song" },
            { spellId = 473137, name = "Soweezi's Vintage Waveshredder" },
            { spellId = 473472, name = "Jani's Trashpile" },
            { spellId = 474086, name = "Prismatic Snapdragon" },
            { spellId = 1214920, name = "Nightfall Skyreaver" },
            { spellId = 1214940, name = "Ur'zul Fleshripper" },
            { spellId = 1214946, name = "Broodling of Sinestra" },
            { spellId = 1214974, name = "Copper-Maned Quilen" },
            { spellId = 457656, name = "Plunderlord's Midnight Crocolisk" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_0_7_COSMETICS,
        cosmeticDetailGroups = {
            soweezi = {
                sourceType = "Siren Isle Vendor",
                source = "Soweezi / Flotsam Shoal",
                acquisition = "Farm Flame-Blessed Iron from Siren Isle rares, treasures, weekly quests, and Major Excavations, then buy the beach, cruise, workwear, and water-blaster appearance tokens.",
                tips = "Major Excavation bosses award the largest repeatable Iron bundles. Sun-Soaked Clothing is currently listed at 1,500 Iron; some early launch guides showed 2,000, so trust the in-game vendor price if it differs.",
                cost = "1,000-4,500 Flame-Blessed Iron per item.",
                waypoints = { "/way #2369 70.1 48.49 Soweezi / Flotsam Shoal" },
            },
            ailenda = {
                sourceType = "Siren Isle Vendor",
                source = "Ailenda Hedgemyr / Flotsam Shoal",
                acquisition = "Exchange Flame-Blessed Iron for Arathi ensemble, head, shoulder, weapon, and profession-prop appearance tokens.",
                tips = "Mereldar Smithing Mallet has separate main-hand and off-hand tokens with the same displayed name. The 350-Iron version is main hand; the 200-Iron version is off hand.",
                cost = "Ensembles: 3,000; most head/shoulder/weapons: 350; off-hand props: 200 Flame-Blessed Iron.",
                researchNotes = "The vendor's normal gear is excluded; this list retains only consumable appearance tokens.",
                waypoints = { "/way #2369 70.79 40.28 Ailenda Hedgemyr" },
            },
            hoodedPurveyor = {
                sourceType = "Siren Isle Vendor",
                source = "Hooded Purveyor / Flotsam Shoal",
                acquisition = "Exchange Flame-Blessed Iron for the ambassador ensemble, four Earthen workpacks, and paired main-hand/off-hand work-prop tokens.",
                tips = "Each chalice, hammer, and pitcher has two item IDs: the 350-Iron main-hand appearance and the 200-Iron off-hand appearance. Learning one does not collect the other weapon category.",
                cost = "Ensemble: 3,000; backpacks: 500; main-hand props: 350; off-hand props: 200 Flame-Blessed Iron.",
                waypoints = { "/way #2369 67.95 39.30 Hooded Purveyor" },
            },
            taljoriPirate = {
                sourceType = "Siren Isle Vendor",
                source = "Taljori / Flotsam Shoal",
                acquisition = "Buy Taljori's pirate ensembles and individual pirate clothing tokens with Flame-Blessed Iron.",
                tips = "The Tattered Rat Hat is a Taljori purchase; do not confuse it with the similarly themed Salt-Stained Sweatcap from an underwater treasure chest.",
                cost = "Ensembles: 3,000; tunics and hats: 350; waist wrap: 200 Flame-Blessed Iron.",
                waypoints = { "/way #2369 65.76 41.70 Taljori" },
            },
            taljoriVrykulNaga = {
                sourceType = "Siren Isle Vendor",
                source = "Taljori / Flotsam Shoal",
                acquisition = "Buy the Vrykul and naga ensembles, ritual tunic, and standalone weapon appearance tokens with Flame-Blessed Iron.",
                tips = "The vendor list is long; search Taljori's inventory by the exact item name. Pincer of the Tidestalker is deliberately absent because it is equippable gear rather than a consumed appearance token.",
                cost = "Ensembles: 3,000; ritual tunic: 500; individual weapons: 350 Flame-Blessed Iron.",
                researchNotes = "This group preserves sixteen separate weapon/tunic consumables in addition to four ensemble wrappers.",
                waypoints = { "/way #2369 65.76 41.70 Taljori" },
            },
            sirenIsleTreasures = {
                sourceType = "Siren Isle Treasures",
                source = "Barnacle-Encrusted Chest, Azerite dig, and Forgotten Vault secret",
                acquisition = "Loot the Sweatcap from the underwater Barnacle-Encrusted Chest, the Workboots from beneath the Azerite excavation steps, and solve the timed Forgotten Vault route for the Scramseax.",
                tips = "The underwater chest can take several minutes to respawn. For the Scramseax, enter Sacred Hollow, click the Radiant Citrine at in-vault 32.14, 79.52, then reach the cache at in-vault 26.68, 23.55 before Glittering Vault Shard expires after two minutes.",
                researchNotes = "The Forgotten Vault positions are interior coordinates and therefore retained in prose; the map pin takes you to the correct exterior entrance.",
                waypoints = {
                    "/way #2369 74.4 52.98 Barnacle-Encrusted Chest / underwater",
                    "/way #2369 41.7 46.0 Ashvane Issued Workboots / beneath steps",
                    "/way #2369 44.35 22.81 Sacred Hollow / Forgotten Vault entrance",
                },
            },
            bygoneRiches = {
                sourceType = "Major Excavation Reward",
                source = "Crate of Bygone Riches",
                acquisition = "Complete the Drain, Shuddering Hollow, and Drowned Lair Major Excavations after obtaining their associated Cyrce's Circlet citrines. The resulting Crate of Bygone Riches teaches one of eight appearance tokens.",
                tips = "Donate at the Command Map to trigger an excavation. The crate uses collection-aware loot and should not repeat an appearance already learned; keep completing the three excavation bosses until all eight are collected.",
                requirements = "Obtain the three Major Excavation Singing Citrines and defeat their excavation bosses.",
                waypoints = {
                    "/way #2369 69.20 43.0 Command Map / fund an excavation",
                    "/way #2369 62.0 74.0 Gravesludge / The Drain",
                    "/way #2369 44.0 56.0 Stalagnarok / Shuddering Hollow",
                    "/way #2369 32.0 65.0 Nerathor / Drowned Lair",
                },
            },
            winterVeil2024 = {
                sourceType = "Holiday Vendor",
                source = "Smokywood Pastures vendors / Feast of Winter Veil",
                acquisition = "During Winter Veil, buy the red and green belt, chest, legs, boots, vest, sweater, and shirt appearance tokens from a Smokywood Pastures holiday-goods vendor.",
                tips = "Coat and vest are separate chest appearances; pants and shorts are separate leg appearances; sweater and shirt are separate shirt-slot appearances. Buy both colors and every silhouette for all sixteen tokens.",
                availability = "Feast of Winter Veil only; originally introduced with the December 2024 event.",
                costs = { "Belt and boots: 15 gold", "Pants and shorts: 25 gold", "Coat, vest, sweater, and shirt: 30 gold" },
                waypoints = {
                    "/way #87 33.0 66.5 Wulmort Jinglepocket / Ironforge",
                    "/way #85 52.6 77.8 Smokywood Pastures vendors / Orgrimmar",
                },
            },
        },
        achievements = {},
    },
    ["11.1"] = {
        label = "Patch 11.1: Undermined",
        wowheadPatchId = 110100,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only disappearing learn-on-use appearance tokens, ensembles, and arsenals are included. Ordinary equippable gear and direct wardrobe rewards are excluded.",
            "Trading Post rewards are excluded. Bundle components are represented only by their ensemble or arsenal wrapper and are not duplicated.",
            "The Gallagio list preserves all 70 Sando weapon tokens, including the database spelling 'Radier' on the four Torchblades.",
        },
        sourceUrls = {
            cartels = "https://www.wowhead.com/guide/the-war-within/patch-11-1-cartels-of-undermine-renown-guide",
            cartelSets = "https://www.wowhead.com/news/transmog-vendor-sells-cartel-affiliated-sets-in-undermine-four-weeks-to-collect-375616",
            gallagio = "https://www.wowhead.com/guide/raids/liberation-of-undermine/gallagio-loyalty-rewards-club",
            gallagioWeapons = "https://www.wowhead.com/news/unlock-cosmetic-raid-weapon-vendor-at-gallagio-loyalty-renown-rank-11-376756",
            drive = "https://www.wowhead.com/guide/the-war-within/patch-11-1-d-r-i-v-e-guide",
            delves = "https://www.wowhead.com/guide/the-war-within/delves-rewards",
        },
        mounts = {
            { spellId = 465999, name = "Crimson Armored Growler" },
            { spellId = 466001, name = "Blackwater Bonecrusher" },
            { spellId = 466000, name = "Darkfuse Chompactor" },
            { spellId = 466002, name = "Violet Armored Growler" },
            { spellId = 466011, name = "Flarendo the Furious" },
            { spellId = 466012, name = "Thunderdrum Misfire" },
            { spellId = 466016, name = "The Topskimmer Special" },
            { spellId = 466014, name = "Steamwheedle Supplier" },
            { spellId = 466017, name = "Innovation Investigator" },
            { spellId = 466013, name = "Ochre Delivery Rocket" },
            { spellId = 466019, name = "Blackwater Shredder Deluxe Mk 2" },
            { spellId = 466018, name = "Darkfuse Demolisher" },
            { spellId = 466020, name = "Personalized Goblin S.C.R.A.P.per" },
            { spellId = 466022, name = "Venture Co-ordinator" },
            { spellId = 466023, name = "Asset Advocator" },
            { spellId = 466026, name = "Salvaged Goblin Gazillionaire's Flying Machine" },
            { spellId = 466025, name = "Margin Manipulator" },
            { spellId = 466027, name = "Darkfuse Spy-Eye" },
            { spellId = 466028, name = "Mean Green Flying Machine" },
            { spellId = 466024, name = "Bilgewater Bombardier" },
            { spellId = 466133, name = "Delver's Gob-Trotter" },
            { spellId = 466144, name = "Prized Gladiator's Fel Bat" },
            { spellId = 466145, name = "Vicious Electro Eel" },
            { spellId = 466146, name = "Vicious Electro Eel" },
            { spellId = 466021, name = "Violet Goblin Shredder" },
            { spellId = 468068, name = "Junkmaestro's Magnetomech" },
            { spellId = 473188, name = "Bronze Goblin Waveshredder" },
            { spellId = 1217235, name = "Crimson Shreddertank" },
            { spellId = 1217760, name = "The Big G" },
            { spellId = 1221155, name = "Prototype A.S.M.R." },
            { spellId = 1221694, name = "Enterprising Shreddertank" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_1_COSMETICS,
        cosmeticDetailGroups = {
            cartelsRenown = {
                sourceType = "Renown Vendor",
                source = "Smaks Topskimmer / Cartels of Undermine",
                acquisition = "Raise Cartels of Undermine Renown, then claim the Renown 10 padding or purchase the remaining unlocked cosmetics from Smaks Topskimmer.",
                tips = "The four Town attire items are separate consumable appearance tokens. Check the item tooltip before spending Resonance Crystals; Renown unlocks access but does not automatically grant the paid rewards.",
                requirements = "Renown 10, 17, or 18 depending on the item.",
                costs = { "Renown 10 padding: claimed reward", "Helmet: 1,625 Resonance Crystals", "Spikes and jetpack: 3,250 Resonance Crystals each", "Town attire: 9,750 Resonance Crystals each" },
                researchNotes = "The Cartels track and individual-cartel reputations are separate. Do not confuse these with Greexit's weekly cartel-alignment cosmetics.",
                waypoints = { "/way #2346 43.6 50.8 Smaks Topskimmer" },
            },
            greexitBruiser = {
                sourceType = "Weekly Cartel Vendor",
                source = "Greexit Coarsebub / cartel alignment rewards",
                acquisition = "Align with one Undermine cartel for the week, then buy that cartel's bruiser tabard, helm, and spaulders from Greexit. Repeat across at least four weekly alignments for every recolor.",
                tips = "Base prices are 500 gold for a tabard, 200 for a helm, and 100 for spaulders. Goblin racial and other vendor discounts can make the displayed price lower.",
                requirements = "The matching cartel must be selected for the current weekly contract.",
                availability = "The available recolor follows the character's current weekly cartel alignment.",
                researchNotes = "There are twelve independent learn-on-use tokens: three slots for each of four cartels.",
                waypoints = { "/way #2346 24.5 63.3 Greexit Coarsebub" },
            },
            cartelExaltedTabards = {
                sourceType = "Reputation Vendor",
                source = "Individual Undermine cartel quartermasters",
                acquisition = "Reach Exalted with the matching cartel, then buy its learn-on-use tabard token for 1,625 Resonance Crystals.",
                tips = "These use-on-click tabard appearances are distinct from the cheaper weekly bruiser tabards. The four reputations continue to advance even when a different cartel is selected for the weekly contract.",
                requirements = "Exalted with the matching Bilgewater, Steamwheedle, Blackwater, or Venture Co. cartel.",
                cost = "1,625 Resonance Crystals each.",
                waypoints = {
                    "/way #2346 39.0 22.1 Rocco Razzboom / Bilgewater",
                    "/way #2346 27.1 72.5 Lab Assistant Laszly / Steamwheedle",
                    "/way #2346 63.4 16.8 Boatswain Hardee / Blackwater",
                    "/way #2346 53.2 72.6 Shredz the Scrapper / Venture Co.",
                },
            },
            gallagioWeapons = {
                sourceType = "Raid Renown Vendor",
                source = "Sando the Rat / Liberation of Undermine",
                acquisition = "Reach Gallagio Loyalty Rewards Club Renown 11, go upstairs inside the raid entrance, and exchange one Counterfeit Dealer's Chip for one weapon appearance token.",
                tips = "Renown 11 and 15 each unlock a chip per level-80 character; after Renown 15 the One-Armed Bandit can drop more. Story Mode through Paks Topskimmer is a low-pressure route to Sando, and the Gallagio Loyalty Rewards Card returns you to the entrance.",
                requirements = "Gallagio Loyalty Renown 11 to access Sando; further chip acquisition opens at Renown 15.",
                cost = "1 Counterfeit Dealer's Chip per weapon.",
                availability = "Permanent raid-renown catch-up source as of the audited data.",
                researchNotes = "Seventy tokens cover four raid-color families across the raid's weapon models. The color name is part of the item name, not a cartel-alignment requirement.",
                waypoints = { "/way #2346 42.0 50.2 Liberation of Undermine / Incontinental Hotel" },
            },
            undermineCampaign = {
                sourceType = "Campaign Quest",
                source = "Undermine campaign and post-raid epilogue",
                acquisition = "The Severance Package comes from My Top Gal during the campaign. Public Defender's Coat comes from Oh, That Casino! after completing the campaign, defeating Gallywix, and following the But What About the Casino? epilogue.",
                tips = "These are quest-awarded consumable cosmetics; use the token from your bags. If the epilogue is absent, verify the campaign and Gallywix prerequisites on the same character.",
                requirements = "Campaign progress; Public Defender's Coat additionally requires the Gallywix epilogue.",
                waypoints = { "/way #2346 42.7 52.8 Incontinental Hotel / campaign hub" },
            },
            darkfuseCoat = {
                sourceType = "Secret Reputation Vendor",
                source = "Sitch / Darkfuse Solutions",
                acquisition = "Unlock Sitch through the post-campaign Darkfuse sequence, reach Exalted with Darkfuse Solutions, then buy the coat for 3,250 Resonance Crystals.",
                tips = "Enter through the sewer and follow it to Sitch. The vendor is tied to the secret Darkfuse reputation, not the Blackwater cartel.",
                requirements = "Exalted with Darkfuse Solutions and access to Sitch.",
                cost = "3,250 Resonance Crystals.",
                waypoints = { "/way #2346 29.75 41.13 Sewer entrance", "/way #2346 30.6 38.8 Sitch / Darkfuse Solutions" },
            },
            shippingCoat = {
                sourceType = "Activity Reward",
                source = "Shipping and Handling job-streak bonus pool",
                acquisition = "Complete a full Shipping and Handling job streak for a chance at the Breakneck Cabbie's Coat as the extra reward.",
                tips = "Cartels Renown 8 raises the chance of receiving an extra reward to 50%; Renown 12 guarantees an extra reward, but the coat itself remains one possible result from that pool. Keep the streak alive until the forced break.",
                requirements = "Shipping and Handling unlocked; Cartels Renown 8/12 improves the extra-reward roll.",
                researchNotes = "The activity UI and community shorthand count the streak boundary differently, so this record deliberately says a full streak rather than promising a specific number of jobs.",
                waypoints = { "/way #2346 42.7 52.8 Incontinental Hotel / Shipping and Handling hub" },
            },
            chettPack = {
                sourceType = "Checklist Vendor",
                source = "C.H.E.T.T. machine / Incontinental Hotel",
                acquisition = "Complete and turn in 100 C.H.E.T.T. Lists to earn C.H.E.T.T.mate and Part Timer progression, exhaust the machine's dialogue options, then buy the pack for 1,000 Resonance Crystals.",
                tips = "Only completed lists turned in at C.H.E.T.T. count toward this reward; Finder's Fee cartel turn-ins do not. The machine is upstairs on the second floor.",
                requirements = "C.H.E.T.T.mate / Part Timer title progression and unlocked vendor dialogue.",
                cost = "1,000 Resonance Crystals.",
                waypoints = { "/way #2346 43.40 50.50 C.H.E.T.T. / second floor" },
            },
            garbageJetpack = {
                sourceType = "Rare Drop",
                source = "Gallagio Garbage / S.C.R.A.P. heaps",
                acquisition = "Contribute S.C.R.A.P. until a heap reaches 500, defeat Gallagio Garbage if it spawns, and loot the rare jetpack token.",
                tips = "Filling a heap does not guarantee that the rare appears. The kill is repeatable and the cosmetic can drop after the first daily attempt; tag the rare and learn or trade the token while eligible.",
                researchNotes = "Community reports place the rare's spawn chance well below 100%; no unsupported exact percentage is promised here.",
                waypoints = {
                    "/way #2346 31.9 21.4 S.C.R.A.P. Heap",
                    "/way #2346 67.5 29.9 S.C.R.A.P. Heap",
                    "/way #2346 36.8 45.0 S.C.R.A.P. Heap",
                    "/way #2346 50.8 63.6 S.C.R.A.P. Heap",
                    "/way #2346 39.0 81.6 S.C.R.A.P. Heap",
                    "/way #2346 52.6 83.3 S.C.R.A.P. Heap",
                    "/way #2346 70.0 76.7 S.C.R.A.P. Heap",
                },
            },
            delveSeasonOne = {
                sourceType = "Delve Catch-Up Vendor",
                source = "Sir Finley Mrrgglton / Delver's Headquarters",
                acquisition = "At level 80, buy each Season 1 armor ensemble or Arsenal: Hallowfall Weaponry from Sir Finley for 5,000 Undercoin.",
                tips = "These are duplicate-safe wrapper records for appearances originally obtained during Season 1 delves. Inspect the bundle tooltip before buying if much of the old pool is already collected.",
                requirements = "Level 80.",
                cost = "5,000 Undercoin per bundle.",
                researchNotes = "Individual armor and weapon appearances taught by these bundles are intentionally not duplicated in the catalog.",
                waypoints = { "/way #2339 47.49 43.67 Sir Finley Mrrgglton / Delver's Headquarters" },
            },
            forgedAspirant = {
                sourceType = "Legacy PvP Vendor",
                source = "Velerd / Contender's Gate",
                acquisition = "Buy the four Forged Aspirant armor ensembles for 12 Marks of Honor each or its weapon arsenal for 80 Marks of Honor.",
                tips = "The armor bundles are separated by armor class. The arsenal is one wrapper and its individual weapon appearances are not listed again.",
                requirements = "Level 80 and enough Marks of Honor.",
                costs = { "Armor ensemble: 12 Marks of Honor", "Weapon arsenal: 80 Marks of Honor" },
                waypoints = { "/way #2339 55.2 76.2 Velerd / Contender's Gate" },
            },
            forgedGladiator = {
                sourceType = "Legacy PvP Vendor",
                source = "Lalandi / Contender's Gate",
                acquisition = "Buy the class-specific Forged Gladiator armor ensemble for 12 Marks of Honor.",
                tips = "Choose the ensemble for the desired class. These are the regular Season 1 appearances; the elite recolors use a different vendor and retain their old rating requirement.",
                requirements = "Level 80 and 12 Marks of Honor.",
                cost = "12 Marks of Honor each.",
                waypoints = { "/way #2339 55.2 76.2 Lalandi / Contender's Gate" },
            },
            eliteForgedGladiator = {
                sourceType = "Legacy Elite PvP Vendor",
                source = "Rogurn / Contender's Gate",
                acquisition = "If the account earned Rival I during The War Within Season 1, buy the matching elite class ensemble for 12 Marks of Honor.",
                tips = "The historic rating achievement is still required; reaching the rating in a later season does not substitute. Check the vendor on a class that can preview the desired set.",
                requirements = "Rival I earned during The War Within Season 1.",
                cost = "12 Marks of Honor each.",
                availability = "Purchasable only for accounts that met the original Season 1 rating requirement.",
                waypoints = { "/way #2339 55.2 76.2 Rogurn / Contender's Gate" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.1.5"] = {
        label = "Patch 11.1.5",
        wowheadPatchId = 110105,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Only learn-on-use appearance items and arsenals are included. Nightfall and Arathi item-level gear is ordinary equippable equipment and is excluded.",
            "Trading Post rewards are excluded. The original five Faceless Mask appearances are included because Revisited Horrific Visions made their cosmetic tokens collectible again.",
            "Event records retain their historical windows and recurrence notes so unavailable rewards are not presented as permanently active.",
        },
        sourceUrls = {
            visions = "https://www.wowhead.com/guide/the-war-within/revisited-horrific-visions-rewards",
            visionsOfficial = "https://www.wowhead.com/blue-tracker/news/us/revisit-horrific-visions-for-new-challenges-and-rewards-world-of-warcraft-24204919",
            flamesRadiance = "https://www.wowhead.com/guide/the-war-within/flames-radiance-renown-rewards-quests",
            dastardlyDuos = "https://www.wowhead.com/guide/the-war-within/dastardly-duos-overview-rewards",
            childrensWeek = "https://www.wowhead.com/blue-tracker/news/us/befriend-the-orphans-of-azeroth-during-childrens-week-world-of-warcraft-blizzard-24194664",
        },
        mounts = {
            { spellId = 428068, name = "Voidfire Deathcycle" },
            { spellId = 447189, name = "Nesting Swarmite" },
            { spellId = 1218229, name = "Void-Scarred Gryphon" },
            { spellId = 1218305, name = "Void-Forged Stallion" },
            { spellId = 1218306, name = "Void-Scarred Pack Mother" },
            { spellId = 1218307, name = "Void-Scarred Windrider" },
            { spellId = 1218314, name = "Ny'alothan Shadow Worm" },
            { spellId = 1218316, name = "Corruption of the Aspects" },
            { spellId = 1218317, name = "Void-Crystal Panther" },
            { spellId = 1226421, name = "Radiant Imperial Lynx" },
            { spellId = 1227076, name = "Tyrannotort" },
            { spellId = 1228865, name = "Void-Scarred Lynx" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_1_5_COSMETICS,
        cosmeticDetailGroups = {
            torieVisions = {
                sourceType = "Event Vendor",
                source = "Torie / Revisited Horrific Visions",
                acquisition = "Run Revisited Horrific Visions, earn Displaced Corrupted Mementos, and buy the desired learn-on-use appearance from Torie south of the Coreway.",
                tips = "Most of the new Ny'alotha-color armor tokens require We Have the Memories, earned by fully upgrading the Hourglass. Buy cheaper wrists first only if completion count matters; chest, head, and shoulder tokens cost more.",
                requirements = "Revisited Horrific Visions unlocked; most new armor requires We Have the Memories.",
                availability = "Introduced as a limited-time 11.1.5 event; verify current availability in the in-game calendar before routing.",
                costs = { "Wrists: 200 mementos", "Boots, hands, legs, belts, and cloaks: 400 mementos", "Chest, head, and shoulders: 600 mementos", "Backpacks and Ashjra'kamas variants: 1,000-5,000 mementos" },
                researchNotes = "The thirty-six Ny'alotha tokens are nine learn-on-use slots for each armor type; they are not conventional stat gear.",
                waypoints = { "/way #2339 34.49 68.41 Torie / Revisited Horrific Visions" },
            },
            facelessMasks = {
                sourceType = "Horrific Vision Challenge",
                source = "Revisited Horrific Visions end chest",
                acquisition = "Meet the original mask's unlock condition in a Vision, finish the run, and loot the once-per-account cosmetic appearance token from the final chest.",
                tips = "Long Night needs all five objectives in one run. For the other four, enter with at least one mask active and finish the named corrupted or lost area. The newer Vengeance, Nemesis, and Multitudes masks do not have matching cosmetic tokens.",
                requirements = "Varies by mask; the exact objective is retained on each catalog entry.",
                availability = "Tied to Revisited Horrific Visions availability.",
                researchNotes = "These item IDs predate 11.1.5, but the patch restored a way to collect the five appearance items and therefore they belong in this acquisition pass.",
                waypoints = {
                    "/way #2403 50.8 45.1 Valley of Wisdom objective / Burned Bridge",
                    "/way #2403 69.0 49.7 Valley of Honor objective / Daredevil",
                    "/way #2404 75.5 56.7 Old Town objective / Pained",
                    "/way #2404 50.9 84.0 Mage Quarter objective / Dark Imagination",
                },
            },
            flamesRadiance = {
                sourceType = "Renown Reward",
                source = "Flame's Radiance / Lars Bronsmaelt",
                acquisition = "Advance Flame's Radiance Renown. The three buckle tokens come from Renown quests; at Renown 7 buy Radiant Traveler's Backpack from Lars for 3,250 Resonance Crystals.",
                tips = "The buckles are consumable appearance items even though the similarly themed tabards are ordinary wearable items and are not in this catalog. Complete each Renown quest rather than checking only the vendor.",
                requirements = "Renown 1, 5, 7, or 10 depending on the token.",
                cost = "Backpack: 3,250 Resonance Crystals; buckles: quest rewards.",
                waypoints = { "/way #2215 28.2 56.1 Lars Bronsmaelt / Flame's Radiance" },
            },
            dastardlyDuos = {
                sourceType = "Limited Event Vendor",
                source = "Wodin the Troll-Servant / Dastardly Duos",
                acquisition = "Defeat enough Dastardlies to unlock the relevant vendor tier, then buy each learn-on-use token from Wodin for 500 Resonance Crystals.",
                tips = "The vendor inventory expanded week by week: two defeats unlocked red/yellow, four unlocked green/purple, six unlocked black/blue, and eight unlocked the weapon. Any of the three event hubs leads to the same activity.",
                requirements = "2, 4, 6, or 8 Dastardly defeats depending on the item.",
                cost = "500 Resonance Crystals each.",
                availability = "Original event window was June 3-July 15, 2025; unavailable unless the event returns.",
                waypoints = {
                    "/way #2339 61.6 78.4 Dornogal Dastardly Duos",
                    "/way #85 49.7 91.0 Orgrimmar Dastardly Duos",
                    "/way #84 67.7 80.0 Stormwind Dastardly Duos",
                },
            },
            childrensWeek = {
                sourceType = "Holiday Quest or Vendor",
                source = "Dornogal Children's Week",
                acquisition = "Choose either arsenal from the final Dornogal Children's Week quest, or buy the other for one Well-loved Figurine from the holiday vendor.",
                tips = "Both factions can learn both weapon sets. Each arsenal teaches four appearances, so the eight internal weapon records are deliberately not duplicated here.",
                requirements = "Complete the Dornogal Children's Week chain or obtain a Well-loved Figurine.",
                cost = "Final quest choice or 1 Well-loved Figurine.",
                availability = "Annual Children's Week holiday; check the in-game calendar for the current dates.",
                includedAppearances = {
                    "Stormwind arsenal: Painted Wooden Sword, Wooden Stormwind Shield, Painted Wooden Dagger, Painted Fighting Prop",
                    "Orgrimmar arsenal: Painted Wooden Axe, Wooden Orgrimmar Shield, Painted Wooden Hatchet, Painted Axe Prop",
                },
                waypoints = { "/way #2339 55.4 27.2 Ullna and the Visitors", "/way #2339 55.8 26.6 Jepetto Joybuzz" },
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.1.7"] = {
        label = "Patch 11.1.7",
        wowheadPatchId = 110107,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Timewalking appearance tokens are excluded from Cosmetics; Chrono Corsair remains in the mounts catalog as a patch-native Timewalking reward.",
            "Cross-game and crossover promotional rewards are excluded, including the Greedy Emissary / Diablo collection. Trading Post rewards are also excluded.",
            "The remaining Cosmetics record is the permanent Rise of the Red Dawn reward; Midsummer and Twitch-promotion appearances are excluded.",
        },
        sourceUrls = {
            redDawn = "https://www.wowhead.com/news/earn-arathi-themed-rewards-from-the-rise-of-the-red-dawn-questline-in-patch-11-1-377299",
            midsummerOfficial = "https://www.wowhead.com/blue-tracker/news/eu/embrace-the-heat-during-the-midsummer-fire-festival-world-of-warcraft-blizzard-24213951",
            midsummer = "https://www.wowhead.com/guide/world-events/holidays/midsummer-fire-festival",
            adornedHalfShell = "https://www.wowhead.com/blue-tracker/news/us/updated-8-5-twitch-drop-get-the-adorned-half-shell-transmog-world-of-warcraft-24223309",
        },
        mounts = {
            { spellId = 1226144, name = "Chrono Corsair" },
            { spellId = 1237631, name = "Moonlit Nightsaber" },
            { spellId = 1237703, name = "Ivory Savagemane" },
            { spellId = 1241263, name = "OC91 Chariot" },
        },
        pets = {},
        toys = {},
        cosmetics = PATCH_11_1_7_COSMETICS,
        cosmeticDetailGroups = {
            redDawn = {
                sourceType = "Campaign Quest",
                source = "Past Glory / Rise of the Red Dawn",
                acquisition = "Start Trouble in the Highlands from Faerin Lothar outside the Dornogal inn, finish the Rise of the Red Dawn story, then complete Past Glory for the learn-on-use pauldrons.",
                tips = "Follow the chain into Arathi Highlands; the shoulder token is from the finale, not a random mob drop. Use it from the bag after turn-in.",
                requirements = "Complete the Rise of the Red Dawn questline through Past Glory.",
                availability = "Permanent story questline as of the audited data.",
                waypoints = { "/way #2339 46.0 49.6 Faerin Lothar / Trouble in the Highlands", "/way #14 36.7 58.0 Rise of the Red Dawn / High Perch area" },
            },
            midsummerVendor = {
                sourceType = "Holiday Vendor",
                source = "Midsummer Fire Festival vendors",
                acquisition = "Earn Burning Blossoms by honoring friendly flames, desecrating enemy flames, and completing holiday activities, then buy the three learn-on-use Fire Festival armor tokens.",
                tips = "The helm and mantle cost 350 blossoms each; the belt costs 150. Route bonfires across expansions before spending so the one-time blossom supply covers the desired pieces.",
                requirements = "Midsummer Fire Festival active.",
                costs = { "Grand Helm: 350 Burning Blossoms", "Grand Mantle: 350 Burning Blossoms", "Grand Belt: 150 Burning Blossoms" },
                availability = "Annual Midsummer Fire Festival; the 2025 window was June 21-July 5. Check the current calendar.",
                waypoints = { "/way #85 45.9 37.4 Orgrimmar Midsummer festival", "/way #84 50.0 72.0 Stormwind Midsummer festival" },
            },
            ahune = {
                sourceType = "Holiday Dungeon Drop",
                source = "Ahune / Satchel of Chilled Goods",
                acquisition = "Queue for Ahune while Midsummer is active and open the daily Satchel of Chilled Goods for a chance at the crown or one of the four scythe/staff appearance tokens.",
                tips = "The first daily satchel is the meaningful attempt and uses bad-luck protection according to the event guide; later character runs may have only a very small chance. The polearms and staves are distinct appearances despite their paired names.",
                requirements = "Midsummer Fire Festival active and eligible for the holiday dungeon reward.",
                availability = "Annual Midsummer Fire Festival only.",
                researchNotes = "Five separate consumable items: one crown, two polearms, and two staves. They are not bundle components.",
                waypoints = { "/way #85 45.9 37.4 Orgrimmar Midsummer festival / queue hub", "/way #84 50.0 72.0 Stormwind Midsummer festival / queue hub" },
            },
            adornedHalfShell = {
                sourceType = "WoW Twitch Drop",
                source = "Adorned Half Shell promotion",
                acquisition = "The original promotion required watching four hours of eligible World of Warcraft streams with linked Battle.net and Twitch accounts, then claiming the drop.",
                tips = "This was a WoW-only promotional appearance rather than a cross-game reward, but the original claim window has ended. Keep the record for collection diagnosis and any future return.",
                requirements = "Claimed during the original Twitch Drop window or a future reissue.",
                availability = "Original promotion ran July 14-August 19, 2025 after Blizzard extended the end date; it is no longer claimable.",
                researchNotes = "No map waypoint is supplied because acquisition occurred outside the game and the token arrived through the promotion.",
            },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.2"] = {
        label = "Patch 11.2: Ghosts of K'aresh",
        wowheadPatchId = 110200,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Cosmetics are limited to learn-on-use appearance items, ensembles, and arsenals. Ordinary equippable gear and Trading Post rewards are excluded.",
            "K'aresh treasure records use the learnable purple cosmetic token, not the similarly named gray flavor item that can accompany it.",
            "Bundle components are not duplicated: Ethereal Sash Cache and Arsenal: Undermine Weaponry each appear once even though they teach multiple appearances.",
        },
        sourceUrls = {
            cosmetics = "https://www.wowhead.com/guide/collections/transmog-armor-patch-11-2",
            phaseDiving = "https://www.wowhead.com/guide/the-war-within/phase-diving-unlock-rewards",
            phaseLostWeapons = "https://www.wowhead.com/news/previously-unobtainable-weapon-transmogs-available-in-patch-11-2s-phase-diving-377706",
            kareshTrust = "https://www.wowhead.com/guide/the-war-within/karesh-trust-renown-quartermaster-fastest-farming",
            treasures = "https://www.wowhead.com/guide/the-war-within/karesh-rares-and-treasures",
            delveCatchup = "https://www.wowhead.com/news/obtain-missed-season-2-delve-cosmetics-with-the-undermine-weaponry-arsenal-in-377484",
            manaforgeVandals = "https://www.wowhead.com/guide/raids/manaforge-omega/manaforge-vandals-renown",
        },
        mounts = {
            { spellId = 353264, name = "Xy Trustee's Gearglider" },
            { spellId = 353265, name = "Vandal's Gearglider" },
            { spellId = 472157, name = "Astral Gladiator's Fel Bat" },
            { spellId = 1221132, name = "Resplendent K'arroc" },
            { spellId = 1223187, name = "Terror of the Wastes" },
            { spellId = 1223191, name = "Terror of the Night" },
            { spellId = 1224048, name = "Delver's Mana-Skimmer" },
            { spellId = 1233511, name = "Umbral K'arroc" },
            { spellId = 1233518, name = "Lavender K'arroc" },
            { spellId = 1233542, name = "The Bone Freezer" },
            { spellId = 1233546, name = "Ruby Void Creeper" },
            { spellId = 1233547, name = "Acidic Void Creeper" },
            { spellId = 1233559, name = "Blue Barry" },
            { spellId = 1233561, name = "Curious Slateback" },
            { spellId = 1234573, name = "Unbound Star-Eater" },
            { spellId = 1234820, name = "Vicious Void Creeper" },
            { spellId = 1234821, name = "Vicious Void Creeper" },
            { spellId = 1240632, name = "Pearlescent Krolusk" },
            { spellId = 1241070, name = "Translocated Gorger" },
            { spellId = 1241076, name = "Sthaarbs's Last Lunch" },
            { spellId = 1242272, name = "Royal Voidwing" },
            { spellId = 1245517, name = "Scarlet Void Flyer" },
            { spellId = 1246781, name = "Azure Void Flyer" },
            { spellId = 1250578, name = "Phase-Lost Slateback" },
        },
        pets = {},
        toys = {},
        cosmetics = {
            { itemId = 248998, name = "Ensemble: Untethered Captain's Full-Plate", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 248995, name = "Ensemble: Untethered Seer's Vestiture", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 248996, name = "Ensemble: Untethered Blade's Garb", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 248997, name = "Ensemble: Untethered Striker's Gear", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 250441, name = "Ensemble: Shoulderguards of the Wastelander Seer", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 250442, name = "Ensemble: Ancient Capes of the Reshii", subtype = "ensemble", detailKey = "phaseVendor" },
            { itemId = 245967, name = "Shawl of the Trust", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 245968, name = "Tabard of the Trust", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 245969, name = "Mantle of the Trust", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 245980, name = "Inter-Phase Scoop", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 245979, name = "Arcano-Charged Wrench", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 245981, name = "K'areshi Multi-Tool", subtype = "appearance", detailKey = "kareshTrust" },
            { itemId = 248969, name = "Ensemble: Hollow Sentinel's Wingdrapes", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248971, name = "Ensemble: Vicious Charhound's Felcovers", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248972, name = "Ensemble: Plumes of the Mother Eagle", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248973, name = "Ensemble: Spellweaver's Immaculate Runecloaks", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248976, name = "Ensemble: Midnight Herald's Shrouds", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248977, name = "Ensemble: Augur's Ephemeral Brilliance", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248978, name = "Ensemble: Breeze of Fallen Storms", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248979, name = "Ensemble: Gilded Cloaks of the Lucent Battalion", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248980, name = "Ensemble: Memories of a Dying Star", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248981, name = "Ensemble: Capes of the Sudden Eclipse", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248982, name = "Ensemble: Shawls of Channeled Fury", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248983, name = "Ensemble: Inquisitor's All-Seeing Madness", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 248984, name = "Ensemble: Living Weapon's Capes", subtype = "ensemble", detailKey = "manaforgeCloaks" },
            { itemId = 244140, name = "Ethereal Sash Cache", subtype = "ensemble", detailKey = "moonlighter" },
            { itemId = 237954, name = "Arsenal: Undermine Weaponry", subtype = "arsenal", detailKey = "undermineWeaponry" },
            { itemId = 250269, name = "Phase-Lost Longsword", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250270, name = "Phase-Lost Scimitar", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250271, name = "Phase-Lost Hammer", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250272, name = "Phase-Lost Cudgel", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250273, name = "Phase-Lost Carver", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250274, name = "Phase-Lost Hatchet", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250275, name = "Phase-Lost Zweihander", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250276, name = "Phase-Lost Greatsword", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250277, name = "Phase-Lost Maul", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250278, name = "Phase-Lost Great Mace", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250280, name = "Phase-Lost Chopper", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250281, name = "Phase-Lost Battleaxe", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250282, name = "Phase-Lost Bardiche", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250283, name = "Phase-Lost Spear", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250284, name = "Phase-Lost Spire", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250285, name = "Phase-Lost Shillelagh", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250286, name = "Phase-Lost Blunderbuss", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250287, name = "Phase-Lost Longbow", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250288, name = "Phase-Lost Baselard", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250289, name = "Phase-Lost Dirk", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250294, name = "Phase-Lost Katar", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250295, name = "Phase-Lost Claw", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250296, name = "Phase-Lost Sigil", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250297, name = "Phase-Lost Beacon", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250298, name = "Phase-Lost Bulwark", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250299, name = "Phase-Lost Pavise", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250300, name = "Phase-Lost Rod", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 250301, name = "Phase-Lost Wand", subtype = "appearance", detailKey = "phaseLostWeapons" },
            { itemId = 248199, name = "The Brothers' Final Gift", subtype = "appearance", detailKey = "treasureBrothers" },
            { itemId = 246295, name = "Tazavesh Lookout's Mace", subtype = "appearance", detailKey = "treasureLookout" },
            { itemId = 246297, name = "Desperate Defender's Bladed Staff", subtype = "appearance", detailKey = "treasureDefender" },
            { itemId = 246299, name = "Blade of Lost Hope", subtype = "appearance", detailKey = "treasureLostHope" },
            { itemId = 246293, name = "Buckler of the Last Stand", subtype = "appearance", detailKey = "treasureBuckler" },
            { itemId = 243002, name = "Light-Soaked Cleaver", subtype = "appearance", detailKey = "treasureCleaver" },
            { itemId = 243003, name = "Spear of Fallen Memories", subtype = "appearance", detailKey = "treasureSpear" },
            { itemId = 243004, name = "Efrat's Forgotten Bulwark", subtype = "appearance", detailKey = "treasureEfrat" },
            { itemId = 243005, name = "Tulwar of the Golden Guard", subtype = "appearance", detailKey = "treasureTulwar" },
            { itemId = 243006, name = "Petrified Branch of Janaa", subtype = "appearance", detailKey = "treasureBranch" },
            { itemId = 243008, name = "Shadowguard Crusher", subtype = "appearance", detailKey = "treasureCrusher" },
            { itemId = 243009, name = "Sufaadi Skiff Lantern", subtype = "appearance", detailKey = "treasureLantern" },
            { itemId = 243153, name = "Korgorath's Talon", subtype = "appearance", detailKey = "treasureTalon" },
            { itemId = 245667, name = "Warglaive of the Audacious Hunter", subtype = "appearance", detailKey = "treasureWarglaive" },
            { itemId = 245669, name = "P.O.S.T. Master's Prototype Parcel and Postage Presser", subtype = "appearance", detailKey = "treasurePost" },
            { itemId = 245671, name = "Phaseblade of the Void Marches", subtype = "appearance", detailKey = "treasurePhaseblade" },
            { itemId = 245673, name = "Bladed Rifle of Unfettered Momentum", subtype = "appearance", detailKey = "treasureRifle" },
        },
        cosmeticDetailGroups = {
            phaseVendor = { sourceType = "Phase Diving Vendor", source = "Shad'anis / Overlook Zo'Shuul", acquisition = "Unlock Phase Diving through Chapter 3 of the K'aresh campaign, earn Untethered Coins from phase activities, then buy the ensemble from Shad'anis for 5 coins.", tips = "The weekly More Than Just a Phase is the dependable coin source. Check the ensemble tooltip before buying because the vendor may still show bundles whose appearances you already know.", waypoints = KARESH_PHASE_VENDOR_WAYPOINTS },
            kareshTrust = { sourceType = "Renown Reward", source = "Om'sirik / The K'aresh Trust", acquisition = "Raise The K'aresh Trust Renown and claim or buy the unlocked cosmetic from Om'sirik in Tazavesh.", tips = "Shawl, tabard, and mantle unlock at Renown 6, 10, and 13. The three tools unlock at Renown 17; Inter-Phase Scoop is the free reward while the other tools require Resonance Crystals.", waypoints = KARESH_TRUST_WAYPOINTS },
            manaforgeCloaks = { sourceType = "Raid Renown Vendor", source = "Ba'choso / Manaforge Vandals", acquisition = "Reach Manaforge Vandals Renown 2, defeat Loom'ithar for Loombeast Silk, then exchange one silk for a class cloak ensemble at Ba'choso outside Manaforge Omega.", tips = "Loombeast Silk is limited to one account-wide drop per week. Verify the cloak appearances before purchasing; Ba'choso can sell an ensemble that your collection already knows.", waypoints = MANAFORGE_CLOAK_WAYPOINTS },
            moonlighter = { sourceType = "Meta Achievement", source = "Moonlighter / Tazavesh Warrants", acquisition = "Finish all six rotating Warrant questlines from Constable Zo'ardaz. Ethereal Sash Cache is delivered with the Moonlighter reward and teaches four sash appearances.", tips = "Only one random Warrant is offered per week, so this normally takes at least six weeks. If the cache is not in your bags after the final Warrant, check the mailbox before repeating anything.", waypoints = MOONLIGHTER_WAYPOINTS },
            undermineWeaponry = { sourceType = "Delve Catch-Up Vendor", source = "Sir Finley Mrrgglton / Dornogal", acquisition = "Buy Arsenal: Undermine Weaponry from Sir Finley Mrrgglton for 5,000 Undercoin to learn the twelve Season 2 delve weapon appearances.", tips = "This is the duplicate-safe catch-up bundle for the old delve pool. Inspect its tooltip first if you collected several appearances during Season 2.", waypoints = UNDERMINE_WEAPONRY_WAYPOINTS },
            phaseLostWeapons = { sourceType = "Phase Diving Drop", source = "Phase Orbs in K'aresh and Tazavesh", acquisition = "Wear upgraded Reshii Wraps and loot Phase Orbs while Phase Diving. The Orbs of Power upgrade also lets slain enemies generate orbs.", tips = "Learn each weapon immediately: duplicate protection checks whether the appearance is collected, not whether the token is sitting in your bags. Untethered Xy'bucha or a fast ground mount helps on routes, and visible orbs can be claimed by another player first.", waypoints = PHASE_ORB_WAYPOINTS },
            treasureBrothers = { sourceType = "Treasure Puzzle", source = "The Brothers' Final Gift / K'aresh", acquisition = "Begin with Ihya and the Flickering Lantern, then visit Naji, M'alim, and Sahra to complete the brothers' memorial sequence and claim the cosmetic token.", tips = "Follow the four stops in order; the lantern interaction starts the sequence.", waypoints = { "/way #2371 76.0 45.2 Ihya and Flickering Lantern", "/way #2371 68.3 45.3 Naji", "/way #2371 69.8 60.5 M'alim", "/way #2371 75.5 39.8 Sahra" } },
            treasureLookout = { sourceType = "Treasure", source = "Crudely Stitched Sack / K'aresh", acquisition = "Open the Crudely Stitched Sack to receive the learnable Tazavesh Lookout's Mace token.", tips = "Use the purple cosmetic token; the similarly named gray flavor object does not teach an appearance.", waypoints = { "/way #2371 58.6 34.3 Crudely Stitched Sack" } },
            treasureDefender = { sourceType = "Treasure", source = "Sand-Worn Coffer / K'aresh", acquisition = "Open the Sand-Worn Coffer to receive Desperate Defender's Bladed Staff.", tips = "The coffer is in the northern wastes; use the cosmetic item from your bags after looting it.", waypoints = { "/way #2371 54.4 24.4 Sand-Worn Coffer" } },
            treasureLostHope = { sourceType = "Treasure", source = "Abandoned Lockbox / K'aresh", acquisition = "Find the Abandoned Lockbox at one of its possible spawn points and use the Blade of Lost Hope token it contains.", tips = "The lockbox can appear at several points, so check the full route instead of camping only one coordinate.", waypoints = { "/way #2371 53.95 54.96 Abandoned Lockbox", "/way #2371 54.0 59.3 Abandoned Lockbox", "/way #2371 60.1 60.9 Abandoned Lockbox", "/way #2371 59.75 53.72 Abandoned Lockbox" } },
            treasureBuckler = { sourceType = "Phase Diving Treasure", source = "Ethereal Voidforged Container", acquisition = "Enter Phase Diving and open the Ethereal Voidforged Container for Buckler of the Last Stand.", tips = "Phase-only treasures require Reshii Wraps rank 4, What Lies Beyond. Use the token immediately after looting.", waypoints = { "/way #2371 52.0 68.4 Ethereal Voidforged Container" } },
            treasureCleaver = { sourceType = "Phase Diving Treasure", source = "Light-Soaked Cleaver treasure", acquisition = "While Phase Diving, reach and loot the treasure that awards Light-Soaked Cleaver.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 52.4 46.6 Light-Soaked Cleaver treasure" } },
            treasureSpear = { sourceType = "Phase Diving Treasure", source = "Spear of Fallen Memories treasure", acquisition = "While Phase Diving in Tazavesh, loot the hidden treasure for Spear of Fallen Memories.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2472 23.7 46.8 Spear of Fallen Memories treasure" } },
            treasureEfrat = { sourceType = "Phase Diving Treasure", source = "Efrat's Forgotten Bulwark treasure", acquisition = "While Phase Diving, loot the hidden treasure for Efrat's Forgotten Bulwark.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 78.0 48.9 Efrat's Forgotten Bulwark treasure" } },
            treasureTulwar = { sourceType = "Phase Diving Treasure", source = "Tulwar of the Golden Guard treasure", acquisition = "While Phase Diving, loot the hidden treasure for Tulwar of the Golden Guard.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 51.0 65.1 Tulwar of the Golden Guard treasure" } },
            treasureBranch = { sourceType = "Phase Diving Treasure", source = "Petrified Branch of Janaa treasure", acquisition = "While Phase Diving, loot the hidden treasure for Petrified Branch of Janaa.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 78.3 61.5 Petrified Branch of Janaa treasure" } },
            treasureCrusher = { sourceType = "Phase Diving Treasure", source = "Shadowguard Crusher treasure", acquisition = "While Phase Diving near Shadow Point, loot the hidden treasure for Shadowguard Crusher.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 49.1 18.0 Shadowguard Crusher treasure" } },
            treasureLantern = { sourceType = "Phase Diving Treasure", source = "Sufaadi Skiff Lantern treasure", acquisition = "While Phase Diving, loot the hidden treasure for Sufaadi Skiff Lantern.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond; a glider or Untethered Xy'bucha can simplify awkward approaches.", waypoints = { "/way #2371 80.7 52.6 Sufaadi Skiff Lantern treasure" } },
            treasureTalon = { sourceType = "Phase Diving Treasure", source = "Korgorath's Talon treasure", acquisition = "While Phase Diving, loot the hidden treasure for Korgorath's Talon.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 64.4 42.7 Korgorath's Talon treasure" } },
            treasureWarglaive = { sourceType = "Phase Diving Treasure", source = "Warglaive of the Audacious Hunter treasure", acquisition = "Enter the nearby structure while Phase Diving and loot the cosmetic token inside.", tips = "The pin marks the entrance; the treasure itself is deeper inside near 58.45, 22.78. Requires Reshii Wraps rank 4.", waypoints = { "/way #2371 56.8 24.1 Entrance to Warglaive treasure" } },
            treasurePost = { sourceType = "Phase Diving Treasure", source = "P.O.S.T. Master's Prototype Parcel and Postage Presser", acquisition = "Enter the P.O.S.T. area while Phase Diving and loot the prototype cosmetic token.", tips = "The exterior door is near 48.02, 62.92; continue inside to the treasure. Requires Reshii Wraps rank 4.", waypoints = { "/way #2472 48.02 62.92 Door to P.O.S.T. treasure", "/way #2472 47.4 69.8 Prototype Parcel and Postage Presser" } },
            treasurePhaseblade = { sourceType = "Phase Diving Treasure", source = "Phaseblade of the Void Marches treasure", acquisition = "While Phase Diving, loot the hidden treasure for Phaseblade of the Void Marches.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond.", waypoints = { "/way #2371 50.8 35.3 Phaseblade of the Void Marches treasure" } },
            treasureRifle = { sourceType = "Phase Diving Treasure", source = "Bladed Rifle of Unfettered Momentum treasure", acquisition = "While Phase Diving, loot the hidden treasure for Bladed Rifle of Unfettered Momentum.", tips = "Requires Reshii Wraps rank 4, What Lies Beyond; use a mobility aid if the approach is difficult.", waypoints = { "/way #2371 70.0 70.9 Bladed Rifle treasure" } },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.2.5"] = {
        label = "Patch 11.2.5: Legion Remix",
        wowheadPatchId = 110205,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "The list tracks learn-on-use ensembles, arsenals, illusions, and cosmetic tokens offered or awarded during Legion Remix; ordinary equippable raid and world gear is excluded.",
            "Legion Remix ran from October 7, 2025 through January 19, 2026. Event-only sources are now legacy and unavailable unless Blizzard returns them.",
            "Trading Post items are excluded. Component appearance records taught by an ensemble, arsenal, or achievement wrapper are not duplicated.",
        },
        sourceUrls = {
            overview = "https://www.wowhead.com/guide/wow-remix-legion-overview",
            rewards = "https://www.wowhead.com/guide/legion-remix-rewards-mounts-transmog",
            zoneRewards = "https://www.wowhead.com/news/50-warband-xp-buff-exclusive-transmogs-pets-and-more-zone-rewards-in-legion-remix-378658",
            felshatter = "https://www.wowhead.com/news/embrace-the-fel-with-a-new-weapon-illusion-in-legion-remix-378372",
            argusWeapons = "https://www.wowhead.com/news/scythes-of-the-unmaker-and-taeshalach-appearances-available-in-legion-remix-phase-4-379378",
        },
        mounts = {
            { spellId = 1229276, name = "Bloodhunter Fel Bat" },
            { spellId = 1229283, name = "Ashplague Fel Bat" },
            { spellId = 1229288, name = "Wretched Fel Bat" },
            { spellId = 1235513, name = "Snowy Highmountain Eagle" },
            { spellId = 1238729, name = "Slag Basilisk" },
            { spellId = 1250482, name = "Ghastly Ur'zul" },
            { spellId = 1250879, name = "Leystone Basilisk" },
            { spellId = 1250880, name = "Felslate Basilisk" },
            { spellId = 1250881, name = "Aquamarine Basilisk" },
            { spellId = 1250882, name = "Illidari Dreadstalker" },
            { spellId = 1250884, name = "Illidari Blightstalker" },
            { spellId = 1250886, name = "Highland Elderhorn" },
            { spellId = 1251255, name = "Treetop Highmountain Eagle" },
            { spellId = 1251265, name = "Arcberry Manasaber" },
            { spellId = 1251279, name = "Fel-Scarred Mana Ray" },
            { spellId = 1251281, name = "Bloodtooth Mana Ray" },
            { spellId = 1251283, name = "Albino Mana Ray" },
            { spellId = 1251284, name = "Luminous Mana Ray" },
            { spellId = 1251295, name = "Twilight Courser" },
            { spellId = 1251297, name = "Golden Sunrunner" },
            { spellId = 1251298, name = "Turquoise Courser" },
            { spellId = 1251300, name = "Gloomdark Nightmare" },
            { spellId = 1251305, name = "Bonesteed of Triumph" },
            { spellId = 1251307, name = "Bonesteed of Bloodshed" },
            { spellId = 1251309, name = "Bonesteed of Plague" },
            { spellId = 1251311, name = "Bonesteed of Oblivion" },
            { spellId = 1251396, name = "Longhorned Sable Talbuk" },
            { spellId = 1251397, name = "Garnet Ruinstrider" },
            { spellId = 1251398, name = "Longhorned Bleakhoof Talbuk" },
            { spellId = 1251399, name = "Longhorned Argussian Talbuk" },
            { spellId = 1251400, name = "Longhorned Beryl Talbuk" },
            { spellId = 1253129, name = "Chestnut Courser" },
            { spellId = 1253130, name = "Brimstone Courser" },
            { spellId = 1255264, name = "Felscorned Vilebrood Vanquisher" },
            { spellId = 1255431, name = "Slayer's Felscorned Shrieker" },
            { spellId = 1255456, name = "Felscorned Wolfhawk" },
            { spellId = 1255463, name = "Archmage's Felscorned Disc" },
            { spellId = 1255467, name = "Felscorned Grandmaster's Companion" },
            { spellId = 1255471, name = "Felscorned Highlord's Charger" },
            { spellId = 1255475, name = "High Priest's Felscorned Seeker" },
            { spellId = 1255477, name = "Shadowblade's Felscorned Omen" },
            { spellId = 1255478, name = "Farseer's Felscorned Tempest" },
            { spellId = 1255480, name = "Felscorned Netherlord's Dreadsteed" },
            { spellId = 1255482, name = "Felscorned War Wyrm" },
        },
        pets = {},
        toys = {},
        cosmetics = {
            { itemId = 253382, name = "Arsenal: Arms of the Felforged Knight", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 255156, name = "Arsenal: Odyn's Spears", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 253379, name = "Ensemble: Windrunner Quivers", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241416, name = "Ensemble: Blazing Dreamscribed Robes", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241415, name = "Ensemble: Dreamwatcher Vestments", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241414, name = "Ensemble: Dreamseeker Vestments", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241413, name = "Ensemble: Nightrune Robes", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241412, name = "Ensemble: Earthrune Robes", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241411, name = "Ensemble: Skyrune Robes", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241410, name = "Ensemble: Slayer's Golden Scarguards", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241409, name = "Ensemble: Slayer's Silver Scarguards", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241408, name = "Ensemble: Fel-Bloodied Battlegear", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241407, name = "Ensemble: Searaider's Battlegarb", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241406, name = "Ensemble: Gladeraider's Battlegarb", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241403, name = "Ensemble: Jarl's Battlescales", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241402, name = "Ensemble: Ruby Drake Hunter's Kit", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241400, name = "Ensemble: Highpeak Dragonscale", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241399, name = "Ensemble: Dreamweald Dragonscale", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241397, name = "Ensemble: Firewurm Dragonscale", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241396, name = "Ensemble: Jarl's Battlehorns", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241395, name = "Ensemble: Storm Champion's Warharness", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241358, name = "Ensemble: Dream Defender's Emerald Guardplate", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 190772, name = "Ensemble: Barkbinds of the Archdruid's Nightmare", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241356, name = "Ensemble: Tidecaller's Scales", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241355, name = "Ensemble: Verdant Dreamscribed Robes", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 251271, name = "Ensemble: Tidesoaked Battlegear", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 253385, name = "Ensemble: Mantles of the Nightwell", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 253358, name = "Ensemble: Tideskorn Hunter's Munitions", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 253551, name = "Arsenal: Mo'arg Swords", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 253556, name = "Arsenal: Bone Scythes", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 253561, name = "Arsenal: Immortal Maces", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 253565, name = "Arsenal: Mo'arg Hornmaces", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 253569, name = "Arsenal: Gems of the Lightforged Draenei", subtype = "arsenal", detailKey = "remixExclusive" },
            { itemId = 241360, name = "Ensemble: Stygian Silks", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241392, name = "Ensemble: Argussian Demonsbane Armor", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241390, name = "Ensemble: Vestments of Eredathian Sacrifice", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241389, name = "Ensemble: Antoran Guard's Golden Battleplate", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241388, name = "Ensemble: Heritage of the Lightforged - Holy Gold", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241387, name = "Ensemble: Heritage of the Lightforged - Hologemmed", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241386, name = "Ensemble: Heritage of the Lightforged - Crimson Vengeance", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 241385, name = "Ensemble: Heritage of the Shal'dorei - Vineyard Red", subtype = "ensemble", detailKey = "remixExclusive" },
            { itemId = 139170, name = "Ensemble: Fel-Infused Cloth Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 139169, name = "Ensemble: Felshroud Leather Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 139168, name = "Ensemble: Fel-Chain Mail Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 139167, name = "Ensemble: Felforged Plate Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241440, name = "Ensemble: Vestments of the Manasinged", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241438, name = "Ensemble: Moonfall Robes", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241437, name = "Ensemble: Battlegear of the Dreadhide Stalker", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241435, name = "Ensemble: Ambervale Bonehide", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241433, name = "Ensemble: Chains of Helheim", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241432, name = "Ensemble: Darkwatcher Bindings", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241430, name = "Ensemble: Jandvik Diver's Metal", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241429, name = "Ensemble: Leyline Defender's Sunplate Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241384, name = "Ensemble: Regalia of the Hrydshal Runespeaker", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241383, name = "Ensemble: Crescent Vale Raiment", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241382, name = "Ensemble: Wine-Dark Royal Robes", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241381, name = "Ensemble: Leyline Scholar's Regalia", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241380, name = "Ensemble: Highmountain Hides", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241379, name = "Ensemble: Haustvelt Leathers", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241378, name = "Ensemble: Sablehide Vestments", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241377, name = "Ensemble: Llothien Prowler's Kit", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241376, name = "Ensemble: Dreadthorn Battlegear", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241375, name = "Ensemble: Scales of Remembered Eternity", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241374, name = "Ensemble: Stormborn Laminar Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241373, name = "Ensemble: Highmountain Riverscales", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241372, name = "Ensemble: Thunderpeak Boneguards", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241371, name = "Ensemble: Nar'thalas Graduate's Trim", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241370, name = "Ensemble: Kal'delar Battleplate", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241369, name = "Ensemble: Vrykul Funereal Regalia", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241364, name = "Ensemble: Riven Priesthood Regalia", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241363, name = "Ensemble: Lunarblight Leathers", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241362, name = "Ensemble: Shrinebreaker's Battlegear", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241361, name = "Ensemble: Moonshatter Warplate", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241444, name = "Ensemble: Vileweave Vestments", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241443, name = "Ensemble: Netherfiend Battlegear", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241442, name = "Ensemble: Ered'ruin Scalemail", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241441, name = "Ensemble: Xorothian Plate Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241359, name = "Ensemble: Garothi Battleplate", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241368, name = "Ensemble: Doomsinger's Cloth Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241367, name = "Ensemble: Arinor Keeper's Leather Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241366, name = "Ensemble: Oronaar Disciple's Mail Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241365, name = "Ensemble: Praetorium Guard's Plate Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241391, name = "Ensemble: Stygian Hides", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 253594, name = "Ensemble: Zealous Felslingers Battle Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 253588, name = "Ensemble: World-Defiler's Battle Armor", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 254753, name = "Ensemble: Forgotten Conservatory Clothes", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 254754, name = "Ensemble: Eredath Lightseeker's Regalia", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 254752, name = "Ensemble: Triumvirate High Guard's Battlegear", subtype = "ensemble", detailKey = "remixWorld" },
            { itemId = 241439, name = "Ensemble: Seawitch's Terrorcloth", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241436, name = "Ensemble: Nighthide Coat", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241434, name = "Ensemble: Chains of Nightmare's Embrace", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241431, name = "Ensemble: Suramar Silver Plating", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241428, name = "Ensemble: Vesture of Borrowed Souls", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241427, name = "Ensemble: Sanguine Oath Vestments", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241425, name = "Ensemble: Bindings of Hungering Flesh", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241424, name = "Ensemble: Thirsting Hides", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241422, name = "Ensemble: Armor of the Skyfather's Chosen", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241421, name = "Ensemble: Ravensteel Mail", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241419, name = "Ensemble: Honorforged Valorplate", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241418, name = "Ensemble: Bloodforged Battleplate", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241417, name = "Ensemble: Nightforged Felplate", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241426, name = "Ensemble: Raiment of Night Eternal", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241423, name = "Ensemble: Guise of the Nightstalker", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241420, name = "Ensemble: Scalemail of Devouring Night", subtype = "ensemble", detailKey = "remixDungeon" },
            { itemId = 241586, name = "Ensemble: Regalia of Everburning Knowledge", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241582, name = "Ensemble: Vestments of the Purifier", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241578, name = "Ensemble: Legacy of Azj'aqir", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241574, name = "Ensemble: Vestment of Second Sight", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241570, name = "Ensemble: Garb of the Astral Warden", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241566, name = "Ensemble: Vestments of Enveloped Dissonance", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241562, name = "Ensemble: Doomblade Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241558, name = "Ensemble: Eagletalon Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241553, name = "Ensemble: Regalia of Shackled Elements", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241549, name = "Ensemble: Dreadwyrm Battleplate", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241545, name = "Ensemble: Battleplate of the Highlord", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241541, name = "Ensemble: Warplate of the Obsidian Aspect", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241537, name = "Ensemble: Regalia of the Arcane Tempest", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241533, name = "Ensemble: Vestments of Blind Absolution", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241529, name = "Ensemble: Diabolic Raiment", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241525, name = "Ensemble: Demonbane Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241521, name = "Ensemble: Stormheart Raiment", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241517, name = "Ensemble: Xuen's Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241513, name = "Ensemble: Fanged Slayer's Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241509, name = "Ensemble: Wildstalker Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241505, name = "Ensemble: Regalia of the Skybreaker", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241501, name = "Ensemble: Gravewarden Armaments", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241497, name = "Ensemble: Radiant Lightbringer Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241493, name = "Ensemble: Titanic Onslaught Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241489, name = "Ensemble: Runebound Regalia", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241485, name = "Ensemble: Gilded Seraph's Raiment", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241481, name = "Ensemble: Grim Inquisitor's Regalia", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241477, name = "Ensemble: Felreaper Vestments", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241473, name = "Ensemble: Bearmantle Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241469, name = "Ensemble: Chi-Ji's Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241465, name = "Ensemble: Regalia of the Dashing Scoundrel", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241461, name = "Ensemble: Serpentstalker Guise", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241459, name = "Ensemble: Garb of Venerated Spirits", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241453, name = "Ensemble: Dreadwake Armor", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241449, name = "Ensemble: Light's Vanguard Battleplate", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241445, name = "Ensemble: Juggernaut Battlegear", subtype = "ensemble", detailKey = "remixRaid" },
            { itemId = 241405, name = "Ensemble: Skyborne Brigandine", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241404, name = "Ensemble: Seaborne Brigandine", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241401, name = "Ensemble: Sunborne Runemail", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241398, name = "Ensemble: Earthbreaker Dragonscale", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241394, name = "Ensemble: Val'kyr's Warharness", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241393, name = "Ensemble: Winged Plate of the Valhalas Champion", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 241354, name = "Ensemble: Emerald Drake Hunter's Kit", subtype = "ensemble", detailKey = "remixLostFound" },
            { itemId = 235630, name = "Ensemble: Runespeaker Wraps", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 241591, name = "Ensemble: Legion Hunter's Capes", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 241590, name = "Ensemble: Stormborne Wraps", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242240, name = "Ensemble: Cloaks of the Green Mountains", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242234, name = "Ensemble: Dalaran's Finest Silken Cloaks", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242233, name = "Ensemble: Cloaks of Silken Knowledge", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242232, name = "Ensemble: Cloaks of the Ironskin Gladiator", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242231, name = "Ensemble: Cloaks of the Fel Battler", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242230, name = "Ensemble: Shrouds of the Lost Deathwyrms", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242229, name = "Ensemble: Druidic Fur Drapes", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242228, name = "Ensemble: Shrouds of Azj'Aqir", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 241593, name = "Ensemble: Cloaks of the Lost Gladiator", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 241592, name = "Ensemble: Cloaks of the Lost Combatant", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242235, name = "Ensemble: Drapes of Devouring Night", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242239, name = "Ensemble: Eredar Battle Capes", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242238, name = "Ensemble: Cloaks of the Antoran Guard", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242237, name = "Ensemble: Argussian Demonsbane Cloaks", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 242236, name = "Ensemble: Drapes of Eredar Finery", subtype = "ensemble", detailKey = "remixCloaks" },
            { itemId = 253343, name = "Ensemble: Sargerei Commander's Felscorned Regalia", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 257104, name = "Ensemble: Sargerei Commander's Voidscarred Regalia", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 257106, name = "Ensemble: Sargerei Commander's Lightbound Regalia", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 257105, name = "Ensemble: Sargerei Commander's Hellforged Regalia", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 241608, name = "Ensemble: Regalia of the Chosen Dead", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 241603, name = "Ensemble: Garb of the Chosen Dead", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 241599, name = "Ensemble: Chains of the Chosen Dead", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 241596, name = "Ensemble: Funerary Plate of the Chosen Dead", subtype = "ensemble", detailKey = "remixAchievements" },
            { itemId = 253344, name = "Kaldorei Queen's Sarong", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 253345, name = "Kaldorei Queen's Crown", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 253346, name = "Kaldorei Queen's Robe", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 253347, name = "Kaldorei Queen's Sash", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 253348, name = "Kaldorei Queen's Anklets", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 253349, name = "Kaldorei Queen's Bangles", subtype = "appearance", detailKey = "remixSuramar" },
            { itemId = 246793, name = "Sinister Feldirk", subtype = "appearance", detailKey = "remixStormheim" },
            { itemId = 246991, name = "Sinister Felstaff", subtype = "appearance", detailKey = "remixStormheim" },
            { itemId = 246786, name = "Sinister Felblade", subtype = "appearance", detailKey = "remixStormheim" },
            { itemId = 246997, name = "Sinister Felwand", subtype = "appearance", detailKey = "remixStormheim" },
            { itemId = 253231, name = "Fallen King's Corrupted Blades", subtype = "arsenal", detailKey = "remixBrokenShore" },
            { itemId = 253221, name = "Appearance: Bulwark of Mannoroth", subtype = "ensemble", detailKey = "remixArgus" },
            { itemId = 253285, name = "Felscorned Scythe of the Unmaker", subtype = "arsenal", detailKey = "remixMythicAntorus" },
            { itemId = 242368, name = "The First Satyr's Spaulders", subtype = "appearance", detailKey = "remixRareRaid" },
            { itemId = 151524, name = "Hammer of Vigilance", subtype = "appearance", detailKey = "remixRareRaid" },
            { itemId = 255006, name = "Taeshalach", subtype = "arsenal", detailKey = "remixRareRaid" },
            { itemId = 253273, name = "Scythe of the Unmaker", subtype = "arsenal", detailKey = "remixRareRaid" },
            { itemId = 253353, name = "Illusion: Felshatter", subtype = "illusion", illusionId = 98, detailKey = "remixFelshatter" },
        },
        cosmeticDetailGroups = {
            remixExclusive = { sourceType = "Legacy Event Vendor", source = "Unicus / Infinite Bazaar", acquisition = "During Legion Remix, buy the event-exclusive ensemble or arsenal from Unicus with Bronze after its phase became available.", tips = "Legion Remix ended January 19, 2026, so these rewards are currently unavailable. They were learn-on-use bundles; individual appearances inside them are intentionally not duplicated here.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixWorld = { sourceType = "Legacy Event Vendor", source = "Larah Treebender / Infinite Bazaar", acquisition = "During Legion Remix, buy the open-world or questing ensemble from Larah Treebender with Bronze.", tips = "The event has ended. Larah grouped appearances by their original Legion zone or outdoor source, but each listed record is the learn-on-use ensemble sold during Remix.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixDungeon = { sourceType = "Legacy Event Vendor", source = "Arturos / Infinite Bazaar", acquisition = "During Legion Remix, buy the dungeon appearance ensemble from Arturos with Bronze after the relevant phase unlocked.", tips = "The event has ended. Buying the ensemble taught the set directly; farming ordinary equippable dungeon drops is outside this Cosmetics category.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixRaid = { sourceType = "Legacy Event Vendor", source = "Pythagorus / Infinite Bazaar", acquisition = "During Legion Remix, buy the class raid ensemble from Pythagorus with Bronze after its raid phase became available.", tips = "Nighthold, Tomb of Sargeras, and Antorus ensembles unlocked in later event phases. The event has ended; individual raid gear pieces are omitted because the ensemble is the collectible container.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixLostFound = { sourceType = "Legacy Event Vendor", source = "Agos / Lost and Found Apparel", acquisition = "During Legion Remix, buy this otherwise-missed apparel ensemble from Agos in the Infinite Bazaar.", tips = "The event has ended. Agos was the dedicated source for incomplete or hard-to-place Legion appearance sets.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixCloaks = { sourceType = "Legacy Event Vendor", source = "Freddie Threads / Infinite Bazaar", acquisition = "During Legion Remix, buy the cloak ensemble from Freddie Threads with Bronze after its content phase unlocked.", tips = "The event has ended. Each ensemble teaches several matching cloak appearances, so its internal cloak item records are not repeated.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixAchievements = { sourceType = "Legacy Event Achievement", source = "Legion Remix campaign and raid achievements", acquisition = "Earn the matching Legion Remix achievement to receive the learn-on-use ensemble. The Sargerei tints came from campaign, Heroic world-quest, raid, and progression goals; Chosen Dead ensembles came from Trial of Valor objectives.", tips = "These were event-only achievement rewards and are currently unavailable. Remember to use the reward item from your bags after earning it.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixSuramar = { sourceType = "Legacy Event Achievement", source = "Suramar / Kaldorei Queen's Royal Vestments", acquisition = "Complete at least two of the four Suramar Timerunning objectives: campaign, zone tour, group content, or Exalted with The Nightfallen.", tips = "The achievement awarded six separate learn-on-use cosmetic pieces rather than one ensemble, so all six actual bag items are tracked. Legion Remix has ended.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixStormheim = { sourceType = "Legacy Event Achievement", source = "Stormheim / Sinister Fel Arsenal", acquisition = "Complete at least two of the four Stormheim Timerunning objectives: campaign, zone tour, group content, or Exalted with the Valarjar.", tips = "The achievement's cache produced four separate learn-on-use weapon cosmetics; the non-cosmetic cache itself is not tracked. Legion Remix has ended.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixBrokenShore = { sourceType = "Legacy Event Achievement", source = "The Broken Shore / Fallen King's Corrupted Blades", acquisition = "Complete at least three of the four Broken Shore Timerunning objectives to receive the learn-on-use Fallen King's Corrupted Blades bundle.", tips = "The bundle teaches the corrupted Shalla'tor, Ellemayne, and Shalamayne appearances. Their hidden component records are not duplicated. Legion Remix has ended.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixArgus = { sourceType = "Legacy Event Achievement", source = "Argus / Bulwark of Mannoroth", acquisition = "Complete at least two of the four Argus Timerunning objectives: campaign, zone tour, group content, or Exalted with the Argussian Reach.", tips = "The single reward wrapper teaches the matching shield and cloak looks, so those component appearances are not listed separately. Legion Remix has ended.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixMythicAntorus = { sourceType = "Legacy Event Achievement", source = "Mythic: Antorus, the Burning Throne", acquisition = "Defeat every Antorus boss on Mythic difficulty during Legion Remix to receive the Felscorned Scythe of the Unmaker appearance bundle.", tips = "The item had to be used from the bag. It teaches the Felscorned scythe variants and is now unavailable because Legion Remix has ended.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixRareRaid = { sourceType = "Legacy Event Vendor", source = "Pythagorus / rare raid appearances", acquisition = "During Legion Remix, trade 20 of the matching boss currency to Pythagorus: Horns of the First Satyr, Felwarped Slabs, Everflames of Hatred, or Cosmic Soulslivers.", tips = "Normal, Heroic, and Mythic kills awarded 1, 4, and 10 currency respectively. Taeshalach and Scythe of the Unmaker bundles include their added weapon-type variants. The event has ended, though some original appearances remain farmable in retail Legion raids.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
            remixFelshatter = { sourceType = "Legacy Event Achievement", source = "Val'sharah Timerunning meta", acquisition = "Complete at least two of the four Val'sharah Timerunning objectives to receive Illusion: Felshatter, then use the item to learn weapon illusion 98.", tips = "The objectives were the campaign, zone tour, group content, and Dreamweavers reputation. The event has ended; players who earned but deleted the bugged item were advised to check Item Restoration.", waypoints = LEGION_REMIX_BAZAAR_WAYPOINTS },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["11.2.7"] = {
        label = "Patch 11.2.7: The Warning",
        wowheadPatchId = 110207,
        sourceNotes = {
            "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
            "Cosmetics are limited to learn-on-use items. Ordinary Timewalking gear, Brawler's Guild shirts, housing decor, and every Trading Post reward are excluded.",
            "Shadowlands Timewalking records come from Collector Ta'steld's permanent rotation inventory; the Pandaren ensembles come from the level-50 heritage questline.",
        },
        sourceUrls = {
            overview = "https://www.wowhead.com/guide/the-war-within/patch-11-2-7-overview",
            shadowlandsTimewalking = "https://www.wowhead.com/guide/world-events/shadowlands-timewalking",
            timewalkingCosts = "https://www.wowhead.com/blue-tracker/news/eu/take-a-ride-on-turbulent-timeways-now-live-world-of-warcraft-blizzard-news-24242437",
            pandarenHeritage = "https://www.wowhead.com/guide/transmogrification/pandaren-heritage-armor",
        },
        mounts = {
            { spellId = 332482, name = "Bonecleaver's Skullboar" },
            { spellId = 1233516, name = "K'arroc Swiftwing" },
            { spellId = 1261668, name = "Bronze Wilderling" },
            { spellId = 1261671, name = "Bronze Aquilon" },
            { spellId = 1261677, name = "Bronze Corpsefly" },
            { spellId = 1261681, name = "Bronze Gravewing" },
            { spellId = 1262886, name = "Geargrinder Mk. 11" },
            { spellId = 1263369, name = "Skypaw Glimmerfur" },
            { spellId = 1263387, name = "Crimson Lupine" },
            { spellId = 1264621, name = "Brawlin' Bruno" },
            { spellId = 1264643, name = "Ballistic Bronco" },
            { spellId = 1264988, name = "Snowpaw Glimmerfur Prowler" },
        },
        pets = {},
        toys = {},
        cosmetics = {
            { itemId = 258527, name = "Greathammer of the Fallen Lightbringer", subtype = "appearance", detailKey = "slTimewalking2200" },
            { itemId = 258528, name = "Greathammer of the Righteous Lightbringer", subtype = "appearance", detailKey = "slTimewalking2200" },
            { itemId = 254845, name = "Hammer of the Fallen Lightbringer", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254844, name = "Hammer of the Righteous Lightbringer", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254866, name = "Progenitor's Fractured Smasher", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254861, name = "Sinstone Cleaver", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254857, name = "Maw Executioner's Guillotine", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254856, name = "Soul Harvester's Scythe", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254853, name = "Lance of the Architects", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254872, name = "Creator's Rod of Origin", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254858, name = "Crossbow of the First Ones", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254865, name = "Shell of the Forbidden Land", subtype = "appearance", detailKey = "slTimewalking1500" },
            { itemId = 254867, name = "Progenitor's Fix-It-Up", subtype = "appearance", detailKey = "slTimewalking1200" },
            { itemId = 254860, name = "Longsword of the First Ones", subtype = "appearance", detailKey = "slTimewalking1200" },
            { itemId = 254862, name = "Runeblade of the Maldraxxus Paragon", subtype = "appearance", detailKey = "slTimewalking1200" },
            { itemId = 254873, name = "Zerith Vibroblade", subtype = "appearance", detailKey = "slTimewalking1200" },
            { itemId = 258662, name = "Progenitor's Custodial Sentry", subtype = "appearance", detailKey = "slTimewalking1200" },
            { itemId = 254851, name = "Maw Stalker's Quiver", subtype = "appearance", detailKey = "slTimewalking600" },
            { itemId = 254852, name = "Spirit Marksman's Quiver", subtype = "appearance", detailKey = "slTimewalking600" },
            { itemId = 254864, name = "Oozeframe of the Mad Alchemist", subtype = "appearance", detailKey = "slTimewalking600" },
            { itemId = 254855, name = "Amice of the Dark Necromancer", subtype = "appearance", detailKey = "slTimewalking450" },
            { itemId = 254854, name = "Putrid Necromancer Mantle", subtype = "appearance", detailKey = "slTimewalking450" },
            { itemId = 258635, name = "Ensemble: Heritage of the Wandering Isle (Alliance)", subtype = "ensemble", detailKey = "pandarenHeritage" },
            { itemId = 258657, name = "Ensemble: Heritage of the Wandering Isle (Horde)", subtype = "ensemble", detailKey = "pandarenHeritage" },
        },
        cosmeticDetailGroups = {
            slTimewalking2200 = { sourceType = "Timewalking Vendor", source = "Collector Ta'steld / Oribos", acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 2,200 Timewarped Badges.", tips = "Collector Ta'steld appears only while Shadowlands Timewalking is active. The two greathammers are the most expensive appearance tokens in this inventory; ordinary equippable weapons sold nearby are not part of Cosmetics.", waypoints = SHADOWLANDS_TIMEWALKING_WAYPOINTS },
            slTimewalking1500 = { sourceType = "Timewalking Vendor", source = "Collector Ta'steld / Oribos", acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 1,500 Timewarped Badges.", tips = "Farm the event's first-dungeon quest and repeated Timewalking runs while the rotation is active. Use the token from your bags after purchase.", waypoints = SHADOWLANDS_TIMEWALKING_WAYPOINTS },
            slTimewalking1200 = { sourceType = "Timewalking Vendor", source = "Collector Ta'steld / Oribos", acquisition = "During Shadowlands Timewalking, buy this learn-on-use appearance from Collector Ta'steld for 1,200 Timewarped Badges.", tips = "The vendor is available only during Shadowlands Timewalking. Check the collection state before spending badges because the item is consumed on use.", waypoints = SHADOWLANDS_TIMEWALKING_WAYPOINTS },
            slTimewalking600 = { sourceType = "Timewalking Vendor", source = "Collector Ta'steld / Oribos", acquisition = "During Shadowlands Timewalking, buy this learn-on-use back appearance from Collector Ta'steld for 600 Timewarped Badges.", tips = "These are cosmetic quiver or back tokens, not wearable bag-slot items. Use the token after purchase.", waypoints = SHADOWLANDS_TIMEWALKING_WAYPOINTS },
            slTimewalking450 = { sourceType = "Timewalking Vendor", source = "Collector Ta'steld / Oribos", acquisition = "During Shadowlands Timewalking, buy this learn-on-use shoulder appearance from Collector Ta'steld for 450 Timewarped Badges.", tips = "Collector Ta'steld is present only for the Shadowlands rotation. These cosmetic tokens disappear after teaching the appearance.", waypoints = SHADOWLANDS_TIMEWALKING_WAYPOINTS },
            pandarenHeritage = { sourceType = "Heritage Questline", source = "A New Tradition / Pandaren Heritage", acquisition = "On a level-50 or higher Pandaren, begin Invitation to the Spirit Festival at your faction embassy and complete the heritage storyline through A New Tradition.", tips = "The questline takes roughly 25-60 minutes depending on dialogue and grouping. The reward teaches the faction-colored Tushui or Huojin set plus the neutral Wandering Isle tint; use the ensemble from your bags if it is not learned automatically.", waypoints = PANDAREN_HERITAGE_WAYPOINTS },
        },
        achievements = { ids = {}, rewardHighlights = {} },
    },
    ["12.0"] = {
        label = "Patch 12.0: Midnight Launch",
        wowheadPatchId = 120000,
        sourceNotes = {
            "Wowhead Added in Patch filters for base Midnight launch mounts and battle pets.",
            "Wowhead Midnight mount and pet guides for curated source notes.",
            "Wowhead Midnight transformation toy roundup and item comments for launch toy notes.",
            "Base achievement IDs use the reliable 12.0.1 launch filter slice to avoid unrelated embedded page data.",
            "Cosmetics include only consumable appearance unlocks, ensembles, and arsenals; equippable gear, Trading Post items, shop items, and promotional rewards are excluded.",
            "The launch list also includes Midnight's limited-time Twilight Ascension pre-patch bundles, the Abundance vendor cosmetics, the Bloodstains quest arsenal, and the full 12-item random delve appearance pool; internal component records taught by an ensemble or arsenal are not duplicated.",
        },
        sourceUrls = {
            mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120000",
            mountGuide = "https://www.wowhead.com/guide/collections/midnight-mounts-locations-appearances",
            mountCrossCheck = "https://www.icy-veins.com/wow/midnight-mounts-patch120",
            pets = "https://www.wowhead.com/battle-pets?filter=3;3;120000",
            petGuide = "https://www.wowhead.com/guide/collections/midnight-battle-pets-locations-sources",
            toys = "https://www.wowhead.com/news/midnight-transformation-toys-roundup-potatoads-pangos-and-saptors-381211",
            achievements = "https://www.wowhead.com/achievements?filter=17;3;120001",
            glyphs = "https://www.wowhead.com/achievement=61584/midnight-glyph-hunter",
            eversongTreasures = "https://www.wowhead.com/object=617432/forgotten-ink-and-quill",
            abundance = "https://www.method.gg/guides/abundance-midnight-event-and-vendor-rewards-guide",
            eversongRares = "https://www.method.gg/guides/a-bloody-song-eversong-woods-rares-and-locations",
            zulamanRares = "https://www.method.gg/guides/tallest-tree-in-the-forest-zul-aman-rare-locations",
            harandarRares = "https://www.method.gg/guides/leaf-none-behind-harandar-rare-locations",
            voidstormRares = "https://www.method.gg/guides/the-ultimate-predator-voidstorm-rare-locations",
            silvermoonCourt = "https://www.wowhead.com/guide/midnight/silvermoon-court-renown-reputation-farming-rewards",
            amaniTribe = "https://www.wowhead.com/guide/midnight/amani-tribe-renown-reputation-farming-rewards",
            harati = "https://www.wowhead.com/guide/midnight/harati-renown-reputation-farming-rewards",
            singularity = "https://www.wowhead.com/guide/midnight/the-singularity-renown-reputation-farming-rewards",
            prey = "https://www.wowhead.com/guide/midnight/prey-unlocking-hunts-rewards",
            delves = "https://www.wowhead.com/guide/midnight/delves-season-companion-nemesis-rewards-locations",
            delveCosmeticBag = "https://www.wowhead.com/item=263179/delvers-cosmetic-surprise-bag",
            worldEvents = "https://www.wowhead.com/guide/midnight/world-and-zone-events-locations-rewards",
            prepatch = "https://www.wowhead.com/guide/midnight/pre-patch-event-rewards-mounts-pets-decor-transmog",
            atalAmanArsenal = "https://www.wowhead.com/news/heirlooms-of-atalaman-a-call-back-to-the-burning-crusade-380870",
        },
        mounts = {
            { spellId = 1242904, itemId = 246590, name = "Ashes of Belo'ren" },
            { spellId = 1243003, itemId = 246594, name = "Light-Forged Mechsuit" },
            { spellId = 1243593, itemId = 246734, name = "Fierce Grimlynx" },
            { spellId = 1243597, itemId = 246735, name = "Rootstalker Grimlynx" },
            { spellId = 3363, itemId = 260916, name = "Nether-Swept Drake" },
            { spellId = 1251433, itemId = 250782, name = "Amani Sunfeather" },
            { spellId = 1251630, itemId = 250889, name = "Amani Windcaller" },
            { spellId = 1253927, itemId = 252012, name = "Vibrant Petalwing" },
            { spellId = 1253924, itemId = 252011, name = "Brilliant Petalwing" },
            { spellId = 1253929, itemId = 252014, name = "Cerulean Sporeglider" },
            { spellId = 1253938, itemId = 252017, name = "Ruddy Sporeglider" },
            { spellId = 1257058, itemId = 262620, name = "Calamitous Carrion" },
            { spellId = 1257081, itemId = 262621, name = "Convalescent Carrion" },
            { spellId = 1260354, itemId = 256423, name = "Untainted Grove Crawler" },
            { spellId = 1260356, itemId = 256424, name = "Echo of Aln'sharan" },
            { spellId = 1261155, itemId = 257085, name = "Augmented Stormray" },
            { spellId = 1261291, itemId = 257142, name = "Fiery Dragonhawk" },
            { spellId = 1261293, itemId = 257143, name = "Peridot Dragonhawk" },
            { spellId = 1261296, itemId = 257144, name = "Umbral Dragonhawk" },
            { spellId = 1261298, itemId = 257145, name = "Crimson Dragonhawk" },
            { spellId = 1261302, itemId = 257147, name = "Cobalt Dragonhawk" },
            { spellId = 1261316, itemId = 257152, name = "Amani Sharptalon" },
            { spellId = 1261322, itemId = 257154, name = "Crimson Silvermoon Hawkstrider" },
            { spellId = 1261323, itemId = 257156, name = "Cerulean Hawkstrider" },
            { spellId = 1261332, itemId = 257176, name = "Duskbrute Harrower" },
            { spellId = 1261336, itemId = 257191, name = "Preyseeker's Hubris" },
            { spellId = 1261337, itemId = 257192, name = "Preyseeker's Wrath" },
            { spellId = 1261338, itemId = 257193, name = "Preyseeker's Nightmare" },
            { spellId = 1261348, itemId = 257197, name = "Blessed Amani Burrower" },
            { spellId = 1261349, itemId = 257199, name = "Giganto Manis" },
            { spellId = 1261351, itemId = 257200, name = "Escaped Witherbark Pango" },
            { spellId = 1261357, itemId = 257219, name = "Amani Blessed Bear" },
            { spellId = 1261360, itemId = 257223, name = "Ancestral War Bear" },
            { spellId = 1261391, itemId = 257240, name = "Relinquished Scarlet Charger" },
            { spellId = 1261576, itemId = 257444, name = "Hexed Vilefeather Eagle" },
            { spellId = 1261579, itemId = 257445, name = "Ravenous Shredclaw" },
            { spellId = 1261583, itemId = 257446, name = "Insatiable Shredclaw" },
            { spellId = 1261584, itemId = 257447, name = "Prowling Shredclaw" },
            { spellId = 1261585, itemId = 257448, name = "Frenzied Shredclaw" },
            { spellId = 1261629, itemId = 257502, name = "Vicious Snaplizard" },
            { spellId = 1261648, itemId = 257504, name = "Vicious Snaplizard" },
            { spellId = 1262840, itemId = 260228, name = "Galactic Gladiator's Goredrake" },
            { spellId = 1265784, itemId = 260231, name = "Lucent Hawkstrider" },
            { spellId = 1263635, itemId = 262914, name = "Spectral Hawkstrider" },
            { spellId = 1266700, itemId = 260635, name = "Sanguine Harrower" },
            { spellId = 1266702, itemId = 260696, name = "Voidbound Stormray" },
            { spellId = 1266703, itemId = 260697, name = "Lab-Grown Stormray" },
            { spellId = 1266980, itemId = 260887, name = "Tenebrous Harrower" },
            { spellId = 1268924, itemId = 262500, name = "Silvermoon's Arcane Defender" },
            { spellId = 1268926, itemId = 262502, name = "Elven Arcane Guardian" },
            { spellId = 1268949, itemId = 263222, name = "Arcanovoid Construct" },
            { spellId = 1270675, itemId = 263580, name = "Vivid Chloroceros" },
            { spellId = 1270673, itemId = 263579, name = "Vivacious Chloroceros" },
            { spellId = 1276650, itemId = 265656, name = "Anu'shalla, Shadow's Guidance" },
            { spellId = 1243598, itemId = 246736, name = "Ivory Grimlynx" },
            { spellId = 447173, itemId = 222988, name = "Elder Glowmite" },
            { spellId = 451487, itemId = 224148, name = "Retrained Skyrazor" },
        },
        pets = {
            { speciesId = 4891, npcId = 250573, name = "Wrathful Wyrm" },
            { speciesId = 4892, npcId = 250680, name = "Riftblade Familiar" },
            { speciesId = 4876, npcId = 249816, name = "Mud Potadpole" },
            { speciesId = 4884, npcId = 249825, name = "Pangolil" },
            { speciesId = 4912, npcId = 254885, name = "Silvermoon Broom" },
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
            { speciesId = 4497, npcId = 222077, name = "Waddles" },
            { speciesId = 3364, npcId = 192368, name = "Striped Snakebiter" },
            { speciesId = 5012, npcId = 260899, name = "Sootpaw" },
        },
        toys = {
            { itemId = 252265, name = "Hexed Potatoad Mucus", source = "Atal'Aman delve Sturdy Chest", acquisition = "Loot one-time Sturdy Chests inside the Atal'Aman delve; comments point to a chest near the Restoration Stone in the Toadly Unbecoming variant." },
            { itemId = 251903, name = "Potatoad Egg", source = "The Blinding Vale dungeon secret", acquisition = "Get Hexed Potatoad Mucus first, enter The Blinding Vale, reach the lower river path before Ziekket, use the mucus to transform, then interact with Gravid Potatoad." },
            { itemId = 268717, name = "Pango Plating", source = "Treasures of Zul'Aman achievement", acquisition = "Complete Treasures of Zul'Aman. Wowhead comments note Abandoned Ritual Skull was removed from the requirement after March 5." },
            { itemId = 256552, name = "Verdant Rutaani Seed", source = "Hara'ti Renown vendor", acquisition = "Reach Renown 13 with the Hara'ti, then buy it from Naynar in Harandar." },
            { itemId = 268728, name = "Saptor Salve", source = "The Blinding Vale dungeon", acquisition = "Drops from Ziekket on Mythic difficulty; comments say it also became obtainable through Mythic+ once The Blinding Vale entered the Season 2 rotation." },
        },
        cosmetics = {
            { itemId = 248218, name = "Arsenal: Weathered Twilight's Hammer Armaments", subtype = "arsenal", detailKey = "twilightAscension" },
            { itemId = 249438, name = "Ensemble: Well-Worn Twilight Cultist's Attire", subtype = "ensemble", detailKey = "twilightAscension" },
            { itemId = 262582, name = "Amani Gem Clamps", subtype = "appearance", detailKey = "abundance" },
            { itemId = 262579, name = "Amani Hide Cutter", subtype = "appearance", detailKey = "abundance" },
            { itemId = 262580, name = "Amani Log Splitter", subtype = "appearance", detailKey = "abundance" },
            { itemId = 262581, name = "Amani Rock Hammer", subtype = "appearance", detailKey = "abundance" },
            { itemId = 262578, name = "Amani Stonework Chisel", subtype = "appearance", detailKey = "abundance" },
            { itemId = 266970, name = "Ensemble: Abundant Raiment", subtype = "ensemble", detailKey = "abundance" },
            { itemId = 264184, name = "Arsenal: Heirlooms of Atal'Aman", subtype = "arsenal", detailKey = "atalAmanQuest" },
            { itemId = 259028, name = "Ensemble: Haven's Elegant Regalia", subtype = "ensemble", detailKey = "silvermoonCourt" },
            { itemId = 265658, name = "Silvermoon Court Cloak", subtype = "appearance", detailKey = "silvermoonCourt" },
            { itemId = 265663, name = "Silvermoon Court Tabard", subtype = "appearance", detailKey = "silvermoonCourt" },
            { itemId = 259082, name = "Ensemble: Haven Dignitary's Trappings", subtype = "ensemble", detailKey = "silvermoonCourt" },
            { itemId = 265659, name = "Silvermoon Court Epaulets", subtype = "appearance", detailKey = "silvermoonCourt" },
            { itemId = 259091, name = "Ensemble: Haven Socialite's Attire", subtype = "ensemble", detailKey = "silvermoonCourt" },
            { itemId = 259027, name = "Ensemble: Blood Knight's Elegant Regalia", subtype = "ensemble", detailKey = "bloodKnights" },
            { itemId = 259081, name = "Ensemble: Blood Knight Dignitary's Trappings", subtype = "ensemble", detailKey = "bloodKnights" },
            { itemId = 259088, name = "Ensemble: Blood Knight Socialite's Attire", subtype = "ensemble", detailKey = "bloodKnights" },
            { itemId = 265997, name = "Blood Knight Champion's Tabard", subtype = "appearance", detailKey = "bloodKnights" },
            { itemId = 264907, name = "Blood Knight Recruit's Shield", subtype = "appearance", detailKey = "bloodKnights" },
            { itemId = 259076, name = "Ensemble: Farstrider's Elegant Regalia", subtype = "ensemble", detailKey = "farstriders" },
            { itemId = 259079, name = "Ensemble: Farstrider Dignitary's Trappings", subtype = "ensemble", detailKey = "farstriders" },
            { itemId = 259090, name = "Ensemble: Farstrider Socialite's Attire", subtype = "ensemble", detailKey = "farstriders" },
            { itemId = 264997, name = "Farstriders Quiver", subtype = "appearance", detailKey = "farstriders" },
            { itemId = 259074, name = "Ensemble: Magister's Elegant Regalia", subtype = "ensemble", detailKey = "magisters" },
            { itemId = 259080, name = "Ensemble: Magister Dignitary's Trappings", subtype = "ensemble", detailKey = "magisters" },
            { itemId = 259089, name = "Ensemble: Magister Socialite's Attire", subtype = "ensemble", detailKey = "magisters" },
            { itemId = 259075, name = "Ensemble: Pilfered Elegant Regalia", subtype = "ensemble", detailKey = "shades" },
            { itemId = 259083, name = "Ensemble: Pilfered Dignitary's Trappings", subtype = "ensemble", detailKey = "shades" },
            { itemId = 259087, name = "Ensemble: Pilfered Socialite's Attire", subtype = "ensemble", detailKey = "shades" },
            { itemId = 264996, name = "Gilded Sunlance", subtype = "appearance", detailKey = "shades" },
            { itemId = 250799, name = "Loa-Blessed Cloak", subtype = "appearance", detailKey = "amani" },
            { itemId = 250800, name = "Loa-Blessed Tabard", subtype = "appearance", detailKey = "amani" },
            { itemId = 250801, name = "Loa-Blessed Shoulderguards", subtype = "appearance", detailKey = "amani" },
            { itemId = 250855, name = "Crown of the Loa-Speaker", subtype = "appearance", detailKey = "amani" },
            { itemId = 256613, name = "Cloak of the Hara'ti Elder", subtype = "appearance", detailKey = "harati" },
            { itemId = 267257, name = "Cloak of the Hara'ti Sage", subtype = "appearance", detailKey = "harati" },
            { itemId = 267258, name = "Cloak of the Hara'ti Seer", subtype = "appearance", detailKey = "harati" },
            { itemId = 256615, name = "Tabard of the Hara'ti Elder", subtype = "appearance", detailKey = "harati" },
            { itemId = 267261, name = "Tabard of the Hara'ti Sage", subtype = "appearance", detailKey = "harati" },
            { itemId = 267262, name = "Tabard of the Hara'ti Seer", subtype = "appearance", detailKey = "harati" },
            { itemId = 256614, name = "Shoulderguards of the Hara'ti Elder", subtype = "appearance", detailKey = "harati" },
            { itemId = 267259, name = "Shoulderguards of the Hara'ti Sage", subtype = "appearance", detailKey = "harati" },
            { itemId = 267260, name = "Shoulderguards of the Hara'ti Seer", subtype = "appearance", detailKey = "harati" },
            { itemId = 259073, name = "Arsenal: Arms of the Hara'ti", subtype = "arsenal", detailKey = "harati" },
            { itemId = 258010, name = "Ensemble: Hara'ti Rootdancer's Garb", subtype = "ensemble", detailKey = "harati" },
            { itemId = 258012, name = "Ensemble: Hara'ti Rootwarden's Wear", subtype = "ensemble", detailKey = "harati" },
            { itemId = 258013, name = "Ensemble: Hara'ti Scout's Outfit", subtype = "ensemble", detailKey = "harati" },
            { itemId = 258014, name = "Ensemble: Hara'ti Guardian's Armor", subtype = "ensemble", detailKey = "harati" },
            { itemId = 263723, name = "Shawl of the Gilded Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266979, name = "Shawl of the Darkened Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266984, name = "Shawl of the Nebulous Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 263572, name = "Tabard of the Gilded Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266981, name = "Tabard of the Darkened Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266982, name = "Tabard of the Nebulous Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 263573, name = "Pauldrons of the Gilded Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266980, name = "Pauldrons of the Darkened Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 266983, name = "Pauldrons of the Nebulous Collapsed Star", subtype = "appearance", detailKey = "singularity" },
            { itemId = 258022, name = "Skilled Preyseeker's Plumed Helm", subtype = "appearance", detailKey = "prey" },
            { itemId = 258024, name = "Skilled Preyseeker's Shoulder-Spikes", subtype = "appearance", detailKey = "prey" },
            { itemId = 258023, name = "Skilled Preyseeker's Knapsack", subtype = "appearance", detailKey = "prey" },
            { itemId = 258028, name = "Famed Preyseeker's Plumed Helm", subtype = "appearance", detailKey = "prey" },
            { itemId = 258026, name = "Famed Preyseeker's Shoulder-Spikes", subtype = "appearance", detailKey = "prey" },
            { itemId = 258030, name = "Famed Preyseeker's Knapsack", subtype = "appearance", detailKey = "prey" },
            { itemId = 266196, name = "Ensemble: Preyseeker's Refined Armor", subtype = "ensemble", detailKey = "prey" },
            { itemId = 266197, name = "Ensemble: Preyseeker's Sleek Armor", subtype = "ensemble", detailKey = "prey" },
            { itemId = 266198, name = "Ensemble: Preyseeker's Rugged Armor", subtype = "ensemble", detailKey = "prey" },
            { itemId = 266199, name = "Ensemble: Preyseeker's Polished Armor", subtype = "ensemble", detailKey = "prey" },
            { itemId = 278241, name = "Arsenal: Preyseeker's Lost Armaments", subtype = "arsenal", detailKey = "prey" },
            { itemId = 263574, name = "Ensemble: Osseoclad's Wear", subtype = "ensemble", detailKey = "delves" },
            { itemId = 263575, name = "Ensemble: Elder Moss Outfit", subtype = "ensemble", detailKey = "delves" },
            { itemId = 263576, name = "Ensemble: Rampant Thorn Armor", subtype = "ensemble", detailKey = "delves" },
            { itemId = 263577, name = "Arsenal: Rootlands Weaponry", subtype = "arsenal", detailKey = "delves" },
            { itemId = 262983, name = "Archival Magnimace", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264847, name = "Dozing Vinepouch", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264857, name = "Twilight Fanatic's Cowl", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264854, name = "Vilebranch Soulseer", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 263442, name = "Voidridden Domaneye", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 262970, name = "Ominous Tome", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 262991, name = "Two Thousand and Two Nights", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264852, name = "Bladed Twilight Spaulder", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264859, name = "Twilight Follower's Cowl", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264855, name = "Vilebranch Deathseer", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264851, name = "Voidtouched Twilight Spaulder", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264848, name = "Sunlit Vinepouch", subtype = "appearance", detailKey = "delveDrops" },
            { itemId = 264860, name = "Twilight Magus's Cowl", subtype = "appearance", detailKey = "delves" },
            { itemId = 264856, name = "Vilebranch Lifeseer", subtype = "appearance", detailKey = "delves" },
            { itemId = 264853, name = "Gilded Twilight Spaulder", subtype = "appearance", detailKey = "delves" },
            { itemId = 264849, name = "Dewy Vinepouch", subtype = "appearance", detailKey = "delves" },
            { itemId = 262989, name = "Focusight Relic Mace", subtype = "appearance", detailKey = "telemancer" },
            { itemId = 262973, name = "Reliquary Expedition Notes", subtype = "appearance", detailKey = "telemancer" },
            { itemId = 262984, name = "Reliquary Expedition Bag", subtype = "appearance", detailKey = "telemancer" },
            { itemId = 262990, name = "Sin'dorei Arcane Manuscript", subtype = "appearance", detailKey = "telemancer" },
        },
        cosmeticDetailGroups = {
            twilightAscension = { sourceType = "Limited-Time Event Vendor", source = "Materialist Ophinell / Twilight Ascension", acquisition = "During the Midnight pre-patch event, buy the arsenal or ensemble from Materialist Ophinell for 40 Twilight's Blade Insignia.", tips = "The Twilight Ascension event ended when Midnight launched on March 2, 2026. These two appearance bundles were event-exclusive; the nearby catch-up armor and weapons were equippable gear and are not part of this Cosmetics list.", waypoints = TWILIGHT_ASCENSION_WAYPOINTS },
            abundance = { sourceType = "World Event Vendor", source = "Chel the Chip / Abundance", acquisition = "Earn Unalloyed Abundance from an empowered Abundant Harvest, then buy the appearance from Chel the Chip at any Abundance entrance.", tips = "Each weapon appearance costs 800 Unalloyed Abundance and Ensemble: Abundant Raiment costs 3200. The empowered cavern rotates every 8 hours; offer a Shard of Dundun before harvesting so the run awards currency.", waypoints = ABUNDANCE_WAYPOINTS },
            atalAmanQuest = { sourceType = "Questline", source = "Bloodstains / In Their Own Blood", acquisition = "Finish the six-quest Bloodstains storyline in Zul'Aman. The final quest, In Their Own Blood, rewards Arsenal: Heirlooms of Atal'Aman and teaches eight weapon appearances.", tips = "Start with Personal History from Zul'jarra in Amani'Zar Village after advancing the Zul'Aman campaign through De Legend of de Hash'ey. Inside Atal'Aman, standing on a marked loa sigil grants the extra-action button; the Lynx Loa avatar near 34.4, 25.5 is a quick option.", waypoints = ATAL_AMAN_QUEST_WAYPOINTS },
            silvermoonCourt = { sourceType = "Renown Vendor", source = "Caeris Fairdawn / Silvermoon Court", acquisition = "Unlock through Silvermoon Court Renown, then buy from Caeris Fairdawn at Saltheril's Haven.", tips = "The launch appearances unlock across Renown 2, 10, 14, 16, and 20. Check the item's tooltip before spending if you are comparing the three Haven outfit tiers.", waypoints = SILVERMOON_COURT_WAYPOINTS },
            bloodKnights = { sourceType = "Court Subfaction", source = "Blood Knights / Saltheril's Haven", acquisition = "Raise Blood Knights friendship through Silvermoon Court activities, then buy the unlocked cosmetic from their representative at Saltheril's Haven.", tips = "Elegant, Dignitary, and Socialite ensembles unlock at Guest, Trendsetter, and Luminary; the tabard unlocks at Host and the shield at Luminary.", waypoints = SILVERMOON_COURT_WAYPOINTS },
            farstriders = { sourceType = "Court Subfaction", source = "Farstriders / Saltheril's Haven", acquisition = "Raise Farstriders friendship through Silvermoon Court activities, then buy the unlocked cosmetic at Saltheril's Haven.", tips = "The three outfit tiers unlock at Guest, Trendsetter, and Luminary; Farstriders Quiver also unlocks at Luminary.", waypoints = SILVERMOON_COURT_WAYPOINTS },
            magisters = { sourceType = "Court Subfaction", source = "Magisters / Saltheril's Haven", acquisition = "Raise Magisters friendship through Silvermoon Court activities, then buy the unlocked ensemble at Saltheril's Haven.", tips = "The three outfit tiers unlock at Guest, Trendsetter, and Luminary.", waypoints = SILVERMOON_COURT_WAYPOINTS },
            shades = { sourceType = "Court Subfaction", source = "Shades of the Row / Saltheril's Haven", acquisition = "Raise Shades of the Row friendship through Silvermoon Court activities, then buy the unlocked cosmetic at Saltheril's Haven.", tips = "The three outfit tiers unlock at Guest, Trendsetter, and Luminary; Gilded Sunlance is a Luminary reward.", waypoints = SILVERMOON_COURT_WAYPOINTS },
            amani = { sourceType = "Renown Vendor", source = "Magovu / Amani Tribe", acquisition = "Raise Amani Tribe Renown, then buy the unlocked cosmetic from Magovu.", tips = "The cloak, tabard, shoulders, and crown unlock at Renown 2, 10, 16, and 20 respectively.", waypoints = AMANI_TRIBE_WAYPOINTS },
            harati = { sourceType = "Renown Vendor", source = "Naynar / Hara'ti", acquisition = "Raise Hara'ti Renown, then buy the unlocked cosmetic from Naynar in Harandar.", tips = "Cloaks unlock at Renown 2, tabards at 10, shoulders and the arsenal at 17, and the four armor ensembles at 20.", waypoints = HARATI_WAYPOINTS },
            singularity = { sourceType = "Renown Vendor", source = "Void Researcher Anomander / The Singularity", acquisition = "Raise The Singularity Renown, then buy the unlocked cosmetic from Void Researcher Anomander in Voidstorm.", tips = "The three shawls unlock at Renown 4, tabards at 10, and pauldrons at 15.", waypoints = SINGULARITY_WAYPOINTS },
            prey = { sourceType = "Prey Season 1", source = "Preyhunter's Journey / Construct E'nui", acquisition = "These were Midnight Season 1 Preyhunter's Journey rewards. Check Construct E'nui in Astalor's Sanctum for past-season purchases; the Skilled Knapsack originally came from the Precious Jewels quest.", tips = "The original rank rewards used Remnants of Anguish. Season 1 is over, so availability now depends on the past-season vendor inventory.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
            delves = { sourceType = "Delve Vendor", source = "Naleidea Rivergleam", acquisition = "Buy this learn-on-use appearance, ensemble, or arsenal from Naleidea Rivergleam with Undercoin at Delver's Headquarters.", tips = "Use the item from your bags after purchase. Ensembles and arsenals teach every included appearance rather than equipping as gear.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
            delveDrops = { sourceType = "Delve Drop", source = "Midnight delve treasure rooms / Delver's Cosmetic Surprise Bag", acquisition = "Loot this random learn-on-use appearance from Midnight delve treasure-room chests. Telemancer Astrandis also offers one free Delver's Cosmetic Surprise Bag per warband during the seasonal introduction; it selects an unlearned delve collectible when possible.", tips = "Run quick lower-tier delves if you only want the cosmetic pool; player reports confirm these can appear in ordinary, bountiful, and nemesis treasure chests. The one-time surprise bag is duplicate-aware, so claim it before spending time farming the last missing appearance.", waypoints = MIDNIGHT_DELVE_DROP_WAYPOINTS },
            telemancer = { sourceType = "Delve Vendor", source = "Telemancer Astrandis", acquisition = "Buy or unlock this learn-on-use appearance through Telemancer Astrandis at Delver's Headquarters.", tips = "Check the live vendor requirement before farming because seasonal Journey gating and past-season availability can change.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        },
        achievements = {
            ids = {
                62273, 62288, 62289, 62290, 62291, 62324, 62325, 62326, 62329, 62330, 62331,
                62332, 62333, 62336, 62337, 62338, 62339, 62340, 62341, 62342, 62343, 62351, 62352, 62357, 62358, 62359, 62360,
                62361, 62362, 62363, 62364, 62365, 62366, 62369, 62370, 62371, 62373, 62374, 62375, 62376, 62377, 62378, 62383,
                62385, 62386, 62388, 62400, 62403, 62406, 62493, 62494, 62514, 62516, 62517,
            },
            rewardHighlights = {
                { achievementId = 62386, name = "Light Up the Night", reward = "Mount: Brilliant Petalwing" },
                { achievementId = 62385, name = "Staring Into The Void", reward = "Mount: Lab-Grown Stormray" },
                { achievementId = 62403, name = "'Tis But A Scratch", reward = "Achievement reward noted in Midnight launch data" },
            },
        },
    },
    ["12.0.5"] = {
        label = "Patch 12.0.5: Lingering Shadows",
        wowheadPatchId = 120005,
        sourceNotes = {
            "Wowhead activity, mount, pet, Decor Duels, and Abyss Anglers guides were cross-checked against live item pages for sources, costs, routes, and item type.",
            "Four Ritual Site curios were removed from the Toys list because they are usable or flavor items, not Toy Box collectibles; their relevant secret use remains documented under the pet that needs it.",
            "Promotion, shop, and expired-event rewards are labeled explicitly so unavailable sources are not mistaken for active world drops.",
            "The Cosmetics list tracks the learn-on-use Lost Armament items and confirmed Decor Duel appearance tokens, not their random pouch containers or ordinary equippable weapons.",
        },
        sourceUrls = {
            overview = "https://www.wowhead.com/guide/midnight/patch-12-0-5-overview-features-activities-rewards",
            voidAssaults = "https://www.wowhead.com/guide/midnight/void-assaults-strikes-incursions-rewards",
            ritualSites = "https://www.wowhead.com/guide/midnight/ritual-sites-challenges-locations-rewards",
            mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120005",
            mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-0-5-models-locations",
            mountCrossCheck = "https://www.warcraftmounts.com/patch12.0.5.php",
            pets = "https://www.wowhead.com/battle-pets?filter=3;3;120005",
            petGuide = "https://www.wowhead.com/guide/collections/midnight-battle-pets-locations-sources",
            achievements = "https://www.wowhead.com/guide/midnight/void-assaults-strikes-incursions-rewards#void-assaults-achievements",
            decorDuels = "https://www.wowhead.com/guide/midnight/decor-duels-objectives-kits-rewards",
            decorDuelsRemoval = "https://www.wowhead.com/news/decor-duels-no-longer-available-in-patch-12-1-double-currency-how-382221",
            abyssAnglers = "https://www.wowhead.com/guide/midnight/abyss-anglers-location-dives-rewards",
            liveRewards = "https://blizzardwatch.com/2026/05/26/rewards-available-void-assaults/",
            childrensWeek = "https://www.wowhead.com/news/new-nap-mat-toy-from-childrens-week-381407",
            arboonShop = "https://news.blizzard.com/en-us/article/24276748/shop-azeroth-blossoms-anew-choose-your-blooming-arboon-mount",
            lostArmaments = "https://www.wowhead.com/news/buy-lost-armament-transmogs-for-dark-particles-in-patch-12-0-7-381740",
        },
        mounts = {
            { spellId = 1261362, itemId = 257225, name = "Witherbark Warbear Mother" },
            { spellId = 1266982, itemId = 269659, name = "The Sire's Palanquin" },
            { spellId = 1267077, itemId = 262344, name = "Scarlet Lady" },
            { spellId = 1271698, itemId = 264348, name = "Unbound Manawyrm" },
            { spellId = 1282268, itemId = 268360, name = "Gilnean Iron Charger" },
            { spellId = 1282274, itemId = 268362, name = "Gilnean Copper Charger" },
            { spellId = 1282275, itemId = 268363, name = "Pyrewood Rebel's Rouncey" },
            { spellId = 1282276, itemId = 268364, name = "Gilneas Loyalist's Rouncey" },
            { spellId = 1282450, itemId = 268472, name = "Blossomback Arboon" },
            { spellId = 1282453, itemId = 268474, name = "Amberback Arboon" },
            { spellId = 1282471, itemId = 268481, name = "Breaker Bee" },
            { spellId = 1282936, itemId = 268578, name = "Void-Corrupted Hawkstrider" },
            { spellId = 1283837, itemId = 268833, name = "Zothwing Darkseeker" },
            { spellId = 1283838, itemId = 268834, name = "Zothwing Deepseeker" },
            { spellId = 1283906, itemId = 268878, name = "[PH] Giant Eagle Sunwalker Mount Blue" },
            { spellId = 1283908, itemId = 268877, name = "Dusk-Painted Sun Roc" },
            { spellId = 1283910, itemId = 268876, name = "Flame-Painted Sun Roc" },
            { spellId = 1283911, itemId = 268875, name = "[PH] Giant Eagle Sunwalker Mount White" },
            { spellId = 1284679, itemId = 269012, name = "Sha-Warped Riding Wolf" },
            { spellId = 1285897, itemId = 269640, name = "Sha-Warped Owl" },
            { spellId = 1286606, itemId = 269828, name = "Void-Corrupted Hex Eagle" },
            { spellId = 1287357, itemId = 270041, name = "Void-Touched Snapdragon" },
            { spellId = 1287359, itemId = 270058, name = "Void-Corrupted Lynx" },
            { spellId = 1296731, itemId = 275440, name = "Cerulean Deathwalker" },
            { spellId = 1296734, itemId = 275442, name = "Amethyst Mechsuit" },
            { spellId = 1296756, itemId = 275444, name = "Blue-Chip Shreddertank" },
            { spellId = 1296758, itemId = 275445, name = "Profit-Green Shreddertank" },
            { spellId = 1296759, itemId = 275446, name = "High-Yield Shreddertank" },
            { spellId = 1296760, itemId = 275447, name = "Speculative Shreddertank" },
        },
        pets = {
            { speciesId = 5023, npcId = 262092, name = "Void-Touched Lynx Kitten" },
            { speciesId = 5038, npcId = 262786, name = "Wriggling Capybara" },
            { speciesId = 5017, npcId = 261676, name = "Void-Scarred Eaglet" },
            { speciesId = 5040, npcId = 262788, name = "Curious Lynx Kitten" },
            { speciesId = 5039, npcId = 262787, name = "Cappy" },
            { speciesId = 5019, npcId = 261684, name = "Chubs" },
            { speciesId = 5022, npcId = 262090, name = "Void-Touched Chick" },
            { speciesId = 5021, npcId = 262089, name = "Void-Corrupted Snapdragon" },
            { speciesId = 5020, npcId = 262066, name = "Overloaded Manaling" },
            { speciesId = 5037, npcId = 262427, name = "Void-Infused Mindbreaker Fry" },
            { speciesId = 5036, npcId = 262422, name = "Rescued Dragonhawk Chick" },
            { speciesId = 5065, npcId = 264933, name = "Ka'bubb" },
            { speciesId = 5042, npcId = 263232, name = "The Sire's Ghastly Screecher" },
            { speciesId = 5060, npcId = 264163, name = "Sha-Warped Hippogryph Hatchling" },
        },
        toys = {
            { itemId = 268455, name = "Enchanted Hourglass" },
            { itemId = 268456, name = "Animated Bench" },
            { itemId = 272287, name = "Nap Mat" },
        },
        cosmetics = {
            { itemId = 270997, name = "Blood Oath Tome", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271024, name = "Diseased Piranha Fetish", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270998, name = "Fetish of the Vanquished Foe", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270995, name = "Sin'dorei Crystal Focus", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271048, name = "Wriggling Tentacle Fetish", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270992, name = "Amani Hex Crest", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270994, name = "Deepsea Behemoth Scale", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270996, name = "Hex-Horn Buckler", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270991, name = "Sunfury Great Bulwark", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270993, name = "Twilight Blade Barrier", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271013, name = "Adherent's Wriggling Backstabber", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271008, name = "Cultist's Sacrificial Kris", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271009, name = "Daggerspine Trident Tine", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271012, name = "Forest Tiki Twinblade", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271011, name = "Frostdeep Spider's Fang", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271010, name = "Glistening Sin'dorei Twinblade", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271007, name = "Twilight Ritualist's Stiletto", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271014, name = "Twilight Scout's Sticher", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271015, name = "Deep Fathom Claw", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271016, name = "Golden Phoenix's Beak", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 270999, name = "Forest Berserker's Hatchet", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271000, name = "Twilight Gut Ripper", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271018, name = "Deepcrawler Pincher", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271021, name = "Loa Battle Font", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271020, name = "Phoenix Wing Basher", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271022, name = "Ritual Overseer's Mace", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271019, name = "Sin'dorei Magister's Gavel", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271023, name = "Swingable Piranha", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271041, name = "Blade of the Deeplurk Honorguard", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271039, name = "Curved Blade of the Drained Loa", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271042, name = "Myrmidon's Cutlass", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271038, name = "Ornate Blade of the Royal Guard", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271040, name = "Twilight Captain's Short Sword", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271043, name = "Twilight Assassin's Glaive", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271028, name = "Amani War Spear", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271027, name = "Deeplurk Battle Trident", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271026, name = "Deeplurk Myrmidon's Trident", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 272144, name = "Onyx Bloodknight Bladestaff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271034, name = "Ritual Overseer's Polestaff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271037, name = "Battle Shaman's Ritual Staff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271035, name = "Deeplurk Sorceress' Stave", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271029, name = "Fathom-Coral Lightstaff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271036, name = "Forest Shaman's Voodoo Staff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271030, name = "Living Stave of the Deepdweller", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271031, name = "Onyx Bloodknight Stave", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271033, name = "Skull-Bearer's Ritual Stave", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271032, name = "Tiki-Bearer's Ritual Staff", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271001, name = "Greataxe of the Forest Tribe", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271002, name = "Twilight Berserker's Cleaver", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271025, name = "Twilight Guardian's Maul", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271004, name = "Deepcrawler Recurve Bow", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271006, name = "Forest Stalker's Bow", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271003, name = "Sunfury Phoenix Bow", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271005, name = "Violet Thalassian Greatbow", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271017, name = "Twilight Slug Belcher", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271045, name = "Crystal Focus Spellslinger", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271044, name = "Deeplurk Shock Wand", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271046, name = "Voodoo Hex Stick", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271047, name = "Spell-Infused Wriggling Tentacles", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 271049, name = "Ritual Weaver's Spellstick", subtype = "appearance", detailKey = "lostArmament" },
            { itemId = 272317, name = "Spellbreaker's Phoenixglaive", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272318, name = "Spellbreaker's Phoenixblade", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272338, name = "Mage Guard's Spellsteel", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272337, name = "Mage Guard's Spellblade", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272321, name = "Arcane Ranger's Spellbow", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272320, name = "Nullbeacon Rift Channeler", subtype = "appearance", detailKey = "decorDuels" },
            { itemId = 272336, name = "Nullbeacon Rift Smasher", subtype = "appearance", detailKey = "decorDuels" },
        },
        cosmeticDetailGroups = {
            lostArmament = { sourceType = "Void Assault / Ritual Site", source = "Field Pouches / Cosmetic Equipment Salvager", acquisition = "Obtain the learn-on-use item as a very rare Field Pouch reward from Void Assaults and Ritual Sites. Since Patch 12.0.7, the Cosmetic Equipment Salvager in Silvermoon sells weapon-family Bulging Field Pouches for 150 Dark Particles.", tips = "The purchasable pouch narrows the random roll to an Amani, Elven, Naga, or Twilight weapon pool. It is only a container; this listed item is the collectible consumed to teach the appearance.", waypoints = LOST_ARMAMENT_WAYPOINTS },
            decorDuels = { sourceType = "Decor Duel Vendor", source = "Gamesmaster Fleurian", acquisition = "During Decor Duels, earn Illusionary Coins from matches and the Ephemeron Masquerade daily, then buy this learn-on-use appearance from Gamesmaster Fleurian in Falconwing Square.", tips = "Decor Duels was removed in Patch 12.1 and Blizzard has not confirmed a replacement source. Treat these appearances as currently unavailable unless the activity or rewards return.", waypoints = DECOR_DUELS_WAYPOINTS },
        },
        achievements = {
            ids = {
                62498, 62499, 62507, 62508, 62509, 62510, 62511, 62512, 62513, 62518, 62562, 62563, 62568, 62569,
                62570, 62571, 62572, 62574, 62620, 62621, 62622,
            },
            rewardHighlights = {
                { achievementId = 62518, name = "Cosmic Exterminator", reward = "Unlocks Pet: Cappy for purchase" },
                { achievementId = 62563, name = "Void Response Team", reward = "Unlocks Mount: Unbound Manawyrm for purchase" },
                { achievementId = 62562, name = "Ritual Site Disruptor", reward = "Required for Unbound Manawyrm" },
                { achievementId = 62622, name = "Ritual Renown", reward = "Unlocks Ritual Sites Rank 8 vendor rewards" },
            },
        },
    },
    ["12.0.7"] = {
        label = "Patch 12.0.7: Revelations",
        wowheadPatchId = 120007,
        sourceNotes = {
            "The Naigtal and Val guides were cross-checked with Method's rare and Heroic Showdown routes, including cave entrances and nested maps.",
            "Live pet data adds Fishstick Keith and moves Sleepy Mandrake into its obtainable patch; the deleted Pinky record and non-Toy Box Phase-Displaced Toy were removed.",
            "Vendor costs, achievement criteria, ended events, shop rewards, and regional promotions are labeled explicitly.",
            "Cosmetics cover the learn-on-use Naigtal and Val vendor, pack, treasure, and Heroic secret rewards; Trading Post, shop, promotional, and ordinary equippable gear are excluded.",
        },
        sourceUrls = {
            overview = "https://www.wowhead.com/guide/midnight/patch-12-0-7-overview-features-activities-rewards",
            mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120007",
            mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-0-7-models-locations",
            mountCrossCheck = "https://www.warcraftmounts.com/patch12.0.7.php",
            pets = "https://www.wowhead.com/battle-pets?filter=3;3;120007",
            petGuide = "https://www.wowhead.com/guide/collections/midnight-battle-pets-locations-sources",
            achievements = "https://www.wowhead.com/achievement=62873/a-trip-around-the-stars",
            timewalking = "https://www.method.gg/guides/dragonflight-timewalking-vendor-and-rewards",
            voidInvasions = "https://www.wowhead.com/guide/midnight/naigtal-val-zones-heroic-world-tier",
            valRares = "https://www.method.gg/guides/showdown-slugger-val-rares-and-locations-in-wow-midnight",
            naigtalRares = "https://www.method.gg/guides/showdown-slugger-naigtal-rares-and-locations-in-wow-midnight",
            heroicShowdowns = "https://www.method.gg/guides/mounts/tortured-gorger-mount-guide",
            petCrossCheck = "https://www.wow-petguide.com/News/607/Patch_12.0.7_Datamining_2026-05-05",
            liveRewards = "https://www.wowhead.com/news/return-to-naigtal-and-val-to-stop-the-void-and-collect-cosmetics-381832",
            luminousSporeglider = "https://www.wowhead.com/ptr/news/luminous-sporeglider-available-from-the-sporefall-raid-382121",
            legacyOfAmani = "https://www.wowhead.com/news/chapter-1-of-curse-of-ulatek-patch-12-1-campaign-now-live-382105",
            lostArmamentCatchup = "https://www.wowhead.com/news/buy-lost-armament-transmogs-for-dark-particles-in-patch-12-0-7-381740",
        },
        mounts = {
            { spellId = 1243582, itemId = 246731, name = "Dusk Grimlynx" },
            { spellId = 1261369, name = "Amani Hex Bear" },
            { spellId = 1279352, itemId = 267078, name = "Stoneforged Sentinel" },
            { spellId = 1284973, itemId = 269240, name = "Luminous Sporeglider" },
            { spellId = 1291315, itemId = 272920, name = "Spring Panda" },
            { spellId = 1292102, itemId = 273317, name = "Blackwater X-TREME Firework Rocket" },
            { spellId = 1292342, itemId = 273650, name = "Green Rocket Mount [PH]" },
            { spellId = 1292344, itemId = 273651, name = "Bilgewater X-TREME Firework Rocket" },
            { spellId = 1292345, itemId = 273652, name = "Pink Rocket Mount [PH]" },
            { spellId = 1292356, itemId = 273655, name = "Sunflare Driftmoth" },
            { spellId = 1293456, itemId = 274260, name = "Rabbit'ath" },
            { spellId = 1264184, itemId = 258884, name = "Spawn of Vyranoth" },
            { spellId = 1294648, itemId = 274649, name = "Voidmancer's Starcarver" },
            { spellId = 1294663, itemId = 274650, name = "Netherforged Nullframe" },
            { spellId = 1294677, itemId = 274681, name = "[PH] Horse with Hat" },
            { spellId = 1297427, itemId = 275664, name = "Tortured Gorger" },
            { spellId = 1298439, itemId = 275464, name = "Sun Festival's Painted Roc" },
            { spellId = 1299156, itemId = 276245, name = "Shadow Spirehawk" },
        },
        pets = {
            { speciesId = 5064, npcId = 264863, name = "Murk'atath" },
            { speciesId = 5041, npcId = 262985, name = "Emberlyn" },
            { speciesId = 5073, npcId = 266577, name = "Frosticus Maximus" },
            { speciesId = 5007, npcId = 260149, name = "Akiki" },
            { speciesId = 4949, npcId = 256080, name = "Shadowflame Remnant" },
            { speciesId = 5074, npcId = 266580, name = "Silento" },
            { speciesId = 5052, npcId = 263995, name = "Sunflicker Driftmoth" },
            { speciesId = 4898, npcId = 251820, name = "Fishstick Keith" },
            { speciesId = 4965, npcId = 256565, name = "Sleepy Mandrake" },
        },
        toys = {
            { itemId = 259335, name = "Photo Finisher" },
            { itemId = 259899, name = "Ashen Horn of the Fallen Keeper" },
            { itemId = 260170, name = "Oathstone Fragment" },
            { itemId = 264313, name = "Madcap Redcap" },
            { itemId = 264367, name = "Mycomancer's Hearthspore" },
            { itemId = 276371, name = "Lightveil Recall Beacon" },
        },
        cosmetics = {
            { itemId = 260739, name = "Swamp Dweller's Night Staff", subtype = "appearance", detailKey = "kifaan" },
            { itemId = 276364, name = "Arsenal: Lightforged Armaments", subtype = "arsenal", detailKey = "zuronarArsenal" },
            { itemId = 276301, name = "Lightruned Crystal Beacon", subtype = "appearance", detailKey = "zuronar" },
            { itemId = 276289, name = "Lightveil Argunite Blade", subtype = "appearance", detailKey = "zuronar" },
            { itemId = 274883, name = "Hal'hadar Warpguard's Poleaxe", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274878, name = "Hal'hadar Shadowripper's Blade", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274882, name = "Hal'hadar Pulse Rifle", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274888, name = "Hal'hadar Legion Glaives", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274889, name = "Hal'hadar Darkblade's Edge", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274880, name = "Hal'hadar Adjutant's Gavel", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274884, name = "Arcanografter's Beacon", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274886, name = "Eradicator's Censer", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274879, name = "Mana-Amplified Crusher", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274887, name = "Mana-Overloaded Bulwark", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274881, name = "Phase Igniter", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274885, name = "Phase-Edged Falchion", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 274877, name = "Phaseblade Headsplitter", subtype = "appearance", detailKey = "etherealPack" },
            { itemId = 276290, name = "Ice Guardian's Sleetblade", subtype = "appearance", detailKey = "iceGuardian" },
            { itemId = 249759, name = "Void-Touched Winter Leggings", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249761, name = "Void-Touched Winter Gloves", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249757, name = "Void-Touched Winter Tunic", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249756, name = "Void-Touched Winter Pauldrons", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249755, name = "Void-Touched Winter Hood", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249758, name = "Void-Touched Winter Belt", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249762, name = "Void-Touched Winter Cloak", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249760, name = "Void-Touched Winter Boots", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 249864, name = "Void-Touched Winter Spaulders", subtype = "appearance", detailKey = "winterPack" },
            { itemId = 275214, name = "Response Team's Tower Shield", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275213, name = "Response Team's Lantern", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275212, name = "Response Team's Falchion", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275211, name = "Response Team's Spire", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275210, name = "Response Team's Spear", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275209, name = "Response Team's Longbow", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275208, name = "Response Team's Warglaive", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275207, name = "Response Team's Longsword", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275206, name = "Response Team's Hammer", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275205, name = "Response Team's Kukri", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275204, name = "Response Team's Hatchet", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275203, name = "Response Team's Vambraces", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275202, name = "Response Team's Girdle", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275201, name = "Response Team's Pauldrons", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275200, name = "Response Team's Legplates", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275199, name = "Response Team's Helm", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275198, name = "Response Team's Gauntlets", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275197, name = "Response Team's Greatboots", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275196, name = "Response Team's Chestplate", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275195, name = "Response Team's Bands", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275194, name = "Response Team's Clasp", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275193, name = "Response Team's Shoulderguards", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275192, name = "Response Team's Legguards", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275191, name = "Response Team's Helmet", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275190, name = "Response Team's Grips", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275189, name = "Response Team's Sabatons", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275188, name = "Response Team's Hauberk", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275187, name = "Response Team's Bindings", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275186, name = "Response Team's Belt", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275185, name = "Response Team's Shoulderpads", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275184, name = "Response Team's Trousers", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275183, name = "Response Team's Mask", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275182, name = "Response Team's Handguards", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275181, name = "Response Team's Boots", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275180, name = "Response Team's Jerkin", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275179, name = "Response Team's Cuffs", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275178, name = "Response Team's Cord", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275177, name = "Response Team's Spires", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275176, name = "Response Team's Tights", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275175, name = "Response Team's Crown", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275174, name = "Response Team's Gloves", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275173, name = "Response Team's Slippers", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275172, name = "Response Team's Vestments", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275169, name = "Response Team's Cloak", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275168, name = "Response Team's Cape", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275171, name = "Response Team's Drape", subtype = "appearance", detailKey = "responseTeam" },
            { itemId = 275170, name = "Response Team's Shawl", subtype = "appearance", detailKey = "responseTeam" },
        },
        cosmeticDetailGroups = {
            kifaan = { sourceType = "Vendor", source = "Kifaan", acquisition = "Buy this learn-on-use appearance from Kifaan at the active Umbral Base Camp in Naigtal or Val.", tips = "The active invasion zone rotates weekly. Use the Silvermoon portal to Voidstorm, then enter the active Naigtal or Val gateway.", waypoints = KIFAAN_WAYPOINTS },
            zuronarArsenal = { sourceType = "Achievement Vendor", source = "Zuronar", acquisition = "Complete Showdown Slugger in both Naigtal and Val, then buy Arsenal: Lightforged Armaments from Zuronar at the active Umbral Base Camp.", tips = "The two zones rotate weekly, so the achievement requires at least one active week in each zone. The arsenal is consumed to teach its full weapon set.", waypoints = UMBRAL_BASE_CAMP_WAYPOINTS },
            zuronar = { sourceType = "Vendor", source = "Zuronar", acquisition = "Buy this learn-on-use Lightforged appearance from Zuronar at the active Umbral Base Camp.", tips = "Check Zuronar in whichever invasion zone is active that week; Naigtal and Val use separate maps but share the vendor hub.", waypoints = UMBRAL_BASE_CAMP_WAYPOINTS },
            etherealPack = { sourceType = "Treasure / Vendor Pack", source = "Hal'hadar Pocket-Storage, Domanaar Storage Vessel, or Kifaan", acquisition = "Loot Naigtal and Val storage treasures for a chance at this appearance, or buy a Bulging Ethereal Pack from Kifaan at the active Umbral Base Camp.", tips = "Use each appearance token from your bags as it drops, and combine the fixed treasure route with packs bought using invasion currency.", waypoints = UMBRAL_BASE_CAMP_WAYPOINTS },
            iceGuardian = { sourceType = "Heroic Val Secret", source = "Ice Guardian's Testament", acquisition = "On Heroic World Tier in Val, enter the southeastern cave and interact with the embedded hilt. Carry the Ice Guardian's Testament, defeat two eligible rare or world bosses to gain two Vanquishing stacks, then return to claim the Sleetblade.", tips = "Heroic Val must be active. Do not discard or lose the Testament before returning to the hilt; finish both boss kills during the same secret attempt.", waypoints = ICE_GUARDIAN_SLEETBLADE_WAYPOINTS },
            winterPack = { sourceType = "Vendor Pack", source = "Kifaan / Bulging Winter Pack", acquisition = "Buy Bulging Winter Packs from Kifaan at the active Umbral Base Camp for chances at the Void-Touched Winter appearance tokens.", tips = "The pack result is random. Use each appearance token from your bags and check collection status before buying more packs.", waypoints = KIFAAN_WAYPOINTS },
            responseTeam = { sourceType = "Invasion Vendor", source = "Fieldsmith Ventem", acquisition = "Buy this learn-on-use Response Team appearance from Fieldsmith Ventem at the active Naigtal or Val Umbral Base Camp using Field Accolades and Voidlight Marl.", tips = "Earn Field Accolades from invasion world quests, rares, treasures, and events. Heroic World Tier yields stronger rewards, so combine this farm with the Heroic achievements when geared for it.", waypoints = UMBRAL_BASE_CAMP_WAYPOINTS },
        },
        achievements = {
            ids = {
                61463, 62873, 62874, 62880, 62881, 62882, 62883, 62887, 62901, 62903, 62904, 62909,
                62917, 62919, 63264, 63348, 63349, 63383, 63384, 63385, 63386,
            },
            rewardHighlights = {
                { achievementId = 61463, name = "Master of the Turbulent Timeways V", reward = "Mount: Spawn of Vyranoth" },
                { achievementId = 62873, name = "A Trip Around the Stars", reward = "Unlocks Mount: Voidmancer's Starcarver for purchase" },
                { achievementId = 62874, name = "A Trip Through the Stars", reward = "Unlocks Mount: Netherforged Nullframe for purchase" },
                { achievementId = 63264, name = "Heroic Showdowns", reward = "Unlocks Mount: Tortured Gorger for purchase" },
                { achievementId = 62903, name = "Climate Strange: Val", reward = "Unlocks Pet: Fishstick Keith for purchase" },
                { achievementId = 63349, name = "Ultradon Carnage", reward = "Unlocks Pet: Frosticus Maximus for purchase" },
            },
        },
    },
    ["12.1"] = {
        label = "Patch 12.1: Curse of Ula'tek",
        wowheadPatchId = 120100,
        sourceNotes = {
            "Wowhead 12.1.0 Added in Patch filters for mounts, battle pets, and achievements.",
            "Wowhead, Warcraft Mounts, and Method Patch 12.1 guides for curated source notes and waypoint routes.",
            "Wowhead database mapper data and comments cross-checked vendor, Cursed Surge, treasure, and pet-capture coordinates.",
        },
        sourceUrls = {
            mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120100",
            mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-1-models-locations",
            mountCrossCheck = "https://www.warcraftmounts.com/patch12.1.0.php",
            coiledIsle = "https://www.method.gg/guides/how-to-get-to-the-coiled-isle-in-wow-midnight",
            rareGuide = "https://www.method.gg/guides/coiled-to-strike-coiled-isle-rares-and-locations-in-wow-midnight",
            turbulentTimeways = "https://www.wowhead.com/guide/world-events/turbulent-timeways-timewalking-rewards",
            tradingPost = "https://news.blizzard.com/en-gb/article/24295383/september-is-a-great-month-to-celebrate-friendship-at-the-trading-post",
            blizzconBundle = "https://news.blizzard.com/en-gb/article/24280280/celebrate-blizzcon-2026-with-the-world-of-warcraft-blizzcon-bundle",
            venomousAbyss = "https://www.wowhead.com/guide/midnight/raids/the-venomous-abyss-overview-location-rewards-bosses",
            altarOfFangs = "https://www.wowhead.com/guide/midnight/altar-of-fangs-dungeon-overview-location-rewards",
            sporefall = "https://www.wowhead.com/guide/midnight/raids/sporefall-overview-location-rewards-boss",
            curseSurges = "https://www.wowhead.com/news/the-300-cursed-surge-achievement-takes-a-very-very-long-time-382464",
            pets = "https://www.wowhead.com/battle-pets?filter=3;3;120100",
            petGuide = "https://www.wowhead.com/guide/collections/curse-of-ulatek-patch-12-1-all-pets-locations-sources",
            cataclysmFamilyBattler = "https://www.wow-petguide.com/Section/118/Family_Battler_of_Cataclysm",
            outlandFamilyBattler = "https://www.wow-petguide.com/Section/117/Family_Battler_of_Outland",
            toys = "https://www.wowhead.com/news/new-toys-and-treasures-datamined-on-the-patch-12-1-ptr-381966",
            treasureGuide = "https://www.method.gg/guides/treasures-of-the-coiled-isle-locations-in-wow-midnight",
            corrosiveVendorGuide = "https://www.method.gg/guides/skull-of-er-inye-corrosive-coins-vendor-location-and-rewards-in-wow-midnight",
            reputationGuide = "https://www.method.gg/guides/zuljarras-forces-reputation-guide-for-wow-midnight",
            captainTokka = "https://www.method.gg/guides/captain-tokka-reputation-guide-for-wow-midnight",
            preySeason2 = "https://www.method.gg/guides/prey-in-wow-midnight-season-2",
            delveSeason2 = "https://www.wowhead.com/guide/midnight/delves-season-journey-best-builds-nemesis-rewards",
            vaultGuide = "https://www.method.gg/guides/vaults-of-atal-utek-wow-midnight-world-activity-overview",
            assaultTheVault = "https://www.method.gg/guides/mounts/assault-the-vault-meta-achievement-venomous-coiler-mount-guide",
            achievements = "https://www.wowhead.com/achievements?filter=17;3;120100",
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
            { spellId = 1268919, itemId = 262496, name = "Delver's Arcane Golem" },
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
            { spellId = 1297217, itemId = 275654, name = "Caustic Venomfang" },
            { spellId = 1297216, itemId = 275653, name = "Sea-Dwelling Isle Serpent" },
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
        cosmetics = {
            { itemId = 276249, name = "Cloak of the Hash'ura", subtype = "appearance" },
            { itemId = 276250, name = "Tabard of the Hash'ura", subtype = "appearance" },
            { itemId = 276251, name = "Shoulderguards of the Hash'ura", subtype = "appearance" },
            { itemId = 277327, name = "Mantle of Nalorakk", subtype = "appearance" },
            { itemId = 277326, name = "Axe of the Amani", subtype = "appearance" },
            { itemId = 276841, name = "Arsenal: Armaments of the Loa", subtype = "arsenal" },
            { itemId = 276607, name = "Ensemble: Vestments of Jan'alai's Chosen", subtype = "ensemble" },
            { itemId = 276608, name = "Ensemble: Battlegear of Halazzi's Chosen", subtype = "ensemble" },
            { itemId = 276609, name = "Ensemble: Chainmail of Akil'zon's Chosen", subtype = "ensemble" },
            { itemId = 276610, name = "Ensemble: Warplate of Nalorakk's Chosen", subtype = "ensemble" },
            { itemId = 279358, name = "Arsenal: Venom-Cursed Arms", subtype = "arsenal" },
            { itemId = 279224, name = "Ensemble: Venom-Cursed Dragonhawk's Raiment", subtype = "ensemble" },
            { itemId = 279227, name = "Ensemble: Venom-Cursed Lynx's Garb", subtype = "ensemble" },
            { itemId = 279228, name = "Ensemble: Venom-Cursed Eagle's Scales", subtype = "ensemble" },
            { itemId = 279230, name = "Ensemble: Venom-Cursed Bear's Guard", subtype = "ensemble" },
            { itemId = 258029, name = "Vaunted Preyhunter's Plumed Helm", subtype = "appearance" },
            { itemId = 258031, name = "Vaunted Preyhunter's Knapsack", subtype = "appearance" },
            { itemId = 258027, name = "Vaunted Preyhunter's Shoulder-Spikes", subtype = "appearance" },
            { itemId = 278101, name = "Ensemble: Preyhunter's Polished Armor", subtype = "ensemble" },
            { itemId = 278103, name = "Ensemble: Preyhunter's Rugged Armor", subtype = "ensemble" },
            { itemId = 278104, name = "Ensemble: Preyhunter's Sleek Armor", subtype = "ensemble" },
            { itemId = 278105, name = "Ensemble: Preyhunter's Refined Armor", subtype = "ensemble" },
            { itemId = 278261, name = "Arsenal: Preyhunter's Lost Armaments", subtype = "arsenal" },
            { itemId = 276165, name = "Ophidian Patagia", subtype = "appearance" },
            { itemId = 276164, name = "Corroded Patagia", subtype = "appearance" },
            { itemId = 276163, name = "Apophic Patagia", subtype = "appearance" },
            { itemId = 281227, name = "Soulcoiler's Rush'kah", subtype = "appearance" },
            { itemId = 275937, name = "Hex Lord's Visage", subtype = "appearance" },
            { itemId = 275938, name = "Hex Lord's Gaze", subtype = "appearance" },
            { itemId = 274814, name = "Envenomed Game Ripper", subtype = "appearance" },
            { itemId = 281569, name = "Quiver of the Drowned Marksman", subtype = "appearance" },
            { itemId = 275062, name = "Illusion: Venomcoil", subtype = "illusion", illusionId = 101 },
            { itemId = 279997, name = "Insidious Venomstone", subtype = "effect", questId = 98217 },
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
            { spellId = 1296724, itemId = 275551, name = "Autumnal Witchwick's Rider" },
            { spellId = 1296988, itemId = 275573, name = "Blushing Witchwick's Rider" },
            { spellId = 1296989, itemId = 275574, name = "Carmine Witchwick's Rider" },
            { spellId = 1305209, itemId = 278576, name = "Crested Violet Leafmimic" },
            { spellId = 1296986, itemId = 275571, name = "Moonlit Witchwick's Rider" },
            { spellId = 1296985, itemId = 275570, name = "Mossy Witchwick's Rider" },
            { spellId = 1296987, itemId = 275572, name = "Scarlet Witchwick's Rider" },
            { spellId = 1295958, name = "Swift Spectral Eagle" },
            { spellId = 1297223, itemId = 275655, name = "Venom Serpent - White" },
            { spellId = 1301817, itemId = 277261, name = "Whoofle Bramblewing" },
            { spellId = 1309340, itemId = 280581, name = "Wintry Witchwick's Rider" },
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
        },
        toys = {},
        achievements = {
            ids = {},
            rewardHighlights = {},
        },
    },
}

-- Use the client-snapshot audit for the collection types that were previously
-- left empty. The 10.0.5 and 10.0.7 rows retain their earlier hand-audited
-- datasets; the 10.0 launch rows are refreshed because that audit found real
-- omissions there as well.
local GENERATED_COLLECTION_PATCHES = {
    ["10.0"] = true,
    ["10.1"] = true,
    ["10.1.5"] = true,
    ["10.1.7"] = true,
    ["10.2"] = true,
    ["10.2.5"] = true,
    ["10.2.6"] = true,
    ["10.2.7"] = true,
    ["11.0"] = true,
    ["11.0.5"] = true,
    ["11.0.7"] = true,
    ["11.1"] = true,
    ["11.1.5"] = true,
    ["11.1.7"] = true,
    ["11.2"] = true,
    ["11.2.5"] = true,
    ["11.2.7"] = true,
}

for patchKey in pairs(GENERATED_COLLECTION_PATCHES) do
    local patch = PatchCatalog.patches[patchKey]
    local generated = GeneratedPatchCollections[patchKey]
    if patch and generated then
        patch.pets = generated.pets or {}
        patch.toys = generated.toys or {}
        patch.achievements = patch.achievements or {}
        patch.achievements.ids = generated.achievements or {}
    end
end

-- These faction variants are launch achievements even though they first
-- appeared in the available post-launch DB2 snapshot used by the generator.
-- Keep them with Dragonflight launch instead of silently dropping them with
-- the 10.0.7 hidden/DNT tracking rows.
table.insert(PatchCatalog.patches["10.0"].achievements.ids, 15325)
table.insert(PatchCatalog.patches["10.0"].achievements.ids, 15638)

local EXCLUDED_COSMETIC_DETAIL_KEYS = {
    anniversaryTierTwo = true,
    anniversaryColdflame = true,
    winterVeil2024 = true,
    childrensWeek = true,
    midsummerVendor = true,
    ahune = true,
    adornedHalfShell = true,
}

local DUPLICATE_12_1_MOUNT_SPELLS = {
    [1243582] = true, [1264184] = true, [1284973] = true, [1292102] = true,
    [1292344] = true, [1294648] = true, [1294663] = true, [1296731] = true,
    [1296734] = true, [1296756] = true, [1296758] = true, [1296759] = true,
    [1296760] = true, [1297427] = true, [1298439] = true,
}

local DUPLICATE_12_1_ACHIEVEMENTS = {
    [61463] = true, [62873] = true, [62874] = true, [62880] = true,
    [62881] = true, [62882] = true, [62883] = true, [62887] = true,
    [62901] = true, [62903] = true, [62904] = true, [62909] = true,
    [62917] = true, [62919] = true, [63264] = true, [63348] = true,
    [63349] = true, [63383] = true, [63384] = true, [63385] = true,
    [63386] = true,
}

local function FilterCollection(entries, keep)
    local filtered = {}
    for _, entry in ipairs(entries or {}) do
        if keep(entry) then
            filtered[#filtered + 1] = entry
        end
    end
    return filtered
end

for _, patch in pairs(PatchCatalog.patches) do
    patch.cosmetics = FilterCollection(patch.cosmetics, function(entry)
        return not EXCLUDED_COSMETIC_DETAIL_KEYS[entry.detailKey]
    end)
    patch.toys = FilterCollection(patch.toys, function(entry)
        return entry.name ~= "Nap Mat"
    end)
    patch.mounts = FilterCollection(patch.mounts, function(entry)
        return entry.name ~= "Sun Festival's Painted Roc"
    end)
end

PatchCatalog.patches["11.0.5"].mounts = FilterCollection(PatchCatalog.patches["11.0.5"].mounts, function(entry)
    return entry.name == "Incognitro, the Indecipherable Felcycle"
end)
PatchCatalog.patches["12.1"].mounts = FilterCollection(PatchCatalog.patches["12.1"].mounts, function(entry)
    return not DUPLICATE_12_1_MOUNT_SPELLS[entry.spellId]
end)
PatchCatalog.patches["12.1"].achievements.ids = FilterCollection(PatchCatalog.patches["12.1"].achievements.ids, function(achievementId)
    return not DUPLICATE_12_1_ACHIEVEMENTS[achievementId]
end)

-- Unknown, promotional, shop, placeholder, and future-rotation records are
-- outside the permanent-content catalog and must never appear as a UI patch.
PatchCatalog.patches["Unknown"] = nil

PatchCatalog.achievementCategories = {
    ["12.0"] = {
        [62273] = "Questing",
        [62288] = "Exploration",
        [62289] = "Exploration",
        [62290] = "Exploration",
        [62291] = "Exploration",
        [62324] = "Events",
        [62325] = "Events",
        [62326] = "Events",
        [62329] = "Events",
        [62330] = "Events",
        [62331] = "Events",
        [62332] = "Events",
        [62333] = "Events",
        [62336] = "Events",
        [62337] = "Events",
        [62338] = "Events",
        [62339] = "Events",
        [62340] = "Events",
        [62341] = "Events",
        [62342] = "Events",
        [62343] = "Events",
        [62351] = "Prey",
        [62352] = "Raids",
        [62357] = "Housing",
        [62358] = "Housing",
        [62359] = "Housing",
        [62360] = "Housing",
        [62361] = "Housing",
        [62362] = "Housing",
        [62363] = "Housing",
        [62364] = "Housing",
        [62365] = "Housing",
        [62366] = "Housing",
        [62369] = "Housing",
        [62370] = "Housing",
        [62371] = "Housing",
        [62373] = "Housing",
        [62374] = "Housing",
        [62375] = "Housing",
        [62376] = "Housing",
        [62377] = "Housing",
        [62378] = "Housing",
        [62383] = "Prey",
        [62385] = "Questing",
        [62386] = "Questing",
        [62388] = "Questing",
        [62400] = "Questing",
        [62403] = "Prey",
        [62406] = "Raids",
        [62493] = "PvP",
        [62494] = "PvP",
        [62514] = "PvP",
        [62516] = "PvP",
        [62517] = "PvP",
    },
    ["12.0.5"] = {
        [62498] = "Events",
        [62499] = "Events",
        [62507] = "Events",
        [62508] = "Events",
        [62509] = "Events",
        [62510] = "Events",
        [62511] = "Events",
        [62512] = "Events",
        [62513] = "Events",
        [62518] = "Events",
        [62562] = "Events",
        [62563] = "Events",
        [62568] = "Events",
        [62569] = "Events",
        [62570] = "Events",
        [62571] = "Events",
        [62572] = "Events",
        [62574] = "Events",
        [62620] = "Events",
        [62621] = "Events",
        [62622] = "Events",
    },
    ["12.0.7"] = {
        [61463] = "Events",
        [62873] = "Questing",
        [62874] = "Questing",
        [62880] = "Questing",
        [62881] = "Questing",
        [62882] = "Questing",
        [62883] = "Questing",
        [62887] = "Questing",
        [62901] = "Questing",
        [62903] = "Questing",
        [62904] = "Questing",
        [62909] = "Questing",
        [62917] = "Questing",
        [62919] = "Questing",
        [63264] = "Questing",
        [63348] = "Questing",
        [63349] = "Questing",
        [63383] = "Questing",
        [63384] = "Questing",
        [63385] = "Questing",
        [63386] = "Questing",
    },
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

PatchCatalog.achievementDetails = {
    ["12.0"] = {
        [62273] = { sourceType = "Achievement", source = "Echoes of Midnight", acquisition = "Joined in the defense of the Sunwell against the forces of Xal'atath during Midnight." },
        [62288] = { sourceType = "Achievement", source = "Eversong Woods: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Eversong Woods.", waypoints = EVERSONG_HIGHEST_PEAKS_WAYPOINTS, mapAchievementId = 62288, waypointCriteria = HIGHEST_PEAKS_CRITERIA },
        [62289] = { sourceType = "Achievement", source = "Zul'Aman: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Zul'Aman.", waypoints = ZULAMAN_HIGHEST_PEAKS_WAYPOINTS, mapAchievementId = 62289, waypointCriteria = HIGHEST_PEAKS_CRITERIA },
        [62290] = { sourceType = "Achievement", source = "Harandar: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Harandar.", waypoints = HARANDAR_HIGHEST_PEAKS_WAYPOINTS, mapAchievementId = 62290, waypointCriteria = HIGHEST_PEAKS_CRITERIA },
        [62291] = { sourceType = "Achievement", source = "Voidstorm: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Voidstorm.", waypoints = VOIDSTORM_HIGHEST_PEAKS_WAYPOINTS, mapAchievementId = 62291, waypointCriteria = HIGHEST_PEAKS_CRITERIA },
        [62324] = { sourceType = "Achievement", source = "Abundance: Loa of all Trades", acquisition = "Complete an Abundance event after earning points in every score category.", tips = "Touch basic and artisan nodes, contribute materials, collect large orbs, and participate in a bonus before the run ends.", waypoints = ABUNDANCE_WAYPOINTS },
        [62325] = { sourceType = "Achievement", source = "Abundance: Treasures Aplenty", acquisition = "Trigger the Treasure Dundun Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62326] = { sourceType = "Achievement", source = "Abundance: Golden Opportunities", acquisition = "Trigger the Golden Glow Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62329] = { sourceType = "Achievement", source = "Abundance: Squash the Competition", acquisition = "Trigger the Runaways Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62330] = { sourceType = "Achievement", source = "Abundance: One Bite at a Time", acquisition = "Trigger the Gigantic Harvest Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62331] = { sourceType = "Achievement", source = "Abundance: Drops of Prosperity", acquisition = "Trigger the Rain of Abundance Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62332] = { sourceType = "Achievement", source = "Abundance: Dundun's Favored", acquisition = "Complete every listed location-specific Abundance bonus achievement.", tips = "The active Abundant Harvest cavern rotates every 8 hours; track which of the four locations still needs each bonus.", waypoints = ABUNDANCE_WAYPOINTS },
        [62333] = { sourceType = "Achievement", source = "Abundance: Harvester", acquisition = "Earn at least 10000 Materials Harvested score in one Abundance event.", tips = "Prioritize rapid node gathering for the entire run and avoid spending time on categories you no longer need.", waypoints = ABUNDANCE_WAYPOINTS },
        [62336] = { sourceType = "Achievement", source = "Abundance: Contributor", acquisition = "Earn at least 10000 Materials Contributed score in one Abundance event.", tips = "Deposit gathered materials frequently rather than carrying them when the timer ends.", waypoints = ABUNDANCE_WAYPOINTS },
        [62337] = { sourceType = "Achievement", source = "Abundance: Professional", acquisition = "Earn at least 10000 Basic Nodes score in one Abundance event.", waypoints = ABUNDANCE_WAYPOINTS },
        [62338] = { sourceType = "Achievement", source = "Abundance: Artisan", acquisition = "Earn at least 10000 Artisan Nodes score in one Abundance event.", waypoints = ABUNDANCE_WAYPOINTS },
        [62339] = { sourceType = "Achievement", source = "Abundance: Gambler", acquisition = "Earn at least 10000 Bonus Events score in one Abundance event.", tips = "Join every announced bonus immediately; this category depends on bonus participation rather than ordinary harvesting.", waypoints = ABUNDANCE_WAYPOINTS },
        [62340] = { sourceType = "Achievement", source = "Abundance: Investor", acquisition = "Earn at least 10000 Large Orbs score in one Abundance event.", waypoints = ABUNDANCE_WAYPOINTS },
        [62341] = { sourceType = "Achievement", source = "Abundance: Ain't Dun Till It's Dun", acquisition = "Complete every listed Abundance score achievement.", tips = "Build one run around one missing 10000-point category; spreading effort evenly makes the specialist thresholds harder.", waypoints = ABUNDANCE_WAYPOINTS },
        [62342] = { sourceType = "Achievement", source = "Abyss Anglers: The Finest of Fish", acquisition = "Catch a Mythic creature 3 times from Abyss Anglers dives.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        [62343] = { sourceType = "Achievement", source = "Abyss Anglers: Myths from Beneath", acquisition = "Catch a Mythic creature 6 times from Abyss Anglers dives.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        [62351] = { sourceType = "Achievement", source = "Preying For Midnight", acquisition = "Complete the achievements listed below.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        [62352] = { sourceType = "Achievement", source = "Nothing to See Here", acquisition = "Get consumed by the Devouring Host in The Voidspire or March on Quel'Danas.", waypoints = MIDNIGHT_RAID_WAYPOINTS },
        [62357] = { sourceType = "Achievement", source = "Classically Trained Lumberjack", acquisition = "Harvest 250 Ironwood Lumber." },
        [62358] = { sourceType = "Achievement", source = "Outlandish Lumberjack", acquisition = "Harvest 250 Olemba Lumber." },
        [62359] = { sourceType = "Achievement", source = "Wrathful Lumberjack", acquisition = "Harvest 250 Coldwind Lumber." },
        [62360] = { sourceType = "Achievement", source = "Cataclysmic Lumberjack", acquisition = "Harvest 250 Ashwood Lumber." },
        [62361] = { sourceType = "Achievement", source = "Mist-Shrouded Lumberjack", acquisition = "Harvest 250 Bamboo Lumber." },
        [62362] = { sourceType = "Achievement", source = "Lumberjack Warlord", acquisition = "Harvest 250 Shadowmoon Lumber." },
        [62363] = { sourceType = "Achievement", source = "Legion Lumberjack", acquisition = "Harvest 250 Fel-Touched Lumber." },
        [62364] = { sourceType = "Achievement", source = "Azeroth's Lumberjack", acquisition = "Harvest 250 Darkpine Lumber." },
        [62365] = { sourceType = "Achievement", source = "Shadowy Lumberjack", acquisition = "Harvest 250 Arden Lumber." },
        [62366] = { sourceType = "Achievement", source = "Draconic Lumberjack", acquisition = "Harvest 250 Dragonpine Lumber." },
        [62369] = { sourceType = "Achievement", source = "The Lumberjack Within", acquisition = "Harvest 250 Dornic Fir Lumber." },
        [62370] = { sourceType = "Achievement", source = "Midnight Lumberjack", acquisition = "Harvest 250 Thalassian Lumber." },
        [62371] = { sourceType = "Achievement", source = "Couponing for Beginners", acquisition = "Collect 50 Community Coupons." },
        [62373] = { sourceType = "Achievement", source = "Coupon Collector", acquisition = "Collect 250 Community Coupons." },
        [62374] = { sourceType = "Achievement", source = "You Get The Best Deals Anywhere", acquisition = "Collect 500 Community Coupons." },
        [62375] = { sourceType = "Achievement", source = "Buying in Bulk", acquisition = "Collect 1000 Community Coupons." },
        [62376] = { sourceType = "Achievement", source = "Extreme Couponing", acquisition = "Collect 2500 Community Coupons." },
        [62377] = { sourceType = "Achievement", source = "A Fist Full of Coupons", acquisition = "Collect 5000 Community Coupons." },
        [62378] = { sourceType = "Achievement", source = "A Few Coupons More", acquisition = "Collect 10000 Community Coupons." },
        [62383] = { sourceType = "Achievement", source = "Gotta Hunt Them All", acquisition = "Defeat all of the following Prey targets on any difficulty.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        [62385] = { sourceType = "Achievement", source = "Staring Into The Void", acquisition = "Connect a path through the Void Research Console to its final node using weekly Uncontaminated Void Samples.", tips = "Samples are weekly-gated. The Lab-Grown Stormray is mailed after completion if it is not granted immediately.", waypoints = SINGULARITY_WAYPOINTS },
        [62386] = { sourceType = "Achievement", source = "Light Up the Night", acquisition = "Complete Forever Song, Making an Amani Out of You, That's Aln, Folks!, and Yelling into the Voidstorm.", tips = "These are the four zone metas. Finish each zone's story, exploration, rares, and treasures together to minimize repeat travel.", waypoints = { "/way #2395 43.4 47.4 Forever Song / Eversong Woods", "/way #2437 45.8 65.8 Making an Amani Out of You / Zul'Aman", "/way #2413 49.2 54.4 That's Aln, Folks! / Harandar", "/way #2405 51.6 23.7 Yelling into the Voidstorm / Voidstorm" } },
        [62388] = { sourceType = "Achievement", source = "Illicit Rain: Five Stars", acquisition = "Earn a Five Star Review for your services at the Illicit Rain." },
        [62400] = { sourceType = "Achievement", source = "Craft Your World", acquisition = "Own a Pin-o-Matic Camera." },
        [62403] = { sourceType = "Achievement", source = "'Tis But A Scratch", acquisition = "Complete a Prey Hunt in Nightmare Mode while suffering from Lord Viscera's Cat Scratch.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        [62406] = { sourceType = "Achievement", source = "All the Things She Said", acquisition = "Defeat Midnight Falls after returning 12 Memories of Alleria to L'ura on Normal difficulty or higher.", waypoints = { "/way #2424 52.60 87.50 March on Quel'Danas entrance" } },
        [62493] = { sourceType = "Achievement", source = "Slayer's Rise Victory", acquisition = "Win one Slayer's Rise match.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        [62494] = { sourceType = "Achievement", source = "Slayer's Rise Veteran", acquisition = "Win 100 Slayer's Rise matches.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        [62514] = { sourceType = "Achievement", source = "Slayer's Rise Dominance", acquisition = "Win while your team controls Shenzar Refinery, Bastion of Might, Gates of Might, Bastion of Valor, and Gates of Valor.", tips = "Coordinate the final capture rather than ending the match as soon as your team is ahead; all five criteria must be controlled for the same win.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        [62516] = { sourceType = "Achievement", source = "The Voided Gazelle", acquisition = "Kill an enemy at the Path of Predation before they dismount.", tips = "Hold burst and crowd control at the mounted approach so the target dies before voluntary or forced dismount credit is lost.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        [62517] = { sourceType = "Achievement", source = "Rise of the Ultradon Slayer", acquisition = "Kill the enemy faction's ultradon summoned at The Husk or Sparring Grounds.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
    },
    ["12.0.5"] = {
        [62498] = { sourceType = "Void Assault", source = "Void Assault: Eversong", acquisition = "Complete one Void Strike or Incursion while Eversong Woods is the active weekly assault zone.", tips = "Eversong and Zul'Aman alternate weekly. Pick up Ranger Captain's Summons in Silvermoon if the activity has not been introduced on your Warband.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62499] = { sourceType = "Void Assault", source = "Void Assault: Zul'Aman", acquisition = "Complete one Void Strike or Incursion while Zul'Aman is the active weekly assault zone.", tips = "Eversong and Zul'Aman alternate weekly. A missed zone cannot be completed until its assault rotates back.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62507] = { sourceType = "Void Assault", source = "Void Smasher: Eversong", acquisition = "Complete 5 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62508] = { sourceType = "Void Assault", source = "Void Eradicator: Eversong", acquisition = "Complete 25 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62509] = { sourceType = "Void Assault", source = "Void Bane: Eversong", acquisition = "Complete 50 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62510] = { sourceType = "Void Assault", source = "Void Smasher: Zul'Aman", acquisition = "Complete 5 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62511] = { sourceType = "Void Assault", source = "Void Eradicator: Zul'Aman", acquisition = "Complete 25 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62512] = { sourceType = "Void Assault", source = "Void Bane: Zul'Aman", acquisition = "Complete 50 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62513] = { sourceType = "Currency", source = "Outstanding in the Field", acquisition = "Earn 100 Field Accolades from Ritual Sites or Void Assaults.", tips = "This tracks lifetime currency earned, so spending Field Accolades does not erase progress.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62518] = { sourceType = "Void Assault", source = "Cosmic Exterminator", acquisition = "Defeat 100 wildlife enemies afflicted with Apex Corruption. The marked Eversong wildlife strikes and Zul'Aman Bitter Bark strike are the reliable farms.", tips = "Only corrupted wildlife counts. Farm dense packs while the matching strike is active; completion unlocks Cappy from Sergeant Vornin for 1800 Voidlight Marl.", waypoints = COSMIC_EXTERMINATOR_WAYPOINTS },
        [62562] = { sourceType = "Ritual Sites", source = "Ritual Site Disruptor", acquisition = "Complete Ritual Sites 320, Ritual Renown, and Challenging Sites.", tips = "Only one of Daggerspine Point and Broken Throne is active each week. Tier and challenge progress is Warband-wide, but use the active site to work on all three sub-achievements together.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62563] = { sourceType = "Void Assault", source = "Void Response Team", acquisition = "Complete both zone assault chains plus Cosmic Exterminator. This unlocks Unbound Manawyrm from Sergeant Vornin for 6000 Voidlight Marl.", tips = "The two assault zones alternate weekly, so this requires seeing both sides of the rotation. Check the individual criteria before farming repeat strikes.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62568] = { sourceType = "Void Assault", source = "Void Shmoid", acquisition = "Defeat 250 enemies in Void Strikes or Incursions. Follow the weekly assault zone and tag broadly for credit.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62569] = { sourceType = "Void Assault", source = "Traces in the Dark", acquisition = "Collect Torn Twilight Missive from Twilight cultists, Hal'hadar Battery Core from Hal'hadar, Enchanted Naga Scroll from Daggerspine naga, and Permafrosted Keystone from Domanaar or Devouring Host enemies.", tips = "Do all four drops on one character; reports indicate the achievement looks Warband-wide but the hidden item/quest flags are character-specific. Maren can exchange 100 Dark Particles for a missing trace.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62570] = { sourceType = "Void Assault", source = "Cosmic Slayer", acquisition = "Defeat 15 advanced Void-Corrupted creatures. Comments point to Springclaw and Croaker in Eversong Woods and Grizzly in Zul'Aman as eligible bosses.", waypoints = COSMIC_SLAYER_WAYPOINTS },
        [62571] = { sourceType = "Void Assault", source = "Everybody Gets One", acquisition = "Free trapped allies or wildlife during the relevant assault phases. Comments say the Stillwhisper Pond phase in Eversong is the fastest route.", waypoints = { "/way #2395 45.8 70.0 Stillwhisper Pond / animal rescue phase", "/way #2437 31.0 42.0 Spiritpaw Gatherers / Zul'Aman rescue objective" } },
        [62572] = { sourceType = "Void Assault", source = "Battery Bombardment", acquisition = "Pick up Hal'hadar batteries during Battery Rush and throw 50 of them at pylons.", tips = "Carrying a battery blocks ordinary mounting. Use the water-orb movement aids or a form that still works while carrying, and loop the two Zul'Aman Battery Rush areas when that objective appears.", waypoints = BATTERY_BOMBARDMENT_WAYPOINTS },
        [62574] = { sourceType = "Currency", source = "Accolade to Rest", acquisition = "Earn 500 Field Accolades from Ritual Sites or Void Assaults.", tips = "This tracks lifetime currency earned, so you may spend the currency while progressing it.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62620] = { sourceType = "Ritual Sites", source = "Ritual Sites 320", acquisition = "Complete a Tier 3 Ritual Site after unlocking the tiers in sequence.", tips = "Tier 2 and Tier 3 must be opened through prior-tier progress; select the highest available tier before entering the active weekly site.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62621] = { sourceType = "Ritual Sites", source = "Challenging Sites", acquisition = "Complete all eight challenges: Tendrils, Magical Alarm Bells, Patrols, Manifestations, Tainted Corpses, Reinforced, Malevolent Boons, and Embers.", tips = "Choose missing challenges at the Ritual Site interface before a run. Higher tiers expose more challenge slots, letting you combine several missing criteria.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62622] = { sourceType = "Ritual Sites", source = "Ritual Renown", acquisition = "Reach Ritual Sites Renown Rank 8 by repeatedly clearing the active site and opening its spoils.", tips = "Ritual Interest from Ranger Captain's Summons opens the system. Higher tiers and challenge runs are the efficient route; the reputation is repeatable rather than limited to one gain per week.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
    },
    ["12.0.7"] = {
        [61463] = { sourceType = "Timewalking", source = "Master of the Turbulent Timeways V", acquisition = "Gain Mastery of Timeways in four different weeks of Turbulent Timeways V. The 2026 event ran June 30 through August 11 and is now over.", tips = "Four consecutive Timewalking dungeon completions build Knowledge of Timeways into Mastery for that week. Missed mount rewards are expected at Timewalking vendors for 5000 Timewarped Badges when the next Turbulent Timeways event begins.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        [62873] = { sourceType = "Naigtal and Val", source = "A Trip Around the Stars", acquisition = "Complete Into the Stars, Prepared for a Showdown, Frosty Domanaar Politics, Climate Strange: Val, Showdown Slugger: Val, and Showdown Success: Val.", tips = "The active zone rotates weekly. Completing the meta unlocks Voidmancer's Starcarver from Kifaan for 15 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62874] = { sourceType = "Naigtal and Val", source = "A Trip Through the Stars", acquisition = "Complete Into the Stars, Prepared for a Showdown, A Hal'hadar Walks into a Swamp, Climate Strange: Naigtal, Showdown Slugger: Naigtal, and Showdown Success: Naigtal.", tips = "Track every sub-criterion while Naigtal is active; the weekly zone rotation and rotating stories/world quests can require a later Naigtal week. Completion unlocks Netherforged Nullframe for 15 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62880] = { sourceType = "Val", source = "Showdown Success: Val", acquisition = "Complete 8 different Val world quests.", tips = "There are more than eight possibilities and the active world quest changes roughly hourly. Heroic completions also satisfy the normal achievement.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62881] = { sourceType = "Val", source = "Showdown Slugger: Val", acquisition = "Defeat 6 of Val's 10 named rares.", tips = "Rares have a short protection window after spawning; use the cave-entrance and nested Forgotten Depths pins rather than waiting on the surface marker. Heroic kills also count toward Heroic Slugger.", waypoints = VAL_RARE_WAYPOINTS },
        [62882] = { sourceType = "Naigtal", source = "Showdown Success: Naigtal", acquisition = "Complete 8 different Naigtal world quests.", tips = "The active world quest changes roughly hourly. Heroic completions also satisfy the normal achievement.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62883] = { sourceType = "Naigtal", source = "Showdown Slugger: Naigtal", acquisition = "Defeat 6 of Naigtal's 10 named rares.", tips = "Several targets patrol or are inside structures; the map route labels those cases. Heroic kills also count toward Heroic Slugger.", waypoints = NAIGTAL_RARE_WAYPOINTS },
        [62887] = { sourceType = "Heroic World Tier", source = "Heroic: Worlds Ahead", acquisition = "Complete 15 different Naigtal or Val world quests with Heroic World Tier selected.", tips = "Select Heroic at level 90 before entering; published guidance recommends about item level 274. Repeats of the same named world quest do not advance the unique count.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62901] = { sourceType = "Heroic World Tier", source = "Heroic: Power Creep", acquisition = "Defeat creatures carrying each of the 10 listed Heroic affix criteria in Val or Naigtal.", tips = "Check the achievement tracker before pulling so you target missing affixes. This is Heroic-only; ordinary versions of the same creatures do not count.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62903] = { sourceType = "Val", source = "Climate Strange: Val", acquisition = "Complete Storm Mitigation 5 times and defeat 8 Rampaging Ice Elementals in Val.", tips = "A Heroic completion advances the normal criterion too. Completion unlocks Fishstick Keith from Kifaan for 50 Sin'dorei Swarmers.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62904] = { sourceType = "Naigtal", source = "Climate Strange: Naigtal", acquisition = "Complete Subdue the Spore Storm 5 times in Naigtal.", tips = "Heroic completions also count for the normal achievement, so use Heroic when possible to progress both versions together.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62909] = { sourceType = "Heroic World Tier", source = "Heroic: Pain of Command", acquisition = "Defeat Imperator Pertinax in Val and Nexus-Captain Leth'ir in Naigtal on Heroic World Tier.", tips = "Each boss is available with its zone's weekly rotation. Pertinax is inside the Void Acropolis; Leth'ir is at Command Point Primos.", waypoints = SHOWDOWN_WORLD_BOSS_WAYPOINTS },
        [62917] = { sourceType = "Heroic World Tier", source = "Heroic Climate Strange: Val", acquisition = "Complete Storm Mitigation 5 times in Val on Heroic World Tier.", tips = "Heroic runs simultaneously advance Climate Strange: Val. The second normal-only elemental criterion is not part of this achievement.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62919] = { sourceType = "Heroic World Tier", source = "Heroic Climate Strange: Naigtal", acquisition = "Complete Subdue the Spore Storm 5 times in Naigtal on Heroic World Tier.", tips = "Each Heroic completion simultaneously advances the normal Climate Strange: Naigtal achievement.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63264] = { sourceType = "Heroic World Tier", source = "Heroic Showdowns", acquisition = "Complete Heroic: Worlds Ahead, Heroic: Power Creep, Heroic: Pain of Command, both Heroic Climate achievements, and Heroic Slugger.", tips = "This is Warband-wide but needs both weekly zone rotations. Completion unlocks Tortured Gorger from Kifaan for 15 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63348] = { sourceType = "Heroic World Tier", source = "Heroic Slugger", acquisition = "Defeat 15 rare creatures in Val or Naigtal on Heroic World Tier.", tips = "This counts kills rather than 15 unique names. Farm the zone-specific rare loop and repeat it across both weekly rotations.", waypoints = SHOWDOWN_RARE_WAYPOINTS },
        [63349] = { sourceType = "Naigtal", source = "Ultradon Carnage", acquisition = "During Until It Is Done, enter Ultradon Slayer mode and defeat 100 enemies in Naigtal.", tips = "Progress is cumulative. A raid group can suppress ordinary world-quest progress while preserving achievement kills, allowing all 100 during one appearance. Completion unlocks Frosticus Maximus from Kifaan for 15 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63383] = { sourceType = "Story", source = "Into the Stars", acquisition = "Complete the introduction questlines for both Naigtal and Val on the same character.", tips = "Start with Maella in Silvermoon and use the Voidstorm portal. After completing an introduction once, a Warband skip becomes available for alts.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63384] = { sourceType = "Story", source = "Prepared for a Showdown", acquisition = "Complete Bouncy Mushrooms, Aerospores, Exterior Manaforge Translocator, Preparing for Threats, The Road Not Taken Twice, Spatial Reasoning, and The Grappler.", tips = "These quests unlock traversal abilities used by other secrets, especially the Airy Redcap for Sleepy Mandrake. Check this criterion before attempting that route.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63385] = { sourceType = "Naigtal story", source = "A Hal'hadar Walks into a Swamp", acquisition = "Complete every tracked chapter of the Naigtal Hal'hadar storyline.", tips = "The story rotates with Naigtal. Use the achievement tracker to identify the missing chapter rather than repeating completed introductions.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63386] = { sourceType = "Val story", source = "Frosty Domanaar Politics", acquisition = "Complete Victory Within Hindsight, A Shot at the Dark, and Umbral Title Bout in Val.", tips = "The story is available during Val's weekly rotation. The three Umbravarden pins cover the commonly missed handoff locations.", waypoints = { "/way #2599 38.09 54.89 Umbravarden Shadinos", "/way #2599 38.20 67.72 Umbravarden Vicium", "/way #2599 56.25 84.37 Umbravarden Votarna" } },
    },
    ["12.1"] = {
        [61463] = { sourceType = "Timewalking", source = "Master of the Turbulent Timeways V", acquisition = "Gain Mastery of Timeways in four different weeks of Turbulent Timeways V. The 2026 event ran June 30 through August 11, so the Feat of Strength is no longer earnable after that event.", tips = "Four consecutive Timewalking dungeon completions build Knowledge of Timeways into Mastery for that week. Missed mount rewards are added to Timewalking vendors for 5000 Timewarped Badges when the next Turbulent Timeways event begins; Xydan is present only during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        [62447] = { sourceType = "Mythic+", source = "Midnight Keystone Master: Season 2", acquisition = "Reach at least 2000 Mythic+ rating during Midnight Season 2 to earn Breath of Blight.", tips = "The exact mix depends on which dungeons are over- or under-timed, but the published estimate is close to timing nearly every Season 2 dungeon at +7. This is queue-based seasonal content, so there is no single map pin." },
        [62449] = { sourceType = "Mythic+", source = "Midnight Keystone Legend: Season 2", acquisition = "Reach at least 3000 Mythic+ rating during Midnight Season 2 to earn Breath of Ruin.", tips = "The published estimate is roughly every Season 2 dungeon at +12 with some +13s. This is queue-based seasonal content, so there is no single map pin." },
        [62460] = { sourceType = "Pet Battles", source = "Family Battler of Outland", acquisition = "Defeat Nicki Tinytech, Ras'an, Narrok, Morulu the Elder, and Bloodknight Antari with ten separate teams, one all-level-25 team for each pet family.", tips = "This is 50 credited wins. The August 14 hotfix replaced the erroneous Gorma Asaan criterion with Bloodknight Antari. The trainers are account-wide daily fights, so expect ten daily resets after the prerequisite tamer chain is unlocked.", waypoints = OUTLAND_FAMILY_BATTLER_WAYPOINTS },
        [62461] = { sourceType = "Pet Battles", source = "Family Battler of Cataclysm", acquisition = "Defeat Brok, Bordin Steadyfist, Goz Banefury, and Obalis with ten separate teams, one all-level-25 team for each pet family.", tips = "This is 40 credited wins and the tamers are account-wide daily fights, so expect ten daily resets. Obalis has separate pins for old Uldum and the Battle for Azeroth Uldum phase.", waypoints = CATACLYSM_FAMILY_BATTLER_WAYPOINTS },
        [62492] = { sourceType = "Achievement", source = "The Coiled Isle Safari", acquisition = "Capture Autumn Snapling, Caustic Writhling, Cursed Spawn, Jaundiced Slitherer, Nightfur Kapara, Poisoned Parasite, Sleek Snakebiter, and Steady Croakfrog.", tips = "These are peaceful click-captures, not pet battles. Nightfur Kapara is the rarest stop and can take hours to respawn; try War Mode, a group phase, or another character phase if its southern route is empty.", waypoints = COILED_ISLE_SAFARI_WAYPOINTS, mapAchievementId = 62492, waypointCriteria = COILED_ISLE_SAFARI_CRITERIA },
        [63099] = { sourceType = "Rated PvP", source = "Venomous Combatant / Alliance", acquisition = "While at 1000 rating or higher during Midnight Season 2, win rated PvP matches until the Season Rewards bar is full to earn the Alliance Vicious Lightbloom Boar.", tips = "The exact win count is not fixed across brackets; use the Rated PvP Season Rewards bar as the source of truth. Additional full bars award Vicious Saddles. This queue-based reward has no single map location." },
        [63103] = { sourceType = "Rated PvP", source = "Venomous Combatant / Horde", acquisition = "While at 1000 rating or higher during Midnight Season 2, win rated PvP matches until the Season Rewards bar is full to earn the Horde Vicious Lightbloom Boar.", tips = "The exact win count is not fixed across brackets; use the Rated PvP Season Rewards bar as the source of truth. Additional full bars award Vicious Saddles. This queue-based reward has no single map location." },
        [63104] = { sourceType = "Mythic+ end-of-season reward", source = "Umbral Champion: Midnight Season 1", acquisition = "End Midnight Mythic+ Season 1 in the top 1% of Mythic+ rating in your region to receive Umbral Ashes.", tips = "Season 1 has ended and the reviewed rewards have been distributed, so this achievement and mount can no longer be earned. Eligible players receive the mount through the achievement and Lindormi's in-game mail." },
        [63167] = { sourceType = "PvP", source = "Tour of Duty: The Coiled Isle", acquisition = "Earn 1000 honor on The Coiled Isle while War Mode is enabled.", tips = "The achievement text is honor earned, not a fixed kill count. Farm where players gather for active objectives; Tokka's Landing and Tokka's Folly are useful rally points, but the objective can move.", waypoints = { "/way #2512 59.4 49.5 Tokka's Landing / War Mode rally point", "/way #2512 51.5 49.7 Tokka's Folly / War Mode rally point" } },
        [63250] = { sourceType = "Raid achievement", source = "Is Venom Stasis A Joke To You?", acquisition = "Defeat the Entombed Sentinels on Normal difficulty or higher after each Sentinel restores more than half of its maximum health with Vitriolic Stasis.", tips = "Create at least a 50-percentage-point health gap before an intermission, wait for the lower Sentinel to heal, then solve Helical Toxins. Repeat with the opposite Sentinel. Solving the toxins ends the heal, so do not finish the matching mechanic early.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63254] = { sourceType = "Raid meta-achievement", source = "Glory of the Venomous Raider", acquisition = "Complete all eight boss achievements in The Venomous Abyss on Normal difficulty or higher: Well, Well, Little Sky; Is Venom Stasis A Joke To You?; Accidental Inclusion; Kept You Waiting Huh?; Jumping Through Hoops; Taking a Bite out of Slime; Watch Out Behind You; and No Egg Scramble.", tips = "Track the Glory achievement during each pull. Several objectives must be prepared before combat: buy Balm of Flies inside the raid for Kupamanduka, light the incense left of the stairs before Sszorak, and organize a dedicated Greasy Hatchling relay for Ula'tek.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63333] = { sourceType = "Delve achievement", source = "Let Me Solo Him: Azta'rec", acquisition = "Defeat Azta'rec solo on Nemesis (Tier ??) difficulty during Midnight Season 2.", tips = "Use the seasonal quest at Delver's Headquarters to reach Azta'rec in Venomfall Deeps. For the memory intermissions, mark the four quadrants, record the seven-step sequence, move toward center before the 90%, 60%, and 30% transitions, and never miss the lethal interrupt or dispel.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        [63334] = { sourceType = "Delve Feat of Strength", source = "Fabled Let Me Solo Him: Azta'rec", acquisition = "Defeat Azta'rec solo on Tier ?? during the first week of Midnight Season 2 to earn the Fabled Vanquisher of Azta'rec title.", tips = "This first-week Feat of Strength is no longer obtainable. The fight route is retained for reference: mark the four quadrants, move toward center before the 90%, 60%, and 30% memory intermissions, and prioritize the lethal interrupt and dispel.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        [63391] = { sourceType = "Raid achievement", source = "Jumping Through Hoops", acquisition = "Defeat Sszorak on Normal difficulty or higher after the raid jumps through every ring that appears.", tips = "Before the pull, light the small incense on the left side of the doorway before the stairs into the arena. Three rings appear with each Raging Crosswinds sequence; line up so the knockback sends you through the rings. Tracking the achievement should turn white once the setup is active and the rings are satisfied.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63397] = { sourceType = "Raid achievement", source = "Kept You Waiting Huh?", acquisition = "Defeat Vashnik on Normal difficulty or higher after killing the Solidified Snake Venom.", tips = "Preserve and crowd-control one split red slime, then during the next Imbibe stack red, orange, and purple altar adds exactly together to form Solidified Snake Venom. Death Grip or other precise displacement plus a long crowd control such as Banish makes the merge much easier. Kill the solidified add before Vashnik.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63418] = { sourceType = "Raid achievement", source = "Well, Well, Little Sky", acquisition = "Defeat Nek'zali on Normal difficulty or higher after returning Kupamanduka to the Soulcoil Well.", tips = "Buy Balm of Flies from the Forgotten Attendant skeleton on the left inside the raid entrance. Use it on Kupamanduka in the poison fountain before the boss room, pick up the frog, carry it to the Soulcoil Well, then punt it into the well during the encounter before killing Nek'zali.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63645] = { sourceType = "Raid achievement", source = "Accidental Inclusion", acquisition = "Defeat The Lost Explorers on Normal difficulty or higher while including Hoji in the fight.", tips = "Before the pull, interact with the fish on the platform near the coffin. This causes the invulnerable Hoji add to spawn and cast throughout the encounter. Leave Hoji active and defeat the boss; the achievement does not require killing Hoji.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63656] = { sourceType = "Raid achievement", source = "Taking a Bite out of Slime", acquisition = "Defeat the Twin Fangs on Normal difficulty or higher after feeding Ithraz Crunchy Appetizer, Sumptuous Soup, Tasty Blob, and Jiggly Dessert in the tracked order during Ravenous Feast.", tips = "Before the boss, assign four players to click one follower each: Sumptuous Soup is in a left-side hole after the first boss; Jiggly Dessert is on a right ledge in the Twin Fangs room; Tasty Blob is in the green fountain before Vashnik; Crunchy Appetizer is on a small poison island after the Lost Explorers. The follower buffs last one hour. Send those players into successive red group soaks in the exact order shown by the tracked achievement.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63669] = { sourceType = "Raid achievement", source = "Watch Out Behind You", acquisition = "Defeat the Coiled Altar on Normal difficulty or higher while every player is afflicted by Unnerving Fixation.", tips = "Dreadmarch mind controls create two fixating ghosts after a player is freed. Preserve the ghosts instead of destroying them with the tank frontal: kite them by looking away and freeze them by facing them. Wait until every living player has a fixation and the tracked criterion turns white before finishing the encounter. Groups above 20 have reported ghost-cap problems.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63359] = { sourceType = "Achievement", source = "Treasures of the Coiled Isle", acquisition = "Loot all 22 hidden treasures on The Coiled Isle. Several treasures require short interaction chains, keys, nearby NPC dialogue, fishing, or temporary objects before the final treasure can be opened.", tips = "Use the pins as a checklist, but do not skip the helper pins attached to Amani Privateer's Cache, Lost Spirit, Vul'zahn's Smuggled Treasure, Grave of Someone Forgotten, or Brine-Crusted Chest; those are required setup steps, not duplicate treasure locations.", mapAchievementId = 63359, waypointCriteria = COILED_ISLE_TREASURE_CRITERIA, waypoints = COILED_ISLE_TREASURE_WAYPOINTS },
        [63609] = { sourceType = "Raid achievement", source = "No Egg Scramble", acquisition = "Defeat Ula'tek on Normal difficulty or higher before the Greasy Hatchling breaks.", tips = "Assign at least four players to keep the hatchling moving; five gives a safer relay. The carrier cannot cross the poison sea normally, so use a Demonic Gateway, Leap of Faith, or high-mobility class during the platform split. Caustic Wave forces an immediate drop, so the next catcher must be ready.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        [63630] = { sourceType = "Meta-achievement", source = "Assault the Vault", acquisition = "Complete Roll the Patrol, Submerge the Incursion, A Lone Wanderer, Ritual Behavior, The Honored Dead, Spike the Strike, Oppose the Foes, Dance While Everyone Watches, Soft Underbelly, and Fully Corroded.", tips = "Plan for at least three weekly Ancient Foe rotations and Zul'jarra's Forces Renown 14. Patrols rotate every 10 minutes. For Earth and Sky, reach the upper-right Shrine of Sky before the event fills; for Cache of Three, /dance uninterrupted at all three shrine circles; for travel, Sulfurous Sludgefish helps non-stealth classes avoid trash.", waypoints = VAULTS_ASSAULT_WAYPOINTS },
        [63633] = { sourceType = "Achievement", source = "A Stack of Snacks", acquisition = "Complete the Ki'clak Snack Attack world quest five times. Unlock it per character by finishing the Don't be Afrayed side story, starting with Ghosts of the Ring from Olawu.", tips = "During the world quest, loot 10 Swirling Ectoplasm from Frayed ghosts near the Ring of Glory, then use Mab'jul's special dialogue option and feed Ki'clak. Do not buy the similarly named vendor item: it does not grant quest credit. Do not feed Ki'clak while in a raid group. Multiple eligible alts can shorten the five-completion time gate.", waypoints = { "/way #2512 58.58 47.27 Olawu / Ghosts of the Ring prerequisite", "/way #2512 71.0 57.0 Frayed ghosts / Swirling Ectoplasm farm", "/way #2512 59.4 49.5 Tokka's Landing / Mab'jul and Ki'clak" } },
        [63653] = { sourceType = "Achievement", source = "Pro Poison Patroller", acquisition = "Complete 250 patrols within the Vaults of Atal'Utek. Five patrols can be active in each 10-minute wave.", tips = "Run the high-ground circuit to reveal nearby patrol icons, complete the active set, then return to the Amani Foothold until the next :00/:10/:20 wave. Sulfurous Sludgefish or stealth greatly reduces time lost to hostile packs.", waypoints = VAULTS_ASSAULT_WAYPOINTS },
    },
}

PatchCatalog.petDetails = {
    ["12.0"] = {
        ["Amber Treeflitter"] = { sourceType = "Wild caught", source = "Eversong Woods", acquisition = "Found commonly across Eversong Woods.", waypoints = { "/way #2395 42.8 38.6 Amber Treeflitter", "/way #2395 40.8 46.6 Amber Treeflitter", "/way #2395 50.0 59.6 Amber Treeflitter" } },
        ["Vibrant Manaling"] = { sourceType = "Wild caught", source = "Eversong Woods", acquisition = "Found commonly across Eversong Woods.", waypoints = { "/way #2395 46.0 36.2 Vibrant Manaling", "/way #2395 53.8 55.4 Vibrant Manaling", "/way #2395 39.4 56.6 Vibrant Manaling" } },
        ["Violet Chick"] = { sourceType = "Wild caught", source = "Eversong Woods", acquisition = "Found uncommonly across Eversong Woods.", waypoints = { "/way #2395 46.0 36.4 Violet Chick", "/way #2395 38.0 57.8 Violet Chick" } },
        ["Silvermoon Broom"] = { sourceType = "Wild caught", source = "Silvermoon City", acquisition = "Rare spawn in a small sweeping route in Silvermoon City; Wowhead notes spawn times can be over an hour and it is not required for Midnight Safari.", waypoints = SILVERMOON_BROOM_WAYPOINTS },
        ["Azure Sporebat"] = { sourceType = "Wild caught", source = "Harandar", acquisition = "Capture from the Harandar wild pet pool.", waypoints = { "/way #2413 64.0 45.6 Azure Sporebat", "/way #2413 56.6 54.6 Azure Sporebat", "/way #2413 70.0 64.4 Azure Sporebat" } },
        ["Mud Potadpole"] = { sourceType = "Wild caught", source = "Harandar", acquisition = "Rare spawn in northeast Harandar; Wowhead notes spawn times can be over three hours.", waypoints = { "/way #2413 70.5 32.2 Mud Potadpole", "/way #2413 69.6 32.2 Mud Potadpole", "/way #2413 71.6 31.2 Mud Potadpole" } },
        ["Rootling Nester"] = { sourceType = "Wild caught", source = "Harandar", acquisition = "Found uncommonly across Harandar.", waypoints = { "/way #2413 60.4 20.7 Rootling Nester", "/way #2413 40.6 43.2 Rootling Nester", "/way #2413 52.8 80.2 Rootling Nester" } },
        ["Silkcrawler"] = { sourceType = "Wild caught", source = "Harandar", acquisition = "Found commonly across Harandar.", waypoints = { "/way #2413 41.4 69.8 Silkcrawler", "/way #2413 36.6 26.6 Silkcrawler", "/way #2413 41.6 69.6 Silkcrawler" } },
        ["Blistercreepling"] = { sourceType = "Wild caught", source = "Voidstorm", acquisition = "Found all over Voidstorm.", waypoints = { "/way #2405 62.8 67.2 Blistercreepling", "/way #2405 33.0 48.4 Blistercreepling", "/way #2405 65.4 59.4 Blistercreepling" } },
        ["Devouring Runt"] = { sourceType = "Wild caught", source = "Voidstorm", acquisition = "Found all across Voidstorm.", waypoints = { "/way #2405 51.1 77.4 Devouring Runt", "/way #2405 40.2 37.6 Devouring Runt", "/way #2405 57.2 71.0 Devouring Runt" } },
        ["Riftblade Familiar"] = { sourceType = "Wild caught", source = "Voidstorm", acquisition = "Found around Obscurian Citadel.", waypoints = { "/way #2405 63.2 73.6 Riftblade Familiar", "/way #2405 60.0 72.4 Riftblade Familiar" } },
        ["Voidcrawler"] = { sourceType = "Wild caught", source = "Voidstorm", acquisition = "Found around Stormarion Citadel, Obscurian Citadel, and nearby Voidstorm areas.", waypoints = { "/way #2405 30.6 66.4 Voidcrawler", "/way #2405 28.2 53.0 Voidcrawler", "/way #2405 48.0 60.0 Voidcrawler" } },
        ["Akil Fledgling"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Found around the southeast mountain area of Zul'Aman.", waypoints = { "/way #2437 52.8 80.6 Akil Fledgling", "/way #2437 47.0 75.8 Akil Fledgling", "/way #2437 49.6 81.6 Akil Fledgling" } },
        ["Dragonhawk Mosswing"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Found on the northern islands in Zul'Aman.", waypoints = { "/way #2437 50.6 24.8 Dragonhawk Mosswing", "/way #2437 51.8 28.8 Dragonhawk Mosswing", "/way #2437 51.6 18.2 Dragonhawk Mosswing" } },
        ["Ebon Snapling"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Found sparsely around the center of Zul'Aman.", waypoints = { "/way #2437 41.4 48.4 Ebon Snapling", "/way #2437 32.6 45.6 Ebon Snapling", "/way #2437 42.0 59.6 Ebon Snapling" } },
        ["Gloom Toad"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Found around Zul'Aman, generally near water.", waypoints = { "/way #2437 29.0 41.8 Gloom Toad", "/way #2437 37.4 64.8 Gloom Toad", "/way #2437 45.2 73.0 Gloom Toad" } },
        ["Pangolil"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Rare spawn wandering the center bridge in Zul'Aman; Wowhead notes spawn times can be over three hours.", waypoints = { "/way #2437 40.8 54.2 Pangolil", "/way #2437 48.2 54.6 Pangolil", "/way #2437 40.2 54.2 Pangolil" } },
        ["Swamp Biter"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Found all over Zul'Aman.", waypoints = { "/way #2437 51.4 65.0 Swamp Biter", "/way #2437 44.6 40.4 Swamp Biter", "/way #2437 51.6 65.0 Swamp Biter" } },
        ["Nether Familiar"] = { sourceType = "Wild caught", source = "Isle of Quel'Danas", acquisition = "Found commonly in the north of Isle of Quel'Danas.", waypoints = { "/way #2424 43.6 15.6 Nether Familiar", "/way #2424 29.0 29.0 Nether Familiar", "/way #2424 29.0 28.4 Nether Familiar" } },
        ["Wrathful Wyrm"] = { sourceType = "Wild caught", source = "Isle of Quel'Danas", acquisition = "Rare spawn that patrols a diagonal line through northern Isle of Quel'Danas; Wowhead notes spawn times can be over three hours.", waypoints = { "/way #2424 41.0 33.0 Wrathful Wyrm", "/way #2424 49.2 22.8 Wrathful Wyrm" } },
        ["Waddles"] = { sourceType = "Wild caught", source = "Harandar", acquisition = "Click-capture this peaceful pet around the northern pools of Harandar.", tips = "It is collected by clicking it in the world, not through a pet battle; the learned pet item is placed in your bags.", waypoints = { "/way #2413 60.4 20.9 Waddles", "/way #2413 60.6 20.8 Waddles", "/way #2413 61.4 18.6 Waddles" } },
        ["Striped Snakebiter"] = { sourceType = "Wild caught", source = "Zul'Aman", acquisition = "Click-capture this peaceful snake around central and southeastern Zul'Aman.", tips = "It is a direct click capture, not a pet battle. Check the alternate spawn pins or another phase if the route is empty.", waypoints = { "/way #2437 39.6 51.8 Striped Snakebiter", "/way #2437 51.6 67.0 Striped Snakebiter", "/way #2437 51.8 61.6 Striped Snakebiter", "/way #2437 38.67 47.24 Striped Snakebiter / alternate spawn", "/way #2437 48.61 49.79 Striped Snakebiter / alternate spawn", "/way #2437 42.24 63.38 Striped Snakebiter / alternate spawn", "/way #2437 50.34 57.72 Striped Snakebiter / alternate spawn" } },
        ["Do, Child of Filo"] = { sourceType = "Achievement", source = "Midnight Safari", acquisition = "Capture the required wild pets across Midnight launch zones.", waypoints = MIDNIGHT_SAFARI_WAYPOINTS, mapAchievementId = 61091, waypointCriteria = MIDNIGHT_SAFARI_CRITERIA },
        ["Niblet"] = { sourceType = "Achievement", source = "Midnight Dungeon Hero", acquisition = "Complete every Midnight launch dungeon on at least Heroic difficulty.", waypoints = MIDNIGHT_DUNGEON_WAYPOINTS },
        ["Sootpaw"] = { sourceType = "Achievement", source = "Treasures of Eversong Woods", acquisition = "Loot all nine Eversong Woods treasures.", tips = "The Triple-Locked Safebox needs its three marked keys; the Stone Vat needs 10 grapes, stomping, and yeast from nearby Sheri.", waypoints = EVERSONG_TREASURE_WAYPOINTS, mapAchievementId = 61960, waypointCriteria = EVERSONG_TREASURE_CRITERIA },
        ["Blitzcreek"] = { sourceType = "Renown Vendor", source = "Void Researcher Anomander", acquisition = "Reach The Singularity Renown 14, then buy for 2500 Voidlight Marl.", waypoints = SINGULARITY_WAYPOINTS },
        ["Dragonhawk Munchkin"] = { sourceType = "Renown Vendor", source = "Caeris Fairdawn", acquisition = "Reach Silvermoon Court Renown 12, then buy for 2500 Voidlight Marl.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Flicker"] = { sourceType = "Vendor", source = "Apprentice Diell", acquisition = "Reach Luminary standing with the Magisters of the Silvermoon Court, then buy for 200 Brimming Arcana.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Medusa"] = { sourceType = "Reputation Vendor", source = "Thraxadar", acquisition = "Reach Revered with Slayer's Duellum, then buy for 2500 Voidlight Marl.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Munchy"] = { sourceType = "Renown Vendor", source = "Naynar", acquisition = "Reach Hara'ti Renown 12, then buy for 2500 Voidlight Marl.", waypoints = HARATI_WAYPOINTS },
        ["Naloki"] = { sourceType = "Renown Vendor", source = "Magovu", acquisition = "Reach Amani Tribe Renown 12, then buy for 2500 Voidlight Marl.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Nova"] = { sourceType = "Paragon Cache", source = "Slayer's Duellum Trove", acquisition = "Chance from the Slayer's Duellum paragon cache.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Lil' Preyseeker"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Preyseeker's Journey Rank 9, then buy for 1200 Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Voldy"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Buy from Construct V'anore for 800 Remnant of Anguish after progressing the Prey system.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Princess Bloodshed"] = { sourceType = "Drop", source = "Dame Bloodshed", acquisition = "Drops from the roaming Dame Bloodshed rare in Eversong Woods; use /tar if she is hard to spot.", waypoints = { "/way #2395 45.6 38.6 Dame Bloodshed" } },
        ["Kai"] = { sourceType = "Event Cache", source = "Victorious Stormarion Cache", acquisition = "Chance from the cache after completing the Stormarion Assault. Repeatable across event completions.", waypoints = VOIDSTORM_RARE_WAYPOINTS },
        ["Bubbly Snapling"] = { sourceType = "Fishing", source = "Patient Chest", acquisition = "Fish up and open the Patient Chest during the Midnight launch fishing activity." },
        ["Hexed Bunny"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Lost Star"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Nibblesworth"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Sporbie"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Spormilian"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Treja'saka"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Ziorg'pharon"] = { sourceType = "Delves", source = "Delve end-of-run rewards", acquisition = "Chance from Midnight delve end-of-run rewards.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Kreepah'zoyd"] = { sourceType = "Delves", source = "Naleidea Rivergleam", acquisition = "Buy from Naleidea Rivergleam for 10000 Undercoin.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Ominous Domanus"] = { sourceType = "Delves", source = "Nullaeus", acquisition = "Chance from Nullaeus, the Midnight Season 1 delve challenge boss.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Dali"] = { sourceType = "Treasure", source = "Burbling Paint Pot", acquisition = "Loot Burbling Paint Pot in Eversong Woods; Wowhead notes you must be near or in water to use the object that teaches the pet.", waypoints = { "/way #2395 48.7 75.5 Burbling Paint Pot" } },
        ["Gortham"] = { sourceType = "Dungeon treasure", source = "Nexus Point Xenas / Netherstorm Structural Cage", acquisition = "Bring five players, clear the left corridor, and stand on all five Corespark Conduits simultaneously to unlock the Netherstorm Structural Cage.", tips = "All five conduits must be occupied at once, so do this with a full group before anyone leaves the dungeon.", waypoints = { "/way #2405 65.0 61.7 Nexus Point Xenas entrance" } },
        ["Nether Siphoner"] = { sourceType = "Treasure", source = "Quivering Egg", acquisition = "Loot the Quivering Egg treasure in Voidstorm.", waypoints = { "/way #2405 31.51 44.51 Quivering Egg" } },
        ["Sunwing Hatchling"] = { sourceType = "Treasure", source = "Rookery Cache", acquisition = "Buy Tasty Meat, use it on the bowl by the Mischevious Chick, loot the dropped key, then open the upper-platform Rookery Cache.", waypoints = { "/way #2393 24.4 69.6 Rookery Cache / above" } },
        ["Percival"] = { sourceType = "Treasure", source = "Kemet's Simmering Cauldron", acquisition = "Loot Kemet's Simmering Cauldron in Harandar.", waypoints = { "/way #2413 55.6 39.5 Kemet's Simmering Cauldron" } },
        ["Perturbed Sporebat"] = { sourceType = "Treasure", source = "Impenetrably Sealed Gourd", acquisition = "Mix red and purple fluid into Fizzing Fluid, then use it on the gourd.", waypoints = { "/way #2413 27.50 67.97 Cave Entrance" } },
        ["Scruffbeak"] = { sourceType = "Treasure", source = "Abandoned Nest", acquisition = "Loot the Weathered Eagle Egg and wait 3 real-time days for it to hatch.", waypoints = { "/way #2437 42.7 52.5 Abandoned Nest" } },
        ["Willie"] = { sourceType = "Treasure", source = "Half-Digested Viscera", acquisition = "Loot the treasure inside the Voidstorm cave.", waypoints = { "/way #2405 38.06 68.74 Cave Entrance", "/way #2405 37.8 69.7 Half-Digested Viscera" } },
        ["Assistant Botanist Leafy"] = { sourceType = "Quest", source = "Re-Hydra-ted", acquisition = "Complete the three-quest Predator Reintroduction chain, starting with Drift Them Away from Ney'tar.", waypoints = { "/way #2413 69.6 50.6 Ney'tar / Drift Them Away" } },
        ["Distorted Memory"] = { sourceType = "Quest", source = "The Empty Cradle", acquisition = "Finish the weekly-gated Empty Cradle storyline and turn in the final quest to Aksem.", tips = "Progress was prone to cross-character flag issues before 12.1; keep the chain on one character if a step appears missing.", waypoints = { "/way #2413 53.4 49.6 Aksem / The Empty Cradle" } },
        ["Emberwing Hatchling"] = { sourceType = "Quest", source = "A Quiet Farewell", acquisition = "Complete A Quiet Farewell, starting with The Path of Mourning from Chana.", waypoints = { "/way #2437 45.36 69.74 Chana / The Path of Mourning" } },
        ["Emerald Hatchling"] = { sourceType = "Unverified quest data", source = "The Battle of the Bridge", acquisition = "The database associates this pet with The Battle of the Bridge, but it is absent from the collection journal and has no verified obtainable source." },
        ["Hawkstrider Hatchling"] = { sourceType = "Quest", source = "First Step Into Parenthood", acquisition = "Complete the One Adventurous Hatchling chain from Vaelith Sunplume, then wait 24 real hours for the rewarded Hawkstrider Egg to hatch.", tips = "The side quests appear after the Eversong main story is complete.", waypoints = { "/way #2395 56.81 35.55 Vaelith Sunplume / chain start", "/way #2395 53.62 35.23 Lost Hawkstrider Fledgling" } },
        ["Fidoficus"] = { sourceType = "Quest", source = "Mighty and Superior", acquisition = "Complete A Domanaar's Best Friend, starting with Harvest of Darkness from Ravenia.", tips = "At the final choice, wait for all dialogue to finish before leaving; either answer awards the pet.", waypoints = { "/way #2405 52.08 67.43 Ravenia / Harvest of Darkness", "/way #2405 48.03 75.70 Den-Gorger cave entrance" } },
        ["Linda the Lucky"] = { sourceType = "Quest", source = "O.K. Bloomer", acquisition = "Complete the Bloomtown chain, starting with Light Disturbance from Hannan.", waypoints = { "/way #2413 31.44 64.93 Hannan / Light Disturbance", "/way #2413 37.31 72.29 O.K. Bloomer finale" } },
        ["Luma"] = { sourceType = "Quest", source = "Thief at Bark", acquisition = "Complete the short Missing Lynx chain, starting with Second Time's a Choice from Instructor Antheol.", waypoints = { "/way #2395 44.6 45.4 Instructor Antheol / chain start" } },
        ["Grumpy Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Plump Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Screechy Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Gummi the Glow Wyrm"] = { sourceType = "Promotion", source = "Unknown promotion", acquisition = "Wowhead lists this as a promotion and speculates about a Trolli / Xbox-style cross promotion; no reliable in-world source is available." },
        ["Lil' Staropod"] = { sourceType = "Promotion", source = "Unknown promotion", acquisition = "Wowhead lists this as a promotion with no reliable in-world source yet." },
        ["Razeshi C."] = { sourceType = "Promotion", source = "Discord Quest", acquisition = "Required playing Midnight through the Discord Quest campaign before March 15, 2026.", tips = "The promotion has ended and this pet is currently unavailable." },
        ["Smoldering Valor"] = { sourceType = "In-Game Shop", source = "Battle.net Shop", acquisition = "Shop pet with no in-world map source." },
        ["Star the Lucky Dragon"] = { sourceType = "In-Game Shop", source = "Unreleased shop pet", acquisition = "No verified general-release purchase or in-world source was found as of September 2026." },
        ["Aud'rei III"] = { sourceType = "Unknown / quest data", source = "Patch-filtered pet species", acquisition = "No verified collectible source was found as of September 2026; database records remain tied to conflicting quest data." },
        ["Auspicious Pixiu"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No reliable public acquisition method or coordinate was found in the current guides." },
        ["Chillcrawler"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No verified collectible source or coordinate was found as of September 2026." },
        ["Dundun"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No verified collectible source or coordinate was found as of September 2026." },
        ["Moon Darter"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No reliable public acquisition method or coordinate was found in the current guides." },
    },
    ["12.0.5"] = {
        ["Cappy"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Earn Cosmic Exterminator, then buy Cappy from Sergeant Vornin for 1800 Voidlight Marl.", tips = "Farm only Apex-Corrupted wildlife for the 100-kill prerequisite; ordinary enemies in the same strike do not count.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Curious Lynx Kitten"] = { sourceType = "Void Assault", source = "Wriggling Field Pouch", acquisition = "Very rare chance from a Wriggling Field Pouch, an uncommon replacement for the normal end reward from repeat Void Strikes and Incursions.", tips = "The journal associates this pet with Eversong, but pouch reports are inconsistent about strict zone locking. Repeat fast strikes while an assault is active and inspect every pushed end-of-event bag.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        ["Wriggling Capybara"] = { sourceType = "Void Assault", source = "Wriggling Field Pouch", acquisition = "Very rare chance from a Wriggling Field Pouch, an uncommon replacement for the normal end reward from repeat Void Strikes and Incursions.", tips = "Repeat the quickest active strikes; the rare pouch is the bottleneck and may be pushed directly rather than looted from a boss.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        ["Chubs"] = { sourceType = "Ritual Sites", source = "Broken Throne", acquisition = "In Broken Throne Tier 2 or higher, feed 1 Practically Pork to the stealthed Lost Bear Cub to receive Chubs.", tips = "Collect 5 additional Practically Pork and keep Chubs summoned at the northern meat piles if you also want to spawn the Angry Amani Warbear for its mount.", waypoints = BROKEN_THRONE_PETS_WAYPOINTS },
        ["Overloaded Manaling"] = { sourceType = "Ritual Sites", source = "Mana-Gorged Greatwyrm", acquisition = "Reach Ritual Sites Renown 8, then kill the rare Mana-Gorged Greatwyrm in Daggerspine Point for a chance at the pet.", tips = "Renown 8 is required for the rare/reward access; use higher-tier challenge runs to reach it quickly.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Void-Infused Mindbreaker Fry"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown 6, then buy from Sergeant Vornin for 1800 Voidlight Marl.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Rescued Dragonhawk Chick"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown 6, then buy the Void-Touched Dragonhawk Egg from Sergeant Vornin for 1800 Voidlight Marl.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Snapdragon"] = { sourceType = "Ritual Sites secret", source = "Soggy Nest / Daggerspine Point", acquisition = "Click Washed Up Kelp in Daggerspine Point until a Disturbed Kelpslinger drops Soggy Lynx Toy, then use that item at the Soggy Nest to obtain the pet.", tips = "The Soggy Lynx Toy is a usable inventory item, not a Toy Box collectible. It is tradable, can be bought on the Auction House, and is not consumed at the nest.", waypoints = DAGGERSPINE_POINT_PETS_WAYPOINTS },
        ["Void-Scarred Eaglet"] = { sourceType = "Ritual Sites secret", source = "Broken Throne tornado nest", acquisition = "First learn the Void-Corrupted Hex Eagle mount. Ride it near the marked nest, jump into the tornado around 49.5, 78.3, fly upward, and loot the eaglet from the nest.", tips = "The secret checks for the Hex Eagle mount, so the nest alone is not enough. Obtain the mount from its nearby Tier 2 ritual first.", waypoints = BROKEN_THRONE_PETS_WAYPOINTS },
        ["Void-Touched Chick"] = { sourceType = "Ritual Sites secret", source = "Drifting Void-Touched Egg", acquisition = "At Daggerspine Point, click the Void-Touched Egg near the waterfall around 74.3, 49.6 and follow it downstream until it stops around 52.3, 63.8.", tips = "Stay close to the drifting egg and interact whenever it pauses; the second pin marks the end of its route.", waypoints = VOID_TOUCHED_CHICK_WAYPOINTS },
        ["Void-Touched Lynx Kitten"] = { sourceType = "Ritual Sites secret", source = "Rustling Bushes", acquisition = "On Tier 3, repeatedly inspect a Rustling Bush or fern until the kitten is revealed, usually after roughly 10-12 successful rustles.", tips = "Progress is Warband-wide. The route contains both Ritual Site interiors; when a bush resets quickly, repeatedly working the same cluster can be faster than a full loop.", waypoints = RITUAL_SITE_RUSTLING_BUSH_WAYPOINTS },
        ["Ka'bubb"] = { sourceType = "Abyss Anglers vendor", source = "Depthdiver Tu'nakit", acquisition = "Complete All Blue Angler, then buy Ka'bubb for 2400 Angler Pearls.", tips = "Work the Abyss Anglers dives and blue-quality fish objectives together before spending pearls, because the achievement gate and currency are both required.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        ["The Sire's Ghastly Screecher"] = { sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; there is no general-region in-world source or map location." },
        ["Sha-Warped Hippogryph Hatchling"] = { sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; there is no general-region in-world source or map location." },
    },
    ["12.0.7"] = {
        ["Murk'atath"] = { sourceType = "Promotion", source = "BlizzCon 2026 Ultimate Collection", acquisition = "Bundle/promotion pet with no in-world farm location." },
        ["Emberlyn"] = { sourceType = "Quest", source = "Like Dragonhawks to a Flame", acquisition = "Complete It Takes Two, Hungry Hungry Hatchlings, Eggstra Protection Never Hurts, Perfect Timing, and Like Dragonhawks to a Flame, starting with Loa Speaker Brek in Zul'Aman.", tips = "Gather feathers behind the temple cliffs, stand in the center while clicking the seven glowing eggs, and kill Cinderscale Patriarch for the final quest.", waypoints = EMBERLYN_WAYPOINTS },
        ["Frosticus Maximus"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Complete Ultradon Carnage, then buy from Kifaan for 15 Voidlight Marl.", tips = "During Until It Is Done, defeat 100 enemies while in Ultradon Slayer mode. Progress is cumulative; a raid group can suppress world-quest completion while you finish all 100.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Akiki"] = { sourceType = "Quest", source = "Dead End / Legacy of the Amani", acquisition = "Complete the Legacy of the Amani chapter through Dead End. Begin Hagar's Invitation in Silvermoon if the chapter has not been started.", tips = "This pet is not sold by Kifaan. Continue the full campaign chain; the Dusk Grimlynx mount is awarded earlier in the same storyline.", waypoints = { "/way #2393 45.45 70.26 Hagar's Invitation / Legacy of the Amani" } },
        ["Shadowflame Remnant"] = { sourceType = "Timewalking", source = "Xydan", acquisition = "Buy from Xydan for 2200 Timewarped Badges during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Silento"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Complete Showdown Success in both Val and Naigtal, then buy from Kifaan for 15 Voidlight Marl.", tips = "Each zone requires eight different world quests. Check Kifaan during either active-zone week after both achievements are complete.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Sunflicker Driftmoth"] = { sourceType = "In-Game Shop", source = "Battle.net Shop / subscription bundle", acquisition = "Shop or subscription-bundle pet with no in-world map source." },
        ["Fishstick Keith"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Complete Climate Strange: Val, then buy from Kifaan for 50 Sin'dorei Swarmers.", tips = "Finish Storm Mitigation five times and kill eight Rampaging Ice Elementals. Heroic storm completions also advance the normal achievement.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Sleepy Mandrake"] = { sourceType = "Naigtal secret", source = "Sleeper's Grotto", acquisition = "Find Sleepy Mandrake in Sleeper's Grotto, feed it Highland, Dusty, Marshy, Partially-Digested, and Airy Redcaps, then interact with the nearby pot.", tips = "The five feed flags are Warband-wide, so they may be split across characters. Normal mode is easier; Airy requires the traversal abilities from Prepared for a Showdown. The pins include Vilaldoun Crypt and the hidden cave entrances.", waypoints = SLEEPY_MANDRAKE_WAYPOINTS },
    },
    ["12.1"] = {
        ["Autumn Snapling"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet around the southeast shoreline of Gnarldor Isle, including the small island and nearby shoreline. Comments add more shoreline spawn points around 70.6, 78.7 and 65.4, 70.9.", waypoints = { "/way #2512 67.8 81.4 Autumn Snapling", "/way #2512 70.6 78.6 Autumn Snapling", "/way #2512 70.61 78.71 Autumn Snapling / comment spawn", "/way #2512 65.35 70.88 Autumn Snapling / comment spawn" } },
        ["Cauldron Concoction"] = { sourceType = "Discovery", source = "Ofi's Offerings / Mixing Mysteries", acquisition = "Complete the Mixing Mysteries activity with Ofi the Sly. Open Handful of Esoteric Ingredients, combine ingredients into offerings, then turn in the offering containers for a low chance at the pet.", waypoints = { "/way #2512 61.0 32.6 Ofi the Sly / Swamp", "/way #2512 57.4 48.7 Ofi the Sly / Tokka's Landing", "/way #2512 58.57 45.93 Firetender Zab'ni / comment step" } },
        ["Caustic Writhling"] = { sourceType = "Wild caught", source = "Vaults of Atal'Utek", acquisition = "Click-capture this peaceful pet inside the Vaults of Atal'Utek sub-zone. Comments add multiple Vaults spawn points and recommend checking War Mode or group phases if the pet is not up.", waypoints = { "/way #2509 39.0 28.2 Caustic Writhling", "/way #2509 41.96 34.23 Caustic Writhling / comment spawn", "/way #2509 43.66 31.63 Caustic Writhling / comment spawn", "/way #2509 41.78 34.54 Caustic Writhling / comment spawn", "/way #2509 32.3 29.4 Caustic Writhling / comment spawn" } },
        ["Corrosive Writhling"] = { sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy from Skull of Er'inye for 5000 Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Cursed Spawn"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle. Comments add more spawns near the north and central island.", waypoints = { "/way #2512 47.2 59.8 Cursed Spawn", "/way #2512 46.20 27.11 Cursed Spawn", "/way #2512 41.9 21.2 Cursed Spawn / comment spawn", "/way #2512 51.5 52.9 Cursed Spawn / comment spawn" } },
        ["Furiostraza"] = { sourceType = "Achievement", source = "Family Battler of Cataclysm", acquisition = "Defeat Brok, Bordin Steadyfist, Goz Banefury, and Obalis with ten separate all-level-25 teams, one for each pet family (40 credited wins).", tips = "The tamers are account-wide daily fights, making this a ten-reset reward. Obalis moves with the Uldum phase; both old-Uldum and Battle-for-Azeroth-Uldum pins are included.", waypoints = CATACLYSM_FAMILY_BATTLER_WAYPOINTS },
        ["Jaundiced Slitherer"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle. Wowhead notes phasing issues: complete the active campaign quest in the area if it is not appearing.", waypoints = { "/way #2512 45.2 31.2 Jaundiced Slitherer", "/way #2512 45.16 31.37 Jaundiced Slitherer / comment spawn", "/way #2512 49.83 55.87 Jaundiced Slitherer / comment spawn" } },
        ["Ki'clak"] = { sourceType = "Achievement", source = "A Stack of Snacks", acquisition = "Complete Ki'clak Snack Attack five times after unlocking it per character through the Don't be Afrayed side story, starting with Ghosts of the Ring from Olawu.", tips = "Loot 10 Swirling Ectoplasm from Frayed ghosts while the world quest is active, use Mab'jul's special dialogue option, and feed Ki'clak. Do not buy the vendor's similarly named item and do not feed while in a raid group; neither grants the required completion credit.", waypoints = { "/way #2512 58.58 47.27 Olawu / Ghosts of the Ring prerequisite", "/way #2512 71.0 57.0 Frayed ghosts / Swirling Ectoplasm farm", "/way #2512 59.4 49.5 Tokka's Landing / Mab'jul and Ki'clak" } },
        ["Lil' Mon"] = { sourceType = "Drop", source = "Big Mon", acquisition = "Drops from Big Mon on the Coiled Isle.", waypoints = { "/way #2512 70.1 63.5 Big Mon" } },
        ["Lil'Kruul"] = { sourceType = "Achievement", source = "Family Battler of Outland", acquisition = "Defeat Nicki Tinytech, Ras'an, Narrok, Morulu the Elder, and Bloodknight Antari with ten separate all-level-25 teams, one for each pet family (50 credited wins).", tips = "The tamers are account-wide daily fights, making this a ten-reset reward. Bloodknight Antari is the correct fifth trainer after Blizzard's August 14 hotfix replaced the erroneous Gorma Asaan criterion.", waypoints = OUTLAND_FAMILY_BATTLER_WAYPOINTS },
        ["Nightfur Kapara"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful rare pet in the southern grassy area of Gnarldor Isle. It patrols between the shrine and the delve and has a multi-hour rare-pet respawn; comments repeatedly place it near the stairs around 61-63, 81-83.", tips = "If every pin is empty, check War Mode or another group phase instead of camping one coordinate; rare-quality wild pets can take hours to return.", waypoints = { "/way #2512 62.6 84.0 Nightfur Kapara", "/way #2512 61.6 81.8 Nightfur Kapara", "/way #2512 62.5 83.0 Nightfur Kapara / comment spawn", "/way #2512 62.59 81.58 Nightfur Kapara / comment spawn", "/way #2512 62.95 81.68 Nightfur Kapara / comment spawn", "/way #2512 61.0 81.0 Nightfur Kapara / approximate comment spawn" } },
        ["Pale Hexscale"] = { sourceType = "Drop", source = "Ral'kala / Nightmare Prey", acquisition = "Chance to drop from Ral'kala during Curse of the Isle. Farm Ossified Relics and contribute them at an active Haunted Brazier; Ral'kala spawns when players collectively offer 100 relics.", tips = "Always contribute at least one relic before the summon completes to gain the improved-loot buff. Search Group Finder for Ral'kala or Haunted Brazier when a brazier's progress is already moving.", waypoints = RALKALA_WAYPOINTS },
        ["Poison Dart Frog"] = { sourceType = "Treasure", source = "Unfortunate Scout's Satchel", acquisition = "Chance from Unfortunate Scout's Satchels after the satchel activity unlocks at Zul'jarra's Forces Renown 9. Route the listed spawn points and loot each satchel you find.", waypoints = UNFORTUNATE_SCOUT_SATCHEL_WAYPOINTS },
        ["Poisoned Parasite"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle. Comments add additional spawns around 68.4, 76.1 and 65.4, 53.9.", waypoints = { "/way #2512 62.2 40.8 Poisoned Parasite", "/way #2512 65.2 49.2 Poisoned Parasite", "/way #2512 68.35 76.08 Poisoned Parasite / comment spawn", "/way #2512 65.42 53.86 Poisoned Parasite / comment spawn" } },
        ["Preyhunter's Prismguard"] = { sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Prey Renown level 8, then buy from Construct V'anore for 1200 Remnant of Anguish. Prey world quests and trap farming near active Prey objectives are the steady Remnant sources.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyhunter's Riftbreaker"] = { sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Prey Renown level 8, then buy from Construct V'anore for 1200 Remnant of Anguish. Prey world quests and trap farming near active Prey objectives are the steady Remnant sources.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Sleek Snakebiter"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet on the Coiled Isle. Player comments list several alternate spawn points across the island.", waypoints = { "/way #2512 65.81 45.75 Sleek Snakebiter", "/way #2512 41.31 43.63 Sleek Snakebiter / comment spawn", "/way #2512 65.76 45.55 Sleek Snakebiter / comment spawn", "/way #2512 56.06 51.44 Sleek Snakebiter / comment spawn", "/way #2512 60.62 77.81 Sleek Snakebiter / comment spawn", "/way #2512 47.39 74.19 Sleek Snakebiter / comment spawn" } },
        ["Slitherfang"] = { sourceType = "Secret", source = "Altar of Fangs Mythic", acquisition = "In Mythic Altar of Fangs, bring a full group. Before the first boss, have 4 players pick up Reversal Charms and 1 pick up the Ritual Reagent under the waterfalls. Kill the first two bosses, clear the room after boss two, avoid clicking the totems, then use the extra action interactions on the snake.", waypoints = ALTAR_OF_FANGS_WAYPOINTS },
        ["Snek'zali"] = { sourceType = "Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 12 with Zul'jarra's Forces, then buy from Jan'sari the Watchful for 2500 Voidlight Marl.", waypoints = JANSARI_WAYPOINTS },
        ["Soulcoil Remnant"] = { sourceType = "Drop", source = "Nek'zali the Soulcoiler / The Venomous Abyss", acquisition = "Drops from Nek'zali the Soulcoiler, the first boss of The Venomous Abyss, on raid difficulties. The pet is cageable, so the Auction House is a backup route.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Steady Croakfrog"] = { sourceType = "Wild caught", source = "The Coiled Isle", acquisition = "Click-capture this peaceful pet around the northeast water/coastline of the island.", waypoints = { "/way #2512 65.8 32.8 Steady Croakfrog", "/way #2512 69.23 46.35 Steady Croakfrog" } },
        ["Three-Eyed Fish"] = { sourceType = "Quest", source = "Tipping the Scaled", acquisition = "Requires Venom Trawler friendship rank with Captain Tokka. Buy the Eerie Bauble from Second Mate Sluggs, fish in Coiled Isle pools until the quest-giver appears, then complete Tipping the Scaled. Comments call out the Blighted Venom Pool inside the Vaults as a useful fishing spot.", waypoints = { "/way #2512 51.64 49.78 Second Mate Sluggs", "/way #2509 46.35 49.03 Blighted Venom Pool / Blightfang" } },
        ["Ula'took"] = { sourceType = "Achievement", source = "No Egg Scramble", acquisition = "Defeat Ula'tek on Normal difficulty or higher before the Greasy Hatchling breaks.", tips = "Assign at least four players to relay the hatchling; five is safer. The carrier cannot cross the poison sea normally, so plan a Demonic Gateway, Leap of Faith, or mobile class for the platform split. Caustic Wave forces an immediate drop, so keep the next catcher close.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Venom Elemental"] = { sourceType = "Vendor", source = "Second Mate Sluggs", acquisition = "Reach Venom Trawler rank with Captain Tokka, then buy from Second Mate Sluggs for 100 gold.", waypoints = SECOND_MATE_SLUGGS_WAYPOINTS },
        ["Vibrant Venomfang"] = { sourceType = "Drop", source = "Wriggling Venom-Soaked Satchel / Curse Surges", acquisition = "Very rare chance from a Wriggling Venom-Soaked Satchel, itself a rare replacement for the repeatable Venom-Soaked Satchel awarded after a Curse Surge.", tips = "Surges use five fixed locations on roughly 45-minute timers and appear in the map's Events tab. Repeat completions still award satchels; the Wriggling satchel is push loot for participating in the event area, so a boss tag is not required.", waypoints = CURSE_SURGE_WAYPOINTS },
        ["Volatile Venomfang"] = { sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Buy from Skull of Er'inye for 5000 Corrosive Coin. If the vendor is missing, unlock the Skull once through Warleader Abdumati's nearby questline.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Zan"] = { sourceType = "Quest", source = "Strange Friends in Odd Places", acquisition = "Complete the side questline that starts with Dealing with Pests from Ofi the Sly, then finish A Little Kindness for Zan.", waypoints = { "/way #2512 61.0 32.6 Ofi the Sly / Dealing with Pests", "/way #2512 57.4 48.7 Ofi the Sly / alternate daily position" } },
        ["Zesty"] = { sourceType = "Achievement", source = "The Coiled Isle Safari", acquisition = "Click-capture the eight pets required by The Coiled Isle Safari: Autumn Snapling, Caustic Writhling, Cursed Spawn, Jaundiced Slitherer, Nightfur Kapara, Poisoned Parasite, Sleek Snakebiter, and Steady Croakfrog.", tips = "These are peaceful captures, not battles. Nightfur Kapara is the rarest stop and can take hours to respawn; if its southern route is empty, try War Mode, a group phase, or another character phase.", waypoints = COILED_ISLE_SAFARI_WAYPOINTS, mapAchievementId = 62492, waypointCriteria = COILED_ISLE_SAFARI_CRITERIA },
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
    ["12.0"] = {
        ["Hexed Potatoad Mucus"] = { sourceType = "Delve treasure", source = "Atal'Aman Sturdy Chest", acquisition = "Loot the three one-time Sturdy Chests in the Toadly Unbecoming story; the reported toy chest is behind the statue near the Restoration Stone.", tips = "The interior map ID may not accept a pasted pin until you are inside Atal'Aman.", effect = "Transforms you into a random Potatoad for 10 minutes; 20-minute cooldown. Combat or abilities can break the form.", waypoints = { "/way #2395 63.78 80.15 Atal'Aman delve entrance", "/way #2535 48.34 50.50 Sturdy Chest / behind statue", "/way #2535 53.15 57.99 Sturdy Chest / water below bridge", "/way #2535 52.98 65.38 Sturdy Chest / ledge by water" } },
        ["Potatoad Egg"] = { sourceType = "Dungeon secret", source = "Gravid Potatoad / The Blinding Vale", acquisition = "After learning Hexed Potatoad Mucus, clear the first two bosses, descend by flight, take the river path opposite the Waystone, transform, and interact with Gravid Potatoad.", tips = "Follower difficulty is safest. Do not cast or enter combat after transforming, and avoid Mythic+ because the hidden reward quest can be pushed at an awkward time.", effect = "Transforms you into a Potatoad for 60 minutes; 1-hour cooldown. Combat breaks the form.", waypoints = { "/way #2576 27.8 77.9 The Blinding Vale entrance", "/way #2576 60.1 50.3 Gravid Potatoad / lower river" } },
        ["Pango Plating"] = { sourceType = "Achievement", source = "Treasures of Zul'Aman", acquisition = "Complete Treasures of Zul'Aman; Abandoned Ritual Skull is no longer required.", tips = "Expect roughly an hour when following a complete treasure route; several objectives have small interaction puzzles.", effect = "Transforms you into a Pango for 60 minutes; 10-minute cooldown. The form persists through combat.", waypoints = ZULAMAN_TREASURE_WAYPOINTS, mapAchievementId = 62125, waypointCriteria = ZULAMAN_TREASURE_CRITERIA },
        ["Verdant Rutaani Seed"] = { sourceType = "Renown Vendor", source = "Naynar", acquisition = "Reach Hara'ti Renown 13, then buy from Naynar in Harandar.", effect = "Transforms you into a Rutaani for 30 minutes; 1-hour cooldown. Combat and jumping remove the form, but mounting does not.", waypoints = HARATI_WAYPOINTS },
        ["Saptor Salve"] = { sourceType = "Dungeon drop", source = "Ziekket / The Blinding Vale", acquisition = "Drops from Ziekket on Mythic difficulty and while The Blinding Vale is available in the Mythic+ rotation.", effect = "Transforms you into a Saptor for 60 minutes; 10-minute cooldown. The form persists through combat.", waypoints = MIDNIGHT_DUNGEON_WAYPOINTS },
    },
    ["12.0.5"] = {
        ["Enchanted Hourglass"] = { sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Originally sold for 300 Illusionary Coins from Gamesmaster Fleurian in Falconwing Square.", tips = "Decor Duels was removed in Patch 12.1. Blizzard confirmed decor rewards would remain available, but did not confirm a replacement source for this toy; treat it as currently unavailable unless it returns.", waypoints = DECOR_DUELS_WAYPOINTS },
        ["Animated Bench"] = { sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Originally sold for 300 Illusionary Coins from Gamesmaster Fleurian in Falconwing Square.", tips = "Decor Duels was removed in Patch 12.1. Blizzard confirmed decor rewards would remain available, but did not confirm a replacement source for this toy; treat it as currently unavailable unless it returns.", waypoints = DECOR_DUELS_WAYPOINTS },
        ["Nap Mat"] = { sourceType = "World Event vendor", source = "Children's Week", acquisition = "During Children's Week, buy from Jepetto Joybuzz or another holiday vendor for 1 Well-loved Figurine.", tips = "A Well-loved Figurine is awarded instead of choosing a companion pet from an orphan questline. The item is sold in Silvermoon, Stormwind, Orgrimmar, and Dornogal during the holiday.", effect = "Places an interactable mat that lets a player lie down with a sleep effect; 20-minute cooldown." },
    },
    ["12.0.7"] = {
        ["Photo Finisher"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan for 1000 Timewarped Badges during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Ashen Horn of the Fallen Keeper"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan for 750 Timewarped Badges during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Oathstone Fragment"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan for 500 Timewarped Badges during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Madcap Redcap"] = { sourceType = "Raid drop", source = "Rotmire / Sporefall", acquisition = "Drops from Rotmire in Sporefall on raid difficulties.", effect = "Transforms nearby party members into Fungarians; 1-hour cooldown.", waypoints = SPOREFALL_WAYPOINTS },
        ["Mycomancer's Hearthspore"] = { sourceType = "Raid drop", source = "Rotmire / Sporefall", acquisition = "Drops from Rotmire in Sporefall on raid difficulties.", effect = "A Fungarian-themed cosmetic hearthstone.", waypoints = SPOREFALL_WAYPOINTS },
        ["Lightveil Recall Beacon"] = { sourceType = "Quest", source = "A Swampy Welcome to Naigtal", acquisition = "Reward from A Swampy Welcome to Naigtal during the Naigtal introduction.", tips = "It only functions while already inside Val or Naigtal and recalls you to that zone's active Umbral Base Camp. It may be hidden from the Toy Box while outside those zones.", effect = "Recalls you to the active Umbral Base Camp in Val or Naigtal; 15-minute cooldown.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
    },
    ["12.1"] = {
        ["Ancient Amani Mask"] = { sourceType = "Treasure", source = "Sunken Diver's Chest / The Coiled Isle", acquisition = "Complete the northeastern Mlurkkr Massacre Curse Surge and defeat Ss'akrithos for Diver's Key Fragments. Combine 3 fragments into a Diver's Key, then open the Sunken Diver's Chest off the coast of Diver's Arch.", tips = "Only Ss'akrithos at the northeastern surge drops the key fragments; the other four Curse Surge bosses do not. Track the surge in the map's Events tab and keep the fragments until you have three.", effect = "Adds an Amani mask to your character for about 10 minutes; the effect cannot be manually removed.", waypoints = { "/way #2512 65.41 5.58 Sunken Diver's Chest / underwater off Diver's Arch", "/way #2512 71.2 31.3 Mlurkkr Massacre / Ss'akrithos" } },
        ["Companion Command Crystal"] = { sourceType = "Prey", source = "Preyhunter's Journey Season 2 Rank 4", acquisition = "Reach Preyhunter's Journey Season 2 Rank 4, then buy from Construct V'anore for 600 Remnant of Anguish.", effect = "Commands your active companion pet to attack a nearby critter.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Corrosive Victory"] = { sourceType = "Delves", source = "Fangs for the Memories / Azta'rec", acquisition = "Pick up the Season 2 delve questline at Delver's Headquarters, then defeat Azta'rec in Venomfall Deeps on any difficulty to complete Fangs for the Memories.", effect = "Applies a snake-themed visual illusion around your character.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        ["Effigy of Dundun"] = { sourceType = "Delves", source = "Telemancer Astrandis", acquisition = "Reach Delver's Journey Season 2 Rank 3, then buy the toy from Telemancer Astrandis in Silvermoon City.", effect = "Transforms your character into Dundun for 30 minutes.", waypoints = TELEMANCER_ASTRANDIS_WAYPOINTS },
        ["Forgotten Memento"] = { sourceType = "Treasure", source = "Grave of Someone Forgotten / The Coiled Isle", acquisition = "Inspect the Forgotten Soldier and Nameless Grave at the grave site, ask Zuzan, Nan'ja, and Ru'ko about Jin'ta, then return to the grave and loot the revealed treasure.", tips = "The three dialogue pins can be visited in any order, but the initial grave interactions must be done first and the final loot requires returning to the grave.", effect = "Transforms your character into a ghostly Amani troll and changes your display name to Unknown.", waypoints = { "/way #2512 67.21 48.38 Grave / Forgotten Soldier and Nameless Grave", "/way #2512 69.07 52.71 Zuzan / ask about Jin'ta", "/way #2512 70.38 58.45 Nan'ja / ask about Jin'ta", "/way #2512 66.38 57.24 Ru'ko / ask about Jin'ta" } },
        ["Idol of Blue Water and Blue Sky"] = { sourceType = "Treasure", source = "Amani Privateer's Cache / The Coiled Isle", acquisition = "Fish a Grisly Morsel from the Grisly Cod Pool and feed it to the Hungry Dolphin. During the 5-minute Blue Water, Blue Sky buff, loot the Waterlogged Crate and Broken Urn, combine both key halves, and open the Amani Privateer's Cache.", tips = "Do not start the two underwater containers until the dolphin grants the 5-minute buff. The crate and urn each provide one half of the cache key.", effect = "Turns you into a dolphin and greatly increases underwater swim speed on the Coiled Isle.", waypoints = { "/way #2512 71.82 66.66 Amani Privateer's Cache / final chest", "/way #2512 73.27 65.88 Grisly Cod Pool / fish Grisly Morsel", "/way #2512 73.09 67.02 Waterlogged Crate / first key half", "/way #2512 72.45 68.40 Broken Urn / second key half" } },
        ["Idol of Ula'tek"] = { sourceType = "Renown", source = "Jan'sari the Watchful", acquisition = "Reach Renown 13 with Zul'jarra's Forces, then buy from Jan'sari the Watchful for 4000 Voidlight Marl.", effect = "Transforms your character into a Child of Ula'tek.", waypoints = JANSARI_WAYPOINTS },
        ["Jaktu's Cursed Blade"] = { sourceType = "Treasure", source = "Jaktu's Cursed Blade / The Coiled Isle", acquisition = "Loot Jaktu's Cursed Blade at the marked spot on The Coiled Isle.", effect = "Haunts you for 10 minutes; Jak'tu occasionally appears and laughs.", waypoints = { "/way #2512 60.41 59.49 Jaktu's Cursed Blade" } },
        ["Malfunctioning Staff"] = { sourceType = "Treasure", source = "Malfunctioning Staff / The Coiled Isle", acquisition = "Loot the Malfunctioning Staff at the marked spot on The Coiled Isle.", effect = "Summons a dancing mage image.", waypoints = { "/way #2512 75.38 68.37 Malfunctioning Staff" } },
        ["Otoola's Recognition"] = { sourceType = "Vendor", source = "Navigator Otoola, Tokka's Landing", acquisition = "Buy from Navigator Otoola in Tokka's Landing for 10 Pristine Polygon.", effect = "Pins a gold starfish to a friend or foe.", waypoints = { "/way #2512 57.2 48.3 Navigator Otoola" } },
        ["Pearl of Jubilation"] = { sourceType = "Treasure", source = "Brine-Crusted Chest / The Coiled Isle", acquisition = "Search the four Bubbling Clams until one yields a Luminescent Pearl. Place it at the marked drop point by the cave; Nacretta takes the pearl and leaves a Dropped Key. Use that key on the Brine-Crusted Chest.", tips = "Empty clams are normal, so check all four. The chest is inside the nearby cave and cannot be opened directly with the pearl.", effect = "Transforms your character into a dancing crab.", waypoints = { "/way #2512 70.61 76.70 Brine-Crusted Chest / pearl drop point and final chest", "/way #2512 68.05 80.31 Bubbling Clam", "/way #2512 69.57 82.48 Bubbling Clam", "/way #2512 70.90 81.63 Bubbling Clam", "/way #2512 71.30 83.29 Bubbling Clam" } },
        ["Preyhunter's Masquerade"] = { sourceType = "Drop", source = "Ral'kala / Prey System", acquisition = "Drops from Ral'kala during Curse of the Isle. Contribute Ossified Relics at the Haunted Brazier for credit, then kill Ral'kala when the event completes.", effect = "Transforms your character into a floating mask.", waypoints = RALKALA_WAYPOINTS },
        ["Preyhunter's Trophy Stand"] = { sourceType = "Prey", source = "Preyhunter's Journey Season 2 Rank 4", acquisition = "Reach Preyhunter's Journey Season 2 Rank 4, then buy from Construct V'anore for 800 Remnant of Anguish.", effect = "Summons a trophy stand for displaying earned Prey achievement trophies.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ula'tek's Sssacrificial Rain"] = { sourceType = "PvP", source = "Tour of Duty: The Coiled Isle", acquisition = "Earn 1000 honor on The Coiled Isle while War Mode is enabled.", tips = "The requirement is honor earned, not a fixed number of killing blows. Farm near whichever War Mode objective or player rally is currently active; the two pins are practical gathering points, not mandatory kill locations.", effect = "While active, enemy players killed near you melt into a pile of goo.", waypoints = { "/way #2512 59.4 49.5 Tokka's Landing / War Mode rally point", "/way #2512 51.5 49.7 Tokka's Folly / War Mode rally point" } },
    },
}

PatchCatalog.cosmeticDetails = {
    ["12.1"] = {
        ["Cloak of the Hash'ura"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 2 with Zul'jarra's Forces, then buy the cloak from Jan'sari at Tokka's Landing.", tips = "The item is consumed when learned; use it from your bags to add the appearance to your Warband collection.", waypoints = JANSARI_WAYPOINTS },
        ["Tabard of the Hash'ura"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 10 with Zul'jarra's Forces, then buy the tabard from Jan'sari at Tokka's Landing.", tips = "The item is consumed when learned; use it from your bags to add the appearance to your Warband collection.", waypoints = JANSARI_WAYPOINTS },
        ["Shoulderguards of the Hash'ura"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 16 with Zul'jarra's Forces, then buy the shoulders from Jan'sari at Tokka's Landing.", tips = "Each Renown rank requires 2500 reputation. Complete the campaign, treasures, lore objects, rares, and weekly activities before repeating daily sources.", waypoints = JANSARI_WAYPOINTS },
        ["Mantle of Nalorakk"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 20 with Zul'jarra's Forces, then buy the mantle from Jan'sari at Tokka's Landing.", tips = "The item is consumed when learned; use it from your bags to add the appearance to your Warband collection.", waypoints = JANSARI_WAYPOINTS },
        ["Axe of the Amani"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 20 with Zul'jarra's Forces, then buy the cosmetic axe from Jan'sari at Tokka's Landing.", tips = "The item is consumed when learned; use it from your bags to add the appearance to your Warband collection.", waypoints = JANSARI_WAYPOINTS },
        ["Arsenal: Armaments of the Loa"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 15 with Zul'jarra's Forces, then buy the arsenal from Jan'sari for 5000 Voidlight Marl.", tips = "An arsenal teaches multiple weapon appearances. The collected state shows complete only after every distinct appearance reported by the transmog set API is learned.", waypoints = JANSARI_WAYPOINTS },
        ["Ensemble: Vestments of Jan'alai's Chosen"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 18 with Zul'jarra's Forces, then buy this cloth ensemble from Jan'sari for 5000 Voidlight Marl.", tips = "This is the cloth set. The item is consumed when learned and teaches all included appearances your Warband can collect.", waypoints = JANSARI_WAYPOINTS },
        ["Ensemble: Battlegear of Halazzi's Chosen"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 18 with Zul'jarra's Forces, then buy this leather ensemble from Jan'sari for 5000 Voidlight Marl.", tips = "This is the leather set. The item is consumed when learned and teaches all included appearances your Warband can collect.", waypoints = JANSARI_WAYPOINTS },
        ["Ensemble: Chainmail of Akil'zon's Chosen"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 18 with Zul'jarra's Forces, then buy this mail ensemble from Jan'sari for 5000 Voidlight Marl.", tips = "This is the mail set. The item is consumed when learned and teaches all included appearances your Warband can collect.", waypoints = JANSARI_WAYPOINTS },
        ["Ensemble: Warplate of Nalorakk's Chosen"] = { sourceType = "Renown Vendor", source = "Jan'sari the Watchful", acquisition = "Reach Renown 18 with Zul'jarra's Forces, then buy this plate ensemble from Jan'sari for 5000 Voidlight Marl.", tips = "This is the plate set. The item is consumed when learned and teaches all included appearances your Warband can collect.", waypoints = JANSARI_WAYPOINTS },
        ["Arsenal: Venom-Cursed Arms"] = { sourceType = "Vault Vendor", source = "Skull of Er'inye", acquisition = "Unlock the Skull of Er'inye through Warleader Abdumati's Vaults of Atal'Utek questline, then buy the arsenal for 25000 Corrosive Coins.", tips = "Corrosive Coins come from Vault events, dailies, the weekly, rares, enemies, and treasures. Upgrade the Altar of Corrosion before this purchase if you still need its power improvements.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Ensemble: Venom-Cursed Dragonhawk's Raiment"] = { sourceType = "Vault Vendor", source = "Skull of Er'inye", acquisition = "Unlock the Skull of Er'inye, then buy this cloth ensemble for 10000 Corrosive Coins.", tips = "The Skull unlock is account-wide after completing its questline once. This is the cloth armor set.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Ensemble: Venom-Cursed Lynx's Garb"] = { sourceType = "Vault Vendor", source = "Skull of Er'inye", acquisition = "Unlock the Skull of Er'inye, then buy this leather ensemble for 10000 Corrosive Coins.", tips = "The Skull unlock is account-wide after completing its questline once. This is the leather armor set.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Ensemble: Venom-Cursed Eagle's Scales"] = { sourceType = "Vault Vendor", source = "Skull of Er'inye", acquisition = "Unlock the Skull of Er'inye, then buy this mail ensemble for 10000 Corrosive Coins.", tips = "The Skull unlock is account-wide after completing its questline once. This is the mail armor set.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Ensemble: Venom-Cursed Bear's Guard"] = { sourceType = "Vault Vendor", source = "Skull of Er'inye", acquisition = "Unlock the Skull of Er'inye, then buy this plate ensemble for 10000 Corrosive Coins.", tips = "The Skull unlock is account-wide after completing its questline once. This is the plate armor set.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Vaunted Preyhunter's Plumed Helm"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 6, then buy this appearance from Construct V'anore in Silvermoon.", tips = "Triggering Prey traps near an active Prey objective is a steady source of Remnants of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Vaunted Preyhunter's Knapsack"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 6, then buy this appearance from Construct V'anore in Silvermoon.", tips = "Triggering Prey traps near an active Prey objective is a steady source of Remnants of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Vaunted Preyhunter's Shoulder-Spikes"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 6, then buy this appearance from Construct V'anore in Silvermoon.", tips = "Triggering Prey traps near an active Prey objective is a steady source of Remnants of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ensemble: Preyhunter's Polished Armor"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 7, then buy this plate ensemble for 1600 Remnants of Anguish.", tips = "The first weekly hunt gives the largest Journey progress; later hunts give sharply reduced progress.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ensemble: Preyhunter's Rugged Armor"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 7, then buy this mail ensemble for 1600 Remnants of Anguish.", tips = "The first weekly hunt gives the largest Journey progress; later hunts give sharply reduced progress.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ensemble: Preyhunter's Sleek Armor"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 7, then buy this leather ensemble for 1600 Remnants of Anguish.", tips = "The first weekly hunt gives the largest Journey progress; later hunts give sharply reduced progress.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ensemble: Preyhunter's Refined Armor"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 7, then buy this cloth ensemble for 1600 Remnants of Anguish.", tips = "The first weekly hunt gives the largest Journey progress; later hunts give sharply reduced progress.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Arsenal: Preyhunter's Lost Armaments"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Midnight Season 2 Preyhunter's Journey Rank 7, then buy the arsenal for 1600 Remnants of Anguish.", tips = "The first weekly hunt gives the largest Journey progress. For Remnants, accept a hunt and trigger Prey traps around an active Prey world quest.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Ophidian Patagia"] = { sourceType = "Delve Vendor", source = "Naleidea Rivergleam", acquisition = "Buy this Season 2 cloak appearance from Naleidea Rivergleam at the Delver's Headquarters in Silvermoon.", tips = "Naleidea stands beside the Delver's Guide. The item is consumed when learned.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Corroded Patagia"] = { sourceType = "Delve Drop", source = "Abundantly Bountiful Heavy Trunk", acquisition = "Open Abundantly Bountiful Heavy Trunks in Midnight Season 2 delves for a chance at this cloak appearance.", tips = "Player reports confirm it can drop in different Season 2 delves and does not require the delve to be Bountiful. Higher tiers and Nemesis strongboxes are reported sources, but the drop remains random.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Apophic Patagia"] = { sourceType = "Delve Achievement", source = "My Venomous Nemesis", acquisition = "Defeat Azta'rec in Venomfall Deeps on any difficulty before Midnight Season 2 ends.", tips = "Start the Season 2 delve questline at Delver's Headquarters. This reward is seasonal, so complete it before the next season begins.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        ["Soulcoiler's Rush'kah"] = { sourceType = "Raid Bonus Loot", source = "Nek'zali the Soulcoiler / The Venomous Abyss", acquisition = "Defeat Nek'zali on any raid difficulty for a chance at this cosmetic head appearance as bonus loot.", tips = "Nek'zali is the first raid boss; use the Vaults entrance or one of the three surface gates marked on the map.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Hex Lord's Visage"] = { sourceType = "Raid Bonus Loot", source = "The Coiled Altar / The Venomous Abyss", acquisition = "Defeat The Coiled Altar on any raid difficulty for a chance at this cosmetic head appearance as bonus loot.", tips = "The Coiled Altar is the seventh encounter. Use the Vaults entrance or one of the three Coiled Isle gates marked on the map.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Hex Lord's Gaze"] = { sourceType = "Mythic Raid Bonus Loot", source = "The Coiled Altar / The Venomous Abyss", acquisition = "Defeat The Coiled Altar on Mythic difficulty for a chance at this cosmetic head appearance as bonus loot.", tips = "This version is Mythic-only. The Coiled Altar is the seventh encounter.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Envenomed Game Ripper"] = { sourceType = "Friendship Vendor", source = "Second Mate Sluggs / Captain Tokka", acquisition = "Raise friendship with Captain Tokka until Second Mate Sluggs offers this cosmetic weapon, then buy it at Tokka's Folly.", tips = "Complete Cursed Surges and the weekly surge quest while working on Captain Tokka friendship.", waypoints = SECOND_MATE_SLUGGS_WAYPOINTS },
        ["Quiver of the Drowned Marksman"] = { sourceType = "Treasure", source = "Waterlogged Basket", acquisition = "Loot the Waterlogged Basket in the northern waters of the Coiled Isle to learn this back appearance.", tips = "The basket is underwater. Approach the precise pin from the nearby coast and use an underwater-breathing or swim-speed effect if available.", waypoints = { "/way #2512 49.33 31.96 Waterlogged Basket / Quiver of the Drowned Marksman" } },
        ["Illusion: Venomcoil"] = { sourceType = "PvP", source = "Midnight Season 2 Rival II", acquisition = "Reach 1950 rating in rated PvP during Midnight Season 2, then use the item to learn the Venomcoil weapon illusion.", tips = "This is a seasonal rated-PvP reward and has no world-map vendor location." },
        ["Insidious Venomstone"] = { sourceType = "Seasonal Achievement", source = "Sssensational!", acquisition = "Complete one route for Sssensational!: defeat Ula'tek on Mythic, reach 2500 Mythic+ rating, or earn Elite in rated PvP during Midnight Season 2. Then use the rewarded item.", tips = "Using the Venomstone unlocks the extra visual effects for Midnight Season 2 class-set appearances Warband-wide. The addon tracks the hidden completion quest set by using the item, not merely earning the achievement." },
    },
}

PatchCatalog.mountDetails = {
    ["12.0"] = {
        ["Arcanovoid Construct"] = { category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Nullaeus", acquisition = "Defeat Nullaeus, the Midnight Season 1 Delve Nemesis, solo on the required high tier.", tips = "This was a Season 1 Feat of Strength and is no longer obtainable after the season ended.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Light-Forged Mechsuit"] = { category = "Achievements", sourceType = "Pre-patch achievement", source = "Two Minutes to Midnight", acquisition = "During the Midnight pre-patch, defeat all 19 Twilight's Blade rare bosses for Two Minutes to Midnight.", tips = "The pre-patch event has ended, so this mount is currently unavailable.", waypoints = { "/way #241 49.6 81.2 Former Midnight pre-patch camp" } },
        ["Retrained Skyrazor"] = { category = "Vendor", sourceType = "Pre-patch vendor", source = "Materialist Ophinell", acquisition = "Was sold at the Midnight pre-patch resistance camp for 100 Twilight's Blade Insignia.", tips = "The pre-patch event has ended, so this vendor source is currently unavailable.", waypoints = { "/way #241 49.8 81.3 Materialist Ophinell / former event camp" } },
        ["Elven Arcane Guardian"] = { category = "Delves", sourceType = "Vendor", source = "Naleidea Rivergleam, Delver's Headquarters in Silvermoon", acquisition = "Buy from Naleidea Rivergleam for 10000 Undercoin.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Silvermoon's Arcane Defender"] = { category = "Delves", sourceType = "Vendor", source = "Telemancer Astrandis, Delver's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Delver's Journey Rank 5, then buy from Telemancer Astrandis for 10 Voidlight Marl.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Giganto Manis"] = { category = "Delves", sourceType = "Achievement", source = "Glory of the Midnight Delver", acquisition = "Complete the Midnight delve meta-achievement, including delve story, sturdy chest, curio, and Nemesis objectives." },
        ["Preyseeker's Hubris"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 5, then buy for 2000 Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyseeker's Wrath"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 10, then buy for 2000 Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyseeker's Nightmare"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Prey: Nightmare Mode III", acquisition = "Defeat every Midnight Prey target on Nightmare difficulty.", tips = "This was a Season 1 reward and is no longer obtainable after the season ended.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Calamitous Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Master: Season 1", acquisition = "Earn at least 2000 Mythic+ rating during Midnight Season 1.", tips = "Season 1 has ended; the rating reward is no longer obtainable." },
        ["Convalescent Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Legend: Season 1", acquisition = "Earn at least 3000 Mythic+ rating during Midnight Season 1.", tips = "Season 1 has ended; the rating reward is no longer obtainable." },
        ["Lucent Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Degentrius in Magisters' Terrace", acquisition = "Chance from Degentrius on Mythic difficulty or the Magisters' Terrace Mythic+ Challenger's Cache.", tips = "Magisters' Terrace was in the Season 1 rotation. Farm it again when Mythic or Mythic+ access returns.", waypoints = { "/way #2424 62.39 14.55 Magisters' Terrace entrance" } },
        ["Spectral Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Restless Heart in Windrunner's Spire", acquisition = "Chance from Restless Heart on Mythic difficulty or the Windrunner's Spire Mythic+ Challenger's Cache.", tips = "Windrunner's Spire was in the Season 1 rotation. Farm it again when Mythic or Mythic+ access returns.", waypoints = { "/way #2395 35.2 78.4 Windrunner's Spire entrance" } },
        ["Crimson Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Midnight Glyph Hunter", acquisition = "Collect every Skyriding Glyph in Eversong Woods, Zul'Aman, Harandar, and Voidstorm.", tips = "The pins are ordered by zone. Witherbark Bluffs is below its bridge; several Harandar glyphs sit above or beneath giant roots.", waypoints = MIDNIGHT_GLYPH_WAYPOINTS, mapAchievementId = 61584, waypointCriteria = MIDNIGHT_GLYPH_CRITERIA },
        ["Cerulean Hawkstrider"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Low chance from any Eversong Woods rare.", tips = "Each rare has one eligible loot attempt per day. Run the full route; alts and alternate group phases provide more attempts.", waypoints = EVERSONG_RARE_WAYPOINTS },
        ["Cobalt Dragonhawk"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Low chance from any Eversong Woods rare.", tips = "Each rare has one eligible loot attempt per day. Run the full route; alts and alternate group phases provide more attempts.", waypoints = EVERSONG_RARE_WAYPOINTS },
        ["Amani Sharptalon"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Low chance from any Zul'Aman rare.", tips = "Each rare has one eligible loot attempt per day; several route pins mark cave entrances or underwater targets.", waypoints = ZULAMAN_RARE_WAYPOINTS },
        ["Escaped Witherbark Pango"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Low chance from any Zul'Aman rare.", tips = "Each rare has one eligible loot attempt per day; several route pins mark cave entrances or underwater targets.", waypoints = ZULAMAN_RARE_WAYPOINTS },
        ["Rootstalker Grimlynx"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Low chance from any Harandar rare.", tips = "Each rare has one eligible loot attempt per day. Use the cave-entrance and patrol notes rather than waiting on the exact pin.", waypoints = HARANDAR_RARE_WAYPOINTS },
        ["Vibrant Petalwing"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Low chance from any Harandar rare.", tips = "Each rare has one eligible loot attempt per day. Use the cave-entrance and patrol notes rather than waiting on the exact pin.", waypoints = HARANDAR_RARE_WAYPOINTS },
        ["Ruddy Sporeglider"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Peculiar Cauldron in Harandar", acquisition = "Collect 150 Crystallized Resin Fragments from Flame-Hardened Sap along the northern river, then open the Peculiar Cauldron.", tips = "The sap is underwater. Sweep downstream from the northern lake toward the Den and return to the cauldron when you reach 150.", waypoints = { "/way #2413 40.7 28.1 Peculiar Cauldron", "/way #2413 40.0 21.4 Flame-Hardened Sap route start", "/way #2413 49.32 51.16 Flame-Hardened Sap route end" } },
        ["Untainted Grove Crawler"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Sporespawned Cache in Harandar", acquisition = "Use the Fungal Mallet in Fungara Village to gain the buff, then ring the nearby Mycelium Gong. The Sporespawned Cache appears next to the gong and can contain the mount.", waypoints = { "/way #2413 41.31 67.90 Fungal Mallet", "/way #2413 46.65 67.78 Mycelium Gong / Sporespawned Cache" } },
        ["Echo of Aln'sharan"] = { category = "Quest Rewards", sourceType = "Hidden turn-in", source = "Kuri in Harandar", acquisition = "Complete Legend of Aln'sharan, beginning with Tales of Sky, then collect 500 Mysterious Skyshards from Harandar mobs and delves and turn them in to Kuri.", tips = "Kuri is airborne near the zone edge; dismount if the interaction prompt does not appear.", waypoints = { "/way #2413 66.15 25.47 Kuri" } },
        ["Augmented Stormray"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Low chance from any Voidstorm rare.", tips = "Each rare has one eligible loot attempt per day. Some targets are inside caves or Slayer's Rise; follow the labels on the full route.", waypoints = VOIDSTORM_RARE_WAYPOINTS },
        ["Sanguine Harrower"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Low chance from any Voidstorm rare.", tips = "Each rare has one eligible loot attempt per day. Some targets are inside caves or Slayer's Rise; follow the labels on the full route.", waypoints = VOIDSTORM_RARE_WAYPOINTS },
        ["Ancestral War Bear"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Honored Warrior's Cache in Zul'Aman", acquisition = "Interact with Honored Warrior's Cache, collect four key items from guardian urn events across Zul'Aman, then return to open the cache.", waypoints = { "/way #2437 21.45 77.38 Honored Warrior's Cache", "/way #2437 32.69 83.50 Nalorakk's Cache", "/way #2437 34.55 33.46 Halazzi's Cache", "/way #2437 54.78 22.39 Jan'alai's Cache", "/way #2437 51.58 84.92 Akil'zon's Cache" } },
        ["Hexed Vilefeather Eagle"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Abandoned Ritual Skull in Zul'Aman", acquisition = "Farm 1000 Vile Essence from nearby enemies, then open the Abandoned Ritual Skull.", tips = "The essence grind is local to the skull area; keep the skull pin as your return point.", waypoints = { "/way #2437 44.7 44.1 Abandoned Ritual Skull" } },
        ["Insatiable Shredclaw"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Final Clutch of Predaxas", acquisition = "Complete the wind-trail traversal inside the southern Voidstorm cave, then open the Final Clutch of Predaxas.", tips = "Avoid the lightning circles and follow the wind trail; overlapping circle edges can leave a narrow safe lane, and movement abilities can shorten difficult gaps.", waypoints = { "/way #2405 48.91 78.34 Final Clutch of Predaxas / cave" } },
        ["Relinquished Scarlet Charger"] = { category = "Quest Rewards", sourceType = "Quest", source = "Relinquishing Relics", acquisition = "Complete the Relinquishing Relics questline." },
        ["Ashes of Belo'ren"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Midnight Falls / March on Quel'Danas", acquisition = "Drops on Mythic difficulty; three copies are guaranteed per kill while the raid is current.", waypoints = { "/way #2424 52.60 87.50 March on Quel'Danas entrance" } },
        ["Tenebrous Harrower"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Glory of the Midnight Raider", acquisition = "Complete the raid meta-achievement across The Dreamrift, The Voidspire, and March on Quel'Danas.", waypoints = MIDNIGHT_RAID_WAYPOINTS },
        ["Crimson Silvermoon Hawkstrider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 17, then buy for 6000 Voidlight Marl.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Fiery Dragonhawk"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 19, then buy for 8000 Voidlight Marl.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Peridot Dragonhawk"] = { category = "Quest Rewards", sourceType = "Campaign quest", source = "From Darkness, Light", acquisition = "Complete From Darkness, Light at the end of Midnight campaign Chapter 6." },
        ["Amani Blessed Bear"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 17, then buy for 6000 Voidlight Marl.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Amani Windcaller"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 19, then buy for 8000 Voidlight Marl.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Fierce Grimlynx"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 17, then buy from Naynar for 6000 Voidlight Marl.", waypoints = HARATI_WAYPOINTS },
        ["Cerulean Sporeglider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 19, then buy for 8000 Voidlight Marl.", waypoints = HARATI_WAYPOINTS },
        ["Ravenous Shredclaw"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 17, then buy for 6000 Voidlight Marl.", waypoints = SINGULARITY_WAYPOINTS },
        ["Voidbound Stormray"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 19, then buy for 8000 Voidlight Marl.", waypoints = SINGULARITY_WAYPOINTS },
        ["Lab-Grown Stormray"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Staring Into The Void", acquisition = "Complete the Void Research Console investigation by connecting a route to the final console node and spending the required weekly Uncontaminated Void Samples.", tips = "Samples are weekly-gated. The reward is mailed after completion, so check your mailbox if it does not appear immediately.", waypoints = SINGULARITY_WAYPOINTS },
        ["Frenzied Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy for 6000 Voidlight Marl.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Prowling Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy for 6000 Voidlight Marl.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Umbral Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Life of the Party", acquisition = "Reach maximum friendship with all four Silvermoon Court subfactions for Life of the Party.", tips = "Choose Court weekly activities that advance whichever subfaction is still below maximum.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Duskbrute Harrower"] = { category = "Rare Drops", sourceType = "Paragon Cache", source = "Slayer's Duellum Trove", acquisition = "Chance to drop from the Slayer's Duellum paragon cache.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Amani Sunfeather"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Buy from Chel the Chip for 6400 Unalloyed Abundance.", tips = "Abundant Harvest rotates to one of four caverns every 8 hours and requires a Shard of Dundun. A strong run can award up to 900 currency.", waypoints = ABUNDANCE_WAYPOINTS },
        ["Blessed Amani Burrower"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Buy from Chel the Chip for 6400 Unalloyed Abundance.", tips = "Abundant Harvest rotates to one of four caverns every 8 hours and requires a Shard of Dundun. A strong run can award up to 900 currency.", waypoints = ABUNDANCE_WAYPOINTS },
        ["Vivid Chloroceros"] = { category = "Vendor", sourceType = "Vendor currency", source = "Mothkeeper Wew'tam", acquisition = "Capture 50 Glowing Moths in Harandar, then buy for 10 Luminous Dust.", tips = "Moths unlock in sets through Hara'ti Renown; map icons can unlock later than the moths themselves, so search even before every icon is visible.", waypoints = { "/way #2413 49.2 54.4 Mothkeeper Wew'tam" } },
        ["Elder Glowmite"] = { category = "Vendor", sourceType = "Vendor currency", source = "Mothkeeper Wew'tam", acquisition = "Capture all 120 Glowing Moths in Harandar, then buy for 10 Luminous Dust.", tips = "The three moth sets unlock through Hara'ti Renown; revisit the route as more moths become visible.", waypoints = { "/way #2413 49.2 54.4 Mothkeeper Wew'tam" } },
        ["Vivacious Chloroceros"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Treasures of Harandar", acquisition = "Complete Treasures of Harandar and open the Gift of the Cycle reward if the mount is not granted directly.", waypoints = HARANDAR_TREASURE_WAYPOINTS, mapAchievementId = 61263, waypointCriteria = HARANDAR_TREASURE_CRITERIA },
        ["Brilliant Petalwing"] = { category = "Achievements", sourceType = "Meta-achievement", source = "Light Up the Night", acquisition = "Complete Forever Song, Making an Amani Out of You, That's Aln, Folks!, and Yelling into the Voidstorm.", tips = "Each criterion is the major exploration meta for one launch zone, so combine story, rare, treasure, and exploration routes before moving on." },
        ["Ivory Grimlynx"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Allied Race: Haranir", acquisition = "Unlock the Haranir allied race by completing the required Midnight storylines.", waypoints = HARATI_WAYPOINTS },
        ["Nether-Swept Drake"] = { category = "Professions", sourceType = "Fishing secret", source = "Nether-Warped Egg", acquisition = "Fish a Nether-Warped Egg from Voidstorm waters, an Oceanic Vortex, or a Patient Treasure, then wait 7 real days for it to hatch.", tips = "The egg is the collection bottleneck; keep it in your bags until its seven-day timer completes.", waypoints = { "/way #2405 48.0 60.0 Voidstorm open-water fishing route" } },
        ["Anu'shalla, Shadow's Guidance"] = { category = "Achievements", sourceType = "Collection achievement", source = "Insurmountable Collection", acquisition = "Collect 600 mounts usable by a single character." },
        ["Galactic Gladiator's Goredrake"] = { category = "PvP", sourceType = "Achievement", source = "Gladiator: Midnight Season 1", acquisition = "Win 50 3v3 arena games while at Elite rank during Midnight Season 1.", tips = "Season 1 has ended; this Gladiator reward is no longer obtainable." },
        ["Vicious Snaplizard"] = { category = "PvP", sourceType = "Achievement", source = "Midnight Season 1 Rated PvP", acquisition = "Fill the seasonal Vicious Saddle progress bar through rated PvP at 1000+ rating during Midnight Season 1.", tips = "Season 1 has ended; this seasonal mount is no longer obtainable from its original source." },
    },
    ["12.0.5"] = {
        ["Unbound Manawyrm"] = { category = "Vendor", sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Complete Void Response Team and Ritual Site Disruptor, then buy from Sergeant Vornin for 6000 Voidlight Marl.", tips = "Both metas span weekly rotations: the assault requires Eversong and Zul'Aman, while only one Ritual Site is active each week.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Hawkstrider"] = { category = "Vendor", sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown 8, then buy from Sergeant Vornin for 4500 Voidlight Marl.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Hex Eagle"] = { category = "Rare Drops", sourceType = "Ritual Site drop", source = "Broken Throne", acquisition = "In Broken Throne Tier 2 or higher, carry the nearby Misplaced Ritual Candle to the ritual circle, activate the candles, and kill the summoned Hex Eagle for a chance at the mount.", tips = "Learn this mount before attempting the Void-Scarred Eaglet secret in the tornado nest.", waypoints = BROKEN_THRONE_HEX_EAGLE_WAYPOINTS },
        ["Void-Touched Snapdragon"] = { category = "Rare Drops", sourceType = "Ritual Site drop", source = "Daggerspine Point", acquisition = "During a Daggerspine Point run, click Washed Up Kelp around the interior shoreline; a kelp can spawn the Void-Touched Snapdragon rare, which has a chance to drop the mount.", tips = "The updated Ritual Site guide lists this on any difficulty. Sweep every marked internal kelp point because only a small number may be active in a run.", waypoints = DAGGERSPINE_POINT_PETS_WAYPOINTS },
        ["Witherbark Warbear Mother"] = { category = "Rare Drops", sourceType = "Ritual Site secret", source = "Broken Throne", acquisition = "In Tier 2 or higher, feed 1 Practically Pork to the Lost Bear Cub to obtain Chubs. Bring 5 more pork to the northern meat piles with Chubs summoned, spawn the Angry Amani Warbear, and defeat it for the mount chance.", tips = "Gather all 6 Practically Pork before starting so you can complete the pet prerequisite and mount event in the same run.", waypoints = WITHERBARK_WARBEAR_WAYPOINTS },
        ["Void-Corrupted Lynx"] = { category = "Professions", sourceType = "Leatherworking", source = "Rope Lynx Harness", acquisition = "Crafted by Leatherworking. Both the Rope Lynx Harness pattern and the Broken Lynx Leash bind-on-pickup material come from Treasure and Rare Spoils in Ritual Sites.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Breaker Bee"] = { category = "Vendor", sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Originally bought as Magister's Spell Bee Comb for 600 Illusionary Coins from Gamesmaster Fleurian.", tips = "Decor Duels was removed in Patch 12.1, and Blizzard did not confirm a replacement source for the mount. Treat it as currently unavailable unless the reward returns.", waypoints = DECOR_DUELS_WAYPOINTS },
        ["Cerulean Deathwalker"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Amethyst Mechsuit"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Blue-Chip Shreddertank"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Profit-Green Shreddertank"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["High-Yield Shreddertank"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Speculative Shreddertank"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn Keystone Myth in Midnight Season 1, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Gilnean Iron Charger"] = { category = "Trading Post", sourceType = "Trading Post", source = "Future / patch-filtered Trading Post", acquisition = "Patch-filtered mount with Trading Post-style availability; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Gilnean Copper Charger"] = { category = "Trading Post", sourceType = "Trading Post", source = "Future / patch-filtered Trading Post", acquisition = "Patch-filtered mount with Trading Post-style availability; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Pyrewood Rebel's Rouncey"] = { category = "Trading Post", sourceType = "Trading Post", source = "Future / patch-filtered Trading Post", acquisition = "Patch-filtered mount with Trading Post-style availability; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Gilneas Loyalist's Rouncey"] = { category = "Trading Post", sourceType = "Trading Post", source = "Future / patch-filtered Trading Post", acquisition = "Patch-filtered mount with Trading Post-style availability; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Blossomback Arboon"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Azeroth Blossoms Anew", acquisition = "Purchase the Blossomback Arboon through the Battle.net Shop; there is no in-world location." },
        ["Amberback Arboon"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Azeroth Blossoms Anew", acquisition = "Purchase the Amberback Arboon through the Battle.net Shop; there is no in-world location." },
        ["Dusk-Painted Sun Roc"] = { category = "Trading Post", sourceType = "Trading Post", source = "June 2026 Trading Post", acquisition = "Originally sold for 700 Trader's Tender in June 2026. Check future Trading Post or Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Flame-Painted Sun Roc"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "June 2026 Traveler's Log", acquisition = "Awarded for completing the June 2026 Traveler's Log. It is no longer in the active monthly reward slot; watch for a future return.", waypoints = TRADING_POST_WAYPOINTS },
        ["[PH] Giant Eagle Sunwalker Mount Blue"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead 12.0.5 mount filter", acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet." },
        ["[PH] Giant Eagle Sunwalker Mount White"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead 12.0.5 mount filter", acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet." },
        ["The Sire's Palanquin"] = { category = "Promotion", sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; no general-region in-world source is available." },
        ["Scarlet Lady"] = { category = "Promotion", sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; no general-region in-world source is available." },
        ["Sha-Warped Riding Wolf"] = { category = "Promotion", sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; no general-region in-world source is available." },
        ["Sha-Warped Owl"] = { category = "Promotion", sourceType = "Regional promotion", source = "China / Crimson Tide Treasure", acquisition = "China-region promotional reward; no general-region in-world source is available." },
        ["Zothwing Darkseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Patch-filtered shop mount", acquisition = "Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Zothwing Deepseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Patch-filtered shop mount", acquisition = "Purchase availability is handled through the shop, so there is no in-world map source." },
    },
    ["12.0.7"] = {
        ["Dusk Grimlynx"] = { category = "Quest Rewards", sourceType = "Questline", source = "Legacy of the Amani / Hagar's Invitation", acquisition = "Accept Hagar's Invitation in Silvermoon and progress the Legacy of the Amani storyline; the mount is awarded early in the chain.", tips = "Continue the same chapter through Dead End if you also need the Akiki pet.", waypoints = { "/way #2393 45.45 70.26 Hagar's Invitation / Legacy of the Amani" } },
        ["Amani Hex Bear"] = { category = "Other", sourceType = "Unknown", source = "Wowhead 12.0.7 mount filter", acquisition = "The 12.0.7 mount guide still lists this as unknown, so no coordinate is attached." },
        ["Stoneforged Sentinel"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "In-Game Shop", acquisition = "Purchase through the shop; no in-world map source." },
        ["Luminous Sporeglider"] = { category = "Dungeon and Raids", sourceType = "Raid drop / weekly combine", source = "Rotmire / Sporefall", acquisition = "Defeat Rotmire in Sporefall once per weekly reset to receive one Delicious Sporesnack, then combine four to learn the mount.", tips = "The snack is once per Warband each week on any difficulty, and there is no catch-up; plan on four weekly kills.", waypoints = SPOREFALL_WAYPOINTS },
        ["Netherforged Nullframe"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Complete A Trip Through the Stars, then buy from Kifaan for 15 Voidlight Marl.", tips = "The meta uses Naigtal criteria and may take more than one Naigtal rotation because its stories and world quests rotate.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Voidmancer's Starcarver"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Complete A Trip Around the Stars, then buy from Kifaan for 15 Voidlight Marl.", tips = "The meta combines the Val story, climate event, six rares, eight world quests, and shared introduction/preparation achievements.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Tortured Gorger"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Complete Heroic Showdowns, then buy from Kifaan for 15 Voidlight Marl.", tips = "The meta needs both Val and Naigtal Heroic weeks and therefore takes at least two weekly zone rotations.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Sun Festival's Painted Roc"] = { category = "World Events", sourceType = "Holiday boss", source = "Frost Lord Ahune / Midsummer Fire Festival", acquisition = "During Midsummer Fire Festival, loot the first eligible Satchel of Chilled Goods each day across the Warband for an increasing chance at the mount.", waypoints = AHUNE_WAYPOINTS },
        ["Spawn of Vyranoth"] = { category = "Achievements", sourceType = "Achievement / future vendor", source = "Master of the Turbulent Timeways V", acquisition = "Originally required Mastery of Timeways in four different weeks of Turbulent Timeways V; the 2026 event ended August 11.", tips = "Missed Turbulent Timeways mounts are expected to cost 5000 Timewarped Badges when the next event begins. Xydan appears only during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Blackwater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post mount priced at 700 Trader's Tender; check the current monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Bilgewater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "July 2026 Traveler's Log", acquisition = "Awarded for completing the July 2026 Traveler's Log. Watch future Trading Post returns if it was missed.", waypoints = TRADING_POST_WAYPOINTS },
        ["Green Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined placeholder recolor; check future Trading Post inventory.", waypoints = TRADING_POST_WAYPOINTS },
        ["Pink Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined placeholder recolor; check future Trading Post inventory.", waypoints = TRADING_POST_WAYPOINTS },
        ["Sunflare Driftmoth"] = { category = "In-Game Shop", sourceType = "Battle.net Shop / subscription bundle", source = "In-Game Shop", acquisition = "Shop or subscription-bundle mount with no in-world map source." },
        ["Spring Panda"] = { category = "Promotion", sourceType = "Regional promotion", source = "China-exclusive promotion", acquisition = "China-region promotional reward; no general-region in-world source is available." },
        ["Rabbit'ath"] = { category = "Promotion", sourceType = "BlizzCon 2026 Bundle", source = "Battle.net Shop", acquisition = "Included in the World of Warcraft BlizzCon 2026 Bundle and BlizzCon Ultimate Collection." },
        ["[PH] Horse with Hat"] = { category = "Trading Post", sourceType = "Unavailable placeholder", source = "Trading Post data", acquisition = "Datamined Trading Post placeholder that has not been made available; there is no active collection method." },
        ["Shadow Spirehawk"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "In-Game Shop", acquisition = "Purchase through the Battle.net Shop; there is no in-world map location." },
    },
    ["12.1"] = {
        ["Amethyst Mechsuit"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn the high Mythic+ seasonal rating reward choice, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Apophic Soul Crusher"] = { category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Azta'rec", acquisition = "Defeat Azta'rec solo on Nemesis (Tier ??) difficulty during Midnight Season 2.", tips = "Start from the Season 2 quest at Delver's Headquarters, then enter Venomfall Deeps. Mark the four quadrants and record the seven-step memory sequence; move toward center before the 90%, 60%, and 30% intermissions, and never miss the lethal interrupt or dispel.", waypoints = VENOMFALL_DEEPS_WAYPOINTS },
        ["Badlands Buzzard"] = { category = "Trading Post", sourceType = "Trading Post", source = "August 2026 Trading Post", acquisition = "Available from the August 2026 Trading Post for 550 Trader's Tender. Check the standard Trading Post stalls or future Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Bilgewater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "July 2026 Traveler's Log", acquisition = "Earned as the July 2026 Traveler's Log completion reward through the Trading Post interface.", waypoints = TRADING_POST_WAYPOINTS },
        ["Blackwater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Trading Post / Traveler's Log", source = "Trading Post", acquisition = "Trading Post reward. Check the monthly Trading Post inventory and Outlet returns; use the freeze slot if it appears before you have enough Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Blue-Chip Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Corroded Soul Crusher"] = { category = "Delves", sourceType = "Vendor", source = "Telemancer Astrandis", acquisition = "Reach Delver's Journey Rank 5 in Season 2, then buy from Telemancer Astrandis in Silvermoon.", waypoints = TELEMANCER_ASTRANDIS_WAYPOINTS },
        ["Delver's Arcane Golem"] = { category = "Delves", sourceType = "Delve treasure", source = "Sturdy Chest / Gnarldor Isle", acquisition = "Loot the Sturdy Chest at 60.43, 68.11 inside the Gnarldor Isle delve. If the mount item is not visible in the chest window, finish or leave the delve and check your mailbox; live reports confirm it can be delivered by post.", tips = "This is the southern of the three Sturdy Chests. The delve map may reject waypoint commands, so set the pin before entering or use the coordinate-only fallback while inside.", waypoints = { "/way #2635 60.43 68.11 Sturdy Chest / Delver's Arcane Golem" } },
        ["Breath of Blight"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Master: Season 2", acquisition = "Earn 2000 Mythic+ rating during Midnight Season 2.", tips = "The published estimate is close to timing nearly every Season 2 dungeon at +7. Rating comes from the seasonal dungeon queue, so there is no meaningful single map pin." },
        ["Breath of Ruin"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Legend: Season 2", acquisition = "Earn 3000 Mythic+ rating during Midnight Season 2.", tips = "The published estimate is roughly every Season 2 dungeon at +12 with some +13s. Rating comes from the seasonal dungeon queue, so there is no meaningful single map pin." },
        ["Cerulean Deathwalker"] = { category = "Dungeon and Raids", sourceType = "Seasonal rating reward", source = "Lindormi / Timelost Saddle", acquisition = "Earn the high Mythic+ seasonal rating reward choice, then spend the Timelost Saddle at Lindormi for this recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Crested Aqua Leafmimic"] = { category = "Trading Post", sourceType = "Trading Post", source = "September 2026 Trading Post", acquisition = "Available from the September 2026 Trading Post for 500 Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Crested Ember Leafmimic"] = { category = "Trading Post", sourceType = "Traveler's Log", source = "September 2026 Trading Post", acquisition = "Earned as the September 2026 Traveler's Log completion reward from the Trading Post.", waypoints = TRADING_POST_WAYPOINTS },
        ["Crested Verdant Leafmimic"] = { category = "Trading Post", sourceType = "Trading Post", source = "September 2026 Trading Post", acquisition = "Available from the September 2026 Trading Post for 500 Trader's Tender.", waypoints = TRADING_POST_WAYPOINTS },
        ["Hexflame Reaver"] = { category = "Rare Drops", sourceType = "Drop", source = "Ral'kala, Prey: A Ghostly Nightmare", acquisition = "Chance to drop from Ral'kala during Curse of the Isle. Farm Ossified Relics and contribute them at an active Haunted Brazier; Ral'kala spawns when players collectively offer 100 relics.", tips = "Always contribute at least one relic before the summon completes to gain the improved-loot buff. Group Finder searches for Ral'kala or Haunted Brazier are faster than filling a brazier alone.", waypoints = RALKALA_WAYPOINTS },
        ["Dusk Grimlynx"] = { category = "Quest Rewards", sourceType = "Questline", source = "Legacy of the Amani / Hagar's Invitation", acquisition = "Wowhead comments report accepting Hagar's Invitation from Orweyna in Silvermoon and progressing the Legacy of the Amani questline; comments also mention the Suggested Content tab workaround for The Preparations Are Complete.", waypoints = { "/way #2393 45.6 70.0 Orweyna" } },
        ["High-Yield Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Luminous Sporeglider"] = { category = "Dungeon and Raids", sourceType = "Drop / weekly combine", source = "Rotmire / Sporefall", acquisition = "Defeat Rotmire in Sporefall once per weekly reset to earn one Delicious Sporesnack, then combine four Delicious Sporesnacks to learn the mount. Difficulty changes gear rewards, not the four-week mount timeline.", waypoints = SPOREFALL_WAYPOINTS },
        ["Netherforged Nullframe"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Preyhunter's Fury"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore", acquisition = "Reach Preyhunter's Journey Season 2 Rank 10, then buy from Construct V'anore for 2250 Remnant of Anguish.", tips = "The first weekly hunt awards 5000 Journey, the next three award 1000 each, and later hunts award only 50. For Remnants, accept a hunt and trigger Prey traps around an active Prey world quest.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Profit-Green Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Spawn of Vyranoth"] = { category = "Achievements", sourceType = "Achievement / future Timewalking vendor", source = "Master of the Turbulent Timeways V / Xydan", acquisition = "The original reward required Mastery of Timeways in four different weeks of Turbulent Timeways V, which ended August 11, 2026. Missed Turbulent Timeways mounts become vendor purchases for 5000 Timewarped Badges when the next Turbulent Timeways event begins.", tips = "Xydan is present only while Dragonflight Timewalking is active. The pin is the vendor location; the mount may not appear there until a later Turbulent Timeways begins.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Speculative Shreddertank"] = { category = "Vendor", sourceType = "Vendor / seasonal reward", source = "Lindormi / Timelost Saddle", acquisition = "Spend a Timelost Saddle at Lindormi for this seasonal vendor recolor.", waypoints = LINDORMI_WAYPOINTS },
        ["Sun Festival's Painted Roc"] = { category = "World Events", sourceType = "Holiday boss", source = "Frost Lord Ahune / Midsummer Fire Festival", acquisition = "During Midsummer Fire Festival, queue for The Frost Lord Ahune or speak to an Earthen Ring Elder at a main Midsummer camp. The first eligible Satchel of Chilled Goods each day across the Warband can contain the mount, with bad-luck protection increasing the chance after misses.", waypoints = AHUNE_WAYPOINTS },
        ["Tortured Gorger"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Caustic Venomfang"] = { category = "Vendor", sourceType = "Vendor", source = "Skull of Er'inye", acquisition = "Unlock Skull of Er'inye account-wide by completing Vaults Of Atal'Utek: Certain Doom from Warleader Abdumati, then buy Caustic Venomfang for 10000 Corrosive Coin.", tips = "Corrosive Coins come from Vault events, dailies, the weekly, rares, enemies, and treasures. Upgrade the Altar of Corrosion before this cosmetic purchase if you still need its power and coin-earning improvements.", waypoints = SKULL_OF_ERINYE_WAYPOINTS },
        ["Sea-Dwelling Isle Serpent"] = { category = "Vendor", sourceType = "Vendor", source = "Second Mate Sluggs", acquisition = "Reach Bloodsworn Crew (8400 reputation) with Captain Tokka, buy The Coiled Huntress rod for 6000 Voidlight Marl, equip it while fishing successfully on the Coiled Isle, and have Seasage Polo convert the rod's venom stacks 1:1 into Coiled Filament. Buy the mount from Second Mate Sluggs for 2500 Coiled Filament.", tips = "Fishing directly in the island's venom is faster than hunting pools; gray catches do not add a venom stack. The rod's stored total is shown on its tooltip in the Fishing profession equipment slot.", waypoints = { "/way #2512 57.21 48.63 Captain Tokka / unlock reputation", "/way #2512 51.62 49.84 Second Mate Sluggs / rod and mount vendor", "/way #2512 51.55 49.92 Seasage Polo / convert venom to Coiled Filament" } },
        ["Venomous Gladiator's Goredrake"] = { category = "PvP", sourceType = "Achievement", source = "Gladiator: Midnight Season 2", acquisition = "Reach Elite rank, then win 50 rated 3v3 Arena games while remaining at Elite during Midnight Season 2.", tips = "Only rated 3v3 wins at Elite qualify; 2v2, Solo Shuffle, and Battleground Blitz do not substitute. This queue-based seasonal reward has no single map location." },
        ["Vicious Lightbloom Boar"] = { category = "PvP", sourceType = "Achievement", source = "Venomous Combatant", acquisition = "Reach 1000 rating, then win rated PvP matches during Midnight Season 2 until the Season Rewards bar is full. Alliance and Horde have separate faction-colored variants.", tips = "Watch the Rated PvP Season Rewards bar rather than a quoted win total, because progress differs by bracket. Additional full bars award Vicious Saddles. This queue-based reward has no single map location." },
        ["Crimson Venomfang"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Glory of the Venomous Raider", acquisition = "Complete all eight boss achievements in The Venomous Abyss on Normal difficulty or higher.", tips = "The required achievements are Well, Well, Little Sky; Is Venom Stasis A Joke To You?; Accidental Inclusion; Kept You Waiting Huh?; Jumping Through Hoops; Taking a Bite out of Slime; Watch Out Behind You; and No Egg Scramble. Buy Balm of Flies inside the raid before Nek'zali, light the incense left of Sszorak's stairs, and organize a Greasy Hatchling relay before Ula'tek.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["Primeval Skyfriend"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Ula'tek / The Venomous Abyss", acquisition = "Drops from Ula'tek, the final boss of The Venomous Abyss, on Mythic difficulty only.", waypoints = THE_VENOMOUS_ABYSS_WAYPOINTS },
        ["The Writhing Brood"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Zul'jan / Altar of Fangs", acquisition = "Drops from Zul'jan, the final boss of Altar of Fangs, on Mythic and Mythic+ difficulty.", waypoints = ALTAR_OF_FANGS_WAYPOINTS },
        ["Indigo Coiled Horror"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Jan'sari the Watchful, Zul'jarra's Forces", acquisition = "Reach Zul'jarra's Forces Renown 17, then buy from Jan'sari the Watchful for 6000 Voidlight Marl.", tips = "Each Renown rank requires 2500 reputation. Prioritize the campaign, side quests, 22 treasures, 10 lore objects, and 12 rares before settling into weekly and daily sources.", waypoints = JANSARI_WAYPOINTS },
        ["Violet-Backed Skyfang"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Jan'sari the Watchful, Zul'jarra's Forces", acquisition = "Reach Zul'jarra's Forces Renown 19, then buy from Jan'sari the Watchful for 8000 Voidlight Marl.", tips = "Each Renown rank requires 2500 reputation. Prioritize the campaign, side quests, 22 treasures, 10 lore objects, and 12 rares before settling into weekly and daily sources.", waypoints = JANSARI_WAYPOINTS },
        ["Spirit of Tok'jara"] = { category = "Quest Rewards", sourceType = "Questline", source = "The Innocent Essence quest chain / Zul'jarra's Forces Renown 10", acquisition = "Reach Zul'jarra's Forces Renown 10, then complete Du'gal's six daily quests: Ancestral Gems, Dark Charms, Spirit Totems, Ancient Weapons, Loa Idols, and The Innocent Essence.", tips = "Only one quest becomes available per day, so the mount takes six days after the chain is unlocked. Return to Du'gal at the Amani Foothold after each daily reset.", waypoints = { "/way #2509 50.43 63.65 Du'gal / daily quest chain" } },
        ["Auriferous Venomfang"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Treasures of the Coiled Isle", acquisition = "Loot all 22 hidden treasures on The Coiled Isle. Several treasures require short interaction chains, keys, nearby NPC dialogue, fishing, or temporary objects before the final treasure can be opened.", mapAchievementId = 63359, waypointCriteria = COILED_ISLE_TREASURE_CRITERIA, waypoints = COILED_ISLE_TREASURE_WAYPOINTS },
        ["Ruby Writhe"] = { category = "Rare Drops", sourceType = "Drop", source = "Coiled Isle rares", acquisition = "Very low chance from Coiled Isle rares. Each rare has roughly a 10-15 minute respawn during active play, but each character gets only one loot chance per rare per day.", tips = "Use the route in map order, then switch characters after all 12 daily loot chances. Farthik requires clicking the Unguarded Treasure Chest; Szarith and Nar'zira are on nested interior maps.", waypoints = COILED_ISLE_RARE_WAYPOINTS },
        ["Topaz Skyfang"] = { category = "Rare Drops", sourceType = "Drop", source = "Coiled Isle rares", acquisition = "Very low chance from Coiled Isle rares. Each rare has roughly a 10-15 minute respawn during active play, but each character gets only one loot chance per rare per day.", tips = "Use the route in map order, then switch characters after all 12 daily loot chances. Farthik requires clicking the Unguarded Treasure Chest; Szarith and Nar'zira are on nested interior maps.", waypoints = COILED_ISLE_RARE_WAYPOINTS },
        ["Emerald Skyfang"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Pro Poison Patroller", acquisition = "Complete 250 patrols within the Vaults of Atal'Utek. Five patrols can be active in each 10-minute wave.", tips = "Run the high-ground circuit to reveal nearby patrol icons, clear the active set, then wait at the Amani Foothold for the next :00/:10/:20 wave. Sulfurous Sludgefish or stealth avoids most trash.", waypoints = VAULTS_ASSAULT_WAYPOINTS },
        ["Venomous Coiler"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Assault the Vault", acquisition = "Complete all ten Vaults of Atal'Utek meta-achievements, including every patrol, strike, incursion, Ancient Foe, Funerary Inscription, Underbelly target, and Altar of Corrosion node.", tips = "This is time-gated by at least three weekly Ancient Foe rotations and Renown 14. Use the nested Underbelly and Vault of Restless Bones pins for criteria that are not on the main Vaults map.", waypoints = VAULTS_ASSAULT_WAYPOINTS },
        ["Voidmancer's Starcarver"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan / Umbral Bazaar", acquisition = "Buy from Kifaan at the Umbral Bazaar base camps. Check both Naigtal and Val camp locations if the vendor is not present where you are phased.", waypoints = KIFAAN_WAYPOINTS },
        ["Umbral Ashes"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Umbral Champion: Midnight Season 1", acquisition = "End Midnight Mythic+ Season 1 in the top 1% of Mythic+ rating in your region.", tips = "Season 1 has ended and the reviewed rewards have been distributed, so this mount can no longer be earned. Eligible players receive the achievement reward and Lindormi's in-game mail." },
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

-- Shadowlands 9.1 through 9.1.7 backfill. The client snapshots contain many
-- internal and promotional records, so these details only describe the audited
-- permanent and seasonal collection rows retained above.
PatchCatalog.achievementCategories["9.1"] = {}
PatchCatalog.achievementDetails["9.1"] = {}
for _, achievementId in ipairs(PATCH_9_1_ACHIEVEMENTS) do
    local category = "Exploration"
    local acquisition = "Complete the matching Chains of Domination campaign, Korthia, Maw, covenant-assault, collection, or reputation objective."
    if (achievementId >= 14966 and achievementId <= 14976) or achievementId == 14999 or achievementId == 15102 then
        category = "PvP"
        acquisition = "Complete the matching Shadowlands Season 2 rated PvP or armor-collection objective."
    elseif achievementId == 14998 or achievementId == 15003 or achievementId == 15040 or achievementId == 15058
        or achievementId == 15065 or achievementId == 15105 or achievementId == 15108
        or (achievementId >= 15112 and achievementId <= 15135)
        or (achievementId >= 15182 and achievementId <= 15184)
        or achievementId == 15191 or achievementId == 15196 or achievementId == 15197 then
        category = "Raids"
        acquisition = "Complete the matching Sanctum of Domination raid objective."
    elseif (achievementId >= 15045 and achievementId <= 15052)
        or achievementId == 15073 or achievementId == 15077 or achievementId == 15078
        or achievementId == 15106 or achievementId == 15109
        or (achievementId >= 15177 and achievementId <= 15179)
        or achievementId == 15185 or achievementId == 15190 then
        category = "Dungeons"
        acquisition = "Complete the matching Shadowlands Season 2 Mythic+ or Tazavesh objective."
    elseif achievementId == 15067 or (achievementId >= 15075 and achievementId <= 15096) then
        category = "Other"
        acquisition = "Complete the matching Torghast scoring, Adamant Vaults, or Box of Many Things objective."
    elseif achievementId == 15004 or achievementId == 15079 then
        category = "Pet Battles"
        acquisition = "Complete the matching battle-pet or pet-reward collection objective."
    end
    PatchCatalog.achievementCategories["9.1"][achievementId] = category
    PatchCatalog.achievementDetails["9.1"][achievementId] = {
        sourceType = "Achievement",
        source = "Shadowlands Patch 9.1",
        acquisition = acquisition,
        waypoints = category == "Exploration" and { "/way #1961 62.8 22.6 Keeper's Respite / Korthia" } or nil,
    }
end

PatchCatalog.achievementCategories["9.1.5"] = {}
PatchCatalog.achievementDetails["9.1.5"] = {}
for _, achievementId in ipairs(PATCH_9_1_5_ACHIEVEMENTS) do
    local category = "Other"
    local acquisition = "Complete the matching permanent patch 9.1.5 objective."
    if achievementId >= 15232 and achievementId <= 15234 then
        category = "PvP"
        acquisition = "Earn the matching Shadowlands Season 2 rated PvP rank."
    elseif achievementId == 15241 then
        category = "Reputation"
        acquisition = "Reach Renown 80 with a Shadowlands covenant."
    elseif achievementId >= 15308 and achievementId <= 15310 then
        category = "Feats of Strength"
        acquisition = "Complete the matching Legion Timewalking Mage Tower challenge or meta-achievement."
    elseif achievementId == 15327 then
        category = "Dungeons"
        acquisition = "Finish Shadowlands Mythic+ Season 2 in the top 0.1% for your faction."
    elseif achievementId == 15388 then
        category = "Exploration"
        acquisition = "Complete the listed Shadowlands exploration achievements."
    end
    PatchCatalog.achievementCategories["9.1.5"][achievementId] = category
    PatchCatalog.achievementDetails["9.1.5"][achievementId] = {
        sourceType = "Achievement",
        source = "Shadowlands Patch 9.1.5",
        acquisition = acquisition,
    }
end
PatchCatalog.achievementCategories["9.1.7"] = {}
PatchCatalog.achievementDetails["9.1.7"] = {}

PatchCatalog.cosmeticDetails["9.1"] = {
    covenantEnsembles = {
        sourceType = "Covenant Reward",
        source = "Renown, covenant vendors, Death's Advance, and Korthia activities",
        acquisition = "Earn or purchase the matching covenant ensemble after meeting its Renown, reputation, campaign, or Korthia activity requirement.",
    },
    cityEyeglasses = {
        sourceType = "Vendor",
        source = "Finn / Stormwind or Ca'nees / Orgrimmar",
        acquisition = "Buy the cosmetic glasses from the eyewear vendor outside the barbershop in Stormwind or Orgrimmar.",
        waypoints = { "/way #84 61.7 65.8 Finn / eyewear vendor", "/way #85 40.9 61.2 Ca'nees / eyewear vendor" },
    },
    mawBacks = {
        sourceType = "Maw and Torghast Collection",
        source = "Covenant assaults, Korthia and Maw caches, Torghast, and the Adamant Vaults",
        acquisition = "Loot the matching cosmetic back from its Maw, Korthia, assault, Torghast broker, or Adamant Vaults source.",
        waypoints = { "/way #1961 62.8 22.6 Keeper's Respite / Korthia collection hub" },
    },
    mawShoulders = {
        sourceType = "Maw and Torghast Collection",
        source = "Korthia rares, covenant assaults, Torghast brokers, and the Adamant Vaults",
        acquisition = "Loot or buy the matching cosmetic shoulders from their Korthia, Maw-assault, Torghast, or Adamant Vaults source.",
        waypoints = { "/way #1961 62.8 22.6 Keeper's Respite / Korthia collection hub" },
    },
    korthianCloaks = {
        sourceType = "Korthia Reward",
        source = "Archivists' Codex and Death's Advance",
        acquisition = "Earn the matching cosmetic cloak through the Korthia factions and their permanent reward tracks.",
        waypoints = { "/way #1961 62.8 22.6 Keeper's Respite" },
    },
}
PatchCatalog.cosmeticDetails["9.1.5"] = {
    legionTimewalkingCosmetics = {
        sourceType = "Legion Timewalking Vendor",
        source = "Aridormi / Dalaran",
        acquisition = "During Legion Timewalking, buy the Replica Aegis of Aggramar or Ensemble: Ravencrest's Battleplate from Aridormi with Timewarped Badges.",
        waypoints = { "/way #627 68.6 49.2 Aridormi / Legion Timewalking" },
    },
}
PatchCatalog.cosmeticDetails["9.1.7"] = {}
for _, patchKey in ipairs({ "9.1", "9.1.5" }) do
    local details = PatchCatalog.cosmeticDetails[patchKey]
    for _, entry in ipairs(PatchCatalog.patches[patchKey].cosmetics) do
        details[entry.name] = details[entry.detailKey]
    end
end

PatchCatalog.petDetails["9.1"] = {}
local patch91PetDetails = {
    sourceType = "Pet Journal Source",
    source = "Chains of Domination collection",
    acquisition = "Follow the pet journal source for its Korthia, Maw assault, Tazavesh, Sanctum of Domination, Torghast, vendor, quest, or achievement reward.",
    waypoints = { "/way #1961 62.8 22.6 Keeper's Respite / Korthia" },
}
for _, entry in ipairs(PatchCatalog.patches["9.1"].pets) do
    PatchCatalog.petDetails["9.1"][entry.name] = patch91PetDetails
end
PatchCatalog.petDetails["9.1.5"] = {}
PatchCatalog.petDetails["9.1.7"] = {}

PatchCatalog.toyDetails["9.1"] = {}
local patch91ToyDetails = {
    sourceType = "Chains of Domination Collection",
    source = "Korthia, the Maw, Torghast, covenant assaults, professions, and pet activities",
    acquisition = "Obtain the toy from its permanent profession, treasure, quest, rare, assault, Torghast, or Korthia source.",
    waypoints = { "/way #1961 62.8 22.6 Keeper's Respite / Korthia" },
}
for _, entry in ipairs(PatchCatalog.patches["9.1"].toys) do
    PatchCatalog.toyDetails["9.1"][entry.name] = patch91ToyDetails
end
PatchCatalog.toyDetails["9.1.5"] = {}
local patch915ToyDetails = {
    sourceType = "Patch 9.1.5 Collection",
    source = "Covenant callings, heirloom vendors, and Legion Timewalking",
    acquisition = "Obtain the toy from its permanent covenant-calling, heirloom-map vendor, or Legion Timewalking source.",
}
for _, entry in ipairs(PatchCatalog.patches["9.1.5"].toys) do
    PatchCatalog.toyDetails["9.1.5"][entry.name] = patch915ToyDetails
end
PatchCatalog.toyDetails["9.1.7"] = {}

PatchCatalog.mountDetails["9.1"] = {}
local patch91MountDetails = {
    category = "Other",
    sourceType = "Chains of Domination Collection",
    source = "Korthia, the Maw, covenant rewards, Shadowlands Season 2, Tazavesh, Sanctum of Domination, or Torghast",
    acquisition = "Complete the mount's matching permanent or seasonal Chains of Domination source.",
    waypoints = { "/way #1961 62.8 22.6 Keeper's Respite / Korthia" },
}
for _, entry in ipairs(PatchCatalog.patches["9.1"].mounts) do
    PatchCatalog.mountDetails["9.1"][entry.name] = patch91MountDetails
end
local patch91MountCategories = {
    PvP = { "Vicious War Gorm", "Unchained Gladiator's Soul Eater" },
    ["Dungeon and Raids"] = { "Vengeance", "Cartel Master's Gearglider", "Sanctum Gloomcharger" },
    Achievements = { "Mawsworn Charger", "Hand of Hrestimorak", "Tazavesh Gearglider", "Battle-Hardened Aquilon", "Winter Wilderling", "Pale Gravewing", "Battlefield Swarmer", "Hand of Salaranga", "Soultwisted Deathwalker" },
    Vendor = { "Soaring Razorwing", "Amber Shardhide", "Autumnal Wilderling", "Obsidian Gravewing", "Ascendant's Aquilon", "Regal Corpsefly" },
    ["Quest Rewards"] = { "Ardenweald Wilderling", "Sinfall Gravewing", "Elysian Aquilon", "Maldraxxian Corpsefly" },
    ["Rare Drops"] = { "Mastercraft Gravewing", "Harvester's Dredwing", "Lord of the Corpseflies", "Tamed Mauler", "Beryl Shardhide", "Hand of Bahmethra", "Wild Hunt Legsplitter", "Undying Darkhound", "Summer Wilderling", "Foresworn Aquilon", "Soulbound Gloomcharger", "Fallen Charger", "Hand of Nilganihmaht", "Crimson Shardhide", "Darkmaul", "Fierce Razorwing", "Garnet Razorwing", "Dusklight Razorwing", "Maelie, the Wanderer", "Rampaging Mauler" },
}
for category, names in pairs(patch91MountCategories) do
    for _, name in ipairs(names) do
        local base = PatchCatalog.mountDetails["9.1"][name]
        PatchCatalog.mountDetails["9.1"][name] = {
            category = category,
            sourceType = base.sourceType,
            source = base.source,
            acquisition = base.acquisition,
            waypoints = base.waypoints,
        }
    end
end
PatchCatalog.mountDetails["9.1.5"] = {
    ["Val'sharah Hippogryph"] = { category = "Vendor", sourceType = "Legion Timewalking Vendor", source = "Aridormi / Dalaran", acquisition = "Buy for 5,000 Timewarped Badges during Legion Timewalking.", waypoints = { "/way #627 68.6 49.2 Aridormi" } },
    ["Soaring Spelltome"] = { category = "Achievements", sourceType = "Mage Tower Meta-Achievement", source = "A Tour of Towers", acquisition = "Complete all seven unique Legion Timewalking Mage Tower challenges." },
    ["Lightforged Ruinstrider"] = { category = "Quest Rewards", sourceType = "Racial Class Mount", source = "Lightforged draenei paladin", acquisition = "Learn automatically as an eligible Lightforged draenei paladin." },
}
PatchCatalog.mountDetails["9.1.7"] = {}

-- Shadowlands 9.2 through 9.2.7 backfill. Shared source records keep every
-- eligible row actionable without duplicating the same acquisition text.
PatchCatalog.achievementCategories["9.2"] = {}
PatchCatalog.achievementDetails["9.2"] = {}
for _, achievementId in ipairs(PATCH_9_2_ACHIEVEMENTS) do
    local category = "Exploration"
    local acquisition = "Complete the matching permanent Zereth Mortis campaign, exploration, collection, or reputation objective."
    if achievementId >= 15251 and achievementId <= 15324 then
        category = "Torghast"
        acquisition = "Complete the matching Jailer's Gauntlet or Layer 16 Torghast objective."
    elseif achievementId >= 15346 and achievementId <= 15384 then
        category = "PvP"
        acquisition = "Complete the matching Shadowlands Season 3 rated PvP objective."
    elseif achievementId >= 15416 and achievementId <= 15494 then
        category = "Raids"
        acquisition = "Complete the matching Sepulcher of the First Ones raid objective."
    elseif achievementId >= 15496 and achievementId <= 15506 then
        category = "Dungeons"
        acquisition = "Complete the matching Shadowlands Season 3 Mythic+ objective."
    elseif achievementId == 15511 or (achievementId >= 15539 and achievementId <= 15544) then
        category = "PvP"
        acquisition = "Complete the matching Solo Shuffle objective."
    end
    PatchCatalog.achievementCategories["9.2"][achievementId] = category
    PatchCatalog.achievementDetails["9.2"][achievementId] = {
        sourceType = "Achievement",
        source = "Shadowlands Patch 9.2",
        acquisition = acquisition,
        waypoints = category == "Exploration" and { "/way #1970 34.8 64.8 Haven / Zereth Mortis" } or nil,
    }
end

PatchCatalog.achievementCategories["9.2.5"] = {}
PatchCatalog.achievementDetails["9.2.5"] = {}
for _, achievementId in ipairs(PATCH_9_2_5_ACHIEVEMENTS) do
    local category = "Questing"
    local acquisition = "Complete the matching permanent Shadowlands quest, collection, reputation, or meta-achievement objective."
    if achievementId >= 15598 and achievementId <= 15639 then
        category = "PvP"
        acquisition = "Complete the matching Shadowlands Season 4 rated PvP objective."
    elseif achievementId >= 15650 and achievementId <= 15652 then
        category = "Dungeons"
        acquisition = "Complete the matching Shadowlands dungeon objective."
    elseif achievementId >= 15663 and achievementId <= 15687 then
        category = "Raids"
        acquisition = "Complete the matching Fated Shadowlands raid or raid-meta objective during Season 4."
    elseif achievementId >= 15688 then
        category = "Dungeons"
        acquisition = "Complete the matching Shadowlands Season 4 Mythic+ objective."
    end
    PatchCatalog.achievementCategories["9.2.5"][achievementId] = category
    PatchCatalog.achievementDetails["9.2.5"][achievementId] = {
        sourceType = "Achievement",
        source = "Shadowlands Patch 9.2.5 / Season 4",
        acquisition = acquisition,
    }
end
PatchCatalog.achievementCategories["9.2.7"] = {}
PatchCatalog.achievementDetails["9.2.7"] = {}

PatchCatalog.cosmeticDetails["9.2"] = {
    torghastMawswornWeapons = {
        sourceType = "Torghast Vendor",
        source = "Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16",
        acquisition = "Buy the rotating Mawsworn cosmetic weapon from the broker on floor 3 or floor 6 during a Layers 13-16 Torghast run.",
        cost = "300 Phantasma during the run.",
    },
    dominationCache = {
        sourceType = "Treasure",
        source = "Domination Cache / Zereth Mortis",
        acquisition = "Loot a Dominance Key from Mawsworn elites in the northeast desert, then open the one-time Domination Cache for the guaranteed greatsword.",
        waypoints = { "/way #1970 60.0 28.0 Mawsworn desert / Dominance Key and cache area" },
    },
    enlightenedParagonCloaks = {
        sourceType = "Paragon Cache",
        source = "Enlightened Broker Supplies",
        acquisition = "After reaching Exalted with The Enlightened, earn another 10,000 reputation and open Enlightened Broker Supplies for a chance at this cosmetic cloak.",
        waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" },
    },
    enlightenedParagonWeapons = {
        sourceType = "Paragon Cache",
        source = "Enlightened Broker Supplies",
        acquisition = "After reaching Exalted with The Enlightened, earn another 10,000 reputation and open Enlightened Broker Supplies for a chance at this cosmetic weapon.",
        waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" },
    },
}
PatchCatalog.cosmeticDetails["9.2.5"] = {
    lavaforgeArmaments = {
        sourceType = "Racial Questline",
        source = "Weapons o' the Dark Iron",
        acquisition = "On a Dark Iron dwarf that has completed Heritage o' the Dark Iron, finish the Anvil-Thane questline in Blackrock Depths.",
    },
    bloodKnightDedication = {
        sourceType = "Racial and Class Questline",
        source = "Blood Knight",
        acquisition = "On a level-60 blood elf paladin exalted with Silvermoon City, complete Lady Liadrin's Ghostlands questline.",
        waypoints = { "/way #1670 42.5 27.2 Lady Liadrin / Oribos" },
    },
    darkRangerAttire = {
        sourceType = "Questline and Vendor",
        source = "Return to Lordaeron / Outfitter Reynolds",
        acquisition = "Complete Return to Lordaeron on a hunter, then buy the ensemble from Outfitter Reynolds in Trueshot Lodge.",
        cost = "1,000 gold.",
    },
}
PatchCatalog.cosmeticDetails["9.2.7"] = {}

for _, patchKey in ipairs({ "9.2", "9.2.5" }) do
    local details = PatchCatalog.cosmeticDetails[patchKey]
    for _, entry in ipairs(PatchCatalog.patches[patchKey].cosmetics) do
        details[entry.name] = details[entry.detailKey]
    end
end

PatchCatalog.petDetails["9.2"] = {}
local zerethMortisPetDetails = {
    sourceType = "Wild Pet Battle",
    source = "Zereth Mortis",
    acquisition = "Find this species in its Zereth Mortis habitat, weaken it in a pet battle, and capture it with a pet trap.",
    waypoints = { "/way #1970 34.8 64.8 Haven / Zereth Mortis" },
}
for _, entry in ipairs(PatchCatalog.patches["9.2"].pets) do
    PatchCatalog.petDetails["9.2"][entry.name] = zerethMortisPetDetails
end
local protoformPetDetails = {
    sourceType = "Protoform Synthesis",
    source = "Protoform Synthesis pet forge",
    acquisition = "Learn the matching schematic, then synthesize the pet with Genesis Motes, its lattice, and the required rare reagent.",
    waypoints = { "/way #1970 61.8 58.9 Protoform Synthesis pet forge" },
}
for _, name in ipairs({
    "Archetype of Focus", "Resonant Echo", "Omnipotential Core", "Archetype of Discovery",
    "Tunneling Vombata", "Archetype of Motion", "Archetype of Animation", "Archetype of Serenity",
    "Archetype of Multiplicity", "Archetype of Metamorphosis", "Archetype of Predation",
    "Archetype of Survival", "Archetype of Cunning", "Archetype of Malice", "Archetype of Satisfaction",
    "Shelly", "Ambystan Darter", "Fierce Scarabid", "Violent Poultrid", "Multichicken",
    "Stabilized Geomental", "Archetype of Renewal", "Terror Jelly", "Prototickles",
    "Leaping Leporid", "Archetype of Vigilance", "Viperid Menace", "Microlicid",
}) do
    PatchCatalog.petDetails["9.2"][name] = protoformPetDetails
end
PatchCatalog.petDetails["9.2"]["Geordy"] = { sourceType = "Treasure", source = "Ephemera Shell", acquisition = "Open the Ephemera Shell treasure in Zereth Mortis.", waypoints = { "/way #1970 50.5 73.6 Ephemera Shell" } }
PatchCatalog.petDetails["9.2"]["Lightless Tormentor"] = { sourceType = "Achievement", source = "The Jailer's Gauntlet: Layer 1", acquisition = "Complete Layer 1 of the Jailer's Gauntlet in Torghast." }
PatchCatalog.petDetails["9.2"]["E'rnee"] = { sourceType = "Quest", source = "Can I Keep Him?", acquisition = "Complete the Can I Keep Him? quest in Zereth Mortis.", waypoints = { "/way #1970 34.8 64.8 Haven / Zereth Mortis" } }
PatchCatalog.petDetails["9.2"]["Pocopoc"] = { sourceType = "Vendor", source = "Olea Manu / Exile's Hollow", acquisition = "Buy Pocopoc from Olea Manu after unlocking the vendor through the Cypher system.", cost = "500 Cyphers of the First Ones.", waypoints = { "/way #1970 37.2 44.6 Olea Manu / Exile's Hollow" } }
PatchCatalog.petDetails["9.2.5"] = {}
PatchCatalog.petDetails["9.2.7"] = {}

PatchCatalog.toyDetails["9.2"] = {
    ["Personal Containment Trap"] = { sourceType = "Achievement", source = "Completing the Code", acquisition = "Complete the Zereth Mortis cypher-console achievement Completing the Code.", waypoints = { "/way #1970 34.8 64.8 Haven / Zereth Mortis" } },
    ["Mortis Mover"] = { sourceType = "Achievement", source = "Traversing the Spheres", acquisition = "Complete Traversing the Spheres in Zereth Mortis.", waypoints = { "/way #1970 34.8 64.8 Haven / Zereth Mortis" } },
    ["Dominated Hearthstone"] = { sourceType = "Achievement", source = "The Jailer's Gauntlet: Layer 2", acquisition = "Complete Layer 2 of the Jailer's Gauntlet in Torghast." },
    ["Sphere of Enlightened Cogitation"] = { sourceType = "Paragon Cache", source = "Enlightened Broker Supplies", acquisition = "Open Enlightened paragon caches after Exalted for a chance at the toy.", waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" } },
    ["Enlightened Hearthstone"] = { sourceType = "Zereth Mortis", source = "Enlightened content", acquisition = "Obtain the toy from its permanent Zereth Mortis Enlightened source." },
    ["Broker Translocation Matrix"] = { sourceType = "Vendor", source = "Vilo / Haven", acquisition = "Reach Exalted with The Enlightened and buy the toy from Vilo.", cost = "5,000 gold.", waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" } },
    ["Xy'rath's Booby-Trapped Cache"] = { sourceType = "Rare Drop", source = "Xy'rath the Covetous", acquisition = "Defeat Xy'rath the Covetous in Zereth Mortis for a chance at the toy." },
    ["Jiro Circle of Song"] = { sourceType = "Cypher Reward", source = "Zereth Mortis Jiro", acquisition = "Complete the matching Jiro and Cypher activity in Zereth Mortis." },
    ["Protopological Cube"] = { sourceType = "Treasure", source = "Syntactic Vault", acquisition = "Open the Syntactic Vault treasure in Zereth Mortis." },
    ["Makaris's Satchel of Mines"] = { sourceType = "Quest or Treasure", source = "Zereth Mortis", acquisition = "Obtain the satchel from its permanent Zereth Mortis source." },
    ["Firim's Specimen Container"] = { sourceType = "Quest or Treasure", source = "Firim / Zereth Mortis", acquisition = "Complete Firim's matching Zereth Mortis activity." },
    ["Bushel of Mysterious Fruit"] = { sourceType = "Treasure", source = "Catalyst Gardens", acquisition = "Loot the toy from its Catalyst Gardens treasure source.", waypoints = { "/way #1970 40.0 72.0 Catalyst Gardens" } },
    ["Infested Automa Core"] = { sourceType = "Treasure", source = "Catalyst Wards", acquisition = "Loot the toy from its Catalyst Wards source.", waypoints = { "/way #1970 48.0 25.0 Catalyst Wards" } },
}
PatchCatalog.toyDetails["9.2.5"] = {
    ["Earpieces of Tranquil Focus"] = { sourceType = "Vendor", source = "Toy vendors in major cities", acquisition = "Buy the toy from Craggle Wobbletop, Blax Bottlerocket, Jepetto Joybuzz, or another permanent toy vendor." },
    ["Stored Wisdom Device"] = { sourceType = "Mail Reward", source = "Ve'nari's epilogue", acquisition = "Finish the Zereth Mortis epilogue and Ve'nari progression, inspect Ve'nari's body at the Creation Catalyst, then wait for her in-game mail.", waypoints = { "/way #1970 47.0 88.0 Ve'nari's body / Creation Catalyst" } },
}
PatchCatalog.toyDetails["9.2.7"] = {}

PatchCatalog.mountDetails["9.2"] = {}
local protoformMountDetails = {
    category = "Other",
    sourceType = "Protoform Synthesis",
    source = "Protoform Synthesis mount forge",
    acquisition = "Learn the matching schematic, then synthesize the mount with Genesis Motes, its lattice, and the required rare reagent.",
    waypoints = { "/way #1970 61.8 58.9 Protoform Synthesis mount forge" },
}
for _, entry in ipairs(PatchCatalog.patches["9.2"].mounts) do
    PatchCatalog.mountDetails["9.2"][entry.name] = protoformMountDetails
end
local enlightenedMountDetails = { category = "Vendor", sourceType = "Reputation Vendor", source = "Vilo / Haven", acquisition = "Reach the required standing with The Enlightened and buy the mount from Vilo.", waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" } }
PatchCatalog.mountDetails["9.2"]["Heartlight Vombata"] = enlightenedMountDetails
PatchCatalog.mountDetails["9.2"]["Anointed Protostag"] = enlightenedMountDetails
local seasonThreePvPDetails = { category = "PvP", sourceType = "Seasonal PvP Reward", source = "Shadowlands Season 3", acquisition = "Earn the matching rated-PvP reward during Shadowlands Season 3.", availability = "The original Season 3 reward is no longer obtainable." }
PatchCatalog.mountDetails["9.2"]["Vicious War Croaker"] = seasonThreePvPDetails
PatchCatalog.mountDetails["9.2"]["Cosmic Gladiator's Soul Eater"] = seasonThreePvPDetails
PatchCatalog.mountDetails["9.2"]["Wastewarped Deathwalker"] = { category = "Dungeon and Raids", sourceType = "Seasonal Achievement", source = "Shadowlands Keystone Master: Season Three", acquisition = "Reach 2,500 Mythic+ rating during Shadowlands Season 3.", availability = "The original Season 3 reward is no longer obtainable." }
PatchCatalog.mountDetails["9.2"]["Shimmering Aurelid"] = { category = "Dungeon and Raids", sourceType = "Raid Achievement", source = "Glory of the Sepulcher Raider", acquisition = "Complete the Sepulcher of the First Ones raid meta-achievement." }
PatchCatalog.mountDetails["9.2"]["Cryptic Aurelid"] = { category = "Achievements", sourceType = "Meta-Achievement", source = "From A to Zereth", acquisition = "Complete the Zereth Mortis meta-achievement From A to Zereth." }
PatchCatalog.mountDetails["9.2"]["Carcinized Zerethsteed"] = { category = "Dungeon and Raids", sourceType = "Limited Raid Quest", source = "Leading Motives", acquisition = "Defeat the Jailer on Heroic or Mythic and complete Leading Motives.", availability = "The original Ahead of the Curve-era quest is no longer obtainable." }
PatchCatalog.mountDetails["9.2"]["Colossal Soulshredder Mawrat"] = { category = "Achievements", sourceType = "Torghast Achievement", source = "Flawless Master (Layer 16)", acquisition = "Earn a flawless score in each Torghast wing on Layer 16." }
PatchCatalog.mountDetails["9.2"]["Colossal Ebonclaw Mawrat"] = { category = "Achievements", sourceType = "Torghast Achievement", source = "The Jailer's Gauntlet: Layer 4", acquisition = "Complete Layer 4 of the Jailer's Gauntlet." }
PatchCatalog.mountDetails["9.2"]["Colossal Umbrahide Mawrat"] = { category = "Rare Drops", sourceType = "Torghast Drop", source = "Torghast Layers 13-16", acquisition = "Complete Torghast Layers 13 or higher for a chance at the mount." }
PatchCatalog.mountDetails["9.2"]["Colossal Plaguespew Mawrat"] = { category = "Rare Drops", sourceType = "Rare Drop", source = "Rhuv, Gorger of Ruin", acquisition = "Defeat Rhuv, Gorger of Ruin in Zereth Mortis for a chance at the mount." }
PatchCatalog.mountDetails["9.2"]["Colossal Wraithbound Mawrat"] = { category = "Rare Drops", sourceType = "Container Drop", source = "Mawsworn Supply Chest", acquisition = "Open Mawsworn Supply Chests in Zereth Mortis for a chance at the mount." }
PatchCatalog.mountDetails["9.2"]["Deepstar Aurelid"] = { category = "Rare Drops", sourceType = "Rare Drop", source = "Hirukon", acquisition = "Fish the Strange Goop and complete Hirukon's lure sequence, then defeat Hirukon.", waypoints = { "/way #1970 52.6 74.8 Hirukon" } }
PatchCatalog.mountDetails["9.2"]["Patient Bufonid"] = { category = "Quest Rewards", sourceType = "Seven-Day Questline", source = "The Patient Bufonid", acquisition = "Complete Avna's seven daily material turn-ins at Haven.", waypoints = { "/way #1970 34.3 65.9 Avna / Haven" } }
PatchCatalog.mountDetails["9.2"]["Zereth Overseer"] = { category = "Dungeon and Raids", sourceType = "Mythic Raid Drop", source = "The Jailer / Sepulcher of the First Ones", acquisition = "Defeat the Jailer on Mythic difficulty for a chance at the mount." }

PatchCatalog.mountDetails["9.2.5"] = {
    ["Restoration Deathwalker"] = { category = "Dungeon and Raids", sourceType = "Seasonal Achievement", source = "Shadowlands Keystone Master: Season Four", acquisition = "Reach 2,000 Mythic+ rating during Shadowlands Season 4.", availability = "The original Season 4 reward is no longer obtainable." },
    ["Vicious Warstalker"] = { category = "PvP", sourceType = "Seasonal PvP Reward", source = "Shadowlands Season 4", acquisition = "Fill the rated-PvP seasonal reward bar at 1,000+ rating for the faction-specific Warstalker.", availability = "The original Season 4 reward is no longer obtainable." },
    ["Jigglesworth Sr."] = { category = "Dungeon and Raids", sourceType = "Seasonal Raid Achievement", source = "Fates of the Shadowlands Raids", acquisition = "Complete all three Fated Shadowlands raids on Normal difficulty or higher during Season 4.", availability = "The original Season 4 reward is no longer obtainable." },
    ["Grimhowl"] = { category = "Quest Rewards", sourceType = "Racial Questline", source = "Good Fiery Boy", acquisition = "Complete the Dark Iron dwarf heritage continuation questline in Blackrock Depths." },
    ["Eternal Gladiator's Soul Eater"] = { category = "PvP", sourceType = "Seasonal Achievement", source = "Gladiator: Shadowlands Season 4", acquisition = "Win 50 3v3 games at Elite rank during Shadowlands Season 4.", availability = "The original Season 4 reward is no longer obtainable." },
    ["Elusive Emerald Hawkstrider"] = { category = "Quest Rewards", sourceType = "Racial Questline", source = "Victory for the Sin'dorei / Blood Knight", acquisition = "Complete the blood elf questline that begins with Lady Liadrin in Oribos; requires level 60 and Exalted with Silvermoon City.", waypoints = { "/way #1670 42.5 27.2 Lady Liadrin / Oribos" } },
}
PatchCatalog.mountDetails["9.2.7"] = {}

-- Dragonflight launch and early-patch research is kept here as grouped source
-- metadata so every catalog row can open a useful map/details payload without
-- duplicating the same acquisition text dozens of times.
PatchCatalog.achievementCategories["10.0.5"] = {}
PatchCatalog.achievementDetails["10.0.5"] = {}
for _, achievementId in ipairs(PATCH_10_0_5_ACHIEVEMENTS) do
    local category = "Skyriding"
    local acquisition = "Complete the matching Dragon Isles reverse-race or reverse-race meta achievement."
    if achievementId >= 16696 and achievementId <= 16727 then
        category = "Collections"
        acquisition = "Collect the customizations required by this Dragon Isles drake-customization achievement."
    elseif achievementId == 17207 then
        category = "Fishing"
        acquisition = "Use an oversized fishing bobber at each required Dragon Isles fishing hole."
    elseif achievementId == 17335 or achievementId == 17336 or achievementId == 17345 then
        category = "PvP"
        acquisition = "Complete the listed airborne War Mode objective in the Dragon Isles."
    elseif achievementId == 17342 or achievementId == 17343 then
        category = "Events"
        acquisition = "Complete the listed objective during the permanent Storm's Fury event in Primalist Tomorrow."
    end
    PatchCatalog.achievementCategories["10.0.5"][achievementId] = category
    PatchCatalog.achievementDetails["10.0.5"][achievementId] = {
        sourceType = "Achievement",
        source = "Dragonflight Patch 10.0.5",
        acquisition = acquisition,
        waypoints = category == "Events" and { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" } or nil,
    }
end

PatchCatalog.achievementCategories["10.0.7"] = {}
PatchCatalog.achievementDetails["10.0.7"] = {}
for _, achievementId in ipairs(PATCH_10_0_7_ACHIEVEMENTS) do
    local category = achievementId < 17300 and "Skyriding" or "Exploration"
    local acquisition = achievementId < 17300
        and "Complete the matching Forbidden Reach dragonriding race or race meta achievement."
        or "Complete the matching permanent Patch 10.0.7 collection, exploration, quest, profession, or battle-pet objective."
    if achievementId == 17366 or achievementId == 17367 or (achievementId >= 17496 and achievementId <= 17499) then
        category = "Professions"
        acquisition = "Complete the matching permanent legacy-profession discovery objective added in Patch 10.0.7."
    elseif achievementId == 17406 or achievementId == 17410 or achievementId == 17411 or achievementId == 17412 then
        category = "Pet Battles"
        acquisition = "Complete the matching Dragon Isles or Forbidden Reach pet-battle objective."
    elseif achievementId == 17427 then
        category = "Reputation"
        acquisition = "Complete the Winterpelt Furbolg reputation objective."
    elseif achievementId == 17546 then
        category = "Questing"
        acquisition = "Complete the Baine Bloodhoof questline added in Patch 10.0.7."
    end
    PatchCatalog.achievementCategories["10.0.7"][achievementId] = category
    PatchCatalog.achievementDetails["10.0.7"][achievementId] = {
        sourceType = "Achievement",
        source = "Dragonflight Patch 10.0.7",
        acquisition = acquisition,
        waypoints = category == "Skyriding" and { "/way #2151 41.4 74.4 Forbidden Reach race hub" }
            or category == "Exploration" and { "/way #2151 35.8 59.6 Morqut Village / Forbidden Reach" }
            or nil,
    }
end

PatchCatalog.petDetails["10.0"] = {}
local dragonflightWildPetDetails = {
    sourceType = "Wild pet battle",
    source = "Dragon Isles",
    acquisition = "Find this species in wild pet battles across its Dragon Isles habitat, weaken it, and capture it with a pet trap.",
}
for petIndex = 1, 24 do
    local entry = PatchCatalog.patches["10.0"].pets[petIndex]
    PatchCatalog.petDetails["10.0"][entry.name] = dragonflightWildPetDetails
end

local dragonflightCraftedPetDetails = {
    sourceType = "Profession",
    source = "Dragon Isles professions",
    acquisition = "Craft this companion with the matching Dragon Isles profession or obtain the caged pet from another player.",
    waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" },
}
for _, name in ipairs({
    "Alvin", "Blaze Spirit", "Dust Spirit", "Gale Spirit", "Tide Spirit",
    "Jeweled Amber Whelpling", "Jeweled Emerald Whelpling", "Jeweled Onyx Whelpling",
    "Jeweled Sapphire Whelpling", "Jeweled Ruby Whelpling", "Quack-E", "Sophic Amalgamation",
}) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightCraftedPetDetails
end

local dragonflightTreasurePetDetails = {
    sourceType = "Treasure or discovery",
    source = "Dragon Isles",
    acquisition = "Complete this pet's permanent Dragon Isles treasure, discovery, or interaction puzzle.",
}
for _, name in ipairs({ "Azure Frillfish", "Blackfeather Nester", "Chestnut", "Cubbly", "Roseate Hopper", "Viridescent Duck" }) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightTreasurePetDetails
end

local dragonflightRenownPetDetails = {
    sourceType = "Renown reward",
    source = "Dragon Isles major factions",
    acquisition = "Reach the required Dragonscale Expedition, Iskaara Tuskarr, Maruuk Centaur, or Valdrakken Accord renown and claim or purchase the pet.",
}
for _, name in ipairs({
    "Backswimmer Timbertooth", "Whiskuk", "Black Skitterbug", "Gray Marmoni",
    "Crimson Proto-Whelp", "Magic Nibbler", "Hoofhelper",
}) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightRenownPetDetails
end

local dragonflightAchievementPetDetails = {
    sourceType = "Achievement",
    source = "Pet, racing, or collection achievement",
    acquisition = "Complete the achievement associated with this permanent Dragonflight collection reward.",
}
for _, name in ipairs({
    "Bronze Racing Enthusiast", "Lady Feathersworth", "Lubbins", "Mister Muskoxeles",
    "Secretive Frogduck", "Violet Violence", "Crystalline Mini-Monster",
}) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightAchievementPetDetails
end

local dragonflightVendorPetDetails = {
    sourceType = "Vendor",
    source = "Dragon Isles pet and event vendors",
    acquisition = "Purchase this pet with its listed Dragon Isles materials, Polished Pet Charms, or Elemental Overflow.",
}
for _, name in ipairs({
    "Chip", "Ghostflame", "Jean's Lucky Fish", "Mallard Duckling", "Obsidian Proto-Whelp",
    "Petal", "Pinkie", "Pistachio", "Scout", "Stormie", "Troubled Tome",
}) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightVendorPetDetails
end

local primalStormPetDetails = {
    sourceType = "Primal Storm drop",
    source = "Dragon Isles Primal Storms",
    acquisition = "Defeat enemies during the matching elemental Primal Storm for a chance at this companion.",
}
for _, name in ipairs({ "Echo of the Cave", "Echo of the Depths", "Echo of the Heights", "Echo of the Inferno" }) do
    PatchCatalog.petDetails["10.0"][name] = primalStormPetDetails
end

local dragonflightQuestPetDetails = {
    sourceType = "Quest",
    source = "Dragon Isles side quests",
    acquisition = "Complete the permanent Dragon Isles quest or questline that awards this companion.",
}
for _, name in ipairs({ "Living Mud Mask", "Lord Basilton", "Mister Toots", "Shiverweb Broodling", "Yipper", "Pilot" }) do
    PatchCatalog.petDetails["10.0"][name] = dragonflightQuestPetDetails
end
local grandHuntPetDetails = {
    sourceType = "Grand Hunt reward",
    source = "Grand Hunt reward bags",
    acquisition = "Complete Grand Hunts for a chance to find the pet in a hunt reward bag.",
    waypoints = { "/way #2023 60.4 39.6 Maruukai / Grand Hunt hub" },
}
PatchCatalog.petDetails["10.0"]["Bakar Companion"] = grandHuntPetDetails
PatchCatalog.petDetails["10.0"]["Ohuna Companion"] = grandHuntPetDetails

PatchCatalog.petDetails["10.0.5"] = {
    ["Time-Lost Vorquin Foal"] = {
        sourceType = "Event vendor",
        source = "Brendormi / Storm's Fury",
        acquisition = "Complete Storm's Fury events in Primalist Tomorrow, then buy the pet from Brendormi.",
        cost = "105 Essence of the Storm and 1,500 Elemental Overflow.",
        waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" },
    },
}

PatchCatalog.petDetails["10.0.7"] = {}
local forbiddenReachRarePetSources = {
    Ashenwing = { "Bonesifter Marwak", "/way #2151 43.1 60.6 Bonesifter Marwak" },
    Luvvy = { "Luttrok", "/way #2151 13.2 48.4 Luttrok spawn area" },
    Scruffles = { "Vraken the Hunter", "/way #2151 58.6 47.9 Vraken the Hunter" },
    Wakyn = { "Warden Entrix", "/way #2151 67.0 7.2 War Creche entrance" },
}
for name, sourceData in pairs(forbiddenReachRarePetSources) do
    PatchCatalog.petDetails["10.0.7"][name] = {
        sourceType = "Rare drop",
        source = sourceData[1] .. " / Forbidden Reach",
        acquisition = "Defeat the named Forbidden Reach rare for a chance at this battle pet.",
        waypoints = { sourceData[2] },
    }
end
local zskeraPetDetails = {
    sourceType = "Zskera Vault",
    source = "Zskera Vault rooms and puzzles",
    acquisition = "Open Zskera Vault doors and complete the room interaction, treasure, fishing, or gift-token puzzle associated with this pet.",
    waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" },
}
for _, name in ipairs({ "Emmah", "Kobaldt", "Berylmane", "Brightfeather", "Patos", "Gilded Mechafrog" }) do
    PatchCatalog.petDetails["10.0.7"][name] = zskeraPetDetails
end
PatchCatalog.petDetails["10.0.7"]["Buckie"] = { sourceType = "Vendor", source = "Turik / Forbidden Reach", acquisition = "Buy from Turik for 25,000 Elemental Overflow.", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } }
PatchCatalog.petDetails["10.0.7"]["Driftling"] = { sourceType = "Reputation", source = "Winterpelt Furbolg", acquisition = "Reach Exalted with the Winterpelt Furbolg and claim the pet reward.", waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" } }
PatchCatalog.petDetails["10.0.7"]["Shaggy"] = { sourceType = "Vendor bag", source = "Sack of Oddities / Cataloger Daela", acquisition = "Buy Sack of Oddities for 2,000 Elemental Overflow until the pet drops.", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } }
PatchCatalog.petDetails["10.0.7"]["Bunbo"] = { sourceType = "Quest", source = "Primordial Answers", acquisition = "Complete Primordial Answers on the Forbidden Reach.", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } }
local forbiddenReachBattlePetDetails = {
    sourceType = "Pet battle reward",
    source = "Forbidden Reach elemental boss pet",
    acquisition = "Reduce the active elemental boss pet to Rare quality through the nearby battles, then defeat its Rare version to collect the companion.",
    waypoints = { "/way #2151 35.8 59.6 Morqut Village / Forbidden Reach" },
}
for _, name in ipairs({ "Flow", "Tremblor", "Vortex", "Wildfire" }) do
    PatchCatalog.petDetails["10.0.7"][name] = forbiddenReachBattlePetDetails
end

PatchCatalog.toyDetails["10.0"] = {}
local dragonflightToyDetails = {
    sourceType = "Dragonflight collection",
    source = "Permanent Dragon Isles content",
    acquisition = "Obtain this toy from its permanent Dragon Isles quest, treasure, vendor, reputation, profession, rare, or achievement source shown in the in-game collection journal.",
}
for _, entry in ipairs(PatchCatalog.patches["10.0"].toys) do
    PatchCatalog.toyDetails["10.0"][entry.name] = dragonflightToyDetails
end
local dragonflightTreasureToyDetails = {
    sourceType = "Treasure",
    source = "Dragon Isles treasure",
    acquisition = "Loot the named permanent treasure in its Dragon Isles zone.",
}
for _, name in ipairs({ "Golden Dragon Goblet", "Yennu's Kite", "Gleaming Arcanocrystal", "Wheeled Floaty Boaty Controller", "Ohn Lite Branded Horn" }) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightTreasureToyDetails
end
local dragonflightDropToyDetails = {
    sourceType = "Drop",
    source = "Dragon Isles rare, enemy, or event drop",
    acquisition = "Farm the named Dragon Isles enemy, creature family, cache, or Primalist source for this toy.",
}
for _, name in ipairs({ "Talisman of Sargha", "Notfar's Favorite Food", "Personal Shell", "A Collection of Me", "The Super Shellkhan Gang", "Black Dragon's Challenge Dummy", "Primalist Prison" }) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightDropToyDetails
end
local dragonflightRenownToyDetails = {
    sourceType = "Renown or reputation",
    source = "Dragon Isles major factions",
    acquisition = "Reach the listed faction rank, then claim the quest reward or buy the toy from that faction's vendor.",
}
for _, name in ipairs({
    "Obsidian Egg Clutch", "Wayfinder's Compass", "Dragon Tea Set", "Blue-Covered Beanbag",
    "Ohuna Perch", "Whale Bone Tea Set", "Tuskarr Traveling Soup Pot", "Iskaara Tug Sled",
    "Magical Snow Sled", "Explorers' League Banner", "Comfortable Pile of Pelts", "Maruuk Cooking Pot",
    "Very Comfortable Pelt", "Fisherman's Folly", "Soft Purple Pillow", "Skinny Reliquary Pillow",
    "Small Triangular Pillow", "Reliquary Banner", "Red Dragon Banner", "Blue Dragon Banner",
    "Bronze Dragon Banner", "Green Dragon Banner", "Black Dragon Banner", "Rubbery Fish Head",
}) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightRenownToyDetails
end
local dragonflightVendorToyDetails = {
    sourceType = "Vendor",
    source = "Dragon Isles vendor",
    acquisition = "Purchase from the toy's permanent Dragon Isles vendor after meeting the listed unlock or currency requirement.",
}
for _, name in ipairs({ "Aquatic Shades", "Breaker's Flag of Victory", "Ornate Dragon Statue", "Shuffling Sands" }) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightVendorToyDetails
end
local dragonflightQuestToyDetails = {
    sourceType = "Quest or achievement",
    source = "Permanent Dragonflight objective",
    acquisition = "Complete the named Dragon Isles questline or achievement associated with this toy.",
}
for _, name in ipairs({
    "Seed of Renewed Souls", "Artist's Easel", "Compendium of Love", "Lover's Bouquet",
    "Cloak of Many Faces", "Professor Chirpsnide's Im-PECK-able Harpy Disguise", "Taivan's Trumpet",
    "Lucky Duck", "Somewhat-Stabilized Arcana", "Rock of Appreciation", "Ohn'ir Windsage's Hearthstone",
    "Murglasses", "Happy Tuskarr Palooza", "Tuskarr Dinghy", "Jar of Excess Slime",
}) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightQuestToyDetails
end
local dragonflightProfessionToyDetails = {
    sourceType = "Profession",
    source = "Dragon Isles professions",
    acquisition = "Craft with the matching Dragon Isles profession or obtain the finished toy through a crafter or the Auction House.",
    waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" },
}
for _, name in ipairs({
    "Duck-Stuffed Duck Lovie", "Market Tent", "Gnoll Tent", "Dragonscale Expedition's Expedition Tent",
    "Artisan's Sign", "Tuskarr Beanbag", "Cushion of Time Travel", "Environmental Emulator",
    "Element-Infused Rocket Helmet", "Cold Cushion", "Khadgar's Disenchanting Rod",
    "Centralized Precipitation Emitter", "Forlorn Funeral Pall", "Giggle Goggles", "Convergent Prism",
    "Jeweled Offering", "S.E.A.T.", "Malfunctioning Stealthman 54",
}) do
    PatchCatalog.toyDetails["10.0"][name] = dragonflightProfessionToyDetails
end
PatchCatalog.toyDetails["10.0.5"] = {
    ["Chasing Storm"] = { sourceType = "Event vendor", source = "Brendormi / Storm's Fury", acquisition = "Buy from Brendormi after farming the permanent Storm's Fury event.", cost = "75 Essence of the Storm and 1,200 Elemental Overflow.", waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" } },
    ["Reusable Oversized Bobber"] = { sourceType = "Achievement", source = "Discombobberlated", acquisition = "Complete Discombobberlated by using oversized bobbers at the required Dragon Isles fishing holes." },
    ["Defective Doomsday Device"] = { sourceType = "Profession", source = "Dragon Isles Engineering", acquisition = "Craft with Dragon Isles Engineering or obtain the finished toy through a crafting order.", waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" } },
}
PatchCatalog.toyDetails["10.0.7"] = {
    ["Primal Stave of Claw and Fur"] = { sourceType = "Quest", source = "Champion of the Winterpelt", acquisition = "Raise Winterpelt Language Skill to 100, then complete the final Winterpelt Furbolg questline for the toy.", waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" } },
    ["Reading Glasses"] = { sourceType = "Quest", source = "Returning the Blade / Winterpelt Furbolg", acquisition = "Raise Winterpelt Language Skill to 50, then complete the matching Winterpelt Furbolg story chapter for the toy.", waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" } },
    ["Display of Strength"] = { sourceType = "Quest", source = "A Final Word / Baine questline", acquisition = "Complete the Baine Bloodhoof storyline through A Final Word on a character that receives the toy reward.", waypoints = { "/way #2112 50.8 57.9 Mayla Highmountain / questline start" } },
    ["Brazier of Madness"] = { sourceType = "Discovery", source = "Old Zul'Gurub", acquisition = "Unlock the old Zul'Gurub collection secrets, then complete the Brazier of Madness discovery.", waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" } },
    ["Snow Blanket"] = { sourceType = "Vendor", source = "Forbidden Reach", acquisition = "Buy from the permanent Forbidden Reach vendor after meeting its unlock requirement.", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } },
    ["Dented Can"] = { sourceType = "Profession", source = "Dragon Isles Engineering", acquisition = "Create through Dragon Isles Engineering or obtain the finished toy from another engineer.", waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" } },
    ["Clan Banner"] = { sourceType = "Quest", source = "Orc heritage questline", acquisition = "Complete the Orc heritage questline and its clan-choice follow-up to receive the banner.", waypoints = { "/way #85 39.1 79.0 Orgrimmar Embassy" } },
    ["Holoviewer: The Scarlet Queen"] = { sourceType = "Zskera Vault", source = "Zskera Vault rooms", acquisition = "Open Zskera Vault rooms and loot the matching holoviewer collectible.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
    ["Holoviewer: The Lady of Dreams"] = { sourceType = "Zskera Vault", source = "Zskera Vault rooms", acquisition = "Open Zskera Vault rooms and loot the matching holoviewer collectible.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
    ["Holoviewer: The Timeless One"] = { sourceType = "Zskera Vault", source = "Zskera Vault rooms", acquisition = "Open Zskera Vault rooms and loot the matching holoviewer collectible.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
    ["Secondhand Survey Tools"] = { sourceType = "Vendor", source = "Emilia Bellocq / Dragonscale Expedition", acquisition = "Purchase from Emilia Bellocq after unlocking the required Dragonscale Expedition research rank.", waypoints = { "/way #2022 47.0 82.6 Dragonscale Basecamp" } },
    ["Spore-Bound Essence"] = { sourceType = "Zskera Vault", source = "Zskera Vaults", acquisition = "Loot from a Zskera Vault room or chest.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
    ["H.E.L.P."] = { sourceType = "Profession", source = "Dragon Isles Engineering", acquisition = "Craft with Dragon Isles Engineering or obtain the finished toy from another engineer.", waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" } },
    ["Obsidian Battle Horn"] = { sourceType = "Zskera Vault", source = "Zskera Vaults", acquisition = "Loot from a Zskera Vault room or chest.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
    ["Stuffed Bear"] = { sourceType = "Zskera Vault", source = "Stuffed Bear object / Zskera Vaults", acquisition = "Find and loot the Stuffed Bear object in a randomized Zskera Vault room. The item became a Toy Box collectible in patch 11.0 but remains sourced from permanent 10.0.7 content.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
}

PatchCatalog.mountDetails["10.0"] = {}
local dragonflightMountDetails = {
    category = "Dragonflight",
    sourceType = "Dragonflight launch collection",
    source = "Permanent Dragon Isles content",
    acquisition = "Obtain this mount from its permanent launch-era quest, vendor, reputation, achievement, rare, profession, dungeon, raid, or PvP source shown in the mount journal.",
}
for _, entry in ipairs(PatchCatalog.patches["10.0"].mounts) do
    PatchCatalog.mountDetails["10.0"][entry.name] = dragonflightMountDetails
end
local dracthyrMountDetails = { category = "Racial", sourceType = "Racial mount", source = "Dracthyr intro and racial-mount vendors", acquisition = "Complete the Dracthyr introduction, then obtain the basic or armored vorquin from the racial-mount vendors." }
for _, name in ipairs({ "Bronze Vorquin", "Crimson Vorquin", "Obsidian Vorquin", "Sapphire Vorquin", "Armored Vorquin Leystrider", "Guardian Vorquin", "Swift Armored Vorquin", "Majestic Armored Vorquin" }) do
    PatchCatalog.mountDetails["10.0"][name] = dracthyrMountDetails
end
local dragonridingCampaignMountDetails = { category = "Quest Rewards", sourceType = "Campaign quest", source = "Dragonflight leveling campaign", acquisition = "Complete the matching Waking Shores, Ohn'ahran Plains, Azure Span, or Thaldraszus campaign chapter to unlock this dragonriding mount." }
for _, name in ipairs({ "Renewed Proto-Drake", "Windborne Velocidrake", "Highland Drake", "Cliffside Wylderdrake" }) do
    PatchCatalog.mountDetails["10.0"][name] = dragonridingCampaignMountDetails
end
PatchCatalog.mountDetails["10.0"]["Otterworldly Ottuk Carrier"] = { category = "Achievements", sourceType = "Achievement", source = "Thanks for the Carry!", acquisition = "Collect 500 mounts usable by a single character." }
PatchCatalog.mountDetails["10.0"]["Hailstorm Armoredon"] = { category = "Dungeons", sourceType = "Seasonal achievement", source = "Dragonflight Keystone Master: Season One", acquisition = "Earn the Dragonflight Season 1 Mythic+ rating achievement.", availability = "The original Season 1 reward is no longer obtainable." }
PatchCatalog.mountDetails["10.0"]["Crimson Gladiator's Drake"] = { category = "PvP", sourceType = "Seasonal achievement", source = "Gladiator: Dragonflight Season 1", acquisition = "Win 50 3v3 games at Elite rank during Dragonflight Season 1.", availability = "The original Season 1 reward is no longer obtainable." }
PatchCatalog.mountDetails["10.0"]["Vicious Sabertooth"] = { category = "PvP", sourceType = "Seasonal PvP reward", source = "Dragonflight Season 1 rated PvP", acquisition = "Fill the seasonal Vicious mount progress bar at 1000+ rating for the faction-specific sabertooth.", availability = "The original Season 1 route has ended." }
local iskaaraOttukDetails = { category = "Renown", sourceType = "Renown vendor", source = "Tatto / Iskaara", acquisition = "Reach Iskaara Tuskarr Renown 25 for scouting ottuks or Renown 30 for war ottuks, then buy the desired color.", waypoints = { "/way #2024 13.8 49.2 Tatto / Iskaara" } }
for _, name in ipairs({ "Brown Scouting Ottuk", "Yellow Scouting Ottuk", "Brown War Ottuk", "Yellow War Ottuk" }) do
    PatchCatalog.mountDetails["10.0"][name] = iskaaraOttukDetails
end
local skitterflyDetails = { category = "Renown", sourceType = "Renown vendor or pack", source = "Dragonscale Expedition", acquisition = "Reach Dragonscale Expedition Renown 25; buy the Azure or Tamed Skitterfly from Granpap Whiskers, or open Expedition Scout's Packs for the Verdant Skitterfly.", waypoints = { "/way #2022 47.0 82.6 Dragonscale Basecamp" } }
for _, name in ipairs({ "Azure Skitterfly", "Tamed Skitterfly", "Verdant Skitterfly" }) do
    PatchCatalog.mountDetails["10.0"][name] = skitterflyDetails
end
PatchCatalog.mountDetails["10.0"]["Zenet Hatchling"] = { category = "Rare Drops", sourceType = "Rare drop and timer", source = "Zenet Avis / Ohn'ahran Plains", acquisition = "Loot a Zenet Egg from Zenet Avis and wait seven days for it to hatch.", waypoints = { "/way #2023 31.4 64.2 Zenet Avis patrol" } }
PatchCatalog.mountDetails["10.0"]["Liberated Slyvern"] = { category = "Rare Drops", sourceType = "Rare drop", source = "Breezebiter / The Azure Span", acquisition = "Defeat Breezebiter for a chance at the reins.", waypoints = { "/way #2024 26.0 40.8 Breezebiter patrol" } }
PatchCatalog.mountDetails["10.0"]["Loyal Magmammoth"] = { category = "Reputation", sourceType = "Quest reward", source = "Grand Theft Mammoth", acquisition = "Max both Wrathion and Sabellian reputations, then complete Grand Theft Mammoth at the Obsidian Citadel.", waypoints = { "/way #2022 27.0 62.6 Obsidian Citadel" } }
PatchCatalog.mountDetails["10.0"]["Plainswalker Bearer"] = { category = "Events", sourceType = "Grand Hunt reward", source = "Grand Hunt Spoils", acquisition = "Open the first Grand Hunt reward bag of the week for a chance at the mount.", waypoints = { "/way #2023 60.4 39.6 Maruukai / Grand Hunt hub" } }
PatchCatalog.mountDetails["10.0"]["Stormhide Salamanther"] = { category = "Events", sourceType = "Currency vendor", source = "Mythressa / Valdrakken", acquisition = "Buy for 2,000 Elemental Overflow earned from Primal Storms.", waypoints = { "/way #2112 38.1 37.7 Mythressa" } }
PatchCatalog.mountDetails["10.0"]["Divine Kiss of Ohn'ahra"] = { category = "Secrets", sourceType = "Quest and materials", source = "A Whispering Breeze", acquisition = "Reach Maruuk Renown 9, complete the Ohn'iri Springs chain, and bring Godoloto 3 Stolen Breaths of Ohn'ahra, an Essence of Awakening, and rank-3 Exultant Incense.", waypoints = { "/way #2023 56.1 77.0 Ohn'iri Springs" } }
PatchCatalog.mountDetails["10.0"]["Lizi, Thunderspine Tramper"] = { category = "Secrets", sourceType = "Five-day quest", source = "To Tame A Thunderspine", acquisition = "Reach Maruuk Renown 9 and complete the five daily material turn-ins at Ohn'iri Springs.", waypoints = { "/way #2023 56.1 77.0 Initiate Radiya / Ohn'iri Springs" } }
PatchCatalog.mountDetails["10.0"]["Scrappy Worldsnail"] = { category = "Secrets", sourceType = "Currency vendor", source = "Dealer Vexil / Worldbreakers", acquisition = "Become a Worldbreaker, farm 1,000 Magmotes, and buy the Slumbering Worldsnail Shell from Dealer Vexil.", waypoints = { "/way #2022 35.0 47.0 Worldbreakers cave" } }
PatchCatalog.mountDetails["10.0"]["Temperamental Skyclaw"] = { category = "Secrets", sourceType = "Material turn-in", source = "Zon'Wogi / Three-Falls Lookout", acquisition = "Bring Zon'Wogi 20 Tuskarr Jerky, 20 Flash Frozen Meat, and 20 Gnolan's House Special.", waypoints = { "/way #2024 19.0 23.8 Zon'Wogi" } }
PatchCatalog.mountDetails["10.0"]["Iskaara Trader's Ottuk"] = { category = "Raids", sourceType = "Raid-item vendor", source = "Tattukiaka / Iskaara", acquisition = "Trade Terros's Captive Core and Eye of the Vengeful Hurricane from Vault of the Incarnates to Tattukiaka.", waypoints = { "/way #2024 14.0 49.6 Tattukiaka / Iskaara" } }
PatchCatalog.mountDetails["10.0"]["Raging Magmammoth"] = { category = "Raids", sourceType = "Achievement", source = "Glory of the Vault Raider", acquisition = "Complete the Vault of the Incarnates raid meta-achievement.", waypoints = { "/way #2022 72.0 56.0 Vault of the Incarnates entrance" } }
PatchCatalog.mountDetails["10.0"]["Ivory Trader's Ottuk"] = { category = "Dungeons", sourceType = "Dungeon-item vendor", source = "Tattukiaka / Iskaara", acquisition = "Trade the three required Dragonflight dungeon rings to Tattukiaka; any dungeon difficulty works.", waypoints = { "/way #2024 14.0 49.6 Tattukiaka / Iskaara" } }
PatchCatalog.mountDetails["10.0"]["Shellack"] = { category = "Dungeons", sourceType = "Achievement", source = "Glory of the Dragonflight Hero", acquisition = "Complete the Dragonflight dungeon meta-achievement." }
PatchCatalog.mountDetails["10.0"]["Otto"] = { category = "Secrets", sourceType = "Fishing secret", source = "The Way to an Otto's Heart", acquisition = "Obtain Aquatic Shades, retrieve the Empty Fish Barrel, and fill it with the three required fish in sequence.", waypoints = { "/way #2023 81.9 72.1 Great Swog cave", "/way #2022 20.4 39.7 Empty Fish Barrel" } }
PatchCatalog.mountDetails["10.0"]["Magmashell"] = { category = "Secrets", sourceType = "Drop and interaction", source = "Empowered Snail / Scalecracker Peaks", acquisition = "Obtain an Empty Magma Shell, then channel on the Empowered Snail at the bottom of the lava pool.", waypoints = { "/way #2022 71.15 25.5 Empowered Snail lava pool" } }
PatchCatalog.mountDetails["10.0.5"] = {
    ["Skyskin Hornstrider"] = {
        category = "Events",
        sourceType = "Event vendor",
        source = "Brendormi / Storm's Fury",
        acquisition = "Complete Storm's Fury events in Primalist Tomorrow, then buy the mount from Brendormi.",
        cost = "150 Essence of the Storm and 3,000 Elemental Overflow.",
        waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / Primalist Tomorrow portal" },
    },
}
PatchCatalog.mountDetails["10.0.7"] = {
    ["Noble Bruffalon"] = { category = "Vendor", sourceType = "Vendor", source = "Storykeeper Ashekh / Morqut Village", acquisition = "Buy for 100,000 Elemental Overflow.", waypoints = { "/way #2151 35.8 59.6 Storykeeper Ashekh / Morqut Village" } },
    ["Ancient Salamanther"] = { category = "Rare Drops", sourceType = "Rare drop", source = "Forbidden Reach rares", acquisition = "Defeat Forbidden Reach rare enemies for a chance at the mount.", waypoints = { "/way #2151 35.8 59.6 Morqut Village / rare-farming hub" } },
    ["Gooey Snailemental"] = { category = "Events", sourceType = "Primal Storm collection", source = "Froststone Vault Primal Storm", acquisition = "Collect 50 Leftover Elemental Slime from the Froststone Vault Primal Storm boss and combine them.", waypoints = { "/way #2151 59.0 38.0 Froststone Vault" } },
    ["Mossy Mammoth"] = { category = "Treasures", sourceType = "Zskera Vault puzzle", source = "Zskera Vaults", acquisition = "Combine the Zskera Vault mammoth-puzzle reagents in sequence, ending with the Sleeping Ancient Mammoth and Emerald Dragon Brooch.", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } },
}

-- Dragonflight 10.1 through The War Within 11.2.7 mount backfill. The
-- journal's spell ID is the durable collection key; the shared detail record
-- keeps every row usable by the Explorer while individual route research is
-- expanded separately.
local AUDITED_MOUNT_PATCHES = {
    "10.1", "10.1.5", "10.1.7", "10.2", "10.2.5", "10.2.6", "10.2.7",
    "11.0", "11.0.5", "11.0.7", "11.1", "11.1.5", "11.1.7", "11.2", "11.2.5", "11.2.7",
}
local LIMITED_MOUNT_SPELLS = {
    [127178] = true,
    [254812] = true,
    [300154] = true,
    [437162] = true,
    [441324] = true,
    [441325] = true,
    [446017] = true,
    [446022] = true,
    [457656] = true,
}
local LIMITED_MOUNT_PATCHES = {
    ["10.2.7"] = "Pandaria Remix has ended; the mount remains listed in its original patch for historical collection tracking.",
    ["11.2.5"] = "Legion Remix has ended; the mount remains listed in its original patch for historical collection tracking.",
}
local MOUNT_PATCH_SOURCE_TYPES = {
    ["10.2.7"] = "Pandaria Remix",
    ["11.2.5"] = "Legion Remix",
}

for _, patchKey in ipairs(AUDITED_MOUNT_PATCHES) do
    PatchCatalog.mountDetails[patchKey] = PatchCatalog.mountDetails[patchKey] or {}
    local patch = PatchCatalog.patches[patchKey]
    for _, entry in ipairs(patch.mounts) do
        local category = "Other"
        if entry.name:find("Gladiator", 1, true) or entry.name:find("Vicious", 1, true) then
            category = "PvP"
        elseif entry.name:find("Delver", 1, true) then
            category = "Delves"
        end

        PatchCatalog.mountDetails[patchKey][entry.name] = {
            category = entry.category or category,
            sourceType = entry.sourceType or MOUNT_PATCH_SOURCE_TYPES[patchKey] or "Patch mount collection",
            source = entry.source or patch.label,
            acquisition = entry.acquisition or "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
            availability = entry.availability or LIMITED_MOUNT_PATCHES[patchKey] or (LIMITED_MOUNT_SPELLS[entry.spellId] and "Limited-time reward; retained in its original patch catalog for historical collection tracking." or nil),
        }
    end
end

-- Every generated row gets a usable detail record. Specific hand-authored
-- routes remain authoritative because these defaults only fill missing keys.
for patchKey in pairs(GENERATED_COLLECTION_PATCHES) do
    local patch = PatchCatalog.patches[patchKey]
    local generated = GeneratedPatchCollections[patchKey]
    PatchCatalog.petDetails[patchKey] = PatchCatalog.petDetails[patchKey] or {}
    PatchCatalog.toyDetails[patchKey] = PatchCatalog.toyDetails[patchKey] or {}
    PatchCatalog.achievementDetails[patchKey] = PatchCatalog.achievementDetails[patchKey] or {}
    PatchCatalog.achievementCategories[patchKey] = PatchCatalog.achievementCategories[patchKey] or {}

    for _, entry in ipairs(patch.pets or {}) do
        PatchCatalog.petDetails[patchKey][entry.name] = PatchCatalog.petDetails[patchKey][entry.name] or {
            sourceType = "Pet Journal Source",
            source = entry.source and entry.source ~= "" and entry.source or patch.label,
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
        }
    end
    for _, entry in ipairs(patch.toys or {}) do
        PatchCatalog.toyDetails[patchKey][entry.name] = PatchCatalog.toyDetails[patchKey][entry.name] or {
            sourceType = "Toy Box Source",
            source = entry.source and entry.source ~= "" and entry.source or patch.label,
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
        }
    end
    for _, achievementId in ipairs(patch.achievements and patch.achievements.ids or {}) do
        PatchCatalog.achievementCategories[patchKey][achievementId] = PatchCatalog.achievementCategories[patchKey][achievementId]
            or generated and generated.achievementCategories and generated.achievementCategories[achievementId]
            or "Other"
        PatchCatalog.achievementDetails[patchKey][achievementId] = PatchCatalog.achievementDetails[patchKey][achievementId] or {
            sourceType = "Achievement",
            source = patch.label,
            acquisition = "Complete the achievement's listed criteria.",
        }
    end
end

-- Older checklist-style achievements use the same criterion-aware map contract
-- as the Midnight routes above. Generic hub, vendor, raid entrance, and campaign
-- pins intentionally remain unmapped because they are not individual criteria.
local function BuildSequentialCriteria(count, achievementId)
    local criteria = {}
    for criterionIndex = 1, count do
        criteria[criterionIndex] = achievementId and {
            achievementId = achievementId,
            criterionIndex = criterionIndex,
        } or criterionIndex
    end
    return criteria
end

local function AppendWaypointSet(targetWaypoints, targetCriteria, waypoints, achievementId)
    for criterionIndex, waypoint in ipairs(waypoints) do
        targetWaypoints[#targetWaypoints + 1] = waypoint
        targetCriteria[#targetCriteria + 1] = achievementId and {
            achievementId = achievementId,
            criterionIndex = criterionIndex,
        } or criterionIndex
    end
end

local KORTHIA_META_WAYPOINTS = {
    "/way #1961 60.5 20.6 Chains of Domination campaign",
    "/way #1960 36.6 39.4 Minions of the Cold Dark / Tormentors",
    "/way #1961 52.0 43.0 Explore Korthia route",
    "/way #1961 62.7 22.3 The Archivists' Codex",
    "/way #1961 54.0 35.0 Conquering Korthia rare route",
    "/way #1960 45.0 39.0 On the Offensive / Covenant Assaults",
    "/way #1961 47.3 35.6 Reliquary Restoration route",
    "/way #1961 63.4 23.2 Death's Advance",
}
local KORTHIA_TREASURE_WAYPOINTS = {
    "/way #1961 38.4 42.8 Glittering Nest Material",
    "/way #1961 52.9 14.8 Lost Memento",
    "/way #1961 29.5 53.4 Anima Laden Egg",
    "/way #1960 66.1 48.3 Helsworn Chest",
    "/way #1961 40.2 58.9 Infested Vestige",
    "/way #1961 69.0 29.8 Forgotten Feather",
    "/way #1961 47.3 29.3 Dislodged Nest",
    "/way #1961 50.5 84.3 Displaced Relic",
    "/way #1960 66.5 62.2 Jeweled Heart",
    "/way #1961 45.3 67.1 Offering Box",
}
local KORTHIA_META_MAP_WAYPOINTS = {}
local KORTHIA_META_MAP_CRITERIA = {}
AppendWaypointSet(KORTHIA_META_MAP_WAYPOINTS, KORTHIA_META_MAP_CRITERIA, KORTHIA_META_WAYPOINTS)
AppendWaypointSet(KORTHIA_META_MAP_WAYPOINTS, KORTHIA_META_MAP_CRITERIA, KORTHIA_TREASURE_WAYPOINTS, 15099)

PatchCatalog.achievementCategories["9.1"][15064] = "Exploration"
PatchCatalog.achievementDetails["9.1"][15064] = {
    sourceType = "Meta-Achievement",
    source = "Breaking the Chains",
    acquisition = "Complete the permanent Korthia and Maw campaign, reputation, assault, rare, exploration, and treasure objectives.",
    tips = "Treasure pins read completion from Treasures of Korthia; the other pins read the matching Breaking the Chains criterion.",
    waypoints = KORTHIA_META_MAP_WAYPOINTS,
    mapAchievementId = 15064,
    waypointCriteria = KORTHIA_META_MAP_CRITERIA,
}
PatchCatalog.achievementCategories["9.1"][15099] = "Exploration"
PatchCatalog.achievementDetails["9.1"][15099] = {
    sourceType = "Achievement",
    source = "Treasures of Korthia",
    acquisition = "Find and loot all ten treasures in Korthia and the adjacent Maw locations.",
    waypoints = KORTHIA_TREASURE_WAYPOINTS,
    mapAchievementId = 15099,
    waypointCriteria = BuildSequentialCriteria(#KORTHIA_TREASURE_WAYPOINTS),
}
PatchCatalog.mountDetails["9.1"]["Hand of Salaranga"] = {
    category = "Achievements",
    sourceType = "Meta-Achievement",
    source = "Breaking the Chains",
    acquisition = "Complete Breaking the Chains in Korthia and the Maw.",
    tips = "Treasure pins are filtered through the child achievement Treasures of Korthia.",
    waypoints = KORTHIA_META_MAP_WAYPOINTS,
    mapAchievementId = 15064,
    waypointCriteria = KORTHIA_META_MAP_CRITERIA,
}

local ZERETH_META_WAYPOINTS = {
    "/way #1970 34.8 64.8 Secrets of the First Ones campaign / Haven",
    "/way #1970 60.5 23.0 Dune Dominance / Endless Sands",
    "/way #1970 33.8 49.2 Cyphers of the First Ones / Exile's Hollow",
    "/way #1970 34.8 64.8 The Enlightened / Haven",
    "/way #1970 50.0 50.0 Adventurer of Zereth Mortis rare route",
    "/way #1970 61.8 58.8 Synthe-fived! / Protoform Synthesis",
}
local ZERETH_TREASURE_WAYPOINTS = {
    "/way #1970 58.82 77.20 Library Vault",
    "/way #1970 38.23 37.21 Damaged Jiro Stash",
    "/way #1970 67.01 69.35 Forgotten Proto-Vault",
    "/way #1970 60.50 30.55 Mawsworn Cache",
    "/way #1970 51.63 9.93 Fallen Vault",
    "/way #1970 59.98 17.91 Domination Cache",
    "/way #1970 61.6 37.0 Architect's Reserve",
    "/way #1970 35.2 44.2 Overgrown Protofruit",
    "/way #1970 34.9 70.0 Drowned Broker Supplies",
    "/way #1970 46.6 31.0 Protomineral Extractor",
    "/way #1970 34.0 67.6 Stolen Scroll",
    "/way #1970 52.6 71.6 Protoflora Harvester",
    "/way #1970 66.0 49.0 Ripened Protopear",
    "/way #1970 47.5 94.4 Bushel of Progenitor Produce",
    "/way #1970 58.72 73.01 Submerged Chest",
    "/way #1970 58.0 44.55 Template Archive",
    "/way #1970 52.64 63.03 Symphonic Vault",
    "/way #1970 37.96 65.20 Stolen Relic",
    "/way #1970 38.9 73.2 Gnawed Valise",
    "/way #1970 49.69 87.27 Filched Artifact",
    "/way #1970 56.80 64.12 Crushed Supply Crate",
    "/way #1970 53.65 72.75 Mistaken Ovoid",
    "/way #1970 34.78 56.07 Offering to the First Ones",
    "/way #1970 60.86 42.98 Pilfered Curio",
    "/way #1970 37.15 78.24 Grateful Boon",
    "/way #1970 77.48 58.20 Syntactic Vault",
    "/way #1970 49.6 77.8 Undulating Foliage / entrance",
}
local ZERETH_META_CRITERIA = { 1, 2, 3, 4, 6, 7 }
local ZERETH_META_MAP_WAYPOINTS = {}
local ZERETH_META_MAP_CRITERIA = {}
for waypointIndex, waypoint in ipairs(ZERETH_META_WAYPOINTS) do
    ZERETH_META_MAP_WAYPOINTS[#ZERETH_META_MAP_WAYPOINTS + 1] = waypoint
    ZERETH_META_MAP_CRITERIA[#ZERETH_META_MAP_CRITERIA + 1] = ZERETH_META_CRITERIA[waypointIndex]
end
AppendWaypointSet(ZERETH_META_MAP_WAYPOINTS, ZERETH_META_MAP_CRITERIA, ZERETH_TREASURE_WAYPOINTS, 15331)

PatchCatalog.achievementDetails["9.2"][15331] = {
    sourceType = "Achievement",
    source = "Treasures of Zereth Mortis",
    acquisition = "Find and loot all 27 treasures in Zereth Mortis.",
    waypoints = ZERETH_TREASURE_WAYPOINTS,
    mapAchievementId = 15331,
    waypointCriteria = BuildSequentialCriteria(#ZERETH_TREASURE_WAYPOINTS),
}
PatchCatalog.achievementDetails["9.2"][15336] = {
    sourceType = "Meta-Achievement",
    source = "From A to Zereth",
    acquisition = "Complete the seven permanent Zereth Mortis campaign, reputation, collection, rare, treasure, and synthesis objectives.",
    tips = "Treasure pins read completion from Treasures of Zereth Mortis.",
    waypoints = ZERETH_META_MAP_WAYPOINTS,
    mapAchievementId = 15336,
    waypointCriteria = ZERETH_META_MAP_CRITERIA,
}
PatchCatalog.mountDetails["9.2"]["Cryptic Aurelid"] = {
    category = "Achievements",
    sourceType = "Meta-Achievement",
    source = "From A to Zereth",
    acquisition = "Complete From A to Zereth in Zereth Mortis.",
    tips = "Treasure pins are filtered through the child achievement Treasures of Zereth Mortis.",
    waypoints = ZERETH_META_MAP_WAYPOINTS,
    mapAchievementId = 15336,
    waypointCriteria = ZERETH_META_MAP_CRITERIA,
}

local DRAGON_ISLES_SAFARI_WAYPOINTS = {
    "/way #2024 50.25 46.20 Azure Crystalspine",
    "/way #2025 50.70 64.12 Crimsonspine",
    "/way #2023 53.35 49.32 Grassland Stomper",
    "/way #2025 50.40 51.48 Igneoid",
    "/way #2022 74.0 34.8 Kindlet",
    "/way #2025 49.02 58.13 Palamanther",
    "/way #2022 74.0 55.8 Pricklefury Hare",
    "/way #2022 38.82 82.25 Shyfly",
    "/way #2023 61.35 47.90 Stoneshell",
    "/way #2023 73.14 76.22 Tiny Timbertooth",
    "/way #2023 55.38 65.07 Trunkalumpf",
    "/way #2022 57.0 70.8 Wild Duckling",
    "/way #2025 62.30 16.95 Blue Dasher",
    "/way #2022 39.05 74.22 Emberling",
    "/way #2024 32.50 35.48 Grizzlefur Cub",
    "/way #2023 50.55 71.80 Ironbeak Duck",
    "/way #2022 77.33 29.20 Magma Slug",
    "/way #2025 54.97 39.46 Polliswog",
    "/way #2022 54.05 33.90 Scruffy Ottuk",
    "/way #2024 53.14 42.25 Snowlemental",
    "/way #2022 55.04 61.43 Swoglet",
    "/way #2023 88.0 13.6 Treeflitter",
    "/way #2022 20.49 85.96 Vorquin Runt",
}
PatchCatalog.achievementDetails["10.0"][16519] = {
    sourceType = "Achievement",
    source = "Dragon Isles Safari",
    acquisition = "Capture every wild battle pet required by Dragon Isles Safari.",
    waypoints = DRAGON_ISLES_SAFARI_WAYPOINTS,
    mapAchievementId = 16519,
    waypointCriteria = BuildSequentialCriteria(#DRAGON_ISLES_SAFARI_WAYPOINTS),
}

local COMMUNITY_RUMOR_WAYPOINTS = {
    "/way #23 55.2 59.4 Dirt Mound / Eastern Plaguelands",
    "/way #77 42.2 48.1 Dirt Mound / Felwood underwater",
    "/way #64 42.7 30.6 Dirt Mound / Thousand Needles underwater cave",
    "/way #539 35.3 48.9 Dirt Mound / Shadowmoon Valley",
    "/way #109 26.2 68.5 Dirt Mound / Netherstorm",
    "/way #376 56.7 21.4 Dirt Mound / Valley of the Four Winds",
    "/way #2024 25.2 71.4 Dirt Mound / Azure Span snowman",
    "/way #115 63.9 72.6 Dirt Mound / Dragonblight",
    "/way #10 46.0 50.6 Dirt Mound / Northern Barrens",
    "/way #17 64.6 55.4 Dirt Mound / Blasted Lands",
    "/way #107 57.88 26.33 Dirt Mound / Nagrand floating island",
    "/way #22 68.80 73.25 Dirt Mound / Western Plaguelands",
    "/way #650 53.36 87.52 Dirt Mound / Highmountain",
    "/way #115 73.15 39.48 Dirt Mound / Dragonblight",
    "/way #116 10.9 74.9 Dirt Mound / Horde Satchel route",
    "/way #116 20.2 81.2 Dirt Mound / Alliance Satchel route",
    "/way #554 38.7 54.9 Dirt Mound / Timeless Isle",
    "/way #895 74.6 86.1 Dirt Mound / Tiragarde Sound",
}
local COMMUNITY_RUMOR_CRITERIA = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 17 }
PatchCatalog.achievementDetails["10.1.7"][18644] = {
    sourceType = "Achievement",
    source = "Community Rumor Mill",
    acquisition = "Follow the Secrets of Azeroth community-rumor clues and uncover ten buried satchels.",
    tips = "The Horde and Alliance Grizzly Hills pins are alternatives for the same criterion.",
    waypoints = COMMUNITY_RUMOR_WAYPOINTS,
    mapAchievementId = 18644,
    waypointCriteria = COMMUNITY_RUMOR_CRITERIA,
}
PatchCatalog.petDetails["10.1.7"]["Tobias"] = {
    sourceType = "Achievement",
    source = "Community Rumor Mill",
    acquisition = "Uncover ten community-rumor satchels for Community Rumor Mill.",
    tips = "The Horde and Alliance Grizzly Hills pins are alternatives for the same criterion.",
    waypoints = COMMUNITY_RUMOR_WAYPOINTS,
    mapAchievementId = 18644,
    waypointCriteria = COMMUNITY_RUMOR_CRITERIA,
}

local KHAZ_ALGAR_SAFARI_WAYPOINTS = {
    "/way #2214 59.8 36.0 Chitin Burrower",
    "/way #2248 59.8 30.6 Fallowspark Glowfly",
    "/way #2214 58.0 23.8 Vibrant Glowfly",
    "/way #2255 61.6 47.6 Verdant Scootlefish",
    "/way #2256 63.6 85.2 Shadowy Oozeling",
    "/way #2255 58.2 50.0 Ebon Ploughworm",
    "/way #2215 50.0 37.0 Arathi Chicken",
    "/way #2214 56.0 33.0 Ghostcap Menace",
    "/way #2255 57.2 63.6 Vile Bloodtick",
    "/way #2248 72.6 26.2 Mossy Snail",
    "/way #2248 61.6 60.2 Troglofrog",
    "/way #2248 55.6 28.6 Sandstone Mosswool",
    "/way #2248 76.8 43.4 Bedrock Stonecharger",
    "/way #2248 44.0 74.2 Granite Ramolith",
    "/way #2214 67.6 49.2 Snuffling",
    "/way #2214 66.2 42.4 Arachnoid Hatchling",
    "/way #2214 42.6 28.6 Azure Flickerfly",
    "/way #2255 59.4 47.6 Aubergine Scootlefish",
    "/way #2256 66.2 82.8 Voidling Ooze",
    "/way #2214 44.8 27.8 Common Ploughworm",
    "/way #2215 61.2 29.8 Greenlands Chicken",
    "/way #2214 46.2 40.8 Meek Bloodlasher",
    "/way #2215 71.4 55.8 Winged Arachnoid",
    "/way #2214 50.0 17.0 Magmashell Crawler",
    "/way #2214 56.6 66.6 Subterranean Dartswog",
    "/way #2248 66.0 51.4 Fragrant Stonelamb",
    "/way #2248 58.6 59.2 Shale Mosswool",
    "/way #2248 67.2 45.8 Cobalt Ramolith",
    "/way #2248 48.0 27.6 Alabaster Stonecharger",
    "/way #2248 72.6 41.6 Cinderhoney Emberstinger",
}
PatchCatalog.achievementDetails["11.0"][40194] = {
    sourceType = "Achievement",
    source = "Khaz Algar Safari",
    acquisition = "Capture every wild battle pet required by Khaz Algar Safari.",
    waypoints = KHAZ_ALGAR_SAFARI_WAYPOINTS,
    mapAchievementId = 40194,
    waypointCriteria = BuildSequentialCriteria(#KHAZ_ALGAR_SAFARI_WAYPOINTS),
}
PatchCatalog.petDetails["11.0"]["Waxwick"] = {
    sourceType = "Achievement",
    source = "Khaz Algar Safari",
    acquisition = "Complete Khaz Algar Safari by capturing its 30 required wild battle pets.",
    waypoints = KHAZ_ALGAR_SAFARI_WAYPOINTS,
    mapAchievementId = 40194,
    waypointCriteria = BuildSequentialCriteria(#KHAZ_ALGAR_SAFARI_WAYPOINTS),
}

local UNDERMINE_SAFARI_WAYPOINTS = {
    "/way #2346 22.0 51.0 Wily Rat",
    "/way #2346 41.01 23.89 Bombshell Crab",
    "/way #2346 61.40 30.63 Cave Crab",
    "/way #2346 70.91 65.94 Varmint Mark II",
    "/way #862 21.93 56.09 Tropical Frog",
    "/way #2214 71.23 97.67 Hemospore",
    "/way #2346 19.14 51.81 Underroach",
    "/way #2346 52.8 85.4 Venture Bombshell / Venture Crab",
    "/way #862 23.69 60.20 Kaja Crab",
    "/way #2346 42.0 10.2 Lime Roboclucker",
    "/way #2346 42.2 51.2 Spring-Loaded Ribbitron / secondary battle pet",
    "/way #2214 68.06 90.72 Frenzied Bloodtick",
}
PatchCatalog.achievementDetails["11.1"][41092] = {
    sourceType = "Achievement",
    source = "Undermine Safari",
    acquisition = "Capture every wild battle pet required by Undermine Safari.",
    tips = "Spring-Loaded Ribbitron only appears as a secondary pet; start nearby wild battles until it joins one.",
    waypoints = UNDERMINE_SAFARI_WAYPOINTS,
    mapAchievementId = 41092,
    waypointCriteria = BuildSequentialCriteria(#UNDERMINE_SAFARI_WAYPOINTS),
}
PatchCatalog.petDetails["11.1"]["Lettuce"] = {
    sourceType = "Achievement",
    source = "Undermine Safari",
    acquisition = "Complete Undermine Safari by capturing its 12 required wild battle pets.",
    tips = "Spring-Loaded Ribbitron only appears as a secondary pet; start nearby wild battles until it joins one.",
    waypoints = UNDERMINE_SAFARI_WAYPOINTS,
    mapAchievementId = 41092,
    waypointCriteria = BuildSequentialCriteria(#UNDERMINE_SAFARI_WAYPOINTS),
}

for _, achievementId in ipairs({ 15325, 15638 }) do
    PatchCatalog.achievementCategories["10.0"][achievementId] = "Questing"
    PatchCatalog.achievementDetails["10.0"][achievementId] = {
        sourceType = "Faction quest achievement",
        source = "Dracthyr, Awaken",
        acquisition = "Complete the seven chapters of the dracthyr starting experience on the matching Alliance or Horde path.",
        waypoints = { "/way #2107 46.6 57.7 The Forbidden Reach / dracthyr starting experience" },
    }
end

-- Midnight data was originally imported with only a small subset of detail
-- rows. Preserve those specific routes and fill the remainder so every UI row
-- has a stable explanation rather than silently falling through.
for _, patchKey in ipairs({ "12.0", "12.0.5", "12.0.7", "12.1" }) do
    local patch = PatchCatalog.patches[patchKey]
    PatchCatalog.achievementDetails[patchKey] = PatchCatalog.achievementDetails[patchKey] or {}
    for _, achievementId in ipairs(patch.achievements and patch.achievements.ids or {}) do
        PatchCatalog.achievementDetails[patchKey][achievementId] = PatchCatalog.achievementDetails[patchKey][achievementId] or {
            sourceType = "Achievement",
            source = patch.label,
            acquisition = "Complete the achievement's listed criteria.",
        }
    end
end

local PROHIBITED_DETAIL_TERMS = {
    "trading post", "traveler's log", "in-game shop", "battle.net shop",
    "promotion", "promotional", "twitch", "discord quest", "blizzcon",
    "china-only", "regional promotion", "subscription bundle",
    "holiday", "midsummer", "winter veil", "noblegarden", "children's week",
    "brewfest", "hallow's end", "lunar festival", "love is in the air",
    "headless horseman", "abominable greench",
}

local function IsProhibitedDetail(details)
    if type(details) ~= "table" then
        return false
    end
    local text = table.concat({
        tostring(details.category or ""),
        tostring(details.sourceType or ""),
        tostring(details.source or ""),
        tostring(details.availability or ""),
    }, " "):lower()
    for _, term in ipairs(PROHIBITED_DETAIL_TERMS) do
        if text:find(term, 1, true) then
            return true
        end
    end
    return false
end

for patchKey, patch in pairs(PatchCatalog.patches) do
    patch.mounts = FilterCollection(patch.mounts, function(entry)
        return not IsProhibitedDetail(PatchCatalog.mountDetails[patchKey] and PatchCatalog.mountDetails[patchKey][entry.name])
    end)
    patch.pets = FilterCollection(patch.pets, function(entry)
        return not IsProhibitedDetail(PatchCatalog.petDetails[patchKey] and PatchCatalog.petDetails[patchKey][entry.name])
    end)
    patch.toys = FilterCollection(patch.toys, function(entry)
        return not IsProhibitedDetail(PatchCatalog.toyDetails[patchKey] and PatchCatalog.toyDetails[patchKey][entry.name])
    end)
    patch.cosmetics = FilterCollection(patch.cosmetics, function(entry)
        local details = PatchCatalog.cosmeticDetails[patchKey]
        details = details and (details[entry.name] or details[entry.detailKey])
        return not IsProhibitedDetail(details)
    end)
    patch.achievements.ids = FilterCollection(patch.achievements.ids, function(achievementId)
        return not IsProhibitedDetail(PatchCatalog.achievementDetails[patchKey] and PatchCatalog.achievementDetails[patchKey][achievementId])
    end)
    patch.achievements.rewardHighlights = FilterCollection(patch.achievements.rewardHighlights, function(entry)
        for _, achievementId in ipairs(patch.achievements.ids) do
            if achievementId == entry.achievementId then
                return true
            end
        end
        return false
    end)
end

function PatchCatalog:GetPatch(patchKey)
    return self.patches[patchKey]
end

function PatchCatalog:GetPatchKeys()
    local keys = {}
    for patchKey in pairs(self.patches) do
        keys[#keys + 1] = patchKey
    end
    table.sort(keys, function(left, right)
        local leftParts = {}
        local rightParts = {}
        for value in tostring(left):gmatch("%d+") do
            leftParts[#leftParts + 1] = tonumber(value) or 0
        end
        for value in tostring(right):gmatch("%d+") do
            rightParts[#rightParts + 1] = tonumber(value) or 0
        end
        if #leftParts == 0 or #rightParts == 0 then
            if #leftParts == #rightParts then
                return tostring(left) < tostring(right)
            end
            return #leftParts > 0
        end
        local partCount = math.max(#leftParts, #rightParts)
        for index = 1, partCount do
            local leftValue = leftParts[index] or 0
            local rightValue = rightParts[index] or 0
            if leftValue ~= rightValue then
                return leftValue < rightValue
            end
        end
        return tostring(left) < tostring(right)
    end)
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
        cosmetics = self:GetCount(patchKey, "cosmetics"),
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

function PatchCatalog:GetAchievementDetails(patchKey, entry)
    local detailsById = self.achievementDetails and self.achievementDetails[patchKey]
    if not detailsById then
        return nil
    end

    local achievementId = type(entry) == "table" and entry.achievementId or entry
    achievementId = tonumber(achievementId)
    return achievementId and detailsById[achievementId] or nil
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

function PatchCatalog:GetCosmeticDetails(patchKey, entry)
    local details = self:GetDetailsByName(self.cosmeticDetails, patchKey, entry)
    if details or type(entry) ~= "table" then
        return details
    end

    local patch = self:GetPatch(patchKey)
    local detailGroups = patch and patch.cosmeticDetailGroups
    return detailGroups and detailGroups[entry.detailKey] or nil
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

function PatchCatalog:GetCosmeticSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetCosmeticDetails(patchKey, entry))
end

function PatchCatalog:GetCosmeticAcquisitionText(patchKey, entry)
    local details = self:GetCosmeticDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetCosmeticWaypoints(patchKey, entry)
    local details = self:GetCosmeticDetails(patchKey, entry)
    return details and details.waypoints or nil
end

function PatchCatalog:GetAchievementSourceSummary(patchKey, entry)
    return self:GetSourceSummary(self:GetAchievementDetails(patchKey, entry))
end

function PatchCatalog:GetAchievementAcquisitionText(patchKey, entry)
    local details = self:GetAchievementDetails(patchKey, entry)
    return details and details.acquisition or nil
end

function PatchCatalog:GetAchievementWaypoints(patchKey, entry)
    local details = self:GetAchievementDetails(patchKey, entry)
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
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticSourceSummary(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementSourceSummary(patchKey, entry)
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
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticAcquisitionText(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementAcquisitionText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionUseText(collectionType, patchKey, entry)
    if collectionType == "toys" then
        return self:GetToyUseText(patchKey, entry)
    end
    return nil
end

function PatchCatalog:GetCollectionTips(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    return details and details.tips or nil
end

function PatchCatalog:GetCollectionWaypoints(collectionType, patchKey, entry)
    if collectionType == "mounts" then
        return self:GetMountWaypoints(patchKey, entry)
    elseif collectionType == "pets" then
        return self:GetPetWaypoints(patchKey, entry)
    elseif collectionType == "toys" then
        return self:GetToyWaypoints(patchKey, entry)
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticWaypoints(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementWaypoints(patchKey, entry)
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
    elseif collectionType == "cosmetics" then
        return self:GetCosmeticDetails(patchKey, entry)
    elseif collectionType == "achievements" then
        return self:GetAchievementDetails(patchKey, entry)
    end
    return nil
end

function PatchCatalog:IsAchievementSourcedCollection(collectionType, patchKey, entry)
    if collectionType == "achievements" then
        return false
    end

    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    if type(details) ~= "table" then
        return false
    end

    local waypoints = self:GetCollectionWaypoints(collectionType, patchKey, entry)
    if type(waypoints) == "table" and #waypoints > 0 then
        return false
    end

    local sourceType = tostring(details.sourceType or ""):lower()
    local category = tostring(details.category or ""):lower()
    return sourceType:find("achievement", 1, true) ~= nil or category == "achievements"
end

function PatchCatalog:ParseWaypoint(waypoint)
    if type(waypoint) == "table" then
        local mapID = tonumber(waypoint.mapID or waypoint.uiMapID)
        local x = tonumber(waypoint.x)
        local y = tonumber(waypoint.y)
        if not mapID or not x or not y then
            return nil
        end
        if x > 1 or y > 1 then
            x = x / 100
            y = y / 100
        end
        return {
            mapID = mapID,
            mapName = waypoint.mapName or waypoint.uiMapName,
            x = x,
            y = y,
            label = waypoint.label,
            waypoint = waypoint.waypoint,
        }
    end

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
        mapName = MAP_NAMES[tonumber(mapID)],
        x = x / 100,
        y = y / 100,
        label = label ~= "" and label or nil,
        waypoint = waypoint,
    }
end

function PatchCatalog:GetCollectionMapPayload(collectionType, patchKey, entry, state)
    if collectionType ~= "mounts" and collectionType ~= "pets" and collectionType ~= "toys" and collectionType ~= "cosmetics" and collectionType ~= "achievements" then
        return nil
    end
    if self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then
        return nil
    end

    local sourceSummary = self:GetCollectionSourceSummary(collectionType, patchKey, entry)
    local acquisition = self:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    local effect = self:GetCollectionUseText(collectionType, patchKey, entry)
    local tips = self:GetCollectionTips(collectionType, patchKey, entry)
    local details = self:GetCollectionDetails(collectionType, patchKey, entry)
    local waypoints = self:GetCollectionWaypoints(collectionType, patchKey, entry)
    local pins = {}

    local entryDetails = type(entry) == "table" and entry or {}
    details = type(details) == "table" and details or {}
    local requirements = entryDetails.requirements or details.requirements
    local cost = entryDetails.cost or details.cost
    local notes = entryDetails.notes or details.notes

    if type(waypoints) == "table" then
        for waypointIndex, waypoint in ipairs(waypoints) do
            local pin = self:ParseWaypoint(waypoint)
            if pin then
                pin.icon = state and state.icon
                pin.source = sourceSummary
                pin.acquisition = acquisition
                pin.effect = effect
                pin.tips = tips
                if type(details.waypointCriteria) == "table" then
                    local criterionMapping = details.waypointCriteria[waypointIndex]
                    if type(criterionMapping) == "table" then
                        pin.criterionIndex = tonumber(criterionMapping.criterionIndex or criterionMapping.index)
                        pin.criterionAchievementId = tonumber(criterionMapping.achievementId)
                    else
                        pin.criterionIndex = tonumber(criterionMapping)
                    end
                end
                pins[#pins + 1] = pin
            end
        end
    end

    if #pins == 0 then
        return nil
    end

    return {
        title = (type(entry) == "table" and entry.name) or (state and state.name) or nil,
        collectionType = collectionType,
        sourceSummary = sourceSummary,
        acquisition = acquisition,
        effect = effect,
        tips = tips,
        requirements = requirements,
        cost = cost,
        costs = details.costs,
        availability = entryDetails.availability or details.availability,
        notes = notes,
        researchNotes = entryDetails.researchNotes or details.researchNotes,
        description = state and state.description,
        criteria = state and state.criteria,
        mapAchievementId = tonumber(details.mapAchievementId),
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
    elseif (collectionType == "toys" or collectionType == "cosmetics") and entry and entry.itemId then
        return "https://www.wowhead.com/item=" .. tostring(entry.itemId)
    elseif collectionType == "achievements" and entry then
        local achievementId = type(entry) == "table" and entry.achievementId or entry
        return "https://www.wowhead.com/achievement=" .. tostring(achievementId)
    end

    return nil
end

TDP.PatchCatalog = PatchCatalog
