-- Retail raid walkthroughs. The old Ulduar size-specific IDs are retired;
-- Val'anyr and Herald of the Titans remain separate, obtainable achievements.
local _, TDP = ...
local guides = TDP.CollectionWalkthroughs.achievements
local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end
local function add(id, name, steps, waypoints, tips, comments)
    local lines, sources = {}, {}
    for i, text in ipairs(steps) do lines[i] = i .. ". " .. text end
    for _, comment in ipairs(comments or {}) do
        sources[#sources + 1] = type(comment) == "number" and ("https://www.wowhead.com/achievement=" .. id .. "#comments:id=" .. comment) or comment
    end
    guides[id] = { achievementId = id, name = name, category = "Raids", sourceType = "Achievement", source = name,
        acquisition = table.concat(lines, "\n\n"), stepCount = #steps, waypoints = waypoints or {}, tips = tips,
        sources = sources, wowheadUrl = "https://www.wowhead.com/achievement=" .. id,
        sourceURL = "https://www.wowhead.com/achievement=" .. id .. "#comments" }
end

-- Retail boss mapper floors 1-6 match UiMaps 162-167, respectively.
local naxxBosses = {
    anub={163,30.6,46.9,"Anub'Rekhan","Arachnid Quarter"},
    faerlina={163,44.1,36,"Grand Widow Faerlina","Arachnid Quarter"},
    maexxna={163,68.6,15.2,"Maexxna","Arachnid Quarter"},
    patchwerk={162,54.1,41.6,"Patchwerk","Construct Quarter"},
    grobbulus={162,61.5,53.1,"Grobbulus","Construct Quarter"},
    gluth={162,46.2,43.8,"Gluth","Construct Quarter"},
    thaddius={162,26.5,14.5,"Thaddius","Construct Quarter"},
    noth={165,34.6,56.4,"Noth the Plaguebringer","Plague Quarter"},
    heigan={165,49.8,45.6,"Heigan the Unclean","Plague Quarter"},
    loatheb={165,76,28.3,"Loatheb","Plague Quarter"},
    razuvious={164,42.7,45.9,"Instructor Razuvious","Military Quarter"},
    gothik={164,67.5,59.6,"Gothik the Harvester","Military Quarter"},
    horsemen={164,30.1,76.8,"Four Horsemen chamber","Military Quarter"},
    sapphiron={167,56.5,67.5,"Sapphiron","Upper Necropolis"},
    kelthuzad={167,36.5,22.3,"Kel'Thuzad","Upper Necropolis"},
}
local naxxTargets = {}
local function naxxRoute(ids, targets)
    for _,id in ipairs(ids) do naxxTargets[id]=targets end
end
naxxRoute({562,563},{{"anub",2},{"faerlina",2},{"maexxna",2}})
naxxRoute({564,565},{{"patchwerk",2},{"grobbulus",2},{"gluth",2},{"thaddius",2}})
naxxRoute({566,567},{{"noth",2},{"heigan",2},{"loatheb",2}})
naxxRoute({568,569},{{"razuvious",2},{"gothik",2},{"horsemen",3}})
naxxRoute({572,573},{{"sapphiron",3}})
naxxRoute({574,575},{{"sapphiron",2},{"kelthuzad",3},{"kelthuzad",4}})
for _,id in ipairs({576,577,578,579}) do
    local wingStep=(id==578 or id==579) and 3 or 2
    local targets={}
    for _,boss in ipairs({"anub","faerlina","maexxna","patchwerk","grobbulus","gluth","thaddius","noth","heigan","loatheb","razuvious","gothik","horsemen"}) do
        targets[#targets+1]={boss,wingStep}
    end
    targets[#targets+1]={"sapphiron",4}
    targets[#targets+1]={"kelthuzad",4}
    naxxTargets[id]=targets
end
naxxRoute({1856,1857},{{"patchwerk",2},{"patchwerk",3}})
naxxRoute({1858,1859},{{"anub",2},{"faerlina",3},{"maexxna",3}})
naxxRoute({1996,2139},{{"noth",2},{"heigan",2},{"heigan",3}})
naxxRoute({1997,2140},{{"faerlina",2},{"faerlina",3},{"faerlina",4}})
naxxRoute({2146,2147},{{"sapphiron",2},{"sapphiron",3}})
naxxRoute({2176,2177},{{"razuvious",2},{"gothik",2},{"horsemen",2},{"horsemen",3},{"horsemen",4},{"horsemen",5}})
naxxRoute({2178,2179},{{"thaddius",2},{"thaddius",3},{"thaddius",4}})
naxxRoute({2180,2181},{{"thaddius",2},{"thaddius",3}})
naxxRoute({2182,2183},{{"noth",2},{"heigan",2},{"loatheb",2},{"loatheb",3}})
naxxRoute({2184,2185},{{"sapphiron",2},{"kelthuzad",2},{"kelthuzad",3},{"kelthuzad",4},{"kelthuzad",5}})

local function naxx(id, name, size, steps, comments)
    local route = {
        "Outside Naxxramas, set Legacy Raid Size to " .. size .. " players. Fly to the floating necropolis over eastern Dragonblight and enter the portal underneath it (87.4, 51.0). This is the Northrend raid, not the removed Eastern Plaguelands version.",
    }
    for _, text in ipairs(steps) do route[#route + 1] = text end
    local points={pin(115,87.4,51,1,"Naxxramas - portal under the floating necropolis")}
    for _,target in ipairs(naxxTargets[id] or {}) do
        local boss=naxxBosses[target[1]]
        points[#points+1]=pin(boss[1],boss[2],boss[3],target[2],boss[4],"Naxxramas - "..boss[5])
    end
    add(id, name, route, points,
        "Choose the size before entering. The 10- and 25-player achievements are separate; stay inside the instance until each required kill credits.", comments)
end

local quarters = {
    {562,563,"The Arachnid Quarter","Take the spider-lined Arachnid Quarter from the central hub. Kill Anub'Rekhan, Grand Widow Faerlina and Maexxna in that order. Faerlina is the boss surrounded by worshippers; Maexxna is at the end of the webbed passage.",{528721},{528710}},
    {564,565,"The Construct Quarter","Take the abomination-lined Construct Quarter. Kill Patchwerk, cross the moving slime channels, then kill Grobbulus. Descend through the pipe to Gluth, defeat him, and continue to Stalagg and Feugen. Kill those two together, jump to Thaddius's platform and defeat Thaddius.",{779592,1033535},{528712}},
    {566,567,"The Plague Quarter","Take the Plague Quarter. Kill Noth the Plaguebringer, then Heigan the Unclean. Follow the fungus corridor and kill Loatheb. All three bosses are required; reaching Loatheb alone does not complete the wing.",{528731},{528716}},
    {568,569,"The Military Quarter","Take the Military Quarter and kill Instructor Razuvious. Start Gothik the Harvester's event and clear the arriving waves until he descends. Keep pets passive until he is on the floor; kill Gothik, wait for the gate to open, and enter the Four Horsemen's chamber.",{2269133},{528720}},
}
for _, wing in ipairs(quarters) do
    for index, size in ipairs({10,25}) do
        local steps = {wing[4]}
        if wing[1] == 568 then steps[#steps+1] = "Walk up to the Four Horsemen without damaging them. Let all four leave their starting platform, then kill Thane Korth'azz, Baron Rivendare, Lady Blaumeux and Sir Zeliek. Attacking too early can reset the encounter." end
        steps[#steps+1] = "Check the wing's boss checklist before taking the return portal. Being outside the instance at a kill can leave that criterion missing."
        naxx(wing[index],wing[3] .. " (" .. size .. " player)",size,steps,wing[index+4])
    end
end
for _, size in ipairs({10,25}) do
    local ten = size == 10
    naxx(ten and 572 or 573,"Sapphiron's Demise ("..size.." player)",size,{
        "From Naxxramas's entrance hub, use the central portal to Frostwyrm Lair. The old requirement to clear all four wings before using this route was removed.",
        "Defeat Sapphiron in the large ice chamber. At high level a direct kill is sufficient. If an air phase occurs, hide behind an ice block for Frost Breath, then resume attacking after the landing.",
    },ten and {} or {1606848})
    naxx(ten and 574 or 575,"Kel'Thuzad's Defeat ("..size.." player)",size,{
        "Use the central portal to Frostwyrm Lair and defeat Sapphiron. Enter the chamber behind him and walk into the green circle to begin Kel'Thuzad's event.",
        "Stay near the central circle and kill the enemies that approach. Do not run around the outside alcoves or leave the room. The opening phase is timed; killing the first wave does not immediately make Kel'Thuzad attackable.",
        "When Kel'Thuzad joins the fight, defeat him and any surviving adds. For Just Can't Get Enough, follow that separate guide BEFORE killing the abominations or boss.",
    },ten and {} or {2178222})
    for _, few in ipairs({false,true}) do
        naxx(few and (ten and 578 or 579) or (ten and 576 or 577),(few and "The Dedicated Few" or "The Fall of Naxxramas").." ("..size.." player)",size,{
            few and ("Keep at most "..(ten and "8" or "20").." players INSIDE the instance throughout each qualifying encounter. Soloing satisfies this limit; having players die or leave after the pull does not fix an oversized attempt.") or "Clear all four wings from the central hub: Arachnid (Anub'Rekhan, Faerlina, Maexxna), Plague (Noth, Heigan, Loatheb), Military (Razuvious, Gothik, Four Horsemen) and Construct (Patchwerk, Grobbulus, Gluth, Thaddius).",
            few and "Clear the Arachnid, Plague, Military and Construct wings with that player limit. The Dedicated Few checklist excludes the Four Horsemen; check the listed criteria rather than assuming a single Kel'Thuzad kill is sufficient." or "At Gothik, wait for the scripted waves and his descent. At the Four Horsemen, let them spread to their corners before attacking. At Thaddius, kill Stalagg and Feugen together before jumping to the final platform.",
            "Use the hub portal to Frostwyrm Lair, defeat Sapphiron, start Kel'Thuzad's central-circle event and defeat him after the opening waves. Check every listed boss criterion; missing kills can be finished in later resets.",
        },few and (ten and {482749,2092894} or {644995}) or (ten and {763182} or {763185}))
    end
end

local naxxChallenges = {
    {1856,1857,"Make Quick Werk of Him",{
        "Take the Construct Quarter and clear the trash around Patchwerk before pulling him. Position so you can attack immediately.",
        "Kill Patchwerk within THREE minutes of engaging him. A high-level direct kill meets the requirement; the old level-80 raid compositions and damage targets are unnecessary.",
    },{478943},{766994}},
    {1858,1859,"Arachnophobia",{
        "Take the Arachnid Quarter. Clear Anub'Rekhan's room and be ready to continue before killing him: his death starts the TWENTY-minute timer.",
        "Move straight through the wing, kill Grand Widow Faerlina, clear the web corridor and defeat Maexxna before that same timer expires. Loot and optional detours can wait until after Maexxna.",
    },{612790},{}},
    {1996,2139,"The Safety Dance",{
        "Take the Plague Quarter, defeat Noth and reach Heigan. Everyone in the group must remain alive for this encounter.",
        "At high level, move onto Heigan's platform and kill him immediately. No dance phase is mandatory. If the fight lasts, move through the safe floor sections during eruptions and return to attacking; any player death fails the attempt.",
    },{1649553,5630748},{}},
    {1997,2140,"Momma Said Knock You Out",{
        "Take the Arachnid Quarter to Grand Widow Faerlina. Dismiss pets with cleave and disable automatic area damage before entering her worshipper group.",
        "Kill FAERLINA with a single-target attack, leaving all worshippers alive until she dies. Do not dispel Frenzy, use a worshipper to suppress it, or kill worshippers beside her even before Frenzy occurs. A fast boss kill is valid.",
        "After achievement credit appears, kill the remaining worshippers. Killing them first can apply Widow's Embrace and silently fail the requirement.",
    },{582340,1785222,3308220},{}},
    {2146,2147,"The Hundred Club",{
        "Use the central portal to Frostwyrm Lair and reach Sapphiron. Have every participant remove old Frost Resistance equipment, resistance potions and resistance buffs before pulling.",
        "Defeat Sapphiron without anyone's Frost Resistance exceeding 100 during the encounter. Ordinary modern gear and an immediate high-level kill are sufficient; do not equip an old resistance set because an outdated level-80 guide recommends it.",
    },{},{}},
    {2176,2177,"And They Would All Go Down Together",{
        "Clear Razuvious and Gothik in the Military Quarter. Walk up to the Four Horsemen WITHOUT damaging them and wait until they leave the starting platform. Killing one on that platform can reset the encounter without valid credit.",
        "Collect Thane Korth'azz and Baron Rivendare, the two melee horsemen that follow you. Bring them to Lady Blaumeux in the far left corner or Sir Zeliek in the far right corner.",
        "Kill the two followers and that stationary horseman together. Immediately run across the BACK of the room and kill the last stationary horseman. All FOUR must die within 15 seconds of the FIRST death, not 15 seconds between each pair.",
    },{2237272,2502174,5376238},{3211755,5188367}},
    {2178,2179,"Shocking!",{
        "Clear the Construct Quarter to Stalagg and Feugen. Pull them without killing one prematurely, bring them together and kill both close together in time, then jump onto Thaddius's platform.",
        "Solo, kill Thaddius directly. In a group, keep everyone more than 10 yards apart so opposite charges cannot damage another player. Avoid pets or movement that brings players together during Polarity Shift.",
        "Finish Thaddius with no polarity damage to another player. Later Retail comments confirm that a kill before the first Polarity Shift can count; the old forced-wait instructions are unnecessary.",
    },{1970466,2508197,5630751},{2284293,3297336}},
    {2180,2181,"Subtraction",{
        "Reach Thaddius at the end of the Construct Quarter. Keep no more than LIMIT players inside for the whole encounter; a solo run meets the requirement.",
        "Pull Stalagg and Feugen, defeat both together, jump onto Thaddius's platform and kill Thaddius. Check credit before leaving; this is a player-count achievement, not a requirement to wait for Polarity Shift.",
    },{},{}},
    {2182,2183,"Spore Loser",{
        "Take the Plague Quarter through Noth and Heigan to Loatheb. Dismiss uncontrolled pets and remove cleave or retaliation effects.",
        "Kill Loatheb with single-target damage and do not kill ANY Spore. A direct high-level kill before spores spawn is sufficient. If spores appear, leave them alive and avoid area attacks until Loatheb dies.",
    },{},{}},
    {2184,2185,"Just Can't Get Enough",{
        "Use the central portal to Frostwyrm Lair, kill Sapphiron and enter Kel'Thuzad's chamber. Prepare a ranged non-cleaving pull and remove retaliation damage or pets that could kill adds early.",
        "Start the event by entering the GREEN CENTRAL CIRCLE. Stay in or beside it while pulling the abomination packs from the surrounding alcoves. Do not run around the room: leaving the circle too long can reset the encounter.",
        "Bring at least 18 Unstoppable Abominations into the central chamber. There are 21 around the room if all packs are collected. Keep the abominations alive until Kel'Thuzad becomes active in phase 2; kill other approaching enemies as needed.",
        "After phase 2 begins, kill at least 18 gathered abominations INSIDE the chamber, then kill Kel'Thuzad. Check the achievement before leaving the instance.",
    },{}, {3214588}},
}
for _, challenge in ipairs(naxxChallenges) do
    for index, size in ipairs({10,25}) do
        local steps = {}
        for _, text in ipairs(challenge[4]) do steps[#steps+1] = (text:gsub("LIMIT",size == 10 and "8" or "20")) end
        local sources = challenge[index+4]
        if challenge[1] == 2184 then sources = {"https://www.wowhead.com/achievement=2185#comments:id=3214588"} end
        naxx(challenge[index],challenge[3].." ("..size.." player)",size,steps,sources)
    end
end

for _, size in ipairs({10,25}) do
    local ten = size == 10
    local entrance = {pin(114,27.5,26.6,1,"Eye of Eternity - highest Nexus portal")}
    local start = "Set Legacy Raid Size to "..size.." players outside the instance. Fly to Coldarra in Borean Tundra and enter the EYE OF ETERNITY on the highest ring of the Nexus tower. The Nexus and Oculus portals are different instances."
    local finish = "When the platform breaks, wait for your red drake and its vehicle bar. Target Malygos and use Flame Spike (1), Flame Spike (1), Engulf in Flames (2); repeat, adding Revivify (3) to heal if needed and moving out of Static Fields. Finish the dragon and wait for credit."
    for _, mode in ipairs({"clear","few","time","scion"}) do
        local id = mode == "clear" and (ten and 622 or 623) or mode == "few" and (ten and 1869 or 1870) or mode == "time" and (ten and 1874 or 1875) or (ten and 2148 or 2149)
        local name = mode == "clear" and "The Spellweaver's Downfall" or mode == "few" and "A Poke in the Eye" or mode == "time" and "You Don't Have an Eternity" or "Denyin' the Scion"
        local steps = {start}
        if mode == "few" then steps[#steps+1] = "Keep at most "..(ten and "8" or "20").." players inside for the entire encounter. Soloing satisfies the limit. Start the encounter at the central focusing device." else steps[#steps+1] = "Use the central focusing device to start Malygos. Damage him to trigger phase 2. He can remain at 1 health until the scripted transitions finish; this is not a reason to reset." end
        if mode == "scion" then
            steps[#steps+1] = "In phase 2, leave at least one Scion of Eternity alive. Kill a Nexus Lord that descends toward the floor, click its dropped hover disc, and FLY OFF the floor before attacking your target. A disc from a Nexus Lord is the reliable rideable one."
            steps[#steps+1] = "While mounted on that disc, personally land a DIRECT killing blow on a Scion of Eternity. A pet or lingering damage-over-time effect can deny credit. The achievement can award immediately; killing Malygos is not required for this particular criterion."
        else
            steps[#steps+1] = "In phase 2, kill every Nexus Lord and Scion of Eternity. Ranged attacks can reach the flying enemies; otherwise kill a descending Nexus Lord and mount its dropped disc to fly to them. Stay inside the anti-magic bubbles if damage matters."
            steps[#steps+1] = finish
            if mode == "time" then steps[#steps+1] = "The whole encounter must finish within SIX minutes of the pull, including the scripted transitions. Attack each available target promptly; the old five-minute and spark-stacking strategies are obsolete for a high-level run." end
        end
        add(id,name.." ("..size.." player)",steps,entrance,
            mode == "scion" and "Credit is personal: being on a disc while someone else kills the Scion is insufficient. Rise above the floor before dealing the killing blow." or "No old Eye of Eternity key is needed. Do not leave the instance while the platform and drake transitions run.",
            mode == "scion" and (ten and {1712621,2268751,5378653} or {2268752,6413211}) or mode == "few" and (ten and {1784746} or {2260400}) or {})
    end
    local osStart = "Set Legacy Raid Size to "..size.." players outside. Enter the chamber beneath Wyrmrest Temple in Dragonblight (59.8, 54.6) and choose OBSIDIAN SANCTUM, not Ruby Sanctum."
    for _, task in ipairs({{"clear",ten and 1876 or 625,"Besting the Black Dragonflight"},{"few",ten and 624 or 1877,"Less Is More"},{"lava",ten and 2047 or 2048,"Gonna Go When the Volcano Blows"},{"one",ten and 2049 or 2052,"Twilight Assist"},{"two",ten and 2050 or 2053,"Twilight Duo"},{"three",ten and 2051 or 2054,"The Twilight Zone"}}) do
        local steps = {osStart}
        if task[1] == "few" then
            steps[#steps+1] = "Keep at most "..(ten and "8" or "20").." players inside throughout the run. Kill Tenebron, Shadron and Vesperon SEPARATELY on their ledges before attacking Sartharion. Each named drake is a checklist criterion."
            steps[#steps+1] = "Then kill Sartharion on the central island. Killing Sartharion first causes unengaged drakes to disappear and can leave Less Is More incomplete, even though it is a good route for the three-drake mount."
        elseif task[1] == "lava" then
            steps[#steps+1] = "Clear an approach to the central island and kill Sartharion immediately with a direct attack. This avoids the time spent exposed to Lava Strike. No drake or add count is required."
            steps[#steps+1] = "If the encounter lasts, keep moving away from the smoky fireballs falling from above until Sartharion dies. LAVA STRIKE is the failing effect; it is different from the large moving flame walls. Credit is evaluated for your own avoidance."
        else
            steps[#steps+1] = task[1] == "clear" and "Clear a safe route to Sartharion on the central island. Killing the three side drakes first is optional for this simple clear." or "Leave ALL THREE side drakes alive before pulling Sartharion. This exceeds the one- or two-drake minimum and can award the lower drake-count achievements together with The Twilight Zone. Do not clear the named drakes on their ledges."
            steps[#steps+1] = "At high level, go straight to Sartharion and kill him before Shadron lands and grants immunity. A fast kill with the drakes alive at the pull is valid; you do not have to wait for all three to land. Loot the boss before leaving."
        end
        add(task[2],task[3].." ("..size.." player)",steps,{pin(115,59.8,54.6,1,"Obsidian Sanctum - below Wyrmrest Temple")},
            task[1] == "three" and "The three-drake kill also drops a Black Drake in 10-player mode or a Twilight Drake in 25-player mode. Less Is More needs actual side-drake kills and should be planned separately." or nil,
            task[1] == "few" and {"https://www.wowhead.com/achievement=624#comments:id=2075942"} or task[1] == "lava" and (ten and {476388,2082243} or {476387,2196170}) or {})
    end
end

add(2044,"Ruby Void",{
    "Set HEROIC and enter the Oculus through Coldarra's upper dungeon portal. Kill Drakos and choose an EMERALD essence from the freed drakes; nobody may use a Ruby drake for Eregos.",
    "Use the drake to reach the construct platforms, dismount and destroy all ten Centrifuge Constructs, then kill Varos. Follow Urom through his platform summons, defeat him and fly to Eregos's highest ring.",
    "On the Emerald drake, keep three stacks of Leeching Poison (1) on Eregos. Apply and refresh poison on the summoned whelps as well so they die and provide healing. Use Touch the Nightmare (2) only with enough health to survive its self-damage; maintaining poison and killing whelps takes priority.",
    "Move around the upper ring during Planar Shift to avoid the pursuing orbs, then refresh poison and finish Eregos. Do not switch to a Ruby drake mid-fight. This all-Emerald route can also award Amber Void and the Emerald criterion of Experienced Drake Rider.",
},{pin(114,28.6,27.5,1,"The Oculus - upper dungeon portal"),pin(143,49.1,76.2,1,"Drakos - choose Emerald after freeing the drakes","The Oculus - Band of Variance"),pin(144,46.1,19.2,2,"Varos - destroy constructs first","The Oculus - Band of Acceleration"),pin(145,70.7,27.4,2,"Urom - finish platform sequence","The Oculus - Band of Transmutation"),pin(146,46.9,20.9,3,"Eregos - poison boss and whelps; no Ruby drake","The Oculus - Band of Alignment")},
    "If attempting this with friends, everyone must avoid Ruby. The old five-Amber coordinated rotation is an alternative, but is unnecessary for this route. Using a forbidden drake then deleting its essence at low boss health does not repair the attempt.",{473425,1636151,1424040})

-- NPC coordinates below come from each boss's Retail g_mapperData. Its
-- Icecrown floors 1/3/4/5/6/7 correspond to UiMaps 186/188/189/190/191/192.
local iccBosses = {
    marrowgar={186,38.9,59.8,"Lord Marrowgar","Icecrown Citadel - Lower Citadel"},
    deathwhisper={186,39.1,86.7,"Lady Deathwhisper","Icecrown Citadel - Lower Citadel"},
    saurfang={188,51.4,21.7,"Deathbringer Saurfang","Icecrown Citadel - Deathbringer's Rise"},
    festergut={190,19.8,65.4,"Festergut","Icecrown Citadel - Upper Reaches"},
    rotface={190,19.8,41.8,"Rotface","Icecrown Citadel - Upper Reaches"},
    putricide={190,13.1,53.2,"Professor Putricide","Icecrown Citadel - Upper Reaches"},
    princes={190,51.8,14.5,"Blood Prince Council","Icecrown Citadel - Upper Reaches"},
    queen={191,51.1,43.5,"Blood-Queen Lana'thel","Icecrown Citadel - Royal Quarters"},
    valithria={190,76.6,73.6,"Valithria Dreamwalker","Icecrown Citadel - Upper Reaches"},
    sindragosa={189,36.6,23.1,"Sindragosa","Icecrown Citadel - Frost Queen's Lair"},
    lichking={192,49.8,52.8,"The Lich King","Icecrown Citadel - The Frozen Throne"},
}
local function iccPin(boss,step,label)
    local b=iccBosses[boss]
    return pin(b[1],b[2],b[3],step,label or b[4],b[5])
end
local function icc(id,name,size,heroic,steps,waypoints,comments,tips)
    local route={"Outside Icecrown Citadel, set Legacy Raid Size to "..size.." players and Raid Difficulty to "..(heroic and "HEROIC" or "NORMAL (Heroic also satisfies this achievement)")..". Enter the RAID portal at 53.5, 85.5 in Icecrown; the higher Frozen Halls dungeon entrance is different."}
    for _,text in ipairs(steps) do route[#route+1]=text end
    local points={pin(118,53.5,85.5,1,"Icecrown Citadel - raid entrance")}
    for _,point in ipairs(waypoints or {}) do points[#points+1]=point end
    add(id,name,route,points,tips,comments)
end
local lowerRoute="Defeat Marrowgar and Deathwhisper, then take the elevator to the ramparts. Obtain and equip the faction ship's Goblin Rocket Pack, speak to the commander and start the Gunship Battle. Use a cannon as soon as the enemy ship arrives; build heat with Cannon Blast and spend it with Incinerating Blast."
local upperRoute="Clear the Lower Spire: Marrowgar, Deathwhisper, Gunship Battle and Saurfang. Wait for Saurfang's dialogue, then take the transporter to the Upper Spire. Choose the branch named in the next step."
local lichRoute="Clear the Lower Spire, then the Plagueworks (Festergut, Rotface and Putricide), Crimson Hall (Blood Princes and Lana'thel), and Frostwing path to Sindragosa. Activate both valves after Festergut and Rotface so Putricide's room opens. The three wing-end bosses unlock the central Upper Spire transporter to the Frozen Throne."
local lichFinish="Speak to Tirion Fordring at the Frozen Throne, then attack the Lich King. At the scripted raid-kill scene, DO NOT release or leave. Wait for Tirion and Terenas's dialogue, accept the resurrection when offered, and finish the suspended Lich King after Tirion breaks Frostmourne."

local iccWings={
    {4531,4604,4628,4632,"Storming the Citadel",{
        lowerRoute,
        "If the cannons freeze, jump across using the Rocket Pack, kill the battle-mage and jump back to your own ship. Resume cannon fire until victory. Cross to Saurfang's platform, speak to the commander and defeat Deathbringer Saurfang. Check all FOUR criteria before teleporting upstairs.",
    },{"marrowgar","deathwhisper","saurfang"}},
    {4528,4605,4629,4633,"The Plagueworks",{
        upperRoute,
        "Take the Plagueworks branch and kill Festergut and Rotface in their separate rooms. Activate the valve in EACH room after its boss dies. Return to the corridor and follow the opened route to Professor Putricide; kill him as well.",
    },{"festergut","rotface","putricide"}},
    {4529,4606,4630,4634,"The Crimson Hall",{
        upperRoute,
        "Take the Crimson Hall branch and defeat the Blood Prince Council. Attack the prince currently empowered by Invocation of Blood; the other princes' health cannot be depleted normally. Follow the opened passage upstairs to the Royal Quarters and defeat Blood-Queen Lana'thel.",
    },{"princes","queen"}},
    {4527,4607,4631,4635,"The Frostwing Halls",{
        upperRoute,
        "Take the Frostwing branch to Valithria Dreamwalker. Bring direct friendly-target healing or a suitable healing item. Start combat by killing the four channelers, then heal HER to full while clearing the attacking adds. This is a healing encounter: skipping past her does not satisfy the wing-clear achievement.",
        "If your class cannot finish the healing, bring a healer; on Heroic, ongoing damage can interrupt ordinary bandages. Recent Retail comments also report Darkmoon Deck: Dance or a Pump-Action Bandage Gun. Check that Valithria's criterion actually credits before continuing.",
        "Take the elevator beyond Valithria, clear the spider gauntlet below, then defeat the frost wyrms Rimefang and Spinestalker outside. Wait for Sindragosa to land and kill her. Valithria AND Sindragosa are required.",
    },{"valithria","sindragosa"}},
}
for _,wing in ipairs(iccWings) do
    for index,size in ipairs({10,25}) do
        for _,heroic in ipairs({false,true}) do
            local id=wing[index+(heroic and 2 or 0)]
            local points={}
            for _,boss in ipairs(wing[7]) do points[#points+1]=iccPin(boss,wing[5]=="Storming the Citadel" and (boss=="saurfang" and 3 or 2) or wing[5]=="The Frostwing Halls" and (boss=="sindragosa" and 5 or 3) or 3) end
            icc(id,(heroic and "Heroic: " or "")..wing[5].." ("..size.." player)",size,heroic,wing[6],points,
                wing[5]=="The Frostwing Halls" and {"https://www.wowhead.com/achievement=4607#comments:id=5544252","https://www.wowhead.com/achievement=4607#comments:id=6307435","https://www.wowhead.com/achievement=4631#comments:id=5652676"} or {},
                "Heroic kills also satisfy the corresponding Normal checklist. Finish each named boss in the selected raid size; a Lich King kill alone does not complete the earlier wings.")
        end
    end
end
for _,size in ipairs({10,25}) do
    local ten=size==10
    for _,heroic in ipairs({false,true}) do
        icc(heroic and (ten and 4636 or 4637) or (ten and 4532 or 4608),(heroic and "Heroic: " or "").."Fall of the Lich King ("..size.." player)",size,heroic,{
            lowerRoute,
            "Finish the gunship victory and kill Saurfang. Upstairs, kill Festergut and Rotface, use both room valves, and kill Putricide. Clear the Blood Princes and Lana'thel in the Crimson Hall.",
            "Heal Valithria Dreamwalker to FULL, then descend through the spider gauntlet and kill Sindragosa after her two frost wyrms. Bring a healer or effective friendly-target healing item; bypassing Valithria leaves this all-bosses achievement incomplete.",
            "With Putricide, Lana'thel and Sindragosa defeated, use the Upper Spire's central transporter to reach the Frozen Throne. "..lichFinish,
        },{iccPin("marrowgar",2),iccPin("deathwhisper",2),iccPin("saurfang",3),iccPin("festergut",3),iccPin("rotface",3),iccPin("putricide",3),iccPin("princes",3),iccPin("queen",3),iccPin("valithria",4),iccPin("sindragosa",4),iccPin("lichking",5)},
        ten and {1001808} or {924123},"This checks every ICC boss. A heroic Lich King title achievement has fewer required kills because Valithria can be bypassed on the route to the throne.")
        icc(heroic and (ten and 4583 or 4584) or (ten and 4530 or 4597),heroic and (ten and "Bane of the Fallen King" or "The Light of Dawn") or "The Frozen Throne ("..size.." player)",size,heroic,{
            lichRoute,
            "For this Lich King-only objective, Valithria can be bypassed if you have no healing, but Sindragosa must still die. At the Upper Spire transporter, select the Frozen Throne after all three wing-end bosses are finished.",
            lichFinish,
        },{iccPin("putricide",2),iccPin("queen",2),iccPin("sindragosa",2),iccPin("lichking",3),iccPin("lichking",4)}, {},
        "Set the intended difficulty before the final pull. The old normal-clear prerequisite for entering Heroic is no longer required.")
    end
end

local iccChallenges={
    {4534,4610,"Boned","marrowgar",{
        "Marrowgar is the first boss beyond the entrance trash. At high level, kill him immediately; a Bone Spike phase is not mandatory.",
        "If spikes appear, target and destroy each Bone Spike within EIGHT seconds of the impale, then return to Marrowgar. In a group, keep players close enough that spikes can be reached promptly.",
    },{1395977},{2561335}},
    {4535,4611,"Full House","deathwhisper",{
        "Defeat Marrowgar and clear ALL the ordinary trash in front of Lady Deathwhisper. Those trash packs do not count. Disable retaliation damage, cleave and pet attacks, then walk up to her to enter combat WITHOUT damaging her mana shield.",
        "Wait while she summons and transforms cultists. Keep the shield intact so more waves can arrive. The reliable five types are Cult Fanatic, Deformed Fanatic, Reanimated Fanatic, Cult Adherent and Reanimated Adherent. Keep at least ONE OF EACH alive simultaneously; merely having five enemies is insufficient.",
        "Use separate /targetexact macros or inspect nameplates to identify all five types. For marking in Midnight, use /tm 1 through /tm 5 on five separate buttons; old scripted SetRaidTarget combat macros may fail. A transformation can take several minutes: continue waiting if only three or four types are present.",
        "Once all five types are active, kill ONLY Lady Deathwhisper with direct single-target damage. Leave every required cultist alive until she dies. Her shield must be depleted as part of this final kill, not while you are waiting for spawns.",
    },{2095680,5520230,5806848},{2314598,2579280,6320916}},
    {4537,4613,"I've Gone and Made a Mess","saurfang",{
        lowerRoute,
        "Finish the gunship and speak to the commander at Deathbringer's Rise. Wait for the introduction, then kill Saurfang immediately. He must die before his THIRD Mark of the Fallen Champion in 10-player mode or FIFTH in 25-player mode; a high-level fast kill meets either limit.",
    },{},{3143255}},
    {4538,4614,"Dances with Oozes","rotface",{
        upperRoute,
        "Take the Plagueworks branch to Rotface and kill him immediately. No ooze needs to spawn for the achievement. If he survives, keep small oozes apart or kite any Big Ooze without feeding it enough additional oozes to cast Unstable Ooze Explosion.",
        "Finish Rotface before ANY Big Ooze explodes. A Big Ooze reaching five Unstable Ooze stacks causes failure even if you survive the explosion. Old instructions to merge big oozes until they disappear were corrected by later comments.",
    },{941762},{947662}},
    {4577,4615,"Flu Shot Shortage","festergut",{
        upperRoute,
        "Enter Festergut's Plagueworks room and kill him promptly. No player may ever reach THREE Inoculated stacks. A fast kill before spores appear is valid; there is no requirement to wait through Pungent Blight.",
        "If spores do appear, stay away from exploding spores once you have two stacks. In a group, spread the spore holders so they do not give an unwanted third stack to another player. Finish the boss before the next cycle causes a failure.",
    },{2616619},{2078204}},
    {4578,4616,"Nausea, Heartburn, Indigestion...","putricide",{
        upperRoute,
        "Kill Festergut and Rotface and activate BOTH room valves to open Putricide's corridor. Do not drink from his experiment table or become the Mutated Abomination for a solo attempt.",
        "Kill Putricide without anyone using the Abomination's Regurgitated Ooze ability. A high-level direct kill works. If a group uses the Abomination for another purpose, its driver must leave that slowing attack unused for the entire encounter.",
    },{2073269,2616620},{2555959}},
    {4582,4617,"The Orb Whisperer","princes",{
        upperRoute,
        "Take the Crimson Hall branch. Wait until the Blood Prince Council becomes active, then kill the prince empowered by Invocation of Blood. A high-level fast kill avoids the dangerous empowered spells and is confirmed by later Retail comments.",
        "If the encounter lasts, avoid Empowered Shock Vortex, soften Empowered Flame by letting it pass near players, and have Keleseth's target collect Dark Nuclei for Shadow Resonance. No player may take a single spell hit over the achievement's threshold. Finish the empowered prince to end the shared encounter.",
    },{2616621},{2565396}},
    {4580,4620,"All You Can Eat","sindragosa",{
        upperRoute,
        "Follow the Frostwing route, descend through the spider gauntlet and kill Rimefang and Spinestalker. Wait for Sindragosa to land, then kill her immediately. This fast kill is sufficient; the final-phase debuff need not appear.",
        "If phase 3 lasts, no player may exceed FIVE Mystic Buffet stacks. Use an Ice Tomb to break line of sight until your stacks fall off, then return to the boss; rotate tanks if needed. Ordinary pillars or simply moving farther away do not replace the Ice Tomb mechanic.",
    },{2022469},{5167212}},
    {4581,4622,"Neck-Deep in Vile","lichking",{
        lichRoute,
        "At the Frozen Throne, speak to Tirion and kill the Lich King promptly through his scripted transitions. Later Retail reports confirm that winning before Vile Spirits spawn satisfies the achievement.",
        "If Vile Spirits do spawn in the later phase, destroy every spirit before it reaches a player and explodes. Do not force the 10% scripted ending while live spirits are about to detonate. After that condition is safe, "..lichFinish,
    },{2014799,5806875},{2014798}},
}
for _,challenge in ipairs(iccChallenges) do
    for index,size in ipairs({10,25}) do
        local points={}
        local firstStep=(challenge[4]=="marrowgar" or challenge[4]=="deathwhisper") and 2 or 3
        for step=firstStep,#challenge[5]+1 do points[#points+1]=iccPin(challenge[4],step) end
        if challenge[4]=="putricide" then points[#points+1]=iccPin("festergut",3);points[#points+1]=iccPin("rotface",3) end
        icc(challenge[index],challenge[3].." ("..size.." player)",size,false,challenge[5],points,challenge[index+5])
    end
end
for _,size in ipairs({10,25}) do
    local ten=size==10
    icc(ten and 4536 or 4612,"I'm on a Boat ("..size.." player)",size,false,{
        lowerRoute,
        "Remain on your own gunship and immediately fire its cannon into the enemy ship. Spend the cannon's heat on Incinerating Blast without overheating. At high level, destroying the enemy ship before its battle-mage freezes the cannons avoids all boarding requirements.",
        "If the cannons freeze, use the equipped Rocket Pack to board the enemy ship, kill the freezing battle-mage, then return and resume cannon fire. No player may visit the enemy ship more than "..(ten and "TWICE" or "ONCE").." during this battle. Coordinate any second boarding rather than reusing a player who has reached the limit.",
    },{iccPin("deathwhisper",2)},ten and {926920} or {2508072},
    "In a group, alternate boarding teams if more trips are needed. A fast solo cannon kill needs zero visits; the 25-player limit is stricter than the 10-player limit.")
    icc(ten and 4539 or 4618,"Once Bitten, Twice Shy ("..size.." player)",size,false,{
        upperRoute,
        "Defeat the Blood Princes, then go upstairs to Lana'thel. For the NOT-A-VAMPIRE criterion, enter combat by walking up to her or using a non-damaging ability. Wait about FIVE seconds, then kill her BEFORE Essence of the Blood Queen appears. An immediate kill before combat registers can give no credit.",
        "On another eligible run, enter combat without attacking and wait until YOUR Essence of the Blood Queen debuff appears. Kill her as soon as it is visible. You are already a vampire at that point; do not wait for Frenzied Bloodthirst or mind control.",
        "Check both criteria for this raid size. You can use the next weekly reset on the same character, or another Warband character with an unused lockout: later Retail comments confirm the shared criteria can combine across characters. Complete the separate 10- and 25-player achievements in their respective sizes.",
    },{iccPin("princes",2),iccPin("queen",3,"Lana'thel - engage, wait briefly, kill BEFORE Essence"),iccPin("queen",4,"Second run - wait for YOUR Essence debuff")},
    ten and {3287684,6413802} or {2099150,3287689,5982800,6060730},
    "No treant or Shadowmeld workaround is needed. Warband sharing allows both criteria to be completed on different eligible characters with unused lockouts.")
    icc(ten and 4579 or 4619,"Portal Jockey ("..size.." player)",size,false,{
        upperRoute,
        "Choose the Frostwing branch and reach Valithria. NORMAL is the straightforward solo bandage route. Kill the four channelers first to start combat, then heal Valithria herself to full before any portals spawn. Direct friendly-target healing or an effective current bandage can work on Normal.",
        "If ordinary bandaging is interrupted or cannot finish, bring a healer or use suitable friendly-target healing such as a Spirit Beast's Spirit Mend or Darkmoon Deck: Dance. Heroic has ongoing damage and may need a different method; do not assume an old low-level bandage works there.",
        "If portals appear, EVERY portal in EVERY set must be entered by someone before it expires. One player entering a single portal is insufficient. Solo, finish before the first set; entering a portal with nobody left outside can reset the encounter. Check Portal Jockey credit before moving on.",
    },{iccPin("valithria",3,"Valithria - start combat, then heal to FULL"),iccPin("valithria",4,"Normal bandage or direct-heal route")},
    ten and {1763060,6259192} or {1763055,5806862,6297042},
    "Valithria is a friendly healing target. A single huge heal before combat has started can end the scene without the intended achievement credit, so begin with the channelers.")
    icc(ten and 4601 or 4621,"Been Waiting a Long Time for This ("..size.." player)",size,false,{
        lichRoute,
        "Speak to Tirion, dismiss attacking pets and remove automatic retaliation damage. Do not damage the Lich King or his adds. Stand on the LOWER few stairs with your back toward the throne; Normal avoids Heroic's Shadow Traps entirely.",
        "Let him summon ghouls while Necrotic Plague jumps between you and nearby adds. Its disappearance from YOUR debuff bar is normal: it is travelling through the pack. Keep the pack together and wait until Necrotic Plague reaches at least THIRTY stacks on a current carrier. Plague Siphon on the boss is a different effect.",
        "Only after seeing 30 or more Necrotic Plague stacks, attack and push the boss into his ending. "..lichFinish,
    },{iccPin("lichking",3,"Lower stairs - no damage while plague builds"),iccPin("lichking",4,"Wait for 30+ Necrotic Plague stacks"),iccPin("lichking",5,"Finish after Tirion and Terenas's ending")},
    ten and {6022006,6025458} or {6026673,6137875,6433961},
    "Modern Retail solo reports do not require a pet, summoned guardian, exactly 30 stacks, or a disease dispeller. Heal yourself if needed. Do not stand so high on the throne stairs that a Heroic trap can throw you off the back.")
end

add(4598,"The Ashen Verdict",{
    "Enter Icecrown Citadel's raid portal at 53.5, 85.5 in Icecrown. Kill the entrance trash and watch your Ashen Verdict reputation increase; neither a faction tabard nor an old emblem currency is required.",
    "For repeated trash farming, leave Marrowgar ALIVE, exit, reset the instance and clear the entrance again. Trigger the floor traps to awaken additional Deathbound Wards rather than disabling the traps. Observe the game's instance-entry limit.",
    "Alternatively clear raid trash and bosses each weekly reset. Finish at Exalted and speak to the Ashen Verdict NPCs at the entrance for any unlocked ring quests. Killing Marrowgar saves that raid and removes the convenient unsaved-trash reset route.",
},{pin(118,53.5,85.5,1,"Icecrown Citadel - Ashen Verdict trash route"),iccPin("marrowgar",2,"Leave Marrowgar alive for repeated trash resets")},
    "The useful old trash-farm method remains the route; fixed reputation totals and old group clear times vary with current bonuses and which wards you awaken.",{932351,1555631})

local function trial(id,name,size,heroic,steps,comments)
    local route={"Outside the Crusaders' Coliseum in Icecrown, set Legacy Raid Size to "..size.." players and Raid Difficulty to "..(heroic and "HEROIC" or "NORMAL")..". Enter Trial of the Crusader's RAID portal at 75.0, 21.8, not the nearby Trial of the Champion dungeon. Confirm the difficulty inside before speaking to the announcer."}
    for _,text in ipairs(steps) do route[#route+1]=text end
    add(id,name,route,{pin(118,75,21.8,1,"Trial of the Crusader - raid entrance")},
        "Talk to the announcer again between arena encounters when progression pauses. The removed limited-attempt tribute achievements are not part of these surviving objectives.",comments)
end
for _,size in ipairs({10,25}) do
    local ten=size==10
    for _,heroic in ipairs({false,true}) do
        trial(heroic and (ten and 3918 or 3812) or (ten and 3917 or 3916),"Call of the "..(heroic and "Grand " or "").."Crusade ("..size.." player)",size,heroic,{
            "Speak to the announcer to begin the Northrend Beasts. Kill Gormok, then Acidmaw and Dreadscale, then Icehowl. These three stages form the FIRST encounter; finish all stages before waiting for the next event.",
            "Start the next event and defeat Lord Jaraxxus. Speak to the announcer for Faction Champions and kill every enemy champion, including healers. Start the Twin Val'kyr and defeat Fjola and Eydis after their introduction.",
            "Let the Lich King's scene break the floor, drop into the cavern and defeat Anub'arak. If he burrows, clear adds and wait for him to resurface. Check every encounter criterion before leaving; a single Anub'arak kill is not a full clear.",
        },heroic and {"https://www.wowhead.com/achievement=3812#comments:id=2305150"} or {})
    end
    trial(ten and 3797 or 3813,"Upper Back Pain ("..size.." player)",size,false,{
        "Start the Northrend Beasts. GORMOK, the first stage, supplies the Snobolds. Use single-target damage to kill him and leave every dropped Snobold alive; later Retail comments confirm the remaining riders can drop when he dies.",
        "Verify that at least "..(ten and "TWO" or "FOUR").." Snobolds are still alive. Disable pets, cleaves, damage shields and retaliation effects that could kill them. Keep them through the Acidmaw and Dreadscale stage, killing only the worms.",
        "When Icehowl enters, kill ONLY Icehowl with the required Snobolds still alive. He does not supply replacement Snobolds. Do not use area damage until the achievement credits.",
    },ten and {2250894,2531234} or {1955378,2441979})
    trial(ten and 3936 or 3937,"Not One, But Two Jormungars ("..size.." player)",size,false,{
        "Start the Northrend Beasts and defeat Gormok. Wait until BOTH Acidmaw and Dreadscale are present and attackable; do not finish the first worm while the other is still entering.",
        "Kill the two worms within TEN seconds of the first death. At high level, target and kill one, immediately switch to the other and kill it. Continue to Icehowl after checking the achievement.",
    },ten and {800350,5643239} or {})
    trial(ten and 3996 or 3997,"Three Sixty Pain Spike ("..size.." player)",size,true,{
        "Defeat the Northrend Beasts and start the Jaraxxus event. Engage Jaraxxus by proximity or a non-damaging taunt. Do not attack the boss, his Nether Portals or the Mistresses.",
        "Wait for a Nether Portal to summon Mistresses of Pain. HEROIC portals can release multiple Mistresses if left alive. Keep at least TWO Mistresses alive at the same time; if the first portal gives only one, wait for the next portal instead of killing Jaraxxus.",
        "With two living Mistresses confirmed, kill ONLY Jaraxxus using direct single-target damage. Check for credit before clearing the Mistresses. No low-health boss setup or removed class talent is required.",
    },ten and {5167457} or {2462397})
    trial(ten and 3799 or 3815,"Salt and Pepper ("..size.." player)",size,false,{
        "Clear Northrend Beasts, Jaraxxus and Faction Champions, then start the Twin Val'kyr event. Let both twins become active. Walk up or use a non-damaging taunt and wait a few seconds for combat to register.",
        "Kill the twins within THREE minutes. Their health is linked, so attack one active twin with your normal damage; select the opposite-colored essence if your attacks need its damage bonus. An immediate pre-combat one-shot can miss credit, so do not attack during their entrance scene.",
    },ten and {2446163,5245439} or {6021709})
    trial(ten and 3800 or 3816,"The Traitor King ("..size.." player)",size,false,{
        "Clear the four arena encounters, wait for the floor-breaking scene and drop down to Anub'arak. Remove automatic retaliation damage and dismiss attacking pets BEFORE entering combat.",
        "Walk up to Anub'arak and DO NOT damage him. Let him burrow and resurface repeatedly while the small SWARM SCARABS gather. Do not confuse the larger Nerubian Burrowers with the required scarabs. Three full burrow cycles are the cautious route to at least 25 scarabs.",
        "Keep all required scarabs alive while waiting, healing yourself if necessary. When at least TWENTY-FIVE are gathered, kill them with area damage within THIRTY seconds of the first scarab death. Doing this while Anub'arak is underground prevents accidentally killing him before the scarabs.",
        "The achievement can credit before the boss dies. Verify it, then finish Anub'arak. Do not lower his health into the final no-burrow phase while still collecting scarabs.",
    },ten and {5541971,6387576} or {2436878,3224863,5548105})
end
trial(3798,"Resilience Will Fix It (10 player)",10,false,{
    "Complete the Northrend Beasts and Jaraxxus, then ask the announcer to start Faction Champions. The enemy heroes are the third raid encounter, not players in the Argent Tournament jousting ring.",
    "Once all champions are active, kill the entire enemy team within SIXTY seconds of the FIRST champion dying. At high level, gather them and use area damage; prioritize any healer that survives. Their summoned pets are not required for the timer.",
},{849218,2058690,2290876})

for _,size in ipairs({10,25}) do
    local ten=size==10
    local start="Set Legacy Raid Size to "..size.." players and enter Onyxia's Lair at 52.0, 76.0 in Dustwallow Marsh. Clear the entrance guards and stop at the edge of Onyxia's egg chamber."
    for _,mode in ipairs({"clear","time","breath","whelps"}) do
        local id=mode=="clear" and (ten and 4396 or 4397) or mode=="time" and (ten and 4402 or 4405) or mode=="breath" and (ten and 4404 or 4407) or (ten and 4403 or 4406)
        local name=mode=="clear" and "Onyxia's Lair" or mode=="time" and "More Dots!" or mode=="breath" and "She Deep Breaths More" or "Many Whelps! Handle It!"
        local steps={start}
        if mode=="whelps" then
            steps[#steps+1]="Prepare your strongest movement ability or a speed potion, then stand at the START of one egg tunnel along the room's edge. Pull Onyxia to you with a non-damaging ability and keep her away from the eggs until you are ready."
            steps[#steps+1]="Damage her to trigger the air phase, then STOP attacking. Start your egg run as soon as she announces that she will incinerate you from above and starts moving back for takeoff. The TEN-second window starts before the full liftoff animation; waiting until she is high in the air is too late."
            steps[#steps+1]="Sprint in a STRAIGHT LINE from the entrance to the far end of the egg tunnel. Passing beside the eggs hatches them; weaving over each individual egg wastes time. Hatch at least FIFTY whelps inside that ten-second window. With a friend, assign one tunnel to each runner."
            steps[#steps+1]="Wait for the trailing whelps to reach you, kill them, then finish Onyxia after she is attackable again. The achievement appears after Onyxia dies, not when the fiftieth egg hatches. An early boss kill before the run cannot satisfy it."
        else
            steps[#steps+1]="Engage Onyxia and attack immediately. If she stops at 1 health and starts flying, wait for the scripted transition, kill the whelps and use ranged attacks when possible. Finish her when she becomes attackable; the temporary health floor does not mean the encounter failed."
            steps[#steps+1]=mode=="time" and "Finish within FIVE minutes of the pull. At high level the scripted transitions are the main delay; avoid unnecessary waiting or detours through the egg tunnels." or mode=="breath" and "Kill her before Deep Breath if possible. If she begins a breath run, move out of the line across the room along her flight path; nobody in the group may take Deep Breath damage. Continue attacking as soon as the run ends." or "Loot Onyxia and check the achievement for the selected size. This is the revamped Wrath raid; killing the historical level-60 version is not required."
        end
        local points={pin(70,52,76,1,"Onyxia's Lair - Dustwallow entrance"),pin(248,67.2,30.9,mode=="whelps" and 3 or 2,"Onyxia - egg chamber","Onyxia's Lair")}
        add(id,name.." ("..size.." player)",steps,points,mode=="whelps" and "The current straight-tunnel route preserves the useful timing correction in the older guide. Use the takeoff announcement rather than counting from the first combat yell. If it fails, another kill attempt needs another unused raid lockout." or nil,
            mode=="whelps" and (ten and {2010131,2229701,6239252,6388191} or {2273835,5624386,6400736}) or mode=="breath" and (ten and {849553,861560} or {1688423}) or {})
    end
end

local watchers={
    {1722,1721,"Archavon the Stone Watcher",49.3,16.8,"Follow the main passage north to Archavon's large final chamber. Kill Archavon; his grabs and ground clouds are unnecessary to wait for at high level."},
    {3136,3137,"Emalon the Storm Watcher",62.7,55.3,"Take the first eastern side chamber to Emalon and his four Tempest Minions. Kill Emalon promptly; if he survives long enough to overcharge a minion, kill that enlarged minion before it reaches ten stacks."},
    {3836,3837,"Koralon the Flame Watcher",36.3,55.1,"Take the western side chamber to Koralon. Kill him while moving out of the fire patches. At high level you do not need a second tank to split Meteor Fists for an ordinary clear."},
    {4585,4586,"Toravon the Ice Watcher",62.7,36.3,"Take the northeastern side chamber to Toravon. Kill him and any Frozen Orbs that appear. He is a separate fourth Watcher and is NOT required for Earth, Wind & Fire."},
}
for _,size in ipairs({10,25}) do
    local index=size==10 and 1 or 2
    local start="Set Legacy Raid Size to "..size.." players outside, fly to Wintergrasp Fortress and enter the Vault of Archavon portal at 50.0, 11.0. This is the outdoor Northrend zone, not the queued Epic Battleground. If access is closed, use the faction-control state shown in that zone."
    for _,w in ipairs(watchers) do
        add(w[index],w[3].." ("..size.." player)",{start,w[6],"Check the named Watcher's achievement for this size before leaving. A 25-player kill does not substitute for the separate 10-player criterion."},
            {pin(123,50,11,1,"Vault of Archavon - fortress raid portal"),pin(156,w[4],w[5],2,w[3],"Vault of Archavon")},nil,{})
    end
    add(size==10 and 4016 or 4017,"Earth, Wind & Fire ("..size.." player)",{
        start,
        "Clear the trash connecting the three original Watchers WITHOUT killing them. Disable damage procs, pets and retaliation. Pull Koralon in the west and Emalon in the east using proximity or non-damaging taunts, then lead both toward the hallway BEFORE Archavon's northern room.",
        "Keep Archavon unengaged while bringing the two other bosses together. Kill Emalon and Koralon in that hallway, then immediately run into Archavon's room and kill him. All THREE must die within SIXTY seconds of the first death.",
        "Do not include Toravon. Pulling Archavon too early can let his grab reset the other bosses, and killing the first Watcher in its original side room wastes the travel portion of the timer. Check credit before leaving.",
    },{pin(123,50,11,1,"Vault of Archavon entrance"),pin(156,36.3,55.1,2,"Koralon - pull without damage","Vault of Archavon"),pin(156,62.7,55.3,2,"Emalon - pull without damage","Vault of Archavon"),pin(156,49.3,16.8,3,"Archavon - kill LAST after the two hallway kills","Vault of Archavon")},
        "This keeps the numbered guide's gathering order and last-boss finish while replacing obsolete health targets with current single-target kills.",size==10 and {1937153,1995191} or {2509207,3187853})
end

add(3316,"Herald of the Titans",{
    "Use a LEVEL 30 character and stop experience gains before preparing. The CURRENT Retail requirement is item level 41 or lower in every equipped slot; old level-80, item-level-107 or item-level-226 instructions predate later squishes. Check the in-game achievement text again before assembling the group.",
    "Prepare a group whose participating characters all meet that level and equipment limit. Audit weapons, off-hands, trinkets and profession-related equipment as well as armor. Prefer unambiguous eligible items; avoid equipping higher-level loot during the run. Recent successful Midnight reports used item level 40 or lower.",
    "Enter regular Ulduar at 41.6, 18.2 in Storm Peaks, clear Flame Leviathan and XT-002, and take the side passage in the Antechamber to the Celestial Planetarium. Use its console to open Algalon's room. A key and the old one-hour access timer are not required.",
    "Defeat Algalon with the eligible characters. Move out of Cosmic Smash, swap tanks as needed for Phase Punch, and arrange Big Bang survival: the group enters available black holes shortly before the cast finishes while a designated survivor remains outside with suitable protection. Do not stand on a black hole after being returned to the normal realm.",
    "Check the title achievement after the defeat. The ordinary max-level Algalon kill cannot award Herald. Recent solo reports use Infinitely Divisible Ooze on an eligible level-30 character, but that trinket is an alternative, not a requirement for the group route.",
},{pin(120,41.6,18.2,3,"Ulduar - regular raid entrance"),pin(148,79.2,45.8,3,"Algalon - Celestial Planetarium","The Antechamber of Ulduar"),pin(148,79.2,45.8,4,"Eligible level-30 group; item level 41 maximum","The Antechamber of Ulduar")},
    "Herald is still obtainable. A September 2026 reply also confirms preparing the route with a high-level friend, but the character and gear requirements must be met for Algalon itself. Remove questionable higher-level items from bags before the attempt as advised by the preparation thread.",{5918538,6055051,6274124,6298260,6354056,6372630,6434335})
add(3142,"Val'anyr, Hammer of Ancient Kings",{
    "Use a Paladin, Priest, Shaman, Monk, Druid or Evoker. Enter regular Ulduar in Storm Peaks and collect THIRTY Fragments of Val'anyr from eligible raid bosses over weekly resets. The present raid has one merged difficulty; the old separate 10/25-player selector is not the current route.",
    "Combine the 30 fragments into Shattered Fragments of Val'anyr and accept Ancient History from the item. After defeating the Assembly of Iron, use the Archivum Console in the room behind their arena. Complete that turn-in, accept Val'anyr, Hammer of Ancient Kings and receive the Unbound Fragments of Val'anyr quest item (45896).",
    "Continue through XT-002 and Kologarn, defeat Hodir, Thorim, Freya and Mimiron, then General Vezax. Leave at least ONE Keeper uninvited to Yogg-Saron. Asking only Thorim to assist is a straightforward setup; do not ask all four, because that removes the final phase's Deafening Roar.",
    "Enter Yogg-Saron's prison and keep the quest item ready. In phase 1, kill each arriving Guardian NEXT TO SARA so its death explosion damages her. Attacking Sara directly does not replace this mechanic. Repeat until Yogg appears and the tentacle/brain phase begins.",
    "Enter a brain portal, clear the illusion's tentacles and damage Yogg's brain to trigger the final phase. Leave through the exit portal BEFORE Induce Madness finishes; repeat the portal cycle if needed. Preserve your Sanity and turn away from gaze effects rather than staying in the brain room until the cast ends.",
    "In the final phase, KEEP YOGG ALIVE and face him when Deafening Roar begins. While he is actually casting it, target him and USE Unbound Fragments of Val'anyr (45896) to throw them into his mouth. After the successful throw, defeat and LOOT Yogg-Saron for the Reforged Hammer. A normal immediate boss kill cannot complete the throw.",
    "Return to the Archivum Console behind the Assembly of Iron arena, complete the quest, receive Val'anyr and EQUIP the finished mace for its wielder achievement. Collecting thirty fragments or completing the throw alone does not award ownership of the finished legendary.",
},{pin(120,41.6,18.2,1,"Ulduar - fragment farming and legendary quest"),pin(148,15.6,56.4,2,"Assembly of Iron - Archivum room beyond its arena","The Antechamber of Ulduar"),pin(149,72.2,48.5,3,"Thorim - optional sole Keeper assistance","The Inner Sanctum of Ulduar"),pin(150,56.7,60.2,3,"General Vezax - route to Yogg","The Prison of Yogg-Saron"),pin(150,68.3,39.9,4,"Sara - Guardians must die beside her","The Prison of Yogg-Saron"),pin(150,68.3,39.9,5,"Yogg - brain portal phase","The Prison of Yogg-Saron"),pin(150,68.3,39.9,6,"Yogg - throw Unbound Fragments DURING Deafening Roar","The Prison of Yogg-Saron"),pin(148,15.6,56.4,7,"Return past Assembly of Iron to Archivum Console","The Antechamber of Ulduar")},
    "Fragments and the finished mace have explicit class restrictions. The old quest text calls its original 25-player requirement Heroic; regular merged Retail Ulduar is the route. Do not confuse this with Timewalking raid tuning.",{669917,"https://www.wowhead.com/item=45038","https://www.wowhead.com/quest=13629"})

icc(4623,"Shadowmourne",25,false,{
    "Use a Warrior, Paladin or Death Knight. Reach Friendly with the Ashen Verdict by killing ICC entrance trash, then accept The Sacred and the Corrupt from Highlord Darion Mograine at the entrance. Buying a chest reward or mount from someone else does not award the legendary weapon achievement.",
    "With the quest active, go to Frostmourne Cavern in Dragonblight (74.4, 23.5). Interact with Light's Vengeance, wait through the scene and complete the follow-up combat/interactions. Also obtain 25 Primordial Saronite and loot Festergut's and Rotface's Acidic Blood from their 25-player kills; return all four components to Darion for Shadow's Edge.",
    "Equip Shadow's Edge for A Feast of Souls. Collect FIFTY souls from ICC enemies after Shadow's Fate has registered on them; immediate kills can miss the quest counter. Use a non-damaging application or controlled low damage and check the counter before clearing a large pack.",
    "Unholy Infusion: with Shadow's Edge equipped, have a helper hold Putricide while you use the experiment table to become an Abomination. Absorb puddles to reach 100 energy, activate Shadow Infusion and finish its cast, then defeat Putricide after the infusion buff is present.",
    "Blood Infusion preparation: keep Shadow's Edge equipped at 25-player Lana'thel. With a helper holding her, stand nearest that helper to receive Blood Mirror and confirm your Gushing Wound quest debuff. Arrange for YOU to receive Essence of the Blood Queen. Stop boss damage and heal while waiting. Eight total players allow the normal expanding bite chain with everyone alive; smaller groups need a planned way to remove or resurrect previously bitten helpers.",
    "When your sixty-second Essence expires, Frenzied Bloodthirst replaces your action bar with Vampiric Bite. Immediately bite an unbitten helper. Repeat on the next two cycles, personally landing THREE bites. Other vampires must feed on separate eligible players so they do not become mind-controlled while you wait. Avoid Divine Shield or similar effects that remove your quest debuff. Only after Gushing Wound becomes the completed infusion buff, kill Lana'thel and return to Darion for Frost Infusion.",
    "Frost Infusion: keep Shadow's Edge equipped, face Sindragosa and survive FOUR Frost Breaths before killing her. Hold damage and heal while waiting; a normal one-shot cannot infuse the weapon.",
    "Complete The Splintered Throne by looting FIFTY Shadowfrost Shards from eligible 25-player ICC boss kills over weekly resets. Return to Darion to forge Shadowmourne, receive and equip it. The separate Sealed Chest reward chain happens afterward and is not required for this wielder achievement.",
},{pin(115,74.4,23.5,3,"Frostmourne Cavern - Light's Vengeance"),iccPin("festergut",3,"25-player Festergut - Acidic Blood"),iccPin("rotface",3,"25-player Rotface - Acidic Blood"),iccPin("putricide",5,"Unholy Infusion - Abomination energy and cast"),iccPin("queen",6,"Blood Infusion - Blood Mirror and first Essence"),iccPin("queen",7,"Blood Infusion - personally bite three times"),iccPin("sindragosa",8,"Frost Infusion - four breaths")},
{"https://www.wowhead.com/achievement=4623#comments","https://www.wowhead.com/item=49623#comments","https://www.wowhead.com/quest=24756#comments:id=2256479"},
"Turn in each infusion and accept the next quest before its encounter. At high level, keep automatic damage and attacking pets off while waiting for the required casts or bites.")

local function mountAchievement(id,name,spell)
    local original=TDP.CollectionWalkthroughs.mounts[spell]
    if not original then return end
    local guide={}
    for key,value in pairs(original) do guide[key]=value end
    guide.achievementId,guide.name,guide.category=id,name,"Mounts"
    guide.sourceType,guide.source="Achievement",name
    guide.acquisition=original.acquisition.."\n\n"..(original.stepCount+1)..". Learn the finished mount, then check "..name.." in your achievement list. A drop attempt or riding another player's mount does not complete this collection criterion."
    guide.stepCount=original.stepCount+1
    guide.wowheadUrl="https://www.wowhead.com/achievement="..id
    guide.sourceURL=guide.wowheadUrl.."#comments"
    guides[id]=guide
end
mountAchievement(4625,"Invincible's Reins",72286)
mountAchievement(4626,"And I'll Form the Head!",63796)

for _,size in ipairs({10,25}) do
    local ten=size==10
    add(ten and 2137 or 2138,"Glory of the Raider ("..size.." player)",{
        "Set Legacy Raid Size to "..size.." players and track the meta's CURRENT checklist. Its three raids are Northrend Naxxramas, Obsidian Sanctum and Eye of Eternity. The removed Immortal/Undying requirements are not necessary for the current meta.",
        "In Naxxramas, plan the special kills before clearing: preserve Faerlina's worshippers, leave Loatheb's spores alive, synchronize the Four Horsemen after their platform split, and gather Kel'Thuzad's abominations before phase 2. Also finish the speed, resistance, polarity and small-group criteria shown in your checklist.",
        "In Obsidian Sanctum, use the three-drake setup for The Twilight Zone and avoid Lava Strike. In Eye of Eternity, finish the timed/small-group kill and personally kill a Scion from a hover disc. Use those individual achievement guides for the mechanics rather than treating every boss as an ordinary clear.",
        "Return in later lockouts for incompatible or missed criteria. Completing this meta still awards achievement credit, but its original Plagued/Black Proto-Drake reward was removed; do not farm the meta expecting those mounts.",
    },{pin(115,87.4,51,2,"Naxxramas - encounter challenges"),pin(115,59.8,54.6,3,"Obsidian Sanctum - three drakes and Lava Strike"),pin(114,27.5,26.6,3,"Eye of Eternity - timed kill and hover disc")},nil,
        ten and {624222,676570} or {624223,1327611})
    icc(ten and 4602 or 4603,"Glory of the Icecrown Raider ("..size.." player)",size,true,{
        "Track the current meta checklist before killing anything. Complete the four Heroic wing clears, including HEALING Valithria. Heroic Lich King and Neck-Deep in Vile are separate achievements and are not required by this mount meta.",
        "In the Lower Spire, preserve five cultist types for Full House; do not one-shot Deathwhisper first. Win the gunship with the boarding limit for this size, and kill Saurfang before too many Marks. In the Plagueworks, avoid ooze explosions, third Inoculated stacks and the Abomination's Regurgitated Ooze.",
        "Finish the Blood Princes' empowered-spell avoidance, then plan Lana'thel's two opposite vampire states on separate eligible runs. A second Warband character can supply the other state. Heal Valithria before portals or use every spawned portal, and defeat Sindragosa without exceeding five Mystic Buffet stacks.",
        "At the Lich King, wait for at least THIRTY actual Necrotic Plague stacks before damaging him. Complete his scripted ending. Check for the meta reward mail and learn the Bloodbathed (10-player) or Icebound (25-player) Frostbrood Vanquisher after all required criteria are complete.",
    },{iccPin("deathwhisper",3),iccPin("festergut",3),iccPin("rotface",3),iccPin("putricide",3),iccPin("princes",4),iccPin("queen",4),iccPin("valithria",4),iccPin("sindragosa",4),iccPin("lichking",5)}, {},
    "Each size has its own meta and mount. The checklist, not the number of bosses killed, determines completion. Use each encounter's detailed guide before committing its weekly kill.")
end
add(1658,"Champion of the Frozen Wastes",{
    "Track this title achievement's boss checklist. Set Dungeon Difficulty to HEROIC and clear the original twelve Northrend launch dungeons; their required final bosses include Mal'Ganis, not the optional Infinite Corruptor.",
    "Use the Northrend Dungeon Hero guide for the entrances and scripted dungeon events. If any final-boss criterion remains missing, revisit that specific Heroic; a Normal clear does not replace the title's Heroic requirement.",
    "Defeat Kel'Thuzad in Northrend Naxxramas, Sartharion in Obsidian Sanctum and Malygos in Eye of Eternity. Either original raid size is suitable for this title. The three raids are separate instances with different entrances.",
    "Check every listed boss, then select Champion of the Frozen Wastes from your title list. No removed realm-first, original-season or level-80-only restriction applies to this surviving title.",
},{pin(117,58.2,48.9,1,"Utgarde Keep - begin Heroic dungeon circuit"),pin(125,66.5,67.8,2,"Violet Hold - original Northrend Dalaran"),pin(75,56.9,82.4,2,"Culling of Stratholme - Heroic Mal'Ganis"),pin(115,87.4,51,3,"Naxxramas - Kel'Thuzad"),pin(115,59.8,54.6,3,"Obsidian Sanctum - Sartharion"),pin(114,27.5,26.6,3,"Eye of Eternity - Malygos")},
    "The individual dungeon guides include all boss requirements and event dialogue. Getting the Bronze Drake alone does not establish Mal'Ganis credit.",{749911,1301767})
add(2136,"Glory of the Hero",{
    "Set HEROIC and track the current checklist. Plan each instance's special objectives BEFORE killing its bosses. Start with ordinary fast-kill conditions, but stop damage wherever a guide requires living adds, a sacrifice, a vehicle color or a debuff.",
    "Schedule the constrained attempts early: Experienced Drake Rider needs three different drake-color kills, and Violet Hold's Lockdown depends on its random prisoners across visits. A saved Heroic boss normally needs the next daily reset for another attempt. Share The Love remains a separate obtainable five-player achievement, but it is no longer required by this meta.",
    "Prepare controlled low damage for The Incredible Hulk and the required Scourge Hulk sword hit. Gather zombies in the Culling's final alley while leaving Arthas waiting. For What the Eck?, obtain and keep Eck Residue before killing Gal'darah. Use those individual guides instead of clearing the whole dungeon indiscriminately.",
    "Work through the remaining listed achievements, checking their criteria after each boss. When the meta completes, collect and learn the Red Proto-Drake reward. Ulduar, Trial of the Champion and the Frozen Halls are not part of this original dungeon meta.",
},{pin(117,57.3,46.7,3,"Utgarde Pinnacle - Scourge Hulk setup"),pin(75,56.9,82.4,3,"Culling of Stratholme - Zombiefest alley"),pin(121,76.4,21.3,3,"Gundrak - Eck Residue before Gal'darah"),pin(114,28.6,27.5,2,"The Oculus - three drake-color visits"),pin(125,66.5,67.8,2,"Violet Hold - random prisoner checklist")},
    "Many high-level kills satisfy simple conditions, but several checklist items deliberately require waiting or preserving enemies. Read the linked encounter guide first.",{6098328})
