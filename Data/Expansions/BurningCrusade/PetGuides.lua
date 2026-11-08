-- Hand-curated Burning Crusade pet walkthroughs for Retail, reviewed 2026-11-01.
-- All 21 item comment sets were read (880 parent comments), with relevant
-- replies expanded and compared with current vendor, quest and map records.
-- No numbered acquisition comment ending in profit qualified. The profit
-- match on Captured Firefly concerns selling other pets, not acquisition.
-- The steps below synthesize that research and retain useful existing advice.
-- Original Quel'Thalas maps are used only with their still-usable Retail access.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.pets = TDP.CollectionWalkthroughs.pets or {}
local guides = TDP.CollectionWalkthroughs.pets

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
    guide.faction = "all"
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[speciesID] = guide
end

-- Each item's comments were read separately: 29363 (18), 29364 (6),
-- 29902 (5), 29958 (10). No profit walkthroughs in these four sets.
-- https://www.wowhead.com/item=29363#comments:id=181835
-- https://www.wowhead.com/item=29364#comments:id=323931 and reply
-- https://www.wowhead.com/item=29902#comments
-- https://www.wowhead.com/item=29958#comments
-- https://www.wowhead.com/npc=20980#comments:id=2538309
-- https://www.wowhead.com/npc=20980#comments:id=874329 and replies
for _, pet in ipairs({
    { 136, "Mana Wyrmling", 29363, "Mana Wyrmling", 40 },
    { 137, "Brown Rabbit", 29364, "Brown Rabbit Crate", 10 },
    { 139, "Red Moth", 29902, "Red Moth Egg", 10 },
    { 145, "Blue Dragonhawk Hatchling", 29958, "Blue Dragonhawk Hatchling", 10 },
}) do
    local speciesID, name, itemID, itemName, price = unpack(pet)
    addPet(speciesID, name, itemID, {
        steps = {
            "Take a character of either faction to Outland. You can use your capital's Shattrath portal, then travel north through Zangarmarsh and Blade's Edge Mountains to Netherstorm, or fly directly if able. Bring " .. price .. " gold for this pet before any Consortium discount.",
            "Reach the Stormspire in northern Netherstorm. Dealer Rashaad stands on its upper settlement platform, beside the inn, at 43.5, 35.2. Fly up or use the settlement's lift; the marker is not a vendor down at the base of the rock.",
            "Open Dealer Rashaad's shop and buy " .. itemName .. " (" .. itemID .. "). Its base price is " .. price .. " gold. His pet stock is unlimited, and Neutral Consortium reputation is sufficient; higher reputation only reduces the price.",
            "Use " .. itemName .. " from your bags, then find " .. name .. " in Collections > Pet Journal. Learning it unlocks the species across your account, so you do not need to repeat the trip for every character.",
        },
        source = "Dealer Rashaad - the Stormspire, Netherstorm",
        category = "Vendor", npcId = 20980,
        requirements = "Either faction; access to the Stormspire. No reputation grind required.",
        cost = price .. " gold base; Consortium reputation discounts apply.",
        tips = "Brown Rabbit differs from Snowshoe Rabbit. Rashaad's Red Moth and Blue Dragonhawk are different colors from the moths and dragonhawks sold in the racial starting areas. Select the item named in this guide.",
        waypoints = {
            pin(109, 43.5, 35.2, 2, "Dealer Rashaad - upper Stormspire, beside the inn"),
            pin(109, 43.5, 35.2, 3, "Buy " .. itemName),
        },
    })
end

-- Item sets: Blue Moth (12), Yellow Moth (8), White Moth (8).
-- https://www.wowhead.com/item=29901#comments:id=98956 and correcting reply
-- https://www.wowhead.com/item=29903#comments:id=1472596 and replies
-- https://www.wowhead.com/item=29904#comments:id=131904 and account-wide reply
-- https://www.wowhead.com/npc=21019#comments:id=409859 and floor corrections
for _, pet in ipairs({
    { 138, "Blue Moth", 29901, "Blue Moth Egg" },
    { 140, "Yellow Moth", 29903, "Yellow Moth Egg" },
    { 141, "White Moth", 29904, "White Moth Egg" },
}) do
    local speciesID, name, itemID, itemName = unpack(pet)
    addPet(speciesID, name, itemID, {
        steps = {
            "Use an Alliance character for the vendor purchase. Horde collectors can learn the pet on an Alliance alt and use the account-wide unlock, or buy the matching caged species from a player. Bring 50 silver before discounts.",
            "Enter The Exodar on Azuremyst Isle and go to the Crystal Hall. Find Sixx at about 30.0, 34.0 on the southwest side of the hall. Look on the hall's lower walking level; the platform overhead at the same coordinates is too high.",
            "Speak to Sixx, the Moth Keeper, and buy " .. itemName .. " (" .. itemID .. "). The base price is 50 silver, reduced by applicable discounts. Any Alliance race can buy it; you do not have to be Draenei.",
            "Use the egg from your bags and search the Pet Journal for " .. name .. ". Sixx sells three separate colors, so buying a different egg does not collect this species. Once learned, it is also available to your Horde characters.",
        },
        source = "Sixx - lower level of the Crystal Hall, The Exodar",
        category = "Vendor", npcId = 21019,
        requirements = "Alliance character for the vendor; learned pet available to either faction.",
        cost = "50 silver base before applicable vendor discounts.",
        tips = "Dealer Rashaad sells Red Moth, not these three Exodar colors. Account-wide learning on an alt avoids the old neutral-Auction-House transfer described in early comments.",
        waypoints = {
            pin(103, 30.0, 34.0, 2, "Sixx - southwest Crystal Hall; below the upper platform"),
            pin(103, 30.0, 34.0, 3, "Buy " .. itemName),
        },
    })
