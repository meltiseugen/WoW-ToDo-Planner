local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("3.0.8", "mounts", {
    entries = {
        {
            acquisition = "Obtain Blue Dragonhawk from Mountain o' Mounts for Alliance.",
            category = "Achievements",
            name = "Blue Dragonhawk",
            source = "Mountain o' Mounts for Alliance",
            spellId = 61996,
            tips = "Collect 100 mounts on one character under the original achievement rules.",
        },
        {
            acquisition = "Obtain Red Dragonhawk from Mountain o' Mounts for Horde.",
            category = "Achievements",
            name = "Red Dragonhawk",
            source = "Mountain o' Mounts for Horde",
            spellId = 61997,
            tips = "Collect 100 mounts on one character under the original achievement rules.",
        },
    },
    details = {
        ["Blue Dragonhawk"] = {
            acquisition = "Obtain Blue Dragonhawk from Mountain o' Mounts for Alliance.",
            category = "Achievements",
            source = "Mountain o' Mounts for Alliance",
            sourceType = "Patch mount collection",
            tips = "Collect 100 mounts on one character under the original achievement rules.",
        },
        ["Red Dragonhawk"] = {
            acquisition = "Obtain Red Dragonhawk from Mountain o' Mounts for Horde.",
            category = "Achievements",
            source = "Mountain o' Mounts for Horde",
            sourceType = "Patch mount collection",
            tips = "Collect 100 mounts on one character under the original achievement rules.",
        },
    },
})
