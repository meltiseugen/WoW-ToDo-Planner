local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.3", {
    label = "Patch 6.2.3",
    sourceNotes = {
        "This bucket follows live availability for Cataclysm Timewalking, the Infinite Timereaver, Warlords PvP Season 3, and the limited Grove Warden quest reward.",
        "The retired Grove Warden and original Season 3 Gladiator mounts are removed from the mount catalogue. Infinite Timereaver is placed under General because its source spans recurring Timewalking events.",
        "Warmongering Gladiator's Tabards (127369 and 127371) are removed from the cosmetic catalogue because their elite season has ended.",
    },
    sourceUrls = {
        hotfixes = "https://worldofwarcraft.blizzard.com/en-us/news/19991705/patch-623-hotfixes-january-6-29",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/19913791",
        overview = "https://warcraft.wiki.gg/wiki/Patch_6.2.3",
    },
    wowheadPatchId = 60203,
})
