# TODO Planner Backlog

Scan date: 2026-09-04

This backlog is based on a source-code scan of the addon. I verified Lua syntax locally, but the bug list still needs in-game confirmation where noted.

## Current Functionality

- Addon bootstrap and namespace setup through `TODOPlanner.lua` and `Core/Bootstrap.lua`.
- Account-wide saved variables in `TODOPlannerDB`, with defaults and migration in `Data/Database.lua`.
- Board model with built-in `All`, `Global`, and `Archived` boards plus character/custom boards.
- Kanban planner with `To Do`, `In Progress`, and `Done` columns.
- Task creation from the main toolbar and detailed task editor.
- Task detail window with resize support, notes, metadata, archive/edit actions, and achievement-specific details.
- Drag and drop task movement between statuses, with a drop indicator and stable sort order.
- Category filtering for task cards.
- Board creation and deletion. Deleting a board moves its tasks to `Global`.
- Achievement integration that adds buttons to the Blizzard achievement UI and Krowi Achievement Filter when available.
- Achievement task auto-completion when the underlying achievement is complete.
- Achievement detail enrichment: criteria rows, progress bars or text, series display, Wowhead link copy dialog, and open-achievement actions.
- Home launcher window for Collections, Planner, and Favorites.
- Static patch catalog for mounts, pets, toys, and achievements, currently centered around patch `12.0` and `12.1`.
- Collection Explorer with patch/type/status filters, mount source filtering, achievement category filtering, search, model/icon preview, Wowhead links, favorites, map buttons, and bulk "Add Missing".
- Favorites window with type filter, search, preview, remove action, task creation, Wowhead links, and map buttons.
- Collection scanner integration for current mount, pet, toy, and achievement ownership state.
- Collection map window with custom map art, curated pins, details panel, zoom/pan, waypoint setting, and optional projection onto the Blizzard world map.
- Release helper script that bumps the TOC semantic version, commits, tags, and pushes.

## Verification Performed

- `luac -p` passed for all 24 Lua files.
- `luacheck` found 0 errors and 19 warnings. Most warnings are expected WoW globals or ignored API return values. The only meaningful cleanup warning is in `Integrations/Achievements.lua:613`.

## Resolved Items

### Global Tasks Now Appear On Character Boards

Status:
- Fixed in the working tree on 2026-09-04.
- `Global` tasks remain owned by `Global`.
- Character boards include `Global` tasks.
- Character-specific progress is stored in `statusByBoard`.
- Character-specific ordering for global tasks is stored in `sortOrderByBoard`.

Changed:
- `Data/TaskRepository.lua` now makes task status and sort order board-aware.
- `Data/Database.lua` now preserves and normalizes `statusByBoard` instead of deleting it.
- `UI/TaskCard.lua` now updates status in the currently selected board context.
- `UI/TaskDetailWindow.lua` now displays the status for the currently selected board context.
- `Core/Constants.lua` bumps the saved-variable schema version to `3`.

### Achievement Series Helper Warning Cleaned Up

Status:
- Fixed in the working tree on 2026-09-04.
- `Integrations/Achievements.lua` now checks that `GetNextAchievement` exists before assigning the `pcall` result.

## Bugs And Risks

### P1 - Collection Ownership Cache Can Go Stale While Windows Stay Open

Evidence:
- `Integrations/CollectionScanner.lua:15` resets mount and pet caches.
- Cached data is reused at `Integrations/CollectionScanner.lua:29` and `Integrations/CollectionScanner.lua:100`.
- Explorer/Favorites reset caches on open or manual refresh only: `UI/CollectionExplorerWindow.lua:1192`, `UI/CollectionExplorerWindow.lua:1293`, `UI/FavoritesWindow.lua:829`, `UI/FavoritesWindow.lua:922`.

Impact:
- If the player learns a mount, captures a pet, or obtains a toy while the window is open, the list may still show stale collected/missing state until refresh or reopen.

Suggested fix:
- Register relevant collection events and call `CollectionScanner:ResetCache()` plus rerender visible collection windows.
- Candidate events to test in-game: mount journal update, pet journal update, toybox update, bag/item learned events, and achievement earned.

### P2 - Drag Ordering In `All` Or `Archived` Can Rewrite Sort Orders Across Boards

Evidence:
- `Data/TaskRepository.lua:156` handles relative drag moves.
- When the selected board is `All` or `Archived`, the function does not move the task to a concrete board, but it still builds an ordered list from `MatchesBoardView`.
- Sort orders are then reassigned on the combined visible set.

Impact:
- Reordering in aggregate views can affect task order when returning to individual boards.
- Archived task ordering can mix unrelated board histories.

Suggested fix:
- Disable drag reordering on `All` and `Archived`, or store sort order by board/status/view.

### P2 - Shared Window Position Causes Surprising Placement

Evidence:
- `UI/Widgets.lua:135` saves a single `TODOPlannerDB.settings.frame`.
- `UI/HomeWindow.lua:162` and `UI/MainWindow.lua:467` both load that same frame position.
- Explorer, Favorites, Map, Detail, and Options mostly open centered or relative to other windows.
- Slash reset moves all managed windows at `Core/SlashCommands.lua:54`.
- Options reset only moves the planner frame at `UI/OptionsWindow.lua:161`.

Impact:
- Moving the Home window changes where the Planner opens next, and vice versa.
- Options "Reset Position" may leave currently visible non-planner windows where they are even though the shared saved setting was reset.

