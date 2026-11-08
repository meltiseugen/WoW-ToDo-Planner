-- English Retail walkthroughs. Only the explicitly registered IDs are reviewed.
-- Routes are manually reconciled with the Retail Wowhead comments and replies;
-- sources below identify useful comments, not text copied into the catalogue.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.achievements = TDP.CollectionWalkthroughs.achievements or {}
local guides = TDP.CollectionWalkthroughs.achievements
local originals = TDP.PatchCatalog.achievementDetails["1.0"] or {}

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(id, name, steps, waypoints, tips, comments, category)
    local guide, lines, sources = {}, {}, {}
    -- Retain existing requirements, notes and other useful metadata. Coordinates
    -- and criterion mappings must describe this route, not its previous pins.
    for key, value in pairs(originals[id] or {}) do guide[key] = value end
    for index, text in ipairs(steps) do lines[index] = index .. ". " .. text end
    for _, comment in ipairs(comments or {}) do
        sources[#sources + 1] = type(comment) == "number"
            and ("https://www.wowhead.com/achievement=" .. id .. "#comments:id=" .. comment) or comment
    end
    guide.achievementId, guide.name = id, name
    guide.category, guide.sourceType, guide.source = category or "Dungeons", "Achievement", name
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #steps
    guide.waypoints, guide.waypointCriteria, guide.mapAchievementId = waypoints or {}, nil, nil
    guide.tips, guide.sources = tips or guide.tips, sources
    guide.reviewedAt = "2026-11-03"
    guide.wowheadUrl = "https://www.wowhead.com/achievement=" .. id
    guide.sourceURL = guide.wowheadUrl .. "#comments"
    guides[id] = guide
end

-- The achievement pages contain no profit-ending numbered dungeon guide.
-- In particular, old boss names, keys and removed floors are not Retail routes.
add(628, "Deadmines", {
    "Go to Moonbrook in Westfall, enter the mine building at 42.6, 71.8, and follow the mine passages to the dungeon portal. Set dungeon difficulty to Normal before entering.",
    "Clear Glubtok, Helix Gearbreaker and the Foe Reaper 5000. Continue through the foundry and docks, use the cannon to open the large door, and climb the Defias ship to Admiral Ripsnarl.",
    "Defeat Ripsnarl and wait for Cookie to appear from the cabin. Approach the cabin if he has not entered his cauldron, then defeat Captain Cookie. He is the Normal final boss; Edwin VanCleef and the Heroic-only Vanessa event are not this achievement's target.",
}, {pin(52,42.6,71.8,1,"Moonbrook - mine building"),pin(55,25.6,51,1,"Deadmines - portal inside the mines","The Deadmines - exterior mines")}, nil, {1687204,"https://www.wowhead.com/npc=47739/captain-cookie#comments"})

add(629, "Ragefire Chasm", {
    "Enter Orgrimmar and descend into the Cleft of Shadow. The dungeon portal is underground; the map pin uses the Cleft's own map, not outdoor Orgrimmar coordinates. Alliance characters must get past hostile city guards.",
    "Enter on Normal and follow the lava cavern through Adarogg, Dark Shaman Koranthal and Slagmaw. Continue beyond the lava worm instead of leaving after the earlier bosses.",
    "Defeat Lava Guard Gordoth in the last cavern. Old comments name Taragaman, who belonged to an earlier version; Gordoth is the current achievement target.",
}, {pin(86,52.5,57.8,1,"Ragefire Chasm - underground portal","Orgrimmar - Cleft of Shadow")}, nil, {1547564,1669016,"https://www.wowhead.com/npc=61528/lava-guard-gordoth"})

add(630, "Wailing Caverns", {
    "Enter the skull-shaped cave at 39.1, 69.6 in Northern Barrens. Follow the cave to the dungeon portal; the second pin is on the cave map. The achievement boss is summoned by an escort, not encountered during an ordinary circuit.",
    "Defeat all FOUR Fanglords: Lady Anacondra, Lord Cobrahn, Lord Pythas and Lord Serpentis. Check all four before returning to the entrance. The optional turtle Kresh and the elemental Verdan do not replace a Fanglord.",
    "Return to the Disciple of Naralex near the instance entrance, speak to him and start his escort. Stay with him and protect him through each stop until he reaches Naralex.",
    "Let each final wave come out of the water and engage the escort before killing it. If a wave stalls, check the water for a surviving nightmare creature. Defeat Mutanus the Devourer when he emerges; killing Serpentis alone does not award the achievement.",
}, {pin(10,39.1,69.6,1,"Wailing Caverns - cave entrance"),pin(11,55.2,66.1,1,"Wailing Caverns - dungeon portal","Wailing Caverns - exterior cave")}, "Do not kill newly spawning escort waves before the event registers them. Old instructions using Nat Pagle, a pet battle scenario or a full optional-boss clear are not required.", {415162,415083,1689380,1818856})

add(631, "Shadowfang Keep", {
    "Enter Shadowfang Keep at 44.8, 67.8 in Silverpine Forest on Normal difficulty. Use the keep above Pyrewood Village, not a Caverns of Time instance.",
    "Follow the keep's route through Baron Ashbury, Baron Silverlaine and Commander Springvale. Wait for the friendly NPCs to open progression doors after the associated encounters.",
    "Continue across the battlements and through Lord Walden's room to Lord Godfrey. Defeat Godfrey for credit. The old route through Rethilgore's cages to Archmage Arugal describes the removed pre-Cataclysm layout.",
}, {pin(21,44.8,67.8,1,"Shadowfang Keep - entrance")}, nil, {779018,1122278})

add(632, "Blackfathom Deeps", {
    "Go to the ruins at 14.2, 14.0 on the northwestern Ashenvale coast. Swim down through the temple's flooded entrance and follow the underwater passage to the dungeon portal near 16.5, 11.0.",
    "Follow the caverns through Ghamoo-Ra, Domina, Subjugator Kor'ul, Thruk and the Guardian of the Deep. Continue into the cultists' temple and defeat Executioner Gore and Twilight Lord Bathiel before the final sanctuary; do not leave after the early turtle or naga encounters.",
    "Defeat Aku'mai and confirm the achievement before leaving. The old four-brazier instructions in the comments describe an earlier dungeon layout; use the current encounters and opened passages rather than searching for the removed fire puzzle.",
}, {pin(63,14.2,14,1,"Blackfathom Deeps - flooded temple approach"),pin(63,16.5,11,1,"Blackfathom Deeps - portal below the ruins")}, nil, {689978,1454115,"https://www.wowhead.com/achievement=632","https://www.wowhead.com/dungeon-journal/blackfathom-deeps/twilight-lord-bathiel"})

add(633, "Stormwind Stockade", {
    "Go to the Stockade prison building beside Stormwind's canals, near 50.5, 66.5, and descend the stairs to the Normal dungeon portal. Horde can fly or approach through the canals, but the guards remain hostile.",
    "Clear the prison corridors and the encounters with Randolph Moloch and Lord Overheat. Work through the cell blocks rather than looking for an outdoor Hogger spawn.",
    "Defeat Hogger inside the Stockade. Bazil Thredd in early comments was replaced; Elwynn Forest's outdoor Hogger does not award this dungeon achievement.",
}, {pin(84,50.5,66.5,1,"Stormwind Stockade - prison entrance")}, nil, {437805,1100016,1431833})

add(634, "Gnomeregan", {
    "Go to Gnomeregan's main entrance in western Dun Morogh, descend into the underground station and reach the dungeon portal. The portal pin uses the New Tinkertown entrance map. Set Normal difficulty.",
    "Follow the instance toward the Engineering Labs and then Tinkers' Court. Use the ramps and connecting corridors shown on the dungeon map; a fall into a lower room can make the route longer.",
    "Defeat Mekgineer Thermaplugg in Tinkers' Court. The optional Workshop back door can shorten a familiar route, but is not a required key or unlock for this achievement.",
}, {pin(27,31.8,37.9,1,"Gnomeregan - surface approach"),pin(30,30.1,74.6,1,"Gnomeregan - underground portal")}, nil, {347022,427205})

add(635, "Razorfen Kraul", {
    "Enter Razorfen Kraul at about 41.0, 94.6 in Southern Barrens. This is the western bramble dungeon; Razorfen Downs across the zone border is a separate instance.",
    "Follow the raised walkways and bridges through the dungeon, continuing through the bat-filled passage toward the final elevated huts. Clear enemies at the ramps so they do not follow you around the route.",
    "Defeat Charlga Razorflank in her hut on the final ledge. The escort and side quests are optional for this boss-kill achievement.",
}, {pin(199,41,94.6,1,"Razorfen Kraul - entrance")}, nil, {986636,2076097})

add(636, "Razorfen Downs", {
    "Go to northern Thousand Needles and enter the skull-shaped cave in the Razorfen Downs brambles around 43.3,26.0. Follow the cave and take the first left toward the dungeon portal around 49.3,26.4. Do not enter Razorfen Kraul in Southern Barrens.",
    "Progress past Aarux, Mordresh Fire Eye and Mushlump, then climb the Spiral of Thorns with Koristrasza. Reach Death Speaker Blackthorn at the summit and defeat him; his death completes the ritual that brings Amnennar back. Give the encounter's dialogue and transition time to finish before leaving.",
    "Defeat the newly summoned Amnennar the Coldbringer and check the achievement. At a scaled level, stand in Koristrasza's Redeemed Soil when she calls for it to handle his Soul Leech. If an instant Blackthorn kill leaves him evading and no lich appears, move back down the path until the encounter advances, then return; a recent Retail report describes this transition workaround.",
}, {pin(64,43.3,26,1,"Razorfen Downs - skull cave entrance"),pin(64,49.3,26.4,1,"Razorfen Downs - portal inside the cave")}, "Blackthorn is the penultimate encounter, not the achievement target. Wait for Amnennar's summon and finish the lich; no dungeon quest hand-in is required.", {547549,986652,1528693,"https://www.wowhead.com/npc=74875/death-speaker-blackthorn#comments:id=6208448","https://www.wowhead.com/guide/dungeon-entrances-wow-kalimdor","https://www.wowhead.com/dungeon-journal/razorfen-downs/amnennar-the-coldbringer"})

add(637, "Scarlet Monastery", {
    "Go to the monastery complex at 82.5, 33.0 in Tirisfal Glades. In the courtyard, choose the current Scarlet Monastery portal. Scarlet Halls and the restored old Library/Armory are different destinations.",
    "Clear Thalnos the Soulrender and Brother Korloff, then enter the cathedral and defeat Commander Durand to begin the last encounter.",
    "Fight High Inquisitor Whitemane, let her resurrection sequence complete, and finish both Whitemane and the revived Durand. Check credit after the encounter finishes; the old five-boss/four-wing circuit is no longer the requirement.",
}, {pin(18,82.5,33,1,"Scarlet Monastery - complex entrance"),pin(19,69.2,24.9,1,"Scarlet Monastery - current portal","Scarlet Monastery - entrance courtyard")}, nil, {1712242,1891488,1964225})

add(638, "Uldaman", {
    "Enter the ORIGINAL Uldaman in northern Badlands. The main cave is near 41, 10; follow the excavation to its old dungeon portal. Uldaman: Legacy of Tyr is a separate Dragonflight dungeon and does not count.",
    "Proceed through the original halls toward Ironaya and the ancient vault. Activate the altar in the Hall of the Keepers and defeat the awakened guardians to open the route to Archaedas. A party of three is no longer needed for these activations.",
    "Use the altar in Archaedas's chamber to awaken him, then defeat him. Reading the Platinum Discs afterwards is optional; this guide uses the boss kill rather than an old retroactive quest credit.",
}, {pin(15,41,10,1,"Original Uldaman - excavation approach"),pin(16,36.6,29.4,1,"Original Uldaman - dungeon portal","Uldaman - exterior excavation")}, nil, {337188,409733,638045})

add(639, "Zul'Farrak", {
    "Enter Zul'Farrak at 39.2, 21.6 in northwestern Tanaris on Normal difficulty.",
    "Reach the pyramid, kill the troll at the top and open the prisoners' cages. Protect Weegli Blastfuse through the staircase waves and defeat Shadowpriest Sezz'ziz.",
    "After the event, speak to Weegli and ask him to blow open the gate to the chief. Let him finish. Do not turn the prisoners hostile and kill the goblin before the gate opens.",
    "Pass through the opened gate and defeat Chief Ukorz Sandscalp. Gahz'rilla and the old Mallet of Zul'Farrak are not requirements for this achievement.",
}, {pin(71,39.2,21.6,1,"Zul'Farrak - entrance")}, nil, {415957,1312673,2076487,2512017})

add(640, "Maraudon", {
    "Enter Maraudon's cave at 30.0, 62.5 in Desolace. At the colored fork take the purple-crystal passage, then descend left toward the inner Maraudon portal rather than crossing the bridge.",
    "Enter the Earth Song Falls section and descend the waterfall. Follow the path southeast out of the waterfall area, climb the ramps toward Zaetar's Grave, and keep to the path instead of dropping off ledges.",
    "Cross the final long bridge to Princess Theradras and defeat her. If a suitable Dungeon Finder queue offers Maraudon - Earth Song Falls, that is the section containing her. You do not need the old Scepter of Celebras.",
}, {pin(66,30,62.5,1,"Maraudon - Valley of Spears cave"),pin(66,35.7,55.5,1,"Maraudon - entrance complex")}, "Plan a way out after the one-way waterfall drop, such as your Hearthstone or the Dungeon Finder teleport if you queued.", {705277,1261006,1321815,1675685})

add(641, "Sunken Temple", {
    "Go to the Temple of Atal'Hakkar in the lake in Swamp of Sorrows, near 69, 54. Descend through the submerged temple entrance and follow the passage to the dungeon portal.",
    "Use the CURRENT single-floor Sunken Temple. Clear the troll packs leading to Jammal'an the Prophet and Ogom in the eastern room and defeat them. Clear the dragon encounters on the main route as they become available: Dreamscythe, Weaver, Hazzas and Morphaz. Continue through their rooms toward the southern sanctuary instead of looking for an old basement route.",
    "Continue through the southern rooms and defeat Shade of Eranikus. The six upper-ring channelers and the lower-floor statue puzzle described by old comments belong to the removed multi-floor version and are not a Retail route.",
}, {pin(51,69,54,1,"Sunken Temple - submerged temple approach"),pin(51,76,45.2,1,"Sunken Temple - dungeon portal")}, "Follow the main floor's troll and dragon wings to Eranikus. The old six-balcony-boss circuit and basement statue puzzle do not belong to the current dungeon.", {413782,5466691})

add(642, "Blackrock Depths", {
    "Enter Blackrock Mountain and descend to the Blackrock Depths dungeon portal. Use the original Normal dungeon, not the anniversary raid version. The old Shadowforge Key is not required.",
    "Use the Abandoned Mole Machine at the entrance to travel to Just Past the Grim Guzzler if that option is available. Otherwise progress through Shadowforge City to the bar. Buy SIX Dark Iron Ale Mugs from Plugger Spazzring and give them to Private Rocknot through three two-mug hand-ins. Let him break the barrels, then kill the hostile Phalanx at the opened rear door. Buy the ale BEFORE attacking the bar's vendor.",
    "Continue through Ambassador Flamelash and the Summoners' Tomb. Speak to Doom'rel to start the Seven encounter and defeat the successive dwarves to open the next door.",
    "In the Lyceum, kill Shadowforge Flame Keepers, loot their torches and light BOTH braziers. Proceed through Magmus to the throne room, then defeat Emperor Dagran Thaurissan. Stop only after the emperor criterion credits.",
}, {pin(35,39.1,18.1,1,"Blackrock Depths - original dungeon portal","Blackrock Mountain - lower chamber"),pin(243,50.4,58.8,2,"Grim Guzzler - buy six ale mugs from Plugger"),pin(243,50.8,60.8,2,"Private Rocknot - three two-mug hand-ins")}, "The mole machine skips travel, not the Lyceum braziers or the final emperor kill. If using the bar route, wait for Rocknot's barrel event to open the door before fighting Phalanx.", {437662,737817,1947955,"https://www.wowhead.com/npc=9503/private-rocknot#comments:id=90510"})

add(643, "Lower Blackrock Spire", {
    "Enter Blackrock Mountain, climb to the Blackrock Spire entrance on the upper balcony and choose the LOWER Blackrock Spire dungeon. The Warlords Upper Blackrock Spire portal is a different instance.",
    "Follow the lower route through the ogre and troll areas, then climb through the orc barracks and connecting ramps. Continue beyond the side bosses to the last large chamber.",
    "Defeat Overlord Wyrmthalak. General Drakkisath, the Seal of Ascension and the old Upper Spire flame event are not required for this Lower Spire achievement.",
}, {pin(33,80.5,40.7,1,"Lower Blackrock Spire - upper balcony portal","Blackrock Mountain - upper chamber")}, nil, {337181,701477,1067878})

add(644, "King of Dire Maul", {
    "Travel to Dire Maul in Feralas. There are THREE separate wings, each with a required boss. Use the map selector to choose East, West or North; a clear of only one wing cannot complete the achievement.",
    "EAST / Warpwood Quarter, around 64, 30: defeat Zevrim Thornhoof, return to Ironbark in the courtyard and ask him to open the door. Follow the newly opened corridor and defeat Alzzin the Wildshaper.",
    "WEST / Capital Gardens, around 60, 30: disable all FIVE pylons by killing their surrounding elementals. There is one near the entrance, two upstairs in the Court of the Highborne and two beside Immol'thar's prison. Once the barrier falls, defeat Immol'thar.",
    "NORTH / Gordok Commons, around 62, 24: follow the corridors and ramps to King Gordok and defeat him. The old Gordok door key is no longer required. A tribute run, Ogre Suit and trap materials are optional, not achievement conditions.",
    "Check that Alzzin, Immol'thar and King Gordok are all credited. You can leave one wing and enter another normally; the old reports of criteria resetting describe a fixed bug.",
}, {pin(69,64,30,2,"Dire Maul East - Alzzin route"),pin(69,60,30,3,"Dire Maul West - five pylons / Immol'thar"),pin(69,62,24,4,"Dire Maul North - King Gordok")}, "Ironbark only opens the East wing's door after Zevrim dies. A reply also corrects the old North-wing key requirement: the door now opens without it.", {537188,2541633})

add(645, "Scholomance", {
    "Go to Caer Darrow in Western Plaguelands and enter the current Scholomance at 69.1, 73.0 on Normal difficulty. The achievement does not require unlocking restored Old Scholomance or obtaining a Skeleton Key.",
    "Clear Instructor Chillheart, Jandice Barov and Rattlegore, then continue through Lilian Voss's encounter. Wait for encounter dialogue or doors before moving to the next room.",
    "Reach Headmaster's Retreat and defeat Darkmaster Gandling. If he sends you into a study room, kill its enemies and return to the main chamber. The six mini-bosses and Viewing Room Key in old comments describe Old Scholomance, not this route.",
}, {pin(22,69.1,73,1,"Scholomance - current dungeon entrance")}, nil, {779957,1209776,1713238,"https://www.wowhead.com/npc=59080/darkmaster-gandling"})

add(646, "Stratholme", {
    "Go to northern Eastern Plaguelands. This achievement requires the final boss in BOTH halves of present-day Stratholme. Set Normal difficulty; the Caverns of Time Culling of Stratholme is unrelated.",
    "Use the MAIN entrance near 27, 12 for the living/Crusader's Square side. Clear the Scarlet rooms to Balnazzar, allow the final encounter to finish and confirm his criterion.",
    "Leave and enter the SERVICE entrance at Eastwall Gate near 43.3, 19.7. Kill Baroness Anastari, Nerub'enkan and Maleki the Pallid, and clear the acolytes inside all three opened ziggurats to remove the gate barrier.",
    "Clear the abominations in Slaughter Square, kill Ramstein, then wait for and defeat the remaining undead waves and Black Guard. Enter the slaughterhouse and kill Lord Aurius Rivendare. Confirm both bosses are credited before leaving.",
}, {pin(23,27.1,11.6,2,"Stratholme MAIN entrance - Balnazzar"),pin(23,43.3,19.7,3,"Stratholme SERVICE entrance - Rivendare")}, "No Key to the City is required. Comments reporting that the first boss resets after changing halves describe a bug fixed in 6.1.", {612586,1258518,1472011,2076767,2122718})

add(685, "Blackwing Lair", {
    "Enter Blackrock Mountain and reach the Orb of Command beside the Blackrock Spire approach, around 64.2, 71.0 on the upper mountain map. Use the orb for Blackwing Lair. Blackwing Descent on the mountain's exterior summit is a different raid.",
    "At Razorgore, clear the enemies around the Orb of Domination and use it to control him. Use his Destroy Egg ability on EVERY egg while keeping him alive. Reapply control as needed; killing Razorgore before the eggs are destroyed wipes the encounter.",
    "Once the eggs are gone, defeat Razorgore and progress through Vaelastrasz, the suppression rooms, Broodlord, the three drakes and Chromaggus. Open progression doors using the encounter's switch or dialogue when necessary.",
    "Speak to Victor Nefarius in the last room, kill the drakonid waves and wait for Nefarian to land. Defeat Nefarian and confirm the Blackwing Lair achievement. An Onyxia attunement or a kill in Blackwing Descent does not substitute for this clear.",
}, {pin(33,64.2,71,1,"Blackwing Lair - Orb of Command","Blackrock Mountain - upper chamber")}, nil, {1868017,1949498,1980791,2483576}, "Raids")

add(686, "Molten Core", {
    "Enter Blackrock Mountain and descend to Lothos Riftwaker near 54.2, 83.3. Speak to him to enter Molten Core. Use the original raid; Firelands and anniversary versions do not replace its Ragnaros kill.",
    "Clear the raid's earlier bosses and their required packs so Majordomo Executus can appear. Kill the Core Hound packs together so survivors do not resurrect the others. You do not need to obtain Aqual or Eternal Quintessence to douse runes.",
    "Defeat Majordomo's guards until he surrenders, then speak to him and follow him to Ragnaros. Speak again to start the summoning and wait through the event.",
    "Defeat Ragnaros in Molten Core. The achievement is for the boss kill, not looting his head, owning an old item or killing the later Firelands version.",
}, {pin(33,54.2,83.3,1,"Lothos Riftwaker - Molten Core access","Blackrock Mountain - lower approach")}, nil, {1374290,2224638}, "Raids")

add(687, "Temple of Ahn'Qiraj", {
    "Go through the open Scarab Wall in southern Silithus to Ahn'Qiraj: The Fallen Kingdom. Enter the TEMPLE portal near 46.8, 7.5; the other portal leads to the Ruins.",
    "Defeat the Prophet Skeram and follow the main route through the raid. At the Twin Emperors, keep progressing only after both emperors are defeated; choose attacks the targeted emperor is not immune to.",
    "Continue through the cleared passages to C'Thun and defeat his eye and body phases. If drawn into the stomach, kill the flesh tentacles to weaken him, then use the exit to return and finish the body.",
    "Check the C'Thun criterion after the encounter. The old Onyxia and Zul'Gurub raids are not prerequisites for this clear.",
}, {pin(327,46.8,7.5,1,"Temple of Ahn'Qiraj - C'Thun raid portal")}, nil, {337186,419297,6259970}, "Raids")

add(689, "Ruins of Ahn'Qiraj", {
    "Pass through the Scarab Wall in southern Silithus and enter the RUINS portal at 58.9, 14.3 in Ahn'Qiraj: The Fallen Kingdom. Do not take the Temple portal for C'Thun.",
    "Defeat Kurinnaxx. Follow the path past the General Rajaxx courtyard; if you start his event, clear its waves and Rajaxx before continuing. Take the route toward the large stairway into Ossirian's arena.",
    "Clear the arena's nearby enemies, engage Ossirian the Unscarred and defeat him. If his Strength buff prevents a comfortable kill, lead him beside a crystal and activate it to weaken him, then attack using a school he is vulnerable to.",
    "Confirm the boss kill. Looting or turning in the Head of Ossirian is optional; the achievement does not require winning a shared quest-item roll.",
}, {pin(327,58.9,14.3,1,"Ruins of Ahn'Qiraj - Ossirian raid portal")}, nil, {337185,420761,1350394}, "Raids")

for _, milestone in ipairs({{121,"Journeyman Cook",150,1962161},{122,"Expert Cook",225,1962162},{123,"Classic Cook",300,684025}}) do
    add(milestone[1],milestone[2],{
        "Learn Classic Cooking from Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6). Open the profession window and select the Classic category.",
        "Cook orange or yellow CLASSIC recipes until Classic Cooking reaches " .. milestone[3] .. ". Learn the next trainer recipes before the current ones turn gray; gather or buy their ingredients and cook beside a cooking fire.",
        "At the target, check this achievement and the Classic skill bar. Points from Pandaria or another expansion do not count. Old comments about Sungshin Ironpaw raising a single shared Cooking bar predate the expansion skill split.",
    },{pin(84,76.8,53.6,1,"Stephen Ryback - Alliance Classic Cooking"),pin(85,32.2,69.6,1,"Zamja - Horde Classic Cooking")},"You do not need the removed Artisan Cooking quest or a trip to Gadgetzan just to unlock this skill range.",{milestone[4]},"Professions")
end
for _, milestone in ipairs({{126,"Journeyman Fisherman",150,440620},{127,"Expert Fisherman",225,2195281},{128,"Artisan Fisherman",300,785515}}) do
    add(milestone[1],milestone[2],{
        "Learn Classic Fishing from Arnold Leland in Stormwind (55.0, 69.6) or Lumak in Orgrimmar (66.6, 41.6). Select the Classic Fishing skill bar to track your progress.",
        "Fish in Classic waters, such as your capital's water beside the trainer. Cast into open water, wait for a bite, click the bobber and loot the catch. Continue until your base Classic Fishing reaches " .. milestone[3] .. ".",
        "Keep fishing when several catches give no point: gains become less frequent as skill rises. A fishing pole or lure's bonus is not permanent skill. Outland and later expansion fishing points do not advance the Classic bar.",
    },{pin(84,55,69.6,1,"Arnold Leland - Alliance Fishing / canals"),pin(85,66.6,41.6,1,"Lumak - Horde Fishing / Valley of Honor")},"Old Expert Fishing books and Nat Pagle's Artisan unlock quest are not required in Retail.",{milestone[4]},"Fishing")
end
for _, milestone in ipairs({{116,"Professional Journeyman",150,1653833},{731,"Professional Expert",225,1375908},{732,"Professional Classic Master",300,1375909}}) do
    add(milestone[1],milestone[2],{
        "Choose a primary profession. In Stormwind or Orgrimmar, ask a city guard for that profession's trainer and follow the guard's marker to learn its CLASSIC skill. Cooking, Fishing and an expansion-specific profession category are not substitutes for a primary Classic profession.",
        "Open that profession's Classic category. Craft orange/yellow recipes, or gather Classic herbs, ore or skins with the corresponding gathering profession, until its base Classic skill reaches " .. milestone[3] .. ".",
        "Learn higher recipes or move to appropriate Classic materials as your current actions turn gray. Verify the achievement when the base skill reaches the target; racial or equipment bonuses may display extra skill without satisfying the earned-points requirement.",
    },{},"The map menu includes the two main capitals. Ask a guard for the profession you chose; trainer locations and required materials depend on that choice.",{milestone[4]},"Professions")
    guides[milestone[1]].areaMaps = {84,85}
end

-- Battleground-wide objectives have a real instance map but no single world
-- waypoint. Do not substitute the outdoor queue cave or an arbitrary flag pin.
local function battleground(id, name, mapID, steps, tips, comments)
    add(id,name,steps,{},tips,comments,"PvP")
    guides[id].areaMaps = {mapID}
end
local abQueue = "Queue for a regular Arathi Basin match through the PvP interface. Track the achievement before the gates open; assault and defend are different actions recorded on the scoreboard."
battleground(73,"Disgracin' The Basin",1366,{
    abQueue,
    "Personally click three neutral or enemy-owned flags in ONE match and finish each uninterrupted channel. Protect the flag clicker if helping a friend, but take your own three assaults for your achievement.",
    "An assault starts a contested capture timer. Instantly restoring a flag your team already owned is a DEFEND and does not replace one of the three assaults. Recheck the counter before the match ends.",
},nil,{432414,1960915,6063763})
battleground(154,"Arathi Basin Victory",1366,{
    abQueue,
    "Capture and hold a majority of bases: keep defenders at your flags and move reinforcements to incoming attacks. Fighting on the road without protecting a flag does not generate resources.",
    "Stay until your team wins and the results screen appears. A single completed victory awards this achievement; continue the same activity for the 100-win Veteran achievement.",
},nil,{1350297,1636369})
battleground(155,"Arathi Basin Veteran",1366,{
    abQueue,
    "Win matches by holding bases, protecting flag channels and calling incoming enemies. Stay through each result so its victory is recorded.",
    "Repeat until the achievement counter reaches 100 victories. Losses and personal flag caps do not count as wins. Track the live counter on the character you are using rather than assuming old account statistics match it.",
},"Comments also report victory credit from the former Comp Stomp. Its special-mode rules are not the same as the assault/defend achievements.",{584290,2875721,5238053})
battleground(156,"Territorial Dominance",1366,{
    abQueue,
    "Coordinate a five-base capture: Stables, Farm, Blacksmith, Lumber Mill and Gold Mine must all be fully under your team's control. A contested flag is not full ownership.",
    "Finish the match with all FIVE bases controlled at the moment your team wins. A five-cap earlier in the match is insufficient if an enemy retakes a flag before the result.",
    "Repeat this result for 10 qualifying victories. You can establish the five-cap late in a match; it does not have to last from the opening gates.",
},nil,{627432,2877786,3175728})
battleground(157,"To The Rescue!",1366,{
    abQueue,
    "Watch a base your team fully owns. When an enemy assaults it, return immediately while its flag is still contested. Clear or control the enemies who can interrupt your channel.",
    "Personally finish the flag channel BEFORE the enemy capture timer ends. The flag must instantly return to your team; if the enemy already fully captured it, your click is an assault instead of a defend.",
    "Repeat until your counter reaches 50 defenses across matches. Rotate toward newly assaulted nearby flags while working on the 100-win grind, and check the scoreboard's defenses column after each return.",
},"Old Comp Stomp did not credit this action, but a 2026 comment confirms the new Training Grounds does. Use regular Arathi Basin if you are unsure which version is in the queue.",{1107888,1756759,1872030,3213292,6314527})
battleground(158,"Me and the Cappin' Makin' It Happen",1366,{
    abQueue,
    "Personally finish flag channels on neutral or fully enemy-owned bases. An opening Farm/Stables assault is a useful first credit; afterwards follow attacks on lightly defended enemy flags.",
    "Use control on the remaining defender and ask teammates to protect your channel. Making the flag contested is enough; it does not need to stay yours through the following capture timer.",
    "Repeat for 50 assaults. Defenses, kills beside a flag and merely being near someone else's channel are not a substitute for your own scoreboard assaults.",
},"A 2026 comment confirms Training Grounds credit, distinguishing it from the former Comp Stomp restrictions.",{1697077,1982801,3175521,6266016})
battleground(159,"Let's Get This Done",1366,{
    abQueue,
    "Agree on routes before the match starts. Split between the near flag, Gold Mine, Lumber Mill and Blacksmith, with a fast group putting the enemy's near flag into contention.",
    "Secure all five bases quickly, then leave defenders and rotate reinforcements instead of chasing kills. A five-cap accelerates scoring enough for the six-minute target.",
    "Win within six minutes of the actual match start. Being present for only the last six minutes of a longer match is not the condition.",
},nil,{337413,517364,1969077})
battleground(161,"Resilient Victory",1366,{
    abQueue,
    "Before attempting a planned comeback, explain the achievement and get the team cooperating. Your team must be behind by AT LEAST 500 resources at some point; a close match or merely losing a base is insufficient.",
    "Once that deficit has actually occurred, attack several bases together. Aim to hold four or five, interrupt enemy flag channels and leave defenders so the comeback is not undone by recaptures.",
    "Keep controlling the resource race until your team WINS that same match. Recovering the deficit and then losing does not award it. Do not wait until the enemy is nearly at the winning score to begin the comeback.",
},"Recent comments confirm former Comp Stomp credit. Do not follow old instructions to queue a 15-player party: later replies report a five-player party limit.",{906547,1110044,2267480,3143656,5796590,6107024,6107375})
battleground(162,"We Had It All Along *cough*",1366,{
    abQueue,
    "Coordinate a close-score attempt with the team. A workable starting plan is two fully held bases per side while the fifth stays neutral; defend your two flags and prevent the unused flag from being captured.",
    "Watch the actual resource gap and node ownership. You need to be slightly ahead and WIN by 50 points or less. If the gap is wrong, a brief change in contested/owned bases can adjust scoring, but every unplanned cap changes the result.",
    "Maintain the qualifying narrow lead through the final scoring tick. A loss or draw does not count. Old 2000/1990 and 1600/1590 examples use earlier score caps and a stricter old ten-point requirement.",
},"The team needs to cooperate throughout the match; this is not guaranteed by a fixed stopwatch formula. The mapped area is the battleground itself.",{1373917,1452328,3281036,5317555})
battleground(165,"Arathi Basin Perfection",1366,{
    abQueue,
    "Send players to every base at the opening, including a fast group to interrupt the enemy's first Farm/Stables capture. Their resource total must remain ZERO for the whole match.",
    "Fully capture all five bases, keep a defender at each flag and rotate to incoming attackers. An enemy flag that is merely contested has not generated points yet, so interrupt or retake it before full ownership.",
    "Win with the opposing team still on zero resources. Even a single scoring tick fails the shutout. Old comments referring to 2000 or 1600 points predate the current 1500-point criterion.",
},nil,{1513293,1973492,2187677,3143566})
battleground(1153,"Overly Defensive",1366,{
    abQueue,
    "Watch the map for a flag your team owned that the enemy has just assaulted. Reach it during the contested timer, clear/control the attackers and personally channel the recapture.",
    "The flag must instantly return to your team for a defense. A neutral opening flag or fully enemy-owned flag is an assault. Finish THREE defenses in the SAME match; partial progress does not carry into the next battle.",
},"Regular Arathi Basin is the documented route. Old Comp Stomp and Arathi Blizzard reports do not show reliable credit.",{432409,795078,2857769,3175054})
battleground(583,"Arathi Basin All-Star",1366,{
    abQueue,
    "Get two personal assaults by clicking neutral or fully enemy-owned flags and completing the channel. Taking the opening near flag is a useful first assault.",
    "Get two personal defenses by restoring your team's assaulted flags BEFORE the enemy finishes converting them. Control or kill the enemies interrupting your channel; help from friends makes this much easier.",
    "Finish both pairs in ONE match and check the scoreboard for at least two assaults and two defenses. Progress resets between games, and clicking a fully converted flag is not a defense.",
},"Use regular Arathi Basin. Detailed comments report no credit in former Comp Stomp or Arathi Blizzard even with the required scoreboard actions.",{774145,840830,901048,5395672,6001002})
battleground(584,"Arathi Basin Assassin",1366,{
    abQueue,
    "Fight close to the actual bases and receive five honorable kills at EACH: Stables, Farm, Blacksmith, Lumber Mill and Gold Mine. Assist teammates; five solo killing blows per base are not required.",
    "Check the five criteria during the match, then rotate to whichever base is still missing its kills. Gold Mine can be easy to overlook if you spend the match near Blacksmith.",
    "Complete every location in the SAME match. Do not rely on old reports about saving progress by switching queues or standing at Blacksmith with maximum view distance.",
},"A 2026 comment reports that the new Training Grounds credits this, unlike former Comp Stomp.",{496674,582256,1351161,1606053,6266025})
battleground(1169,"Master of Arathi Basin",1366,{
    "Open this achievement's current checklist. Work on its listed Arathi Basin achievements; the old Exalted reputation requirement was removed.",
    "While building 100 victories, collect the personal assault and defense totals. In longer matches, pursue Disgracin' The Basin, Overly Defensive, All-Star and Assassin; their single-match counters must finish before that battle ends.",
    "Plan separate team attempts for the 500-resource comeback, the close-score victory, the six-minute win and the zero-point shutout. They have conflicting score objectives, so do not try to force every condition into one game.",
    "Reopen the meta and finish whichever CURRENT criteria remain unchecked. Use the individual guide for its exact condition and special-mode restrictions.",
},nil,{927475})

local wsgQueue = "Queue for regular Warsong Gulch and track this achievement before the gates open. The map shows Warsong Gulch itself; Twin Peaks and other flag battlegrounds are different matches."
battleground(166,"Warsong Gulch Victory",1339,{
    wsgQueue,
    "Escort your carrier from the enemy flag room back to your base, while teammates recover your own flag. Your flag must be home for your carrier to score.",
    "Win the match and stay for the result. Three captures finish an ordinary match; if it reaches the time limit, make sure the game's result is a victory for your side.",
},nil,{444434})
battleground(167,"Warsong Gulch Veteran",1339,{
    wsgQueue,
    "Queue with teammates who will escort carriers, call the enemy carrier's route and focus their healers. Recover your own flag so your carrier can score; kills alone do not win Warsong Gulch.",
    "Stay until each match's result, and repeat until this achievement records 100 victories. Track its counter rather than adding wins from different characters' older statistics yourself.",
},nil,{1958176,1982792})
battleground(168,"Warsong Gulch Perfection",1339,{
    wsgQueue,
    "Arrange a carrier and escort, plus defenders who recover your flag. Protect the home flag whenever the enemy attacks; a single enemy capture spoils the shutout.",
    "Capture the enemy flag three times and finish with a 3-0 WIN. A shorter time-limit victory with fewer than three captures is not the required score.",
},nil,{711033,1088734})
battleground(199,"Capture the Flag",1339,{
    wsgQueue,
    "Reach the enemy flag room and personally pick up their flag. Return across the field with an escort, using available movement abilities that do not cause the flag to drop.",
    "Bring the enemy flag onto your own flag's position while your flag is HOME. If an enemy has it, wait safely while your team recovers it, then score. Escorting someone else or returning your own flag does not count as your personal capture.",
},nil,{414671,840302})
battleground(200,"Persistent Defender",1339,{
    wsgQueue,
    "Follow enemies carrying your team's flag and help defeat them. When your flag drops on the ground, right-click it immediately to RETURN it.",
    "Repeat until your personal return counter reaches 50. An honorable kill on the carrier is not enough by itself, and a teammate clicking the dropped flag gets the return instead of you.",
},nil,{1804146,3216908})
battleground(201,"Warsong Expedience",1339,{
    wsgQueue,
    "Arrange quick carriers and an escort while a separate group recovers your home flag immediately. A second runner can wait near the enemy flag position for the next flag spawn while the first returns.",
    "Score three captures and WIN in under seven minutes from the match start. Long carrier standoffs consume the timer, so prioritize killing the enemy carrier and returning your flag over midfield fighting.",
    "Be present from the start for the timed attempt. Do not use your own arrival time in a match already in progress to judge the seven-minute condition.",
},nil,{432393,827608,1244478})
for _, home in ipairs({{203,"Warsong",1982264},{1251,"Silverwing",646529}}) do
    battleground(home[1],"Not In My House",1339,{
        wsgQueue,
        "Defend your team's " .. home[2] .. " flag room with a small group. When an enemy picks up your flag, slow/stun them and focus their healer so they cannot escape.",
        "Receive credit for TWO enemy flag carriers killed before they leave that flag room, in ONE match. Keep the victims on the room's actual floor; the adjacent tunnel and side passage do not count as being inside.",
    },"The old ten-kill requirement was reduced to two. Follow the current criterion rather than old screenshots.",{home[3]})
end
for _, defender in ipairs({{206,1913302},{1252,1156286}}) do
    battleground(defender[1],"Supreme Defender",1339,{
        wsgQueue,
        "Find the enemy carrying your team's flag, call their route and help your team defeat them. Stay in range to receive the honorable kill.",
        "Repeat until the achievement records 100 enemy flag-carrier kills. You do not need every killing blow. Returning the dropped flag can also advance Persistent Defender, but returns and carrier kills are separate counters.",
    },nil,{defender[2]})
end
battleground(1259,"Not So Fast",1339,{
    wsgQueue,
    "Watch an enemy collect the speed-boost pickup in a tunnel. You need the enemy to still have THAT battleground speed buff when they die; an ordinary class sprint is not the same condition.",
    "Slow, root or stun them and help kill them before the speed buff expires. Receiving the honorable kill is sufficient according to the comments; a solo killing blow is unnecessary.",
},"This is not required by Master of Warsong Gulch. Old bug reports predate the later confirmation that Warsong credit was fixed.",{437433,606681,771322,807285})

-- Interior positions come from the Retail Dungeon Journal, not coordinates
-- projected onto the outdoor entrance map. Steps match the guides above.
-- https://wago.tools/db2/JournalEncounter/csv
-- https://wago.tools/db2/UiMap/csv
local encounterPins = {
    [628]={pin(292,60.48,45.51,3,"Captain Cookie - ship deck")},
    [629]={pin(213,34.29,81.69,3,"Lava Guard Gordoth - final cavern")},
    [630]={pin(279,34.56,13.73,4,"Mutanus - finish the Naralex escort here")},
    [631]={pin(315,68.46,33.53,3,"Lord Godfrey - final encounter")},
    [632]={pin(222,85.52,86.42,3,"Aku'mai - final sanctuary")},
    [634]={pin(229,31.15,30.33,3,"Mekgineer Thermaplugg - Tinkers' Court")},
    [635]={pin(301,21.96,31.17,3,"Charlga Razorflank - final ledge")},
    [636]={pin(300,43.01,62.72,2,"Death Speaker Blackthorn - ritual"),pin(300,45.51,58.23,3,"Amnennar the Coldbringer - summit")},
    [637]={pin(436,49.10,80.42,3,"Whitemane / Durand - cathedral")},
    [638]={pin(231,55.33,50.41,3,"Archaedas - activate the altar")},
    [639]={pin(219,42.21,32.99,4,"Chief Ukorz - beyond the opened gate")},
    [640]={pin(281,25.82,78.89,3,"Princess Theradras - Zaetar's Grave")},
    [641]={pin(220,76.09,45.90,2,"Jammal'an and Ogom"),pin(220,67.08,87.70,3,"Shade of Eranikus")},
    [642]={pin(243,53.83,48.57,3,"Ambassador Flamelash"),pin(243,53.83,24.80,3,"The Seven - start the event"),pin(243,79.64,11.89,4,"Magmus - beyond the Lyceum"),pin(243,90.98,11.89,4,"Emperor Dagran Thaurissan")},
    [643]={pin(255,57.51,60.04,3,"Overlord Wyrmthalak")},
    [644]={pin(240,57.51,74.39,2,"Zevrim - kill before talking to Ironbark"),pin(240,56.69,28.89,2,"Alzzin - Dire Maul East"),pin(238,34.97,57.58,3,"Immol'thar - disable five pylons"),pin(235,31.95,22.95,4,"King Gordok - Dire Maul North")},
    [645]={pin(479,50.11,32.62,3,"Darkmaster Gandling - current Scholomance")},
    [646]={pin(317,20.49,81.80,2,"Balnazzar - MAIN entrance side"),pin(318,74.59,46.93,3,"Anastari / ziggurat"),pin(318,57.24,46.11,3,"Nerub'enkan / ziggurat"),pin(318,67.49,22.75,3,"Maleki / ziggurat"),pin(318,45.63,19.88,4,"Ramstein - clear the square first"),pin(318,38.66,20.08,4,"Lord Aurius Rivendare - slaughterhouse")},
    [685]={pin(287,41.93,60.24,2,"Razorgore - control him to destroy eggs"),pin(290,70.37,72.46,4,"Nefarian - finish waves and landing")},
    [686]={pin(232,56.23,53.40,4,"Ragnaros - original Molten Core")},
    [687]={pin(321,57.07,62.51,3,"C'Thun - final chamber")},
    [689]={pin(247,42.91,69.59,3,"Ossirian - crystal arena")},
}
for id, points in pairs(encounterPins) do
    for _, point in ipairs(points) do guides[id].waypoints[#guides[id].waypoints + 1] = point end
    guides[id].sources[#guides[id].sources + 1] = "https://wago.tools/db2/JournalEncounter/csv"
end

local floorNames = {
    [213]="Ragefire Chasm",[222]="Blackfathom Deeps - final sanctuary",
    [229]="Gnomeregan - Tinkers' Court",[231]="Uldaman - Archaedas's chamber",
    [235]="Dire Maul North - Gordok Commons",[238]="Dire Maul West - Immol'thar's prison",
    [240]="Dire Maul East - Warpwood Quarter",[243]="Blackrock Depths - upper city",
    [255]="Lower Blackrock Spire - lower halls",[281]="Maraudon - Earth Song Falls",
    [287]="Blackwing Lair - Razorgore's room",[290]="Blackwing Lair - Nefarian's lair",
    [292]="Deadmines - Ironclad Cove",[315]="Shadowfang Keep - Godfrey's chamber",
    [317]="Stratholme - Main Gate / Balnazzar",[318]="Stratholme - Service Entrance / Rivendare",
    [436]="Scarlet Monastery - cathedral",[479]="Scholomance - Headmaster's Retreat",
}
for id in pairs(encounterPins) do
    for _, point in ipairs(guides[id].waypoints) do point.mapName = point.mapName or floorNames[point.mapID] end
end

for _, quick in ipairs({{202,1152866,3224626},{1502,412338,2566073}}) do
    battleground(quick[1],"Quick Cap",1339,{
        wsgQueue,
        "Ask defenders to keep your own flag HOME and an escort to clear the crossing. Personally take the enemy flag from its room, starting the 75-second timer shown when tracking the achievement.",
        "Run down the enemy tunnel, use its speed pickup if available, cross directly toward your tunnel, then use the second tunnel pickup. Use your current flag-compatible movement and snare breaks; detours and carrier standoffs waste the timer.",
        "Score at your own flag within 75 seconds. Merely reaching your flag room before the timer ends is insufficient if your flag is still held by an enemy. A late hand-off near the scoring spot is not a reliable substitute for the timed full run.",
    },"Use regular Warsong Gulch. Comments report no Quick Cap credit in Warsong Scramble or Deep Six. Old Nifty Stopwatch/Skull of Impending Doom advice can make you drop the flag; removed talents and legendaries are not part of this route.",{quick[2],quick[3]})
end
battleground(204,"Ironman",1339,{
    wsgQueue,
    "Before attempting the run, ask teammates to help you score all three flags, with a healer/escort protecting you and others recovering your home flag. Avoid dying from the start of the match.",
    "Carry or receive the first enemy flag and personally score it at your base. Survive the return trip to the enemy base and repeat for the second capture.",
    "Personally score the THIRD flag in that same match without a death anywhere in the match. A teammate may carry a flag across the field and hand it to you to score; the three personal captures and your survival are what matter.",
    "Check the scoreboard for three captures and zero deaths. Running a flag without scoring, returning your own flag, or getting only a time-limit win does not complete Ironman.",
},"Use regular Warsong Gulch; the three-flag Warsong Scramble brawl has repeated reports of no credit. Do not sacrifice survival by outrunning your escort just to attempt Quick Cap at the same time.",{420629,431863,488776,1345717,1683908,2492753,3157111})
battleground(207,"Save the Day",1339,{
    wsgQueue,
    "Follow the enemy carrier of YOUR flag toward THEIR flag room with teammates. Their own flag must be home, under their control, when the carrier dies.",
    "Stop the carrier inside the main flag room before they can score: use slows, stuns and focused damage. Remove or control their healer and be ready for movement abilities toward the scoring spot.",
    "Kill the carrier while the enemy's own flag is still at its base. Receive the honorable kill; a solo killing blow is not required. If a teammate is carrying their flag, that prevents the required condition until it is returned.",
},"The profit-ending comment outlines coordinating the flag state, but combines its final kill and profit in one bullet. The actual kill is retained here. Do not confuse this with killing a carrier in YOUR room for Not In My House.",{409277,566027,863799,1091059,1241883,1466578})
battleground(872,"Frenzied Defender",1339,{
    wsgQueue,
    "Help defeat enemies carrying your team's flag, then personally right-click the dropped flag to return it. Stay near the carrier so you can reach the flag immediately.",
    "Repeat for FIVE personal returns in ONE match. The carrier's death alone is not a return, and a teammate who clicks the flag first receives the return credit.",
    "Watch your return counter during the match. Five captures of the enemy flag, or five returns accumulated across separate matches, are different conditions.",
},"Comments also report Warsong Scramble credit for this specific return achievement; that does not imply that Ironman or Quick Cap works there.",{393853,1535140,2492321,3172237})
battleground(1172,"Master of Warsong Gulch",1339,{
    "Track this meta's current criteria and queue for regular Warsong Gulch. The Silverwing/Warsong Exalted reputation achievement is no longer a requirement for this meta.",
    "While building 100 victories, work on the lifetime flag returns and carrier kills. In suitable matches, defend your room for Not In My House and stop a carrier in their own room for Save the Day.",
    "Plan separate attempts for five returns in one match, three personal captures without dying, the 75-second Quick Cap and the seven-minute team win. Ask teammates which attempt you are working on so they can protect the appropriate flag or carrier.",
    "Finish every achievement actually listed by the meta. Not So Fast is an additional Warsong achievement, not an extra condition to add to the meta checklist.",
},nil,{1809149,"https://www.wowhead.com/achievement=713#comments:id=1639858","https://www.wowhead.com/achievement=1259#comments:id=771322"})

local avQueue = "Queue for Alterac Valley through the PvP interface's Epic Battlegrounds or available specific queue. Track the achievement inside the battleground; the outdoor Alterac caves are not where its objectives happen."
for _, victory in ipairs({{218,"Alterac Valley Victory",1,1018068},{219,"Alterac Valley Veteran",100,1900105}}) do
    battleground(victory[1],victory[2],91,{
        avQueue,
        "Help your team assault and fully burn enemy towers, defend its own towers and protect its captain. Use a forward graveyard to keep reinforcements reaching your attack rather than repeatedly returning from the starting cave.",
        "Win by defeating the enemy general or reducing enemy reinforcements to zero. Stay for the victory result and repeat until this achievement records " .. victory[3] .. (victory[3] == 1 and " victory." or " victories; losses and unfinished games do not replace wins."),
    },nil,{victory[4]})
end
for _, perfection in ipairs({{220,"Stormpike Perfection","Balinda Stonehearth","Horde",880767,1525615},{873,"Frostwolf Perfection","Captain Galvangar","Alliance",416116,1577167}}) do
    battleground(perfection[1],perfection[2],91,{
        avQueue,
        "Coordinate defenders to keep " .. perfection[3] .. " alive and all four of YOUR team's towers/bunkers intact. Return assaulted home flags before they burn; a destroyed home tower cannot be repaired for this attempt.",
        "Assault all FOUR " .. perfection[4] .. " towers/bunkers and protect the flags until they finish burning. A striped contested icon is not a completed enemy tower.",
        "Do not end the match before the last enemy tower burns. Watch enemy reinforcements and delay the general kill if needed; uncontrolled extra kills can end a low-reinforcement match too soon.",
        "Win with your captain alive, every home tower safe and every enemy tower burned. Defend a newly assaulted home flag before the final result so it is not left in contention.",
    },"Some comments report partial-condition or inconsistent awards. This route follows the full stated requirements instead of promising credit from an old bug.",{perfection[5],perfection[6]})
end
battleground(221,"Alterac Grave Robber",91,{
    avQueue,
    "Personally assault a neutral or fully enemy-owned GRAVEYARD flag. Snowfall is a common opening opportunity; finish the channel while teammates handle guards or enemy players.",
    "Check that an assault was recorded, then repeat for 50 graveyards across matches. Instantly restoring your team's still-contested graveyard is a defense and does not replace an assault.",
    "Choose assaults that help your team's route. Do not confuse looting a corpse or taking a tower flag with taking a graveyard.",
},nil,{419563,708527,773187,1107595})
battleground(222,"Tower Defense",91,{
    avQueue,
    "Watch YOUR towers/bunkers for an enemy assault. Reach the contested flag while the tower is still standing; a burned tower cannot be defended afterwards.",
    "Clear or control the enemy players and personally channel the flag back to your faction before the burn timer expires. The instant restoration is the counted defense; killing attackers without recapping is insufficient.",
    "Repeat until the achievement records 50 personal defenses. Home-base towers often get assaulted by a small group while the main fight is elsewhere, so check those as well as the midfield towers.",
},nil,{868266,1070894,1970346,2584682})
battleground(223,"The Sickly Gazelle",91,{
    avQueue,
    "Reach the FIELD OF STRIFE in the middle of the battleground and look for an enemy still riding a mount. The opening mounted crossing gives a natural opportunity.",
    "Help kill that enemy before they dismount, staying in range for the honorable kill. A stun can hold the target, but avoid assuming a class sprint counts as a mount or that a kill in another part of Alterac qualifies.",
},nil,{347047,416357,419279})
for _, loyal in ipairs({{224,"Hall of the Frostwolf","Drek'Thar",774602,864695},{1151,"Hall of the Stormpike","Vanndar Stormpike",435241,620150}}) do
    battleground(loyal[1],"Loyal Defender",91,{
        avQueue,
        "Defend the " .. loyal[2] .. ", the room containing " .. loyal[3] .. ". Enemy players must actually enter that room; kills in the courtyard, bridge or outside keep do not satisfy the location.",
        "Help defeat intruders while staying near the fight. Use control to keep victims inside the hall, and receive the honorable kills. Do not just stand inside and attack targets who remain outside.",
        "Repeat until 50 qualifying player kills have credited across matches. Follow the live achievement counter; NPC boss deaths and kills elsewhere are not hall-defense credit.",
    },nil,{loyal[4],loyal[5]})
end
for _, mine in ipairs({{225,347019},{1164,347036}}) do
    battleground(mine[1],"Everything Counts",91,{
        avQueue,
        "Capture BOTH mines, Irondeep in the north and Coldtooth in the south. Kill the controlling foreman at the back of each mine; merely entering or killing random miners does not switch its ownership.",
        "Leave defenders or arrange teammates to watch the other mine. If the enemy takes one back, recapture it before the match finishes.",
        "WIN while your faction controls both mines at the same time. This refers to the two mines, not the graveyards or a count of ore looted.",
    },nil,{mine[2]})
end
battleground(226,"The Alterac Blitz",91,{
    avQueue,
    "Before the gates open, agree on a fast push with tanks, healers and enough damage to handle the general and his guards. Be present from the START; joining only the end of a short match can fail the timed criterion.",
    "Ride directly toward the enemy general, avoiding unnecessary midfield fights and graveyard commanders. Gather the attack before pulling so the tank does not start alone and wipe.",
    "Tank the general and the remaining marshals/warmasters, use major cooldowns and defeat the general before six minutes have passed. Adjust the kill order if the guards make the boss too strong; do not assume old expansion-specific gear tricks still function.",
},"Difficulty changes with current scaling. A 2025 success is reported, but an October 2026 comment questions the current tuning; no fixed group size or guaranteed easy kill is promised. This achievement is no longer required by Master of Alterac Valley.",{802040,1670997,5366864,6110890,6460810})
battleground(582,"Alterac Valley All-Star",91,{
    avQueue,
    "Personally assault an enemy tower/bunker early, before all available towers are burning. Also personally assault a graveyard; the initially neutral Snowfall flag can count for that assault.",
    "Help kill an enemy in the FIELD OF STRIFE and receive the honorable kill. Do this while traveling through midfield rather than leaving it until both teams have moved into the far bases.",
    "Find a home tower/bunker that an enemy has assaulted and personally recap it BEFORE it burns. Then do the same for a graveyard your team previously owned, before its enemy capture completes.",
    "Check that all FIVE actions credited in this SAME match: tower assault, tower defense, graveyard assault, graveyard defense and Field of Strife kill. Their order can change with the match, but progress does not carry into the next battle.",
},"A return insignia can save travel if you already own it. Ask teammates to cover your flag channels; several required actions depend on you personally completing the click.",{411413,425209,668338,1041950,1510383,1803757,1969250,6094533})
battleground(1166,"To the Looter Go the Spoils",91,{
    avQueue,
    "Help fight enemy players, then loot their corpses/take their insignias before someone else does. Keep a free bag slot so a gray-quality drop is not left behind.",
    "Continue looting until you personally obtain the Autographed Picture of Tigule. It is a random drop; defending your general's hall can provide corpses while also working on Loyal Defender.",
    "Loot it directly from a corpse for the achievement. Buying a picture at the Auction House, trading it, mailing it or unwrapping it does not satisfy the looting criterion.",
},"Later comments also report the drop in Korrak's Revenge when that event is available. No fixed number of corpses guarantees it.",{347043,424815,429299,705824,1036047,3250728,6019987})
battleground(1167,"Master of Alterac Valley",91,{
    "Track the meta's current checklist and queue for Alterac Valley. The Alterac Blitz and Exalted Stormpike/Frostwolf reputation are no longer requirements for this meta.",
    "During the 100-win progress, collect personal graveyard assaults, tower defenses and kills in your general's hall, and loot enemy corpses for the Tigule picture.",
    "Use a longer match for All-Star's five actions and a coordinated victory for both mines or the full Perfection conditions. Check the individual guide before trying to combine them.",
    "Complete every CURRENT listed criterion. Do not follow the old comment lists that add removed meta requirements or confuse controlling both mines with both graveyards.",
},nil,{1530646,"https://www.wowhead.com/achievement=709#comments:id=890433"})

for _, faction in ipairs({
    {708,"Hero of the Frostwolf Clan","Horde","Frostwolf Clan",693327},
    {709,"Hero of the Stormpike Guard","Alliance","Stormpike Guard",661678},
}) do
    battleground(faction[1],faction[2],91,{
        "Use a " .. faction[3] .. " character and track " .. faction[4] .. " in the reputation panel. Queue for Alterac Valley; buying its PvP mount does not grant this reputation achievement.",
        "Help complete the battleground's reputation-granting objectives: defeat enemy NPCs, burn enemy towers and contribute to victories. Loot enemies and use available battleground turn-ins while working on the other Alterac achievements.",
        "Repeat until the actual " .. faction[4] .. " reputation bar reaches EXALTED. A 100-win achievement, Honor level or city reputation is a different counter.",
    },"This reputation is still obtainable, but is no longer required for Master of Alterac Valley. Classic Timewalking's quest/kill reputation bonus can help when its event is active.",{faction[5],"https://www.wowhead.com/guide/world-events/classic-timewalking"})
end
for _, faction in ipairs({
    {710,"The Defiler","Horde","The Defilers",3178869},
    {711,"Knight of Arathor","Alliance","The League of Arathor",5566719},
}) do
    battleground(faction[1],faction[2],1366,{
        "Use a " .. faction[3] .. " character and track " .. faction[4] .. " in the reputation panel. Queue for Arathi Basin and concentrate on your team's resource income.",
        "Capture bases, leave defenders and reinforce attacks before flags are lost. Reputation is earned as your TEAM generates resources; you do not need to personally click every flag, and a loss can still yield progress.",
        "Keep playing until " .. faction[4] .. " reaches EXALTED. Check the reputation gained in your actual matches rather than using old comments' 2000-point formulas, removed guild perks or fixed hundreds-of-wins estimates.",
    },"This is a reputation achievement. It does not award the similarly named old military rank and is not required for Master of Arathi Basin.",{faction[5],"https://www.wowhead.com/achievement=710#comments:id=1445185"})
end
for _, faction in ipairs({
    {712,"Warsong Outrider","Horde","Warsong Outriders",2132232},
    {713,"Silverwing Sentinel","Alliance","Silverwing Sentinels",2613217},
}) do
    battleground(faction[1],faction[2],1339,{
        "Use a " .. faction[3] .. " character and track " .. faction[4] .. " in the reputation panel. Queue for Warsong Gulch with teammates willing to carry and recover flags.",
        "Help your TEAM capture the enemy flag: escort its carrier and recover your own flag so the carrier can score. Your team's captures give reputation; midfield kills without captures are not an efficient reputation route.",
        "When Warsong Scramble is offered, its multiple flags and higher capture limit provide another documented reputation route. That does not mean the brawl qualifies for Quick Cap or Ironman.",
        "Repeat until " .. faction[4] .. " reaches EXALTED. Old calculations assuming only 35 reputation per capture predate later increases; use the actual bar and gains shown on your character.",
    },"This reputation remains obtainable. It is no longer a Master of Warsong Gulch requirement, and the individual reputation achievement does not grant its own title.",{faction[5],"https://www.wowhead.com/achievement=712#comments:id=2493100","https://www.wowhead.com/achievement=713#comments:id=1639858"})
end
for _, meta in ipairs({
    {714,"The Conqueror","Horde","Frostwolf Clan","The Defilers","Warsong Outriders",5911414},
    {907,"The Justicar","Alliance","Stormpike Guard","The League of Arathor","Silverwing Sentinels",5907212},
}) do
    add(meta[1],meta[2],{
        "Use a " .. meta[3] .. " character and build all THREE required battleground reputations on that character. The account sharing of a completed title is not permission to assume three incomplete alts satisfy the criterion.",
        "Reach Exalted with " .. meta[4] .. " in Alterac Valley by completing its NPC/tower objectives and victories. This is independent of purchasing its mount.",
        "Reach Exalted with " .. meta[5] .. " in Arathi Basin. Protect bases so your team keeps generating resources and reputation throughout the match.",
        "Reach Exalted with " .. meta[6] .. " through your team's flag captures in Warsong Gulch, or the documented Warsong Scramble reputation route when offered. Escort and home-flag recovery help far more than unrelated midfield kills.",
        "Confirm all three reputations are Exalted and check the title list after the meta awards. Later War Within comments report that the earned title is now available to alts; early character-only title reports are outdated.",
    },{},"The three reputations are still obtainable. Removed battleground marks, old guild reputation perks and historical exact match-count estimates are not required.",{meta[7],"https://www.wowhead.com/achievement=714#comments:id=2865317"},"PvP")
    guides[meta[1]].areaMaps = {91,1366,1339}
end

-- These seven achievements award credit for the same mount acquisitions already
-- reviewed in MountGuides.lua. Keep their detailed current routes synchronized,
-- including faction, currency, phase and step-linked destinations.
local function mountAchievement(id, name, spellID, comments)
    local route = TDP.CollectionWalkthroughs.mounts[spellID]
    local points = {}
    for _, point in ipairs(route.waypoints or {}) do points[#points + 1] = point end
    add(id,name,{},points,route.tips,comments,"Collections")
    local guide = guides[id]
    guide.stepCount = route.stepCount + 1
    guide.acquisition = route.acquisition .. "\n\n" .. guide.stepCount .. ". After learning the exact mount, check " .. name .. " in Achievements. A similarly named mount or merely killing the former drop boss does not satisfy this record."
    guide.source, guide.requirements, guide.cost = route.source, route.requirements, route.cost
    guide.faction = route.faction
end
mountAchievement(706,"Frostwolf Howler",23509,{1004109,"https://www.wowhead.com/item=19029/horn-of-the-frostwolf-howler"})
mountAchievement(707,"Stormpike Battle Charger",23510,{1004108,2468733})
mountAchievement(729,"Deathcharger's Reins",17481,{417574,556603,561162,1350710,1870748,5603743})
mountAchievement(880,"Swift Zulian Tiger",24252,{5756676,"https://www.wowhead.com/guide/going-above-and-beyond-a-guide-for-obtainable-feats-of-strength-5586","https://www.wowhead.com/npc=245164/madam-goya#comments"})
mountAchievement(881,"Swift Razzashi Raptor",24242,{2160152,5756675,"https://www.wowhead.com/npc=245164/madam-goya#comments"})
mountAchievement(3356,"Winterspring Frostsaber",17229,{1413889,1421433,2543641,5339175})
-- Add the verified service-side encounter pins to the Deathcharger farm.
for _, point in ipairs(encounterPins[646]) do
    if point.mapID == 318 then
        local copy = {}
        for key, value in pairs(point) do copy[key] = value end
        copy.step = point.step == 3 and 2 or point.label:match("Ramstein") and 3 or 4
        copy.mapName = floorNames[318]
        guides[729].waypoints[#guides[729].waypoints + 1] = copy
    end
end

add(3357,"Venomhide Ravasaur",{
    "Use a Horde character and find Mor'vek at 71.6, 73.8 in southeastern Un'Goro Crater. Accept Toxic Tolerance. You need the quest's poison exposures, not a reputation grind for a vendor mount.",
    "Find Venomhide Ravasaurs in the southeastern jungle and trigger 20 poison splashes by HITTING them. Remove weapons and damage-proc gear to avoid killing them immediately. At very high level, use a suitably leveled Horde alt or Party Sync with a friend if the poison cannot affect you.",
    "Return to Mor'vek for Venomhide Eggs, collect four quest-marked eggs, then accept They Grow Up So Fast. Keep the supplied Venomhide Hatchling item.",
    "Summon the hatchling in Un'Goro, Tanaris or Silithus and accept its daily quest. Feed it the exact food requested by that day's quest and turn it in to the hatchling for a Venomhide Baby Tooth.",
    "Repeat after daily resets until you have 20 teeth. Return to Mor'vek with the teeth, 20 Rugged Leather, 20 Runecloth and 80 gold. Complete They Grow Up So Fast and use the whistle to learn the Venomhide Ravasaur, then check the achievement.",
},{pin(78,71.6,73.8,1,"Mor'vek - begin the hatchling chain"),pin(78,67,71,2,"Venomhide Ravasaurs - southeastern jungle"),pin(78,71.6,73.8,3,"Mor'vek - eggs and hatchling"),pin(78,71.6,73.8,5,"Mor'vek - 20-tooth final turn-in")},"High-level characters can have trouble receiving the poison. Remove damage gear and use an appropriately leveled Horde alt or Party Sync if necessary. No full Cataclysm campaign is required to start Mor'vek's chain.",{758122,831079,1899816,2180947,6113349},"Collections")

add(957,"Hero of the Zandalar Tribe",{
    "Wait for Classic Timewalking and visit Bobadormu: the Stormwind Embassy at 56.0, 19.0 for Alliance, or near Orgrimmar's main gate at 52.8, 83.0 for Horde. The old 20th-anniversary camp in Tanaris is not the regular vendor location.",
    "Buy Commendation of the Zandalar Tribe for 50 Timewarped Badges each. These Warband-bound tokens can be sent to the character on which you want to raise the reputation.",
    "Use the commendations on that character until Zandalar Tribe reaches Exalted. Each gives 500 base reputation: from 0 Neutral, 84 tokens cost 4,200 badges before applicable bonuses. Check the actual bar before buying the last batch.",
    "Confirm the achievement after reaching Exalted. This restored reputation route does not restore the removed original Zul'Gurub raid or all of its old vendor rewards.",
},{pin(84,56,19,1,"Bobadormu - Stormwind Embassy"),pin(85,52.8,83,1,"Bobadormu - Orgrimmar main gate")},"Buy the ZANDALAR TRIBE commendation for this old reputation. Zandalari Empire is a different faction, and clearing the current Zul'Gurub dungeon does not replace using these tokens.",{5986820,5994047,5999803,"https://www.wowhead.com/item=224570/commendation-of-the-zandalar-tribe","https://www.wowhead.com/npc=234555/bobadormu"},"Reputation")

local function metaPins(groups)
    local points = {}
    for _, group in ipairs(groups) do
        for _, id in ipairs(group[2]) do
            for _, point in ipairs(guides[id].waypoints) do
                local copy = {}
                for key, value in pairs(point) do copy[key] = value end
                copy.step = group[1]
                points[#points + 1] = copy
            end
        end
    end
    return points
end
add(1283,"Classic Dungeonmaster",{
    "Track this achievement and skip dungeons already credited. Use the CURRENT Retail Normal dungeons; old lists containing removed Upper Blackrock Spire, Scarlet keys or the old Scholomance layout are outdated.",
    "Northern Eastern Kingdoms: complete Shadowfang Keep, Scarlet Monastery, Scholomance and BOTH halves of Stratholme. Use their individual guides for the current final bosses and progression events.",
    "Central/southern Eastern Kingdoms: complete Gnomeregan, original Uldaman, Lower Blackrock Spire, original Blackrock Depths, Sunken Temple, Deadmines and Stormwind Stockade. Horde must also complete the Stormwind dungeon; Alliance must also complete Ragefire below.",
    "Northern/central Kalimdor: complete Ragefire Chasm, Blackfathom Deeps, Wailing Caverns, Razorfen Kraul and Razorfen Downs. In Wailing Caverns, finish the Naralex escort and Mutanus rather than leaving after the four Fanglords.",
    "Southern/western Kalimdor: complete Maraudon, Zul'Farrak and King of Dire Maul. Dire Maul needs Alzzin in East, Immol'thar in West and Gordok in North; a single wing clear does not finish it.",
    "Recheck the current checklist and finish any remaining boss credit. No retired Classic Upper Spire achievement or raid clear is required for this dungeon meta.",
},metaPins({{2,{631,637,645,646}},{3,{634,638,643,642,641,628,633}},{4,{629,632,630,635,636}},{5,{640,639,644}}}),"Both Stratholme halves and all three Dire Maul wings matter. Check the individual boss criteria after each clear, especially after an escort or scripted final encounter.",{534101,534104,575942,803524,929067,1005950,1036087},"Dungeons")
add(1285,"Classic Raider",{
    "Track the meta's CURRENT four raid criteria. The removed level-60 Onyxia and original Zul'Gurub raid are not new completion requirements.",
    "Enter original Molten Core in Blackrock Mountain, clear its progression and summon/defeat Ragnaros. Firelands does not replace this kill.",
    "Enter Blackwing Lair through the Orb of Command, complete Razorgore's egg mechanic and the raid's route, then defeat Nefarian. Blackwing Descent is a separate raid.",
    "Travel to Ahn'Qiraj. Clear the Ruins through Ossirian, then the separate Temple through C'Thun. Use the correct portal for each instance.",
    "Check that Molten Core, Blackwing Lair, Temple of Ahn'Qiraj and Ruins of Ahn'Qiraj are all credited. Naxxramas and the retired level-60 Onyxia achievement are not part of this current four-raid route.",
},metaPins({{2,{686}},{3,{685}},{4,{689,687}}}),nil,{347872,434041,575948,822893},"Raids")

add(940,"The Green Hills of Stranglethorn",{
    "Go to Nesingwary's Expedition in Northern Stranglethorn. Speak to Barnil Stonepot at 44.2, 22.2 and complete Welcome to the Jungle to open the hunters' quests. Enable trivial quest tracking if you outlevel the zone.",
    "Work on all three hunting chains together. For tigers, complete Tiger Hunting, Tiger Stalking, Tiger Prowess and Tiger Mastery. Use each current quest's highlighted area; accept its next stage in the field when the completion/acceptance prompt appears.",
    "Complete Panther Hunting, Panther Stalking, Panther Prowess and Panther Mastery. Young panthers and the later shadowmaw panthers can be STEALTHED: move through the marked area close to the ground instead of concluding that no targets spawned.",
    "Complete Raptor Hunting, Raptor Stalking, Raptor Prowess and Raptor Mastery. Finish and hand in the final mastery quest from EACH of the three chains; doing only the tiger chain will not unlock the finale.",
    "Accept Big Game Hunter from Hemet Nesingwary Jr. at 44.0, 23.4. Kill King Bangalash on the hill around 47.5, 58.5, then complete the quest's turn-in for achievement credit.",
},{pin(50,44.2,22.2,1,"Barnil Stonepot - Welcome to the Jungle"),pin(50,44,23.4,5,"Hemet Nesingwary Jr. - Big Game Hunter"),pin(50,47.5,58.5,5,"King Bangalash - patrol on the hill")},"The old collection of many book pages is obsolete. The current single-page Green Hills quest is a separate camp quest; Big Game Hunter and its hunting prerequisites are the achievement's required route.",{1642180,6207694,"https://www.wowhead.com/npc=731/king-bangalash"},"Quests")

add(944,"They Love Me In That Tunnel",{
    "Go to Nafien outside Timbermaw Hold's Felwood entrance at 64.0, 10.4. Complete the available Deadwood quests to establish friendly access and unlock his repeatable feather turn-in. Do not attack the neutral Timbermaw inside the tunnel.",
    "Kill DEADWOOD furbolgs in Felpaw Village, immediately south of that entrance, and loot every Deadwood Headdress Feather. These enemies give kill reputation up to Revered; the feathers provide the turn-in reputation needed afterward.",
    "Do the available Timbermaw quest chains on both sides of the tunnel. In Winterspring, Salfa's Winterfall quests and Winterfall Spirit Beads provide an alternative to Felwood feathers. The northern Felwood camp is usually the more compact repeat farm.",
    "Return batches of FIVE feathers to Nafien for More Feathers, or five beads to Salfa for More Beads. Each repeat awards 2,000 BASE reputation, not the 300 quoted in pre-Cataclysm comments.",
    "Keep turning in until Timbermaw Hold reaches Exalted. From exactly 0/21,000 Revered, 55 feathers cover the final stretch without bonuses. Save roughly that many for Revered; turn in excess earlier rather than stockpiling hundreds unnecessarily.",
},{pin(77,64,10.4,1,"Nafien - Timbermaw quests"),pin(77,62.5,12,2,"Felpaw Village - Deadwood feather farm"),pin(77,64,10.4,4,"Nafien - More Feathers turn-in")},"The achievement is awarded at Exalted. The later Defender of the Timbermaw quest and toy purchases are optional rewards, not additional achievement criteria. Removed guild reputation perks and the old Wintersaber reputation grind are not part of this route.",{1180050,1230331,1251596,1704632,2069143,"https://www.wowhead.com/npc=15395/nafien"},"Reputation")

add(946,"The Argent Dawn",{
    "Start Fiona's caravan at the WESTERN entrance to Eastern Plaguelands, around 9.0, 66.0. Complete both companions' introductions: Gidwin Goldbraids -> Just Encased -> Greasing the Wheel, and Tarenar Sunstrike -> What I Do Best -> A Gift for Fiona.",
    "Take Onward, to Light's Hope Chapel and ride the caravan to Crown Guard Tower. Complete Traveling Companions at the tower and Rough Roads, then The Trek Continues. Pick up Boys Will Be Boys and continue to Light's Hope Chapel.",
    "Finish A Boyhood Dream and Argent Call: The Trial of the Crypt. This sets the reputation to Revered if it was lower and unlocks Lord Raymond George behind the chapel at 76.0, 51.0. Argent Crusade is a separate reputation.",
    "Accept Annals of the Silver Hand from Lord Raymond George. Enter Stratholme's MAIN Gate and take the living/Crusader's Square route into the Scarlet stronghold toward the Crimson Throne. Pick up the quest-marked book on a table in the stronghold; use the minimap quest marker inside.",
    "Return the book to Raymond for 2,000 base Argent Dawn reputation, and ACCEPT THE QUEST AGAIN before leaving. Repeat until Exalted: eleven completions cover 21,000 reputation without bonuses. This is repeatable immediately, not once per day, and you can revisit the same cleared Normal instance without resetting it.",
    "Alternatively, accept Aberrations of Bone, kill Rattlegore in current Normal Scholomance, return to Raymond, then reset Scholomance before the next kill. Its modern layout requires the preceding boss encounters; old bridge-jump shortcuts describe removed Scholomance.",
},{pin(23,9,66,1,"Fiona - caravan starting camp"),pin(23,76,51,3,"Lord Raymond George - behind Light's Hope Chapel"),pin(23,27.1,11.6,4,"Stratholme MAIN Gate - Annals route"),pin(23,76,51,5,"Raymond - turn in and reaccept Annals"),pin(22,69.1,73.3,6,"Scholomance - alternative Rattlegore route")},"Old Scourgestone collection, the removed Naxxramas raid and wearing an Argent Dawn Commission are not required for this current quest route. Keep useful travel shortcuts such as a hearthstone at Light's Hope, but do not use the obsolete guild-perk macros in older comments.",{1347354,1370976,1641173,1795716,2287040,3176315,"https://www.wowhead.com/quest=28755/annals-of-the-silver-hand#comments:id=2330152"},"Reputation")

local function timewalkingVendors(step)
    return {pin(84,56,19,step,"Bobadormu - Stormwind Embassy"),pin(85,52.8,83,step,"Bobadormu - Orgrimmar main gate")}
end
local function appendRoute(points, id, step)
    for _, point in ipairs(guides[id].waypoints or {}) do
        local copy = {}
        for key, value in pairs(point) do copy[key] = value end
        copy.step = step
        points[#points + 1] = copy
    end
    return points
end
add(955,"Hydraxian Waterlords",{
    "Choose the badge route or the raid route, or combine them. During CLASSIC Timewalking, visit Bobadormu at Stormwind Embassy (56.0, 19.0) or Orgrimmar's main gate (52.8, 83.0).",
    "Buy Commendation of the Hydraxian Waterlords for 50 Timewarped Badges each and use them on the character whose reputation you are raising. Each gives 500 base reputation. From 0 Neutral, 84 tokens cost 4,200 badges; buy only enough to cover your remaining bar.",
    "For the raid alternative, enter ORIGINAL Molten Core in Blackrock Mountain. Clear trash while avoiding bosses if you want to farm and reset the unsaved instance. Trash reputation stops just short of Revered; once that happens, stop expecting trash kills to advance the bar.",
    "Clear the bosses, defeat Majordomo's guards, then speak to Majordomo at Ragnaros's chamber to summon Ragnaros. After your first boss kill, treat this as a weekly raid lockout; resetting does not restore that week's bosses.",
    "Repeat boss clears after weekly resets, or finish the remaining reputation with Timewalking commendations. Kill Golemagg or Ragnaros if other bosses stop giving the final point at the top of Revered. The achievement needs Exalted, not the optional 999/1,000 cap beyond it.",
},appendRoute(timewalkingVendors(1),686,3),"The badge route is a current alternative to the long weekly grind. Classic Timewalking's quest/kill bonus does not automatically multiply reputation from commendation items. Use actual item gains and current buffs, not old Human racial or guild-perk calculations.",{2473761,3245992,5321031,6385199,"https://www.wowhead.com/item=224561/commendation-of-the-hydraxian-waterlords","https://www.wowhead.com/npc=234555/bobadormu"},"Reputation")
add(956,"Brood of Nozdormu",{
    "For a badge route, visit Bobadormu during Classic Timewalking at Stormwind Embassy (56.0, 19.0) or Orgrimmar's main gate (52.8, 83.0). Buy Commendation of the Brood of Nozdormu for 50 Timewarped Badges per 500 base reputation. This faction starts HATED, so the 84-token calculation for a Neutral faction is not its full starting cost.",
    "For the raid route, enter the TEMPLE of Ahn'Qiraj (AQ40) in southern Silithus. Kill trash and bosses, looting Qiraji Lord's Insignias from bosses and any Ancient Qiraji Artifacts from trash. Keep these turn-in items while ordinary kills are still helping.",
    "Continue clearing trash until its reputation stops at 2,999/3,000 Neutral. Boss kills and turn-ins are the route beyond that point; old Scepter-of-the-Shifting-Sands fragment quests are not a current prerequisite.",
    "Clear the raid through the Twin Emperors and C'Thun. Viscidus is optional if you lack the frost-hit and melee-hit tools for his special mechanic. Save the Eye of C'Thun for its one-time quest chain, and keep the insignias/artifacts rather than vendoring them.",
    "Return insignias through Mortal Champions to Kandrostrasz near the raid entrance for 500 base reputation each. An Ancient Qiraji Artifact starts its own 1,000-base-reputation turn-in. Use the raid's friendly dragon NPCs for these quests; they are not the outdoor Cenarion Circle vendors.",
    "Repeat after weekly resets until Exalted, using any Timewalking commendations to cover the balance. A trash-only reset does not restore killed bosses. Check your actual bar before buying a large batch of tokens or following old exact-run estimates.",
},appendRoute(timewalkingVendors(1),687,2),"The original AQ40 raid is still available. The removed original Zul'Gurub raid and the Wrath-era Wyrmrest Accord reputation have no role in this achievement.",{350899,1375780,1749362,"https://www.wowhead.com/faction=910/brood-of-nozdormu","https://www.wowhead.com/item=224558/commendation-of-the-brood-of-nozdormu","https://www.wowhead.com/quest=8579/mortal-champions"},"Reputation")

add(611,"Bleeding Bloodhoof",{
    "Use an Alliance character and organize a city-leader group with a tank and healing. The current target in Thunder Bluff is Baine Bloodhoof, Cairne's successor.",
    "Fly into central Thunder Bluff and find Baine Bloodhoof at the longhouse around 59.6, 51.6. Gather before attacking so everyone is in the same phase and group when the boss is tagged.",
    "Tank him near the longhouse with your back away from the cliff edges. Handle guards and defending Horde players as they arrive; knockbacks and a long fall are avoidable reasons to lose the pull.",
    "Defeat Baine and check credit. A second documented route is the account's Horde character earning Overthrow the Council in Ironforge: a 2026 comment reports the faction-equivalent Bleeding Bloodhoof credit on Alliance characters too.",
},{pin(88,59.6,51.6,2,"Baine Bloodhoof - central longhouse"),pin(87,39.6,55.6,4,"Horde alternative - Council of Three Hammers")},"Bring enough healing for the boss and city guards, keep knockbacks away from the cliff edges, and regroup before another pull if defending players scatter the raid.",{1872286,6040243,"https://www.wowhead.com/achievement=616#comments:id=6264103","https://www.wowhead.com/npc=36648/baine-bloodhoof"},"PvP")
add(616,"Overthrow the Council",{
    "Use a Horde character and form a city-leader group with a tank, healing and interrupts. Get everyone into the same phase and War Mode setting before attacking Ironforge.",
    "Send a warlock and helpers into a quiet stairwell near the High Seat. Summon the group out of sight, below the top of the stairs, then move into the throne room together. Prepare for all three council members, rather than the former single Magni encounter.",
    "Engage Moira Thaurissan, Muradin Bronzebeard and Falstad Wildhammer in the High Seat around 39.6, 55.6. Kill Moira first and interrupt her healing; do not spend the whole pull letting her heal the other bosses.",
    "Keep your tank's back against a wall for Muradin's knockback and repeated stuns. Keep healers in line of sight, handle Falstad's casts, and deal with defending players before they overwhelm the group. Do not kite far down the Old Ironforge stairs and reset the encounter.",
    "Defeat all THREE council members and check the criteria. Recent completions report credit even when a previously killed member respawns during the fight; Magni alone is no longer the target. Avoid multiple independent raid groups splitting the boss tags.",
},{pin(87,39.6,55.6,2,"High Seat approach - gather and summon"),pin(87,39.6,55.6,3,"Council - kill Moira first"),pin(87,39.6,55.6,4,"Council - Muradin and Falstad")},"Bring a tank who can survive repeated stuns and healers who can stay in line of sight. A warlock summon reduces the number of players who need to cross the city separately. Modern tank solos are reported, but a group is the practical general route.",{744256,1156021,1303232,1644175,6158725,6226326,6264103,"https://www.wowhead.com/npc=42928/muradin-bronzebeard"},"PvP")

local arenaTiming = "Arrive at Gurubashi Arena in the Cape of Stranglethorn around 46.4, 26.6 a few minutes before a three-hour chest event: normally 00:00, 03:00, 06:00, 09:00, 12:00, 15:00, 18:00 or 21:00 SERVER time. Daylight-saving changes can shift the schedule until a realm restart."
add(389,"Gurubashi Arena Master",{
    arenaTiming,
    "Wait for Short John Mithril's announcement and the Arena Treasure Chest in the arena floor. Entering the floor enables free-for-all PvP, including attacks by your own faction. Friends can protect your opening channel; an off-peak visit reduces competition.",
    "Open the chest and personally loot the Arena Master trinket. Confirm the bind/loot prompt if shown; merely opening the chest, winning a duel or looting only a potion does not grant this achievement.",
    "Keep the trinket if you also want Arena Grand Master, then start its quest and speak to Short John Mithril at the arena. If the event and NPCs are missing, resolve or abandon the interfering Bwemba's Spirit/Zul'Gurub introduction quests and relog before assuming the event was removed.",
},{pin(210,46.4,26.6,1,"Gurubashi Arena - scheduled chest"),pin(210,45,25.5,4,"Short John Mithril - trinket quest")},"Recent comments report that other players can also loot their trinket if earlier looters leave ordinary loot inside the chest. Coordinate before using autoloot if sharing; do not count on an old guaranteed exclusive-chest model.",{347025,591036,974356,1382592,1577378,1638188,5421652,5912257,"https://www.wowhead.com/npc=14508/short-john-mithril"},"PvP")
add(396,"Gurubashi Arena Grand Master",{
    arenaTiming,
    "Personally loot an Arena Master trinket from the chest, right-click it to begin Arena Master, and complete that introduction with Short John Mithril. Accept Arena Grandmaster from him; the final quest requires TWELVE trinkets together, not twelve scattered characters.",
    "Return for more three-hour chest spawns on that SAME character. Protect the opening channel, loot the trinket and keep it. Check how many remain after the introductory turn-in rather than assuming the first quest left one in your bags.",
    "Keep enough bag space for all twelve nonstacking trinkets. They bind to the looter, so collecting on a high-level character does not supply a different low-level character's turn-in.",
    "Bring twelve to Short John Mithril and complete Arena Grandmaster to receive the Arena Grand Master trinket and achievement. The first-chest Arena Master achievement alone does not finish this one, and no arena rating or title is awarded by this quest.",
},{pin(210,46.4,26.6,1,"Gurubashi Arena - repeat chest spawns"),pin(210,45,25.5,2,"Short John Mithril - introduction and follow-up"),pin(210,45,25.5,5,"Short John Mithril - twelve-trinket turn-in")},"Use a character eligible for the current quest, rather than the obsolete level-one twink instructions. War Mode has separate populations; do not expect a chest to remain for hours after its spawn. A 2025 report observes a one-hour unlooted despawn.",{418228,644710,862014,905747,1112960,2569028,3145713,3302037,6081960},"PvP")

add(428,"Thunderfury, Blessed Blade of the Windseeker",{
    "Choose a character that can EQUIP a one-handed sword. The personal achievement requires equipping Thunderfury; collecting a Warband appearance or earning the guild legendary achievement is a different condition.",
    "Enter original Molten Core through Lothos Riftwaker in Blackrock Mountain. Kill Garr for Bindings of the Windseeker (RIGHT half) and Baron Geddon for the LEFT half, looting both on the SAME character. Repeat after weekly resets; neither binding has a guaranteed run count.",
    "Once you have either binding, visit Highlord Demitrian in northwestern Silithus at 29.6, 10.6. If the sword-wounded phase hides him, ask Zidormi at 78.8, 22.0 to show Silithus before the wound. Use Demitrian's dialogue for the Vessel of Rebirth, use the vessel to complete Examine the Vessel, then accept Thunderaan the Windseeker.",
    "With that quest ACTIVE, kill original Molten Core's Ragnaros for Essence of the Firelord. Loot it before leaving. A Ragnaros kill before accepting the quest does not supply the essence; Firelands Ragnaros is the wrong boss.",
    "Obtain TEN Enchanted Elementium Bars. Buy the finished bars, commission a Classic miner, or learn the smelting recipe from Goblin's Guide to Elementium dropped by Master Elemental Shaper Krixix in Blackwing Lair. The total materials are 10 Elementium Ingots from Blackwing Lair, 100 Arcanite Bars, 10 Fiery Cores and 30 vendor-bought Elemental Flux. Ordinary Cataclysm Elementium Bars are the wrong item.",
    "Bring both bindings, the essence and the ten enchanted bars to Demitrian. Finish the turn-in, defeat the summoned Thunderaan nearby, and loot the Dormant Wind Kissed Blade. Use the blade to start Rise, Thunderfury!, then turn it in to Demitrian.",
    "EQUIP the rewarded Thunderfury and check the personal achievement. Keep the bindings, quest and final weapon on the same eligible character throughout the chain.",
},{pin(33,54.2,83.3,2,"Lothos Riftwaker - original Molten Core","Blackrock Mountain - lower approach"),pin(232,31.51,68.96,2,"Garr - RIGHT binding"),pin(232,52.39,77.63,2,"Baron Geddon - LEFT binding"),pin(81,78.8,22,3,"Zidormi - Silithus before the wound"),pin(81,29.6,10.6,3,"Highlord Demitrian - start the quest"),pin(232,56.23,53.40,4,"Ragnaros - essence while on the quest"),pin(33,64.2,71,5,"Blackwing Lair - optional ingots and recipe","Blackrock Mountain - upper chamber"),pin(81,29.6,10.6,6,"Demitrian - materials and Thunderaan")},"You do not need to learn Mining yourself if you buy the enchanted bars. Arcanite Bars can be made by Classic Alchemy from Thorium Bars and Arcane Crystals. Do not follow the old Krixix mind-control method or a fixed estimate of binding runs.",{1834412,"https://www.wowhead.com/item=19019#comments:id=1130192","https://www.wowhead.com/item=19019#comments:id=1653255","https://www.wowhead.com/npc=14347/highlord-demitrian","https://www.wowhead.com/npc=128607/zidormi","https://wago.tools/db2/JournalEncounter/csv"},"Raids")
add(429,"Sulfuras, Hand of Ragnaros",{
    "Use a character that can EQUIP a two-handed mace: Warrior, Paladin, Death Knight, Shaman or Druid. The personal achievement requires equipping the original legendary, even though other classes can now collect its appearance for the Warband.",
    "Clear original Molten Core and loot the Eye of Sulfuras from Ragnaros when it drops. Keep the Eye on the character earning the achievement. Repeat after weekly resets as needed; Firelands' similarly named Sulfuras is a different weapon.",
    "Obtain the bind-on-equip Sulfuron Hammer. You can buy a finished hammer or have a Classic Blacksmith with the recipe craft it; your achievement character does not need Blacksmithing.",
    "If the crafter needs the recipe, take ONE extra Sulfuron Ingot to Lokhtos Darkbargainer in Blackrock Depths' Grim Guzzler. Use his dialogue and A Binding Contract to receive Plans: Sulfuron Hammer. This recipe ingot is additional to the eight consumed by the craft; no Thorium Brotherhood reputation grind is needed just for the contract.",
    "For the hammer craft, provide 8 Sulfuron Ingots, 20 Dark Iron Bars, 50 Arcanite Bars, 25 Essences of Fire, 10 Blood of the Mountain, 10 Lava Cores and 10 Fiery Cores. Golemagg in Molten Core supplies ingots; its trash supplies cores and Molten Destroyers can drop Blood of the Mountain. Materials can also be purchased.",
    "Have the crafter make the Sulfuron Hammer at the BLACK ANVIL, beside Lord Incendius in original Blackrock Depths. This is a different station from the Black Forge used to smelt Dark Iron. Use the original dungeon, not the anniversary raid or the Dark Iron allied-race scenario.",
    "On the eligible character, keep the Sulfuron Hammer in your bags and use the Eye of Sulfuras to combine them into Sulfuras, Hand of Ragnaros. EQUIP the legendary mace for this achievement.",
},{pin(33,54.2,83.3,2,"Lothos Riftwaker - original Molten Core","Blackrock Mountain - lower approach"),pin(232,56.23,53.40,2,"Ragnaros - Eye of Sulfuras"),pin(243,50.4,58.8,4,"Lokhtos - Grim Guzzler recipe contract","Blackrock Depths - upper city"),pin(232,68.87,57.64,5,"Golemagg - Sulfuron Ingot"),pin(242,56.42,31.15,6,"Black Anvil - Lord Incendius's platform","Blackrock Depths - Detention Block")},"Buying a finished Sulfuron Hammer skips the recipe and material collection steps. Creating the weapon or obtaining its appearance on a class unable to equip it does not replace the personal equip criterion.",{944485,951223,1083358,1702699,"https://www.wowhead.com/item=17182#comments:id=1021689","https://www.wowhead.com/item=17182#comments:id=1816455","https://www.wowhead.com/item=17182#comments:id=5911027","https://www.wowhead.com/npc=12944/lokhtos-darkbargainer","https://wago.tools/db2/JournalEncounter/csv"},"Raids")

-- Each route is curated against the current achievement criteria. Coordinates
-- from the old, differently scaled pre-Cataclysm maps are deliberately excluded.
local function explore(id, zone, mapID, legs, tips, comments, preparation)
    local steps = {preparation or ("Track Explore " .. zone .. " and check which named areas are still missing. Use the " .. zone .. " map for these coordinates. Fly or ride through each missing area's discovery boundary; a fully visible map alone is not proof that every criterion credited.")}
    local points = {}
    for _, leg in ipairs(legs) do
        local stops = {}
        for _, point in ipairs(leg[2]) do
            stops[#stops + 1] = string.format("%s (%.1f, %.1f)",point[3],point[1],point[2])
            points[#points + 1] = pin(mapID,point[1],point[2],#steps + 1,point[3])
        end
        steps[#steps + 1] = leg[1] .. " " .. table.concat(stops," -> ") .. "."
    end
    steps[#steps + 1] = "Reopen the achievement and check every named criterion. If one is missing, return to its pin and move around the actual subzone, descending toward the ground if necessary. Stop once the discovery credits; extra map shading and nearby dungeons are not additional requirements."
    add(id,"Explore " .. zone,steps,points,tips,comments,"Exploration")
end
explore(627,"Dun Morogh",27,{
    {"Western circuit:",{{36.8,70,"Coldridge Valley"},{42.71,64.22,"Coldridge Pass"},{34.5,51.69,"Frostmane Hold"},{33.22,38.73,"New Tinkertown"},{42.95,38.47,"Iceflow Lake"}}},
    {"Central circuit:",{{48.47,39.33,"Shimmer Ridge"},{60.35,33.43,"Gates of Ironforge"},{54.06,50.76,"Kharanos"},{58.34,57.61,"Frostmane Front"},{67.48,57.28,"The Tundrid Hills"}}},
    {"Eastern circuit, including the elevated airfield:",{{70.84,48.33,"Amberstill Ranch"},{75.84,56.37,"Gol'Bolar Quarry"},{84.14,51.49,"Helm's Bed Lake"},{88.42,41.12,"North Gate Outpost"},{77.81,25.96,"Ironforge Airfield"}}},
},"The airfield is above the ordinary valley floor; flying is the direct route. Alliance ground travelers can complete Sergeant Bahrum's local quests to unlock Get to the Airfield and its flying machine. The Grizzled Den and the obsolete South Gate/Brewnall criteria are not required by the current checklist.",{1398598,1403147,1484402,1646606,3198663})
explore(728,"Durotar",1,{
    {"Southern coast and starting valley:",{{44.17,64.68,"Valley of Trials"},{49.82,81.5,"Northwatch Foothold"},{55.98,74.36,"Sen'jin Village"},{64.14,74.41,"Echo Isles"},{59.51,58.3,"Tiragarde Keep"}}},
    {"Cross the middle of the zone:",{{49.11,48.81,"Razormane Grounds"},{43.15,42.55,"Southfury Watershed"},{52.83,42.81,"Razor Hill"}}},
    {"Finish the northern ravines and city boundary:",{{40.9,26.51,"Thunder Ridge"},{52.6,21.52,"Drygulch Ravine"},{54.97,9.96,"Skull Rock"},{53,1,"Orgrimmar boundary"}}},
},"Razormane Grounds moved relative to old maps; do not use the old 41,45 pin. Alliance can approach the Orgrimmar boundary from the north/Azshara side, flying into its discovery area and checking credit before going deeper among guards. For Valley of Trials, a 2023 comment uses the southern slope near 49.5,70.5 to avoid its guarded entrance.",{1297419,1485985,2006732,5660777})
explore(736,"Mulgore",7,{
    {"Southern circuit:",{{42.84,80.52,"Red Cloud Mesa"},{35.05,61.37,"Palemane Rock"},{48.11,59.2,"Bloodhoof Village"},{53.56,65.35,"Winterhoof Water Well"},{59.74,65.71,"The Rolling Plains"}}},
    {"Central circuit:",{{60.68,47.69,"The Venture Co. Mine"},{53.46,48.32,"Ravaged Caravan"},{44.86,45.53,"Thunderhorn Water Well"},{32.83,48.9,"Bael'dun Digsite"},{48.58,37.61,"The Golden Plains"}}},
    {"Northern circuit:",{{43.12,16.06,"Wildmane Water Well"},{51.14,9.25,"Windfury Ridge"},{60.57,21.61,"Red Rocks"}}},
},"Thunder Bluff was removed from this achievement's criteria; the many old comments about its bug do not add a city visit to this route. Palemane Rock is the cave area south of Bael'dun Digsite. For Red Cloud Mesa, the edge near 41.8,75 can also trigger discovery.",{1376469,1438912,1486053,1575271,1702615})
explore(750,"Northern Barrens",10,{
    {"Northern circuit:",{{66.57,12.74,"Boulder Lode Mine"},{57.96,19.5,"The Sludge Fen"},{42.7,15.41,"The Mor'shan Rampart"},{27.59,31.68,"The Dry Hills"},{42.86,38.8,"Dreadmist Peak"}}},
    {"Middle circuit:",{{36.99,45.21,"The Forgotten Pools"},{53.84,41.04,"Grol'dom Farm"},{67.22,39.75,"Far Watch Post"},{58.42,49.23,"Thorn Hill"},{49.65,58.08,"The Crossroads"}}},
    {"Southern circuit:",{{40.26,74.95,"Lushwater Oasis"},{55.69,80.18,"The Stagnant Oasis"},{67.93,72.28,"Ratchet"},{70.55,89.12,"The Merchant Coast"}}},
},"These are Northern Barrens coordinates after the zone split. Camp Taurajo, Razorfen entrances and other Southern Barrens locations in 2008 lists are not this checklist. Dreadmist discovery is up on the peak. Alliance on foot can skirt the eastern side of the Mor'shan barricade instead of its guarded main gate.",{1486025,1598072,1934147})
explore(761,"Arathi Highlands",14,{
    {"Western circuit:",{{12.9,34.85,"Galen's Fall"},{18.97,30.99,"Circle of West Binding"},{25.77,29.58,"Northfold Manor"},{29.09,45.21,"Boulder'gor"},{19.57,66.96,"Stromgarde Keep"},{28.9,82.81,"Faldir's Cove"}}},
    {"Southern and central circuit:",{{39.57,96.1,"Thandol Span"},{47.98,78.79,"Boulderfist Hall"},{63.04,75.75,"Witherbark Village"},{56.62,60.15,"Go'Shek Farm"},{46.39,52.16,"Circle of Outer Binding"},{29.76,59.77,"Circle of Inner Binding"}}},
    {"Finish the central and northeastern camps:",{{40.13,47.87,"Refuge Pointe"},{49.64,40.59,"Dabyrie's Farmstead"},{61.62,30.33,"Circle of East Binding"},{69.06,36.18,"Hammerfall"}}},
},"Faldir's Cove is below/behind Stromgarde: fly down to the shore, or use the cave behind the keep. A 2026 comment reports some discoveries failing in the old phase until logging out and back in at each named area; try this only for a criterion that refuses to register.",{1484416,1638403,2625754,6327098},"Track Explore Arathi Highlands. Speak to Zidormi at the southern entrance by Thandol Span and select Arathi BEFORE the Battle for Stromgarde. Use that accessible Retail phase and the original Arathi map, rather than the active Warfront map, for this route.")
explore(765,"Badlands",15,{
    {"Western and central circuit:",{{17.7,44.27,"New Kargath"},{14.8,63.15,"Camp Cagg"},{24.68,36.68,"The Dustbowl"},{36.89,49.95,"Scar of the Worldbreaker"},{46.81,56.51,"Agmond's End"},{50.55,46.03,"Bloodwatcher Point"}}},
    {"Northern and eastern circuit:",{{41.21,26.75,"Angor Fortress"},{42.26,11.71,"Uldaman"},{59.23,19.51,"Camp Kosh"},{71.17,44.37,"Lethlor Ravine"}}},
},"Use New Kargath and the post-Cataclysm landmarks. Old lists of Camp Boff, Mirage Flats, Apocryphan's Rest and Hammertoe's Digsite do not match the current ten criteria. Bloodwatcher Point is the small Horde camp; Alliance can discover its boundary without entering the camp.",{1429954,1484396,1870610,2310719})
explore(766,"Blasted Lands",17,{
    {"Northern circuit:",{{41.75,14.25,"Dreadmaul Hold"},{45.03,26.57,"Rise of the Defiler"},{52.61,18.63,"Nethergarde Supply Camps"},{60.41,16.94,"Nethergarde Keep"},{61.4,29.41,"Serpent's Coil"},{67.52,31.67,"Shattershore"}}},
    {"Central circuit:",{{54.9,52.99,"The Dark Portal"},{45.06,38.21,"Dreadmaul Post"},{36.95,28.29,"Altar of Storms"},{32.58,44.78,"The Tainted Scar"}}},
    {"Southern circuit:",{{32.63,80.28,"The Tainted Forest"},{45.52,86.96,"Surwich"},{50.16,78.78,"The Red Reaches"},{50.07,72.99,"Sunveil Excursion"}}},
},"Nethergarde Supply Camps were replaced by the Forge Grounds in the invasion phase. If the old-phase visit still fails, comments report logging out and back in at that camp restores discovery credit. Do not treat the achievement as removed just because the present-day map has different names.",{1484379,1647662,2078466,2491914,3123962,3291716,"https://www.wowhead.com/npc=88206/zidormi"},"Track Explore Blasted Lands. At the road from Swamp of Sorrows, speak to Zidormi on the small hill at 48.2,7.2 and ask to see Blasted Lands BEFORE the Iron Horde invasion. Dismount if she is not visible. These old-phase locations remain accessible in Retail through her.")
guides[766].waypoints[#guides[766].waypoints + 1] = pin(17,48.2,7.2,1,"Zidormi - before the Iron Horde invasion")
explore(768,"Tirisfal Glades",18,{
    {"Western circuit:",{{32.09,64.6,"Deathknell"},{37.98,51.11,"Solliden Farmstead"},{44.44,53.19,"Calston Estate"},{46.01,69.26,"Nightmare Vale"},{53.72,57.02,"Cold Hearth Manor"}}},
    {"Central and northern circuit:",{{45.93,29.89,"Agamand Mills"},{58.58,35.21,"Garren's Haunt"},{60.87,52.03,"Brill"},{68.2,47.61,"Brightwater Lake"},{79.52,25.48,"Scarlet Watch Post"},{85.08,31.34,"Scarlet Monastery Entrance"}}},
    {"Eastern and southern circuit:",{{83.05,44.85,"Venomweb Vale"},{78.96,55.56,"Crusader Outpost"},{76.02,59.61,"Balnir Farmstead"},{83.29,70.46,"The Bulwark"},{61.87,67.55,"Ruins of Lordaeron"}}},
},"The current criterion is Ruins of Lordaeron, not a trip down the Undercity elevators. Stillwater Pond and Whispering Gardens are not required. A 2025 comment reports Cold Hearth Manor credit working in old Tirisfal; if Zidormi is absent, resolve the Battle for Azeroth introduction/phasing on that character.",{1484429,5204518,6168672,"https://www.wowhead.com/npc=141488/zidormi"},"Track Explore Tirisfal Glades. If your zone shows the blighted/post-battle version, use Zidormi's dialogue at 69.5,62.8 near the eastern road to return to Tirisfal BEFORE the Battle for Lordaeron. Follow the original Tirisfal map for the route below.")
guides[768].waypoints[#guides[768].waypoints + 1] = pin(18,69.5,62.8,1,"Zidormi - Tirisfal before the Battle for Lordaeron")
explore(769,"Silverpine Forest",21,{
    {"Northern circuit:",{{56.7,10.1,"Forsaken High Command"},{44.66,21.64,"Forsaken Rear Guard"},{35.78,14.19,"The Skittering Dark"},{38.56,29.2,"North Tide's Beachhead"},{38.9,33.19,"North Tide's Run"}}},
    {"Lake and middle circuit:",{{52.56,26.59,"Valgan's Field"},{65.76,26.21,"Fenris Isle"},{56.88,33.53,"The Decrepit Fields"},{44.97,41.66,"The Sepulcher"},{56.38,46.15,"Deep Elem Mine"},{46.92,53.94,"Olsen's Farthing"}}},
    {"Southern circuit:",{{60.03,61.9,"Ambermill"},{51.14,67.42,"The Forsaken Front"},{45.05,67.95,"Shadowfang Keep"},{45.41,82.23,"The Battlefront"}}},
},"Forsaken High Command is at the NORTH end near 56.7,10.1; the 90.98 latitude repeated in some old macros is a typo. North Tide's Run is the offshore water: move between/out toward the ships if the beach visit does not credit it. No Shadowfang dungeon clear is required.",{1484427,1551268,1635675,1647984,1677386})
explore(770,"Western Plaguelands",22,{
    {"Western and northern circuit:",{{28.83,57.36,"The Bulwark"},{36.69,56.57,"Felstone Field"},{45.91,53.31,"Dalson's Farm"},{49.66,43.08,"Redpine Dell"},{48.27,32.16,"Northridge Lumber Camp"},{45.73,18.57,"Hearthglen"}}},
    {"Eastern circuit:",{{64.87,38.72,"The Weeping Cave"},{69.61,49.22,"Thondroril River"},{62.6,58.21,"Gahrron's Withering"},{53.26,65.92,"The Writhing Haunt"}}},
    {"Southern circuit:",{{47.63,67.18,"Andorhal"},{50.83,77.2,"Sorrow Hill"},{60.03,74.66,"Darrowmere Lake"},{65.52,75.34,"Caer Darrow"}}},
},"Caer Darrow is the island; discovering its shore does not require entering Scholomance. On foot, use the road into Hearthglen rather than attempting to climb its southern cliffs. Redpine Dell is a current criterion missing from some pre-Cataclysm lists.",{1366294,1484432})
explore(771,"Eastern Plaguelands",23,{
    {"Southwestern circuit:",{{8.63,66.2,"Thondroril River"},{22.31,68.15,"The Marris Stead"},{24.24,78.57,"The Undercroft"},{35.05,84.39,"Darrowshire"},{35.75,68.82,"Crown Guard Tower"},{35.52,46.65,"The Fungal Vale"}}},
    {"Northwestern circuit:",{{13.74,27.79,"Terrordale"},{27.59,21.44,"Plaguewood"},{27.07,11.63,"Stratholme"},{48.27,14.69,"Quel'Lithien Lodge"},{51.77,19.65,"Northpass Tower"},{46.57,43.49,"Blackwood Lake"}}},
    {"Central and southeastern circuit:",{{48.9,62.25,"The Infectis Scar"},{54.5,61.84,"Corin's Crossing"},{56.8,73.64,"Lake Mereldar"},{72.09,70.14,"Tyr's Hand"},{85.59,79.64,"Ruins of the Scarlet Enclave"},{74.95,53.1,"Light's Hope Chapel"},{69.99,53.76,"Pestilent Scar"}}},
    {"Northeastern circuit:",{{62.29,42.29,"Eastwall Tower"},{77.1,37.02,"The Noxious Glade"},{65.03,25.67,"Northdale"},{67.39,9.17,"Zul'Mashar"}}},
},"Stratholme discovery is outside its entrance; the dungeon is not required. The Scarlet Enclave criterion refers to the accessible outdoor ruins, not the Death Knight starting scenario or entering Acherus. Ground travelers can use the tunnel from the Noxious Glade toward Death's Breach.",{1047218,1484434,1631441,1787858})
explore(772,"Hillsbrad Foothills",25,{
    {"Southern circuit:",{{27.02,86.94,"Purgation Isle"},{34.24,72.6,"Azurelode Mine"},{29.91,63.81,"Southpoint Gate"},{36.56,58.04,"The Sludge Fields"},{48.97,71.89,"Ruins of Southshore"},{57.51,74.96,"Nethander Stead"},{63,79,"Dun Garok"},{68.04,60.47,"Durnholde Keep"}}},
    {"Central hills:",{{46.57,54.3,"Darrow Hill"},{43.98,48.87,"The Headland"},{40.08,47.84,"Gavin's Naze"},{33.33,48.2,"Brazie Farmstead"},{43.58,38.37,"Growless Cave"},{49.49,48.09,"Corrahn's Dagger"},{57.32,46.33,"Tarren Mill"},{55.43,38.42,"Sofera's Naze"},{49.88,32.59,"Gallows' Corner"}}},
    {"Northern mountains and lakeshore:",{{57.82,24.21,"Strahnbrad"},{67.36,25.44,"Chillwind Point"},{50.16,24.37,"Crushridge Hold"},{46.17,27.93,"Ruins of Alterac"},{49.43,18.88,"Slaughter Hollow"},{50.04,11.98,"The Uplands"},{44.82,9.67,"Dandred's Fold"},{35.06,26.14,"Misty Shore"},{30.4,36.37,"Dalaran Crater"}}},
},"This includes the former Alterac Mountains areas. Purgation Isle is the southern island; do not keep swimming into fatigue beyond it. If Gallows' Corner fails, stand on the signpost at the road fork southeast of Ruins of Alterac. For Dandred's Fold, follow the Lordamere lakeshore north instead of dropping down cliffs.",{"https://www.wowhead.com/achievement=772/explore-hillsbrad-foothills#comments"})
explore(773,"The Hinterlands",26,{
    {"Western circuit:",{{14.55,47.84,"Aerie Peak"},{23.89,38.4,"Plaguemist Ravine"},{31.06,48.02,"Quel'Danil Lodge"},{23.46,58.21,"Zun'watha"},{33.77,71.21,"Shadra'Alor"},{40.93,59.4,"Valorwind Lake"}}},
    {"Central circuit:",{{48.85,68.69,"The Altar of Zul"},{48.96,52.34,"The Creeping Ruin"},{46.59,39.68,"Agol'watha"},{57.37,39.03,"Skulk Rock"}}},
    {"Eastern circuit:",{{63.23,27.26,"Seradane"},{72.82,53.39,"Shaol'watha"},{72.64,66.32,"The Overlook Cliffs"},{59.64,78.14,"Jintha'Alor"}}},
},"Plaguemist Ravine is in the WEST behind Aerie Peak, not the blank northeastern corner. On foot, take the path toward Shindigger's Camp, then its left branch into the ravine; it also connects to Western Plaguelands. Fly or use the terrace paths for the elevated troll ruins.",{"https://www.wowhead.com/achievement=773/explore-the-hinterlands#comments"})
explore(774,"Searing Gorge",32,{
    {"Northern circuit:",{{22.16,36.32,"Firewatch Ridge"},{38.03,28.18,"Thorium Point"},{71.45,33.11,"Dustfire Valley"}}},
    {"Central and southern circuit:",{{63.52,60.47,"Grimesilt Dig Site"},{52.04,50.02,"The Cauldron"},{58.32,71.3,"The Sea of Cinders"},{34.63,82.31,"Blackrock Mountain"},{21.24,77.74,"Blackchar Cave"}}},
},"Tanner Camp appears in older coordinate lists but is not one of the current eight criteria. Discover Blackrock Mountain at its outdoor approach; no dungeon or raid clear is required. Check the Cauldron itself rather than assuming a ride around its rim registered the subzone.",{"https://www.wowhead.com/achievement=774/explore-searing-gorge#comments"})
explore(775,"Burning Steppes",36,{
    {"Eastern circuit:",{{65.92,72.56,"Blackrock Pass"},{72.64,66.55,"Morgan's Vigil"},{77.42,52.32,"Terror Wing Path"},{69.73,43.28,"Dreadmaul Rock"},{58.18,38.04,"Ruins of Thaurissan"}}},
    {"Western circuit:",{{39.83,55.24,"Black Tooth Hovel"},{18.87,62.99,"The Whelping Downs"},{10.04,29.71,"Altar of Storms"},{21.22,43.38,"Blackrock Mountain"},{32.66,35.1,"Blackrock Stronghold"}}},
},"Blackrock Pass is the approach toward Redridge, even though the map patch it reveals stretches west of the pass. Slither Rock's separate map shading is not a criterion. The current zone quest chain also visits these areas, so check existing credit before making a separate circuit.",{"https://www.wowhead.com/achievement=775/explore-burning-steppes#comments"})
explore(776,"Elwynn Forest",37,{
    {"Western circuit:",{{24.4,74.53,"Westbrook Garrison"},{38.64,82.32,"Fargodeep Mine"},{42.38,66.2,"Goldshire"},{48.16,42.08,"Northshire Valley"}}},
    {"Northern and eastern circuit:",{{54.25,66.22,"Crystal Lake"},{64.88,69.86,"Tower of Azora"},{73.48,58.85,"Stone Cairn Lake"},{81.82,66.54,"Eastvale Logging Camp"},{84.6,79.44,"Ridgepoint Tower"}}},
    {"Southern circuit:",{{69.34,79.3,"Brackwell Pumpkin Patch"},{48.15,87.17,"Jerod's Landing"}}},
},"Stormwind is absent from the current eleven criteria; the many old city-wall instructions are unnecessary. Horde can approach Northshire from the side slope or by air, checking discovery before approaching guards. The pumpkin patch is south of the Tower of Azora even if its name is not printed on the map.",{"https://www.wowhead.com/achievement=776/explore-elwynn-forest#comments"})
explore(777,"Deadwind Pass",42,{
    {"Follow the northern road and its southeastern branch:",{{35.87,35.6,"Deadman's Crossing"},{58.69,61.4,"The Vice"}}},
    {"Finish outside the tower at the southern end:",{{46.53,74.34,"Karazhan"}}},
},"The Vice is the southeastern ogre area, so a direct flight only to Karazhan can miss it. All three criteria are outdoor discoveries; neither Karazhan instance nor the crypts need to be entered.",{"https://www.wowhead.com/achievement=777/explore-deadwind-pass#comments"})
explore(778,"Duskwood",47,{
    {"Western circuit:",{{11.17,58.74,"The Hushed Bank"},{19.13,56.8,"Raven Hill"},{20.78,44.12,"Raven Hill Cemetery"},{22.49,71.33,"Addle's Stead"},{36.69,72.24,"Vul'Gol Ogre Mound"}}},
    {"Northern circuit:",{{46.52,38.03,"Twilight Grove"},{63.3,25.28,"Brightwood Grove"},{65.44,18.02,"The Darkened Bank"},{77.25,35.19,"Manor Mistmantle"}}},
    {"Eastern and southern circuit:",{{74.36,47.21,"Darkshire"},{79.54,70.61,"Tranquil Gardens Cemetery"},{64.63,68.77,"The Rotting Orchard"},{49.81,75.79,"The Yorgen Farmstead"}}},
},"Twilight Grove lies inside the central ridge. Ground travelers enter from the south around 47,60 and follow the torch-lined path; do not keep riding around the cliff base. You only need to discover the grove, without using its portal.",{"https://www.wowhead.com/achievement=778/explore-duskwood#comments"})
explore(779,"Loch Modan",48,{
    {"Western and northern circuit:",{{23.49,74.97,"Valley of Kings"},{30.96,80.28,"Stonesplinter Valley"},{37.82,62.62,"Grizzlepaw Ridge"},{34.9,45.68,"Thelsamar"},{19.33,16.97,"North Gate Pass"},{35.52,18.07,"Silver Stream Mine"}}},
    {"Dam and eastern circuit:",{{45.01,13.07,"Stonewrought Dam"},{48.4,17.55,"The Loch"},{69.96,23.19,"Mo'grosh Stronghold"},{81.8,61.27,"The Farstrider Lodge"},{69.65,62.55,"Ironband's Excavation Site"}}},
},"These coordinates use the current drained Loch and broken dam. The Loch criterion can register near the water below the dam; do not rely on the center of the former full lake. The Farstrider Lodge is up the eastern hillside.",{"https://www.wowhead.com/achievement=779/explore-loch-modan#comments"})
explore(780,"Redridge Mountains",49,{
    {"Western and northern circuit:",{{16.96,64.59,"Three Corners"},{28.45,43.71,"Lakeshire"},{28.61,24.38,"Redridge Canyons"},{34.28,11.17,"Render's Camp"},{47.69,41.01,"Alther's Mill"}}},
    {"Lake and eastern circuit:",{{51.03,51.73,"Lake Everstill"},{53.78,53.97,"Camp Everstill"},{60.16,50.86,"Stonewatch Keep"},{70.28,34.66,"Galardell Valley"},{71.25,54.57,"Stonewatch Falls"},{78.73,63.04,"Shalewind Canyon"}}},
    {"Return along the southern bank:",{{66.75,70.39,"Render's Valley"},{42.49,66.07,"Lakeridge Highway"}}},
},"Camp Everstill is the camp with the flight point near Stonewatch Keep, on the lake's eastern side. It is distinct from Lake Everstill discovery. For Render's Camp you can trigger discovery on the approach without clearing the whole cave system.",{"https://www.wowhead.com/achievement=780/explore-redridge-mountains#comments"})
explore(781,"Northern Stranglethorn",50,{
    {"Northern and western circuit:",{{47.37,11.09,"Rebel Camp"},{44.13,23.25,"Nesingwary's Expedition"},{26.22,22.81,"Ruins of Zul'Kunda"},{19.81,23.98,"Zuuldaia Ruins"},{25.94,42.43,"The Vile Reef"},{34.6,35.78,"Bal'lal Ruins"},{37.79,50.21,"Grom'gol Base Camp"}}},
    {"Central circuit:",{{45.98,54.08,"Mizjah Ruins"},{42.95,41.82,"Kal'ai Ruins"},{52.35,34.51,"Lake Nazferiti"},{57.75,21.02,"Kurzen's Compound"}}},
    {"Eastern and southern circuit:",{{67.53,32.85,"Zul'Gurub"},{62.95,39.13,"Bambala"},{66.17,48.69,"Mosh'Ogg Ogre Mound"},{60.28,55.5,"Balia'mah Ruins"},{53,66.65,"Fort Livingston"}}},
},"Balia'mah is southwest of Mosh'Ogg, east of the main road; its revealed map patch is misleadingly farther west. Vile Reef is offshore. Booty Bay, Gurubashi Arena and the southern ruins belong to the separate Cape map, so skip the old full-Stranglethorn coordinate lists. Zul'Gurub only needs an outdoor discovery.",{1258703,1484373,1513500,1533284,1638338})
explore(782,"Swamp of Sorrows",51,{
    {"Western circuit:",{{16.84,58.94,"Purespring Cavern"},{24.94,48.53,"Splinterspear Junction"},{21.34,36.29,"Misty Valley"},{32.61,34.86,"The Harborage"},{35.05,42.82,"The Shifting Mire"},{42.77,59.58,"Stonard"}}},
    {"Eastern lake and northern coast:",{{62.41,54.62,"Pool of Tears"},{68.38,36.7,"Marshtide Watch"},{78.22,35.86,"Sorrowmurk"},{79.57,16.45,"Misty Reed Strand"},{76.34,9.96,"Bogpaddle"}}},
    {"Finish in the southeastern bog:",{{70.97,76.24,"Stagalbog"}}},
},"Pool of Tears is the lake around Sunken Temple, not the eastern sea; the later corrected comments place it near 62,55. Discovering the lake does not require entering the temple. Check the named criterion near Purespring's cave approach if the southwest map patch remains unclear.",{"https://www.wowhead.com/achievement=782/explore-swamp-of-sorrows#comments"})
explore(802,"Westfall",52,{
    {"Northern farms:",{{56.56,19.28,"The Jansen Stead"},{49.57,19.4,"Furlbrow's Pumpkin Farm"},{44.58,25.38,"Jangolode Mine"},{45.91,38.62,"The Molsen Farm"},{56.09,31.19,"Saldean's Farm"}}},
    {"Central and southeastern circuit:",{{56.85,47.31,"Sentinel Hill"},{60.91,58.69,"The Dead Acre"},{65.55,70.95,"The Dust Plains"},{39.91,80.56,"The Dagger Hills"}}},
    {"Southwestern circuit:",{{34.01,74.31,"Demont's Place"},{43.7,69.47,"Moonbrook"},{36.65,54.23,"Alexston Farmstead"},{38.49,42.59,"The Raging Chasm"}}},
},"The Raging Chasm is the large western vortex and also advances Surveying the Damage. Westfall Lighthouse appears in some route comments but is not one of the current thirteen criteria. Moonbrook discovery does not require a Deadmines run.",{"https://www.wowhead.com/achievement=802/explore-westfall#comments"})
explore(841,"Wetlands",56,{
    {"Western marsh circuit:",{{10.77,59.53,"Menethil Harbor"},{23.66,52.47,"Black Channel Marsh"},{17.26,37.17,"Bluegill Marsh"},{31.03,30.19,"Sundown Marsh"},{31.98,18.22,"Saltspray Glen"},{33.61,48.36,"Whelgar's Excavation Site"}}},
    {"Northern and central circuit:",{{44.01,43.36,"Angerfang Encampment"},{44.27,25.46,"Ironbeard's Tomb"},{49.9,18.19,"Dun Modr"},{60.87,25.46,"Direforge Hill"},{56.5,40.23,"Greenwarden's Grove"},{69.89,38.34,"Raptor Ridge"}}},
    {"Southern circuit:",{{64.44,53.25,"Mosshide Fen"},{57.46,71.7,"Slabchisel's Survey"},{53.06,63.55,"Thelgen Rock"},{48.06,74.43,"Dun Algaz"}}},
},"Thelgen Rock's accessible cave area counts; the tiny lake above it does not need to lose its map shading. Slabchisel's Survey is the southeastern dwarf camp near the lake above Dun Algaz. Grim Batol was moved out of this zone's checklist, so the old Dragonmaw Gate instructions are unnecessary.",{"https://www.wowhead.com/achievement=841/explore-wetlands#comments"})

explore(842,"Teldrassil",57,{
    {"First discover Rut'theran at the docks, then use its pink portal to enter Darnassus and get the separate city criterion. Leave Darnassus by its eastern gate to explore the tree's upper surface. Dock location:",{{55.4,88.4,"Rut'theran Village"}}},
    {"Western and southern circuit on top of the tree:",{{36.45,65.34,"Pools of Arlithrien"},{42.74,68.92,"Gnarlpine Hold"},{52.36,62.58,"Lake Al'Ameth"},{55.79,51.9,"Dolanaar"},{46.16,50.68,"Ban'ethil Hollow"}}},
    {"Northern circuit:",{{40.45,29.92,"The Oracle Glade"},{44.29,35.8,"Wellspring Lake"},{51.72,38.49,"The Cleft"},{60.17,39.13,"Shadowglen"}}},
    {"Finish at the eastern village:",{{64.51,50.49,"Starbreeze Village"}}},
},"The dock village is BELOW the tree canopy: flying directly onto the upper tree can miss it. The Cleft is the cave northwest of Dolanaar. If Pools of Arlithrien does not register at the lake, move toward the right edge of the Darnassus map banner around 40,58. Horde should approach city discovery carefully around hostile guards.",{"https://www.wowhead.com/achievement=842/explore-teldrassil#comments","https://www.wowhead.com/npc=141489/zidormi"},"Track Explore Teldrassil. If Teldrassil is burned, first speak to Zidormi in Darkshore at 48.9,24.5 and select the time BEFORE the burning. Travel northwest to restored Rut'theran Village, keeping an eye on fatigue during the sea crossing. This accessible past phase is still Retail.")
guides[842].waypoints[#guides[842].waypoints + 1] = pin(62,48.9,24.5,1,"Zidormi - restore Teldrassil before the burning")
guides[842].waypoints[#guides[842].waypoints + 1] = pin(89,36.6,49,2,"Darnassus - arrive through the Rut'theran portal")
explore(844,"Darkshore",62,{
    {"Northern circuit:",{{50.9,18.7,"Lor'danel"},{61.21,20.3,"Ruins of Mathystra"},{62.33,9.94,"Shatterspear War Camp"},{70.09,19.03,"Shatterspear Vale"}}},
    {"Central circuit:",{{43.96,39.82,"Withering Thicket"},{38.5,42.32,"Ruins of Auberdine"},{43.81,53.97,"The Eye of the Vortex"},{43.1,56.33,"Ameth'Aran"}}},
    {"Southern circuit and coastal island:",{{42.31,70.1,"Wildbend River"},{40.58,85.61,"The Master's Glaive"},{32.79,84.13,"Nazj'vel"}}},
},"Withering Thicket is north/northeast of Auberdine's ruins, not the northernmost shoreline. Nazj'vel is the southwestern coastal ruin/island. These are post-Cataclysm landmarks in the pre-Battle-for-Darkshore phase; the original intact Auberdine from Classic Era is not the destination.",{"https://www.wowhead.com/achievement=844/explore-darkshore#comments"},"Track Explore Darkshore. Speak to Zidormi at 48.9,24.5 if the Battle for Darkshore phase prevents discovery, and ask for Darkshore BEFORE the burning of Teldrassil. Use this original Darkshore map for the route.")
guides[844].waypoints[#guides[844].waypoints + 1] = pin(62,48.9,24.5,1,"Zidormi - pre-battle Darkshore")
explore(845,"Ashenvale",63,{
    {"Western circuit:",{{15.35,15.53,"The Zoram Strand"},{26.43,22.2,"Orendil's Retreat"},{26.79,36.08,"Maestra's Post"},{21.15,39.38,"Lake Falathim"},{21.54,47.41,"The Shrine of Aessina"},{35.32,53.42,"Astranaar"},{32.01,64.89,"The Ruins of Stardust"}}},
    {"Central circuit:",{{37.25,37.4,"Thistlefur Village"},{45.74,39.53,"Thunder Peak"},{53.68,40.06,"The Howling Vale"},{61.87,51.74,"Raynewood Retreat"},{51.48,61.66,"Silverwind Refuge"},{66.42,81.78,"Fallen Sky Lake"}}},
    {"Eastern circuit:",{{73.52,61.5,"Splintertree Post"},{80.55,68.48,"Felfire Hill"},{86.95,60,"Warsong Lumber Camp"},{80.74,49.68,"Satyrnaar"},{91.27,38.61,"Bough Shadow"}}},
},"Howling Vale lies in the northern hills: enter its cave area if flying over the valley fails, then relog there if discovery still refuses to update. Felfire Hill is near 80,68, not the obsolete 89,77. Current Thunder Peak and Silverwind Refuge criteria replace landmarks used in some old lists.",{1253971,1485963,1787495,2098603})
explore(846,"Thousand Needles",64,{
    {"Western and northern circuit:",{{12.08,10.09,"Westreach Summit"},{11.41,35.84,"Highperch"},{32.24,23.2,"The Great Lift"},{43.56,27.19,"Razorfen Downs"},{33.84,38.44,"Darkcloud Pinnacle"}}},
    {"Central circuit:",{{33.37,58.95,"Twilight Bulwark"},{45.63,50.53,"Freewind Post"},{58.24,62.88,"The Twilight Withering"}}},
    {"Eastern circuit:",{{70.44,61.19,"The Shimmering Deep"},{69.45,83.92,"Sunken Dig Site"},{91.45,75.71,"Southsea Holdfast"},{86.39,49.69,"Splithoof Heights"}}},
},"This is the flooded Retail zone. Flying is convenient; water walking/breathing can help ground travelers reach discovery boundaries safely. Freewind Post IS on the current checklist. The old Shimmering Flats, Screeching Canyon and Camp E'thok lists describe the previous dry zone.",{"https://www.wowhead.com/achievement=846/explore-thousand-needles#comments"})
explore(847,"Stonetalon Mountains",65,{
    {"Southern circuit:",{{64.28,91.62,"Boulderslide Ravine"},{68.48,84.69,"Webwinder Path"},{71.3,90.67,"Malaka'jin"},{73.37,87.91,"Greatwood Vale"},{75.09,77.58,"Unearthed Grounds"}}},
    {"Central circuit:",{{67.66,63.27,"Krom'gar Fortress"},{61.36,56,"Windshear Crag"},{58.52,54.91,"Windshear Hold"},{58.86,72.76,"Webwinder Hollow"},{49.56,72.81,"Ruins of Eldre'thar"},{49.7,62.15,"Sun Rock Retreat"}}},
    {"Northern and western circuit:",{{51.57,46.36,"Mirkfallon Lake"},{40.91,40.2,"Battlescar Valley"},{44.92,32.3,"Cliffwalker Post"},{40.67,17.02,"Stonetalon Peak"},{39.74,32,"Thal'darah Overlook"},{34.74,68.46,"The Charred Vale"}}},
},"Unearthed Grounds are in the SOUTHEAST near 75,78, not the incorrect 69,30 comment. Windshear Hold and Windshear Crag are separate criteria. Ruins of Eldre'thar lie south of Sun Rock Retreat around the small lake and ruined arches; fly over the ridge or follow connecting paths.",{"https://www.wowhead.com/achievement=847/explore-stonetalon-mountains#comments"})
explore(848,"Desolace",66,{
    {"Northern circuit:",{{29.18,7.98,"Ranazjar Isle"},{50.16,8.16,"Tethris Aran"},{66.35,6.74,"Nijel's Point"},{76.53,24,"Sargeron"},{55.22,28.89,"Thunder Axe Fortress"},{29.45,31.86,"Slitherblade Shore"}}},
    {"Central circuit:",{{64.76,48.63,"Cenarion Wildlands"},{72.46,46,"Magram Territory"},{52.24,58.73,"Kodo Graveyard"},{30.26,62.3,"Valley of Spears"},{36.65,71.48,"Thargad's Camp"}}},
    {"Southern circuit:",{{23.59,70.51,"Shadowprey Village"},{35.9,82.95,"Gelkis Village"},{51.17,77.64,"Mannoroc Coven"},{71.03,72.15,"Shok'Thokar"},{80.18,77.16,"Shadowbreak Ravine"}}},
},"Ranazjar Isle is the small island just off the far northwestern coast; do not miss it when circling the mainland. Shadowbreak Ravine's ground entrance is around 77,76. The central green Cenarion Wildlands and current Magram Territory are the Retail landmarks, replacing the old barren-zone list.",{"https://www.wowhead.com/achievement=848/explore-desolace#comments"})
explore(849,"Feralas",69,{
    {"Western circuit:",{{46.25,17.53,"The Twin Colossals"},{31.34,44.61,"Ruins of Feathermoon"},{43.87,45.33,"The Forgotten Coast"},{45.95,45.36,"Feathermoon Stronghold"},{55.99,57.23,"Feral Scar Vale"}}},
    {"Central and eastern circuit:",{{59.14,45.85,"Dire Maul"},{69.52,38.84,"Grimtotem Compound"},{75.52,30.48,"Gordunni Outpost"},{75.25,43.76,"Camp Mojache"},{77.4,52.59,"Lower Wilds"}}},
    {"Southern circuit:",{{76.4,61.32,"The Writhing Deep"},{65.09,59.59,"Darkmist Ruins"},{58.48,71.75,"Ruins of Isildien"}}},
},"Ruins of Feathermoon are on the western island; the current Feathermoon Stronghold is on the mainland and needs its own discovery. Both are accessible by flying/swimming in Retail. Dream Bough, Oneiros, Frayfeather Highlands and Isle of Dread are absent from this current thirteen-criterion checklist.",{"https://www.wowhead.com/achievement=849/explore-feralas#comments"})
explore(850,"Dustwallow Marsh",70,{
    {"Northern circuit:",{{36.09,31.28,"Brackenwall Village"},{45.07,16.55,"Blackhoof Village"},{58.16,15.97,"Dreadmurk Shore"},{71.61,18.79,"Alcaz Island"}}},
    {"Central circuit:",{{66.07,49.04,"Theramore Isle"},{46.88,47.11,"Direhorn Post"},{29.7,48,"Shady Rest Inn"}}},
    {"Southern circuit:",{{41.97,72.99,"Mudsprocket"},{52.12,75.52,"Wyrmbog"}}},
},"Shady Rest Inn is the burned building beside the WESTERN road at the Southern Barrens border. Go right into/over its footprint; a distant flyby can miss it. Alcaz Island is offshore to the northeast. If your Theramore phase prevents discovery, Zidormi by the western approach can show the city before its destruction.",{1337329,1487764,1518739,1598077,1797491,2624897})
explore(851,"Tanaris",71,{
    {"Northern circuit:",{{51.4,29.28,"Gadgetzan"},{39.27,21.47,"Sandsorrow Watch"},{39.38,20.62,"Zul'Farrak"},{44.86,40.16,"Abyssal Sands"},{52.86,45.72,"Broken Pillar"}}},
    {"Eastern circuit:",{{64.56,50.07,"Caverns of Time"},{72.23,47.07,"Lost Rigger Cove"},{64.09,60.36,"Southbreak Shore"}}},
    {"Southern circuit:",{{53.88,68.19,"The Gaping Chasm"},{47.28,64.75,"Eastmoon Ruins"},{49.45,84.76,"Land's End Beach"},{40.83,72.1,"Southmoon Ruins"},{37.47,78.58,"Valley of the Watchers"}}},
    {"Western circuit:",{{30.62,64.56,"Thistleshrub Valley"},{34.25,47.71,"The Noxious Lair"},{41.3,56.76,"Dunemaul Compound"}}},
},"Land's End Beach is reached through the southern cliff gap south of Eastmoon Ruins; no fatigue swim to the distant islands is needed. Zul'Farrak and Caverns of Time need outdoor discovery, not instance completion. Old Steamwheedle Port and Noonshade Ruins are not current criteria.",{1370277,1487682,1629633,1890400})
explore(852,"Azshara",76,{
    {"Western circuit:",{{26.75,77.96,"Orgrimmar Rear Gate"},{21.04,57.16,"Gallywix Pleasure Palace"},{25.47,38,"Bear's Head"},{33.06,32.76,"Blackmaw Hold"},{31.95,50.02,"Ruins of Eldarath"},{39.21,55.46,"The Shattered Strand"}}},
    {"Northern and harbor circuit:",{{52.25,26.95,"Darnassian Base Camp"},{73.69,20.98,"Bitter Reaches"},{80.9,32.34,"Tower of Eldara"},{69.89,34.83,"Ruins of Arkkoran"},{58.29,51,"Bilgewater Harbor"}}},
    {"Southern circuit:",{{68.41,75.62,"Southridge Beach"},{64.65,79.31,"Ravencrest Monument"},{56.99,76.5,"Storm Cliffs"},{46.54,76.25,"The Secret Lab"},{39.83,84.67,"The Ruined Reaches"},{35.72,73.99,"Lake Mennar"}}},
},"Use the current goblin-shaped Azshara map, not pre-Cataclysm coordinates. Ruined Reaches are on the shoreline below the Secret Lab. Blackmaw Hold is the required local area, not Felwood's Timbermaw tunnel. Flying avoids the cliffs; ground travelers can use the rocketway for much of the circuit and paths down to the shore.",{1266143,1449166,1484587,1518668,1792737,2006737})
explore(853,"Felwood",77,{
    {"Southern circuit:",{{48.25,85.41,"Deadwood Village"},{53.62,83.86,"Morlos'Aran"},{51.75,81.23,"Emerald Sanctuary"},{43.42,83.49,"Jadefire Glen"},{41.9,65.59,"Ruins of Constellas"}}},
    {"Central circuit:",{{41.35,56.04,"Jaedenar"},{46.12,47.48,"Bloodvenom Falls"},{39.88,39.26,"Shatter Scar Vale"}}},
    {"Northern circuit:",{{45,15.82,"Jadefire Run"},{49.78,16.84,"Irontree Woods"},{63.1,21.57,"Talonbranch Glade"},{63,10,"Felpaw Village"}}},
},"Jadefire Glen and Jadefire Run are different sites at opposite ends of the zone. Ruins of Constellas lie between Jaedenar and the southern glen; descend toward the ruins if flying above them does not credit discovery. Felpaw discovery does not require entering Timbermaw Hold or earning its reputation.",{1677213,2098593})
explore(854,"Un'Goro Crater",78,{
    {"Western and central circuit:",{{29.87,37.1,"The Screaming Reaches"},{29.02,58.79,"Golakka Hot Springs"},{31.88,64.14,"Terror Run"},{43.36,41.43,"Mossy Pile"},{49.87,47.03,"Fire Plume Ridge"}}},
    {"Northern and eastern circuit:",{{53.3,26.51,"Lakkari Tar Pits"},{61.17,17.37,"Fungal Rock"},{77.41,30.87,"Ironstone Plateau"},{68.46,36.66,"The Roiling Gardens"},{64.84,55.19,"The Marshlands"}}},
    {"Southern circuit:",{{55.12,62.37,"Marshal's Stand"},{50.3,79.6,"The Slithering Scar"}}},
},"Ironstone Plateau is UP on the eastern rim, northeast of the eastern pylon, not the crater floor beneath its covered map patch. Fly onto the plateau, or climb the hillside around 75.9,32.5. Current Marshal's Stand and Mossy Pile are separate discoveries; do not substitute the old Marshal's Refuge.",{1487600,1629515,2543337})
explore(855,"Moonglade",80,{
    {"Western and northern circuit:",{{36.15,41.64,"Shrine of Remulos"},{48.5,39.36,"Nighthaven"}}},
    {"Lake and southeastern circuit:",{{56.5,55.87,"Lake Elune'ara"},{68.01,60.24,"Stormrage Barrow Dens"}}},
},"Simply arriving or using Teleport: Moonglade no longer completes the current four-area checklist. Non-druids can fly in, or take Timbermaw Hold's Moonglade branch from Felwood/Winterspring; use the branch inside the tunnel instead of walking all the way out to Winterspring.",{525893,1274143,1484341,1535468,1555340,2098577})
explore(856,"Silithus",81,{
    {"Northern circuit:",{{81.13,18.7,"Valor's Rest"},{53.77,34.53,"Cenarion Hold"},{49.43,24.08,"Hive'Ashi"},{34.56,14.8,"The Crystal Vale"}}},
    {"Western and southern circuit:",{{32.36,52.3,"Hive'Zora"},{35.91,83.42,"The Scarab Wall"},{59.71,70.85,"Hive'Regal"},{64.62,50.1,"Southwind Village"}}},
},"Southwind Village IS on the current eight-criterion list, despite an older comment excluding it. Twilight Base Camp may reveal more shading but is not required. For Scarab Wall, approach the open Ahn'Qiraj gate; no raid entry or old gate-opening quest is necessary.",{1486181,1629962,1686231,2573525,3146741,5996386},"Track Explore Silithus. If the giant sword has destroyed Cenarion Hold in your phase, speak to Zidormi at 78.8,22.0 and select Silithus BEFORE the wound. Use the original Silithus map and the accessible past-phase landmarks below.")
guides[856].waypoints[#guides[856].waypoints + 1] = pin(81,78.8,22,1,"Zidormi - Silithus before the wound")
explore(857,"Winterspring",83,{
    {"Western and northern circuit:",{{31.72,49.7,"Frostfire Hot Springs"},{36.92,55.71,"Timbermaw Post"},{49.78,54.1,"Lake Kel'Theril"},{48.8,41.08,"Starfall Village"},{46.11,15.35,"Frostsaber Rock"},{62.76,25.67,"The Hidden Grove"}}},
    {"Eastern and southern circuit:",{{66.62,47.73,"Winterfall Village"},{59.73,50.41,"Everlook"},{66.9,54.59,"Ice Thistle Hills"},{55.95,63.54,"Mazthoril"},{63.15,75.14,"Owl Wing Thicket"},{62.13,86.08,"Frostwhisper Gorge"}}},
},"The Hidden Grove is reached through the short tunnel around 64.1,28 when on foot. Frostwhisper Gorge requires entering the gorge, rather than only crossing above it. Darkwhisper Gorge from old lists is no longer a Winterspring criterion; current coordinates use the zone's post-Cataclysm bounds.",{508801,1448937,1484339,1628707,2098580})

local scoutingVendors = {pin(87,74.6,9.8,2,"Krom Stoutarm - Alliance scouting maps"),pin(85,56.8,89.8,2,"Estelle Gendry - Horde scouting maps, atop the gate")}
add(42,"Eastern Kingdoms Explorer",{
    "Choose the scouting-map shortcut or the exploration route. First check your Toy Box for the Eastern Kingdoms scouting map; an already learned copy can be used again without buying another.",
    "For the shortcut, Alliance buy Scouting Map: Modern Provisioning of the Eastern Kingdoms from Krom Stoutarm in Ironforge (74.6,9.8). Horde buy Scouting Map: The Eastern Kingdoms Campaign from Estelle Gendry atop Orgrimmar's main gate (56.8,89.8). The base price is 10,000 gold; it does not require already earning this exploration meta.",
    "Learn and USE the toy on your character, then check Eastern Kingdoms Explorer and its zone criteria. The current map grants exploration as well as flight paths; older comments saying it teaches only a few flight paths predate the update. Finish any criterion still missing rather than buying the wrong continent's map.",
    "For manual exploration, track each missing zone achievement and use its detailed route. Southern circuit: Elwynn -> Westfall -> Duskwood -> Northern Stranglethorn -> the Cape -> Deadwind Pass -> Swamp of Sorrows -> Blasted Lands. Use Zidormi at Blasted Lands 48.2,7.2 for its pre-invasion phase.",
    "Northern circuit: Tirisfal -> Silverpine -> Hillsbrad -> Arathi -> Hinterlands -> Western Plaguelands -> Eastern Plaguelands, plus Ghostlands, Eversong Woods (Burning Crusade) and Isle of Quel'Danas. Use Zidormi at Tirisfal 69.5,62.8 for pre-battle Lordaeron. After Midnight, enter the old Ghostlands portal beside Zidormi at Eastern Plaguelands 53.8,8.6; Horde can also use Orgrimmar's downstairs Silvermoon (Burning Crusade) portal. For old Quel'Danas, use Shattrath's portal behind Exarch Nasuun at 49.0,42.3. The new Midnight Eversong achievement is separate.",
    "Central circuit: Wetlands -> Loch Modan -> Dun Morogh -> Badlands -> Searing Gorge -> Burning Steppes -> Redridge. Recheck the meta's 25 zone criteria; visiting a zone once is insufficient unless every required subzone discovery credited.",
},scoutingVendors,"The scouting-map purchase is optional. The current 25-zone checklist does not add Gilneas, Twilight Highlands, Vashj'ir or other Cataclysm expansion zones. Old comments requiring city entries beyond the current zone checklists are outdated.",{1758596,5725937,"https://www.wowhead.com/item=150746#comments:id=5275402","https://www.wowhead.com/item=150746#comments:id=5276150","https://www.wowhead.com/npc=259326/zidormi","https://www.wowhead.com/npc=6294/krom-stoutarm","https://www.wowhead.com/npc=6566/estelle-gendry"},"Exploration")
guides[42].areaMaps = {37,52,47,50,210,42,51,17,18,21,25,14,26,22,23,95,94,122,56,48,27,15,32,36,49}
guides[42].waypoints[#guides[42].waypoints + 1] = pin(23,53.82,8.61,5,"Old Ghostlands portal beside Zidormi - Burning Crusade exploration")
guides[42].waypoints[#guides[42].waypoints + 1] = pin(17,48.2,7.2,4,"Zidormi - pre-invasion Blasted Lands")
guides[42].waypoints[#guides[42].waypoints + 1] = pin(18,69.5,62.8,5,"Zidormi - pre-battle Tirisfal")
guides[42].waypoints[#guides[42].waypoints + 1] = pin(111,49,42.3,5,"Shattrath - portal to old Quel'Danas")
guides[42].sources[#guides[42].sources + 1] = "https://www.wowhead.com/object=187056/portal-to-isle-of-queldanas"
add(43,"Kalimdor Explorer",{
    "Choose the scouting-map shortcut or the exploration route. Check your Toy Box first: an already learned Kalimdor scouting map can simply be used again.",
    "For the shortcut, Alliance buy Scouting Map: Surviving Kalimdor from Krom Stoutarm in Ironforge (74.6,9.8). Horde buy Scouting Map: Walking Kalimdor with the Earthmother from Estelle Gendry atop Orgrimmar's main gate (56.8,89.8). The base price is 10,000 gold, with no prior Explorer achievement requirement.",
    "Learn and USE the toy, then check Kalimdor Explorer and its zone achievements. Since the map update it grants exploration as well as flight paths. Complete any remaining criterion using its individual zone guide; do not buy an Eastern Kingdoms or Cataclysm map for this continent.",
    "For a manual route, start with the northwestern group: Teldrassil -> Darkshore -> Ashenvale -> Felwood -> Moonglade -> Winterspring. Restore pre-burning Teldrassil/Darkshore through Zidormi at Darkshore 48.9,24.5. Include BOTH Azuremyst and Bloodmyst Isles from the meta's checklist.",
    "Central group: Azshara -> Durotar -> Northern Barrens -> Mulgore -> Southern Barrens -> Dustwallow Marsh. Work on each zone's missing SUBZONES; old lists treating the Barrens as a single map are outdated.",
    "Western/southern group: Stonetalon -> Desolace -> Feralas -> Thousand Needles -> Tanaris -> Un'Goro -> Silithus. Use the flooded Thousand Needles route and Zidormi's pre-wound Silithus. Check the 21 zone criteria after the last circuit.",
},{pin(87,74.6,9.8,2,"Krom Stoutarm - Alliance scouting maps"),pin(85,56.8,89.8,2,"Estelle Gendry - Horde scouting maps, atop the gate"),pin(62,48.9,24.5,4,"Zidormi - pre-burning Darkshore and Teldrassil"),pin(81,78.8,22,6,"Zidormi - Silithus before the wound")},"Hyjal and Uldum exploration belong to other achievements. Use the accessible pre-burning phase for Teldrassil and the pre-wound phase for Silithus. Check the meta's actual zone criteria after using a scouting map.",{1758597,5725938,"https://www.wowhead.com/item=150743#comments:id=3225088","https://www.wowhead.com/item=150743#comments:id=5275401","https://www.wowhead.com/item=150743#comments:id=5276152","https://www.wowhead.com/npc=6294/krom-stoutarm","https://www.wowhead.com/npc=6566/estelle-gendry"},"Exploration")
guides[43].areaMaps = {57,62,63,77,80,83,97,106,76,1,10,7,199,70,65,66,69,64,71,78,81}

add(1676,"Loremaster of Eastern Kingdoms",{
    "Track the CURRENT meta and expand its nested criteria. It now requires zone STORY achievements, not an old 700-quest total. Enable Trivial Quests on the minimap, then track the individual unfinished zone achievement so its chapter names appear in your objective tracker.",
    "Choose the appropriate alternatives already credited on your account: Redridge OR Hillsbrad; Westfall & Duskwood OR Silverpine; Loch Modan & Wetlands OR Ghostlands. You do not need both factions' alternatives. If using an Alliance combined criterion, finish the component zones on one character and confirm the combined achievement awards.",
    "Southern route: finish your chosen Westfall/Duskwood or Silverpine branch, Redridge or Hillsbrad, then Northern Stranglethorn and the Cape's separate quest stories. Follow each hub's follow-up quests instead of leaving when a breadcrumb sends you elsewhere. If Bloodsail hostility blocks Booty Bay, use an alt without that reputation conflict.",
    "Southeastern route: complete Swamp of Sorrows, pre-invasion Blasted Lands, Burning Steppes, Searing Gorge and Badlands. Follow the faction introduction to Burning Steppes' opening hub so its long story unlocks. Zidormi restores the required Blasted Lands phase.",
    "Northern route: complete your chosen Loch Modan/Wetlands or Ghostlands branch, Arathi, Hinterlands, Western Plaguelands and Eastern Plaguelands. Use Zidormi for pre-Warfront Arathi. For Ghostlands after Midnight, take the old-zone portal beside Zidormi at Eastern Plaguelands 53.8,8.6, rather than doing the new Eversong campaign.",
    "If a chapter stalls, check the last completed quest and its next quest giver, including items in your bags that begin quests. A quest-chain viewer such as BtWQuests with its Cataclysm/old-world data can show the missing prerequisite. For a quest that requires weakening a trivial enemy, remove damage gear or use an appropriate nonlethal tool/leveled alt instead of repeatedly killing it.",
    "Finish every current top-level criterion and recheck the meta. Starting-zone Elwynn/Dun Morogh quests, dungeon repeatables and arbitrary extra quest counts do not substitute for an unfinished story chapter.",
},{pin(17,48.2,7.2,4,"Zidormi - pre-invasion Blasted Lands quests"),pin(14,38.2,90,5,"Zidormi - switch to pre-Warfront Arathi"),pin(23,53.82,8.61,5,"Old Ghostlands portal beside Zidormi")},"Completed zone achievements can contribute across alts, but faction-specific and combined criteria need their actual green credit in this meta. Old EveryQuest instructions, fixed continent totals and removed pre-Cataclysm quest chains are not the current requirements.",{1180592,1190533,1201082,1690853,1964214,2869298,3287934,5585117,5952042,6085685,"https://www.wowhead.com/npc=88206/zidormi","https://www.wowhead.com/npc=141649/zidormi"},"Quests")
guides[1676].areaMaps = {52,47,21,49,25,50,210,51,17,36,32,15,48,56,95,14,26,22,23}
add(1678,"Loremaster of Kalimdor",{
    "Track the CURRENT meta and the individual unfinished zone STORY achievement. Enable Trivial Quests. This requires chapters in the listed zones, not the obsolete 700-quest counter or every quest on Kalimdor.",
    "Choose the applicable alternative for Darkshore OR Azshara and Bloodmyst OR Northern Barrens. Ashenvale, Dustwallow, Feralas, Southern Barrens and Stonetalon each display faction-specific versions: complete the version your character can actually quest through, not both factions' stories.",
    "Northern route: complete the chosen Darkshore/Azshara and Bloodmyst/Northern Barrens branches, Ashenvale, Felwood and Winterspring. Use Zidormi at Darkshore 48.9,24.5 to restore pre-battle questing if needed. Follow the named chapter chains through their finales, not merely a tour of the zone.",
    "Western route: complete Stonetalon Mountains, Desolace and Feralas. Desolace IS required by the current meta, despite an old comment excluding it. Continue the local story from one quest hub to the next and check chapter credit before moving on.",
    "Southern route: complete Southern Barrens, Dustwallow Marsh, Thousand Needles, Tanaris and Un'Goro. Use your faction's starting chain and follow the flooded-zone story in Thousand Needles. For any weaken/capture objective, avoid one-shotting the target; a leveled alt or suitable nonlethal tool can resolve it.",
    "Complete Silithus in its pre-wound phase through Zidormi at 78.8,22.0. If Steamwheedle hostility blocks Gadgetzan or another goblin hub, finish that zone on an alt with normal goblin reputation instead of sacrificing pirate reputation on your main.",
    "Recheck every top-level criterion, including Tanaris if the UI collapses or hides its entry. If a chapter is missing, follow its last completed quest and next giver; BtWQuests with the relevant old-world data can help locate the broken chain. Stop when all current chapter achievements credit the meta.",
},{pin(62,48.9,24.5,3,"Zidormi - old Darkshore quest phase"),pin(81,78.8,22,6,"Zidormi - pre-wound Silithus quests")},"A finished zone achievement may contribute from an alt. Check the meta's actual faction/alternative credit instead of repeating unavailable opposite-faction quests. Mount Hyjal, Uldum and the racial starting-zone stories are not additional criteria for this meta.",{1102267,1282303,1690852,1964213,2152177,5769746,5952008,6085682},"Quests")
guides[1678].areaMaps = {62,76,106,10,63,77,83,65,66,69,199,70,64,71,78,81}

mountAchievement(424,"Why? Because It's Red",26054,{390614,527690,685055,829934,1362745,1640339,1716778,1859952})
guides[424].tips = "Farm the Temple's entrance trash with Skeram alive if using instance resets, or loot trash during weekly full clears for Brood of Nozdormu reputation. Red is rarer than the other three colors, but is still obtainable. No particular kill count guarantees it; the mount is usable only inside AQ40."
add(150,"The Fishing Diplomat",{
    "Learn Fishing and fish up an item in your OWN capital first: Stormwind for Alliance or Orgrimmar for Horde. Loot the catch and check that half of the achievement before traveling. This requires one catch in BOTH cities, not a rare fish.",
    "For Stormwind, use a canal or its harbor water. Horde can fly/swim north along Westfall's coast and land on a small shore/ruin ledge south of the harbor around Stormwind 30.1,85.8. Confirm your minimap has changed to Stormwind before casting; fishing from Westfall does not count.",
    "For Orgrimmar, use the Valley of Honor water. Alliance can approach from the northern hills and land at the top of the waterfall around 58.35,29.37. Watch the flying guard patrol before descending; the lower waterfall around 58,35 is another documented fishing spot. Confirm that you are inside Orgrimmar's boundary.",
    "Cast, wait for the bobber splash, and LOOT the catch in the second city. Check the achievement, then leave or hearth. A Fishing skill-up with an empty loot window is not a catch. You can stay in Orgrimmar for Old Crafty if you accept the extra exposure to guards and players.",
},{pin(84,30.1,85.8,2,"Stormwind - harbor coast fishing ledge"),pin(85,58.35,29.37,3,"Orgrimmar - upper waterfall fishing spot"),pin(85,58,35,3,"Orgrimmar - lower waterfall alternative")},"City Fishing works with low skill; no special rare fish or 300-skill prerequisite is required. Guards can see stealth and flying patrols can attack. The removed Wrathgate neutral-city quest phase and the Siege of Orgrimmar raid are not reliable substitutes for the actual cities.",{338770,994564,1088716,1544308,1690112,1760213,1977881,5180540,5312282,5754842,6050805},"Fishing")

add(306,"Master Angler of Azeroth",{
    "Check the in-game calendar for the Stranglethorn Fishing Extravaganza and arrive BEFORE its start. It is a Sunday event in the region's schedule; local dates and realm clocks can differ. The current competition awards the first 50 finishers across the REGION, not the first three on your realm.",
    "Learn Fishing, clear bag space, enable auto-loot and put Fishing on a convenient key. Set your hearthstone at Booty Bay's inn beside Riggle Bassbait (Cape 41.5,73.0), and make sure it will be ready for the return. Find Fish, flying and water walking help, but maximum Fishing skill is not required.",
    "Scout an uncrowded stretch of Northern Stranglethorn or the Cape before the event begins. Suggested Northern Stranglethorn starting areas are the northwestern islands around 20,40, the inland water around 52.6,29.1, or the bay by Grom'gol around 43,58. Choose available pools instead of following a crowd along one fixed route.",
    "When the world quest appears, fish INTO pools and loot Speckled Tastyfish. Current Retail pools in these two zones can supply them, including ordinary fish schools and wreckage; do not waste time searching only for pools named Tastyfish. No advance quest pickup is needed.",
    "Collect 40 Speckled Tastyfish on your character. Move immediately to another pool when one is exhausted or contested. Check the actual fish count, not the number of casts; other catches are normal. Avoid falling far enough to break water walking between schools.",
    "As soon as you have 40, hearth to Booty Bay and turn them in to Riggle Bassbait at 41.5,73.0. Choose the offered prize and COMPLETE the turn-in before the regional winner limit is reached. Catching the fish without finishing the hand-in does not win.",
    "Check the achievement after turning in. If the competition has already filled, try again at the next weekly event with a quieter starting area and the return trip prepared. The retired Kalu'ak Fishing Derby is not an alternative Retail route.",
},{pin(210,41.5,73,2,"Booty Bay - Riggle and inn preparation"),pin(50,20,40,3,"Northwestern islands - scout fishing pools"),pin(50,52.61,29.07,3,"Northern Stranglethorn - inland pool alternative"),pin(50,43,58,3,"Grom'gol bay - coastal pool alternative"),pin(210,41.5,73,6,"Riggle Bassbait - hand in 40 fish immediately")},"The start time shown by the event and world quest is more reliable than an old guide's server-clock conversion. War Mode and shards do not change the regional winner limit. Choose a route with pools available, and prepare the hearthstone before starting.",{1768694,2494351,2615541,3202388,3252086,5172659,5243807,5331895,5755234,6172006,6172054,6408796,6416992,"https://www.wowhead.com/quest=44765/stranglethorn-fishing-extravaganza","https://www.wowhead.com/npc=15077/riggle-bassbait"},"Fishing")

add(1836,"Old Crafty",{
    "Learn Fishing and go to Orgrimmar. For the account achievement, using a Horde alt avoids hostile city guards; the fish does not have to be caught by an Alliance main. Skill 1 can catch it, so leveling Fishing to a cap is not a prerequisite.",
    "Fly or walk to the Valley of Honor pond. The ledge behind the waterfall around Orgrimmar 62,39 is a documented fishing spot, with recent catches around 61.8,38.6 and 63.4,38.8. Cast into the actual pond, not the waterfall's rock face.",
    "Keep fishing in the pond and loot each catch until Old Crafty appears. Free bag space regularly. This is a rare random catch: moving after an arbitrary number of casts, using a particular pole, or reaching a claimed skill total does not guarantee it.",
    "Watch the loot window before casting again. If a bind confirmation appears, accept it and make sure Old Crafty reaches your bags. Confirm the achievement before leaving; merely seeing the fish in the loot window, buying it or trading another player's fish does not count.",
},{pin(85,62,39,2,"Valley of Honor - fish behind the waterfall")},"Alliance can fly to the waterfall ledge, but flying patrols and city guards can still attack; use a Horde alt if you only need account credit. The old Crocolisks in the City exploit and removed Wrathgate neutral-city phase are not current methods. This rare fish is not required for the Salty meta.",{423034,1714013,2226329,3296316,3306870,5843192,5913458,6090434,6149915,6163705,6385793,6410296,6413998},"Fishing")
add(1837,"Old Ironjaw",{
    "Learn Fishing and go to Ironforge. Horde players who only need the account achievement can use an Alliance alt instead of infiltrating the opposing capital. High Fishing skill and special fishing gear are not required to begin.",
    "Go to the Forlorn Cavern pond in northern Ironforge. Grimnur Stonebrand, up the steps at the northern edge, can train Fishing. Fish from the back of the pond, or the ledge around 50.65,14.68; the back wall reduces exposure to passing guards if you are Horde.",
    "Continue casting into this pond and looting catches until Old Ironjaw appears. Keep space in your bags. Catch counts reported by other players are examples of random luck, not a required number or a guaranteed time limit.",
    "When the rare fish appears, finish looting it before your next cast. Accept a bind confirmation if one is shown, verify the fish is in your bags and check the achievement. If an auto-loot setup is skipping confirmations, loot manually rather than repeatedly recasting over the rare catch.",
},{pin(87,48.4,8.2,2,"Grimnur Stonebrand - trainer above the pond"),pin(87,50.65,14.68,2,"Forlorn Cavern - fishing ledge")},"Use the actual Forlorn Cavern pond. Fishing in the Great Forge lava was patched out, and the old Mystic Ward pool is not an alternative. Horde can fly through the main entrance and continue to the cavern, but an Alliance alt avoids that trip's guard risk. This fish is not required for the Salty meta.",{423038,678968,1321653,1714014,1955982,2045114,2327143,2557272,5658647,5912167,6067005,6091284,6293214,"https://www.wowhead.com/npc=5161/grimnur-stonebrand"},"Fishing")

add(1244,"Well Read",{
    "Track the 42 unread titles in Well Read. Click each ORIGINAL world book to open it, then check its criterion before leaving; paging through every page is unnecessary. The circuit below includes Alliance cities, so an Alliance character is easier. Use the same character for the whole circuit instead of relying on partial progress from several alts.",
    "Stormwind Keep, Royal Library around 85,24: check tables, stools AND the tops of short pillars for Aegwynn and the Dragon Hunt; Aftermath of the Second War; Beyond the Dark Portal; Civil War in the Plaguelands; The Alliance of Lordaeron; The Guardians of Tirisfal; The Kaldorei and the Well of Eternity; The New Horde; The War of the Ancients; The World Tree and the Emerald Dream. There are several close objects: opening one book does not read the neighboring titles.",
    "Still in Stormwind Keep, enter the battle/war room around 86.7,36.0. Read The Dark Portal and the Fall of Stormwind and War of the Spider from the central table; The Battle of Grim Batol is an additional copy here. If ALL library books are absent, finish the Keep's pending Darkshore introduction/phasing before returning, rather than searching empty tables indefinitely.",
    "Stormwind Mage Quarter around 51.9,74.6: enter the house beside the inscription trainer, using its canal-side approach. Read Archimonde's Return and the Flight to Kalimdor and Mount Hyjal and Illidan's Gift. These are in the small house, not the Royal Library.",
    "Elwynn Forest, Eastvale Logging Camp around 85.3,69.7: go upstairs in the inn/Marshal Haggard building and read Lethargy of the Orcs from the table. If Icecrown and the Frozen Throne is still missing later, Goldshire's inn has an upstairs copy around 43.8,65.7.",
    "Duskwood, Darkshire's Scarlet Raven inn: go upstairs. The right-hand bedroom table around 73.6,45.1 has The Founding of Quel'Thalas; the left room around 74.1,45.4 has Kil'jaeden and the Shadow Pact. Mount Hyjal and Illidan's Gift is another upstairs copy if you missed it in Stormwind.",
    "Booty Bay, Cape of Stranglethorn: read Sunwell - The Fall of Quel'Thalas on the Salty Sailor Tavern's second floor (41.0,74.4), with another Beyond the Dark Portal copy on its third floor (40.6,73.8). Above Sea Wolf MacKinley's house, The Sentinels and the Long Vigil is by the bed (42.2,73.6). Descend TWO flights below MacKinley to Auctioneer Kresky's room (42.1,73.7): read Empires' Fall, The Twin Empires, Wrath of Soulflayer and The Scourge of Lordaeron from its tables/shelves, including the shelf under the stairs.",
    "Ironforge, Hall of Explorers around 75.7,11.0: search the central table and the four tables around the curved room for Arathor and the Troll Wars; Charge of the Dragonflights; Civil War in the Plaguelands; Ironforge - the Awakening of the Dwarves; Rise of the Horde; The Alliance of Lordaeron; The Battle of Grim Batol; The Old Gods and the Ordering of Azeroth; War of the Three Hammers. Some are duplicates from earlier stops; verify all nine titles.",
    "Loch Modan, Thelsamar around 37.2,46.9: enter the eastern house with Brock and Jern outside and read The Last Guardian downstairs. Use this copy instead of Sentinel Hill's inn, where Westfall quest phasing can make the old copy inaccessible.",
    "Western Plaguelands, enter CURRENT Normal Scholomance at Caer Darrow (69.1,73.0). Clear through Rattlegore to Lilian Voss's encounter room. Read The Invasion of Draenor, the small red/pink book on the northeastern wall ledge beside a candelabra, around 56.6,41.3 on that room's map. This is not one of the quest books you burn; no restored Old Scholomance unlock is required.",
    "Eastern Plaguelands, enter Stratholme through the MAIN Gate (27.1,11.6), then take the western Scarlet Bastion/Crusader's Square route. Check Commander Malor's room near 30.2,41.5 for The Seven Kingdoms. Search the alcoves and tables around Instructor Galford's library near 25.5,70.9 for The Lich King Triumphant; Kel'Thuzad and the Forming of the Scourge; The Birth of the Lich King; Icecrown and the Frozen Throne; War of the Spider; The Scourge of Lordaeron; and Kil'jaeden and the Shadow Pact if still missing. The service-entrance undead half is not this library route.",
    "Tanaris, Gadgetzan around 51.0,30.3: read Old Hatreds - The Colonization of Kalimdor from the ground beside Derotain's anvil, baskets and machinery. It is no longer beside the flight master. Gadgetzan's inn also has copies of Empires' Fall, The Twin Empires and Wrath of Soulflayer if you missed Booty Bay's lower room.",
    "Restore pre-burning Teldrassil through Zidormi in Darkshore (48.9,24.5), travel through Rut'theran to Darnassus, and read two books: The Betrayer Ascendant at Tradesmen's Terrace (61.9,74.7), and Rise of the Blood Elves on the ground-floor table behind the mining trainer at Craftsmen's Terrace (49.9,33.5). The burned present-day city is not the destination.",
    "Northern Barrens, Ratchet: read Exile of the High Elves on the upstairs balcony of Jazzik's General Goods/blacksmith building (67.1,73.4), and Sargeras and the Betrayal on a low table between the beds behind the inn's keg (67.0,75.0). If needed, the nearby hut at 68.0,73.5 has Archimonde's Return and the Flight to Kalimdor, and the inn at 66.9,74.7 has Mount Hyjal and Illidan's Gift.",
    "Recheck the full list of 42 titles, including entries below the achievement panel's visible area. Return only for unread titles. Temporary inventory reprints from Legion Dalaran or Love is in the Air's Historic Lore Books do NOT replace reading the original objects for this achievement.",
},{
    pin(84,85,24,2,"Royal Library - ten book titles"),pin(84,86.7,36,3,"Stormwind Keep - battle room books"),pin(84,51.9,74.6,4,"Mage Quarter - house beside inscription trainer"),
    pin(37,85.3,69.7,5,"Eastvale - Lethargy of the Orcs upstairs"),pin(37,43.8,65.7,5,"Goldshire - optional Icecrown copy upstairs"),pin(47,73.62,45.05,6,"Scarlet Raven - Founding, upstairs right"),pin(47,74.09,45.37,6,"Scarlet Raven - Kil'jaeden, upstairs left"),
    pin(210,41.04,74.44,7,"Salty Sailor - Sunwell, second floor"),pin(210,40.59,73.8,7,"Salty Sailor - Beyond, third floor"),pin(210,42.2,73.63,7,"Above MacKinley - Sentinels"),pin(210,42.08,73.72,7,"Below MacKinley - four books by Kresky"),
    pin(87,75.65,11.02,8,"Hall of Explorers - nine titles around the tables"),pin(48,37.16,46.93,9,"Thelsamar - The Last Guardian downstairs"),pin(22,69.1,73,10,"Current Normal Scholomance - entrance"),pin(477,56.58,41.26,10,"Lilian Voss room - Invasion of Draenor","Scholomance - Chamber of Summoning"),
    pin(23,27.1,11.6,11,"Stratholme - MAIN Gate for Scarlet Bastion books"),pin(317,30.18,41.49,11,"Malor's room - The Seven Kingdoms","Stratholme - Main Gate"),pin(317,25.5,70.9,11,"Galford library alcoves - Scourge history books","Stratholme - Main Gate"),pin(71,50.97,30.29,12,"Gadgetzan - Old Hatreds beside the anvil"),pin(71,52.47,26.88,12,"Gadgetzan inn - optional empire books"),
    pin(62,48.9,24.5,13,"Zidormi - pre-burning Teldrassil"),pin(57,55.4,88.4,13,"Rut'theran - portal into Darnassus"),pin(89,61.87,74.66,13,"Tradesmen's Terrace - The Betrayer Ascendant"),pin(89,49.94,33.51,13,"Craftsmen's Terrace - Rise of the Blood Elves"),
    pin(10,67.09,73.35,14,"Ratchet balcony - Exile of the High Elves"),pin(10,67.03,75.02,14,"Ratchet inn - Sargeras behind the keg"),pin(10,67.98,73.54,14,"Ratchet hut - optional Archimonde copy"),pin(10,66.87,74.65,14,"Ratchet inn - optional Mount Hyjal copy"),
},"Buildings and floors matter as much as coordinates. Finish this circuit on a character that can use goblin towns before making Steamwheedle hostile for Bloodsail. If a library is entirely empty, resolve its quest phase; a missing book is not evidence that Well Read was removed. Current Scholomance and pre-burning Darnassus provide accessible Retail copies.",{424389,1419335,1769321,1794944,1811000,1839442,1882726,1929423,2462310,2565483,3216279,5456799,5920046,6280292,6288073,"https://www.wowhead.com/object=175747/the-invasion-of-draenor"},"Exploration")

add(871,"Avast Ye, Admiral!",{
    "Choose the character whose Bloodsail reputation you want to raise. Killing Booty Bay NPCs lowers your reputations with Booty Bay, Ratchet, Gadgetzan and Everlook, making their towns hostile. If you only want the account-wide title, an alt keeps your main's goblin access intact; if also doing Insane in the Membrane, use the character doing ALL of that achievement's reputations.",
    "Go to Booty Bay in the Cape of Stranglethorn. In the reputation panel, select Booty Bay and enable At War. Farm the Booty Bay Bruisers around the docks and tavern (roughly 42,74), checking that kills actually grant Bloodsail reputation. Attacking a town NPC can call more Bruisers; move to another part of town if reinforcements stop. A small party helps if you cannot handle the guards alone.",
    "Continue until at least FRIENDLY with Bloodsail Buccaneers AND HATED with Booty Bay. Use normal Booty Bay rather than the old under-siege quest phase. Then board the middle Bloodsail ship off Wild Shore around Cape 46.6,95.2 and go below decks to Fleet Master Firallon. Accept Avast Ye, Admiral! (quest 4621); the old Pretty Boy Duncan introduction is not required for this direct route.",
    "Return to Booty Bay and reach the boat-shaped balcony above the Salty Sailor Tavern, beside the Horde flight master (41.0,73.0). With the quest active, kill BOTH Baron Revilgaz and Fleet Master Seahorn. Deal with the Bruisers they summon and check both quest objectives before leaving; killing them earlier during the reputation grind does not finish an unaccepted quest.",
    "Return below decks to Firallon at 46.6,95.2 and TURN IN the quest for the Bloodsail Admiral's Hat, achievement and title. If he is absent from the usual ship because your character is already in the siege story phase, check his phased ship northwest of Booty Bay around 35.9,66.5 instead. Do not restore goblin reputation before completing this turn-in.",
    "If also pursuing Insane in the Membrane, keep farming Bloodsail to HONORED on this same character before rebuilding the goblin factions. To preserve Bloodsail while restoring Steamwheedle, kill Southsea pirates at Lost Rigger Cove in Tanaris, then use Fray Island for Gadgetzan's final capped point as described in that guide. Cloth-repair quests are a separate option that LOWERS Bloodsail reputation.",
},{pin(210,42,74,2,"Booty Bay - docks and tavern Bruisers"),pin(210,46.6,95.2,3,"Fleet Master Firallon - below decks on the middle ship"),pin(210,41,73,4,"Tavern roof balcony - Revilgaz AND Seahorn"),pin(210,46.6,95.2,5,"Firallon - turn in Avast Ye, Admiral!"),pin(210,35.9,66.5,5,"Firallon - alternative ship ONLY in the siege quest phase"),pin(71,72.33,47.43,6,"Lost Rigger Cove - preserve Bloodsail while restoring goblins"),pin(10,77,90,6,"Fray Island - finish capped Gadgetzan via spillover")},"Friendly Bloodsail is enough for the hat/title quest; Honored is the higher target for Insane in the Membrane. Do not start the long siege quest chain solely to make the guards easier: current normal-phase completions do not need it. The removed artisan Cooking quest and old level-80 guard estimates are not prerequisites.",{334202,490821,1255940,2524602,2538625,3221063,3231441,6054740,6113675,"https://www.wowhead.com/quest=4621/avast-ye-admiral","https://www.wowhead.com/quest=1036/avast-ye-scallywag"},"Reputation")

add(2336,"Insane in the Membrane",{
    "Choose ONE character and use it for every required standing: Honored Bloodsail Buccaneers, plus Exalted Booty Bay, Ratchet, Gadgetzan, Everlook, Ravenholdt and Darkmoon Faire. The earned title is account-wide, but earning different required reputations on different alts does not complete this achievement. Shen'dralar and Syndicate reputation are not requirements.",
    "Start Darkmoon Faire alongside the other grinds whenever it is open; check its in-game calendar week each month. On Darkmoon Island, buy a Ride Ticket Book from Kae Ti around 50.4,59.0, open it, and ride the adjacent carousel until WHEE! reaches 60 minutes. Refresh this 10% reputation buff before large quest/junkbox turn-ins. The Top Hat is an alternative, not a second stacking Faire buff. A Battle Standard of Coordination helps nearby kill reputation if your guild has unlocked it.",
    "For Bloodsail, enable At War with Booty Bay and kill its Bruisers around the docks/tavern (Cape 42,74) until HONORED. Stay in normal Booty Bay rather than starting the old under-siege quest chain. Attacking a town NPC can call guards; rotate between nearby spots when reinforcements stop. This damages all four goblin reputations, so do it before restoring them.",
    "While Bloodsail is friendly and Booty Bay hated, complete Avast Ye, Admiral! from Fleet Master Firallon below decks on the middle Wild Shore ship (46.6,95.2). Kill Revilgaz and Seahorn on the tavern roof balcony (41.0,73.0), then turn in to Firallon. Friendly is enough for that quest, but verify HONORED Bloodsail for Insane before leaving this grind. Doing the hat quest now also avoids the old-credit problems reported by returning players.",
    "Choose how to restore the goblins. To KEEP Bloodsail Honored, skip the cloth quests and farm the pirates in the next step directly, even while hated by the towns. Alternatively, after recording Honored Bloodsail and finishing the hat quest, the repeatable cloth quests below can repair goblin access faster but LOWER Bloodsail. You do not need both opposing standings simultaneously; this choice determines which reputations you keep afterward.",
    "Optional cloth repair ONLY if you accept losing Bloodsail: Mupsi Shacklefridd west of Ratchet (Northern Barrens 65.8,72.0) takes 40 Linen Cloth + 4 Crystal Vials; Bronn Fitzwrench outside Everlook (Winterspring 58.0,52.2) takes 40 Runecloth + 4 Coal; the Bloodsail Traitor north of Booty Bay (Cape 48.5,63.3) takes 40 Silk Cloth + 4 Red Dye; Rumsen Fizzlebrack outside Gadgetzan (Tanaris 50.4,27.2) takes 40 Mageweave Cloth + 4 Strong Flux. Each hand-in gives 500 base reputation to its city and 250 spillover to each of the other three. The city's quest stops at Neutral. Prioritize Everlook/Ratchet before Gadgetzan, check all four standings, and buy more materials only while an available repair quest is still needed.",
    "Farm Southsea pirates at Lost Rigger Cove behind the Caverns of Time in Tanaris. Cover the northern camp around 72.3,47.4 and southern shore camp around 69,54, including their nearby ships as needed. A PARTY of up to five can split the camps and encourage faster respawns; do not convert it to a raid, which current reports say stops sharing the kills' reputation. Stay within your guild banner's range if using one. These pirates restore the goblins without lowering Bloodsail.",
    "Continue until Booty Bay, Ratchet AND Everlook reach Exalted; Gadgetzan usually gets there first but stops at 20,999/21,000 Revered. Then kill a pirate at Fray Island (Northern Barrens 77,90) to supply Gadgetzan's final point through spillover. Check each of the FOUR named cities rather than stopping at the Steamwheedle heading or at Revered. No fixed kill count applies to every starting standing and buff combination.",
    "For Ravenholdt's kill phase, use BFA-era Arathi Highlands. If needed, speak to Zidormi near the southern bridge (38.2,90.0) and select that era, not the newer TWW story phase. Find the Syndicate at Dabyrie's Farmstead around 50,41 or Go'shek Farm around 51.7,60.1, depending on the current Warfront control. Kill the Syndicate humanoids and Harvest Shredders, check that they give Ravenholdt reputation, and circle the active farm with a small party until 11,999/12,000 HONORED. This is one point BEFORE Revered; do not keep killing after the cap.",
    "Arrange Heavy Junkboxes with a rogue alt or another rogue; your achievement character can be any class. One proven route is CURRENT Lower Blackrock Spire: enter the upper-balcony portal inside Blackrock Mountain (80.5,40.7 on its upper map), then stealth through the lower dungeon and pickpocket humanoids before killing them. Reverse the route once pockets have replenished, or leave/reset when appropriate. This uses LBRS, not the Warlords Upper Blackrock Spire instance.",
    "An outdoor lockbox alternative is Greengill Coast on the OLD Isle of Quel'Danas. After Midnight, use the Isle of Quel'Danas portal in Shattrath to reach this Burning Crusade zone. Pickpocket the Greengill Slave camps around 63,54 and 64,48, THEN kill them and move between the camps as they respawn. Empty bags beforehand and mail/deposit the boxes regularly. A rogue is needed for Pick Pocket; other classes should arrange boxes from one rather than merely killing murlocs.",
    "Bring the Heavy Junkboxes to Winstone Wolfe INSIDE Ravenholdt Manor, ground floor on the left (Hillsbrad 71.4,45.0). Use Junkboxes Needed: five boxes give 75 base Ravenholdt reputation. From the exact 11,999/12,000 Honored kill cap, the unbuffed requirement is 1,405 boxes; active quest-reputation buffs reduce it. Save turn-ins for WHEE! if convenient. Keep the boxes unopened, use mail/Warband bank for storage, and leave bag space for quest rewards. Wolfe handles the current turn-in, not Fahrad upstairs.",
    "For Darkmoon Faire Exalted, return during each Faire week and do the daily minigames/races, the monthly quests for your professions, and the nine Darkmoon artifact quests. Get a Darkmoon Adventurer's Guide from Selina Dourman near the entrance so relevant dungeon/PvP artifacts can drop, or buy the specific quest items from other players. Turn them in on the SAME achievement character with WHEE! active. Pet-battle dailies do not replace these reputation quests.",
    "To speed Darkmoon reputation with gold, assemble full traditional Darkmoon decks whose turn-in quest explicitly rewards Darkmoon Faire reputation, then repeat those hand-ins. Check the actual deck/quest before buying: a modern Darkmoon trinket is not automatically a reputation turn-in. Otherwise continue the monthly and daily activities until Exalted. Do not discard a primary profession merely to add another profession quest.",
    "When the final required standing is reached, check the achievement and title. If it does not award, verify all seven standings were earned on THIS character and relog once before redoing anything. The Bloodsail Admiral achievement by itself proves only Friendly, not necessarily Honored. Do not destroy Exalted goblin standings to repeat Bloodsail solely because an old tracker displays it unchecked; current completions and replies confirm the route still works in Retail.",
},{
    pin(407,50.4,59,2,"Kae Ti - ride tickets, carousel beside her"),pin(210,42,74,3,"Booty Bay - Bruisers to Honored Bloodsail"),pin(210,46.6,95.2,4,"Firallon - accept and turn in Admiral quest"),pin(210,41,73,4,"Revilgaz and Seahorn - tavern roof balcony"),
    pin(10,65.8,72,6,"OPTIONAL cloth - Mupsi, lowers Bloodsail"),pin(83,58,52.2,6,"OPTIONAL cloth - Bronn, lowers Bloodsail"),pin(210,48.5,63.3,6,"OPTIONAL cloth - Bloodsail Traitor"),pin(71,50.4,27.2,6,"OPTIONAL cloth - Rumsen, lowers Bloodsail"),
    pin(71,72.33,47.43,7,"Lost Rigger Cove - northern pirate camp"),pin(71,69,54,7,"Lost Rigger Cove - southern shore camp"),pin(10,77,90,8,"Fray Island - Gadgetzan's final spillover point"),
    pin(14,38.2,90,9,"Zidormi - select BFA Arathi for Syndicate farms"),pin(14,50,41,9,"BFA Dabyrie's Farmstead - check Syndicate control"),pin(14,51.73,60.06,9,"BFA Go'shek Farm - alternative Syndicate control"),pin(33,80.5,40.7,10,"Lower Blackrock Spire - rogue pickpocket route","Blackrock Mountain - upper chamber"),
    pin(111,49,42.3,11,"Shattrath - old Quel'Danas portal behind Exarch Nasuun"),pin(122,63,54,11,"Old Quel'Danas - two Greengill Slave camps"),pin(122,64,48,11,"Old Quel'Danas - northern murloc camp alternative"),pin(25,71.4,45,12,"Winstone Wolfe - downstairs, five Heavy Junkboxes per turn-in"),pin(407,50.4,59,13,"Refresh WHEE! before Faire quest hand-ins"),
},"All reputation requirements belong to one character. A rogue is needed to farm the pickpocketed boxes, not to earn the achievement or turn them in. Use a party for shared pirate kills, save box hand-ins for an active reputation buff when convenient, and pace the Faire work across its calendar weeks. Free Knot!, Shen'dralar and Durnholde Syndicate farming are obsolete routes.",{1420416,1958609,2108619,2459407,2616182,2858253,3212821,3214799,3230386,5350349,5751358,5908307,6007923,6098489,6153701,6184785,6258776,6366046,6417285,"https://www.wowhead.com/quest=8249/junkboxes-needed#comments:id=6290547","https://www.wowhead.com/npc=7323/winstone-wolfe","https://www.wowhead.com/npc=25084/greengill-slave#comments:id=6389635","https://www.wowhead.com/spell=46668/whee#comments:id=1794480"},"Reputation")

-- Overall acquisition effort for a current max-level Retail character: include
-- repetition, randomness, event access and coordination, not just combat level.
local function rate(level, reason, achievementIDs)
    for _, id in ipairs(achievementIDs) do
        local guide = guides[id]
        guide.difficulty, guide.difficultyReason = level, reason
        guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
    end
end
rate("easy","Follow the legacy dungeon or raid route; the required boss kills are straightforward at current max level.",{
    628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,685,686,687,689,
})
rate("easy","Follow the zone discovery pins; no rare drop or organized group is required.",{
    627,728,736,750,761,765,766,768,769,770,771,772,773,774,775,776,777,778,779,780,781,782,802,841,842,844,845,846,847,848,849,850,851,852,853,854,855,856,857,
})
rate("easy","A purchasable scouting-map toy provides a shortcut; manual exploration is also available.",{42,43})
rate("easy","Reach an early Classic skill milestone with ordinary materials or repeated fishing.",{116,121,126})
rate("medium","Higher Classic skill requires more materials, recipe progression or repeated practice.",{122,123,127,128,731,732})
rate("medium","Ordinary battleground objectives or cumulative counters require several matches and active participation.",{
    73,154,157,158,166,199,200,203,206,218,221,222,223,582,1251,1252,
})
rate("hard","The objective depends on tight timing, an unusual match situation, coordinated team control or many victories.",{
    155,156,159,161,162,165,167,168,201,202,204,207,219,220,224,225,226,583,584,872,873,1151,1153,1164,1166,1167,1169,1172,1259,1502,
})
rate("hard","Exalted battleground reputation requires a substantial number of objective-focused matches.",{708,709,710,711,712,713,714,907})
rate("hard","Hostile-capital bosses need a capable group and can be interrupted by defending players.",{611,616})
rate("medium","Earn PvP currency and buy the correct faction mount; no rare drop is required.",{706,707})
rate("medium","Complete a daily mount quest chain across multiple days.",{3356,3357})
rate("hard","Rare drops or scarce Black Market auctions make the acquisition unpredictable.",{424,729,880,881})
rate("hard","Rare weekly raid drops and substantial crafting materials are required.",{428,429})
rate("medium","Complete the quest or reputation route, using event currency where available.",{940,944,946,955,956,957,871})
rate("medium","Clear several legacy instances and finish every component achievement.",{1283,1285})
rate("medium","One arena chest is needed, but access is scheduled and other players can contest it.",{389})
rate("hard","Collect twelve arena trinkets across scheduled, potentially contested chest events.",{396})
rate("medium","Catch an ordinary fish in both capitals, including a trip through hostile territory.",{150})
rate("hard","Win a regional fishing race with limited places and a rapid return trip.",{306})
rate("hard","The required rare fish can take many casts; there is no guaranteed completion time.",{1836,1837})
rate("medium","Read 42 specific books across several zones, buildings and dungeons.",{1244})
rate("hard","Complete many zone story chapters, resolving faction alternatives and quest prerequisites.",{1676,1678})
rate("hard","Combine several long reputation grinds, rogue-farmed junkboxes and monthly Faire access.",{2336})
