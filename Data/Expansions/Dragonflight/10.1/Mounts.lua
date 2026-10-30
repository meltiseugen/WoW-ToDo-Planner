local _, TDP = ...

local shared = {}
shared["Patch 10.1: Embers of Neltharion"] = {
    category = "Other",
    source = "Patch 10.1: Embers of Neltharion",
    sourceType = "Patch mount collection",
}

shared["Patch 10.1: Embers of Neltharion 2"] = {
    category = "PvP",
    source = "Patch 10.1: Embers of Neltharion",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("10.1", "mounts", {
    entries = {
        { name = "Winding Slitherdrake", spellId = 368893 },
        { name = "Subterranean Magmammoth", spellId = 371176 },
        { name = "Seething Slug", spellId = 374138 },
        { name = "Inferno Armoredon", spellId = 406637 },
        { name = "Tarecgosa's Visage", spellId = 407555 },
        { name = "Big Slick in the City", spellId = 408313 },
        { name = "Igneous Shalewing", spellId = 408627 },
        { name = "Cobalt Shalewing", spellId = 408647 },
        { name = "Shadowflame Shalewing", spellId = 408649 },
        { name = "Cataloged Shalewing", spellId = 408651 },
        { name = "Boulder Hauler", spellId = 408653 },
        { name = "Morsel Sniffer", spellId = 408655 },
        { name = "Obsidian Gladiator's Slitherdrake", spellId = 408977 },
        { name = "Vicious War Snail", spellId = 409034 },
        { name = "Vicious War Snail", spellId = 409032 },
    },
    details = {
        ["Big Slick in the City"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Boulder Hauler"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Cataloged Shalewing"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Cobalt Shalewing"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Igneous Shalewing"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Inferno Armoredon"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Morsel Sniffer"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Obsidian Gladiator's Slitherdrake"] = shared["Patch 10.1: Embers of Neltharion 2"],
        ["Seething Slug"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Shadowflame Shalewing"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Subterranean Magmammoth"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Tarecgosa's Visage"] = shared["Patch 10.1: Embers of Neltharion"],
        ["Vicious War Snail"] = shared["Patch 10.1: Embers of Neltharion 2"],
        ["Winding Slitherdrake"] = shared["Patch 10.1: Embers of Neltharion"],
    },
})
