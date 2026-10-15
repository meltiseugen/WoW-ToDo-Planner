# Collection availability audit

Reviewed for Retail on **2026-10-13**. This covers the existing catalog; it does not add excluded shop, promotional, holiday, hidden, or never-released records.

Catalogue coverage extended on **2026-10-15** for live patch 12.1.5. The 474 existing retirement records retain their original review date; new live rewards are not marked retired in advance. See [Patch 12.1.5 collection audit](Patch1215CollectionAudit.md) for the 65 additions, deadlines, sources, and remaining location refinement.

| Collection | Catalog entries screened | Retirement records |
| --- | ---: | ---: |
| Mounts | 1,204 | 158 |
| Pets | 1,551 | 5 |
| Toys | 750 | 8 |
| Cosmetics | 2,845 | 303 |
| Total | 6,350 | 474 |

These are curated retirement candidates. The number shown in game depends on the selected expansion/patch and the player's original unlocks. Unclassified or uncertain records remain unflagged; absence of a flag is not a guarantee of availability. Availability needs another review when rewards return or new seasons end.

## Behavior

- `Status: Unobtainable` shows flagged entries, including owned retired rewards.
- `Missing` shows unowned entries without an unobtainable flag.
- `All` preserves the complete catalog; `Collected` preserves ownership tracking.
- The row, preview, and fallback tooltip identify unobtainable rewards. Preview instructions are labeled `Original acquisition` and include the reason.
- Status selection persists across reload. Existing `collectionHideCollected` settings migrate to `Missing` or `All`.
- No task status, completion, favorite, or catalog identity is rewritten.

The summary's unobtainable count includes owned retired entries, so it can overlap the collected count.

## Covered rewards and evidence

### Mounts

The retired-mount index was matched against all 1,201 catalog mount spell IDs and names, including individual retired pages to catch renamed rewards. This caught Breaker Bee, now listed as Magister's Spell Bee. The data records use explicit spell IDs, not name patterns.

