# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Account for each of the original 228 missing collection destinations."""
from collections import Counter
import json
from lupa.lua51 import LuaRuntime
from catalog_support import ROOT, load_catalog, load_file
from import_collection_sources import unpack, REPOSITORY, REVISION

lua = LuaRuntime(unpack_returned_tuples=True)
catalog = load_catalog(lua)
names = lua.table()
load_file(lua, names, ROOT / "Data/Catalog/MapNames.lua")
map_names = names.CatalogMapNames
targets = json.loads((ROOT / "Data/Sources/LocationResearchTargets.json").read_text(encoding="utf-8-sig"))["targets"]
rows = []
for target in targets:
    kind, patch, ident = target["type"], target["patch"], target["id"]
    field = {"mounts": "spellId", "pets": "speciesId", "toys": "itemId", "cosmetics": "itemId"}[kind]
    entry = next(entry for _, entry in catalog.GetEntries(catalog, patch, kind).items() if entry[field] == ident)
    info = catalog.GetCollectionSourceInfo(catalog, kind, patch, entry)
    payload = catalog.GetCollectionMapPayload(catalog, kind, patch, entry)
    records = unpack(catalog.GetCollectionSourceRecords(catalog, kind, patch, entry))
    availability = catalog.GetCollectionAvailability(catalog, kind, patch, entry)
    methods = {record.get("kind") for record in records}
    if any(record.get("researchStatus") == "unconfirmed" for record in records): status = "unconfirmed"
    elif availability and availability["kind"] == "opponent": status = "opponent"
    elif availability and availability["kind"] == "neverImplemented": status = "unimplemented"
    elif "Historical Reward" in methods: status = "historical"
    elif payload: status = "area" if payload["areaOnly"] else "coordinates"
    elif "Achievements" in methods: status = "achievement"
    elif methods & {"Class Unlock", "PvP"}: status = "no fixed location"
    else: status = "unresolved"
    references = sorted({url for record in records for url in record.get("references", [])}
        | {f"{REPOSITORY}/blob/{REVISION}/db/Standard/Categories/{record['file']}.lua" for record in records if record.get("file")})
    rows.append({**target, "status": status, "method": info["kind"] if info else None,
        "source": info["summary"] if info else None, "instructions": info["instructions"] if info else None,
        "availability": unpack(availability) if availability else None,
        "waypoints": unpack(info["waypoints"]) if info else [], "areaMaps": unpack(info["areaMaps"]) if info else [],
        "achievementID": info["achievementID"] if info else None, "references": references})
counts = dict(Counter(row["status"] for row in rows))
assert len(rows) == 228 and not counts.get("unresolved"), "Every original entry needs an explicit research outcome"
assert all(row["references"] for row in rows), "Each research outcome needs evidence"
report = {"reviewedAt": "2026-10-28", "originalEntries": 228, "counts": counts, "entries": rows}
(ROOT / "Docs/CollectionLocationResearch.json").write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
lines = ["# Original 228 source-location entries", "", "Every original entry is retained by patch, collection type and ID. Coordinates, source areas, non-collectible opponents, retired rewards and unconfirmed sources are reported separately.", "", "| Result | Entries |", "| --- | ---: |"]
for status, count in sorted(counts.items()): lines.append(f"| {status} | {count} |")
for status in sorted(counts):
    lines += ["", f"## {status.capitalize()}", "", "| Collectible | Type / ID | Patch | Destination / finding | Evidence |", "| --- | --- | --- | --- | --- |"]
    for row in sorted((row for row in rows if row["status"] == status), key=lambda row: (row["type"], row["name"], row["id"])):
        locations = "; ".join(f"{p.get('mapName') or 'map ' + str(p['mapID'])}: {p['x']*100:.2f}, {p['y']*100:.2f}" for p in row["waypoints"])
        if not locations and row["areaMaps"]: locations = "Source areas: " + ", ".join(map_names[ident] or f"map {ident}" for ident in row["areaMaps"])
        finding = (row["instructions"] or row["source"] or "Unresolved").replace("|", "\\|").replace("\n", " ")
        evidence = ", ".join(f"[source {i}]({url})" for i, url in enumerate(row["references"], 1))
        lines.append(f"| {row['name']} | {row['type']} / {row['id']} | {row['patch']} | {locations + '. ' if locations else ''}{finding} | {evidence} |")
(ROOT / "Docs/CollectionLocationResearch.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
print(json.dumps({"originalEntries": len(rows), "counts": counts}, sort_keys=True))
for row in rows:
    if row["status"] in {"unresolved", "unconfirmed"}: print(row["status"], row["type"], row["id"], row["name"])
