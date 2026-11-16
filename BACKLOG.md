# Backlog

- renaming of project: files, folder etc.

- add more skins: class based, race based, faction based





- add button to track an item and put it in the planner board for the character

- favorite window should stay available and the same for every character

- when i click on the planner, the board for that character should by default be selected



- step by step guide is displayed like shit and hard to read

- meed to search for more and add holydai items under general


12.1.7

12.2


So im telling you again, with all the patience in the world.
We will work next on [EXPANSION TAB] information:
- for each item in here
- search wowheadfor that item
- IF YOU WORK ON ACHIVEMENTS, WE DONT CARE ABOUT GUILD ACHIVEMENTS, YOU CAN REMOVE THOSE
- WE NEED TO ONLY HAVE ITEMS THAT ARE STILL OBTAINABBLE OR ACHIVEABLE IN RETAIL, WHAT IS NOT, WE NEED TO REMOVE FROM THE CATALOGUE ENTIRELY
- DONT search for new items     
- look at the comments and find the ones that are green preferably (but not neccessary), and that have a numbered list of steps that end in profit, or "profit ?", or " profit achviement completed".
- There are different numbers of users that post this kind of comments
- THESE ARE THE COMMENTS WE ARE INTERESTED IN
- i need you to add that numbered guide to our addon, but exclude the "profit" step.
- also we have already location data for that item. IF WE DONT FIRST FIND THE LOCATION DATA SO WE CAN RENDER THE FUCKING MAP BUTTON.
- if the numbered guide list mentions map locations or coordinated, i need you, in the map view for the item, to add a dropdown at the top so we can navigate between the guides locations. E.g. step one mentions location X, then go to location Y. if X and Y are on the same map, add a new entry in the dropdown and palce both locations and number them accordingly to the guide step number. if X and Y are on different maps, add 2 entried in the dropdown.
- if the comment with the "profit" steps has replys, look at the replys because there could be relevant info there.
- IF you first search the comments and dont find any with steps and "profit", look at the other comments, at all of them, and try to make up a guide from waht the users mention.
- the guides and the description and the how to get we have right now for items, is a complete shit, and hard to follow and understand. i want you to add fucking steps and details, not some generic bullshit
- we are only interested in retail only
- if wowhead blocks you from reading comments, find other ways around that, you know you can do it. You said "I can now read the full reply threads through Wowhead’s public comment endpoint".
- I found a working way to read the full Retail pages: their URL-encoded addresses return the embedded comment data. That gives me the parent comments, ratings, and reply counts, and I can expand threads through the public reply endpoint.
- do this really FUCKING GOOD, BECAUSE I AM LOOSING MY FUCKING PATIENCE!
- forget about running the tests, dont even think about that, dont even run the lua syntax checker
- nu vreau sa faci scipturi de python si sa scrapeuiesti comentarile dupa care sa trantesti textul in addon fara zero gandire implicata... vreau sa le scrapeuiesti tu in mintea ta, si sa le analizezi inainte sa le punem orbeste la noi in addon data. 
cine dracu iti tot zice si de ce crezi tu ca ii necesar sa imi tot faci fisiere in tools in care sa imi vomiti scripturi inutile? nu mai face asta, si nici in .local si nici Docs sa nu mai faci
- any information we add to the addon HAS to be in English, not any other language
- WE MAY ALREADY HAVE SOME DESCRIPTION AND HOW TO GET TEXT FOR EACH ITEM. DONT BLINDLY OVERWRITE THAT, LOOK AT WHAT WE HAVE ALSO AND MAYBE KEEP SOME OF THAT INFORMATION OR INTEGRATE IT WITH THE NEW INFORMATION YOU FIND NOW.
- if old locations or map data or information you find, are no longer usable in retail dont include them! ONLY USE LOCATIONS THAT ARE USABLE IN RETAIL WOW
- no more fucking tests!!!!!!!!!!!!!!
- IF your research determines that an item is no longer obtainable or achiveable in retail, maybe like pvp achivements from older seasons, or other stuff like this, I need you to ignore these and more so, remove them from our catalogue. then give me a list with exactly what you have removed!!
- DONT FUCKING STOP UNTIL EVERY ITEM FROM THIS IS COVERED. DONT FUCKING DO IT IN BATCHES AND UPDATE THE BACKLOG.md FILE WITH THE REMAINING. THERE IS NO FUCKING REMANING, DO IT ALL IN ONE GO
- also i want for each item to determine a dificulty level: easy, medium, hard. based on how hard or simple the steps to obtain / achive are
- Keep written acquisition steps and recorded guide locations. Do not provide character-specific quest guidance or save quest-progress snapshots.
- The map dropdown should list recorded guide destinations only, without Next quest entries or character progress comparisons.
- holiday related items, or items that dont relly belong to the expansion should be added under General (like the achivements we have)





