local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("7.3.5", {
    cosmeticDetailGroups = {
        alliedRaceTabards = {
            acquisition = "Create the corresponding allied-race character after unlocking the race; its tabard is awarded during the starting experience.",
            source = "Highmountain Tauren, Lightforged Draenei, Nightborne, and Void Elf starting experiences",
            sourceType = "Allied race",
            tips = "The four tabards span both factions, so more than one character is required.",
            waypoints = { "/way #84 52.7 13.1 Stormwind Embassy", "/way #85 37.8 81.0 Orgrimmar Embassy" },
        },
        highmountainHeritage = {
            acquisition = "Complete the Highmountain Tauren heritage quest on an eligible character to unlock all eight appearances.",
            source = "Highmountain Tauren heritage quest",
            sourceType = "Heritage armor",
            tips = "Complete the requirements without race-changing the character, then check the Orgrimmar Embassy.",
            waypoints = { "/way #85 37.8 81.0 Orgrimmar Embassy" },
        },
        lightforgedHeritage = {
            acquisition = "Complete the Lightforged Draenei heritage quest on an eligible character to unlock all eight appearances.",
            source = "Lightforged Draenei heritage quest",
            sourceType = "Heritage armor",
            tips = "Complete the requirements without race-changing the character, then check the Stormwind Embassy.",
            waypoints = { "/way #84 52.7 13.1 Stormwind Embassy" },
        },
        masterTrainerTabard = {
            acquisition = "Complete the Family Brawler meta-achievement to receive the Master Trainer's Tabard.",
            source = "Family Brawler",
            sourceType = "Pet-battle achievement",
            tips = "Build one reliable all-family team at a time and save successful lineups for repeated Legion master-tamer fights.",
        },
        nightborneHeritage = {
            acquisition = "Complete the Nightborne heritage quest on an eligible character to unlock all eight appearances.",
            source = "Nightborne heritage quest",
            sourceType = "Heritage armor",
            tips = "Complete the requirements without race-changing the character, then check the Orgrimmar Embassy.",
            waypoints = { "/way #85 37.8 81.0 Orgrimmar Embassy" },
        },
        pvpTabards = {
            acquisition = "Earn the matching Dominant or Demonic Gladiator tabard during its season; retained for historical tracking.",
            source = "Legion rated PvP Seasons 6 and 7",
            sourceType = "PvP season reward",
            tips = "These elite seasonal rewards may no longer be obtainable.",
        },
        voidElfHeritage = {
            acquisition = "Complete the Void Elf heritage quest on an eligible character to unlock all nine appearances.",
            source = "Void Elf heritage quest",
            sourceType = "Heritage armor",
            tips = "Complete the requirements without race-changing the character, then check the Stormwind Embassy.",
            waypoints = { "/way #84 52.7 13.1 Stormwind Embassy", "/way #971 28.5 27.0 Telogrus Rift" },
        },
    },
    label = "Patch 7.3.5",
    sourceNotes = {
        "This requested bucket includes Antorus collection records introduced in 7.3.2 and the four allied races made available during the 7.3.5 period.",
        "The catalogue retains historical limited rewards but excludes store, calendar-event, test, hidden-statistic, NPC-only, and ordinary equipment records.",
    },
    sourceUrls = {
        legionCollections = "https://worldofwarcraft.blizzard.com/en-us/news/23429409/legion-mounts-pets-and-more",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/21365423/patch-7-3-5-now-live",
        overview = "https://www.wowhead.com/guide/patch-7-3-5-content-hub-5751",
    },
    wowheadPatchId = 70305,
})
