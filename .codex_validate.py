# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///

import re
from pathlib import Path

from lupa import LuaRuntime


ROOT = Path(__file__).resolve().parent
CATALOG_PATH = ROOT / "Data" / "PatchCatalog.lua"
GENERATED_PATH = ROOT / "Data" / "GeneratedPatchCollections.lua"
TOC_PATH = ROOT / "TODO-Planner.toc"

EXPECTED_COUNTS = {
    "7.0.0": (21, 89, 68, 154, 242),
    "7.1.0": (9, 25, 8, 12, 37),
    "7.1.5": (6, 4, 4, 108, 38),
    "7.2.0": (29, 11, 8, 299, 66),
    "7.2.5": (5, 10, 17, 6, 48),
    "7.3.0": (26, 39, 16, 81, 50),
    "7.3.5": (13, 1, 1, 42, 98),
    "8.0.0": (46, 120, 43, 34, 364),
    "8.1.0": (26, 41, 26, 18, 98),
    "8.1.5": (8, 13, 3, 20, 29),
    "8.2": (31, 90, 31, 18, 156),
    "8.2.5": (1, 4, 0, 0, 2),
    "8.3.0": (26, 33, 15, 52, 101),
    "8.3.7": (0, 0, 0, 0, 0),
    "9.1": (45, 45, 23, 94, 113),
    "9.1.5": (3, 0, 14, 2, 9),
    "9.1.7": (0, 0, 0, 0, 0),
    "9.2": (41, 53, 13, 22, 107),
    "9.2.5": (7, 0, 2, 3, 45),
    "9.2.7": (0, 0, 0, 0, 0),
    "10.0": (39, 99, 59, 341, 631),
    "10.0.5": (1, 1, 3, 7, 116),
    "10.0.7": (4, 18, 15, 29, 103),
    "10.1": (15, 42, 12, 18, 228),
    "10.1.5": (11, 17, 8, 119, 47),
    "10.1.7": (4, 1, 8, 23, 135),
    "10.2": (25, 29, 6, 123, 246),
    "10.2.5": (3, 2, 1, 51, 12),
    "10.2.6": (18, 3, 2, 0, 68),
    "10.2.7": (29, 2, 2, 11, 158),
    "11.0": (36, 111, 31, 126, 910),
    "11.0.5": (1, 0, 0, 99, 0),
    "11.0.7": (14, 15, 4, 77, 56),
    "11.1": (31, 46, 18, 136, 230),
    "11.1.5": (12, 4, 4, 51, 123),
    "11.1.7": (4, 2, 2, 1, 29),
    "11.2": (24, 22, 7, 72, 200),
    "11.2.5": (44, 3, 3, 187, 254),
    "11.2.7": (12, 1, 3, 24, 87),
    "12.0": (57, 67, 5, 93, 54),
    "12.0.5": (15, 12, 2, 67, 21),
    "12.0.7": (7, 7, 6, 74, 21),
    "12.1": (24, 28, 14, 33, 327),
}

COLLECTION_ID_FIELDS = {
    "mounts": "spellId",
    "pets": "speciesId",
    "toys": "itemId",
    "cosmetics": "itemId",
}

PROHIBITED_DETAIL_TERMS = (
    "trading post", "traveler's log", "in-game shop", "battle.net shop",
    "promotion", "promotional", "twitch", "discord quest", "blizzcon",
    "china-only", "regional promotion", "subscription bundle",
    "holiday", "midsummer", "winter veil", "noblegarden", "children's week",
    "brewfest", "hallow's end", "lunar festival", "love is in the air",
    "headless horseman", "abominable greench",
)


def lua_entries(table):
    index = 1
    while table is not None and table[index] is not None:
        yield table[index]
        index += 1


def lua_strings(value, seen=None):
    if isinstance(value, str):
        return [value]
    if value is None or not hasattr(value, "items"):
        return []

    seen = seen or set()
    identity = id(value)
    if identity in seen:
        return []
    seen.add(identity)

    strings = []
    for key, nested_value in value.items():
        if key in {"researchNotes", "tips"}:
            continue
        strings.extend(lua_strings(key, seen))
        strings.extend(lua_strings(nested_value, seen))
    return strings


def contains_prohibited_term(text):
    return any(re.search(rf"\b{re.escape(term)}\b", text) for term in PROHIBITED_DETAIL_TERMS)


