# Collection performance regression, 2026-10-28

The recent achievement-navigation and acquisition-source changes placed expensive
work in the virtualized list's row-update path. Functional checks did not exercise
the allocation cost of sustained scrolling. That missed a serious regression.

## Findings and fixes

- Achievement lookup sorted every patch and scanned reward highlights repeatedly
  for each row. It also searched journal-name dictionaries linearly. It now builds
  lookup indexes once and reuses them. Missing native achievement names retry at
  most once per five seconds per patch during subsequent use.
- Deciding whether to show a Map button constructed full map payloads, pins, notes
  and cost text. The button's help and visibility could each repeat this work. The
  capability check now inspects coordinates/areas directly; complete payloads are
  created when opening a map. Row metadata and shortcut results are reused within
  a view, and unchanged row bindings do not get painted again.
- Collection refreshes discarded every resolved source, including static sellers
  and drops. Unrelated item and quest data-load events could trigger another full
  refresh. Automatic refreshes now preserve static sources, quest events invalidate
  quest destinations, and unrelated data-load events are ignored. Relevant metadata
  loads avoid journal scans, task scans and projection-criteria refreshes.
  Mount and pet journal caches are invalidated only by their corresponding collection
  events; quest, achievement-criteria and inventory activity reuse those indexes.
- The imported database duplicated identical source records and arrays. Sharing
  those read-only tables saved 3.58 MiB. Comparison against the pre-fix database
  verified all 106,782 scalar values unchanged, including quest prerequisites,
  coordinates, costs and restrictions.
- Rich resolved-source objects previously accumulated for every visited collectible.
  Their cache now has a fixed 512-entry limit and evicts old entries. The bundled
  source data remains available when an entry needs to be resolved again.

## Offline measurements

Lua 5.1, the real catalog, a mocked UI with tracing disabled, and native APIs replaced
by deterministic stubs. The workload renders Shadowlands mounts across all patches
(91 rows), warms the list, then performs 200 scroll updates. The same offsets and
instrumentation were used before and after the fix.

| Measurement | Before | After |
| --- | ---: | ---: |
| CPU time for 200 scroll updates | 9.237 s | about 0.02 s |
| Temporary allocations for those updates | 691.822 MiB | 2.222 MiB |
| Full map payloads built while scrolling | 2,265 | 0 |
| Patch-key sorts while scrolling | 3,203 | 0 |
| Additional UI objects while scrolling | 0 | 0 |
| Imported source-index retained heap | 8.800 MiB | 5.218 MiB |
| Complete catalog retained heap | 15.866 MiB | 12.286 MiB |

The allocation measurement pauses garbage collection **only inside the offline
profiler**. It measures cumulative temporary allocation, not normal in-game peak
memory. The addon does not force garbage collection or change the client's GC settings.
The results demonstrate allocation churn and substantial avoidable CPU work; they
do not establish that an independent in-game leak is impossible.

After the fixes, catalog + tested UI + source caches occupy about 14.7 MiB after
resolving every collectible's source. Five additional full source passes have no
positive retained growth after collection. Twenty cache-reset/render cycles also
show no positive retained growth. Scrolling creates no additional UI objects.

These are offline Lua measurements, not WoW addon-memory attribution or a live CPU
percentage. Native rendering, journal data, other addons and actual saved data are
not reproduced. A client `/reload` and repeated scrolling are still needed to confirm
the user's under-30-MB target and frame-time behavior in WoW.

## Regression coverage

`Tests/collection_performance_tests.lua` checks the scrolling allocation budget,
bounded source cache, retained heap, missing-achievement retry limit, event filtering
and refresh coalescing. It compares the cheap Map capability check against actual map
payloads for every catalog entry, including achievements. Existing source-navigation,
achievement-navigation, acquisition, filtering, Nearby and map-projection suites
remain in use, together with the eight UI snapshots and manifest/Lua syntax checks.

The full suite retains six previously observed `planner_data_tests.lua` failures:
two character/global task-order expectations, the 11.1.5 cosmetic count, two assertions
that expect an expansion-specific patch list from the global patch-key query, and
the selected Shadowlands mount-count expectation. These were not changed or hidden.

Run:

```powershell
uv run --offline --no-project tools/profile_collections.py
uv run --offline --no-project tools/run_tests.py collection_performance_tests
```

## Location-research expansion

