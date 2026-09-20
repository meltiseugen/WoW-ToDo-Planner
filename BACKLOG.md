# TODO Planner Backlog

Scan date: 2026-09-06

Latest Planner-only exploration: 2026-09-19

Planner implementation started: 2026-09-20

This backlog is based on source-code scans of the addon. I verified Lua syntax locally, but the bug list still needs in-game confirmation where noted.

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
- Static patch catalog for mounts, pets, toys, and achievements, currently centered around patches `12.0`, `12.0.5`, `12.0.7`, and `12.1`.
- Collection Explorer with patch/type/status filters, mount source filtering, achievement category filtering, search, model/icon preview, Wowhead links, favorites, map buttons, and bulk "Add Missing".
- Favorites window with type filter, search, preview, remove action, task creation, Wowhead links, and map buttons.
- Collection scanner integration for current mount, pet, toy, and achievement ownership state.
- Collection map window with custom map art, curated pins, details panel, zoom/pan, waypoint setting, and optional projection onto the Blizzard world map.
- Release helper script that bumps the TOC semantic version, commits, tags, and pushes.

## Verification Performed

- `luac -p` passed for all 24 Lua files.
- `luacheck` found 0 errors and 19 warnings. Most warnings are expected WoW globals or ignored API return values. The only meaningful cleanup warning is in `Integrations/Achievements.lua:613`.
- Re-ran a collection-only code scan on 2026-09-06 across `Data/PatchCatalog.lua`, `Integrations/CollectionScanner.lua`, `UI/CollectionExplorerWindow.lua`, `UI/FavoritesWindow.lua`, `UI/CollectionMapWindow.lua`, `Core/Bootstrap.lua`, and `TODO-Planner.toc`.
- Re-verified every Lua file with `luac -p (rg --files -g "*.lua")`; syntax passes.
- Re-ran a Planner-only source scan on 2026-09-19 across `Core/Constants.lua`, `Core/SlashCommands.lua`, `Core/Bootstrap.lua`, `Data/BoardManager.lua`, `Data/TaskRepository.lua`, `Data/Database.lua`, `Integrations/Achievements.lua`, `UI/MainWindow.lua`, `UI/TaskCard.lua`, `UI/TaskDetailWindow.lua`, `UI/TaskEditWindow.lua`, `UI/Widgets.lua`, and the relevant Home/Options navigation paths.
- Re-verified all 24 Lua files with `luac -p` during the Planner scan; syntax passes.
- Reproduced the deleted-board persistence bug with a headless Lua fixture: deleting a board with a Global-task override removes it initially, but `Database:Init()` reconstructs it from `statusByBoard`/`sortOrderByBoard`.
- No automated repository, migration, or UI test suite was found. Findings marked for in-game confirmation are based on static frame geometry or WoW UI lifecycle behavior.
- Added `Tests/planner_data_tests.lua` on 2026-09-20. Its initial regression scenarios cover durable board deletion, override-only board deletion, stale Global achievement status normalization, archived-achievement protection, per-character Global status/ordering, Global-to-character conversion, and archive visibility.
- `lua Tests/planner_data_tests.lua .` passes all 7 Planner data tests, and `luac -p` passes all 25 Lua files after the first correctness changes.

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

### Collection Map Canvas Scaling Normalized

Status:
- Fixed in the working tree on 2026-09-06.
- `UI/CollectionMapWindow.lua` now applies map scale to the content frame and keeps tile, explored overlay, and pin coordinates in raw map-layer pixels.
- Pin buttons are counter-scaled so zooming changes the map art while keeping click targets readable.

### Achievement-Sourced Collection Map Payloads Unblocked

Status:
- Fixed in the working tree on 2026-09-06.
- `Data/PatchCatalog.lua` now allows achievement-sourced mounts, pets, and toys to expose map payloads when their detail record has explicit waypoint data.
- Achievement-sourced collection entries without explicit waypoints remain suppressed, avoiding empty duplicate map buttons for simple achievement rewards.

## Bugs And Risks

### Planner Exploration Findings - 2026-09-19

#### P1 - Deleted Boards Can Return After Reload

