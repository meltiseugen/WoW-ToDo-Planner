# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Inspect upstream ancestry for the catalog's unresolved source destinations."""
import json
from pathlib import Path
import tempfile
from collections import defaultdict
from lupa.lua51 import LuaRuntime, lua_type
from catalog_support import ROOT, load_catalog, plain
from import_collection_sources import load_external, unpack, points, source_maps, CATEGORIES

catalog = load_catalog(LuaRuntime(unpack_returned_tuples=True))
targets_file = ROOT / "Data/Sources/LocationResearchTargets.json"
report = json.loads(targets_file.read_text(encoding="utf-8-sig"))
gaps = {(row["type"], row["patch"], row["name"]) for row in report["targets"]}
targets, result = defaultdict(list), []
for _, patch in catalog.GetPatchKeys(catalog).items():
    for kind, field in (("mounts", "spellId"), ("pets", "speciesId"), ("toys", "itemId"), ("cosmetics", "itemId")):
        for _, entry in catalog.GetEntries(catalog, patch, kind).items():
            if (kind, patch, entry["name"]) in gaps:
                item = {"type": kind, "patch": patch, "name": entry["name"], "id": entry[field],
                        "entry": plain(entry), "details": plain(catalog.GetCollectionDetails(catalog, kind, patch, entry)),
                        "records": plain(catalog.GetCollectionSourceRecords(catalog, kind, patch, entry)), "upstream": []}
                result.append(item)
                targets[(kind, int(entry[field]))].append(item)
lua, categories = load_external(Path(tempfile.gettempdir()) / "tdp-collection-source-research/att")

def walk(node, path, category):
    if lua_type(node) != "table": return
    path = path + [node]
    for kind, field in (("mounts", "spellID"), ("pets", "speciesID"), ("toys", "itemID"), ("cosmetics", "itemID")):
        value = node[field]
        if isinstance(value, (int, float)) and (kind, int(value)) in targets:
            ancestry = []
            for parent in path:
                data = {str(k): unpack(v) for k, v in parent.items() if k != "g" and lua_type(v) != "function"}
                data.pop("coords", None)
                data["coords"] = points(parent)
                ancestry.append(data)
            for target in targets[(kind, int(value))]:
                target["upstream"].append({"category": category, "maps": source_maps(path), "path": ancestry})
    group = node["g"]
    if lua_type(group) == "table":
        for _, child in group.items(): walk(child, path, category)

for category in CATEGORIES:
    if categories[category] is not None: walk(categories[category], [], category)
path = Path(tempfile.gettempdir()) / "tdp-unmapped-source-research.json"
path.write_text(json.dumps(result, indent=2, ensure_ascii=False), encoding="utf-8")
print(f"Inspected {len(result)} entries; {sum(bool(row['upstream']) for row in result)} have upstream occurrences. Saved {path}")
for row in result:
    if row["type"] != "pets" or row["name"] in ("Harpy Youngling", "Blazehound", "Caustic Oozeling", "Faithful Dog", "Aud'rei III"):
        print(row["type"], row["id"], row["name"], "; ".join(f"{source['category']}: maps={source['maps'][:4]}" for source in row["upstream"]))
