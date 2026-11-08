-- Manually reviewed Retail acquisition routes, 2026-11-01.
-- Read every pet item's parent comments, then expand the useful reply threads.
-- No numbered acquisition comment ended in a profit step. The profit matches
-- discuss resale or incidental gold; the routes below synthesize the research.
-- Coordinates use current Retail maps, including the Northrend Underbelly.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.pets = TDP.CollectionWalkthroughs.pets or {}
local guides = TDP.CollectionWalkthroughs.pets
local function rate(level, reason, speciesIDs)
    for _, speciesID in ipairs(speciesIDs) do
        local guide = guides[speciesID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function addPet(speciesID, name, itemID, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.faction = guide.faction or "all"
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[speciesID] = guide
end

-- Reeking Pet Carrier: 32 parents; Little Fawn's Salt Lick: 27 parents.
-- https://www.wowhead.com/item=40653#comments:id=1733549
-- https://www.wowhead.com/item=40653#comments:id=1800028
-- https://www.wowhead.com/item=44841#comments:id=1707150
-- https://www.wowhead.com/item=44841#comments:id=1838589
-- Current achievement records: /achievement=1250 and /achievement=2516.
-- Vendor positions/stock: /npc=20980 and /npc=28951.
for _, pet in ipairs({
    { 160, "Stinker", 40653, 50, 1250, "Shop Smart, Shop Pet...Smart", { 1733549, 1800028 } },
    { 203, "Little Fawn", 44841, 75, 2516, "Lil' Game Hunter", { 584665, 1707150, 1838589 } },
}) do
    local speciesID, name, itemID, target, achievementID, achievement, comments = unpack(pet)
    addPet(speciesID, name, itemID, {
        category = "Achievements", source = achievement .. " - collect " .. target .. " unique species",
        sourceAchievementId = achievementID, sourceComments = comments,
        requirements = target .. " unique collected pet species across your account; duplicates do not add progress.",
        cost = "No reward purchase. Optional vendor pets and Auction House purchases cost gold.",
        tips = "Wild battle-pet captures count. Learn each new species before checking progress; an unlearned cage in your bags does not count. Retail adds this reward directly to the Pet Journal.",
        steps = {
            "Open Achievements > Pet Battles > Collect and track " .. achievement .. ". Check Collections > Pet Journal for " .. name .. " first. Your target is " .. target .. " different collected species, not " .. target .. " pets including duplicates.",
            "For a compact vendor stop, visit Dealer Rashaad on the upper Stormspire platform in Netherstorm (43.5, 35.2). Compare his seven pets with your journal: Mana Wyrmling, Brown Rabbit, Siamese Cat, Cockroach, Crimson Snake, Red Moth and Blue Dragonhawk Hatchling. Buy and learn only species you are missing.",
            "Visit Breanni inside the Magical Menagerie in Northrend Dalaran (58.6, 39.6). Check Calico Cat, Obsidian Hatchling and Albino Snake against your collection. Learning these vendor pets also counts; buying a second color counts only when it is a different journal species.",
            "Fill the remaining gap with missing wild species or inexpensive level-1 caged pets. For a wild capture, learn Battle Pet Training from a pet trainer, take a battle team, weaken a capturable opponent until the Trap action is available, and finish the battle after trapping it. Select species marked Not Collected rather than repeatedly capturing the same species.",
            "Keep checking the tracked achievement until it reaches " .. target .. " unique species. You can combine pets learned on different characters because the journal is shared. You do not need to assemble the entire collection on one character or buy rare promotional pets.",
            "Search the Pet Journal for " .. name .. " and summon it. The old item/mail instructions on the original reward page predate Retail's automatic journal reward; do not wait for Breanni to mail a carrier or salt lick.",
        },
        waypoints = {
            pin(109, 43.5, 35.2, 2, "Dealer Rashaad - seven optional missing-species purchases", "Netherstorm"),
            pin(125, 58.6, 39.6, 3, "Breanni - optional vendor species for collection progress", "Dalaran (Northrend)"),
        },
    })
end

-- Ghostly Skull: 36 parents; vendor thread 383967 expanded (9 replies).
-- https://www.wowhead.com/item=39973#comments:id=383967
-- https://www.wowhead.com/npc=29537#comments:id=2617566
-- Darahir's mapper floor 2 is UI map 126, not surface Dalaran 125.
addPet(190, "Ghostly Skull", 39973, {
    category = "Vendor", source = "Darahir - Black Market, Northrend Dalaran Underbelly", npcId = 29537,
    sourceComments = { 383967, 603178 }, cost = "40 gold base before applicable discounts.",
    requirements = "Either faction; access to Northrend Dalaran's sewers.",
    tips = "Darahir is below the city in the northern Black Market room. Breanni does not sell this pet. The old bind-on-pickup item can be learned and the resulting pet caged for trading.",
    steps = {
        "Travel to Dalaran above Crystalsong Forest in Northrend. Darahir is in this city's sewers; the similarly named Legion Dalaran is not the destination for this vendor.",
        "Enter the Underbelly through a city sewer entrance, such as the access beside Krasus' Landing. Descend before following the vendor pin; surface streets cannot reach an underground merchant. A Dalaran guard can also direct you to the sewers.",
        "On the Northrend Underbelly map, go to the Black Market room at the north end and find Darahir at about 63.4, 16.0. Open his Reagents & Magical Goods shop and buy Ghostly Skull for up to 40 gold.",
        "Use Ghostly Skull from your bags, then find it in the Pet Journal. If buying from another player instead, choose the caged Ghostly Skull species; a cage avoids this vendor trip.",
    },
    waypoints = { pin(126, 63.4, 16.0, 3, "Darahir - underground Black Market room", "Dalaran Underbelly (Northrend)") },
})

-- Giant Sewer Rat: all 386 parents read; 374202 and 5625457 replies expanded.
-- https://www.wowhead.com/item=43698#comments:id=374202
-- https://www.wowhead.com/item=43698#comments:id=6224739
-- https://www.wowhead.com/item=43698#comments:id=5661966
-- https://www.wowhead.com/item=43698#comments:id=6334744
-- https://www.wowhead.com/npc=28707 (dock position on sewer floor)
addPet(193, "Giant Sewer Rat", 43698, {
    category = "Fishing", source = "Open-water fishing - Northrend Dalaran Underbelly",
    sourceComments = { 374202, 2557519, 5661966, 6224739, 6334744 },
    requirements = "Fishing and access to Northrend Dalaran. No daily quest or fishing pool required.",
    tips = "Hundreds or thousands of casts can be needed. Jewel of the Sewers is not a requirement. A caged Auction House pet collects the species but does not grant I Smell A Giant Rat; the original item from the Black Market can grant that achievement.",
    steps = {
        "Learn Fishing and, for useful local skill gains and equipment bonuses, Northrend Fishing from Marcia Chase beside the Eventide fountain in Northrend Dalaran (52.6, 64.8). Empty some ordinary bag slots; a fishing-only bag cannot hold the pet item.",
        "Descend into the Northrend Underbelly. Go to the Cantrips & Crows dock around 44.0, 65.0 on the sewer map. Angelo Pescatore is nearby for selling unwanted catches and buying basic supplies.",
        "Cast into the open water from the dock and loot every successful catch. Do not search for a school or kill the walking sewer rats. If you prefer another spot, the Circle of Wills water around 52.0, 50.6 also works; the two fishing areas are alternatives, not consecutive objectives.",
        "Continue in sessions until Giant Sewer Rat appears in your bags. Ordinary catches such as Sewer Carp and Magic Eater show you are fishing the local water. Old 430/525 total-skill thresholds and mandatory Underbelly Elixir claims are not Retail requirements; fishing bonuses help with local fishing, not a guaranteed pet roll.",
        "Use the Giant Sewer Rat item and check the journal. Fishing the original item also awards I Smell A Giant Rat. If you only want the species, compare a caged pet on the normal Auction House; for the achievement, keep fishing or investigate an original-item Black Market listing.",
    },
    waypoints = {
        pin(125, 52.6, 64.8, 1, "Marcia Chase - Fishing and Northrend Fishing", "Dalaran (Northrend)"),
        pin(126, 44.0, 65.0, 2, "Cantrips & Crows dock - fishing spot and nearby supplier", "Dalaran Underbelly (Northrend)"),
        pin(126, 44.0, 65.0, 3, "Open-water fishing - primary rat spot", "Dalaran Underbelly (Northrend)"),
        pin(126, 52.0, 50.6, 3, "Circle of Wills - alternative open-water fishing", "Dalaran Underbelly (Northrend)"),
    },
})

-- Each pet page read separately: Tickbird 15, White Tickbird 20,
-- Proto-Drake Whelp 42, Cobra 18 parents. These share one acquisition route.
-- https://www.wowhead.com/item=39896#comments:id=404685 (both replies)
-- https://www.wowhead.com/item=39899#comments:id=397873 (three-day correction)
-- https://www.wowhead.com/item=44721#comments
-- https://www.wowhead.com/item=39898#comments
-- https://www.wowhead.com/item=39878#comments:id=1177760 and reply
-- https://www.wowhead.com/item=39878#comments:id=3163378
-- https://www.wowhead.com/npc=28659#comments:id=5377602 (shield script)
-- Egg tooltip: three real-time days; /npc=31910 mapper and vendor stock.
for _, pet in ipairs({
    { 194, "Tickbird Hatchling", 39896, { 404685, 505041 } },
    { 195, "White Tickbird Hatchling", 39899, { 397873, 541833 } },
    { 196, "Proto-Drake Whelp", 44721, { 400221, 1177760 } },
    { 197, "Cobra Hatchling", 39898, { 499110, 520393, 1177760 } },
}) do
    local speciesID, name, itemID, comments = unpack(pet)
    addPet(speciesID, name, itemID, {
        category = "Reputation", source = "Cracked Mysterious Egg - Geen, Revered with the Oracles", npcId = 31910,
        sourceComments = comments, cost = "Mysterious Egg: 3 gold base before reputation discount; one unhatched egg per character.",
        requirements = "Revered with the Oracles to buy eggs. No reputation requirement for learning a traded pet.",
        tips = name .. " is one of four possible pets in the same egg. Duplicate pets, Aged Yolk and the Green Proto-Drake mount are other outcomes; none guarantees this species next time. The Frenzyheart's Disgusting Jar does not contain these pets.",
        steps = {
            "Check the normal Auction House for " .. name .. " first if you want to avoid the reputation and incubation route. The pet can be traded after hatching or sold as a cage; use the item or learn the cage to collect this exact species.",
            "For your own eggs, travel to Sholazar Basin. If the Oracles are not unlocked, kill Pitch near 50.5, 76.8 and accept Playing Along from Tracker Gekgek. Follow High-Shaman Rakjak's Frenzyheart chain at 55.0, 69.2, then the injured Oracle and the Rainspeaker quests, through A Hero's Burden. The early Frenzyheart errands are part of the unlock, not a reason to abandon it.",
            "At the end of that chain, enter the cave at 70.9, 58.7 and find Artruis the Heartless at 72.2, 57.5. Attack until his shield releases Jaloot and Zepik. Kill Zepik the Gorloc Hunter, keep Jaloot alive, then finish Artruis. Avoid area attacks that kill both captives. Complete Jaloot's Hand of the Oracles, then take Return of the Friendly Dryskin back to Rainspeaker Canopy to join the Oracles. An already-unlocked character can use this encounter to switch back from Frenzyheart.",
            "Return to Rainspeaker Canopy at 54.5, 56.2. Complete the available Oracle daily quests from the canopy and repeat them after each daily reset until Revered. Accept the quest-giver's companion item when required and return the completed quests for reputation; merely killing random Frenzyheart mobs is not the daily reputation route.",
            "At Revered, buy one Mysterious Egg from Geen at 54.5, 56.2 in Rainspeaker Canopy. Leave it in your bags for three real-time days, including time logged out. Retail's current tooltip says three days, not the seven days in original Wrath comments.",
            "When it becomes a Cracked Egg, open it. If " .. name .. " appears, use that pet item. If you receive a different reward, buy a replacement egg from Geen and repeat the three-day cycle. You cannot choose which of the four pet species hatches.",
        },
        waypoints = {
            pin(119, 50.5, 76.8, 2, "Pitch / Tracker Gekgek - Playing Along unlock", "Sholazar Basin"),
            pin(119, 55.0, 69.2, 2, "High-Shaman Rakjak - initial Frenzyheart story quests", "Sholazar Basin"),
            pin(119, 70.9, 58.7, 3, "Artruis cave entrance - east of Lifeblood Pillar", "Sholazar Basin"),
            pin(119, 72.2, 57.5, 3, "Artruis - save Jaloot, kill Zepik", "Sholazar Basin"),
            pin(119, 54.5, 56.2, 4, "Rainspeaker Canopy - Oracle daily quest hub", "Sholazar Basin"),
            pin(119, 54.5, 56.2, 5, "Geen - buy Mysterious Egg at Revered", "Sholazar Basin"),
            pin(119, 54.5, 56.2, 6, "Geen - replace an opened egg for another attempt", "Sholazar Basin"),
        },
    })
end

-- Pengu: 51 parents. Preserve the useful three-zone reputation advice.
-- https://www.wowhead.com/item=44723#comments:id=534890
-- /quest=11945, /quest=11960, /quest=11472 supply current daily objectives.
-- /npc=26213, /npc=26194, /npc=24810 supply hub coordinates.
-- /npc=32763 is Sairuk; the old record's NPC 31916 is actually Tanaika.
addPet(198, "Pengu", 44723, {
    category = "Reputation", source = "Sairuk or Tanaika - Exalted with the Kalu'ak", npcId = 32763,
    sourceComments = { 534890, 577089, 2107282 },
    requirements = "Exalted with the Kalu'ak for the vendor route; either faction.",
    cost = "12 gold base; normally 9 gold 60 silver with the required Exalted discount.",
    tips = "Pengu and Mr. Chilly are different species. Kalu'ak is the Northrend tuskarr reputation, not Dragonflight's Iskaara Tuskarr. A traded caged Pengu avoids the reputation requirement.",
    steps = {
        "Check your Kalu'ak reputation. If already Exalted, skip to the purchase in step 6. Otherwise enable Trivial Quests tracking and finish the local tuskarr stories in Borean Tundra, Moa'ki Harbor in Dragonblight, and Kamagua in Howling Fjord to unlock their dailies. Include Elder Atkanok's quests at 54.5, 35.9 and Etaruk's at 54.2, 36.2 in Borean Tundra if unfinished; they add one-time reputation.",
        "In Borean Tundra, visit Utaik at Kaskala (63.8, 45.8). Do Preparing for the Worst: collect eight Kaskala Supplies from the village/coast and turn them in to Utaik. Complete his introductory quests first if the daily is not offered.",
        "In Dragonblight, take Planning for the Future from Trapper Mau'i at Moa'ki Harbor (48.0, 74.8). Go north to Snowfall Glade around 45.7, 61.6 and collect twelve living pups by interacting with them. Avoid area attacks and pet cleaves that kill the pups; return to Mau'i with all twelve.",
        "In Howling Fjord, visit Anuniaq at Kamagua (24.6, 58.8). Do The Way to His Heart... after its introductory version: use the supplied net on the marked reef-fish schools, then feed a Reef Bull while moving toward a Reef Cow. Keep the bull in range and lead it all the way to the cow for credit; return to Anuniaq.",
        "Repeat the three unlocked dailies after each daily reset until the Kalu'ak bar reaches Exalted. You can complete these separate zone dailies on the same day. One-time quests shorten the grind; repeatedly killing ordinary zone enemies does not replace the daily turn-ins.",
        "Buy Nurtured Penguin Egg from Sairuk at Moa'ki Harbor in Dragonblight (48.5, 75.6), or Tanaika at Kamagua in Howling Fjord (25.5, 58.6). Bring 12 gold to cover the base price; the normal Exalted price is 9 gold 60 silver.",
        "Use Nurtured Penguin Egg and find Pengu in the Pet Journal. Unlike an Oracle egg, this vendor egg does not need a three-day incubation period.",
    },
    waypoints = {
        pin(114, 54.5, 35.9, 1, "Elder Atkanok - unfinished one-time reputation quests", "Borean Tundra"),
        pin(114, 54.2, 36.2, 1, "Etaruk - unfinished one-time reputation quests", "Borean Tundra"),
        pin(114, 63.8, 45.8, 2, "Utaik - Preparing for the Worst", "Borean Tundra"),
        pin(115, 48.0, 74.8, 3, "Trapper Mau'i - Planning for the Future", "Dragonblight"),
        pin(115, 45.7, 61.6, 3, "Snowfall Glade - collect twelve living pups", "Dragonblight"),
        pin(117, 24.6, 58.8, 4, "Anuniaq - The Way to His Heart...", "Howling Fjord"),
        pin(115, 48.5, 75.6, 6, "Sairuk - buy Nurtured Penguin Egg at Exalted", "Dragonblight"),
        pin(117, 25.5, 58.6, 6, "Tanaika - alternative Pengu vendor", "Howling Fjord"),
    },
})

-- Kirin Tor Familiar: full parent set and guide/reward correction replies read.
-- https://www.wowhead.com/item=44738#comments:id=595175 (all 3 replies)
-- https://www.wowhead.com/item=44738#comments:id=1758359 (both replies)
-- https://www.wowhead.com/item=44738#comments:id=1964160
-- https://www.wowhead.com/item=44738#comments:id=3198595
-- https://www.wowhead.com/item=44738#comments:id=5889459 (reply)
addPet(199, "Kirin Tor Familiar", 44738, {
    category = "Achievements", source = "Higher Learning, then Archmage Vargoth's retreat in Northrend Dalaran",
    sourceAchievementId = 1956, sourceComments = { 595175, 1758359, 1964160, 3198595 },
    requirements = "Read all eight Higher Learning books on the collecting character; either faction and any class.",
    tips = "Read the full title: unrelated books are placeholders and do not grant a criterion. Spawn waits vary and can take hours. Read placeholders too, check back later, and share real-book sightings quickly. Complete the route in Northrend Dalaran, including the final toy teleport.",
    steps = {
        "Travel to Dalaran above Crystalsong Forest and track Higher Learning (1956). Use one character for the eight books and Vargoth reward. Visit every missing location below; a book may be absent or replaced by a non-achievement title, so this usually needs repeat circuits.",
        "Read The Schools of Arcane Magic - Introduction at the Violet Gate (56.7, 46.1). Look on the floor beside the northern/right-hand bookcase inside the portal room.",
        "Read Conjuration in the Violet Citadel (30.9, 46.3). Stay on the entrance level and check the bottom of the bookcase on your right as you enter.",
        "Read Divination upstairs in the Violet Citadel (26.5, 51.7). Take the stairs and look on the floor near the bookcases by the Caverns of Time portal area. The two Citadel books are on different levels.",
        "Read Enchantment at Threads of Fate (43.6, 47.1). Go upstairs in the cloth-armor shop and out onto its balcony; inspect the crate outside, rather than the shop floor.",
        "Read Transmutation downstairs in the Legerdemain Lounge (46.9, 39.8). Check the ground-floor western bookcase near the entrance/stove.",
        "Read Necromancy upstairs in the Legerdemain Lounge (46.9, 39.1). Enter the western bedroom and inspect the empty bookcase. This is a separate spawn from the downstairs Transmutation book.",
        "Read Abjuration inside the Dalaran Visitor Center (52.2, 55.5). Look on the floor to the right of the entrance, beside the small table and books.",
        "Read Illusion by the Violet Hold (64.5, 52.8). At the entrance area, check the crate against the wall beside Archmage Timear. You do not need to enter or clear the dungeon.",
        "After all eight criteria complete, retrieve The Schools of Arcane Magic - Mastery from the achievement mail and learn the toy if needed. Look in your Toy Box if the book is already learned. The achievement alone does not directly put the Familiar in your journal.",
        "While in Northrend Dalaran, use The Schools of Arcane Magic - Mastery to enter Archmage Vargoth's retreat. Speak to Vargoth about the book to receive Kirin Tor Familiar, then use the pet item. A teleport from Legion Dalaran reaches a different room and does not complete this reward conversation.",
        "Use the Mastery toy again to leave the retreat. Check the Pet Journal for Kirin Tor Familiar. If Vargoth is missing, confirm both the Northrend city and the character that completed Higher Learning before repeating any book hunting.",
    },
    waypoints = {
        pin(125, 56.7, 46.1, 2, "Introduction - floor beside Violet Gate bookcase", "Dalaran (Northrend)"),
        pin(125, 30.9, 46.3, 3, "Conjuration - Violet Citadel, entrance level", "Dalaran (Northrend)"),
        pin(125, 26.5, 51.7, 4, "Divination - Violet Citadel, upstairs", "Dalaran (Northrend)"),
        pin(125, 43.6, 47.1, 5, "Enchantment - Threads of Fate balcony crate", "Dalaran (Northrend)"),
        pin(125, 46.9, 39.8, 6, "Transmutation - Legerdemain Lounge, downstairs", "Dalaran (Northrend)"),
        pin(125, 46.9, 39.1, 7, "Necromancy - Legerdemain Lounge, upstairs bedroom", "Dalaran (Northrend)"),
        pin(125, 52.2, 55.5, 8, "Abjuration - Visitor Center floor", "Dalaran (Northrend)"),
        pin(125, 64.5, 52.8, 9, "Illusion - crate at Violet Hold entrance", "Dalaran (Northrend)"),
    },
})

-- The ten city pet pages were read separately, including their common
-- cost/trading threads and all replies. Current sold-by tables confirm 40 seals.
-- /item=44965#comments:id=634598, /item=44970#comments:id=630199
-- /item=44971#comments:id=633179, /item=44973#comments:id=633180
-- /item=44974#comments:id=634596, /item=44980#comments:id=633183
-- /item=44984#comments:id=634593, /item=44982#comments:id=2625181
-- /item=45002#comments:id=634595, /item=45606#comments:id=631230
-- /item=44982#comments:id=3203491 and its hourly-limit correction reply.
-- https://www.wowhead.com/guide/world-events/championing-the-argent-tournament
-- Each named quartermaster's Retail NPC mapper supplies its individual pin.
for _, pet in ipairs({
    { 204, "Teldrassil Sproutling", 44965, "Alliance", "Darnassus", "Rook Hawkfist", 33653, 76.2, 19.2, 634598 },
    { 205, "Dun Morogh Cub", 44970, "Alliance", "Ironforge", "Derrick Brindlebeard", 33310, 76.5, 19.4, 630199 },
    { 206, "Tirisfal Batling", 44971, "Horde", "Undercity", "Eliza Killian", 33555, 76.4, 24.0, 633179 },
    { 207, "Durotar Scorpion", 44973, "Horde", "Orgrimmar", "Freka Bloodaxe", 33553, 76.4, 24.2, 633180 },
    { 209, "Elwynn Lamb", 44974, "Alliance", "Stormwind", "Corporal Arthur Flew", 33307, 76.4, 19.2, 634596 },
    { 210, "Mulgore Hatchling", 44980, "Horde", "Thunder Bluff", "Doru Thunderhorn", 33556, 76.2, 24.5, 633183 },
    { 212, "Ammen Vale Lashling", 44984, "Alliance", "Exodar", "Irisee", 33657, 76.2, 19.2, 634593 },
    { 213, "Enchanted Broom", 44982, "Horde", "Silvermoon", "Trellis Morningsun", 33557, 76.2, 23.8, 2625181 },
    { 215, "Mechanopeep", 45002, "Alliance", "Gnomeregan", "Rillie Spindlenut", 33650, 76.4, 19.5, 634595 },
    { 218, "Sen'jin Fetish", 45606, "Horde", "Sen'jin", "Samamba", 33554, 76.0, 24.4, 631230 },
}) do
    local speciesID, name, itemID, faction, city, vendor, npcID, x, y, comment = unpack(pet)
    local alliance = faction == "Alliance"
    local representative = alliance and "Arcanist Taelis at 76.4, 19.4" or "Magister Edien Sunhollow at 76.2, 24.2"
    local cityReputation = city == "Sen'jin" and "Darkspear Trolls" or city
    addPet(speciesID, name, itemID, {
        category = "Vendor", source = vendor .. " - " .. city .. " quartermaster, Argent Tournament", npcId = npcID,
        sourceComments = { comment, 3203491 }, cost = "40 Champion's Seals. A traded pet costs whatever the seller asks.",
        requirements = faction .. " buyer; unlock " .. city .. "'s tournament quartermaster. Learned pet usable by either faction.",
        tips = "Aspirant's Seals and Valiant's Seals advance training; Champion's Seals buy pets. Keep the currency names separate. You can learn a traded " .. name .. " without doing the tournament, and no neutral-Auction-House transfer is needed in modern Retail.",
        steps = {
            "For the direct vendor route use a " .. faction .. " character. You do not have to be the race represented by " .. city .. ". A collector of either faction can instead buy " .. name .. " or its cage on the normal Auction House and learn it without the tournament unlock.",
            "Fly to the Argent Tournament Grounds in northeast Icecrown. If new to the tournament, start with Justicar Mariel Trueheart at 69.6, 22.8, then " .. representative .. " in your faction pavilion. Finish the mounted-combat lessons. Equip the supplied lance and use a tournament mount when a jousting quest requires one.",
            "Complete Up to the Challenge by collecting 15 Aspirant's Seals from the pavilion's training dailies, normally five per day over three days. Then win The Aspirant's Challenge. During jousts, build and refresh Defend, use Shield-Breaker to remove the opponent's defenses, and Charge when you have room.",
            "Finish your first city's A Valiant's Charge: collect 25 Valiant's Seals through its dailies, normally five per day for five days. Complete The Valiant's Challenge and A Champion Rises. If your character already completed a stage, continue from its current quests rather than restarting completed introductory training.",
            "If your first championship was for another city, accept " .. city .. "'s Valiant invitation and complete that city's 25-seal training and challenge too. Check its Exalted Champion achievement and raise " .. cityReputation .. " reputation as needed, using the city's tournament quests and Champion's Writ turn-ins. Owning 40 purchase seals does not by itself open a locked city vendor.",
            "Earn and save 40 Champion's Seals from unlocked Champion dailies. Complete Crusader Rhydalla's investigation through The Black Knight's Fall to add Threat From Above. For extra seals, clear Trial of the Champion at the Coliseum's five-player entrance (75.1, 21.8): Heroic offers a daily clear; Normal can be reset for the final encounter's seal. Respect the hourly instance limit instead of following old five-runs-per-hour comments.",
            "Return to " .. vendor .. " at " .. x .. ", " .. y .. " in the " .. faction .. " pavilion and buy " .. name .. " for 40 Champion's Seals. This vendor is at the tournament in Icecrown, not in " .. city .. " itself.",
            "Use " .. name .. " from your bags and find the species in your account-wide Pet Journal. The blue item wrapper does not guarantee a Rare-quality battle pet; use a battle-stone later if you want to improve its battle quality.",
        },
        waypoints = {
            pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
            pin(118, alliance and 76.4 or 76.2, alliance and 19.4 or 24.2, 2, faction .. " pavilion - training representative", "Icecrown"),
            pin(118, alliance and 76.4 or 76.2, alliance and 19.4 or 24.2, 3, "Aspirant daily quests - training seals", "Icecrown"),
            pin(118, x, y, 5, city .. " pavilion - city championship and reputation", "Icecrown"),
            pin(118, 69.6, 22.8, 6, "Argent pavilion - Champion daily quest hub", "Icecrown"),
            pin(118, 75.1, 21.8, 6, "Trial of the Champion - optional extra purchase seals", "Icecrown"),
            pin(118, x, y, 7, vendor .. " - buy " .. name, "Icecrown"),
        },
    })
end

-- Squire: 72 parents; Gruntling: 50 parents.
-- https://www.wowhead.com/item=44998#comments:id=2000427 (all 6 replies)
-- https://www.wowhead.com/item=45022#comments:id=2000428 (all 4 replies)
-- https://www.wowhead.com/item=45022#comments:id=5390045
-- https://www.wowhead.com/item=45022#comments:id=6367954 and reply 1870835:
-- Oathbreaker Wrangler is a LOST-companion replacement, not a first purchase.
-- /npc=257151 current stock and mapper: Slayer's Rise 2444, 35.4 81.5.
for _, pet in ipairs({
    { 214, "Argent Squire", 44998, "Alliance", 2000427 },
    { 216, "Argent Gruntling", 45022, "Horde", 2000428 },
}) do
    local speciesID, name, itemID, faction, comment = unpack(pet)
    local alliance = faction == "Alliance"
    addPet(speciesID, name, itemID, {
        category = "Quest Rewards", source = "A Champion Rises - " .. faction .. " Argent Tournament introduction",
        faction = alliance and "alliance" or "horde", sourceComments = { comment, 5390045, 6367954 },
        cost = "Pet: quest reward. Optional Argent Pony Bridle: 150 Champion's Seals after Crusader unlock.",
        requirements = faction .. " character; first city championship. No need to champion all five cities just to collect the pet.",
        tips = "This is a non-battling, faction-specific companion. The Pony Bridle services are a separate character-specific upgrade; learning the account pet does not give every alt a portable bank. Lost-companion vendors cannot bypass first-time quest acquisition.",
        steps = {
            "On a " .. faction .. " character, check the Pet Journal for " .. name .. ". If you earned it before but lost access, ask a stable master for a lost companion. Midnight's Oathbreaker Wrangler at 35.4, 81.5 in Slayer's Rise also lists replacements, but only for an eligible previously earned companion. For a first collection, follow the tournament route below.",
            "Start The Argent Tournament with Justicar Mariel Trueheart at 69.6, 22.8 in Icecrown. Report to " .. (alliance and "Arcanist Taelis at 76.4, 19.4 in the Alliance pavilion" or "Magister Edien Sunhollow at 76.2, 24.2 in the Horde pavilion") .. ". Finish the lance and mounted-combat introductions.",
            "Do the pavilion's Aspirant dailies until you have 15 Aspirant's Seals for Up to the Challenge. The standard route awards five per day, so allow three days. Complete The Aspirant's Challenge by defeating its mounted opponent; equip your lance, mount the supplied tournament mount, maintain Defend, and remove the opponent's shields before charging.",
            "Take your first city's A Valiant's Charge and collect 25 Valiant's Seals, normally five per day for five days. These come from the city pavilion's weapon, field-training and jousting dailies. The western Argent pavilion's Champion dailies do not substitute for these training seals.",
            "Complete The Valiant's Challenge and take A Champion Rises. Turn it in to Justicar Mariel Trueheart in the Argent pavilion at 69.6, 22.8, then use the " .. name .. " reward. Allow roughly a week of daily resets from a fresh introduction; the last Aspirant day can also be your first Valiant day.",
            "Summon " .. name .. " from your journal. Its dialogue can display city banners you have unlocked. Collect the opposing faction's companion separately on that faction if you want both species; changing faction does not reliably award the other journal entry.",
            "Optional utility upgrade: check Dame Evniki Kapsalis in the Argent pavilion (69.5, 23.2) if Crusader is already unlocked on your account. If her stock is locked, earn Crusader through all five city championships, Exalted with those city factions, and Exalted with the Argent Crusade. Buy Argent Pony Bridle for 150 Champion's Seals and use it on the character that needs the services.",
            "After the bridle upgrade, talk to your summoned companion to choose bank, mailbox or vendor access. One choice lasts three minutes and starts the shared four-hour service cooldown. Other characters need their own upgrade; the pony and services are not required for collecting " .. name .. ".",
        },
        waypoints = {
            pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
            pin(118, alliance and 76.4 or 76.2, alliance and 19.4 or 24.2, 2, faction .. " pavilion - report for training", "Icecrown"),
            pin(118, alliance and 76.4 or 76.2, alliance and 19.4 or 24.2, 3, "Aspirant training daily quests", "Icecrown"),
            pin(118, alliance and 76.4 or 76.2, alliance and 19.4 or 24.2, 4, "Valiant city training daily quests", "Icecrown"),
            pin(118, 69.6, 22.8, 5, "A Champion Rises - turn in for " .. name, "Icecrown"),
            pin(118, 69.5, 23.2, 7, "Dame Evniki Kapsalis - optional Argent Pony Bridle", "Icecrown"),
            pin(2444, 35.4, 81.5, 1, "Oathbreaker Wrangler - previously earned companion recovery only", "Slayer's Rise"),
        },
    })
end

-- Both faction items reviewed separately: 46820 (24), 46821 (14).
-- https://www.wowhead.com/item=46820#comments:id=2194218
-- https://www.wowhead.com/item=46820#comments:id=5896464 and reply
-- https://www.wowhead.com/item=46821#comments:id=979526
-- https://www.wowhead.com/item=46821#comments:id=1715156
-- /npc=34881, /npc=167030, /npc=34772, /npc=167081: vendor positions.
addPet(229, "Shimmering Wyrmling", 46820, {
    category = "Reputation", source = "Hiren Loresong / Vasarin Redmorn - Exalted Silver Covenant / Sunreavers",
    sourceComments = { 2194218, 5896464, 979526, 1715156 }, cost = "40 Champion's Seals for the faction vendor item.",
    requirements = "Tournament vendor access and Exalted with the Silver Covenant (Alliance) or Sunreavers (Horde), unless learning a traded cage.",
    tips = "Both faction items teach the same species. Buying both does not add two unique pets. The vendor item has a faction reputation requirement to learn; a caged Shimmering Wyrmling, or the reputation-free reward item 69992, avoids that restriction. Mana Wyrmling is a different species.",
    steps = {
        "Choose your route. For a purchase without the reputation grind, search the Auction House for the caged Shimmering Wyrmling species. Avoid buying the opposing faction's unopened item 46820/46821: those retain their own Silver Covenant/Sunreaver requirement.",
        "For the tournament route, visit the Argent Tournament in Icecrown. Start with Justicar Mariel Trueheart (69.6, 22.8), finish the 15-Aspirant's-Seal training and challenge, then your first city's 25-Valiant's-Seal training and A Champion Rises. Continue any unfinished tournament stages on the character buying the pet.",
        "Raise the correct reputation to Exalted: the Silver Covenant for Alliance, or the Sunreavers for Horde. Use your faction pavilion's available tournament dailies and their reputation rewards. Check this exact bar after turn-ins; Exalted with Silvermoon, Darnassus or the Argent Crusade is not the pet's faction requirement. If pavilion services are still locked, finish the remaining city championship quests they require.",
        "Save 40 Champion's Seals from unlocked tournament dailies and their purses. Trial of the Champion's five-player entrance is at 75.1, 21.8; a daily Heroic clear and repeatable Normal final-encounter seals can supplement the dailies. Aspirant's and Valiant's Seals cannot buy the pet.",
        "Alliance: buy Shimmering Wyrmling (46820) from Hiren Loresong at 76.2, 19.5 in the Silver Covenant pavilion. Horde: buy Shimmering Wyrmling (46821) from Vasarin Redmorn at 76.2, 24.0 in the Sunreaver pavilion. The price is 40 Champion's Seals for either version.",
        "Use your faction's item on the Exalted character, then find Shimmering Wyrmling in the shared Pet Journal. The learned species can be caged and traded without the unopened vendor item's reputation requirement.",
    },
    waypoints = {
        pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament unlock", "Icecrown"),
        pin(118, 76.2, 19.5, 3, "Silver Covenant pavilion - Alliance reputation route", "Icecrown"),
        pin(118, 76.2, 24.0, 3, "Sunreaver pavilion - Horde reputation route", "Icecrown"),
        pin(118, 75.1, 21.8, 4, "Trial of the Champion - optional extra seals", "Icecrown"),
        pin(118, 76.2, 19.5, 5, "Hiren Loresong - Alliance purchase", "Icecrown"),
        pin(118, 76.2, 24.0, 5, "Vasarin Redmorn - Horde purchase", "Icecrown"),
    },
})

-- Breanni pets: Calico 14, Obsidian 21 parents; no profit walkthroughs.
-- https://www.wowhead.com/item=46398#comments:id=871851
-- https://www.wowhead.com/item=46398#comments:id=911795
-- https://www.wowhead.com/item=48120#comments:id=1819482
-- https://www.wowhead.com/item=48120#comments:id=1850049
-- /npc=28951 Retail stock: unlimited; both pets 50 gold base.
for _, pet in ipairs({
    { 224, "Calico Cat", 46398, { 871851, 911795 } },
    { 236, "Obsidian Hatchling", 48120, { 1819482, 1850049 } },
}) do
    local speciesID, name, itemID, comments = unpack(pet)
    addPet(speciesID, name, itemID, {
        category = "Vendor", source = "Breanni - Magical Menagerie, Northrend Dalaran", npcId = 28951,
        sourceComments = comments, cost = "50 gold base before applicable vendor discounts.",
        requirements = "Either faction; no reputation grind or rare-spawn kill needed.",
        tips = "Compare the normal Auction House price with Breanni's displayed price. These are unlimited-stock vendor pets; neither a Black Market bid nor a rare-drop farm is necessary.",
        steps = {
            "Travel to Dalaran above Crystalsong Forest in Northrend and bring up to 50 gold. You can buy this pet on either faction; higher Kirin Tor reputation reduces the displayed price but is not required to open the shop.",
            "Go inside the Magical Menagerie at 58.6, 39.6, beside the exotic-mount vendors. Find Breanni indoors. Do not stay outside looking for a pet dropped by one of the animals around the shop.",
            "Buy " .. (name == "Calico Cat" and "Calico Cat (46398)" or "Obsidian Hatchling (48120)") .. " from Breanni. It costs 50 gold before discounts and does not require waiting for limited stock. Select the exact species; her other pets are separate collection entries.",
            "Use the item in your bags and find " .. name .. " in the shared Pet Journal. If you bought a caged pet from another player instead, learn the cage. Once learned, the species is available to characters of either faction.",
        },
        waypoints = {
            pin(125, 58.6, 39.6, 2, "Breanni - inside the Magical Menagerie", "Dalaran (Northrend)"),
            pin(125, 58.6, 39.6, 3, "Buy " .. name .. " - 50 gold base", "Dalaran (Northrend)"),
        },
    })
end

-- Blue Clockwork Rocket Bot: all 14 parents; /npc=29478 current vendor stock.
-- https://www.wowhead.com/item=54436#comments:id=984077
-- https://www.wowhead.com/item=54436#comments:id=1400202
-- https://www.wowhead.com/item=54436#comments:id=1415530
addPet(254, "Blue Clockwork Rocket Bot", 54436, {
    category = "Vendor", source = "Jepetto Joybuzz - Wonderworks, Northrend Dalaran", npcId = 29478,
    sourceComments = { 984077, 1400202, 1415530 }, cost = "50 gold base before applicable discounts.",
    requirements = "Either faction; no Winter Veil event or Engineering required.",
    tips = "Buy the BLUE Clockwork Rocket Bot. Clockwork Rocket Bot, the original holiday species, is a separate journal entry. The blue vendor pet does not award the original 2007 holiday achievement.",
    steps = {
        "Bring up to 50 gold and travel to Northrend Dalaran above Crystalsong Forest. This vendor route is available throughout the year and works for either faction.",
        "Enter the Wonderworks toy shop near 44.4, 45.6. Find Jepetto Joybuzz; his Clockwork Assistant also sells the pet. The shop is on the surface, not in the Underbelly.",
        "Buy Blue Clockwork Rocket Bot (54436) for 50 gold before discounts. Check the word Blue before purchasing: several rocket-bot species look similar but collect different entries.",
        "Use the item from your bags, then search the Pet Journal for Blue Clockwork Rocket Bot. It can also be learned from a traded cage; Engineering and the old Winter Veil event are not prerequisites for this blue version.",
    },
    waypoints = {
        pin(125, 44.4, 45.6, 2, "Wonderworks - Jepetto Joybuzz / Clockwork Assistant", "Dalaran (Northrend)"),
        pin(125, 44.4, 45.6, 3, "Buy Blue Clockwork Rocket Bot", "Dalaran (Northrend)"),
    },
})

-- Strand Crawler: all 90 parents, 637289 and 1821898 replies expanded.
-- https://www.wowhead.com/item=44983#comments:id=637289
-- https://www.wowhead.com/item=44983#comments:id=1653917
-- https://www.wowhead.com/item=44983#comments:id=1821898
-- /npc=28742 current rotation: quests 13830, 13832, 13833, 13834, 13836.
-- /quest=13830#comments:id=636223 and all replies: EAT the Ghostfish.
-- /quest=13836#comments:id=1030313 and all replies: OPEN the eel.
-- /quest=13836#comments:id=5588623; /npc=28706 turn-in position.
addPet(211, "Strand Crawler", 44983, {
    category = "Fishing", source = "Bag of Fishing Treasures - Marcia Chase's Northrend Dalaran daily", npcId = 28742,
    sourceComments = { 637289, 1653917, 1821898 },
    requirements = "Fishing; access to Marcia's daily. Only do the branch matching today's accepted quest.",
    tips = "The pet is a random reward, not a guaranteed first-bag drop. Bags of Shiny Things from capital fishing dailies are another source. Old Man Barlo's Outland fishing bag is not the Strand Crawler route. The learned pet is cageable, so a normal Auction House cage is an alternative.",
    steps = {
        "Visit Marcia Chase by the Eventide fountain in Northrend Dalaran (52.6, 64.8), learn the available Fishing training, and accept today's fishing daily. She offers one of five quests. Follow only the matching branch in steps 2-6, then open its reward in step 7; these five branches are not five dailies available at once.",
        "Jewel Of The Sewers: descend into the Northrend Underbelly and fish open water, for example from the Cantrips & Crows dock at 44.0, 65.0 on the sewer map, until you catch Corroded Jewelry. Return to Marcia with it. Fishing here can also catch Giant Sewer Rat, but that is a different pet.",
        "Disarmed!: fish the water outside the Violet Hold entrance in surface Dalaran, around 65.0, 61.0. When you catch a Bloated Slippery Eel, OPEN it to obtain the Severed Arm. Take the arm to Olisarra the Kind in the First to Your Aid shop around 37.4, 36.6. This quest turns in to Olisarra, not Marcia.",
        "The Ghostfish: go to River's Heart in central Sholazar Basin, around 50.1, 61.5, and fish open water. When you catch Phantom Ghostfish, EAT it within one minute to discover its mystery. Do this before flying back; the fish disappears if you wait too long. Return to Marcia after the objective credits.",
        "Blood Is Thicker: go to Borean Tundra, kill a beast to gain the blood effect, then step into fishable water, such as Lake Kum'uya around 53.0, 44.0. Fish from the blood pool you create until you have five Bloodtooth Frenzies, then bring them to Marcia. If the blood effect is missing, kill another beast before entering the water.",
        "Dangerously Delicious: fish open water in outdoor Wintergrasp, for example the eastern lake around 71.0, 42.0, until you have ten Terrorfish. You do not need a fishing pool or a fortress kill. Return to Marcia with all ten fish.",
        "Complete the matching turn-in and open Bag of Fishing Treasures (46007). If Strand Crawler appears, use the item to collect it. Its bind-on-pickup reward item can be learned and the resulting pet caged; you do not have to discard a duplicate merely because the original item is bound.",
        "If the bag has no pet, return after the next daily reset for another attempt. Additional eligible characters can do their own daily for the shared collection. Compare a caged Strand Crawler on the normal Auction House if you prefer a direct purchase to repeated daily bags.",
    },
    waypoints = {
        pin(125, 52.6, 64.8, 1, "Marcia Chase - accept today's ONE fishing daily", "Dalaran (Northrend)"),
        pin(126, 44.0, 65.0, 2, "Jewel Of The Sewers - fish Corroded Jewelry", "Dalaran Underbelly (Northrend)"),
        pin(125, 65.0, 61.0, 3, "Disarmed! - fish outside Violet Hold; open the eel", "Dalaran (Northrend)"),
        pin(125, 37.4, 36.6, 3, "Olisarra the Kind - Disarmed! turn-in", "Dalaran (Northrend)"),
        pin(119, 50.1, 61.5, 4, "The Ghostfish - fish River's Heart; EAT within one minute", "Sholazar Basin"),
        pin(114, 53.0, 44.0, 5, "Blood Is Thicker - beast blood, then lake fishing", "Borean Tundra"),
        pin(123, 71.0, 42.0, 6, "Dangerously Delicious - ten Terrorfish from open water", "Wintergrasp"),
        pin(125, 52.6, 64.8, 7, "Marcia - turn in all branches except Disarmed!", "Dalaran (Northrend)"),
    },
})

-- Nest pet parent counts: Darting 68, Leaping 59, Ravasaur 89, Razormaw 67.
-- https://www.wowhead.com/item=48112#comments:id=1498357 (all 11 replies)
-- https://www.wowhead.com/item=48118#comments:id=1498363 (all 5 replies)
-- https://www.wowhead.com/item=48122#comments:id=1510547 (all 9 replies)
-- https://www.wowhead.com/item=48122#comments:id=1637215 (11 replies;
-- reply 1847585 reconfirms this route in Midnight, 2026-06-26).
-- /object=202080, /object=202081, /object=202082 current mappers agree.
-- Takk's old Barrens coordinates and the isolated mapper outlier are omitted.
for _, pet in ipairs({
    {
        speciesID = 232, name = "Darting Hatchling", itemID = 48112,
        zone = "Dustwallow Marsh", mapID = 70, nest = "Dart's Nest", adult = "Dart",
        comments = { 1498357, 1670733, 5252994 },
        approach = "Go to the raptor nesting area in northern Dustwallow Marsh, near Stinky Ignatz. You are looking for a clickable Dart's Nest with pink/purple eggs, usually against a tree; the ordinary nests in the middle of the area are scenery.",
        route = {
            { 48.0, 14.2, "Check behind the large tree at the northern edge of the nesting area." },
            { 49.1, 17.4, "Look at the base of the tree against the eastern hill, between the bushes." },
            { 47.9, 19.0, "Inspect the southern tree beside the scattered wooden debris." },
            { 46.5, 17.2, "Check between the trees near Stinky Ignatz on the western side." },
        },
    },
    {
        speciesID = 235, name = "Leaping Hatchling", itemID = 48118,
        zone = "Northern Barrens", mapID = 10, nest = "Takk's Nest", adult = "Takk the Leaper",
        comments = { 1189010, 1498363, 2528193 },
        approach = "Go to the northeastern Northern Barrens and search the large trees around Takk the Leaper's area. Use the post-Cataclysm points below; old coordinates around 58, 8 refer to a different version of the Barrens map.",
        route = {
            { 61.0, 19.8, "Inspect the large tree and the small clearing at its base." },
            { 62.8, 20.2, "Check the southeast side of the next large tree for the purple-egg nest." },
            { 64.1, 23.0, "Continue southeast and inspect the tree base against the hillside." },
            { 65.0, 28.7, "Check the southern end of the route around the large tree." },
        },
    },
    {
        speciesID = 237, name = "Ravasaur Hatchling", itemID = 48122,
        zone = "Un'Goro Crater", mapID = 78, nest = "Ravasaur Matriarch's Nest", adult = "Ravasaur Matriarch",
        comments = { 1510547, 1637215, 2491299 },
        approach = "Go to the southeastern ravasaur area in Un'Goro Crater. Search for a leafy nest at tree roots, not a loose Ravasaur Egg. Lower ground clutter if the nest blends into the plants. Mor'vek's Venomhide mount quests are a separate reward and are not required.",
        route = {
            { 63.0, 63.2, "Check the base of the large tree and its projecting root." },
            { 62.2, 65.3, "Inspect beside the small palm tree just southwest of the first point." },
            { 62.0, 73.3, "Search between the giant tree and small palm at the southern point." },
            { 68.9, 66.9, "Check where the large tree and adjacent palm nearly meet on the eastern side." },
            { 68.9, 61.2, "Finish at the base of the large northeastern tree; sweep your cursor through the grass." },
        },
    },
}) do
    local steps = { pet.approach }
    local waypoints = {}
    for index, point in ipairs(pet.route) do
        local step = index + 1
        steps[#steps + 1] = "At " .. point[1] .. ", " .. point[2] .. ": " .. point[3] .. " Move around the tree and mouse over the ground; " .. pet.nest .. " is an interactable object, not a targetable creature. If absent, continue to the next marked point."
        waypoints[#waypoints + 1] = pin(pet.mapID, point[1], point[2], step, pet.nest .. " - search point " .. index, pet.zone)
    end
    steps[#steps + 1] = "When you find " .. pet.nest .. ", interact with it and loot " .. pet.name .. ". Use the pet item and confirm the species in your journal. You do not need to kill " .. pet.adult .. " to unlock, force or loot the nest."
    steps[#steps + 1] = "If all marked points are empty, return later and repeat the circuit, or leave an alt here to check between other activities. Someone else may have looted the nest. The adult rare and nest are independent; a rare kill does not start a guaranteed countdown. A traded item or caged " .. pet.name .. " is an alternative."
    addPet(pet.speciesID, pet.name, pet.itemID, {
        category = "Treasure", source = pet.nest .. " - " .. pet.zone,
        sourceComments = pet.comments, steps = steps, waypoints = waypoints,
        requirements = "Either faction; access to the outdoor nest area. No reputation or profession requirement.",
        tips = "Loot the named nest. The old rare-creature drop instructions are obsolete, but the nest remains obtainable in Retail. This is not a wild pet battle capture. Spawn times vary; the guide's points are search locations, not guaranteed simultaneous nests.",
    })
end

-- Current Retail mapper for /object=202083 has ONE point: 69.9,29.1.
-- https://www.wowhead.com/object=202083#comments:id=1205979 (4 replies)
-- https://www.wowhead.com/object=202083#comments:id=1519973
-- https://www.wowhead.com/object=202083#comments:id=3292904
-- The old four-point cave circuit from /item=48124 is intentionally excluded.
addPet(238, "Razormaw Hatchling", 48124, {
    category = "Treasure", source = "Razormaw Matriarch's Nest - Raptor Ridge cave, Wetlands",
    sourceComments = { 1205979, 1519973, 3292904 },
    requirements = "Either faction; access to Raptor Ridge cave. No reputation or profession required.",
    tips = "The nest and adult rare have independent spawns. The pet comes from the nest, not from killing the Matriarch. Use the current ledge spawn; old comments listing four different spots around the cave predate the fixed location.",
    steps = {
        "Travel to Raptor Ridge in northeastern Wetlands. Enter the cave at about 69.1, 35.4. The nest pin is underground; flying over the mountaintop at that coordinate will not reach it.",
        "Inside, follow the right-hand passage into the chamber with shallow water and a raised rocky ledge in its middle. Go onto the ledge around 69.9, 29.1; look near its far end for Razormaw Matriarch's Nest.",
        "Interact with the nest and loot Razormaw Hatchling. The adult Razormaw Matriarch can be beside it, elsewhere, or absent. Clear an attacking raptor if needed, but do not repeatedly kill the rare expecting it to drop the pet or summon the nest.",
        "Use Razormaw Hatchling from your bags. If the ledge is empty, check later or leave an alt near the ledge. Reports often find a roughly hour-long respawn, but another player may loot it and the timer is not guaranteed. You can also learn a traded item or cage.",
    },
    waypoints = {
        pin(56, 69.1, 35.4, 1, "Raptor Ridge cave entrance - enter, do not fly over", "Wetlands"),
        pin(56, 69.9, 29.1, 2, "Current nest spawn - raised ledge surrounded by water", "Wetlands"),
        pin(56, 69.9, 29.1, 3, "Loot Razormaw Matriarch's Nest", "Wetlands"),
    },
})

-- Deviate: all 163 parents, guide 811634 and all 5 replies read.
-- https://www.wowhead.com/item=48114#comments:id=811634
-- https://www.wowhead.com/item=48114#comments:id=5678601
-- https://www.wowhead.com/item=48114#comments:id=6275725
-- https://www.wowhead.com/zone=718#comments:id=2358950 (Retail approach)
-- /zone=718 and /npc=3671: Anacondra is a landmark for the first-room loop.
addPet(233, "Deviate Hatchling", 48114, {
    category = "Dungeon and Raids", source = "Deviate Guardians and Deviate Ravagers - Wailing Caverns",
    sourceComments = { 811634, 1737930, 5678601, 6275725 },
    requirements = "Either faction; a character able to clear Normal Wailing Caverns. No pet battle challenge required.",
    tips = "Farm the raptors INSIDE the Normal dungeon. Decorative nests, the outdoor cavern mobs and Lady Anacondra herself are not the target drop. The pet remains obtainable in Retail; the old removal claim was incorrect.",
    steps = {
        "Go to the Wailing Caverns cave entrance at 39.0, 69.2 in Northern Barrens, south of the Crossroads. Use Normal Dungeon Difficulty. Old Barrens coordinates around 46, 36 are not the current Northern Barrens entrance.",
        "Follow the approach cave to the actual instance portal, around 42.1, 66.6 on the Northern Barrens map. Cross the portal before farming. Reaching the outdoor cavern is not enough: the pet's source raptors are in the dungeon instance.",
        "Enter the first large chamber and make a full circuit of its upper walkway above the stream. Kill every Deviate Guardian and Deviate Ravager along the loop. The dungeon pin near Lady Anacondra (30.6, 43.0) is a chamber landmark, not a claim that the boss drops the pet. You do not need to complete the Fanglord bosses or the final escort.",
        "Loot all the raptors, using area loot for nearby bodies. Keep combat pets under control while gathering enemies so they do not kill an untagged target out of range. Skinning is optional and can add leather; it is not required for the pet drop.",
        "After clearing the loop, retrace the entrance tunnel and leave the instance. Right-click your character portrait, choose Reset All Instances, re-enter, and repeat. Stop when the game reports the hourly instance limit; waiting for access is part of this farm, not evidence the pet has been removed.",
        "When Deviate Hatchling drops, use the item and check the journal. A run can yield none, one or multiple pets, and there is no fixed number of clears that guarantees it. If you prefer, learn a traded item or caged Deviate Hatchling instead.",
    },
    waypoints = {
        pin(10, 39.0, 69.2, 1, "Wailing Caverns - outdoor cave entrance", "Northern Barrens"),
        pin(10, 42.1, 66.6, 2, "Wailing Caverns - instance portal inside approach cave", "Northern Barrens"),
        pin(279, 30.6, 43.0, 3, "First chamber landmark - farm the upper raptor loop", "Wailing Caverns"),
    },
})

-- Gundrak: all 115 parents; numbered farming guide 1660757 and 5 replies.
-- https://www.wowhead.com/item=48116#comments:id=1660757
-- https://www.wowhead.com/item=48116#comments:id=807460
-- https://www.wowhead.com/item=48116#comments:id=6365996 (Retail 12.0.5)
-- /npc=29334 mapper supplies the outdoor U-shaped farming area.
addPet(234, "Gundrak Hatchling", 48116, {
    category = "Rare Drops", source = "Gundrak Raptors outside Gundrak - northeastern Zul'Drak", npcId = 29334,
    sourceComments = { 807460, 1660757, 6365996 },
    requirements = "Either faction; access to northeastern Zul'Drak. Skinning optional.",
    tips = "Gundrak Raptors are outside the dungeon. Nearby quest eggs do not contain the pet. Roughly one in a thousand is a commonly reported estimate, not a promise of a drop by kill 1,000. Skinning adds Borean Leather and occasional Arctic Fur while you farm.",
    steps = {
        "Travel to the outdoor grounds around Gundrak in northeastern Zul'Drak. Start near the western side around 71.5, 21.5 and identify enemies named Gundrak Raptor. Do not enter the Gundrak dungeon or collect its quest eggs expecting the hatchling.",
        "Clear the raptors down the western side toward 71.5, 30.5. Continue along the southern edge toward 76.5, 40.5, killing and looting the raptors as you move. The pins mark parts of a farming circuit, not a single rare spawn.",
        "Work around the eastern side near 83.5, 26.5, then toward the northern raptors around 78.5, 13.5 and back to your starting side. Repeat the U-shaped circuit around the troll structure as enemies respawn. If another player is clearing one section, use the other side rather than waiting at one empty spawn.",
        "Loot every kill. If you have Skinning, skin the looted raptors for extra materials; otherwise just keep the circuit moving. Vendor trash and greens can offset the time spent, but farming unrelated bats does not give the same direct pet attempts.",
        "Use Gundrak Hatchling when it drops and confirm it in the journal. Expect repeated loops and possible thousands of kills; take breaks instead of treating an anecdotal quick drop as a guarantee. A traded item or caged Gundrak Hatchling is a direct alternative.",
    },
    waypoints = {
        pin(121, 71.5, 21.5, 1, "Gundrak Raptors - outdoor western start", "Zul'Drak"),
        pin(121, 71.5, 30.5, 2, "Raptor circuit - western leg", "Zul'Drak"),
        pin(121, 76.5, 40.5, 2, "Raptor circuit - southern leg", "Zul'Drak"),
        pin(121, 83.5, 26.5, 3, "Raptor circuit - eastern leg", "Zul'Drak"),
        pin(121, 78.5, 13.5, 3, "Raptor circuit - northern leg", "Zul'Drak"),
    },
})

-- Razzashi: all 134 parents; source-change and pirate-farm replies expanded.
-- https://www.wowhead.com/item=48126#comments:id=1194348 (4 replies)
-- https://www.wowhead.com/item=48126#comments:id=1504367 (6 replies;
-- last reply corrects the old instant-respawn claim)
-- https://www.wowhead.com/item=48126#comments:id=2426010
-- https://www.wowhead.com/item=48126#comments:id=6091318
-- /npc=940 and /npc=1563 current mappers supply two alternative farming areas.
addPet(239, "Razzashi Hatchling", 48126, {
    category = "Rare Drops", source = "Zone-wide drop - Northern Stranglethorn and the Cape of Stranglethorn",
    sourceComments = { 1194348, 1504367, 2426010, 6091318 },
    requirements = "Either faction; outdoor Stranglethorn enemies. No original Zul'Gurub access required.",
    tips = "This is still obtainable in Retail as an outdoor zone drop. The original raid route is obsolete. It is not the Lashtail Hatchling quest reward and does not come from a collectible nest. The two mapped farming areas are alternatives, not two unlock stages.",
    steps = {
        "Check the normal Auction House for Razzashi Hatchling or its cage if you want a direct purchase. For a self-farmed pet, choose either outdoor area below; the original Zul'Gurub raid is not the current source.",
        "Northern Stranglethorn option: go to Kurzen's Compound around 56.8, 21.2. Clear the Kurzen humanoids through the camp and adjoining routes, looting every body. Killable enemies across this zone can drop the pet; you are not restricted to raptors or one special Kurzen enemy.",
        "Repeat a circuit of the occupied camp as enemies respawn, moving into nearby packs when one section is empty. Keep bag space for the pet among the cloth, equipment and vendor items. Check your bags for an unnoticed pet drop before continuing.",
        "Cape alternative: farm Bloodsail Swashbucklers and Warlocks around 48.6, 38.0 south of the Gurubashi Arena. This can also produce Hyacinth Macaw, but kills reduce Bloodsail Buccaneers reputation. Use the Kurzen route if preserving that reputation. Old comments promising permanently instant pirate respawns were corrected in their replies.",
        "When Razzashi Hatchling appears, use it and confirm the species in the journal. Low drop rates can mean thousands of kills with no pet, and an individual enemy's displayed Wowhead percentage is not proof of a better farm. If your chosen area is crowded, switch to the other mapped outdoor area or buy a cage.",
    },
    waypoints = {
        pin(50, 56.8, 21.2, 2, "Kurzen's Compound - outdoor zone-drop farming option", "Northern Stranglethorn"),
        pin(50, 56.8, 21.2, 3, "Repeat Kurzen camp circuit and loot all kills", "Northern Stranglethorn"),
        pin(210, 48.6, 38.0, 4, "Bloodsail pirates - alternative; reduces Bloodsail reputation", "The Cape of Stranglethorn"),
    },
})

-- Perky Pug: all 52 parents; current /achievement=4478 wording checked.
-- https://www.wowhead.com/item=49912#comments:id=1964004
-- https://www.wowhead.com/item=49912#comments:id=2271226
-- https://www.wowhead.com/achievement=4478#comments:id=5451389 (2 replies)
-- No invented entrance pin: joining the RANDOM queue is the acquisition action.
addPet(250, "Perky Pug", 49912, {
    category = "Achievements", source = "Looking For Multitudes - random Heroic Dungeon Finder groups",
    sourceAchievementId = 4478, sourceComments = { 1964004, 2271226, 5451389 },
    requirements = "Eligibility for Random Heroic Dungeon Finder; complete runs with 100 randomly matched players total.",
    tips = "The counter is random party members, not 100 dungeon completions. Walking into a dungeon, selecting a specific Heroic, or changing your portrait's dungeon difficulty does not replace selecting the Random Heroic queue. There is no fixed outdoor collection location.",
    steps = {
        "Open Achievements > Dungeons & Raids, find Looking For Multitudes (4478), and track its progress. Check the Pet Journal for Perky Pug first if you have run random dungeons on another character.",
        "Open Group Finder > Dungeon Finder and select Random Heroic. Queue on a character that meets the current level and item-level requirements. If the option is unavailable, inspect the Heroic requirements in Specific Dungeons to see what is missing; setting your portrait difficulty to Heroic does not unlock or select the random queue.",
        "Queue with room for randomly matched players and finish the dungeon, including its final encounter. A solo queue allows the finder to fill the other four places. A fully premade group provides no random teammates toward this requirement.",
        "Repeat eligible random Heroic completions until the tracked counter reaches 100 players. Check that it increases after an early run before committing to a long grind. Do not substitute manually entered legacy Heroics or assume every Normal/Timewalking queue qualifies merely because an older comment mentions it.",
        "When Looking For Multitudes completes, check the completing character's mailbox for the WoW Dev Team reward, take Perky Pug, and use it. Then search the journal for the learned species.",
        "If the achievement is already complete but the journal entry is missing, log onto the character that earned it, check its mail and journal filters, and summon the pet there. The item page also reports that assigning the earned pet to a battle slot on that character can refresh an old account-wide collection entry.",
    },
    waypoints = {},
})

-- Short acquisition descriptions accompany the detailed steps in both
-- inspectors and the map. These describe the live route, rather than old loot.
local descriptions = {
    [160] = "A skunk companion awarded automatically for collecting 50 different pet species.",
    [190] = "A floating skull sold by an underground merchant in Northrend Dalaran.",
    [193] = "A rare fishing companion from Dalaran's sewer water; catching the original item also awards I Smell A Giant Rat.",
    [194] = "A brown tickbird randomly hatched from the Oracles' three-day Mysterious Egg.",
    [195] = "The white tickbird variant, collected separately from the brown bird through the same Oracle egg route.",
    [196] = "A small proto-drake pet from an Oracle egg, distinct from the Green Proto-Drake mount in the same reward pool.",
    [197] = "A cobra pet from an Oracle egg, distinct from the common snakes sold by racial pet vendors.",
    [198] = "A penguin purchased with gold after reaching Exalted with Northrend's Kalu'ak.",
    [199] = "An arcane elemental earned by reading Dalaran's eight books and showing the Mastery book to Vargoth.",
    [203] = "A young deer awarded automatically when your account collects 75 different pet species.",
    [204] = "Darnassus' small treant companion, purchased with Champion's Seals at the Argent Tournament.",
    [205] = "Ironforge's bear cub, purchased from its Icecrown tournament quartermaster.",
    [206] = "Undercity's tournament bat companion; this is a separate species from Vampiric Batling.",
    [207] = "Orgrimmar's scorpion companion, purchased with 40 Champion's Seals.",
    [209] = "Stormwind's lamb companion, purchased from the tournament rather than captured as an ordinary Sheep.",
    [210] = "Thunder Bluff's small pink plainstrider, purchased with Champion's Seals in Icecrown.",
    [211] = "A crab found randomly in fishing-daily reward bags, with a caged player-trade alternative.",
    [212] = "The Exodar's walking plant companion, sold by Irisee at the Argent Tournament.",
    [213] = "Silvermoon's animated sweeping broom, sold by Trellis Morningsun in the Horde tournament pavilion.",
    [214] = "An Alliance non-battling companion from your first tournament championship, with an optional portable-services upgrade.",
    [215] = "Gnomeregan's miniature mechanical bird, purchased with Champion's Seals in Icecrown.",
    [216] = "A Horde non-battling companion from your first tournament championship, with an optional portable-services upgrade.",
    [218] = "Sen'jin's floating mask companion, purchased from Samamba at the Argent Tournament.",
    [224] = "A cat purchased directly from Breanni; no rare-spawn camp is needed.",
    [229] = "A tournament mana-wyrm pet shared by both factions' vendor items; only one species is collected.",
    [232] = "An orange raptor companion looted from Dart's Nest in northern Dustwallow Marsh.",
    [233] = "A purple raptor companion dropped by eligible raptors inside Normal Wailing Caverns.",
    [234] = "A blue raptor companion rarely dropped by outdoor Gundrak Raptors in Zul'Drak.",
    [235] = "A dark raptor companion looted from Takk's Nest among the northeastern Northern Barrens trees.",
    [236] = "A dark-colored raptor companion sold directly by Breanni, rather than farmed from a nest.",
    [237] = "A green raptor companion looted from a leafy nest in southeastern Un'Goro Crater.",
    [238] = "A yellow-orange raptor companion looted from the fixed nest ledge inside Wetlands' Raptor Ridge cave.",
    [239] = "A red raptor companion from outdoor Stranglethorn zone drops, with no original-raid requirement.",
    [250] = "A pug rewarded for completing Random Heroic Dungeon Finder runs with 100 randomly matched players total.",
    [254] = "The blue vendor rocket bot, available year-round without Engineering or a holiday event.",
}

-- Retail availability reviewed 2026-11-04: all 35 species retain a live route.
-- Razzashi uses current Stranglethorn drops; the four nest pets do not need
-- their old rare-creature drops. Caged-pet alternatives are valid where listed.
-- https://news.blizzard.com/en-us/article/23507736/wrath-of-the-lich-king-mounts-pets-and-more
-- https://www.wowhead.com/npc=35394/razzashi-hatchling
-- https://www.curseforge.com/wow/addons/adorable-raptor-hatchlings
-- https://warcraft.wiki.gg/wiki/Kirin_Tor_Familiar
rate("easy", "Buy the pet directly for gold from its year-round vendor; no reputation grind is required.", {190,224,236,254})
rate("medium", "Collect the required number of distinct pet species; ordinary vendors and traded pets provide reliable progress.", {160,203})
rate("medium", "Buy a traded pet or unlock Oracles Revered and open three-day eggs until this species hatches.", {194,195,196,197})
rate("medium", "Reach Kalu'ak Exalted through the Northrend quests and repeatable daily quests, then buy Pengu.", {198})
rate("medium", "Complete a city's tournament training and earn 40 Champion's Seals, or buy an eligible traded pet.", {204,205,206,207,209,210,212,213,215,218})
rate("medium", "Complete the Aspirant and Valiant daily stages to earn the first tournament championship.", {214,216})
rate("medium", "Unlock the faction's tournament vendor and earn its reputation and seals, or buy a caged Wyrmling.", {229})
rate("medium", "Repeat fishing-daily reward bags or buy a caged pet to bypass the random reward.", {211})
rate("medium", "Find the correct respawning raptor nest or buy the pet; killing the associated rare is unnecessary.", {232,235,237,238})
rate("medium", "Repeat Normal Wailing Caverns raptor clears or buy the pet; instance-entry limits constrain the farm.", {233})
rate("medium", "Complete enough Random Heroic Dungeon Finder runs to group with 100 randomly matched players.", {250})
rate("hard", "Fish the Northrend Underbelly for a rare catch, or find a traded pet; there is no guaranteed catch count.", {193})
rate("hard", "Find all eight correct Dalaran books among decoy spawns and multi-hour respawn timers.", {199})
rate("hard", "The outdoor raptor drop is very rare; a traded pet can bypass the farm but supply and price vary.", {234})
rate("hard", "The current Stranglethorn world drop is extremely rare; buying a traded pet avoids an unbounded farm.", {239})

-- Apply reviewed acquisition fields to BOTH catalog surfaces. Keep the original
-- species IDs, names, patch membership and unrelated metadata intact.
local fields = {
    "acquisition", "itemId", "npcId", "source", "tips", "requirements", "cost",
    "category", "waypoints", "faction", "sourceAchievementId", "description", "difficulty", "difficultyReason",
}
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^3%.") then
        for _, entry in ipairs(patch.pets or {}) do
            local guide = guides[entry.speciesId]
            if guide then
                guide.description = descriptions[entry.speciesId]
                local detailsByName = TDP.PatchCatalog.petDetails[patchKey]
                local original = detailsByName[entry.name] or {}
                local details = {}
                for key, value in pairs(original) do details[key] = value end
                for _, field in ipairs(fields) do
                    if guide[field] ~= nil then
                        entry[field], details[field] = guide[field], guide[field]
                    end
                end
                details.sourceType = guide.category
                detailsByName[entry.name] = details
            end
        end
    end
end