Suggested fix:
- Store per-window positions, or explicitly define one canonical main position and label it that way.

### P2 - Map Pin Rendering Assumes Valid Pin Coordinates

Evidence:
- `UI/CollectionMapWindow.lua:750` multiplies `pinData.x` and `pinData.y` directly.
- `Data/PatchCatalog.lua:992` validates parsed `/way` strings, but future callers could pass hand-built payloads.

Impact:
- A bad catalog entry or external caller could throw during map rendering.

Suggested fix:
- Guard each pin with `tonumber(pinData.x)` and `tonumber(pinData.y)` before placing it.
- Skip invalid pins and show a status count like "2 of 3 pins rendered".

### P2 - World Map Projection Uses Canvas Width/Height Directly

Evidence:
- `UI/CollectionMapWindow.lua:513` refreshes projected pins.
- `UI/CollectionMapWindow.lua:528` reads `child:GetWidth()` and `child:GetHeight()`.
- Pins are placed as normalized `x/y * width/height`.

Impact:
- This may drift on maps with unusual art extents, zoom state, inset areas, or Blizzard map layout changes.

Suggested fix:
- Prefer Blizzard map canvas pin APIs if available.
- At minimum, test projected pins on continent, zone, dungeon, and sub-zone maps.

### P3 - Clipboard Copy Success Requires Read-Back Verification

Evidence:
- `Integrations/Achievements.lua:118` implements clipboard copy.
- Success requires `self:GetClipboardText() == text` at `Integrations/Achievements.lua:139` and `Integrations/Achievements.lua:148`.

Impact:
- If the client allows clipboard write but blocks clipboard read, the addon may show the manual copy dialog even after a successful write.

Suggested fix:
- Treat a non-false write result as success when read-back is unavailable, or keep the dialog but change messaging to "Link ready to copy".

## Feature Ideas

### High Value

- Per-character progress for global tasks.
- Due dates, reset timers, and recurring tasks for weekly/daily goals.
- Priority, tags, and saved task filters.
- Subtasks/checklists inside a task, especially for achievement criteria or farming steps.
- Unarchive action in task detail and archived board rows.
- Cross-board search page that can find tasks by title, notes, source ID, category, and board.
- Bulk actions for selected collection rows: add to planner, favorite, copy waypoints, hide, or mark ignored.
- Event-driven collection refresh so Explorer and Favorites update immediately after learning/capturing/earning something.
- Account-wide duplicate source detection with "open existing task" support.

### Collection Explorer

- Sort controls: name, source, missing first, collected first, patch, reward type, and difficulty/source category.
- Region/source filters for shop, promotion, Trading Post, unavailable, placeholder, and unknown items.
- "Ignore/Hide this entry" for unobtainable or unwanted catalog items.
- User notes per catalog entry, separate from generated task notes.
- Currency/cost tracking for vendor rewards.
- Route mode for map entries with many pins, including next pin, copy all `/way`, and TomTom integration if installed.
- Show current task board/name when an entry already has a task.
- One-click "open existing task" from Explorer/Favorites rows and preview panels.
- Patch summary dashboard with completion percentage by type and source.
- Catalog validation tool that reports duplicate names, duplicate IDs, invalid waypoints, missing details, and placeholder entries.

### Planner

- Task templates for common grinds: weekly raid, rare rotation, reputation farm, pet battle family, vendor currency farm.
- Minimap/DataBroker launcher.
- Import/export saved tasks and favorites as text for backup or sharing.
- Better task cards with icons for achievement/mount/pet/toy source tasks.
- Inline edit for status, category, board, priority, due date, and tags.
- Confirmation setting for delete/archive actions.
- Optional compact board mode with shorter task cards.
- Per-window saved size and position.

### Achievement Integration

- Create a task from selected achievement detail page, not only list rows.
- Add a task for an entire achievement series.
- Add generated subtasks from visible criteria rows.
- Better Krowi compatibility checks and a diagnostic command for whether hooks are active.
- Option to auto-create tasks for incomplete reward achievements from the current patch catalog.

### Collection Map

- Safer pin validation with bad-waypoint reporting.
- Multi-map grouped view for entries with pins on several maps.
- Copy all waypoints button.
- Set next waypoint button that cycles through pins.
- Optional persistent world-map overlay until cleared.
- Test command that opens a known catalog entry instead of only a generic prototype.

### Options And Settings

- Add options for collection default patch, default status filter, source filters, and hidden/ignored entries.
- Add model preview settings: default zoom, default facing, preview size.
- Add progress display options for planner cards, not only detail criteria.
- Add per-window reset buttons.
- Add debug section with scanner cache state and loaded integration status.

## Maintenance Tasks

- Add a `.luacheckrc` tuned for WoW globals so warnings stay useful.
- Keep `README.md` in sync with actual board semantics.
- Consider splitting duplicated Explorer/Favorites preview code into a shared helper.
- Add a small catalog QA script for static data.
- Add release notes/changelog generation to `release.ps1`.
- Add smoke-test checklist for in-game validation after each release.

## Suggested Next Milestones

1. Fix or clarify the `Global` board semantics.
2. Add collection event cache invalidation.
3. Add duplicate source detection across boards.
4. Add unarchive and open-existing-task actions.
5. Add collection route utilities: copy all waypoints, next waypoint, and map pin validation.
