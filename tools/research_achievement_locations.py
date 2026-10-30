# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Resolve unlocated achievements from public criteria and pinned sources.

Network access is explicit (--download). Tooltips and full external trees stay
in TEMP; only compact spatial evidence is exported, never loaded in WoW.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
from html import unescape
import json
import re

from lupa.lua51 import LuaRuntime, lua_type

from catalog_support import ROOT
from description_map_support import load_context
from import_collection_sources import CATEGORIES, REPOSITORY, REVISION, load_external, points, source_maps
from research_acquisition_guides import CACHE, tooltip

OUTPUT = ROOT / "Data/Sources/AchievementLocationEvidence.json"
# Tooltip type 165 uses combat-log encounter IDs. ATT Encounter constructors
# use Dungeon Journal IDs; those namespaces must never be joined by number.
TYPES = {0: "npc", 8: "achievement", 27: "quest", 29: "spell", 36: "item",
         41: "item", 68: "object", 72: "object", 158: "npc"}
CRITERIA = re.compile(r"<!--cr\d+:(\d+):(\d+)-->([^<]*)")


def plain_text(value):
    return " ".join(unescape(re.sub(r"<[^>]+>", " ", value)).split())


def original_title(value):
    return re.sub(r"\s*\((?:char(?:acter)? specific )?hidden copy\)\s*$", "", value, flags=re.I).strip()


