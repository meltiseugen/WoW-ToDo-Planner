local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("1.0", {
    label = "Original World of Warcraft Baseline",
    sourceNotes = {
        "This catalogue uses 1.0 as the base-game collection bucket for permanent collectibles already present before the commercial launch build. Blizzard's North American release itself was patch 1.1.0; client-build records identify 1.0.0 and 1.0.1 as the final open-beta builds.",
        "The baseline contains the original racial and class mounts, Winterspring Frostsaber, Rivendare's Deathcharger, vendor, quest, drop, and Engineering companions, plus Orb of Deception and Piccolo of the Flaming Fire, the two launch-era items now tracked by the modern Toy Box.",
        "The fourteen original unarmored level-60 racial mounts were retired in patch 1.4 and are excluded from the obtainable Retail catalogue. Collector's Edition, promotion, recurring-event and ordinary equipment records are excluded.",
        "Obtainable Retail achievements about Classic content are grouped in 1.0, regardless of the later patch that introduced the achievement record. This includes original dungeons and raids, Classic zones and reputations, and Classic profession milestones. Permanently unavailable achievement records are excluded. Expansion-neutral milestones and cross-expansion metas have their own General section.",
    },
    sourceUrls = {
        builds = "https://warcraft.wiki.gg/wiki/World_of_Warcraft_client_builds",
        companions = "https://warcraft.wiki.gg/wiki/Companions_by_source",
        kodo = "https://warcraft.wiki.gg/wiki/Kodo_mounts",
        mounts = "https://warcraft.wiki.gg/wiki/Mount",
        species = "https://warcraft.wiki.gg/wiki/BattlePetSpeciesID",
        toys = "https://warcraft.wiki.gg/wiki/List_of_toys_by_source",
        winterspring = "https://warcraft.wiki.gg/wiki/Reins_of_the_Winterspring_Frostsaber",
    },
    wowheadPatchId = 10000,
})

