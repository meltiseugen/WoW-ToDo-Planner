local _, TDP = ...

local shared = {}
shared["etherealPack waypoints"] = { "/way #2600 48.0 82.0 Naigtal Umbral Base Camp / Kifaan, Fieldsmith Ventem, and Zuronar", "/way #2599 62.0 15.0 Val Umbral Base Camp / Kifaan, Fieldsmith Ventem, and Zuronar" }

shared["kifaan waypoints"] = { "/way #2600 47.4 81.4 Kifaan / Naigtal Umbral Base Camp", "/way #2599 59.0 19.6 Kifaan / Val Umbral Base Camp" }

TDP.CatalogRegistry:RegisterPatch("12.0.7", {
    cosmeticDetailGroups = {
        etherealPack = {
            acquisition = "Loot Naigtal and Val storage treasures for a chance at this appearance, or buy a Bulging Ethereal Pack from Kifaan at the active Umbral Base Camp.",
            source = "Hal'hadar Pocket-Storage, Domanaar Storage Vessel, or Kifaan",
            sourceType = "Treasure / Vendor Pack",
            tips = "Use each appearance token from your bags as it drops, and combine the fixed treasure route with packs bought using invasion currency.",
            waypoints = shared["etherealPack waypoints"],
        },
        iceGuardian = {
            acquisition = "On Heroic World Tier in Val, enter the southeastern cave and interact with the embedded hilt. Carry the Ice Guardian's Testament, defeat two eligible rare or world bosses to gain two Vanquishing stacks, then return to claim the Sleetblade.",
            source = "Ice Guardian's Testament",
            sourceType = "Heroic Val Secret",
            tips = "Heroic Val must be active. Do not discard or lose the Testament before returning to the hilt; finish both boss kills during the same secret attempt.",
            waypoints = { "/way #2599 61.4 78.8 Ice Guardian cave entrance / Heroic Val", "/way #2599 70.5 84.3 Ice Guardian's Sleetblade hilt / inside the cave" },
        },
        kifaan = {
            acquisition = "Buy this learn-on-use appearance from Kifaan at the active Umbral Base Camp in Naigtal or Val.",
            source = "Kifaan",
            sourceType = "Vendor",
            tips = "The active invasion zone rotates weekly. Use the Silvermoon portal to Voidstorm, then enter the active Naigtal or Val gateway.",
            waypoints = shared["kifaan waypoints"],
        },
        responseTeam = {
            acquisition = "Buy this learn-on-use Response Team appearance from Fieldsmith Ventem at the active Naigtal or Val Umbral Base Camp using Field Accolades and Voidlight Marl.",
            source = "Fieldsmith Ventem",
            sourceType = "Invasion Vendor",
            tips = "Earn Field Accolades from invasion world quests, rares, treasures, and events. Heroic World Tier yields stronger rewards, so combine this farm with the Heroic achievements when geared for it.",
            waypoints = shared["etherealPack waypoints"],
        },
        winterPack = {
            acquisition = "Buy Bulging Winter Packs from Kifaan at the active Umbral Base Camp for chances at the Void-Touched Winter appearance tokens.",
            source = "Kifaan / Bulging Winter Pack",
            sourceType = "Vendor Pack",
            tips = "The pack result is random. Use each appearance token from your bags and check collection status before buying more packs.",
            waypoints = shared["kifaan waypoints"],
        },
        zuronar = {
            acquisition = "Buy this learn-on-use Lightforged appearance from Zuronar at the active Umbral Base Camp.",
            source = "Zuronar",
            sourceType = "Vendor",
            tips = "Check Zuronar in whichever invasion zone is active that week; Naigtal and Val use separate maps but share the vendor hub.",
            waypoints = shared["etherealPack waypoints"],
        },
        zuronarArsenal = {
            acquisition = "Complete Showdown Slugger in both Naigtal and Val, then buy Arsenal: Lightforged Armaments from Zuronar at the active Umbral Base Camp.",
            source = "Zuronar",
            sourceType = "Achievement Vendor",
            tips = "The two zones rotate weekly, so the achievement requires at least one active week in each zone. The arsenal is consumed to teach its full weapon set.",
            waypoints = shared["etherealPack waypoints"],
        },
    },
    label = "Patch 12.0.7: Revelations",
    sourceNotes = {
        "The Naigtal and Val guides were cross-checked with Method's rare and Heroic Showdown routes, including cave entrances and nested maps.",
        "Live pet data adds Fishstick Keith and moves Sleepy Mandrake into its obtainable patch; the deleted Pinky record and non-Toy Box Phase-Displaced Toy were removed.",
        "Vendor costs, achievement criteria, ended events, shop rewards, and regional promotions are labeled explicitly.",
        "Cosmetics cover the learn-on-use Naigtal and Val vendor, pack, treasure, and Heroic secret rewards; Trading Post, shop, promotional, and ordinary equippable gear are excluded.",
    },
    sourceUrls = {
        achievements = "https://www.wowhead.com/achievement=62873/a-trip-around-the-stars",
        heroicShowdowns = "https://www.method.gg/guides/mounts/tortured-gorger-mount-guide",
        legacyOfAmani = "https://www.wowhead.com/news/chapter-1-of-curse-of-ulatek-patch-12-1-campaign-now-live-382105",
        liveRewards = "https://www.wowhead.com/news/return-to-naigtal-and-val-to-stop-the-void-and-collect-cosmetics-381832",
        lostArmamentCatchup = "https://www.wowhead.com/news/buy-lost-armament-transmogs-for-dark-particles-in-patch-12-0-7-381740",
        luminousSporeglider = "https://www.wowhead.com/ptr/news/luminous-sporeglider-available-from-the-sporefall-raid-382121",
        mountCrossCheck = "https://www.warcraftmounts.com/patch12.0.7.php",
        mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-0-7-models-locations",
        mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120007",
        naigtalRares = "https://www.method.gg/guides/showdown-slugger-naigtal-rares-and-locations-in-wow-midnight",
        overview = "https://www.wowhead.com/guide/midnight/patch-12-0-7-overview-features-activities-rewards",
        petCrossCheck = "https://www.wow-petguide.com/News/607/Patch_12.0.7_Datamining_2026-05-05",
        petGuide = "https://www.wowhead.com/guide/collections/midnight-battle-pets-locations-sources",
        pets = "https://www.wowhead.com/battle-pets?filter=3;3;120007",
        timewalking = "https://www.method.gg/guides/dragonflight-timewalking-vendor-and-rewards",
        valRares = "https://www.method.gg/guides/showdown-slugger-val-rares-and-locations-in-wow-midnight",
        voidInvasions = "https://www.wowhead.com/guide/midnight/naigtal-val-zones-heroic-world-tier",
    },
    wowheadPatchId = 120007,
})