def merge(routes):
    routes = [route for route in routes if route]
    if not routes: return None
    pins, areas = [], set()
    for route in routes:
        for pin in route.get("waypoints", []):
            if pin not in pins: pins.append(pin)
        areas.update(route.get("areaMaps", []))
    if not areas: return {"waypoints": pins[:40]} if pins else None
    # Mixed criteria must retain every destination. Use honest source areas
    # rather than discarding area-only criteria or inventing precise positions.
    areas.update(pin["mapID"] for pin in pins)
    return {"areaMaps": sorted(areas)[:40]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--download", action="store_true")
    parser.add_argument("--expansion", action="append", help="Expansion major version, e.g. 12; repeat or omit for all")
    parser.add_argument("--list", action="store_true", help="List targets without downloading or changing evidence")
    args = parser.parse_args()
    lua = LuaRuntime(unpack_returned_tuples=True)
    ns, _, _ = load_context(lua)
    catalog = ns.PatchCatalog
    selected_expansions = set(args.expansion or [str(patch).split(".")[0] for _, patch in catalog.GetPatchKeys(catalog).items()])
    # Ignore this tool's previous output so a rerun never drops its own targets.
    previous = json.loads(OUTPUT.read_text(encoding="utf-8")) if OUTPUT.exists() else {"resolved": []}
    supplemental_ids = {row["id"] for row in previous["resolved"]}
    targets, mapped = [], []
    for _, patch in catalog.GetPatchKeys(catalog).items():
        if patch.split(".")[0] not in selected_expansions: continue
        for _, identity in catalog.GetEntries(catalog, patch, "achievements").items():
            if identity in supplemental_ids or not catalog.HasCollectionMapPayload(catalog, "achievements", patch, identity):
                targets.append({"id": identity, "patch": patch})
            else:
                mapped.append({"id": identity, "patch": patch})
    print(json.dumps({"expansions": sorted(selected_expansions), "unlocatedTargets": len(targets), "download": args.download}), flush=True)
    if args.list: return
    metadata, errors = {}, {}

    def fetch(target):
        identity = target["id"]
        cached = CACHE / "tooltips" / f"achievement-{identity}.json"
        try:
            if not args.download and not cached.exists(): return identity, None, "Tooltip not cached"
            return identity, tooltip("achievement", identity), None
        except Exception as error: return identity, None, str(error)

    downloads = targets + mapped
    with ThreadPoolExecutor(max_workers=8) as pool:
        for index, (identity, value, error) in enumerate(pool.map(fetch, downloads), 1):
            if value: metadata[identity] = value
            else: errors[identity] = error
            if index % 100 == 0: print(f"Reviewed {index}/{len(downloads)} tooltips", flush=True)
    if errors:
        print(json.dumps({"tooltipErrors": len(errors), "examples": list(errors.items())[:8]}), flush=True)
    failed_targets = {row["id"] for row in targets} & errors.keys()
    if failed_targets:
        raise SystemExit("Target descriptions are missing; evidence was not changed. Retry with --download.")
    wanted = set()
    overrides = json.loads((ROOT / "Data/Sources/AchievementLocationOverrides.json").read_text(encoding="utf-8"))
    wanted.update(("achievement", row["sourceAchievement"]) for row in overrides.values() if row.get("sourceAchievement"))
    criteria, criterion_labels = {}, {}
    for identity, value in metadata.items():
        links = [(TYPES[int(kind)], int(entity)) for kind, entity, _ in CRITERIA.findall(value.get("tooltip", ""))
                 if int(kind) in TYPES and int(entity) > 0]
        criteria[identity] = links
        criterion_labels[identity] = {(TYPES[int(kind)], int(entity)): plain_text(label).lstrip("- ")
            for kind, entity, label in CRITERIA.findall(value.get("tooltip", "")) if int(kind) in TYPES}
        wanted.update(links)
    canonical = {}
    target_names = {original_title(value["name"]) for value in metadata.values()}
    for path in (CACHE / "tooltips").glob("achievement-*.json"):
        value = json.loads(path.read_text(encoding="utf-8"))
        title = value.get("name", "")
        if title in target_names and title == original_title(title):
            identity = int(path.stem.split("-")[-1])
            canonical.setdefault(title, []).append(identity)
            wanted.add(("achievement", identity))
    _, categories = load_external(CACHE / "att")
    entities, giver_locations, quest_givers = {}, {}, {}

    def walk(node, parents, category):
        if lua_type(node) != "table": return
        path = parents + [node]
        keys = [(kind, node[field]) for kind, field in (("npc", "npcID"), ("quest", "questID"),
                    ("item", "itemID"), ("object", "objectID"), ("spell", "recipeID"),
                    ("achievement", "achievementID"))]
        if node["_constructor"] == "HQT": keys.append(("quest", node["trackingQuestID"]))
        # Creature criteria can reference an Encounter's explicit creature list.
        # Those IDs are safe to join; the journal encounter number is not.
        if node["_constructor"] == "Encounter":
            for _, identity in (node["crs"] or {}).items(): keys.append(("npc", identity))
        if node["_constructor"] == "Header" and node["type"] in ("a", "n", "o"):
            keys.append(({"a": "achievement", "n": "npc", "o": "object"}[node["type"]], node["headerID"]))
        if node["_constructor"] == "NPC" and points(node):
            record = {"coords": points(node), "maps": source_maps(path), "category": category,
                "historical": any(parent["u"] == 1 or parent["rwp"] and parent["rwp"] <= 120105 for parent in path)}
            if record not in giver_locations.setdefault(node["npcID"], []): giver_locations[node["npcID"]].append(record)
        for key in keys:
            if key not in wanted: continue
            if key[0] == "quest" and node["qgs"]:
                quest_givers.setdefault(key, set()).update(identity for _, identity in node["qgs"].items())
            instance = next((parent for parent in reversed(path) if parent["_constructor"] == "Instance" and points(parent)), None)
            own_coords = points(node)
            if key[0] == "npc" and not own_coords and instance is None and any(parent["_constructor"] == "Quest" for parent in path):
                # An objective NPC listed below a quest does not stand at the
                # quest giver. Resolve its own placement elsewhere in the tree.
                continue
            coords = points(instance) if instance is not None else next((points(parent) for parent in reversed(path) if points(parent)), [])
            maps = source_maps(path)
            if not coords and not maps: continue
            record = {"coords": coords, "maps": maps, "category": category,
                "placement": "instance" if instance is not None else "direct" if own_coords else "inherited",
                "historical": any(parent["u"] == 1 or parent["rwp"] and parent["rwp"] <= 120105 for parent in path)}
            if record not in entities.setdefault(key, []): entities[key].append(record)
        for _, child in (node["g"] or {}).items(): walk(child, path, category)

    for category in CATEGORIES:
        if category not in ("Promotions", "InGameShop", "TradingPost"): walk(categories[category], [], category)
    for key, givers in quest_givers.items():
        if key in entities: continue
        paths = [record for giver in givers for record in giver_locations.get(giver, [])]
        if paths: entities[key] = paths
    routes, references = {}, {}
    for key, paths in entities.items():
        active = [path for path in paths if not path["historical"]]
        selected = active or paths
        if key[0] == "npc":
            placed = [path for path in selected if path["coords"] and path.get("placement") in ("direct", "instance")]
            selected = placed or selected
        routes[key] = merge([{"waypoints": [{"mapID": mid, "x": x / 100, "y": y / 100,
            "label": "Achievement criterion location"} for mid, x, y in path["coords"]]}
            if path["coords"] else {"areaMaps": path["maps"]} for path in selected])
        references[key] = {f"{REPOSITORY}/blob/{REVISION}/db/Standard/Categories/{path['category']}.lua" for path in selected}
    activity_locations = {}
    authored_maps = {}
    compiled_references = {(row["type"], row["id"]): set(row["references"])
        for row in json.loads((ROOT / "Data/Sources/DescriptionLocations.json").read_text(encoding="utf-8"))}

    def authored_file(patch, kind):
        return next(ROOT.glob(f"Data/Expansions/*/{patch}/{kind.title()}.lua"), None)

    def activity(name, expansion, route, refs):
        if len(name) < 8 or not route: return
        activity_locations.setdefault(name.lower(), []).append((expansion, route, refs))

    # Reuse reviewed routes rather than guessing positions from a boss counter.
    # This also links a dungeon's Keystone achievement to its ordinary clear.
    for target in mapped:
        identity, patch = target["id"], target["patch"]
        if identity not in metadata: continue
        payload = catalog.GetCollectionMapPayload(catalog, "achievements", patch, identity)
        if payload is None: continue
        route = {"areaMaps": [mid for _, mid in payload.sourceAreaMaps.items()]} if payload.areaOnly else {
            "waypoints": [{"mapID": pin.mapID, "x": pin.x, "y": pin.y, "label": pin.label or metadata[identity]["name"]}
                for _, pin in payload.pins.items()]}
        path = authored_file(patch, "achievements")
        details = catalog.GetCollectionDetails(catalog, "achievements", patch, identity)
        refs = {path.relative_to(ROOT).as_posix()} if path and details and details.waypoints else compiled_references.get(("achievements", identity), set())
        routes["achievement", identity] = route
        references["achievement", identity] = refs
        activity(metadata[identity]["name"], patch.split(".")[0], route, refs)
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind in ("achievements", "mounts", "pets", "toys", "cosmetics"):
            path = authored_file(patch, kind)
            if path is None: continue
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                details = catalog.GetCollectionDetails(catalog, kind, patch, entry)
                if details is None: continue
                for _, point in (details.waypoints or {}).items():
                    pin = catalog.ParseWaypoint(catalog, point)
                    if pin is None or not pin.label: continue
                    authored_maps.setdefault(patch.split(".")[0], set()).add(pin.mapID)
                    label = pin.label.split(" /", 1)[0].strip()
                    name = re.sub(r"\s+(?:(?:Raid|Dungeon)\s+)?Entrance$", "", label, flags=re.I)
                    if name == label and " /" not in pin.label: continue
                    activity(name, patch.split(".")[0], {"waypoints": [{"mapID": pin.mapID, "x": pin.x, "y": pin.y,
                        "label": pin.label}]}, {path.relative_to(ROOT).as_posix()})
    reviewed_places = ROOT / "Data/Sources/AchievementPlaceLocations.json"
    if reviewed_places.exists():
        for place in json.loads(reviewed_places.read_text(encoding="utf-8")):
            route = {"areaMaps": place["maps"]} if place.get("maps") else {"waypoints": [
                {"mapID": mid, "x": x / 100, "y": y / 100, "label": label}
                for mid, x, y, label in place["waypoints"]]}
            activity_locations[place["name"].lower()] = [(place["expansion"], route, set(place["references"]))]
    activity_pattern = re.compile(r"(?<![A-Za-z])(?:" + "|".join(map(re.escape, sorted(activity_locations, key=len, reverse=True))) + r")(?![A-Za-z])", re.I)
    map_names = {}
    for mid, name in ns.CatalogMapNames.items():
        if len(name) > 4:
            map_names.setdefault(name, []).append(mid)
            if name.startswith("The "): map_names.setdefault(name[4:], []).append(mid)
    ordered_names = sorted(map_names, key=len, reverse=True)
    place_pattern = re.compile(r"(?<![A-Za-z])(?:" + "|".join(map(re.escape, ordered_names)) + r")(?![A-Za-z])", re.I)
    normalized_names = {name.lower(): maps for name, maps in map_names.items()}
    resolved = {}
    for _ in range(8):
        changed = False
        for target in targets:
            identity = target["id"]
            if identity in resolved or identity not in metadata: continue
            value = metadata[identity]
            override = overrides.get(str(identity), {})
            if override.get("noFixedDestination"):
                continue
            links = list(criteria[identity])
            if override.get("sourceAchievement"): links.insert(0, ("achievement", override["sourceAchievement"]))
            links += [("achievement", other) for other in canonical.get(original_title(value["name"]), []) if other != identity]
            criterion_routes = []
            for key in links:
                route = routes.get(key)
                if route and route.get("waypoints"):
                    label = criterion_labels[identity].get(key)
                    route = {"waypoints": [{**pin, "label": label or pin["label"]} for pin in route["waypoints"]]}
                criterion_routes.append(route)
            geometry = merge(criterion_routes)
            used = set().union(*(references.get(key, set()) for key in links))
            if override.get("maps"): geometry = {"areaMaps": override["maps"]}
            if override.get("waypoints"):
                geometry = {"waypoints": [{"mapID": mid, "x": x / 100, "y": y / 100, "label": label}
                    for mid, x, y, label in override["waypoints"]]}
            used.update(override.get("references", []))
            if not geometry and not override.get("disableNamedFallback"):
                text = plain_text(value.get("tooltip", ""))
                expansion = target["patch"].split(".")[0]
                named_routes = []
                for match in activity_pattern.finditer(text):
                    choices = activity_locations[match.group().lower()]
                    choices = [choice for choice in choices if choice[0] == expansion] or choices
                    for _, route, refs in choices:
                        named_routes.append(route)
                        used.update(refs)
                matches = list(place_pattern.finditer(text))
                maps = set()
                for match in matches:
                    candidates = normalized_names[match.group().lower()]
                    preferred = [mid for mid in candidates if mid in authored_maps.get(expansion, set())]
                    maps.update(preferred or candidates)
                if maps and not named_routes: named_routes.append({"areaMaps": sorted(maps)[:40]})
                geometry = merge(named_routes)
            if not geometry: continue
            source_url = f"https://nether.wowhead.com/tooltip/achievement/{identity}?dataEnv=1&locale=0"
            resolved[identity] = {**target, "type": "achievements", "name": value["name"], "locations": geometry,
                "references": [source_url, *sorted(used)], "method": "Documented criterion locations" if used else "Named achievement area"}
            routes["achievement", identity] = geometry
            references["achievement", identity] = set(resolved[identity]["references"])
            changed = True
        if not changed: break
    unresolved = [{**target, "name": metadata.get(target["id"], {}).get("name"),
        "description": plain_text(metadata.get(target["id"], {}).get("tooltip", "")),
        "reason": errors.get(target["id"]) or overrides.get(str(target["id"]), {}).get("reason")
            or "No fixed destination resolved from named areas or indexed criteria"}
        for target in targets if target["id"] not in resolved]
    retained_resolved = [row for row in previous["resolved"] if row["patch"].split(".")[0] not in selected_expansions]
    retained_unresolved = [row for row in previous.get("unresolved", []) if row["patch"].split(".")[0] not in selected_expansions]
    report = {"reviewedAt": "2026-10-30", "resolved": retained_resolved + list(resolved.values()),
              "unresolved": retained_unresolved + unresolved}
    OUTPUT.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"resolved": len(resolved), "unresolved": len(unresolved), "tooltipErrors": len(errors)}), flush=True)


if __name__ == "__main__": main()
