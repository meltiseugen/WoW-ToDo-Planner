"""Populate TBC content views from reviewed current-retail achievement sources."""
import html
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

from lupa.lua51 import LuaRuntime

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from description_map_support import load_context

evidence = json.loads((ROOT / ".local/burning-crusade-achievement-evidence.json").read_text(encoding="utf-8"))
metadata = json.loads((ROOT / ".local/burning-crusade-achievement-metadata.json").read_text(encoding="utf-8"))
lua = LuaRuntime(unpack_returned_tuples=True)
namespace, _, _ = load_context(lua)
catalog = namespace.PatchCatalog

# The original seasons ended, but their ordinary appearance sets remain sold
# by the legacy PvP vendors. The parent's retirement flag is not an achievement
# retirement flag for these later transmog achievements.
obtainable_legacy_ensembles = {11706, 11707, 11708, 11709}
excluded = {}
selected = {}
for key, paths in evidence.items():
    identity = int(key)
    if identity == 964:
        excluded[key] = "Going Down? is a general falling achievement; Shattrath is only one possible location."
        continue
    active = [record for record in paths if not any(
        node.get("u") in (1, 2) or node.get("rwp", 999999) <= 120105
        for node in record["path"]
    )]
    if not active and identity not in obtainable_legacy_ensembles:
        excluded[key] = "Original seasonal or removed-content achievement; no current acquisition source."
        continue
    selected[identity] = active or paths

instance_names = {
    247: "Auchenai Crypts", 248: "Hellfire Ramparts", 249: "Magisters' Terrace",
    250: "Mana-Tombs", 251: "Old Hillsbrad Foothills", 252: "Sethekk Halls",
    253: "Shadow Labyrinth", 254: "The Arcatraz", 255: "The Black Morass",
    256: "The Blood Furnace", 257: "The Botanica", 258: "The Mechanar",
    259: "The Shattered Halls", 260: "The Slave Pens", 261: "The Steamvault",
    262: "The Underbog", 745: "Karazhan", 746: "Gruul's Lair",
    747: "Magtheridon's Lair", 748: "Serpentshrine Cavern",
    749: "The Battle for Mount Hyjal", 750: "Tempest Keep: The Eye",
    751: "Black Temple", 752: "Sunwell Plateau",
}
instance_coords = {}
for records in selected.values():
    for record in records:
        for node in record["path"]:
            if node.get("instanceID") and node.get("coords"):
                instance_coords.setdefault(node["instanceID"], node["coords"])

patch_overrides = {
    868: "2.4", 897: "2.4", 905: "2.4", 1800: "2.4", 1801: "2.4",
    883: "2.1", 894: "2.1", 896: "2.1", 898: "2.1", 958: "2.1",
    1275: "2.1", 1276: "2.1", 1638: "2.1", 9824: "2.4",
    877: "2.3", 906: "2.3", 11707: "2.1", 11708: "2.3", 11709: "2.4",
    11748: "2.1", 11749: "2.4",
}
reputations = {763, 764, 893, 894, 896, 897, 898, 899, 900, 901, 902, 903, 953, 958, 959, 960, 1205}
quest_achievements = {1189, 1190, 1191, 1192, 1193, 1194, 1195, 1262, 1271, 1272, 1273, 4908, 4926, 939}
pet_battles = {6587, 6604, 6614, 62460, *range(62466, 62476)}
collections = {426, 725, 726, 882, 883, 884, 885, 893, 1165, 8293, 9824, *range(11706, 11710), *range(11746, 11750)}


