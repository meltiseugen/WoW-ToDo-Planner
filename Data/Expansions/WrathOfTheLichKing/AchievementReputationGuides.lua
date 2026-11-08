-- Retail reputation routes. Preserve the detailed, already curated tabard
-- unlock guides, then add the achievement's Exalted requirement and farming route.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label}
end
local function add(id,name,steps,waypoints,tips,comments)
    local lines,sources={},{}
    for i,s in ipairs(steps) do lines[i]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="Reputation",sourceType="Achievement",source=name,
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=waypoints or {},tips=tips,sources=sources,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
for _,a in ipairs({{947,"The Argent Crusade",43154},{1007,"The Wyrmrest Accord",43156},{1008,"The Kirin Tor",43157},{1009,"Knights of the Ebon Blade",43155}}) do
    local base=TDP.CollectionWalkthroughs.cosmetics[a[3]]
    local step=(base.stepCount or 0)+1
    local points={}
    for _,p in ipairs(base.waypoints or {}) do points[#points+1]=p end
    local extra={
        "Keep the PHYSICAL reputation tabard equipped, not just its transmog appearance. Enter an eligible original Wrath Heroic dungeon such as Utgarde Keep or Gundrak and kill trash/bosses while checking that reputation is awarded to "..a[2]..". Current-expansion dungeons and Wrath raids are not the tabard farm.",
        "For repeat visits, rotate through different unsaved original Wrath Heroics after boss kills. For a repeatable Normal route, enter Halls of Lightning at 45.3, 21.6 in Storm Peaks, clear its enemies and bosses, leave, reset outside and repeat. Check reputation after the first kills and respect the instance-entry limit. Ordinary Normal Utgarde Keep is not equivalent to Normal Halls of Lightning for Northrend championing.",
        "Continue to EXALTED and confirm the achievement. Friendly only unlocks the tabard; owning it or learning the appearance is not the achievement. Supplement with the faction's Northrend story/daily quests if desired. Old Justice Point commendation purchases are no longer a Retail route.",
    }
    local lines={base.acquisition}
    for i,s in ipairs(extra) do lines[#lines+1]=(step+i-1)..". "..s end
    points[#points+1]=pin(117,58.2,48.9,step,"Utgarde Keep - original Heroic reputation run")
    points[#points+1]=pin(121,76.3,21.1,step,"Gundrak - original Heroic reputation run")
    points[#points+1]=pin(120,45.3,21.6,step+1,"Normal Halls of Lightning - repeatable tabard reputation")
    guides[a[1]]={achievementId=a[1],name=a[2],category="Reputation",sourceType="Achievement",source=a[2].." Exalted",
        acquisition=table.concat(lines,"\n\n"),stepCount=step+2,waypoints=points,
        tips=base.tips.." Follow the reputation bar after the first kills so an unequipped tabard or ineligible instance does not waste a run.",
        wowheadUrl="https://www.wowhead.com/achievement="..a[1],sourceURL="https://www.wowhead.com/achievement="..a[1].."#comments",
        sources={"https://www.wowhead.com/achievement="..a[1].."#comments","https://www.wowhead.com/item="..a[3].."#comments","https://www.wowhead.com/item=43156#comments:id=1337598","https://www.wowhead.com/achievement=1010#comments:id=2514794","https://www.wowhead.com/achievement=1010#comments:id=5162710"}}
end
add(1010,"Northrend Vanguard",{
    "Earn Exalted with ALL FOUR factions: Argent Crusade, The Wyrmrest Accord, Kirin Tor and Knights of the Ebon Blade. Check their individual guides for the Friendly unlock, exact vendor and any Shadow Vault phasing prerequisites.",
    "At Friendly, buy and equip the first missing faction's actual championing tabard. Clear eligible original Wrath Heroic dungeons, checking that faction in the combat/reputation log. Transmogging its appearance does not redirect reputation.",
    "When that faction reaches Exalted, replace its tabard with the next missing faction's tabard and repeat. Heroic Utgarde Keep/Gundrak are simple starting points; rotate unsaved original Heroics or use the Normal Halls of Lightning reset route described in the individual guides.",
    "Check all four Exalted criteria. Horde Expedition/Alliance Vanguard, Kalu'ak and the Sholazar factions are separate achievements and do not replace any of these four.",
},{pin(118,87.6,75.6,1,"Argent Crusade - Aliocha Segard"),pin(115,59.8,53,1,"Wyrmrest TOP terrace - Cielstrasza"),pin(125,25.4,47.8,1,"Violet Citadel UPSTAIRS - Archmage Alvareaux"),pin(118,43.4,20.6,1,"Unlocked Shadow Vault - Duchess Mynx"),pin(117,58.2,48.9,2,"Utgarde Keep - equip the correct tabard"),pin(121,76.3,21.1,2,"Gundrak - eligible original Heroic")},nil,{431007,2514794,5162710})
for _,alliance in ipairs({true,false}) do
    local faction=alliance and "Alliance Vanguard" or "Horde Expedition"
    add(alliance and 1012 or 1011,"The Winds of the North",{
        "Open Northrend reputations and track the PARENT reputation, "..faction..". This achievement requires that bar at Exalted, rather than all its component factions individually at Exalted.",
        "Complete your faction's Borean Tundra, Howling Fjord and Icecrown military quests for initial reputation/spillover. "..(alliance and "Valiance Keep and Valgarde" or "Warsong Hold and Vengeance Landing").." are useful campaign starting hubs.",
        "REMOVE reputation-championing tabards, including city and Northrend faction tabards. Clear eligible original Wrath Heroic dungeons such as Utgarde Keep and Gundrak to receive the default expedition/vanguard reputation instead of redirecting it elsewhere.",
        "Check "..faction.." after the first kills and rotate unsaved Heroics as needed. Reach Exalted on that specific bar and confirm the achievement. An Exalted subfaction alone is not the current requirement.",
    },{pin(114,alliance and 58.5 or 41.6,alliance and 68.2 or 54.2,2,alliance and "Valiance Keep - military reputation" or "Warsong Hold - military reputation"),pin(117,alliance and 59.9 or 78.5,alliance and 64.5 or 30.9,2,alliance and "Valgarde - military reputation" or "Vengeance Landing - military reputation"),pin(117,58.2,48.9,3,"Utgarde Keep - NO reputation tabard"),pin(121,76.3,21.1,3,"Gundrak - NO reputation tabard")},"The original pre-3.0.8 list of three required subfactions was replaced. Use the current parent-faction criterion.",alliance and {504021,611709,940910} or {504020,552564,928869})
end
add(949,"Tuskarrmageddon",{
    "Complete the Kalu'ak story quests in Borean Tundra (Kaskala/Unu'pe and Karuk), Dragonblight (Moa'ki Harbor), and Howling Fjord (Kamagua/Ancient Lift). These unlock three different dailies and provide initial reputation. This is The Kalu'ak, not Dragonflight's Iskaara Tuskarr.",
    "In Borean Tundra, take Preparing for the Worst from Utaik at 63.8, 45.8. Collect eight Kaskala Supplies from the nearby attacked village and turn them in.",
    "In Dragonblight, take Planning for the Future from Trapper Mau'i at Moa'ki Harbor (48.2, 74.2). Collect twelve Snowfall Glade Pups from the nearby wolvar settlement and return them.",
    "In Howling Fjord, take The Way to His Heart... from Anuniaq at Kamagua (24.6, 58.8). Obtain Tasty Reef Fish using the quest's fish interaction, then toss them at a Reef Bull repeatedly, moving it toward a Reef Cow until the objective credits. Bring enough fish to maintain the lure across the water.",
    "If Anuniaq has no daily, complete the Ancient Lift/Kamagua introduction and the pirate follow-ups at Scalawag Point, including the bull-seal blubber quest. The coastal pirate branch can be a prerequisite despite appearing unrelated.",
    "Repeat all three available dailies after resets until Exalted. Each gives 500 base reputation (1,500 per full day before bonuses). Reaching the daily stage does not guarantee that the earlier story left you at a particular reputation value.",
},{pin(114,63.8,45.8,2,"Utaik - Preparing for the Worst"),pin(115,48.2,74.2,3,"Trapper Mau'i - Planning for the Future"),pin(117,24.6,58.8,4,"Anuniaq - The Way to His Heart..."),pin(117,36,80,5,"Scalawag Point - missing Kamagua daily prerequisites")},"There is no Kalu'ak tabard that converts dungeon kills to this reputation. Old guild-reputation perks and fixed completion-time promises are omitted.",{560842,1151435,1845905,5307034})

local unlock="If the faction story is unfinished, kill Pitch near 50.6, 76.8 in Sholazar Basin and accept Playing Along from Tracker Gekgek. Follow the Frenzyheart jobs through Just Following Orders, help the injured Oracle, and finish the Oracle story through A Hero's Burden. Nesingwary's hunting chain is not required to start this faction chain."
local choiceTip="At high level, remove damage/proc gear and control damage so Artruis releases BOTH prisoners. Kill only the unwanted faction's prisoner. Complete the survivor's faction quest AND return-to-camp follow-up; merely killing the lich does not unlock the dailies. Switching can reset standing and is limited by the daily reset."
for _,oracles in ipairs({false,true}) do
    local id=oracles and 951 or 950
    local name=oracles and "The Oracles" or "Frenzyheart Tribe"
    add(id,name,{
        unlock,
        "Enter Artruis's cave at 70.8, 58.7 and reach the lich near 72.2, 57.5. Damage him carefully, then STOP until he releases Jaloot and Zepik. "..(oracles and "Kill ZEPIK, keep JALOOT alive" or "Kill JALOOT, keep ZEPIK alive")..", then finish Artruis without area damage that kills your survivor.",
        oracles and "Speak to Jaloot immediately. Complete Hand of the Oracles, then Return of the Friendly Dryskin and report to High-Oracle Soo-say at Rainspeaker Canopy (54.6, 56.3)." or "Speak to Zepik immediately. Complete Frenzyheart Champion, then Return of the Lich Hunter and report to Frenzyheart Hill (55.0, 69.2).",
        oracles and "At Rainspeaker Canopy, take all THREE dailies: High-Oracle Soo-say's treasure task, Soo-nee's rotating song task, and Soo-dow's rotating combat task. Soo-dow can be hidden inside the tree on the north side. Follow the combat task to Lightningcaller Soo-met near Sparktouched Haven." or "At Frenzyheart Hill, take all THREE dailies: Elder Harkek's Chicken Party!, Rejek's rotating task and Vekgar's rotating combat task. Follow the combat task to Shaman Jakjek near Kartak's Hold where instructed.",
        "Complete the current three quests, including each task's supplied item/companion, and return after daily resets until Exalted. The base full-day total is 1,700 reputation. Enable Trivial Quests if markers are missing and stay with this faction while finishing its eight-daily achievement.",
        oracles and "At Revered, Geen's Mysterious Eggs offer an optional mount/pet project, but buying or hatching an egg is not required for the Exalted achievement. Stay with the Oracles afterward if you want continued egg access." or "If pursuing Mercenary of Sholazar, reach Exalted and finish Honorary Frenzyheart BEFORE switching. Many collectors do Frenzyheart first, then keep Oracles for its repeatable mount/pet eggs.",
    },{pin(119,50.6,76.8,1,"Pitch / Tracker Gekgek - Playing Along"),pin(119,70.8,58.7,2,"Artruis cave entrance"),pin(119,72.2,57.5,2,oracles and "Artruis - save Jaloot, kill Zepik" or "Artruis - save Zepik, kill Jaloot"),pin(119,oracles and 54.6 or 55,oracles and 56.3 or 69.2,3,oracles and "Rainspeaker Canopy - return follow-up" or "Frenzyheart Hill - return follow-up"),pin(119,oracles and 54.6 or 55,oracles and 56.3 or 69.2,4,"Pick up ALL three dailies")},choiceTip,oracles and {873846,3177094,"https://www.wowhead.com/achievement=962#comments:id=2097761"} or {1112248,3177091,"https://www.wowhead.com/achievement=961#comments:id=3306010"})
end
add(952,"Mercenary of Sholazar",{
    unlock,
    "Choose Frenzyheart first if you want to end with Oracles egg access: at Artruis, let both prisoners release, kill Jaloot and save Zepik, then finish the lich. Complete Frenzyheart Champion and Return of the Lich Hunter to unlock Frenzyheart Hill's dailies.",
    "Do all three Frenzyheart dailies after resets until EXALTED and verify its achievement tick. Finish Honorary Frenzyheart and any purchases you want before switching. Returning to this allegiance later does not restore the old Exalted standing automatically.",
    "Return to Artruis's cave, repeat the controlled encounter, this time kill Zepik and save Jaloot. Finish Hand of the Oracles and Return of the Friendly Dryskin to unlock Rainspeaker Canopy's three dailies.",
    "Do the Oracles dailies until Exalted and check both recorded criteria. You do not need both factions Exalted simultaneously; the achievement remembers the completed sides. Its current progress is account-wide, so separate characters can also work on opposite allegiances without resetting one character's standing.",
},{pin(119,50.6,76.8,1,"Pitch - unlock the faction storyline"),pin(119,70.8,58.7,2,"Artruis cave - first choice"),pin(119,55,69.2,3,"Frenzyheart Hill - reach Exalted before switching"),pin(119,70.8,58.7,4,"Artruis cave - switch to save Jaloot"),pin(119,54.6,56.3,5,"Rainspeaker Canopy - second Exalted")},choiceTip,{518572,540500,668866,1318466})
add(961,"Honorary Frenzyheart",{
    "Unlock Frenzyheart dailies through the full Pitch/Artruis route in Frenzyheart Tribe's guide. Save Zepik, complete Frenzyheart Champion and Return of the Lich Hunter, then visit Frenzyheart Hill (55, 69.2). You need EIGHT different quests over resets, not eight repetitions of Chicken Party!.",
    "Chicken Party!: use the supplied Chicken Net or catch the escapees around the hill until twelve are captured. This daily is offered every day; the other two slots rotate.",
    "Tools of War: go to Shaman Jakjek at Kartak's Hold (about 24, 83), take Zepik's traps from the stash and kill fifty Sparktouched Gorlocs using the tools as needed. Kartak's Rampage instead needs an Oracle Blood drop brought to Kartak's altar, then fifty gorloc kills with the supplied power.",
    "Secret Strength of the Frenzyheart: obtain the ale from Grimbooze at Nesingwary Base Camp (27, 60), combine it with the quest berries and use the resulting drink for thirty Sparktouched Gorloc kills near Kartak's Hold.",
    "The Heartblood's Strength: fill the supplied vial at the Suntouched Pillar (32, 52), kill the Goretalon Matriarch near 59, 23 and combine the required heartblood. Rejek: First Blood instead needs his blade used on the corpses of a Sapphire Hive Wasp, a Hardknuckle Charger and THREE Mistwhisper tribe members; killing without blooding the blade is insufficient.",
    "Strength of the Tempest: at Stormwright's Shelf, collect three Essences of the Monsoon and three Essences of the Storm, then take them to the Shrine of the Tempest (about 22, 44) for True Power of the Tempest.",
    "A Hero's Headgear: get Venture Co. Explosives at Swindlegrin's Dig (35, 44). Kill a Stormwatcher on the high western shelf, use the explosives and loot its head. Return each completed Rejek task to Frenzyheart Hill.",
    "Check all eight quest names and keep returning after resets for missing rotations. Check character-level eligibility and Trivial Quest tracking if fewer than three tasks appear. Old realm-hop guarantees are omitted; do not switch factions until your desired ticks are complete.",
},{pin(119,55,69.2,1,"Frenzyheart Hill - all three daily quest givers"),pin(119,55,69.2,2,"Chicken Party! - escapees around the hill"),pin(119,24,83,3,"Kartak's Hold - combat daily / tools / altar"),pin(119,27,60,4,"Grimbooze - ale for Secret Strength"),pin(119,24,83,4,"Kartak's Hold - thirty gorlocs"),pin(119,32,52,5,"Suntouched Pillar - heartblood water"),pin(119,59,23,5,"Goretalon Matriarch - heartblood"),pin(119,48,35,5,"Mistwhisper Refuge - blood Rejek's Blade"),pin(119,59,79,5,"Sapphire Hive - wasp corpse"),pin(119,67,68,5,"Hardknuckle area - charger corpse"),pin(119,26,35,6,"Stormwright's Shelf - essences"),pin(119,22,44,6,"Shrine of the Tempest"),pin(119,35,44,7,"Swindlegrin's Dig - explosives"),pin(119,26,35,7,"Stormwatcher - use explosives and loot head")},choiceTip,{463187,475539,552191,3306010,5795003})
add(962,"Savior of the Oracles",{
    "Unlock the Oracles dailies through Pitch's storyline, save Jaloot at Artruis, and finish Hand of the Oracles AND Return of the Friendly Dryskin. At Rainspeaker Canopy (54.6, 56.3), take three dailies; the combat quest giver Soo-dow is inside the tree on the north side.",
    "Appeasing the Great Rain Stone: speak to Soo-say for an Oracle companion/summoning item. Follow the companion's dig interactions and loot six Shiny Treasures. Keep the companion summoned instead of searching for ordinary lootable ground treasure alone.",
    "Mastery of the Crystals: collect the three crystal defenses at Sparktouched Haven, then kill fifty Frenzyheart Attackers. Will of the Titans instead needs a Tainted Crystal from the wolvar brought to the Great Lightning Stone to call Soo-holu, followed by fifty kills. Turn the combat task in to Lightningcaller Soo-met near the front.",
    "Power of the Great Ones: charge the Dormant Polished Crystal at the exposed Lifeblood Pillar, return to Sparktouched Haven, use its power and kill thirty Frenzyheart Attackers before reporting to Soo-met.",
    "Song of Reflection: use the Didgeridoo of Contemplation on TOP of all four named pillars: Glimmering, Suntouched, Mosslight and Skyreach. Land on each top rather than playing the instrument at its base.",
    "A Cleansing Song: use the Cleansing Chime at Bittertide Lake, Wintergrasp River and River's Heart; kill each summoned spirit. The three water destinations are in Sholazar Basin, including the river on its eastern side.",
    "Song of Wind and Water: use the Tempest Drums at Stormwright's Shelf and use Haiphoon's vehicle actions to devour three Storm Revenants and three Aqueous Spirits, switching forms as required. Song of Fecundity instead needs the Horn of Fecundity played near eight Soaked Fertile Dirt piles on the same shelf.",
    "Repeat after daily resets until all EIGHT named quests credit. One treasure quest is fixed; the combat and song slots rotate. A missing rotation is not evidence that the achievement was removed. Stay with the Oracles while finishing these criteria.",
},{pin(119,54.6,56.3,1,"Rainspeaker Canopy - ALL three daily givers"),pin(119,54.6,56.3,2,"Soo-say - obtain the digging companion"),pin(119,33.5,75,3,"Sparktouched Haven - crystal / Titan combat task"),pin(119,65,59,4,"Lifeblood Pillar - charge the polished crystal"),pin(119,33.5,75,4,"Sparktouched Haven - Power of the Great Ones"),pin(119,49,38,5,"Glimmering Pillar TOP - Reflection"),pin(119,33,52,5,"Suntouched Pillar TOP - Reflection"),pin(119,36,75,5,"Mosslight Pillar TOP - Reflection"),pin(119,54,79,5,"Skyreach Pillar TOP - Reflection"),pin(119,40,34,6,"Bittertide Lake - cleansing spirit"),pin(119,69,55,6,"Wintergrasp River - cleansing spirit"),pin(119,50,62,6,"River's Heart - cleansing spirit"),pin(119,26,35,7,"Stormwright's Shelf - drums or fertile dirt")},choiceTip,{460444,463170,473046,2097761,6000191})

for _,alliance in ipairs({true,false}) do
    local faction=alliance and "The Silver Covenant" or "The Sunreavers"
    add(alliance and 3676 or 3677,alliance and "A Silver Confidant" or "The Sunreavers",{
        "On a "..(alliance and "Alliance" or "Horde").." character, enrol at the Argent Tournament in northern Icecrown. Finish the mounted-training introduction, earn fifteen Aspirant's Seals, pass the Aspirant's Challenge and become a Valiant for the offered city.",
        "Complete the city's Valiant dailies for twenty-five Valiant's Seals, finish The Valiant's Charge and defeat Squire Danny's Argent Champion for The Valiant's Challenge. Turn in to gain the RIGHT TO REPRESENT A CITY; reputation alone does not meet this second requirement.",
        "Raise "..faction.." to Exalted through the tournament's available Aspirant/Valiant/Champion quests. Continue the unlocked Champion work after the city promotion. You can also check eligible original Wrath Heroic kills with NO reputation tabard for default expedition/vanguard subfaction gains; watch the actual faction bar.",
        "Check BOTH conditions: Exalted "..faction.." and city representation. This unlocks the additional faction dailies in its tournament pavilion. It does not require all five cities at Champion or Exalted; those belong to the later Crusader chain.",
    },{pin(118,alliance and 76.4 or 76.2,alliance and 19.4 or 24.2,1,alliance and "Alliance pavilion - Arcanist Taelis" or "Horde pavilion - Magister Edien Sunhollow"),pin(118,68.6,20.9,2,"Squire Danny - Valiant's Challenge"),pin(118,alliance and 76.4 or 76.2,alliance and 19.4 or 24.2,3,"Tournament reputation dailies"),pin(117,58.2,48.9,3,"Optional original Heroic - remove reputation tabard")},"Keep the tournament progression on the character that needs its quest/vendor unlocks. Account achievement credit does not automatically complete another character's city-representation quest chain.",alliance and {761630,1837763,5544294} or {784352,825294,961769})
end
