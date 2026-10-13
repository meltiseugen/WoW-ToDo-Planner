local _, TDP = ...
local PatchCatalog = TDP.PatchCatalog

-- Retail audit: 2026-10-13. Explicit collectible IDs, never name/source-text heuristics.
-- A retired bundle is distinct from its component appearances (some remain farmable).
-- Recurring events, tradable pets, BMAH and Timelost Saddle rewards are not retired.
local availability = { mounts = {}, pets = {}, toys = {}, cosmetics = {} }
PatchCatalog.collectionAvailability = availability
PatchCatalog.collectionAvailabilityReviewedAt = "2026-10-13"

local function Add(collectionType, ids, reason, sourceUrl, eligibility)
    local record = {
        reason = reason,
        sourceUrl = sourceUrl,
        reviewedAt = "2026-10-13",
        achievementIds = eligibility and eligibility.achievementIds,
        questIds = eligibility and eligibility.questIds,
        characterOnly = eligibility and eligibility.characterOnly,
    }
    for _, id in ipairs(ids) do
        assert(not availability[collectionType][id], "Duplicate collection availability ID: " .. id)
        availability[collectionType][id] = record
    end
end

-- Ended Gladiator seasons, through Midnight Season 1; Season 2 stays available
Add("mounts", {
    37015, -- Swift Nether Drake (2.1)
    44744, -- Merciless Nether Drake (2.3)
    49193, -- Vengeful Nether Drake (2.4)
    58615, -- Brutal Nether Drake (2.4)
    64927, -- Deadly Gladiator's Frost Wyrm (3.1.0)
    65439, -- Furious Gladiator's Frost Wyrm (3.2.0)
    67336, -- Relentless Gladiator's Frost Wyrm (3.2.0)
    71810, -- Wrathful Gladiator's Frost Wyrm (3.3.0)
    101282, -- Vicious Gladiator's Twilight Drake (4.0.0)
    101821, -- Ruthless Gladiator's Twilight Drake (4.2.0)
    124550, -- Cataclysmic Gladiator's Twilight Drake (4.3.0)
    139407, -- Malevolent Gladiator's Cloud Serpent (5.0)
    148618, -- Tyrannical Gladiator's Cloud Serpent (5.2)
    148619, -- Grievous Gladiator's Cloud Serpent (5.4.0)
    148620, -- Prideful Gladiator's Cloud Serpent (5.4.7)
    186828, -- Primal Gladiator's Felblood Gronnling (6.0.0)
    189043, -- Wild Gladiator's Felblood Gronnling (6.2.0)
    189044, -- Warmongering Gladiator's Felblood Gronnling (6.2.3)
    227986, -- Vindictive Gladiator's Storm Dragon (7.0.0)
    227988, -- Fearless Gladiator's Storm Dragon (7.1.0)
    227989, -- Cruel Gladiator's Storm Dragon (7.2.0)
    227991, -- Ferocious Gladiator's Storm Dragon (7.2.5)
    227994, -- Fierce Gladiator's Storm Dragon (7.3.0)
    227995, -- Dominant Gladiator's Storm Dragon (7.3.5)
    243201, -- Demonic Gladiator's Storm Dragon (7.3.5)
    262022, -- Dread Gladiator's Proto-Drake (8.0.0)
    262023, -- Sinister Gladiator's Proto-Drake (8.1.0)
    262024, -- Notorious Gladiator's Proto-Drake (8.2)
    262027, -- Corrupted Gladiator's Proto-Drake (8.3.0)
    353036, -- Unchained Gladiator's Soul Eater (9.1)
    365559, -- Cosmic Gladiator's Soul Eater (9.2)
    370346, -- Eternal Gladiator's Soul Eater (9.2.5)
    377071, -- Crimson Gladiator's Drake (10.0)
    408977, -- Obsidian Gladiator's Slitherdrake (10.1)
    425416, -- Verdant Gladiator's Slitherdrake (10.2)
    424539, -- Draconic Gladiator's Drake (10.2.6)
    449466, -- Forged Gladiator's Fel Bat (11.0)
    466144, -- Prized Gladiator's Fel Bat (11.1)
    472157, -- Astral Gladiator's Fel Bat (11.2)
    1262840, -- Galactic Gladiator's Goredrake (12.0)
}, "The original rated Arena season has ended. Its Gladiator mount cannot be earned in a later season.",
    "https://www.warcraftmounts.com/retired.php")

-- Original epic racial mounts
Add("mounts", {
    16082, -- Palomino (1.0)
    16083, -- White Stallion (1.0)
    17460, -- Frost Ram (1.0)
    17461, -- Black Ram (1.0)
    16055, -- Black Nightsaber (1.0)
    16056, -- Ancient Frostsaber (1.0)
    15779, -- White Mechanostrider Mod B (1.0)
    17459, -- Icy Blue Mechanostrider Mod A (1.0)
    16080, -- Red Wolf (1.0)
    16081, -- Arctic Wolf (1.0)
    16084, -- Mottled Red Raptor (1.0)
    17450, -- Ivory Raptor (1.0)
    18991, -- Green Kodo (1.1)
    18992, -- Teal Kodo (1.1)
}, "The original unarmored epic mount was removed from vendors in patch 1.4. Existing owners retain it.",
    "https://www.warcraftmounts.com/retired.php")

-- Pandaria Remix mounts
Add("mounts", {
    127178, -- Jungle Riding Crane (10.2.7)
    435044, -- Golden Discus (10.2.7)
    435082, -- Mogu Hazeblazer (10.2.7)
    435084, -- Sky Surfer (10.2.7)
    435108, -- Daystorm Windsteed (10.2.7)
    435107, -- Forest Windsteed (10.2.7)
    435103, -- Dashing Windsteed (10.2.7)
    435109, -- Feathered Windsurfer (10.2.7)
    435115, -- Guardian Quilen (10.2.7)
    435118, -- Marble Quilen (10.2.7)
    435123, -- Gilded Riding Crane (10.2.7)
    435128, -- Pale Riding Crane (10.2.7)
    435127, -- Rose Riding Crane (10.2.7)
    435126, -- Silver Riding Crane (10.2.7)
    435124, -- Luxurious Riding Crane (10.2.7)
    435125, -- Tropical Riding Crane (10.2.7)
    435131, -- Snowy Riding Goat (10.2.7)
    435133, -- Little Red Riding Goat (10.2.7)
    435145, -- Bloody Skyscreamer (10.2.7)
    435146, -- Night Pterrorwing (10.2.7)
    435147, -- Jade Pterrordax (10.2.7)
    435149, -- Cobalt Juggernaut (10.2.7)
    435150, -- Fel Iron Juggernaut (10.2.7)
    435153, -- Purple Shado-Pan Riding Tiger (10.2.7)
    435160, -- Riverwalker Mushan (10.2.7)
    435161, -- Palehide Mushan Beast (10.2.7)
    441794, -- Amber Pterrordax (10.2.7)
    446017, -- August Phoenix (10.2.7)
    446022, -- Astral Emperor's Serpent (10.2.7)
}, "Pandaria Remix has ended. This event-specific mount has no current acquisition source.",
    "https://news.blizzard.com/en-us/article/24115317/what-to-tackle-in-dragonflight-before-the-war-within")

