local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.3", {
    cosmeticDetailGroups = {
        brawlerShirts = {
            acquisition = "Complete the matching original challenge-card encounter and obtain its shirt reward.",
            source = "Original Brawler's Guild challenge cards",
            sourceType = "Brawler's Guild reward",
            tips = "These rewards are retained for historical tracking; original-season encounter and vendor availability has changed.",
        },
    },
    label = "Patch 5.3: Escalation",
    sourceNotes = {
        "This bucket covers Battlefield: Barrens, the Escalation campaign, Heroic Scenarios, Deepwind Gorge, the Brawler's Guild update, Raiding with Leashes II, and new Throne of Thunder and world pets.",
        "The retired Barrens campaign and original Brawler season remain represented through their historical rewards. Event, shop, promotion, hidden-statistic, NPC-only, and ordinary equipment records are excluded.",
        "Several Barrens vanity rewards remain obtainable from legacy vendors even though their original Radical Mojo acquisition path ended.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/10021220/53-escalation-patch-notes",
        overview = "https://worldofwarcraft.blizzard.com/en-us/news/9679405/53-escalation-round-up",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.3.0",
        pets = "https://warcraft.wiki.gg/wiki/Raiding_with_Leashes_II:_Attunement_Edition",
    },
    wowheadPatchId = 50300,
})
