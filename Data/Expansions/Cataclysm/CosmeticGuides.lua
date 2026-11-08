-- English Retail acquisition guides, manually reviewed 2026-11-04.
-- Reviewed all 259 parent comments across these 12 item pages, then expanded
-- relevant acquisition/correction threads through /comment/show-replies.
-- None contains a numbered acquisition guide ending in Profit. The routes
-- below reconcile the discussions, replies, existing descriptions and current
-- Retail item/vendor/quest records. All 12 tabards remain obtainable.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.cosmetics = TDP.CollectionWalkthroughs.cosmetics or {}
local guides = TDP.CollectionWalkthroughs.cosmetics

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function add(itemID, name, guide)
    local lines = { "Difficulty: " .. guide.difficulty:gsub("^%l", string.upper) .. " - " .. guide.difficultyReason }
    for step, instruction in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. instruction
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #guide.steps
    guide.steps = nil
    guide.sourceType = guide.category
    guide.wowheadUrl = "https://www.wowhead.com/item=" .. itemID
    guides[itemID] = guide
end

-- /item=63378: comments 1231287, 1246261, 1311062, 1638097, 3307923.
-- /item=63379: comments 1219666 and 3189389 (daily/currency route).
-- Replies 203603/202082 distinguish teleporting from reputation championing;
-- 1375687 corrects the old use-and-refund suggestion. Current sold-by records
-- confirm 40 currency 391, from /npc=48531 and /npc=47328 on map 245.
for _, tabard in ipairs({
    {
        id = 63378, name = "Hellscream's Reach Tabard", side = "Horde", reputation = "Hellscream's Reach",
        vendor = "Pogg", npc = 48531, x = 54.6, y = 80.8,
        hub = "Hellscream's Grasp", hubX = 55.0, hubY = 80.0,
        capital = "Orgrimmar", capitalMap = 85, capitalX = 50.6, capitalY = 38.6,
        departure = "the Western Earthshrine, on the elevated northern Cataclysm portal platform around 50.6,38.6",
    },
    {
        id = 63379, name = "Baradin's Wardens Tabard", side = "Alliance", reputation = "Baradin's Wardens",
        vendor = "Quartermaster Brazie", npc = 47328, x = 72.5, y = 62.7,
        hub = "Baradin Base Camp", hubX = 73.0, hubY = 61.0,
        capital = "Stormwind City", capitalMap = 84, capitalX = 73.3, capitalY = 18.4,
        departure = "the Tol Barad portal on the northeastern Earthshrine island at 73.3,18.4",
    },
}) do
    add(tabard.id, tabard.name, {
        category = "Reputation", faction = tabard.side:lower(), npcId = tabard.npc,
        source = tabard.vendor .. " - Tol Barad Peninsula, " .. tabard.reputation .. " Honored",
        description = "A faction tabard with a reusable teleport to " .. tabard.hub .. ". It does not grant dungeon reputation.",
        difficulty = "medium", difficultyReason = "Requires Honored reputation and daily-quest currency over repeated visits; the purchase itself is guaranteed.",
        requirements = tabard.side .. "; Honored with " .. tabard.reputation .. " on the buyer",
        cost = "40 Tol Barad Commendations (currency 391)",
        steps = {
            "Use a " .. tabard.side .. " character and check " .. tabard.reputation .. " in the reputation panel. You need Honored and 40 spendable Tol Barad Commendations on the buying character. You do not need the Tol Barad achievement meta or an old PvP season rating.",
            "In " .. tabard.capital .. ", go to " .. tabard.departure .. ". Take the portal to Tol Barad Peninsula. The daily-quest peninsula is the northern island; you do not need to enter the southern PvP battle or Baradin Hold to buy this tabard.",
            "At " .. tabard.hub .. " on Tol Barad Peninsula (" .. tabard.hubX .. "," .. tabard.hubY .. "), accept all offered faction dailies. Follow their objective areas, complete the kill/collection/rescue tasks and return to the camp to turn them in. The quests award both faction reputation and commendations; unfinished objectives alone do not pay either reward.",
            "Repeat the available peninsula dailies after daily resets until you have BOTH Honored reputation and 40 commendations. Save those 40 instead of spending them on mounts, pets or reputation tokens. This route works without winning or controlling the southern battle island, so you can continue even when no battle group is available.",
            "Return to " .. tabard.vendor .. " at " .. tabard.x .. "," .. tabard.y .. " on the same Peninsula map. Set the shop filter to All, find " .. tabard.name .. " (" .. tabard.id .. ") and buy it for 40 commendations. If the item is red, check the buyer's reputation and currency separately.",
            "Equip the tabard and keep it. Its on-use effect returns you to " .. tabard.hub .. "; that camp also has a portal back to your faction capital. Transmog alone does not provide the teleport. Do not follow old comments recommending a refund after collecting or using it: a refund can remove a collection unlock, and using the teleport can end refund eligibility.",
        },
        tips = "Battle wins and the extra dailies available when your faction controls Tol Barad can supplement the peninsula route. They are optional. Wearing this tabard in dungeons does not earn " .. tabard.reputation .. " reputation. The teleport has a 4-hour cooldown.",
        effect = "Teleports the wearer to " .. tabard.hub .. " on Tol Barad Peninsula; 4-hour cooldown.",
        waypoints = {
            pin(tabard.capitalMap, tabard.capitalX, tabard.capitalY, 2, "Cataclysm portal area - depart for Tol Barad", tabard.capital),
            pin(245, tabard.hubX, tabard.hubY, 3, tabard.hub .. " - accept and turn in peninsula dailies", "Tol Barad Peninsula"),
            pin(245, tabard.hubX, tabard.hubY, 4, "Repeat dailies until Honored and 40 commendations", "Tol Barad Peninsula"),
            pin(245, tabard.x, tabard.y, 5, tabard.vendor .. " - buy " .. tabard.name, "Tol Barad Peninsula"),
        },
    })
