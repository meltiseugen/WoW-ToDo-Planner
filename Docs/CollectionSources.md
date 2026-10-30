# Collection sources and quest guidance

The collection rows now retain useful named sources instead of discarding a quest,
NPC, profession or drop description when its imported source type is generic.
Collections and Favorites share the same resolver, map destinations and cost data.

`Data/Sources/CollectionSourceIndex.lua` contains acquisition sources for existing
catalog IDs and their prerequisite quest records. It does not add collectibles,
modify collection ownership, migrate saved data, or require AllTheThings at runtime.
The generated data is derived from the MIT-licensed [AllTheThings database](https://github.com/ATTWoWAddon/AllTheThings/tree/f8113a527789bf361e070d7cde94d1f57a22b2b8/db/Standard/Categories).
The full license and copyright notice are distributed in `Data/Sources/ATT-LICENSE.txt`.
`receipt.json` records the upstream revision and input SHA-256 hashes.

## Acquisition behavior

- Quest rewards: walk unfinished prerequisites for the current character, excluding
  other factions/classes/races and optional breadcrumbs. Parallel requirements follow
  the longer story branch first; all remaining branches are still required. Recorded
  alternative quests count as equivalent introductions. Quest completion on another
  character does not advance this character's route.
- Active quests: use Blizzard's next quest waypoint when available, falling back to
  the researched quest-giver coordinates. Unavailable quest APIs leave the chain start
  usable. A completed reward quest is described as completed, rather than as a next step.
- Vendors: show the seller's coordinates, compatible faction locations and known gold,
  currency or barter costs. Existing item-specific cost guides take precedence.
- Alternative sources: prefer an eligible seller over an optional quest route when
  the collectible can also be purchased. A mount sold after an achievement unlock
  retains its seller map; the separate achievement link remains available.
- Drops, treasures and wild pets: use recorded creature, object or spawn coordinates.
  Instance entrance coordinates are explicitly distinguished from a boss location.
- Crafting, achievements, PvP, promotions, Trading Post and Black Market sources retain
  their acquisition method. The resolver does not manufacture a world coordinate for
  a reward that has no researched fixed location. Achievement links retain the addon
  navigation implemented for mount rewards.
- Existing cosmetic guides with researched routes, access points and unlock locations
  remain intact; the index fills their missing locations. Quest guidance follows
  progress, while existing cosmetic routes retain their material and clue pins.
- Area sources: when the database identifies a source map without fixed coordinates,
  open that area with no invented pin. Multiple recorded areas have a selector in
  the map details panel. The interface explains the precision limit and disables
  pin projection until there are real coordinates.

Quest updates reuse the addon's collection-cache events. The open collection map
advances only when the displayed quest/destination changes. There is no player-location
polling. Quest-title data requests are limited to inspected entries and opened maps,
not catalog scans or row Map-availability checks.

## Tiny Flamefly

The catalog previously listed only the Alliance reward and no map coordinates. The
resolver now follows both faction branches from Flamestar Post in Burning Steppes:

- Alliance: John J. Keeshan, 17.2, 52.0, leading to **SEVEN! YUP!** (28415).
- Horde: Ariok, 17.4, 51.6, leading to **Not Fireflies, Flameflies** (28491).

The alternative Alliance introductions (28174 / 28416), optional Hero's Call /
Warchief's Command breadcrumbs, parallel prerequisites and character completion are
handled explicitly. [Tiny Flamefly acquisition reference](https://www.wow-petguide.com/Pet/287),
[upstream Burning Steppes source data](https://github.com/ATTWoWAddon/AllTheThings/blob/f8113a527789bf361e070d7cde94d1f57a22b2b8/db/Standard/Categories/Zones.lua).

Mr. Grubbs also has a researched quest-gated drop source. Before the caravan buffs
are unlocked, its map follows Fiona's prerequisites. Afterwards it shows Eastern
Plaguelands as a farming area and explains the Lucky Charm buff, Hidden Stash and
chance-based pet reward. It does not label a prerequisite quest as the pet reward.
[Acquisition reference](https://www.wowhead.com/item=66076/mr-grubbs),
[buff unlock reference](https://warcraft.wiki.gg/wiki/Fiona%27s_Lucky_Charm).

## Rebuilding and auditing

```powershell
uv run --no-project tools/import_collection_sources.py --download
uv run --offline --no-project tools/import_collection_sources.py
uv run --offline --no-project tools/audit_collection_sources.py
uv run --offline --no-project tools/run_tests.py collection_source_navigation_tests
```

The importer runs the pinned database's constructors in a Lua environment without
filesystem, OS, network, addon or Python access. Runtime gameplay callbacks are not
invoked. Existing catalog IDs bound the exported data. Removed and never-implemented
sources are excluded; future removal dates do not prematurely remove current sources.
Including the upstream holiday file supplies sources for already cataloged items,
such as Darkmoon Faire vendors; excluded calendar collectibles are not added.
Independent, referenced research overrides live in `Data/Sources/CuratedSources.json`;
their hash is recorded in the receipt and only existing catalog IDs are accepted.

`CollectionSourceAudit.json` records coverage, Map availability before/after this
change, and named entries that still need verified location research. Coverage is
not universal: some world drops, conditional/class-hall sellers, wild-pet areas and
quest prerequisites have no usable fixed coordinates in this snapshot. Existing
named source descriptions remain visible when structured source data is unavailable.
The audit includes historical entries and runs without live faction/quest APIs, so
its counts are not a claim that every source is currently obtainable on a character.

The original 228 missing-location records have now been researched individually.
[CollectionLocationResearch.md](CollectionLocationResearch.md) lists every original
ID, its location or finding, and supporting sources. There are 109 coordinate-based
collectible destinations, 64 source areas, 24 non-collectible trainer opponents,
14 unimplemented items/wrappers, nine historical rewards, four achievement links,
two acquisition methods without a fixed location, and two unconfirmed sources
(Gleam and Aud'rei III). An unconfirmed journal label is not converted into a
fabricated seller or spawn.

The updated aggregate audit contains 5,737 structured source entries and 1,528
additional map-enabled entries relative to the original catalog. It has no remaining
gaps for a confirmed location-based method; the two unconfirmed sources are listed
separately. Some map destinations intentionally locate an instance entrance,
expedition queue or varying source area. The current aggregate report is
[UnmappedCollectionSources.md](UnmappedCollectionSources.md).

The importer now recognizes ensemble item IDs, instance encounter sources, primary
zone maps for wild pets, shared event-vendor NPC groups and covenant Renown rewards.
Research profiles in `CuratedSources.json` add faction-specific queues and sellers,
secret prerequisite steps, repeatable chance rewards and explicit availability
findings. Researched instructions replace stale acquisition text, including the
retired Repossessed! quest text for the Mana-Skimmer's current Reno Jackson purchase.
Jenafur and Faithful Dog follow character-specific secret flags; repeatable Firim
quests remain actionable after a previous completion. Trainer opponents and unused
ensemble wrappers retain their records but are identified as non-collectible.

## Runtime cost

Identical imported records and arrays share read-only Lua tables. The acquisition
data and prerequisite chains are preserved; character-specific destinations use
separate runtime objects. Those resolved objects use a 512-entry cache with
eviction, including negative results. Quest changes invalidate quest destinations
without discarding static seller/drop locations. Explicit Refresh still clears
the source cache in full.

Map-button availability checks inspect locations without building map payloads or
formatting source notes and costs. Achievement names and rewards use lookup indexes;
unavailable native achievement data retries with a five-second backoff on subsequent
use. This does not add timers or polling. List row metadata and shortcuts are reused
until the view is rebuilt. Unrelated item/quest data-load events do not rebuild lists,
and relevant metadata-load events do not rescan collection journals or planner tasks.

The measured regression, corrections and offline limits are recorded in
[CollectionPerformance.md](CollectionPerformance.md). To repeat the workload:

```powershell
uv run --offline --no-project tools/profile_collections.py
uv run --offline --no-project tools/run_tests.py collection_performance_tests
uv run --offline --no-project tools/run_tests.py collection_location_research_tests
uv run --offline --no-project tools/audit_location_research.py
```

Headless tests cover both Tiny Flamefly branches, progress, alternative introductions,
active objectives, vendor coordinates, crafting/achievement types, costs, bounded
quest-title requests, alternative prerequisite counts, quest-gated drops, area maps,
character restrictions and open-map refreshes. In-game `/reload` verification is still
required for NPC phasing, native quest data, visuals, and actual acquisition.

# Acquisition guide text

`Data/Sources/CollectionAcquisitionGuides.lua` replaces 725 former journal
handoffs (283 mounts, 331 pets, 111 toys). Its strings are selected by collectible
ID. Registration copies shared detail tables once for those entries so direct
detail consumers also receive a guide; ordinary guide reads are constant lookups.
Character-specific next-quest notes and navigation still use the bounded source
resolver. Existing authored guides outside this target set are retained.

`AcquisitionGuideTargets.json` freezes the original identities. The reviewed
overrides and generated `AcquisitionGuides.json` record the steps and references.
The compiled Lua contains neither the research HTML nor the full external trees.
For a readable per-item record see `Docs/AcquisitionGuides.md`.

Reproduction, using the same research cache:

```powershell
uv run tools/research_acquisition_guides.py --download
uv run tools/build_acquisition_guides.py
uv run tools/audit_acquisition_guides.py
uv run tools/audit_acquisition_placeholders.py
```

The research downloader uses the pinned ATT snapshot plus public Wowhead
tooltips for entity names, objectives and currency names. Downloaded files stay
in the system temporary research cache. Hidden tracking flags without a public
quest page are not treated as named quests. Secret interactions and exceptions
are reviewed separately in `AcquisitionGuideOverrides.json`.

## Description locations and Map actions

The full 2026-10-29 audit is in [DescriptionMapAudit.md](DescriptionMapAudit.md).
It checks coordinates and named places against the actual UI action and map
payload, rather than assuming a source category implies that a location exists.

`CollectionDescriptionLocations.lua` contains compiled fallback destinations.
It supplements missing routes and areas; existing authored pins and current
character quest destinations retain priority. A source area has no fabricated
pin. Multi-part guides keep distinct pins for their parts, quest starts and
assembly points. The same catalog methods serve Collections, Favorites and a
user-requested Nearby scan. No prose is parsed by a scrolling row.

The profession importer now preserves quests, achievements and sellers found
inside a profession chapter. Starlight Beacon therefore follows its real quest
chain. The Grotto Netherwing Drake entry explicitly references Dragon Keeping
(76465); character progress selects its unfinished prerequisite.

Evidence and manual exceptions are stored in `DescriptionLocations.json` and
`DescriptionLocationOverrides.json`. The intermediate external paths stay in
the temporary research cache. To reproduce with the pinned source cache:

```powershell
uv run tools/import_collection_sources.py
uv run tools/research_description_locations.py
uv run tools/build_description_locations.py
uv run tools/audit_description_maps.py
uv run tools/run_tests.py description_location_tests collection_performance_tests
```

A patch heading alone is not destination evidence.
Unverified/unimplemented collectibles and event shops without a fixed world
destination do not receive invented pins. Unobtainable mount archives remain
hidden in the UI.

The description-map audit must set character identity. Its original neutral
context missed sources rejected for the current faction, class or race, including
the opposite faction's Vicious Skyflayer and Vicious Electro Eel variants. The
research tool now tests both factions and every distinct eligibility combination
in each item's source records and prerequisite quests. The audit calls the real
Collections and Favorites action methods for these contexts. Recorded locations
remain inspectable even when the character cannot acquire that item; source
eligibility and character quest progression keep their existing restrictions.

PvP wares with explicit purchase costs are classified as vendor sources even when
the external source has no vendor header. Regression checks render both the row
icon and inspector button and click both controls for all four screenshot mount
variants on Alliance and Horde characters, verifying the displayed coordinates.

## Achievement locations beyond shared guide text

Achievement location import no longer requires geographic words in the stored
acquisition text. Most War Within entries share `Complete the achievement's
listed criteria.`, while the native journal supplies the real description. The
old text filter discarded known zone, dungeon, raid, delve and event locations.

The compiler now retains every documented spatial source. For the remaining 756
War Within entries, public achievement tooltips were fetched into the TEMP cache
and their criteria were matched to the pinned quest, creature, item and achievement
records. Reviewed copies of older achievements use the canonical achievement's
location. Combat-log encounter IDs are deliberately not joined to Dungeon Journal
IDs. `AchievementLocationOverrides.json` records reviewed exceptions, and
`AchievementLocationEvidence.json` records the results and unresolved entries.
Neither JSON file nor tooltip parsing is loaded by WoW.

The current result is 1,418 of 1,889 War Within achievements with Map actions
(786 with pins and 632 with source areas), up from 2. The remaining 471 entries
have no verified fixed destination in this research; the report includes their
names and does not count them as repaired. See [AchievementMapAudit.md](AchievementMapAudit.md).
The audit now checks known spatial sources independently of guide prose.

```powershell
uv run tools/research_achievement_locations.py --expansion 11 --download  # First research pass only
uv run tools/research_achievement_locations.py --expansion 11             # Reproduce from cached tooltips
uv run tools/build_description_locations.py
uv run tools/audit_description_maps.py
uv run tools/run_tests.py achievement_location_tests
```

The UI regression renders all 1,889 War Within achievement rows through the
actual expansion/type filters, paints the Map icons, renders the inspector and
clicks both controls for every mapped row in Collections and Favorites on both
factions. It also checks canonical raid destinations, labeled quest criteria,
collection rewards, and the absence of fabricated locations for level counters.

## Midnight achievement criteria

The supplemental researcher now accepts any expansion through `--expansion`.
Its original War Within-only selection left 212 Midnight entries without a
destination despite the primary-source compiler already covering 249 of 461.
All 461 Midnight descriptions were checked: the missing entries for criteria,
and the already mapped entries for canonical names and reusable activity routes.
The correction restores another 132 actions, bringing coverage to 381 of 461.
The remaining 80 entries are reported by name in `AchievementMapAudit.md`.

Creature pet-battle criteria resolve the real trainers, rather than inheriting
coordinates from a quest giver in Stormwind or Orgrimmar. Reviewed dungeon names
resolve all eight Season 2 entrances, including returning dungeons. Authored raid
and delve entrances are reused for kill counters. Lumber achievements open verified
harvesting areas; private housing achievements open the relevant neighborhoods.
Prey affix/target goals open Astalor's hunt selection, rather than an invented
fixed boss spawn. `AchievementPlaceLocations.json` records reviewed named routes.

The real Midnight tab is now covered by the same row and preview click regression
as War Within, on both factions and in both Collections and Favorites.

```powershell
uv run tools/research_achievement_locations.py --expansion 12 --download
uv run tools/research_achievement_locations.py --expansion 12
uv run tools/build_description_locations.py
uv run tools/audit_description_maps.py
uv run tools/run_tests.py achievement_location_tests collection_performance_tests
```

Selected expansion research preserves evidence for other expansions. Missing
target descriptions abort the export, so an empty research cache cannot silently
erase previously reviewed destinations. Public tooltips and entity-tree matching
continue to run offline; WoW loads only the compiled shared destination table.

