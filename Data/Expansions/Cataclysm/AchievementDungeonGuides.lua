-- English Retail walkthroughs, manually reconciled with Wowhead comments and
-- replies. Reviewed 2026-11-04. Difficulty describes the achievement mechanic,
-- including damage control and travel, rather than the original level-85 fight.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.achievements = TDP.CollectionWalkthroughs.achievements or {}
local guides = TDP.CollectionWalkthroughs.achievements

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(id, name, difficulty, reason, steps, waypoints, comments, tips, replyIDs)
    local lines = { "Difficulty: " .. difficulty:gsub("^%l", string.upper) .. " - " .. reason }
    local sources = {}
    for step, instruction in ipairs(steps) do lines[#lines + 1] = step .. ". " .. instruction end
    for _, commentID in ipairs(comments or {}) do
        sources[#sources + 1] = "https://www.wowhead.com/achievement=" .. id .. "#comments:id=" .. commentID
    end
    guides[id] = {
        achievementId = id, name = name, category = "Dungeons", sourceType = "Achievement", source = name,
        difficulty = difficulty, difficultyReason = reason, stepCount = #steps,
        acquisition = table.concat(lines, "\n\n"), waypoints = waypoints or {},
        tips = tips, sources = sources, sourceComments = comments, sourceReplyIds = replyIDs,
        wowheadUrl = "https://www.wowhead.com/achievement=" .. id,
        sourceURL = "https://www.wowhead.com/achievement=" .. id .. "#comments",
    }
end

-- NPC coordinates use Retail Wowhead g_mapperData. Floor numbers are resolved
-- with Retail UiMapGroupMember, not confused with Wowhead's zone IDs.
local blackrock = pin(36, 27.4, 27.9, 1, "Blackrock Caverns - eastern hallway INSIDE Blackrock Mountain", "Burning Steppes")
local stonecore = pin(207, 47.6, 52.0, 1, "The Stonecore - elevated entrance", "Deepholm")
local vortex = pin(249, 76.7, 84.4, 1, "The Vortex Pinnacle - airborne entrance", "Uldum")
local lostCity = pin(249, 60.5, 64.1, 1, "Lost City of the Tol'vir - entrance", "Uldum")
local halls = pin(249, 69.1, 52.9, 1, "Halls of Origination - entrance", "Uldum")
local grimBatol = pin(241, 19.2, 54.1, 1, "Grim Batol - entrance", "Twilight Highlands")

-- Preferred numbered profit guide: 3217997, including all three public replies.
-- The Midnight report 6461312 updates the damage-control method; its measured
-- 47% hit is character-specific, not a promised damage value.
add(5281, "Crushing Bones and Cracking Skulls", "hard", "Keep a fragile boss and his adds alive through two deliberately controlled health transitions.", {
    "Set dungeon difficulty to Heroic before entering Blackrock Caverns. Stop at Rom'ogg Bonecrusher, the first boss. Dismiss attacking pets and remove damage procs, weapons and gear that could kill him or the adds automatically. A second player makes collecting enough elementals easier.",
    "Start with proximity aggro or a non-damaging taunt. Take damage from Quake so Angered Earth elementals actually appear. Face away and repeatedly sit if avoidance prevents Quake from damaging you. Keep the elementals alive; do not use an area attack on them.",
    "Collect at least five elementals for the first Skullcracker. Move Rom'ogg away from them before damaging him, so your controlled hit cannot kill the adds. Lower him below about 66% while keeping him above 33%, then stop attacking immediately. Use a damage-reduction toy BEFORE combat, or suitably weak damage whose strength you have checked; an ungeared auto attack can still kill him.",
    "A Midnight comment reports using Oil of Immolation while naked to trigger the phase. If using that method, cancel the oil buff immediately after the needed tick and keep the adds outside its radius. The reported damage depends on the character; do not assume one potion tick always leaves the same health. Account for the potion cooldown before the next phase.",
    "Let Chains of Woe pull everyone in and let THE BOSS'S Skullcracker kill the gathered elementals. Do not kill them yourself. Gather the next set, lower him below about 33%, stop damage and repeat. Ten qualifying kills are required in total; collect spare elementals where possible because older replies report missed credit at exactly ten.",
    "Finish Rom'ogg only after both Skullcracker phases have killed enough elementals. If an accidental hit skips both thresholds or kills the adds, reset before killing the boss and start again. Check achievement credit before continuing the dungeon.",
}, { blackrock, pin(283, 50.0, 70.2, 2, "Rom'ogg - Quake elementals", "Blackrock Caverns - Chamber of Incineration"), pin(283, 50.0, 70.2, 5, "Rom'ogg - two Skullcracker phases", "Blackrock Caverns - Chamber of Incineration") }, {3217997, 6461312}, "Do not copy old level-120 punch damage or old gear requirements. The mechanic needs actual Quake spawns and boss-caused elemental deaths.", {1394177, 1395033, 1401908})

add(5282, "Arrested Development", "easy", "Wait for three zealots to evolve before killing them and Corla.", {
    "Enter Blackrock Caverns on Heroic and reach Corla, Herald of Twilight. There must be THREE kneeling zealots; two means you entered Normal. Dismiss attacking pets and avoid area damage while starting the encounter.",
    "Walk close enough to engage Corla, then stand outside the purple beams and wait. Let all three ZEALOTS reach 100 Evolution stacks. Do not intercept the beams yourself: transforming a player does not meet the achievement.",
    "Watch for three separate 'A Twilight Zealot has evolved!' messages. Kill the three evolved dragonkin, then kill Corla. At a high Retail level the old two-beam rotation and separate off-tank strategy are unnecessary; a lower-level group can still evolve and kill one zealot at a time.",
}, { blackrock, pin(284, 27.0, 16.3, 2, "Corla - leave all three beams unobstructed", "Blackrock Caverns - Twilight Forge") }, {1218698, 1419035, 2076998, 2533649, 2871868, 5906299})

add(5283, "Too Hot to Handle", "easy", "Position Karsh in the fire and withhold all damage until his armor reaches 15 stacks.", {
    "Enter Blackrock Caverns on Heroic and reach Karsh Steelbender in the circular forge. Disable attacking pets, damage shields, automatic attacks and damage-over-time effects before engaging him.",
    "Use proximity aggro or a non-damaging taunt and lead Karsh into the central pillar of fire. Watch HIS Superheated Quicksilver Armor stacks. Keep him in the fire until he reaches at least 15; at a high Retail level the incoming damage is normally manageable.",
    "After you have actually seen 15 stacks, kill Karsh. If attempting this while leveling, dip him into the fire for a few stacks at a time and refresh before the debuff expires to reduce incoming damage. He only needs to reach 15 during the encounter, but never kill him before that happens.",
}, { blackrock, pin(284, 47.0, 66.4, 2, "Karsh - central fire pillar, wait for 15 stacks", "Blackrock Caverns - Twilight Forge") }, {1241332, 2135823, 5906300}, "A damage-over-time pull can kill Karsh as his damage vulnerability grows. Replies specifically warn against this.", {860783, 926148, 950019, 974986, 1065443})

add(5284, "Ascendant Descending", "easy", "Defeat Obsidius before his shadows can apply four stacks of their debuff.", {
    "Enter Blackrock Caverns on Heroic and clear the route to Ascendant Lord Obsidius. Let Raz finish his scripted attack so the boss is available, then select Obsidius himself rather than a Shadow of Obsidius.",
    "At a high Retail level, kill Obsidius directly with a strong single-target attack, preferably from range. Do not stand among his shadows while waiting or attacking the wrong target: the failure condition is four stacks of Crepuscular Veil on a party member.",
    "If he survives, kite the shadows around the cleared room, use available slows and immediately retarget the real Obsidius when he swaps positions with a shadow. Finish the boss before the debuff reaches four stacks.",
}, { blackrock, pin(284, 68.9, 50.7, 2, "Obsidius - direct kill; avoid shadow debuff", "Blackrock Caverns - Twilight Forge") }, {2017527, 2089722, 2141947, 2559306})

add(5287, "Rotten to the Core", "medium", "Gather at least 60 followers and kill them yourself while Azil is alive and engaged.", {
    "Enter The Stonecore on Heroic. Reach High Priestess Azil without killing the Devout Followers in the Chamber of Fanatics immediately before her or the three groups in front of her platform. Disable damage shields, passive area damage and attacking pets.",
    "Body-pull the followers from the preceding room and all three groups beside Azil. Gather more than 60 to give yourself a margin, and bring them together away from her platform. Do not kill any until Azil is actually in combat.",
    "Engage Azil with a non-damaging taunt or interrupt from range. As she starts her encounter dialogue and becomes hostile, kill one follower, then immediately kill the gathered followers with your own area damage, within ten seconds. Keep Azil outside that attack so she remains alive.",
    "Do this before Gravity Well consumes the pack: deaths caused by her mechanic have inconsistent historical reports, so use your own damage. Confirm the achievement, then kill Azil. If you lose too many followers, reset without killing her; later followers or a trash respawn can provide another attempt.",
}, { stonecore, pin(324, 57.4, 38.7, 2, "Azil - preserve and gather followers", "The Stonecore"), pin(324, 57.4, 38.7, 3, "Engage Azil, then kill 60 followers", "The Stonecore") }, {1934015, 2026927, 2066024, 2332644, 5669608, 6041656, 6218432}, "Soft Foam Sword cannot be used in dungeons. A non-damaging pull avoids accidentally killing Azil at a high Retail level.")

-- Preferred numbered profit guide 2063513, with both complete replies read.
-- Retain its jump/burst approach, but include the cast-based fallback because
-- both replies report failed instant kills.
add(5288, "No Static at All", "easy", "Stay airborne for every Static Cling cast that occurs.", {
    "Enter The Vortex Pinnacle on Heroic and reach Asaad on the final platform. Track the achievement on YOUR character: another player's failure does not automatically fail yours.",
    "Jump into the pull and burst Asaad down before Static Cling if your damage allows it. This is the short numbered profit guide's approach, with its final profit step omitted.",
    "For a deliberate attempt, engage without killing him and watch his cast bar. Jump as Static Cling starts so you are in the air when it completes; repeat for every cast, and stand inside the triangle during his storm. Kill him after avoiding the cast. This also provides a fallback if a previous instant kill gave no credit.",
}, { vortex, pin(325, 30.0, 38.0, 3, "Asaad - jump for Static Cling", "The Vortex Pinnacle") }, {1161954, 1218739, 1244537, 1313968, 2063513, 3203042}, "Anti-Magic Shell preventing the root is not a substitute for avoiding the spell by jumping.", {914933, 1051151})

add(5289, "Extra Credit Bonus Stage", "medium", "Collect five airborne orbs in one instance, using jumps, slipstreams and Altairus's tornadoes.", {
    "Enter The Vortex Pinnacle on Heroic and enable a convenient Interact with Target keybind. Collect FIVE Golden Orbs in the same instance; a party shares the count. Orb positions vary slightly, so inspect the edges and height rather than assuming every old screenshot matches exactly.",
    "Check the first bridge's lamps, then the edge near the slipstream behind Grand Vizier Ertan. Defeat Ertan and inspect the bridge containing the two Howling Gales: an orb hangs off either side. Face each orb before jumping, and interact as soon as it is in reach. A movement boost, glide or safe return ability helps.",
    "Keep Altairus ALIVE if you still need the two orbs above his arena. Stand beneath an orb and let a moving tornado throw you into reach, then interact while airborne. Remove avoidance gear and sit if tornadoes fail to lift you. Collect both before killing him.",
    "If still short, inspect both sides of the upward spiral at Thunder's Rise and the downward spiral toward Asaad. Use the small wind streams for movement speed and jump toward the orb. Falling returns you to the entrance; the unlocked slipstreams there take you back to later platforms.",
    "Continue until the fifth orb awards the achievement. You can collect the bridge and spiral orbs after clearing the dungeon, but killing Altairus removes his helpful tornado mechanic. Do not leave and reset the instance between collections.",
}, { vortex,
    pin(325,63.6,35.9,2,"Golden Orb - possible first-platform search area","The Vortex Pinnacle"),
    pin(325,56.7,68.9,2,"Golden Orb - inspect both sides of Gale bridge","The Vortex Pinnacle"),
    pin(325,55.6,70.0,2,"Golden Orb - opposite bridge search area","The Vortex Pinnacle"),
    pin(325,31.0,66.6,4,"Golden Orb - search ramp below overhang","The Vortex Pinnacle"),
    pin(325,28.8,69.9,4,"Golden Orb - spiral-ramp search area","The Vortex Pinnacle"),
}, {1261778, 2171764, 2585159, 5589215, 5598167, 6041668}, "Orb pins retain the existing mount guide's possible search areas. Orb height and exact positions vary; use the named platforms and inspect the actual floating objects.", {1391548, 1403219, 1444089, 1512202, 1550172})

add(5290, "Kill It With Fire!", "hard", "Preserve a fire patch, control Barim's health and kill three burning Soul Fragments in the spirit phase.", {
    "Enter Lost City of the Tol'vir on Heroic and reach High Prophet Barim. Clear nearby trash. Dismiss attacking pets, remove damage procs and prepare a damage-reduction method BEFORE combat so you can lower his health without killing him.",
    "Engage without attacking and wait for the red phoenix, Blaze of the Heavens. Let it leave several fire patches on the ground before damaging Barim. Remember their positions: the spirit phase needs that fire.",
    "Carefully lower Barim below 50% to trigger Repentance, then stop all damage. An ungeared punch can still be too strong at a high Retail level; Whole-Body Shrinka' reduces your damage. Midnight comments also describe Oil of Immolation and Goblin Dragon Gun, Mark II, but their actual damage must be judged on your character.",
    "Leave the purple Harbinger of Darkness ALIVE. Wait for Soul Fragments, the shadow copies of your character. Position yourself so each fragment crosses a retained fire patch on its way toward you. Target it and check for the Burning Soul debuff; its displayed name can flicker back to Soul Fragment.",
    "Kill a fragment immediately while Burning Soul is active, using a single-target attack that does not kill the Harbinger. Repeat for THREE qualifying fragments. If one merges or fails to burn, wait for another; do not end the spirit phase early.",
    "The achievement appears during the encounter. Only then kill the Harbinger and finish Barim. If the fire setup failed, reset the living boss and rebuild it rather than completing an unsuccessful kill.",
}, { lostCity, pin(277, 27.0, 65.7, 2, "Barim - create phoenix fire before 50%", "Lost City of the Tol'vir"), pin(277, 27.0, 65.7, 4, "Spirit phase - burn and kill three fragments", "Lost City of the Tol'vir") }, {1241326, 2025535, 2543732, 3229745, 5178128, 6065766, 6370555})

add(5291, "Acrocalypse Now", "medium", "Keep Lockmaw alive while gathering five waves of crocolisks, then kill the crocolisks together.", {
    "Enter Lost City of the Tol'vir on Heroic. At Lockmaw, dismiss attacking pets and disable damage shields or passive area damage. Pull by proximity or a non-damaging taunt, without damaging him.",
    "Wait for FIVE Scent of Blood waves. Each brings four Frenzied Crocolisks, so you need at least twenty alive together. Kite or heal as needed without killing the boss or the growing pack. A passive pet holding Lockmaw away from you can simplify the separation.",
    "When twenty are gathered, wait for Lockmaw to stop for Dust Flail, move the crocolisks away from him and kill the pack with your own area damage within ten seconds. Avoid hitting Lockmaw: if he dies first, the small crocolisks can despawn before counting.",
    "Confirm the achievement before finishing Lockmaw. If a wave was lost, wait for another before attacking. Count actual living crocolisks rather than merely elapsed time.",
}, { lostCity, pin(277, 67.4, 72.4, 2, "Lockmaw - gather five crocolisk waves", "Lost City of the Tol'vir") }, {2024255, 2099181, 2490680, 2548801, 3202150, 5191427, 5233606})

-- Numbered profit guide 1389194 supplies the servant order and charge timing.
-- Replace its original level-85 shield-burning and gear advice with Retail
-- damage control; later reports support killing the three servants individually.
add(5292, "Headed South", "medium", "Collect all three personal Lightning Charge stacks before killing Siamat.", {
    "Enter Lost City of the Tol'vir on Heroic. Defeat the preceding bosses and use the wind route to Siamat's roof. Disable attacking pets and damage procs; start Siamat without damaging him.",
    "Wait until all THREE Servants of Siamat, the melee adds, have spawned. Preserve them all. You may kill the smaller casting MINIONS separately, but keep those attacks away from Siamat and the servants.",
    "Move the three servants away from Siamat so you cannot kill the boss accidentally. Every player needing credit must stand in MELEE RANGE of each dying servant. Kill the servants one at a time, briefly allowing each death effect to apply, and verify YOUR Lightning Charge stacks after each.",
    "Keep the previous charge active while killing the next servant; its short duration refreshes as another stack is gained. After seeing THREE stacks on your own debuff bar, kill Siamat immediately before they expire. Do not use an immunity that clears the charges.",
    "If you missed a stack, reset the boss while he is alive and repeat. Only three servants spawn in an attempt, so waiting for a fourth is not a recovery method. A second player receiving three stacks does not prove that you received yours.",
}, { lostCity, pin(277, 41.5, 55.2, 2, "Siamat - preserve three melee servants", "Lost City of the Tol'vir"), pin(277, 41.5, 55.2, 4, "Kill Siamat with three personal charges", "Lost City of the Tol'vir") }, {1389194, 1449956, 2586384, 3205003, 3216601, 3236251, 6256364})

add(5293, "I Hate That Song", "easy", "A high-level direct kill avoids the hymn; a longer fight needs quick lever use and an interrupt.", {
    "Enter Halls of Origination on Heroic and reach Temple Guardian Anhuur, the first boss. At a high Retail level, burst him down with your own direct damage before Reverberating Hymn can start. Later comments confirm this can award the achievement without using the levers.",
    "If he shields instead, stop attacking the immune boss. Use BOTH beacon levers in the snake pit below to remove his shield, then immediately interrupt Reverberating Hymn. Repeat for the next shield phase; each hymn must be interrupted within the achievement's time limit.",
    "For a deliberate lever attempt, bring partners: one holds the snakes away from the levers, two handle the opposite levers, and an available interrupt stops the hymn as soon as the shield drops. Finish Anhuur after both phases. Do not rely on the old health-threshold exploit described in early solo comments.",
}, { halls, pin(297, 58.4, 62.7, 1, "Temple Guardian Anhuur - burst or beacon levers", "Halls of Origination - Vault of Lights") }, {1218673, 1947769, 2014765, 2489489, 3210024})

add(5294, "Straw That Broke the Camel's Back", "easy", "Ride the dungeon's camel for the entire Ptah encounter.", {
    "Enter Halls of Origination on Heroic and take the outside sandy route to Earthrager Ptah. Clear the trash before pulling him, then click one of the live camels beside the approach. These are dungeon vehicles; owning a camel mount is unnecessary.",
    "Remain on that camel and kill Ptah. At a high Retail level a direct fast kill is enough. If the fight lasts, move out of dark Earth Spike warnings and swirling Quicksand, since either can throw you off the camel.",
    "Do not dismount before the boss dies and credit appears. If thrown off while solo, retreat down the approach stairs to reset the living boss, mount another available camel and retry.",
}, { halls, pin(298, 50.0, 49.2, 2, "Earthrager Ptah - stay on a dungeon camel", "Halls of Origination - Tomb of the Earthrager") }, {1218667, 1883332, 2024864, 2114375})

add(5295, "Sun of a....", "easy", "Defeat Rajh before his first solar-energy recharge finishes.", {
    "Enter Halls of Origination on Heroic. Use the blue elevator plate and its side control to reach The Four Seats. Rajh is upstairs; searching only the ground-floor halls will not find him.",
    "At a high Retail level, select Rajh and kill him directly before he can finish recharging. A quick kill before any recharge is supported by the later comments.",
    "If he survives, interrupt his interruptible casts to slow energy use, then finish him during Blessing of the Sun before his energy refills and the recharge completes. Do not wait for a full recharge. His movement to the center is the warning to finish immediately.",
}, { halls, pin(299, 47.5, 25.2, 2, "Rajh - kill before recharge completes", "Halls of Origination - The Four Seats") }, {1230573, 2021331, 2543730, 5380812})

add(5296, "Faster Than the Speed of Light", "easy", "Run directly between four elemental warders during Brann's timed event.", {
    "Enter Halls of Origination on Heroic, defeat Anhuur and reach Brann at the Vault of Lights door. Prepare movement abilities before speaking to him; the event timer starts with opening the door.",
    "As soon as the door opens, move through the vault and kill the Fire, Water, Earth and Air Warders in the four alcoves. Continue directly to the next alcove after each kill. Do not stop to clear every trogg pack because they respawn; kill only what obstructs you.",
    "Defeat all four within the timer and watch for achievement credit. Anraphet's subsequent fight is not part of the timed requirement. Old advice reserving extra time for the closing dialogue predates a hotfix awarding credit when the fourth warder dies.",
}, { halls,
    pin(297,49.0,22.2,2,"Elemental Warder - northwest alcove","Halls of Origination - Vault of Lights"),
    pin(297,49.4,32.4,2,"Elemental Warder - southwest alcove","Halls of Origination - Vault of Lights"),
    pin(297,63.2,22.2,2,"Elemental Warder - northeast alcove","Halls of Origination - Vault of Lights"),
    pin(297,63.4,32.6,2,"Elemental Warder - southeast alcove","Halls of Origination - Vault of Lights"),
}, {1118927, 1218659, 1375509, 1387284, 2025531})

add(5298, "Don't Need to Break Eggs to Make an Omelet", "easy", "A direct high-level kill prevents any Faceless Corruptor from reaching an egg.", {
    "Enter Grim Batol on Heroic and follow the dungeon through General Umbriss, Forgemaster Throngus and Drahga Shadowburner to Erudax. Finish Drahga's dragon phase so the route onward opens.",
    "Kill Erudax directly with your own damage before his Faceless Corruptors can reach the eggs. Later Retail comments confirm that a fast kill meets the achievement; you do not need to wait for a corruptor wave.",
    "If the fight lasts, stand in Shadow Gale's safe center, then immediately intercept BOTH corruptors entering from the doorway. Slow and kill them before either begins Twilight Corruption on an egg. Return to Erudax and repeat as necessary until he dies with no egg corrupted.",
}, { grimBatol, pin(293, 85.6, 74.7, 2, "Erudax - kill before egg corruption", "Grim Batol") }, {1218750, 1694926, 2063560, 6078675})

local deadmines = pin(52, 42.6, 71.7, 1, "Moonbrook mine - descend to Deadmines", "Westfall")
local shadowfang = pin(21, 44.9, 67.8, 1, "Shadowfang Keep - Heroic entrance", "Silverpine Forest")
local zulGurub = pin(50, 72.1, 32.9, 1, "Zul'Gurub - Heroic dungeon entrance", "Northern Stranglethorn")
local legacyAccess = pin(23, 53.8, 8.7, 1, "Zidormi - select legacy Quel'Thalas", "Eastern Plaguelands")
local zulAman = pin(95, 81.5, 64.4, 1, "Zul'Aman - legacy Heroic entrance", "Ghostlands")
local caverns = pin(71, 64.4, 50.0, 1, "Caverns of Time - descend to the dungeon portals", "Tanaris")

add(5366, "Ready for Raiding", "easy", "Kill Glubtok before Fire Wall or move around the rotating wall without touching it.", {
    "Set Heroic and descend through Moonbrook's mine into Deadmines. Reach Glubtok, the first boss, without confusing the Normal version with the required Heroic encounter.",
    "At a high Retail level, kill Glubtok directly before he can create Fire Wall. If he enters his floating phase, keep moving around the center ahead of the rotating wall. Do not cross through either arm of the wall while repositioning or casting.",
    "Finish Glubtok without being hit by Fire Wall and check your achievement. You do not need to deliberately trigger the wall if your burst kills him before it appears.",
}, { deadmines, pin(291, 36.5, 61.2, 2, "Glubtok - avoid rotating Fire Wall", "Deadmines") }, {1243122, 1999933, 2027161})

add(5367, "Rat Pack", "easy", "Preserve the Lumbering Oaf and kill the small rats released by its charges.", {
    "Enter Deadmines on Heroic and reach Helix Gearbreaker, riding the Lumbering Oaf. Do NOT kill the Oaf: he is part of the encounter and supplies the rats. Disable automatic damage and pets, then start by walking into him.",
    "Wait for the Oaf to pick you up and charge into the lumber pile. Mine Rats, small critters rather than kobold adds, scatter around the impact. Target them with /target Mine Rat and kill them with a single-target attack, avoiding Helix and the Oaf.",
    "Repeat the charge-and-rat cycle until YOUR counter reaches twenty and the achievement appears. With multiple players, check each player's counter. Finish the boss afterward. Rat kills can accumulate across attempts, so accidentally ending one attempt does not erase all previous progress.",
}, { deadmines, pin(291, 50.1, 86.8, 2, "Helix / Lumbering Oaf - Mine Rat charge spawns", "Deadmines") }, {1168828, 2024165, 2228306, 2854835, 5233626, 6107118, 6134808})

add(5368, "Prototype Prodigy", "easy", "Leave the friendly Prototype Reaper out of combat and kill Foe Reaper directly.", {
    "Enter Deadmines on Heroic and reach the foundry. Leave the friendly Prototype Reaper untouched upstairs. Clear the hostile reapers and other activation trash using your character, without driving the friendly machine through their damage.",
    "Once Foe Reaper 5000 activates, kill him promptly while the friendly prototype remains safely upstairs at full health. At a high Retail level you do not need to pilot the prototype at all.",
    "If using a lower-level group, keep the boss on the ramp away from the friendly vehicle and assign its pilot to stun and kill Molten Slags below. The prototype must never drop below 90%, including during the preceding trash; healing it afterward does not undo a failure.",
}, { deadmines, pin(292, 12.4, 75.8, 2, "Foe Reaper - leave friendly prototype safe upstairs", "Deadmines - Ironclad Cove") }, {1314771, 1755087, 2063525})

add(5369, "It's Frost Damage", "medium", "Lower Ripsnarl below 75% without killing him, then allow three vapors to finish Coalesce.", {
    "Enter Deadmines on Heroic and reach Admiral Ripsnarl on the ship. Remove damage procs and attacking pets. If needed, use Whole-Body Shrinka' BEFORE combat: an ungeared high-level hit can still kill the boss.",
    "Carefully lower Ripsnarl below 75% health, then stop every attack. Simply standing there at full boss health will not start the required fog phase.",
    "Leave the Vapors alive while they grow into Freezing Vapors and cast Coalesce. Let THREE casts complete. Use the ship's cabin and line of sight to avoid the explosions and knockback; a recent reply warns that being knocked out of position can reset the encounter.",
    "Wait for the achievement during the encounter, then finish Ripsnarl. Do not kill fresh vapors just because they reach you, and do not finish the boss before all three casts have happened.",
}, { deadmines, pin(292, 60.4, 38.7, 2, "Ripsnarl - below 75%, then stop damage", "Deadmines - Ironclad Cove"), pin(292, 60.4, 38.7, 3, "Cabin - line of sight three Coalesce casts", "Deadmines - Ironclad Cove") }, {1335782, 2068814, 3201671, 3259422, 5842880, 6158675})

add(5370, "I'm on a Diet", "easy", "Initialize Cookie's food mechanic, take one Nauseated stack and kill him before a second.", {
    "Enter Deadmines on Heroic and defeat Ripsnarl. Let Captain Cookie emerge and climb into his cooking pot; wait for him to start throwing food rather than killing him during his introduction.",
    "Eat ONE piece of rotten, green-glowing food to receive exactly one Nauseated stack. Then kill Cookie immediately. Do not eat another rotten food or stand in its effects until you gain a second stack.",
    "Confirm credit before moving to Vanessa's letter. The original instruction to eat only good food can work in a normal-length fight, but the later comments recommend one deliberate bad-food stack because some instant kills before initialization miss credit.",
}, { deadmines, pin(292, 60.4, 45.5, 2, "Cookie - one Nauseated stack, then kill", "Deadmines - Ironclad Cove") }, {1168535, 2018136, 2550560, 6032768})

add(5371, "Vigorous VanCleef Vindicator", "medium", "Complete the nightmare route and engage Vanessa within five minutes; scripted hazards still matter at high level.", {
    "Enter Deadmines on Heroic, defeat the bosses through Cookie and click Vanessa's letter on the ship's deck. Prepare movement abilities before starting. Her Nightmare Elixir starts the FIVE-MINUTE timer.",
    "Use the steam valves to escape the opening trap. Follow the nightmare route toward the ship, killing the required nightmare bosses as each section opens. Move around fire patches instead of repeatedly running through them.",
    "At the Foe Reaper nightmare, wait until the rotating lightning hazards are visible, then cross carefully through their gaps. Killing the enemies quickly leaves plenty of time; repeated hazard hits waste it.",
    "In the Ripsnarl nightmare, kill the attacking worgen and SAVE each named friendly NPC before advancing. Rushing past Emme or the other rescue events can trigger Nightmare's End and kill you regardless of your level.",
    "Reach Vanessa on the ship and ENGAGE her before the five minutes expire. The timed achievement is for starting her fight, not completing her kill. Finish the encounter afterward for the Heroic dungeon achievement. Do not follow old intentional-wipe or resurrection shortcuts.",
}, { deadmines, pin(292, 60.4, 45.5, 1, "Cookie's deck - Vanessa's letter", "Deadmines - Ironclad Cove"), pin(292, 65.4, 40.2, 5, "Vanessa - engage within five minutes", "Deadmines - Ironclad Cove") }, {1262438, 1315968, 2186136, 2191267, 2337145})

add(5503, "Pardon Denied", "easy", "Prevent every healing tick of Stay of Execution, or kill Ashbury before it begins.", {
    "Enter Shadowfang Keep on Heroic and reach Baron Ashbury in the first courtyard. A high-level character can kill him directly before he uses his healing mechanic; use your own attack to establish kill credit.",
    "If the encounter lasts, survive Asphyxiate and interrupt Stay of Execution IMMEDIATELY when the channel starts, before it heals him. Heal yourself or your tank afterward instead of using his healing ticks to recover.",
    "Finish Ashbury without letting Stay of Execution heal him. Do not deliberately wait for the heal if your direct kill can avoid it entirely.",
}, { shadowfang, pin(310, 66.4, 73.2, 1, "Baron Ashbury - interrupt Stay of Execution", "Shadowfang Keep - Courtyard") }, {1291815, 1904040, 2062447, 2349002})

add(5504, "To the Ground!", "easy", "Kill Springvale before his adds can empower him, or interrupt and kill the adds.", {
    "Enter Shadowfang Keep on Heroic and reach Commander Springvale. At a high Retail level, kill him immediately with your own single-target damage before the guards can cast their empowerment.",
    "For a longer fight, interrupt the Unholy Empowerment casts from both the Wailing Guardsman and Tormented Officer, kill them and handle each reinforcement wave the same way. Crowd control can hold one while the other dies.",
    "The failure concerns empowerment supplied by the ADDS. Springvale gaining his own Unholy Power through Malefic Strike is a separate mechanic. Do not abandon a valid attempt just because his personal stack counter increases.",
}, { shadowfang, pin(310, 28.0, 59.7, 1, "Commander Springvale - stop add empowerment", "Shadowfang Keep - Courtyard") }, {1397333, 2062458, 2326839, 3141291})

add(5505, "Bullet Time", "easy", "Let Godfrey's Pistol Barrage kill at least twelve ghouls before finishing him.", {
    "Enter Shadowfang Keep on Heroic and reach Lord Godfrey at the top of the keep. Disable damage shields, pets and automatic attacks. Start with a non-damaging pull and lead him down the room's stairs into the open floor.",
    "Wait for Summon Bloodthirsty Ghouls, then Pistol Barrage. Step a little away in front of the boss so the ghouls follow you into the wider part of his cone. Let HIS bullets kill the ghouls; do not kill them with your own area attack.",
    "Each full wave contains six, so normally repeat for two waves. If any survive outside the cone, wait for another wave. Check that at least twelve qualifying ghoul deaths have occurred, then kill Godfrey. Keep yourself alive while positioning in the barrage.",
}, { shadowfang, pin(315, 68.4, 33.5, 2, "Godfrey - funnel ghouls into Pistol Barrage", "Shadowfang Keep - Lord Godfrey's Chamber") }, {1218722, 1235649, 1238422, 2458149, 2564749, 2626709, 3300416})

add(5743, "It's Not Easy Being Green", "easy", "Engage Venoxis before bursting him and avoid all poison hazards if he survives.", {
    "Enter Heroic Zul'Gurub and reach High Priest Venoxis. Disable attacking pets and start with a non-damaging taunt or other harmless pull.",
    "Let Venoxis move off his stairs and the encounter initialize, then kill him directly. Later Retail comments confirm that waiting for the snake transformation is unnecessary for a high-level kill.",
    "If he survives, stay out of Venomous Effusion, poison clouds and the moving poison trails. Move apart to break Toxic Link without crossing hazards, then finish the boss. If effects are invisible, check particle-density settings before another attempt.",
}, { zulGurub, pin(337, 50.9, 53.7, 2, "Venoxis - initialize encounter, then burst", "Zul'Gurub") }, {2553178, 3154483, 5587890, 6059534, 6236089})

add(5744, "Gurubashi Headhunter", "easy", "Visit and defeat eight specific optional enemies throughout the dungeon.", {
    "Enter Zul'Gurub on Heroic and track the eight named criteria. These are optional enemies around the dungeon rather than the five main bosses, and all can be visited in one run.",
    "Check the western lake and nearby paths: kill Florawing Hive Queen at 32.9,39.4; a Lost Offspring of Gahz'ranka in the lake around 37.6,40.5; Gub at 43.2,44.6; and Tor-Tun at 45.8,55.7. The lake pin marks a search area for a moving creature.",
    "Continue through the central and eastern paths: kill Mor'Lek the Dismantler at 56.2,55.5, Kaulema the Mover at 54.1,62.7 and Mortaxx at 62.4,34.1. Then visit Gurubashi Master Chef at 57.9,26.9. The chef is neutral, so use his full name with /target if hostile-only nameplates miss him.",
    "Check all eight criteria before leaving and revisit any missing name. Coordinates belong to the Heroic dungeon map, not outdoor Northern Stranglethorn.",
}, { zulGurub, pin(337,32.9,39.4,2,"Florawing Hive Queen","Zul'Gurub"), pin(337,37.6,40.5,2,"Lost Offspring - lake search area","Zul'Gurub"), pin(337,43.2,44.6,2,"Gub","Zul'Gurub"), pin(337,45.8,55.7,2,"Tor-Tun","Zul'Gurub"), pin(337,56.2,55.5,3,"Mor'Lek","Zul'Gurub"), pin(337,54.1,62.7,3,"Kaulema","Zul'Gurub"), pin(337,62.4,34.1,3,"Mortaxx","Zul'Gurub"), pin(337,57.9,26.9,3,"Gurubashi Master Chef - neutral","Zul'Gurub") }, {1354110, 1962365, 3270467})

add(5750, "Tunnel Vision", "easy", "Kill Halazzi without destroying his totems.", {
    "For Midnight access, select legacy Quel'Thalas with Zidormi at Thalassian Pass, then enter the Heroic Zul'Aman dungeon in Ghostlands. The new outdoor Zul'Aman is different content. Reach Halazzi in the northeastern temple.",
    "Kill Halazzi directly with single-target damage. Leave his totems alive throughout the fight. Disable passive area attacks, cleaving pets and the archaeology bear-cub buff, which older comments report can destroy a totem automatically.",
    "If he survives long enough to place a healing totem, move him away from its green healing area and keep attacking him. The achievement does not require you to kill a totem or wait for a specific number of spawns.",
}, { legacyAccess, zulAman, pin(333,58.4,23.8,2,"Halazzi - preserve every totem","Zul'Aman") }, {1401217, 1403300, 1885901, 2107378, 5581734})

-- Numbered profit guide 1423924: keep gathering spirits, then kill twenty
-- together. Its obsolete level-85 party composition is unnecessary in Retail.
add(5759, "Spirit Twister", "medium", "Gather twenty Twisted Spirits in Jin'do's spirit phase and kill them within fifteen seconds.", {
    "Enter Zul'Gurub on Heroic, defeat Venoxis and reach Jin'do's upper platform. Clear the approach and disable passive damage so newly spawned spirits are not killed one by one.",
    "Bring Jin'do into his spirit phase, around 70% health, then stop damage to the encounter objectives. Leave the spirit chains intact while Twisted Spirits continue spawning.",
    "Run broad circles around the platform or stand safely at a corner at high level, gathering at least TWENTY spirits alive together. Avoid Shadow Spike ground warnings. Do not use a damaging ground effect while collecting them.",
    "Once enough are grouped, kill the whole pack with your own area damage inside fifteen seconds. The achievement can appear during the fight; Jin'do does not have to die for this particular objective. If continuing the clear, use a Gurubashi Spirit's Body Slam to break the chain shields before destroying the chains.",
}, { zulGurub, pin(337,48.503,39.521,2,"Jin'do - preserve spirit-phase chains","Zul'Gurub"), pin(337,48.503,39.521,3,"Gather twenty Twisted Spirits on upper platform","Zul'Gurub") }, {1354793, 1423924, 1941443, 2281255, 2538084, 3209134, 5945704})

add(5760, "Ring Out!", "easy", "Stay within Daakara's marked central rectangle from the pull until his death.", {
    "Select legacy Quel'Thalas through Zidormi and enter Heroic Zul'Aman in Ghostlands. Defeat the preceding bosses and reach Daakara. Identify the rectangular stone inlay on his floor before starting.",
    "Move EVERY player inside the rectangle first, then pull Daakara into it from range. At a high Retail level, kill him directly without leaving the rectangle; do not body-pull from beyond its boundary.",
    "If the fight lasts through transformations, dodge fire columns and tornadoes while remaining inside the marked floor. Keep the boss in the middle so movement leaves room on every side. Finish him without anyone stepping outside during combat.",
}, { legacyAccess, zulAman, pin(333,90.4,52.9,2,"Daakara - remain inside floor rectangle","Zul'Aman") }, {1400767, 1435445, 2362267, 5984487, 6234342})

add(5761, "Hex Mix", "medium", "Collect Amani Hex Sticks and repeatedly unhex frogs until every named victim has appeared.", {
    "Select the legacy Ghostlands phase with Zidormi at Thalassian Pass and enter Zul'Aman on Heroic. Bring free bag space. You need Amani Hex Sticks; they are tradeable, so check the Auction House if available stock is affordable.",
    "Otherwise kill and loot the dungeon's trash, including the southern village, while avoiding boss kills if you want to reset and farm more immediately. Exit, reset from outside and repeat as needed, respecting the instance-entry limit. A boss kill can save your Heroic run until the daily reset.",
    "Find Forest Frogs around the central water, roughly 44,53. Target a frog and use an Amani Hex Stick. Wait for its transformation and dialogue, and check your named achievement criteria. Other party members' unhexes can also count while you are present.",
    "Continue until all twelve victims have appeared. Outcomes can repeat: twelve sticks do NOT guarantee twelve unique people, and specific frog coordinates do not guarantee a specific victim. Mojo and the treasure left by some victims are extra rewards rather than replacements for a missing name.",
}, { legacyAccess, zulAman, pin(333,44,53,3,"Forest Frogs - unhex around central water","Zul'Aman") }, {1401267, 1981870, 1991209, 3229253, 3245945, 3302264, 5760474, 6256078})

add(5762, "Ohganot So Fast!", "easy", "Kill Mandokir while leaving his raptor Ohgan alive.", {
    "Enter Zul'Gurub on Heroic and go to Bloodlord Mandokir in the southeastern arena. Disable area damage and cleaving pets that might kill Ohgan.",
    "At a high Retail level, kill Mandokir directly with single-target damage before Ohgan needs handling. Do not attack the raptor: the achievement requires the boss to die without Ohgan dying.",
    "In a longer fight, slow or stun Ohgan while focusing Mandokir, avoid Devastating Slam and let the chained spirits handle encounter resurrections. Keeping the raptor controlled preserves the available spirits for longer, but killing it fails this objective.",
}, { zulGurub, pin(337,60.4,79.9,2,"Mandokir - leave Ohgan alive","Zul'Gurub") }, {1362653, 1401183, 1402402, 2019596, 5906452})

add(5765, "Here, Kitty Kitty...", "hard", "Feed four different cats in one encounter without killing Kilnara; a group simplifies rat supply.", {
    "Enter Heroic Zul'Gurub and reach the Temple of Bethekk. Clear the approach and pick up a Temple Rat from the floor ABOVE Kilnara before entering her chamber. Each player can carry only one; bringing four rat-carrying players avoids the solo collection problem.",
    "Start Kilnara without damaging her and preserve the sleeping Pride of Bethekk in her room. Wake ONE cat with a non-damaging taunt or harmless control, place your rat beside it and wait until the cat eats it and gains its enlarged frenzy appearance. A rat placed beside a sleeping, unengaged cat may be wasted.",
    "With a group, have the next players each feed a DIFFERENT cat in the same pull. Kill a fed cat with single-target damage if needed, but keep Kilnara and the other cats alive. Feed four cats before finishing her; partial feeds from different attempts do not accumulate.",
    "For the reported solo route, enable the Interact Key option AND bind Interact with Target. Use /target Temple Rat at the entrance wall, then move close to its path and interact when it is within reach. Later Retail comments confirm collecting the respawning rat this way, though positioning is sensitive. Wait about a minute for another rat and repeat the wake-and-feed process on a fresh cat.",
    "If the rat cannot be reached in your current attempt, use the four-player supply route rather than killing Kilnara with incomplete feeds. After four cats are credited, defeat her and check the achievement. Do not treat the fixed 9.2 rat-interaction bug as proof the achievement is permanently unavailable.",
}, { zulGurub, pin(337,48,20,2,"Kilnara - preserve boss and feed four cats","Zul'Gurub"), pin(337,48,20,4,"Temple entrance wall - solo rat interaction","Zul'Gurub") }, {1401026, 1401171, 1402395, 2457063, 5380485, 5464695, 6082160, 6096006, 6236145})

add(5858, "Bear-ly Made It", "easy", "The high-level rescue route is generous once you use the correct legacy dungeon and boss order.", {
    "In Midnight, visit Zidormi at Thalassian Pass, Eastern Plaguelands 53.8,8.7, and select legacy Quel'Thalas. Travel through the original Ghostlands to Zul'Aman at 81.5,64.4. Set Heroic before entering; the new outdoor Zul'Aman is not this dungeon.",
    "Speak to Vol'jin at the entrance and complete the gong interaction without moving to cancel it. When the gate opens and the rescue timer starts, head directly to Akil'zon in the northwest. Defeat him, then continue to Nalorakk in the southwest, clearing the approach packs that make him advance onto his platform. These early bosses add time.",
    "Defeat Jan'alai in the southeast, then Halazzi in the northeastern temple, all before the sacrifice timer expires. Mount between pulls when out of combat and avoid unnecessary side bosses or long loot stops.",
    "Free the four captives and collect their rewards. After the fourth timely rescue, follow that captive's reward sequence; with this route Kasha breaks vases and leaves the bag containing the Amani Battle Bear. Loot the container rather than assuming the mount is automatically learned. The achievement needs the four rescues, not Malacrass or Daakara.",
}, { legacyAccess, zulAman, pin(333,35.5,23,2,"Akil'zon - first rescue","Zul'Aman"), pin(333,40.5,77.3,2,"Nalorakk - second rescue","Zul'Aman"), pin(333,55.4,70.9,3,"Jan'alai - third rescue","Zul'Aman"), pin(333,58.4,23.8,3,"Halazzi - fourth rescue","Zul'Aman"), pin(333,60,17,4,"Kasha's reward container","Zul'Aman") }, {1427408, 1482289, 1955147, 2044665, 6234340}, "Retain the existing mount guide's Midnight phase access and reward-container details. The original removed Amani War Bear is a different mount.")

add(5995, "Moon Guard", "medium", "Obtain the Tyrande shrine and complete its gauntlet while protecting any healing-specialization character.", {
    "Enter End Time through the Caverns of Time in Tanaris. Use the dungeon's transit device to check the two available echoes. You need EMERALD Dragonshrine, Echo of Tyrande. If absent, leave before killing a boss and reset an unsaved instance to reroll, respecting the entry limit.",
    "For the simplest high-level attempt, use a damage or tank specialization. Comments identify healing SPECIALIZATION, rather than the Dungeon Finder role icon, as the healer check. If a healer is present, keep them safely out of the shadow creatures' attacks throughout the gauntlet.",
    "Move from one illuminated moonwell area to the next, bringing shadow creatures into the light so they can be killed. Clear the full gauntlet without letting a healing-specialization character take damage, then engage the now-available Tyrande. Credit normally appears at engagement; verify it before finishing the boss.",
}, { caverns, pin(405,51.5,43.3,3,"Echo of Tyrande - complete Emerald gauntlet","End Time - Emerald Dragonshrine") }, {1584440, 1584653, 1866238, 2098615, 5882009, 6120395})

add(6070, "That's Not Canon!", "medium", "Damage Mannoroth while preserving Varo'then until the sacrifice has happened.", {
    "Enter Well of Eternity through the Caverns of Time and follow the Illidan and Tyrande storyline through Peroth'arn and Queen Azshara. At the final encounter, leave Captain Varo'then ALIVE and target Mannoroth instead.",
    "Use controlled damage to bring Mannoroth to about 90%, then wait for him to sacrifice Varo'then and heal himself. His 'Your blood is MINE, elf!' line confirms the intended event. Do not kill Varo'then yourself while setting this up; disable pet cleaves and damage effects that could hit him.",
    "After the sacrifice, interact with Varo'then's dropped blade and use it against Mannoroth as directed by the encounter. Kill the demons threatening Tyrande, continue damaging Mannoroth and let the final Illidan sequence finish. Check achievement credit after the encounter.",
    "Later high-level reports also describe a direct Mannoroth kill, but the controlled sacrifice route makes the criterion explicit. The dungeon quest can still need your own Varo'then kill, so plan a separate run for that quest if he was sacrificed instead.",
}, { caverns, pin(398,87.3,48.2,2,"Mannoroth - preserve Varo'then until sacrifice","Well of Eternity") }, {1585035, 1586057, 2024415, 2292006, 2573219, 5244178, 5313956, 5586513})

add(6127, "Lazy Eye", "easy", "A high-level burst avoids the eyes; otherwise circle the arena edge without being detected.", {
    "Enter Well of Eternity through the Caverns of Time and follow Illidan's stealth section. Close the three required portals after defeating their defenders and allow Illidan's combat and dialogue to advance before moving on.",
    "At Peroth'arn, a high-level direct burst can kill him before the eye-search phase and award the achievement. If he disappears instead, stop trying to damage the hidden boss and concentrate on avoiding the eyes.",
    "Move continuously around the outer edge near the fire boundary, giving each Eye of Peroth'arn space. With a group, agree on a direction and follow together so players do not lead eyes into each other. Survive the entire search without ANY party member being detected, then kill Peroth'arn when he returns.",
}, { caverns, pin(398,23.7,48.2,2,"Peroth'arn - avoid detection by every eye","Well of Eternity") }, {1583543, 1935212, 2017687, 2027058, 2072139, 2349209, 2624006})

add(6130, "Severed Ties", "easy", "Wait for one Calling of the Highborne phase and kill two ghouls in that same phase.", {
    "Enter End Time in the Caverns of Time and check its transit device. You need RUBY Dragonshrine, Echo of Sylvanas. If absent, leave before any boss kill and reset an unsaved instance to try again, respecting the hourly entry limit.",
    "Engage Sylvanas with proximity or a non-damaging pull and stop attacking. Wait for Calling of the Highborne to create the ring of Risen Ghouls. A high-level instant kill before the ring prevents this achievement.",
    "Kill at least TWO of the ring's ghouls during that SINGLE Calling phase, then kill Sylvanas when she returns. One ghoul in each of two phases is insufficient. Keep pets passive until the needed ghouls have appeared.",
}, { caverns, pin(403,55.9,39.2,2,"Echo of Sylvanas - wait for ghoul ring","End Time - Ruby Dragonshrine") }, {1585662, 1603414, 2077802, 2098614, 5617966, 6023098, 6235994})

add(6132, "Eclipse", "medium", "Control Benedictus's health, then kill ten sparks around the outer ring before finishing him.", {
    "Enter Hour of Twilight in the Caverns of Time and escort Thrall through Arcurion and Asira Dawnslayer to Archbishop Benedictus. Disable attacking pets, damage procs and automatic retaliation before the final pull.",
    "Carefully lower Benedictus until Twilight Epiphany changes the room to purple and Twilight Sparks appear, around 60% in recent Retail comments. Stop attacking him as soon as the phase starts. Use Whole-Body Shrinka' before combat if your normal hit would kill him; old fixed hit counts do not transfer between levels.",
    "Kill TEN Twilight Sparks around the outside of the circular arena, leaving Benedictus alive. Use ranged attacks where possible and watch your health while crossing the damaging outer area. Remove a damage-reduction toy buff after the phase begins if it makes killing sparks unnecessarily slow.",
    "After ten sparks are credited, kill Benedictus. If controlled player damage is impossible, comments report letting Thrall slowly bring him to the transition instead, which can take roughly eighteen minutes. Do not attempt to use Soft Foam Sword inside this dungeon.",
}, { caverns, pin(400,47.3,51.3,2,"Benedictus - trigger Twilight phase, preserve boss","Hour of Twilight - Wyrmrest Temple") }, {1584948, 2361734, 2533389, 3202480, 3241811, 5387491, 5550811, 5760977, 6028482, 6463045})

-- Normal and Heroic clear pages were read individually. Most have no comments;
-- retain the useful entrance/script details from the existing mount walkthrough
-- and the encounter guides above, instead of inventing a profit comment.
local routes = {
    { ids = {4833,5060}, name = "Blackrock Caverns", entrance = blackrock,
        steps = {
            "Inside Blackrock Mountain, take the eastern hallway toward Blackrock Spire, then its right-hand branch to Blackrock Caverns. The entrance is inside the mountain, not on the outdoor summit.",
            "Defeat Rom'ogg Bonecrusher, follow Raz's opened route to Corla, then continue through Karsh Steelbender's forge. At Karsh, lead him through the central fire to remove his heavy armor if ordinary damage is ineffective.",
            "Defeat Beauty and continue to Ascendant Lord Obsidius. Let Raz complete his scripted attack, select the real Obsidius and defeat him for the final-boss credit. Wait for the encounter to register before leaving.",
        }, pins = {pin(284,68.9,50.7,4,"Obsidius - final boss","Blackrock Caverns - Twilight Forge")}, comments = {1358248},
    },
    { ids = {4839,5061}, name = "Throne of the Tides",
        entrance = pin(204,70.5,29.9,1,"Abyssal Breach - swim down into the whirlpool","Abyssal Depths"),
        steps = {
            "Travel to the Abyssal Breach in northern Abyssal Depths, Vashj'ir. Swim down through the giant whirlpool to the dungeon portal. This underwater entrance is separate from Throne of the Four Winds in Uldum.",
            "Defeat Lady Naz'jar and Commander Ulthok, then continue along the dungeon's available branches and use its transport devices as they unlock. Follow the current Retail encounters rather than waiting for the removed Old Faithful or Prince of Tides mechanics.",
            "Reach Neptulon and start the Ozumat encounter through the offered dialogue. Clear the required enemies to advance the scripted phases, then attack the active Ozumat objective when the encounter allows it. Stay until Ozumat's defeat awards credit; clearing only the earlier bosses does not complete the achievement.",
        }, pins = {}, comments = {1078502},
    },
    { ids = {4840,5062}, name = "Grim Batol", entrance = grimBatol,
        steps = {
            "Enter the fortress portal in western Twilight Highlands at about 19.2,54.1. Use the captive dragons' bombing section if offered to weaken the trash along your route, then continue on foot.",
            "Defeat General Umbriss and Forgemaster Throngus. Continue to Drahga Shadowburner; complete his encounter through Valiona's dragon phase before moving into the final hall.",
            "Defeat Erudax, the final boss. If he survives through Shadow Gale, stand in its safe center and kill the incoming Faceless Corruptors before they reach the eggs. Check final-boss credit before leaving.",
        }, pins = {pin(293,85.6,74.7,4,"Erudax - final boss","Grim Batol")}, comments = {1253039},
    },
    { ids = {4841,5065}, name = "Halls of Origination", entrance = halls,
        steps = {
            "Enter the pyramid in eastern Uldum. Defeat Temple Guardian Anhuur; if his shield phase occurs, use both snake-pit beacon levers and interrupt the exposed hymn before resuming damage.",
            "Follow Brann into the Vault of Lights, kill the four elemental warders to open Anraphet's door and defeat Anraphet. Visit the sandy side route for Earthrager Ptah if you also need his separate criteria or quests.",
            "Use the blue elevator plate and side control to reach The Four Seats. Defeat Rajh for the dungeon completion achievement. Ammunae, Isiset and Setesh are optional for this final-boss achievement, although separate quests and collections can still need them.",
        }, pins = {pin(297,58.4,62.7,2,"Temple Guardian Anhuur","Halls of Origination - Vault of Lights"),pin(299,47.5,25.2,4,"Rajh - final boss upstairs","Halls of Origination - The Four Seats")}, comments = {1712342},
    },
    { ids = {4846,5063}, name = "The Stonecore", entrance = stonecore,
        steps = {
            "Fly to the upper OUTSIDE ledge of the Temple of Earth in Deepholm and use The Stonecore portal at about 47.6,52.0. The ground-level quest hub is below the entrance.",
            "Follow the tunnel through Corborus, then the open cavern to Slabhide. Wait for Slabhide to land and complete his encounter before continuing. Work through Ozruk's corridor and defeat Ozruk.",
            "Reach High Priestess Azil and defeat her for the final-boss credit. If you also need Rotten to the Core, preserve and gather the followers BEFORE this pull and complete that setup first; killing her ends the opportunity for this saved run.",
        }, pins = {pin(324,57.4,38.7,4,"High Priestess Azil - final boss","The Stonecore")},
    },
    { ids = {4847,5064}, name = "The Vortex Pinnacle", entrance = vortex,
        steps = {
            "Fly to the airborne portal off southeastern Uldum, around 76.7,84.4. This is The Vortex Pinnacle dungeon, not the Throne of the Four Winds raid off southwestern Uldum.",
            "Defeat Grand Vizier Ertan and use the slipstream to the next section. Defeat Altairus and take the next available wind route toward Thunder's Rise. If collecting Golden Orbs, leave Altairus alive until you have used any tornado-assisted orbs you need.",
            "Follow the spiral ramps to Asaad and defeat him. During a longer fight, jump for Static Cling and stand inside the triangle during the storm. Check the dungeon's final-boss achievement before leaving.",
        }, pins = {pin(325,30,38,4,"Asaad - final boss","The Vortex Pinnacle")},
    },
    { ids = {4848,5066}, name = "Lost City of the Tol'vir", entrance = lostCity,
        steps = {
            "Enter the ground-level portal in southern Uldum, around 60.5,64.1. Defeat General Husam and proceed through the open courtyard routes.",
            "Defeat Lockmaw and Augh, then High Prophet Barim. If working on Acrocalypse Now or Kill It With Fire!, do their add and fire setup before killing those bosses. They cannot be recreated after a saved Heroic kill.",
            "Use the unlocked wind route to Siamat's roof and defeat him for the completion achievement. If he raises his shield, kill the required servants to advance the encounter. For Headed South, preserve all three melee servants and collect their charges first.",
        }, pins = {pin(277,41.5,55.2,4,"Siamat - final boss on roof","Lost City of the Tol'vir")},
    },
    { ids = {5083}, name = "Deadmines", heroicOnly = true, entrance = deadmines,
        steps = {
            "Follow Moonbrook's mine tunnels down to the Deadmines portal. Defeat Glubtok, Helix Gearbreaker with his Lumbering Oaf, and Foe Reaper 5000, clearing the enemies that activate each encounter.",
            "Open the way into Ironclad Cove and climb the ship. Defeat Admiral Ripsnarl and Captain Cookie, then click Vanessa's letter on the deck. Cookie is NOT the final boss required by the current achievement.",
            "Complete Vanessa's nightmare: escape the opening trap with its steam valves, kill the nightmare enemies, cross the fire and rotating-lightning sections, and protect the friendly NPCs from worgen before returning to the ship.",
            "Fight Vanessa through her scripted stages. Use the hanging ropes when instructed to avoid the deck explosions, return to the deck and finish the encounter. Stay for final credit rather than leaving after Cookie or the nightmare's timed achievement.",
        }, pins = {pin(292,60.4,45.5,3,"Cookie - letter unlocks Vanessa","Deadmines - Ironclad Cove"),pin(292,65.4,40.2,5,"Vanessa - Heroic final boss","Deadmines - Ironclad Cove")}, comments = {1113597},
    },
    { ids = {5093}, name = "Shadowfang Keep", heroicOnly = true, entrance = shadowfang,
        steps = {
            "Enter the castle in southern Silverpine Forest. Defeat Baron Ashbury in the courtyard and allow the nearby NPC dialogue and doors to advance before continuing into the keep.",
            "Follow the route through Baron Silverlaine, Commander Springvale and Lord Walden. Continue up the stairways, through the observatory and along the wall walk into Lord Godfrey's chamber.",
            "Defeat Lord Godfrey for the completion achievement. If you also need Bullet Time, let his Pistol Barrage kill twelve ghouls BEFORE finishing him; a fast clear without the setup will not provide that separate achievement.",
        }, pins = {pin(315,68.4,33.5,4,"Lord Godfrey - final boss","Shadowfang Keep - Lord Godfrey's Chamber")},
    },
    { ids = {5768}, name = "Zul'Gurub", heroicOnly = true, entrance = zulGurub,
        steps = {
            "Enter the current Heroic five-player dungeon in Northern Stranglethorn. Defeat High Priest Venoxis and the other guardians you still need: Bloodlord Mandokir, High Priestess Kilnara and Zanzil. The optional Cache of Madness bosses are separate.",
            "Before fighting Jin'do, kill a Gurubashi Spirit Warrior on the lower terrace so its spirit will be available later. Start Jin'do on the upper platform and bring him into his spirit phase.",
            "In the spirit realm, bring the large Gurubashi Spirit onto the upper platform. Stand on a shielded Hakkar's Chain when the spirit targets you for Body Slam; let the slam break the chain's immunity shield, then kill the exposed chain. Repeat for all THREE chains while clearing small spirits and avoiding Shadow Spike.",
            "Let Hakkar's final sequence finish and check Jin'do's encounter credit. Attacking immune chains without breaking their shields does not complete the dungeon, regardless of your level.",
        }, pins = {pin(337,50.9,53.7,2,"Venoxis - guardian","Zul'Gurub"),pin(337,60.4,79.9,2,"Mandokir - guardian","Zul'Gurub"),pin(337,48,20,2,"Kilnara - guardian","Zul'Gurub"),pin(337,48.503,39.521,4,"Jin'do - break shields, then destroy three chains","Zul'Gurub")}, comments = {1615610,5268713},
    },
    { ids = {5769}, name = "Zul'Aman", heroicOnly = true, entrance = legacyAccess,
        steps = {
            "Select legacy Quel'Thalas with Zidormi at Thalassian Pass, then enter the original Ghostlands dungeon at 81.5,64.4. Speak to Vol'jin and complete the gong interaction to open the gate. Midnight's outdoor Zul'Aman is not this instance.",
            "Defeat the four animal bosses: Akil'zon, Nalorakk, Jan'alai and Halazzi. If also doing Bear-ly Made It, use that order and finish within the rescue timer; the ordinary completion achievement does not need the timed rescue.",
            "Continue to Hex Lord Malacrass and defeat him, then proceed to Daakara and kill him. Daakara replaced the old raid's Zul'jin and is the final boss for Heroic: Zul'Aman.",
        }, pins = {zulAman,pin(333,90.4,52.9,4,"Daakara - final boss","Zul'Aman")}, comments = {1368266},
    },
    { ids = {6117}, name = "End Time", heroicOnly = true, entrance = caverns,
        steps = {
            "Descend into the Caverns of Time in Tanaris and enter End Time. Use its transit device to visit the TWO randomly selected echo shrines; only those echoes are required for this run.",
            "Complete the selected shrine events and defeat both echoes. Azure is Jaina, Ruby is Sylvanas, Obsidian is Baine and Emerald is Tyrande. At Jaina gather the required staff fragments; at Tyrande bring shadow enemies into moonlight until her event opens.",
            "Travel to Bronze Dragonshrine and engage Murozond. Use the central Hourglass of Time when needed to rewind the fight and restore resources, then defeat him. Complete the offered quest hand-ins if you need to unlock Well of Eternity afterward.",
        }, pins = {pin(406,48.4,32.3,4,"Murozond - final boss","End Time - Bronze Dragonshrine")}, comments = {1585369},
    },
    { ids = {6118}, name = "Well of Eternity", heroicOnly = true, entrance = caverns,
        steps = {
            "Complete End Time and its offered continuation if Well of Eternity access is locked, then enter Well of Eternity through its Caverns of Time portal. Follow Illidan and accept his stealth support.",
            "Move through the portal-defense section with Illidan, kill the required defenders and close all three portals as directed. Let the NPCs enter combat and finish their dialogue so the next objective unlocks. Defeat Peroth'arn, then follow the route through Queen Azshara's encounter.",
            "At the final battle, handle Varo'then and Mannoroth, use Varo'then's dropped weapon against Mannoroth and clear the demons threatening Tyrande. Stay with Illidan through the concluding scripted phase until Mannoroth's defeat awards credit. If doing That's Not Canon!, use its sacrifice setup instead of killing Varo'then yourself.",
        }, pins = {pin(398,23.7,48.2,3,"Peroth'arn","Well of Eternity"),pin(398,87.3,48.2,4,"Mannoroth - final encounter","Well of Eternity")}, comments = {2294708},
    },
    { ids = {6119}, name = "Hour of Twilight", heroicOnly = true, entrance = caverns,
        steps = {
            "Complete End Time and Well of Eternity with their continuation quests if Hour of Twilight access is locked. Enter its Caverns of Time portal in Tanaris and speak to Thrall to begin the escort.",
            "Stay with Thrall, clear the ambush waves and defeat Arcurion, then Asira Dawnslayer. Speak to Thrall whenever he stops and wait for each scripted transition rather than running alone to the final temple.",
            "Escort him to Archbishop Benedictus at Wyrmrest Temple and defeat the Archbishop through his light and Twilight phases. If you also need Eclipse, stop boss damage in the purple phase and kill ten Twilight Sparks first. Wait for the final encounter credit.",
        }, pins = {pin(400,47.3,51.3,4,"Archbishop Benedictus - final boss","Hour of Twilight - Wyrmrest Temple")}, comments = {1700393},
    },
}

for _, route in ipairs(routes) do
    for index, id in ipairs(route.ids) do
        local heroic = route.heroicOnly or index == 2
        local name = (heroic and "Heroic: " or "") .. route.name
        local steps = { "Set Dungeon Difficulty to " .. (heroic and "Heroic" or "Normal") .. " before entering " .. route.name .. ". A different difficulty or a similarly named raid is not the requested clear." }
        local waypoints = {route.entrance}
        for _, instruction in ipairs(route.steps) do steps[#steps + 1] = instruction end
        for _, point in ipairs(route.pins) do waypoints[#waypoints + 1] = point end
        add(id, name, "easy", "A high-level legacy clear; follow the dungeon's progression events and final-boss requirement.", steps, waypoints, route.comments)
    end
end

add(4844, "Cataclysm Dungeon Hero", "medium", "Complete nine different Heroic dungeons, including their scripted finales.", {
    "Track Cataclysm Dungeon Hero and set Dungeon Difficulty to Heroic. The checklist contains the NINE original Heroic clears: Blackrock Caverns, Throne of the Tides, Grim Batol, The Stonecore, The Vortex Pinnacle, Halls of Origination, Lost City of the Tol'vir, Deadmines and Shadowfang Keep.",
    "Clear the seven new Cataclysm dungeons through their final bosses: Obsidius, Ozumat, Erudax, Azil, Asaad, Rajh and Siamat respectively. Use their individual guides for the underwater Tides entrance, elevated Stonecore and Vortex portals, and Rajh's upstairs elevator route.",
    "For Deadmines, continue past Cookie: click Vanessa's letter, complete the nightmare and defeat Vanessa. For Shadowfang Keep, continue all the way to Lord Godfrey. A Normal clear or stopping at Cookie does not satisfy those Heroic criteria.",
    "Check the nine criteria before leaving each instance and revisit only unfinished clears. The later Zul'Aman, Zul'Gurub and three Caverns of Time dungeons are separate achievements and are not additions to this nine-dungeon checklist.",
}, {blackrock,pin(204,70.5,29.9,2,"Throne of the Tides - Abyssal Breach","Abyssal Depths"),grimBatol,stonecore,vortex,halls,lostCity,deadmines,shadowfang}, {})

-- Promote the existing detailed 27-step achievement-reward route without
-- discarding its useful research, restrictions, Midnight updates or map data.
local volcanic = TDP.CollectionWalkthroughs.mounts and TDP.CollectionWalkthroughs.mounts[88331]
if volcanic then
    guides[4845] = {
        achievementId = 4845, name = "Glory of the Cataclysm Hero", category = "Dungeons",
        sourceType = "Achievement", source = "Glory of the Cataclysm Hero",
        description = volcanic.description, acquisition = volcanic.acquisition,
        difficulty = volcanic.difficulty, difficultyReason = volcanic.difficultyReason,
        stepCount = volcanic.stepCount, waypoints = volcanic.waypoints, tips = volcanic.tips,
        sourceComments = volcanic.sourceComments, sourceReplyIds = volcanic.sourceReplyIds,
        wowheadUrl = "https://www.wowhead.com/achievement=4845",
        sourceURL = "https://www.wowhead.com/achievement=4845#comments",
    }
end
