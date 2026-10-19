local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("11.1.7", "toys", {
    entries = {
        { itemId = 245942, name = "Sea-Blessed Shrine", source = "Vendor: Churbro / Zone: Boralus Harbor / Cost: 1000 / Vendor: Churbro / Zone: Zuldazar / Cost: 1000" },
        { itemId = 246227, name = "Lightning-Blessed Spire", source = "Vendor: Churbro / Zone: Zuldazar / Cost: 1000 / Vendor: Churbro / Zone: Boralus Harbor / Cost: 1000" },
    },
    details = {
        ["Lightning-Blessed Spire"] = {
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
            source = "Vendor: Churbro / Zone: Zuldazar / Cost: 1000 / Vendor: Churbro / Zone: Boralus Harbor / Cost: 1000",
            sourceType = "Toy Box Source",
        },
        ["Sea-Blessed Shrine"] = {
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
            source = "Vendor: Churbro / Zone: Boralus Harbor / Cost: 1000 / Vendor: Churbro / Zone: Zuldazar / Cost: 1000",
            sourceType = "Toy Box Source",
        },
    },
})
