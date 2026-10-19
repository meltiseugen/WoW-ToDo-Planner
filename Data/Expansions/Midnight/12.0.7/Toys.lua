local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("12.0.7", "toys", {
    entries = {
        { itemId = 259335, name = "Photo Finisher" },
        { itemId = 259899, name = "Ashen Horn of the Fallen Keeper" },
        { itemId = 260170, name = "Oathstone Fragment" },
        { itemId = 264313, name = "Madcap Redcap" },
        { itemId = 264367, name = "Mycomancer's Hearthspore" },
        { itemId = 276371, name = "Lightveil Recall Beacon" },
    },
    details = {
        ["Ashen Horn of the Fallen Keeper"] = {
            acquisition = "Buy from Xydan for 750 Timewarped Badges during Dragonflight Timewalking.",
            source = "Xydan",
            sourceType = "Timewalking Vendor",
            waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" },
        },
        ["Lightveil Recall Beacon"] = {
            acquisition = "Reward from A Swampy Welcome to Naigtal during the Naigtal introduction.",
            effect = "Recalls you to the active Umbral Base Camp in Val or Naigtal; 15-minute cooldown.",
            source = "A Swampy Welcome to Naigtal",
            sourceType = "Quest",
            tips = "It only functions while already inside Val or Naigtal and recalls you to that zone's active Umbral Base Camp. It may be hidden from the Toy Box while outside those zones.",
            waypoints = {
                "/way #2393 47.61 51.08 Maella / Invasion Point introductions",
                "/way #2405 51.44 71.27 Portal to Naigtal and Val",
                "/way #2600 47.8 81.6 Kifaan / Naigtal Umbral Base Camp",
                "/way #2599 59.0 19.0 Kifaan / Val Umbral Base Camp",
            },
        },
        ["Madcap Redcap"] = {
            acquisition = "Drops from Rotmire in Sporefall on raid difficulties.",
            effect = "Transforms nearby party members into Fungarians; 1-hour cooldown.",
            source = "Rotmire / Sporefall",
            sourceType = "Raid drop",
            waypoints = { "/way #2413 73.7 66.5 Sporefall Raid Entrance" },
        },
        ["Mycomancer's Hearthspore"] = {
            acquisition = "Drops from Rotmire in Sporefall on raid difficulties.",
            effect = "A Fungarian-themed cosmetic hearthstone.",
            source = "Rotmire / Sporefall",
            sourceType = "Raid drop",
            waypoints = { "/way #2413 73.7 66.5 Sporefall Raid Entrance" },
        },
        ["Oathstone Fragment"] = {
            acquisition = "Buy from Xydan for 500 Timewarped Badges during Dragonflight Timewalking.",
            source = "Xydan",
            sourceType = "Timewalking Vendor",
            waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" },
        },
        ["Photo Finisher"] = {
            acquisition = "Buy from Xydan for 1000 Timewarped Badges during Dragonflight Timewalking.",
            source = "Xydan",
            sourceType = "Timewalking Vendor",
            waypoints = { "/way #2112 81.44 47.33 Xydan / Dragonflight Timewalking vendor" },
        },
    },
})
