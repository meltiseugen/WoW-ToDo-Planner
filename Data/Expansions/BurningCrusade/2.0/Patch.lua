local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("2.0", {
    cosmeticDetailGroups = {
        cenarionTabard = {
            acquisition = "Reach Exalted with the Cenarion Expedition and buy the tabard.",
            source = "Fedryen Swiftspear",
            sourceType = "Reputation vendor",
            tips = "Run Coilfang Reservoir dungeons and turn in eligible reputation items before finishing remaining quests.",
            waypoints = { "/way #102 79.3 63.8 Fedryen Swiftspear" },
        },
        darkPortalTabard = {
            acquisition = "Complete the pre-expansion Dark Portal event quest Into the Breach.",
            source = "Into the Breach at the Dark Portal",
            sourceType = "Historical launch event",
            tips = "This one-time 2.0.1 event reward is no longer obtainable; keep it in the catalogue for historical appearance tracking.",
            waypoints = { "/way #17 58.0 55.8 Dark Portal event location" },
        },
        hellfireTabards = {
            acquisition = "Reach Exalted with the matching Hellfire Peninsula faction and buy its tabard.",
            source = "Honor Hold or Thrallmar quartermaster",
            sourceType = "Reputation vendor",
            tips = "Hellfire Ramparts, Blood Furnace, and Shattered Halls runs combine reputation with transmog farming.",
            waypoints = { "/way #100 56.7 62.6 Logistics Officer Ulrike", "/way #100 54.9 37.8 Quartermaster Urgronn" },
        },
        illidariTabards = {
            acquisition = "Complete the Shadowmoon Valley group quest Battle of the Crimson Watch.",
            source = "Battle of the Crimson Watch",
            sourceType = "Quest reward",
            tips = "Modern completion awards both colors; a tabard vendor can help reacquire or swap the historical versions.",
            waypoints = { "/way #104 51.4 72.8 Battle of the Crimson Watch" },
        },
        keepersTabard = {
            acquisition = "Reach Exalted with the Keepers of Time and buy the tabard.",
            source = "Alurmi in the Caverns of Time",
            sourceType = "Reputation vendor",
            tips = "Repeated Old Hillsbrad and Black Morass clears provide the original reputation path.",
            waypoints = { "/way #71 63.6 57.6 Alurmi" },
        },
        nagrandTabards = {
            acquisition = "Reach Exalted with the matching Nagrand faction and buy its tabard.",
            source = "Kurenai or Mag'har quartermaster",
            sourceType = "Reputation vendor",
            tips = "Farm ogre beads or warbeads while working toward the faction's talbuk mounts.",
            waypoints = { "/way #107 53.5 36.9 Provisioner Nasela / Garadar", "/way #107 54.3 75.0 Trader Narasu / Telaar" },
        },
        racialTabards = {
            acquisition = "Complete the matching racial or class quest chain.",
            source = "Draenei starting campaign or blood elf Paladin class campaign",
            sourceType = "Racial quest",
            tips = "Tabard of the Hand is draenei-specific; Blood Knight Tabard belongs to the blood elf Paladin campaign.",
            waypoints = { "/way #97 47.0 50.0 Azuremyst quest campaign", "/way #110 92.6 36.8 Blood Knight headquarters" },
        },
        shattrathTabards = {
            acquisition = "Reach Exalted with the corresponding faction and buy its tabard.",
            source = "Shattrath and Netherstorm faction quartermasters",
            sourceType = "Reputation vendor",
            tips = "Choose Aldor or Scryers carefully: changing allegiance requires rebuilding the opposing reputation. Lower City, Sha'tar, and Consortium can be advanced through their associated dungeons and turn-ins.",
            waypoints = { "/way #111 47.6 26.6 Aldor Rise", "/way #111 56.3 81.5 Scryer's Tier", "/way #111 54.0 44.8 Terrace of Light", "/way #109 43.5 35.2 Stormspire / Consortium" },
        },
        sporeggarTabard = {
            acquisition = "Reach Exalted with Sporeggar and buy the tabard with Glowcaps.",
            source = "Mycah in Sporeggar",
            sourceType = "Reputation vendor",
            tips = "Combine repeatable Zangarmarsh turn-ins with dungeon objectives, then gather extra Glowcaps near Sporeggar.",
            waypoints = { "/way #102 17.9 51.2 Mycah" },
        },
    },
    label = "The Burning Crusade",
    sourceNotes = {
        "The launch bucket covers the permanent collection introduced by the 2.0 client and the January 2007 expansion release: Outland flying mounts, blood elf and draenei racial mounts and pets, talbuks, launch raids, reputation tabards, quests, fishing, and engineering devices later promoted into the Toy Box.",
        "Fiery Warhorse and Ashes of Al'ar retain their original Karazhan and Tempest Keep entrances. Mr. Pinchy, Halaa, racial vendors, reputation quartermasters, and the two engineering transporter branches include practical farming or purchase pins.",
        "Collector's Edition, trading-card, promotion, recurring holiday, unused, NPC-only, temporary, and ordinary equipment records are excluded. The one-time Tabard of the Protector remains as a historical collection appearance; achievements did not exist until patch 3.0.2.",
    },
    sourceUrls = {
        collections = "https://news.blizzard.com/en-us/article/23523203/burning-crusade-mounts-pets-and-more",
        expansion = "https://warcraft.wiki.gg/wiki/World_of_Warcraft:_The_Burning_Crusade",
        miniwing = "https://warcraft.wiki.gg/wiki/Miniwing",
        patch = "https://warcraft.wiki.gg/wiki/Patch_2.0.3",
        powerConverter = "https://warcraft.wiki.gg/wiki/Power_Converter",
        tabards = "https://warcraft.wiki.gg/wiki/Tabard#The_Burning_Crusade_tabards",
    },
    wowheadPatchId = 20000,
})
