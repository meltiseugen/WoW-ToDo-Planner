local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("4.0.0", {
    cosmeticDetailGroups = {
        racialTabards = {
            acquisition = "Purchase the matching racial tabard from its faction vendor.",
            source = "Gilneas and Bilgewater Cartel quartermasters",
            sourceType = "Racial faction tabard",
            tips = "Use the capital-city faction vendors and enable trivial quests if the introductory faction access is incomplete.",
        },
        reputationTabards = {
            acquisition = "Reach Friendly with the matching faction and purchase its tabard, then wear it in eligible dungeons for reputation.",
            source = "Original Cataclysm faction quartermasters",
            sourceType = "Cataclysm reputation tabard",
            tips = "Quest through each faction's opening zone first; Therazane requires the Deepholm campaign before its quartermaster becomes available.",
        },
        tolBaradTabards = {
            acquisition = "Earn Tol Barad reputation and commendations, then purchase the faction tabard.",
            source = "Baradin's Wardens or Hellscream's Reach quartermaster",
            sourceType = "Tol Barad reputation tabard",
            tips = "Combine the peninsula daily circuit with battleground wins when available.",
            waypoints = { "/way #245 47.5 39.0 Tol Barad Peninsula hub" },
        },
    },
    label = "Cataclysm (Initial Release)",
    sourceNotes = {
        "This launch bucket covers patch 4.0.x and the Cataclysm release: the shattered old world, level 80-85 zones, Archaeology, guild progression, Tol Barad, the original heroic dungeons and raid tier, and PvP Season 9.",
        "Original live availability and current durable collection IDs are used. Shop, Collector's Edition, promotion, trading-card, recurring calendar-event, hidden-statistic, NPC-only, unused, and ordinary equipment records are excluded.",
        "Historical guild, realm-first, launch-event, raid, rated-battleground, and ranked-PvP achievements remain listed. Later Toy Box conversions retain their modern item IDs while staying with their original Cataclysm source.",
    },
    sourceUrls = {
        archaeology = "https://www.wowhead.com/cata/guide/professions/archaeology/quests-and-rewards",
        archaeologyRewards = "https://warcraft.wiki.gg/wiki/Template:Archaeology_rewards",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23492555/cataclysm-mounts-pets-and-more",
        overview = "https://www.wowhead.com/guide/cataclysm-wow-expansion",
    },
    wowheadPatchId = 40003,
})