Status:
- Fixed in the working tree on 2026-09-20; in-game verification remains.
- `BoardManager:DeleteBoard()` now removes the deleted board from every Global task's status/order overrides, collapses empty override tables, and updates affected timestamps.
- Owned tasks moved to Global also discard invalid per-board override tables.
- Headless regression coverage confirms both owned-task and override-only boards remain deleted after `Database:Init()`.

Evidence:
- `Data/BoardManager.lua:187-211` moves tasks owned by the deleted board to `Global` and removes the board from `TODOPlannerDB.characters`.
- That deletion path does not remove the deleted key from Global tasks' `statusByBoard` or `sortOrderByBoard` tables.
- `Data/Database.lua:84-113` treats keys in those per-board override tables as character boards and adds them back to the normalized character list.
- `BoardManager:CountBoardTasks()` only counts tasks owned by the board, so the confirmation can report `0 tasks` while hidden Global-task overrides still make the board persistent.

Impact:
- A board appears deleted for the current session but returns after `/reload` or login.
- Stale per-board progress and ordering remain attached to Global tasks indefinitely.
- Repeated deletion cannot permanently remove the board until every stale override is removed.

Suggested fix:
- Make board deletion an atomic cleanup operation: move owned tasks to `Global`, remove `statusByBoard[boardKey]` and `sortOrderByBoard[boardKey]` from every Global task, then remove the board registry entry.
- Collapse empty override tables back to `nil` to keep saved variables small.
- Decide whether database normalization should discover boards from task overrides at all, or only preserve overrides for boards already present in the registry.
- Add a reload-style regression fixture covering a board with owned tasks, a board with only Global-task overrides, and a board with both.

Acceptance criteria:
- Delete a board that has Global-task status/order overrides, run `Database:Init()`, and confirm the board does not return.
- Tasks owned by the deleted board appear on `Global` with their previous visible status.
- No deleted-board key remains in any task override table.

#### P1 - Aggregate Views Hide Task Ownership And Destructive Scope

Evidence:
- `UI/TaskCard.lua:181-183` displays title and category but not the owning board or whether the task is shared.
- `UI/TaskDetailWindow.lua:102-110` has no Board/Scope detail row.
- `All` and `Archived` combine tasks from multiple boards, while character boards also include shared Global tasks.
- Archive and delete confirmations only show the title. They do not explain that acting on a Global task affects every character board.

Impact:
- Same-named tasks are difficult to distinguish in `All` and `Archived`.
- A user can archive or permanently delete a shared task while believing it belongs only to the currently selected character.
- The current per-character progress model is difficult to understand from the UI.

Suggested fix:
- Add a visible `Global` badge or board-name badge to every card.
- Add Board and Scope fields to task details.
- Include the source board and destructive scope in archive/delete confirmations.
- Consider distinct card styling or an account/shared icon for Global tasks.

Acceptance criteria:
- Every task in `All`, `Archived`, and character views clearly identifies its owner.
- Destructive actions on Global tasks explicitly say they affect all character boards.

#### P1 - Board Movement Is One-Way And Does Not Match The README

Evidence:
- `UI/TaskDetailWindow.lua:245-275` only permits the move action when a task is currently Global.
- `UI/TaskDetailWindow.lua:561-577` hides the move control for character-owned tasks.
- The target menu contains only character/custom boards, so there is no move-to-Global choice.
- `README.md:22` says any task can move between `Global` and a specific character board.

Impact:
- Character tasks cannot move to another character board.
- Character tasks cannot move back to Global.
- A mistaken task destination cannot be corrected without deleting and recreating the task.
- Converting a Global task to local clears every other board's progress overrides without explaining that consequence.

Suggested fix:
- Put a Board selector in the task editor and include Global plus all valid character/custom boards.
- Reuse `TaskRepository:MoveToBoard()` for every direction after defining the intended status/order conversion rules.
- Warn before converting a shared Global task into a local task because other characters will lose access to it.
- Preserve the status visible in the source context and assign a deterministic position in the target status.
- Update the README after the behavior and terminology are finalized.

Acceptance criteria:
- A task can complete the round trip `Global -> Character A -> Character B -> Global` without recreation.
- The selected task remains visible on the expected board with a predictable status after every move.
- Shared per-character progress is never discarded without an explicit warning.

#### P2 - The Themed Planner Toolbar Has Overlapping Controls

Status:
- High-confidence static geometry finding; confirm at supported resolutions and UI scales in-game.

