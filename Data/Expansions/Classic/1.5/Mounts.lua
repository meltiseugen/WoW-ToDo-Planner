local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("1.5", "mounts", {
    entries = {
        {
            acquisition = "Reach Exalted with the Frostwolf Clan, then buy the mount from Jorek Ironside or Grunnda Wolfheart.",
            category = "PvP",
            name = "Frostwolf Howler",
            source = "Jorek Ironside or Grunnda Wolfheart",
            spellId = 23509,
            tips = "Alterac Valley bonus weeks and repeatable battleground objectives help with the reputation grind. The outdoor Hillsbrad vendor is the simplest purchase point.",
            waypoints = { "/way #25 44.6 46.0 Thanthaldis Snowgleam", "/way #25 58.0 33.4 Jorek Ironside" },
        },
        {
            acquisition = "Reach Exalted with the Stormpike Guard, then buy the mount from Thanthaldis Snowgleam or Gaelden Hammersmith.",
            category = "PvP",
            name = "Stormpike Battle Charger",
            source = "Thanthaldis Snowgleam or Gaelden Hammersmith",
            spellId = 23510,
            tips = "Alterac Valley bonus weeks and repeatable battleground objectives help with the reputation grind. The outdoor Hillsbrad vendor is the simplest purchase point.",
            waypoints = { "/way #25 44.6 46.0 Thanthaldis Snowgleam", "/way #25 58.0 33.4 Jorek Ironside" },
        },
    },
    details = {
        ["Frostwolf Howler"] = {
            acquisition = "Reach Exalted with the Frostwolf Clan, then buy the mount from Jorek Ironside or Grunnda Wolfheart.",
            category = "PvP",
            source = "Jorek Ironside or Grunnda Wolfheart",
            sourceType = "Patch mount collection",
            tips = "Alterac Valley bonus weeks and repeatable battleground objectives help with the reputation grind. The outdoor Hillsbrad vendor is the simplest purchase point.",
            waypoints = { "/way #25 44.6 46.0 Thanthaldis Snowgleam", "/way #25 58.0 33.4 Jorek Ironside" },
        },
        ["Stormpike Battle Charger"] = {
            acquisition = "Reach Exalted with the Stormpike Guard, then buy the mount from Thanthaldis Snowgleam or Gaelden Hammersmith.",
            category = "PvP",
            source = "Thanthaldis Snowgleam or Gaelden Hammersmith",
            sourceType = "Patch mount collection",
            tips = "Alterac Valley bonus weeks and repeatable battleground objectives help with the reputation grind. The outdoor Hillsbrad vendor is the simplest purchase point.",
            waypoints = { "/way #25 44.6 46.0 Thanthaldis Snowgleam", "/way #25 58.0 33.4 Jorek Ironside" },
        },
    },
})
