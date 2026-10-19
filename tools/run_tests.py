# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Run each standalone Lua test suite in an isolated Lua 5.1 runtime."""

import os
import argparse
from pathlib import Path

from lupa.lua51 import LuaRuntime


ROOT = Path(__file__).resolve().parents[1]
os.chdir(ROOT)
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("suites", nargs="*", help="Optional test filenames or stems; default: all suites")
args = parser.parse_args()
paths = sorted((ROOT / "Tests").glob("*_tests.lua"))
if args.suites:
    for suite in args.suites:
        if not any(suite in {path.name, path.stem} for path in paths):
            parser.error(f"Unknown suite: {suite}")
    paths = [path for path in paths if any(suite in {path.name, path.stem} for suite in args.suites)]
failures = []
for path in paths:
    print(f"\nRunning {path.name}", flush=True)
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.globals().print = lambda *values: print(*values, flush=True)
    lua.globals().arg = lua.table_from({1: str(ROOT)})
    lua.execute('os.exit = function(code) error("Suite exited: " .. tostring(code)) end')
    try:
        lua.execute(path.read_text(encoding="utf-8-sig"))
    except Exception as error:
        failures.append(path.name)
        print(error, flush=True)

if failures:
    raise SystemExit("Failed suites: " + ", ".join(failures))
print("All Lua test suites passed.")
