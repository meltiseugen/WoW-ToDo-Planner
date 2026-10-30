"""Apply the researched Legion map destinations and acquisition guides."""
import copy
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
path = ROOT / "Data/Sources/CuratedSources.json"
curated = json.loads(path.read_text(encoding="utf-8"))
entities = json.loads((ROOT / ".local/legion-research-entities.json").read_text(encoding="utf-8"))
evidence = json.loads((ROOT / ".local/legion-source-evidence.json").read_text(encoding="utf-8"))
ATT = "https://github.com/ATTWoWAddon/AllTheThings/blob/f8113a527789bf361e070d7cde94d1f57a22b2b8/db/Standard/Categories/"
WH = "https://www.wowhead.com/"
additions = {"pets": {}, "toys": {}, "cosmetics": {}}


def source(name, instructions, coords=None, npc=None, npc_name=None, references=(), **fields):
    record = {
        "kind": "Professions", "sourceName": name,
        "coords": coords or [], "maps": [], "instructions": instructions,
        "references": list(references) + [ATT + "Professions.lua"],
        "reviewedAt": "2026-10-30",
    }
    if npc:
        record["npcID"] = npc
        record["npcName"] = npc_name
    record.update(fields)
    return record


def npc_coords(identity, map_id):
    return [point for point in entities["npcs"][str(identity)] if point[0] == map_id]


def add(kind, identity, record):
    additions[kind][str(identity)] = record if isinstance(record, list) else [record]


# Enchanting pets: the two vendor recipes share the Pen quest's shop unlock.
for identity, name, recipe_item in ((1699, "Enchanted Cauldron", 128621), (1700, "Enchanted Torch", 128622)):
    add("pets", identity, source(
        "Legion Enchanting - Tigrid the Charmer's formula",
        f"Learn Legion Enchanting and follow Enchanter Nalthanis's profession quests in Broken Isles Dalaran (38.3, 40.3) until An Enchanting Home. Visit Tigrid the Charmer in Stormheim (39.4, 42.6), complete A Touch of Magic, then Halls of Valor: Revenge of the Enchantress. Recover her rod in Halls of Valor and return it to unlock her shop. Buy Formula: {name} for 50 Arkhana, learn it and craft the pet. Alternatively, buy the crafted pet or a caged copy from another player or the Auction House.",
        npc_coords(98367, 634), 98367, "Tigrid the Charmer",
        [WH + f"item={recipe_item}", WH + "npc=98367/tigrid-the-charmer", WH + "quest=39904"],
        unlockQuestID=39904, locationType="Enchanting formula vendor",
        # This is the price of the formula, not a direct pet purchase.
        cost=[["i", 124440, 50]],
    ))
add("pets", 1701, source(
    "Legion Enchanting - Halls of Valor: Revenge of the Enchantress",
    "Learn Legion Enchanting and progress Enchanter Nalthanis's profession story in Broken Isles Dalaran (38.3, 40.3) until An Enchanting Home. Visit Tigrid the Charmer in Stormheim (39.4, 42.6), complete A Touch of Magic, and accept Halls of Valor: Revenge of the Enchantress. Recover Tigrid's Enchanting Rod in Halls of Valor and return it to her to learn Enchanted Pen. Craft the pet with the learned recipe, or buy a crafted/caged copy on the Auction House. The map follows the first unfinished prerequisite; the quest rewards the recipe, not the finished pet.",
    npc_coords(98367, 634), 98367, "Tigrid the Charmer",
    [WH + "quest=39904", WH + "item=128535/enchanted-pen"],
    progressQuestID=39904, locationType="Enchanting recipe quest",
))

