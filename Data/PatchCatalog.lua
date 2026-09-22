local _, TDP = ...

local PatchCatalog = {}

local MAP_NAMES = {
    [84] = "Stormwind City",
    [85] = "Orgrimmar",
    [100] = "Hellfire Peninsula",
    [102] = "Zangarmarsh",
    [104] = "Shadowmoon Valley (Outland)",
    [107] = "Nagrand (Outland)",
    [111] = "Shattrath City",
    [198] = "Mount Hyjal",
    [207] = "Deepholm",
    [241] = "Twilight Highlands",
    [249] = "Uldum",
    [1527] = "Uldum (Battle for Azeroth)",
    [2112] = "Valdrakken",
    [2339] = "Dornogal",
    [2393] = "Silvermoon City",
    [2395] = "Eversong Woods",
    [2405] = "Voidstorm",
    [2413] = "Harandar",
    [2424] = "Isle of Quel'Danas",
    [2437] = "Zul'Aman",
    [2444] = "Slayer's Rise",
    [2509] = "Vaults of Atal'Utek",
    [2512] = "The Coiled Isle",
    [2576] = "The Blinding Vale",
    [2585] = "Broken Throne",
    [2594] = "Ritual Site",
    [2599] = "Val",
    [2600] = "Naigtal",
    [2613] = "The Underbelly",
    [2635] = "Gnarldor Isle",
    [2636] = "Vault of Restless Bones",
    [2642] = "Tomb of the Forgotten Priest",
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
    "/way #2405 51.6 23.7 Void Researcher Anomander / The Singularity rewards",
}

local SLAYERS_DUELLUM_WAYPOINTS = {
    "/way #2444 39.2 81.0 Thraxadar / Slayer's Duellum rewards",
}

local ABUNDANCE_WAYPOINTS = {
    "/way #2413 66.0 61.5 Chel the Chip / Abundance entrance",
    "/way #2405 38.8 22.8 Chel the Chip / Abundance entrance",
}

local EVERSONG_RARE_WAYPOINTS = {
    "/way #2395 43.4 47.4 Eversong rare route / Silvermoon approach",
}

local ZULAMAN_RARE_WAYPOINTS = {
    "/way #2437 45.8 65.8 Zul'Aman rare route / Amani hub",
}

local HARANDAR_RARE_WAYPOINTS = {
    "/way #2413 49.2 54.4 Harandar rare route",
}

local VOIDSTORM_RARE_WAYPOINTS = {
    "/way #2405 51.6 23.7 Voidstorm rare route / Singularity hub",
}

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
    "/way #2594 39.45 80.20 Rustling Bush",
    "/way #2594 32.60 65.40 Rustling Bush",
    "/way #2594 39.83 80.01 Rustling Bush",
    "/way #2594 33.89 73.85 Rustling Bush",
    "/way #2594 64.69 57.13 Rustling Bush",
    "/way #2594 29.74 73.48 Rustling Bush",
}

local BROKEN_THRONE_PETS_WAYPOINTS = {
    "/way #2585 55.8 49.6 Chubs / Lost Bear Cub",
    "/way #2585 49.6 77.9 Void-Scarred Eaglet / tornado nest",
}

local DAGGERSPINE_POINT_PETS_WAYPOINTS = {
    "/way #2395 29.0 62.0 Void-Bathed Snapdragon / Soggy Lynx Toy and nest area",
    "/way #2395 66.98 46.86 Void-Touched Chick",
}

local ABYSS_ANGLERS_WAYPOINTS = {
    "/way #2437 78.0 15.0 Depthdiver Jeju / Abyss Anglers island",
}

