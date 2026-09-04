# TODO Planner (WoW Addon)

Base Kanban-style planner addon for World of Warcraft.

## What this base includes
- Account-wide data storage (`SavedVariables: TODOPlannerDB`)
- Character board selector with a `Global` board
- Global tasks that appear on every character board
- Per-character `To Do`, `In Progress`, and `Done` tracking for shared global tasks
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
- `Data/PatchCatalog.lua`: static patch collection catalogs for mounts, pets, toys, and achievements.
- `Data/Favorites.lua`: saved favorite collection references.
- `UI/`: reusable widgets, task cards, task details, and the main planner window.
- `UI/HomeWindow.lua`: default launcher for Explorer, Planner, and Favorites.
- `UI/CollectionExplorerWindow.lua`: patch collection browser with filters, previews, and task creation.
- `UI/FavoritesWindow.lua`: saved collection favorites browser.
- `Integrations/`: Blizzard UI integrations such as achievement task buttons and Wowhead detail helpers.

## Static collection catalog
- Patch `12.0` and `12.1` are seeded with Wowhead-sourced static IDs:
  - Mount spell IDs, plus item IDs when Wowhead exposes the learning item
  - Battle pet species IDs and NPC IDs
  - Toy item IDs
  - Achievement IDs, with reward highlights for collection-relevant achievements
- Mount entries can include curated acquisition notes and source categories such as PvP, Dungeon and Raids, Quest Rewards, Rare Drops, Vendor, and Delves.
- The catalog is intentionally static because WoW's addon API can scan current collection state, but does not expose a reliable "added in patch" field.

## Notes
- Data is global/account-wide, but tasks can now live on `Global` or on individual character boards.
- `Global` tasks are visible on every character board while keeping per-character progress state.
- This is a starter foundation intended for iterative improvements.
