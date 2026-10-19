local _, TDP = ...

local shared = {}
shared["Patch 11.1.5"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "Other",
    source = "Patch 11.1.5",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("11.1.5", "mounts", {
    entries = {
        { name = "Voidfire Deathcycle", spellId = 428068 },
        { name = "Nesting Swarmite", spellId = 447189 },
        { name = "Void-Scarred Gryphon", spellId = 1218229 },
        { name = "Void-Forged Stallion", spellId = 1218305 },
        { name = "Void-Scarred Pack Mother", spellId = 1218306 },
        { name = "Void-Scarred Windrider", spellId = 1218307 },
        { name = "Ny'alothan Shadow Worm", spellId = 1218314 },
        { name = "Corruption of the Aspects", spellId = 1218316 },
        { name = "Void-Crystal Panther", spellId = 1218317 },
        { name = "Radiant Imperial Lynx", spellId = 1226421 },
        { name = "Tyrannotort", spellId = 1227076 },
        { name = "Void-Scarred Lynx", spellId = 1228865 },
    },
    details = {
        ["Corruption of the Aspects"] = shared["Patch 11.1.5"],
        ["Nesting Swarmite"] = shared["Patch 11.1.5"],
        ["Ny'alothan Shadow Worm"] = shared["Patch 11.1.5"],
        ["Radiant Imperial Lynx"] = shared["Patch 11.1.5"],
        Tyrannotort = shared["Patch 11.1.5"],
        ["Void-Crystal Panther"] = shared["Patch 11.1.5"],
        ["Void-Forged Stallion"] = shared["Patch 11.1.5"],
        ["Void-Scarred Gryphon"] = shared["Patch 11.1.5"],
        ["Void-Scarred Lynx"] = shared["Patch 11.1.5"],
        ["Void-Scarred Pack Mother"] = shared["Patch 11.1.5"],
        ["Void-Scarred Windrider"] = shared["Patch 11.1.5"],
        ["Voidfire Deathcycle"] = shared["Patch 11.1.5"],
    },
})
