-- Individual Retail tournament achievement discussions were reviewed, including
-- the repeated city-challenge guides, rank corrections and modern unlock replies.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label}
end
local function add(id,name,steps,waypoints,tips,comments)
    local lines,sources={},{}
    for i,s in ipairs(steps) do lines[i]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="Argent Tournament",sourceType="Achievement",source=name,
        acquisition=table.concat(lines,"\n\n"),stepCount=#steps,waypoints=waypoints or {},tips=tips,sources=sources,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local joust="Equip the lance and mount an eligible tournament steed. Build THREE Defend stacks (action 4) before challenging. Use Thrust (1) in melee; when the enemy rides away, Charge (3) as soon as range allows, then Shield-Breaker (2) while turning back to melee. Refresh Defend when a stack is lost. Heal between bouts."
local weapon="Complete only today's weapon errand: A Blade Fit For A Champion uses Warts-B-Gone Lip Balm before EACH /kiss on a Lake Frog at Grizzly Hills 60.5, 51.5; speak to the revealed Maiden. A Worthy Weapon needs FOUR Winter Hyacinths from the Decrepit Flow (Crystalsong 12, 16), used inside the flower circle at Drak'Mar Lake (Dragonblight 93.1, 25.9); wait and LOOT the sword. The Edge of Winter needs Lord Everblaze's ember (Crystalsong 55.5, 74.9), used on the frozen Maiden at Winter's Breath Lake (Howling Fjord 42.2, 19.6). Return the obtained weapon to your own quest giver."
local function weaponPins(points,step)
    points[#points+1]=pin(116,60.5,51.5,step,"Blade Fit - lip balm, /kiss frogs, talk to Maiden")
    points[#points+1]=pin(127,12,16,step,"Worthy Weapon - FOUR Winter Hyacinths")
    points[#points+1]=pin(115,93.1,25.9,step,"Worthy Weapon - use flowers in circle, LOOT sword")
    points[#points+1]=pin(127,55.5,74.9,step,"Edge of Winter - kill Lord Everblaze, loot ember")
    points[#points+1]=pin(117,42.2,19.6,step,"Edge of Winter - use ember on frozen Maiden")
end
local weaponSources={"https://www.wowhead.com/quest=13673#comments:id=627500","https://www.wowhead.com/quest=13674#comments:id=668629","https://www.wowhead.com/quest=13675#comments:id=2468252"}
add(2756,"Argent Aspiration",{
    "Travel to Justicar Mariel Trueheart inside the Argent pavilion at the Argent Tournament Grounds, northern Icecrown (69.6, 22.8). Enable Trivial Quests and accept The Argent Tournament.",
    "Follow its faction-specific introduction to Arcanist Taelis in the Alliance pavilion (76.4, 19.4) or Magister Edien Sunhollow in the Horde pavilion (76.2, 24.2). Turn in the introduction to enrol as an Aspirant and receive this achievement.",
    "Take the lance/mounted-training lessons for further progression. Fifteen Aspirant's Seals and the later Aspirant's Challenge are for Argent Valor; they are not prerequisites for this enrollment achievement.",
},{pin(118,69.6,22.8,1,"Justicar Mariel Trueheart - The Argent Tournament"),pin(118,76.4,19.4,2,"Arcanist Taelis - Alliance enrollment"),pin(118,76.2,24.2,2,"Magister Edien Sunhollow - Horde enrollment")},"The early PTR comment assigned the later challenge to this achievement; the live-game correction distinguishes the ranks.",{627175,677162})
do
    local points={pin(118,69.6,22.8,1,"Mariel Trueheart - initial introduction"),pin(118,76.4,19.4,2,"Alliance pavilion - lessons / Aspirant dailies"),pin(118,76.2,24.2,2,"Horde pavilion - lessons / Aspirant dailies"),pin(118,71.4,19.6,4,"Aspirants' Ring - mounted training"),pin(118,71.4,19.6,5,"Squire David - The Aspirant's Challenge"),pin(118,76.4,19.4,6,"Alliance - turn in and accept city invitation"),pin(118,76.2,24.2,6,"Horde - turn in and accept city invitation")}
    weaponPins(points,3)
    add(2758,"Argent Valor",{
        "Enrol through The Argent Tournament introduction and finish the mounted combat lessons in your faction pavilion. Equip the supplied lance and use the stabled tournament mount; your ordinary travel mount is not the jousting vehicle.",
        "Accept Up to the Challenge and do all available Aspirant dailies: the field-kill task, Learning the Reins and the rotating weapon errand. A full day normally gives five Aspirant's Seals; fifteen are required, so plan multiple daily resets.",
        weapon,
        "For Learning the Reins, use the practice targets and each named vehicle ability required by the quest. "..joust,
        "At fifteen Aspirant's Seals, finish Up to the Challenge and accept The Aspirant's Challenge. Speak to Squire David at the Aspirants' Ring while mounted with the lance equipped, then defeat the summoned Argent Valiant.",
        "Return to the pavilion and finish the promotion/invitation to the city offered to your character. This reaches Valiant and awards Argent Valor. You can begin the next rank's Valiant work as soon as it is offered; you do not need another fifteen Aspirant's Seals for each city.",
    },points,nil,{679417,723801,1293545,weaponSources[1],weaponSources[2],weaponSources[3]})
end

-- champion ID, exalted ID, city, faction, city quest giver, current NPC position,
-- city reputation tabard/vendor/UiMapID/position, per-achievement guide comment.
local cities={
    {2777,2760,"Darnassus","Alliance","Jaelyne Evensong",76.2,19,45579,"Moon Priestess Lasara in Bel'ameth",2239,46.5,70.6,2291684},
    {2778,2761,"Exodar","Alliance","Colosos",76,19.2,45580,"Kadu beside the indoor Exodar flight master",103,54.6,36.8,2291691},
    {2779,2762,"Gnomeregan","Alliance","Ambrose Boltspark",76.4,19.8,45578,"Master Tinker Trini beside Ironforge's flight master",87,55.6,47.8,2291683},
    {2780,2763,"Ironforge","Alliance","Lana Stouthammer",76.4,19.4,45577,"Captain Stonehelm beside Ironforge's flight master",87,55.6,47.8,2291685},
    {2781,2764,"Stormwind","Alliance","Marshal Jacob Alerius",76.4,19.2,45574,"Captain Lancy Revshon below Stormwind's flight-master ramp",84,67.6,72.8,2291690},
    {2783,2765,"Orgrimmar","Horde","Mokra the Skullcrusher",76.4,24.4,45581,"Stone Guard Nargol on Orgrimmar's upper flight-master platform",85,50.4,58.4,2291686},
    {2784,2766,"Sen'jin","Horde","Zul'tore",76,24.4,45582,"Champion Uru'zin on Orgrimmar's upper flight-master platform",85,49.9,58.1,2291687},
    {2785,2767,"Silvermoon City","Horde","Eressea Dawnsinger",76.4,23.8,45585,"Magistrix Nizara in present-day Midnight Silvermoon",2393,69,67.5,2291689},
    {2786,2768,"Thunder Bluff","Horde","Runok Wildmane",76.2,24.4,45584,"Brave Tuho at Thunder Bluff's central flight-master tower",88,46.8,50,702455},
    {2787,2769,"the Undercity","Horde","Deathstalker Visceri",76.4,24.2,45583,"Captain Donald Adams on Orgrimmar's main-gate ramparts",85,56.6,90.2,702451},
}
local function cityRoute(c)
    local steps={
        "Reach Valiant through the Argent Aspiration/Argent Valor introduction. If "..c[3].." is not the first city offered to your character, finish that first city's championship before selecting another. Only ONE city's Valiant training can be active at a time.",
        "Speak to "..c[5].." in the "..c[4].." pavilion at "..c[6]..", "..c[7].." in Icecrown. Accept the invitation to represent "..c[3].." and The Valiant's Charge. Already being Exalted with the city does not replace the tournament training.",
        "Complete that city's available Valiant dailies: the weapon errand, A Valiant's Field Training, The Grand Melee and At the Enemy's Gates. Turn them in for Valiant's Seals and continue after daily resets until you have TWENTY-FIVE. Aspirant's Seals and Champion's Seals are different currencies/items.",
        weapon,
        "For field training, kill the requested eligible Scourge in Icecrown. For At the Enemy's Gates, take a provided campaign mount near the Court of Bones, maintain Defend, use Shield-Breaker on flyers and strip enemy riders' shields before charging. For The Grand Melee, defeat the requested city Valiants in the tournament rings. "..joust,
        "Turn in the twenty-five seals to "..c[5]..", accept The Valiant's Challenge, then speak to Squire Danny at about 68.6, 20.9 while on the tournament mount with the lance equipped. Defeat his summoned Argent Champion; Danny does not start the bout for an ordinary unmounted visitor.",
        "Return to "..c[5].." and turn in the challenge to become Champion of "..c[3]..". Finish A Champion Rises when first offered. You retain earlier city championships when choosing a new Valiant city; the basic Champion achievement does not require Exalted.",
    }
    local points={pin(118,c[6],c[7],2,c[5].." - "..c[3].." Valiant invitation"),pin(118,c[6],c[7],3,"City dailies - 25 Valiant's Seals"),pin(118,75,18,5,"Alliance Valiants' Ring - Grand Melee"),pin(118,75,26,5,"Horde Valiants' Ring - Grand Melee"),pin(118,48.7,71.5,5,"Court of Bones - Enemy's Gates campaign mounts"),pin(118,68.6,20.9,6,"Squire Danny - Valiant's Challenge"),pin(118,c[6],c[7],7,c[5].." - championship turn-in")}
    weaponPins(points,4)
    return steps,points
end
for _,c in ipairs(cities) do
    local steps,points=cityRoute(c)
    add(c[1],"Champion of "..c[3],steps,points,"The usual five-seal daily total makes this a multi-reset stage. If a newly chosen city's dailies are absent, the shared quests may already have been completed that day for the previous city.",{c[13],"https://www.wowhead.com/achievement=2788#comments:id=702657",weaponSources[1],weaponSources[2],weaponSources[3]})
    local exSteps,exPoints=cityRoute(c)
    local rep=c[3]=="Sen'jin" and "Darkspear Trolls" or c[3]=="the Undercity" and "Undercity" or c[3]
    exSteps[#exSteps+1]="Also reach EXALTED with "..rep.." on the character completing this city's championship. You can raise reputation before or after the challenge; both conditions are needed. Tournament dailies and Champion's Writ commendations help top up the bar."
    exSteps[#exSteps+1]="For a repeatable reputation route, buy the physical city tabard ("..c[8]..") from "..c[9].." at "..c[11]..", "..c[12].." on the selected map. The current city purchase is a silver purchase and does not require Exalted or a championship. Check the tabard's own guide if a phased city vendor is missing."
    exSteps[#exSteps+1]="Equip that actual tabard, enter NORMAL Botanica in Netherstorm (71.7, 54.9), and clear enemies/bosses while checking "..rep.." reputation. Use the exit behind Warp Splinter, reset outside and repeat, respecting the instance-entry limit. A transmog appearance alone gives no reputation."
    exSteps[#exSteps+1]="Confirm both Champion of "..c[3].." and Exalted "..rep.." criteria. This awards Exalted Champion of "..c[3].." and its city title. It is one of the five city requirements toward Crusader; Argent Crusade Exalted is a separate final requirement."
    exPoints[#exPoints+1]=pin(c[10],c[11],c[12],9,c[9].." - city reputation tabard")
    exPoints[#exPoints+1]=pin(109,71.7,54.9,10,"Normal Botanica - equipped CITY tabard reputation")
    add(c[2],"Exalted Champion of "..c[3],exSteps,exPoints,"Use the correct reputation: Sen'jin means Darkspear Trolls, and the Undercity quartermaster route uses current Orgrimmar. Darnassus and Silvermoon pins use their usable current Retail vendors.",{ "https://www.wowhead.com/achievement="..c[2].."#comments","https://www.wowhead.com/achievement="..c[1].."#comments:id="..c[13],"https://www.wowhead.com/item="..c[8].."#comments"})
end
for _,alliance in ipairs({true,false}) do
    local side=alliance and "Alliance" or "Horde"
    local names=alliance and "Darnassus, Exodar, Gnomeregan, Ironforge and Stormwind" or "Orgrimmar, Sen'jin, Silvermoon City, Thunder Bluff and the Undercity"
    for _,kind in ipairs({"Champion","Exalted Champion","Exalted Argent Champion"}) do
        local id=kind=="Champion" and (alliance and 2782 or 2788) or kind=="Exalted Champion" and (alliance and 2770 or 2771) or (alliance and 2817 or 2816)
        local steps={
            "Enrol and reach Valiant through the Argent Aspiration/Argent Valor guides. Finish the first city offered to your character, then choose the other cities one at a time. The five "..side.." cities are "..names..".",
            "For EACH city, accept its Valiant invitation, earn twenty-five Valiant's Seals through its dailies, turn in The Valiant's Charge, and defeat Squire Danny's Argent Champion for The Valiant's Challenge. Return for that city's final hand-in before starting another city. Use the individual city guides for the full weapon errands and mounted tasks.",
            "Continue unlocked Champion dailies alongside the currently selected city's Valiant work. Changing cities keeps your previous Champion ranks. Shared dailies already completed that day do not necessarily reappear for the new city; continue after reset.",
        }
        if kind~="Champion" then steps[#steps+1]="Raise all five corresponding CITY reputations to Exalted as well. Each Exalted Champion guide includes the current physical city-tabard seller and repeatable Normal Botanica route. Sen'jin uses Darkspear Trolls reputation. Buying a city mount or merely being Champion is insufficient." end
        if kind=="Exalted Argent Champion" then
            steps[#steps+1]="Reach Exalted with ARGENT CRUSADE in addition to the five Exalted city championships. At Friendly, buy its tabard from Aliocha Segard at Argent Vanguard (87.6, 75.6), equip it and clear eligible original Wrath Heroic dungeons. Argent Dawn and Knights of the Ebon Blade do not substitute."
            steps[#steps+1]="Check all meta criteria for the Crusader title/unlock. Account-wide completed city achievements can contribute, so inspect existing progress before repeating a whole city on an alt. The individual city quest chains and ordinary Champion activities still have their own character progression."
        else
            steps[#steps+1]="Check all five "..(kind=="Champion" and "Champion" or "Exalted Champion").." criteria for the meta. "..(kind=="Champion" and "City Exalted reputations are not required for this basic Champion meta." or "Argent Crusade Exalted is not required until Exalted Argent Champion, the next meta that grants Crusader.")
        end
        local points={}
        for _,c in ipairs(cities) do if c[4]==side then points[#points+1]=pin(118,c[6],c[7],2,c[5].." - "..c[3]) end end
        points[#points+1]=pin(118,68.6,20.9,2,"Squire Danny - city Valiant's Challenge")
        if kind~="Champion" then points[#points+1]=pin(109,71.7,54.9,4,"Normal Botanica - city tabard reputation") end
        if kind=="Exalted Argent Champion" then points[#points+1]=pin(118,87.6,75.6,5,"Aliocha Segard - Argent Crusade tabard");points[#points+1]=pin(117,58.2,48.9,5,"Heroic Utgarde Keep - Argent Crusade tabard reputation") end
        add(id,kind.." of the "..side,steps,points,"Old advice to withhold the fifth championship for daily gold conflicts with completing this achievement. Finish all required city turn-ins. Gilneas, Bilgewater and allied-race cities are not extra criteria.",{ "https://www.wowhead.com/achievement="..id.."#comments","https://www.wowhead.com/achievement=2788#comments:id=702657","https://www.wowhead.com/achievement=2816#comments:id=5494934","https://www.wowhead.com/achievement=2817#comments:id=1762360"})
    end
end
add(2836,"Lance a Lot",{
    "Reach Valiant and accept The Grand Melee. Keep it in your log while working through the TEN racial riders, including both factions. Equip the lance and mount a tournament steed.",
    "Before each challenge, stack Defend to three. Challenge an uncredited Valiant in the Alliance ring (75, 18): Darnassus, Exodar, Gnomeregan, Ironforge and Stormwind. Keep the daily unturned-in even after its required marks are collected so you can continue challenging.",
    "Stay in melee using Thrust until the rider retreats. Charge as soon as you have range, then Shield-Breaker while turning back toward them. Refresh lost Defend stacks. Charging first avoids delaying your charge while the enemy prepares theirs.",
    "Repeat for the five Horde Valiants in their ring (75, 26): Orgrimmar, Sen'jin, Silvermoon, Thunder Bluff and Undercity. Different rider styles may need more circling and Shield-Breaker/Charge opportunities, especially Exodar/Thunder Bluff.",
    "Check all ten race ticks before turning in The Grand Melee. If you handed it in before finishing the list, return when that daily is available again. This achievement is NPC jousting, while Tilted! needs a player duel.",
},{pin(118,75,18,2,"Alliance Valiants - all five cities"),pin(118,75,18,3,"Charge, then Shield-Breaker; maintain Defend"),pin(118,75,26,4,"Horde Valiants - all five cities")},"You do not have to discard daily marks or abandon/reaccept the quest between riders.",{679137,683527,689563,695074})
add(2772,"Tilted!",{
    "Bring another player to the Argent Tournament. Both should complete enough introduction/training to use the stabled tournament mounts, and equip a lance. Winning against an NPC Valiant does not satisfy this player-duel achievement.",
    "Mount up near the tournament jousting rings, build three Defend stacks and use the vehicle's Duel action to challenge your friend. Win by reducing their vehicle's health with Thrust, Shield-Breaker and Charge. Refresh Defend during the duel.",
    "If the vehicle-duel countdown repeatedly dismounts both players, use the reported workaround: start an ordinary /duel on FOOT beside the stabled horses. Wait for the duel to actually begin, then the player needing credit mounts the tournament steed and the other player types /forfeit.",
    "Check the achievement, then swap roles if your friend also needs it. Use the workaround only if the normal mounted duel fails; simply fighting another outdoor player without the tournament vehicle is a different duel.",
},{pin(118,75,18,1,"Tournament stables / Alliance jousting area"),pin(118,75,26,1,"Tournament stables / Horde jousting area"),pin(118,75,18,3,"If countdown dismounts you: start duel on foot, then mount")},nil,{676742,677491,2582662,5164135})
add(2773,"It's Just a Flesh Wound",{
    "Start Crusader Rhydalla's Black Knight investigation at the Argent pavilion (69.5, 23.1). For The Black Knight of Westfall? (Alliance), loot the Dusty Journal inside the house by its fireplace at Westfall 42.1, 69.7. For The Black Knight of Silverpine? (Horde), loot the journal inside the house at Silverpine Forest 53.2, 28.1. Return to Rhydalla.",
    "For The Seer's Crystal, kill Unbound Seers in Forlorn Woods, Crystalsong Forest (about 46, 40), until the crystal drops. The similarly named enemies in the Unbound Thicket are not the indicated farm. Return the crystal.",
    "For The Stories Dead Men Tell, visit the graveyard just east of the tournament (79.5, 23). Investigate the three named graves using the quest interaction/crystal: Sir Wendell Balfour, Lorien Sunblaze and Conall Irongrip. Return after all three credit.",
    "For There's Something About the Squire, kill a Skeletal Woodcutter near Crystalsong 38.3, 59.4 for a Large Femur. Use it on Maloric there to incapacitate him, search him for the Murderer's Toolkit and report back.",
    "For The Black Knight's Orders, use the Enchanted Bridle beside his gryphon at Icecrown 77.76, 21.62. Ride the gryphon to its destination so the ride objective credits, then loot BOTH items inside the house: invitation on a barrel, orders on crates beside the stove. Return to Rhydalla.",
    "Reach Champion rank for a city if the final quest is locked. Accept The Black Knight's Fall, equip the lance and use the STABLED ARGENT WARHORSE near the flight master (about 72.3, 22.5), rather than a racial tournament mount. Speak to Squire Cavin at the Ring of Champions to summon the Black Knight.",
    "Defeat the Black Knight and finish the quest turn-in with Rhydalla for the achievement. If he repeatedly evades at the vehicle transition, the comments' workaround is to dismount immediately after requesting the summon, BEFORE combat activates, equip your real weapon and kill him on foot once attackable. Repeatedly dismounting mid-fight can instead make him evade.",
},{pin(118,69.5,23.1,1,"Crusader Rhydalla - start/return all investigation quests"),pin(52,42.1,69.7,1,"Alliance Westfall journal - inside house by fireplace"),pin(21,53.2,28.1,1,"Horde Silverpine journal - inside house"),pin(127,46,40,2,"Forlorn Woods - Unbound Seers"),pin(118,79.5,23,3,"Three named tournament graves"),pin(127,38.3,59.4,4,"Woodcutters / Maloric - femur and toolkit"),pin(118,77.76,21.62,5,"Black Knight's Gryphon - use Enchanted Bridle"),pin(118,72.3,22.5,6,"Stabled Argent Warhorse - correct vehicle"),pin(118,71.4,23.2,6,"Ring of Champions - Squire Cavin")},"This is the outdoor investigation and quest duel, not the Trial of the Champion dungeon boss. The required city championship is separate from the investigation's earlier stages.",{700412,"https://www.wowhead.com/quest=13641#comments:id=679685","https://www.wowhead.com/quest=13663#comments:id=632415","https://www.wowhead.com/quest=13664#comments:id=2018108","https://www.wowhead.com/quest=13664#comments:id=6289961"})
add(3736,"Pony Up!",{
    "Check Dame Evniki Kapsalis in the Argent pavilion (69.5, 23.2). Her Crusader shop unlock comes from Exalted Argent Champion of the Alliance/Horde, not Argent Crusade Exalted alone. If your account already has Crusader, check the shop before repeating the full tournament grind.",
    "Obtain your Argent Squire (Alliance) or Argent Gruntling (Horde) through A Champion Rises. Save 150 CHAMPION'S Seals from unlocked Champion dailies, their purses and the optional daily Heroic Trial of the Champion clear. Aspirant's and Valiant's Seals cannot buy the bridle.",
    "Buy ARGENT PONY BRIDLE (47541) from Dame Evniki Kapsalis for 150 Champion's Seals. Check the item name: Argent Warhorse and Argent Charger have similar icons and do not award Pony Up!.",
    "USE the consumable bridle from your bags on the character whose squire/gruntling you want to upgrade, then check the achievement. The little pony belongs to that companion; it is not a player mount or an additional Mount Journal collection entry.",
},{pin(118,69.5,23.2,1,"Dame Evniki Kapsalis - Crusader shop"),pin(118,69.6,22.8,2,"Argent pavilion - Champion's Seal activities"),pin(118,75.1,21.8,2,"Trial of the Champion - optional Heroic seals"),pin(118,69.5,23.2,3,"Buy the 150-seal ARGENT PONY BRIDLE")},"Buying alone is not the final action: consume the bridle. The service upgrade has historically been character-specific even though the achievement is account-wide; do not assume every alt's companion gained the services.",{800672,813360,859669,1788434,1803494,5435957})
