local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.1.0", {
    cosmeticDetailGroups = {
        argentCityTabards = {
            acquisition = "Become Champion of the matching city, then buy its tabard with Champion's Seals.",
            source = "home-city quartermasters",
            sourceType = "Argent Tournament vendor",
            tips = "Work through one city at a time and keep doing champion dailies; progress also unlocks the matching mount, pet, and banner.",
            waypoints = { "/way #118 75.8 24.4 Argent Tournament Grounds" },
        },
    },
    label = "Secrets of Ulduar",
    sourceNotes = {
        "Patch 3.1 opens Ulduar, introduces the Argent Tournament and Dalaran fishing dailies, and adds their permanent mounts, pets, toys, city tabards, and achievements.",
        "The PTR-only Blue Skeletal Warhorse and recurring Noblegarden collection are excluded. Deadly Gladiator rewards and removed Ulduar realm-first or challenge records remain for historical completeness.",
        "Tournament rows point to the shared grounds because city vendors cluster in faction pavilions; each tip names the championship prerequisite so Seal spending can be planned efficiently.",
    },
    sourceUrls = {
        fishing = "https://warcraft.wiki.gg/wiki/Bag_of_Fishing_Treasures_(Dalaran)",
        patch = "https://warcraft.wiki.gg/wiki/Patch_3.1.0",
        tournament = "https://www.wowhead.com/wotlk/guide/argent-tournament/rewards",
        ulduar = "https://www.wowhead.com/news/ulduar-timewalking-patch-3-1-features-and-patch-notes-spotlight-281916",
        undocumented = "https://warcraft.wiki.gg/wiki/Patch_3.1.0_(undocumented_changes)",
    },
    wowheadPatchId = 30100,
})
