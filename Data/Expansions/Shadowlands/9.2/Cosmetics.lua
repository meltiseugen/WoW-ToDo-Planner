local _, TDP = ...

local shared = {}
shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"] = {
    acquisition = "Buy the rotating Mawsworn cosmetic weapon from the broker on floor 3 or floor 6 during a Layers 13-16 Torghast run.",
    cost = "300 Phantasma during the run.",
    source = "Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16",
    sourceType = "Torghast Vendor",
}

shared["Enlightened Broker Supplies"] = {
    acquisition = "After reaching Exalted with The Enlightened, earn another 10,000 reputation and open Enlightened Broker Supplies for a chance at this cosmetic cloak.",
    source = "Enlightened Broker Supplies",
    sourceType = "Paragon Cache",
    waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" },
}

shared["Enlightened Broker Supplies 2"] = {
    acquisition = "After reaching Exalted with The Enlightened, earn another 10,000 reputation and open Enlightened Broker Supplies for a chance at this cosmetic weapon.",
    source = "Enlightened Broker Supplies",
    sourceType = "Paragon Cache",
    waypoints = { "/way #1970 34.8 64.8 Vilo / Haven" },
}

shared["Domination Cache / Zereth Mortis"] = {
    acquisition = "Loot a Dominance Key from Mawsworn elites in the northeast desert, then open the one-time Domination Cache for the guaranteed greatsword.",
    source = "Domination Cache / Zereth Mortis",
    sourceType = "Treasure",
    waypoints = { "/way #1970 60.0 28.0 Mawsworn desert / Dominance Key and cache area" },
}

TDP.CatalogRegistry:RegisterCollection("9.2", "cosmetics", {
    entries = {
        { detailKey = "torghastMawswornWeapons", itemId = 188737, name = "Ebon Mawsworn Crossbow", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188743, name = "Ashen Mawsworn Crossbow", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188744, name = "Ebon Mawsworn Maul", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188745, name = "Ashen Mawsworn Maul", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188746, name = "Ebon Mawsworn Halberd", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188747, name = "Ashen Mawsworn Halberd", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188748, name = "Ebon Mawsworn Staff", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188749, name = "Ashen Mawsworn Staff", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188750, name = "Burnished Mawsworn Greatsword", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188752, name = "Argent Mawsworn Greatsword", subtype = "appearance" },
        { detailKey = "torghastMawswornWeapons", itemId = 188753, name = "Gilded Mawsworn Greatsword", subtype = "appearance" },
        { detailKey = "dominationCache", itemId = 190638, name = "Tormented Mawsteel Greatsword", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190928, name = "Sandtails Drape", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190929, name = "Ebony Protocloak", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190930, name = "Dark Shawl of the Enlightened", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190931, name = "Cape of the Regal Wanderer", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190932, name = "Protohide Drape", subtype = "appearance" },
        { detailKey = "enlightenedParagonCloaks", itemId = 190933, name = "Majestic Oracle's Drape", subtype = "appearance" },
        { detailKey = "enlightenedParagonWeapons", itemId = 190934, name = "Standard of the Wandering Brokers", subtype = "appearance" },
        { detailKey = "enlightenedParagonWeapons", itemId = 190937, name = "Edge of the Enlightened", subtype = "appearance" },
        { detailKey = "enlightenedParagonWeapons", itemId = 190939, name = "Walking Staff of the Enlightened Journey", subtype = "appearance" },
        { detailKey = "enlightenedParagonWeapons", itemId = 190951, name = "Distinguished Blade of Cartel Al", subtype = "appearance" },
    },
    details = {
        ["Argent Mawsworn Greatsword"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ashen Mawsworn Crossbow"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ashen Mawsworn Halberd"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ashen Mawsworn Maul"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ashen Mawsworn Staff"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Burnished Mawsworn Greatsword"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Cape of the Regal Wanderer"] = shared["Enlightened Broker Supplies"],
        ["Dark Shawl of the Enlightened"] = shared["Enlightened Broker Supplies"],
        ["Distinguished Blade of Cartel Al"] = shared["Enlightened Broker Supplies 2"],
        ["Ebon Mawsworn Crossbow"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ebon Mawsworn Halberd"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ebon Mawsworn Maul"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ebon Mawsworn Staff"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Ebony Protocloak"] = shared["Enlightened Broker Supplies"],
        ["Edge of the Enlightened"] = shared["Enlightened Broker Supplies 2"],
        ["Gilded Mawsworn Greatsword"] = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
        ["Majestic Oracle's Drape"] = shared["Enlightened Broker Supplies"],
        ["Protohide Drape"] = shared["Enlightened Broker Supplies"],
        ["Sandtails Drape"] = shared["Enlightened Broker Supplies"],
        ["Standard of the Wandering Brokers"] = shared["Enlightened Broker Supplies 2"],
        ["Tormented Mawsteel Greatsword"] = shared["Domination Cache / Zereth Mortis"],
        ["Walking Staff of the Enlightened Journey"] = shared["Enlightened Broker Supplies 2"],
        dominationCache = shared["Domination Cache / Zereth Mortis"],
        enlightenedParagonCloaks = shared["Enlightened Broker Supplies"],
        enlightenedParagonWeapons = shared["Enlightened Broker Supplies 2"],
        torghastMawswornWeapons = shared["Broker Ve'ken and Broker Ve'nott / Torghast Layers 13-16"],
    },
})
