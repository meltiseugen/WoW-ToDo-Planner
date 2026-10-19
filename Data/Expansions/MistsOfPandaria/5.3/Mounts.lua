local _, TDP = ...

TDP.CatalogRegistry:RegisterCollection("5.3", "mounts", {
    entries = {
        {
            acquisition = "Obtain Armored Red Dragonhawk from the Horde Mount Parade achievement.",
            category = "Achievements",
            name = "Armored Red Dragonhawk",
            source = "the Horde Mount Parade achievement",
            spellId = 142266,
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
        },
        {
            acquisition = "Obtain Armored Blue Dragonhawk from the Alliance Mount Parade achievement.",
            category = "Achievements",
            name = "Armored Blue Dragonhawk",
            source = "the Alliance Mount Parade achievement",
            spellId = 142478,
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
        },
        {
            acquisition = "Obtain Brawler's Burly Mushan Beast from the Rank 10 Brawler's Guild vendor.",
            category = "Vendor",
            name = "Brawler's Burly Mushan Beast",
            source = "the Rank 10 Brawler's Guild vendor",
            spellId = 142641,
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
            waypoints = { "/way #84 66.5 33.0 Bizmo's Brawlpub entrance", "/way #85 48.5 30.0 Brawl'gar Arena" },
        },
    },
    details = {
        ["Armored Blue Dragonhawk"] = {
            acquisition = "Obtain Armored Blue Dragonhawk from the Alliance Mount Parade achievement.",
            category = "Achievements",
            source = "the Alliance Mount Parade achievement",
            sourceType = "Patch mount collection",
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
        },
        ["Armored Red Dragonhawk"] = {
            acquisition = "Obtain Armored Red Dragonhawk from the Horde Mount Parade achievement.",
            category = "Achievements",
            source = "the Horde Mount Parade achievement",
            sourceType = "Patch mount collection",
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
        },
        ["Brawler's Burly Mushan Beast"] = {
            acquisition = "Obtain Brawler's Burly Mushan Beast from the Rank 10 Brawler's Guild vendor.",
            category = "Vendor",
            source = "the Rank 10 Brawler's Guild vendor",
            sourceType = "Patch mount collection",
            tips = "The original Brawler rank requirement is historical; the dragonhawks remain tied to the 200-mount faction achievements.",
            waypoints = { "/way #84 66.5 33.0 Bizmo's Brawlpub entrance", "/way #85 48.5 30.0 Brawl'gar Arena" },
        },
    },
})
