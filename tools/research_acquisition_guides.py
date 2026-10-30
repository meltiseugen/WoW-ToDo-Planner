# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Extract acquisition evidence for the frozen journal-placeholder identities.

The full ATT trees and tooltip responses stay in the offline research cache;
only the reviewed guide text is shipped to WoW. Historical paths are retained
here because a retired reward still needs its original requirements explained.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import tempfile
from urllib.request import Request, urlopen

from lupa.lua51 import lua_type

from catalog_support import ROOT
from import_collection_sources import CATEGORIES, REVISION, cache_path, download, load_external, points, unpack

CACHE = Path(tempfile.gettempdir()) / "tdp-collection-source-research"
TARGETS = ROOT / "Data/Sources/AcquisitionGuideTargets.json"
FIELDS = {"mounts": "spellID", "pets": "speciesID", "toys": "itemID"}


def extract():
    _, categories = load_external(CACHE / "att")
    targets = json.loads(TARGETS.read_text(encoding="utf-8"))
    wanted = {(r["type"], r["id"]) for r in targets}
    found = {f"{kind}:{identity}": [] for kind, identity in wanted}
    keys = {"questID", "npcID", "objectID", "achievementID", "itemID", "spellID", "speciesID", "headerID",
            "encounterID", "instanceID", "mapID", "name", "text", "description", "cost", "r", "c", "races", "difficultyID", "_difficultyID",
            "lvl", "minReputation", "reputation", "sourceQuests", "qgs", "providers", "crs", "u", "rwp", "professionID",
            "e", "eventID", "difficultyID", "difficulties", "requireSkill", "recipeID", "type", "factionID", "gating"}

    def walk(node, path, category):
        if lua_type(node) != "table":
            return
        data = {key: unpack(node[key]) for key in keys if node[key] is not None and lua_type(node[key]) != "function"}
        data["constructor"] = node["_constructor"]
        if points(node): data["coords"] = points(node)
        if node["maps"]: data["maps"] = unpack(node["maps"])
        current = path + [data]
        for kind, field in FIELDS.items():
            if isinstance(node[field], (int, float)) and (kind, int(node[field])) in wanted:
                found[f"{kind}:{int(node[field])}"].append({"category": category, "path": current})
        if lua_type(node["g"]) == "table":
            for _, child in node["g"].items(): walk(child, current, category)

    for category in CATEGORIES:
        walk(categories[category], [], category)
    (CACHE / "acquisition-paths.json").write_text(json.dumps(found, ensure_ascii=False, indent=2), encoding="utf-8")
    return found


def tooltip(kind, identity):
    directory = CACHE / "tooltips"
    directory.mkdir(exist_ok=True)
    target = directory / f"{kind}-{identity}.json"
    if not target.exists():
        url = f"https://nether.wowhead.com/tooltip/{kind}/{identity}?dataEnv=1&locale=0"
        with urlopen(Request(url, headers={"User-Agent": "TODO-Planner acquisition research"}), timeout=35) as response:
            value = json.load(response)
        if not value.get("name"): raise ValueError(f"No name in {url}")
        target.write_text(json.dumps(value, ensure_ascii=False), encoding="utf-8")
    return json.loads(target.read_text(encoding="utf-8"))


def download_names(found):
    # Lucky-item candidates documented in Ratts' Revenge's source tree.
    wanted = {("item", identity) for identity in (5373, 138382, 138385, 198400, 198857, 200265, 202046)}
    kinds = {"npcID": "npc", "questID": "quest", "achievementID": "achievement", "itemID": "item", "factionID": "faction", "spellID": "spell"}
    for occurrences in found.values():
        for occurrence in occurrences:
            for node in occurrence["path"]:
                for field, kind in kinds.items():
                    if node.get(field) and kind != "faction": wanted.add((kind, int(node[field])))
                header_kind = {"q": "quest", "n": "npc", "i": "item", "s": "spell", "a": "achievement"}.get(node.get("type"))
                if header_kind and node.get("headerID", 0) > 0: wanted.add((header_kind, int(node["headerID"])))
                for identity in node.get("sourceQuests", []): wanted.add(("quest", int(identity)))
                for cost in node.get("cost", []) if isinstance(node.get("cost"), list) else []:
                    if cost[0] in ("i", "c"): wanted.add(("item" if cost[0] == "i" else "currency", int(cost[1])))
                for identity in node.get("qgs", []) + node.get("crs", []): wanted.add(("npc", int(identity)))
                for tag, identity in node.get("providers", []):
                    if tag in ("i", "n"): wanted.add(("item" if tag == "i" else "npc", int(identity)))
    def fetch(key):
        try:
            tooltip(*key)
            return None
        except Exception as error:
            return f"{key}: {error}"
    with ThreadPoolExecutor(max_workers=12) as pool:
        errors = [error for error in pool.map(fetch, sorted(wanted)) if error]
    print(json.dumps({"requested": len(wanted), "failed": errors}, ensure_ascii=False), flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--download", action="store_true")
    args = parser.parse_args()
    if args.download:
        download(CACHE / "att")
        localization = cache_path(CACHE / "att", "db/Standard/LocalizationDB.lua")
        if not localization.exists():
            with urlopen(f"https://raw.githubusercontent.com/ATTWoWAddon/AllTheThings/{REVISION}/db/Standard/LocalizationDB.lua", timeout=45) as response:
                localization.write_bytes(response.read())
    evidence = extract()
    print(json.dumps({"targets": len(evidence), "matched": sum(bool(v) for v in evidence.values())}), flush=True)
    if args.download: download_names(evidence)
