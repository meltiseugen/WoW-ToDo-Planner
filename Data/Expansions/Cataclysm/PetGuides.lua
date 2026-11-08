-- Retail acquisition routes manually reconciled with the original catalogue.
-- Evidence URLs identify the item comments and current quest/profession records.
-- Instructions are paraphrased; resale comments and obsolete exploits are not routes.
-- A map marker can identify a trainer or search area, rather than a guaranteed drop.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.pets = TDP.CollectionWalkthroughs.pets or {}
local guides = TDP.CollectionWalkthroughs.pets

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(speciesID, name, itemID, guide)
    local lines = { "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason }
    for step, instruction in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. instruction
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #guide.steps
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[speciesID] = guide
end

-- Archaeology item comments: /item=60847, /item=60955, /item=64372,
-- /item=69821 and /item=69824. ViceVersa supplies the project costs;
-- later comments distinguish random project discovery from a guaranteed solve.
-- /npc=44238 and /npc=47571 are the capital Archaeology trainers.
for _, pet in ipairs({
    {264, "Crawling Claw", 60847, "Tol'vir", "Mummified Monkey Paw", 150, "Tol'vir Hieroglyphics", 3, "hard", "Tol'vir sites are limited and discovering this rare project can take hundreds of solves."},
    {266, "Fossilized Hatchling", 60955, "Fossil", "Fossilized Hatchling", 85, false, 0, "medium", "Simple surveying, but the rare project and dig-site mix are random."},
    {277, "Clockwork Gnome", 64372, "Dwarf", "Clockwork Gnome", 100, "Dwarf Rune Stones", 3, "medium", "The project is random, although Eastern Kingdoms has many suitable Dwarf sites."},
    {309, "Pterrordax Hatchling", 69821, "Fossil", "Pterrordax Hatchling", 120, false, 0, "medium", "Repeated Fossil solves and random project discovery are required."},
    {310, "Voodoo Figurine", 69824, "Troll", "Voodoo Figurine", 100, "Troll Tablets", 3, "medium", "The rare project appears randomly while solving Troll artifacts."},
}) do
    local speciesID, name, itemID, race, project, fragments, keystone, slots, level, reason = unpack(pet)
    local region = race == "Tol'vir" and "Kalimdor, particularly Uldum" or race == "Dwarf" and "Eastern Kingdoms" or race == "Troll" and "Eastern Kingdoms" or "Eastern Kingdoms or Kalimdor"
    local sites = race == "Tol'vir"
        and "Reach Archaeology 450 to unlock Tol'vir dig sites. Survey Uldum sites and clear other Kalimdor sites when necessary to roll new locations. If Uldum is in its assault phase, Zidormi at 56.0,35.1 can return you to the earlier zone."
        or "Enable dig sites on your world map and survey the active sites in " .. region .. ". Check each find's race: only " .. race .. " fragments advance this project. Clear other races' sites when necessary to get new sites; a marked region does not guarantee a specific active dig."
    local solve = "When " .. project .. " appears, collect " .. fragments .. " " .. race .. " fragments"
    if keystone then
        solve = solve .. ", or fill up to " .. slots .. " sockets with " .. keystone .. " to reduce the fragment cost by 12 per socket"
    else
        solve = solve .. ". Fossil projects have no keystone sockets"
    end
    local steps = {
        "If you want to earn the pet yourself, train Archaeology with Harrison Jones in Stormwind Keep at 85.7,25.9 or Belloc Brightblade in Orgrimmar at 49.0,70.6. Alternatively, buy a caged " .. name .. " from another player and learn it.",
        sites,
        "Use Survey inside the red dig-site boundary, follow the indicator toward the find, and loot the fragments. Finish ordinary " .. race .. " artifacts from the Archaeology window to reveal new projects. Continue until " .. project .. " is selected; another player's solve count is not a guarantee.",
        solve .. ". Solve the rare project, find " .. name .. " in your bags and use it to learn the pet.",
    }
    if race == "Tol'vir" then
        -- /item=87539#comments (Gershuun, Toonami, 1549749)
        -- /item=104198#comments (shrew26, Lilyoptra, Drailessan)
        table.insert(steps, 4, "Alternative to waiting for Uldum sites: reach Archaeology 600, solve common Pandaria artifacts and right-click the completed objects to crate them into Restored Artifacts. Take these to Brann Bronzebeard in the Seat of Knowledge above Mogu'shan Palace, 83.5,31.0 in the original Vale of Eternal Blossoms. Exchange them for Crates of Tol'vir Archaeology Fragments, open the crates, and solve Tol'vir projects normally. Crates supply fragments; they do not guarantee the pet project.")
        table.insert(steps, 5, "To concentrate that optional farm, first reach Exalted with the Lorewalkers. Buy Brann's Mantid Artifact Hunter's Kit for 2 Restored Artifacts, open it only when ready to dig, and use its Lorewalker's Map with the Sonic Locator active. Survey the Mantid sites in Townlong Steppes and Dread Wastes, crate your common solves, then return to Brann for more Tol'vir crates. The locator lasts 24 real-time hours; do not buy the kit before meeting its reputation requirement.")
    end
    add(speciesID, name, itemID, {
        category = "Professions", source = race .. " Archaeology - rare " .. project .. " project",
        description = "An Archaeology rare: discovering the project is random, but completing that project guarantees this pet.",
        difficulty = level, difficultyReason = reason,
        requirements = "Archaeology for self-discovery; no profession needed to learn a purchased cage",
        cost = fragments .. " " .. race .. " fragments before applicable keystones; alternatively a player-set cage price",
        tips = "A project is selected after completing the previous artifact of that race. You cannot select a pet from a list of undiscovered projects. Buying a cage bypasses the archaeology grind; check its required pet level before learning it.",
        steps = steps,
        waypoints = {
            pin(84, 85.7, 25.9, 1, "Harrison Jones - Alliance Archaeology trainer", "Stormwind City"),
            pin(85, 49.0, 70.6, 1, "Belloc Brightblade - Horde Archaeology trainer", "Orgrimmar"),
        },
        areaMaps = race == "Tol'vir" and {249} or race == "Fossil" and {13, 12} or {13},
    })
    if race == "Tol'vir" then
        guides[speciesID].waypoints[#guides[speciesID].waypoints + 1] = pin(249, 56.0, 35.1, 2, "Zidormi - earlier Uldum if assault phasing hides dig sites", "Uldum")
        guides[speciesID].waypoints[#guides[speciesID].waypoints + 1] = pin(390, 83.5, 31.0, 4, "Brann - optional Tol'vir fragment exchange, above the palace", "Vale of Eternal Blossoms")
        guides[speciesID].waypoints[#guides[speciesID].waypoints + 1] = pin(390, 83.5, 31.0, 5, "Brann - Mantid kit and return for Tol'vir crates", "Vale of Eternal Blossoms")
        guides[speciesID].areaMaps = {249, 388, 422}
    end
end

-- https://www.wowhead.com/item=60869#comments
-- https://www.wowhead.com/achievement=5449#comments
-- https://www.wowhead.com/quest=26710#comments (rickfert, Contay, Hemingray)
add(265, "Pebble", 60869, {
    category = "Achievements", source = "Rock Lover - complete Lost In The Deeps ten times",
    sourceAchievementId = 5449,
    description = "Rescue the quest version of Pebble on ten available daily resets to earn the permanent companion.",
    difficulty = "medium", difficultyReason = "A long Deepholm unlock and ten completions of a rotating daily; the escort itself is simple.",
    requirements = "Deepholm story completed through the Therazane daily-quest unlock",
    cost = "No purchase", tips = "The daily is not guaranteed every day and the ten completions need not be consecutive. Use one character for the counter. Underground Economy held in your log can interfere with this daily's shared slot; finish or abandon it before checking.",
    steps = {
        "Enter Deepholm through your faction capital's Cataclysm portal. Finish the Temple of Earth and Earthen/Therazane story until Therazane's Throne offers daily quests. Being high level or Exalted does not replace the quest unlock on a new character.",
        "Check Pyrite at Therazane's Throne, around 57.3,12.5, for Lost In The Deeps. If it is absent, return after a daily reset. Accepting other dailies does not guarantee this specific one will appear.",
        "Enter the Crumbling Depths near 59.0,25.0. Follow behind the Colossal Gyreworm around the circular tunnel, avoiding its body, then take the exit into the large crystal chamber. Follow the right-hand passage and its left turn to Pebble's ledge near 63.2,20.8; talk to him.",
        "Escort him back along the tunnels on foot. Pause at corners and the low rock ramp so he follows; avoid jumping away or running far ahead. At the cave mouth wait for the rescue objective to complete before flying off. If lost, return for Pebble; leave and re-enter the cave if he does not reset.",
        "Turn in the daily to Pyrite. Repeat on available days until Rock Lover reaches 10/10, then check your Pet Journal and reward mail for Pebble. Learn any awarded pet item.",
    },
    waypoints = {
        pin(207, 57.3, 12.5, 2, "Pyrite / Therazane's Throne - rotating daily", "Deepholm"),
        pin(207, 59.0, 25.0, 3, "Crumbling Depths - cave entrance", "Deepholm"),
        pin(207, 63.2, 20.8, 3, "Pebble - underground ledge, follow tunnels", "Deepholm"),
        pin(207, 59.0, 25.0, 4, "Cave exit - wait for rescue credit", "Deepholm"),
        pin(207, 57.3, 12.5, 5, "Pyrite - turn in Lost In The Deeps", "Deepholm"),
    },
})

-- https://www.wowhead.com/item=64494#comments (Elftastic, 322202)
-- https://www.wowhead.com/quest=27048#comments (700064)
-- Keep the bomb route; discard historical disconnect/flying-through-caves tricks.
add(279, "Tiny Shale Spider", 64494, {
    category = "Rare Drops", source = "Jadefang - elevated cave inside Deepholm's Crumbling Depths", npcId = 49822,
    description = "Jadefang drops the companion when killed. Reaching her elevated tunnel and finding the rare alive are the obstacles.",
    difficulty = "hard", difficultyReason = "A rotating quest supplies the reliable access method, followed by an unpredictable rare-spawn wait.",
    requirements = "Therazane daily access for the Ricket's Tickers route; an eligible Jadefang kill",
    cost = "No purchase required; a caged pet is an alternative",
    tips = "The green spider is Jadefang, not the catchable Emerald Shale Hatchling. Hunter taming does not award the companion drop. Do not turn in Underground Economy until you have used its bombs to reach the ledge.",
    steps = {
        "Unlock Therazane dailies by progressing Deepholm's story. Enter the Crumbling Depths at 59.0,25.0 and look for Ricket inside near 56.0,14.2. On an Underground Economy day, accept the quest and keep its Ricket's Tickers.",
        "Pass the circling Colossal Gyreworm into the large central crystal chamber. Take the far-right tunnel and the first left to reach the overlook near Pebble. Locate the higher cave opening across the chamber; Jadefang is in its back near 61.2,22.6, underground.",
        "Aim toward Jadefang's opening, place a ticker, then stand between the bomb and your destination. Jump as it detonates so the knockback launches you into the elevated tunnel. Repeat and adjust your position if you miss; the quest item allows repeated attempts.",
        "Check the back of the tunnel for Jadefang. If absent, wait or return later; another player's recorded spawn time does not start a guaranteed timer for your phase. You may log out on the ledge to avoid repeating the jump.",
        "Kill Jadefang and loot Tiny Shale Spider, then use it. Finish Underground Economy when done with the bombs. If you prefer to bypass the spawn and access work, buy a caged Tiny Shale Spider from another player.",
    },
    waypoints = {
        pin(207, 59.0, 25.0, 1, "Crumbling Depths - cave entrance", "Deepholm"),
        pin(207, 56.0, 14.2, 1, "Ricket - UNDERGROUND, only on her daily day", "Deepholm"),
        pin(207, 63.2, 20.8, 2, "Pebble's overlook - bomb-jump approach underground", "Deepholm"),
        pin(207, 61.2, 22.6, 4, "Jadefang - elevated tunnel underground", "Deepholm"),
        pin(207, 61.2, 22.6, 5, "Jadefang - kill and loot the companion", "Deepholm"),
    },
})

-- https://www.wowhead.com/item=46325#comments
-- Bziuma and Woodymakespizza describe the Retail Horde route and Zidormi phase.
-- The older Alliance lists by sunsmoon / 718472 supply the quest dependencies.
-- Quest prerequisites and coordinates cross-checked against ATT's Retail Darkshore.lua.
add(220, "Withers", 46325, {
    category = "Quest Rewards", source = "Darkshore - Apothecary Furrows (Horde) or Remembrance of Auberdine (Alliance)",
    description = "A shrinking treant with two faction-specific acquisition routes. The Horde vendor is much quicker than the Alliance story.",
    difficulty = "medium", difficultyReason = "A simple Horde purchase; the Alliance route requires a substantial Darkshore quest chain.",
    requirements = "A character of the appropriate faction in Darkshore's pre-Battle for Azeroth phase",
    cost = "Horde: 50 silver before discounts; Alliance: quest reward",
    tips = "Use Zidormi if Darkshore shows the warfront. Withers cannot be caged, so a Horde purchase cannot be traded to a friend; learning it adds the species to your account.",
    steps = {
        "Travel to Darkshore. If you see the Battle for Azeroth battlefield, speak to Zidormi at 48.9,24.4 and choose the earlier Darkshore. Both routes below use that still-accessible Cataclysm version.",
        "Horde: enter Cliffspring Falls through the waterfall at 56.6,30.8. Follow the cave and take the left branch to Apothecary Furrows at about 57.3,33.9. Buy Withers for 50 silver and use the item. No Alliance quest chain is required.",
        "Alliance: begin in Lor'danel around 50.8,18.2 with The Last Wave of Survivors and The Boon of the Seas. Follow Wizbang's chain: Buzzbox 413, No Accounting for Taste, Buzzbox 723 and A Cure In The Dark. Enable trivial-quest tracking so these low-level quests remain visible.",
        "At Cliffspring Falls, complete The Corruption's Source and Bearer of Good Fortune. Inside the cave, inspect the Disgusting Workbench near 57.4,33.8 for A Troubling Prescription. Finish these follow-ups and return to Lor'danel for the newly available quests.",
        "Finish The Final Flame of Bashal'Aran and A Love Eternal, then follow A Lost Companion to Keeper Karithus near 43.0,39.0. Complete Twice Removed, Unsavory Remedies and Ritual Materials. Finish The Ritual Bond by choosing one animal spirit, then return with Grimclaw's Return.",
        "Take The Shatterspear Invaders from Ranger Glynda Nal'Shea and report to Morra at 58.9,19.4. Complete Shatterspear Laborers and Remnants of the Highborne, then Denying Manpower and War Supplies. Finish both On the Brink and Strategic Strikes to unlock The Front Line; doing just one leaves the next quest unavailable.",
        "Follow The Front Line to Huntress Sandrya Moonfall near 72.3,19.1. Accept Ending the Threat and tell her you are ready to attack; her assistance removes Jor'kil the Soulripper's protective shield. Kill him and loot Hellscream's Missive. Use the missive to start Disturbing Connections before leaving.",
        "Turn in Ending the Threat, then return to Ranger Glynda Nal'Shea in Lor'danel for Disturbing Connections. Find Cerellean Whiteclaw near 50.1,19.5 and complete Remembrance of Auberdine. Use the Withers reward; the missive quest is required for this final link.",
    },
    waypoints = {
        pin(62, 48.9, 24.4, 1, "Zidormi - select earlier Darkshore", "Darkshore"),
        pin(62, 56.6, 30.8, 2, "Cliffspring Falls - cave entrance behind waterfall", "Darkshore"),
        pin(62, 57.3, 33.9, 2, "Apothecary Furrows - inside the cave, Horde vendor", "Darkshore"),
        pin(62, 50.8, 18.2, 3, "Lor'danel - Alliance quest-chain hub", "Darkshore"),
        pin(62, 56.6, 30.8, 4, "Cliffspring Falls - Alliance corruption quests", "Darkshore"),
        pin(62, 57.4, 33.8, 4, "Disgusting Workbench - A Troubling Prescription, inside cave", "Darkshore"),
        pin(62, 43.0, 39.0, 5, "Keeper Karithus - ritual and Grimclaw quests", "Darkshore"),
        pin(62, 58.9, 19.4, 6, "Morra - Mathystra and Shatterspear prerequisites", "Darkshore"),
        pin(62, 72.3, 19.1, 7, "Huntress Sandrya Moonfall - begin the attack", "Darkshore"),
        pin(62, 50.1, 19.5, 8, "Cerellean Whiteclaw - Remembrance of Auberdine", "Darkshore"),
    },
})

-- https://www.wowhead.com/item=65661#comments
-- https://www.wowhead.com/item=65662#comments
-- Faedeyssara corrects the launch-era claim that only one colour is obtainable.
-- https://www.wowhead.com/achievement=5860
-- /quest=25560 and /quest=25810: Egg Wave and The Hatchery Must Burn.
for _, pet in ipairs({ {259, "Blue Mini Jouster", 65661}, {260, "Gold Mini Jouster", 65662} }) do
    local speciesID, name, itemID = unpack(pet)
    add(speciesID, name, itemID, {
        category = "Quest Rewards", source = "Egg Wave; the other colour from The 'Unbeatable?' Pterodactyl: BEATEN.",
        description = "One jouster colour is a story reward. Ten completions of Vigilance on Wings unlock the other colour.",
        difficulty = "medium", difficultyReason = "The first colour is a quest reward, but the second needs ten daily completions.",
        requirements = "Mount Hyjal story access to the Hatchery and its jousting quests",
        cost = "No purchase required", sourceAchievementId = 5860,
        tips = "The Hatchery portal is at 38.8,58.6, not the Sanctuary of Malorne. These pets cannot be caged. Old comments saying that the other colour is permanently unavailable predate the achievement reward.",
        steps = {
            "Follow Mount Hyjal's story into the Shrine of Aviana branch near 44.3,47.9. Complete its egg and Sethria quests through Return to the Shrine and An Ancient Reborn. Take The Hatchery Must Burn, which sends you through the flamegate near 38.8,58.6 to Farden Talonshrike.",
            "Enter the flamegate. For Flight in the Firelands, take and equip a Twilight Firelance from the rack behind Farden, mount an Aviana's Guardian and use Flap to reach the marked flag. Finish Wave One and Wave Two by flying into the required enemies while maintaining height and avoiding hazards. For Egg Wave, run the mount over 40 eggs on the ledges, then return to Farden.",
            "If this character has not chosen a reward yet, select " .. name .. " from Egg Wave and learn it. The quest offers a choice of colours; it does not award both at once.",
            "If you chose the other colour, return to Farden for Vigilance on Wings whenever available. Complete and turn in that daily ten times on the character progressing The 'Unbeatable?' Pterodactyl: BEATEN.; they do not have to be consecutive days.",
            "After the tenth completion, open the achievement's Chirping Box reward and learn the missing colour. Check your mail and Pet Journal before repeating the story on another character.",
        },
        waypoints = {
            pin(198, 44.3, 47.9, 1, "Shrine of Aviana - prerequisite story branch", "Mount Hyjal"),
            pin(198, 38.8, 58.6, 2, "Hatchery portal - Farden's jousting chain inside", "Mount Hyjal"),
            pin(198, 38.8, 58.6, 4, "Hatchery portal - Vigilance on Wings daily inside", "Mount Hyjal"),
        },
    })
end

-- https://www.wowhead.com/item=59597#comments (279627, Pipebomb3000)
-- https://www.wowhead.com/item=60216#comments (279627, 62980, Guy19)
-- Current recipe records: /spell=84412 and /spell=84413. Old 475 = Cataclysm 25.
-- Current specialization quests: /quest=29475 (Goblin), /quest=29477 (Gnomish).
for _, pet in ipairs({
    {261, "Personal World Destroyer", 59597, "Goblin", "10 Obsidium Bars, 8 Handfuls of Obsidium Bolts and 8 Electrified Ether", "Blacksmith Hammer"},
    {262, "De-Weaponized Mechanical Companion", 60216, "Gnomish", "12 Obsidium Bars, 4 Handfuls of Obsidium Bolts, 8 Electrified Ether and 2 Jasper", "Arclight Spanner"},
}) do
    local speciesID, name, itemID, branch, materials, tool = unpack(pet)
    local specializationMaterials = branch == "Goblin"
        and "20 Big Iron Bombs, 20 Solid Dynamite and 5 Explosive Sheep"
        or "6 Mithril Tubes, 1 Accurate Scope and 2 Advanced Target Dummies"
    add(speciesID, name, itemID, {
        category = "Professions", source = branch .. " Engineering - Cataclysm Engineering (25), or another player",
        description = "A tradeable mechanical pet. Engineering is needed to craft it, but anyone can learn the finished pet.",
        difficulty = "medium", difficultyReason = "Crafting needs Engineering progression, a specialization and materials; a player purchase bypasses that work.",
        requirements = "Crafting: Cataclysm Engineering 25 and " .. branch .. " Engineering; initial specialization: Classic Engineering 200; learning: no profession",
        cost = materials .. "; specialization samples if needed; alternatively a player-set Auction House price",
        tips = "Goblin/Gnomish refers to the Engineering specialization, not your race or faction. Enable trivial-quest tracking when taking the specialization quest. Buying or commissioning the finished pet avoids changing your own specialization.",
        steps = {
            "Choose a route: buy " .. name .. " as an unused item or caged battle pet from another player, or craft it. Learn a purchased cage at its displayed pet-level requirement; no Engineering is needed for collection.",
            "For crafting, visit Lilliam Sparkspindle in Stormwind at 62.8,32.0 or Roxxik in Orgrimmar at 56.8,56.4. Learn Engineering and Cataclysm Engineering, then reach Cataclysm skill 25. If you lack the specialization, also raise the separate Classic Engineering skill to 200; Cataclysm skill does not replace that requirement.",
            "If not already a " .. branch .. " Engineer, take " .. branch .. " Engineering from the capital trainer on an eligible level 20+ character. Craft or buy " .. specializationMaterials .. " and hand them in to unlock the specialization. Return to the trainer's recipe list and learn " .. name .. ". An existing specialist can craft it for you instead.",
            "Gather " .. materials .. ". Bolts are crafted from Obsidium Bars and Electrified Ether from Volatile Air. Bring the High-Powered Bolt Gun and " .. tool .. " tools required by the recipe, or valid replacements for those tools.",
            "At an anvil, craft " .. name .. " and use the finished item. A specialist can also craft it for you from your materials, avoiding the need to level or change your own profession.",
        },
        waypoints = {
            pin(84, 62.8, 32.0, 2, "Lilliam Sparkspindle - Engineering training", "Stormwind City"),
            pin(85, 56.8, 56.4, 2, "Roxxik - Engineering training", "Orgrimmar"),
            pin(84, 62.8, 32.0, 3, "Lilliam - specialization quest and pet recipe", "Stormwind City"),
            pin(85, 56.8, 56.4, 3, "Roxxik - specialization quest and pet recipe", "Orgrimmar"),
        },
    })
end

-- https://www.wowhead.com/item=67274#comments
-- https://www.wowhead.com/item=67275#comments
-- Formula tooltips /item=67308 and /item=67312 resolve the faction and materials.
for _, pet in ipairs({
    {267, "Enchanted Lantern", 67274, "Horde", 67308, "8 Hypnotic Dust", 85, 53.5, 48.9, "Kithas - Enchanting Supplies", "Orgrimmar"},
    {292, "Magic Lamp", 67275, "Alliance", 67312, "4 Greater Celestial Essence", 84, 53.0, 74.3, "Jessara Cordell - Enchanting Supplies", "Stormwind City"},
}) do
    local speciesID, name, itemID, faction, formulaID, extra, mapID, x, y, vendor, mapName = unpack(pet)
    add(speciesID, name, itemID, {
        category = "Professions", source = faction .. " Cataclysm Enchanting (75), or a tradeable crafted pet",
        description = "The recipe is faction-specific; the finished pet can be learned by either faction.",
        difficulty = "medium", difficultyReason = "Self-crafting needs Cataclysm Enchanting 75 and materials; buying the pet is straightforward.",
        requirements = "Crafting: " .. faction .. " Enchanter with Cataclysm Enchanting 75; learning: either faction, no profession",
        cost = "Formula: 20 Hypnotic Dust; craft: 8 Heavenly Shards, 1 Maelstrom Crystal and " .. extra,
        tips = "Enchanting supply vendors sell the formula, not the finished companion. The old guild-vendor markers were unrelated to these pets. You can buy the crafted item or cage through the normal Auction House.",
        steps = {
            "For the shortest route, compare the unused " .. name .. " item and caged " .. name .. " listings on the Auction House. Buy and learn one; neither faction nor Enchanting restricts learning the finished pet.",
            "To make it yourself, use a " .. faction .. " character and train Cataclysm Enchanting to 75. Bring 20 Hypnotic Dust to " .. vendor .. " at " .. x .. "," .. y .. " in " .. mapName .. " and buy Formula: " .. name .. ".",
            "Learn the formula, then gather 8 Heavenly Shards, 1 Maelstrom Crystal and " .. extra .. ". The dust paid for the formula is separate from the crafting reagents.",
            "Craft " .. name .. " from the Cataclysm Enchanting recipe list and use it. Alternatively, give the materials to an eligible enchanter and have them trade you the finished pet.",
        },
        waypoints = { pin(mapID, x, y, 2, vendor .. " - buy formula " .. formulaID, mapName) },
    })
end

-- https://www.wowhead.com/item=63138#comments and /npc=47944#comments
-- https://www.wowhead.com/item=63398#comments (neiljwd, 505142)
-- https://www.wowhead.com/item=71033#comments (1341154, Avante)
-- Armadillo's lower requirement is confirmed by Blizzard's 4.0.6 patch notes.
-- Vendor locations: /npc=46602 (Shay, Visitor's Center), /npc=46572 (Goram).
-- Standing gates cross-checked with ATT's current Retail 11 - Character/Guild.lua.
for _, pet in ipairs({
    {270, "Dark Phoenix Hatchling", 63138, "United Nations", "Exalted", 300,
        "Check that your guild has United Nations completed. Joining a guild with this unlock is sufficient; you do not need to personally rebuild its entire reputation collection.",
        "If needed, track United Nations in the Guild Achievements panel: the guild needs 55 different eligible Exalted reputations from its listed criteria. Different members can supply different factions, but contributing characters must also be Exalted with the guild. Duplicate reputations count once. Check the actual criteria; personal reputation totals and friendships are not interchangeable with this list."},
    {272, "Armadillo Pup", 63398, "Critter Kill Squad", "Revered", 300,
        "Check your guild's Critter Kill Squad progress. The unlock is 50,000 critter kills by the guild, not 50,000 kills required from each buyer. A guild that already earned it lets you skip that grind.",
        "If needed, help the guild kill critters. The cave just inside western Eastern Plaguelands at 4.2,36.1 has dense small creatures; sweep it with area attacks and let them respawn. Watch the guild counter rather than assuming a party multiplies every kill."},
    {320, "Lil' Tarecgosa", 71033, "Dragonwrath, Tarecgosa's Rest - Guild Edition", "Exalted", 1500,
        "Join or remain in a guild that has Dragonwrath, Tarecgosa's Rest - Guild Edition. Open the Guild Achievements panel and verify the completed unlock before investing in reputation. Merely seeing a member with a dragon pet is not proof.",
        "If the guild lacks the unlock, an eligible caster must complete the Dragonwrath legendary staff storyline and satisfy the guild achievement. This involves repeated Firelands runs; it is not a requirement for every pet buyer. Joining an already-qualified guild is the direct collection route."},
}) do
    local speciesID, name, itemID, achievement, standing, price, unlock, help = unpack(pet)
    local steps = {
        unlock,
        help,
        "On the character making the purchase, reach " .. standing .. " reputation with that guild by completing reputation-awarding quests and eligible guild activities. Guild tabards can increase gains. Check the Guild faction in your reputation panel; city reputation does not replace it.",
        "Visit Shay Pressler inside Stormwind's Visitor's Center at 64.6,76.8 (Alliance) or Goram at 48.2,75.6 in Orgrimmar (Horde). Set the vendor filter to All if the pet is hidden. Buy " .. name .. " for " .. price .. " gold and use the item.",
    }
    add(speciesID, name, itemID, {
        category = "Guild Achievements", source = achievement .. " - guild vendor purchase",
        description = "The guild unlock and the buyer's guild reputation are separate requirements. An already-qualified guild provides the quickest route.",
        difficulty = "medium", difficultyReason = "Guild access and personal reputation take time; creating the guild unlock from scratch can be much harder.",
        requirements = "Guild achievement: " .. achievement .. "; buyer route: " .. standing .. " guild reputation",
        cost = price .. " gold; use the vendor's displayed price",
        tips = speciesID == 272 and "Revered is sufficient for Armadillo Pup; launch-era Exalted instructions were changed in patch 4.0.6. This guild reward can be purchased from either faction's appropriate vendor."
            or speciesID == 320 and "Buy only one: Lil' Tarecgosa has an account collection limit of one. It is not a random Firelands boss drop, and each alt does not need to buy its own."
            or "United Nations unlocks the purchase for the guild; Exalted reputation with that guild is a separate buyer requirement. This is the small companion, not the Dark Phoenix mount from Guild Glory of the Cataclysm Raider.",
        steps = steps,
        waypoints = {
            pin(84, 64.6, 76.8, 4, "Shay Pressler - inside Visitor's Center, Alliance", "Stormwind City"),
            pin(85, 48.2, 75.6, 4, "Goram - Horde guild vendor", "Orgrimmar"),
        },
    })
    if speciesID == 272 then
        guides[speciesID].waypoints[#guides[speciesID].waypoints + 1] = pin(23, 4.2, 36.1, 2, "Critter cave - optional guild-achievement farm", "Eastern Plaguelands")
    end
end

-- Item comments /item=65361, /item=65362, /item=65363, /item=65364.
-- Moof2 and Fyuriagosa explain apparently missing pages and guild-faction gates.
-- Notaturnip, 1131787 and SirKainey distinguish these from account-wide battle pets.
for _, pet in ipairs({
    {280, "Alliance Guild Page", 65361, "Alliance", "Page", "Horde Slayer", "Honored", 300, 84, 64.6, 76.8, "Shay Pressler", "Stormwind City"},
    {281, "Horde Guild Page", 65362, "Horde", "Page", "Alliance Slayer", "Honored", 300, 85, 48.2, 75.6, "Goram", "Orgrimmar"},
    {282, "Alliance Guild Herald", 65363, "Alliance", "Herald", "Profit Sharing", "Revered", 500, 84, 64.6, 76.8, "Shay Pressler", "Stormwind City"},
    {283, "Horde Guild Herald", 65364, "Horde", "Herald", "Profit Sharing", "Revered", 500, 85, 48.2, 75.6, "Goram", "Orgrimmar"},
}) do
    local speciesID, name, itemID, faction, role, achievement, standing, price, mapID, x, y, vendor, mapName = unpack(pet)
    local unlock = role == "Page"
        and "If that achievement is unfinished, track its missing opposing-faction race/class kills and complete them with your guild, for example in battlegrounds. Check the guild's current criteria rather than an old list; joining a guild with the completed unlock avoids this work."
        or "If Profit Sharing is unfinished, guild members must loot a combined 100,000 gold from creatures. Vendor sales, Auction House income and depositing gold in the guild bank are different activities. Joining an already-qualified guild avoids waiting for this total."
    add(speciesID, name, itemID, {
        category = "Guild Achievements", source = faction .. " guild vendor after " .. achievement,
        description = "A character-specific companion that provides temporary guild-vendor access. It cannot participate in pet battles.",
        faction = faction:lower(), difficulty = "medium", difficultyReason = "The correct guild unlock and the buying character's guild reputation are required.",
        requirements = faction .. " character; appropriate guild unlock " .. achievement .. "; " .. standing .. " guild reputation",
        cost = price .. " gold", tips = "Buy and learn this on the character that will use it. It is not an ordinary cageable, account-wide battle pet. Changing guilds or transferring can affect access; verify the unlock in the new guild before repurchasing.",
        steps = {
            "Use a " .. faction .. " character and check that its guild has " .. achievement .. ". For a Page, use a guild of the matching faction: a character joining a cross-faction guild does not automatically gain the other faction's Slayer unlock.",
            unlock,
            "Earn " .. standing .. " reputation with that guild on the buying character through reputation-awarding quests and eligible guild activities. Check your personal Guild reputation; another member's standing does not satisfy it.",
            "Visit " .. vendor .. " at " .. x .. "," .. y .. " in " .. mapName .. ". Choose All in the vendor filter, buy Guild " .. role .. " for " .. price .. " gold and use it on this character. Summon it from the Pet Journal while meeting its guild-use requirements.",
        },
        waypoints = { pin(mapID, x, y, 4, vendor .. " - buy Guild " .. role, mapName) },
    })
end

-- https://www.wowhead.com/item=64996#comments (709104)
-- https://www.wowhead.com/item=64403#comments (JangoD00D, ThatTamiCat, 2shoulderdevils)
-- /npc=47328, /npc=48531 identify the Peninsula vendors, not Baradin Hold.
add(271, "Rustberg Gull", 64996, {
    category = "Vendor", source = "Tol Barad Peninsula - Quartermaster Brazie (Alliance) or Pogg (Horde)",
    description = "A reputation purchase from the Peninsula camps. The pet is not obtained inside Baradin Hold.",
    difficulty = "medium", difficultyReason = "Honored reputation and daily-quest currency require several visits.",
    requirements = "Honored with Baradin's Wardens (Alliance) or Hellscream's Reach (Horde)",
    cost = "50 Tol Barad Commendations", tips = "Peninsula dailies are available independently of owning the southern PvP island. Do not spend your pet currency on reputation commendation tokens unless you deliberately choose that tradeoff.",
    steps = {
        "Take the Tol Barad portal from your faction capital's Cataclysm portal area. Arrive on Tol Barad Peninsula, map 245; the southern battle island is a separate map.",
        "Alliance: pick up dailies at Baradin Base Camp near 73,61. Horde: use Hellscream's Grasp near 55,80. Complete and turn in the offered quests for reputation and Tol Barad Commendations. Repeat after daily resets until Honored and at least 50 commendations.",
        "Return to Quartermaster Brazie at 72.4,63.1 (Alliance) or Pogg at 54.6,81.1 (Horde). Buy Rustberg Gull for 50 commendations. Use your faction's version; both teach the same species.",
        "Learn the item. Alternatively, buy a caged Rustberg Gull from another player if you want to bypass the reputation and currency route; check the cage's learning requirement before purchase.",
    },
    waypoints = {
        pin(245, 72.4, 63.1, 2, "Baradin Base Camp - Alliance daily hub", "Tol Barad Peninsula"),
        pin(245, 54.6, 81.1, 2, "Hellscream's Grasp - Horde daily hub", "Tol Barad Peninsula"),
        pin(245, 72.4, 63.1, 3, "Quartermaster Brazie - Alliance gull vendor", "Tol Barad Peninsula"),
        pin(245, 54.6, 81.1, 3, "Pogg - Horde gull vendor", "Tol Barad Peninsula"),
    },
})

add(278, "Fox Kit", 64403, {
    category = "Rare Drops", source = "Baradin Foxes; alternatively Tol Barad Peninsula's Exalted vendor", npcId = 47676,
    description = "Choose a rare fox drop, a deterministic reputation purchase, or a player-sold cage.",
    difficulty = "medium", difficultyReason = "The vendor route takes daily progression; the optional drop farm is substantially less predictable.",
    requirements = "Drop route: no reputation; vendor route: Exalted with your Tol Barad faction",
    cost = "Drop: no purchase; vendor: 200 Tol Barad Commendations; cage: player-set gold price",
    tips = "Kill Baradin Fox NPCs, not the small battle-pet critters. Reputation and control of the PvP island are not requirements for the fox drop. The original item is soulbound, but the learned pet can be caged.",
    steps = {
        "Travel to Tol Barad Peninsula through the capital portal. Choose between farming Baradin Foxes, earning 200 commendations and Exalted reputation through your faction's dailies, or buying a cage.",
        "For the drop route, kill and loot Baradin Foxes around the Peninsula. Follow the marked circuit from the eastern camp through the southern woods and western coast, then back through the northern paths. These are patrol/search positions; some foxes wander away from the exact pin.",
        "Repeat the circuit, killing foxes encountered while doing dailies. The drop is very rare, with no guaranteed kill count. Loot each fox before moving on; the small capturable fox critters do not drop the item.",
        "For a guaranteed purchase instead, reach Exalted with Baradin's Wardens or Hellscream's Reach, save 200 Tol Barad Commendations, and buy Fox Kit from Quartermaster Brazie at 72.4,63.1 or Pogg at 54.6,81.1.",
        "Use the Fox Kit item, or learn a purchased cage. One learned species is enough for your account; separate Horde and Alliance purchases are unnecessary.",
    },
    waypoints = {
        pin(245, 71.0, 60.5, 2, "Baradin Fox - eastern circuit search", "Tol Barad Peninsula"),
        pin(245, 67.5, 66.2, 2, "Baradin Fox - southeast circuit search", "Tol Barad Peninsula"),
        pin(245, 67.6, 76.5, 2, "Baradin Fox - southeast woods", "Tol Barad Peninsula"),
        pin(245, 57.2, 72.4, 2, "Baradin Fox - southern circuit", "Tol Barad Peninsula"),
        pin(245, 49.3, 75.2, 2, "Baradin Fox - southwest circuit", "Tol Barad Peninsula"),
        pin(245, 50.5, 67.6, 2, "Baradin Fox - Darkwood approach", "Tol Barad Peninsula"),
        pin(245, 40.5, 54.6, 2, "Baradin Fox - western circuit", "Tol Barad Peninsula"),
        pin(245, 35.9, 55.8, 2, "Baradin Fox - western coast", "Tol Barad Peninsula"),
        pin(245, 33.3, 58.6, 2, "Baradin Fox - western coast south", "Tol Barad Peninsula"),
        pin(245, 33.6, 43.0, 2, "Baradin Fox - northwest circuit", "Tol Barad Peninsula"),
        pin(245, 32.0, 47.4, 2, "Baradin Fox - northwest coast", "Tol Barad Peninsula"),
        pin(245, 47.3, 42.5, 2, "Baradin Fox - northern paths", "Tol Barad Peninsula"),
        pin(245, 48.1, 36.7, 2, "Baradin Fox - north circuit", "Tol Barad Peninsula"),
        pin(245, 51.6, 39.6, 2, "Baradin Fox - north return", "Tol Barad Peninsula"),
        pin(245, 49.3, 46.9, 2, "Baradin Fox - central return", "Tol Barad Peninsula"),
        pin(245, 72.4, 63.1, 4, "Quartermaster Brazie - 200 commendations at Exalted", "Tol Barad Peninsula"),
        pin(245, 54.6, 81.1, 4, "Pogg - 200 commendations at Exalted", "Tol Barad Peninsula"),
    },
})

-- https://www.wowhead.com/item=66076#comments (Hashupa, Omodis, NoSmoking, Phote)
-- https://www.wowhead.com/quest=27555
add(286, "Mr. Grubbs", 66076, {
    category = "Rare Drops", source = "Hidden Stash - Eastern Plaguelands with Fiona's Lucky Charm active",
    description = "A chance reward inside a chance-dropped bag. Fiona's buff enables the bags; ordinary grub kills alone do not.",
    difficulty = "medium", difficultyReason = "A short quest unlock followed by two layers of random loot.",
    requirements = "Fiona's Lucky Charm active while looting Eastern Plaguelands enemies",
    cost = "No purchase required", tips = "You do not need to recruit the entire caravan or finish the zone. Farm Hidden Stash, not Scum Covered Bags. Many eligible enemy types can drop stashes, not just carrion grubs. Recheck the buff after leaving the zone.",
    steps = {
        "Find Fiona at the western entrance to Eastern Plaguelands, 9.0,66.4. Complete her Gidwin Goldbraids and Tarenar Sunstrike branches, including the quests each missing paladin gives before returning to the caravan.",
        "Interact with Fiona's Caravan and choose Fiona's Lucky Charm. Confirm the buff is on your character before farming. If the caravan has already moved in your story, use its current stop; the western start is for a fresh character.",
        "Kill and loot enemies at Corin's Crossing around 54,61 or the trolls and disturbed graves of Zul'Mashar around 63,18. Open every Hidden Stash you receive. These are alternative farming areas on the same zone map, not sequential quest requirements.",
        "Repeat while the charm is active until a stash contains Mr. Grubbs, then use the item. Neither the bag nor its pet is guaranteed on a particular kill. A caged Mr. Grubbs from another player bypasses the unlock and farm.",
    },
    waypoints = {
        pin(23, 9.0, 66.4, 1, "Fiona - fresh-character caravan quests", "Eastern Plaguelands"),
        pin(23, 9.0, 66.4, 2, "Fiona's Caravan - choose Lucky Charm before it moves", "Eastern Plaguelands"),
        pin(23, 54.0, 61.0, 3, "Corin's Crossing - Hidden Stash farm option", "Eastern Plaguelands"),
        pin(23, 63.0, 18.0, 3, "Zul'Mashar - alternative trolls/graves farm", "Eastern Plaguelands"),
    },
})

-- https://www.wowhead.com/item=66080#comments (xemega, 310680, 778392)
-- https://www.wowhead.com/quest=28415#comments (wharris, lisaroxy)
-- Horde ending: /quest=28491. Alliance ends with Oralius, not Kibler.
add(287, "Tiny Flamefly", 66080, {
    category = "Quest Rewards", source = "Burning Steppes - SEVEN! YUP! (Alliance) / Not Fireflies, Flameflies (Horde)",
    description = "A guaranteed reward after the Flamestar Post and Chiselgrip infiltration story, with a different final hub for each faction.",
    difficulty = "medium", difficultyReason = "A long, branching quest chain with disguise and automatic follow-ups, but no random drop.",
    requirements = "Burning Steppes quest progression on one character",
    cost = "No purchase", tips = "Enable trivial-quest tracking. Starting at Abuse of Power skips required earlier work. Keep the disguise item and check your quest log for automatic follow-ups; if an NPC rejects your disguise, remove its old buff and reapply it.",
    steps = {
        "Start at Flamestar Post near 17.3,51.5 in Burning Steppes. Work with Mouton Flamestar and John J. Keeshan (Alliance) or Ariok (Horde): Done Nothing Wrong, Burning Vengeance, Stocking Up, A Future Project and Mud Hunter.",
        "Continue The Sand, the Cider, and the Orb to Gorzeeki Wildeyes near 8.3,35.9. Finish Warlocks Have the Neatest Stuff and Shadow Boxing, return to your faction contact, then follow Chiselgrip, the Heart of the Steppes.",
        "At Chiselgrip around 46,44, complete Stebben's Prove Yer Allegiance, Scrapped Golems and Golem Training. Continue the main infiltration chain through A Needle in a Hellhole, A Perfect Costume and Into the Black Tooth Hovel.",
        "While disguised, finish Strategic Cuts, Grunt Work, The Kodocaller's Horn and Taking the Horn for Ourselves. Continue General Thorg'izog and Trial by Magma. Accept the automatic Abuse of Power follow-up and finish Enough Damage for One Day.",
        "Alliance: follow Morgan's Vigil to Oralius at 71.8,67.9 and accept SEVEN! YUP!. Horde: follow Flame Crest to Kibler at 54.9,22.5 and accept Not Fireflies, Flameflies. Dismiss critter-eating companions before collecting seven nearby sparkling Flameflies by clicking them.",
        "Turn in to your faction's quest giver, take Tiny Flamefly and learn it. This companion cannot be caged. A low Booty Bay reputation can prevent Horde interaction with Kibler; use a character without that hostility or repair its reputation.",
    },
    waypoints = {
        pin(36, 17.3, 51.5, 1, "Flamestar Post - begin the faction story", "Burning Steppes"),
        pin(36, 8.3, 35.9, 2, "Gorzeeki Wildeyes - orb and warlock quests", "Burning Steppes"),
        pin(36, 46.0, 44.0, 3, "Chiselgrip - disguise and golem prerequisites", "Burning Steppes"),
        pin(36, 30.7, 33.8, 4, "General Thorg'izog - Trial by Magma", "Burning Steppes"),
        pin(36, 71.8, 67.9, 5, "Oralius - Alliance SEVEN! YUP!", "Burning Steppes"),
        pin(36, 54.9, 22.5, 5, "Kibler - Horde Not Fireflies, Flameflies", "Burning Steppes"),
        pin(36, 71.8, 67.9, 6, "Oralius - Alliance pet reward", "Burning Steppes"),
        pin(36, 54.9, 22.5, 6, "Kibler - Horde pet reward", "Burning Steppes"),
    },
})

-- https://www.wowhead.com/item=66067#comments (artyfarty, 487521, Greyblade)
-- The numbered 'How to smile' profit joke assumes ownership; it is not acquisition.
-- https://www.wowhead.com/quest=28748#comments (NoSmoking, 597390)
add(291, "Singing Sunflower", 66067, {
    category = "Quest Rewards", source = "Lawn of the Dead - Brazie the Botanist in Hillsbrad Foothills",
    description = "Complete Brazie's five garden-defense quests. Your character's combat gear does not replace the minigame strategy.",
    difficulty = "medium", difficultyReason = "The final garden-defense waves require resource management and timely rebuilding.",
    requirements = "Access to Brazie's Farmstead; both factions can complete the chain",
    cost = "No purchase", tips = "Collect sunpower by clicking its glowing pickups. Protect every horizontal lane, use the left side for income plants, and leave the far-right enemy-entry column open to avoid reported stalled waves.",
    steps = {
        "Visit Brazie the Botanist at 33.6,49.5 in Hillsbrad Foothills, south of the Dalaran Crater. Finish Basic Botany, Flower Power, Ghouls Hate My Grains and Someone Setup the Pumpkin Bomb, then accept Lawn of the Dead.",
        "Start each round by collecting sunpower and planting Sunflowers in the leftmost column. Add Spitters in lanes with approaching enemies, using Rocknuts ahead of them to buy time. Expand toward two Sunflower columns without leaving an attacked lane undefended.",
        "Build damage and slowing plants in front of the Sunflowers: Spitters, Freezyas and, once available, Strangler Vines. Replace damaged front plants as cooldowns allow. Vines can reach nearby lanes; they do not need to occupy the enemy-entry squares.",
        "During the final fight, save enough sunpower for Pumpkin Bombs and replacement Sunflowers. Bomb Warden Stillwater and clustered tough enemies when the bomb is ready. Rebuild plants destroyed by his attacks so both income and lane defenses continue.",
        "Survive until the objective completes, turn in Lawn of the Dead to Brazie, and use Brazie's Sunflower Seeds. Search the journal for Singing Sunflower. You do not need an unavailable endless-mode achievement for the pet.",
    },
    waypoints = {
        pin(25, 33.6, 49.5, 1, "Brazie the Botanist - garden-defense chain", "Hillsbrad Foothills"),
        pin(25, 33.6, 49.5, 5, "Brazie - turn in Lawn of the Dead", "Hillsbrad Foothills"),
    },
})

-- https://www.wowhead.com/item=68833#comments (Rocsanna, Katerra, mapleshosho)
-- Retain the useful original Mauti-chain advice; the entire ZG introduction is not needed.
add(301, "Panther Cub", 68833, {
    category = "Quest Rewards", source = "Some Good Will Come - Bwemba and the injured hunter in Northern Stranglethorn",
    description = "A short outdoor storyline ends at the hunter's cave. No Zul'Gurub dungeon clear is needed.",
    difficulty = "easy", difficultyReason = "A guaranteed reward from a short, sequential outdoor quest chain.",
    requirements = "The faction's Bwemba introduction and Northern Stranglethorn follow-ups",
    cost = "No purchase", tips = "Keep Bwemba's Spirit in your log while following the pet branch, but you need not finish the entire introduction to receive the cub. Accept Follow That Cat before killing Mauti; the cave and the final cub reward are distinct interactions.",
    steps = {
        "Find Bwemba in Stormwind Harbor near 26.0,29.6 (Alliance) or near the Orgrimmar Embassy at 32.6,68.2 (Horde). Take Bwemba's Spirit and To Fort Livingston or To Bambala respectively.",
        "At the marked faction hub in Northern Stranglethorn, complete Serpents and Poison and Spirits Are With Us. Continue Nesingwary Will Know to Nesingwary's Expedition, then Track the Tracker and The Hunter's Revenge.",
        "Accept Follow That Cat and follow the flares to the cave near 77.1,69.1. Enter the cave to advance the quest, accept Mauti, then kill the panther outside. Remain nearby for the spirit scene and its quest completion.",
        "Return inside for How's the Hunter Holding Up? and Bury Me With Me Boots.... Collect the sparkling boots beside the injured hunter. Finish Some Good Will Come with the cub near 76.1,66.7 and learn the Panther Cub reward.",
    },
    waypoints = {
        pin(84, 26.0, 29.6, 1, "Bwemba - Alliance introduction", "Stormwind City"),
        pin(85, 32.6, 68.2, 1, "Bwemba - Horde introduction", "Orgrimmar"),
        pin(50, 53.2, 66.0, 2, "Fort Livingston - Alliance story hub", "Northern Stranglethorn"),
        pin(50, 64.7, 40.2, 2, "Bambala - Horde story hub", "Northern Stranglethorn"),
        pin(50, 44.0, 22.7, 2, "Nesingwary's Expedition - Track the Tracker", "Northern Stranglethorn"),
        pin(50, 77.1, 69.1, 3, "Hunter's cave - accept Mauti before killing the cat", "Northern Stranglethorn"),
        pin(50, 76.1, 66.7, 4, "Some Good Will Come - Panther Cub quest reward", "Northern Stranglethorn"),
    },
})

-- https://www.wowhead.com/item=69251#comments (Glowyrm; Alliance credit Madwolf)
-- https://www.wowhead.com/quest=29208#comments (654830, newmanfancypants, Glowyrm)
-- /quest=26775 and /quest=26362: Be Raptor checkpoints, bridges and final dialogue.
add(307, "Lashtail Hatchling", 69251, {
    category = "Quest Rewards", source = "An Old Friend - after the Northern Stranglethorn hatchling story and Bloodlord Mandokir", npcId = 52877,
    description = "Raise the quest hatchling, finish the raptor-vision story, then rescue her after a fresh Zul'Gurub boss kill.",
    difficulty = "medium", difficultyReason = "Multiple outdoor quest branches must be finished before the Heroic dungeon rescue appears.",
    requirements = "The hatchling quest chain completed on the character killing Mandokir; access to Heroic Zul'Gurub",
    cost = "No purchase", tips = "The quest raptor and permanent pet are different. Complete the outdoor prerequisites before killing Mandokir for the simplest route. If Bwemba's story phases the Rebel Camp, finish that introduction. Stable-master sales reported in current comments require a previous unlock; they do not replace the first rescue.",
    steps = {
        "Alliance: start Bad Medicine with Brother Nimetz at the Rebel Camp, 47.2,10.8. Loot the remedies to receive the Lashtail Raptor Egg Fragment and Just Hatched; return to Corporal Sethman. Horde: start The Defense of Grom'gol: Raptor Risk at Grom'gol, 38.4,50.5; breaking the eggs starts A Lashtail Hatchling for Far Seer Mok'thardin.",
        "Use the quest hatchling for I Think She's Hungry: feed it from slain basilisks (Alliance) or murlocs (Horde). Alliance must also finish The Fate of Kurzen and Spared from Madness. Keep space in your bags for the egg fragment.",
        "Bring the summoned hatchling to the skull pile at Bal'lal Ruins, 33.7,37.2. Accept Favored Skull and return to Osborn Obnoticus at the Rebel Camp or Nimboya in Grom'gol. Continue A Nose for This Sort of Thing, then A Physical Specimen (Alliance) or Who's a Big Troll? and Skullsplitter Mojo (Horde).",
        "Complete Bloodlord Mandokir when he takes the hatchling. Follow your priestess referral: Thaalia at Fort Livingston (Alliance), Hu'rala at Bambala (Horde). Finish Mind Vision, See Raptor and Mind Control, then accept Be Raptor. Speak to the priestess to start its ritual; entering the dungeon yourself does not start the vision.",
        "During Be Raptor, speak to each friendly raptor to save progress and learn its ability. Avoid patrols with Dash; feed the hungry raptor with the sleeping troll's food. Take fire from braziers and burn tikis to draw guards away. At each bridge, place a skull in the bridge guard's path while he is walking away, retreat, and wait for him to trip off the bridge before crossing. Avoid the three-troll patrols between bridges.",
        "Burn the last tiki, pass the distracted guards and stop on the first stair landing for the final conversation. Being caught in that scripted scene is the intended ending; running beyond it can reset you. Wait for quest credit, return to the priestess and finish Be Raptor, then Ghaliri (Alliance) or Surkhan (Horde).",
        "Set dungeon difficulty to Heroic. Approach Zul'Gurub's outer gate near 67.5,32.9 in Northern Stranglethorn and continue east to the instance portal near 72.1,32.9. Inside, follow the southeastern route to Bloodlord Mandokir's arena. Defeat him on this same character; high-level Retail characters can solo the legacy dungeon.",
        "Look for the tiny chained hatchling at the back of Mandokir's arena, using the quest marker on the minimap. Accept and complete An Old Friend, then learn Lashtail Hatchling. If absent, revisit the outdoor chain's final turn-in before trying a fresh eligible kill.",
    },
    waypoints = {
        pin(50, 47.2, 10.8, 1, "Rebel Camp - Alliance hatchling chain", "Northern Stranglethorn"),
        pin(50, 38.4, 50.5, 1, "Grom'gol - Horde hatchling chain", "Northern Stranglethorn"),
        pin(50, 33.7, 37.2, 3, "Bal'lal Ruins - quest hatchling finds Favored Skull", "Northern Stranglethorn"),
        pin(50, 53.2, 66.0, 4, "Fort Livingston - Priestess Thaalia, Alliance", "Northern Stranglethorn"),
        pin(50, 64.7, 40.2, 4, "Bambala - Priestess Hu'rala, Horde", "Northern Stranglethorn"),
        pin(50, 53.2, 66.0, 5, "Thaalia - enter Be Raptor's vision through dialogue", "Northern Stranglethorn"),
        pin(50, 64.7, 40.2, 5, "Hu'rala - enter Be Raptor's vision through dialogue", "Northern Stranglethorn"),
        pin(50, 53.2, 66.0, 6, "Thaalia - finish the vision quest", "Northern Stranglethorn"),
        pin(50, 64.7, 40.2, 6, "Hu'rala - finish the vision quest", "Northern Stranglethorn"),
        pin(50, 67.5, 32.9, 7, "Zul'Gurub - outer gate, continue east", "Northern Stranglethorn"),
        pin(50, 72.1, 32.9, 7, "Zul'Gurub - Heroic instance portal", "Northern Stranglethorn"),
        pin(337, 60.4, 79.9, 7, "Bloodlord Mandokir - defeat the boss", "Zul'Gurub"),
        pin(337, 60.4, 79.9, 8, "Mandokir's arena - hatchling at the back after the kill", "Zul'Gurub"),
    },
    areaMaps = {337},
})

-- https://www.wowhead.com/item=69239#comments (rahael, 782722, 838314)
-- https://www.wowhead.com/npc=52830
add(306, "Winterspring Cub", 69239, {
    category = "Vendor", source = "Michelle De Rum - inside the Everlook inn, Winterspring", npcId = 52830,
    description = "A direct vendor purchase available to both factions, independent of the Wintersaber mount dailies.",
    difficulty = "easy", difficultyReason = "Travel to a neutral inn and buy the pet; no quest chain or rare drop.",
    requirements = "Access to Everlook and enough gold", cost = "50 gold before any applicable discount",
    tips = "Michelle stands in a back corner inside the inn. Do not confuse the cub with Rivern Frostwind's Alliance mount quest. If goblin guards are hostile, an alt or another player can buy the tradeable item for you.",
    steps = {
        "Travel to Everlook in Winterspring. Either faction can use Michelle De Rum's shop; the companion purchase does not require Wintersaber Trainers reputation.",
        "Enter the inn at about 59.8,51.6 and look in its back corner for Michelle De Rum, Pet Collector. Open her vendor window and buy Winterspring Cub for 50 gold.",
        "Use the item to add the species to your Pet Journal. You can instead buy the unused item or a caged Winterspring Cub from another player; compare that price with the vendor's 50 gold before paying a travel premium.",
    },
    waypoints = { pin(83, 59.8, 51.6, 2, "Michelle De Rum - inside Everlook inn", "Winterspring") },
})

-- https://www.wowhead.com/item=67282#comments (745099, 1014297)
add(293, "Elementium Geode", 67282, {
    category = "Professions", source = "Rare bonus from Elementium Veins and Rich Elementium Veins",
    description = "A mining bonus from Cataclysm Elementium deposits. The item or learned pet can also be purchased from another player.",
    difficulty = "medium", difficultyReason = "Mining is simple, but the bonus pet is random and can take many nodes.",
    requirements = "Cataclysm Mining for the farming route; no profession required for a purchased pet",
    cost = "No vendor cost; Auction House prices vary", tips = "Buying or prospecting Elementium Ore does not reproduce mining the vein. The marked Deepholm position is a reported node area, not a permanent pet spawn or guaranteed drop.",
    steps = {
        "Choose to farm with Mining or buy an unused Elementium Geode / caged Elementium Geode on the Auction House. A non-miner can learn a purchased copy.",
        "For farming, train Cataclysm Mining and enable mineral tracking. Search Elementium Veins and Rich Elementium Veins in Deepholm, Twilight Highlands or original Uldum. Mine suitable deposits rather than Obsidium nodes.",
        "Loot every mined vein and continue around the zone's cliffs, rocky edges and caves as new nodes respawn. The area north of the Temple of Earth around 51,37 is one reported Deepholm find; it is a starting search area, not a guaranteed node.",
        "When Elementium Geode appears in your mining loot, use the item to learn it. You do not need to enter The Stonecore, kill Corborus or prospect a stack of ore.",
    },
    waypoints = { pin(207, 51.0, 37.0, 3, "Elementium node search - no guaranteed deposit", "Deepholm") },
    areaMaps = {241, 249},
})

-- /item=70140#comments, /item=70160#comments and their current vendor records.
-- /quest=29279#comments, /quest=29281#comments explain both recruitments and
-- the return to Matoclaw in Hyjal. Marks unlock vendors; the pets cost gold.
for _, pet in ipairs({
    {317, "Hyjal Bear Cub", 70140, "Calling the Ancients", "Varlan Highbough", 53882, 44.45, 88.8},
    {318, "Crimson Lasher", 70160, "Filling the Moonwell", "Ayla Shadowstorm", 53881, 44.1, 86.35},
}) do
    local speciesID, name, itemID, project, vendor, npcID, x, y = unpack(pet)
    add(speciesID, name, itemID, {
        category = "Vendor", source = vendor .. " in the Molten Front after " .. project, npcId = npcID,
        description = "A guaranteed vendor pet after weeks of Molten Front progression. A tradeable cage offers an alternative.",
        difficulty = "medium", difficultyReason = "The tasks are straightforward, but recruiting both factions and the final project take daily resets.",
        requirements = "Hyjal story through Aessina's Miracle, Molten Front access, both recruitments and " .. project,
        cost = "1,500 gold before discounts; campaign spending: 20 + 150 + 150 + 125 Marks of the World Tree",
        tips = "Use one character for the campaign and purchases. Both Druids of the Talon and The Shadow Wardens must be recruited. Completing the other final project does not substitute for " .. project .. ".",
        steps = {
            "Quest through Mount Hyjal to Aessina's Miracle. Go to the Sanctuary of Malorne at 27.1,62.5 and start Guardians of Hyjal: Firelands Invasion! or its available follow-up. Finish the defense introduction and sanctuary dailies.",
            "Spend 20 Marks of the World Tree on Calling for Reinforcements and finish the opening quests into the Molten Front. Use the Hyjal portal at about 27.6,56.3; inside, Malfurion's Breach around 47,90.7 is the daily hub.",
            "Repeat the available dailies and recruit Druids of the Talon for 150 marks and The Shadow Wardens for another 150. Complete each recruitment's follow-ups. Choosing one route for today's dailies does not permanently lock out the other faction.",
            "After both recruitments, save another 125 marks for " .. project .. ". Follow its turn-in back through the portal to Matoclaw at the Sanctuary of Malorne; merely accepting the project does not unlock the vendor.",
            "Return to the Molten Front and find " .. vendor .. " at " .. x .. "," .. y .. ". Buy " .. name .. " for 1,500 gold before applicable discounts, then learn it. Alternatively, learn a caged copy bought from another player without doing this campaign.",
        },
        waypoints = {
            pin(198, 27.1, 62.5, 1, "Sanctuary of Malorne - invasion introduction", "Mount Hyjal"),
            pin(198, 27.6, 56.3, 2, "Portal to the Molten Front - after introduction", "Mount Hyjal"),
            pin(338, 47.0, 90.7, 3, "Malfurion's Breach - both 150-mark recruitments", "Molten Front"),
            pin(198, 27.1, 62.5, 4, "Matoclaw - complete " .. project, "Mount Hyjal"),
            pin(338, x, y, 5, vendor .. " - buy " .. name, "Molten Front"),
        },
    })
end

-- https://www.wowhead.com/item=34955#comments (693338, togahsisoka, Blueyan)
-- https://www.wowhead.com/item=71631#comments
-- Ahune's original drop was removed, but this SAME species remains obtainable.
add(172, "Searing Scorchling", 34955, {
    category = "Rare Drops", source = "Scorched Stone in Zen'Vorka's Cache - fully unlocked Molten Front", npcId = 52822,
    description = "The original holiday drop was replaced by a rare reward inside Molten Front currency caches.",
    difficulty = "hard", difficultyReason = "The full daily campaign is followed by random cache attempts that can take many more resets.",
    requirements = "Both Molten Front recruitments and all three final support projects for cache access",
    cost = "695 Marks of the World Tree in unlock spending from scratch; 30 marks per cache afterward",
    tips = "Do not farm Ahune for the old Scorched Stone drop. Having only Additional Armaments completed is insufficient for the fully unlocked cache route. Buying multiple caches together does not improve each cache's odds.",
    steps = {
        "Complete Hyjal's story through Aessina's Miracle, then the invasion introduction at the Sanctuary of Malorne, 27.1,62.5. Spend 20 Marks on Calling for Reinforcements and follow the opening quests through the portal at 27.6,56.3.",
        "Run the available sanctuary and Molten Front dailies. Spend 150 marks on Druids of the Talon and 150 on The Shadow Wardens, completing the associated recruitment follow-ups on this same character.",
        "Complete Calling the Ancients, Additional Armaments and Filling the Moonwell for 125 marks each, following their turn-ins to Matoclaw back in Hyjal. All three are needed for the completed-front route; their order only affects which benefits you unlock first.",
        "Return to Zen'Vorka at about 44.8,88.6 in the Molten Front. Once his cache is available, buy Zen'Vorka's Cache for 30 Marks of the World Tree and open it. The desired item inside is Scorched Stone.",
        "If the stone is absent, earn more marks and repeat. When it drops, use Scorched Stone to learn Searing Scorchling. A caged Searing Scorchling from another player bypasses both the campaign and the random caches.",
    },
    waypoints = {
        pin(198, 27.1, 62.5, 1, "Sanctuary of Malorne - invasion unlock", "Mount Hyjal"),
        pin(198, 27.6, 56.3, 1, "Portal to the Molten Front", "Mount Hyjal"),
        pin(338, 47.0, 90.7, 2, "Malfurion's Breach - recruit both factions", "Molten Front"),
        pin(198, 27.1, 62.5, 3, "Matoclaw - finish all three support projects", "Mount Hyjal"),
        pin(338, 44.8, 88.6, 4, "Zen'Vorka - buy 30-mark caches", "Molten Front"),
    },
})

-- /item=71140, /item=71387, /item=54810 comments: Robbie, Auryan, 101151.
-- /achievement=5876, /achievement=5877, /achievement=5875 remain Retail rewards.
-- The mailed-item descriptions predate automatic Pet Journal delivery.
for _, pet in ipairs({
    {323, "Nuts", 71140, 100, 5876, "Petting Zoo"},
    {325, "Brilliant Kaliri", 71387, 125, 5877, "Menagerie"},
    {255, "Celestial Dragon", 54810, 150, 5875, "Littlest Pet Shop"},
}) do
    local speciesID, name, itemID, target, achievementID, achievement = unpack(pet)
    add(speciesID, name, itemID, {
        category = "Achievements", source = achievement .. " - collect " .. target .. " unique pet species",
        sourceAchievementId = achievementID,
        description = "An account-wide collection milestone. The reward is added to the Pet Journal, rather than requiring a visit to a reward NPC.",
        difficulty = "medium", difficultyReason = "No difficult fight is required, but collecting " .. target .. " different species takes travel and a growing collection.",
        requirements = target .. " different learned pet species; additional copies of one species do not count",
        cost = "No reward fee; optional vendor and Auction House purchases",
        tips = "Neither a Collector's Edition nor a shop pet is required. Capturable wild species count. The map offers practical collection starting areas, not a spawn location for " .. name .. ".",
        steps = {
            "Open " .. achievement .. " in Pet Battles > Collect and check its unique-species counter. Learn unused pet items and cages already in your bags before spending more gold; duplicates do not close the gap to " .. target .. ".",
            "Buy missing vendor species. For example, Breanni in Northrend Dalaran at 58.6,39.6 sells Obsidian Hatchling, Albino Snake and Calico Cat. Alliance can also visit Donni Anthania at 44.2,53.2 in Elwynn Forest for the cheap house-cat varieties. Learn only species your account is missing.",
            "Train Battle Pet Training if necessary and capture missing wild species. Begin with low-level pets in Elwynn Forest (Alliance) or Durotar (Horde), then visit additional zones rather than repeatedly catching the same species. Reduce a wild pet below the trap's health threshold, use Trap, and win the encounter.",
            "Continue with inexpensive missing cages and guaranteed quest pets until you reach " .. target .. ". The game adds " .. name .. " to your Pet Journal automatically. Clear journal filters and relog if the achievement has completed but the pet is not yet visible; do not wait for an old-style Breanni reward letter.",
        },
        waypoints = {
            pin(125, 58.6, 39.6, 2, "Breanni - three vendor species, Northrend Dalaran", "Dalaran (Northrend)"),
            pin(37, 44.2, 53.2, 2, "Donni Anthania - Alliance house-cat vendor", "Elwynn Forest"),
        },
        areaMaps = {37, 1},
    })
end

-- /item=72042#comments, /item=72045#comments, /quest=29412, /quest=29401.
-- MysteryFruit, Melilithia and the quest comments describe ground-level balloons.
for _, pet in ipairs({
    {331, "Alliance Balloon", 72042, "Alliance", "Vin", 54117, 84, 58.9, 52.7, "Stormwind City", "Old Town and the canals"},
    {332, "Horde Balloon", 72045, "Horde", "Jaga", 54118, 85, 48.1, 46.8, "Orgrimmar", "the Valley of Wisdom, The Drag and the Valley of Strength"},
}) do
    local speciesID, name, itemID, faction, child, npcID, mapID, x, y, city, area = unpack(pet)
    add(speciesID, name, itemID, {
        category = "Quest Rewards", source = "Blown Away - " .. child .. " in " .. city, npcId = npcID,
        description = "A short collection quest awards a faction-themed companion balloon. This companion cannot battle.",
        faction = faction:lower(), difficulty = "easy", difficultyReason = "Collect five nearby objects and return to the quest giver.",
        requirements = "A level 10+ " .. faction .. " character for this faction's quest",
        cost = "No purchase", tips = "Opposing-faction characters cannot simply visit the child to take this quest. Balloons spawn near the ground; you do not need to chase them high above the city. This pet cannot be caged.",
        steps = {
            "Use a " .. faction .. " character and speak to " .. child .. " at " .. x .. "," .. y .. " in " .. city .. ". Enable trivial-quest tracking if you are above the quest's level and accept Blown Away.",
            "Search " .. area .. " for sparkling Windswept Balloons hovering close to the ground, often behind trees or beside buildings. Click five quest objects; another player's summoned balloon cannot be looted.",
            "Return to " .. child .. " at the starting location and turn in Blown Away. Use the " .. name .. " reward and check your Pet Journal. If the child is floating away after another turn-in, wait for the respawn.",
        },
        waypoints = {
            pin(mapID, x, y, 1, child .. " - accept Blown Away", city),
            pin(mapID, x, y, 3, child .. " - balloon reward turn-in", city),
        },
        areaMaps = {mapID},
    })
end

-- https://www.wowhead.com/item=78916#comments (rokkitan, IhaveNoLife, Tilde)
-- https://www.wowhead.com/npc=58163 - In-Game Shop, not a guild reward.
-- Blizzard's 2026 Spring Bloom Pet Pack announcement also confirms standalone sales:
-- https://worldofwarcraft.blizzard.com/en-us/news/24267944
add(347, "Soul of the Aspects", 78916, {
    category = "Promotion", source = "Blizzard's World of Warcraft Shop - Soul of the Aspects",
    description = "An account-bound shop pet. The old Fangs of the Father guild-reward speculation was incorrect.",
    difficulty = "easy", difficultyReason = "A shop purchase and account delivery; no in-game grind or legendary quest is required.",
    requirements = "A compatible Retail WoW account in the shop region used for the purchase",
    cost = "Real money / supported Battle.net Balance; use the current regional shop price",
    tips = "The pet is not cageable. Guild vendors, Dragon Soul and the rogue legendary daggers do not award it. There is no physical acquisition NPC, so this guide intentionally has no map destination.",
    steps = {
        "Open the official World of Warcraft Shop on your Battle.net account or the in-game Shop, and find the Soul of the Aspects pet. Check that the product is for Retail WoW and the region/account on which you play.",
        "Review the current regional price and complete the purchase if you want this shop pet. No guild achievement, reputation or Fangs of the Father quest is part of the acquisition.",
        "Log into the purchased account's Retail region and search the Pet Journal for Soul of the Aspects, clearing filters if needed. Allow account delivery to finish and relog if it has not appeared yet; no trip to a guild vendor is necessary.",
    },
    waypoints = {},
})