end

-- https://www.wowhead.com/item=64882#comments:id=6274507 and reply 1818631.
-- /npc=50307: 6270288, 6278501, 6279462; full thread 5995245 includes
-- reply 1818966 confirming old Darnassus remains usable in Retail 12.0.
-- September/October 2026 comments 6420102/6431768 also confirm that fallback.
-- Thread 6270288 reports an empty Gilneas phase even after reclamation: do not
-- promise that repeating that campaign always fixes it. Map 217 is the outdoor
-- Ruins of Gilneas map, not an inaccessible Worgen starting scenario.
add(64882, "Gilneas Tabard", {
    category = "Vendor", faction = "alliance", npcId = 50307,
    source = "Lord Candren - reclaimed Gilneas; pre-burning Darnassus if phased",
    description = "Gilneas city tabard sold directly for silver. Any eligible Alliance race can buy it without first earning Exalted.",
    difficulty = "easy", difficultyReason = "A cheap direct purchase; a second confirmed Retail location covers characters with an empty Gilneas phase.",
    requirements = "Alliance; Neutral or better with Gilneas for the tabard itself",
    cost = "10 silver base price, before applicable discounts",
    steps = {
        "Use an Alliance character and bring 10 silver. You do not need to be a Worgen, earn Exalted, unlock an Argent Tournament championship or complete a racial heritage achievement to buy this tabard.",
        "Check Lord Candren in present-day Gilneas City, at 57.3,55.5 on the outdoor Ruins of Gilneas map. He sits on a horse near the flagpole in Greymane Court, in the city's southwestern sector. If he is present, buy Gilneas Tabard (64882) and continue at step 5. Do not use the Worgen starting scenario as your destination.",
        "If the city is empty or Candren is missing, use the confirmed Darnassus alternative. Travel to Darkshore and speak to Zidormi near 48.8,24.4, choosing the option to see Darkshore before the battle. If you are already in the intact older world phase, keep that phase. This time-travel version is still accessible in Retail.",
        "From that Darkshore phase, travel to Rut'theran Village and enter Darnassus through its pink portal. Find Lord Candren beside the city's flight master in the Temple Gardens, around 37.2,47.6 on the Darnassus map. Buy Gilneas Tabard for up to 10 silver. The Stormwind Embassy directions in older comments no longer describe the dependable current purchase route.",
        "Equip the purchased tabard to register the collectible. Acquisition is complete: you do not need to grind Gilneas reputation just to own it. Keep the physical tabard if you also want its reputation effect; applying its transmog appearance does not champion Gilneas.",
    },
    tips = "The reclaimed-city vendor and pre-burning Darnassus fallback are both supported by Retail comments. Gilneas Liberation Front Tabard is a different reward. For optional Gilneas reputation, wear this physical tabard in an eligible dungeon and check actual reputation gains before repeating runs; the old infinite-add farming tricks were changed.",
    effect = "Champions Gilneas reputation in eligible dungeons while the real tabard is equipped.",
    waypoints = {
        pin(217, 57.3, 55.5, 2, "Lord Candren - present-day Gilneas purchase", "Ruins of Gilneas"),
        pin(62, 48.8, 24.4, 3, "Zidormi - pre-burning phase, only if Candren is missing", "Darkshore"),
        pin(89, 37.2, 47.6, 4, "Lord Candren - confirmed pre-burning Darnassus alternative", "Darnassus"),
    },
})

