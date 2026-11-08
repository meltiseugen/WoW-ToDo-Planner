-- Hand-reviewed Burning Crusade toy walkthroughs for Retail, reviewed 2026-11-01.
-- Read all 420 parent comments across the five item pages and expanded the
-- relevant acquisition/correction threads through /comment/show-replies?id=...
-- None of those item lists contains a profit-ending acquisition walkthrough.
-- These original steps combine the comments, replies and Retail NPC/quest/recipe
-- records. The related Ride the Lightning profit comment supplies only its
-- useful quest mechanic; its closing filler/profit steps are omitted.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.toys = TDP.CollectionWalkthroughs.toys or {}
local guides = TDP.CollectionWalkthroughs.toys

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function addToy(itemID, name, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.sourceType = guide.category
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end

-- Recipe dialogue, current skill threshold and collection-only route, with replies:
-- https://www.wowhead.com/item=30542#comments:id=188258
-- https://www.wowhead.com/item=30542#comments:id=6120240
-- https://www.wowhead.com/item=30542#comments:id=2306710
-- https://www.wowhead.com/item=30542#comments:id=2474221
-- https://www.wowhead.com/npc=21493#comments:id=5536256
-- https://www.wowhead.com/spell=36954/dimensional-ripper-area-52
-- https://www.wowhead.com/quest=29475/goblin-engineering
-- https://www.wowhead.com/npc=5518/lilliam-sparkspindle
-- https://www.wowhead.com/npc=11017/roxxik
-- https://www.wowhead.com/npc=18775/lebowski
-- https://www.wowhead.com/npc=18752/zebig
addToy(30542, "Dimensional Ripper - Area 52", {
    steps = {
        "For collection only, search the Auction House for the finished Dimensional Ripper - Area 52 (30542), or ask a Goblin Engineer to make it. You can add the finished toy without Engineering; buying it does not let an ineligible character teleport. If you obtain one this way, continue at step 7.",
        "For self-crafting, reach Classic Engineering 200 and choose the Goblin specialization. At level 20 or higher, take Goblin Engineering (29475) from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Bring 20 Big Iron Bombs, 20 Solid Dynamite and 5 Explosive Sheep to complete it. Bought quest items work too. Skip this if you are already a Goblin Engineer.",
        "Learn Outland Engineering from Lebowski outside the Honor Hold keep in Hellfire Peninsula (55.6, 65.6, Alliance) or Zebig in Thrallmar (54.8, 38.4, Horde). Raise that expansion's Engineering skill to 50. Classic Engineering and Outland Engineering are separate bars; the old comments' 350 requirement is not 350 points in the current Outland profession.",
        "Visit Kablamm Farflinger beside the transporter in Area 52, Netherstorm (32.8, 63.6). Speak to him and select the dialogue asking how to make the dangerous dimensional device. He teaches the recipe directly when you have Goblin Engineering and Outland Engineering 50. He is not beside the town's ordinary Engineering trainer, and there is no schematic item to buy from a vendor list.",
        "Gather the recipe's actual components: 1 Adamantite Frame, 2 Primal Fire, 2 The Bigger One bombs, 4 Handfuls of Fel Iron Bolts and 1 Khorium Power Core. Buy finished components or make them with Outland Engineering. The Bigger One is a batch craft, so you can have a spare bomb; several older raw-material shopping lists also confuse Arcane Dust with Arcane Powder or use obsolete Khorium totals.",
        "Stand at an anvil, open Outland Engineering and craft Dimensional Ripper - Area 52. If it is missing, clear the Have Materials filter and check that you learned the recipe through Kablamm's dialogue. Raising Outland Engineering to 50 without the Goblin specialization does not unlock it.",
        "Use the finished item from your bags to add it to the account-wide Toy Box. To activate the teleport afterwards, use a Goblin Engineer with Outland Engineering 50. It can put you on a floating rock above Area 52 instead of the pad: arrive with a usable flying mount or another way to leave safely, and do not jump off without fall protection.",
    },
    source = "Goblin Engineering; Kablamm Farflinger's recipe at Area 52, Netherstorm",
    category = "Professions", faction = "all", npcId = 21493,
    requirements = "Collection: no profession. Recipe, crafting and teleport: Goblin Engineering specialization and Outland Engineering 50.",
    cost = "1 Adamantite Frame, 2 Primal Fire, 2 The Bigger One, 4 Handfuls of Fel Iron Bolts, 1 Khorium Power Core; specialization quest items are additional. Finished-toy Auction House prices vary.",
    tips = "Goblin Engineering is a profession specialization, not a race or faction restriction. Buying the finished toy avoids changing specialization for collection. Teleports can cause transformations, soul-split effects or an off-target arrival. Old stance-switching tricks are not an acquisition step.",
    effect = "Teleports an eligible Goblin Engineer to Area 52 in Netherstorm; 4-hour cooldown. Malfunctions can alter your appearance or destination.",
    waypoints = {
        pin(84, 62.8, 32.0, 2, "Lilliam Sparkspindle - Alliance Goblin specialization quest"),
        pin(85, 56.8, 56.4, 2, "Roxxik - Horde Goblin specialization quest"),
        pin(100, 55.6, 65.6, 3, "Lebowski - Alliance Outland Engineering trainer"),
        pin(100, 54.8, 38.4, 3, "Zebig - Horde Outland Engineering trainer"),
        pin(109, 32.8, 63.6, 4, "Kablamm Farflinger - learn recipe through dialogue"),
        pin(109, 32.8, 63.6, 7, "Area 52 transporter - normal arrival"),
    },
})

-- Trainer position, both-faction access, collection and reagent corrections:
-- https://www.wowhead.com/item=30544#comments:id=33213 and replies
-- https://www.wowhead.com/item=30544#comments:id=2306711 and its coordinate reply
-- https://www.wowhead.com/item=30544#comments:id=2355896 and reply
-- https://www.wowhead.com/item=30544#comments:id=1634359 and replies
-- https://www.wowhead.com/item=30544#comments:id=2443530
-- https://www.wowhead.com/npc=21494/smiles-obyron
-- https://www.wowhead.com/spell=36955#comments:id=261102 and replies
-- https://www.wowhead.com/spell=36955#comments:id=5639537
-- https://www.wowhead.com/quest=29477/gnomish-engineering
addToy(30544, "Ultrasafe Transporter: Toshley's Station", {
    steps = {
        "For collection only, buy the finished Ultrasafe Transporter: Toshley's Station (30544) on the Auction House or ask a Gnomish Engineer to craft it. A non-engineer can add it to the Toy Box, although using the teleport still requires the profession and specialization. If you obtain the finished toy, continue at step 7.",
        "For self-crafting, reach Classic Engineering 200 and choose the Gnomish specialization. At level 20 or higher, take Gnomish Engineering (29477) from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Turn in 6 Mithril Tubes, 2 Advanced Target Dummies and 1 Accurate Scope. You can buy these items. Skip this if you are already a Gnomish Engineer.",
        "Train Outland Engineering with Lebowski outside the Honor Hold keep in Hellfire Peninsula (55.6, 65.6, Alliance) or Zebig in Thrallmar (54.8, 38.4, Horde), then raise Outland Engineering to 50. The old unsplit Engineering 350 figure in comments became Outland Engineering 50; skill in a different expansion does not satisfy it.",
        "Find Smiles O'Byron at the transporter pad NORTH of Toshley's Station in Blade's Edge Mountains (60.2, 65.2), near the graveyard. Speak to him and choose the dialogue about building a beacon to learn the recipe for free. You need Gnomish Engineering and Outland Engineering 50. Both factions can speak to Smiles; Horde characters should stay at the pad outside the Alliance settlement.",
        "Collect 1 Adamantite Frame, 2 Primal Air, 2 Felsteel Stabilizers, 4 Handfuls of Fel Iron Bolts and 1 Khorium Power Core. Buy the components or craft them. If making the two Felsteel Stabilizers yourself, they require 4 Felsteel Bars in total; do not mistake those for Khorium Bars in the older comments.",
        "At an anvil, open Outland Engineering and craft Ultrasafe Transporter - Toshley's Station. The recipe uses a hyphen while the finished toy uses a colon. Clear the Have Materials filter if the recipe is hidden, and revisit Smiles's dialogue if you have not learned it. Toshley himself does not teach this recipe.",
        "Use the finished item from your bags to learn the account-wide toy. An eligible Gnomish Engineer with Outland Engineering 50 can then activate it from the Toy Box. The normal arrival is the pad beside Smiles, outside the station. Malfunctions can cause appearance changes or a temporary chicken transformation; wait for the effect to end if it prevents normal actions.",
    },
    source = "Gnomish Engineering; Smiles O'Byron's recipe north of Toshley's Station",
    category = "Professions", faction = "all", npcId = 21494,
    requirements = "Collection: no profession. Recipe, crafting and teleport: Gnomish Engineering specialization and Outland Engineering 50. Available to both factions.",
    cost = "1 Adamantite Frame, 2 Primal Air, 2 Felsteel Stabilizers, 4 Handfuls of Fel Iron Bolts, 1 Khorium Power Core; specialization quest items are additional. Finished-toy Auction House prices vary.",
    tips = "The transporter and recipe NPC are at 60.2, 65.2, north of Toshley's Station. Gnomish means the profession specialization; a Horde character can learn and use this toy. Despite the name, the transporter can produce side effects.",
    effect = "Teleports an eligible Gnomish Engineer to the pad north of Toshley's Station in Blade's Edge Mountains; 4-hour cooldown. Can malfunction.",
    waypoints = {
        pin(84, 62.8, 32.0, 2, "Lilliam Sparkspindle - Alliance Gnomish specialization quest"),
        pin(85, 56.8, 56.4, 2, "Roxxik - Horde Gnomish specialization quest"),
        pin(100, 55.6, 65.6, 3, "Lebowski - Alliance Outland Engineering trainer"),
        pin(100, 54.8, 38.4, 3, "Zebig - Horde Outland Engineering trainer"),
        pin(105, 60.2, 65.2, 4, "Smiles O'Byron - learn recipe outside the station"),
        pin(105, 60.2, 65.2, 7, "Toshley's Station transporter - normal arrival"),
    },
})

-- The highly rated item guide skips prerequisites and misidentifies the reward
-- quest as 10674. Its useful route is retained with those corrections.
-- https://www.wowhead.com/item=30690#comments:id=2425814 and replies
-- https://www.wowhead.com/item=30690#comments:id=2332120
-- https://www.wowhead.com/item=30690#comments:id=825879 and faction-use replies
-- https://www.wowhead.com/quest=10584#comments:id=3125544 and prerequisite reply
-- https://www.wowhead.com/quest=10584#comments:id=3135334
-- https://www.wowhead.com/quest=10584#comments:id=2023163
-- https://www.wowhead.com/quest=10502/the-bloodmaul-ogres
-- https://www.wowhead.com/quest=10504/the-bladespire-ogres
-- https://www.wowhead.com/quest=10516/the-trappings-of-a-vindicator
-- https://www.wowhead.com/quest=10517/gorrdim-your-time-has-come
-- https://www.wowhead.com/quest=10518/planting-the-banner
-- https://www.wowhead.com/quest=10580#comments:id=22092 and replies
-- https://www.wowhead.com/quest=10581/follow-the-breadcrumbs
-- https://www.wowhead.com/quest=10657#comments:id=915387
-- https://www.wowhead.com/quest=10674#comments:id=2585872
-- https://www.wowhead.com/quest=10675#comments:id=5877768
-- https://www.wowhead.com/quest=10675#comments:id=100468 and reply
-- https://www.wowhead.com/quest=10675#comments:id=2194628 and reply
-- Quest-giver coordinates/prerequisite order also match CollectionSourceIndex.
addToy(30690, "Power Converter", {
    steps = {
        "Use an Alliance character of at least level 20 and enable Trivial Quests in the minimap tracking options. Visit Toshley at Toshley's Station in Blade's Edge Mountains (60.5, 69.0). If he offers Picking Up Some Power Converters, skip the optional unlock in steps 2-6 and continue at step 7. If you already have a later quest, resume at its step below. Horde can use the collected toy but cannot earn it from their version of the Razaan quest.",
        "OPTIONAL UNLOCK: If Toshley offers nothing, visit Commander Skyshadow in Sylvanaar (36.5, 66.4). Complete The Bloodmaul Ogres (10502): kill 30 Bloodmaul ogres around Bloodmaul Outpost (45.0, 75.0), then return. Take The Bladespire Ogres (10504), kill 30 ogres in Bladespire Hold/Bladespire Grounds around 42.0, 51.0 and return again. The ogres at Bladespire Outpost near Toshley's Station are the wrong camp for this second quest.",
        "OPTIONAL UNLOCK: Speak to Vindicator Vuuleen in the cage at Bladespire Hold (44.0, 51.8). Take The Trappings of a Vindicator (10516). Kill Droggam in his building near 38.5, 52.5 and loot her Blade; kill Mugdorg in the building near 42.4, 58.6 and loot her Shield. Return both to Vuuleen. A strong legacy-farming character can clear their guards rather than reproduce old class-specific tricks.",
        "OPTIONAL UNLOCK: Take Gorr'Dim, Your Time Has Come... (10517) from Vuuleen. Kill Gorr'Dim inside the large building near 39.5, 49.8, then return to her and accept Planting the Banner (10518). Do not leave the chain after merely recovering the sword and shield.",
        "OPTIONAL UNLOCK: Kill a Bladespire Champion near 41.3, 46.8 for the Bladespire Clan Banner. Go south to the top of Northmaul Tower at Bloodmaul Outpost (46.5, 74.4), use the banner and defeat the attacking waves, followed by Gurn Grubnosh. Loot his Helm. If another player's banner is already there, let their event finish and the banner disappear before placing yours.",
        "OPTIONAL UNLOCK: Return to Commander Skyshadow in Sylvanaar to finish Planting the Banner and take Where Did Those Darn Gnomes Go? (10580). Find R-3D0 at the foot of the ridge west of Toshley's Station (55.0, 72.8), turn it in and accept Follow the Breadcrumbs (10581). Follow the spare-parts trail up the ramp to Toshley (60.5, 69.0) and turn that in to open his quests.",
        "Accept Picking Up Some Power Converters (10584) from Toshley. Go north to Bladespire Outpost around 57.5, 56.0. Click a Power Converter on the ground to release an Electromental, target the creature and use the provided Protovoltaic Magneto Collector BEFORE killing it. Kill it once it is encased. Repeat until 5 Electromentals are collected; dismiss attacking pets or stop automatic attacks if they kill it before the collector finishes.",
        "Return to Toshley and take Ride the Lightning (10657). Go to Scalewing Shelf east/southeast of the station, around 68.5, 72.0. Activate the provided Repolarized Magneto Sphere on yourself, aggro Scalewing Serpents and let their lightning hit you until the counter reaches 25. Leave the serpents alive while collecting strikes; a high-level character can body-pull them without attacking. Then kill enough to loot 5 Scalewing Lightning Glands and return to Toshley.",
        "Accept Trapping the Light Fantastic (10674). Travel to Razaan's Landing around 65.5, 43.2 and repeatedly place the provided Multi-Spectrum Light Trap beside the TINY PINK floating lights until you have trapped 15. These are not the large yellow souls that drift out of dead ethereals. Return to Toshley; this quest leads to the toy quest but does not itself award the toy.",
        "Take Show Them Gnome Mercy! (10675). Return to the portal apparatus with a tall pink tube at Razaan's Landing (66.4, 44.2). Kill the Razaani ethereals nearby. Their yellow souls travel slowly to the tube; keep clearing and allow them to arrive. When the apparatus fills and completes its animation, Nexus-Prince Razaan appears with a yell. Killing unrelated flesh beasts does not replace the ethereal souls.",
        "Kill Nexus-Prince Razaan, then click the separate runed BOX that appears above/near his body and take the Collection of Souls. The quest needs the item from that box, not just kill credit or ordinary corpse loot. Loot it promptly before it disappears. If someone else already killed the prince, a still-present box can supply the item while you have the quest.",
        "Return to Toshley at 60.5, 69.0 and turn in Show Them Gnome Mercy! Power Converter is an additional guaranteed reward alongside your equipment choice. Use the item from your bags to add it to the account-wide Toy Box. Eligible Horde alts can use it afterwards; the Horde quest There Can Be Only One Response does not award this toy.",
    },
    source = "Show Them Gnome Mercy! (10675) - Toshley, Toshley's Station",
    category = "Quest Rewards", faction = "all", npcId = 21691,
    requirements = "An Alliance character, level 20 or higher, for the quest chain. Both factions can use the account-wide toy after collection.",
    cost = "No toy purchase cost; complete Toshley's quest chain and any unfinished prerequisites.",
    tips = "Check Toshley first to avoid repeating an already finished Sylvanaar unlock. Each quest supplies its own device: collector, sphere and light trap have different targets. The reward is a reusable cosmetic firework, not a weapon against mechanical enemies.",
    effect = "Launches a cosmetic firework; 5-minute cooldown. It does not destroy mechanical enemies and is not consumed.",
    waypoints = {
        pin(105, 60.5, 69.0, 1, "Toshley - quest chain, turn-ins and toy reward"),
        pin(105, 36.5, 66.4, 2, "Commander Skyshadow - optional Sylvanaar unlock"),
        pin(105, 45.0, 75.0, 2, "Bloodmaul Outpost - optional 30 Bloodmaul kills"),
        pin(105, 42.0, 51.0, 2, "Bladespire Hold - optional 30 Bladespire kills"),
        pin(105, 44.0, 51.8, 3, "Vindicator Vuuleen - optional equipment recovery"),
        pin(105, 38.5, 52.5, 3, "Droggam - Vindicator Vuuleen's Blade"),
        pin(105, 42.4, 58.6, 3, "Mugdorg - Vindicator Vuuleen's Shield"),
        pin(105, 44.0, 51.8, 4, "Vindicator Vuuleen - optional Gorr'Dim quest"),
        pin(105, 39.5, 49.8, 4, "Gorr'Dim - optional kill"),
        pin(105, 41.3, 46.8, 5, "Bladespire Champion - loot a banner"),
        pin(105, 46.5, 74.4, 5, "Northmaul Tower - plant banner, loot Gurn's Helm"),
        pin(105, 36.5, 66.4, 6, "Commander Skyshadow - optional gnome breadcrumb"),
        pin(105, 55.0, 72.8, 6, "R-3D0 - Follow the Breadcrumbs"),
        pin(105, 60.5, 69.0, 6, "Toshley - finish Follow the Breadcrumbs"),
        pin(105, 60.5, 69.0, 7, "Toshley - Picking Up Some Power Converters"),
        pin(105, 57.5, 56.0, 7, "Bladespire Outpost - encase 5 Electromentals"),
        pin(105, 68.5, 72.0, 8, "Scalewing Shelf - absorb 25 strikes, loot 5 glands"),
        pin(105, 65.5, 43.2, 9, "Razaan's Landing - trap 15 tiny pink lights"),
        pin(105, 66.4, 44.2, 10, "Razaan portal - summon the prince and loot the soul box"),
        pin(105, 66.4, 44.2, 11, "Nexus-Prince Razaan - loot the separate soul box"),
        pin(105, 60.5, 69.0, 12, "Toshley - turn in for Power Converter"),
    },
})

-- Detailed numbered farming guides, AH shortcut and respawn/trading corrections:
-- https://www.wowhead.com/item=32782#comments:id=2515855 and replies
-- https://www.wowhead.com/item=32782#comments:id=5385664
-- https://www.wowhead.com/item=32782#comments:id=6036954
-- https://www.wowhead.com/item=32782#comments:id=5789601
-- https://www.wowhead.com/item=32782#comments:id=5452801
-- https://www.wowhead.com/item=32782#comments:id=2357864 and correction reply
-- https://www.wowhead.com/npc=21838#comments:id=1996077 and prerequisite reply
-- https://www.wowhead.com/npc=21838#comments:id=775132
-- https://www.wowhead.com/npc=21838#comments:id=5794211
-- https://www.wowhead.com/quest=11004/world-of-shadows
-- https://www.wowhead.com/quest=11005/secrets-of-the-talonpriests
-- https://www.wowhead.com/quest=11021/ishaals-almanac
-- https://www.wowhead.com/quest=11024/an-ally-in-lower-city
-- https://www.wowhead.com/quest=11028/countdown-to-doom
-- https://www.wowhead.com/quest=11056#comments:id=87793 and replies
-- https://www.wowhead.com/quest=11029/a-shabby-disguise
-- https://www.wowhead.com/quest=11885/adversarial-blood
-- https://www.wowhead.com/quest=11074/tokens-of-the-descendants
-- NPC records: 23042, 23038, 23306, 23066, 23067, 23068, 22292 and 23363.
-- https://www.wowhead.com/object=185928/ancient-skull-pile
addToy(32782, "Time-Lost Figurine", {
    steps = {
        "Choose the shortcut or the self-farmed route before travelling. For the shortcut, buy a Time-Lost Offering (32720) on the Auction House and continue at step 12: it can summon Terokk without farming dust, scrolls or the quest unlock. The Figurine itself is a bound drop, not the tradable offering. For the full route, follow steps 2-11; if you already unlocked Hazzik's repeatable turn-in, resume at step 8.",
        "Fly to Blackwind Landing north of Skettis in Terokkar Forest. Speak to Severin at 64.0, 66.8 and take World of Shadows (11004). Kill the ordinary arakkoa around Skettis for 6 Shadow Dust, then return to Severin for an Elixir of Shadows. Additional elixirs come from the repeatable More Shadow Dust, also at 6 dust per elixir. Turn on Trivial Quests if the low-level quests are hidden.",
        "Take Secrets of the Talonpriests (11005) from Sky Commander Adaris beside Severin. Drink the elixir to see the hidden enemies for 20 minutes. Kill Talonpriest Ishaal around 69.3, 78.6, Skizzik at 69.8, 82.0 and Zellek around 70.1, 74.5 on Skettis's raised platforms/huts. LOOT Ishaal's Almanac from Ishaal and use it to start its quest. Return to Adaris with the three kills and the book; drink another elixir if your visibility buff expires.",
        "Turn in Ishaal's Almanac (11021) to Adaris and accept An Ally in Lower City (11024). Take the book to Rilak the Redeemed in northern Lower City, Shattrath (52.6, 20.8). Take his follow-up Countdown to Doom (11028); leaving after delivering the book does not unlock Hazzik's offering exchange.",
        "Return to Adaris at Blackwind Landing (64.0, 66.8) and turn in Countdown to Doom. Speak to Hazzik, the arakkoa in the cage at 64.2, 66.8, and accept Hazzik's Bargain (11056). The caged arakkoa is the quest NPC; Grella, the nearby mount quartermaster, does not provide the toy or its summoning item.",
        "Collect Hazzik's Package from the box inside the hut at Upper Veil Shil'ak (74.8, 80.2). Look inside the ground-level hut by the small summoning circle, rather than searching the tops of every tree platform. Return the package to Hazzik at 64.2, 66.8.",
        "Take A Shabby Disguise (11029). Go to Sahaak in the hut on Terokk's Rest, the island in Blackwind Lake (67.0, 79.6). Use the quest's Shabby Arakkoa Disguise, speak to him and buy Adversarial Bloodlines, then bring the book back to Hazzik. Carry a few gold for the book. The disguise is for this interaction; it does not make the other Skettis enemies friendly.",
        "FIRST FARMED OFFERING: accept Adversarial Blood (11885) from Hazzik BEFORE summoning the four descendants. This first quest requires their kills while it is active. If you kill them first, holding their four drops will not complete that initial kill objective. Once this unlock is complete, use Hazzik's repeatable Tokens of the Descendants (11074) for later offerings.",
        "While affected by Elixir of Shadows, kill the shadowy Time-Lost Skettis Reavers, High Priests and Worshippers for 40 Time-Lost Scrolls. Look on the raised platforms and around the purple summoning circles. Ordinary visible arakkoa provide dust; the Time-Lost enemies provide the scrolls. Refill the elixir with 6 dust if the 20-minute buff runs out. Scrolls, dust and the four descendant tokens can also be bought on the Auction House to shorten this part.",
        "Use the SMALL Skull Piles in Skettis's purple summoning circles: convenient ones are at 62.0, 74.6; 61.4, 78.1; 69.7, 74.7; and 70.1, 79.4. Spend 10 scrolls at each to summon a DIFFERENT descendant: Darkscreecher Akkarai (Akkarai's Talons), Karrog (Karrog's Spine), Gezzarak the Huntress (Gezzarak's Claws) and Vakkiz the Windrager (Vakkiz's Scale). Kill and loot each. Move to another pile after using one; repeating the same descendant leaves you short of a required token.",
        "Return to Hazzik at 64.2, 66.8. For the first round, finish Adversarial Blood for its Time-Lost Offering and keep the four tokens you looted. The repeatable Tokens of the Descendants trades a complete set of those tokens for another offering. For later rounds, farm 40 more scrolls and one of each token, then repeat that exchange. Keep the tokens when vendoring; they are needed even when their icons look like ordinary junk.",
        "Go to the LARGE green summoning circle on Terokk's Rest (66.1, 77.6). Click the Ancient Skull Pile in its centre and choose the option to use one Time-Lost Offering to summon Terokk. If the pile is absent, wait: another summon has used it. Coordinate with nearby farmers so you do not spend several offerings on the same spawn.",
        "Defeat and loot Terokk for a chance at Time-Lost Figurine. A strong legacy-farming character can usually kill him immediately; if he becomes immune, move him onto the blue flare/fire dropped by the Skyguard until the shield is removed, then finish him. There is no daily toy-drop lockout. The Ancient Skull Pile returns roughly 15 minutes after his death; buy another offering or repeat steps 9-12 for another attempt. A long unlucky streak does not mean the drop has been removed.",
        "When the Figurine drops, use it from your bags to add it to the account-wide Toy Box. Learn your own drop before selling or deleting duplicates; do not rely on the old comments claiming another player's bound toy can always be traded to you.",
    },
    source = "Terokk - summoned with a Time-Lost Offering at Terokk's Rest, Skettis",
    category = "Rare Drops", faction = "all", npcId = 21838,
    requirements = "A Time-Lost Offering for each summon. Buying an offering bypasses the farming unlock; making your own requires the Skettis quest chain. No Exalted reputation requirement for the toy.",
    cost = "Per repeat farmed offering: 40 Time-Lost Scrolls to summon four descendants, then trade their four tokens to Hazzik. Elixirs of Shadows cost 6 Shadow Dust each. Alternatively buy Time-Lost Offerings; prices vary.",
    tips = "Sha'tari Skyguard reputation is a useful byproduct, not the toy's purchase requirement. Use Terokkar Forest in Outland, not Talador in Draenor. The cosmetic disguise does not prevent enemy aggression. You can keep farming between Terokk summons.",
    effect = "Transforms you into an arakkoa for 5 minutes; 30-minute cooldown. This is a cosmetic effect, not friendly standing with Skettis.",
    waypoints = {
        pin(108, 64.0, 66.8, 2, "Severin / Adaris - shadow quests, elixirs and Almanac"),
        pin(108, 69.3, 78.6, 3, "Talonpriest Ishaal - loot Ishaal's Almanac"),
        pin(108, 69.8, 82.0, 3, "Talonpriest Skizzik"),
        pin(108, 70.1, 74.5, 3, "Talonpriest Zellek"),
        pin(108, 64.0, 66.8, 4, "Adaris - Ishaal's Almanac and Lower City delivery"),
        pin(111, 52.6, 20.8, 4, "Rilak the Redeemed - An Ally in Lower City"),
        pin(108, 64.0, 66.8, 5, "Adaris - Countdown to Doom"),
        pin(108, 64.2, 66.8, 5, "Hazzik - unlock quests and offering exchange"),
        pin(108, 74.8, 80.2, 6, "Hazzik's Package - inside the hut"),
        pin(108, 67.0, 79.6, 7, "Sahaak - use quest disguise and buy the book"),
        pin(108, 64.2, 66.8, 8, "Hazzik - accept Adversarial Blood BEFORE the kills"),
        pin(108, 69.7, 74.7, 9, "Skettis - Time-Lost scroll farm and small Skull Pile"),
        pin(108, 62.0, 74.6, 10, "Small Skull Pile - choose a different descendant"),
        pin(108, 61.4, 78.1, 10, "Small Skull Pile - choose a different descendant"),
        pin(108, 69.7, 74.7, 10, "Small Skull Pile - choose a different descendant"),
        pin(108, 70.1, 79.4, 10, "Small Skull Pile - choose a different descendant"),
        pin(108, 64.2, 66.8, 11, "Hazzik - collect or exchange for offerings"),
        pin(108, 66.1, 77.6, 12, "Ancient Skull Pile / Terokk - summon and loot"),
        pin(108, 66.1, 77.6, 13, "Terokk - toy drop and repeatable attempts"),
    },
})

-- All four Heroic bosses, current drop reports and original-island access:
-- https://www.wowhead.com/item=35275#comments:id=1515959
-- https://www.wowhead.com/item=35275#comments:id=1753366 and replies
-- https://www.wowhead.com/item=35275#comments:id=1943676 and reply
-- https://www.wowhead.com/item=35275#comments:id=5501964
-- https://www.wowhead.com/item=35275#comments:id=6261366 and reply
-- https://www.wowhead.com/item=35275#comments:id=6438277
-- https://www.wowhead.com/item=35513#comments:id=6370420 (post-Midnight access)
-- https://www.wowhead.com/npc=24723/selin-fireheart
-- https://www.wowhead.com/npc=24744/vexallus
-- https://www.wowhead.com/npc=24560/priestess-delrissa
-- https://www.wowhead.com/npc=24664/kaelthas-sunstrider
-- Retail dungeon floor mapping: floor 2 = UiMap 349; floor 1 = UiMap 348.
addToy(35275, "Orb of the Sin'dorei", {
    steps = {
        "Go to Shattrath City in Outland and take the portal at 48.6, 42.0 to the ORIGINAL Isle of Quel'Danas. Post-Midnight Retail comments confirm that this still reaches the Burning Crusade island. Use this route to the legacy dungeon rather than the new Midnight version of Magisters' Terrace.",
        "Before entering original Magisters' Terrace at 61.2, 30.9 on Isle of Quel'Danas (#122), set Dungeon Difficulty to HEROIC through your character portrait menu. Check the difficulty after entering. The orb farming route is Heroic, and every one of its four bosses can drop it; do not plan repeated Normal resets for this toy.",
        "Follow the entrance route to Selin Fireheart at 42.4, 22.3 on the Observation Grounds floor. Kill him, finish any nearby enemies pulled into the fight, and LOOT his body. He can drop the orb, including in recent Retail reports, so skipping his loot throws away a chance.",
        "Continue through the mana-wyrm hall to Vexallus at 83.4, 26.4 on Observation Grounds. Defeat and loot him for another chance. If the encounter lasts long enough to spawn Pure Energy, kill the adds and finish the boss before continuing through the courtyard.",
        "On the Grand Magister's Asylum floor, reach Priestess Delrissa at 39.7, 55.7. Defeat her and ALL four companions to complete the encounter and open the way onward. Loot Delrissa; the orb is not exclusive to Kael'thas, despite some older Dungeon Journal interpretations.",
        "Enter Kael'thas Sunstrider's chamber at 8.6, 50.2 on Grand Magister's Asylum. Defeat him and loot his body for the fourth chance. If Gravity Lapse begins, move away from the floating damaging spheres and finish him when possible. This run can also supply Swift White Hawkstrider and Phoenix Hatchling, so check the rest of the loot too.",
        "If the orb did not drop, use the exit orb behind Kael'thas to leave. Return after the daily Heroic reset or run another eligible character. Reset All Instances does not refresh a completed Heroic lockout. Clear and loot all four bosses on each fresh attempt; no particular boss order or promised number of runs guarantees the toy.",
        "Use Orb of the Sin'dorei from your bags to add it to the Toy Box. Both factions can collect and use it. Activate the disguise on the ground; a Blood Elf may see little or no appearance change, but the collection unlock still counts.",
    },
    source = "All four bosses in original Heroic Magisters' Terrace",
    category = "Dungeon and Raids", faction = "all",
    requirements = "Access to original Heroic Magisters' Terrace; a character capable of clearing the legacy dungeon. No Blood Elf race or Horde faction requirement.",
    cost = "No purchase cost; daily Heroic loot opportunities per character.",
    tips = "Loot Selin, Vexallus, Delrissa and Kael'thas for four chances per clear. The disguise changes appearance, not faction: opposing guards can still attack you. The Shattrath portal reaches the original island and dungeon in Retail.",
    effect = "Disguises you as a Blood Elf for 5 minutes while showing your equipped appearance; 30-minute cooldown. It changes appearance, not faction access.",
    waypoints = {
        pin(111, 48.6, 42.0, 1, "Shattrath portal - original Isle of Quel'Danas"),
        pin(122, 61.2, 30.9, 2, "Original Magisters' Terrace entrance - set Heroic", "Isle of Quel'Danas (original)"),
        pin(349, 42.4, 22.3, 3, "Selin Fireheart - first orb chance", "Magisters' Terrace (original): Observation Grounds"),
        pin(349, 83.4, 26.4, 4, "Vexallus - second orb chance", "Magisters' Terrace (original): Observation Grounds"),
        pin(348, 39.7, 55.7, 5, "Priestess Delrissa - third orb chance", "Magisters' Terrace (original): Grand Magister's Asylum"),
        pin(348, 8.6, 50.2, 6, "Kael'thas Sunstrider - fourth orb chance", "Magisters' Terrace (original): Grand Magister's Asylum"),
    },
})

-- Retail availability reviewed 2026-11-04. The five registered toys still
-- have crafting, quest or drop routes; none requires an expired promotion.
-- https://news.blizzard.com/en-us/article/23523203/burning-crusade-mounts-pets-and-more
-- https://warcraft.wiki.gg/wiki/List_of_toys_by_source
-- https://www.wowhead.com/item=32782/time-lost-figurine#comments
-- https://www.wowhead.com/item=35275/orb-of-the-sindorei#comments
local function rate(level, reason, itemIDs)
    for _, itemID in ipairs(itemIDs) do
        local guide = guides[itemID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end
rate("medium", "Buy the crafted toy or level Engineering and its specialization to make it; activating the teleport remains profession-gated.", {30542,30544})
rate("medium", "Complete Toshley's Alliance quest chain, including any unfinished unlocks and its special quest-item mechanics.", {30690})
rate("medium", "Unlock Terokk, gather or buy summoning materials and repeat summons for a random toy drop.", {32782})
rate("hard", "Farm a rare drop from original Heroic Magisters' Terrace, subject to daily boss loot lockouts.", {35275})