--[====[
Preserved inactive research: Data/Expansions/Classic/QuestRoutes.lua
This material is retained for reference and does not register character quest routes.

-- Classic collection bucket; all quest IDs and locations below are Retail data.
local _, TDP = ...
local guides, routes = TDP.CollectionWalkthroughs, TDP.CollectionQuestRoutes
local function point(mapID,x,y) return {mapID=mapID,x=x/100,y=y/100} end
local function quest(id,name,pickup,instructions,requires,objective,turnIn)
    return {questID=id,name=name,pickup=pickup,instructions=instructions,requires=requires,
        objective=objective,turnIn=turnIn or pickup,sourceURL="https://www.wowhead.com/quest="..id}
end
local function register(key,name,quests,options)
    local route=options or {}
    route.key,route.name,route.quests,route.version=key,name,quests,1
    route.reviewedAt="2026-11-12"
    routes[key]=route
    return route
end
local function attach(kind,ids,route,keepPins)
    for _,id in ipairs(ids) do
        local guide=guides[kind] and guides[kind][id]
        if guide then
            guide.questRoutes=guide.questRoutes or {}
            local exists=false
            for _,current in ipairs(guide.questRoutes) do if current.key==route.key then exists=true end end
            if not exists then guide.questRoutes[#guide.questRoutes+1]=route end
            if keepPins then guide.keepReferencePins=true end
        end
    end
end

-- Shared routes researched in the General pass; retain the same identities so
-- character observations also apply when the corresponding Classic item is open.
attach("achievements",{940},routes["nesingwary-stranglethorn"])
attach("achievements",{944},routes["timbermaw-nafien"],true)
attach("achievements",{946},routes["argent-dawn-introduction"],true)
attach("achievements",{3356},routes["winterspring-frostsaber"])

local bootY=point(210,43,72)
local chicken=register("classic-oox-rescues","Mechanical Chicken - all three OOX rescues",{
    quest(25475,"Find OOX-22/FE!",point(69,55,56),"Farm outdoor Feralas enemies such as Feral Scar Yetis for OOX-22/FE Distress Beacon (8705). Use the beacon in your bags, then find the damaged robot at 53.4,55.6.",{},point(69,53.4,55.6),point(69,53.4,55.6)),
    quest(25476,"Rescue OOX-22/FE!",point(69,53.4,55.6),"Escort the Feralas robot, stay beside it through ambushes and protect it until the escort objective completes. Then report to Oglethorpe in Booty Bay.",{25475},nil,bootY),
    quest(351,"Find OOX-17/TN!",point(71,60,64),"Loot OOX-17/TN Distress Beacon (8623) from Tanaris enemies, use it and find the damaged robot near 60,64.",{},point(71,60,64),point(71,60,64)),
    quest(648,"Rescue OOX-17/TN!",point(71,60,64),"Escort the Tanaris robot and protect it through the ambushes. When the escort ends, turn the rescue in to Oglethorpe in Booty Bay.",{351},nil,bootY),
    quest(485,"Find OOX-09/HL!",point(26,61,73),"Farm Hinterlands enemies, including the Jintha'Alor trolls, for OOX-09/HL Distress Beacon (8704). Use it and find the robot on the lake island at 49,38.",{},point(26,49,38),point(26,49,38)),
    quest(836,"Rescue OOX-09/HL!",point(26,49,38),"Escort the Hinterlands robot; keep it alive and stay nearby until the objective completes. Turn the rescue in to Oglethorpe in Booty Bay.",{485},nil,bootY),
    quest(3721,"An OOX of Your Own",bootY,"On the SAME character, turn in all three rescues to Oglethorpe Obnoticus. Accept his final reward quest, complete it and use the Mechanical Chicken item to learn the pet.",{25476,648,836}),
},{endQuestID=3721,after="The rescues must belong to one character. A robot may temporarily be away on another player's escort. Booty Bay must be non-hostile for Oglethorpe's turn-ins."})
chicken.quests[1].startItemID=8705
chicken.quests[3].startItemID=8623
chicken.quests[5].startItemID=8704
attach("pets",{83},chicken)

local cluck=register("classic-cluck","Westfall Chicken - CLUCK!",{
    quest(3861,"CLUCK!",point(52,56,31),"Buy Special Chicken Feed from Farmer Saldean first. Target an ordinary Chicken at Saldean's Farm and repeat /chicken until it becomes friendly and offers CLUCK!. Accept promptly; use /cheer if needed, turn in the feed and LOOT THE EGG on the ground.",{}),
},{faction="Alliance",after="Use the Chicken Egg to learn the pet; a quest turn-in alone does not collect it. CLUCK! is repeatable, so its flag is not a permanent learned-pet counter."})
local cluckH=register("classic-cluck-horde","Westfall Chicken - Horde CLUCK! route",{
    quest(3861,"CLUCK!",point(18,37.1,50.4),"Buy Special Chicken Feed from William Saldean at old Brill (60,53). If needed, use Zidormi at 69.4,62.8 for pre-battle Tirisfal. Find an ordinary Chicken around Solliden Farmstead, repeat /chicken until friendly, accept CLUCK!, /cheer if needed and turn in the feed. Loot the egg on the ground.",{}),
},{faction="Horde",after="Learn the Chicken Egg after looting it. The quest may be repeated; its completion flag is separate from account pet ownership."})
attach("pets",{84},cluck)
attach("pets",{84},cluckH)

local jubling=register("classic-jubling","Jubling - Spawn of Jubjub",{
    quest(7946,"Spawn of Jubjub",point(407,55.6,70.6),"During Darkmoon Faire, bring at least two Dark Iron Ale Mugs. Place one at Morja's feet to lure Jubjub; use a trail of extra mugs if the frog is distant. Accept her quest once he arrives, then turn in a spare mug for the Unhatched Jubling Egg.",{}),
},{endQuestID=7946,after="Keep the egg for seven real days, open it for A Jubling's Tiny Home and learn the pet. The egg can mature while offline and after the Faire ends; do not repeat the quest merely because the egg has not hatched."})
attach("pets",{106},jubling)

local demitrian=point(81,29.6,10.6)
local thunderfury=register("classic-thunderfury","Thunderfury - bindings and Demitrian's chain",{
    quest(7785,"Examine the Vessel",demitrian,"First loot either Binding of the Windseeker in original Molten Core: Garr drops the right half and Baron Geddon the left. In pre-wound Silithus, ask Demitrian about the binding to receive Vessel of Rebirth (19016). Use the vessel and return to him.",{}),
    quest(7786,"Thunderaan the Windseeker",demitrian,"With this quest ACTIVE, loot Essence of the Firelord from original Molten Core's Ragnaros. Bring BOTH bindings, ten Enchanted Elementium Bars and the essence to Demitrian. Cataclysm's ordinary Elementium Bars are the wrong material.",nil,point(232,56.23,53.4)),
    quest(7787,"Rise, Thunderfury!",demitrian,"After the materials turn-in, defeat the summoned Thunderaan near Demitrian. Loot Dormant Wind Kissed Blade (19018), use it to start the quest and present it to Demitrian for Thunderfury."),
},{endQuestID=7787,after="Keep the raid drops, quest and reward on the same character. Equip the one-handed sword for the personal achievement. Buying finished enchanted bars avoids needing Mining. Zidormi at Silithus 78.8,22 restores Demitrian's phase."})
thunderfury.quests[1].startItemID=19016
thunderfury.quests[3].startItemID=19018
attach("achievements",{428},thunderfury)

local contract=register("classic-sulfuron-contract","Sulfuras - optional Sulfuron Hammer recipe",{
    quest(7604,"A Binding Contract",point(243,50.4,58.8),"If crafting the hammer yourself, bring one extra Sulfuron Ingot to Lokhtos Darkbargainer in original Blackrock Depths' Grim Guzzler. Use his contract dialogue and complete the contract to receive Plans: Sulfuron Hammer.",{}),
},{optional=true,endQuestID=7604,after="Buying a finished Sulfuron Hammer skips this recipe route. Combine the hammer with the Eye of Sulfuras, then EQUIP Sulfuras on an eligible character for the personal achievement; the recipe quest alone is not the legendary."})
attach("achievements",{429},contract,true)

local eye=register("classic-cthun-eye","Brood of Nozdormu - optional Eye of C'Thun chain",{
    quest(8801,"C'Thun's Legacy",point(321,57,62.5),"Clear the original Temple of Ahn'Qiraj through C'Thun and loot Eye of C'Thun (21221). Use it, then take the eye to Caelestrasz in the friendly dragons' room beside C'Thun's chamber. Stay in the cleared raid for the follow-up.",{}),
    quest(8802,"The Savior of Kalimdor",point(321,57,62.5),"Accept from Caelestrasz in the dragons' room beside C'Thun. Take the eye to Anachronos on the central platform INSIDE the Caverns of Time, not his former outdoor position. Raise Brood of Nozdormu to Neutral if he remains hostile.",nil,nil,point(75,41.6,49.8)),
},{optional=true,endQuestID=8802,after="The C'Thun chamber pin is a reference for the adjacent uncharted dragon room, not a verified Caelestrasz coordinate. This one-time chain supplements the existing reputation routes; it is not required when using Timewalking commendations."})
eye.quests[1].startItemID=21221
eye.quests[1].turnInReference=true
eye.quests[2].pickupReference=true
attach("achievements",{956},eye,true)

local arena=register("classic-arena-grandmaster","Arena Grand Master - trinket turn-ins",{
    quest(7810,"Arena Master",point(210,46.4,26.6),"Loot an Arena Master trinket from the scheduled Gurubashi Arena chest. Use the trinket to accept its quest, then speak to Short John Mithril nearby.",{},nil,point(210,45,25.5)),
    quest(7838,"Arena Grandmaster",point(210,45,25.5),"Accept Short John Mithril's follow-up and collect twelve Arena Master trinkets together on this character. Loot future scheduled chests until you have enough, then turn them in for the Arena Grand Master reward.",nil,point(210,46.4,26.6)),
},{progressItemID=18706,progressRequired=12,progressLabel="Arena Master trinkets",after="Use the in-game chest schedule and the reference guide's contested-arena advice. Do not combine trinkets or quest completion from different characters."})
arena.quests[1].startItemID=18706
attach("achievements",{396},arena)

local morvek=point(78,71.6,73.8)
local venom=register("classic-venomhide","Venomhide Ravasaur - hatchling route",{
    quest(13850,"Toxic Tolerance",morvek,"Attack Venomhide Ravasaurs in southeastern Un'Goro until splashed with their poison twenty times. Strip damage/proc gear if you kill them too fast; an appropriately leveled Horde character or Party Sync can help.",{},point(78,67,71)),
    quest(13887,"Venomhide Eggs",morvek,"Collect four quest-marked Venomhide Ravasaur Eggs around the southeastern nests and return to Mor'vek."),
    quest(13906,"They Grow Up So Fast",morvek,"Keep the parent quest and Venomhide Hatchling item (46362). Summon the hatchling in Un'Goro, Tanaris or Silithus; complete its daily after each reset for a tooth. Bring twenty teeth, twenty Runecloth, twenty Rugged Leather and eighty gold to Mor'vek for the mount."),
},{faction="Horde",endQuestID=13906,progressItemID=47196,progressRequired=20,progressLabel="Venomhide Baby Teeth",
    dailyConfig={maps={[78]=true,[71]=true,[81]=true},hub=point(78,67,71),label="Summon your Venomhide Hatchling - ask for today's daily",turnInLabel="Turn in to your summoned Venomhide Hatchling",
        instructions="Next action: summon quest hatchling 46362 in Un'Goro, Tanaris or Silithus and accept today's offered daily. If already completed today, return after the daily reset."},
    after="Daily completions produce teeth; they do not permanently complete the parent quest. Keep using the same Horde character. After the final turn-in, use the whistle to learn the mount."})
venom.dailyQuests={
    quest(13889,"Hungry, Hungry Hatchling",point(78,67,71),"Loot fifteen Fresh Dinosaur Meat from Un'Goro dinosaurs and feed each piece to the hatchling."),
    quest(13903,"Gorishi Grub",point(78,50,79),"Loot ten Silithid Meat from Gorishi silithids and feed it to the hatchling."),
    quest(13904,"Poached, Scrambled, Or Raw?",point(71,35,46),"Collect twelve Silithid Eggs from the Tanaris silithid hives and feed them to the hatchling."),
    quest(13905,"Searing Roc Feathers",point(71,42,62.2),"Kill Searing Rocs in Tanaris for five pieces of Searing Roc Plumage, then return to your summoned hatchling."),
}
attach("achievements",{3357},venom)

local admiral=register("classic-bloodsail-admiral","Bloodsail Admiral - Avast Ye chain",{
    quest(1036,"Avast Ye, Scallywag",point(210,44.4,92.6),"Reach Friendly Bloodsail Buccaneers and Hated Booty Bay by killing Booty Bay Bruisers. Speak to Pretty Boy Duncan at the Wild Shore Bloodsail camp, then report to Fleet Master Firallon below decks on the middle ship. This introduction can be skipped if you already have the Admiral quest.",{},nil,point(210,46.6,95.2)),
    quest(4621,"Avast Ye, Admiral!",point(210,46.6,95.2),"Speak to Fleet Master Firallon below decks on the middle Wild Shore ship. With the quest active, kill Baron Revilgaz and Fleet Master Seahorn on Booty Bay's tavern balcony, then return to Firallon.",nil,point(210,41,73)),
},{endQuestID=4621,after="The quest rewards the Bloodsail Admiral's Hat and title. If pursuing Insane in the Membrane, also reach Honored Bloodsail on the same character before restoring goblin reputation. The old siege introduction is not required."})
attach("achievements",{871},admiral)
attach("achievements",{2336},admiral,true)
guides.achievements[2336].questRoutesOptional=true

local oldScarlet=register("classic-old-scarlet-key","Old Scarlet Monastery - optional key unlock",{
    quest(77644,"The Scarlet Key",point(18,83.9,32.1),"Acquire the tradable Scarlet Key (208485), for example through the Auction House. In pre-battle Tirisfal, enter Scarlet Monastery's exterior vestibule and interact with the Old Keyring on the left wall at the top of the stairs. Accept and immediately turn in the key.",{}),
},{optional=true,endQuestID=77644,accountUnlockQuestID=77644,after="This unlock is account-wide; it is an explicit exception to character-specific quest-chain tracking. Click the Old Keyring to toggle the old-dungeon buff, then enter the OLD ARMORY for Herod's trainees. Regular Scarlet Halls remains a no-key alternative for the tabard."})
attach("cosmetics",{23192},oldScarlet,true)

for _,kind in ipairs({"Alliance","Horde"}) do
    local trainer=kind=="Alliance" and point(84,62.8,32) or point(85,56.8,56.4)
    local gnomish=register("classic-gnomish-"..kind:lower(),"Gnomish Engineering - optional crafting specialization",{
        quest(29477,"Gnomish Engineering",trainer,"At level twenty with Classic Engineering two hundred, ask this capital's Engineering trainer for the specialization. Bring six Mithril Tubes, one Accurate Scope and two Advanced Target Dummies; these can be purchased finished items.",{}),
    },{faction=kind,optional=true,endQuestID=29477,satisfiedSpellID=20219,after="Buying a finished toy skips this crafting unlock. A completed old specialization quest does not prove you still know that specialization after switching; check the Engineering profession before crafting or using the toy."})
    local goblin=register("classic-goblin-"..kind:lower(),"Goblin Engineering - optional crafting specialization",{
        quest(29475,"Goblin Engineering",trainer,"At level twenty with Classic Engineering two hundred, ask this capital's Engineering trainer for Goblin specialization. Bring twenty Big Iron Bombs, twenty Solid Dynamite and five Explosive Sheep, counted as finished items.",{}),
    },{faction=kind,optional=true,endQuestID=29475,satisfiedSpellID=20222,after="Buying a finished toy skips the crafting unlock. Verify the current profession specialization; a historical quest flag does not track later specialization switches."})
    attach("toys",{18660,18986},gnomish,true)
    attach("toys",{18984},goblin,true)
end

local lore=TDP.ClassicLoremasterData
if lore then
    for _,entry in ipairs(lore.chapters) do
        local ordered,visited,visiting={},{},{}
        local function visit(id)
            if visited[id] or visiting[id] then return end
            local step=lore.quests[id]
            if not step then return end
            visiting[id]=true
            for _,previous in ipairs(step.requires or {}) do visit(previous) end
            visiting[id],visited[id]=nil,true
            ordered[#ordered+1]=step
        end
        for _,id in ipairs(entry.ends) do visit(id) end
        local chapter=register("classic-story-"..entry.achievementID.."-"..entry.criteriaID,
            entry.zoneName.." - "..entry.name,ordered,{
                faction=entry.faction,compact=true,achievementID=entry.achievementID,criteriaID=entry.criteriaID,
                sourceURL="https://www.wowhead.com/achievement="..entry.achievementID,
                sourceRevision=lore.revision,
            })
        attach("achievements",{entry.metaID},chapter)
        -- Opening a linked component achievement uses the same researched data.
        -- No dependency on another quest-viewer addon is introduced.
        attach("achievements",{entry.achievementID},chapter)
    end
end

-- The remaining Classic entries use current vendor/drop/crafting/skill/PvP or
-- exploration routes. Removed class mount, Sprite Darter, Kibler capture and
-- Artisan profession quests are intentionally not reintroduced.

]====]