Evidence:
- `UI/MainWindow.lua:461` fixes the Planner width at 1100 pixels.
- Theme chrome and body insets reduce the usable toolbar width.
- `UI/MainWindow.lua:512-534` anchors four controls from the left and four controls from the right.
- With the bundled theme's insets, `Delete Board` ends around x=684 while `Collections` begins around x=658, producing roughly 26 pixels of overlap.

Impact:
- Labels and borders overlap visually.
- Clickable regions may compete, making one of the buttons unreliable near the overlap.
- Lower UI scales, translations, or longer labels could make the collision worse.

Suggested fix:
- Split navigation and board/task controls into separate toolbar rows, or replace fixed widths with a responsive layout.
- Consider moving Home, Collections, Favorites, and Options into a compact navigation strip or overflow menu.
- Add a minimum-size/responsive design instead of relying on one fixed 1100-pixel geometry.

Acceptance criteria:
- No toolbar elements overlap at the minimum supported resolution and common WoW UI scales.
- Every control has a distinct clickable region and fully visible label.

#### P2 - Planner Child Windows Can Be Left Orphaned

Evidence:
- `Core/SlashCommands.lua:28-35` manages Home, Planner, Explorer, Favorites, and Collection Map, but not Task Detail, Task Edit, or Options.
- Task Detail and Task Edit are parented to `UIParent`, not to the main Planner frame.
- Home/Collections/Favorites navigation hides the main Planner frame without consistently closing its child workflow windows.

Impact:
- `/tdp hide` can leave task details, the task editor, or options visible.
- Toggling the addon can open Home while an old task dialog remains above it.
- A task editor can outlive the board context from which it was opened.

Suggested fix:
- Give the Planner one method that hides the main frame plus all owned dialogs, menus, popups, and drag indicators.
- Add the child windows to the slash-command managed window lifecycle, or make Home own a general top-level window registry.
- Decide whether navigation should close dialogs or retain them and restore their parent context; apply the decision consistently.

Acceptance criteria:
- `/tdp hide` leaves no TODO Planner window visible.
- Navigating away from Planner cannot leave an editable task dialog detached from its board context.

#### P2 - Manual Tasks Cannot Use The Existing Category System

Evidence:
- The data model defines `General`, `Achievements`, `Mounts`, `Collections`, `Reputation`, and `Other`.
- `UI/TaskEditWindow.lua:126-152` exposes only title and description.
- Detailed creation hardcodes `category = "General"`, and editing never updates category.
- The main Planner exposes a category filter even though manually created tasks cannot choose a non-General category.

Impact:
- Category filtering is mainly useful for tasks created by integrations.
- A manually entered mount, reputation grind, or achievement cannot be categorized correctly.
- Users cannot correct a category assigned by an integration.

Suggested fix:
- Make the detailed editor the authoritative editor for Title, Description, Category, Status, and Board.
- Optionally add Priority, Due/Reset schedule, Tags, and Recurrence only after the core fields work reliably.
- Show validation errors without discarding unsaved content.

Acceptance criteria:
- Users can create and edit every persisted core task field through the UI.
- Category filters work equally for manual and integration-created tasks.

#### P2 - Reordering While Filtered Can Rewrite Hidden Task Order

Evidence:
- `Data/TaskRepository.lua:373-395` applies the category filter to the cards the user can see.
- `Data/TaskRepository.lua:241-285` rebuilds sort order using every task in the target status, including categories hidden by the current filter.
- Drag anchors come only from visible cards, but hidden tasks are still reindexed around those anchors.

Impact:
- Clearing the category filter can reveal an order the user never saw or intended.
- Reordering a few visible tasks may shift hidden tasks to different relative positions.

Suggested fix:
- Safest first step: disable drag reordering whenever the category filter is not `All`, with a tooltip explaining why.
- Longer-term option: preserve hidden task slots while reordering only the visible subset, then verify the result against mixed-category fixtures.

Acceptance criteria:
- Reordering under a filter either is intentionally disabled or leaves hidden tasks in a documented, predictable order.

#### P2 - Archive Is A One-Way, Account-Wide Operation

Evidence:
- `Data/TaskRepository.lua:402-409` sets `archivedAt`, but there is no inverse repository operation.
- Archived cards disable Archive but provide no Restore/Unarchive action.
- Archiving a Global task removes it from every character board, including boards with separate progress overrides.

