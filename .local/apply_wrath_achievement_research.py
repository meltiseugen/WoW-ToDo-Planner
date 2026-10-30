"""Apply reviewed comment guides and destinations to catalog data only."""
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path

from lupa.lua51 import LuaRuntime, lua_type

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from description_map_support import load_context

lua = LuaRuntime(unpack_returned_tuples=True)
ns, _, _ = load_context(lua)
catalog = ns.PatchCatalog
CACHE = Path(os.environ["TEMP"]) / "tdp-collection-source-research/tooltips"
guides = {}


def add(ids, steps, *, authors=(), corrections=(), profit=False, waypoints=(), maps=(), references=(), tips=None):
    if isinstance(ids, int):
        ids = [ids]
    for identity in ids:
        guides[identity] = {
            "steps": steps, "authors": list(authors), "corrections": list(corrections),
            "matchedProfitGuide": profit,
            "references": [f"https://www.wowhead.com/achievement={identity}#comments", *references],
            "waypoints": list(waypoints), "maps": list(maps), "tips": tips,
        }


COOKS = [(125, 40.3, 66.1, "Katherine Lee - Alliance Northrend Cooking and daily quests"),
         (125, 70.0, 38.9, "Awilo Lon'gomba - Horde Northrend Cooking and daily quests")]
MARCIA = [(125, 52.6, 65.6, "Marcia Chase - Northrend Fishing and daily quests")]
ROKK = [(111, 61.6, 15.8, "The Rokk - Shattrath cooking daily quests")]
TURKEYS = [(117, 69.0, 64.0, "Fjord Turkeys - west of Explorer's League Outpost")]

# Explicit numbered/bulleted comments ending in Profit, with corrections from
# the surrounding discussion. The guides below are newly written summaries.
add(5444, [
    "Go to Fuselight in Badlands (64.3, 38.0). Finish Garyanne Fleezlebop's When the Going Gets Tough, Cheat, then accept It's Goat Time, Baby for the Billy Goat Blaster.",
    "If you already turned in the quest, buy Billy Goat Blaster DX from Gina Gotgoods nearby (64.25, 37.46). Completing the quest does not lock you out.",
    "Put the blaster on your action bar. An optional targeting macro is:\n/target Billy Goat\n/use Billy Goat Blaster\nFor the purchased version, replace the last line with /use Billy Goat Blaster DX.",
    "Locate a route between 12 Billy Goats before firing. Stay mounted, move close to each goat and blast 12 within 60 seconds of your first hit.",
    "If using the quest blaster, wait for achievement credit before handing in the quest. Retry the timed run if necessary.",
], authors=["333888", "culemborgnl", "762263", "Esploratore", "patti221"], profit=True,
    corrections=["The DX item needs the DX macro; the quest item and purchased item are different.",
                 "The vendor version permits attempts after quest completion; flying is helpful, not required."],
    waypoints=[(15, 64.3, 38.0, "Garyanne Fleezlebop - goat quest chain"),
               (15, 64.25, 37.46, "Gina Gotgoods - Billy Goat Blaster DX")])

add([4601, 4621], [
    "Enter Icecrown Citadel in the raid size named by this achievement, reach the Frozen Throne and speak to Tirion to start the encounter.",
    "Stand on the stairs with your back toward the throne. Stop attacking and let the Lich King summon adds; keep them alive for Necrotic Plague to jump between.",
    "Watch Necrotic Plague on yourself and the adds until it reaches at least 30 stacks. The boss's Plague Siphon buff is a different counter.",
    "Only then damage the Lich King. Let the final dialogue, resurrection and Tirion's intervention finish before dealing the killing blow.",
], authors=["Bajungadustin", "Roguesoultms", "Volleynova", "lostelement"], profit=True,
    corrections=["Recent solo reports do not require a pet or an old class-specific threat trick.",
                 "Do not kill adds early or finish the boss during the scripted ending."],
    waypoints=[(118, 53.5, 85.5, "Icecrown Citadel entrance")])

