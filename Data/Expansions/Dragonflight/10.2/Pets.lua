local _, TDP = ...

local shared = {}
shared["Pet Battle: Emerald Dream"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Pet Battle: Emerald Dream", sourceType = "Pet Journal Source" }

shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1",
    sourceType = "Pet Journal Source",
}

shared["Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1"] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1",
    sourceType = "Pet Journal Source",
}

shared["Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375"] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375",
    sourceType = "Pet Journal Source",
}

shared["Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom "] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1",
    sourceType = "Pet Journal Source",
}

TDP.CatalogRegistry:RegisterCollection("10.2", "pets", {
    entries = {
        { name = "Rithro", npcId = 201008, source = "Quest: Mean Green Infusion Machine / Zone: Emerald Dream", speciesId = 3552 },
        { name = "Flooftalon", npcId = 211110, source = "Pet Battle: Emerald Dream", speciesId = 4275 },
        { name = "Fol'ya Pup", npcId = 211177, source = "Pet Battle: Emerald Dream", speciesId = 4276 },
        { name = "Sapnibbler", npcId = 211182, source = "Pet Battle: Emerald Dream", speciesId = 4277 },
        { name = "Leyhart", npcId = 211288, source = "Pet Battle: Emerald Dream", speciesId = 4278 },
        { name = "Slumbertooth", npcId = 211295, source = "Pet Battle: Emerald Dream", speciesId = 4279 },
        { name = "Pewling", npcId = 211302, source = "Pet Battle: Emerald Dream", speciesId = 4280 },
        { name = "Sergeant Quackers", npcId = 211939, source = "Achievement: Ducks In A Row / Category: Dragonflight Raid", speciesId = 4285 },
        { name = "Reverie", npcId = 212192, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4287 },
        { name = "Blueloo", npcId = 212206, source = "Achievement: Friends in Feathers", speciesId = 4288 },
        { name = "Dreamborne Scarab", npcId = 212267, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4289 },
        { name = "Dreamhoof", npcId = 212273, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4290 },
        { name = "Ivy", npcId = 212275, source = "Achievement: \"Don't Let the Doe Hit You On the Way Out\"", speciesId = 4291 },
        { name = "Memorie", npcId = 212315, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4292 },
        { name = "Napps", npcId = 212328, source = "Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1", speciesId = 4295 },
        {
            name = "Snoozles",
            npcId = 212329,
            source = "Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1",
            speciesId = 4296,
        },
        { name = "Kal'andu", npcId = 212399, source = "Quest: Burning Out / Zone: Emerald Dream", speciesId = 4297 },
        {
            name = "Seedle",
            npcId = 212408,
            source = "Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1",
            speciesId = 4298,
        },
        { name = "Dustite", npcId = 212413, source = "Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1", speciesId = 4299 },
        { name = "Somnolet", npcId = 212417, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4300 },
        { name = "Pale Slumbertooth", npcId = 212437, source = "Pet Battle: Emerald Dream", speciesId = 4302 },
        { name = "Snaggletoof", npcId = 212459, source = "Pet Battle: Emerald Dream", speciesId = 4303 },
        { name = "Dream Badger", npcId = 212557, source = "Pet Battle: Emerald Dream", speciesId = 4304 },
        {
            name = "Snoots",
            npcId = 212562,
            source = "Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1",
            speciesId = 4305,
        },
        { name = "Elmer", npcId = 212567, source = "Vendor: Sylvia Whisperbloom Zone: Emerald Dream Cost: 1 Vendor: Talisa Whisperbloom Zone: Emerald Dream Cost: 1", speciesId = 4306 },
        { name = "Spruce", npcId = 212569, source = "Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375", speciesId = 4307 },
        { name = "Juniper", npcId = 212570, source = "Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375", speciesId = 4308 },
        { name = "Drowsey", npcId = 212877, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4309 },
        { name = "Snorr", npcId = 212954, source = "Vendor: Elianna / Zone: Emerald Dream / Cost: 1", speciesId = 4310 },
    },
    details = {
        Blueloo = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Achievement: Friends in Feathers", sourceType = "Pet Journal Source" },
        ["Dream Badger"] = shared["Pet Battle: Emerald Dream"],
        ["Dreamborne Scarab"] = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Dreamhoof = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Drowsey = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Dustite = shared["Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1"],
        Elmer = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Sylvia Whisperbloom Zone: Emerald Dream Cost: 1 Vendor: Talisa Whisperbloom Zone: Emerald Dream Cost: 1",
            sourceType = "Pet Journal Source",
        },
        Flooftalon = shared["Pet Battle: Emerald Dream"],
        ["Fol'ya Pup"] = shared["Pet Battle: Emerald Dream"],
        Ivy = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: \"Don't Let the Doe Hit You On the Way Out\"",
            sourceType = "Pet Journal Source",
        },
        Juniper = shared["Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375"],
        ["Kal'andu"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Quest: Burning Out / Zone: Emerald Dream", sourceType = "Pet Journal Source" },
        Leyhart = shared["Pet Battle: Emerald Dream"],
        Memorie = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Napps = shared["Vendor: Talisa Whisperbloom / Zone: Emerald Dream / Cost: 1"],
        ["Pale Slumbertooth"] = shared["Pet Battle: Emerald Dream"],
        Pewling = shared["Pet Battle: Emerald Dream"],
        Reverie = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Rithro = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Quest: Mean Green Infusion Machine / Zone: Emerald Dream",
            sourceType = "Pet Journal Source",
        },
        Sapnibbler = shared["Pet Battle: Emerald Dream"],
        Seedle = shared["Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom "],
        ["Sergeant Quackers"] = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Ducks In A Row / Category: Dragonflight Raid",
            sourceType = "Pet Journal Source",
        },
        Slumbertooth = shared["Pet Battle: Emerald Dream"],
        Snaggletoof = shared["Pet Battle: Emerald Dream"],
        Snoots = shared["Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom "],
        Snoozles = shared["Vendor: Sylvia Whisperbloom / Zone: Emerald Dream / Cost: 1 / Vendor: Talisa Whisperbloom "],
        Snorr = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Somnolet = shared["Vendor: Elianna / Zone: Emerald Dream / Cost: 1"],
        Spruce = shared["Vendor: Moon Priestess Lasara / Zone: Emerald Dream / Cost: 375"],
    },
})
