-- Hand-reviewed English Retail walkthroughs, reviewed 2026-11-02.
-- All 33 item comment lists were read, with acquisition/correction replies
-- expanded through Wowhead's public comment/show-replies endpoint.
-- Item-page profit matches describe jokes, resale or using an owned toy,
-- rather than acquiring it. Routes below reconcile the remaining comments
-- with Retail vendors, recipes, quests and objects. No closing profit filler.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.toys = TDP.CollectionWalkthroughs.toys or {}
local guides = TDP.CollectionWalkthroughs.toys
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

local function addToy(itemID, name, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.sourceType = guide.category
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end

-- https://www.wowhead.com/item=36862#comments:id=1507120 and all 8 replies
-- https://www.wowhead.com/item=36862#comments:id=5478138
-- https://www.wowhead.com/item=36862#comments:id=6073250
-- https://www.wowhead.com/npc=34907/kvaldir-harpooner (UiMap 170)
-- https://www.wowhead.com/npc=34728/dark-zealot (UiMap 118)
addToy(36862, "Worn Troll Dice", {
    description = "Reusable dice obtained by Rogue pickpocketing, or by buying an unused pair.",
    category = "Professions", source = "Northrend humanoid pickpocketing; unused dice can be traded",
    requirements = "Rogue with Stealth and Pick Pocket to farm; no Rogue requirement to collect or use bought dice.",
    cost = "No farming purchase cost; Auction House prices vary.",
    steps = {
        "Check the Auction House for Worn Troll Dice (36862) if you want to avoid the Rogue farm. Buy the unused toy and continue at step 5; other classes cannot reproduce the pickpocket route.",
        "On a Rogue, fly to Hrothgar's Landing, the island north of Icecrown. Begin around the Kvaldir shore camps at 50.0, 49.4 on the island's own map. Enter Stealth and Pick Pocket the living Kvaldir before killing them.",
        "Work around the occupied shore, huts and higher ground, picking each eligible humanoid. Empty pockets need time to refill; kill already-picked enemies for fresh spawns or return for another circuit later. Ordinary corpse loot is not the dice roll.",
        "If another Rogue has emptied the island, try the Dark Zealots around Deathspeaker's Watch in Icecrown (62.0, 21.2). Pick Pocket first, then kill. A short lucky farm in a comment does not guarantee a quick drop.",
        "Use the dice from your bags to add them to the account-wide Toy Box. Keep farming only if you want a spare unused pair to trade.",
    },
    tips = "No retired Pick Pocket glyph or Cold Weather Flying purchase is needed. Use the Hrothgar's Landing map for island coordinates; Icecrown coordinates are different.",
    effect = "Rolls a pair of six-sided dice with a cosmetic emote.",
    waypoints = {
        pin(170, 50.0, 49.4, 2, "Kvaldir shore camps - begin pickpocket circuit", "Hrothgar's Landing"),
        pin(118, 62.0, 21.2, 4, "Deathspeaker's Watch - alternative Dark Zealot pockets", "Icecrown"),
    },
})

-- https://www.wowhead.com/item=36863#comments:id=1507121 and all 10 replies
-- https://www.wowhead.com/item=36863#comments:id=5478233
-- https://www.wowhead.com/item=36863#comments:id=6091777
-- https://www.wowhead.com/npc=29330/onslaught-harbor-guard
-- https://www.wowhead.com/npc=29338/onslaught-raven-bishop
addToy(36863, "Decahedral Dwarven Dice", {
    description = "A tradable pickpocketed toy that provides a theatrical alternative to a normal random roll.",
    category = "Professions", source = "Northrend humanoid pickpocketing; unused dice can be traded",
    requirements = "A Rogue to pickpocket; any class can learn and use a purchased pair.",
    cost = "No farming purchase cost; unused dice can be bought on the Auction House.",
    steps = {
        "Search the Auction House for Decahedral Dwarven Dice (36863) if you prefer buying them. Otherwise bring a Rogue with Pick Pocket to Onslaught Harbor, the island on Icecrown's western coast.",
        "Start at the cathedral steps around 10.2, 45.0. Stealth and Pick Pocket the Onslaught guards, bishops and paladins. The comments confirm more eligible enemies than the site's short recorded pickpocket table suggests.",
        "Continue through the harbor's buildings and shoreline, then circle back. Pick pockets before killing; killing an enemy without pickpocketing does not roll for the dice. Replace already-empty pockets with fresh spawns or wait before repeating.",
        "For an alternative circuit, go to New Hearthglen in southern Dragonblight (72.0, 74.0). Include the cathedral, stables, beach and ship. Target a mounted Onslaught rider rather than its horse. Both locations have Retail drop reports; neither guarantees a fixed number of attempts.",
        "Use the dice to learn the account-wide toy. No Rogue class requirement remains for collection or activation.",
    },
    tips = "Old Pick Pocket glyphs and old level-74 requirements are obsolete. Pickpocket junk or romance novels do not guarantee the dice will accompany them.",
    effect = "Performs a dice-roll emote and a 1-100 roll.",
    waypoints = {
        pin(118, 10.2, 45.0, 2, "Onslaught Harbor cathedral steps - pick pockets", "Icecrown"),
        pin(118, 7.2, 38.6, 3, "Onslaught Harbor - continue around the shore and buildings", "Icecrown"),
        pin(115, 72.0, 74.0, 4, "New Hearthglen - alternative town, beach and ship circuit", "Dragonblight"),
    },
})

-- https://www.wowhead.com/item=37254#comments:id=1641965 and all 8 replies
-- https://www.wowhead.com/item=37254#comments:id=2284121 and all 15 replies
-- https://www.wowhead.com/item=37254#comments:id=2862030
-- https://www.wowhead.com/item=37254#comments:id=6392743 (2026 Retail drop)
-- https://www.wowhead.com/npc=15954/noth-the-plaguebringer
-- https://www.wowhead.com/npc=15936/heigan-the-unclean
-- Naxxramas floor 4 is Retail UiMap 165, The Plague Quarter.
addToy(37254, "Super Simian Sphere", {
    description = "An exceptionally rare bound drop that turns you into a gorilla inside a magical bubble.",
    category = "Rare Drops", source = "Rare Wrath enemy drops; Naxxramas trash is a documented Retail farming route",
    requirements = "A character capable of clearing legacy Naxxramas. No profession requirement.",
    cost = "No purchase route: the Sphere binds when picked up and cannot be bought on the Auction House.",
    steps = {
        "Fly underneath the floating Naxxramas necropolis in eastern Dragonblight (87.3, 50.9) and enter through its underside portal. Choose 10- or 25-player Normal; recent Retail reports confirm both. The old level-79 wording describes pre-squish enemies, not a present-day character-level requirement.",
        "Enter the Plague Quarter and defeat Noth the Plaguebringer (34.6, 56.4 on that floor). Loot him, then take the opened route into the trash hall beyond his room.",
        "Gather and kill the bats, grubs and other loot-bearing enemies in the corridor leading to Heigan (49.8, 45.6). Loot every group. STOP before killing Heigan so the intervening trash can respawn.",
        "Leave after clearing the hall and return after its trash respawns, commonly around 30 minutes. Rotate other characters or do other activities while waiting. Reset All Instances does not reliably force an immediate raid-trash respawn; old instant-reset instructions have correction replies.",
        "Repeat until the Sphere drops, then use it from your bags. This can take many thousands of kills. It is a bound world-table drop, not an Auction House item or a guaranteed reward after enough runs.",
    },
    tips = "Loot corpses yourself; do not depend on unlooted trash reaching the mailbox. Keep looting other Wrath raids during your regular clears too. The highest percentage on a sparsely sampled mob is not proof of a better drop chance.",
    effect = "Transforms you into a gorilla in a magical bubble for 5 minutes; 1-hour cooldown.",
    waypoints = {
        pin(115, 87.3, 50.9, 1, "Naxxramas - entrance underneath the floating necropolis", "Dragonblight"),
        pin(165, 34.6, 56.4, 2, "Noth - open the Plague Quarter trash route", "Naxxramas: The Plague Quarter"),
        pin(165, 49.8, 45.6, 3, "Farm the trash BEFORE Heigan; leave this boss alive", "Naxxramas: The Plague Quarter"),
    },
})

-- Each item page was reviewed separately. The deterministic vendor route avoids
-- waiting for random Winter Veil presents. Retail NPC 29478 confirms prices.
-- https://www.wowhead.com/item=44606#comments:id=388590
-- https://www.wowhead.com/item=44606#comments:id=2551165
-- https://www.wowhead.com/item=44606#comments:id=3284585 and replies
-- https://www.wowhead.com/item=45057#comments:id=677442
-- https://www.wowhead.com/item=54343#comments:id=984078 and replies
-- https://www.wowhead.com/item=54343#comments:id=2291808
-- https://www.wowhead.com/item=54437#comments:id=984081 and replies
-- https://www.wowhead.com/item=54438#comments:id=984079
-- https://www.wowhead.com/npc=29478/jepetto-joybuzz
local shopToys = {
    {44606, "Toy Train Set", "250 gold", "Places a miniature train track and moving train; 30-minute cooldown.",
        "Place it on clear ground. Old comments describe forcing an entire city to /train; later Retail changes restrict or suppress that interaction. The train itself still appears, and a Train Wrecker can destroy the placed set."},
    {45057, "Wind-Up Train Wrecker", "250 gold", "Summons a robot that destroys a nearby active Toy Train Set, then celebrates; 30-minute cooldown.",
        "Place the robot close to an active Toy Train Set. It destroys that placed set; it does not remove the other player's collected toy. This is a Toy Box item, not a battle pet."},
    {54343, "Blue Crashin' Thrashin' Racer Controller", "40 gold", "Controls a small blue racer that can charge into other racers.",
        "Use it on open ground and use the vehicle controls to move, jump and charge another racer. This is the vendor's blue model, not the original red Winter Veil gift. It is sold year-round."},
    {54437, "Tiny Green Ragdoll", "20 gold", "Places a small green ragdoll on the ground; 30-minute cooldown.",
        "Buy the current item 54437. Older comments may link the replaced item 44849; you do not need that retired version. The green and blue dolls have separate cooldowns."},
    {54438, "Tiny Blue Ragdoll", "10 gold", "Places a small blue ragdoll on the ground; 30-minute cooldown.",
        "Buy the blue doll directly; there is no need to wait for a Winter Veil reward bag. The blue and green dolls can be placed together because their cooldowns are separate."},
}
for _, toy in ipairs(shopToys) do
    local id, name, price, effect, detail = unpack(toy)
    addToy(id, name, {
        description = effect,
        category = "Vendor", source = "Jepetto Joybuzz or his Clockwork Assistant - The Wonderworks, Northrend Dalaran",
        npcId = 29478, requirements = "Either faction; enough gold for the vendor price.",
        cost = price .. " before reputation discounts.",
        steps = {
            "Travel to Dalaran above Crystalsong Forest in Northrend. The portal to Crystalsong Forest in your capital's portal room reaches this city; the Dalaran Hearthstone reaches the Legion city instead.",
            "Enter The Wonderworks on the western side of Runeweaver Square, around 44.6, 45.8. Speak to Jepetto Joybuzz or the Clockwork Assistant inside the toy shop.",
            "Find " .. name .. " in the vendor's pages and buy it for " .. price .. " before Kirin Tor discounts. It is a regular gold purchase; no tournament progress or seasonal event is required.",
            "Use " .. name .. " from your bags to add it to the account-wide Toy Box. " .. detail,
        },
        tips = "The Wonderworks is the toy shop, not Breanni's pet shop. Reputation discounts explain some lower prices quoted in comments. " .. detail,
        effect = effect,
        waypoints = { pin(125, 44.6, 45.8, 2, "The Wonderworks - Jepetto and Clockwork Assistant", "Dalaran (Northrend)") },
    })
end

-- https://www.wowhead.com/item=37460#comments:id=334184 and replies
-- https://www.wowhead.com/item=37460#comments:id=2344862
-- https://www.wowhead.com/item=44820#comments:id=640556
-- https://www.wowhead.com/item=44820#comments:id=883465
-- https://www.wowhead.com/item=44820#comments:id=2306636
-- https://www.wowhead.com/npc=28951/breanni
for _, toy in ipairs({ {37460, "Rope Pet Leash", "75 silver"}, {44820, "Red Ribbon Pet Leash", "1 gold 50 silver"} }) do
    local id, name, price = unpack(toy)
    addToy(id, name, {
        description = "A reusable cosmetic tether for your summoned companion pet.",
        category = "Vendor", source = "Breanni - Magical Menagerie, Northrend Dalaran", npcId = 28951,
        requirements = "Either faction. Summon an eligible companion pet to use the leash.",
        cost = price .. " before Kirin Tor reputation discounts.",
        steps = {
            "Travel to Northrend Dalaran above Crystalsong Forest. Enter the Magical Menagerie near Krasus' Landing at 58.6, 39.6.",
            "Speak to Breanni and buy " .. name .. " for " .. price .. " before reputation discounts. This is a permanent cosmetic item, not a new pet or a limited-charge consumable.",
            "Use the purchased item to add it to the Toy Box. Summon a companion from the Pet Journal, target that pet and activate the leash. If the pet is an invalid target, try a different companion.",
        },
        tips = "The leash does not capture pets or keep them summoned through travel. Moving too far from the pet can break the tether; apply it again when nearby.",
        effect = "Tethers an eligible companion pet to your hand with a cosmetic leash.",
        waypoints = {
            pin(125, 58.6, 39.6, 1, "Magical Menagerie - Breanni", "Dalaran (Northrend)"),
            pin(125, 58.6, 39.6, 2, "Breanni - purchase " .. name, "Dalaran (Northrend)"),
        },
    })
end

-- https://www.wowhead.com/item=40768#comments:id=2307430 and replies
-- https://www.wowhead.com/item=40768#comments:id=5981589
-- https://www.wowhead.com/item=40768#comments:id=5801939 and replies
-- https://www.wowhead.com/item=40768#comments:id=6338183 and reply
-- https://www.wowhead.com/spell=56472/moll-e (Retail skill 50, 8+8 materials)
-- https://www.wowhead.com/npc=28697#comments:id=3213089 and replies
addToy(40768, "MOLL-E", {
    description = "An engineer's reusable portable mailbox, usable by nearby players once placed.",
    category = "Professions", source = "Northrend Engineering trainer recipe; unused MOLL-E can be traded", npcId = 28697,
    requirements = "Collection: no profession. Crafting and placing the mailbox: Northrend Engineering 50.",
    cost = "8 Saronite Bars and 8 Eternal Air, plus trainer fees; alternatively buy the finished toy.",
    steps = {
        "For collection only, buy an unused MOLL-E (40768) on the Auction House or ask an Engineer to craft it. A non-engineer can add the toy but cannot deploy the mailbox. If buying one, continue at step 4.",
        "For crafting, visit Timofey Oshenko inside Like Clockwork in Northrend Dalaran (38.8, 25.8). Learn Northrend Engineering and raise that expansion's skill to 50, then train MOLL-E. The old unsplit 425 Engineering figure is obsolete.",
        "Bring 8 Saronite Bars, 8 Eternal Air and the recipe's Blacksmith Hammer tool. Open Northrend Engineering and craft MOLL-E. Clear the Have Materials filter if you cannot see the learned recipe.",
        "Use the finished item from your bags to learn the account-wide toy. Deploy it on an eligible Engineer on clear, stationary ground, away from walls or large objects. Interact with the placed mailbox to send or collect mail.",
    },
    tips = "The mailbox lasts 10 minutes and is reusable after its cooldown. Retail comments report an intermittent immediate-despawn bug; an early disappearance does not mean another toy must be crafted. It has no Gnomish/Goblin specialization requirement.",
    effect = "Creates a portable mailbox for 10 minutes; 1-hour cooldown. Deployment requires Northrend Engineering 50.",
    waypoints = { pin(125, 38.8, 25.8, 2, "Timofey Oshenko - Northrend Engineering and MOLL-E recipe", "Dalaran (Northrend)") },
})

-- https://www.wowhead.com/item=40895#comments:id=1796144 and both replies
-- https://www.wowhead.com/item=40895#comments:id=1770552 and reply
-- https://www.wowhead.com/spell=56473/gnomish-x-ray-specs
-- https://www.wowhead.com/npc=29514/findle-whistlesteam
-- https://www.wowhead.com/quest=29477/gnomish-engineering
addToy(40895, "Gnomish X-Ray Specs", {
    description = "Gnomish Engineering goggles that change how you see other players' outfits.",
    category = "Professions", source = "Gnomish Engineering specialization and Northrend Engineering trainer recipe", npcId = 29514,
    requirements = "Gnomish Engineering specialization and Northrend Engineering 1. The crafted toy binds on pickup.",
    cost = "6 Titanium Bars, 2 Dream Shards and 2 Handfuls of Cobalt Bolts. Specialization quest materials are additional.",
    steps = {
        "Use an Engineer with the Gnomish specialization. If needed, reach Classic Engineering 200 and take Gnomish Engineering from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Turn in 6 Mithril Tubes, 2 Advanced Target Dummies and 1 Accurate Scope.",
        "Learn Northrend Engineering from Timofey Oshenko at Like Clockwork in Northrend Dalaran (38.8, 25.8). Train Gnomish X-Ray Specs with Findle Whistlesteam in the same shop (39.2, 25.0). The Retail recipe requires Northrend Engineering 1 and Gnomish specialization; old comments quoting 350 or 425 use the former profession scale.",
        "Collect 6 Titanium Bars, 2 Dream Shards and 2 Handfuls of Cobalt Bolts. Bring the Blacksmith Hammer tool and craft the specs at an anvil. They bind on pickup, so another Engineer cannot simply trade you a finished pair.",
        "Use the item to add it to the Toy Box. An eligible Gnomish Engineer can activate the visual effect; it changes your view of player outfits while leaving weapons visible. It is no longer an equipped head-slot item.",
    },
    tips = "Gnomish is a profession specialization, not a Gnome race requirement. Both factions can craft these. Cosmetic effects do not remove the other players' actual gear or stats.",
    effect = "Shows other players in underwear while retaining their weapons; requires Gnomish Engineering and Northrend Engineering 1.",
    waypoints = {
        pin(84, 62.8, 32.0, 1, "Lilliam Sparkspindle - Alliance Gnomish specialization quest", "Stormwind City"),
        pin(85, 56.8, 56.4, 1, "Roxxik - Horde Gnomish specialization quest", "Orgrimmar"),
        pin(125, 38.8, 25.8, 2, "Timofey Oshenko - learn Northrend Engineering", "Dalaran (Northrend)"),
        pin(125, 39.2, 25.0, 2, "Findle Whistlesteam - Gnomish X-Ray Specs recipe", "Dalaran (Northrend)"),
    },
})

-- https://www.wowhead.com/item=43499#comments:id=1548453 and replies
-- https://www.wowhead.com/item=43499#comments:id=5189521
-- https://www.wowhead.com/item=43499#comments:id=6149066
-- https://www.wowhead.com/npc=29744#comments:id=2215894
-- https://www.wowhead.com/npc=30472/olut-alegut
-- https://www.wowhead.com/quest=12870/ancient-relics (Alliance)
-- https://www.wowhead.com/quest=12882/ancient-relics (Horde)
addToy(43499, "Iron Boot Flask", {
    description = "A permanent Iron Dwarf disguise purchased with Relics of Ulduar.",
    category = "Vendor", source = "Rork Sharpchin in Frosthold (Alliance) or Olut Alegut at Grom'arsh Crash-Site (Horde)",
    requirements = "Complete your seller's Ancient Relics quest. No Sons of Hodir reputation or Brunnhildar quest chain is required.",
    cost = "20 Relics of Ulduar on a fresh character: 10 for Ancient Relics and 10 for the toy. Only 10 if the quest is already complete.",
    steps = {
        "Collect 20 Relics of Ulduar (42780), or 10 if you already completed Ancient Relics for your seller. They can be traded and bought on the Auction House; Storm Peaks enemies also drop them.",
        "Alliance: visit Rork Sharpchin in Frosthold at 28.8, 74.0 in The Storm Peaks. Horde: visit Olut Alegut at Grom'arsh Crash-Site, 37.0, 49.6. Use your faction's seller, rather than the Sons of Hodir quartermaster.",
        "If the vendor inventory is unavailable, enable Trivial Quests and accept Ancient Relics from that same NPC. Hand over 10 relics and reopen the vendor window. This unlock is separate from buying the flask.",
        "Spend another 10 relics on Iron Boot Flask. Learn it from your bags to unlock the account-wide toy; further uses do not consume relics or charges.",
    },
    tips = "The rumored 250-relic price in very old comments was not the flask's actual price. Bring 20 for an untouched character so the unlock does not leave you short of the purchase.",
    effect = "Transforms you into an Iron Dwarf for 10 minutes; 1-hour cooldown.",
    waypoints = {
        pin(120, 28.8, 74.0, 2, "Rork Sharpchin - Alliance quest and seller", "The Storm Peaks"),
        pin(120, 37.0, 49.6, 2, "Olut Alegut - Horde quest and seller", "The Storm Peaks"),
        pin(120, 28.8, 74.0, 3, "Alliance Ancient Relics - hand in 10 relics", "The Storm Peaks"),
        pin(120, 37.0, 49.6, 3, "Horde Ancient Relics - hand in 10 relics", "The Storm Peaks"),
        pin(120, 28.8, 74.0, 4, "Alliance Iron Boot Flask - 10 more relics", "The Storm Peaks"),
        pin(120, 37.0, 49.6, 4, "Horde Iron Boot Flask - 10 more relics", "The Storm Peaks"),
    },
})

-- https://www.wowhead.com/item=43824#comments:id=461057 and all replies
-- https://www.wowhead.com/item=43824#comments:id=2353117 and all 7 replies
-- https://www.wowhead.com/achievement=1956#comments:id=1463964 (numbered circuit)
-- https://www.wowhead.com/achievement=1956#comments:id=483136
-- https://www.wowhead.com/achievement=1956#comments:id=6270986 and 2026 completion reply
-- Retail object positions: 192708, 192709, 192710, 192711, 192713,
-- 192865, 192866, 192867. These are the Northrend city, UiMap 125.
addToy(43824, "The Schools of Arcane Magic - Mastery", {
    description = "The Higher Learning reward book teleports you into Archmage Vargoth's retreat in Dalaran.",
    category = "Achievements", source = "Higher Learning (1956) - read eight rare books in Northrend Dalaran",
    sourceAchievementId = 1956,
    requirements = "Read all eight books on one character. No Mage class requirement.",
    cost = "No gold cost; missing books and placeholder spawns can require repeated visits.",
    steps = {
        "Go to Dalaran above Crystalsong Forest and track Higher Learning (1956). If you already completed it, check the Toy Box first, then skip to step 11 for recovery. The book hunt takes place in Northrend Dalaran, not the Broken Isles city.",
        "At the Legerdemain Lounge (46.9, 39.8), look in the downstairs empty bookcase by the stove for The Schools of Arcane Magic - Transmutation. Read the genuine title and check its criterion; an unrelated book is only a placeholder.",
        "Go upstairs in the same inn to the western bedroom (46.9, 39.3). Read Necromancy from its empty bookcase. This is a different spawn from the downstairs book, despite their nearly identical map positions.",
        "Enter Threads of Fate at 43.5, 47.0, go upstairs and step onto the balcony. Enchantment appears on a crate outside; searching the ground-floor shop misses this spawn.",
        "Enter the Violet Citadel (30.9, 46.3). Read Conjuration at the bottom of the bookcase on your right as you face into the main room. Stay downstairs for this book.",
        "Take the Citadel stairs up to 26.5, 51.7. Divination appears on the floor between the bookcases near the old Caverns of Time portal area. It is upstairs, separate from Conjuration.",
        "At the Dalaran Visitor Center (52.2, 55.5), check the floor to the right inside the entrance, beside the small table and chair, for Abjuration.",
        "Outside the Violet Hold (64.5, 52.8), check the crate against the wall beside Archmage Timear for Illusion. Stay in the entrance courtyard; no dungeon clear is needed.",
        "Go inside the Violet Gate's teleportation-crystal room (56.5, 45.8). Introduction lies on the floor beside the northern bookcase, on your right as you enter.",
        "Repeat only your missing locations. Read placeholder books too so their spawn can cycle; books usually disappear a few minutes after being opened and replacements can take hours. Share genuine-book sightings promptly because several players can read the same spawn.",
        "When all eight criteria complete, collect the Mastery book from the achievement mail and use it to learn the toy. If an older completion has no book, speak to Rhonin inside the Violet Citadel (30.5, 48.4) on the character that completed Higher Learning. Check that character's bank before requesting another copy.",
        "Activate the toy while in Northrend Dalaran to visit Vargoth's retreat. Speak to Vargoth there for the additional Kirin Tor Familiar pet, then activate the book again to leave. The pet conversation needs the character that read the books.",
    },
    tips = "Check the achievement after each real book. The eight titles have fixed positions but can be replaced by unrelated reading material. A 12.0 bug report has a reply confirming successful completion; a missing spawn alone does not establish that the achievement is removed.",
    effect = "Teleports between Dalaran and Archmage Vargoth's retreat while in the city. Northrend Vargoth supplies the separate Familiar reward.",
    waypoints = {
        pin(125, 46.9, 39.8, 2, "Transmutation - Legerdemain Lounge, DOWNSTAIRS", "Dalaran (Northrend)"),
        pin(125, 46.9, 39.3, 3, "Necromancy - Legerdemain Lounge, UPSTAIRS bedroom", "Dalaran (Northrend)"),
        pin(125, 43.5, 47.0, 4, "Enchantment - Threads of Fate, upstairs BALCONY crate", "Dalaran (Northrend)"),
        pin(125, 30.9, 46.3, 5, "Conjuration - Violet Citadel, downstairs bookcase", "Dalaran (Northrend)"),
        pin(125, 26.5, 51.7, 6, "Divination - Violet Citadel, upstairs floor", "Dalaran (Northrend)"),
        pin(125, 52.2, 55.5, 7, "Abjuration - Visitor Center floor", "Dalaran (Northrend)"),
        pin(125, 64.5, 52.8, 8, "Illusion - crate OUTSIDE Violet Hold", "Dalaran (Northrend)"),
        pin(125, 56.5, 45.8, 9, "Introduction - Violet Gate portal room floor", "Dalaran (Northrend)"),
        pin(125, 30.5, 48.4, 11, "Rhonin - replacement book for the eligible character", "Dalaran (Northrend)"),
    },
})

-- https://www.wowhead.com/item=44430#comments:id=2274233 and reply
-- https://www.wowhead.com/item=44430#comments:id=5410981
-- https://www.wowhead.com/item=44430#comments:id=2012975 and reply
-- https://www.wowhead.com/achievement=2096#comments:id=449998 and replies
-- https://www.wowhead.com/achievement=2096#comments:id=5788955
-- https://www.wowhead.com/achievement=2096#comments:id=6126017 and all replies
-- https://www.wowhead.com/achievement=2094/a-penny-for-your-thoughts
-- https://www.wowhead.com/achievement=2095/silver-in-the-city
-- https://www.wowhead.com/achievement=1957/there-is-gold-in-that-there-fountain
addToy(44430, "Titanium Seal of Dalaran", {
    description = "A reusable coin-flipping toy awarded for collecting the original Dalaran fountain coins.",
    category = "Achievements", source = "The Coin Master (2096) - Northrend Dalaran fountain fishing",
    sourceAchievementId = 2096,
    requirements = "Fishing; catch the required coins yourself in Northrend Dalaran.",
    cost = "No toy purchase cost. A fishing pole and optional lures are the only supplies.",
    steps = {
        "Travel to Northrend Dalaran and find the fountain in the Eventide at about 52.6, 66.5. Track The Coin Master (2096) and its three coin achievements. The Legion fountain has a different coin collection.",
        "Stand a little back from the rim, face the water and cast into the fountain. Catch every named coin required by A Penny For Your Thoughts (copper), Silver in the City, and There Is Gold In That There Fountain. Buying or receiving coins from another player does not replace fishing them yourself.",
        "Whenever you catch a gold coin, use it beside the fountain to obtain the two-minute Lucky buff. Refresh after it expires; using several at once does not extend it. Let each catch finish looting before recasting.",
        "Keep checking the missing coin names in each criterion list. Duplicate coins are normal and the final missing name can take much longer than the others. Vendor spare copper and silver coins for bag space; keep spare gold coins for Lucky.",
        "After the meta completes, check the Toy Box: Retail reports include direct automatic learning rather than an item in the mail. If the toy is still missing, check the completion character's mail and speak to Jepetto Joybuzz in The Wonderworks (44.6, 45.8) about a replacement.",
    },
    tips = "Breanni's shop is not the fishing spot. No fixed number of casts guarantees the last coin. You can start with low Northrend Fishing skill; additional fishing supplies help with fishing, not with selecting a particular missing name.",
    effect = "Flips a coin with a heads-or-tails emote; 10-second cooldown.",
    waypoints = {
        pin(125, 52.6, 66.5, 1, "Eventide fountain - original Dalaran coin collection", "Dalaran (Northrend)"),
        pin(125, 52.6, 66.5, 2, "Fish here for all three coin lists", "Dalaran (Northrend)"),
        pin(125, 52.6, 66.5, 3, "Use a gold coin here for Lucky", "Dalaran (Northrend)"),
        pin(125, 44.6, 45.8, 5, "Jepetto Joybuzz - replacement for an older completion", "Dalaran (Northrend)"),
    },
})

-- https://www.wowhead.com/item=44719#comments:id=458800 and replies
-- https://www.wowhead.com/item=44719#comments:id=2014920
-- https://www.wowhead.com/item=44719#comments:id=2024593
-- https://www.wowhead.com/item=44719#comments:id=2358032
-- https://www.wowhead.com/item=44717/disgusting-jar (Retail duration: 3 days)
-- https://www.wowhead.com/npc=31911/tanak
-- https://www.wowhead.com/npc=28659/artruis-the-heartless
-- https://www.wowhead.com/quest=12582/frenzyheart-champion
-- https://www.wowhead.com/quest=12692/return-of-the-lich-hunter
addToy(44719, "Frenzyheart Brew", {
    description = "A reusable Wolvar disguise randomly found in the Frenzyheart's matured jars.",
    category = "Reputation", source = "Ripe Disgusting Jar; Tanak sells the fermenting jar at Frenzyheart Revered", npcId = 31911,
    requirements = "Revered with the Frenzyheart Tribe to buy jars. Choose Frenzyheart at Artruis if currently aligned with the Oracles.",
    cost = "One Disgusting Jar per attempt: 3 gold before reputation discounts, followed by 3 real-time days of fermentation.",
    steps = {
        "If the Sholazar factions are not unlocked, kill Pitch near 50.5, 76.5 and accept Playing Along from Tracker Gekgek. Follow High-Shaman Rakjak's jobs at Frenzyheart Hill (55.0, 69.2) through Just Following Orders, help the injured Oracle, then follow the Rainspeaker Canopy story through A Hero's Burden. The initial jobs for both sides are part of the unlock.",
        "Enter Artruis's cave at 70.9, 58.7 and reach him around 72.2, 57.5. Let his encounter release Jaloot and Zepik. Kill JALOOT, keep ZEPIK alive, then defeat Artruis to choose Frenzyheart. Avoid area damage and instant kills that skip the choice; remove damage gear and control your attacks if overlevelled.",
        "Speak to surviving Zepik inside the cave. Complete Frenzyheart Champion and take Return of the Lich Hunter back to Frenzyheart Hill. If switching from the Oracles, finish these normal follow-ups before expecting the hill's dailies; merely killing Artruis does not complete the change.",
        "At Frenzyheart Hill, complete the available daily quests and return for the next daily reset until Revered. Keep the quest's supplied companion available when its objectives require it. Remaining with Frenzyheart while buying jars avoids switching back and losing access to their quartermaster.",
        "Buy a Disgusting Jar (44717) from Tanak at 55.0, 69.0. Keep it for THREE real-time days until it becomes a Ripe Disgusting Jar (44718). This timer continues while logged out; the old seven-day duration is obsolete.",
        "Open the ripe jar. If it contains Frenzyheart Brew, use the Brew to add the toy. Otherwise buy another jar and repeat the three-day cycle. The jar is Unique, so you cannot queue several fermenting jars on one character.",
    },
    tips = "The Brew is a random jar outcome, not a direct vendor purchase or an Exalted reward. Oracles eggs contain different rewards. Once learned, the toy remains collected when you later change Sholazar allegiance.",
    effect = "Transforms you into a Wolvar for 5 minutes; 30-minute cooldown. The Brew is not consumed.",
    waypoints = {
        pin(119, 50.5, 76.5, 1, "Pitch / Tracker Gekgek - begin faction story", "Sholazar Basin"),
        pin(119, 55.0, 69.2, 1, "High-Shaman Rakjak - early Frenzyheart story", "Sholazar Basin"),
        pin(119, 54.6, 56.2, 1, "Rainspeaker Canopy - continue story to A Hero's Burden", "Sholazar Basin"),
        pin(119, 70.9, 58.7, 2, "Artruis cave ENTRANCE", "Sholazar Basin"),
        pin(119, 72.2, 57.5, 2, "Artruis - kill Jaloot and SAVE Zepik", "Sholazar Basin"),
        pin(119, 72.0, 57.6, 3, "Zepik - Frenzyheart Champion and Return of the Lich Hunter", "Sholazar Basin"),
        pin(119, 55.0, 69.2, 4, "Frenzyheart Hill - daily reputation quests", "Sholazar Basin"),
        pin(119, 55.0, 69.0, 5, "Tanak - buy the 3-day Disgusting Jar at Revered", "Sholazar Basin"),
    },
})

-- https://www.wowhead.com/item=45984#comments:id=635093 and replies
-- https://www.wowhead.com/item=45984#comments:id=2133018 and both replies
-- https://www.wowhead.com/item=45984#comments:id=2076631 and all replies
-- https://www.wowhead.com/npc=28742/marcia-chase (five daily quests)
-- Retail quest objectives: 13830, 13832, 13833, 13834, 13836.
-- https://www.wowhead.com/quest=13832#comments:id=3305626 (Underbelly 44,66)
-- https://www.wowhead.com/quest=13836#comments:id=5588623 (Violet Hold 66,61)
-- https://www.wowhead.com/quest=13834#comments:id=876066 (Wintergrasp 71,42)
-- https://www.wowhead.com/npc=28706/olisarra-the-kind
addToy(45984, "Unusual Compass", {
    description = "A reusable fishing reward that turns your character toward a random direction.",
    category = "Daily Quests", source = "Bag of Fishing Treasures from Marcia Chase's Northrend Dalaran dailies; tradable unused toy", npcId = 28742,
    requirements = "Fishing and access to Marcia's daily for the bag route; no Fishing requirement to learn a bought compass.",
    cost = "No purchase cost for daily attempts; Auction House prices for the unused compass vary.",
    steps = {
        "For a direct purchase, search the Auction House for Unusual Compass (45984), buy an unused one and continue at step 5. Otherwise visit Marcia Chase beside the Eventide fountain in Northrend Dalaran (52.6, 64.8) and accept her available fishing daily.",
        "If offered Jewel Of The Sewers, fish the Northrend Dalaran Underbelly for Corroded Jewelry. If offered Disarmed!, fish the water OUTSIDE Violet Hold for a Bloated Slippery Eel, then open that eel for the Severed Arm. Disarmed! finishes with Olisarra the Kind in the first-aid shop (36.8, 37.6), rather than Marcia.",
        "For The Ghostfish, fish River's Heart in Sholazar Basin (about 49.0, 61.0) and EAT the Phantom Ghostfish promptly to discover its secret. For Blood Is Thicker, kill a Borean Tundra beast to get covered in blood, enter nearby water to create a Blood Pool, then fish 5 Bloodtooth Frenzies from that pool. For Dangerously Delicious, fish Wintergrasp's open water for 10 Terrorfish.",
        "Return the completed daily to Marcia, except for Disarmed!'s Olisarra turn-in. Open the actual Bag of Fishing Treasures (46007). If the compass is absent, try again after the daily reset or use another eligible character; an ordinary Draenor fishing-daily reward bag is a different item.",
        "Use the compass from your bags to learn the Toy Box entry. It is a cosmetic random-direction effect; it does not point toward the Time-Lost Proto-Drake or hidden treasure.",
    },
    tips = "Draenor cavedwellers can also drop a compass, but the ordinary garrison fishing daily bag does not. The listed daily destinations are alternatives: complete only the quest Marcia offers that day.",
    effect = "After a short cast, faces your character in a random direction; 10-second cooldown.",
    waypoints = {
        pin(125, 52.6, 64.8, 1, "Marcia Chase - accept today's fishing daily", "Dalaran (Northrend)"),
        pin(126, 44.0, 66.0, 2, "Underbelly water - Jewel Of The Sewers fishing area", "Dalaran Underbelly (Northrend)"),
        pin(125, 66.0, 61.0, 2, "Water OUTSIDE Violet Hold - Disarmed! fishing area", "Dalaran (Northrend)"),
        pin(125, 36.8, 37.6, 2, "Olisarra the Kind - Disarmed! turn-in", "Dalaran (Northrend)"),
        pin(119, 49.0, 61.0, 3, "River's Heart - catch and eat Phantom Ghostfish", "Sholazar Basin"),
        pin(114, 79.0, 28.0, 3, "Blood Is Thicker - beast blood, then make a pool in water", "Borean Tundra"),
        pin(123, 71.0, 42.0, 3, "Wintergrasp - Terrorfish open-water fishing area", "Wintergrasp"),
        pin(125, 52.6, 64.8, 4, "Marcia - turn-in for four of the five dailies", "Dalaran (Northrend)"),
        pin(125, 36.8, 37.6, 4, "Olisarra - Disarmed! reward bag", "Dalaran (Northrend)"),
    },
})

-- All ten banner pages were read separately. Their useful acquisition facts
-- are the city Champion requirement, 15-seal price and paired Toy Box unlock.
-- https://www.wowhead.com/item=45011#comments:id=2012816
-- https://www.wowhead.com/item=45013#comments:id=2017994
-- https://www.wowhead.com/item=45014#comments:id=2016421
-- https://www.wowhead.com/item=45015#comments:id=2018915 and reply
-- https://www.wowhead.com/item=45016#comments:id=2017996
-- https://www.wowhead.com/item=45017#comments:id=2016578
-- https://www.wowhead.com/item=45018#comments:id=2168947
-- https://www.wowhead.com/item=45019#comments:id=2025148 and replies
-- https://www.wowhead.com/item=45020#comments:id=2025144
-- https://www.wowhead.com/item=45021#comments:id=2025146
-- Retail quartermasters: 33307, 33556, 33553, 33554, 33555, 33557,
-- 33310, 33650, 33657, 33653. Their positions and sells tables were checked.
-- https://www.wowhead.com/npc=33817/justicar-mariel-trueheart
-- https://www.wowhead.com/quest=13672/up-to-the-challenge
-- https://www.wowhead.com/quest=13699/the-valiant-s-challenge
local cityBanners = {
    {45011, "Stormwind Banner", "Alliance", "Stormwind", "Corporal Arthur Flew", 33307, 76.4, 19.2, "Orgrimmar Banner", "Horde", "Orgrimmar"},
    {45013, "Thunder Bluff Banner", "Horde", "Thunder Bluff", "Doru Thunderhorn", 33556, 76.2, 24.4, "Gnomeregan Banner", "Alliance", "Gnomeregan"},
    {45014, "Orgrimmar Banner", "Horde", "Orgrimmar", "Freka Bloodaxe", 33553, 76.4, 24.2, "Stormwind Banner", "Alliance", "Stormwind"},
    {45015, "Sen'jin Banner", "Horde", "Sen'jin", "Samamba", 33554, 76.0, 24.4, "Ironforge Banner", "Alliance", "Ironforge"},
    {45016, "Undercity Banner", "Horde", "Undercity", "Eliza Killian", 33555, 76.4, 24.0, "Darnassus Banner", "Alliance", "Darnassus"},
    {45017, "Silvermoon City Banner", "Horde", "Silvermoon City", "Trellis Morningsun", 33557, 76.2, 23.8, "Exodar Banner", "Alliance", "the Exodar"},
    {45018, "Ironforge Banner", "Alliance", "Ironforge", "Derrick Brindlebeard", 33310, 76.4, 19.4, "Sen'jin Banner", "Horde", "Sen'jin"},
    {45019, "Gnomeregan Banner", "Alliance", "Gnomeregan", "Rillie Spindlenut", 33650, 76.4, 19.6, "Thunder Bluff Banner", "Horde", "Thunder Bluff"},
    {45020, "Exodar Banner", "Alliance", "the Exodar", "Irisee", 33657, 76.2, 19.2, "Silvermoon City Banner", "Horde", "Silvermoon City"},
    {45021, "Darnassus Banner", "Alliance", "Darnassus", "Rook Hawkfist", 33653, 76.2, 19.2, "Undercity Banner", "Horde", "Undercity"},
}
for _, banner in ipairs(cityBanners) do
    local id, name, faction, city, vendor, npc, x, y, counterpart, opposite, oppositeCity = unpack(banner)
    addToy(id, name, {
        description = "A reusable " .. city .. " city banner planted on the ground; paired with " .. counterpart .. " in the Toy Box.",
        category = "Argent Tournament", source = vendor .. " - " .. city .. " quartermaster at the Argent Tournament", npcId = npc,
        requirements = faction .. " character and Champion of " .. city .. " to buy directly; the paired " .. opposite .. " toy also unlocks this collection entry.",
        cost = "15 Champion's Seals. One purchase learns both faction counterparts.",
        steps = {
            "Check the Toy Box for both " .. name .. " and " .. counterpart .. " first. Learning one grants both collection entries. If already collected, use the faction-appropriate banner without repeating the tournament on every alt.",
            "For the direct purchase, use a " .. faction .. " character and start The Argent Tournament with Justicar Mariel Trueheart in Icecrown (69.6, 22.8). Finish the lance lessons, earn 15 Aspirant's Seals from training dailies, and win The Aspirant's Challenge.",
            "Complete your first city's Valiant training: 25 Valiant's Seals from its dailies, then The Valiant's Challenge and A Champion Rises. For jousting, equip the supplied lance, use a tournament mount, maintain three Defend stacks and strip the opponent's shields before charging.",
            "You need Champion of " .. city .. ". If your first city was different, take " .. city .. "'s Valiant line in the faction pavilion and complete its 25-seal training and challenge too. Train one city at a time. Champion status and Exalted home-city reputation are separate things.",
            "Save 15 CHAMPION'S Seals from unlocked Champion dailies and open their purses. Aspirant's and Valiant's Seals are training resources and cannot pay for the banner. Continue city training alongside Champion dailies if still unlocking the desired seller.",
            "Visit " .. vendor .. " at " .. x .. ", " .. y .. " in the " .. faction .. " pavilion and purchase " .. name .. " for 15 Champion's Seals. The tournament seller remains in Icecrown even if the banner's home city has changed elsewhere in the world.",
            "Use the banner item and check both Toy Box entries. A " .. opposite .. " collector can instead follow the same city-training route for " .. oppositeCity .. " and buy " .. counterpart .. ". Activation remains faction-specific; there is no need for a faction change just to obtain the paired entry.",
        },
        tips = "The banner lasts 3 minutes and shares its cooldown with the other tournament city banners. It provides no combat bonus. The Thunder Bluff/Gnomeregan and Sen'jin/Ironforge toy pairings differ from some tournament mount pairings.",
        effect = "Plants the " .. city .. " banner for 3 minutes; shared 3-minute banner cooldown.",
        waypoints = {
            pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
            pin(118, x, y, 3, faction .. " pavilion - first city training", "Icecrown"),
            pin(118, x, y, 4, city .. " delegation - city Champion unlock", "Icecrown"),
            pin(118, 69.6, 22.8, 5, "Argent pavilion - unlocked Champion daily quests", "Icecrown"),
            pin(118, x, y, 6, vendor .. " - " .. name .. ", 15 seals", "Icecrown"),
            pin(118, opposite == "Alliance" and 76.4 or 76.2, opposite == "Alliance" and 19.4 or 24.2, 7,
                opposite .. " pavilion - optional " .. counterpart .. " collection route", "Icecrown"),
        },
    })
end

-- https://www.wowhead.com/item=46843#comments:id=762692 and replies
-- https://www.wowhead.com/item=46843#comments:id=1363271
-- https://www.wowhead.com/npc=34885/dame-evniki-kapsalis
-- https://www.wowhead.com/npc=34885#comments:id=1934029 and account-wide-access reply
-- https://www.wowhead.com/achievement=2816/exalted-argent-champion-of-the-horde
-- https://www.wowhead.com/achievement=2817/exalted-argent-champion-of-the-alliance
-- The Retail sells table confirms 15 Champion's Seals, not a gold purchase.
addToy(46843, "Argent Crusader's Banner", {
    description = "The Argent Crusade's planted banner, sold by the tournament's Crusader quartermaster.",
    category = "Argent Tournament", source = "Dame Evniki Kapsalis - Crusader quartermaster in the Argent pavilion", npcId = 34885,
    requirements = "Crusader vendor access: champion all five original cities of your faction, become Exalted with them, and become Exalted with the Argent Crusade.",
    cost = "15 Champion's Seals after unlocking the quartermaster.",
    steps = {
        "Check Dame Evniki Kapsalis inside the western Argent pavilion in Icecrown (69.5, 23.2). The Crusader title can provide account-wide vendor access, so check before repeating another character's grind. If her inventory opens, save 15 Champion's Seals and continue at step 6.",
        "If starting fresh, speak to Justicar Mariel Trueheart (69.6, 22.8). Finish the tournament lessons, collect 15 Aspirant's Seals from daily training and win The Aspirant's Challenge. Equip the supplied lance and ride a tournament mount for mounted challenges.",
        "Complete your home city's Valiant training: collect 25 Valiant's Seals, win The Valiant's Challenge and turn in A Champion Rises. Continue the Valiant line for each of the other four original cities, one city at a time, until you are Champion of all five.",
        "Reach Exalted with all five cities of that faction, as well as the Argent Crusade. Use Champion's Writs from tournament rewards for missing home-city reputation. For Argent Crusade reputation, its tabard in eligible legacy Wrath dungeons provides a separate route. Check the Exalted Argent Champion achievement requirements rather than assuming the first Champion title is Crusader.",
        "Keep completing the unlocked Champion dailies and opening their purses until you have 15 Champion's Seals available. Neither Aspirant's nor Valiant's Seals can buy this reward. Check the vendor again on the character that completed the unlock.",
        "Buy Argent Crusader's Banner from Dame Evniki Kapsalis at 69.5, 23.2 and use it from your bags to learn the toy. Both factions can use this banner; it is separate from the ten racial banners and their paired unlocks.",
    },
    tips = "Dame is in the Argent pavilion on the WEST side of the grounds, not the racial quartermasters' eastern tents. A completed city championship alone does not unlock her inventory.",
    effect = "Plants an Argent Crusader's banner for 3 minutes; 3-minute cooldown.",
    waypoints = {
        pin(118, 69.5, 23.2, 1, "Dame Evniki Kapsalis - check Crusader vendor access", "Icecrown"),
        pin(118, 69.6, 22.8, 2, "Justicar Mariel Trueheart - tournament introduction", "Icecrown"),
        pin(118, 76.4, 19.4, 3, "Alliance pavilion - five city championships", "Icecrown"),
        pin(118, 76.2, 24.2, 3, "Horde pavilion - five city championships", "Icecrown"),
        pin(118, 69.6, 22.8, 5, "Argent pavilion - Champion daily quests", "Icecrown"),
        pin(118, 69.5, 23.2, 6, "Dame Evniki - Argent Crusader's Banner, 15 seals", "Icecrown"),
    },
})

-- https://www.wowhead.com/item=48933#comments:id=764178 and all 15 replies
-- https://www.wowhead.com/item=48933#comments:id=2306709 and replies
-- https://www.wowhead.com/item=48933#comments:id=5701413
-- https://www.wowhead.com/spell=67920/wormhole-generator-northrend
-- https://www.wowhead.com/npc=28697/timofey-oshenko
addToy(48933, "Wormhole Generator: Northrend", {
    description = "An engineer's personal wormhole with a choice of Northrend destination zones.",
    category = "Professions", source = "Northrend Engineering trainer recipe; unused finished toy can be traded", npcId = 28697,
    requirements = "Collection: no profession. Crafting: Northrend Engineering 60. Teleport use: Northrend Engineering 40 and level 24.",
    cost = "8 Titanium Bars; 2 each of Eternal Shadow, Eternal Water, Eternal Fire and Eternal Air. Alternatively buy the finished toy.",
    steps = {
        "For collection only, buy Wormhole Generator: Northrend (48933) on the Auction House or ask an Engineer to make one. Use the finished item and skip to step 4. Learning the toy does not grant the Engineering skill needed for teleports.",
        "For self-crafting, visit Timofey Oshenko in Like Clockwork, Northrend Dalaran (38.8, 25.8). Learn Northrend Engineering, raise it to 60 and train the recipe. It does not require Gnomish or Goblin specialization.",
        "Bring 8 Titanium Bars and 2 each of Eternal Shadow, Eternal Water, Eternal Fire and Eternal Air, plus the listed Arclight Spanner and Gyromatic Micro-Adjustor tools. Craft the generator and use the finished item to add it to the Toy Box.",
        "On a level-24-or-higher Engineer with Northrend Engineering 40, activate the toy on solid ground. Click the resulting wormhole and select your destination while it remains open for one minute. Other players cannot use your personal wormhole as a group portal.",
        "The usual exits are Borean Tundra (51.0, 44.0, above Lake Kum'uya), Howling Fjord (58.0, 47.0, Utgarde Keep ledge), Sholazar Basin (34.0, 39.0, pillar ledge), Icecrown (65.0, 31.0, mountainside), and The Storm Peaks (43.0, 25.0, Ulduar ledge). Choose the matching map in the guide dropdown to inspect that arrival.",
        "Prepare a flying mount or fall protection before leaving high ledges. The Borean destination drops you toward a lake: allow the fall into water rather than steering onto rocks. The generator has a four-hour cooldown; recrafting or buying a spare does not provide a fresh independent use.",
    },
    tips = "Recipe skill 60 and activation skill 40 are intentionally different. The trainer is in Northrend Dalaran's engineering shop, not Breanni's pet shop or the sewers. Optional unusual menu outcomes are not required to collect the toy.",
    effect = "Creates a personal wormhole for one minute; selected Northrend zone destination, 4-hour cooldown.",
    waypoints = {
        pin(125, 38.8, 25.8, 2, "Timofey Oshenko - recipe at Northrend Engineering 60", "Dalaran (Northrend)"),
        pin(114, 51.0, 44.0, 5, "Borean arrival - ABOVE Lake Kum'uya", "Borean Tundra"),
        pin(117, 58.0, 47.0, 5, "Howling Fjord arrival - Utgarde Keep LEDGE", "Howling Fjord"),
        pin(119, 34.0, 39.0, 5, "Sholazar arrival - pillar LEDGE", "Sholazar Basin"),
        pin(118, 65.0, 31.0, 5, "Icecrown arrival - mountainside", "Icecrown"),
        pin(120, 43.0, 25.0, 5, "Storm Peaks arrival - Ulduar ledge", "The Storm Peaks"),
    },
})

-- Both toy item pages and their relevant chest/turn-in replies were read:
-- https://www.wowhead.com/item=52201#comments:id=1020507 and replies
-- https://www.wowhead.com/item=52201#comments:id=1024367 and all replies
-- https://www.wowhead.com/item=52253#comments:id=1017877 and reply
-- https://www.wowhead.com/item=52253#comments:id=1024371 and reply
-- https://www.wowhead.com/item=52253#comments:id=5963561 and 2024 correction reply
-- https://www.wowhead.com/quest=24914#comments:id=1013397 and all replies
-- https://www.wowhead.com/quest=24917#comments:id=1664471
-- https://www.wowhead.com/quest=24918#comments:id=1664460 and reply
-- https://www.wowhead.com/quest=24545/the-sacred-and-the-corrupt
-- https://www.wowhead.com/quest=24547#comments:id=6218544
-- https://www.wowhead.com/quest=24547#comments:id=6253750
-- https://www.wowhead.com/quest=24749#comments:id=2086520 and all 24 replies
-- https://www.wowhead.com/quest=24749#comments:id=6349458 (12.0.5)
-- https://www.wowhead.com/quest=24756#comments:id=3176141 and all 34 replies
-- https://www.wowhead.com/quest=24756#comments:id=3303255 and all replies
-- The two profit-ending alt guides above are adapted using these later Retail
-- corrections, including reconnect speed, same-faction/instance and kill credit:
-- https://www.wowhead.com/quest=24756#comments:id=6051266
-- https://www.wowhead.com/quest=24756#comments:id=6326570 (2026 helper route)
-- https://www.wowhead.com/quest=24756#comments:id=6371344 (2026 reconnect timing)
-- https://www.wowhead.com/quest=24756#comments:id=6436693 (2026 credit after kill)
-- https://www.wowhead.com/quest=24757/frost-infusion
-- Retail boss floor positions: 36626, 36627, 36678, 37955, 36853, 36597.
local shadowmourneToys = {
    {52201, "Muradin's Favor", "Arthas' Training Sword", "Muradin's Lament", "Muradin Bronzebeard",
        "Transforms you into a Frost Dwarf for 10 minutes; 30-minute cooldown."},
    {52253, "Sylvanas' Music Box", "Blood of Sylvanas", "Sylvanas' Vengeance", "Lady Sylvanas Windrunner",
        "Places a music box with spectral singers performing Lament of the Highborne; 1-hour cooldown."},
}
for _, toy in ipairs(shadowmourneToys) do
    local id, name, keepsake, quest, recipient, effect = unpack(toy)
    addToy(id, name, {
        description = effect,
        category = "Quest Rewards", source = quest .. " - Shadowmourne's one-time chest; unused finished toy can be traded",
        requirements = "Buying the toy: any class, either faction. Creating your own chest: Warrior, Paladin or Death Knight completing Shadowmourne in 25-player Icecrown Citadel.",
        cost = "Auction House price varies. Self-farming includes 25 Primordial Saronite, 50 Shadowfrost Shards and the legendary quest chain.",
        steps = {
            "For the direct route, buy the FINISHED " .. name .. " (" .. id .. ") from the Auction House or another player and continue at step 16. Neither Shadowmourne ownership nor its class restrictions apply to a buyer. For your own quest reward, follow steps 2-15.",
            "On a Warrior, Paladin or Death Knight, enter 25-player Icecrown Citadel at 53.7, 87.0 in Icecrown. Reach Friendly with the Ashen Verdict by killing raid enemies, then accept The Sacred and the Corrupt from Highlord Darion Mograine on the left inside the entrance (42.6, 22.6 on The Lower Citadel map).",
            "With the quest active, travel to Frostmourne Cavern in northeastern Dragonblight (74.4, 23.5). Interact with Light's Vengeance, let the Lich King's scene play, interact again when prompted and defeat the resurrected enemy. Loot the hammer after the sequence; this is the quest object, not a normal world weapon drop.",
            "Obtain 25 Primordial Saronite and loot Festergut's Acidic Blood and Rotface's Acidic Blood in the 25-player raid. Their rooms are on The Upper Reaches floor, at 19.8, 65.4 and 19.8, 41.9 respectively. Deliver the components to Darion and finish the runeforge turn-ins to receive Shadow's Edge.",
            "For A Feast of Souls, EQUIP Shadow's Edge and collect 50 souls. Apply Shadow's Fate before killing enemies; instant kills can miss credit. A Death Knight can tag with Chains of Ice without attacking, or a Protection Warrior with Demoralizing Shout. Check the debuff and quest counter before clearing more enemies. Disable incidental damage effects that kill targets too soon. Return to Darion for Unholy Infusion when complete.",
            "For Unholy Infusion, keep Shadow's Edge equipped and bring a helper to hold Professor Putricide at 13.2, 53.4 on The Upper Reaches. Let several slime puddles form without pushing him through phases. Use his laboratory table to become the abomination, absorb puddles until you have 100 energy, then cast the vehicle's Shadow Infusion ability fully. Only kill Putricide after the infusion is active; the helper prevents him resetting while you are in the vehicle. Turn in the quest before the next infusion.",
            "For Blood Infusion, reach Blood-Queen Lana'thel at 51.1, 43.8 on Royal Quarters with Shadow's Edge equipped. Use three same-faction helpers who hold damage, dismiss pets and spread out. An alternative is three of your own same-faction alts: invite them through a custom premade raid, enter the SAME saved instance with the quest character first, and position all four in her room before pulling. Faster loading matters for that alternative.",
            "Gain Blood Mirror so Gushing Wound applies, and obtain Essence of the Blood Queen on the quest character. Keep a helper close enough for the mirror link until it appears. For the alt method, body-pull on the quest character, reconnect into alt 1, then immediately reconnect back to the quest character; the disconnected alt remains available to bite. Two windowed game clients avoid repeatedly waiting for a full client restart. Temporarily disable slow-loading addons through the character-selection AddOns menu if needed.",
            "Wait for Essence's timer to expire, target the first unbitten helper/alt and use Vampiric Bite from the temporary action bar immediately. Confirm the bite landed. Repeat for a SECOND and THIRD different target when the timer returns. With your own alts, reconnect into alt 2 and back before bite two, then alt 3 and back before bite three. Use low-damage alts first so mind control does not kill the remaining targets; keep the final alt sturdy enough to survive.",
            "Count THREE successful bites, then kill Lana'thel while still wielding Shadow's Edge. The quest credit arrives after her death, so lack of an early completion popup is not failure. If the setup fails, reset the encounter while she is alive; killing her prematurely spends that character's weekly opportunity. Return to Darion and take Frost Infusion before touching Sindragosa.",
            "For Frost Infusion, reach Sindragosa at 36.6, 23.4 on The Frost Queen's Lair map. Keep Shadow's Edge equipped, face her breath and survive FOUR Frost Breaths before finishing her. Hold damage and heal through the waiting period; killing her before the fourth breath means waiting for another eligible weekly kill.",
            "Turn in the infusion and accept The Splintered Throne. Collect 50 Shadowfrost Shards from eligible 25-player Icecrown boss kills over weekly resets. The shards are quest drops; bought Primordial Saronite cannot replace them. Finish Darion's forging quests to receive Shadowmourne.",
            "Accept The Lich King's Last Stand. With the finished Shadowmourne equipped, defeat the Lich King on The Frozen Throne (49.9, 52.8) in the 25-player raid and loot the Sealed Chest. This reward is once per eligible legendary quest chain; ordinary weekly kills with an already-finished Shadowmourne do not generate unlimited chests.",
            "Use the raid's transporters to return to The Lower Citadel. Bring the chest to Darion (42.6, 22.6) for Personal Property and open the Unsealed Chest. It contains the keepsakes for ALL five follow-up rewards; choosing one does not forfeit the others.",
            "Take " .. keepsake .. " from that container and use it to start " .. quest .. ". Speak to " .. recipient .. " among the post-victory NPCs near the raid entrance. This is the friendly ICC version, even for the opposite faction. Do not travel to a capital-city version of the character. Wait for one reward's scene to finish before turning in another keepsake. If the NPCs are missing on a later visit, finish the Lich King again in that instance to restore the victory phase.",
            "Use " .. name .. " from your bags to add it to the account-wide Toy Box. If you bought the finished toy, no chest, keepsake delivery or legendary quest is needed. An unused reward can be traded; a learned Toy Box entry cannot be sold.",
        },
        tips = "Helpers must hold damage during the infusion setups. Turn each infusion in before killing the next required boss. Buying the finished toy bypasses the entire legendary chain. Reusing someone else's already-completed Shadowmourne is not a repeatable chest farm.",
        effect = effect,
        waypoints = {
            pin(118, 53.7, 87.0, 2, "Icecrown Citadel raid entrance - set 25-player", "Icecrown"),
            pin(186, 42.6, 22.6, 2, "Darion Mograine - start the Shadowmourne chain", "Icecrown Citadel: The Lower Citadel"),
            pin(115, 74.4, 23.5, 3, "Frostmourne Cavern - Light's Vengeance quest sequence", "Dragonblight"),
            pin(190, 19.8, 65.4, 4, "Festergut - loot Acidic Blood on 25-player", "Icecrown Citadel: The Upper Reaches"),
            pin(190, 19.8, 41.9, 4, "Rotface - loot Acidic Blood on 25-player", "Icecrown Citadel: The Upper Reaches"),
            pin(186, 42.6, 22.6, 4, "Darion / runeforge - receive Shadow's Edge", "Icecrown Citadel: The Lower Citadel"),
            pin(186, 42.6, 22.6, 5, "Darion - finish A Feast of Souls, take Unholy Infusion", "Icecrown Citadel: The Lower Citadel"),
            pin(190, 13.2, 53.4, 6, "Putricide - abomination, 100 energy, Shadow Infusion", "Icecrown Citadel: The Upper Reaches"),
            pin(186, 42.6, 22.6, 6, "Darion - finish Unholy Infusion, take Blood Infusion", "Icecrown Citadel: The Lower Citadel"),
            pin(191, 51.1, 43.8, 7, "Lana'thel - prepare three bite targets", "Icecrown Citadel: Royal Quarters"),
            pin(191, 51.1, 43.8, 8, "Lana'thel - Blood Mirror and vampire setup", "Icecrown Citadel: Royal Quarters"),
            pin(191, 51.1, 43.8, 9, "Lana'thel - perform three bites", "Icecrown Citadel: Royal Quarters"),
            pin(191, 51.1, 43.8, 10, "Lana'thel - kill AFTER three bites", "Icecrown Citadel: Royal Quarters"),
            pin(186, 42.6, 22.6, 10, "Darion - turn in Blood Infusion before Sindragosa", "Icecrown Citadel: The Lower Citadel"),
            pin(189, 36.6, 23.4, 11, "Sindragosa - survive FOUR Frost Breaths first", "Icecrown Citadel: The Frost Queen's Lair"),
            pin(186, 42.6, 22.6, 12, "Darion - shards quest and completed legendary", "Icecrown Citadel: The Lower Citadel"),
            pin(192, 49.9, 52.8, 13, "Lich King - Shadowmourne equipped, one-time Sealed Chest", "Icecrown Citadel: The Frozen Throne"),
            pin(186, 42.6, 22.6, 14, "Darion - Personal Property / Unsealed Chest", "Icecrown Citadel: The Lower Citadel"),
            pin(186, 42.6, 22.6, 15, "Entrance hub search area - find " .. recipient .. " after victory", "Icecrown Citadel: The Lower Citadel"),
        },
    })
end

-- Availability reviewed 2026-11-04: the remaining 31 toys have live Retail
-- vendors, crafting, achievement, drop or tradable Shadowmourne routes.
-- https://news.blizzard.com/en-us/article/23507736/wrath-of-the-lich-king-mounts-pets-and-more
-- https://warcraft.wiki.gg/wiki/ToyItemID
-- https://www.wowhead.com/item=44719/frenzyheart-brew
rate("easy", "Buy the inexpensive toy from its year-round Dalaran vendor.", {37460,44820,44606,45057,54343,54437,54438})
rate("medium", "Buy unused dice or farm eligible Northrend pockets on a Rogue; a random pocket drop is not guaranteed.", {36862,36863})
rate("medium", "Train the required Northrend Engineering recipe and craft the toy, or buy an eligible finished item.", {40768,48933})
rate("medium", "Raise Northrend Engineering and meet the Gnomish specialization requirement for the personal craft.", {40895})
rate("medium", "Unlock the Storm Peaks vendor and collect ten Relics of Ulduar for the guaranteed purchase.", {43499})
rate("medium", "Fish the fountain's three coin checklists; duplicates and random coin selection can extend the session.", {44430})
rate("medium", "Unlock Frenzyheart Revered and repeat ripened jars until the toy appears.", {44719})
rate("medium", "Repeat fishing dailies and open their reward bags until the compass appears.", {45984})
rate("medium", "Complete the city's daily tournament training and spend fifteen Champion's Seals on its banner.", {
    45011,45013,45014,45015,45016,45017,45018,45019,45020,45021,
})
rate("medium", "A traded reward bypasses Shadowmourne; the personal quest route needs helpers and repeated weekly raids.", {52201,52253})
rate("hard", "Farm Northrend creatures for an exceptionally rare bind-on-pickup drop with no purchase shortcut.", {37254})
rate("hard", "Find all eight correct Dalaran books among decoys and multi-hour respawns for Higher Learning.", {43824})
rate("hard", "Complete all five city championships and required Exalted reputations before buying the Crusader banner.", {46843})

local fields = { "acquisition", "npcId", "source", "tips", "requirements", "cost", "category", "waypoints", "description", "effect", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^3%.") then
        for _, entry in ipairs(patch.toys or {}) do
            local guide = guides[entry.itemId]
            if guide then
                local detailsByName = TDP.PatchCatalog.toyDetails[patchKey]
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