# These are Legion's Pulsating/Growling Sacs, not the BfA Quivering Sac.
for identity, name in ((1756, "Ridgeback Piglet"), (1759, "Thaumaturgical Piglet"), (1920, "Transmutant")):
    add("pets", identity, source(
        "Legion Alchemy - Transmute: Meat to Pet / Growling Sac",
        f"Learn Legion Alchemy from Deucus Valdera in Broken Isles Dalaran (41.3, 33.4). Complete the alchemy-station quest chain through Return the Filter, then buy Recipe: Wild Transmutation from Patricia Egan in the same shop (42.2, 32.3). Perform Wild Transmutation at the Dalaran Alchemy Station each day until you discover Transmute: Meat to Pet. Use that recipe to make a Pulsating Sac and wait 7 real-time days for it to become a Growling Sac. Open it for a random pet; {name} is one possible result. Repeat if needed, or buy a caged {name} on the Auction House.",
        npc_coords(92457, 627), 92457, "Patricia Egan",
        [WH + "spell=213256/transmute-meat-to-pet", WH + "item=137599/pulsating-sac", WH + "quest=39338/return-the-filter"],
        unlockQuestID=39338, locationType="Wild Transmutation recipe / Dalaran Alchemy Station",
    ))

add("pets", 1886, source(
    "Legion Engineering - Halls of Valor: Trigger Happy",
    "Learn Legion Engineering in Broken Isles Dalaran and follow the engineering story until Hobart Grapplehammer offers Halls of Valor: Trigger Happy. Accept it at the engineering shop (38.4, 24.7), defeat Odyn in Halls of Valor and loot the Runestone of Vitality. Return to Hobart to learn Trigger. Craft it at Legion Engineering 90 with 50 Leystone Ore, 30 Loose Trigger, 20 Oversized Blasting Cap, 2 Sniping Scope, 50 Blood of Sargeras and 10 Infernal Brimstone. You can instead buy a caged Trigger from another player or the Auction House without Engineering.",
    npc_coords(93539, 627), 93539, "Hobart Grapplehammer",
    [WH + "quest=40877/halls-of-valor-trigger-happy", WH + "guide/legion-engineering", WH + "item=132519/trigger"],
    progressQuestID=40877, locationType="Trigger engineering recipe quest",
))
add("pets", 1806, source(
    "Blingtron 6000 Gift Package - portable daily gift / Reaves engineering unlock",
    "Accept Blingtron 6000's daily gift quest and open the Blingtron 6000 Gift Package for a chance at Knockoff Blingtron. Another player's Blingtron works; it is portable and has no permanent spawn. To summon your own, progress Legion Engineering with Didi the Wrench in Broken Isles Dalaran (38.6, 25.0), complete Short Circuit and Oil Rags to Riches, craft Reaves Module: Bling Mode and install it on Reaves. Summon Reaves with a battery and choose Bling Mode. The marker follows this engineering unlock route, not a fixed Blingtron spawn. Alternatively, buy a caged pet on the Auction House.",
    [[627, 38.6, 25.0]], 93520, "Didi the Wrench",
    [WH + "item=132892/blingtron-6000-gift-package", WH + "quest=40881/oil-rags-to-riches", WH + "guide/legion-engineering"],
    unlockQuestID=40881, containerItemID=132892,
    locationType="Optional engineering unlock for your own portable Blingtron",
))
add("pets", 2117, source(
    "Legion Herbalism - herb nodes on Argus",
    "Learn Legion Herbalism, unlock Argus through The Hand of Fate and follow the Argus campaign to open its zones. Gather herbs in Krokuun, Antoran Wastes or Eredath: Fel-Encrusted Herb nodes and Astral Glory can yield Fel Lasher. Keep gathering; this is a rare bonus from harvesting herbs, not a wild pet you trap or a stationary creature drop. The map opens the actual gathering zones because herb nodes move and respawn. You can also buy a caged Fel Lasher from another player or the Auction House.",
    references=[WH + "npc=128137/fel-lasher", WH + "guide/legion-herbalism", ATT + "Craftables.lua"],
    maps=[830, 885, 882], locationType="Argus herb gathering areas",
))
add("pets", 2121, source(
    "Legion Skinning - skinnable creatures on Argus",
    "Learn Legion Skinning and unlock Argus through The Hand of Fate. Kill and skin beasts on Argus for a rare chance at Fossorial Bile Larva; the pet comes from skinning, not their normal loot or pet battles. One reported farm is Chitinbuk Ruinwalkers in Eredath around 52.0, 35.0. Panthara in Krokuun's Petrified Forest and other skinnable Argus beasts are alternatives. Keep skinning until the pet drops, or buy a caged copy on the Auction House. The marker is a farming area, not a guaranteed pet spawn; Fiendish Leather ranks improve material yield but a particular rank is not established as a pet requirement.",
    [[882, 52.0, 35.0]],
    references=[WH + "item=153057/fossorial-bile-larva", WH + "guide/legion-skinning", ATT + "Craftables.lua"],
    maps=[830, 885, 882], locationType="Chitinbuk skinning farm - rare bonus, not a pet spawn",
))

