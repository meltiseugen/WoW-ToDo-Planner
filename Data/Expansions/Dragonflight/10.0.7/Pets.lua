local _, TDP = ...

local shared = {}
shared["Zskera Vault rooms and puzzles"] = {
    acquisition = "Open Zskera Vault doors and complete the room interaction, treasure, fishing, or gift-token puzzle associated with this pet.",
    source = "Zskera Vault rooms and puzzles",
    sourceType = "Zskera Vault",
    waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" },
}

shared["Forbidden Reach elemental boss pet"] = {
    acquisition = "Reduce the active elemental boss pet to Rare quality through the nearby battles, then defeat its Rare version to collect the companion.",
    source = "Forbidden Reach elemental boss pet",
    sourceType = "Pet battle reward",
    waypoints = { "/way #2151 35.8 59.6 Morqut Village / Forbidden Reach" },
}

TDP.CatalogRegistry:RegisterCollection("10.0.7", "pets", {
    entries = {
        { name = "Ashenwing", npcId = 189118, speciesId = 3293 },
        { name = "Luvvy", npcId = 189106, speciesId = 3285 },
        { name = "Scruffles", npcId = 189115, speciesId = 3291 },
        { name = "Wakyn", npcId = 188821, speciesId = 3261 },
        { name = "Emmah", npcId = 189694, speciesId = 3331 },
        { name = "Kobaldt", npcId = 191435, speciesId = 3338 },
        { name = "Berylmane", npcId = 191287, speciesId = 3333 },
        { name = "Brightfeather", npcId = 189158, speciesId = 3323 },
        { name = "Patos", npcId = 189696, speciesId = 3332 },
        { name = "Gilded Mechafrog", npcId = 202484, speciesId = 3476 },
        { name = "Buckie", npcId = 189661, speciesId = 3330 },
        { name = "Driftling", npcId = 200259, speciesId = 3427 },
        { name = "Shaggy", npcId = 188709, speciesId = 3259 },
        { name = "Bunbo", npcId = 189113, speciesId = 3290 },
        { name = "Flow", npcId = 200772, speciesId = 3449 },
        { name = "Tremblor", npcId = 200770, speciesId = 3447 },
        { name = "Vortex", npcId = 200769, speciesId = 3446 },
        { name = "Wildfire", npcId = 200771, speciesId = 3448 },
    },
    details = {
        Ashenwing = {
            acquisition = "Defeat the named Forbidden Reach rare for a chance at this battle pet.",
            source = "Bonesifter Marwak / Forbidden Reach",
            sourceType = "Rare drop",
            waypoints = { "/way #2151 43.1 60.6 Bonesifter Marwak" },
        },
        Berylmane = shared["Zskera Vault rooms and puzzles"],
        Brightfeather = shared["Zskera Vault rooms and puzzles"],
        Buckie = { acquisition = "Buy from Turik for 25,000 Elemental Overflow.", source = "Turik / Forbidden Reach", sourceType = "Vendor", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } },
        Bunbo = { acquisition = "Complete Primordial Answers on the Forbidden Reach.", source = "Primordial Answers", sourceType = "Quest", waypoints = { "/way #2151 35.8 59.6 Morqut Village" } },
        Driftling = {
            acquisition = "Reach Exalted with the Winterpelt Furbolg and claim the pet reward.",
            source = "Winterpelt Furbolg",
            sourceType = "Reputation",
            waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" },
        },
        Emmah = shared["Zskera Vault rooms and puzzles"],
        Flow = shared["Forbidden Reach elemental boss pet"],
        ["Gilded Mechafrog"] = shared["Zskera Vault rooms and puzzles"],
        Kobaldt = shared["Zskera Vault rooms and puzzles"],
        Luvvy = {
            acquisition = "Defeat the named Forbidden Reach rare for a chance at this battle pet.",
            source = "Luttrok / Forbidden Reach",
            sourceType = "Rare drop",
            waypoints = { "/way #2151 13.2 48.4 Luttrok spawn area" },
        },
        Patos = shared["Zskera Vault rooms and puzzles"],
        Scruffles = {
            acquisition = "Defeat the named Forbidden Reach rare for a chance at this battle pet.",
            source = "Vraken the Hunter / Forbidden Reach",
            sourceType = "Rare drop",
            waypoints = { "/way #2151 58.6 47.9 Vraken the Hunter" },
        },
        Shaggy = {
            acquisition = "Buy Sack of Oddities for 2,000 Elemental Overflow until the pet drops.",
            source = "Sack of Oddities / Cataloger Daela",
            sourceType = "Vendor bag",
            waypoints = { "/way #2151 35.8 59.6 Morqut Village" },
        },
        Tremblor = shared["Forbidden Reach elemental boss pet"],
        Vortex = shared["Forbidden Reach elemental boss pet"],
        Wakyn = {
            acquisition = "Defeat the named Forbidden Reach rare for a chance at this battle pet.",
            source = "Warden Entrix / Forbidden Reach",
            sourceType = "Rare drop",
            waypoints = { "/way #2151 67.0 7.2 War Creche entrance" },
        },
        Wildfire = shared["Forbidden Reach elemental boss pet"],
    },
})
