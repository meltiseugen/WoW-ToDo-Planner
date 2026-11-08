-- Retail profession and fishing achievements, curated from the individual
-- achievement comments and their corrections; old First Aid skill is not used.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label}
end
local function add(id,name,steps,waypoints,tips,comments)
    local lines,sources={},{}
    for i,text in ipairs(steps) do lines[i]=i..". "..text end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="Professions",sourceType="Achievement",source=name,
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=waypoints or {},tips=tips,sources=sources,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
add(125,"Northrend Cook",{
    "Learn Northrend Cooking from Katherine Lee in A Hero's Welcome (Alliance, 40.3, 66.1) or Awilo Lon'gomba in the Horde inn (70.0, 38.9), in Northrend Dalaran. Open the Northrend category: another expansion's Cooking skill does not count.",
    "Use the orange/yellow trainer recipes and available Northrend meat/fish to raise that category. Rhino Dogs use Rhino Meat and are a practical early recipe; keep them and Chilled Meat for the Dalaran cooking dailies.",
    "Do the daily from your cooking trainer for Epicurean's Awards. At Derek Odds or Misensi beside the faction kitchen, buy a higher-skill recipe such as Mighty Rhino Dogs and Northern Spices for its ingredients. Switch recipes when your current one no longer grants skill.",
    "Continue to 75 base Northrend Cooking skill. The original 450 total-skill requirement was replaced by this expansion-specific cap. Crafting different needed recipes also advances The Northrend Gourmet.",
},{pin(125,40.3,66.1,1,"Katherine Lee - Alliance Northrend Cooking"),pin(125,70,38.9,1,"Awilo Lon'gomba - Horde Northrend Cooking"),pin(125,40.6,65.8,3,"Derek Odds - Alliance recipes and spices"),pin(125,70.2,39,3,"Misensi - Horde recipes and spices")},nil,{3245217})
add(130,"Northrend Fisherman",{
    "Visit Marcia Chase beside the Eventide fountain in Northrend Dalaran (52.6, 64.8) and learn Northrend Fishing. Check the Northrend skill bar rather than your current-expansion Fishing bar.",
    "Fish Northrend water until this category reaches 75. The Eventide fountain lets you work on all three coin checklists at the same time; the Underbelly is an alternative while trying for Giant Sewer Rat.",
    "Loot your catches and keep fishing after casts that do not increase skill. Higher levels can take several catches per point. Return to the skill window to confirm 75 Northrend Fishing and achievement credit.",
},{pin(125,52.6,64.8,1,"Marcia Chase - learn Northrend Fishing"),pin(125,52.5,66.2,2,"Eventide fountain - skill and coin fishing"),pin(126,44,65,2,"Underbelly - alternate skill / Giant Sewer Rat")},nil,{5350969})
add(137,"Stocking Up",{
    "Use a character with Tailoring. Learn Northrend Tailoring, then visit the First to Your Aid shop in Northrend Dalaran (37.4, 36.6) for the Frostweave bandage recipes. First Aid is no longer a separate profession.",
    "Raise Northrend Tailoring to the Heavy Frostweave Bandage recipe's requirement (15). If starting at skill 1, reserve extra cloth for the ordinary bandages needed to reach it.",
    "Obtain 1,000 Frostweave Cloth for 500 Heavy Frostweave Bandages, less any progress already credited. Each heavy bandage consumes two cloth. Buying 500 finished bandages does not satisfy a crafting achievement.",
    "Personally craft the heavy bandages, allowing bag space and enough time for the queue. Check the achievement counter before selling or using the results. This remains earnable through Tailoring despite its original First Aid classification.",
},{pin(125,36.5,33.5,1,"Charles Worth - Northrend Tailoring"),pin(125,37.4,36.6,1,"First to Your Aid - bandage recipes")},"Starting from skill 1 requires additional cloth; the comment's 1,014 total includes 14 cloth for preparation. Prices and crafting time vary.",{611551,3290588,5458583})
add(141,"Ultimate Triage",{
    "Obtain a Heavy Frostweave Bandage or an Embersilk/Windwool Bandage. You may buy the finished bandage; you do not need the retired First Aid profession. Check its level requirement before arranging the attempt.",
    "A repeatable setup is a duel with a friend in a safe outdoor area, such as the ground below Northrend Dalaran. Let your friend win the duel, leaving you at very low health. Stop automatic healing effects and avoid nearby enemies.",
    "Immediately use the qualifying bandage on yourself while below 5% health. Let its healing begin without moving or taking damage. Alternatively bandage the losing player while they are still below the threshold.",
    "If health regenerated above 5% or Recently Bandaged prevents another attempt, wait for the restriction, then repeat the duel. Buying or using an unrelated low-level bandage does not meet the named-bandage requirement.",
},{pin(127,15,42,2,"Crystalsong Forest below Dalaran - arrange a safe duel")},"Use the qualifying bandage while the target is still below 5% health. A controlled duel lets you repeat the setup without searching for a particular low-health training dummy.",{484444,2335854,5892794,5953872})
for _,a in ipairs({{734,"Professional Northrend Master",1},{735,"Working In the Cold",2}}) do
    add(a[1],a[2],{
        "Open your primary professions and choose "..(a[3]==1 and "one" or "two").." Northrend categories to raise. Cooking and Fishing are secondary professions and do not count. Use professions you already want to keep; changing professions can discard learned recipes.",
        "Visit the matching trainers in Dalaran's Magus Commerce Exchange and learn their Northrend training. For a gathering profession, gather Northrend nodes/beasts with its Northrend skill learned. For a crafting profession, use its Northrend recipes and materials, replacing recipes as they stop granting skill.",
        "Reach 75 base skill in "..(a[3]==1 and "that Northrend primary-profession category" or "each of two Northrend primary-profession categories")..". Check the expansion bars directly; training a title or reaching 75 in another expansion is insufficient.",
        a[3]==1 and "Confirm achievement credit. A second completed Northrend primary profession also advances Working In the Cold." or "Check both criteria in Working In the Cold. Its current progress is account-wide, but one character with both chosen professions provides a straightforward route without relying on the old Grand Master training rules.",
    },{pin(125,39,29,2,"Magus Commerce Exchange - choose the matching profession trainer")},"Retail replaced the old 350/450 total-skill and Grand Master rank descriptions with 75 skill in the Northrend category.",a[1]==734 and {372530,1375916,1589517} or {338804,784251})
