-- Hand-curated Burning Crusade mount walkthroughs for Retail, reviewed 2026-11-01.
-- Item comments were compared with their relevant replies and current NPC,
-- quest, vendor and recipe records. Source receipts accompany each route.
-- The profit matches on the rare-drop/Engineering pages are obsolete solo
-- tactics or gold discussion, not current numbered acquisition walkthroughs.
-- These are original, Retail-adapted steps; no closing profit step is included.
-- Only obtainable Retail mounts are registered. Automatic class unlocks
-- deliberately have no invented acquisition pins.
local _, TDP = ...
TDP.CollectionWalkthroughs = TDP.CollectionWalkthroughs or {}
TDP.CollectionWalkthroughs.mounts = TDP.CollectionWalkthroughs.mounts or {}
local guides = TDP.CollectionWalkthroughs.mounts

local function pin(mapID, x, y, step, label, mapName)
    return { mapID = mapID, x = x / 100, y = y / 100, step = step, label = label, mapName = mapName }
end

local function addMount(spellID, name, itemID, guide)
    local lines = {}
    for step, text in ipairs(guide.steps) do
        lines[#lines + 1] = step .. ". " .. text
    end
    guide.name, guide.itemId = name, itemID
    guide.acquisition, guide.stepCount = table.concat(lines, "\n\n"), #lines
    guide.steps = nil
    guide.waypoints = guide.waypoints or {}
    guide.wowheadUrl = "https://www.wowhead.com/" .. (itemID and ("item=" .. itemID) or ("spell=" .. spellID))
    guides[spellID] = guide
end

-- Retail availability reviewed 2026-11-04 against the current source lists:
-- https://www.warcraftmounts.com/retired.php
-- https://www.warcraftmounts.com/pvp.php
-- https://www.warcraftmounts.com/crafted.php
-- https://news.blizzard.com/en-us/article/23523203/burning-crusade-mounts-pets-and-more
-- The four original seasonal Nether Drakes and Amani War Bear were already
-- absent from the catalogue. Ordinary PvP vendors and Halaa remain available.
-- Rate the complete acquisition effort for a current max-level character,
-- including currency, repetition and lockouts. Preserve any existing rating.
local function rate(level, reason, spellIDs)
    for _, spellID in ipairs(spellIDs) do
        local guide = guides[spellID]
        if guide and not guide.difficulty then
            guide.difficulty, guide.difficultyReason = level, reason
            guide.acquisition = "Difficulty: " .. level:gsub("^%l", string.upper) .. " - " .. reason .. "\n\n" .. guide.acquisition
        end
    end
end

-- Every color's item comments were considered separately. The current vendor
-- records supersede the old 800/5000-gold flight-training and level-70 advice.
-- https://www.wowhead.com/item=25529#comments:id=3261001
-- https://www.wowhead.com/item=25473#comments:id=721421
-- https://www.wowhead.com/npc=43768/tannec-stonebeak
-- https://www.wowhead.com/npc=44918/drakma
local flyingVendors = {
    { 32235, "Golden Gryphon", 25470, "alliance", 50 },
    { 32239, "Ebon Gryphon", 25471, "alliance", 50 },
    { 32240, "Snowy Gryphon", 25472, "alliance", 50 },
    { 32242, "Swift Blue Gryphon", 25473, "alliance", 100 },
    { 32289, "Swift Red Gryphon", 25527, "alliance", 100 },
    { 32290, "Swift Green Gryphon", 25528, "alliance", 100 },
    { 32292, "Swift Purple Gryphon", 25529, "alliance", 100 },
    { 32243, "Tawny Wind Rider", 25474, "horde", 50 },
    { 32244, "Blue Wind Rider", 25475, "horde", 50 },
    { 32245, "Green Wind Rider", 25476, "horde", 50 },
    { 32246, "Swift Red Wind Rider", 25477, "horde", 100 },
    { 32295, "Swift Green Wind Rider", 25531, "horde", 100 },
    { 32296, "Swift Yellow Wind Rider", 25532, "horde", 100 },
    { 32297, "Swift Purple Wind Rider", 25533, "horde", 100 },
}
for _, mount in ipairs(flyingVendors) do
    local spellID, name, itemID, faction, price = unpack(mount)
    local alliance = faction == "alliance"
    local vendor = alliance and "Tannec Stonebeak" or "Drakma"
    local destination = alliance and "Stormwind City, beside the gryphons at 71.5, 72.3. Take the ramp up from the Trade District to the flight-master platform"
        or "Orgrimmar, on the upper flight-master platform at 48.0, 58.5. Use a lift or fly up to the roof above the Valley of Strength"
    addMount(spellID, name, itemID, {
        steps = {
            "Log onto an " .. (alliance and "Alliance" or "Horde") .. " character with Apprentice Riding and search Collections > Mounts for " .. name .. ". Check uncollected mounts before buying: an account unlock or a faction counterpart may already have supplied this appearance.",
            "Visit " .. vendor .. " in " .. destination .. ". Speak to the mount vendor, rather than the nearby flight master who sells taxi rides.",
            "Buy the exact item " .. name .. " (" .. itemID .. "). Its base price is " .. price .. " gold before any applicable vendor discount. There is no racial Exalted-reputation grind for these flying-mount colors.",
            "Use the item from your bags, then search for " .. name .. " in Collections > Mounts and summon it outdoors. Its movement speed follows your current riding skill; buying a Swift color does not purchase flight training.",
        },
        source = vendor .. (alliance and " - Stormwind City" or " - Orgrimmar"),
        category = "Vendor", faction = faction,
        npcId = alliance and 43768 or 44918,
        cost = price .. " gold base; applicable vendor discounts reduce the price.",
        requirements = (alliance and "Alliance" or "Horde") .. "; Apprentice Riding to learn the item. Flying also requires the appropriate riding unlock and a flyable area.",
        tips = "The old comments describe earlier expansion training costs and fixed mount speeds. Use the current item tooltip and your character's riding skills. All seven colors from this vendor are separate collection entries.",
        waypoints = { pin(alliance and 84 or 85, alliance and 71.5 or 48.0, alliance and 72.3 or 58.5, 2, vendor .. " - mount vendor on flight-master platform") },
    })
end

-- https://www.wowhead.com/item=28936#comments:id=2575605
-- https://www.wowhead.com/item=29221#comments:id=3149254
-- https://www.wowhead.com/npc=254366#comments:id=6384640
-- https://www.wowhead.com/npc=240940/magistrix-nizara
-- https://www.wowhead.com/faction=911/silvermoon-city (Botanica corrections)
-- Use the current Silvermoon vendor, not an obsolete route to Thuron's Livery.
for _, mount in ipairs({
    { 33660, "Swift Pink Hawkstrider", 28936, 10 },
    { 34795, "Red Hawkstrider", 28927, 1 },
    { 35018, "Purple Hawkstrider", 29222, 1 },
    { 35020, "Blue Hawkstrider", 29220, 1 },
    { 35022, "Black Hawkstrider", 29221, 1 },
    { 35025, "Swift Green Hawkstrider", 29223, 10 },
    { 35027, "Swift Purple Hawkstrider", 29224, 10 },
}) do
    local spellID, name, itemID, price = unpack(mount)
    addMount(spellID, name, itemID, {
        steps = {
            "Use a Horde character with Apprentice Riding. A Blood Elf is the simplest purchase route because the original racial vendor does not require that race to grind Silvermoon City reputation. Check your Mount Journal for " .. name .. " first.",
            "Visit Winaestra in current Silvermoon City at 67.2, 66.0, west of The Royal Exchange flight point. Check whether she will sell you the mount now. If eligible, skip the optional reputation route in steps 3-4.",
            "If the vendor refuses a non-Blood-Elf character because of reputation, buy Silvermoon City Tabard from Magistrix Nizara in the same city at 69.0, 67.5, and EQUIP it. This is the old Silvermoon City reputation, not Midnight's Silvermoon Court renown.",
            "With that tabard equipped, enter The Botanica in Netherstorm at 71.5, 55.5 on Normal difficulty. Kill the trash and all five bosses, use the exit behind Warp Splinter, reset outside and repeat until Silvermoon City is Exalted. Check that kills award Silvermoon City reputation. Pause if you reach the hourly instance limit.",
            "Return to Winaestra at 67.2, 66.0 in current Silvermoon. Buy " .. name .. " (" .. itemID .. ") for " .. price .. " gold base, less any applicable discount. Buy the specific color; learning another hawkstrider does not unlock this one.",
            "Use the purchased item in your bags and find " .. name .. " in Collections > Mounts. This remains a Horde racial appearance; learning it does not let an Alliance character summon it.",
        },
        source = "Winaestra - current Silvermoon City, west of The Royal Exchange",
        category = "Vendor", faction = "horde", npcId = 254366,
        requirements = "Horde; Apprentice Riding. Blood Elf or the vendor's Silvermoon City reputation eligibility.",
        cost = price .. " gold base; applicable reputation discounts reduce the price.",
        tips = "Try the vendor before farming reputation. Steps 3-4 are only needed if she refuses the purchase. The mapped Silvermoon City is #2393; the old city's coordinates refer to a different map. Allied races do not automatically inherit the original Blood Elf racial exemption.",
        waypoints = {
            pin(2393, 67.2, 66.0, 2, "Winaestra - check purchase eligibility", "Silvermoon City (current)"),
            pin(2393, 69.0, 67.5, 3, "Magistrix Nizara - optional Silvermoon City Tabard", "Silvermoon City (current)"),
            pin(109, 71.5, 55.5, 4, "The Botanica - optional Normal reputation runs"),
            pin(2393, 67.2, 66.0, 5, "Winaestra - buy the selected hawkstrider", "Silvermoon City (current)"),
        },
    })
end

-- https://www.wowhead.com/item=29745#comments:id=5747160 and reply
-- https://www.wowhead.com/npc=17584#comments:id=5322367 and replies
-- https://www.wowhead.com/npc=17584#comments:id=5925312 and reply
-- https://www.wowhead.com/npc=50306/kadu
for _, mount in ipairs({
    { 34406, "Brown Elekk", 28481, 1 },
    { 35710, "Gray Elekk", 29744, 1 },
    { 35711, "Purple Elekk", 29743, 1 },
    { 35712, "Great Green Elekk", 29746, 10 },
    { 35713, "Great Blue Elekk", 29745, 10 },
    { 35714, "Great Purple Elekk", 29747, 10 },
}) do
    local spellID, name, itemID, price = unpack(mount)
    addMount(spellID, name, itemID, {
        steps = {
            "Use an Alliance character with Apprentice Riding. A regular Draenei can buy these racial mounts without an Exodar reputation grind. Lightforged Draenei are a separate race and do not receive that exemption. If available, use a regular Draenei to make the purchase.",
            "Find Torallius the Pack Handler OUTSIDE The Exodar at 81.5, 52.0 on Azuremyst Isle. From inside the city, leave through the main entrance and turn left toward the elekks. If he will sell to you, skip steps 3-4.",
            "For a non-Draenei character refused by the vendor, go inside The Exodar and buy Exodar Tabard from Kadu beside the flight master at 54.6, 36.8 on the city map. Equip the tabard; keeping it in your bags gives no dungeon reputation.",
            "Enter Normal Botanica in Netherstorm at 71.5, 55.5 with Exodar Tabard equipped. Clear trash and all five bosses, leave by the exit behind Warp Splinter, reset outside and repeat until Exodar is Exalted. Check that the reputation messages name Exodar and pause at the hourly instance limit.",
            "Return to Torallius outside The Exodar on Azuremyst Isle. Buy " .. name .. " (" .. itemID .. "). The base price is " .. price .. " gold before reputation discounts. Check the name: the Great colors and ordinary colors are separate mounts.",
            "Use the item from your bags to learn " .. name .. ". It becomes available to eligible Alliance characters through Collections > Mounts; the appearance remains faction restricted.",
        },
        source = "Torallius the Pack Handler - outside The Exodar, Azuremyst Isle",
        category = "Vendor", faction = "alliance", npcId = 17584,
        requirements = "Alliance; Apprentice Riding; regular Draenei or Exodar Exalted.",
        cost = price .. " gold base; reputation discount applies.",
        tips = "Torallius is outside; Kadu is inside. Their pins intentionally use different maps. The old runecloth turn-ins and level-40/60 training prices in the comments are obsolete. A regular Draenei can collect all six colors without doing the tabard route.",
        waypoints = {
            pin(97, 81.5, 52.0, 2, "Torallius - check eligibility outside The Exodar"),
            pin(103, 54.6, 36.8, 3, "Kadu - optional Exodar Tabard"),
            pin(109, 71.5, 55.5, 4, "The Botanica - optional Normal reputation runs"),
            pin(97, 81.5, 52.0, 5, "Torallius - buy the selected elekk"),
        },
    })
end

-- https://www.wowhead.com/spell=34767#comments:id=3267758
-- https://www.wowhead.com/spell=34769#comments:id=3267757
-- The long Blood Knight material/Stratholme quests in old comments are not
-- Retail mount requirements. An automatically learned mount has no vendor pin.
for _, mount in ipairs({
    { 34767, "Thalassian Charger" },
    { 34769, "Thalassian Warhorse" },
}) do
    local spellID, name = unpack(mount)
    addMount(spellID, name, nil, {
        steps = {
            "Create or log onto a Blood Elf Paladin. Reach level 10; this racial Paladin mount is an automatic class unlock in Retail.",
            "Open Collections > Mounts and search for " .. name .. ". Clear collection filters if it is hidden, then drag its summon icon onto an action bar or select Summon in the journal.",
            "Summon the mount outdoors on the Blood Elf Paladin. This class-and-race unlock is separate from buying a hawkstrider or completing the Blood Knight tabard quests. The old runecloth, arcanite, gold and Stratholme mount chain is not required.",
        },
        source = "Automatic level-10 Blood Elf Paladin class mount",
        category = "Class", faction = "horde", cost = "No mount purchase or quest materials.",
        requirements = "Blood Elf Paladin, level 10.",
        tips = "These are two separate mount appearances. Owning one on the account does not make it summonable by other classes or races. No travel is needed for the unlock, so there is no acquisition map destination.",
    })
end

-- https://www.wowhead.com/item=34129#comments:id=2028053
-- https://www.wowhead.com/item=35906#comments:id=2028066
-- Current sold-by tables: both cost 15 of item 137642, not Honor currency.
-- https://www.wowhead.com/npc=12796/raider-bork
-- https://www.wowhead.com/npc=12783/lieutenant-karter
for _, mount in ipairs({
    { 35028, "Swift Warstrider", 34129, "horde" },
    { 48027, "Black War Elekk", 35906, "alliance" },
}) do
    local spellID, name, itemID, faction = unpack(mount)
    local alliance = faction == "alliance"
    local vendor = alliance and "Lieutenant Karter" or "Raider Bork"
    addMount(spellID, name, itemID, {
        steps = {
            "Use an " .. (alliance and "Alliance" or "Horde") .. " character with Apprentice Riding. Search for " .. name .. " in Collections > Mounts first; the opposite-faction equivalent may already have unlocked its counterpart.",
            "Collect 15 Marks of Honor (item 137642), the physical legacy-PvP tokens awarded from eligible PvP reward containers. Transfer any spare Warband-bound Marks from your other characters. Honor points shown in the currency pane are a different resource.",
            "Visit " .. vendor .. (alliance and " in Stormwind's Old Town at 76.4, 65.4, outside the Champion's Hall" or " in Orgrimmar at 41.7, 72.6, near the Hall of Legends") .. ". Open the mount vendor's shop and find " .. name .. ". No racial Exalted reputation or Gladiator rating is required.",
            "Buy " .. (alliance and "Reins of the Black War Elekk" or "Swift Warstrider") .. " for 15 Marks of Honor, then use the item from your bags. Check Collections > Mounts to confirm that " .. name .. " is learned.",
        },
        source = vendor .. (alliance and " - Stormwind, Old Town" or " - Orgrimmar, Hall of Legends"),
        category = "PvP", faction = faction, npcId = alliance and 12783 or 12796,
        cost = "15 Marks of Honor (item 137642).",
        requirements = (alliance and "Alliance" or "Horde") .. "; Apprentice Riding; 15 Marks of Honor. No rating or racial reputation requirement.",
        tips = "Old comments quote battleground-specific marks, 50,000 Honor or 2,000 Honor. Those are previous prices. The Black War Elekk is the Alliance elekk from Karter; the Horde hawkstrider from Bork is Swift Warstrider.",
        waypoints = { pin(alliance and 84 or 85, alliance and 76.4 or 41.7, alliance and 65.4 or 72.6, 3, vendor .. " - 15 Marks of Honor") },
    })
end

-- Both factions' item pages were reviewed, including the distinct Alliance
-- item IDs. Same spell/appearance; separate faction quartermasters and beads.
-- https://www.wowhead.com/item=29102#comments:id=321321 and replies
-- https://www.wowhead.com/item=29231#comments:id=982470
-- https://www.wowhead.com/item=31830#comments:id=632658
-- https://www.wowhead.com/npc=18407/warden-bullrok
-- https://www.wowhead.com/npc=18408/warden-moibff-jill
for _, mount in ipairs({
    { 34896, "Cobalt War Talbuk", 29102, 29227, 80 },
    { 34897, "White War Talbuk", 29103, 29231, 80 },
    { 34898, "Silver War Talbuk", 29104, 29229, 80 },
    { 34899, "Tan War Talbuk", 29105, 29230, 80 },
    { 39315, "Cobalt Riding Talbuk", 31829, 31830, 56 },
    { 39317, "Silver Riding Talbuk", 31831, 31832, 56 },
    { 39318, "Tan Riding Talbuk", 31833, 31834, 56 },
    { 39319, "White Riding Talbuk", 31835, 31836, 56 },
}) do
    local spellID, name, hordeItemID, allianceItemID, price = unpack(mount)
    addMount(spellID, name, hordeItemID, {
        steps = {
            "Go to Nagrand in OUTLAND. Alliance earns Kurenai reputation and buys from Trader Narasu in Telaar; Horde earns The Mag'har reputation and buys from Provisioner Nasela in Garadar. These are the original Outland reputations, not the Mag'har allied race or Draenor's Nagrand factions.",
            "Start killing Warmaul ogres in Laughing Skull Ruins around 46.0, 23.0. Loot every corpse for Obsidian Warbeads (25433). The kills themselves award your faction reputation, including while working toward Neutral; you do not have to wait for daily quests.",
            "If Laughing Skull is crowded, move to the ogres at Warmaul Hill around 29.0, 26.0 and its caves. Keep all Obsidian Warbeads. Outland faction quests are optional extra reputation, but the repeatable ogre-and-bead route can finish the grind.",
            "Once your faction will speak to you, take a stack of 10 Obsidian Warbeads to Warden Moi'bff Jill at 54.8, 70.8 in Telaar (Alliance) or Warden Bullrok at 55.8, 37.8 in Garadar (Horde). Complete Fierce Enemies, then the repeatable More Warbeads! turn-in.",
            "Repeat the ogre kills and 10-bead hand-ins until Kurenai or The Mag'har is Exalted. A normal hand-in awards 500 reputation before bonuses, and it is repeatable without a daily limit. Hand the beads to your faction warden, not The Consortium, if your goal is these mounts.",
            "At Exalted, visit Trader Narasu at 54.5, 75.1 in Telaar (Alliance) or Provisioner Nasela at 53.5, 36.9 in Garadar (Horde). Buy Reins of the " .. name .. ". Its normal Exalted price is " .. price .. " gold; the faction item IDs are " .. allianceItemID .. " (Alliance) and " .. hordeItemID .. " (Horde).",
            "Use the reins from your bags. You may buy every other missing talbuk color from the same vendor after this one reputation grind; the first purchase does not consume or reset your reputation.",
        },
        source = "Trader Narasu (Kurenai) / Provisioner Nasela (The Mag'har) - Outland Nagrand",
        category = "Reputation", faction = "all",
        requirements = "Kurenai Exalted on Alliance or The Mag'har Exalted on Horde; Apprentice Riding.",
        cost = price .. " gold at Exalted before any additional discounts.",
        tips = "Riding and War talbuks are separate unarmored and armored collection entries. They scale with riding skill; the War version does not buy a speed upgrade. Save any Oshu'gun Crystal Powder Samples found during the grind if you also want the two Halaa talbuks.",
        sourceUrls = { "https://www.wowhead.com/item=" .. allianceItemID, "https://www.wowhead.com/item=" .. hordeItemID },
        waypoints = {
            pin(107, 46.0, 23.0, 2, "Laughing Skull Ruins - ogres and Obsidian Warbeads"),
            pin(107, 29.0, 26.0, 3, "Warmaul Hill - alternative ogre farming area"),
            pin(107, 54.8, 70.8, 4, "Alliance: Warden Moi'bff Jill - 10-bead turn-ins"),
            pin(107, 55.8, 37.8, 4, "Horde: Warden Bullrok - 10-bead turn-ins"),
            pin(107, 54.5, 75.1, 6, "Alliance: Trader Narasu - Exalted mount vendor"),
            pin(107, 53.5, 36.9, 6, "Horde: Provisioner Nasela - Exalted mount vendor"),
        },
    })
end

-- https://www.wowhead.com/item=29228#comments:id=1667780 and all replies:
-- the later garrison reply supersedes the old mandatory-PvP route.
-- https://www.wowhead.com/item=29228#comments:id=5957724
-- https://www.wowhead.com/item=28915#comments:id=1820755
-- https://www.wowhead.com/mission=332/mysteries-of-lok-rath
-- https://www.wowhead.com/npc=21474/coreiel
-- https://www.wowhead.com/npc=21485/aldraan
for _, mount in ipairs({
    { 34790, "Dark War Talbuk", 29228, 100, 20 },
    { 39316, "Dark Riding Talbuk", 28915, 70, 15 },
}) do
    local spellID, name, itemID, battle, research = unpack(mount)
    addMount(spellID, name, itemID, {
        steps = {
            "Choose how to collect " .. battle .. " Halaa Battle Tokens and " .. research .. " Halaa Research Tokens for " .. name .. ". No Kurenai or Mag'har Exalted reputation is required. If collecting both dark talbuks, budget 170 Battle and 35 Research Tokens in total.",
            "For the route without token farming in PvP, use your Draenor Garrison Hearthstone and check the follower Command Table in your Town Hall: Lunarfall for Alliance or Frostwall for Horde. Look for the rare mission Mysteries of Lok-rath (332). Level and equip your Draenor followers through ordinary missions while checking back; the rare mission is random and can take a long time to appear.",
            "When Mysteries of Lok-rath appears, assign a follower who counters Minion Swarms and improve the success chance before sending them. It costs 10 Garrison Resources and takes 1 hour. Collect the completed reward at the table: 100 Battle and 40 Research Tokens. One success buys either mount; both require a second mission or another source of Battle Tokens.",
            "If you prefer the original farming alternative, earn Battle Tokens from eligible opposing-faction player kills INSIDE Halaa in Outland Nagrand. Bombing guards does not award Battle Tokens. For Research Tokens, kill Nagrand enemies for Oshu'gun Crystal Powder Samples; Sunspring Post around 33.0, 46.0 is one farming area. Exchange 10 samples per Research Token with your faction's researcher in Halaa. Skip this step if the mission supplied all your tokens.",
            "Bring your tokens to Halaa in OUTLAND Nagrand around 42.8, 42.5. This is not Lok-rath in Draenor. Your faction must control Halaa for its vendor to be available. If the other faction controls it, defeat its Halaani guards, then stand by the central capture flag until the capture bar finishes and your NPCs appear.",
            "At the northeastern part of Halaa, speak to Aldraan if Alliance controls the town or Coreiel if Horde controls it. Check the vendor's mount items, including later shop pages. Buy Reins of the " .. name .. " for " .. battle .. " Battle Tokens plus " .. research .. " Research Tokens.",
            "Use the reins from your bags. Both factions can collect and use the dark talbuk appearance. Keep leftover tokens if you still need the other version; buying the cheaper Riding mount does not also unlock the armored War mount.",
        },
        source = "Aldraan / Coreiel - faction-controlled Halaa, Outland Nagrand",
        category = "PvP", faction = "all",
        requirements = "Apprentice Riding; enough Halaa tokens; your faction must control Halaa. Garrison mission route requires an established Draenor follower table.",
        cost = battle .. " Halaa Battle Tokens + " .. research .. " Halaa Research Tokens.",
        tips = "The garrison mission is an alternative token source, not a guaranteed daily quest. Modern reports still confirm it; old level-98 follower requirements predate the level squish. Do not follow old Hellfire/Sulfuron suicide tricks. Research powder has a carrying limit, so exchange it before continuing to farm.",
        waypoints = {
            pin(582, 29.2, 34.5, 2, "Alliance: Lunarfall Town Hall - follower table; position varies by garrison level"),
            pin(590, 40.0, 54.4, 2, "Horde: Frostwall Town Hall - follower table; position varies by garrison level"),
            pin(107, 33.0, 46.0, 4, "Optional: Sunspring Post - Crystal Powder farming"),
            pin(107, 42.8, 42.5, 4, "Halaa - optional PvP tokens and powder exchanges"),
            pin(107, 42.8, 42.5, 5, "Halaa - capture the town if necessary"),
            pin(107, 42.8, 42.5, 6, "Aldraan / Coreiel - buy the selected dark talbuk"),
        },
    })
end

-- https://www.wowhead.com/item=32319#comments:id=2016343 and both replies
-- https://www.wowhead.com/item=32314#comments:id=2016342
-- https://www.wowhead.com/quest=11021/ishaal-s-almanac
-- https://www.wowhead.com/quest=11024/an-ally-in-lower-city
-- https://www.wowhead.com/quest=11056#comments:id=87793
-- https://www.wowhead.com/quest=11029#comments:id=89109
-- https://www.wowhead.com/quest=11885/adversarial-blood
-- https://www.wowhead.com/quest=11074/tokens-of-the-descendants
for _, mount in ipairs({
    { 39798, "Green Riding Nether Ray", 32314 },
    { 39800, "Red Riding Nether Ray", 32317 },
    { 39801, "Purple Riding Nether Ray", 32316 },
    { 39802, "Silver Riding Nether Ray", 32318 },
    { 39803, "Blue Riding Nether Ray", 32319 },
}) do
    local spellID, name, itemID = unpack(mount)
    addMount(spellID, name, itemID, {
        steps = {
            "Begin with Yuula beside Shattrath's flight master around 64.0, 42.0. Complete Threat from Above by killing 20 Gordunni ogres in the Barrier Hills north of the city, around 22.0, 12.0 on the Terokkar Forest map. Return to Yuula, then follow To Skettis to Sky Commander Adaris at Blackwind Landing, 64.0, 66.8. If already Exalted with Sha'tari Skyguard, skip to step 10.",
            "At Blackwind Landing, take World of Shadows from Severin. Kill Skettis arakkoa and collect 6 Shadow Dust, then return to Severin at 64.0, 66.8 for Elixir of Shadows. Keep the elixir buff active to see the otherwise hidden time-lost arakkoa.",
            "While clearing Skettis, kill Talonpriest Ishaal around 69.3, 78.5 and loot Ishaal's Almanac. Use the item to start its quest and take it to Adaris at Blackwind Landing. Continue with An Ally in Lower City.",
            "Take the almanac to Rilak the Redeemed in Shattrath's Lower City at 52.6, 20.8. Accept Countdown to Doom and return to Adaris. This unlock chain is needed for Hazzik's summoning quests; simply grinding ordinary birds does not complete it.",
            "Speak to Hazzik beside Adaris at 64.2, 66.8. For Hazzik's Bargain, retrieve the small package inside the ground-level hut in UPPER Veil Shil'ak at 74.8, 80.2, then return to Hazzik. Do not search the similarly named lower settlement or the platforms in the trees.",
            "Accept A Shabby Disguise. Use the supplied disguise on the central island, enter Sahaak's hut around 67.0, 79.0, and buy Adversarial Bloodlines for 3 gold. Bring the book to Hazzik and accept Adversarial Blood.",
            "Keep Elixir of Shadows active and kill time-lost arakkoa for Time-Lost Scrolls. Gather 40 scrolls for a complete four-descendant cycle. At a small Skull Pile, for example 69.6, 74.6, spend 10 scrolls per summon and kill each DIFFERENT descendant once: Darkscreecher Akkarai, Karrog, Gezzarak the Huntress and Vakkiz the Windrager. Loot and keep their four distinct token items.",
            "Turn in Adversarial Blood to Hazzik for your first Time-Lost Offering. For later Offerings, use Tokens of the Descendants to trade one of each descendant token to Hazzik. Take Terokk's Downfall from Adaris. On Terokk's Rest island at 66.2, 77.5, use the large Skull Pile with an Offering in your bags to summon and defeat Terokk, then turn in the quest.",
            "Continue earning reputation until Sha'tari Skyguard is Exalted. Kill arakkoa and the large treants while collecting dust and scrolls, repeat the four-descendant token exchange and Terokk summons, and refresh Elixir of Shadows. Terokk's pile normally returns about 15 minutes after a kill; farm elsewhere while waiting. If he shields, bring him into the blue fire from the Skyguard bombing run. You can buy tradable scrolls/offerings on the Auction House to shorten gathering.",
            "At Exalted, return to Grella at Blackwind Landing, 64.2, 66.2 in Terokkar Forest. Buy " .. name .. " for the normal Exalted price of 160 gold and use the item from your bags. The same reputation unlocks all five colors; buy the missing colors separately.",
        },
        source = "Grella - Blackwind Landing, Terokkar Forest; Sha'tari Skyguard Exalted",
        category = "Reputation", faction = "all", npcId = 23367,
        requirements = "Sha'tari Skyguard Exalted; Apprentice Riding. Flying helps reach the Skettis plateau and platforms.",
        cost = "160 gold at Exalted (200 gold base); 3 gold for the unlock-chain book. Optional Auction House reagents cost extra.",
        tips = "Use the small Skull Piles for the four descendants and the large island pile for Terokk. Keep one of each descendant's token, not four copies of the same one. Ordinary small birds stop giving reputation before Exalted. Daily bombing/escort quests are optional extra reputation; the repeatable summoning route avoids waiting for daily resets.",
        waypoints = {
            pin(111, 64.0, 42.0, 1, "Yuula - Threat from Above"),
            pin(108, 22.0, 12.0, 1, "Barrier Hills - kill 20 Gordunni ogres"),
            pin(108, 64.0, 66.8, 1, "Blackwind Landing - Adaris and Severin"),
            pin(108, 64.0, 66.8, 2, "Severin - Shadow Dust and Elixir of Shadows"),
            pin(108, 69.3, 78.5, 3, "Talonpriest Ishaal - loot the Almanac"),
            pin(108, 64.0, 66.8, 3, "Adaris - turn in Ishaal's Almanac"),
            pin(111, 52.6, 20.8, 4, "Rilak the Redeemed - almanac translation"),
            pin(108, 64.0, 66.8, 4, "Adaris - return with Countdown to Doom"),
            pin(108, 64.2, 66.8, 5, "Hazzik - unlock quests and descendant exchanges"),
            pin(108, 74.8, 80.2, 5, "Upper Veil Shil'ak - Hazzik's Package in a hut"),
            pin(108, 67.0, 79.0, 6, "Sahaak - buy Adversarial Bloodlines while disguised"),
            pin(108, 69.6, 74.6, 7, "Small Skull Pile - four different descendant summons"),
            pin(108, 64.2, 66.8, 8, "Hazzik - exchange four tokens for an Offering"),
            pin(108, 66.2, 77.5, 8, "Terokk's Rest - large Skull Pile"),
            pin(108, 66.2, 77.5, 9, "Repeat Terokk summons between reputation farming"),
            pin(108, 64.2, 66.2, 10, "Grella - buy the selected nether ray at Exalted"),
        },
    })
end

-- https://www.wowhead.com/item=32857#comments:id=419993 (numbered unlock chain)
-- https://www.wowhead.com/item=32857#comments:id=74097 and all ten replies
-- https://www.wowhead.com/item=32861#comments:id=95747 and replies
-- https://www.wowhead.com/item=32860#comments:id=6258804 (2026 event advice)
-- https://www.wowhead.com/item=32858#comments:id=3203261
-- https://www.wowhead.com/item=32859#comments:id=3373722
-- https://www.wowhead.com/npc=22113/mordenai
-- https://www.wowhead.com/quest=10837/to-netherwing-ledge
-- https://www.wowhead.com/quest=10854/the-force-of-neltharaku
-- The 2026 egg-count formula includes reputation from the Exalted-only finale.
-- Do not promise its 32/46-egg totals as a way to reach Exalted beforehand.
for _, mount in ipairs({
    { 41513, "Onyx Netherwing Drake", 32857, "Onyxien" },
    { 41514, "Azure Netherwing Drake", 32858, "Suraku" },
    { 41515, "Cobalt Netherwing Drake", 32859, "Jorus" },
    { 41516, "Purple Netherwing Drake", 32860, "Malfas" },
    { 41517, "Veridian Netherwing Drake", 32861, "Zoya" },
    { 41518, "Violet Netherwing Drake", 32862, "Voranaku" },
}) do
    local spellID, name, itemID, drake = unpack(mount)
    addMount(spellID, name, itemID, {
        steps = {
            "Travel to Shadowmoon Valley in OUTLAND on a character able to fly. Enable Trivial Quests tracking and find Mordenai walking through Netherwing Fields around 60.0, 59.0; he may be fighting flayers, so use /targetexact Mordenai and look on the ground. For Kindness, kill Rocknail Flayers, combine their giblets into carcasses and feed 8 Mature Netherwing Drakes. If already Exalted, skip to step 10.",
            "Complete Seek Out Neltharaku, then Neltharaku's Tale. Neltharaku is a large dragon FLYING HIGH above the fields, patrolling roughly 58-70, 54-64. His map pin is a search point, not a stationary ground spawn. Follow his Infiltrating Dragonmaw Fortress quest and kill the required Dragonmaw orcs at the fortress around 69.0, 61.0.",
            "For To Netherwing Ledge!, fly to the island south of the mainland and collect 12 Nethervine Crystals from the quest sources there. Return to Neltharaku. For The Force of Neltharaku, use his enchanted crystal on enslaved Netherwing drakes at Dragonmaw Fortress, then help the freed drakes defeat their captors. Do not kill the drakes you are trying to rescue.",
            "Accept Karynaku and speak to the chained dragon on the fortress platform at 69.8, 61.5. Take Zuluhed the Whacked, defeat Zuluhed, loot his key and use it on Karynaku's chains. Complete her follow-up and Ally of the Netherwing with Mordenai. This finishes the introductory chain and provides the large reputation award.",
            "Continue Mordenai's Blood Oath of the Netherwing and In Service of the Illidari to Dragonmaw Base Camp on Netherwing Ledge. Let the Dragonmaw disguise apply, then speak to Overlord Mor'ghor at 66.2, 85.6 and Taskmaster Varkule Dragonbreath at 66.0, 86.4. These friendly quest NPCs are part of the disguise, for both Alliance and Horde.",
            "Speak to Yarzill the Merc at 66.0, 86.5 and complete Your Friend on the Inside. Find a Netherwing Egg and complete The Great Netherwing Egg Hunt; later eggs use Accepting All Eggs. The first hand-in normally gives 350 reputation and subsequent eggs 250 before bonuses. Egg hand-ins are repeatable without a daily cap.",
            "Search the ledge, floating rock shelves and Dragonmaw Fortress for lootable eggs. Also enter the Netherwing Mines at 65.3, 90.0: check corners and side passages for ground eggs and loot Nethermine Flayers, Ravagers and other lootable enemies for random egg drops. Murkblood Miners do not provide loot. Ground eggs are not available before the introductory unlock; do not spend hours searching for them on a character still before Ally of the Netherwing.",
            "Take the available dailies at the base camp and mine entrance while gathering eggs. For Netherwing Crystals, collect 30 crystals from ledge/mine enemies. At Friendly, mine quests include collecting 15 Nethermine Cargo and killing 15 Nethermine Flayers plus 5 Ravagers. These share the egg-farming area, so collect their objectives in the same run and return to the quest givers when complete.",
            "At each new reputation rank, return to the camp for promotion quests such as Rise, Overseer!, Stand Tall, Captain! and Hail, Commander! Keep repeating eggs and available dailies until Netherwing is Exalted. If a Burning Crusade Timewalking reputation bonus or another applicable reputation buff is active, use it for the introductory award and egg hand-ins; do not rely on another player's fixed egg count or completion time.",
            "At Exalted, take Bow to the Highlord from Taskmaster Varkule Dragonbreath at 66.0, 86.4, then Lord Illidan Stormrage from Overlord Mor'ghor at 66.2, 85.6. Stay for the event and Yarzill's rescue flight to Shattrath; allow the sequence to finish rather than flying to Shattrath before accepting the quests.",
            "Turn in to Barthamus in Shattrath's Lower City at 66.5, 16.8. Speak to " .. drake .. " among the drakes beside him and complete that drake's quest for your free " .. name .. ". Only the first chosen color is free. If you already chose a different drake, use step 12 instead.",
            "For additional colors, return to Drake Dealer Hurlunk on Netherwing Ledge at 65.6, 86.0 while Exalted on this character. Buy Reins of the " .. name .. " for 200 gold if it is still missing, then use the reins. You can keep and learn all six colors; purchasing a second does not replace the first.",
        },
        source = "Netherwing Exalted: first drake quest in Shattrath; additional colors from Drake Dealer Hurlunk",
        category = "Reputation", faction = "all", npcId = 23489,
        requirements = "Netherwing Exalted on the purchasing character; introductory Netherwing quest chain and flight access.",
        cost = "One color free from the Exalted finale; 200 gold for each additional color.",
        tips = "The map uses Outland Shadowmoon Valley (#104), not Draenor's zone. Netherwing is separate from Sha'tari Skyguard. Enable Trivial Quests, check your quest log for an abandoned chain step if Mordenai has nothing, and let the disguise reapply after leaving/re-entering the ledge. The Purple color also counts toward Awake the Drakes.",
        waypoints = {
            pin(104, 60.0, 59.0, 1, "Mordenai - walking search area / Kindness", "Shadowmoon Valley (Outland)"),
            pin(104, 61.8, 60.0, 2, "Neltharaku - high-altitude patrol search point", "Shadowmoon Valley (Outland)"),
            pin(104, 69.0, 61.0, 2, "Dragonmaw Fortress - introductory orc kills", "Shadowmoon Valley (Outland)"),
            pin(104, 69.4, 82.4, 3, "Netherwing Ledge - Nethervine Crystal quest area", "Shadowmoon Valley (Outland)"),
            pin(104, 69.0, 61.0, 3, "Dragonmaw Fortress - release enslaved drakes", "Shadowmoon Valley (Outland)"),
            pin(104, 69.8, 61.5, 4, "Karynaku / Zuluhed - fortress platform", "Shadowmoon Valley (Outland)"),
            pin(104, 60.0, 59.0, 4, "Mordenai - Ally of the Netherwing", "Shadowmoon Valley (Outland)"),
            pin(104, 66.2, 85.6, 5, "Overlord Mor'ghor - disguised camp introductions", "Shadowmoon Valley (Outland)"),
            pin(104, 66.0, 86.4, 5, "Taskmaster Varkule Dragonbreath - camp introductions", "Shadowmoon Valley (Outland)"),
            pin(104, 66.0, 86.5, 6, "Yarzill the Merc - repeatable egg hand-ins", "Shadowmoon Valley (Outland)"),
            pin(104, 65.3, 90.0, 7, "Netherwing Mines entrance - egg farming", "Shadowmoon Valley (Outland)"),
            pin(104, 65.3, 90.0, 8, "Netherwing Mines - cargo, kills and crystal dailies", "Shadowmoon Valley (Outland)"),
            pin(104, 66.0, 86.4, 9, "Taskmaster Varkule Dragonbreath - rank promotions", "Shadowmoon Valley (Outland)"),
            pin(104, 66.0, 86.4, 10, "Bow to the Highlord - Exalted finale", "Shadowmoon Valley (Outland)"),
            pin(104, 66.2, 85.6, 10, "Lord Illidan Stormrage - stay for the rescue", "Shadowmoon Valley (Outland)"),
            pin(111, 66.5, 16.8, 11, "Barthamus and " .. drake .. " - first free drake"),
            pin(104, 65.6, 86.0, 12, "Drake Dealer Hurlunk - additional colors", "Shadowmoon Valley (Outland)"),
        },
    })
end

-- https://www.wowhead.com/item=30480#comments:id=5963192
-- https://www.wowhead.com/item=30480#comments:id=6139303
-- https://www.wowhead.com/npc=16152/attumen-the-huntsman
-- Original Karazhan floor 1 is UiMap 350, not Legion's map 809.
addMount(36702, "Fiery Warhorse", 30480, {
    steps = {
        "Travel to Karazhan in Deadwind Pass and enter the ORIGINAL raid through the ground-level gatehouse at 46.9, 74.8. Do not enter the raised Legion Return to Karazhan dungeon portal: that instance has a different Attumen and a different mount.",
        "Stay on the entry floor and follow the stables corridor toward Midnight and Attumen, around 45.2, 82.6 on the original Servant's Quarters map. Clear the spectral horses and stable hands along the way so their fears and stuns do not drag extra packs into the encounter. You do not need to complete the rest of the tower.",
        "Attack Midnight to begin the encounter, defeat Attumen when he joins, and loot Attumen's corpse for a chance at Fiery Warhorse's Reins. Check the body even if you defeated the encounter almost instantly on a high-level character.",
        "If the reins do not drop, return after the weekly raid reset or make another attempt on a different eligible character. Reset All Instances does not refresh this character's boss loot. No old Karazhan attunement or Master's Key quest is required for this run.",
        "Use Fiery Warhorse's Reins from your bags to learn Fiery Warhorse. This is a ground mount; it does not fly like the Headless Horseman's mount or share the collection entry of Midnight's Eternal Reins.",
    },
    source = "Attumen the Huntsman - original Karazhan raid, stables",
    category = "Dungeon and Raids", faction = "all", npcId = 16152,
    requirements = "An eligible character capable of clearing the original Karazhan raid encounter.",
    cost = "No purchase cost for the raid-drop route.",
    tips = "This is the original raid's weekly attempt, not the Legion dungeon's lockout. Different characters provide additional independent chances, not a guaranteed drop after a particular number of kills. The mapped instance floor is the original Karazhan floor.",
    waypoints = {
        pin(42, 46.9, 74.8, 1, "Original Karazhan - ground-level raid entrance"),
        pin(350, 45.2, 82.6, 2, "Stables - clear the approach to Midnight / Attumen", "Karazhan (original raid): Servant's Quarters"),
        pin(350, 45.2, 82.6, 3, "Attumen - defeat and loot the mount boss", "Karazhan (original raid): Servant's Quarters"),
    },
})

-- https://www.wowhead.com/item=32458#comments:id=715250 and all seven replies
-- https://www.wowhead.com/item=32458#comments:id=3301485
-- https://www.wowhead.com/item=32458#comments:id=6284639
-- https://www.wowhead.com/npc=19622/kaelthas-sunstrider
addMount(40192, "Ashes of Al'ar", 32458, {
    steps = {
        "Fly to Tempest Keep in eastern Netherstorm. Enter The Eye through the large central floating structure at 73.6, 63.7. The smaller surrounding structures are The Botanica, The Mechanar and The Arcatraz; their bosses do not drop Ashes of Al'ar.",
        "Inside, cross Al'ar's central hall and take either outer corridor around toward the northern chamber. Clear any trash blocking your route. You can skip Al'ar, Void Reaver and High Astromancer Solarian; their deaths do not enable or improve the mount drop.",
        "Reach Kael'thas Sunstrider in the northern room, around 50.0, 13.8 on The Eye map. Start the encounter and stay inside: kill the four advisors as they activate, then the animated weapons, then the advisors again when they revive. Prioritize Capernian if her crowd control is interrupting your attacks.",
        "Defeat Kael'thas when he becomes attackable, waiting through any remaining dialogue or phase transition. On a low-level solo character, dismiss pets if mind control is resetting the fight and return with a stronger character if the encounter is not manageable. Loot Kael'thas himself for the rare Ashes; Al'ar is not the mount's loot source.",
        "If it does not drop, try on another eligible character or wait for the weekly raid reset. The Eye has a single original raid difficulty for this purpose; toggling raid size/difficulty or resetting the instance does not create more loot chances for the same saved character.",
        "Use Ashes of Al'ar from your bags and confirm it in Collections > Mounts. Learning the mount does not require winning an Arena season or grinding a reputation.",
    },
    source = "Kael'thas Sunstrider - The Eye, Tempest Keep",
    category = "Dungeon and Raids", faction = "all", npcId = 19622,
    requirements = "Flight access to Tempest Keep; an eligible character capable of clearing the original raid encounter.",
    cost = "No purchase cost for the raid-drop route.",
    tips = "The existing weekly farming advice is retained, but a full raid clear is optional. There is no required number of attempts, special looting order, or need to kill the phoenix boss first. This Kael'thas is different from the dungeon boss in Magisters' Terrace.",
    waypoints = {
        pin(109, 73.6, 63.7, 1, "The Eye - central Tempest Keep raid entrance"),
        pin(334, 50.0, 13.8, 3, "Kael'thas - advisors, weapons and boss encounter", "Tempest Keep: The Eye"),
        pin(334, 50.0, 13.8, 4, "Kael'thas - loot Ashes of Al'ar", "Tempest Keep: The Eye"),
    },
})

-- https://www.wowhead.com/item=32768#comments:id=3277885
-- https://www.wowhead.com/item=32768#comments:id=5400635 and reply
-- https://www.wowhead.com/npc=23035/anzu
addMount(41252, "Raven Lord", 32768, {
    steps = {
        "Before entering, right-click your character portrait and set Dungeon Difficulty to HEROIC. Travel to the Auchindoun ring in Terokkar Forest and enter Sethekk Halls on its eastern side at 44.9, 65.6. The other Auchindoun entrances lead to different dungeons.",
        "Follow the Veil Sethekk corridors past Darkweaver Syth's area and climb to the Halls of Mourning floor. Clear enemies that follow you, especially the Sethekk packs whose control effects can interrupt a run. A Rogue or Druid can stealth past avoidable trash, but no particular class is required.",
        "Find Anzu in his room at 32.6, 54.5 on Halls of Mourning. He is already present in Retail: no Druid, old summon item or flight-form quest is needed. Defeat him and loot Reins of the Raven Lord. If he becomes immune during a longer fight, kill his summoned birds, then finish the boss.",
        "If the reins do not drop, leave and return after the next daily Heroic reset, or use another eligible character. Killing Talon King Ikiss is optional for the mount chance. Reset All Instances does not grant a second Anzu kill's loot on the same daily save.",
        "Use the reins from your bags to learn Raven Lord and check Collections > Mounts. Despite the bird appearance, this is a ground mount and cannot fly.",
    },
    source = "Anzu - Heroic Sethekk Halls, Halls of Mourning",
    category = "Dungeon and Raids", faction = "all", npcId = 23035,
    requirements = "Heroic Sethekk Halls access; a character capable of clearing the route and Anzu. No Druid summon requirement.",
    cost = "No purchase cost for the dungeon-drop route.",
    tips = "Normal Sethekk Halls is not the direct mount-farming difficulty. The old Druid summoning instructions predate Retail's permanently present Anzu. Daily attempts on multiple characters increase the number of chances, without guaranteeing a drop.",
    waypoints = {
        pin(108, 44.9, 65.6, 1, "Sethekk Halls - eastern Auchindoun entrance; Heroic"),
        pin(259, 32.6, 54.5, 3, "Anzu - permanently present Heroic mount boss", "Sethekk Halls: Halls of Mourning"),
    },
})

-- https://www.wowhead.com/item=35513#comments:id=5347980 and its orb reply
-- https://www.wowhead.com/item=35513#comments:id=6370420 (post-Midnight route)
-- https://www.wowhead.com/npc=24723/selin-fireheart
-- https://www.wowhead.com/npc=24744/vexallus
-- https://www.wowhead.com/npc=24560/priestess-delrissa
-- https://www.wowhead.com/npc=24664/kaelthas-sunstrider
-- Retail UiMapGroupMember: floor 2 = 349; floor 1 = 348.
addMount(46628, "Swift White Hawkstrider", 35513, {
    steps = {
        "Go to Shattrath City and take the portal at 48.6, 42.0 to the ORIGINAL Isle of Quel'Danas. Retail comments after Midnight confirm that this portal still reaches the Burning Crusade island. This route avoids confusing the new Midnight island and dungeon with the old ones.",
        "Set Dungeon Difficulty to HEROIC before entering original Magisters' Terrace at 61.2, 30.9 on Isle of Quel'Danas (#122). Confirm the instance is Heroic. Normal mode is not the direct Swift White Hawkstrider farming route.",
        "Follow the entrance path to Selin Fireheart at 42.4, 22.3 on Observation Grounds. Defeat him and clear any nearby enemies pulled into combat so you can continue through the opened route.",
        "Continue through the mana-wyrm hall to Vexallus at 83.4, 26.4 on Observation Grounds. Defeat Vexallus and proceed through the courtyard toward the next boss; kill summoned Pure Energy if the fight lasts long enough for it to appear.",
        "On Grand Magister's Asylum, defeat Priestess Delrissa and all four companions at 39.7, 55.7. Do not leave a surviving companion behind: finish the entire encounter to open the route to the final chamber.",
        "Reach Kael'thas at 8.6, 50.2 on Grand Magister's Asylum and defeat him. If the encounter reaches Gravity Lapse, move away from the floating orbs and finish him when you can attack again. Loot Kael'thas himself for a chance at Swift White Hawkstrider.",
        "Use the mount item if it drops. After looting, use the orb behind Kael'thas to leave. If it did not drop, repeat after the daily Heroic reset or on another eligible character; Reset All Instances does not refresh this character's Heroic loot.",
    },
    source = "Kael'thas Sunstrider - original Heroic Magisters' Terrace",
    category = "Dungeon and Raids", faction = "all", npcId = 24664,
    requirements = "Access to the original Isle of Quel'Danas and Heroic Magisters' Terrace; no racial reputation requirement.",
    cost = "No purchase cost for the dungeon-drop route.",
    tips = "Both factions can learn and use this drop. It is separate from the Horde-only Swift Warstrider sold for PvP tokens. The Shattrath portal and original island are still usable Retail destinations; the pins intentionally use the original island and dungeon floors.",
    waypoints = {
        pin(111, 48.6, 42.0, 1, "Shattrath portal - original Isle of Quel'Danas"),
        pin(122, 61.2, 30.9, 2, "Original Magisters' Terrace entrance - set Heroic", "Isle of Quel'Danas (original)"),
        pin(349, 42.4, 22.3, 3, "Selin Fireheart - first boss", "Magisters' Terrace (original): Observation Grounds"),
        pin(349, 83.4, 26.4, 4, "Vexallus - second boss", "Magisters' Terrace (original): Observation Grounds"),
        pin(348, 39.7, 55.7, 5, "Priestess Delrissa and companions", "Magisters' Terrace (original): Grand Magister's Asylum"),
        pin(348, 8.6, 50.2, 6, "Kael'thas - Heroic mount drop", "Magisters' Terrace (original): Grand Magister's Asylum"),
    },
})

-- https://www.wowhead.com/item=33999#comments:id=3190546 and reply
-- https://www.wowhead.com/item=33999#comments:id=1966685 (removed armament turn-ins)
-- https://www.wowhead.com/item=33999#comments:id=5640327
-- https://www.wowhead.com/npc=17904/fedryen-swiftspear
-- https://www.wowhead.com/npc=17797/hydromancer-thespia
-- https://www.wowhead.com/npc=17796/mekgineer-steamrigger
-- https://www.wowhead.com/npc=17798/warlord-kalithresh
addMount(43927, "Cenarion War Hippogryph", 33999, {
    steps = {
        "Check your character's Cenarion Expedition reputation. The mount requires Exalted with the Outland faction, not the Cenarion Circle. If already Exalted, go straight to Fedryen Swiftspear in step 6.",
        "Travel to Coilfang Reservoir in Zangarmarsh at 50.4, 40.8. Swim down the central underwater pipe and continue until you emerge in the air-filled entrance cavern. Set Dungeon Difficulty to Normal for repeatable farming.",
        "Enter The Steamvault from the rear of the cavern; verify the instance name rather than entering The Slave Pens, The Underbog or Serpentshrine Cavern. Clear the naga and other reputation-awarding trash as well as the bosses. Normal Steamvault continues awarding Cenarion Expedition reputation through Revered.",
        "For a full clear, defeat Hydromancer Thespia at 54.2, 13.7 and Mekgineer Steamrigger at 34.1, 81.9 on The Steamvault floor. Activate the access panels associated with their areas to open the final boss route. Defeat Warlord Kalithresh at 75.9, 43.6 and kill remaining useful trash before leaving. Remove any city reputation tabard if kills are crediting a different faction.",
        "Exit, reset the Normal instance outside and repeat until Cenarion Expedition is Exalted. Pause at the hourly instance limit. If Normal kills leave you at the final point before Exalted, complete a Heroic Coilfang dungeon for the remaining reputation. Existing Cenarion Expedition quests in Outland are optional extra reputation; the old Coilfang Armaments turn-ins are no longer a current shortcut.",
        "Visit Fedryen Swiftspear at Cenarion Refuge, 79.2, 63.8 in Zangarmarsh. Buy Cenarion War Hippogryph for its usual Exalted price of 1,600 gold (2,000 gold base), then use the item from your bags.",
    },
    source = "Fedryen Swiftspear - Cenarion Refuge, Zangarmarsh; Cenarion Expedition Exalted",
    category = "Reputation", faction = "all", npcId = 17904,
    requirements = "Cenarion Expedition Exalted; Apprentice Riding; a character capable of farming the chosen dungeon route.",
    cost = "1,600 gold at Exalted (2,000 gold base), before any additional discounts.",
    tips = "Both factions can buy this mount. Normal Steamvault is the repeatable reputation route; killing raid bosses in Serpentshrine Cavern does not replace it. Buying Coilfang Armaments based on old comments will waste gold because their reputation hand-in was removed.",
    waypoints = {
        pin(102, 50.4, 40.8, 2, "Coilfang Reservoir - swim down the central pipe"),
        pin(263, 54.2, 13.7, 4, "Hydromancer Thespia - boss and access panel", "The Steamvault: main floor"),
        pin(263, 34.1, 81.9, 4, "Mekgineer Steamrigger - boss and access panel", "The Steamvault: main floor"),
        pin(263, 75.9, 43.6, 4, "Warlord Kalithresh - final boss", "The Steamvault: main floor"),
        pin(102, 79.2, 63.8, 6, "Fedryen Swiftspear - buy the hippogryph at Exalted"),
    },
})

-- https://www.wowhead.com/item=34060#comments:id=872940 and reply
-- https://www.wowhead.com/item=34060#comments:id=167005 and all replies
-- https://www.wowhead.com/spell=44155/flying-machine (current recipe, skill 1)
-- https://www.wowhead.com/npc=19576/xyrol
-- https://www.wowhead.com/npc=20981/dealer-najeeb (current limited stock)
addMount(44153, "Flying Machine", 34060, {
    steps = {
        "Use a character with Engineering. Decide whether to buy a finished Flying Machine from the Auction House or craft it. Even an Auction House purchase requires Outland Engineering (1) to learn; a non-engineer cannot use the purchase to bypass the profession requirement.",
        "Visit Xyrol, the neutral Engineering trainer in Area 52, Netherstorm, at 32.5, 66.6. Learn the Outland Engineering branch if missing, then train Flying Machine at Outland Engineering 1. You do not need to level an unrelated expansion's Engineering or choose Gnomish/Goblin specialization for this mount. If buying the finished item, skip the material steps after learning the required branch.",
        "For crafting, gather exactly 2 Fel Iron Casings, 20 Elemental Blasting Powder, 20 Handfuls of Fel Iron Bolts and 8 Star Wood. Buy finished components on the Auction House or train their Outland Engineering recipes. Star Wood is an enchanting-supplies item. The recipe asks for 20 Handfuls, not 20 individual bolts in a differently named item.",
        "If using a vendor shortcut, check Dealer Najeeb at The Stormspire, Netherstorm, 44.8, 36.5 for limited-stock Fel Iron Bolts. Buy only relevant stock and source missing components elsewhere rather than waiting for a guaranteed restock. When crafting bolts or blasting powder, count the resulting items because one craft can yield multiple units.",
        "Return to an anvil with the tools listed by the recipe, including an Arclight Spanner and Blacksmith Hammer, and craft Flying Machine. Alternatively, buy the unused finished Flying Machine (34060) after confirming its profession requirement on your character.",
        "Use the finished item from your bags to add Flying Machine to Collections > Mounts. Keep Engineering and satisfy the journal's profession requirement on the character that will ride it. The standard and Turbo-Charged machines are separate collection appearances; the ordinary one already scales with your riding skill.",
    },
    source = "Outland Engineering (1) - train with Xyrol in Area 52; crafted item can also be bought",
    category = "Professions", faction = "all", npcId = 19576,
    requirements = "Outland Engineering 1 and Apprentice Riding to learn. Crafting requires the recipe, tools and an anvil.",
    cost = "2 Fel Iron Casings, 20 Elemental Blasting Powder, 20 Handfuls of Fel Iron Bolts, 8 Star Wood; or a variable Auction House price.",
    tips = "The current recipe is much cheaper than its original Burning Crusade version. Do not gather the obsolete Adamantite Frame/Fel Iron Toolbox recipe from old comments. The old 300/350 profession numbers predate the expansion profession split; use Outland Engineering.",
    waypoints = {
        pin(109, 32.5, 66.6, 2, "Xyrol - Outland Engineering and Flying Machine recipe"),
        pin(109, 44.8, 36.5, 4, "Dealer Najeeb - optional limited-stock Fel Iron Bolts"),
    },
})

-- https://www.wowhead.com/item=34061#comments:id=1481240 and all six replies
-- A reply incorrectly restores the old three-bar Power Core recipe. Current
-- Retail spell 30308 uses ONE Khorium Bar, so the mount needs eight, not 24.
-- https://www.wowhead.com/spell=44157/turbo-charged-flying-machine
-- https://www.wowhead.com/spell=30308/khorium-power-core
-- https://www.wowhead.com/item=34061#comments:id=166926 and replies
-- https://www.wowhead.com/npc=19227/griftah
addMount(44151, "Turbo-Charged Flying Machine", 34061, {
    steps = {
        "Use a character with Engineering and learn the Outland Engineering branch from Xyrol at 32.5, 66.6 in Area 52, Netherstorm. Raise OUTLAND Engineering to 75 with that branch's recipes; skill in a different expansion does not fulfill the requirement to learn this mount.",
        "At Outland Engineering 75, train Turbo-Charged Flying Machine from Xyrol. You can either craft it with the following materials or buy a finished unused Turbo-Charged Flying Machine (34061) from the Auction House. Buying it does not bypass the Outland Engineering requirement to learn it.",
        "For crafting, gather 4 Adamantite Frames, 8 Khorium Power Cores and 8 Felsteel Stabilizers. If making all those components yourself, the current combined materials are 16 Adamantite Bars, 8 Khorium Bars, 48 Fel Iron Bars, 32 Eternium Bars, 4 Primal Earth and 8 Primal Fire. Train the component recipes or buy the finished parts; check the current recipe output before making duplicates.",
        "Go to Griftah in Shattrath's Lower City at 65.6, 68.6 and buy one Hula Girl Doll, 100 gold base before applicable discounts. This vendor doll is a required reagent; it is not the earlier Flying Machine mount and does not drop from a boss.",
        "For an optional component purchase, check Dealer Najeeb at The Stormspire, Netherstorm, 44.8, 36.5 for limited-stock Adamantite Frames. Obtain missing parts from crafting or the Auction House. Khorium is a rare Outland mining node if gathering your own ore; do not assume a vendor will have all eight Power Cores waiting.",
        "At an anvil, use the tools shown by your learned recipe, including an Arclight Spanner and Blacksmith Hammer, and craft the Turbo-Charged Flying Machine. The current recipe does not consume a standard Flying Machine, so crafting this does not automatically collect the other appearance.",
        "Use the finished item from your bags to learn the mount and check Collections > Mounts. Keep Engineering and satisfy the journal's profession requirement on each character that will ride it. This is an appearance choice with flames and the dashboard doll, not a purchase of faster riding skill.",
    },
    source = "Outland Engineering (75) - Xyrol in Area 52; Hula Girl Doll from Griftah in Shattrath",
    category = "Professions", faction = "all", npcId = 19576,
    requirements = "Outland Engineering 75 and Apprentice Riding to learn. Crafting requires the recipe, tools and an anvil.",
    cost = "4 Adamantite Frames + 8 Khorium Power Cores + 8 Felsteel Stabilizers + 1 Hula Girl Doll (100 gold base); or variable Auction House price.",
    tips = "One current Khorium Power Core uses one Khorium Bar and one Primal Fire; older comments and a later reply quote a superseded three-bar recipe. Do not spend 24 Khorium Bars on the basis of that advice. Both Engineering specializations can craft this mount.",
    waypoints = {
        pin(109, 32.5, 66.6, 1, "Xyrol - learn and level Outland Engineering"),
        pin(109, 32.5, 66.6, 2, "Xyrol - Turbo-Charged Flying Machine recipe at 75"),
        pin(111, 65.6, 68.6, 4, "Griftah - Hula Girl Doll"),
        pin(109, 44.8, 36.5, 5, "Dealer Najeeb - optional limited-stock Adamantite Frames"),
    },
})


rate("easy", "Buy the racial or flying mount on an eligible character; no rare drop is required.", {
    32235,32239,32240,32242,32289,32290,32292,32243,32244,32245,32246,32295,32296,32297,
    33660,34795,35018,35020,35022,35025,35027,34406,35710,35711,35712,35713,35714,
})
rate("easy", "Reach the automatic class-unlock level on a Blood Elf Paladin.", {34767,34769})
rate("medium", "Earn 15 Marks of Honor and buy the correct faction mount; no Arena rating is needed.", {35028,48027})
rate("medium", "Farm ogres and repeatable warbead turn-ins to Exalted, then buy the chosen color.", {
    34896,34897,34898,34899,39315,39317,39318,39319,
})
rate("hard", "Obtain Halaa tokens through contested PvP or an unpredictable garrison mission, then control Halaa to buy the mount.", {34790,39316})
rate("medium", "Complete the Skettis unlock and repeat reputation farming to Exalted; all five colors share that standing.", {
    39798,39800,39801,39802,39803,
})
rate("medium", "Finish the Netherwing introduction and build Exalted reputation with dailies and repeatable egg turn-ins.", {
    41513,41514,41515,41516,41517,41518,
})
rate("hard", "A rare boss drop and daily or weekly loot lockouts make the number of attempts unpredictable.", {36702,40192,41252,46628})
rate("medium", "Reach Cenarion Expedition Exalted through repeatable dungeon farming and pay the mount's gold cost.", {43927})
rate("medium", "Level the required Outland Engineering skill and obtain the crafted mount or its materials.", {44151,44153})

-- Apply the reviewed text consistently to the list, inspectors and map payload.
-- Retain unrelated detail fields and all spell IDs, names and patch membership.
-- Empty waypoint tables intentionally replace automatic class-unlock sources.
local fields = { "acquisition", "source", "tips", "requirements", "cost", "category", "waypoints", "faction", "difficulty", "difficultyReason" }
for patchKey, patch in pairs(TDP.PatchCatalog.patches) do
    if patchKey:match("^2%.") then
        for _, entry in ipairs(patch.mounts) do
            local guide = guides[entry.spellId]
            if guide then
                local original = TDP.PatchCatalog.mountDetails[patchKey][entry.name] or {}
                local details = {}
                for key, value in pairs(original) do details[key] = value end
                for _, field in ipairs(fields) do
                    entry[field], details[field] = guide[field], guide[field]
                end
                if guide.npcId then entry.npcId, details.npcId = guide.npcId, guide.npcId end
                details.sourceType = guide.category
                TDP.PatchCatalog.mountDetails[patchKey][entry.name] = details
            end
        end
    end
end
