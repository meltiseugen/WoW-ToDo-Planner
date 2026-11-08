-- Named Retail discovery circuits, manually ordered from the exploration
-- comment routes and corrections. Coordinates use current zone UiMapIDs.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label}
end
local function explore(id,name,mapID,route,note,comments)
    local steps={"Track "..name.." and travel to the named locations below. Flying makes the circuit easier. Move into each discovery area until its criterion ticks; a revealed map image or nearby place label alone does not prove credit."}
    local points,sources={},{}
    for _,r in ipairs(route) do
        local step=#steps+1
        steps[step]="Visit "..r[1].." ("..r[2]..", "..r[3].."). "..(r[4] or "Check that this named criterion credits before continuing.")
        points[#points+1]=pin(mapID,r[2],r[3],step,r[1])
    end
    steps[#steps+1]="Review every criterion in the achievement. Revisit an unticked location and move around its immediate area if the first approach did not trigger discovery. "..note
    local lines={}
    for i,s in ipairs(steps) do lines[i]=i..". "..s end
    for _,c in ipairs(comments) do sources[#sources+1]="https://www.wowhead.com/achievement="..id.."#comments:id="..c end
    guides[id]={achievementId=id,name=name,sourceType="Achievement",source=name,category="Exploration",
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=points,tips=note,sources=sources,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
explore(1263,"Explore Howling Fjord",117,{
    {"Kamagua",25,57},{"Scalawag Point",34,78,"This is the southern pirate island below the Ancient Lift, not the lift platform."},
    {"Westguard Keep",30,43},{"Ember Clutch",39,50},{"New Agamand",52,67},{"Halgrind",50,53},
    {"Utgarde Keep",58,46},{"Nifflevar",68,54},{"Baelgun's Excavation Site",72,71},
    {"Ivald's Ruin",78,46},{"Baleheim",66,39,"Check north of Nifflevar by the small bridge. Revealing Utgarde Keep can make this look explored before it credits."},
    {"Cauldros Isle",57,36,"Visit the small island immediately north of Utgarde Keep. Its fog is easy to overlook; it is not an offshore island."},
    {"Skorn",45,35},{"Steel Gate",30,26},{"Apothecary Camp",27,24},{"Gjalerbron",36,10},
    {"Camp Winterhoof",48,10},{"The Twisted Glade",53.77,16.53,"Use this northern glade, rather than relying only on the similarly named Vibrant Glade at 51, 27."},
    {"Fort Wildervar",60,15},{"Giant's Run",68,27},{"Vengeance Landing",78,30},
},"Cauldros Isle and Baleheim are common missing ticks. Explorers' League Outpost can reveal extra fog, but it is not an extra required criterion.",{441139,478364,1112864,5204807})
explore(1264,"Explore Borean Tundra",114,{
    {"Valiance Keep",58.78,68.55},{"Riplash Strand",46.05,78.79},{"Warsong Hold",41.42,53.62},
    {"Garrosh's Landing",31.92,52.74,"Approach the actual landing area even if its label already appears on the map."},
    {"Coldarra",32.66,28.26,"Fly to the western dragon island; a ground traveller can use Amber Ledge's flight connection."},
    {"Amber Ledge",45.26,34.25},{"Steeljaw's Caravan",49.15,25.16,"This small discovery is north of Amber Ledge and easy to miss."},
    {"Bor'gorok Outpost",49.7,10.1},{"The Geyser Fields",67.08,32.19},
    {"The Dens of the Dying",75.58,17.05,"Search the northern Talramas/necropolis region if the tick does not trigger on the first pass."},
    {"Temple City of En'kilah",85.42,25.24},{"Death's Stand",82.37,46.69,"The discovery toast can use a neighboring subzone name; check the achievement tick."},
    {"Kaskala",65.8,46.87},
},"Do not confuse additional exploration-experience areas with this thirteen-location checklist.",{442792,478305,1907900,5204752})
explore(1265,"Explore Dragonblight",115,{
    {"Westwind Refugee Camp",14.1,47.4},{"Icemist Village",25.1,43.2},{"Agmar's Hammer",36.7,46.8},
    {"Lake Indu'le",40,67.4},{"Ruby Dragonshrine",47.5,48.7},{"Obsidian Dragonshrine",40.7,31.9},
    {"Angrathar the Wrathgate",37.7,17.4},{"Coldwind Heights",55,20,"This is the high northern area, west of the Crystal Vice."},
    {"The Crystal Vice",60.5,20.2},{"Galakrond's Rest",55.6,34.1},{"Wyrmrest Temple",59.8,54.2},
    {"Emerald Dragonshrine",63.6,73.6},{"New Hearthglen",71,74.2},{"The Forgotten Shore",82.4,68.4},
    {"Venomspite",78,63},{"Naxxramas",87.3,47.8,"Explore the outdoor necropolis region; clearing the raid is not required."},
    {"Light's Trust",84,26.1},{"Scarlet Point",72.5,26},
},"This is outdoor exploration. Opposing-faction settlements can be discovered from above without speaking to their NPCs.",{478341,628053,5204817})
explore(1266,"Explore Grizzly Hills",116,{
    {"Granite Springs",16.2,47.7},{"Conquest Hold",21.4,65.4},{"Venture Bay",14.6,86.1},
    {"Voldrune",28.9,74.9},{"Amberpine Lodge",31.7,59.4},
    {"Rage Fang Shrine",50.3,57.8,"Approach the cave south of Grizzlemaw using the path from about 53, 56. Its name may not be printed on the map."},
    {"Dun Argol",77.8,59.4},{"Camp Oneqwah",65.1,47.2},{"Drakil'jin Ruins",71.6,26},
    {"Thor Modan",66.5,17},{"Westfall Brigade Encampment",57.2,30},{"Grizzlemaw",49.2,43.9},
    {"Blue Sky Logging Grounds",37.3,36.5},{"Drak'Tharon Keep",17.6,28.4,"Explore outside the keep; entering the dungeon is unnecessary for this tick."},
},"Rage Fang Shrine is the frequent missing cave-side discovery. The zone can also be explored on foot using its roads and shrine approach.",{443582,478350,1965759,5204792})
explore(1267,"Explore Zul'Drak",121,{
    {"Light's Breach",32,75.6},{"Zeramas",21.5,76.5},{"Thrym's End",17.2,58.6},{"Voltarus",28.3,46.6},
    {"Altar of Sseratus",40.6,38.6},{"Amphitheater of Anguish",49.4,56.1},{"Drak'Sotra Fields",51.8,75.3},
    {"Kolramas",62,77.6},{"Altar of Har'koa",63.9,71},{"Zim'Torga",59.7,57.6},
    {"Altar of Quetz'lun",77,59.2},{"Altar of Mam'toth",76.1,43.3},{"Gundrak",82.1,20.7},
    {"Altar of Rhunok",53.6,36.8},
},"The Drakuru gargoyle quest tour can discover many areas, but check Sseratus, Zim'Torga and Kolramas separately afterward.",{478276,599374,601472,5204787})
explore(1268,"Explore Sholazar Basin",119,{
    {"River's Heart",48,63},{"The Mosslight Pillar",36,75},{"Kartak's Hold",25,81},
    {"The Suntouched Pillar",33,52},{"Makers' Perch",29,38},
    {"The Stormwright's Shelf",26,35,"Fly above and behind Makers' Perch to the western cliff-top shelf; it is not on the basin floor."},
    {"The Savage Thicket",46,25},{"The Glimmering Pillar",49,38},{"Rainspeaker Canopy",53,55},
    {"The Lifeblood Pillar",65,59},{"Makers' Overlook",80.7,54.42,"Fly to the eastern cliff ledge. The old 81, 12 coordinate is incorrect."},
    {"The Avalanche",73,36},
},"Use flying for the high western shelf and eastern overlook. Old death/resurrection routes and obsolete loan-mount requirements are unnecessary for a flying Retail character.",{795619,1449508,5204758})
explore(1269,"Explore Storm Peaks",120,{
    {"Sparksocket Minefield",36,81},{"Garm's Bane",43,82},{"Brunnhildar Village",48,69},
    {"Dun Niffelem",62,60},{"Temple of Life",66,50},{"Thunderfall",70,49},{"Terrace of the Makers",58,44},
    {"Ulduar",40,24,"Explore the outdoor Titan complex. You do not need to enter its dungeons or raid."},
    {"Narvir's Cradle",29,44},{"Snowdrift Plains",27,45},{"Nidavelir",25,51},{"Valkyrion",25,57},
    {"Temple of Storms",34,56,"Use flying to approach Thorim's high temple and move around its immediate discovery area."},
    {"Engine of the Makers",41,56},{"Bor's Breath",24,70},{"Frosthold",28,72},
},"The old ghost-mount/remote-spirit-healer tricks are unreliable and omitted. Flying provides direct access to the high temples and faction settlements.",{530353,591007,5204770})
explore(1270,"Explore Icecrown",118,{
    {"Valley of Echoes",83,73},{"Scourgeholme",78,59},{"The Broken Front",68,65},{"Icecrown Citadel",53,89},
    {"Corp'rethar: The Horror Gate",41,68},{"The Conflagration",44,64},{"The Fleshwerks",30,63},
    {"Onslaught Harbor",11,50,"Fly to the far western coastal harbor; it is easy to overlook on an inland route."},
    {"Jotunheim",35,36},{"Valhalas",33,29},{"The Shadow Vault",45,16},{"Sindragosa's Fall",73,29},
    {"The Bombardment",62,40},{"Aldur'thar: The Desolation Gate",52,47},{"Ymirheim",51,59},
},"Move within the named subzone if its broad discovery trigger is not reached at the first pin. Argent Tournament Grounds reveals additional fog but is not an extra criterion for this achievement.",{641657,752401,5204766})
explore(1457,"Explore Crystalsong Forest",127,{
    {"Violet Stand",15.7,42.4},{"The Azure Front",23.5,57.6},{"Forlorn Woods",47.1,44.6},
    {"The Unbound Thicket",60.8,61.8},{"Windrunner's Overlook",74.7,80.4,"This is an Alliance outpost; an opposing-faction flyer can discover it from above."},
    {"Sunreaver's Command",76.9,48.3,"This is the Horde outpost north of Windrunner's Overlook. Move toward its flags if the tick is still missing."},
    {"The Decrepit Flow",18.2,15.6},{"The Great Tree",15.38,29.95,"Use the corrected tree approach north of Violet Stand."},
},"Explore the FOREST below Dalaran, not the floating city's streets. Check the achievement rather than relying only on fog on the zone map.",{478317,1396860,5204781})

guides[45]={achievementId=45,name="Northrend Explorer",category="Exploration",sourceType="Achievement",source="Nine Northrend exploration achievements",
    acquisition="1. Track the nine zone achievements: Explore Borean Tundra, Howling Fjord, Dragonblight, Grizzly Hills, Zul'Drak, Sholazar Basin, Storm Peaks, Icecrown and Crystalsong Forest.\n\n2. Follow each zone's numbered discovery circuit and check its actual achievement criteria. Fog disappearing near another location does not necessarily credit the missing area.\n\n3. Use flying for Sholazar's Stormwright's Shelf/Makers' Overlook and Storm Peaks' high temples. Crystalsong means the forest BELOW Dalaran; neither Wintergrasp nor Dalaran is a tenth zone criterion.\n\n4. Finish all nine component achievements and check Northrend Explorer. If one remains incomplete, inspect its checklist for the named missing subzone rather than repeatedly flying across the whole continent.",
    stepCount=4,waypoints={pin(114,58.78,68.55,2,"Borean Tundra circuit"),pin(117,25,57,2,"Howling Fjord circuit"),pin(115,59.8,54.2,2,"Dragonblight circuit"),pin(116,16.2,47.7,2,"Grizzly Hills circuit"),pin(121,32,75.6,2,"Zul'Drak circuit"),pin(119,48,63,3,"Sholazar Basin circuit"),pin(120,36,81,3,"Storm Peaks circuit"),pin(118,83,73,2,"Icecrown circuit"),pin(127,15.7,42.4,3,"Crystalsong FOREST circuit")},
    wowheadUrl="https://www.wowhead.com/achievement=45",sourceURL="https://www.wowhead.com/achievement=45#comments",
    sources={"https://www.wowhead.com/achievement=45#comments","https://www.wowhead.com/achievement=1268#comments:id=5204758","https://www.wowhead.com/achievement=1269#comments:id=5204770"}}

-- Each point is a representative spawn/patrol search location, not a promise
-- that the rare stands there. Separate regions for the same rare are retained.
local rares={
    {114,"Old Crystalbark","circle Coldarra and the Nexus base",{{20.6,27.6},{22.2,33.8},{34.4,31.6},{34,24.2}}},
    {114,"Fumblub Gearwind","look UP for the flying gnome helicopter over the Geyser Fields",{{60.6,15},{61.6,28},{66.2,36.6},{72.4,39.2},{72.6,29.4},{67,19.4}}},
    {114,"Icehorn","search the snowy eastern Death's Stand/En'kilah region for an icy rhino",{{80.6,46.2},{88.6,39.8},{91.6,32.6},{81.4,31.4}}},
    {115,"Crazed Indu'le Survivor","search the western fields around Stars' Rest for the wandering Tuskarr",{{15.6,45.6},{15.6,58.2},{24,53.8},{28.8,61.6},{33.2,56.8}}},
    {115,"Scarlet Highlord Daion","check ALL three separate Scarlet regions: Scarlet Point, the camp north of Naxxramas and New Hearthglen",{{71.6,22.4},{75.6,27.2},{88.2,36.6},{86.8,41.6},{72,70.8},{69.2,75.6}}},
    {115,"Tukemuth","sweep the central Dragon Wastes for a large pale mammoth",{{60.2,34.6},{68.6,27.6},{68,46},{67.8,59.2},{58.8,59.6},{53.6,59.2}}},
    {116,"Grocklar","check the western giant's patrols west of Granite Springs and south of Conquest Hold",{{10,38.4},{13.2,46.6},{12,55.6},{25.8,56.4},{11.2,71},{22.8,73.4}}},
    {116,"Seething Hate","inspect the THREE fallen/slime-filled tree trunks rather than just flying over the forest",{{28,45.6},{34,49.2},{40.2,48.8}}},
    {116,"Syreian the Bonecarver","search the eastern/northeastern giant fields southeast of Westfall Brigade for the Vrykul ranger",{{61.6,36.2},{68.8,26.8},{71.4,33.4},{75.2,41.4},{67,42.6}}},
    {117,"King Ping","follow the southwest coast and islands around Kamagua/Scalawag for the large penguin",{{31.2,56.8},{26,64},{30.8,71.2},{33.2,80.2}}},
    {117,"Perobas the Bloodthirster","check the northern lakes and Fort Wildervar region for the worgen",{{50.6,4.8},{53.2,11.4},{60.8,20.2},{68.6,16.8},{71.6,13.6}}},
    {117,"Vigdis the War Maiden","search east of Nifflevar for the Vrykul on a ground-patrolling proto-drake; do not search the high-altitude flight paths",{{68.2,46},{75.6,45},{72.8,49},{69.6,58},{74.6,59.6}}},
    {121,"Griegen","sweep the southwest around Zeramas, Thrym's End and the nearby fields",{{14.6,56.8},{26.6,55.8},{23,61},{17,70.4},{26.6,71.2},{21.2,79.8}}},
    {121,"Zul'drak Sentinel","follow the southwest road and the north/south road around the Argent Stand for the glowing stone giant",{{21.6,82.8},{29,82.2},{28.8,72.2},{42.6,70.6},{40.6,62.2},{40.4,53}}},
    {121,"Terror Spinner","check the northern/eastern temple terraces for the bone spider",{{53.6,32},{61.8,36.4},{71.8,23.8},{81.6,34.6},{77.4,43.6},{75,66.8}}},
    {120,"Dirkee","check the separate Engine of the Makers, Grom'arsh and eastern Thunderfall regions for the mechanical gnome",{{37.8,58.6},{41,51.6},{41.6,40.6},{68.2,47.6}}},
    {120,"Vyragosa","search the SKY along the southwest/central flight paths. This blue dragon shares the Time-Lost Proto-Drake spawn system, but Time-Lost itself is not a Frostbitten criterion",{{26.6,59},{29.2,66.6},{36.2,65.2},{37,73.4},{39.8,58}}},
    {118,"Hildana Deathstealer","check both Jotunheim/Valhalas and the separate Ymirheim area for the flying Val'kyr",{{28.6,45.8},{30.6,34.4},{34,27.6},{37.4,23.6},{54.6,52.4},{58.2,63}}},
    {118,"High Thane Jorfus","check THREE disconnected regions: Fleshwerks, Court of Bones and Sindragosa's Fall",{{31.2,62.2},{35.6,70},{49.2,79},{48.4,86.8},{67.6,38.6},{74.2,33}}},
    {118,"Putridus the Ancient","follow the huge flesh giant's long central patrol between the gates; look beyond the immediate pin if targeting finds him",{{46.6,65},{44.8,53.8},{52.4,38.6},{65.4,48.6},{69,67.6}}},
    {119,"Aotona","search the central/southern jungle around Rainspeaker and Wildgrowth Mangal for the blue parrot",{{54.4,52.8},{43,52.2},{41,58.6},{41.2,68.4},{42,73.8},{52.6,72.6},{57.8,65.6}}},
    {119,"King Krush","check the northwest, central pillar area and southern basin for the green devilsaur",{{26.8,47.8},{37.8,28.8},{47,44},{52.6,41.8},{50.2,80.4},{63.8,82.8},{66.2,78.2}}},
    {119,"Loque'nahak","visit the spirit beast's widely separated spawn areas around the entire basin, not just one camp",{{21.6,70.6},{31,66.6},{36.8,30},{59.4,22.6},{51,81.6},{67,79.6},{71,71.6}}},
}
do
    local steps={"Track Frostbitten and mark the rares already credited. You need ALL 23 named creatures across eight zones. Visit only missing ones; the map dropdown groups the search points by zone and their pin numbers match these steps."}
    local points={}
    for _,r in ipairs(rares) do
        local step=#steps+1
        steps[step]="Find and kill "..r[2]..": "..r[3]..". The map shows multiple search points for this step; patrol between them and check nearby terrain/altitude. Confirm kill credit in the checklist."
        for _,xy in ipairs(r[4]) do points[#points+1]=pin(r[1],xy[1],xy[2],step,r[2].." - spawn/patrol search") end
    end
    steps[#steps+1]="If a rare is absent, return later or check another eligible phase with a friend who is physically there. There is no guaranteed server-restart spawn or universal respawn timer. Old claims that only one or two rares can exist in a zone at once are contradicted by later reports."
    steps[#steps+1]="For Aotona, King Krush and Loque'nahak, do not rely on taming alone for achievement credit: Retail reports conflict, including a failed tame in September 2026. Check your criterion immediately and use a qualifying kill if still missing. A summoned hunter pet is not the wild rare."
    local lines={}
    for i,s in ipairs(steps) do lines[i]=i..". "..s end
    guides[2257]={achievementId=2257,name="Frostbitten",category="Exploration",sourceType="Achievement",source="23 Northrend rare creatures",
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=points,
        tips="Search pins describe possible spawn regions and patrols, not fixed spawns or a continuous exact path. Kill and check credit while nearby; a party member elsewhere in the zone does not automatically receive it. Vyragosa counts; Time-Lost Proto-Drake, Skoll, Arcturis and Gondria are not substitutes.",
        wowheadUrl="https://www.wowhead.com/achievement=2257",sourceURL="https://www.wowhead.com/achievement=2257#comments",
        sources={"https://www.wowhead.com/achievement=2257#comments:id=594565","https://www.wowhead.com/achievement=2257#comments:id=2020138","https://www.wowhead.com/achievement=2257#comments:id=5810131","https://www.wowhead.com/achievement=2257#comments:id=3237017","https://www.wowhead.com/achievement=2257#comments:id=6412676"}}
end
guides[2256]={achievementId=2256,name="Northern Exposure",category="Exploration",sourceType="Achievement",source="One listed Northrend rare creature",
    acquisition="1. Track Northern Exposure. You need ONE of the 23 rares on its checklist; an unrelated silver-dragon mob or Time-Lost Proto-Drake does not substitute.\n\n2. For a compact first search, circle Coldarra in Borean Tundra for Old Crystalbark, then check the eastern snowy Death's Stand region for Icehorn. The map pins are search areas, not guaranteed spawns.\n\n3. If both are absent, try Seething Hate at the three fallen, slime-filled tree trunks in western Grizzly Hills, or use Frostbitten's full eight-zone route for another listed rare. Return later when a region is empty.\n\n4. Tag and kill a listed rare while nearby, loot if desired and check the achievement. You do not need to collect every rare's blue item or finish all 23; that is Frostbitten.",
    stepCount=4,waypoints={pin(114,22.2,33.8,2,"Old Crystalbark - Coldarra search"),pin(114,34.4,31.6,2,"Old Crystalbark - alternate Coldarra search"),pin(114,84.6,46.8,2,"Icehorn - eastern snow search"),pin(114,91.6,32.6,2,"Icehorn - alternate eastern snow search"),pin(116,28,45.6,3,"Seething Hate - western fallen trunk"),pin(116,34,49.2,3,"Seething Hate - central fallen trunk"),pin(116,40.2,48.8,3,"Seething Hate - eastern fallen trunk")},
    wowheadUrl="https://www.wowhead.com/achievement=2256",sourceURL="https://www.wowhead.com/achievement=2256#comments",
    sources={"https://www.wowhead.com/achievement=2256#comments:id=457819","https://www.wowhead.com/achievement=2256#comments:id=477090","https://www.wowhead.com/achievement=2257#comments:id=2020138"}}
