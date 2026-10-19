local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.4.7", {
    cosmeticDetailGroups = {
        pvpTabard = {
            acquisition = "Earn the elite Prideful Gladiator's Tabard during Mists PvP Season 15.",
            source = "Mists PvP Season 15",
            sourceType = "Elite PvP season reward",
            tips = "The original elite-season source is no longer obtainable.",
        },
    },
    label = "Patch 5.4.7: Mists PvP Season 15",
    sourceNotes = {
        "This bucket records the Prideful Season 15 mount, tabard, conquest, combatant, ladder-title, rated-battleground, and gladiator-mount achievements that became available with the season.",
        "The original ranked rewards are no longer obtainable; they remain visible for historical collection tracking.",
    },
    sourceUrls = { patch = "https://warcraft.wiki.gg/wiki/Patch_5.4.7" },
    wowheadPatchId = 50407,
})