general:
- [x] achivements
- [] holidays
- [] other 

classic:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achivements

burning crusade:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achievements

wrath:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achivements

cataclysm:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achivements

mists of pandaria:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achivements

draenor:
- [x] mounts
- [x] pets
- [x] toys
- [x] cosmetics
- [x] achivements

legion:
- [x] mounts
- [x] pets
- [] toys
- [] cosmetics
- [] achivements

BfA:
- [] mounts
- [] pets
- [] toys
- [] cosmetics
- [] achivements

Shadowlands:
- [] mounts
- [] pets
- [] toys
- [] cosmetics
- [] achivements

Dragonflight:
- [] mounts
- [] pets
- [] toys
- [] cosmetics
- [] achivements

The War Within:
- [] mounts
- [] pets
- [] toys
- [] cosmetics
- [] achivements

Midnight:
- [] mounts
- [] pets
- [] toys
- [] cosmetics
- [] achivements




















## Missing Retail achievements - complete aggregate from this conversation

**125 unique achievement IDs: 4 initial findings + 23 additions + 46 additions + 52 additions.** Each achievement is listed individually below with its Retail Wowhead link. This is the cumulative list of findings reported in this conversation.

Keep only achievements that remain obtainable in Retail. Remove permanently unobtainable entries, including retired PvP season awards, from THIS LIST. This list does not authorize changes to the existing catalogue. Recurring Cup and Classic Timewalking achievements remain listed with their event availability requirements. Obtainable Feats of Strength remain eligible.

### General and cross-expansion achievements (15)