end

-- Item sets: Golden (12), Red (10), Silver (9). Gold-resale comments are
-- not acquisition walkthroughs; faction/account-wide corrections are retained.
-- https://www.wowhead.com/item=29953#comments:id=1740577
-- https://www.wowhead.com/item=29956#comments:id=901050 and reply
-- https://www.wowhead.com/item=29957#comments:id=1873583
-- https://www.wowhead.com/npc=16860#comments:id=159862 and location replies
-- https://www.wowhead.com/quest=56903#comments:id=6285183 and replies
-- https://www.wowhead.com/npc=259326#comments:id=6333717 (2026 border)
-- https://www.wowhead.com/zone=3430#comments:id=6389640 (Retail phase access)
for _, pet in ipairs({
    { 142, "Golden Dragonhawk Hatchling", 29953 },
    { 143, "Red Dragonhawk Hatchling", 29956 },
    { 144, "Silver Dragonhawk Hatchling", 29957 },
}) do
    local speciesID, name, itemID = unpack(pet)
    addPet(speciesID, name, itemID, {
        steps = {
            "Use a Horde character and bring 50 silver before discounts. Alliance collectors can learn this species on a Horde alt for the account-wide unlock, or buy a matching caged pet. Jilanne's shop is not Alliance-friendly.",
            "Travel to Zidormi at 53.8, 8.6 in northern Eastern Plaguelands, by the Ghostlands border. Ask to visit Eversong Woods during the Burning Crusade and use the adjoining route into the original Ghostlands. This old version remains accessible in Retail after Midnight. If already in original Eversong, continue to step 3.",
            "Travel north through original Ghostlands into Eversong Woods (Burning Crusade), then go to Fairbreeze Village at 44.8, 71.6. Find Jilanne inside the small house beside the inn, on the ground floor. Early posts putting her upstairs in the inn predate her move.",
            "Buy " .. name .. " (" .. itemID .. ") from Jilanne. The base price is 50 silver before discounts. Golden, Red and Silver are separate purchases; the Blue Dragonhawk Hatchling comes from Dealer Rashaad instead.",
            "Use the hatchling item in your bags, then find " .. name .. " in the Pet Journal. Once learned, the pet is available across your account, including on Alliance characters.",
        },
        source = "Jilanne - Fairbreeze Village in original Eversong Woods, via Retail's Burning Crusade phase",
        category = "Vendor", npcId = 16860,
        requirements = "Horde buyer; access to original Eversong through Zidormi or an existing original-zone route.",
        cost = "50 silver base before applicable vendor discounts.",
        tips = "The Fairbreeze pin uses original Eversong Woods (#94), not Midnight Eversong (#2395). Switch to the original zone first. Ground travel is needed there; current Eversong flying access does not apply to the old map.",
        waypoints = {
            pin(23, 53.8, 8.6, 2, "Zidormi - choose Burning Crusade Eversong / Ghostlands"),
            pin(94, 44.8, 71.6, 3, "Jilanne - house beside the Fairbreeze inn", "Eversong Woods (Burning Crusade phase)"),
            pin(94, 44.8, 71.6, 4, "Buy " .. name, "Eversong Woods (Burning Crusade phase)"),
        },
    })
end

-- 100 parent comments on the pet item; Mr. Pinchy's supporting page and
-- current XML tooltip establish three charges / FOUR HOURS, not two days.
-- https://www.wowhead.com/item=27445#comments:id=75511
-- https://www.wowhead.com/item=27445#comments:id=5775030 (three lake locations)
-- https://www.wowhead.com/item=27388#comments:id=2879377
-- https://www.wowhead.com/item=27388#comments:id=3196747
-- https://www.wowhead.com/item=27388#comments:id=6061775 and skill replies
-- https://www.wowhead.com/item=27388&xml
-- https://www.wowhead.com/npc=18911/juno-dufrain
addPet(132, "Magical Crawdad", 27445, {
    steps = {
        "Learn Fishing and Outland Fishing before starting. Juno Dufrain at 78.0, 66.0 in Cenarion Refuge, Zangarmarsh, is an Outland fishing trainer. Bring a character able to fly to Terokkar's high lakes; the old 375/525-skill and fishing-tournament-gear instructions are unnecessary for pool fishing in Retail.",
        "Fly to Lake Jorune, above Stonebreaker Hold in Terokkar Forest, around 46.3, 39.6. Look specifically for Highland Mixed Schools. Position your cast so the bobber lands inside the visible school, catch and loot, then continue until that pool disappears.",
        "When that lake has no schools, check Lake Ere'Noru above Allerian Stronghold around 60.3, 59.2, then Blackwind Lake at Skettis around 66.4, 80.0. Circle the shore and fish the Highland Mixed Schools. Rotate among the three lakes rather than casting into empty open water.",
        "Keep fishing and fully loot each catch until you obtain Mr. Pinchy (27388). Ordinary Furious Crawdad is cooking fish, not the pet item. Mr. Pinchy is rare, so another player's low cast count does not establish a guaranteed number of catches.",
        "With a free bag slot, right-click Mr. Pinchy to spend a wish. It has three charges. A wish can create Magical Crawdad Box, a buff, a temporary friendly or hostile creature, or another gift. You do not need to talk to a summoned creature to choose the pet.",
        "If the first wish does not give Magical Crawdad Box, keep Mr. Pinchy and wait FOUR HOURS before the next use. Use the remaining charges as they become ready. Copies carried by the same character share the cooldown. If all three fail, fish another Mr. Pinchy and continue.",
        "When Magical Crawdad Box appears in your bags, use it to learn Magical Crawdad and check the Pet Journal. The species can also be bought as a caged pet from another player if you prefer to skip fishing.",
    },
    source = "Mr. Pinchy wishes - Highland Mixed Schools in Terokkar Forest",
    category = "Professions",
    requirements = "Fishing; access to Terokkar's elevated lakes. Mr. Pinchy requires level 23 to use.",
    cost = "Fishing training if needed; no purchase cost for the fishing route.",
    tips = "There are two random stages: catching Mr. Pinchy, then receiving the box from a wish. Three wishes can yield no pet, one pet or multiple pets. The lake pins mark search areas for schools, not permanently active pools.",
    waypoints = {
        pin(102, 78.0, 66.0, 1, "Juno Dufrain - learn Outland Fishing if needed"),
        pin(108, 46.3, 39.6, 2, "Lake Jorune - Highland Mixed School search area"),
        pin(108, 60.3, 59.2, 3, "Lake Ere'Noru - Highland Mixed School search area"),
        pin(108, 66.4, 80.0, 3, "Blackwind Lake - circle the shore for schools"),
    },
})

