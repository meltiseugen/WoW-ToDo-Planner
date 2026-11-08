local _, TDP = ...

-- Later achievements tied to this Burning Crusade content patch.
-- Retroactive records moved from Wrath are owned only by the 2.0 bucket.
TDP.CatalogRegistry:RegisterCollection("2.4", "achievements", {
    entries = {
        ids = {
            9824, -- Raiding with Leashes III: Drinkin' From the Sunwell
            11709, -- Tough Threads
            11749, -- Suns Out, Thori'dals Out
        },
        rewardHighlights = {},
    },
    details = {
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
        [9824] = "Collections",
        [11709] = "Collections",
        [11749] = "Collections",
    },
})
