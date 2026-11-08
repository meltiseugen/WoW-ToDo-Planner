-- Retail faction routes and current phase access, reviewed 2026-11-05.
local _,TDP=...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label,mapName)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label,mapName=mapName}
end
local function add(id,name,difficulty,reason,steps,points,sources)
    local lines={"Difficulty: "..difficulty:gsub("^%l",string.upper).." - "..reason}
    for i,s in ipairs(steps) do lines[#lines+1]=i..". "..s end
    guides[id]={achievementId=id,name=name,category="Reputation",sourceType="Achievement",source=name,
        difficulty=difficulty,difficultyReason=reason,acquisition=table.concat(lines,"\n\n"),stepCount=#steps,
        waypoints=points or {},sources=sources or {},reviewedAt="2026-11-05",
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local factions={
    {4881,"The Earthen Ring",205,49,42,"Provisioner Arok",
        "Complete Earthen Ring quests in Vashj'ir and Deepholm to reach Friendly. Arok is in Silver Tide Hollow, an air-filled cave in Shimmering Expanse; approach through the underwater cave entrance, not the surface directly above the pin.",1357681},
    {4882,"Guardians of Hyjal",198,62.8,23.8,"Provisioner Whitecloud",
        "Follow the present-day Mount Hyjal storyline from Nordrassil. Its quests provide Guardians reputation and unlock later Sanctuary of Malorne dailies. This is the outdoor Hyjal faction, not the Scale of the Sands faction in the Caverns of Time raid.",1369259},
    {4883,"Therazane",207,56.8,13.2,"D'lom the Collector",
        "Complete Deepholm's Temple of Earth, Earthen and World Pillar storyline until Therazane becomes friendly and her northern Throne offers the quartermaster and dailies. Flying to the Throne on a new character does not replace that quest-chain unlock.",1074807},
    {4884,"Ramkahen",249,54,33.2,"Blacksmith Abasi",
        "Use original Uldum, selecting the earlier phase with Zidormi near 56.0, 35.1 when needed. Complete the Ramkahen/Neferset story to Friendly. Harrison Jones's separate expedition is not the main Ramkahen reputation source; Uldum Accord is a different faction.",1236999},
    {4885,"Wildhammer Clan",241,48.6,30.5,"Craw MacGraw",
        "Use an ALLIANCE character and follow Twilight Highlands' Alliance introduction through the Wildhammer settlements and Thundermar. Complete the local story if Craw is hidden by an attack phase; the quartermaster is in Thundermar's inn area.",1081529},
    {4886,"Dragonmaw Clan",241,53.8,42,"Grot Deathblow",
        "Use a HORDE character and complete Twilight Highlands' Horde introduction, Dragonmaw Port storyline and Bloodgulch quests. Grot is in Bloodgulch, not Outland's hostile Dragonmaw camps.",1077403},
}
for _,r in ipairs(factions) do
    local points={pin(r[3],r[4],r[5],2,r[6].." - "..r[2].." tabard"),pin(249,60.5,64.4,3,"Lost City of the Tol'vir - Normal championing route")}
    if r[1]==4884 then points[#points+1]=pin(249,56,35.1,1,"Zidormi - original Uldum") end
    add(r[1],r[2],"medium","Unlock the Friendly tabard and earn Exalted through quests and eligible dungeon kills.",{
        r[7],
        "At FRIENDLY, visit "..r[6].." at the marked location and buy Tabard of "..(r[1]==4881 and "the Earthen Ring" or r[1]==4882 and "the Guardians of Hyjal" or r[1]==4885 and "the Wildhammer Clan" or r[1]==4886 and "the Dragonmaw Clan" or r[2])..". EQUIP it before entering a reputation-granting dungeon.",
        "Use an original Cataclysm dungeon such as NORMAL Lost City of the Tol'vir in Uldum. Kill reputation-granting trash and bosses and inspect the reputation log to confirm the equipped tabard is awarding "..r[2]..". This avoids the seasonal Mythic reworks of other old dungeons.",
        "Leave, reset the Normal instance and repeat within the game's entry limit, keeping the tabard equipped. A killed Heroic boss uses its daily lockout and Reset All Instances cannot restore it. Complete unlocked faction quests/dailies as an alternative while travelling.",
        "Stop at EXALTED and check the achievement. Buying a tabard or a reputation reward alone does not finish the reputation bar, and a later expansion's tabard converts reputation to a different faction.",
    },points,{"https://www.wowhead.com/achievement="..r[1].."#comments:id="..r[8],"https://www.wowhead.com/achievement=4884#comments:id=2568234"})
end
for _,r in ipairs({{5375,"Baradin's Wardens","Alliance",72.5,62.6},{5376,"Hellscream's Reach","Horde",54.5,80.7}}) do
    add(r[1],r[2],"medium","A repeated daily-quest reputation with extra opportunities while your faction controls Tol Barad.",{
        "Use a "..r[3].." character. Take the capital's Tol Barad portal and visit your faction camp on TOL BARAD PENINSULA. Accept its daily quests; they are available even when the enemy controls the southern PvP island.",
        "Complete the Peninsula objectives and return for the hand-ins. The offered variants rotate, so follow today's quest log rather than a fixed old list. These hand-ins are the steady reputation route.",
        "When your faction controls TOL BARAD, cross to the southern island and collect the bonus dailies near Baradin Hold. Complete the fixed quests and the currently open prison wing's three quests, then turn them in before the relevant access changes.",
        "If you participate in Tol Barad battles, winning also awards reputation and may change the prison quest rotation. Already completed daily variants do not become infinitely repeatable after another win. Repeat available quests after daily resets until EXALTED.",
        "Check the faction reputation achievement. The Tol Barad tabard is a commendation-purchased teleport item, not a dungeon championing tabard; repeatedly killing dungeon trash while wearing it is not this reputation route.",
    },{pin(245,r[4],r[5],1,r[2].." - Peninsula daily camp"),pin(244,51.4,49.6,3,"Tol Barad - controlling faction's outdoor daily hub")},
    {"https://www.wowhead.com/achievement="..r[1].."#comments:id="..(r[1]==5375 and 1375910 or 1688640)})
end
add(5827,"Avengers of Hyjal","medium","Repeated Firelands boss kills; the final reputation point needs care.",{
    "Enter original Firelands from Mount Hyjal (47.2, 78.1). This is the AVENGERS of Hyjal raid faction. Sanctuary of Malorne and Molten Front dailies instead award Guardians of Hyjal reputation.",
    "Kill and loot the raid's trash before clearing bosses. Ordinary trash stops awarding reputation at 5,999/6,000 Friendly. Larger eligible creatures such as Molten Lords, Ancient Core Hounds and harder inner trash can continue toward 11,999/12,000 Honored.",
    "Once trash no longer advances the bar, clear Firelands bosses: Shannox, Beth'tilac, Rhyolith, Alysrazor, Baleroc, Staghelm and Ragnaros. Use HEROIC for the stronger boss reputation and final point. Run each eligible Normal/Heroic lockout after weekly resets; changing the old 10/25 selector is not extra loot or reputation.",
    "At 20,999/21,000 Revered, kill a HEROIC boss to cross into Exalted. If solo credit still sticks there, a September 2026 comment reports that support's working fix was to enter in a raid with one other player and kill a boss together. Verify the final point rather than continuing an ineffective trash farm.",
    "Confirm Exalted and the Avengers of Hyjal achievement/title. A tabard does not grant this reputation from unrelated dungeons, and Molten Front daily progress does not substitute for Firelands kills.",
},{pin(198,47.2,78.1,1,"Original Firelands - Avengers reputation"),pin(367,49.3,44.31,3,"Shannox - first raid boss route","Firelands")},
{"https://www.wowhead.com/achievement=5827#comments:id=1464855","https://www.wowhead.com/achievement=5827#comments:id=1478662","https://www.wowhead.com/achievement=5827#comments:id=1518977","https://www.wowhead.com/achievement=5827#comments:id=6384868"})
for _,r in ipairs({{5374,"45 Exalted Reputations",45},{5723,"50 Exalted Reputations",50}}) do
    add(r[1],r[2],"hard","Many separate reputation grinds, including time-gated factions.",{
        "Track "..r[2].." and check its live distinct-faction total. Make a list of factions already close to Exalted; another copy of the same faction on an alt is not a new unique reputation. Use the current tracker when combining Warband progress.",
        "Fill quick dungeon reputations: wear city tabards for eligible city reputation, use the four original Northrend championing tabards, and use the six Cataclysm championing factions. At Friendly buy the matching tabard, equip it, and verify the kill log awards the intended faction before repeating a dungeon.",
        "Add original Outland dungeon factions through their own dungeons: Cenarion Expedition in Coilfang, Lower City in Auchindoun, Sha'tar in Tempest Keep dungeons, and Keepers of Time in the Caverns of Time. A Cataclysm tabard is not a substitute for these factions' default dungeon reputation.",
        "Use raid clears for Hydraxian Waterlords, Brood of Nozdormu, Violet Eye, Ashtongue, Ashen Verdict and Avengers of Hyjal. Observe each faction's trash cap and finish the remaining bar with eligible bosses or its required turn-ins. Combine these with your weekly mount and legendary routes.",
        "Fill remaining slots with currently available daily factions, such as Ramkahen, Therazane, Tol Barad, Kalu'ak and later-expansion factions. Keep their hand-in schedule and actual reputation bars visible; retired factions and an old mutually exclusive counterpart need not be part of the route.",
        "Continue until the live counter reaches "..r[3]..". Rank/renown displays from later systems do not automatically mean that an Exalted criterion counted; verify each planned addition rather than assuming every reputation UI bar contributes.",
    },{pin(249,54,33.2,2,"Ramkahen - championing tabard"),pin(207,56.8,13.2,2,"Therazane - tabard after campaign"),pin(118,53.5,85.5,4,"ICC - Ashen Verdict"),pin(198,47.2,78.1,4,"Firelands - Avengers of Hyjal")},
    {"https://www.wowhead.com/achievement=5374#comments","https://www.wowhead.com/achievement=5723#comments"})
end
add(5794,"Time Flies When You're Having Fun","easy","A personal guild-reputation milestone from normal questing.",{
    "Join the guild in which you want to earn this PERSONAL reputation achievement and inspect that character's guild reputation. The achievement is personal even though its subject is a guild; it does not require a guild achievement or guild raid.",
    "Complete ordinary reputation-granting quests while remaining in the guild. At Friendly buy and wear the Illustrious Guild Tabard for its reputation bonus; at Honored the Renowned Guild Tabard offers the larger bonus.",
    "Continue quest hand-ins to EXALTED and check the achievement. The old weekly guild-reputation cap was removed; do not wait for a weekly reset because of launch-era cap comments.",
},{pin(84,64.6,76.8,2,"Shay Pressler - guild reputation tabards"),pin(85,48.2,75.6,2,"Goram - guild reputation tabards")},
{"https://www.wowhead.com/achievement=5794#comments:id=1477210","https://www.wowhead.com/achievement=5794#comments:id=1715487"})
