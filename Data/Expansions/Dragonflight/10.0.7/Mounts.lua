local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("10.0.7", "mounts", {
    entries = {
        { itemId = 204382, name = "Noble Bruffalon", spellId = 349935 },
        { itemId = 192772, name = "Ancient Salamanther", spellId = 374090 },
        { itemId = 192785, name = "Gooey Snailemental", spellId = 374157 },
        { itemId = 192790, name = "Mossy Mammoth", spellId = 374194 },
    },
    details = {
        ["Ancient Salamanther"] = {
            acquisition = "Defeat Forbidden Reach rare enemies for a chance at the mount.",
            category = "Rare Drops",
            source = "Forbidden Reach rares",
            sourceType = "Rare drop",
            waypoints = { "/way #2151 35.8 59.6 Morqut Village / rare-farming hub" },
        },
        ["Gooey Snailemental"] = {
            acquisition = "Collect 50 Leftover Elemental Slime from the Froststone Vault Primal Storm boss and combine them.",
            category = "Events",
            source = "Froststone Vault Primal Storm",
            sourceType = "Primal Storm collection",
            waypoints = { "/way #2151 59.0 38.0 Froststone Vault" },
        },
        ["Mossy Mammoth"] = {
            acquisition = "Combine the Zskera Vault mammoth-puzzle reagents in sequence, ending with the Sleeping Ancient Mammoth and Emerald Dragon Brooch.",
            category = "Treasures",
            source = "Zskera Vaults",
            sourceType = "Zskera Vault puzzle",
            waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" },
        },
        ["Noble Bruffalon"] = {
            acquisition = "Buy for 100,000 Elemental Overflow.",
            category = "Vendor",
            source = "Storykeeper Ashekh / Morqut Village",
            sourceType = "Vendor",
            waypoints = { "/way #2151 35.8 59.6 Storykeeper Ashekh / Morqut Village" },
        },
    },
})
