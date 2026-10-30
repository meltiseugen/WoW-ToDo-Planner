local _, TDP = ...

local shared = {}
shared["Drop: Vibrating Box / Zone: K'aresh"] = { source = "Drop: Vibrating Box / Zone: K'aresh", sourceType = "Pet Journal Source" }

TDP.CatalogRegistry:RegisterCollection("11.2", "pets", {
    entries = {
        { name = "Ixthal the Observling", npcId = 244263, source = "Zone: K'aresh", speciesId = 4813 },
        { name = "Veridian Thorntail", npcId = 245215, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4825 },
        { name = "Scrappy Thorntail", npcId = 245217, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4826 },
        { name = "Dread Horrorling", npcId = 245474, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4827 },
        { name = "Impartial Watcher", npcId = 245475, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4828 },
        { name = "Penumbral Terror", npcId = 245476, source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 4", speciesId = 4829 },
        { name = "Looker Gaz'kreth Jr.", npcId = 245479, source = "Faction: Manaforge Vandals / Renown: 13 / Location: Shadow Point", speciesId = 4832 },
        { name = "Xanthous Siphonmite", npcId = 245480, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4833 },
        { name = "Jimmy", npcId = 245481, source = "Drop: Morgil the Netherspawn / Zone: K'aresh", speciesId = 4834 },
        { name = "Cyan Siphonmite", npcId = 245482, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4835 },
        { name = "Vitriolic Inchshifter", npcId = 245494, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4836 },
        { name = "Palek'ti, the Mouth of Nothingness", npcId = 245496, source = "Drop: Malek'ta / Zone: K'aresh", speciesId = 4838 },
        { name = "Shimmering Inchshifter", npcId = 245497, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4839 },
        { name = "Graceful Cosmic Ray Pup", npcId = 245498, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4840 },
        { name = "Duskthief", npcId = 245500, source = "Drop: The Nightreaver / Zone: K'aresh", speciesId = 4842 },
        { name = "Sao'rhon", npcId = 245501, source = "Drop: Ethereal Delve's Heavy Trunk", speciesId = 4843 },
        { name = "Inquisitive Cosmic Ray Pup", npcId = 245502, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4844 },
        { name = "Mr. Long-Legs", npcId = 245503, source = "Treasure: Ancient Coffer / Zone: K'aresh", speciesId = 4845 },
        { name = "Heka'Tarnos, Bringer of Discord", npcId = 245504, source = "Drop: Heka'tamos / Zone: K'aresh", speciesId = 4846 },
        { name = "Copper Lapbug", npcId = 245505, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4847 },
        { name = "Cerulean Lapbug", npcId = 245506, source = "Drop: Vibrating Box / Zone: K'aresh", speciesId = 4848 },
        { name = "Zo'ya", npcId = 247463, source = "Faction: Manaforge Vandals / Renown: 8 / Location: Shadow Point", speciesId = 4859 },
    },
    details = {
        ["Cerulean Lapbug"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Copper Lapbug"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Cyan Siphonmite"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Dread Horrorling"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        Duskthief = { source = "Drop: The Nightreaver / Zone: K'aresh", sourceType = "Pet Journal Source" },
        ["Graceful Cosmic Ray Pup"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Heka'Tarnos, Bringer of Discord"] = { source = "Drop: Heka'tamos / Zone: K'aresh", sourceType = "Pet Journal Source" },
        ["Impartial Watcher"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Inquisitive Cosmic Ray Pup"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Ixthal the Observling"] = { source = "Zone: K'aresh", sourceType = "Pet Journal Source" },
        Jimmy = {
            source = "Drop: Morgil the Netherspawn / Zone: K'aresh",
            sourceType = "Pet Journal Source",
        },
        ["Looker Gaz'kreth Jr."] = {
            source = "Faction: Manaforge Vandals / Renown: 13 / Location: Shadow Point",
            sourceType = "Pet Journal Source",
        },
        ["Mr. Long-Legs"] = { source = "Treasure: Ancient Coffer / Zone: K'aresh", sourceType = "Pet Journal Source" },
        ["Palek'ti, the Mouth of Nothingness"] = { source = "Drop: Malek'ta / Zone: K'aresh", sourceType = "Pet Journal Source" },
        ["Penumbral Terror"] = { source = "Vendor: Shad'anis / Zone: K'aresh / Cost: 4", sourceType = "Pet Journal Source" },
        ["Sao'rhon"] = { source = "Drop: Ethereal Delve's Heavy Trunk", sourceType = "Pet Journal Source" },
        ["Scrappy Thorntail"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Shimmering Inchshifter"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Veridian Thorntail"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Vitriolic Inchshifter"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Xanthous Siphonmite"] = shared["Drop: Vibrating Box / Zone: K'aresh"],
        ["Zo'ya"] = {
            source = "Faction: Manaforge Vandals / Renown: 8 / Location: Shadow Point",
            sourceType = "Pet Journal Source",
        },
    },
})
