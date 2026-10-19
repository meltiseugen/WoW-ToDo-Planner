local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("4.3.0", "pets", {
    entries = {
        {
            acquisition = "Obtain Soul of the Aspects from guild vendor after Fangs of the Father - Guild Edition.",
            category = "Guild Achievements",
            name = "Soul of the Aspects",
            source = "guild vendor after Fangs of the Father - Guild Edition",
            speciesId = 347,
            tips = "A guild must complete the legendary-dagger guild achievement before eligible members can purchase this pet.",
            waypoints = { "/way #84 67.4 72.8 Guild vendor", "/way #85 48.4 75.6 Guild vendor" },
        },
    },
    details = {
        ["Soul of the Aspects"] = {
            acquisition = "Obtain Soul of the Aspects from guild vendor after Fangs of the Father - Guild Edition.",
            source = "guild vendor after Fangs of the Father - Guild Edition",
            sourceType = "Pet Journal Source",
            tips = "A guild must complete the legendary-dagger guild achievement before eligible members can purchase this pet.",
            waypoints = { "/way #84 67.4 72.8 Guild vendor", "/way #85 48.4 75.6 Guild vendor" },
        },
    },
})
