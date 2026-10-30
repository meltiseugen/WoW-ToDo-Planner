local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("11.2.5", "toys", {
    entries = {
        {
            itemId = 141605,
            name = "Flight Master's Whistle",
            source = "Quest: Uniting the Isles / Zone: Dalaran / Quest: Uniting Kul Tiras / Zone: Tiragarde Sound / Quest: Uniting Zandalar / Zone: Zuldazar",
        },
        { itemId = 131717, name = "Starlight Beacon", source = "Quest: A Beacon of Hope / Zone: Azsuna / Zone: Val'sharah / Zone: Suramar" },
        { itemId = 138111, name = "Stormforged Grapple Launcher", source = "Quest: Stormforged Grapple Launcher / Zone: Stormheim" },
    },
    details = {
        ["Flight Master's Whistle"] = {
            source = "Quest: Uniting the Isles / Zone: Dalaran / Quest: Uniting Kul Tiras / Zone: Tiragarde Sound / Quest: Uniting Zandalar / Zone: Zuldazar",
            sourceType = "Toy Box Source",
        },
        ["Starlight Beacon"] = {
            source = "Quest: A Beacon of Hope / Zone: Azsuna / Zone: Val'sharah / Zone: Suramar",
            sourceType = "Toy Box Source",
        },
        ["Stormforged Grapple Launcher"] = { source = "Quest: Stormforged Grapple Launcher / Zone: Stormheim", sourceType = "Toy Box Source" },
    },
})