add(1254, [
    "Go to the Fjord Turkey packs beside the road west of Explorer's League Outpost, Howling Fjord (69, 64).",
    "Bind /target Fjord Turkey and a quick damaging ability to convenient keys. Start where you can see several living turkeys.",
    "Kill 15 Fjord Turkeys within three minutes, moving along the road and using respawns when needed. Pilgrim's Bounty turkeys do not count.",
], authors=["68381", "Avrsion", "610726", "659423"], profit=True,
    corrections=["Use Fjord Turkey, not an unspecified Turkey target.", "Holiday turkeys are a different creature."],
    waypoints=TURKEYS)

add([2953, 2954], [
    "Reach Kologarn in Ulduar. Disable pet attacks and incidental cleave so the torso and arms stay alive while you prepare.",
    "Lower the torso's health with controlled single-target damage. Leave enough health to survive the damage transferred when each arm dies.",
    "Destroy one arm, destroy the other, then finish the torso within 12 seconds of the first arm dying. Do not kill the torso before both arms are destroyed.",
], authors=["Volleynova", "Lightweave", "karliflan"],
    corrections=["Arm deaths damage the torso; a universal 20-percent preparation target is unsafe with current damage.",
                 "The objective is both arms and then the torso, inside the same 12-second window."],
    waypoints=[(120, 41.6, 18.2, "Ulduar entrance")])

add([3014, 3017], [
    "Enter Ulduar and reach Sara in Yogg-Saron's room. During the opening phase, stand beside Sara without damaging the Guardians.",
    "Touch Ominous Clouds to spawn additional Guardians of Yogg-Saron. Gather at least nine living Guardians before attacking.",
    "Kill those nine Guardians together with area damage inside 12 seconds. Check for achievement credit before continuing the fight.",
], authors=["LordRaikalo", "hsoftdev17"],
    corrections=["Use opening-phase Guardians of Yogg-Saron, not the later Immortal Guardians, which cannot be killed normally.",
                 "A reply confirms the opening-phase method; later discussion corrects an old bug claim."],
    waypoints=[(120, 41.6, 18.2, "Ulduar entrance")],
    tips="Keep damage procs and pets disabled until all nine Guardians are present. The later Immortal Guardians are the wrong targets.")

add(10553, [
    "Enter Assault on Violet Hold on Mythic difficulty in Broken Isles Dalaran. Millificent Manastorm must be one of the bosses released in that run.",
    "Damage Millificent slowly and wait for Millhouse's dialogue about disarming her squirrel bombs. Defuse a bomb instead of bursting her down.",
    "Continue carefully until Millhouse mocks her hair and she gains her rage effect. Use /laugh at her if following the dialogue prompt.",
    "Kill Millificent while she is enraged. The Manastorm's Duplicator toy is an optional shortcut, not a required purchase.",
], authors=["Volleynova", "adkbmxrider", "maximef1", "alecz24"], profit=True,
    corrections=["The discussion confirms the encounter dialogue can trigger the rage without the toy.",
                 "Do not use an old dated boss-rotation calendar as a current schedule."],
    waypoints=[(627, 66.2, 68.4, "Assault on Violet Hold entrance")])

# Reviewed, useful destinations for actual missing Wrath objectives. Trainers
# are labelled as starting points, never as the location where every skill-up
# or randomly caught item must occur.
add(125, [
    "Visit Katherine Lee (Alliance) or Awilo Lon'gomba (Horde) in Northrend Dalaran and learn Northrend Cooking.",
    "Cook recipes that still grant Northrend skill until that expansion's skill reaches 75. Cooking from a different expansion does not advance this achievement.",
    "Use the Dalaran cooking daily rewards to buy additional Northrend recipes and Northern Spices when trainer recipes stop granting skill.",
], waypoints=COOKS, references=["https://www.wowhead.com/npc=29631/awilo-longomba"])

add(130, [
    "Learn Northrend Fishing from Marcia Chase by the fountain in Northrend Dalaran (52.6, 65.6).",
    "Fish in Northrend waters until the Northrend Fishing skill reaches 75. Progress in Classic, Outland or Broken Isles Fishing is separate.",
], waypoints=MARCIA, references=["https://www.wowhead.com/npc=28742/marcia-chase"])