local NAIGTAL_VAL_INVASION_WAYPOINTS = {
    "/way #2600 47.4 81.4 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.6 Kifaan / Val Umbral Base Camp",
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
    "/way #2512 67.8 81.4 Autumn Snapling",
    "/way #2509 39.0 28.2 Caustic Writhling",
    "/way #2512 47.2 59.8 Cursed Spawn",
    "/way #2512 45.2 31.2 Jaundiced Slitherer",
    "/way #2512 62.6 84.0 Nightfur Kapara",
    "/way #2512 62.2 40.8 Poisoned Parasite",
    "/way #2512 65.81 45.75 Sleek Snakebiter",
    "/way #2512 65.8 32.8 Steady Croakfrog",
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
    ["12.0.5"] = {
        label = "Patch 12.0.5: Lingering Shadows",
        wowheadPatchId = 120005,
        sourceNotes = {
            "Wowhead Patch 12.0.5 overview, Void Assault guide, Ritual Site guide, mount guide, and pet guide were used for source notes and routes.",
            "Wowhead Added in Patch filters supplied the 12.0.5 mount and pet species IDs; shop, Trading Post, and regional/promotion entries are included without world pins.",
            "Wowhead comments supplied high-value farming notes for Cosmic Exterminator, Cosmic Slayer, and Wriggling Field Pouch farms.",
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
            { itemId = 272046, name = "Mana-Singed Divining Rod" },
            { itemId = 272047, name = "Deeplurk Scrying Stone" },
            { itemId = 272048, name = "Shattered Containment Pearl" },
            { itemId = 272128, name = "Soggy Lynx Toy" },
            { itemId = 272287, name = "Nap Mat" },
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
            "Wowhead Patch 12.0.7 overview and mount guide were used for Naigtal, Val, Sporefall, Egg Hatching, Dragonflight Timewalking, and Turbulent Timeways notes.",
            "Wowhead Added in Patch filters supplied the 12.0.7 mount and pet species IDs; unresolved placeholders stay marked without waypoints.",
            "Wowhead achievement pages and comments were used for Naigtal/Val meta-achievement requirements and reward unlocks.",
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
            { speciesId = 5080, npcId = 266912, name = "Pinky" },
        },
        toys = {
            { itemId = 259335, name = "Photo Finisher" },
            { itemId = 259899, name = "Ashen Horn of the Fallen Keeper" },
            { itemId = 260170, name = "Oathstone Fragment" },
            { itemId = 264313, name = "Madcap Redcap" },
            { itemId = 264367, name = "Mycomancer's Hearthspore" },
            { itemId = 275665, name = "Phase-Displaced Toy" },
            { itemId = 276371, name = "Lightveil Recall Beacon" },
        },
        achievements = {
            ids = {
                61463, 62873, 62874, 62880, 62881, 62882, 62883, 62887, 62901, 62903, 62904, 62909,
                62917, 62919, 63264, 63348, 63383, 63384, 63385, 63386,
            },
            rewardHighlights = {
                { achievementId = 61463, name = "Master of the Turbulent Timeways V", reward = "Mount: Spawn of Vyranoth" },
                { achievementId = 62873, name = "A Trip Around the Stars", reward = "Unlocks Mount: Voidmancer's Starcarver for purchase" },
                { achievementId = 62874, name = "A Trip Through the Stars", reward = "Unlocks Mount: Netherforged Nullframe for purchase" },
                { achievementId = 63264, name = "Heroic Showdowns", reward = "Unlocks Mount: Tortured Gorger for purchase" },
                { achievementId = 62903, name = "Climate Strange: Val", reward = "Unlocks Pet: Fishstick Keith for purchase" },
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

PatchCatalog.achievementCategories = {
    ["12.0"] = {
        [62273] = "Questing",
        [62288] = "Exploration",
        [62289] = "Exploration",
        [62290] = "Exploration",
        [62291] = "Exploration",
        [62292] = "Currency",
        [62293] = "Currency",
        [62294] = "Currency",
        [62295] = "Currency",
        [62296] = "Currency",
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
        [62489] = "Delves",
        [62493] = "PvP",
        [62494] = "PvP",
        [62496] = "Hidden",
        [62514] = "PvP",
        [62516] = "PvP",
        [62517] = "PvP",
        [62603] = "Hidden",
        [62612] = "Hidden",
        [62620] = "Questing",
        [62653] = "Professions",
        [62654] = "Professions",
        [62655] = "Professions",
        [62656] = "Professions",
        [62657] = "Professions",
        [62658] = "Professions",
        [62659] = "Professions",
        [62660] = "Professions",
        [62688] = "Professions",
        [62839] = "Hidden",
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
        [62288] = { sourceType = "Achievement", source = "Eversong Woods: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Eversong Woods.", waypoints = EVERSONG_HIGHEST_PEAKS_WAYPOINTS },
        [62289] = { sourceType = "Achievement", source = "Zul'Aman: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Zul'Aman.", waypoints = ZULAMAN_HIGHEST_PEAKS_WAYPOINTS },
        [62290] = { sourceType = "Achievement", source = "Harandar: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Harandar.", waypoints = HARANDAR_HIGHEST_PEAKS_WAYPOINTS },
        [62291] = { sourceType = "Achievement", source = "Voidstorm: The Highest Peaks", acquisition = "Place telescopes on the tallest peaks in Voidstorm.", waypoints = VOIDSTORM_HIGHEST_PEAKS_WAYPOINTS },
        [62292] = { sourceType = "Achievement", source = "Adventurer Dawncrests earned", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62293] = { sourceType = "Achievement", source = "Veteran Dawncrests earned", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62294] = { sourceType = "Achievement", source = "Champion Dawncrests earned", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62295] = { sourceType = "Achievement", source = "Hero Dawncrests earned", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62296] = { sourceType = "Achievement", source = "Myth Dawncrests earned", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62324] = { sourceType = "Achievement", source = "Abundance: Loa of all Trades", acquisition = "Complete an Abundance event having earned points in every score catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62325] = { sourceType = "Achievement", source = "Abundance: Treasures Aplenty", acquisition = "Trigger the Treasure Dundun Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62326] = { sourceType = "Achievement", source = "Abundance: Golden Opportunities", acquisition = "Trigger the Golden Glow Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62329] = { sourceType = "Achievement", source = "Abundance: Squash the Competition", acquisition = "Trigger the Runaways Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62330] = { sourceType = "Achievement", source = "Abundance: One Bite at a Time", acquisition = "Trigger the Gigantic Harvest Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62331] = { sourceType = "Achievement", source = "Abundance: Drops of Prosperity", acquisition = "Trigger the Rain of Abundance Bonus in each Abundance location.", waypoints = ABUNDANCE_WAYPOINTS },
        [62332] = { sourceType = "Achievement", source = "Abundance: Dundun's Favored", acquisition = "Complete each of the Abundance achievements below.", waypoints = ABUNDANCE_WAYPOINTS },
        [62333] = { sourceType = "Achievement", source = "Abundance: Harvester", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Materials Harvested catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62336] = { sourceType = "Achievement", source = "Abundance: Contributor", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Materials Contributed catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62337] = { sourceType = "Achievement", source = "Abundance: Professional", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Basic Nodes catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62338] = { sourceType = "Achievement", source = "Abundance: Artisan", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Artisan Nodes catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62339] = { sourceType = "Achievement", source = "Abundance: Gambler", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Bonus Events catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62340] = { sourceType = "Achievement", source = "Abundance: Investor", acquisition = "Complete an Abundance event having earned a score of at least 10,000 in the Large Orbs catagory.", waypoints = ABUNDANCE_WAYPOINTS },
        [62341] = { sourceType = "Achievement", source = "Abundance: Ain't Dun Till It's Dun", acquisition = "Complete each of the Abundance achievements below.", waypoints = ABUNDANCE_WAYPOINTS },
        [62342] = { sourceType = "Achievement", source = "Abyss Anglers: The Finest of Fish", acquisition = "Catch a Mythic creature 3 times from Abyss Anglers dives.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        [62343] = { sourceType = "Achievement", source = "Abyss Anglers: Myths from Beneath", acquisition = "Catch a Mythic creature 6 times from Abyss Anglers dives.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        [62351] = { sourceType = "Achievement", source = "Preying For Midnight", acquisition = "Complete the achievements listed below.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        [62352] = { sourceType = "Achievement", source = "Nothing to See Here", acquisition = "Get consumed by the Devouring Host in The Voidspire or March on Quel'Danas." },
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
        [62385] = { sourceType = "Achievement", source = "Staring Into The Void", acquisition = "Fully unlock the Research Console in Voidstorm.", waypoints = SINGULARITY_WAYPOINTS },
        [62386] = { sourceType = "Achievement", source = "Light Up the Night", acquisition = "Rally your forces against Xal'atath by completing the achievements below.", waypoints = { "/way #2395 43.4 47.4 Eversong Woods launch activities", "/way #2437 45.8 65.8 Zul'Aman launch activities", "/way #2413 49.2 54.4 Harandar launch activities", "/way #2405 51.6 23.7 Voidstorm launch activities" } },
        [62388] = { sourceType = "Achievement", source = "Illicit Rain: Five Stars", acquisition = "Earn a Five Star Review for your services at the Illicit Rain." },
        [62400] = { sourceType = "Achievement", source = "Craft Your World", acquisition = "Own a Pin-o-Matic Camera." },
        [62403] = { sourceType = "Achievement", source = "'Tis But A Scratch", acquisition = "Complete a Prey Hunt in Nightmare Mode while suffering from Lord Viscera's Cat Scratch.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        [62406] = { sourceType = "Achievement", source = "All the Things She Said", acquisition = "Defeat Midnight Falls after returning 12 Memories of Alleria back to L'ura in March on Quel'Danas on Normal difficulty or higher." },
        [62489] = { sourceType = "Achievement", source = "Last Call for Undercoin", acquisition = "Wowhead lists this hidden or tracking achievement without a public description.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        [62493] = { sourceType = "Achievement", source = "Slayer's Rise Victory", acquisition = "Win Slayer's Rise." },
        [62494] = { sourceType = "Achievement", source = "Slayer's Rise Veteran", acquisition = "Complete 100 victories in Slayer's Rise." },
        [62496] = { sourceType = "Achievement", source = "12.0 Research Console - Mount Tracking - Hidden [DNT]", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62514] = { sourceType = "Achievement", source = "Slayer's Rise Dominance", acquisition = "Win Slayer's Rise while controlling Shenzar Refinery, Bastion of Might, Gates of Might, Bastion of Valor, and Gates of Valor." },
        [62516] = { sourceType = "Achievement", source = "The Voided Gazelle", acquisition = "In Slayer's Rise, kill an enemy at the Path of Predation before they dismount." },
        [62517] = { sourceType = "Achievement", source = "Rise of the Ultradon Slayer", acquisition = "Kill the enemy faction's ultradon summoned at The Husk or Sparring Grounds." },
        [62603] = { sourceType = "Achievement", source = "[DNT] <Hidden> Mythic+ Rating > 0 (Midnight, any season)", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62612] = { sourceType = "Achievement", source = "[DNT] Midnight Epic Edition Decor", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62620] = { sourceType = "Achievement", source = "Allied Race: Haranir (copy)", acquisition = "Complete the Midnight storylines listed below.", waypoints = HARATI_WAYPOINTS },
        [62653] = { sourceType = "Achievement", source = "[DNT] Midnight Alchemy Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62654] = { sourceType = "Achievement", source = "[DNT] Midnight Blacksmithing Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62655] = { sourceType = "Achievement", source = "[DNT] Midnight Enchanting Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62656] = { sourceType = "Achievement", source = "[DNT] Midnight Herbalism Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62657] = { sourceType = "Achievement", source = "[DNT] Midnight Inscription Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62658] = { sourceType = "Achievement", source = "[DNT] Midnight Leatherworking Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62659] = { sourceType = "Achievement", source = "[DNT] Midnight Mining Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62660] = { sourceType = "Achievement", source = "[DNT] Midnight Skinning Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62688] = { sourceType = "Achievement", source = "[DNT] Midnight Engineering Knowledge Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
        [62839] = { sourceType = "Achievement", source = "[DNT] Haranir Reputation Fix", acquisition = "Wowhead lists this hidden or tracking achievement without a public description." },
    },
    ["12.0.5"] = {
        [62498] = { sourceType = "Void Assault", source = "Void Assault: Eversong", acquisition = "Complete one Void Strike or Incursion while Eversong Woods is the active weekly assault zone.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62499] = { sourceType = "Void Assault", source = "Void Assault: Zul'Aman", acquisition = "Complete one Void Strike or Incursion while Zul'Aman is the active weekly assault zone.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62507] = { sourceType = "Void Assault", source = "Void Smasher: Eversong", acquisition = "Complete 5 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62508] = { sourceType = "Void Assault", source = "Void Eradicator: Eversong", acquisition = "Complete 25 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62509] = { sourceType = "Void Assault", source = "Void Bane: Eversong", acquisition = "Complete 50 Void Strikes in Eversong Woods during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62510] = { sourceType = "Void Assault", source = "Void Smasher: Zul'Aman", acquisition = "Complete 5 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62511] = { sourceType = "Void Assault", source = "Void Eradicator: Zul'Aman", acquisition = "Complete 25 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62512] = { sourceType = "Void Assault", source = "Void Bane: Zul'Aman", acquisition = "Complete 50 Void Strikes in Zul'Aman during its active assault week.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62513] = { sourceType = "Currency", source = "Outstanding in the Field", acquisition = "Earn 100 Field Accolades from Ritual Sites or Void Assaults.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62518] = { sourceType = "Void Assault", source = "Cosmic Exterminator", acquisition = "Defeat 100 wildlife enemies afflicted with Apex Corruption. Comments consistently call out three Eversong wildlife strikes and one Zul'Aman strike as the reliable farm spots.", waypoints = COSMIC_EXTERMINATOR_WAYPOINTS },
        [62562] = { sourceType = "Ritual Sites", source = "Ritual Site Disruptor", acquisition = "Complete Ritual Sites 320, Ritual Renown, and Challenging Sites. Run the active Daggerspine Point or Broken Throne site, climb tiers, and unlock all challenges.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62563] = { sourceType = "Void Assault", source = "Void Response Team", acquisition = "Complete both Eversong and Zul'Aman assault achievement chains plus Cosmic Exterminator; this unlocks Unbound Manawyrm at Sergeant Vornin.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62568] = { sourceType = "Void Assault", source = "Void Shmoid", acquisition = "Defeat 250 enemies in Void Strikes or Incursions. Follow the weekly assault zone and tag broadly for credit.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62569] = { sourceType = "Void Assault", source = "Traces in the Dark", acquisition = "Loot the four trace items from Void Assault and Ritual Site enemies. Comments identify Twilight mobs, Hal'hadar mobs, Daggerspine Point naga, and general void enemies as the farm targets.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62570] = { sourceType = "Void Assault", source = "Cosmic Slayer", acquisition = "Defeat 15 advanced Void-Corrupted creatures. Comments point to Springclaw and Croaker in Eversong Woods and Grizzly in Zul'Aman as eligible bosses.", waypoints = COSMIC_SLAYER_WAYPOINTS },
        [62571] = { sourceType = "Void Assault", source = "Everybody Gets One", acquisition = "Free trapped allies or wildlife during the relevant assault phases. Comments say the Stillwhisper Pond phase in Eversong is the fastest route.", waypoints = { "/way #2395 45.8 70.0 Stillwhisper Pond / animal rescue phase", "/way #2437 31.0 42.0 Spiritpaw Gatherers / Zul'Aman rescue objective" } },
        [62572] = { sourceType = "Void Assault", source = "Battery Bombardment", acquisition = "Complete the battery objective during Void Assaults; prioritize Hal'hadar battery events when they rotate in.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62574] = { sourceType = "Currency", source = "Accolade to Rest", acquisition = "Earn 500 Field Accolades from Ritual Sites or Void Assaults.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        [62620] = { sourceType = "Ritual Sites", source = "Ritual Sites 320", acquisition = "Use and learn the Ritual Site item/challenge system while progressing the active Ritual Site.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62621] = { sourceType = "Ritual Sites", source = "Challenging Sites", acquisition = "Unlock every Ritual Site challenge across runs. Higher tiers and ritual chest drops unlock the full challenge roster.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        [62622] = { sourceType = "Ritual Sites", source = "Ritual Renown", acquisition = "Reach Ritual Sites Renown Rank 8. Comments note rep comes from repeated site clears and is not hard time-gated.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
    },
    ["12.0.7"] = {
        [61463] = { sourceType = "Timewalking", source = "Master of the Turbulent Timeways V", acquisition = "Gain Mastery of Timeways for the required weeks during Turbulent Timeways V; later comments note Spawn of Vyranoth was added to a Timewalking vendor rotation after the event.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        [62873] = { sourceType = "Naigtal and Val", source = "A Trip Around the Stars", acquisition = "Complete the Val-focused Invasion Point meta requirements. Reward unlocks Voidmancer's Starcarver for purchase from Kifaan.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62874] = { sourceType = "Naigtal and Val", source = "A Trip Through the Stars", acquisition = "Complete the Naigtal-focused Invasion Point meta requirements. Wowhead comments note the early version was time-gated over several Naigtal rotations.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62880] = { sourceType = "Val", source = "Showdown Success: Val", acquisition = "Complete the listed Val world quests. Heroic completions can also satisfy normal-mode criteria.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62881] = { sourceType = "Val", source = "Showdown Slugger: Val", acquisition = "Defeat 6 of the Val rare targets. Heroic kills also count toward Heroic Slugger.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62882] = { sourceType = "Naigtal", source = "Showdown Success: Naigtal", acquisition = "Complete the listed Naigtal world quests. Heroic completions can also satisfy normal-mode criteria.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62883] = { sourceType = "Naigtal", source = "Showdown Slugger: Naigtal", acquisition = "Defeat 6 of the Naigtal rare targets. Heroic kills also count toward Heroic Slugger.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62887] = { sourceType = "Heroic World Tier", source = "Heroic: Worlds Ahead", acquisition = "Complete 15 different Naigtal or Val world quests on Heroic World Tier.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62901] = { sourceType = "Heroic World Tier", source = "Heroic: Power Creep", acquisition = "Defeat creatures with the listed affixes in Val or Naigtal on Heroic World Tier.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62903] = { sourceType = "Val", source = "Climate Strange: Val", acquisition = "Dissipate 5 storms in Val. Unlocks Fishstick Keith for purchase.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62904] = { sourceType = "Naigtal", source = "Climate Strange: Naigtal", acquisition = "Complete Subdue the Spore Storm 5 times in Naigtal. Heroic completions also count for the heroic version.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62909] = { sourceType = "Heroic World Tier", source = "Heroic: Pain of Command", acquisition = "Complete the command-themed heroic objective in Val or Naigtal for Heroic Showdowns.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62917] = { sourceType = "Heroic World Tier", source = "Heroic Climate Strange: Val", acquisition = "Dissipate 5 Val storms on Heroic World Tier.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [62919] = { sourceType = "Heroic World Tier", source = "Heroic Climate Strange: Naigtal", acquisition = "Complete Subdue the Spore Storm 5 times in Naigtal on Heroic World Tier.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63264] = { sourceType = "Heroic World Tier", source = "Heroic Showdowns", acquisition = "Complete the heroic Val and Naigtal meta-achievement set. Reward unlocks Tortured Gorger at Kifaan.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63348] = { sourceType = "Heroic World Tier", source = "Heroic Slugger", acquisition = "Defeat 15 rare creatures in Val or Naigtal on Heroic World Tier.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63383] = { sourceType = "Story", source = "Into the Stars", acquisition = "Complete the introduction questlines for both Naigtal and Val on the same character.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63384] = { sourceType = "Story", source = "Prepared for a Showdown", acquisition = "Complete the preparatory quest objectives after unlocking the Naigtal and Val invasion content.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63385] = { sourceType = "Naigtal story", source = "A Hal'hadar Walks into a Swamp", acquisition = "Complete the Naigtal Hal'hadar storyline chapters.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        [63386] = { sourceType = "Val story", source = "Frosty Domanaar Politics", acquisition = "Complete the Val storyline chapters. Comments call out several Domanaar/Umbravarden steps around Val.", waypoints = { "/way #2599 38.09 54.89 Umbrawarden Shadinos", "/way #2599 38.20 67.72 Umbrawarden Vicium", "/way #2599 56.25 84.37 Umbrawarden Votarna" } },
    },
    ["12.1"] = {
        [61463] = { sourceType = "Timewalking", source = "Master of the Turbulent Timeways V", acquisition = "Gain Mastery of Timeways in four different weeks of Turbulent Timeways V. The 2026 event ran June 30 through August 11, so the Feat of Strength is no longer earnable after that event.", tips = "Four consecutive Timewalking dungeon completions build Knowledge of Timeways into Mastery for that week. Missed mount rewards are added to Timewalking vendors for 5000 Timewarped Badges when the next Turbulent Timeways event begins; Xydan is present only during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        [62447] = { sourceType = "Mythic+", source = "Midnight Keystone Master: Season 2", acquisition = "Reach at least 2000 Mythic+ rating during Midnight Season 2 to earn Breath of Blight.", tips = "The exact mix depends on which dungeons are over- or under-timed, but the published estimate is close to timing nearly every Season 2 dungeon at +7. This is queue-based seasonal content, so there is no single map pin." },
        [62449] = { sourceType = "Mythic+", source = "Midnight Keystone Legend: Season 2", acquisition = "Reach at least 3000 Mythic+ rating during Midnight Season 2 to earn Breath of Ruin.", tips = "The published estimate is roughly every Season 2 dungeon at +12 with some +13s. This is queue-based seasonal content, so there is no single map pin." },
        [62460] = { sourceType = "Pet Battles", source = "Family Battler of Outland", acquisition = "Defeat Nicki Tinytech, Ras'an, Narrok, Morulu the Elder, and Bloodknight Antari with ten separate teams, one all-level-25 team for each pet family.", tips = "This is 50 credited wins. The August 14 hotfix replaced the erroneous Gorma Asaan criterion with Bloodknight Antari. The trainers are account-wide daily fights, so expect ten daily resets after the prerequisite tamer chain is unlocked.", waypoints = OUTLAND_FAMILY_BATTLER_WAYPOINTS },
        [62461] = { sourceType = "Pet Battles", source = "Family Battler of Cataclysm", acquisition = "Defeat Brok, Bordin Steadyfist, Goz Banefury, and Obalis with ten separate teams, one all-level-25 team for each pet family.", tips = "This is 40 credited wins and the tamers are account-wide daily fights, so expect ten daily resets. Obalis has separate pins for old Uldum and the Battle for Azeroth Uldum phase.", waypoints = CATACLYSM_FAMILY_BATTLER_WAYPOINTS },
        [62492] = { sourceType = "Achievement", source = "The Coiled Isle Safari", acquisition = "Capture Autumn Snapling, Caustic Writhling, Cursed Spawn, Jaundiced Slitherer, Nightfur Kapara, Poisoned Parasite, Sleek Snakebiter, and Steady Croakfrog.", tips = "These are peaceful click-captures, not pet battles. Nightfur Kapara is the rarest stop and can take hours to respawn; try War Mode, a group phase, or another character phase if its southern route is empty.", waypoints = COILED_ISLE_SAFARI_WAYPOINTS },
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
        [63359] = { sourceType = "Achievement", source = "Treasures of the Coiled Isle", acquisition = "Loot all 22 hidden treasures on The Coiled Isle. Several treasures require short interaction chains, keys, nearby NPC dialogue, fishing, or temporary objects before the final treasure can be opened.", tips = "Use the pins as a checklist, but do not skip the helper pins attached to Amani Privateer's Cache, Lost Spirit, Vul'zahn's Smuggled Treasure, Grave of Someone Forgotten, or Brine-Crusted Chest; those are required setup steps, not duplicate treasure locations.", waypoints = COILED_ISLE_TREASURE_WAYPOINTS },
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
        ["Do, Child of Filo"] = { sourceType = "Achievement", source = "Midnight Safari", acquisition = "Capture the required wild pets across Midnight launch zones.", waypoints = { "/way #2395 43.4 47.4 Eversong Safari route", "/way #2413 49.2 54.4 Harandar Safari route", "/way #2437 45.8 65.8 Zul'Aman Safari route", "/way #2405 51.6 23.7 Voidstorm Safari route" } },
        ["Niblet"] = { sourceType = "Achievement", source = "Midnight Dungeon Hero", acquisition = "Complete every Midnight launch dungeon on at least Heroic difficulty.", waypoints = MIDNIGHT_DUNGEON_WAYPOINTS },
        ["Sootpaw"] = { sourceType = "Achievement", source = "Treasures of Eversong Woods", acquisition = "Loot all hidden treasures in Eversong Woods.", waypoints = EVERSONG_RARE_WAYPOINTS },
        ["Blitzcreek"] = { sourceType = "Renown Vendor", source = "Void Researcher Anomander", acquisition = "Reach The Singularity Renown 14, then buy for Voidlight Marl.", waypoints = SINGULARITY_WAYPOINTS },
        ["Dragonhawk Munchkin"] = { sourceType = "Renown Vendor", source = "Caeris Fairdawn", acquisition = "Reach Silvermoon Court Renown 12, then buy for Voidlight Marl.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Flicker"] = { sourceType = "Vendor", source = "Apprentice Diell", acquisition = "Reach Luminary standing with the Magisters of Silvermoon Court, then buy for Brimming Arcana.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Medusa"] = { sourceType = "Reputation Vendor", source = "Thraxadar", acquisition = "Reach Revered with Slayer's Duellum, then buy for Voidlight Marl.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Munchy"] = { sourceType = "Renown Vendor", source = "Naynar", acquisition = "Reach Hara'ti Renown 12, then buy for Voidlight Marl.", waypoints = HARATI_WAYPOINTS },
        ["Naloki"] = { sourceType = "Renown Vendor", source = "Magovu", acquisition = "Reach Amani Tribe Renown 12, then buy for Voidlight Marl.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Nova"] = { sourceType = "Paragon Cache", source = "Slayer's Duellum Trove", acquisition = "Chance from the Slayer's Duellum paragon cache.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Lil' Preyseeker"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Reach Preyseeker's Journey Rank 9, then buy for Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Voldy"] = { sourceType = "Prey Vendor", source = "Construct V'anore", acquisition = "Buy from Construct V'anore with Remnant of Anguish after progressing the Prey system.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
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
        ["Kreepah'zoyd"] = { sourceType = "Delves", source = "Naleidea Rivergleam", acquisition = "Buy from Naleidea Rivergleam for Undercoin.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Ominous Domanus"] = { sourceType = "Delves", source = "Nullaeus", acquisition = "Chance from Nullaeus, the Midnight Season 1 delve challenge boss.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Dali"] = { sourceType = "Treasure", source = "Burbling Paint Pot", acquisition = "Loot Burbling Paint Pot in Eversong Woods; Wowhead notes you must be near or in water to use the object that teaches the pet.", waypoints = { "/way #2395 48.7 75.5 Burbling Paint Pot" } },
        ["Gortham"] = { sourceType = "Dungeon treasure", source = "Nexus Point Xenas / Netherstorm Structural Cage", acquisition = "Bring five players to Nexus Point Xenas, clear the left-corridor trash, and stand on the five Corespark Conduits together to unlock the treasure." },
        ["Nether Siphoner"] = { sourceType = "Treasure", source = "Quivering Egg", acquisition = "Loot the Quivering Egg treasure in Voidstorm.", waypoints = { "/way #2405 31.51 44.51 Quivering Egg" } },
        ["Sunwing Hatchling"] = { sourceType = "Treasure", source = "Rookery Cache", acquisition = "Buy Tasty Meat, use it on the bowl by the Mischevious Chick, loot the dropped key, then open the upper-platform Rookery Cache.", waypoints = { "/way #2393 24.4 69.6 Rookery Cache / above" } },
        ["Percival"] = { sourceType = "Treasure", source = "Kemet's Simmering Cauldron", acquisition = "Loot Kemet's Simmering Cauldron in Harandar.", waypoints = { "/way #2413 55.6 39.5 Kemet's Simmering Cauldron" } },
        ["Perturbed Sporebat"] = { sourceType = "Treasure", source = "Impenetrably Sealed Gourd", acquisition = "Mix red and purple fluid into Fizzing Fluid, then use it on the gourd.", waypoints = { "/way #2413 27.50 67.97 Cave Entrance" } },
        ["Scruffbeak"] = { sourceType = "Treasure", source = "Abandoned Nest", acquisition = "Loot the Weathered Eagle Egg and wait 3 real-time days for it to hatch.", waypoints = { "/way #2437 42.7 52.5 Abandoned Nest" } },
        ["Willie"] = { sourceType = "Treasure", source = "Half-Digested Viscera", acquisition = "Loot the treasure inside the Voidstorm cave.", waypoints = { "/way #2405 38.06 68.74 Cave Entrance", "/way #2405 37.8 69.7 Half-Digested Viscera" } },
        ["Assistant Botanist Leafy"] = { sourceType = "Quest", source = "Re-Hydra-ted", acquisition = "Complete Re-Hydra-ted, starting with Drift Them Away." },
        ["Distorted Memory"] = { sourceType = "Quest", source = "The Empty Cradle", acquisition = "Complete The Empty Cradle." },
        ["Emberwing Hatchling"] = { sourceType = "Quest", source = "A Quiet Farewell", acquisition = "Complete A Quiet Farewell, starting with The Path of Mourning." },
        ["Emerald Hatchling"] = { sourceType = "Quest / World quest", source = "The Battle of the Bridge", acquisition = "Listed by the guide as The Battle of the Bridge; guide notes the pet may be missing from the journal." },
        ["Hawkstrider Hatchling"] = { sourceType = "Quest", source = "First Step Into Parenthood", acquisition = "Complete First Step Into Parenthood, starting with One Adventurous Hatchling, then wait one real day for the Hawkstrider Egg to hatch." },
        ["Fidoficus"] = { sourceType = "Quest", source = "Mighty and Superior", acquisition = "Complete Mighty and Superior, starting with Harvest of Darkness. The guide also notes conflicting Prey-track database information for this pet." },
        ["Linda the Lucky"] = { sourceType = "Quest", source = "O.K. Bloomer", acquisition = "Complete O.K. Bloomer, starting with Light Disturbance." },
        ["Luma"] = { sourceType = "Quest", source = "Thief at Bark", acquisition = "Complete Thief at Bark, starting with Second Time's a Choice." },
        ["Sleepy Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Grumpy Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Plump Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Screechy Mandrake"] = { sourceType = "Trading Post", source = "Trading Post", acquisition = "Trading Post pet; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Gummi the Glow Wyrm"] = { sourceType = "Promotion", source = "Unknown promotion", acquisition = "Wowhead lists this as a promotion and speculates about a Trolli / Xbox-style cross promotion; no reliable in-world source is available." },
        ["Lil' Staropod"] = { sourceType = "Promotion", source = "Unknown promotion", acquisition = "Wowhead lists this as a promotion with no reliable in-world source yet." },
        ["Razeshi C."] = { sourceType = "Promotion", source = "Discord Quest", acquisition = "Wowhead comments identify this as a Discord Quest promotion that required playing Midnight during the promotion window." },
        ["Smoldering Valor"] = { sourceType = "In-Game Shop", source = "Battle.net Shop", acquisition = "Shop pet with no in-world map source." },
        ["Star the Lucky Dragon"] = { sourceType = "In-Game Shop", source = "Battle.net Shop", acquisition = "Shop pet; Wowhead notes it was not yet generally available when the guide was written." },
        ["Aud'rei III"] = { sourceType = "Unknown / quest data", source = "Patch-filtered pet species", acquisition = "Wowhead lists this as unclear, missing from the journal, and attached to conflicting quest data." },
        ["Auspicious Pixiu"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No reliable public acquisition method or coordinate was found in the current guides." },
        ["Chillcrawler"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "Wowhead lists this under unknown source; no reliable public acquisition method or coordinate was found." },
        ["Dundun"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "Wowhead lists this under unknown source; no reliable public acquisition method or coordinate was found." },
        ["Moon Darter"] = { sourceType = "Unknown / patch-filtered", source = "Patch-filtered pet species", acquisition = "No reliable public acquisition method or coordinate was found in the current guides." },
    },
    ["12.0.5"] = {
        ["Cappy"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Earn Cosmic Exterminator, then buy Cappy from Sergeant Vornin for Voidlight Marl.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Curious Lynx Kitten"] = { sourceType = "Void Assault", source = "Wriggling Field Pouch", acquisition = "Chance from Wriggling Field Pouch during Void Assaults. Comments describe the pouch as very rare, so farm repeatable Void Strikes during active Eversong or Zul'Aman weeks.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        ["Wriggling Capybara"] = { sourceType = "Void Assault", source = "Wriggling Field Pouch", acquisition = "Chance from Wriggling Field Pouch during Void Assaults. Comments describe the pouch as very rare, so farm repeatable Void Strikes during active Eversong or Zul'Aman weeks.", waypoints = FIELD_ACCOLADE_WAYPOINTS },
        ["Chubs"] = { sourceType = "Ritual Sites", source = "Broken Throne", acquisition = "In Broken Throne Tier 2+, find the Lost Bear Cub and feed it Practically Pork.", waypoints = BROKEN_THRONE_PETS_WAYPOINTS },
        ["Overloaded Manaling"] = { sourceType = "Ritual Sites", source = "Daggerspine Point", acquisition = "Drops from Mana-Gorged Greatwyrm in Daggerspine Point Ritual Site.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Void-Infused Mindbreaker Fry"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown Rank 6, then buy from Sergeant Vornin.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Rescued Dragonhawk Chick"] = { sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown Rank 6, then buy the Void-Touched Dragonhawk Egg from Sergeant Vornin.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Snapdragon"] = { sourceType = "Ritual Sites", source = "Daggerspine Point", acquisition = "Use the Soggy Lynx Toy/Nest area during Daggerspine Point Ritual Site runs and loot the pet source there.", waypoints = DAGGERSPINE_POINT_PETS_WAYPOINTS },
        ["Void-Scarred Eaglet"] = { sourceType = "Ritual Sites", source = "Broken Throne", acquisition = "Found at the tornado/nest spot in Broken Throne.", waypoints = BROKEN_THRONE_PETS_WAYPOINTS },
        ["Void-Touched Chick"] = { sourceType = "Ritual Sites", source = "Daggerspine Point", acquisition = "Found in Daggerspine Point at the guide/comment coordinate.", waypoints = DAGGERSPINE_POINT_PETS_WAYPOINTS },
        ["Void-Touched Lynx Kitten"] = { sourceType = "Ritual Sites", source = "Rustling Bushes", acquisition = "Chance from Rustling Bushes in Ritual Sites. Route the known bush spawns during active runs.", waypoints = RITUAL_SITE_RUSTLING_BUSH_WAYPOINTS },
        ["Ka'bubb"] = { sourceType = "Abyss Anglers", source = "Depthdiver Tu'nakit", acquisition = "Complete Abyss Anglers All Blue Angler, then buy from Depthdiver Tu'nakit for Angler Pearls.", waypoints = ABYSS_ANGLERS_WAYPOINTS },
        ["The Sire's Ghastly Screecher"] = { sourceType = "Promotion", source = "Regional / unassigned", acquisition = "Patch-filtered pet with no reliable general-region in-world acquisition found; no map pin is attached." },
        ["Sha-Warped Hippogryph Hatchling"] = { sourceType = "Promotion", source = "Regional / unassigned", acquisition = "Patch-filtered pet with no reliable general-region in-world acquisition found; no map pin is attached." },
    },
    ["12.0.7"] = {
        ["Murk'atath"] = { sourceType = "Promotion", source = "BlizzCon 2026 Ultimate Collection", acquisition = "Bundle/promotion pet with no in-world farm location." },
        ["Emberlyn"] = { sourceType = "Quest / Egg Hatching", source = "Like Dragonhawks to a Flame", acquisition = "Complete Jan'alai's Egg Hatching story experience in Zul'Aman.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Frosticus Maximus"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock through Naigtal/Val activity progress, then buy from Kifaan at the active Umbral Base Camp.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Akiki"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock through Naigtal/Val activity progress, then buy from Kifaan at the active Umbral Base Camp.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Shadowflame Remnant"] = { sourceType = "Timewalking", source = "Xydan", acquisition = "Buy from Xydan during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Silento"] = { sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock by completing both Showdown Success achievements, then buy from Kifaan.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Sunflicker Driftmoth"] = { sourceType = "In-Game Shop", source = "Battle.net Shop / subscription bundle", acquisition = "Shop or subscription-bundle pet with no in-world map source." },
        ["Pinky"] = { sourceType = "Unknown / PTR", source = "Patch-filtered pet species", acquisition = "No reliable public acquisition method or coordinate was found in the current guides." },
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
        ["Zesty"] = { sourceType = "Achievement", source = "The Coiled Isle Safari", acquisition = "Click-capture the eight pets required by The Coiled Isle Safari: Autumn Snapling, Caustic Writhling, Cursed Spawn, Jaundiced Slitherer, Nightfur Kapara, Poisoned Parasite, Sleek Snakebiter, and Steady Croakfrog.", tips = "These are peaceful captures, not battles. Nightfur Kapara is the rarest stop and can take hours to respawn; if its southern route is empty, try War Mode, a group phase, or another character phase.", waypoints = COILED_ISLE_SAFARI_WAYPOINTS },
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
        ["Hexed Potatoad Mucus"] = { sourceType = "Delve treasure", source = "Atal'Aman Sturdy Chest", acquisition = "Loot one-time Sturdy Chests inside the Atal'Aman delve; comments point to a chest near the Restoration Stone in the Toadly Unbecoming variant.", waypoints = { "/way #2437 44.7 44.1 Atal'Aman delve / nearby ritual skull route" } },
        ["Potatoad Egg"] = { sourceType = "Dungeon secret", source = "The Blinding Vale", acquisition = "Get Hexed Potatoad Mucus first, enter The Blinding Vale, reach the lower river path before Ziekket, use the mucus to transform, then interact with Gravid Potatoad.", waypoints = MIDNIGHT_DUNGEON_WAYPOINTS },
        ["Pango Plating"] = { sourceType = "Achievement", source = "Treasures of Zul'Aman", acquisition = "Complete Treasures of Zul'Aman. Comments note Abandoned Ritual Skull was removed from the requirement after March 5.", waypoints = ZULAMAN_RARE_WAYPOINTS },
        ["Verdant Rutaani Seed"] = { sourceType = "Renown Vendor", source = "Naynar", acquisition = "Reach Hara'ti Renown 13, then buy from Naynar in Harandar.", waypoints = HARATI_WAYPOINTS },
        ["Saptor Salve"] = { sourceType = "Dungeon drop", source = "Ziekket / The Blinding Vale", acquisition = "Drops from Ziekket on Mythic difficulty; comments say it also became obtainable through Mythic+ once The Blinding Vale entered the season rotation.", waypoints = MIDNIGHT_DUNGEON_WAYPOINTS },
    },
    ["12.0.5"] = {
        ["Enchanted Hourglass"] = { sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Buy with Illusionary Coins from Gamesmaster Fleurian in Falconwing Square.", waypoints = DECOR_DUELS_WAYPOINTS },
        ["Animated Bench"] = { sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Buy with Illusionary Coins from Gamesmaster Fleurian in Falconwing Square.", waypoints = DECOR_DUELS_WAYPOINTS },
        ["Mana-Singed Divining Rod"] = { sourceType = "Ritual Sites", source = "Ritual Site treasure", acquisition = "Chance from Ritual Site treasure/spoils in the active 12.0.5 sites.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Deeplurk Scrying Stone"] = { sourceType = "Ritual Sites", source = "Ritual Site treasure", acquisition = "Chance from Ritual Site treasure/spoils in the active 12.0.5 sites.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Shattered Containment Pearl"] = { sourceType = "Ritual Sites", source = "Ritual Site treasure", acquisition = "Chance from Ritual Site treasure/spoils in the active 12.0.5 sites.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Soggy Lynx Toy"] = { sourceType = "Ritual Sites", source = "Daggerspine Point", acquisition = "Found around Daggerspine Point during Ritual Site runs; also used by collectors while checking the Void-Corrupted Snapdragon pet/source area.", waypoints = DAGGERSPINE_POINT_PETS_WAYPOINTS },
        ["Nap Mat"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Patch-filtered toy currently tied to Xydan's Timewalking vendor data.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
    },
    ["12.0.7"] = {
        ["Photo Finisher"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Ashen Horn of the Fallen Keeper"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Oathstone Fragment"] = { sourceType = "Timewalking Vendor", source = "Xydan", acquisition = "Buy from Xydan during Dragonflight Timewalking.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Madcap Redcap"] = { sourceType = "Raid drop", source = "Rotmire / Sporefall", acquisition = "Drops from Rotmire in Sporefall.", waypoints = SPOREFALL_WAYPOINTS },
        ["Mycomancer's Hearthspore"] = { sourceType = "Raid drop", source = "Rotmire / Sporefall", acquisition = "Drops from Rotmire in Sporefall.", waypoints = SPOREFALL_WAYPOINTS },
        ["Phase-Displaced Toy"] = { sourceType = "Treasure", source = "Bill of Lading", acquisition = "Loot from the Bill of Lading treasure/source in the 12.0.7 invasion content.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Lightveil Recall Beacon"] = { sourceType = "Quest", source = "A Swampy Welcome to Naigtal", acquisition = "Reward/source from the Naigtal introduction questline.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
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

PatchCatalog.mountDetails = {
    ["12.0"] = {
        ["Arcanovoid Construct"] = { category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Nullaeus", acquisition = "Defeat Nullaeus, the Midnight Season 1 Delve Nemesis, solo on the required high tier." },
        ["Light-Forged Mechsuit"] = { category = "Achievements", sourceType = "Achievement", source = "Achievement 42300", acquisition = "Complete the Feat of Strength tied to killing all 19 Twilight's Blade rare bosses. Wowhead item comments describe a fixed rare rotation and confirm the mount as the reward." },
        ["Elven Arcane Guardian"] = { category = "Delves", sourceType = "Vendor", source = "Naleidea Rivergleam, Delver's Headquarters in Silvermoon", acquisition = "Buy with Undercoin from Naleidea Rivergleam in Silvermoon.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Silvermoon's Arcane Defender"] = { category = "Delves", sourceType = "Vendor", source = "Telemancer Astrandis, Delver's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Delver's Journey Rank 5, then buy from Telemancer Astrandis.", waypoints = SILVERMOON_DELVES_WAYPOINTS },
        ["Giganto Manis"] = { category = "Delves", sourceType = "Achievement", source = "Glory of the Midnight Delver", acquisition = "Complete the Midnight delve meta-achievement, including delve story, sturdy chest, curio, and Nemesis objectives." },
        ["Preyseeker's Hubris"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 5, then buy with Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyseeker's Wrath"] = { category = "Vendor", sourceType = "Vendor", source = "Construct V'anore, Preyseeker's Headquarters in Silvermoon", acquisition = "Reach Midnight Season 1 Preyseeker's Journey Rank 10, then buy with Remnant of Anguish.", waypoints = CONSTRUCT_VANORE_WAYPOINTS },
        ["Preyseeker's Nightmare"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Prey: Nightmare Mode III", acquisition = "Defeat every Midnight Prey target on Nightmare difficulty." },
        ["Calamitous Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Master: Season 1", acquisition = "Earn at least 2000 Mythic+ rating during Midnight Season 1." },
        ["Convalescent Carrion"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Midnight Keystone Legend: Season 1", acquisition = "Earn at least 3000 Mythic+ rating during Midnight Season 1." },
        ["Lucent Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Degentrius in Magisters' Terrace", acquisition = "Chance to drop from Degentrius on Mythic difficulty, or from the Magisters' Terrace Mythic+ Challenger's Cache." },
        ["Spectral Hawkstrider"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Restless Heart in Windrunner's Spire", acquisition = "Chance to drop from Restless Heart on Mythic difficulty, or from the Windrunner's Spire Mythic+ Challenger's Cache." },
        ["Crimson Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Midnight Glyph Hunter", acquisition = "Collect all Skyriding Glyphs in Quel'Thalas and adjacent Midnight zones." },
        ["Cerulean Hawkstrider"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Chance to drop from rare mobs in Eversong Woods.", waypoints = EVERSONG_RARE_WAYPOINTS },
        ["Cobalt Dragonhawk"] = { category = "Rare Drops", sourceType = "Drop", source = "Eversong Woods rares", acquisition = "Chance to drop from rare mobs in Eversong Woods.", waypoints = EVERSONG_RARE_WAYPOINTS },
        ["Amani Sharptalon"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Chance to drop from rare mobs in Zul'Aman.", waypoints = ZULAMAN_RARE_WAYPOINTS },
        ["Witherbark Pango"] = { category = "Rare Drops", sourceType = "Drop", source = "Zul'Aman rares", acquisition = "Chance to drop from rare mobs in Zul'Aman.", waypoints = ZULAMAN_RARE_WAYPOINTS },
        ["Rootstalker Grimlynx"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Chance to drop from rare mobs in Harandar.", waypoints = HARANDAR_RARE_WAYPOINTS },
        ["Vibrant Petalwing"] = { category = "Rare Drops", sourceType = "Drop", source = "Harandar rares", acquisition = "Chance to drop from rare mobs in Harandar.", waypoints = HARANDAR_RARE_WAYPOINTS },
        ["Ruddy Sporeglider"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Peculiar Cauldron in Harandar", acquisition = "Open the Peculiar Cauldron around /way #2413 40.7 28.1 after collecting 150 of the required cauldron items from small river treasures nearby. Wowhead comments recommend farming along the river from the northern lake toward the Den.", waypoints = { "/way #2413 40.7 28.1 Peculiar Cauldron", "/way #2413 40.0 21.4 River treasure route start", "/way #2413 49.32 51.16 River treasure route end" } },
        ["Untainted Grove Crawler"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Sporespawned Cache in Harandar", acquisition = "Use the Fungal Mallet in Fungara Village to gain the buff, then ring the nearby Mycelium Gong. The Sporespawned Cache appears next to the gong and can contain the mount.", waypoints = { "/way #2413 41.31 67.90 Fungal Mallet", "/way #2413 46.65 67.78 Mycelium Gong / Sporespawned Cache" } },
        ["Echo of Aln'sharan"] = { category = "Quest Rewards", sourceType = "Hidden turn-in", source = "Kuri in Harandar", acquisition = "After completing the relevant Harandar storyline, farm 500 rare skyshards from Harandar mobs and delves, then turn them in to Kuri. Comments note Kuri is airborne near the edge of the zone and you may need to dismount to interact.", waypoints = { "/way #2413 66.15 25.47 Kuri" } },
        ["Augmented Stormray"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Chance to drop from rare mobs in Voidstorm.", waypoints = VOIDSTORM_RARE_WAYPOINTS },
        ["Sanguine Harrower"] = { category = "Rare Drops", sourceType = "Drop", source = "Voidstorm rares", acquisition = "Chance to drop from rare mobs in Voidstorm.", waypoints = VOIDSTORM_RARE_WAYPOINTS },
        ["Ancestral War Bear"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Honored Warrior's Cache in Zul'Aman", acquisition = "Interact with Honored Warrior's Cache, collect four key items from guardian urn events across Zul'Aman, then return to open the cache.", waypoints = { "/way #2437 21.45 77.38 Honored Warrior's Cache", "/way #2437 32.69 83.50 Nalorakk's Cache", "/way #2437 34.55 33.46 Halazzi's Cache", "/way #2437 54.78 22.39 Jan'alai's Cache", "/way #2437 51.58 84.92 Akil'zon's Cache" } },
        ["Hexed Vilefeather Eagle"] = { category = "Quest Rewards", sourceType = "Treasure", source = "Abandoned Ritual Skull in Zul'Aman", acquisition = "Open the Abandoned Ritual Skull treasure after farming the required Vile Essence from nearby mobs.", waypoints = { "/way #2437 44.7 44.1 Abandoned Ritual Skull" } },
        ["Relinquished Scarlet Charger"] = { category = "Quest Rewards", sourceType = "Quest", source = "Relinquishing Relics", acquisition = "Complete the Relinquishing Relics questline." },
        ["Ashes of Belo'ren"] = { category = "Dungeon and Raids", sourceType = "Drop", source = "Midnight Falls in March on Quel'Danas", acquisition = "Drops from Midnight Falls on Mythic difficulty. Wowhead notes three mounts are guaranteed per kill." },
        ["Tenebrous Harrower"] = { category = "Dungeon and Raids", sourceType = "Achievement", source = "Glory of the Midnight Raider", acquisition = "Complete the raid meta-achievement across The Dreamrift, Voidspire, and March on Quel'Danas." },
        ["Crimson Silvermoon Hawkstrider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 17, then buy from Caeris Fairdawn in Eversong Woods.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Fiery Dragonhawk"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Caeris Fairdawn, Silvermoon Court", acquisition = "Reach Silvermoon Court Renown 19, then buy from Caeris Fairdawn in Eversong Woods.", waypoints = SILVERMOON_COURT_WAYPOINTS },
        ["Peridot Dragonhawk"] = { category = "Quest Rewards", sourceType = "Quest reward", source = "Midnight launch quest content", acquisition = "Wowhead's filtered mount list marks this as a quest-sourced mount, but the public spell/item comments did not expose a more precise quest chain during this scrape." },
        ["Amani Blessed Bear"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 17, then buy from Magovu in Zul'Aman.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Amani Windcaller"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Magovu, Amani Tribe", acquisition = "Reach Amani Tribe Renown 19, then buy from Magovu in Zul'Aman.", waypoints = AMANI_TRIBE_WAYPOINTS },
        ["Fierce Grimlynx"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 16, then buy from Naynar in Harandar.", waypoints = HARATI_WAYPOINTS },
        ["Cerulean Sporeglider"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Naynar, Hara'ti", acquisition = "Reach Hara'ti Renown 19, then buy from Naynar in Harandar.", waypoints = HARATI_WAYPOINTS },
        ["Ravenous Shredclaw"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 17, then buy from Void Researcher Anomander in Voidstorm.", waypoints = SINGULARITY_WAYPOINTS },
        ["Voidbound Stormray"] = { category = "Vendor", sourceType = "Renown Vendor", source = "Void Researcher Anomander, The Singularity", acquisition = "Reach The Singularity Renown 19, then buy from Void Researcher Anomander in Voidstorm.", waypoints = SINGULARITY_WAYPOINTS },
        ["Lab-Grown Stormray"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Staring Into The Void", acquisition = "Spend Uncontaminated Void Samples at the Void Research Console in Voidstorm after progressing The Singularity Renown.", waypoints = SINGULARITY_WAYPOINTS },
        ["Frenzied Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy from Thraxadar in Voidstorm.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Prowling Shredclaw"] = { category = "Vendor", sourceType = "Reputation Vendor", source = "Thraxadar, Slayer's Duellum", acquisition = "Reach Exalted with Slayer's Duellum, then buy from Thraxadar in Voidstorm.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Umbral Dragonhawk"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Life of the Party", acquisition = "Earn the Life of the Party achievement." },
        ["Duskbrute Harrower"] = { category = "Rare Drops", sourceType = "Paragon Cache", source = "Slayer's Duellum Trove", acquisition = "Chance to drop from the Slayer's Duellum paragon cache.", waypoints = SLAYERS_DUELLUM_WAYPOINTS },
        ["Amani Sunfeather"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Earn Unalloyed Abundance from the Abundance world event, then buy from Chel the Chip at Abundance cavern entrances.", waypoints = ABUNDANCE_WAYPOINTS },
        ["Blessed Amani Burrower"] = { category = "Vendor", sourceType = "World Event Vendor", source = "Chel the Chip, Abundance", acquisition = "Earn Unalloyed Abundance from the Abundance world event, then buy from Chel the Chip at Abundance cavern entrances.", waypoints = ABUNDANCE_WAYPOINTS },
        ["Vivid Chloroceros"] = { category = "Vendor", sourceType = "Vendor currency", source = "Harandar treasure currency vendor", acquisition = "Collect 120 Harandar treasures for the related achievement and spend the zone currency at the associated Hara'ti vendor. Comments note treasure visibility is gated by Hara'ti renown.", waypoints = HARATI_WAYPOINTS },
        ["Anu'shalla, Shadow's Guidance"] = { category = "Achievements", sourceType = "Collection achievement", source = "Mount collection achievement", acquisition = "Wowhead comments identify this as a high mount-count achievement reward; treat as a mount collection milestone reward." },
        ["Galactic Gladiator's Goredrake"] = { category = "PvP", sourceType = "Achievement", source = "Gladiator: Midnight Season 1", acquisition = "Win 50 3v3 arena games while at Elite rank during Midnight Season 1." },
        ["Vicious Snaplizard"] = { category = "PvP", sourceType = "Achievement", source = "Midnight Season 1 Rated PvP", acquisition = "Win rated PvP matches while at 1000+ rating during Midnight Season 1." },
    },
    ["12.0.5"] = {
        ["Unbound Manawyrm"] = { category = "Vendor", sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Complete Void Response Team and Ritual Site Disruptor, then buy from Sergeant Vornin on the upper deck of the Bazaar in Silvermoon City.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Hawkstrider"] = { category = "Vendor", sourceType = "Vendor", source = "Sergeant Vornin", acquisition = "Reach Ritual Sites Renown Rank 8, then buy from Sergeant Vornin.", waypoints = SERGEANT_VORNIN_WAYPOINTS },
        ["Void-Corrupted Hex Eagle"] = { category = "Rare Drops", sourceType = "Ritual Site drop", source = "Broken Throne", acquisition = "In Broken Throne Tier 2+, restore the missing candle to the ritual circle, click the candles to spawn the Void-Corrupted Hex Eagle, then kill it for a chance at the mount.", waypoints = BROKEN_THRONE_HEX_EAGLE_WAYPOINTS },
        ["Void-Touched Snapdragon"] = { category = "Rare Drops", sourceType = "Ritual Site drop", source = "Daggerspine Point", acquisition = "In Daggerspine Point Tier 2+, click Washed Up Kelp along the shore. One or two can appear per run and may spawn the Void-Touched Snapdragon rare.", waypoints = { "/way #2395 34.9 65.4 Daggerspine Point Ritual Site", "/way #2395 29.0 62.0 Washed Up Kelp / shore route" } },
        ["Witherbark Warbear Mother"] = { category = "Rare Drops", sourceType = "Ritual Site secret", source = "Broken Throne", acquisition = "Collect 6 Practically Pork. In Broken Throne Tier 2+, feed the Lost Bear Cub once to obtain Chubs, learn and summon Chubs, then go north to spawn and feed the Angry Amani Warbear.", waypoints = WITHERBARK_WARBEAR_WAYPOINTS },
        ["Void-Corrupted Lynx"] = { category = "Professions", sourceType = "Leatherworking", source = "Rope Lynx Harness", acquisition = "Crafted by Leatherworking. Both the Rope Lynx Harness pattern and the Broken Lynx Leash bind-on-pickup material come from Treasure and Rare Spoils in Ritual Sites.", waypoints = RITUAL_SITE_ENTRANCE_WAYPOINTS },
        ["Breaker Bee"] = { category = "Vendor", sourceType = "Decor Duels", source = "Gamesmaster Fleurian", acquisition = "Earn Illusionary Coins through Decor Duels, then buy the Magister's Spell Bee Comb from Gamesmaster Fleurian in Falconwing Square.", waypoints = DECOR_DUELS_WAYPOINTS },
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
        ["Blossomback Arboon"] = { category = "Other", sourceType = "Unknown / patch-filtered", source = "Wowhead 12.0.5 mount filter", acquisition = "No reliable public acquisition method was found; keep in this patch slice until a concrete source appears." },
        ["Amberback Arboon"] = { category = "Other", sourceType = "Unknown / patch-filtered", source = "Wowhead 12.0.5 mount filter", acquisition = "No reliable public acquisition method was found; keep in this patch slice until a concrete source appears." },
        ["Dusk-Painted Sun Roc"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "Patch-filtered mount with no reliable general-region in-world source yet." },
        ["Flame-Painted Sun Roc"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "Patch-filtered mount with no reliable general-region in-world source yet." },
        ["[PH] Giant Eagle Sunwalker Mount Blue"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead 12.0.5 mount filter", acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet." },
        ["[PH] Giant Eagle Sunwalker Mount White"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead 12.0.5 mount filter", acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet." },
        ["The Sire's Palanquin"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "No general-region in-world source is available." },
        ["Scarlet Lady"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "No general-region in-world source is available." },
        ["Sha-Warped Riding Wolf"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "No general-region in-world source is available." },
        ["Sha-Warped Owl"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "No general-region in-world source is available." },
        ["Zothwing Darkseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Patch-filtered shop mount", acquisition = "Purchase availability is handled through the shop, so there is no in-world map source." },
        ["Zothwing Deepseeker"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "Patch-filtered shop mount", acquisition = "Purchase availability is handled through the shop, so there is no in-world map source." },
    },
    ["12.0.7"] = {
        ["Dusk Grimlynx"] = { category = "Quest Rewards", sourceType = "Questline", source = "Legacy of the Amani / Hagar's Invitation", acquisition = "Accept Hagar's Invitation from Orweyna in Silvermoon and progress the Legacy of the Amani questline.", waypoints = { "/way #2393 45.6 70.0 Orweyna / Hagar's Invitation" } },
        ["Amani Hex Bear"] = { category = "Other", sourceType = "Unknown", source = "Wowhead 12.0.7 mount filter", acquisition = "The 12.0.7 mount guide still lists this as unknown, so no coordinate is attached." },
        ["Stoneforged Sentinel"] = { category = "In-Game Shop", sourceType = "Battle.net Shop", source = "In-Game Shop", acquisition = "Purchase through the shop; no in-world map source." },
        ["Luminous Sporeglider"] = { category = "Dungeon and Raids", sourceType = "Raid drop / weekly combine", source = "Rotmire / Sporefall", acquisition = "Defeat Rotmire in Sporefall once per weekly reset for Delicious Sporesnack, then combine four snacks to learn the mount.", waypoints = SPOREFALL_WAYPOINTS },
        ["Netherforged Nullframe"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock A Trip Through the Stars, then buy from Kifaan for 5 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Voidmancer's Starcarver"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock A Trip Around the Stars, then buy from Kifaan for 5 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Tortured Gorger"] = { category = "Vendor", sourceType = "Vendor", source = "Kifaan", acquisition = "Unlock Heroic Showdowns, then buy from Kifaan for 5 Voidlight Marl.", waypoints = NAIGTAL_VAL_INVASION_WAYPOINTS },
        ["Sun Festival's Painted Roc"] = { category = "World Events", sourceType = "Holiday boss", source = "Frost Lord Ahune / Midsummer Fire Festival", acquisition = "During Midsummer Fire Festival, loot the first eligible Satchel of Chilled Goods each day across the Warband for an increasing chance at the mount.", waypoints = AHUNE_WAYPOINTS },
        ["Spawn of Vyranoth"] = { category = "Achievements", sourceType = "Achievement", source = "Master of the Turbulent Timeways V", acquisition = "Earn Master of the Turbulent Timeways V during the event; comments later note vendor availability for Timewarped Badges.", waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" } },
        ["Blackwater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Trading Post / Traveler's Log", source = "Trading Post", acquisition = "Trading Post reward; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Bilgewater X-TREME Firework Rocket"] = { category = "Trading Post", sourceType = "Trading Post / Traveler's Log", source = "Trading Post", acquisition = "Trading Post reward; check monthly inventory and Outlet returns.", waypoints = TRADING_POST_WAYPOINTS },
        ["Green Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined placeholder recolor; check future Trading Post inventory.", waypoints = TRADING_POST_WAYPOINTS },
        ["Pink Rocket Mount [PH]"] = { category = "Trading Post", sourceType = "Trading Post / placeholder", source = "Future Trading Post rotation", acquisition = "Datamined placeholder recolor; check future Trading Post inventory.", waypoints = TRADING_POST_WAYPOINTS },
        ["Sunflare Driftmoth"] = { category = "In-Game Shop", sourceType = "Battle.net Shop / subscription bundle", source = "In-Game Shop", acquisition = "Shop or subscription-bundle mount with no in-world map source." },
        ["Spring Panda"] = { category = "Promotion", sourceType = "Regional / unassigned", source = "Patch-filtered appearance", acquisition = "No general-region in-world source is available." },
        ["Rabbit'ath"] = { category = "Promotion", sourceType = "BlizzCon 2026 Bundle", source = "Battle.net Shop", acquisition = "Included in the World of Warcraft BlizzCon 2026 Bundle and BlizzCon Ultimate Collection." },
        ["[PH] Horse with Hat"] = { category = "Other", sourceType = "Placeholder", source = "Wowhead 12.0.7 mount filter", acquisition = "Placeholder mount entry; no reliable acquisition method or coordinate yet." },
        ["Shadow Spirehawk"] = { category = "Promotion", sourceType = "Unknown / promotion", source = "Patch-filtered appearance", acquisition = "No reliable in-world acquisition method is available yet." },
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
        ["Auriferous Venomfang"] = { category = "Quest Rewards", sourceType = "Achievement", source = "Treasures of the Coiled Isle", acquisition = "Loot all 22 hidden treasures on The Coiled Isle. Several treasures require short interaction chains, keys, nearby NPC dialogue, fishing, or temporary objects before the final treasure can be opened.", waypoints = COILED_ISLE_TREASURE_WAYPOINTS },
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
    if collectionType ~= "mounts" and collectionType ~= "pets" and collectionType ~= "toys" and collectionType ~= "achievements" then
        return nil
    end
    if self:IsAchievementSourcedCollection(collectionType, patchKey, entry) then
        return nil
    end

    local sourceSummary = self:GetCollectionSourceSummary(collectionType, patchKey, entry)
    local acquisition = self:GetCollectionAcquisitionText(collectionType, patchKey, entry)
    local effect = self:GetCollectionUseText(collectionType, patchKey, entry)
    local tips = self:GetCollectionTips(collectionType, patchKey, entry)
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
                pin.tips = tips
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
        description = state and state.description,
        criteria = state and state.criteria,
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
