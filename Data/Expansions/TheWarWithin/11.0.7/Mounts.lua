local _, TDP = ...

local shared = {}
shared["Patch 11.0.7: Siren Isle"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "Other",
    source = "Patch 11.0.7: Siren Isle",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("11.0.7", "mounts", {
    entries = {
        { name = "Honeyback Hivemother", spellId = 303767 },
        { name = "Shadow of Doubt", spellId = 448934 },
        { name = "Timely Buzzbee", spellId = 471538 },
        { name = "Thrayir, Eyes of the Siren", spellId = 471562 },
        { name = "Hooktalon", spellId = 471696 },
        { name = "The Breaker's Song", spellId = 472752 },
        { name = "Soweezi's Vintage Waveshredder", spellId = 473137 },
        { name = "Jani's Trashpile", spellId = 473472 },
        { name = "Prismatic Snapdragon", spellId = 474086 },
        { name = "Nightfall Skyreaver", spellId = 1214920 },
        { name = "Ur'zul Fleshripper", spellId = 1214940 },
        { name = "Broodling of Sinestra", spellId = 1214946 },
        { name = "Copper-Maned Quilen", spellId = 1214974 },
        { name = "Plunderlord's Midnight Crocolisk", spellId = 457656 },
    },
    details = {
        ["Broodling of Sinestra"] = shared["Patch 11.0.7: Siren Isle"],
        ["Copper-Maned Quilen"] = shared["Patch 11.0.7: Siren Isle"],
        ["Honeyback Hivemother"] = shared["Patch 11.0.7: Siren Isle"],
        Hooktalon = shared["Patch 11.0.7: Siren Isle"],
        ["Jani's Trashpile"] = shared["Patch 11.0.7: Siren Isle"],
        ["Nightfall Skyreaver"] = shared["Patch 11.0.7: Siren Isle"],
        ["Plunderlord's Midnight Crocolisk"] = {
            acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
            availability = "Limited-time reward; retained in its original patch catalog for historical collection tracking.",
            category = "Other",
            source = "Patch 11.0.7: Siren Isle",
            sourceType = "Patch mount collection",
        },
        ["Prismatic Snapdragon"] = shared["Patch 11.0.7: Siren Isle"],
        ["Shadow of Doubt"] = shared["Patch 11.0.7: Siren Isle"],
        ["Soweezi's Vintage Waveshredder"] = shared["Patch 11.0.7: Siren Isle"],
        ["The Breaker's Song"] = shared["Patch 11.0.7: Siren Isle"],
        ["Thrayir, Eyes of the Siren"] = shared["Patch 11.0.7: Siren Isle"],
        ["Timely Buzzbee"] = shared["Patch 11.0.7: Siren Isle"],
        ["Ur'zul Fleshripper"] = shared["Patch 11.0.7: Siren Isle"],
    },
})