-- All 22 item comments; the escort quest's comments add route and pause details.
-- https://www.wowhead.com/item=31760#comments:id=264862
-- https://www.wowhead.com/item=31760#comments:id=410266 and recovery replies
-- https://www.wowhead.com/item=31760#comments:id=1924551 and prerequisite reply
-- https://www.wowhead.com/quest=10898#comments:id=2293376 and reply
-- https://www.wowhead.com/quest=10898#comments:id=5797550
-- https://www.wowhead.com/npc=22424/skywing
-- https://www.wowhead.com/npc=18533/luanga-the-imprisoner
-- https://www.wowhead.com/npc=22292/rilak-the-redeemed
addPet(149, "Miniwing", 31760, {
    steps = {
        "Enable Trivial Quests on your minimap tracking menu, then go to Veil Shalas in southern Terokkar Forest. Find Skywing, the large white bird, near 53.8, 72.2 at the base of the tree settlement. He patrols, so search the nearby ground if the exact point is empty.",
        "Accept Skywing (10898) from the bird and stay close as he enters the tree and climbs the ramps. Put a raid marker on him if it helps you track him. If another player has already started the escort, wait for Skywing to return to the starting area.",
        "Follow him across the raised platforms and bridges, killing enemies he pulls. He can pause near the first tree for about a minute; allow the escort to continue before abandoning it. At the platform drop, follow him onto the lower platform rather than taking the long ground route away from him.",
        "Near 55.6, 69.6, help Skywing fight Luanga the Imprisoner. Keep your back toward the central structure so a knockback cannot throw you from the platform. Stay until Skywing's transformation finishes and your quest log records completion.",
        "Return to Rilak the Redeemed at 52.6, 20.8 in Shattrath City's Lower City and turn in Skywing. Miniwing is the pet reward; collect it from the quest turn-in and use the item from your bags to learn the species.",
    },
    source = "Skywing escort in Veil Shalas; turn in to Rilak the Redeemed in Shattrath",
    category = "Quests", npcId = 22424,
    requirements = "Skywing quest available on the character; either faction.",
    cost = "No purchase cost for the quest reward.",
    tips = "If the escort fails, check your quest log before abandoning, then wait for the bird to respawn and retry. A brief pause is normal. Stable-master replacement comments concern characters that already completed the quest; they are not a first-time purchase route.",
    waypoints = {
        pin(108, 53.8, 72.2, 1, "Skywing - patrol near the base of Veil Shalas"),
        pin(108, 53.8, 72.2, 2, "Accept Skywing and follow the bird"),
        pin(108, 56.8, 70.6, 3, "Escort platform drop - stay with Skywing"),
        pin(108, 55.6, 69.6, 4, "Luanga - finish the escort and transformation"),
        pin(111, 52.6, 20.8, 5, "Rilak the Redeemed - turn in Skywing"),
    },
})

-- All 212 item comments. The only profit match is unrelated resale advice.
-- https://www.wowhead.com/item=29960#comments:id=368263 and both replies
-- https://www.wowhead.com/item=29960#comments:id=1783861
-- https://www.wowhead.com/item=29960#comments:id=6003632
-- https://www.wowhead.com/npc=20197/bogflare-needler (current spawn points)
addPet(146, "Firefly", 29960, {
    steps = {
        "Travel to northern Zangarmarsh in Outland. The target enemy is Bogflare Needler (20197), and the item you need is Captured Firefly (29960). Other glowing insects, wild battle pets and the similarly named Tiny Flamefly do not unlock this species.",
        "Start on the western shore of Serpent Lake around 38.8, 39.4. Kill and loot Bogflare Needlers as you follow the shore north toward 43.5, 35.5. Check the nameplate before pulling; the surrounding sporebats are useful for other materials but do not drop this pet.",
        "Continue east along the northern shore through 49.6, 31.4 toward 58.6, 36.2. Make a return pass through the same spawn belt; you can also check the smaller southeastern cluster around 59.6, 46.2 while the northern groups respawn.",
        "Loot every Needler before moving on and repeat the circuit. If the whole route is dead, wait for respawns or return later. Keep Glowcaps you find if you also want Tiny Sporebat, which costs 30 Glowcaps at Sporeggar Exalted. Vendor ordinary insect parts to keep bag space available.",
        "Use Captured Firefly when it drops. The learned species is named Firefly in the Pet Journal, so search under F. You can also buy the item or matching caged Firefly from another player; check the species before paying.",
    },
    source = "Bogflare Needlers - northern Serpent Lake, Zangarmarsh",
    category = "Rare Drops", npcId = 20197,
    requirements = "Either faction; able to kill and loot Bogflare Needlers.",
    cost = "No purchase cost when farming; player prices vary.",
    tips = "This is a very rare drop with widely varying kill counts. A route makes more eligible kills available but does not guarantee a drop after a fixed number. The pins mark a farming circuit, not individual permanent spawns.",
    waypoints = {
        pin(102, 38.8, 39.4, 2, "Bogflare Needlers - western shore start"),
        pin(102, 43.5, 35.5, 2, "Bogflare Needlers - northwest shore"),
        pin(102, 49.6, 31.4, 3, "Bogflare Needlers - northern shore"),
        pin(102, 58.6, 36.2, 3, "Bogflare Needlers - northeast end of circuit"),
        pin(102, 59.6, 46.2, 3, "Bogflare Needlers - optional southeastern cluster"),
    },
})