add("toys", 132518, source(
    "Legion Engineering - Short Circuit",
    "Progress the Legion Engineering story with Didi the Wrench in Broken Isles Dalaran (38.6, 25.0) until Short Circuit. Follow its investigation: Rocket-Chief Fuselage in Area 52, Ricket in K3, Chief Engineer Foote in Ratchet, Nixx Sprocketspring in Gadgetzan, then Winkey in eastern Tanaris. Borrow Winkey's Diving Helmet and find Gnopetto's underwater workshop and journal off Tanaris. This teaches Blingtron's Circuit Design Tutorial. Craft the toy with 50 Leystone Ore, 50 Felslate and 5 Infernal Brimstone, then use it to add it to the Toy Box. Alternatively, buy the finished toy on the Auction House; using it does not require Engineering.",
    [[627, 38.6, 25.0]], 93520, "Didi the Wrench",
    [WH + "quest=40880/short-circuit", WH + "guide/legion-engineering", WH + "item=137692"],
    progressQuestID=40880, locationType="Engineering recipe quest chain",
))
add("toys", 130254, source(
    "Legion Jewelcrafting - Mysteries of Nature",
    "Begin Legion Jewelcrafting with Tiffany Cartier in Broken Isles Dalaran (39.9, 34.8) and follow her profession story through Come at Me, Brul and The Charge Within. Jabrul in Stormheim (42.2, 35.0) offers Mysteries of Nature: collect Dragon Glass from the mountainside at 46.7, 31.3 and return it to learn Chatterstone. Craft it with 10 Sangrite, 10 Chaotic Spinel and 1 Blood of Sargeras, then use it to collect the toy. You can also buy the finished toy from another player or the Auction House without Jewelcrafting.",
    [[634, 42.2, 35.0]], 100499, "Jabrul",
    [WH + "quest=40546/mysteries-of-nature", WH + "spell=195883/chatterstone"],
    progressQuestID=40546, locationType="Jabrul - Chatterstone recipe quest",
))
add("toys", 130251, source(
    "Legion Jewelcrafting - Socket to Me",
    "Follow Tiffany Cartier's Legion Jewelcrafting story through To Dalaran, With Love, then inspect the toy box in the Dalaran jewelry shop (40.0, 35.3) to accept Socket to Me. Collect Crystal Shell from the Truesilver Crab in the Northern Stranglethorn wreck (35.7, 55.9), Crystal Core in Deepholm (51.9, 20.7), Crystal Scale in Twilight Highlands (26.0, 69.7), Crystal Heart from the Golden Hare in Vale of Eternal Blossoms (14.2, 67.2), Crystal Plume in Moonglade (31.0, 47.7), and Crystal Shard inside Highmountain's Greystone Enclave (entrance 54.5, 75.4). Return the components to learn JewelCraft, craft the toy and use it. Buying the finished toy on the Auction House skips the profession chain.",
    [[627, 40.0, 35.3]],
    references=[WH + "quest=40558/socket-to-me", WH + "guide/legion-jewelcrafting"],
    progressQuestID=40558, locationType="Toy box - Socket to Me quest start",
))

