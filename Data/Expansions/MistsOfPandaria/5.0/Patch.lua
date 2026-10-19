local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.0", {
    cosmeticDetailGroups = {
        pandarenTabards = {
            acquisition = "Purchase the tabard from the matching faction emissary in Stormwind or Orgrimmar.",
            source = "Tushui Pandaren and Huojin Pandaren emissaries",
            sourceType = "Racial faction tabard",
            tips = "Wear the tabard in eligible dungeons if you still need its racial-faction reputation.",
        },
        pandariaTabards = {
            acquisition = "Reach Exalted with the matching Pandaria faction and purchase its tabard.",
            source = "Original Pandaria faction quartermasters",
            sourceType = "Reputation tabard",
            tips = "Work one daily hub at a time and buy Grand Commendations where available to accelerate account-wide reputation gains.",
        },
        theramoreTabard = {
            acquisition = "Originally awarded to Alliance characters during the Mists pre-launch Theramore's Fall event.",
            source = "Alliance Theramore's Fall launch event",
            sourceType = "Historical scenario reward",
            tips = "The original limited-time source is no longer obtainable; retained for historical tracking.",
        },
    },
    label = "Mists of Pandaria (Initial Release)",
    sourceNotes = {
        "This launch bucket includes patch 5.0.4, the Mists of Pandaria expansion launch, Pandaria's original zones and factions, Pet Battles, Challenge Modes, scenarios, Mists PvP Season 12, and the first raid tier.",
        "The audit uses original live availability and current collection IDs. Shop, Collector's Edition, promotion, calendar-event, hidden-statistic, NPC-only, unused-beta, and ordinary equipment records are excluded.",
        "Historical Theramore, Challenge Mode, realm-first, raid, guild, and Season 12 rewards remain listed even where the original acquisition path has ended.",
    },
    sourceUrls = {
        launch = "https://www.wowhead.com/news/mists-of-pandaria-launch-guide-206705",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/10026010",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.0.4",
        pets = "https://us.forums.blizzard.com/en/wow/t/pandarian-pets-and-where-to-find-them/2077368",
        roundup = "https://worldofwarcraft.blizzard.com/en-us/news/7305448/world-of-warcraft-mists-of-pandaria-round-up",
        toys = "https://us.forums.blizzard.com/en/wow/t/more-toys-for-your-toy-box-pandaria/2098920",
    },
    wowheadPatchId = 50004,
})