end
for _,a in ipairs({{1777,15},{1778,30},{1779,45}}) do
    add(a[1],"The Northrend Gourmet",{
        "Learn Northrend Cooking, track this achievement, and plan to personally cook "..a[2].." DIFFERENT listed recipes. Buying or eating a finished dish does not grant this crafting criterion, and repeated batches of one dish only fill one tick.",
        "Learn the trainer dishes in Northrend Dalaran: Baked Manta Ray, Dalaran Clam Chowder, Grilled Bonescale, Grilled Sculpin, Mammoth Meal, Pickled Fangtooth, Poached Nettlefish, Rhino Dogs, Roasted Worg, Sauteed Goby, Shoveltusk Steak, Smoked Rockfin, Smoked Salmon, Worm Delight and Great Feast. Obtain Northern Stew through the faction's Northern Cooking quest at its Borean Tundra starting hub if missing.",
        "Do Dalaran cooking dailies for Epicurean's Awards, then buy the missing recipes from Derek Odds (Alliance) or Misensi (Horde). Purchase Northern Spices as needed. Cook one of each uncredited recipe instead of spending all awards on redundant recipes or the Chef's Hat first.",
        "For the four unusual dishes, obtain the dropped/tradeable recipes for Bad Clams, Haunted Herring, Last Week's Mammoth and Tasty Cupcake. Check the Auction House before farming Northrend humanoids. Learn each recipe and cook the dish; these are not all taught by the trainer.",
        "For Kungaloosh, complete Grimbooze Thunderbrew's drinking quests at Nesingwary Base Camp in Sholazar Basin through The Taste Test. Find the Washed-Up Mage behind a sewer grate at Underbelly 43.2, 24.4, complete Fletcher's Lost and Found to learn Kungaloosh, then obtain its fruit ingredients and make it.",
        "Work down the live checklist, including feast recipes when needed. Fish Feast is a further cooking-award recipe unlock; check the vendor's current requirement if it is locked. Stop at "..a[2].." unique cooked entries for this tier; the 45-recipe tier needs every listed dish, including Kungaloosh and all four dropped recipes.",
    },{pin(125,40.3,66.1,2,"Katherine Lee - Alliance trainer dishes"),pin(125,70,38.9,2,"Awilo Lon'gomba - Horde trainer dishes"),pin(114,58.2,62.1,2,"Valiance Keep - Alliance Northern Cooking quest"),pin(114,42,54.1,2,"Warsong Hold - Horde Northern Cooking quest"),pin(125,40.6,65.8,3,"Derek Odds - award recipes / Northern Spices"),pin(125,70.2,39,3,"Misensi - award recipes / Northern Spices"),pin(119,27,58.5,5,"Nesingwary Base Camp - Grimbooze's Taste Test"),pin(126,43.2,24.4,5,"Washed-Up Mage - behind grate; Kungaloosh after The Taste Test")},"Keep useful previously collected recipes. Use the current 45-dish achievement checklist to decide what is missing; the original total Cooking skill numbers are obsolete.",{"https://www.wowhead.com/achievement=1779#comments"})
