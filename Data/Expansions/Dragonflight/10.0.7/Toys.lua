local _, TDP = ...

local shared = {}
shared["Zskera Vault rooms"] = {
    acquisition = "Open Zskera Vault rooms and loot the matching holoviewer collectible.",
    source = "Zskera Vault rooms",
    sourceType = "Zskera Vault",
    waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" },
}

shared["Zskera Vaults"] = { acquisition = "Loot from a Zskera Vault room or chest.", source = "Zskera Vaults", sourceType = "Zskera Vault", waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" } }

TDP.CatalogRegistry:RegisterCollection("10.0.7", "toys", {
    entries = {
        { itemId = 202253, name = "Primal Stave of Claw and Fur" },
        { itemId = 202283, name = "Reading Glasses" },
        { itemId = 203725, name = "Display of Strength" },
        { itemId = 203757, name = "Brazier of Madness" },
        { itemId = 203734, name = "Snow Blanket" },
        { itemId = 202360, name = "Dented Can" },
        { itemId = 204170, name = "Clan Banner" },
        { itemId = 204256, name = "Holoviewer: The Scarlet Queen" },
        { itemId = 204257, name = "Holoviewer: The Lady of Dreams" },
        { itemId = 204262, name = "Holoviewer: The Timeless One" },
        { itemId = 199900, name = "Secondhand Survey Tools" },
        { itemId = 203852, name = "Spore-Bound Essence" },
        { itemId = 201930, name = "H.E.L.P." },
        { itemId = 204687, name = "Obsidian Battle Horn" },
        { itemId = 204405, name = "Stuffed Bear" },
    },
    details = {
        ["Brazier of Madness"] = {
            acquisition = "Unlock the old Zul'Gurub collection secrets, then complete the Brazier of Madness discovery.",
            source = "Old Zul'Gurub",
            sourceType = "Discovery",
            waypoints = { "/way #50 72.1 32.9 Zul'Gurub entrance" },
        },
        ["Clan Banner"] = {
            acquisition = "Complete the Orc heritage questline and its clan-choice follow-up to receive the banner.",
            source = "Orc heritage questline",
            sourceType = "Quest",
            waypoints = { "/way #85 39.1 79.0 Orgrimmar Embassy" },
        },
        ["Dented Can"] = {
            acquisition = "Create through Dragon Isles Engineering or obtain the finished toy from another engineer.",
            source = "Dragon Isles Engineering",
            sourceType = "Profession",
            waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" },
        },
        ["Display of Strength"] = {
            acquisition = "Complete the Baine Bloodhoof storyline through A Final Word on a character that receives the toy reward.",
            source = "A Final Word / Baine questline",
            sourceType = "Quest",
            waypoints = { "/way #2112 50.8 57.9 Mayla Highmountain / questline start" },
        },
        ["H.E.L.P."] = {
            acquisition = "Craft with Dragon Isles Engineering or obtain the finished toy from another engineer.",
            source = "Dragon Isles Engineering",
            sourceType = "Profession",
            waypoints = { "/way #2112 30.8 61.4 Artisan's Market / crafting orders" },
        },
        ["Holoviewer: The Lady of Dreams"] = shared["Zskera Vault rooms"],
        ["Holoviewer: The Scarlet Queen"] = shared["Zskera Vault rooms"],
        ["Holoviewer: The Timeless One"] = shared["Zskera Vault rooms"],
        ["Obsidian Battle Horn"] = shared["Zskera Vaults"],
        ["Primal Stave of Claw and Fur"] = {
            acquisition = "Raise Winterpelt Language Skill to 100, then complete the final Winterpelt Furbolg questline for the toy.",
            source = "Champion of the Winterpelt",
            sourceType = "Quest",
            waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" },
        },
        ["Reading Glasses"] = {
            acquisition = "Raise Winterpelt Language Skill to 50, then complete the matching Winterpelt Furbolg story chapter for the toy.",
            source = "Returning the Blade / Winterpelt Furbolg",
            sourceType = "Quest",
            waypoints = { "/way #2024 65.4 15.8 Winterpelt Hollow" },
        },
        ["Secondhand Survey Tools"] = {
            acquisition = "Purchase from Emilia Bellocq after unlocking the required Dragonscale Expedition research rank.",
            source = "Emilia Bellocq / Dragonscale Expedition",
            sourceType = "Vendor",
            waypoints = { "/way #2022 47.0 82.6 Dragonscale Basecamp" },
        },
        ["Snow Blanket"] = {
            acquisition = "Buy from the permanent Forbidden Reach vendor after meeting its unlock requirement.",
            source = "Forbidden Reach",
            sourceType = "Vendor",
            waypoints = { "/way #2151 35.8 59.6 Morqut Village" },
        },
        ["Spore-Bound Essence"] = shared["Zskera Vaults"],
        ["Stuffed Bear"] = {
            acquisition = "Find and loot the Stuffed Bear object in a randomized Zskera Vault room. The item became a Toy Box collectible in patch 11.0 but remains sourced from permanent 10.0.7 content.",
            source = "Stuffed Bear object / Zskera Vaults",
            sourceType = "Zskera Vault",
            waypoints = { "/way #2151 29.1 53.1 Zskera Vault entrance" },
        },
    },
})
