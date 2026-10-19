local _, TDP = ...

local shared = {}
shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("11.2", "toys", {
    entries = {
        { itemId = 242323, name = "Chowdar's Favorite Ribbon", source = "Drop: \"Chowdar\" / Zone: K'aresh" },
        { itemId = 245567, name = "K'aresh Memory Crystal", source = "Quest: Veni Vidi Ve'nari / Zone: Telogrus Rift" },
        { itemId = 246903, name = "Guise of the Phase Diver", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3" },
        { itemId = 246905, name = "Overtuned K'areshi Goggles", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3" },
        { itemId = 246908, name = "K'areshi Supply Crate", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3" },
        { itemId = 246907, name = "Broker Supply Crate", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3" },
        { itemId = 250722, name = "Ethereal Stall", source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 3" },
    },
    details = {
        ["Broker Supply Crate"] = shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"],
        ["Chowdar's Favorite Ribbon"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Drop: \"Chowdar\" / Zone: K'aresh", sourceType = "Toy Box Source" },
        ["Ethereal Stall"] = shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"],
        ["Guise of the Phase Diver"] = shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"],
        ["K'aresh Memory Crystal"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Quest: Veni Vidi Ve'nari / Zone: Telogrus Rift", sourceType = "Toy Box Source" },
        ["K'areshi Supply Crate"] = shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"],
        ["Overtuned K'areshi Goggles"] = shared["Vendor: Shad'anis / Zone: K'aresh / Cost: 3"],
    },
})
