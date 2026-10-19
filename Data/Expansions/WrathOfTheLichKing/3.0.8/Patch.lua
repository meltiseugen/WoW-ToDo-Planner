local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("3.0.8", {
    label = "Patch 3.0.8",
    sourceNotes = {
        "Patch 3.0.8 added the 75-pet and 100-mount collection milestones, two critter achievements, Wintergrasp vehicle achievements, and the original Tiny Green Ragdoll.",
        "Tiny Green Ragdoll uses current Toy Box item ID 54437; its original 3.0.8 item ID 44849 was replaced in patch 3.3.3.",
        "The limited Scourge Invasion Vampire Hunter feat is retained for historical completeness; recurring holiday and promotional rewards remain excluded.",
    },
    sourceUrls = {
        mountain = "https://warcraft.wiki.gg/wiki/Mountain_o%27_Mounts",
        patch = "https://warcraft.wiki.gg/wiki/Patch_3.0.8",
        pets = "https://warcraft.wiki.gg/wiki/Lil%27_Game_Hunter",
        ragdoll = "https://warcraft.wiki.gg/wiki/Tiny_Green_Ragdoll",
        undocumented = "https://wowpedia.fandom.com/wiki/Patch_3.0.8_(undocumented_changes)",
    },
    wowheadPatchId = 30008,
})
