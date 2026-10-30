local _, TDP = ...

local shared = {}
shared["Patch 11.1.7"] = {
    category = "Other",
    source = "Patch 11.1.7",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("11.1.7", "mounts", {
    entries = {
        { name = "Chrono Corsair", spellId = 1226144 },
        { name = "Moonlit Nightsaber", spellId = 1237631 },
        { name = "Ivory Savagemane", spellId = 1237703 },
        { name = "OC91 Chariot", spellId = 1241263 },
    },
    details = {
        ["Chrono Corsair"] = shared["Patch 11.1.7"],
        ["Ivory Savagemane"] = shared["Patch 11.1.7"],
        ["Moonlit Nightsaber"] = shared["Patch 11.1.7"],
        ["OC91 Chariot"] = shared["Patch 11.1.7"],
    },
})