-- Legion Remix mounts
Add("mounts", {
    1229276, -- Bloodhunter Fel Bat (11.2.5)
    1229283, -- Ashplague Fel Bat (11.2.5)
    1229288, -- Wretched Fel Bat (11.2.5)
    1235513, -- Snowy Highmountain Eagle (11.2.5)
    1238729, -- Slag Basilisk (11.2.5)
    1250482, -- Ghastly Ur'zul (11.2.5)
    1250879, -- Leystone Basilisk (11.2.5)
    1250880, -- Felslate Basilisk (11.2.5)
    1250881, -- Aquamarine Basilisk (11.2.5)
    1250882, -- Illidari Dreadstalker (11.2.5)
    1250884, -- Illidari Blightstalker (11.2.5)
    1250886, -- Highland Elderhorn (11.2.5)
    1251255, -- Treetop Highmountain Eagle (11.2.5)
    1251265, -- Arcberry Manasaber (11.2.5)
    1251279, -- Fel-Scarred Mana Ray (11.2.5)
    1251281, -- Bloodtooth Mana Ray (11.2.5)
    1251283, -- Albino Mana Ray (11.2.5)
    1251284, -- Luminous Mana Ray (11.2.5)
    1251295, -- Twilight Courser (11.2.5)
    1251297, -- Golden Sunrunner (11.2.5)
    1251298, -- Turquoise Courser (11.2.5)
    1251300, -- Gloomdark Nightmare (11.2.5)
    1251305, -- Bonesteed of Triumph (11.2.5)
    1251307, -- Bonesteed of Bloodshed (11.2.5)
    1251309, -- Bonesteed of Plague (11.2.5)
    1251311, -- Bonesteed of Oblivion (11.2.5)
    1251396, -- Longhorned Sable Talbuk (11.2.5)
    1251397, -- Garnet Ruinstrider (11.2.5)
    1251398, -- Longhorned Bleakhoof Talbuk (11.2.5)
    1251399, -- Longhorned Argussian Talbuk (11.2.5)
    1251400, -- Longhorned Beryl Talbuk (11.2.5)
    1253129, -- Chestnut Courser (11.2.5)
    1253130, -- Brimstone Courser (11.2.5)
    1255264, -- Felscorned Vilebrood Vanquisher (11.2.5)
    1255431, -- Slayer's Felscorned Shrieker (11.2.5)
    1255456, -- Felscorned Wolfhawk (11.2.5)
    1255463, -- Archmage's Felscorned Disc (11.2.5)
    1255467, -- Felscorned Grandmaster's Companion (11.2.5)
    1255471, -- Felscorned Highlord's Charger (11.2.5)
    1255475, -- High Priest's Felscorned Seeker (11.2.5)
    1255477, -- Shadowblade's Felscorned Omen (11.2.5)
    1255478, -- Farseer's Felscorned Tempest (11.2.5)
    1255480, -- Felscorned Netherlord's Dreadsteed (11.2.5)
    1255482, -- Felscorned War Wyrm (11.2.5)
}, "Legion Remix has ended. This event-specific mount has no current acquisition source.",
    "https://worldofwarcraft.blizzard.com/en-gb/news/24242738")

-- The original Gates of Ahn'Qiraj gong event and its reward window have ended.
Add("mounts", {
    26656, -- Black Qiraji Battle Tank (1.9)
}, "The original Gates of Ahn'Qiraj gong event and its reward window have ended.",
    "https://www.warcraftmounts.com/mount.php?mountid=129")

-- The original Zul'Aman timed raid was removed. Amani Battle Bear is a different mount.
Add("mounts", {
    43688, -- Amani War Bear (2.3)
}, "The original Zul'Aman timed raid was removed. Amani Battle Bear is a different mount.",
    "https://www.warcraftmounts.com/mount.php?mountid=134")

-- The original Glory of the Raider (25 player) mount reward was removed in patch 3.1.
Add("mounts", {
    59976, -- Black Proto-Drake (3.0)
}, "The original Glory of the Raider (25 player) mount reward was removed in patch 3.1.",
    "https://www.warcraftmounts.com/mount.php?mountid=171")

-- The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.
Add("mounts", {
    68056, -- Swift Horde Wolf (3.2.0)
}, "The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.",
    "https://www.warcraftmounts.com/mount.php?mountid=252")

-- The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.
Add("mounts", {
    68057, -- Swift Alliance Steed (3.2.0)
}, "The Trial of the Grand Crusader tribute mount reward was removed with Cataclysm.",
    "https://www.warcraftmounts.com/mount.php?mountid=251")

-- The A Tribute to Immortality mount reward was removed with Cataclysm.
Add("mounts", {
    68187, -- Crusader's White Warhorse (3.2.0)
}, "The A Tribute to Immortality mount reward was removed with Cataclysm.",
    "https://www.warcraftmounts.com/mount.php?mountid=253")

-- The A Tribute to Immortality mount reward was removed with Cataclysm.
Add("mounts", {
    68188, -- Crusader's Black Warhorse (3.2.0)
}, "The A Tribute to Immortality mount reward was removed with Cataclysm.",
    "https://www.warcraftmounts.com/mount.php?mountid=254")

-- The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.
Add("mounts", {
    129552, -- Crimson Pandaren Phoenix (5.0)
}, "The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.",
    "https://www.warcraftmounts.com/mount.php?mountid=380")

-- The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.
Add("mounts", {
    132117, -- Ashen Pandaren Phoenix (5.0)
}, "The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.",
    "https://www.warcraftmounts.com/mount.php?mountid=379")

-- The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.
Add("mounts", {
    132118, -- Emerald Pandaren Phoenix (5.0)
}, "The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.",
    "https://www.warcraftmounts.com/mount.php?mountid=381")

-- The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.
Add("mounts", {
    132119, -- Violet Pandaren Phoenix (5.0)
}, "The original Pandaria Challenge Modes were removed; their Phoenix mount unlock can no longer be earned.",
    "https://www.warcraftmounts.com/mount.php?mountid=382")

-- The original Brawler's Guild Rank 10 reward is retired. The current Brawler's Guild does not award this mount.
Add("mounts", {
    142641, -- Brawler's Burly Mushan Beast (5.3)
}, "The original Brawler's Guild Rank 10 reward is retired. The current Brawler's Guild does not award this mount.",
    "https://www.warcraftmounts.com/mount.php?mountid=428")

