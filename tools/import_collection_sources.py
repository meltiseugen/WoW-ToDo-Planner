# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Build a bounded collection-source index from a pinned MIT-licensed ATT snapshot.

Run with --download once, then repeat offline using the same cache directory.
Only collection IDs already in TODO-Planner and their quest prerequisites are exported.
External Lua is evaluated with data constructors in an environment without OS, file,
network, addon, or Python access. Only database-build handlers run; gameplay
callbacks are never invoked.
"""
from __future__ import annotations

import argparse
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import tempfile
from urllib.request import urlopen

from lupa.lua51 import LuaRuntime, lua_type

from catalog_support import ROOT, load_catalog

REVISION = "f8113a527789bf361e070d7cde94d1f57a22b2b8"
CURRENT_PATCH = 120105  # The newest catalog patch is 12.1.5.
REPOSITORY = "https://github.com/ATTWoWAddon/AllTheThings"
CATEGORIES = ["Zones", "Instances", "Craftables", "Professions", "ExpansionFeatures",
              "Delves", "Secrets", "WorldDrops", "WorldEvents", "PVP", "BlackMarket",
              "InGameShop", "Promotions", "TradingPost", "Character", "Holidays"]
FILES = [f"db/Standard/Categories/{name}.lua" for name in CATEGORIES] + ["LICENSE"]
CURATED = ROOT / "Data/Sources/CuratedSources.json"
CONSTRUCTORS = {
    "Achievement": "achievementID", "GuildAchievement": "achievementID", "Header": "headerID", "CustomHeader": "headerID",
    "Item": "itemID", "Toy": "itemID", "Species": "speciesID", "Mount": "spellID",
    "Quest": "questID", "CharacterUnlockQuest": "questID", "HQT": "trackingQuestID",
    "NPC": "npcID", "Object": "objectID", "Map": "mapID", "Profession": "professionID",
    "Encounter": "encounterID", "Recipe": "recipeID", "Spell": "spellID",
    "ItemSource": "sourceID", "Faction": "factionID",
    "CharacterClass": "classID", "Race": "raceID",
    "Ensemble": "itemID", "EnsembleSpell": "spellID", "Instance": "instanceID",
    "Difficulty": "difficultyID", "Expansion": "expansionID",
}
FIELDS = {"questID", "npcID", "objectID", "achievementID", "faction", "classes", "races",
          "coords", "sourceQuests", "altQuests", "isBreadcrumb", "qgs", "providers",
          "cost", "description", "lvl", "sqreq", "maps"}


def cache_path(cache: Path, name: str) -> Path:
    return cache / name.replace("/", "_")


def download(cache: Path) -> None:
    def fetch(name: str) -> None:
        target = cache_path(cache, name)
        if target.exists():
            return
        with urlopen(f"https://raw.githubusercontent.com/ATTWoWAddon/AllTheThings/{REVISION}/{name}", timeout=45) as response:
            content = response.read()
        target.write_bytes(content)
        print(f"Downloaded {name}: {len(content):,} bytes", flush=True)
    cache.mkdir(parents=True, exist_ok=True)
    with ThreadPoolExecutor(max_workers=4) as pool:
        list(pool.map(fetch, FILES))


def unpack(value):
    if lua_type(value) != "table":
        return value if lua_type(value) != "function" else None
    keys = list(value.keys())
    if all(isinstance(k, int) and 1 <= k <= len(keys) for k in keys):
        return [unpack(value[i]) for i in range(1, len(keys) + 1)]
    return {str(k): unpack(v) for k, v in value.items() if lua_type(v) != "function"}


def load_external(cache: Path):
    lua = LuaRuntime(unpack_returned_tuples=True, register_eval=False, register_builtins=False)
    setup = lua.eval("""function(keys)
        local categories = {}
        local ns = {L = setmetatable({}, {__index = function(_, key) return key end}),
            OnTooltipDB = {}, OnUpdateDB = {}, RaceIndex = {}, ClassIndex = {},
            CurrentCharacter = {}, Modules = {}, Settings = {}, WOWAPI = {}}
        local function constructor(key, name)
            return function(id, second, third)
                local data = type(third) == 'table' and third or type(second) == 'table' and second or {}
                if #data > 0 and data.g == nil then data = {g = data} end
                data[key] = id
                data._constructor = name
                if name == 'ItemSource' and type(second) == 'number' then data.itemID = second end
                return data
            end
        end
        setmetatable(ns, {__index = function(t, key)
            if key:sub(1,6) == 'Create' then
                local name = key:sub(7)
                local fn = constructor(keys[name] or ('_' .. name), name)
                rawset(t, key, fn)
                return fn
            end
        end})
        ns.AddEventHandler = function(event, fn)
            if event == 'OnBuildDataCache' then fn(categories) end
        end
        ns.ResolveQuestData = function(data) return data end
        ns.asset = function(name) return name end
        ns.WOWAPI.GetItemCount = function() return 0 end
        ns.indexOf = function(t, value) for i, v in ipairs(t or {}) do if v == value then return i end end end
        local env = {assert=assert, error=error, type=type, tonumber=tonumber, tostring=tostring,
            pairs=pairs, ipairs=ipairs, select=select, unpack=unpack, next=next,
            string=string, table=table, math=math, setmetatable=setmetatable, rawget=rawget}
        env._G = env
        env.Enum = {FlightPathFaction = {Horde = 1, Alliance = 2}}
        env.GetCVar = function() return 'EU' end
        return ns, categories, function(source)
            local fn = assert(loadstring(source))
            setfenv(fn, env)
            fn('SourceData', ns)
        end
    end""")
    namespace, categories, run = setup(lua.table_from(CONSTRUCTORS))
    for category in CATEGORIES:
        content = cache_path(cache, f"db/Standard/Categories/{category}.lua").read_text(encoding="utf-8-sig")
        try:
            run(content)
        except Exception as error:
            raise RuntimeError(f"Cannot decode {category}: {error}") from error
    return lua, categories


def points(node):
    result = []
    coords = node["coords"]
    if lua_type(coords) == "table":
        for map_id, positions in coords.items():
            for _, xy in positions.items():
                x, y = xy[1], xy[2]
                if isinstance(x, (int, float)) and isinstance(y, (int, float)) and 0 <= x <= 100 and 0 <= y <= 100:
                    result.append([int(map_id), x, y])
    return sorted(result)[:40]


def source_maps(path):
    for node in reversed(path):
        if isinstance(node["mapID"], (int, float)) and node["mapID"] > 0 and node["mapID"] != 947:
            return [int(node["mapID"])]
        maps = unpack(node["maps"])
        if isinstance(maps, list) and maps:
            return sorted({int(value) for value in maps if isinstance(value, (int, float)) and value > 0})
    return []


def restrictions(path):
    result = {}
    for node in reversed(path):
        if "faction" not in result and node["r"] in (1, 2): result["faction"] = "Horde" if node["r"] == 1 else "Alliance"
        if "classes" not in result:
            if node["c"]: result["classes"] = unpack(node["c"])
            elif node["classID"]: result["classes"] = [int(node["classID"])]
        if "races" not in result:
            if node["races"]: result["races"] = unpack(node["races"])
            elif node["raceID"]: result["races"] = [int(node["raceID"])]
    return result


def make_index(categories, catalog):
    wanted = {kind: set() for kind in ("mounts", "pets", "toys", "cosmetics")}
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind, field in [("mounts", "spellId"), ("pets", "speciesId"), ("toys", "itemId"), ("cosmetics", "itemId")]:
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                if entry[field]: wanted[kind].add(int(entry[field]))
    found = {kind: defaultdict(list) for kind in wanted}
    quests = {}
    npcs = {}
    npc_sources = defaultdict(list)
    objects = {}
    def walk(node, ancestors, category):
        if lua_type(node) != "table": return
        # Historical sources must never replace a current vendor/quest destination.
        removed_at = node["rwp"]
        if node["u"] == 1 or (removed_at and removed_at <= CURRENT_PATCH) or (node["u"] == 2 and not removed_at): return
        path = ancestors + [node]
        constructor = node["_constructor"]
        if constructor == "Quest":
            record = {key: unpack(node[key]) for key in FIELDS if node[key] is not None and key != "coords"}
            record["coords"] = points(node)
            record["maps"] = source_maps(path)
            record.update(restrictions(path))
            if node["isBreadcrumb"]: record["isBreadcrumb"] = True
            if node["altQuests"]: record["altQuests"] = unpack(node["altQuests"])
            variants = []
            for variant_key, faction in (("aqd", "Alliance"), ("hqd", "Horde")):
                branch = node[variant_key]
                if lua_type(branch) != "table": continue
                variant = {**record, "faction": faction}
                for key in FIELDS:
                    if key != "coords" and branch[key] is not None: variant[key] = unpack(branch[key])
                variant["coords"] = points(branch) or record["coords"]
                variant["maps"] = source_maps(path + [branch])
                variants.append(variant)
            if variants: record["variants"] = variants
            previous = quests.get(int(node["questID"]))
            if previous is None or (not previous["coords"] and record["coords"]): quests[int(node["questID"])] = record
        if constructor in ("NPC", "Object") and points(node):
            (npcs if constructor == "NPC" else objects).setdefault(int(node["npcID"] if constructor == "NPC" else node["objectID"]), points(node))
            if constructor == "NPC":
                npc_source = {"coords": points(node), **restrictions(path)}
                if npc_source not in npc_sources[int(node["npcID"])]: npc_sources[int(node["npcID"])].append(npc_source)
        for kind, field in [("mounts", "spellID"), ("pets", "speciesID"), ("toys", "itemID"), ("cosmetics", "itemID")]:
            value = node[field]
            if not isinstance(value, (int, float)) or int(value) not in wanted[kind]: continue
            if constructor not in ("Item", "ItemSource", "Toy", "Mount", "Species", "Ensemble", "EnsembleSpell", "CharacterUnlockQuest"): continue
            parent_path = path[:-1]
            source = None
            vendor = any(p["headerID"] in (-58, -22, -480) for p in path)
            # Some PvP sellers sit directly under a mount filter rather than a
            # vendor header. An explicit purchase cost identifies their wares.
            vendor = vendor or (category == "PVP" and node["cost"] is not None)
            for parent in reversed(parent_path):
                pc = parent["_constructor"]
                if pc == "Quest":
                    source = {"kind": "Quest Rewards", "questID": int(parent["questID"])}; break
                if pc in ("Achievement", "GuildAchievement"):
                    source = {"kind": "Achievements", "achievementID": int(parent["achievementID"])}; break
                if pc == "NPC":
                    source = {"kind": "Vendor" if vendor else "Rare Drops", "npcID": int(parent["npcID"]), "coords": points(parent)}; break
                if pc == "Faction" and parent["npcID"]:
                    source = {"kind": "Vendor", "npcID": int(parent["npcID"]), "coords": points(parent)}; break
                if pc == "Header" and parent["type"] == "n" and parent["headerID"] > 0:
                    source = {"kind": "Vendor" if vendor else "Rare Drops", "npcID": int(parent["headerID"]), "coords": points(parent)}; break
                if pc == "Encounter":
                    source = {"kind": "Dungeon and Raids", "encounterID": int(parent["encounterID"])}
                    if parent["npcID"]: source["npcID"] = int(parent["npcID"])
                    break
                if pc == "Object":
                    source = {"kind": "Treasure", "objectID": int(parent["objectID"]), "coords": points(parent)}; break
            if source is None and kind == "pets" and (node["coords"] or node["maps"] or node["pb"] == 1):
                source = {"kind": "Pet Battles", "coords": points(node)}
            if source is None and any(parent["headerID"] == -63 for parent in path):
                source = {"kind": "Rare Drops", "coords": [], "maps": source_maps(path)}
                for parent in reversed(parent_path):
                    if parent["_constructor"] == "Item":
                        source["containerItemID"] = int(parent["itemID"]); break
            if source is None:
                method = {"Craftables": "Professions", "Professions": "Professions", "InGameShop": "Promotion",
                          "Promotions": "Promotion", "TradingPost": "Trading Post", "BlackMarket": "Black Market",
                          "PVP": "PvP", "WorldDrops": "Rare Drops", "WorldEvents": "Events", "Delves": "Delves"}.get(category)
                if method: source = {"kind": method, "coords": []}
            if source is None and category == "Instances":
                source = {"kind": "Dungeon and Raids", "coords": []}
            if source is None and vendor:
                source = {"kind": "Vendor", "coords": []}
                for parent in reversed(path):
                    if parent["crs"]:
                        source["sourceNPCs"] = unpack(parent["crs"])
                        source["locationType"] = "Event vendor; availability follows the active event"
                        break
            if source is None and category == "ExpansionFeatures":
                headers = {parent["headerID"] for parent in path if parent["headerID"]}
                if headers & {-142, -47, -27, -19}: source = {"kind": "Rare Drops", "coords": []}
                elif -170 in headers and any(str(value).startswith("SL_COV_") for parent in path for value in (unpack(parent["customCollect"]) or [])):
                    source = {"kind": "Reputation", "coords": [], "sourceName": "Automatic covenant Renown reward",
                              "instructions": str(node["description"] or "Raise Renown with the corresponding covenant to unlock this reward automatically.")}
            if source is None and category == "Secrets":
                for parent in reversed(path):
                    if parent["_constructor"] == "HQT" and points(parent):
                        source = {"kind": "Treasure", "coords": points(parent), "locationType": "Secret interaction"}; break
            if source is None: continue
            # A profession chapter can contain quest/achievement rewards and
            # sellers. Keep their actual method so quest progression and giver
            # locations remain available; ordinary crafts already use Professions.
            source.update(restrictions(path))
            if source["kind"] not in ("Professions", "Achievements", "Promotion", "Trading Post", "PvP"):
                source["maps"] = source_maps(path)
            for parent in reversed(path):
                if parent["cost"]:
                    cost = unpack(parent["cost"])
                    source["cost"] = [["g", cost]] if isinstance(cost, (int, float)) else cost
                    break
            # Instance-only coordinates belong to the entrance, never a made-up outdoor boss pin.
            if category == "Instances" and not source.get("coords") and source["kind"] not in ("Quest Rewards", "Achievements"):
                for parent in reversed(path):
                    if points(parent):
                        source["coords"] = points(parent); source["locationType"] = "Instance entrance"; break
                source["kind"] = "Dungeon and Raids"
            source["file"] = category
            if source not in found[kind][int(value)]: found[kind][int(value)].append(source)
        group = node["g"]
        if lua_type(group) == "table":
            for _, child in group.items(): walk(child, path, category)
    for category in CATEGORIES:
        if categories[category] is not None: walk(categories[category], [], category)
    curated = json.loads(CURATED.read_text(encoding="utf-8"))
    for group in curated.get("groups", []):
        kind = group["type"]
        for entry_id in group["ids"]:
            assert entry_id in wanted[kind], f"Curated group references an absent catalog entry: {kind}/{entry_id}"
            found[kind][entry_id] = curated["profiles"][group["profile"]]
    for quest_id, record in curated.get("quests", {}).items():
        quests[int(quest_id)] = {"questID": int(quest_id), "coords": [], "maps": [], **record}
    for kind, entries in curated.get("collections", {}).items():
        for entry_id, records in entries.items():
            entry_id = int(entry_id)
            assert entry_id in wanted[kind], f"Curated source references an absent catalog entry: {kind}/{entry_id}"
            found[kind][entry_id] = records
    for sources in found.values():
        for records in sources.values():
            for record in records:
                if record.get("references"): record["researched"] = True
                if record.get("availability"):
                    record["availability"].setdefault("reviewedAt", "2026-10-28")
                    record["availability"].setdefault("sourceUrl", record.get("references", [REPOSITORY])[0])
    # Explicit alternative introductions for the same Alliance Burning Steppes chain.
    for a, b in [(28174, 28416)]:
        if a in quests and b in quests:
            quests[a]["altQuests"] = [b]; quests[b]["altQuests"] = [a]
    required = set()
    def require(quest_id):
        if quest_id in required: return
        required.add(quest_id)
        record = quests.get(quest_id)
        if record:
            for branch in [record] + record.get("variants", []):
                for value in branch.get("sourceQuests", []) + branch.get("altQuests", []): require(int(value))
    for sources in found.values():
        for records in sources.values():
            for record in records:
                if "questID" in record: require(record["questID"])
                if "unlockQuestID" in record: require(record["unlockQuestID"])
                if "progressQuestID" in record: require(record["progressQuestID"])
    subset = {key: value for key, value in quests.items() if key in required}
    depths = {}
    def depth(quest_id, visiting=None):
        visiting = set() if visiting is None else visiting
        record = subset.get(quest_id)
        if not record or record.get("isBreadcrumb") or quest_id in visiting or len(visiting) > 80: return 0
        if quest_id in depths: return depths[quest_id]
        visiting = visiting | {quest_id}
        value = 1 + max((depth(q, visiting) for q in record.get("sourceQuests", [])), default=0)
        depths[quest_id] = value
        return value
    for record in [branch for value in subset.values() for branch in [value] + value.get("variants", [])]:
        # Parallel requirements have no unique first quest. Follow the longer
        # story branch first, then complete its remaining parallel requirements.
        if record.get("sourceQuests"):
            record["sourceQuests"].sort(key=lambda q: (-depth(q), q))
        if not record["coords"]:
            for npc_id in record.get("qgs", []):
                if npc_id in npcs: record["coords"] = npcs[npc_id]; break
    for sources in found.values():
        for entry_id, records in list(sources.items()):
            expanded = []
            for record in records:
                if not record.get("coords") and record.get("npcID") in npcs: record["coords"] = npcs[record["npcID"]]
                if not record.get("coords") and record.get("objectID") in objects: record["coords"] = objects[record["objectID"]]
                variants = []
                for npc_id in record.get("sourceNPCs", []):
                    for npc_source in npc_sources.get(npc_id, []):
                        variants.append({**record, **npc_source, "npcID": npc_id})
                expanded.extend(variants or [record])
            sources[entry_id] = expanded
    return {**{kind: dict(records) for kind, records in found.items()}, "quests": subset}


def lua_literal(value, indent=0):
    if value is None: return "nil"
    if value is True: return "true"
    if value is False: return "false"
    if isinstance(value, (float, int)): return str(value)
    if isinstance(value, str): return json.dumps(value, ensure_ascii=False)
    if isinstance(value, list): return "{" + ",".join(lua_literal(v, indent) for v in value) + "}"
    return "{" + ",".join(f"[{lua_literal(k)}]={lua_literal(v, indent + 1)}" for k, v in sorted(value.items(), key=lambda p: str(p[0]))) + "}"


def shared_lua_tables(index, table_name="TDP.CollectionSourceIndex"):
    """Share identical read-only records and arrays instead of allocating copies."""
    counts, values = {}, {}

    def visit(value):
        if not isinstance(value, (dict, list)):
            return
        key = lua_literal(value)
        counts[key] = counts.get(key, 0) + 1
        values[key] = value
        for child in (value.values() if isinstance(value, dict) else value):
            visit(child)

    visit(index)
    keys = sorted((key for key, count in counts.items() if count > 1), key=lambda key: (len(key), key))
    ids = {key: number for number, key in enumerate(keys, 1)}

    def render(value, definition=False):
        if not isinstance(value, (dict, list)):
            return lua_literal(value)
        key = lua_literal(value)
        if not definition and key in ids:
            return f"shared[{ids[key]}]"
        if isinstance(value, list):
            return "{" + ",".join(render(child) for child in value) + "}"
        return "{" + ",".join(f"[{lua_literal(k)}]={render(v)}" for k, v in sorted(value.items(), key=lambda p: str(p[0]))) + "}"

    lines = ["local shared = {}"]
    for key in keys:
        lines.append(f"shared[{ids[key]}] = {render(values[key], definition=True)}")
    lines.append(table_name + " = {")
    for field, records in index.items():
        lines.append(f"    {field} = {{")
        for key, value in sorted(records.items()):
            lines.append(f"        [{key}] = {render(value)},")
        lines.append("    },")
    lines.append("}")
    return lines


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cache-dir", type=Path, default=Path(tempfile.gettempdir()) / "tdp-collection-source-research" / "att")
    parser.add_argument("--download", action="store_true")
    args = parser.parse_args()
    if args.download: download(args.cache_dir)
    lua, categories = load_external(args.cache_dir)
    catalog = load_catalog(LuaRuntime(unpack_returned_tuples=True))
    index = make_index(categories, catalog)
    lines = ["-- Generated by tools/import_collection_sources.py; see Docs/CollectionSources.md.",
             "-- Data derived from AllTheThings (MIT); see Data/Sources/ATT-LICENSE.txt.",
             "-- Shared source records are read-only. Runtime destinations use separate tables.",
             "local _, TDP = ...", *shared_lua_tables(index), ""]
    output = ROOT / "Data/Sources/CollectionSourceIndex.lua"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text("\n".join(lines), encoding="utf-8")
    (output.parent / "ATT-LICENSE.txt").write_bytes(cache_path(args.cache_dir, "LICENSE").read_bytes())
    receipt = {"repository": REPOSITORY, "revision": REVISION, "reviewedAt": "2026-10-28",
               "files": {name: hashlib.sha256(cache_path(args.cache_dir, name).read_bytes()).hexdigest() for name in FILES},
               "curatedSourceSha256": hashlib.sha256(CURATED.read_bytes()).hexdigest(),
               "counts": {field: len(records) for field, records in index.items()}}
    (output.parent / "receipt.json").write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(receipt["counts"], sort_keys=True), flush=True)


if __name__ == "__main__":
    main()