for identity, name, price in ((129961, "Flaming Hoop", 100), (129958, "Leather Pet Leash", 50)):
    add("toys", identity, source(
        f"Legion Leatherworking - Pattern: {name} / Laura Malley",
        f"Learn Legion Leatherworking, then buy Pattern: {name} from Laura Malley in the Broken Isles Dalaran Underbelly (58.0, 58.1) for {price} Sightless Eyes. Earn the currency from Underbelly activities and rare creatures; check whether the sewer guards are present before entering its PvP areas. Learn the pattern, craft {name} and use the finished item to add it to the Toy Box. The marker is Laura's recipe shop, not a direct toy purchase. Alternatively, buy the finished toy on the Auction House; Leatherworking is not needed to use it.",
        npc_coords(97364, 628), 97364, "Laura Malley",
        [WH + "npc=97364/laura-malley", WH + "guide/legion-leatherworking"],
        cost=[["c", 1149, price]], locationType="Leatherworking pattern vendor",
    ))
add("toys", 129956, source(
    "Legion Leatherworking - Pattern: Leather Love Seat / Xur'ios",
    "Visit Xur'ios beside the bank in Broken Isles Dalaran (48.8, 13.5) and check his rotating stock for Pattern: Leather Love Seat, priced at 1 Curious Coin. Return on another day if the pattern is absent. Curious Coins are rare rewards from Broken Isles treasures, rare creatures and other Legion reward containers. Learn the pattern with Legion Leatherworking, craft Leather Love Seat and use the finished toy. You can instead buy the finished toy from another player or the Auction House without Leatherworking.",
    npc_coords(107109, 627), 107109, "Xur'ios",
    [WH + "item=137935/pattern-leather-love-seat", WH + "npc=107109/xurios"],
    cost=[["c", 1275, 1]], locationType="Rotating Leather Love Seat pattern vendor",
))
add("toys", 129960, source(
    "Legion Leatherworking - Playthings / Namha Moonwater",
    "Begin Legion Leatherworking with Namha Moonwater in Broken Isles Dalaran (35.4, 29.6), starting with Skin Deep. Follow her story through Dazed of the Past and Battle Bonds, then accept Playthings. Collect the tanning mixture from the red bottle on the workbench behind Namha. Use the quest workbench recipes in order: 8 Shaved Stonehide Pelts, 8 Tanned Stonehide Leather, 2 Stonehide Leather Linings, 5 Stonehide Leather Strips, then the prototype Stonehide Leather Bed. Turn it in to learn Leather Pet Bed, craft the collectible with 50 Stonehide Leather and 5 Felhide, and use it. Alternatively, buy the finished toy on the Auction House.",
    npc_coords(93523, 627), 93523, "Namha Moonwater",
    [WH + "quest=40201/playthings", WH + "spell=194776/leather-pet-bed"],
    progressQuestID=40201, locationType="Leather Pet Bed recipe quest / Namha's Workbench",
))
add("toys", 128536, source(
    "Legion Enchanting - Formula: Leylight Brazier / K'huta",
    "Buy Formula: Leylight Brazier from K'huta in the Broken Isles Dalaran Underbelly (66.0, 79.9) for 250 Sightless Eyes. Gather the currency from Underbelly activities and rare creatures. Learn the formula with Legion Enchanting, then craft Leylight Brazier with 1 Chaos Crystal, 100 Arkhana and 5 Blood of Sargeras. Use the finished item to add it to the Toy Box. The marker identifies the formula vendor. You can instead buy the finished toy from another player or the Auction House without Enchanting.",
    npc_coords(97363, 628), 97363, "K'huta",
    [WH + "item=128625/formula-leylight-brazier", WH + "spell=191078/leylight-brazier"],
    cost=[["c", 1149, 250]], locationType="Leylight Brazier enchanting formula vendor",
))
novel_common = (
    "Learn Legion Inscription from Professor Pallin in Broken Isles Dalaran (41.3, 37.0) and progress the profession story until An Embarrassing Revelation. Bring him the Steamy Romance Novel and accept The Plot Thickens. "
)
novel_sources = []
for faction, quest, author, npc, coords in (
    ("Alliance", 39956, "Bill Spearshaker", 97762, [87, 77.2, 10.4]),
    ("Horde", 39960, "Ferdinand Serbacon", 97766, [90, 77.8, 38.8]),
):
    place = "Ironforge" if faction == "Alliance" else "Undercity"
    guide = novel_common + f"Find {author} in {place} ({coords[1]}, {coords[2]}) and complete The Legacy Passed On by interacting with the unfinished book and choosing a complete story. This teaches Steamy Romance Novel Kit; craft the toy and use it to collect it. "
    if faction == "Horde":
        guide += "If Undercity is in its destroyed phase, ask Zidormi in Tirisfal Glades to show the city before the Battle for Lordaeron. "
    guide += "The finished toy is tradable, so buying it on the Auction House skips Inscription and its quest chain."
    novel_sources.append(source(
        f"Legion Inscription - The Legacy Passed On / {author}", guide, [coords], npc, author,
        [WH + f"quest={quest}/the-legacy-passed-on", WH + "guide/legion-inscription"],
        faction=faction, progressQuestID=quest, locationType="Steamy Romance Novel Kit recipe quest",
    ))
