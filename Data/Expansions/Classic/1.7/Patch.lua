local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.7", {
    cosmeticDetailGroups = {
        arathorTabard = {
            acquisition = "Reach Exalted with the League of Arathor through Arathi Basin, then purchase the tabard from Samuel Hawke.",
            source = "Samuel Hawke / League of Arathor",
            sourceType = "Reputation vendor",
            tips = "Arathi Basin bonus weeks accelerate reputation. Modern acquisition no longer requires completing the historical five-base quest.",
            waypoints = { "/way #14 40.2 46.5 Samuel Hawke / Refuge Pointe" },
        },
        defilersTabard = {
            acquisition = "Reach Exalted with The Defilers through Arathi Basin, then purchase the tabard from Rutherford Twing.",
            source = "Rutherford Twing / The Defilers",
            sourceType = "Reputation vendor",
            tips = "Arathi Basin bonus weeks accelerate reputation. Modern acquisition no longer requires completing the historical five-base quest.",
            waypoints = { "/way #14 69.6 33.0 Rutherford Twing / Hammerfall" },
        },
    },
    label = "Rise of the Blood God",
    sourceNotes = {
        "Patch 1.7.0 introduced the original Zul'Gurub raid and Arathi Basin. Its permanent collection records are the Swift Razzashi Raptor, Swift Zulian Tiger, and the two Exalted Arathi Basin faction tabards.",
        "Both original Zul'Gurub mounts became unavailable when the raid was replaced in patch 4.0.3a, although they may appear on the Black Market Auction House. Their later replacement mounts remain attributed to Cataclysm.",
        "The Stranglethorn Fishing Extravaganza and ordinary Zul'Gurub equipment are excluded under the catalogue's recurring-event and ordinary-equipment rules. Achievements did not yet exist.",
    },
    sourceUrls = {
        arathorTabard = "https://warcraft.wiki.gg/wiki/Arathor_Battle_Tabard",
        defilersTabard = "https://warcraft.wiki.gg/wiki/Battle_Tabard_of_the_Defilers",
        patch = "https://warcraft.wiki.gg/wiki/Patch_1.7.0",
        removedMounts = "https://warcraft.wiki.gg/wiki/Removed_mounts",
        tiger = "https://warcraft.wiki.gg/wiki/Swift_Zulian_Tiger",
    },
    wowheadPatchId = 10700,
})
