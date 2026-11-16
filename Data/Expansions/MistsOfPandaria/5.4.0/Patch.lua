local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.4.0", {
    label = "Patch 5.4: Siege of Orgrimmar",
    sourceNotes = {
        "This bucket covers Siege of Orgrimmar, the Timeless Isle, Celestial Tournament, Proving Grounds, the legendary-cloak finale, and Mists PvP Season 14.",
        "The audit uses original live availability. Calendar events, shop and promotional rewards, hidden statistics, NPC-only records, and ordinary equipment are excluded; retired raid, realm-best, and PvP rewards remain for historical tracking.",
        "Timeless Isle coordinates identify practical farming hubs or spawn areas; moving rares and multi-point treasure objectives may require a local route rather than a single pin.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/10158897/patch-54-siege-of-orgrimmar",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.4.0",
        pets = "https://warcraft.wiki.gg/wiki/Celestial_Tournament",
        siege = "https://warcraft.wiki.gg/wiki/Siege_of_Orgrimmar",
        timeless = "https://warcraft.wiki.gg/wiki/Timeless_Isle",
    },
    wowheadPatchId = 50400,
})
