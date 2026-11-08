-- Manually reviewed Retail cosmetic guides (2026-11-02).
-- Read all 790 parent comments on the 27 item pages. None contains a numbered,
-- profit-ending acquisition walkthrough; the sole profit mention is a resale
-- anecdote. These guides synthesize acquisition comments, expanded correction
-- threads and Retail quest, achievement, vendor and map records.
-- Source links retain the evidence, including replies superseding old prices,
-- currencies, vendor positions and account restrictions. No historical pins
-- are presented as current acquisition routes for retired arena tabards.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.cosmetics = TDP.CollectionWalkthroughs.cosmetics or {}
local guides = TDP.CollectionWalkthroughs.cosmetics
local function rate(level, reason, itemIDs)
    for _, itemID in ipairs(itemIDs) do
        local guide = guides[itemID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(itemID, name, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.category = guide.category or "Achievements"
    guide.sourceType = guide.category
    guide.waypoints = guide.waypoints or {}
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end

-- Each city's complete item discussion was reviewed separately. Current sold-by
-- tables confirm silver prices; the old 50-seal tournament acquisition is stale.
-- https://www.wowhead.com/item=45574#comments:id=5581888
-- https://www.wowhead.com/item=45577#comments:id=6363049 and reply 1845225
-- https://www.wowhead.com/item=45578#comments:id=925099
-- https://www.wowhead.com/item=45579#comments:id=6285739 and reply 1850555
-- https://www.wowhead.com/npc=216286#comments:id=5766902 and all replies
-- https://www.wowhead.com/npc=216286#comments:id=6284946
-- https://www.wowhead.com/item=45580#comments:id=1179818 and both replies
-- https://www.wowhead.com/item=45581#comments:id=1866202 and reply 1205970
-- https://www.wowhead.com/item=45582#comments:id=5352865
-- https://www.wowhead.com/npc=50304#comments:id=5730828
-- https://www.wowhead.com/npc=50304#comments:id=5969793 and all replies
-- https://www.wowhead.com/npc=50304#comments:id=6322636
-- https://www.wowhead.com/item=45584#comments:id=5538733
-- https://www.wowhead.com/item=45585#comments:id=2867152 and reply 1219713
-- https://www.wowhead.com/npc=240940/magistrix-nizara (Midnight vendor)
local cityTabards = {
    {
        id = 45574, name = "Stormwind Tabard", faction = "Alliance", reputation = "Stormwind",
        npc = 49877, vendor = "Captain Lancy Revshon", map = 84, mapName = "Stormwind City", x = 67.6, y = 72.8,
        route = "Go to Captain Lancy Revshon in Stormwind's Trade District (67.6, 72.8). She stands at the bottom of the ramp leading to the gryphon flight master, not inside the Visitor's Center.",
        detail = "Choose Stormwind Tabard (45574). The later Stormwind Tabard from the Warlords garrison is a different item; buying garrison armor is unnecessary.",
    },
    {
        id = 45577, name = "Ironforge Tabard", faction = "Alliance", reputation = "Ironforge",
        npc = 50309, vendor = "Captain Stonehelm", map = 87, mapName = "Ironforge", x = 55.6, y = 47.8,
        route = "Go to Captain Stonehelm in Ironforge's Great Forge (55.6, 47.8), beside the central gryphon flight master. The Gnomeregan quartermaster stands next to him, so check the vendor name before buying.",
        detail = "Buy Ironforge Tabard (45577) from Stonehelm. Dwarf facial hair can hide the emblem visually; inspect the Wardrobe to confirm the appearance instead of assuming you bought the wrong item.",
    },
    {
        id = 45578, name = "Gnomeregan Tabard", faction = "Alliance", reputation = "Gnomeregan",
        npc = 50308, vendor = "Master Tinker Trini", map = 87, mapName = "Ironforge", x = 55.6, y = 47.8,
        route = "Go to Master Tinker Trini in Ironforge's Great Forge (55.6, 47.8), beside the gryphon flight master and Captain Stonehelm. The seller is in Ironforge, not inside the Gnomeregan dungeon.",
        detail = "Choose Gnomeregan Tabard (45578), not Stonehelm's Ironforge tabard. Equip the purchased item: simply previewing it on the vendor does not collect it or advance a tabard-collection achievement.",
    },
    {
        id = 45579, name = "Darnassus Tabard", faction = "Alliance", reputation = "Darnassus",
        npc = 216286, vendor = "Moon Priestess Lasara", map = 2239, mapName = "Amirdrassil", x = 46.5, y = 70.6,
        route = "Visit Moon Priestess Lasara beside the flight point in Bel'ameth, Amirdrassil (46.5, 70.6). Use the physical Amirdrassil zone in the Dragon Isles, not the Amirdrassil raid or the Emerald Dream map. This vendor has moved from Stormwind's Embassy to Bel'ameth.",
        detail = "Choose Darnassus Tabard (45579), the older purple city tabard. Darnassian Tabard (210424), also sold by Lasara, is a separate newer appearance with a different currency price. If your phase prevents reaching Lasara, an already eligible Darnassus Champion/Exalted character can check Rook Hawkfist in the Argent Tournament's Alliance pavilion (76.2, 19.2 in Icecrown); his tournament unlock still applies.",
        extraPins = { pin(118, 76.2, 19.2, 4, "Rook Hawkfist - alternative only with his tournament unlock", "Icecrown") },
    },
    {
        id = 45580, name = "Exodar Tabard", faction = "Alliance", reputation = "Exodar",
        npc = 50306, vendor = "Kadu", map = 103, mapName = "The Exodar", x = 54.6, y = 36.8,
        route = "Enter the Exodar and find Kadu beside the indoor flight master (54.6, 36.8 on The Exodar map). Old comments directing you to the former outdoor flight point were corrected in their replies.",
        detail = "Choose Exodar Tabard (45580). You can buy it on an eligible Alliance character without being Draenei; Tabard of the Hand is a different, race-specific quest reward.",
    },
    {
        id = 45581, name = "Orgrimmar Tabard", faction = "Horde", reputation = "Orgrimmar",
        npc = 50488, vendor = "Stone Guard Nargol", map = 85, mapName = "Orgrimmar", x = 50.4, y = 58.4,
        route = "Find Stone Guard Nargol on the upper flight-master platform above Orgrimmar's Valley of Strength (50.4, 58.4). Fly up or take the nearby elevator; the pin is above the street, not inside Grommash Hold.",
        detail = "Choose Orgrimmar Tabard (45581). If other vendor armor is red, check the tabard itself: comments confirm that it can still be purchasable. Any eligible Horde race can buy it.",
    },
    {
        id = 45582, name = "Darkspear Tabard", faction = "Horde", reputation = "Darkspear Trolls",
        npc = 50477, vendor = "Champion Uru'zin", map = 85, mapName = "Orgrimmar", x = 49.9, y = 58.1,
        route = "Find Champion Uru'zin on Orgrimmar's upper flight-master platform above the Valley of Strength (49.9, 58.1), beside the other city quartermasters. Use the elevator or fly up; you do not need to travel to the Echo Isles or Sen'jin Village.",
        detail = "Choose Darkspear Tabard (45582). Old posts call the tournament version Sen'jin Tabard; the current item name and reputation are Darkspear. You do not need to be a Troll.",
    },
    {
        id = 45583, name = "Undercity Tabard", faction = "Horde", reputation = "Undercity",
        npc = 50304, vendor = "Captain Donald Adams", map = 85, mapName = "Orgrimmar", x = 56.6, y = 90.2,
        route = "Find Captain Donald Adams on top of Orgrimmar's main-gate ramparts (56.6, 90.2). Without flight, take the elevator at 50.6, 63.6, then follow the upper path southeast through 54.1, 68.4 and 58.6, 85.1 to the gate. This is a different platform from Nargol and Uru'zin.",
        detail = "Choose Undercity Tabard (45583). If Adams is phased out, check the Shadowlands: A Chilling Summons introduction in front of Grommash Hold; recent comments report that accepting/progressing it restores these rampart vendors. Alternatively, an already eligible tournament character can buy from Eliza Killian in Icecrown's Horde pavilion. Do not enter blighted Undercity expecting an ordinary live vendor.",
        extraPins = {
            pin(85, 50.6, 63.6, 2, "Valley of Strength elevator - reach the ramparts", "Orgrimmar"),
            pin(85, 54.1, 68.4, 2, "Upper path toward the main gate", "Orgrimmar"),
            pin(85, 58.6, 85.1, 2, "Rampart approach to Captain Donald Adams", "Orgrimmar"),
            pin(118, 76.4, 24.0, 4, "Eliza Killian - alternative with her tournament unlock", "Icecrown"),
        },
    },
    {
        id = 45584, name = "Thunder Bluff Tabard", faction = "Horde", reputation = "Thunder Bluff",
        npc = 50483, vendor = "Brave Tuho", map = 88, mapName = "Thunder Bluff", x = 46.8, y = 50.0,
        route = "Go to Brave Tuho at Thunder Bluff's central flight-master tower (46.8, 50.0), on the elevated flight platform. He is the city quartermaster, not the tabard designer or the mount vendor on another rise.",
        detail = "Choose Thunder Bluff Tabard (45584). The city vendor is the useful starting point for a new collector; the tournament vendor's championship restriction does not mean Tuho requires Exalted.",
    },
    {
        id = 45585, name = "Silvermoon City Tabard", faction = "Horde", reputation = "Silvermoon City",
        npc = 240940, vendor = "Magistrix Nizara", map = 2393, mapName = "Silvermoon City (Midnight)", x = 69.0, y = 67.5,
        route = "In present-day Midnight Silvermoon, visit Magistrix Nizara (69.0, 67.5 on the Silvermoon City map). Find her in the Horde section of the current city; use the Midnight city map in the dropdown.",
        detail = "Choose Silvermoon City Tabard (45585). If this character cannot access the current Silvermoon phase, an already eligible tournament character can check Trellis Morningsun in Icecrown's Horde pavilion (76.2, 23.8). His tournament unlock is separate from Nizara's direct silver purchase.",
        extraPins = { pin(118, 76.2, 23.8, 4, "Trellis Morningsun - alternative with his tournament unlock", "Icecrown") },
    },
}

for _, city in ipairs(cityTabards) do
    local points = { pin(city.map, city.x, city.y, 2, city.vendor .. " - buy " .. city.name, city.mapName) }
    for _, point in ipairs(city.extraPins or {}) do points[#points + 1] = point end
    points[#points + 1] = pin(109, 71.7, 54.9, 5, "The Botanica - optional city reputation, not required to buy", "Netherstorm")
    add(city.id, city.name, {
        category = "Vendor", faction = city.faction:lower(), npcId = city.npc,
        source = city.vendor .. " - " .. city.mapName,
        description = city.reputation .. " city tabard; direct silver purchase in Retail.",
        requirements = city.faction .. "; the direct city purchase does not require a tournament championship or Exalted.",
        cost = "10 silver base, reduced by applicable reputation discounts. No Champion's Seals for this item.",
        effect = "The physical tabard grants " .. city.reputation .. " reputation in eligible dungeons. Transmog alone does not.",
        tips = "Buy the appearance first; reputation farming is optional. Old 50-seal prices, guild-tabard display bugs and dungeon exclusions were changed. Check the named reputation after initial kills instead of trusting an old universal dungeon list.",
        steps = {
            "Use an eligible " .. city.faction .. " character and bring 10 silver. You do not need the city's race, Exalted or an Argent Tournament championship for the direct purchase. Check your appearances first if you may already own it.",
            city.route,
            "Open the quartermaster's shop, find " .. city.name .. " and buy it for up to 10 silver. Browse all pages and choose the All item filter if hidden. Equip it and confirm the appearance is learned; the cosmetic acquisition is complete at this point.",
            city.detail,
            "Optional reputation: equip the physical tabard and enter The Botanica, the northern satellite dungeon of Tempest Keep in Netherstorm (71.7, 54.9), on NORMAL. On a character able to solo it, clear the enemies and bosses, checking that " .. city.reputation .. " actually increases. Use the exit behind Warp Splinter at the end.",
            "If you also want Exalted, reset outside and repeat Normal Botanica until the reputation goal is met, pausing at the hourly instance limit. Keep the real tabard equipped. The appearance alone does not champion a faction, and the reputation grind is not a prerequisite for purchasing this tabard.",
        },
        waypoints = points,
    })
end

-- https://www.wowhead.com/item=46817#comments:id=760763
-- https://www.wowhead.com/item=46817#comments:id=2588590 and reply
-- https://www.wowhead.com/item=46817#comments:id=3365537
-- https://www.wowhead.com/item=46818#comments:id=857178
-- https://www.wowhead.com/item=46818#comments:id=2588589
-- https://www.wowhead.com/faction=1094#comments:id=689636 and replies
-- https://www.wowhead.com/faction=1094#comments:id=3309931
-- https://www.wowhead.com/faction=1094#comments:id=6267858
-- https://www.wowhead.com/faction=1124#comments:id=689695
-- https://www.wowhead.com/faction=1124#comments:id=1783234 and replies
for _, faction in ipairs({
    { id = 46817, name = "Silver Covenant Tabard", side = "Alliance", reputation = "The Silver Covenant", vendor = "Hiren Loresong", npc = 34881, y = 19.6, representative = "Arcanist Taelis", trainingY = 19.4 },
    { id = 46818, name = "Sunreaver Tabard", side = "Horde", reputation = "The Sunreavers", vendor = "Vasarin Redmorn", npc = 34772, y = 24.0, representative = "Magister Edien Sunhollow", trainingY = 24.2 },
}) do
    add(faction.id, faction.name, {
        category = "Reputation", faction = faction.side:lower(), npcId = faction.npc,
        source = faction.vendor .. " - Argent Tournament, " .. faction.reputation .. " Exalted",
        description = faction.reputation .. "'s tournament faction tabard.",
        requirements = faction.side .. "; " .. faction.reputation .. " Exalted and access to the faction quartermaster.",
        cost = "50 Champion's Seals (currency 241). Aspirant's and Valiant's Seals cannot buy it.",
        effect = "Cosmetic appearance; this tabard does not champion its own faction in dungeons.",
        tips = "The buyer needs the reputation, but later Retail comments confirm that alts can transmog the learned appearance without repeating the grind. Check the opposite faction's counterpart appearance before buying twice. Neither tabard is refundable for its seals.",
        steps = {
            "On an eligible " .. faction.side .. " character, check " .. faction.reputation .. " reputation and whether " .. faction.vendor .. " will sell to you. If already unlocked and Exalted, skip the training and reputation stages, then collect the 50 purchase seals.",
            "If new to the tournament, speak to Justicar Mariel Trueheart in Icecrown (69.6, 22.8), then " .. faction.representative .. " in your faction pavilion (76.2, " .. faction.trainingY .. "). Complete the lance and mounted-combat lessons. For jousts, equip the lance, use a tournament mount, refresh Defend, strip enemy shields with Shield-Breaker and Charge when there is room.",
            "Finish Up to the Challenge: collect 15 Aspirant's Seals from the pavilion's training dailies, normally five per day, then complete The Aspirant's Challenge. Advance a city's A Valiant's Charge with 25 Valiant's Seals, complete The Valiant's Challenge and A Champion Rises. These training seals unlock progression; keep them separate from Champion's Seals.",
            "Raise " .. faction.reputation .. " to Exalted through the pavilion's available Valiant and Champion quests. Combine the rotating weapon errand with field training, The Grand Melee/Among the Champions and At the Enemy's Gates/Battle Before the Citadel when offered. Completing further city championships advances this reputation while working toward Crusader. Check this exact faction's bar, not the city or Argent Crusade bar.",
            "Optional dungeon reputation: remove ALL reputation-championing tabards and clear original Wrath heroics, such as Halls of Lightning in the Storm Peaks (45.4, 21.4). Check " .. faction.reputation .. " directly before and after: chat can emphasize Alliance Vanguard/Horde Expedition or another subfaction while this reputation also rises. Wearing an unrelated reputation tabard diverts those gains.",
            "Save 50 Champion's Seals from unlocked Champion dailies and their purses. The Black Knight investigation through The Black Knight's Fall unlocks Threat From Above. For additional seals, do the daily Heroic Trial of the Champion clear at the five-player Coliseum entrance (75.1, 21.8 in Icecrown). This is not the Trial of the Crusader raid entrance.",
            "At Exalted, visit " .. faction.vendor .. " inside the " .. faction.side .. " pavilion (76.2, " .. faction.y .. " in Icecrown). Buy " .. faction.name .. " for 50 Champion's Seals. Check that you do not already own it: buying another copy is possible and wastes seals.",
            "Equip the tabard and confirm the Wardrobe appearance. Keep the purchase; the item cannot be returned for a seal refund and ordinary tabard designers do not provide a free replacement for a discarded tournament purchase.",
        },
        waypoints = {
            pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
            pin(118, 76.2, faction.trainingY, 2, faction.representative .. " - mounted training", "Icecrown"),
            pin(118, 76.2, faction.trainingY, 3, "Pavilion - Aspirant and Valiant progression", "Icecrown"),
            pin(118, 76.2, faction.y, 4, faction.reputation .. " - reputation quest hub", "Icecrown"),
            pin(120, 45.4, 21.4, 5, "Halls of Lightning - optional reputation WITHOUT championing tabards", "The Storm Peaks"),
            pin(118, 75.1, 21.8, 6, "Trial of the Champion - daily Heroic seals", "Icecrown"),
            pin(118, 76.2, faction.y, 7, faction.vendor .. " - Exalted tabard purchase", "Icecrown"),
        },
    })
end

-- https://www.wowhead.com/item=46874#comments:id=795186 and all replies
-- https://www.wowhead.com/item=46874#comments:id=2265396 and reply
-- https://www.wowhead.com/item=46874#comments:id=2562493 and all replies
-- https://www.wowhead.com/npc=34885#comments:id=787205 and replies
-- https://www.wowhead.com/npc=34885#comments:id=1934029 and replies
-- https://www.wowhead.com/npc=34885#comments:id=5763770 and reply
add(46874, "Argent Crusader's Tabard", {
    category = "Reputation", npcId = 34885,
    source = "Dame Evniki Kapsalis - Crusader's Quartermaster, Argent Tournament",
    description = "Crusader reward with a permanent teleport to the Argent Tournament Grounds.",
    requirements = "Crusader unlock from Exalted Argent Champion of the Alliance (2817) or Horde (2816). Either faction and any class.",
    cost = "50 Champion's Seals. An existing account Crusader unlock can open the shop for eligible alts.",
    effect = "The equipped physical tabard teleports you to the Argent Tournament's Argent pavilion; 30-minute cooldown. Transmog grants only the appearance.",
    tips = "Argent Crusade Exalted alone is insufficient. Keep the physical tabard for its teleport: ordinary tabard designers do not replace this purchase for free. The similarly named Tabard of the Argent Crusade is the separate Friendly reputation tabard.",
    steps = {
        "First check Dame Evniki Kapsalis inside the Argent pavilion in Icecrown (69.5, 23.2). If your account already earned Crusader, inspect her inventory on this character before repeating all five championships. If accessible, go straight to earning the 50 seals in step 6.",
        "Without a Crusader unlock, begin at Justicar Mariel Trueheart (69.6, 22.8). Complete mounted lessons, collect 15 Aspirant's Seals for Up to the Challenge, then win The Aspirant's Challenge. Advance your first city's 25-Valiant's-Seal charge, win The Valiant's Challenge and finish A Champion Rises.",
        "Champion all FIVE original cities of your faction, one city at a time. Alliance: Stormwind, Ironforge, Gnomeregan, Darnassus and Exodar. Horde: Orgrimmar, Sen'jin/Darkspear, Undercity, Thunder Bluff and Silvermoon. Each additional city's charge needs 25 Valiant's Seals and its challenge. Continue Champion dailies alongside the current city's training.",
        "Reach Exalted with those same five city reputations. City quests and Champion's Writ hand-ins help; for a repeatable dungeon route, equip the appropriate city tabard and clear Normal Botanica in Netherstorm (71.7, 54.9), exit behind the last boss, reset and repeat. Change the actual tabard when changing the city reputation being farmed.",
        "Also reach Argent Crusade Exalted. Buy its separate Friendly tabard from Aliocha Segard at the Argent Vanguard (87.6, 75.6 in Icecrown), equip it and run eligible Wrath heroics such as Halls of Lightning (45.4, 21.4 in the Storm Peaks). Check 2817/2816 for all city championships, city Exalted achievements and Argent Crusade Exalted. This awards Crusader; the unrelated Argent Champion title does not.",
        "Earn and save 50 Champion's Seals on the purchasing character. Do its unlocked Champion dailies, open their purses and complete the Black Knight investigation for Threat From Above. Daily Heroic Trial of the Champion at 75.1, 21.8 adds seals. Aspirant's and Valiant's Seals are not purchase currency.",
        "Return to Dame Evniki Kapsalis (69.5, 23.2) and buy Argent Crusader's Tabard for 50 Champion's Seals. Browse all pages if necessary; the tabard is available to non-Paladins too.",
        "Equip the physical tabard and use it to teleport to the Argent pavilion. You can transmog its appearance, but keep the real item for the teleport. It brings you to the tournament in northern Icecrown, not Dalaran or the Argent Vanguard.",
    },
    waypoints = {
        pin(118, 69.5, 23.2, 1, "Dame Evniki Kapsalis - check an existing Crusader unlock", "Icecrown"),
        pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - begin tournament training", "Icecrown"),
        pin(118, 76.2, 19.4, 3, "Alliance pavilion - five city championships", "Icecrown"),
        pin(118, 76.2, 24.2, 3, "Horde pavilion - five city championships", "Icecrown"),
        pin(109, 71.7, 54.9, 4, "The Botanica - optional city-tabard reputation", "Netherstorm"),
        pin(118, 87.6, 75.6, 5, "Aliocha Segard - separate Argent Crusade reputation tabard", "Icecrown"),
        pin(120, 45.4, 21.4, 5, "Halls of Lightning - Argent Crusade Heroic reputation", "The Storm Peaks"),
        pin(118, 75.1, 21.8, 6, "Trial of the Champion - daily Heroic seals", "Icecrown"),
        pin(118, 69.5, 23.2, 7, "Dame Evniki Kapsalis - buy the teleport tabard", "Icecrown"),
        pin(118, 69.4, 22.6, 8, "Argent pavilion - tabard teleport destination", "Icecrown"),
    },
})

-- Retail audit, 2026-11-04: original Season 6/7/8 tabards have been removed
-- from the catalogue and guides; current Arena rating does not unlock them.
-- https://warcraft.wiki.gg/wiki/Tabard#Arena_tabards

-- https://www.wowhead.com/item=49052#comments:id=900738 and reply 823167
-- https://www.wowhead.com/item=49052#comments:id=1890392
-- https://www.wowhead.com/item=49054#comments:id=900736 and reply 823166
-- https://www.wowhead.com/item=49054#comments:id=1912257 and both replies
-- https://www.wowhead.com/item=49054#comments:id=2107308
-- Retail meta/criteria: 3857, 3957, 3777, 3847-3856.
-- https://www.wowhead.com/achievement=3852#comments:id=5836906
-- https://www.wowhead.com/achievement=3850#comments:id=6413720
-- Approximate objective-area centers read from the Retail terrain map:
-- https://wow.zamimg.com/images/wow/maps/enus/original/4710.jpg
-- UI map 169 is confirmed by the existing catalogue's battleground area data.
for _, conquest in ipairs({
    { 49052, "Alliance", 3857 },
    { 49054, "Horde", 3957 },
}) do
    local id, faction, achievement = conquest[1], conquest[2], conquest[3]
    add(id, "Tabard of Conquest", {
        category = "PvP", faction = faction:lower(), sourceAchievementId = achievement,
        source = "Master of Isle of Conquest (" .. achievement .. ") - " .. faction .. " reward",
        description = faction .. " version of the Isle of Conquest battleground meta's tabard.",
        requirements = "Complete the current faction version of Master of Isle of Conquest and all its listed subachievements.",
        cost = "Achievement reward; no purchase with Honor or Conquest currency.",
        effect = "Cosmetic faction appearance; no battleground combat bonus.",
        tips = "Queue through PvP; there is no outdoor entrance to travel to. Battleground pins mark approximate objective areas. Counters can require several games, but both five-bomb objectives and All Over the Isle must each be completed within one battle. Old no-replacement comments were corrected in their replies.",
        steps = {
            "Track Master of Isle of Conquest (" .. achievement .. ") on an eligible " .. faction .. " character. Expand its missing subachievements. Queue for Isle of Conquest through PvP, or use Random Epic Battlegrounds. Work on the objectives below during matches while building the win total.",
            "Isle of Conquest Veteran: win 100 games. Keep this counter running while doing the specialized criteria. Losses can advance many other objectives, but they do not add victories.",
            "Four Car Garage: personally control a Glaive Thrower and Catapult from the Docks, plus a Demolisher and Siege Engine from the Workshop. Enter the appropriate controlling seat and verify each criterion; sitting only in a passenger or gunner seat may not give the required control credit.",
            "Back Door Job: enter the ENEMY courtyard while its gates are still intact. Use a Docks catapult to launch over the wall, or the Hangar's gunship to parachute in. Do this before your team breaks a gate; walking through an already destroyed gate does not meet the condition.",
            "A-bomb-inable and A-bomb-ination: in one battle, use 5 ordinary Seaforium Bombs on enemy gates; separately, in one battle, use 5 HUGE Seaforium Bombs. Ordinary bombs come from the Workshop; huge bombs are inside the enemy courtyard. Pick up the correct type, carry it to an intact enemy gate, plant it and let it detonate. Refill and repeat, watching each separate counter. A disarmed bomb may not give the required damage credit.",
            "Cut the Blue Wire... No the Red Wire!: disarm 25 enemy bombs, accumulated across games. Defend your own gates, watch for a planted explosive, then interact and finish the disarm before it explodes. Crowd-control attackers or ask teammates to cover you; damage or movement can interrupt the cast. Stay for defensive opportunities even in a losing game.",
            "Mowed Down: while using a keep turret, collect 100 player kills and destroy 10 vehicles. Player honorable-kill credit can count, but recent replies stress that vehicles require the turret's finishing damage. Watch the vehicle counter after each destruction instead of assuming a nearby teammate's kill counted.",
            "Demolition Derby: destroy an enemy Glaive Thrower, Catapult, Demolisher and Siege Engine. Hunt Docks and Workshop vehicles, participate directly in their destruction and verify all four checkmarks. These are destruction objectives, separate from controlling your own team's vehicles.",
            "Glaive Grave: use a Glaive Thrower to kill 10 players without dying. Keep the vehicle protected and aim at enemy players instead of only gates. Ask teammates for cover and repairs; a fast vehicle loss can ruin the attempt before the required streak.",
            "All Over the Isle: in a SINGLE battle, obtain player-kill credit at the Workshop, Docks, Hangar, Alliance Keep and Horde Keep. Check each location during the same match and travel to missing sites before it ends. Kills split across separate battles do not finish this criterion.",
            "Mine: win while your team simultaneously CONTROLS the Quarry, Refinery, Docks/Shipyard, Workshop and Hangar. An assaulted flag is not a fully controlled node. Coordinate the last captures and protect all five until the winning moment; merely capturing each once during the match is insufficient.",
            "When every required subachievement completes, collect the mailed Tabard of Conquest. If mail is delayed, or an alt needs its faction copy, speak to Elizabeth Ross in Northrend Dalaran (51.6, 55.4) and choose the lost-Tabard-of-Conquest dialogue. Later replies explicitly correct the old claim that it cannot be reclaimed.",
            "Equip the tabard and check the learned appearance. Its Alliance and Horde looks differ; a Conquest currency purchase or the ordinary Orgrimmar/Stormwind tabard is not this reward.",
        },
        waypoints = {
            pin(169, 30.7, 50.9, 3, "Docks area - Glaive Throwers and Catapults", "Isle of Conquest"),
            pin(169, 53.4, 53.3, 3, "Workshop area - Demolishers and Siege Engine", "Isle of Conquest"),
            pin(169, 64.9, 54.6, 4, "Hangar area - gunship access", "Isle of Conquest"),
            pin(169, 53.4, 53.3, 5, "Workshop area - ordinary Seaforium Bombs", "Isle of Conquest"),
            pin(169, 48.5, 25.0, 5, "Horde Keep area - courtyard bombs and gate objectives", "Isle of Conquest"),
            pin(169, 51.0, 77.8, 5, "Alliance Keep area - courtyard bombs and gate objectives", "Isle of Conquest"),
            pin(169, 48.5, 25.0, 6, "Horde Keep - defend gates and disarm enemy bombs", "Isle of Conquest"),
            pin(169, 51.0, 77.8, 6, "Alliance Keep - defend gates and disarm enemy bombs", "Isle of Conquest"),
            pin(169, 48.5, 25.0, 7, "Horde Keep area - defensive turrets", "Isle of Conquest"),
            pin(169, 51.0, 77.8, 7, "Alliance Keep area - defensive turrets", "Isle of Conquest"),
            pin(169, 30.7, 50.9, 8, "Docks area - vehicle destruction objectives", "Isle of Conquest"),
            pin(169, 53.4, 53.3, 8, "Workshop area - vehicle destruction objectives", "Isle of Conquest"),
            pin(169, 30.7, 50.9, 9, "Docks area - Glaive Grave attempt", "Isle of Conquest"),
            pin(169, 53.4, 53.3, 10, "Workshop - same-battle kill location", "Isle of Conquest"),
            pin(169, 30.7, 50.9, 10, "Docks - same-battle kill location", "Isle of Conquest"),
            pin(169, 64.9, 54.6, 10, "Hangar - same-battle kill location", "Isle of Conquest"),
            pin(169, 51.0, 77.8, 10, "Alliance Keep - same-battle kill location", "Isle of Conquest"),
            pin(169, 48.5, 25.0, 10, "Horde Keep - same-battle kill location", "Isle of Conquest"),
            pin(169, 28.3, 72.8, 11, "Quarry area - control at victory for Mine", "Isle of Conquest"),
            pin(169, 35.5, 22.5, 11, "Refinery area - control at victory for Mine", "Isle of Conquest"),
            pin(169, 30.7, 50.9, 11, "Docks - control at victory for Mine", "Isle of Conquest"),
            pin(169, 53.4, 53.3, 11, "Workshop - control at victory for Mine", "Isle of Conquest"),
            pin(169, 64.9, 54.6, 11, "Hangar - control at victory for Mine", "Isle of Conquest"),
            pin(125, 51.6, 55.4, 12, "Elizabeth Ross - earned-tabard recovery", "Dalaran (Northrend)"),
        },
    })
end

-- https://www.wowhead.com/item=52252#comments:id=1017874 and all replies
-- https://www.wowhead.com/item=52252#comments:id=1024370 and reply
-- https://www.wowhead.com/item=52252#comments:id=2341090 and all replies
-- https://www.wowhead.com/item=52252#comments:id=3209104
-- https://www.wowhead.com/item=52252#comments:id=5763037 and reply
-- https://www.wowhead.com/quest=24919#comments:id=1664472
-- https://www.wowhead.com/quest=24919#comments:id=2139638 and reply
-- https://www.wowhead.com/quest=24547#comments:id=6218544
-- https://www.wowhead.com/quest=24749#comments:id=6282050
-- https://www.wowhead.com/quest=24749#comments:id=6406767
-- https://www.wowhead.com/quest=24756#comments:id=6051266 and replies
-- https://www.wowhead.com/quest=24757#comments:id=6051269 and reply
-- https://www.wowhead.com/quest=24548/the-splintered-throne
-- https://www.wowhead.com/quest=24914/personal-property
-- Boss coordinates: Retail NPCs 36626, 36627, 36678, 37955, 36853, 36597.
-- Floor IDs verified from https://wago.tools/db2/UiMapGroupMember/csv :
-- group 181 floors 1/4/5/6/7 are maps 186/189/190/191/192 respectively.
add(52252, "Tabard of the Lightbringer", {
    category = "Quest Rewards", npcId = 38608,
    source = "The Lightbringer's Redemption - Shadowmourne chest, or traded finished tabard",
    description = "Silver Hand tabard with a cosmetic light effect on use.",
    requirements = "Any eligible wearer can use a traded tabard. The direct Shadowmourne chain requires a Warrior, Paladin or Death Knight.",
    cost = "Auction House/player-trade price varies. Quest route: 25 Primordial Saronite, raid materials, infusions and 50 Shadowfrost Shards over weekly lockouts.",
    effect = "The equipped physical tabard grants a cosmetic glow for 5 minutes, with a 30-minute cooldown. Transmog alone does not grant the use effect; the current glow differs from old pre-Warlords screenshots.",
    tips = "The chest is once per completed Shadowmourne chain, not a weekly Lich King drop. The finished tabard binds when equipped. It is Unique: owning a copy in bags, equipment or bank can block the reward quest. Keep an existing bound copy; ordinary tabard vendors do not reliably restore a discarded one.",
    steps = {
        "Choose the purchase or quest route. You can buy the actual Tabard of the Lightbringer (52252) on the Auction House or trade for it, then equip it directly; the buyer does not need Shadowmourne or a plate class. Compare the actual item rather than paying for an unrelated tabard or a promised chest drop. If purchasing, skip to step 14.",
        "For the quest route, use a Warrior, Paladin or Death Knight. Set Icecrown Citadel to 25-player and enter at 53.7, 87.0 in Icecrown. Kill entrance trash until Friendly with the Ashen Verdict, then accept The Sacred and the Corrupt from Highlord Darion Mograine on the left inside the entrance (42.6, 22.6 on The Lower Citadel map). Enable Trivial Quests if needed.",
        "With that quest active, go to Frostmourne Cavern in northeastern Dragonblight (74.4, 23.5). Interact with Light's Vengeance, wait through the Lich King's scene, use the hammer again as prompted and defeat the resurrected enemy. Collect the quest credit/item before leaving.",
        "Gather 25 Primordial Saronite and loot Rotface's Acidic Blood and Festergut's Acidic Blood from their 25-player kills. Return these and Light's Vengeance to Mograine's runeforge. Finish the forging turn-ins to receive Shadow's Edge.",
        "For A Feast of Souls, equip Shadow's Edge and collect 50 souls from Icecrown enemies. Apply Shadow's Fate BEFORE killing each target. At high level, use controlled or non-damaging abilities and watch the counter: Death Knights can apply it with Chains of Ice. Remove damage procs if enemies die before the debuff lands.",
        "Unholy Infusion: keep Shadow's Edge equipped and fight 25-player Professor Putricide. Bring a helper to hold his attention while you use the laboratory table to become an abomination. Let several slime pools form first; use Eat Ooze to absorb them until you have 100 energy, then cast Shadow Infusion. Once the infusion finishes and its buff is present, leave the vehicle and kill Putricide. Avoid procs or auto-attacks that kill him before the setup.",
        "Blood Infusion: bring three helpers to 25-player Blood-Queen Lana'thel and keep Shadow's Edge equipped. Stand beside the tank for Blood Mirror and arrange the initial vampire bite on the quest character. Personally bite three other players as Frenzied Bloodthirst enables Vampiric Bite. Coordinate helpers' own feeding, deaths or resurrection so your targets remain usable. Count all three personal bites before killing Lana'thel; quest credit is awarded after her death.",
        "Frost Infusion: with Shadow's Edge still equipped, face 25-player Sindragosa and survive FOUR Frost Breaths without dying. Hold damage, heal if necessary and remove retaliation/damage procs so she survives. After the frost infusion is applied, kill her and return to Mograine.",
        "Accept The Splintered Throne and collect 50 Shadowfrost Shards from eligible 25-player boss kills. This takes weekly lockouts; shards are not guaranteed from every boss. A second run on the same saved bosses or switching raid size does not supply another weekly set of drops.",
        "Finish forging Shadowmourne and accept The Lich King's Last Stand. With the completed legendary equipped and the relevant quest stage active, defeat the Lich King in 25-player Icecrown Citadel. Wait through the scripted death/resurrection and the final kill.",
        "Loot the Sealed Chest from that eligible kill BEFORE leaving or completing the remaining turn-ins. A random Lich King kill, or a repeat with an already completed legendary chain, does not create another chest.",
        "Return to Darion inside the entrance hall in that cleared raid. Complete Personal Property (24914) with the Sealed Chest, receive the Unsealed Chest and open it. Take the Badge of the Silver Hand from its contents.",
        "Speak to Uther the Lightbringer among the reward NPCs in the entrance hall of the instance where the Lich King has been defeated. Complete The Lightbringer's Redemption (24919) with the Badge for the tabard. Wait for each reward NPC's dialogue scene to finish before another turn-in. A fresh uncleared instance does not provide this reward scene.",
        "Equip the finished tabard to use its glow, or retain it unbound if intentionally trading it. A learned appearance can be transmogged on eligible alts, but the use effect requires the physical item. Keep it if you want the effect; transmogging another tabard to this appearance does not grant the glow.",
    },
    waypoints = {
        pin(118, 53.7, 87.0, 2, "Icecrown Citadel - 25-player quest-route entrance", "Icecrown"),
        pin(186, 42.6, 22.6, 2, "Darion Mograine - Friendly Ashen Verdict quest start", "Icecrown Citadel: The Lower Citadel"),
        pin(115, 74.4, 23.5, 3, "Frostmourne Cavern - Light's Vengeance", "Dragonblight"),
        pin(190, 19.8, 41.9, 4, "Rotface - Acidic Blood on 25-player", "Icecrown Citadel: The Upper Reaches"),
        pin(190, 19.8, 65.4, 4, "Festergut - Acidic Blood on 25-player", "Icecrown Citadel: The Upper Reaches"),
        pin(186, 42.6, 22.6, 4, "Darion and runeforge - Shadow's Edge", "Icecrown Citadel: The Lower Citadel"),
        pin(190, 13.3, 53.5, 6, "Professor Putricide - Unholy Infusion", "Icecrown Citadel: The Upper Reaches"),
        pin(191, 51.1, 43.8, 7, "Blood-Queen Lana'thel - three personal bites", "Icecrown Citadel: Royal Quarters"),
        pin(189, 36.6, 23.4, 8, "Sindragosa - four Frost Breaths", "Icecrown Citadel: The Frost Queen's Lair"),
        pin(192, 49.9, 52.8, 10, "The Lich King - eligible legendary-chain kill", "Icecrown Citadel: The Frozen Throne"),
        pin(192, 49.9, 52.8, 11, "The Lich King - loot the Sealed Chest", "Icecrown Citadel: The Frozen Throne"),
        pin(186, 42.6, 22.6, 12, "Entrance hall - Darion's Personal Property turn-in", "Icecrown Citadel: The Lower Citadel"),
        pin(186, 42.6, 22.6, 13, "Entrance hall - nearby post-kill reward NPCs and Uther", "Icecrown Citadel: The Lower Citadel"),
    },
})

-- https://www.wowhead.com/item=40643#comments:id=554620 and all replies
-- https://www.wowhead.com/item=40643#comments:id=562816 and all replies
-- https://www.wowhead.com/item=40643#comments:id=1706935 and all replies
-- https://www.wowhead.com/achievement=1021#comments:id=3215854
-- Additional shopping pins preserve the already-reviewed Outland vendor routes
-- in BurningCrusade/CosmeticGuides.lua, rather than inventing new destinations.
local achieverWaypoints = {
    pin(84, 64.0, 77.2, 2, "Rebecca Laughlin - Alliance basic PvP/Guild tabards", "Stormwind City"),
    pin(85, 47.5, 75.5, 2, "Garyl - Horde basic PvP/Guild tabards", "Orgrimmar"),
}
for _, city in ipairs(cityTabards) do
    achieverWaypoints[#achieverWaypoints + 1] = pin(city.map, city.x, city.y, 3,
        city.faction .. ": " .. city.vendor .. " - " .. city.name, city.mapName)
end
for _, point in ipairs({
    pin(118, 87.6, 75.6, 4, "Aliocha Segard - Argent Crusade Friendly tabard", "Icecrown"),
    pin(118, 43.4, 20.6, 4, "Duchess Mynx - Ebon Blade tabard after vault unlock", "Icecrown"),
    pin(115, 59.8, 53.0, 4, "Cielstrasza - Wyrmrest Friendly tabard, TOP terrace", "Dragonblight"),
    pin(125, 25.4, 47.8, 4, "Archmage Alvareaux - Kirin Tor Friendly tabard", "Dalaran (Northrend)"),
    pin(100, 56.6, 62.6, 5, "Alliance: Ulrike - Honor Hold tabard at Exalted", "Hellfire Peninsula"),
    pin(100, 54.8, 37.8, 5, "Horde: Urgronn - Thrallmar tabard at Exalted", "Hellfire Peninsula"),
    pin(102, 79.2, 63.8, 5, "Fedryen Swiftspear - Cenarion Expedition tabard at Exalted", "Zangarmarsh"),
    pin(111, 62.0, 69.0, 5, "Nakodu - Lower City tabard at Exalted", "Shattrath City"),
    pin(111, 51.2, 41.6, 5, "Almaador - Sha'tar tabard at Exalted", "Shattrath City"),
    pin(125, 51.6, 55.4, 7, "Elizabeth Ross - achievement reward recovery", "Dalaran (Northrend)"),
    pin(84, 64.0, 77.2, 7, "Rebecca Laughlin - lost-tabard dialogue", "Stormwind City"),
    pin(85, 47.5, 75.5, 7, "Garyl - lost-tabard dialogue", "Orgrimmar"),
}) do achieverWaypoints[#achieverWaypoints + 1] = point end
add(40643, "Tabard of the Achiever", {
    source = "Twenty-Five Tabards (1021); mailed reward or tabard-designer recovery",
    sourceAchievementId = 1021,
    description = "Gold-and-red reward for collecting 25 qualifying tabards.",
    requirements = "Twenty-Five Tabards. Check its actual counter to confirm which purchases count.",
    cost = "No charge for the reward or eligible replacement; component tabards have their own costs.",
    effect = "Cosmetic appearance; no reputation championing effect.",
    tips = "Older lists mix factions, retired event rewards and obsolete refund tricks. Use obtainable tabards for your faction and equip each one. Later-expansion appearances do not all count toward this old achievement.",
    steps = {
        "Track Twenty-Five Tabards (1021) and note its counter. Work from the number already credited; the number of Wardrobe appearances is not a reliable substitute.",
        "Start with inexpensive purchases: your faction's city tabards, Guild Tabard, and Private's Tabard plus Knight's Colors for Alliance, or Scout's Tabard plus Stone Guard's Herald for Horde. The PvP pair costs Marks of Honor, not removed battleground tokens.",
        "Use the individual city-tabard guides in this catalogue for current sellers and maps. Buy and equip each different tabard, checking 1021 after each purchase. Repeated copies of the same item add nothing.",
        "Add the four Wrath reputation tabards: Argent Crusade, Ebon Blade, Wyrmrest Accord and Kirin Tor. Each requires Friendly, not Exalted. Their guides explain the Shadow Vault unlock and each separate quartermaster.",
        "Fill the remaining count with tabards whose requirements you already meet. Outland's Honor Hold/Thrallmar, Cenarion Expedition, Lower City, Sha'tar and other reputation rewards are useful choices; use their individual guides for the Exalted grinds. Green and Purple Trophy Tabards of the Illidari and Tabard of the Explorer provide more options. A retired event reward is unnecessary.",
        "Equip each new tabard and recheck the counter. Relog if credit is delayed. Keep required purchases; old comments promising permanent credit after refunding PvP or tournament tabards are not a dependable shopping plan.",
        "At 25 credited tabards, collect the mailed reward. For missing mail or an alt's physical copy, speak to Elizabeth Ross in Northrend Dalaran (51.6, 55.4), Rebecca Laughlin in Stormwind (64.0, 77.2), or Garyl in Orgrimmar (47.5, 75.5). Choose the lost-Tabard-of-the-Achiever dialogue; it is not ordinary vendor stock.",
        "Equip the reward and confirm the appearance. Once the achievement is earned, eligible alts can use that recovery dialogue without collecting 25 tabards again.",
    },
    waypoints = achieverWaypoints,
})

-- https://www.wowhead.com/item=43300#comments:id=633521 and replies
-- https://www.wowhead.com/item=43300#comments:id=2311512
-- https://www.wowhead.com/achievement=7520#comments:id=5172293 and replies
-- https://www.wowhead.com/achievement=7520#comments:id=6076567
-- https://www.wowhead.com/achievement=7520#comments:id=5413179 and replies
add(43300, "Loremaster's Colors", {
    source = "The Loremaster (7520); mailed reward or tabard-designer recovery",
    sourceAchievementId = 7520,
    description = "Questing achievement tabard with a yellow exclamation mark.",
    requirements = "The current The Loremaster meta, not only Loremaster of Northrend.",
    cost = "Quest completion; no purchase price for the reward or eligible replacement.",
    effect = "Cosmetic tabard; the achievement also awards the Loremaster title.",
    tips = "Use the criteria displayed by 7520. Old 550/700-quest totals and retired Wrath faction metas do not describe today's zone-story requirements. Completed zone achievements can contribute across characters and factions.",
    steps = {
        "Search Achievements for The Loremaster (7520). Expand each unfinished continent/expansion requirement, then its unfinished zone achievements. List the missing story chapters instead of accepting every quest on every continent.",
        "Check existing characters before beginning. An alt with most of a zone finished can save substantial work. Completed zone achievements contribute to the account meta; inspect the actual chapter criteria before splitting an unfinished chain between characters.",
        "Enable Trivial Quests in tracking. Follow the missing zone's story markers and finish one chapter at a time. Take connected quests together, loot quest enemies for item-started follow-ups, and return to the last giver when a chain appears to stop.",
        "At high level, carry Soft Foam Sword for eligible enemies that must be weakened and kept alive. Remove damage-proc gear for capture, interrogation and vehicle objectives; a one-shot can prevent the required action.",
        "If a giver is absent, check your log for another stage or scenario affecting the zone and follow the chapter's current prerequisites. Do not hunt removed Battle for the Undercity objectives or use pre-Cataclysm quest-count lists as a Retail route.",
        "Recheck each zone achievement after its chapters, then the expansion achievement after its zones. Continue until every requirement currently listed under 7520 is complete. Northrend alone or a lifetime quest total does not award this tabard.",
        "Collect the mailed tabard. For missing mail or an alt's copy, speak to Elizabeth Ross in Northrend Dalaran (51.6, 55.4), Rebecca Laughlin in Stormwind (64.0, 77.2), or Garyl in Orgrimmar (47.5, 75.5). Choose the lost-Loremaster's-Colors dialogue, then equip it.",
    },
    waypoints = {
        pin(125, 51.6, 55.4, 7, "Elizabeth Ross - Loremaster reward recovery", "Dalaran (Northrend)"),
        pin(84, 64.0, 77.2, 7, "Rebecca Laughlin - lost-Loremaster's-Colors dialogue", "Stormwind City"),
        pin(85, 47.5, 75.5, 7, "Garyl - lost-Loremaster's-Colors dialogue", "Orgrimmar"),
    },
})

-- https://www.wowhead.com/item=43348#comments:id=612232
-- https://www.wowhead.com/item=43348#comments:id=1825520
-- https://www.wowhead.com/item=43348#comments:id=2076760 and reply
-- https://www.wowhead.com/achievement=45 (current nine zone criteria)
-- Landmarks: Retail NPCs 26117, 32533, 26853, 28518, 27986, 29473,
-- 30431 and object 191230. Starting landmarks are not entire zone criteria.
add(43348, "Tabard of the Explorer", {
    source = "Northrend Explorer (45); mailed reward or tabard-designer recovery",
    sourceAchievementId = 45,
    description = "Exploration reward bearing a stylized world map.",
    requirements = "Explore the nine zones listed under Northrend Explorer. Wintergrasp is not required.",
    cost = "Exploration; no purchase price for the reward or eligible replacement.",
    effect = "Cosmetic appearance. Unchampioned dungeon reputation is not a special effect of this tabard.",
    tips = "Pins mark route starting landmarks. Visit ALL unexplored named areas in each zone's achievement, not just the pin. Northrend Explorer awards the tabard; the wider World Explorer project is separate.",
    steps = {
        "Track Northrend Explorer (45). Open its nine zone achievements to see missing named areas. Fly into each actual area until discovery credit appears; passing far above or beside it can miss the trigger.",
        "Borean Tundra: start near the Transitus Shield in Coldarra (33.2, 34.4), cover the island, then the mainland's missing areas. Howling Fjord: use the Utgarde approach (57.3, 46.7) as a central reference and cover the missing coast, islands and inland areas. Select each zone separately in the dropdown.",
        "Dragonblight: start from Wyrmrest Temple (59.8, 53.0) and visit missing dragonshrines and settlements. Grizzly Hills: use Camp Oneqwah (64.8, 46.8) as a reference and cover its missing areas. Exploration does not require talking to or fighting the local faction NPCs.",
        "Zul'Drak: start near Ebon Watch (14.0, 73.8), then cover the terraces and missing temples. Sholazar Basin: start at Nesingwary Base Camp (27.0, 58.6) and visit every missing lake, pillar and camp area.",
        "The Storm Peaks: start at K3 (41.0, 86.0), then explore missing northern and high-altitude areas. Crystalsong Forest: begin below Dalaran near the teleport crystal (15.8, 42.4) and cover the forest's named areas. Dalaran above it does not substitute for Crystalsong exploration.",
        "Icecrown: begin at the Argent Vanguard (87.6, 75.6) and fly through the missing named areas. Confirm that Icecrown's exploration achievement and all eight other zones are checked under Northrend Explorer.",
        "Collect the mailed tabard; do not chase Brann for a turn-in. For missing mail or an alt's copy, speak to Elizabeth Ross in Northrend Dalaran (51.6, 55.4) and choose the lost-Tabard-of-the-Explorer dialogue. Equip it to confirm the appearance.",
    },
    waypoints = {
        pin(114, 33.2, 34.4, 2, "Coldarra - Borean Tundra exploration start", "Borean Tundra"),
        pin(117, 57.3, 46.7, 2, "Utgarde approach - Howling Fjord exploration start", "Howling Fjord"),
        pin(115, 59.8, 53.0, 3, "Wyrmrest Temple - Dragonblight exploration start", "Dragonblight"),
        pin(116, 64.8, 46.8, 3, "Camp Oneqwah area - Grizzly Hills exploration start", "Grizzly Hills"),
        pin(121, 14.0, 73.8, 4, "Ebon Watch - Zul'Drak exploration start", "Zul'Drak"),
        pin(119, 27.0, 58.6, 4, "Nesingwary Base Camp - basin exploration start", "Sholazar Basin"),
        pin(120, 41.0, 86.0, 5, "K3 - Storm Peaks exploration start", "The Storm Peaks"),
        pin(127, 15.8, 42.4, 5, "Below Dalaran - Crystalsong exploration start", "Crystalsong Forest"),
        pin(118, 87.6, 75.6, 6, "Argent Vanguard - Icecrown exploration start", "Icecrown"),
        pin(125, 51.6, 55.4, 7, "Elizabeth Ross - lost-Explorer-tabard dialogue", "Dalaran (Northrend)"),
    },
})

-- https://www.wowhead.com/item=43349#comments:id=559118
-- https://www.wowhead.com/item=43349#comments:id=1960752 and reply 1387976
-- https://www.wowhead.com/item=43349#comments:id=3119672 and reply 1301026
-- https://www.wowhead.com/achievement=876#comments:id=6272472 and reply 1833926
add(43349, "Tabard of Brute Force", {
    source = "Brutally Dedicated (876) - 300 ranked arena victories",
    sourceAchievementId = 876, category = "PvP",
    description = "Bloodstained tabard rewarded for sustained ranked arena success.",
    requirements = "300 ranked arena wins credited to Brutally Dedicated; no original Wrath-season rating required.",
    cost = "Achievement reward; no Honor or Conquest purchase.",
    effect = "Cosmetic appearance; no PvP combat bonus.",
    tips = "A recent reply reports Solo Shuffle rounds giving no progress. Use rated 2v2 or 3v3 and verify a win advances the counter. Old arena-point payouts, arena teams and 5v5 are obsolete. The appearance is account-wide; physical replacement reports conflict.",
    steps = {
        "Track Brutally Dedicated (876) and note its win counter. If already earned, check tabard appearances first: the appearance can be available even when no physical reward is in your bags.",
        "Find a partner for rated 2v2, or two partners for rated 3v3. Open PvP > Rated and queue for that arena bracket. Skirmishes, ordinary battlegrounds and arena losses do not meet the ranked-win requirement.",
        "Win a rated match and check that 876 advances. Continue in a bracket that gives credit. Do not treat six Solo Shuffle rounds as six qualifying wins; the recent reply reports no progress from that mode.",
        "Build the counter to 300 across as many sessions as needed. There is no requirement to finish in one season or reach the old elite-tabard rating. Track wins, not matches played or Conquest earned.",
        "At completion, check mail and the appearance collection. If the physical tabard is absent, ask Elizabeth Ross in Northrend Dalaran (51.6, 55.4) whether the lost-tabard dialogue is offered. Reports include cases where only the transmog appeared, so retain an existing physical copy rather than assuming guaranteed replacement.",
    },
    waypoints = {
        pin(125, 51.6, 55.4, 5, "Elizabeth Ross - check recovery after earning Brutally Dedicated", "Dalaran (Northrend)"),
    },
})

-- https://www.wowhead.com/item=43154#comments:id=879347 and replies
-- https://www.wowhead.com/item=43154#comments:id=5827947
-- https://www.wowhead.com/item=43154#comments:id=6177263
-- https://www.wowhead.com/faction=1106/argent-crusade
-- https://www.wowhead.com/quest=13008/scourge-tactics
add(43154, "Tabard of the Argent Crusade", {
    category = "Reputation", npcId = 30431,
    source = "Veteran Crusader Aliocha Segard - Argent Vanguard, Icecrown",
    description = "Argent Crusade tabard with the gold sun-and-hand emblem.",
    requirements = "Friendly with Argent Crusade on the buyer; either faction.",
    cost = "1 gold base, before reputation discounts.",
    effect = "Wearing the physical tabard redirects eligible Wrath dungeon reputation to Argent Crusade.",
    tips = "This is the Friendly reputation tabard, not Argent Crusader's Tabard with its tournament teleport. Shadowlands pre-event vendor moves and Honor-to-Justice conversions are not the normal Retail purchase route.",
    steps = {
        "Check Argent Crusade reputation. At Friendly or higher, skip to step 4. Argent Dawn is separate and does not satisfy this purchase.",
        "At the Argent Vanguard in southeastern Icecrown (around 87.0, 76.0), enable Trivial Quests. Start Honor Above All Else if offered and report to Crusade Commander Entari. Take Scourge Tactics, Defending the Vanguard and Curing the Incurable as available.",
        "Outside the camp, free the webbed crusaders, kill the requested nerubians and loot venom sacs for the cure. Turn in and follow the rescue/defense chain until Friendly. Existing Plaguelands or Zul'Drak quest progress can already have supplied the reputation.",
        "Find Veteran Crusader Aliocha Segard at the upper camp (87.6, 75.6), by the tents near Tirion. Buy Tabard of the Argent Crusade for up to 1 gold, then equip it to learn the appearance.",
        "For optional further reputation, keep the physical tabard equipped and clear Heroic Halls of Lightning in the Storm Peaks (45.4, 21.4). Check your reputation bar after the first kills. Other original Wrath heroics also work; transmog alone does not champion the faction.",
    },
    waypoints = {
        pin(118, 87.0, 76.0, 2, "Argent Vanguard - introductory quest hub", "Icecrown"),
        pin(118, 87.6, 75.6, 4, "Aliocha Segard - Friendly reputation tabard", "Icecrown"),
        pin(120, 45.4, 21.4, 5, "Halls of Lightning - optional Heroic reputation", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=43155#comments:id=2089606 and Horde reply 898225
-- https://www.wowhead.com/item=43155#comments:id=448902 and all replies
-- https://www.wowhead.com/quest=12893#comments:id=452276 (three ledge locations)
-- https://www.wowhead.com/quest=12893#comments:id=496146 (use rod promptly)
-- Retail objectives: 12887/12892, 12891, 12893, 12896/12897, 12898/12899.
add(43155, "Tabard of the Ebon Blade", {
    category = "Reputation", npcId = 32538,
    source = "Duchess Mynx - unlocked Shadow Vault, Icecrown",
    description = "Dark violet Knights of the Ebon Blade championing tabard.",
    requirements = "Friendly with Knights of the Ebon Blade and the Shadow Vault phase unlocked. Any class.",
    cost = "1 gold base, before reputation discounts.",
    effect = "Wearing the physical tabard redirects eligible Wrath dungeon reputation to Knights of the Ebon Blade.",
    tips = "Death Knight starting reputation does not unlock Mynx. Gunships move: pins mark search areas in the sky, not fixed landing spots. Cold Weather Flying purchases and the old level-77 requirement are obsolete.",
    steps = {
        "If the Shadow Vault is already friendly and Duchess Mynx is visible, skip to step 7. Otherwise enable Trivial Quests and find your faction's flying gunship: The Skybreaker for Alliance or Orgrim's Hammer for Horde.",
        "Speak to Thassarian on The Skybreaker or Koltira Deathweaver on Orgrim's Hammer. Accept It's All Fun and Games (12887 Alliance / 12892 Horde). Search the patrol area above Icecrown instead of standing on the ground at one coordinate.",
        "Fly to the Ocular above the Shadow Vault (44.3, 21.5). Use the quest item repeatedly on the floating eye until destroyed. Turn in to Baron Sliver outside the vault (44.0, 24.6).",
        "Accept I Have an Idea, But First... (12891). Kill and loot nearby Scourge for a Cultist Rod, Abomination Hook, Geist Rope and 5 Scourge Essences. Return these to Sliver for the Sovereign Rod.",
        "For Free Your Mind (12893), kill Vile on the ledge near 44.4, 27.0 and Lady Nightswood near 41.8, 24.5. Find The Leaper patrolling the ring above Sliver, starting around 44.3, 23.6. Use the Sovereign Rod on EACH corpse promptly before it despawns. Killing them alone does not complete the conversions.",
        "Take If He Cannot Be Turned (12896 / 12897). Enter the vault, activate the weapon rack near the statue and kill General Lightsbane. Return to Thassarian/Koltira on the gunship, then take The Shadow Vault (12898 / 12899) back to the friendly base.",
        "Find Duchess Mynx inside, left near the forge (43.4, 20.6). At Friendly with Knights of the Ebon Blade, buy the tabard for up to 1 gold. If still short of Friendly, finish available Ebon Blade follow-ups in the newly opened base.",
        "Equip the tabard to learn its appearance. For optional reputation, wear the physical item and clear Heroic Halls of Lightning in the Storm Peaks (45.4, 21.4). Check that Ebon Blade reputation increases; raids and unrelated modern dungeons are not substitutes.",
    },
    waypoints = {
        pin(118, 59.6, 44.6, 2, "Alliance: Skybreaker patrol - search ABOVE the ground", "Icecrown"),
        pin(118, 64.6, 46.4, 2, "Horde: Orgrim's Hammer patrol - search ABOVE the ground", "Icecrown"),
        pin(118, 44.3, 21.5, 3, "The Ocular - eye above the Shadow Vault", "Icecrown"),
        pin(118, 44.0, 24.6, 3, "Baron Sliver - outside the vault", "Icecrown"),
        pin(118, 44.0, 24.6, 4, "Baron Sliver - rod components", "Icecrown"),
        pin(118, 44.4, 27.0, 5, "Vile - kill, then use the Sovereign Rod", "Icecrown"),
        pin(118, 41.8, 24.5, 5, "Lady Nightswood - kill, then use the rod", "Icecrown"),
        pin(118, 44.3, 23.6, 5, "The Leaper - patrol on the upper ring; use rod after kill", "Icecrown"),
        pin(118, 43.4, 24.4, 6, "Vault entrance - weapon rack and Lightsbane inside", "Icecrown"),
        pin(118, 43.4, 20.6, 7, "Duchess Mynx - tabard after the phase unlock", "Icecrown"),
        pin(120, 45.4, 21.4, 8, "Halls of Lightning - optional Heroic reputation", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=43156#comments:id=452811
-- https://www.wowhead.com/item=43156#comments:id=1337598
-- https://www.wowhead.com/npc=26117/raelorasz
-- https://www.wowhead.com/npc=26443/tariolstrasz
-- https://www.wowhead.com/quest=11918/basic-training
-- https://www.wowhead.com/quest=11936/hatching-a-plan
add(43156, "Tabard of the Wyrmrest Accord", {
    category = "Reputation", npcId = 32533,
    source = "Cielstrasza - upper Wyrmrest Temple terrace, Dragonblight",
    description = "Wyrmrest Accord tabard bearing a winged temple emblem.",
    requirements = "Friendly with The Wyrmrest Accord on the buyer; either faction.",
    cost = "1 gold base, before reputation discounts.",
    effect = "Wearing the physical tabard redirects eligible Wrath dungeon reputation to The Wyrmrest Accord.",
    tips = "Cielstrasza is on the TOP terrace, not the ground entrance or middle-floor daily. Her Red Drake requires Exalted; this tabard only needs Friendly.",
    steps = {
        "Check The Wyrmrest Accord reputation. At Friendly or higher, skip to step 3. Kirin Tor or another dragonflight's reputation does not substitute.",
        "For initial reputation, visit Raelorasz at the Transitus Shield in Coldarra, Borean Tundra (33.2, 34.4). Start Basic Training: kill 10 Coldarra Spellweavers. Continue Hatching a Plan: loot Frozen Axes from Coldarra Wyrmkin and use them to break 5 blue dragon eggs around the base of the Nexus. Continue the Drake Hunt and Cracking the Code chain, checking the Wyrmrest bar after turn-ins. Finish further red-dragon quests until Friendly; already-started Wyrmrest story quests in Dragonblight can supply the remaining reputation too.",
        "Travel to Wyrmrest Temple in Dragonblight. Fly to the top terrace, or speak to Tariolstrasz at the western ground entrance (57.8, 54.2) for a drake ride to the top. Do not stop at the middle-floor defenders.",
        "Find Cielstrasza on the upper terrace (59.8, 53.0). Buy Tabard of the Wyrmrest Accord for up to 1 gold and equip it. Browse the remaining vendor pages if needed.",
        "For optional reputation toward her Red Drake, wear the actual tabard and clear Heroic Halls of Lightning in the Storm Peaks (45.4, 21.4). Confirm Wyrmrest reputation increases. The old level-80 wording does not mean any dungeon at your present character level works.",
    },
    waypoints = {
        pin(114, 33.2, 34.4, 2, "Raelorasz - initial Wyrmrest reputation quests", "Borean Tundra"),
        pin(115, 57.8, 54.2, 3, "Tariolstrasz - ground-floor ride to the top", "Dragonblight"),
        pin(115, 59.8, 53.0, 4, "Cielstrasza - TOP terrace purchase", "Dragonblight"),
        pin(120, 45.4, 21.4, 5, "Halls of Lightning - optional Heroic reputation", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=43157#comments:id=940861 and all replies
-- https://www.wowhead.com/item=43157#comments:id=444025 and reply
-- https://www.wowhead.com/item=43157#comments:id=466890 and all replies
-- https://www.wowhead.com/item=43157#comments:id=3207692
-- https://www.wowhead.com/npc=25262/librarian-donathan
-- https://www.wowhead.com/quest=11587/prison-break
add(43157, "Tabard of the Kirin Tor", {
    category = "Reputation", npcId = 32287,
    source = "Archmage Alvareaux - Violet Citadel, Northrend Dalaran",
    description = "Purple-and-gold Kirin Tor championing tabard.",
    requirements = "Friendly with Kirin Tor on the buyer; any class or faction.",
    cost = "1 gold base, before reputation discounts.",
    effect = "Wearing the physical tabard redirects eligible Wrath dungeon reputation to Kirin Tor.",
    tips = "Use Northrend Dalaran, not the Broken Isles city or Dalaran Hearthstone destination. Mages can already be Friendly. Replies warn that many Coldarra quests award Wyrmrest Accord instead of Kirin Tor.",
    steps = {
        "Check Kirin Tor reputation. If Friendly or higher, skip to step 3. Mages commonly start Friendly and can buy directly; other classes can obtain the tabard too.",
        "For Friendly, visit Librarian Donathan at Amber Ledge in Borean Tundra (45.2, 33.4). Start Prison Break: kill Beryl Mage Hunters in the camp just south of the ledge, loot a Beryl Prison Key and open an arcane prison to rescue a mage. Return to Donathan, then follow Abduction and the Amber Ledge investigation chain. For Abduction, weaken the target before using the provided capture item; high-level characters can use Soft Foam Sword on an eligible target to avoid killing it. Keep completing the Kirin Tor follow-ups until Friendly. Many Coldarra red-dragon quests award Wyrmrest instead, so check the reward faction.",
        "Go to the original Dalaran above Crystalsong Forest. Enter the Violet Citadel on the west side and climb the interior stairs. Archmage Alvareaux stands upstairs around 25.4, 47.8.",
        "At Friendly, buy Tabard of the Kirin Tor for up to 1 gold and equip it. If the shop says you already own a unique item, check bags and bank before trying another copy.",
        "For optional reputation, wear the actual tabard and clear Heroic Halls of Lightning in the Storm Peaks (45.4, 21.4). Other original Wrath heroics work too. Normal Halls of Lightning is a repeatable alternative: leave, reset outside and respect the instance limit. Check the reputation bar before repeating runs.",
    },
    waypoints = {
        pin(114, 45.2, 33.4, 2, "Librarian Donathan - Amber Ledge quests", "Borean Tundra"),
        pin(125, 25.4, 47.8, 3, "Archmage Alvareaux - upstairs in Violet Citadel", "Dalaran (Northrend)"),
        pin(125, 25.4, 47.8, 4, "Archmage Alvareaux - Friendly tabard purchase", "Dalaran (Northrend)"),
        pin(120, 45.4, 21.4, 5, "Halls of Lightning - optional reputation runs", "The Storm Peaks"),
    },
})

-- Retail availability reviewed 2026-11-04: all 24 retained tabards have a live
-- vendor, achievement or tradable reward route. Original seasonal tabards
-- are excluded, while Brutally Dedicated and the Isle of Conquest metas remain.
-- https://www.wowhead.com/guide/vanity-collections/guide-to-collecting-tabards
-- https://www.wowhead.com/item=43349/tabard-of-brute-force
rate("easy", "Buy the inexpensive racial tabard from the current city quartermaster; a tournament championship is unnecessary.", {
    45574,45577,45578,45579,45580,45581,45582,45583,45584,45585,
})
rate("medium", "Complete the faction introduction to Friendly and buy its guaranteed reputation tabard.", {43154,43155,43156,43157})
rate("medium", "Collect twenty-five distinct tabards using current vendors and reputation rewards.", {40643})
rate("medium", "Discover every required subzone across the nine Northrend exploration achievements.", {43348})
rate("medium", "Unlock the appropriate tournament championship, earn Exalted reputation and buy the tabard with seals.", {46817,46818})
rate("medium", "Buy the tradable tabard or complete Shadowmourne's long quest chain and final chest turn-in.", {52252})
rate("hard", "Complete the cross-continent Loremaster quest metas; this is an extensive account collection project.", {43300})
rate("hard", "Win three hundred qualifying rated Arena matches; sustained PvP participation is required.", {43349})
rate("hard", "Champion all five cities, earn their required Exalted reputations and buy the Crusader teleport tabard.", {46874})
rate("hard", "Finish the Isle of Conquest meta, including 100 wins and coordinated bomb, vehicle and objective criteria.", {49052,49054})

local fields = { "acquisition", "npcId", "source", "tips", "requirements", "cost", "category", "waypoints", "faction", "sourceAchievementId", "description", "effect", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^3%.") then
        for _, entry in ipairs(patch.cosmetics or {}) do
            local guide = guides[entry.itemId]
            if guide then
                local detailsByName = TDP.PatchCatalog.cosmeticDetails[patchKey] or {}
                TDP.PatchCatalog.cosmeticDetails[patchKey] = detailsByName
                local details = {}
                for key, value in pairs(detailsByName[entry.name] or {}) do details[key] = value end
                for _, field in ipairs(fields) do
                    if guide[field] ~= nil then entry[field], details[field] = guide[field], guide[field] end
                end
                details.sourceType = guide.sourceType
                detailsByName[entry.name] = details
            end
        end
    end
end
