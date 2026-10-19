local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("9.1.5", {
    label = "Patch 9.1.5: Shadowlands Content Update",
    sourceNotes = {
        "This audit covers eligible collection records introduced by the 9.1.5 client, including Legion Timewalking, Mage Tower, covenant-callings, scouting maps, and the Lightforged draenei paladin mount.",
        "Winter Veil, Noblegarden, Midsummer, Trial of Style, esports, shop, subscription, promotion, hidden tracking, placeholders, and unavailable records are excluded.",
        "The incomplete duplicate Lightforged Ruinstrider mount record is excluded in favor of the collectible mount-journal spell.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23731242",
        overview = "https://www.wowhead.com/guide/shadowlands-patch-9-1-5-features",
        timewalking = "https://www.wowhead.com/news/legion-timewalking-vendor-rewards-includes-nightborne-weapons-and-toy-324199",
    },
    wowheadPatchId = 90105,
})
