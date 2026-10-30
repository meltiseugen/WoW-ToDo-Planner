local _, TDP = ...

local shared = {}
shared["Patch 10.1.7: Fury Incarnate"] = {
    category = "Other",
    source = "Patch 10.1.7: Fury Incarnate",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("10.1.7", "mounts", {
    entries = {
        { name = "Renewed Magmammoth", spellId = 374278 },
        { name = "Duskwing Ohuna", spellId = 385262 },
        { name = "Sandy Shalewing", spellId = 408654 },
        { name = "Mimiron's Jumpjets", spellId = 424082 },
    },
    details = {
        ["Duskwing Ohuna"] = shared["Patch 10.1.7: Fury Incarnate"],
        ["Mimiron's Jumpjets"] = shared["Patch 10.1.7: Fury Incarnate"],
        ["Renewed Magmammoth"] = shared["Patch 10.1.7: Fury Incarnate"],
        ["Sandy Shalewing"] = shared["Patch 10.1.7: Fury Incarnate"],
    },
})