-- All 124 item comments; prefer the Retail dungeon explanation over removed
-- raid gauntlet/reset tactics. The full replies reject a guaranteed 13th frog.
-- https://www.wowhead.com/item=33993#comments:id=5634380
-- https://www.wowhead.com/item=33993#comments:id=1387312 and replies
-- https://www.wowhead.com/item=33993#comments:id=2006585 and both replies
-- https://www.wowhead.com/item=33993#comments:id=2060966 and reply
-- https://www.wowhead.com/zone=3805#comments:id=2477075 and gong replies
-- https://www.wowhead.com/npc=24396/forest-frog (pool coordinates)
-- https://www.wowhead.com/npc=52924/voljin (entry event position)
-- https://www.wowhead.com/npc=259326/zidormi (still-usable original phase)
-- https://wago.tools/db2/UiMap/csv : original dungeon 333, Midnight zone 2437.
addPet(165, "Mojo", 33993, {
    steps = {
        "Reach Zidormi at 53.8, 8.6 in northern Eastern Plaguelands and choose the Burning Crusade version of Eversong Woods and Ghostlands. Travel into original Ghostlands. This accesses the old-zone dungeon in Retail, rather than Midnight's outdoor Zul'Aman.",
        "Set Dungeon Difficulty to HEROIC and enter Zul'Aman at about 82.0, 64.0 in original Ghostlands. The accessible legacy instance is the Cataclysm five-player dungeon; there is no Normal mode for this route and no need to form an old ten-player raid.",
        "Inside, talk to Vol'jin to start the entry event. When the gong becomes usable, click it ONCE and remain still while your character channels. Wait for Vol'jin to finish and open the gate; repeated clicks can interrupt the action.",
        "Kill and loot the dungeon's Amani trash for Amani Hex Sticks (33865). Work through the paths as necessary; killing every boss is not required for the pet. Keep the central Forest Frogs alive and avoid sweeping them up in area attacks.",
        "Return to the pools around the central platform. Forest Frogs gather around 38.6, 51.6 on the west side and 49.4, 50.6 on the east side of the dungeon map. Target a living Forest Frog and use an Amani Hex Stick from your bags. Each attempt consumes a stick.",
        "Most frogs reveal people who may leave a small box or bag on the ground. Loot these before leaving, since boxes can contain another Hex Stick. Keep using sticks on frogs, waiting for frogs to respawn if necessary. Rescuing all other people does not guarantee Mojo on the next attempt.",
        "When the successful transformation occurs, Mojo jumps into your bags automatically. Leave a free slot and use the Mojo item immediately to learn the pet; the unused item is Unique, so carrying one can block another successful reward.",
        "If you run out of sticks, continue any unlooted trash or try another eligible character. Cleared Heroic bosses do not refresh with Reset All Instances. Sticks can also be traded or bought from players. Learning a matching caged Mojo is another way to skip the farm.",
    },
    source = "Amani Hex Sticks on Forest Frogs - legacy Heroic Zul'Aman",
    category = "Rare Drops",
    requirements = "Access to original Ghostlands and legacy Heroic Zul'Aman; either faction.",
    cost = "Farm Amani Hex Sticks or buy them from players; one consumed per frog attempt.",
    tips = "The frog result is random. The old Prigmon /kiss acquisition trick was removed; /kiss is an effect of the already-learned Mojo. Original Ghostlands (#95) and dungeon #333 remain accessible through Retail's original-zone route.",
    waypoints = {
        pin(23, 53.8, 8.6, 1, "Zidormi - enter original Eversong / Ghostlands"),
        pin(95, 82.0, 64.0, 2, "Legacy Zul'Aman entrance - set Heroic", "Ghostlands (original Retail phase)"),
        pin(333, 14.2, 53.2, 3, "Vol'jin - start the gong event", "Zul'Aman (legacy Heroic dungeon)"),
        pin(333, 38.6, 51.6, 5, "Forest Frogs - west central pool", "Zul'Aman (legacy Heroic dungeon)"),
        pin(333, 49.4, 50.6, 5, "Forest Frogs - east central pool", "Zul'Aman (legacy Heroic dungeon)"),
        pin(333, 38.6, 51.6, 6, "Unhex more frogs and loot the small reward boxes", "Zul'Aman (legacy Heroic dungeon)"),
    },
})