Impact:
- Accidental archive cannot be undone.
- Archived becomes a dead-end holding area before permanent deletion rather than a useful history view.
- Global archive scope can surprise a user working on one character board.

Suggested fix:
- Add `Unarchive` at repository, card, and task-detail levels.
- Restore to the previous owner/status/order when possible; otherwise use a documented fallback.
- Decide whether Global tasks need account-wide archive only or optional per-character dismissal/archive state.
- Add board/scope information to both Archive and Unarchive confirmations.

Acceptance criteria:
- Archive/unarchive is a lossless round trip for ordinary and Global tasks.
- The UI explains whether the action affects one board or every board.

#### P3 - Achievement Auto-Completion Can Leave A Character Override Incomplete

Status:
- Fixed in the working tree on 2026-09-20; in-game event verification remains.
- Auto-completion no longer exits merely because the base status is already `DONE`.
- Stale per-character statuses are moved through `TaskRepository:SetStatus()`, which also assigns a valid order in the destination `DONE` column.
- Headless coverage confirms stale overrides are normalized, already-normalized tasks report no change, and archived tasks remain untouched.

Evidence:
- `Integrations/Achievements.lua:519-521` returns early when the task's base status is already `DONE`.
- Per-board override normalization to `DONE` happens only later at lines 529-533.
- A Global achievement task can therefore have base status `DONE` and a character override of `TODO` or `DOING` that is never corrected.

Impact:
- A completed achievement can continue to appear incomplete on one or more character boards.

Suggested fix:
- Treat auto-completion as complete only when the base status and every stored character override are `DONE`.
- Alternatively, always normalize all stored overrides after confirming the achievement is complete.

Acceptance criteria:
- A completed Global achievement task displays `Done` on Global and on every character board, even from a deliberately inconsistent saved-variable fixture.

#### P3 - Board Identity And Board Selection Do Not Scale Cleanly

Evidence:
- `BoardManager:CreateBoard()` uses exact matching for custom names, allowing names such as `Farm` and `farm` to coexist.
- `UI/Widgets.lua:343-402` computes dropdown height from every option and has no scroll container or maximum height.
- Current-character boards are automatically re-created on login, while custom and character boards share the same list and presentation.

Impact:
- Visually duplicate boards can split tasks and progress.
- Accounts with many characters/custom boards can produce a menu taller than the screen.
- Users cannot tell whether a board is a live character board or an arbitrary custom planning board.

Suggested fix:
- Define case-insensitive board identity while preserving display capitalization.
- Separate character boards from custom boards in the selector, or explicitly rename the concept to generic boards.
- Add a scrollable, searchable board selector with section labels and task counts.
- Clarify whether a character's own board can ever be permanently deleted.

#### P3 - Aggregate-View Creation Target Is Implicit

Evidence:
- `TaskRepository:GetSelectedCreationBoardKey()` silently maps `All` and `Archived` to the current character board.
- `TaskRepository:Create()` then changes `selectedBoard` to the creation target.

Impact:
- Creating a task while looking at `All` or `Archived` unexpectedly changes the active board.
- The user is not told where the new task will be created until after the action.

Suggested fix:
- Display the creation target beside the quick-add control.
- For aggregate views, require or remember an explicit target, or default visibly to Global/current character according to a setting.

#### P3 - Inline Quick-Edit State Is Unreachable Technical Debt

Evidence:
- `MainWindow:LoadEditor()` sets `editingTaskId` and changes the quick-add button to `Save Task`.
- No call site invokes `LoadEditor()`.
- Archive/delete/reset paths still contain branches for this unused state.

Impact:
- The main window carries an incomplete secondary editing model alongside the detailed editor.
- Future maintenance may incorrectly assume inline editing is supported.

Suggested fix:
- Either add an intentional card action that enters inline edit mode, or remove the dead state and keep the detailed editor as the single editing path.

### Collection Rescan Findings - 2026-09-06

