local _, TDP = ...

local shared = {}
shared["Drop: Broken Isles Fishing"] = {
    acquisition = "Obtain this toy from the listed source: Drop: Broken Isles Fishing.",
    source = "Drop: Broken Isles Fishing",
    sourceType = "Toy Box Source",
    tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
}

shared["Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 "] = {
    acquisition = "Obtain this toy from the listed source: Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency.",
    source = "Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency",
    sourceType = "Toy Box Source",
    tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
    waypoints = { "/way #627 45.6 62.8 Krasus' Landing" },
}

shared["Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency"] = {
    acquisition = "Obtain this toy from the listed source: Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency.",
    source = "Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency",
    sourceType = "Toy Box Source",
    tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
}

shared["Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency"] = {
    acquisition = "Obtain this toy from the listed source: Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency.",
    source = "Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency",
    sourceType = "Toy Box Source",
    tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
}

TDP.CatalogRegistry:RegisterCollection("7.2.5", "toys", {
    entries = {
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Treasure Master Iks'reeged / Zone: Broken Shore / Cost: 50000 currency.",
            itemId = 142452,
            name = "Lingering Wyrmtongue Essence",
            source = "Vendor: Treasure Master Iks'reeged / Zone: Broken Shore / Cost: 50000 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Impus / Zone: Broken Shore / Profession: Fishing / Reputation: Impus - Best Friend.",
            itemId = 147312,
            name = "Demon Noggin",
            source = "Vendor: Impus / Zone: Broken Shore / Profession: Fishing / Reputation: Impus - Best Friend",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Treasure: Sheddle's Chest.",
            itemId = 129055,
            name = "Shoe Shine Kit",
            source = "Treasure: Sheddle's Chest",
            tips = "Check prerequisites and the source's daily or weekly lockout before starting; several Legion collectibles require campaign progress or repeat attempts.",
        },
        {
            acquisition = "Earn the Legion Season 4 Prestige pennant reward.",
            itemId = 134034,
            name = "Esteemed Pennant",
            source = "Player vs. Player: Legion Season 4 Prestige reward",
            tips = "This is a historical Prestige reward and may no longer be obtainable from its original source.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Cupri / Zone: Shattrath City / Cost: 750 currency.",
            itemId = 151016,
            name = "Fractured Necrolyte Skull",
            source = "Vendor: Cupri / Zone: Shattrath City / Cost: 750 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Cupri / Zone: Shattrath City / Cost: 500 currency.",
            itemId = 151184,
            name = "Verdant Throwing Sphere",
            source = "Vendor: Cupri / Zone: Shattrath City / Cost: 500 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Drop: Broken Isles Fishing.",
            itemId = 142528,
            name = "Crate of Bobbers: Can of Worms",
            source = "Drop: Broken Isles Fishing",
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Drop: Broken Isles Fishing.",
            itemId = 142529,
            name = "Crate of Bobbers: Cat Head",
            source = "Drop: Broken Isles Fishing",
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Drop: Broken Isles Fishing.",
            itemId = 142530,
            name = "Crate of Bobbers: Tugboat",
            source = "Drop: Broken Isles Fishing",
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency.",
            itemId = 142531,
            name = "Crate of Bobbers: Squeaky Duck",
            source = "Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #627 45.6 62.8 Krasus' Landing" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency.",
            itemId = 142532,
            name = "Crate of Bobbers: Murloc Head",
            source = "Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #627 45.6 62.8 Krasus' Landing" },
        },
        {
            acquisition = "Obtain this toy from the listed source: Drop: Broken Isles Fishing.",
            itemId = 143662,
            name = "Crate of Bobbers: Wooden Pepe",
            source = "Drop: Broken Isles Fishing",
            tips = "Check the source's loot lockout before farming. Argus rares rotate and many drops are not guaranteed, so use eligible alts when practical.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency.",
            itemId = 150743,
            name = "Surviving Kalimdor",
            source = "Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency.",
            itemId = 150744,
            name = "Walking Kalimdor with the Earthmother",
            source = "Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency.",
            itemId = 150745,
            name = "The Azeroth Campaign",
            source = "Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency.",
            itemId = 150746,
            name = "To Modernize the Provisioning of Azeroth",
            source = "Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        {
            acquisition = "Obtain this toy from the listed source: Pickpocketing.",
            itemId = 151877,
            name = "Barrel of Eyepatches",
            source = "Pickpocketing",
            tips = "Check prerequisites and the source's daily or weekly lockout before starting; several Legion collectibles require campaign progress or repeat attempts.",
        },
    },
    details = {
        ["Barrel of Eyepatches"] = {
            acquisition = "Obtain this toy from the listed source: Pickpocketing.",
            source = "Pickpocketing",
            sourceType = "Toy Box Source",
            tips = "Check prerequisites and the source's daily or weekly lockout before starting; several Legion collectibles require campaign progress or repeat attempts.",
        },
        ["Crate of Bobbers: Can of Worms"] = shared["Drop: Broken Isles Fishing"],
        ["Crate of Bobbers: Cat Head"] = shared["Drop: Broken Isles Fishing"],
        ["Crate of Bobbers: Murloc Head"] = shared["Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 "],
        ["Crate of Bobbers: Squeaky Duck"] = shared["Vendor: Conjurer Margoss / Zone: Dalaran / Faction: Conjurer Margoss - Friend / Cost: 100 "],
        ["Crate of Bobbers: Tugboat"] = shared["Drop: Broken Isles Fishing"],
        ["Crate of Bobbers: Wooden Pepe"] = shared["Drop: Broken Isles Fishing"],
        ["Demon Noggin"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Impus / Zone: Broken Shore / Profession: Fishing / Reputation: Impus - Best Friend.",
            source = "Vendor: Impus / Zone: Broken Shore / Profession: Fishing / Reputation: Impus - Best Friend",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        ["Esteemed Pennant"] = {
            acquisition = "Earn the Legion Season 4 Prestige pennant reward.",
            source = "Player vs. Player: Legion Season 4 Prestige reward",
            sourceType = "Toy Box Source",
            tips = "This is a historical Prestige reward and may no longer be obtainable from its original source.",
        },
        ["Fractured Necrolyte Skull"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Cupri / Zone: Shattrath City / Cost: 750 currency.",
            source = "Vendor: Cupri / Zone: Shattrath City / Cost: 750 currency",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        ["Lingering Wyrmtongue Essence"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Treasure Master Iks'reeged / Zone: Broken Shore / Cost: 50000 currency.",
            source = "Vendor: Treasure Master Iks'reeged / Zone: Broken Shore / Cost: 50000 currency",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
            waypoints = { "/way #646 44.5 63.2 Deliverance Point" },
        },
        ["Shoe Shine Kit"] = {
            acquisition = "Obtain this toy from the listed source: Treasure: Sheddle's Chest.",
            source = "Treasure: Sheddle's Chest",
            sourceType = "Toy Box Source",
            tips = "Check prerequisites and the source's daily or weekly lockout before starting; several Legion collectibles require campaign progress or repeat attempts.",
        },
        ["Surviving Kalimdor"] = shared["Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency"],
        ["The Azeroth Campaign"] = shared["Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency"],
        ["To Modernize the Provisioning of Azeroth"] = shared["Vendor: Krom Stoutarm / Zone: Ironforge / Cost: 10000 currency"],
        ["Verdant Throwing Sphere"] = {
            acquisition = "Obtain this toy from the listed source: Vendor: Cupri / Zone: Shattrath City / Cost: 500 currency.",
            source = "Vendor: Cupri / Zone: Shattrath City / Cost: 500 currency",
            sourceType = "Toy Box Source",
            tips = "Confirm the reputation, currency, and vendor phase before travelling. Some Legion rewards also require completion of the relevant campaign.",
        },
        ["Walking Kalimdor with the Earthmother"] = shared["Vendor: Estelle Gendry / Zone: Undercity / Cost: 10000 currency"],
    },
})
