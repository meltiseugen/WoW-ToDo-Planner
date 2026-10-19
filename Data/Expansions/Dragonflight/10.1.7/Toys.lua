local _, TDP = ...

local shared = {}
shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"] = {
    acquisition = "Follow the in-game Toy Box source for this permanent toy.",
    source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 500",
    sourceType = "Toy Box Source",
}

shared["World Event: Secrets of Azeroth"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "World Event: Secrets of Azeroth", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("10.1.7", "toys", {
    entries = {
        { itemId = 206696, name = "Tricked-Out Thinking Cap", source = "World Event: Secrets of Azeroth" },
        { itemId = 208092, name = "Torch of Pyrreth", source = "World Event: Secrets of Azeroth" },
        { itemId = 207730, name = "Idol of Ohn'ahra", source = "World Event: Secrets of Azeroth" },
        { itemId = 208421, name = "Compendium of the New Moon", source = "Achievement: Best Stellar / Category: Inscription" },
        { itemId = 208433, name = "Bronze Racer's Pennant", source = "Achievement: Dragonriding Challenge: Dragon Isles: Bronze" },
        { itemId = 208658, name = "Mirror of Humility", source = "Quest: Proof and Promise / Zone: Krokuun" },
        {
            itemId = 209944,
            name = "Friendsurge Defenders",
            source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 500",
        },
        {
            itemId = 209858,
            name = "Dreamsurge Remnant",
            source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 500",
        },
    },
    details = {
        ["Bronze Racer's Pennant"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Achievement: Dragonriding Challenge: Dragon Isles: Bronze", sourceType = "Toy Box Source" },
        ["Compendium of the New Moon"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Achievement: Best Stellar / Category: Inscription", sourceType = "Toy Box Source" },
        ["Dreamsurge Remnant"] = shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"],
        ["Friendsurge Defenders"] = shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"],
        ["Idol of Ohn'ahra"] = shared["World Event: Secrets of Azeroth"],
        ["Mirror of Humility"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Quest: Proof and Promise / Zone: Krokuun", sourceType = "Toy Box Source" },
        ["Torch of Pyrreth"] = shared["World Event: Secrets of Azeroth"],
        ["Tricked-Out Thinking Cap"] = shared["World Event: Secrets of Azeroth"],
    },
})