The subsequent research of the original 228 missing destinations expands the source
index to 5,737 structured collectible-source entries and 5,716 prerequisite records.
The same offline workload retains about 15.5 MiB after browsing all sources, with
no positive retained growth on the repeated passes. The 512-entry cache remains in
place. Warmed scrolling still constructs zero map payloads, sorts zero patch lists,
creates zero additional UI objects and allocates about 2.22 MiB across 200 updates.
Observed CPU time is about 0.02-0.04 seconds for those updates; host timing varies.
The live WoW memory and frame-time verification requirement remains unchanged.
# Acquisition guide verification, 2026-10-28

The 725 replacement guides retain about 0.210 MiB for their compiled strings and
ID tables in isolated Lua 5.1. Shared catalog details are copied once during
registration for guide compatibility; guide reads create no source or map
payloads. External research databases, tooltips and receipts are not loaded by
the addon.

After this change the full offline source workload retains about 15.79 MiB.
Repeating the complete source pass retains no additional heap. The 200-scroll
workload still allocates 2.222 MiB transiently, creates no UI objects, builds no
map payloads and performs no patch sorts or achievement queries. An instrumented
run took 0.043 seconds; wall-clock results vary with other processes.

These are headless Lua measurements. WoW rendering, native API allocations and
the in-game addon memory/CPU counters still require a `/reload` and live check.

## Description map destinations, 2026-10-29

The compiled fallback locations restore map actions for 422 entries; two repaired
quest sources restore another two. The shared destination table retains 0.076 MiB
in isolated Lua 5.1. Source evidence, research snapshots and description parsing
remain offline. Map visibility reads the compiled lookup and does not build map
payloads or scan guide text.

After these changes the complete offline source workload retains 15.877 MiB.
Repeating that workload has no positive retained growth. Across 200 warmed scroll
updates, temporary allocations remain 2.222 MiB, with zero additional UI objects,
map payloads, patch sorts or achievement queries. The measured scroll workload
took 0.024 seconds; host timing varies. These figures are not native WoW memory
attribution or live frame-time measurements.

## Character-restricted description maps, 2026-10-29

The initial description audit used no character identity. It therefore missed
actions hidden by faction, class or race filtering. The correction adds 616
compiled inspection destinations (78 mounts, 19 pets, 41 toys and 478 cosmetics)
and repairs achievement navigation for another 12 mounts. Acquisition eligibility
and the live quest resolver keep their existing restrictions. Both factions and
every distinct source and prerequisite restriction combination are checked
offline (47,989 contexts), using the actual Collections and Favorites map-action
methods. All 12 achievement mounts open the addon's achievement tab on either
faction; row and preview buttons for the four screenshot mount variants are
clicked on both factions and checked against the guide's coordinates.

The expanded compiled destination table retains 0.141 MiB total, approximately
67 KiB above the first version. The complete offline source workload retains
15.945 MiB, and repeated passes show no retained growth. The 200-scroll workload
still allocates 2.222 MiB transiently and creates zero UI objects or map payloads,
with no patch sorts or achievement queries. No parsing, character-context audit
or external research runs in the addon. Native WoW validation remains pending.

## Achievement location coverage, 2026-10-29

Removing the geographic-prose gate and resolving additional achievement criteria
expands the shared fallback dataset to 4,957 entries, including 4,226 achievements.
It restores Map coverage for 1,418 War Within achievements; the initial dataset
covered only two. Source tooltips, HTML, research logic and JSON evidence remain
outside the runtime manifest. The addon still reads a compiled ID lookup.

The complete compiled destination dataset retains 1.001 MiB in isolated Lua 5.1,
approximately 0.860 MiB above the previous character-restriction repair. The full
offline catalog/UI/source workload retains 16.801 MiB and repeated source passes
show no retained growth. Across 200 warmed scroll updates, temporary allocation
remains 2.222 MiB, with zero additional UI objects, map payloads, patch sorts or
achievement queries. One measured run took 0.018 seconds; host timings vary.

These are offline measurements, not native WoW addon-memory attribution. Live
rendering, frame times and saved-data effects still require a client `/reload`.

## Midnight achievement criteria, 2026-10-29

The Midnight correction adds 132 compiled destinations, increasing the shared
dataset from 4,957 to 5,089 entries. It retains 1.022 MiB for the complete table,
about 22 KiB above the previous version. The full offline source workload retains
16.821 MiB with no retained growth on repeated passes. All 461 Midnight achievement
rows are exercised through the real tab filters and Map controls; 381 have verified
destinations and 80 remain without a verified fixed destination.

The warmed 200-scroll workload still allocates 2.222 MiB transiently, creates no
new UI objects or map payloads, and performs no patch sorting or achievement
queries. Public metadata, raw source trees, named-place matching and criteria
research remain outside the runtime manifest. Native WoW checks remain pending.

