-- Hand-reviewed Burning Crusade cosmetic walkthroughs for Retail (2026-11-01).
-- Read all 408 parent comments on the 20 item pages and expanded acquisition
-- and correction threads through Wowhead's public comment/show-replies endpoint.
-- None of the item threads has a numbered, profit-ending acquisition guide.
-- These edited guides combine useful item comments with related Retail quest
-- and faction threads, replies, vendor costs and NPC maps. Historical tricks,
-- removed quests and Classic-only requirements are not acquisition routes here.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.cosmetics = TDP.CollectionWalkthroughs.cosmetics or {}
local guides = TDP.CollectionWalkthroughs.cosmetics

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function addCosmetic(itemID, name, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.category = guide.category or "Reputation"
    guide.sourceType = guide.category
    guide.effect = guide.effect or "Cosmetic tabard appearance. Wearing this tabard does not grant faction reputation in dungeons."
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end


-- Detailed item guide and its travel/Legoso corrections; current quest maps:
-- https://www.wowhead.com/item=24344#comments:id=2463610 and all ten replies
-- https://www.wowhead.com/item=24344#comments:id=2025578
-- https://www.wowhead.com/item=24344#comments:id=2550278
-- https://www.wowhead.com/item=24344#comments:id=2343753
-- https://www.wowhead.com/quest=9753/what-we-know
-- https://www.wowhead.com/quest=9761/clearing-the-way
-- https://www.wowhead.com/quest=9759/ending-their-world
-- https://www.wowhead.com/quest=9762/the-unwritten-prophecy
addCosmetic(24344, "Tabard of the Hand", {
    steps = {
        "Use a regular Draenei character; Lightforged Draenei do not qualify for the final tabard quest. Any class works, including Death Knight. Go to Blood Watch in Bloodmyst Isle and enable Trivial Quests. The old guide's level-100 Class Trial, garrison and Legion-introduction travel steps are unnecessary.",
        "Speak to Vindicator Aesom at Blood Watch (55.6, 55.4) and take What We Know... (9753). Deliver it to Exarch Admetius inside the nearby building (52.6, 53.2). You do not need to complete every quest on Azuremyst or Bloodmyst first.",
        "Accept What We Don't Know... (9756). Let Admetius disguise you, question the blood elf prisoner in the cage just downhill, then return to Admetius. Stay in Blood Watch while disguised so the spell does not fail. Accept Vindicator's Rest (9760).",
        "Go west to Vindicator Corin at Vindicator's Rest (30.6, 46.6). Take Clearing the Way (9761), kill the requested Sunhawk Agents and Sunhawk Saboteurs around the Vector Coil, southwest around 17.0, 55.0, and return to Corin.",
        "Speak to Demolitionist Legoso beside Corin (30.8, 46.6) and accept Ending Their World (9759). If Legoso is absent, another player may be escorting him; let that event finish and check again. Complete Clearing the Way before assuming he is missing permanently.",
        "Follow and protect Legoso all the way up the Vector Coil to around 14.8, 54.9. Let him place and detonate his explosives, then defeat Sironas when the event makes her attackable. Stay with the escort until the quest objective actually completes; killing nearby blood elves alone is insufficient.",
        "Return to Exarch Admetius at Blood Watch (52.6, 53.2) and turn in Ending Their World. Walk outside to the welcoming crowd. Speak to Prophet Velen there around 54.0, 55.5 and accept and complete The Unwritten Prophecy (9762) for the tabard. Do not leave immediately for the permanent Velen in the Exodar and miss the ceremony.",
        "Equip the tabard and check your appearance collection. Once learned, the appearance can be used by other eligible Alliance characters. If Aesom has no starting quest, check your log for a later chain step; the comments also report relogging or accepting and abandoning a local Blood Watch quest making the starter appear.",
    },
    source = "The Unwritten Prophecy - Blood Watch, after the Vector Coil escort",
    category = "Quests", faction = "alliance", npcId = 17468,
    requirements = "Regular Draenei for the final reward; any class. Lightforged Draenei are not eligible for that quest.",
    cost = "Quest reward; no reputation currency or purchase.",
    tips = "Keep the guide on Bloodmyst Isle for the main route. Comments saying Velen must always be visited in the Exodar conflict with the ceremony route and current Blood Watch quest location. Older race-change and Class Trial shortcuts are not required.",
    waypoints = {
        pin(106, 55.6, 55.4, 2, "Vindicator Aesom - What We Know..."),
        pin(106, 52.6, 53.2, 2, "Exarch Admetius - chain turn-ins"),
        pin(106, 52.6, 53.2, 3, "Admetius - disguise and prisoner interrogation nearby"),
        pin(106, 30.6, 46.6, 4, "Vindicator Corin - Clearing the Way"),
        pin(106, 17.0, 55.0, 4, "Vector Coil - Sunhawk Agents and Saboteurs"),
        pin(106, 30.8, 46.6, 5, "Demolitionist Legoso - begin the escort"),
        pin(106, 14.8, 54.9, 6, "Vector Coil - escort finale and Sironas"),
        pin(106, 52.6, 53.2, 7, "Admetius - turn in Ending Their World"),
        pin(106, 54.0, 55.5, 7, "Prophet Velen - ceremony and tabard reward"),
    },
})

-- Current Orgrimmar quest giver, numbered BRD route and restriction corrections:
-- https://www.wowhead.com/quest=28473#comments:id=3244889
-- https://www.wowhead.com/quest=28473#comments:id=1557209
-- https://www.wowhead.com/quest=28473#comments:id=1891243 and replies
-- https://www.wowhead.com/item=25549#comments:id=1891242
-- https://www.wowhead.com/item=25549#comments:id=1911567 and Midnight replies
-- https://www.wowhead.com/item=25549#comments:id=2156750
-- https://www.wowhead.com/npc=168597/avaros-dawnglaive
-- https://www.wowhead.com/npc=9017/lord-incendius (original dungeon floor 1)
addCosmetic(25549, "Blood Knight Tabard", {
    steps = {
        "For the direct reward, use a Blood Elf Paladin of level 20 or higher. This is the original Blood Knight Tabard, not the later Blood Knight Champion's Tabard. The old epic-Charger chain and its expensive materials are no longer the acquisition route.",
        "Go to Avaros Dawnglaive in the Orgrimmar barracks, Valley of Honor (73.3, 47.0). Enable Trivial Quests, take Meet With Avaros Dawnglaive if offered, then accept Weapons of Darkness (28473). The relevant quests moved here; do not search the old Silvermoon headquarters.",
        "Enter the original Blackrock Depths dungeon beneath Blackrock Mountain. Approach from Searing Gorge around 35.0, 85.0, descend the interior chains to the central tomb, then follow the lower passage toward the quarry and dungeon portal. Use the original five-player dungeon, not an anniversary raid queue.",
        "Kill and loot Anvilrage/Dark Iron dwarves near the dungeon entrance until you have 5 Elemental-Imbued Weapons in your bags. Looting them does not complete the objective: all five must also be broken. Dwarves in the entrance quarry can supply the weapons too.",
        "Reach the Black Anvil beside Lord Incendius on the Detention Block floor (56.4, 31.1). For a direct route, take the gate immediately left of the entrance into the Dark Iron Highway, then follow the highway RIGHT toward Shadowforge City and the anvil bridge. Bael'gar is the opposite direction. Clear Incendius and nearby enemies, then use each of the five quest weapons while standing at the anvil.",
        "Return to Avaros in Orgrimmar and turn in Weapons of Darkness. Choose the helm reward and collect the additional Blood Knight Tabard. Equip the tabard to confirm the learned appearance.",
        "If you completed the eligible Horde paladin version previously, check Garyl's tabard inventory in Orgrimmar (47.5, 75.5). Tauren-paladin comments document buying the tabard after their Weapons of Darkness completion. The reliable new-character route above uses a Blood Elf Paladin; Alliance vendor purchases and non-paladin loopholes do not establish a usable appearance on those characters.",
    },
    source = "Avaros Dawnglaive - Weapons of Darkness; eligible paladin replacement vendors",
    category = "Quests", faction = "horde", npcId = 168597,
    requirements = "Direct quest reward: Blood Elf Paladin, level 20+. Appearance has Horde and Paladin restrictions.",
    cost = "Direct quest reward; eligible replacement-vendor price may vary.",
    tips = "Use the quest weapon item at the Black Anvil five times. Neither Blacksmithing nor the old Shadowforge Key is required. Older Alliance purchase comments have later replies reporting unusable items and missing transmog; they are not the recommended route.",
    waypoints = {
        pin(85, 73.3, 47.0, 2, "Avaros Dawnglaive - accept Weapons of Darkness"),
        pin(32, 35.0, 85.0, 3, "Blackrock Mountain - Searing Gorge approach to the lower chains"),
        pin(242, 56.4, 31.1, 5, "Black Anvil - break all five weapons beside Incendius", "Blackrock Depths: Detention Block"),
        pin(85, 73.3, 47.0, 6, "Avaros Dawnglaive - tabard reward"),
        pin(85, 47.5, 75.5, 7, "Garyl - alternative for eligible paladins with the completed quest"),
    },
})

-- Normal Shattered Halls is the finishing route; Normal Ramparts/Furnace cap earlier.
-- https://www.wowhead.com/item=23999#comments:id=252092
-- https://www.wowhead.com/faction=946#comments:id=1566194
-- https://www.wowhead.com/faction=946#comments:id=1414914
-- https://www.wowhead.com/npc=17657/logistics-officer-ulrike
addCosmetic(23999, "Honor Hold Tabard", {
    steps = {
        "Use an Alliance character and check Honor Hold reputation. If already Exalted, go directly to Logistics Officer Ulrike in step 5. This faction belongs to Outland's Hellfire Peninsula; wearing another tabard is not required to earn its dungeon reputation.",
        "Take the Honor Hold quests around 56.6, 62.6 and their Hellfire Peninsula follow-ups for initial reputation. Complete dungeon quests if available, but you can also build the reputation through dungeon kills without finishing every outdoor quest.",
        "Set Dungeon Difficulty to NORMAL and enter The Shattered Halls at Hellfire Citadel (47.7, 52.0). Clear the fel-orc packs and bosses for Honor Hold reputation. This is the middle dungeon doorway; Hellfire Ramparts and Blood Furnace are separate entrances.",
        "Run back outside, reset Normal instances and repeat Shattered Halls until Exalted. Normal Ramparts/Blood Furnace stop contributing before the end of this grind. Their Heroic versions are optional daily clears that still give reputation toward Exalted. If you hit the instance-entry limit, quest or return later rather than continuing unproductive resets.",
        "Return to Logistics Officer Ulrike at Honor Hold (56.6, 62.6). Find Honor Hold Tabard in her inventory, buy it for up to 1 gold before discounts, and equip it. Check all vendor pages and the All item filter if it is hidden.",
    },
    source = "Logistics Officer Ulrike - Honor Hold, Hellfire Peninsula",
    faction = "alliance", npcId = 17657,
    requirements = "Alliance; Honor Hold Exalted on the buyer.",
    cost = "1 gold base; reputation and other applicable vendor discounts can lower it.",
    tips = "Honor Hold and Thrallmar tabards are separate faction purchases. The tabard is a reward for the completed reputation grind and does not champion Honor Hold in unrelated dungeons.",
    waypoints = {
        pin(100, 56.6, 62.6, 2, "Honor Hold - quests and Logistics Officer Ulrike"),
        pin(100, 47.7, 52.0, 3, "The Shattered Halls - repeat Normal for reputation"),
        pin(100, 47.7, 52.0, 4, "The Shattered Halls - reset Normal until Exalted"),
        pin(100, 56.6, 62.6, 5, "Logistics Officer Ulrike - buy Honor Hold Tabard"),
    },
})

-- https://www.wowhead.com/item=24004#comments:id=74793
-- https://www.wowhead.com/item=24004#comments:id=1407215
-- https://www.wowhead.com/faction=947/thrallmar
-- https://www.wowhead.com/npc=17585/quartermaster-urgronn
addCosmetic(24004, "Thrallmar Tabard", {
    steps = {
        "Use a Horde character and check Thrallmar reputation. Already Exalted characters can skip to the purchase in step 5. This is the Outland faction in Hellfire Peninsula, not a faction awarded by a modern expansion's Hellfire Citadel raid.",
        "Start the Thrallmar quests around 55.0, 38.0 and their Hellfire Peninsula follow-ups for initial reputation. Dungeon quests provide more reputation when available; doing all outdoor quests is not a prerequisite for the repeatable dungeon route.",
        "Set Dungeon Difficulty to NORMAL and go to The Shattered Halls doorway at Hellfire Citadel (47.7, 52.0). Clear its fel-orc packs and bosses. The same kills award Thrallmar on Horde characters and Honor Hold on Alliance characters.",
        "Leave, reset Normal instances and repeat Shattered Halls to Exalted. Normal Hellfire Ramparts and Blood Furnace have earlier reputation caps; use their Heroic versions for optional daily reputation instead. Do not copy old boss-reset tricks or wait for removed heroic-key requirements.",
        "Visit Quartermaster Urgronn outdoors at Thrallmar (54.8, 37.8), beside the main building. Buy Thrallmar Tabard for up to 1 gold before discounts, then equip it to learn the appearance. Browse all vendor pages if needed.",
    },
    source = "Quartermaster Urgronn - Thrallmar, Hellfire Peninsula",
    faction = "horde", npcId = 17585,
    requirements = "Horde; Thrallmar Exalted on the buyer.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "The original faction quartermaster is the clear purchase destination; do not rely on old comments about buying every reputation tabard in Dalaran. Wearing this tabard does not grant additional Thrallmar reputation.",
    waypoints = {
        pin(100, 55.0, 38.0, 2, "Thrallmar - initial faction quests"),
        pin(100, 47.7, 52.0, 3, "The Shattered Halls - Normal reputation farm"),
        pin(100, 47.7, 52.0, 4, "The Shattered Halls - reset Normal until Exalted"),
        pin(100, 54.8, 37.8, 5, "Quartermaster Urgronn - buy Thrallmar Tabard"),
    },
})

-- Item discussion is cosmetic; the faction thread supplies the actionable route.
-- https://www.wowhead.com/item=31804/cenarion-expedition-tabard
-- https://www.wowhead.com/faction=942#comments:id=2558269 and reply
-- https://www.wowhead.com/faction=942#comments:id=6104659
-- https://www.wowhead.com/npc=17904/fedryen-swiftspear
addCosmetic(31804, "Cenarion Expedition Tabard", {
    steps = {
        "Check Cenarion Expedition reputation; both factions can collect this tabard. If already Exalted, skip to step 5. Cenarion Circle is a different reputation and does not unlock this vendor.",
        "For initial reputation, visit Cenarion Refuge in eastern Zangarmarsh (80.2, 64.2). Complete available faction quests. If you have Unidentified Plant Parts, Lauranna Thar'well's turn-ins help only through Friendly; do not buy enough plants expecting them to finish Exalted.",
        "Set Dungeon Difficulty to NORMAL. At Serpent Lake (50.4, 40.9), dive into the large central pipe and swim into Coilfang Reservoir. Surface in the entrance cavern and take The Steamvault portal around 50.3, 33.4. The Underbog and Slave Pens are different portals.",
        "Clear Steamvault trash and bosses, leave, reset Normal instances and repeat until Exalted. Use the access panels after Hydromancer Thespia and Mekgineer Steamrigger to open the last boss's door. Heroic Coilfang clears are optional extra reputation. If combining this with Normal Underbog for Sporeggar, finish the last point to Exalted in Steamvault: comments document Underbog stopping at 20,999/21,000 Revered.",
        "Return to Fedryen Swiftspear at Cenarion Refuge (79.2, 63.8). Buy Cenarion Expedition Tabard for up to 1 gold before discounts, then equip it. This reputation also unlocks the Cenarion War Hippogryph, which is a separate purchase.",
    },
    source = "Fedryen Swiftspear - Cenarion Refuge, Zangarmarsh", npcId = 17904,
    requirements = "Cenarion Expedition Exalted on the buyer; either faction.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "The repeatable Normal Steamvault route avoids relying on obsolete Coilfang Armament quests or old heroic-key attunements. Farming Underbog hibiscus can advance Sporeggar at the same time, but the reputations and tabard purchases remain separate.",
    waypoints = {
        pin(102, 80.2, 64.2, 2, "Cenarion Refuge - quests and early plant-parts turn-ins"),
        pin(102, 50.4, 40.9, 3, "Coilfang Reservoir - underwater pipe entrance"),
        pin(102, 50.3, 33.4, 3, "The Steamvault - portal inside the cavern"),
        pin(102, 50.3, 33.4, 4, "The Steamvault - repeat Normal to Exalted"),
        pin(102, 79.2, 63.8, 5, "Fedryen Swiftspear - buy Cenarion Expedition Tabard"),
    },
})

-- https://www.wowhead.com/item=31775#comments:id=552318
-- https://www.wowhead.com/item=31775#comments:id=6163755
-- https://www.wowhead.com/item=31775#comments:id=90326 and reply
-- https://www.wowhead.com/faction=970#comments:id=2317895 and replies
-- https://www.wowhead.com/faction=970#comments:id=3244866 and replies
-- https://www.wowhead.com/quest=29691/bring-me-a-shrubbery
-- https://www.wowhead.com/quest=29692/bring-me-another-shrubbery
-- https://www.wowhead.com/npc=18382/mycah
addCosmetic(31775, "Sporeggar Tabard", {
    steps = {
        "Check Sporeggar reputation; either faction can earn it. If already Exalted, skip to step 5. Otherwise set Dungeon Difficulty to NORMAL and go to the underwater pipe at Serpent Lake, Zangarmarsh (50.4, 40.9).",
        "Swim through the pipe, surface in Coilfang Reservoir and take the right-hand Underbog portal (54.2, 34.5). Speak to T'shu just inside and accept Bring Me A Shrubbery! (29691). This Retail quest does not require the old outdoor Friendly-reputation unlock.",
        "Pick the glowing Sanguine Hibiscus flowers and loot hibiscus from dungeon enemies. Clear the opening bog-creature section through Hungarfen toward the first naga, then return to T'shu. Herbalism is not required to pick these quest flowers; kills also award Sporeggar reputation.",
        "Hand T'shu 5 Sanguine Hibiscus, then repeat Bring Me Another Shrubbery! (29692), five flowers per turn-in, until Exalted. Leave and reset Normal instances for more flowers as needed. Bought hibiscus work too. From exactly Neutral, with no reputation bonuses or kill reputation, the comments' baseline is 280 flowers; check your actual standing before buying.",
        "Collect 10 Glowcaps from the small mushrooms around western Zangarmarsh, or buy them from players. Keep these separate from Sanguine Hibiscus: Glowcaps pay for the tabard. Reserve another 30 only if you also want the Tiny Sporebat pet.",
        "Visit Mycah at Sporeggar (17.8, 51.2). At Exalted, buy Sporeggar Tabard for 10 Glowcaps and equip it. Reaching the start of Exalted is sufficient; you do not need to fill its final 999-point bar.",
    },
    source = "Mycah - Sporeggar, Zangarmarsh", npcId = 18382,
    requirements = "Sporeggar Exalted on the buyer; either faction.",
    cost = "10 Glowcaps (24245); optional purchased Sanguine Hibiscus at player prices.",
    tips = "Use T'shu inside Underbog for the current hibiscus quests. The old Gzhun'tt quest IDs and instructions to grind outdoor naga first are unnecessary for this route. Normal mode permits repeated full clears without a Heroic boss lockout.",
    waypoints = {
        pin(102, 50.4, 40.9, 1, "Coilfang Reservoir - underwater access pipe"),
        pin(102, 54.2, 34.5, 2, "Underbog portal - T'shu stands inside"),
        pin(102, 54.2, 34.5, 4, "Underbog - repeat hibiscus turn-ins with T'shu inside"),
        pin(102, 17.8, 51.2, 5, "Sporeggar area - gather or bring 10 Glowcaps"),
        pin(102, 17.8, 51.2, 6, "Mycah - buy Sporeggar Tabard"),
    },
})

-- https://www.wowhead.com/item=31774#comments:id=975910
-- https://www.wowhead.com/item=31774#comments:id=1916841 and reply
-- https://www.wowhead.com/faction=978#comments:id=18465
-- https://www.wowhead.com/faction=978#comments:id=1611852
-- https://www.wowhead.com/npc=18408/warden-moibff-jill
-- https://www.wowhead.com/npc=20240/trader-narasu
addCosmetic(31774, "Kurenai Tabard", {
    steps = {
        "Use an Alliance character and check Kurenai reputation. At Exalted, skip to step 6. The Horde counterpart is The Mag'har, and this guide uses Outland Nagrand rather than the Draenor version of that zone.",
        "For the quest route, start with the Kurenai at Orebor Harborage in northern Zangarmarsh (41.5, 27.2), then continue their quests at Telaar in southern Nagrand. These establish friendly access and provide a substantial part of the grind. Ogre kills can also build reputation before the quest hubs open.",
        "Farm Warmaul ogres at Laughing Skull Ruins in northern Nagrand (46.0, 23.0). Kill and loot every ogre for direct Kurenai reputation and Obsidian Warbeads (25433). These are the beads you need, not Oshu'gun Crystal Powder Samples.",
        "If that area is occupied, farm the ogres at Warmaul Hill and its caves (29.0, 26.0). Keep the beads and return to Telaar between farming sessions.",
        "At Telaar, take 10 Obsidian Warbeads to Warden Moi'bff Jill (54.8, 70.8). Complete Fierce Enemies, then repeat More Warbeads! for 500 base Kurenai reputation per 10 beads. Continue ogre kills and turn-ins to Exalted. Do not give those beads to the Consortium while working on this tabard.",
        "Buy Kurenai Tabard from Trader Narasu at Telaar (54.5, 75.1), near the flight master, for up to 1 gold before discounts. Equip it to learn the appearance. The same reputation unlocks the Kurenai talbuks, bought separately.",
    },
    source = "Trader Narasu - Telaar, Outland Nagrand", faction = "alliance", npcId = 20240,
    requirements = "Alliance; Kurenai Exalted on the buyer.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "Ogre kills plus 10-bead turn-ins can finish the reputation without daily resets. This is a cosmetic reward, not a tabard that earns Kurenai reputation in dungeons.",
    waypoints = {
        pin(102, 41.5, 27.2, 2, "Orebor Harborage - initial Kurenai quests"),
        pin(107, 54.8, 70.8, 2, "Telaar - Kurenai quest hub"),
        pin(107, 46.0, 23.0, 3, "Laughing Skull Ruins - ogres and Obsidian Warbeads"),
        pin(107, 29.0, 26.0, 4, "Warmaul Hill - alternative ogre farm"),
        pin(107, 54.8, 70.8, 5, "Warden Moi'bff Jill - 10-bead Kurenai turn-ins"),
        pin(107, 54.5, 75.1, 6, "Trader Narasu - buy Kurenai Tabard"),
    },
})

-- https://www.wowhead.com/item=31773#comments:id=3178138
-- https://www.wowhead.com/faction=941#comments:id=16471
-- https://www.wowhead.com/faction=941#comments:id=58583 and replies
-- https://www.wowhead.com/npc=18407/warden-bullrok
-- https://www.wowhead.com/npc=20241/provisioner-nasela
addCosmetic(31773, "Mag'har Tabard", {
    steps = {
        "Use a Horde character and check The Mag'har reputation. This is the original Outland faction, not the Mag'har Orc allied-race unlock. Allied-race characters do not earn this reputation merely by wearing the tabard. If already Exalted, skip to step 6.",
        "For the story route, take The Assassin from Thrallmar in Hellfire Peninsula and follow its Mag'har-outpost chain, then complete the faction quests at Garadar in Outland Nagrand. Alternatively, reputation from eligible ogre kills can raise your standing until the Mag'har will speak to you.",
        "Farm the Warmaul ogres at Laughing Skull Ruins (46.0, 23.0 in Nagrand). Kill and loot them for direct Mag'har reputation and Obsidian Warbeads (25433). Keep every bead for the turn-in stage.",
        "Use Warmaul Hill and its caves (29.0, 26.0) as an alternative when Laughing Skull is crowded. Continue killing, looting and checking your reputation; no dungeon or daily-quest unlock is needed for this kill farm.",
        "Take batches of 10 Obsidian Warbeads to Warden Bullrok in Garadar (55.8, 37.8). Complete Proving Your Strength, then repeat More Warbeads! for 500 base Mag'har reputation per batch. Repeat kills and turn-ins until Exalted; Consortium bead turn-ins do not advance The Mag'har.",
        "Visit Provisioner Nasela in Garadar (53.5, 36.9). Buy Mag'har Tabard for up to 1 gold before discounts and equip it. The faction's talbuk mounts are optional additional purchases after the same reputation grind.",
    },
    source = "Provisioner Nasela - Garadar, Outland Nagrand", faction = "horde", npcId = 20241,
    requirements = "Horde; The Mag'har Exalted on the buyer.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "Use the Outland Nagrand map. The tabard does not champion The Mag'har in dungeons, and the Mag'har allied race's starting reputation is not a substitute for this grind.",
    waypoints = {
        pin(100, 55.0, 38.0, 2, "Thrallmar - The Assassin and Mag'har introduction"),
        pin(107, 55.8, 37.8, 2, "Garadar - Mag'har quest hub"),
        pin(107, 46.0, 23.0, 3, "Laughing Skull Ruins - ogres and beads"),
        pin(107, 29.0, 26.0, 4, "Warmaul Hill - alternative ogre farm"),
        pin(107, 55.8, 37.8, 5, "Warden Bullrok - 10-bead Mag'har turn-ins"),
        pin(107, 53.5, 36.9, 6, "Provisioner Nasela - buy Mag'har Tabard"),
    },
})

-- https://www.wowhead.com/item=31778/lower-city-tabard
-- https://www.wowhead.com/faction=1011#comments:id=32622
-- https://www.wowhead.com/faction=1011#comments:id=1164683
-- https://www.wowhead.com/npc=21655/nakodu
addCosmetic(31778, "Lower City Tabard", {
    steps = {
        "Check Lower City reputation on the purchasing character. Either faction can collect the tabard. If already Exalted, skip to step 5. Aldor/Scryer allegiance does not prevent earning Lower City reputation.",
        "For early reputation, take the Lower City quests in Shattrath and the refugee-camp quests in the Bone Wastes. Arakkoa Feather turn-ins with Vekax in Lower City help through Friendly, but cannot finish the Exalted grind.",
        "Set Dungeon Difficulty to NORMAL and enter Shadow Labyrinth, the south wing of Auchindoun in Terokkar Forest, with its portal around 39.6, 73.5. Clear the cultists, demons and bosses. This dungeon grants Lower City reputation all the way to Exalted.",
        "Run back to the entrance, leave and reset Normal instances for another clear. Loot Marks of Sargeras and Fel Armaments if you also want Aldor reputation; those items are separate turn-ins and are not needed to receive Lower City kill reputation. Heroic Auchindoun clears are optional additional reputation.",
        "At Exalted, return to Nakodu in Shattrath's Lower City market (62.0, 69.0). Buy Lower City Tabard for up to 1 gold before discounts, then equip it. He is not the Aldor quartermaster or the vendor beside A'dal.",
    },
    source = "Nakodu - Lower City market, Shattrath City", npcId = 21655,
    requirements = "Lower City Exalted on the buyer; either faction and either Shattrath allegiance.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "The physical reputation tabard does not boost Lower City gains. Normal Shadow Labyrinth is the straightforward finishing route; early feather turn-ins are optional and capped. Keep useful Aldor drops rather than vendoring them accidentally.",
    waypoints = {
        pin(111, 62.0, 69.0, 2, "Lower City market - faction quartermaster and nearby quest hubs"),
        pin(108, 39.6, 73.5, 3, "Shadow Labyrinth - south Auchindoun dungeon portal"),
        pin(108, 39.6, 73.5, 4, "Shadow Labyrinth - repeat Normal; save Aldor turn-in items"),
        pin(111, 62.0, 69.0, 5, "Nakodu - buy Lower City Tabard"),
    },
})

-- https://www.wowhead.com/item=31779#comments:id=5912011 and corrected quest names in reply
-- https://www.wowhead.com/item=31779#comments:id=2584467 and transmog reply
-- https://www.wowhead.com/faction=932#comments:id=1880720 and replies
-- https://www.wowhead.com/npc=18538/ishanah
-- https://www.wowhead.com/npc=19321/quartermaster-endarin
addCosmetic(31779, "Aldor Tabard", {
    steps = {
        "Choose a character for the Aldor grind. Both factions can join, but gaining Aldor reputation lowers Scryer reputation on that character. If already Aldor Exalted, skip to step 5. Using different characters for the two tabards avoids rebuilding a hostile reputation.",
        "In Shattrath, take A'dal from the Haggard War Veteran and speak to A'dal at the Terrace of Light (54.0, 44.6). Take City of Light from Khadgar beside him (54.6, 44.0), follow the summoned servant's city tour, then choose Allegiance to the Aldor. Follow Ishanah to the Aldor Rise temple.",
        "For a direct turn-in route, buy Fel Armaments (29740), or loot them from eligible Outland demons. Ishanah in the Aldor temple (24.2, 29.8) accepts A Cleansing Light and its repeatable hand-ins. Each armament gives 350 base Aldor reputation. From exactly Neutral with no bonuses or other reputation, 120 armaments cover the 42,000 points to Exalted; buy fewer if quests or your starting standing already supplied some.",
        "For self-farming, clear Normal Shadow Labyrinth in southern Auchindoun, Terokkar Forest (39.6, 73.5), and loot its demons/cultists for Fel Armaments and Marks of Sargeras. Return to Ishanah for armaments and Adyen the Lightwarden on Aldor Rise (30.6, 34.4) for eligible mark hand-ins. Dungeon kills themselves award Lower City, so the Aldor reputation arrives when you turn in the items.",
        "At Aldor Exalted, go to Quartermaster Endarin on Aldor Rise (47.5, 26.3). Buy Aldor Tabard for up to 1 gold before discounts. Ishanah takes armaments; Endarin sells the tabard. They are different NPCs at different ends of the Rise.",
        "Equip the tabard and check the learned appearance before changing allegiance or disposing of it. The physical item requires Aldor Exalted to equip; do not plan around keeping it equipped forever after switching to Scryers. Finish any Aldor recipes and other purchases you want before switching.",
    },
    source = "Quartermaster Endarin - Aldor Rise, Shattrath City", npcId = 19321,
    requirements = "Aldor Exalted on the buyer; Aldor allegiance for its quests and hand-ins.",
    cost = "1 gold base for the tabard. Optional Fel Armaments/marks at player prices.",
    tips = "The high-rated item guide's replies correct its quest names: City of Light is Khadgar's tour; A Cleansing Light is Ishanah's Fel Armament turn-in. The appearance can be available on eligible alts without their own Aldor grind, but physical equip restrictions and hostile allegiance still matter.",
    waypoints = {
        pin(111, 54.0, 44.6, 2, "A'dal - Shattrath introduction"),
        pin(111, 54.6, 44.0, 2, "Khadgar - City of Light and Aldor allegiance"),
        pin(111, 24.2, 29.8, 3, "Ishanah - Fel Armament hand-ins in the temple"),
        pin(108, 39.6, 73.5, 4, "Shadow Labyrinth - farm Fel Armaments and Marks of Sargeras"),
        pin(111, 30.6, 34.4, 4, "Adyen the Lightwarden - eligible mark hand-ins"),
        pin(111, 24.2, 29.8, 4, "Ishanah - return with Fel Armaments"),
        pin(111, 47.5, 26.3, 5, "Quartermaster Endarin - buy Aldor Tabard"),
    },
})

-- https://www.wowhead.com/item=31780#comments:id=1679351
-- https://www.wowhead.com/item=31780#comments:id=2584466
-- https://www.wowhead.com/faction=934#comments:id=3305993 and dungeon-kill clarification
-- https://www.wowhead.com/npc=18530/vorenthal-the-seer
-- https://www.wowhead.com/npc=18531/magistrix-fyalenn
-- https://www.wowhead.com/npc=19331/quartermaster-enuril
addCosmetic(31780, "Scryers Tabard", {
    steps = {
        "Choose a character for the Scryers. Both factions can join, but Scryer gains reduce Aldor reputation on that character. Already Scryer Exalted characters can skip to step 5. An alt with no allegiance is usually simpler than reversing an Aldor grind.",
        "Complete Shattrath's introduction: speak to A'dal at 54.0, 44.6, then take City of Light from Khadgar at 54.6, 44.0 and follow his servant. Choose Allegiance to the Scryers, then complete the introduction to Voren'thal the Seer on Scryer's Tier.",
        "Buy Arcane Tomes (29739), or farm them from eligible Outland blood elves. Voren'thal inside the Seer's Library (42.6, 91.4) accepts Synthesis of Power and repeatable Arcane Tome hand-ins, worth 350 base reputation each. From exactly Neutral with no other gains, 120 tomes cover Exalted; your starting standing, quests and bonuses change the number needed.",
        "To farm your own items, set NORMAL and clear the blood elf sections of The Botanica in Netherstorm (71.7, 54.9). Loot Arcane Tomes and Sunfury Signets; clear the rest and use the exit behind the final boss, or return outside and reset. Give eligible signet batches to Magistrix Fyalenn on Scryer's Tier (45.4, 81.4), and tomes to Voren'thal. Botanica kills award The Sha'tar, not Scryer reputation: the Scryer gains come from these hand-ins.",
        "At Scryers Exalted, visit Quartermaster Enuril (60.4, 64.0) on Scryer's Tier. He is separate from Fyalenn and the Seer's Library. Buy Scryers Tabard for up to 1 gold before discounts.",
        "Equip the tabard and confirm the appearance. Finish other Scryer purchases before switching to Aldor: the physical tabard requires Scryers Exalted to equip again, even if you owned it earlier. Do not rely on the old leave-it-equipped workaround.",
    },
    source = "Quartermaster Enuril - Scryer's Tier, Shattrath City", npcId = 19331,
    requirements = "The Scryers Exalted on the buyer; Scryer allegiance for its hand-ins.",
    cost = "1 gold base for the tabard. Optional Arcane Tomes/signets at player prices.",
    tips = "Arcane Tomes are reputation turn-ins; the tabard costs gold, not the Arcane Runes received during that process. Aldor and Scryer allegiance are independent of Alliance/Horde faction.",
    waypoints = {
        pin(111, 54.0, 44.6, 2, "A'dal - Shattrath introduction"),
        pin(111, 54.6, 44.0, 2, "Khadgar - City of Light and Scryer allegiance"),
        pin(111, 42.6, 91.4, 3, "Voren'thal the Seer - Arcane Tome hand-ins"),
        pin(109, 71.7, 54.9, 4, "The Botanica - blood elves drop tomes and signets"),
        pin(111, 45.4, 81.4, 4, "Magistrix Fyalenn - eligible Sunfury Signet hand-ins"),
        pin(111, 42.6, 91.4, 4, "Voren'thal - return with Arcane Tomes"),
        pin(111, 60.4, 64.0, 5, "Quartermaster Enuril - buy Scryers Tabard"),
    },
})

-- https://www.wowhead.com/item=31781/shatar-tabard
-- https://www.wowhead.com/faction=935#comments:id=215896
-- https://www.wowhead.com/faction=935#comments:id=1796166 and replies
-- https://www.wowhead.com/faction=935#comments:id=2360781
-- https://www.wowhead.com/npc=21432/almaador
addCosmetic(31781, "Sha'tar Tabard", {
    steps = {
        "Check The Sha'tar reputation. Either faction and either Aldor/Scryer allegiance can collect this tabard. If already Exalted, skip to step 5. Sha'tari Skyguard and the Draenor Sha'tari Defense are different reputations.",
        "Fly to Tempest Keep in eastern Netherstorm and enter The Botanica, the northern side satellite at 71.7, 54.9. Set Dungeon Difficulty to NORMAL. Entering The Eye, the central raid building, does not follow this reputation route.",
        "Clear Botanica's trash and bosses for The Sha'tar reputation, including the blood elf rooms and plant sections. Use the exit behind Warp Splinter to return outside, reset Normal instances, then repeat. Normal kills continue giving reputation toward Exalted.",
        "For variety, The Mechanar (70.6, 69.8) and The Arcatraz (74.4, 57.7) also award this faction's reputation. Their Heroic versions, and Heroic Botanica, are optional daily clears. Save Botanica's Arcane Tomes and Sunfury Signets if also working on Scryers, but those are separate item turn-ins.",
        "At Exalted, return to Almaador beside A'dal on Shattrath's Terrace of Light (51.2, 41.6). Buy Sha'tar Tabard for up to 1 gold before discounts and equip it. Do not buy a Skyguard tabard from Grella by mistake.",
    },
    source = "Almaador - Terrace of Light, Shattrath City", npcId = 21432,
    requirements = "The Sha'tar Exalted on the buyer; either faction or Shattrath allegiance.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "Normal Botanica's exit makes repeated clears convenient. The tabard itself does not increase reputation gains, and farming the Tempest Keep raid is not a substitute for the three five-player dungeons.",
    waypoints = {
        pin(109, 71.7, 54.9, 2, "The Botanica - Normal dungeon entrance"),
        pin(109, 71.7, 54.9, 3, "The Botanica - reset Normal to Exalted"),
        pin(109, 70.6, 69.8, 4, "The Mechanar - alternative Sha'tar dungeon"),
        pin(109, 74.4, 57.7, 4, "The Arcatraz - alternative Sha'tar dungeon"),
        pin(111, 51.2, 41.6, 5, "Almaador - buy Sha'tar Tabard"),
    },
})

-- https://www.wowhead.com/item=31776#comments:id=79821 and reply
-- https://www.wowhead.com/item=31776#comments:id=1329029 and replies
-- https://www.wowhead.com/faction=933#comments:id=1384817 and replies
-- https://www.wowhead.com/faction=933#comments:id=5998580 and smaller-pull correction
-- https://www.wowhead.com/npc=18265/gezhe
-- https://www.wowhead.com/npc=20242/karaaz
-- https://www.wowhead.com/npc=23007/paulstaats
addCosmetic(31776, "Consortium Tabard", {
    steps = {
        "Check The Consortium reputation. Either faction can earn it. At Exalted, skip to step 6. This faction is separate from Kurenai and The Mag'har, even though all three can accept Obsidian Warbeads.",
        "For the dungeon route, enter Mana-Tombs, the north wing of Auchindoun in Terokkar Forest (39.6, 57.7). Set Dungeon Difficulty to HEROIC. Normal Mana-Tombs helps early standings but has a reputation cap and is not the finishing route.",
        "Clear the Heroic trash while leaving EVERY boss alive. Bypass Pandemonius, Tavarok and Nexus-Prince Shaffar, loot the enemies, return outside, reset and repeat. Avoiding boss kills allows the trash route to be reset without creating a Heroic boss save. Smaller pulls are sensible if a large dragged pack fails to award reputation, as a later reply reports.",
        "If you prefer outdoor turn-ins, reach Friendly with the Consortium at Aeris Landing in western Nagrand, then give batches of 10 Obsidian Warbeads to Gezhe (31.4, 57.6) for the repeatable More Obsidian Warbeads quest. This advances the Consortium, not your faction's talbuk reputation.",
        "Farm those beads from Nagrand ogres at Laughing Skull Ruins (46.0, 23.0) or Warmaul Hill (29.0, 26.0), or buy them. Repeat Heroic trash clears and/or eligible bead turn-ins until Consortium Exalted. If you kill a Heroic boss accidentally, use the bead route or return after the lockout resets.",
        "Buy Consortium Tabard from Karaaz at the Stormspire in Netherstorm (43.5, 34.5), or from Paulsta'ats at Aeris Landing in Nagrand (30.5, 57.0). Both sell the same tabard for up to 1 gold before discounts. Only one purchase is needed; equip it to learn the appearance.",
    },
    source = "Karaaz - Stormspire, Netherstorm; Paulsta'ats - Aeris Landing alternative", npcId = 20242,
    requirements = "The Consortium Exalted on the buyer; either faction.",
    cost = "1 gold base for the tabard; optional bought Obsidian Warbeads at player prices.",
    tips = "Do not wear a reputation-championing city tabard that redirects dungeon gains away from the intended faction. Ethereum Prison Keys are not needed for this route, avoiding their separate quest unlock and random friendly-prisoner outcomes.",
    waypoints = {
        pin(108, 39.6, 57.7, 2, "Mana-Tombs - north Auchindoun portal; set Heroic"),
        pin(108, 39.6, 57.7, 3, "Mana-Tombs - reset trash without killing bosses"),
        pin(107, 31.4, 57.6, 4, "Gezhe - Consortium Obsidian Warbead turn-ins"),
        pin(107, 46.0, 23.0, 5, "Laughing Skull Ruins - alternative bead farm"),
        pin(107, 29.0, 26.0, 5, "Warmaul Hill - alternative bead farm"),
        pin(109, 43.5, 34.5, 6, "Karaaz - buy Consortium Tabard"),
        pin(107, 30.5, 57.0, 6, "Paulsta'ats - alternative tabard vendor"),
    },
})

-- https://www.wowhead.com/item=31777#comments:id=248849 and reply
-- https://www.wowhead.com/faction=989#comments:id=2430890
-- https://www.wowhead.com/faction=989#comments:id=5841830
-- https://www.wowhead.com/npc=21643/alurmi
-- https://www.wowhead.com/npc=18723/erozion
-- https://www.wowhead.com/npc=17876/thrall
-- https://www.wowhead.com/npc=15608/medivh
addCosmetic(31777, "Keepers of Time Tabard", {
    steps = {
        "Check Keepers of Time reputation. This tabard belongs to the Bronze dragons' original Caverns of Time faction, not the later Timewalkers. If already Exalted, skip to step 6.",
        "Go to the Caverns of Time entrance in Tanaris (64.8, 49.9), descend into the cavern and speak to the Steward of Time. Complete To The Master's Lair and Andormu's Caverns of Time tour if you have not already done the introduction. Let the guide finish before leaving.",
        "Follow the original Old Hillsbrad chain: take Old Hillsbrad and enter the Escape from Durnholde dungeon. Speak to Erozion near the entrance cave (28.8, 48.2 on the Old Hillsbrad map), then travel to Durnholde around 68.6, 69.6. Plant the incendiary bombs in its five internment lodges, turn in to Thrall in the keep, and escort him through the event to Tarren Mill around 50.5, 31.6. Turn in the follow-up and return to Andormu. This introduces the original Black Morass route.",
        "Set Dungeon Difficulty to NORMAL and enter The Black Morass, also called Opening of the Dark Portal. On the Caverns of Time map its portal is around 37.2, 83.3. Complete the initial quest with Sa'at if offered and approach Medivh to begin the event.",
        "Find Medivh around 48.7, 72.0 on The Black Morass map and defend him through all 18 portals. Kill each Rift Lord/Rift Keeper and the three bosses rather than only the incidental wildlife; the timed event supplies the reputation. After Aeonus, turn in any available event quest, leave, reset Normal instances and repeat to Exalted. Heroic Black Morass and Heroic Old Hillsbrad are optional daily additions.",
        "Visit Alurmi inside the Caverns of Time at 40.0, 77.0 on the interior Caverns of Time map. She is the Keepers of Time Quartermaster, not an outdoor vendor on the surface of Tanaris. Buy Keepers of Time Tabard for up to 1 gold before discounts.",
        "Equip the tabard and check the appearance. You do not need an old Heroic key, a raid attunement or a Timewalking event to buy it. Wearing it does not turn unrelated dungeon kills into Keepers of Time reputation.",
    },
    source = "Alurmi - inside the Caverns of Time, Tanaris", npcId = 21643,
    requirements = "Keepers of Time Exalted on the buyer; either faction.",
    cost = "1 gold base, before applicable vendor discounts.",
    tips = "The map separates Tanaris from the interior Caverns of Time map. The Black Morass event can be repeated on Normal; killing wildlife outside the portal waves is not the reputation route. Do not confuse Keepers of Time with the Scale of the Sands raid faction.",
    waypoints = {
        pin(71, 64.8, 49.9, 2, "Caverns of Time - enter and descend to the quest hub"),
        pin(75, 26.8, 36.8, 3, "Old Hillsbrad - original Durnholde introduction"),
        pin(274, 28.8, 48.2, 3, "Erozion - dungeon introduction at the entrance cave", "Old Hillsbrad Foothills (Durnholde)"),
        pin(274, 68.6, 69.6, 3, "Durnholde Keep - lodges and Thrall's escape", "Old Hillsbrad Foothills (Durnholde)"),
        pin(274, 50.5, 31.6, 3, "Tarren Mill - finish Thrall's escort", "Old Hillsbrad Foothills (Durnholde)"),
        pin(75, 37.2, 83.3, 4, "The Black Morass - original Dark Portal event dungeon"),
        pin(75, 37.2, 83.3, 5, "The Black Morass - repeat Normal event clears"),
        pin(273, 48.7, 72.0, 5, "Medivh - defend the Dark Portal through all 18 waves", "The Black Morass"),
        pin(75, 40.0, 77.0, 6, "Alurmi - buy Keepers of Time Tabard inside the cavern"),
    },
})

-- Both item threads and the quest replies correct the former random-box tricks.
-- https://www.wowhead.com/item=31404#comments:id=2358871
-- https://www.wowhead.com/item=31405#comments:id=2358870
-- https://www.wowhead.com/item=31405#comments:id=558738 and final reply
-- https://www.wowhead.com/quest=10793#comments:id=1622643 and replies
-- https://www.wowhead.com/quest=10781#comments:id=1622654 and replies
-- https://www.wowhead.com/npc=21979/valzareq-the-conqueror
for _, cosmetic in ipairs({
    { 31404, "Green Trophy Tabard of the Illidari" },
    { 31405, "Purple Trophy Tabard of the Illidari" },
}) do
    local itemID, name = unpack(cosmetic)
    addCosmetic(itemID, name, {
        steps = {
            "Use a character of level 25 or higher and go to Shadowmoon Valley in OUTLAND, not Draenor. Either faction and any class can earn both Illidari tabards. You do not need to be a Demon Hunter, finish the Demon Hunter campaign or enter Black Temple.",
            "Find Val'zareq the Conqueror and his patrol on the Path of Conquest, roughly between 50.5, 59.0 and 53.0, 68.5. Kill him, loot The Journal of Val'zareq (31345), then use the journal from your bags to start The Journal of Val'zareq: Portends of War (10793). Search along the patrol route rather than waiting at a single spawn pin.",
            "Take the journal quest to the Crystal Prison at 51.4, 72.8. Speak to the trapped Marcus Auralion in the crystal and turn it in. Accept Battle of the Crimson Watch (10781) when you are ready: it starts a wave event at this location.",
            "Remain by the prison, defeat every wave and then Torloth the Magnificent. Wait through the scripted pauses until the final enemy is attackable, and stay until the quest marks complete. On a high-level Retail character the original group recommendation is usually unnecessary; bring help if you are doing it at the content's level.",
            "Return to A'dal in Shattrath's Terrace of Light (54.0, 44.6) and turn in Battle of the Crimson Watch. Current Retail awards BOTH Green Trophy Tabard of the Illidari and Purple Trophy Tabard of the Illidari. Choose any accompanying ring reward and collect the tabards; no random-color reroll is needed.",
            "Equip both tabards and check both appearances. If an older character already completed the quest but lacks one color, speak to Linsa nearby (58.6, 46.6) and check the lost-tabard dialogue for that completed quest. The old auto-loot, wait-two-hours and item-restoration tricks are not part of a fresh Retail completion.",
        },
        source = "A'dal - Battle of the Crimson Watch, started by Val'zareq's journal",
        category = "Quests", npcId = 18481,
        requirements = "Level 25+; complete the journal quest and Battle of the Crimson Watch. Either faction and any class.",
        cost = "Quest reward; one completion awards both tabard colors.",
        tips = "The two colors share one acquisition route. The Path of Conquest pin is a patrol area, while the Crystal Prison is a fixed event location. A warlock on the green-fire scenario can encounter phasing interference in this area; check that quest state if the normal journal patrol or prison is absent.",
        waypoints = {
            pin(104, 51.5, 64.0, 2, "Path of Conquest - search Val'zareq's north-south patrol"),
            pin(104, 51.4, 72.8, 3, "Crystal Prison - journal turn-in and event start"),
            pin(104, 51.4, 72.8, 4, "Crystal Prison - waves and Torloth"),
            pin(111, 54.0, 44.6, 5, "A'dal - turn in quest for BOTH Illidari tabards"),
            pin(111, 58.6, 46.6, 6, "Linsa - optional replacement for a completed older quest"),
        },
    })
end

-- https://www.wowhead.com/item=32445#comments:id=92431
-- https://www.wowhead.com/item=32445#comments:id=103337 and replies (old level requirement)
-- https://www.wowhead.com/faction=1031#comments:id=1963404
-- https://www.wowhead.com/faction=1031#comments:id=3226823 and replies
-- https://www.wowhead.com/npc=23367/grella
addCosmetic(32445, "Skyguard Tabard", {
    steps = {
        "Check Sha'tari Skyguard reputation. If already Exalted, skip to step 10. Otherwise speak to Yuula beside Shattrath's flight master (64.0, 42.0). Complete Threat from Above by killing the Gordunni ogres in the Barrier Hills north of the city, around 22.0, 12.0 on the Terokkar Forest map. Return and follow To Skettis to Blackwind Landing (64.0, 66.8).",
        "At Blackwind Landing, take World of Shadows from Severin. Kill Skettis arakkoa for 6 Shadow Dust and hand it in for Elixir of Shadows. Drink the elixir to see time-lost arakkoa, then keep it active while farming them.",
        "Kill Talonpriest Ishaal around 69.3, 78.5, loot Ishaal's Almanac and start its quest. Take it to Sky Commander Adaris at Blackwind Landing. Follow An Ally in Lower City to Rilak the Redeemed in Shattrath (52.6, 20.8), then return to Adaris with Countdown to Doom.",
        "Speak to Hazzik beside Adaris (64.2, 66.8). For Hazzik's Bargain, retrieve Hazzik's Package from the ground-level hut in UPPER Veil Shil'ak (74.8, 80.2), then return. The lower settlement and treetop platforms are the wrong search area.",
        "Take A Shabby Disguise. Use the supplied disguise, enter Sahaak's hut on the central island (67.0, 79.0), and buy Adversarial Bloodlines for 3 gold. Return the book to Hazzik and accept Adversarial Blood.",
        "With Elixir of Shadows active, kill time-lost arakkoa for 40 Time-Lost Scrolls per full summon cycle. At a SMALL Skull Pile, such as 69.6, 74.6, spend 10 scrolls to summon each of four different descendants: Darkscreecher Akkarai, Karrog, Gezzarak the Huntress and Vakkiz the Windrager. Loot their four different tokens.",
        "Give one of each token to Hazzik for a Time-Lost Offering. Complete Adversarial Blood first, then use Tokens of the Descendants for later exchanges. Take Terokk's Downfall from Adaris and use the LARGE Skull Pile on Terokk's Rest island (66.2, 77.5) with an Offering to summon Terokk.",
        "Defeat Terokk and turn in the quest. If he becomes immune, wait for the Skyguard bombing run and draw him into the blue fire to remove the shield. His large pile has a respawn delay of roughly 15 minutes; farm elsewhere between summons.",
        "Repeat arakkoa/treant kills, Shadow Dust hand-ins, the four-descendant exchanges and Terokk summons until Sha'tari Skyguard Exalted. Refresh the elixir. Bombing and escort dailies provide optional additional reputation; the repeatable route does not require waiting for daily resets. Scrolls and Offerings can also be bought from players.",
        "Buy Skyguard Tabard from Grella at Blackwind Landing (64.2, 66.2) for up to 1 gold before discounts and equip it. The same reputation unlocks the nether ray mounts, which are separate purchases.",
    },
    source = "Grella - Blackwind Landing, Terokkar Forest", npcId = 23367,
    requirements = "Sha'tari Skyguard Exalted; level 27 to equip the physical tabard. Flying helps reach Skettis and its platforms.",
    cost = "1 gold base for the tabard; 3 gold for Adversarial Bloodlines during the summon unlock. Optional bought reagents cost extra.",
    tips = "Sha'tari Skyguard is separate from The Sha'tar. Keep four different descendant tokens, not four of one kind. Use small piles for descendants and the large island pile for Terokk. The Retail tooltip requires level 27 to equip the tabard, replacing the old level-70 requirement in early comments.",
    waypoints = {
        pin(111, 64.0, 42.0, 1, "Yuula - Threat from Above"),
        pin(108, 22.0, 12.0, 1, "Barrier Hills - Gordunni ogres"),
        pin(108, 64.0, 66.8, 1, "Blackwind Landing - Adaris and Severin"),
        pin(108, 64.0, 66.8, 2, "Severin - Shadow Dust and Elixir of Shadows"),
        pin(108, 69.3, 78.5, 3, "Talonpriest Ishaal - loot the Almanac"),
        pin(111, 52.6, 20.8, 3, "Rilak the Redeemed - Almanac translation"),
        pin(108, 64.0, 66.8, 3, "Adaris - return with Countdown to Doom"),
        pin(108, 64.2, 66.8, 4, "Hazzik - begin the package quest"),
        pin(108, 74.8, 80.2, 4, "Upper Veil Shil'ak - Hazzik's Package"),
        pin(108, 67.0, 79.0, 5, "Sahaak - buy Adversarial Bloodlines while disguised"),
        pin(108, 69.6, 74.6, 6, "Small Skull Pile - four descendant summons"),
        pin(108, 64.2, 66.8, 7, "Hazzik - exchange four different tokens"),
        pin(108, 66.2, 77.5, 7, "Terokk's Rest - large Skull Pile"),
        pin(108, 66.2, 77.5, 8, "Terokk - defeat and wait between summons"),
        pin(108, 64.2, 66.2, 10, "Grella - buy Skyguard Tabard"),
    },
})

-- Item page is chiefly old shard-to-gold discussion, not an acquisition guide.
-- https://www.wowhead.com/item=32828#comments:id=117486 and replies (cost context)
-- https://www.wowhead.com/faction=1038#comments:id=1959331 (old group prerequisite unnecessary)
-- https://www.wowhead.com/faction=1038#comments:id=1997118 and outpost-coordinate replies
-- https://www.wowhead.com/faction=1038#comments:id=3373838
-- https://www.wowhead.com/quest=11058#comments:id=1890034 and six-round correction
-- https://www.wowhead.com/quest=11058#comments:id=6068322 (Retail 2025)
-- https://www.wowhead.com/quest=11058#comments:id=6357859 (Retail 2026)
-- https://www.wowhead.com/npc=23428/jhonass
addCosmetic(32828, "Ogri'la Tabard", {
    steps = {
        "Check Ogri'la reputation. Already Exalted characters can go to step 9. Otherwise fly to Ogri'la on the western Blade's Edge Mountains plateau. Enable Trivial Quests and speak directly to Chu'a'lor (28.8, 57.4); the old five-player Mog'dorg chain is not required to open these dailies.",
        "Take The Crystals (11025), gather 5 Apexis Shards from plateau creatures or shard formations, and return to Chu'a'lor. Gather extra shards for the subsequent activities, and eventually keep 10 unspent for the tabard. These are bag-item Apexis Shards (32569), not Draenor's Apexis Crystal currency.",
        "Complete An Apexis Relic (11058). At a small relic circle around 33.1, 51.4, insert a shard and watch the lights. After each demonstrated sequence finishes, click the same four pads in that order; repeat until the objective completes. Stand over one small circle and write its pad sequence as 1-4 if the colors are hard to follow. This opens The Relic's Emanation daily, with a longer sequence.",
        "Take Our Boy Wants To Be A Skyguard Ranger from Torkus (28.4, 57.5). Spend 10 shards at the Fel Crystalforge in Forge Camp: Wrath, around 32.9, 40.5, for ONE Unstable Flask of the Beast, then bring the flask back. Do not drink it or spend shards on extra flasks. Follow any remaining local one-time quests for additional reputation.",
        "Take The Skyguard Outpost from Chu'a'lor and visit Sky Commander Keller just north at 27.5, 52.6. Unlock Bombing Run with Sky Sergeant Vanderlip (27.5, 52.8), then Bomb Them Again!. While flying, use the supplied bombs on cannonball stacks in the forge camps and keep moving to evade flak.",
        "Also take Wrangle Some Aether Rays! from Skyguard Khatie at 28.0, 51.5. Use the quest rope on five plateau aether rays; high-level characters should try the rope before attacking so they do not accidentally one-shot their targets. Turn it in to unlock Wrangle More Aether Rays!.",
        "At Honored, speak to Kronk in Ogri'la (28.8, 57.8), complete Banish the Demons, then add Banish More Demons to the daily circuit. Open the portal with the supplied item and shard, bring demons close to it, then kill them in its range. Pull without damaging them first if your normal attack would kill them too far away.",
        "Repeat the daily circuit from BOTH camps until Exalted: The Relic's Emanation and, once unlocked, Banish More Demons in Ogri'la; Bomb Them Again! and Wrangle More Aether Rays! at the Skyguard Outpost. Turn each quest in and return after the daily reset. Doing only the ogre camp's quests misses two available reputation sources.",
        "Keep 10 Apexis Shards in your bags and visit Jho'nass at Ogri'la (28.0, 58.5). Buy Ogri'la Tabard and equip it. The shard cost is 10, not an Apexis Crystal, gold purchase or a stack consumed by a summoning monument.",
    },
    source = "Jho'nass - Ogri'la, Blade's Edge Mountains", npcId = 23428,
    requirements = "Ogri'la Exalted on the buyer; either faction. Flying for plateau access and bombing quests.",
    cost = "10 Apexis Shards (32569) for the tabard; additional shards for the unlock quests and daily activities.",
    tips = "The ordinary daily route takes repeated daily resets; there is no equivalent dungeon reputation farm. Old comments describing a broken relic game were later updated: Retail 2025/2026 comments describe working completions. Wait for the entire displayed sequence before entering your response.",
    waypoints = {
        pin(105, 28.8, 57.4, 1, "Chu'a'lor - start directly at Ogri'la"),
        pin(105, 28.8, 57.4, 2, "Chu'a'lor - The Crystals; gather shards nearby"),
        pin(105, 33.1, 51.4, 3, "Small Apexis relic circle - repeat the light sequence"),
        pin(105, 28.4, 57.5, 4, "Torkus - flask unlock quest"),
        pin(105, 32.9, 40.5, 4, "Fel Crystalforge - buy one Unstable Flask of the Beast"),
        pin(105, 27.5, 52.6, 5, "Sky Commander Keller - Skyguard Outpost introduction"),
        pin(105, 27.5, 52.8, 5, "Sky Sergeant Vanderlip - bombing quests"),
        pin(105, 32.9, 40.5, 5, "Forge Camp: Wrath - cannonball stacks"),
        pin(105, 28.0, 51.5, 6, "Skyguard Khatie - aether ray wrangling"),
        pin(105, 28.8, 57.8, 7, "Kronk - Honored demon-banishing unlock"),
        pin(105, 28.8, 57.4, 8, "Ogri'la - relic and banishing daily turn-ins"),
        pin(105, 27.5, 52.8, 8, "Skyguard Outpost - bombing and wrangling dailies"),
        pin(105, 28.0, 58.5, 9, "Jho'nass - buy tabard with 10 Apexis Shards"),
    },
})

-- https://www.wowhead.com/item=35221#comments:id=1640291 (numbered farming itinerary)
-- https://www.wowhead.com/item=35221#comments:id=260863 and reputation-cap correction
-- https://www.wowhead.com/faction=1077#comments:id=1184586
-- https://www.wowhead.com/npc=25032/eldara-dawnrunner
-- https://www.wowhead.com/npc=25084#comments (Midnight: Shattrath portal reaches the old island)
-- https://www.wowhead.com/object=187056/shattrath-portal-to-isle-of-queldanas
addCosmetic(35221, "Tabard of the Shattered Sun", {
    steps = {
        "Check Shattered Sun Offensive reputation; both factions can collect the tabard. If already Exalted, go to step 5. Use the original Burning Crusade Isle of Quel'Danas, map 122, rather than Midnight's new island and Magisters' Terrace.",
        "Go to Shattrath and take the portal to the Isle of Quel'Danas in the Terrace of Light alcove, around 49.0, 42.3. This is the Retail access to the old island even after Midnight. On arrival, pick up available Shattered Sun daily quests if you want to combine questing with the dungeon grind.",
        "Set Dungeon Difficulty to NORMAL and enter the original Magisters' Terrace at 61.2, 30.9. Clear the dungeon's trash and bosses through Kael'thas Sunstrider for Shattered Sun Offensive reputation. Use the exit orb after the final boss, leave, reset Normal instances and repeat.",
        "Continue Normal clears until Exalted. You can add a Heroic clear and the island dailies between runs; Heroic has a daily boss lockout. The comments' old claim that Normal bosses stop giving reputation at Revered was corrected in its replies. The Sunwell Plateau raid does not supply this reputation, and the old realm-wide island-building stages are not a prerequisite.",
        "At Exalted, visit Eldara Dawnrunner inside the building in the Shattered Sun staging area (47.2, 30.6). Buy Tabard of the Shattered Sun for up to 1 gold before discounts. This is the reputation quartermaster, not one of the island's legacy raid-gear vendors.",
        "Equip the tabard and check the appearance. You do not need to pay the separate 1,000-gold donation for the 'of the Shattered Sun' title. If you also want the Swift White Hawkstrider, that mount's Heroic drop restriction is separate from this tabard's repeatable Normal reputation route.",
    },
    source = "Eldara Dawnrunner - original Isle of Quel'Danas staging area", npcId = 25032,
    requirements = "Shattered Sun Offensive Exalted on the buyer; either faction. Use the original island via Shattrath.",
    cost = "1 gold base, before applicable vendor discounts. The title donation is not required.",
    tips = "The map deliberately uses the original Isle of Quel'Danas (#122). The new Midnight island (#2424) and its dungeons are different destinations. Dungeon kills supply the reputation; this tabard itself does not grant championing.",
    waypoints = {
        pin(111, 49.0, 42.3, 2, "Shattrath portal - original Isle of Quel'Danas"),
        pin(122, 61.2, 30.9, 3, "Original Magisters' Terrace - Normal reputation farm", "Isle of Quel'Danas (Burning Crusade)"),
        pin(122, 61.2, 30.9, 4, "Original Magisters' Terrace - repeat to Exalted", "Isle of Quel'Danas (Burning Crusade)"),
        pin(122, 47.2, 30.6, 5, "Eldara Dawnrunner - buy Tabard of the Shattered Sun", "Isle of Quel'Danas (Burning Crusade)"),
    },
})

-- Retail availability reviewed 2026-11-04. All 19 registered tabards retain
-- quest or reputation routes. Tabard of the Protector was already absent;
-- the still-available Blood Knight Tabard uses the replacement class quest.
-- https://www.wowhead.com/guide/vanity-collections/guide-to-collecting-tabards
-- https://www.wowhead.com/item=24344/tabard-of-the-hand#comments
-- https://www.wowhead.com/item=31404/green-trophy-tabard-of-the-illidari#comments
local function rate(level, reason, itemIDs)
    for _, itemID in ipairs(itemIDs) do
        local guide = guides[itemID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end
rate("medium", "Complete the Draenei-only reward chain and its scripted demolition escort.", {24344})
rate("easy", "Complete the short eligible Paladin class quest, breaking its weapons at the Black Anvil.", {25549})
rate("medium", "Reach Exalted with repeatable legacy dungeon clears, then buy the tabard.", {23999,24004,31804,31778,31781,31777,35221})
rate("medium", "Reach Sporeggar Exalted with repeatable hibiscus turn-ins and gather 10 Glowcaps for the tabard.", {31775})
rate("medium", "Farm ogres and repeatable warbead turn-ins to Exalted with the correct faction.", {31774,31773})
rate("medium", "Choose the matching Shattrath faction and gather or buy its reputation turn-ins to Exalted.", {31779,31780})
rate("medium", "Repeat Consortium insignia or warbead turn-ins, or Heroic Mana-Tombs, until Exalted.", {31776})
rate("easy", "Finish the short Crimson Watch quest chain; current completion grants access to both tabard colors.", {31404,31405})
rate("medium", "Unlock Skettis and repeat Sha'tari Skyguard reputation farming to Exalted.", {32445})
rate("hard", "Unlock both daily hubs and repeat their limited daily quests across many resets to reach Ogri'la Exalted.", {32828})