- Original epic racial mounts, ended Gladiator seasons through Midnight Season 1, removed challenge-mode mounts, removed Zul'Aman/tribute/Glory raid rewards, and discontinued launch-event mounts: [Warcraft Mounts retired index](https://www.warcraftmounts.com/retired.php). Individual references are beside the corresponding ID groups in `Data/CollectionAvailability.lua`.
- Final-raid quest rewards include Kor'kron War Wolf, Grove Warden, Violet Spellwing, Uncorrupted Voidwing, Carcinized Zerethsteed, and Royal Voidwing. Royal Voidwing's removal is distinguished from reduced Mythic mount drop rates by [Blizzard's Midnight launch checklist](https://news.blizzard.com/en-us/article/24257262/what-to-tackle-in-the-war-within-before-the-launch-of-midnight).
- Voyaging Wilderling, Pandaria Remix mounts, and Radiant Echoes mounts: [Blizzard's Dragonflight checklist](https://news.blizzard.com/en-us/article/24115317/what-to-tackle-in-dragonflight-before-the-war-within).
- Legion Remix mounts: [Blizzard's event ending notice](https://worldofwarcraft.blizzard.com/en-gb/news/24242738), cross-checked with the retired index.
- Umbral Ashes is the ended Season 1 top-one-percent reward, distinct from Keystone Master/Legend mounts: [Midnight Season 1 checklist](https://worldofwarcraft.blizzard.com/en-gb/news/24293280).
- Arcanovoid Construct is the ended Season 1 solo Nullaeus reward, explicitly included in [Blizzard's seasonal Delve checklist](https://news.blizzard.com/en-us/article/24293280/the-clock-is-ticking-on-midnight-season-1-achievements-and-rewards).
- Tyrannotort retains the original Week 4 quest exception (quest 87552): [Wodin's vendor requirements](https://www.wowhead.com/npc=234297/wodin-the-troll-servant).

### Pets and toys

- Muskpaw Calf and Astral Emperor's Serpentling: [Pandaria Remix pet rewards](https://www.warcraftpets.com/news/new-pets-remix-mists-of-pandaria-coming-soon/). Both are non-cageable achievement pets.
- Tidbit, Morsel, and Fledgling Warden's Companion: the Legion Remix event has ended and these pets cannot be caged. References: [Tidbit](https://www.warcraftpets.com/wow-pets/critter/miscellaneous/tidbit/), [Morsel](https://www.warcraftpets.com/wow-pets/critter/miscellaneous/morsel/), [Warden's Companion](https://www.wowhead.com/npc=251889/fledgling-wardens-companion), and the Blizzard ending notice above.
- Gnomeregan Pride and Darkspear Pride: [removed pre-Cataclysm quest rewards](https://warcraft.wiki.gg/wiki/Gnomeregan_Pride).
- Crimson and Obsidian Legend's Pennants are ended Solo Shuffle rewards: [Obsidian seasonal exclusivity](https://warcraft.wiki.gg/wiki/Obsidian_Legend%27s_Pennant).
- Toxic Victory and Explosive Victory lost their original Delve quest sources in 12.0.1: [removed rewards](https://warcraft.wiki.gg/wiki/Category:Removed_in_patch_12.0.1).
- Enchanted Hourglass and Animated Bench, plus Breaker Bee and seven catalog appearance tokens: [Blizzard's Decor Duel closure notice](https://news.blizzard.com/en-us/article/24271369/updated-7-22-join-the-final-surge-for-decor-duels). Retained housing decor is excluded from retirement.

### Cosmetics

- Retired event tabards and historical elite PvP tabards are explicit item IDs. Theramore's Fall (achievement 7467, earned by the current character) preserves [legacy tabard access](https://warcraft.wiki.gg/wiki/Theramore_Tabard).
- Legion elite ensembles preserve character eligibility for the original shared season groups: 1/2 (11578/11579), 3/4 (11697/11698), and 5/6/7 (12090/12135/12198). Reference: [elite ensemble requirement](https://www.wowhead.com/item=146236/ensemble-elite-vindictive-gladiators-satin-armor).
- Dragonflight elite ensembles preserve Rival I eligibility; weapons preserve Elite eligibility. Verdant appearances also accept the Season 4 unlock. References: [Crimson armor](https://www.wowhead.com/item=230886), [Obsidian armor](https://www.wowhead.com/item=230968), [Verdant armor](https://www.wowhead.com/item=231137), and [Season 4 shared appearances](https://www.wowhead.com/guide/pvp/dragonflight-season-4-rewards).
- Forged armor preserves account Rival I eligibility (40389); Forged weapons preserve account Duelist eligibility (40391). References: [Forged ensemble](https://www.wowhead.com/item=232681), [Duelist](https://www.wowhead.com/achievement=40391), and [Blizzard's original season rewards](https://news.blizzard.com/en-us/article/24177858/last-chance-for-the-war-within-season-1-achievements-and-rewards).
- Dastardly Duos cosmetics preserve account achievements 41948/41949/41950/41951 for two/four/six/eight bosses: [vendor requirements](https://www.wowhead.com/npc=234297/wodin-the-troll-servant). The event unlock is unavailable to new participants, while qualified accounts retain purchases.
- 73 Legion Remix cosmetics are exclusive unlocks, restored unavailable appearances, achievement rewards, or bundles containing new weapon variants. [Unicus sells exclusive ensembles](https://warcraft.wiki.gg/wiki/Unicus); [the Remix reward guide](https://www.wowhead.com/guide/legion-remix-rewards-mounts-transmog) distinguishes new unlocks from old farmable loot. The full component set or unrestricted Remix unlock can be unavailable even when an original boss still drops one matching appearance.

## Exceptions deliberately preserved

- Vicious mounts: later Vicious Saddle access is different from retired Gladiator rewards.
- Old Keystone Master/Legend mounts and the new Saddle recolors: Timelost Saddle access returned. Blizzard's [12.1.5 update notes](https://worldofwarcraft.blizzard.com/en-gb/news/24304162/1215-content-update-notes) confirm another Season 2 Saddle reward. An old season-ending checklist alone is insufficient to retire these mounts.
- Swift Zulian Tiger, Swift Razzashi Raptor, Plagued Proto-Drake, and Thundering Serpent Hatchling: Black Market access counts as obtainable. [Thundering Serpent source](https://www.warcraftpets.com/wow-pets/dragonkin/serpents/thundering-serpent-hatchling/).
- Tradable pets are not retired solely because their original farming source ended. Old pet quests also have replacement drops in several cases.
- Deathwatch Hatchling remains accessible through guilds with its historical guild unlock.
- Ominous Domanus is not retired merely because the solo Nullaeus achievement mount is retired; [player reports describe a Season 2 ordinary-difficulty drop](https://www.wowhead.com/npc=256265/ominous-domanus). Conflicting acquisition reports are insufficient for a definitive pet flag. Etheric Victory is also left unflagged without a confirmed current removal.
- Clock'em, Tylarr Gronnden, and Brawler's Garb returned with the current Brawler's Guild; historical Brawler mounts are separate rewards. [Current rewards](https://www.icy-veins.com/wow/brawlers-guild-guide/).
- Twilight Ascension cosmetics retained a Resonant Crystal vendor after the event: [post-event inventory](https://www.wowhead.com/news/midnight-pre-patch-collectables-available-for-resonant-crystals-380621).
- Ordinary Legion world/dungeon/raid ensembles and cloak appearances remain unflagged when their looks can still be farmed, even though the Bronze bundle vendor is gone. Hammer of Vigilance remains a raid drop. The rare Remix shoulder/weapon bundles have separate unrestricted or additional appearance unlocks.
- Current Midnight Season 2 rewards, recurring events, seasonal rotations, reduced-drop-rate Mythic mounts, and unverified acquisition data are not automatically retired.
- Uncertain older Brawler challenge-shirt sources and past-season Prey inventory are left unflagged pending reliable item-specific confirmation.

## Validation

Run `lua Tests/collection_availability_tests.lua` for ID coverage, metadata, eligibility exceptions, filter composition, ownership, preview text, migration, and persistence. Run `uv run .codex_validate.py` for unchanged catalog counts and data integrity. The new data file must load after `Data/PatchCatalog.lua` in the TOC.

An in-game `/reload` and visual check are still needed to confirm dropdown layout, badges, and preview rendering in the actual WoW client.
