# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Verify every former journal placeholder through the real runtime getter."""
from collections import Counter
import hashlib
import json
import re

from lupa.lua51 import LuaRuntime

from catalog_support import ROOT, load_catalog, manifest_scripts


def main():
    targets = json.loads((ROOT / "Data/Sources/AcquisitionGuideTargets.json").read_text(encoding="utf-8"))
    rows = json.loads((ROOT / "Data/Sources/AcquisitionGuides.json").read_text(encoding="utf-8"))
    guides = {(row["type"], row["id"]): row for row in rows}
    assert len(guides) == len(rows) == len(targets) == 725
    assert set(guides) == {(row["type"], row["id"]) for row in targets}
    lua = LuaRuntime(unpack_returned_tuples=True)
    catalog = load_catalog(lua)
    checked = Counter()
    for target in targets:
        kind, identity = target["type"], target["id"]
        field = {"mounts": "spellId", "pets": "speciesId", "toys": "itemId"}[kind]
        entry = next(entry for _, entry in catalog.GetEntries(catalog, target["patch"], kind).items() if entry[field] == identity)
        row = guides[kind, identity]
        text = catalog.GetCollectionAcquisitionText(catalog, kind, target["patch"], entry)
        assert text == row["text"], (kind, identity, "Guide does not reach the UI getter")
        assert len(text) >= 65 and row["references"], (kind, identity, "Missing guide or research")
        assert not re.search(r"Follow the in-game|\[DNT\]|\bDebug\b|\bNone\b|\bmap \d+|\|H|<[^>]+>", text), (kind, identity, "Unusable guide text")
        checked[kind] += 1
    for path in manifest_scripts(ROOT / "Data/Catalog.xml"):
        assert "Follow the in-game" not in path.read_text(encoding="utf-8-sig"), path
    report = {"reviewedAt": "2026-10-28", "verifiedGuides": dict(checked), "total": sum(checked.values()),
              "journalPlaceholders": 0, "methods": dict(Counter(row["method"] for row in rows)),
              "runtimeDataSha256": hashlib.sha256((ROOT / "Data/Sources/CollectionAcquisitionGuides.lua").read_bytes()).hexdigest(),
              "scope": "Offline coverage and runtime getter validation. Acquisition evidence is recorded per item. Native WoW interactions and current event scheduling are not exercised."}
    (ROOT / "Docs/AcquisitionGuideAudit.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    lines = ["# Acquisition guide replacements", "", "Replaces all 725 stored Mount Journal, Pet Journal and Toy Box handoffs (682 still reached the UI before this change; 43 already had researched overrides).", "",
             "The compiled Lua file contains only static text keyed by spell, species or item ID. Research HTML and full external databases are never loaded by the addon. Existing character quest progression and map navigation continue through the bounded source index.", "",
             "Retired events explain their original requirements and availability. Non-collectible opponents and unreleased entries are identified explicitly; no fabricated farming route is supplied. Gleam remains unconfirmed.", "",
             "Validation: all 725 identities still exist, their real acquisition getter returns the recorded guide, all guides have evidence references, and no loaded catalog script contains the journal handoff wording.", ""]
    for row in rows:
        lines += [f"## {row['name']} ({row['type']} {row['id']}, patch {row['patch']})", "", row["text"], "",
                  "Evidence: " + ", ".join(f"[source {i + 1}]({url})" for i, url in enumerate(row["references"])), ""]
    (ROOT / "Docs/AcquisitionGuides.md").write_text("\n".join(lines), encoding="utf-8")
    print(json.dumps(report, sort_keys=True))


if __name__ == "__main__": main()