end
add(1780,"Second That Emotion",{
    "Obtain one each of Bad Clams, Last Week's Mammoth, Haunted Herring and Tasty Cupcake. Buying the FINISHED foods from the Auction House or another cook is sufficient; you do not have to craft them yourself.",
    "Eat Bad Clams and let its associated emotion effect register, then do the same with Last Week's Mammoth. Stay seated long enough to receive each food's effect rather than cancelling immediately.",
    "Eat Haunted Herring, then Tasty Cupcake, checking the four achievement criteria. You need all four foods, not any four servings of the same food.",
    "If cooking them yourself, learn their four dropped Northrend recipes first. They are separate from the normal trainer dishes. Keep the crafting ticks for The Northrend Gourmet and the eating ticks for this achievement distinct.",
},{pin(125,40.3,66.1,4,"Alliance cooking area - prepare the four foods"),pin(125,70,38.9,4,"Horde cooking area - prepare the four foods")},nil,{5169406})
add(1781,"Critter Gitter",{
    "Buy or cook at least ten Critter Bites and place them on an action button. Find a dense group of living critters before using any; the achievement needs ten following you within three minutes.",
    "A useful Northrend spot is the Fjord Turkey field just west of Explorers' League Outpost in Howling Fjord, around 69.2, 64.6. Do this before killing the turkeys for Friend or Fowl?.", 
    "Target one living turkey, use a Critter Bite, then target a DIFFERENT nearby turkey and repeat. Keep the followers alive and close; do not use damaging area attacks or repeatedly feed the same critter.",
    "Continue until ten are following simultaneously before the first follower expires. If the field was cleared by another player, wait for respawns or find another dense critter group before starting the timer again.",
},{pin(117,69.2,64.6,2,"Fjord Turkey field - ten living critter followers"),pin(117,69.2,64.6,3,"Feed a different turkey for each Critter Bite")},nil,{6202649,6463200})
for _,alliance in ipairs({true,false}) do
    add(alliance and 1782 or 1783,"Our Daily Bread",{
        "Learn Northrend Cooking and take today's daily from "..(alliance and "Katherine Lee in the kitchen at A Hero's Welcome (40.3, 66.1)" or "Awilo Lon'gomba in the Horde inn (70.0, 38.9)").." in Northrend Dalaran. One random daily is offered per day; repeat after resets until all five named quests credit.",
        "Convention at the Legerdemain: cook four Northern Stew (Chilled Meat), pick up a Jug of Wine at the cheese shop One More Glass, and deliver both to Arille Azuregaze in the Legerdemain Lounge. This branch turns in there, not at your cooking trainer.",
        "Cheese for Glowergold: collect Aged Dalaran Limburger at One More Glass and six Half Full Dalaran Wine Glasses from inn/tavern tables. Use the supplied Empty Cheese Platter to combine them, then deliver it to Ranid Glowergold in the leatherworking shop.",
        "Infused Mushroom Meatloaf: collect four Infused Mushrooms in the Northrend Underbelly. Combine them with two Chilled Meat using the supplied Meatloaf Pan, then deliver the result to Orton Bennet in Curiosities & Moore.",
        "Mustard Dogs!: cook four Rhino Dogs from Rhino Meat and collect four Wild Mustard plants in Dalaran's grassy areas. Use the supplied basket, then deliver it to Archmage Pentarus at Krasus' Landing.",
        "Sewer Stew: descend to Crystalsong Forest and collect four Crystalsong Carrots. Combine them with four Chilled Meat using the quest Cookpot, then deliver the stew to Ajay Green in the Cantrips & Crows sewer inn.",
        "Use only the branch matching today's quest. Keep Chilled Meat and Rhino Meat for future resets, and learn Northern Stew if missing. Repeated daily selections are normal; abandoning a duplicate does not reroll the rotation.",
    },{pin(125,alliance and 40.3 or 70,alliance and 66.1 or 38.9,1,alliance and "Katherine Lee - accept daily" or "Awilo Lon'gomba - accept daily"),pin(125,53.5,34.8,2,"One More Glass - cheese / Jug of Wine"),pin(125,48.5,38.1,2,"Legerdemain Lounge - Arille"),pin(125,36.4,28.6,3,"Ranid Glowergold - leatherworking shop"),pin(126,44,65,4,"Underbelly - search for Infused Mushrooms"),pin(125,52,55.2,4,"Curiosities & Moore - Orton Bennet"),pin(125,68.6,42,5,"Krasus' Landing - Archmage Pentarus"),pin(127,27,43,6,"Crystalsong Forest - carrot search area below Dalaran"),pin(126,35.4,57.4,6,"Cantrips & Crows - Ajay Green")},"All quest destinations are in the original Northrend city and its surroundings. The modern requirement is learned Northrend Cooking, not the old 350/375 combined Cooking skill.",{1172616,1172617,6244506,"https://www.wowhead.com/quest=13100","https://www.wowhead.com/quest=13101","https://www.wowhead.com/quest=13102","https://www.wowhead.com/quest=13103","https://www.wowhead.com/quest=13107"})