- `UI/CollectionExplorerWindow.lua`: achievement category filters are behind the catalog. The static catalog now uses categories such as `Prey`, `Housing`, `Currency`, and `Hidden`, but the achievement category dropdown does not expose them.
- `UI/CollectionExplorerWindow.lua`: mount source filters do not include `In-Game Shop`, even though catalog mount details use that category. Shop mounts are only reachable through `All` and cannot be isolated in the source filter.
- `UI/CollectionMapWindow.lua`: if loading map art fails after a previous successful map, `RenderMap` returns before clearing the Project button state. That can leave stale projection controls enabled for an entry whose current map could not render.
- `Data/PatchCatalog.lua`: patch selector sorting is lexical. It is fine for `12.0`, `12.0.5`, `12.0.7`, and `12.1`, but future values such as `12.10` would sort before `12.2`. `Unknown` ordering is also brittle.
- `Data/PatchCatalog.lua`: `ParseWaypoint` only accepts `/way #mapID x y ...`. Common guide formats such as `/way 2413 x y ...` or `/way Zone Name x y ...` are silently ignored, which makes future data entry easy to get wrong.
- `UI/FavoritesWindow.lua`: favorite search is narrower than Collection Explorer search. It misses pet, toy, and achievement acquisition/source/category/effect text, so searches that work in Explorer can fail once the same entry is favorited.
- `Data/PatchCatalog.lua`: direct achievement map payloads can have a nil title because achievements are stored as numeric IDs and the catalog helper only reads `entry.name` from table entries. Explorer/Favorites patch the title afterward, but the lower-level API should return a useful title by itself.
- `UI/CollectionMapWindow.lua`: the test command still uses a Nagrand/Goretooth placeholder instead of a real static catalog entry. It does not exercise current expansion maps, multi-pin data, or collection metadata.

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
- `All patches` view with grouping by patch, useful when a collectible appears in more than one patch bucket or moves after discovery.
- Persist selected patch, collection type, status, source/category filter, and search text so Explorer reopens where the collector left off.
- Map data filters: `Has pins`, `Missing pins`, `Achievement-sourced`, and `Needs validation`.
- Catalog QA panel or slash command that reports duplicate IDs, orphan details, invalid map IDs, ignored achievement-sourced waypoints, and rows with guide text but no map payload.

### Planner

- Board/scope badges on cards and in task details, especially for `All`, `Archived`, and shared Global tasks.
- A complete task editor for title, description, category, status, and board, with clear Global-to-local conversion warnings.
- Bidirectional board movement: Global, character-to-character, and character-to-Global.
- Unarchive/restore with preservation of owner, status, and ordering.
- Cross-board search by title, notes, source ID, category, status, board, priority, due date, and tags.
- A `Today` / `This Reset` view combining actionable tasks across all boards.
- Daily, weekly, seasonal, and custom recurrence tied to WoW reset times, with next-reset countdowns and explicit rollover behavior.
- Due dates, priority, tags, saved filters, and user-defined sorting.
- Subtasks/checklists for farming steps, achievement criteria, currencies, weekly raid bosses, and rare rotations.
- Optional per-character dismissal/completion semantics for Global tasks, separate from account-wide archive/delete.
- Empty-state messaging that distinguishes an empty board from a filter with no matches.
- Scrollable/searchable board selector with character and custom-board sections, task counts, and optional rename support.
- Responsive/resizable Planner layout for smaller resolutions and different UI scales.
- Keyboard workflow: focus quick-add, create, close, move status, open details, and search without requiring the mouse.
- Task templates for common grinds: weekly raid, rare rotation, reputation farm, pet battle family, vendor currency farm.
- Minimap/DataBroker launcher.
- Import/export saved tasks and favorites as text for backup or sharing.
- Better task cards with source icons, board badges, priority, reset/due state, checklist progress, and achievement/mount/pet/toy metadata.
- Inline edit for status, category, board, priority, due date, and tags.
- Scope-aware confirmation settings for delete/archive actions, with stronger defaults for shared Global tasks.
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
- Test command that opens a known catalog entry instead of only the generic map test.
- Batch projection for all visible filtered rows so a collector can project a whole farm session to the world map instead of opening entries one at a time.
- Per-pin completion/visited state for daily or weekly route runs, separate from the permanent collection-owned state.
- Map selector/tabs inside the map window for entries with pins on multiple maps, with pin counts per map.
- One-click task creation from the map window, using active route pins as subtasks or checklist text.

### Favorites