for identity, amount in [(1998, 1), (1999, 10), (2000, 25), (2001, 50), (2002, 100)]:
    add(identity, [
        "Learn Northrend Cooking, then visit your faction's cooking quest giver in Northrend Dalaran: Katherine Lee for Alliance or Awilo Lon'gomba for Horde.",
        "Accept the available daily, collect or cook its requested items, and return to the same NPC to claim the Cooking Awards.",
        f"Repeat on later daily resets until you have earned {amount} awards. Open reward bags and use any Waterlogged Recipe turn-in you obtain for additional awards.",
    ], waypoints=COOKS, references=["https://www.wowhead.com/npc=29631/awilo-longomba"])

add(877, [
    "Complete cooking daily quests for The Rokk in Shattrath (61.6, 15.8), or your faction's cook in Northrend Dalaran.",
    "Open the daily reward containers until Recipe: Delicious Chocolate Cake drops. Learn the recipe on the character doing this achievement.",
    "Gather its ingredients and personally bake the cake. Buying or eating a finished cake does not satisfy the baking objective.",
], waypoints=ROKK + COOKS, references=["https://www.wowhead.com/item=33925/recipe-delicious-chocolate-cake"])

add(1801, [
    "Do Marcia Chase's fishing daily in Northrend Dalaran and open the Bag of Fishing Treasures for a chance at Recipe: Captain Rumsey's Lager. Outland and Northrend cooking daily containers are another source.",
    "Learn the recipe, then buy a Skin of Dwarven Stout and a Flagon of Dwarven Mead from an innkeeper or drink vendor.",
    "Brew Captain Rumsey's Lager yourself. Purchasing a finished drink does not complete the brewing objective.",
], waypoints=MARCIA + ROKK + COOKS, references=["https://www.wowhead.com/item=34834/recipe-captain-rumseys-lager"])

add(878, [
    "Travel to Howling Fjord and look for Fangtooth Herring Schools along its waters.",
    "Fish those schools for a chance at Dark Herring. Move to another school when one is depleted; the rare catch is not guaranteed in a fixed number of casts.",
    "Catch the fish yourself and loot it. Only one of the listed rare fish is required; buying a rare fish does not count as catching it.",
], maps=[117], authors=["Nikotine", "250338", "32578"])

add(153, [
    "Learn Fishing, then find a visible fish school or Steam Pump Flotsam pool in Zangarmarsh.",
    "Cast so the bobber lands inside the pool, and loot a successful catch. Casting into ordinary open water beside a school does not count.",
], maps=[102])

add(1243, [
    "Fish from wreckage pools, such as Steam Pump Flotsam in Zangarmarsh, and open the trunks or supply crates you catch.",
    "Keep opening these containers until you obtain a Weather-Beaten Journal. Pool positions and the journal drop are random.",
    "Use the journal to learn Find Fish, then enable fish-school tracking on the minimap. Merely owning the journal does not complete the achievement.",
], maps=[102, 56, 71, 50, 210, 66, 69])

add(1781, [
    "Cook or buy at least ten Critter Bites before travelling to the Fjord Turkey packs in Howling Fjord (69, 64).",
    "Find ten separate living critters close together. Target each one and use a Critter Bite, moving quickly between them.",
    "Coerce ten critters within three minutes. Feed the turkeys before killing them if you also want Friend or Fowl? on the same visit.",
], waypoints=TURKEYS, references=["https://www.wowhead.com/achievement=1254/friend-or-fowl#comments"])

for identity, count in [(1777, 15), (1778, 30), (1779, 45)]:
    add(identity, [
        "Learn Northrend Cooking and start with the recipes taught by Katherine Lee or Awilo Lon'gomba in Northrend Dalaran.",
        "Complete their cooking dailies for awards, then buy missing recipes and Northern Spices from the nearby recipe vendors. Learn Northern Stew through a Northrend starter-zone cooking quest and collect other quest recipes as needed.",
        f"Personally cook {count} different recipes from this achievement's checklist. Track missing dishes as you work; buying or eating somebody else's cooking does not count.",
    ], references=["https://www.wowhead.com/npc=29631/awilo-longomba"])

add(137, [
    "Learn Northrend Tailoring and the Heavy Frostweave Bandage recipe. First Aid was removed; this recipe now belongs to Tailoring.",
    "Collect or buy Frostweave Cloth, then craft Heavy Frostweave Bandages until you have created 500. Purchased finished bandages do not count.",
], waypoints=[(125, 38.78, 41.56, "Darin Goodstitch - Northrend Tailoring")],
    references=["https://www.wowhead.com/spell=45546/heavy-frostweave-bandage"])

