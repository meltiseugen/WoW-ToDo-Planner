local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("8.2.5", {
    label = "Patch 8.2.5: Battle for Azeroth Content Update",
    sourceNotes = {
        "Patch 8.2.5 added the permanent Honeyback Hive collection, the Fourth War finale, and the Jenafur client record later solved by the Secret Finding community.",
        "The time-limited anniversary battleground mounts, toys, and achievements, Recruit-a-Friend mounts, Winter Veil toys, promotions, and hidden records are excluded under the catalogue's standing policy.",
    },
    sourceUrls = {
        honeyback = "https://www.wowhead.com/guide/honeyback-hive-reputation-bee-mount-rewards",
        jenafur = "https://warcraft-secrets.com/guides/jenafur",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/23156365/the-next-battle-for-azeroth-content-update-is-now-live",
    },
    wowheadPatchId = 80205,
})