add("toys", 129211, novel_sources)

# Vendor-specific profiles preserve sharing across the 149 obtainable wrappers.
vendors = {
    "Gladiator": (54650, "Kezzik the Striker", 109, "Area 52, Netherstorm"),
    "Merciless Gladiator": (107599, "Izzee the 'Clutch'", 109, "Area 52, Netherstorm"),
    "Vengeful Gladiator": (107610, "Kitzie Crankshot", 109, "Area 52, Netherstorm"),
    "Brutal Gladiator": (107619, "Blaze Magmaburn", 109, "Area 52, Netherstorm"),
    "Savage Gladiator": (40212, "Trapjaw Rix", 126, "the Northrend Dalaran sewers"),
    "Hateful Gladiator": (30885, "Blazik Fireclaw", 126, "the Northrend Dalaran sewers"),
    "Deadly Gladiator": (69321, "Herwin Steampop", 126, "the Northrend Dalaran sewers"),
    "Furious Gladiator": (69318, "Kylo Kelwin", 126, "the Northrend Dalaran sewers"),
    "Relentless Gladiator": (69973, "Zom Bocom", 126, "the Northrend Dalaran sewers"),
    "Wrathful Gladiator": (69971, "Xazi Smolderpipe", 126, "the Northrend Dalaran sewers"),
    "Bloodthirsty Gladiator": (20278, "Vixton Pinchwhistle", 71, "Gadgetzan, Tanaris"),
    "Vicious Gladiator": (40216, "Blazzek the Biter", 71, "Gadgetzan, Tanaris"),
    "Ruthless Gladiator": (69323, "Tiny Tayger", 71, "Gadgetzan, Tanaris"),
    "Cataclysmic Gladiator": (69322, "Capps Carlin", 71, "Gadgetzan, Tanaris"),
}
groups = defaultdict(list)
for key, name in evidence["names"].items():
    if not key.startswith("cosmetics:"):
        continue
    identity = int(key.split(":")[1])
    if identity == 146651:
        continue
    item_type, family = name.split(": ", 1)
    family = family.split("'s ")[0]
    groups[(item_type, family)].append(identity)

