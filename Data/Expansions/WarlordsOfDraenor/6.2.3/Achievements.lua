local _, TDP = ...

local shared = {}
shared["Warlords PvP Season 3"] = {
    acquisition = "Meet the listed rated-PvP rank, conquest, combatant, or faction-ladder requirement during Warlords Season 3.",
    source = "Warlords PvP Season 3",
    sourceType = "Achievement",
    tips = "These seasonal feats and original rewards are retained for historical tracking and may no longer be earned.",
}

TDP.CatalogRegistry:RegisterCollection("6.2.3", "achievements", {
    entries = {
        ids = { 10090, 10091, 10094, 10095, 10097, 10110, 10111, 10112, 10113, 10114, 10115, 10116, 10117, 10118, 10119, 10120, 10121, 10146 },
        rewardHighlights = { "Warmongering Gladiator's Felblood Gronnling" },
    },
    details = {
        [10090] = shared["Warlords PvP Season 3"],
        [10091] = shared["Warlords PvP Season 3"],
        [10094] = shared["Warlords PvP Season 3"],
        [10095] = shared["Warlords PvP Season 3"],
        [10097] = shared["Warlords PvP Season 3"],
        [10110] = shared["Warlords PvP Season 3"],
        [10111] = shared["Warlords PvP Season 3"],
        [10112] = shared["Warlords PvP Season 3"],
        [10113] = shared["Warlords PvP Season 3"],
        [10114] = shared["Warlords PvP Season 3"],
        [10115] = shared["Warlords PvP Season 3"],
        [10116] = shared["Warlords PvP Season 3"],
        [10117] = shared["Warlords PvP Season 3"],
        [10118] = shared["Warlords PvP Season 3"],
        [10119] = shared["Warlords PvP Season 3"],
        [10120] = shared["Warlords PvP Season 3"],
        [10121] = shared["Warlords PvP Season 3"],
        [10146] = shared["Warlords PvP Season 3"],
    },
    categories = {
        [10090] = "PvP",
        [10091] = "PvP",
        [10094] = "PvP",
        [10095] = "PvP",
        [10097] = "PvP",
        [10110] = "PvP",
        [10111] = "PvP",
        [10112] = "PvP",
        [10113] = "PvP",
        [10114] = "PvP",
        [10115] = "PvP",
        [10116] = "PvP",
        [10117] = "PvP",
        [10118] = "PvP",
        [10119] = "PvP",
        [10120] = "PvP",
        [10121] = "PvP",
        [10146] = "PvP",
    },
})
