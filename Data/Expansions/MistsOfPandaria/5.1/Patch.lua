local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.1", {
    label = "Patch 5.1: Landfall",
    sourceNotes = {
        "This bucket covers the Operation: Shieldwall and Dominance Offensive campaigns, Brawler's Guild Season 1, Pandaren Spirit Tamers, Raiding with Leashes, and the permanent pets and collection rewards introduced with Landfall.",
        "Calendar-event, shop, promotion, hidden-statistic, NPC-only, and ordinary equipment records are excluded. Historical campaign, legendary, scenario, and Brawler achievements remain visible.",
        "The original campaign mounts require the faction storyline; the armored gryphon and wyvern are separate Exalted reputation purchases.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/7540458/patch-51-ptr-patch-notes-november-8",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.1.0",
        pets = "https://warcraft.wiki.gg/wiki/Raiding_with_Leashes",
    },
    wowheadPatchId = 50100,
})
