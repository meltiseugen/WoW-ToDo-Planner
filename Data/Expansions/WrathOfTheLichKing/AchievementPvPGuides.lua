-- Retail objectives and comment corrections. Outdoor Wintergrasp (123) and
-- its Epic Battleground copy (1334) share bounds, but remain separate maps.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label,mapName)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label,mapName=mapName}
end
local function add(id,name,steps,points,tips,comments,areas)
    local lines,sources={},{}
    for i,s in ipairs(steps) do lines[i]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="PvP",sourceType="Achievement",source=name,
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=points or {},areaMaps=areas,tips=tips,sources=sources,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local function wgPoints(rows,outdoor)
    local points={}
    for _,map in ipairs(outdoor and {123} or {1334,123}) do
        for _,r in ipairs(rows) do points[#points+1]=pin(map,r[1],r[2],r[3],r[4],map==123 and "Wintergrasp (Outdoor)" or "Wintergrasp (Epic Battleground)") end
    end
    return points
end
local winterQueue="For populated PvP, queue for Wintergrasp through the PvP Epic Battleground interface (or its specific battleground selection when available). This loads an INSTANCE. Outdoor Wintergrasp in Northrend is a separate copy that still has its own battle/control state; use the map dropdown to distinguish them."
for _,veteran in ipairs({false,true}) do
    add(veteran and 1718 or 1717,veteran and "Wintergrasp Veteran" or "Wintergrasp Victory",{
        winterQueue,
        "Participate from the start when possible. Help kill eligible enemy players/NPCs to gain battle rank, capture/defend workshops and protect your team's vehicles. Watch the rank buff rather than an old fixed kill count before trying to build an advanced vehicle.",
        "On ATTACK, capture a workshop, use its builder for siege vehicles, breach a route through the fortress walls and final door, then interact with the Titan Relic to win. Protect the vehicles from defenders; attacking ordinary players alone cannot open the fortress.",
        "On DEFENSE, destroy attacking vehicles and protect the relic until time expires. A team can also destroy the three southern towers to reduce the attackers' available time. Stay until the match result records the victory.",
        veteran and "Repeat successful battles until the CURRENT achievement counter reaches 100. Progress is account-wide in the current criteria. Use these matches for cannon, vehicle and Ranger objectives, but a loss does not advance the victory total." or "Check Wintergrasp Victory after your team's successful match. One win is sufficient; the separate Veteran tier needs 100. Walking into the outdoor zone while a different instanced match ends is not a dependable credit method.",
    },wgPoints({{49.3,21.1,3,"Wintergrasp Fortress - walls, final door and relic"},{32.9,38.8,2,"Broken Temple workshop"},{63.8,40.1,2,"Sunken Ring workshop"},{50.1,66.4,4,"Winter's Edge - southern tower"}}),"Old fixed outdoor battle schedules, obsolete queue portals, Tenacity strategies and predictions of a server/faction win rate are omitted.",{ "https://www.wowhead.com/achievement=1717#comments","https://www.wowhead.com/achievement=1718#comments:id=5225012","https://www.wowhead.com/achievement=1718#comments:id=1559153"})
end
add(1723,"Vehicular Gnomeslaughter",{
    winterQueue,
    "During a battle, gain the rank needed for a vehicle and take a friendly workshop, or man an available friendly fortress Tower Cannon. A passenger/cannon position can be useful when a driver is already available.",
    "Use the vehicle/cannon to fight enemy PLAYERS near an active siege. Catapult flame attacks can hit players around a wall push; cannons can assist your team against enemies approaching the fortress. Destroying a vehicle without an eligible player kill is a different criterion.",
    "Check the kill counter after engagements. Comments describe shared nearby honorable-kill credit while mounted in a vehicle, so assist the fight from the vehicle; do not assume you must personally land every player killing blow. Accumulate 100 credited player kills across battles.",
},wgPoints({{32.9,38.8,2,"Broken Temple - vehicle builder when controlled"},{63.8,40.1,2,"Sunken Ring - vehicle builder when controlled"},{49.3,21.1,3,"Fortress - cannon / siege fighting"}}),"Personal spells used after leaving a vehicle are not the primary route. Check the actual counter rather than assuming every nearby enemy death credited.",{569143,669130,1581370})
add(1727,"Leaning Tower",{
    "Enter an active Wintergrasp battle. A clear target on DEFENSE is one of the three southern towers: Shadowsight, Winter's Edge or Flamewatch. The instanced Epic Battleground has players to help; outdoor battles offer an alternate route.",
    "Earn enough rank from enemy NPC/player kills to build a Demolisher or Siege Engine. The central bridge NPC groups around 48.3, 43.8 and 49.1, 50.9 are a reported outdoor rank-building route. Check your rank buff rather than expecting each individual kill to advance it.",
    "Capture a workshop, wait for its friendly builder to appear, then create your vehicle. If one outdoor workshop's builder fails to spawn, check another controlled workshop instead of waiting indefinitely at the flag.",
    "Drive to a hostile southern tower and use the vehicle's siege attacks until it actually COLLAPSES. A 'tower damaged' alert is not completion. Stay involved through the destruction and check the achievement.",
},wgPoints({{48.3,43.8,2,"Central bridge - rank-building NPC group"},{49.1,50.9,2,"Central road - second NPC group"},{32.9,38.8,3,"Broken Temple - workshop builder"},{67.7,61.7,3,"Eastspark - alternate workshop builder"},{24,58.8,4,"Shadowsight Tower"},{50.1,66.4,4,"Winter's Edge Tower"},{79.4,62.7,4,"Flamewatch Tower"}}),"Recent comments also report fortress towers crediting on attack. Southern towers remain the established route; use a tower hostile to your current team and finish its full health bar.",{720259,2559801,5634770,6381033})
for _,id in ipairs({1737,2476}) do
    add(id,"Destruction Derby",{
        winterQueue,
        "Track the FOUR separate Wintergrasp targets: Catapult, Siege Engine, Demolisher and Tower Cannon. You may accumulate their ticks across battles; driving these vehicles is not the same as destroying them.",
        "Follow enemy vehicle pushes from controlled workshops toward the fortress and help destroy each missing vehicle TYPE. Aim to participate through its final destruction and check the corresponding tick immediately.",
        "For Tower Cannon, attack a hostile cannon on an enemy-held tower/fortress wall until destroyed. This target is the cannon, not the entire tower building. Complete all four ticks on the version appropriate to your faction.",
    },wgPoints({{49.3,21.1,3,"Fortress approaches - enemy siege pushes"},{32.9,38.8,3,"Broken Temple - vehicle traffic"},{63.8,40.1,3,"Sunken Ring - vehicle traffic"},{24,58.8,4,"Hostile southern tower cannons"},{79.4,62.7,4,"Hostile southern tower cannons"}}),"Retail reports still describe Siege Engine credit/UI problems. Check the live criterion after a kill and try another eligible enemy engine if missing. Old friendly-duel exploits are not presented as a guaranteed repair.",{ "https://www.wowhead.com/achievement=1737#comments","https://www.wowhead.com/achievement=2476#comments:id=5897587"})
end
add(1751,"Didn't Stand a Chance",{
    "Join a Wintergrasp DEFENSE and get into a friendly TOWER CANNON. The required victims are players still on their own mounts when they die. Enemy siege engines, passengers and dismounted players are not interchangeable with that condition.",
    "Prefer the inner fortress cannons overlooking the gate/courtyard approaches, which generally survive longer than exposed outer cannons. Aim at mounted enemies moving with the attack and keep contributing cannon fire while nearby teammates fight.",
    "Check the mounted-player counter after engagements. Replies report that nearby honorable kills can credit while you are in the cannon, but the player must die mounted. Accumulate twenty credited kills; this does not have to happen in a single defense.",
    "If arranging an outdoor attempt with an opposite-faction friend, use the ACTUAL outdoor battle while your side controls the fortress, get into its cannon and have the friend remain mounted at impact. Re-mount on the ground if the zone's flight warning dismounts them. Repeat only while the battle/credit conditions are active and verify the counter after the first kill.",
},wgPoints({{49.3,21.1,1,"Fortress - use a friendly Tower Cannon"},{46,23,2,"Inner fortress cannon area - gate approaches"},{62,32,4,"Outdoor eastern approach - mounted target area"}}),"This requires mounted enemy players, rather than vehicle destruction. Check the counter after the first eligible kill; an enemy killed after dismounting does not meet the condition.",{830893,890719,927458,5381835,6162215})
add(1755,"Within Our Grasp",{
    "Queue for Wintergrasp and make the attempt when your team is ATTACKING. The current requirement is a successful attack in TEN MINUTES or less. Defending until the timer ends is not the intended route.",
    "Work with the initial team push: earn vehicle rank quickly while teammates secure a workshop. Build advanced siege vehicles as soon as available and escort them to a shared fortress-wall target rather than splitting damage among several gates.",
    "Breach the outer wall, then progress to the final fortress door. A Demolisher can sometimes arc its shot over an inner wall toward the final door when positioned with line of sight; use the visible damage feedback and move if shots do not land. Keep enemy players from destroying your siege.",
    "After the final door falls, enter and claim the Titan Relic BEFORE ten minutes have elapsed from the battle start. Check achievement credit at victory. Contemporary comments recommend the populated instanced battleground over a slow solo outdoor rank grind.",
},wgPoints({{32.9,38.8,2,"Broken Temple - secure a vehicle workshop"},{63.8,40.1,2,"Sunken Ring - secure a vehicle workshop"},{53.8,22,3,"Fortress eastern approach - reported Demolisher angle"},{49.3,21.1,4,"Final fortress door / Titan Relic"}}),"The outdoor version remains possible but is sensitive to builder bugs and rank timing. A 2026 reply confirms completion; old instant-wall damage/level assumptions are omitted.",{1604653,1749244,2538889,6267870})
add(2199,"Wintergrasp Ranger",{
    "Track the TEN area counters. You need ten player kills credited in EACH area, across battles. NPC kills and destroying a cannon do not substitute. The Epic Battleground is the best place to find active players; the outdoor copy can also credit kills.",
    "Fight within Wintergrasp Fortress, then at the middle workshops: The Broken Temple and The Sunken Ring. Watch the subzone name above the minimap and the achievement counter; standing beside an area boundary may credit a neighboring zone.",
    "Work through the southern objectives: Shadowsight Tower, Westspark Workshop, Winter's Edge Tower, Eastspark Workshop and Flamewatch Tower. Join fights while enemy players have a reason to attack or defend these objectives.",
    "Finish The Chilled Quagmire in the northwest and The Cauldron of Flames in the far southeast (84.4, 72.4). The Cauldron often sees little ordinary battleground traffic, so plan that area deliberately rather than expecting it to finish with fortress kills.",
    "For quiet missing areas, an opposite-faction friend can meet you in the OUTDOOR zone for the relevant PvP kills; comment reports allow these outside an active battle. Make sure both are in the same outdoor phase and the kills credit the intended subzone. Check the fortress separately in the instanced battle if outdoor fortress kills fail to advance it.",
    "Review all ten x/10 counters, not just the total number of kills in Wintergrasp. Glacial Falls was removed from the criterion list and is not an eleventh requirement.",
},wgPoints({{49.3,21.1,2,"Wintergrasp Fortress - 10 players"},{32.9,38.8,2,"The Broken Temple - 10 players"},{63.8,40.1,2,"The Sunken Ring - 10 players"},{24,58.8,3,"Shadowsight Tower - 10 players"},{34.7,67.5,3,"Westspark Workshop - 10 players"},{50.1,66.4,3,"Winter's Edge Tower - 10 players"},{67.7,61.7,3,"Eastspark Workshop - 10 players"},{79.4,62.7,3,"Flamewatch Tower - 10 players"},{22.1,34.9,4,"The Chilled Quagmire - 10 players"},{84.4,72.4,4,"The Cauldron of Flames - 10 players"}}),"Pins mark named area search centers. Stay within the matching subzone for each kill. These ten counters are not required in one match.",{707155,799083,879157,3226420,5326587,6365058})
add(1752,"Master of Wintergrasp",{
    "Track the live meta and complete Wintergrasp Veteran (100 wins), Wintergrasp Ranger, Vehicular Gnomeslaughter, Didn't Stand a Chance, Destruction Derby, Leaning Tower and Within Our Grasp using their separate numbered guides.",
    "Buy and learn the ordinary Black War Mammoth from the friendly OUTDOOR fortress quartermaster for fifteen Marks of Honor. Grand Black War Mammoth is a rare raid drop and is NOT required by this meta.",
    "While your faction controls outdoor Wintergrasp, enter Vault of Archavon at the back of the fortress (50, 11.9). Defeat Archavon in BOTH legacy raid sizes, 10 and 25. The meta may still call the second tick 'Heroic: Archavon'; this means the original 25-player version, not an extra modern Heroic difficulty.",
    "Check every component and the faction-appropriate Destruction Derby tick. Raid access and the mammoth vendor use outdoor control; an Epic Battleground victory does not necessarily change control in your separate outdoor copy.",
},{pin(1334,49.3,21.1,1,"Instanced Wintergrasp - battle achievements"),pin(123,51.7,17.2,2,"OUTDOOR quartermaster - ordinary Black War Mammoth"),pin(123,50,11.9,3,"OUTDOOR Vault entrance - Archavon in 10 AND 25"),pin(156,49.3,16.8,3,"Archavon - original legacy size criteria")},nil,{495721,1024183})

for _,alliance in ipairs({true,false}) do
    local id=alliance and 2016 or 2017
    add(id,"Grizzled Veteran",{
        "In Grizzly Hills, enable Trivial Quests and use your faction's quest givers below. All NINE different PvP dailies can be completed in one day; you do not need nine resets or every unrelated zone quest. Accepting tasks can flag you for PvP.",
        alliance and "At the Alliance side of Blue Sky Logging Grounds (39.4-40.5, 42.6-43.9), take Kick 'Em While They're Down (defeat fifteen Horde units/players), Life or Death (bandage ten Wounded Westfall Infantry), Pieces Parts (four Grooved Cogs, three Notched Sprockets, two High Tension Springs), and Shredder Repair (deliver three Broken-down Shredders). Use the supplied bandage/repair/vehicle interactions rather than killing the rescue targets." or "At the Horde side of Blue Sky Logging Grounds (34.4, 32.7), take Keep 'Em on Their Heels (defeat fifteen Alliance units/players), Overwhelmed! (tourniquet ten Wounded Skirmishers), Making Repairs (four Grooved Cogs, three Notched Sprockets, two High Tension Springs), and Shred the Alliance (deliver three shredders). Use the supplied healing/vehicle interactions and return each shredder to the quest giver.",
        alliance and "At Blackriver Logging Camp, take Blackriver Skirmish from Scout Captain Carter (29.9, 59.8). Defeat ten Horde units or players INSIDE that logging area and return the quest." or "Take Blackriver Brawl from Raider Captain Kronn near Blackriver Logging Camp (26.4, 65.7). Defeat ten Alliance units or players INSIDE the logging area and return the quest.",
        alliance and "At the Alliance Venture Bay camp (22.0-22.2, 80.7-81.2), finish Smoke 'Em Out (use Smoke Bombs to drive twenty Venture Company Stragglers out of buildings), Down With Captain Zorna! (kill the captain), and Keep Them at Bay! (ten Horde units/players in Venture Bay)." or "At the Horde Venture Bay camp (10.1, 77.3 and 11.4, 76.7), finish Smoke 'Em Out (Smoke Bomb twenty Venture Company Stragglers from buildings), Crush Captain Brightwater! (kill the captain), and Keep Them at Bay (ten Alliance units/players in Venture Bay).",
        "For Riding the Red Rocket, reach the lighthouse island (14.8, 86.6), become PvP-flagged and stay by its control flag until your faction has FULL control. The quest giver appears only then. Other Venture Bay tasks do not require owning the lighthouse.",
        "Accept the rocket quest, obtain Element 115 BEFORE boarding a red rocket, and ride/steer it into the OPPOSING faction's lumber boat to destroy the shipment. Return for the turn-in; merely mounting a rocket is not the objective.",
        "Check all nine named criteria. The kill tasks accept the listed hostile NPC units, so an empty outdoor area does not prevent those from completing. Shredder deliveries, healing and smoke bombs still need their quest items/actions.",
    },{pin(116,alliance and 39.6 or 34.4,alliance and 43.4 or 32.7,2,alliance and "Alliance Blue Sky camp - four dailies" or "Horde Blue Sky camp - four dailies"),pin(116,alliance and 29.9 or 26.4,alliance and 59.8 or 65.7,3,"Blackriver - faction skirmish daily"),pin(116,alliance and 22.1 or 10.1,alliance and 81.2 or 77.3,4,"Venture Bay - faction camp dailies"),pin(116,14.8,86.6,5,"Lighthouse - reach FULL faction control"),pin(116,14.8,86.6,6,"Red Rocket - obtain Element 115 before boarding")},"These are outdoor Grizzly Hills quests, not the Wintergrasp battleground. Old Honor reward totals are no longer accurate and are omitted.",alliance and {956248,1661838,2099555} or {1039941,2337907,5526143})
end

-- Approximate objective AREA centers read from the current Isle map artwork.
-- These are not exact flag-click/vehicle-spawn pixels. Docks is WEST, Hangar EAST.
local isle={
    docks={29,50,"Docks - Glaives / Catapults"},workshop={48,48,"Workshop - Demolishers / Siege Engine / regular bombs"},
    hangar={61,53,"Hangar - airship access"},quarry={61,79,"Quarry"},refinery={34,23,"Oil Refinery"},
    alliance={48,75,"Alliance Keep"},horde={45,23,"Horde Keep"},
}
local function ioPoints(rows)
    local points={}
    for _,r in ipairs(rows) do local p=isle[r[1]];points[#points+1]=pin(169,p[1],p[2],r[2],r[3] or p[3],"Isle of Conquest") end
    return points
end
local isleQueue="Queue for Isle of Conquest through the PvP Epic Battleground interface (or specific selection when available). This is an instanced battlefield; the map button shows its objective areas, not an outdoor entrance."
for _,veteran in ipairs({false,true}) do
    add(veteran and 3777 or 3776,veteran and "Isle of Conquest Veteran" or "Isle of Conquest Victory",{
        isleQueue,
        "Help secure a working attack route: Docks supplies Glaive Throwers/Catapults, Workshop supplies Demolishers/Siege Engines, and Hangar gives airship access and bombardment. Protect your team's siege while contesting the enemy's important node.",
        "Win by breaching the enemy keep and defeating its commander, OR by reducing the enemy reinforcement total to zero. Do not leave before the match result records your team's victory.",
        veteran and "Repeat until the current achievement counter reaches ONE HUNDRED victories. Losses do not count. Work on bomb, vehicle, turret and location criteria during these games instead of assuming 100 games played is sufficient." or "Check the victory achievement after a successful match. One win is enough for this tier; Isle of Conquest Veteran needs 100 wins, and the other criteria each have their own rules.",
    },ioPoints({{"docks",2},{"workshop",2},{"hangar",2},{"alliance",3},{"horde",3}}),"Old fixed faction win rates, queue-time estimates and level-80 damage values are omitted.",{ "https://www.wowhead.com/achievement=3776#comments:id=2001335","https://www.wowhead.com/achievement=3777#comments"})
end
add(3845,"Isle of Conquest All-Star",{
    "Start a fresh Isle match and track the FOUR tasks. Assault a base, defend a base, destroy a vehicle and kill a player must all credit in THIS ONE match.",
    "Assault a resource flag such as Quarry or Oil Refinery, then stay close enough to protect it. When an enemy ASSAULTS your controlled flag, clear/disable the attacker and click the flag back BEFORE their capture completes; this grants a defense. Taking an already fully enemy-controlled base is another assault, not a defense.",
    "Participate in a player kill near the objective or another active fight. The comments report honorable-kill participation is enough; check the player criterion rather than spending the match chasing a solo killing blow.",
    "Destroy an enemy vehicle and aim for its FINAL killing blow. Docks Catapults/Glaives or Workshop Demolishers are opportunities when controlled by the enemy. If one vehicle type fails to tick, try another during the same game.",
    "Verify all four ticks before the battle ends. A win is not a listed condition, and tasks from an earlier match do not satisfy the single-match requirement. This achievement is separate from the Isle meta's required list.",
},ioPoints({{"quarry",2},{"refinery",2},{"docks",4},{"workshop",4}}),nil,{799306,799639,805363,1065074,2326163})
for _,alliance in ipairs({true,false}) do
    for _,all in ipairs({false,true}) do
        local id=all and (alliance and 3851 or 4177) or (alliance and 3846 or 4176)
        add(id,all and "Mine" or "Resource Glut",{
            isleQueue,
            all and "Your team must control ALL FIVE non-keep nodes at VICTORY: Quarry, Oil Refinery, Docks (called Shipyard in the achievement), Workshop (Siege Workshop) and Hangar. Capturing them at unrelated times or in separate games is insufficient." or "Your team must control BOTH resource nodes at VICTORY: Quarry and Oil Refinery. The team's usual siege objective alone is not this condition.",
            "Capture the missing nodes early and keep defenders assigned while the main attack progresses. Watch the live node colors/capture state on the battleground map. Retake an assaulted flag promptly instead of assuming a contested node will satisfy the requirement.",
            "Keep the required flags friendly through the actual win, whether achieved by commander kill or reinforcements. Coordinate the last captures before the victory trigger when possible; a last-second enemy assault can spoil the attempt.",
            "Check the achievement after the match result. "..(all and "Completing Mine can also complete the earlier Resource Glut tier. Old mercenary-mode/partially controlled-node reports describe inconsistent credit, not a dependable route." or "Resource Glut is the two-node tier; Mine adds the three siege/airship nodes in the later tier."),
        },all and ioPoints({{"quarry",2},{"refinery",2},{"docks",2},{"workshop",2},{"hangar",2}}) or ioPoints({{"quarry",2},{"refinery",2}}),"Aim for full control at victory. Comment claims about tapped/contested nodes conflict across patches.",{ "https://www.wowhead.com/achievement="..id.."#comments","https://www.wowhead.com/achievement=4177#comments:id=802832","https://www.wowhead.com/achievement=4177#comments:id=6319566"})
    end
end
add(3847,"Four Car Garage",{
    "In Isle of Conquest, track the four vehicle types. You need to CONTROL each vehicle, not destroy it. The ticks can be completed across multiple matches.",
    "When your team controls Docks, take the DRIVER seat of a Glaive Thrower and check its tick. Then drive a Catapult and check that separate tick. An ordinary mount or an enemy vehicle does not satisfy either.",
    "When your team controls Workshop, drive a Demolisher. Stay for the Siege Engine's construction/repair period and enter its driver seat once usable. Being only a turret passenger does not reliably grant the control criterion.",
    "Check all four names. If someone else is driving the Siege Engine, arrange a safe seat change during the game or try a later spawn/match; the old method of waiting for the driver to leave after the match ends is unreliable.",
},ioPoints({{"docks",2},{"workshop",3}}),nil,{799127,799380,799438,807736})
for _,huge in ipairs({false,true}) do
    local id=huge and 3849 or 3848
    add(id,huge and "A-bomb-ination" or "A-bomb-inable",{
        "Track this achievement at the start of an Isle match. You need FIVE "..(huge and "HUGE Seaforium Bombs (47030)" or "regular Seaforium Bombs (46847)").." to damage enemy gates in ONE match. The other bomb size advances a different achievement.",
        huge and "Reach the ENEMY courtyard while gates remain: control Hangar and parachute from the airship, or use a Docks Catapult to launch over the wall. Loot a Huge Seaforium Bomb from the enemy keep's bomb stack. Your own keep's stack is not the source for attacking its gates." or "Help your team capture and fully control Workshop. Loot one regular Seaforium Bomb from its stack and carry it to an enemy keep gate.",
        "Place the bomb close enough to a STILL-STANDING enemy gate to damage it. Keep defenders from disarming it and wait for detonation. A planted/disarmed bomb or an explosion beside an already destroyed gate does not satisfy the intended damage condition.",
        "Check that the counter advanced, then return to the matching stack for another bomb. Repeat the run until five detonations credit before the match ends. You need a fresh pickup for each bomb; the old repeated-use trick was hotfixed.",
        "If your main gate target falls, use another standing enemy gate while there is time. A team victory is not itself a listed requirement, but the match must last long enough for all five credited bombs. Do not assume regular and Huge bombs can be mixed to total five.",
    },huge and ioPoints({{"hangar",2},{"docks",2},{"alliance",2,"Alliance keep - Huge bombs when it is the ENEMY keep"},{"horde",2,"Horde keep - Huge bombs when it is the ENEMY keep"},{"alliance",3},{"horde",3}}) or ioPoints({{"workshop",2},{"alliance",3},{"horde",3}}),"Choose the keep hostile to your current battleground team, including when playing as a mercenary. Current comments include credit failures, so verify the first actual gate-damaging detonation before repeating the whole route.",huge and {799377,1023406,1798966,6119690} or {812066,867018,1025907,1650077})
end
add(3850,"Mowed Down",{
    "In Isle of Conquest, man a KEEP CANNON on your friendly fortress wall. The achievement needs TEN vehicle kills and ONE HUNDRED player kills with turrets, accumulated across matches. Airship bombardment turrets are not the established keep-cannon route.",
    "Use the cannons facing the approaches from enemy-held Docks or Workshop. Fire at incoming players and vehicles while your team fights near the walls. Catapults are useful vehicle targets because they are easier to finish than a fresh Siege Engine.",
    "For the vehicle counter, land the FINAL damaging blow with the cannon. Merely helping damage a vehicle that another player finishes does not reliably count. Save the turret's stronger attack for an enemy vehicle low enough to finish.",
    "For players, nearby honorable-kill credit while in the cannon is sufficient according to current replies; continue supporting the fight. Check both independent counters and repeat until 10 vehicles and 100 players are recorded.",
},ioPoints({{"alliance",1,"Alliance Keep - friendly wall cannon when on Alliance team"},{"horde",1,"Horde Keep - friendly wall cannon when on Horde team"},{"docks",2,"Watch enemy Docks vehicles approaching your keep"},{"workshop",2,"Watch enemy Workshop vehicles approaching your keep"}}),"September 2026 comments confirm the final-blow distinction for vehicles. Do not mistake many player honorable kills for vehicle-kill progress.",{799655,799801,839148,1996103,5966537,6413720})
add(3852,"Cut the Blue Wire... No the Red Wire!",{
    "Defend your own Isle of Conquest keep when enemy bombers are present. You need to DISARM twenty-five enemy-planted bombs in total; these can be spread across matches.",
    "Watch the inside gates for Huge Seaforium bombs brought by enemy parachute/Catapult infiltrators and the outside gates for regular Workshop bomb runners. Identify the actual planted bomb object; killing the carrier before planting does not give a disarm.",
    "After a bomb is planted, move to it, RIGHT-CLICK and finish the disarm channel before it explodes. The comments describe roughly ten seconds to detonation and a short disarm cast, so begin promptly and use crowd control/defensive abilities to avoid interruption.",
    "Use nearby cover, stealth or invisibility to approach when the bomber turns away. Check that each completed disarm advances the counter, then continue supporting your keep. If nobody is planting bombs in this game, work on another objective and resume in a match with bombers.",
    "Continue until twenty-five disarms credit. Do not rely on clicking through a closed gate or on old corpse/line-of-sight tricks; use a reachable bomb and complete its interaction.",
},ioPoints({{"alliance",1,"Alliance Keep - defend friendly gates / disarm planted bombs"},{"horde",1,"Horde Keep - defend friendly gates / disarm planted bombs"}}),nil,{799526,815201,861544,1968395,5836906,6122378})
add(3853,"All Over the Isle",{
    "Track the FIVE location criteria at the start of an Isle match: Workshop, Docks, Hangar, Alliance Keep and Horde Keep. The current requirement is a player kill in EACH area in a SINGLE match.",
    "Join the opening fights at Docks, Workshop and Hangar, moving between missing areas while teammates are actively fighting there. You need credited player kills, not flag clicks or vehicle destruction. Honorable-kill participation is reported to work without every personal killing blow.",
    "Get a player kill in your own keep during its defense. For the ENEMY keep, use a Hangar airship drop or a Catapult entry while a group can fight there; do not wait until the commander is already about to die.",
    "Watch your subzone name above the minimap and check each criterion immediately. Standing just outside a keep or node's boundary can credit a different location. Complete all five before the match result; old accidental cross-match credit is not the planned route.",
},ioPoints({{"docks",2},{"workshop",2},{"hangar",2},{"alliance",3},{"horde",3}}),nil,{834271,1572637,1606052,"https://www.wowhead.com/achievement=3957#comments:id=830737"})
add(3854,"Back Door Job",{
    "Enter an Isle match and act BEFORE any enemy keep gate is destroyed. You need to enter its courtyard while ALL its gates still stand; walking through a breach later is too late.",
    "Help control Hangar, board your team's airship and drop into the enemy courtyard using the supplied parachute. Land INSIDE the walls, not on the outside slope.",
    "Alternatively control Docks, drive a Catapult into a safe launch position, aim the launch and propel yourself over the enemy wall. Check your landing location and achievement credit.",
    "Once inside, you can work on Huge Seaforium bombing or the enemy-keep location kill while supporting the attack. No commander kill or match victory is required for Back Door Job itself.",
},ioPoints({{"hangar",2},{"docks",3},{"alliance",2,"Enemy courtyard if attacking Alliance Keep"},{"horde",2,"Enemy courtyard if attacking Horde Keep"}}),nil,{801892,"https://www.wowhead.com/achievement=3957#comments:id=830737"})
add(3855,"Glaive Grave",{
    "Help your team control Docks and take a Glaive Thrower. You need ten credited player kills while using a glaive WITHOUT YOUR CHARACTER DYING; destroying ten vehicles is a different objective.",
    "Travel with a supporting group and use the glaive's long range near an active fight. Stay behind cover from keep cannons/enemy players where possible and aim at groups rather than driving into melee to chase one target.",
    "Comments establish that honorable-kill participation while in the glaive can credit, without ten personal last hits. Keep firing and check the count. Preserve your character's life if the vehicle is about to be destroyed; you can use a replacement glaive without intentionally dying.",
    "Reach ten credited kills before a death resets the streak. Aim to finish in one safe match; older reports of carrying an unbroken streak across matches are not a reason to assume a death outside the battleground is harmless.",
},ioPoints({{"docks",1,"Friendly Docks - take a Glaive Thrower"},{"alliance",2,"Keep approach - stay at supported range"},{"horde",2,"Keep approach - stay at supported range"}}),nil,{799296,802611,804581,1133778,1919895})
for _,id in ipairs({3856,4256}) do
    add(id,"Demolition Derby",{
        "Track the FOUR vehicle-destruction criteria in Isle of Conquest. These ticks can be accumulated over multiple matches; you need the final killing blow on each missing vehicle type.",
        "When the ENEMY controls Docks, attack an enemy Glaive Thrower and Catapult. Stay for the final destruction and check each distinct tick. Driving the friendly versions only advances Four Car Garage.",
        "When the ENEMY controls Workshop, target a Demolisher and the completed Siege Engine. The Siege Engine has a construction/repair period before becoming usable/attackable, so its friendly-looking build phase is not an eligible kill.",
        "If killing an occupied engine repeatedly fails to credit, recent replies describe destroying a newly completed enemy vehicle at its SPAWN before a player enters. The engine must first finish its repair period; check attackability and use burst for the last blow. This is a reported alternative, not guaranteed credit for every bugged attempt.",
        "You may use your character, a vehicle or a keep cannon, provided your attack gets the final vehicle kill. Check all four criteria; high damage or a 'kill' message alone has produced inconsistent Siege Engine credit in comments.",
    },ioPoints({{"docks",2,"Enemy Docks - Glaive / Catapult kills"},{"workshop",3,"Enemy Workshop - Demolisher / Siege Engine kills"},{"workshop",4,"Completed spawn - reported unoccupied-engine alternative"},{"alliance",5,"Friendly keep cannon - alternate final blow"},{"horde",5,"Friendly keep cannon - alternate final blow"}}),"The enemy must own the vehicle source; do not damage your team's objective plan to create a target. This is separate from Wintergrasp's similarly named Destruction Derby.",{ "https://www.wowhead.com/achievement=3856#comments:id=798785","https://www.wowhead.com/achievement=3856#comments:id=6085447","https://www.wowhead.com/achievement=4256#comments:id=3234835"})
end
for _,id in ipairs({3857,3957}) do
    add(id,"Master of Isle of Conquest",{
        "Track the live meta and start the long counter, Isle of Conquest Veteran (100 wins). During these games, complete Four Car Garage and both faction-appropriate Demolition Derby/vehicle requirements as they become available.",
        "On offense, do Back Door Job before enemy gates fall. Work on FIVE regular Workshop bombs in one match for A-bomb-inable, and FIVE Huge bombs from the enemy courtyard in one match for A-bomb-ination. Different bomb sizes cannot be mixed for the same five-bomb criterion.",
        "On defense, disarm twenty-five bombs over time and use KEEP cannons for Mowed Down's ten vehicle final blows and one hundred player kills. Use the detailed subguides so player honorable-kill credit is not confused with vehicle final-blow credit.",
        "Finish Glaive Grave's ten-player streak without dying, All Over the Isle's FIVE area kills in one match, and Mine's victory while all five nodes are controlled. All-Star is NOT an extra required criterion for this meta.",
        "Complete every live meta tick, then collect Tabard of Conquest from the achievement mail/replacement service if needed. The meta can combine completed achievements across matches; individual single-match and no-death rules still apply to their own sub-achievements.",
    },ioPoints({{"docks",1},{"workshop",1},{"hangar",2},{"alliance",3},{"horde",3},{"quarry",4},{"refinery",4}}),"The numbered guides retain useful old tactics but omit obsolete level-80 damage, fixed faction-win assumptions and removed Strand requirements.",{ "https://www.wowhead.com/achievement=3957#comments:id=830737","https://www.wowhead.com/achievement=3857#comments:id=1711225","https://www.wowhead.com/achievement=3845#comments:id=805363"})
end

-- Final Wrath metadata: this module loads after all other achievement guides.
-- Retail availability/difficulty review, 2026-11-04. Rate acquisition effort,
-- including prerequisites, randomness, resets and other players. Existing
-- ratings (including the two copied mount guides) are preserved.
-- Surviving Glory of the Raider achievements do not award the retired mounts.
-- Ultimate Triage remains available through Tailoring. Herald is obtainable
-- with its level/equipment restrictions. Pit of Saron's two retired mechanic
-- achievements are excluded; its ordinary clear achievements remain.
-- https://www.wowhead.com/achievement=141/ultimate-triage
-- https://www.wowhead.com/achievement=3316/herald-of-the-titans
-- https://warcraft.wiki.gg/wiki/Glory_of_the_Raider_(10_player)
-- https://www.curseforge.com/wow/addons/krowi-achievement-filter/files/9058137
-- https://eu.forums.blizzard.com/en/wow/t/pit-of-saron-achievement-bugged/613785/7
-- Individual guide source/comment receipts above and in the other Wrath
-- modules document the retained encounter, profession, quest and PvP routes.
local function rate(level, reason, achievementIDs)
    for _, id in ipairs(achievementIDs) do
        local guide = guides[id]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end

-- Exploration and outdoor quests.
rate("easy", "Fly through each named subzone and confirm its discovery; combat and random drops are unnecessary.", {
    1263,1264,1265,1266,1267,1268,1269,1270,1457,
})
rate("easy", "Complete the short turkey-kill or critter-emote checklist; attempts can be repeated without a lockout.", {1254,2557})
rate("medium", "Complete the substantial zone quest checklist, including its prerequisite branches and scripted events.", {
    33,34,35,36,37,38,39,40,1356,1357,1358,1359,547,938,1596,
})
rate("medium", "Finish all nine Northrend zone exploration checklists; the route spans the whole continent.", {45})
rate("easy", "Complete the camp's short rescue quest branches and final Harold Lane turn-in.", {561})
rate("medium", "Unlock the dragon vehicle daily and finish its objectives and turn-in within three minutes.", {1277})
rate("medium", "Chain ten mine launches without landing; positioning and movement can require repeated attempts.", {1428})
rate("medium", "Complete the faction's Grizzly Hills daily checklist, including vehicle and controlled-objective quests.", {2016,2017})
rate("medium", "Search known Northrend spawn areas and defeat one eligible rare; respawn timing varies.", {2256})
rate("hard", "Complete all eight Northrend zone quest achievements; the full continent is a lengthy quest project.", {41})
rate("hard", "Find all eight correct Dalaran books among decoys and multi-hour respawn timers.", {1956})
rate("hard", "Find every required Northrend rare across contested spawns and long, unpredictable respawn timers.", {2257})

-- Professions, fishing and reputation.
rate("medium", "Raise the required Northrend profession categories to 75 using expansion-specific recipes or gathering.", {125,130,734,735})
rate("medium", "Learn the heavy bandage recipe and personally craft five hundred bandages from gathered or bought cloth.", {137})
rate("easy", "Buy a qualifying bandage and heal a controlled low-health target; the retired First Aid profession is unnecessary.", {141})
rate("easy", "Buy or cook the required food and perform the short eating or critter-feeding checklist.", {1780,1781})
rate("medium", "Learn and personally cook the required number of different Northrend recipes; repeated batches do not add distinct ticks.", {1777,1778})
rate("medium", "Complete each randomly offered Dalaran cooking or fishing daily over multiple resets.", {1782,1783,3217})
rate("medium", "Place the correct Great Feast in all four required battlegrounds; queuing and travel take several matches.", {1785})
rate("medium", "Find and successfully fish each of the ten named Northrend schools across the continent.", {1517})
rate("medium", "Fish the required fountain coin checklist; duplicate catches extend the collection effort.", {1957,2094,2095,2096})
rate("hard", "Learn and cook all forty-five required recipes, including dropped recipes, award purchases and quest unlocks.", {1779})
rate("hard", "Personally fish and loot the rare sewer rat; buying a caged pet does not satisfy this catch achievement.", {1958})
rate("hard", "Fish eligible pools until the very rare Sea Turtle catch appears; completion has no fixed attempt count.", {3218})
rate("hard", "Earn and spend one hundred Epicurean's Awards on the Chef's Hat; regular income is limited by daily quests.", {3296})
rate("medium", "Unlock the faction and farm its guaranteed Exalted reputation through quests, tabard runs or dailies.", {
    947,949,950,951,1007,1008,1009,1011,1012,
})
rate("medium", "Unlock the chosen Sholazar allegiance and finish all eight distinct rotating daily quests.", {961,962})
rate("medium", "Earn a tournament championship and the corresponding Silver Covenant or Sunreavers Exalted reputation.", {3676,3677})
rate("medium", "Earn Ashen Verdict Exalted through Icecrown kills; repeated trash farming or raid resets are needed.", {4598})
rate("hard", "Reach Exalted with both opposing Sholazar factions, recording each side before switching or using separate characters.", {952})
rate("hard", "Complete four separate Northrend Exalted reputation grinds for the meta.", {1010})

-- Tournament ranks and ownership achievements.
rate("easy", "Enroll through the short Argent Tournament introduction; the later training ranks are separate.", {2756})
rate("medium", "Complete Aspirant training and multiple daily turn-ins for fifteen Aspirant's Seals.", {2758})
rate("medium", "Complete one city's Valiant training and challenge; Exalted variants also require that city's reputation grind.", {
    2760,2761,2762,2763,2764,2765,2766,2767,2768,2769,
    2777,2778,2779,2780,2781,2783,2784,2785,2786,2787,
})
rate("medium", "Unlock the tournament vehicle and win a mounted player duel with another participant.", {2772})
rate("medium", "Finish the Black Knight investigation, obtain a city championship and complete the quest duel.", {2773})
rate("medium", "Reach Valiant and defeat all ten racial riders using the tournament vehicle's combat abilities.", {2836})
rate("hard", "Champion all five home cities through consecutive daily training stages; Exalted variants add all required reputations.", {2770,2771,2782,2788,2816,2817})
rate("hard", "Unlock the Crusader vendor, obtain the squire or gruntling and earn 150 Champion's Seals for its bridle.", {3736})
rate("easy", "Buy and use the named gold-vendor item; no rare drop or reputation rank is required.", {2076,2077,2078,2084})
rate("medium", "Earn fifteen Marks of Honor, then buy and learn the Black War Mammoth from a friendly Wintergrasp quartermaster.", {2080})
rate("medium", "Unlock the Sons of Hodir and reach the named mammoth's required reputation before purchasing it.", {2082,2083})
rate("medium", "Buy the tradable crafted motorcycle or complete the Northrend Engineering recipe and material requirements.", {2097})
rate("medium", "Obtain a tradable Battered Hilt, then complete its multi-dungeon reforging and Sunwell quest chain.", {4596})
rate("hard", "Farm the Grand Black War Mammoth's rare Vault drop across weekly loot opportunities, then learn it.", {2081})
rate("hard", "Farm the named rare raid mount across weekly lockouts, then learn it for ownership credit.", {4625,4626})
rate("hard", "Collect thirty Val'anyr fragments over weekly raids and complete the legendary's Yogg-Saron quest mechanics.", {3142})
rate("hard", "Complete the restricted-class legendary chain, coordinated infusion mechanics and fifty weekly raid shards.", {4623})
rate("hard", "Assemble a level-30 raid meeting Herald's equipment restrictions and defeat Algalon within those limits.", {3316})

-- Ordinary dungeons and their encounter challenges.
rate("easy", "Clear the named legacy dungeon in the required mode and complete its scripted boss events.", {
    477,478,479,480,481,482,483,484,485,486,487,488,
    489,490,491,492,493,494,495,496,497,498,499,500,
    3778,4296,4297,4298,4516,4517,4518,4519,4520,4521,
})
rate("medium", "Clear all twelve launch dungeons; the Heroic and title variants add their stated mode or raid requirements.", {1288,1289,1658})
rate("easy", "A high-level direct kill satisfies the condition; avoid prohibited adds, dispels or transformations.", {
    1296,1297,1860,1862,1866,1867,1919,2036,2037,2038,2040,2042,2058,2150,2151,2157,4523,
})
rate("easy", "Preserve the Violet Hold seal at full health and finish all waves without using a defense crystal.", {1816})
rate("easy", "Follow Arthas promptly and kill the Infinite Corruptor before the generous Heroic timer expires.", {1817})
rate("easy", "Wait for Bjarngrim's electrical charge before engaging, then defeat him while charged.", {1834})
rate("easy", "Use a permitted Ruby drake and its attacks for the Eregos kill; do not use the prohibited color.", {2045,2046})
rate("easy", "Kill the Black Knight's forms and ghouls promptly while avoiding marked explosions.", {3804})
rate("medium", "Wait for Eck Residue to apply, preserve the debuff and then defeat Gal'darah.", {1864})
rate("medium", "Collect all six randomly selected Violet Hold prisoners across eligible rerolls or daily clears.", {1865})
rate("medium", "Complete the Oculus vehicle route within twenty minutes, including every construct and platform stage.", {1868})
rate("medium", "Defeat Eregos using each of the three drake colors on separate eligible clears.", {1871})
rate("medium", "Gather one hundred zombies, control damage and kill them within the same one-minute window.", {1872})
rate("medium", "Collect the harpoons and execute Skadi's required gauntlet timing or single-pass objective.", {1873,2156})
rate("medium", "Keep King Dred alive while killing six qualifying raptors during his encounter.", {2039})
rate("medium", "Obtain the required randomly selected Violet Hold boss, then preserve its prohibited adds or globule condition.", {2041,2153})
rate("medium", "Use the permitted Emerald drake's poison and self-healing mechanics to defeat Eregos without Ruby drakes.", {2044})
rate("medium", "Hold damage for the sacrifice or defense event and preserve the exact encounter condition.", {2056,2057,2154})
rate("medium", "Hold Sjonnir alive while combining oozes and killing five Iron Sludges without accidental boss damage.", {2155})
rate("medium", "Defeat Paletress with five different randomly summoned memories over separate eligible visits.", {3802})
rate("medium", "Wait for Eadric's hammer, use the temporary vehicle action and finish the encounter correctly.", {3803})
rate("medium", "Finish the four scripted escape walls and board the rescuing ship before the six-minute deadline.", {4526})
rate("hard", "Use controlled low damage to let a Scourge Hulk kill the ritual enemy with its required sword attack.", {2043})
rate("hard", "Bring five eligible players and keep Gal'darah alive until every player has been impaled.", {2152})
rate("hard", "Keep four Corrupted Soul Fragments alive at Bronjahm's death using a prepared group or the specialized solo route.", {4522})
rate("hard", "Complete the Heroic dungeon challenge meta, including random prisoners, vehicle colors and controlled-damage mechanics.", {2136})

-- Legacy raids: rate surviving mechanics using high-level Retail behavior.
rate("easy", "Defeat the required legacy raid bosses in the correct size and mode, allowing scripted events to finish.", {
    562,563,564,565,566,567,568,569,572,573,574,575,576,577,578,579,
    622,623,624,625,1869,1870,1874,1875,1876,1877,
    1721,1722,3136,3137,3836,3837,4585,4586,
    3812,3916,3917,3918,4396,4397,4402,4404,4405,4407,
    4528,4529,4530,4531,4583,4584,4597,4604,4605,4606,
    4628,4629,4630,4632,4633,4634,
})
rate("easy", "A high-level fast kill or solo small-group clear satisfies the surviving Naxxramas encounter condition.", {
    1856,1857,1858,1859,1996,1997,2139,2140,2146,2147,2178,2179,2180,2181,2182,2183,
})
rate("easy", "Kill Sartharion promptly with the required drakes alive and avoid Lava Strike if the fight lasts.", {2047,2048,2049,2050,2051,2052,2053,2054})
rate("medium", "Wait for the Four Horsemen to leave their platforms, then kill all four within fifteen seconds.", {2176,2177})
rate("medium", "Gather at least eighteen abominations and keep them alive until Kel'Thuzad's second phase before killing them.", {2184,2185})
rate("medium", "Use a Nexus Lord's hover disc and personally land a direct killing blow on a flying Scion.", {2148,2149})
rate("medium", "Preserve the required Snobolds or gather Anub'arak's beetles before completing the encounter.", {3797,3813,3800,3816})
rate("easy", "Burst the eligible Faction Champions or synchronize the worm kills within the stated short window.", {3798,3799,3815,3936,3937})
rate("medium", "Keep Jaraxxus alive until two Mistresses of Pain are active, then kill only the boss while both survive.", {3996,3997})
rate("hard", "Keep all three Vault Watchers alive, bring them together and coordinate their deaths within sixty seconds.", {4016,4017})
rate("medium", "Hatch fifty whelps within ten seconds of Onyxia's takeoff, then complete the encounter.", {4403,4406})
rate("medium", "Control Halion's damage thresholds and use the Twilight portal so all required phases register before the kill.", {4815,4816,4817,4818})
rate("easy", "Kill promptly or use the short prescribed gunship route before the prohibited Icecrown mechanic can occur.", {
    4534,4536,4537,4538,4577,4578,4580,4581,4582,
    4610,4612,4613,4614,4615,4616,4617,4620,4622,
})
rate("medium", "Preserve five distinct transformed cultist types, then kill only Lady Deathwhisper while all five survive.", {4535,4611})
rate("medium", "Complete separate Lana'thel kills with and without the vampire debuff; plan eligible characters or another reset.", {4539,4618})
rate("medium", "Use a healing-capable character or helper for Valithria and meet the required portal condition.", {4579,4619})
rate("medium", "Complete the required Icecrown wing or full clear, including healing Valithria rather than skipping her.", {4527,4532,4607,4608,4631,4635,4636,4637})
rate("hard", "Hold the Lich King in phase one and maintain a plague chain until the actual Necrotic Plague reaches thirty stacks.", {4601,4621})
rate("hard", "Complete every surviving Naxxramas, Eye of Eternity and Obsidian Sanctum challenge in the selected size.", {2137,2138})
rate("hard", "Finish the matching Heroic Icecrown meta, including controlled adds, healing, plague stacks and opposite vampire states.", {4602,4603})

-- PvP: ordinary victories and finite objective checklists remain available;
-- season-limited rewards were already excluded by the achievement catalogue.
rate("medium", "Win one Wintergrasp or Isle of Conquest match against the opposing team.", {1717,3776})
rate("medium", "Build a siege vehicle and fully destroy a hostile Wintergrasp tower during an active battle.", {1727})
rate("medium", "Participate in destroying all four distinct Wintergrasp vehicle or cannon types across battles.", {1737,2476})
rate("medium", "Complete all three personal Isle of Conquest objectives in one match while responding to the opposing team.", {3845})
rate("medium", "Control each of the four battleground vehicle types; seat access depends on team-controlled objectives.", {3847})
rate("medium", "Deliver and detonate five bombs of the required size on enemy gates within one battle.", {3848,3849})
rate("medium", "Use a catapult or gunship to enter the enemy courtyard before its gates are breached.", {3854})
rate("medium", "Land the required final blows on four enemy Isle of Conquest vehicle types across battles.", {3856,4256})
rate("hard", "Accumulate one hundred battleground victories; losses do not advance the counter.", {1718,3777})
rate("hard", "Accumulate one hundred player kills while operating Wintergrasp vehicles or cannons.", {1723})
rate("hard", "Earn twenty kills on still-mounted enemy players from a Wintergrasp cannon; suitable targets are uncommon.", {1751})
rate("hard", "Complete every Wintergrasp meta criterion, including long win, vehicle and area-kill counters.", {1752})
rate("hard", "Coordinate an attacking Wintergrasp victory within ten minutes, including rank, siege and relic progress.", {1755})
rate("hard", "Earn ten player kills in each of ten named Wintergrasp areas, including locations with little regular fighting.", {2199})
rate("hard", "Control both resource nodes and accumulate the required Isle of Conquest resources before the battle ends.", {3846,4176})
rate("hard", "Earn one hundred player kills and ten vehicle final blows from keep cannons across contested battles.", {3850})
rate("hard", "Win while your team simultaneously controls all five required Isle of Conquest objectives.", {3851,4177})
rate("hard", "Find and successfully disarm twenty-five enemy bombs while defending contested gates.", {3852})
rate("hard", "Earn player-kill credit at all five required Isle of Conquest locations within a single battle.", {3853})
rate("hard", "Earn ten player kills from a Glaive Thrower without dying while protecting the vulnerable vehicle.", {3855})
rate("hard", "Finish the Isle of Conquest meta, including 100 wins and coordinated vehicle, bomb and objective criteria.", {3857,3957})

-- Clone shared detail groups so every retained ID keeps its own rating and
-- route. Consumers resolving raw catalogue details see the same metadata as
-- the walkthrough lookup; unrelated expansion data is left untouched.
local fields = { "acquisition", "source", "sourceType", "tips", "requirements", "cost", "waypoints", "areaMaps", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^3%.") then
        local detailsByID = TDP.PatchCatalog.achievementDetails[patchKey]
        for _, id in ipairs(patch.achievements.ids or {}) do
            local guide = guides[id]
            if guide then
                local details = {}
                for key, value in pairs(detailsByID[id] or {}) do details[key] = value end
                for _, field in ipairs(fields) do
                    if guide[field] ~= nil then details[field] = guide[field] end
                end
                detailsByID[id] = details
            end
        end
    end
end
