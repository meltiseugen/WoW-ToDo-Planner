# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Check all catalog values and resolved UI payloads against reviewed fixtures."""

import argparse
import json

from lupa.lua51 import LuaRuntime

from catalog_support import ROOT, load_catalog, snapshot


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--update", action="store_true", help="Accept intentional catalog content changes")
args = parser.parse_args()
path = ROOT / "Tests/Fixtures/catalog_snapshot.json"
actual = snapshot(load_catalog(LuaRuntime(unpack_returned_tuples=True)))
if args.update:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(actual, indent=2, sort_keys=True) + "\n", encoding="utf-8")
else:
    expected = json.loads(path.read_text(encoding="utf-8"))
    changed = [key for key in sorted(expected.keys() | actual.keys()) if expected.get(key) != actual.get(key)]
    assert not changed, "Catalog snapshot changed:\n" + "\n".join(changed)
    print(f"Catalog parity passed: {len(actual)} snapshots, including all resolved collection payloads.")