-- /item=64884: all 34 parents; 1174590 (purchase), 1178896 (old bug),
-- 1182123/1199962 (fixed infinite-add methods), 3201895 and reply 1485623.
-- /npc=50323 g_mapperData places Frizzo on the upper flight-master platform.
add(64884, "Bilgewater Cartel Tabard", {
    category = "Vendor", faction = "horde", npcId = 50323,
    source = "Frizzo Villamar - Orgrimmar's upper flight-master platform",
    description = "The goblin city tabard is a direct silver purchase for Horde characters; a Goblin character or Exalted reputation is unnecessary.",
    difficulty = "easy", difficultyReason = "Reach a capital-city vendor and pay a small silver price; no quest chain or reputation grind is required.",
    requirements = "Horde; Neutral or better with Bilgewater Cartel for the tabard itself",
    cost = "10 silver base price, before applicable discounts",
    steps = {
        "Use a Horde character and bring 10 silver. A non-Goblin can buy the tabard. The reputation requirements attached to Frizzo's cloaks and bag do not mean you must earn that standing before buying the tabard.",
        "Go to Orgrimmar's central upper flight-master platform above the Valley of Strength. Fly up or use the nearby elevator, then find Frizzo Villamar on her trike around 49.6,58.6. This is the elevated platform with the city quartermasters, rather than a vendor in the Goblin Slums at street level.",
        "Open Frizzo's shop, select All if your class filter hides items, and buy Bilgewater Cartel Tabard (64884) for up to 10 silver. Check the actual tabard name; the old database entry Bilgewater Champion's Tabard is not an additional acquisition requirement.",
        "Equip the physical tabard to register it. You have now obtained the cosmetic. Keep it if you want to earn Bilgewater Cartel reputation in eligible dungeons; a transmog appearance by itself does not apply the reputation effect.",
        "Optional reputation: on a character able to solo it, enter The Mechanar on Normal at 70.5,69.6 in Netherstorm, the southern Tempest Keep satellite. Keep the tabard equipped, kill enemies and bosses, and verify Bilgewater reputation gains. Take the exit portal after Pathaleon, reset outside and repeat within the instance-entry limit. This optional grind is for further reputation rewards, not for buying the tabard.",
    },
    tips = "Directly damage enemies instead of letting an untagged pet kill them. The old Hadronox, Pit of Saron and Blackrock Depths infinite-reputation tricks were fixed; old five-instances-per-hour and original Scarlet Monastery routes are not the current route used here.",
    effect = "Champions Bilgewater Cartel reputation in eligible dungeons while the real tabard is equipped.",
    waypoints = {
        pin(85, 49.6, 58.6, 2, "Frizzo Villamar - upper flight-master platform", "Orgrimmar"),
        pin(85, 49.6, 58.6, 3, "Buy Bilgewater Cartel Tabard", "Orgrimmar"),
        pin(109, 70.5, 69.6, 5, "The Mechanar - optional reputation, Normal difficulty", "Netherstorm"),
    },
})

-- /item=65904: 1245615, 1283466 and reply 214181; /quest=28112.
-- /npc=48617 g_mapperData: original Uldum 54.0,33.2, map 249.
-- Comments 5768018/6153597 supersede unconditional old dungeon-farm claims.
add(65904, "Tabard of Ramkahen", {
    category = "Reputation", npcId = 48617,
    source = "Blacksmith Abasi - Ramkahen, Uldum; Friendly",
    description = "A guaranteed Friendly reputation purchase from Ramkahen's blacksmith. The early Prince Nadun quests supply the starting reputation.",
    difficulty = "easy", difficultyReason = "A short opening quest sequence and an optional reputation reward unlock a cheap guaranteed purchase.",
    requirements = "Friendly with Ramkahen on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "Check Ramkahen reputation first. If already Friendly or higher, skip to step 5. Otherwise use original Cataclysm Uldum. If you see the later N'Zoth assault phase, speak to Zidormi near Ramkahen at 56.0,35.1 and ask to see Uldum before the assaults.",
        "Start Easy Money with Adarrah's caravan at 30.5,65.5 in southwestern Tanaris, outside the entrance to Uldum. Use the Tanaris map for this starting point. Follow the caravan and capture sequence into the Lost City, then take Prince Nadun's quests beginning with Traitors! Enable Trivial Quests if the low-level quest markers are hidden.",
        "Complete Nadun's captive-escape tasks and Escape From the Lost City, starting with him at 59.6,72.0 in Uldum. Free him and the other prisoners, then meet King Phaoris in Ramkahen at 54.8,32.8. Choose the Ramkahen Badge of Valor reward instead of the small gold reward and use the badge for its 1,000 Ramkahen reputation if that choice is still available to this character.",
        "If still below Friendly, continue the Ramkahen story quests offered in the city and its surrounding Tol'vir settlements until the reputation panel shows Friendly. Prioritize quests whose rewards list Ramkahen reputation; the separate Harrison Jones archaeology story does not supply all of this faction's reputation. Stop at Friendly for this cosmetic.",
        "Find Blacksmith Abasi at 54.0,33.2 in Ramkahen. Facing the inn entrance, take the small path to the left on the same level. Buy Tabard of Ramkahen (65904) for up to 1 gold and equip it. You do not need Exalted, either camel mount or the entire Uldum campaign.",
    },
    tips = "The tabard is Unique. If the shop says you cannot carry more, check bags and bank for an existing copy. Its Cataclysm dungeon reputation effect is useful after purchase, but conflicting Retail reports make old Zul'Gurub/Mists farming instructions unsuitable as an unconditional route to this tabard.",
    effect = "Champions Ramkahen in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(249, 56.0, 35.1, 1, "Zidormi - original Uldum if in the assault phase", "Uldum"),
        pin(71, 30.5, 65.5, 2, "Adarrah - Easy Money, outside the Uldum entrance", "Tanaris"),
        pin(249, 59.6, 72.0, 3, "Prince Nadun - Escape From the Lost City", "Uldum"),
        pin(249, 54.8, 32.8, 3, "King Phaoris - escape turn-in and reputation reward", "Uldum"),
        pin(249, 54.0, 33.2, 5, "Blacksmith Abasi - Friendly tabard purchase", "Uldum"),
    },
})

