-- English Retail routes, manually reconciled with Wowhead comments/replies.
-- Retired achievement IDs are excluded by the expansion catalogue.
-- Neutral Dungeon Finder guides live in General.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.achievements = TDP.CollectionWalkthroughs.achievements or {}
local guides = TDP.CollectionWalkthroughs.achievements

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(id, name, steps, waypoints, tips, comments, category)
    local lines, sources = {}, {}
    for index, text in ipairs(steps) do lines[index] = index .. ". " .. text end
    for _, comment in ipairs(comments or {}) do
        sources[#sources + 1] = type(comment) == "number"
            and ("https://www.wowhead.com/achievement=" .. id .. "#comments:id=" .. comment) or comment
    end
    guides[id] = {
        achievementId = id, name = name, category = category or "Dungeons", sourceType = "Achievement", source = name,
        acquisition = table.concat(lines, "\n\n"), stepCount = #steps,
        waypoints = waypoints or {}, tips = tips, sources = sources,
        wowheadUrl = "https://www.wowhead.com/achievement=" .. id,
        sourceURL = "https://www.wowhead.com/achievement=" .. id .. "#comments",
    }
end

-- Both Normal and Heroic comment lists were read separately. Most contain
-- no numbered acquisition guide. These routes combine their useful details
-- with the named criteria and boss locations, rather than old level/gear advice.
-- Interior coordinates: each named NPC's Retail g_mapperData; floor identities:
-- https://wago.tools/db2/UiMap/csv and /db2/UiMapGroupMember/csv.
-- Ahn'kahet's room pins use Retail /db2/JournalEncounter/csv (UiMap 132).
local dungeons = {
    {
        477, 489, "Utgarde Keep", 117, 58.2, 48.9,
        "Enter the LOWER Utgarde Keep portal beside the water in Howling Fjord. The upper ledge leads to Utgarde Pinnacle, a different dungeon.",
        "Follow the forge corridor and dragon pens to Prince Keleseth. Defeat him, then climb the Dragonflayer Ascent and kill BOTH Skarvald the Constructor and Dalronn the Controller; the surviving partner must also die.",
        "Continue upstairs to Tyr's Terrace and defeat Ingvar the Plunderer. WAIT for Annhylde to resurrect him, then kill his undead form. The first apparent death does not finish the encounter.",
        { pin(133,28.9,62.7,2,"Prince Keleseth","Utgarde Keep - Njorndir Preparation"), pin(134,58.7,62,2,"Skarvald and Dalronn","Utgarde Keep - Dragonflayer Ascent"), pin(135,72.4,38.1,3,"Ingvar - defeat both phases","Utgarde Keep - Tyr's Terrace") },
        {1636702}, {530539},
    },
    {
        478, 490, "The Nexus", 114, 27.5, 26.7,
        "Fly to the Coldarra island west of Borean Tundra. Descend to the LOWEST portal beneath the Nexus tower; the Oculus entrance is on a higher ring.",
        "Work around the dungeon's three branches: defeat Grand Magus Telestra, Anomalus and Ormorok the Tree-Shaper. Activate the containment sphere near EACH defeated boss; all three are needed to release Keristrasza.",
        "Return to the central frozen dragon, Keristrasza, and finish activating the containment spheres if she is still imprisoned. Defeat her after she becomes attackable. Move or jump to clear Intense Cold and break roots promptly if the fight lasts.",
        { pin(129,27.5,39.9,2,"Grand Magus Telestra / containment sphere","The Nexus"), pin(129,62,22.1,2,"Anomalus / containment sphere","The Nexus"), pin(129,56.2,72.7,2,"Ormorok / containment sphere","The Nexus"), pin(129,36.2,67.4,3,"Keristrasza - free and defeat","The Nexus") },
        {511601}, {1024180,2194851},
    },
    {
        479, 500, "The Culling of Stratholme", 75, 56.9, 82.4,
        "Enter the Caverns of Time in Tanaris, descend into the main cavern and take the Culling of Stratholme portal. Present-day Stratholme in Eastern Plaguelands is the wrong instance.",
        "Speak to Chromie and complete or skip the crate introduction using the dialogue available to your character. If asked to expose suspicious crates, use the supplied Arcane Disruptor on all five. Meet Arthas at Stratholme and speak to him to start the culling.",
        "Clear the marked street waves and defeat Meathook and Salramm the Fleshcrafter. Follow Arthas into the town hall, complete the Infinite Dragonflight waves and defeat Chrono-Lord Epoch. Speak to Arthas whenever progression pauses.",
        { pin(131,56.6,59.2,3,"Meathook - street waves","Stratholme City"), pin(131,59.1,40.1,3,"Salramm - street waves","Stratholme City"), pin(131,65.8,25.8,3,"Chrono-Lord Epoch - town hall","Stratholme City"), pin(131,32.5,45.9,4,"Mal'Ganis - final encounter","Stratholme City") },
        {1685602}, {505480},
        "Escort Arthas through the burning streets, speak to him at the last square and defeat Mal'Ganis. Wait for the encounter to end and check the boss criteria. The optional Infinite Corruptor is a separate Heroic timed objective, not a requirement for this clear.",
    },
    {
        480, 491, "Azjol-Nerub", 115, 26, 50.8,
        "Enter the pit at 26.3, 49.5 in western Dragonblight. At the meeting stone, take the RIGHT branch to Azjol-Nerub; the left branch leads to Ahn'kahet.",
        "Defeat Krik'thir the Gatewatcher beyond the three watcher packs. Continue down into Hadronox's lair, let the spider encounter advance until Hadronox can be engaged, and defeat it.",
        "Follow the downward route and drop into the Brood Pit. Enter Anub'arak's arena and defeat him; kill the summoned waves whenever he burrows so he resurfaces. Check all three boss criteria before leaving.",
        { pin(159,50.1,45,2,"Krik'thir the Gatewatcher","Azjol-Nerub - The Gilded Gate"), pin(158,43.1,59.4,2,"Hadronox","Azjol-Nerub - Hadronox's Lair"), pin(157,62.1,48.7,3,"Anub'arak","Azjol-Nerub - The Brood Pit") },
        {1698472}, {1961194},
    },
    {
        481, 492, "Ahn'kahet: The Old Kingdom", 115, 28.4, 51.7,
        "Enter the pit at 26.3, 49.5 in western Dragonblight and take the LEFT branch from the Azjol-Nerub meeting stone to Ahn'kahet.",
        "Defeat Elder Nadox, then reach Prince Taldaram's platform. Activate BOTH nearby devices to remove Taldaram's barrier and defeat him. Continue to Jedoga Shadowseeker, kill her initial worshippers and complete her sacrifice phase before finishing her.",
        "Reach Herald Volazj and defeat him. If Insanity occurs, kill the hostile copies in your phase, then resume attacking Volazj. Check each named boss criterion; skipping a side encounter can leave the clear unfinished.",
        { pin(132,69.67,27.05,2,"Elder Nadox","Ahn'kahet: The Old Kingdom"), pin(132,63.11,49.59,2,"Prince Taldaram - activate both devices","Ahn'kahet: The Old Kingdom"), pin(132,48.22,72.54,2,"Jedoga Shadowseeker","Ahn'kahet: The Old Kingdom"), pin(132,23.63,50.41,3,"Herald Volazj","Ahn'kahet: The Old Kingdom") }, {520853}, {823931,1961188},
        "On HEROIC, also take the side path into the mushroom cavern and kill Amanitar. He is required for Heroic: Ahn'kahet even though he is unnecessary for the Normal achievement. Do this before leaving after Volazj.",
    },
    {
        482, 493, "Drak'Tharon Keep", 121, 28.6, 86.9,
        "Enter Drak'Tharon Keep at the southwestern edge of Zul'Drak, above the Grizzly Hills approach. Use the dungeon portal inside the keep.",
        "Defeat Trollgore, then Novos the Summoner. At Novos, kill the Crystal Handlers as they arrive to disable his barrier, then kill Novos. Continue through King Dred's raptor courtyard and defeat Dred.",
        "Climb to the overlook and defeat The Prophet Tharon'ja. If he transforms you into a skeleton, use the temporary abilities until your normal action bar returns, then finish him. Confirm that Tharon'ja's criterion credited before leaving.",
        { pin(160,56.5,18.2,2,"Trollgore","Drak'Tharon Keep - The Vestibules"), pin(160,70.2,47.9,2,"Novos - Crystal Handler event","Drak'Tharon Keep - The Vestibules"), pin(160,61.2,86.2,2,"King Dred","Drak'Tharon Keep - The Vestibules"), pin(161,47.6,13.3,3,"The Prophet Tharon'ja","Drak'Tharon Keep - Overlook") },
        {662438}, {584255,662425},
    },
    {
        483, 494, "The Violet Hold", 125, 66.5, 67.8,
        "Go to the ORIGINAL Dalaran in Northrend and enter the Violet Hold prison. Legion Dalaran's Assault on Violet Hold is a different dungeon and cannot award these achievements.",
        "Speak to Lieutenant Sinclari inside and confirm that you are ready. Stay inside when the guards leave. Kill every portal's attackers before they damage the prison seal; the event advances through eighteen waves.",
        "Defeat the random prisoners released at waves 6 and 12, then Cyanigosa at wave 18. Kill Cyanigosa and wait for credit. The random prisoner selection matters for Lockdown!, but this clear only requires Cyanigosa.",
        { pin(168,45,55.1,3,"Cyanigosa - eighteenth wave","The Violet Hold (Northrend)") },
        {}, {1619591,1961197},
    },
    {
        484, 495, "Gundrak", 121, 76.4, 21.3,
        "Use Gundrak's NORTHWEST entrance in northeastern Zul'Drak (76.4, 21.3). The southeast entrance at 81.1, 28.8 is another usable entrance to the same dungeon.",
        "Defeat Slad'ran, the Drakkari Colossus and Moorabi. CLICK THE ALTAR near each defeated boss; all three altar activations are needed to rotate the bridge to Gal'darah.",
        "Cross the activated central bridge and defeat Gal'darah, completing his troll/rhino phases if he survives. Confirm all the named boss criteria.",
        { pin(153,53.9,48.5,2,"Slad'ran / altar","Gundrak"), pin(153,46.5,65.5,2,"Drakkari Colossus / altar","Gundrak"), pin(153,39.3,48.9,2,"Moorabi / altar","Gundrak"), pin(153,46.5,27,3,"Gal'darah - across rotated bridge","Gundrak") },
        {1698156,1961313}, {1961312,2583124},
        "On HEROIC, also take the passage behind Moorabi into the side cavern. Clear the living inhabitants to bring out Eck the Ferocious and kill him. Eck is a separate optional boss required for the Heroic clear; he is not the Drakkari Colossus.",
    },
    {
        485, 496, "Halls of Stone", 120, 40.1, 26.9,
        "Fly to the Ulduar complex in northern Storm Peaks and enter Halls of Stone on the WEST side of the approach. The central Ulduar raid and eastern Halls of Lightning portal are different instances.",
        "Clear the side branches to Krystallus and the Maiden of Grief and defeat both. Neither should be skipped even if the route toward Brann is open.",
        "Find Brann Bronzebeard and speak to him to begin his escort. Follow him to the Tribunal of Ages and defend him through the complete event. Talk to him again after the dialogue, follow him to Sjonnir's door and let him open it. Defeat Sjonnir the Ironshaper.",
        { pin(140,40.1,60.4,2,"Krystallus","Halls of Stone"), pin(140,50.2,86.2,2,"Maiden of Grief","Halls of Stone"), pin(140,84.9,76.1,3,"Tribunal of Ages - defend Brann","Halls of Stone"), pin(140,49.7,13.7,3,"Sjonnir - Brann opens the door","Halls of Stone") },
        {618631}, {2206441},
    },
    {
        486, 497, "Halls of Lightning", 120, 45.3, 21.6,
        "Fly to the EASTERN dungeon entrance beside Ulduar in The Storm Peaks. Check that the instance name is Halls of Lightning before continuing.",
        "Defeat the patrolling General Bjarngrim on the lower platforms. Cross the slag room, climb to Volkhan's forge and defeat Volkhan.",
        "Continue along the Walk of the Makers to Ionar. If he disperses, wait for his sparks to return and finish the reformed boss. Clear the final hall and defeat Loken; this requires all four bosses, not just Loken.",
        { pin(138,43.5,37.2,2,"General Bjarngrim - patrol area","Halls of Lightning - Unyielding Garrison"), pin(139,37.7,20.9,2,"Volkhan","Halls of Lightning - Walk of the Makers"), pin(139,61.4,77.4,3,"Ionar","Halls of Lightning - Walk of the Makers"), pin(139,18.9,52.2,3,"Loken","Halls of Lightning - Walk of the Makers") },
        {985762}, {1961303},
    },
    {
        487, 498, "The Oculus", 114, 28.6, 27.5,
        "Fly to Coldarra in Borean Tundra and use the Oculus portal on the ring ABOVE the Nexus ground-level entrance. Defeat Drakos the Interrogator to release the three friendly drakes.",
        "Speak to a freed drake for an Amber, Emerald or Ruby Essence. Use it to fly between platforms. Kill the Centrifuge Constructs powering Varos's shield, then land, dismount and defeat Varos Cloudstrider.",
        "Fly to each of Mage-Lord Urom's platforms, kill the summoned packs and follow his teleports. Finish Urom on the inner ring. Use your drake to reach Ley-Guardian Eregos on the highest ring and defeat him to complete all four criteria.",
        { pin(143,49.1,76.2,1,"Drakos - free the drakes","The Oculus - Band of Variance"), pin(144,46.1,19.2,2,"Varos - disable construct shield","The Oculus - Band of Acceleration"), pin(145,70.7,27.4,3,"Urom - follow platform sequence","The Oculus - Band of Transmutation"), pin(146,46.9,20.9,3,"Eregos - highest ring","The Oculus - Band of Alignment") },
        {1636142,2506862}, {872486},
    },
    {
        488, 499, "Utgarde Pinnacle", 117, 57.3, 46.7,
        "Enter the UPPER Utgarde Pinnacle portal in Howling Fjord. The lower Utgarde Keep entrance leads to a different dungeon.",
        "Defeat Svala Sorrowgrave after her introduction. At Gortok's trophy room, activate the stasis controller and defeat the released beasts until Gortok Palehoof awakens; kill Gortok too.",
        "Start Skadi's gauntlet and collect HARPOONS from the Ymirjar Harpooners. At the launcher end, wait until Grauf is in range and fire three harpoons to bring Skadi down. Defeat Skadi, continue through the last hall and defeat King Ymiron.",
        { pin(136,36.3,70.6,2,"Svala Sorrowgrave","Utgarde Pinnacle - Lower Pinnacle"), pin(137,60.6,68.8,2,"Gortok - stasis room","Utgarde Pinnacle - Upper Pinnacle"), pin(137,68.4,36.2,3,"Skadi - gauntlet and launchers","Utgarde Pinnacle - Upper Pinnacle"), pin(137,41.5,53.4,3,"King Ymiron","Utgarde Pinnacle - Upper Pinnacle") },
        {}, {1360520},
    },
}

for _, dungeon in ipairs(dungeons) do
    for _, heroic in ipairs({ false, true }) do
        local id = heroic and dungeon[2] or dungeon[1]
        local steps = {
            (heroic and "Set Dungeon Difficulty to HEROIC outside the instance. " or "Normal difficulty is sufficient; a full Heroic clear also awards the Normal achievement. ") .. dungeon[7],
            dungeon[8], dungeon[9],
        }
        if dungeon[13] and (heroic or id == 479) then steps[#steps + 1] = dungeon[13] end
        local waypoints = { pin(dungeon[4], dungeon[5], dungeon[6], 1, dungeon[3] .. " - entrance") }
        for _, point in ipairs(dungeon[10]) do waypoints[#waypoints + 1] = point end
        if heroic and id == 495 then
            waypoints[#waypoints + 1] = pin(153,25.1,70.4,4,"Eck - Heroic side cavern","Gundrak")
        elseif heroic and id == 492 then
            waypoints[#waypoints + 1] = pin(132,67.21,78.69,4,"Amanitar - Heroic mushroom cavern","Ahn'kahet: The Old Kingdom")
        end
        add(id, (heroic and "Heroic: " or "") .. dungeon[3], steps, waypoints,
            heroic and "This is the original Northrend Heroic instance. Check every boss criterion before leaving; a saved Heroic clear normally requires the next daily reset for another attempt." or nil,
            dungeon[heroic and 12 or 11])
    end
end

add(2150, "Split Personality", {
    "Set Heroic and enter the Nexus at Coldarra's lowest portal. Follow the left branch to Grand Magus Telestra.",
    "At high level, kill Telestra immediately with a direct attack. Later Retail comments and the fast-kill thread's replies confirm that killing her before any split awards the achievement; two splits are not mandatory.",
    "If she does split, weaken all three images, then kill them within FIVE seconds of the first image dying. Interrupt or wait out the Frost image's Blizzard before starting that window. Repeat for any additional split, then finish Telestra.",
}, { pin(114,27.5,26.7,1,"The Nexus - lowest portal"), pin(129,27.5,39.9,2,"Telestra - direct fast kill","The Nexus"), pin(129,27.5,39.9,3,"Telestra - synchronize image deaths if needed","The Nexus") }, nil, {1756582,5405309,467834})

add(2036, "Intense Cold", {
    "Enter the Nexus on Heroic. Defeat Telestra, Anomalus and Ormorok and activate their containment spheres so Keristrasza is released.",
    "Stand beside Keristrasza and kill her promptly. Keep moving or jumping throughout any surviving fight: YOUR Intense Cold debuff must never reach three stacks. Other players' failures do not automatically invalidate your own attempt.",
    "If Crystal Chains roots you, remove the magic root or use an available root-breaking ability immediately, then move. Prepare that ability before freeing her. A fast direct kill is confirmed in later Retail replies; verify Heroic difficulty if no achievement appears.",
}, { pin(114,27.5,26.7,1,"The Nexus - entrance"), pin(129,27.5,39.9,1,"Telestra / containment sphere","The Nexus"), pin(129,62,22.1,1,"Anomalus / containment sphere","The Nexus"), pin(129,56.2,72.7,1,"Ormorok / containment sphere","The Nexus"), pin(129,36.2,67.4,2,"Keristrasza - move and prevent three stacks","The Nexus") }, "Track Intense Cold on your own debuff bar. Retired talents, old potion level limits and old class rotations are unnecessary for a high-level Retail attempt.", {418176,629616,2175571,3174272})

add(2037, "Chaos Theory", {
    "Enter the Nexus on Heroic and go to Anomalus on the northeastern platforms. Avoid killing Chaotic Rifts along the approach as well as those summoned during the boss fight; use single-target attacks and control pets or damage procs.",
    "At high level, kill Anomalus directly without attacking a rift. Later Retail comments and replies confirm a fast kill can award credit without waiting for an immunity phase.",
    "If he becomes immune, stop attacking and leave every Chaotic Rift alive. Kill only the smaller summoned enemies, away from rifts. Wait for Rift Shield to expire, then finish Anomalus. Do not follow old advice to destroy a rift to end the immunity.",
}, { pin(114,27.5,26.7,1,"The Nexus - entrance"), pin(129,62,22.1,2,"Anomalus - leave Chaotic Rifts alive","The Nexus") }, "Pet cleaves, ground effects and automatic retaliation can kill a rift accidentally. A completed Heroic kill locks another boss attempt until the next daily reset.", {2290372,2617465,1559467,1683216})

-- A qualifying numbered profit-ending comment (no replies). Its high-level
-- direct-kill route remains useful; the old level-100 health figures do not.
add(2040, "Less-rabi", {
    "Set Heroic and enter Gundrak through the northwest portal in Zul'Drak (76.4, 21.3). Follow the western branch to Moorabi, near his altar.",
    "At high level, use a strong direct single-target attack to kill Moorabi before he can cast Transformation. This is the useful part of the numbered fast-kill guide; its old health and damage figures are not current requirements.",
    "If Moorabi survives, interrupt EVERY Transformation cast. Later casts become faster as his health drops. Do not let him finish transforming even once; kill him and confirm Less-rabi before continuing.",
}, { pin(121,76.4,21.3,1,"Gundrak - northwest entrance"), pin(153,39.3,48.9,2,"Moorabi - kill before Transformation","Gundrak") }, nil, {2265670})

add(2042, "Shatter Resistant", {
    "Set Heroic and enter Halls of Lightning beside Ulduar. Defeat Bjarngrim and continue through the slag room to Volkhan's forge.",
    "Kill Volkhan directly at high level. A fast kill before any golems are shattered satisfies the achievement; waiting for the mechanic is unnecessary.",
    "If the fight lasts, avoid damaging his Molten Golems into their brittle state. Move away from the slow golems and finish Volkhan before he can shatter five. The limit concerns SHATTERED Brittle Golems, not merely the number he summons.",
}, { pin(120,45.3,21.6,1,"Halls of Lightning - entrance"), pin(139,37.7,20.9,2,"Volkhan - kill before five golem shatters","Halls of Lightning - Walk of the Makers") }, nil, {407708,642622,3140206})

add(2153, "A Void Dance", {
    "Enter the ORIGINAL Violet Hold in Northrend Dalaran on Heroic. Speak to Sinclari, clear the portal waves and watch which prisoner is released at wave 6. You need Zuramat the Obliterator; another prisoner cannot award this achievement.",
    "If the first prisoner is wrong, leave BEFORE killing that boss and reset from outside for another random selection, provided you have not been saved by a boss kill. Later Retail comments confirm this reroll route. Respect the hourly instance-entry limit; a saved Heroic run is not a fresh reroll.",
    "When Zuramat becomes attackable, kill him with direct SINGLE-TARGET damage. Leave every Void Sentry alive. If Void Shift lets you see or attack the sentries, keep targeting Zuramat; pet cleaves and random damage effects can otherwise ruin the attempt.",
}, { pin(125,66.5,67.8,1,"Original Violet Hold - entrance"), pin(168,27.19,33.61,3,"Zuramat's cell - must be selected by saboteur","The Violet Hold (Northrend)") }, "Begin the random-prisoner attempts early if working on Glory of the Hero. No Void Sentry kill is required to make Zuramat vulnerable.", {485222,1689700,3239923,5588828,5981560})

add(1816, "Defenseless", {
    "Enter the ORIGINAL Violet Hold in Northrend Dalaran on Heroic. Tell Sinclari you are ready. Leave all Defense Control Crystals on the prison walls untouched for the ENTIRE run.",
    "Intercept each portal's attackers before they damage the prison seal. Watch the seal-integrity display and keep it at 100%. For split groups, kill or tag every enemy rather than assuming the portal's main guardian is the only threat.",
    "Defeat the prisoners at waves 6 and 12, then Cyanigosa at wave 18, with the seal still at 100% and no crystal used. If Ichoron appears, do not use a crystal for his globules during this attempt; handle them yourself or do Dehydration separately.",
}, { pin(125,66.5,67.8,1,"Original Violet Hold - entrance"), pin(168,45,55.1,2,"Prison arena - intercept portal attackers","The Violet Hold (Northrend)"), pin(168,45,55.1,3,"Cyanigosa - preserve 100% seal integrity","The Violet Hold (Northrend)") }, nil, {472706,548211,650601,2878795})

add(2154, "Brann Spankin' New", {
    "Set Heroic and enter Halls of Stone in The Storm Peaks. Find Brann Bronzebeard, start his escort and follow him into the Tribunal of Ages. Clear the approach before starting the defense dialogue.",
    "Stand at the TOP of the entrance stairs, between the spawning enemies and Brann. Kill each wave immediately, including ranged casters and the larger late-event enemies. A slow, stun or ranged attack helps catch anything that slips past; a harmless ground effect alone does not guarantee aggro.",
    "Keep defending through the full event while avoiding the moving beam and ground hazards. Brann must take ZERO damage, not merely survive. Stay for the final dialogue and achievement credit; killing one wave and running ahead does not finish the event.",
}, { pin(120,40.1,26.9,1,"Halls of Stone - entrance"), pin(140,84.9,76.1,2,"Tribunal of Ages - intercept waves at stairs","Halls of Stone") }, "The high-level stair-defense approach is confirmed in later replies. You still have to play through the scripted defense duration.", {499094,637202,1617719,1715952,2878905})

add(1866, "Good Grief", {
    "Set Heroic and enter Halls of Stone. Take the side branch to the Maiden of Grief; groups running only Brann and Sjonnir can skip this boss, so visit her deliberately.",
    "Engage the Maiden and defeat her within ONE minute. At high level, direct burst damage is normally sufficient. If a very fast kill fails to start or finish the timer, retry after the Heroic reset with a low-damage tag, allow combat to register, then finish within the minute.",
    "If the fight lasts until Shock of Sorrow, be beside a fresh dark ground pool. Briefly step into it as the incapacitate lands so its damage breaks the effect, then step back out and keep attacking. Check achievement credit before leaving.",
}, { pin(120,40.1,26.9,1,"Halls of Stone - entrance"), pin(140,50.2,86.2,2,"Maiden of Grief - one-minute timer","Halls of Stone") }, "The widely reported 2024 timer bug was reported fixed in patch 11.0.5, with confirmation in replies. Those old failure reports are not evidence that the achievement remains unobtainable.", {839302,2513872,5381870,5914699,5986906})

add(1834, "Lightning Struck", {
    "Set Heroic and enter Halls of Lightning. Stop before General Bjarngrim's patrol and clear nearby trash without hitting him.",
    "Target Bjarngrim and wait until his patrol stops on a charging platform. Watch his buffs: engage only AFTER Temporary Electrical Charge is actually present, not while he is merely walking toward the platform.",
    "Kill the charged Bjarngrim. At high level, a direct fast kill is sufficient. If credit has previously failed, let him enter combat and land a hit while charged before finishing; do not assume standing near a platform applied the buff.",
}, { pin(120,45.3,21.6,1,"Halls of Lightning - entrance"), pin(138,43.5,37.2,2,"Bjarngrim patrol - wait for Temporary Electrical Charge","Halls of Lightning - Unyielding Garrison") }, "The pin marks his patrol area, not a stationary spawn. Verify the named buff on the moving boss.", {432239,1715961,2020048,2586230})

add(2057, "Oh Novos!", {
    "Enter Drak'Tharon Keep on Heroic and reach Novos's room. Move around the LEFT edge and climb the staircase before pulling. Engage Novos from range so you can already intercept the first descending enemies.",
    "Stay at the TOP of the stairs and kill every descending undead before it reaches the room floor. Crystal Handlers enter from other directions and run toward you; let them come up to your position and kill all four there. Check behind you between stair waves.",
    "Once all four handlers die, Novos's barrier falls and the wave phase ends. Finish Novos. Keep the achievement tracked: if the criterion turns red, something reached the floor and that pull failed. Avoid an early one-shot through the barrier, which older comments report can leave the event running.",
}, { pin(121,28.6,86.9,1,"Drak'Tharon Keep - entrance"), pin(160,70.2,47.9,1,"Novos room - take stairs before ranged pull","Drak'Tharon Keep - The Vestibules"), pin(160,70.2,47.9,3,"Novos - finish after four Crystal Handlers","Drak'Tharon Keep - The Vestibules") }, nil, {407687,1956272,3242345,5889790})

add(2058, "Snakes. Why'd It Have To Be Snakes?", {
    "Set Heroic and enter Gundrak. Reach Slad'ran at the first snake chamber and clear nearby trash before engaging.",
    "At high level, kill Slad'ran immediately. A quick kill before Snake Wrap occurs satisfies the criterion; you do not need to summon snakes first.",
    "If he survives, kill the small constricting snakes promptly before their stacks cause Snake Wrap. Keep them off the player holding healing aggro and use area damage when several arrive together. Do not rely on the old water-evade or no-snakes-in-the-next-room tricks; comments report snakes reaching those positions too.",
}, { pin(121,76.4,21.3,1,"Gundrak - northwest entrance"), pin(153,53.9,48.5,2,"Slad'ran - prevent Snake Wrap","Gundrak") }, nil, {499840,500351,569966,3225072})

add(2157, "King's Bane", {
    "Set Heroic and clear Utgarde Pinnacle through Svala, Gortok and Skadi. Continue to King Ymiron's final room.",
    "At high level, kill Ymiron quickly before he can cast Bane. Skipping the buff with sufficient damage satisfies the achievement.",
    "If Bane is cast, EVERYONE must stop attacking until the buff is removed or expires. Stop auto-attacks, control pets, and avoid lingering or automatic damage. The requirement is that Bane never TRIGGERS, not that he never casts it. Resume damage only after the buff disappears, then defeat him.",
}, { pin(117,57.3,46.7,1,"Utgarde Pinnacle - upper entrance"), pin(137,41.5,53.4,2,"King Ymiron - kill before Bane or stop damage","Utgarde Pinnacle - Upper Pinnacle") }, "A pet hit or retaliation effect can invalidate the whole party's attempt. Old anecdotes about ignoring Bane do not override the named criterion.", {470204,470722,515677,1597534})

add(1867, "Timely Death", {
    "Set Heroic and enter Halls of Lightning. Defeat Bjarngrim, Volkhan and Ionar, then clear the approach to Loken's final chamber.",
    "Prepare your damage cooldowns before pulling and defeat Loken within TWO minutes of engaging. At high level, kill him directly; no Lightning Nova cast is required for credit.",
    "If he survives, remain reasonably close between casts because Pulsing Shockwave hurts more at range. When Lightning Nova is cast, move beyond its immediate blast radius and return promptly, or use an appropriate defensive if you can safely survive it. Keep attacking whenever possible and check the timer.",
}, { pin(120,45.3,21.6,1,"Halls of Lightning - entrance"), pin(139,18.9,52.2,2,"Loken - two-minute timer","Halls of Lightning - Walk of the Makers") }, "Old level-80 damage, health and resistance numbers are not modern Retail requirements. The actual objective is the two-minute kill.", {468653,511349,1779615})

-- The profit-ending Nadox comment describes separating the guardian from
-- the boss. Later comments allow the simpler high-level kill before it spawns.
add(2038, "Respect Your Elders", {
    "Enter Ahn'kahet on Heroic via the left branch of Dragonblight's Nerubian pit. Reach Elder Nadox and control pet cleaves or automatic area damage before pulling.",
    "At high level, kill Nadox directly before he summons an Ahn'kahar Guardian. No Guardian has to spawn for the achievement to count; later Retail comments replace the old elaborate kiting setup with this fast kill.",
    "If a Guardian appears and grants immunity, leave it ALIVE. Have a second player hold it away from Nadox, or crowd-control it and move Nadox beyond its protective aura, then finish the boss. Distance matters; merely breaking line of sight does not remove the aura. Do not drag Nadox all the way to the instance entrance, which can trigger his enrage.",
}, { pin(115,28.4,51.7,1,"Ahn'kahet - entrance"), pin(132,69.67,27.05,2,"Elder Nadox - leave Ahn'kahar Guardian alive","Ahn'kahet: The Old Kingdom") }, nil, {576631,1682733,1758677,2269168,3225060})

-- The old profit guide uses Divine Intervention, a removed ability. Retain
-- the timed objective, but use the later Retail direct-kill corrections.
add(1862, "Volazj's Quick Demise", {
    "Set Heroic and enter Ahn'kahet in Dragonblight. Follow the dungeon route to Herald Volazj's final chamber and clear nearby trash before starting the timer.",
    "Engage Volazj and kill him within TWO minutes. At high level, begin with a low-damage tag, allow combat to register, then finish him; several later comments report missing boss credit after an instantaneous first-hit kill.",
    "If Insanity begins, kill the hostile party copies in your phase, prioritizing a healing copy if present. When the normal room returns, resume damage immediately. A solo character may have no other party copies to fight. Do not follow the old Divine Intervention or repeated zoning-out strategy; it is unnecessary and relies on obsolete abilities or behavior.",
}, { pin(115,28.4,51.7,1,"Ahn'kahet - entrance"), pin(132,23.63,50.41,2,"Herald Volazj - two-minute timer","Ahn'kahet: The Old Kingdom") }, nil, {668329,1173014,2167546,3225059})

-- The qualifying profit comment's five-player tank swap is retained. Current
-- corrections add the health threshold and /sit for high-level dodge chance.
add(2152, "Share The Love", {
    "Bring FIVE distinct player characters to Heroic Gundrak, including two characters able to exchange the boss's attention without heavy damage. Clear through the three altars and gather inside Gal'darah's arena before pulling.",
    "Dismiss pets, remove damage procs and use a low-damage attack to bring Gal'darah below roughly 50% so he transforms into a rhino. Stop damage; an accidental high-level hit can kill him before five impales.",
    "Let each non-tank be impaled. At high level, use /sit with your back toward the boss so the attempt actually lands instead of being avoided. Record the Impaling Charge announcements; merely being charged toward is not proof of an impale.",
    "After the second tank has been impaled, have that character taunt so the original tank can receive an impale too. Wait through additional transformations if targets repeat.",
    "Only after FIVE DIFFERENT characters have been impaled, kill Gal'darah. Credit is awarded on his death. This achievement is separate from Glory of the Hero and is no longer required for that mount meta.",
}, { pin(121,76.4,21.3,1,"Gundrak - northwest entrance"), pin(153,46.5,27,2,"Gal'darah - weaken, then stop damage","Gundrak"), pin(153,46.5,27,3,"Gal'darah - /sit for five distinct impales","Gundrak"), pin(153,46.5,27,4,"Gal'darah - exchange tanks","Gundrak"), pin(153,46.5,27,5,"Gal'darah - kill after all five impales","Gundrak") }, "The standard five-player route avoids the fragile old disconnect-and-alt-swapping method. Recent replies confirm /sit at high level; it does not replace the five-character requirement.", {590587,2025923,2581593,6134542,6260653})

add(1871, "Experienced Drake Rider", {
    "Set Heroic and enter the Oculus through the upper Coldarra portal. Plan three Eregos victories, one while mounted on EACH of the Amber, Emerald and Ruby drakes. Track the three color criteria individually.",
    "Defeat Drakos and take the essence for a missing color from its freed drake. Ride it between platforms, disable the Centrifuge Constructs, defeat Varos and follow Urom's platform sequence until he is dead.",
    "Mount the selected drake and fly to Eregos. Remain mounted until he DIES: a personal ranged kill while dismounted does not satisfy the color criterion. At high level, use the drake's own abilities rather than the old pre-mount projectile trick.",
    "On Ruby, use Searing Wrath and kill whelps if needed. On Amber, use Shock Lance; when Eregos becomes immune, wait out the shift before resuming. On Emerald, maintain Leeching Poison on Eregos and apply it to whelps for healing. Do not dismount to shorten the fight.",
    "Repeat for the other two colors on later Heroic resets, or use eligible alts on separate Heroic lockouts. The account-wide criteria can combine their victories. Confirm all three color checks after the final kill.",
}, { pin(114,28.6,27.5,1,"The Oculus - upper portal"), pin(143,49.1,76.2,2,"Drakos - choose a missing essence color","The Oculus - Band of Variance"), pin(144,46.1,19.2,2,"Varos - construct shield","The Oculus - Band of Acceleration"), pin(145,70.7,27.4,2,"Urom - platform sequence","The Oculus - Band of Transmutation"), pin(146,46.9,20.9,3,"Eregos - remain mounted until death","The Oculus - Band of Alignment") }, "The old profit-ending Throw Glaive macro depends on obsolete damage figures. Later Retail comments and replies confirm direct vehicle kills, including level-80 attempts.", {2563864,3305609,5688796,6041437,6097249})

for _, meta in ipairs({ {1288,"Northrend Dungeonmaster",false}, {1289,"Northrend Dungeon Hero",true} }) do
    local steps = {
        meta[3] and "Set Dungeon Difficulty to HEROIC outside each instance. Complete all twelve original Northrend Heroic clear achievements; no reputation key is required. This is not the encounter-challenge meta Glory of the Hero." or "Complete all twelve original Northrend dungeon clear achievements. Normal is sufficient; Heroic clears also award their Normal counterparts. Track the twelve child achievements so a skipped boss is visible.",
        "In Howling Fjord, clear Utgarde Keep through both Ingvar phases, then Utgarde Pinnacle through Ymiron. Use the lower and upper portals respectively.",
        "On Coldarra in Borean Tundra, clear the Nexus through Keristrasza and the Oculus through Eregos. Use the lowest and upper portals respectively.",
        "In Dragonblight's western pit, clear Azjol-Nerub via the right branch and Ahn'kahet via the left. On Heroic, include Amanitar's mushroom cavern.",
        "Clear Drak'Tharon Keep in southwestern Zul'Drak, then Gundrak in the northeast. Activate Gundrak's three altars; on Heroic, also kill Eck in the side cavern.",
        "At Ulduar in The Storm Peaks, clear Halls of Stone, including Krystallus, Maiden, Brann's event and Sjonnir, and Halls of Lightning through Loken.",
        "Clear the original Violet Hold in Northrend Dalaran through wave 18. Travel to Tanaris's Caverns of Time for the Culling of Stratholme and escort Arthas through Mal'Ganis. Trial of the Champion and the three Frozen Halls dungeons are not required.",
    }
    local points = {
        pin(117,58.2,48.9,2,"Utgarde Keep - lower entrance"), pin(117,57.3,46.7,2,"Utgarde Pinnacle - upper entrance"),
        pin(114,27.5,26.7,3,"The Nexus - lowest portal"), pin(114,28.6,27.5,3,"The Oculus - upper portal"),
        pin(115,26,50.8,4,"Azjol-Nerub - right branch"), pin(115,28.4,51.7,4,"Ahn'kahet - left branch"),
        pin(121,28.6,86.9,5,"Drak'Tharon Keep"), pin(121,76.4,21.3,5,"Gundrak"),
        pin(120,40.1,26.9,6,"Halls of Stone"), pin(120,45.3,21.6,6,"Halls of Lightning"),
        pin(125,66.5,67.8,7,"The Violet Hold - Northrend Dalaran"), pin(75,56.9,82.4,7,"Culling of Stratholme - Caverns of Time"),
    }
    add(meta[1],meta[2],steps,points,"Use the individual dungeon guides for room-by-room progression. A mount-drake challenge, timed run or special boss mechanic is not required by these two clear metas.",meta[3] and {563315,1630192,2867160} or {903550})
end

-- The four faction/difficulty pages each have separate comment lists. All
-- five enemy champions AND both Argent bosses require more than one visit.
for _, trial in ipairs({
    {3778,false,"Horde",{801876,2563801}}, {4296,false,"Alliance",{799859,2563800}},
    {4297,true,"Horde",{799426,2563799}}, {4298,true,"Alliance",{799175,2472353,5636514}},
}) do
    add(trial[1],(trial[2] and "Heroic: " or "") .. "Trial of the Champion",{
        "Use a " .. trial[3] .. " character. " .. (trial[2] and "Set HEROIC outside." or "Normal is sufficient.") .. " Enter the FIVE-PLAYER Trial of the Champion portal at the Argent Tournament's Coliseum in Icecrown (75.1, 21.8), not the adjacent raid.",
        "Equip the supplied lance, mount a tournament horse/worg and tell the announcer you are ready. Defeat the mounted escorts and three selected champions, then defeat those champions again on foot. Re-equip your real weapon after dismounting.",
        "Speak to the announcer for the Argent stage. Kill the attendant packs, then the selected boss: Eadric the Pure or Argent Confessor Paletress. If Paletress shields herself, kill her summoned Memory before finishing her.",
        "Start the last stage and defeat the Black Knight's living, skeleton and ghost forms. Avoid exploding ghouls and wait for each resurrection; his first death is not the end.",
        "Check ALL boss criteria. Repeat for missing champions and the other Argent boss; they cannot all appear in one run. " .. (trial[2] and "Return after daily resets. Before any boss kill, a wrong opening selection can be rerolled by leaving and resetting." or "Leave and reset Normal for additional selections, respecting the hourly instance-entry limit."),
    }, { pin(118,75.1,21.8,1,"Trial of the Champion - five-player entrance"), pin(171,51.3,52.7,2,"Arena - mounted and foot champions","Trial of the Champion"), pin(171,51.3,52.7,3,"Arena - Eadric or Paletress","Trial of the Champion"), pin(171,51.3,52.7,4,"Arena - three Black Knight forms","Trial of the Champion") }, "The opposing champions depend on your faction. Do not confuse completion of one random lineup with completion of every criterion.",trial[4])
end

local frozenHalls = {
    {4516,4519,"The Forge of Souls",{
        "Fly to the Frozen Halls alcove high on Icecrown Citadel's WEST face (52.6, 89.4). Take the LEFT portal labelled The Forge of Souls; the ground-level raid entrance is elsewhere.",
        "If following the Frozen Halls story, take Echoes of Tortured Souls from Jaina (Alliance) or Sylvanas (Horde) just inside. Follow the winding walkway and defeat Bronjahm. Destroy approaching Soul Fragments during an ordinary clear; Soul Power requires a different setup.",
        "Continue to the final platform and defeat the Devourer of Souls. Interrupt Phantom Blast if it survives long enough to cast, stop damage during Mirrored Soul, and stay out of the sweeping Wailing Souls beam. Check both boss criteria and turn in the story quest before moving on.",
    },{ pin(183,43.58,49.59,2,"Bronjahm","The Forge of Souls"), pin(183,43.44,12.09,3,"Devourer of Souls / story hand-in","The Forge of Souls") },{}},
    {4517,4520,"The Pit of Saron",{
        "Fly to the Frozen Halls alcove high on Icecrown Citadel's west face (52.6, 89.4). Enter the RIGHT portal labelled Pit of Saron. If entry is restricted, check the current level requirement and the Frozen Halls story on this character.",
        "Defeat Forgemaster Garfrost on the eastern side, then Ick and Krick on the western route. If progressing toward Halls of Reflection, accept and turn in the faction leader's story quests as you complete their objectives; boss kills without the quest do not replace its hand-ins.",
        "Follow the route uphill through the ambushes and icy tunnel. Avoid the blue icicle-impact circles and clear the exit guards. Reach the final overlook and defeat Scourgelord Tyrannus, avoiding Rimefang's ground ice. Check all three boss criteria and finish the faction leader's hand-in.",
    },{ pin(184,68.03,55.33,2,"Forgemaster Garfrost","Pit of Saron"), pin(184,47.54,39.75,2,"Ick and Krick","Pit of Saron"), pin(184,44.13,26.64,3,"Scourgelord Tyrannus - tunnel destination","Pit of Saron") },{}},
    {4518,4521,"The Halls of Reflection",{
        "Enter the CENTRAL portal in the Frozen Halls alcove high on Icecrown Citadel's west face (52.6, 89.4). If the portal rejects the character, complete the faction leader's Forge of Souls -> Pit of Saron quest progression, including the final Tyrannus hand-in.",
        "Speak to Jaina or Sylvanas inside. Clear the ghost waves in Frostmourne's chamber, defeating Falric after the first set and Marwyn after the second. Continue down the passage and speak to the faction leader to begin the escape.",
        "Stay ahead of the pursuing Lich King and kill every blocking wave at each ice wall. Remain with Jaina/Sylvanas while the wall is broken, then advance together. You are ESCAPING Arthas, not killing him; do not stop to fight him.",
        "At the last wall, finish every remaining wave and follow the leader onto the final ledge. Stay for the gunship rescue and encounter completion; leaving before the scripted ending can miss the escape criterion.",
    },{ pin(185,35.25,75,2,"Falric - first ghost waves","Halls of Reflection"), pin(185,43.44,62.70,2,"Marwyn - second ghost waves","Halls of Reflection"), pin(185,10.52,27.46,3,"Escape route - stay with faction leader","Halls of Reflection") },{"https://www.wowhead.com/achievement=4518#comments:id=899720","https://www.wowhead.com/achievement=4526#comments:id=6430245"}},
}
for _, dungeon in ipairs(frozenHalls) do
    for _, heroic in ipairs({false,true}) do
        local steps = {}
        for index,text in ipairs(dungeon[4]) do
            steps[index] = (index == 1 and (heroic and "Set Dungeon Difficulty to HEROIC outside. " or "Normal is sufficient; Heroic also credits the Normal clear. ") or "") .. text
        end
        local points = {pin(118,52.6,89.4,1,dungeon[3] .. " - Frozen Halls portal room")}
        for _,point in ipairs(dungeon[5]) do points[#points + 1] = point end
        add(heroic and dungeon[2] or dungeon[1],(heroic and "Heroic: " or "") .. dungeon[3],steps,points,
            "The three Frozen Halls clear achievements are separate from the original twelve-dungeon Northrend clear metas. Use the portal's displayed instance name to choose the correct wing.",dungeon[6])
    end
end

add(4523, "Three Faced", {
    "Set Heroic and enter the Forge of Souls through the left Frozen Halls portal high on Icecrown Citadel's west face. Defeat Bronjahm and reach the Devourer of Souls.",
    "At high level, kill the Devourer immediately. Later Retail comments confirm that a first-hit kill awards credit; there is no requirement to let it begin casting Phantom Blast.",
    "If it survives, interrupt EVERY Phantom Blast. Bring a second interrupter if your cooldown cannot cover consecutive casts. Stop ordinary damage during Mirrored Soul while maintaining interrupts; relying on a reflected blast can hurt the mirrored player and invalidate the achievement.",
}, {pin(118,52.6,89.4,1,"Frozen Halls - left Forge of Souls portal"),pin(183,43.44,12.09,2,"Devourer of Souls - prevent Phantom Blast","The Forge of Souls")},nil,{909572,1112579,5366601,6185691})

-- Two old Pit of Saron mechanic achievements were retired in 12.0.1.
-- Normal/Heroic clear achievements remain; temporary seasonal credit issues
-- do not establish permanent retirement. Retail review: 2026-11-04.
-- https://www.curseforge.com/wow/addons/krowi-achievement-filter/files/9058137
-- https://eu.forums.blizzard.com/en/wow/t/pit-of-saron-achievement-bugged/613785/7

-- The latest Retail comment confirms ordinary fast wave kills in Midnight;
-- the old 2024 stuck-ending reports and hand-timed workaround are not the route.
add(4526, "We're Not Retreating; We're Advancing in a Different Direction.", {
    "Set Heroic and enter Halls of Reflection. Complete Falric and Marwyn's ghost waves, then reach Jaina/Sylvanas confronting Arthas. Track this achievement so the six-minute timer is visible.",
    "After the confrontation, SPEAK to the faction leader to start the escape. Running down the empty tunnel without the dialogue does not start the timer or encounter.",
    "Follow the leader to each of the FOUR ice walls. Kill every spawned ghoul, caster and abomination promptly; the wall opens after its enemies are dead. Keep checking for ranged enemies that stopped behind you. Running faster by itself cannot advance an uncleared wall.",
    "Clear the larger final waves, follow the leader to the last ledge and wait for the gunship sequence. The ending still consumes timer time after the final enemy dies, so do not pause for loot or sightseeing.",
    "Walk UP the metal ramp onto the rescuing ship as soon as it appears and remain for credit. A later Midnight comment confirms that fast wave kills followed by boarding the ship work; do not leave the instance before the ending registers.",
}, {pin(118,52.6,89.4,1,"Frozen Halls - central Halls of Reflection portal"),pin(185,35.25,75,1,"Falric - first waves","Halls of Reflection"),pin(185,43.44,62.70,1,"Marwyn - second waves","Halls of Reflection"),pin(185,10.52,27.46,2,"Start the escape with Jaina / Sylvanas","Halls of Reflection")},"Aim to clear the final wall with spare time for the rescue. Old instructions that wait through precisely timed wall kills describe a workaround, not a requirement for the current route.",{909569,910752,1982235,6083914,6430245})

add(3802, "Argent Confessor", {
    "Set Heroic and enter Trial of the Champion at the Argent Tournament. Complete the opening mounted and on-foot champions, then start the Argent encounter. You need Paletress; Eadric cannot award a memory criterion.",
    "Bring Paletress below 50% and wait for her to shield herself and summon a Memory. At high level, use controlled damage and let the scripted summon happen before trying to finish the encounter.",
    "Kill the summoned Memory, THEN defeat Paletress. Check which named memory credited in the achievement window. You need FIVE DIFFERENT memories, not every one of the twenty-five displayed names.",
    "Repeat on later Heroic visits or eligible alts until five distinct checks are present. The selection can repeat. If a fresh character repeatedly sees only Hogger, try an established character with a broader boss-kill history; recent replies connect the available pool to that character's recorded kills.",
    "Do not assume the old kill-memory/Feign Death loop will finish everything in one day: a later reply reports that method stopped working. Keep the confirmed memory check and use another eligible visit rather than killing retired versions of bosses to fill all twenty-five names.",
}, {pin(118,75.1,21.8,1,"Trial of the Champion - Heroic five-player entrance"),pin(171,51.23,52.87,2,"Paletress - below 50% for a Memory","Trial of the Champion"),pin(171,51.23,52.87,3,"Kill Memory, then finish Paletress","Trial of the Champion")},"Only five distinct memories are required. The old fixed-level gear recommendations and historical twenty-five-memory completion attempts are unnecessary.",{1936787,2578554,3122821,5639540,6227881})

add(3803, "The Faceroller", {
    "Set Heroic and complete the opening champions in Trial of the Champion. Start the Argent stage and check the selected boss. You need Eadric the Pure; if Paletress appears, return on another eligible Heroic visit.",
    "Clear Eadric's attendants, dismiss damaging pets and remove automatic damage effects. Engage Eadric by proximity or a non-damaging taunt and WAIT without attacking. A normal high-level attack can end the encounter before the hammer mechanic.",
    "Turn away for Radiance and wait for Hammer of the Righteous. If Hammer of Justice stuns you, remove the stun when possible. Catching the hammer replaces your action bar with a SINGLE hammer button; watch that bar rather than searching the floor for a dropped item.",
    "Face Eadric, target him and press the temporary hammer button. If he survives, immediately follow it with a direct instant attack. Later Retail comments, including Midnight prepatch, confirm that this sequence awards credit; the old requirement to lower him to a fixed 15,000 health is obsolete.",
}, {pin(118,75.1,21.8,1,"Trial of the Champion - Heroic entrance"),pin(171,51.37,52.46,2,"Eadric - wait without dealing damage","Trial of the Champion"),pin(171,51.37,52.46,4,"Throw the caught hammer, then finish promptly","Trial of the Champion")},"If the temporary hammer bar is hidden by an action-bar addon, expose the vehicle/override bar. An ordinary kill before the hammer is thrown fails the objective.",{1517651,2015983,2474635,3217284,5821668,6275021})

add(3804, "I've Had Worse", {
    "Set Heroic and complete Trial of the Champion's first two stages. Before starting the Black Knight, dismiss uncontrolled pets or summons and be ready to move away from marked ghouls.",
    "During the first living phase, kill the single risen ghoul before its explosion completes, or move clear when it is marked. Kill the Black Knight and wait for his skeleton form.",
    "During the second phase, promptly kill the Army of the Dead ghouls or kite away from those preparing to explode. When the skeleton dies, move away from ALL surviving ghouls because they can explode during the transition.",
    "Finish the ghost phase with no party member hit by a ghoul explosion. At high level, immediately killing each boss form and every spawned add works, but do not stand beside surviving marked ghouls while waiting for a resurrection.",
}, {pin(118,75.1,21.8,1,"Trial of the Champion - Heroic entrance"),pin(171,51.37,52.66,2,"Black Knight - avoid first ghoul explosion","Trial of the Champion"),pin(171,51.37,52.66,3,"Black Knight - Army of the Dead / phase transition","Trial of the Champion"),pin(171,51.37,52.66,4,"Black Knight - finish ghost form","Trial of the Champion")},"Older comments report pet and totem explosions invalidating attempts too. The original joke criteria about blue gear, repair costs and party classes were PTR placeholders and do not apply.",{780210,798399,815614,896463,3309810})

add(1919, "On The Rocks", {
    "Set Heroic and enter the LOWER Utgarde Keep portal in Howling Fjord. Follow the opening route to Prince Keleseth.",
    "At high level, kill Keleseth immediately with a single-target attack. He does not have to cast a Frost Tomb first; later Retail comments confirm the fast kill satisfies the achievement.",
    "If anyone is entombed, leave the Frost Tomb completely alone and keep that player alive until it expires naturally. Avoid cleaves, ground effects and uncontrolled pets near the tomb. Do not use old Blink/PvP-trinket escape advice: later corrections report those escapes or a death inside the tomb can invalidate the attempt.",
    "Finish Keleseth without shattering any tomb and check the achievement. This is Prince Keleseth in Utgarde Keep, not the similarly named Blood Prince Council encounter in Icecrown Citadel.",
}, {pin(117,58.2,48.9,1,"Utgarde Keep - lower portal"),pin(133,28.9,62.7,2,"Prince Keleseth - leave Frost Tombs intact","Utgarde Keep - Njorndir Preparation")},nil,{484393,602945,650945,1322100,3185849})

add(1865, "Lockdown!", {
    "Enter the ORIGINAL Violet Hold in Northrend Dalaran on Heroic, not Legion's Assault on Violet Hold. Open the achievement and note which of Xevozz, Lavanthor, Ichoron, Zuramat, Erekem and Moragg are still missing.",
    "Tell Sinclari to begin and clear through the sixth portal. Watch the saboteur run to a prison cell; only the selected prisoner becomes the real boss. You cannot choose a prisoner by attacking its cage.",
    "If the first selection is missing, kill that boss and continue to wave 12 for a second chance. Control pets so your character participates in the kill. Once saved by a boss kill, you cannot freely reroll that Heroic instance.",
    "If the first selection is already complete, leave BEFORE killing it, reset from outside and try again. A hearth, class teleport or leaving a temporary premade group can get you out. Reset the actual instance as well as the event; restarting Sinclari in the same instance can repeat the same prisoner.",
    "Repeat with eligible alts or later resets until all six checks are present. Later Retail comments confirm Warband progress combines characters, so the old minimum-three-days claim is obsolete. The random selection can still repeat; respect the hourly entry limit.",
}, {pin(125,66.5,67.8,1,"Original Violet Hold - Northrend Dalaran"),pin(168,27.60,62.30,3,"Erekem's cell - random selection","The Violet Hold (Northrend)"),pin(168,67.90,52.87,3,"Moragg's cell - random selection","The Violet Hold (Northrend)"),pin(168,55.60,40.37,3,"Ichoron's cell - random selection","The Violet Hold (Northrend)"),pin(168,33.06,45.29,3,"Xevozz's cell - random selection","The Violet Hold (Northrend)"),pin(168,61.89,75,3,"Lavanthor's cell - random selection","The Violet Hold (Northrend)"),pin(168,27.19,33.61,3,"Zuramat's cell - random selection","The Violet Hold (Northrend)")},"Cyanigosa is not one of the six prisoner criteria. A replacement enemy after a previously killed prisoner does not count as a fresh kill of that named boss.",{1509938,2092434,2861624,3206458,5845154,6067422})

add(2156, "My Girl Loves to Skadi All the Time", {
    "Set Heroic and clear Utgarde Pinnacle through Svala and Gortok. Start Skadi's gauntlet and head toward the harpoon-launcher end while clearing the enemies in your way.",
    "Kill Ymirjar Harpooners and LOOT THREE Harpoons. Keep them until all three are ready; firing a single early shot and waiting for another pass fails the full-health-to-dead-in-one-pass objective.",
    "Stand by the launchers and wait until Grauf is in range. Click the launchers in quick succession to fire all THREE shots during that SAME pass. One person can do it; alternate launchers if a gun's cooldown prevents another immediate click. The guns are clicked directly, with no aiming or vehicle action bar.",
    "Once Grauf is down, kill Skadi on foot and check the achievement. The successful pass does not have to be Grauf's first pass of the encounter. Old instructions asking for five or six shots predate the reduction to three.",
}, {pin(117,57.3,46.7,1,"Utgarde Pinnacle - upper entrance"),pin(137,60.6,68.8,1,"Gortok - finish stasis event before gauntlet","Utgarde Pinnacle - Upper Pinnacle"),pin(137,68.4,36.2,2,"Skadi gauntlet - collect harpoons and reach launchers","Utgarde Pinnacle - Upper Pinnacle"),pin(137,68.4,36.2,3,"Skadi gauntlet - three launcher clicks in one pass","Utgarde Pinnacle - Upper Pinnacle")},"Keep a free bag slot if launcher clicks appear to do nothing. Finishing the entire gauntlet within three minutes can also award Lodi Dodi We Loves the Skadi.",{615387,964005,1676174,1894082,2878917,5688810})

add(1873, "Lodi Dodi We Loves the Skadi", {
    "Set Heroic and reach Skadi's gauntlet in Utgarde Pinnacle. Track this achievement before approaching Skadi: the THREE-minute timer begins when he mounts Grauf and starts the gauntlet, not when he lands.",
    "Advance to the launcher end, kill the Ymirjar Harpooners and loot THREE Harpoons promptly. Save all three shots until Grauf is in range so you can bring him down during one pass.",
    "Click the harpoon launchers three times in quick succession while Grauf passes. Kill Skadi immediately after he lands, before the original gauntlet timer expires. Do not stop the timer mentally after shooting the drake; Skadi's death is the finishing condition.",
    "If you need another setup attempt BEFORE killing Skadi, collect harpoons and run back into Gortok's room until the event fully resets. Keep the collected harpoons, verify the achievement timer has reset too, then restart and rush the launchers. Old five-harpoon preparations are unnecessary.",
}, {pin(117,57.3,46.7,1,"Utgarde Pinnacle - upper portal"),pin(137,68.4,36.2,2,"Skadi gauntlet - harpooners / launchers","Utgarde Pinnacle - Upper Pinnacle"),pin(137,68.4,36.2,3,"Skadi - finish before three minutes","Utgarde Pinnacle - Upper Pinnacle"),pin(137,60.6,68.8,4,"Gortok's room - reset unfinished Skadi event","Utgarde Pinnacle - Upper Pinnacle")},"The same attempt can award My Girl Loves to Skadi All the Time if Grauf goes from full health to dead in one pass. Neither achievement guarantees the rare Blue Proto-Drake drop.",{466255,806923,957268,1523857,1657623,3229014})

add(2056, "Volunteer Work", {
    "Set Heroic and enter Ahn'kahet. Reach Jedoga Shadowseeker's platform beyond Prince Taldaram and kill the Twilight INITIATES that start her encounter. These initial enemies are different from the Twilight VOLUNTEERS around the arena.",
    "At high level, directly kill Jedoga after she descends. Later Retail comments confirm that skipping the sacrifice with a fast kill awards credit, provided you have not killed a Volunteer.",
    "If she rises for the sacrifice, STOP area damage and let the selected Twilight Volunteer walk into the circle and sacrifice itself. Do not kill it. When Jedoga lands empowered, survive with defensives and avoid Cyclone Strike, then finish her. Her own sacrifice of the Volunteer does not count as you killing it.",
}, {pin(115,28.4,51.7,1,"Ahn'kahet - entrance"),pin(132,48.22,72.54,1,"Jedoga's platform - Initiates start the encounter","Ahn'kahet: The Old Kingdom"),pin(132,48.22,72.54,3,"Let the Volunteer complete its sacrifice","Ahn'kahet: The Old Kingdom")},"Keep the fight on her platform. Old waterfall/stair kiting instructions were explicitly corrected because they reset the boss.",{467804,573874,1701711,2334833,5178580})

add(2155, "Abuse the Ooze", {
    "Set Heroic, complete Brann's Tribunal event in Halls of Stone and let him open Sjonnir's door. BEFORE combat, dismiss pets, remove damage procs and prepare a very low-damage setup. Whole-Body Shrinka' plus unequipped gear and a spec without passive damage is a later Retail suggestion.",
    "Carefully bring Sjonnir into the 26-49% health range, then STOP all damage to him. Above 50% the required oozes do not spawn; below roughly 25%, friendly Earthen arrive and can kill the boss before you finish.",
    "Leave the small MALFORMED OOZES alive. Let them reach the middle and combine into larger IRON SLUDGES; the small oozes themselves do not count. Wait for the combination animation and check the target name before attacking.",
    "Kill FIVE Iron Sludges with single-target attacks that cannot cleave Sjonnir or destroy the next combining oozes. Count actual Sludge deaths, not the number of small oozes spawned.",
    "Once five Sludges are dead, finish Sjonnir. If even your reduced-damage attacks kill him outright, use a lower-level eligible alt for another attempt rather than repeating the same lethal hit after each daily reset.",
}, {pin(120,40.1,26.9,1,"Halls of Stone - entrance"),pin(140,84.9,76.1,1,"Tribunal of Ages - finish Brann's event","Halls of Stone"),pin(140,49.7,13.7,2,"Sjonnir - stop at 26-49% health","Halls of Stone"),pin(140,49.7,13.7,3,"Sjonnir's platform - let Malformed Oozes combine","Halls of Stone"),pin(140,49.7,13.7,4,"Kill five IRON SLUDGES before Sjonnir","Halls of Stone")},"Shrinka' must be activated before combat and does not guarantee that every class's attack will be weak enough. Later replies confirm both successful reduced-damage setups and remaining one-shot problems.",{538017,1836375,2344296,2540717,5534387,5661958,6279118})

add(2151, "Consumption Junction", {
    "Set Heroic and enter Drak'Tharon Keep. Clear the approach to Trollgore at the first stair chamber and prepare direct single-target damage.",
    "At high level, kill Trollgore immediately before his Consume buff reaches TEN stacks. Later Retail comments confirm a one-hit kill; waiting for the first Consume is unnecessary.",
    "If the fight lasts, remember that Consume gains stacks from multiple eligible targets in his line of sight, including approaching enemies. Pull him beside the stair pillar so the group can break line of sight before a Consume, and kill incoming trolls before they join him. Resume damage after the cast and finish while he remains below ten stacks.",
}, {pin(121,28.6,86.9,1,"Drak'Tharon Keep - entrance"),pin(160,56.5,18.2,2,"Trollgore - kill below ten Consume stacks","Drak'Tharon Keep - The Vestibules")},"The old stopwatch macros and level-80 damage targets are optional historical tactics. Watch the boss's actual Consume stacks instead of assuming a fixed twenty-nine-second deadline.",{473182,476519,747329,2497299,3225062})

add(2039, "Better Off Dred", {
    "Set Heroic and reach King Dred's fenced raptor courtyard in Drak'Tharon Keep. Leave the small raptors ALIVE while clearing the rest of the approach; you need at least six available during the boss fight.",
    "Dismiss pets and remove uncontrolled cleave or retaliation damage. Gather the raptors without killing them, then engage King Dred with proximity or a non-damaging taunt. Make sure Dred is actually in combat before the first counted raptor dies.",
    "While Dred remains ALIVE, single-target SIX Drakkari Gutrippers/Drakkari Scytheclaws. Clear your target or stop auto-attacking between kills so Dred does not become your next automatic target. Killing all seven available raptors is a safe way to avoid a miscount.",
    "After the six qualifying deaths, kill Dred. Do not wait for an endless supply of newly summoned raptors: Call Raptor brings existing courtyard raptors into combat. Killing several before pulling Dred cannot be fixed by waiting for replacements.",
}, {pin(121,28.6,86.9,1,"Drak'Tharon Keep - entrance"),pin(160,61.2,86.2,1,"Dred's courtyard - keep six raptors alive","Drak'Tharon Keep - The Vestibules"),pin(160,61.2,86.2,3,"Kill six raptors WHILE Dred is engaged and alive","Drak'Tharon Keep - The Vestibules")},nil,{460567,603053,788731,2295343,2371939})

add(1864, "What the Eck?", {
    "Set Heroic and enter Gundrak. Defeat Slad'ran, the Colossus and Moorabi and click each boss's altar to open the bridge to Gal'darah. Leave Gal'darah alive. Behind Moorabi, take the side passage into Eck's cavern and kill the three inhabitants that trigger his arrival.",
    "Do NOT kill Eck yet. Control pets and damage procs, engage without dealing damage and stand in front of him so Eck Spit can hit you. At high level, turn your character's back toward him, try /sit, and remove gear if needed; it can take repeated casts, including after his enrage.",
    "Wait until your debuff bar actually shows ECK RESIDUE, lasting one hour. The cast animation or a resisted/missed spit is insufficient. Once the lasting debuff is present, kill Eck.",
    "Return through Moorabi's room and cross the opened central bridge. Defeat Gal'darah while YOU still have Eck Residue. Avoid dying or using immunity/debuff-clearing abilities such as Ice Block or Cloak of Shadows along the way.",
}, {pin(121,76.4,21.3,1,"Gundrak - northwest entrance"),pin(153,53.9,48.5,1,"Slad'ran / altar","Gundrak"),pin(153,46.5,65.5,1,"Colossus / altar","Gundrak"),pin(153,39.3,48.9,1,"Moorabi / altar / side passage","Gundrak"),pin(153,25.1,70.4,2,"Eck - wait for spit, do not kill yet","Gundrak"),pin(153,46.5,27,4,"Gal'darah - kill WITH Eck Residue","Gundrak")},"The achievement is awarded after Gal'darah, not after Eck. Recent Retail comments still report variable waits for the spit; /sit is a useful attempt, not a guaranteed instant application.",{468698,2229664,3277978,5407705,5999784,6389232})

add(2041, "Dehydration", {
    "Enter the ORIGINAL Violet Hold in Northrend Dalaran on Heroic. Start Sinclari's event and reach the first prisoner selection at wave 6. You need Ichoron, released from the water pool; if another prisoner is chosen, leave before killing it and reset from outside to reroll an unsaved instance.",
    "When Ichoron becomes attackable, kill him with a strong direct attack. Later Retail comments confirm that killing him before any globules spawn awards the achievement; you do not have to play through every old shield phase.",
    "If his Protective Bubble survives, attack until it breaks and then kill EVERY Ichor Globule before it reaches his body. A usable red Defense Control Crystal on the prison wall can kill the globules when activated at the split; use a fresh crystal for a later split and watch for any globule already close to him.",
    "Finish Ichoron with no globule having merged. If working on Defenseless in the same run, leave the crystals untouched and handle the globules manually, or use the immediate-kill route. After Ichoron has died, his replacement Swirling Water Revenant cannot award another attempt at this achievement.",
}, {pin(125,66.5,67.8,1,"Original Violet Hold - entrance"),pin(168,55.60,40.37,2,"Ichoron's pool - kill before globule merges","The Violet Hold (Northrend)")},"The blue saboteur chooses the prisoner randomly. Reset the actual instance from outside for a reroll; restarting the same event alone can retain the same bosses.",{502972,741103,831358,1604442,2372823,2534039,2878793,5626058})

add(1817, "The Culling of Time", {
    "Set Heroic and enter the Culling of Stratholme through the Caverns of Time in Tanaris. Complete Chromie's crate introduction or use the available skip dialogue, then speak to Arthas to begin the timed street event.",
    "Clear the ten marked street waves, including Meathook and Salramm. Keep following the minimap's next wave marker. Speak to Arthas when he arrives at the town hall; clear its Infinite enemies and defeat Chrono-Lord Epoch.",
    "Speak to Arthas again and follow him through the passage and burning-street gauntlet. Kill enemies that stop the escort. The Infinite Corruptor must DIE before the 25-minute countdown expires; merely pulling him just before expiry is insufficient.",
    "At the final clean street before Mal'Ganis's square, take the LEFT side alley toward Market Row. Kill the Infinite Corruptor beside the captive bronze drake, then check the achievement. Do this before starting Mal'Ganis to avoid wasting the remaining timer.",
}, {pin(75,56.9,82.4,1,"Culling of Stratholme - Caverns of Time portal"),pin(131,56.6,59.2,2,"Meathook - first street waves","Stratholme City"),pin(131,59.1,40.1,2,"Salramm - later street waves","Stratholme City"),pin(131,65.8,25.8,2,"Chrono-Lord Epoch - town hall","Stratholme City"),pin(131,50.9,41.75,4,"Infinite Corruptor - Market Row side alley","Stratholme City")},"Mal'Ganis is not the timed target. The Corruptor can remain after Mal'Ganis if time is left, but taking the side alley first removes that unnecessary delay.",{401786,432246,462102,470058,3245166,"https://www.wowhead.com/npc=32273#comments:id=5148009"})

add(2046, "Amber Void", {
    "Set Heroic and enter the Oculus at Coldarra's upper portal. Defeat Drakos and take a RUBY essence from the freed red drake. Have every party member avoid Amber drakes; the restriction applies to the whole party.",
    "Disable Varos's shield by killing the Centrifuge Constructs and defeat him. Follow Urom's platform packs and defeat Urom, then mount your permitted drake and fly to Eregos on the highest ring.",
    "Defeat Eregos without anyone using an AMBER drake. At high level, a Ruby drake's Searing Wrath can handle the boss and whelps; use Evasive Maneuvers if needed and move away from the orbs during immunity phases. A permitted Emerald drake can heal in a group if necessary.",
    "Stay within the upper-ring encounter area and finish Eregos. Check Amber Void after the kill. This is an Oculus drake-color restriction, not a Malygos/Eye of Eternity mechanic, and it does not require the entire party to use five drakes.",
}, {pin(114,28.6,27.5,1,"The Oculus - upper portal"),pin(143,49.1,76.2,1,"Drakos - select Ruby, not Amber","The Oculus - Band of Variance"),pin(144,46.1,19.2,2,"Varos - clear construct shield","The Oculus - Band of Acceleration"),pin(145,70.7,27.4,2,"Urom - finish platform sequence","The Oculus - Band of Transmutation"),pin(146,46.9,20.9,3,"Eregos - NO Amber drakes in the party","The Oculus - Band of Alignment")},"Older group tactics assume level-80 vehicle durability and can be unnecessarily complex at high level. The color prohibition remains the deciding condition.",{594872,953415,957274,1447256,"https://www.wowhead.com/achievement=1871#comments:id=3305609"})

add(1868, "Make It Count", {
    "Set Heroic and enter the Oculus. Before killing Drakos, decide which essence to take and prepare the route; the TWENTY-minute timer starts at DRAKOS'S DEATH, not when you enter the dungeon.",
    "Kill Drakos, immediately take an essence from the freed drakes and mount. At high level a Ruby drake is a straightforward choice. Fly to the construct level without spending time on unnecessary wandering drakes.",
    "Kill all TEN Centrifuge Constructs, including the groups on both outer platforms and the inner horseshoe. Remount between separated platforms. When the shield is gone, land on Varos's platform, dismount and defeat him.",
    "Fly to Urom's platforms, clear each summoned pack and follow his teleports. Finish him on the inner ring, remount and reach Eregos on the highest ring promptly.",
    "Kill Eregos before the twenty-minute timer expires. Use your drake's attacks, kill threatening whelps and move away from the planar-shift orbs. The normal-to-Heroic trick for carrying an essence into a pre-cleared instance was removed long ago; start and finish a real Heroic run.",
}, {pin(114,28.6,27.5,1,"The Oculus - upper portal"),pin(143,49.1,76.2,2,"Drakos - death STARTS twenty-minute timer","The Oculus - Band of Variance"),pin(143,47.6,80.2,2,"Freed essence drakes - mount promptly","The Oculus - Band of Variance"),pin(144,46.1,19.2,3,"Varos - destination after all ten constructs","The Oculus - Band of Acceleration"),pin(145,70.7,27.4,4,"Urom - complete all platform packs","The Oculus - Band of Transmutation"),pin(146,46.9,20.9,5,"Eregos - kill before timer expires","The Oculus - Band of Alignment")},"Do not waste the timer changing drake colors repeatedly or looting every trash corpse. Later Retail vehicle comments supersede the old assumption that the drakes cannot be used for a high-level solo kill.",{566896,582969,633318,738694,1761449,"https://www.wowhead.com/achievement=1871#comments:id=6041437"})

-- Current correction: fragments are not reliably rootable/slowable. The
-- grate route is confirmed in October 2026 replies. Coordinates are from
-- replies 1793445 and 1812853 to the detailed Hunter guide, not guessed pins.
add(4522, "Soul Power", {
    "Enter the Forge of Souls on Heroic with a HUNTER for this solo route. Clear trash around Bronjahm, the FIRST boss. Put your pet on Passive and bind Move To, Disengage and a single-target finishing attack. Trailblazer, Pathfinding and Posthaste help with the return runs; remove uncontrolled damage effects.",
    "Start combat by moving the passive pet onto Bronjahm, without attacking yourself. Move the pet toward the entrance-side ramp and park it near 47.0, 53.1 on the Forge of Souls map, beside the chain near the ramp's top. The PET must hold aggro so Bronjahm casts Corrupt Soul on you.",
    "Stand on the open grate around 54.4, 57.5 with the boss in sight. When Corrupt Soul STARTS casting, Disengage backward onto the lower slanted grate around 56, 58. Land there BEFORE the cast finishes and stuns you. The fragment now has a longer route back to Bronjahm.",
    "Run back around to the casting position for the next cast, roughly thirty seconds later. Repeat until THREE fragments are alive. Keep yourself in casting range and line of sight between drops; missing a cycle lets the first fragment catch the boss.",
    "After the third drop, use your speed cooldown to return toward the pet. Use Move To repeatedly to pull Bronjahm BACK toward his boss room, away from the approaching first fragment. Remain in sight and at enough distance for the FOURTH fragment to spawn on you.",
    "As soon as FOUR fragments are alive, single-target Bronjahm to death before any reaches him. Do not cleave the fragments. If a fragment is consumed or the boss resets, rebuild the setup before killing him; the achievement needs four living fragments at the killing blow.",
}, {pin(118,52.6,89.4,1,"Frozen Halls - Forge of Souls portal"),pin(183,47,53.1,2,"Pet tank position - ramp top beside chain","The Forge of Souls"),pin(183,54.4,57.5,3,"Player takeoff - wait for Corrupt Soul cast","The Forge of Souls"),pin(183,56,58,3,"Lower slanted grate - land before cast finishes","The Forge of Souls"),pin(183,54.4,57.5,4,"Return for next cast - repeat to three fragments","The Forge of Souls"),pin(183,43.58,49.59,5,"Pull pet and boss back toward arena for fourth fragment","The Forge of Souls"),pin(183,43.58,49.59,6,"Finish Bronjahm with FOUR fragments alive","The Forge of Souls")},"A player tank alone is not the solo setup: Corrupt Soul needs another eligible target. Old Water Elemental, root and slow instructions are not the current Hunter route. This achievement is not required for Glory of the Hero.",{1517663,2203220,6097976,6182051,6279238,"https://www.wowhead.com/comment/show-replies?id=6097976","https://www.wowhead.com/comment/show-replies?id=6279238"})

-- The two Azjol-Nerub pages below were read in full: 246 parent comments
-- for Watch Him Die and 93 for Hadronox Denied, with no qualifying profit
-- list. Modern direct-kill reports replace obsolete ledge/racer setups.
add(1296, "Watch Him Die", {
    "Set Dungeon Difficulty to HEROIC outside Azjol-Nerub. In western Dragonblight, enter the Nerubian pit and take the RIGHT branch by the meeting stone; the left branch is Ahn'kahet.",
    "Reach the first boss chamber, The Gilded Gate. Identify Krik'thir the Gatewatcher behind the three Watchers: Gashra, Narjil and Silthik. Leave ALL THREE Watchers alive; do not clear their packs with area damage as you normally might.",
    "At high level, run into range and kill KRIK'THIR with a direct single-target attack before touching the Watchers. Dismiss uncontrolled pets and avoid cleaves or damage procs that could kill a Watcher first. The Watchers do not have to be pulled or killed to make this achievement count.",
    "Check for Watch Him Die after Krik'thir's death, then clean up any remaining attackers. You may kill the Watchers after the achievement has credited. Old ledge-climbing, sacrificial kiting, raid-gear requirements and level-80 damage targets are unnecessary for this Retail route.",
}, {pin(115,26,50.8,1,"Azjol-Nerub - right branch entrance"),pin(159,50.1,45,2,"Krik'thir - three Watchers must remain alive","Azjol-Nerub - The Gilded Gate"),pin(159,50.1,45,3,"Single-target Krik'thir BEFORE the Watchers","Azjol-Nerub - The Gilded Gate")},"This is the FIRST boss of Azjol-Nerub. Killing the three named Watchers before him fails the attempt even if his own kill is instantaneous.",{450967,1939480,3216035,3225057})

add(1297, "Hadronox Denied", {
    "Enter Azjol-Nerub on HEROIC and defeat Krik'thir. Stop on the web bridge overlooking the next chamber; the three large Crusher groups below are the event trash, not the achievement target.",
    "At high level, head down the webbed route toward Hadronox's LOWER chamber before the spider climbs up and seals the top doors. You can bypass the Crusher groups for this approach; killing through the full waiting event gives Hadronox time to move into the normal doorway-closing sequence.",
    "Engage Hadronox at the lower end and kill it immediately with single-target damage. Later Retail comments, including The War Within, confirm that an ordinary fast kill works. You do not need a Crashin' Thrashin' Racer, Feign Death, a sacrificed player or an event reset.",
    "Confirm Hadronox Denied before clearing the surviving enemies and dropping down the hole toward Anub'arak. If damage is slow, keep Hadronox away from dying poisoned adds, which can heal it; the objective is to kill BEFORE the top doors are webbed, not merely to survive the normal encounter.",
}, {pin(115,26,50.8,1,"Azjol-Nerub - entrance"),pin(159,50.1,45,1,"Krik'thir - clear before Hadronox approach","Azjol-Nerub - The Gilded Gate"),pin(158,43.1,59.4,2,"Hadronox - reach the lower chamber early","Azjol-Nerub - Hadronox's Lair"),pin(158,43.1,59.4,3,"Kill Hadronox before the top doors are sealed","Azjol-Nerub - Hadronox's Lair")},"Do not wait upstairs for the normal event to finish, and do not jump into Anub'arak's one-way drop before finishing Hadronox.",{511332,1676946,1841261,5968445})

-- No qualifying numbered profit list was found on these six pages.
-- The full parent-comment lists and the selected modern guide replies
-- were reviewed before writing these Retail routes.
add(1860, "Gotta Go!", {
    "Enter Azjol-Nerub on HEROIC, defeat Krik'thir and Hadronox, then drop into the final Brood Pit. This is dungeon Anub'arak, not the Trial of the Crusader raid boss.",
    "Engage Anub'arak and attack immediately. The current limit is FOUR minutes from the pull. Ignore old two-minute strategies involving stolen buffs, stacked casting slows or specially selected level-80 groups.",
    "If he stops at 1 health and burrows, stay in the arena and immediately kill each wave of summoned enemies. Later Retail reports describe this health floor: more damage cannot finish an untargetable submerged boss. Avoid the spikes while waiting for the next wave.",
    "Attack as soon as he resurfaces, clear another add wave if required, and finish him before the countdown expires. The timer covers the whole encounter, including the underground phases; it does not restart when he reappears.",
}, {pin(115,26,50.8,1,"Azjol-Nerub - entrance"),pin(158,43.1,59.4,1,"Hadronox - clear before the one-way drop","Azjol-Nerub - Hadronox's Lair"),pin(157,62.1,48.7,2,"Anub'arak - four-minute timer starts on pull","Azjol-Nerub - The Brood Pit"),pin(157,62.1,48.7,3,"Clear burrow-phase adds immediately","Azjol-Nerub - The Brood Pit")},"Tracking the achievement makes the countdown easier to follow. An unavoidable burrow does not by itself fail the current four-minute requirement.",{503867,613727,3225058,5968450})

add(1872, "Zombiefest!", {
    "Set HEROIC and enter the Culling of Stratholme through the Caverns of Time. Complete Chromie's introduction or use her available skip, then start Arthas's event. Track Zombiefest! so you can see its kill count and one-minute timer.",
    "Clear the ten street waves, Meathook and Salramm normally. Speak to Arthas at the town hall, defeat the Infinite enemies and Chrono-Lord Epoch, then speak to Arthas to open the secret bookcase passage.",
    "Follow the passage to the burning alley. Leave Arthas WAITING at the bottom: do not choose the dialogue that starts his next escort. Dismiss pets and remove retaliation damage or other effects that could kill a Risen Zombie early.",
    "Walk the entire alley toward Mal'Ganis's empty square, gathering EVERY Risen Zombie without killing any. Check both sides, carts and corners. Slow down for the trailing zombies so they do not reset; wait for them to join the final pack.",
    "Kill the gathered zombies with area damage. The final alley contains the required 100, and the minute starts at the FIRST zombie death. If the count stops at 99, immediately look back for a straggler. A later reply also reports finding replacement spawns near the alley entrance.",
    "If the minute expires, keep Mal'Ganis alive and Arthas waiting, allow the alley to repopulate and try again. Resume the escort only after checking achievement credit. You do not need to kite Salramm into the town hall for this route.",
}, {pin(75,56.9,82.4,1,"Culling of Stratholme - Caverns of Time portal"),pin(131,56.6,59.2,2,"Meathook - clear street waves","Stratholme City"),pin(131,59.1,40.1,2,"Salramm - clear normally","Stratholme City"),pin(131,65.8,25.8,2,"Epoch - then ask Arthas to open the bookcase","Stratholme City"),pin(131,32.5,45.9,4,"Mal'Ganis's square - end of final-alley gathering route","Stratholme City"),pin(131,32.5,45.9,5,"Wait for all trailing zombies, then kill 100","Stratholme City")},"All eight replies to the detailed Dragonflight alley guide were read, including later successful Retail runs. Do not start Arthas: his kills can consume zombies needed for your attempt.",{2621712,3194515,3228720,3288147,5534417,"https://www.wowhead.com/comment/show-replies?id=5534417"})

add(2043, "The Incredible Hulk", {
    "Enter Utgarde Pinnacle on HEROIC. Clear the approach but leave the Scourge Hulks alive as spare targets. At Svala's room, wait for her Lich King dialogue to finish. Remove damage procs, dismiss pets and prepare attacks weak enough to leave BOTH enemies alive.",
    "If needed, remove gear and use Whole-Body Shrinka' BEFORE combat; its damage reduction lasts only three minutes. Naked caster melee attacks or single ticks of a Monk's Crackling Jade Lightning have worked in later Retail reports. Damage varies by class: do not assume one punch is safe. Use an eligible lower-level alt if you cannot control it.",
    "Engage Svala FIRST with proximity or a non-damaging taunt, then collect the Hulk at the far end of the room. Carefully lower the Hulk to roughly 10-20% without a damage-over-time effect. Stop auto-attacking immediately after every deliberate hit.",
    "Position near the back corner under the stairs or the upper entry doorway so the Hulk must walk back to the altar after your teleport. Reduce Svala below 50% with controlled single-target hits, then STOP attacking. Do not kill her or the three Ritual Channelers.",
    "During Ritual of the Sword, wait while stunned. The Hulk must reach the altar and be hit by the descending sword and its damage effect. Let Svala's effect kill the weakened Hulk; this avoids the conflicting reports about player finishing blows. Check for credit at the Hulk's death, then kill Svala.",
    "If the Hulk dies early, misses the sword or survives its damage, leave Svala ALIVE and run out to reset the unfinished encounter. Another nearby Hulk can provide a spare attempt. Killing Svala saves the Heroic boss and prevents another attempt on that character until reset.",
}, {pin(117,57.3,46.7,1,"Utgarde Pinnacle - upper entrance"),pin(136,36.3,70.6,1,"Svala - leave surrounding Scourge Hulks alive","Utgarde Pinnacle - Lower Pinnacle"),pin(136,36.3,70.6,3,"Engage Svala FIRST, then weaken a Hulk","Utgarde Pinnacle - Lower Pinnacle"),pin(136,36.3,70.6,5,"Svala's altar - sword must kill the Hulk","Utgarde Pinnacle - Lower Pinnacle")},"Midnight replies confirm both caster and Shrinka' approaches, but neither works for every damage setup. One newer comment combines Shrinka' with the one-minute Resurrection Sickness; do not rely on the obsolete long sickness window. Soft Foam Sword is not an instance solution, and Fel-Scarred passive damage can ruin a Demon Hunter attempt.",{1856997,2466247,5709367,5761147,6044990,6053930,6067343,6126733,6169675,6375532,"https://www.wowhead.com/comment/show-replies?id=2466247","https://www.wowhead.com/comment/show-replies?id=6169675","https://www.wowhead.com/comment/show-replies?id=6126733"})

-- Emerald Void: all 66 parent comments were read; no qualifying profit
-- list was present. Later Retail vehicle reports support the Ruby route
-- without importing the old five-player Amber rotation or drake buffs.
add(2045, "Emerald Void", {
    "Set Dungeon Difficulty to HEROIC outside the Oculus. Enter Coldarra's UPPER portal in Borean Tundra, defeat Drakos, then take a RUBY essence from the freed red drake. Nobody in the party may use an Emerald (green) drake for Eregos.",
    "Mount the Ruby drake and fly to the construct level. Dismount to destroy all ten Centrifuge Constructs, then defeat Varos after his shield disappears. Follow Urom through his platform packs, defeat him, and remount for the highest ring.",
    "Engage Ley-Guardian Eregos on your RUBY drake. Use Searing Wrath against him and the whelps; its chaining attack helps clear the smaller enemies. Use Evasive Maneuvers if needed. During Planar Shift, move around the upper ring away from the pursuing orbs, then resume attacking when Eregos becomes vulnerable.",
    "Finish Eregos with no Emerald drake used by any party member. Remaining mounted also gives Ruby credit toward Experienced Drake Rider. An all-Ruby kill can award Amber Void at the same time, because no Amber drake was used either.",
}, {pin(114,28.6,27.5,1,"The Oculus - upper portal"),pin(143,49.1,76.2,1,"Drakos - free the essence drakes","The Oculus - Band of Variance"),pin(143,47.6,80.2,1,"Choose RUBY essence, not Emerald","The Oculus - Band of Variance"),pin(144,46.1,19.2,2,"Varos - clear all ten constructs first","The Oculus - Band of Acceleration"),pin(145,70.7,27.4,2,"Urom - finish the platform sequence","The Oculus - Band of Transmutation"),pin(146,46.9,20.9,3,"Eregos - Ruby vehicle attacks / avoid planar orbs","The Oculus - Band of Alignment"),pin(146,46.9,20.9,4,"Defeat Eregos with NO Emerald drakes","The Oculus - Band of Alignment")},"At high level, later Retail reports confirm solo kills using the drake's attack. The old five-Amber coordination, player healer on a rock and borrowed stamina buffs are unnecessary for this route. Do not confuse Emerald Void (no green drake) with Amber Void (no bronze drake).",{856073,924563,997384,"https://www.wowhead.com/achievement=1871#comments:id=3305609","https://www.wowhead.com/achievement=1871#comments:id=6041437"})

-- All four Halion pages were read. The 25-player Heroic numbered profit
-- guide has three replies: they confirm the slow phase transition matters,
-- while returning through the second portal is optional once phase 3 starts.
for _, ruby in ipairs({{4815,25,false},{4816,25,true},{4817,10,false},{4818,10,true}}) do
    add(ruby[1],(ruby[3] and "Heroic: " or "") .. "The Twilight Destroyer (" .. ruby[2] .. " player)",{
        "Outside, set Legacy Raid Size to " .. ruby[2] .. " players and Raid Difficulty to " .. (ruby[3] and "HEROIC" or "NORMAL") .. ". Enter the ground-level chamber BENEATH Wyrmrest Temple in Dragonblight and take the Ruby Sanctum portal, not the Obsidian Sanctum portal.",
        "Clear the trash and kill Baltharus the Warborn and Saviana Ragefire, then General Zarithrian. All three lieutenants must die before Halion lands in the central clearing.",
        "Use LOW damage on Halion rather than an immediate one-shot. Bring him to 75%, wait for the Twilight Portal and enter it. High-level damage procs or pets can skip the transition and cause missing achievement credit.",
        "In the Twilight Realm, avoid the rotating beam between the orbs. Lower Halion to 50% and allow the second portal/phase transition to register.",
        "Finish Halion after phase 3 begins. The guide's replies confirm that you do not have to return through the second portal just to receive credit. Check the achievement for the intended raid size and difficulty before leaving.",
    }, {pin(115,59.8,54.6,1,"Chamber beneath Wyrmrest Temple - choose Ruby Sanctum"),pin(200,65.8,53.9,2,"Baltharus the Warborn","The Ruby Sanctum"),pin(200,36.5,53.7,2,"Saviana Ragefire","The Ruby Sanctum"),pin(200,49.6,80.1,2,"General Zarithrian","The Ruby Sanctum"),pin(200,49.14,53.58,3,"Halion - wait for first portal","The Ruby Sanctum"),pin(200,49.14,53.58,4,"Halion - allow phase 3","The Ruby Sanctum"),pin(200,49.14,53.58,5,"Halion - finish after transitions","The Ruby Sanctum")},
        "Heroic does not require a prior Normal clear. Avoid instant kills even at maximum level: the phase transitions are the important correction in the comments.",{"https://www.wowhead.com/achievement=4816#comments:id=2302580","https://www.wowhead.com/achievement=4817#comments:id=1038644"},"Raids")
end
