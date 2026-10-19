local _, TDP = ...

local shared = {}
shared["remixAchievements waypoints"] = {
    "/way #627 47.70 69.81 Infinite Bazaar portal",
    "/way #627 45.48 67.84 Pythagorus / raid ensembles",
    "/way #627 45.50 68.39 Unicus and Larah Treebender",
    "/way #627 45.44 68.03 Arturos / dungeon ensembles",
    "/way #627 45.43 67.70 Agos / Lost and Found Apparel",
    "/way #627 45.39 67.78 Freddie Threads / cloak ensembles",
}

TDP.CatalogRegistry:RegisterPatch("11.2.5", {
    cosmeticDetailGroups = {
        remixAchievements = {
            acquisition = "Earn the matching Legion Remix achievement to receive the learn-on-use ensemble. The Sargerei tints came from campaign, Heroic world-quest, raid, and progression goals; Chosen Dead ensembles came from Trial of Valor objectives.",
            source = "Legion Remix campaign and raid achievements",
            sourceType = "Legacy Event Achievement",
            tips = "These were event-only achievement rewards and are currently unavailable. Remember to use the reward item from your bags after earning it.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixArgus = {
            acquisition = "Complete at least two of the four Argus Timerunning objectives: campaign, zone tour, group content, or Exalted with the Argussian Reach.",
            source = "Argus / Bulwark of Mannoroth",
            sourceType = "Legacy Event Achievement",
            tips = "The single reward wrapper teaches the matching shield and cloak looks, so those component appearances are not listed separately. Legion Remix has ended.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixBrokenShore = {
            acquisition = "Complete at least three of the four Broken Shore Timerunning objectives to receive the learn-on-use Fallen King's Corrupted Blades bundle.",
            source = "The Broken Shore / Fallen King's Corrupted Blades",
            sourceType = "Legacy Event Achievement",
            tips = "The bundle teaches the corrupted Shalla'tor, Ellemayne, and Shalamayne appearances. Their hidden component records are not duplicated. Legion Remix has ended.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixCloaks = {
            acquisition = "During Legion Remix, buy the cloak ensemble from Freddie Threads with Bronze after its content phase unlocked.",
            source = "Freddie Threads / Infinite Bazaar",
            sourceType = "Legacy Event Vendor",
            tips = "The event has ended. Each ensemble teaches several matching cloak appearances, so its internal cloak item records are not repeated.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixDungeon = {
            acquisition = "During Legion Remix, buy the dungeon appearance ensemble from Arturos with Bronze after the relevant phase unlocked.",
            source = "Arturos / Infinite Bazaar",
            sourceType = "Legacy Event Vendor",
            tips = "The event has ended. Buying the ensemble taught the set directly; farming ordinary equippable dungeon drops is outside this Cosmetics category.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixExclusive = {
            acquisition = "During Legion Remix, buy the event-exclusive ensemble or arsenal from Unicus with Bronze after its phase became available.",
            source = "Unicus / Infinite Bazaar",
            sourceType = "Legacy Event Vendor",
            tips = "Legion Remix ended January 19, 2026, so these rewards are currently unavailable. They were learn-on-use bundles; individual appearances inside them are intentionally not duplicated here.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixFelshatter = {
            acquisition = "Complete at least two of the four Val'sharah Timerunning objectives to receive Illusion: Felshatter, then use the item to learn weapon illusion 98.",
            source = "Val'sharah Timerunning meta",
            sourceType = "Legacy Event Achievement",
            tips = "The objectives were the campaign, zone tour, group content, and Dreamweavers reputation. The event has ended; players who earned but deleted the bugged item were advised to check Item Restoration.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixLostFound = {
            acquisition = "During Legion Remix, buy this otherwise-missed apparel ensemble from Agos in the Infinite Bazaar.",
            source = "Agos / Lost and Found Apparel",
            sourceType = "Legacy Event Vendor",
            tips = "The event has ended. Agos was the dedicated source for incomplete or hard-to-place Legion appearance sets.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixMythicAntorus = {
            acquisition = "Defeat every Antorus boss on Mythic difficulty during Legion Remix to receive the Felscorned Scythe of the Unmaker appearance bundle.",
            source = "Mythic: Antorus, the Burning Throne",
            sourceType = "Legacy Event Achievement",
            tips = "The item had to be used from the bag. It teaches the Felscorned scythe variants and is now unavailable because Legion Remix has ended.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixRaid = {
            acquisition = "During Legion Remix, buy the class raid ensemble from Pythagorus with Bronze after its raid phase became available.",
            source = "Pythagorus / Infinite Bazaar",
            sourceType = "Legacy Event Vendor",
            tips = "Nighthold, Tomb of Sargeras, and Antorus ensembles unlocked in later event phases. The event has ended; individual raid gear pieces are omitted because the ensemble is the collectible container.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixRareRaid = {
            acquisition = "During Legion Remix, trade 20 of the matching boss currency to Pythagorus: Horns of the First Satyr, Felwarped Slabs, Everflames of Hatred, or Cosmic Soulslivers.",
            source = "Pythagorus / rare raid appearances",
            sourceType = "Legacy Event Vendor",
            tips = "Normal, Heroic, and Mythic kills awarded 1, 4, and 10 currency respectively. Taeshalach and Scythe of the Unmaker bundles include their added weapon-type variants. The event has ended, though some original appearances remain farmable in retail Legion raids.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixStormheim = {
            acquisition = "Complete at least two of the four Stormheim Timerunning objectives: campaign, zone tour, group content, or Exalted with the Valarjar.",
            source = "Stormheim / Sinister Fel Arsenal",
            sourceType = "Legacy Event Achievement",
            tips = "The achievement's cache produced four separate learn-on-use weapon cosmetics; the non-cosmetic cache itself is not tracked. Legion Remix has ended.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixSuramar = {
            acquisition = "Complete at least two of the four Suramar Timerunning objectives: campaign, zone tour, group content, or Exalted with The Nightfallen.",
            source = "Suramar / Kaldorei Queen's Royal Vestments",
            sourceType = "Legacy Event Achievement",
            tips = "The achievement awarded six separate learn-on-use cosmetic pieces rather than one ensemble, so all six actual bag items are tracked. Legion Remix has ended.",
            waypoints = shared["remixAchievements waypoints"],
        },
        remixWorld = {
            acquisition = "During Legion Remix, buy the open-world or questing ensemble from Larah Treebender with Bronze.",
            source = "Larah Treebender / Infinite Bazaar",
            sourceType = "Legacy Event Vendor",
            tips = "The event has ended. Larah grouped appearances by their original Legion zone or outdoor source, but each listed record is the learn-on-use ensemble sold during Remix.",
            waypoints = shared["remixAchievements waypoints"],
        },
    },
    label = "Patch 11.2.5: Legion Remix",
    sourceNotes = {
        "Mounts, battle pets, toys, Cosmetics, and achievements are audited against client snapshots and source metadata.",
        "The list tracks learn-on-use ensembles, arsenals, illusions, and cosmetic tokens offered or awarded during Legion Remix; ordinary equippable raid and world gear is excluded.",
        "Legion Remix ran from October 7, 2025 through January 19, 2026. Event-only sources are now legacy and unavailable unless Blizzard returns them.",
        "Trading Post items are excluded. Component appearance records taught by an ensemble, arsenal, or achievement wrapper are not duplicated.",
    },
    sourceUrls = {
        argusWeapons = "https://www.wowhead.com/news/scythes-of-the-unmaker-and-taeshalach-appearances-available-in-legion-remix-phase-4-379378",
        felshatter = "https://www.wowhead.com/news/embrace-the-fel-with-a-new-weapon-illusion-in-legion-remix-378372",
        overview = "https://www.wowhead.com/guide/wow-remix-legion-overview",
        rewards = "https://www.wowhead.com/guide/legion-remix-rewards-mounts-transmog",
        zoneRewards = "https://www.wowhead.com/news/50-warband-xp-buff-exclusive-transmogs-pets-and-more-zone-rewards-in-legion-remix-378658",
    },
    wowheadPatchId = 110205,
})
