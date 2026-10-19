local _, TDP = ...

local shared = {}
shared["Aridormi / Dalaran"] = {
    acquisition = "During Legion Timewalking, buy the Replica Aegis of Aggramar or Ensemble: Ravencrest's Battleplate from Aridormi with Timewarped Badges.",
    source = "Aridormi / Dalaran",
    sourceType = "Legion Timewalking Vendor",
    waypoints = { "/way #627 68.6 49.2 Aridormi / Legion Timewalking" },
}

TDP.CatalogRegistry:RegisterCollection("9.1.5", "cosmetics", {
    entries = {
        { detailKey = "legionTimewalkingCosmetics", itemId = 187562, name = "Replica Aegis of Aggramar", subtype = "appearance" },
        { detailKey = "legionTimewalkingCosmetics", itemId = 188209, name = "Ensemble: Ravencrest's Battleplate", subtype = "appearance" },
    },
    details = {
        ["Ensemble: Ravencrest's Battleplate"] = shared["Aridormi / Dalaran"],
        ["Replica Aegis of Aggramar"] = shared["Aridormi / Dalaran"],
        legionTimewalkingCosmetics = shared["Aridormi / Dalaran"],
    },
})
