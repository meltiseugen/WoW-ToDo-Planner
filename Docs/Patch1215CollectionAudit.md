# Patch 12.1.5 collection audit

Reviewed **2026-10-15** against live client **12.1.5.70391**, compared with **12.1.0.69933**. Release dates are October 13 in North America and October 14 in Europe. This extends the catalogue's existing scope: permanent and historically trackable gameplay collectibles, excluding shop, Trading Post, calendar events, housing decor, ordinary equipment, hidden trackers, and statistics.

| Type | Added to catalogue | Coverage |
| --- | ---: | --- |
| Mounts | 3 | Corrupted Swarmer, Loa-Blessed Wayfarer, Sporebearer Fungal Strider |
| Pets | 3 | Aqir Wingreaver, Aqir Scuttler, Aqir Razorwing |
| Toys | 10 | All ten additions in the live Toy table |
| Cosmetics | 11 | Seven Labyrinth treasures, two Delve vendor tokens, two campaign tokens |
| Achievements | 38 | Campaign, invasions, raid/guild kills, Labyrinth, mount ownership, Keystone Myth |
| Total | 65 | Separate durable IDs; no duplicates in earlier patches |

The new data lives in `Data/Patch1215Collections.lua` and loads before `Data/PatchCatalog.lua`. The Explorer defaults to 12.1.5 and includes it in Midnight's patch selector. All new entries have source links, acquisition instructions, tips, and a research date. These shared rewards use explicit neutral faction metadata so a Silvermoon location does not create a misleading Horde badge.

## Evidence and inclusion decisions