- Favorite groups or tags, for example `weekly`, `daily`, `gold`, `rare drop`, and `group content`.
- `Favorite all missing in this patch` shortcut from the Collection Explorer.
- Optional account-wide vs character-specific favorites.
- Sorting by source type, patch, collected state, and most recently favorited.
- Stale favorite repair when a catalog row moves patch or changes source IDs, preserving the user's favorite where possible.
- Match Favorite search behavior to Collection Explorer search so source text, acquisition notes, achievement categories, effects, and map locations are all searchable.

### Options And Settings

- Add options for collection default patch, default status filter, source filters, and hidden/ignored entries.
- Add model preview settings: default zoom, default facing, preview size.
- Add progress display options for planner cards, not only detail criteria.
- Add per-window reset buttons.
- Add debug section with scanner cache state and loaded integration status.

## Maintenance Tasks

- Expand the initial headless Planner data suite for `BoardManager`, `TaskRepository`, `Database`, and achievement status synchronization. Durable board deletion, achievement override normalization, per-character status/reordering, Global-to-character movement, and archive visibility are covered; creation, unarchive, bidirectional movement, and broader migration fixtures remain.
- Add saved-variable migration fixtures for malformed IDs, stale boards, Global per-board overrides, old schema versions, and archive restoration.
- Add an in-game Planner smoke-test matrix covering board CRUD, task CRUD, Global/character status behavior, filtering, drag ordering, archive/unarchive, navigation, reload persistence, and achievement completion.
- Test the Planner at common resolutions and UI scales, including enough boards/tasks to force scrolling.
- Remove or complete the unreachable inline quick-edit state so there is one clearly supported editing model.
- Add a `.luacheckrc` tuned for WoW globals so warnings stay useful.
- Keep `README.md` in sync with actual board semantics.
- Consider splitting duplicated Explorer/Favorites preview code into a shared helper.
- Add a small catalog QA script for static data.
- Add release notes/changelog generation to `release.ps1`.
- Add smoke-test checklist for in-game validation after each release.

## Suggested Next Milestones

1. Fix Planner data integrity: durable board deletion, override cleanup, achievement override normalization, and regression fixtures.
2. Make task scope safe and visible: board badges, scope-aware confirmations, complete field editing, and bidirectional board movement.
3. Complete the archive workflow and Planner window lifecycle: Unarchive plus consistent hide/navigation behavior for child windows.
4. Fix Planner scaling and interaction risks: toolbar overlap, filtered reordering, scrollable board selection, responsive layout, and aggregate-view creation target.
5. Add cross-board search and a `Today` / `This Reset` workflow before expanding into recurrence, priority, tags, and checklists.
6. Add duplicate source detection across boards and open-existing-task actions.
7. Continue collection route utilities: copy all waypoints, next waypoint, and map pin validation.

## Planner Delivery Plan

### Phase 1 - Correctness And Regression Protection

- Fix durable board deletion and clean all per-board Global overrides.
- Normalize completed achievement tasks across every stored character override.
- Define case sensitivity and identity rules for custom boards.
- Add headless tests for create, move, reorder, archive, delete-board, reload, and migration behavior.

Exit criteria:
- Board/task saved variables survive reload without resurrecting deleted state or losing intended status/order data.
- Core repository behavior is covered without requiring a running WoW client.

### Phase 2 - Safe, Complete Task Management

- Add board/scope badges and Board/Scope detail fields.
- Make title, description, category, status, and board editable in one authoritative task editor.
- Support movement in every board direction with explicit Global conversion behavior.
- Add Unarchive and scope-aware archive/delete confirmations.
- Remove or finish the unreachable inline quick-edit path.

Exit criteria:
- Every persisted core task field can be corrected without deleting the task.
- Shared actions cannot be mistaken for character-local actions.
- Archive/unarchive and board movement are reversible and documented.

### Phase 3 - Planner UI Reliability And Scale

- Repair toolbar geometry and introduce a responsive/resizable layout.
- Make all Planner-owned dialogs participate in hide/navigation lifecycle.
- Add a bounded, scrollable/searchable board menu.
- Define filtered drag behavior and add empty/filter-result states.
- Show or request an explicit creation target in aggregate views.

Exit criteria:
- No overlaps or inaccessible controls at supported resolutions/UI scales.
- `/tdp hide` closes every Planner-owned surface.
- Large board/task collections remain navigable and ordering remains predictable.

### Phase 4 - Planning Workflow

