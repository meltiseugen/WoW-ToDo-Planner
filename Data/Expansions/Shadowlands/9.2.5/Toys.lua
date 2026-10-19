local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("9.2.5", "toys", {
    entries = { { itemId = 192099, name = "Earpieces of Tranquil Focus" }, { itemId = 192485, name = "Stored Wisdom Device" } },
    details = {
        ["Earpieces of Tranquil Focus"] = {
            acquisition = "Buy the toy from Craggle Wobbletop, Blax Bottlerocket, Jepetto Joybuzz, or another permanent toy vendor.",
            source = "Toy vendors in major cities",
            sourceType = "Vendor",
        },
        ["Stored Wisdom Device"] = {
            acquisition = "Finish the Zereth Mortis epilogue and Ve'nari progression, inspect Ve'nari's body at the Creation Catalyst, then wait for her in-game mail.",
            source = "Ve'nari's epilogue",
            sourceType = "Mail Reward",
            waypoints = { "/way #1970 47.0 88.0 Ve'nari's body / Creation Catalyst" },
        },
    },
})
