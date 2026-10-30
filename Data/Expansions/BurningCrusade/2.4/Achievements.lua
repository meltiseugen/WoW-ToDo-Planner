local _, TDP = ...

-- Group retroactive achievements with the content they guide.
-- The achievement system arrived later; the original release records
-- remain intact so saved favorites and old patch links keep working.
TDP.CatalogRegistry:RegisterCollection("2.4", "achievements", {
    entries = {
        ids = {
            661, -- Magister's Terrace
            682, -- Heroic: Magister's Terrace
            698, -- Sunwell Plateau
            725, -- Thori'dal, the Stars' Fury
            868, -- Explore Isle of Quel'Danas
            884, -- Swift White Hawkstrider
            897, -- You're So Offensive
            905, -- Old Man Barlowned
            1800, -- The Outland Gourmet
            1801, -- Captain Rumsey's Lager
            9824, -- Raiding with Leashes III: Drinkin' From the Sunwell
            11709, -- Tough Threads
            11749, -- Suns Out, Thori'dals Out
        },
        rewardHighlights = {},
    },
    details = {
        [661] = {
            name = "Magister's Terrace",
            acquisition = "Enter the original Burning Crusade version of Magisters' Terrace. Defeat Kael'thas Sunstrider. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Magisters' Terrace",
            sourceURL = "https://www.wowhead.com/achievement=661",
            waypoints = { "/way #122 61.23 30.94 Magisters' Terrace entrance" },
        },
        [682] = {
            name = "Heroic: Magister's Terrace",
            acquisition = "Set dungeon difficulty to Heroic before entering the original Magisters' Terrace. Defeat Kael'thas Sunstrider on Heroic Difficulty. Finish the encounter and check that its criterion has registered before leaving.",
            sourceType = "Achievement",
            source = "Magisters' Terrace",
            sourceURL = "https://www.wowhead.com/achievement=682",
            waypoints = { "/way #122 61.23 30.94 Magisters' Terrace entrance" },
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
        [868] = {
            name = "Explore Isle of Quel'Danas",
            acquisition = "Explore Isle of Quel'Danas, revealing the covered areas of the world map. Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough.",
            sourceType = "Achievement",
            source = "Burning Crusade exploration",
            sourceURL = "https://www.wowhead.com/achievement=868",
        },
        [884] = {
            name = "Swift White Hawkstrider",
            acquisition = "Obtain the Swift White Hawkstrider from Kael'thas Sunstrider in Magisters' Terrace.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=884",
        },
        [897] = {
            name = "You're So Offensive",
            acquisition = "Earn Exalted status with the Shattered Sun Offensive. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=897",
        },
        [905] = {
            name = "Old Man Barlowned",
            acquisition = "Complete each of Old Man Barlo's 5 fishing daily quests listed below. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=905",
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
        [9824] = {
            name = "Raiding with Leashes III: Drinkin' From the Sunwell",
            acquisition = "Collect all of the battle pets listed below from Black Temple, Hyjal Summit, and the Sunwell.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=9824",
        },
        [11709] = {
            name = "Tough Threads",
            acquisition = "Collect 12 Marks of Honor and visit Blaze Magmaburn inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Brutal Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Blaze Magmaburn / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11709",
            waypoints = { "/way #109 33.0 64.2 Blaze Magmaburn - Brutal Gladiator armor ensemble" },
        },
        [11749] = {
            name = "Suns Out, Thori'dals Out",
            acquisition = "Collect any class armor set from Sunwell Plateau. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Sunwell Plateau",
            sourceURL = "https://www.wowhead.com/achievement=11749",
            waypoints = { "/way #122 44.28 45.71 Sunwell Plateau entrance" },
        },
    },
    categories = {
        [661] = "Dungeons",
        [682] = "Dungeons",
        [698] = "Raids",
        [725] = "Collections",
        [868] = "Exploration",
        [884] = "Collections",
        [897] = "Reputation",
        [905] = "Quests",
        [1800] = "Professions",
        [1801] = "Professions",
        [9824] = "Collections",
        [11709] = "Collections",
        [11749] = "Collections",
    },
})
