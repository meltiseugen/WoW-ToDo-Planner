# UI architecture

Files are grouped by feature and responsibility. The public window classes and
named WoW frames are unchanged, so Bootstrap, integrations, saved positions, and
cross-window navigation keep their existing contracts.

```text
UI/
  Widgets/                 Controls, window stacking/positions, menus, preview text
  Collections/
    PreviewModel.lua       Shared model transforms, reset, zoom, and control binding
    PreviewPanel.lua       Shared preview layout and scrollable details
    Shared.xml
    Explorer/              Browser state, toolbar/filters, viewport rows, adaptive inspector, layout, actions
    Favorites/             Tabs, rows, actions, notes, preview, view
  CollectionMap/           Navigation, details, criteria, canvas, waypoints,
                          world-map pins/provider, world-map controls, minimap, view
  Planner/                 Board actions, task actions, columns, drag/drop, view
  Tasks/
    Card.lua               Cohesive task-card factory
    Editor/                Window construction and frame editing behavior
    Details/               Window construction, actions, criteria, and frame behavior
  Options/                 Page definitions, settings, controls, previews, layout, view
  Home/                    Launcher
  Windows.xml
```

## Module contracts

- `Init.lua` creates a feature's class, constructor, and shared constants. Other
  files attach focused methods to that same class. `Config` holds feature constants;
  the collection map's `Helpers` holds coordinate and payload helpers shared by its
  modules. Keep imports explicit at the top of each file.
- `View.lua` creates and wires frames. Row construction belongs in `Rows.lua`;
  selection, filtering, task actions, and map projection belong in their respective
  modules. Keep visual geometry out of filtering and persistence code.
- Collection-map `Projections.lua` owns item identities, independent payload
  snapshots, and `TODOPlannerDB.mapProjections`. Startup restores them without
  opening a window. Both map renderers enumerate every projected payload, and
  collection-cache events refresh saved achievement criteria for every item.
- Task editor and detail frames receive methods from `FrameMethods` when built.
  `frame.todoPlannerOwner` identifies their owning window, replacing implicit
  captures of the planner inside a large `Build()` function. Frame methods keep the
  existing signatures (`SaveTask`, `OpenTask`, `UpdateTask`, etc.).
- Explorer and Favorites install the same collection-preview methods. The installer
  preserves their existing distinction when resetting without a row key: Explorer
  retains its key, while Favorites clears it. The panel builder optionally includes
  Explorer's achievement action; each feature owns its remaining actions.
- Explorer owns its adaptive inspector and responsive layout while reusing the
  shared model controls. `BrowserState.lua` remembers browsing preferences and
  size; `Toolbar.lua` keeps source/category selectors visible and provides separate
  Weapons and Armour dropdowns on Cosmetics; `Rows.lua` measures wrapped rows and
  reuses a viewport-sized frame pool on scroll. Nearby snapshots are manual and
  are never restored or rescanned on open.
- `TDP.Widgets` stays a singleton with its original prototype. Widget modules attach
  methods to that prototype, so its constructor and inherited behavior remain intact.
- Options page definitions drive search, contextual help, and preference resets.
  Preview themes come from `ThemeManager:BuildSpec()` and independent theme
  instances, leaving the active skin in place until reload. Logging routes through
  `Utils:Msg(message, category)`; uncategorized callers remain command/action replies.

Small cohesive files such as task cards and the launcher stay together. Add a new
module when it owns a distinct responsibility, not merely to meet a line count.

## Loading

`TODO-Planner.toc` loads `Widgets/Widgets.xml` before the achievement and location
integrations, then `Windows.xml`. Feature XML manifests load `Init.lua` first and
list every module explicitly. `Collections/Shared.xml` loads before Explorer and
Favorites. Bundled LibStub, CallbackHandler, and HereBeDragons load from the TOC
before addon code. Collection projections register both world-map and minimap
icons with HereBeDragons-Pins; the library owns map positioning and visibility.

Paths in XML are relative to the containing manifest. Runtime code uses WoW's XML
loader; it does not use `require`, `loadfile`, or runtime filesystem discovery.
Test-only manifest adapters load the same module order in headless Lua.

## Verification

Run from the addon root:

```powershell
$env:UV_CACHE_DIR = Join-Path $env:TEMP 'todo-planner-uv-cache'
uv run --no-project .codex_validate.py
uv run --no-project tools/check_ui_snapshot.py
uv run --no-project tools/run_tests.py
```

The validator checks manifest coverage, missing or duplicate scripts, and Lua 5.1
syntax. The UI scenarios construct and render the main windows, switch options
tabs, reset the map, create/edit a task, and lay out task details and criteria using
the real widget/theme code against a minimal frame API mock. The trace fixture was
captured from the original UI before this refactor. It checks frame creation,
geometry calls, text, and registered event names across those scenarios.

For a focused test run:

```powershell
uv run --no-project tools/run_tests.py ui_construction_tests preview_model_tests
```

After an intentional UI change, review the behavioral difference before updating
the trace fixture with `tools/check_ui_snapshot.py --update`. Do not regenerate it
just to hide a refactoring regression.

The mock does not render pixels, dispatch automatic frame events, or emulate
protected UI behavior. A WoW `/reload` is still required to verify window visuals,
resizing, dropdown dismissal, dragging, tooltips, and world-map/minimap projection.