-- /item=65905: 1212900, 1291559, 1641823 and 2585297 with reply 1124093.
-- /npc=50324: 1232362 and replies distinguish the cave entrance from the NPC.
-- /guide/how-to-skip-intro-campaigns-and-unlock-world-quests-for-alts-in-every-expansion-34723
-- supplies current capital starters; /quest=25371 supplies the seahorse route.
add(65905, "Tabard of the Earthen Ring", {
    category = "Reputation", npcId = 50324,
    source = "Provisioner Arok - inside Silver Tide Hollow, Shimmering Expanse; Friendly",
    description = "An Earthen Ring reputation tabard sold inside an underwater refuge. Reaching Friendly and finding the cave entrance are separate tasks.",
    difficulty = "medium", difficultyReason = "Needs initial reputation and underwater travel; the vendor is inside a cave above the seabed.",
    requirements = "Friendly with The Earthen Ring on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "Check The Earthen Ring in your reputation panel. If you are already Friendly from Deepholm, Vashj'ir or other Earthen Ring quests, you can go directly to the vendor once you can travel underwater safely. You do not have to finish Vashj'ir's entire campaign.",
        "For a fresh route, start Vashj'ir from your capital's Cataclysm introduction: Naraat the Earthspeaker at 74.6,19.6 in Stormwind or Farseer Krogar at 50.6,38.6 in Orgrimmar. Follow the Vashj'ir/Call of Duty chain, board its ship and allow the shipwreck sequence to finish. An already unlocked Vashj'ir portal can be used instead.",
        "In Kelp'thar Forest, complete Sea Legs with Erunak Stonespeaker around 45.1,23.5 for underwater breathing and movement. Follow the survivors' opening quests. Complete Moanah Stormhoof's The Abyssal Ride around 46.0,46.8 if you want the fast zone seahorse, then continue Earthen Ring quest rewards until Friendly. Reputation previously earned in Deepholm also counts.",
        "Travel into the Shimmering Expanse and approach Silver Tide Hollow near 50.5,38.0. Face south toward the reef column and look for the cave mouth partway above the seabed, among the conspicuous yellow/purple coral fronds. Swim into the side of the reef; swimming along the surface or standing on top of the vendor's map dot will not enter the refuge.",
        "Inside the air-filled cave, find Provisioner Arok near 49.0,42.0 on the Shimmering Expanse map, beside the other camp vendors. This refuge does not require completing every quest leading to it. Buy Tabard of the Earthen Ring (65905) for up to 1 gold once Friendly, then equip it.",
    },
    tips = "Use the Shimmering Expanse map for the cave pins, not the larger Vashj'ir overview. The cave entrance and Arok are distinct positions on that same map. Old claims that this tabard works in every later expansion's dungeons are incorrect; collecting it only requires the Friendly vendor purchase.",
    effect = "Champions The Earthen Ring in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(84, 74.6, 19.6, 2, "Naraat the Earthspeaker - Alliance Vashj'ir introduction", "Stormwind City"),
        pin(85, 50.6, 38.6, 2, "Farseer Krogar - Horde Vashj'ir introduction", "Orgrimmar"),
        pin(201, 45.1, 23.5, 3, "Erunak Stonespeaker - Sea Legs and opening quests", "Kelp'thar Forest"),
        pin(201, 46.0, 46.8, 3, "Moanah Stormhoof - optional seahorse quest", "Kelp'thar Forest"),
        pin(205, 50.5, 38.0, 4, "Silver Tide Hollow - entrance in the reef wall", "Shimmering Expanse"),
        pin(205, 49.0, 42.0, 5, "Provisioner Arok - inside the air-filled cave", "Shimmering Expanse"),
    },
})

