local _, TDP = ...

local shared = {}
shared["Patch 10.1.5: Fractures in Time"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "Other",
    source = "Patch 10.1.5: Fractures in Time",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("10.1.5", "mounts", {
    entries = {
        { name = "Scarlet Pterrordax", spellId = 413825 },
        { name = "Harbor Gryphon", spellId = 413827 },
        { name = "Valiance", spellId = 413922 },
        { name = "White War Wolf", spellId = 414316 },
        { name = "Ravenous Black Gryphon", spellId = 414323 },
        { name = "Gold-Toed Albatross", spellId = 414324 },
        { name = "Felstorm Dragon", spellId = 414326 },
        { name = "Sulfur Hound", spellId = 414327 },
        { name = "Perfected Juggernaut", spellId = 414328 },
        { name = "Scourgebound Vanquisher", spellId = 414334 },
        { name = "Pattie", spellId = 418078 },
    },
    details = {
        ["Felstorm Dragon"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Gold-Toed Albatross"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Harbor Gryphon"] = shared["Patch 10.1.5: Fractures in Time"],
        Pattie = shared["Patch 10.1.5: Fractures in Time"],
        ["Perfected Juggernaut"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Ravenous Black Gryphon"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Scarlet Pterrordax"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Scourgebound Vanquisher"] = shared["Patch 10.1.5: Fractures in Time"],
        ["Sulfur Hound"] = shared["Patch 10.1.5: Fractures in Time"],
        Valiance = shared["Patch 10.1.5: Fractures in Time"],
        ["White War Wolf"] = shared["Patch 10.1.5: Fractures in Time"],
    },
})
