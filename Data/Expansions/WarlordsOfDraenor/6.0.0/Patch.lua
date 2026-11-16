local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("6.0.0", {
    cosmeticDetailGroups = {
        cityTabards = {
            acquisition = "Build a level 1 Dwarven Bunker or War Mill and complete Scraps of Iron with five Iron Horde Scraps.",
            source = "Scraps of Iron at your own Dwarven Bunker or War Mill",
            sourceType = "Quests",
            tips = "These guard-uniform tabards are one-time quest rewards. They do not champion city reputation.",
        },
        reputationTabards = {
            acquisition = "Reach Exalted with the matching faction and purchase its tabard.",
            source = "Draenor faction quartermasters",
            sourceType = "Reputation reward",
            tips = "Use the item's reviewed reputation method and faction-specific vendor. Medallions do not grant Ashran reputation.",
        },
    },
    label = "Warlords of Draenor (Initial Release)",
    sourceNotes = {
        "This launch bucket includes the 6.0.2 Iron Tide systems update, the 6.0.3 expansion launch, Highmaul, and Blackrock Foundry—the complete initial Warlords collection tier before patch 6.1.",
        "The audit reconciles the final Legion-era client database with contemporary collection guides and All The Things source metadata. Store, Collector's Edition, promotion, calendar-event, hidden, test, NPC-only, and ordinary equipment records are excluded.",
        "The Retail mount review removes the retired Challenge Mode and original Gladiator rewards. Obtainable Ashran, Garrison, reputation and raid mounts have detailed current acquisition routes; cross-expansion collection milestones are placed under General.",
        "The Retail cosmetic review retains ten obtainable launch items with numbered guides and removes Primal Gladiator's Tabard (115972), whose elite season has ended.",
    },
    sourceUrls = {
        mounts = "https://www.wowhead.com/guide/vanity-collections/mounts-from-the-garrison",
        official = "https://worldofwarcraft.blizzard.com/en-us/news/15682579/the-iron-tide-602-patch-notes",
        overview = "https://www.wowhead.com/guide/warlords-of-draenor-an-expansion-overview-6120",
        pets = "https://www.wowhead.com/guide/battle-pets/battle-pet-updates-in-warlords-of-draenor",
        release = "https://worldofwarcraft.blizzard.com/en-us/news/16365525/patch-602-now-live-the-iron-tide-crashes-into-azeroth",
        toys = "https://www.wowhead.com/guide/toy-box-a-look-inside-the-box-2381",
    },
    wowheadPatchId = 60000,
})

