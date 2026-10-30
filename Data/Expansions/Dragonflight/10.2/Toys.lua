local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2", "toys", {
    entries = {
        { itemId = 205463, name = "Molten Lava Ball", source = "Drop: Moltenbinder's Disciple / Zone: Emerald Dream" },
        { itemId = 207092, name = "Portable Party Platter", source = "Profession: Dragon Isles Engineering" },
        { itemId = 208798, name = "Recorded Memories of Tyr's Guard", source = "Quest: Disc Delivery / Zone: Thaldraszus" },
        { itemId = 209859, name = "Festive Trans-Dimensional Bird Whistle", source = "Drop: The Abominable Greench / Zone: Hillsbrad Foothills" },
        { itemId = 210411, name = "Fast Growing Seed", source = "Treasure: Pineshrew Cache / Zone: Emerald Dream" },
        { itemId = 210725, name = "Owl Post", source = "Drop: Hidden Moonkin Stash / Zone: Emerald Dream" },
        { itemId = 210864, name = "Improvised Leafbed", source = "Quest: Sleepy Druid in Emerald Dream" },
    },
    details = {
        ["Fast Growing Seed"] = { source = "Treasure: Pineshrew Cache / Zone: Emerald Dream", sourceType = "Toy Box Source" },
        ["Festive Trans-Dimensional Bird Whistle"] = { source = "Drop: The Abominable Greench / Zone: Hillsbrad Foothills", sourceType = "Toy Box Source" },
        ["Improvised Leafbed"] = { source = "Quest: Sleepy Druid in Emerald Dream", sourceType = "Toy Box Source" },
        ["Molten Lava Ball"] = { source = "Drop: Moltenbinder's Disciple / Zone: Emerald Dream", sourceType = "Toy Box Source" },
        ["Owl Post"] = { source = "Drop: Hidden Moonkin Stash / Zone: Emerald Dream", sourceType = "Toy Box Source" },
        ["Portable Party Platter"] = { source = "Profession: Dragon Isles Engineering", sourceType = "Toy Box Source" },
        ["Recorded Memories of Tyr's Guard"] = { source = "Quest: Disc Delivery / Zone: Thaldraszus", sourceType = "Toy Box Source" },
    },
})
