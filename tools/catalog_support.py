"""Shared manifest loading and deterministic catalog snapshots for checks."""

import hashlib
import json
from pathlib import Path
import xml.etree.ElementTree as ET

from lupa.lua51 import lua_type


ROOT = Path(__file__).resolve().parents[1]


def manifest_scripts(path):
    """Follow the same ordered Script/Include files as the WoW XML loader."""
    path = path.resolve()
    assert path.is_relative_to(ROOT), f"Manifest escapes addon: {path}"
    assert path.is_file(), f"Missing manifest file: {path}"
    if path.suffix == ".lua":
        yield path
        return
    for node in ET.parse(path).getroot():
        tag = node.tag.rsplit("}", 1)[-1]
        if tag in {"Script", "Include"}:
            yield from manifest_scripts(path.parent / node.attrib["file"])


def load_file(lua, namespace, path):
    source = path.read_text(encoding="utf-8-sig")
    lua.execute("return function(...)\n" + source + "\nend")("TODO-Planner", namespace)


def load_catalog(lua):
    namespace = lua.table()
    for path in manifest_scripts(ROOT / "Data/Catalog.xml"):
        load_file(lua, namespace, path)
    return namespace["PatchCatalog"]


def plain(value):
    """Keep numeric/string keys distinct and retain array ordering and holes."""
    if lua_type(value) == "table":
        return [
            [key, plain(nested)]
            for key, nested in sorted(value.items(), key=lambda item: (type(item[0]).__name__, item[0]))
            if lua_type(nested) != "function"
        ]
    return value


def digest(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, separators=(",", ":")).encode()).hexdigest()


def snapshot(catalog):
    fields = ("patches", "mountDetails", "petDetails", "toyDetails", "cosmeticDetails",
              "achievementDetails", "achievementCategories")
    result = {}
    patches = catalog.GetPatchKeys(catalog)
    for index in range(1, len(patches) + 1):
        patch = patches[index]
        for field in fields:
            result[f"{patch}/{field}"] = digest(plain(catalog[field][patch]))
        resolved = []
        for kind in ("mounts", "pets", "toys", "cosmetics", "achievements"):
            entries = catalog.GetEntries(catalog, patch, kind)
            for entry_index in range(1, len(entries) + 1):
                entry = entries[entry_index]
                resolved.append([
                    kind, plain(entry),
                    plain(catalog.GetCollectionDetails(catalog, kind, patch, entry)),
                    plain(catalog.GetCollectionMapPayload(catalog, kind, patch, entry)),
                    catalog.GetCollectionFaction(catalog, kind, patch, entry),
                    plain(catalog.GetCollectionAvailability(catalog, kind, patch, entry)),
                    catalog.IsCollectionUnobtainable(catalog, kind, patch, entry),
                ])
        result[f"{patch}/resolved"] = digest(resolved)
    result["availability"] = digest(plain(catalog.collectionAvailability))
    result["availabilityReviewedAt"] = catalog.collectionAvailabilityReviewedAt
    return result
