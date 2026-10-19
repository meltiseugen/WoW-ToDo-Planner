local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.3.0", {
    cosmeticDetailGroups = {
        argusTabards = {
            acquisition = "Raise the matching Argus faction reputation and purchase its tabard from the quartermaster.",
            source = "Army of the Light and Argussian Reach quartermasters",
            sourceType = "Reputation reward",
            tips = "World quests, emissaries, and account-bound reputation tokens shorten the grind.",
            waypoints = { "/way #831 43.5 25.0 Vindicaar collection hub" },
        },
        lightforgedArsenal = {
            acquisition = "Complete Commander of Argus to unlock the Lightforged weapon arsenal.",
            source = "Commander of Argus",
            sourceType = "Achievement arsenal",
            tips = "Track the Argus rare checklist by subzone and revisit the rotating rares after daily resets.",
            waypoints = { "/way #831 43.5 25.0 Vindicaar collection hub" },
        },
        pvpEnsembles = {
            acquisition = "Purchase the matching Fierce Gladiator armor ensemble with Marks of Honor.",
            source = "Legion Season 5 legacy PvP vendors",
            sourceType = "PvP ensemble",
            tips = "Alliance and Horde variants can share a name while retaining different item IDs.",
        },
        pvpTabards = {
            acquisition = "Earn the Fierce Gladiator tabard during its rated PvP season; retained for historical tracking.",
            source = "Legion rated PvP Season 5",
            sourceType = "PvP season reward",
            tips = "This elite seasonal reward may no longer be obtainable.",
        },
        triumvirateEnsembles = {
            acquisition = "Collect the matching armor-type ensemble associated with Seat of the Triumvirate rewards.",
            source = "Seat of the Triumvirate",
            sourceType = "Dungeon ensemble",
            tips = "Use the dungeon entrance in Eredath and verify the ensemble's armor restriction before farming.",
            waypoints = { "/way #882 22.3 56.4 Seat of the Triumvirate entrance" },
        },
    },
    label = "Patch 7.3: Shadows of Argus",
    sourceNotes = {
        "The Argus catalogue is reconciled against the official Shadows of Argus notes, contemporary collection guides, All The Things source data, and the final Legion client database.",
        "Antorus rewards are placed in 7.3.5 below because the requested patch set has no 7.3.2 bucket and 7.3.5 is the first requested bucket after the raid became available.",
        "Ordinary equipment appearances are excluded. Ensemble, arsenal, tabard, mount, pet, toy, and visible achievement records remain directly trackable.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/20947822/world-of-warcraft-73-patch-notes",
        overview = "https://www.wowhead.com/guide/patch-7-3-shadows-of-argus-content-hub-5304",
        pets = "https://www.wowhead.com/news/battle-pet-updates-in-patch-7-3-40-new-pets-family-fighter-achievement-battle-270387",
        rares = "https://www.wowhead.com/guide/argus-rares-mounts-pets-toys",
    },
    wowheadPatchId = 70300,
})
