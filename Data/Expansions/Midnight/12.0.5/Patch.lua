local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("12.0.5", {
    cosmeticDetailGroups = {
        decorDuels = {
            acquisition = "During Decor Duels, earn Illusionary Coins from matches and the Ephemeron Masquerade daily, then buy this learn-on-use appearance from Gamesmaster Fleurian in Falconwing Square.",
            source = "Gamesmaster Fleurian",
            sourceType = "Decor Duel Vendor",
            tips = "Decor Duels was removed in Patch 12.1 and Blizzard has not confirmed a replacement source. Treat these appearances as currently unavailable unless the activity or rewards return.",
            waypoints = { "/way #2393 31.6 76.7 Gamesmaster Fleurian / Decor Duels rewards" },
        },
        lostArmament = {
            acquisition = "Obtain the learn-on-use item as a very rare Field Pouch reward from Void Assaults and Ritual Sites. Since Patch 12.0.7, the Cosmetic Equipment Salvager in Silvermoon sells weapon-family Bulging Field Pouches for 150 Dark Particles.",
            source = "Field Pouches / Cosmetic Equipment Salvager",
            sourceType = "Void Assault / Ritual Site",
            tips = "The purchasable pouch narrows the random roll to an Amani, Elven, Naga, or Twilight weapon pool. It is only a container; this listed item is the collectible consumed to teach the appearance.",
            waypoints = { "/way #2393 48.2 49.6 Field Accolade hub / Cosmetic Equipment Salvager", "/way #2395 34.9 65.4 Daggerspine Point Ritual Site", "/way #2437 29.7 78.2 Broken Throne Ritual Site" },
        },
    },
    label = "Patch 12.0.5: Lingering Shadows",
    sourceNotes = {
        "Wowhead activity, mount, pet, Decor Duels, and Abyss Anglers guides were cross-checked against live item pages for sources, costs, routes, and item type.",
        "Four Ritual Site curios were removed from the Toys list because they are usable or flavor items, not Toy Box collectibles; their relevant secret use remains documented under the pet that needs it.",
        "Promotion, shop, and expired-event rewards are labeled explicitly so unavailable sources are not mistaken for active world drops.",
        "The Cosmetics list tracks the learn-on-use Lost Armament items and confirmed Decor Duel appearance tokens, not their random pouch containers or ordinary equippable weapons.",
    },
    sourceUrls = {
        abyssAnglers = "https://www.wowhead.com/guide/midnight/abyss-anglers-location-dives-rewards",
        achievements = "https://www.wowhead.com/guide/midnight/void-assaults-strikes-incursions-rewards#void-assaults-achievements",
        arboonShop = "https://news.blizzard.com/en-us/article/24276748/shop-azeroth-blossoms-anew-choose-your-blooming-arboon-mount",
        childrensWeek = "https://www.wowhead.com/news/new-nap-mat-toy-from-childrens-week-381407",
        decorDuels = "https://www.wowhead.com/guide/midnight/decor-duels-objectives-kits-rewards",
        decorDuelsRemoval = "https://www.wowhead.com/news/decor-duels-no-longer-available-in-patch-12-1-double-currency-how-382221",
        liveRewards = "https://blizzardwatch.com/2026/05/26/rewards-available-void-assaults/",
        lostArmaments = "https://www.wowhead.com/news/buy-lost-armament-transmogs-for-dark-particles-in-patch-12-0-7-381740",
        mountCrossCheck = "https://www.warcraftmounts.com/patch12.0.5.php",
        mountGuide = "https://www.wowhead.com/guide/midnight/mounts-patch-12-0-5-models-locations",
        mounts = "https://www.wowhead.com/spells/mounts?filter=21;3;120005",
        overview = "https://www.wowhead.com/guide/midnight/patch-12-0-5-overview-features-activities-rewards",
        petGuide = "https://www.wowhead.com/guide/collections/midnight-battle-pets-locations-sources",
        pets = "https://www.wowhead.com/battle-pets?filter=3;3;120005",
        ritualSites = "https://www.wowhead.com/guide/midnight/ritual-sites-challenges-locations-rewards",
        voidAssaults = "https://www.wowhead.com/guide/midnight/void-assaults-strikes-incursions-rewards",
    },
    wowheadPatchId = 120005,
})
