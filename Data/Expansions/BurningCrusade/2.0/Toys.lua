local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("2.0", "toys", {
    entries = {
        {
            acquisition = "Learn Kablamm Farflinger's recipe with Goblin Engineering and Outland Engineering 50, then craft the toy; buying the finished toy also works for collection.",
            category = "Professions",
            itemId = 30542,
            name = "Dimensional Ripper - Area 52",
            source = "Kablamm Farflinger's Goblin Engineering recipe at Area 52",
            tips = "Kablamm teaches through dialogue beside the transporter. Engineering is not required to collect a finished toy, but teleporting requires Goblin Engineering and Outland Engineering 50. Malfunctions can alter your appearance or put you on a floating rock.",
            waypoints = { "/way #109 32.8 63.6 Kablamm Farflinger / Area 52 transporter" },
        },
        {
            acquisition = "Learn Smiles O'Byron's recipe with Gnomish Engineering and Outland Engineering 50, then craft the toy; buying the finished toy also works for collection.",
            category = "Professions",
            itemId = 30544,
            name = "Ultrasafe Transporter: Toshley's Station",
            source = "Smiles O'Byron's Gnomish Engineering recipe north of Toshley's Station",
            tips = "Both factions can learn the recipe from Smiles at the pad outside the Alliance settlement. Collection needs no profession; teleporting requires Gnomish Engineering and Outland Engineering 50. The transporter can produce side effects.",
            waypoints = { "/way #105 60.2 65.2 Smiles O'Byron / Toshley's Station transporter" },
        },
        {
            acquisition = "Complete Toshley's Alliance quest chain through Show Them Gnome Mercy! (10675) and learn Power Converter from the guaranteed reward.",
            category = "Quests",
            itemId = 30690,
            name = "Power Converter",
            source = "Show Them Gnome Mercy!",
            tips = "Enable Trivial Quests and check Toshley's next quest. If unavailable, finish the Sylvanaar unlock through Where Did Those Darn Gnomes Go? and Follow the Breadcrumbs. Horde can use the toy after an Alliance character collects it. Converted to a Toy Box collectible in patch 6.0.2.",
            waypoints = { "/way #105 60.5 69.0 Toshley / Power Converter quest chain" },
        },
    },
    details = {
        ["Dimensional Ripper - Area 52"] = {
            acquisition = "Learn Kablamm Farflinger's recipe with Goblin Engineering and Outland Engineering 50, then craft the toy; buying the finished toy also works for collection.",
            source = "Kablamm Farflinger's Goblin Engineering recipe at Area 52",
            sourceType = "Toy Box Source",
            tips = "Kablamm teaches through dialogue beside the transporter. Engineering is not required to collect a finished toy, but teleporting requires Goblin Engineering and Outland Engineering 50. Malfunctions can alter your appearance or put you on a floating rock.",
            waypoints = { "/way #109 32.8 63.6 Kablamm Farflinger / Area 52 transporter" },
        },
        ["Power Converter"] = {
            acquisition = "Complete Toshley's Alliance quest chain through Show Them Gnome Mercy! (10675) and learn Power Converter from the guaranteed reward.",
            source = "Show Them Gnome Mercy!",
            sourceType = "Toy Box Source",
            tips = "Enable Trivial Quests and check Toshley's next quest. If unavailable, finish the Sylvanaar unlock through Where Did Those Darn Gnomes Go? and Follow the Breadcrumbs. Horde can use the toy after an Alliance character collects it. Converted to a Toy Box collectible in patch 6.0.2.",
            waypoints = { "/way #105 60.5 69.0 Toshley / Power Converter quest chain" },
        },
        ["Ultrasafe Transporter: Toshley's Station"] = {
            acquisition = "Learn Smiles O'Byron's recipe with Gnomish Engineering and Outland Engineering 50, then craft the toy; buying the finished toy also works for collection.",
            source = "Smiles O'Byron's Gnomish Engineering recipe north of Toshley's Station",
            sourceType = "Toy Box Source",
            tips = "Both factions can learn the recipe from Smiles at the pad outside the Alliance settlement. Collection needs no profession; teleporting requires Gnomish Engineering and Outland Engineering 50. The transporter can produce side effects.",
            waypoints = { "/way #105 60.2 65.2 Smiles O'Byron / Toshley's Station transporter" },
        },
    },
})
