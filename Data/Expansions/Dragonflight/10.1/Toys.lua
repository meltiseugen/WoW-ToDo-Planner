local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.1", "toys", {
    entries = {
        { itemId = 204220, name = "Hraxian's Unbreakable Will", source = "Quest: Hraxian's Unbreakable Will / Zone: Zaralek Cavern" },
        { itemId = 204686, name = "Titan Containment Device", source = "Quest: A Sliver of Silver / Zone: Tirisfal Glades" },
        { itemId = 204818, name = "Mallard Mortar", source = "Profession: Dragon Isles Engineering" },
        { itemId = 205045, name = "B.B.F. Fist", source = "Profession: Dragon Isles Jewelcrafting" },
        { itemId = 205419, name = "Dinn's Drum", source = "Drop: Dinn / Zone: Zaralek Cavern" },
        { itemId = 205796, name = "Molten Lava Pack", source = "Drop: Invohq / Zone: Zaralek Cavern" },
        { itemId = 205908, name = "Inherited Wisdom of Senegos", source = "Quest: A Peaceful Farewell / Zone: The Azure Span" },
        { itemId = 205963, name = "Sniffin' Salts", source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 200" },
        { itemId = 206267, name = "Obsidian Legend's Pennant", source = "Achievement: Legend: Dragonflight Season 2 / Category: Arena" },
        { itemId = 206008, name = "Nightmare Banner", source = "Event: A Greedy Emissary" },
        { itemId = 205936, name = "New Niffen No-Sniffin' Tonic", source = "Vendor: Loamm Food and Beverage Vendors" },
        { itemId = 206343, name = "Crimson Legend's Pennant", source = "Achievement: Legend: Dragonflight Season 1 / Category: Player vs. Player" },
    },
    details = {
        ["B.B.F. Fist"] = { source = "Profession: Dragon Isles Jewelcrafting", sourceType = "Toy Box Source" },
        ["Crimson Legend's Pennant"] = {
            source = "Achievement: Legend: Dragonflight Season 1 / Category: Player vs. Player",
            sourceType = "Toy Box Source",
        },
        ["Dinn's Drum"] = { source = "Drop: Dinn / Zone: Zaralek Cavern", sourceType = "Toy Box Source" },
        ["Hraxian's Unbreakable Will"] = { source = "Quest: Hraxian's Unbreakable Will / Zone: Zaralek Cavern", sourceType = "Toy Box Source" },
        ["Inherited Wisdom of Senegos"] = { source = "Quest: A Peaceful Farewell / Zone: The Azure Span", sourceType = "Toy Box Source" },
        ["Mallard Mortar"] = { source = "Profession: Dragon Isles Engineering", sourceType = "Toy Box Source" },
        ["Molten Lava Pack"] = { source = "Drop: Invohq / Zone: Zaralek Cavern", sourceType = "Toy Box Source" },
        ["New Niffen No-Sniffin' Tonic"] = { source = "Vendor: Loamm Food and Beverage Vendors", sourceType = "Toy Box Source" },
        ["Nightmare Banner"] = { source = "Event: A Greedy Emissary", sourceType = "Toy Box Source" },
        ["Obsidian Legend's Pennant"] = {
            source = "Achievement: Legend: Dragonflight Season 2 / Category: Arena",
            sourceType = "Toy Box Source",
        },
        ["Sniffin' Salts"] = { source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 200", sourceType = "Toy Box Source" },
        ["Titan Containment Device"] = { source = "Quest: A Sliver of Silver / Zone: Tirisfal Glades", sourceType = "Toy Box Source" },
    },
})