end
add(1785,"Dinner Impossible",{
    "Obtain at least four Great Feast (item 34753), either cooked or bought. Fish Feast, Small Feast and Gigantic Feast are different items and do not satisfy this achievement.",
    "Queue for Alterac Valley through Epic Battlegrounds. Once in the match, place a Great Feast on the ground where placement is allowed and check that Alterac Valley credits.",
    "Queue for Warsong Gulch and Arathi Basin through the PvP battleground interface. In each actual match, place another Great Feast and check its separate tick. No victory or personal eating step is required.",
    "Do the same in Eye of the Storm. If preparation-area placement does not credit, place it after the match starts. Review all FOUR current criteria; the removed Strand of the Ancients is no longer needed.",
},{},"These destinations are instanced battlegrounds reached through the PvP queue, not outdoor travel pins. Cooking skill is unnecessary when using purchased Great Feasts.",{1258874,1686673,2835472})
guides[1785].areaMaps={91,1339,1366,112}
add(3296,"Cooking with Style",{
    "Earn 100 Epicurean's Awards from cooking dailies. Northrend Dalaran's faction cooking daily and eligible capital-city cooking dailies use this currency; check your currency balance before spending it on recipes or spices.",
    "Go to Derek Odds beside the Alliance kitchen (40.6, 65.8) or Misensi beside the Horde kitchen (70.2, 39.0) in Northrend Dalaran. Buy the CURRENT Chef's Hat toy (134020) for 100 awards.",
    "Check achievement credit from the purchase, then use the item to add it to your Toy Box. Merely wearing a chef-looking transmog item is not the purchase requirement.",
    "During Wrath Timewalking, check Auzin's current Small Spice Bag stock if you have spare Timewarped Badges: these bags can provide awards. Compare the vendor's live cost before buying, since the regular daily route works independently of this event.",
},{pin(125,40.6,65.8,2,"Derek Odds - Alliance Chef's Hat"),pin(125,70.2,39,2,"Misensi - Horde Chef's Hat"),pin(125,50,45.6,4,"Auzin - optional Wrath Timewalking spice bags")},"Buying the hat awards the achievement and removes its normal currency-refund option. The old head-slot item was replaced by a toy.",{2864839,5441688})

