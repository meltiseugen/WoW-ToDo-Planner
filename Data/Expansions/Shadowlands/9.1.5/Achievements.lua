local _, TDP = ...

local shared = {}
shared["Shadowlands Patch 9.1.5"] = { acquisition = "Earn the matching Shadowlands Season 2 rated PvP rank.", source = "Shadowlands Patch 9.1.5", sourceType = "Achievement" }

shared["Shadowlands Patch 9.1.5 2"] = { acquisition = "Complete the matching Legion Timewalking Mage Tower challenge or meta-achievement.", source = "Shadowlands Patch 9.1.5", sourceType = "Achievement" }

TDP.CatalogRegistry:RegisterCollection("9.1.5", "achievements", {
    entries = { ids = { 15232, 15233, 15234, 15241, 15308, 15309, 15310, 15327, 15388 } },
    details = {
        [15232] = shared["Shadowlands Patch 9.1.5"],
        [15233] = shared["Shadowlands Patch 9.1.5"],
        [15234] = shared["Shadowlands Patch 9.1.5"],
        [15241] = { acquisition = "Reach Renown 80 with a Shadowlands covenant.", source = "Shadowlands Patch 9.1.5", sourceType = "Achievement" },
        [15308] = shared["Shadowlands Patch 9.1.5 2"],
        [15309] = shared["Shadowlands Patch 9.1.5 2"],
        [15310] = shared["Shadowlands Patch 9.1.5 2"],
        [15327] = { acquisition = "Finish Shadowlands Mythic+ Season 2 in the top 0.1% for your faction.", source = "Shadowlands Patch 9.1.5", sourceType = "Achievement" },
        [15388] = { acquisition = "Complete the listed Shadowlands exploration achievements.", source = "Shadowlands Patch 9.1.5", sourceType = "Achievement" },
    },
    categories = {
        [15232] = "PvP",
        [15233] = "PvP",
        [15234] = "PvP",
        [15241] = "Reputation",
        [15308] = "Feats of Strength",
        [15309] = "Feats of Strength",
        [15310] = "Feats of Strength",
        [15327] = "Dungeons",
        [15388] = "Exploration",
    },
})
