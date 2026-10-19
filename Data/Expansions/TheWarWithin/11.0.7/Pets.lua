local _, TDP = ...

local shared = {}
shared["Pet Battle: Siren Isle"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Pet Battle: Siren Isle", sourceType = "Pet Journal Source" }

shared["Special Event: Plunderstorm"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Special Event: Plunderstorm", sourceType = "Pet Journal Source" }

TDP.CatalogRegistry:RegisterCollection("11.0.7", "pets", {
    entries = {
        { name = "Tidal Kroling", npcId = 230394, source = "Pet Battle: Siren Isle", speciesId = 4628 },
        { name = "Sparklesnap", npcId = 233797, source = "Special Event: Plunderstorm", speciesId = 4692 },
        { name = "Parley", npcId = 233967, source = "Special Event: Plunderstorm", speciesId = 4695 },
        { name = "Rusty Kroling", npcId = 234097, source = "Pet Battle: Siren Isle", speciesId = 4702 },
        { name = "Cave Kroling", npcId = 234101, source = "Pet Battle: Siren Isle", speciesId = 4703 },
        { name = "Marmaduke", npcId = 234365, source = "Discovery: Siren Isle", speciesId = 4708 },
        { name = "Pillaged Parrot", npcId = 234367, source = "Pet Battle: Siren Isle", speciesId = 4710 },
        { name = "Snapdragon Pup", npcId = 234369, source = "Pet Battle: Siren Isle", speciesId = 4711 },
        { name = "Cliffreach Cub", npcId = 234710, source = "Pet Battle: Siren Isle", speciesId = 4723 },
        { name = "Battleboar Piglet", npcId = 234734, source = "Pet Battle: Siren Isle", speciesId = 4724 },
        { name = "Titan Orb", npcId = 234908, source = "Zone: Siren Isle", speciesId = 4725 },
        { name = "Crackleroar", npcId = 235124, source = "Zone: Siren Isle / Drop: Stormtouched Pridetalon", speciesId = 4726 },
        { name = "Skitterbite", npcId = 235130, source = "Vendor: Soweezi / Zone: Siren Isle / Cost: 750", speciesId = 4727 },
        { name = "Storm-Infused Snapdragon", npcId = 236040, source = "Pet Battle: Siren Isle: Seafury Tempest", speciesId = 4731 },
        { name = "Scavenging Snapdragon", npcId = 236041, source = "Pet Battle: Siren Isle, Seafury Tempest", speciesId = 4732 },
    },
    details = {
        ["Battleboar Piglet"] = shared["Pet Battle: Siren Isle"],
        ["Cave Kroling"] = shared["Pet Battle: Siren Isle"],
        ["Cliffreach Cub"] = shared["Pet Battle: Siren Isle"],
        Crackleroar = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Zone: Siren Isle / Drop: Stormtouched Pridetalon",
            sourceType = "Pet Journal Source",
        },
        Marmaduke = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Discovery: Siren Isle", sourceType = "Pet Journal Source" },
        Parley = shared["Special Event: Plunderstorm"],
        ["Pillaged Parrot"] = shared["Pet Battle: Siren Isle"],
        ["Rusty Kroling"] = shared["Pet Battle: Siren Isle"],
        ["Scavenging Snapdragon"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Pet Battle: Siren Isle, Seafury Tempest", sourceType = "Pet Journal Source" },
        Skitterbite = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Soweezi / Zone: Siren Isle / Cost: 750",
            sourceType = "Pet Journal Source",
        },
        ["Snapdragon Pup"] = shared["Pet Battle: Siren Isle"],
        Sparklesnap = shared["Special Event: Plunderstorm"],
        ["Storm-Infused Snapdragon"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Pet Battle: Siren Isle: Seafury Tempest", sourceType = "Pet Journal Source" },
        ["Tidal Kroling"] = shared["Pet Battle: Siren Isle"],
        ["Titan Orb"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Zone: Siren Isle", sourceType = "Pet Journal Source" },
    },
})
