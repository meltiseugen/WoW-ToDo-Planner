local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.0.8", "pets", {
    entries = {
        {
            acquisition = "Obtain Little Fawn from Lil' Game Hunter.",
            category = "Achievements",
            name = "Little Fawn",
            source = "Lil' Game Hunter",
            speciesId = 203,
            tips = "Collect 75 companion pets under the original achievement criterion; the reward arrives by mail.",
        },
    },
    details = {
        ["Little Fawn"] = {
            acquisition = "Obtain Little Fawn from Lil' Game Hunter.",
            source = "Lil' Game Hunter",
            sourceType = "Pet Journal Source",
            tips = "Collect 75 companion pets under the original achievement criterion; the reward arrives by mail.",
        },
    },
})
