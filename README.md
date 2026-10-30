# TODO Planner (WoW Addon)

Base Kanban-style planner addon for World of Warcraft.

## What this base includes
- Account-wide data storage (`SavedVariables: TODOPlannerDB`)
- Character board selector with a `Global` board
- Board-isolated tasks: Global tasks stay on `Global`, and character tasks stay on their assigned board
- 3 Kanban columns: `To Do`, `In Progress`, `Done`
- Task fields: title, notes, category, board location, status, timestamps
- Categories for planning goals:
  - Achievements
  - Mounts
  - Collections
  - Reputation
  - Other
- Category filtering for the active board view
- Favorites for patch collection entries
- Collections **Nearby** button: scan your current map and parent zone for catalog mounts, pets, toys, cosmetics, and achievements across all expansions. Use the type tabs, status, and search to filter the results. While active, the same button shows **Cancel**: click it again to leave Nearby and restore your previous browsing view. The location stays fixed during Nearby, with no automatic location tracking or chat reminders.
- Collection Explorer with visible source/category filters, separate Weapons and Armour dropdowns on Cosmetics, sorting, favorite/map shortcuts, a resizable window, and remembered browsing state. Mounts, pets, and supported cosmetics have collapsible model previews; icon entries give acquisition details the full reading area. Additional catalog notes remain expandable.
- **Project** adds each collection item to the Blizzard world map and minimap. Multiple items remain projected together, and saved projections restore after login or `/reload`. Projecting the same item again updates it; **Clear All** removes every projected item and its saved pins.
- Open, delete, and status movement for tasks
- Move any task between `Global` and a specific character board from the editor
- Draggable main window with saved position
- Searchable Options window with Appearance, Achievements, Maps, Windows, and Logging pages; six skin previews, contextual help, page resets, and remembered size/position
- Chat controls with a master switch, optional timestamps, a delivery test, and separate startup, task, collection, navigation, warning, and command categories

## Commands
- `/tdp` or `/todoplanner`: toggle window
- `/tdp show`: show window
- `/tdp hide`: hide window
- `/tdp planner`: open the Kanban planner
- `/tdp explorer`: open the collection explorer
- `/tdp favorites`: open favorites
- `/tdp options`: open the Options window
- `/tdp resetpos`: reset window to center
- `/tdp help`: print command help

## Code layout
- `TODOPlanner.lua`: addon namespace and event frame bootstrap.
- `Core/`: constants, utility helpers, theme setup, slash commands, and load-event bootstrap.
- `Data/Persistence/`: board, task, database, and favorite storage.
- `Data/Expansions/<Expansion>/<patch>/`: patch metadata, collection records, research, and availability.
- `Data/Catalog/`: shared registration, queries, faction rules, map payloads, and availability logic.
- `Data/Catalog.xml`: ordered catalog manifest; see [Data/README.md](Data/README.md) for the content contract and validation commands.
- `UI/Widgets/`: shared controls, window management, dropdowns, and preview text.
- `UI/Planner/` and `UI/Tasks/`: board view, drag/drop, task cards, editor, and details.
- `UI/Collections/`: Explorer, Favorites, and their shared model preview.
- `UI/CollectionMap/`: map canvas, criteria, world-map projection, and minimap pins.
- `UI/Options/` and `UI/Home/`: settings and the launcher.
- `UI/Windows.xml`: feature load order; see [UI/README.md](UI/README.md) for module responsibilities and checks.
- `Integrations/`: Blizzard UI integrations such as achievement task buttons and Wowhead detail helpers.

## Static collection catalog

- Patches `9.1` through `12.1` now have audited static rows for mounts, battle pets, toys, Cosmetics, and achievements wherever eligible records exist. Pets, toys, and achievements from `10.0` through `11.2.7` are backed by versioned public-client DB2 snapshots, with source-text reassignment for records Blizzard preloaded before their real content patch. `9.1.7` is an explicit empty placeholder because retail proceeded directly from `9.1.5` to `9.2`; `9.2.7` remains empty because its only new collection records are promotional or hidden tracking. The catalog excludes Trading Post, shop, external promotions, calendar holidays, placeholders, hidden records, the former Unknown bucket, and cross-patch duplicate IDs. Patch-native Timewalking, Remix, Plunderstorm, pre-patch, and seasonal PvP rewards remain in their introduction patch for historical tracking; direct wardrobe unlocks are not mislabeled as learn-on-use Cosmetic items.
- Seeded records can include:
  - Mount spell IDs, plus item IDs when Wowhead exposes the learning item
  - Battle pet species IDs and NPC IDs
  - Toy item IDs
  - Learn-on-use cosmetic item IDs, with transmog set, illusion, or unlock tracking where applicable
  - Achievement IDs, with reward highlights for collection-relevant achievements
- Mount entries can include curated acquisition notes and source categories such as PvP, Dungeon and Raids, Quest Rewards, Rare Drops, Vendor, and Delves.
- The catalog is intentionally static because WoW's addon API can scan current collection state, but does not expose a reliable "added in patch" field.

## Notes

- Options changes save automatically. Skin changes take effect after **Reload UI**; progress, pin size, minimap visibility, and logging changes apply immediately. **Reset this page** requires a second click and restores that page's preferences. **Center windows** is a separate action; tasks, characters, favorites, and collection filters are preserved.
- Logging controls the addon's existing output to your default chat frame. Startup and navigation messages are off by default; warnings and action replies remain on. Disabling the master switch also silences warnings and `/tdp help`. Category selections remain saved while muted. No separate log file or automatic location tracking is added.
- Data is global/account-wide, but tasks can now live on `Global` or on individual character boards.
- `Global` tasks are visible on the `Global` board and aggregate views, not on character boards.
- This is a starter foundation intended for iterative improvements.
