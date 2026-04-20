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
- Open, delete, and status movement for tasks
- Move any task between `Global` and a specific character board from the editor
- Draggable main window with saved position

## Commands
- `/tdp` or `/todoplanner`: toggle window
- `/tdp show`: show window
- `/tdp hide`: hide window
- `/tdp resetpos`: reset window to center
- `/tdp help`: print command help

## Code layout
- `TODOPlanner.lua`: addon namespace and event frame bootstrap.
- `Core/`: constants, utility helpers, theme setup, slash commands, and load-event bootstrap.
- `Data/`: board, task, and saved-variable database managers.
- `UI/`: reusable widgets, task cards, task details, and the main planner window.
- `Integrations/`: Blizzard UI integrations such as achievement task buttons and Wowhead detail helpers.

## Notes
- Data is global/account-wide, but tasks can now live on `Global` or on individual character boards.
- `Global` tasks are visible on every character board while keeping per-character progress state.
- This is a starter foundation intended for iterative improvements.