add(1244, [
    "Track the unread titles in the achievement checklist and visit their original book objects in libraries, inns and dungeons.",
    "Click each original book to open and read it, then check that its title is credited before moving on. A later reprint with the same title may not count.",
    "Use the mapped book-source areas to plan your trip. Place names inside a book title describe its subject, not necessarily where that book is located.",
])

add(1257, [
    "Fish a Steam Pump Flotsam pool in Zangarmarsh and a Schooner Wreckage pool along the Wetlands coast.",
    "Find Floating Wreckage along Tanaris and Bloodsail Wreckage along the Stranglethorn coasts.",
    "Fish Waterlogged Wreckage along Desolace or Feralas. Cast inside each required pool and loot a catch for that criterion.",
    "Pools move and share spawn locations. Clear nearby fishing pools and return along the coast if the wreckage type you need is absent.",
])

add(1206, [
    "Target each required living critter and use /love. You need credit for every species; do not kill them.",
    "In Elwynn Forest, find Cat, Chicken, Cow, Deer, Fawn, Rabbit and Small Frog around Goldshire and its woods or ponds.",
    "In Durotar, find Hare, Swine and Toad. In Northern Barrens, find Gazelle and Prairie Dog; in Un'Goro Crater, find Parrot.",
    "Find Ram in Wetlands, and Sheep and Skunk in Howling Fjord.",
    "Visit Shattrath for Ewe and Northrend Dalaran for Squirrel.",
    "In Borean Tundra, find Borean Frog around the Geyser Fields, Steam Frog around Taunka'le Village's pools, and Shore Crab on the coast. Check the remaining species in your achievement checklist.",
], authors=["1223209", "boraa", "NavySWO91"],
    maps=[37, 1, 10, 78, 56, 117, 111, 125, 114],
    corrections=["Criterion type 54 identifies the love emote, not creature 225. Resolve the named critters instead.",
                 "Critters roam; the map opens their documented habitat areas rather than invented fixed spawn pins."],
    references=["https://www.wowhead.com/achievement=1206/to-all-the-squirrels-ive-loved-before#comments"])

for identity, rank in [(121, 150), (122, 225), (123, 300)]:
    add(identity, [
        "Visit Stephen Ryback in Stormwind (76.8, 53.6) or Zamja in Orgrimmar (32.2, 69.6) to train Classic Cooking.",
        f"Cook Classic recipes that still grant skill, learning higher recipes as needed, until Classic Cooking reaches {rank}.",
        "Check the Classic skill bar specifically. Skill gained in a later expansion's Cooking category does not count for this milestone.",
    ], waypoints=[(84, 76.8, 53.6, "Stephen Ryback - Alliance Classic Cooking"),
                  (85, 32.2, 69.6, "Zamja - Horde Classic Cooking")],
        references=["https://www.wowhead.com/npc=5482", "https://www.wowhead.com/npc=3399"])

for identity, rank in [(126, 150), (127, 225), (128, 300)]:
    add(identity, [
        "Learn Classic Fishing from Arnold Leland in Stormwind (55.0, 69.6) or Lumak in Orgrimmar (66.6, 41.6).",
        f"Fish in Classic waters until the Classic Fishing skill reaches {rank}. Cast, wait for the bobber's bite and loot each catch.",
        "The map marks the trainers as starting points. Fishing skill in Northrend, Outland or another expansion is tracked separately.",
    ], waypoints=[(84, 55.0, 69.6, "Arnold Leland - Alliance Classic Fishing"),
                  (85, 66.6, 41.6, "Lumak - Horde Classic Fishing")],
        references=["https://www.wowhead.com/npc=5493", "https://www.wowhead.com/npc=3332"])

add(124, [
    "Learn Outland Cooking from Gaston in Honor Hold or Baxter in Thrallmar, Hellfire Peninsula.",
    "Cook Outland recipes that still grant skill, learning higher recipes from trainers, vendors and quests as needed, until Outland Cooking reaches 75.",
    "Track the Outland skill bar. Later expansions' Cooking skill does not advance this achievement.",
], waypoints=[(100, 54.0, 63.6, "Gaston - Alliance Outland Cooking"),
              (100, 56.8, 37.4, "Baxter - Horde Outland Cooking")],
    references=["https://www.wowhead.com/npc=18987", "https://www.wowhead.com/npc=18988"])

