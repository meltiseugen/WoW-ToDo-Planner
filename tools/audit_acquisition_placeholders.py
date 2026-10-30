# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""List catalog entries whose acquisition text delegates guidance to a game journal."""
from collections import Counter, defaultdict
import json

from lupa.lua51 import LuaRuntime, lua_type

from catalog_support import ROOT, load_catalog, manifest_scripts


TEXTS = {
    "mount_journal": "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    "pet_journal": "Follow the in-game Pet Journal source for this permanent battle pet.",
    "toy_box": "Follow the in-game Toy Box source for this permanent toy.",
}
LABELS = {"mount_journal": "Exact screenshot wording", "pet_journal": "Pet Journal equivalent", "toy_box": "Toy Box equivalent", "other_journal": "Other journal handoff"}
ID_FIELDS = {"mounts": "spellId", "pets": "speciesId", "toys": "itemId", "cosmetics": "itemId", "achievements": "achievementId"}
EXPANSIONS = {"1": "Classic", "2": "The Burning Crusade", "3": "Wrath of the Lich King", "4": "Cataclysm", "5": "Mists of Pandaria", "6": "Warlords of Draenor", "7": "Legion", "8": "Battle for Azeroth", "9": "Shadowlands", "10": "Dragonflight", "11": "The War Within", "12": "Midnight"}


def family(value):
    normalized = " ".join(str(value or "").split())
    for key, text in TEXTS.items():
        if normalized == text:
            return key
    if normalized.startswith("Follow the in-game ") and ("Journal" in normalized or "Toy Box" in normalized):
        return "other_journal"
    return None


def md(value):
    return str(value or "").replace("|", "\\|").replace("\n", " ")


def audit():
    lua = LuaRuntime(unpack_returned_tuples=True)
    catalog = load_catalog(lua)
    files, definitions = {}, []
    types_by_file = {"Mounts": "mounts", "Pets": "pets", "Toys": "toys", "Cosmetics": "cosmetics", "Achievements": "achievements"}
    for path in manifest_scripts(ROOT / "Data/Catalog.xml"):
        if path.stem in types_by_file and "Expansions" in path.parts:
            files[(path.parent.name, types_by_file[path.stem])] = path
        for number, line in enumerate(path.read_text(encoding="utf-8-sig").splitlines(), 1):
            for key, text in TEXTS.items():
                if text in line:
                    definitions.append({"family": key, "file": path.relative_to(ROOT).as_posix(), "line": number})
    rows = []
    scanned = Counter()
    for _, patch in catalog.GetPatchKeys(catalog).items():
        for kind, field in ID_FIELDS.items():
            for _, entry in catalog.GetEntries(catalog, patch, kind).items():
                scanned[kind] += 1
                details = catalog.GetCollectionDetails(catalog, kind, patch, entry)
                raw = details["acquisition"] if details else None
                if not raw and lua_type(entry) == "table": raw = entry["acquisition"]
                effective = catalog.GetCollectionAcquisitionText(catalog, kind, patch, entry)
                raw_family, effective_family = family(raw), family(effective)
                if not raw_family and not effective_family: continue
                item_id = entry[field] if lua_type(entry) == "table" else entry
                name = entry["name"] if lua_type(entry) == "table" else (details["name"] if details else None)
                info = catalog.GetCollectionSourceInfo(catalog, kind, patch, entry)
                availability = catalog.GetCollectionAvailability(catalog, kind, patch, entry)
                path = files.get((patch, kind))
                rows.append({"type": kind, "patch": patch, "expansion": EXPANSIONS.get(patch.split(".")[0], patch),
                    "id": item_id, "name": name or f"{kind} #{item_id}",
                    "family": effective_family or raw_family, "stillReturned": effective_family is not None,
                    "rawAcquisition": raw, "effectiveAcquisition": effective,
                    "catalogSource": details["source"] if details else None,
                    "structuredSource": info["summary"] if info else None,
                    "hasLocation": bool(catalog.HasCollectionMapPayload(catalog, kind, patch, entry)),
                    "availabilityReason": availability["reason"] if availability else None,
                    "file": path.relative_to(ROOT).as_posix() if path else None})
    active = [row for row in rows if row["stillReturned"]]
    summary = {key: {"stillReturned": sum(row["stillReturned"] and row["family"] == key for row in rows),
                     "storedCatalogEntries": sum(row["family"] == key for row in rows),
                     "storedDefinitions": sum(row["family"] == key for row in definitions)}
               for key in LABELS if any(row["family"] == key for row in rows)}
    report = {"reviewedAt": "2026-10-28", "scope": "All runtime catalog entries after catalog policy filters. No live character, ownership or quest APIs; visibility can vary with filters and eligibility.",
              "scanned": dict(scanned), "summary": summary, "stillReturned": len(active),
              "storedCatalogEntries": len(rows), "alreadyOverridden": len(rows) - len(active),
              "entries": rows, "definitions": definitions}
    assert len({(row["type"], row["patch"], row["id"]) for row in rows}) == len(rows), "Duplicate audit identity"
    assert all(family(row["effectiveAcquisition"]) for row in active), "Audit must reflect the actual acquisition getter"
    return report