-- /item=65906: 1215508, 1245635; /npc=50314: 1211350 and 1217429.
-- Reply 1608466 to 5544797 corrects a different-faction Firelands raid claim.
add(65906, "Tabard of the Guardians of Hyjal", {
    category = "Reputation", npcId = 50314,
    source = "Provisioner Whitecloud - Nordrassil Inn, Mount Hyjal; Friendly",
    description = "The Guardians of Hyjal tabard is available at the zone's starting inn once you reach Friendly; Molten Front progression is unnecessary.",
    difficulty = "easy", difficultyReason = "Opening Mount Hyjal quests unlock a cheap purchase at the first hub.",
    requirements = "Friendly with Guardians of Hyjal on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "Check Guardians of Hyjal reputation. If already Friendly, go directly to step 4. This is the original Mount Hyjal questing faction; Avengers of Hyjal, earned in the Firelands raid, is a different reputation and does not satisfy this purchase.",
        "If the zone introduction is new, take Hero's Call: Mount Hyjal! from Stormwind's board at 63.1,71.4 or Warchief's Command: Mount Hyjal! from Orgrimmar's board at 49.8,76.4. Follow the introduction to Moonglade, then use Aronus at 46.0,45.5 for the As Hyjal Burns flight to Nordrassil. If your Mount Hyjal portal is already unlocked, use it to reach the same starting hub.",
        "At Nordrassil, speak with Ysera around 62.0,24.8. Follow Protect the World Tree to Malfurion Stormrage at the Tranquil Grove, 47.6,35.5. Complete his local defense and Flameseer quests, checking for Guardians of Hyjal reputation in the rewards. Continue the opening story until Friendly; you can stop for the tabard without unlocking the later Molten Front dailies.",
        "Enter Nordrassil Inn, the building by the first arrival point, at 62.8,23.8 in Mount Hyjal. Find Provisioner Whitecloud just inside on the right. The female Tauren quartermaster can be present before you finish the zone; if her tabard is red, the remaining gate is your reputation.",
        "Buy Tabard of the Guardians of Hyjal (65906) for up to 1 gold and equip it. Check the name before buying: the similarly styled Cenarion Expedition Tabard belongs to a separate Outland faction. The cosmetic is obtained at Friendly, so Exalted is optional.",
    },
    tips = "The physical tabard champions eligible Cataclysm dungeon reputation. Firelands raid boss kills grant Avengers of Hyjal, not Guardians of Hyjal; do not follow the down-rated item comment that confuses them. Early normal-mode dungeon exclusions and scaling changes also mean wearing the tabard does not guarantee reputation from every dungeon.",
    effect = "Champions Guardians of Hyjal in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(84, 63.1, 71.4, 2, "Hero's Call Board - Alliance Mount Hyjal introduction", "Stormwind City"),
        pin(85, 49.8, 76.4, 2, "Warchief's Command Board - Horde Mount Hyjal introduction", "Orgrimmar"),
        pin(80, 46.0, 45.5, 2, "Aronus - As Hyjal Burns flight", "Moonglade"),
        pin(198, 62.0, 24.8, 3, "Ysera - Nordrassil arrival and story handoff", "Mount Hyjal"),
        pin(198, 47.6, 35.5, 3, "Malfurion - Tranquil Grove defense and Flameseer quests", "Mount Hyjal"),
        pin(198, 62.8, 23.8, 4, "Nordrassil Inn - Provisioner Whitecloud inside", "Mount Hyjal"),
        pin(198, 62.8, 23.8, 5, "Buy the Guardians of Hyjal tabard at Friendly", "Mount Hyjal"),
    },
})