-- All 36 item comments; the old Sporeggar shrubbery quest is obsolete.
-- https://www.wowhead.com/item=34478#comments:id=180528 and replies
-- https://www.wowhead.com/item=34478#comments:id=179043 and reputation-cap reply
-- https://www.wowhead.com/quest=9715#comments:id=6288217 (2026 correction)
-- https://www.wowhead.com/quest=29691#comments:id=1583472
-- https://www.wowhead.com/quest=29692#comments:id=2317891
-- https://www.wowhead.com/quest=29692#comments:id=6038363
-- https://www.wowhead.com/zone=3716#comments:id=1630502 and entrance reply
-- https://www.wowhead.com/npc=18382/mycah (30 Glowcaps)
addPet(167, "Tiny Sporebat", 34478, {
    steps = {
        "Check your Sporeggar reputation on the purchasing character. If already Exalted, skip to step 6. Otherwise set Dungeon Difficulty to NORMAL and go to Coilfang Reservoir in Zangarmarsh, at 50.4, 40.9 in the middle of Serpent Lake.",
        "Dive down the large central pipe and swim through the underwater tunnel until you surface in the entrance cavern. Take the rightmost dungeon portal, The Underbog, around 54.2, 34.5 on the Zangarmarsh map. Speak to T'shu just inside and accept Bring Me A Shrubbery! (29691). No prior Sporeggar reputation is needed for this version.",
        "Pick Sanguine Hibiscus from the glowing plants inside the dungeon and loot them from eligible enemies. Clear the opening bog-creature section through Hungarfen and the path toward the first naga. Herbalism is not required to gather these quest plants.",
        "Return to T'shu inside the entrance. Turn in 5 Sanguine Hibiscus, then repeat Bring Me Another Shrubbery! (29692), 5 flowers per turn-in, for 750 base Sporeggar reputation each time. Keep the flowers in your bags; items counted from storage cannot be handed over until withdrawn.",
        "Continue until Exalted: gather more hibiscus, hand them in, leave the dungeon and reset Normal instances for another run when needed. Eligible kills in Normal also give Sporeggar reputation. You can instead buy tradable Sanguine Hibiscus; starting at exactly Neutral with no bonus or kill reputation takes 280 flowers for 42,000 reputation. Check your actual standing before buying.",
        "Gather 30 Glowcaps from the small mushrooms around western and northern Zangarmarsh, or buy them from players. Keep these separate from the hibiscus: Glowcaps are the purchase currency, not the repeatable turn-in reagent for Exalted.",
        "At Sporeggar Exalted, speak to Mycah at 17.8, 51.2 in Sporeggar. Buy Tiny Sporebat (34478) for 30 Glowcaps and use the item to learn it. A matching caged pet from another player does not require you to earn the reputation yourself.",
    },
    source = "Mycah - Sporeggar Exalted; 30 Glowcaps",
    category = "Reputation", npcId = 18382,
    requirements = "Sporeggar Exalted on the buyer; 30 Glowcaps. Either faction.",
    cost = "30 Glowcaps; optional purchased hibiscus or caged pet at player prices.",
    tips = "Use T'shu INSIDE Underbog for the current shrubbery quests, not Gzhun'tt in Sporeggar. Normal mode supports repeat farming. Reputation bonuses and kills reduce the number of flowers needed; buying 280 is only the from-Neutral, turn-ins-only baseline.",
    waypoints = {
        pin(102, 50.4, 40.9, 1, "Coilfang Reservoir - dive into the central pipe"),
        pin(102, 54.2, 34.5, 2, "Underbog portal - T'shu is just inside"),
        pin(102, 54.2, 34.5, 4, "Underbog - return to T'shu inside for hibiscus turn-ins"),
        pin(102, 17.8, 51.2, 7, "Mycah - buy Tiny Sporebat for 30 Glowcaps"),
    },
})

