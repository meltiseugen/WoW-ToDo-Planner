-- Hand-reviewed Classic-tab toy guides, Retail only; reviewed 2026-11-01.
-- Availability and acquisition difficulty reviewed 2026-11-04; all five remain obtainable.
-- All five item comment lists were read (510 parents, 409 reported replies).
-- No numbered acquisition guide ending in profit was found. The two Orb matches
-- concern resale. These original walkthroughs combine acquisition comments,
-- relevant replies and Retail recipe records; source links accompany each entry.
-- Dungeon coordinates use Retail UiMap/UiMapGroupMember floor IDs, not zone IDs.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.toys = {
    [1973] = {
        difficulty = "hard",
        difficultyReason = "Farm a rare world drop or pay its variable Auction House price; there is no guaranteed farming completion time.",
        name = "Orb of Deception",
        acquisition = table.concat({
            "1. Choose a purchase or farming route. For a guaranteed acquisition, search the Auction House for Orb of Deception (1973), buy an unused one and continue at step 7. Player prices vary; the rare-drop route below has no guaranteed number of runs.",
            "2. For the Molten Core route, enter Blackrock Mountain from Burning Steppes near 21.0, 38.0. Inside, follow the chains down around the central rock toward the lower passage to Blackrock Depths.",
            "3. Find Lothos Riftwaker at 54.4, 83.6 on the Blackrock Mountain: Blackrock Depths approach map. Speak to him to enter the original Molten Core raid. This is the old raid inside the mountain, not a Timewalking or anniversary queue.",
            "4. Clear and loot the raid, including its trash. Defeat the first eight bosses so Majordomo Executus appears, defeat his encounter, then speak to him in Ragnaros's chamber to summon Ragnaros. Kill and loot Ragnaros at 56.2, 53.3 on the Molten Core map for another chance at the orb.",
            "5. Molten Core bosses have a weekly lockout. Reset All Instances will not restore their loot. Check Raid Info before returning; use another eligible character for additional weekly chances.",
            "6. For a repeatable dungeon alternative, enter Normal Stratholme through the Main Gate in Eastern Plaguelands (27.1, 12.6), clear and loot its enemies, walk outside and reset. You can farm Hearthsinger's Piccolo there at the same time. The orb is a rare world drop, so these enemies do not guarantee it; pause if you reach the hourly instance limit.",
            "7. Use the unused Orb of Deception from your bags to add it to the account-wide Toy Box. Keep the first one you need before selling any duplicates.",
        }, "\n\n"),
        stepCount = 7,
        source = "Rare world drop; Molten Core and Normal Stratholme farming routes, or the Auction House",
        sourceType = "Rare Drops",
        category = "Rare Drops",
        tips = "Old Dire Maul arena camping instructions predate the relocated rares and changed loot tables. Colossus of Zora is not a dependable current farming target. The disguise changes appearance, not faction: opposing guards can still attack you. The effect keeps your equipped appearance in Retail.",
        effect = "Changes your appearance to an opposing-faction race for 5 minutes; 30-minute cooldown. It does not grant faction access or change your actual allegiance.",
        requirements = "No profession required. Use a character capable of soloing the chosen legacy instance when farming.",
        cost = "No purchase cost when farming; Auction House price varies.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=1973",
        -- Acquisition/drop reports and corrections, including replies to 1388833:
        -- https://www.wowhead.com/item=1973#comments:id=1388833
        -- https://www.wowhead.com/item=1973#comments:id=3207625
        -- https://www.wowhead.com/item=1973#comments:id=6000304
        -- https://www.wowhead.com/npc=14387/lothos-riftwaker
        -- https://www.wowhead.com/npc=11502/ragnaros
        waypoints = {
            { mapID = 36, x = 0.210, y = 0.380, step = 2, label = "Blackrock Mountain - surface approach" },
            { mapID = 35, mapName = "Blackrock Mountain: Blackrock Depths approach", x = 0.544, y = 0.836, step = 3, label = "Lothos Riftwaker - enter original Molten Core", npcID = 14387, locationType = "NPC" },
            { mapID = 232, x = 0.562, y = 0.533, step = 4, label = "Ragnaros - clear the raid and summon him first", npcID = 11502, locationType = "NPC" },
            { mapID = 23, x = 0.271, y = 0.126, step = 6, label = "Stratholme Main Gate - optional repeatable world-drop route" },
        },
    },
    [13379] = {
        difficulty = "medium",
        difficultyReason = "Find Hearthsinger Forresten in Normal Stratholme and repeat the run until his toy drops.",
        name = "Piccolo of the Flaming Fire",
        acquisition = table.concat({
            "1. Set dungeon difficulty to Normal and enter Stratholme through the MAIN GATE in Eastern Plaguelands at 27.1, 12.6. The dungeon floor must be Crusader's Square. The Service Entrance leads to the separate Gauntlet section; hearing or targeting Hearthsinger from there does not mean you can reach him.",
            "2. Clear the first packs and search the streets around Market Row and Festival Lane. Use /targetexact Hearthsinger Forresten, then put a raid marker on your target. He is a translucent ghost with a yellow, neutral nameplate; enable neutral NPC names as well as enemy names.",
            "3. Check the Market Row search point near 60.5, 32.7 on the Crusader's Square map. If he is absent, continue around the streets rather than trusting the single boss icon or immediately resetting.",
            "4. Check beneath the overhang outside Angelista's Boutique near 84.2, 27.5 in Festival Lane. Look into the shadows beside the wall; several replies describe walking past him without seeing his neutral nameplate.",
            "5. If necessary, check the other reported Festival Lane position near 85.2, 47.1 and search the adjoining streets with the targeting command. These pins are alternative search points, not three simultaneous spawns. Kill Hearthsinger and loot him for a chance at the Piccolo.",
            "6. If the toy does not drop, walk back out through the Main Gate, choose Reset All Instances on your portrait and repeat. Search the alternative positions on each run; killing the rest of the dungeon or dancing with him does not guarantee the toy. Wait if you hit the hourly instance limit.",
            "7. Use Piccolo of the Flaming Fire from your bags to add it to the account-wide Toy Box. For the intended group effect, try it beside party or raid members; the old comments about making everyone in an Auction House dance describe an earlier version.",
        }, "\n\n"),
        stepCount = 7,
        npcId = 10558,
        source = "Hearthsinger Forresten - Normal Stratholme, Main Gate / Crusader's Square",
        sourceType = "Dungeon and Raids",
        category = "Dungeon and Raids",
        tips = "Hearthsinger changes position between runs. Check Market Row and Festival Lane before giving up. The drop is random; comments reporting a handful of runs are not a promise. A recent comment reports problems affecting other players, so an unsuccessful dance effect is not evidence that the acquisition failed.",
        effect = "Channels a dance effect for up to 30 seconds with a 5-minute cooldown. Retail restricts the player effect to party or raid members; recent comments also report inconsistent behavior.",
        requirements = "Either faction; a character capable of clearing the relevant part of Normal Stratholme.",
        cost = "No purchase cost; bind-on-pickup dungeon drop.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=13379",
        -- Main Gate correction, alternative positions and complete relevant replies:
        -- https://www.wowhead.com/item=13379#comments:id=1798214
        -- https://www.wowhead.com/item=13379#comments:id=2270470
        -- https://www.wowhead.com/npc=10558#comments:id=2190763
        -- https://www.wowhead.com/npc=10558#comments:id=2567630
        -- https://www.wowhead.com/npc=10558#comments:id=2869091
        -- https://www.wowhead.com/npc=10558#comments:id=5811724
        waypoints = {
            { mapID = 23, x = 0.271, y = 0.126, step = 1, label = "Stratholme Main Gate - enter Crusader's Square" },
            { mapID = 317, mapName = "Stratholme: Crusader's Square", x = 0.605, y = 0.327, step = 3, label = "Market Row - Hearthsinger search point", npcID = 10558, locationType = "NPC" },
            { mapID = 317, mapName = "Stratholme: Crusader's Square", x = 0.842, y = 0.275, step = 4, label = "Angelista's Boutique - check beneath the overhang", npcID = 10558, locationType = "NPC" },
            { mapID = 317, mapName = "Stratholme: Crusader's Square", x = 0.852, y = 0.471, step = 5, label = "Festival Lane - alternative reported position", npcID = 10558, locationType = "NPC" },
        },
    },
    [18660] = {
        difficulty = "medium",
        difficultyReason = "Buy a finished toy, or obtain the rare BRD schematic, raise Gnomish Engineering and craft it; use has separate profession restrictions.",
        name = "World Enlarger",
        acquisition = table.concat({
            "1. To collect without crafting, buy the finished World Enlarger (18660) from another player or the Auction House and continue at step 10. You can add it to the Toy Box without Engineering; activating it afterwards requires Gnomish Engineering.",
            "2. To craft it yourself, train Classic Engineering and raise it to 200 on a level 20 or higher character. If you are not already a Gnomish Engineer, take Gnomish Engineering (29477) from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Hand that trainer 6 Mithril Tubes, 2 Advanced Target Dummies and 1 Accurate Scope. You can buy these finished quest items. Raise Classic Engineering to 260 before learning the toy's recipe.",
            "3. Obtain Schematic: World Enlarger (18661). You can buy the schematic instead of farming it; a recipe is not the finished toy. For the drop route, use Normal Blackrock Depths and the route in steps 4-8. Any character can loot the tradable schematic, even without Engineering.",
            "4. Enter Blackrock Mountain from Burning Steppes near 21.0, 38.0. Follow the chains and central tomb down to the lower passage near Lothos Riftwaker. Turn into the Grinding Quarry before his room and follow it to the Blackrock Depths portal at 38.9, 18.1 on the Blackrock Mountain: Blackrock Depths approach map. Enter the original dungeon, rather than a queued raid version.",
            "5. Inside the Detention Block, take the gate on the left, then the gate on the right. Go through the left-hand door beside the friendly NPC. Click the lever at the large hanging wheel, the Shadowforge Lock (41.3, 88.1 on the Detention Block floor). Return up the ramp and take the left corridor toward the West Garrison. Retail no longer requires the old Shadowforge Key.",
            "6. Follow the corridor left through the West Garrison. When the room opens up, take two right turns toward Golem Lord Argelmach. Kill and loot the Weapon Technicians down the ramps on both sides of the Manufactory near his room (36.4, 65.1 on the Shadowforge City floor). These technicians drop the schematic; you are not looking for a schematic vendor or farming Lower Blackrock Spire.",
            "7. For additional technicians, follow the bridge toward the Grim Guzzler and Plugger Spazzring (47.7, 65.7 on the Shadowforge City floor). Clear the bar's exit by defeating Plugger, Phalanx and the enemies that enter, then go through and down the ramp to check the next groups. The mole-machine shortcut to just past the bar is another option, but comments warn that those few groups can contain very few technicians.",
            "8. If the schematic has not dropped, use the mole machine to return to the entrance, leave and reset the dungeon. Repeat the technician route and pause at the hourly instance limit. Direbrew's Remote is optional; a reply warns that using it from outside may put you at the dungeon entrance instead of directly in the bar.",
            "9. On your Gnomish Engineer with Classic Engineering 260, learn Schematic: World Enlarger. Gather 1 Mithril Casing, 2 Thorium Widgets, 1 Gold Power Core, 1 Unstable Trigger and 1 Citrine, then craft World Enlarger. Buying the components avoids having to make their subcomponents yourself.",
            "10. Use the finished World Enlarger from your bags to collect it. To activate it from the Toy Box, use a Gnomish Engineer. The low Engineering requirement on the finished toy does not remove the specialization requirement.",
        }, "\n\n"),
        stepCount = 10,
        source = "Gnomish Engineering; schematic from Weapon Technicians in Normal Blackrock Depths",
        sourceType = "Professions",
        category = "Professions",
        tips = "Buying the finished toy is enough for collection credit. Buying only the schematic still requires a Gnomish Engineer to craft it. The schematic and the toy have different skill requirements. Do not change specialization merely to add a purchased toy to the collection.",
        effect = "Makes you very small for up to 5 minutes, ending when you attack; 15-minute cooldown. Requires Gnomish Engineering to activate.",
        requirements = "Collection: no profession. Crafting: Gnomish Engineer and Classic Engineering 260. Use: Gnomish Engineer; specialization unlock requires level 20 and Classic Engineering 200.",
        cost = "1 Mithril Casing, 2 Thorium Widgets, 1 Gold Power Core, 1 Unstable Trigger, 1 Citrine; schematic and optional specialization quest items are extra.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=18660",
        -- Acquisition comments, corrected key requirement and Remote/mole-machine replies:
        -- https://www.wowhead.com/item=18660#comments:id=2017091
        -- https://www.wowhead.com/item=18661#comments:id=2262100
        -- https://www.wowhead.com/npc=8920#comments:id=2016669
        -- https://www.wowhead.com/npc=8920#comments:id=1849042
        -- https://www.wowhead.com/npc=8920#comments:id=2017472
        -- https://www.wowhead.com/zone=1584#comments:id=1367013
        -- https://www.wowhead.com/npc=8983/golem-lord-argelmach
        -- https://www.wowhead.com/npc=9499/plugger-spazzring
        -- https://www.wowhead.com/quest=29477/gnomish-engineering
        -- https://www.wowhead.com/spell=23129/world-enlarger
        waypoints = {
            { mapID = 84, x = 0.628, y = 0.320, step = 2, label = "Lilliam Sparkspindle - Alliance Gnomish specialization quest", npcID = 5518, locationType = "NPC" },
            { mapID = 85, x = 0.568, y = 0.564, step = 2, label = "Roxxik - Horde Gnomish specialization quest", npcID = 11017, locationType = "NPC" },
            { mapID = 36, x = 0.210, y = 0.380, step = 4, label = "Blackrock Mountain - surface approach to the lower chains" },
            { mapID = 35, mapName = "Blackrock Mountain: Blackrock Depths approach", x = 0.389, y = 0.181, step = 4, label = "Original Blackrock Depths dungeon portal" },
            { mapID = 242, mapName = "Blackrock Depths: Detention Block", x = 0.413, y = 0.881, step = 5, label = "Shadowforge Lock - click the lever below the hanging wheel" },
            { mapID = 243, mapName = "Blackrock Depths: Shadowforge City", x = 0.364, y = 0.651, step = 6, label = "Manufactory - search the technician ramps near Argelmach", npcID = 8920, locationType = "NPC" },
            { mapID = 243, mapName = "Blackrock Depths: Shadowforge City", x = 0.477, y = 0.657, step = 7, label = "Grim Guzzler - Plugger and the route to additional technicians", npcID = 9499, locationType = "NPC" },
        },
    },
    [18984] = {
        difficulty = "medium",
        difficultyReason = "Buy the finished toy, or raise Classic Engineering, unlock the matching specialization and learn the recipe through NPC dialogue.",
        name = "Dimensional Ripper - Everlook",
        acquisition = table.concat({
            "1. For collection only, buy the finished Dimensional Ripper - Everlook (18984) or ask a Goblin Engineer to craft it, then continue at step 6. You do not need Engineering to add it to the Toy Box. Using the learned teleporter requires the Goblin specialization and Classic Engineering 260.",
            "2. For self-crafting, train Classic Engineering and reach 200 on a level 20 or higher character. If you lack Goblin Engineering, take Goblin Engineering (29475) from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Turn in 20 Big Iron Bombs, 20 Solid Dynamite and 5 Explosive Sheep to that trainer. These are finished-item counts, not the number of crafts.",
            "3. With the Goblin specialization and at least 260 Classic Engineering, go to Zap Farflinger beside the transporter in Everlook, Winterspring (59.6, 49.8). Use his dialogue to learn the recipe for free. It is not a schematic in a vendor inventory. You need non-hostile Everlook reputation to interact; a comment confirms Neutral is enough.",
            "4. Raise Classic Engineering to 285 to craft the recipe. The 260 threshold mentioned in the trainer comments and finished item's tooltip is not the recipe's crafting threshold. Search for Dimensional Ripper in Classic Engineering and clear the Have Materials filter if the recipe seems missing.",
            "5. Gather 10 Mithril Bars, 1 Truesilver Transformer, 4 Hearts of Fire, 2 Star Rubies and 1 The Big One. Buy the finished subcomponents or craft them, then craft the Dimensional Ripper. The Big One is a required bomb component, not an instruction to use a bomb at the transporter.",
            "6. Use the finished item in your bags to add it to the account-wide Toy Box. An eligible Goblin Engineer can then activate it to teleport to Everlook. Other characters retain collection credit even when the toy is unusable for them.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 14742,
        source = "Goblin Engineering; recipe taught through Zap Farflinger's dialogue in Everlook",
        sourceType = "Professions",
        category = "Professions",
        tips = "Collection and activation have separate requirements; buying the finished toy avoids changing specialization. Teleports can cause a burning or transformation malfunction. Bring a heal or healing item, and remember that hostile Everlook guards still attack after arrival. Old comments about equipping a trinket predate the Toy Box.",
        effect = "Teleports an eligible Goblin Engineer to Everlook in Winterspring; 4-hour cooldown, with possible malfunctions.",
        requirements = "Collection: no profession. Recipe dialogue: Goblin Engineer and Classic Engineering 260. Crafting: Classic Engineering 285. Use: Goblin Engineer and Classic Engineering 260.",
        cost = "10 Mithril Bars, 1 Truesilver Transformer, 4 Hearts of Fire, 2 Star Rubies, 1 The Big One; optional specialization quest items are extra.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=18984",
        -- Highly rated trainer information and collection clarification, including replies:
        -- https://www.wowhead.com/item=18984#comments:id=10568
        -- https://www.wowhead.com/item=18984#comments:id=1009592
        -- https://www.wowhead.com/item=18984#comments:id=2306634
        -- https://www.wowhead.com/npc=14742#comments:id=1122625
        -- https://www.wowhead.com/quest=29475/goblin-engineering
        -- https://www.wowhead.com/spell=23486/dimensional-ripper-everlook
        waypoints = {
            { mapID = 84, x = 0.628, y = 0.320, step = 2, label = "Lilliam Sparkspindle - Alliance Goblin specialization quest", npcID = 5518, locationType = "NPC" },
            { mapID = 85, x = 0.568, y = 0.564, step = 2, label = "Roxxik - Horde Goblin specialization quest", npcID = 11017, locationType = "NPC" },
            { mapID = 83, x = 0.596, y = 0.498, step = 3, label = "Zap Farflinger - learn through dialogue", npcID = 14742, locationType = "NPC" },
        },
    },
    [18986] = {
        difficulty = "medium",
        difficultyReason = "Buy the finished toy, or raise Classic Engineering, unlock the matching specialization and learn the recipe through NPC dialogue.",
        name = "Ultrasafe Transporter: Gadgetzan",
        acquisition = table.concat({
            "1. For collection only, buy the finished Ultrasafe Transporter: Gadgetzan (18986) or ask a Gnomish Engineer to craft it, then continue at step 6. You do not need Engineering to collect it. Activation requires the Gnomish specialization and Classic Engineering 260.",
            "2. For self-crafting, train Classic Engineering and reach 200 on a level 20 or higher character. If you lack Gnomish Engineering, take Gnomish Engineering (29477) from Lilliam Sparkspindle in Stormwind (62.8, 32.0) or Roxxik in Orgrimmar (56.8, 56.4). Turn in 6 Mithril Tubes, 2 Advanced Target Dummies and 1 Accurate Scope to that trainer; buying the finished quest items also works.",
            "3. With the Gnomish specialization and at least 260 Classic Engineering, visit Jhordy Lapforge beside the transporter at Gadgetzan, Tanaris (52.2, 27.8). Speak to him and choose the dialogue about building a beacon. He teaches the recipe directly; it is not sold by the ordinary Engineering supplier. Gadgetzan must not be hostile to you. The old claim that Honored reputation is required is contradicted by players learning the recipe at lower reputation.",
            "4. Raise Classic Engineering to 285 before crafting. The 260 requirement on the finished toy and in old comments is not the current recipe's crafting threshold. Search for Ultrasafe Transporter in Classic Engineering and clear the Have Materials filter if it appears missing.",
            "5. Gather 12 Mithril Bars, 2 Truesilver Transformers, 4 Cores of Earth, 2 Globes of Water, 4 Aquamarines and 1 Inlaid Mithril Cylinder. The cylinder is a Blacksmithing product: buy one or ask a blacksmith if you cannot make it. Craft Ultrasafe Transporter - Gadgetzan; the recipe uses a hyphen where the toy name uses a colon.",
            "6. Use the finished item in your bags to add it to the account-wide Toy Box. For an actual teleport, use an eligible Gnomish Engineer and have a ready slow-fall or parachute ability: a malfunction can put you high above Gadgetzan. Check that your fall protection is usable before starting the cast.",
        }, "\n\n"),
        stepCount = 6,
        npcId = 14743,
        source = "Gnomish Engineering; recipe taught through Jhordy Lapforge's dialogue in Gadgetzan",
        sourceType = "Professions",
        category = "Professions",
        tips = "Buying the finished toy is enough to collect it without changing specialization. Gnomish refers to the Engineering specialization, not your race. Malfunctions still occur; a recent reply confirms the high-altitude arrival. Hostile Gadgetzan guards are an additional risk for Bloodsail reputation farmers.",
        effect = "Teleports an eligible Gnomish Engineer to Gadgetzan in Tanaris; 4-hour cooldown. Possible malfunctions include a high-altitude arrival or a transformation.",
        requirements = "Collection: no profession. Recipe dialogue: Gnomish Engineer and Classic Engineering 260. Crafting: Classic Engineering 285. Use: Gnomish Engineer and Classic Engineering 260.",
        cost = "12 Mithril Bars, 2 Truesilver Transformers, 4 Cores of Earth, 2 Globes of Water, 4 Aquamarines, 1 Inlaid Mithril Cylinder; optional specialization quest items are extra.",
        faction = "all",
        wowheadUrl = "https://www.wowhead.com/item=18986",
        -- Acquisition, reputation correction, collection clarification and malfunction replies:
        -- https://www.wowhead.com/item=18986#comments:id=267288
        -- https://www.wowhead.com/item=18986#comments:id=2306633
        -- https://www.wowhead.com/item=18986#comments:id=2433590
        -- https://www.wowhead.com/item=18986#comments:id=1993177
        -- https://www.wowhead.com/npc=14743#comments:id=250182
        -- https://www.wowhead.com/quest=29477/gnomish-engineering
        -- https://www.wowhead.com/spell=23489/ultrasafe-transporter-gadgetzan
        waypoints = {
            { mapID = 84, x = 0.628, y = 0.320, step = 2, label = "Lilliam Sparkspindle - Alliance Gnomish specialization quest", npcID = 5518, locationType = "NPC" },
            { mapID = 85, x = 0.568, y = 0.564, step = 2, label = "Roxxik - Horde Gnomish specialization quest", npcID = 11017, locationType = "NPC" },
            { mapID = 71, x = 0.522, y = 0.278, step = 3, label = "Jhordy Lapforge - learn through dialogue", npcID = 14743, locationType = "NPC" },
        },
    },
}

-- Keep the researched difficulty visible in the walkthrough and on its catalogue row.
for _, guide in pairs(TDP.CollectionWalkthroughs.toys) do
    guide.availabilityReviewedAt = "2026-11-04"
    guide.acquisition = "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason .. "\n\n" .. guide.acquisition
end
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^1%.") then
        for _, entry in ipairs(patch.toys) do
            local guide = TDP.CollectionWalkthroughs.toys[entry.itemId]
            if guide then
                entry.difficulty = entry.difficulty or guide.difficulty
                entry.difficultyReason = entry.difficultyReason or guide.difficultyReason
                entry.availabilityReviewedAt = guide.availabilityReviewedAt
            end
        end
    end
end