-- /item=65907: 1365820, 1429287, 1654526 and expanded reply 1689446.
-- /npc=45408: 1265096 and reply 237121; /quest=26326 and /quest=26750.
-- /quest=26315, /quest=26328, /quest=26436, /quest=26507,
-- /quest=26576 and /quest=26577 supply the intervening handoffs and map pins.
-- The corrected route uses actual campaign milestones, not an exact old quest
-- count or the false claim that every optional Deepholm quest is mandatory.
add(65907, "Tabard of Therazane", {
    category = "Reputation", npcId = 45408,
    source = "D'lom the Collector - Therazane's Throne, Deepholm; Friendly and the friendly world phase",
    description = "A tabard locked behind Deepholm's World Pillar and stone-lord story. The quartermaster becomes usable before the faction's full daily hub opens.",
    difficulty = "hard", difficultyReason = "A fresh character must advance a long campaign through several quest chains before the initially hostile faction will sell anything.",
    requirements = "Friendly with Therazane and sufficient Deepholm story progression on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "If D'lom is already friendly and your Therazane reputation is Friendly or higher, skip to step 8. Otherwise start The Maelstrom with Naraat the Earthspeaker at 74.6,19.6 in Stormwind or Farseer Krogar at 50.6,38.6 in Orgrimmar. Follow the portal/flight introduction into Deepholm; an already unlocked Deepholm portal also works.",
        "At the Temple of Earth around 49.5,53.3 in Deepholm, follow the World Pillar recovery story. Complete the Stormcaller Mylra/airship chain and the Stonehearth/Earthen chain that restore the first two required fragments. Return the fragments and turn in their Temple follow-ups. Flying straight to Therazane's Throne on a fresh character does not bypass this progression.",
        "Take The Very Earth Beneath Our Feet (26326) when the Temple story offers it. Meet Earthcaller Torunscar and Earthmender Norsala northwest of the Temple near 46.0,45.6. Complete Crumbling Defenses, Core of Our Troubles and On Even Ground, then Imposing Confrontation. Read the proclamation to Boden and stay in front of him until his speech and knockback finish; leaving early can prevent quest credit.",
        "Take Rocky Relations to Diamant the Patient at 56.4,42.6. Complete Hatred Runs Deep, Unsolid Ground and Loose Stones, then the follow-ups through Violent Gale, Depth of the Depths and A Rock Amongst Many. Take Entrenched when offered; it sends you to Kor the Immovable at 34.4,34.4. The Stonecore dungeon detour is not needed just for this tabard.",
        "At Kor, complete the offered aid quests and follow-ups through Clingy, So Big, So Round... and Rock Bottom. When Pebble offers Petrified Delicacies, gather 12 Petrified Stone Bats; ground pickups around 42.8,29.4 can supply them without repeatedly killing basilisks. Turn the bats in to Pebble, then check Kor again for the next handoffs. Keep both the main story and Pebble's follow-up moving if one seems to stop.",
        "Follow Steady Hand to Terrath at 39.8,19.5 in the Pale Roost and complete his branch through Resonating Blow. Follow Rocky Upheaval to Gorsik at 72.2,53.8 in the Crimson Expanse and complete his offered fungal/corruption branch, including its follow-ups to Shaken and Stirred and Corruption Destruction. Finish the outstanding handoffs on both sides until At the Stonemother's Call (26750) becomes available.",
        "Speak to Therazane at her northern throne around 56.3,12.2 and finish the offered story handoffs until the reputation panel shows at least Friendly and D'lom is a friendly vendor. Check him at this point. Unlocking all daily quests, finishing The Binding or completing the Deepholm quest-count achievement is not required just to buy the tabard.",
        "At Therazane's Throne, find D'lom the Collector at 56.8,13.2. Buy Tabard of Therazane (65907) for up to 1 gold and equip it. If D'lom remains hostile, resume the outstanding stone-lord story handoff instead of trying to farm dungeon reputation before owning the tabard.",
    },
    tips = "The Twilight Plot/Fly Over side chain is not mandatory for this purchase; a 2024 reply confirms the tabard can be owned while those quests remain unfinished. Continue Deepholm after buying only if you also want its daily hub or other rewards. No shoulder enchant or Exalted standing is required for the cosmetic.",
    effect = "Champions Therazane in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(84, 74.6, 19.6, 1, "Naraat the Earthspeaker - Alliance The Maelstrom", "Stormwind City"),
        pin(85, 50.6, 38.6, 1, "Farseer Krogar - Horde The Maelstrom", "Orgrimmar"),
        pin(207, 49.5, 53.3, 2, "Temple of Earth - World Pillar story and fragment turn-ins", "Deepholm"),
        pin(207, 46.0, 45.6, 3, "Earthmender Norsala - stone-lord story", "Deepholm"),
        pin(207, 56.4, 42.6, 4, "Diamant the Patient - Rocky Relations and follow-ups", "Deepholm"),
        pin(207, 34.4, 34.4, 4, "Kor the Immovable - Entrenched handoff", "Deepholm"),
        pin(207, 34.4, 34.4, 5, "Kor and Pebble - Rock Bottom and linked quests", "Deepholm"),
        pin(207, 42.8, 29.4, 5, "Petrified Stone Bats - gather 12 for Pebble", "Deepholm"),
        pin(207, 39.8, 19.5, 6, "Terrath - Steady Hand branch", "Deepholm"),
        pin(207, 72.2, 53.8, 6, "Gorsik - Rocky Upheaval branch", "Deepholm"),
        pin(207, 56.3, 12.2, 7, "Therazane - complete the friendly-faction handoff", "Deepholm"),
        pin(207, 56.8, 13.2, 8, "D'lom the Collector - buy Tabard of Therazane", "Deepholm"),
    },
})

-- /item=65908: all 8 parents, especially 1215699 and reply 1086496.
-- /quest=28716: current Retail Jes-Tereth/Fargo entry and Highbank sequence.
-- The original Stormwind investigation/Varian chain was removed in Legion.
add(65908, "Tabard of the Wildhammer Clan", {
    category = "Reputation", faction = "alliance", npcId = 49386,
    source = "Craw McGraw - Thundermar, Twilight Highlands; Friendly",
    description = "The Alliance Twilight Highlands tabard. Establish Highbank, then help the Wildhammer clans until their quartermaster will sell it.",
    difficulty = "medium", difficultyReason = "A guaranteed low-cost purchase after the zone introduction and several Wildhammer quest hubs.",
    requirements = "Alliance; Friendly with Wildhammer Clan on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "Use an Alliance character and check Wildhammer Clan reputation. If already Friendly and Thundermar's quartermaster is accessible, skip to step 5. Hinterlands Wildhammer lore and the Horde's Dragonmaw standing do not replace this Cataclysm reputation.",
        "Start the current Twilight Shores introduction with Grand Admiral Jes-Tereth in Stormwind Keep at 85.8,32.4, then meet Fargo Flintlocke at the harbor around 26.1,47.2 and take his seaplane. The old detective quests with young Anduin and King Varian are no longer the Retail entry route. If Fargo is missing, resolve a conflicting Call of Duty harbor phase before returning.",
        "At Highbank in Twilight Highlands, around 81.0,79.4, follow Welcome to Highbank!, Burnin' at Both Ends and Aiming High. Continue Kurdran's and Lieutenant Emry's beach quests through Wings Over Highbank, Any Portal in a Storm and The Way is Open. This establishes the Alliance base and its return portal; simply flying to an unopened Highbank can leave the necessary NPCs phased out.",
        "Follow the Firebeard's Patrol handoff northwest from Highbank, around 60.2,57.8, and help the Wildhammer families. Complete the offered clan-aid quests, checking Wildhammer Clan reputation in the rewards, and follow the story toward Thundermar. Continue until at least Friendly; you do not need Exalted, the entire zone achievement or the full wedding/daily-quest unlock just to own the tabard.",
        "Find Craw McGraw in Thundermar at 48.6,30.6 on the Twilight Highlands map. Buy Tabard of the Wildhammer Clan (65908) for up to 1 gold, then equip it. If it is red, check your actual Wildhammer standing; if the town is still in a story phase, finish its outstanding main handoff and return.",
    },
    tips = "This is the Alliance tabard; the Horde counterpart is Tabard of the Dragonmaw Clan. The physical tabard champions eligible Cataclysm dungeon reputation after purchase. Old Mists-of-Pandaria and pre-rework Grim Batol farming instructions are not prerequisites for acquiring it.",
    effect = "Champions Wildhammer Clan in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(84, 85.8, 32.4, 2, "Grand Admiral Jes-Tereth - current Twilight Shores starter", "Stormwind City"),
        pin(84, 26.1, 47.2, 2, "Fargo Flintlocke - seaplane at the harbor", "Stormwind City"),
        pin(241, 81.0, 79.4, 3, "Highbank - establish the Alliance foothold", "Twilight Highlands"),
        pin(241, 76.8, 69.8, 3, "Lieutenant Emry - beach-head quest chain", "Twilight Highlands"),
        pin(241, 60.2, 57.8, 4, "Firebeard's Patrol - Wildhammer clan quests", "Twilight Highlands"),
        pin(241, 48.6, 30.6, 5, "Craw McGraw - buy the tabard at Friendly", "Twilight Highlands"),
    },
})

