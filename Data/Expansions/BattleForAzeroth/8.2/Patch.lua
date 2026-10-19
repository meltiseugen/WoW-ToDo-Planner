local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.2", {
    cosmeticDetailGroups = {
        gnomeHeritage = {
            acquisition = "Complete the Gnome heritage questline beginning with Shifting Gears; the finale unlocks all nine G.E.A.R. Commander appearances.",
            requirements = "A level-eligible Gnome; the original Exalted Gnomeregan requirement was removed in patch 10.1.",
            source = "Gnome heritage questline ending with G.E.A.R. Up",
            sourceType = "Heritage Armor",
            tips = "Start with Ace Pilot Stormcog at the Stormwind Embassy. The route continues through New Tinkertown, Borean Tundra, and the Storm Peaks.",
            waypoints = { "/way #84 54.6 18.4 Ace Pilot Stormcog / Shifting Gears" },
        },
        taurenHeritage = {
            acquisition = "Complete the Tauren heritage questline beginning with When Spirits Whisper; the finale unlocks all nine Ancestral Chieftain appearances.",
            requirements = "A level-eligible Tauren; the original Exalted Thunder Bluff requirement was removed in patch 10.1.",
            source = "Tauren heritage questline ending with Thank Your Guide",
            sourceType = "Heritage Armor",
            tips = "Begin at the Orgrimmar Embassy, then follow Baine and the Spiritwalkers through Thunder Bluff and Stonetalon Mountains.",
            waypoints = { "/way #85 39.1 79.0 Spiritwalker Isahi / When Spirits Whisper" },
        },
    },
    label = "Patch 8.2: Rise of Azshara",
    sourceNotes = {
        "This audited backfill compares the final 8.1.5 and 8.2.0 client snapshots, then checks collectible records against contemporary Rise of Azshara guides and current collection data.",
        "The audit retains permanent and historically trackable in-game mounts, pets, toys, Cosmetics, and visible achievements. Shop, promotion, anniversary, holiday, hidden-statistic, NPC-only pet, and unused records are excluded.",
        "Cosmetics tracks the eighteen Gnome and Tauren heritage wardrobe entries. Ordinary Benthic, raid, dungeon, and PvP stat gear is not duplicated.",
    },
    sourceUrls = {
        collections = "https://www.wowhead.com/news/new-mounts-pets-and-toys-in-rise-of-azshara-292173",
        nazjatarPets = "https://www.wowhead.com/guide/nazjatar-battle-pets",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23014436/rise-of-azshara-content-update-notes",
        overview = "https://www.wowhead.com/guide/patch-8-2-rise-of-azshara-bfa-wow-overview",
        stratholmePets = "https://www.wowhead.com/guide/stratholme-pet-battle-challenge-dungeon",
        transmog = "https://www.wowhead.com/news/transmog-updates-and-nazjatar-armor-sets-in-rise-of-azshara-292192",
    },
    wowheadPatchId = 80200,
})