- Add cross-board search and saved filters.
- Add priority, due/reset schedule, recurrence, tags, and checklist data incrementally.
- Introduce `Today` / `This Reset` views only after recurrence and rollover rules are covered by tests.
- Enrich cards with source icons, board scope, progress, priority, and reset state while retaining an optional compact mode.

Exit criteria:
- The Planner answers: what should I do now, on which character, before which reset, and what remains afterward?

## Planner In-Game Acceptance Checklist

- Create manual tasks in every category and edit title, description, category, status, and board.
- Move a task through `Global -> Character A -> Character B -> Global` and verify visibility/status/order at each step.
- Give a Global task different per-character statuses, delete one character/custom board, `/reload`, and confirm it stays deleted without affecting other boards.
- Archive and unarchive local and Global tasks; verify owner, status, order, and scope messaging.
- Delete a Global task from a character board and verify the confirmation clearly states the account-wide effect.
- Filter to a single category, attempt a reorder, clear the filter, and verify hidden-task ordering follows the documented behavior.
- Open Task Detail, Task Edit, and Options, run `/tdp hide`, and confirm no addon window remains visible.
- Navigate Planner -> Home -> Collections -> Planner while dialogs are open and confirm there are no orphaned windows or stale task contexts.
- Test `All` and `Archived` with duplicate task titles across boards and verify every row clearly identifies its owner.
- Complete an achievement with a deliberately stale Global per-character override and verify every board displays `Done`.
- Test the toolbar at the minimum supported resolution and several UI scales; verify labels, hit regions, and columns do not overlap or leave the screen.
- Populate enough boards to exceed screen height and verify the board selector remains fully usable.
- Create from `All` and `Archived` and confirm the destination is explicit before saving.






# RAW details:

Planner discovery report
I reviewed the Planner’s board/task storage, Kanban UI, cards, detail/editor windows, archive behavior, filtering, drag ordering, achievement completion, and navigation. No files were changed.
All 24 Lua files pass luac -p. There is no automated test suite, so UI findings still need an in-game pass.
Bugs and functional gaps
1. High — Deleted boards can return after /reload
Deleting a board removes it from characters, but it does not remove that board’s entries from Global tasks’ statusByBoard or sortOrderByBoard ([BoardManager.lua (line 187)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/BoardManager.lua:187)). Database initialization later reconstructs boards from those entries ([Database.lua (line 84)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/Database.lua:84)).
I reproduced this headlessly: delete Farm, reload the database, and Farm returns.
2. High — Task movement between boards is only one-way
The detail window only shows “Move to Board” for Global tasks and only offers character boards ([TaskDetailWindow.lua (line 245)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/TaskDetailWindow.lua:245), [TaskDetailWindow.lua (line 561)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/TaskDetailWindow.lua:561)).
Consequently:
- Character tasks cannot move to another character.
- Character tasks cannot move back to Global.
- A mistaken board assignment cannot be corrected fully.
This contradicts the README claim that any task can move between Global and character boards ([README.md (line 22)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/README.md:22)).
3. High — Aggregate views do not identify task ownership
Cards display only title and category ([TaskCard.lua (line 181)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/TaskCard.lua:181)), while task details omit the board entirely ([TaskDetailWindow.lua (line 102)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/TaskDetailWindow.lua:102)).
On All and Archived, users cannot tell which board owns a task. On character boards, Global tasks are visually indistinguishable from local tasks. This is dangerous because archiving or deleting a Global task affects it account-wide.
4. Medium — The themed Planner toolbar overlaps
With the bundled theme’s window/body insets and the fixed 1100-pixel window, the left controls end around x=684 while the right-side Collections button starts around x=658. That creates roughly 26 pixels of overlap between “Delete Board” and “Collections” ([MainWindow.lua (line 461)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/MainWindow.lua:461), [MainWindow.lua (line 506)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/MainWindow.lua:506)).
This needs an in-game visual confirmation at different UI scales.
5. Medium — Planner child windows can become orphaned
/tdp hide manages the main Planner but not its task detail, task editor, or options windows ([SlashCommands.lua (line 28)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Core/SlashCommands.lua:28)). Those dialogs are parented directly to UIParent, so they can remain visible after the Planner is hidden or navigation switches to another section.
The same lifecycle issue exists when Home, Collections, or Favorites hides only the main Planner frame.
6. Medium — Manual tasks cannot use the category system properly
The detailed editor exposes only title and description. Creation always hardcodes General, and editing never changes category ([TaskEditWindow.lua (line 126)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/TaskEditWindow.lua:126)).
Therefore, the category filter is mostly useful for tasks created by integrations; users cannot manually create a Mount, Reputation, Achievement, or Other task through the Planner.
Status and board are also absent from the editor.
7. Medium — Reordering while filtered rewrites hidden task order
The rendered list applies the category filter ([TaskRepository.lua (line 373)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/TaskRepository.lua:373)), but drag reordering rebuilds sort order using every task in the status, including hidden categories ([TaskRepository.lua (line 241)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/TaskRepository.lua:241)).
After dragging under a filter and returning to All, previously hidden tasks can appear in unexpected positions. Either preserve hidden slots or disable drag ordering while filtered.
8. Medium — Archive is a one-way workflow
Tasks can be archived, but there is no repository or UI action to restore them ([TaskRepository.lua (line 402)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/TaskRepository.lua:402)). The Archived board consequently behaves more like a pre-deletion holding area than a usable archive.
For Global tasks, archiving from one character also removes the task from every character board without explaining that scope.
9. Low — Achievement completion has a per-board edge case
Auto-completion returns immediately whenever a task’s base status is already DONE ([Achievements.lua (line 519)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Integrations/Achievements.lua:519)). If a Global task has base DONE but a character override still says TODO or DOING, the override is never corrected even when the achievement is complete.
10. Low — Board identity and scale need hardening
    - Custom board duplicate detection is case-sensitive, so Farm and farm can coexist ([BoardManager.lua (line 138)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/Data/BoardManager.lua:138)).
    - The board dropdown grows without a scroll container, eventually exceeding the screen with enough boards ([Widgets.lua (line 343)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/Widgets.lua:343)).
    - The main board is fixed at 1100×660, making lower resolutions and aggressive UI scaling problematic.
    - An apparent inline quick-edit path exists, but LoadEditor is never called; editingTaskId is effectively dead state ([MainWindow.lua (line 44)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/UI/MainWindow.lua:44)).
