-- Manually curated English Retail routes, reviewed 2026-11-04.
-- Read alongside the original catalogue text. Comment IDs identify evidence;
-- historical skill levels, exploits, temporary events and retired seasons are
-- not acquisition instructions. Coordinates are destinations or search areas,
-- never a promise that a rare or a rotating archaeology dig site is present.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.mounts = TDP.CollectionWalkthroughs.mounts or {}
local guides = TDP.CollectionWalkthroughs.mounts

local categories = {
    Class = "Quest Rewards", Reputation = "Vendor", Professions = "Other",
    ["Guild Achievements"] = "Achievements",
}
local function add(spellID, name, itemID, guide)
    local lines = { "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason }
    for step, instruction in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. instruction
    end
    guide.name, guide.itemId = name, itemID
    guide.mountCategory = categories[guide.category] or guide.category
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #guide.steps
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.wowheadUrl = "https://www.wowhead.com/" .. (itemID and ("item=" .. itemID) or ("spell=" .. spellID))
    guides[spellID] = guide
end
local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

-- https://www.wowhead.com/item=63042#comments:id=2857631
-- https://www.wowhead.com/item=63042#comments:id=3227015
-- The 8.1 change and current reports supersede the old friendly vehicle fight.
add(88718, "Phosphorescent Stone Drake", 63042, {
    category = "Rare Drops", source = "Aeonaxx - six aerial search areas in Deepholm", npcId = 50062,
    description = "A guaranteed mount from an eligible Aeonaxx kill; finding the rare airborne dragon is the difficult part.",
    difficulty = "hard", difficultyReason = "An unpredictable rare spawn, competition and separate world phases make the search potentially lengthy.",
    cost = "No purchase", requirements = "A normal character able to reach and defeat Aeonaxx",
    tips = "Use a normal character rather than a Class Trial. Modern Aeonaxx is hostile: the old instruction to mount his back is obsolete. Do not confuse him with Xariona or assume either rare's timer guarantees an Aeonaxx spawn.",
    sourceComments = {2857631, 3227015, 2588218, 5373641, 5777836, 6276122, 6371446},
    sourceReplyIds = {1343540, 1405054},
    steps = {
        "Reach Deepholm through your faction capital's Cataclysm portal. If the portal is not unlocked, follow the Deepholm introduction, starting with The Maelstrom, until you reach the Temple of Earth. Bring flying and a safe way to handle falling after an aerial pull.",
        "Search all six marked areas around the Temple of Earth: 42.0,43.6; 43.0,50.8; 49.1,55.6; 50.5,63.5; 53.7,39.7; and 55.1,54.1. Look above and below your current altitude, roughly around Stonecore-entrance height and the surrounding floating pillars. These are search centers, not guaranteed spawn positions.",
        "Use /target Aeonaxx while checking the areas, and visually inspect the dragon if targeted. A rare-alert addon can help, but remaining motionless at Stonecore does not cover every spawn or height. Check different valid War Mode or Chromie Time phases only with characters eligible for those phases; changing phase does not force a spawn.",
        "When Aeonaxx is present, get within range and attack him directly. On a low-level Chromie Time character he can hit hard, so bring help rather than assuming the old low-health vehicle encounter still applies. If sharing a find, assemble the small party and nearby eligible characters before the kill.",
        "Kill Aeonaxx, reach his corpse safely and loot Reins of the Phosphorescent Stone Drake. Stay in the same group and phase until looting is complete. Use the reins; a short unsuccessful patrol does not start a fixed countdown to your next sighting.",
    },
    waypoints = {
        pin(207, 42.0, 43.6, 2, "Aeonaxx - northwest aerial search area", "Deepholm"),
        pin(207, 43.0, 50.8, 2, "Aeonaxx - west aerial search area", "Deepholm"),
        pin(207, 49.1, 55.6, 2, "Aeonaxx - central aerial search area", "Deepholm"),
        pin(207, 50.5, 63.5, 2, "Aeonaxx - south aerial search area", "Deepholm"),
        pin(207, 53.7, 39.7, 2, "Aeonaxx - northeast aerial search area", "Deepholm"),
        pin(207, 55.1, 54.1, 2, "Aeonaxx - east aerial search area", "Deepholm"),
    },
})

-- https://www.wowhead.com/item=63046#comments:id=1525679
-- https://www.wowhead.com/item=63046#comments:id=3188369
-- https://www.wowhead.com/item=63046#comments:id=2587802
-- Retain the useful search coordinates; reject the obsolete repeat-kill and
-- realm-swap sharing instructions. Dormus's pin is the post-teleport phase.
local camelSearch = {
    {25.4,51.2}, {32.6,47.8}, {32.0,45.0}, {40.0,44.8}, {40.0,43.2},
    {40.0,38.6}, {33.2,28.2}, {33.8,25.4}, {29.8,25.0}, {29.8,20.6},
    {34.4,21.4}, {34.2,19.6}, {45.2,15.8}, {52.4,28.0}, {50.6,31.6},
    {37.0,64.0}, {33.0,59.8}, {33.2,63.0}, {33.2,68.0}, {33.0,71.8},
    {31.6,69.2}, {30.8,67.6}, {30.8,66.4}, {30.4,62.4}, {30.6,60.6},
    {28.6,63.6}, {26.2,64.8}, {25.6,65.8}, {22.2,64.0}, {24.6,60.0},
    {73.4,73.8}, {51.0,79.6}, {47.2,76.8}, {49.0,75.8}, {50.2,73.4},
    {50.6,72.2}, {51.8,70.6}, {52.0,51.0}, {51.8,49.6}, {50.6,50.6},
    {48.0,46.6}, {46.2,44.8}, {40.8,49.6}, {38.6,54.8}, {38.2,60.4},
    {64.8,30.2}, {72.0,44.0}, {69.8,57.8},
}
local camelPins = {pin(249, 56.0, 35.1, 1, "Zidormi - select original Uldum", "Uldum")}
for _, location in ipairs(camelSearch) do
    camelPins[#camelPins + 1] = pin(249, location[1], location[2], 3, "Mysterious Camel Figurine - possible search location", "Uldum")
end
camelPins[#camelPins + 1] = pin(69, 69.5, 73.2, 5, "Dormus - reachable only after the real figurine's teleport", "Feralas")
add(88750, "Grey Riding Camel", 63046, {
    category = "Rare Drops", source = "Mysterious Camel Figurine, then Dormus the Camel-Hoarder", npcId = 50245,
    description = "Find the real miniature camel in original Uldum, accept its teleport and kill Dormus during the temporary encounter phase.",
    difficulty = "hard", difficultyReason = "Rare figurines are scattered across many locations and most are the dust-producing decoy.",
    cost = "No purchase", requirements = "Original Uldum phase; defeat Dormus before the 20-minute buff expires",
    tips = "Dormus cannot be reached by flying straight to his Feralas pin. The figurine supplies the required phase. Use a normal character to avoid inconsistent Class Trial eligibility reports.",
    sourceComments = {1525679, 1551431, 2587802, 3188369, 3212109, 5517146, 5965080, 6246148},
    steps = {
        "Travel to Uldum and speak to Zidormi near 56.0,35.1 if the N'Zoth assault is active. Choose the earlier Uldum. Ramkahen reputation and buying the Brown or Tan Riding Camel do not unlock the rare figurine.",
        "Enable friendly NPC nameplates. The figurine is tiny and cannot be reliably found by an old /target macro. An optional Camel Spotter addon can alert on its nameplate and distinguish the real figurine, NPC 50409, from the dust-producing 50410.",
        "Fly low over the marked Uldum search locations and inspect the exact ground, ledges, bushes and rooftops. All figurine pins belong to this step. They are possible locations, so an empty point is expected; sweep the whole route rather than waiting only beside Ramkahen.",
        "Click any figurine you find. Most crumble into Crumbled Statue Remnants; clear the fake and resume later patrols. The real figurine creates a cyclone and transports you to the Steam Pools in Feralas, applying Dormus' Rage for 20 minutes. No camel purchase is needed before clicking it.",
        "After the teleport, swim to shore and locate Dormus the Camel-Hoarder near 69.5,73.2 in the special Feralas phase. Defeat him and loot the reins before Dormus' Rage expires. Remain in the encounter phase until you have looted; old instructions to realm-hop for repeated kills are obsolete.",
        "Use the reins to learn the Grey Riding Camel and receive the associated Camel-Hoarder reward. If a sweep finds nothing, repeat later or check another legitimately available character phase. There is no guaranteed number of figurines or fixed successful time of day.",
    },
    waypoints = camelPins,
})

-- https://www.wowhead.com/item=64999#comments:id=5788788
-- https://www.wowhead.com/item=65356#comments:id=5788787
-- https://www.wowhead.com/npc=47328 and npc=48531 supply actual shop pins.
local function tolBarad(spellID, name, itemID, faction, tokens)
    local both = not faction
    local seller = faction == "Alliance" and "Quartermaster Brazie" or faction == "Horde" and "Pogg" or "Quartermaster Brazie or Pogg"
    add(spellID, name, itemID, {
        category = "Reputation", source = seller .. " - Tol Barad Peninsula", faction = faction,
        description = "A guaranteed Tol Barad commendation purchase after reaching Exalted with your faction's defenders.",
        difficulty = "medium", difficultyReason = "Repeat daily quests across resets to reach Exalted and save the required commendations.",
        cost = tokens .. " Tol Barad Commendations", requirements = "Exalted with Baradin's Wardens (Alliance) or Hellscream's Reach (Horde)",
        tips = "The vendor is on Tol Barad Peninsula, not inside Baradin Hold. The faction tabard teleports you; it does not champion dungeon reputation. Keep mount currency instead of spending it on other rewards first.",
        sourceComments = {5788787, 5788788, 1219130, 2017741, 2021049, 1780563},
        steps = {
            "Use the Tol Barad portal beside your capital's Cataclysm portals. It takes you to your faction's base on Tol Barad Peninsula. Alliance uses Baradin Base Camp around 72.5,62.6; Horde uses Hellscream's Grasp around 54.5,80.7.",
            "Complete the available daily quests from the base, turn them in and retain the Tol Barad Commendations. These quests are available even when the opposite faction controls the battle island. Repeat after daily resets until the relevant faction reputation reaches Exalted.",
            "For additional daily quests, cross the bridge to the separate Tol Barad battle island when your faction controls it. Take the quests from the outdoor hub around 51.4,49.6 and complete their marked objectives. This is the courtyard quest hub, not the raid entrance.",
            "If your faction does not control the island, the peninsula dailies still work. You can also participate in the next Tol Barad battle for victory rewards and access to the extra quests. Do not rely on the old comments' exact daily token totals: offered quests and controlling-faction access determine your actual earnings.",
            "Once you are Exalted and have " .. tokens .. " commendations, return to " .. seller .. " at the peninsula base and buy " .. name .. ". Use the reins from your bags. " .. (both and "The two factions sell the same West Wind drake; you do not need to buy it twice." or "Learning either Spectral Steed or Spectral Wolf also unlocks its faction counterpart for the appropriate characters."),
        },
        waypoints = {},
    })
    local points = guides[spellID].waypoints
    if both or faction == "Alliance" then
        points[#points + 1] = pin(245, 72.5, 62.6, 1, "Baradin Base Camp - Alliance daily hub", "Tol Barad Peninsula")
        points[#points + 1] = pin(245, 72.5, 62.6, 5, "Quartermaster Brazie - Alliance mount purchase", "Tol Barad Peninsula")
    end
    if both or faction == "Horde" then
        points[#points + 1] = pin(245, 54.5, 80.7, 1, "Hellscream's Grasp - Horde daily hub", "Tol Barad Peninsula")
        points[#points + 1] = pin(245, 54.5, 80.7, 5, "Pogg - Horde mount purchase", "Tol Barad Peninsula")
    end
    points[#points + 1] = pin(244, 51.4, 49.6, 3, "Outdoor victory daily hub - controlling faction only", "Tol Barad")
end
tolBarad(88741, "Drake of the West Wind", 65356, nil, 200)
tolBarad(92231, "Spectral Steed", 64998, "Alliance", 165)
tolBarad(92232, "Spectral Wolf", 64999, "Horde", 165)

-- https://www.wowhead.com/item=62298#comments:id=2438442
-- https://www.wowhead.com/item=67107#comments:id=2309978
for _, mount in ipairs({
    {90621, "Golden King", 62298, "Alliance", "Shay Pressler", 84, 67.7, 73.0, "Stormwind City"},
    {93644, "Kor'kron Annihilator", 67107, "Horde", "Goram", 85, 48.5, 75.5, "Orgrimmar"},
}) do
    add(mount[1], mount[2], mount[3], {
        category = "Guild Achievements", source = mount[5] .. " - guild vendor", faction = mount[4],
        description = "A guild-reputation purchase. The former guild-level-25 requirement no longer needs to be earned.",
        difficulty = "medium", difficultyReason = "Join a guild, earn Exalted guild reputation and pay the gold cost.",
        cost = "1,500 gold before applicable vendor discounts", requirements = "Exalted with your current guild",
        tips = "Learning either faction's version also unlocks the counterpart on the appropriate characters. Changing guilds before buying can affect your guild reputation; verify it with the current guild.",
        sourceComments = {2438442, 1419512, 1777525, 2309978},
        steps = {
            "On an appropriate-faction character, join a guild and check your reputation with that guild. Guild levels were removed; you do not need to level a guild to 25 or complete the personal Glory of the Cataclysm Raider achievement.",
            "Earn guild reputation through eligible quest completions and guild activities until Exalted. If available, a guild reputation tabard helps. Check progress against your current guild rather than an old guild's standing.",
            "Visit " .. mount[5] .. " in " .. mount[9] .. " at " .. mount[7] .. "," .. mount[8] .. ". Bring up to 1,500 gold, open the vendor's mount listings and buy " .. mount[2] .. ".",
            "Use the reins. Check the journal on both factions before buying a second item: Golden King and Kor'kron Annihilator are paired, so one learned purchase covers their corresponding faction appearances.",
        },
        waypoints = {pin(mount[6], mount[7], mount[8], 3, mount[5] .. " - guild mount vendor", mount[9])},
    })
end

-- https://www.wowhead.com/item=63125#comments:id=3372160
-- https://www.wowhead.com/achievement=4988#comments:id=2323773
-- https://www.wowhead.com/item=63125#comments:id=6051371 confirms purchase
-- after the temporary TWW vendor bug reported by comment 5996699.
add(88990, "Dark Phoenix", 63125, {
    category = "Guild Achievements", source = "Guild vendor after Guild Glory of the Cataclysm Raider",
    description = "Buy the phoenix at Exalted with a guild that has unlocked the three original Cataclysm guild raid clears.",
    difficulty = "medium", difficultyReason = "A guild with the unlock offers a direct purchase after the guild reputation grind.",
    cost = "3,000 gold before applicable vendor discounts", requirements = "Exalted with a guild that has Guild Glory of the Cataclysm Raider",
    tips = "The personal Glory achievement does not unlock a guild shop. You can buy the mount without personally attending the guild's old raid clears, and learned mounts remain available to eligible alts.",
    sourceComments = {3372160, 2323773, 2323804, 2574757, 5996699, 6051371, 6153175},
    steps = {
        "Check your guild's achievements for Guild Glory of the Cataclysm Raider (4988), including the guild runs of Blackwing Descent, The Bastion of Twilight and Throne of the Four Winds. If already complete, go straight to the reputation and purchase steps.",
        "If your guild wants to unlock it, form a qualifying guild raid: at least 8 guild members in 10-player mode or 20 in 25-player mode. Keep them present for the required kills and check the minimap's guild-group indicator. A solo guild member clearing the raids does not satisfy the guild-group requirement.",
        "Clear Blackwing Descent on the outside upper terrace of Blackrock Mountain (26.1,23.8 in Burning Steppes), The Bastion of Twilight on the high spire in Twilight Highlands (34.2,78.0), and Throne of the Four Winds above southwestern Uldum (38.4,80.6). Complete each raid's guild-run criteria and check that the guild meta has unlocked.",
        "Reach Exalted with that guild through eligible quests and guild activities. Alternatively, join an established guild that already has the unlock, then earn the required standing with your new guild. Personal raid credit is not required for the purchase.",
        "Buy Reins of the Dark Phoenix from Shay Pressler in Stormwind (67.7,73.0) or Goram in Orgrimmar (48.5,75.5), for up to 3,000 gold, and use the item. If the vendor refuses it, check both current-guild reputation and the guild achievement before repeating the raids.",
    },
    waypoints = {
        pin(36, 26.1, 23.8, 3, "Blackwing Descent - upper exterior terrace", "Burning Steppes"),
        pin(241, 34.2, 78.0, 3, "The Bastion of Twilight - high spire entrance", "Twilight Highlands"),
        pin(249, 38.4, 80.6, 3, "Throne of the Four Winds - floating entrance", "Uldum"),
        pin(84, 67.7, 73.0, 5, "Shay Pressler - Alliance guild vendor", "Stormwind City"),
        pin(85, 48.5, 75.5, 5, "Goram - Horde guild vendor", "Orgrimmar"),
    },
})
-- https://www.wowhead.com/spell=69820#comments:id=5834167
-- https://www.wowhead.com/spell=69826#comments:id=3201911
-- Full replies include the 2024 correction: simply log into the trial.
for _, mount in ipairs({ {69820, "Sunwalker Kodo"}, {69826, "Great Sunwalker Kodo"} }) do
    add(mount[1], mount[2], nil, {
        category = "Class", source = "Tauren Paladin racial mount", faction = "Horde", automaticUnlock = true,
        description = "Automatically learned by an eligible Tauren Paladin; reputation vendors do not sell this kodo.",
        difficulty = "easy", difficultyReason = "Create an eligible Paladin and check its automatically learned mounts.",
        cost = "No mount purchase", requirements = "Tauren Paladin",
        tips = "These mounts retain race and class restrictions. Seeing a racial class mount on another character's uncollected list does not mean that character can buy it.",
        sourceComments = {5834167, 3201911, 1759041}, sourceReplyIds = {1682838},
        steps = {
            "Log into a Tauren Paladin. If you already have one, open Collections > Mounts and search for Sunwalker Kodo and Great Sunwalker Kodo before travelling anywhere.",
            "For a quick unlock, create a Tauren Paladin Class Trial if your account offers that option, enter the world and check its Mount Journal. Retail commenters confirm that both kodos are already learned when the trial arrives in Orgrimmar; a vendor trip or old class-mount quest is unnecessary.",
            "Alternatively, play a normal Tauren Paladin through its introduction and riding progression, then check both entries again. Use the mount from the eligible Paladin's journal; creating the character does not let other races or classes summon these racial mounts.",
        },
        areaMaps = {85, 7},
    })
end

-- https://www.wowhead.com/spell=73629#comments:id=1070398
-- https://www.wowhead.com/spell=73630#comments:id=2552506
-- The Lightforged comment predates their separate racial mount; use ordinary Draenei.
for _, mount in ipairs({ {73629, "Exarch's Elekk"}, {73630, "Great Exarch's Elekk"} }) do
    add(mount[1], mount[2], nil, {
        category = "Class", source = "Draenei Paladin racial mount", faction = "Alliance", automaticUnlock = true,
        description = "The ordinary Draenei Paladin's automatically learned elekk, separate from reputation-vendor elekks.",
        difficulty = "easy", difficultyReason = "Level an ordinary Draenei Paladin through its riding progression.",
        cost = "No mount purchase", requirements = "Draenei Paladin",
        tips = "Old level-20/40 trainer instructions predate Retail's level and riding changes. Lightforged Draenei have their own racial Paladin mount; do not use the old Lightforged shortcut for these entries.",
        sourceComments = {1070398, 1486382, 2552506, 1938216},
        steps = {
            "Create or log into an ordinary Draenei Paladin. Open Collections > Mounts and search for Exarch's Elekk and Great Exarch's Elekk; these are class mounts, not the grey or purple elekks sold by a racial mount vendor.",
            "Finish the character's introduction and progress through the ground-riding levels. On an existing or boosted Paladin, check the journal first: Retail learns racial Paladin mounts automatically rather than requiring the original Charger quest or an Exodar purchase.",
            "Check both the plain and armored elekk entries as you progress, and summon the one you want from the eligible Paladin. Other races and classes do not gain permission to ride it merely because the account has a Draenei Paladin.",
        },
        areaMaps = {97, 84},
    })
end

-- https://www.wowhead.com/item=62461#comments:id=5264554
-- https://www.wowhead.com/item=62462#comments:id=5264555
-- https://www.wowhead.com/npc=48510#comments:id=5264557
-- Replies 1516711/1537153 correct the old 36.2,86.6 location.
for _, mount in ipairs({ {87090, "Goblin Trike", 62461, "1 gold"}, {87091, "Goblin Turbo-Trike", 62462, "10 gold"} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Vendor", source = "Kall Worthaton - Orgrimmar Embassy", npcId = 48510, faction = "Horde",
        description = "A Goblin racial mount sold beside the Orgrimmar Embassy. A Goblin character avoids the non-Goblin reputation grind.",
        difficulty = "easy", difficultyReason = "A Goblin can buy the mount directly for a small amount of gold.",
        cost = mount[4] .. " before discounts", requirements = "Goblin, or a Horde character Exalted with Bilgewater Cartel",
        tips = "Kall is beside the Embassy at 38.1,78.0. Use his current Embassy location rather than the older Goblin Slums location.",
        sourceComments = {5264554, 5264555, 5264557, 3207614}, sourceReplyIds = {1516711, 1537153, 1772611, 1854724},
        steps = {
            "Use a Goblin character with access to Orgrimmar. The numbered Wowhead route uses a Goblin Mage Class Trial, if available, to arrive quickly. Bring enough gold for the key; buying both trikes costs at most 11 gold before discounts.",
            "Go to Kall Worthaton beside the Orgrimmar Embassy, around 38.1,78.0. Approach from the Valley of Spirits side and look for the Goblin trike dealer outside the Embassy building.",
            "Buy the matching Goblin Trike Key or Goblin Turbo-Trike Key and use it from your bags. Check Collections > Mounts on your other Horde characters after learning it.",
            "If buying on a non-Goblin instead, first reach Exalted with Bilgewater Cartel. Buy its tabard from Frizzo Villamar beside the Orgrimmar flight master, wear it in eligible reputation-granting dungeons, and check the reputation bar after a kill before committing to repeated clears. Return to Kall when Exalted.",
        },
        waypoints = {
            pin(85, 38.1, 78.0, 2, "Kall Worthaton - trike dealer", "Orgrimmar"),
            pin(85, 49.8, 58.6, 4, "Frizzo Villamar - optional Bilgewater Cartel tabard", "Orgrimmar"),
        },
    })
end

-- https://www.wowhead.com/npc=55285#comments:id=5848731
-- https://www.wowhead.com/item=73839#comments:id=6003596
-- Expanded replies distinguish Class Trial phasing problems from removal.
for _, mount in ipairs({ {103195, "Mountain Horse", 73838, "1 gold"}, {103196, "Swift Mountain Horse", 73839, "10 gold"} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Vendor", source = "Astrid Langstrump - accessible Darnassus phase or Stormwind refugee camp", npcId = 55285, faction = "Alliance",
        description = "A Gilnean racial horse. Astrid's Darnassus shop remains accessible in Retail through Darkshore's pre-burning phase.",
        difficulty = "medium", difficultyReason = "Meet Gilneas reputation requirements and reach Astrid in the correct world phase.",
        cost = mount[4] .. " before reputation discounts", requirements = "Alliance; Gilneas reputation required by the vendor",
        tips = "Exalted with Gilneas is the reliable purchase route, including for characters whose Worgen race change did not satisfy the vendor. Do not assume a Class Trial can switch Darkshore's phase.",
        sourceComments = {1529139, 1597490, 1963131, 5756887, 6003596, 2586874, 5848731, 6357422},
        sourceReplyIds = {1680572, 1750265, 1765849},
        steps = {
            "Use an Alliance character and check Gilneas reputation. Ordinary non-Worgen need Exalted. Worgen reports differ by starting history and race changes, so if Astrid refuses to sell, build Gilneas reputation rather than assuming the horse was removed.",
            "If reputation is needed, buy the Gilneas Tabard from Lord Candren at Stormwind's refugee area or in pre-burning Darnassus. Wear it in eligible dungeons and check that kills grant Gilneas reputation; repeat until the vendor's requirement is satisfied.",
            "Check Astrid Langstrump at the Wollerton Stead refugee area in northern Stormwind, around 52.4,7.9. She is present only in applicable phases. If she is missing, use the following Darnassus route on a normal character.",
            "Travel to Zidormi in Darkshore, around 48.9,24.4, and ask to see Darkshore before the burning. Fly west to Teldrassil and enter Darnassus. This is a usable Retail time-travel phase; burned Darnassus has no functioning shop.",
            "Find Astrid beside the Howling Oak at about 48.4,21.8 in Darnassus. Buy Mountain Horse or Swift Mountain Horse, use the item, and check the Mount Journal. You can buy the second horse during the same visit if it is also missing.",
        },
        waypoints = {
            pin(84, 56.4, 13.5, 2, "Lord Candren - Gilneas tabard, refugee phase", "Stormwind City"),
            pin(89, 37.1, 47.5, 2, "Lord Candren - Gilneas tabard, pre-burning phase", "Darnassus"),
            pin(84, 52.4, 7.9, 3, "Astrid Langstrump - check refugee phase", "Stormwind City"),
            pin(62, 48.9, 24.4, 4, "Zidormi - choose pre-burning Darkshore", "Darkshore"),
            pin(89, 48.4, 21.8, 5, "Astrid Langstrump - pre-burning Darnassus", "Darnassus"),
        },
    })
end

-- https://www.wowhead.com/item=60954#comments:id=6094907
-- The profit-ending 2025 route omits the Lorewalkers gate and uses an old
-- crate skill threshold. Reconciled with 2344221, 5283094 and 5788460.
add(84751, "Fossilized Raptor", 60954, {
    category = "Professions", source = "Fossil Archaeology rare project",
    description = "Discover the Fossilized Raptor project, then solve it with 100 Fossil fragments. It is not a creature drop or a purchased mount.",
    difficulty = "medium", difficultyReason = "Level Archaeology and repeat random Fossil projects; there is no guaranteed discovery count.",
    cost = "100 Fossil fragments once discovered", requirements = "Archaeology on the character doing the solves",
    tips = "Fossil has no keystones. Solving common projects advances the discovery queue; hoarding fragments without solving does not reveal the mount. Crate purchases require Archaeology 600.",
    sourceComments = {6094907, 2344221, 5283094, 5788460, 1231901}, sourceReplyIds = {1766715, 1594253},
    steps = {
        "Learn Archaeology from Harrison Jones in Stormwind Keep (85.7,25.9) or Belloc Brightblade in Orgrimmar (49.0,70.6). Open the Archaeology window and enable dig sites on the world map.",
        "For the direct route, survey Fossil sites in Eastern Kingdoms or Kalimdor. Use Survey inside the marked dig-site boundary, follow its direction indicator, and move shorter distances as it changes from red to yellow to green. Finish other sites when necessary to generate new Fossil sites; the locations rotate.",
        "Solve the currently offered Fossil project whenever you have enough fragments. Continue until Fossilized Raptor appears, collect the 100 fragments it requests, solve it and use the completed mount item.",
        "To use fragment crates instead of searching for continental Fossil sites, first raise Archaeology to 600. Broken Isles archaeology can provide skill and Restored Artifacts, but its active excavation zone rotates; Azsuna is not permanently available. Pandaria and other expansion solves that can be crated are alternatives.",
        "To focus Pandaria sites, reach Exalted with the Lorewalkers and visit Brann Bronzebeard at the Seat of Knowledge above Mogu'shan Palace (83.5,31.0 in the Vale). Buy a Mantid Artifact Hunter's Kit for 2 Restored Artifacts, open it when ready to dig and use its Lorewalker's Map with the Sonic Locator effect active.",
        "Survey the resulting Mantid sites in Townlong Steppes and Dread Wastes. Solve common Mantid artifacts and turn the completed objects into Restored Artifacts. Return to Brann and exchange these for Crates of Fossil Archaeology Fragments, not Tol'vir or Troll crates.",
        "Open the Fossil crates and keep solving Fossil projects as in step 3. The final project can appear early or after many solves. Neither the Mantid route nor reaching maximum skill guarantees the next project will be the mount.",
    },
    waypoints = {
        pin(84, 85.7, 25.9, 1, "Harrison Jones - Alliance Archaeology trainer", "Stormwind City"),
        pin(85, 49.0, 70.6, 1, "Belloc Brightblade - Horde Archaeology trainer", "Orgrimmar"),
        pin(390, 83.5, 31.0, 5, "Seat of Knowledge - Brann, kit and fragment exchanges", "Vale of Eternal Blossoms"),
        pin(390, 83.5, 31.0, 6, "Brann - buy Fossil fragment crates", "Vale of Eternal Blossoms"),
    },
    areaMaps = {13, 12, 619, 388, 422},
})

-- https://www.wowhead.com/item=64883#comments:id=5785398
-- https://www.wowhead.com/item=64883#comments:id=1640434
add(92155, "Ultramarine Qiraji Battle Tank", 64883, {
    category = "Professions", source = "Scepter of Azj'Aqir - Tol'vir Archaeology rare project",
    description = "An outdoor-usable qiraji mount discovered through Tol'vir Archaeology. Ordinary blue Ahn'Qiraj crystals do not unlock it.",
    difficulty = "hard", difficultyReason = "A very rare project after substantial Archaeology preparation can require hundreds of Tol'vir solves.",
    cost = "150 Tol'vir fragments; up to three Tol'vir Hieroglyphic keystones can reduce the fragment cost",
    requirements = "Archaeology; 450 skill for Uldum dig sites, 600 for fragment-crate exchanges",
    tips = "There is no required ring > pendant > mount order and no guaranteed solve number. Do not spend fragments on Troll or Fossil crates: this mount is a Tol'vir project.",
    sourceComments = {1132640, 1640434, 5785398, 5295889, 5564609, 6080847, 6134799},
    steps = {
        "Learn Archaeology and raise its skill. For direct Tol'vir fragments, reach 450 and survey the active Tol'vir dig sites in Uldum. Complete other Kalimdor dig sites when necessary to create more chances for Uldum sites.",
        "If Uldum is showing the N'Zoth assault, speak to Zidormi near Ramkahen (56.0,35.1) to use the earlier Uldum phase for the original archaeology route. Dig-site boundaries rotate; a static pin cannot stand in for your active dig-site map.",
        "For the more consistent crate route, reach Archaeology 600 and Lorewalkers Exalted. Go to the Seat of Knowledge above Mogu'shan Palace (83.5,31.0 in the Vale), buy Brann's Mantid Artifact Hunter's Kit for 2 Restored Artifacts and use the map included in it while its locator is active.",
        "Survey Mantid sites in Townlong Steppes and Dread Wastes, solve the common artifacts and crate those completed objects into Restored Artifacts. The locator lasts 24 real-time hours; obtain another kit when its effect expires if you want to continue that route.",
        "Return to Brann and buy Crates of Tol'vir Archaeology Fragments with the Restored Artifacts. Open the crates, solve the current Tol'vir project, and repeat. Optional Tol'vir Hieroglyphics speed up solves that offer keystone sockets, but buying them does not improve the chance of discovering the Scepter.",
        "When Scepter of Azj'Aqir becomes the current project, complete its 150-fragment requirement, using up to three keystones if desired. Solve it, use the Scepter from your bags and check Ultramarine Qiraji Battle Tank in the Mount Journal.",
    },
    waypoints = {
        pin(84, 85.7, 25.9, 1, "Harrison Jones - Archaeology trainer", "Stormwind City"),
        pin(85, 49.0, 70.6, 1, "Belloc Brightblade - Archaeology trainer", "Orgrimmar"),
        pin(249, 56.0, 35.1, 2, "Zidormi - earlier Uldum phase", "Uldum"),
        pin(390, 83.5, 31.0, 3, "Seat of Knowledge - Mantid kit", "Vale of Eternal Blossoms"),
        pin(390, 83.5, 31.0, 5, "Brann - Tol'vir fragment crates", "Vale of Eternal Blossoms"),
    },
    areaMaps = {249, 388, 422},
})

-- https://www.wowhead.com/item=63045#comments:id=1248296 and replies.
-- Profit comment 1495930 is a costume joke beginning AFTER getting the camel.
for _, mount in ipairs({ {88748, "Brown Riding Camel", 63044}, {88749, "Tan Riding Camel", 63045} }) do
    add(mount[1], mount[2], mount[3], {
        category = "Reputation", source = "Blacksmith Abasi - Ramkahen Exalted", npcId = 48617,
        description = "A guaranteed Ramkahen reputation purchase, separate from Dormus's rare Grey Riding Camel.",
        difficulty = "medium", difficultyReason = "Quest to unlock the tabard, then earn Exalted reputation and buy the camel.",
        cost = "100 gold base price; normally 80 gold with the Exalted discount", requirements = "Exalted with Ramkahen",
        tips = "You need Exalted to buy the camels even if they are visible in Abasi's shop earlier. Use the original Ramkahen faction, not BfA's Uldum Accord. Both camel colors share the same reputation.",
        sourceComments = {1492915, 1137344, 1152612, 1248296, 1268177}, sourceReplyIds = {206434, 550986},
        steps = {
            "Travel to Ramkahen in Uldum. If the zone is in the N'Zoth assault phase, use Zidormi near 56.0,35.1 to enter the earlier Uldum. Follow the original Uldum introduction and Ramkahen quests until you can buy the faction tabard at Friendly.",
            "Find Blacksmith Abasi at 54.0,33.2 in Ramkahen and buy the Tabard of Ramkahen. Equip it before entering original Cataclysm dungeons. Lost City of the Tol'vir is nearby and offers a repeatable Normal route; check that kills actually increase Ramkahen reputation.",
            "Clear reputation-granting enemies and bosses, leave the dungeon, reset it and repeat within the instance-entry limit. Keep the tabard equipped. Original Ramkahen quest rewards and unlocked daily quests can supplement the dungeon reputation.",
            "At Exalted, return to Abasi and buy the correct color of camel. If it was absent from his shop earlier, reopen the vendor window now. Use the reins to learn the mount; buy the other color on the same visit if needed.",
        },
        waypoints = {
            pin(249, 56.0, 35.1, 1, "Zidormi - original Uldum phase", "Uldum"),
            pin(249, 54.0, 33.2, 2, "Blacksmith Abasi - Ramkahen tabard", "Uldum"),
            pin(249, 60.5, 64.4, 3, "Lost City of the Tol'vir - Normal reputation route", "Uldum"),
            pin(249, 54.0, 33.2, 4, "Blacksmith Abasi - buy the camel at Exalted", "Uldum"),
        },
    })
end

-- https://www.wowhead.com/quest=25371#comments:id=1212796
-- https://www.wowhead.com/quest=25371#comments:id=6016487
add(75207, "Vashj'ir Seahorse", 54465, {
    category = "Quest Rewards", source = "The Abyssal Ride - Moanah Stormhoof", npcId = 41248,
    description = "Complete the opening Kelp'thar Forest campaign and tame a seahorse with the quest's vehicle controls.",
    difficulty = "easy", difficultyReason = "A short introductory quest chain and a guided riding minigame give a guaranteed reward.",
    cost = "No purchase", requirements = "Vashj'ir introduction on the character using the mount",
    tips = "This character-specific quest mount works in Vashj'ir. It is different from the tradable Reins of Poseidus. If the journal does not show it after completion, try /cast Vashj'ir Seahorse on that character.",
    sourceComments = {1112514, 1211259, 1212796, 2539730, 2506374, 6016487},
    steps = {
        "Start the original Vashj'ir introduction. Alliance can take Call of Duty from Recruiter Burns at Stormwind Harbor (27.4,24.5). Horde follows Warchief's Command: Vashj'ir! to Commander Thorak at Bladefist Bay (55.8,12.2 in Durotar). Board the quest ship and let the shipwreck sequence finish.",
        "Complete Sea Legs with Erunak Stonespeaker, then the opening survival and shelter quests in Kelp'thar Forest. Continue the quests from Erunak and the nearby survivors rather than swimming straight to the mount objective: the later quest giver is phased until this introduction advances.",
        "Find Moanah Stormhoof at Shallow's End, around 46.0,46.8. Complete Better Late Than Dead and Sea-Food Chain when offered, then accept The Abyssal Ride. If she has no quests, finish the outstanding opening-hub quests first.",
        "Dismiss a summoned companion pet if the lure fails to appear. Click the coil of rope beside Moanah at the edge of the drop, select its lure interaction once, then approach and mount the seahorse that swims to it. Repeatedly clicking the rope can interrupt the setup.",
        "During the ride, use the quest's three arrow buttons or their displayed action-bar bindings, normally 1, 2 and 3. Follow each on-screen lean or grip prompt when it appears; ordinary movement keys do not operate those vehicle actions. If thrown off, return and try the rope again.",
        "Turn in The Abyssal Ride and learn the seahorse reward if an item is provided. Summon it in Vashj'ir on the character that completed the chain. Other characters must do their own introduction and mount quest.",
    },
    waypoints = {
        pin(84, 27.4, 24.5, 1, "Recruiter Burns - Alliance Call of Duty", "Stormwind City"),
        pin(1, 55.8, 12.2, 1, "Commander Thorak - Horde Vashj'ir departure", "Durotar"),
        pin(201, 45.1, 23.5, 2, "Erunak Stonespeaker - opening Sea Legs phase", "Kelp'thar Forest"),
        pin(201, 46.0, 46.8, 3, "Moanah Stormhoof - The Abyssal Ride", "Kelp'thar Forest"),
        pin(201, 46.0, 46.8, 4, "Rope beside Moanah - lure the seahorse", "Kelp'thar Forest"),
    },
})

-- https://www.wowhead.com/item=65891#comments:id=1411544
-- https://www.wowhead.com/item=65891#comments:id=3194115
-- https://www.wowhead.com/item=65891#comments:id=5450158
add(93326, "Sandstone Drake", 65891, {
    category = "Professions", source = "Vial of the Sands - Auction House or Cataclysm Alchemy",
    description = "Use a tradable Vial of the Sands to become a drake that can carry a party member. The buyer needs no profession.",
    difficulty = "medium", difficultyReason = "Buying the finished vial is straightforward but costly; discovering and crafting it yourself is a long random profession route.",
    cost = "Auction House price, or crafting materials plus 29,000 gold base vendor reagents",
    requirements = "No profession to learn; Cataclysm Alchemy 75 and the discovered recipe to craft",
    tips = "The recipe is bound to the Alchemist who discovers it, while the completed vial is tradable. The old generic Alchemy 525 requirement became Cataclysm Alchemy 75. Compare a finished vial with the total material cost first.",
    sourceComments = {1411544, 3194115, 5366991, 5450158, 2612558}, sourceReplyIds = {507506, 1855197},
    steps = {
        "For the direct route, search the Auction House for Vial of the Sands, buy the finished item and use it. You do not need Alchemy or Archaeology, and riding as another player's passenger does not teach your own mount.",
        "For the self-crafted route, learn Cataclysm Alchemy on the character doing Archaeology and raise it to 75 for crafting. Level Archaeology far enough for Tol'vir projects. The recipe can be discovered only by an eligible Alchemist opening Canopic Jars; another character cannot mail you its bound recipe.",
        "Obtain Tol'vir fragments from original Uldum dig sites, or at Archaeology 600 exchange Restored Artifacts for Tol'vir fragment crates at Brann Bronzebeard in the Seat of Knowledge (83.5,31.0 in the Vale). Solve Tol'vir projects until Canopic Jar is offered, solve it and open the jar. Repeat until Recipe: Vial of the Sands appears. A jar is not guaranteed to contain it.",
        "Gather 12 Truegold, 8 Flasks of the Winds, 8 Flasks of Titanic Strength and 8 Deepstone Oil. Buy these from the Auction House or make them with the appropriate Cataclysm recipes. A crafter who already knows the recipe can also turn your materials into a finished tradable vial.",
        "Buy 1 Pyrium-Laced Crystalline Vial and 8 Sands of Time from Yasmin at 26.6,7.2 in northwestern Uldum. In original Uldum they total 29,000 gold at base price. The assault-era Yasmin uses Uldum Accord reputation discounts, bringing that vendor portion to 23,200 gold at Exalted; select the correct phase with Zidormi near Ramkahen.",
        "Craft Vial of the Sands or receive the completed vial from your crafter, then use it. Summon Sandstone Drake from the journal. Invite your passenger to your party and let them interact with you after you transform.",
    },
    waypoints = {
        pin(390, 83.5, 31.0, 3, "Brann - optional Tol'vir fragment-crate route", "Vale of Eternal Blossoms"),
        pin(249, 56.0, 35.1, 5, "Zidormi - choose the required Uldum phase", "Uldum"),
        pin(249, 26.6, 7.2, 5, "Yasmin - original-phase vendor reagents", "Uldum"),
        pin(1527, 26.6, 7.2, 5, "Yasmin - Uldum Accord discount alternative", "Uldum (N'Zoth Assault)"),
    },
})

-- https://www.wowhead.com/item=67151#comments:id=2531604
-- https://www.wowhead.com/item=67151#comments:id=2552764
add(98718, "Subdued Seahorse", 67151, {
    category = "Rare Drops", source = "Reins of Poseidus - Auction House or Poseidus in Vashj'ir", npcId = 50005,
    description = "The tradable Reins of Poseidus teach an aquatic mount usable in suitable deep water outside Vashj'ir too.",
    difficulty = "easy", difficultyReason = "The finished reins can be bought directly; finding Poseidus yourself involves a contested rare-spawn search.",
    cost = "Auction House price, or no gold cost when looted", requirements = "A normal character for the rare-drop route",
    tips = "Use the exact item name Reins of Poseidus in the Auction House. Old 72-120-hour respawn instructions predate the greatly shortened timer. Class Trials are restricted from this valuable rare drop.",
    sourceComments = {1765312, 2531604, 2534859, 2552764, 2857758, 3293407},
    steps = {
        "For a direct unlock, buy Reins of Poseidus from the Auction House and use them. Search the journal for Subdued Seahorse, and use it in sufficiently deep water. The Vashj'ir quest seahorse is a separate character-specific reward.",
        "To farm instead, use a normal character and travel to Vashj'ir. Completing Sea Legs and The Abyssal Ride in Kelp'thar Forest first supplies underwater travel tools and makes moving between the spawn areas much easier.",
        "Patrol the four Shimmering Expanse points: 66.6,41.4; 58.4,82.2; 46.6,50.0; and 40.0,67.8. Search underwater around each marked point, using /target Poseidus or a rare alert while moving between them.",
        "Also check the fifth spawn in Abyssal Depths at about 41.4,76.3. It is on a different map; checking only Shimmering Expanse misses this possible location. Return for later patrols if all five areas are empty.",
        "Defeat Poseidus, loot Reins of Poseidus and use them. The reins remain tradable until learned. Avoid relying on old group-loot or Class Trial farming instructions, and finish looting before changing realm or phase.",
    },
    waypoints = {
        pin(201, 46.0, 46.8, 2, "Moanah - optional Vashj'ir travel-mount unlock", "Kelp'thar Forest"),
        pin(205, 66.6, 41.4, 3, "Poseidus - northeast spawn area", "Shimmering Expanse"),
        pin(205, 58.4, 82.2, 3, "Poseidus - southeast spawn area", "Shimmering Expanse"),
        pin(205, 46.6, 50.0, 3, "Poseidus - central spawn area", "Shimmering Expanse"),
        pin(205, 40.0, 67.8, 3, "Poseidus - southwest spawn area", "Shimmering Expanse"),
        pin(204, 41.4, 76.3, 4, "Poseidus - Abyssal Depths spawn area", "Abyssal Depths"),
    },
})

-- https://www.wowhead.com/item=63040#comments:id=1242687
-- https://www.wowhead.com/item=63040#comments:id=1812294
add(88742, "Drake of the North Wind", 63040, {
    category = "Dungeon and Raids", source = "Altairus - original The Vortex Pinnacle", npcId = 43873,
    description = "A rare drop from the second boss. Normal difficulty permits repeated attempts within the instance-entry limit.",
    difficulty = "medium", difficultyReason = "The route is short and repeatable, but the drop is random and may take many clears.",
    cost = "No purchase", requirements = "Original Vortex Pinnacle, Normal or Heroic",
    tips = "Use Normal for repeat farming. Heroic has a daily loot limit. The mount is not guaranteed by a number of kills, and a past Collector's Bounty event is not a permanent drop-rate increase.",
    sourceComments = {1242687, 1812294, 2023899, 2183800, 1958581}, sourceReplyIds = {833598, 853140},
    steps = {
        "Travel to southeastern Uldum and fly up to The Vortex Pinnacle entrance on the floating platform at 76.8,84.4. Set Dungeon Difficulty to Normal before entering the original dungeon.",
        "Follow the platform path, kill Grand Vizier Ertan and use the slipstream to the next section. Clear anything keeping you in combat and continue along the wind platforms to Altairus, the second boss.",
        "Defeat Altairus and loot his corpse. Reins of the Drake of the North Wind can drop on Normal as well as Heroic; there is no need to kill Asaad just for this mount.",
        "After looting, jump off the platform. The dungeon's rescue wind returns you to its entrance. Walk out, right-click your portrait, choose Reset All Instances and enter again on Normal.",
        "Repeat until the reins drop or the rolling instance-entry limit stops further entries. Wait for that limit to clear, then resume. If doing a Heroic attempt instead, do not expect resetting it to restore that character's daily boss loot.",
    },
    waypoints = {
        pin(249, 76.8, 84.4, 1, "The Vortex Pinnacle - floating entrance", "Uldum"),
        pin(325, 51.9, 82.1, 3, "Altairus - second boss", "The Vortex Pinnacle"),
    },
})

-- https://www.wowhead.com/item=63043#comments:id=2070292
-- https://www.wowhead.com/item=63043#comments:id=5562796
-- https://www.wowhead.com/item=63043#comments:id=5774991
add(88746, "Vitreous Stone Drake", 63043, {
    category = "Dungeon and Raids", source = "Slabhide - The Stonecore", npcId = 43214,
    description = "A rare drop from Stonecore's second boss, farmable repeatedly on Normal.",
    difficulty = "medium", difficultyReason = "A short repeatable dungeon route, with an unpredictable number of attempts.",
    cost = "No purchase", requirements = "The Stonecore, Normal or Heroic",
    tips = "Advance Millhouse's scripted trash sequence; merely running past him can leave the route blocked. Corborus itself can be skipped after that sequence, but killing it avoids stuck-combat problems.",
    sourceComments = {2070292, 2020303, 2562262, 3125732, 5562796, 5774991, 6084120},
    steps = {
        "Reach Deepholm and fly to The Stonecore entrance on the Temple of Earth's outer wall at 47.5,52.1. Set Dungeon Difficulty to Normal before entering for repeatable mount attempts.",
        "Clear the opening packs and damage Millhouse Manastorm until he retreats. Follow and repeat at his next positions until Corborus bursts through and opens the way. Do not attack the last pack while Corborus is sweeping it away, as the comments report this can leave you stuck in combat.",
        "Kill Corborus if it or nearby enemies keep you in combat, then follow the tunnel through the rockfall area. Wait for Slabhide to land in the next cavern, defeat him and loot his corpse for the reins.",
        "When out of combat, use the teleporter just beyond Slabhide to return to the entrance. Walk outside, choose Reset All Instances from your portrait and repeat on Normal. You can stop after Slabhide; the final two bosses are unnecessary for the mount.",
        "Observe the rolling instance-entry limit. Heroic is also eligible for the mount but its boss loot resets daily, so Normal is the practical choice for consecutive runs. Use the reins when they finally drop.",
    },
    waypoints = {
        pin(207, 47.5, 52.1, 1, "The Stonecore - entrance on the temple wall", "Deepholm"),
        pin(324, 37.0, 44.7, 3, "Slabhide - second boss", "The Stonecore"),
    },
})

-- https://www.wowhead.com/item=68823#comments:id=1829461
-- https://www.wowhead.com/item=68823#comments:id=6141825
add(96491, "Armored Razzashi Raptor", 68823, {
    category = "Dungeon and Raids", source = "Bloodlord Mandokir - Heroic Zul'Gurub", npcId = 52151,
    description = "A rare daily dungeon drop. This is the Cataclysm raptor, distinct from the removed Swift Razzashi Raptor.",
    difficulty = "hard", difficultyReason = "An easy legacy boss, but only one eligible Heroic loot attempt per character per day.",
    cost = "No purchase", requirements = "Heroic Zul'Gurub",
    tips = "The original raid is gone, but the current Heroic dungeon and this mount remain. The Adventure Guide's Normal listing does not give unlimited repeatable mount runs.",
    sourceComments = {1780893, 1816904, 1829461, 3229396, 6141825},
    steps = {
        "Travel to the Zul'Gurub portal at 72.1,32.9 in Northern Stranglethorn. Set Dungeon Difficulty to Heroic before entering. The old raid's removed mount is a different item.",
        "From the entrance take the route toward Mandokir in the southeastern part of the dungeon. Cross the rope bridge, climb the boulder path and kill the boulder thrower if needed to clear the approach. Other boss kills are not a prerequisite for reaching Mandokir.",
        "Enter Bloodlord Mandokir's courtyard, defeat him and loot his body. At high level you can kill him directly; obsolete guides requiring Snake Trap or immunity tricks for solo Decapitate are unnecessary.",
        "If the raptor is absent, continue to High Priestess Kilnara for the separate panther mount before leaving. Return after the next daily reset, or use another eligible character. Resetting the dungeon does not renew Heroic boss loot on the same character that day.",
        "Use Armored Razzashi Raptor when it drops. Park characters outside the portal between attempts if you want to avoid repeating the journey.",
    },
    waypoints = {
        pin(50, 72.1, 32.9, 1, "Zul'Gurub - Heroic dungeon entrance", "Northern Stranglethorn"),
        pin(337, 60.4, 79.9, 3, "Bloodlord Mandokir - raptor drop", "Zul'Gurub"),
        pin(337, 48.0, 20.0, 4, "High Priestess Kilnara - optional panther attempt", "Zul'Gurub"),
    },
})

-- https://www.wowhead.com/item=68824#comments:id=3187062
-- Reply 1516578 to 5159432 corrects the parent's false Normal-mode claim.
add(96499, "Swift Zulian Panther", 68824, {
    category = "Dungeon and Raids", source = "High Priestess Kilnara - Heroic Zul'Gurub", npcId = 52059,
    description = "A rare daily drop from Kilnara in the Cataclysm dungeon, separate from the removed Swift Zulian Tiger.",
    difficulty = "hard", difficultyReason = "Repeated daily Heroic attempts may be needed for a rare drop.",
    cost = "No purchase", requirements = "Heroic Zul'Gurub",
    tips = "Kilnara can drop the mount when killed immediately; waiting for her panther transformation is unnecessary. Use Heroic despite misleading Normal loot listings.",
    sourceComments = {3187062, 5159432, 5385903, 6141826}, sourceReplyIds = {1516578},
    steps = {
        "Go to Zul'Gurub at 72.1,32.9 in Northern Stranglethorn and set Dungeon Difficulty to Heroic. Enter the current five-player dungeon, not an attempt to reach the removed original raid.",
        "Head toward Kilnara's temple in the northwestern part of the instance. The left route from the entrance and the waterfall crossing lead toward her building. Clear any enemies keeping you in combat, then descend the temple stairs to the boss chamber.",
        "Defeat High Priestess Kilnara and loot her corpse. You can kill her immediately at high level; allowing a transformation or deliberately waking every panther does not improve the mount chance.",
        "If also missing Armored Razzashi Raptor, visit Bloodlord Mandokir in the southeastern courtyard before leaving. Neither mount requires defeating Jin'do, and this panther does not drop from him.",
        "Return after the daily reset or repeat on other eligible characters. The same character cannot obtain fresh Heroic loot by resetting immediately. Use the panther item when it drops.",
    },
    waypoints = {
        pin(50, 72.1, 32.9, 1, "Zul'Gurub - Heroic dungeon entrance", "Northern Stranglethorn"),
        pin(337, 48.0, 20.0, 3, "High Priestess Kilnara - panther drop", "Zul'Gurub"),
        pin(337, 60.4, 79.9, 4, "Bloodlord Mandokir - optional raptor attempt", "Zul'Gurub"),
    },
})

-- https://www.wowhead.com/item=69747#comments:id=2295418
-- https://www.wowhead.com/item=69747#comments:id=2585568
-- Full thread 5303360 corrects Zul'jin to Vol'jin. Midnight access is via
-- Zidormi at Thalassian Pass, not the new outdoor Zul'Aman quest zone.
add(98204, "Amani Battle Bear", 69747, {
    category = "Dungeon and Raids", source = "Fourth hostage's reward - timed Heroic Zul'Aman rescue",
    description = "A guaranteed rescue-event reward for saving the first four boss captives in time; it is not a random Halazzi drop.",
    difficulty = "easy", difficultyReason = "At high level the timed route is generous and the successful rescue guarantees one bear.",
    cost = "No purchase", requirements = "Heroic Zul'Aman; rescue all four captives before the timer expires",
    tips = "Use the legacy Ghostlands dungeon. Midnight's outdoor Zul'Aman and its new dungeons are different content. Only one bear is awarded per successful run, so a group shares that copy.",
    sourceComments = {1404342, 2043154, 2295418, 2373952, 2585568, 5303360, 5769791, 6357819},
    sourceReplyIds = {1562119, 1620362, 1554959, 1555890},
    steps = {
        "For Midnight-era access, go to Zidormi at the Thalassian Pass border in northern Eastern Plaguelands (53.8,8.7). Choose the Burning Crusade-era Quel'Thalas and enter the legacy Ghostlands. This retained Retail phase contains the old Zul'Aman dungeon.",
        "Travel to the Zul'Aman dungeon portal in southeastern Ghostlands, around 81.5,64.4, and set Dungeon Difficulty to Heroic. Inside, approach the closed gate, speak to Vol'jin and help with the gong. Click once and let its interaction finish instead of moving and cancelling it.",
        "When the gate opens and the rescue timer starts, go directly to Akil'zon in the northwest. Defeat him and release the nearby captive. Continue to Nalorakk in the southwest, defeat him and release his captive. These early kills add time to the initial 15-minute timer.",
        "Go to Jan'alai in the southeast, defeat him and release the third captive. Keep moving and avoid unnecessary side bosses. You can mount between pulls; the event needs these four animal bosses rather than a full dungeon clear.",
        "Kill Halazzi in the northeastern temple last, before the timer expires. Open Kasha's cage and follow her while she breaks the vases. Wait until her reward container appears, then click and loot it. The bear belongs to the fourth timely rescue, so if you used another boss order, inspect all four released prisoners' reward containers instead of assuming Kasha must always hold it.",
        "Loot and use Amani Battle Bear before leaving. In a group, agree who needs the rescue reward and check the actual loot rather than leaving after the boss kill. If you missed the timer, return on another eligible character or after the daily Heroic reset. The removed Amani War Bear is a different reward.",
    },
    waypoints = {
        pin(23, 53.8, 8.7, 1, "Zidormi - enter legacy Quel'Thalas", "Eastern Plaguelands"),
        pin(95, 81.5, 64.4, 2, "Zul'Aman - legacy Ghostlands Heroic entrance", "Ghostlands"),
        pin(333, 35.5, 23.0, 3, "Akil'zon - first rescue", "Zul'Aman"),
        pin(333, 40.5, 77.3, 3, "Nalorakk - second rescue", "Zul'Aman"),
        pin(333, 55.4, 70.9, 4, "Jan'alai - third rescue", "Zul'Aman"),
        pin(333, 58.4, 23.8, 5, "Halazzi and Kasha - final rescue", "Zul'Aman"),
        pin(333, 60.0, 17.0, 5, "Kasha's reward bag after breaking the vases", "Zul'Aman"),
    },
})

-- https://www.wowhead.com/item=103533/vicious-saddle
-- https://www.wowhead.com/achievement=5328/veteran-of-the-alliance
-- https://www.wowhead.com/item=70909 and item=70910 remain vendor rewards.
for _, mount in ipairs({
    {100332, "Vicious War Steed", 70909, "Alliance", "Necrolord Sipe", 73190, 84, 76.8, 65.5, "Stormwind City"},
    {100333, "Vicious War Wolf", 70910, "Horde", "Deathguard Netharian", 73151, 85, 41.9, 73.0, "Orgrimmar"},
}) do
    add(mount[1], mount[2], mount[3], {
        category = "PvP", source = mount[5] .. " - Vicious Saddle exchange", npcId = mount[6], faction = mount[4],
        description = "A legacy Vicious mount still sold for a Vicious Saddle. It is not a retired Gladiator season reward.",
        difficulty = "hard", difficultyReason = "Earning a saddle requires sustained wins in qualifying rated PvP, unless you already have one.",
        cost = "1 Vicious Saddle", requirements = "A Vicious Saddle and an eligible faction character",
        tips = "Veteran requires 75 rated battleground wins and Veteran II requires 150. The saddle vendor provides a direct modern route without earning an old Arena-season title.",
        sourceComments = {1439044, 2494254, 1928169},
        steps = {
            "Check your bags and bank for a Vicious Saddle. If you already have one, skip directly to the vendor. This mount is still obtainable even though its original Cataclysm-era introduction is old.",
            "To earn a new saddle, open the PvP pane's Rated section and inspect the seasonal Vicious mount progress bar. Play the rated brackets listed as eligible and reach the rating threshold shown there; qualifying wins, rather than ordinary random battleground wins, advance this reward.",
            "Fill the seasonal bar to receive that season's Vicious mount, then continue qualifying rated wins to fill the repeatable saddle bar. Claim a Vicious Saddle when that bar completes. You can stop as soon as you have one for this purchase.",
            "An alternative is progress through the Veteran rated-battleground achievements. The first milestone is 75 wins in the traditional rated battleground format; Rated Battleground Blitz does not count for that achievement according to current Retail reports. Check the current reward and your progress before choosing this longer route.",
            "Take 1 Vicious Saddle to " .. mount[5] .. " in " .. mount[10] .. " at " .. mount[8] .. "," .. mount[9] .. ". Select " .. mount[2] .. ", complete the exchange and use the mount item. Check the journal for the corresponding faction version before spending another saddle.",
        },
        waypoints = {pin(mount[7], mount[8], mount[9], 5, mount[5] .. " - Vicious Saddle mount exchange", mount[10])},
    })
end

-- https://www.wowhead.com/achievement=5866#comments:id=1472334
-- https://www.wowhead.com/item=69213#comments:id=1479435
-- Replies correct the lasher drop and explain that both factions are unlocked.
add(97359, "Flameward Hippogryph", 69213, {
    category = "Achievements", source = "The Molten Front Offensive - unlock the full daily campaign",
    description = "A guaranteed reward for completing the Molten Front's recruitment and support unlocks, including the lasher and Anren rescues.",
    difficulty = "medium", difficultyReason = "The quests are simple at high level, but Marks of the World Tree require weeks of daily resets.",
    cost = "20 opening Marks, 150 for each of two recruits and 125 for each of three final projects",
    requirements = "Mount Hyjal progression through Aessina's Miracle, then the Molten Front introduction",
    tips = "Do both recruitments and all three final projects. Choosing a daily faction is not a permanent choice. Save marks for unlocks rather than spending them at the reward vendors first.",
    sourceComments = {1472334, 1479435, 3154363, 6098780, 5917164, 6378540, 1466544, 1465257, 1474011},
    sourceReplyIds = {255398, 532182, 1643355, 1770260},
    steps = {
        "Enter the original Mount Hyjal campaign and quest through the regrowth storyline to Aessina's Miracle. Enable Trivial Quests. If NPCs vanish because you have an unfinished BfA Heart of Azeroth visit, finish the active A Fresh Trauma sequence before resuming Hyjal; do not start unrelated BfA prerequisites on a character without that phasing problem.",
        "At the Sanctuary of Malorne (about 27.1,62.5), take Guardians of Hyjal: Firelands Invasion! or the available Opening the Door follow-up. Complete the defense introduction and the offered sanctuary dailies. Save 20 Marks of the World Tree for Calling for Reinforcements, then follow the chain through the portal into the Molten Front.",
        "Complete the base dailies from Malfurion's Breach, then return to the Hyjal sanctuary for its daily quests as well. Keep both areas in your circuit; unlocking more quests increases your mark income. Save 150 Marks to recruit either the Shadow Wardens or the Druids of the Talon.",
        "After the first recruitment, finish that faction's daily route whenever available and save another 150 Marks to recruit the other group. Both are required. Once both are unlocked you choose which route to do that day, rather than completing both daily branches every day.",
        "After recruiting the Shadow Wardens, fight the ground-based Druids of the Flame in the Widow's Clutch near the solar core, around 70.4,38.4. These are the humanoid/shapeshifting druids, not the flying birds. Look for a Dried Acorn on the ground beside a killed druid. Pick up The Mysterious Seed, return it to Avrilla at Malfurion's Breach (50.4,87.0), then finish Planting Season and Little Lasher. The acorn is a ground object, not ordinary corpse loot.",
        "On a Druids of the Talon route, follow Into the Fire into the underground Molten Flow. Find the injured Anren Shadowseeker on rocks in the lava near 51.9,31.0, accept Need... Water... Badly... and escort him back to Thisalee Crow. This pin is underground: a surface quest marker does not mean he is standing above the cave. Finish the turn-in for Save Anren Shadowseeker.",
        "After both recruitment paths are unlocked, complete Calling the Ancients, Filling the Moonwell and Additional Armaments for 125 Marks each. Calling the Ancients first opens more daily income; follow each new quest marker and turn-in instead of stopping at the currency handover. All three projects are required.",
        "Open The Molten Front Offensive (5866) and check every criterion: sanctuary defense, entering the Front, both recruits, Little Lasher, Anren and the three projects. Finish any unchecked one on the character with that campaign progress. Check the Mount Journal for Flameward Hippogryph; if not learned automatically, also check Malfurion's reward mail.",
    },
    waypoints = {
        pin(198, 27.1, 62.5, 2, "Sanctuary of Malorne - daily campaign unlock", "Mount Hyjal"),
        pin(198, 27.6, 56.3, 3, "Molten Front portal - after the opening chain", "Mount Hyjal"),
        pin(338, 47.0, 90.7, 3, "Malfurion's Breach - daily and recruitment hub", "Molten Front"),
        pin(338, 70.4, 38.4, 5, "Ground-based Druids of the Flame - Dried Acorn quest area", "Molten Front"),
        pin(338, 50.4, 87.0, 5, "Avrilla - seed, Planting Season and Little Lasher", "Molten Front"),
        pin(338, 51.9, 31.0, 6, "Anren - UNDERGROUND Molten Flow, enter during Into the Fire", "Molten Front"),
        pin(338, 47.0, 90.7, 7, "Malfurion's Breach - final support projects", "Molten Front"),
    },
    areaMaps = {338},
})

-- https://www.wowhead.com/item=63041#comments:id=2098338
-- https://www.wowhead.com/item=63041#comments:id=5951357
-- Normal/Heroic and both sizes share this raid's weekly boss loot.
add(88744, "Drake of the South Wind", 63041, {
    category = "Dungeon and Raids", source = "Al'Akir - Throne of the Four Winds", npcId = 46753,
    description = "A rare Al'Akir mount drop. The raid has only the Conclave of Wind before him, making each weekly attempt short.",
    difficulty = "hard", difficultyReason = "The encounters are easy at high level, but the mount is a rare drop with weekly loot limits.",
    cost = "No purchase", requirements = "Flying access to the raid platform in Uldum",
    tips = "All four legacy size/difficulty combinations can drop it, but they do not provide four independent weekly attempts. Loot the floating reward crystal after Al'Akir dies.",
    sourceComments = {1219247, 1268748, 2098338, 5951357},
    steps = {
        "Travel to original Uldum. If necessary use Zidormi at 56.0,35.1 to leave the assault phase. Fly to the high floating platform over the southwest coast at 38.4,80.6. The entrance is Throne of the Four Winds, not the Vortex Pinnacle farther east.",
        "Choose a legacy Normal or Heroic raid difficulty before entering. On a high-level character, either raid size is sufficient; choosing 25-player does not create an additional weekly mount roll after a 10-player kill.",
        "Defeat Anshal, Nezir and Rohash on the three outer platforms. Use the wind bridges to move between them and kill the last two before the first finishes recovering. If one revives, finish the active bosses again within the recovery window.",
        "After the Conclave is dead, click the central wind funnel on an outer platform to reach Al'Akir. Defeat him; at the final transition the platform breaks and the encounter gives you flight.",
        "Fly to the floating Heart of Wind reward crystal near Al'Akir's center platform and open it. Check its loot for Reins of the Drake of the South Wind, then use the reins. His vanished body is not the reward container.",
        "If it does not drop, repeat after the weekly raid reset or on another eligible character. Check Raid Info before returning: changing Normal to Heroic or 10 to 25 does not refresh this character's Al'Akir loot.",
    },
    waypoints = {
        pin(249, 56.0, 35.1, 1, "Zidormi - original Uldum if needed", "Uldum"),
        pin(249, 38.4, 80.6, 1, "Throne of the Four Winds - airborne entrance", "Uldum"),
        pin(328, 47.5, 50.0, 4, "Al'Akir - central platform, then reward crystal", "Throne of the Four Winds"),
    },
})

-- https://www.wowhead.com/item=69224#comments:id=3204112
-- https://www.wowhead.com/item=71665 and the Alysrazor/Ragnaros NPC threads.
-- Firelands has separate Normal/Heroic loot after its Timewalking rework.
add(97493, "Pureblood Fire Hawk", 69224, {
    category = "Dungeon and Raids", source = "Ragnaros - Firelands", npcId = 52409,
    description = "Ragnaros can drop the Smoldering Egg of Millagazor on Normal or Heroic; using the egg teaches Pureblood Fire Hawk.",
    difficulty = "hard", difficultyReason = "A full raid route and a low drop chance can require many weekly attempts.",
    cost = "No purchase", requirements = "Reach Ragnaros in the legacy Firelands raid",
    tips = "The old guaranteed Heroic drop ended with Cataclysm. Retail Normal and Heroic Firelands have separate weekly loot; raid sizes do not add another pair of attempts.",
    sourceComments = {3204112, 6141846},
    steps = {
        "Fly to Firelands in southern Mount Hyjal at 47.2,78.1. Choose legacy Normal or Heroic before entering. Both can drop the mount; Heroic is no longer a guaranteed egg.",
        "Clear the entrance trash and the Molten Fields until Shannox appears. Kill Shannox and his hounds. Defeat Beth'tilac to the northwest, Lord Rhyolith to the northeast and Alysrazor in the eastern arena. Alysrazor is also a separate chance at Flametalon.",
        "At Beth'tilac, kill a hanging Cinderweb Spinner and use its web strand to climb to the canopy. Damage Beth'tilac and follow the transition back down, then finish her. At Rhyolith, attack a foot until his armor breaks, then kill his exposed body.",
        "Defeat Baleroc at the northern gate after the initial bosses. Cross the bridge into Sulfuron Keep and kill Majordomo Fandral Staghelm. Continue to Ragnaros at the far end of the keep.",
        "Defeat Ragnaros and loot the encounter's reward. On Normal he submerges at the end; open the resulting Cache of the Fire Lord. On Heroic finish the additional final phase and loot the reward there. Look for Smoldering Egg of Millagazor, not an item named Pureblood Fire Hawk.",
        "Use the egg if it drops. Otherwise leave, change to the other difficulty and clear its independent weekly lockout. Once both Normal and Heroic are looted, use another character or wait for the weekly reset; switching 10/25 does not create four attempts.",
    },
    waypoints = {
        pin(198, 47.2, 78.1, 1, "Firelands - raid entrance", "Mount Hyjal"),
        pin(367, 64.3, 38.0, 2, "Alysrazor - additional Flametalon chance", "Firelands"),
        pin(369, 50.7, 15.3, 5, "Ragnaros - Smoldering Egg of Millagazor", "Firelands - Sulfuron Keep"),
    },
})

add(101542, "Flametalon of Alysrazor", 71665, {
    category = "Dungeon and Raids", source = "Alysrazor - Firelands", npcId = 52530,
    description = "A rare ground mount from Alysrazor. You can target her without clearing all of Firelands.",
    difficulty = "hard", difficultyReason = "The short fight is simple, but a rare weekly drop may require many repeats.",
    cost = "No purchase", requirements = "Legacy Firelands on Normal or Heroic",
    tips = "This mount does not fly. Normal and Heroic each give a weekly loot chance; 10-player and 25-player do not provide four independent attempts.",
    sourceComments = {6141842}, sourceReplyIds = {1780684, 1780828, 1780991, 1781159},
    steps = {
        "Set legacy Raid Difficulty to Normal or Heroic and enter Firelands at Mount Hyjal 47.2,78.1. Both difficulties can drop Flametalon; use a high-level character for the legacy damage bonus.",
        "Head east through the Molten Fields toward the large Alysrazor arena, around 64.3,38.0 on the Firelands map. Clear the flame-bird trash and the enemies at its approach so the opening scene can run.",
        "Let Majordomo's scene finish and Alysrazor enter combat before attacking. Kill her when she is targetable and loot her body. Ranged attacks make it easier to finish her while she moves; you do not need to perform a full aerial-ring phase to earn the mount.",
        "Look for Flametalon of Alysrazor in the loot and use it if present. If farming both Firelands mounts, continue through the other bosses to Ragnaros instead of leaving immediately.",
        "Leave the instance, switch between Normal and Heroic and repeat on the second difficulty. After those two eligible clears, wait for the weekly reset or change character. Reset All Instances does not restore boss loot on a cleared weekly difficulty.",
    },
    waypoints = {
        pin(198, 47.2, 78.1, 1, "Firelands - raid entrance", "Mount Hyjal"),
        pin(367, 64.3, 38.0, 2, "Alysrazor - arena approach", "Firelands"),
        pin(367, 64.3, 38.0, 3, "Alysrazor - let the opening scene finish, then loot", "Firelands"),
    },
})

-- Shared route instructions are repeated in each mount's displayed guide.
-- https://www.wowhead.com/item=78919#comments:id=6142385 (and reply 1780640)
-- https://www.wowhead.com/item=77069#comments:id=6009740
-- https://www.wowhead.com/item=77067#comments:id=1559338
local dragonSoulApproach = "Travel to the Caverns of Time in Tanaris. The 64.4,50.0 outdoor pin marks the cave entrance: follow the tunnel down into the cavern and take the Dragon Soul raid portal in the northeast of the hub. This is a physical legacy raid run, not Raid Finder."
local dragonSoulToUltraxion = "Kill Morchok, then Warlord Zon'ozz and Yor'sahj. Use the Wyrmrest NPC transports and portals to reach Hagara in the Eye of Eternity and return to the temple summit afterward. Speak to Thrall and finish the Twilight drake defense; stay for the dialogue until Ultraxion actually engages."
local dragonSoulSpine = "For Spine, kill three Corruption tentacles and leave one alive. Stand in a tentacle hole with Grasping Tendrils while Deathwing rolls to throw away unwanted Amalgamations. Kill Corrupted Bloods, then drag one living Hideous Amalgamation across their residue until it has 9 stacks of Absorbed Blood. Heroic's revised encounter can give all 9 from one blood residue: inspect the add's stacks rather than waiting needlessly for nine bodies."
local dragonSoulPlate = "Move that 9-stack Amalgamation against the next armor plate and kill it there. Its Nuclear Blast lifts the plate; immediately kill the exposed Burning Tendon. Repeat for all three plates. Between planned rolls, move left and right to cancel the roll warning, or remain anchored in a tentacle hole. An unanchored roll throws you off and resets the encounter."
local dragonSoulMadness = "At the Maelstrom, speak to Thrall to begin Madness. Use the wind jumps to visit the four Aspect platforms, kill each platform's large limb and its Mutated Corruption, then return to the starting platform for Deathwing's head. Finish the encounter and open the final Greater Cache of the Aspects."

add(110039, "Experiment 12-B", 78919, {
    category = "Dungeon and Raids", source = "Ultraxion - Lesser Cache of the Aspects, Dragon Soul", npcId = 55294,
    description = "A rare mount from Ultraxion's reward chest, halfway through Dragon Soul. It is not a Deathwing drop.",
    difficulty = "hard", difficultyReason = "Dialogue and prerequisite bosses make each rare weekly drop attempt a longer run.",
    cost = "No purchase", requirements = "Legacy Normal or Heroic Dragon Soul; Raid Finder is ineligible",
    tips = "Normal/Heroic and 10/25 share weekly boss loot. Reports warn that killing Ultraxion before he properly engages can leave an unusable chest: wait for active combat before the killing hit.",
    sourceComments = {6009743, 6142385}, sourceReplyIds = {1780640},
    steps = {
        "Choose legacy Normal or Heroic before entering Dragon Soul. Heroic also gives access to Life-Binder's Handmaiden if you intend to finish the entire raid; there is still only one weekly loot chance at each boss on this character.",
        dragonSoulApproach,
        dragonSoulToUltraxion,
        "When Ultraxion is attackable, let him enter combat before dealing the killing blow. Defeat him, wait for the chest to appear on the temple summit and open the Lesser Cache of the Aspects. The mount is inside the chest rather than on a conventional corpse.",
        "Use Experiment 12-B if it drops. If you also want Blazing Drake or Life-Binder's Handmaiden, continue to the Skyfire, Warmaster Blackhorn, Spine and Madness. Otherwise return on the next weekly reset or use another eligible character; changing size or difficulty does not refresh Ultraxion's loot.",
    },
    waypoints = {
        pin(71, 64.4, 50.0, 2, "Caverns of Time - descend to the Dragon Soul portal", "Tanaris"),
        pin(409, 49.9, 45.7, 4, "Ultraxion - Wyrmrest summit and Lesser Cache", "Dragon Soul - Dragonblight"),
    },
})

for _, mount in ipairs({
    {107842, "Blazing Drake", 77067, false},
    {107845, "Life-Binder's Handmaiden", 77069, true},
}) do
    add(mount[1], mount[2], mount[3], {
        category = "Dungeon and Raids", source = (mount[4] and "Heroic " or "") .. "Madness of Deathwing - Dragon Soul", npcId = 56173,
        description = mount[4] and "A rare Heroic-only mount from the final Deathwing reward chest; it is no longer guaranteed."
            or "A rare mount from Normal or Heroic Madness of Deathwing; Heroic can also drop the Handmaiden on the same kill.",
        difficulty = "hard", difficultyReason = "A full weekly raid, the Spine mechanics and a rare final-chest drop can require many attempts.",
        cost = "No purchase", requirements = mount[4] and "Heroic Dragon Soul; Raid Finder and Normal cannot drop this mount" or "Normal or Heroic Dragon Soul; Raid Finder cannot drop this mount",
        tips = "All legacy sizes and Normal/Heroic share this character's weekly boss loot. Blazing Drake and Life-Binder's Handmaiden are separate possible drops; a Heroic clear can yield either, both or neither.",
        sourceComments = {1559338, 1559342, 1654671, 6009740, 6009743},
        steps = {
            mount[4] and "Set legacy Raid Difficulty to Heroic BEFORE entering. Life-Binder's Handmaiden does not drop on Normal or Raid Finder, and killing Madness on Normal consumes this character's weekly loot opportunity."
                or "Choose legacy Normal or Heroic before entering. Heroic is useful if you also need Life-Binder's Handmaiden; LFR does not drop Blazing Drake. A different raid size does not give an extra weekly boss roll.",
            dragonSoulApproach,
            dragonSoulToUltraxion .. " Kill Ultraxion and open the Lesser Cache for a separate chance at Experiment 12-B.",
            "Board the Skyfire when offered and speak to the NPC to start Warmaster Blackhorn. Kill the boarding enemies and ranged Twilight Assault Drakes until Blackhorn lands, then defeat him. Speak to the crew to continue to Deathwing's back.",
            dragonSoulSpine,
            dragonSoulPlate,
            dragonSoulMadness,
            "Search the Greater Cache for " .. mount[2] .. " and use the reins if present. If absent, repeat on another character or after the weekly reset. Do not run a different size expecting another eligible Madness chest this week.",
        },
        waypoints = {
            pin(71, 64.4, 50.0, 2, "Caverns of Time - descend to the Dragon Soul portal", "Tanaris"),
            pin(409, 49.9, 45.7, 3, "Ultraxion - summit and first mount chest", "Dragon Soul - Dragonblight"),
            pin(415, 47.7, 53.4, 7, "Madness of Deathwing - final encounter and Greater Cache", "Dragon Soul - The Maelstrom"),
        },
        areaMaps = {413, 414},
    })
end

-- https://www.wowhead.com/achievement=4845 (current required criteria)
-- https://www.wowhead.com/achievement=5281#comments:id=6461312
-- https://www.wowhead.com/achievement=5289#comments:id=1261778
-- https://www.wowhead.com/achievement=5290#comments:id=6370555
-- https://www.wowhead.com/achievement=5370#comments:id=2018136
-- Only the live checklist is required: the old Tides challenges and Umbrage
-- for Umbriss have been removed. Heroic dungeon completion still includes Tides.
add(88331, "Volcanic Stone Drake", 62900, {
    category = "Achievements", source = "Glory of the Cataclysm Hero (4845)", sourceAchievementId = 4845,
    description = "A guaranteed mount for the original Heroic dungeon challenge meta. This route explains every retained challenge and the nine required dungeon clears.",
    difficulty = "hard", difficultyReason = "Several bosses must survive for add mechanics; daily Heroic lockouts and excessive high-level damage can force repeat visits.",
    cost = "No purchase", requirements = "Heroic versions of the nine original Cataclysm dungeons; controlled damage and preferably a helper",
    tips = "Track 4845 and each unfinished sub-achievement. Remove damaging procs, pets and automatic retaliation before setup fights. The Whole-Body Shrinka' toy and removing gear may still leave a level-90 hit lethal: a lower-level helper or small fixed-damage item is safer. Old Faithful, Prince of Tides and Umbrage for Umbriss are no longer required.",
    sourceComments = {1878526, 6461312, 1248740, 2135823, 1934015, 6218432, 1261778, 2585159,
        2025535, 6370555, 1208598, 1232937, 1218673, 1218667, 1218659, 1168828,
        2024165, 2063525, 3201671, 2018136, 2337145, 2062447, 2062458, 1238422},
    sourceReplyIds = {974986, 927519, 210311, 1622260, 1512202, 919965, 943770, 1770052,
        865498, 192270, 202812, 1561768, 1558399, 1210418, 238456, 565727},
    steps = {
        "Set Dungeon Difficulty to Heroic and open Glory of the Cataclysm Hero (4845). Plan to complete every unfinished challenge below, plus Cataclysm Dungeon Hero (4844). Read the relevant setup BEFORE hitting a boss: killing it too early usually means another character or the next daily Heroic reset.",
        "BLACKROCK CAVERNS: enter Blackrock Mountain from Burning Steppes or Searing Gorge. On the east side of the inner ring take the Blackrock Spire hallway, then its right-hand branch into Caverns (Burning Steppes map about 27.4,27.9). The route is inside the mountain, not on its outside summit.",
        "Rom'ogg - Crushing Bones and Cracking Skulls: keep him alive while Quake produces Angered Earth adds. At high level, remove gear and /sit for Quake to help it actually hit and spawn adds; bring a lower-level helper if the spawns still fail. Keep the adds alive and gather them near him. At his roughly 66% and 33% health transitions, free yourself from Chains of Woe and let The Skullcracker kill the gathered adds. Get ten add deaths credited to HIS attack before finishing him; your AoE kills do not count.",
        "For a max-level Rom'ogg attempt, the recent Midnight comment uses Oil of Immolation (8956) with gear removed to cross each health threshold without one-shotting him. Gather at least five adds, separate them from the boss, allow only one oil tick, and immediately cancel the buff. Its exact damage depends on your character: watch his health rather than treating the reported percentage as guaranteed. Let Skullcracker kill that wave, wait out the oil cooldown and repeat for ten total. Do not leave the oil running on the adds.",
        "Corla - Arrested Development: let all three kneeling zealots finish evolving into Twilight Drakonids; do not block every beam or kill zealots before evolution. Kill each evolved drakonid, then Corla. Karsh - Too Hot to Handle: move him into the central lava column and wait until his Superheated Quicksilver Armor has at least 15 stacks, then kill him before the stacks expire. Obsidius - Ascendant Descending: kill him promptly before anyone reaches four stacks of Crepuscular Veil; kite his shadow copies if necessary.",
        "THE STONECORE: fly to the portal on the Temple of Earth's upper exterior ledge in Deepholm (47.5,52.1). For Rotten to the Core, leave the Devout Followers near High Priestess Azil alive. Body-pull the preceding room and the three packs in front of her, gathering at least 60. Pull Azil with a non-damaging ability, then kill the followers within ten seconds of the pull. Do not kill those packs while walking in and do not kill Azil before triggering their count. Finish the Heroic dungeon.",
        "THE VORTEX PINNACLE: fly to the airborne portal in southeast Uldum at 76.8,84.4. You need Extra Credit Bonus Stage and No Static at All, as well as the full Heroic clear. Collect five Golden Orbs during this run; simply moving through an orb is insufficient, so right-click it while within reach.",
        "For the orbs, inspect the first bridge's outer edge, the ledge behind Grand Vizier Ertan beside his slipstream, both sides of the Howling Gale bridge, and the spiral ramp toward Asaad. The map marks possible search positions, not guaranteed spawns. Jump toward an orb and click in midair; falling returns you to the entrance, whose unlocked slipstream shortens the return. Two alternatives float above Altairus and require his active tornadoes to lift you: leave him alive if you need those.",
        "At Asaad, kill him before Static Cling if your damage permits. Otherwise jump so you are airborne when each Static Cling cast completes, avoid the debuff throughout the fight, and finish him for No Static at All. Confirm both challenges and the Heroic final-boss credit before leaving.",
        "LOST CITY OF THE TOL'VIR: enter the ground-level portal in southern Uldum, around 60.5,64.4. At Lockmaw, hold damage and let five waves of four Frenzied Crocolisks accumulate. Kite them without killing them, then kill all 20 in a ten-second window for Acrocalypse Now. Finish Lockmaw and Augh afterward.",
        "High Prophet Barim - Kill It With Fire!: first wait for his red phoenix to leave fire patches. Carefully reduce Barim to 50% to enter the spirit phase without killing him. Use a lower-level helper if a bare-handed hit is lethal; the Midnight comments also describe controlled Oil of Immolation damage followed by Goblin Dragon Gun, Mark II. Cancel damaging effects as soon as the phase starts.",
        "In Barim's spirit phase, make Soul Fragments pass through the existing fire before killing them. Keep the purple Harbinger alive until three burning fragments are credited; it can consume fragments that reach it. Standing by a fire patch helps ignite fresh spawns immediately. Once the achievement appears, kill the Harbinger and finish Barim.",
        "Siamat - Headed South: leave the three large melee Servants of Siamat alive as they spawn; the small caster Minions do not give the required buff. Stand in melee range when each Servant dies to receive Lightning Charge. Kill the last-spawned Servant to remove Siamat's shield, then kill the other two close together while maintaining all three stacks. Confirm three Lightning Charges on YOUR character before killing Siamat; do not kill all adds from range.",
        "HALLS OF ORIGINATION: enter the pyramid in eastern Uldum, around 69.1,52.9. Temple Guardian Anhuur - I Hate That Song: a high-level immediate kill avoids the hymn entirely. If he shields, pull both pit levers and interrupt the exposed boss's Reverberating Hymn within 15 seconds. Put one player at each lever and clear/control the snakes so their hits do not interrupt the channels.",
        "Earthrager Ptah - Straw That Broke the Camel's Back: clear the sand-area trash FIRST, then click one of the dungeon's camels and fight Ptah while riding it. Avoid the dark Earth Spike marks and swirling Quicksand, which dismount you. Finish the boss without losing your camel; summoning an ordinary camel mount does not replace the encounter vehicle.",
        "Faster Than the Speed of Light: when ready, tell Brann to open the Vault of Lights. Immediately go around its four corners and kill all four Elemental Warders within five minutes, allowing time for the door-opening dialogue. Skip unnecessary Trogg packs; Anraphet himself does not have to die inside that timer. For Sun of a...., kill Rajh before he completes a recharge, interrupting his casts if your damage is low. Finish the Heroic final-boss requirement.",
        "DEADMINES: enter the mine building in Moonbrook, Westfall (about 42.6,71.7), follow the tunnels down and use the Heroic instance portal. Glubtok - Ready for Raiding: avoid his rotating Fire Wall; a quick kill before it appears is sufficient.",
        "Helix - Rat Pack: leave his Lumbering Oaf alive and let its charges smash into the lumber piles. Target the Mine Rats that emerge and kill them until you have 20. Do not AoE the Oaf down before the rats spawn. The rat counter can accumulate across attempts; check the achievement before finishing the encounter.",
        "Foe Reaper 5000 - Prototype Prodigy: keep the friendly Prototype Reaper above 90% health during the boss encounter. At high level, leave it safely upstairs, clear the enemies that activate the boss and kill Foe Reaper quickly. You do not have to bring the friendly vehicle into the damaging floor fight.",
        "Admiral Ripsnarl - It's Frost Damage: reduce him carefully below 75%, stop attacking, and let the fog phase continue. Leave the Vapors alive until three have grown and cast Coalesce. A high-level character can survive their explosions; lower-level players can hide in the cabin for each cast. Wait for achievement credit before killing Ripsnarl.",
        "Captain Cookie - I'm on a Diet: let Cookie climb into his pot and throw food. Eat ONE rotten green-glowing food to obtain a single Nauseated stack, then kill him immediately without gaining a second stack. The comment replies warn that killing him before the encounter initializes can miss credit even with zero stacks.",
        "Vigorous VanCleef Vindicator: after Cookie, click Vanessa's letter on the deck. When her nightmare starts, use the steam valves to escape the opening trap and run back toward the ship through each nightmare section. Avoid fire and rotating lightning, kill the required nightmare enemies, and protect the friendly NPCs in the Ripsnarl section before advancing. Reach and ENGAGE Vanessa within five minutes of the Nightmare Elixir; the timer is for engaging her, not killing her. Finish her for the Heroic clear.",
        "SHADOWFANG KEEP: enter the castle in southern Silverpine Forest (44.9,67.8) on Heroic. Baron Ashbury - Pardon Denied: kill him before Stay of Execution, or interrupt that heal immediately after Asphyxiate and heal yourself. Letting even one healing tick through fails the challenge. Lord Springvale - To the Ground!: kill him quickly, or kill/interrupt his adds before they grant him Unholy Empowerment.",
        "Lord Godfrey - Bullet Time: hold boss damage and let him summon Bloodthirsty Ghouls. When he channels Pistol Barrage, move so the ghouls follow you through the cone and die to HIS bullets. Repeat until 12 are credited, then kill him. Do not AoE the ghouls yourself; standing on the stairs does not make you immune to his barrage.",
        "GRIM BATOL: enter the portal in western Twilight Highlands, around 19.2,54.2, on Heroic. Finish the dungeon for 4844. At Erudax, for Don't Need to Break Eggs to Make an Omelet, kill both Faceless Corruptors immediately when they appear, before either reaches and damages an egg. High-level burst can end Erudax before that wave. The removed Umbrage for Umbriss challenge is not a prerequisite for this mount.",
        "THRONE OF THE TIDES: travel to the Abyssal Breach in northern Abyssal Depths, Vashj'ir (about 70.5,29.9), swim down into the giant whirlpool and enter on Heroic. Complete the current dungeon through Ozumat for Cataclysm Dungeon Hero. The old Old Faithful and Prince of Tides mechanics are not required by 4845 anymore, so do not look for removed versions of those encounters.",
        "Reopen 4845 and 4844. Finish any unchecked boss challenge or Heroic dungeon on another eligible character or the next daily reset as needed. When the meta completes, check the Mount Journal and achievement reward mail for Reins of the Volcanic Stone Drake, then learn it.",
    },
    waypoints = {
        pin(36, 27.4, 27.9, 2, "Blackrock Caverns - inside Blackrock Mountain's eastern hallway", "Burning Steppes"),
        pin(283, 50.0, 70.2, 3, "Rom'ogg - preserve adds for Skullcracker", "Blackrock Caverns - Chamber of Incineration"),
        pin(283, 50.0, 70.2, 4, "Rom'ogg - controlled-damage alternative", "Blackrock Caverns - Chamber of Incineration"),
        pin(207, 47.5, 52.1, 6, "The Stonecore - Temple of Earth upper exterior ledge", "Deepholm"),
        pin(324, 57.4, 38.7, 6, "Azil - gather 60 followers BEFORE pulling", "The Stonecore"),
        pin(249, 76.8, 84.4, 7, "The Vortex Pinnacle - airborne entrance", "Uldum"),
        pin(325, 63.6, 35.9, 8, "Golden Orb - possible first-platform search area", "The Vortex Pinnacle"),
        pin(325, 56.7, 68.9, 8, "Golden Orb - possible bridge search area", "The Vortex Pinnacle"),
        pin(325, 55.6, 70.0, 8, "Golden Orb - check both sides of the bridge", "The Vortex Pinnacle"),
        pin(325, 31.0, 66.6, 8, "Golden Orb - ramp below the overhang", "The Vortex Pinnacle"),
        pin(325, 28.8, 69.9, 8, "Golden Orb - possible spiral-ramp search area", "The Vortex Pinnacle"),
        pin(325, 57.3, 72.6, 8, "Golden Orb - possible bridge search area", "The Vortex Pinnacle"),
        pin(325, 58.6, 71.2, 8, "Golden Orb - possible bridge search area", "The Vortex Pinnacle"),
        pin(249, 60.5, 64.4, 10, "Lost City of the Tol'vir - Heroic challenges", "Uldum"),
        pin(249, 69.1, 52.9, 14, "Halls of Origination - Heroic entrance", "Uldum"),
        pin(52, 42.6, 71.7, 17, "Moonbrook mine building - descend to Deadmines", "Westfall"),
        pin(21, 44.9, 67.8, 23, "Shadowfang Keep - Heroic entrance", "Silverpine Forest"),
        pin(241, 19.2, 54.2, 25, "Grim Batol - Heroic entrance", "Twilight Highlands"),
        pin(204, 70.5, 29.9, 26, "Abyssal Breach - swim down to Throne of the Tides", "Abyssal Depths"),
    },
})

-- https://www.wowhead.com/achievement=4853#comments:id=2323804
-- Replies 947202 and 1007965 correct positioning and add counting.
-- https://www.wowhead.com/achievement=5305#comments:id=2028318
add(88335, "Drake of the East Wind", 62901, {
    category = "Achievements", source = "Glory of the Cataclysm Raider (4853)", sourceAchievementId = 4853,
    description = "A guaranteed personal reward for twelve Heroic raid bosses and their encounter challenges across three raids. This is separate from the guild's Dark Phoenix unlock.",
    difficulty = "hard", difficultyReason = "Multiple raids require deliberate add handling, health thresholds and debuff timing; failed kills consume a weekly lockout.",
    cost = "No purchase", requirements = "Heroic Blackwing Descent, Bastion of Twilight and Throne of the Four Winds; a helper simplifies several setups",
    tips = "Run all twelve required bosses on Heroic. Remove damaging procs and dismiss pets before health-control fights; one ordinary max-level hit can skip a required phase. Sinestra and the retired I Can't Hear You Over the Sound of How Awesome I Am are not required.",
    sourceComments = {2323804, 1878350, 1629857, 2028318, 3304634, 2086268, 2072364},
    sourceReplyIds = {947202, 1007965, 822735, 1773856, 832724, 1078175, 1509573},
    steps = {
        "Track Glory of the Cataclysm Raider (4853), inspect its unfinished criteria and set legacy Raid Difficulty to Heroic before entering each raid. You need every listed Heroic boss kill as well as the special challenges below. Unlike Dark Phoenix, this mount does not require a guild group.",
        "BLACKWING DESCENT: fly to the high outside balcony on Blackrock Mountain's eastern face, around Burning Steppes 26.1,23.8. Enter the raid portal there; going down the internal chains leads toward different instances.",
        "Magmaw - Parasite Evening: kill him before a player becomes infected by a Lava Parasite; if adds spawn, keep them off players. Omnotron - Achieve-a-tron: burst the active construct before Static Shock, Poison Bomb, Arcane Annihilator or Flamethrower can hit anyone. These are quick kills at high level, and both must also give Heroic completion.",
        "Maloriak - Aberrant Behavior: aggro without damaging him below his final-phase threshold. Let Release Aberrations finish repeatedly until at least 12 Aberrations are alive; each successful release adds three. Gather them away from the boss and kill 12 within ten seconds, then finish Maloriak. Do not interrupt every release or let a damage aura kill adds as they appear.",
        "Atramedes - Silence is Golden: kill him before anyone's sound reaches 50. If the fight lasts, dodge the sound discs and use the room's gongs to reset sound before the limit. Chimaeron - Full of Sound and Fury: defeat him without any raid member dying. A fast high-level kill meets both conditions without recreating the old raid damage cycle.",
        "Nefarian - Keeping it in the Family: jump into the pit and keep Onyxia alive while Nefarian arrives. Carefully lower Nefarian below 50% without killing him; roughly 40-45% leaves a clear margin. Kill Onyxia before her energy fills. During the lava phase climb a pillar, kill the Chromatic Prototype there and interrupt dangerous casts. Wait until the lava recedes and Nefarian LANDS for the final phase, then kill him. A premature airborne kill can miss credit.",
        "BASTION OF TWILIGHT: fly high above the southwestern Twilight Highlands to the spire's summit portal, around 34.2,78.0. Enter on Heroic. Halfus - The Only Escape: release two available drakes, gather them and kill both within ten seconds of each other, then kill Halfus. Do not kill Halfus before freeing and defeating the drakes.",
        "Valiona and Theralion - Double Dragon: hold boss damage and wait for the Twilight Realm entry mechanic. Stand in Theralion's Dazzling Destruction ground effects to enter the realm, then find and kill six Twilight Fiends there. Use /target Twilight Fiend to find them among the purple effects. After the six are credited, leave through a portal if needed and finish the dragons.",
        "Ascendant Council - Elementary: reduce the first pair together, then the second pair, without excessive damage. Before Elementium Monstrosity forms, stand near the EDGE of the purple central circle. Keep it stationary and kill it promptly so it creates only one Liquid Ice pool. Standing at the exact center can make it move after spawning and create a second pool; that correction comes from the guide's replies.",
        "Cho'gall - The Abyss Will Gaze Back Into You: stay close to him and kill him before any player's Corrupted Blood reaches 30. Dismiss a taunting pet if it would pull him away and expose a solo character to mind control. Finish his Heroic kill; Sinestra beyond him is optional for this mount.",
        "THRONE OF THE FOUR WINDS: fly to the airborne platform off southwestern Uldum at 38.4,80.6 and enter on Heroic. The Conclave's three bosses occupy separate outer platforms connected by wind bridges. Do not kill Nezir immediately: this attempt needs Stay Chill first.",
        "Conclave - Stay Chill: stand on Nezir's northern platform and let Wind Chill reach at least seven stacks on every player who needs credit. While that condition is active, defeat Nezir and cross the wind bridges to finish Anshal and Rohash before the first boss recovers. A helper covering an outer platform makes the timing easier. Track the condition and kill all three within their recovery window rather than repeatedly waiting for a dead boss to revive.",
        "Al'Akir - Four Play: click an outer platform's central wind funnel to reach him. Carefully lower his health to start phase two, then STOP before the final flight transition. Wait for a Stormling. Move it beside Al'Akir and kill it there so the boss receives Feedback; killing it far away gives no debuff. Confirm Feedback on Al'Akir, then burst him down before it expires, including the short flight transition.",
        "Check all 24 criteria in 4853. If a setup failed, finish that missing achievement on a suitable eligible character or after the weekly reset. When the meta completes, check the Mount Journal and reward mail for Reins of the Drake of the East Wind and learn it. Completing Guild Glory alone does not award this personal mount.",
    },
    waypoints = {
        pin(36, 26.1, 23.8, 2, "Blackwing Descent - high outside balcony", "Burning Steppes"),
        pin(286, 71.4, 70.2, 4, "Maloriak - allow at least twelve Aberrations to spawn", "Blackwing Descent - Vault of the Shadowflame"),
        pin(286, 48.0, 70.2, 6, "Nefarian - hold below half health, then wait for the landing", "Blackwing Descent - Vault of the Shadowflame"),
        pin(241, 34.2, 78.0, 7, "Bastion of Twilight - very high spire summit", "Twilight Highlands"),
        pin(249, 38.4, 80.6, 11, "Throne of the Four Winds - airborne entrance", "Uldum"),
        pin(328, 47.5, 26.0, 12, "Nezir - wait for seven Wind Chill stacks", "Throne of the Four Winds"),
        pin(328, 47.5, 50.0, 13, "Al'Akir - keep alive for a nearby Stormling and Feedback", "Throne of the Four Winds"),
    },
})

-- https://www.wowhead.com/achievement=5828#comments:id=1969834 and 1969837
-- https://www.wowhead.com/achievement=5829#comments:id=1625485 (reply 930104)
-- https://www.wowhead.com/achievement=5799#comments:id=3162817
-- https://www.wowhead.com/achievement=5799#comments:id=6288490 and replies
add(97560, "Corrupted Fire Hawk", 69230, {
    category = "Achievements", source = "Glory of the Firelands Raider (5828)", sourceAchievementId = 5828,
    description = "A guaranteed Firelands achievement mount. Six Heroic boss kills, Shannox's tour and the flame-orb coordination are the main objectives.",
    difficulty = "hard", difficultyReason = "Several bosses must survive setup mechanics, and Only the Penitent needs precise coordinated interactions or a practiced solo movement route.",
    cost = "No purchase", requirements = "Six Heroic Firelands boss kills and all six listed special challenges",
    tips = "Bring a second player for Only the Penitent; its old six-player requirement is obsolete. Do not kill Staghelm's flame-casting trash until that achievement is complete. Heroic Ragnaros is not required by this meta.",
    sourceComments = {1969834, 1969837, 1782728, 2083657, 2056527, 1625485, 1499549,
        3162817, 3180835, 6003681, 6148406, 6150568, 6268772, 6288490, 2022457, 1484957},
    sourceReplyIds = {930104, 1829948, 829023, 525182},
    steps = {
        "Track Glory of the Firelands Raider (5828), set legacy Raid Difficulty to Heroic, and enter Firelands at Mount Hyjal 47.2,78.1. Bring a helper for the two flame orbs if possible and convert the group to a raid. Remove automatic damage, reflective effects and pets before the Shannox route and other setup fights.",
        "Clear a safe circuit through the Molten Fields without killing Shannox when the trash threshold spawns him. Bucket List requires HIM to enter five named areas while alive. Keep the achievement tracked. At high level, kill Rageface alone if his stun prevents movement, leaving Shannox and Riplimb alive; avoid cleave hitting the boss.",
        "Pull Shannox and lead him through Flamebreach (34.1,75.1), Beth'tilac's Lair (29.1,62.3), Path of Corruption (34.0,30.8), Shatterstone (61.2,45.4) and The Ridge of Ancient Flame (61.6,55.9). These pins are route markers: move far enough for Shannox himself to cross each area boundary and check its criterion. The wall below Beth'tilac's upper room counts without climbing to her. Kill Shannox only after all five locations are registered.",
        "Beth'tilac - Death from Above: kill a hanging Spinner and use its web strand to reach the upper canopy. Damage Beth'tilac there and follow her down if she transitions. Do not kill any Cinderweb Drone on the ground: use single-target attacks on the boss and leave drones alive. If deliberately killing a drone, wait until it climbs up after losing energy and kill it on the web. Finish Beth'tilac for the Heroic kill and the challenge.",
        "Lord Rhyolith - Not an Ambi-Turner: attack only his RIGHT foot to steer him clockwise. Do not attack the left foot and make him turn left. Once his armor breaks and his body becomes attackable, kill him. At high level this can be a very short right-foot phase.",
        "Alysrazor - Do a Barrel Roll!: avoid Brushfire, Lava Spew, Incendiary Cloud and Fiery Tornado throughout the encounter. Kill the flame druids before Brushfire casts, stay away from the worms' fire cones and attack Alysrazor as soon as she is properly engaged. A fast high-level kill before the tornado phase is simplest. Anyone flying with feathers must avoid the clouds as well as the ground team's hazards.",
        "Baleroc - Share the Pain: kill him promptly before anyone suffers Torment more than three times. If the fight lasts, rotate crystal soakers and keep Tormented players apart to avoid spreading the effect. Complete Baleroc's Heroic kill and cross the newly accessible bridge toward Staghelm.",
        "STOP before Staghelm's arena for Only the Penitent. Leave the central humanoid Druid of the Flame alive while it casts Kneel to the Flame. Dismiss pets and temporary minions, leave shapeshift forms and remove summon/damage procs. Put /kneel or /sit on a convenient key. The two large Fandral's Flame orbs stand on opposite sides of the arena.",
        "Advance only between casts, then kneel BEFORE each cast finishes. Get one player to each orb and stand inside its close orange floor swirl. After a cast finishes, briefly stand if necessary to make the interaction register, and activate both orbs together. Remain close through the short activation and kneel again before the next cast. Being hit by the flame makes the orbs disappear and fails the attempt.",
        "If solo, use a class with rapid movement between the orbs: activate the first just after a flame cast, cross immediately, activate the second and kneel again. Mage comments describe Alter Time plus Shimmer to return to the first orb. This is timing-sensitive; a helper is simpler. If either orb disappears, use the bridge portal back to the entrance, leave, reset the uncompleted trash and re-enter. Leave Staghelm alive while retrying, and respect the instance-entry limit.",
        "Once Only the Penitent has actually appeared, clear the flame druids and defeat Majordomo Fandral Staghelm on Heroic. The six required Heroic kills are Shannox, Beth'tilac, Rhyolith, Alysrazor, Baleroc and Staghelm; Ragnaros is optional and can be farmed for Pureblood Fire Hawk afterward.",
        "Review all twelve criteria in 5828. A missed boss challenge may be completed on an eligible Normal run or another character, while the six Heroic kill criteria still require Heroic. After the meta completes, check the Mount Journal and reward mail for Corrupted Fire Hawk and learn the mount.",
    },
    waypoints = {
        pin(198, 47.2, 78.1, 1, "Firelands - Heroic entrance", "Mount Hyjal"),
        pin(367, 34.1, 75.1, 3, "Bucket List - bring Shannox into Flamebreach", "Firelands"),
        pin(367, 29.1, 62.3, 3, "Bucket List - Beth'tilac's Lair boundary", "Firelands"),
        pin(367, 34.0, 30.8, 3, "Bucket List - Path of Corruption boundary", "Firelands"),
        pin(367, 61.2, 45.4, 3, "Bucket List - Shatterstone boundary", "Firelands"),
        pin(367, 61.6, 55.9, 3, "Bucket List - Ridge of Ancient Flame boundary", "Firelands"),
        pin(367, 64.3, 38.0, 6, "Alysrazor - avoid all four challenge hazards", "Firelands"),
        pin(367, 49.5, 30.9, 7, "Baleroc - gate to the bridge", "Firelands"),
        pin(369, 50.9, 72.4, 8, "Staghelm arena - stop before the flame-casting trash", "Firelands - Sulfuron Keep"),
        pin(369, 50.9, 72.4, 9, "Only the Penitent - orbs on opposite sides of this arena", "Firelands - Sulfuron Keep"),
        pin(369, 50.9, 72.4, 11, "Staghelm - kill AFTER completing the orb achievement", "Firelands - Sulfuron Keep"),
    },
})

-- https://www.wowhead.com/achievement=6169#comments:id=2558918
-- https://www.wowhead.com/achievement=6169#comments:id=3305287
-- https://www.wowhead.com/achievement=6180#comments:id=2328211 and 6065736
-- https://www.wowhead.com/achievement=6128#comments:id=2065438
-- The numbered profit-ending orb route is adapted without its final two filler
-- lines. Replies confirm non-pet soloing; the 2026 counter caps at ten.
-- The live meta no longer requires Holding Hands or Heroic Spine/Madness.
add(107844, "Twilight Harbinger", 77068, {
    category = "Achievements", source = "Glory of the Dragon Soul Raider (6169)", sourceAchievementId = 6169,
    description = "A guaranteed Dragon Soul achievement mount. Most challenges fit into one careful clear, but Chromatic Champion needs four different opening platforms on the same character across weekly resets.",
    difficulty = "hard", difficultyReason = "At least four weekly Madness kills plus orb bounces, Skyfire defense and a precise Spine roll sequence.",
    cost = "No purchase", requirements = "Six Heroic boss kills and seven special achievements; keep one character for all four Chromatic Champion criteria",
    tips = "Holding Hands and the Heroic Spine/Madness kill achievements are no longer required. Do not one-shot a boss that needs setup. Killing Madness on several alts in one week does not combine their incomplete Chromatic Champion platform criteria.",
    sourceComments = {2558918, 3305287, 2328211, 6065736, 6009740, 6009743,
        2065438, 2460870, 6355915, 6399548, 2081084, 6238131, 2158077, 2357248, 6149464},
    sourceReplyIds = {1210742, 1780640, 822139, 833075, 1571754, 1848454, 1368676, 1778430},
    steps = {
        "Track Glory of the Dragon Soul Raider (6169) and Chromatic Champion (6180). Choose the character you will use for four weekly Madness kills and record which Aspect opening platform is still missing. Set legacy Raid Difficulty to Heroic so the first six required bosses also give their Heroic kill achievements.",
        dragonSoulApproach,
        "Morchok - Don't Stand So Close to Me: defeat him quickly before Black Blood of the Earth or his other area mechanics create a failure. If in a group, spread rather than stacking everyone together. Loot him and continue to the two lower side encounters.",
        "Yor'sahj - Taste the Rainbow!: pull without killing him and wait for multiple ooze waves. On Heroic, allow all four oozes in each wave to reach him. During this single fight, record each simultaneous pair in HIS absorbed color buffs: Black/Yellow, Black/Blue, Red/Green and Purple/Yellow. One wave can satisfy two pairs. The live achievement tracker may not update until the kill, so do not wait forever for its checkboxes: kill him once you have personally seen all four pairs. The room's initial trash oozes do not count.",
        "Zon'ozz - Ping Pong Champion: let the purple Void of the Unmaking orb appear and intercept it ten times. After each bounce, follow until its center glows again before touching it for the next bounce. Keep it away from the outer walls. Two players on opposite sides can pass it back and forth; solo, chase it or use a passive pet's taunt to hold the boss aside without damage. This also works without a pet. Confirm ten Void Diffusion stacks on the ORB, then kill Zon'ozz. The current counter can cap at ten, so an eleventh visible stack is unnecessary.",
        "Use the Wyrmrest transport and portal to the Eye of Eternity and defeat Hagara on Heroic. Holding Hands is absent from the live mount checklist; the lightning-chain challenge is not an extra prerequisite. Return to Wyrmrest's summit and speak to Thrall for the Twilight drake defense.",
        "Ultraxion - Minutes to Midnight: let the encounter engage normally, then kill him before anyone can be hit by Hour of Twilight more than once. A prompt high-level kill is enough. Loot the Lesser Cache of the Aspects for the separate Experiment 12-B chance.",
        "Warmaster Blackhorn - Deck Defender: board the Skyfire and use ranged attacks to kill Twilight Assault Drakes as soon as they approach. Prevent their small Twilight Barrage circles from striking the ship unsoaked; helpers can cover circles while you shoot drakes. Do not confuse those small impacts with Goriona's large Twilight Onslaught. After the defense waves, kill Goriona and Blackhorn and confirm the Heroic boss credit.",
        "Spine - Maybe He'll Get Dizzy...: start by killing three Corruption tentacles and leaving one alive. Anchor in a dead tentacle's hole with Grasping Tendrils on the LEFT and wait for the completed left roll. Move to a right-side hole for a completed RIGHT roll, then repeat LEFT and RIGHT. You need exactly that ordered four-roll sequence during the successful attempt. If you fall off and reset, do it again from the beginning.",
        dragonSoulSpine .. " Once the four achievement rolls are complete, stop causing extra rolls and begin opening the armor plates.",
        dragonSoulPlate .. " Watch the achievement tracker before finishing the third plate. Heroic Spine is optional for this mount; if using Normal, expect the original nine-residue collection rather than Heroic's shortened absorption.",
        "At Madness, choose one still-missing first platform for Chromatic Champion: Ysera, Nozdormu, Alexstrasza or Kalecgos. Thrall is on Ysera's platform. The physical order along the platform chain is Alexstrasza - Nozdormu - Ysera - Kalecgos, so Alexstrasza requires two jumps from the start.",
        "For the distant Alexstrasza start, jump from Ysera to Nozdormu and back BEFORE speaking to Thrall to build Carrying Winds movement stacks. Finish Thrall's start dialogue, immediately jump through Nozdormu to Alexstrasza using a speed ability, and remain there until Deathwing announces the first Aspect assault. For the other starts, move to the selected platform as soon as the dialogue allows. Do not attack the first limb instantly: wait for the assault and the platform's Mutated Corruption to engage so the opening criterion is established.",
        "After the chosen first-platform assault, kill that limb and Corruption, cross to the remaining platforms and kill their limbs, then return to the start and defeat Deathwing's head. Open the Greater Cache and inspect 6180 afterward to confirm which first-platform criterion was credited. Do not repeat that same opening next week unless its checkbox is still missing.",
        "On the SAME character, return after each weekly reset and repeat Madness with a different missing Aspect first until all four are checked. Normal and Heroic share weekly loot/progression here, so swapping difficulty does not turn this into four attempts in one week. This criterion needs at least four weekly lockouts, even when the rest of 6169 is complete.",
        "Review all thirteen live criteria in 6169, including the six Heroic kills through Blackhorn. Finish any missed special challenge without repeating already-complete criteria unnecessarily. When the meta completes, check the Mount Journal and reward mail for Reins of the Twilight Harbinger, then learn the mount.",
    },
    waypoints = {
        pin(71, 64.4, 50.0, 2, "Caverns of Time - descend to Dragon Soul", "Tanaris"),
        pin(411, 46.8, 49.9, 4, "Yor'sahj - wait for all four ooze-color combinations", "Dragon Soul - Maw of Shu'ma"),
        pin(410, 50.9, 53.0, 5, "Zon'ozz - intercept the orb ten times before killing the boss", "Dragon Soul - Maw of Go'rath"),
        pin(409, 49.9, 45.7, 7, "Ultraxion - summit and Lesser Cache", "Dragon Soul - Dragonblight"),
        pin(413, 48.2, 17.0, 8, "Warmaster Blackhorn - Skyfire defense", "Dragon Soul - The Skyfire"),
        pin(415, 47.7, 53.4, 12, "Madness - choose the next missing opening Aspect", "Dragon Soul - The Maelstrom"),
        pin(415, 47.7, 53.4, 14, "Madness - final chest after all four limbs", "Dragon Soul - The Maelstrom"),
    },
    areaMaps = {412, 414},
})

-- Keep the registered rows and name-based detail panels on the same route.
-- Empty waypoint lists intentionally replace invented class-mount trainer pins.
local fields = {
    "acquisition", "itemId", "npcId", "description", "source", "tips", "requirements",
    "cost", "waypoints", "faction", "difficulty", "difficultyReason", "sourceAchievementId", "automaticUnlock",
}
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^4%.") then
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
