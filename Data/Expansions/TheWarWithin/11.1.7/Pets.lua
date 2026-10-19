local _, TDP = ...

local shared = {}
shared["Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth "] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth Timewalking",
    sourceType = "Pet Journal Source",
}

TDP.CatalogRegistry:RegisterCollection("11.1.7", "pets", {
    entries = {
        { name = "Flotsam Harvester", npcId = 245545, source = "Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth Timewalking", speciesId = 4849 },
        { name = "Lil' Daz'ti", npcId = 245647, source = "Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth Timewalking", speciesId = 4852 },
    },
    details = {
        ["Flotsam Harvester"] = shared["Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth "],
        ["Lil' Daz'ti"] = shared["Vendor: Churbro / Zone: Zuldazar / Zone: Boralus Harbor / World Event: Battle for Azeroth "],
    },
})
