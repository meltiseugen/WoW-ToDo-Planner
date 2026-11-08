-- English Retail collection and legendary guides. Reviewed 2026-11-05.
local _, TDP = ...
local guides=TDP.CollectionWalkthroughs.achievements
local function pin(mapID,x,y,step,label,mapName)
    return {mapID=mapID,x=x/100,y=y/100,step=step,label=label,mapName=mapName}
end
local function add(id,name,difficulty,reason,steps,points,sources,tips)
    local lines={"Difficulty: "..difficulty:gsub("^%l",string.upper).." - "..reason}
    for i,text in ipairs(steps) do lines[#lines+1]=i..". "..text end
    guides[id]={achievementId=id,name=name,category="Collections",sourceType="Achievement",source=name,
        difficulty=difficulty,difficultyReason=reason,stepCount=#steps,acquisition=table.concat(lines,"\n\n"),
        waypoints=points or {},sources=sources or {},tips=tips,reviewedAt="2026-11-05",
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments"}
end
local function promote(id,source,name)
    if not source then return end
    local g={}
    for _,key in ipairs({"description","acquisition","stepCount","waypoints","areaMaps","difficulty","difficultyReason","tips","sources","sourceComments","sourceReplyIds"}) do g[key]=source[key] end
    g.achievementId,g.name,g.source,g.sourceType,g.category=id,name,name,"Achievement","Collections"
    g.wowheadUrl="https://www.wowhead.com/achievement="..id
    g.sourceURL=g.wowheadUrl.."#comments"
    guides[id]=g
end
-- Existing mount/pet routes were reviewed against these achievement comments.
-- Preserve their detailed current routes, including the complete figurine map.
promote(5767,TDP.CollectionWalkthroughs.mounts[88750],"Scourer of the Eternal Sands")
guides[5767].tips=guides[5767].tips.." Midnight comments confirm this remains obtainable. The achievement is earned by the real figurine/Dormus event; buying a Ramkahen camel cannot award it."
guides[5767].sources={"https://www.wowhead.com/achievement=5767#comments:id=1413128","https://www.wowhead.com/achievement=5767#comments:id=1446037","https://www.wowhead.com/achievement=5767#comments:id=6331902"}
guides[5767].sourceReplyIds={771417,869340,1028279,1846742}
promote(4888,TDP.CollectionWalkthroughs.mounts[88748],"One Hump or Two?")
guides[4888].sources={"https://www.wowhead.com/achievement=4888#comments:id=1217956","https://www.wowhead.com/achievement=4888#comments:id=5778360"}
promote(5749,TDP.CollectionWalkthroughs.mounts[93326],"Vial of the Sands")
guides[5749].sources={"https://www.wowhead.com/achievement=5749#comments:id=1411542","https://www.wowhead.com/achievement=5749#comments:id=1424210","https://www.wowhead.com/achievement=5749#comments:id=2498025"}
guides[5749].sourceReplyIds={720344}
for _,r in ipairs({{5875,255,"Littlest Pet Shop"},{5876,323,"Petting Zoo"},{5877,325,"Menagerie"}}) do
    promote(r[1],TDP.CollectionWalkthroughs.pets[r[2]],r[3])
    guides[r[1]].sources={"https://www.wowhead.com/achievement=5875#comments:id=1631573","https://www.wowhead.com/achievement=5875#comments:id=1721017","https://www.wowhead.com/achievement=5876#comments:id=1838575","https://www.wowhead.com/achievement=5877#comments:id=1708111"}
end

add(5180,"Breaking the Sound Barrier","easy","Master Riding is learned automatically at level 40 in Retail.",{
    "Level a normal Retail character to 40. Since patch 10.1.5, the character automatically learns Master Riding at this level; the old 4,000-5,000 gold trainer purchase is obsolete.",
    "Check your riding skills and the achievement after the level-up. If an older eligible character has not refreshed its riding skill, log out and back in before looking for a trainer or spending gold.",
    "Use a mount in Steady Flight where flying is allowed to see the Master Riding flight speed. Skyriding speed and buying a particular 310% mount are not separate requirements for this achievement.",
},{},{"https://www.wowhead.com/achievement=5180#comments:id=5650302"},"This is automatic character progression, so there is no riding-vendor destination to place on the map.")
guides[5180].sourceReplyIds={1646063}

add(5755,"Thirty Tabards","medium","Collect thirty distinct tabard appearances, with several reputation unlocks.",{
    "Track Thirty Tabards and inspect the tabard section of your appearance collection. Learn missing tabards by equipping them or otherwise completing their collection binding. Buying duplicate copies or merely previewing an appearance does not add another distinct tabard.",
    "Start with your faction's seven city tabards and the ordinary Guild Tabard. Visit each city's quartermaster near its flight master; Alliance uses Stormwind, Ironforge, Darnassus, Exodar, Gnomeregan, Gilneas and Tushui, while Horde uses Orgrimmar, Undercity, Thunder Bluff, Silvermoon, Darkspear, Bilgewater and Huojin. Use a city's earlier phase where its old quartermaster requires it.",
    "At Friendly and Honored with your guild, add Illustrious Guild Tabard and Renowned Guild Tabard from a guild vendor. These are different appearances from the ordinary Guild Tabard. Stormwind's Shay Pressler and Orgrimmar's Goram sell the guild rewards.",
    "Add the four Northrend championing tabards at Friendly: Argent Crusade, Kirin Tor, Wyrmrest Accord and Knights of the Ebon Blade. Then unlock the Cataclysm Friendly tabards for Ramkahen, Guardians of Hyjal, Earthen Ring, Therazane and your faction's Wildhammer/Dragonmaw clan. Complete Deepholm's storyline to reach Therazane's quartermaster.",
    "Fill the remaining slots from reputations you already have at Exalted, such as Cenarion Expedition, Lower City, Sha'tar, Consortium, Sporeggar, Keepers of Time and Shattered Sun. Obtain each DIFFERENT tabard and learn its appearance. Pandaria and later faction tabards provide alternatives; old reports that later-expansion tabards never count predate fixes.",
    "Collect the Tabard of the Explorer if you have World Explorer and the Tabard of the Achiever after Twenty-Five Tabards. These can help close the final gap. Check that the appearance has stayed learned before discarding any refundable purchase; stop when the live achievement counter reaches thirty.",
},{pin(84,64.6,76.8,3,"Shay Pressler - guild tabards"),pin(85,48.2,75.6,3,"Goram - guild tabards"),pin(249,54,33.2,4,"Abasi - Ramkahen tabard"),pin(207,57.3,12.5,4,"Therazane's Throne - after Deepholm campaign")},
{"https://www.wowhead.com/achievement=5755#comments:id=1682919","https://www.wowhead.com/achievement=5755#comments:id=2448651","https://www.wowhead.com/achievement=5755#comments:id=2528997"},
"The collection became account-wide with wardrobe tracking. The old insistence on one character and the obsolete listing macros do not describe the current appearance counter. Retired event and old Gladiator tabards are unnecessary.")

add(5839,"Dragonwrath, Tarecgosa's Rest","hard","A long raid quest chain with four controlled boss mechanics and repeated collection stages.",{
    "Use an eligible caster: Mage, Priest, Warlock, Druid, Shaman or Evoker. In original Firelands, kill a Molten Lord trash enemy to trigger Your Time Has Come if needed, then follow A Legendary Engagement to Anachronos at the Caverns of Time. Enable Trivial Quests. If already started, resume your current chain rather than repeatedly clearing Molten Lords.",
    "Complete A Wrinkle in Time and accept All-Seeing Eye. Loot TWENTY-FIVE Eternal Embers from Firelands bosses and buy THREE Sands of Time from Yasmin in northwestern Uldum. Eternal Embers are quest drops; the tradable crafting material Living Ember is the wrong item. Normal and Heroic have separate weekly loot opportunities in current Retail; a 10/25 toggle does not create additional copies of either lockout.",
    "Follow On a Wing and a Prayer to Coldarra in Borean Tundra. Complete Through a Glass, Darkly in its special Nexus scenario with Tarecgosa: follow her, clear the scripted enemies and protect her during the final caster encounter. Use the quest's scenario entrance, not an ordinary dungeon clear that lacks her event.",
    "Complete Actionable Intelligence and accept Delegation. Before its four focus encounters, remove damaging procs and attacking pets. Do NOT kill the bosses while charging their foci if you want them available for the next collection quest. Bring a helper for Shannox if your class lacks a reliable harmless second unit.",
    "Delegation / Shannox: clear trash to spawn him, then keep Shannox and Riplimb alive; kill Rageface with single-target damage if his stun is disruptive. With a helper or suitable non-damaging summon present, trigger Crystal Prison traps and let Riplimb become trapped. After the prison breaks, loot its Emberstone Fragment. Repeat for THREE fragments, combine them into Dull Emberstone Focus, place it in the Hurl Spear ground marker BEFORE the spear lands, then pick up Charged Emberstone Focus. Reset combat safely without killing Shannox.",
    "Delegation / Beth'tilac: engage without killing her. Kill a Cinderweb Drone and collect the THREE Obsidian-Flecked Chitin Fragments that appear. Combine the Dull Chitinous Focus. Kill a hanging Spinner, click its web strand to climb, and place the focus on the upper web just before Smoldering Devastation. Retrieve the Charged Chitinous Focus, climbing back up if needed, then reset the fight. Avoid waiting until the final web collapse.",
    "Delegation / Rhyolith: leave him alive and look around the island's outer edge for THREE purple Rhyolite Fragments. Combine Dull Rhyolite Focus, stand close beneath the boss and place it as Concussive Stomp begins. Pick up Charged Rhyolite Focus after the stomp and reset. Killing a foot or the body is unnecessary for charging this focus.",
    "Delegation / Alysrazor: leave the boss alive while the eggs hatch. Collect THREE Pyreshell Fragments from the hatchling areas across enough egg waves and combine Dull Pyreshell Focus. Wait through tornadoes until she lands exhausted. Place the focus beside her during the recharge, before she reaches full energy and takes off. After takeoff, retrieve Charged Pyreshell Focus and reset without killing her.",
    "With all FOUR charged foci, go to the Circle of Thorns along the northwestern Path of Corruption in Firelands. Use the foci to open its portal. Inside, kill the casters, interact with the central branch, complete the tree event and defeat Volcanus. Pick up Branch of Nordrassil from the ground.",
    "Turn in Delegation and Nordrassil's Bough to Kalecgos in the Coldarra/Amber Ledge storyline. Receive the first staff stage and follow Emergency Extraction and At One. Do these dialogue quests before resuming the collection farm.",
    "Accept Time Grows Short and loot ONE THOUSAND Seething Cinders from eligible Firelands boss kills. Run both Normal and Heroic each weekly reset. If you reach the total partway through a clear, leave the remaining bosses alive, turn in and finish Alignment so those bosses can contribute to the next stage.",
    "Receive Runestaff of Nordrassil and accept Heart of Flame. Keep the staff and use its Siphon Essence ability on the corpses of the first SIX Firelands bosses to collect TWO HUNDRED FIFTY Smouldering Essences. Ordinary boss looting is not the siphon. Ragnaros does not supply this essence; return after weekly resets on each eligible difficulty.",
    "After reaching 250 essences, defeat Ragnaros with Heart of Flame active and collect the Heart of Flame from his encounter area. Finish his scripted ending and retrieve the actual quest objective before leaving; simply killing him earlier in the chain cannot supply it.",
    "Complete The Stuff of Legends in your faction capital and wait through the Blue Dragonflight ceremony. Receive the FINISHED Dragonwrath and check the personal achievement. The earlier Branch and Runestaff stages are not the legendary. A later Dragonflight quest can unlock a separate Tarecgosa mount, but it is not needed for this achievement.",
},{pin(198,47.2,78.1,1,"Original Firelands - Molten Lord / quest start"),pin(71,65.2,50,1,"Anachronos - Caverns of Time exterior"),pin(198,47.2,78.1,2,"Firelands - 25 Eternal Embers"),pin(249,26.6,7.2,2,"Yasmin - three Sands of Time"),pin(114,27.5,26.6,3,"Coldarra / Nexus - follow special quest scenario"),pin(367,49.30,44.31,5,"Shannox - traps, fragments, Hurl Spear focus","Firelands"),pin(367,21.06,32.78,6,"Beth'tilac - Drone fragments / upper web","Firelands"),pin(367,65.37,75,7,"Rhyolith - fragments around island / Stomp","Firelands"),pin(367,64.37,38.02,8,"Alysrazor - eggs and recharge phase","Firelands"),pin(198,47.2,78.1,11,"Firelands - 1,000 Seething Cinders"),pin(198,47.2,78.1,12,"Firelands - siphon six boss corpses"),pin(369,50.75,15.38,13,"Ragnaros - Heart of Flame after essence stage","Firelands - Ragnaros")},
{"https://www.wowhead.com/item=71086#comments:id=1415566","https://www.wowhead.com/item=71086#comments:id=5866271","https://www.wowhead.com/quest=29234#comments:id=3186613","https://www.wowhead.com/quest=29234#comments:id=5898413","https://www.wowhead.com/quest=29307/heart-of-flame"},
"Use a helper for Shannox rather than assuming an old permanent Water Elemental talent exists. A newer mage reply specifies that a creature must actually be trapped; an empty trap fading is insufficient. This route omits the comments' profit filler and obsolete level-85 raid requirements.")
guides[5839].sourceReplyIds={935875,1351283,1661385,1695350,1701971,1749412,1758600}
guides[5839].areaMaps={114,84,85}

add(6181,"Fangs of the Father","hard","Rogue-only stealth missions, two long raid collection stages and Spine's scripted mechanics.",{
    "Use a Rogue of at least level 35. Enter original Dragon Soul inside the Caverns of Time in Tanaris on NORMAL or HEROIC; Raid Finder cannot provide the quest items. Accept Proving Your Worth from Lord Afrasastrasz inside the raid near the starting Wyrmrest area. Outdoor Dragonblight's Wyrmrest Temple is the wrong instance.",
    "Defeat Morchok, Zon'ozz and Yor'sahj, then use the temple transports and Eye of Eternity portal for Hagara. Clear her preceding waves. When she lands and waits in the middle, approach in Stealth and PICK POCKET her for Cryptomancer's Decoder Ring BEFORE killing her. Return to the quest giver; if her pocket is empty, reset her encounter safely and try again.",
    "Accept A Hidden Message. Visit Thaumaturge Rafir in Stormwind (50.6, 61.3) or Thaumaturge Altha in Orgrimmar (57.6, 65.5), pay TEN THOUSAND gold and receive the Charging Decoder Ring. Wait TWELVE real hours; you can be logged out. This timer is not twelve hours of played time.",
    "Go to Corastrasza beneath the large tree at Vermillion Redoubt in Twilight Highlands (29.0, 25.0). Obtain Singed Cipher and use your CHARGED ring to decode it. Turn in, accept To Ravenholdt and speak to Mostrasz outside for the flight.",
    "Complete To Catch a Thief by following the special stealth route into Ravenholdt Manor. Use the supplied detection guidance to avoid guards and enter as directed. Ordinary Ravenholdt reputation does not make these quest guards friendly. Meet Wrathion in the cellar and follow the dialogue.",
    "Follow Our Man in Gilneas to Zazzo and complete Assassinate Creed. Use Zazzo's quest transport/instructions to reach the mission phase, sneak through the guarded town, kill Lord Hiram Creed and return to Ravenholdt. Turn in The Deed is Done for Fear and Vengeance, the FIRST dagger pair; keep both for later upgrades.",
    "Accept Cluster Clutch. Return to Dragon Soul each weekly reset, loot Elementium Gem Clusters from eligible bosses, and OPEN them until you have THREE HUNDRED THIRTY-THREE Shadowy Gems. Use 25-player mode for the larger cluster supply. Normal and Heroic share the Dragon Soul boss lockout; changing difficulty is not a second weekly farm. Stop opening clusters when the gem target is reached and keep extra INTACT clusters.",
    "Return to Wrathion, then complete Our Man in Karazhan and Blood of the Betrayer. Meet Zazzo outside original Karazhan, enter the quest's cellar mission and defeat Nalice, using the mission's arcane devices to remove her barriers. Return for Victory in the Depths and exchange the first pair for The Sleeper and The Dreamer.",
    "Accept Sharpening Your Fangs and collect SIXTY INTACT Elementium Gem Clusters from Dragon Soul bosses over weekly resets. Leftover unopened clusters from the first collection count; loose Shadowy Gems do not replace clusters. Check every boss and loot cache. Raid Finder supplies none.",
    "As soon as you reach sixty clusters, leave the raid and turn in to Wrathion BEFORE killing Madness of Deathwing. Accept Patricide and keep the intermediate daggers for its turn-in. If your sixtieth cluster came from Madness itself, you need another eligible weekly kill for the new quest.",
    "Continue the raid through Ultraxion and Warmaster Blackhorn. On Spine, kill three Corruption tentacles and anchor in a dead tentacle's hole for a roll to discard unwanted Amalgamations. Keep one Amalgamation, kill Bloods and lead it over residue until its Absorbed Blood reaches NINE. Keep checking the actual stack count.",
    "Move the nine-stack Amalgamation against the next armor plate toward Deathwing's head and kill it. Nuclear Blast exposes a Burning Tendon: kill that tendon to remove the plate. Repeat for all THREE plates. Alternate sides to cancel unwanted rolls, or stay anchored; an unanchored completed roll throws you off.",
    "At Madness, speak to Thrall, cross the four Aspect platforms and defeat each limb/Mutated Corruption. Return to the starting platform, defeat Deathwing's head and loot the final cache for Fragment of Deathwing's Jaw while Patricide is ACTIVE.",
    "Return to Wrathion in Ravenholdt Manor (71.4, 45.5 in Hillsbrad), turn in the jaw and required intermediate weapons, and receive BOTH Golad and Tiriosh together. Finish the scene and check Fangs of the Father. If you deleted an intermediate pair, ask the Ravenholdt NPC for replacements before assuming the chain is blocked.",
},{pin(71,64.4,50,1,"Caverns of Time - descend to Dragon Soul"),pin(409,50.40,69.25,2,"Morchok - first raid boss","Dragon Soul"),pin(412,52.75,52.05,2,"Hagara - PICK POCKET before killing","Eye of Eternity - Dragon Soul"),pin(84,50.6,61.3,3,"Thaumaturge Rafir - 10,000-gold decoder charge"),pin(85,57.6,65.5,3,"Thaumaturge Altha - 10,000-gold decoder charge"),pin(241,29,25,4,"Corastrasza - cipher / Mostrasz flight"),pin(25,71.4,45.5,5,"Ravenholdt Manor - quest cellar"),pin(71,64.4,50,7,"Dragon Soul - 333 Shadowy Gems"),pin(42,47,75,8,"Original Karazhan approach - Zazzo's cellar mission"),pin(71,64.4,50,9,"Dragon Soul - 60 intact clusters"),pin(25,71.4,45.5,10,"Wrathion - accept Patricide BEFORE Madness"),pin(25,71.4,45.5,14,"Wrathion - final legendary pair")},
{"https://www.wowhead.com/quest=29801#comments:id=1630862","https://www.wowhead.com/quest=29801#comments:id=2050032","https://www.wowhead.com/quest=29802#comments:id=1570111","https://www.wowhead.com/quest=29802#comments:id=1590446","https://www.wowhead.com/quest=30116#comments:id=1602897","https://www.wowhead.com/quest=30116#comments:id=6240266","https://www.wowhead.com/quest=30118#comments:id=6206486"},
"This is the still-obtainable Cataclysm Rogue chain. It does not use Pandaria's removed legendary-cloak storyline, and no guild raid is needed for the personal daggers. The weeks required depend on cluster and gem drops; there is no guaranteed completion date.")
guides[6181].areaMaps={217,218}
guides[6181].sourceReplyIds={1847255,1863686}

