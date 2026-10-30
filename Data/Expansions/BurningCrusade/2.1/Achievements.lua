local _, TDP = ...

-- Group retroactive achievements with the content they guide.
-- The achievement system arrived later; the original release records
-- remain intact so saved favorites and old patch links keep working.
TDP.CatalogRegistry:RegisterCollection("2.1", "achievements", {
    entries = {
        ids = {
            426, -- Warglaives of Azzinoth
            697, -- The Black Temple
            883, -- Reins of the Raven Lord
            894, -- Flying High Over Skettis
            896, -- A Quest a Day Keeps the Ogres at Bay
            898, -- On Wings of Nether
            958, -- Sworn to the Deathsworn
            1275, -- Bombs Away
            1276, -- Blade's Edge Bomberman
            1638, -- Skyshattered
            11707, -- No Mercy
            11748, -- Black is the New Black
        },
        rewardHighlights = {},
    },
    details = {
        [426] = {
            name = "Warglaives of Azzinoth",
            acquisition = "Wielder of a set of Warglaives of Azzinoth.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=426",
        },
        [697] = {
            name = "The Black Temple",
            acquisition = "Enter the original Burning Crusade version of Black Temple. Defeat Illidan Stormrage in The Black Temple. Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity.",
            sourceType = "Achievement",
            source = "Black Temple",
            sourceURL = "https://www.wowhead.com/achievement=697",
            waypoints = { "/way #104 71 46.5 Black Temple entrance" },
        },
        [883] = {
            name = "Reins of the Raven Lord",
            acquisition = "Obtain the Reins of the Raven Lord from Anzu in Sethekk Halls.",
            sourceType = "Achievement",
            source = "Burning Crusade collections",
            sourceURL = "https://www.wowhead.com/achievement=883",
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
        [898] = {
            name = "On Wings of Nether",
            acquisition = "Earn Exalted status with Netherwing. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=898",
        },
        [958] = {
            name = "Sworn to the Deathsworn",
            acquisition = "Earn Exalted status with the Ashtongue Deathsworn. Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations.",
            sourceType = "Achievement",
            source = "Burning Crusade reputation",
            sourceURL = "https://www.wowhead.com/achievement=958",
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
        [1638] = {
            name = "Skyshattered",
            acquisition = "Defeat Captain Skyshatter in the Dragonmaw race on Netherwing Ledge. Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines.",
            sourceType = "Achievement",
            source = "Burning Crusade quests",
            sourceURL = "https://www.wowhead.com/achievement=1638",
        },
        [11707] = {
            name = "No Mercy",
            acquisition = "Collect 12 Marks of Honor and visit Izzee the 'Clutch' inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the Merciless Gladiator armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required.",
            sourceType = "Achievement",
            source = "Izzee the 'Clutch' / Area 52",
            sourceURL = "https://www.wowhead.com/achievement=11707",
            waypoints = { "/way #109 33.0 64.2 Izzee the 'Clutch' - Merciless Gladiator armor ensemble" },
        },
        [11748] = {
            name = "Black is the New Black",
            acquisition = "Collect any class armor set from Black Temple. Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need.",
            sourceType = "Achievement",
            source = "Black Temple",
            sourceURL = "https://www.wowhead.com/achievement=11748",
            waypoints = { "/way #104 71 46.5 Black Temple entrance" },
        },
    },
    categories = {
        [426] = "Collections",
        [697] = "Raids",
        [883] = "Collections",
        [894] = "Reputation",
        [896] = "Reputation",
        [898] = "Reputation",
        [958] = "Reputation",
        [1275] = "Quests",
        [1276] = "Quests",
        [1638] = "Quests",
        [11707] = "Collections",
        [11748] = "Collections",
    },
})