def load_lua_file(lua, tdp, path):
    source = path.read_text(encoding="utf-8-sig")
    chunk = lua.execute("return function(...)\n" + source + "\nend")
    chunk("TODO-Planner", tdp)


toc = TOC_PATH.read_text(encoding="utf-8-sig")
generated_index = toc.index("Data/GeneratedPatchCollections.lua")
catalog_index = toc.index("Data/PatchCatalog.lua")
assert generated_index < catalog_index, "generated collection data must load before PatchCatalog.lua"

catalog_text = CATALOG_PATH.read_text(encoding="utf-8-sig")
generated_text = GENERATED_PATH.read_text(encoding="utf-8-sig")
assert "remain intentionally empty" not in catalog_text
assert "remains intentionally empty" not in catalog_text

known_maps = {
    int(value)
    for value in re.findall(
        r'^\s*\[(\d+)\] = "',
        catalog_text[catalog_text.index("local MAP_NAMES"):catalog_text.index("local SILVERMOON_DELVES_WAYPOINTS")],
        re.MULTILINE,
    )
}
used_maps = {int(value) for value in re.findall(r"/way #(\d+)", catalog_text + generated_text)}
assert not used_maps - known_maps, ("unknown map IDs", sorted(used_maps - known_maps))

lua = LuaRuntime(unpack_returned_tuples=True)
tdp = lua.table()
load_lua_file(lua, tdp, GENERATED_PATH)
load_lua_file(lua, tdp, CATALOG_PATH)
catalog = tdp["PatchCatalog"]

patch_keys = list(lua_entries(catalog["GetPatchKeys"](catalog)))
assert patch_keys == list(EXPECTED_COUNTS), ("patch keys", patch_keys)
assert catalog["patches"]["Unknown"] is None, "Unknown patch bucket must stay hidden"

seen = {collection: {} for collection in (*COLLECTION_ID_FIELDS, "achievements")}
totals = {collection: 0 for collection in (*COLLECTION_ID_FIELDS, "achievements")}

for patch_key in patch_keys:
    patch = catalog["patches"][patch_key]
    actual_counts = []

    for collection, id_field in COLLECTION_ID_FIELDS.items():
        rows = list(lua_entries(patch[collection]))
        actual_counts.append(len(rows))
        totals[collection] += len(rows)

        for entry in rows:
            row_id = entry[id_field]
            name = entry["name"]
            assert row_id is not None and int(row_id) > 0, (patch_key, collection, "missing ID")
            assert isinstance(name, str) and name.strip(), (patch_key, collection, row_id, "missing name")
            assert row_id not in seen[collection], (
                "duplicate ID", collection, int(row_id), seen[collection].get(row_id), patch_key,
            )
            seen[collection][row_id] = patch_key

            details = catalog["GetCollectionDetails"](catalog, collection, patch_key, entry)
            assert details is not None, (patch_key, collection, name, "missing details")
            detail_text = " ".join(lua_strings(entry) + lua_strings(details)).lower()
            assert not contains_prohibited_term(detail_text), (
                patch_key, collection, name, detail_text,
            )

    achievements = list(lua_entries(patch["achievements"]["ids"]))
    actual_counts.append(len(achievements))
    totals["achievements"] += len(achievements)
    for achievement_id in achievements:
        assert achievement_id not in seen["achievements"], (
            "duplicate achievement", int(achievement_id),
            seen["achievements"].get(achievement_id), patch_key,
        )
        seen["achievements"][achievement_id] = patch_key
        details = catalog["GetAchievementDetails"](catalog, patch_key, achievement_id)
        assert details is not None, (patch_key, int(achievement_id), "missing achievement details")
        detail_text = " ".join(lua_strings(details)).lower()
        assert not contains_prohibited_term(detail_text), (
            patch_key, "achievements", int(achievement_id), detail_text,
        )

    expected = EXPECTED_COUNTS[patch_key]
    assert tuple(actual_counts) == expected, (patch_key, tuple(actual_counts), expected)
    print(
        f"{patch_key}: {actual_counts[0]} mounts, {actual_counts[1]} pets, "
        f"{actual_counts[2]} toys, {actual_counts[3]} cosmetics, "
        f"{actual_counts[4]} achievements"
    )

print("Totals:", ", ".join(f"{name}={count}" for name, count in totals.items()))
print(f"Map IDs: {len(used_maps)} used, all resolved")
print("Catalog runtime validation passed")
