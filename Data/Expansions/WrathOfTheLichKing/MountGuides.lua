-- Hand-curated Retail routes. Review date: 2026-11-01.
-- Read the item/spell comments first, prefer numbered acquisition comments,
-- expand relevant reply threads, then reconcile with current Retail records.
-- Source comment IDs are research receipts, not text copied into the guide.
-- A waypoint is an actionable destination or a clearly labelled search area.
-- Retired sources have no historical map pins masquerading as live routes.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.mounts = TDP.CollectionWalkthroughs.mounts or {}
local guides = TDP.CollectionWalkthroughs.mounts
-- Ratings cover acquisition effort on a current high-level Retail character,
-- including unlocks, repetition, randomness and valid purchase alternatives.
local function rate(level, reason, spellIDs)
    for _, spellID in ipairs(spellIDs) do
        local guide = guides[spellID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end
-- Match the mount explorer's existing source-filter choices. The more specific
-- method remains visible in the source text and guide itself.
local mountCategories = {
    ["Class"] = "Quest Rewards", ["Daily Quests"] = "Quest Rewards",
    ["Dungeons"] = "Dungeon and Raids", ["Rare Spawns"] = "Rare Drops",
    ["Argent Tournament"] = "Vendor", ["Reputation"] = "Vendor",
    ["Professions"] = "Other", ["Fishing"] = "Other",
    ["Black Market"] = "Other", ["Unavailable"] = "Other",
}

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(spellID, name, itemID, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.mountCategory = guide.mountCategory or mountCategories[guide.category] or guide.category
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.wowheadUrl = "https://www.wowhead.com/" .. (itemID and ("item=" .. itemID) or ("spell=" .. spellID))
    guides[spellID] = guide
end

-- https://www.wowhead.com/spell=48778#comments:id=351200
-- https://www.wowhead.com/spell=48778#comments:id=759203
-- https://www.wowhead.com/item=40775#comments:id=6125921
-- https://www.wowhead.com/item=40775#comments:id=6186512
add(48778, "Acherus Deathcharger", nil, {
    category = "Class", source = "Death Knight introduction", cost = "No gold cost",
    tips = "Death Knight only. Check your Mount Journal before repeating a starting campaign; the shorter allied-race introduction also grants this mount.",
    sourceComments = { 351200, 759203 },
    steps = {
        "Create or log into a Death Knight. Search Collections > Mounts for Acherus Deathcharger first. A character that completed the shorter allied-race or pandaren Death Knight introduction can already have it.",
        "For the original Scarlet Enclave introduction, follow the starting quests to Death's Breach and accept Grand Theft Palomino from Salanar the Horseman. Use the quest's own map markers: this is the instanced starting phase, not ordinary Eastern Plaguelands.",
        "Steal a horse from the nearby stable area, ride it back to Salanar, and use the vehicle's delivery action. Accept Into the Realm of Shadows, defeat a Dark Rider, and take its deathcharger.",
        "Bring the deathcharger to Salanar and use the horse's challenge action as instructed. Complete the quest and check your Mount Journal for the learned class mount. Continue the introduction to regain access to the outside world.",
    },
    waypoints = { pin(124, 52.5, 34.5, 2, "Salanar the Horseman - original Death Knight starting phase", "Plaguelands: The Scarlet Enclave") },
})

add(54729, "Winged Steed of the Ebon Blade", 40775, {
    category = "Class", mountCategory = "Vendor", source = "Acherus mount vendors - Death Knight only", npcId = 29587,
    cost = "1,000 gold before any applicable vendor discount",
    tips = "Death Knight only. Use Death Gate to reach your character's Acherus; the Legion and Eastern Plaguelands versions are different maps.",
    sourceComments = { 6125921, 6186512, 2489181 },
    steps = {
        "On a Death Knight, finish the introduction far enough to use Death Gate and Acherus services. Search the Mount Journal first, especially on a boosted character.",
        "Cast Death Gate. In the Eastern Plaguelands version of Acherus, find Dread Commander Thalanor on the outer terrace beside the flight master (84.0, 49.8 on the Eastern Plaguelands map). Use the internal pink teleporter if you arrive on the other level. If Death Gate takes you to Legion Acherus instead, check Quartermaster Ozorg, the large abomination in the Heart of Acherus (44.2, 37.5); the dropdown includes this separate live vendor location.",
        "Buy Winged Steed of the Ebon Blade from the vendor available in your Acherus phase. Bring up to 1,000 gold. Some characters report no mount in Ozorg's stock; in that case check Thalanor beside the flight master rather than concluding the mount is unavailable. There is no old 5,000-gold Artisan Riding or Cold Weather Flying purchase to add in Retail.",
        "Use the item from your bags, then summon the mount from the journal on an eligible Death Knight. Learning a class mount does not make it usable by other classes.",
    },
    waypoints = {
        pin(23, 84.0, 49.8, 2, "Dread Commander Thalanor - Acherus terrace", "Eastern Plaguelands"),
        pin(647, 44.2, 37.5, 2, "Quartermaster Ozorg - Legion Acherus alternative", "Acherus: The Ebon Hold"),
    },
})

-- The useful numbered route is comment 5317253, not an RNG success story.
-- Its full four-reply thread explicitly corrects the claim of a guaranteed drop.
-- https://www.wowhead.com/item=43962#comments:id=5317253
add(54753, "White Polar Bear", 43962, {
    category = "Daily Quests", source = "Gretta the Arbiter's Hyldnir Spoils", npcId = 29796,
    cost = "Quest progression, then daily attempts",
    tips = "The bag is not guaranteed to contain a mount. Unlock the optional Brunnhildar quests as well: otherwise some daily rotations can appear to be missing.",
    sourceComments = { 5317253, 528166 },
    steps = {
        "Travel to K3 in the Storm Peaks and find Gretchen Fizzlespark inside the large central building (41.1, 86.1). Enable Trivial Quests in tracking. Start They Took Our Men! and Leave No Goblin Behind; collect keys from the hostile inhabitants of Sifreldar Village to release the prisoners.",
        "Continue through The Crone's Bargain and Mildred the Cruel to enter the disguised Brunnhildar sequence. Finish Discipline, Examples to be Made, A Certain Prisoner, A Change of Scenery, and Is That Your Goblin? Follow each quest's marker rather than trying to speak to the undisguised hostile villagers.",
        "Continue The Hyldsmeet, Taking on All Challengers, You'll Need a Bear, Going Bearback, and Cold Hearted. During Cold Hearted, ride a captive proto-drake, free and collect three frozen prisoners at a time, then fly out of the quest area to deliver them.",
        "Complete Deemed Worthy and Making a Harness. At Hibernal Cavern (entrance about 56.0, 64.0), finish The Last of Her Kind and The Slithering Darkness; return for The Warm-Up and Into the Pit.",
        "Follow the chain through the bear competition, drake-riding challenge, and the Thorim introduction. Complete Mending Fences. Return to Gretta the Arbiter at Brunnhildar Village (50.9, 65.6) and check for a blue daily quest.",
        "Also visit the southern village hut around 48.4, 72.2. Complete Aberrations from Thyra Kvinnshal, then Off With Their Black Wings and Yulda's Folly from Astrid Bjornrittar where offered. These one-time quests unlock additional daily rotations. A missing daily can mean that its prerequisite is unfinished.",
        "Each day, complete every available Gretta daily that actually lists Hyldnir Spoils as its reward. Open each bag and learn Reins of the White Polar Bear if it appears. Repeat after the daily reset; unlocking additional characters gives additional daily attempts.",
    },
    waypoints = {
        pin(120, 41.1, 86.1, 1, "Gretchen Fizzlespark - K3 introduction", "The Storm Peaks"),
        pin(120, 56.0, 64.0, 4, "Hibernal Cavern entrance", "The Storm Peaks"),
        pin(120, 50.9, 65.6, 5, "Gretta the Arbiter - daily quest hub", "The Storm Peaks"),
        pin(120, 48.4, 72.2, 6, "Southern hut - additional daily prerequisites", "The Storm Peaks"),
        pin(120, 50.9, 65.6, 7, "Gretta - repeat Hyldnir Spoils dailies", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=41508#comments:id=1410065 (+ full replies)
-- https://www.wowhead.com/item=44413#comments:id=870170
-- The profit-ending passenger/flag tricks are not acquisition guides.
local motorcycles = {
    { 55531, "Mechano-Hog", 41508, "Horde", "Horde Expedition", "Gara Skullcrush", 114, 41.4, 53.6, 44502 },
    { 60424, "Mekgineer's Chopper", 44413, "Alliance", "Alliance Vanguard", "Logistics Officer Brighton", 114, 59.6, 64.0, 44503 },
}
for _, mount in ipairs(motorcycles) do
    local spell, name, item, faction, reputation, vendor, map, x, y, schematic = unpack(mount)
    add(spell, name, item, {
        category = "Professions", source = faction .. " Northrend Engineering or a traded finished mount",
        cost = "12 Titansteel Bars, 40 Handfuls of Cobalt Bolts, 2 Arctic Fur, 1 Salvaged Iron Golem Parts, 8 Goblin-machined Pistons, 1 Elementium-plated Exhaust Pipe",
        tips = "Only the crafter needs Engineering and the recipe reputation. The finished motorcycle can be traded. Old guild-level perks and old 450-point profession instructions do not apply to Retail's split profession skills.",
        sourceComments = { item == 41508 and 1410065 or 870170 },
        steps = {
            "Use a " .. faction .. " character. For the quickest collection route, compare the finished " .. name .. " on the Auction House with the cost of its materials and a crafter's fee. Buying the completed mount does not require Engineering or reputation; if buying it, skip to the last step.",
            "To craft it yourself, learn Northrend Engineering and raise that expansion's skill to 75. Reach Exalted with " .. reputation .. ". Quest for its Northrend subfactions or earn their default reputation in eligible Wrath dungeons without a competing reputation tabard. Check that the parent faction's bar is increasing.",
            "Buy schematic item " .. schematic .. " from " .. vendor .. " in Borean Tundra (" .. x .. ", " .. y .. ") and learn it on the engineer. Merely having the materials does not unlock the restricted component vendor.",
            "Obtain 12 Titansteel Bars, 40 Handfuls of Cobalt Bolts, and 2 Arctic Fur. These are the finished crafting materials; do not mistake 40 Handfuls of Cobalt Bolts for 40 individual bolts or assume that a fixed amount of ore always produces them.",
            "With the schematic learned, visit Roxi Ramrocket at K3 in the Storm Peaks (40.7, 84.8). Buy one Salvaged Iron Golem Parts, eight Goblin-machined Pistons, and one Elementium-plated Exhaust Pipe. Their undiscounted total is 12,500 gold. The exhaust pipe can be limited stock; return later if it is unavailable.",
            "Craft the motorcycle at an anvil using all six material types. If another player is crafting it, agree on the materials and fee first; that engineer must buy any parts you cannot see on Roxi's vendor list.",
            "Use the finished " .. name .. " item to learn it. A party member can board the sidecar after you summon it. The passenger feature is part of the mount; it is not a separate recipe or reputation unlock.",
        },
        waypoints = {
            pin(map, x, y, 3, vendor .. " - faction schematic", "Borean Tundra"),
            pin(120, 40.7, 84.8, 5, "Roxi Ramrocket - motorcycle parts", "The Storm Peaks"),
            pin(120, 40.7, 84.8, 6, "K3 - nearby anvil", "The Storm Peaks"),
        },
    })
end

-- https://www.wowhead.com/item=44554#comments:id=2588208
-- https://www.wowhead.com/item=44554#comments:id=2582519
-- Current created-by spell records: 60969 / 60971 / 75597. The basic carpet
-- now uses Frostweave materials, superseding the older Outland-material list.
add(61451, "Flying Carpet", 44554, {
    category = "Professions", source = "Northrend Tailoring - trainer or traded finished carpet", npcId = 28699,
    cost = "6 Bolts of Imbued Frostweave, 4 Iceweb Spider Silk, 4 Green Dye, 5 Heavy Silken Thread",
    tips = "Learn Northrend Tailoring specifically. This basic carpet can be traded, but the character using it still needs the profession. Old Outland-material recipes are obsolete.",
    sourceComments = {2588208, 2582519, 1717189},
    steps = {
        "Go to Charles Worth inside the tailoring shop in Northrend Dalaran (36.5, 33.5). Learn Northrend Tailoring; a high skill in another expansion's Tailoring is a separate skill bar.",
        "If buying a finished Flying Carpet from the Auction House or another player, keep Northrend Tailoring learned and skip to the final step. Otherwise learn the Flying Carpet recipe from Charles; the current recipe is available at Northrend Tailoring 1.",
        "Gather 6 Bolts of Imbued Frostweave, 4 Iceweb Spider Silk, 4 Green Dye, and 5 Heavy Silken Thread. The dye and thread are tailoring supplies; buy the cloth, dust, or finished bolts as appropriate. This Retail recipe does not use the old Netherweave and Golden Draenite list.",
        "Craft Flying Carpet in your Northrend Tailoring window. The finished item is tradeable, unlike the two advanced Northrend carpets.",
        "Use the finished carpet to learn the mount, then summon it on a character with Northrend Tailoring. Account-wide collection does not remove the profession requirement for riding it.",
    },
    waypoints = { pin(125, 36.5, 33.5, 1, "Charles Worth - Northrend Tailoring", "Dalaran (Northrend)") },
})

add(61309, "Magnificent Flying Carpet", 44558, {
    category = "Professions", source = "Northrend Tailoring - Charles Worth", npcId = 28699,
    cost = "12 Bolts of Imbued Frostweave, 4 Monarch Topaz, 4 Red Dye, 2 Yellow Dye, 4 Iceweb Spider Silk",
    tips = "Craft it on your own tailor: the completed item binds on pickup. The recipe requires Northrend Tailoring 60; keeping the profession is required to ride it.",
    sourceComments = {461535, 2263242},
    steps = {
        "Learn Northrend Tailoring from Charles Worth in the tailoring shop in original Dalaran (36.5, 33.5). Raise that expansion's skill to 60; the old unsplit 425-point requirement is not a separate Retail skill to grind.",
        "Return to Charles and learn Magnificent Flying Carpet. Make sure your trainer filter shows available and unavailable recipes if you cannot find it.",
        "Collect 12 Bolts of Imbued Frostweave, 4 Monarch Topaz, 4 Red Dye, 2 Yellow Dye, and 4 Iceweb Spider Silk. Buy dyes from a tailoring-supplies vendor. The bolts can be crafted from Frostweave cloth and Infinite Dust or purchased directly.",
        "Craft the carpet on the tailor who will learn it, then use the item from that character's bags. Another tailor cannot hand you the bind-on-pickup finished mount.",
        "Search Collections > Mounts for Magnificent Flying Carpet. Keep Northrend Tailoring learned to summon it; learning it account-wide does not make it usable on non-tailor characters.",
    },
    waypoints = { pin(125, 36.5, 33.5, 1, "Charles Worth - trainer inside tailoring shop", "Dalaran (Northrend)") },
})

-- https://www.wowhead.com/item=54797#comments:id=1014108
-- https://www.wowhead.com/npc=40160#comments:id=983712
add(75596, "Frosty Flying Carpet", 54797, {
    category = "Professions", source = "Frozo's pattern and Northrend Tailoring", npcId = 40160,
    cost = "6 Frozen Orbs for the pattern; 4 more Frozen Orbs, 1 Ebonweave, 1 Moonshroud, 1 Spellweave to craft",
    tips = "Ten Frozen Orbs total when buying the pattern and crafting once. The finished carpet binds on pickup. Old special cloth-crafting locations and cooldowns are not required.",
    sourceComments = {1014108, 983712},
    steps = {
        "Learn Northrend Tailoring from Charles Worth in original Dalaran (36.5, 33.5), then raise the skill to 60 for the carpet recipe. Legion Dalaran is not the destination for this pattern.",
        "Gather at least 10 Frozen Orbs. You can buy them or loot the final bosses of eligible Wrath Heroic dungeons; six will be spent on the recipe and four are actual crafting reagents.",
        "Find Frozo the Renowned outdoors in Dalaran's Magus Commerce Exchange (40.0, 28.3). Buy Pattern: Frosty Flying Carpet for six Frozen Orbs and learn it on your tailor. If the pattern is hidden, check your profession and vendor filters.",
        "Obtain one Ebonweave, one Moonshroud, and one Spellweave, and keep four Frozen Orbs for the craft. These are the three finished specialty cloths; there is no need to visit old attunement altars or wait for their original Wrath cooldowns.",
        "Craft and use Frosty Flying Carpet on that tailor. The finished item is bind on pickup. Keep Northrend Tailoring learned to ride it, even though the collection unlock is shared with your account.",
    },
    waypoints = {
        pin(125, 36.5, 33.5, 1, "Charles Worth - Northrend Tailoring trainer", "Dalaran (Northrend)"),
        pin(125, 40.0, 28.3, 3, "Frozo the Renowned - six-Orb pattern", "Dalaran (Northrend)"),
    },
})

-- Collection-count comments supply the vendor-first approach; use the actual
-- achievement counter rather than the journal's larger account-wide total.
-- https://www.wowhead.com/item=44178#comments:id=1473853
-- https://www.wowhead.com/item=44842#comments:id=692133
-- https://www.wowhead.com/item=44842#comments:id=684097
for _, mount in ipairs({
    {60025, "Albino Drake", 44178, 50, "Leading the Cavalry"},
    {61996, "Blue Dragonhawk", 44843, 100, "Mountain o' Mounts (Alliance)"},
    {61997, "Red Dragonhawk", 44842, 100, "Mountain o' Mounts (Horde)"},
}) do
    local spell, name, item, total, achievement = unpack(mount)
    add(spell, name, item, {
        category = "Achievements", source = achievement,
        tips = "Track the achievement's own usable-mount counter. Class, profession, and faction restrictions can make it differ from the total in the Mount Journal. Learn purchased reins; merely owning them does not count.",
        sourceComments = {1473853, 692133, 684097},
        steps = {
            "Track " .. achievement .. " in the achievement window and note its current counter. The target is " .. total .. " mounts usable by an eligible character. For the dragonhawks, use an Alliance character for Blue and a Horde character for Red when checking the reward.",
            "Start with inexpensive racial mounts you have not learned. Use a character of the matching original race, or earn the vendor's home-city reputation to Exalted. Buy every uncollected ordinary and swift color you qualify for; each distinct learned mount adds collection progress.",
            "Add missing basic and swift gryphon or wind-rider colors from the flying-mount vendors in your faction capital. Then visit Mei Francis in Northrend Dalaran (57.8, 42.5) for any uncollected gold mounts within your budget. Check the journal before buying faction counterparts twice.",
            "For a reliable additional group, unlock Netherwing at the Netherwing Fields in Outland Shadowmoon Valley (59.3, 58.7), complete its reputation quests to Exalted, and collect all six drake colors. Another option is the Mag'har/Kurenai talbuk group in Nagrand: its Exalted vendor sells multiple distinct riding and war colors.",
            "After each group of purchases, use every item and recheck the tracked achievement. At " .. total .. ", log onto an eligible character and check both the journal and mailbox for " .. name .. ". If the displayed total is short, compare your usable-mount counter before buying an expensive extra mount.",
        },
        waypoints = {
            pin(125, 57.8, 42.5, 3, "Mei Francis - optional uncollected gold mounts", "Dalaran (Northrend)"),
            pin(104, 59.3, 58.7, 4, "Mordenai - optional Netherwing collection route", "Shadowmoon Valley (Outland)"),
            pin(107, 54.6, 75.2, 4, "Telaar - Alliance Kurenai talbuk vendor", "Nagrand (Outland)"),
            pin(107, 53.4, 36.8, 4, "Garadar - Horde Mag'har talbuk vendor", "Nagrand (Outland)"),
        },
    })
end

-- Retail audit, 2026-11-04: the nine retired raid/seasonal mounts were removed
-- from their patch entries, details and walkthroughs. Current retirement list:
-- https://www.warcraftmounts.com/retired.php

-- https://www.wowhead.com/item=44175#comments:id=1777871
-- https://www.wowhead.com/item=44175#comments:id=1871966
-- Current auctioneer: https://www.wowhead.com/npc=243247/madam-goya
add(60021, "Plagued Proto-Drake", 44175, {
    category = "Black Market", source = "Black Market Auction House", npcId = 243247,
    cost = "Variable gold bid; limited rotating availability",
    tips = "The old Glory of the Raider reward is gone, but this color survives through the Black Market. Black Proto-Drake does not share this route. Unclaimed containers are a gamble, not a guaranteed substitute.",
    sourceComments = {1777871, 1871966, 6338699},
    steps = {
        "Do not run the original 10-player Glory of the Raider meta expecting this mount: that reward was removed in patch 3.1. The current route is a rotating Black Market listing.",
        "On a character at the current maximum level, visit Madam Goya in Midnight Silvermoon City, Murder Row (51.8, 48.5). This is map 2393, not the Burning Crusade Silvermoon map or an old Dalaran auctioneer.",
        "Inspect the Black Market list for Reins of the Plagued Proto-Drake. If absent, check another day's inventory. If present, decide your maximum bid before bidding; there is no fixed gold price or guaranteed day for the listing.",
        "If bidding, monitor the auction until it ends. A bid does not reserve the mount against other bidders. On winning, retrieve the reins from your mailbox and use them.",
        "An Unclaimed Black Market Container can also contain the reins, but its contents are random. Buying a container is not a reliable way to target this particular drake.",
    },
    waypoints = { pin(2393, 51.8, 48.5, 2, "Madam Goya - current Black Market Auction House", "Silvermoon City (Midnight)") },
})

-- The profit-ending Horde comment 1004532 was read with its reply. Its route
-- predates Retail's changed criteria; retain group preparation, not dead targets.
-- https://www.wowhead.com/item=44224#comments:id=1004532
-- Current meta pages: https://www.wowhead.com/achievement=614 and =619.
add(60118, "Black War Bear", 44223, {
    category = "Achievements", source = "For the Alliance! - current Horde leader criteria",
    tips = "Alliance reward. The current meta lists Killed in Quel'Thalas and Opposing Orgrimmar. Check the live achievement window before travelling; old four-leader routes and old throne occupants are obsolete.",
    sourceComments = {2620563, 6384089},
    steps = {
        "On an Alliance character, track For the Alliance! and open its required sub-achievements. The current Retail page requires Lor'themar Theron and Rokhan. Form a same-faction group with a tank and healer, agree on a War Mode setting, and gather before entering an enemy city.",
        "For Killed in Quel'Thalas, use the Burning Crusade version of Silvermoon City. At the northern Eastern Plaguelands border (53.9, 8.7), use Zidormi/the old-zone portal to reach Ghostlands and old Eversong. Continue north through the old zones; the modern neutral Silvermoon hub is not the leader encounter.",
        "Inside old Silvermoon, reach Sunfury Spire (about 54.0, 20.6). Clear interfering guards, keep the group together, defeat Lor'themar Theron, and confirm Killed in Quel'Thalas completed before leaving.",
        "Travel to Grommash Hold in Orgrimmar's Valley of Strength. Defeat the attackable Rokhan for Opposing Orgrimmar, keeping damage on the leader and controlling guards and enemy-player interference. Do not hunt an obsolete Thrall, Garrosh, or Saurfang version.",
        "Confirm For the Alliance! is complete, then check the Mount Journal and mailbox for the Alliance Black War Bear. Use any reins received. Additional old leader achievements are optional unless your current in-game checklist explicitly requires them.",
    },
    waypoints = {
        pin(23, 53.9, 8.7, 2, "Old Quel'Thalas portal / Zidormi", "Eastern Plaguelands"),
        pin(110, 54.0, 20.6, 3, "Lor'themar Theron - Sunfury Spire in old Silvermoon", "Silvermoon City (Burning Crusade)"),
        pin(85, 48.5, 71.4, 4, "Grommash Hold - Rokhan leader encounter", "Orgrimmar"),
    },
})

add(60119, "Black War Bear", 44224, {
    category = "Achievements", source = "For the Horde! - current Alliance leader criteria",
    tips = "Horde reward. The current meta lists Overthrow the Council and Putting Out the Light. Old Darnassus and Stormwind instructions are not required by this current checklist.",
    sourceComments = {1004532, 3303780, 5559930},
    steps = {
        "On a Horde character, track For the Horde! and inspect the live criteria. The current Retail page lists Overthrow the Council and Putting Out the Light. Form a same-faction group with a tank and healer, choose matching War Mode settings, and enter each city together.",
        "Go to the High Seat in Ironforge (39.6, 56.0). Defeat all three Council of Three Hammers members: Muradin Bronzebeard, Moira Thaurissan, and Falstad Wildhammer. Keep the group in credit range and verify Overthrow the Council before leaving.",
        "Reach Azuremyst Isle and enter the Exodar. A practical Horde approach is through pre-burning Darkshore and Rut'theran's Azuremyst connection; use Zidormi at Darkshore (48.9, 24.5) if the route is hidden by the burned phase. A warlock already on Azuremyst can also summon the group.",
        "In the Exodar, reach Prophet Velen in the Vault of Lights (32.5, 54.5). Control the guards, interrupt healing where possible, and defeat Velen for Putting Out the Light. Verify the achievement before the group disperses.",
        "Check For the Horde! for completion, then inspect the Mount Journal and mailbox for the Horde Black War Bear. If your game lists an additional criterion, follow that live requirement; do not repeat a four-city Wrath-era itinerary by default.",
    },
    waypoints = {
        pin(87, 39.6, 56.0, 2, "High Seat - defeat all three council members", "Ironforge"),
        pin(62, 48.9, 24.5, 3, "Zidormi - optional pre-burning travel phase", "Darkshore"),
        pin(103, 32.5, 54.5, 4, "Prophet Velen - Vault of Lights", "The Exodar"),
    },
})

-- Tournament comments were inspected on every city mount item, not inferred
-- from a single color. The quest comments provide the missing daily gates.
-- https://www.wowhead.com/quest=13667#comments:id=677180
-- https://www.wowhead.com/quest=13668#comments:id=705690
-- https://www.wowhead.com/quest=13668#comments:id=705698
-- https://www.wowhead.com/item=45593#comments:id=5430633
local cityMounts = {
    {63232, "Stormwind Steed", 45125, "Alliance", "Stormwind", "Corporal Arthur Flew", 33307, 76.4, 19.2, "Orgrimmar Wolf", 1932370},
    {63635, "Darkspear Raptor", 45593, "Horde", "Sen'jin", "Samamba", 33554, 76.0, 24.4, "Gnomeregan Mechanostrider", 680921},
    {63636, "Ironforge Ram", 45586, "Alliance", "Ironforge", "Derrick Brindlebeard", 33310, 76.4, 19.4, "Thunder Bluff Kodo", 692509},
    {63637, "Darnassian Nightsaber", 45591, "Alliance", "Darnassus", "Rook Hawkfist", 33653, 76.2, 19.2, "Forsaken Warhorse", 679868},
    {63638, "Gnomeregan Mechanostrider", 45589, "Alliance", "Gnomeregan", "Rillie Spindlenut", 33650, 76.4, 19.6, "Darkspear Raptor", 1932374},
    {63639, "Exodar Elekk", 45590, "Alliance", "the Exodar", "Irisee", 33657, 76.2, 19.2, "Silvermoon Hawkstrider", 746331},
    {63640, "Orgrimmar Wolf", 45595, "Horde", "Orgrimmar", "Freka Bloodaxe", 33553, 76.4, 24.2, "Stormwind Steed", 626901},
    {63641, "Thunder Bluff Kodo", 45592, "Horde", "Thunder Bluff", "Doru Thunderhorn", 33556, 76.2, 24.4, "Ironforge Ram", 5430634},
    {63642, "Silvermoon Hawkstrider", 45596, "Horde", "Silvermoon", "Trellis Morningsun", 33557, 76.2, 23.8, "Exodar Elekk", 5430636},
    {63643, "Forsaken Warhorse", 45597, "Horde", "the Undercity", "Eliza Killian", 33555, 76.4, 24.0, "Darnassian Nightsaber", 627131},
}
for _, mount in ipairs(cityMounts) do
    local spell, name, item, faction, city, vendor, npc, x, y, counterpart, receipt = unpack(mount)
    add(spell, name, item, {
        category = "Argent Tournament", source = vendor .. " - Champion of " .. city, npcId = npc,
        cost = "100 Champion's Seals",
        tips = "Aspirant's Seals, Valiant's Seals, and Champion's Seals are different progression resources. This mount costs 100 Champion's Seals; the 5-seal-and-gold alternative is a different appearance.",
        sourceComments = {receipt, 677180, 705690, 705698},
        steps = {
            "Use an eligible " .. faction .. " character. Visit Justicar Mariel Trueheart at the Argent Tournament in Icecrown (69.6, 22.8), enable Trivial Quests, and accept The Argent Tournament. Follow the introduction to your faction pavilion.",
            "Complete the mounted-combat mastery lessons. For Up To The Challenge, do the Aspirant dailies until you have 15 Aspirant's Seals, then complete The Aspirant's Challenge. Equip the provided lance and ride a tournament mount; maintain three Defend stacks, break the opponent's shields, and Charge when there is room.",
            "Become a Valiant for the city offered to your race. Complete its daily training to collect 25 Valiant's Seals for The Valiant's Charge, then win The Valiant's Challenge and turn in A Champion Rises. These daily gates cannot be skipped by simply bringing gold.",
            "You need Champion of " .. city .. " for this vendor. If your first championship was another city, accept " .. city .. "'s Valiant line and repeat its 25-seal training and challenge. Only one new city can be in training at a time; home-city Exalted reputation and tournament championship are different requirements.",
            "Complete Crusader Rhydalla's Black Knight investigation through The Black Knight's Fall to unlock Threat From Above. This adds a Champion daily; do not confuse the quest-chain Black Knight with buying the mount directly.",
            "Earn and save 100 Champion's Seals through the unlocked Champion dailies. Prefer the Champion's Purse reward when offered for another possible seal, and open the purses. Keep doing city training alongside the Champion dailies if also working toward Crusader.",
            "For additional daily seals, set Trial of the Champion to Heroic and enter the five-player portal at the Coliseum (75.1, 21.8). Complete the mounted opening and all bosses, looting them. This is not the adjacent Trial of the Crusader raid; the Heroic dungeon has a daily lockout.",
            "Return to " .. vendor .. " in your faction pavilion (" .. x .. ", " .. y .. "). Buy " .. name .. " for 100 Champion's Seals after the city championship is complete.",
            "Use the mount item, then check the journal. The eligible opposite-faction counterpart is " .. counterpart .. "; check whether it was already granted before planning a second full tournament grind.",
        },
        waypoints = {
            pin(118, 69.6, 22.8, 1, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
            pin(118, x, y, 4, city .. " pavilion - city championship", "Icecrown"),
            pin(118, 75.1, 21.8, 7, "Trial of the Champion - Heroic five-player entrance", "Icecrown"),
            pin(118, x, y, 8, vendor .. " - " .. name, "Icecrown"),
        },
    })
end

-- https://www.wowhead.com/item=45725#comments:id=635971
-- https://www.wowhead.com/item=45725#comments:id=717194
add(63844, "Argent Hippogryph", 45725, {
    category = "Argent Tournament", source = "Your unlocked city tournament quartermaster",
    cost = "150 Champion's Seals",
    tips = "One city championship is enough for its vendor. The tournament is a permanent quest hub, not a seasonal holiday. The old 250-seal price is obsolete.",
    sourceComments = {635971, 717194, 677180, 705690},
    steps = {
        "Start The Argent Tournament with Justicar Mariel Trueheart in Icecrown (69.6, 22.8). Finish the combat lessons, collect 15 Aspirant's Seals from the daily training, and win The Aspirant's Challenge.",
        "Complete your first city's Valiant training: collect 25 Valiant's Seals through its dailies, win The Valiant's Challenge, and turn in A Champion Rises. This unlocks that city's quartermaster and Champion's Seal activities.",
        "Finish Crusader Rhydalla's investigation through The Black Knight's Fall to unlock Threat From Above. Keep doing the Champion dailies and open any Champion's Purses you select as rewards.",
        "Add a daily Heroic Trial of the Champion clear at the Coliseum's five-player entrance (75.1, 21.8). Loot all bosses. Keep saving until the currency panel shows 150 Champion's Seals.",
        "Buy Argent Hippogryph from your unlocked city quartermaster. For example, Champion of Stormwind can use Corporal Arthur Flew in the Alliance pavilion (76.4, 19.2); Champion of Orgrimmar can use Freka Bloodaxe in the Horde pavilion (76.4, 24.2). Use the item to learn the mount.",
    },
    waypoints = {
        pin(118, 69.6, 22.8, 1, "Justicar Mariel Trueheart - introduction", "Icecrown"),
        pin(118, 75.1, 21.8, 4, "Trial of the Champion - Heroic dungeon", "Icecrown"),
        pin(118, 76.4, 19.2, 5, "Corporal Arthur Flew - Alliance example vendor", "Icecrown"),
        pin(118, 76.4, 24.2, 5, "Freka Bloodaxe - Horde example vendor", "Icecrown"),
    },
})

-- https://www.wowhead.com/item=46815#comments:id=759932
-- https://www.wowhead.com/item=46816#comments:id=759931
-- https://www.wowhead.com/item=46816#comments:id=2361387
-- https://www.wowhead.com/npc=34881#comments:id=800180
for _, mount in ipairs({
    {66087, "Silver Covenant Hippogryph", 46813, "Alliance", "the Silver Covenant", "Hiren Loresong", 34881, 19.6, 150, 760787},
    {66088, "Sunreaver Dragonhawk", 46814, "Horde", "the Sunreavers", "Vasarin Redmorn", 34772, 24.0, 150, 759549},
    {66090, "Quel'dorei Steed", 46815, "Alliance", "the Silver Covenant", "Hiren Loresong", 34881, 19.6, 100, 759932},
    {66091, "Sunreaver Hawkstrider", 46816, "Horde", "the Sunreavers", "Vasarin Redmorn", 34772, 24.0, 100, 2361387},
}) do
    local spell, name, item, faction, reputation, vendor, npc, y, seals, receipt = unpack(mount)
    add(spell, name, item, {
        category = "Argent Tournament", source = vendor .. " - Exalted with " .. reputation, npcId = npc,
        cost = seals .. " Champion's Seals",
        tips = "Reach the vendor's faction at Exalted and advance your tournament championship. These are permanent vendors. A flying mount costs 150 seals; the faction ground mount costs 100.",
        sourceComments = {receipt, 800180, 705690},
        steps = {
            "Use an eligible " .. faction .. " character and begin The Argent Tournament with Justicar Mariel Trueheart (69.6, 22.8 in Icecrown). Finish the mastery lessons, 15 Aspirant's Seals, and The Aspirant's Challenge.",
            "Complete your home city's 25-Valiant's-Seal training, The Valiant's Challenge, and A Champion Rises. Keep the Champion dailies running while doing any further city training needed for the faction pavilion's services.",
            "Reach Exalted with " .. reputation .. ". Complete the faction's unlocked tournament dailies and check that this exact reputation increases. Home-city Exalted or Argent Crusade Exalted is not a replacement for the vendor's own faction reputation.",
            "Save " .. seals .. " Champion's Seals from Champion/faction dailies and their purses. A daily Heroic Trial of the Champion clear at 75.1, 21.8 adds more seals after the character's Champion progression is unlocked.",
            "At Exalted, visit " .. vendor .. " in the " .. faction .. " pavilion at 76.2, " .. y .. ". If the vendor is locked, finish the remaining tournament champion introductions on this character. Buy " .. name .. " for " .. seals .. " seals.",
            "Use the item from your bags and check the Mount Journal. Before repeating the grind on another faction, check for an already-granted counterpart in the journal.",
        },
        waypoints = {
            pin(118, 69.6, 22.8, 1, "Justicar Mariel Trueheart - start tournament", "Icecrown"),
            pin(118, 76.2, y, 3, reputation .. " - pavilion reputation dailies", "Icecrown"),
            pin(118, 75.1, 21.8, 4, "Trial of the Champion - Heroic daily seals", "Icecrown"),
            pin(118, 76.2, y, 5, vendor .. " - " .. name, "Icecrown"),
        },
    })
end

-- https://www.wowhead.com/item=47179#comments:id=1934030 (+ full replies)
-- https://www.wowhead.com/item=47179#comments:id=760189 (+ full replies)
-- https://www.wowhead.com/item=47180#comments:id=769547
-- https://www.wowhead.com/achievement=2816#comments:id=675476
for _, mount in ipairs({ {66906, "Argent Charger", 47179, true}, {67466, "Argent Warhorse", 47180, false} }) do
    local spell, name, item, paladin = unpack(mount)
    add(spell, name, item, {
        category = paladin and "Class" or "Argent Tournament", mountCategory = "Vendor", source = "Dame Evniki Kapsalis - Crusader vendor", npcId = 34885,
        cost = "100 Champion's Seals",
        tips = paladin and "A Paladin must buy and use Argent Charger. An account's existing Crusader achievement can unlock the vendor for the Paladin alt; the seals still need to be earned."
            or "Usable by both factions. Argent Warhorse is not one of the retired Crusader's White/Black Warhorse tribute rewards.",
        sourceComments = {1934030, 760189, 769547, 675476},
        steps = {
            (paladin and "Use a Paladin and check " or "Check ") .. "Dame Evniki Kapsalis in the Argent pavilion at 69.4, 23.1 in Icecrown. If another character already earned Crusader, inspect her stock first: the account achievement can save you repeating all five city championships.",
            "If Crusader is not unlocked, begin The Argent Tournament with Justicar Mariel Trueheart (69.6, 22.8). Finish Aspirant training and the 15-seal challenge, then a city's 25-Valiant's-Seal training and challenge to become a Champion.",
            "Champion all five original home cities of your faction, one city at a time. Keep doing the Champion dailies while collecting each new city's 25 Valiant's Seals. Aspirant and Valiant seals are training progress, not the currency used to buy this mount.",
            "Reach Exalted with those same five city factions and with the Argent Crusade. Complete Exalted Argent Champion of the Alliance or Exalted Argent Champion of the Horde for Crusader. Argent Dawn Exalted and an unrelated Argent Champion title are not this achievement.",
            "On the character buying the mount, save 100 Champion's Seals. Unlock Champion dailies through its own training as needed, finish the Black Knight investigation for Threat From Above, and add daily Heroic Trial of the Champion clears at 75.1, 21.8.",
            "Buy " .. name .. " from Dame Evniki Kapsalis and use the item. " .. (paladin and "If the Charger is missing from her stock, confirm you are on a Paladin; a different class cannot buy this class mount for you." or "The mount is shared with eligible characters of either faction."),
        },
        waypoints = {
            pin(118, 69.4, 23.1, 1, "Dame Evniki Kapsalis - check existing Crusader unlock", "Icecrown"),
            pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - introduction if needed", "Icecrown"),
            pin(118, 75.1, 21.8, 5, "Trial of the Champion - Heroic daily seals", "Icecrown"),
            pin(118, 69.4, 23.1, 6, "Dame Evniki Kapsalis - " .. name, "Icecrown"),
        },
    })
end

-- Current racial vendors: https://www.wowhead.com/npc=3685,
-- https://www.wowhead.com/npc=3362 and https://www.wowhead.com/npc=4731.
-- Item comments: https://www.wowhead.com/item=46099#comments:id=678188
-- https://www.wowhead.com/item=46308#comments:id=798444
for _, mount in ipairs({
    {64657, "White Kodo", 46100, "Tauren", "Thunder Bluff", "Harb Clawhoof", 3685, 7, 47.6, 58.1, "Bloodhoof Village", "White Kodo"},
    {64658, "Black Wolf", 46099, "Orc", "Orgrimmar", "Ogunaro Wolfrunner", 3362, 85, 61.5, 35.5, "Valley of Honor", "Horn of the Black Wolf"},
    {64977, "Black Skeletal Horse", 46308, "Undead", "Undercity", "Zachariah Post", 4731, 18, 61.8, 51.8, "Brill", "Black Skeletal Horse"},
}) do
    local spell, name, item, race, reputation, vendor, npc, map, x, y, place, itemName = unpack(mount)
    add(spell, name, item, {
        category = "Vendor", source = vendor .. " - " .. place, npcId = npc,
        cost = "1 gold base, reduced by reputation discounts",
        tips = "Horde only. The matching original race skips the reputation grind. Allied races are separate races; use the vendor's eligibility requirement. Ordinary mounts scale with your riding skill.",
        steps = {
            "Use a Horde character with riding unlocked. An original " .. race .. " can buy this racial mount without Exalted; other races need Exalted with " .. reputation .. ". If already eligible, go directly to the vendor step.",
            "If reputation is needed, equip the " .. reputation .. " Tabard from its city quartermaster. Use the quartermaster beside the city flight master; for Undercity, restore the pre-battle Tirisfal phase with Zidormi first, then visit Captain Donald Adams underground.",
            "With the tabard equipped, clear Normal Botanica in Netherstorm (71.5, 55.5) on a character able to solo it. Confirm the correct city reputation increases, take the exit behind Warp Splinter, reset outside, and repeat to Exalted. Pause at the hourly instance limit.",
            "Visit " .. vendor .. " at " .. place .. " (" .. x .. ", " .. y .. "). " .. (map == 18 and "If Brill is destroyed in your phase, speak to Zidormi in Tirisfal Glades (69.4, 62.8) to restore the pre-battle zone first. " or "") .. "Buy " .. itemName .. " for up to 1 gold.",
            "Use the mount item and search Collections > Mounts for " .. name .. ". This is a normal racial purchase, not a PvP currency mount or an Argent Tournament reward.",
        },
        waypoints = {
            pin(109, 71.5, 55.5, 3, "The Botanica - optional tabard reputation runs", "Netherstorm"),
            pin(map, x, y, 4, vendor .. " - " .. itemName, map == 7 and "Mulgore" or map == 85 and "Orgrimmar" or "Tirisfal Glades"),
        },
    })
    if map == 18 then
        table.insert(guides[spell].waypoints, 1, pin(18, 69.4, 62.8, 2, "Zidormi - restore pre-battle Tirisfal", "Tirisfal Glades"))
        table.insert(guides[spell].waypoints, 2, pin(90, 63.6, 48.8, 2, "Captain Donald Adams - optional Undercity Tabard", "Undercity"))
    elseif map == 7 then
        table.insert(guides[spell].waypoints, 1, pin(88, 46.6, 50.0, 2, "Brave Tuho - optional Thunder Bluff Tabard", "Thunder Bluff"))
    else
        table.insert(guides[spell].waypoints, 1, pin(85, 50.0, 58.0, 2, "Stone Guard Nargol - optional Orgrimmar Tabard", "Orgrimmar"))
    end
end

-- https://www.wowhead.com/item=46109#comments:id=1900057
-- https://www.wowhead.com/item=46109#comments:id=1607166
-- https://www.wowhead.com/item=46109#comments:id=682545 (+ reply)
add(64731, "Sea Turtle", 46109, {
    category = "Fishing", source = "Rare catch from eligible fishing pools",
    tips = "The map pins are starting areas for pool fishing, not fixed turtle spawns. Cast into the visible school of fish. No exact number of catches guarantees the mount.",
    sourceComments = {1900057, 1607166, 682545, 929176},
    steps = {
        "Learn Fishing, make room in your bags, and choose a region with many accessible pools. If you know Find Fish, enable its minimap tracking. Higher Fishing skill does not create a special guaranteed turtle roll.",
        "For a simple Northrend route, start at Bittertide Lake in northwestern Sholazar Basin (about 38.0, 39.0). Move around the shoreline and fish each visible Nettlefish school until it disappears. Cast so the bobber lands inside the pool, not just somewhere in the lake.",
        "If the lake is crowded or empty, use a different pool circuit. Fangtooth Herring schools in Howling Fjord's lakes, including the area near 48.0, 39.0, are another option and can also yield the Dark Herring achievement fish. Switch the map dropdown to compare the two starting areas.",
        "Continue from pool to pool, loot every catch, and keep bag space available. This is a rare catch with no daily dungeon-style lockout; unsuccessful casts do not make a specific later cast guaranteed.",
        "When Sea Turtle appears in the loot, take the item before moving or cancelling the window, then use it to learn the mount. Eligible Cataclysm, Pandaria, and Draenor pools offer alternate fishing routes if you prefer their fish; Northrend is not the only surviving Retail source.",
    },
    waypoints = {
        pin(119, 38.0, 39.0, 2, "Bittertide Lake - Nettlefish pool circuit starting area", "Sholazar Basin"),
        pin(117, 48.0, 39.0, 3, "Howling Fjord lakes - alternate fishing-pool search area", "Howling Fjord"),
    },
})

-- https://www.wowhead.com/npc=11701#comments:id=780966 (+ replies)
-- https://www.wowhead.com/item=46102#comments:id=760101
-- https://www.wowhead.com/quest=13850#comments:id=6113348
-- https://www.wowhead.com/quest=13850#comments:id=6186052
add(64659, "Venomhide Ravasaur", 46102, {
    category = "Quest Rewards", source = "Mor'vek - They Grow Up So Fast", npcId = 11701,
    cost = "20 Venomhide Baby Teeth, 20 Rugged Leather, 20 Runecloth, 80 gold",
    tips = "Horde only. One hatchling daily gives one tooth: plan for 20 daily completions. Keep the hatchling summoned while collecting or feeding its quest items.",
    sourceComments = {780966, 760101, 6113348, 6186052},
    steps = {
        "Visit Mor'vek near the southeastern exit of Un'Goro Crater (71.5, 73.7) on a Horde character. Enable Trivial Quests and accept Toxic Tolerance.",
        "Find Venomhide Ravasaurs in southeastern Un'Goro and trigger 20 poison splashes by hitting them. Being attacked without hitting back is not enough. Remove weapons and damage-proc equipment and use small melee hits. At very high level, use a lower-level Horde alt or Party Sync with an appropriately leveled friend if the ravasaurs die before the poison can proc; wait for quest credit between attempts.",
        "Return for Venomhide Eggs and collect four eggs from the nests marked by that quest. Turn them in, accept They Grow Up So Fast, and keep the supplied Venomhide Hatchling item.",
        "Summon the hatchling in Un'Goro or Tanaris each day and accept its daily. Hungry, Hungry Hatchling needs 15 Fresh Dinosaur Meat from Un'Goro dinosaurs; Gorishi Grub needs 10 Silithid Meat from the Slithering Scar. In Tanaris, Poached, Scrambled, Or Raw? needs 12 Silithid Eggs from the Noxious Lair, and Searing Roc Feathers needs five Searing Roc Plumage. Keep the hatchling present and feed it the quest items where requested; follow the current quest markers for that day's task.",
        "Turn the daily in to the hatchling to receive one Venomhide Baby Tooth. Repeat after the daily reset until you have 20 teeth. Summoning it repeatedly on the same day does not generate extra daily teeth.",
        "Bring the 20 teeth, 20 Rugged Leather, 20 Runecloth, and 80 gold back to Mor'vek. Complete They Grow Up So Fast, collect Whistle of the Venomhide Ravasaur, and use it to learn the mount.",
    },
    waypoints = {
        pin(78, 71.5, 73.7, 1, "Mor'vek - begin the ravasaur chain", "Un'Goro Crater"),
        pin(78, 67.0, 71.0, 2, "Venomhide Ravasaurs - search the southeastern jungle", "Un'Goro Crater"),
        pin(78, 71.5, 73.7, 3, "Mor'vek - eggs and hatchling quests", "Un'Goro Crater"),
        pin(78, 50.0, 78.0, 4, "Slithering Scar - Un'Goro silithid daily area", "Un'Goro Crater"),
        pin(71, 34.5, 47.5, 4, "Noxious Lair - Tanaris egg daily search area", "Tanaris"),
        pin(78, 71.5, 73.7, 6, "Mor'vek - final 20-tooth turn-in", "Un'Goro Crater"),
    },
})

-- https://www.wowhead.com/item=43953#comments:id=1605779
-- Both colors occur in the same current loot chest; size is not color-specific.
for _, mount in ipairs({ {59567, "Azure Drake", 43952}, {59568, "Blue Drake", 43953} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Dungeon and Raids", source = "Malygos - The Eye of Eternity", npcId = 28859,
        tips = "Both Blue and Azure can drop in either raid size. Loot Alexstrasza's Gift after the scripted ending; the mount is not guaranteed.",
        sourceComments = { 1605779, 1408099 },
        steps = {
            "Travel to Coldarra in Borean Tundra. Fly up to the Eye of Eternity portal on the upper ring of the Nexus structure (27.5, 26.6). The ground-level Nexus and the middle Oculus portals are different instances.",
            "Set a legacy 10- or 25-player raid size before entering and check your weekly raid lockout. You no longer need the original attunement key to activate the encounter.",
            "Use the focusing object in the room to summon Malygos. Defeat him and any transition enemies. If the dragon vehicle phase occurs, build combo points with Flame Spike and spend them on Engulf in Flames; use Revivify and Life Burst to recover and Flame Shield for the incoming surge. Stay on the vehicle and finish the encounter rather than leaving when the platform breaks.",
            "Wait for Alexstrasza and the reward chest. Loot Alexstrasza's Gift completely, including any mount reins. Use Reins of the " .. mount[2] .. " if they appear.",
            "A failed attempt to get the reins does not unlock another loot roll on the same saved encounter. Return after the weekly reset, or use a different eligible character. Either color can appear on the same attempt.",
        },
        waypoints = { pin(114, 27.5, 26.6, 1, "Eye of Eternity - upper Nexus ring", "Borean Tundra") },
    })
end

-- https://www.wowhead.com/item=43951#comments:id=1555368
-- https://www.wowhead.com/item=43951#comments:id=5366327
add(59569, "Bronze Drake", 43951, {
    category = "Dungeons", source = "Timed Infinite Corruptor - Heroic Culling of Stratholme", npcId = 32273,
    tips = "Heroic only. Kill the optional Infinite Corruptor while the 25-minute timer is active, before finishing with Mal'Ganis. One guaranteed mount drops for the group.",
    sourceComments = { 388195, 1555368, 5366327 },
    steps = {
        "Set Dungeon Difficulty to Heroic before entering. Go to the Caverns of Time in Tanaris (64.4, 50.0), descend into the cavern, and take the Culling of Stratholme portal (56.9, 82.4 on the Caverns of Time map).",
        "On a first visit, speak to Chromie, obtain the Arcane Disruptor, and reveal the five plagued grain crates around the approach to the city. Speak to Chromie again, then talk to Arthas at the city entrance to begin the event.",
        "Follow the minimap markers to each undead wave and kill both wave bosses. Keep talking to Arthas whenever his dialogue is required; waiting for him without starting the next segment wastes the timer.",
        "Escort Arthas through the Town Hall, kill Chrono-Lord Epoch, and continue through the tunnel and burning streets. Clear anything preventing the escort from advancing. You have 25 minutes from the timed event's start to reach the optional boss.",
        "At the end of the burning-street route, before committing to Mal'Ganis, take the side path into Market Row. Find the Infinite Corruptor beside a captive bronze drake and kill him before the timer expires.",
        "Loot Reins of the Bronze Drake from the Corruptor and use them. If several collectors are present, agree who gets the single mount. If the timer expires, try again on a different eligible character or after the Heroic reset.",
    },
    waypoints = {
        pin(71, 64.4, 50.0, 1, "Caverns of Time entrance", "Tanaris"),
        pin(75, 56.9, 82.4, 1, "Culling of Stratholme portal - set Heroic", "Caverns of Time"),
    },
})

-- https://www.wowhead.com/item=43955#comments:id=482625
-- https://www.wowhead.com/item=43955#comments:id=501526
add(59570, "Red Drake", 43955, {
    category = "Reputation", source = "Cielstrasza - Exalted with the Wyrmrest Accord", npcId = 32533,
    cost = "2,000 gold base; normally 1,600 gold at the required Exalted reputation",
    tips = "Use the Wyrmrest Accord Tabard in eligible Wrath dungeons. Old Justice Point currency exchanges are obsolete. Naxxramas is not a purchase location for this mount.",
    sourceComments = { 482625, 501526 },
    steps = {
        "Quest for the Wyrmrest Accord in Dragonblight until at least Friendly. Visit Cielstrasza on the upper level of Wyrmrest Temple (59.8, 53.0); take a temple flight or fly up to her terrace.",
        "Buy and equip the Tabard of the Wyrmrest Accord. Enter an eligible Wrath dungeon on a character able to clear it, kill a few enemies, and confirm that the Wyrmrest Accord reputation bar increases. The tabard does not redirect reputation from arbitrary modern dungeons.",
        "Continue eligible dungeon clears to Exalted. Heroic Wrath dungeons provide a daily route; repeatable Normal clears of the Icecrown five-player dungeons are another option where their kills award tabard reputation. Reset Normal instances only after exiting, and respect the hourly instance limit.",
        "Return to Cielstrasza at Exalted, buy Reins of the Red Drake, and use the item. The displayed vendor price includes any applicable discount; bring 2,000 gold to cover the base price.",
    },
    waypoints = {
        pin(115, 59.8, 53.0, 1, "Cielstrasza - upper Wyrmrest Temple", "Dragonblight"),
        pin(118, 52.5, 89.3, 3, "Icecrown five-player dungeon approach - optional reputation route", "Icecrown"),
        pin(115, 59.8, 53.0, 4, "Cielstrasza - buy the reins at Exalted", "Dragonblight"),
    },
})

-- Black Drake's actual numbered profit-ending acquisition comment: 1875881.
-- Read its full reply; remove the closing joke and obsolete class/gear advice.
-- https://www.wowhead.com/item=43986#comments:id=1875881
-- https://www.wowhead.com/item=43954#comments:id=1683151 (portal correction in reply)
for _, mount in ipairs({ {59650, "Black Drake", 43986, 10}, {59571, "Twilight Drake", 43954, 25} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Dungeon and Raids", source = "Sartharion with three drakes - " .. mount[4] .. "-player Obsidian Sanctum", npcId = 28860,
        tips = "The raid size chooses the color. Leave Tenebron, Shadron, and Vesperon alive before pulling Sartharion. A fast direct boss kill is the simplest route on a strong Retail character.",
        sourceComments = mount[4] == 10 and {1875881, 494316} or {1683151, 389757},
        steps = {
            "Outside the instance, set Legacy Raid Size to " .. mount[4] .. " players. Fly to the ground-level chamber beneath Wyrmrest Temple in Dragonblight (about 59.6, 54.4) and enter the Obsidian Sanctum portal. Do not confuse it with the Ruby Sanctum.",
            "Clear only the ordinary trash you need to pass. Leave the three named twilight drakes on the surrounding ledges alive. Killing one before the pull removes the required three-drake condition for this attempt.",
            "Engage Sartharion directly with all three drakes still alive and defeat him quickly. On an overleveled Retail character, there is no need to reproduce old class cooldown rotations, raid compositions, or item-level requirements.",
            "If he becomes immune because the fight lasts long enough for Shadron's mechanics, handle the summoned drakes and their portal disciples. In a group, leave someone outside to maintain the encounter while another player enters the portal. Do not start by killing the drakes before Sartharion is engaged.",
            "Loot Reins of the " .. mount[2] .. " from Sartharion and learn the mount. The correctly completed three-drake encounter guarantees one mount for the group. Check the selected raid size if you received the other color.",
        },
        waypoints = { pin(115, 59.6, 54.4, 1, "Obsidian Sanctum - chamber under Wyrmrest Temple", "Dragonblight") },
    })
end

-- Item vendor tables confirm 15 Marks of Honor, not a Vault boss drop.
-- https://www.wowhead.com/item=44077#comments:id=5236050
for _, mount in ipairs({ {59785, 43956, "Alliance", "Knight Dameron", 32294}, {59788, 44077, "Horde", "Stone Guard Mukar", 32296} }) do
    add(mount[1], "Black War Mammoth", mount[2], {
        category = "Vendor", source = mount[4] .. " - Wintergrasp", npcId = mount[5], cost = "15 Marks of Honor",
        tips = "This is the single-rider vendor mammoth. Grand Black War Mammoth is the separate rare raid drop. Honor points and Marks of Honor are different resources.",
        sourceComments = {5236050, 1814355},
        steps = {
            "Collect 15 Marks of Honor from PvP reward sources and place them in this character's bags. The vendor requires the actual Mark of Honor item, not 15 Honor points or old Stone Keeper's Shards.",
            "Travel to outdoor Wintergrasp in Northrend on a " .. mount[3] .. " character and check which faction controls the fortress. The quartermasters are in the courtyard near 51.7, 17.2. Check outside an active battle instance if you only want the outdoor vendor.",
            "When the friendly quartermaster is available, speak to " .. mount[4] .. " and buy Reins of the Black War Mammoth for 15 Marks of Honor. If the opposing faction controls this outdoor copy, return later or use a character of that faction to buy its counterpart.",
            "Use the reins and check your Mount Journal. The faction counterparts are shared with eligible characters; there is no reason to farm Vault bosses for this particular item.",
        },
        waypoints = {
            pin(123, 51.7, 17.2, 2, "Wintergrasp fortress quartermasters", "Wintergrasp"),
            pin(123, 51.7, 17.2, 3, mount[4] .. " - 15 Marks of Honor", "Wintergrasp"),
        },
    })
end

-- Every faction item's comments were read separately; old Emblem/Justice prices
-- and old guild discounts were compared with the live vendor cost records.
local meiMounts = {
    {59791, "Wooly Mammoth", 44230, "Alliance", 10000},
    {59793, "Wooly Mammoth", 44231, "Horde", 10000},
    {60114, "Armored Brown Bear", 44225, "Alliance", 750},
    {60116, "Armored Brown Bear", 44226, "Horde", 750},
    {61229, "Armored Snowy Gryphon", 44689, "Alliance", 2000},
    {61230, "Armored Blue Wind Rider", 44690, "Horde", 2000},
    {61425, "Traveler's Tundra Mammoth", 44235, "Alliance", 20000},
    {61447, "Traveler's Tundra Mammoth", 44234, "Horde", 20000},
}
for _, mount in ipairs(meiMounts) do
    local spell, name, item, faction, price = unpack(mount)
    local vendors = spell == 61425 or spell == 61447
    add(spell, name, item, {
        category = "Vendor", source = "Mei Francis - Northrend Dalaran", npcId = 32216,
        cost = price .. " gold base; " .. (price * 0.8) .. " gold with an Exalted Kirin Tor discount",
        tips = vendors and "Includes repair and trade vendors. Eject them using the passenger controls to free the seats; remount to restore them."
            or "No reputation is required to buy it. Kirin Tor reputation reduces the gold price; it does not unlock an extra version.",
        steps = {
            "Use an eligible " .. faction .. " character and take a portal or travel to the original Dalaran above Crystalsong Forest in Northrend. Legion Dalaran above the Broken Isles is a different city and map.",
            "Find Mei Francis outdoors at 57.8, 42.5, near the entrance to the Horde quarter. The pet shop and Breanni are nearby but are not the mount vendor. Bring " .. price .. " gold to cover the undiscounted cost.",
            "Buy " .. (name == "Wooly Mammoth" and "Reins of the Wooly Mammoth" or name == "Armored Brown Bear" and "Reins of the Armored Brown Bear" or vendors and "Reins of the Traveler's Tundra Mammoth" or name) .. ". The price shown by Mei includes the character's applicable Kirin Tor discount. This is a gold purchase in Retail; do not farm old Emblems or Justice Points.",
            "Use the item in your bags, then find " .. name .. " in Collections > Mounts. " .. (vendors and "Summon it outdoors to use its vendors. To carry friends, invite them to your party and eject the NPC passengers first." or "Summon the faction version available to this character; the journal handles eligible faction counterparts."),
        },
        waypoints = {
            pin(125, 57.8, 42.5, 2, "Mei Francis - outdoor exotic mount vendor", "Dalaran (Northrend)"),
            pin(125, 57.8, 42.5, 3, "Mei Francis - buy " .. name, "Dalaran (Northrend)"),
        },
    })
end

-- https://www.wowhead.com/item=44080#comments:id=456034
-- https://www.wowhead.com/item=43961#comments:id=474954
-- Preserve the useful Sons of Hodir progression, but correct the faction labels:
-- 59797/61469 are Horde; 59799/61470 are Alliance.
for _, mount in ipairs({
    {59797, "Ice Mammoth", 44080, "Horde", "Revered", 1000},
    {59799, "Ice Mammoth", 43958, "Alliance", "Revered", 1000},
    {61469, "Grand Ice Mammoth", 44086, "Horde", "Exalted", 10000},
    {61470, "Grand Ice Mammoth", 43961, "Alliance", "Exalted", 10000},
}) do
    local spell, name, item, faction, standing, price = unpack(mount)
    add(spell, name, item, {
        category = "Reputation", source = "Lillehoff - " .. standing .. " with the Sons of Hodir", npcId = 32540,
        cost = price .. " gold base, reduced by applicable reputation discounts",
        tips = name == "Grand Ice Mammoth" and "Carries two passengers but has no vendors. Traveler's Tundra Mammoth is the version with vendors."
            or "The ordinary Ice Mammoth needs Revered, not Exalted. Its price is one tenth of the Grand Ice Mammoth's base price.",
        sourceComments = {456034, 474954},
        steps = {
            "If the Sons of Hodir are hostile, start They Took Our Men! with Gretchen Fizzlespark in K3 (41.1, 86.1). Complete the Brunnhildar and Thorim introduction through Sibling Rivalry and Mending Fences. Enable Trivial Quests so the old quest markers remain visible.",
            "While doing Mending Fences, loot the Slag Covered Metal from the stormforged enemies and complete The Refiner's Fire and A Spark of Hope. Continue the Thorim/Hodir follow-ups until Dun Niffelem is friendly and its vendors and repeatable reputation quests are available.",
            "Raise the Sons of Hodir to " .. standing .. ". Complete the unlocked dailies, or turn in batches of Relics of Ulduar to Lillehoff at Dun Niffelem (66.1, 61.4). The relics can be farmed from Northrend enemies or bought; check your bar before buying more than you need.",
            "On a " .. faction .. " character, return to Lillehoff and buy Reins of the " .. name .. ". Bring the " .. price .. "-gold base price; the displayed cost is lower when reputation discounts apply.",
            "Use the reins to add the mount to your collection. " .. (name == "Grand Ice Mammoth" and "Invite friends to your party to use the two passenger seats. There are no repair or trade NPCs to unlock on this mount." or "This is the single-rider Ice Mammoth. The separate Grand Ice Mammoth requires Exalted and a larger gold purchase."),
        },
        waypoints = {
            pin(120, 41.1, 86.1, 1, "Gretchen Fizzlespark - unlock Sons of Hodir", "The Storm Peaks"),
            pin(120, 66.1, 61.4, 3, "Lillehoff - Relics of Ulduar reputation turn-ins", "The Storm Peaks"),
            pin(120, 66.1, 61.4, 4, "Lillehoff - buy " .. name, "The Storm Peaks"),
        },
    })
end

-- https://www.wowhead.com/item=44151#comments:id=1428041 (+ replies)
-- https://www.wowhead.com/item=44151#comments:id=485852 (+ replies)
add(59996, "Blue Proto-Drake", 44151, {
    category = "Dungeons", source = "Skadi the Ruthless - Heroic Utgarde Pinnacle", npcId = 26693,
    tips = "Heroic only. The first two bosses are optional for this farm. The three-minute achievement neither guarantees the mount nor needs to be completed for it to drop.",
    sourceComments = {1428041, 485852},
    steps = {
        "Set Dungeon Difficulty to Heroic outside the instance. Fly to Utgarde Keep in Howling Fjord and use the upper Utgarde Pinnacle entrance (57.3, 46.7), not the lower Utgarde Keep portal.",
        "Follow the halls toward Skadi's gauntlet. You can pass Svala Sorrowgrave and Gortok Palehoof without starting their encounters; kill only trash blocking your route.",
        "Approach Skadi to start his flight on Grauf, then move along the gauntlet toward the harpoon launchers. Kill the Ymirjar Harpooners and loot at least three Harpoons from their corpses.",
        "Wait for Grauf to pass within harpoon range. Click a launcher repeatedly to fire the three Harpoons. Stay out of the blue freezing-breath lane while waiting for the next pass if necessary.",
        "When Skadi lands, kill him and loot his body. Learn Reins of the Blue Proto-Drake if it drops. Do not leave after shooting Grauf without looting Skadi.",
        "A Heroic boss kill gives one daily attempt per eligible character. Return after the daily reset or use another character; resetting the already-saved Heroic does not give another mount roll.",
    },
    waypoints = { pin(117, 57.3, 46.7, 1, "Utgarde Pinnacle - upper entrance, Heroic", "Howling Fjord") },
})

-- https://www.wowhead.com/item=44168#comments:id=451683
-- https://www.wowhead.com/item=44168#comments:id=501456
-- Contemporary search points are retained from the curated Retail source index;
-- old Dirkee/shared-timer and guaranteed-spawn folklore are excluded.
add(60002, "Time-Lost Proto-Drake", 44168, {
    category = "Rare Spawns", source = "Time-Lost Proto-Drake - The Storm Peaks", npcId = 32491,
    tips = "The four pins are patrol-search/camping areas, not four guaranteed stationary spawns. Vyragosa shares this rare's spawn cycle; Dirkee does not. No exact spawn time is guaranteed.",
    sourceComments = {451683, 501456, 484974},
    steps = {
        "Travel to the Storm Peaks in Northrend and choose the same phase and War Mode setting as anyone camping with you. Use a ground-accessible pull spot or prepare a way to land safely; the rare patrols in the air.",
        "Cover the western Bor's Breath/waterfall area near 31.0, 69.0. Watch the canyon and the air above it. The Time-Lost Proto-Drake is gold-brown; the much more common blue rare Vyragosa is not the mount source.",
        "Cover the southern Frozen Lake/Frosthold approach near 35.0, 76.0. If camping in a small party, assign different search areas and communicate sightings before attacking.",
        "Check the Brunnhildar route near 51.0, 70.0 and the northern Ulduar-ravine route near 52.0, 34.0. Fly between the marked areas if searching alone. A single coordinate cannot cover every patrol path.",
        "When the actual Time-Lost Proto-Drake appears, check that its nameplate is loot-eligible for you before killing it. For a group attempt, gather nearby and arrange participation before using an attack that can instantly kill this old rare. Do not assume a distant party member will receive loot.",
        "Bring it over safe ground where possible, kill it, loot Reins of the Time-Lost Proto-Drake, and learn the mount. The reins are guaranteed from a loot-eligible kill; the uncertain part is finding and tagging the rare.",
        "If you find Vyragosa instead, killing her frees the shared spawn cycle for a future spawn, but does not guarantee that the next one is Time-Lost. Record sightings if helpful and return without relying on old item-cache macros or a promised weekly appearance.",
    },
    waypoints = {
        pin(120, 31.0, 69.0, 2, "Bor's Breath / waterfall - patrol search area", "The Storm Peaks"),
        pin(120, 35.0, 76.0, 3, "Frozen Lake / Frosthold - patrol search area", "The Storm Peaks"),
        pin(120, 51.0, 70.0, 4, "Brunnhildar - patrol search area", "The Storm Peaks"),
        pin(120, 52.0, 34.0, 4, "Ulduar ravine - patrol search area", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=44707#comments:id=1733355 (+ replies)
-- https://www.wowhead.com/item=44707#comments:id=1261602
add(61294, "Green Proto-Drake", 44707, {
    category = "Reputation", source = "Mysterious Egg - The Oracles", npcId = 31910,
    cost = "3 gold base per Mysterious Egg; Revered with the Oracles",
    tips = "The Retail egg takes three real days, including logged-out time. Seven-day instructions are obsolete. The mount is a chance reward, not a guaranteed hatch.",
    sourceComments = {1733355, 1261602, 1325459, 1174303},
    steps = {
        "If the Oracles are not unlocked, take The Part-time Hunter from Tamara Wobblesprocket at Lakeside Landing (50.4, 62.0), kill Pitch near 50.5, 77.0, and accept Playing Along from Tracker Gekgek. Follow the Frenzyheart jobs through Hoofing It and Just Following Orders. Help the injured oracle, finish Fortunate Misunderstandings, and follow the Oracles story through The Angry Gorloc, The Mosswalker Savior, and Lifeblood of the Mosswalker Shrine to unlock A Hero's Burden. You initially help both factions; the permanent choice comes next.",
        "Enter the cave at 70.8, 58.7 and fight Artruis the Heartless. When his two captives become attackable, kill Zepik the Gorloc Hunter and keep Jaloot alive to choose the Oracles. Complete Jaloot's offered follow-up and return to Rainspeaker Canopy. If already aligned with Frenzyheart, this encounter also lets you switch sides.",
        "Do the Oracles dailies at Rainspeaker Canopy (about 54.6, 56.1) until Revered. Check each day's available quests; reaching Friendly is only the start, not enough to buy the egg.",
        "Buy one Mysterious Egg from Geen at Rainspeaker Canopy. Keep the unique egg in your inventory and wait three real days for it to become a Cracked Egg. You cannot speed the timer by remaining online.",
        "Open the Cracked Egg. If it contains Reins of the Green Proto-Drake, use them. Otherwise clear the opened egg and buy another one from Geen; repeat the three-day cycle. The pets and Aged Yolk are normal unsuccessful results.",
    },
    waypoints = {
        pin(119, 50.4, 62.0, 1, "Tamara Wobblesprocket - The Part-time Hunter", "Sholazar Basin"),
        pin(119, 50.5, 77.0, 1, "Pitch encounter - start the faction story", "Sholazar Basin"),
        pin(119, 70.8, 58.7, 2, "Artruis cave entrance - choose Jaloot / Oracles", "Sholazar Basin"),
        pin(119, 54.6, 56.1, 3, "Rainspeaker Canopy - Oracles dailies", "Sholazar Basin"),
        pin(119, 54.6, 56.1, 4, "Geen - buy Mysterious Egg at Revered", "Sholazar Basin"),
        pin(119, 54.6, 56.1, 5, "Geen - repeat egg purchases", "Sholazar Basin"),
    },
})

-- https://www.wowhead.com/item=44083#comments:id=626536
-- https://www.wowhead.com/item=43959#comments:id=589210
for _, mount in ipairs({ {61465, 43959, "Alliance"}, {61467, 44083, "Horde"} }) do
    add(mount[1], "Grand Black War Mammoth", mount[2], {
        category = "Dungeon and Raids", source = "Vault of Archavon bosses",
        tips = "Rare drop from all four Vault bosses in either size. This three-person mammoth has no vendors. The cheaper Black War Mammoth is a separate Wintergrasp purchase.",
        sourceComments = {626536, 589210},
        steps = {
            "Travel to outdoor Wintergrasp while your faction controls the fortress. Set a legacy raid size outside, then enter the Vault of Archavon portal at the back of the fortress (50.0, 11.9). The battleground queue is not the raid entrance.",
            "Kill and loot all four bosses: Archavon, Emalon, Koralon, and Toravon. Each can drop the reins; do not stop after the first boss just because the raid is named for Archavon.",
            "If the reins appear, use the " .. mount[3] .. " version from your bags. The mount carries two party passengers, but no trade or repair NPCs.",
            "If no reins drop, check your raid information before making another trip. Use other eligible characters or return after the weekly reset. Where the two legacy size lockouts are separate, an unused size provides another clear; repeating the same saved size does not.",
        },
        waypoints = { pin(123, 50.0, 11.9, 1, "Vault of Archavon portal - faction must control fortress", "Wintergrasp") },
    })
end

-- The item has no qualifying profit acquisition list. Cross-read the full
-- high-level route and its replies, then each delicate criterion separately.
-- https://www.wowhead.com/achievement=2136#comments:id=3225242 (+ replies)
-- The reply corrects the inverted Oculus Void instructions in that comment.
-- https://www.wowhead.com/achievement=2043#comments:id=2466247
-- https://www.wowhead.com/achievement=2155#comments:id=2878906
-- https://www.wowhead.com/achievement=1872#comments:id=1913148
-- https://www.wowhead.com/achievement=1864#comments:id=6389232
add(59961, "Red Proto-Drake", 44160, {
    category = "Achievements", source = "Glory of the Hero - original Wrath Heroic dungeons",
    tips = "Set every dungeon to Heroic before entering. Track the actual meta criteria: Share the Love is no longer required. Remove pets and passive damage for waiting mechanics. Oculus drake colors and Violet Hold's random bosses require repeat visits.",
    sourceComments = {3225242, 2466247, 2878906, 1913148, 6389232},
    steps = {
        "Track Glory of the Hero and its unfinished criteria. Use a strong Retail character, but bring a way to reduce damage for mechanics that need a living boss: unequip weapons and proc gear, disable pets, and consider Whole-Body Shrinka' if you own it. Check every criterion before killing its boss, because Heroic bosses save you for the day.",
        "Utgarde Keep, lower entrance in Howling Fjord (58.2, 48.9): kill Prince Keleseth without shattering a Frost Tomb for On The Rocks. A fast single-target kill avoids the tomb mechanic entirely.",
        "The Nexus, bottom Nexus portal in Coldarra (27.5, 26.2): kill Keristrasza before Intense Cold exceeds two stacks, moving or jumping if the fight lasts. Kill Telestra quickly, or kill all split images within five seconds of one another. Kill Anomalus without destroying any Chaotic Rifts.",
        "Azjol-Nerub, Dragonblight (26.0, 50.6): kill Krik'thir while Gashra, Narji, and Silthik remain alive; use single-target damage. Reach and kill Hadronox before the top doors are webbed. Kill Anub'arak within four minutes, including any scripted underground phases.",
        "Ahn'kahet, the other Azjol-Nerub complex entrance (28.3, 51.6): kill Nadox without killing an Ahn'kahar Guardian, finish Volazj within two minutes, and defeat Jedoga without killing a Twilight Volunteer. If you do not kill Jedoga immediately, allow her chosen volunteer to finish its sacrifice.",
        "Drak'Tharon Keep, southern Zul'Drak approach (28.6, 86.9): kill Trollgore before ten Consume stacks. At Novos, intercept the undead and Crystal Handlers on the stairs before any reach the floor. Pull King Dred, kill six eligible raptor adds while he is engaged, then finish him; killing the raptors first does not count.",
        "Original Violet Hold, Northrend Dalaran (67.9, 69.4): finish with full prison integrity and without using Defense Control Crystals for Defenseless. Kill Ichoron before globules merge, and Zuramat without killing Void Sentries. For Lockdown!, defeat all six listed random prison bosses over multiple Heroic visits; each run releases only two of them.",
        "Gundrak, Zul'Drak (76.3, 21.1): kill Slad'ran before being snake-wrapped and Moorabi before any mammoth transformation. After the western boss, take the side passage to Eck, wait for his spit to apply Eck Residue, and retain that debuff until Gal'darah dies. Activate the main-boss altars to open the final route. Do not cleanse the residue or die before the final boss.",
        "Halls of Stone, western Ulduar dungeon approach: defeat the Maiden within the Good Grief timer. Protect Brann throughout the Tribunal event so he takes no damage. At Sjonnir, reduce his health carefully to around half, stop attacking him, let Malformed Oozes merge, kill five Iron Sludges during the encounter, then finish Sjonnir.",
        "Halls of Lightning, eastern Ulduar dungeon approach: wait until General Bjarngrim visibly has Temporary Electrical Charge before killing him. Kill Volkhan before he shatters any Brittle Golems, and kill Loken within two minutes. Do not pull Bjarngrim during his uncharged patrol just because he is easy to kill.",
        "Heroic Culling of Stratholme, Caverns of Time: begin Chromie's crate sequence and Arthas's event. For Zombiefest!, gather at least 100 Risen Zombies without killing them, allowing respawns before Salramm dies, then kill 100 within one minute. Remove all passive area damage. Separately reach the optional Infinite Corruptor before the 25-minute timer ends for The Culling of Time; follow the side path at the final Market Row approach before Mal'Ganis.",
        "Utgarde Pinnacle, upper Howling Fjord entrance (57.3, 46.7): for The Incredible Hulk, keep a Scourge Hulk alive, weaken it with controlled damage, and position it beneath Svala's ritual sword so her strike kills it. Do not kill either target early. For Skadi, collect three Harpoons and fire them in one pass, then finish him within three minutes. Kill Ymiron without triggering Bane; a fast kill avoids it.",
        "The Oculus, middle Nexus ring: plan three Heroic completions on the same character, riding a different drake color for each Eregos kill. Finish within 20 minutes of Drakos for Make It Count. The Void achievements mean WITHOUT that color: a solo Ruby clear excludes Amber and Emerald, and a solo Amber or Emerald clear excludes Ruby. For Amber, build Temporal Rift charges and spend them with Shock Lance, using Stop Time; for Emerald, maintain Leeching Poison and use its healing/damage tools. Bring help using the same chosen color if a solo vehicle kill is difficult.",
        "Reopen Glory of the Hero, finish any missing random-boss or drake-color criteria after the appropriate daily resets, then check your mailbox for Reins of the Red Proto-Drake. Use the reins. The three Icecrown five-player dungeons and Trial of the Champion are not part of this original dungeon meta.",
    },
    waypoints = {
        pin(117, 58.2, 48.9, 2, "Utgarde Keep - lower dungeon entrance", "Howling Fjord"),
        pin(114, 27.5, 26.2, 3, "The Nexus - bottom portal", "Borean Tundra"),
        pin(115, 26.0, 50.6, 4, "Azjol-Nerub entrance", "Dragonblight"),
        pin(115, 28.3, 51.6, 5, "Ahn'kahet entrance", "Dragonblight"),
        pin(121, 28.6, 86.9, 6, "Drak'Tharon Keep - southern Zul'Drak approach", "Zul'Drak"),
        pin(125, 67.9, 69.4, 7, "Original Violet Hold entrance", "Dalaran (Northrend)"),
        pin(121, 76.3, 21.1, 8, "Gundrak entrance", "Zul'Drak"),
        pin(120, 39.6, 26.9, 9, "Halls of Stone entrance", "The Storm Peaks"),
        pin(120, 45.4, 21.4, 10, "Halls of Lightning entrance", "The Storm Peaks"),
        pin(71, 64.4, 50.0, 11, "Caverns of Time entrance", "Tanaris"),
        pin(75, 56.9, 82.4, 11, "Culling of Stratholme - Heroic portal", "Caverns of Time"),
        pin(117, 57.3, 46.7, 12, "Utgarde Pinnacle - upper entrance", "Howling Fjord"),
        pin(114, 27.52, 26.65, 13, "The Oculus - middle Nexus ring above ground entrance", "Borean Tundra"),
    },
})

-- https://www.wowhead.com/item=45693#comments:id=806970 (+ full replies)
-- The edited parent and recent reply explicitly supersede 10/25 switching.
add(63796, "Mimiron's Head", 45693, {
    category = "Dungeon and Raids", source = "Yogg-Saron with no Keepers assisting - Ulduar", npcId = 33288,
    tips = "Current Ulduar has one merged size. The mount condition is zero assisting Keepers, not a 25-player selector. Do not talk to the defeated Keepers to request their help.",
    sourceComments = {806970, 2019134},
    steps = {
        "Enter the normal legacy Ulduar raid in the Storm Peaks (41.6, 18.2), rather than a queued Timewalking instance. Use your own weekly lockout. The old instructions to clear in 10-player and switch to 25-player are obsolete after Ulduar's merger.",
        "Start the entrance assault, use a siege vehicle if needed, and defeat Flame Leviathan. Continue through XT-002 Deconstructor and Kologarn into the inner ring. Ignis, Razorscale, and the Assembly of Iron are not required detours just to reach Yogg-Saron.",
        "Defeat Hodir, Thorim, Freya, and Mimiron to unlock the way onward. After each win, leave that Keeper's assistance dialogue alone. Their defeated friendly versions on the inner ring must not be asked to help in Yogg-Saron's chamber.",
        "Defeat General Vezax and enter Yogg-Saron's prison. Keep zero Keepers assisting. In the first phase, kill the spawned Guardians beside Sara so their explosions trigger the phase transition; repeatedly hitting Sara directly does not replace this mechanic.",
        "When the portal phase begins, enter a brain portal, clear the illusion's tentacles, and damage the brain before Induce Madness completes. Use the exit portal in time and avoid losing all Sanity; repeat the portal sequence if needed.",
        "In the final phase, turn away from Lunatic Gaze when necessary, kill Yogg-Saron, and loot him. Learn Mimiron's Head if it drops. Alone in the Darkness can confirm the zero-Keeper setup, but completing it does not guarantee the mount.",
        "Return after the weekly reset or use another eligible character if the mount did not drop. Re-running the same saved boss or changing a legacy size setting does not produce another roll.",
    },
    waypoints = { pin(120, 41.6, 18.2, 1, "Ulduar raid entrance - zero-Keeper Yogg route", "The Storm Peaks") },
})

-- https://www.wowhead.com/achievement=12401#comments:id=2547651
-- https://www.wowhead.com/achievement=12401#comments:id=2545906
-- https://www.wowhead.com/achievement=12322#comments:id=2557992 (+ full replies)
-- https://www.wowhead.com/achievement=12330#comments:id=6054277 (+ full replies)
-- https://www.wowhead.com/achievement=12373#comments:id=2860394
for _, mount in ipairs({ {63956, "Ironbound Proto-Drake", 45801}, {63963, "Rusted Proto-Drake", 45802} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Achievements", source = "Glory of the Ulduar Raider - current merged achievement",
        tips = "The current meta awards both Rusted and Ironbound. Use achievement 12401, not the retired separate 10/25-player metas. Plan controlled damage before Razorscale and XT; accidental kills consume that week's attempt.",
        sourceComments = {2547651, 2545906, 2557992, 6054277, 2860394},
        steps = {
            "Track Glory of the Ulduar Raider (12401). Enter the normal legacy Ulduar raid at 41.6, 18.2 in the Storm Peaks. Before pulling, remove damage-proc equipment, dismiss attacking pets, and arrange a low-damage option such as Whole-Body Shrinka' for the delicate encounters.",
            "Flame Leviathan - Orbit-uary: talk to the Lore Keeper of Norgannon at the entrance to activate the orbital defenses, leave all four defense towers intact, then kill Leviathan. Starting the ordinary assault without the defense systems is not the required hard mode.",
            "Razorscale - Iron Dwarf, Medium Rare: keep Dark Rune Guardian dwarves alive. Let the engineers finish the launchers, wait for Razorscale's berserk to strengthen her breath, then harpoon her down and position the Guardians in front of her. Let her breath kill 25 Guardians. Reduce her below half only with controlled damage if you want her permanently grounded. Track the dwarf counter; if short, reset without killing her and continue, since the counter can accumulate across attempts.",
            "Ignis - Stokin' the Furnace: kill him within four minutes. XT-002 - Heartbreaker: carefully lower XT to about 75%, stop attacking the body as the heart emerges, destroy the exposed heart on that first phase, then kill the restored hard-mode boss. A one-shot on XT bypasses the heart and fails the criterion.",
            "Assembly of Iron - I Choose You, Steelbreaker: kill Runemaster Molgeim and Stormcaller Brundir before Steelbreaker. Kologarn - Disarmed: destroy both arms, then finish the body within 12 seconds. Auriaya - Crazy Cat Lady: kill Auriaya with single-target damage while her Sanctum Sentries remain alive.",
            "Hodir - I Could Say That This Cache Was Rare: defeat him quickly enough to preserve the rare cache. Thorim - Lose Your Illusion: start the arena event, clear its opening, operate the gauntlet access, and reach Thorim before Sif leaves, then defeat him with Sif present. Do not wait out the hard-mode timer.",
            "Freya - Knock, Knock, Knock on Wood: leave all three named Elders alive before engaging Freya, then complete the encounter. Clearing the Elder mini-bosses for convenience disables this criterion.",
            "Mimiron - Firefighter: press the big red button before beginning the fight to enable Self-Destruct. Defeat each phase, then disable the three combined machine sections close together so they cannot repair one another. The ordinary Mimiron kill does not count.",
            "General Vezax - I Love the Smell of Saronite in the Morning: keep Vezax alive and do not kill any Saronite Vapors. Wait for all eight to combine into the Saronite Animus. Kill the Animus first, then Vezax. Killing a vapor can prevent the required Animus from spawning.",
            "Yogg-Saron - One Light in the Darkness: use at most one Keeper's assistance. Zero is also valid and preserves a Mimiron's Head chance. Kill Guardians beside Sara, enter brain portals, clear the illusion and damage the brain before Induce Madness, then exit and finish Yogg without exhausting Sanity.",
            "Check the tracked meta for any failed encounter before ending the run. Return on a later weekly lockout for a boss killed with its condition unmet. When the current meta completes, check the journal and mailbox for both proto-drakes and learn any reins received; there is no second 25-player meta to grind.",
        },
        waypoints = { pin(120, 41.6, 18.2, 1, "Ulduar raid entrance - current merged meta", "The Storm Peaks") },
    })
end

-- https://www.wowhead.com/item=49636#comments:id=2496213
add(69395, "Onyxian Drake", 49636, {
    category = "Dungeon and Raids", source = "Onyxia - Onyxia's Lair", npcId = 10184,
    tips = "Normal raid only; both legacy sizes can drop the mount. Their shared weekly save means changing size after a kill does not give a second attempt on that character.",
    sourceComments = {2496213, 891608},
    steps = {
        "Fly to Onyxia's Lair in southern Dustwallow Marsh (52.3, 76.2). Set a legacy raid size outside. There is no Heroic version to unlock and no old Drakefire Amulet attunement to complete in Retail.",
        "Enter, clear the short approach, and engage Onyxia in the final cave. Avoid entering the whelp tunnels unnecessarily. On a strong Retail character the ground phases are brief.",
        "If she takes flight before dying, use ranged attacks that can reach her and clear the whelps and guards while waiting for her to land. Melee-only damage may have to wait for the ground phase; the flying phase is not a failed mount attempt.",
        "Kill and loot Onyxia. If Reins of the Onyxian Drake appear, use them. Otherwise return after the weekly reset or try another eligible character; the mount is a rare drop rather than a timed or deathless reward.",
    },
    waypoints = { pin(70, 52.3, 76.2, 1, "Onyxia's Lair entrance", "Dustwallow Marsh") },
})

-- https://www.wowhead.com/item=50818#comments:id=1649770
-- https://www.wowhead.com/item=50818#comments:id=2510288
-- The useful route is retained; obsolete automatic Group Finder lockout tricks
-- are not a required part of a straightforward weekly Retail clear.
add(72286, "Invincible", 50818, {
    category = "Dungeon and Raids", source = "The Lich King - 25-player Heroic Icecrown Citadel", npcId = 36597,
    tips = "The mount drops on 25-player Heroic only. Check the size and difficulty before killing the Lich King. Valithria can be bypassed for the mount farm, unlike the Frostbrood meta route.",
    sourceComments = {1649770, 2510288, 1843100},
    steps = {
        "At the ground-level Icecrown Citadel raid entrance (53.7, 87.0 in Icecrown), set the legacy raid to 25-player Heroic. Enter the raid itself, not one of the nearby five-player dungeons. Use an unsaved weekly lockout.",
        "Clear Marrowgar and Deathwhisper, then start the gunship event. Take a rocket pack if needed, use the cannons, and handle the enemy mage if the cannons freeze. Continue through Deathbringer Saurfang.",
        "Clear all three upper branches needed to unlock the Frozen Throne: Festergut, Rotface and Putricide; the Blood Princes and Blood-Queen Lana'thel; then Sindragosa. Use the transporters as they unlock. For this mount-only route, you can pass around Valithria Dreamwalker without healing her.",
        "Make sure Putricide's and the other wing-end access requirements are finished, then use the central upper-spire teleporter to the Frozen Throne. Confirm that the Lich King encounter is still 25-player Heroic before telling Tirion to begin.",
        "Defeat the Lich King while avoiding Shadow Traps and the platform edge. At his scripted mass-kill ending, remain in the encounter and wait for the resurrection and Tirion's sequence; do not release spirit simply because he killed you. Finish him when attackable again.",
        "Loot the Lich King and use Invincible's Reins if they drop. This is a rare weekly chance, not a guaranteed Heroic reward. Return after reset or clear on other eligible characters; a Normal kill or 10-player kill is not a mount attempt.",
    },
    waypoints = { pin(118, 53.7, 87.0, 1, "Icecrown Citadel raid - 25-player Heroic", "Icecrown") },
})

-- https://www.wowhead.com/achievement=4603#comments:id=2103691
-- https://www.wowhead.com/achievement=4539#comments:id=3287684 (+ reply)
-- https://www.wowhead.com/achievement=4601#comments:id=6022006 (+ full replies)
-- The latter is a current numbered-style route ending in Profit. Adapt its
-- stack/wait/finish sequence and omit the closing step; the replies warn that
-- the stairs are not unconditional protection from Shadow Traps.
-- https://www.wowhead.com/achievement=4621#comments:id=6137875 (+ reply)
for _, mount in ipairs({ {72808, "Bloodbathed Frostbrood Vanquisher", 51954, 10}, {72807, "Icebound Frostbrood Vanquisher", 51955, 25} }) do
    local spell, name, item, size = unpack(mount)
    add(spell, name, item, {
        category = "Achievements", source = "Glory of the Icecrown Raider (" .. size .. " player)",
        tips = "Use the matching raid size for every criterion. Plan two weekly Lana'thel kills on the same character, one bitten and one unbitten. Bring a healer for Valithria and stop passive damage for Full House and Necrotic Plague.",
        sourceComments = {2103691, 3287684, 6022006, 6137875},
        steps = {
            "Track Glory of the Icecrown Raider (" .. size .. " player). Set the raid to " .. size .. "-player Heroic before entering Icecrown Citadel (53.7, 87.0). Heroic wing completions are part of the meta, so a purely Normal clear will not finish it. Arrange a healer and damage control before the setup encounters.",
            "Marrowgar - Boned: kill quickly or free any impaled player within eight seconds. Deathwhisper - Full House: leave her mana barrier intact, let cultist waves spawn and transform, and keep five different required types alive together: Cult Fanatic, Deformed Fanatic, Reanimated Fanatic, Cult Adherent, and Reanimated Adherent. Only then break the shield and kill her with single-target damage; dismiss pets and avoid cleaves that would kill the adds.",
            "Gunship - I'm on a Boat: use the cannons, and keep every player's visits to the enemy ship to at most one. On a strong legacy clear, destroy it without boarding if possible. Saurfang - I've Gone and Made a Mess: defeat him before enough Marks of the Fallen Champion accumulate to fail the criterion.",
            "Plagueworks: kill Rotface before any Big Ooze casts Unstable Ooze Explosion; kill Festergut before anyone reaches three Inoculated stacks. At Putricide, never use the mutated abomination's Regurgitated Ooze slow; a quick kill avoids needing the vehicle. Complete the branch on Heroic.",
            "Blood Princes - The Orb Whisperer: kill the empowered prince quickly and avoid large empowered-orb hits on the group. Lana'thel - Once Bitten, Twice Shy: for one kill, body-pull, let combat register, and kill before receiving Essence of the Blood Queen. For the other, wait until that debuff actually appears, then kill her before its feeding/charm stage. Plan the second outcome on the same character after the weekly reset, in the same raid size.",
            "Valithria - Portal Jockey: heal her to full before any portals spawn. This satisfies the no-missed-portal condition and is much simpler than entering portals solo and resetting the encounter. If portals do spawn, every one must be used by the group before finishing. A healer is the reliable option; do not skip Valithria on this meta route.",
            "Sindragosa - All You Can Eat: kill quickly before anyone exceeds five Mystic Buffet stacks. If the fight lasts, use the ice tombs to reset stacks. Finish both Frostwing encounters on Heroic for the wing criterion.",
            "Lich King - Been Waiting a Long Time for This: remove attacking pets, damage auras, and automatic damage equipment. Start Tirion's dialogue, keep the boss in phase one without damaging him, and let him summon adds while Necrotic Plague jumps between them and you. The bottom throne steps can help your position, but actively avoid Shadow Traps and heal if needed; do not assume the staircase guarantees safety.",
            "Watch the actual Necrotic Plague stack count on yourself or the adds. It can disappear from your debuffs while on another target. Wait until one plague reaches at least 30 stacks, then finish the Lich King. Do not use his separate Plague Siphon buff as the counter. Wait through the scripted death, resurrection, and final kill before judging whether the achievement completed.",
            (size == 25 and "For the 25-player meta, also complete Neck-Deep in Vile: kill every spawned Vile Spirit before it explodes, then defeat the Lich King. If your high-level kill skips their phase entirely, verify the awarded criterion after the ending." or "Check the 10-player meta directly: Neck-Deep in Vile is not one of its required criteria. Spend the remaining lockouts on the criteria the tracked meta actually lists."),
            "Return after reset for the opposite Lana'thel outcome and any failed boss conditions. Once all matching-size criteria and Heroic wings complete, check the mailbox for Reins of the " .. name .. " and use them. The 10- and 25-player metas award different mounts and remain separate in Retail.",
        },
        waypoints = { pin(118, 53.7, 87.0, 1, "Icecrown Citadel - " .. size .. "-player Heroic meta route", "Icecrown") },
    })
end

-- https://www.wowhead.com/item=52200#comments:id=1017875 (+ full replies)
-- https://www.wowhead.com/item=52200#comments:id=1024366 (+ reply)
-- https://www.wowhead.com/quest=24545#comments:id=2167123 (+ replies)
-- https://www.wowhead.com/quest=24547#comments:id=6218544
-- https://www.wowhead.com/quest=24749#comments:id=2086520
-- https://www.wowhead.com/quest=24756#comments:id=952631
add(73313, "Crimson Deathcharger", 52200, {
    category = "Quest Rewards", source = "Mograine's Reunion - Shadowmourne chest, or traded reins",
    tips = "The finished reins can be traded and do not require the buyer to be a Death Knight or Shadowmourne owner. The chest reward is once per completed legendary chain, not a weekly mount drop.",
    sourceComments = {1017875, 1024366, 2167123, 6218544, 2086520, 952631},
    steps = {
        "Choose the purchase or quest route. Reins of the Crimson Deathcharger can be bought on the Auction House or traded by another player; if you buy the actual reins, use them directly and skip the legendary chain. This is different from the Death Knight's blue Acherus Deathcharger.",
        "For the quest route, use a Warrior, Paladin, or Death Knight and enter 25-player Icecrown Citadel (53.7, 87.0). Clear entrance trash to Friendly with the Ashen Verdict, then take The Sacred and the Corrupt from Highlord Darion Mograine on the left inside the entrance. Only the player completing the legendary needs this class restriction.",
        "With that quest active, visit Frostmourne Cavern in northeastern Dragonblight (74.4, 23.5). Interact with Light's Vengeance, wait through the Lich King's scene, use the hammer again as prompted, and defeat the resurrected enemy. Loot Light's Vengeance once the sequence finishes.",
        "Gather 25 Primordial Saronite and loot Rotface's Acidic Blood and Festergut's Acidic Blood from their 25-player kills. Bring all four components to Mograine's runeforge, complete the turn-ins, and obtain Shadow's Edge.",
        "For A Feast of Souls, equip Shadow's Edge and collect 50 souls from Icecrown enemies. Let Shadow's Fate apply before killing each target; instant kills can miss the credit. A Death Knight can use Chains of Ice to apply it without a damaging hit, and a Protection Warrior can use Demoralizing Shout. Watch the quest counter rather than killing an entire corridor before noticing zero progress.",
        "Unholy Infusion, 25-player Putricide: keep Shadow's Edge equipped and arrange a helper to hold the boss while you use the laboratory table to become an abomination. Let several slime puddles form, absorb them with the vehicle ability until you have 100 energy, then complete the Shadow Infusion cast. Only after the infusion buff is active should the group finish Putricide. Keep all damage controlled so the boss survives the setup.",
        "Blood Infusion, 25-player Lana'thel: with Shadow's Edge equipped, gain Blood Mirror and the initial vampire bite, then personally bite other players three times when Vampiric Bite becomes available. Bring enough helpers and coordinate their own feeding so nobody is mind-controlled before your third bite. Finish Lana'thel after the three bites; a quick ordinary kill does not complete this quest.",
        "Frost Infusion, 25-player Sindragosa: keep Shadow's Edge equipped, face the dragon, and survive four Frost Breaths before killing her. Hold damage and heal through the waiting period; do not one-shot her before the four-breath infusion is present.",
        "For The Splintered Throne, collect 50 Shadowfrost Shards from eligible 25-player boss kills over weekly lockouts. Finish forging Shadowmourne, take The Lich King's Last Stand, and kill the Lich King with the completed legendary equipped. Loot the Sealed Chest before leaving.",
        "Return the chest to Darion Mograine inside the raid and open the resulting reward container. Take Alexandros' Soul Shard to Darion for Mograine's Reunion; the reward is Reins of the Crimson Deathcharger. It is not a normal random mount roll from the Lich King.",
        "Use the reins to learn the mount, or keep them unlearned if intentionally trading them. Repeating weekly Lich King kills with the same completed Shadowmourne chain does not create a fresh chest each week.",
    },
    waypoints = {
        pin(118, 53.7, 87.0, 2, "Icecrown Citadel - Darion and Shadowmourne route", "Icecrown"),
        pin(115, 74.4, 23.5, 3, "Frostmourne Cavern - Light's Vengeance", "Dragonblight"),
        pin(118, 53.7, 87.0, 4, "Icecrown Citadel - blood drops and runeforge turn-in", "Icecrown"),
    },
})

-- Availability reviewed 2026-11-04. Source families were compared with every
-- retained spell ID, including faction variants and the surviving raid metas.
-- https://news.blizzard.com/en-us/article/23507736/wrath-of-the-lich-king-mounts-pets-and-more
-- https://www.warcraftmounts.com/crafted.php
-- https://www.warcraftmounts.com/achievement.php
-- https://www.warcraftmounts.com/mounts/plaguedprotodrake.php
rate("easy", "Finish the short Death Knight introduction; there is no rare drop or reputation grind.", {48778})
rate("easy", "Buy the class mount for gold after unlocking Acherus on a Death Knight.", {54729})
rate("easy", "Buy the chosen faction mount for gold; no rare drop or reputation rank is required.", {
    59791,59793,60114,60116,61229,61230,61425,61447,
})
rate("easy", "Use the matching original race to buy this inexpensive racial mount directly.", {64657,64658,64977})
rate("easy", "A high-level character can finish the Heroic timed event for a guaranteed mount.", {59569})
rate("easy", "Defeat Sartharion with all three drakes alive in the correct raid size; the mount is guaranteed.", {59571,59650})
rate("easy", "Learn Northrend Tailoring and buy or craft the basic carpet; no rare recipe is needed.", {61451})
rate("medium", "Buy the crafted motorcycle or obtain its reputation recipe, materials and vendor parts.", {55531,60424})
rate("medium", "Raise Northrend Tailoring and gather the required cloth, gems or Frozen Orbs for a personal craft.", {61309,75596})
rate("medium", "Earn 15 Marks of Honor and buy from the friendly Wintergrasp quartermaster; Arena rating is unnecessary.", {59785,59788})
rate("medium", "Raise Wyrmrest Accord reputation to Exalted, then buy the guaranteed vendor reward.", {59570})
rate("medium", "Finish the Sons of Hodir introduction and raise reputation to the mount's required rank.", {59797,59799,61469,61470})
rate("medium", "Build the usable-mount collection through ordinary vendors and deterministic rewards.", {60025,61996,61997})
rate("medium", "Complete the tournament training and one city's championship, then farm Champion's Seals.", {
    63232,63635,63636,63637,63638,63639,63640,63641,63642,63643,63844,
})
rate("medium", "Unlock a tournament championship, reach the faction's Exalted rank and earn the purchase seals.", {66087,66088,66090,66091})
rate("medium", "Complete the Horde hatchling quest chain and twenty daily turn-ins; the reward is guaranteed.", {64659})
rate("medium", "The tradable reins can bypass Shadowmourne; the self-earned route needs helpers and weekly shard farming.", {73313})
rate("hard", "Champion all five cities, reach the required Exalted reputations and earn another 100 Champion's Seals.", {66906,67466})
rate("hard", "Defeat current enemy-faction leaders with a suitable group and account for city defenses and PvP interference.", {60118,60119})
rate("hard", "Unlock Brunnhildar dailies and repeat random reward bags across daily resets.", {54753})
rate("hard", "A rare drop with daily or weekly loot limits can require many repeated clears.", {59567,59568,59996,61465,61467,63796,69395,72286})
rate("hard", "Search a contested rare-spawn route with a long, unpredictable timer shared with Vyragosa.", {60002})
rate("hard", "Reach Oracles Revered, then repeat three-day eggs until the rare mount hatches.", {61294})
rate("hard", "Fish eligible pools repeatedly for a very rare catch; there is no guaranteed completion count.", {64731})
rate("hard", "Complete the Heroic dungeon challenge meta, including controlled mechanics and repeated daily visits.", {59961})
rate("hard", "Complete the current unified Ulduar challenge meta; several mechanics need deliberate setup and repeat lockouts.", {63956,63963})
rate("hard", "Complete the matching Icecrown Heroic meta, including healing, opposite vampire states and controlled plague stacks.", {72807,72808})
rate("hard", "Wait for a rare Black Market listing and win a potentially expensive auction against other bidders.", {60021})

-- Keep list data and name-based details consistent with the current routes.
local fields = { "acquisition", "itemId", "npcId", "source", "tips", "requirements", "cost", "waypoints", "faction", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^3%.") then
        for _, entry in ipairs(patch.mounts or {}) do
            local guide = guides[entry.spellId]
            if guide then
                local detailsByName = TDP.PatchCatalog.mountDetails[patchKey]
                local details = {}
                for key, value in pairs(detailsByName[entry.name] or {}) do details[key] = value end
                for _, field in ipairs(fields) do
                    if guide[field] ~= nil then entry[field], details[field] = guide[field], guide[field] end
                end
                entry.category, details.category = guide.mountCategory, guide.mountCategory
                details.sourceType = guide.category
                detailsByName[entry.name] = details
            end
        end
    end
end
