local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("5.1", "toys", {
    entries = {
        {
            acquisition = "Obtain Stackable Stag from Sally Fizzlefury in Valley of the Four Winds for 1,000 gold.",
            category = "Vendor",
            itemId = 91904,
            name = "Stackable Stag",
            source = "Sally Fizzlefury in Valley of the Four Winds for 1,000 gold",
            tips = "The Safari Hat is mailed after the achievement if it is not awarded immediately. Stackable Stag has no reputation requirement.",
        },
        {
            acquisition = "Obtain Safari Hat from the Taming the World achievement.",
            category = "Achievements",
            itemId = 92738,
            name = "Safari Hat",
            source = "the Taming the World achievement",
            tips = "The Safari Hat is mailed after the achievement if it is not awarded immediately. Stackable Stag has no reputation requirement.",
        },
    },
    details = {
        ["Safari Hat"] = {
            acquisition = "Obtain Safari Hat from the Taming the World achievement.",
            source = "the Taming the World achievement",
            sourceType = "Toy Box Source",
            tips = "The Safari Hat is mailed after the achievement if it is not awarded immediately. Stackable Stag has no reputation requirement.",
        },
        ["Stackable Stag"] = {
            acquisition = "Obtain Stackable Stag from Sally Fizzlefury in Valley of the Four Winds for 1,000 gold.",
            source = "Sally Fizzlefury in Valley of the Four Winds for 1,000 gold",
            sourceType = "Toy Box Source",
            tips = "The Safari Hat is mailed after the achievement if it is not awarded immediately. Stackable Stag has no reputation requirement.",
        },
    },
})
