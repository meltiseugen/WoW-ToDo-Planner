local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.2.7", "toys", {
    entries = {
        { itemId = 210455, name = "Draenic Hologem", source = "Draenei Heritage Questline / Quest: Our Path Forward" },
        { itemId = 223146, name = "Satchel of Stormborn Seeds", source = "Quest: Sins of the Sister" },
    },
    details = {
        ["Draenic Hologem"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Draenei Heritage Questline / Quest: Our Path Forward", sourceType = "Toy Box Source" },
        ["Satchel of Stormborn Seeds"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Quest: Sins of the Sister", sourceType = "Toy Box Source" },
    },
})
