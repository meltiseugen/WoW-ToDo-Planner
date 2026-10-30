# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Extract spatial evidence for catalog entries without an existing map action.

This is an offline research step. External data and prose parsing never run in
WoW; only reviewed coordinates and area IDs will be compiled into the addon.
"""
from collections import Counter
import json
from pathlib import Path
import tempfile

from lupa.lua51 import LuaRuntime, lua_type

from catalog_support import ROOT
from description_map_support import CharacterContexts, load_context
from import_collection_sources import CATEGORIES, load_external, points, restrictions, source_maps

CACHE = Path(tempfile.gettempdir()) / "tdp-collection-source-research"
FIELDS = {"mounts": "spellId", "pets": "speciesId", "toys": "itemId", "cosmetics": "itemId", "achievements": "achievementId"}


def main():
    lua = LuaRuntime(unpack_returned_tuples=True)
    namespace, explorer, _ = load_context(lua)
    catalog = namespace.PatchCatalog
    contexts = CharacterContexts(lua, namespace)
    # Reproduction must inspect the original routes, not consume its own output.
    catalog.GetDescriptionMapLocations = lua.eval("function() return nil end")
    overrides = json.loads((ROOT / "Data/Sources/DescriptionLocationOverrides.json").read_text(encoding="utf-8"))
    wanted = {}
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind, field in FIELDS.items():
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                availability = catalog.GetCollectionAvailability(catalog, kind, patch, entry)
                conditional_unlock = bool(availability
                    and availability["kind"] not in ("Unconfirmed", "Unreleased")
                    and (availability["questIds"] or availability["achievementIds"]))
                # Some archived rewards still have a vendor for characters with
                # the original unlock. Research their routes even without that
                # unlock in the offline character context.
                if catalog.IsCollectionHiddenInUI(catalog, kind, patch, entry) and not conditional_unlock: continue
                identity = entry[field] if lua_type(entry) == "table" else entry
                reviewed = overrides.get(f"{kind}:{identity}")
                row = lua.table_from({"collectionType": kind, "patchKey": patch, "entry": entry})
                missing_contexts = []
                for profile in contexts.profiles(kind, patch, entry):
                    contexts.set(profile)
                    if not explorer.IsCollectionMapRow(explorer, row): missing_contexts.append(profile)
                contexts.set()
                if not reviewed and not missing_contexts: continue
                unrestricted_action = bool(explorer.IsCollectionMapRow(explorer, row))
                details = catalog.GetCollectionDetails(catalog, kind, patch, entry)
                name = entry["name"] if lua_type(entry) == "table" else None
                source = catalog.GetCollectionSourceInfo(catalog, kind, patch, entry)
                wanted[kind, identity] = {"type": kind, "id": identity, "patch": patch,
                    "name": name or (details["name"] if details else None) or f"Achievement {identity}",
                    "acquisition": catalog.GetCollectionAcquisitionText(catalog, kind, patch, entry),
                    "source": catalog.GetCollectionSourceSummary(catalog, kind, patch, entry),
                    "sourceKind": source["kind"] if source else None,
                    "conditionalUnlock": conditional_unlock,
                    "missingContexts": missing_contexts, "hadUnrestrictedAction": unrestricted_action, "paths": []}
    _, categories = load_external(CACHE / "att")
    fields = {"mounts": "spellID", "pets": "speciesID", "toys": "itemID", "cosmetics": "itemID", "achievements": "achievementID"}

    def walk(node, path, category):
        if lua_type(node) != "table": return
        current = path + [node]
        for kind, field in fields.items():
            identity = node[field]
            if kind == "achievements" and node["_constructor"] == "Header" and node["type"] == "a": identity = node["headerID"]
            if (kind, identity) not in wanted: continue
            if kind == "achievements" and node["_constructor"] not in ("Achievement", "GuildAchievement", "Header"): continue
            record = {"category": category, **restrictions(current)}
            instance = next((n for n in reversed(current) if n["_constructor"] == "Instance"), None)
            if instance is not None and points(instance):
                record["coords"] = points(instance)
                record["locationType"] = "Instance entrance"
            else:
                record["coords"] = next((points(n) for n in reversed(current) if points(n)), [])
            record["maps"] = source_maps(current)
            record["historical"] = any(n["u"] == 1 or n["rwp"] and n["rwp"] <= 120105 for n in current)
            record["context"] = []
            for parent in current:
                context = {key: parent[key] for key in ("mapID", "npcID", "objectID", "questID", "instanceID", "headerID", "type") if parent[key] is not None}
                if parent["description"]: context["description"] = parent["description"]
                if context: record["context"].append(context)
            if (record["coords"] or record["maps"]) and record not in wanted[kind, identity]["paths"]:
                wanted[kind, identity]["paths"].append(record)
        group = node["g"]
        if lua_type(group) == "table":
            for _, child in group.items(): walk(child, current, category)

    for category in CATEGORIES: walk(categories[category], [], category)
    rows = list(wanted.values())
    (CACHE / "description-location-paths.json").write_text(json.dumps(rows, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps({"withoutMapAction": dict(Counter(r["type"] for r in rows)),
        "withSpatialEvidence": dict(Counter(r["type"] for r in rows if r["paths"]))}))
    for row in rows:
        if row["type"] == "achievements" or not row["paths"]: continue
        print(row["type"], row["id"], row["name"], [(p["category"],p["coords"][:2],p["maps"],p["historical"]) for p in row["paths"][:3]])


if __name__ == "__main__": main()
