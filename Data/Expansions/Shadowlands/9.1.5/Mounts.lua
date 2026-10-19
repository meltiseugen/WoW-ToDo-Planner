local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("9.1.5", "mounts", {
    entries = { { name = "Val'sharah Hippogryph", spellId = 359013 }, { name = "Soaring Spelltome", spellId = 359318 }, { name = "Lightforged Ruinstrider", spellId = 363613 } },
    details = {
        ["Lightforged Ruinstrider"] = {
            acquisition = "Learn automatically as an eligible Lightforged draenei paladin.",
            category = "Quest Rewards",
            source = "Lightforged draenei paladin",
            sourceType = "Racial Class Mount",
        },
        ["Soaring Spelltome"] = {
            acquisition = "Complete all seven unique Legion Timewalking Mage Tower challenges.",
            category = "Achievements",
            source = "A Tour of Towers",
            sourceType = "Mage Tower Meta-Achievement",
        },
        ["Val'sharah Hippogryph"] = {
            acquisition = "Buy for 5,000 Timewarped Badges during Legion Timewalking.",
            category = "Vendor",
            source = "Aridormi / Dalaran",
            sourceType = "Legion Timewalking Vendor",
            waypoints = { "/way #627 68.6 49.2 Aridormi" },
        },
    },
})