add(129, [
    "Visit Juno Dufrain at Cenarion Refuge, Zangarmarsh (78.5, 63.0), and learn Outland Fishing.",
    "Fish in Outland waters until Outland Fishing reaches 75. Zangarmarsh's lakes and schools let you work on the skill and Outland Angler together.",
    "Check the Outland skill bar; Classic and Northrend Fishing have separate progression.",
], waypoints=[(102, 78.5, 63.0, "Juno Dufrain - Outland Fishing")],
    references=["https://www.wowhead.com/npc=18993"])

add(727, [
    "Earn Marks of Honor through PvP and visit Lieutenant Karter in Stormwind (76.2, 65.6) or Raider Bork in Orgrimmar (41.8, 72.6).",
    "Buy one of the original Black War mounts listed by this achievement, such as Black War Steed or Black War Wolf. Check the vendor's current price before purchasing.",
    "Use the mount item to learn it. Merely purchasing the item and leaving it refundable is not sufficient.",
], waypoints=[(84, 76.2, 65.6, "Lieutenant Karter - Alliance honor mounts"),
              (85, 41.8, 72.6, "Raider Bork - Horde honor mounts")],
    references=["https://www.wowhead.com/guide/the-ultimate-achievements-guide-player-vs-player-3590"])

add(2097, [
    "Obtain a Mekgineer's Chopper for Alliance or Mechano-hog for Horde. You can buy the finished mount from an engineer or the auction house; Engineering is not required to use it.",
    "To craft one yourself, learn its schematic with Northrend Engineering and Exalted Alliance Vanguard or Horde Expedition reputation. Gather Titansteel Bars, Cobalt Bolts and Arctic Fur.",
    "The engineer buys the specialized motorcycle parts from Roxi Ramrocket in K3, Storm Peaks (40.6, 84.8), then crafts the mount.",
    "Use the finished mount item to learn it. Older comments claiming that crafting or mailing it alone grants achievement credit are outdated.",
], authors=["Thortok2000", "Venator", "smashfanDS", "345621"],
    corrections=["Northrend professions now have their own skill category; do not require an obsolete global 450 skill value.",
                 "Crafting alone no longer completes the achievement; learn the mount."],
    waypoints=[(120, 40.6, 84.8, "Roxi Ramrocket - motorcycle crafting components")])

add(2336, [
    "Earn Honored with Bloodsail Buccaneers by killing Booty Bay guards. This lowers your Steamwheedle Cartel reputations, so do this before restoring the goblins.",
    "Farm Southsea pirates in Tanaris or on Fray Island in Northern Barrens to raise Booty Bay, Ratchet, Gadgetzan and Everlook toward Exalted without sacrificing Bloodsail reputation.",
    "For Ravenholdt, kill Syndicate enemies around Durnholde Keep in Hillsbrad until ordinary kills stop granting reputation. Then turn in Heavy Junkboxes at Ravenholdt Manor; a rogue can pickpocket the boxes for you.",
    "During Darkmoon Faire, complete its profession quests, dailies and other reputation activities until Exalted.",
    "Track all required factions on the character doing the achievement. Shen'dralar is not required. Avoid reputation turn-ins that undo your pirate progress while completing the other factions.",
], maps=[210, 71, 10, 25, 407], authors=["UnholyoneSP"],
    corrections=["Removed Shen'dralar is not a current requirement.",
                 "Old two-day estimates and fixed costs for buying junkboxes are not reliable guide promises."],
    references=["https://www.wowhead.com/guide/insane-in-the-membrane-3358",
                "https://www.wowhead.com/guide/achievements/reputation/a-guide-for-the-insane"])

# Apply only detail entries, leaving ID/category lists and shared records intact.
def python_value(value):
    if lua_type(value) != "table":
        return value
    keys = list(value.keys())
    if keys and set(keys) == set(range(1, len(keys) + 1)):
        return [python_value(value[i]) for i in range(1, len(keys) + 1)]
    return {key: python_value(value[key]) for key in keys}


