local _, TDP = ...

local shared = {}
shared["Chapter IV: Darkness Incarnate"] = {
    acquisition = "Finish Khadgar's legendary-ring campaign and acquire the legendary ring on the matching faction.",
    source = "Chapter IV: Darkness Incarnate",
    sourceType = "Achievement",
    tips = "The original Warlords legendary-ring questline was removed; these achievements remain for historical tracking.",
    waypoints = { "/way #582 40.0 37.0 Lunarfall", "/way #590 52.0 50.0 Frostwall" },
}

shared["Lord of the Reins"] = {
    acquisition = "Collect 300 mounts usable by a single character.",
    source = "Lord of the Reins",
    sourceType = "Achievement",
    tips = "Check the usable total on one character because faction and class restrictions can change the count.",
}

TDP.CatalogRegistry:RegisterCollection("6.2.2", "achievements", {
    entries = { ids = { 10021, 10148, 10354, 10355, 10356 }, rewardHighlights = { "Heavenly Azure Cloud Serpent" } },
    details = {
        [10021] = shared["Chapter IV: Darkness Incarnate"],
        [10148] = shared["Chapter IV: Darkness Incarnate"],
        [10354] = {
            acquisition = "Collect 200 toys.",
            source = "Crashin' Thrashin' Commander",
            sourceType = "Achievement",
            tips = "Use the Toy Box missing filter and prioritize permanent vendors and guaranteed quest rewards before rare drops.",
        },
        [10355] = shared["Lord of the Reins"],
        [10356] = shared["Lord of the Reins"],
    },
    categories = { [10021] = "Questing", [10148] = "Questing", [10354] = "Collections", [10355] = "Collections", [10356] = "Collections" },
})
