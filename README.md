# TODO Planner (WoW Addon)

Base Kanban-style planner addon for World of Warcraft.

## What this base includes
- Account-wide data storage (`SavedVariables: TODOPlannerDB`)
- 3 Kanban columns: `To Do`, `In Progress`, `Done`
- Task fields: title, notes, category, status, timestamps
- Categories for planning goals:
  - Achievements
  - Mounts
  - Collections
  - Reputation
  - Other
- Category filtering for board view
- Edit, delete, and status movement for tasks
- Draggable main window with saved position

## Commands
- `/tdp` or `/todoplanner`: toggle window
- `/tdp show`: show window
- `/tdp hide`: hide window
- `/tdp resetpos`: reset window to center
- `/tdp help`: print command help

## Notes
- Data is global/account-wide (shared across all characters on the same account+realm set for this client install).
- This is a starter foundation intended for iterative improvements.