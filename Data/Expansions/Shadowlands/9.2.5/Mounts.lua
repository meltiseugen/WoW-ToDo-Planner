local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("9.2.5", "mounts", {
    entries = {
        { itemId = 192557, name = "Restoration Deathwalker", spellId = 334482 },
        { itemId = 187644, name = "Vicious Warstalker", spellId = 349824 },
        { itemId = 187642, name = "Vicious Warstalker", spellId = 349823 },
        { itemId = 190170, name = "Jigglesworth Sr.", spellId = 366791 },
        { itemId = 191123, name = "Grimhowl", spellId = 369666 },
        { itemId = 191290, name = "Eternal Gladiator's Soul Eater", spellId = 370346 },
        { itemId = 191566, name = "Elusive Emerald Hawkstrider", spellId = 370620 },
    },
    details = {
        ["Elusive Emerald Hawkstrider"] = {
            acquisition = "Complete the blood elf questline that begins with Lady Liadrin in Oribos; requires level 60 and Exalted with Silvermoon City.",
            category = "Quest Rewards",
            source = "Victory for the Sin'dorei / Blood Knight",
            sourceType = "Racial Questline",
            waypoints = { "/way #1670 42.5 27.2 Lady Liadrin / Oribos" },
        },
        ["Eternal Gladiator's Soul Eater"] = {
            acquisition = "Win 50 3v3 games at Elite rank during Shadowlands Season 4.",
            availability = "The original Season 4 reward is no longer obtainable.",
            category = "PvP",
            source = "Gladiator: Shadowlands Season 4",
            sourceType = "Seasonal Achievement",
        },
        Grimhowl = {
            acquisition = "Complete the Dark Iron dwarf heritage continuation questline in Blackrock Depths.",
            category = "Quest Rewards",
            source = "Good Fiery Boy",
            sourceType = "Racial Questline",
        },
        ["Jigglesworth Sr."] = {
            acquisition = "Complete all three Fated Shadowlands raids on Normal difficulty or higher during Season 4.",
            availability = "The original Season 4 reward is no longer obtainable.",
            category = "Dungeon and Raids",
            source = "Fates of the Shadowlands Raids",
            sourceType = "Seasonal Raid Achievement",
        },
        ["Restoration Deathwalker"] = {
            acquisition = "Reach 2,000 Mythic+ rating during Shadowlands Season 4.",
            availability = "The original Season 4 reward is no longer obtainable.",
            category = "Dungeon and Raids",
            source = "Shadowlands Keystone Master: Season Four",
            sourceType = "Seasonal Achievement",
        },
        ["Vicious Warstalker"] = {
            acquisition = "Fill the rated-PvP seasonal reward bar at 1,000+ rating for the faction-specific Warstalker.",
            availability = "The original Season 4 reward is no longer obtainable.",
            category = "PvP",
            source = "Shadowlands Season 4",
            sourceType = "Seasonal PvP Reward",
        },
    },
})
