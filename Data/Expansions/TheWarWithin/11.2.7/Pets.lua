local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("11.2.7", "pets", {
    entries = { { name = "P.O.S.T. Assistant", npcId = 253374, source = "Vendor: Collector Ta'steld / Zone: Oribos / Cost: 2200", speciesId = 4911 } },
    details = {
        ["P.O.S.T. Assistant"] = {
            source = "Vendor: Collector Ta'steld / Zone: Oribos / Cost: 2200",
            sourceType = "Pet Journal Source",
        },
    },
})
