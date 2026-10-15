local _, TDP = ...

-- Live 12.1.5.70391 compared with 12.1.0.69933, reviewed 2026-10-15.
-- IDs come from public client tables; acquisition and routes are researched
-- separately. No runtime dependency on a website or another addon.
local LABYRINTH = { "/way #2395 63.0 72.2 Labyrinth of Kindo'jan entrance" }
local AQIR_VENDOR = { "/way #2393 39.3 80.3 Estelia Archtender / Aqir Research Enclave" }
local STRIDER_VENDOR = { "/way #2576 62.05 68.34 Showena / The Den" }
local RAID = { "/way #2613 73.3 8.6 Unbinding of Kith'ix entrance / Underbelly" }
local LABYRINTH_GUIDE = "https://www.wowhead.com/guide/midnight/delves/labyrinth-of-kindojan-megadelve-nemesis-rewards"
local AQIR_GUIDE = "https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards"
local RAID_GUIDE = "https://www.wowhead.com/guide/midnight/raids/the-unbinding-of-kithix-boss-strategy-abilities-rewards"
local STRIDER_GUIDE = "https://www.method.gg/guides/sporebearer-fungal-strider-5-million-gold-mount-vendor-location-in-wow-midnight"

local patch = {
    label = "Patch 12.1.5: The Promise of Tomorrow",
    wowheadPatchId = 120105,
    sourceNotes = {
        "Audited against live 12.1.5.70391 and the preceding 12.1.0.69933 client tables on October 15, 2026.",
        "Includes the Labyrinth of Kindo'jan, Aqir Invasions, the Unbinding of Kith'ix, campaign appearance tokens, and the Sporebearer Fungal Strider.",
        "Shop, Trading Post, recurring calendar events, housing decor, ordinary equipment, hidden trackers, statistics, and unsourced appearance variants are excluded.",
        "First-week and Season 2 rewards are available at review time; limited duration is documented without marking them retired early.",
    },
    sourceUrls = {
        official = "https://worldofwarcraft.blizzard.com/en-us/news/24304162/1215-content-update-notes",
        achievements = "https://wago.tools/db2/Achievement/csv?build=12.1.5.70391",
        mounts = "https://wago.tools/db2/Mount/csv?build=12.1.5.70391",
        pets = "https://wago.tools/db2/BattlePetSpecies/csv?build=12.1.5.70391",
        toys = "https://wago.tools/db2/Toy/csv?build=12.1.5.70391",
        labyrinth = LABYRINTH_GUIDE,
        aqir = AQIR_GUIDE,
        raid = RAID_GUIDE,
        strider = STRIDER_GUIDE,
        coordinates = "https://github.com/DFortun81/AllTheThings/tree/master/db/Standard/Categories",
    },
    mounts = {}, pets = {}, toys = {}, cosmetics = {},
    achievements = { ids = {}, rewardHighlights = {} },
}
local details = { mounts = {}, pets = {}, toys = {}, cosmetics = {}, achievements = {} }
local achievementCategories = {}