-- Item sets: Toothy (35), Muckbreath (25), Snarly (19), Chuck (36).
-- https://www.wowhead.com/item=35350#comments:id=2540228 (numbered guide)
-- https://www.wowhead.com/item=33816#comments:id=239234 (correct reward bag)
-- https://www.wowhead.com/item=33818#comments:id=642096 and duplicate reply
-- https://www.wowhead.com/item=35349#comments:id=260869 and all seven replies
-- https://www.wowhead.com/quest=11665#comments:id=5836038 and location replies
-- https://www.wowhead.com/quest=11665#comments:id=2547136
-- https://www.wowhead.com/quest=11665#comments:id=6410617 (no duplicate protection)
-- https://www.wowhead.com/npc=25580#comments:id=3365379 (Retail level 30)
-- https://www.wowhead.com/npc=98685/cupri (35348 costs 150 badges)
-- https://www.wowhead.com/item=35348#comments:id=2286463
for _, pet in ipairs({
    { 163, "Toothy", 33816, "Toothy's Bucket" },
    { 164, "Muckbreath", 33818, "Muckbreath's Bucket" },
    { 173, "Snarly", 35349, "Snarly's Bucket" },
    { 174, "Chuck", 35350, "Chuck's Bucket" },
}) do
    local speciesID, name, itemID, itemName = unpack(pet)
    addPet(speciesID, name, itemID, {
        steps = {
            "Choose the fishing-daily route in steps 2-6, or the optional Timewalking purchase in steps 7-8. For the daily, use a level-30-or-higher character with Fishing learned. Low fishing skill is sufficient for the baby-crocolisk catch; an old level-70 requirement does not apply in Retail.",
            "Visit Old Man Barlo at 38.6, 12.8 beside Silmyr Lake, northeast of Shattrath in Terokkar Forest. Accept Crocolisks in the City (11665). He offers one of five fishing dailies; if a different quest is offered, check again on another day. Enable Trivial Quests if his marker is hidden.",
            "With Crocolisks in the City active, fish in your faction's capital until you loot a Baby Crocolisk: Alliance can use Stormwind's canal near 67.9, 63.2; Horde can use the Valley of Honor waterfall in Orgrimmar around 60.3, 40.7. Keep casting in the water until the quest completes; the catch is not guaranteed on the first cast.",
            "Return to Old Man Barlo and turn in the quest. Open Bag of Fishing Treasures (35348). This is the crocolisk-reward bag; the similarly named 34863 from his other four dailies is not the pet-farming bag.",
            "If the bag contains " .. itemName .. " (" .. itemID .. "), use that bucket from your bags and find " .. name .. " in the Pet Journal. Learning another crocolisk does not collect this species.",
            "If the bag has no pet or a different crocolisk, repeat on another eligible character while the daily is offered, or wait for the next available day. The four possible pets are Toothy, Muckbreath, Snarly and Chuck. Duplicate species can drop before you complete the set.",
            "Optional Timewalking route: while Burning Crusade Timewalking is active, visit Cupri in Shattrath around 54.5, 39.0. Buy Bag of Fishing Treasures (35348) for 150 Timewarped Badges per bag. Check the item and price in the shop; this route does not require the fishing daily to be offered.",
            "Open the purchased bag and use " .. itemName .. " if it appears. Each additional bag is another random chance, not a selected pet. You can also learn a matching caged " .. name .. " bought from another player instead of spending more badges or doing more dailies.",
        },
        source = "Crocolisks in the City reward bag; also Cupri during Burning Crusade Timewalking",
        category = "Daily Quests", npcId = 25580,
        requirements = "Daily: level 30+, Fishing and Crocolisks in the City offered. Optional vendor: active Burning Crusade Timewalking and badges; bag requires level 30.",
        cost = "Daily reward: no badge cost. Optional Cupri bag: 150 Timewarped Badges per attempt.",
        tips = "The baby you fish up completes the quest; it is not the learnable pet. Open the reward bag for the bucket. No duplicate protection guarantees a missing crocolisk, and learning the pet on an alt still unlocks it account-wide.",
        waypoints = {
            pin(108, 38.6, 12.8, 2, "Old Man Barlo - check for Crocolisks in the City"),
            pin(84, 67.9, 63.2, 3, "Alliance - fish in Stormwind canal with the quest active"),
            pin(85, 60.3, 40.7, 3, "Horde - fish at the Valley of Honor waterfall"),
            pin(108, 38.6, 12.8, 4, "Old Man Barlo - turn in for Bag of Fishing Treasures"),
            pin(108, 38.6, 12.8, 6, "Repeat the daily on eligible characters when offered"),
            pin(111, 54.5, 39.0, 7, "Cupri - optional Timewalking fishing bags"),
        },
    })
end

-- All 150 item comments; both difficulties confirmed, speed-kill myth rejected.
-- https://www.wowhead.com/item=35504#comments:id=1307363
-- https://www.wowhead.com/item=35504#comments:id=1427615
-- https://www.wowhead.com/item=35504#comments:id=671201 and all eight replies
-- https://www.wowhead.com/item=35504#comments:id=1804099 and cage reply
-- https://www.wowhead.com/item=35513#comments:id=6370420 (post-Midnight portal)
-- https://www.wowhead.com/npc=24723/selin-fireheart
-- https://www.wowhead.com/npc=24744/vexallus
-- https://www.wowhead.com/npc=24560/priestess-delrissa
-- https://www.wowhead.com/npc=24664/kaelthas-sunstrider
-- Retail UiMap / UiMapGroupMember: Observation Grounds 349; Asylum 348.
addPet(175, "Phoenix Hatchling", 35504, {
    steps = {
        "Go to Shattrath City and take the portal at 48.6, 42.0 to the ORIGINAL Isle of Quel'Danas. Post-Midnight Retail comments confirm that it still reaches the old island. Use that route for Kael'thas's old dungeon, rather than Midnight's new Magisters' Terrace.",
        "For repeat pet attempts, set Dungeon Difficulty to NORMAL and enter original Magisters' Terrace at 61.2, 30.9 on original Isle of Quel'Danas. Phoenix Hatchling drops on Normal and Heroic. You may instead do a daily Heroic run if you also want a chance at Swift White Hawkstrider.",
        "On Observation Grounds, defeat Selin Fireheart at 42.4, 22.3, then continue through the mana-wyrm hall to Vexallus at 83.4, 26.4 and defeat him. Finish any enemies keeping you in combat and follow the opened route toward the courtyard.",
        "On Grand Magister's Asylum, defeat Priestess Delrissa and ALL four companions at 39.7, 55.7. A surviving companion can leave the encounter unfinished. Continue to Kael'thas's chamber once the route opens.",
        "Defeat Kael'thas Sunstrider at 8.6, 50.2 on the same floor and loot him for Phoenix Hatchling (35504). If Gravity Lapse occurs, avoid the floating orbs and finish the fight. Whether he summons a phoenix does not guarantee the pet drop.",
        "If the pet drops, use the item and check the Pet Journal. Otherwise use the exit orb behind Kael'thas, leave, reset the NORMAL instance and repeat. If the game reports too many recent instances, wait for access to return. Heroic boss loot instead resets daily on that character.",
    },
    source = "Kael'thas Sunstrider - original Magisters' Terrace, Normal or Heroic",
    category = "Dungeon and Raids", npcId = 24664,
    requirements = "Access to original Isle of Quel'Danas and original Magisters' Terrace; either faction.",
    cost = "No purchase cost when farming; matching caged pet can be bought from players.",
    tips = "The pet's repeatable Normal route differs from the mount's Heroic route. Loot Kael'thas in Magisters' Terrace, not the similarly named raid boss in The Eye. The item is soulbound, but the learned species can be caged and traded.",
    waypoints = {
        pin(111, 48.6, 42.0, 1, "Shattrath portal - original Isle of Quel'Danas"),
        pin(122, 61.2, 30.9, 2, "Original Magisters' Terrace - Normal for repeated pet attempts", "Isle of Quel'Danas (original)"),
        pin(349, 42.4, 22.3, 3, "Selin Fireheart - first boss", "Magisters' Terrace (original): Observation Grounds"),
        pin(349, 83.4, 26.4, 3, "Vexallus - second boss", "Magisters' Terrace (original): Observation Grounds"),
        pin(348, 39.7, 55.7, 4, "Priestess Delrissa - defeat all companions", "Magisters' Terrace (original): Grand Magister's Asylum"),
        pin(348, 8.6, 50.2, 5, "Kael'thas - Phoenix Hatchling drop", "Magisters' Terrace (original): Grand Magister's Asylum"),
    },
})

