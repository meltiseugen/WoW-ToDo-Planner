local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.3.5", {
    label = "Defending the Ruby Sanctum",
    sourceNotes = {
        "Patch 3.3.5 adds the Ruby Sanctum raid below Wyrmrest Temple. Its permanent collection contribution is four Halion raid achievements rather than a new mount, pet, toy, or cosmetic drop.",
        "The limited Operation: Gnomeregan and Zalazane's Fall events ran in the final Wrath client era before Cataclysm; their feats and faction toys are grouped here and marked unavailable from their original sources.",
        "Cross-game Real ID and chat changes introduced by the patch do not create collection entries.",
    },
    sourceUrls = {
        eventAdditions = "https://warcraft.wiki.gg/wiki/Patch_3.3.5_(undocumented_changes)",
        patchNotes = "https://warcraft.wiki.gg/wiki/Patch_3.3.5",
        ptrOverview = "https://www.wowhead.com/news/patch-3-3-5-on-the-ptr-realms-155920",
        rubySanctum = "https://www.wowhead.com/wotlk/guide/raids/ruby-sanctum/halion-strategy",
    },
    wowheadPatchId = 30305,
})