local function Add(kind, entry, info)
    entry.faction = "all"
    patch[kind][#patch[kind] + 1] = entry
    info.reviewedAt = "2026-10-15"
    details[kind][entry.name] = info
end

Add("mounts", { spellId = 1301331, itemId = 276926, name = "Corrupted Swarmer" }, {
    category = "Vendor", sourceType = "Reputation Vendor", source = "Estelia Archtender / Aqir Research Enclave",
    acquisition = "Reach Exalted with the Aqir Research Enclave and buy the mount in Silvermoon City.",
    requirements = "Exalted with Aqir Research Enclave (Aqir Research Associate).", cost = "2,500 Voidlight Marl.",
    tips = "Use the active invasion icon in Eversong Woods or Zul'Aman at the top of the hour. Complete objectives and stay for the Monstrosity. Launch reports disagree about repeat-kill reputation; check your reputation log rather than assuming every kill awards 100.",
    availability = "Currently available. Aqir Invasions may be temporary; no confirmed removal date at review.",
    sourceUrl = AQIR_GUIDE, waypoints = AQIR_VENDOR,
})
Add("mounts", { spellId = 1314715, itemId = 283363, name = "Loa-Blessed Wayfarer" }, {
    category = "Delves", sourceType = "Achievement", source = "Let Me Solo Him: Kindo'jan (63715)",
    acquisition = "Defeat Kindo'jan solo on Tier 11 during Midnight Season 2.",
    requirements = "Unlock the Labyrinth and Kindo'jan; no other players in the party for the Tier 11 kill.",
    tips = "Open the Speaker's Chamber by clearing all nine chambers on Tier 8 or higher. Subsequent runs only need a route to Akil'zon's Roost. Clearing Tier 8 first can shorten setup for solo Tier 11 attempts.",
    availability = "Available during Midnight Season 2. The mount is separate from the first-week Fabled title.",
    sourceUrl = LABYRINTH_GUIDE, waypoints = LABYRINTH,
})
Add("mounts", { spellId = 1313788, itemId = 282414, name = "Sporebearer Fungal Strider" }, {
    category = "Vendor", sourceType = "Gold Vendor", source = "Showena / The Den, Harandar",
    acquisition = "Buy from Showena inside The Den. Mailbox and repair passengers are included; optional passengers are separate purchases.",
    cost = "5,000,000 gold; optional Auction House 1,500,000 gold, Transmogrifier 500,000 gold.",
    tips = "Hoshena nearby changes the active passenger combination after purchase. The Den uses interior map 2576; this is not an outdoor Harandar pin.",
    availability = "Vendor purchase is announced for the remainder of Midnight. No future replacement source is assumed.",
    sourceUrl = STRIDER_GUIDE, waypoints = STRIDER_VENDOR,
})

for _, record in ipairs({
    { 5068, 265755, 274927, "Aqir Wingreaver", "Friendly", "1,000" },
    { 5066, 265740, 274923, "Aqir Scuttler", "Honored", "1,000" },
    { 5100, 268483, 276927, "Aqir Razorwing", "Revered", "2,000" },
}) do
    Add("pets", { speciesId = record[1], npcId = record[2], itemId = record[3], name = record[4] }, {
        sourceType = "Reputation Vendor", source = "Estelia Archtender / Aqir Research Enclave",
        acquisition = "Reach " .. record[5] .. " with Aqir Research Enclave, then purchase and learn this companion.",
        requirements = record[5] .. " with Aqir Research Enclave.", cost = record[6] .. " Voidlight Marl.",
        tips = "All three pets use the same vendor. They are peaceful companion collectibles; do not plan a pet-battle capture route.",
        sourceUrl = AQIR_GUIDE, waypoints = AQIR_VENDOR,
    })
end

Add("toys", { itemId = 275039, name = "Curse of the Aqir" }, {
    sourceType = "Reputation Vendor", source = "Estelia Archtender / Aqir Research Enclave",
    acquisition = "Buy from Estelia after reaching Exalted with Aqir Research Enclave.",
    requirements = "Exalted with Aqir Research Enclave.", cost = "2,500 Voidlight Marl.",
    tips = "Save another 2,500 Marl if you also want the Corrupted Swarmer mount.", sourceUrl = AQIR_GUIDE, waypoints = AQIR_VENDOR,
})
Add("toys", { itemId = 286643, name = "Kinduru's Spiriting Quill" }, {
    sourceType = "Quest Reward", source = "...Is Sometimes the Way Back (98836)",
    acquisition = "Finish the Labyrinth introduction and its return quest to receive the quill.",
    tips = "The quill exits the Labyrinth. Leaving ends the current run; it does not preserve completed chambers for a later entry.",
    sourceUrl = LABYRINTH_GUIDE, waypoints = { LABYRINTH[1], "/way #2647 44.4 84.6 Kinduru / introduction return quest" },
})
Add("toys", { itemId = 280820, name = "Loa-Blessed Victory" }, {
    sourceType = "Delve Boss Reward", source = "Kindo'jan / Ancestral Bounty",
    acquisition = "Defeat Kindo'jan on Tier 8 or higher and open his Ancestral Bounty.",
    tips = "Solo Tier 11 is required for the mount achievement, not this ordinary toy reward. The toy also displays a qualifying Fabled achievement rank.",
    sourceUrl = LABYRINTH_GUIDE, waypoints = LABYRINTH,
})
for _, record in ipairs({
    { 280823, "Feathers of Akil'zon", 3, "Akil'zon's Roost", "Akil'zon", "/way #2647 30.7 15.6 Feathers of Akil'zon chest" },
    { 280825, "Rite of Jan'alai's Flame", 5, "Halazzi's Lair", "Jan'alai", "/way #2647 27.4 33.1 Rite of Jan'alai's Flame chest" },
    { 280822, "Nalorakk's Strength Charm", 7, "The Reliquary", "Nalorakk" },
    { 280821, "Trail of Halazzi", 9, "The Catacombs", "Halazzi" },
}) do
    Add("toys", { itemId = record[1], name = record[2] }, {
        sourceType = "Delve Treasure", source = record[4] .. " / " .. record[5] .. "-sealed room",
        acquisition = "Unlock Labyrinth Journey rank " .. record[3] .. ", pass the matching loa seal, and loot the chest in " .. record[4] .. ".",
        requirements = "Labyrinth Journey rank " .. record[3] .. ".",
        tips = record[6] and "The interior pin marks a documented chest; the outdoor pin is only the entrance." or "The chamber is known, but an exact chest coordinate has not been verified. Use the entrance pin, then explore the named chamber.",
        sourceUrl = "https://www.wowhead.com/item=" .. record[1],
        waypoints = record[6] and { LABYRINTH[1], record[6] } or LABYRINTH,
    })
end
Add("toys", { itemId = 281136, name = "Hiveborne Hearthstone" }, {
    sourceType = "Campaign Quest Reward", source = "The Unbinding of Kith'ix (95211)",
    acquisition = "Continue the 12.1.5 campaign through the Kith'ix story and collect the quest hearthstone reward.",
    tips = "Story Mode is available for campaign completion. The live Toy table retains the older Whatever It Takes source label; the current quest reward is The Unbinding of Kith'ix (95211). This is separate from the boss-drop Shadeweaver's Hearthstone.",
    sourceUrl = "https://www.wowhead.com/item=281136", waypoints = RAID,
})
Add("toys", { itemId = 281615, name = "Shadeweaver's Hearthstone" }, {
    sourceType = "Raid Drop", source = "Kith'ix / The Unbinding of Kith'ix",
    acquisition = "Defeat Kith'ix in a loot-eligible raid difficulty for the hearthstone toy.",
    tips = "Use the weekly loot opportunity on eligible characters. Story Mode campaign completion should not be treated as a guarantee of raid-drop loot.",
    sourceUrl = RAID_GUIDE, waypoints = RAID,
})
Add("toys", { itemId = 284159, name = "Libram of the Matriarch" }, {
    sourceType = "Mythic Raid Drop", source = "Mythic Kith'ix / The Unbinding of Kith'ix",
    acquisition = "Defeat Kith'ix on Mythic difficulty and loot the libram toy.",
    requirements = "Mythic difficulty for the drop; the generated wing glyph is for Paladins.",
    tips = "Using the libram creates Glyph of the Matriarch's Wings (284160). The glyph is not a second Toy Box collectible.",
    sourceUrl = "https://www.wowhead.com/item=284159", waypoints = RAID,
})

for _, record in ipairs({
    { 284181, "Loa-Touched Spine", 3, "Chamber of Rites", "Akil'zon", "/way #2647 38.0 83.5 Loa-Touched Spine chest" },
    { 284054, "Hexdrinker's Shoulders", 3, "Chamber of Rites", "Akil'zon" },
    { 284180, "Loa-Touched Deltoid", 5, "Jan'alai's Refuge", "Jan'alai" },
    { 284182, "Loa-Touched Visage", 9, "Halazzi's Lair", "Halazzi" },
    { 284052, "Amani Effigy" }, { 284051, "Hexbearer's Pauldrons" }, { 284057, "Effigy of Corrosion" },
}) do
    Add("cosmetics", { itemId = record[1], name = record[2], subtype = "appearance" }, {
        sourceType = "Delve Treasure", source = "Labyrinth of Kindo'jan / " .. (record[4] or "Ancient Chests"),
        acquisition = record[3] and ("Reach Labyrinth Journey rank " .. record[3] .. " and loot the " .. record[5] .. "-sealed room in " .. record[4] .. ".") or "Search the Labyrinth's Ancient Chests for the appearance token.",
        requirements = record[3] and ("Labyrinth Journey rank " .. record[3] .. ".") or nil,
        tips = "Use the token from your bags to learn the appearance. Sealed rooms unlock progressively through Journey rank 9. Use the entrance route for tokens whose exact chest is not yet mapped.",
        sourceUrl = "https://www.wowhead.com/item=" .. record[1],
        waypoints = record[6] and { LABYRINTH[1], record[6] } or LABYRINTH,
    })
end
for _, record in ipairs({ { 284055, "Hexbinder's Spaulders" }, { 284056, "Spirit Effigy" } }) do
    Add("cosmetics", { itemId = record[1], name = record[2], subtype = "appearance" }, {
        sourceType = "Delve Vendor", source = "Telemancer Astrandis / Silvermoon City",
        acquisition = "Purchase the appearance token from the Delve vendor and use it from your bags.",
        cost = "2,500 Undercoin.", tips = "These are new consumable appearance tokens, separate from ordinary Delve equipment.",
        sourceUrl = "https://www.wowhead.com/item=" .. record[1], waypoints = { "/way #2393 52.8 77.9 Telemancer Astrandis / Delver's Headquarters" },
    })
end
for _, record in ipairs({
    { 274937, "Shield of the Blood Knight Matriarch", "In Victory, Grief" },
    { 274934, "Blade of the Blood Knight Matriarch", "What the World Sees" },
}) do
    Add("cosmetics", { itemId = record[1], name = record[2], subtype = "appearance" }, {
        sourceType = "Campaign Quest Reward", source = record[3] .. " / The Promise of Tomorrow",
        acquisition = "Finish the Kith'ix chapter, then continue the campaign epilogue through " .. record[3] .. ".",
        requirements = "Level 90 and the preceding 12.1.5 campaign quests.",
        tips = "Story Mode can satisfy the campaign raid step. These are use-to-learn tokens; learn both from your bags after finishing the epilogue.",
        sourceUrl = "https://www.wowhead.com/item=" .. record[1],
        waypoints = record[1] == 274934 and { "/way #2393 27.6 10.9 What the World Sees / campaign finale" } or RAID,
    })
end

local function Achievement(id, name, category, acquisition, tips, waypoints, reward)
    patch.achievements.ids[#patch.achievements.ids + 1] = id
    patch.achievements.rewardHighlights[#patch.achievements.rewardHighlights + 1] = { achievementId = id, name = name, reward = reward }
    achievementCategories[id] = category
    details.achievements[id] = {
        sourceType = "Achievement", source = name, acquisition = acquisition, tips = tips,
        waypoints = waypoints, reviewedAt = "2026-10-15", sourceUrl = "https://www.wowhead.com/achievement=" .. id,
        faction = "all",
    }
end

Achievement(63519, "The Promise of Tomorrow", "Questing", "Complete the 12.1.5 campaign and its epilogue.", "Start The Aqir Swarm from Lor'themar in Silvermoon; Story Mode can complete the raid step.", RAID, "Title: Light's Faithful")
Achievement(63657, "Aqir Research Associate", "Reputation", "Reach Exalted with Aqir Research Enclave.", "Participate in the rotating hourly invasions. Current client costs are authoritative where older guides show zero.", AQIR_VENDOR)
Achievement(63658, "No Hives Left Standing", "Exploration", "Complete all six Aqir Invasion scenario types.", "Track the missing scenarios and check both zone rotations; repeated copies do not replace a missing type.", AQIR_VENDOR)
Achievement(63680, "Driving Back the Swarm", "Exploration", "Complete ten Aqir Invasions.", "Check your achievement counter after the event; launch reports describe inconsistent reputation credit.", AQIR_VENDOR)
Achievement(63659, "Bane of the Swarm", "Exploration", "Complete Aqir Research Associate, No Hives Left Standing, and Driving Back the Swarm.", "The vendor pin is a hub, not a fixed event spawn. Follow the active scarab icon on the world map.", AQIR_VENDOR, "Title: Bane of the Swarm")
Achievement(63690, "Midnight Keystone Myth: Season 2", "Dungeons", "Reach 3,600 Mythic+ rating during Midnight Season 2.", "Introduced mid-season. Claim the Timelost Saddle quest reward; this does not retire earlier Saddle mounts.", nil, "Title: The Venomous Contender; Item: Timelost Saddle")
Achievement(63830, "Fungal Not Frugal", "Collections", "Own the Sporebearer Fungal Strider.", "Purchase from Showena for 5,000,000 gold during Midnight.", STRIDER_VENDOR)
for _, record in ipairs({
    { 63692, "Kith'ix", "any difficulty" }, { 63693, "Heroic: Kith'ix", "Heroic difficulty" },
    { 63694, "Mythic: Kith'ix", "Mythic difficulty" }, { 64167, "Kith'ix Guild Run", "Normal or higher in a guild group" },
    { 64168, "Heroic: Kith'ix Guild Run", "Heroic or higher in a guild group" }, { 64169, "Mythic: Kith'ix Guild Run", "Mythic difficulty in a guild group" },
}) do
    Achievement(record[1], record[2], "Raids", "Defeat Kith'ix on " .. record[3] .. ".", "Enter through the northeast Underbelly. Guild achievements require the qualifying guild group, not just a guild tag.", RAID)
end
for _, record in ipairs({
    { 63715, "Let Me Solo Him: Kindo'jan", "Defeat Kindo'jan solo on Tier 11 during Midnight Season 2.", "Mount: Loa-Blessed Wayfarer" },
    { 63716, "The First Hash'ey", "Defeat Kindo'jan in the Labyrinth.", "Title: Loa-Blessed" },
    { 63717, "Kindo'jan's Labyrinth Discoveries", "Open all 44 Ancient / Sturdy Chests in the Labyrinth.", "Title: Treasure Hound" },
    { 63718, "Lock and Key", "Open the Labyrinth's locked door." },
    { 63719, "Lock and Key Master", "Open the locked door twenty times.", "Title: Lockpickin'" },
    { 63720, "Happy Hexmask Collector", "Gather all three Elemental Hexmasks in the Labyrinth." },
    { 63721, "The Labyrinth of Kindo'jan", "Clear all nine chambers in one run." },
    { 63722, "Whose Labyrinth?", "Clear all nine chambers on Tier 11 in one run.", "Title: Maze Runner" },
    { 63723, "My Labyrinth", "Complete 100 chambers in total." },
    { 63724, "Knock Knock", "Enter the Labyrinth for the first time." },
    { 63727, "Treasures Upon Treasures", "Loot ten Mislaid Treasures." },
    { 63728, "A Few More Can't Hurt", "Loot fifty Mislaid Treasures." },
    { 64039, "Fabled Let Me Solo Him: Kindo'jan", "Defeat Kindo'jan solo on Tier 11 before the first regional weekly reset after introduction.", "Title: Fabled Vanquisher of The First Hash'ey" },
    { 64118, "The Labyrinth of Kindo'jan: One-Champion Army", "Clear all nine chambers and defeat Kindo'jan solo on Tier 11 without losing a life during Midnight Season 2.", "Title: Lone Raider" },
}) do
    Achievement(record[1], record[2], "Delves", record[3], "Finish the introduction first. Journey ranks unlock secrets; Kindo'jan initially requires a nine-chamber clear on Tier 8+. Leaving ends the current run.", LABYRINTH, record[4])
end
details.achievements[64039].tips = "FIRST-WEEK DEADLINE: before the first regional weekly reset after release (October 20 NA / October 21 EU, 2026). Unlike the mount, this title cannot be earned throughout Season 2. Check the live achievement before attempting."
details.achievements[63719].tips = "Unlock Journey rank 2, kill the Keeper of the Key when he appears, and use the key on the locked door. One door per run means at least twenty successful runs."
local LOCKED_DOORS = {
    LABYRINTH[1], "/way #2647 50.4 78.5 Locked door / possible location",
    "/way #2647 59.3 26.9 Locked door / possible location",
}
details.achievements[63718].waypoints = LOCKED_DOORS
details.achievements[63719].waypoints = LOCKED_DOORS
details.achievements[63720].waypoints = {
    LABYRINTH[1], "/way #2647 18.4 20.5 Elemental Hexmask / possible location",
    "/way #2647 50.3 85.3 Elemental Hexmask / possible location",
    "/way #2647 88.4 53.9 Elemental Hexmask / possible location",
}
details.achievements[63717].tips = "Journey rank 9 opens the final loa seals. Pins cover 19 documented chest positions, not all 44; the remaining rooms still need exploration. Community map snapshots disagree on several Y positions, so only one documented coordinate set is retained."
for tier, id in ipairs({ 63863, 63864, 63865, 63846, 63847, 63848, 63849, 63850, 63851, 63852, 63853 }) do
    Achievement(id, "The Labyrinth of Kindo'jan: Tier " .. tier, "Delves", "Complete three chambers on Tier " .. tier .. ".", "Three chambers count as one Delve completion. Check existing Season 2 tier unlocks before repeating lower difficulties.", LABYRINTH)
end

-- These are interior positions, not outdoor entrances or claimed boss pins.
-- The current snapshots do not establish a reliable API criterion mapping;
-- do not auto-hide chest pins using guessed criterion indices.
details.achievements[63717].waypoints = {
    LABYRINTH[1],
    "/way #2647 46.9 67.0 Ancient Chest / quest 97131",
    "/way #2647 36.9 72.5 Ancient Chest / quest 98602",
    "/way #2647 38.8 83.4 Ancient Chest / quest 98605",
    "/way #2647 38.0 83.5 Ancient Chest / quest 98606",
    "/way #2647 21.7 71.3 Ancient Chest / quest 98607",
    "/way #2647 29.9 77.4 Ancient Chest / quest 98608",
    "/way #2647 13.9 37.8 Ancient Chest / quest 98611",
    "/way #2647 26.5 43.0 Ancient Chest / quest 98612",
    "/way #2647 27.8 34.6 Ancient Chest / quest 98615",
    "/way #2647 28.7 25.8 Ancient Chest / quest 98620",
    "/way #2647 22.1 32.2 Ancient Chest / quest 98621",
    "/way #2647 40.6 23.0 Ancient Chest / quest 98625",
    "/way #2647 68.2 36.7 Ancient Chest / quest 98628",
    "/way #2647 67.9 30.3 Ancient Chest / quest 98629",
    "/way #2647 81.3 57.7 Ancient Chest / quest 98633",
    "/way #2647 86.9 65.9 Ancient Chest / quest 98634",
    "/way #2647 72.4 68.6 Ancient Chest / quest 98637",
    "/way #2647 69.2 73.7 Ancient Chest / quest 98638",
    "/way #2647 47.7 42.7 Ancient Chest / quest 98649",
}

table.sort(patch.achievements.ids)
TDP.Patch1215Collections = { patch = patch, details = details, achievementCategories = achievementCategories }
