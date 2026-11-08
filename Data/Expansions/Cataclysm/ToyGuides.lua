-- English Retail acquisition routes, manually reviewed 2026-11-04.
-- Item comments, acquisition replies and current quest/recipe/NPC records were
-- reconciled with the existing catalogue. Historical use tricks are not routes.
-- Loaded Gnomish Dice follows Kamikaze28's numbered acquisition comment,
-- without its closing Profit step. Other routes synthesize acquisition evidence.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.toys = TDP.CollectionWalkthroughs.toys or {}
local guides = TDP.CollectionWalkthroughs.toys

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(itemID, name, guide)
    local lines = { "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason }
    for step, instruction in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. instruction
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #guide.steps
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.sourceType = guide.category
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end

-- https://www.wowhead.com/item=40727#comments:id=2307428
-- https://www.wowhead.com/item=40727#comments:id=3296719
-- /spell=95705, /quest=29477 and current item tooltip distinguish crafting,
-- collecting and using the toy; the old unusable-trinket bug is obsolete.
add(40727, "Gnomish Gravity Well", {
    category = "Professions", source = "Cataclysm Engineering 50 and Gnomish Engineering; or an unused player-crafted toy",
    description = "A tradeable Engineering toy that repeatedly lifts its user vertically until it overheats.",
    difficulty = "medium", difficultyReason = "Self-crafting needs two Engineering skill tracks and a specialization; buying the finished toy bypasses that work.",
    requirements = "Craft/use: Cataclysm Engineering 50 and Gnomish Engineer; initial specialization: Classic Engineering 200. Collection alone does not require Engineering.",
    cost = "6 Electrified Ether and 3 Hardened Elementium Bars; specialization samples if needed; or a player-set purchase price",
    steps = {
        "For collection alone, buy an unused Gnomish Gravity Well (40727) from the Auction House or another Engineer, then use it to add it to the Toy Box. If you want to craft or operate it yourself, continue with the profession route below.",
        "Visit Lilliam Sparkspindle at 62.8,32.0 in Stormwind or Roxxik at 56.8,56.4 in Orgrimmar. Learn Engineering and its separate Cataclysm branch. Raise Cataclysm Engineering to 50 using the trainer's available recipes; levels in another expansion's Engineering do not count.",
        "If you are not a Gnomish Engineer, raise Classic Engineering to 200 and take Gnomish Engineering from a capital Engineering trainer. Turn in 6 Mithril Tubes, 1 Accurate Scope and 2 Advanced Target Dummies. Any eligible race can choose this specialization. Return to the trainer and learn Gnomish Gravity Well.",
        "Gather 6 Electrified Ether and 3 Hardened Elementium Bars. Ether is crafted from Volatile Air; the bars require Elementium Bars and Volatile Earth. Buying the finished reagents is sufficient. Bring an Arclight Spanner and Gyromatic Micro-Adjustor, or a tool replacing them, and craft the toy.",
        "Use the finished item to learn it. To activate it from the Toy Box, keep Cataclysm Engineering 50 and Gnomish Engineering. Use it out of combat in a supported flying area; each activation raises you again, but overheating can leave you falling.",
    },
    tips = "The toy is still obtainable. Its tooltip restricts where it works; old comments about bypassing no-flight zones are not a current acquisition or travel method. Learning it once is enough for the account, while each user must meet the profession requirements.",
    effect = "Temporarily reverses gravity outside combat in supported areas where flying mounts are allowed.",
    waypoints = {
        pin(84, 62.8, 32.0, 2, "Lilliam Sparkspindle - Alliance Engineering trainer", "Stormwind City"),
        pin(85, 56.8, 56.4, 2, "Roxxik - Horde Engineering trainer", "Orgrimmar"),
        pin(84, 62.8, 32.0, 3, "Lilliam - Gnomish specialization and recipe", "Stormwind City"),
        pin(85, 56.8, 56.4, 3, "Roxxik - Gnomish specialization and recipe", "Orgrimmar"),
    },
})

-- https://www.wowhead.com/item=60854#comments:id=3240950 (both replies)
-- https://www.wowhead.com/item=60854#comments:id=2357788
-- https://www.wowhead.com/item=60854#comments:id=6291049
-- /spell=84421 and the current item tooltip: craft at 40, use at 70.
add(60854, "Loot-A-Rang", {
    category = "Professions", source = "Cataclysm Engineering 40 recipe; or an unused player-crafted toy",
    description = "A reusable remote-looting tool. Collecting the toy and meeting its use requirement are separate tasks.",
    difficulty = "medium", difficultyReason = "Buying the toy is simple, but using it requires Cataclysm Engineering 70 and the associated material investment.",
    requirements = "Craft: Cataclysm Engineering 40. Use: Cataclysm Engineering 70 on each character. No specialization is required.",
    cost = "5 Hardened Elementium Bars and 5 Electrified Ether, plus profession-leveling materials; or a player-set toy price",
    steps = {
        "Buy an unused Loot-A-Rang (60854), commission it from an Engineer, or craft it yourself. Check the item ID: Findle's Loot-A-Rang is a separate toy with different location restrictions.",
        "For self-crafting or use, visit Lilliam Sparkspindle at 62.8,32.0 in Stormwind or Roxxik at 56.8,56.4 in Orgrimmar. Train Engineering and Cataclysm Engineering. Reach Cataclysm skill 40 and learn Loot-a-Rang from the trainer.",
        "Obtain 5 Hardened Elementium Bars and 5 Electrified Ether. Making the bars takes 50 Elementium Bars and 20 Volatile Earth. Ether is made from Volatile Air in batches of 2-3; buy 5 finished Ether or craft enough batches. At an anvil, craft Loot-A-Rang.",
        "Use the item to add it to the Toy Box. To operate it, continue leveling Cataclysm Engineering to 70 even though the toy was craftable at 40. Early recipes include Handful of Obsidium Bolts, Electrified Ether and Explosive Bolts; later use trainer recipes such as the fishing tools and Volatile Seaforium Blastpack while they still grant skill.",
        "Put the learned toy on your action bar. With Cataclysm Engineering 70, activate it near lootable corpses to retrieve their loot. Auto Loot makes repeated use easier; a corpse must still be in range and eligible for your loot.",
    },
    tips = "The old Engineering 1 or 125 use requirement is obsolete. It remains usable in current Retail; comments confirm it works after the Midnight introduction, although some introductory scenario phases reject it. Do not interpret that temporary zone error as removal of the toy.",
    effect = "Retrieves loot from a nearby corpse, including applicable area loot, on a 3-second cooldown.",
    waypoints = {
        pin(84, 62.8, 32.0, 2, "Lilliam - Cataclysm Engineering and recipe", "Stormwind City"),
        pin(85, 56.8, 56.4, 2, "Roxxik - Cataclysm Engineering and recipe", "Orgrimmar"),
        pin(84, 62.8, 32.0, 4, "Lilliam - continue training to Cataclysm 70", "Stormwind City"),
        pin(85, 56.8, 56.4, 4, "Roxxik - continue training to Cataclysm 70", "Orgrimmar"),
    },
})

-- https://www.wowhead.com/item=63269#comments:id=2004478
-- Kamikaze28: green, rating 32, six numbered steps ending in Profit; no replies.
-- https://www.wowhead.com/item=63269#comments:id=2014646 (all seven replies)
-- https://www.wowhead.com/item=63269#comments:id=1990335 (all ten replies)
-- Later Retail confirmations: comments 5517084, 5657102 and 5920938.
add(63269, "Loaded Gnomish Dice", {
    category = "Rare Drops", source = "Rogue Pick Pocket on Cataclysm humanoids; unused dice can be traded",
    description = "Loaded dice obtained from pockets, rather than ordinary corpse loot. An Auction House purchase is available to every class.",
    difficulty = "hard", difficultyReason = "The direct route is Rogue-only and can require thousands of pickpockets with no guaranteed drop.",
    requirements = "Rogue with Stealth and Pick Pocket to farm; any class can collect or use a purchased unused toy",
    cost = "No farming purchase cost; Auction House prices vary",
    steps = {
        "If you are not a Rogue or want to avoid the farm, buy unused Loaded Gnomish Dice (63269) from another player and go to step 7. For farming, bring a Rogue with Stealth and Pick Pocket, enable Auto Loot and leave bag space for lockboxes and junk.",
        "Travel to Maker's Ascent in northwest Uldum. Begin at the bottom of the stairs around 42.0,12.5 and work upward toward the Ruins of Khintaset. Use the original Uldum phase: if assaults have replaced the zone, speak to Zidormi near 56.0,35.1 to return to the earlier version.",
        "Pick Pocket the Schnottz Infantrymen in each formation. Aim Distract into the center of a patrol to hold it briefly while you work; later replies also confirm that Sapping its elite leader stops the formation. Pick each normal soldier and the elite separately, watching for movement as the control expires.",
        "Pick the stationary Infantrymen at the edges of each platform too. Continue up the steps without skipping a formation. Avoid campfires and careless movement through enemies, which can break Stealth. The dice must come from Pick Pocket; killing alone is not this route.",
        "At the gate above the stairs, open lockboxes you can unlock, sell junk and free bag space. Return to the bottom for another circuit when pockets have refilled. If you kill picked enemies for fresh respawns, coordinate with any other Rogue already using the route.",
        "Repeat until the dice appear in your bags. If this phase of Maker's Ascent has no Infantrymen or is crowded, try the humanoids in the Chamber of the Moon below the Obelisk of the Moon, entering near 42.0,25.0. Alternatively, use Tol Barad Peninsula's Rustberg Village around 67.0,28.0 and Farson Hold around 37.4,29.4 as pocket circuits. These are alternatives, not additional required steps.",
        "Use the unused dice from your bags to learn the account-wide toy. A learned copy cannot be sold, so keep any extra unused copies separate if you intend to trade them.",
    },
    tips = "The old Pick Pocket glyph, Burst of Speed talent and level-83 minimum from early comments are not prerequisites for this Retail route. Very short lucky farms do not establish a normal drop time.",
    effect = "Rolls cosmetic loaded dice that produce a three and a four.",
    waypoints = {
        pin(249, 42.0, 12.5, 2, "Maker's Ascent - start at bottom of stairs", "Uldum"),
        pin(249, 56.0, 35.1, 2, "Zidormi - earlier Uldum if assault phase is active", "Uldum"),
        pin(249, 37.6, 12.8, 3, "Schnottz Infantrymen - work upward through formations", "Uldum"),
        pin(249, 42.0, 25.0, 6, "Chamber of the Moon entrance - pockets BELOW ground", "Uldum"),
        pin(245, 67.0, 28.0, 6, "Rustberg Village - alternative pocket circuit", "Tol Barad Peninsula"),
        pin(245, 37.4, 29.4, 6, "Farson Hold - alternative pocket circuit", "Tol Barad Peninsula"),
    },
})

-- https://www.wowhead.com/item=53057#comments:id=1180151 (all four replies)
-- https://www.wowhead.com/item=53057#comments:id=2252040 (all four replies)
-- Pacmane's reply restores Full of Hot Water to the sequence.
-- /quest=14133 is obsolete; /quest=14392 ends with Sorata in Bilgewater Harbor.
add(53057, "Faded Wizard Hat", {
    category = "Quest Rewards", source = "Horde Azshara story ending with Farewell, Minnow", faction = "horde",
    description = "A Horde quest-chain toy that recalls the disguises of Archmage Xylem's apprentices.",
    difficulty = "medium", difficultyReason = "A substantial quest chain and three movement trials, with no random reward roll.",
    requirements = "Horde character; Azshara's Kalec, Ergll and Xylem storyline",
    cost = "No purchase cost",
    steps = {
        "Use a Horde character and enable Trivial Quests. Start Azshara Blues with Teemo near 59.4,50.5 in Bilgewater Harbor and meet Kalec near 55.5,52.1. On a character that already started this story, resume its first unfinished quest instead of restarting the zone.",
        "Follow Friends Come In All Colors to Ergll at 70.4,36.2. Complete his errands, including A Little Pick-me-up, Absorbent, Full of Hot Water and That's Just Rude! Follow the offered order. Full of Hot Water uses the boiling-water elemental near the Tower of Eldara; do not skip the automatically offered quest.",
        "Take Wash Out to Sorata Firespinner at the Northern Rocketway Exchange near 42.6,25.2, then Dressed to Impress. Continue to the apprentice camp and Image of Archmage Xylem near 47.2,20.8. The Way to a Mage's Heart is obsolete and is not a missing prerequisite.",
        "Complete the apprentice tasks Shear Will, Waste of Thyme, Renewable Resource, Manual Labor and Trouble Under Foot. Then follow The Pinnacle of Learning and Watch Your Step to the trial area. Use the quest's transport and arcane stepping route rather than searching below the cliff for the NPC.",
        "At Xylem's trial hub near 55.8,12.0, complete The Trial of Fire, The Trial of Frost and The Trial of Shadow. Fire: move into safe runes for 10 consecutive bursts. Frost: collect 20 ice essences while avoiding Frostburn. Shadow: lure 20 Weeping Souls across shadow runes without letting them touch you. Use the colored crystals and portals to reach the arenas; follow the quest counters.",
        "Finish Xylem's Asylum and Wasn't It Obvious?, then the Spirit of Azuregos quests Easy is Boring and Turning the Tables. Follow the story to Kalec, Feno and Jellix in the Bitter Reaches, completing Fade to Black, Pro-liberation and Ice Cold as offered.",
        "Speak to Azuregos near 67.0,20.4 for Farewell, Minnow, then deliver it to Sorata Firespinner in Bilgewater Harbor near 53.2,50.0. Receive Faded Wizard Hat and use it from your bags to add it to the Toy Box.",
    },
    tips = "The longer trial achievements are optional; finish the quest objectives to advance. This remains a Horde source and use restriction. Old warnings about keeping a physical hat equipped predate the Toy Box conversion.",
    effect = "Transforms the user into one of Xylem's apprentices, with a 30-minute cooldown.",
    waypoints = {
        pin(76, 59.4, 50.5, 1, "Teemo - Azshara Blues", "Azshara"),
        pin(76, 55.5, 52.1, 1, "Kalec - begin the Azuregos story", "Azshara"),
        pin(76, 70.4, 36.2, 2, "Ergll - coastal errands", "Azshara"),
        pin(76, 42.6, 25.2, 3, "Sorata - Northern Rocketway Exchange", "Azshara"),
        pin(76, 47.2, 20.8, 4, "Image of Xylem - apprentice camp", "Azshara"),
        pin(76, 55.8, 12.0, 5, "Xylem's trial hub - colored portal crystals", "Azshara"),
        pin(76, 33.0, 23.4, 5, "Fire trial arena - enter through trial portal", "Azshara"),
        pin(76, 62.2, 21.0, 5, "Frost trial arena - enter through trial portal", "Azshara"),
        pin(76, 31.0, 26.8, 5, "Shadow trial arena - enter through trial portal", "Azshara"),
        pin(76, 66.5, 20.3, 6, "Kalec - Bitter Reaches story hub", "Azshara"),
        pin(76, 67.0, 20.4, 7, "Azuregos - accept Farewell, Minnow", "Azshara"),
        pin(76, 53.2, 50.0, 7, "Sorata - final turn-in and hat", "Azshara"),
    },
})

-- Archaeology evidence: each item's complete Retail comment list, including
-- ViceVersa's project summaries; current created-by-project records confirm
-- race, fragment cost and three keystone sockets (Ancient Amber has none).
-- /item=64482#comments:id=2621391 and its reply explain the Mantid exchange.
-- /item=64482#comments:id=6228277 corrects the idea of exchanging Vrykul directly.
-- /item=64361#comments:id=1361700 and replies disprove treating the database's
-- learnedat=525 value as a universal minimum for every rare discovery.
local archaeologyRegions = {
    ["Night Elf"] = {
        maps = {12},
        route = "Use Kalimdor's active Night Elf dig sites. Night Elf ruins are common there; check the race shown on each find. Completing Fossil or other active sites can make room for new Night Elf sites.",
    },
    Dwarf = {
        maps = {13},
        route = "Work active Dwarf dig sites in Eastern Kingdoms, where this race is common. Check the fragment type on each find and clear other active sites when necessary to generate new Dwarf locations.",
    },
    Draenei = {
        maps = {101},
        route = "Raise Archaeology to 300 to open Outland dig sites. Travel to Outland, not the alternate Draenor continent. Prioritize Draenei sites; clear the available Orc sites when necessary to generate more Draenei sites.",
    },
    Nerubian = {
        maps = {113},
        route = "Raise Archaeology to 375 to open Northrend dig sites. Fly between the active Nerubian sites shown on your map. These are sparse, so finish unwanted Vrykul and other active sites to roll new locations; Vrykul fragments do not become Nerubian fragments by themselves.",
    },
    ["Tol'vir"] = {
        maps = {249},
        route = "Raise Archaeology to 450 to open Uldum's Tol'vir sites. Survey active Uldum sites and clear other Kalimdor sites when needed to generate replacements. If an assault phase hides the original sites, speak to Zidormi at 56.0,35.1 to return to earlier Uldum.",
    },
    Vrykul = {
        maps = {113},
        route = "Raise Archaeology to 375 to open Northrend dig sites. Prioritize Vrykul sites, especially the ones offered in Howling Fjord and the eastern continent. Check the race of the actual fragments; Nerubian, Troll and Night Elf finds use separate projects.",
    },
    Fossil = {
        maps = {12, 13},
        route = "Survey active Fossil sites in Kalimdor or Eastern Kingdoms. Choose whichever continent currently gives you shorter travel between Fossil sites; clearing other races' sites can generate new Fossil digs. Fixed bones on the ground are not lootable unless that site is active for your character.",
    },
    Troll = {
        maps = {13},
        route = "Prioritize active Troll dig sites in Eastern Kingdoms. Check the fragment race at each site. Clear the other active dig sites when necessary to generate new Troll sites; you cannot choose an inactive ruin just because it has Troll scenery.",
    },
}

local function archaeologyToy(itemID, name, race, fragments, keystone, level, reason, effect, tip, commentID)
    local region = archaeologyRegions[race]
    local solve = "When " .. name .. " is your current " .. race .. " project, collect " .. fragments .. " " .. race .. " Archaeology Fragments"
    if keystone then
        solve = solve .. ", or insert up to 3 " .. keystone .. " into its sockets. Each socket replaces 12 fragments; all three reduce the requirement to " .. (fragments - 36) .. " fragments. Click Solve to receive the toy."
    else
        solve = solve .. ". This Fossil project has no keystone sockets: other races' keystones cannot reduce the cost. Click Solve to receive the toy."
    end
    local steps = {
        "Learn Archaeology from Harrison Jones at 85.6,25.8 in Stormwind, or Belloc Brightblade at 49.0,70.6 in Orgrimmar. Enable dig-site tracking on the world map and learn Survey. This is a secondary profession and does not replace a primary profession.",
        region.route,
        "At each active dig site, use Survey, follow the instrument's direction and narrow the distance as its light changes from red through yellow to green. Loot the finds until the site is exhausted. In the Archaeology journal, solve the current " .. race .. " artifact to roll the next project. Continue until " .. name .. " appears; neither a specific dig nor a fixed solve count guarantees this rare.",
        "Optional fragment supply at Archaeology 600: crate completed common artifacts from Pandaria, Draenor or the Broken Isles into Restored Artifacts. Visit Brann Bronzebeard at 83.5,31.0 in the Seat of Knowledge, on the balcony above Mogu'shan Palace in the Vale of Eternal Blossoms. Exchange 1 Restored Artifact for a crate of " .. race .. " fragments and open it. Ordinary old " .. race .. " solves are not themselves Restored Artifacts.",
    }
    if race == "Nerubian" or race == "Tol'vir" then
        steps[#steps + 1] = "For a concentrated optional Restored Artifact farm, first reach Exalted with the Lorewalkers. Buy Brann's Mantid Artifact Hunter's Kit for 2 Restored Artifacts, open it, keep the Sonic Locator in your bags and use its Lorewalker's Map. Survey the resulting Mantid sites in Townlong Steppes and Dread Wastes, solve and crate the common artifacts, then return to Brann for " .. race .. " crates. The locator lasts one real-time day; this route supplies fragments but does not guarantee the next rare project."
    end
    steps[#steps + 1] = solve
    steps[#steps + 1] = "Use the completed " .. name .. " from your bags to add it to the account-wide Toy Box. The finished toy does not require Archaeology to use. " .. tip
    local points = {
        pin(84, 85.6, 25.8, 1, "Harrison Jones - Alliance Archaeology trainer", "Stormwind City"),
        pin(85, 49.0, 70.6, 1, "Belloc Brightblade - Horde Archaeology trainer", "Orgrimmar"),
        pin(390, 83.5, 31.0, 4, "Brann - OPTIONAL fragment exchange, upper balcony", "Vale of Eternal Blossoms"),
    }
    local areas = {}
    for _, mapID in ipairs(region.maps) do areas[#areas + 1] = mapID end
    if race == "Tol'vir" then
        points[#points + 1] = pin(249, 56.0, 35.1, 2, "Zidormi - earlier Uldum dig-site phase", "Uldum")
    end
    if race == "Nerubian" or race == "Tol'vir" then
        points[#points + 1] = pin(390, 83.5, 31.0, 5, "Brann - optional Mantid kit and return with artifacts", "Vale of Eternal Blossoms")
        areas[#areas + 1] = 388
        areas[#areas + 1] = 422
    end
    add(itemID, name, {
        category = "Professions", source = race .. " Archaeology - rare " .. name .. " project",
        description = "A personal Archaeology rare. Project discovery is random; solving the discovered project awards this specific toy.",
        difficulty = level, difficultyReason = reason,
        requirements = "Archaeology on the solving character; no profession required to use the learned toy. Optional fragment crates require Archaeology 600.",
        cost = fragments .. " " .. race .. " fragments before applicable keystones; optional exchange: 1 Restored Artifact per fragment crate",
        effect = effect, tips = tip .. " Dig-site locations are personal and rotate. The map's region entries are search areas, not guaranteed toy spawns. Keep learning available Archaeology ranks as you progress; do not confuse fragment cost with required skill.",
        sourceComments = { "https://www.wowhead.com/item=" .. itemID .. "#comments:id=" .. commentID },
        steps = steps, waypoints = points, areaMaps = areas,
    })
end

archaeologyToy(64358, "Highborne Soul Mirror", "Night Elf", 100, "Highborne Scrolls", "medium",
    "Straightforward Kalimdor surveying, but discovering the rare project is random.",
    "Creates a translucent reflection of your character.",
    "The reflection is cosmetic; beta comments describing a gorilla are not the current toy effect.", 1138006)

archaeologyToy(64361, "Druid and Priest Statue Set", "Night Elf", 100, "Highborne Scrolls", "medium",
    "Repeated Night Elf solves are needed until this random rare project appears.",
    "Surrounds the user with a moving beam of light and falling leaves.",
    "Any class can collect it. Its name does not restrict it to Druids or Priests; use it outdoors to see the effect.", 1132613)

archaeologyToy(64373, "Chalice of the Mountain Kings", "Dwarf", 100, "Dwarf Rune Stones", "medium",
    "The survey-and-solve route is simple, but project discovery can take repeated Dwarf solves.",
    "Summons a historic Dwarven sword dance with accompanying music.",
    "This is a Dwarf project, so focus Eastern Kingdoms instead of the much more common Night Elf sites in Kalimdor.", 1132594)

archaeologyToy(64383, "Kaldorei Wind Chimes", "Night Elf", 98, "Highborne Scrolls", "medium",
    "Random Night Elf project discovery and travel between dig sites are the main obstacles.",
    "Plays chimes and reports the local weather through an emote.",
    "The unusual 98-fragment cost is correct. Enable sound to hear the chimes; they can help confirm snowfall when hunting a weather-dependent pet.", 1132621)

archaeologyToy(64456, "Arrival of the Naaru", "Draenei", 124, "Draenei Tomes", "medium",
    "Outland surveying requires profession progression, followed by random Draenei project discovery.",
    "Shows a brief scene of Draenei witnessing the arrival of a naaru.",
    "The project costs 124 Draenei fragments, not Orc fragments. It is a short cosmetic scene, not a Draenei companion pet.", 1132627)

archaeologyToy(64481, "Blessing of the Old God", "Nerubian", 140, "Nerubian Obelisks", "hard",
    "Nerubian sites are sparse and repeated random project rolls can make the direct route lengthy.",
    "Transforms the user into a green Qiraji battle tank for 20 seconds.",
    "Despite the Qiraji appearance, this comes from Nerubian Archaeology in Northrend. It is not a Tol'vir or Ahn'Qiraj drop.", 1132632)

archaeologyToy(64482, "Puzzle Box of Yogg-Saron", "Nerubian", 140, "Nerubian Obelisks", "hard",
    "Sparse Nerubian dig sites and random rare discovery can require a long farm; the crate route needs its own setup.",
    "Produces unsettling Old God whispers; it also has a separate interaction with Zek'voz's achievement in Uldir.",
    "The toy is awarded by solving the project. You do not need to find an underwater pearl, open the box, visit Yogg-Saron or complete an Uldir achievement to acquire it.", 1132633)

archaeologyToy(64488, "The Innkeeper's Daughter", "Dwarf", 150, "Dwarf Rune Stones", "medium",
    "A random Dwarf rare requiring repeated surveys and solves, with a larger fragment cost.",
    "Returns the user to their normal Hearthstone location and can summon a ghostly Dwarf companion.",
    "It shares the normal Hearthstone destination and cooldown. The ghost is not guaranteed on every use, and setting your home to Ironforge is not required.", 1132592)

archaeologyToy(64646, "Bones of Transformation", "Night Elf", 150, "Highborne Scrolls", "medium",
    "Repeated Night Elf surveys and random project discovery are required; the solve itself is straightforward.",
    "Transforms the user into a naga for 2 minutes.",
    "This is a Night Elf rare, not a Fossil project. Bones in the name do not make Fossil fragments usable for it.", 1132617)

archaeologyToy(64651, "Wisp Amulet", "Night Elf", 150, "Highborne Scrolls", "medium",
    "The rare project may take many Night Elf solves, with no fixed discovery order.",
    "Transforms the user into a wisp for 2 minutes.",
    "Any race can use the learned toy. It is a cosmetic form, not a flying mount or the Night Elf death-release racial.", 1137303)

archaeologyToy(64881, "Pendant of the Scarab Storm", "Tol'vir", 150, "Tol'vir Hieroglyphics", "hard",
    "Tol'vir sites share Kalimdor's limited active-site slots, and the rare project is random.",
    "Summons peaceful scarabs around the user.",
    "The scarabs are cosmetic rather than a combat swarm. If Uldum sites are scarce, the optional Restored Artifact route avoids repeatedly flying across Kalimdor for new site rolls.", 1132643)

archaeologyToy(69775, "Vrykul Drinking Horn", "Vrykul", 100, "Vrykul Rune Sticks", "medium",
    "Northrend surveying and random Vrykul project discovery are needed, without a difficult encounter.",
    "Enlarges the user and displays a Vrykul-style helmet for 10 minutes.",
    "This is the Northrend Vrykul project, not Legion's Vrykul Archaeology branch. The helmet is a temporary appearance, not a learned transmog.", 1400165)

archaeologyToy(69776, "Ancient Amber", "Fossil", 100, false, "medium",
    "Fossil sites are accessible, but the rare project is random and has no keystone shortcut.",
    "Encases the user in amber; the cosmetic effect can be canceled by removing its buff.",
    "Use 100 Fossil fragments. Insect in Amber is a different common artifact, and this toy does not absorb damage like a Mage's Ice Block.", 1404608)

archaeologyToy(69777, "Haunted War Drum", "Troll", 100, "Troll Tablets", "medium",
    "The route involves repeated Troll solves and random project discovery.",
    "Places a haunted drum and plays Troll music.",
    "Enable Music as well as game sound before using it. The quiet or muted song does not mean the acquisition failed.", 1387449)

-- https://www.wowhead.com/item=63141#comments:id=2079535 (40 commendations)
-- /item=63141#comments:id=6182508 and /item=64997#comments:id=2017997:
-- learning either faction's purchase also grants the counterpart toy.
-- /npc=47328 and /npc=48531 locate the vendors on the Peninsula.
for _, itemID in ipairs({63141, 64997}) do
    add(itemID, "Tol Barad Searchlight", {
        category = "Vendor", source = "Quartermaster Brazie or Pogg on Tol Barad Peninsula - Honored and 40 commendations",
        description = "The Alliance and Horde item IDs are paired Toy Box unlocks. A single purchase from your own faction grants both versions.",
        difficulty = "medium", difficultyReason = "Honored reputation and daily-quest currency take several visits; the final purchase is guaranteed.",
        requirements = "Buyer: Honored with Baradin's Wardens (Alliance) or Hellscream's Reach (Horde)",
        cost = "40 Tol Barad Commendations for one faction's item; learning it grants both versions",
        steps = {
            "Use the Tol Barad portal in your faction capital's Cataclysm portal area to reach Tol Barad Peninsula, map 245. The peninsula daily hub is separate from the southern battle island and the Baradin Hold raid.",
            "Alliance: take dailies at Baradin Base Camp near 73,61. Horde: take them at Hellscream's Grasp near 55,80. Complete and turn in the offered peninsula quests for reputation and Tol Barad Commendations. Repeat after daily resets until this character is Honored and has at least 40 commendations.",
            "If your faction controls the southern battle island, its available daily quests can add more reputation and currency. This is optional: ownership is not required for the peninsula dailies or the toy purchase.",
            "Alliance: buy Tol Barad Searchlight (63141) from Quartermaster Brazie near 72.4,63.0. Horde: buy Tol Barad Searchlight (64997) from Pogg near 54.6,81.0. Both vendors are on Tol Barad Peninsula. Pay 40 commendations; the old Toy Box tooltip suggesting a gold-only purchase is misleading.",
            "Use your purchased searchlight to learn it. Check both Toy Box versions before spending more currency: the matching opposing-faction toy is granted with the first unlock, so a second character does not need to repeat the grind.",
        },
        tips = "Reputation and commendations are separate requirements on the buyer. Save 40 spendable commendations rather than assuming Honored alone is enough. No raid kill is involved.",
        effect = "Places a rotating cosmetic searchlight for about 2.5 minutes, with a 5-minute cooldown. It does not detect Stealth.",
        waypoints = {
            pin(245, 73.0, 61.0, 2, "Baradin Base Camp - Alliance daily hub", "Tol Barad Peninsula"),
            pin(245, 55.0, 80.0, 2, "Hellscream's Grasp - Horde daily hub", "Tol Barad Peninsula"),
            pin(245, 72.4, 63.0, 4, "Quartermaster Brazie - Alliance searchlight", "Tol Barad Peninsula"),
            pin(245, 54.6, 81.0, 4, "Pogg - Horde searchlight", "Tol Barad Peninsula"),
        },
        areaMaps = {244},
    })
end

-- https://www.wowhead.com/item=66888#comments:id=1322556 (both replies)
-- https://www.wowhead.com/item=66888#comments:id=1463940 (both replies)
-- Comment 1445684 ends in Profit but describes using an owned toy for PvP,
-- not acquiring it. It is deliberately not used as an acquisition route.
add(66888, "Stave of Fur and Claw", {
    category = "Reputation", source = "Meilosh inside Timbermaw Hold in northern Felwood", npcId = 11557,
    description = "A guaranteed Exalted reputation purchase that provides a reusable furbolg disguise.",
    difficulty = "easy", difficultyReason = "Modern Timbermaw quests and repeatable turn-ins give large reputation gains; there is no rare drop or daily lockout.",
    requirements = "Exalted with Timbermaw Hold on the buying character",
    cost = "75 gold base price; normally 60 gold at the required Exalted standing, before any further applicable discount",
    steps = {
        "Enable Trivial Quests and visit Nafien at the southern Timbermaw tunnel entrance in northern Felwood, 64.0,10.4. Complete the Timbermaw quests he offers against Deadwood furbolgs. Keep Deadwood Headdress Feathers instead of selling them.",
        "Follow the Timbermaw quests inside the tunnel and on the Winterspring side. Gorn One Eye is near 64.6,5.0 on the Felwood map; Salfa is near 21.0,46.2 in Winterspring. Complete their offered Deadwood/Winterfall tasks and keep Winterfall Spirit Beads.",
        "Turn in sets of 5 Deadwood Headdress Feathers to Nafien and 5 Winterfall Spirit Beads to Salfa once their repeatable quests are available. Kill more of the corresponding hostile furbolgs for missing turn-in items. Repeat until Exalted; old pre-Cataclysm accounts of tiny reputation gains overstate the current grind.",
        "Enter Timbermaw Hold and find Meilosh near 64.8,5.2 on the Felwood map. Buy Stave of Fur and Claw once this character is Exalted; the toy can be hidden from his inventory before then. Pay the displayed price, normally 60 gold with the required reputation discount.",
        "Use the stave from your bags to learn the Toy Box item. Its use remains tied to Timbermaw reputation, so an alt without the standing may see the learned toy but cannot necessarily activate it.",
    },
    tips = "Kill Deadwood and Winterfall enemies, not friendly Timbermaw residents. This is the reusable Toy Box stave; the zone-restricted Dartol quest rod is a different item.",
    effect = "Transforms the user into a furbolg for 3 minutes, with a 1-hour cooldown.",
    waypoints = {
        pin(77, 64.0, 10.4, 1, "Nafien - initial quests and feather turn-ins", "Felwood"),
        pin(77, 64.6, 5.0, 2, "Gorn One Eye - Timbermaw tunnel quests", "Felwood"),
        pin(83, 21.0, 46.2, 2, "Salfa - Winterspring tasks", "Winterspring"),
        pin(77, 64.0, 10.4, 3, "Nafien - repeatable feathers", "Felwood"),
        pin(83, 21.0, 46.2, 3, "Salfa - repeatable spirit beads", "Winterspring"),
        pin(77, 64.8, 5.2, 4, "Meilosh - INSIDE tunnel, buy at Exalted", "Felwood"),
    },
})

-- https://www.wowhead.com/item=68806#comments:id=1398466 and reply
-- /item=68806#comments:id=1336568, 2503834 and 2619940 distinguish access,
-- quest phasing and the lack of a required Azshara quest chain.
add(68806, "Kalytha's Haunted Locket", {
    category = "Vendor", source = "Tex Vortacoil at Bear's Head, Azshara", npcId = 36375,
    description = "A direct purchase available to both factions, with no reputation or prerequisite quest-chain requirement.",
    difficulty = "easy", difficultyReason = "Travel to one vendor and pay the gold price; there is no random drop or progression unlock.",
    requirements = "Reach Tex Vortacoil in the elevated Bear's Head tower; either faction",
    cost = "5,000 gold listed vendor price",
    steps = {
        "Bring 5,000 gold on a character that can reach Azshara. Either faction can buy the locket; you do not need to complete the Faded Wizard Hat story first.",
        "Fly to Bear's Head around 25.5,38.0 in Azshara, northeast of Gallywix Pleasure Palace. Look for the elevated tower and enter its lower occupied floor. This is not the apprentice camp or the trial island farther north.",
        "Speak to Tex Vortacoil inside the tower and buy Kalytha's Haunted Locket for the displayed price, listed at 5,000 gold. Check the toy's name before buying reagent supplies from the same vendor.",
        "Use the locket from your bags to add it to the account-wide Toy Box. If Tex is missing while you have an active quest or scenario in this tower, finish or leave that phase and return, or buy it on another character without that phasing conflict.",
    },
    tips = "A completed Azshara quest chain is not required to open Tex's shop. Old comments about guild-level Bartering or guaranteed Goblin discounts do not establish the price you will pay today.",
    effect = "Transforms the user into Kalytha's ghostly Night Elf appearance; its 30-minute duration exceeds the 15-minute cooldown.",
    waypoints = {
        pin(76, 25.5, 38.0, 2, "Bear's Head - elevated tower, enter lower floor", "Azshara"),
        pin(76, 25.5, 38.0, 3, "Tex Vortacoil - buy locket", "Azshara"),
    },
})

-- https://www.wowhead.com/item=134022#comments:id=2512396
-- https://www.wowhead.com/item=134022#comments:id=3204330
-- /npc=50052 provides the Retail Shimmering Expanse wreck coordinates.
-- Current item drop data is not 100%; do not promise the older comment's rate.
add(134022, "Burgy Blackheart's Handsome Hat", {
    category = "Rare Drops", source = "Burgy Blackheart at his underwater wreck in Shimmering Expanse", npcId = 50052,
    description = "The current Toy Box replacement for Burgy's original Cataclysm hat, obtained by killing the same underwater rare.",
    difficulty = "medium", difficultyReason = "Reaching the wreck is simple with Vashj'ir access, but finding the rare alive and receiving the hat can take repeated visits.",
    requirements = "Underwater access to Shimmering Expanse; Sea Legs and the Vashj'ir seahorse make the journey easier",
    cost = "No purchase cost",
    steps = {
        "Travel to Vashj'ir and its Shimmering Expanse subzone. If this character has never been there, use the capital's Vashj'ir introduction when available and complete the opening Sea Legs quests for underwater breathing and movement, then continue far enough to obtain the zone seahorse.",
        "Swim or ride to Burgy's underwater wreck around 57.6,69.8 on the Shimmering Expanse map. Descend to the ship on the seabed; looking at the surface above the coordinate will not reveal the rare.",
        "Look for Burgy Blackheart (50052), the ghostly gnome pirate by the wreck. Kill him and loot the corpse for Burgy Blackheart's Handsome Hat (134022). If other collectors are waiting, group up before the kill and let nearby players reach the wreck.",
        "If Burgy is absent, return later or wait for a respawn. If he drops no hat for you, try another eligible kill. Old comments disagree about loot rules and sometimes call it guaranteed; a single anecdote is not a reliable current drop guarantee.",
        "Use the hat from your bags to learn it. If you already have the original physical hat (65665) from Cataclysm, check that old character and the Toy Box before farming another copy.",
    },
    tips = "Use map 205, Shimmering Expanse, for the coordinate. The rare is underwater, not inside a dungeon. Class-trial shortcuts from old comments are unnecessary for the normal Retail acquisition route.",
    effect = "Turns the user into Burgy's ghostly gnome pirate appearance, with a 3-second cooldown.",
    waypoints = {
        pin(205, 57.6, 69.8, 2, "Burgy's wreck - descend to the seabed", "Shimmering Expanse"),
        pin(205, 57.6, 69.8, 3, "Burgy Blackheart - rare at underwater ship", "Shimmering Expanse"),
    },
})

-- https://www.wowhead.com/item=133998#comments:id=2283530 (all six replies)
-- https://www.wowhead.com/item=133998#comments:id=2540770
-- /quest=28288#comments:id=1205803 and current quest tooltips supply objectives.
add(133998, "Rainbow Generator", {
    category = "Quest Rewards", source = "Arcanist Delaris's Felwood chain ending with Open Their Eyes", npcId = 47341,
    description = "A short, guaranteed quest reward shared by both factions. It uses the modern toy ID rather than the old trinket ID.",
    difficulty = "easy", difficultyReason = "A compact sequence of ordinary quests in southern Felwood, without daily or random-drop gates.",
    requirements = "A character eligible for the southern Felwood quest chain; either faction",
    cost = "No purchase cost",
    steps = {
        "Enable Trivial Quests and visit Arcanist Delaris at 41.8,72.0 in southern Felwood. If starting on a fresh character, complete The Corruption of the Jadefire when offered, killing the required Jadefire Glen satyrs. Then take Do the Imp-Possible.",
        "For Do the Imp-Possible, weaken Impsy in Jadefire Glen and use the Enchanted Imp Sack supplied by the quest. Return to Delaris. The captured Impsy then appears at the camp and offers the follow-ups.",
        "Complete See the Invisible by collecting 8 Cursed Ooze from the Ruins of Constellas, around 39.8,71.6. Then do Touch the Untouchable: use the quest's Phaseblood Potion at the Sigil of Tichondrius in Jadefire Glen, around 42.2,79.8. Kill Vorlus and loot the Claw of Tichondrius in that phased area, then return to camp.",
        "Complete Break the Unbreakable by killing Xavathras around 33.6,65.6, then return for Open Their Eyes. Use Delaris's Prism on 20 Jadefire Imps around 41.6,78.0 in Jadefire Glen; the objective is to terrify the imps with the prism, not kill them.",
        "Turn Open Their Eyes in to Arcanist Delaris at 41.8,72.0 and receive Rainbow Generator (133998). Use it to learn the toy. If Impsy is invisible after his capture, leave and return to the camp or relog before assuming the chain has been removed.",
    },
    tips = "The quest prism and the permanent toy are different items. Target another unit before activating the learned toy to see its rainbow; using it without a valid target can consume the cooldown without the expected beam.",
    effect = "Projects a rainbow toward a selected target, normally on a 10-minute cooldown.",
    waypoints = {
        pin(77, 41.8, 72.0, 1, "Arcanist Delaris - start Felwood chain", "Felwood"),
        pin(77, 41.8, 72.0, 2, "Delaris and captured Impsy - follow-ups", "Felwood"),
        pin(77, 39.8, 71.6, 3, "Ruins of Constellas - Cursed Ooze", "Felwood"),
        pin(77, 42.2, 79.8, 3, "Sigil area - potion phase and Vorlus", "Felwood"),
        pin(77, 33.6, 65.6, 4, "Xavathras - Break the Unbreakable", "Felwood"),
        pin(77, 41.6, 78.0, 4, "Jadefire Imps - use the prism on 20", "Felwood"),
        pin(77, 41.8, 72.0, 5, "Arcanist Delaris - Open Their Eyes reward", "Felwood"),
    },
})

-- https://www.wowhead.com/item=70161#comments:id=1423029 and reply
-- https://www.wowhead.com/item=70159#comments:id=3247131
-- /quest=29279, /quest=29280, /quest=29283 and /quest=29284 confirm
-- both 150-mark recruitments and the vendor's own 125-mark project.
local function moltenFrontOpening()
    return {
        "Quest through the original Mount Hyjal story to Aessina's Miracle. Enable Trivial Quests, then visit the Sanctuary of Malorne near 27.1,62.5. Take Guardians of Hyjal: Firelands Invasion! or its available follow-up and finish the sanctuary defense introduction.",
        "Complete the offered sanctuary dailies and spend 20 Marks of the World Tree on Calling for Reinforcements. Follow the introduction into the Molten Front through the portal near 27.6,56.3 in Hyjal. Inside, Malfurion's Breach near 47.0,90.7 is the progression hub.",
        "Complete the available Hyjal and Molten Front dailies after each reset. Spend 150 marks on Druids of the Talon and another 150 on The Shadow Wardens, finishing each recruitment's follow-up quests. Both are required before the final support projects appear. Only one of the two daily branches is run on a given day; unlocking both does not make every daily simultaneously available.",
    }
end

for _, toy in ipairs({
    {70161, "Mushroom Chair", "Filling the Moonwell", "Nourishing Waters", "Ayla Shadowstorm", 53881, 44.6, 86.2, 400},
    {70159, "Mylune's Call", "Calling the Ancients", "Aid of the Ancients", "Varlan Highbough", 53882, 44.5, 88.6, 2800},
}) do
    local itemID, name, project, followup, vendor, npcID, x, y, gold = unpack(toy)
    local steps = moltenFrontOpening()
    steps[4] = "Save a further 125 Marks of the World Tree and complete " .. project .. ". Follow its turn-in back to Matoclaw at the Sanctuary of Malorne in Hyjal, then complete " .. followup .. " in the Molten Front. Finish that follow-up rather than stopping after the currency handover. This unlocks " .. vendor .. "."
    steps[5] = "Return to " .. vendor .. " at " .. x .. "," .. y .. " inside the Molten Front. Buy " .. name .. " for the displayed gold price, listed at " .. gold .. " gold before any further applicable discount, then use it to learn the Toy Box item. The marks fund the unlock; the toy itself is a gold purchase."
    add(itemID, name, {
        category = "Vendor", source = vendor .. " in the Molten Front after " .. project, npcId = npcID,
        description = "A guaranteed vendor toy behind the Molten Front's personal daily-quest progression.",
        difficulty = "hard", difficultyReason = "Starting from scratch requires weeks of daily progression and both recruitment paths before the vendor unlock.",
        requirements = "Hyjal story through Aessina's Miracle, Molten Front access, both recruitments and " .. project,
        cost = gold .. " gold listed price; unlock spending from scratch: 20 + 150 + 150 + 125 = 445 Marks of the World Tree",
        steps = steps,
        tips = "Use the character that completed the campaign; another character's progress does not automatically unlock these vendors. After learning the toy, check its quest-use requirement on alts. Finish an active phasing quest if the expected Hyjal NPCs are missing.",
        effect = itemID == 70161 and "Places an outdoor mushroom chair, with a 5-minute cooldown."
            or "Summons woodland animals, butterflies and vegetation around the user, with a 50-minute cooldown.",
        waypoints = {
            pin(198, 27.1, 62.5, 1, "Sanctuary of Malorne - invasion introduction", "Mount Hyjal"),
            pin(198, 27.6, 56.3, 2, "Portal to Molten Front - after introduction", "Mount Hyjal"),
            pin(338, 47.0, 90.7, 3, "Malfurion's Breach - recruit both groups", "Molten Front"),
            pin(198, 27.1, 62.5, 4, "Matoclaw - support-project turn-in", "Mount Hyjal"),
            pin(338, x, y, 4, vendor .. " - finish vendor-unlock follow-up", "Molten Front"),
            pin(338, x, y, 5, vendor .. " - buy " .. name, "Molten Front"),
        },
    })
end

-- https://www.wowhead.com/item=71259#comments:id=2544616
-- /quest=29203#comments:id=1477285 and all five replies; /quest=29298
-- and /quest=29311 correct the trigger and final mailed reward.
-- /object=208790 and /object=208791 supply the two distinct grave locations.
do
    local steps = moltenFrontOpening()
    steps[4] = "Save 125 additional Marks of the World Tree for Filling the Moonwell. Turn it in to Matoclaw at the Sanctuary of Malorne, then complete Nourishing Waters with Ayla Shadowstorm in the Molten Front. Calling the Ancients and Additional Armaments are not required for this particular toy."
    steps[5] = "Take Into the Depths from Malfurion Stormrage in the tree at Malfurion's Breach, around 47.0,90.7. Follow its marker into the Igneous Depths and continue to Leyara in the central underground chamber, around 64.4,59.0 on the Molten Front map, not just the cave entrance. Fight Leyara and let the Malfurion/Hamuul event finish, then return to Malfurion to turn in the quest."
    steps[6] = "Check your mailbox for Theresa Barkskin's letter Left Behind, containing a Smoke-Stained Locket. This follows Into the Depths and Legacy of Leyara; merely reaching the Moonwell vendor is not the final trigger. Use the item to accept A Smoke-Stained Locket."
    steps[7] = "Bring the Smoke-Stained Locket to Rabine Saturna at Nighthaven in Moonglade, about 51.6,44.8. Complete A Smoke-Stained Locket and Unlocking the Secrets Within, watching the memory and taking the next quest before leaving."
    steps[8] = "For Tragedy and Family, travel to the Night Elf Grave east of Astranaar in Ashenvale at 40.5,53.3. Interact with the grave and the locket as directed, watch the complete memory, and accept The Tipping Point."
    steps[9] = "Go to the Small Gravestone at Leyara's Sorrow in Mount Hyjal, around 7.6,34.5. It is on the ground in the outer part of the shrine area. Use the quest interaction, watch the memory and take The Rest is History. This grave is in Hyjal, not inside the Molten Front."
    steps[10] = "Return through Hyjal's portal at 27.6,56.3 and turn The Rest is History in to Malfurion at Malfurion's Breach. Check the follow-up reward mail for Leyara's Locket (71259), then use that toy to learn it. The Smoke-Stained Locket quest starter and Leyara's Locket toy are separate items."
    add(71259, "Leyara's Locket", {
        category = "Quest Rewards", source = "The Rest is History, after Filling the Moonwell and Into the Depths",
        description = "A personal Molten Front campaign reward followed by a memory quest chain across three Kalimdor zones.",
        difficulty = "hard", difficultyReason = "Weeks of Molten Front dailies precede the encounter and multi-zone quest chain.",
        requirements = "Both Molten Front recruitments, Filling the Moonwell, Into the Depths and the Smoke-Stained Locket chain",
        cost = "No toy purchase; campaign unlocks from scratch spend 445 Marks of the World Tree",
        steps = steps,
        tips = "Continue the memory chain on the same character. If the starter or reward seems missing, check mail and existing quest progress before repeating unrelated dailies. Do not follow old advice to kill the friendly Moonglade quest giver to fix a launch-era bug.",
        effect = "Transforms the user into a Druid of the Flame for 10 minutes, with a 1-hour cooldown.",
        waypoints = {
            pin(198, 27.1, 62.5, 1, "Sanctuary of Malorne - invasion introduction", "Mount Hyjal"),
            pin(198, 27.6, 56.3, 2, "Portal to Molten Front", "Mount Hyjal"),
            pin(338, 47.0, 90.7, 3, "Malfurion's Breach - both recruitment unlocks", "Molten Front"),
            pin(198, 27.1, 62.5, 4, "Matoclaw - Filling the Moonwell turn-in", "Mount Hyjal"),
            pin(338, 44.6, 86.2, 4, "Ayla - complete Nourishing Waters", "Molten Front"),
            pin(338, 47.0, 90.7, 5, "Malfurion - Into the Depths and turn-in", "Molten Front"),
            pin(338, 64.4, 59.0, 5, "Leyara - UNDERGROUND in Igneous Depths", "Molten Front"),
            pin(80, 51.6, 44.8, 7, "Rabine Saturna - first memories", "Moonglade"),
            pin(63, 40.5, 53.3, 8, "Night Elf Grave - Tragedy and Family", "Ashenvale"),
            pin(198, 7.6, 34.5, 9, "Small Gravestone - The Tipping Point", "Mount Hyjal"),
            pin(198, 27.6, 56.3, 10, "Portal - return for final turn-in", "Mount Hyjal"),
            pin(338, 47.0, 90.7, 10, "Malfurion - The Rest is History", "Molten Front"),
        },
    })
end
