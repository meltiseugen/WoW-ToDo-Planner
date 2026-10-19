local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.5", "toys", {
    entries = {
        {
            itemId = 212518,
            name = "Vial of Endless Draconic Scales",
            source = "Vendor: Dathendrash Zone: Stormwind City Zone: Orgrimmar Cost: 40 Vendor: Maztha Zone: Valdrakken Cost: 40",
        },
    },
    details = {
        ["Vial of Endless Draconic Scales"] = {
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
            source = "Vendor: Dathendrash Zone: Stormwind City Zone: Orgrimmar Cost: 40 Vendor: Maztha Zone: Valdrakken Cost: 40",
            sourceType = "Toy Box Source",
        },
    },
})