-- All 23 item comments. The report about a Draenor vendor confuses a different
-- species; retain the verified Grella / Sha'tari Skyguard acquisition.
-- https://www.wowhead.com/item=38628#comments:id=327250 and reply
-- https://www.wowhead.com/item=38628#comments:id=1756611 and cage replies
-- https://www.wowhead.com/npc=23367#comments:id=1110145 and reply
-- https://www.wowhead.com/faction=1031#comments:id=1174572 and replies
-- https://www.wowhead.com/faction=1031#comments:id=6017405
-- https://www.wowhead.com/faction=1031#comments:id=6060894
-- https://www.wowhead.com/faction=1031#comments:id=6407576
-- https://www.wowhead.com/npc=23449/yuula
-- https://www.wowhead.com/npc=23038/sky-commander-adaris
-- https://www.wowhead.com/npc=23306/hazzik
-- https://www.wowhead.com/quest=11005/secrets-of-the-talonpriests
-- https://www.wowhead.com/npc=23067/talonpriest-skizzik
-- https://www.wowhead.com/npc=23068/talonpriest-zellek
-- https://www.wowhead.com/quest=11056#comments:id=87793 and location replies
-- https://www.wowhead.com/npc=23363/sahaak
-- https://www.wowhead.com/object=185913/skull-pile
addPet(186, "Nether Ray Fry", 38628, {
    steps = {
        "If your purchasing character is already Exalted with Sha'tari Skyguard, skip to step 10. Otherwise speak to Yuula beside Shattrath's flight master around 64.0, 42.0. Complete Threat from Above by killing 20 Gordunni ogres in the Barrier Hills north of the city, around 22.0, 12.0 on the Terokkar map. Return to Yuula, then follow To Skettis! to Adaris at Blackwind Landing, 64.0, 66.8.",
        "At Blackwind Landing, take World of Shadows from Severin. Kill Skettis arakkoa for 6 Shadow Dust and exchange them for Elixir of Shadows. Use the elixir to see time-lost arakkoa; keep that buff active while gathering their Time-Lost Scrolls. More Shadow Dust is repeatable, not a daily.",
        "Follow Secrets of the Talonpriests from Adaris with Elixir of Shadows active. Kill Zellek on the tree platform at 70.0, 74.4, Ishaal on the tree platform around 69.3, 78.5, and Skizzik in the ground-level hut at 69.8, 82.0. Loot Ishaal's Almanac and start its quest. Take it to Adaris, follow An Ally in Lower City to Rilak the Redeemed at 52.6, 20.8 in Shattrath, then return to Adaris with Countdown to Doom.",
        "Speak to Hazzik beside Adaris at 64.2, 66.8. Accept Hazzik's Bargain, retrieve his package from the ground-level hut in UPPER Veil Shil'ak around 74.8, 80.2, and return it. The similarly named lower village and tree platforms are not the package location.",
        "Accept A Shabby Disguise. Put on the supplied disguise and enter Sahaak's hut on the central island around 67.0, 79.6. Buy Adversarial Bloodlines for 3 gold and bring it to Hazzik to unlock Adversarial Blood.",
        "With Elixir of Shadows active, kill time-lost arakkoa until you have 40 Time-Lost Scrolls. Use a SMALL Skull Pile, such as the one around 69.6, 74.6. Spend 10 scrolls to summon each DIFFERENT descendant once: Darkscreecher Akkarai, Karrog, Gezzarak the Huntress and Vakkiz the Windrager. Loot the distinct token from each one.",
        "Bring the four different tokens to Hazzik. Complete Adversarial Blood for the first Time-Lost Offering; later use Tokens of the Descendants for further offerings. Accept Terokk's Downfall from Adaris, then use the LARGE Skull Pile on Terokk's Rest island at 66.2, 77.5 with an Offering in your bags to summon Terokk.",
        "Kill Terokk and turn in the quest. If he becomes immune, wait for the Skyguard's blue flare/fire and draw him into it to remove the shield. Repeat the four-descendant token exchange and Terokk summons; the large pile normally has about a 15-minute respawn, so collect more dust and scrolls between summons.",
        "Continue until Sha'tari Skyguard is Exalted. Arakkoa kills, Shadow Dust turn-ins and descendant exchanges all contribute. A simpler alternative is repeating More Shadow Dust: six dust gives 150 base reputation; 1,680 dust covers exactly Neutral to Exalted without bonuses or other gains. Dust is tradable, so you can buy only what your remaining reputation needs. You can use this alternative after step 2 instead of completing steps 3-8.",
        "Return to Grella at Blackwind Landing, 64.2, 66.2 in Terokkar Forest. Buy Nether Ray Fry (38628) for 32 gold at Exalted, then use the item and check the Pet Journal. The same Skyguard reputation also unlocks the five nether ray mount colors, sold separately.",
    },
    source = "Grella - Blackwind Landing; Sha'tari Skyguard Exalted",
    category = "Reputation", npcId = 23367,
    requirements = "Sha'tari Skyguard Exalted on the buyer; access to the Skettis plateau. Either faction.",
    cost = "32 gold at Exalted (40 gold base). Summoning-chain book: 3 gold; optional purchased reagents cost extra.",
    tips = "This is Sha'tari Skyguard reputation, not Draenor's Sha'tari Defense. The dust-only route avoids the summoning chain; the full farming route is listed for collectors who prefer to gather their own materials. Daily bombing/escort quests add reputation but are not required to repeat dust turn-ins.",
    waypoints = {
        pin(111, 64.0, 42.0, 1, "Yuula - Threat from Above and To Skettis!"),
        pin(108, 22.0, 12.0, 1, "Barrier Hills - kill 20 Gordunni ogres"),
        pin(108, 64.0, 66.8, 1, "Blackwind Landing - Adaris and Severin"),
        pin(108, 64.0, 66.8, 2, "Shadow Dust exchange - Elixir of Shadows"),
        pin(108, 70.0, 74.4, 3, "Talonpriest Zellek - up on the tree platform"),
        pin(108, 69.3, 78.5, 3, "Talonpriest Ishaal - Almanac for the unlock chain"),
        pin(108, 69.8, 82.0, 3, "Talonpriest Skizzik - ground-level hut"),
        pin(111, 52.6, 20.8, 3, "Rilak the Redeemed - translate Ishaal's Almanac"),
        pin(108, 64.2, 66.8, 4, "Hazzik - unlock quests and return the package"),
        pin(108, 74.8, 80.2, 4, "Upper Veil Shil'ak - package inside ground-level hut"),
        pin(108, 67.0, 79.6, 5, "Sahaak - buy the book while disguised"),
        pin(108, 69.6, 74.6, 6, "Small Skull Pile - summon four DIFFERENT descendants"),
        pin(108, 64.2, 66.8, 7, "Hazzik - exchange the four tokens for an Offering"),
        pin(108, 66.2, 77.5, 7, "Terokk's Rest - use the LARGE Skull Pile"),
        pin(108, 66.2, 77.5, 8, "Terokk - repeat summons between farming loops"),
        pin(108, 64.0, 66.8, 9, "Repeat Shadow Dust turn-ins until Exalted"),
        pin(108, 64.2, 66.2, 10, "Grella - buy Nether Ray Fry at Exalted"),
    },
})