profile_names = set()
for (item_type, family), identities in sorted(groups.items()):
    npc, npc_name, map_id, location = vendors[family]
    coords = npc_coords(npc, map_id)
    point = coords[0]
    price = 80 if item_type == "Arsenal" else 12
    item_kind = "weapon arsenal" if item_type == "Arsenal" else "armor ensemble"
    guide = f"Collect {price} Marks of Honor from PvP reward containers, then visit {npc_name} in {location} ({point[1]}, {point[2]}). Buy the {family} {item_kind} for {price} Marks of Honor and use the purchased wrapper to add its appearances to your collection. "
    if item_type == "Ensemble":
        guide += "Choose the ensemble for the class shown in the item tooltip and check which appearances you already know before spending the marks. These are the regular legacy sets; the old seasonal rating is not required. "
    else:
        guide += "The arsenal teaches the season's weapon appearances, including weapon types your current character cannot equip. Buying only individual weapons can cost fewer marks if you want a small subset. "
    if map_id == 126:
        guide += "Travel to Dalaran in Crystalsong Forest, Northrend, and descend into its sewers; these vendors are not in Broken Isles Dalaran. "
    elif map_id == 109:
        guide += "The vendor is inside the PvP-vendor building in Area 52 in Outland. "
    elif map_id == 71:
        guide += "This Gadgetzan vendor serves both factions. "
    if item_type == "Arsenal" and family == "Merciless Gladiator":
        guide += "This current arsenal also grants the original Gladiator Season 1 weapon appearances; the separate Gladiator's Weapons wrapper was retired."
    refs = [WH + f"npc={npc}", WH + f"item={min(identities)}", WH + "achievement=11719/its-not-fashion-unless-it-hurts", ATT + "Zones.lua", ATT + "PVP.lua"]
    if family == "Bloodthirsty Gladiator":
        refs.append("https://warcraft.wiki.gg/wiki/Ensemble%3A_Bloodthirsty_Gladiator%27s_Chain_Armor")
    record = source(
        f"{npc_name} - {family} {item_kind}", guide.strip(), coords, npc, npc_name, refs,
        kind="Vendor", cost=[["i", 137642, price]], locationType=f"{family} {item_kind} vendor",
    )
    profile = "legion_legacy_" + re.sub(r"[^a-z0-9]+", "_", family.lower()) + "_" + item_type.lower()
    curated.setdefault("profiles", {})[profile] = [record]
    profile_names.add(profile)
    for identity in identities:
        additions["cosmetics"][str(identity)] = [record]
    curated.setdefault("groups", [])[:] = [g for g in curated["groups"] if g.get("profile") != profile]
    curated["groups"].append({"type": "cosmetics", "ids": sorted(identities), "profile": profile})

add("cosmetics", 146651, source(
    "Retired wrapper - replaced by Arsenal: Merciless Gladiator's Weapons",
    "This separate Gladiator's Weapons wrapper was retired in patch 7.2.5. Collect its weapon appearances through Arsenal: Merciless Gladiator's Weapons from Izzee the 'Clutch' in Area 52, Netherstorm, for 80 Marks of Honor. Keep this historical record out of the collection guide UI.",
    references=[WH + "item=146651/arsenal-gladiators-weapons", "https://warcraft.wiki.gg/wiki/Arsenal%3A_Gladiator%27s_Weapons"],
    kind="Unavailable", availability={
        "kind": "Removed", "reason": "The separate wrapper was retired in 7.2.5; its appearances are included in Arsenal: Merciless Gladiator's Weapons.",
        "reviewedAt": "2026-10-30", "sourceUrl": WH + "item=146651/arsenal-gladiators-weapons",
        "replacementItemID": 146650,
    },
))

# Per-item overrides take precedence over profile groups in the importer.
for kind, records in additions.items():
    target = curated.setdefault("collections", {}).setdefault(kind, {})
    for identity, sources in records.items():
        if kind == "cosmetics" and identity != "146651":
            target.pop(identity, None)
        else:
            target[identity] = sources

if {kind: len(rows) for kind, rows in additions.items()} != {"pets": 10, "toys": 9, "cosmetics": 150}:
    raise RuntimeError("The researched target list changed")
path.write_text(json.dumps(curated, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
(ROOT / ".local/legion-researched-sources.json").write_text(json.dumps(additions, indent=2), encoding="utf-8")
print("Applied 10 pet guides, 9 toy guides, 149 cosmetic guides and 1 retired-wrapper exclusion.")
print(f"Cosmetic sources share {len(profile_names)} vendor/season profiles.")