def content_patch(identity, records):
    if identity in patch_overrides:
        return patch_overrides[identity]
    for record in records:
        for node in reversed(record["path"]):
            if node.get("instanceID") and node.get("awp", 0) in range(20000, 20500):
                return "2." + str((node["awp"] // 100) % 100)
    return "2.0"


def first_instance(records):
    for record in records:
        for node in reversed(record["path"]):
            if node.get("instanceID"):
                return node["instanceID"]


def category_for(identity, records):
    if identity in reputations:
        return "Reputation"
    if identity in quest_achievements:
        return "Quests"
    if identity in pet_battles:
        return "Pet Battles"
    if identity in collections:
        return "Collections"
    name = metadata[str(identity)]["name"]
    if name.startswith("Explore ") or identity in (44, 1311, 1312):
        return "Exploration"
    if identity == 1286:
        return "Raids"
    if identity in (1284, 1287):
        return "Dungeons"
    instance = first_instance(records)
    if instance:
        return "Raids" if instance >= 745 else "Dungeons"
    if any(r["category"] == "Professions" for r in records) or identity in (733, 18721, 18729):
        return "Professions"
    return "Quests"


def goal(identity):
    tooltip = metadata[str(identity)]["tooltip"]
    body = re.split(r"<br\s*/?>", tooltip, maxsplit=1)[-1]
    body = re.split(r"<br\s*/?>|</td>", body, maxsplit=1)[0]
    return " ".join(html.unescape(re.sub("<[^>]+>", " ", body)).split())


def waypoints_for_instances(instance_ids):
    return [f"/way #{mid} {x} {y} {instance_names[i]} entrance"
            for i in instance_ids for mid, x, y in instance_coords.get(i, [])]


def build_detail(identity, records, category):
    name = metadata[str(identity)]["name"]
    instance = first_instance(records)
    detail = {
        "name": name, "acquisition": goal(identity), "sourceType": "Achievement",
        "source": "Burning Crusade " + category.lower(),
        "sourceURL": f"https://www.wowhead.com/achievement={identity}",
    }
    if category in ("Dungeons", "Raids") and instance:
        place = instance_names[instance]
        if name.startswith("Heroic:"):
            detail["acquisition"] = f"Set dungeon difficulty to Heroic before entering the original {place}. " + goal(identity) + " Finish the encounter and check that its criterion has registered before leaving."
        else:
            detail["acquisition"] = f"Enter the original Burning Crusade version of {place}. " + goal(identity) + " Defeat the required encounter in that instance; a later remake or timewalking raid with a different map is a separate activity."
        detail["source"] = place
        detail["waypoints"] = waypoints_for_instances([instance])
    elif identity in (1284, 1287, 1286):
        ids = range(745, 753) if identity == 1286 else range(247, 263)
        detail["acquisition"] = (
            "Clear the eight original Burning Crusade raids: Karazhan, Gruul's Lair, Magtheridon's Lair, Serpentshrine Cavern, Tempest Keep, the Battle for Mount Hyjal, Black Temple and Sunwell Plateau. The original Zul'Aman raid is no longer required."
            if identity == 1286 else
            "Defeat the final encounter in each of the 16 original Burning Crusade five-player dungeons, including Magisters' Terrace. "
            + ("Set every dungeon to Heroic before entering; Normal clears do not count for this meta." if identity == 1287 else "Normal or Heroic clears credit this meta. Track its child achievements to identify the remaining dungeons.")
        )
        detail["waypoints"] = waypoints_for_instances(ids)
    elif identity in (11746, 11747, 11748, 11749):
        instances = {11746: [745, 746, 747], 11747: [748, 750], 11748: [751], 11749: [752]}[identity]
        detail["acquisition"] = goal(identity) + " Run those original raids on the class whose set you want, loot its tier tokens and exchange them for the matching armor pieces. Learn each missing appearance; repeat after the weekly raid reset for tokens you still need."
        detail["waypoints"] = waypoints_for_instances(instances)
        detail["source"] = " / ".join(instance_names[i] for i in instances)
    elif identity in obtainable_legacy_ensembles:
        npc, family = {11706: ("Kezzik the Striker", "Gladiator"), 11707: ("Izzee the 'Clutch'", "Merciless Gladiator"),
                       11708: ("Kitzie Crankshot", "Vengeful Gladiator"), 11709: ("Blaze Magmaburn", "Brutal Gladiator")}[identity]
        detail["acquisition"] = f"Collect 12 Marks of Honor and visit {npc} inside the PvP-vendor building in Area 52, Netherstorm (33.0, 64.2). Buy the {family} armor ensemble for your class and use it to learn the full set. These regular legacy appearances can still be collected; the original season's Gladiator title or rating is not required."
        detail["source"] = npc + " / Area 52"
        detail["waypoints"] = [f"/way #109 33.0 64.2 {npc} - {family} armor ensemble"]
    elif category == "Exploration":
        detail["acquisition"] = goal(identity) + (
            " Visit every required subzone until each exploration criterion is credited; revealing only the main zone name is not enough."
            if identity not in (1311, 1312) else
            " Travel between the Outland rare-creature spawn areas and kill the required rares. Spawns are shared and may be absent; return on another pass and track the remaining named criteria."
        )
    elif category == "Quests":
        detail["acquisition"] = goal(identity) + " Follow the zone's quest chains and track the named story criteria. Use a character eligible for the faction's version; reputation or bonus objectives do not replace unfinished storylines."
    elif category == "Reputation":
        detail["acquisition"] = goal(identity) + " Earn reputation through the faction's Outland quests, associated dungeons and repeatable turn-ins. Track each required faction separately; tabards from later expansions do not grant these reputations."
    elif category == "Pet Battles":
        detail["acquisition"] = goal(identity) + (
            " Find each listed species in its Outland habitat, weaken it in a wild pet battle and capture it with a trap. Defeating a wild pet without capturing it does not add that species to your collection."
            if identity == 6587 else
            " Track the named Outland trainer and team-family criteria. Bring pets with the required family and level, and win each listed battle; a team that breaks the stated family restriction will not credit the family achievements."
        )
    elif category == "Professions":
        detail["acquisition"] = goal(identity) + " Learn the Outland tier of the relevant profession and use Outland recipes or gathering materials. Skill in a different expansion's profession tier does not credit the Outland requirement."

    # Authored directions take precedence; otherwise retain all previously
    # researched locations, which are keyed by achievement ID, across content views.
    if not detail.get("waypoints"):
        detail.pop("waypoints", None)
    return detail


buckets = defaultdict(list)
for identity, records in sorted(selected.items()):
    patch = content_patch(identity, records)
    category = category_for(identity, records)
    buckets[patch].append((identity, category, build_detail(identity, records, category)))

def lua_string(value):
    return json.dumps(value, ensure_ascii=False)

for patch in ("2.0", "2.1", "2.2", "2.3", "2.4"):
    records = buckets[patch]
    lines = ["local _, TDP = ...", "",
             "-- Group retroactive achievements with the content they guide.",
             "-- The achievement system arrived later; the original release records",
             "-- remain intact so saved favorites and old patch links keep working.",
             f'TDP.CatalogRegistry:RegisterCollection("{patch}", "achievements", {{',
             "    entries = {", "        ids = {"]
    lines += [f"            {identity}, -- {detail['name']}" for identity, _, detail in records]
    lines += ["        },", "        rewardHighlights = {},", "    },", "    details = {"]
    for identity, _, detail in records:
        lines.append(f"        [{identity}] = {{")
        for field, value in detail.items():
            if field == "waypoints":
                lines.append("            waypoints = { " + ", ".join(map(lua_string, value)) + " },")
            else:
                lines.append(f"            {field} = {lua_string(value)},")
        lines.append("        },")
    lines += ["    },", "    categories = {"]
    lines += [f"        [{identity}] = {lua_string(category)}," for identity, category, _ in records]
    lines += ["    },", "})", ""]
    (ROOT / f"Data/Expansions/BurningCrusade/{patch}/Achievements.lua").write_text("\n".join(lines), encoding="utf-8")

report = ["# Burning Crusade achievements", "",
          "Retail achievements grouped by the Burning Crusade content they describe. Original introduction-patch records are retained for saved favorites and existing links.", "",
          "| Content patch | Achievements |", "| --- | ---: |"]
report += [f"| {patch} | {len(buckets[patch])} |" for patch in ("2.0", "2.1", "2.2", "2.3", "2.4")]
report += ["", "| ID | Achievement | Content patch | Category |", "| ---: | --- | --- | --- |"]
for patch in sorted(buckets):
    report += [f"| {identity} | {detail['name']} | {patch} | {category} |" for identity, category, detail in buckets[patch]]
report += ["", "Sources: [AllTheThings content hierarchy](https://github.com/ATTWoWAddon/AllTheThings/tree/f8113a527789bf361e070d7cde94d1f57a22b2b8/db/Standard/Categories), current Wowhead retail achievement tooltips.",
           "", "Excluded from the added content views:", ""]
report += [f"- {metadata[identity]['name']} ({identity}): {reason}" for identity, reason in excluded.items()]
(ROOT / ".local/burning-crusade-achievement-update.md").write_text("\n".join(report) + "\n", encoding="utf-8")
print("Burning Crusade content achievements:", {patch: len(rows) for patch, rows in buckets.items()})
print("Total:", len(selected), "; categories:", dict(Counter(category for rows in buckets.values() for _, category, _ in rows)))