- [ ] 6601 - [Taming the Wild](https://www.wowhead.com/achievement=6601) - Defeat a master pet tamer on one of the listed early-expansion continents.
- [ ] 6742 - [60 Exalted Reputations](https://www.wowhead.com/achievement=6742) - Raise 60 reputations to Exalted.
- [ ] 6826 - [55 Exalted Reputations](https://www.wowhead.com/achievement=6826) - Raise 55 reputations to Exalted.
- [ ] 7382 - [Dynamic Duo](https://www.wowhead.com/achievement=7382) - Reach maximum level with two different classes.
- [ ] 7520 - [The Loremaster](https://www.wowhead.com/achievement=7520) - Complete the required quest metas.
- [ ] 9069 - [An Awfully Big Adventure](https://www.wowhead.com/achievement=9069) - Defeat the listed trainers with an Elekk Plushie on the team; includes Darkmoon Faire trainers.
- [ ] 9422 - [The Search For Fact, Not Truth](https://www.wowhead.com/achievement=9422) - Find 30 rare archaeology artifacts.
- [ ] 9598 - [Mountacular](https://www.wowhead.com/achievement=9598) - Alliance version; obtain 250 mounts usable by one character.
- [ ] 9599 - [Mountacular](https://www.wowhead.com/achievement=9599) - Horde version; obtain 250 mounts usable by one character.
- [ ] 9643 - [So. Many. Pets.](https://www.wowhead.com/achievement=9643) - Collect 600 unique pets.
- [ ] 9673 - [The Toymaster](https://www.wowhead.com/achievement=9673) - Collect 150 toys.
- [ ] 9713 - [Awake the Drakes](https://www.wowhead.com/achievement=9713) - Collect the listed drakes from several expansions.
- [ ] 11176 - [Remember to Share](https://www.wowhead.com/achievement=11176) - Collect 300 toys.
- [ ] 14782 - [Level 50](https://www.wowhead.com/achievement=14782) - Current level-50 milestone; separate from legacy ID 10.
- [ ] 14783 - [Level 60](https://www.wowhead.com/achievement=14783) - Current level-60 milestone; separate from legacy ID 11.

### Old-world quests, collections, faction leaders, and pet battles (31)

- [ ] 12429 - [Wetlands Quests](https://www.wowhead.com/achievement=12429) - Alliance; current Retail Wetlands storylines.
- [ ] 12430 - [Duskwood Quests](https://www.wowhead.com/achievement=12430) - Alliance; current Retail Duskwood storylines.
- [ ] 11741 - [So Hot Right Now](https://www.wowhead.com/achievement=11741) - Collect a Molten Core class armor set.
- [ ] 11742 - [Dress in Lairs](https://www.wowhead.com/achievement=11742) - Collect a Blackwing Lair class armor set.
- [ ] 11743 - [Accessor-Eyes](https://www.wowhead.com/achievement=11743) - Collect a Temple of Ahn'Qiraj class armor set.
- [ ] 11744 - [Drop Dead, Gorgeous](https://www.wowhead.com/achievement=11744) - Original Naxxramas Tier 3 set; obtainable Feat of Strength through current Retail collection methods, including restored crafting and the BMAH.
- [ ] 14815 - [Executing the Exarch](https://www.wowhead.com/achievement=14815) - Horde; kill High Exarch Turalyon in Stormwind.
- [ ] 14817 - [Opposing Orgrimmar](https://www.wowhead.com/achievement=14817) - Alliance; kill Rokhan in Orgrimmar.
- [ ] 61028 - [Undead Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61028)
- [ ] 61029 - [Aquatic Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61029)
- [ ] 61030 - [Beast Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61030)
- [ ] 61031 - [Critter Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61031)
- [ ] 61032 - [Dragonkin Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61032)
- [ ] 61033 - [Elemental Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61033)
- [ ] 61034 - [Flying Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61034)
- [ ] 61035 - [Humanoid Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61035)
- [ ] 61036 - [Magic Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61036)
- [ ] 61037 - [Mechanical Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61037)
- [ ] 61040 - [Family Battler of Eastern Kingdoms](https://www.wowhead.com/achievement=61040) - Complete all ten family challenges; requires an Alliance character for the trainer quests.
- [ ] 61041 - [Aquatic Battler of Kalimdor](https://www.wowhead.com/achievement=61041)
- [ ] 61042 - [Beast Battler of Kalimdor](https://www.wowhead.com/achievement=61042)
- [ ] 61043 - [Critter Battler of Kalimdor](https://www.wowhead.com/achievement=61043)
- [ ] 61044 - [Dragonkin Battler of Kalimdor](https://www.wowhead.com/achievement=61044)
- [ ] 61045 - [Elemental Battler of Kalimdor](https://www.wowhead.com/achievement=61045)
- [ ] 61046 - [Flying Battler of Kalimdor](https://www.wowhead.com/achievement=61046)
- [ ] 61047 - [Humanoid Battler of Kalimdor](https://www.wowhead.com/achievement=61047)
- [ ] 61048 - [Magic Battler of Kalimdor](https://www.wowhead.com/achievement=61048)
- [ ] 61049 - [Mechanical Battler of Kalimdor](https://www.wowhead.com/achievement=61049)
- [ ] 61050 - [Undead Battler of Kalimdor](https://www.wowhead.com/achievement=61050)
- [ ] 61051 - [Family Battler of Kalimdor](https://www.wowhead.com/achievement=61051) - Complete all ten family challenges; requires a Horde character for the trainer quests.
- [ ] 61094 - [Old World Family Battler](https://www.wowhead.com/achievement=61094) - Complete the Eastern Kingdoms and Kalimdor family metas.

Each trainer family challenge requires a team of level-25 pets of the named family. These challenges were released in the Midnight pre-patch and concern the old-world trainers. [Retail release and requirements](https://www.wowhead.com/news/new-family-pet-battler-achievements-added-in-midnight-pre-patch-new-pets-and-toy-380131).

### Wrath / Northrend content (15)

- [ ] 11750 - [Undying Aesthetic](https://www.wowhead.com/achievement=11750) - Collect a Wrath Naxxramas Tier 7 class armor set.
- [ ] 11751 - [Mogg-Saron](https://www.wowhead.com/achievement=11751) - Collect an Ulduar class armor set.
- [ ] 11752 - [Style of the Crusader](https://www.wowhead.com/achievement=11752) - Collect a Trial of the Crusader class armor set.
- [ ] 11753 - [Winter Catalog](https://www.wowhead.com/achievement=11753) - Collect an Icecrown Citadel class armor set.
- [ ] 60942 - [Aquatic Battler of Northrend](https://www.wowhead.com/achievement=60942)
- [ ] 60943 - [Critter Battler of Northrend](https://www.wowhead.com/achievement=60943)
- [ ] 60944 - [Dragonkin Battler of Northrend](https://www.wowhead.com/achievement=60944)
- [ ] 60948 - [Elemental Battler of Northrend](https://www.wowhead.com/achievement=60948)
- [ ] 60949 - [Flying Battler of Northrend](https://www.wowhead.com/achievement=60949)
- [ ] 60950 - [Humanoid Battler of Northrend](https://www.wowhead.com/achievement=60950)
- [ ] 60951 - [Beast Battler of Northrend](https://www.wowhead.com/achievement=60951)
- [ ] 60952 - [Magic Battler of Northrend](https://www.wowhead.com/achievement=60952)
- [ ] 60953 - [Mechanical Battler of Northrend](https://www.wowhead.com/achievement=60953)
- [ ] 60954 - [Undead Battler of Northrend](https://www.wowhead.com/achievement=60954)
- [ ] 60956 - [Family Battler of Northrend](https://www.wowhead.com/achievement=60956) - Complete all ten Northrend family challenges; either faction.

Each Northrend trainer family challenge requires a team of level-25 pets of the named family.

### Cataclysm content (5)

- [ ] 6133 - [Maybe He'll Get Dizzy...](https://www.wowhead.com/achievement=6133) - Spine of Deathwing; complete the left-right-left-right roll sequence and defeat the encounter.
- [ ] 11754 - [Glamour of Twilight](https://www.wowhead.com/achievement=11754) - Collect a class armor set from The Bastion of Twilight and Blackwing Descent.
- [ ] 11755 - [Hot Couture](https://www.wowhead.com/achievement=11755) - Collect a Firelands class armor set.
- [ ] 11756 - [Wardrobe of the Old Gods](https://www.wowhead.com/achievement=11756) - Collect a Dragon Soul class armor set.
- [ ] 12079 - [Raiding with Leashes V: Cuteaclysm](https://www.wowhead.com/achievement=12079) - Collect the required Cataclysm raid pets.

### Mists of Pandaria content (9)

- [ ] 7359 - [Collector: Pandaren Game Boards](https://www.wowhead.com/achievement=7359) - Restore 20 Pandaren Game Boards; separate from the five-restoration achievement.
- [ ] 7413 - [Scarlet Halls](https://www.wowhead.com/achievement=7413) - Defeat Flameweaver Koegler in normal Scarlet Halls.
- [ ] 7933 - [And... It's Good!](https://www.wowhead.com/achievement=7933) - Fly through the discs above the Engine of Nalak'sha in Mogu'shan Vaults.
- [ ] 8028 - [Praise the Sun!](https://www.wowhead.com/achievement=8028) - Defeat Nalak on the Isle of Thunder.
- [ ] 10010 - [Gate of the Setting Sun](https://www.wowhead.com/achievement=10010) - Defeat Raigonn; normal dungeon completion.
- [ ] 10011 - [Siege of Niuzao Temple](https://www.wowhead.com/achievement=10011) - Defeat Wing Leader Ner'onok; normal dungeon completion.
- [ ] 11757 - [Sha of Fabulous](https://www.wowhead.com/achievement=11757) - Collect a class armor set from Heart of Fear and Terrace of Endless Spring.
- [ ] 11758 - [Thunderwear](https://www.wowhead.com/achievement=11758) - Collect a Throne of Thunder class armor set.
- [ ] 11759 - [Yaass'shaarj](https://www.wowhead.com/achievement=11759) - Collect a Siege of Orgrimmar class armor set.

### Classic Timewalking - recurring event availability (2)

These require Classic Timewalking to be active. Although listed under Anniversary Celebration on Wowhead, Classic Timewalking continues in the recurring Retail event rotation. [Retail Timewalking rotation](https://worldofwarcraft.blizzard.com/en-gb/news/24264422).

- [ ] 40998 - [A Timewalking Step Back to a Classic Dungeon Time](https://www.wowhead.com/achievement=40998) - Complete at least one listed Classic Timewalking dungeon.
- [ ] 41000 - [A Timewalking Journey Back to a Classic Dungeon Time](https://www.wowhead.com/achievement=41000) - Complete all six listed Classic Timewalking dungeon entries.

### Cup racing - recurring event availability (48)

The corresponding Cup event must be active for every achievement below. These are recurring Retail events with event-gated race NPCs. Use the in-game calendar for the next event window and preserve this availability requirement when implementing these entries.

#### Kalimdor Cup (12)

[Retail event and achievements](https://www.wowhead.com/guide/events/kalimdor-cup-skyriding-races). Includes old-world and Cataclysm zones such as Mount Hyjal and Uldum.

- [ ] 17712 - [Kalimdor: Bronze](https://www.wowhead.com/achievement=17712)
- [ ] 17713 - [Kalimdor: Silver](https://www.wowhead.com/achievement=17713)
- [ ] 17714 - [Kalimdor: Gold](https://www.wowhead.com/achievement=17714)
- [ ] 17715 - [Kalimdor Advanced: Bronze](https://www.wowhead.com/achievement=17715)
- [ ] 17716 - [Kalimdor Advanced: Silver](https://www.wowhead.com/achievement=17716)
- [ ] 17717 - [Kalimdor Advanced: Gold](https://www.wowhead.com/achievement=17717)
- [ ] 17718 - [Kalimdor Reverse: Bronze](https://www.wowhead.com/achievement=17718)
- [ ] 17719 - [Kalimdor Reverse: Silver](https://www.wowhead.com/achievement=17719)
- [ ] 17720 - [Kalimdor Reverse: Gold](https://www.wowhead.com/achievement=17720)
- [ ] 17721 - [Kalimdor Racing Completionist](https://www.wowhead.com/achievement=17721)
- [ ] 17722 - [Kalimdor Racing Completionist: Silver](https://www.wowhead.com/achievement=17722)
- [ ] 17723 - [Kalimdor Racing Completionist: Gold](https://www.wowhead.com/achievement=17723)

#### Eastern Kingdoms Cup (12)

[Retail event and achievements](https://www.wowhead.com/guide/events/eastern-kingdoms-cup-skyriding-races). Includes old-world and Cataclysm zones such as Twilight Highlands.

- [ ] 18566 - [Eastern Kingdoms: Bronze](https://www.wowhead.com/achievement=18566)
- [ ] 18567 - [Eastern Kingdoms: Silver](https://www.wowhead.com/achievement=18567)
- [ ] 18568 - [Eastern Kingdoms: Gold](https://www.wowhead.com/achievement=18568)
- [ ] 18569 - [Eastern Kingdoms Advanced: Bronze](https://www.wowhead.com/achievement=18569)
- [ ] 18570 - [Eastern Kingdoms Advanced: Silver](https://www.wowhead.com/achievement=18570)
- [ ] 18571 - [Eastern Kingdoms Advanced: Gold](https://www.wowhead.com/achievement=18571)
- [ ] 18572 - [Eastern Kingdoms Reverse: Bronze](https://www.wowhead.com/achievement=18572)
- [ ] 18573 - [Eastern Kingdoms Reverse: Silver](https://www.wowhead.com/achievement=18573)
- [ ] 18574 - [Eastern Kingdoms Reverse: Gold](https://www.wowhead.com/achievement=18574)
- [ ] 18939 - [Eastern Kingdoms Racing Completionist](https://www.wowhead.com/achievement=18939)
- [ ] 18940 - [Eastern Kingdoms Racing Completionist: Silver](https://www.wowhead.com/achievement=18940)
- [ ] 18942 - [Eastern Kingdoms Racing Completionist: Gold](https://www.wowhead.com/achievement=18942)

#### Outland / Burning Crusade Cup (12)

[Retail event and achievements](https://www.wowhead.com/guide/events/outland-cup-skyriding-races).

- [ ] 19092 - [Outland: Bronze](https://www.wowhead.com/achievement=19092)
- [ ] 19097 - [Outland: Silver](https://www.wowhead.com/achievement=19097)
- [ ] 19098 - [Outland: Gold](https://www.wowhead.com/achievement=19098)
- [ ] 19099 - [Outland Advanced: Bronze](https://www.wowhead.com/achievement=19099)
- [ ] 19100 - [Outland Advanced: Silver](https://www.wowhead.com/achievement=19100)
- [ ] 19101 - [Outland Advanced: Gold](https://www.wowhead.com/achievement=19101)
- [ ] 19102 - [Outland Reverse: Bronze](https://www.wowhead.com/achievement=19102)
- [ ] 19103 - [Outland Reverse: Silver](https://www.wowhead.com/achievement=19103)
- [ ] 19104 - [Outland Reverse: Gold](https://www.wowhead.com/achievement=19104)
- [ ] 19105 - [Outland Racing Completionist](https://www.wowhead.com/achievement=19105)
- [ ] 19106 - [Outland Racing Completionist: Silver](https://www.wowhead.com/achievement=19106)
- [ ] 19107 - [Outland Racing Completionist: Gold](https://www.wowhead.com/achievement=19107)

#### Northrend / Wrath Cup (12)

[Retail event and achievements](https://www.wowhead.com/guide/events/northrend-cup-skyriding-races).

- [ ] 19674 - [Northrend: Bronze](https://www.wowhead.com/achievement=19674)
- [ ] 19675 - [Northrend: Silver](https://www.wowhead.com/achievement=19675)
- [ ] 19676 - [Northrend: Gold](https://www.wowhead.com/achievement=19676)
- [ ] 19677 - [Northrend Advanced: Bronze](https://www.wowhead.com/achievement=19677)
- [ ] 19679 - [Northrend Advanced: Silver](https://www.wowhead.com/achievement=19679)
- [ ] 19681 - [Northrend Advanced: Gold](https://www.wowhead.com/achievement=19681)
- [ ] 19682 - [Northrend Reverse: Bronze](https://www.wowhead.com/achievement=19682)
- [ ] 19683 - [Northrend Reverse: Silver](https://www.wowhead.com/achievement=19683)
- [ ] 19684 - [Northrend Reverse: Gold](https://www.wowhead.com/achievement=19684)
- [ ] 19721 - [Northrend Racing Completionist](https://www.wowhead.com/achievement=19721)
- [ ] 19722 - [Northrend Racing Completionist: Silver](https://www.wowhead.com/achievement=19722)
- [ ] 19723 - [Northrend Racing Completionist: Gold](https://www.wowhead.com/achievement=19723)
