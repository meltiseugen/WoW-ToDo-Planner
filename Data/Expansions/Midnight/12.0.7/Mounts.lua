local _, TDP = ...

local shared = {}
shared["Bilgewater X-TREME Firework Rocket waypoints"] = {
    "/way #2393 48.77 78.02 Trading Post / Silvermoon City",
    "/way #2339 44.4 55.8 Trading Post / Dornogal",
    "/way #84 51.0 71.8 T&W Trading Post / Stormwind",
    "/way #85 48.4 76.0 Zen'shiri Trading Post / Orgrimmar",
}

shared["Future Trading Post rotation"] = {
    acquisition = "Datamined placeholder recolor; check future Trading Post inventory.",
    category = "Trading Post",
    source = "Future Trading Post rotation",
    sourceType = "Trading Post / placeholder",
    waypoints = shared["Bilgewater X-TREME Firework Rocket waypoints"],
}

shared["Netherforged Nullframe waypoints"] = {
    "/way #2393 47.61 51.08 Maella / Invasion Point introductions",
    "/way #2405 51.44 71.27 Portal to Naigtal and Val",
    "/way #2600 47.8 81.6 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.0 Kifaan / Val Umbral Base Camp",
}

TDP.CatalogRegistry:RegisterCollection("12.0.7", "mounts", {
    entries = {
        { itemId = 246731, name = "Dusk Grimlynx", spellId = 1243582 },
        { name = "Amani Hex Bear", spellId = 1261369 },
        { itemId = 267078, name = "Stoneforged Sentinel", spellId = 1279352 },
        { itemId = 269240, name = "Luminous Sporeglider", spellId = 1284973 },
        { itemId = 272920, name = "Spring Panda", spellId = 1291315 },
        { itemId = 273317, name = "Blackwater X-TREME Firework Rocket", spellId = 1292102 },
        { itemId = 273650, name = "Green Rocket Mount [PH]", spellId = 1292342 },
        { itemId = 273651, name = "Bilgewater X-TREME Firework Rocket", spellId = 1292344 },
        { itemId = 273652, name = "Pink Rocket Mount [PH]", spellId = 1292345 },
        { itemId = 273655, name = "Sunflare Driftmoth", spellId = 1292356 },
        { itemId = 274260, name = "Rabbit'ath", spellId = 1293456 },
        { itemId = 258884, name = "Spawn of Vyranoth", spellId = 1264184 },
        { itemId = 274649, name = "Voidmancer's Starcarver", spellId = 1294648 },
        { itemId = 274650, name = "Netherforged Nullframe", spellId = 1294663 },
        { itemId = 274681, name = "[PH] Horse with Hat", spellId = 1294677 },
        { itemId = 275664, name = "Tortured Gorger", spellId = 1297427 },
        { itemId = 276245, name = "Shadow Spirehawk", spellId = 1299156 },
    },
    details = {
        ["Amani Hex Bear"] = {
            acquisition = "The 12.0.7 mount guide still lists this as unknown, so no coordinate is attached.",
            category = "Other",
            source = "Wowhead 12.0.7 mount filter",
            sourceType = "Unknown",
        },
        ["Bilgewater X-TREME Firework Rocket"] = {
            acquisition = "Awarded for completing the July 2026 Traveler's Log. Watch future Trading Post returns if it was missed.",
            category = "Trading Post",
            source = "July 2026 Traveler's Log",
            sourceType = "Traveler's Log",
            waypoints = shared["Bilgewater X-TREME Firework Rocket waypoints"],
        },
        ["Blackwater X-TREME Firework Rocket"] = {
            acquisition = "Trading Post mount priced at 700 Trader's Tender; check the current monthly inventory and Outlet returns.",
            category = "Trading Post",
            source = "Trading Post",
            sourceType = "Trading Post",
            waypoints = shared["Bilgewater X-TREME Firework Rocket waypoints"],
        },
        ["Dusk Grimlynx"] = {
            acquisition = "Accept Hagar's Invitation in Silvermoon and progress the Legacy of the Amani storyline; the mount is awarded early in the chain.",
            category = "Quest Rewards",
            source = "Legacy of the Amani / Hagar's Invitation",
            sourceType = "Questline",
            tips = "Continue the same chapter through Dead End if you also need the Akiki pet.",
            waypoints = { "/way #2393 45.45 70.26 Hagar's Invitation / Legacy of the Amani" },
        },
        ["Green Rocket Mount [PH]"] = shared["Future Trading Post rotation"],
        ["Luminous Sporeglider"] = {
            acquisition = "Defeat Rotmire in Sporefall once per weekly reset to receive one Delicious Sporesnack, then combine four to learn the mount.",
            category = "Dungeon and Raids",
            source = "Rotmire / Sporefall",
            sourceType = "Raid drop / weekly combine",
            tips = "The snack is once per Warband each week on any difficulty, and there is no catch-up; plan on four weekly kills.",
            waypoints = { "/way #2413 73.7 66.5 Sporefall Raid Entrance" },
        },
        ["Netherforged Nullframe"] = {
            acquisition = "Complete A Trip Through the Stars, then buy from Kifaan for 15 Voidlight Marl.",
            category = "Vendor",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "The meta uses Naigtal criteria and may take more than one Naigtal rotation because its stories and world quests rotate.",
            waypoints = shared["Netherforged Nullframe waypoints"],
        },
        ["Pink Rocket Mount [PH]"] = shared["Future Trading Post rotation"],
        ["Rabbit'ath"] = {
            acquisition = "Included in the World of Warcraft BlizzCon 2026 Bundle and BlizzCon Ultimate Collection.",
            category = "Promotion",
            source = "Battle.net Shop",
            sourceType = "BlizzCon 2026 Bundle",
        },
        ["Shadow Spirehawk"] = { acquisition = "Purchase through the Battle.net Shop; there is no in-world map location.", category = "In-Game Shop", source = "In-Game Shop", sourceType = "Battle.net Shop" },
        ["Spawn of Vyranoth"] = {
            acquisition = "Originally required Mastery of Timeways in four different weeks of Turbulent Timeways V; the 2026 event ended August 11.",
            category = "Achievements",
            source = "Master of the Turbulent Timeways V",
            sourceType = "Achievement / future vendor",
            tips = "Missed Turbulent Timeways mounts are expected to cost 5000 Timewarped Badges when the next event begins. Xydan appears only during Dragonflight Timewalking.",
            waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" },
        },
        ["Spring Panda"] = {
            acquisition = "China-region promotional reward; no general-region in-world source is available.",
            category = "Promotion",
            source = "China-exclusive promotion",
            sourceType = "Regional promotion",
        },
        ["Stoneforged Sentinel"] = { acquisition = "Purchase through the shop; no in-world map source.", category = "In-Game Shop", source = "In-Game Shop", sourceType = "Battle.net Shop" },
        ["Sun Festival's Painted Roc"] = {
            acquisition = "During Midsummer Fire Festival, loot the first eligible Satchel of Chilled Goods each day across the Warband for an increasing chance at the mount.",
            category = "World Events",
            source = "Frost Lord Ahune / Midsummer Fire Festival",
            sourceType = "Holiday boss",
            waypoints = { "/way #102 49.0 36.0 Coilfang Reservoir / Slave Pens entrance" },
        },
        ["Sunflare Driftmoth"] = {
            acquisition = "Shop or subscription-bundle mount with no in-world map source.",
            category = "In-Game Shop",
            source = "In-Game Shop",
            sourceType = "Battle.net Shop / subscription bundle",
        },
        ["Tortured Gorger"] = {
            acquisition = "Complete Heroic Showdowns, then buy from Kifaan for 15 Voidlight Marl.",
            category = "Vendor",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "The meta needs both Val and Naigtal Heroic weeks and therefore takes at least two weekly zone rotations.",
            waypoints = shared["Netherforged Nullframe waypoints"],
        },
        ["Voidmancer's Starcarver"] = {
            acquisition = "Complete A Trip Around the Stars, then buy from Kifaan for 15 Voidlight Marl.",
            category = "Vendor",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "The meta combines the Val story, climate event, six rares, eight world quests, and shared introduction/preparation achievements.",
            waypoints = shared["Netherforged Nullframe waypoints"],
        },
        ["[PH] Horse with Hat"] = {
            acquisition = "Datamined Trading Post placeholder that has not been made available; there is no active collection method.",
            category = "Trading Post",
            source = "Trading Post data",
            sourceType = "Unavailable placeholder",
        },
    },
})
