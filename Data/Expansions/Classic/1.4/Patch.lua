local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.4", {
    cosmeticDetailGroups = {
        honorEnlistedTabards = {
            acquisition = "Purchase the faction's enlisted Honor tabard for 50 Honor Points from the PvP accessories quartermaster or an eligible tabard vendor.",
            source = "Master Sergeant Biggins or Brave Stonehide",
            sourceType = "Honor vendor",
            tips = "Private's Tabard is Alliance-only and Scout's Tabard is Horde-only. Their original rank-one requirement was removed in patch 2.0.1.",
            waypoints = { "/way #84 75.2 67.0 Master Sergeant Biggins", "/way #85 38.8 70.0 Brave Stonehide" },
        },
        honorOfficerTabards = {
            acquisition = "Purchase the faction's officer Honor tabard for 100 Honor Points from the PvP accessories quartermaster or an eligible tabard vendor.",
            source = "Master Sergeant Biggins or Brave Stonehide",
            sourceType = "Honor vendor",
            tips = "Knight's Colors is Alliance-only and Stone Guard's Herald is Horde-only. Their original rank-six requirement was removed in patch 2.0.1.",
            waypoints = { "/way #84 75.2 67.0 Master Sergeant Biggins", "/way #85 38.8 70.0 Brave Stonehide" },
        },
    },
    label = "The Call to War",
    sourceNotes = {
        "Patch 1.4.0 activated the original Honor system and added its eight racial war mounts, four rank tabards, and the epic Paladin Charger and Warlock Dreadsteed quest chains.",
        "The patch also replaced vendor-sold level-60 racial mounts with twenty-two newly modeled swift mounts. Faster undead mounts already had distinct models, so Green Skeletal Warhorse remained while Purple Skeletal Warhorse joined the updated vendor set.",
        "World Enlarger was also added in this patch as a rare Gnomish Engineering schematic from Blackrock Depths; it became a Toy Box collectible in Warlords of Draenor.",
        "The PvP mounts and tabards remain obtainable from the Stormwind and Orgrimmar honor vendors without their retired rank requirements. The original class-mount quests were removed, so their current learning method and historical quest locations are both recorded.",
        "The patch also introduced Children's Week and the Gurubashi Arena event. Their recurring-event rewards, ordinary PvP armor and weapons, engineering combat devices, and the consumable Heavy Leather Ball are outside this catalogue's permanent collection rules; achievements did not yet exist.",
    },
    sourceUrls = {
        charger = "https://warcraft.wiki.gg/wiki/Summon_Charger",
        dreadsteed = "https://warcraft.wiki.gg/wiki/Dreadsteed",
        honor = "https://warcraft.wiki.gg/wiki/Honor_system_(pre-2.0)",
        knightTabard = "https://warcraft.wiki.gg/wiki/Knight%27s_Colors",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.4.0",
        privateTabard = "https://warcraft.wiki.gg/wiki/Private%27s_Tabard",
        racialMounts = "https://warcraft.wiki.gg/wiki/Patch_1.4.0",
        scoutTabard = "https://warcraft.wiki.gg/wiki/Scout%27s_Tabard",
        warMount = "https://warcraft.wiki.gg/wiki/Black_War_Steed",
        worldEnlarger = "https://warcraft.wiki.gg/wiki/World_Enlarger",
    },
    wowheadPatchId = 10400,
})
