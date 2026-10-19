local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.5", {
    cosmeticDetailGroups = {
        alteracTabards = {
            acquisition = "Purchase the faction's Alterac Valley tabard after meeting its current reputation or currency requirement.",
            source = "Frostwolf or Stormpike supply officers",
            sourceType = "Battleground reputation vendor",
            tips = "Combine the tabard purchase with the Exalted mount grind. Jorek Ironside and Thanthaldis Snowgleam are accessible outside the battleground.",
            waypoints = { "/way #25 58.0 33.4 Jorek Ironside", "/way #25 44.6 46.0 Thanthaldis Snowgleam" },
        },
        warsongTabards = {
            acquisition = "Purchase the faction's Warsong Gulch tabard from its supply officer after meeting the current requirement.",
            source = "Kelm Hargunth or Illiyana Moonblaze",
            sourceType = "Battleground reputation vendor",
            tips = "Warsong Gulch bonus weeks are efficient for reputation. Warsong Battle Tabard is Horde-only; Silverwing Battle Tabard is Alliance-only.",
            waypoints = { "/way #10 39.4 20.0 Kelm Hargunth", "/way #63 61.5 83.9 Illiyana Moonblaze" },
        },
    },
    label = "Battlegrounds",
    sourceNotes = {
        "Patch 1.5.0 opened Warsong Gulch and Alterac Valley. Its permanent collection consists of the Frostwolf Howler, Stormpike Battle Charger, the four original battleground-faction tabards, and the two original Engineering transporters.",
        "The Alterac Valley mounts still require Exalted reputation with Frostwolf Clan or Stormpike Guard. Current outdoor supply-officer pins are provided alongside the Warsong Gulch faction vendors for the tabards.",
        "Goblin Engineers learn Dimensional Ripper - Everlook from Zap Farflinger, while Gnomish Engineers learn Ultrasafe Transporter: Gadgetzan from Jhordy Lapforge. Both items became Toy Box collectibles in later expansions but remain attributed to their patch 1.5 introduction.",
        "Battleground armor, weapons, trinkets, standards, consumables, and later retroactive achievements are excluded under the catalogue's ordinary-equipment and achievement-attribution rules.",
    },
    sourceUrls = {
        everlookRipper = "https://warcraft.wiki.gg/wiki/Dimensional_Ripper_-_Everlook",
        frostwolfHowler = "https://warcraft.wiki.gg/wiki/Frostwolf_Howler",
        frostwolfTabard = "https://warcraft.wiki.gg/wiki/Frostwolf_Battle_Tabard",
        gadgetzanTransporter = "https://warcraft.wiki.gg/wiki/Ultrasafe_Transporter:_Gadgetzan",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.5.0",
        silverwingTabard = "https://warcraft.wiki.gg/wiki/Silverwing_Battle_Tabard",
        stormpikeCharger = "https://warcraft.wiki.gg/wiki/Stormpike_Battle_Charger",
        stormpikeTabard = "https://warcraft.wiki.gg/wiki/Stormpike_Battle_Tabard",
        warsongTabard = "https://warcraft.wiki.gg/wiki/Warsong_Battle_Tabard",
    },
    wowheadPatchId = 10500,
})