-- The Garrosh Ahead of the Curve mount reward ended before Warlords of Draenor.
Add("mounts", {
    148396, -- Kor'kron War Wolf (5.4.0)
}, "The Garrosh Ahead of the Curve mount reward ended before Warlords of Draenor.",
    "https://www.warcraftmounts.com/mount.php?mountid=436")

-- Warlords Challenge Modes were removed at the Legion pre-patch; their Silver mount reward can no longer be earned.
Add("mounts", {
    171848, -- Challenger's War Yeti (6.0.0)
}, "Warlords Challenge Modes were removed at the Legion pre-patch; their Silver mount reward can no longer be earned.",
    "https://www.warcraftmounts.com/mount.php?mountid=651")

-- The Heroic Archimonde quest mount reward ended at the Legion launch.
Add("mounts", {
    189999, -- Grove Warden (6.2.3)
}, "The Heroic Archimonde quest mount reward ended at the Legion launch.",
    "https://www.warcraftmounts.com/mount.php?mountid=708")

-- The Legion Brawler's Guild mount reward is retired. The current Brawler's Guild has different mount rewards.
Add("mounts", {
    230844, -- Brawler's Burly Basilisk (7.1.5)
}, "The Legion Brawler's Guild mount reward is retired. The current Brawler's Guild has different mount rewards.",
    "https://www.warcraftmounts.com/mount.php?mountid=790")

-- The Heroic Argus quest mount reward ended at the Battle for Azeroth launch.
Add("mounts", {
    253639, -- Violet Spellwing (7.3.5)
}, "The Heroic Argus quest mount reward ended at the Battle for Azeroth launch.",
    "https://www.warcraftmounts.com/mount.php?mountid=797")

-- The Battle for Azeroth pre-launch War of the Thorns reward event has ended.
Add("mounts", {
    272472, -- Undercity Plaguebat (8.0.0)
}, "The Battle for Azeroth pre-launch War of the Thorns reward event has ended.",
    "https://www.warcraftmounts.com/mount.php?mountid=952")

-- The Battle for Azeroth pre-launch War of the Thorns reward event has ended.
Add("mounts", {
    274610, -- Teldrassil Hippogryph (8.0.0)
}, "The Battle for Azeroth pre-launch War of the Thorns reward event has ended.",
    "https://www.warcraftmounts.com/mount.php?mountid=953")

-- The original Battle for Azeroth Brawler's Guild questline reward is retired. Brawlin' Bruno is a different mount.
Add("mounts", {
    289639, -- Bruce (8.1.5)
}, "The original Battle for Azeroth Brawler's Guild questline reward is retired. Brawlin' Bruno is a different mount.",
    "https://www.warcraftmounts.com/mount.php?mountid=1145")

-- The Heroic N'Zoth quest mount reward ended at the Shadowlands launch.
Add("mounts", {
    302143, -- Uncorrupted Voidwing (8.3.0)
}, "The Heroic N'Zoth quest mount reward ended at the Shadowlands launch.",
    "https://www.warcraftmounts.com/mount.php?mountid=1202")

-- The Heroic Jailer quest mount reward ended at the Dragonflight launch.
Add("mounts", {
    359545, -- Carcinized Zerethsteed (9.2)
}, "The Heroic Jailer quest mount reward ended at the Dragonflight launch.",
    "https://www.warcraftmounts.com/mount.php?mountid=1415")

-- The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.
Add("mounts", {
    441324, -- Remembered Golden Gryphon (11.0)
}, "The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.",
    "https://www.warcraftmounts.com/mount.php?mountid=1733")

-- The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.
Add("mounts", {
    441325, -- Remembered Wind Rider (11.0)
}, "The Radiant Echoes pre-expansion event has ended; this mount has no current vendor source.",
    "https://www.warcraftmounts.com/mount.php?mountid=1734")

-- Dastardly Duos mount; retain original quest eligibility
Add("mounts", {
    1227076, -- Tyrannotort (11.1.5)
}, "Dastardly Duos has ended. Only characters with the original Week 4 quest unlock can buy this mount from Wodin.",
    "https://www.wowhead.com/npc=234297/wodin-the-troll-servant", { questIds = { 87552 } })

-- Royal Voidwing
Add("mounts", {
    1242272, -- Royal Voidwing (11.2)
}, "The Heroic Dimensius quest mount reward ended when Midnight launched on March 2, 2026. Mythic raid drop mounts remain obtainable.",
    "https://news.blizzard.com/en-us/article/24257262/what-to-tackle-in-the-war-within-before-the-launch-of-midnight")

-- Voyaging Wilderling
Add("mounts", {
    439138, -- Voyaging Wilderling (10.2.6)
}, "The Dragonflight Season 4 Awakened raid mount reward ended with The War Within launch.",
    "https://news.blizzard.com/en-us/article/24115317/what-to-tackle-in-dragonflight-before-the-war-within")

-- Jigglesworth Sr.
Add("mounts", {
    366791, -- Jigglesworth Sr. (9.2.5)
}, "The Shadowlands Fated raid reward and its Dragonflight Season 4 Antique Bronze Bullion return have ended.",
    "https://www.warcraftmounts.com/mounts/jigglesworthsr.php")

-- Umbral Ashes
Add("mounts", {
    1301775, -- Umbral Ashes (12.1)
}, "The Midnight Season 1 top-one-percent Mythic+ reward can no longer be earned. This is separate from Keystone Master and Legend Saddle rewards.",
    "https://worldofwarcraft.blizzard.com/en-gb/news/24293280")

-- Breaker Bee / Magister's Spell Bee
Add("mounts", {
    1282471, -- Breaker Bee (12.0.5)
}, "Decor Duels ended in patch 12.1. The mount reward has no current source; only housing decor was retained for Voidlight Marl.",
    "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels")

-- Pandaria Remix pets
Add("pets", {
    4579, -- Muskpaw Calf (10.2.7)
    4580, -- Astral Emperor's Serpentling (10.2.7)
}, "Pandaria Remix has ended. This achievement pet cannot be caged or traded.",
    "https://www.warcraftpets.com/news/new-pets-remix-mists-of-pandaria-coming-soon/")

-- Legion Remix pets
Add("pets", {
    4801, -- Tidbit (11.2.5)
    4802, -- Morsel (11.2.5)
    4901, -- Fledgling Warden's Companion (11.2.5)
}, "Legion Remix ended January 19, 2026. This event pet cannot be caged or traded.",
    "https://worldofwarcraft.blizzard.com/en-gb/news/24242738")