def literal(value):
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if value is True:
        return "true"
    if value is False:
        return "false"
    if isinstance(value, list):
        return "{ " + ", ".join(literal(v) for v in value) + " }"
    if isinstance(value, dict):
        return "{ " + ", ".join(f"[{literal(k)}] = {literal(v)}" for k, v in value.items()) + " }"
    return str(value)


changes = defaultdict(dict)
for _, patch in catalog.GetPatchKeys(catalog).items():
    for _, identity in catalog.GetEntries(catalog, patch, "achievements").items():
        if identity not in guides:
            continue
        # Also update the TBC content-view copies of the same reviewed objective.
        if not patch.startswith(("2.", "3.")) and identity not in (5444, 10553):
            continue
        old = python_value(catalog.GetAchievementDetails(catalog, patch, identity))
        value = dict(old or {})
        guide = guides[identity]
        value["acquisition"] = "\n".join(f"{i}. {step}" for i, step in enumerate(guide["steps"], 1))
        value["sourceURL"] = guide["references"][0]
        value["sourceType"] = "Achievement"
        value["source"] = " / ".join(p[3].split(" - ")[0] for p in guide["waypoints"]) or value.get("source", "Achievement criteria")
        if value["source"] == "Wrath launch achievement system":
            value["source"] = "Achievement criteria"
        if guide["waypoints"]:
            value["waypoints"] = [f"/way #{mid} {x} {y} {label}" for mid, x, y, label in guide["waypoints"]]
        # Remove the old generic recommendation when the new instructions cover it.
        value.pop("tips", None)
        if guide["tips"]:
            value["tips"] = guide["tips"]
        changes[patch][identity] = value

for patch, entries in changes.items():
    path = next(ROOT.glob(f"Data/Expansions/*/{patch}/Achievements.lua"))
    text = path.read_text(encoding="utf-8")
    start = text.index("    details = {")
    end = text.index("    categories = {", start)
    section = text[start:end]
    for identity, value in entries.items():
        pattern = rf"^        \[{identity}\] = .*?(?=^        \[\d+\] = |^    \}},)"
        replacement = "        [" + str(identity) + "] = {\n" + "".join(
            f"            {key} = {literal(val)},\n" for key, val in value.items()
        ) + "        },\n"
        section, count = re.subn(pattern, lambda _: replacement, section, flags=re.M | re.S)
        if count != 1:
            raise ValueError(f"Expected one detail entry for {patch}:{identity}, found {count}")
    path.write_text(text[:start] + section + text[end:], encoding="utf-8")

override_path = ROOT / "Data/Sources/AchievementLocationOverrides.json"
overrides = json.loads(override_path.read_text(encoding="utf-8"))
for identity, guide in guides.items():
    if not guide["waypoints"] and not guide["maps"]:
        continue
    overrides[str(identity)] = {
        **({"waypoints": guide["waypoints"]} if guide["waypoints"] else {"maps": guide["maps"]}),
        "references": guide["references"],
    }
# These criteria use legacy AreaTable IDs, not UiMap IDs. Stormwind's 1519
# must not leak into a map payload as if it were a UI map.
overrides["603"] = {"maps": [84, 87, 89, 103], "references": ["https://www.wowhead.com/achievement=603"]}
overrides["604"] = {"maps": [85, 88, 90, 110], "references": ["https://www.wowhead.com/achievement=604"]}
override_path.write_text(json.dumps(overrides, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

evidence = {
    "reviewedAt": "2026-10-30",
    "selection": "Prioritize useful step-by-step comments ending in Profit, from any author. Read replies and current-retail corrections before writing original instructions. Never import filler or old level guarantees.",
    "runtime": "Only compact acquisition strings and waypoints are loaded. This evidence and comment metadata are offline research files.",
    "guides": [{"id": identity, **guide} for identity, guide in guides.items()],
    "updatedContexts": {patch: sorted(entries) for patch, entries in changes.items()},
}
(ROOT / "Data/Sources/CommentAcquisitionGuides.json").write_text(json.dumps(evidence, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
print(json.dumps({"guides": len(guides), "profitCommentGuides": sum(g["matchedProfitGuide"] for g in guides.values()),
                  "updatedContexts": {p: len(v) for p, v in changes.items()}}))