--[====[
Preserved inactive research: Data/Expansions/WarlordsOfDraenor/QuestRoutes.lua
This material is retained for reference and does not register character quest routes.

-- Authored Retail progression data. Loaded after CollectionSourceIndex and
-- QuestProgress; never mutates imported source records or account quest flags.
-- Progress is read only when the user explicitly opens an item's map.
local _,TDP=...
local guides=TDP.CollectionWalkthroughs.mounts
TDP.CollectionQuestRoutes=TDP.CollectionQuestRoutes or {}
local routes=TDP.CollectionQuestRoutes
local function point(mapID,x,y) return {mapID=mapID,x=x/100,y=y/100} end
local function quest(id,name,instructions,pickup,objective,turnIn,options)
    local result={questID=id,name=name,instructions=instructions,
        pickup=pickup,objective=objective,turnIn=turnIn or pickup,
        sourceURL="https://www.wowhead.com/quest="..id}
    for key,value in pairs(options or {}) do result[key]=value end
    return result
end
local function attach(ids,route)
    route.version,route.reviewedAt=1,"2026-11-14"
    routes[route.key]=route
    for _,id in ipairs(ids) do
        local guide=guides[id]
        if guide then
            guide.questRoutes=guide.questRoutes or {}
            guide.questRoutes[#guide.questRoutes+1]=route
            guide.keepReferencePins=true
        end
    end
end
local sides={
    {name="Alliance",key="alliance",hub=point(582,40,37),town=point(582,32,32),fishing=point(582,54,14)},
    {name="Horde",key="horde",hub=point(590,52,50),town=point(590,41,56),fishing=point(590,38,72)},
}

-- Every capture and unique training quest is listed, including both faction
-- versions. Completion is checked on the current character, not the Warband.
for _,mount in ipairs(TDP.WarlordsStableMounts) do
    for _,side in ipairs(sides) do
        local alliance=side.name=="Alliance"
        local captureID=alliance and mount[6] or mount[7]
        local startID=alliance and mount[13] or mount[14]
        local quests={quest(captureID,mount[5],
            "Build a level 1 Stables and ask its trainers for this capture introduction. New beast introductions are staggered across daily resets. "..mount[11].." Return to the same Stables trainer after the capture.",
            side.hub,point(mount[8],mount[9],mount[10]),side.hub,
            {requires={},pickupReference=true,turnInReference=true,pickupLabel="Your Stables trainer - building plot varies",turnInLabel="Return the capture to your Stables trainer"})}
        for index=mount[12],#TDP.WarlordsStableTargets do
            local target=TDP.WarlordsStableTargets[index]
            local id=startID+index-mount[12]
            local first=#quests==1
            local options={pickupReference=true,turnInReference=true,
                pickupLabel="Stables - next daily training offer",turnInLabel="Stables - hand in today's training",
                requires={first and captureID or quests[#quests].questID}}
            -- Horde Rakkiri is offered after its introductory capture; the old
            -- source index incorrectly links it through the optional Black Claw.
            -- Keep the historical Great-Tusk counterpart inspectable without
            -- forcing a stage which that faction's trainer may skip.
            if not alliance and mount[4]=="Clefthoof" and index==1 then options.optional=true end
            if not alliance and mount[4]=="Clefthoof" and index==2 then options.requires={captureID} end
            quests[#quests+1]=quest(id,mount[4].." Training: "..target[1],
                "Accept the next "..mount[4].." Training quest at your Stables. If today's previous stage was just handed in and the trainer offers nothing, return after the daily reset. Use this beast's supplied whistle before the fight and remain mounted for credit. "..target[5].." Return to the Stables to hand it in; dismiss combat pets if they dismount you.",
                side.hub,point(target[2],target[3],target[4]),side.hub,options)
        end
        attach({mount[1]},{key="wod-stables-"..mount[1].."-"..side.key,name=mount[2].." - "..side.name.." capture and training",
            faction=side.name,quests=quests,endQuestID=quests[#quests].questID,
            after="The Stables plot reference is not an exact NPC position. Daily offers are time-gated: an unfinished next stage may first appear after the daily reset. After the final hand-in, learn/check the permanent mount; training whistles can be reissued for the two Stables achievement mounts."})
    end
end

-- Nat's recruitment includes the Fishing Shack opening and both versions of
-- Luring Nat / The Great Angler Returns. The central Pandaria handoff is shared.
for _,side in ipairs(sides) do
    local alliance=side.name=="Alliance"
    local pandaria=point(418,68.4,43.4)
    local opening=alliance and {34194,36199,36201,36202} or {34758,36141,36131,36132}
    local fish=alliance and point(539,44.0,37.0) or point(525,42.0,54.0)
    local q={
        quest(opening[1],"Looking For Help","After upgrading your Garrison to level 2, ask the Fishing Shack NPC how to open the building. The reference pin points to the Shack, not a building plot you must construct manually.",side.fishing,side.fishing,side.fishing,{requires={},pickupReference=true,objectiveReference=true,turnInReference=true}),
        quest(opening[2],alliance and "Moonshell Claws" or "Icespine Stingers",alliance and "Collect four Moonshell Claws from Moonshell Crawlers along the coast below Lunarfall and return them to Madari." or "Collect four Icespine Stingers around Frostwall's southern waters and return them to Mokugg Lagerpounder.",side.fishing,nil,side.fishing,{pickupReference=true,objectiveReference=true,turnInReference=true}),
        quest(opening[3],"Proving Your Worth",alliance and "Use the supplied bait to catch five Shadow Sturgeon and return them to Madari. Train Draenor Fishing if needed; an ordinary fish with a similar name is not a substitute for the quest objective." or "Use the supplied bait to catch five Zangar Eels and return them to Mokugg Lagerpounder. Train Draenor Fishing if needed.",side.fishing,side.fishing,side.fishing,{pickupReference=true,objectiveReference=true,turnInReference=true}),
        quest(opening[4],"Anglin' In Our Garrison","Finish the Fishing Shack opening conversation and hand-in. Develop the Shack to level 3 before expecting Luring Nat: its blueprint comes from Draenor Angler. Reach 100 effective Draenor Fishing and keep your fishing gear/lure equipped.",side.fishing,side.fishing,side.fishing,{pickupReference=true,objectiveReference=true,turnInReference=true}),
        quest(alliance and 36870 or 36612,"Luring Nat",alliance and "With a level 3 Fishing Shack and 100 effective Draenor Fishing, take Luring Nat from Segumi. Fish Shadowmoon Valley inland water until the quest's Arcane Trout is caught, then return to Segumi." or "With a level 3 Fishing Shack and 100 effective Draenor Fishing, take Luring Nat from Rak'jin. Fish the lava pool just outside Frostwall's southern entrance until the quest's Molten Catfish is caught, then return to Rak'jin.",side.fishing,fish,side.fishing,{pickupReference=true,objectiveReference=true,turnInReference=true}),
        quest(36608,"Finding Nat Pagle","Take the special fish to Nat Pagle at Anglers Wharf in Krasarang Wilds. This is the Pandaria Nat, not the unavailable Garrison follower version. Turn in the fish and keep fishing gear/lure equipped so the next quest remains available.",side.fishing,pandaria,pandaria,{pickupReference=true}),
        quest(alliance and 36882 or 36609,"The Great Angler Returns","Accept this from Nat at Anglers Wharf BEFORE leaving Pandaria. Return to your Garrison Fishing Shack and finish the hand-in to continue the Draenor recruitment.",pandaria,side.fishing,side.fishing,{turnInReference=true,objectiveReference=true}),
        quest(36611,"A True Draenor Angler","Speak with Nat at the Shack for his supplied lure. Fish the six requested lunkers in Frostfire Ridge, Shadowmoon Valley, Gorgrond, Talador, Spires of Arak and Nagrand. These recruitment-quest fish are different from an ordinary bag full of repeatable lunkers. Return all six to Nat.",side.fishing,nil,side.fishing,{pickupReference=true,turnInReference=true}),
        quest(36616,"An Angler on Our Team","Finish Nat's recruitment conversation at the Fishing Shack. Afterward, ordinary lunker hand-ins build his friendship and award coins. Best Friend and 100 Nat's Lucky Coins are both required for Crimson Water Strider.",side.fishing,side.fishing,side.fishing,{pickupReference=true,objectiveReference=true,turnInReference=true}),
    }
    attach({127271},{key="wod-nat-pagle-"..side.key,name="Fishing Shack and Nat Pagle - "..side.name,
        faction=side.name,quests=q,endQuestID=36616,progressItemID=117397,progressRequired=100,progressLabel="Nat's Lucky Coins in bags/bank",
        after="Recruitment completion does not mean the mount is bought. Fish ordinary Draenor lunkers and turn them in until Nat is Best Friend and 100 coins are saved; then buy the mount. The guide map retains fishing areas for the six-zone quest and the subsequent coin farm."})
end

-- The mandatory Tanaan/Shipyard access chain is shared by the naval mount and
-- the two Tanaan vendor mounts. It stops at the relevant access point for each
-- reward; the optional level 3 Shipyard grind is not an extra mount requirement.
local function buildShipyard(side)
    local a=side.name=="Alliance"
    local dock=point(543,56.6,17.2)
    local coast=a and point(539,27.5,11.3) or point(525,42,71)
    local jungle=a and point(534,73.4,71.2) or point(534,73.4,71.2)
    local base=a and point(534,57.8,59.4) or point(534,61.0,45.8)
    local rows={
        {38253,38567,"Garrison Campaign: War Council","At a level 3 Garrison meet King Varian Wrynn (Alliance) or Vol'jin (Horde) in the Town Hall. Take the shipwright rescue assignment; if this introduction was accepted earlier, continue the unfinished Iron Docks stage.",side.town,side.town,side.town},
        {38257,38568,"We Need a Shipwright","Use the Garrison flight master/story transport or fly to northern Gorgrond. Meet your faction's rescue party outside the Iron Docks; this is the outdoor story phase, not the dungeon.",side.town,dock,dock},
        {38254,38570,"Derailment","Follow the rescue party into the Iron Docks story phase. Click the Detonator near 51.5,14.3 and the Explosive Charges near 49.8,12.6, then report to the moving faction NPC near the train.",dock,point(543,51.5,14.3),dock},
        {38255,38571,"The Train Gang","Plant the three charges along the train near 56.9,17.2, use the detonator and free Solog Roark. Stay for the scene, then accept his blueprint-recovery assignment.",dock,point(543,56.9,17.2),dock},
        {38256,38572,"Hook, Line, and... Sink Him!","Use the Blackrock Grapple near 56.6,16.1 to reach the upper building. Kill Admiral Knar and loot Roark's Shipyard Blueprints. Return to Solog outside rather than entering the ordinary dungeon.",dock,point(543,56.6,16.1),dock},
        {38258,38573,"Nothing Remains","Return to the Garrison Town Hall using your Garrison Hearthstone and report the successful rescue. Accept the instruction to meet Roark at the coast.",dock,side.town,side.town},
        {38259,38574,"All Hands on Deck","Leave the Garrison for its coastal Shipyard site and meet Solog Roark. Bring the requested gold and Garrison Resources for construction; the Shipyard uses a separate coastal site rather than an ordinary plot.",side.town,coast,coast},
        {39082,39236,"Let's Get To Work","Meet Solog Roark at the dry docks below your Garrison and finish the Shipyard construction handoff. The ship-building tutorial happens at this coastal site.",coast,coast,coast},
        {39054,39241,"Shipbuilding","Use the Shipyard Blueprints to learn the ship design, then destroy the evidence as directed. Return to the dry-dock foreman; commissioning the first Transport is the next stage.",coast,coast,coast},
        {39276,nil,"Strange Tools","Speak with Yanas Seastrike at the dry docks and finish the foreman's conversation before continuing the ship tutorial.",coast,coast,coast},
        {39055,39242,"Ship Shape","Speak with your dry-dock foreman to begin construction of a Transport. Wait for it to finish and use the completed ship interaction to add it to your fleet.",coast,coast,coast},
        {38435,37889,"The Invasion of Tanaan","Meet Khadgar at the Shipyard, then speak to Yrel (Alliance) or Draka (Horde) to begin the landing. Travel with the story transport and stay in its Tanaan phase.",coast,jungle,jungle},
        {38436,37890,"Obstacle Course","Recover the marked intelligence about the Bleeding Hollow, Iron Horde and cultist forces in the landing area. Meet the scouts after all requested information is collected.",jungle,jungle,jungle},
        {38444,37934,"In, Through, and Beyond!","Reach and destroy the Fel Defense Cannon covering the gate. Continue through the opened route and meet Exarch Naielle (Alliance) or Shadow Hunter Mutumba (Horde); wait for the objective credit before leaving the story party.",jungle,jungle,jungle},
        {38445,37935,"The Assault Base","Follow the faction party to Lion's Watch or Vol'mar, use the base-establishment interaction and turn in the quest. This opens the base rather than simply revealing its map label.",jungle,base,base},
        {38581,38577,"The Battle for the West","Use the base's offered flight to the Iron Front and report to the faction commander there. This is the introductory travel/report quest, not an instruction to repeat an unrelated daily assault.",base,point(534,9.6,56.2),point(534,9.6,56.2)},
        {39422,39423,"Shipyard Report","Return from your Tanaan base to the Garrison Shipyard and report on the operation. This continues the naval command tutorial.",base,coast,coast},
        {39056,39243,"Naval Commander","Use the naval command table and complete the introductory naval assignment offered by the tutorial. Collect the finished mission at the table before expecting the next ship/fleet quest.",coast,coast,coast},
        {39404,39401,"Destroying the Competition","Build/use the requested counter ship, then send it on the tutorial naval mission. Match the mission's transport/submarine threat with the indicated counter and collect the completed mission.",coast,coast,coast},
        {39601,39604,"I Sunk Your Battleship","Go to your Tanaan base and meet Vindicator Krethos (Alliance) or Shadow Hunter Denjai (Horde). Follow the offered battleship-blueprint/quartermaster introduction; simply finishing a random naval mission does not complete this travel objective.",coast,base,base},
        {39655,39674,"If At First You Fail, Try Again!","After the tutorial mission fails, meet Yanas Seastrike (Alliance) or Solog Roark (Horde), build another Destroyer and send it on the new mission offered by the tutorial.",coast,coast,coast},
        {39666,39675,"Equipping Our Fleet","Meet Salty Jorren (Alliance) or Kronk Rustspark (Horde) at the Shipyard docks. Obtain and learn Equipment Blueprint: Blast Furnace as directed by the tutorial.",coast,coast,coast},
        {39665,39676,"A True Naval Commander","Install Blast Furnace equipment on a ship, then send the countered fleet on Naval Blockade. Return to the naval table when the mission completes and collect it.",coast,coast,coast},
        {39067,39245,"Upgrading The Fleet","Complete fifteen naval missions, gather 1,000 Garrison Resources and save 1,000 gold. Return to Roark and purchase the level 2 Shipyard upgrade. Level 3's twenty-five treasure missions are not required for Mudback Riverbeast.",coast,coast,coast},
    }
    local q,previousMandatory={},nil
    for _,row in ipairs(rows) do
        local id=a and row[1] or row[2]
        if id then
            local optional=id==39276 or id==39601 or id==39604
            q[#q+1]=quest(id,row[3],row[4],row[5],row[6],row[7],
                {requires=previousMandatory and {previousMandatory} or {},optional=optional,
                    pickupReference=true,objectiveReference=true,turnInReference=true})
            if not optional then previousMandatory=id end
        end
    end
    return q
end
for _,side in ipairs(sides) do
    local q=buildShipyard(side)
    attach({171826},{key="wod-shipyard-"..side.key,name="Shipyard access and level 2 fleet - "..side.name,
        faction=side.name,quests=q,endQuestID=side.name=="Alliance" and 39067 or 39245,
        after="With the level 2 Shipyard ready, check the naval table for mission 615, It's a Boat, It's a Plane, It's... Just a Riverbeast. Mission appearance remains random. The route's outdoor pins are access references for the story phases; use the live quest objective if an NPC moves."})
    local access={}
    for _,entry in ipairs(q) do
        access[#access+1]=entry
        if entry.questID==(side.name=="Alliance" and 38445 or 37935) then break end
    end
    attach({183117,190977},{key="wod-tanaan-access-"..side.key,name="Tanaan daily-base access - "..side.name,
        faction=side.name,quests=access,endQuestID=side.name=="Alliance" and 38445 or 37935,
        after="Tanaan access is ready. Continue the mount's reputation/currency guide; unfinished later Shipyard upgrades are not extra requirements for a vendor purchase."})
end

-- The achievement mounts also expose their actual Stables prerequisites.
-- Frostboar requires the captures, not all six completed training chains.
-- Frostwolf's level 3 blueprint does require the completed training chains.
for _,mount in ipairs(TDP.WarlordsStableMounts) do
    for _,side in ipairs(sides) do
        local original=routes["wod-stables-"..mount[1].."-"..side.key]
        for _,reward in ipairs({171629,171838}) do
            local copy={}
            for key,value in pairs(original) do copy[key]=value end
            copy.key="wod-stables-prerequisite-"..reward.."-"..mount[1].."-"..side.key
            copy.name=mount[2]..(reward==171629 and " capture" or " training")
            copy.compact=true
            if reward==171629 then
                copy.quests={original.quests[1]}
                copy.endQuestID=original.quests[1].questID
                copy.after="Once all six beasts are captured, upgrade to level 2 Stables, carry Black Claw of Sethe and complete the thirty-six challenge kills. Completing all normal training quests is not required for Advanced Husbandry."
            else
                copy.after="After all six training chains, buy/build level 3 Stables, carry Garn-Tooth Necklace and complete the thirty-six challenge kills."
            end
            attach({reward},copy)
        end
    end
end

-- Emerald Drake's Purple Netherwing prerequisite can reuse the already
-- authored Outland chain. Buying purple after a different free colour is valid.
local netherwing=routes["bc-netherwing-41516"]
if netherwing then
    local copy={}
    for key,value in pairs(netherwing) do copy[key]=value end
    copy.key="wod-emerald-purple-netherwing"
    copy.name="Optional Purple Netherwing Drake prerequisite"
    copy.optional=true
    attach({175700},copy)
    guides[175700].questRoutesOptional=true
end

-- A token route may bypass the daily, so this is a reputation method rather
-- than a compulsory daily count. Existing character reputation satisfies it.
for _,side in ipairs(sides) do
    local hub=side.name=="Alliance" and point(534,57.8,59.4) or point(534,60.4,46.6)
    attach({183117},{key="wod-awakened-friendly-"..side.key,name="Order of the Awakened - Friendly purchase requirement",
        faction=side.name,factionID=1849,standing=5,
        quests={quest(39432,"Unknowable Power","Collect one Fel-Corrupted Apexis Fragment from a Tanaan treasure or rare and bring it to Dawn-Seeker Krisek. The quest is offered after establishing your Tanaan base.",hub,nil,hub,{requires={side.name=="Alliance" and 38445 or 37935}})},
        repeatableQuests={quest(39433,"Unseen Influence","Collect ten Fel-Corrupted Apexis Fragments from Tanaan treasures/rares and return them to Krisek. Each treasure/rare has its own loot eligibility; check today's quest rather than treating every kill as another fragment.",hub,nil,hub,{requires={39432},daily=true})},
        after="At Friendly, save 150,000 Apexis Crystals for Corrupted Dreadwing. Unfinished further Order dailies are not additional mount requirements."})
end

]====]
