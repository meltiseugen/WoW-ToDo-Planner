local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("11.0.7", "toys", {
    entries = {
        { itemId = 235017, name = "Glittering Vault Shard", source = "Drop: Siren Isle" },
        { itemId = 233486, name = "Hallowfall Supply Cache", source = "Vendor: Ailenda Hedgemyr / Zone: Siren Isle / Cost: 750" },
        { itemId = 235015, name = "Awakened Supply Crate", source = "Vendor: Hooded Purveyor / Zone: Siren Isle / Cost: 750" },
        { itemId = 234473, name = "Soweezi's Comfy Lawn Chair", source = "Vendor: Soweezi / Zone: Siren Isle / Cost: 750" },
    },
    details = {
        ["Awakened Supply Crate"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Hooded Purveyor / Zone: Siren Isle / Cost: 750", sourceType = "Toy Box Source" },
        ["Glittering Vault Shard"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Drop: Siren Isle", sourceType = "Toy Box Source" },
        ["Hallowfall Supply Cache"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Ailenda Hedgemyr / Zone: Siren Isle / Cost: 750", sourceType = "Toy Box Source" },
        ["Soweezi's Comfy Lawn Chair"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Soweezi / Zone: Siren Isle / Cost: 750", sourceType = "Toy Box Source" },
    },
})
