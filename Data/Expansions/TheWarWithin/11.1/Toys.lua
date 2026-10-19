local _, TDP = ...

local shared = {}
shared["Vendor: Blair Bass / Zone: Undermine / Cost: 5"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Blair Bass / Zone: Undermine / Cost: 5", sourceType = "Toy Box Source" }

shared["Vendor: Rocco Razzboom / Zone: Undermine"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Rocco Razzboom / Zone: Undermine", sourceType = "Toy Box Source" }

shared["Vendor: Boatswain Hardee / Zone: Undermine"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Boatswain Hardee / Zone: Undermine", sourceType = "Toy Box Source" }

shared["Vendor: Shredz the Scrapper / Zone: Undermine"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Shredz the Scrapper / Zone: Undermine", sourceType = "Toy Box Source" }

TDP.CatalogRegistry:RegisterCollection("11.1", "toys", {
    entries = {
        { itemId = 233202, name = "G.O.L.E.M, Jr.", source = "Quest: Showdown in the Attic / Zone: Undermine" },
        { itemId = 234950, name = "Atomic Regoblinator", source = "Vendor: Sitch Lowdown / Zone: Undermine" },
        { itemId = 234951, name = "Uncracked Cold Ones", source = "Treasure: Uncracked Cold Ones / Zone: Undermine" },
        { itemId = 235220, name = "Fireworks Hat", source = "Treasure: Fireworks Hat / Zone: Undermine" },
        { itemId = 235670, name = "Bilgewater Cartel Banner", source = "Vendor: Rocco Razzboom / Zone: Undermine" },
        { itemId = 235671, name = "Blackwater Cartel Banner", source = "Vendor: Boatswain Hardee / Zone: Undermine" },
        { itemId = 235669, name = "Steamwheedle Cartel Banner", source = "Vendor: Lab Assistant Laszly / Zone: Undermine" },
        { itemId = 235672, name = "Venture Co. Banner", source = "Vendor: Shredz the Scrapper / Zone: Undermine" },
        { itemId = 235799, name = "Throwin' Sawblade", source = "Vendor: Shredz the Scrapper / Zone: Undermine" },
        { itemId = 235801, name = "Personal Fishing Barge", source = "Vendor: Boatswain Hardee / Zone: Undermine" },
        { itemId = 235807, name = "Storefront-in-a-Box", source = "Vendor: Rocco Razzboom / Zone: Undermine" },
        { itemId = 236769, name = "Gallagio Pipeline Rerouter", source = "Achievement: A Good Day to Dye Hard / Category: War Within Raid" },
        { itemId = 226373, name = "Everlasting Noggenfogger Elixir", source = "Vendor: Lab Assistant Laszly / Zone: Undermine / Cost: 5000" },
        { itemId = 235050, name = "Desk-in-a-Box", source = "Achievement: Read Between the Lines / Category: War Within" },
        { itemId = 237382, name = "Undermine Supply Crate", source = "Vendor: Angelo Rustbin / Zone: Undermine / Cost: 999" },
        { itemId = 237347, name = "Organically-Sourced Wellington Bobber", source = "Vendor: Blair Bass / Zone: Undermine / Cost: 5" },
        { itemId = 237346, name = "Artisan Beverage Goblet Bobber", source = "Vendor: Blair Bass / Zone: Undermine / Cost: 5" },
        { itemId = 237345, name = "Limited Edition Rocket Bobber", source = "Vendor: Blair Bass / Zone: Undermine / Cost: 5" },
    },
    details = {
        ["Artisan Beverage Goblet Bobber"] = shared["Vendor: Blair Bass / Zone: Undermine / Cost: 5"],
        ["Atomic Regoblinator"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Sitch Lowdown / Zone: Undermine", sourceType = "Toy Box Source" },
        ["Bilgewater Cartel Banner"] = shared["Vendor: Rocco Razzboom / Zone: Undermine"],
        ["Blackwater Cartel Banner"] = shared["Vendor: Boatswain Hardee / Zone: Undermine"],
        ["Desk-in-a-Box"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Achievement: Read Between the Lines / Category: War Within", sourceType = "Toy Box Source" },
        ["Everlasting Noggenfogger Elixir"] = {
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
            source = "Vendor: Lab Assistant Laszly / Zone: Undermine / Cost: 5000",
            sourceType = "Toy Box Source",
        },
        ["Fireworks Hat"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Treasure: Fireworks Hat / Zone: Undermine", sourceType = "Toy Box Source" },
        ["G.O.L.E.M, Jr."] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Quest: Showdown in the Attic / Zone: Undermine", sourceType = "Toy Box Source" },
        ["Gallagio Pipeline Rerouter"] = {
            acquisition = "Follow the in-game Toy Box source for this permanent toy.",
            source = "Achievement: A Good Day to Dye Hard / Category: War Within Raid",
            sourceType = "Toy Box Source",
        },
        ["Limited Edition Rocket Bobber"] = shared["Vendor: Blair Bass / Zone: Undermine / Cost: 5"],
        ["Organically-Sourced Wellington Bobber"] = shared["Vendor: Blair Bass / Zone: Undermine / Cost: 5"],
        ["Personal Fishing Barge"] = shared["Vendor: Boatswain Hardee / Zone: Undermine"],
        ["Steamwheedle Cartel Banner"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Lab Assistant Laszly / Zone: Undermine", sourceType = "Toy Box Source" },
        ["Storefront-in-a-Box"] = shared["Vendor: Rocco Razzboom / Zone: Undermine"],
        ["Throwin' Sawblade"] = shared["Vendor: Shredz the Scrapper / Zone: Undermine"],
        ["Uncracked Cold Ones"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Treasure: Uncracked Cold Ones / Zone: Undermine", sourceType = "Toy Box Source" },
        ["Undermine Supply Crate"] = { acquisition = "Follow the in-game Toy Box source for this permanent toy.", source = "Vendor: Angelo Rustbin / Zone: Undermine / Cost: 999", sourceType = "Toy Box Source" },
        ["Venture Co. Banner"] = shared["Vendor: Shredz the Scrapper / Zone: Undermine"],
    },
})
