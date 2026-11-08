-- Hand-reviewed Classic-tab cosmetic guides, Retail only (2026-11-01).
-- Availability and difficulty reviewed 2026-11-04: 11 obtainable tabards retained.
-- Tabard of the Argent Dawn is excluded: original-owner replacements do not
-- provide new acquisition. https://www.wowhead.com/item=22999#comments
-- Read all 695 item parent comments; none contained a profit-ending guide.
-- Acquisition threads, including hidden replies, were read through Wowhead's
-- public comment/show-replies endpoint. These are original, edited walkthroughs,
-- checked against Retail vendor costs and NPC locations rather than copied posts.
-- Only reachable Retail destinations are pinned. The restored original Armory
-- is accessible in Retail; its unlock is explained before the farming route.
-- UiMapGroupMember identifies Armory as 304 and Harlan's Athenaeum as 432.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.cosmetics = {
    [15196] = {
        difficulty = "easy",
        difficultyReason = "Obtain one Mark of Honor and buy the faction tabard; no old PvP rank or reputation grind is required.",
        name = "Private's Tabard",
        acquisition = table.concat({
            "1. Use an Alliance character. This is the Alliance enlisted tabard; you do not need the Private title, an old PvP rank or a reputation grind. Check your tabard appearances first if you may already own it.",
            "2. Put 1 Mark of Honor (137642) in this character's bags. Obtain marks from PvP reward containers or send spare account-bound marks from an alt. For an Honor conversion, Seltherex in Valdrakken (44.5, 37.4) sells Orboreal Distinguishment (185834) for 2,000 Honor; open it for 5 marks. Skip this detour if you already have a mark.",
            "3. Go to Rebecca Laughlin in Stormwind's Visitor's Center, in the Trade District near the main gates (64.0, 77.2). She is the Tabard Designer, not a battleground quest giver.",
            "4. Browse her vendor inventory for Private's Tabard and buy it for 1 Mark of Honor. Check all vendor pages and select All in the item filter if necessary. The old 50-Honor price and separate Arathi/Warsong battleground tokens are obsolete.",
            "5. Equip the tabard and confirm that its appearance is learned in the Wardrobe. Do not budget around buying, equipping and refunding it: the acquisition comments explicitly correct that old refund trick. Wearing it does not award the Private title or give dungeon reputation.",
        }, "\n\n"),
        stepCount = 5,
        npcId = 5193,
        source = "Rebecca Laughlin - Stormwind Visitor's Center",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Alliance; no PvP rank or reputation requirement.",
        cost = "1 Mark of Honor (137642). Optional conversion: 2,000 Honor buys a container of 5 marks.",
        tips = "This and Knight's Colors can be absent from the uncollected appearance list until purchased. Search the vendor's inventory as well as the Wardrobe. The original rank-one requirement was removed in patch 2.0.1.",
        faction = "alliance",
        wowheadUrl = "https://www.wowhead.com/item=15196",
        -- https://www.wowhead.com/item=15196#comments:id=840097
        -- https://www.wowhead.com/item=15196#comments:id=1016181
        -- https://www.wowhead.com/item=15196#comments:id=2864830
        -- Retail sold-by table: Rebecca Laughlin charges 1 x item 137642.
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional Honor-to-marks conversion", npcID = 199601, locationType = "NPC" },
            { mapID = 84, x = 0.640, y = 0.772, step = 3, label = "Rebecca Laughlin - buy Private's Tabard", npcID = 5193, locationType = "NPC" },
        },
    },
    [15197] = {
        difficulty = "easy",
        difficultyReason = "Obtain one Mark of Honor and buy the faction tabard; no old PvP rank or reputation grind is required.",
        name = "Scout's Tabard",
        acquisition = table.concat({
            "1. Use a Horde character. Scout's Tabard is the Horde enlisted tabard. The old Scout rank is not required and purchasing it does not grant that title.",
            "2. Collect 1 Mark of Honor (137642), either from PvP reward containers or by sending account-bound marks from an alt. If you have Honor instead, visit Seltherex in Valdrakken (44.5, 37.4), buy Orboreal Distinguishment for 2,000 Honor and open it for 5 marks. You only spend one of those marks on this tabard.",
            "3. Visit Garyl, the Tabard Designer in Orgrimmar's Valley of Strength, around 47.5, 75.5. Open his vendor inventory rather than looking for a quest or an old rank-unlock dialogue.",
            "4. Find Scout's Tabard and buy it for 1 Mark of Honor. Browse the remaining pages and switch the vendor filter to All if it is not visible. You do not need to win one Arathi Basin and one Warsong Gulch: those comments describe the removed battleground-token system.",
            "5. Equip it and check the learned tabard appearance. Keep the purchase unless you are certain the appearance is learned; comments about an automatic full refund were subsequently corrected. This is a cosmetic tabard, not a reputation-boosting tabard.",
        }, "\n\n"),
        stepCount = 5,
        npcId = 5188,
        source = "Garyl - Valley of Strength, Orgrimmar",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Horde; no PvP rank or reputation requirement.",
        cost = "1 Mark of Honor (137642). Optional conversion: 2,000 Honor buys 5 marks.",
        tips = "The original rank-one requirement was removed in patch 2.0.1. Current Marks of Honor are bag items; the Honor number in the Currency window is a different resource. Private's Tabard is the Alliance counterpart.",
        faction = "horde",
        wowheadUrl = "https://www.wowhead.com/item=15197",
        -- https://www.wowhead.com/item=15197#comments:id=734557 (refund corrections in replies)
        -- https://www.wowhead.com/item=15197#comments:id=1991591 (old Honor prices, superseded by sold-by data)
        -- https://www.wowhead.com/npc=5188/garyl
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional Honor-to-marks conversion", npcID = 199601, locationType = "NPC" },
            { mapID = 85, x = 0.475, y = 0.755, step = 3, label = "Garyl - buy Scout's Tabard", npcID = 5188, locationType = "NPC" },
        },
    },
    [15198] = {
        difficulty = "easy",
        difficultyReason = "Obtain one Mark of Honor and buy the faction tabard; no old PvP rank or reputation grind is required.",
        name = "Knight's Colors",
        acquisition = table.concat({
            "1. Use an Alliance character. Knight's Colors is the officer-style tabard. You no longer need the Knight rank, a rated battleground rating or reputation with a PvP faction.",
            "2. Obtain 1 Mark of Honor (137642) from a PvP reward container or an alt. Alternatively, buy Orboreal Distinguishment from Seltherex in Valdrakken (44.5, 37.4) for 2,000 Honor and open it for 5 marks. Skip the conversion if you already have the required mark.",
            "3. Enter the Visitor's Center in Stormwind's Trade District near the city gates and speak to Rebecca Laughlin (64.0, 77.2). Her tabard inventory includes Knight's Colors as well as Private's Tabard.",
            "4. Buy Knight's Colors for 1 Mark of Honor. Check the item name carefully: the similar enlisted tabard is a separate appearance. Clear vendor filters and browse all pages if necessary; the old 100-Honor cost is no longer this vendor's price.",
            "5. Equip it and confirm the Wardrobe unlock. This does not give you the Knight title, bonus stats or reputation. Do not use old comments describing Horde purchases in Shattrath as a current route; that cross-faction purchase was a fixed bug.",
        }, "\n\n"),
        stepCount = 5,
        npcId = 5193,
        source = "Rebecca Laughlin - Stormwind Visitor's Center",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Alliance; no old Knight rank, rating or reputation requirement.",
        cost = "1 Mark of Honor (137642). Optional conversion: 2,000 Honor buys 5 marks.",
        tips = "The original rank-six requirement was removed in patch 2.0.1. Purchase refunds are not a reliable collection method. Historical Horde owners report that later patches prevent re-equipping the Alliance item; Stone Guard's Herald is the intended Horde counterpart.",
        faction = "alliance",
        wowheadUrl = "https://www.wowhead.com/item=15198",
        -- https://www.wowhead.com/item=15198#comments:id=804128
        -- https://www.wowhead.com/item=15198#comments:id=1004112
        -- https://www.wowhead.com/item=15198#comments:id=1551831
        -- https://www.wowhead.com/item=15198#comments:id=3166780
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional Honor-to-marks conversion", npcID = 199601, locationType = "NPC" },
            { mapID = 84, x = 0.640, y = 0.772, step = 3, label = "Rebecca Laughlin - buy Knight's Colors", npcID = 5193, locationType = "NPC" },
        },
    },
    [15199] = {
        difficulty = "easy",
        difficultyReason = "Obtain one Mark of Honor and buy the faction tabard; no old PvP rank or reputation grind is required.",
        name = "Stone Guard's Herald",
        acquisition = table.concat({
            "1. Use a Horde character and check whether this tabard appearance is already learned. Stone Guard's Herald is the officer tabard; you do not need the retired Stone Guard rank to buy it.",
            "2. Put 1 Mark of Honor (137642) in your bags, using PvP reward containers or account-bound marks from an alt. If converting Honor, go to Seltherex in Valdrakken (44.5, 37.4), buy Orboreal Distinguishment for 2,000 Honor and open it for 5 marks. Only one mark is needed here.",
            "3. Find Garyl, the Tabard Designer in the Valley of Strength in Orgrimmar (47.5, 75.5). Open his vendor inventory and browse the tabards.",
            "4. Buy Stone Guard's Herald for 1 Mark of Honor. Do not accidentally buy Scout's Tabard, whose design is similar but whose Horde emblem is smaller. Use All in the vendor filter and check the remaining pages if the item is missing.",
            "5. Equip the purchased tabard and confirm the learned appearance. There is no current requirement to collect 20 tokens from each of three battlegrounds, and the old 100-Honor price is obsolete. Buying this appearance does not award a PvP rank or increase reputation gains.",
        }, "\n\n"),
        stepCount = 5,
        npcId = 5188,
        source = "Garyl - Valley of Strength, Orgrimmar",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Horde; no old Stone Guard rank, rating or reputation requirement.",
        cost = "1 Mark of Honor (137642). Optional conversion: 2,000 Honor buys 5 marks.",
        tips = "The original rank-six requirement was removed in patch 2.0.1. Knight's Colors is the Alliance counterpart. Treat the mark as spent; old buy-and-refund collection instructions do not describe a dependable Retail method.",
        faction = "horde",
        wowheadUrl = "https://www.wowhead.com/item=15199",
        -- https://www.wowhead.com/item=15199#comments:id=234753 (emblem distinction in reply)
        -- https://www.wowhead.com/item=15199#comments:id=283540 (historical rank in replies)
        -- https://www.wowhead.com/npc=5188/garyl
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional Honor-to-marks conversion", npcID = 199601, locationType = "NPC" },
            { mapID = 85, x = 0.475, y = 0.755, step = 3, label = "Garyl - buy Stone Guard's Herald", npcID = 5188, locationType = "NPC" },
        },
    },
    [19031] = {
        difficulty = "medium",
        difficultyReason = "Earn ten Marks of Honor and buy the faction tabard; the former battleground reputation requirement was removed.",
        name = "Frostwolf Battle Tabard",
        acquisition = table.concat({
            "1. Use a Horde character and budget 10 Marks of Honor (137642). Frostwolf reputation is not required for this tabard; the old instruction to combine it with an Exalted mount grind is optional, not an unlock condition.",
            "2. Collect the marks from PvP reward containers or an alt. An alternative is Seltherex in Valdrakken (44.5, 37.4): buy and open two Orboreal Distinguishments, at 2,000 Honor each, for 10 marks total. This costs 4,000 Honor if you start with no marks.",
            "3. Go to Jorek Ironside in Hillsbrad Foothills (58.0, 33.5), outside the Horde Alterac Valley entrance. You can visit this outdoor vendor without queuing for or entering a battleground.",
            "4. Browse all of Jorek's vendor pages, choose All in the item filter if needed, and buy Frostwolf Battle Tabard for 10 Marks of Honor. Older comments quoting 2,678 or 2,679 Honor predate the current cost.",
            "5. If visiting Hillsbrad is inconvenient, Garyl in Orgrimmar's Valley of Strength (47.5, 75.5) also lists the tabard for the same 10 marks. This is an alternative vendor, not a second required purchase.",
            "6. Equip the tabard and check the Wardrobe unlock. It does not increase Frostwolf reputation, either in Alterac Valley or in dungeons. Do not expect a full currency refund after learning it.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 13219,
        source = "Jorek Ironside - Hillsbrad Foothills; Garyl - Orgrimmar alternative",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Horde; no Frostwolf reputation or PvP rank required.",
        cost = "10 Marks of Honor. Optional conversion from zero marks: 4,000 Honor for two containers of 5 marks.",
        tips = "Stormpike Battle Tabard is the Alliance counterpart. A missing item on a filtered vendor page is not evidence of an Exalted requirement. These are modern account-bound Marks of Honor, not the removed Alterac Valley battleground tokens.",
        faction = "horde",
        wowheadUrl = "https://www.wowhead.com/item=19031",
        -- https://www.wowhead.com/item=19031#comments:id=3151335
        -- https://www.wowhead.com/item=19031#comments:id=494638 (no reputation effect)
        -- https://www.wowhead.com/item=19031#comments:id=2445694 (tooltip clarification in reply)
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 25, x = 0.580, y = 0.335, step = 3, label = "Jorek Ironside - outdoor Frostwolf supply officer", npcID = 13219, locationType = "NPC" },
            { mapID = 85, x = 0.475, y = 0.755, step = 5, label = "Garyl - alternative Frostwolf tabard vendor", npcID = 5188, locationType = "NPC" },
        },
    },
    [19032] = {
        difficulty = "medium",
        difficultyReason = "Earn ten Marks of Honor and buy the faction tabard; the former battleground reputation requirement was removed.",
        name = "Stormpike Battle Tabard",
        acquisition = table.concat({
            "1. Use an Alliance character. You need 10 Marks of Honor (137642), but no Stormpike reputation rank. This tabard and the Stormpike mount have separate purchases; you do not need to buy a mount first.",
            "2. Gather 10 marks from PvP reward containers or mail account-bound marks from an alt. To use Honor instead, Seltherex in Valdrakken (44.5, 37.4) sells Orboreal Distinguishment: open two for 10 marks, costing 4,000 Honor in total.",
            "3. Visit Thanthaldis Snowgleam at the Alliance Alterac Valley approach in Hillsbrad Foothills (44.6, 46.5). He stands outside the battleground, so no match or battleground entry is required.",
            "4. Find Stormpike Battle Tabard in his inventory and buy it for 10 Marks of Honor. Browse all pages and use the All filter if necessary. Ignore the old Friendly-reputation/gold price and the later 2,678-Honor price; neither is the current purchase.",
            "5. Alternatively, Rebecca Laughlin in Stormwind's Visitor's Center (64.0, 77.2) lists the same tabard for 10 marks. Use whichever vendor is more convenient; only one purchase is necessary.",
            "6. Equip it and confirm the appearance is learned. The tabard does not grant Stormpike reputation in battlegrounds or dungeons. Later replies correct the old buy-equip-refund advice, so plan to spend the marks permanently.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 13217,
        source = "Thanthaldis Snowgleam - Hillsbrad Foothills; Rebecca Laughlin - Stormwind alternative",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Alliance; no Stormpike reputation or PvP rank required.",
        cost = "10 Marks of Honor. Optional conversion from zero marks: 4,000 Honor for 10 marks.",
        tips = "Frostwolf Battle Tabard is the Horde counterpart. The supply officer is an outdoor vendor. The old comments about obtaining Alliance tabards on Horde characters through Shattrath describe a fixed bug.",
        faction = "alliance",
        wowheadUrl = "https://www.wowhead.com/item=19032",
        -- https://www.wowhead.com/item=19032#comments:id=2357197
        -- https://www.wowhead.com/item=19032#comments:id=1100199 (Rebecca alternative in reply)
        -- https://www.wowhead.com/item=19032#comments:id=1201510
        -- https://www.wowhead.com/item=19032#comments:id=904281 (no championing in reply)
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 25, x = 0.446, y = 0.465, step = 3, label = "Thanthaldis Snowgleam - outdoor Stormpike supply officer", npcID = 13217, locationType = "NPC" },
            { mapID = 84, x = 0.640, y = 0.772, step = 5, label = "Rebecca Laughlin - alternative Stormpike tabard vendor", npcID = 5193, locationType = "NPC" },
        },
    },
    [19505] = {
        difficulty = "medium",
        difficultyReason = "Earn ten Marks of Honor and buy the faction tabard; the former battleground reputation requirement was removed.",
        name = "Warsong Battle Tabard",
        acquisition = table.concat({
            "1. Use a Horde character and collect 10 Marks of Honor (137642). You do not need Exalted with Warsong Outriders. The Arathi Basin tabard's reputation restriction does not apply to this Warsong tabard.",
            "2. Get marks from PvP reward containers or an alt. For an Honor conversion, buy two Orboreal Distinguishments from Seltherex in Valdrakken (44.5, 37.4) and open them for 10 marks. Each container costs 2,000 Honor, so this alternative costs 4,000 Honor from zero marks.",
            "3. Go to Kelm Hargunth at Mor'shan Base Camp in Northern Barrens (40.2, 20.0). From the road heading north toward Mor'shan Rampart, take the path on the left between the Horde flags, behind the small pig farm. Follow it uphill to the Warsong Gulch entrance; Kelm is beside it. The Rampart flight-path marker is not the vendor's position.",
            "4. Open Kelm's vendor inventory, switch the class/spec filter to All if necessary and browse the pages for Warsong Battle Tabard. Buy it for 10 Marks of Honor. You do not need the 60 old Warsong Gulch tokens or the obsolete 2,059 Honor quoted in older posts.",
            "5. As a city alternative, visit Garyl in Orgrimmar's Valley of Strength (47.5, 75.5), who also sells this tabard for 10 marks. This avoids the trip to Mor'shan and does not require a second purchase.",
            "6. Equip the tabard and verify the learned appearance. Wearing it provides no Warsong Outriders reputation bonus. The historical refund method was corrected in later comments and is not a dependable way to collect it for free.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 14754,
        source = "Kelm Hargunth - Mor'shan Base Camp, Northern Barrens; Garyl alternative",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Horde; no Warsong Outriders reputation or PvP rank required.",
        cost = "10 Marks of Honor. Optional conversion from zero marks: 4,000 Honor for 10 marks.",
        tips = "Silverwing Battle Tabard is the Alliance counterpart. Kelm is in Northern Barrens, not beside the Alliance quartermaster in Ashenvale. His vendor filter can hide useful items even when they are usable by your class.",
        faction = "horde",
        wowheadUrl = "https://www.wowhead.com/item=19505",
        -- https://www.wowhead.com/item=19505#comments:id=973962
        -- https://www.wowhead.com/item=19505#comments:id=1697087
        -- https://www.wowhead.com/item=19505#comments:id=2458109 (nonrefundable purchase in reply)
        -- https://www.wowhead.com/npc=14754#comments:id=1569535
        -- https://www.wowhead.com/npc=14754#comments:id=1818035
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 10, x = 0.402, y = 0.200, step = 3, label = "Kelm Hargunth - uphill at Mor'shan Base Camp", npcID = 14754, locationType = "NPC" },
            { mapID = 85, x = 0.475, y = 0.755, step = 5, label = "Garyl - alternative Warsong tabard vendor", npcID = 5188, locationType = "NPC" },
        },
    },
    [19506] = {
        difficulty = "medium",
        difficultyReason = "Earn ten Marks of Honor and buy the faction tabard; the former battleground reputation requirement was removed.",
        name = "Silverwing Battle Tabard",
        acquisition = table.concat({
            "1. Use an Alliance character and prepare 10 Marks of Honor (137642). Exalted with Silverwing Sentinels is not required. Comments discussing the League of Arathor requirement concern a different tabard.",
            "2. Collect marks from PvP reward containers or an alt. Alternatively, Seltherex in Valdrakken (44.5, 37.4) sells Orboreal Distinguishment for 2,000 Honor each. Buy and open two for 10 marks total, costing 4,000 Honor if you have no marks already.",
            "3. Go to Illiyana Moonblaze at Silverwing Grove in southern Ashenvale (61.5, 83.8), near the Alliance Warsong Gulch entrance. She is outdoors; entering or winning a Warsong Gulch match is not part of the purchase.",
            "4. Browse her vendor inventory for Silverwing Battle Tabard, checking all pages and selecting All in the item filter if necessary. Buy it for 10 Marks of Honor. The old Warsong tokens and 2,059-Honor price are obsolete.",
            "5. If Stormwind is more convenient, Rebecca Laughlin in the Trade District's Visitor's Center (64.0, 77.2) also sells it for 10 marks. This is an alternative to Illiyana, not another required stage of the unlock.",
            "6. Equip the tabard and check the learned appearance. It does not increase Silverwing Sentinels reputation. Once the appearance is learned it remains in the Wardrobe, but do not expect to recover the marks through the old refund trick.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 14753,
        source = "Illiyana Moonblaze - Silverwing Grove, Ashenvale; Rebecca Laughlin alternative",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Alliance; no Silverwing Sentinels reputation or PvP rank required.",
        cost = "10 Marks of Honor. Optional conversion from zero marks: 4,000 Honor for 10 marks.",
        tips = "Warsong Battle Tabard is the Horde counterpart. Do not confuse this with Arathor Battle Tabard: Arathor still requires Exalted for the physical purchase. The Silverwing comment thread explicitly separates those two requirements.",
        faction = "alliance",
        wowheadUrl = "https://www.wowhead.com/item=19506",
        -- https://www.wowhead.com/item=19506#comments:id=123666 (10 marks, no reputation in replies)
        -- https://www.wowhead.com/item=19506#comments:id=1557780
        -- https://www.wowhead.com/item=19506#comments:id=1333931
        -- https://www.wowhead.com/item=19506#comments:id=5232080
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 2, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 63, x = 0.615, y = 0.838, step = 3, label = "Illiyana Moonblaze - Silverwing Grove supply officer", npcID = 14753, locationType = "NPC" },
            { mapID = 84, x = 0.640, y = 0.772, step = 5, label = "Rebecca Laughlin - alternative Silverwing tabard vendor", npcID = 5193, locationType = "NPC" },
        },
    },
    [20132] = {
        difficulty = "hard",
        difficultyReason = "Reach Exalted with the Arathi Basin faction on the purchasing character and spend ten Marks of Honor; Comp Stomp can ease the long reputation grind.",
        name = "Arathor Battle Tabard",
        acquisition = table.concat({
            "1. Choose the Alliance character that will make the purchase. That character must be Exalted with The League of Arathor. Check the Wardrobe first: a learned appearance can already be available to alts even though buying the physical tabard still has a reputation requirement.",
            "2. Queue for Arathi Basin through the PvP window's Specific Battleground option. Capture and defend bases so your team generates resources; reputation is awarded as resources accumulate, including in losing games. Repeat until the Reputation panel shows Exalted with The League of Arathor. Use an Arathi Basin bonus event when available, and queue as your own faction: replies warn that Mercenary Mode can give no reputation for this grind.",
            "3. Gather 10 Marks of Honor (137642) from PvP reward containers or an alt. If converting Honor, buy and open two Orboreal Distinguishments from Seltherex in Valdrakken (44.5, 37.4), at 2,000 Honor each, for 10 marks total.",
            "4. Travel to Refuge Pointe in Arathi Highlands. If Samuel Hawke is absent or only appears on your minimap, visit Zidormi near the southern bridge from Wetlands (38.2, 90.0) and ask to see Arathi before the war. Return to Refuge Pointe afterwards. This is a phase change for finding the vendor, not another reputation grind.",
            "5. Speak to Samuel Hawke, the League of Arathor Supply Officer, at 40.1, 46.5 in the older Retail phase. Check all vendor pages and the All filter, then buy Arathor Battle Tabard for 10 Marks of Honor on your Exalted character. Control Five Bases is no longer required; do not try to obtain or share that removed quest.",
            "6. Equip the tabard and confirm the Wardrobe unlock. Check your other characters' tabard appearances before repeating the reputation grind. Horde characters use their faction's counterpart, Battle Tabard of the Defilers; the physical Alliance item is not a cross-faction disguise.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 15127,
        source = "Samuel Hawke - Refuge Pointe, Arathi Highlands",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Alliance; Exalted with The League of Arathor on the purchasing character.",
        cost = "10 Marks of Honor. Optional conversion: 4,000 Honor for 10 marks.",
        tips = "Buying it needs Exalted, not a completed five-base quest or 999/1000 beyond Exalted. Reputation rates and the old estimates of hundreds of games changed repeatedly, so track your live progress. If Zidormi has no pre-war option, character-specific Battle for Azeroth War Campaign/Uniting Kul Tiras unlocks may be needed; changing phase alone does not solve every reported missing-vendor case.",
        faction = "alliance",
        wowheadUrl = "https://www.wowhead.com/item=20132",
        -- https://www.wowhead.com/item=20132#comments:id=6951 (quest removal in reply)
        -- https://www.wowhead.com/item=20132#comments:id=2583668 (updated alt appearance information)
        -- https://www.wowhead.com/npc=15127#comments:id=258153 (Retail price/Exalted correction in replies)
        -- https://www.wowhead.com/npc=15127#comments:id=5998907 (Zidormi route and later failure report)
        -- https://www.wowhead.com/npc=141649#comments:id=6278345
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 3, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 14, x = 0.382, y = 0.900, step = 4, label = "Zidormi - pre-war Arathi phase if the vendor is missing", npcID = 141649, locationType = "NPC" },
            { mapID = 14, x = 0.401, y = 0.465, step = 5, label = "Samuel Hawke - Exalted character buys the tabard", npcID = 15127, locationType = "NPC" },
        },
    },
    [20131] = {
        difficulty = "hard",
        difficultyReason = "Reach Exalted with the Arathi Basin faction on the purchasing character and spend ten Marks of Honor; Comp Stomp can ease the long reputation grind.",
        name = "Battle Tabard of the Defilers",
        acquisition = table.concat({
            "1. Use a Horde character that is Exalted with The Defilers, or choose the character on which you will earn that reputation. Check the Wardrobe first if another character already collected it; appearance access and buying another physical tabard have different requirements.",
            "2. Select Arathi Basin in the PvP window's Specific Battleground queue. Capture and hold bases to generate resources for your team; reputation arrives as resources build up, so losses can still advance the grind. Continue until The Defilers is Exalted on your buyer. Arathi Basin bonus events help. Stay in your own faction's queue: a detailed acquisition comment reports no reputation from Mercenary Mode.",
            "3. Put 10 Marks of Honor (137642) in that character's bags. Use PvP reward containers or marks from an alt. For an Honor alternative, visit Seltherex in Valdrakken (44.5, 37.4) and open two Orboreal Distinguishments, costing 4,000 Honor total, for 10 marks.",
            "4. Go to Arathi Highlands and the Hammerfall area. If you are in the warfront or another changed phase and cannot find Rutherford Twing, speak to Zidormi at 38.2, 90.0 near the Wetlands bridge and choose Arathi before the war, then return north.",
            "5. Find Rutherford Twing, the Defilers Supply Officer, at 68.5, 30.5 near the Arathi Basin approach in the older Retail phase. Browse his pages with the All filter and buy Battle Tabard of the Defilers for 10 Marks of Honor. The purchasing character still needs Exalted. The removed Take Five Bases quest and its five-base capture are not required.",
            "6. Equip the tabard and confirm its appearance is learned. Check your alts' Wardrobes before doing the reputation grind again. Eligible Horde alts can use the learned Horde appearance; Alliance characters use Arathor Battle Tabard instead. Wearing this tabard does not itself speed up the reputation grind.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 15126,
        source = "Rutherford Twing - Hammerfall / Arathi Basin approach, Arathi Highlands",
        sourceType = "PvP",
        category = "PvP",
        requirements = "Horde; Exalted with The Defilers on the purchasing character.",
        cost = "10 Marks of Honor. Optional conversion: 4,000 Honor for 10 marks.",
        tips = "This is the Classic PvP tabard that still needs Exalted for purchase; Warsong and Frostwolf tabards do not. Do not follow old 2,679-Honor prices or five-base quest instructions. If Zidormi lacks the phase dialogue, character-specific Battle for Azeroth War Campaign/Uniting Zandalar unlocks may be needed. The vendor pin is 68.5, 30.5, rather than the old approximate Hammerfall marker.",
        faction = "horde",
        wowheadUrl = "https://www.wowhead.com/item=20131",
        -- https://www.wowhead.com/item=20131#comments:id=2356675
        -- https://www.wowhead.com/item=20131#comments:id=125732 (reply corrects claim that reputation is unnecessary)
        -- https://www.wowhead.com/item=20131#comments:id=2878404 (appearance sharing, including replies)
        -- https://www.wowhead.com/item=20131#comments:id=5231122 (Mercenary Mode warning)
        -- https://www.wowhead.com/npc=15126/rutherford-twing
        waypoints = {
            { mapID = 2112, x = 0.445, y = 0.374, step = 3, label = "Seltherex - optional conversion for 10 marks", npcID = 199601, locationType = "NPC" },
            { mapID = 14, x = 0.382, y = 0.900, step = 4, label = "Zidormi - pre-war Arathi phase if the vendor is missing", npcID = 141649, locationType = "NPC" },
            { mapID = 14, x = 0.685, y = 0.305, step = 5, label = "Rutherford Twing - Exalted character buys the tabard", npcID = 15126, locationType = "NPC" },
        },
    },
    [23192] = {
        difficulty = "medium",
        difficultyReason = "Farm the restored old Armory's trainees after its key unlock, or repeat Scarlet Halls for Armsmaster Harlan's rare drop.",
        name = "Tabard of the Scarlet Crusade",
        acquisition = table.concat({
            "1. Choose a character for the farm. Any class can collect the tabard appearance. If you also want the optional Darkmoon Faire armor in step 12, use a plate wearer for the Scale ensemble or a mail wearer for the Chain ensemble; the physical tabard is bind-on-pickup. For the restored Old Scarlet Monastery route, obtain The Scarlet Key (208485) from the Auction House or another player if your account has not unlocked it. Buying the key works outside Hallow's End. If the account is already unlocked, skip the purchase. For a route requiring no key, use steps 8-9 instead.",
            "2. Travel to Tirisfal Glades. If you see the blighted post-Battle for Lordaeron version, talk to Zidormi at 69.4, 62.8 and ask to see Tirisfal before the battle. The Old Keyring can be missing in the wrong phase; a current dungeon portal alone does not confirm the original dungeon is active.",
            "3. Go to the Scarlet Monastery building near 85.6, 30.8. Walk inside and up the stairs into the entrance vestibule. Find the Old Keyring on the left wall around 83.9, 32.1 on the Tirisfal map. If your account is not already unlocked, bring The Scarlet Key in your bags, then accept and immediately complete The Scarlet Key (77644) there. The quest consumes the item and unlocks access for your account.",
            "4. Click the Old Keyring again to gain The Scarlet Key buff. It is a buff on your character, not another key in your bags. If it does not appear immediately after the quest, relog and interact again. Set dungeon difficulty to Normal before entering. With the buff active, open the door to the OLD ARMORY in the vestibule and enter. The two obvious portal entrances lead to other old wings while this buff is active; choose the Armory door rather than Graveyard, Library or Cathedral.",
            "5. Clear the Old Armory's corridors to Herod's circular boss room (approximately 78.5, 12.0 on the Scarlet Monastery: Armory map). Kill Herod. If the boss is Armsmaster Harlan instead, you entered modern Scarlet Halls; leave and check the keyring buff for the original route.",
            "6. Wait for the roughly 20 Scarlet Trainees to rush into Herod's room, then kill and loot them all. These trainees are the tabard source on this route; do not leave after looting Herod. Deal damage yourself rather than letting only a pet or passive damage effect kill every trainee. Check all loot: an individual kill or a complete run is not a guaranteed tabard.",
            "7. If no tabard drops, walk out, right-click your portrait and choose Reset All Instances, then re-enter the Armory and repeat steps 5-6. Pause if you hit the hourly instance-entry limit. Replies report both quick drops and more than 100 runs, so do not treat somebody else's first-run drop as a promised result.",
            "8. Alternative without unlocking the old dungeon: use the regular Scarlet Halls entrance in the same monastery building. If you previously enabled the Old Keyring buff, click the ring to remove it first. Set difficulty to Normal so the run can be repeated; this route uses Armsmaster Harlan, not Herod's original trainees.",
            "9. In Scarlet Halls, pass the archery training area, defeat Houndmaster Braun and let his event clear the guards blocking the way. Continue to Armsmaster Harlan in the Athenaeum (61.8, 44.7 on that floor's map), kill him and loot the BOSS for the tabard chance. You do not need to wait for adds to spawn. If it does not drop, leave and reset as in step 7. Heroic drops are also reported, but switching to Heroic is not required and does not guarantee better odds.",
            "10. Once it drops, equip Tabard of the Scarlet Crusade and confirm the appearance is learned. Keep the actual tabard if you want the Darkmoon Faire purchases. Transmogrifying another tabard to this appearance does not satisfy the vendor's equipment check.",
            "11. Optional follow-up: while Darkmoon Faire is active, take the character holding the physical tabard to Darkmoon Island. Equip that tabard and visit the Scarlet Quartermaster near the pony/petting-zoo area in the southeast (58.0, 80.5). Her trade dialogue becomes available while you are wearing it.",
            "12. Buy only the extra appearances you want: Cropped Tabard of the Scarlet Crusade costs 25,000 gold; Ensemble: Scale of the Scarlet Crusade costs 10,000 gold for plate wearers; Ensemble: Chain of the Scarlet Crusade costs 10,000 gold for mail wearers. The ensembles require level 13 to buy. To obtain both armor types, farm a physical tabard on the corresponding plate and mail characters. The tabard itself is already collected at step 10; these purchases are optional.",
        }, "\n\n"),
        stepCount = 12,
        npcId = 6575,
        source = "Scarlet Trainees - restored Old Scarlet Monastery: Armory; Armsmaster Harlan - Scarlet Halls alternative",
        sourceType = "Dungeon and Raids",
        category = "Dungeon and Raids",
        requirements = "Either faction. Old Armory: account-wide Scarlet Key unlock. Scarlet Halls alternative: no key. Darkmoon ensembles: matching armor type and level 13.",
        cost = "No currency cost for the drop. The optional Scarlet Key purchase has a variable player price. Optional Darkmoon purchases: 25,000g cropped tabard; 10,000g per eligible armor ensemble.",
        availability = "Obtainable in Retail through the restored original Armory and Scarlet Halls. Darkmoon purchases require the Faire to be active.",
        tips = "Old Scarlet Monastery is restored Retail content, not a Classic-client instruction. There is no dependable run-count guarantee. A missing Dungeon Journal entry does not mean the tabard was removed. Do not sell your only physical copy before the optional Darkmoon visit. Old reports that the quartermaster rejects Dracthyr were addressed by the May 2023 hotfix; they are not a current class restriction.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=23192",
        -- https://www.wowhead.com/item=23192#comments:id=5747239 (all 24 replies, including Sept. 2026 confirmation)
        -- https://www.wowhead.com/item=23192#comments:id=5707120 (all 6 replies; one reports 112 runs)
        -- https://www.wowhead.com/item=23192#comments:id=6028812 (cross-checked: Doan's chest is in LIBRARY, not Graveyard)
        -- https://www.wowhead.com/item=23192#comments:id=1867426 (Harlan boss, not his adds)
        -- https://www.wowhead.com/item=23192#comments:id=2363034 (physical equipment / armor-type restrictions and replies)
        -- https://www.wowhead.com/item=23192#comments:id=6119853 (ensemble purchase level)
        -- https://www.wowhead.com/item=208485#comments:id=5706620 (account unlock, toggle and relog replies)
        -- https://www.wowhead.com/quest=77644#comments:id=5711564 (Tirisfal phase and buff correction)
        -- https://www.wowhead.com/object=406829/old-keyring
        -- https://www.wowhead.com/npc=108785#comments:id=5604673 (Dracthyr hotfix)
        -- https://wago.tools/db2/UiMapGroupMember/csv (Retail dungeon floor identities)
        waypoints = {
            { mapID = 18, x = 0.694, y = 0.628, step = 2, label = "Zidormi - Tirisfal before the Battle for Lordaeron if needed", npcID = 141488, locationType = "NPC" },
            { mapID = 18, x = 0.856, y = 0.308, step = 3, label = "Scarlet Monastery building - walk inside to the vestibule" },
            { mapID = 18, x = 0.839, y = 0.321, step = 3, label = "Old Keyring - quest turn-in and old/new dungeon toggle", questID = 77644 },
            { mapID = 18, x = 0.839, y = 0.321, step = 4, label = "Old Keyring - enable original-dungeon buff" },
            { mapID = 304, mapName = "Old Scarlet Monastery: Armory", x = 0.785, y = 0.120, step = 5, label = "Herod's room - defeat Herod, then kill and loot the trainees", npcID = 3975, locationType = "NPC" },
            { mapID = 304, mapName = "Old Scarlet Monastery: Armory", x = 0.785, y = 0.120, step = 6, label = "Scarlet Trainees - kill and loot the wave after Herod", npcID = 6575, locationType = "NPC" },
            { mapID = 18, x = 0.839, y = 0.321, step = 8, label = "Old Keyring - remove buff for regular Scarlet Halls" },
            { mapID = 432, mapName = "Scarlet Halls: Athenaeum", x = 0.618, y = 0.447, step = 9, label = "Armsmaster Harlan - alternative boss-drop route", npcID = 58632, locationType = "NPC" },
            { mapID = 407, x = 0.580, y = 0.805, step = 11, label = "Scarlet Quartermaster - equip physical tabard for optional purchases", npcID = 108785, locationType = "NPC" },
            { mapID = 407, x = 0.580, y = 0.805, step = 12, label = "Scarlet Quartermaster - optional cropped tabard and ensembles", npcID = 108785, locationType = "NPC" },
        },
    },
}

-- Shared supply route used by the PvP guides; reviewed alongside their comments:
-- https://www.wowhead.com/item=137642#comments:id=3310918 (including 2025 reply)
-- https://www.wowhead.com/item=185834/orboreal-distinguishment
-- https://www.wowhead.com/npc=199601/seltherex

-- Keep the researched difficulty visible in the walkthrough and on its catalogue row.
for _, guide in pairs(TDP.CollectionWalkthroughs.cosmetics) do
    guide.availabilityReviewedAt = "2026-11-04"
    guide.acquisition = "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason .. "\n\n" .. guide.acquisition
end
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^1%.") then
        for _, entry in ipairs(patch.cosmetics) do
            local guide = TDP.CollectionWalkthroughs.cosmetics[entry.itemId]
            if guide then
                entry.difficulty = entry.difficulty or guide.difficulty
                entry.difficultyReason = entry.difficultyReason or guide.difficultyReason
                entry.availabilityReviewedAt = guide.availabilityReviewedAt
            end
        end
    end
end