-- Pre-Cataclysm transformation toys
Add("toys", {
    54651, -- Gnomeregan Pride (3.3.5)
    54653, -- Darkspear Pride (3.3.5)
}, "The Operation: Gnomeregan / Zalazane's Fall pre-Cataclysm event questline was removed.",
    "https://warcraft.wiki.gg/wiki/Gnomeregan_Pride")

-- Decor Duel toys
Add("toys", {
    268455, -- Enchanted Hourglass (12.0.5)
    268456, -- Animated Bench (12.0.5)
}, "Decor Duels ended in patch 12.1. This toy has no current source; the retained vendor inventory is housing decor.",
    "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels")

-- Decor Duel appearance tokens
Add("cosmetics", {
    272317, -- Spellbreaker's Phoenixglaive (12.0.5)
    272318, -- Spellbreaker's Phoenixblade (12.0.5)
    272338, -- Mage Guard's Spellsteel (12.0.5)
    272337, -- Mage Guard's Spellblade (12.0.5)
    272321, -- Arcane Ranger's Spellbow (12.0.5)
    272320, -- Nullbeacon Rift Channeler (12.0.5)
    272336, -- Nullbeacon Rift Smasher (12.0.5)
}, "Decor Duels ended in patch 12.1. This appearance token has no current source; housing decor remains available.",
    "https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels")

-- The Scourge Invasion tabard reward is retired. This is the Argent Dawn tabard, not the obtainable Argent Crusade tabard.
Add("cosmetics", {
    22999, -- Tabard of the Argent Dawn (1.11)
}, "The Scourge Invasion tabard reward is retired. This is the Argent Dawn tabard, not the obtainable Argent Crusade tabard.",
    "https://warcraft.wiki.gg/wiki/Tabard_of_the_Argent_Dawn")

-- The original Dark Portal launch event has ended. Existing eligible characters may reclaim their own tabard.
Add("cosmetics", {
    28788, -- Tabard of the Protector (2.0)
}, "The original Dark Portal launch event has ended. Existing eligible characters may reclaim their own tabard.",
    "https://www.wowhead.com/item=28788/tabard-of-the-protector")

-- The pre-Mists event and Pandaria Remix have ended. Only characters with the original Theramore's Fall unlock can reclaim this tabard.
Add("cosmetics", {
    89196, -- Theramore Tabard (5.0)
}, "The pre-Mists event and Pandaria Remix have ended. Only characters with the original Theramore's Fall unlock can reclaim this tabard.",
    "https://warcraft.wiki.gg/wiki/Theramore_Tabard", { achievementIds = { 7467 }, characterOnly = true })

-- Historical elite PvP tabards
Add("cosmetics", {
    45983, -- Furious Gladiator's Tabard (3.2.0)
    49086, -- Relentless Gladiator's Tabard (3.2.0)
    51534, -- Wrathful Gladiator's Tabard (3.3.0)
    98162, -- Tyrannical Gladiator's Tabard (5.2)
    101697, -- Grievous Gladiator's Tabard (5.4.0)
    103636, -- Prideful Gladiator's Tabard (5.4.7)
    115972, -- Primal Gladiator's Tabard (6.0.0)
    127365, -- Wild Gladiator's Tabard (6.2.0)
    127366, -- Wild Gladiator's Tabard (6.2.0)
    127369, -- Warmongering Gladiator's Tabard (6.2.3)
    127371, -- Warmongering Gladiator's Tabard (6.2.3)
    147336, -- Cruel Gladiator's Tabard (7.2.0)
    147337, -- Cruel Gladiator's Tabard (7.2.0)
    147338, -- Ferocious Gladiator's Tabard (7.2.5)
    147339, -- Ferocious Gladiator's Tabard (7.2.5)
    149442, -- Fierce Gladiator's Tabard (7.3.0)
    149443, -- Fierce Gladiator's Tabard (7.3.0)
    149446, -- Dominant Gladiator's Tabard (7.3.5)
    149447, -- Dominant Gladiator's Tabard (7.3.5)
    149450, -- Demonic Gladiator's Tabard (7.3.5)
    149451, -- Demonic Gladiator's Tabard (7.3.5)
}, "The original elite PvP season has ended. This seasonal tabard unlock can no longer be earned.",
    "https://us.forums.blizzard.com/en/wow/t/why-are-elite-sets-restricted-to-the-season/1271032/183")

-- Vindictive Elite Legion ensembles
Add("cosmetics", {
    146218, -- Ensemble: Elite Vindictive Gladiator's Plate Armor (7.2.0)
    146219, -- Ensemble: Elite Vindictive Gladiator's Plate Armor (7.2.0)
    146220, -- Ensemble: Elite Vindictive Gladiator's Dreadplate Armor (7.2.0)
    146221, -- Ensemble: Elite Vindictive Gladiator's Dreadplate Armor (7.2.0)
    146222, -- Ensemble: Elite Vindictive Gladiator's Scaled Armor (7.2.0)
    146223, -- Ensemble: Elite Vindictive Gladiator's Scaled Armor (7.2.0)
    146224, -- Ensemble: Elite Vindictive Gladiator's Ringmail Armor (7.2.0)
    146225, -- Ensemble: Elite Vindictive Gladiator's Ringmail Armor (7.2.0)
    146226, -- Ensemble: Elite Vindictive Gladiator's Chain Armor (7.2.0)
    146227, -- Ensemble: Elite Vindictive Gladiator's Chain Armor (7.2.0)
    146228, -- Ensemble: Elite Vindictive Gladiator's Dragonhide Armor (7.2.0)
    146229, -- Ensemble: Elite Vindictive Gladiator's Dragonhide Armor (7.2.0)
    146230, -- Ensemble: Elite Vindictive Gladiator's Ironskin Armor (7.2.0)
    146231, -- Ensemble: Elite Vindictive Gladiator's Ironskin Armor (7.2.0)
    146232, -- Ensemble: Elite Vindictive Gladiator's Leather Armor (7.2.0)
    146233, -- Ensemble: Elite Vindictive Gladiator's Leather Armor (7.2.0)
    146234, -- Ensemble: Elite Vindictive Gladiator's Silk Armor (7.2.0)
    146235, -- Ensemble: Elite Vindictive Gladiator's Silk Armor (7.2.0)
    146236, -- Ensemble: Elite Vindictive Gladiator's Satin Armor (7.2.0)
    146237, -- Ensemble: Elite Vindictive Gladiator's Satin Armor (7.2.0)
    146238, -- Ensemble: Elite Vindictive Gladiator's Felweave Armor (7.2.0)
    146239, -- Ensemble: Elite Vindictive Gladiator's Felweave Armor (7.2.0)
    146270, -- Ensemble: Elite Vindictive Gladiator's Felskin Armor (7.2.0)
    146271, -- Ensemble: Elite Vindictive Gladiator's Felskin Armor (7.2.0)
}, "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor", { achievementIds = { 11578, 11579 }, characterOnly = true })

