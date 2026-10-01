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
- Collection Explorer for static patch catalogs, with type tabs and mount source filtering
- Open, delete, and status movement for tasks
- Move any task between `Global` and a specific character board from the editor
- Draggable main window with saved position

## Commands
- `/tdp` or `/todoplanner`: toggle window
- `/tdp show`: show window
- `/tdp hide`: hide window
- `/tdp planner`: open the Kanban planner
- `/tdp explorer`: open the collection explorer
- `/tdp favorites`: open favorites
- `/tdp resetpos`: reset window to center
- `/tdp help`: print command help

## Code layout
- `TODOPlanner.lua`: addon namespace and event frame bootstrap.
- `Core/`: constants, utility helpers, theme setup, slash commands, and load-event bootstrap.
- `Data/`: board, task, and saved-variable database managers.
- `Data/PatchCatalog.lua`: static patch collection catalogs for mounts, pets, toys, cosmetics, and achievements.
- `Data/Favorites.lua`: saved favorite collection references.
- `UI/`: reusable widgets, task cards, task details, and the main planner window.
- `UI/HomeWindow.lua`: default launcher for Explorer, Planner, and Favorites.
- `UI/CollectionExplorerWindow.lua`: patch collection browser with filters, previews, and task creation.
- `UI/FavoritesWindow.lua`: saved collection favorites browser.
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
- Data is global/account-wide, but tasks can now live on `Global` or on individual character boards.
- `Global` tasks are visible on the `Global` board and aggregate views, not on character boards.
- This is a starter foundation intended for iterative improvements.
