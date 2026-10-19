# Data architecture

Static game content and saved player state have separate owners:

```text
Data/
  Persistence/             Database, boards, tasks, and favorites
  Catalog/                 Shared catalog behavior
  Catalog.xml              Catalog entry point loaded by the TOC
  Expansions/
    Midnight/
      Expansion.xml        Explicit ordered list of this expansion's files
      12.1.5/
        Patch.lua          Label, source notes, and research URLs
        Mounts.lua         Mount entries and acquisition details
        Pets.lua
        Toys.lua
        Cosmetics.lua
        Achievements.lua   IDs, reward highlights, details, and categories
        Availability.lua   Explicit retired-reward IDs, when applicable
```

The same structure applies to all twelve expansion buckets, including Classic.
Patch keys are stable identifiers used by favorites and collection tasks. Keep
existing keys exactly as written (`8.2`, `10.0`, `12.1.5`, and so on); renaming a
directory must not silently rename stored identifiers. Historical empty buckets
are preserved. This refactor reorganizes existing content without re-auditing its
patch attribution or research claims.

## Loading and ownership

WoW loads `Catalog.xml` through `TODO-Planner.toc`. It creates the registry, loads
shared map names and the expansion manifests, applies collection exclusions, then
attaches catalog query methods. The XML uses paths relative to each manifest.
There is no runtime filesystem discovery, `require`, or `loadfile` dependency.

`TDP.PatchCatalog` remains the consumer API used by the UI and integrations.
`TDP.CatalogRegistry` is the content authoring API. It rejects duplicate patch,
collection, and availability registrations. All patch modules use this same API;
adding a patch does not require a version-specific branch in shared logic.

Catalog records are read-only after loading. Shared tables within a content file
hold repeated routes and acquisition details. Put player completion, favorites,
and task state in Persistence or scanner state, never in static content tables.

The old generated catalog, hand-authored catalog, and 12.1.5 supplement have been
consolidated into these authoritative patch files. Their effective values,
ordering, IDs, research text, URLs, criteria mappings, and availability records
were compared against the original loaded catalog. Historical assignment and
override code is no longer needed to assemble the same result at each login.

## Adding or updating content

1. Create a patch directory inside its expansion and register metadata in
   `Patch.lua`. Use an existing neighboring patch as the schema reference.
2. Add collection files and register each collection type once. Most types use
   an `entries` array and a `details` table keyed by entry name; cosmetics may also
   use `detailKey`. Achievements use `entries = { ids = {}, rewardHighlights = {} }`,
   details keyed by achievement ID, and a `categories` table.
3. Keep acquisition research next to its collection, including source URLs,
   review dates, and uncertainty. Availability records belong to the reward's
   original patch even if removal happened in a later expansion.
4. List files in `Expansion.xml`, with `Patch.lua` before its collection files.
   For a new expansion, add its manifest to `Catalog.xml` as well.
5. Add newly used map IDs to `Catalog/MapNames.lua`. Preserve explicit criterion
   mappings; an entrance or setup pin is not automatically an achievement criterion.

For example:

```lua
local _, TDP = ...

TDP.CatalogRegistry:RegisterPatch("<patch-key>", {
    label = "Patch label",
    sourceNotes = {},
    sourceUrls = {},
})
```

Do not add unrelated game data to `Catalog/`. Its modules contain behavior:
`Queries.lua` exposes lookups, `Factions.lua` resolves faction rules, `Maps.lua`
builds map payloads, `Availability.lua` checks unlock eligibility, and `Policy.lua`
applies the existing exclusion rules. `MapNames.lua` is shared geographic data.

## Validation

From the addon root, with `uv` installed:

```powershell
$env:UV_CACHE_DIR = Join-Path $env:TEMP 'todo-planner-uv-cache'
uv run --no-project .codex_validate.py
uv run --no-project tools/check_catalog_snapshot.py
uv run --no-project tools/run_tests.py
```

The validator follows the actual XML manifest, checks missing or duplicate
scripts, compiles addon Lua with Lua 5.1, and validates counts, unique IDs, details,
exclusions, and maps. The snapshot check covers every stored catalog field plus
resolved details, map payloads, faction, and availability for every visible entry.
Its initial fixture was captured from the original implementation before migration.
The Lua suites use the same catalog manifest through a test-only loader.

For intentional content changes, review the data diff, update the expected counts
and relevant assertions, then explicitly regenerate the snapshot:

```powershell
uv run --no-project tools/check_catalog_snapshot.py --update
```

Do not update the fixture to silence a refactoring regression. Headless checks do
not replace a WoW `/reload` and a check of Explorer, collection maps, favorites,
saved tasks, and missing/unobtainable filters.
