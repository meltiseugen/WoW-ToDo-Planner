local _, TDP = ...

local shared = {}
shared["Fishstick Keith waypoints"] = {
    "/way #2393 47.61 51.08 Maella / Invasion Point introductions",
    "/way #2405 51.44 71.27 Portal to Naigtal and Val",
    "/way #2600 47.8 81.6 Kifaan / Naigtal Umbral Base Camp",
    "/way #2599 59.0 19.0 Kifaan / Val Umbral Base Camp",
}

TDP.CatalogRegistry:RegisterCollection("12.0.7", "pets", {
    entries = {
        { name = "Murk'atath", npcId = 264863, speciesId = 5064 },
        { name = "Emberlyn", npcId = 262985, speciesId = 5041 },
        { name = "Frosticus Maximus", npcId = 266577, speciesId = 5073 },
        { name = "Akiki", npcId = 260149, speciesId = 5007 },
        { name = "Shadowflame Remnant", npcId = 256080, speciesId = 4949 },
        { name = "Silento", npcId = 266580, speciesId = 5074 },
        { name = "Sunflicker Driftmoth", npcId = 263995, speciesId = 5052 },
        { name = "Fishstick Keith", npcId = 251820, speciesId = 4898 },
        { name = "Sleepy Mandrake", npcId = 256565, speciesId = 4965 },
    },
    details = {
        Akiki = {
            acquisition = "Complete the Legacy of the Amani chapter through Dead End. Begin Hagar's Invitation in Silvermoon if the chapter has not been started.",
            source = "Dead End / Legacy of the Amani",
            sourceType = "Quest",
            tips = "This pet is not sold by Kifaan. Continue the full campaign chain; the Dusk Grimlynx mount is awarded earlier in the same storyline.",
            waypoints = { "/way #2393 45.45 70.26 Hagar's Invitation / Legacy of the Amani" },
        },
        Emberlyn = {
            acquisition = "Complete It Takes Two, Hungry Hungry Hatchlings, Eggstra Protection Never Hurts, Perfect Timing, and Like Dragonhawks to a Flame, starting with Loa Speaker Brek in Zul'Aman.",
            source = "Like Dragonhawks to a Flame",
            sourceType = "Quest",
            tips = "Gather feathers behind the temple cliffs, stand in the center while clicking the seven glowing eggs, and kill Cinderscale Patriarch for the final quest.",
            waypoints = { "/way #2437 55.00 18.39 Loa Speaker Brek / Egg Hatching questline" },
        },
        ["Fishstick Keith"] = {
            acquisition = "Complete Climate Strange: Val, then buy from Kifaan for 50 Sin'dorei Swarmers.",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "Finish Storm Mitigation five times and kill eight Rampaging Ice Elementals. Heroic storm completions also advance the normal achievement.",
            waypoints = shared["Fishstick Keith waypoints"],
        },
        ["Frosticus Maximus"] = {
            acquisition = "Complete Ultradon Carnage, then buy from Kifaan for 15 Voidlight Marl.",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "During Until It Is Done, defeat 100 enemies while in Ultradon Slayer mode. Progress is cumulative; a raid group can suppress world-quest completion while you finish all 100.",
            waypoints = shared["Fishstick Keith waypoints"],
        },
        ["Murk'atath"] = { acquisition = "Bundle/promotion pet with no in-world farm location.", source = "BlizzCon 2026 Ultimate Collection", sourceType = "Promotion" },
        ["Shadowflame Remnant"] = {
            acquisition = "Buy from Xydan for 2200 Timewarped Badges during Dragonflight Timewalking.",
            source = "Xydan",
            sourceType = "Timewalking",
            waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" },
        },
        Silento = {
            acquisition = "Complete Showdown Success in both Val and Naigtal, then buy from Kifaan for 15 Voidlight Marl.",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "Each zone requires eight different world quests. Check Kifaan during either active-zone week after both achievements are complete.",
            waypoints = shared["Fishstick Keith waypoints"],
        },
        ["Sleepy Mandrake"] = {
            acquisition = "Find Sleepy Mandrake in Sleeper's Grotto, feed it Highland, Dusty, Marshy, Partially-Digested, and Airy Redcaps, then interact with the nearby pot.",
            source = "Sleeper's Grotto",
            sourceType = "Naigtal secret",
            tips = "The five feed flags are Warband-wide, so they may be split across characters. Normal mode is easier; Airy requires the traversal abilities from Prepared for a Showdown. The pins include Vilaldoun Crypt and the hidden cave entrances.",
            waypoints = {
                "/way #2600 67.51 53.98 Sleeper's Grotto entrance",
                "/way #2600 68.25 51.61 Sleepy Mandrake",
                "/way #2600 33.40 59.70 Path to Highland",
                "/way #2600 28.90 61.76 Highland",
                "/way #2600 27.91 49.96 Vilaldoun Crypt entrance",
                "/way #2646 22.72 61.30 Dusty",
                "/way #2600 75.64 38.14 Marshwalker Refuge cave entrance",
                "/way #2600 71.42 37.05 Marshy",
                "/way #2600 78.50 40.00 Swalewing Matriarch / Partially-Digested",
                "/way #2600 89.31 29.49 Bouncy Mushroom",
                "/way #2600 95.09 26.67 Airy",
            },
        },
        ["Sunflicker Driftmoth"] = { acquisition = "Shop or subscription-bundle pet with no in-world map source.", source = "Battle.net Shop / subscription bundle", sourceType = "In-Game Shop" },
    },
})