-- Retail availability reviewed 2026-11-04. All 21 registered species retain
-- vendor, quest, fishing or drop sources. Mojo comes from the accessible
-- Heroic five-player Zul'Aman, despite removal of the original raid.
-- https://news.blizzard.com/en-us/article/23523203/burning-crusade-mounts-pets-and-more
-- https://www.warcraftpets.com/wow-pets/aquatic/frogs-and-toads/mojo/
-- https://www.warcraftpets.com/wow-pets/flying/fireflies/firefly/
local function rate(level, reason, speciesIDs)
    for _, speciesID in ipairs(speciesIDs) do
        local guide = guides[speciesID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end
rate("easy", "Buy the pet from its ordinary vendor; no reputation grind or random drop is needed.", {
    136,137,138,139,140,141,142,143,144,145,
})
rate("easy", "Complete Skywing's short escort quest for a guaranteed pet reward.", {149})
rate("hard", "Fish up the rare Mr. Pinchy and use his limited wishes; the desired pet is not guaranteed.", {132})
rate("hard", "The direct route is a very rare Bogflare Needler drop; buying a tradable pet can bypass the farm.", {146})
rate("medium", "Collect Amani Hex Sticks and repeatedly free the dungeon's frogs until Mojo appears.", {165})
rate("medium", "Reach Sporeggar Exalted with repeatable hibiscus turn-ins and gather the vendor's Glowcaps.", {167})
rate("medium", "Wait for Crocolisks in the City and repeat its fishing reward bag until this pet appears; a caged pet is an alternative.", {
    163,164,173,174,
})
rate("medium", "Farm Kael'thas for a random pet drop; Normal can be reset, and buying a tradable pet is an alternative.", {175})
rate("medium", "Complete the Skettis unlock and farm Sha'tari Skyguard Exalted before buying the pet.", {186})

-- Update both the list and its details while retaining unrelated existing
-- fields (including descriptions), species IDs, names and patch membership.
local fields = { "acquisition", "itemId", "npcId", "source", "tips", "requirements", "cost", "category", "waypoints", "faction", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^2%.") then
        for _, entry in ipairs(patch.pets) do
            local guide = guides[entry.speciesId]
            if guide then
                local original = TDP.PatchCatalog.petDetails[patchKey][entry.name] or {}
                local details = {}
                for key, value in pairs(original) do details[key] = value end
                for _, field in ipairs(fields) do
                    if guide[field] ~= nil then
                        entry[field], details[field] = guide[field], guide[field]
                    end
                end
                details.sourceType = guide.category
                TDP.PatchCatalog.petDetails[patchKey][entry.name] = details
            end
        end
    end
end
