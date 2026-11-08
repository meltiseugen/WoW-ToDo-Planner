-- Retail Burning Crusade achievement routes. Original prose based on the
-- linked Wowhead comments and their corrections; obsolete keys/attunements
-- and closing joke/profit steps are deliberately excluded.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.achievements = TDP.CollectionWalkthroughs.achievements or {}
local guides = TDP.CollectionWalkthroughs.achievements

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(id, name, category, steps, waypoints, tips, sources)
    local lines = {}
    for index, text in ipairs(steps) do lines[index] = index .. ". " .. text end
    guides[id] = {
        achievementId = id, name = name, category = category,
        sourceType = "Achievement", source = name,
        acquisition = table.concat(lines, "\n\n"), stepCount = #steps,
        waypoints = waypoints or {}, tips = tips, sources = sources,
        wowheadUrl = "https://www.wowhead.com/achievement=" .. id,
        sourceURL = "https://www.wowhead.com/achievement=" .. id .. "#comments",
    }
end

-- Regular Eye of the Storm uses UiMap 112, not the altered rated map 397.
-- Landmark positions are the Retail AreaPOI records 1941/1944/1947/1950/1962,
-- projected with UiMapAssignment 39884. Buff pins mark the base search areas;
-- the power-up at a particular base can change.
-- https://wago.tools/db2/AreaPOI/csv
-- https://wago.tools/db2/UiMapAssignment/csv
local function eyePins(baseStep, flagStep)
    local points = {}
    if baseStep then
        points = {
            pin(112,40.92,41.85,baseStep,"Mage Tower (MT)","Eye of the Storm"),
            pin(112,56.03,40.66,baseStep,"Draenei Ruins (DR)","Eye of the Storm"),
            pin(112,40.10,58.92,baseStep,"Fel Reaver Ruins (FRR)","Eye of the Storm"),
            pin(112,55.79,57.43,baseStep,"Blood Elf Tower (BET)","Eye of the Storm"),
        }
    end
    if flagStep then points[#points + 1] = pin(112,48.04,49.14,flagStep,"Central flag platform","Eye of the Storm") end
    return points
end

local function eye(id, name, steps, points, tips, comments)
    local sources = {}
    for _, comment in ipairs(comments) do
        sources[#sources + 1] = "https://www.wowhead.com/achievement=" .. id .. "#comments:id=" .. comment
    end
    add(id,name,"PvP",steps,points,tips,sources)
end

eye(208,"Eye of the Storm Victory",{
    "Open Player vs. Player > Quick Match and queue for Eye of the Storm in the Specific Battlegrounds list. The map pins are INSIDE the battleground; there is no Outland doorway you can walk through to start a match.",
    "At the start, help capture and defend towers: Mage Tower and Draenei Ruins are north, Fel Reaver Ruins and Blood Elf Tower south. In this regular version, stand inside a tower's capture area with more eligible allies than enemies until its control bar moves to your side. Fighting on the road outside does not capture it.",
    "Keep defenders at captured towers and call incoming attackers. When your team has a safe base, an escorted player can take the central flag to that base for extra resources. A flag carrier cannot score without a friendly controlled base.",
    "Win by reaching the resource target before the opposing team. Stay for the result screen and check the achievement; joining a match or personally carrying a flag is not enough. The same victory starts your progress toward Eye of the Storm Veteran.",
},eyePins(2,3),"The routes in this section use the regular battleground's four-base rules. Rated and Blitz layouts can differ.",{975655})

eye(209,"Eye of the Storm Veteran",{
    "Track this achievement and note its current victory counter. Queue for regular Eye of the Storm through Specific Battlegrounds, alone or with a party; a loss or a match you leave early does not add a victory.",
    "Build wins around tower control. Keep one defender at each friendly base, send reinforcements when they call incoming, and take poorly defended enemy towers instead of leaving the whole team fighting for the middle flag.",
    "With towers secured, escort the central flag to a controlled base for extra resources. Keep playing the objectives until the match actually ends in your team's victory.",
    "Repeat until the achievement records 100 wins. Use the achievement's own progress rather than the Statistics page, which commenters found inconsistent. Older reports disagree about rated-win counters; if you use another queue, check whether that win changed this achievement before committing to a long grind there.",
    "Work on the other Eye of the Storm achievements during these matches. When planning Bound for Glory, protect your life from the START of that match; when planning Stormtrooper, intercept enemy flag carriers rather than carrying the flag yourself.",
},eyePins(2,3),"This is cumulative across matches. Old battleground marks, old gear sets and historical Arena ratings are not prerequisites.",{2328713,2501177,2583530})

eye(211,"Storm Glory",{
    "Queue for regular Eye of the Storm and ask your team to attempt four-base control. You must personally capture the flag; another teammate's capture does not satisfy your objective.",
    "Have teammates take and hold Mage Tower, Draenei Ruins, Fel Reaver Ruins and Blood Elf Tower. Assign defenders before you leave for the middle so an uncontested enemy cannot take a base during your run.",
    "Once all FOUR bases show your faction's control, personally pick up the flag at the central platform. Follow an escorted route to the nearest safe friendly tower and enter its flag capture point.",
    "Capture while all four bases are still controlled. Do this before your team reaches the resource limit: a match ending while you are carrying the flag does not give you a capture. If a tower is lost, let teammates recover it before completing the planned four-base attempt.",
    "Check the achievement after the capture. Comments report inconsistent credit, including captures with fewer bases; those reports do not provide a dependable shortcut. Repeat the stated four-base capture if credit is missing.",
},eyePins(2,3),"Hold four bases before taking the flag and through the capture to satisfy the objective as written.",{1302319,1565177,2172319,2370251})

eye(212,"Storm Capper",{
    "Queue for regular Eye of the Storm. Ask a healer or another teammate to escort you and make sure your faction controls at least one tower before attempting a flag run.",
    "Go to the CENTRAL flag platform. Clear or control enemies who can interrupt the pickup, then interact with the flag and finish taking it. Being near another carrier does not count as personally carrying it.",
    "Return by a safe bridge to a base currently controlled by your faction: Mage Tower or Draenei Ruins in the north, Fel Reaver Ruins or Blood Elf Tower in the south. Move onto that base's capture point until the flag scores.",
    "Check your personal capture on the scoreboard and the achievement. If you die and another player picks up and scores the dropped flag, that capture belongs to the other player; try again on the next flag spawn.",
},eyePins(3,2),"Avoid abilities that drop the flag. Protect the pickup and the return route instead of trying to channel in the middle of an enemy group.",{347037})

eye(213,"Stormtrooper",{
    "Track the achievement and queue for regular Eye of the Storm. You need honorable-kill credit for FIVE enemy flag carriers in ONE match. You do not need the killing blows and do not need to pick up or capture the flag yourself.",
    "Watch the central flag platform and the battleground map for an enemy pickup. Move to intercept the carrier on the route toward an enemy-controlled tower, bringing damage dealers and a healer if available.",
    "Focus the enemy WHILE they are carrying the flag. Slow or stun the carrier, interrupt or control their healers, and stay involved and close enough to receive honorable-kill credit. Killing the player after they have already scored or dropped the flag misses the intended condition.",
    "Repeat for five carrier deaths before that match ends. A small coordinated party helps keep pressure on repeated pickups. Defend or contest towers between interceptions so the match does not end before enough enemy flag runs occur.",
    "Watch the tracked progress and verify completion in the same match. Do not use old comments' battleground-switching or logout tricks; the intended route is five carrier kills within one uninterrupted battle.",
},eyePins(2,2),"The high-rated comment and its replies explicitly distinguish honorable kills from killing blows. A carrier interception is your objective, not a flag capture.",{425216,551297,1536732,2328184})

eye(214,"Flurry",{
    "Queue for regular Eye of the Storm with a coordinated party if possible. Tell the team before the gates open that you are trying to WIN in under six minutes; a fast loss does not count.",
    "Send the main force to contest the enemy-side towers immediately while a few allies claim and defend your nearer towers. Fight INSIDE capture areas. Leave defenders behind and rotate support rather than letting captured towers be taken back.",
    "Once the team holds three or four bases, send a fast escorted carrier from the central flag to the nearest controlled base. Continue flag captures while the rest of the team protects the towers to accelerate resource gains.",
    "Finish the victory before the match timer reaches 6:00 and check the achievement. If the opening is contested for too long, continue playing for the win and try the timed objective in another match; old score totals and old large-premade queue addons are unnecessary.",
},eyePins(2,3),"Both tower income and flag captures matter to a fast victory. The historical 2,000/1,600-point examples predate later scoring changes.",{1595347,1972635})

eye(216,"Bound for Glory",{
    "Queue for regular Eye of the Storm with a healer or escort if possible. Begin with ZERO deaths and keep that condition from the start of the match until your third personal flag capture. Comments repeatedly confirm that dying before your first capture can invalidate an otherwise clean three-capture streak.",
    "Let teammates secure a friendly base and clear the central platform. Personally pick up the flag once the route is safe; use healing, movement and defensive cooldowns to escape pressure without using a flag-dropping ability.",
    "Take the flag to a controlled tower and score your FIRST capture. Stay alive, heal up, then return to the middle for the next flag. Another teammate may capture between your runs; your own total still needs to reach three.",
    "Repeat the safe pickup and return for your SECOND and THIRD personal captures in that same match. Ask teammates to leave you the next pickup when you are at two, and avoid cliff edges or enemy knockbacks on the bridges.",
    "Check the achievement immediately after capture three. If you have died at any earlier point in the match, finish helping your team and start the achievement attempt in a fresh match. Deaths after the achievement has already credited cannot undo it.",
},eyePins(3,2),"The requirement is stricter than simply surviving between three captures: plan for no deaths at all before the third capture.",{410142,683212,984958,1431102,1492232,2060880})

eye(233,"Bloodthirsty Berserker",{
    "Queue for regular Eye of the Storm and find the power-up spawn by a tower. Check Mage Tower, Draenei Ruins, Fel Reaver Ruins or Blood Elf Tower; the offered power-up can vary, so a speed or restoration pickup is not the buff you need.",
    "Walk through a BERSERKING power-up and confirm that its damage-increasing aura is on YOUR character. A class ability with a similar name is not a substitute. Look for a nearby enemy before spending the short buff duration running across the map.",
    "While the aura is still active, personally land the killing blow on an enemy player. Coordinate burst on a low-health target and remain in range; a teammate's killing blow is not the objective as written.",
    "Check the achievement. If the buff expires or you die first, find another Berserking pickup and try again. Old reports of rats, totems or other battlegrounds granting credit are inconsistent and are not required for this route.",
},eyePins(1),"The tower pins locate places to search for battleground power-ups, not guaranteed live Berserking spawns.",{340282,692908,815331,1194932,1610960})

eye(587,"Stormy Assassin",{
    "Track all FOUR counters and queue for regular Eye of the Storm. In one match, earn five honorable kills at EACH tower. Twenty kills in the middle do not replace these four location-specific groups.",
    "At Mage Tower in the northwest, help kill enemy players within the tower's capture area until that criterion reaches five. Fight where the capture bar appears, rather than pulling targets far down the bridge.",
    "Rotate to Draenei Ruins in the northeast and earn its five honorable kills. Check the tracked counter after kills; the reply correction stresses that the ENEMY'S position near the base matters too.",
    "Move to Fel Reaver Ruins in the southwest and fill its five-kill counter. Keep helping your team defend or contest the base so enemies keep fighting inside the scoring area.",
    "Finish five honorable kills at Blood Elf Tower in the southeast. The towers can be done in any order; rotate toward active fights and revisit whichever counter is incomplete before the match ends.",
    "Check all four counters in that SAME battle. Killing blows are unnecessary, but staying close enough for honorable-kill credit is important. Older comments describe broader credit; use the visible counters to confirm what actually credited on your attempt.",
},{pin(112,40.92,41.85,2,"Mage Tower - five honorable kills","Eye of the Storm"),pin(112,56.03,40.66,3,"Draenei Ruins - five honorable kills","Eye of the Storm"),pin(112,40.10,58.92,4,"Fel Reaver Ruins - five honorable kills","Eye of the Storm"),pin(112,55.79,57.43,5,"Blood Elf Tower - five honorable kills","Eye of the Storm")},"The route order is a planning aid; the opponent's movement determines where useful fights occur.",{408768,502497,821544})

eye(783,"The Perfect Storm",{
    "Queue for regular Eye of the Storm and agree on a tower rush before the gates open. The intended result is a 1,500-to-0 victory: even one enemy resource tick can spoil it. A party with healers and good communication helps, but no obsolete fifteen-player queue addon is needed.",
    "Send strong groups to the enemy-side towers immediately, while a small number of allies secure your nearer towers. Keep the enemy's towers NEUTRAL until your side captures them; retaking a tower after the enemy already earned resources is too late for the clean attempt.",
    "Hold all four towers, leave defenders at each, and call incoming attackers. Keep fighting inside capture areas and rotate help quickly. Do not abandon every base to fight at a graveyard or in the middle.",
    "After tower control is secure, escort the central flag to a friendly base to finish faster. Keep the enemy score at zero through the victory and check the achievement at the result screen.",
    "If the enemy gains points, finish the match for your team's win and try again later. Comments report some unintended credit in other modes and older patches; a normal four-base shutout remains the route that satisfies the stated objective.",
},eyePins(2,4),"This can also finish Flurry if the victory takes under six minutes. Opponent strength and team cooperation mean no strategy guarantees a shutout.",{845773,1558842,1962960,2424606,3292874,6026543})

eye(784,"Eye of the Storm Domination",{
    "Track the ten-win counter and queue for regular Eye of the Storm. The stated objective is ten VICTORIES where your team holds all four bases when the match ends; temporarily taking four bases earlier is not the planned completion condition.",
    "Secure your nearer towers, then rotate a coordinated group with healing support to the enemy towers. Leave defenders at Mage Tower, Draenei Ruins, Fel Reaver Ruins and Blood Elf Tower as each is captured.",
    "When all four show your faction's control, keep defenders in place and run the central flag to speed up the final resources. Check the map before the last score: a stealth player can neutralize a tower while everyone else is celebrating.",
    "Stay through the victory and check the achievement's counter. Repeat on later matches until ten wins have credited; the victories need not be consecutive or within one play session.",
    "Retail commenters through late 2025 report missed four-base credit and unexpected credit with fewer bases. A reply for 12.0.1 reports that credit arrived on the NEXT win. If a clean victory appears missing, check again after your next completed win. This is a player-reported workaround, not a guaranteed trigger; standing on a particular base or dying at the end has not been a consistent solution.",
},eyePins(2,3),"Still obtainable: recent comments report completion. Inconsistent counters are not evidence that the achievement has been permanently removed.",{779683,2315150,3211207,5309885,5920275,6232667})

eye(1171,"Master of Eye of the Storm",{
    "Open this meta and track its actual unchecked child achievements. Queue for regular Eye of the Storm so the four-base routes in those guides match the battleground you enter. Storm Glory is a separate achievement and is not a required child of this meta.",
    "Build the cumulative wins toward Eye of the Storm Veteran, planning four-base victories for Eye of the Storm Domination. Keep defenders at the four tower pins and use each child's counter to identify what remains.",
    "In matches with safe middle control, personally capture a flag for Storm Capper, then attempt Bound for Glory with three captures and no deaths BEFORE the third capture. Arrange an escort and ask teammates to leave you the necessary pickups.",
    "In other matches, intercept five enemy carriers for Stormtrooper and rotate tower fights for Stormy Assassin. Find a Berserking power-up for Bloodthirsty Berserker and kill an opposing buffed player for Take a Chill Pill.",
    "Use coordinated tower rushes for The Perfect Storm's shutout and Flurry's under-six-minute win. Finish every child shown by the meta. Open an incomplete child's detailed guide rather than assuming a victory automatically satisfies its personal actions or location counters.",
},eyePins(2,3),"Eye of the Storm Domination has reported credit inconsistencies; its own guide explains the reports without treating this meta as retired.",{439408,615484,2854387})

eye(1258,"Take a Chill Pill",{
    "Queue for regular Eye of the Storm and look for enemy players taking power-ups near the four towers. YOU do not need Berserking for this achievement; the buff must be on the enemy you kill.",
    "Watch an enemy pick up the Berserking power-up, or inspect the target's buffs for the battleground's damage-increasing Berserking aura. An enemy with only a restoration or speed power-up is the wrong target.",
    "Engage and defeat that player before the aura expires. Bring teammates if necessary and stay involved in the kill; personally finishing the target avoids relying on the old comments' uncertain credit rules.",
    "Check the achievement and repeat with another buffed enemy if necessary. Old posts describe Arathi Basin and Warsong Gulch credit, but there is no need to leave Eye of the Storm or rely on those historical cross-battleground reports.",
},eyePins(1),"Do not confuse this with Bloodthirsty Berserker, where the Berserking aura must be on your own character.",{447830,698863,784067})

-- Retail comments: 613/347015 and 5904616; 618/3303778 and 6211471.
-- The original Quel'Thalas maps remain accessible through Zidormi in Retail.
add(613,"Killed in Quel'Thalas","PvP",{
    "Use an ALLIANCE character. At the northern Eastern Plaguelands border (53.8, 8.6), ask Zidormi for Quel'Thalas during The Burning Crusade, then cross into the original Eversong Woods. Midnight's friendly campaign copies of Lor'themar are not the original city-leader target.",
    "Travel north through the original Eversong Woods to Silvermoon City's gate around 56, 48. Enter the ORIGINAL city and head through the Court of the Sun toward Sunfury Spire at its northern end. A ground mount works in this older timeline.",
    "Find Lor'themar Theron (NPC 16802) inside Sunfury Spire at 54.0, 20.6 on the SILVERMOON CITY map. Bring friends and healing if needed. Prepare for hostile guards, Halduron Brightwing, Grand Magister Rommath and defending Horde players; do not assume an old level-80 health figure describes your current fight.",
    "Clear or control the nearby defenders, keep Lor'themar inside the spire so he does not evade, and defeat him while you remain close enough for kill credit. Check the achievement after his death. A quest scene, a friendly modern copy or another blood elf NPC is not a substitute.",
},{pin(23,53.8,8.6,1,"Zidormi - original Quel'Thalas"),pin(94,56,48,2,"Gate to original Silvermoon City","Eversong Woods (Burning Crusade)"),pin(110,54,20.6,3,"Lor'themar Theron - Sunfury Spire","Silvermoon City (Burning Crusade)")},"Entering the enemy capital and attacking its leader involves PvP. Group size depends on your character and any defending players.",{"https://www.wowhead.com/achievement=613#comments:id=347015","https://www.wowhead.com/achievement=613#comments:id=5904616","https://www.wowhead.com/npc=16802/lorthemar-theron","https://www.wowhead.com/npc=259326/zidormi"})

add(618,"Putting Out the Light","PvP",{
    "Use a HORDE character and travel to the ORIGINAL Azuremyst Isle and Exodar. Bring a group with healing and enough damage if your character cannot sustain a long fight. Prophet Velen's non-hostile quest appearances elsewhere are not this city-leader objective.",
    "Enter the Exodar and follow its passages to the Vault of Lights. If arriving from the island's harbor, use the nearby city entrance into this quarter. Avoid accidentally pulling extra groups while assembling the party.",
    "Find Prophet Velen around 32.5, 54.5 on the EXODAR city map. Clear his guards and place your back against a nearby wall to limit knockback. Keep the fight inside his room so he does not leash and reset.",
    "Damage Velen, deal with respawning defenders and interrupt his interruptible heals. If a yellow healing pool appears under him, MOVE HIM OUT OF IT without dragging him far enough to reset. A recent Retail comment reports Vigilant Defenders returning during long fights and protecting him with an immunity buff: kill those defenders when they appear.",
    "Defeat Velen and check the achievement while close enough for credit. If his health keeps recovering, solve the healing-pool or defender problem rather than repeating damage into the protection. Older comments' Auberdine boat route and fixed raid-size or gear requirements are obsolete.",
},{pin(103,32.5,54.5,3,"Prophet Velen - Vault of Lights","The Exodar"),pin(103,31.3,47.9,4,"Nearby wall - control knockback without resetting Velen","The Exodar")},"The 2025 Retail report describes moving Velen out of his healing pool and killing returning Vigilant Defenders. Fight duration varies; a solo kill is not promised.",{"https://www.wowhead.com/achievement=618#comments:id=3303778","https://www.wowhead.com/achievement=618#comments:id=5302348","https://www.wowhead.com/achievement=618#comments:id=6211471","https://www.wowhead.com/npc=17468/prophet-velen"})

-- The August 2026 comments correct the obsolete Gorma Asaan criterion:
-- https://www.wowhead.com/achievement=62460#comments:id=6397806
-- https://www.wowhead.com/achievement=62460#comments:id=6399205
local function tamerPins(firstStep)
    return {
        pin(100, 64.4, 49.2, firstStep, "Nicki Tinytech - Mechanical opponents"),
        pin(102, 17.2, 50.6, firstStep + 1, "Ras'an - Humanoid, Flying, Magic"),
        pin(107, 61.0, 49.4, firstStep + 2, "Narrok - Critter, Aquatic, Beast"),
        pin(111, 59.0, 70.6, firstStep + 3, "Morulu the Elder - Aquatic opponents"),
        pin(104, 30.6, 41.8, firstStep + 4, "Bloodknight Antari - Magic, Elemental, Dragonkin"),
    }
end

-- Teams are examples from each achievement's own comments, not a promise
-- of a deterministic script. Ability numbers refer to Pet Journal slots.
local families = {
    { 62466, "Aquatic", "Storm-infused Snapdragon (1/1/2), Hermit Crab (1/1/2) and Snarly (1/1/2)", "Against Flying enemies, an Aquatic pet with Magic attacks, such as Emerald Turtle, can help.", 6412634 },
    { 62467, "Beast", "two foxes with Flurry/Crouch/Dazzling Dance plus a Snowy Panda (2/2/1)", "Nicki's Mechanical team resists ordinary Beast damage. A Thunder Lizard Runt (2/2/1) with Lightning Shield and Akunda's Wrath is the suggested opening replacement; follow with the foxes.", 6413859 },
    { 62468, "Critter", "Snowshoe Rabbit and Dust Bunny with Flurry/Dodge/Burrow, plus Gleamhoof Fawn (1/2/2)", "Use fast rabbits so Dodge and Burrow cover dangerous attacks. All three pets must be CRITTERS; the previous Beast requirement was incorrect.", 6407170 },
    { 62469, "Dragonkin", "Nether Faerie Dragon (2/2/1), Infinite Whelpling (1/1/1) and Stormborne Whelpling (2/2/2)", "Time heals and Life Exchange for useful health swings, and change your opening pet to match the opposing family.", 6407175 },
    { 62470, "Elemental", "Tiny Snowman (2/1/2), Electrified Razortooth (1/2/1) and Molten Corgi (2/2/1)", "Use Puppies of the Flame to avoid a large hit. Lil' Ragnaros (1/2/2) is a suggested alternative when the Corgi struggles.", 6407179 },
    { 62471, "Flying", "Amber Moth (1/1/2), Ashwing Moth (2/2/2) and Cerulean Moth (1/1/2)", "Moth Dust sleep is random; Cocoon Strike should cover dangerous attacks. Replies report trouble with moths against Antari: Crimson Bat Pup (2/1/1), Direbeak Hatchling with Falcosaur Swarm!, and Dusky Dredwing Pup (2/1/1) are a separately reported Antari team.", 6407183 },
    { 62472, "Humanoid", "Father Winter's Helper (2/1/2), Rotten Little Helper (1/1/1) and Lil' Bad Wolf (1/2/2)", "Anubisath Idol, Curious Wolvar Pup and Fiendish Imp are another reported team. Choose attacks for each opponent rather than using a non-Humanoid counterpet.", 6408431 },
    { 62473, "Magic", "Enchanted Tiki Mask (1/1/2), Enchanted Pen (1/1/2) and Enchanted Torch (1/1/1)", "Nicki's machines are the awkward matchup. Magic-family pets with ELEMENTAL attacks, including Enchanted Torch or Abyssius, keep the team eligible while exploiting that weakness.", 6411560 },
    { 62474, "Mechanical", "Mechanical Pandaren Dragonling (1/1/2), Iron Starlette (1/1/1) and Darkmoon Tonk (1/1/2)", "Use Decoy to absorb dangerous attacks and time Wind-Up so the second use lands after a defensive effect ends. Mechanical recovery is part of the pet's racial ability.", 6408978 },
    { 62475, "Undead", "Mr. Bigglesworth (2/2/2), Macabre Marionette (2/1/1) and Scourged Whelpling (1/1/1)", "Use crowd control and damage-over-time effects around the opposing team's cooldowns. Blightbreath (1/1/1), Fragment of Anger (1/1/1) and Wayward Spirit (1/1/2) are another reported team.", 6409143 },
}
for _, family in ipairs(families) do
    add(family[1], family[2] .. " Battler of Outland", "Pet Battles", {
        "Prepare THREE level-25 " .. family[2] .. " pets. Every slot must satisfy the family and level requirement, even if one pet never fights. A reported starting team is " .. family[3] .. ". The numbers select the first/second ability in each of the three Journal ability slots; heal between battles.",
        "Defeat Nicki Tinytech in Hellfire Peninsula (64.4, 49.2). Her opponents are Mechanical. Keep your entire team in the required family; a pet's attack type can differ from its family.",
        "Defeat Ras'an beside Sporeggar in Zangarmarsh (17.2, 50.6). His opponents are Humanoid, Flying and Magic. Reorder your eligible team and change abilities before the fight to cover these matchups.",
        "Defeat Narrok in Nagrand, OUTLAND (61.0, 49.4). His opponents are Critter, Aquatic and Beast. Heal and revive before moving to the next trainer.",
        "Defeat Morulu the Elder in Shattrath's Lower City (59.0, 70.6). All three enemies are Aquatic crocolisks; check their queued attacks before spending a defensive cooldown.",
        "Defeat Bloodknight Antari in Shadowmoon Valley, OUTLAND (30.6, 41.8). His enemies are Magic, Elemental and Dragonkin. Antari replaced the old erroneous Gorma Asaan criterion. Check that all five trainer criteria have credited; daily availability can prevent immediately repeating an already completed tamer.",
        family[4],
    }, tamerPins(2), "These are player-reported teams, not guaranteed turn-by-turn solutions. Breed, speed, critical hits and random sleeps can require a retry or a different eligible pet.", {
        "https://www.wowhead.com/achievement=" .. family[1] .. "#comments:id=" .. family[5],
        "https://www.wowhead.com/achievement=62460#comments:id=6397806",
        family[1] == 62471 and "https://www.wowhead.com/achievement=62471#comments:id=6410153" or nil,
    })
end

add(62460, "Family Battler of Outland", "Pet Battles", {
    "Unlock the Outland trainer battles through the pet-tamer quest progression if the trainers will not offer a battle. Prepare level-25 teams for all ten families; this meta needs ten separate family achievements, not one mixed-family team.",
    "Defeat Nicki Tinytech in Hellfire Peninsula with each missing family team. Track the child achievements so you know which family victories still need credit.",
    "At Ras'an in Zangarmarsh, repeat the wins for each family when his battle is available. A level-24 carry pet or an off-family counterpet makes that attempt ineligible.",
    "Continue the family victories at Narrok in Outland Nagrand.",
    "Continue at Morulu the Elder in Shattrath. Heal the team between attempts and respect each trainer's daily availability.",
    "Finish the family victories against Bloodknight Antari in Outland Shadowmoon Valley. The old Gorma Asaan reference was corrected to Antari; do not search another continent for that NPC. Complete Aquatic, Beast, Critter, Dragonkin, Elemental, Flying, Humanoid, Magic, Mechanical and Undead Battler of Outland to finish the meta.",
}, tamerPins(2))

-- https://www.wowhead.com/achievement=6604#comments:id=1727467
-- https://www.wowhead.com/achievement=6604#comments:id=1924257
add(6604, "Taming Outland", "Pet Battles", {
    "Follow your faction's earlier pet-tamer quest chain until Audrey Burnhep in Stormwind or Varzok in Orgrimmar offers Battle Pet Tamers: Outland (31919/31921). If the trainer has a speech bubble but no battle, check this prerequisite and your account's tamer quest log before travelling between trainers.",
    "Defeat Nicki Tinytech in Hellfire Peninsula (64.4, 49.2). Her three level-20 Mechanical pets are weak to Elemental attacks. A healthy level-25 team makes the early battles easier.",
    "Defeat Ras'an in western Zangarmarsh (17.2, 50.6). Bring Undead attacks for his Humanoid, Magic attacks for his Flying pet and Dragonkin attacks for his Magic pet.",
    "Defeat Narrok in Outland Nagrand (61.0, 49.4). Beast, Flying and Mechanical attacks counter his Critter, Aquatic and Beast pets respectively.",
    "Defeat Morulu the Elder in Shattrath (59.0, 70.6). Flying attacks are effective against all three crocolisks. Turn in the four-tamer quest and accept its Grand Master Antari follow-up.",
    "Defeat Bloodknight Antari at 30.6, 41.8 in Outland Shadowmoon Valley. Bring Dragonkin, Aquatic and Humanoid attacks against his Magic, Elemental and Dragonkin opponents. Finish the quest hand-in to unlock the associated daily progression.",
}, tamerPins(2), "This achievement has no single-family restriction. If the account has the required quest but the battle dialogue is missing, relogging resolved that state for commenters.")

-- Every Normal and Heroic achievement page was read separately. Most have
-- no acquisition comments; these routes retain the existing entrance data.
-- Notable corrections: 647/402581 (Omor), 667/540955 (both final encounters),
-- 673/1973414 (full escort), 677/1123032 (both control panels),
-- 679/1369165 + 1466195 (gatewatchers, no key), 681/1466207 (no key).
-- Interior pins use the Retail JournalEncounter coordinates and UiMapIDs,
-- cross-checked with the named NPC pages; floor names use UiMapGroupMember.
-- https://wago.tools/db2/JournalEncounter/csv
-- https://wago.tools/db2/UiMapGroupMember/csv
local dungeonInteriors = {
    [647] = { pin(347,39.07,20.49,2,"Omor the Unscarred","Hellfire Ramparts"), pin(347,35.52,82.79,3,"Vazruden and Nazan - also required on Heroic","Hellfire Ramparts") },
    [648] = { pin(261,58.33,41.19,3,"Keli'dan - kill the channelers first","The Blood Furnace") },
    [649] = { pin(265,82.10,76.84,3,"Quagmirran - final cavern","The Slave Pens") },
    [650] = { pin(262,24.73,45.70,3,"The Black Stalker","The Underbog") },
    [651] = { pin(272,32.38,49.18,3,"Nexus-Prince Shaffar","Mana-Tombs") },
    [652] = { pin(274,52,41,3,"Thrall - speak again near Tarren Mill","Old Hillsbrad Foothills"), pin(274,50.82,31.97,4,"Epoch Hunter - finish the escort to spawn him","Old Hillsbrad Foothills") },
    [653] = { pin(259,32.65,27.66,3,"Talon King Ikiss - beyond Anzu's room","Sethekk Halls - Halls of Mourning") },
    [654] = { pin(260,80.87,39.14,3,"Murmur","Shadow Labyrinth") },
    [655] = { pin(273,48.09,74.59,3,"Aeonus - eighteenth rift by Medivh","The Black Morass") },
    [656] = { pin(263,54.23,13.73,2,"Hydromancer Thespia - activate nearby control panel","The Steamvault"), pin(263,34.15,81.97,2,"Mekgineer Steamrigger - activate nearby control panel","The Steamvault"), pin(263,75.96,43.65,3,"Warlord Kalithresh - opened final chamber","The Steamvault") },
    [657] = { pin(246,67.35,54.51,3,"Warchief Kargath Bladefist","The Shattered Halls") },
    [658] = { pin(268,27.19,61.07,3,"Pathaleon - finish the walkway waves","The Mechanar - Calculation Chamber") },
    [659] = { pin(266,34.29,36.89,3,"Warp Splinter","The Botanica") },
    [660] = { pin(271,61.61,30.74,3,"Harbinger Skyriss - Warden's prison event","The Arcatraz - Containment Core") },
    [666] = { pin(257,73.91,50.82,3,"Exarch Maladaar","Auchenai Crypts - Bridge of Souls") },
    [661] = { pin(348,8.61,50.20,3,"Kael'thas Sunstrider - original dungeon","Magisters' Terrace - Grand Magister's Asylum") },
}
local dungeons = {
    { 647, 667, "Hellfire Ramparts", 100, 47.65, 53.57,
      "Fly to the lower exterior rampart of Hellfire Citadel in Hellfire Peninsula. Enter Hellfire Ramparts, not the higher Blood Furnace portal or the nearby Shattered Halls doorway.",
      "Follow the ramparts past Watchkeeper Gargolmar. At the final fork, take the branch to Omor the Unscarred and defeat him. Omor is the Normal achievement's named objective even though the dragon encounter looks like the finale.",
      "For Heroic, also clear the opposite platform: kill the guards to start Vazruden and Nazan, then defeat both. The Heroic achievement requires this encounter AND Omor; do not leave after only one branch." },
    { 648, 668, "The Blood Furnace", 100, 46.06, 51.74,
      "Fly to the upper northern platform of Hellfire Citadel and enter The Blood Furnace.",
      "Clear The Maker, then enter Broggok's prison room. Use the lever to release the cell waves, kill each wave and Broggok, and continue through the opened route.",
      "In the final chamber, kill the channeling orcs to release Keli'dan the Breaker, then defeat Keli'dan. The green tunnel behind him is the exit shortcut." },
    { 649, 669, "The Slave Pens", 102, 48.95, 35.84,
      "At Coilfang Reservoir in Serpent Lake, dive down the central pipe around 50.4, 40.9 and swim into the air-filled cavern. Take The Slave Pens entrance on the left; check the instance name.",
      "Follow the main cavern route past Mennu the Betrayer and Rokmar the Crackler. Clear pursuing naga before continuing to the rear cave.",
      "Defeat Quagmirran in the last cavern. Ahune, the seasonal Midsummer boss, does not replace Quagmirran for this achievement." },
    { 650, 670, "Underbog", 102, 54.24, 34.45,
      "Dive through the central pipe in Serpent Lake at 50.4, 40.9, surface inside Coilfang Reservoir and take The Underbog entrance on the right.",
      "Follow the ramps through Hungerfen's area, cross the naga bridge past Ghaz'an, then continue through the bog to Swamplord Musel'ek and his bear.",
      "Reach the final ledge and defeat The Black Stalker. Jump down toward the entrance afterwards. Collect Sanguine Hibiscus along the way if you also need Sporeggar reputation." },
    { 651, 671, "Mana-Tombs", 108, 39.63, 57.67,
      "Enter the NORTHERN doorway of the Auchindoun ring in Terokkar Forest. Mana-Tombs is the Consortium dungeon, not one of the three Lower City reputation dungeons.",
      "Follow the corridors past Pandemonius and Tavarok into the ethereal hall. Clear any enemies following you before the final encounter.",
      "Defeat Nexus-Prince Shaffar and his summoned beacons/apprentices. The optional Heroic boss Yor is not required for the achievement." },
    { 652, 673, "The Escape From Durnholde", 75, 26.8, 36.8,
      "Go inside the Caverns of Time in Tanaris and enter OLD HILLSBRAD FOOTHILLS. The achievement calls it The Escape From Durnholde; present-day Hillsbrad's outdoor keep is the wrong destination.",
      "Speak to Erozion inside for incendiary bombs and use Brazen's flight to Durnholde. Burn the barrels in all five internment huts, then defeat Lieutenant Drake. Speak to Erozion for any quest hand-in the event requires.",
      "Find Thrall in the keep basement and speak to him to start his escape. Stay beside him, kill Captain Skarloc and the ambushes, and speak to him again whenever he stops. At Tarren Mill he waits southwest of the town around 52, 41 on the INSTANCE map; this is not a Tanaris coordinate.",
      "Speak to Taretha and Thrall as the story progresses. Defeat the dragon waves and Epoch Hunter when the event spawns him. Running straight to his marked location without completing the escort cannot spawn the boss." },
    { 653, 674, "Sethekk Halls", 108, 44.93, 65.61,
      "Enter the EASTERN doorway of the Auchindoun ring in Terokkar Forest; two purple braziers mark the approach.",
      "Clear the halls past Darkweaver Syth and climb to the Halls of Mourning. On Heroic, Anzu is an optional stop for the Raven Lord mount and does not require a Druid to summon him.",
      "Continue beyond Anzu's room to Talon King Ikiss and defeat him. Stopping at the mount boss does not finish this dungeon achievement." },
    { 654, 675, "Shadow Labyrinth", 108, 39.63, 73.55,
      "Enter the SOUTHERN doorway of Auchindoun in Terokkar Forest. Open the door and continue through the portal; Retail does not require the old Shadow Labyrinth Key.",
      "Clear the ritualists around Ambassador Hellmaw to release him, then proceed through Blackheart the Inciter and Grandmaster Vorpil. Clear enemies that follow you so the encounters can finish normally.",
      "Follow the last hall to Murmur and defeat him. He begins below full health by design; this is the correct final encounter." },
    { 655, 676, "Opening of the Dark Portal", 75, 37.2, 83.3,
      "Enter THE BLACK MORASS inside the Caverns of Time, Tanaris. The outdoor Dark Portal in Blasted Lands and Draenor's introductory scenario do not count.",
      "Approach Medivh to start the event, then intercept the creatures from each opening time rift. Kill the Rift Lord or Rift Keeper guarding each portal and keep other attackers away from Medivh's shield.",
      "Complete all 18 rifts: defeat Chrono Lord Deja at rift 6, Temporus at 12 and Aeonus at 18. Stay through the event; no old Caverns of Time attunement or previous Durnholde clear is required." },
    { 656, 677, "The Steamvault", 102, 50.35, 33.39,
      "Dive into Coilfang Reservoir's central underwater pipe at 50.4, 40.9 in Serpent Lake. Surface in the cavern and take The Steamvault entrance toward the rear, rather than Serpentshrine Cavern's raid portal.",
      "Defeat Hydromancer Thespia AND Mekgineer Steamrigger. After each boss, click the nearby control panel. Killing both bosses without activating both panels leaves the final chamber locked.",
      "Enter the now-open final room and defeat Warlord Kalithresh. Destroy a nearby distiller if his channel is a problem. Clear trash too if you need Cenarion Expedition reputation." },
    { 657, 678, "The Shattered Halls", 100, 47.66, 51.98,
      "Find the doorway halfway up Hellfire Citadel beside the Path of Glory. It is between the exterior rampart walls; open the gate and enter The Shattered Halls. The old entry and Heroic reputation keys are obsolete.",
      "Clear the opening corridors and the encounter with Grand Warlock Nethekurse, then proceed through the gauntlet and Warbringer O'mrogg's room.",
      "Defeat Warchief Kargath Bladefist at the end. The Heroic execution/prisoner timer is not an extra requirement for this kill achievement." },
    { 658, 679, "The Mechanar", 109, 70.61, 69.75,
      "Fly to the southeastern satellite of Tempest Keep in Netherstorm and enter The Mechanar. The large central fortress is the raid, The Eye.",
      "Kill BOTH Gatewatcher Gyro-Kill and Gatewatcher Iron-Hand on the entrance floor to unlock the elevator. They no longer drop halves of a key to combine. Ride the elevator to the upper floor.",
      "Clear the upper walkway and its attacking waves, then defeat Pathaleon the Calculator when he becomes available. If the event is still running, finish the waves rather than waiting at an empty boss marker." },
    { 659, 680, "The Botanica", 109, 71.74, 54.95,
      "Fly to the northern satellite of Tempest Keep in Netherstorm and enter The Botanica.",
      "Follow the long garden route through Commander Sarannis, High Botanist Freywinn, Thorngrin and Laj's sections. Earlier bosses are optional for the achievement itself, but kill trash and bosses if farming The Sha'tar reputation.",
      "At the far end, defeat Warp Splinter. His saplings do not count in place of the boss; check achievement credit before using the exit." },
    { 660, 681, "The Arcatraz", 109, 74.42, 57.72,
      "Fly to the eastern Tempest Keep satellite in Netherstorm and enter The Arcatraz. Retail no longer requires the Key to the Arcatraz or a Heroic reputation key.",
      "Climb through the prison past Zereketh, Dalliah and Wrath-Scryer Soccothrates to Warden Mellichar's chamber.",
      "Approach the Warden to start the cell-release event. Defeat the hostile prisoners as each cell opens; the friendly Millhouse is part of the sequence. Wait for Harbinger Skyriss to be released, then kill him and his illusions." },
    { 666, 672, "Auchenai Crypts", 108, 34.34, 65.61,
      "Enter the WESTERN doorway of the Auchindoun ring in Terokkar Forest, opposite Sethekk Halls.",
      "Follow the crypts through Shirrak the Dead Watcher's room. Continue down to the Bridge of Souls and clear the undead guarding Exarch Maladaar.",
      "Defeat Exarch Maladaar. His summoned Avatar is part of that encounter, not an alternative final boss." },
    { 661, 682, "Magister's Terrace", 122, 61.23, 30.94,
      "In Shattrath, take the portal around 48.9, 42.1 to the ORIGINAL Isle of Quel'Danas. Enter the original Magisters' Terrace in the northeast; Midnight's newer instance is a different destination.",
      "Defeat Selin Fireheart, Vexallus, then Priestess Delrissa AND all her companions. Follow the opened route to Kael'thas Sunstrider.",
      "Defeat Kael'thas and loot him. The Heroic clear also offers a chance at Swift White Hawkstrider; Phoenix Hatchling can drop on either difficulty. Return after the daily reset for another Heroic loot attempt." },
}

for _, dungeon in ipairs(dungeons) do
    for mode = 1, 2 do
        local id, heroic = dungeon[mode], mode == 2
        local steps = { (heroic and "Set Dungeon Difficulty to HEROIC before entering. " or "Normal or Heroic can credit this achievement. ") .. dungeon[7] }
        for index = 8, #dungeon do steps[#steps + 1] = dungeon[index] end
        local points = { pin(dungeon[4], dungeon[5], dungeon[6], 1, dungeon[3] .. " entrance") }
        if dungeon[4] == 102 then table.insert(points, 1, pin(102, 50.4, 40.9, 1, "Coilfang Reservoir - dive down the central pipe")) end
        if id == 661 or id == 682 then table.insert(points, 1, pin(111, 48.9, 42.1, 1, "Portal to original Isle of Quel'Danas")) end
        for _, point in ipairs(dungeonInteriors[dungeon[1]] or {}) do points[#points + 1] = point end
        add(id, (heroic and "Heroic: " or "") .. dungeon[3], "Dungeons", steps, points,
            "Use the original Burning Crusade instance. Legacy Heroic dungeons have a daily boss lockout; Reset All Instances does not restore killed Heroic bosses.")
    end
end

-- Raid achievement comments: 694/731379, 696/2497300 and its correction,
-- 693/2461967, 698/1996136. No profit-ending current acquisition route.
local raidInteriors = {
    [690] = {
        pin(352,27.13,63.54,2,"Moroes","Karazhan - The Banquet Hall"),
        pin(353,18.10,35.08,2,"Opera - speak to Barnes","Karazhan - The Guest Chambers / Opera"),
        pin(358,49.49,36.62,2,"The Curator","Karazhan - The Menagerie"),
        pin(363,35.95,61.69,3,"Chess Event - defeat the enemy king","Karazhan - Gamesman's Hall"),
        pin(366,51.44,30.92,3,"Prince Malchezaar","Karazhan - Netherspace"),
    },
    [692] = { pin(330,55.03,57.08,2,"High King Maulgar and council","Gruul's Lair"), pin(330,19.95,28.31,3,"Gruul the Dragonkiller","Gruul's Lair") },
    [693] = { pin(331,69.18,74.31,2,"Channelers - kill them and wait for release","Magtheridon's Lair"), pin(331,69.18,74.31,3,"Magtheridon","Magtheridon's Lair") },
    [694] = { pin(332,40.26,58.15,2,"Optional: The Lurker Below - fish from Strange Pool","Serpentshrine Cavern"), pin(332,72.26,58.92,3,"Lady Vashj","Serpentshrine Cavern") },
    [695] = { pin(329,12.77,63.38,2,"Alliance camp - Jaina's boss waves","Hyjal Summit"), pin(329,42.41,35.85,3,"Horde camp - Thrall's boss waves","Hyjal Summit"), pin(329,77.28,28.31,4,"Archimonde - final encounter","Hyjal Summit") },
    [696] = { pin(334,50.10,13.85,2,"Kael'thas - rear chamber","The Eye"), pin(334,50.10,13.85,3,"Kael'thas - complete every phase","The Eye") },
    [697] = {
        pin(340,43.95,18.77,2,"High Warlord Naj'entus","Black Temple - Karabor Sewers"),
        pin(339,66.31,47.38,2,"Supremus","Black Temple - Courtyard"),
        pin(341,40.97,88.92,2,"Shade of Akama","Black Temple - Sanctuary of Shadows"),
        pin(343,39.44,11.85,2,"Teron Gorefiend","Black Temple - Gorefiend's Vigil"),
        pin(342,54,47.69,2,"Gurtogg Bloodboil","Black Temple - Halls of Anguish"),
        pin(342,61.38,85.08,2,"Reliquary of Souls","Black Temple - Halls of Anguish"),
        pin(344,67.54,36.77,3,"Mother Shahraz","Black Temple - Den of Mortal Delights"),
        pin(345,47.33,43.85,3,"Illidari Council - then speak to Akama","Black Temple - Chamber of Command"),
        pin(346,52.77,70.46,3,"Illidan Stormrage","Black Temple - Temple Summit"),
    },
    [698] = { pin(335,65.90,86.46,2,"Brutallus - outdoor raid route","Sunwell Plateau"), pin(335,72.77,82.62,2,"Felmyst","Sunwell Plateau"), pin(335,64.16,32.10,2,"Eredar Twins","Sunwell Plateau"), pin(336,46.72,23.85,2,"M'uru / Entropius","Sunwell Plateau - Shrine of the Eclipse"), pin(336,46,61.69,3,"Kil'jaeden - kill the three Hands first","Sunwell Plateau - Shrine of the Eclipse") },
}
local raids = {
    { 690, "Karazhan", 42, 46.87, 74.69,
      "Enter the original ground-level Karazhan RAID in Deadwind Pass. The raised Return to Karazhan dungeon entrance belongs to Legion.",
      "Go through Moroes's area and the Opera event; speak to Barnes to start the performance. Follow the opened backstage route, defeat The Curator and climb through the upper tower.",
      "Complete the Chess event by speaking to the Echo of Medivh and controlling pieces until the enemy king dies. Continue up to Netherspace and defeat Prince Malchezaar. Nightbane is optional and does not replace the Prince." },
    { 692, "Gruul's Lair", 105, 69.31, 23.67,
      "Fly to the cave entrance in northeastern Blade's Edge Mountains, east of the Circle of Blood.",
      "Clear High King Maulgar and his council in the first room, then follow the tunnel onward.",
      "Defeat Gruul the Dragonkiller in the last cavern. There is no lengthy attunement or separate Heroic difficulty to unlock." },
    { 693, "Magtheridon's Lair", 100, 46.5, 52.9,
      "Enter the GROUND-LEVEL doorway on the western side of Hellfire Citadel. Do not climb to one of the three dungeon entrances.",
      "Clear the Hellfire Warder packs around the outer ring, then attack and kill the five Hellfire Channelers in the central chamber. Interrupt heals if your character cannot kill them immediately.",
      "Wait for Magtheridon to break free and defeat him. A strong legacy-farming character does not need five people operating the cubes; his release is timed, not triggered by clicking a cube." },
    { 694, "Serpentshrine Cavern", 102, 50.4, 40.9,
      "Dive down Coilfang Reservoir's central pipe in Serpent Lake and surface in the cavern. Enter the central RAID portal, not one of the neighboring five-player dungeons.",
      "Follow the platforms and bridges to Lady Vashj. Other bosses are useful for pets and appearances but are not the named kill requirement. The Lurker Below must be fished from his Strange Pool if you also want that encounter.",
      "Defeat Lady Vashj. If she reaches her shield phase, kill Tainted Elementals, loot their Tainted Cores promptly and use them on the four shield generators. A high-level character may kill her before this phase." },
    { 695, "The Battle for Mount Hyjal", 75, 36.0, 16.1,
      "Enter the Battle for Mount Hyjal RAID inside the Caverns of Time, Tanaris. The Cataclysm outdoor Mount Hyjal zone is not this instance.",
      "Speak to Jaina Proudmoore at the Alliance camp to start each sequence. Clear the eight waves and Rage Winterchill, then start the next sequence and defeat Anetheron. Speak to Jaina again to move the story onward.",
      "At the Horde camp, speak to Thrall to begin the next two wave sequences and defeat Kaz'rogal and Azgalor. Talk to him after the second boss to open the final route.",
      "Continue to the World Tree and defeat Archimonde. Keep the Air Burst fall-protection item offered by Tyrande if your character needs it; the achievement is awarded for Archimonde, not merely the camp waves." },
    { 696, "Tempest Keep", 109, 73.73, 63.71,
      "Fly to the large CENTRAL floating fortress of Tempest Keep in eastern Netherstorm and enter THE EYE raid. Its three smaller satellites are separate dungeons.",
      "Go to Kael'thas's room at the rear. Al'ar, Void Reaver and Solarian are optional for this achievement; the comment claiming all three must die first is corrected in its reply.",
      "Start Kael'thas's event, defeat the advisers in their sequence, kill the summoned weapons and revived advisers, then defeat Kael'thas. Wait for roleplay transitions rather than leaving when he is temporarily untargetable." },
    { 697, "The Black Temple", 104, 71.0, 46.5,
      "Enter the original Black Temple raid through the breach in its wall in Shadowmoon Valley, OUTLAND. Draenor's Shadowmoon Valley is a different zone.",
      "Defeat Naj'entus and Supremus, then continue through Shade of Akama, Teron Gorefiend, Gurtogg Bloodboil and Reliquary of Souls. Let each encounter complete before moving onward.",
      "Proceed through Mother Shahraz and the Illidari Council. Speak to Akama to open the summit route and start the final event. Defeat Illidan, including both Flames of Azzinoth when he becomes airborne." },
    { 698, "Sunwell Plateau", 122, 44.28, 45.71,
      "Take Shattrath's portal at 48.9, 42.1 to the ORIGINAL Isle of Quel'Danas and enter Sunwell Plateau on the west side. This is the Burning Crusade raid.",
      "Follow the raid through Brutallus, Felmyst, the Eredar Twins and M'uru/Entropius. Kalecgos is not necessary for the direct route to the final boss on a legacy farming run; do not get stuck at his optional portal encounter.",
      "Kill the three Hand of the Deceiver enemies at the Sunwell to summon Kil'jaeden, then defeat him. Loot the boss before leaving if also collecting Thori'dal or raid pets." },
}
for _, raid in ipairs(raids) do
    local steps = {}
    for index = 7, #raid do steps[#steps + 1] = raid[index] end
    local points = { pin(raid[3], raid[4], raid[5], 1, raid[2] .. " entrance") }
    -- The first narrative field is index 6, unlike the dungeon tuples.
    table.insert(steps, 1, raid[6])
    if raid[1] == 698 then table.insert(points, 1, pin(111, 48.9, 42.1, 1, "Portal to original Isle of Quel'Danas")) end
    for _, point in ipairs(raidInteriors[raid[1]] or {}) do points[#points + 1] = point end
    add(raid[1], raid[2], "Raids", steps, points, "Original raids use weekly boss lockouts. No original entry attunement is required.")
end

-- https://www.wowhead.com/achievement=763#comments:id=1873687 and replies
-- 764 was also reviewed: the old entry keys and attunements are obsolete.
for _, id in ipairs({ 763, 764 }) do
    local alliance = id == 764
    add(id, "The Burning Crusader", "Reputation", {
        "Use one character for the five required dungeon reputations. Set Dungeon Difficulty to NORMAL for repeatable clears. Wear no reputation-conversion tabard; a later expansion's tabard cannot substitute for these factions.",
        "For " .. (alliance and "Honor Hold" or "Thrallmar") .. ", repeatedly clear The Shattered Halls in Hellfire Citadel (47.7, 52.0). Its Normal kills continue beyond the lower-level dungeons' caps. Exit, reset outside and repeat; no Flamewrought Key is needed.",
        "For Cenarion Expedition, dive through Coilfang Reservoir's central pipe in Zangarmarsh (50.4, 40.9) and clear Normal Steamvault. Activate the panels after Thespia and Steamrigger to open Kalithresh's room. Finish with a Heroic Coilfang run if Normal kills stop at the final point before Exalted.",
        "For Lower City, clear Normal Shadow Labyrinth at the SOUTH side of Auchindoun (39.6, 73.6). Mana-Tombs awards Consortium reputation instead; do not farm it for Lower City. Shadow Labyrinth needs no entry key in Retail.",
        "For The Sha'tar, fly to Tempest Keep in Netherstorm and repeatedly clear Normal Botanica (71.7, 55.0), Mechanar (70.6, 69.8) or Arcatraz (74.4, 57.7). The Eye raid does not replace these dungeon farms.",
        "For Keepers of Time, enter Old Hillsbrad (26.8, 36.8) or Black Morass (37.2, 83.3) on the Caverns of Time map. Complete the Thrall escort or Medivh's 18-rift event. Both Normal dungeons remain repeatable; there is no need to buy an old key or deliberately fail an event.",
        "Repeat the appropriate routes until all five factions are Exalted on this character. Respect the hourly instance-entry limit and daily Heroic boss lockouts. Reputation bonuses change the number of runs, so check the actual reputation bars instead of relying on fixed completion times.",
    }, {
        pin(100, 47.66, 51.98, 2, "The Shattered Halls - " .. (alliance and "Honor Hold" or "Thrallmar")),
        pin(102, 50.4, 40.9, 3, "Coilfang Reservoir - dive down the pipe"),
        pin(102, 50.35, 33.39, 3, "The Steamvault - Cenarion Expedition"),
        pin(108, 39.63, 73.55, 4, "Shadow Labyrinth - Lower City"),
        pin(109, 71.74, 54.95, 5, "The Botanica - The Sha'tar"),
        pin(109, 70.61, 69.75, 5, "The Mechanar - The Sha'tar"),
        pin(109, 74.42, 57.72, 5, "The Arcatraz - The Sha'tar"),
        pin(75, 26.8, 36.8, 6, "Old Hillsbrad - Keepers of Time", "Caverns of Time"),
        pin(75, 37.2, 83.3, 6, "The Black Morass - Keepers of Time", "Caverns of Time"),
    })
end

-- https://www.wowhead.com/achievement=899#comments:id=1049234 and replies
-- https://www.wowhead.com/achievement=901#comments:id=1070965
for _, id in ipairs({ 899, 901 }) do
    local alliance = id == 899
    add(id, alliance and "Oh My, Kurenai" or "Mag'har of Draenor", "Reputation", {
        "Use an " .. (alliance and "Alliance character for Kurenai" or "Horde character for The Mag'har") .. " and travel to Nagrand in OUTLAND. This is the old reputation, not Draenor's factions or the Mag'har allied race.",
        "Kill ogres in Laughing Skull Ruins (46, 23), Warmaul Hill (29, 26), or the Boulderfist caves around 49, 56 and 40, 32. Loot all Obsidian Warbeads. Eligible ogre kills themselves grant reputation, including the early standing needed to speak to the faction.",
        "Once the faction will speak to you, visit " .. (alliance and "Warden Moi'bff Jill in Telaar (54.8, 70.8)" or "Warden Bullrok in Garadar (55.8, 37.8)") .. ". Complete Fierce Enemies with 10 Obsidian Warbeads, then use More Warbeads! for further stacks of 10. These turn-ins are repeatable, not daily.",
        "Continue kills and hand-ins until Exalted. Nagrand's faction quests are useful extra reputation. Give your beads to your faction's warden rather than the Consortium if this achievement is your immediate goal; the same stack cannot credit both.",
        "The achievement completes at Exalted; buying a mount is optional. The faction's eight regular talbuks then become available from " .. (alliance and "Trader Narasu in Telaar (54.5, 75.1)." or "Provisioner Nasela in Garadar (53.5, 36.9)."),
    }, {
        pin(107, 46, 23, 2, "Laughing Skull Ruins - ogres and warbeads"),
        pin(107, 29, 26, 2, "Warmaul Hill - ogre farming alternative"),
        pin(107, 49, 56, 2, "Southern Boulderfist cave"),
        pin(107, 40, 32, 2, "Northern Boulderfist cave"),
        pin(107, alliance and 54.8 or 55.8, alliance and 70.8 or 37.8, 3, "Faction warden - repeatable 10-bead hand-ins"),
        pin(107, alliance and 54.5 or 53.5, alliance and 75.1 or 36.9, 5, "Optional Exalted talbuk vendor"),
    })
end

-- https://www.wowhead.com/achievement=900#comments:id=1635428
-- Current quest NPC and no-reputation prerequisite retained from PetGuides.
add(900, "The Czar of Sporeggar", "Reputation", {
    "Set Dungeon Difficulty to NORMAL and travel to Coilfang Reservoir in Serpent Lake, Zangarmarsh (50.4, 40.9). Dive through the central pipe and surface in the entrance cavern.",
    "Enter The Underbog on the right (54.2, 34.5 on the Zangarmarsh map). Speak to T'shu just INSIDE and take Bring Me A Shrubbery! (29691). This current dungeon version does not require the old outdoor Sporeggar introduction.",
    "Pick Sanguine Hibiscus from the glowing red dungeon plants and loot it from bog creatures, bats and bosses. Herbalism is not required. Clear the opening bog section and check the path toward the naga bridge.",
    "Return to T'shu and hand in 5 flowers. Continue with Bring Me Another Shrubbery! (29692), 5 flowers for 750 base reputation per completion. Keep the items in your bags for the hand-in.",
    "Repeat until Sporeggar is Exalted. Leave and reset the Normal dungeon when more flowers are needed, or buy tradable Sanguine Hibiscus. At exactly Neutral, with no reputation bonuses or kill reputation, 280 flowers cover 42,000 reputation; check your standing before buying. Glowcaps are optional vendor currency, not the flowers needed for this grind.",
}, {
    pin(102, 50.4, 40.9, 1, "Coilfang Reservoir - central underwater pipe"),
    pin(102, 54.2, 34.5, 2, "Underbog - T'shu is inside"),
    pin(102, 54.2, 34.5, 4, "Return inside Underbog - repeatable hibiscus hand-ins"),
})

-- https://www.wowhead.com/achievement=902#comments:id=401030 and replies
-- Heroic trash-reset and Shaffar farming suggestions are not prerequisites.
add(902, "Chief Exalted Officer", "Reputation", {
    "Go to Area 52 in Netherstorm and find Nether-Stalker Khay'ji (32.4, 64.2). Follow his A Heap of Ethereals quest until Another Heap of Ethereals is available.",
    "Kill Zaxxis ethereals in The Heap southwest of Area 52, around 30, 75. Loot Zaxxis Insignias; each stack of 10 can be handed in to Khay'ji for 250 base Consortium reputation. Circle the camps and return to town with your stacks.",
    "Repeat the insignia hand-ins all the way to Exalted. Optional: at Friendly or above, follow the Consortium's Ethereum Prison quest introduction from Commander Ameer at the Protectorate Watch Post (59.5, 32.3) before using the keys you find.",
    "For a daily dungeon alternative, set Mana-Tombs to HEROIC and clear its trash and bosses. Its reputation gains continue to Exalted. Normal Mana-Tombs has an earlier reputation cap and cannot replace the full Exalted route.",
    "Keep doing insignia turn-ins between Heroic resets until Exalted. Obsidian Warbeads are another reputation source, but spend them on Kurenai/Mag'har first if you still need those reputations. No special title is awarded by Chief Exalted Officer.",
}, {
    pin(109, 32.4, 64.2, 1, "Nether-Stalker Khay'ji - unlock insignia turn-ins"),
    pin(109, 30, 75, 2, "The Heap - Zaxxis Insignias"),
    pin(109, 32.4, 64.2, 3, "Khay'ji - repeatable 10-insignia hand-ins"),
    pin(109, 59.5, 32.3, 3, "Optional: Commander Ameer - Ethereum Prison quest line"),
    pin(108, 39.63, 57.67, 4, "Heroic Mana-Tombs - Consortium reputation"),
})

-- https://www.wowhead.com/achievement=903#comments:id=1161050
add(903, "Shattrath Divided", "Reputation", {
    "In Shattrath's Terrace of Light, complete Khadgar's City of Light introduction and choose the Aldor OR the Scryers. This achievement needs Exalted with one side; both sides are required only for Hero of Shattrath.",
    "For Aldor, hand Marks of Kil'jaeden to Adyen the Lightwarden on Aldor Rise until Honored; then use Marks of Sargeras. Fel Armaments handed to High Priestess Ishanah are an alternative. Shadow Labyrinth's demons and Shadowmoon Valley's Legion camps supply Aldor items.",
    "For Scryers, give Firewing Signets to Magistrix Fyalenn on Scryer's Tier until Honored; then use Sunfury Signets. Arcane Tomes handed to Voren'thal the Seer are an alternative. Botanica and Netherstorm's blood elf camps supply Scryer items.",
    "Do your chosen faction's Netherstorm/Shadowmoon quests and repeat the eligible hand-ins until Exalted. Higher-rank marks/signets and the armament/tome hand-ins remain useful after Honored. Bought tradable turn-in items work; compare prices rather than assuming old comment prices still apply.",
}, {
    pin(111, 54.8, 44.3, 1, "Khadgar - introduction and faction choice"),
    pin(111, 30.8, 34.6, 2, "Aldor Rise - Adyen / Ishanah hand-ins"),
    pin(111, 45.0, 81.4, 3, "Scryer's Tier - Fyalenn / Voren'thal hand-ins"),
}, "Turn-ins increase your chosen faction and reduce the other. The two factions are not simultaneously Exalted through ordinary hand-ins.")

-- https://www.wowhead.com/achievement=1205#comments:id=344764
-- https://www.wowhead.com/achievement=1205#comments:id=5963977 and replies
-- https://www.wowhead.com/achievement=1205#comments:id=6281290 (2026)
add(1205, "Hero of Shattrath", "Reputation", {
    "On ONE character, reach Exalted with the Aldor or Scryers first. Use that faction's quest lines and marks/signets plus Fel Armaments or Arcane Tomes. Before switching, buy and learn any reputation recipes or tabard you still want from the first faction.",
    "To change from Scryers to Aldor, farm Dreadfang Venom Sacs from the spiders west/south of Allerian Stronghold and along Netherweb Ridge in Terokkar Forest. Give stacks of 8 to Sha'nir in Shattrath's Lower City (64.5, 15.1), starting Strained Supplies and continuing More Venom Sacs.",
    "To change from Aldor to Scryers instead, farm Dampscale Basilisk Eyes from Terokkar's Dampscale basilisks. Give stacks of 8 to Arcanist Adyria in Lower City (54.7, 22.1), starting Voren'thal's Visions and continuing More Basilisk Eyes. Use only the route toward your NEW faction.",
    "Keep doing the conversion hand-in until the DESIRED faction is Neutral. Watch its name carefully: stopping because the faction you are leaving says Neutral is a mistake noted in 2026 comments. From the bottom of Hated, 1,344 sacs/eyes is the unbuffed baseline; applicable reputation bonuses reduce it.",
    "When conversion turn-ins stop at Neutral, visit Khadgar in the Terrace of Light and take the new faction's introduction if offered. Then use Marks of Kil'jaeden/Firewing Signets until Honored and Marks of Sargeras/Sunfury Signets or Fel Armaments/Arcane Tomes onward to Exalted.",
    "Reach Exalted with the second faction on that SAME character. The game remembers the first Exalted standing; both need not be Exalted simultaneously. Old comments describing a short-lived two-character shortcut or claiming the feat was permanently removed are superseded by later confirmations.",
}, {
    pin(111, 30.8, 34.6, 1, "Aldor Rise - first Exalted faction option"),
    pin(111, 45.0, 81.4, 1, "Scryer's Tier - first Exalted faction option"),
    pin(108, 51, 73, 2, "Netherweb Ridge - Dreadfang spider farming area"),
    pin(111, 64.5, 15.1, 2, "Sha'nir - 8 Dreadfang Venom Sacs per hand-in"),
    pin(108, 46, 33, 3, "Terokkar waterways - Dampscale basilisk search area"),
    pin(111, 54.7, 22.1, 3, "Arcanist Adyria - 8 Dampscale Basilisk Eyes per hand-in"),
    pin(111, 54.8, 44.3, 5, "Khadgar - new faction introduction after Neutral"),
    pin(111, 30.8, 34.6, 5, "Aldor Rise - new faction reputation hand-ins"),
    pin(111, 45.0, 81.4, 5, "Scryer's Tier - new faction reputation hand-ins"),
}, "Conversion reduces your former standing. Do not use old Human racial or guild-perk item totals as a current shopping list; inspect your actual reputation gain.")

for _, route in ipairs({
    { 958, "Sworn to the Deathsworn", "Ashtongue Deathsworn", 104, 71, 46.5, "original Black Temple", "Clear the trash as well as every boss through Illidan. The old attunement chain is optional; ordinary dungeon runs do not grant this faction's reputation." },
    { 959, "The Scale of the Sands", "The Scale of the Sands", 75, 36, 16.1, "Battle for Mount Hyjal raid inside the Caverns of Time", "Start Jaina's two wave sequences, then Thrall's two sequences, and defeat Archimonde. Each wave's kills matter; do not skip straight to an empty boss marker." },
    { 960, "The Violet Eye", "The Violet Eye", 42, 46.87, 74.69, "original ground-level Karazhan raid", "Clear optional rooms and trash as well as the route through Opera, Curator, Chess and Prince Malchezaar. Legion's Return to Karazhan dungeon does not substitute for the original raid." },
}) do
    local raidID = route[1] == 958 and 697 or route[1] == 959 and 695 or 690
    local points = { pin(route[4], route[5], route[6], 1, route[7] .. " entrance", route[4] == 75 and "Caverns of Time" or nil) }
    for _, point in ipairs(raidInteriors[raidID]) do
        points[#points + 1] = pin(point.mapID, point.x * 100, point.y * 100, 2, point.label, point.mapName)
    end
    add(route[1], route[2], "Reputation", {
        "Travel to the " .. route[7] .. " at the mapped entrance. Use the character whose " .. route[3] .. " reputation you are raising.",
        route[8],
        "Repeat the full clear after each weekly raid reset until " .. route[3] .. " is Exalted. Killed bosses stay saved for the week; Reset All Instances does not create another full set of boss reputation.",
        "Use applicable reputation buffs while actually earning the reputation. The number of clears depends on your starting standing, optional trash and bonuses; the old comments' exact run counts are estimates.",
    }, points)
end

-- https://www.wowhead.com/achievement=897#comments:id=1673754 and reply
add(897, "You're So Offensive", "Reputation", {
    "Take Shattrath's portal (48.9, 42.1) to the ORIGINAL Isle of Quel'Danas. This reputation route uses the old island and original Magisters' Terrace, not Midnight's replacement content.",
    "Set Dungeon Difficulty to NORMAL and clear original Magisters' Terrace (61.2, 30.9), killing all reputation-awarding trash and the four bosses. Exit using the orb after Kael'thas, reset outside and repeat. Normal runs are repeatable and can finish the reputation.",
    "For variety, take Shattered Sun daily quests around Sun's Reach Harbor: the bloodberry collection, Dawnblade kills, Greengill murloc rescue and ley-line survey can be combined on one circuit. Complete their listed objectives before returning to the harbor.",
    "Continue dungeon clears and available dailies to Shattered Sun Offensive Exalted. A daily Heroic Terrace clear also offers the mount chance. The achievement itself does not grant the title: A Magnanimous Benefactor, offered at Exalted, is a separate optional 1,000-gold donation.",
}, {
    pin(111, 48.9, 42.1, 1, "Portal to original Isle of Quel'Danas"),
    pin(122, 61.2, 30.9, 2, "Original Magisters' Terrace - repeat Normal reputation runs"),
    pin(348,8.61,50.20,2,"Kael'thas - finish the original Terrace clear and use the exit orb","Magisters' Terrace - Grand Magister's Asylum"),
    pin(122, 48.4, 35.2, 3, "Sun's Reach Harbor - daily quest hub"),
}, "There is no need to wait for the rare mount to drop before finishing the reputation, or to pay the title donation for this achievement.")

-- Preserve the more detailed, already researched mount routes for achievements
-- earned by obtaining that same mount. Both page types were reviewed.
for _, link in ipairs({
    { 882, 36702, "Fiery Warhorse's Reins" },
    { 883, 41252, "Reins of the Raven Lord" },
    { 884, 46628, "Swift White Hawkstrider" },
    { 885, 40192, "Ashes of Al'ar" },
    { 893, 43927, "Cenarion War Hippogryph" },
}) do
    local mount = TDP.CollectionWalkthroughs.mounts[link[2]]
    if mount then
        local guide = {}
        for key, value in pairs(mount) do guide[key] = value end
        guide.achievementId, guide.name = link[1], link[3]
        guide.sourceType = "Achievement"
        guide.wowheadUrl = "https://www.wowhead.com/achievement=" .. link[1]
        guide.sourceURL = guide.wowheadUrl .. "#comments"
        guide.tips = (mount.tips or "") .. " Obtain and learn the mount on this account. The feat may trigger when the reins are looted; its Feat of Strength category does not mean this mount has been removed."
        guides[link[1]] = guide
    end
end

-- https://www.wowhead.com/achievement=426#comments:id=2490351
-- Its Timewalking instructions are a separate transmog objective, not this
-- feat's requirement. 2026 item comments still require equipping BOTH swords.
add(426, "Warglaives of Azzinoth", "Collections", {
    "Choose ONE character who can equip both original Warglaive of Azzinoth swords at the same time: Warrior, Rogue, Death Knight, Monk or Demon Hunter. Select a dual-wielding specialization where necessary. Merely learning an appearance or looting the blades on an ineligible class does not award this feat.",
    "Enter original Black Temple through the wall breach at 71.0, 46.5 in Outland Shadowmoon Valley. Clear through the Illidari Council, speak to Akama and defeat Illidan, including both Flames of Azzinoth during his airborne phase.",
    "Loot Illidan for the MAIN-HAND blade (32837) and OFF-HAND blade (32838). They are separate random drops; two copies of one hand do not make a set. Keep the first blade and return on the same character after each weekly reset for the other.",
    "Equip both blades simultaneously on that character to earn Warglaives of Azzinoth. One blade on each of two alts does not satisfy the feat.",
    "Optional Demon Hunter appearance: after this feat is complete, defeat Illidan during the separate Black Temple TIMEWALKING event for I'll Hold These For You Until You Get Out and use its Arsenal reward. That event is not needed for the original two-blade feat, and the Timewalking kill need not be on a Demon Hunter.",
}, { pin(104, 71.0, 46.5, 2, "Original Black Temple entrance"), pin(346,52.77,70.46,3,"Illidan - main-hand and off-hand blade drops","Black Temple - Temple Summit") },
"The original blades are classified as one-handed swords. The special Demon Hunter transmog unlock and this equipment feat are distinct achievements.")

-- https://www.wowhead.com/achievement=725#comments:id=802643 and replies
-- https://www.wowhead.com/achievement=725#comments:id=1629685
add(725, "Thori'dal, the Stars' Fury", "Collections", {
    "Use a character who can EQUIP a bow: Hunter, Rogue or Warrior. Looting Thori'dal on a class that cannot wield it does not award this equipment feat.",
    "Take Shattrath's portal at 48.9, 42.1 to the original Isle of Quel'Danas. Enter Sunwell Plateau at 44.3, 45.7 and follow the raid route through Brutallus, Felmyst, the Twins and M'uru/Entropius.",
    "Kill the three Hand of the Deceiver enemies to release Kil'jaeden, then defeat and loot him. Thori'dal (34334) is a random drop from this final boss, not a quest reward or a drop from Magisters' Terrace.",
    "Equip the bow to complete the feat. If it does not drop, return after the weekly raid reset or try another eligible bow-using character. A different class's appearance collection does not replace actually equipping it.",
}, {
    pin(111, 48.9, 42.1, 2, "Portal to original Isle of Quel'Danas"),
    pin(122, 44.28, 45.71, 2, "Sunwell Plateau - weekly Kil'jaeden bow chance"),
    pin(336,46,61.69,3,"Kil'jaeden - loot Thori'dal","Sunwell Plateau - Shrine of the Eclipse"),
})

-- https://www.wowhead.com/achievement=1165#comments:id=5532489
add(1165, "My Storage is \"Gigantique\"", "Collections", {
    "Bring 1,200 gold and go to Haris Pilton in the World's End Tavern in Shattrath's Lower City (75.5, 30.5).",
    "Buy the exact item \"Gigantique\" Bag (38082). Portable Hole, ordinary larger bags and profession/reagent bags do not substitute for it.",
    "Empty one of your character's ordinary equipped bag slots and equip the Gigantique bag there. Owning it in your backpack or using it as a bank bag does not meet the objective. Equipping binds it; do not plan to pass it around or obtain a full vendor refund afterwards.",
}, { pin(111, 75.5, 30.5, 1, "Haris Pilton - World's End Tavern; 1,200-gold bag") })

for _, id in ipairs({ 1284, 1287 }) do
    local heroic = id == 1287
    local points = {}
    local groupStep = { [100] = 2, [102] = 3, [108] = 4, [109] = 5, [75] = 6, [122] = 7 }
    for _, dungeon in ipairs(dungeons) do
        points[#points + 1] = pin(dungeon[4], dungeon[5], dungeon[6], groupStep[dungeon[4]], dungeon[3] .. " entrance", dungeon[4] == 75 and "Caverns of Time" or nil)
        for _, point in ipairs(dungeonInteriors[dungeon[1]] or {}) do
            points[#points + 1] = pin(point.mapID, point.x * 100, point.y * 100, groupStep[dungeon[4]], point.label, point.mapName)
        end
    end
    points[#points + 1] = pin(102, 50.4, 40.9, 3, "Coilfang Reservoir - underwater approach")
    points[#points + 1] = pin(111, 48.9, 42.1, 7, "Portal to original Isle of Quel'Danas")
    add(id, heroic and "Outland Dungeon Hero" or "Outland Dungeonmaster", "Dungeons", {
        (heroic and "Set Dungeon Difficulty to HEROIC before entering each dungeon. " or "Normal or Heroic clears count; choosing Heroic also advances Outland Dungeon Hero. ") .. "Complete all 16 original Burning Crusade dungeon achievements. Keys, reputation attunements and a prior Normal Magisters' Terrace clear are no longer required.",
        "Hellfire Peninsula: clear Hellfire Ramparts, The Blood Furnace and The Shattered Halls in Hellfire Citadel. On Heroic Ramparts, defeat both Omor and the Vazruden/Nazan encounter.",
        "Zangarmarsh: dive through the central pipe in Serpent Lake and clear Slave Pens, Underbog and Steamvault. In Steamvault, activate BOTH control panels after the first two bosses to unlock the last room.",
        "Terokkar Forest: visit all four Auchindoun entrances: Mana-Tombs north, Auchenai Crypts west, Sethekk Halls east and Shadow Labyrinth south. Anzu alone does not finish Sethekk Halls; continue to Ikiss.",
        "Netherstorm: fly to the three Tempest Keep satellite dungeons: Mechanar, Botanica and Arcatraz. The central Eye raid is separate. Mechanar's gatewatchers and Arcatraz's final prison event must be completed to reach their final bosses.",
        "Caverns of Time, Tanaris: complete Old Hillsbrad's Thrall escort through Epoch Hunter and all 18 rifts of Black Morass through Aeonus. The achievements call these The Escape From Durnholde and Opening of the Dark Portal.",
        "Take Shattrath's portal to original Isle of Quel'Danas and clear original Magisters' Terrace through Kael'thas. Check the meta's remaining child achievements before leaving; Midnight's newer instance does not replace this original clear.",
    }, points)
end

add(1286, "Outland Raider", "Raids", {
    "Track this meta and complete its eight original raid kill achievements. Karazhan, Hyjal and Sunwell count even though their entrances are on Azeroth. Original Zul'Aman was removed from the requirements; its later five-player remake is not needed.",
    "In Outland, clear Gruul's Lair in Blade's Edge Mountains and Magtheridon's Lair at ground level on the western side of Hellfire Citadel. Kill Gruul and Magtheridon, not only their opening council/channelers.",
    "In Zangarmarsh, swim through Coilfang Reservoir's central pipe and kill Lady Vashj in Serpentshrine Cavern. In Netherstorm, enter the CENTRAL Tempest Keep structure, The Eye, and kill Kael'thas.",
    "In Outland Shadowmoon Valley, clear original Black Temple through Illidan. Speak to Akama when needed to advance the summit event.",
    "In Deadwind Pass, enter original ground-level Karazhan, complete Opera and Chess, then kill Prince Malchezaar. Legion's Return to Karazhan dungeon is separate.",
    "Inside the Caverns of Time in Tanaris, enter Battle for Mount Hyjal. Complete Jaina's and Thrall's wave sequences and defeat Archimonde.",
    "Take Shattrath's portal to original Isle of Quel'Danas and clear Sunwell Plateau through Kil'jaeden. Check all eight child achievements; you need not earn them in a particular order or on one weekly lockout.",
}, {
    pin(105, 69.31, 23.67, 2, "Gruul's Lair"), pin(100, 46.5, 52.9, 2, "Magtheridon's Lair - ground-level western doorway"),
    pin(102, 50.4, 40.9, 3, "Coilfang Reservoir - Serpentshrine Cavern approach"), pin(109, 73.73, 63.71, 3, "The Eye - central Tempest Keep raid"),
    pin(104, 71, 46.5, 4, "Black Temple - wall breach"), pin(42, 46.87, 74.69, 5, "Original Karazhan raid"),
    pin(75, 36, 16.1, 6, "Battle for Mount Hyjal", "Caverns of Time"),
    pin(111, 48.9, 42.1, 7, "Portal to original Isle of Quel'Danas"), pin(122, 44.28, 45.71, 7, "Sunwell Plateau"),
    pin(330,19.95,28.31,2,"Gruul - final encounter","Gruul's Lair"),
    pin(331,69.18,74.31,2,"Magtheridon - final encounter","Magtheridon's Lair"),
    pin(332,72.26,58.92,3,"Lady Vashj - final encounter","Serpentshrine Cavern"),
    pin(334,50.10,13.85,3,"Kael'thas - final encounter","The Eye"),
    pin(346,52.77,70.46,4,"Illidan - final encounter","Black Temple - Temple Summit"),
    pin(366,51.44,30.92,5,"Prince Malchezaar - final encounter","Karazhan - Netherspace"),
    pin(329,77.28,28.31,6,"Archimonde - final encounter","Hyjal Summit"),
    pin(336,46,61.69,7,"Kil'jaeden - final encounter","Sunwell Plateau - Shrine of the Eclipse"),
})

-- Exploration coordinates were compared with the comment replies. Corrections
-- include Stair of Destiny (862), Bleeding Hollow Ruins/Veil Rhaze (867),
-- Tel'athion's Camp and Middenvale (861). These are ORIGINAL Retail maps.
local exploration = {
    { 862, "Hellfire Peninsula", 100, 1659711, {
        {84.3,52.9,"The Stair of Destiny"}, {69,53,"The Legion Front"}, {69,71,"Zeth'Gor"}, {76,71,"Void Ridge"},
        {54,83,"Expedition Armory"}, {45,83,"Warp Fields"}, {29,74,"Den of Haal'esh"}, {27,61,"Falcon Watch"},
        {15,60,"Ruins of Sha'naar"}, {22,40,"Temple of Telhamat"}, {14,42,"Fallen Sky Ridge"}, {32,28,"Mag'har Post"},
        {42,31,"Pools of Aggonar"}, {49,50,"Hellfire Citadel"}, {55,63,"Honor Hold"}, {56,37,"Thrallmar"},
        {64,31,"Forge Camp: Mageddon"}, {63,18,"Throne of Kil'jaeden"},
    } },
    { 863, "Zangarmarsh", 102, 640341, {
        {79,64,"Cenarion Refuge"}, {83,82,"Umbrafen Village"}, {70,80,"Darkcrest Shore"}, {58,62,"The Lagoon"},
        {46,63,"Feralfen Village"}, {29,61,"Quagg Ridge"}, {14,62,"The Spawning Glen"}, {18,50,"Sporeggar"},
        {22,40,"Marshlight Lake"}, {17,23,"Ango'rosh Grounds"}, {18,7,"Ango'rosh Stronghold"}, {29,33,"Hewn Bog"},
        {31,50,"Zabra'jin"}, {42,30,"Orebor Harborage"}, {47,53,"Twin Spire Ruins"}, {61,41,"Bloodscale Grounds"},
        {68,48,"Telredor"}, {81,38,"The Dead Mire"},
    } },
    { 864, "Shadowmoon Valley", 104, 427646, {
        {29.2,28.7,"Shadowmoon Village"}, {23.3,38.2,"Legion Hold"}, {29.5,55.3,"Illidari Point"},
        {35.8,58,"Wildhammer Stronghold"}, {46.1,68.9,"Eclipse Point"}, {64.2,57.6,"Netherwing Fields"},
        {70.5,85.4,"Netherwing Ledge"}, {60.1,48.7,"Warden's Cage"}, {67,50,"The Black Temple - explore outdoor Ruins of Karabor"},
        {61.7,29.1,"Altar of Sha'tar"}, {45.5,28.3,"Coilskar Point"}, {50,40.5,"The Hand of Gul'dan"}, {41,32,"The Deathforge - outdoor northern approach"},
    } },
    { 865, "Blade's Edge Mountains", 105, 411962, {
        {37,64,"Sylvanaar"}, {35,76,"Veil Lashh"}, {28,81,"Forge Camp: Terror"}, {30,64,"Vortex Summit"},
        {40,53,"Bladespire Hold"}, {46,77,"Bloodmaul Outpost"}, {49,70,"Jagged Ridge"}, {52,56,"Thunderlord Stronghold"},
        {64,67,"Death's Door"}, {71,61,"Vekhaar Stand"}, {76,60.3,"Mok'Nathal Village"}, {65,53,"Razor Ridge"},
        {70,42,"Bladed Gulch"}, {73,41,"Forge Camp: Anger"}, {77,24,"Broken Wilds"}, {72,23,"Skald"},
        {65,24,"Gruul's Lair - outdoor area"}, {64,14,"Crystal Spine"}, {52,12,"Bash'ir Landing"}, {39,20,"Grishnath"},
        {31,28,"Raven's Wood"}, {33,40,"Forge Camp: Wrath"}, {53,43,"Circle of Blood"}, {55,27,"Bloodmaul Camp"},
        {62,34,"Ruuan Weald"}, {64,31,"Veil Ruuan"},
    } },
    { 866, "Nagrand", 107, 427617, {
        {72.7,52.6,"Windyreed Village"}, {72.6,36.6,"Windyreed Pass"}, {56,36.3,"Garadar"}, {60.2,23.1,"Throne of the Elements"},
        {46.7,19.4,"Laughing Skull Ruins"}, {33.4,15.6,"Zangar Ridge"}, {27,21.1,"Warmaul Hill"}, {24.6,35.9,"Forge Camp: Hate"},
        {8.6,43.1,"The Twilight Ridge"}, {19.1,51.5,"Forge Camp: Fear"}, {31.6,43.1,"Sunspring Post"}, {42.7,44,"Halaa"},
        {49.4,55.5,"Southwind Cleft"}, {36,71.4,"Spirit Fields"}, {53.7,70.6,"Telaar"}, {62,63.8,"Clan Watch"},
        {70,81.5,"Kil'sorrow Fortress"}, {74.4,66.9,"Burning Blade Ruins"}, {65.9,56.1,"The Ring of Trials"},
    } },
    { 867, "Terokkar Forest", 108, 5204735, {
        {23.3,11.3,"The Barrier Hills - above Shattrath"}, {30,23,"Shattrath City"}, {44.1,21.8,"Cenarion Thicket"},
        {54.9,19.9,"Razorthorn Shelf"}, {52.5,29.8,"Tuurem"}, {59.6,42.7,"Raastok Glade"}, {71.3,37.4,"Firewing Point"},
        {49.9,45.4,"Stonebreaker Hold"}, {39.4,41.4,"Grangol'var Village"}, {36.9,50.2,"Refugee Caravan"},
        {31.1,52.7,"Shadow Tomb"}, {27.1,56.4,"Veil Rhaze"}, {20,63.5,"Bleeding Hollow Ruins"}, {33.7,71,"Auchenai Grounds"},
        {37.3,67.1,"Ring of Observance - inner Auchindoun ring"}, {43.3,51.3,"Carrion Hill"}, {48.7,67.1,"Writhing Mound"},
        {43.6,76.1,"Derelict Caravan"}, {57.4,53.9,"Allerian Stronghold"}, {65.1,54.8,"Bonechewer Ruins"}, {72.2,82.7,"Skettis"},
    } },
    { 843, "Netherstorm", 109, 411960, {
        {22,56,"Gyro-Plank Bridge"}, {32,56,"Ruins of Enkaat"}, {33,65,"Area 52"}, {22,70,"Manaforge B'naar"},
        {31,76,"The Heap"}, {40,75,"Arklon Ruins"}, {48,84,"Manaforge Coruu"}, {56,85,"Kirin'Var Village"},
        {56,78,"Sunfury Hold"}, {59,67,"Manaforge Duro"}, {71,65,"Tempest Keep - outdoor exploration area"},
        {72,40,"Celestial Ridge"}, {62,39,"Manaforge Ultris"}, {55,42,"Ethereum Staging Grounds"}, {45,54,"Eco-Dome Midrealm"},
        {44,36,"The Stormspire"}, {26,38,"Manaforge Ara"}, {29,15,"Socrethar's Seat"}, {37,25,"Forge Base: Oblivion"},
        {45,13,"Eco-Dome Farfield"}, {49,18,"Netherstone"}, {54,25,"Ruins of Farahlon"},
    } },
    { 858, "Ghostlands", 95, 1628050, {
        {48.9,92.6,"Thalassian Pass"}, {34.6,76.1,"Deatholme"}, {13.2,57.4,"Windrunner Spire"},
        {18.7,43.2,"Windrunner Village"}, {25.8,15,"Goldenmist Village"}, {34.3,34.1,"Sanctum of the Moon"},
        {34.3,47.8,"Bleeding Ziggurat"}, {40.4,49.5,"Howling Ziggurat"}, {45.4,28.5,"Tranquillien"},
        {48.4,11.5,"Elrendar Crossing"}, {62.9,12.8,"Suncrown Village"}, {78.3,19.8,"Dawnstar Spire"},
        {72.5,34.1,"Farstrider Enclave"}, {54.4,50.3,"Sanctum of the Sun"}, {64.8,61.6,"Zeb'Nowa"}, {68.6,63.2,"Amani Pass"},
    } },
    { 859, "Eversong Woods (Burning Crusade)", 94, 456243, {
        {36,85,"The Scorched Grove"}, {25,81,"Golden Strand"}, {32,78,"Goldenbough Pass"}, {32,69,"Sunsail Anchorage"},
        {27,60,"Tranquil Shore"}, {35,59,"West Sanctum"}, {37,73,"Saltheril's Haven"}, {43,71,"Fairbreeze Village"},
        {53,70,"East Sanctum"}, {58,72,"The Living Wood"}, {43,86,"Runestone Falithas"}, {55,84,"Runestone Shan'dor"},
        {62,79,"Zeb'Watha"}, {65,81,"Lake Elrendar - cross the islands"}, {70,75,"Tor'Watha"}, {64,73,"Elrendar Falls"},
        {60,62,"Farstrider Retreat"}, {68,47,"Duskwither Grounds"}, {72,43,"Azurebreeze Coast"}, {62,53,"Thuron's Livery"},
        {55,54,"Stillwhisper Pond"}, {44,53,"North Sanctum"}, {44,36,"Ruins of Silvermoon"}, {36,27,"Sunstrider Isle"},
        {56,48,"Silvermoon City - pass through the outer gateway"},
    } },
    { 860, "Azuremyst Isle", 97, 400841, {
        {23,53,"Valaar's Berth - where the dock meets land"}, {31,40,"The Exodar"}, {34,12,"Silting Shore"},
        {42.5,6,"Fairbridge Strand"}, {45,20,"Stillpine Hold"}, {58,17,"Emberglade"}, {52,42,"Moongraze Woods"},
        {49,50,"Azure Watch"}, {62,54,"Ammen Ford"}, {77,43,"Ammen Vale"}, {53,61,"Pod Wreckage"},
        {59,68,"Geezle's Camp"}, {46,71,"Odesyus' Landing"}, {37,62,"Pod Cluster"}, {26,66,"Bristlelimb Village"},
        {32,77,"Wrathscale Point"}, {13,80,"Silvermyst Isle"},
    } },
    { 861, "Bloodmyst Isle", 106, 378611, {
        {62.1,89,"Kessel's Crossing"}, {66.1,78.8,"Bristlelimb Enclave"}, {57.8,81.6,"The Lost Fold"},
        {52.7,71.5,"Middenvale"}, {42.5,84.1,"Mystwood"}, {38.6,79,"Nazzivian"}, {31.8,87,"Blacksilt Shore"},
        {39.1,61.4,"The Cryo-Core"}, {18.2,51.5,"The Vector Coil"}, {30.2,45.9,"Vindicator's Rest"},
        {25.9,41.2,"Tel'athion's Camp - small tent beside the red river"}, {22.8,37.4,"Amberweb Pass"}, {29.4,36.7,"The Foul Pool"},
        {34.1,23,"The Hidden Reef"}, {38.9,20.9,"The Bloodwash"}, {53.2,16,"The Warp Piston"},
        {42,30.4,"Axxarien"}, {46.4,45.6,"Bladewood"}, {54.6,55.3,"Blood Watch"}, {55.3,35.4,"Ragefeather Ridge"},
        {61.7,44.6,"Ruins of Loreth'Aran"}, {71.4,16.3,"Wyrmscar Island"}, {74.5,9.2,"Veridian Point"},
        {73.1,20.9,"Talon Stand"}, {80.5,26.4,"The Bloodcursed Reef"}, {66,49.5,"The Crimson Reach"},
        {69,67.6,"Wrathscale Lair"}, {85,51,"Bloodcurse Isle"},
    } },
    { 868, "Isle of Quel'Danas", 122, 401631, {
        {54,33,"Sun's Reach Harbor"}, {41,32,"Dawnstar Village"}, {40,45,"Sunwell Plateau - outdoor area"},
        {53,84,"The Dead Scar"}, {63,48,"Greengill Coast"}, {60,30,"Magisters' Terrace - outdoor area"},
    } },
}

for _, zone in ipairs(exploration) do
    local oldQuelThalas = zone[1] == 858 or zone[1] == 859
    local intro = "Track the achievement and visit each unchecked subzone below. These are exploration trigger areas, not instance entrances; wait for the named criterion to credit, and move a little closer to the ground or within the area if needed."
    if oldQuelThalas then
        intro = "Go to Zidormi at the northern Eastern Plaguelands border (53.8, 8.6) and choose the Burning Crusade version of Eversong Woods and Ghostlands, then cross the old portal ON FOOT. Use the ORIGINAL maps (#94/#95), not Midnight's Eversong map. Travel by ground mount in the old zones and track each exploration criterion."
    elseif zone[1] == 868 then
        intro = "Take Shattrath's portal at 48.9, 42.1 to the ORIGINAL Isle of Quel'Danas (#122). The achievement may credit immediately on arrival; if it does not, visit the unchecked locations below. Midnight's new island is a separate map."
    elseif zone[3] == 104 or zone[3] == 107 then
        intro = "Travel to " .. zone[2] .. " in OUTLAND, not Draenor. Use a flying mount and track the achievement. Visit each unchecked exploration area below; an already revealed map does not prove every criterion is complete."
    elseif zone[3] == 97 or zone[3] == 106 then
        intro = "Reach the ORIGINAL draenei starting islands and use a ground mount. Bloodmyst is north of Azuremyst across the bridge. Track the achievement; the named criteria, rather than the amount of visible map, determine completion."
    end
    local steps, points = { intro }, {}
    if oldQuelThalas then points[#points + 1] = pin(23, 53.8, 8.6, 1, "Zidormi - choose original Burning Crusade Quel'Thalas") end
    if zone[1] == 868 then points[#points + 1] = pin(111, 48.9, 42.1, 1, "Portal to original Isle of Quel'Danas") end
    -- Small geographic groups keep the text readable and leave every pin
    -- carrying the step number that actually mentions its destination.
    for start = 1, #zone[5], 3 do
        local places, step = {}, #steps + 1
        for index = start, math.min(start + 2, #zone[5]) do
            local place = zone[5][index]
            places[#places + 1] = string.format("%s (%.1f, %.1f)", place[3], place[1], place[2])
            points[#points + 1] = pin(zone[3], place[1], place[2], step, place[3], oldQuelThalas and (zone[2] .. " - original") or nil)
        end
        local instruction = "Explore " .. table.concat(places, "; ") .. ". Skip any location already credited in your achievement."
        if zone[1] == 858 and start == 1 then
            instruction = instruction .. " At Windrunner Spire, walk up to and inside the tower if the outdoor approach does not trigger discovery."
        elseif zone[1] == 861 then
            if start == 13 then instruction = instruction .. " The Hidden Reef is the murloc cove on the northwest coast; enter the shoreline water." end
            if start == 25 then instruction = instruction .. " The Bloodcursed Reef is offshore among the sunken boats east of Wyrmscar Island, separate from Bloodcurse Isle. These reefs may have no obvious unexplored-map shading." end
        end
        steps[#steps + 1] = instruction
    end
    steps[#steps + 1] = "Check the achievement's remaining names before leaving. Exploration is credited by entering the correct outdoor area, not by killing its inhabitants or entering a similarly named dungeon. Hostile towns may flag the opposing faction for PvP; approach only far enough to receive exploration credit."
    add(zone[1], "Explore " .. zone[2], "Exploration", steps, points, nil, {
        "https://www.wowhead.com/achievement=" .. zone[1] .. "#comments:id=" .. zone[4],
        oldQuelThalas and "https://www.wowhead.com/npc=259326/zidormi"
            or zone[1] == 861 and "https://www.wowhead.com/achievement=861#comments:id=1619862" or nil,
    })
end

add(44, "Outland Explorer", "Exploration", {
    "Use a flying mount in OUTLAND. This meta needs its seven original Outland zone exploration achievements; the similarly named Nagrand and Shadowmoon zones on Draenor are separate.",
    "Explore Hellfire Peninsula and Zangarmarsh, checking their individual subzone lists. In Hellfire, include the Stair of Destiny by the Dark Portal and the elevated Throne of Kil'jaeden.",
    "Explore Terokkar Forest and Outland Nagrand. Terokkar's Barrier Hills above Shattrath, the narrow Ring of Observance and the Skettis plateau are common final gaps.",
    "Explore Blade's Edge Mountains and Netherstorm, including the elevated western/northern plateaus and Socrethar's floating island. Flying avoids the old comments' difficult ground-jump workarounds.",
    "Explore Outland Shadowmoon Valley, including Netherwing Ledge and the OUTDOOR Black Temple area. Open each missing child achievement's route for all of its individual locations; revealing the main zone alone does not complete it.",
}, {
    pin(100, 84.3, 52.9, 2, "Hellfire Peninsula - Stair of Destiny"), pin(102, 79, 64, 2, "Zangarmarsh - Cenarion Refuge"),
    pin(100,63,18,2,"Hellfire Peninsula - elevated Throne of Kil'jaeden"),
    pin(108, 23.3, 11.3, 3, "Terokkar - Barrier Hills"), pin(107, 60.2, 23.1, 3, "Outland Nagrand - Throne of the Elements"),
    pin(108,37.3,67.1,3,"Terokkar - inner Ring of Observance"), pin(108,72.2,82.7,3,"Terokkar - Skettis plateau"),
    pin(105, 52, 12, 4, "Blade's Edge - Bash'ir Landing"), pin(109, 29, 15, 4, "Netherstorm - Socrethar's Seat"),
    pin(105,30,64,4,"Blade's Edge - western Vortex Summit plateau"),
    pin(104, 70.5, 85.4, 5, "Outland Shadowmoon - Netherwing Ledge"),
    pin(104,67,50,5,"Outland Shadowmoon - outdoor Black Temple / Ruins of Karabor"),
})

-- Separate vendor comments on all four pages agree with the existing
-- 12-Mark ensemble route. Refund-timer corrections are retained.
for _, set in ipairs({
    { 11706, "The Original", "Gladiator", "Kezzik the Striker", 2477596 },
    { 11707, "No Mercy", "Merciless Gladiator", "Izzee the 'Clutch'", 2477567 },
    { 11708, "With a Vengeance", "Vengeful Gladiator", "Kitzie Crankshot", 2477571 },
    { 11709, "Tough Threads", "Brutal Gladiator", "Blaze Magmaburn", 2477573 },
}) do
    add(set[1], set[2], "Collections", {
        "Use a character with an original Burning Crusade class armor set and collect 12 Marks of Honor. These are the item currency from PvP rewards, not the Honor points on the currency tab. No original season rating or title is required.",
        "Visit " .. set[4] .. " inside Area 52's PvP-vendor building in Netherstorm (33.0, 64.2). Buy the " .. set[3] .. " ARMOR Ensemble for your class. A weapon Arsenal does not finish the armor-set achievement.",
        "Use the Ensemble from your bags to permanently learn the complete set. If you already own most appearances, compare the price of the individual missing pieces before buying the ensemble; the full eight-piece individual purchase costs more than 12 Marks.",
        "Check the achievement after learning the set. For individual refundable purchases, wait for the refund timer to expire or permanently bind the items before expecting credit. Do not return them for a refund and assume the appearance remains collected.",
    }, { pin(109, 33.0, 64.2, 2, set[4] .. " - " .. set[3] .. " armor Ensemble") },
    "Monks, Death Knights, Demon Hunters and Evokers have no original Burning Crusade class tier; use an eligible original class to collect its class set.", {
        "https://www.wowhead.com/achievement=" .. set[1] .. "#comments:id=" .. set[5],
    })
end

local appearanceSets = {
    { 11746, "Outlandish Style", "Tier 4", {
        "In original Karazhan, defeat The Curator for gloves and Prince Malchezaar for the helm. Follow the Opera and Chess events to reach the Prince; the Legion dungeon does not replace this raid.",
        "In Gruul's Lair, kill High King Maulgar for shoulders and Gruul for legs. Kill Magtheridon in his separate Hellfire Citadel raid for the chest token.",
    }, {
        pin(42,46.87,74.69,2,"Original Karazhan - helm / gloves and matching pieces"),
        pin(358,49.49,36.62,2,"The Curator - glove tokens","Karazhan - The Menagerie"),
        pin(363,35.95,61.69,2,"Chess Event - open the Prince's route","Karazhan - Gamesman's Hall"),
        pin(366,51.44,30.92,2,"Prince Malchezaar - helm tokens","Karazhan - Netherspace"),
        pin(105,69.31,23.67,3,"Gruul's Lair - shoulders / legs"),
        pin(330,55.03,57.08,3,"High King Maulgar - shoulder tokens","Gruul's Lair"),
        pin(330,19.95,28.31,3,"Gruul - leg tokens","Gruul's Lair"),
        pin(100,46.5,52.9,3,"Magtheridon's Lair - chest"),
        pin(331,69.18,74.31,3,"Magtheridon - chest tokens","Magtheridon's Lair"),
    }, 2479713 },
    { 11747, "Merely a Set", "Tier 5", {
        "In Serpentshrine Cavern, kill Lady Vashj for the helm, Leotheras the Blind for gloves and Fathom-Lord Karathress for legs. The entrance is through Coilfang Reservoir's underwater pipe in Zangarmarsh.",
        "In The Eye, the central Tempest Keep raid in Netherstorm, kill Void Reaver for shoulders and Kael'thas for the chest. Loot trash as well: some matching set slots come from non-tier drops or crafted items.",
    }, {
        pin(102,50.4,40.9,2,"Serpentshrine approach - helm / gloves / legs"),
        pin(332,72.26,58.92,2,"Lady Vashj - helm tokens","Serpentshrine Cavern"),
        pin(332,41.79,25.54,2,"Leotheras - glove tokens","Serpentshrine Cavern"),
        pin(332,50.41,17.69,2,"Karathress - leg tokens","Serpentshrine Cavern"),
        pin(109,73.73,63.71,3,"The Eye - shoulders / chest"),
        pin(334,26.41,49.07,3,"Void Reaver - shoulder tokens","The Eye"),
        pin(334,50.10,13.85,3,"Kael'thas - chest tokens","The Eye"),
    }, 2479718 },
    { 11748, "Black is the New Black", "Tier 6 / Black Temple", {
        "In Battle for Mount Hyjal inside the Caverns of Time, finish the camp waves and kill Azgalor for gloves and Archimonde for the helm. Outdoor Cataclysm Hyjal is the wrong map.",
        "In original Black Temple, kill Mother Shahraz for shoulders, the Illidari Council for legs and Illidan for the chest. This appearance set combines Hyjal and Black Temple; the three later Sunwell tier extensions belong to a separate appearance achievement.",
    }, {
        pin(75,36,16.1,2,"Battle for Mount Hyjal - helm / gloves","Caverns of Time"),
        pin(329,35.74,37.85,2,"Azgalor - glove tokens","Hyjal Summit"),
        pin(329,77.28,28.31,2,"Archimonde - helm tokens","Hyjal Summit"),
        pin(104,71,46.5,3,"Black Temple - shoulders / legs / chest"),
        pin(344,67.54,36.77,3,"Mother Shahraz - shoulder tokens","Black Temple - Den of Mortal Delights"),
        pin(345,47.33,43.85,3,"Illidari Council - leg tokens","Black Temple - Chamber of Command"),
        pin(346,52.77,70.46,3,"Illidan - chest tokens","Black Temple - Temple Summit"),
    }, 2479720 },
    { 11749, "Suns Out, Thori'dals Out", "Sunwell Plateau", {
        "Take Shattrath's portal to the original Isle of Quel'Danas and enter Sunwell Plateau. Kill the raid bosses and loot their armor as well as the Forgotten tier-extension tokens.",
        "Sunwell tokens cover wrist, waist and feet: Kalecgos drops bracers, Brutallus belts, Felmyst boots, and the Eredar Twins can supply those tokens too. The other displayed Sunwell appearance slots come from boss drops or crafted items; collecting only the three tokens is not a full appearance set.",
    }, {
        pin(111,48.9,42.1,2,"Portal to original Isle of Quel'Danas"),
        pin(122,44.28,45.71,2,"Sunwell Plateau - armor and extension tokens"),
        pin(335,30.62,51.08,3,"Kalecgos - bracer tokens","Sunwell Plateau"),
        pin(335,65.90,86.46,3,"Brutallus - belt tokens","Sunwell Plateau"),
        pin(335,72.77,82.62,3,"Felmyst - boot tokens","Sunwell Plateau"),
        pin(335,64.16,32.10,3,"Eredar Twins - additional extension tokens","Sunwell Plateau"),
        pin(336,46.72,23.85,2,"M'uru - later Sunwell armor drops","Sunwell Plateau - Shrine of the Eclipse"),
        pin(336,46,61.69,2,"Kil'jaeden - final Sunwell armor drops","Sunwell Plateau - Shrine of the Eclipse"),
    }, 2479723 },
}
for _, set in ipairs(appearanceSets) do
    add(set[1], set[2], "Collections", {
        "Open Collections > Appearances > Sets and select a complete " .. set[3] .. " appearance set for an original Burning Crusade class. Pin down its missing slots before farming; five tier pieces alone may leave required matching boots, belt or bracers unfinished.",
        set[4][1], set[4][2],
        "Use eligible class tokens to create the armor, choosing the appropriate loot specialization. Where a token offers a choice, collect the PvE appearance, not its alternative PvP reward. A modern class with no original tier set cannot create that old class's tier pieces for itself.",
        "For every remaining slot in the SETS tab, inspect its specific appearance source and farm or craft that item. Matching off-pieces vary by class. Repeat after weekly resets for random drops; the armor set's visual checklist, not just its set-bonus count, is the goal.",
        "Permanently learn the final appearances. A trade/refund timer can delay credit. If all slots are learned but the achievement has not refreshed, relog; comments also report applying the complete set as a transmog refreshes credit. Do not buy or delete duplicate items before checking the actual missing slot.",
    }, set[5], nil, {
        "https://www.wowhead.com/achievement=" .. set[1] .. "#comments:id=" .. set[6],
        "https://www.wowhead.com/achievement=" .. set[1] .. "#comments",
    })
end

-- These older profession comments predate the expansion skill split.
-- Current objectives use the Outland 1-75 bar, not old skill 300-375.
add(124, "Outland Cook", "Professions", {
    "Train OUTLAND Cooking with Gaston in Honor Hold (54.0, 63.6, Alliance) or Baxter in Thrallmar (56.8, 37.4, Horde). Select the Outland recipe category in your profession window.",
    "Start with available Outland recipes such as Ravager Dog or your trainer's trout dishes. Buy recipe scrolls from the local cooking supplier and bring the actual Outland meat/fish; Classic Cooking skill and Pandaria's catch-up meals do not level this separate bar.",
    "As recipes turn green or grey, learn higher Outland dishes. Nagrand's vendors sell Roasted Clefthoof, Talbuk Steak, Grilled Mudfish and Poached Bluefish; Terokkar's vendors sell Golden Fish Sticks and Spicy Crawdad. Check the recipe's current skill color before buying a large batch of ingredients.",
    "Cook skill-granting Outland recipes until the Outland bar reaches 75. While learning new dishes, personally cook each missing Outland Gourmet criterion too. Merely buying finished food does not give Cooking skill or a cook-it criterion.",
}, {
    pin(100,54,63.6,1,"Gaston - Alliance Outland Cooking"), pin(100,56.8,37.4,1,"Baxter - Horde Outland Cooking"),
    pin(107,56.2,73.3,3,"Alliance: Uriku - Nagrand cooking recipes"), pin(107,58,35.7,3,"Horde: Nula the Butcher - Nagrand recipes"),
    pin(108,56.7,53.3,3,"Alliance: Innkeeper Biribi - fish recipes"), pin(108,48.8,46.0,3,"Horde: Rungor - fish recipes"),
})

add(129, "Outland Fisherman", "Professions", {
    "Learn OUTLAND Fishing from Juno Dufrain at Cenarion Refuge, Zangarmarsh (78.5, 63.0). Learning ordinary Fishing or another expansion's tier is not enough.",
    "Fish in Outland waters and successfully loot your catches. Zangarmarsh's open lakes and nearby schools are convenient. Stay in the Outland expansion's waters so the correct profession bar advances.",
    "Continue to Outland Fishing 75. You can combine the grind with the six Outland Angler school types, Barlo's dailies or Highland Mixed Schools for Mr. Pinchy. Old comments' Master Fishing books and skill 375 requirements belong to the former unsplit profession.",
}, { pin(102,78.5,63,1,"Juno Dufrain - train Outland Fishing"), pin(102,74,60,2,"Eastern Zangarmarsh lakes - fishing practice area") })

for _, profession in ipairs({ {733,"Professional Outland Master",1}, {18729,"Working in Hellfire",2}, {18721,"Outland Master of All",11} }) do
    add(profession[1], profession[2], "Professions", {
        "Open this achievement's progress and check the OUTLAND skill bars already credited. The objective is " .. (profession[3] == 11 and "all eleven primary professions, using your account's profession characters." or profession[3] == 2 and "75 Outland skill in two primary professions; use a character with the pair you want to keep." or "75 skill in one Outland primary profession."),
        "Train the OUTLAND tier separately. Hellfire's Honor Hold and Thrallmar have trainers for most professions; ask a guard for your profession's location. For Inscription, use Recorder Lidio on Shattrath's Aldor Rise (36.2, 44.6) or Scribe Lanloer on Scryer's Tier (56.6, 74.6). For Engineering, use Technician Mihila on Aldor Rise (37.6, 31.6) or Engineer Sinbei on Scryer's Tier (43.6, 65.0). Choose the Shattrath side that is friendly to you. Cooking, Fishing and Archaeology do not replace a primary profession.",
        "Skinning option: train with Jelena Nightsky at Honor Hold (54.4, 63.2) or Moorutu at Thrallmar (56.2, 38.6). In OUTLAND Nagrand, kill and fully loot the clefthoofs and talbuks in the grasslands between Garadar, Halaa and Oshu'gun, then skin their corpses. Continue until OUTLAND Skinning is 75. A corpse with somebody's loot still on it cannot be skinned; move through the herds rather than waiting on one spawn.",
        "Herbalism / Mining options: train with Rorelien (53.6, 65.8) or Ruak Stronghorn (52.2, 36.2) for Herbalism, and Hurnak Grimmord (56.6, 63.8) or Krugosh (55.4, 37.6) for Mining. Enable the appropriate minimap tracking. Circle Hellfire's open ground for Felweed and Dreaming Glory and its cliffs for Fel Iron. If the easy nodes stop giving skill, move to Nagrand or Blade's Edge for higher Outland herbs and Adamantite. Gather the nodes yourself until the relevant bar is 75; buying herbs/ore does not level gathering.",
        "Crafting option: select OUTLAND recipes and inspect their actual skill color before making a batch. Engineering starts with Fel Iron Bolts, Fel Iron Casings and Elemental Blasting Powder, which feed later bombs/grenades. Tailoring uses Netherweave Cloth for bolts, bags and Netherweave armor. Leatherworking uses Knothide Leather for armor kits and Draenic/Felscale armor. Keep useful intermediate materials instead of selling everything between stages; return to the trainer when the current recipe turns green or grey.",
        "For the other crafting bars, use Alchemy's Outland elixirs/potions, Blacksmithing's Fel Iron armor and later Adamantite recipes, Enchanting's Arcane Dust / Planar Essence enchants, Jewelcrafting's Outland gem cuts and Adamantite jewelry, or Inscription's Ethereal Ink / Darkflame Ink recipes. Check the Unlearned recipe's source and required skill before buying reagents: some later recipes are vendor, reputation or dungeon drops. A recipe grey below 75 cannot finish the bar, even if its materials came from Outland.",
        "Raise each required Outland bar to 75 and recheck its criterion. For Outland Master of All the full list is Alchemy, Blacksmithing, Enchanting, Engineering, Herbalism, Inscription, Jewelcrafting, Leatherworking, Mining, Skinning and Tailoring. Use profession alts for that account-wide list instead of deleting a developed profession to rotate through eleven skills. If you only need one or two bars, follow the options for those chosen professions and skip the others.",
    }, {
        pin(100,54.5,64.7,2,"Alliance: Honor Hold - profession trainer hub"), pin(100,54.2,38.5,2,"Horde: Thrallmar - profession trainer hub"),
        pin(111,36.2,44.6,2,"Aldor: Recorder Lidio - Outland Inscription"), pin(111,56.6,74.6,2,"Scryers: Scribe Lanloer - Outland Inscription"),
        pin(111,37.6,31.6,2,"Aldor: Technician Mihila - Outland Engineering"), pin(111,43.6,65.0,2,"Scryers: Engineer Sinbei - Outland Engineering"),
        pin(100,54.4,63.2,3,"Alliance: Jelena Nightsky - Outland Skinning"), pin(100,56.2,38.6,3,"Horde: Moorutu - Outland Skinning"),
        pin(107,50,50,3,"Nagrand grasslands - clefthoof / talbuk skinning circuit"),
        pin(100,53.6,65.8,4,"Alliance: Rorelien - Outland Herbalism"), pin(100,52.2,36.2,4,"Horde: Ruak Stronghorn - Outland Herbalism"),
        pin(100,56.6,63.8,4,"Alliance: Hurnak Grimmord - Outland Mining"), pin(100,55.4,37.6,4,"Horde: Krugosh - Outland Mining"),
        pin(100,30,60,4,"Western Hellfire - herb / Fel Iron search area"),
        pin(107,50,50,4,"Nagrand - herb / Adamantite search circuit"), pin(105,52,60,4,"Blade's Edge - alternative higher-node circuit"),
    }, "Gathering pins mark broad circuits, not guaranteed active nodes. Recipe skill colors and requirements in the current profession window take priority over comments written before the expansion skill split.", {
        "https://www.wowhead.com/achievement=" .. profession[1] .. "#comments",
        "https://www.wowhead.com/npc=33679/recorder-lidio", "https://www.wowhead.com/npc=33638/scribe-lanloer",
        "https://www.wowhead.com/npc=33677/technician-mihila", "https://www.wowhead.com/npc=33634/engineer-sinbei",
        "https://www.wowhead.com/npc=18777/jelena-nightsky", "https://www.wowhead.com/npc=18755/moorutu",
        "https://www.wowhead.com/npc=18779/hurnak-grimmord", "https://www.wowhead.com/npc=18747/krugosh",
        "https://www.wowhead.com/npc=18776/rorelien", "https://www.wowhead.com/npc=18748/ruak-stronghorn",
    })
end

-- https://www.wowhead.com/achievement=18894#comments:id=5653747 and ALL replies
add(18894, "Free Stylin'", "Professions", {
    "Use a Leatherworker, learn OUTLAND Leatherworking and reach 50 skill. All four hats must be CRAFTED by you for the achievement; buying the finished hats or learning their appearances is insufficient.",
    "Farm Pattern: Stylin' Purple Hat (25728) from Blackheart the Inciter in Shadow Labyrinth. Set Normal for repeat attempts and loot the second boss. The pattern is profession-gated, so learn Outland Leatherworking before farming.",
    "Farm Pattern: Stylin' Crimson Hat (25731) from Sethekk Ravenguards in Sethekk Halls. Kill and loot the relevant trash rather than rushing only to Anzu or Ikiss.",
    "In Old Hillsbrad Foothills, loot Durnholde Riflemen and the associated Rifleman variant for Pattern: Stylin' Adventure Hat (25729). In Black Morass, loot Rift Keepers and Rift Lords during the portal waves for Pattern: Stylin' Jungle Hat (25730). Both instances are inside the Caverns of Time in Tanaris.",
    "Learn all four patterns. Bring 24 Heavy Knothide Leather, 8 Cobra Scales, 12 Rune Thread, 8 each of Primal Shadow, Primal Life, Primal Earth and Primal Fire, and 4 each of Purple Dye, Black Dye and Red Dye. Buying the reagents is fine; only the hat crafting must be yours.",
    "Craft one Purple, Crimson, Adventure and Jungle hat with Outland Leatherworking. Check all four criteria. Normal and Heroic can drop the patterns, but no first-run drop is guaranteed; replies include players needing many resets.",
}, {
    pin(108,39.63,73.55,2,"Shadow Labyrinth - Blackheart / Purple pattern"),
    pin(108,44.93,65.61,3,"Sethekk Halls - Ravenguards / Crimson pattern"),
    pin(75,26.8,36.8,4,"Old Hillsbrad - Riflemen / Adventure pattern","Caverns of Time"),
    pin(75,37.2,83.3,4,"Black Morass - rift enemies / Jungle pattern","Caverns of Time"),
})

-- https://www.wowhead.com/achievement=877#comments:id=408891 and replies
-- https://www.wowhead.com/achievement=877#comments:id=2304645 and replies
add(877, "The Cake Is Not A Lie", "Professions", {
    "Search your Cooking recipes for Delicious Chocolate Cake before farming. If already learned, skip to gathering ingredients. The objective is to BAKE the cake, not merely learn the recipe or eat a bought cake.",
    "Complete The Rokk's cooking daily in Shattrath (61.6, 15.8) and open the Crate of Meat or Barrel of Fish until Recipe: Delicious Chocolate Cake drops. Northrend Dalaran's cooking daily Small Spice Bag is another source. These are random rewards, not guaranteed after a set number of days.",
    "Optional during the appropriate Timewalking week: buy those recipe-containing cooking reward bags from Cupri in Shattrath or Auzin in Northrend Dalaran with Timewarped Badges. Opening bought reward containers gives additional attempts; buying a finished cake does not.",
    "Learn the recipe and gather 8 Simple Flour, 8 Small Eggs, 4 Mild Spices, 4 Ice Cold Milk, 3 Mageroyal and 1 Flask of Port. Flour/spices come from cooking suppliers; milk/port from drink vendors. Buy the eggs and herb or gather them. Kylene in Shattrath's World's End Tavern sells the port.",
    "Stand beside a cooking fire and personally craft one Delicious Chocolate Cake. Check the achievement. Clear recipe filters if it does not appear; do not spend more days farming a recipe that is already in your Cooking book.",
}, {
    pin(111,61.6,15.8,2,"The Rokk - cooking daily reward bags"),
    pin(125,40.3,66.1,2,"Alliance: Katherine Lee - Northrend cooking daily"),
    pin(125,70,38.9,2,"Horde: Awilo Lon'gomba - Northrend cooking daily"),
    pin(111,54.5,38.8,3,"Cupri - Burning Crusade Timewalking vendor when active"),
    pin(125,50.6,45.0,3,"Auzin - Northrend Timewalking vendor when active"),
    pin(111,73.5,32.7,4,"Kylene - World's End Tavern drink vendor"),
})

-- https://www.wowhead.com/achievement=1801#comments:id=1204043 and replies
-- The existing Dalaran/Shattrath daily sources are retained and clarified.
add(1801, "Captain Rumsey's Lager", "Professions", {
    "Search your Cooking recipe book for Captain Rumsey's Lager FIRST. Many commenters had already learned it and only needed to brew it. If learned, skip to step 3.",
    "Complete Old Man Barlo's fishing daily at Silmyr Lake in Terokkar (38.7, 12.8) or Marcia Chase's fishing daily in Northrend Dalaran (52.6, 65.6), then open their Bag of Fishing Treasures. The recipe can also appear in cooking daily reward bags from The Rokk or the Northrend cooks. Learn Recipe: Captain Rumsey's Lager when it drops.",
    "Buy 1 Skin of Dwarven Stout and 1 Flagon of Dwarven Mead. Kylene in Shattrath's World's End Tavern (73.5, 32.7) sells both, avoiding the old comments' removed city-vendor locations.",
    "At a cooking fire, brew the lager yourself. Learning the recipe alone, drinking a bought lager, or merely keeping the recipe scroll in your bags does not complete this craft-it objective.",
}, {
    pin(108,38.7,12.8,2,"Old Man Barlo - fishing daily"), pin(125,52.6,65.6,2,"Marcia Chase - Northrend fishing daily"),
    pin(111,61.6,15.8,2,"The Rokk - cooking daily"), pin(125,40.3,66.1,2,"Alliance: Katherine Lee - cooking daily"),
    pin(125,70,38.9,2,"Horde: Awilo Lon'gomba - cooking daily"), pin(111,73.5,32.7,3,"Kylene - stout and mead ingredients"),
})

-- https://www.wowhead.com/achievement=906#comments:id=6038437
-- https://www.wowhead.com/achievement=906#comments:id=6292954
add(906, "Kickin' It Up a Notch", "Quests", {
    "Learn Outland Cooking and visit The Rokk in northern Lower City, Shattrath (61.6, 15.8). He offers one of four cooking dailies each day. Return on later days until you have personally completed all four different quests; they are not a guaranteed four-day rotation.",
    "For Super Hot Stew, bring 2 Mok'Nathal Shortribs and 1 Crunchy Serpent. Learn those recipes from the Blade's Edge cooking suppliers or the Mok'Nathal Treats quest at Mok'Nathal Village (76.0, 60.3). Kill an Abyssal Flamebringer in Forge Camp: Terror and use the supplied cooking pot beside its remains to make the quest stew.",
    "For Soup for the Soul, prepare 4 Roasted Clefthoof. Go to the Ancestral Grounds in southwest Outland Nagrand (around 25, 61) and use the quest's pot there. Carrying the food without cooking the quest soup at the required place is insufficient.",
    "For Revenge is Tasty, bring 3 Warp Burgers and kill Monstrous Kaliri in Skettis for a Giant Kaliri Wing. Use the quest pot to make Kaliri Stew, then return to The Rokk.",
    "For Manalicious, collect 15 Mana Berries from the bushes inside Netherstorm's eco-domes, such as Eco-Dome Midrealm (46, 55). Return them to The Rokk.",
    "Turn in each completed daily and check that its name credits. Keep the reward bags for rare Outland cooking recipes, including those needed by Outland Gourmet. An already completed daily can repeat for many days while you wait for the missing one.",
}, {
    pin(111,61.6,15.8,1,"The Rokk - check today's cooking quest"),
    pin(105,76.0,60.3,2,"Mok'Nathal Treats - two needed cooking recipes"),
    pin(105,29,80,2,"Forge Camp: Terror - Abyssal Flamebringer cooking area"),
    pin(107,25,61,3,"Ancestral Grounds - cook Soup for the Soul"),
    pin(108,66,75,4,"Skettis - Monstrous Kaliri wing search area"),
    pin(109,46,55,5,"Eco-Dome Midrealm - Mana Berries"),
    pin(111,61.6,15.8,6,"Return completed dailies to The Rokk"),
})

-- https://www.wowhead.com/achievement=905#comments:id=1599821 and reply
add(905, "Old Man Barlowned", "Quests", {
    "Learn Outland Fishing and visit Old Man Barlo beside Silmyr Lake north of Shattrath (38.7, 12.8 on the Terokkar map). Use a character eligible for his daily; recent Retail NPC information requires level 30. One of his five quests is offered each day.",
    "For Crocolisks in the City, fish in Stormwind's canals or Orgrimmar's city water until you catch the Baby Crocolisk. Return it to Barlo; a wild battle-pet capture does not replace the quest fish.",
    "For Bait Bandits, fish in Terokkar Forest's rivers for a Blackfin Darter. Ordinary open river water works; it is a quest fish, not the School of Darter achievement objective.",
    "For Felblood Fillet, fish in the fel waters of Hellfire Peninsula or Outland Shadowmoon Valley for a Monstrous Felblood Snapper.",
    "For Shrimpin' Ain't Easy, fish in Zangarmarsh for Bloated Barbed Gill Trout. OPEN each bloated fish to collect Giant Freshwater Shrimp until you have all 10.",
    "For The One That Got Away, fish in Outland Nagrand's lakes for the World's Largest Mudfish. Be patient and loot each cast; the quest item is separate from an ordinary Figluster's Mudfish.",
    "Turn in each of the five DIFFERENT quests to Barlo. Return after future daily resets for missing names. The random rotation can repeat; old realm-hopping advice is not a dependable replacement for waiting. Open the reward bags for extra recipes and, on Crocolisks in the City, possible crocolisk pets.",
}, {
    pin(108,38.7,12.8,1,"Old Man Barlo - daily quest giver"),
    pin(84,61,65,2,"Stormwind canals - Crocolisks in the City fishing area"),
    pin(85,69,30,2,"Orgrimmar - Valley of Honor city water"),
    pin(108,56.5,49,3,"Terokkar river - Bait Bandits fishing area"),
    pin(100,44,47,4,"Hellfire Citadel moat - fel-water fishing area"),
    pin(102,75,60,5,"Zangarmarsh lake - bloated trout and shrimp"),
    pin(107,59,35,6,"Skysong Lake - World's Largest Mudfish search area"),
    pin(108,38.7,12.8,7,"Barlo - turn in completed daily"),
})

-- https://www.wowhead.com/achievement=1225#comments:id=412649 and replies
-- https://www.wowhead.com/achievement=1225#comments:id=787377
add(1225, "Outland Angler", "Professions", {
    "Learn Outland Fishing from Juno Dufrain at Cenarion Refuge (78.5, 63.0). Enable Find Fish if you have it. You must land the bobber IN each named school and successfully loot a catch; open water beside the school does not credit its criterion.",
    "In Zangarmarsh, fish a Sporefish School and a Brackish Mixed School. Search the lakes and shorelines near Cenarion Refuge and the pumping stations. School pins are search areas, not guaranteed active nodes.",
    "In Outland Nagrand, catch from a Bluefish School and a Mudfish School. Check Skysong Lake north of Garadar and Sunspring Lake west of Halaa, circling the shoreline for both names.",
    "In Terokkar Forest, fish a School of Darter in the river system between Tuurem, Allerian Stronghold and Firewing Point. If only Brackish Mixed Schools are present, empty them and revisit the river so new school types can spawn.",
    "Fly up to Lake Ere'Noru near Allerian Stronghold, Lake Jorune or Blackwind Lake in Skettis and catch from a HIGHLAND MIXED SCHOOL. These are elevated lakes, not the lowland rivers. This catch also gives a chance at Mr. Pinchy.",
    "Check all six names in the achievement before leaving. Grey weeds or other junk may fail to credit the school: reposition the bobber and keep fishing until the criterion updates.",
}, {
    pin(102,78.5,63,1,"Juno Dufrain - Outland Fishing"), pin(102,74,60,2,"Eastern lakes - Sporefish / Brackish school search"),
    pin(107,59,35,3,"Skysong Lake - Bluefish / Mudfish schools"), pin(107,35,46,3,"Sunspring Lake - alternative school circuit"),
    pin(108,56.5,49,4,"Terokkar river - School of Darter search"), pin(108,59,59,5,"Lake Ere'Noru - Highland Mixed Schools"),
    pin(108,45.8,40,5,"Lake Jorune - Highland Mixed Schools"), pin(108,67.8,79.6,5,"Blackwind Lake - Highland Mixed Schools"),
})

-- https://www.wowhead.com/achievement=726#comments:id=430034 and all replies
-- https://www.wowhead.com/achievement=726#comments:id=3196727
-- https://www.wowhead.com/achievement=726#comments:id=6407919 (level 23)
add(726, "Mr. Pinchy's Magical Crawdad Box", "Collections", {
    "Use a character of at least level 23 with Fishing and flight access to Terokkar's elevated lakes. Outland Fishing can be learned from Juno Dufrain in Zangarmarsh (78.5, 63.0). You do not need old unsplit Fishing 375 to attempt the catch.",
    "Fly to Blackwind Lake in Skettis (around 67.8, 79.6), Lake Ere'Noru beside Allerian Stronghold (59, 59) or Lake Jorune (45.8, 40). Search specifically for HIGHLAND MIXED SCHOOLS. Fish out each school and move along the shoreline; ordinary open-water casts are the wrong farm.",
    "Fully loot your catches until you obtain Mr. Pinchy (27388). Watch for a binding confirmation so you do not lose the rare item by immediately recasting. Furious Crawdad is an ordinary cooking fish, not Mr. Pinchy or the pet box.",
    "With bag space available, right-click Mr. Pinchy to spend a wish. It has three charges and may award a creature, a buff, a gift or Magical Crawdad Box. The achievement requires the BOX from a wish, not merely catching Mr. Pinchy.",
    "If the box does not appear, keep the item and wait FOUR HOURS for the next wish. Copies on the same character share that cooldown. Use the remaining wishes; if all three fail, fish up another Mr. Pinchy and continue.",
    "When a wish awards Magical Crawdad Box (27445), check the achievement and use the box to learn the pet. A bought caged Magical Crawdad can fill your Pet Journal but does not replace this achievement's personal box objective. Neither stage has a guaranteed cast or wish count.",
}, {
    pin(102,78.5,63,1,"Juno Dufrain - Outland Fishing trainer"),
    pin(108,67.8,79.6,2,"Blackwind Lake - Highland Mixed School search circuit"),
    pin(108,59,59,2,"Lake Ere'Noru - elevated lake alternative"),
    pin(108,45.8,40,2,"Lake Jorune - elevated lake alternative"),
})

-- https://www.wowhead.com/achievement=144#comments:id=5672293
-- https://www.wowhead.com/achievement=144#comments:id=6214000
add(144, "The Lurker Above", "Raids", {
    "Learn Outland Fishing, then go to Coilfang Reservoir in Zangarmarsh (50.3, 40.8). Dive down its central pipe and swim through to the air-filled entrance cavern.",
    "Enter Serpentshrine Cavern through the central waterfall portal (51.9, 33.0 on the Zangarmarsh map). This is the RAID, not Slave Pens or Steamvault. You can enter alone; no original attunement is required.",
    "Ride the large elevator DOWN, follow the boardwalk and take the smaller elevator UP. Continue onto the main cavern platforms and reach the low wooden ring around The Lurker Below's Strange Pool. A strong legacy-farming character can clear the route rather than reproduce old naked/stealth suicide tactics.",
    "Stand on that wooden ring and cast Fishing into the Strange Pool until YOU fish up The Lurker Below. Outland Fishing 1 is enough to attempt it; it can take several casts. Another player's summon or simply killing him does not replace your fishing objective. Defeat him afterwards if desired.",
}, {
    pin(102,50.3,40.8,1,"Coilfang Reservoir - underwater pipe"),
    pin(102,51.9,33,2,"Serpentshrine Cavern - waterfall raid entrance"),
    pin(332,40.26,58.15,3,"Strange Pool - reach the low wooden fishing ring","Serpentshrine Cavern"),
    pin(332,40.26,58.15,4,"Strange Pool - personally fish up The Lurker Below","Serpentshrine Cavern"),
})

-- https://www.wowhead.com/achievement=8293#comments:id=1834244 and all replies
-- https://www.wowhead.com/item=97553#dropped-by (Hydross and Lurker)
add(8293, "Raiding with Leashes II: Attunement Edition", "Collections", {
    "Collect and LEARN all ten listed species. Their dropped items and caged pets are tradable, so check your missing Journal species before farming; buying and learning a missing pet is valid for this collection meta.",
    "In original ground-level Karazhan, kill Moroes to open Opera, then speak to Barnes. Lil' Bad Wolf comes from the Big Bad Wolf version of Opera; a different performance means another week's chance or buying the pet. The Curator drops Menagerie Custodian, Terestian Illhoof drops Fiendish Imp, and Prince Malchezaar drops Netherspace Abyssal.",
    "To reach the Prince, finish Chess. Start with your king, move a pawn to make room, keep your king out of Medivh's fire and attack the opposing king with controlled pieces. Wait for the Recently In Game debuff between changing pieces; repeatedly clicking through that cooldown does nothing.",
    "In Serpentshrine Cavern, loot Hydross the Unstable for Tainted Waveling, Morogrim Tidewalker for Tideskipper and Lady Vashj for Coilfang Stalker. The Lurker Below also drops the Tainted Core pet item: bring Fishing and cast into his Strange Pool for an extra Tainted Waveling attempt. Enter the raid via Coilfang Reservoir's underwater pipe in Zangarmarsh.",
    "In The Eye, the central Tempest Keep raid in Netherstorm, loot Al'ar for Phoenix Hawk Hatchling, Void Reaver for Pocket Reaver and High Astromancer Solarian for Lesser Voidcaller. Kael'thas is not one of this meta's pet bosses.",
    "Use each dropped pet item, or learn the matching caged species. Repeat missing bosses after the weekly reset, then claim and learn Tito from the achievement reward mail. Tito is the reward, not an eleventh prerequisite.",
}, {
    pin(42,46.87,74.69,2,"Original Karazhan - four pet species"), pin(102,50.4,40.9,4,"Serpentshrine Cavern approach - three pet species"),
    pin(109,73.73,63.71,5,"The Eye - Al'ar, Void Reaver and Solarian pets"),
    pin(353,18.10,35.08,2,"Big Bad Wolf Opera - Lil' Bad Wolf","Karazhan - The Guest Chambers / Opera"),
    pin(358,49.49,36.62,2,"The Curator - Menagerie Custodian","Karazhan - The Menagerie"),
    pin(360,52.56,69.69,2,"Terestian Illhoof - Fiendish Imp","Karazhan - The Repository"),
    pin(366,51.44,30.92,2,"Prince Malchezaar - Netherspace Abyssal","Karazhan - Netherspace"),
    pin(363,35.95,61.69,3,"Chess Event - open the Prince's route","Karazhan - Gamesman's Hall"),
    pin(332,36.36,84.77,4,"Hydross - Tainted Waveling","Serpentshrine Cavern"),
    pin(332,40.26,58.15,4,"Lurker Strange Pool - optional extra Tainted Waveling chance","Serpentshrine Cavern"),
    pin(332,59.64,26,4,"Morogrim - Tideskipper","Serpentshrine Cavern"),
    pin(332,72.26,58.92,4,"Lady Vashj - Coilfang Stalker","Serpentshrine Cavern"),
    pin(334,50.10,58.77,5,"Al'ar - Phoenix Hawk Hatchling","The Eye"),
    pin(334,26.41,49.07,5,"Void Reaver - Pocket Reaver","The Eye"),
    pin(334,74,48.92,5,"Solarian - Lesser Voidcaller","The Eye"),
})

-- https://www.wowhead.com/achievement=9824#comments:id=2085716 and all replies
add(9824, "Raiding with Leashes III: Drinkin' From the Sunwell", "Collections", {
    "Check the twelve required species in your Pet Journal. You can farm their raid drops or buy and learn matching caged pets. Owning an unlearned item in a bag does not finish a collection criterion.",
    "In original Black Temple, loot Naj'entus for Leviathan Hatchling, Supremus for Abyssius, Reliquary of Souls for Fragment of Anger / Desire / Suffering, and Mother Shahraz for Sister of Temptation. The three Fragments are distinct species from the same encounter; keep tracking the missing ones on later weekly runs.",
    "In Battle for Mount Hyjal, start Jaina's wave events and loot Anetheron for Stinkrot. Continue Thrall's waves and loot Azgalor for Grotesque, then Archimonde for Hyjal Wisp. Kill incoming flyers too; abandoning the camp event resets its progress.",
    "Take Shattrath's portal to original Isle of Quel'Danas and enter Sunwell Plateau. Loot Brutallus for Sunblade Micro-Defender, the Eredar Twins for Wretched Servant and M'uru/Entropius for Chaos Pup. Felmyst is on the route but is not the Wretched Servant's source.",
    "Learn every missing species and repeat the appropriate bosses after weekly resets if drops are still missing. Claim the final K'ute reward from the achievement mail; K'ute itself is not one of the twelve required drops.",
}, {
    pin(104,71,46.5,2,"Original Black Temple - six pet species"),
    pin(75,36,16.1,3,"Battle for Mount Hyjal - three pet species","Caverns of Time"),
    pin(111,48.9,42.1,4,"Portal to original Isle of Quel'Danas"), pin(122,44.28,45.71,4,"Sunwell Plateau - three pet species"),
    pin(340,43.95,18.77,2,"Naj'entus - Leviathan Hatchling","Black Temple - Karabor Sewers"),
    pin(339,66.31,47.38,2,"Supremus - Abyssius","Black Temple - Courtyard"),
    pin(342,61.38,85.08,2,"Reliquary - all three Fragment species","Black Temple - Halls of Anguish"),
    pin(344,67.54,36.77,2,"Mother Shahraz - Sister of Temptation","Black Temple - Den of Mortal Delights"),
    pin(329,8.56,68.15,3,"Anetheron - Stinkrot","Hyjal Summit"), pin(329,35.74,37.85,3,"Azgalor - Grotesque","Hyjal Summit"),
    pin(329,77.28,28.31,3,"Archimonde - Hyjal Wisp","Hyjal Summit"),
    pin(335,65.90,86.46,4,"Brutallus - Sunblade Micro-Defender","Sunwell Plateau"),
    pin(335,64.16,32.10,4,"Eredar Twins - Wretched Servant","Sunwell Plateau"),
    pin(336,46.72,23.85,4,"M'uru / Entropius - Chaos Pup","Sunwell Plateau - Shrine of the Eclipse"),
})

-- https://www.wowhead.com/achievement=894#comments:id=953802 and replies
-- The existing nether-ray route supplies the detailed Almanac/descendant chain.
add(894, "Flying High Over Skettis", "Reputation", {
    "Take Threat from Above from Yuula beside Shattrath's flight master (64, 42). Kill 20 Gordunni ogres in the Barrier Hills north of Shattrath, return, and follow To Skettis to Adaris at Blackwind Landing (64, 66.8 in Terokkar).",
    "Complete Severin's World of Shadows: collect 6 Shadow Dust from Skettis arakkoa and exchange it for Elixir of Shadows. Keep that buff active to see time-lost arakkoa and collect their Time-Lost Scrolls.",
    "Kill Talonpriest Ishaal (69.3, 78.5), start his dropped Almanac quest, and take it to Adaris. For An Ally in Lower City, visit Rilak in Shattrath (52.6, 20.8); return to Adaris with Countdown to Doom.",
    "At Hazzik, retrieve Hazzik's Package from the ground-level hut in UPPER Veil Shil'ak (74.8, 80.2). Use A Shabby Disguise to buy Adversarial Bloodlines from Sahaak (67, 79), then return to Hazzik.",
    "Gather 40 Time-Lost Scrolls. At small Skull Piles summon four DIFFERENT descendants, spending 10 scrolls each: Akkarai, Karrog, Gezzarak and Vakkiz. Keep one of each token and exchange the set with Hazzik for a Time-Lost Offering.",
    "Take Terokk's Downfall from Adaris. Use the Offering at the LARGE island Skull Pile on Terokk's Rest (66.2, 77.5), kill Terokk and turn in. If he shields, bring him into the Skyguard's blue fire.",
    "Repeat arakkoa/treant kills, dust exchanges, descendant-token sets and Terokk summons until Sha'tari Skyguard is Exalted. Keep the elixir refreshed. Bombing and escort dailies add reputation, but are not the only source; the achievement does not require buying a nether ray.",
}, {
    pin(111,64,42,1,"Yuula - introductory quest"), pin(108,22,12,1,"Barrier Hills - Gordunni ogres"),
    pin(108,64,66.8,1,"Adaris - Blackwind Landing"), pin(108,64,66.8,2,"Severin - Shadow Dust exchange"),
    pin(108,69.3,78.5,3,"Talonpriest Ishaal - Almanac"), pin(111,52.6,20.8,3,"Rilak - An Ally in Lower City"),
    pin(108,64.2,66.8,4,"Hazzik - summoning-chain quests"), pin(108,74.8,80.2,4,"Upper Veil Shil'ak - package"),
    pin(108,67,79,4,"Sahaak - disguised book purchase"), pin(108,69.6,74.6,5,"Small Skull Pile - descendants"),
    pin(108,64.2,66.8,5,"Hazzik - exchange four different tokens"), pin(108,66.2,77.5,6,"Terokk's Rest - large Skull Pile"),
})

-- https://www.wowhead.com/achievement=896#comments:id=425370 and replies
-- https://www.wowhead.com/faction=1038#comments:id=5380854 and all replies
add(896, "A Quest a Day Keeps the Ogres at Bay", "Reputation", {
    "Fly to Ogri'la on the western Blade's Edge plateau (28.8, 57.4), enable Trivial Quests and speak to Chu'a'lor. Complete The Crystals by gathering 5 Apexis Shards from nearby creatures. Follow An Apexis Relic: spend a shard at a relic and reproduce its flashing color sequence, adding each new flash to the previous sequence.",
    "Complete Our Boy Wants To Be A Skyguard Ranger for Torkus: gather the required Apexis Shards and use a Fel Crystalforge at Forge Camp: Wrath to obtain the Unstable Flask of the Beast. Follow The Skyguard Outpost to the camp just north of Ogri'la (27.5, 52.6). Complete the introductory Bombing Run and Wrangle Some Aether Rays! quests to unlock their repeatable versions.",
    "Each day, take Bomb Them Again! from Vanderlip. Bomb 15 cannonball stacks at Forge Camp: Wrath, north of the outpost, using the supplied Skyguard Bombs while mounted. Aim at the ammunition piles, not the demons or cannons. Return to the outpost to turn in.",
    "Complete Wrangle More Aether Rays! by using the supplied rope on five different wild rays near the outpost. Retail allows wrangling them at full health; do not kill the rays first. At Ogri'la, also complete The Relic's Emanation by repeating the full sequence at an Apexis Relic. Write down each new color if needed.",
    "At Honored, complete Banish the Demons to unlock Banish More Demons. Place the supplied portal at a forge camp, bring living demons close to it, wait for its debuff and then kill them. Killing demons outside the portal's influence does not count.",
    "Repeat the three available dailies, then all four after Honored, until Ogri'la is Exalted. Shartuul's Darkrune event is removed and is not a Retail shortcut. Ordinary kills do not provide an unlimited reputation grind; applicable reputation bonuses can shorten the daily schedule.",
}, {
    pin(105,28.8,57.4,1,"Chu'a'lor - Ogri'la and relic quests"), pin(105,28.4,57.6,2,"Torkus - Skyguard Ranger unlock"),
    pin(105,32.4,40.4,2,"Forge Camp: Wrath - Fel Crystalforge area"), pin(105,27.5,52.6,2,"Skyguard Outpost - introductory quests"),
    pin(105,27.6,52.9,3,"Vanderlip - Bomb Them Again!"), pin(105,33,40,3,"Forge Camp: Wrath - cannonball stacks"),
    pin(105,27.5,52.6,4,"Skyguard Outpost - aether rays nearby"), pin(105,28.8,57.4,4,"Ogri'la - relic daily"),
    pin(105,32,48.5,5,"Forge-camp demon banishing area"),
})

-- https://www.wowhead.com/achievement=898#comments:id=1549124
-- See the existing Netherwing mount routes for the complete introductory chain.
add(898, "On Wings of Nether", "Reputation", {
    "Find Mordenai walking in Netherwing Fields (60, 59) in OUTLAND Shadowmoon Valley. Complete Kindness by feeding eight mature drakes with carcasses obtained from Rocknail Flayers. Enable Trivial Quests so the old chain remains visible.",
    "Find Neltharaku flying HIGH above the fields. Finish his dialogue, kill the requested Dragonmaw orcs, collect 12 Nethervine Crystals on Netherwing Ledge, then use his enchanted crystal to release enslaved drakes at Dragonmaw Fortress. Help the freed drakes fight instead of killing them.",
    "At the fortress platform (69.8, 61.5), accept Karynaku's Zuluhed the Whacked. Kill Zuluhed, loot the key, free Karynaku and finish Ally of the Netherwing with Mordenai. Continue Blood Oath of the Netherwing and In Service of the Illidari to the disguised base camp on the southern island.",
    "Speak to Mor'ghor and Taskmaster Varkule Dragonbreath at the base camp (66, 86). Complete Yarzill's Your Friend on the Inside and The Great Netherwing Egg Hunt; later eggs use Accepting All Eggs. Eggs can be handed in repeatedly on the same day.",
    "Search the ledge, floating rocks, fortress and Netherwing Mines (65.3, 90) for ground eggs. Loot mine flayers and ravagers for random eggs as well; Murkblood Miners do not drop loot. Combine this with the camp/mine dailies for crystals, cargo and enemy kills as they unlock.",
    "Return for each reputation-rank promotion and keep doing eggs and dailies until Netherwing is Exalted. Applicable Timewalking or other reputation buffs help; no fixed egg count works for every starting rank and bonus. Exalted completes this achievement; the later Illidan rescue and free-drake selection are optional mount rewards.",
}, {
    pin(104,60,59,1,"Mordenai - walking introductory quest giver"), pin(104,61.8,60,2,"Neltharaku - search HIGH in the air"),
    pin(104,69.4,82.4,2,"Netherwing Ledge - crystal quest"), pin(104,69,61,2,"Dragonmaw Fortress - release drakes"),
    pin(104,69.8,61.5,3,"Karynaku and Zuluhed"), pin(104,60,59,3,"Mordenai - Ally of the Netherwing"),
    pin(104,66,86.4,4,"Disguised base camp and Yarzill's egg quests"), pin(104,65.3,90,5,"Netherwing Mines entrance - eggs and dailies"),
    pin(104,66,86.4,6,"Taskmaster - promotions and reputation dailies"),
})

-- Guardian of Cenarius spans Classic and Outland; its walkthrough is in General.

-- https://www.wowhead.com/achievement=1275#comments:id=5800566
-- https://www.wowhead.com/achievement=1275#comments:id=6318420
add(1275, "Bombs Away", "Quests", {
    "Leave all groups: the achievement requires a SOLO attempt. Unlock Blackwind Landing through Yuula's Threat from Above in Shattrath and To Skettis. At Blackwind Landing, locate Sky Sergeant Doryn (64.6, 66.6 in Terokkar). Use a flying mount and put the supplied Skyguard Blasting Charges on an accessible action-bar key before attempting the timer.",
    "Track this achievement, then accept Fires Over Skettis. The timer starts on acceptance. Fly toward the Skettis tree platforms and roofs around Blackwind Lake; the targets are egg clusters on buildings, not birds on the ground.",
    "Bomb groups of Monstrous Kaliri Eggs until the quest counter reaches 20. Place the targeting circle over the eggs themselves; a well-placed bomb can hit several. Move toward your next roof during the bomb cooldown. Watch for attacking kaliri, and use Steady Flight if Skyriding makes aiming difficult.",
    "Finish the objective within 2 minutes 15 seconds and return promptly to Doryn to turn in. Recent Retail comments report credit when the final eggs are destroyed, but budgeting for the return also avoids relying on that behavior. If the attempt fails, abandon and reaccept before turning in; a completed daily cannot be repeated that day.",
}, {
    pin(111,64,42,1,"Yuula - Skyguard introduction"), pin(108,22,12,1,"Barrier Hills - introductory ogres"),
    pin(108,64.6,66.6,1,"Doryn - Fires Over Skettis"), pin(108,67,77,3,"Skettis - search rooftop egg clusters around the lake"),
    pin(108,64.6,66.6,4,"Doryn - return and turn in"),
})

-- https://www.wowhead.com/achievement=1276#comments:id=5613321 and both replies
-- https://www.wowhead.com/achievement=1276#comments:id=5416541 and reply
add(1276, "Blade's Edge Bomberman", "Quests", {
    "Leave all groups: the achievement requires a SOLO attempt. Unlock the Skyguard Outpost through Ogri'la's introductory crystal/flask quests and The Skyguard Outpost. Complete Vanderlip's introductory Bombing Run first; the achievement attempt uses the DAILY Bomb Them Again!, not that first bombing quest.",
    "At Sky Sergeant Vanderlip (27.6, 52.9), prepare your flying mount and bind Skyguard Bombs before accepting. Track the achievement. Accept Bomb Them Again! and fly immediately NORTH to Forge Camp: Wrath, around 33, 40. Skyriding can shorten the journeys; you can land while still mounted to aim each bomb, then launch toward the next pile.",
    "Destroy 15 Fel Cannonball Stacks. Aim at the small ammunition piles near the flak cannons, center the circle carefully, and line up your next target during every bomb cooldown. Stay inside the camp boundary so the bombs can be used. Current Retail replies say the old double-tap trick no longer works.",
    "Make your last targets the stacks nearest the southern exit, then return directly to Vanderlip and TURN IN within 2 minutes 15 seconds of accepting. Fast travel to/from the camp matters as much as aiming. If the timer fails, abandon and retry before completing the daily; after turn-in, wait for another daily reset.",
}, {
    pin(105,28.8,57.4,1,"Ogri'la - introductory quests"), pin(105,27.6,52.9,2,"Vanderlip - accept timed DAILY"),
    pin(105,33,40,3,"Forge Camp: Wrath - bomb 15 ammunition stacks"), pin(105,27.6,52.9,4,"Vanderlip - timed turn-in"),
})

-- https://www.wowhead.com/achievement=1638#comments:id=1012231
-- https://www.wowhead.com/achievement=1638#comments:id=3229587
add(1638, "Skyshattered", "Quests", {
    "Unlock the Netherwing base camp through Mordenai's introductory chain and reach HONORED with Netherwing. At the disguised Dragonmaw camp on Netherwing Ledge, take the racing introduction Earning Your Wings. These races do not start at a mainland flight master.",
    "Complete the Netherwing races in order: Murg 'Oldie' Muckjaw, Trope the Filth-Belcher, Corlok the Vet, Wing Commander Ichman, Wing Commander Mulverick, and finally Captain Skyshatter. Talk to each rider and let them start; the final race is not available immediately.",
    "Use a responsive flying mount, preferably Steady Flight, and follow the rider's actual turns. Stay close enough to keep the race active while flying above or offset from the stream of thrown attacks. Attacks can knock you back, but the old automatic-dismount behavior was removed. Recover your position and keep following unless the quest actually fails; watch the rider during pauses instead of flying far ahead.",
    "For Captain Skyshatter, learn his sharp turns and altitude changes on a practice attempt. Follow above/alongside him where possible and avoid cutting so far ahead that the race loses contact. After the successful flight, TURN IN the quest to claim Skyshattered; simply reaching the landing strip does not complete it.",
}, {
    pin(104,60,59,1,"Mordenai - Netherwing introductory chain"), pin(104,66,86.4,1,"Dragonmaw base camp - Honored racing introduction"),
    pin(104,65.5,85.3,2,"Netherwing Ledge - Dragonmaw racing strip"), pin(104,65.5,85.3,4,"Racing strip - Captain Skyshatter and final turn-in"),
})

-- https://www.wowhead.com/achievement=939#comments:id=1424500 and both replies
add(939, "Hills Like White Elekk", "Quests", {
    "Go to Nesingwary Safari (71.5, 40.7) in Nagrand, OUTLAND. Enable Trivial Quests. Accept all three opening Mastery quests from Hemet Nesingwary, Harold Lane and Shado 'Fitz' Farstrider; the three hunting chains can progress together.",
    "For Clefthoof Mastery, kill 12 ordinary Clefthoofs, return to Hemet, then kill 12 Clefthoof Bulls and return again. His third quest asks for Banthar's Horn. Search Banthar's patrol in the western/central grasslands, around 37, 61 to 42, 60; kill and LOOT her before returning.",
    "For Talbuk Mastery, kill 12 Talbuk Stags, turn in, then kill 12 Talbuk Thorngrazers and turn in. The third quest needs Bach'lor's Hoof. Search for the named talbuk traveling with a herd in western Nagrand, around 29, 34; loot him and report to Harold.",
    "For Windroc Mastery, kill 12 Windrocs, return, then 12 Ravenous Windrocs and return. The third quest needs Gutripper's Eye. Look UP along the western foothills around 33, 30: Gutripper flies a patrol instead of standing at the map point. Kill and loot her, then return to Shado.",
    "After turning in all three named hunts, accept The Ultimate Bloodsport from Hemet. Kill Tusker on the raised ground northeast of Oshu'gun (44.4, 65.9), loot Tusker's Heart and return to Hemet. This final quest completes the achievement; killing the animals before accepting their particular quest does not substitute for the chain.",
}, {
    pin(107,71.5,40.7,1,"Nesingwary Safari - take all three hunting chains"),
    pin(107,37,61,2,"Banthar - western patrol search"), pin(107,42,60,2,"Banthar - eastern patrol search"),
    pin(107,29,34,3,"Bach'lor - herd patrol search"), pin(107,33,30,4,"Gutripper - airborne patrol search"),
    pin(107,44.4,65.9,5,"Tusker - The Ultimate Bloodsport"), pin(107,71.5,40.7,5,"Hemet - final turn-in"),
})

-- https://www.wowhead.com/achievement=1800#comments:id=1601111
-- https://www.wowhead.com/achievement=1800#comments:id=428569
-- https://www.wowhead.com/achievement=1800#comments:id=434910
-- https://www.wowhead.com/npc=19186/kylene
add(1800, "The Outland Gourmet", "Professions", {
    "Learn Outland Cooking in Shattrath and raise it to 75. Track the achievement's 25 dishes: YOU must cook each one. Buying cooked food or merely learning its recipe does not credit it. Sporeling Snack is no longer a criterion.",
    "Visit Kylene in the World's End Tavern (73.5, 32.7 in Shattrath). Learn and cook Fisherman's Feast from Huge Spotted Feltail, Hot Buttered Trout from Enormous Barbed Gill Trout, and Stewed Trout from Barbed Gill Trout. These are easily missed because they are trainer recipes rather than the usual recipe-vendor items.",
    "In Hellfire, complete Legassi's crashed-zeppelin quest chain (49.2, 74.8) for Recipe: Buzzard Bites, then cook it from Buzzard Meat. Buy Ravager Dog from Sid Limbardi at Honor Hold or Cookie One-Eye at Thrallmar, according to faction, and cook it from Ravager Flesh.",
    "In Zangarmarsh, obtain Feltail Delight and Blackened Trout from your faction's vendors: Doba at Orebor, or Zurai/Gambarinka at Swamprat Post/Zabra'jin. Buy Blackened Sporefish from Juno Dufrain at Cenarion Refuge. Mycah in Sporeggar sells Clam Bar for a Glowcap. Cook all four using Spotted Feltail, Barbed Gill Trout, Zangarian Sporefish and Jaggal Clam Meat respectively.",
    "In Nagrand, visit Uriku in Telaar (Alliance) or Nula the Butcher in Garadar (Horde). Buy and cook Grilled Mudfish, Poached Bluefish, Roasted Clefthoof and Talbuk Steak. Bring Figluster's Mudfish, Icefin Bluefish, Clefthoof Meat and Talbuk Venison.",
    "In Blade's Edge, buy Crunchy Serpent and Mok'Nathal Shortribs from Sassa Weldwell at Toshley's Station (Alliance), or Xerintha Ravenoak in Evergrove. Cook them from Serpent Flesh and Raptor Ribs. Horde can also obtain these recipes through Mok'Nathal Treats at Mok'Nathal Village.",
    "In Terokkar, buy Blackened Basilisk and Warp Burger from Supply Officer Mills at Allerian Stronghold (Alliance) or Innkeeper Grilka at Stonebreaker Hold (Horde). Buy Golden Fish Sticks and Spicy Crawdad from Innkeeper Biribi at Allerian or Rungor at Stonebreaker. Cook them using Chunk o' Basilisk, Warped Flesh, Golden Darter and Furious Crawdad.",
    "Do The Rokk's cooking dailies in Shattrath (61.7, 16.2), choosing the reward crates for missing recipes. The six crate recipes are Broiled Bloodfin, Skullfish Soup, Kibler's Bits, Spicy Hot Talbuk, Stormchops and Delicious Chocolate Cake. Relevant Timewalking recipe bags are another source when offered; random rewards can require repeated days.",
    "Cook the final six dishes with Bloodfin Catfish, Crescent-Tail Skullfish, Buzzard Meat, Talbuk Venison and Lightning Eel for their respective recipes. Chocolate Cake also needs 8 Simple Flour, 8 Small Eggs, 4 Ice Cold Milk, 4 Mild Spices, 3 Mageroyal and 1 Flask of Port. Use the tracked missing criteria to finish only the recipes you still need.",
}, {
    pin(111,73.5,32.7,2,"Kylene - three special cooking recipes"), pin(100,49.2,74.8,3,"Legassi - Buzzard Bites quest chain"),
    pin(100,54.3,63.6,3,"Sid Limbardi - Alliance Ravager Dog"), pin(100,56.7,37.5,3,"Cookie One-Eye - Horde Ravager Dog"),
    pin(102,42,28,4,"Doba - Alliance fish recipes"), pin(102,85.2,54.7,4,"Zurai - Horde Feltail Delight"),
    pin(102,31.7,49.4,4,"Gambarinka - Horde Blackened Trout"), pin(102,78.5,63,4,"Juno Dufrain - Blackened Sporefish"),
    pin(102,17.8,51.2,4,"Mycah - Clam Bar for a Glowcap"), pin(107,56.2,73.3,5,"Uriku - Alliance Nagrand recipes"),
    pin(107,58,35.7,5,"Nula - Horde Nagrand recipes"), pin(105,61.2,69,6,"Sassa - Alliance serpent/rib recipes"),
    pin(105,62.4,40.4,6,"Xerintha - Evergrove recipes"), pin(105,76,60.3,6,"Mok'Nathal Village - Horde recipe quests"),
    pin(108,55.7,53.2,7,"Allerian Stronghold - Alliance four-recipe stop"), pin(108,48.8,45.5,7,"Stonebreaker Hold - Horde four-recipe stop"),
    pin(111,61.7,16.2,8,"The Rokk - random daily recipe crates"),
})

-- https://www.wowhead.com/achievement=6587#comments:id=1788453
-- https://www.wowhead.com/achievement=6587#comments:id=1711917 (all pets vs actual criteria)
-- https://www.wowhead.com/achievement=6614#comments:id=1778003
local captureRoute = {
    "In Hellfire Peninsula, capture Adder and Scorpid in the open desert. For Flayer Youngling, fly to the high Razorthorn Rise ridge on the Hellfire/Terokkar border; its Journal zone and the easiest approach do not use the same zone name. Check around 51.6, 11.4 on the TEROKKAR map rather than searching low ground across Hellfire.",
    "In Zangarmarsh, capture Sporeling Sprout around Sporeggar (19.2, 50.6). Capture Small Frog and Snake too; inspect the secondary enemies in local wild battles if a species is not visible as the first opponent.",
    "In Terokkar, capture Stripe-Tailed Scorpid in the Bone Wastes and Warpstalker Hatchling in Raastok Glade. Collect Rat, Skunk and Squirrel while checking battles in the forest. Flayer Youngling belongs on the elevated border ridge described in step 2, not down in the Bone Wastes.",
    "In Nagrand, capture Clefthoof Runt in the northern grasslands near 37, 24. Capture Prairie Dog, Rabbit and Toad in the surrounding plains and lake areas. Check second/third opponents when a common species is missing.",
    "In Blade's Edge, capture Brown Marmot and Rock Viper on the mountain plateaus. Scalded Basilisk Hatchling is east of Gruul's Lair around 71, 21. Skittering Cavern Crawler is in the southern caves near the Zangarmarsh border, including around 34.4, 88.4 and 51, 82.2; it can also join as a secondary opponent.",
    "In Netherstorm, capture Fledgling Nether Ray around the manaforges, plus Mouse and Nether Roach. For Cat, start Nether Roach battles around Kirin'Var Village / Sunfury Hold in the southeast and inspect the secondary opponents. A Cat purchased from a vendor is not a wild capture.",
    "In OUTLAND Shadowmoon Valley, capture Ash Viper and Tainted Cockroach. Search the lava at the Hand of Gul'dan for Fel Flame, checking both sides around 37.4, 30.8 and 38.4, 41.4. Sparse spawns may require revisiting; a guaranteed server-restart spawn is not part of the method.",
}
local capturePins = {
    pin(100,59.2,62.4,2,"Hellfire desert - Adder and Scorpid"), pin(108,51.6,11.4,2,"Razorthorn Rise - elevated Flayer Youngling habitat"),
    pin(108,45.6,5.2,2,"Razorthorn Rise - alternate high ridge"), pin(102,19.2,50.6,3,"Sporeggar - Sporeling Sprout"),
    pin(102,78.5,63,3,"Cenarion Refuge wetlands - check wild battle teams"), pin(108,41,61,4,"Bone Wastes - Stripe-Tailed Scorpid"),
    pin(108,59,45,4,"Raastok Glade - Warpstalker Hatchling"), pin(107,37,23.8,5,"Northern Nagrand - Clefthoof Runt"),
    pin(107,58,30,5,"Nagrand plains and water - common wild species"), pin(105,70.6,21.8,6,"East of Gruul's Lair - Scalded Basilisk Hatchling"),
    pin(105,34.4,88.4,6,"Southern cave - Skittering Cavern Crawler"), pin(105,51,82.2,6,"Southern cave - alternate crawler habitat"),
    pin(109,51.6,83.8,7,"Southeastern Netherstorm - rays and roach battle teams"), pin(109,57.2,68.4,7,"Sunfury Hold - check roach battles for Cat"),
    pin(104,37.4,30.8,8,"Hand of Gul'dan lava - Fel Flame"), pin(104,38.4,41.4,8,"Hand of Gul'dan lava - second search area"),
    pin(104,59.6,46.6,8,"Shadowmoon wild battles - Ash Viper / Tainted Cockroach"),
}
local safariSteps = {
    "Track all 26 required species. Bring a leveled battle team and weaken each missing wild pet until the trap becomes available, then CAPTURE it. Winning by killing it does not count. The route below groups species by practical Outland hunting stops; common species captured elsewhere may already be credited.",
}
for _, step in ipairs(captureRoute) do safariSteps[#safariSteps + 1] = step end
safariSteps[#safariSteps + 1] = "Check the tracked species list and return for missing captures. Cogblade Raptor and the raid-drop pets may be found in Outland but are not among this achievement's 26 required species. Do not spend time farming them for Safari."
add(6587, "Outland Safari", "Pet Battles", safariSteps, capturePins)
add(6614, "Outland Tamer", "Pet Battles", {
    "Capture ONE wild pet in EACH of the seven Outland zones; this is a geographical capture achievement, not the trainer achievement Taming Outland. Take a leveled team and use your trap when a wild opponent is weak enough. Defeating it without a capture will not credit the zone.",
    "Capture an Adder or Scorpid in Hellfire Peninsula's open desert.",
    "Capture a Sporeling Sprout beside Sporeggar in Zangarmarsh, or another local wild species.",
    "Capture a Stripe-Tailed Scorpid in Terokkar's Bone Wastes, or a Warpstalker Hatchling in Raastok Glade.",
    "Capture a Clefthoof Runt in northern Nagrand, OUTLAND, or another pet in that zone.",
    "Capture a Scalded Basilisk Hatchling east of Gruul's Lair in Blade's Edge, or a Brown Marmot elsewhere in the zone.",
    "Capture a Nether Roach or Fledgling Nether Ray in Netherstorm around a manaforge or Sunfury Hold.",
    "Capture an Ash Viper, Tainted Cockroach or Fel Flame in Shadowmoon Valley, OUTLAND. Check all seven zone criteria afterwards. If you already own three of a species, choose another capturable species instead of releasing a valued pet just to make room.",
}, {
    pin(100,59.2,62.4,2,"Hellfire - desert wild pets"), pin(102,19.2,50.6,3,"Zangarmarsh - Sporeggar"),
    pin(108,41,61,4,"Terokkar - Bone Wastes"), pin(108,59,45,4,"Terokkar - Raastok Glade"),
    pin(107,37,23.8,5,"Nagrand - Clefthoof Runts"), pin(105,70.6,21.8,6,"Blade's Edge - basilisk hatchlings"),
    pin(109,57.2,68.4,7,"Netherstorm - Sunfury Hold wild battles"), pin(104,38.4,41.4,8,"Outland Shadowmoon - lava and nearby wild pets"),
})

-- https://www.wowhead.com/achievement=1311#comments:id=350012 and replies
-- https://www.wowhead.com/achievement=1312#comments:id=2020458 and all replies
-- https://www.wowhead.com/achievement=1312#comments:id=6265406 (no guaranteed shard/timer shortcut)
local rareSteps = {
    "Track the missing rare names before flying. Map pins mark reported SEARCH POINTS, not guaranteed stationary spawns. Sweep the land between matching pins and use /targetexact with the full rare name while nearby. These old rares have variable availability; neither a server restart nor War Mode guarantees a spawn.",
    "In Hellfire, search the burrower areas west/south of the Citadel for Fulgorge: look for unusually large moving dirt/rock eruptions and approach on the ground to make the worm emerge. Mekthorg the Wild visits orc camps around the Citadel and Zeth'Gor. Vorakem Doomspeaker appears in the northern/eastern demon camps; check each region instead of camping one point.",
    "In Zangarmarsh, search the broken villages in the northwest, center-south and far southeast for Bog Lurker. Check naga pump camps for Coilfang Emissary. Marticar patrols the west coast, northern marsh and northeast; follow the routes between pins rather than waiting at one endpoint.",
    "In Terokkar, search the whole Bone Wastes around Auchindoun for Crippler. Doomsayer Jurim walks roads around Shattrath, Cenarion Thicket, Tuurem and toward the east; city guards can kill him. Check Veil Reskk, Shienor, Skith and the southeastern arakkoa settlement for Okrek, including platforms above the ground.",
    "In Nagrand, look UNDERWATER in the major lakes for Goretooth, including Sunspring, Skysong and the southeastern lake. Voidhunter Yar patrols around Oshu'gun. Bro'Gaz the Clanless is not a criterion, so his kill does not replace either required rare.",
    "In Blade's Edge, check the long western Netherwing-dragon plateau for Hemathion. Morcrush travels the eastern and northeastern giant areas. Speaker Mar'grom appears among ogre camps in the southwest, west-central and north; search all three regions.",
    "In Netherstorm, check Manaforge Ara, Coruu and Duro for Chief Engineer Lorthander. Ever-Core the Punisher patrols B'naar, Ara and Ultris. Nuramoc FLIES along the southern edge, northern Duro ridge and Stormspire island's western side, so scan above ground level and between its route points.",
    "In OUTLAND Shadowmoon, Ambassador Jerrikar can visit Illidari Point, Eclipse Point, Coilskar Point, the Ruins of Baa'ri and the southern Black Temple area. Collidus the Warp-Watcher has central, northeastern and southeastern patrols. Kraator appears near Legion Hold, the Hand of Gul'dan, Eclipse Point, northern Coilskar and the area north of Warden's Cage. Search every missing rare's separate regions on later circuits.",
}
local rarePins = {
    pin(100,24.8,49.6,2,"Fulgorge - western burrower search"), pin(100,32.4,60.6,2,"Fulgorge - central-west search"), pin(100,58.6,71.6,2,"Fulgorge - southern search"),
    pin(100,47.2,57.6,2,"Mekthorg - Citadel orc camps"), pin(100,45.2,40.6,2,"Mekthorg - northern orc camps"), pin(100,67.6,76.8,2,"Mekthorg - Zeth'Gor"),
    pin(100,42.6,31.8,2,"Vorakem - western demon camps"), pin(100,65.6,30.6,2,"Vorakem - northern demon camps"), pin(100,72.8,57.2,2,"Vorakem - eastern demon camps"),
    pin(102,22.8,28.4,3,"Bog Lurker - northwest"), pin(102,40.8,62.2,3,"Bog Lurker - south-central"), pin(102,84.4,79.2,3,"Bog Lurker - southeast"),
    pin(102,25.8,42.6,3,"Coilfang Emissary - western pump"), pin(102,63,38,3,"Coilfang Emissary - northern pump"), pin(102,62,69.6,3,"Coilfang Emissary - southern pump"), pin(102,73.6,82.2,3,"Coilfang Emissary - southeast pump"),
    pin(102,10,52.4,3,"Marticar - west coast"), pin(102,48,30,3,"Marticar - northern patrol"), pin(102,79.6,53.6,3,"Marticar - northeast patrol"),
    pin(108,32.4,63.4,4,"Crippler - western Bone Wastes"), pin(108,46.6,78.8,4,"Crippler - southern Bone Wastes"), pin(108,50.6,62.4,4,"Crippler - eastern Bone Wastes"),
    pin(108,35.8,35.8,4,"Jurim - Shattrath-side road"), pin(108,41.6,26.2,4,"Jurim - Cenarion Thicket road"), pin(108,58,33.6,4,"Jurim - eastern road"), pin(108,68,46.6,4,"Jurim - southeast road"),
    pin(108,49.6,18.2,4,"Okrek - Veil Reskk"), pin(108,59.2,24.2,4,"Okrek - Veil Shienor"), pin(108,31,43,4,"Okrek - Veil Skith"), pin(108,56.6,67.8,4,"Okrek - southeastern arakkoa camp"),
    pin(107,35.4,47.2,5,"Goretooth - Sunspring water"), pin(107,42.2,40,5,"Goretooth - central lake"), pin(107,58.8,28.8,5,"Goretooth - Skysong water"), pin(107,76.6,78.8,5,"Goretooth - southeast lake"),
    pin(107,35.8,65.6,5,"Voidhunter Yar - north Oshu'gun"), pin(107,34.6,76.8,5,"Voidhunter Yar - south Oshu'gun"),
    pin(105,30.8,71.8,6,"Hemathion - southern western plateau"), pin(105,32,54.8,6,"Hemathion - central western plateau"), pin(105,30,44.8,6,"Hemathion - northern western plateau"),
    pin(105,68.6,73.8,6,"Morcrush - southeast"), pin(105,70.8,42.8,6,"Morcrush - east"), pin(105,77.6,24,6,"Morcrush - northeast"), pin(105,59,25.4,6,"Morcrush - northern giants"),
    pin(105,42.8,81.2,6,"Speaker Mar'grom - southern ogres"), pin(105,39.8,57,6,"Speaker Mar'grom - western ogres"), pin(105,64.4,19.2,6,"Speaker Mar'grom - northern ogres"),
    pin(109,26.6,42,7,"Lorthander - Manaforge Ara"), pin(109,46.6,83.2,7,"Lorthander - Manaforge Coruu"), pin(109,58.6,64,7,"Lorthander - Manaforge Duro"),
    pin(109,23,64.6,7,"Ever-Core - Manaforge B'naar patrol"), pin(109,30.8,41.8,7,"Ever-Core - Manaforge Ara patrol"), pin(109,62.8,32.4,7,"Ever-Core - Manaforge Ultris patrol"),
    pin(109,25,82.4,7,"Nuramoc - southern airborne route"), pin(109,67.6,61,7,"Nuramoc - Duro airborne route"), pin(109,35.8,20.8,7,"Nuramoc - Stormspire airborne route"),
    pin(104,29.8,52.2,8,"Jerrikar - Illidari Point"), pin(104,46.8,70.8,8,"Jerrikar - Eclipse Point"), pin(104,45.6,31.2,8,"Jerrikar - Coilskar"), pin(104,57.4,37,8,"Jerrikar - Ruins of Baa'ri patrol"), pin(104,71.6,61.8,8,"Jerrikar - south of Black Temple"),
    pin(104,38.6,42.4,8,"Collidus - central patrol"), pin(104,66.8,21.8,8,"Collidus - northeast patrol"), pin(104,64.6,68,8,"Collidus - southeast patrol"),
    pin(104,31.2,45.6,8,"Kraator - Legion Hold foothills"), pin(104,42,40,8,"Kraator - Hand of Gul'dan"), pin(104,42,68.8,8,"Kraator - Eclipse region"), pin(104,45.6,12.6,8,"Kraator - north Coilskar"), pin(104,59.6,46.6,8,"Kraator - Warden's Cage region"),
}
for _, target in ipairs({ {1311,"Medium Rare"}, {1312,"Bloody Rare"} }) do
    local steps = {}
    for index, text in ipairs(rareSteps) do steps[index] = text end
    steps[1] = (target[1] == 1311 and "Kill ANY ONE of the twenty Outland rares below. You can stop after the first credited kill. " or "Kill ALL TWENTY different Outland rares below. Repeating one rare cannot replace another. ") .. steps[1]
    steps[#steps + 1] = target[1] == 1311 and "Confirm Medium Rare has credited after your kill. Buying one of the rare's tradable drops does not count as killing it." or "After each circuit, check off credited names and revisit only missing creatures. Progress is account-wide, but every required NAME must be killed; no fixed respawn schedule or single empty pin proves a rare is unavailable."
    add(target[1], target[2], "Exploration", steps, rarePins)
end

-- Story achievements now require named chapters, not the old quest totals.
-- https://www.wowhead.com/achievement=1189#comments:id=643387
-- https://www.wowhead.com/achievement=1189#comments:id=643389
-- https://www.wowhead.com/achievement=1189#comments:id=2553560 and reply
add(1189, "To Hellfire and Back", "Quests", {
    "On an ALLIANCE character, enable Trivial Quests and track the eight chapter criteria. Begin at Honor Hold with Danath and the introductory Legion quests. Retail uses chapter completions, so old advice to reach a fixed quest count, obtain a Shattered Halls key or grind PvP repeatables is obsolete.",
    "For Disrupt the Burning Legion, follow The Legion Reborn -> The Path of Anguish -> Expedition Point -> Disrupt Their Reinforcements. Complete the gateway bombing mission, report to Shatter Point, and continue the Abyssal Shelf / forge-camp chain through Invasion Point: Annihilator. Use the mission flight NPC and supplied bombs when the quest asks for a bombing run.",
    "For Overthrow the Overlord, loot the Burning Legion Missive from the northern demons, start The Dark Missive and finish The Heart of Darkness / Overlord with Honor Hold. Kill Arazzius the Cruel at the Pools of Aggonar and return; a kill before accepting the quest will not finish the chapter.",
    "Follow Expedition Point's fel-orc chain through Fel Orc Scavengers, Ill Omens, Cursed Talismans and Warlord of the Bleeding Hollow. Return to Honor Hold. Digging for Prayer Beads and Fel Spirits lead to The Exorcism of Colonel Jules: speak to Anchorite Barada upstairs in the inn and protect the ritual. Continue Trollbane is Looking for You -> Drill the Drillmaster, kill Drillmaster Zurok and turn in. These are two separate chapters.",
    "At Temple of Telhamat, complete Obadei/Makuru's In Search of Sedai -> Return to Obadei -> Makuru's Vengeance -> Atonement, and follow the relic investigation through The Seer's Relic at Sedai's body. For the Temple chapter, also finish its Pools of Aggonar cleansing and local arakkoa/ravager chains, following The Longbeards to the southern camp when offered.",
    "For Green, But Not Orcs, do BOTH goblin groups. Foreman Razelcraz outside the mine northwest of Thrallmar offers Outland Sucks! -> How to Serve Goblins -> Shizz Work -> Beneath Thrallmar. At Zeppelin Crash, finish Screed's In Case of Emergency... / Voidwalkers Gone Wild and Legassi's Ravager Egg Roundup -> Hellboar, the Other White Meat -> Smooth as Butter.",
    "At Cenarion Post in western Hellfire, finish Demonic Contamination -> Testing the Antidote. Complete Colossal Menace, loot the giants' Crimson Crystal Shard and follow The Earthbinder -> Natural Remedies, using the supplied quest item at the marked green rune and finishing the resulting event. Turn in and check all eight named chapters.",
}, {
    pin(100,56.6,66.7,1,"Honor Hold - Danath and introductory chains"), pin(100,71,63,2,"Expedition Point - Legion missions"),
    pin(100,78.5,35,2,"Shatter Point - mission flights"), pin(100,43.5,31.6,3,"Arazzius - Pools of Aggonar"),
    pin(100,56.7,66.5,4,"Honor Hold - exorcism / Drillmaster follow-ups"), pin(100,54.5,83.7,4,"Drillmaster Zurok - southern fel-orc camp"),
    pin(100,23.4,39.8,5,"Temple of Telhamat - Sedai and Temple chapters"), pin(100,26.8,37.5,5,"Sedai's body - relic investigation"),
    pin(100,23.9,72.3,5,"Longbeards' camp - southern follow-ups"), pin(100,51.2,30.6,6,"Foreman Razelcraz - mine chain"),
    pin(100,49.2,74.8,6,"Zeppelin Crash - finish BOTH goblins' chains"), pin(100,15.7,52,7,"Cenarion Post - contamination and colossi"),
    pin(100,13.9,39.1,7,"Natural Remedies - quest-event rune"),
})

-- https://www.wowhead.com/achievement=1271#comments:id=2588180 and both replies
-- https://www.wowhead.com/quest=10876/the-foot-of-the-citadel
-- https://www.wowhead.com/quest=9400/the-assassin
add(1271, "To Hellfire and Back", "Quests", {
    "On a HORDE character, enable Trivial Quests and track the eight story chapters. Start Thrallmar's Nazgrel chain and report to Reaver's Fall. Follow Eradicate the Burning Legion, the gateway bombing missions and the Abyssal Shelf mission to finish Disrupt the Burning Legion. Take mission flights from the named quest NPC; do not look for the old dungeon attunements.",
    "For Cruel's Intentions, continue Nazgrel's northern forge-camp chain through Forge Camp: Mageddon, Cannons of Rage and Doorway to the Abyss. Accept Cruel's Intentions, kill Arazzius the Cruel at the Pools of Aggonar and return to Nazgrel.",
    "For The Mag'har, take The Assassin from Nazgrel. Find the Fel Orc Corpse west of the Pools (33.6, 43.5), complete A Strange Weapon / The Warchief's Mandate and use the supplied spirit item for A Spirit Guide. FOLLOW the wolf to Mag'har Post, then finish The Mag'har and its reporting follow-ups. This is also useful for opening Nagrand's Mag'har quests.",
    "For Spinebreaker Post and The Hand of Kargath, complete the apothecary chain beginning with Bonechewer Blood, following Zelana to Spinebreaker and Boiling Blood back to Antonivich. Continue A Burden of Souls -> The Demoniac Scryer -> Report to Nazgrel -> The Foot of the Citadel. Kill Gorax beneath the Citadel, plant the supplied challenge on his corpse, then kill and loot the summoned Hand of Kargath; turn in his head.",
    "At Falcon Watch, finish the blood-elf expedition's local investigations, including its arakkoa/Avruu and missing-ranger rescue chains. Check inside the tower as well as the ground-level camp for follow-ups. Turn in the final chapter quests rather than assuming the first set of local kills is enough.",
    "For Green, But Not Orcs, finish all four Razelcraz mine quests outside the mine northwest of Thrallmar: Outland Sucks!, How to Serve Goblins, Shizz Work and Beneath Thrallmar. ALSO complete both goblins' chains at Zeppelin Crash: Screed's salvage/voidwalkers and Legassi's eggs -> hellboar -> Smooth as Butter. The mine alone does not credit this chapter.",
    "At Cenarion Post, complete Demonic Contamination -> Testing the Antidote. Finish Colossal Menace, start the giants' Crimson Crystal Shard quest and continue The Earthbinder -> Natural Remedies. Use the quest item at the marked rune, finish the event and turn in. Check the eight story criteria; old numeric quest totals and removed key chains are unnecessary.",
}, {
    pin(100,55,36,1,"Thrallmar - Nazgrel"), pin(100,66,43.8,1,"Reaver's Fall - mission flights"),
    pin(100,43.5,31.6,2,"Arazzius - Cruel's Intentions"), pin(100,33.6,43.5,3,"Fel Orc Corpse - The Assassin"),
    pin(100,32,27.8,3,"Mag'har Post - spirit-wolf destination"), pin(100,61.7,81.2,4,"Spinebreaker Post - apothecary chain"),
    pin(100,48.4,50.1,4,"Foot of the Citadel - Gorax / Hand of Kargath"), pin(100,27,60,5,"Falcon Watch - blood-elf quest chains"),
    pin(100,51.2,30.6,6,"Razelcraz - four mine quests"), pin(100,49.2,74.8,6,"Zeppelin Crash - Legassi AND Screed"),
    pin(100,15.7,52,7,"Cenarion Post - contamination and colossi"), pin(100,13.9,39.1,7,"Natural Remedies - event rune"),
})

-- https://www.wowhead.com/achievement=1190#comments:id=3205947
-- https://www.wowhead.com/achievement=1190#comments:id=3205948
-- https://www.wowhead.com/achievement=1190#comments:id=2552759 and replies
add(1190, "Mysteries of the Marsh", "Quests", {
    "Enable Trivial Quests and track your FACTION's chapter list. Both factions complete the Cenarion Refuge, Leesa'oh and Sporeggar stories; Alliance additionally uses Telredor/Orebor, while Horde uses Swamprat Post/Zabra'jin. Current progress follows named stories rather than an old 52/54-quest counter.",
    "At Ysiel Windbringer in Cenarion Refuge (78.4, 62), complete Disturbance at Umbrafen Lake -> As the Crow Flies -> Balance Must Be Preserved. Loot the Drain Schematics from naga, bring them back and continue Warning the Cenarion Circle to Cenarion Post in Hellfire (16, 52.2). Return to Ysiel with Return to the Marsh to finish Draining the Marsh.",
    "For Saving the Sporeloks, finish the Refuge's Umbrafen Tribe, A Damp, Dark Place, Saving the Sporeloks and Safeguarding the Watchers quests. Lauranna, Windcaller Blackhoof and Lethyn are close together around 80, 64. Enter Funggor Cavern for its actual cave objectives and return for every follow-up.",
    "For Don't Eat THOSE Mushrooms!, find Watcher Leesa'oh at Cenarion Watchpost (23.3, 66.2). Follow A Question of Gluttony -> Familiar Fungi -> Stealing Back the Mushrooms. These quests are away from the main Refuge and are easy to miss when following only the road hubs.",
    "For A Trip With the Sporelings, start Fahssn's Spawning Glen introductions (19, 63), then follow the invitation to Sporeggar. Raise Sporeggar to Friendly if necessary and complete Now That We're Friends... against the naga. Also complete Fhwoor Smash!'s escort when offered; Fhwoor can be absent while another player's escort is active, so wait for him to return rather than repeatedly grinding an unrelated reputation quest.",
    "ALLIANCE: At Telredor, finish its quests through An Unnatural Drought. Follow the Feralfen investigation through Messenger to the Feralfen for Draenei Diplomacy; use the quest disguise/potion as instructed instead of attacking the friendly quest objective. At Orebor Harborage, finish the Broken's bog-giant/naga and Marshlight Lake chain through The Terror of Marshlight Lake.",
    "HORDE: At Swamprat Post, finish the Dead Mire investigation through Jyoba's Report. At Zabra'jin, follow the wildlife hunt through Pursuing Terrorclaw. Finish the defenses against Ango'rosh and Daggerfen through Message to the Daggerfen. Return for the final hand-ins, then check the seven chapters applicable to your faction.",
}, {
    pin(102,78.4,62,2,"Ysiel - Draining the Marsh"), pin(100,16,52.2,2,"Cenarion Post - Warning / Return to the Marsh"),
    pin(102,80.4,64.2,3,"Cenarion Refuge - Sporelok quest givers"), pin(102,74.5,92,3,"Funggor Cavern - cave quest objectives"),
    pin(102,23.3,66.2,4,"Watcher Leesa'oh - mushroom storyline"), pin(102,19,63,5,"Fahssn - Spawning Glen introductions"),
    pin(102,18,51,5,"Sporeggar - naga quest and Fhwoor escort"), pin(102,68,49,6,"Telredor - Alliance stories"),
    pin(102,42,28,6,"Orebor Harborage - Alliance stories"), pin(102,85.2,54.7,7,"Swamprat Post - Horde stories"),
    pin(102,31,50,7,"Zabra'jin - Horde stories"),
})

-- https://www.wowhead.com/achievement=1272#comments:id=2556037 and all replies
-- https://www.wowhead.com/achievement=1272#comments:id=6236026
for _, variant in ipairs({ {1191,"Allerian Stronghold",55.7,53.2}, {1272,"Stonebreaker Hold",49,46} }) do
    local alliance = variant[1] == 1191
    add(variant[1], "Terror of Terokkar", "Quests", {
        "Enable Trivial Quests and track the five chapter criteria. Start at " .. variant[2] .. ". Complete its arakkoa investigations, wolf/seed errands and Torgos hunt; for Torgos, kill Trachela at Carrion Hill, loot the carcass and use it at Torgos's Scarecrow in Veil Rhaze. " .. (alliance and "Follow Jenai Starwhisper, Ros'eleth, Bertelm and the other Allerian quest givers through their final hand-ins." or "Finish Rokag/Faila, Malukaz's wolf-spirit chain and Rakoria's seed-oil chain. At Grangol'var, speak to Scout Neftis, complete Who Are They? while disguised, then Kill the Shadow Council!; mounting cancels the disguise."),
        "For The Warden's Secret, start Earthbinder Tavgren's investigation at Cenarion Thicket (44, 26). Finish Strange Energy, Clues in the Thicket and Watching You!, then stop Empoor on the road for By Any Means Necessary.... Follow Wind Trader Lathrai's favors in Shattrath and the Tuurem investigation back to Tavgren. The story crosses maps rather than ending with one local kill quest.",
        "Continue the Firewing investigation via your faction's camp east of its stronghold. Kill Sharth Voldoun on Firewing Point's upper platform, using the translocation orb inside the tower to reach him. Loot the Final Code, activate the mana bomb and finish Letting Earthbinder Tavgren Know. This final report is a commonly missed part of the Warden chapter.",
        "For The Skettis Offensive, start Kirrik's arakkoa chain at Refugee Caravan (37.3, 51). Visit Rilak the Redeemed in Shattrath's Lower City, gather the Eyes of Skettis at Veil Reskk/Shienor, then work through Kirrik's Veil Skith -> Rhaze -> Lithic -> Shalas follow-ups. Return to Shattrath and complete Defender Grashna's Skettis Offensive event. Sha'tari Skyguard Exalted is not required.",
        "For Refugee Caravan, complete Mekeda's Before Darkness Falls, loot Cabal Orders and follow The Shadow Tomb. Finish Ethan's Missing Friends, Lakotae's Infested Protectors, Orglum's Tomb of Lights / Vengeful Souls and Soolaveen's Recover the Bones. Follow Ramdor's Helping the Lost Find Their Way when offered; the caravan's different NPC chains all matter.",
        "For Sha'tari Base Camp, visit Letoll near 31.3, 76.2. Stay with the Digging for Bones event, then finish Dwarfowitz's Fumping -> The Big Bone Worm. Complete Ra'vaj's Improper Burial -> A Hero Is Needed -> The Fallen Exarch. Also finish Vindicator Haylen's For the Fallen -> Terokkarantula -> Return to Sha'tari Base Camp; Haylen stands east of Auchindoun and is easy to overlook.",
        "Turn in the final reports to your stronghold, Tavgren, Rilak/Grashna, Refugee Caravan and Sha'tari Base Camp as appropriate. Check the five named chapters instead of following old advice to reach a numeric quest total. A quest completed but still waiting for its final report may leave its chapter unfinished.",
    }, {
        pin(108,variant[3],variant[4],1,variant[2] .. " - faction quest chains"), pin(108,43.2,51.4,1,"Trachela - loot Torgos bait"), pin(108,27,55.6,1,"Veil Rhaze - Torgos's Scarecrow"),
        pin(108,44,26,2,"Tavgren - Cenarion Thicket investigation"), pin(108,40.1,25.8,2,"Empoor - road patrol search"), pin(111,72.2,30.7,2,"Wind Trader Lathrai - investigation follow-ups"),
        pin(108,73.3,34.7,3,"Firewing Point - tower / translocation orb"), pin(108,44,26,3,"Tavgren - FINAL report"),
        pin(108,37.3,51,4,"Kirrik - Refugee Caravan"), pin(111,52.6,20.8,4,"Rilak and Grashna - Skettis Offensive chain"),
        pin(108,50.1,19.4,4,"Veil Reskk - Eye of Skettis"), pin(108,57.9,23.1,4,"Veil Shienor - Eye of Skettis"),
        pin(108,30.9,42,4,"Veil Skith"), pin(108,27,55.6,4,"Veil Rhaze"), pin(108,23,73,4,"Veil Lithic"), pin(108,57,65,4,"Veil Shalas"),
        pin(108,37.3,51,5,"Refugee Caravan - all resident quest chains"), pin(108,31.2,52.7,5,"Shadow Tomb - Cabal Orders follow-up"),
        pin(108,31.3,76.2,6,"Sha'tari Base Camp - Letoll / Ra'vaj"), pin(108,49.7,76.3,6,"Vindicator Haylen - Terokkarantula chain"),
    })
end

-- https://www.wowhead.com/achievement=1273#comments:id=2557209 and all four replies
-- https://www.wowhead.com/achievement=1192#comments:id=5191807 and 2026 reply
-- https://www.wowhead.com/achievement=1192#comments:id=5408820
-- https://www.wowhead.com/quest=10167/auchindoun
for _, variant in ipairs({ {1192,"Telaar",54.5,72.3}, {1273,"Garadar",55,36} }) do
    local alliance = variant[1] == 1192
    local points = {
        pin(107,variant[3],variant[4],1,variant[2] .. " - faction introductions"),
        pin(107,73.8,62.6,3,"Lantresor - diplomatic chain"), pin(107,60.5,22.5,4,"Throne of the Elements - elemental chains"),
        pin(107,72.5,44.2,4,"Air elementals - Howling Wind quest drop"), pin(107,29,25,4,"Warmaul Hill - Gurok quest area"),
        pin(107,32,43,5,"Sunspring Post / mounted invaders - Murkblood objectives"),
        pin(107,27.3,43,6,"Altruis - Forge Camp: Annihilated chain"), pin(111,77.3,34.9,6,"Lower City tavern - Sal'salabim"),
        pin(107,variant[3],variant[4],6,variant[2] .. " - WANTED poster and final reports"), pin(107,30.8,58.2,7,"Aeris Landing - Consortium story"),
        pin(107,42.7,20.7,8,"Gurgthock - all six Ring of Blood fights"), pin(107,71.5,40.7,9,"Nesingwary Safari - three Mastery chains"),
        pin(107,44.4,65.9,9,"Tusker - loot heart and return to Hemet"),
    }
    if alliance then
        points[#points + 1] = pin(107,72.5,70.7,2,"Corki - HELP! cage in Burning Blade Ruins")
        points[#points + 1] = pin(107,39.3,27.4,2,"Corki - cage at back of Northwind Cleft")
        points[#points + 1] = pin(107,29.4,26,2,"Corki - Warmaul Hill cage")
        points[#points + 1] = pin(107,27.2,18.7,2,"Northern Warmaul cave - route to Cho'war's key")
    else
        points[#points + 1] = pin(108,19.8,60.8,2,"Kilrath - Horde Unkor chain")
        points[#points + 1] = pin(107,32,36,5,"Mag'hari Procession - Horde follow-ups")
        points[#points + 1] = pin(107,55.5,37.6,10,"Garadar - Greatmother / Thrall finale")
        points[#points + 1] = pin(108,34.34,65.61,10,"Auchenai Crypts - Maladaar / D'ore quest")
        points[#points + 1] = pin(85,48.5,70.7,10,"Orgrimmar - Thrall reporting step")
    end
    add(variant[1], "Nagrand Slam", "Quests", {
        "Use Nagrand in OUTLAND and enable Trivial Quests. Track the eight story chapters for your faction. Start at " .. variant[2] .. "; the achievement follows completed stories, not the old 75/85-quest total. Do not substitute Halaa repeatables or unrelated Shadowmoon quests for a missing chapter.",
        alliance and "For The Adventures of Corki, take HELP! from Corki's Burning Blade Ruins cage (72.5, 70.7), obtain the Boulderfist Key from the local ogres and free him. Report to Arechron in Telaar for Corki's Gone Missing Again!, then rescue him at the back of Northwind Cleft (39.3, 27.4). Return for Corki's Ransom, find his Warmaul Hill cage and take Cho'war the Pillager. The key comes from Cho'war in the upper cave system; return to Corki's cage after looting it. One rescue does not complete all three adventures." or "For Lantresor's opening, follow Jorin Deadeye's The Impotent Leader to Kilrath in Terokkar. In Don't Kill the Fat One, weaken Unkor until he submits instead of killing him; overleveled characters must control their damage. Return through Success! / Because Kilrath Is a Coward, then finish Message in a Battle, Standards and Practices, An Audacious Advance and Bleeding Hollow Supply Crates. These open Diplomatic Measures.",
        "For Lantresor of the Blade, follow your faction's Diplomatic Measures to Lantresor in Burning Blade Ruins (73.8, 62.6). Complete Ruthless Cunning and Armaments for Deception, then Returning the Favor / Body of Evidence and the final message back to your faction town. Use the supplied banners/bodies for the quest objectives instead of just clearing the camp.",
        "For Throne of the Elements, finish the elementalists' Skysong, earth and fire chains. Continue Gordawg's The Tortured Earth -> Eating Damnation -> Shattering the Veil -> Gurok the Usurper; collect the ogre skulls and summon Gurok at Warmaul Hill. Also loot The Howling Wind from air elementals, start its quest and finish Bring Me the Egg! and its follow-up where offered. Drop-started quests can be the missing link.",
        "For The Murkblood, complete the Sunspring / captive rescue quests from your faction town. Kill the mounted Murkblood Invaders traveling in groups of three, LOOT their invasion plans and start the resulting quest. " .. (alliance and "Finish Telaar's Murkblood reports and the captive escort; the mounted invaders' item chain is separate from simply killing the village mobs." or "Finish Vile Idolatry / Murkblood Leaders..., rescue the Mag'har captive, and follow The Missing War Party to the Mag'hari Procession. Complete War on the Warmaul before Cho'war the Pillager, then the procession's remaining reports through He Will Walk the Earth...."),
        "For Threats to Nagrand, complete all WANTED poster quests in your town, ending with Durn the Hungerer. ALSO finish Altruis the Sufferer's forge-camp chain from 27.3, 43: Survey the Land, Buying Time, The Master Planner, Patience and Understanding and Forge Camp: Annihilated. Patience and Understanding sends you to Sal'salabim in Shattrath's Lower City tavern; that trip is required even if no obvious map marker appears.",
        "For Encountering the Ethereals, visit Aeris Landing (30.8, 58.2), finish Zerid's Matters of Security and Gava'xi, and turn in the crystal/ivory introductions offered by the nearby Consortium NPCs. Follow the single-use story quests; repeating membership/reputation hand-ins is not a replacement.",
        "For The Ring of Blood, speak to Gurgthock (42.7, 20.7). Complete all six arena quests in order, through The Final Challenge. Stay inside the arena for each spawned opponent and return to the quest giver between fights; killing an unrelated ogre outside the event gives no arena progress.",
        "For The Ultimate Bloodsport, take all three Mastery chains at Nesingwary Safari (71.5, 40.7). Each chain has two hunting stages and its named hunt: Banthar, Bach'lor or Gutripper. After turning in all three, take The Ultimate Bloodsport, kill Tusker (44.4, 65.9), loot the heart and return to Hemet. The separate Hills Like White Elekk guide details these hunts.",
        alliance and "Check all eight chapters after their final hand-ins. If Threats is missing, check BOTH the WANTED poster and Altruis; if Murkblood is missing, look for the mounted invaders' dropped plans. If Corki is missing, return to Arechron for the next rescue instead of repeating the first cage." or "For Birth of a Warchief, finish Lantresor's final Message to Garadar, then take A Visit With the Greatmother. Follow Greatmother Geyah's chain through Garadar, Nagrand and Auchindoun.... Enter Auchenai Crypts, kill Exarch Maladaar and speak to D'ore for What the Soul Sees. Finish the ancestral-spirit objectives, return to Geyah and carry the message to Thrall in Orgrimmar. Stay for his return/dialogue in Garadar and complete the final hand-in; the dungeon is a required chain step, not an optional detour.",
    }, points)
end

-- https://www.wowhead.com/achievement=1193#comments:id=2556997 and ALL seven replies
-- https://www.wowhead.com/achievement=1193#comments:id=2551066 and replies
-- https://www.wowhead.com/achievement=1193#comments:id=5401965
add(1193, "On the Blade's Edge", "Quests", {
    "Enable Trivial Quests and track the FOUR chapters for your faction. Alliance needs Sylvanaar, Toshley's Station, The Gronn Threat and Ruuan Weald. Horde needs Thunderlord Stronghold, The Mok'Nathal, Reunion and Ruuan Weald. The old Ogri'la/Apexis-relic chapter is removed; neither its reputation grind nor its daily unlock is required.",
    "ALLIANCE - Sylvanaar: start Commander Skyshadow's Bloodmaul/Bladespire ogre chains. Rescue Vindicator Vuuleen in the Bladespire cage, recover The Trappings of a Vindicator from Droggam and Mugdorg, kill Gorr'Dim, then complete Planting the Banner in Northmaul Tower. Follow Where Did Those Darn Gnomes Go? to the gnome wreck rather than stopping at the banner.",
    "ALLIANCE - Toshley's Station: follow the R-3D0 / gnome introductions to Toshley's Station (60.5, 69). Complete the power-converter, lightning, trapping and Show Them Gnome Mercy! chains. Finish the Test Flight quests, INCLUDING Test Flight: Ruuan Weald and its arrival hand-in; merely flying to Evergrove yourself does not finish the test-flight chain.",
    "HORDE - Thunderlord Stronghold: complete Gor'drek's wildlife chains and Tor'chunk's Bladespire Threat. Loot Thunderlord Clan Artifacts from the ogres and follow Rokgah's Vision Guide to The Thunderspike, inside the southern cave. Also finish T'chali's Bloodmaul Ravine chain: recover his hookah/brews, use the keg on the quest targets, kill Grimnok/Korgaah and finish A Curse Upon Both of Your Clans!.",
    "HORDE - The Mok'Nathal: at Mok'Nathal Village (76, 60), finish Dertrok's Vekhnir stone chain through Trial and Error. Follow Leoroxx's Understanding the Mok'Nathal -> Since Time Forgotten... -> Slay the Brood Mother -> Totems of My Enemy -> Spirit Calling -> Gather the Orbs -> Inform Leoroxx! -> There Can Be Only One Response. Turn in the Ruuan Weald breadcrumb too; comments identify it as a missing final hand-in.",
    "HORDE - Reunion / ALLIANCE - The Gronn Threat: follow your faction's introduction to Rexxar/Baron Sablemane. Horde starts Garm Wolfbrother's Whispers on the Wind and Leoroxx's Reunion before Rexxar's tasks. Complete Sablemane's Churning Gulch poison, The Smallest Creatures (use the controlled marmot), A Boaring Time for Grulloc, It's a Trap!, Gorgrom's Altar and Prisoner of the Bladespire. Finish Showdown at the northern altar and return for the final report.",
    "BOTH - Ruuan Weald: start Evergrove's Culling the Wild and loot the Damaged Mask. Follow Mystery of the Mask -> Felsworn Gas Mask. WEAR the mask at Forge Camp: Anger to speak to the communicator, then finish Deceive Thy Enemy, You're Fired! and the Death's Door flare/cannon chain through The Hound-Master. For the cannon mission, collect the requested fel ammunition and use the provided control rather than your own attacks on the gate.",
    "Also finish Evergrove's Creating the Pendant / Whispers of the Raven God and Tree Warden Chawn's Wyrmcult investigation. Loot the note, follow Wyrmskull Watcher / Longtail, enter Blackwing Coven (32, 33.7), assemble the disguise from five costume scraps and talk to Kolphis Darkscale inside. Continue Maxnar Must Die! and return to Evergrove. Check the four applicable chapters; do not start an unrelated Ogri'la crystal grind to fill a removed criterion.",
}, {
    pin(105,36,66,2,"Sylvanaar - Alliance chapter"), pin(105,44,51.8,2,"Vuuleen - Bladespire cage"), pin(105,46.5,74.4,2,"Northmaul Tower - Planting the Banner"),
    pin(105,55,72.8,3,"Gnome wreck - R-3D0 introductions"), pin(105,60.5,69,3,"Toshley's Station - Alliance gnome chains"),
    pin(105,52.2,57.7,4,"Thunderlord Stronghold - Horde chapter"), pin(105,45,72.2,4,"T'chali - Bloodmaul Ravine"), pin(105,39.8,85.5,4,"Southern cave - Thunderspike route"),
    pin(105,76,60,5,"Mok'Nathal Village - Dertrok / Leoroxx"), pin(105,53,41,6,"Circle of Blood - Baron Sablemane"),
    pin(105,51.8,58.4,6,"Thunderlord Stronghold - Horde Rexxar chain"), pin(105,63.8,19.6,6,"Northern altar - Showdown"),
    pin(105,61.5,39.3,7,"Evergrove - Ruuan Weald quests"), pin(105,73.2,40,7,"Forge Camp: Anger - wear Felsworn Gas Mask"),
    pin(105,64.5,33.1,8,"Veil Ruuan - pendant / raven-god quests"), pin(105,32,33.7,8,"Blackwing Coven cave entrance"), pin(105,32.6,37.4,8,"Kolphis - follow right inside cave"),
})

-- https://www.wowhead.com/achievement=1194#comments:id=2556486
-- https://www.wowhead.com/achievement=1194#comments:id=3121828 and all four replies
-- https://www.wowhead.com/achievement=1194#comments:id=6387238 (conditional Retail credit report)
-- https://www.wowhead.com/quest=10257/capturing-the-keystone
-- https://www.wowhead.com/quest=10440/success
-- https://www.wowhead.com/quest=10409/deathblow-to-the-legion
add(1194, "Into the Nether", "Quests", {
    "Track all SIX Netherstorm chapters. First choose Aldor OR Scryers in Shattrath through A'dal, Khadgar's City of Light tour and the faction-choice quest; speak to your chosen leader afterwards. The choice opens necessary inn quests in Area 52 even though the rest of the zone is faction-neutral.",
    "For Protect Area 52!, work through the goblins' local defense chains from Area 52, including the crystal/rock-flayer and manaforge threats. For Building the X-52 Nether-Rocket, follow Rocket-Chief Fuselage's parts and testing quests, including the robot escort through the Ruins of Enkaat. Return with every requested component and complete the rocket's final test/report.",
    "For Socrethar, take your Aldor/Scryer contacts' Manaforge B'naar quests inside Area 52's inn. Follow the shutdown and intelligence chain through the later manaforges, collecting the overseers' crystals and protecting the shutdown consoles. Continue the leader/reporting quests until offered your faction's Socrethar finale; a single B'naar shutdown is not the entire chapter.",
    "Use the supplied teleportation/disguise quest item to reach Socrethar's Seat from the northwestern Legion teleporter. Complete the scripted confrontation and your faction's final report. Accept the quest BEFORE attacking Socrethar; killing a visible NPC out of sequence does not replace the story event.",
    "For The Violet Tower, go to Kirin'Var Village in the southeast. Follow the ghost investigators' chains through the village's book/relic and restless-spirit objectives, including the culminating Naberius quest. Follow the Vargoth investigation too: recover access to his tower, speak to his image and continue Capturing the Keystone.",
    "Enter The Botanica, the northern Tempest Keep dungeon, for Capturing the Keystone. Loot the Keystone from COMMANDER SARANNIS, the first boss, then return to Archmage Vargoth at the Violet Tower. It is not a Warp Splinter drop. Completing this part can also unblock the eco-dome Consortium follow-up Success!.",
    "The Consortium chapter needs FOUR endpoints. For Full Triangle, start Khayji's Area 52 crystal/Heap/Warp-Raider Nesaad chain, follow Gahruj at Midrealm Post to Haramad at the Stormspire, then finish both triangulation points and Full Triangle. Turn in the final crystal report, not just the first measurement.",
    "For Success!, finish Mehrdad's Diagnostic! / New Opportunities / Deal With the Saboteurs, then Ghabar's Diagnosis: Critical and Testing the Prototype. At Eco-Dome Farfield, complete Tashar's All Clear! and Success!, returning to Ghabar. If the final quest is absent, finish the Violet Tower / Botanica Keystone chain in steps 5-6.",
    "For Securing the Celestial Ridge, take Marid's A Not-So-Modest Proposal at the Protectorate Watch Post. Retrieve the surveying equipment from the cave, meet Tyri and the Shrouded Figure on the ridge, and finish Getting Down to Business / A Promising Start / Troublesome Distractions. Use Tyri's horn and defeat Veraku for Securing the Celestial Ridge. If Netherwing reputation makes Veraku friendly, the quest's combat can require setting that faction At War.",
    "For Nexus-King Salhadaar, follow Commander Ameer's Ethereum investigations, relay/essence collection, sabotage and Delivering the Message escort. Use the Ethereum Transponder around 56, 38 to summon the Image of Commander Ameer when needed; this temporary quest giver may have no obvious exclamation mark on the map. Activate Salhadaar's three power conduits before fighting and return for the final hand-in.",
    "For Destroying the All-Devouring, follow Professor Dabiri's Recipe for Destruction at the Protectorate Watch Post. Complete On Nethery Wings using the quest dragon/bombs, then join Captain Saeed. Follow the squad and speak to Saeed again at the staging point outside Manaforge Ultris to start Dimensius's encounter. Kill Dimensius and turn in; flying straight to the boss without the squad does not advance the event.",
    "Check all six chapters. If The Consortium remains incomplete, confirm ALL FOUR: Full Triangle, Success!, Securing the Celestial Ridge and Nexus-King Salhadaar. Finish Shattrath faction reports, Vargoth's tower hand-ins and temporary Image-of-Ameer quests before assuming the zone is out of quests.",
    "ONLY if you have already completed and turned in Dimensius the All-Devouring (10439), but its chapter still lacks credit: a July 2026 Retail commenter reports resolving that state by completing Lorewalking: The Protectorate (85027). Lorewalker Cho offers the ethereal story in Stormwind (64.2, 16.2), Orgrimmar (54.2, 56.6) or Dornogal (49.6, 31.6). This is a reported credit workaround, not a prerequisite for the ordinary Netherstorm route above.",
}, {
    pin(111,54.8,44.3,1,"Khadgar - City of Light and faction choice"), pin(109,32.5,64.5,2,"Area 52 - goblin and rocket chains"),
    pin(109,31.5,56.6,2,"Ruins of Enkaat - robot quest area"), pin(109,32,64,3,"Area 52 inn - Aldor / Scryer contacts"),
    pin(109,29,15,4,"Socrethar's Seat - use quest access item"), pin(109,57,86,5,"Kirin'Var Village / Violet Tower"),
    pin(109,71.7,55.1,6,"The Botanica - Commander Sarannis's Keystone"), pin(109,57,86,6,"Vargoth - return with Keystone"),
    pin(109,32.4,64.2,7,"Khayji - Consortium introduction"), pin(109,46.6,56.6,7,"Midrealm Post - Gahruj / Mehrdad"), pin(109,46.7,36.4,7,"Stormspire - Haramad / Ghabar"),
    pin(109,44.7,14.5,8,"Eco-Dome Farfield - Tashar / Success!"), pin(109,59,32,9,"Protectorate Watch Post - Marid"),
    pin(109,61,45.8,9,"Cave - surveying equipment"), pin(109,72.2,43.2,9,"Celestial Ridge - Tyri / Veraku"),
    pin(109,56,38,10,"Ethereum Transponder - Image of Ameer"), pin(109,53.6,42,10,"Nexus-King Salhadaar - three conduits"),
    pin(109,60,32,11,"Dabiri / Saeed - Dimensius chain"), pin(109,62,40,11,"Manaforge Ultris - follow Saeed's event"),
    pin(84,64.2,16.2,13,"Optional credit workaround: Lorewalker Cho - Alliance"),
    pin(85,54.2,56.6,13,"Optional credit workaround: Lorewalker Cho - Horde"),
    pin(2339,49.6,31.6,13,"Optional credit workaround: Lorewalker Cho - Dornogal"),
})

-- https://www.wowhead.com/achievement=1195#comments:id=2556356
-- https://www.wowhead.com/achievement=1195#comments:id=2556357 and ALL seven replies
-- https://www.wowhead.com/achievement=1195#comments:id=5773782 (Netherwing story, not Exalted)
-- https://www.wowhead.com/quest=10664/additional-materials
-- https://www.wowhead.com/quest=10666/the-lexicon-demonica
-- https://www.wowhead.com/quest=10649/the-book-of-fel-names
-- https://www.wowhead.com/quest=10705/seer-udalo
-- https://www.wowhead.com/quest=11041/a-job-unfinished
add(1195, "Shadow of the Betrayer", "Quests", {
    "Use Shadowmoon Valley in OUTLAND, not Draenor. Enable Trivial Quests and track your faction's eight chapters. Choose Aldor OR Scryers through Khadgar's City of Light chain in Shattrath if you have not already; the choice opens required Shadowmoon quests. Keep the provided disguises, spectacles, totems and quest weapons until their chains finish.",
    "For Wildhammer Stronghold (Alliance) or Shadowmoon Village (Horde), follow your base's Legion Hold investigation through its infernal-bombing tasks, then the Deathforge chain. Defeat Warbringer Razuun inside the Deathforge, continue Gaining Access with the weaponsmith's key and the Invasion Point: Cataclysm fel-reaver objective, then turn in News of Victory. Enter the Deathforge through its cave and interior gate rather than searching above its underground quest marker.",
    "For The First Death Knight, follow Zorus the Judicator (Alliance) or Chief Apothecary Hildagard (Horde) into the ghost investigation. Wear the supplied Spectrecles when looking for spectres. Continue Teron Gorefiend - Lore and Legend, collect the requested cloak, truncheon and armor in its three divination branches, then finish Teron Gorefiend, I am.... Removing the spectacles can hide the very enemies/items you need.",
    "For The Dark Conclave, finish your base's Sketh'lon Wreckage investigation and find Parshah, the Sketh'lon deserter on the central road. Follow his Asghar / Rod of Lianthe / feathers tasks through Imbuing the Headpiece and Thwart the Dark Conclave. Use the completed quest headpiece at the ritual site; ordinary kills around the wreckage are only the opening of the story.",
    "For The Cipher of Damnation, start Earthmender Torlok at the Altar of Damnation (42.2, 45). Complete the fire/earth, water and air spirit quests: plant the supplied totem near the enemies BEFORE killing them so it can capture their souls. Follow Oronok Torn-heart at his northern farm; use his whistle near living boars to dig up tubers, then finish A Lesson Learned and The Cipher of Damnation - Truth and History.",
    "Complete ALL THREE sons' branches. Grom'tor in Coilskar needs naga keys to open footlockers for his fragment. Ar'tor at Illidari Point needs the Demonic Crystal Prisons / Lohn'goron bow chain before his fragment. Borak near Eclipse Point sends you through Of Thistleheads and Eggs... to Tobias in Shattrath; return with the bloodthistle, lure the target, then finish Shadowmoon Shuffle, the Ruusk disguise conversation and Ruul the Darkener for the third fragment. Do not attack a target you are meant to speak to while disguised.",
    "Return all three fragments to Oronok, then bring the assembled Cipher to the Altar of Damnation. Speak to Oronok there to begin the event, remain for the dialogue and defeat Cyrukh when the fight becomes active. Finish the final hand-in; possessing the fragments without completing this event leaves the chapter unfinished.",
    "For Anti-Demon Weapons, kill Overseer Ripsaw near Legion Hold and loot the Illidari-Bane Shard to START its quest. Report to your faction base, finish Capture the Weapons, then visit David Wayne at Wayne's Refuge in TEROKKAR (77.6, 38.6). Bring him 1 Adamantite Frame, 4 Heavy Knothide Leather and 1 Demon Warding Totem; Fantei in Shattrath's Lower City sells the totem.",
    "Accept Wayne's dungeon material quests BEFORE entering. In The Mechanar, take the right hallway and look by the wall near Mechano-Lord Capacitus for the lootable Overcharged Manacell boxes; the item is not a final-boss drop. In Shadow Labyrinth, loot Grandmaster Vorpil for The Lexicon Demonica. Turn BOTH quests in to unlock the next pair: Hydromancer Thespia in Steamvault supplies Underworld Loam, and Warbringer O'mrogg in Shattered Halls supplies Tear of the Earthmother. Return both to Wayne.",
    "Finish The Bane of the Illidari, then Quenching the Blade. Take the supplied blade to the Scalding Pools high on the Hand of Gul'dan and use it in the lava; stay for the resulting defense/event. Return the quenched blade to David Wayne. Merely clearing the four dungeons does not finish Anti-Demon Weapons without these final steps.",
    "For Borrowed Power, take Karabor Training Grounds from your chosen faction's Shadowmoon camp: Altar of Sha'tar for Aldor, Sanctum of the Stars for Scryers. Finish A Necessary Distraction and follow Altruis to Nagrand (27.3, 43). Complete Against the Legion (Netherstorm), Against the Illidari (Shadowmoon) and Against All Odds (Zangarmarsh) using their quest items and marked targets.",
    "Return to Altruis, listen to Illidan's Pupil and accept The Book of Fel Names. Enter Shadow Labyrinth and loot BLACKHEART THE INCITER for the book, then return to Altruis. This is a different boss/item from Wayne's Lexicon, which comes from VORPIL. Finish the report to your Aldor/Scryer camp and Varedis Must Be Stopped at Black Temple's training grounds.",
    "For Akama's Promise, follow Tablets of Baa'ri -> Oronu the Elder -> The Ashtongue Corruptors, including all four corruptors, then The Warden's Cage. Enter through the FLOOR GRATE at 57.4, 49.7. Finish Sanoru's Proof of Allegiance against Zandras, return, swim down the passage and take the right-hand route to Akama's chamber.",
    "Akama sends you to Seer Udalo in The Arcatraz: find Udalo's BODY inside, before the final boss area, and accept A Mysterious Portent. Return to Akama, complete the Atamal Terrace Soulstealer/Shadowlord Deathwail event for the Heart of Fury, return to Akama and take Akama's Promise to A'dal in Shattrath. The zone chapter does not require the later Black Temple raid attunement chain.",
    "For Netherwing Ledge, start Mordenai's Kindness in Netherwing Fields, follow the flying Neltharaku's crystals/drake-rescue quests and free Karynaku from Zuluhed at Dragonmaw Fortress. Complete Ally of the Netherwing, Blood Oath of the Netherwing and In Service of the Illidari into the disguised base camp. On the island's eastern side, kill Arvoar the Rapacious around 74.6, 86.7 and loot the Partially Digested Hand. Start A Job Unfinished..., kill its 10 Overmine Flayers and Barash the Den Mother, then return to Mor'ghor. This chapter needs that story, not Netherwing Exalted, daily repetition or an egg grind.",
    "Check the eight chapter criteria and complete outstanding final reports. Normal difficulty is sufficient for these original dungeon quests; old Heroic keys and raid attunements are unnecessary. If combining trips, have BOTH Shadow Labyrinth item quests active so Blackheart's book and Vorpil's Lexicon can be collected in the same run.",
}, {
    pin(111,54.8,44.3,1,"Khadgar - choose Aldor or Scryers"), pin(104,36,58,2,"Wildhammer Stronghold - Alliance base chains"),
    pin(104,29.5,29.5,2,"Shadowmoon Village - Horde base chains"), pin(104,22.5,39.9,2,"Legion Hold - infernal bombing quest area"),
    pin(104,40.4,38,2,"Deathforge cave entrance"), pin(104,28,20,2,"Invasion Point: Cataclysm"),
    pin(104,35.5,40,4,"Central road - search for Parshah"), pin(104,42.2,45,5,"Torlok - Altar of Damnation"),
    pin(104,53.9,23.5,5,"Oronok's Farm - Cipher introduction"), pin(104,44.6,23.6,6,"Grom'tor - Coilskar branch"),
    pin(104,29.6,50.4,6,"Ar'tor - Illidari Point branch"), pin(104,47.6,57.2,6,"Borak - Eclipse Point branch"),
    pin(111,64.2,69.6,6,"Tobias - Borak's Shattrath bloodthistle step"), pin(104,46.5,71.9,6,"Grand Commander Ruusk - disguised conversation"),
    pin(104,42.2,45,7,"Altar of Damnation - Oronok / Cyrukh event"), pin(104,23,36,8,"Overseer Ripsaw - shard drop patrol area"),
    pin(108,77.6,38.6,8,"David Wayne - cross-zone weapon quest giver"), pin(111,64.6,70.6,8,"Fantei - Demon Warding Totem"),
    pin(109,70.61,69.75,9,"The Mechanar - Overcharged Manacell"), pin(108,39.63,73.55,9,"Shadow Labyrinth - Vorpil's Lexicon"),
    pin(102,50.3,40.8,9,"Coilfang Reservoir - swim down central pipe"), pin(102,50.4,33.3,9,"Steamvault - Thespia's Underworld Loam"),
    pin(100,47.7,51.9,9,"Shattered Halls - O'mrogg's Tear"), pin(104,43.2,45.4,10,"Scalding Pools - quench Wayne's blade"),
    pin(108,77.6,38.6,10,"David Wayne - final weapon report"), pin(104,62.5,28.5,11,"Altar of Sha'tar - Aldor story start"),
    pin(104,56.3,59.6,11,"Sanctum of the Stars - Scryer story start"), pin(107,27.3,43,11,"Altruis - three demon quests"),
    pin(109,40,19,11,"Forge Base: Gehenna - blood / Avatar of Sathal"), pin(102,15,41,11,"Portal Clearing - use the quest spear for Xeleth"),
    pin(104,28.2,49.8,11,"Illidari Point - Lothros"),
    pin(108,39.63,73.55,12,"Shadow Labyrinth - Blackheart's Book of Fel Names"), pin(107,27.3,43,12,"Altruis - return with Book of Fel Names"),
    pin(104,70,50,12,"Black Temple exterior - Varedis training grounds"), pin(104,57.4,49.7,13,"Warden's Cage - FLOOR GRATE entrance"),
    pin(109,74.4,57.7,14,"The Arcatraz - Seer Udalo's body"), pin(104,71.2,35.4,14,"Atamal Terrace - Heart of Fury event"),
    pin(104,57.4,49.7,14,"Return through grate to Akama"), pin(111,54,44.8,14,"A'dal - Akama's Promise FINAL report"),
    pin(104,60,59,15,"Mordenai - Netherwing introductory chain"), pin(104,61.8,60,15,"Neltharaku - HIGH airborne patrol"),
    pin(104,69.8,61.5,15,"Karynaku / Zuluhed - free the dragon"), pin(104,66.2,85.6,15,"Mor'ghor - disguised camp and final hand-in"),
    pin(104,74.6,86.7,15,"Arvoar - Partially Digested Hand quest item"),
})

-- https://www.wowhead.com/achievement=1262#comments
add(1262, "Loremaster of Outland", "Quests", {
    "Enable Trivial Quests and track the SEVEN zone achievements. Modern Loremaster uses named story chapters, not the original fixed quest counts. Use one character's quest log to follow each chain coherently; faction variants use different hubs and final reports.",
    "Complete To Hellfire and Back: Honor Hold / Temple of Telhamat for Alliance, or Thrallmar / Spinebreaker / Falcon Watch for Horde. Both need the Razelcraz mine AND crashed-zeppelin goblin stories, plus Cenarion Post.",
    "Complete Mysteries of the Marsh in Zangarmarsh: faction towns, Cenarion Refuge's drain/Sporelok stories, Watcher Leesa'oh and Sporeggar. Finish the cross-zone report to Hellfire and any remaining escort rather than stopping at a reputation rank.",
    "Complete Terror of Terokkar: your stronghold, the Warden/Firewing investigation, Refugee Caravan, Skettis Offensive and Sha'tari Base Camp. The map and the child achievement's guide include the Shattrath reports and Haylen's easy-to-miss final chain.",
    "Complete Nagrand Slam in OUTLAND. Finish the Mastery hunts, Ring of Blood, Throne of the Elements, Consortium, Murkblood, Lantresor and town WANTED quests plus Altruis. Alliance also rescues Corki; Horde completes Birth of a Warchief, including its Auchenai Crypts quest.",
    "Complete On the Blade's Edge using your faction's four chapters. Finish Evergrove's Wyrmcult and Death's Door stories too. The old Ogri'la/Apexis-relic requirement is removed; do not grind its reputation for Loremaster.",
    "Complete Into the Nether in Netherstorm. Choose Aldor or Scryers in Shattrath for Socrethar, finish Vargoth's Botanica Keystone quest, and finish all FOUR Consortium endpoints. The child guide explains the temporary Image of Ameer and Saeed's Dimensius event.",
    "Complete Shadow of the Betrayer in OUTLAND Shadowmoon. Keep the quest items and follow the cross-zone routes to David Wayne and Altruis. Original Mechanar, Botanica, Arcatraz, Shadow Labyrinth, Steamvault, Shattered Halls and Auchenai Crypts can be needed across the different zone chains; accept the relevant quests before running them. Netherwing Exalted and old raid attunements are unnecessary.",
    "Open each incomplete child achievement and use its detailed numbered route to resolve the missing chapter. Finish outstanding reports before abandoning a chain. Ghostlands and Bloodmyst have separate quest achievements and are not additional requirements of this seven-zone meta.",
}, {
    pin(100,56.6,66.7,2,"Hellfire - Honor Hold (Alliance)"), pin(100,55,36,2,"Hellfire - Thrallmar (Horde)"),
    pin(102,78.4,62,3,"Zangarmarsh - Cenarion Refuge"), pin(108,44,26,4,"Terokkar - Cenarion Thicket investigation"),
    pin(107,71.5,40.7,5,"Nagrand - Nesingwary Safari"), pin(105,61.5,39.3,6,"Blade's Edge - Evergrove"),
    pin(109,32.5,64.5,7,"Netherstorm - Area 52"), pin(111,54.8,44.3,7,"Shattrath - Aldor/Scryer choice"),
    pin(104,42.2,45,8,"Shadowmoon - Altar of Damnation"), pin(108,77.6,38.6,8,"Terokkar - David Wayne"), pin(107,27.3,43,8,"Nagrand - Altruis"),
})

-- https://www.wowhead.com/achievement=4908#comments:id=2134058 and ALL six replies
-- https://www.wowhead.com/achievement=4908#comments:id=3198271
-- https://www.wowhead.com/quest=9174/vanquishing-aquantion
-- https://www.wowhead.com/quest=9167/the-traitors-destruction
add(4908, "Ghostlands Quests", "Quests", {
    "Use a HORDE character and the original Burning Crusade Ghostlands. In Retail's updated Quel'Thalas, speak to Zidormi at the northern Eastern Plaguelands border (53.8, 8.6) to choose the earlier timeline, then cross into the old Eversong/Ghostlands maps. The modern Midnight zone and its quests do not replace these original story chapters. Enable Trivial Quests.",
    "For Citizens of Tranquillien, start the northern road introductions Suncrown Village / Tomber's Supplies and report to Tranquillien (45.5, 30.6). Work through its residents' food, disease, patrol and mine chains, following reports to Ranger Station, Windrunner Village and the sanctums. Finish the local follow-ups instead of using the old advice to reach a numeric quest total.",
    "For Farstrider Enclave, complete the Farstriders' troll investigations and Zeb'Nowa objectives, including the catacomb work where offered. ALSO visit Geranis Whitemorn on the island north of the Enclave (72.2, 19). His lake chain is required even though he belongs to Tranquillien rather than the Farstriders.",
    "Finish Geranis's medallion collection and accept Vanquishing Aquantion. Swim to the lake floor near 71.4, 15.2, use the supplied Bundle of Medallions at the Altar of Tidal Mastery, kill the summoned Aquantion and return to Geranis. Merely killing other lake elementals does not finish the Enclave chapter.",
    "For Dar'Khan Drathir, turn in The Sanctum of the Sun (9151); replies identify this breadcrumb as a required link into the final chain. Continue the investigation through The Traitor's Shadow, Dar'Khan's Journal / Report to Magister Kaendris and The Twin Ziggurats. At Deatholme, also finish the lieutenant and captive objectives offered by the sanctum's other quest givers, returning for the final reports.",
    "Accept The Traitor's Destruction from Magister Kaendris at the Sanctum of the Sun. Enter Deatholme, go down inside Dar'Khan's building, kill Dar'Khan Drathir and LOOT his head. Return the head to Kaendris. Check all three chapters; the later Hero of the Sin'dorei / Friend of the Sin'dorei celebration is not a substitute for a missing Geranis or local Tranquillien chain.",
}, {
    pin(23,53.8,8.6,1,"Zidormi - original Quel'Thalas timeline"), pin(95,45.5,30.6,2,"Tranquillien - resident quest chains","Ghostlands (Burning Crusade)"),
    pin(95,72.5,32.5,3,"Farstrider Enclave - troll investigations","Ghostlands (Burning Crusade)"),
    pin(95,72.2,19,3,"Geranis Whitemorn - island quest giver","Ghostlands (Burning Crusade)"), pin(95,71.4,15.2,4,"Lake floor - Altar of Tidal Mastery / Aquantion","Ghostlands (Burning Crusade)"),
    pin(95,72.2,19,4,"Geranis - report after Aquantion","Ghostlands (Burning Crusade)"),
    pin(95,55,48.5,5,"Sanctum of the Sun - Dar'Khan investigation","Ghostlands (Burning Crusade)"), pin(95,32.8,34.8,5,"Sanctum of the Moon - ziggurat chain reports","Ghostlands (Burning Crusade)"),
    pin(95,33,82,6,"Deatholme - Dar'Khan's building","Ghostlands (Burning Crusade)"), pin(95,55,48.5,6,"Kaendris - turn in Dar'Khan's head","Ghostlands (Burning Crusade)"),
})

-- https://www.wowhead.com/achievement=4926#comments:id=2580290 and both corrections
-- https://www.wowhead.com/achievement=4926#comments:id=5391133 (other Alliance races eligible)
-- https://www.wowhead.com/quest=9759/ending-their-world
-- https://www.wowhead.com/quest=9683/ending-the-bloodcurse
add(4926, "Bloodmyst Isle Quests", "Quests", {
    "Use an ALLIANCE character and enable Trivial Quests. Other Alliance races can complete the achievement; a Draenei additionally has a tabard follow-up. Enter Bloodmyst from Azuremyst through Kessel's Crossing and follow the introductions toward Blood Watch (54.5, 55). Track the eight named chapters instead of an old fixed quest total.",
    "For The Triumvirate's First, Boros, follow What Argus Means to Me -> Blood Watch -> Intercepting the Message -> Translations... -> Audience with the Prophet -> Truth or Fiction -> I Shoot Magic Into the Darkness. CLICK BOROS even if he only shows a blue repeatable-question mark: his crystal turn-in can hide the main quest's marker. Audience with the Prophet takes you to Velen in the Exodar (32.5, 54.5 on the CITY map); finish his report and return to Blood Watch for the follow-ups.",
    "For The Triumvirate's Second, Kuros, complete The Cryo-Core and loot Galaen's Journal to begin The Fate of Vindicator Saruan. Follow its report to Matis the Cruel; use the supplied signal/flare as directed to capture Matis rather than killing a patrol before the quest is active. The Cryo-Core belongs to KUROS, not Aesom, as corrected in the guide's replies.",
    "For The Triumvirate's Third, Aesom, complete Don't Drink the Water -> Limits of Physical Exhaustion -> The Sun Gate. Finish the Sun Gate's crystal/portal objectives and return for the hand-in; unrelated water kills cannot replace the portal objective.",
    "For Galaen's Fate, take Searching for Galaen from Morae at Blood Watch, find Galaen's body in the Cryo-Core and accept Galaen's Fate there. Loot the requested amulet and return to Morae. His dropped JOURNAL in step 3 and his BODY'S quest here are separate chains.",
    "For Defending Vindicator's Rest, finish Critters of the Void -> What We Know... -> What We Don't Know..., then report through Vindicator's Rest to the western camp (30, 46). Complete Cutting a Path, Fouled Water Spirits and Oh, the Tangled Webs They Weave. Clearing the Way is an optional nearby quest, not a hidden requirement of this chapter.",
    "For Ending the Bloodcurse, first complete A Small Start for Admiral Odesyus at Odesyus' Landing in AZUREMYST (47.0, 70.2) if you have not done it. Return to Blood Watch, speak to the roaming Messenger Hermesius for Urgent Delivery, then CHECK YOUR MAILBOX for A Letter from the Admiral. Its The Bloodcurse Legacy quest leads to Captain Edward Hanes, the ghost on Wyrmscar Island's northern shore (79, 22.6). Complete The Bloodcursed Naga -> The Hopeless Ones... -> Ending the Bloodcurse. Destroy the Statue of Queen Azshara to summon Atoph, defeat him and return to Hanes. Eligible non-Draenei Alliance characters can complete this chain too.",
    "For Loreth'Aran, speak to Prince Toreth on Wyrmscar Island (74, 34.5). Complete Restoring Sanctity -> Into the Dream -> Razormaw. Use the quest's summoning location to call Razormaw, kill him and return to Toreth; a normal nearby dragon kill is not sufficient.",
    "For The Unwritten Prophecy chapter, finish Blood Watch's Vector Coil investigation and take Ending Their World. Meet Demolitionist Legoso at Vindicator's Rest and FOLLOW/PROTECT him as he plants explosives, destroys the Vector Coil and engages Sironas. Stay with the escort's pauses and dialogue; flying ahead and killing Sironas out of sequence does not replace the event. Report to Exarch Admetius at Blood Watch.",
    "Check all eight story criteria. Ending Their World supplies the final chapter's achievement credit. A Draenei can then accept Velen's separate The Unwritten Prophecy for Tabard of the Hand; that race-specific reward quest is not a reason for other Alliance races to abandon the zone achievement.",
}, {
    pin(106,63,87,1,"Kessel's Crossing - Bloodmyst introduction"), pin(106,54.5,55,1,"Blood Watch - main quest hub"),
    pin(106,55.5,55,2,"Boros - check behind the blue repeatable marker"), pin(103,32.5,54.5,2,"Velen - Audience with the Prophet / Truth or Fiction","The Exodar"),
    pin(106,37,61,3,"The Cryo-Core - Kuros objectives / Galaen's Journal"),
    pin(106,55.5,55,4,"Aesom / Blood Watch - water and Sun Gate chain"), pin(106,19,63,4,"Sun Gate - portal quest area"),
    pin(106,53.2,57.8,5,"Morae - Searching for Galaen / final report"), pin(106,37.5,61.3,5,"Galaen's body - separate quest from journal"),
    pin(106,30,46,6,"Vindicator's Rest - western defense chains"),
    pin(97,47,70.2,7,"Admiral Odesyus - A Small Start prerequisite"), pin(106,54.5,55,7,"Blood Watch - Messenger Hermesius; then check mail"),
    pin(106,79,22.6,7,"Captain Edward Hanes - Bloodcurse chain"),
    pin(106,74,34.5,8,"Prince Toreth - Loreth'Aran chain"), pin(106,30,46,9,"Legoso - start and follow demolition escort"),
    pin(106,18,51,9,"Vector Coil - escort's destination"), pin(106,52.7,53.2,9,"Admetius - Ending Their World final hand-in"),
})

-- Retail availability reviewed 2026-11-04. The 151 currently registered IDs
-- retain acquisition routes. The catalogue already excludes retired Arena
-- seasons, original Zul'Aman and removed attunement feats. Do not treat a
-- Feat of Strength label, a legacy-content level or a fixed bug as retirement.
-- https://www.wowhead.com/achievement=11707/no-mercy#comments
-- https://www.wowhead.com/achievement=62460/family-battler-of-outland#comments
-- https://www.wowhead.com/achievement=214/flurry#comments
-- https://www.wowhead.com/achievement=1800/the-outland-gourmet#comments
-- https://www.wowhead.com/achievement=18721/outland-master-of-all
-- https://www.wowhead.com/guide/the-ultimate-reputation-guide-10726
-- https://us.forums.blizzard.com/en/wow/t/explore-eversong-woods-burning-crusade/2290240
-- Overall effort includes prerequisites, repetition, randomness and resets.
-- Mount-ownership achievements inherit the matching mount's existing rating.
local function rate(level, reason, achievementIDs)
    for _, id in ipairs(achievementIDs) do
        local guide = guides[id]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end
rate("easy", "Clear the named legacy dungeon or raid and finish its scripted encounters; combat is straightforward at current max level.", {
    647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,666,
    667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,
    690,692,693,694,695,696,697,698,
})
rate("easy", "Visit the required discovery points; use the original timeline for the old Quel'Thalas zones.", {
    44,843,858,859,860,861,862,863,864,865,866,867,868,
})
rate("easy", "Learn Fishing and fish from the Strange Pool in the legacy raid to summon the boss; no random rare drop is needed.", {144})
rate("easy", "Buy and equip the Gigantique bag from Haris Pilton for its ordinary vendor price.", {1165})
rate("medium", "Play the battleground objectives or complete a personal capture or buffed kill; a few matches may be needed.", {208,212,233,587,1258})
rate("hard", "The objective needs tight timing, unusual match conditions, coordinated tower control or many victories.", {
    209,211,213,214,216,783,784,1171,
})
rate("hard", "Defeat an enemy-capital leader, handling guards, defending players and any needed group coordination.", {613,618})
rate("hard", "Obtain both rare legendary swords on the same eligible character across weekly raid loot opportunities.", {426})
rate("hard", "Obtain the rare legendary bow from Kil'jaeden; weekly loot opportunities make the wait unpredictable.", {725})
rate("hard", "Fish up rare Mr. Pinchy and use his limited wishes until the Magical Crawdad Box reward appears.", {726})
rate("medium", "Acquire and learn the mount through its reputation route and gold purchase.", {893})
rate("hard", "Obtain and learn a rare boss-drop mount, subject to daily or weekly loot lockouts.", {882,883,884,885})
rate("medium", "Repeat quests, dungeon clears or item turn-ins until the required faction reaches Exalted.", {
    894,897,898,899,900,901,902,903,
})
rate("medium", "Raise the raid faction to Exalted through repeat clears, respecting weekly boss lockouts.", {958,959,960})
rate("hard", "Complete five separate Exalted dungeon-reputation grinds on one character.", {763,764})
rate("hard", "Unlock both Ogri'la daily hubs and repeat their limited quests across many daily resets.", {896})
rate("hard", "Reach Exalted with both opposing Shattrath factions on one character, including the long allegiance conversion.", {1205})
rate("medium", "Raise the required Outland profession skill bars with expansion-specific training, materials or gathering.", {124,129,733,18729})
rate("hard", "Max all eleven primary Outland professions across profession characters, requiring substantial materials and preparation.", {18721})
rate("hard", "Collect four profession-gated dungeon patterns and personally craft every required hat.", {18894})
rate("hard", "Obtain the random cooking recipe from reward bags, then gather its ingredients and cook the cake.", {877})
rate("hard", "Collect the full recipe list, including random daily-reward recipes, and personally cook all required dishes.", {1800})
rate("medium", "Obtain the fishing-reward recipe and brew the drink; buying a Timewalking reward bag can provide extra chances.", {1801})
rate("medium", "Complete each required daily quest when it is offered; the rotation prevents finishing all objectives on demand.", {905,906})
rate("medium", "Fish from each named Outland school; travel between zones and pool availability add to the effort.", {1225})
rate("medium", "Complete all three Nagrand hunting chains and their named-target finale.", {939})
rate("medium", "Unlock the bombing quest or Netherwing races and complete the route with the required mechanics.", {1275,1638})
rate("hard", "Finish the full bombing objective within its short timer while avoiding anti-air attacks.", {1276})
rate("medium", "Finish the named zone's story chapters and their quest prerequisites; legacy combat alone does not complete them.", {
    1189,1190,1191,1192,1193,1194,1271,1272,1273,4908,4926,
})
rate("hard", "Complete Shadowmoon's long branching story, dungeon errands and scripted quest chains.", {1195})
rate("hard", "Finish every required Outland zone-story achievement, including the longer branching chains.", {1262})
rate("medium", "Complete all component legacy dungeon or raid achievements, requiring several full instance routes.", {1284,1286,1287})
rate("medium", "Find and defeat one Outland rare; spawn availability and patrol routes can require searching.", {1311})
rate("hard", "Find every named Outland rare across multiple zones despite variable respawns and competition.", {1312})
rate("medium", "Capture the required wild pets across Outland or build a leveled team and finish the tamer progression.", {6587,6604,6614})
rate("medium", "Prepare three level-25 pets of the required family and defeat all five tamers with eligible teams.", {
    62466,62467,62468,62469,62470,62471,62472,62473,62474,62475,
})
rate("hard", "Prepare teams for all ten pet families and complete every family restriction against all five tamers.", {62460})
rate("hard", "Collect the full set of raid pets through random weekly drops or buy the missing tradable pets.", {8293,9824})
rate("medium", "Earn 12 Marks of Honor and learn an ordinary legacy armor ensemble; no historical Arena rating is required.", {11706,11707,11708,11709})
rate("hard", "Collect a complete class appearance set through random weekly raid drops and the relevant token exchanges.", {11746,11747,11748,11749})
