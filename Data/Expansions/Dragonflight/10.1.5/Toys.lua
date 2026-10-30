local _, TDP = ...

local shared = {}
shared["Discovery: Naxxramas"] = { source = "Discovery: Naxxramas", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("10.1.5", "toys", {
    entries = {
        { itemId = 197961, name = "Whelps on Strings", source = "Achievement: Daycare Derby / Category: Dragonflight" },
        { itemId = 206195, name = "Path of the Naaru", source = "Vendor: Gaal / Zone: Krokuun / Cost: 90 90 900" },
        { itemId = 206565, name = "Plagued Grain", source = "Discovery: Naxxramas" },
        { itemId = 206993, name = "Investi-gator's Pocketwatch", source = "Drop: Temporal Investi-gator / Zone: Thaldraszus" },
        { itemId = 207099, name = "Tiny Box of Tiny Rocks", source = "Achievement: Many Boxes, Many Rockses" },
        { itemId = 208096, name = "Familiar Journal", source = "Discovery: Naxxramas" },
        { itemId = 208186, name = "Boffins", source = "Achievement: Temporal Acquisitions Specialist" },
        { itemId = 208415, name = "Stasis Sand", source = "Quest: Dawn of the Infinite: Chrono-Lord Deios / Zone: Thaldraszus" },
    },
    details = {
        Boffins = { source = "Achievement: Temporal Acquisitions Specialist", sourceType = "Toy Box Source" },
        ["Familiar Journal"] = shared["Discovery: Naxxramas"],
        ["Investi-gator's Pocketwatch"] = { source = "Drop: Temporal Investi-gator / Zone: Thaldraszus", sourceType = "Toy Box Source" },
        ["Path of the Naaru"] = { source = "Vendor: Gaal / Zone: Krokuun / Cost: 90 90 900", sourceType = "Toy Box Source" },
        ["Plagued Grain"] = shared["Discovery: Naxxramas"],
        ["Stasis Sand"] = {
            source = "Quest: Dawn of the Infinite: Chrono-Lord Deios / Zone: Thaldraszus",
            sourceType = "Toy Box Source",
        },
        ["Tiny Box of Tiny Rocks"] = { source = "Achievement: Many Boxes, Many Rockses", sourceType = "Toy Box Source" },
        ["Whelps on Strings"] = { source = "Achievement: Daycare Derby / Category: Dragonflight", sourceType = "Toy Box Source" },
    },
})
