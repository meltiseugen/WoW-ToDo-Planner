-- Retail professions, manually reconciled with comments and replies, 2026-11-05.
local _,TDP=...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label,mapName)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label,mapName=mapName}
end
local function add(id,name,difficulty,reason,steps,points,comments,areas,tips)
    local lines={"Difficulty: "..difficulty:gsub("^%l",string.upper).." - "..reason}
    local sources={}
    for i,s in ipairs(steps) do lines[#lines+1]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="Professions",sourceType="Achievement",source=name,
        difficulty=difficulty,difficultyReason=reason,acquisition=table.concat(lines,"\n\n"),stepCount=#steps,
        waypoints=points or {},areaMaps=areas,sources=sources,tips=tips,reviewedAt="2026-11-05",
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local archStart="Learn Archaeology from Harrison Jones in Stormwind's library (85.6, 25.8) or Belloc Brightblade in Orgrimmar (49.0, 70.6). Enable Archaeology dig sites on the world map. Dig sites are personal and move as YOU finish them; another player's route does not determine your active sites."
local survey="At an active dig site, stand inside its highlighted boundary and use Survey. Follow the instrument's direction: red means far away, yellow closer, green nearby. Survey again until the fragment object appears, then LOOT it. Continue until the site disappears and a replacement spawns. Clearing unwanted races also frees slots for the race you need."
local solve="Open Archaeology, select the race whose fragments you collected, and complete its CURRENT research project when you have enough fragments. Insert matching keystones where the project has sockets to reduce its cost. The next project is random: you cannot select an unsolved artifact directly."
local archPins={pin(84,85.6,25.8,1,"Harrison Jones - Archaeology trainer"),pin(85,49,70.6,1,"Belloc Brightblade - Archaeology trainer")}
for _,r in ipairs({
    {4857,"Journeyman Archaeologist",150,"easy",1756811},
    {4919,"Expert Archaeologist",225,"medium",1756818},
    {4920,"Artisan Archaeologist",300,"medium",1756839},
    {4921,"Master Archaeologist",375,"medium",1756862},
    {4922,"Grand Master Archaeologist",450,"medium",1756916},
    {4923,"Illustrious Grand Master Archaeologist",525,"medium",1196513},
}) do
    add(r[1],r[2],r[4],"Surveying and completed projects raise the persistent Archaeology skill.",{
        archStart,survey,solve,
        "Continue completing research projects until your BASE Archaeology skill reaches "..r[3]..". Surveying stops giving early skill gains, so do not keep digging while leaving every project unsolved. Old advice to save all solves for the original 525 cap is optional, not an achievement requirement.",
        "You can remain in Eastern Kingdoms or Kalimdor for this target. At 300 skill Outland becomes available, at 375 Northrend, and at 450 Tol'vir sites in original Uldum. Check the skill and achievement after a solve; racial bonuses are not earned skill points.",
    },archPins,{r[5]},{13,12})
end
for _,r in ipairs({{4854,"I Had It in My Hand",1,"medium"},{4855,"What was Briefly Yours is Now Mine",10,"hard"},{4856,"It Belongs in a Museum!",20,"hard"}}) do
    add(r[1],r[2],r[4],"Rare projects are randomly offered after other projects; multiple cultures reduce reliance on one rare drop.",{
        archStart,survey,solve,
        "When a BLUE-quality rare project appears, collect its required fragments and FINISH that solve. Merely revealing the project is insufficient. Complete "..r[3].." DIFFERENT rare projects; extra copies or appearance collection from another source do not replace the Archaeology solve.",
        "Work across cultures rather than waiting only for one very rare Tol'vir weapon. Fossil and Night Elf sites in Kalimdor, Dwarf/Troll in Eastern Kingdoms, Orc/Draenei in Outland and Vrykul/Nerubian in Northrend all provide eligible rares. Later-expansion Archaeology rares can contribute too.",
        "Optional at Archaeology 600: solve common Pandaria artifacts, crate the completed objects into Restored Artifacts, then exchange them with Brann at the Seat of Knowledge (83.5, 31.0 above Mogu'shan Palace) for the old race's fragments. Crates supply fragments, not a guaranteed rare project. Original Eastern Kingdoms/Kalimdor gray artifacts cannot be crated this way.",
        "Check the live rare-project counter after each completed rare. Return to races with missing projects until it reaches "..r[3].."; there is no fixed number of digs or guaranteed completion time.",
    },{archPins[1],archPins[2],pin(390,83.5,31,6,"Brann - optional restored-artifact fragment exchange")},
    {"https://www.wowhead.com/achievement=4854#comments:id=5813873","https://www.wowhead.com/achievement=4856#comments:id=1339634"},{13,12,101,113})
end
for _,r in ipairs({{5315,"Digger",10,"easy"},{5469,"Diggerer",50,"medium"},{5470,"Diggerest",100,"hard"}}) do
    add(r[1],r[2],r[4],"Complete many common projects across cultures; duplicates are unreliable for the unique-project target.",{
        archStart,survey,solve,
        "Finish "..r[3].." DIFFERENT COMMON projects and inspect the completed-artifact journal and achievement counter. Rare blue projects advance the rare achievements instead. The written requirement is unique projects; do not plan the route around a temporary report that duplicate commons counted after a bug fix.",
        "When one culture repeatedly offers artifacts already in your journal, move to cultures with missing commons. Eastern Kingdoms supplies Dwarf and Troll; Kalimdor supplies Night Elf and Fossil; Outland supplies Orc and Draenei; Northrend supplies Nerubian and Vrykul. Tol'vir and later-expansion cultures add more choices.",
        "Continue until the live counter reaches "..r[3]..". The older progress-reset issue was reported fixed around Midnight prepatch; current collection comments confirm renewed progress. If your own journal fails to retain a solve, check it before committing to another long session.",
    },archPins,{"https://www.wowhead.com/achievement=5315#comments:id=1299649","https://www.wowhead.com/achievement=5470#comments:id=1222281","https://www.wowhead.com/achievement=5470#comments:id=6346617"},{13,12,101,113})
end
local sets={
    {4859,"Kings Under the Mountain","Dwarf","Eastern Kingdoms",13,
        "Mithril Chain of Angerforge; Winged Helm of Corehammer; Skull Staff of Shadowforge; Warmaul of Burningeye; Moltenfist's Jeweled Goblet; Ironstar's Petrified Shield; Spiked Gauntlets of Anvilrage",{1124268,6234900,6266697,6278840,6413482}},
    {5191,"Tragedy in Three Acts","Night Elf","Kalimdor",12,
        "Delicate Music Box; Hairpin of Silver and Malachite; Cracked Crystal Vial; Cloak Clasp with Antlers; Chest of Tiny Glass Animals; Silver Scroll Case",{1138014}},
    {5192,"The Harder they Fall","Orc","Outland",101,
        "Tiny Bronze Scorpion; Gray Candle Stub; Maul of Stone Guard Mur'og; Rusted Steak Knife",{1124261}},
    {5193,"Blue Streak","Dwarf","Eastern Kingdoms",13,
        "Notched Sword of Tunadil the Redeemer; Scorched Staff of Shadow Priest Anund; Dented Shield of Horuz Killcrow; Silver Kris of Korl",{1124259}},
    {5301,"The Boy Who Would be King","Tol'vir","original Uldum in Kalimdor",249,
        "Cat Statue with Emerald Eyes; Tiny Oasis Mosaic; Sketch of a Desert Palace; Soapstone Scarab Necklace; Engraved Scimitar Hilt; Canopic Jar",{1124294}},
}
for _,r in ipairs(sets) do
    local points={archPins[1],archPins[2]}
    if r[1]==5301 then points[#points+1]=pin(249,56,35.1,2,"Zidormi - original Uldum for Tol'vir sites") end
    points[#points+1]=pin(390,83.5,31,6,"Brann - optional "..r[3].." fragment crates")
    add(r[1],r[2],"medium","A specific random common-project collection; travel and duplicate solves can prolong it.",{
        archStart,
        "Focus "..r[3].." dig sites in "..r[4]..". "..(r[3]=="Tol'vir" and "Reach Archaeology 450 and use Zidormi for original Uldum if assaults hide the old zone. Clear other Kalimdor sites to roll Uldum replacements." or r[3]=="Orc" and "Reach Archaeology 300 to survey Outland. Draenor is a different continent and its Orc clans do not supply these Orc fragments." or "Clear nearby unwanted sites when they occupy the continent's active slots; waiting beside a completed site does not cause the required project to appear."),
        survey,solve,
        "Finish these "..r[3].." COMMON artifacts, checking off each distinct name: "..r[6]..". These are research solves, not dungeon boss drops despite some familiar names. Repeating one artifact does not substitute for a missing named artifact.",
        "Optional at Archaeology 600: crate completed common Pandaria artifacts and exchange the Restored Artifacts with Brann above Mogu'shan Palace for "..r[3].." fragment crates. Solve the projects offered by those fragments. Original Eastern Kingdoms and Kalimdor gray artifacts cannot be converted into these crates.",
        "Continue until EVERY named criterion is complete. You cannot force the next research project or guarantee a particular solve within a few hours. "..(r[1]==4859 and "Midnight comments confirm the collection still completes; the older journal reset bug was reported fixed." or "Keep reviewing the achievement checklist rather than counting total solves."),
    },points,r[7],{r[5]})
end
guides[4859].sourceReplyIds={1822047,1822804,1816087}
add(4858,"Seven Scepters","hard","Seven named common artifacts spread across five cultures and three continents.",{
    archStart,"Reach at least Archaeology 375 for Northrend access. Track the seven named criteria; collecting a similarly named equipped weapon is not a research solve.",
    "In Eastern Kingdoms, solve DWARF projects for Scepter of Bronzebeard and Scepter of Charlga Razorflank, and TROLL projects for Atal'ai Scepter. Clear unwanted sites to rotate the continent's active locations.",
    "In Kalimdor, solve NIGHT ELF projects for Scepter of Xavius. There is no need to enter an Emerald Nightmare raid or defeat Xavius.",
    "In OUTLAND, solve DRAENEI projects for Scepter of the Nathrezim and ORC projects for Scepter of Nekros Skullcrusher. Use the original Outland map, not Draenor.",
    "In Northrend, solve NERUBIAN projects for Scepter of Nezar'Azret. If your active sites are all other cultures, finish them to roll replacements.",
    "At Archaeology 600, Brann's Restored Artifact exchanges above Mogu'shan Palace can supply the missing race's fragments instead of direct digging. Solve every offered common until all seven named scepters are recorded. The rare Scepter of Azj'Aqir is NOT required.",
},{archPins[1],archPins[2],pin(390,83.5,31,7,"Brann - missing culture's fragment crates")},{1122392,1890496,2552363},{13,12,101,113})
add(5511,"It's Always in the Last Place You Look","medium","Finish one artifact from each of the nine original cultures.",{
    archStart,"Raise Archaeology to 450 so all nine required cultures can appear. Fragments alone are insufficient: complete at least ONE research solve from each required culture.",
    "In Eastern Kingdoms, complete a Dwarf, Troll and Fossil artifact. In Kalimdor, complete a Night Elf artifact and use original Uldum for a Tol'vir artifact; ask Zidormi near 56.0, 35.1 if an assault phase interferes.",
    "In OUTLAND, survey and solve BOTH an Orc and a Draenei project. These use the original continent's archaeology, not Draenor archaeology.",
    "In Northrend, survey and solve BOTH a Vrykul and a Nerubian project. Complete unwanted sites to replace them when the culture you need is absent.",
    "Check all nine criteria after the solves. Pandaren, Mogu, Mantid and later races are not required substitutes. A May 2026 reply confirms the previously broken Draenei criterion was awarding progress again.",
},{archPins[1],archPins[2],pin(249,56,35.1,3,"Zidormi - original Tol'vir archaeology")},{1132661,1926602,3212173,6256961},{13,12,101,113})
guides[5511].sourceReplyIds={1843325}

for _,r in ipairs({{4924,"Professional Cataclysmic Master",1},{4914,"Working In the Heat",2}}) do
    add(r[1],r[2],"medium","Level the Cataclysm branch of "..r[3].." primary profession(s), not a later expansion's branch.",{
        "Choose "..r[3].." PRIMARY profession(s) on the character. Ask a Stormwind or Orgrimmar guard for each trainer, learn that profession and specifically learn its CATACLYSM category. Cooking, Fishing and Archaeology do not count as primary professions.",
        "Open the Cataclysm skill bar. For crafting, learn orange/yellow recipes, obtain the listed Cataclysm materials and make those recipes until they stop giving reliable skill, then learn the next recipes. For gathering, gather appropriate Cataclysm herbs, ore or skins in Hyjal, Deepholm, Uldum or Twilight Highlands.",
        "Reach SEVENTY-FIVE base Cataclysm skill in "..r[3].." primary profession(s). Check earned skill rather than counting a racial or equipment bonus. The old generic 525 requirement became a separate Cataclysm 1-75 bar.",
        "Verify the live achievement before changing a profession. For Working In the Heat, keep both completed primary professions together; a Cooking bar plus one primary profession is insufficient.",
    },{}, {"https://www.wowhead.com/achievement=4914#comments:id=1265488","https://www.wowhead.com/achievement=4924#comments:id=1242523"},{84,85,198,207,249,241})
end
add(4916,"Cataclysmic Cook","medium","Train and level the separate Cataclysm Cooking bar to 75.",{
    "Visit Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6). Learn Cooking and its CATACLYSM category, then select that category in the profession window.",
    "Begin with the trainer's Cataclysm recipes such as Blackened Surprise using Toughened Flesh. Cook orange or yellow recipes beside a fire and learn the next available recipes as the earlier ones turn green or gray.",
    "For the later recipes, complete a capital Cooking daily for Epicurean's Awards and buy Cataclysm recipes from the nearby sous-chef vendor. Obtain the exact Cataclysm fish or meat from the Auction House or the zones named in the recipe. More copies of a gray low-level recipe cannot finish the skill bar reliably.",
    "Reach 75 BASE Cataclysm Cooking and check the achievement. Halfhill's old fast 1-525 instructions predate the expansion skill split; Pandaria Cooking skill does not replace Cataclysm Cooking.",
},{pin(84,76.8,53.6,1,"Stephen Ryback - Cataclysm Cooking"),pin(85,32.2,69.6,1,"Zamja - Cataclysm Cooking")},{1211904})
add(4917,"Cataclysmic Fisherman","easy","Learn Cataclysm Fishing, then fish repeatedly in Hyjal waters.",{
    "Learn Fishing and CATACLYSM Fishing from a trainer offering that expansion branch, such as Old Umbehto in Orgrimmar (35.0, 67.5) or Arnold Leland in Stormwind (55.0, 69.6). Confirm that Cataclysm Fishing appears in the profession window before travelling.",
    "Take the capital's Cataclysm portal to Mount Hyjal. Go to the small lake behind Nordrassil's portal/building and cast into its open water. Wait for the bobber, click it and loot the catch.",
    "Keep fishing until the Cataclysm bar reaches SEVENTY-FIVE. Gains become less frequent; a fishing pole or lure's bonus is not earned base skill. Check the achievement after the final gain. You do not need a rare fish, a pool or an old 525 overall skill bar.",
},{pin(84,55,69.6,1,"Arnold Leland - Fishing training"),pin(85,35,67.5,1,"Old Umbehto - Cataclysm Fishing training")},{3304298,6268983},{198})
guides[4917].sourceReplyIds={1849876}

-- City NPC positions are current Retail g_mapperData. Their shared lockout is
-- one Cooking AND one Fishing daily per character per day, not one per city.
local cityDailies={
    {5474,"Let's Do Lunch: Stormwind","Cooking","Robby Flay",84,50.6,71.6,"A Fisherman's Feast; Orphans Like Cookies Too!; The King's Cider; Feeling Crabby?; Penny's Pumpkin Pancakes",1452939},
    {5475,"Let's Do Lunch: Orgrimmar","Cooking","Marogg",85,56.6,62.6,"Careful, This Fruit Bites Back; Even Thieves Get Hungry; Stealing From Our Own; Crawfish Creole; Everything is Better with Bacon",1180482},
    {5841,"Let's Do Lunch: Ironforge","Cooking","Daryl Riknussun",87,60.1,36.4,"A Round for the Guards; Keepin' the Haggis Flowin'; I Need to Cask a Favor; A Fowl Shortage; Can't Get Enough Spice Bread",1418369},
    {5842,"Let's Do Lunch: Darnassus","Cooking","Alegorn",89,50,36.6,"The Secret to Perfect Kimchi; Back to Basics; Spice Bread Aplenty; Remembering the Ancestors; Ribs for the Sentinels",2864348},
    {5843,"Let's Do Lunch: Thunder Bluff","Cooking","Aska Mistrunner",88,51.2,52.8,"Pining for Nuts; Mulgore Spice Bread; Perfectly Picked Portions; Magic Mushrooms; Corn Mash",1418386},
    {5844,"Let's Do Lunch: Undercity","Cooking","Eunice Burch",90,62.8,44.2,"Fungus Among Us; Escargot A Go-Go; Would You Like Some Flies With That?; Lily, Oh Lily; Roach Coach",1418389},
    {5476,"Fish or Cut Bait: Stormwind","Fishing","Catherine Leland",84,55,69.6,"Hitting a Walleye; Rock Lobster; Thunder Falls; Diggin' for Worms; Big Gulp",1201711},
    {5477,"Fish or Cut Bait: Orgrimmar","Fishing","Razgar",85,65.6,41.6,"Clammy Hands; A Staggering Effort; A Golden Opportunity; No Dumping Allowed; A Furious Catch",1180269},
    {5847,"Fish or Cut Bait: Ironforge","Fishing","Grimnur Stonebrand",87,47.6,7.2,"Cold Water Fishing; Fish fer Squirky; The Gnomish Bait-o-Matic; One fer the Ages; Live Bait",1418366},
    {5848,"Fish or Cut Bait: Darnassus","Fishing","Astaia",89,49,61,"Happy as a Clam Digger; The Sister's Pendant; An Old Favorite; Stocking Up; A Slippery Snack",3288456},
    {5849,"Fish or Cut Bait: Thunder Bluff","Fishing","Kah Mistrunner",88,56,46.8,"Pond Predators; The Race to Restock; Shiny Baubles; The Ring's the Thing; Craving Crayfish",1418355},
    {5850,"Fish or Cut Bait: Undercity","Fishing","Armand Cromwell",90,80.4,31.6,"Fish Head; Like Pike?; Moat Monster!; Tadpole Terror; Time for Slime",3169166},
}
for _,r in ipairs(cityDailies) do
    local phase=r[5]==89 and "If Darnassus is destroyed in your timeline, speak to Zidormi in Darkshore at 48.9, 24.5 and choose the time before the battle, then fly to Darnassus. "
        or r[5]==90 and "If Undercity is blighted or its NPCs are absent, ask Zidormi in Tirisfal Glades at 69.4, 62.8 for the time before the battle, then enter original Undercity. " or ""
    local points={pin(r[5],r[6],r[7],1,r[4].." - "..r[3].." daily giver"),pin(r[5],r[6],r[7],3,r[4].." - turn in for criterion credit")}
    if r[5]==89 then points[#points+1]=pin(62,48.9,24.5,1,"Zidormi - restore accessible Darnassus") end
    if r[5]==90 then points[#points+1]=pin(18,69.4,62.8,1,"Zidormi - original Undercity") end
    add(r[1],r[2],"medium","Five easy quests on a rotating daily schedule; the last variant can take many resets.",{
        phase.."Learn basic "..r[3].." and visit "..r[4].." at the marked city location. Enable Trivial Quests. Check that you have not already accepted or completed a capital "..r[3].." daily elsewhere today.",
        "Track this achievement and compare today's offered quest with the five required variants: "..r[8]..". Check other cities before accepting if you want to spend today's shared daily slot on a missing criterion elsewhere.",
        "Accept the missing variant, follow its quest items and marked local objectives, then RETURN to "..r[4].." and turn it in. Collecting its materials without the hand-in does not complete the criterion. Keep the supplied bait, lure or container until that quest is finished.",
        "Return after daily resets until all five DIFFERENT variants are checked. Repeating one daily five times does not complete the achievement. You can do only one capital Cooking daily and one capital Fishing daily per character per day, across all three same-faction cities; Shattrath and Northrend Dalaran have separate dailies.",
        "If no quest is visible, check your quest log for another city's accepted daily, today's completion and the correct city phase before assuming the achievement is removed. Random repeats are expected and skipping a quest does not force the missing one tomorrow.",
    },points,{r[9],"https://www.wowhead.com/achievement=5847#comments:id=2864514"})
end
guides[5848].sourceReplyIds={1525406}
guides[5850].sourceReplyIds={1352835,1375464,1691673}
for _,r in ipairs({{5845,"A Bunch of Lunch","Cooking"},{5851,"Gone Fishin'","Fishing"}}) do
    add(r[1],r[2],"medium","Complete the three city daily checklists for your faction across repeated resets.",{
        "Track "..r[2].." and its CURRENT city checklist. Alliance uses Stormwind, Ironforge and Darnassus; Horde uses Orgrimmar, Thunder Bluff and Undercity. Learn basic "..r[3].." and enable Trivial Quests.",
        "Each day, inspect the three city givers before accepting a "..r[3].." daily. Choose a quest whose name is still missing for its city's five-quest achievement. Accepting one hides the other cities' offers, and completing one spends the shared capital daily slot for this profession.",
        "Complete that quest's local objectives and turn it in to its giver. Repeat after resets, moving between cities as their missing variants appear. Finish all five variants for each of the three cities; fifteen completions of one city's repeat cannot replace the other cities.",
        "Use Zidormi in Darkshore for accessible old Darnassus or Zidormi in Tirisfal for old Undercity when necessary. A destroyed present-day city is not a reason to abandon these still-usable timelines.",
        "When all three city sub-achievements are complete, check this meta. Account progress can display other characters' criteria, but each character still has its own daily lockout. The Cooking and Fishing slots are separate, so work on both professions together if useful.",
    },{pin(62,48.9,24.5,4,"Zidormi - old Darnassus"),pin(18,69.4,62.8,4,"Zidormi - old Undercity")},
        {"https://www.wowhead.com/achievement=5845#comments:id=1967722","https://www.wowhead.com/achievement=5851#comments:id=1418378"},{84,87,89,85,88,90})
    for _,c in ipairs(cityDailies) do
        if c[3]==r[3] then guides[r[1]].waypoints[#guides[r[1]].waypoints+1]=pin(c[5],c[6],c[7],2,c[4].." - inspect today's missing variant") end
    end
end

add(5471,"Iron Chef","medium","Learn two hundred Cooking recipes across available expansion categories.",{
    "Train Cooking and inspect its learned recipe count. This is a LEARNED-recipes achievement, so buying finished food and cooking two hundred copies of one recipe do not advance the target.",
    "Learn the inexpensive unlearned trainer recipes in each expansion's Cooking category. Begin with Classic trainers in the capitals and the Outland/Northrend trainers, then add Pandaria and later expansion trainers. Use the profession window's Unlearned filter to choose recipes you can actually learn.",
    "Buy missing ordinary recipes from cooking-supply vendors and the Auction House. Alliance can visit Kendor Kabonka upstairs in the Pig and Whistle (76.0, 53.2 in Stormwind) for many Classic vendor recipes; Horde can obtain tradable opposite-faction recipes through the Auction House. Learn the recipe item after buying it.",
    "Add Cataclysm and Northrend recipes sold for Epicurean's Awards, earned from their separate daily hubs. Seasonal Cooking vendors and reputation recipes can fill gaps, but retired Dirge's Chimaerok Chops and Rogue-only Thistle Tea are not necessary in modern Retail.",
    "Keep learning DIFFERENT available recipes until the live counter reaches TWO HUNDRED. Old comments claiming a new character is capped below 200 describe Cataclysm's original recipe pool; later expansions supply many alternatives.",
},{pin(84,76,53.2,3,"Kendor Kabonka - many Classic cooking recipes"),pin(85,32.2,69.6,2,"Zamja - Cooking trainer"),pin(84,76.8,53.6,2,"Stephen Ryback - Cooking trainer")},
{1351984,1401204,1660687,1882680,2323342},{111,125,376})
for _,r in ipairs({{5472,15},{5473,30}}) do
    add(r[1],"The Cataclysmic Gourmet ("..r[2].." recipes)","medium","Learn and personally cook many different Cataclysm recipes; awards take repeated daily visits.",{
        "Learn Cataclysm Cooking and track the achievement's recipe checklist. You must personally COOK "..r[2].." DIFFERENT listed recipes. Learning recipes alone, eating the food or buying another player's finished dishes does not replace crafting them.",
        "Earn Epicurean's Awards from capital Cooking dailies and the separate Northrend Dalaran Cooking daily. Spend them at the capital sous-chef vendors, such as Jon Casper near Robby Flay in Stormwind or Shazdar near Marogg in Orgrimmar. The vendors sell the Cataclysm recipes; Blackened Surprise and Darkbrew Lager are trainer recipes.",
        "Start with simple listed dishes: Blackened Surprise uses Toughened Flesh; Broiled Mountain Trout uses Mountain Trout; Lightly Fried Lurker and Lurker Lunch use Striped Lurker; Lavascale Fillet and Lavascale Minestrone use Lavascale Catfish. Cook each DIFFERENT recipe once and check its criterion.",
        "Fish or buy Cataclysm ingredients. Hyjal supplies Mountain Trout and Striped Lurker; original Uldum's river supplies Blackbelly Mudfish, Lavascale Catfish and Sharptooth; Twilight Highlands supplies Highland Guppy inland and Algaefin Rockfish/Deepsea Sagefish on its coast; Tol Barad's coast supplies Fathom Eel. Buying raw materials is valid.",
        "For meat dishes, gather or buy Crocolisk Tail in Uldum, Dragon Flank in Twilight Highlands/Deepholm, Delicate Wing from Uldum birds, Basilisk Liver from Deepholm basilisks, and Snake Eye/Monstrous Claw/Blood Shrimp from Vashj'ir creatures and their clams. Use the recipe's current material quantities; an old shopping list counted recipe uses rather than all actual material amounts.",
        "Add the vendor-ingredient recipes: Chocolate Cookie needs Simple Flour and Cocoa Beans; Starfire Espresso uses Cocoa Beans and Refreshing Spring Water; Highland Spirits uses Highland Pomegranate and water; South Island Iced Tea uses Tropical Sunfruit and water; Darkbrew Lager uses Dwarven Stout and Badlands Bourbon. Fortune Cookie also needs a Mysterious Fortune Card from Inscription or the Auction House.",
        "Cook missing recipes until the counter reaches "..r[2]..". The checklist offers THIRTY-TWO choices, so the thirty-recipe tier can skip BOTH guild-unlocked feasts. Feathered Lure is available again; the old removal warning is obsolete. Eat your completed food and drinks afterward if also pursuing Cataclysmically Delicious and Drown Your Sorrows.",
    },{pin(84,50.6,71.6,2,"Robby Flay / Jon Casper - awards and recipes"),pin(85,56.6,62.6,2,"Marogg / Shazdar - awards and recipes"),pin(249,62,79,5,"Uldum serpents - Toughened Flesh"),pin(249,66.4,60.4,5,"Uldum carrion birds - Delicate Wing"),pin(249,70.2,67.6,5,"Uldum carrion birds - alternative wing farm")},
    {"https://www.wowhead.com/achievement=5473#comments:id=1264456","https://www.wowhead.com/achievement=5473#comments:id=1662375","https://www.wowhead.com/achievement=5473#comments:id=2010104","https://www.wowhead.com/achievement=5473#comments:id=3269607"},{198,249,241,207,244})
end
guides[5472].sourceReplyIds={761660}
guides[5473].sourceReplyIds={761660}
add(5779,"You'll Feel Right as Rain","easy","Obtain ninety-one Chocolate Cookies and keep the stacking food buff active.",{
    "Obtain at least NINETY-ONE Chocolate Cookies (62680). Buy the finished cookies from another player or the Auction House, or learn the Cataclysm Cooking recipe and make them. You do not need Cooking if you buy the finished food.",
    "For the cooking route, buy Recipe: Chocolate Cookie from a Cataclysm sous-chef vendor for Epicurean's Awards. Make ninety-one cookies using ninety-one Simple Flour and ninety-one Cocoa Beans. The vendors sell bags of cocoa beans for awards; check the bag's quantity before buying more.",
    "Put the cookies on an action bar and eat them one after another without letting the Satisfied buff expire. The FIRST cookie gives 100%; each additional one adds 10%. Ninety-one cookies bring the buff to 1000%.",
    "Check the achievement at 1000%. Each cookie refreshes the buff timer, so there is no need to eat them all within one original sixty-second window. A Chef's Hat, Chocolate Cake and a special standing/sitting trick are unnecessary.",
},{pin(84,50.6,71.6,2,"Stormwind sous-chef vendor - recipe and cocoa"),pin(85,56.6,62.6,2,"Orgrimmar sous-chef vendor - recipe and cocoa")},{1375847,1401028,1516174,1623742})
