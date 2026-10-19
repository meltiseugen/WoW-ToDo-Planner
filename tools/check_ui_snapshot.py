# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Compare headless window construction and interaction traces with reviewed fixtures."""

import argparse
import json
import os

from lupa.lua51 import LuaRuntime

from catalog_support import ROOT, digest, plain


def run_ui_scenarios(lua=None):
    os.chdir(ROOT)
    lua = lua or LuaRuntime(unpack_returned_tuples=True)
    lua.globals().arg = lua.table_from({1: str(ROOT)})
    lua.globals().print = lambda *values: print(*values, flush=True)
    lua.execute((ROOT / "Tests/ui_construction_tests.lua").read_text(encoding="utf-8"))
    return {
        name: {"operations": len(trace), "sha256": digest(plain(trace))}
        for name, trace in lua.globals().UI_TEST_SNAPSHOTS.items()
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--update", action="store_true", help="Accept intentional UI behavior changes")
    args = parser.parse_args()
    actual = run_ui_scenarios()
    path = ROOT / "Tests/Fixtures/ui_snapshot.json"
    if args.update:
        path.write_text(json.dumps(actual, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    else:
        expected = json.loads(path.read_text(encoding="utf-8"))
        changed = [key for key in sorted(expected.keys() | actual.keys()) if expected.get(key) != actual.get(key)]
        assert not changed, "UI snapshot changed:\n" + "\n".join(changed)
        print(f"UI parity passed: {len(actual)} construction and interaction scenarios.")
