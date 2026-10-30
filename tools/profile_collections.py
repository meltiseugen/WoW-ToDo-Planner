# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Offline Lua 5.1 collection workload; excludes native WoW rendering and API costs."""
import os
from pathlib import Path
from lupa.lua51 import LuaRuntime

root = Path(__file__).resolve().parents[1]
os.chdir(root)
index_lua = LuaRuntime(unpack_returned_tuples=True)
index_lua.globals().index_path = str(root / "Data/Sources/CollectionSourceIndex.lua")
index_lua.globals().guide_path = str(root / "Data/Sources/CollectionAcquisitionGuides.lua")
index_lua.globals().location_path = str(root / "Data/Sources/CollectionDescriptionLocations.lua")
index_lua.execute('''
    collectgarbage("collect")
    local before = collectgarbage("count")
    local addon = {}
    assert(loadfile(index_path))("TODO-Planner", addon)
    collectgarbage("collect")
    print(string.format("source_index_retained_mb=%.3f", (collectgarbage("count") - before) / 1024))
    before = collectgarbage("count")
    assert(loadfile(guide_path))("TODO-Planner", addon)
    collectgarbage("collect")
    print(string.format("acquisition_guides_retained_mb=%.3f", (collectgarbage("count") - before) / 1024))
    before = collectgarbage("count")
    assert(loadfile(location_path))("TODO-Planner", addon)
    collectgarbage("collect")
    print(string.format("description_locations_retained_mb=%.3f", (collectgarbage("count") - before) / 1024))
''')
lua = LuaRuntime(unpack_returned_tuples=True)
lua.globals().arg = lua.table_from({1: str(root)})
lua.execute((root / "Tests/support/collection_profile.lua").read_text(encoding="utf-8"))