Recommended improvements
The highest-value usability improvements are:
- Add a prominent Global or board-name badge to every card and detail view.
- Include scope in destructive prompts: “Delete this shared Global task from every board?”
- Make the detailed editor authoritative: title, description, category, status, and board.
- Support movement in every direction, with an explicit warning when converting a shared Global task into a local task.
- Add Unarchive and possibly “Archive only for this character” semantics.
- Show clear empty states such as “No tasks match the Reputation filter.”
- Add search across title, description, board, category, and source.
- Add compact cards, source icons, achievement progress, and optional metadata.
- Add scrollable board selection and a responsive/resizable Planner layout.
- Disable filtered reordering initially, then implement predictable filtered-order semantics later.
For a WoW-focused planner, the strongest larger feature would be reset-aware tasks:
- Daily, weekly, seasonal, or manually recurring tasks.
- Next-reset countdown and automatic roll-forward.
- Due date and priority.
- Checklists for farming routes, achievement steps, and currencies.
- A “Today / This Reset” view across boards.
Suggested implementation order
1. Data integrity
   Purge per-board Global overrides when deleting a board, normalize board identity, fix the achievement override edge case, and add headless tests for repository/database behavior.
2. Safe task management
   Add board badges, scope-aware confirmations, bidirectional movement, category/status editing, and archive restoration.
3. Window and UI correctness
   Fix toolbar overlap, close or hide child windows with their parent, make dropdowns scrollable, and validate at multiple resolutions/UI scales.
4. Scaling the workflow
   Resolve filtered drag semantics, add search and meaningful empty states, then introduce compact cards and richer card metadata.
5. WoW-native planning
   Add recurrence, reset schedules, due dates, priority, checklists, and a cross-board “This Reset” view.
The current [BACKLOG.md (line 87)](/D:/World of Warcraft/_retail_/Interface/AddOns/TODO-Planner/BACKLOG.md:87) already contains several good feature directions, but the durable board-deletion bug, one-way movement, missing board identity, toolbar overlap, filtered reorder behavior, and child-window lifecycle should be added ahead of most new functionality.