add(1517,"Northrend Angler",{
    "Learn Fishing and enable Find Fish if you have it. You need a successful catch from each of TEN different named schools. Cast INTO a visible pool; open-water fishing beside it does not satisfy that school.",
    "In Borean Tundra, fish Borean Man O' War schools along the eastern coast (84.5, 48.3) and Musselback Sculpin schools around the inland water (73.0, 45.8). Check both names on the pool tooltip.",
    "Fly to the icebergs offshore southeast of Unu'pe/Death's Stand (about 89.1, 53.7, still on the Borean map). Fish both Deep Sea Monsterbelly and Moonglow Cuttlefish schools. Search around the ice, fishing other schools out if the missing type is absent; do not continue into fatigue water.",
    "In Dragonblight, fish Dragonfin Angelfish at Lake Indu'le (39.5, 65.6). Continue to Grizzly Hills and fish a Glacial Salmon school along the southwestern river (23.9, 79.6).",
    "In Howling Fjord, find Imperial Manta Ray schools along the northwest coast (21.2, 15.3), then Fangtooth Herring schools in inland water near 33.5, 26.2. Manta schools also occur on other Northrend coasts.",
    "In Sholazar Basin, fish a Nettlefish school along the waterways, for example near 73.8, 64.2. In Crystalsong Forest, fish a Glassfin Minnow school near 32.9, 44.8. Check all ten criteria before leaving.",
},{pin(114,84.5,48.3,2,"Borean Man O' War school search"),pin(114,73,45.8,2,"Musselback Sculpin school search"),pin(114,89.1,53.7,3,"Offshore icebergs - Monsterbelly AND Cuttlefish schools"),pin(115,39.5,65.6,4,"Lake Indu'le - Dragonfin Angelfish"),pin(116,23.9,79.6,4,"Southwestern river - Glacial Salmon"),pin(117,21.2,15.3,5,"Northwest coast - Imperial Manta Ray"),pin(117,33.5,26.2,5,"Inland water - Fangtooth Herring"),pin(119,73.8,64.2,6,"Waterways - Nettlefish"),pin(127,32.9,44.8,6,"Glassfin Minnow school search")},"Pins mark pool search areas, not permanent spawns. Loot a successful non-junk catch from the pool and verify its tick. Original 480 Fishing requirements and coordinates on the zoomed-out continent map are omitted.",{454536,681625,1610340,5744312})
for _,a in ipairs({{1957,"There's Gold In That There Fountain","15 gold"},{2094,"A Penny For Your Thoughts","22 copper"},{2095,"Silver in the City","15 silver"},{2096,"The Coin Master","all 52 gold, silver and copper"}}) do
    add(a[1],a[2],{
        "Travel to the ORIGINAL Dalaran above Crystalsong Forest in Northrend. Find the small Eventide fountain beside Marcia Chase at 52.5, 66.2. Legion Dalaran's lookalike fountain has different junk coins and does not complete these lists.",
        "Learn Fishing, stand at the fountain and cast into its water. Loot every catch. Track the "..a[3].." named coins in the achievement checklist; repeated catches of a coin you already have do not fill missing names.",
        "When you catch a gold coin, right-click it to throw it back for the two-minute Lucky buff. Its achievement credit was already recorded when caught. Refresh near expiry rather than throwing several at once: the buff does not stack.",
        "Continue fishing and maintaining Lucky while any required coin is missing. You do not need to store all coins at once. There is no fixed cast total or time guarantee for the last coin.",
        a[1]==2096 and "Complete There's Gold In That There Fountain, A Penny For Your Thoughts and Silver in the City. Together these award The Coin Master; collect its Titanium Seal of Dalaran reward from the achievement mail." or "Check every named criterion in this coin tier. Keep fishing the same fountain for the other two metal lists if you also want The Coin Master and its reward.",
    },{pin(125,52.5,66.2,1,"Eventide fountain - Northrend coin achievements"),pin(125,52.5,66.2,3,"Throw back a gold coin for Lucky")},"This uses Northrend Dalaran (map 125). A particular old combined Fishing level is not required to cast. Lucky improves coin fishing; it cannot target a specific missing name.",{"https://www.wowhead.com/achievement=1957#comments:id=444463","https://www.wowhead.com/achievement=1957#comments:id=1618113","https://www.wowhead.com/achievement=2095#comments:id=1410600","https://www.wowhead.com/achievement=2096#comments:id=6053400"})
