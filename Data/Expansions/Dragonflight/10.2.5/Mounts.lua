local _, TDP = ...

local shared = {}
shared["Patch 10.2.5: Seeds of Renewal"] = {
    category = "Other",
    source = "Patch 10.2.5: Seeds of Renewal",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("10.2.5", "mounts", {
    entries = { { name = "Explorer's Stonehide Packbeast", spellId = 374204 }, { name = "Gilnean Prowler", spellId = 430225 }, { name = "Clayscale Hornstrider", spellId = 432610 } },
    details = {
        ["Clayscale Hornstrider"] = shared["Patch 10.2.5: Seeds of Renewal"],
        ["Explorer's Stonehide Packbeast"] = shared["Patch 10.2.5: Seeds of Renewal"],
        ["Gilnean Prowler"] = shared["Patch 10.2.5: Seeds of Renewal"],
    },
})
