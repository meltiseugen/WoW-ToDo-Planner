local _, TDP = ...

local shared = {}
shared["Event: Dastardly Duos"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Event: Dastardly Duos", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("11.1.5", "toys", {
    entries = {
        { itemId = 238852, name = "Flame's Radiance Banner", source = "Vendor: Lars Bronsmaelt / Zone: Hallowfall / Cost: 5000" },
        { itemId = 239007, name = "Dastardly Banner", source = "Event: Dastardly Duos" },
        { itemId = 239018, name = "Winner's Podium", source = "Event: Dastardly Duos" },
        { itemId = 167698, name = "Secret Fish Goggles", source = "Vendor: Danielle Anglers / Zone: Mechagon / Cost: 10" },
    },
    details = {
        ["Dastardly Banner"] = shared["Event: Dastardly Duos"],
        ["Flame's Radiance Banner"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Lars Bronsmaelt / Zone: Hallowfall / Cost: 5000", sourceType = "Toy Box Source" },
        ["Secret Fish Goggles"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Danielle Anglers / Zone: Mechagon / Cost: 10", sourceType = "Toy Box Source" },
        ["Winner's Podium"] = shared["Event: Dastardly Duos"],
    },
})
