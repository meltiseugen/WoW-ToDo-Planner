local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("5.0", {
    cosmeticDetailGroups = {
        pandarenTabards = {
            acquisition = "Purchase the tabard from the matching faction emissary in Stormwind or Orgrimmar.",
            source = "Tushui Pandaren and Huojin Pandaren emissaries",
            sourceType = "Racial faction tabard",
            tips = "Wear the tabard in eligible dungeons if you still need its racial-faction reputation.",
        },
        pandariaTabards = {
            acquisition = "Reach Exalted with the matching Pandaria faction and purchase its tabard.",
            source = "Original Pandaria faction quartermasters",
            sourceType = "Reputation tabard",
            tips = "Work one daily hub at a time and buy Grand Commendations where available to accelerate account-wide reputation gains.",
        },
    },
    label = "Mists of Pandaria (Initial Release)",
    sourceNotes = {
        "This launch bucket includes patch 5.0.4, the Mists of Pandaria expansion launch, Pandaria's original zones and factions, Pet Battles, Challenge Modes, scenarios, Mists PvP Season 12, and the first raid tier.",
        "The audit uses original live availability and current collection IDs. Shop, Collector's Edition, promotion, calendar-event, hidden-statistic, NPC-only, unused-beta, and ordinary equipment records are excluded.",
        "Historical Challenge Mode, realm-first, raid, guild, and Season 12 achievement records remain listed even where the original acquisition path has ended. Theramore Tabard has a separately reviewed level-35 Retail scenario route.",
    },
    sourceUrls = {
        launch = "https://www.wowhead.com/news/mists-of-pandaria-launch-guide-206705",
        official = "https://worldofwarcraft.blizzard.com/en-gb/news/10026010",
        patch = "https://warcraft.wiki.gg/wiki/Patch_5.0.4",
        pets = "https://us.forums.blizzard.com/en/wow/t/pandarian-pets-and-where-to-find-them/2077368",
        roundup = "https://worldofwarcraft.blizzard.com/en-us/news/7305448/world-of-warcraft-mists-of-pandaria-round-up",
        toys = "https://us.forums.blizzard.com/en/wow/t/more-toys-for-your-toy-box-pandaria/2098920",
    },
    wowheadPatchId = 50004,
})

