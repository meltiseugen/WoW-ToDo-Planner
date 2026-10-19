local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("10.0.5", {
    cosmeticDetailGroups = {
        stormsFury = {
            acquisition = "Enter Primalist Tomorrow through the Temporal Conflux while Storm's Fury is active, close four portals, defeat the final boss, and open the event's Primal caches for a chance at the seven weapon or shield appearance tokens.",
            requirements = "Level 70; Storm's Fury must be active.",
            researchNotes = "Storm's Fury is a permanent recurring Dragonflight system, not a limited calendar event. Its rewards belong to 10.0.5 even though the item records existed in the launch client.",
            source = "Primal caches / Storm's Fury, Primalist Tomorrow",
            sourceType = "Permanent World Event",
            tips = "Pick up the event quest before entering, join a group, and keep moving between portals so the Freezing meter does not overwhelm you. The tokens are chance rewards rather than direct currency purchases, so repeat later event cycles and check the Auction House for bind-on-equip gaps.",
            waypoints = { "/way #2025 59.6 81.8 Temporal Conflux / portal to Primalist Tomorrow" },
        },
    },
    label = "Patch 10.0.5: Storm's Fury",
    sourceNotes = {
        "This backfill covers the permanent Storm's Fury mount, pet, toy, achievement, and Cosmetic rewards plus the patch's other permanent collectible additions.",
        "The seven Primal Revenant appearance tokens were preloaded in launch data but are assigned here because their permanent acquisition source, Storm's Fury, opened in patch 10.0.5.",
        "Trading Post, Timewalking, crossover, Trial of Style, other calendar-event rewards, and ordinary equippable items are excluded.",
    },
    sourceUrls = { official = "https://worldofwarcraft.blizzard.com/en-us/news/23892227", stormsFury = "https://www.wowhead.com/guide/storms-fury-event-rewards" },
    wowheadPatchId = 100005,
})