-- Cruel Elite Legion ensembles
Add("cosmetics", {
    147621, -- Ensemble: Elite Cruel Gladiator's Chain Armor (7.2.0)
    147622, -- Ensemble: Elite Cruel Gladiator's Chain Armor (7.2.0)
    147623, -- Ensemble: Elite Cruel Gladiator's Dragonhide Armor (7.2.0)
    147624, -- Ensemble: Elite Cruel Gladiator's Dragonhide Armor (7.2.0)
    147625, -- Ensemble: Elite Cruel Gladiator's Dreadplate Armor (7.2.0)
    147626, -- Ensemble: Elite Cruel Gladiator's Dreadplate Armor (7.2.0)
    147627, -- Ensemble: Elite Cruel Gladiator's Felskin Armor (7.2.0)
    147628, -- Ensemble: Elite Cruel Gladiator's Felskin Armor (7.2.0)
    147629, -- Ensemble: Elite Cruel Gladiator's Felweave Armor (7.2.0)
    147630, -- Ensemble: Elite Cruel Gladiator's Felweave Armor (7.2.0)
    147631, -- Ensemble: Elite Cruel Gladiator's Ironskin Armor (7.2.0)
    147632, -- Ensemble: Elite Cruel Gladiator's Ironskin Armor (7.2.0)
    147633, -- Ensemble: Elite Cruel Gladiator's Leather Armor (7.2.0)
    147634, -- Ensemble: Elite Cruel Gladiator's Leather Armor (7.2.0)
    147635, -- Ensemble: Elite Cruel Gladiator's Plate Armor (7.2.0)
    147636, -- Ensemble: Elite Cruel Gladiator's Plate Armor (7.2.0)
    147637, -- Ensemble: Elite Cruel Gladiator's Ringmail Armor (7.2.0)
    147638, -- Ensemble: Elite Cruel Gladiator's Ringmail Armor (7.2.0)
    147639, -- Ensemble: Elite Cruel Gladiator's Satin Armor (7.2.0)
    147640, -- Ensemble: Elite Cruel Gladiator's Satin Armor (7.2.0)
    147641, -- Ensemble: Elite Cruel Gladiator's Scaled Armor (7.2.0)
    147642, -- Ensemble: Elite Cruel Gladiator's Scaled Armor (7.2.0)
    147643, -- Ensemble: Elite Cruel Gladiator's Silk Armor (7.2.0)
    147644, -- Ensemble: Elite Cruel Gladiator's Silk Armor (7.2.0)
}, "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor", { achievementIds = { 11697, 11698 }, characterOnly = true })

-- Fierce Elite Legion ensembles
Add("cosmetics", {
    149454, -- Ensemble: Elite Fierce Gladiator's Chain Armor (7.3.0)
    149455, -- Ensemble: Elite Fierce Gladiator's Chain Armor (7.3.0)
    149456, -- Ensemble: Elite Fierce Gladiator's Dragonhide Armor (7.3.0)
    149457, -- Ensemble: Elite Fierce Gladiator's Dragonhide Armor (7.3.0)
    149458, -- Ensemble: Elite Fierce Gladiator's Dreadplate Armor (7.3.0)
    149459, -- Ensemble: Elite Fierce Gladiator's Dreadplate Armor (7.3.0)
    149460, -- Ensemble: Elite Fierce Gladiator's Felskin Armor (7.3.0)
    149461, -- Ensemble: Elite Fierce Gladiator's Felskin Armor (7.3.0)
    149462, -- Ensemble: Elite Fierce Gladiator's Felweave Armor (7.3.0)
    149463, -- Ensemble: Elite Fierce Gladiator's Felweave Armor (7.3.0)
    149464, -- Ensemble: Elite Fierce Gladiator's Ironskin Armor (7.3.0)
    149465, -- Ensemble: Elite Fierce Gladiator's Ironskin Armor (7.3.0)
    149466, -- Ensemble: Elite Fierce Gladiator's Leather Armor (7.3.0)
    149467, -- Ensemble: Elite Fierce Gladiator's Leather Armor (7.3.0)
    149468, -- Ensemble: Elite Fierce Gladiator's Plate Armor (7.3.0)
    149469, -- Ensemble: Elite Fierce Gladiator's Plate Armor (7.3.0)
    149470, -- Ensemble: Elite Fierce Gladiator's Ringmail Armor (7.3.0)
    149471, -- Ensemble: Elite Fierce Gladiator's Ringmail Armor (7.3.0)
    149472, -- Ensemble: Elite Fierce Gladiator's Satin Armor (7.3.0)
    149473, -- Ensemble: Elite Fierce Gladiator's Satin Armor (7.3.0)
    149474, -- Ensemble: Elite Fierce Gladiator's Scaled Armor (7.3.0)
    149475, -- Ensemble: Elite Fierce Gladiator's Scaled Armor (7.3.0)
    149476, -- Ensemble: Elite Fierce Gladiator's Silk Armor (7.3.0)
    149477, -- Ensemble: Elite Fierce Gladiator's Silk Armor (7.3.0)
}, "The Legion season rating unlock can no longer be earned. Characters that earned the matching original Elite achievement can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor", { achievementIds = { 12090, 12135, 12198 }, characterOnly = true })

-- Crimson Elite Dragonflight armor
Add("cosmetics", {
    230886, -- Ensemble: Elite Crimson Gladiator's Death Knight Armor (11.0.5)
    230887, -- Ensemble: Elite Crimson Gladiator's Demon Hunter Armor (11.0.5)
    230888, -- Ensemble: Elite Crimson Gladiator's Druid Armor (11.0.5)
    230889, -- Ensemble: Elite Crimson Gladiator's Evoker Armor (11.0.5)
    230890, -- Ensemble: Elite Crimson Gladiator's Hunter Armor (11.0.5)
    230891, -- Ensemble: Elite Crimson Gladiator's Mage Armor (11.0.5)
    230892, -- Ensemble: Elite Crimson Gladiator's Monk Armor (11.0.5)
    230893, -- Ensemble: Elite Crimson Gladiator's Paladin Armor (11.0.5)
    230894, -- Ensemble: Elite Crimson Gladiator's Priest Armor (11.0.5)
    230895, -- Ensemble: Elite Crimson Gladiator's Rogue Armor (11.0.5)
    230896, -- Ensemble: Elite Crimson Gladiator's Shaman Armor (11.0.5)
    230897, -- Ensemble: Elite Crimson Gladiator's Warlock Armor (11.0.5)
    230898, -- Ensemble: Elite Crimson Gladiator's Warrior Armor (11.0.5)
}, "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=230886", { achievementIds = { 15952 }, characterOnly = true })

