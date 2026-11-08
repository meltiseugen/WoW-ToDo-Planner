local _, TDP = ...

-- Expansion-neutral milestones and metas spanning multiple expansions.
-- Reviewed individually; introduction of the achievement system is not content ownership.
-- Named expansion zones, instances, factions and encounter challenges remain
-- with their content. Name/criteria reference: https://wago.tools/db2/Achievement/csv
-- Retail cleanup (2026-11-03): omit pre-Shadowlands level records 10-13,
-- removed 5v5 records 404/406/407/409/1161 and their Arena Master meta 1174,
-- old bank-slot achievement 546 (replaced in 11.2), removed riding skills 891/892,
-- the retired original RAF feat 1436 and Dual Talent Specialization 2716.
-- Reissued reward items do not necessarily grant their original retired feat.
TDP.CatalogRegistry:RegisterPatch("general", {
    label = "General",
    sourceNotes = {
        "General achievements cover unrestricted milestones, account activities and metas spanning expansions. They are grouped independently of the patch that introduced the achievement record.",
        "This section currently contains neutral records reviewed during the Classic, Burning Crusade and Wrath catalogue split. Expansion-specific zones, dungeons, raids, reputations and seasonal rewards stay with their content.",
    },
})

TDP.CatalogRegistry:RegisterCollection("general", "achievements", {
    entries = {
        ids = {
            6, -- Level 10
            7, -- Level 20
            8, -- Level 30
            9, -- Level 40
            15, -- Plenty of Pets
            31, -- A Simple Re-Quest
            32, -- 2000 Quests Completed
            46, -- Universal Explorer
            153, -- The Old Gnome and the Sea
            227, -- Damage Control
            229, -- The Grim Reaper
            230, -- Battlemaster
            231, -- Wrecking Ball
            238, -- An Honorable Kill
            239, -- 25000 Honorable Kills
            245, -- That Takes Class
            246, -- Know Thy Enemy
            247, -- Make Love, Not Warcraft
            388, -- City Defender
            397, -- Step Into The Arena
            398, -- Mercilessly Dedicated
            399, -- Just the Two of Us: 1550
            400, -- Just the Two of Us: 1750
            401, -- Just the Two of Us: 2000
            402, -- Three's Company: 1550
            403, -- Three's Company: 1750
            405, -- Three's Company: 2000
            408, -- Hot Streak
            503, -- 50 Quests Completed
            504, -- 100 Quests Completed
            505, -- 250 Quests Completed
            506, -- 500 Quests Completed
            507, -- 1000 Quests Completed
            508, -- 1500 Quests Completed
            509, -- 10000 Honorable Kills
            512, -- 5000 Honorable Kills
            513, -- 100 Honorable Kills
            515, -- 500 Honorable Kills
            516, -- 1000 Honorable Kills
            518, -- 30 Exalted Reputations
            519, -- 25 Exalted Reputations
            520, -- 20 Exalted Reputations
            521, -- 15 Exalted Reputations
            522, -- Somebody Likes Me
            523, -- 5 Exalted Reputations
            524, -- 10 Exalted Reputations
            545, -- Shave and a Haircut
            603, -- Wrath of the Horde
            604, -- Wrath of the Alliance
            614, -- For the Alliance!
            619, -- For the Horde!
            621, -- Represent
            699, -- World Wide Winner
            700, -- Freedom of the Horde
            701, -- Freedom of the Alliance
            727, -- Call in the Cavalry
            762, -- Ambassador of the Horde
            869, -- 50000 Honorable Kills
            870, -- 100000 Honorable Kills
            875, -- Vengefully Dedicated
            876, -- Brutally Dedicated
            878, -- One That Didn't Get Away
            889, -- Fast and Furious
            890, -- Into the Wild Blue Yonder
            908, -- Call to Arms!
            909, -- Call to Arms!
            941, -- Hemet Nesingwary: The Collected Quests
            942, -- The Diplomat
            943, -- The Diplomat
            945, -- The Argent Champion
            948, -- Ambassador of the Alliance
            953, -- Guardian of Cenarius
            964, -- Going Down?
            973, -- 5 Daily Quests Completed
            974, -- 50 Daily Quests Completed
            975, -- 200 Daily Quests Completed
            976, -- 500 Daily Quests Completed
            977, -- 1000 Daily Quests Completed
            978, -- 3000 Quests Completed
            1005, -- Know Thy Enemy
            1006, -- City Defender
            1014, -- 35 Exalted Reputations
            1015, -- 40 Exalted Reputations
            1017, -- Can I Keep Him?
            1020, -- Ten Tabards
            1021, -- Twenty-Five Tabards
            1157, -- Duel-icious
            1159, -- Just the Two of Us: 2200
            1160, -- Three's Company: 2200
            1162, -- Hotter Streak
            1175, -- Battlemaster
            1176, -- Got My Mind On My Money
            1177, -- Got My Mind On My Money
            1178, -- Got My Mind On My Money
            1180, -- Got My Mind On My Money
            1181, -- Got My Mind On My Money
            1182, -- The Bread Winner
            1206, -- To All The Squirrels I've Loved Before
            1243, -- Fish Don't Leave Footprints
            1248, -- Plethora of Pets
            1250, -- Shop Smart, Shop Pet...Smart
            1257, -- The Scavenger
            1516, -- Accomplished Angler
            1556, -- 25 Fish
            1557, -- 50 Fish
            1558, -- 100 Fish
            1559, -- 250 Fish
            1560, -- 500 Fish
            1561, -- 1000 Fish
            1563, -- Hail to the Chef
            1576, -- Of Blood and Anguish
            1795, -- Lunch Lady
            1796, -- Short Order Cook
            1797, -- Chef de Partie
            1798, -- Sous Chef
            1799, -- Chef de Cuisine
            1832, -- Tastes Like Chicken
            1833, -- It's Happy Hour Somewhere
            1998, -- Cooking Award
            1999, -- 10 Cooking Awards
            2000, -- 25 Cooking Awards
            2001, -- 50 Cooking Awards
            2002, -- 100 Cooking Awards
            2090, -- Challenger
            2091, -- Gladiator
            2092, -- Duelist
            2093, -- Rival
            2141, -- Stable Keeper
            2142, -- Filling Up The Barn
            2143, -- Leading the Cavalry
            2516, -- Lil' Game Hunter
            2536, -- Mountain o' Mounts
            2537, -- Mountain o' Mounts
            2556, -- Pest Control
            4476, -- Looking For More
            4477, -- Looking For Many
            4478, -- Looking For Multitudes
            4496, -- It's Over Nine Thousand!
        },
        rewardHighlights = {},
    },
    details = {
        [6] = {
            name = "Level 10",
            acquisition = "Reach level 10.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=6",
        },
        [7] = {
            name = "Level 20",
            acquisition = "Reach level 20.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=7",
        },
        [8] = {
            name = "Level 30",
            acquisition = "Reach level 30.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=8",
        },
        [9] = {
            name = "Level 40",
            acquisition = "Reach level 40.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=9",
        },
        [15] = {
            name = "Plenty of Pets",
            acquisition = "Collect 15 unique pets.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=15",
        },
        [31] = {
            name = "A Simple Re-Quest",
            acquisition = "Complete a daily quest every day for five consecutive days.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=31",
        },
        [32] = {
            name = "2000 Quests Completed",
            acquisition = "Complete 2000 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=32",
        },
        [46] = {
            name = "Universal Explorer",
            acquisition = "Explore Eastern Kingdoms, Kalimdor, Outland, Northrend, the areas revealed by the Cataclysm, Pandaria, Draenor, the Broken Isles, Kul Tiras, and Zandalar.",
            source = "General exploration milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=46",
        },
        [153] = {
            name = "The Old Gnome and the Sea",
            acquisition = "1. Learn Fishing, then find a visible fish school or Steam Pump Flotsam pool in Zangarmarsh.\n2. Cast so the bobber lands inside the pool, and loot a successful catch. Casting into ordinary open water beside a school does not count.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=153#comments",
        },
        [227] = {
            name = "Damage Control",
            acquisition = "Do 300,000 damage or healing in a single battle in any battleground. The damage or healing must be done to a player.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=227",
        },
        [229] = {
            name = "The Grim Reaper",
            acquisition = "Get 30 Honorable Kills in a single battle in any battleground.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=229",
        },
        [230] = {
            name = "Battlemaster",
            acquisition = "Complete the battleground achievements listed below.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=230",
        },
        [231] = {
            name = "Wrecking Ball",
            acquisition = "Get 20 killing blows without dying in a single battle in any battleground.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=231",
        },
        [238] = {
            name = "An Honorable Kill",
            acquisition = "Achieve an honorable kill.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=238",
        },
        [239] = {
            name = "25000 Honorable Kills",
            acquisition = "Get 25000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=239",
        },
        [245] = {
            name = "That Takes Class",
            acquisition = "Get an honorable, killing blow on one of each class.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=245",
        },
        [246] = {
            name = "Know Thy Enemy",
            acquisition = "Get an honorable, killing blow against all Horde races.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=246",
        },
        [247] = {
            name = "Make Love, Not Warcraft",
            acquisition = "Emote /hug on a dead enemy before they release corpse.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=247",
        },
        [388] = {
            name = "City Defender",
            acquisition = "Kill 50 enemy players in any of your home cities.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=388",
        },
        [397] = {
            name = "Step Into The Arena",
            acquisition = "Win a ranked arena match.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=397",
        },
        [398] = {
            name = "Mercilessly Dedicated",
            acquisition = "Win 100 ranked arena matches.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=398",
        },
        [399] = {
            name = "Just the Two of Us: 1550",
            acquisition = "Earn a 1550 personal rating in the 2v2 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=399",
        },
        [400] = {
            name = "Just the Two of Us: 1750",
            acquisition = "Earn a 1750 personal rating in the 2v2 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=400",
        },
        [401] = {
            name = "Just the Two of Us: 2000",
            acquisition = "Earn a 2000 personal rating in the 2v2 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=401",
        },
        [402] = {
            name = "Three's Company: 1550",
            acquisition = "Earn a 1550 personal rating in the 3v3 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=402",
        },
        [403] = {
            name = "Three's Company: 1750",
            acquisition = "Earn a 1750 personal rating in the 3v3 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=403",
        },
        [405] = {
            name = "Three's Company: 2000",
            acquisition = "Earn a 2000 personal rating in the 3v3 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=405",
        },
        [408] = {
            name = "Hot Streak",
            acquisition = "Win ten ranked matches in a row.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=408",
        },
        [503] = {
            name = "50 Quests Completed",
            acquisition = "Complete 50 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=503",
        },
        [504] = {
            name = "100 Quests Completed",
            acquisition = "Complete 100 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=504",
        },
        [505] = {
            name = "250 Quests Completed",
            acquisition = "Complete 250 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=505",
        },
        [506] = {
            name = "500 Quests Completed",
            acquisition = "Complete 500 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=506",
        },
        [507] = {
            name = "1000 Quests Completed",
            acquisition = "Complete 1000 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=507",
        },
        [508] = {
            name = "1500 Quests Completed",
            acquisition = "Complete 1500 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=508",
        },
        [509] = {
            name = "10000 Honorable Kills",
            acquisition = "Get 10000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=509",
        },
        [512] = {
            name = "5000 Honorable Kills",
            acquisition = "Get 5000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=512",
        },
        [513] = {
            name = "100 Honorable Kills",
            acquisition = "Get 100 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=513",
        },
        [515] = {
            name = "500 Honorable Kills",
            acquisition = "Get 500 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=515",
        },
        [516] = {
            name = "1000 Honorable Kills",
            acquisition = "Get 1000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=516",
        },
        [518] = {
            name = "30 Exalted Reputations",
            acquisition = "Raise 30 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=518",
        },
        [519] = {
            name = "25 Exalted Reputations",
            acquisition = "Raise 25 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=519",
        },
        [520] = {
            name = "20 Exalted Reputations",
            acquisition = "Raise 20 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=520",
        },
        [521] = {
            name = "15 Exalted Reputations",
            acquisition = "Raise 15 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=521",
        },
        [522] = {
            name = "Somebody Likes Me",
            acquisition = "Raise a reputation to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=522",
        },
        [523] = {
            name = "5 Exalted Reputations",
            acquisition = "Raise 5 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=523",
        },
        [524] = {
            name = "10 Exalted Reputations",
            acquisition = "Raise 10 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=524",
        },
        [545] = {
            name = "Shave and a Haircut",
            acquisition = "Visit a Barber Shop and alter your appearance.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=545",
        },
        [603] = {
            name = "Wrath of the Horde",
            acquisition = "Kill 5 Alliance players in each of the cities listed below.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=603",
        },
        [604] = {
            name = "Wrath of the Alliance",
            acquisition = "Kill 5 Horde players in each of the cities listed below.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=604",
        },
        [614] = {
            name = "For the Alliance!",
            acquisition = "Slay the leaders of the Horde.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=614",
        },
        [619] = {
            name = "For the Horde!",
            acquisition = "Slay the leaders of the Alliance.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=619",
        },
        [621] = {
            name = "Represent",
            acquisition = "Collect a tabard slot appearance.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=621",
        },
        [699] = {
            name = "World Wide Winner",
            acquisition = "Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=699",
        },
        [700] = {
            name = "Freedom of the Horde",
            acquisition = "Obtain an Insignia or Medallion of the Horde.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=700",
        },
        [701] = {
            name = "Freedom of the Alliance",
            acquisition = "Obtain an Insignia or Medallion of the Alliance.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=701",
        },
        [727] = {
            name = "Call in the Cavalry",
            acquisition = "1. Earn Marks of Honor through PvP and visit Lieutenant Karter in Stormwind (76.2, 65.6) or Raider Bork in Orgrimmar (41.8, 72.6).\n2. Buy one of the original Black War mounts listed by this achievement, such as Black War Steed or Black War Wolf. Check the vendor's current price before purchasing.\n3. Use the mount item to learn it. Merely purchasing the item and leaving it refundable is not sufficient.",
            sourceType = "Achievement",
            source = "Lieutenant Karter / Raider Bork",
            sourceURL = "https://www.wowhead.com/achievement=727#comments",
            waypoints = { "/way #84 76.2 65.6 Lieutenant Karter - Alliance honor mounts", "/way #85 41.8 72.6 Raider Bork - Horde honor mounts" },
        },
        [762] = {
            name = "Ambassador of the Horde",
            acquisition = "Earn Exalted reputation with all six Horde factions.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=762",
        },
        [869] = {
            name = "50000 Honorable Kills",
            acquisition = "Get 50000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=869",
        },
        [870] = {
            name = "100000 Honorable Kills",
            acquisition = "Get 100000 honorable kills.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=870",
        },
        [875] = {
            name = "Vengefully Dedicated",
            acquisition = "Win 200 ranked arena matches.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=875",
        },
        [876] = {
            name = "Brutally Dedicated",
            acquisition = "Win 300 ranked arena matches.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=876",
        },
        [878] = {
            name = "One That Didn't Get Away",
            acquisition = "1. Travel to Howling Fjord and look for Fangtooth Herring Schools along its waters.\n2. Fish those schools for a chance at Dark Herring. Move to another school when one is depleted; the rare catch is not guaranteed in a fixed number of casts.\n3. Catch the fish yourself and loot it. Only one of the listed rare fish is required; buying a rare fish does not count as catching it.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=878#comments",
        },
        [889] = {
            name = "Fast and Furious",
            acquisition = "Learn the Journeyman Riding skill.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=889",
        },
        [890] = {
            name = "Into the Wild Blue Yonder",
            acquisition = "Learn the Expert Riding skill.",
            source = "General other milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=890",
        },
        [908] = {
            name = "Call to Arms!",
            acquisition = "Complete 100 battlegrounds at max level.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=908",
        },
        [909] = {
            name = "Call to Arms!",
            acquisition = "Complete 100 battlegrounds at max level.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=909",
        },
        [941] = {
            name = "Hemet Nesingwary: The Collected Quests",
            acquisition = "Complete the Green Hills of Stranglethorn, Hills Like White Elekk and Snows of Northrend achievements.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=941",
        },
        [942] = {
            name = "The Diplomat",
            acquisition = "Raise your reputation level from Unfriendly to Exalted with Timbermaw Hold, Sporeggar and the Kurenai.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=942",
        },
        [943] = {
            name = "The Diplomat",
            acquisition = "Raise your reputation level from Unfriendly to Exalted with Timbermaw Hold, Sporeggar and The Mag'har.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=943",
        },
        [945] = {
            name = "The Argent Champion",
            acquisition = "Earn Exalted status with the Argent Dawn and the Argent Crusade.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=945",
        },
        [948] = {
            name = "Ambassador of the Alliance",
            acquisition = "Earn Exalted reputation with all six Alliance factions.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=948",
        },
        [953] = {
            name = "Guardian of Cenarius",
            acquisition = "Earn Exalted status with the Cenarion Circle and Cenarion Expedition. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "General reputation milestones",
            sourceURL = "https://www.wowhead.com/achievement=953",
        },
        [964] = {
            name = "Going Down?",
            acquisition = "Fall 65 yards without dying.",
            source = "General exploration milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=964",
        },
        [973] = {
            name = "5 Daily Quests Completed",
            acquisition = "Complete 5 daily quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=973",
        },
        [974] = {
            name = "50 Daily Quests Completed",
            acquisition = "Complete 50 daily quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=974",
        },
        [975] = {
            name = "200 Daily Quests Completed",
            acquisition = "Complete 200 daily quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=975",
        },
        [976] = {
            name = "500 Daily Quests Completed",
            acquisition = "Complete 500 daily quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=976",
        },
        [977] = {
            name = "1000 Daily Quests Completed",
            acquisition = "Complete 1000 daily quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=977",
        },
        [978] = {
            name = "3000 Quests Completed",
            acquisition = "Complete 3000 quests.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=978",
        },
        [1005] = {
            name = "Know Thy Enemy",
            acquisition = "Get an honorable, killing blow against all Alliance races.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1005",
        },
        [1006] = {
            name = "City Defender",
            acquisition = "Kill 50 enemy players in any of your home cities.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1006",
        },
        [1014] = {
            name = "35 Exalted Reputations",
            acquisition = "Raise 35 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1014",
        },
        [1015] = {
            name = "40 Exalted Reputations",
            acquisition = "Raise 40 reputations to Exalted.",
            source = "General reputation milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1015",
        },
        [1017] = {
            name = "Can I Keep Him?",
            acquisition = "Obtain a pet.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1017",
        },
        [1020] = {
            name = "Ten Tabards",
            acquisition = "Collect 10 tabard slot appearances.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1020",
        },
        [1021] = {
            name = "Twenty-Five Tabards",
            acquisition = "Collect 25 tabard slot appearances.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1021",
        },
        [1157] = {
            name = "Duel-icious",
            acquisition = "Win a duel against another player.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1157",
        },
        [1159] = {
            name = "Just the Two of Us: 2200",
            acquisition = "Earn a 2200 personal rating in the 2v2 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1159",
        },
        [1160] = {
            name = "Three's Company: 2200",
            acquisition = "Earn a 2200 personal rating in the 3v3 bracket of the arena.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1160",
        },
        [1162] = {
            name = "Hotter Streak",
            acquisition = "Win ten ranked matches in a row with a personal rating above 1800.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1162",
        },
        [1175] = {
            name = "Battlemaster",
            acquisition = "Complete the battleground achievements listed below.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1175",
        },
        [1176] = {
            name = "Got My Mind On My Money",
            acquisition = "Loot 100 gold.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1176",
        },
        [1177] = {
            name = "Got My Mind On My Money",
            acquisition = "Loot 1,000 gold.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1177",
        },
        [1178] = {
            name = "Got My Mind On My Money",
            acquisition = "Loot 5,000 gold.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1178",
        },
        [1180] = {
            name = "Got My Mind On My Money",
            acquisition = "Loot 10,000 gold.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1180",
        },
        [1181] = {
            name = "Got My Mind On My Money",
            acquisition = "Loot 25,000 gold.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1181",
        },
        [1182] = {
            name = "The Bread Winner",
            acquisition = "Make 10,000 gold from quest rewards.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1182",
        },
        [1206] = {
            name = "To All The Squirrels I've Loved Before",
            acquisition = "1. Target each required living critter and use /love. You need credit for every species; do not kill them.\n2. In Elwynn Forest, find Cat, Chicken, Cow, Deer, Fawn, Rabbit and Small Frog around Goldshire and its woods or ponds.\n3. In Durotar, find Hare, Swine and Toad. In Northern Barrens, find Gazelle and Prairie Dog; in Un'Goro Crater, find Parrot.\n4. Find Ram in Wetlands, and Sheep and Skunk in Howling Fjord.\n5. Visit Shattrath for Ewe and Northrend Dalaran for Squirrel.\n6. In Borean Tundra, find Borean Frog around the Geyser Fields, Steam Frog around Taunka'le Village's pools, and Shore Crab on the coast. Check the remaining species in your achievement checklist.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1206#comments",
        },
        [1243] = {
            name = "Fish Don't Leave Footprints",
            acquisition = "1. Fish from wreckage pools, such as Steam Pump Flotsam in Zangarmarsh, and open the trunks or supply crates you catch.\n2. Keep opening these containers until you obtain a Weather-Beaten Journal. Pool positions and the journal drop are random.\n3. Use the journal to learn Find Fish, then enable fish-school tracking on the minimap. Merely owning the journal does not complete the achievement.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1243#comments",
        },
        [1248] = {
            name = "Plethora of Pets",
            acquisition = "Collect 25 unique pets.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1248",
        },
        [1250] = {
            name = "Shop Smart, Shop Pet...Smart",
            acquisition = "Collect 50 unique pets.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1250",
        },
        [1257] = {
            name = "The Scavenger",
            acquisition = "1. Fish a Steam Pump Flotsam pool in Zangarmarsh and a Schooner Wreckage pool along the Wetlands coast.\n2. Find Floating Wreckage along Tanaris and Bloodsail Wreckage along the Stranglethorn coasts.\n3. Fish Waterlogged Wreckage along Desolace or Feralas. Cast inside each required pool and loot a catch for that criterion.\n4. Pools move and share spawn locations. Clear nearby fishing pools and return along the coast if the wreckage type you need is absent.",
            sourceType = "Achievement",
            source = "Achievement criteria",
            sourceURL = "https://www.wowhead.com/achievement=1257#comments",
        },
        [1516] = {
            name = "Accomplished Angler",
            acquisition = "Complete the fishing achievements listed below.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1516",
        },
        [1556] = {
            name = "25 Fish",
            acquisition = "Fish up 25 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1556",
        },
        [1557] = {
            name = "50 Fish",
            acquisition = "Fish up 50 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1557",
        },
        [1558] = {
            name = "100 Fish",
            acquisition = "Fish up 100 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1558",
        },
        [1559] = {
            name = "250 Fish",
            acquisition = "Fish up 250 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1559",
        },
        [1560] = {
            name = "500 Fish",
            acquisition = "Fish up 500 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1560",
        },
        [1561] = {
            name = "1000 Fish",
            acquisition = "Fish up 1000 items.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1561",
        },
        [1563] = {
            name = "Hail to the Chef",
            acquisition = "Complete the cooking achievements listed below.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1563",
        },
        [1576] = {
            name = "Of Blood and Anguish",
            acquisition = "Complete the Ring of Blood quests in Nagrand and the Ampitheater of Anguish quests in Zul'Drak.",
            source = "General questing milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1576",
        },
        [1795] = {
            name = "Lunch Lady",
            acquisition = "Learn 25 cooking recipes.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1795",
        },
        [1796] = {
            name = "Short Order Cook",
            acquisition = "Learn 50 cooking recipes.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1796",
        },
        [1797] = {
            name = "Chef de Partie",
            acquisition = "Learn 75 cooking recipes.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1797",
        },
        [1798] = {
            name = "Sous Chef",
            acquisition = "Learn 100 cooking recipes.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1798",
        },
        [1799] = {
            name = "Chef de Cuisine",
            acquisition = "Learn 160 cooking recipes.",
            source = "General professions milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1799",
        },
        [1832] = {
            name = "Tastes Like Chicken",
            acquisition = "Sample 50 different kinds of Azeroth's delectable dishes.",
            source = "General exploration milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1832",
        },
        [1833] = {
            name = "It's Happy Hour Somewhere",
            acquisition = "Drink 25 different types of beverages.",
            source = "General exploration milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=1833",
        },
        [1998] = {
            name = "Cooking Award",
            acquisition = "1. Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.\n2. Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.\n3. Repeat on later daily resets until you have earned 1 awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=1998#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [1999] = {
            name = "10 Cooking Awards",
            acquisition = "1. Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.\n2. Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.\n3. Repeat on later daily resets until you have earned 10 awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=1999#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [2000] = {
            name = "25 Cooking Awards",
            acquisition = "1. Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.\n2. Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.\n3. Repeat on later daily resets until you have earned 25 awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=2000#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [2001] = {
            name = "50 Cooking Awards",
            acquisition = "1. Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.\n2. Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.\n3. Repeat on later daily resets until you have earned 50 awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=2001#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [2002] = {
            name = "100 Cooking Awards",
            acquisition = "1. Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.\n2. Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.\n3. Repeat on later daily resets until you have earned 100 awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
            sourceType = "Achievement",
            source = "Katherine Lee / Awilo Lon'gomba",
            sourceURL = "https://www.wowhead.com/achievement=2002#comments",
            waypoints = { "/way #125 40.3 66.1 Katherine Lee - Alliance Northrend Cooking and daily quests", "/way #125 70.0 38.9 Awilo Lon'gomba - Horde Northrend Cooking and daily quests" },
        },
        [2090] = {
            name = "Challenger",
            acquisition = "Earn the Challenger title in an arena season.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2090",
        },
        [2091] = {
            name = "Gladiator",
            acquisition = "Earn the Gladiator title in an arena season.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2091",
        },
        [2092] = {
            name = "Duelist",
            acquisition = "Earn the Duelist title in an arena season.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2092",
        },
        [2093] = {
            name = "Rival",
            acquisition = "Earn the Rival title in an arena season.",
            source = "General pvp milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2093",
        },
        [2141] = {
            name = "Stable Keeper",
            acquisition = "Obtain 10 mounts (usable by a single character).",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2141",
        },
        [2142] = {
            name = "Filling Up The Barn",
            acquisition = "Obtain 25 mounts (usable by a single character).",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2142",
        },
        [2143] = {
            name = "Leading the Cavalry",
            acquisition = "Obtain 50 mounts (usable by a single character).",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2143",
        },
        [2516] = {
            name = "Lil' Game Hunter",
            acquisition = "Collect 75 unique pets.",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2516",
        },
        [2536] = {
            name = "Mountain o' Mounts",
            acquisition = "Obtain 100 mounts (usable by a single character).",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2536",
        },
        [2537] = {
            name = "Mountain o' Mounts",
            acquisition = "Obtain 100 mounts (usable by a single character).",
            source = "General collections milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2537",
        },
        [2556] = {
            name = "Pest Control",
            acquisition = "Slay the following pests.",
            source = "General exploration milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=2556",
        },
        [4476] = {
            name = "Looking For More",
            acquisition = "Use the Dungeon Finder tool to finish random heroic dungeons until you have grouped with 10 random players total.",
            source = "General dungeons milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=4476",
        },
        [4477] = {
            name = "Looking For Many",
            acquisition = "Use the Dungeon Finder tool to finish random heroic dungeons until you have grouped with 50 random players total.",
            source = "General dungeons milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=4477",
        },
        [4478] = {
            name = "Looking For Multitudes",
            acquisition = "Use the Dungeon Finder tool to finish random heroic dungeons until you have grouped with 100 random players total.",
            source = "General dungeons milestones",
            sourceType = "Achievement",
            sourceURL = "https://www.wowhead.com/achievement=4478",
        },
        [4496] = {
            name = "It's Over Nine Thousand!",
            acquisition = "Earn more than 9,000 achievement points.",
            source = "Achievement points",
            sourceType = "Achievement",
            tips = "This is an account progression milestone; prioritize high-density expansion and dungeon metas.",
        },
    },
    categories = {
        [6] = "Other",
        [7] = "Other",
        [8] = "Other",
        [9] = "Other",
        [15] = "Collections",
        [31] = "Questing",
        [32] = "Questing",
        [46] = "Exploration",
        [153] = "Professions",
        [227] = "PvP",
        [229] = "PvP",
        [230] = "PvP",
        [231] = "PvP",
        [238] = "PvP",
        [239] = "PvP",
        [245] = "PvP",
        [246] = "PvP",
        [247] = "PvP",
        [388] = "PvP",
        [397] = "PvP",
        [398] = "PvP",
        [399] = "PvP",
        [400] = "PvP",
        [401] = "PvP",
        [402] = "PvP",
        [403] = "PvP",
        [405] = "PvP",
        [408] = "PvP",
        [503] = "Questing",
        [504] = "Questing",
        [505] = "Questing",
        [506] = "Questing",
        [507] = "Questing",
        [508] = "Questing",
        [509] = "PvP",
        [512] = "PvP",
        [513] = "PvP",
        [515] = "PvP",
        [516] = "PvP",
        [518] = "Reputation",
        [519] = "Reputation",
        [520] = "Reputation",
        [521] = "Reputation",
        [522] = "Reputation",
        [523] = "Reputation",
        [524] = "Reputation",
        [545] = "Other",
        [603] = "PvP",
        [604] = "PvP",
        [614] = "PvP",
        [619] = "PvP",
        [621] = "Collections",
        [699] = "PvP",
        [700] = "PvP",
        [701] = "PvP",
        [727] = "Collections",
        [762] = "Reputation",
        [869] = "PvP",
        [870] = "PvP",
        [875] = "PvP",
        [876] = "PvP",
        [878] = "Professions",
        [889] = "Other",
        [890] = "Other",
        [908] = "PvP",
        [909] = "PvP",
        [941] = "Questing",
        [942] = "Reputation",
        [943] = "Reputation",
        [945] = "Reputation",
        [948] = "Reputation",
        [953] = "Reputation",
        [964] = "Exploration",
        [973] = "Questing",
        [974] = "Questing",
        [975] = "Questing",
        [976] = "Questing",
        [977] = "Questing",
        [978] = "Questing",
        [1005] = "PvP",
        [1006] = "PvP",
        [1014] = "Reputation",
        [1015] = "Reputation",
        [1017] = "Collections",
        [1020] = "Collections",
        [1021] = "Collections",
        [1157] = "PvP",
        [1159] = "PvP",
        [1160] = "PvP",
        [1162] = "PvP",
        [1175] = "PvP",
        [1176] = "Other",
        [1177] = "Other",
        [1178] = "Other",
        [1180] = "Other",
        [1181] = "Other",
        [1182] = "Questing",
        [1206] = "Exploration",
        [1243] = "Professions",
        [1248] = "Collections",
        [1250] = "Collections",
        [1257] = "Professions",
        [1516] = "Professions",
        [1556] = "Professions",
        [1557] = "Professions",
        [1558] = "Professions",
        [1559] = "Professions",
        [1560] = "Professions",
        [1561] = "Professions",
        [1563] = "Professions",
        [1576] = "Questing",
        [1795] = "Professions",
        [1796] = "Professions",
        [1797] = "Professions",
        [1798] = "Professions",
        [1799] = "Professions",
        [1832] = "Exploration",
        [1833] = "Exploration",
        [1998] = "Professions",
        [1999] = "Professions",
        [2000] = "Professions",
        [2001] = "Professions",
        [2002] = "Professions",
        [2090] = "PvP",
        [2091] = "PvP",
        [2092] = "PvP",
        [2093] = "PvP",
        [2141] = "Collections",
        [2142] = "Collections",
        [2143] = "Collections",
        [2516] = "Collections",
        [2536] = "Collections",
        [2537] = "Collections",
        [2556] = "Exploration",
        [4476] = "Dungeons",
        [4477] = "Dungeons",
        [4478] = "Dungeons",
        [4496] = "Other",
    },
})