- [Blizzard's update notes](https://worldofwarcraft.blizzard.com/en-us/news/24304162/1215-content-update-notes) establish the patch content and the 3,600-rating Keystone Myth reward. They also remove Snake Eyes, Snake Eater, and Good Night, Sweet Prince from Glory of the Wartorn Hero; the existing BfA mount and meta notes are updated without moving their original patch attribution.
- Public client tables were compared by ID: [Mount](https://wago.tools/db2/Mount/csv?build=12.1.5.70391), [BattlePetSpecies](https://wago.tools/db2/BattlePetSpecies/csv?build=12.1.5.70391), [Toy](https://wago.tools/db2/Toy/csv?build=12.1.5.70391), [Achievement](https://wago.tools/db2/Achievement/csv?build=12.1.5.70391), and [Item](https://wago.tools/db2/Item/csv?build=12.1.5.70391). The same URLs with `build=12.1.0.69933` are the baseline.
- Eight new Mount records resolve to three gameplay rewards and five excluded shop/Trading Post mounts. All three new pet species and all ten new toys have gameplay sources.
- Fifty-five new Achievement records resolve to 38 eligible achievements. Eight calendar/event records and nine hidden/statistic records are excluded. Hidden personal Keystone tracking is not the public Keystone Myth achievement.
- The Item comparison found 89 new cosmetic-armor records. Nine sourced learn-on-use tokens are retained; the remaining 80 contain shop/Trading Post families, calendar pieces, and unsourced variants. Two older dormant campaign weapon/shield tokens become obtainable here, bringing the catalogue total to eleven. Tooltip verification confirms that all eleven teach appearances when used.
- [Chef sets and tray variants](https://www.wowhead.com/news/get-cooking-with-new-chef-transmogs-coming-in-patch-12-1-5-382769) are Trading Post or still unsourced, rather than assumed Labyrinth loot. Steel-Plated Cushion Boots also appear in [Trading Post data](https://www.wowhead.com/ptr/news/new-trading-post-rewards-datamined-from-the-patch-12-1-5-ptr-382771).
- [Campaign reward reporting](https://www.icy-veins.com/wow/news/complete-kithix-raid-for-a-hero-neck-or-ring-story-mode-available/) corroborates Hiveborne Hearthstone and the Blood Knight Matriarch weapon/shield tokens. Hiveborne is quest item 281136; Shadeweaver's Hearthstone is boss drop 281615. They are separate toys.
- [The raid guide](https://www.wowhead.com/guide/midnight/raids/the-unbinding-of-kithix-boss-strategy-abilities-rewards) identifies the Mythic-only Libram of the Matriarch. Its generated glyph is not another Toy Box entry.

## Locations and practical notes

| Location | Map and coordinates | Role |
| --- | --- | --- |
| Estelia Archtender | Silvermoon 2393, 39.3 / 80.3 | Aqir reputation vendor |
| Showena | The Den 2576, 62.05 / 68.34 | Strider vendor, interior map |
| Labyrinth | Eversong 2395, 63.0 / 72.2 | Outdoor entrance |
| Kith'ix raid | Underbelly 2613, 73.3 / 8.6 | Raid entrance, not boss position |
| Telemancer Astrandis | Silvermoon 2393, 52.8 / 77.9 | Delve appearance vendor |
| Campaign finale | Silvermoon 2393, 27.6 / 10.9 | What the World Sees quest location |

[Aqir guide](https://www.wowhead.com/guide/midnight/aqir-invasions-locations-reputation-rewards) and the live journal agree on the vendor sources. Live client prices are 1,000 Marl for each lower-tier pet, 2,000 for Razorwing, and 2,500 each for the mount and toy. Older guide tables showing zero are not used as prices. Follow the current map icon in the weekly invasion zone. Launch comments report inconsistent repeat-kill reputation credit, so no fixed number of runs to Exalted is promised.

[The Strider vendor guide](https://www.method.gg/guides/sporebearer-fungal-strider-5-million-gold-mount-vendor-location-in-wow-midnight) supplies the interior vendor pin and passenger costs: five million gold for the mount, another 1.5 million for Auction House access, and 500,000 for a Transmogrifier. Hoshena changes the selected passenger combination. The purchase window lasts through Midnight; it is not retired at review time.

[Labyrinth guide](https://www.wowhead.com/guide/midnight/delves/labyrinth-of-kindojan-megadelve-nemesis-rewards) cross-checks rewards, introduction, and Journey requirements. The data includes chamber names and Journey ranks 3/5/7/9 for sealed-room rewards, an introduction return-quest pin, two toy chest pins, two possible locked-door positions, and three possible hexmask locations.

Interior locations were cross-checked against installed AllTheThings 5.4.0 and HandyNotes Midnight 158 snapshots. See the [AllTheThings source](https://github.com/DFortun81/AllTheThings/tree/master/db/Standard/Categories) for `Delves.lua`, `ExpansionFeatures.lua`, `Instances.lua`, and `Zones.lua`. These are research inputs only; neither addon is a runtime dependency.

## Deadlines and remaining location refinement

- **Fabled Let Me Solo Him: Kindo'jan (64039)** ends at the first regional weekly reset following release. Expected first reset: October 20 NA / October 21 EU. It remains earnable on the review date. The ordinary mount achievement is a separate Season 2 reward.
- Loa-Blessed Wayfarer and One-Champion Army are Season 2 rewards. They are not marked Unobtainable before the season ends.
- The Labyrinth discovery route contains **19 documented chest positions plus the entrance**, not all 44 treasures. Two community snapshots disagree on several Y coordinates; coordinates were not blended or adjusted speculatively.
- A reliable live criterion-index mapping has not been established for these chests. No guessed completion mapping is attached, so pins do not disappear on an unrelated criterion completion.
- Exact chest pins remain pending for some appearance tokens and two sealed-room toys. Their chamber, rank requirement, and entrance remain available.
- The live Toy table still labels Hiveborne's quest as Whatever It Takes, while current quest 95211 and campaign data award it from The Unbinding of Kith'ix. The catalogue records the live quest and explains the stale source label.
- Existing retirement records remain unchanged. A temporary source or future announced deadline is not, by itself, current retirement evidence.

## Validation

- `lua Tests/patch1215_collection_tests.lua .`: four focused checks cover ID uniqueness, all 38 achievement IDs, locations, neutral faction metadata, current availability, selector integration, and all five tabs.
- `lua Tests/collection_availability_tests.lua .`: seven checks preserve retirement and ownership behavior.
- `uv run .codex_validate.py`: checks every patch, excludes duplicate IDs, and validates counts and map references. Totals become 1,204 mounts, 1,551 pets, 750 toys, 2,845 cosmetics, and 8,893 achievements.
- All Lua files pass `luac -p`; `git diff --check` passes.
- Broad planner tests still stop at the existing completed-character sort-order assertion (expected 6, got 1). Actual in-game rendering and server-side acquisition still require a WoW `/reload` check.