end
add(1958,"I Smell A Giant Rat",{
    "Travel to Northrend Dalaran and descend into the Underbelly. Learn Fishing and make bag space. The dock at Cantrips & Crows (44.0, 65.0 on the sewer map) is a convenient confirmed fishing spot.",
    "Fish the sewer's open water repeatedly. You do not need a school, a particular daily quest or a special lure for the rat to be eligible. A Drowned Rat is junk and is not the required Giant Sewer Rat (43698).",
    "When the Giant Sewer Rat appears, LOOT the original item and accept any binding confirmation before moving or recasting. Check achievement credit, then learn the pet if desired.",
    "An alternative is the ORIGINAL Giant Sewer Rat item on the Black Market Auction House when it rotates in. Current Retail replies confirm that acquisition also awards this achievement. A normal Auction House CAGED pet only learns the pet and does not award it.",
},{pin(126,44,65,1,"Cantrips & Crows - Giant Sewer Rat fishing"),pin(126,64,17,2,"Underbelly Black Market district - alternate fishing water")},"The sewer district called Black Market is a fishing area; it is distinct from the actual rotating Black Market Auction House. No number of casts guarantees the catch.",{1352066,5777769,5827395,6269225})
add(3217,"Chasing Marcia",{
    "Visit Marcia Chase at Northrend Dalaran's Eventide fountain (52.6, 64.8), learn Northrend Fishing and accept today's daily. Complete each of her FIVE different daily quests over multiple resets; you cannot select all five on one day.",
    "Jewel Of The Sewers: fish open water in the Northrend Underbelly, for example the Cantrips & Crows dock (44.0, 65.0), until you catch Corroded Jewelry. Return it to Marcia.",
    "Disarmed!: fish the water outside Violet Hold (65.0, 61.0), catch and OPEN the Bloated Slippery Eel, then bring its Severed Arm to Olisarra the Kind at First to Your Aid (37.4, 36.6). This turn-in is not at Marcia.",
    "The Ghostfish: fish open water at River's Heart in Sholazar Basin (50.1, 61.5). EAT the Phantom Ghostfish within one minute, while still there, so its mystery credits. Then return to Marcia.",
    "Blood Is Thicker: in Borean Tundra kill a beast for the blood effect, then enter fishable water such as Lake Kum'uya (53.0, 44.0). Fish five Bloodtooth Frenzies from the resulting blood pool and return them to Marcia.",
    "Dangerously Delicious: fish ten Terrorfish from open water in OUTDOOR Wintergrasp, for example its eastern lake (71.0, 42.0). Return them to Marcia. You do not need to queue for the battleground or win its fortress.",
    "Keep checking after daily resets until all five turn-ins credit. Opening the Bag of Fishing Treasures is useful for rewards but does not replace completing a missing daily. Use the Northrend quest giver, not her Legion counterpart.",
},{pin(125,52.6,64.8,1,"Marcia Chase - one random daily per day"),pin(126,44,65,2,"Jewel Of The Sewers - Corroded Jewelry"),pin(125,65,61,3,"Disarmed! - fish and open Bloated Slippery Eel"),pin(125,37.4,36.6,3,"Olisarra - deliver Severed Arm"),pin(119,50.1,61.5,4,"River's Heart - eat Phantom Ghostfish promptly"),pin(114,53,44,5,"Lake Kum'uya - create and fish blood pool"),pin(123,71,42,6,"Outdoor Wintergrasp - Terrorfish")},nil,{1633275,2585837})
add(3218,"Turtles All the Way Down",{
    "Learn Fishing and choose a circuit of visible eligible fishing pools. Enable Find Fish if learned. Northrend Nettlefish and Fangtooth Herring pools are useful because they also advance other fishing achievements.",
    "Start at Bittertide Lake in Sholazar Basin (38.0, 39.0). Cast inside each Nettlefish school until it disappears, then move to the next. Fishing the lake's ordinary open water does not give the same turtle opportunity.",
    "If pools are empty or crowded, switch to Howling Fjord's inland Fangtooth Herring schools, for example near 48.0, 39.0. This also gives a chance at the Dark Herring needed for One That Didn't Get Away outside this expansion catalogue.",
    "Continue pool fishing, loot every catch and keep bag space. When Sea Turtle (46109) appears, loot its original item before recasting and learn the mount. Check the achievement as well as the Mount Journal.",
},{pin(119,38,39,2,"Bittertide Lake - Nettlefish pool circuit"),pin(117,48,39,3,"Howling Fjord lakes - Fangtooth Herring alternate")},"Eligible pools in later expansions also provide surviving Retail routes. This is a rare catch without a guaranteed number of casts; fountain or sewer open-water fishing for coins/rat is a different farm.",{929176,1900057,1607166})