-- Crimson Elite Dragonflight weapons
Add("cosmetics", {
    202123, -- Crimson Gladiator's Greatbow (10.0)
    202124, -- Crimson Gladiator's Crossbow (10.0)
    202125, -- Crimson Gladiator's Greatstaff (10.0)
    202126, -- Crimson Gladiator's Spellblade (10.0)
    202127, -- Crimson Gladiator's Censer (10.0)
    202128, -- Crimson Gladiator's Rod (10.0)
    202129, -- Crimson Gladiator's Barrier (10.0)
    202130, -- Crimson Gladiator's Bulwark (10.0)
    202131, -- Crimson Gladiator's Sword (10.0)
    202132, -- Crimson Gladiator's Warhammer (10.0)
    202133, -- Crimson Gladiator's Blade (10.0)
    202134, -- Crimson Gladiator's Glaive (10.0)
    202135, -- Crimson Gladiator's Poleaxe (10.0)
    202136, -- Crimson Gladiator's Quarterstaff (10.0)
    202137, -- Crimson Gladiator's Greataxe (10.0)
    202138, -- Crimson Gladiator's Greatmace (10.0)
    202139, -- Crimson Gladiator's Scepter (10.0)
    202140, -- Crimson Gladiator's Claw (10.0)
    230901, -- Arsenal: Elite Crimson Gladiator's Weapons (11.0.5)
}, "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    "https://www.wowhead.com/achievement=15984", { achievementIds = { 15984 }, characterOnly = true })

-- Obsidian Elite Dragonflight armor
Add("cosmetics", {
    230968, -- Ensemble: Elite Obsidian Gladiator's Death Knight Armor (11.0.5)
    230969, -- Ensemble: Elite Obsidian Gladiator's Demon Hunter Armor (11.0.5)
    230970, -- Ensemble: Elite Obsidian Gladiator's Druid Armor (11.0.5)
    230971, -- Ensemble: Elite Obsidian Gladiator's Evoker Armor (11.0.5)
    230972, -- Ensemble: Elite Obsidian Gladiator's Hunter Armor (11.0.5)
    230973, -- Ensemble: Elite Obsidian Gladiator's Mage Armor (11.0.5)
    230974, -- Ensemble: Elite Obsidian Gladiator's Monk Armor (11.0.5)
    230975, -- Ensemble: Elite Obsidian Gladiator's Paladin Armor (11.0.5)
    230976, -- Ensemble: Elite Obsidian Gladiator's Priest Armor (11.0.5)
    230977, -- Ensemble: Elite Obsidian Gladiator's Rogue Armor (11.0.5)
    230978, -- Ensemble: Elite Obsidian Gladiator's Shaman Armor (11.0.5)
    230979, -- Ensemble: Elite Obsidian Gladiator's Warlock Armor (11.0.5)
    230980, -- Ensemble: Elite Obsidian Gladiator's Warrior Armor (11.0.5)
}, "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=230968", { achievementIds = { 17795 }, characterOnly = true })

-- Obsidian Elite Dragonflight weapons
Add("cosmetics", {
    206044, -- Obsidian Gladiator's Axe (10.1)
    206137, -- Obsidian Gladiator's Dagger (10.1)
    206146, -- Obsidian Gladiator's Warglaive (10.1)
    206147, -- Obsidian Gladiator's Polearm (10.1)
    206148, -- Obsidian Gladiator's Staff (10.1)
    206149, -- Obsidian Gladiator's Rifle (10.1)
    206150, -- Obsidian Gladiator's Mace (10.1)
    206151, -- Obsidian Gladiator's Rod (10.1)
    206152, -- Obsidian Gladiator's Shield (10.1)
    206153, -- Obsidian Gladiator's Claws (10.1)
    206154, -- Obsidian Gladiator's Bow (10.1)
    230983, -- Arsenal: Elite Obsidian Gladiator's Weapons (11.0.5)
}, "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    "https://www.wowhead.com/achievement=17831", { achievementIds = { 17831 }, characterOnly = true })

-- Verdant Elite Dragonflight armor
Add("cosmetics", {
    231137, -- Ensemble: Elite Verdant Gladiator's Death Knight Armor (11.0.5)
    231138, -- Ensemble: Elite Verdant Gladiator's Demon Hunter Armor (11.0.5)
    231139, -- Ensemble: Elite Verdant Gladiator's Druid Armor (11.0.5)
    231140, -- Ensemble: Elite Verdant Gladiator's Evoker Armor (11.0.5)
    231141, -- Ensemble: Elite Verdant Gladiator's Hunter Armor (11.0.5)
    231142, -- Ensemble: Elite Verdant Gladiator's Mage Armor (11.0.5)
    231143, -- Ensemble: Elite Verdant Gladiator's Monk Armor (11.0.5)
    231144, -- Ensemble: Elite Verdant Gladiator's Paladin Armor (11.0.5)
    231145, -- Ensemble: Elite Verdant Gladiator's Priest Armor (11.0.5)
    231146, -- Ensemble: Elite Verdant Gladiator's Rogue Armor (11.0.5)
    231147, -- Ensemble: Elite Verdant Gladiator's Shaman Armor (11.0.5)
    231148, -- Ensemble: Elite Verdant Gladiator's Warlock Armor (11.0.5)
    231149, -- Ensemble: Elite Verdant Gladiator's Warrior Armor (11.0.5)
}, "The original Dragonflight Rival I unlock can no longer be earned. Characters with the matching historical rating unlock can still buy this legacy ensemble.",
    "https://www.wowhead.com/item=231137", { achievementIds = { 19133, 19493 }, characterOnly = true })

-- Verdant Elite Dragonflight weapons
Add("cosmetics", {
    210502, -- Verdant Gladiator's Axe (10.2)
    210503, -- Verdant Gladiator's Dagger (10.2)
    210504, -- Verdant Gladiator's Sickle (10.2)
    210506, -- Verdant Gladiator's Warglaive (10.2)
    210507, -- Verdant Gladiator's Scythe (10.2)
    210508, -- Verdant Gladiator's Staff (10.2)
    210509, -- Verdant Gladiator's Greatstaff (10.2)
    210510, -- Verdant Gladiator's Axestaff (10.2)
    210511, -- Verdant Gladiator's Rifle (10.2)
    210512, -- Verdant Gladiator's Scepter (10.2)
    210513, -- Verdant Gladiator's Censer (10.2)
    210514, -- Verdant Gladiator's Shield (10.2)
    210515, -- Verdant Gladiator's Bulwark (10.2)
    210516, -- Verdant Gladiator's Claws (10.2)
    210517, -- Verdant Gladiator's Bow (10.2)
    210518, -- Verdant Gladiator's Greatsword (10.2)
    210519, -- Verdant Gladiator's Pulverizer (10.2)
    210520, -- Verdant Gladiator's Sword (10.2)
    210521, -- Verdant Gladiator's Shotel (10.2)
    231152, -- Arsenal: Elite Verdant Gladiator's Weapons (11.0.5)
}, "The original Dragonflight Elite weapon unlock can no longer be earned. Characters with the matching historical Elite achievement retain legacy vendor access.",
    "https://www.wowhead.com/achievement=19090", { achievementIds = { 19090, 19509 }, characterOnly = true })

-- Forged Elite weapon tokens
Add("cosmetics", {
    225856, -- Forged Gladiator's Axe (11.0)
    225857, -- Forged Gladiator's Dagger (11.0)
    225858, -- Forged Gladiator's Pincer (11.0)
    225859, -- Forged Gladiator's Warglaive (11.0)
    225860, -- Forged Gladiator's Spear (11.0)
    225861, -- Forged Gladiator's Staff (11.0)
    225863, -- Forged Gladiator's Battlestaff (11.0)
    225864, -- Forged Gladiator's Crossbow (11.0)
    225865, -- Forged Gladiator's Scepter (11.0)
    225866, -- Forged Gladiator's Focus (11.0)
    225867, -- Forged Gladiator's Shield (11.0)
    225868, -- Forged Gladiator's Bulwark (11.0)
    225869, -- Forged Gladiator's Claws (11.0)
    225870, -- Forged Gladiator's Bow (11.0)
    225871, -- Forged Gladiator's Greataxe (11.0)
    225872, -- Forged Gladiator's Pulverizer (11.0)
    225874, -- Forged Gladiator's Wither-Blade (11.0)
}, "The War Within Season 1 Duelist unlock can no longer be earned. Accounts with the original Duelist achievement retain legacy weapon access.",
    "https://www.wowhead.com/achievement=40391", { achievementIds = { 40391 } })

-- Forged Elite armor ensembles
Add("cosmetics", {
    232681, -- Ensemble: Elite Forged Gladiator's Death Knight Armor (11.1)
    232682, -- Ensemble: Elite Forged Gladiator's Demon Hunter Armor (11.1)
    232683, -- Ensemble: Elite Forged Gladiator's Druid Armor (11.1)
    232684, -- Ensemble: Elite Forged Gladiator's Evoker Armor (11.1)
    232685, -- Ensemble: Elite Forged Gladiator's Hunter Armor (11.1)
    232686, -- Ensemble: Elite Forged Gladiator's Mage Armor (11.1)
    232687, -- Ensemble: Elite Forged Gladiator's Monk Armor (11.1)
    232688, -- Ensemble: Elite Forged Gladiator's Paladin Armor (11.1)
    232689, -- Ensemble: Elite Forged Gladiator's Priest Armor (11.1)
    232690, -- Ensemble: Elite Forged Gladiator's Rogue Armor (11.1)
    232691, -- Ensemble: Elite Forged Gladiator's Shaman Armor (11.1)
    232692, -- Ensemble: Elite Forged Gladiator's Warlock Armor (11.1)
    232693, -- Ensemble: Elite Forged Gladiator's Warrior Armor (11.1)
}, "The War Within Season 1 Rival I unlock can no longer be earned. Accounts with the original Rival I achievement can still buy this ensemble.",
    "https://www.wowhead.com/item=232681", { achievementIds = { 40389 } })

-- Exclusive Legion Remix cosmetic unlocks; ordinary farmable sets are excluded
Add("cosmetics", {
    253382, -- Arsenal: Arms of the Felforged Knight (11.2.5)
    255156, -- Arsenal: Odyn's Spears (11.2.5)
    253379, -- Ensemble: Windrunner Quivers (11.2.5)
    241416, -- Ensemble: Blazing Dreamscribed Robes (11.2.5)
    241415, -- Ensemble: Dreamwatcher Vestments (11.2.5)
    241414, -- Ensemble: Dreamseeker Vestments (11.2.5)
    241413, -- Ensemble: Nightrune Robes (11.2.5)
    241412, -- Ensemble: Earthrune Robes (11.2.5)
    241411, -- Ensemble: Skyrune Robes (11.2.5)
    241410, -- Ensemble: Slayer's Golden Scarguards (11.2.5)
    241409, -- Ensemble: Slayer's Silver Scarguards (11.2.5)
    241408, -- Ensemble: Fel-Bloodied Battlegear (11.2.5)
    241407, -- Ensemble: Searaider's Battlegarb (11.2.5)
    241406, -- Ensemble: Gladeraider's Battlegarb (11.2.5)
    241403, -- Ensemble: Jarl's Battlescales (11.2.5)
    241402, -- Ensemble: Ruby Drake Hunter's Kit (11.2.5)
    241400, -- Ensemble: Highpeak Dragonscale (11.2.5)
    241399, -- Ensemble: Dreamweald Dragonscale (11.2.5)
    241397, -- Ensemble: Firewurm Dragonscale (11.2.5)
    241396, -- Ensemble: Jarl's Battlehorns (11.2.5)
    241395, -- Ensemble: Storm Champion's Warharness (11.2.5)
    241358, -- Ensemble: Dream Defender's Emerald Guardplate (11.2.5)
    190772, -- Ensemble: Barkbinds of the Archdruid's Nightmare (11.2.5)
    241356, -- Ensemble: Tidecaller's Scales (11.2.5)
    241355, -- Ensemble: Verdant Dreamscribed Robes (11.2.5)
    251271, -- Ensemble: Tidesoaked Battlegear (11.2.5)
    253385, -- Ensemble: Mantles of the Nightwell (11.2.5)
    253358, -- Ensemble: Tideskorn Hunter's Munitions (11.2.5)
    253551, -- Arsenal: Mo'arg Swords (11.2.5)
    253556, -- Arsenal: Bone Scythes (11.2.5)
    253561, -- Arsenal: Immortal Maces (11.2.5)
    253565, -- Arsenal: Mo'arg Hornmaces (11.2.5)
    253569, -- Arsenal: Gems of the Lightforged Draenei (11.2.5)
    241360, -- Ensemble: Stygian Silks (11.2.5)
    241392, -- Ensemble: Argussian Demonsbane Armor (11.2.5)
    241390, -- Ensemble: Vestments of Eredathian Sacrifice (11.2.5)
    241389, -- Ensemble: Antoran Guard's Golden Battleplate (11.2.5)
    241388, -- Ensemble: Heritage of the Lightforged - Holy Gold (11.2.5)
    241387, -- Ensemble: Heritage of the Lightforged - Hologemmed (11.2.5)
    241386, -- Ensemble: Heritage of the Lightforged - Crimson Vengeance (11.2.5)
    241385, -- Ensemble: Heritage of the Shal'dorei - Vineyard Red (11.2.5)
    241405, -- Ensemble: Skyborne Brigandine (11.2.5)
    241404, -- Ensemble: Seaborne Brigandine (11.2.5)
    241401, -- Ensemble: Sunborne Runemail (11.2.5)
    241398, -- Ensemble: Earthbreaker Dragonscale (11.2.5)
    241394, -- Ensemble: Val'kyr's Warharness (11.2.5)
    241393, -- Ensemble: Winged Plate of the Valhalas Champion (11.2.5)
    241354, -- Ensemble: Emerald Drake Hunter's Kit (11.2.5)
    253343, -- Ensemble: Sargerei Commander's Felscorned Regalia (11.2.5)
    257104, -- Ensemble: Sargerei Commander's Voidscarred Regalia (11.2.5)
    257106, -- Ensemble: Sargerei Commander's Lightbound Regalia (11.2.5)
    257105, -- Ensemble: Sargerei Commander's Hellforged Regalia (11.2.5)
    241608, -- Ensemble: Regalia of the Chosen Dead (11.2.5)
    241603, -- Ensemble: Garb of the Chosen Dead (11.2.5)
    241599, -- Ensemble: Chains of the Chosen Dead (11.2.5)
    241596, -- Ensemble: Funerary Plate of the Chosen Dead (11.2.5)
    253344, -- Kaldorei Queen's Sarong (11.2.5)
    253345, -- Kaldorei Queen's Crown (11.2.5)
    253346, -- Kaldorei Queen's Robe (11.2.5)
    253347, -- Kaldorei Queen's Sash (11.2.5)
    253348, -- Kaldorei Queen's Anklets (11.2.5)
    253349, -- Kaldorei Queen's Bangles (11.2.5)
    246793, -- Sinister Feldirk (11.2.5)
    246991, -- Sinister Felstaff (11.2.5)
    246786, -- Sinister Felblade (11.2.5)
    246997, -- Sinister Felwand (11.2.5)
    253231, -- Fallen King's Corrupted Blades (11.2.5)
    253221, -- Appearance: Bulwark of Mannoroth (11.2.5)
    253285, -- Felscorned Scythe of the Unmaker (11.2.5)
    242368, -- The First Satyr's Spaulders (11.2.5)
    255006, -- Taeshalach (11.2.5)
    253273, -- Scythe of the Unmaker (11.2.5)
    253353, -- Illusion: Felshatter (11.2.5)
}, "Legion Remix has ended. This exclusive cosmetic unlock or bundle is no longer awarded or sold. Original raid drops may still provide some component appearances, but not the full Remix unlock.",
    "https://worldofwarcraft.blizzard.com/en-gb/news/24242738")

-- Dastardly Duos cosmetics; retained achievement eligibility
Add("cosmetics", {
    239506, -- Red Dastardly Epaulet (11.1.5)
    239507, -- Yellow Dastardly Epaulet (11.1.5)
}, "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    "https://www.wowhead.com/npc=234297/wodin-the-troll-servant", { achievementIds = { 41948 } })

-- Dastardly Duos cosmetics; retained achievement eligibility
Add("cosmetics", {
    239504, -- Green Dastardly Epaulet (11.1.5)
    239505, -- Purple Dastardly Epaulet (11.1.5)
}, "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    "https://www.wowhead.com/npc=234297/wodin-the-troll-servant", { achievementIds = { 41949 } })

-- Dastardly Duos cosmetics; retained achievement eligibility
Add("cosmetics", {
    239442, -- Black Dastardly Epaulet (11.1.5)
    239503, -- Blue Dastardly Epaulet (11.1.5)
}, "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    "https://www.wowhead.com/npc=234297/wodin-the-troll-servant", { achievementIds = { 41950 } })

-- Dastardly Duos cosmetics; retained achievement eligibility
Add("cosmetics", {
    238624, -- Dastardly Pinchzapper (11.1.5)
}, "Dastardly Duos has ended. The vendor requires the original Defeat the Dastardlies achievement; eligible accounts retain access.",
    "https://www.wowhead.com/npc=234297/wodin-the-troll-servant", { achievementIds = { 41951 } })

-- Seasonal Nemesis achievement mounts are separate from ordinary legacy boss drops.
Add("mounts", {
    1268949, -- Arcanovoid Construct (12.0)
}, "Midnight Season 1 has ended. The Let Me Solo Him: Nullaeus mount reward can no longer be earned.",
    "https://news.blizzard.com/en-us/article/24293280/the-clock-is-ticking-on-midnight-season-1-achievements-and-rewards")

Add("toys", {
    206267, -- Obsidian Legend's Pennant (10.1)
    206343, -- Crimson Legend's Pennant (10.1)
}, "The original Dragonflight Solo Shuffle season has ended. Its Legend pennant reward can no longer be earned.",
    "https://warcraft.wiki.gg/wiki/Obsidian_Legend%27s_Pennant")

Add("toys", {
    225547, -- Toxic Victory (11.0 catalog)
    230727, -- Explosive Victory (11.0 catalog)
}, "The original War Within Delve storyline quest reward was removed in patch 12.0.1.",
    "https://warcraft.wiki.gg/wiki/Category:Removed_in_patch_12.0.1")

local ID_FIELDS = { mounts = "spellId", pets = "speciesId", toys = "itemId", cosmetics = "itemId" }

function PatchCatalog:GetCollectionAvailability(collectionType, patchKey, entry)
    local field = ID_FIELDS[collectionType]
    local id = field and type(entry) == "table" and tonumber(entry[field])
    return id and availability[collectionType][id] or nil
end

function PatchCatalog:HasOriginalCollectionUnlock(record)
    if not record then
        return false
    end
    if type(GetAchievementInfo) == "function" then
        for _, id in ipairs(record.achievementIds or {}) do
            local ok, _, _, _, completed, _, _, _, _, _, _, _, _, earnedByMe = pcall(GetAchievementInfo, id)
            if ok and (record.characterOnly and earnedByMe == true or not record.characterOnly and completed == true) then
                return true
            end
        end
    end
    if C_QuestLog and type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
        for _, id in ipairs(record.questIds or {}) do
            local ok, completed = pcall(C_QuestLog.IsQuestFlaggedCompleted, id)
            if ok and completed == true then
                return true
            end
        end
    end
    return false
end

function PatchCatalog:IsCollectionUnobtainable(collectionType, patchKey, entry)
    local record = self:GetCollectionAvailability(collectionType, patchKey, entry)
    return record ~= nil and not self:HasOriginalCollectionUnlock(record)
end