-- /item=65909: 1213309, 1214715, 1245628 and correction threads to
-- 1752961/1962421. /faction=1172 corrects the unnecessary Crucible detour.
-- /quest=26293 and /quest=28717: current Eitrigg starter and modern BfA /
-- heritage phasing corrections, including a May 2026 confirmation.
add(65909, "Tabard of the Dragonmaw Clan", {
    category = "Reputation", faction = "horde", npcId = 49387,
    source = "Grot Deathblow - Bloodgulch, Twilight Highlands; Friendly",
    description = "The Horde Twilight Highlands tabard. Help Zaela's Dragonmaw faction, then purchase it in Bloodgulch rather than Dragonmaw Port.",
    difficulty = "medium", difficultyReason = "Requires the Horde zone introduction, a faction uprising and Friendly reputation; capital-city phasing can add a prerequisite.",
    requirements = "Horde; Friendly with Dragonmaw Clan on the buyer",
    cost = "1 gold base price, before applicable discounts",
    steps = {
        "Use a Horde character and check Dragonmaw Clan reputation. If already Friendly and the Bloodgulch vendor is accessible, skip to step 5. This is the Twilight Highlands faction, not Netherwing in Outland, and the tabard does not unlock Netherwing drakes.",
        "In Orgrimmar, speak to Eitrigg inside Grommash Hold around 49.0,72.8 and begin Machines of War. Follow the preparation quests, including the Azshara fleet/air-force errands, until the chain sends you to Twilight Highlands. Do not wait for the removed original Garrosh version or assume the notice board must display the breadcrumb.",
        "At Dragonmaw Port on the eastern coast, around 75.2,54.8, complete the arrival and uprising story with Zaela, including You Say You Want a Revolution and its follow-ups through Return to the Highlands. The chain establishes friendly Dragonmaw control and the capital portal. Flying straight into the hostile initial port does not complete this unlock.",
        "Follow Zaela's Northern/Southern Flank quests and the subsequent Dragonmaw work toward Bloodgulch, around 54.8,44.0. Continue reputation-awarding Dragonmaw quests until Friendly. You do not need the Crucible of Carnage arena chain to unlock Grot Deathblow; the faction-page replies explicitly correct that older detour.",
        "Find Grot Deathblow at 53.8,42.0 in Bloodgulch, near its flight master. He is inland, not the vendor at Dragonmaw Port. Buy Tabard of the Dragonmaw Clan (65909) for up to 1 gold and equip it. The often-quoted 95-silver price is the Friendly reputation discount on its 1-gold base price.",
    },
    tips = "If Eitrigg has no starter, finish an active BfA/A Dying World introduction and its Heart of Azeroth handoffs, then return; Retail replies through 2026 confirm throne-room phasing can hide the chain. An active Orc heritage introduction can also phase Eitrigg: progress that introduction if it is the conflicting quest. Old MoP reputation-farm claims have later corrections and are not the acquisition route.",
    effect = "Champions Dragonmaw Clan in eligible Cataclysm dungeons while the physical tabard is equipped.",
    waypoints = {
        pin(85, 49.0, 72.8, 2, "Eitrigg - Machines of War inside Grommash Hold", "Orgrimmar"),
        pin(241, 75.2, 54.8, 3, "Dragonmaw Port - Zaela's uprising and portal story", "Twilight Highlands"),
        pin(241, 54.8, 44.0, 4, "Bloodgulch - continue the Dragonmaw quest chain", "Twilight Highlands"),
        pin(241, 53.8, 42.0, 5, "Grot Deathblow - buy the tabard at Friendly", "Twilight Highlands"),
    },
})

