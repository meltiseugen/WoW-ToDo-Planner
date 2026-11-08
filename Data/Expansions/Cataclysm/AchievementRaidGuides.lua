-- Retail raid walkthroughs reviewed 2026-11-04. Numbered profit guides are
-- reconciled with their replies, recent Retail reports and the existing mount
-- routes; original level-85 DPS, gear and class requirements are not retained.
local _, TDP = ...
local guides = TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label,mapName)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label,mapName=mapName}
end
local function add(id,name,difficulty,reason,steps,waypoints,comments,tips,replies)
    local lines={"Difficulty: "..difficulty:gsub("^%l",string.upper).." - "..reason}
    local sources={}
    for i,s in ipairs(steps) do lines[#lines+1]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]="https://www.wowhead.com/achievement="..id.."#comments:id="..c end
    guides[id]={achievementId=id,name=name,category="Raids",sourceType="Achievement",source=name,
        difficulty=difficulty,difficultyReason=reason,acquisition=table.concat(lines,"\n\n"),stepCount=#steps,
        waypoints=waypoints or {},tips=tips,sources=sources,sourceComments=comments,sourceReplyIds=replies,
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local bwd=pin(36,26.1,23.8,1,"Blackwing Descent - high OUTSIDE balcony","Burning Steppes")
local bastion=pin(241,34.2,78,1,"Bastion of Twilight - high spire summit","Twilight Highlands")
local winds=pin(249,38.4,80.6,1,"Throne of the Four Winds - airborne raid entrance","Uldum")
local firelands=pin(198,47.2,78.1,1,"Firelands - raid entrance","Mount Hyjal")
local soul=pin(71,64.4,50,1,"Caverns of Time - descend to Dragon Soul","Tanaris")
local hold=pin(244,47.5,39,1,"Baradin Hold - controlling faction's raid entrance","Tol Barad")

local approach={
    bwd="Fly to Blackwing Descent's high balcony on the EASTERN OUTSIDE face of Blackrock Mountain. Enter the raid there; the inner mountain's chains lead to different instances. Defeat Magmaw and Omnotron to open the lower wing, then clear the side laboratories to access Nefarian.",
    bastion="Fly to the portal at the TOP of the very tall southwestern Twilight Highlands spire. Follow Halfus, Valiona/Theralion, Ascendant Council and Cho'gall in order. On Heroic, Cho'gall opens the floor to the additional Sinestra encounter.",
    winds="Fly to the airborne Throne of the Four Winds portal off southwestern Uldum. The first encounter occupies three connected platforms: Anshal, Nezir and Rohash. Use their wind bridges; after all three are defeated the central route to Al'Akir opens.",
    firelands="Enter Firelands from southern Mount Hyjal. Clear enough Molten Fields trash to spawn Shannox. Defeat Shannox, Beth'tilac, Rhyolith, Alysrazor and Baleroc to open the bridge, then Staghelm to reach Ragnaros. Verify Heroic again INSIDE if earning Heroic kills.",
    soul="Enter Dragon Soul through the northeast raid portal INSIDE the Caverns of Time in Tanaris. Its outdoor Wyrmrest Temple counterpart is not the entrance. Defeat Morchok, Zon'ozz and Yor'sahj, use the temple transports for Hagara, return to the summit and speak to Thrall through the drake-defense dialogue to unlock Ultraxion and the Skyfire.",
}
local nefarian="Jump into the pit, let Nefarian join Onyxia, then defeat Onyxia to start the lava transition. Climb a pillar and kill the Chromatic Prototype, interrupting its casts if necessary. Wait for the lava to recede and Nefarian to LAND, then defeat him. For Keeping it in the Family, first lower Nefarian below half health while Onyxia is still alive."
local sinestra="After Heroic Cho'gall, drop through the broken floor to Sinestra. Damage her into the shield phase, stay away from Calen so pools do not kill the friendly NPC, and handle the summoned whelps. Keep damaging her shield until the message says the Pulsing Twilight Eggs' barriers dissipate, then kill BOTH eggs beside her and finish Sinestra."
local conclave="Kill all three wind lords within their recovery window, using the bridges between platforms. A high-level solo route is Anshal first, Nezir second and Rohash last; stay until each boss is actually down before leaving its platform. If one revives, bring it down again before the others recover."
local spine="On Spine, kill three Corruption tentacles and leave one alive. Anchor in a dead tentacle's hole with Grasping Tendrils for a planned roll to discard unwanted Amalgamations. Kill Corrupted Bloods, keep ONE Hideous Amalgamation alive and lead it across the blood residue until its Absorbed Blood is at NINE stacks. Current Heroic can supply all nine from a single residue, so inspect its buff rather than counting nine bodies."
local plate="Bring that nine-stack Amalgamation directly against the next HEADWARD armor plate, then kill it there. Its Nuclear Blast lifts the plate: immediately kill the exposed Burning Tendon. Repeat for all three plates. Between planned rolls, alternate left/right to cancel the roll warning or remain anchored in a hole; an unanchored completed roll throws you off."
local madness="At the Maelstrom, speak to Thrall. Visit all four Aspect platforms using their wind jumps and defeat each large limb and Mutated Corruption. Return to the starting platform for Deathwing's head, finish the encounter and open the Greater Cache. For a Heroic Madness kill, clear the preceding Dragon Soul encounters on Heroic in the same progression."

-- Boss positions: current Retail JournalEncounter Map_0/Map_1 and UiMapID.
-- Each Heroic achievement's own comment list was read; most old comments are
-- progression-era ability explanations rather than numbered acquisition guides.
local heroicBosses={
    {5094,"Magmaw","bwd",285,27.54,57.49,"Attack Magmaw at the lava edge and kill him directly at high level. If the encounter lasts, move out of Pillar of Flame and the Heroic construct meteors, kill the constructs before their Armageddon finishes, and use the exposed-head phase when available.",{1284839,1337867}},
    {5107,"Omnotron Defense System","bwd",285,65.47,57.49,"Attack the active construct and kill the shared-health encounter. If more constructs activate, switch away from a shielded construct, interrupt Arcanotron and avoid Toxitron's poison bombs; high-level burst can end the encounter before those overlaps.",{1326496}},
    {5108,"Maloriak","bwd",286,71.46,70.21,"Defeat Maloriak in his laboratory. If collecting Aberrant Behavior at the same time, leave him alive while twelve Aberrations spawn and kill those together first. Heroic's black phase adds Vile Swill; clear them and avoid their pools if you cannot burst the boss immediately.",{1326503}},
    {5109,"Atramedes","bwd",286,47.50,32.78,"Activate Atramedes through the room's event and kill him while avoiding sound discs and fire. Use an available gong if sound is getting dangerous, and kill an Obnoxious Fiend promptly if one appears. A high-level fast kill avoids the old lengthy sound-management cycle.",{1326480}},
    {5115,"Chimaeron","bwd",286,24.55,70.21,"Speak to Finkle Einhorn and activate the Bile-O-Tron before starting Chimaeron. Kill the boss directly at high level. If the fight lasts through Massacre, heal above the robot's survival threshold rather than assuming the robot itself restores health.",{1279596,1393832}},
    {5116,"Nefarian","bwd",286,48.00,70.21,nefarian,{1683814},"medium"},
    {5118,"Halfus Wyrmbreaker","bastion",294,53.49,19.31,"Defeat Halfus in the first hall. At high level direct damage is enough; if also doing The Only Escape, release two drakes and kill them within ten seconds of each other BEFORE Halfus dies. Ignore old level-85 tank-swap and gear thresholds.",{}},
    {5117,"Valiona and Theralion","bastion",294,53.99,78.44,"Defeat the shared-health dragon pair after Halfus. For Double Dragon, delay the kill until you have entered the Twilight Realm and killed six Twilight Fiends. Otherwise a high-level direct kill is sufficient for the Heroic boss achievement.",{}},
    {5119,"Ascendant Council","bastion",295,42.51,45.51,"Damage both members of the first pair, then both of the second pair, and wait for them to combine. Kill the Elementium Monstrosity, the actual final target. For Elementary, stand near the central circle beforehand and do not drag that final form through multiple ice pools.",{1384395}},
    {5120,"Cho'gall","bastion",295,73.45,75.45,"Clear both nearby trash groups, pull Cho'gall to the CENTER and let combat initialize before finishing him. Stay until he actually dies and breaks the floor. Recent 2026 comments report both a death-script bug and a later successful normal kill sequence; a temporary script failure is not permanent removal.",{1158106,1410498,6389605,6404698}},
    {5121,"Sinestra","bastion",296,49.00,34.28,sinestra,{2445428,2527637},"medium"},
    {5122,"Conclave of Wind","winds",328,47.50,26.05,conclave,{2020410},"medium"},
    {5123,"Al'Akir","winds",328,47.50,50.00,"Use the central wind route after the Conclave. Damage Al'Akir through his transitions and finish him after the flight phase if he survives. If also doing Four Play, stop in phase two and kill a Stormling NEXT TO HIM so Feedback is active before the final kill.",{1385346,2328874}},
    {5806,"Shannox","firelands",367,49.30,44.31,"Spawn Shannox by clearing trash. Kill Rageface first if his pin prevents you from acting, then finish Shannox. For Bucket List, preserve Shannox and take him through all five named areas first; killing him early ends that opportunity in this run.",{1458560,2103287,2248619}},
    {5807,"Beth'tilac","firelands",367,21.06,32.78,"Engage Beth'tilac, kill a hanging Cinderweb Spinner and click its web strand to reach her canopy. Damage her there, follow her down if she transitions and finish her. For Death from Above, preserve every Cinderweb Drone on the lower floor.",{3246214}},
    {5808,"Lord Rhyolith","firelands",367,65.37,75.00,"Attack Rhyolith's RIGHT foot until his armor phase ends, then target and kill his BODY yourself. A foot's defeat alone is not the boss kill, and letting a pet kill the body before you tag it has caused missed credit in comments.",{2092013,2489595}},
    {5809,"Alysrazor","firelands",367,64.37,38.02,"Clear the approach and wait for the Staghelm opening scene to finish. Attack Alysrazor when she is engaged; a high-level ranged burst can end the fight before the flying and tornado phases. If it lasts, avoid the fire hazards and use feather flight only when needed.",{1510858,2489596}},
    {5805,"Baleroc","firelands",367,49.50,30.99,"Clear the packs in front of Baleroc and kill him directly. Avoid repeatedly taking crystal Torment if the fight lasts. His defeat opens the bridge toward Staghelm; do not skip the bridge event and search the wrong side of the map.",{2098293,2489597}},
    {5804,"Majordomo Fandral Staghelm","firelands",369,51.00,72.46,"Cross Baleroc's bridge and STOP before clearing the flame-casting druids if you still need Only the Penitent. Complete the two-orb interaction first, then clear the druids and kill Staghelm. Verify that the instance remains Heroic inside.",{2489598}},
    {5803,"Ragnaros","firelands",369,50.75,15.38,"Clear the preceding Firelands bosses on Heroic and proceed beyond Staghelm. Damage Ragnaros, kill the Sons of Flame during hammer intermissions, and wait through his apparent defeat at low health. On Heroic he grows legs and returns for the final phase: kill THAT form for actual Heroic credit.",{1473555,1869966,2463223,2489600},"medium"},
    {6109,"Morchok","soul",409,50.40,69.25,"Kill Morchok on the approach to Wyrmrest Temple. At high level burst him before the split or Black Blood phase; if the fight lasts, handle the two Heroic copies and hide behind the stone fragments during Black Blood.",{}},
    {6110,"Warlord Zon'ozz","soul",410,50.96,53.03,"Use the transport to the Maw of Go'rath and defeat Zon'ozz. If also doing Ping Pong Champion, delay the kill until the Void orb has bounced ten times off players. Return through the available transport after the kill.",{}},
    {6111,"Yor'sahj the Unsleeping","soul",411,46.83,49.93,"Use the transport to the Maw of Shu'ma and defeat Yor'sahj. For Taste the Rainbow!, keep him alive through the required ooze-color combinations before finishing him. The room's initial trash slimes are not those encounter waves.",{}},
    {6112,"Hagara the Stormbinder","soul",412,52.75,52.05,"After the two lower bosses, take Wyrmrest's transport and the Eye of Eternity portal to Hagara. Start the encounter and kill her. If a shield phase occurs, complete its ice crystals or lightning-conductor mechanic before resuming boss damage; return to the temple when finished.",{}},
    {6113,"Ultraxion","soul",409,50.03,45.81,"Return to Wyrmrest's summit, speak to Thrall and complete the Twilight drake-defense event. Wait through the dialogue until Ultraxion is actually attackable, then kill him. Loot the Lesser Cache and use the next dialogue to proceed to the Skyfire.",{}},
    {6114,"Warmaster Blackhorn","soul",413,48.15,17.18,"Board the Skyfire and start its defense. Kill the approaching drakes, boarding adds and Twilight Sappers while keeping the ship alive. When Goriona and Blackhorn arrive, bring the dragon into reach and finish the encounter. Ranged attacks help with the airborne targets.",{}},
    {6115,"Spine of Deathwing","soul",414,33.21,85.26,spine.." "..plate,{2474766,2479679,2871135,6138689,6142127,6151155},"hard"},
    {6116,"Madness of Deathwing","soul",415,47.87,53.85,madness,{1709303,2178730},"medium"},
}
local entrances={bwd=bwd,bastion=bastion,winds=winds,firelands=firelands,soul=soul}
local floorNames={
    [285]="Blackwing Descent - Broken Hall",[286]="Blackwing Descent - Vault of the Shadowflame",
    [294]="Bastion of Twilight - Twilight Enclave",[295]="Bastion of Twilight - Throne of the Apocalypse",
    [296]="Bastion of Twilight - Twilight Caverns",[328]="Throne of the Four Winds",[367]="Firelands",
    [369]="Firelands - Sulfuron Keep",[409]="Dragon Soul - Dragonblight",[410]="Dragon Soul - Maw of Go'rath",
    [411]="Dragon Soul - Maw of Shu'ma",[412]="Dragon Soul - Eye of Eternity",[413]="Dragon Soul - Skyfire",
    [414]="Dragon Soul - Spine of Deathwing",[415]="Dragon Soul - Maelstrom",
}
for _,b in ipairs(heroicBosses) do
    add(b[1],"Heroic: "..b[2],b[9] or "easy",b[9] and "The legacy encounter still requires its scripted phases or coordinated movement." or "A high-level legacy boss kill after reaching the correct Heroic instance.",{
        "Set the legacy raid to HEROIC before entry. "..approach[b[3]], b[7],
        "Finish the actual encounter and verify Heroic: "..b[2].." before leaving. A Normal or Raid Finder kill does not satisfy this criterion, and old progression-era DPS or item-level targets are unnecessary at high level.",
    },{entrances[b[3]],pin(b[4],b[5],b[6],2,b[2].." - Heroic encounter",floorNames[b[4]])},b[8])
end

add(4849,"Keeping it in the Family","hard","Control Nefarian's health before Onyxia dies, then wait for the final landing.",{
    "Enter Blackwing Descent on Normal or Heroic and clear to Nefarian. Disable automatic damage, pets and procs before the final pit. Jump down and engage Onyxia WITHOUT killing her; wait for Nefarian to land and join the fight.",
    "Carefully lower NEFARIAN below 50% while Onyxia is still alive. Aim for roughly 40-45% to remove ambiguity, then stop attacking him. Use controlled damage or a suitable helper if an ungeared hit would kill him.",
    "Kill Onyxia and complete the lava phase: climb the pillars, kill their Chromatic Prototypes and interrupt casts if needed. Keep Nefarian alive through this transition.",
    "Wait for the lava to recede and Nefarian to return to the floor for the final confrontation, then kill him. This adapts the numbered profit guide's actual kill sequence while omitting the profit phrase; all three replies confirm the sequence.",
},{bwd,pin(286,48,70.21,2,"Nefarian - below 50% BEFORE Onyxia dies",floorNames[286]),pin(286,48,70.21,4,"Nefarian - kill AFTER final landing",floorNames[286])},{2209364},nil,{892890,898497,903515})

add(4852,"Double Dragon","medium","Enter the Twilight Realm and find six small moving fiends without killing the dragon pair early.",{
    "Enter Bastion of Twilight on Normal or Heroic, defeat Halfus and reach Valiona and Theralion. Disable damaging procs, retaliation and pets; start Valiona with a non-damaging pull.",
    "Wait for Theralion's Dazzling Destruction and stand in one of its purple ground effects to enter the Twilight Realm. Preserve the bosses throughout; the goal is six Twilight Fiends, not a quick dragon kill.",
    "Use /target Twilight Fiend, turn on nameplates and search both ends of the room. Fiends move quickly and can despawn, so kill each with a precise ranged single-target attack. Clear your target afterward to avoid automatically attacking a dragon. You can remain inside for all six rather than leaving after three.",
    "After six qualifying fiends are credited, leave through a realm portal if needed and finish the dragons. If you have already completed the boss-kill portion on that character, credit may appear on the sixth fiend; otherwise stay for the kill.",
},{bastion,pin(294,53.99,78.44,2,"Valiona / Theralion - Twilight Realm entry",floorNames[294]),pin(294,53.99,78.44,3,"Search the realm for six moving Twilight Fiends",floorNames[294])},{1333831,2072364,2079083,2478995,3229934,5678300,5779079,6016379})

add(5300,"The Only Escape","easy","Release and kill two drakes close together before killing Halfus.",{
    "Enter Bastion of Twilight on Normal or Heroic and stop at Halfus. Start the encounter without killing him; disable passive damage and pets if necessary.",
    "Interact with one of the available captive drakes to release it, then release a SECOND drake. Keep both alive until they are together. Do not mistake the boss's own death for the required drake kills.",
    "Kill both released drakes within TEN seconds of each other, then kill Halfus. This follows the highly rated numbered profit guide and its confirming replies, with the final filler lines omitted.",
},{bastion,pin(294,53.49,19.31,2,"Halfus - release two drakes",floorNames[294])},{2065537},nil,{833346,898367,1114222})

add(5304,"Stay Chill","medium","Maintain seven Wind Chill stacks while completing all three wind-lord kills in their recovery window.",{
    "Enter Throne of the Four Winds on Normal or Heroic. Go to Nezir's northern platform, engage without damaging him and wait for Wind Chill. Every player needing credit must have at least SEVEN stacks when the encounter finishes.",
    "At high level, gather seven stacks first, then quickly cross to one outer boss and defeat it. Return through Nezir's platform to refresh Wind Chill, cross to the other outer boss and defeat it, then return to Nezir and kill him before either outer boss recovers. Use movement abilities and keep watching your own stack duration.",
    "If an outer lord revives before you finish, bring it down again while retaining the stacks; a recovered boss is not a completed kill. A helper covering an outer platform simplifies the timing, but that helper must also visit Nezir for their own stacks.",
    "Avoid Rohash's Wind Blast during the crossings. Do not remove Wind Chill with an immunity, and do not kill Nezir before the stack setup is complete. Confirm credit after all three lords are defeated.",
},{winds,pin(328,47.50,26.05,1,"Nezir - build and refresh seven Wind Chill stacks",floorNames[328])},{2028316,2427092,2853731,2871106,5711693,6134533})

add(5305,"Four Play","hard","Reach Al'Akir's Stormling phase without overshooting it, then kill him with Feedback active.",{
    "Enter Throne of the Four Winds on Normal or Heroic, defeat the Conclave and use its central wind route to Al'Akir. Disable pets, procs and automatic damage before pulling him.",
    "Carefully reduce Al'Akir into phase two, roughly 65-70% in the recent successful guide, then STOP. Do not push him into the final flight phase before a Stormling has spawned. A lower-level helper or damage-reduction toy can be needed even after removing gear.",
    "Wait for a Stormling, move it next to Al'Akir and kill the ADD there. Inspect Al'Akir's debuffs and verify Feedback is present; killing the add too far from him does not apply it.",
    "Immediately finish Al'Akir before Feedback expires, including the flight transition if it occurs. Do not kill the boss merely because an add died: the debuff must actually be on him. The preferred recent profit comments and their replies emphasize controlling damage rather than using old fixed hit counts.",
},{winds,pin(328,47.50,50,2,"Al'Akir - preserve phase two",floorNames[328]),pin(328,47.50,50,3,"Kill a nearby Stormling; verify Feedback",floorNames[328])},{2028318,6123448,6288840},nil,{1812421,1866590})

add(5306,"Parasite Evening","easy","Defeat Magmaw without any player being infected by a Lava Parasite.",{
    "Enter Blackwing Descent on Normal or Heroic and clear Magmaw's approach. At a high Retail level, kill him directly before Pillar of Flame produces parasites.",
    "If he survives, move out of each Pillar of Flame warning. Kill spawned Lava Parasites from range before they contact players; do not deliberately let them attach to you to start an add phase.",
    "Finish Magmaw with no infection on any raid member and check credit. A quick kill before parasites exist meets the condition.",
},{bwd,pin(285,27.54,57.49,1,"Magmaw - prevent parasite infections",floorNames[285])},{})

add(5307,"Achieve-a-tron","easy","Burst the construct encounter or avoid four specific failures across its kills.",{
    "Enter Blackwing Descent and select the active Omnotron construct. At high level, kill the shared-health encounter directly before the four failure mechanics develop.",
    "If the fight lasts, stop attacking Electron while Unstable Shield is up to prevent Static Shock; kite and kill Toxitron's Poison Bombs before contact; interrupt every Arcanotron Arcane Annihilator; and keep Magmatron's Flamethrower line on only its marked target.",
    "Defeat the system and inspect the four criteria. They can be completed across separate victories, so a later run can finish a missing condition without invalidating previously completed ones.",
},{bwd,pin(285,65.47,57.49,1,"Omnotron - four mechanic criteria",floorNames[285])},{1169601,1234495,1280625,6234325})

add(5308,"Silence is Golden","easy","Keep every player's sound bar at or below 50% until Atramedes dies.",{
    "Enter Blackwing Descent, clear to Atramedes and start the room's event. Defeat him quickly at high level before substantial sound builds up.",
    "In a longer attempt, dodge the moving sound discs, breath and fire. Use an available room gong before any player's sound goes OVER 50%; do not wait for the normal encounter's lethal 100% threshold.",
    "Finish Atramedes with every raid member within that sound limit. On Heroic, also kill Obnoxious Fiends promptly because their casts increase sound.",
},{bwd,pin(286,47.50,32.78,2,"Atramedes - sound must not exceed 50%",floorNames[286])},{})

add(5309,"Full of Sound and Fury","easy","Defeat Chimaeron with no more than two raid-member deaths.",{
    "Enter Blackwing Descent and reach Chimaeron. Speak to Finkle Einhorn and activate the Bile-O-Tron before pulling; its survival effect helps if the fight lasts through Massacre.",
    "Kill Chimaeron directly at high level. For a longer fight, heal players above the robot's survival threshold after Massacre and finish the final burn before deaths accumulate.",
    "The current criterion allows NO MORE THAN TWO raid-member deaths. A death-free kill is simplest, but one or two deaths do not by themselves invalidate the achievement. Check credit at the end.",
},{bwd,pin(286,24.55,70.21,1,"Chimaeron - at most two raid-member deaths",floorNames[286])},{})

add(5310,"Aberrant Behavior","medium","Gather twelve living Aberrations, then kill them within ten seconds while Maloriak remains alive.",{
    "Enter Blackwing Descent on Normal or Heroic and reach Maloriak. Disable attacking pets, damage shields, procs and automatic area damage. Engage him without attacking.",
    "Let Release Aberrations complete repeatedly; each release adds three. Wait until at least TWELVE Aberrations are alive, usually a few minutes. This avoids the risk of trying to lower Maloriak to an old percentage threshold and accidentally killing him.",
    "While Maloriak is occupied with a cast, move the gathered adds away from him and kill all twelve with your own area damage inside ten seconds. Keep the boss outside the attack until the add criterion is done.",
    "Finish Maloriak and verify the achievement. If you accidentally kill too many adds individually, reset the living boss before using a saved kill; the required burst is twelve together, not twelve across the whole fight.",
},{bwd,pin(286,71.46,70.21,2,"Maloriak - allow twelve Aberrations to spawn",floorNames[286])},{5299063,6234328,6328647})

add(5311,"Elementary","medium","Keep the final Monstrosity still so it creates only one Liquid Ice pool.",{
    "Enter Bastion of Twilight and reach Ascendant Council. Clear the room, then position near the EDGE of the central purple circle before the final combination; standing exactly on the final spawn can make the boss step back and create another pool.",
    "Damage both members of the first pair together, then both of the second pair. Let the scripted combination finish while you remain in position. Balanced damage leaves less health on the final Elementium Monstrosity.",
    "When the Monstrosity appears, wait for its first Liquid Ice circle, then kill it promptly WITHOUT moving it. Keep other players from pulling it around the room. The condition concerns the number of ice pools, not surviving their damage.",
},{bastion,pin(295,42.51,45.51,1,"Council - prepare near edge of central circle",floorNames[295]),pin(295,42.51,45.51,3,"Monstrosity - keep stationary for one ice pool",floorNames[295])},{1688121,2086268,2477241,3233228,3251943})

add(5312,"The Abyss Will Gaze Back Into You","easy","Keep every player's Corrupted Blood below 30 before finishing Cho'gall.",{
    "Enter Bastion of Twilight and clear to Cho'gall. If only this special achievement is needed, Normal avoids the Heroic death-script issue reported in recent comments. Clear his surrounding trash before starting.",
    "Pull Cho'gall toward the center, let combat register and kill him promptly before anyone's Corrupted Blood reaches 30. Do not wait for corruption merely to prove the mechanic occurred.",
    "If the fight lasts, avoid the adherents' corrupting attacks, interrupt their casts and kill the final-phase tentacles promptly. Stay near the boss and use your own damage rather than letting a remote taunting pet complicate the encounter. Wait for his actual death and credit.",
},{bastion,pin(295,73.45,75.45,2,"Cho'gall - keep Corrupted Blood below 30",floorNames[295])},{1169615,6392167})

add(5799,"Only the Penitent...","hard","Precise orb interactions and kneeling matter; a helper makes the timing much easier.",{
    "Enter Firelands and clear through Baleroc to cross the bridge toward Staghelm. STOP before killing the three Druids of the Flame at his arena. The central humanoid must remain alive casting Kneel to the Flame, and both large flame orbs must still be present.",
    "Dismiss combat pets, minions and temporary companions, remove summon procs and leave shapeshift forms for a straightforward attempt. Bind /kneel or /sit. Move toward an orb only between casts, then kneel BEFORE each cast finishes. A hit can remove the orbs and fail the attempt.",
    "With two players, send one to each orb and stand very close inside the orange floor swirls. After a flame cast finishes, activate both orbs together. Briefly stand if the channel does not register while kneeling, remain close for activation and kneel again before the next cast. The old six-player requirement is obsolete.",
    "For a practiced solo route, activate the first orb immediately after a cast, cross quickly with available movement abilities, activate the second and kneel again. Recent mage comments use Alter Time and Shimmer for the crossing and return. Watch the actual orb animation; seeing a channel from too far away does not prove activation.",
    "If the orbs disappear without credit, leave Staghelm alive. Use the bridge portal back to the entrance, leave and reset eligible trash before retrying, respecting entry limits. Check both orbs have returned before another attempt. Only after the achievement appears should you clear the druids and kill Staghelm.",
},{firelands,pin(369,51,72.46,1,"Staghelm courtyard - preserve flame-casting druids",floorNames[369]),pin(369,51,72.46,3,"Activate the two opposite flame orbs",floorNames[369])},{1627754,3162817,3180835,6003681,6148406,6150568,6268772,6288490},"Reports differ on whether a solo raid-group conversion affects registration. Forming a raid group is a useful troubleshooting step; correct proximity and avoiding the flame remain essential.")

add(5810,"Not an Ambi-Turner","easy","Steer Rhyolith clockwise using only the right foot until his body becomes attackable.",{
    "Enter Firelands and go up the eastern ramp to Lord Rhyolith. Select his RIGHT foot from the boss targets and use single-target attacks; disable cleaves or pets that could attack the left foot.",
    "Keep attacking only the right foot during the armored steering phase. If you need him to walk straight, stop foot damage rather than attacking the left foot. Do not assume removing the foot's armor stacks permits a left turn while the first phase is still active.",
    "When the armor breaks and Rhyolith's BODY becomes attackable, switch to that body and personally kill it. Make sure a pet has not finished the body before you can hit it; the foot alone is not the boss kill.",
},{firelands,pin(367,65.37,75,1,"Rhyolith - attack RIGHT foot only",floorNames[367])},{1487467,1624122,2022457,2091912})

add(5813,"Do a Barrel Roll!","easy","Kill Alysrazor quickly or avoid all four listed fire hazards while staying alive.",{
    "Enter Firelands, clear the Alysrazor approach and let Staghelm's opening scene finish. Kill Alysrazor promptly when she becomes engaged; a high-level burst can avoid the entire tornado sequence.",
    "If the encounter lasts, avoid Brushfire from the flame druids, Lava Spew from the worms, Incendiary Clouds in the air and Fiery Tornado on the ground. Clear the druids promptly and keep out of the worms' facing. Every player in the raid must avoid the listed attacks for that criterion.",
    "If you fly, collect three feathers and follow the rings while avoiding clouds, then descend with Alysrazor so excessive distance does not reset her. Stay alive through the kill: older replies explicitly report missed personal credit after a death.",
},{firelands,pin(367,64.37,38.02,1,"Alysrazor - avoid four named fire hazards",floorNames[367])},{1523672,1832557,1878973,1939714,2186083})

add(5821,"Death from Above","easy","Leave ground-level Cinderweb Drones alive while killing Beth'tilac.",{
    "Enter Firelands and reach Beth'tilac's western lair. Start the encounter and kill ONE hanging Cinderweb Spinner, then click its dropped web strand to climb onto the canopy. Spinners are different from the large ground-level Drones.",
    "Damage Beth'tilac upstairs and follow her down if she transitions. Use single-target attacks and keep Cinderweb Drones alive on the lower floor; killing no drones at all satisfies the condition.",
    "If deliberately killing a Drone, wait until its energy is exhausted and it climbs onto the canopy, then kill it while it is still upstairs. The simplest high-level route is to ignore drones entirely and finish Beth'tilac without a ground-level drone death.",
},{firelands,pin(367,21.06,32.78,1,"Beth'tilac - spinner web to upper canopy",floorNames[367])},{1536634,1637551,1638019,2056527,2614607})

add(5829,"Bucket List","medium","Bring the living Shannox himself across five area boundaries in one engagement.",{
    "Enter Firelands and clear a safe circuit through the Molten Fields until Shannox spawns. Remove passive damage and cleaving pets. Start him without damaging him; kill Rageface separately if his stun prevents the tour, while preserving Shannox.",
    "Lead Shannox through Flamebreach 34.1,75.1; Beth'tilac's Lair boundary 29.1,62.3; Path of Corruption 34.0,30.8; Shatterstone 61.2,45.4; and Ridge of Ancient Flame 61.6,55.9. Follow the marked circuit and allow the boss to catch up at every destination.",
    "Credit depends on SHANNOX crossing each boundary, not just your minimap displaying the subzone name. The low cliff beside Beth'tilac's lair can count without climbing into her upper room. Watch the five criteria and move farther into an area if one is still missing.",
    "After all five areas are covered during this engagement, kill Shannox. Keep him alive if tracking is delayed and recheck the route; do not discard a valid attempt merely because an external tracker flags killing his dogs as a failure.",
},{firelands,pin(367,34.1,75.1,2,"Flamebreach - bring Shannox here",floorNames[367]),pin(367,29.1,62.3,2,"Beth'tilac's Lair boundary",floorNames[367]),pin(367,34,30.8,2,"Path of Corruption",floorNames[367]),pin(367,61.2,45.4,2,"Shatterstone",floorNames[367]),pin(367,61.6,55.9,2,"Ridge of Ancient Flame",floorNames[367])},{1499549,1625485,1854340,2016976,5702366,6044295,6256909,6410048})

add(5830,"Share the Pain","easy","Finish Baleroc before anyone receives Torment on more than three separate occasions.",{
    "Enter Firelands, clear Baleroc's approach and kill him directly at high level. There is no need to wait for a crystal if your damage ends the encounter first.",
    "If a longer fight produces Shards of Torment, rotate the soakers so no player receives Torment more than THREE separate times. This counts applications or soaks, not the number of damage stacks within one continuous soak.",
    "Keep other players away from crystal range when they are not assigned, then finish Baleroc and check the achievement. A high-level solo kill can complete it without any crystal rotation.",
},{firelands,pin(367,49.50,30.99,1,"Baleroc - at most three separate Torment applications",floorNames[367])},{1456163,1465672,1773359,2019641,2073196})

add(5855,"Ragnar-O's","hard","Stop Ragnaros in the meteor phase and ignite three meteors before ending the fight.",{
    "Enter Firelands on 10-player Normal for a simple dedicated attempt and clear to Ragnaros. Disable passive damage and pets that retaliate. Use controlled damage, a lower-level helper or Whole-Body Shrinka' before combat if your normal attack would kill him.",
    "Bring Ragnaros to around 30% while keeping him ABOVE 10%, then stop attacking. Wait for at least THREE Living Meteors to spawn. Keep an eligible target in melee range so he continues the encounter normally; a passive pet can help, but avoid pets with automatic damaging effects.",
    "Kite the meteors near the middle of the platform. When Sulfuras Smash creates Lava Waves, lead or knock the meteors through the waves. Target each meteor and confirm its Lavalogged debuff; the visual appearance alone is not sufficient.",
    "Once THREE meteors are actually Lavalogged, finish Ragnaros promptly. Do not kill the boss before the setup, and do not trust an early failed message from a tracker that confuses the intermission elementals with meteors. On Heroic, the subsequent final phase can complicate keeping the ignition condition, which is why Normal is the recommended dedicated route.",
},{firelands,pin(369,50.75,15.38,2,"Ragnaros - hold near 30% for three meteors",floorNames[369]),pin(369,50.75,15.38,3,"Ignite three meteors with Lava Wave",floorNames[369])},{1456281,2079486,2082155,3307513,5527972,5761517,6038579,6150587,6383708},nil,{899606})

add(6084,"Minutes to Midnight","easy","Kill Ultraxion before a player can be hit by Hour of Twilight twice.",{
    "Enter Dragon Soul on Normal or Heroic, clear through Hagara and return to Wyrmrest's summit. Speak to Thrall and finish the drake-defense and dialogue sequence so Ultraxion engages properly.",
    "Kill Ultraxion quickly at high level, ideally before his first Hour of Twilight. You do not need to deliberately take a hit; the condition is that nobody is hit MORE THAN ONCE.",
    "If the fight lasts through repeated casts, use Heroic Will and a planned rotation of remaining soakers so the same player does not take a second Hour. Finish the encounter and verify credit before boarding the Skyfire.",
},{soul,pin(409,50.03,45.81,2,"Ultraxion - prevent a second Hour hit",floorNames[409])},{1586187,1690314,2027221})

add(6105,"Deck Defender","medium","Kill approaching assault drakes and prevent every small Twilight Barrage from damaging the ship.",{
    "Enter Dragon Soul and clear through Ultraxion, then board the Skyfire and start the defense. For a dedicated attempt, use Normal and bring ranged attacks or helpers to cover both sides of the deck.",
    "Target Twilight Assault Drakes as they approach and kill each wave promptly. Watch the SMALL Twilight Barrage circles and have a player stand in each circle before impact if a drake gets a cast off. Cover both sides rather than chasing only the boarding enemies.",
    "Kill Twilight Sappers before they reach the ship's vulnerable area, and handle the larger Twilight Onslaught separately; it is not the small Twilight Barrage named by the achievement. Continue through the defense until Goriona and Blackhorn arrive.",
    "Finish Blackhorn with no unsoaked small barrages having damaged the Skyfire. Ranged /target Twilight Assault Drake attacks simplify covering incoming drakes; a very fast boss kill after a failed defense does not repair the criterion.",
},{soul,pin(413,48.15,17.18,2,"Skyfire - cover both sides and kill assault drakes",floorNames[413])},{5594854,5853532,6112733,6149464})

add(6128,"Ping Pong Champion","hard","Preserve Zon'ozz while controlling the orb's direction, short immunity and ten-bounce counter.",{
    "Enter Dragon Soul on Normal or Heroic and reach Zon'ozz. Remove damaging procs, retaliation and attacking pets. A tank specialization prevents daze while chasing the orb; a second player holding the boss aside makes it easier.",
    "Wait for the Void of the Unmaking orb. Run into it to reverse its direction, then continue briefly in your original direction so its transparent immune form can pass through you and the following boss safely.",
    "Turn and follow the orb until its center glows again, roughly two to three seconds, then intercept it to bounce it back. Repeat for TEN player bounces. Keep the glowing orb away from the boss and outer wall; either collision can end that sequence. A passive pet or helper can hold Zon'ozz aside instead of following you.",
    "Inspect Void Diffusion on the ORB and confirm ten stacks, then kill Zon'ozz. The current counter can cap at ten, so waiting for an eleventh visible stack is unnecessary. If the orb was lost before ten, preserve the boss and try the next orb.",
},{soul,pin(410,50.96,53.03,2,"Zon'ozz - ten player bounces, preserve boss",floorNames[410])},{2065438,5579303,5706019,6081458,6137986,6148482,6355915,6399548},nil,{822139,833075,839278,842120})

add(6129,"Taste the Rainbow!","medium","Observe four absorbed ooze-color pairs during one living Yor'sahj encounter.",{
    "Enter Dragon Soul on Heroic if possible, because four oozes per wave make combinations quicker. Reach Yor'sahj, remove passive damage and start without killing him. The initial trash oozes do not count.",
    "Allow each encounter wave's oozes to reach Yor'sahj. Record these simultaneous pairs in his absorbed color buffs: BLACK/YELLOW, BLACK/BLUE, RED/GREEN and PURPLE/YELLOW. A four-color wave can satisfy several pairs at once.",
    "Keep waiting through additional waves in the SAME fight until you have personally seen all four pairs. The live achievement checklist can fail to update before the boss dies, so use your own notes or observed buffs rather than waiting indefinitely for checkboxes.",
    "Once all four combinations have occurred, kill Yor'sahj and check credit. Do not end the encounter after merely seeing four individual colors; the required PAIRS must coexist.",
},{soul,pin(411,46.83,49.93,2,"Yor'sahj - absorb all four required color pairs",floorNames[411])},{5524015,5900829,6137982,6238131,6385617})

add(6174,"Don't Stand So Close to Me","easy","Burst Morchok or spread all players during every Black Blood channel.",{
    "Enter Dragon Soul on Normal or Heroic and clear the approach around Morchok. At high level, kill him before he reaches Black Blood of the Earth; a fast kill without the phase meets the achievement.",
    "If Black Blood occurs, spread immediately after the pull-in effect while using the rock fragments for protection. In 10-player mode no two players may be within five yards; in 25-player mode two together are allowed, but three together fail it.",
    "Remain spread until the channel ends, repeat for any later channel and finish Morchok. Predetermine positions if using a group so several players do not choose the same fragment.",
},{soul,pin(409,50.40,69.25,2,"Morchok - spread during Black Blood",floorNames[409])},{1600629,1616544,1659189,1761639,2009513})

add(6175,"Holding Hands","hard","Build a lightning chain that includes every present player when Hagara's final conductor activates.",{
    "Enter Dragon Soul and reach Hagara. A dedicated 10-player Normal attempt has recent Midnight confirmations, including a character plus a passive pet. Bring a helper if your class cannot position a pet. This achievement remains separate from the current Dragon Soul mount meta.",
    "Clear her starting trash, engage without killing her and use controlled damage to reach her special phases. Remove damaging procs and use a damage-reduction toy before combat if needed. Survive the ice phase if it comes first; destroy an Ice Tomb or have a helper or pet free trapped players.",
    "In the LIGHTNING phase, kill the Bound Lightning Elemental beside a Crystal Conductor to charge it. Position players, and a passive pet if used, in a STRAIGHT LINE between the charged conductor and the next, with each link close enough to transmit lightning.",
    "Repeat around the room, adjusting the chain to charge the remaining conductors. When the FINAL conductor activates, EVERY player present must be part of that final Lightning Conduit. Simply charging all conductors with someone standing disconnected does not meet the criterion.",
    "Watch for the achievement at the final activation; killing Hagara is not needed to make this interaction credit appear. Recent comments report different results between modes and sensitive pet positioning, so use actual credit rather than only her stun animation as proof of success.",
},{soul,pin(412,52.75,52.05,3,"Hagara - lightning elemental and conductor circuit",floorNames[412])},{6025059,6103322,6358551,6383588})

add(6180,"Chromatic Champion","hard","Four different opening platforms must be completed on the same character across weekly Madness kills.",{
    "Choose ONE character for the entire achievement. Enter Dragon Soul on Normal or Heroic, clear through Spine and inspect which of the four opening Aspects remain unchecked. Warbands do not combine unfinished platform criteria from four different characters.",
    "At Madness, Thrall stands on Ysera's platform. From there Nozdormu is one platform left, Alexstrasza two left and Kalecgos one right. Plan an unchecked first assault before speaking to Thrall.",
    "For distant Alexstrasza, jump Ysera-to-Nozdormu and back before starting to build the Carrying Winds movement buff. Speak to Thrall, immediately rush through Nozdormu to Alexstrasza and wait there for Deathwing to announce the first Aspect assault. Use movement abilities; the assault begins faster than some old videos show.",
    "For any chosen opening, let the first assault and its Mutated Corruption establish before killing the limb. Then clear the other three platforms, return for Deathwing's head and finish the encounter. Check the actual criterion after the kill rather than an external tracker's provisional platform name.",
    "Return on that SAME character after each weekly reset and repeat with a different missing first Aspect until all four are credited. Changing Normal/Heroic in the same weekly Dragon Soul progression does not provide four independent attempts, so plan at least four weekly kills.",
},{soul,pin(415,47.87,53.85,2,"Madness - choose the next missing opening Aspect",floorNames[415])},{5609573,6065736,6129619})

add(6133,"Maybe He'll Get Dizzy...","hard","Complete an ordered four-roll sequence and then all three armor plates in the successful Spine attempt.",{
    "Enter Dragon Soul on Normal or Heroic and clear through Blackhorn to Spine. Kill three Corruption tentacles and leave one alive. The required sequence is LEFT, RIGHT, LEFT, RIGHT; warnings alone do not count as completed rolls.",
    "Stand in a dead tentacle hole on the LEFT and verify Grasping Tendrils anchors you while Deathwing completes a left roll. Move to a RIGHT-side hole for the next completed roll, then repeat LEFT and RIGHT. Keep yourself anchored during each completed roll so you are not thrown off.",
    spine,
    plate.." Once the required four rolls are complete, avoid unnecessary extra completed rolls while opening the plates. The achievement requires successfully finishing Spine after the sequence; resetting or falling off means starting the sequence again.",
},{soul,pin(414,33.21,85.26,2,"Spine - completed Left / Right / Left / Right rolls",floorNames[414])},{})

local clears={
    {4842,"Blackwing Descent","bwd",{
        "Defeat Magmaw and Omnotron in the entrance wing. Continue to Atramedes, Maloriak and Chimaeron, activating their encounter events as needed; speak to Finkle and activate the robot before Chimaeron.",nefarian,
        "Check all six bosses in Blackwing Descent before leaving. A quick airborne Nefarian kill that bypasses the final landing can leave the scripted completion unfinished.",
    },{1286310,1958007}},
    {4850,"The Bastion of Twilight","bastion",{
        "Defeat Halfus Wyrmbreaker, then the shared-health Valiona and Theralion pair. Continue to Ascendant Council and defeat its first pair, second pair and combined Elementium Monstrosity.",
        "Clear the packs around Cho'gall, pull him to the center, let the encounter initialize and defeat him. Wait for the death sequence. On Heroic the broken floor leads to Sinestra, whose separate kill is not required by the ordinary four-boss Bastion achievement.",
        "Check Halfus, the dragons, Council and Cho'gall. If earning Heroic-specific achievements, verify Heroic inside as well; this ordinary raid clear can be earned on Normal.",
    },{}},
    {4851,"Throne of the Four Winds","winds",{conclave,
        "After the Conclave, use the central wind route to Al'Akir. Defeat him through any required transitions and his final flight phase. If attempting Four Play as well, first preserve his middle phase and apply Feedback from a nearby Stormling.",
        "Confirm both Conclave and Al'Akir are credited. This raid is off southwestern Uldum; Throne of the Tides is a different underwater dungeon in Vashj'ir.",
    },{}},
    {5802,"Firelands","firelands",{
        "Defeat Shannox, Beth'tilac, Lord Rhyolith and Alysrazor. Spawn Shannox by clearing trash; use a killed Spinner's web for Beth'tilac; switch from Rhyolith's foot to his BODY for the final kill; let Alysrazor's opening scene complete.",
        "Defeat Baleroc, cross the opened bridge, clear the courtyard and defeat Staghelm. If you still need Only the Penitent, do its orb interaction BEFORE killing the flame-casting druids.",
        "Proceed to Ragnaros and finish his encounter. On Heroic, his low-health disappearance is followed by the phase where he grows legs, so stay and kill the final form. Check all seven bosses before leaving.",
    },{2058282}},
    {6106,"Siege of Wyrmrest Temple","soul",{
        "Defeat Morchok outside Wyrmrest. Use the NPC transport routes to the Maw of Go'rath for Zon'ozz and the Maw of Shu'ma for Yor'sahj, and defeat both.",
        "Return to Wyrmrest and take the Eye of Eternity portal to Hagara. Defeat her and check all FOUR first-wing boss criteria. Killing only the three encounters around the temple leaves Hagara missing.",
        "This finishes the first-wing achievement. Continue through Thrall's summit event and the Skyfire if you also want Fall of Deathwing; the two wing achievements have different criteria.",
    },{1583756}},
    {6107,"Fall of Deathwing","soul",{
        "Clear the first wing through Hagara, return to Wyrmrest's summit and speak to Thrall. Complete the drake-defense event and wait through the dialogue, then defeat Ultraxion and loot his cache.",
        "Board the Skyfire, defeat the drake waves and sappers, then Goriona and Warmaster Blackhorn. Use the offered next dialogue and transition to Spine.",spine,plate,madness,
        "Check Ultraxion, Blackhorn, Spine and Madness. This wing achievement includes those four encounters; the separate Destroyer's End title specifically needs a Normal or Heroic Deathwing kill.",
    },{1584523,1605814}},
}
for _,r in ipairs(clears) do
    local steps={"Set legacy Raid Difficulty to Normal or Heroic. "..approach[r[3]]}
    for _,instruction in ipairs(r[4]) do steps[#steps+1]=instruction end
    local waypoints={entrances[r[3]]}
    for _,b in ipairs(heroicBosses) do
        if b[3]==r[3] then waypoints[#waypoints+1]=pin(b[4],b[5],b[6],2,b[2],floorNames[b[4]]) end
    end
    add(r[1],r[2],r[3]=="soul" and "medium" or "easy","Complete each named boss and allow scripted finales to finish.",steps,waypoints,r[5])
end

add(6177,"Destroyer's End","medium","Clear Dragon Soul through its scripted Spine and Madness encounters on Normal or Heroic.",{
    approach.soul,
    "Defeat Ultraxion after Thrall's summit event, then complete the Skyfire defense and defeat Blackhorn. Continue through the offered dialogue to Spine.",spine,plate,madness,
    "Stay through Deathwing's actual defeat and check Destroyer's End. The title requires Normal or Heroic; a Raid Finder-only Deathwing kill does not meet this achievement.",
},{soul,pin(414,33.21,85.26,3,"Spine - open all three plates",floorNames[414]),pin(415,47.87,53.85,5,"Madness - final Deathwing defeat",floorNames[415])},{})

for _,r in ipairs({{5416,"Pit Lord Argaloth",80.44,63.47},{6045,"Occu'thar",15.57,63.18},{6108,"Alizabal",47.90,17.96}}) do
    add(r[1],r[2],"easy","A short legacy raid kill once your faction has Tol Barad access.",{
        "Travel to Tol Barad and check which faction controls it. Baradin Hold is accessible to the controlling faction; if necessary, queue for the next Tol Barad battle and win control before attempting the raid entrance at 47.5,39.0.",
        "Enter Baradin Hold and take the wing marked for "..r[2]..". Clear the approach and defeat that named boss. The other two bosses have separate achievements, so killing whichever one is nearest does not replace this target.",
        "Confirm "..r[2].." is credited and loot the boss before leaving. These are raid boss kills despite their catalogue placement beside Tol Barad PvP achievements; the zone battle alone does not award them.",
    },{hold,pin(282,r[3],r[4],2,r[2],"Baradin Hold")},{})
end

-- Keep the already researched mount routes intact when presenting their actual
-- achievement IDs. These are full numbered guides, not a pointer to buy a mount.
for _,r in ipairs({{4853,88335,"Glory of the Cataclysm Raider"},{5828,97560,"Glory of the Firelands Raider"},{6169,107844,"Glory of the Dragon Soul Raider"}}) do
    local g=TDP.CollectionWalkthroughs.mounts[r[2]]
    if g then
        guides[r[1]]={achievementId=r[1],name=r[3],category="Raids",sourceType="Achievement",source=r[3],
            description=g.description,acquisition=g.acquisition,stepCount=g.stepCount,waypoints=g.waypoints,areaMaps=g.areaMaps,
            difficulty=g.difficulty,difficultyReason=g.difficultyReason,tips=g.tips,
            sourceComments=g.sourceComments,sourceReplyIds=g.sourceReplyIds,
            wowheadUrl="https://www.wowhead.com/achievement="..r[1],sourceURL="https://www.wowhead.com/achievement="..r[1].."#comments"}
    end
end

add(5506,"Defender of a Shattered World","medium","Combine all nine original Heroic dungeon clears with the three launch raid clears.",{
    "Track Defender of a Shattered World and complete Cataclysm Dungeon Hero: Heroic Blackrock Caverns, Throne of the Tides, Grim Batol, The Stonecore, The Vortex Pinnacle, Halls of Origination, Lost City of the Tol'vir, Deadmines and Shadowfang Keep.",
    "Complete Blackwing Descent through Nefarian, Bastion of Twilight through Cho'gall and Throne of the Four Winds through Al'Akir. Normal raid clears are sufficient for these component raid achievements; their separate Heroic achievements are not required by this meta.",
    "Use the individual guides for the scripted finales: Vanessa is after Cookie's letter and nightmare, Nefarian must complete the lava phase, and all three Conclave lords must be defeated before Al'Akir is available.",
    "Check all four component achievements. Firelands, Dragon Soul, the Zandalari dungeons and the three later Caverns of Time dungeons are separate content rather than additions to this launch meta.",
},{bwd,bastion,winds}, {})