def write_report(report):
    (ROOT / "Docs/PlaceholderAcquisitionAudit.json").write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    lines = ["# Journal placeholder acquisition text", "", f"Audited on {report['reviewedAt']} using the same acquisition getter used by the addon.",
        "Shared text definitions are counted separately from affected items. This report lists every affected catalog entry, including entries whose stored placeholder is already replaced by researched guidance.",
        "Ownership, current quest progress and eligibility are not read from a live character. An entry listed here can be hidden by status, faction, class or retired-source filters.", "",
        "| Wording | Still returned by the addon | Catalog entries storing it | Shared/inline definitions |", "| --- | ---: | ---: | ---: |"]
    for key, value in report["summary"].items():
        lines.append(f"| {LABELS[key]} | {value['stillReturned']} | {value['storedCatalogEntries']} | {value['storedDefinitions']} |")
    lines += ["", "## Wording", ""]
    for key, text in TEXTS.items(): lines += [f"**{LABELS[key]}**", "", text, ""]
    lines += ["## Entries still using the placeholder", ""]
    active = [row for row in report["entries"] if row["stillReturned"]]
    groups = defaultdict(list)
    for row in active: groups[(row["type"], row["expansion"], row["patch"])].append(row)
    for (kind, expansion, patch), entries in groups.items():
        lines += [f"### {expansion} / {patch} / {kind} ({len(entries)})", "",
                  "| Item | ID | Recorded source | Structured acquisition source | Location | Catalog |", "| --- | ---: | --- | --- | --- | --- |"]
        for row in sorted(entries, key=lambda row: (row["name"].lower(), row["id"])):
            path = row["file"]
            link = f"[data](../{path})" if path else ""
            source = md(row["catalogSource"])
            if row["availabilityReason"]: source += " (" + md(row["availabilityReason"]) + ")"
            lines.append(f"| {md(row['name'])} | {row['id']} | {source} | {md(row['structuredSource'])} | {'Recorded' if row['hasLocation'] else 'None recorded'} | {link} |")
        lines.append("")
    overridden = [row for row in report["entries"] if not row["stillReturned"]]
    lines += ["## Stored placeholders already replaced by researched guidance", "",
              "| Item | Type | Patch | ID | Current acquisition guidance |", "| --- | --- | --- | ---: | --- |"]
    for row in overridden:
        lines.append(f"| {md(row['name'])} | {row['type']} | {row['patch']} | {row['id']} | {md(row['effectiveAcquisition'])} |")
    (ROOT / "Docs/PlaceholderAcquisitionAudit.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    result = audit()
    write_report(result)
    print(json.dumps({key: value for key, value in result.items() if key not in {"entries", "definitions"}}, sort_keys=True))
    for family_key in result["summary"]:
        entries = [row for row in result["entries"] if row["stillReturned"] and row["family"] == family_key]
        print(LABELS[family_key], "structured:", sum(bool(row["structuredSource"]) for row in entries), "location:", sum(row["hasLocation"] for row in entries))
        print(json.dumps(dict(Counter(row["patch"] for row in entries)), sort_keys=True))
        print("Examples:", "; ".join(row["name"] for row in entries[:6]))
