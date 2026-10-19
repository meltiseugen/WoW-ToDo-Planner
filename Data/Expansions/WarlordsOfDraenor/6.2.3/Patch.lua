local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.2.3", {
    cosmeticDetailGroups = {
        pvpTabards = {
            acquisition = "Earn the faction tabard during Warlords PvP Season 3; retained for historical collection tracking.",
            source = "Warlords rated PvP Season 3",
            sourceType = "PvP season reward",
            tips = "This original elite-season reward is no longer obtainable.",
        },
    },
    label = "Patch 6.2.3",
    sourceNotes = {
        "This bucket follows live availability for Cataclysm Timewalking, the Infinite Timereaver, Warlords PvP Season 3, and the limited Grove Warden quest reward.",
        "The Grove Warden and original Season 3 rewards are retained for historical tracking even though their original sources have ended.",
    },
    sourceUrls = {
        hotfixes = "https://worldofwarcraft.blizzard.com/en-us/news/19991705/patch-623-hotfixes-january-6-29",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/19913791",
        overview = "https://warcraft.wiki.gg/wiki/Patch_6.2.3",
    },
    wowheadPatchId = 60203,
})