--[====[
Preserved inactive research: Data/Expansions/MistsOfPandaria/QuestRoutes.lua
This material is retained for reference and does not register character quest routes.

-- Character-specific Retail mount progression. No account quest flags are used.
-- Current English names/objectives: Wowhead Retail tooltips, dataEnv=1,
-- reviewed 2026-11-13. Pickup/prerequisite facts reuse the existing MIT-licensed
-- ATT Retail source index; source records are never mutated.
-- Additional gates: ATT Retail revision 7a793a77b08c8982d4ea0d64dcc81dd38e5fc984,
-- .contrib/.db/standard/06 - Expansion Features/05 - Mists of Pandaria/
-- Krasarang Wilds Campaign.lua and Order of the Cloud Serpent.lua.
local _,TDP=...
local guides=TDP.CollectionWalkthroughs.mounts
local routes=TDP.CollectionQuestRoutes
local sourceQuests=TDP.CollectionSourceIndex.quests
local function point(mapID,x,y) return {mapID=mapID,x=x/100,y=y/100} end
local function quest(id,name,instructions,options)
    local source=sourceQuests[id] or {}
    local q={questID=id,name=name,instructions=instructions,
        sourceURL="https://www.wowhead.com/quest="..id,
        requires=source.sourceQuests or {},requiredCount=source.sqreq,
        faction=source.faction,races=source.races,classes=source.classes,
        npcID=source.qgs and source.qgs[1],
        turnInReference=true,objectiveReference=true}
    local coord=source.coords and source.coords[1]
    if coord then q.pickup=point(coord[1],coord[2],coord[3]) end
    for key,value in pairs(options or {}) do q[key]=value end
    return q
end
local function define(key,name,quests,options)
    local route=options or {}
    route.key,route.name,route.quests,route.version=key,name,quests,1
    route.reviewedAt="2026-11-13"
    route.sourceRevision="7a793a77b08c8982d4ea0d64dcc81dd38e5fc984"
    routes[key]=route
    return route
end
local function attach(ids,route,optional)
    for _,id in ipairs(ids) do
        local guide=guides[id]
        if guide then
            guide.questRoutes=guide.questRoutes or {}
            guide.questRoutes[#guide.questRoutes+1]=route
            guide.keepReferencePins=true
            if optional then guide.questRoutesOptional=true end
        end
    end
end
local function gate(factionID,standing,offset)
    return {factionID=factionID,standing=standing,offset=offset}
end

-- The old imported Incoming... / Wrathion dependency is removed on these two
-- roots. Landfall remains available without the retired legendary cloak chain.
local alliance={
    quest(32246,"Meet the Scout","Accept the faction introduction at the Shrine of Seven Stars, then speak with Scout Lynna at Krasarang Cove (89.9,24.5). Use the earlier Vale if your shrine is in an assault phase.",{requires={},pickup=point(390,84.0,58.7),objective=point(418,89.9,24.5),turnIn=point(418,89.9,24.5),turnInReference=false,objectiveReference=false}),
    quest(32247,"A King Among Men","Accompany King Varian along the landing beach. Find Marshal Troteman and Hilda Hornswaggle and kill twenty-five Horde; remain with the escort until all three objectives are credited."),
    quest(32109,"Lion's Landing","Use the Flare Launcher in Krasarang Cove to summon the Alliance fleet. Stay for the base-establishment scene and complete the hand-in.",{pickup=point(418,89.9,24.5),pickupReference=true}),
    quest(32380,"The Best Around","Use the story portal offered at Lion's Landing to reach the Stormwind side of Deeprun Tram. Enter Bizmo's Brawlpub and find undercover agent Townsley; do not travel to the Ironforge end.",{minReputation=gate(1376,5,950)}),
    quest(32381,"To Catch A Spy","Take the Pink Marmot, Mogu Melon Twist and Rusty Dagger drinks and match each to the correct patron using their dialogue clues. Return to Townsley after all three deliveries.",{pickupReference=true}),
    quest(32426,"Stirred, Not Shaken","Use the Boom Room invitation and find Professor Kilt inside Bizmo's Brawlpub. Finish the conversation/event, then return through the campaign transport.",{pickupReference=true}),
    quest(32382,"He's In Deep","At Lion's Landing speak to Fennie Hornswaggle and take her kite to Connelly in Kun-Lai. Use this campaign transport to enter the correct quest phase.",{minReputation=gate(1376,5,4900)}),
    quest(32383,"Bugging Out","Plant a Cleverly Disguised Bug at the large tent, the small tents and the supplies in the camp. Do this alongside the journal-stealing errand."),
    quest(32397,"He Won't Even Miss It","Create the offered distraction in Garrosh's camp, then steal the Weathered Journal. Return this and Bugging Out before expecting the next chapter."),
    quest(32331,"The Kirin Tor","Return to Lion's Landing and take the Portal to the Purple Parlor. Meet Anduin in that story version of Dalaran, not an unrelated modern Dalaran phase.",{minReputation=gate(1376,6,2850)}),
    quest(32193,"To Mogujia","Speak to Fennie Hornswaggle at Lion's Landing and take the kite to Mogujia. Find Brann Bronzebeard and the expedition there.",{minReputation=gate(1376,6,6800)}),
    quest(32194,"Bad Blood","Collect five Korune Artifacts from Silvermoon Runeseekers, Dominance Mages or Dominance Knights. Complete The Source of Korune Power in the same area."),
    quest(32243,"The Source of Korune Power","Kill a Korune Spellweaver and loot its Sha-Touched Claw. Turn in both Mogujia errands; one alone does not unlock Anduin's Plea."),
    quest(32315,"Anduin's Plea","Use Fennie's kite from Lion's Landing to reach Anduin at the Shrine of Seven Stars.",{minReputation=gate(1376,6,10750)}),
    quest(32316,"Heart Of The Alliance","Confront and save six Sha-Touched Footmen with Anduin. If the companion is lost, find him again at the Imperial Exchange and continue the same quest.",{mobilePickup=true}),
    quest(32370,"The Kun-Lai Expedition","Take Fennie's campaign kite to the Grummle Bazaar and meet Connelly.",{minReputation=gate(1376,7,2700)}),
    quest(32377,"A Kor'kron In Our Midst","Obtain a Kor'kron Helmet, Armor and Boots from the indicated sources and combine all three into a Kor'kron Disguise."),
    quest(32371,"Memory Wine","Wear the Kor'kron Disguise to enter the camp. Drink the Memory Brew and use the vision's controls to witness Shan Kien's past; stay until the final objective completes."),
    quest(32393,"The Ruins of Korune","Return to Fennie at Lion's Landing and take the campaign kite to Sarannha Skyglaive at the Ruins of Korune.",{minReputation=gate(1376,7,6650)}),
    quest(32394,"The Divine Bell","Kill Dreadweaver Avartu and recover the Divine Bell. Complete the actual bell interaction before returning."),
    quest(32414,"Darnassus Attacked?","Ask Seamus Goldenkicks at Lion's Landing to send you to the campaign's Darnassus phase, then speak with Jaina. Do not use the burned present-day Teldrassil as your destination.",{minReputation=gate(1376,7,8600)}),
    quest(32460,"Tracking the Thieves","Follow Jaina's clues to identify the bell's thieves. Re-enter the Darnassus story using Seamus in Lion's Landing if you left; the quest may need to be reacquired near Darnassus' east gate.",{pickup=point(418,94.5,28.5),pickupReference=true,pickupLabel="Seamus at Lion's Landing - return to Jaina's Darnassus story"}),
    quest(32416,"Jaina's Resolution","Use Jaina's Darnassus-to-Dalaran story portal and speak with Vereesa on the other side. This chapter uses the Purge story phase.",{pickup=point(418,94.5,28.5),pickupReference=true,pickupLabel="Lion's Landing transport - Jaina's story portal"}),
    quest(32417,"Sewer Cleaning","Kill twelve hostile Sunreavers in the story Dalaran sewers. Accept the other four Vereesa errands before leaving the hub."),
    quest(32418,"Unfair Trade","Kill Inkmaster Aelon, Tolyria, Gearmage Astalon and Sintharia Cinderweave in the story city; collect all four named-target credits."),
    quest(32419,"Nowhere to Hide","Defeat sixteen Sunreavers in Sunreaver's Sanctuary in the campaign Dalaran phase."),
    quest(32420,"Cashing Out","Find and defeat Magister Brasael in the campaign Dalaran phase."),
    quest(32421,"Nowhere to Run","Subdue five Sunreaver Dragonhawks so they cannot fly. Use the quest's indicated interaction instead of assuming any nearby dragonhawk kill counts."),
    quest(32423,"What Had To Be Done","After all five Purge errands are handed in, speak to Vereesa for transport to Lion's Landing, then report to King Varian."),
    quest(32355,"The Harmonic Mallet","Take Fennie's kite from Lion's Landing to Anduin at the Tomb of Conquerors in Kun-Lai.",{minReputation=gate(1376,7,14540)}),
    quest(32321,"The Monkey King","Speak with Anduin, accompany him through the Valley of Emperors and release the Monkey King. Complete the escort rather than flying directly to its endpoint.",{mobilePickup=true}),
    quest(32332,"The First Riddle: Mercy","Recover the Untamed Amber described by the Monkey King's riddle. The other two riddles are parallel tasks and can be accepted together."),
    quest(32333,"The Second Riddle: Fellowship","Ring the Bell of Fellowship, defeat the summoned Acid-Spine Bonebreaker/challenger and obtain the Metal Brew."),
    quest(32334,"The Third Riddle: Strength","Go to the Tiger Temple and defeat the challenger. Finish all three riddles before returning for the Monkey King's story."),
    quest(32335,"The Greatest Prank","Listen to the Monkey King's full story. Wait for the conversation credit before trying the three mallet-component quests."),
    quest(32336,"The Handle","Recover the Mallet Handle at the quest-marked location. Collect the head and ointment in the same chapter.",{minReputation=gate(1376,7,18500)}),
    quest(32337,"The Head","Find the Royal Finder and recover the Mallet Head. Follow the quest marker to its current objective rather than returning to the Monkey King too early.",{minReputation=gate(1376,7,18500)}),
    quest(32338,"The Harmonic Ointment","Recover the Harmonic Ointment and turn in all three component quests.",{minReputation=gate(1376,7,18500)}),
    quest(32400,"The Bell Speaks","At Exalted, take Fennie's kite from Lion's Landing to Anduin at Emperor's Reach. Earlier Kun-Lai Loremaster progress does not replace this Landfall prerequisite chain.",{minReputation=gate(1376,8)}),
    quest(32401,"Breath of Darkest Shadow","Defeat Ishi, then perform the quest interaction that destroys the Divine Bell. Stay through Anduin's scene."),
    quest(32455,"The Silence","Use the Alliance Flare Gun at the finale, finish the scene and turn in the quest. Collect Grand Gryphon and learn the reward.",{turnIn=point(379,55.9,31.9),turnInReference=false}),
}
local horde={
    quest(32249,"Meet the Scout","Accept the faction introduction at the Shrine of Two Moons, then speak with Scout Rokla at the western Horde Landing Site in Krasarang Wilds.",{requires={},pickup=point(390,62.8,27.9),objective=point(418,8.7,64.3),turnIn=point(418,8.7,64.3),turnInReference=false,objectiveReference=false}),
    quest(32250,"The Might of the Warchief","Accompany Garrosh on the landing beach. Find Blood Guard Gro'tash and Grizzle Gearslip and kill twenty-five Alliance; stay until all escort objectives complete."),
    quest(32108,"Domination Point","Light the Signal Fire on the landing beach to summon the fleet. Complete the base-establishment scene and hand-in."),
    quest(32256,"Rise Of An Empire","Ask Tak-Tak at Domination Point for transport to Garrosh at the Shrine of Two Moons.",{minReputation=gate(1375,5,950)}),
    quest(32242,"Buried Secrets","Speak to Fanlyr Silverthorn at Ancestral Rise in the Vale. Use the chapter's current quest marker to reach the excavation."),
    quest(32257,"Voice of the Gods","Investigate the Mercurial Guardian and recover the Ancient Korune Tablet; complete both interaction and loot objectives."),
    quest(32284,"Someone You Should See","Take Tak-Tak's kite to Chen Stormstout at Binan Village in Kun-Lai Summit.",{minReputation=gate(1375,5,4900)}),
    quest(32318,"Regeneration Takes Time","Collect ten Sturdy Needles for Chen and return to the story camp."),
    quest(32319,"Find Thrall!","Use Vol'jin's Hearthstone to reach Thrall in the correct quest phase. Do not search present-day Orgrimmar for a different version of Thrall."),
    quest(32320,"The Horde Is Family","Speak to Thrall and accompany him to the Echo Isles. If he moves, follow the quest tracker/companion rather than treating the pickup reference as a permanent endpoint.",{mobilePickup=true}),
    quest(32372,"De-Subjugation","Defeat ten Kor'kron Overseers, five Kor'kron Subjugators and Gul'tar the Subjugator in the quest's Echo Isles phase."),
    quest(32190,"To Mogujia","Take Tak-Tak's campaign kite from Domination Point and meet Lor'themar at Mogujia.",{minReputation=gate(1375,6,2850)}),
    quest(32191,"Ancient Guardians","Kill five Korune Guardians near the expedition. Pick up Bloodlines and The Korune before clearing the area."),
    quest(32192,"Bloodlines","Kill Korune Wardens to release six captured Domination Mages. Simply killing unrelated mogu does not free the required prisoners."),
    quest(32244,"The Korune","Kill the Korune Spellweaver and loot its Korune Codex. Turn in all three Mogujia errands."),
    quest(32376,"To the Valley!","Ask Tak-Tak for transport to your 'Friend from Silvermoon' in the Valley of Emperors.",{minReputation=gate(1375,6,6800)}),
    quest(32378,"Clearing a Path","Kill ten Korune Mogu while collecting the documents for Legacy of the Korune."),
    quest(32379,"Legacy of the Korune","Read/recover Legacy of the Korune in the valley and loot the Sealed Korune Artifact and Korune Orders from the mogu. All three records are required."),
    quest(32384,"Trapping the Leader","Weaken Shan Kien at the Tomb of Shadows and use the offered capture interaction. Avoid killing him with uncontrolled high-level damage."),
    quest(32351,"Echoes of Thunder","Take Tak-Tak's transport to Baine at the Shrine of Two Moons.",{minReputation=gate(1375,6,10750)}),
    quest(32352,"A Gathering Storm","Confront and save six Sha-Touched Grunts in the shrine's campaign phase."),
    quest(32329,"Get My Results!","Use the Sunreaver campaign portal from Domination Point and report to Lor'themar. Follow the quest's Silvermoon phase; the original outdoor Silvermoon map coordinate is not used as a current destination.",{minReputation=gate(1375,7,2700)}),
    quest(32330,"What's in the Box?","In the campaign Silvermoon visit the Arcanis Mechanica, speak to Aethas and Rommath and help contain the experiment. Use Domination Point's story portal if returning; do not search the rebuilt city's ordinary NPC phases.",{pickup=point(418,10.4,53.7),pickupReference=true,pickupLabel="Domination Point story portal - reach Lor'themar's experiment"}),
    quest(32363,"The Kun-Lai Expedition","Take Tak-Tak's kite to Baine at Garrosh'ar Advance.",{minReputation=gate(1375,7,6650)}),
    quest(32448,"Ties with the Past","Recover the Spirit Essence of Varatus at the quest-marked location and return to Baine."),
    quest(32368,"Memory Wine","Drink the Memory Wine and complete Shan Kien's vision. Use the vision's action buttons and wait for the final witnessed-past credit."),
    quest(32391,"The Ruins of Korune","Return to Tak-Tak and take the kite to Ishi at the Ruins of Korune.",{minReputation=gate(1375,7,10515)}),
    quest(32392,"The Divine Bell","Defeat Sarannha Skyglaive and finish the bell-recovery scene before returning to Domination Point."),
    quest(32326,"Insertion","Use the Sunreaver Portal at Domination Point to enter the campaign Darnassus phase. The present-day burned city is not the quest destination.",{minReputation=gate(1375,7,14540)}),
    quest(32327,"The Darnassus Mission","Sneak through the Cenarion Enclave and locate the Divine Bell. Use the Silvermoon Charm to return to Fanlyr if needed; stay in the story phase.",{pickup=point(418,10.4,53.7),pickupReference=true,pickupLabel="Domination Point Sunreaver portal - story Darnassus"}),
    quest(32328,"Victorious Return","Report the successful Darnassus mission to General Nazgrim at Domination Point.",{pickup=point(418,10.4,53.7),pickupReference=true,pickupLabel="Return through the campaign portal to General Nazgrim"}),
    quest(32402,"The Situation In Dalaran","Speak to Kromthar at Domination Point for the campaign ride to Dalaran.",{minReputation=gate(1375,7,18500)}),
    quest(32403,"It Starts in the Sewers","Follow Rommath and evacuate nine Sunreaver Citizens in the story Dalaran sewers.",{mobilePickup=true}),
    quest(32404,"Violence in the Arena","Kill six Silver Covenant Enforcers and four Silver Covenant Spellbows in the campaign arena.",{mobilePickup=true}),
    quest(32405,"Hand of the Silver Covenant","Defeat Sorin Magehand, then continue with Rommath.",{mobilePickup=true}),
    quest(32406,"A Tactical Assault","Follow Grand Magister Rommath into the centre of the story city. Remain with the escort until its objective completes.",{mobilePickup=true}),
    quest(32408,"The Silver Covenant's Stronghold","Defeat Arcanist Rathaella. Accept this, The Kirin Tor's True Colors and Krasus' Landing together.",{mobilePickup=true}),
    quest(32409,"The Kirin Tor's True Colors","Kill Lieutenant Corwin and ten Stormwind troops in campaign Dalaran.",{mobilePickup=true}),
    quest(32410,"Krasus' Landing","Free six Sunreaver Dragonhawks at Krasus' Landing. Complete all three city errands before continuing.",{mobilePickup=true}),
    quest(32411,"The Remaining Sunreavers","Use the Tear of the Sin'dorei on Uda the Beast, High Arcanist Savor, Magister Hathorel, Magister Surdiel and Magistrix Vesara. Rescue all five named targets.",{mobilePickup=true}),
    quest(32412,"One Last Grasp","Defeat Mage-Commander Zuros and complete the escape from Dalaran with Rommath.",{mobilePickup=true}),
    quest(32413,"A Return to Krasarang","Optional return handoff: report to Nazgrim at Domination Point. If you left the scenario before accepting it, use the campaign ride back to Dalaran and speak with Rommath.",{optional=true,pickupReference=true}),
    quest(32398,"The Bell Speaks","At Exalted, use Tak-Tak's kite to reach Malkorok at Emperor's Reach. The optional return breadcrumb is not an additional mandatory unlock.",{requires={32412},minReputation=gate(1375,8)}),
    quest(32399,"Breath of Darkest Shadow","Witness the bell event, defeat Blademaster Ishi and complete the Anduin confrontation. Stay for the final credit and turn-in, then collect and learn Grand Wyvern.",{turnIn=point(379,55.9,33.9),turnInReference=false}),
}
local function landfall(side,quests,rep,endID,reward,vendor)
    local hub=side=="Alliance" and point(418,94.5,28.5) or point(418,10.4,53.7)
    local route=define("mop-landfall-"..side:lower(),side.." Landfall campaign",quests,{
        faction=side,endQuestID=endID,rankFactionID=rep,grindStanding=8,
        grindPin=hub,grindInstructions="The next chapter is reputation-gated. Finish the offered base dailies or use the appropriate Pandaria Timewalking commendations. At Revered buy and use the faction's Grand Commendation; some chapters require an amount partway through the rank.",
        completionPin=side=="Alliance" and point(379,55.9,31.9) or point(379,55.9,33.9),
        completionText="Campaign complete - collect and learn the unarmoured "..reward,
        after="Only this character's quest flags advance this campaign. Story transports enter the required phases. Active quest waypoints take precedence over the labelled static pickup/hand-in references.",
    })
    attach({side=="Alliance" and 136163 or 136164},route)
    local base={quests[1],quests[2],quests[3]}
    local vendorRoute=define("mop-landfall-vendor-"..side:lower(),side.." Landfall base and armoured mount",base,{
        faction=side,factionID=rep,standing=8,unlockQuestIDs={side=="Alliance" and 32109 or 32108},rankFactionID=rep,
        satisfiedPin=vendor,completionPin=vendor,
        satisfiedText="Base access and Exalted reputation are ready. Buy the armoured mount from the quartermaster.",
        completionText="Base established - earn Exalted, then buy the armoured mount here",
        after="The later Landfall chapters award a DIFFERENT unarmoured mount. They are not added as requirements for this vendor purchase.",
    })
    attach({side=="Alliance" and 135416 or 135418},vendorRoute)
end
landfall("Alliance",alliance,1376,32455,"Grand Gryphon",point(418,94.5,29.2))
landfall("Horde",horde,1375,32399,"Grand Wyvern",point(418,10.8,53.4))

-- Three parallel island errands converge before the egg choice; three egg
-- colours are verified alternatives, not three mandatory hatchlings.
local cloudQuests={
    quest(30134,"Wild Things","Speak to Elder Anli at the Arboretum, then fly to Instructor Tong on Windward Isle. The optional shrine breadcrumbs are not mandatory.",{requires={},pickup=point(371,57.7,45.0),objective=point(371,65.3,31.6),turnIn=point(371,65.3,31.6),turnInReference=false,objectiveReference=false}),
    quest(30135,"Beating the Odds","Kill the attacking saurok on Windward Isle. Accept Empty Nests and Egg Collection at the same time.",{requires={30134},pickup=point(371,65.3,31.6),turnIn=point(371,65.3,31.6),turnInReference=false}),
    quest(30136,"Empty Nests","Rescue the Windward hatchlings around the island and return to Instructor Tong.",{requires={30134},pickup=point(371,65.3,31.6),turnIn=point(371,65.3,31.6),turnInReference=false}),
    quest(30137,"Egg Collection","Recover the stolen serpent eggs on Windward Isle. Hand in all three introductory errands.",{requires={30134},pickup=point(371,65.3,31.6),turnIn=point(371,65.3,31.6),turnInReference=false}),
    quest(30138,"Choosing the One","Choose a green egg for Jade, blue for Azure or yellow for Golden. This selects the free mount's colour; the other colours remain purchasable at Exalted.",{requires={30135,30136,30137},pickup=point(371,65.3,31.6),turnIn=point(371,65.3,31.6),turnInReference=false}),
    quest(30139,"The Rider's Journey - your chosen egg","Take the chosen egg from Tong back to Instructor Skythorn at the Arboretum. The blue, green and yellow versions all satisfy this one handoff.",{requires={30138},altQuests={30140,30141},pickup=point(371,65.3,31.6),objective=point(371,57.5,45.1),turnIn=point(371,57.5,45.1),turnInReference=false,objectiveReference=false}),
    quest(30142,"It's A...","Complete the hatchling introduction with Instructor Skythorn at the Arboretum. The hatchling and offered dailies become available afterward.",{requires={30139},pickup=point(371,57.5,45.1),turnIn=point(371,57.5,45.1),turnInReference=false}),
    quest(30143,"They Grow Like Weeds","At Revered, speak with Elder Anli about your growing serpent, then meet Instructor Windblade for flight lessons.",{requires={30142},minReputation=gate(1271,7),pickup=point(371,57.6,44.9),turnIn=point(371,58.5,43.7),turnInReference=false}),
    quest(30144,"Flight Training: Ring Round-Up","Use the serpent vehicle and fly through six Cloud Rings. Follow the quest's flight controls rather than trying to complete it on an ordinary journal mount.",{requires={30143},pickup=point(371,58.5,43.7),minReputation=gate(1271,7)}),
    quest(30145,"Flight Training: Full Speed Ahead","Stay with Instructor Windblade's flying escort. Cut corners and use Cloud Rings for speed so you do not lose the instructor; wait for the final escort credit.",{requires={30144},pickup=point(371,58.5,43.7),minReputation=gate(1271,7)}),
    quest(30187,"Flight Training: In Due Course","Ride your trained serpent through all ten checkpoints in order and return to Windblade.",{requires={30145},pickup=point(371,58.5,43.7),minReputation=gate(1271,7)}),
    quest(30188,"Riding the Skies - your trained colour","At Exalted, complete Elder Anli's graduation and collect the serpent matching your egg. Any of the three colour finales completes this training route; buy additional colours from San Redscale.",{requires={30187},altQuests={31810,31811},pickup=point(371,57.7,45.0),minReputation=gate(1271,8)}),
}
local egg=quest(31784,"Onyx To Goodness","Search the rock pillars/ledges around Windward Isle for Onyx Eggs. With one in your bags, return to Elder Anli. This repeatable reputation delivery never counts as another permanent quest step.",{
    requires={30142},pickup=point(371,57.6,44.8),objective=point(371,66.6,28.7),repeatItemID=89155,repeatItemCount=1,repeatItemLabel="Onyx Eggs",turnIn=point(371,57.6,44.8),turnInReference=false,
})
local cloud=define("mop-cloud-serpent-training","Order of the Cloud Serpent - hatchling to graduation",cloudQuests,{
    endQuestIDs={30188,31810,31811},rankFactionID=1271,grindStanding=8,
    repeatableQuests={egg},
    grindPin=point(371,57.7,45.0),grindInstructions="Finish today's available Arboretum/hatchling dailies or hand in Onyx Eggs. At Revered use the Grand Commendation before earning more reputation.",
    completionPin=point(371,56.6,44.4),completionText="Training complete - learn the free colour or buy additional colours from San Redscale",
    after="The old Cloud Serpent Riding skill is removed. A different trained colour still completes this route; it does not falsely grant ownership of the selected mount.",
})
attach({113199,123992,123993},cloud)

local onyx=define("mop-onyx-cloud-serpent","Shado-Pan - Onyx Cloud Serpent finale",{
    quest(31266,"Mogu Incursions","At Exalted, accept the quest at Shado-Pan Garrison and find/kill the Shan'ze Spymaster. Return to the garrison; Golden Lotus reputation is not required.",{requires={},minReputation=gate(1270,8),pickup=point(388,49.5,70.5)}),
    quest(31277,"Surprise Attack!","Meet Ban Bearheart outside Niuzao Temple, join the battle and defeat the mogu invasion. Stay through the completion event and return for the Onyx Cloud Serpent reward.",{requires={31266},pickup=point(388,49.5,70.5),objective=point(388,39.0,62.0),objectiveReference=true}),
},{endQuestID=31277,rankFactionID=1270,grindStanding=8,grindPin=point(388,49.0,70.5),
    grindInstructions="Earn Shado-Pan Exalted from garrison dailies, stolen insignias or Timewalking commendations. Use the Grand Commendation at Revered.",
    completionPin=point(388,49.5,70.5),completionText="Finale completed - learn Reins of the Onyx Cloud Serpent",after="A completed finale on this character does not restart because another character has different quest flags."})
attach({127154},onyx)

local klaxxi=define("mop-klaxxi-introduction","Klaxxi - Terrace of Gurthan introduction",{
    quest(31001,"Falling Down","Take Bowmistress Li's Shado-Pan Rope from the Serpent's Spine wall and descend to find Marksman Lann in the Terrace of Gurthan. Optional Dread Space/capital breadcrumbs are not mandatory.",{requires={},pickup=point(390,14.1,76.9),objective=point(422,72.5,28.6),turnIn=point(422,72.5,28.6),turnInReference=false,objectiveReference=false}),
    quest(31002,"Nope","Take the Shado-Pan Dragon Gun from Bowmistress Li. Destroy twenty Dreadspinner Eggs and kill six Dreadspinner Tenders around the terrace; finish this alongside Falling Down.",{requires={},pickup=point(390,14.1,76.9),objective=point(422,72.5,28.6),turnIn=point(422,72.5,28.6),turnInReference=false,objectiveReference=true}),
    quest(31003,"Psycho Mantid","After both wall/rescue errands, investigate the mantid fighting and defeat Adjunct Kree'zot. Speak with Klaxxi'va Tik at the terrace.",{requires={31001,31002},pickup=point(422,72.5,28.6),turnIn=point(422,73.6,27.5),turnInReference=false}),
    quest(31004,"Preserved in Amber","Use Klaxxi'va Tik's Klaxxi Tuning Fork on the Ancient Amber Chunk to awaken Kil'ruk the Wind-Reaver.",{requires={31003},pickup=point(422,73.6,27.5),objective=point(422,70.1,25.6),turnIn=point(422,70.1,25.6),turnInReference=false,objectiveReference=false}),
    quest(31005,"Wakening Sickness","Kill the terrace sapflies and collect one hundred Sapfly Bits for Kil'ruk. Accept Ancient Vengeance at the same time.",{requires={31004},pickup=point(422,70.1,25.6),turnIn=point(422,70.1,25.6),turnInReference=false}),
    quest(31676,"Ancient Vengeance","Kill six Vengeful Gurthani Spirits around the terrace and return to Kil'ruk. Both this and Wakening Sickness precede the Council handoff.",{requires={31004},pickup=point(422,70.1,25.6),turnIn=point(422,70.1,25.6),turnInReference=false}),
    quest(31006,"The Klaxxi Council","Speak with Kil'ruk for a ride, or travel to Klaxxi'vess yourself. Finish the Council introduction in the central settlement.",{requires={31005,31676},pickup=point(422,70.1,25.6),objective=point(422,55.0,35.5),turnIn=point(422,55.0,35.5),turnInReference=true,objectiveReference=true}),
},{optional=true,factionID=1337,standing=8,rankFactionID=1337,completionPin=point(422,55.0,35.5),satisfiedPin=point(422,55.0,35.5),
    completionText="Introduction complete - earn Klaxxi Exalted and buy from Ambersmith Zikk",
    after="The Amber Scorpion is a reputation purchase, not the reward for completing every Dread Wastes side story. Use the retained guide's insignia/commendation alternatives if you prefer."})
attach({123886},klaxxi,true)

local tillers=define("mop-tillers-introduction","Tillers - Learn and Grow farm introduction",{
    quest(30252,"A Helping Hand","At Sunsong Ranch clear eight Unbudging Rocks for Farmer Yoon.",{requires={},pickup=point(376,52.0,48.1),objective=point(376,52.0,48.6),turnIn=point(376,52.2,48.8),turnInReference=false,objectiveReference=false}),
    quest(30535,"Learn and Grow I: Seeds","Speak with Merchant Greenfield at Halfhill Market and obtain the Packet of Green Cabbage Seeds, then return to Yoon.",{requires={30252},pickup=point(376,52.2,48.8),objective=point(376,52.8,52.0),turnIn=point(376,52.2,48.8),turnInReference=false,objectiveReference=false}),
    quest(30254,"Learn and Grow II: Tilling and Planting","Till two soil plots and plant the two EZ-Gro Green Cabbage Seeds in them. Use Yoon's quest seeds for the lesson.",{requires={30535},pickup=point(376,52.2,48.8),objective=point(376,52.0,48.4),turnIn=point(376,52.2,48.8),turnInReference=false,objectiveReference=false}),
    quest(30255,"Learn and Grow III: Tending Crops","Take the Rusty Watering Can beside the field and water both Parched EZ-Gro Green Cabbages.",{requires={30254},pickup=point(376,52.2,48.8),objective=point(376,52.0,48.4),turnIn=point(376,52.2,48.8),turnInReference=false,objectiveReference=false}),
    quest(30256,"Learn and Grow IV: Harvesting","Harvest both ripe EZ-Gro Green Cabbages and bring them to Farmer Yoon.",{requires={30255},pickup=point(376,52.2,48.8),objective=point(376,52.0,48.4),turnIn=point(376,52.2,48.8),turnInReference=false,objectiveReference=false}),
    quest(30257,"Learn and Grow V: Halfhill Market","Investigate the Dark Soil under Yoon's house, take the Marsh Lily and give the gift to Gina Mudclaw at Halfhill Market.",{requires={30256},pickup=point(376,52.2,48.8),objective=point(376,52.8,48.1),turnIn=point(376,53.2,51.6),turnInReference=false,objectiveReference=false}),
    quest(31945,"Learn and Grow VI: Gina's Vote","Buy Scallion Seeds, plant and tend one Scallion, then wait for the next daily growth reset and harvest it. Deliver five Scallions to Gina; extra purchased scallions do not replace the personal plant/harvest objectives.",{requires={30257},pickup=point(376,52.2,48.8),objective=point(376,52.0,48.4),turnIn=point(376,53.2,51.6),turnInReference=false,objectiveReference=false}),
},{optional=true,factionID=1272,standing=8,rankFactionID=1272,completionPin=point(376,53.2,51.6),satisfiedPin=point(376,53.2,51.6),
    completionText="Farm introduction complete - earn Tillers Exalted, then buy the selected goat",
    after="Individual farmers' friendship is not The Tillers faction bar. The guide retains Timewalking commendations as an alternative to the farm/daily reputation route."})
attach({130086,130137,130138},tillers,true)

local bones=define("mop-bone-white-raptor","Bone-White Primal Raptor - bone exchange",{
    quest(32617,"A Mountain of Giant Dinosaur Bones","Collect 9,999 Giant Dinosaur Bones from Isle of Giants dinosaurs or the Auction House. Carry them to Ku'ma inside the west-side cave and exchange them for the Bone-White Primal Raptor.",{
        requires={},pickup=point(507,32.6,54.6),turnIn=point(507,32.6,54.6),turnInReference=false,
        requiredItemID=94288,requiredItemCount=9999,itemRequirementText="Carry 9,999 Giant Dinosaur Bones in this character's bags for Ku'ma's exchange.",
    }),
},{endQuestID=32617,progressItemID=94288,progressRequired=9999,progressLabel="Giant Dinosaur Bones on this character",
    grindPin=point(507,45.0,70.0),grindLocationType="Farm",
    grindInstructions="Farm Isle of Giants dinosaurs or buy bones until 9,999 are in your bags. Character-bank bones can appear in the counter but must be withdrawn before the exchange; other characters' bank stock is not ready to turn in.",
    completionPin=point(507,32.6,54.6),completionText="Exchange completed - learn the Bone-White Primal Raptor",
    after="The small bone exchanges are optional and are not prerequisites. Primal Egg hatches are a separate random-colour route."})
attach({138640},bones)

-- Both island introductions, including phase-specific boat reference anchors.
-- Vendor reputation can be earned with tokens; the full later island campaign
-- and Thunder Forge scenarios are not mandatory mount-purchase quests.
for _, side in ipairs({
    {"Alliance",32679,32681,32644,1387,140249,"Vereesa Windrunner",49.8,69.0,34.6,89.5,64.6,74.6},
    {"Horde",32678,32680,32212,1388,140250,"Scout Captain Elsia",50.8,73.2,28.4,52.2,33.4,32.4},
}) do
    local shrine=side[1]=="Alliance" and point(390,84.0,58.8) or point(390,62.8,28.0)
    local departure=point(388,side[8],side[9])
    local boat=point(504,side[10],side[11])
    local vendor=point(504,side[12],side[13])
    local quests={
        quest(side[2],"Thunder Calls","Accept the introduction from "..(side[1]=="Alliance" and "Lyalia at the Shrine of Seven Stars" or "Sunwalker Dezco at the Shrine of Two Moons")..", then report to "..side[7].." at Shado-Pan Garrison.",{requires={},faction=side[1],pickup=shrine,objective=departure,turnIn=departure,turnInReference=false,objectiveReference=false}),
        quest(side[3],"The Storm Gathers","Speak to "..side[7].." and take the offered flight to the Isle of Thunder. Finish the discovery/arrival credit and hand in to "..(side[1]=="Alliance" and "Jaina" or "Lor'themar").." on the ship, or at the established base if your phase has already advanced.",{requires={side[2]},faction=side[1],pickup=departure,turnIn=boat,turnInReference=true,turnInLabel="Island ship initially; established faction base in the later phase - follow the quest marker"}),
        quest(side[4],side[1]=="Alliance" and "The Assault on Shaol'mara" or "The Assault on Zeb'tula","If offered on the ship, speak to your faction leader to enter the landing assault scenario. Follow every stage, secure the landing site and finish the scene/hand-in. This establishes the ground base; later island campaigns are not additional mount-purchase requirements.",{requires={side[3]},faction=side[1],pickup=boat,pickupReference=true,turnIn=vendor,turnInReference=true,optional=true}),
    }
    local route=define("mop-thunder-vendor-"..side[1]:lower(),side[1].." Isle of Thunder access",quests,{
        optional=true,faction=side[1],factionID=side[5],standing=8,unlockQuestIDs={side[3]},rankFactionID=side[5],
        completionPin=vendor,satisfiedPin=vendor,
        completionText="Island access ready - earn Exalted and buy the faction direhorn",
        after="A quartermaster can be on the introductory ship or at the established base according to your story phase. Follow active Blizzard quest waypoints; static hand-ins are labelled phase references. Timewalking tokens do not complete character access quests.",
    })
    attach({side[6]},route,true)
    local access=define("mop-thunder-nalak-"..side[1]:lower(),side[1].." access route for Nalak",{quests[1],quests[2]},{
        optional=true,faction=side[1],endQuestID=side[3],completionPin=point(504,60.0,37.7),completionText="Island access complete - find Nalak outside Throne of Thunder",
        after="The remaining Isle of Thunder campaign is not required to tag Nalak. Weekly boss loot and Mogu Rune attempts remain separate from quest completion.",
    })
    attach({139442,136471,139448,136400},access,true)
end

-- Story scrolls are item-started, independent one-time deliveries. An account
-- lore achievement alone is not evidence that this character has its letter.
local loreQuests={quest(31015,"Your Private Collection","Accept Cho's introduction at the Seat of Knowledge and clean off the Empty Bookshelf. The optional capital breadcrumbs are not mandatory; this prepares your collection before the independently mailed stories.",{
    requires={},optional=true,pickup=point(390,83.2,29.6),turnIn=point(390,83.2,29.6),turnInReference=false,
})}
for _, entry in ipairs({
    {31055,"Between a Saurok and a Hard Place",{83076,83769}},
    {31094,"Fish Tales",{83771}},
    {31097,"Heart of the Mantid Swarm",{83773}},
    {31093,"Hozen in the Mist",{83770}},
    {31103,"The Ballad of Liu Lang",{83780}},
    {31095,"The Dark Heart of the Mogu",{83772}},
    {31102,"The Seven Burdens of Shaohao",{83779}},
    {31100,"The Song of the Yaungol",{83777}},
    {31096,"What Is Worth Fighting For",{83774}},
}) do
    loreQuests[#loreQuests+1]=quest(entry[1],entry[2],"Complete this lore-object collection, retrieve its story scroll from the mailbox and use the scroll. Deliver it to Lorewalker Cho at the Seat of Knowledge, then let his story finish before the next delivery.",{
        requires={},startItemID=entry[3][1],startItemIDs=entry[3],requiresStartItem=true,
        pickup=point(390,83.2,29.6),turnIn=point(390,83.2,29.6),turnInReference=false,
        pickupLabel="Use the mailed story scroll, then visit Lorewalker Cho",
        itemRequirementText="Read the matching lore objects, then collect this story's quest scroll from your mailbox.",
    })
end
local lore=define("mop-lorewalker-scrolls","Lorewalkers - mailed story scrolls",loreQuests,{
    optional=true,factionID=1345,standing=8,rankFactionID=1345,satisfiedPin=point(390,82.2,29.4),
    satisfiedText="Lorewalkers Exalted - buy the Disc of the Red Flying Cloud from Tan Shin Tiao",
    completionPin=point(390,82.2,29.4),completionText="Story deliveries complete - check reputation and buy the disc",
    after="The nine stories are independent, not a forced sequence. Active stories or a letter already in your bags take priority. Only enough reputation to buy the mount is required; the guide's numbered map route retains every lore-object location.",
})
attach({130092},lore,true)

-- Optional self-crafting reputation routes stop at the recipe's actual rank;
-- they do not require an Exalted graduation for an Honored panther design.
local cloudRep={}
for _, rank in ipairs({6,7,8}) do
    local introduction={}
    for index=1,7 do introduction[index]=cloudQuests[index] end
    cloudRep[rank]=define("mop-cloud-recipe-rank-"..rank,"Order of the Cloud Serpent - reputation access",introduction,{
        optional=true,factionID=1271,standing=rank,rankFactionID=1271,grindStanding=rank,
        repeatableQuests={egg},completionPin=point(371,56.6,44.4),satisfiedPin=point(371,56.6,44.4),
        completionText="Hatchling introduction complete - reach the design's required reputation rank",
        satisfiedText="Recipe reputation requirement met - visit San Redscale",
        after="This is the optional self-crafting route. A finished Auction House panther requires no profession or Order reputation. The selected design's requirement, rather than the free serpent graduation, ends this route.",
    })
end
attach({121837,121839},cloudRep[6],true)
attach({121836,121838},cloudRep[7],true)
attach({120043},cloudRep[8],true)

-- Ambassador is a reputation milestone. Retain only optional introductions
-- that help its existing methods; do not impose the free-serpent finale.
for _, original in ipairs({cloudRep[8],klaxxi,tillers,lore}) do
    local copy={}
    for key,value in pairs(original) do copy[key]=value end
    copy.key=original.key.."-ambassador"
    copy.compact=true
    copy.optional=true
    copy.satisfiedText="This faction's Exalted requirement is met on the current character."
    copy.completionText="Introduction complete - continue this faction to Exalted for Pandaren Ambassador"
    copy.after="This is an optional reputation method for Pandaren Ambassador. Use the original guide's token alternatives where available; unfinished optional quests are not extra achievement requirements."
    routes[copy.key]=copy
    attach({118737,130985},copy,true)
end

-- Reuse the existing current specialization quest routes only as OPTIONAL
-- self-crafting methods; buying a finished rocket needs no Engineering.
for _, side in ipairs({"alliance","horde"}) do
    for _, spec in ipairs({{"goblin",126507},{"gnomish",126508}}) do
        local original=routes["classic-"..spec[1].."-"..side]
        if original then
            local copy={}
            for key,value in pairs(original) do copy[key]=value end
            copy.key="mop-rocket-"..spec[1].."-"..side
            copy.optional=true
            routes[copy.key]=copy
            attach({spec[2]},copy,true)
        end
    end
end

]====]
