# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Report catalog source coverage and the remaining location research gaps."""
from collections import Counter
import json

from lupa.lua51 import LuaRuntime

from catalog_support import ROOT, load_catalog


def audit():
    lua = LuaRuntime(unpack_returned_tuples=True)
    catalog = load_catalog(lua)
    namespace = lua.table_from({"PatchCatalog": catalog})
    lua.execute("return function(...)\n" + (ROOT / "UI/Collections/Metadata.lua").read_text(encoding="utf-8") + "\nend")("TODO-Planner", namespace)
    metadata = namespace.CollectionMetadata
    original = catalog.GetCollectionSourceInfo
    researched_kind = catalog.GetResearchedCollectionSourceKind
    absent = lua.eval("function() return nil end")
    totals, covered, mapped, previous_maps = Counter(), Counter(), Counter(), Counter()
    precise, areas = Counter(), Counter()
    old_unknown, structured_unknown, named_unknown = 0, 0, 0
    gaps = []
    area_sources = []
    unconfirmed = []
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind in ("mounts", "pets", "toys", "cosmetics"):
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                totals[kind] += 1
                details = catalog.GetCollectionDetails(catalog, kind, patch, entry) or lua.table()
                source = original(catalog, kind, patch, entry)
                payload = catalog.GetCollectionMapPayload(catalog, kind, patch, entry)
                current_map = payload is not None
                if source: covered[kind] += 1
                if source and source["kind"] == "Unverified":
                    unconfirmed.append({"patch": patch, "type": kind, "name": entry["name"], "source": source["source"], "instructions": source["instructions"]})
                if current_map:
                    mapped[kind] += 1
                    if payload["areaOnly"]:
                        areas[kind] += 1
                        area_sources.append({"patch": patch, "type": kind, "name": entry["name"], "method": source["kind"] if source else "Other",
                                             "source": details["source"], "mapID": payload["mapID"]})
                    else: precise[kind] += 1
                catalog.GetCollectionSourceInfo = absent
                catalog.GetResearchedCollectionSourceKind = absent
                old_map = bool(catalog.HasCollectionMapPayload(catalog, kind, patch, entry))
                old_category = metadata.GetSourceCategory(metadata, kind, patch, entry)
                catalog.GetCollectionSourceInfo = original
                catalog.GetResearchedCollectionSourceKind = researched_kind
                if old_map: previous_maps[kind] += 1
                source_type = details["sourceType"]
                generic = not source_type or source_type in ("Pet Journal Source", "Toy Box Source") or "Unknown" in source_type
                if kind != "mounts" and generic and old_category == "Other":
                    old_unknown += 1
                    if source: structured_unknown += 1
                    elif details["source"]: named_unknown += 1
                method = source["kind"] if source else old_category
                if not current_map and method in {"Quest Rewards", "Vendor", "Rare Drops", "Treasure", "Pet Battles", "Dungeon and Raids", "Delves", "Reputation"}:
                    gaps.append({"patch": patch, "type": kind, "name": entry["name"], "method": method,
                                 "source": details["source"], "structuredSource": source is not None,
                                 "npcID": source["npcID"] if source else None,
                                 "questID": source["questID"] if source else None,
                                 "retired": bool(catalog.IsCollectionUnobtainable(catalog, kind, patch, entry))})
    return {"reviewedAt": "2026-10-28", "scope": "All catalog entries; includes historical entries. No live quest or faction APIs.",
            "totals": dict(totals), "structuredSources": dict(covered), "mapEntriesBefore": dict(previous_maps),
            "mapEntriesAfter": dict(mapped), "additionalMapEntries": sum(mapped.values()) - sum(previous_maps.values()),
            "mapEntriesWithCoordinates": dict(precise), "sourceAreaMaps": dict(areas), "areaOnlySources": area_sources,
            "previousUnknownLabels": old_unknown, "unknownRowsWithStructuredSources": structured_unknown,
            "unknownRowsWithNamedCatalogSources": named_unknown, "remainingLocationResearch": gaps, "unconfirmedSources": unconfirmed}


def write_location_report(report):
    gaps = report["remainingLocationResearch"]
    counts = Counter(entry["method"] for entry in gaps)
    lines = ["# Collection sources without a mapped location", "",
             f"The {report['reviewedAt']} offline audit found {len(gaps)} catalog entries with a location-based acquisition method but no usable map destination.",
             "These are catalog entries. A named source can be known while its coordinates or area map are missing.",
             "The audit includes historical entries and uses no live faction, class or quest-progress APIs. It does not establish current obtainability.", "",
             f"The separate {len(report['areaOnlySources'])} area-only destinations already open a source area and are not included in this list.",
             f"There are also {len(report['unconfirmedSources'])} unconfirmed acquisition sources; they are explicitly recorded in the original-entry research report.",
             "The original 228 entries are tracked separately in [CollectionLocationResearch.md](CollectionLocationResearch.md).", "",
             "| Acquisition method | Entries |", "| --- | ---: |"]
    for method, count in counts.most_common():
        lines.append(f"| {method} | {count} |")
    for method, _ in counts.most_common():
        lines += ["", f"## {method}", "", "| Collectible | Type | Patch | Recorded source |", "| --- | --- | --- | --- |"]
        for entry in sorted((entry for entry in gaps if entry["method"] == method), key=lambda entry: (entry["type"], entry["name"])):
            source = (entry["source"] or "No named catalog source").replace("|", "\\|").replace("\n", " ")
            name = entry["name"] + (" (historical / unobtainable)" if entry["retired"] else "")
            lines.append(f"| {name} | {entry['type']} | {entry['patch']} | {source} |")
    (ROOT / "Docs/UnmappedCollectionSources.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    report = audit()
    path = ROOT / "Docs/CollectionSourceAudit.json"
    path.write_text(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    write_location_report(report)
    print(json.dumps({key: value for key, value in report.items() if key not in {"remainingLocationResearch", "areaOnlySources", "unconfirmedSources"}}, sort_keys=True))
    print(f"Remaining spatial-source research entries: {len(report['remainingLocationResearch'])}")
