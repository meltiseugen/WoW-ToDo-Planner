# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Audit prose locations against the same map actions exposed by the addon UI."""
from collections import Counter
import json
import re

from lupa.lua51 import LuaRuntime, lua_type

from catalog_support import ROOT
from description_map_support import CharacterContexts, load_context
from import_collection_sources import REPOSITORY, REVISION
from research_description_locations import CACHE, FIELDS

COORDINATES = re.compile(r"(?<![\d.])(?:\d{1,2}\.\d+\s*,\s*\d{1,2}(?:\.\d+)?|\d{1,2}\s*,\s*\d{1,2}\.\d+)(?![\d.])|\(\s*\d{1,2}\s*,\s*\d{1,2}\s*\)|/way\s+#?\d+")


def strings(value, depth=0, achievement=False):
    if isinstance(value, str): return [value]
    if lua_type(value) == "table" and depth < 6:
        result = []
        for key, nested in value.items():
            if key in ("name", "category", "sourceType"): continue
            # A patch heading or achievement title is not a travel instruction.
            if key == "source" and (achievement or isinstance(nested, str) and nested.startswith("Patch ")): continue
            result.extend(strings(nested, depth + 1, achievement))
        return result
    return []


def main():
    lua = LuaRuntime(unpack_returned_tuples=True)
    namespace, explorer, favorites = load_context(lua)
    catalog = namespace.PatchCatalog
    contexts = CharacterContexts(lua, namespace)
    names = sorted({name for _, name in namespace.CatalogMapNames.items() if len(name) > 4}, key=lambda name: -len(name))
    named_place = re.compile(r"(?<![A-Za-z])(?:" + "|".join(map(re.escape, names)) + r")(?![A-Za-z])", re.I)
    overrides = json.loads((ROOT / "Data/Sources/DescriptionLocationOverrides.json").read_text(encoding="utf-8"))
    additions = json.loads((ROOT / "Data/Sources/DescriptionLocations.json").read_text(encoding="utf-8"))
    research = json.loads((CACHE / "description-location-paths.json").read_text(encoding="utf-8"))
    known_achievement_locations = {row["id"] for row in research if row["type"] == "achievements"
        and not overrides.get(f"achievements:{row['id']}", {}).get("exclude")
        and any(path["category"] not in ("Promotions", "InGameShop", "TradingPost")
                and (path["coords"] or path["maps"]) for path in row["paths"])}
    supplemental_path = ROOT / "Data/Sources/AchievementLocationEvidence.json"
    supplemental = json.loads(supplemental_path.read_text(encoding="utf-8")) if supplemental_path.exists() else {"resolved": [], "unresolved": []}
    known_achievement_locations.update(row["id"] for row in supplemental["resolved"])
    reviewed_achievements = {row["id"]: row for row in supplemental["resolved"] + supplemental["unresolved"]}
    added = {(row["type"], row["id"]): row for row in additions}
    # These had source data, but the old profession override/absent quest alias
    # prevented the resolver from following the chain to its real quest giver.
    added["mounts", 431049] = {"type": "mounts", "patch": "10.2", "id": 431049, "name": "Grotto Netherwing Drake", "references": ["https://www.wowhead.com/quest=76465/dragon-keeping"]}
    added["toys", 131717] = {"type": "toys", "patch": "11.2.5", "id": 131717, "name": "Starlight Beacon", "references": ["https://www.wowhead.com/quest=41173"]}
    navigation_repairs = {60118: 614, 60119: 619, 61996: 2536, 61997: 2537,
        118737: 6827, 130985: 6828, 142266: 8302, 142478: 8304,
        193695: 11474, 204166: 11474, 295386: 13517, 295387: 13517}
    for identity, achievement_id in navigation_repairs.items():
        added["mounts", identity] = {"type": "mounts", "id": identity, "navigationAchievementId": achievement_id,
            "references": []}
    scanned, checked, excluded, unresolved = Counter(), [], {}, {}
    achievement_coverage, unmapped_achievements = {}, []
    character_checks = 0
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind, field in FIELDS.items():
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                scanned[kind] += 1
                if kind == "achievements":
                    coverage = achievement_coverage.setdefault(patch, {"total": 0, "mapped": 0, "pins": 0, "areas": 0})
                    coverage["total"] += 1
                contexts.set()
                identity = entry[field] if lua_type(entry) == "table" else entry
                hidden = bool(catalog.IsCollectionHiddenInUI(catalog, kind, patch, entry))
                details = catalog.GetCollectionDetails(catalog, kind, patch, entry)
                source = catalog.GetCollectionSourceSummary(catalog, kind, patch, entry)
                title = (entry["name"] if lua_type(entry) == "table" else None) or reviewed_achievements.get(identity, {}).get("name") or source or f"Achievement {identity}"
                row = lua.table_from({"collectionType": kind, "patchKey": patch, "entry": entry})
                if hidden: continue
                for profile in [None, *contexts.profiles(kind, patch, entry)]:
                    contexts.set(profile)
                    character_checks += 1
                    has_action = bool(explorer.IsCollectionMapRow(explorer, row))
                    assert has_action == bool(favorites.IsCollectionMapRow(favorites, row)), (kind, identity, profile, "Windows disagree")
                    if kind == "achievements" and profile is None:
                        if has_action:
                            coverage["mapped"] += 1
                            destination = catalog.GetCollectionMapPayload(catalog, kind, patch, entry)
                            assert destination is not None, (identity, "Achievement Map cannot open")
                            coverage["areas" if destination["areaOnly"] else "pins"] += 1
                        else:
                            review = reviewed_achievements.get(identity, {})
                            unmapped_achievements.append({"id": identity, "patch": patch, "name": review.get("name"),
                                "category": catalog.GetAchievementCategory(catalog, patch, identity),
                                "description": review.get("description"),
                                "reason": review.get("reason") or "No verified fixed destination in the stored guide or pinned spatial source records; not classified as a repaired map."})
                    if (kind, identity) in added:
                        assert has_action, (kind, identity, profile, "Restored map action is unavailable")
                        payload = catalog.GetCollectionMapPayload(catalog, kind, patch, entry)
                        navigation_id = added[kind, identity].get("navigationAchievementId")
                        if navigation_id:
                            assert explorer.GetCollectionMapAchievementId(explorer, row) == navigation_id, (identity, profile, "Achievement action was lost")
                        else:
                            assert payload is not None, (kind, identity, profile, "Map action cannot open a destination")
                        pins = payload["pins"] if payload else lua.table()
                        for _, pin in pins.items():
                            assert pin["mapID"] > 0 and 0 <= pin["x"] <= 1 and 0 <= pin["y"] <= 1
                        if profile is None:
                            if navigation_id:
                                added[kind, identity]["references"] = sorted({
                                    f"{REPOSITORY}/blob/{REVISION}/db/Standard/Categories/{record['file']}.lua"
                                    for _, record in catalog.GetCollectionSourceRecords(catalog, kind, patch, entry).items() if record["file"]})
                            checked.append({**added[kind, identity], "name": title, "patch": patch, "pinCount": len(pins), "areaOnly": bool(payload and payload["areaOnly"]), "mapID": payload["mapID"] if payload else None})
                    if has_action: continue
                    text = "\n".join(strings(details, achievement=kind == "achievements") + strings(entry, achievement=kind == "achievements") + strings(catalog.GetCollectionAcquisitionText(catalog, kind, patch, entry)))
                    known_location = kind == "achievements" and identity in known_achievement_locations
                    if not known_location and not COORDINATES.search(text) and not named_place.search(text): continue
                    exclusion = overrides.get(f"{kind}:{identity}", {}).get("exclude")
                    info = catalog.GetCollectionSourceInfo(catalog, kind, patch, entry)
                    if info and info["kind"] in ("Unavailable", "Unverified"):
                        exclusion = "No implemented or verified acquisition source; the old journal's place label does not establish a collectible spawn."
                    item = {"type": kind, "patch": patch, "id": identity, "name": title}
                    if exclusion: excluded[kind, identity] = {**item, "reason": exclusion}
                    else:
                        issue = unresolved.setdefault((kind, identity), {**item, "text": text, "contexts": []})
                        issue["contexts"].append(profile)
    excluded, unresolved = list(excluded.values()), list(unresolved.values())
    restricted_locations = Counter(row["type"] for row in additions if row["hadUnrestrictedAction"] and row["missingContexts"])
    restricted_actions = restricted_locations + Counter({"mounts": len(navigation_repairs)})
    assert len(checked) == len(added), "A location target vanished from its original catalog"
    report = {"reviewedAt": "2026-10-29", "scanned": dict(scanned), "restoredActions": dict(Counter(row["type"] for row in checked)),
              "totalRestored": len(checked), "remainingSpatialDescriptionsWithoutAction": len(unresolved),
              "characterContextChecks": character_checks,
              "characterRestrictedFallbacks": dict(restricted_locations),
              "characterRestrictedActions": dict(restricted_actions),
              "achievementActionRepairs": len(navigation_repairs),
              "excludedNonSpatialDescriptions": excluded, "restored": checked, "unresolved": unresolved,
              "scope": "All runtime catalog entries through actual Collections and Favorites action methods, with both factions and representatives of every distinct class/race eligibility combination in source and quest records. Includes characters unable to acquire an inspected item. Hidden mount archives stay hidden. Live WoW rendering and native quest state are not exercised."}
    (ROOT / "Docs/DescriptionMapAudit.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    lines = ["# Locations described without a Map action", "", "Audit date: 2026-10-29.", "",
             f"Scanned {sum(scanned.values()):,} entries. Fixed and verified {len(checked)} map/achievement actions; {len(unresolved)} spatial descriptions remain without an action.", "",
             f"Verified {character_checks:,} character contexts through both Collections and Favorites. Both factions and distinct source/quest class and race restrictions are exercised, including ineligible characters viewing another faction or class's collectible.", "",
             "The initial audit omitted character identity and missed locations hidden by eligibility filtering. The compiled fallback now preserves those items' recorded destinations for inspection; acquiring the item and choosing a live quest destination still respect the character's restrictions.", "",
             "Stored guide coordinates and pinned source records are compiled offline into a shared lookup table. Existing authored routes and character quest progression take priority. Named zones without coordinates open the source area and receive no invented center pin. Instance-only coordinates identify the entrance. The Map button continues to open a rewarding achievement inside the addon for achievement mounts. Patch headings and achievement names alone are not travel instructions.", "",
             "| Type | Fixed and verified actions |", "| --- | ---: |"]
    for kind, count in Counter(row["type"] for row in checked).items(): lines.append(f"| {kind} | {count} |")
    lines += ["", "## Character restrictions missed by the original audit", "",
              "These entries already had destinations without a character identity, but lost them in at least one faction, class or race context. They now retain inspection destinations or the rewarding achievement action.", "",
              "| Type | Additional entries fixed |", "| --- | ---: |"]
    for kind, count in report["characterRestrictedActions"].items(): lines.append(f"| {kind} | {count} |")
    lines += ["", "## Explicit exclusions", ""]
    for row in excluded: lines.append(f"- {row['name']} ({row['id']}): {row['reason']}")
    lines += ["", "## Restored entries", "", "| Entry | Type | Patch | ID | Destination |", "| --- | --- | --- | ---: | --- |"]
    for row in checked:
        destination = f"Achievement {row['navigationAchievementId']}" if row.get("navigationAchievementId") else "Source area" if row["areaOnly"] else f"{row['pinCount']} recorded pin(s)"
        lines.append(f"| {row['name'].replace('|', '/')} | {row['type']} | {row['patch']} | {row['id']} | {destination} |")
    lines += ["", "Per-entry source evidence and compiled locations: `Data/Sources/DescriptionLocations.json`. Research snapshots remain outside the addon. Native `/reload` validation is still pending.", ""]
    (ROOT / "Docs/DescriptionMapAudit.md").write_text("\n".join(lines), encoding="utf-8")
    expansion_coverage = {major: {patch: values for patch, values in achievement_coverage.items()
        if patch.split(".")[0] == major} for major in ("11", "12")}
    totals = {major: {key: sum(values[key] for values in patches.values()) for key in ("total", "mapped", "pins", "areas")}
        for major, patches in expansion_coverage.items()}
    achievement_report = {"reviewedAt": "2026-10-29", "coverageByPatch": achievement_coverage,
        "warWithin": totals["11"], "midnight": totals["12"],
        "knownSpatialSourcesWithoutAction": sum(row["type"] == "achievements" for row in unresolved),
        "withoutRecordedDestination": unmapped_achievements,
        "scope": "Real Collections/Favorites action methods and compiled map payloads. Known source locations are checked independently of generic guide text. Entries without verified fixed destinations remain listed, not counted as fixed. Native WoW rendering and journal data are not exercised."}
    (ROOT / "Docs/AchievementMapAudit.json").write_text(json.dumps(achievement_report, indent=2) + "\n", encoding="utf-8")
    achievement_lines = ["# Achievement Map coverage", "", "Audit date: 2026-10-29.", "",
        "The previous compiler required the stored guide to contain geography. Shared `Complete the achievement's listed criteria.` text discarded researched achievement locations, while live journal descriptions were not part of the offline prose scan. Known source destinations now enable Map independently of either description.", "",
        "The criteria research tool accepts any expansion (`--expansion`). It was initially limited to War Within; Midnight's missing criteria locations were subsequently researched with the same pipeline.", ""]
    for major, label, baseline in (("11", "The War Within", 2), ("12", "Midnight", 249)):
        counts = totals[major]
        achievement_lines += [f"## {label}", "",
            f"{counts['mapped']:,} of {counts['total']:,} achievements have verified destinations (before this expansion's additional research: {baseline:,}).", "",
            "| Patch | Entries | Map actions | Pins | Areas |", "| --- | ---: | ---: | ---: | ---: |"]
        for patch, values in expansion_coverage[major].items():
            achievement_lines.append(f"| {patch} | {values['total']} | {values['mapped']} | {values['pins']} | {values['areas']} |")
        achievement_lines.append("")
    achievement_lines += ["The UI regression opens the actual War Within and Midnight achievement tabs, paints every row, and clicks both row and inspector Map controls for every mapped achievement in Collections and Favorites on both factions. Areas receive no invented pin; instance coordinates identify the entrance.", "",
        "Entries below are not counted as repaired map actions. A missing source record does not prove an achievement is non-spatial; it can also be a data gap. Fixed-location coverage and unresolved records are reported separately. Native client verification remains pending.", ""]
    for major, label in (("12", "Midnight"), ("11", "War Within")):
        achievement_lines += [f"## {label} entries without a recorded destination", "",
            "| Patch | Achievement ID | Name | Catalog category |", "| --- | ---: | --- | --- |"]
        for row in unmapped_achievements:
            if row["patch"].split(".")[0] == major:
                achievement_lines.append(f"| {row['patch']} | {row['id']} | {(row.get('name') or '').replace('|', '/')} | {row['category'] or 'Other'} |")
        achievement_lines.append("")
    (ROOT / "Docs/AchievementMapAudit.md").write_text("\n".join(achievement_lines) + "\n", encoding="utf-8")
    print(json.dumps({"achievementCoverage": achievement_report["warWithin"],
        "midnightCoverage": achievement_report["midnight"],
        "knownAchievementLocationsWithoutAction": achievement_report["knownSpatialSourcesWithoutAction"]}))
    print(json.dumps({k:v for k,v in report.items() if k not in ("restored", "unresolved", "excludedNonSpatialDescriptions")}, sort_keys=True))
    for row in unresolved: print("UNRESOLVED", row["type"], row["id"], row["name"])
    assert not unresolved, "Geographic descriptions still have no working map action"


if __name__ == "__main__": main()