-- /item=69209: 1352937 with live-purchase reply 259040, 1400215,
-- 1413750 (purchase vs use standing), 2373631 (what the effect increases).
-- /item=69210: 1400335, 1400732, 2373628, 3296087; expanded 5985059
-- reports both continued Stormwind availability and a Great Seal alternative.
-- /npc=46572: 5991747/reply 1731317 and December 2025 comment 6245859
-- move Goram across from the Trading Post to 47.2,80.0. /npc=46602 places
-- Shay INSIDE the Visitor's Center, not beside the flight-master ramp.
for _, tabard in ipairs({
    { id = 69209, name = "Illustrious Guild Tabard", standing = "Friendly", gold = 125, bonus = 50, difficulty = "easy",
        reason = "A short guild reputation buildup unlocks a guaranteed purchase; an eligible main can supply an alt." },
    { id = 69210, name = "Renowned Guild Tabard", standing = "Honored", gold = 250, bonus = 100, difficulty = "medium",
        reason = "Needs more guild reputation than the Friendly tabard, but can be passed to alts once purchased." },
}) do
    local progression = tabard.id == 69210
        and "At Friendly, you may first buy and equip Illustrious Guild Tabard for 125 gold to increase subsequent guild reputation gains by 50%. Continue reputation-awarding quests until Honored. If a main already owns Renowned Guild Tabard, transfer that physical tabard to this character instead of repeating the purchase grind."
        or "Keep completing quests that actually award Guild reputation until Friendly. If another character in your Warband can already buy this tabard, buy it there and mail the physical item to this character; the recipient does not need Friendly merely to wear an already purchased tabard."
    add(tabard.id, tabard.name, {
        category = "Vendor",
        source = "Guild vendors - " .. tabard.standing .. " guild reputation; transferable within the Warband",
        description = "A guild-crest tabard that increases existing guild reputation gains by " .. tabard.bonus .. "%. Purchase standing applies to the buyer, not an alt receiving it.",
        difficulty = tabard.difficulty, difficultyReason = tabard.reason,
        requirements = tabard.standing .. " reputation with the buyer's guild; recipients can equip an already owned tabard at Neutral",
        cost = tabard.gold .. " gold base price, before applicable discounts",
        steps = {
            "Join a guild on the character making the purchase and open the Guild reputation entry in the reputation panel. You need " .. tabard.standing .. ", not that standing with Stormwind, Orgrimmar or another city. A level-25 guild or a retired guild-level achievement is not required for these tabards.",
            "Earn personal guild reputation by completing reputation-awarding quests while in the guild. Use current-level quest content and check that Guild reputation increases when turning in a quest before committing to a long route. Ordinary solo dungeon trash does not grant guild reputation merely because a guild tabard says champion. Eligible guild-group activities can also award it.",
            progression,
            "Alliance: visit Shay Pressler inside Stormwind's Visitor's Center at 64.6,76.8, the first building on the left after entering from the main gate. Horde: visit Goram at 47.2,80.0 in Orgrimmar's Valley of Strength, across the courtyard from the Trading Post. Goram's old position beside Grommash Hold at 48.4,75.6 is outdated.",
            "Set the shop's class/item filter to All, browse all pages and buy " .. tabard.name .. " (" .. tabard.id .. ") for up to " .. tabard.gold .. " gold. If hidden, verify the buyer's current guild standing and reopen the shop. If this vendor remains affected by a phase/inventory issue, try another capital's guild vendor; do not conclude that the tabard was removed.",
            "Equip the purchased tabard. You can mail the physical Warband-bound item to an alt, including an alt in another guild; it does not appear in every character's bags automatically. Its " .. tabard.bonus .. "% bonus increases existing guild reputation awards, not character experience or reputation with a city. A transmog appearance alone does not supply the bonus.",
        },
        tips = "Old discussions of a weekly 3,500/4,375 guild reputation cap and guild levels describe removed systems. The basic, Illustrious and Renowned guild tabards are separate collectible items despite showing your current guild's crest. If the border appears wrong after equipping, re-equip the tabard; recent Retail replies still report this visual issue.",
        effect = "Increases existing guild reputation gains by " .. tabard.bonus .. "% while physically equipped; displays the wearer's current guild crest.",
        waypoints = {
            pin(84, 64.6, 76.8, 4, "Shay Pressler - inside Stormwind Visitor's Center", "Stormwind City"),
            pin(85, 47.2, 80.0, 4, "Goram - across from the Trading Post", "Orgrimmar"),
            pin(84, 64.6, 76.8, 5, "Alliance - buy " .. tabard.name, "Stormwind City"),
            pin(85, 47.2, 80.0, 5, "Horde - buy " .. tabard.name, "Orgrimmar"),
        },
    })
end
