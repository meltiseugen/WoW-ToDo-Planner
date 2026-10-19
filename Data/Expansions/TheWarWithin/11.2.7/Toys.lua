local _, TDP = ...

local shared = {}
shared["Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("11.2.7", "toys", {
    entries = {
        { itemId = 242520, name = "Festival Hot Air Balloon", source = "World Quest: A Tradition / Zone: The Wandering Isle" },
        { itemId = 256881, name = "Steward's Bauble", source = "Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750" },
        { itemId = 256893, name = "Wretched Dredger's Brand", source = "Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750" },
    },
    details = {
        ["Festival Hot Air Balloon"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "World Quest: A Tradition / Zone: The Wandering Isle", sourceType = "Toy Box Source" },
        ["Steward's Bauble"] = shared["Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750"],
        ["Wretched Dredger's Brand"] = shared["Vendor: Collector Ta'steld / Zone: Oribos / Cost: 750"],
    },
})
