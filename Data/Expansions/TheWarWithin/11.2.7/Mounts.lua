local _, TDP = ...

local shared = {}
shared["Patch 11.2.7: The Warning"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "Other",
    source = "Patch 11.2.7: The Warning",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("11.2.7", "mounts", {
    entries = {
        { name = "Bonecleaver's Skullboar", spellId = 332482 },
        { name = "K'arroc Swiftwing", spellId = 1233516 },
        { name = "Bronze Wilderling", spellId = 1261668 },
        { name = "Bronze Aquilon", spellId = 1261671 },
        { name = "Bronze Corpsefly", spellId = 1261677 },
        { name = "Bronze Gravewing", spellId = 1261681 },
        { name = "Geargrinder Mk. 11", spellId = 1262886 },
        { name = "Skypaw Glimmerfur", spellId = 1263369 },
        { name = "Crimson Lupine", spellId = 1263387 },
        { name = "Brawlin' Bruno", spellId = 1264621 },
        { name = "Ballistic Bronco", spellId = 1264643 },
        { name = "Snowpaw Glimmerfur Prowler", spellId = 1264988 },
    },
    details = {
        ["Ballistic Bronco"] = shared["Patch 11.2.7: The Warning"],
        ["Bonecleaver's Skullboar"] = shared["Patch 11.2.7: The Warning"],
        ["Brawlin' Bruno"] = shared["Patch 11.2.7: The Warning"],
        ["Bronze Aquilon"] = shared["Patch 11.2.7: The Warning"],
        ["Bronze Corpsefly"] = shared["Patch 11.2.7: The Warning"],
        ["Bronze Gravewing"] = shared["Patch 11.2.7: The Warning"],
        ["Bronze Wilderling"] = shared["Patch 11.2.7: The Warning"],
        ["Crimson Lupine"] = shared["Patch 11.2.7: The Warning"],
        ["Geargrinder Mk. 11"] = shared["Patch 11.2.7: The Warning"],
        ["K'arroc Swiftwing"] = shared["Patch 11.2.7: The Warning"],
        ["Skypaw Glimmerfur"] = shared["Patch 11.2.7: The Warning"],
        ["Snowpaw Glimmerfur Prowler"] = shared["Patch 11.2.7: The Warning"],
    },
})
