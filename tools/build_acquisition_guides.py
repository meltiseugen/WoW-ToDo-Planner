# /// script
# requires-python = ">=3.11"
# dependencies = ["lupa>=2.8,<3"]
# ///
"""Compile reviewed acquisition evidence into static, ID-keyed guide strings.

No external trees, tooltip HTML, research receipts or generator logic run in WoW.
Run research_acquisition_guides.py --download first, then this script offline.
"""
from collections import Counter
from html import unescape
import json
import re

from lupa.lua51 import LuaRuntime

from catalog_support import ROOT, load_catalog, load_file
from import_collection_sources import REVISION, REPOSITORY, unpack
from research_acquisition_guides import CACHE, TARGETS

PROFESSIONS = {164: "Blacksmithing", 165: "Leatherworking", 171: "Alchemy", 182: "Herbalism", 185: "Cooking", 186: "Mining", 197: "Tailoring", 202: "Engineering", 333: "Enchanting", 356: "Fishing", 755: "Jewelcrafting", 773: "Inscription", 794: "Archaeology"}
FACTIONS = {2503: "Maruuk Centaur", 2507: "Dragonscale Expedition", 2510: "Valdrakken Accord", 2564: "Loamm Niffen", 2568: "Glimerogg Racer", 2570: "Hallowfall Arathi", 2574: "Dream Wardens", 2590: "Council of Dornogal", 2593: "Keg Leg's Crew", 2594: "Assembly of the Deeps", 2600: "Severed Threads", 2601: "The Weaver", 2605: "The General", 2607: "The Vizier", 2653: "The Cartels of Undermine", 2658: "The K'aresh Trust", 2669: "Darkfuse Solutions", 2671: "Venture Company", 2673: "Bilgewater Cartel", 2675: "Blackwater Cartel", 2677: "Steamwheedle Cartel", 2685: "Gallagio Loyalty Rewards Club", 2688: "Flame's Radiance", 2736: "Manaforge Vandals", 2766: "Silvermoon Court", 2767: "The Singularity"}
DIFFICULTIES = {1: "Normal", 2: "Heroic", 3: "10-player", 4: "25-player", 14: "Normal", 15: "Heroic", 16: "Mythic", 17: "Raid Finder", 23: "Mythic"}


def cached(kind, identity):
    file = CACHE / "tooltips" / f"{kind}-{identity}.json"
    return json.loads(file.read_text(encoding="utf-8")) if file.exists() else {}


def name(kind, identity):
    if kind == "currency" and identity == 3252: return "Bronze"
    return cached(kind, identity).get("name")


def clean(text):
    text = re.sub(r"\|H[^|]+\|h(.*?)\|h", r"\1", str(text or ""))
    text = re.sub(r"\|c[0-9a-fA-F]{8}|\|r|\|T[^|]*\|t", "", text)
    text = re.sub(r"<(?:br|/tr|/table)\b[^>]*>", "\n", text, flags=re.I)
    text = re.sub(r"<[^>]+>", "", text)
    text = unescape(text).replace("(Plot coords in Debug)", "")
    text = re.sub(r"<[^>]+>", "", text)
    text = re.sub(r"-\s*\[DNT\].*?(?= - |$)", "", text, flags=re.S)
    text = re.sub(r"\*\*\*.*?Debug.*?\*\*\*", "", text)
    text = re.sub(r"See the respective header for more information\.", "", text)
    return " ".join(text.split()).strip()


def achievement_text(identity):
    data = cached("achievement", identity)
    title = data.get("name")
    text = clean(data.get("tooltip"))
    if title and text.startswith(title): text = text[len(title):].strip()
    return text.split("Reward:")[0].strip()


def main():
    lua = LuaRuntime(unpack_returned_tuples=True)
    catalog = load_catalog(lua)
    ns = lua.table()
    load_file(lua, ns, ROOT / "Data/Catalog/MapNames.lua")
    maps = dict(ns.CatalogMapNames.items())
    paths = json.loads((CACHE / "acquisition-paths.json").read_text(encoding="utf-8"))
    targets = json.loads(TARGETS.read_text(encoding="utf-8"))
    overrides = json.loads((ROOT / "Data/Sources/AcquisitionGuideOverrides.json").read_text(encoding="utf-8"))
    result, missing = [], []

    def location(nodes):
        for node in reversed(nodes):
            if node.get("coords"):
                mid, x, y = node["coords"][0]
                return f"{maps.get(mid, 'map ' + str(mid))} ({x:.1f}, {y:.1f})"
        for node in reversed(nodes):
            if node.get("mapID") and node["mapID"] != 947:
                return maps.get(node["mapID"], "")
        return ""

    def cost_text(cost):
        if isinstance(cost, (float, int)): cost = [["g", cost]]
        parts = []
        for component in cost or []:
            if component[0] == "g":
                gold = component[1] / 10000
                parts.append(f"{gold:,.0f} gold" if gold.is_integer() else f"{gold:,.2f} gold")
            elif component[0] in ("i", "c"):
                label = name("item" if component[0] == "i" else "currency", component[1])
                if label: parts.append(f"{component[2]:,} {label}")
                else: raise ValueError(f"Unnamed acquisition cost: {component}")
        return " and ".join(parts)

    for target in targets:
        kind, identity, title = target["type"], target["id"], target["name"]
        key = f"{kind}:{identity}"
        entry = next(e for _, e in catalog.GetEntries(catalog, target["patch"], kind).items() if e[{"mounts":"spellId","pets":"speciesId","toys":"itemId"}[kind]] == identity)
        info = catalog.GetCollectionSourceInfo(catalog, kind, target["patch"], entry)
        if key in overrides:
            result.append({**target, **overrides[key], "method": overrides[key].get("method", "Reviewed guide")})
            continue
        if info and info["acquisition"]:
            references = next((unpack(record["references"]) for _, record in info["records"].items() if record["references"]), ["Data/Sources/CuratedSources.json"])
            result.append({**target, "method": info["kind"], "text": info["acquisition"], "references": references})
            continue
        occurrences = paths[key]
        # Prefer an active documented path over an expired event or NYI preview.
        def rank(o):
            retired = any(n.get("rwp", 999999) <= 120105 or n.get("u") == 1 for n in o["path"])
            vendor_path = any(n.get("headerID") in (-58, -22, -480) for n in o["path"])
            return (retired, o["category"] in ("Promotions", "BlackMarket"), not vendor_path, o["category"] == "TradingPost")
        occurrences = sorted(occurrences, key=rank)
        if not occurrences:
            if info and info["acquisition"]:
                result.append({**target, "method": info["kind"], "text": info["acquisition"], "references": ["Data/Sources/CuratedSources.json"]})
            else: missing.append(key + " " + title)
            continue
        occurrence = occurrences[0]
        nodes, category = occurrence["path"], occurrence["category"]
        parents, item = nodes[:-1], nodes[-1]
        method, lines = None, []
        source = None
        vendor = any(n.get("headerID") in (-58, -22, -480) for n in parents)
        for node in reversed(parents):
            c, typed = node.get("constructor"), node.get("type")
            if c == "Achievement" or typed == "a":
                aid = node.get("achievementID") or node.get("headerID")
                aname = name("achievement", aid)
                if aname:
                    method, source = "Achievements", node
                    lines.append(f"Earn {aname}: {achievement_text(aid)}")
                    break
            if c in ("NPC", "Encounter") or typed == "n":
                nid = node.get("npcID") or node.get("headerID")
                npc = name("npc", nid)
                if not npc: continue
                source = node
                place = location(parents)
                where = f" in {place}" if place else ""
                cost = next((n["cost"] for n in reversed(nodes) if n.get("cost")), None)
                if vendor or cost and category != "Secrets" and not any(n.get("headerID") == -46 for n in parents):
                    method = "Vendor"
                    price = cost_text(cost)
                    lines.append(f"Buy {title} from {npc}{where}" + (f" for {price}." if price else "."))
                else:
                    method = "Dungeon and Raids" if category == "Instances" else "Rare Drops"
                    difficulty = next((DIFFICULTIES.get(n.get("difficultyID")) for n in reversed(nodes) if n.get("difficultyID")), None)
                    lines.append(f"Defeat {npc}" + (f" on {difficulty} difficulty" if difficulty else "") + where + f" and loot {title}. This is a chance drop.")
                break
            if c == "Quest" or typed == "q":
                qid = node.get("questID") or node.get("headerID")
                qname = name("quest", qid)
                if qname:
                    method, source = "Quest Rewards", node
                    giver = name("npc", (node.get("qgs") or [None])[0])
                    place = location(parents)
                    lines.append(f"Complete {qname}" + (f" from {giver}" if giver else "") + (f" in {place}" if place else "") + f" to receive {title}.")
                    # Quest tooltips contain the actual objective rather than only a title.
                    text = clean(cached("quest", qid).get("tooltip"))
                    if text.startswith(qname): text = text[len(qname):].strip()
                    if "Requirements:" in text: text = "Objectives: " + text.split("Requirements:", 1)[1].strip()
                    # Completion dialogue is story prose, not an acquisition step.
                    if text and not text.startswith("Level ") and len(text.split()) < 85: lines.append(text)
                    break
            if c == "Object":
                oid = node["objectID"]
                # Object names are original ATT localization data, not client lookups.
                object_names = (CACHE / "att/db_Standard_LocalizationDB.lua").read_text(encoding="utf-8-sig").split("local ObjectNames = {", 1)[1].split("} _.ObjectNames", 1)[0]
                match = re.search(r'\[' + str(oid) + r'\] = ("(?:[^"\\]|\\.)*")', object_names)
                label = lua.eval(match[1]) if match else "the treasure"
                method, source = "Treasure", node
                place = location(parents)
                lines.append(f"Loot {label}" + (f" in {place}" if place else "") + f" to obtain {title}.")
                break
            if c == "Item":
                container = name("item", node.get("itemID"))
                if container:
                    method, source = "Container reward", node
                    price = cost_text(node.get("cost"))
                    place = location(nodes)
                    lines.append(f"Open {container}" + (f" in {place}" if place else "") + f" for a chance at {title}." + (f" Obtain the container with {price}." if price else ""))
                    break
        if category in ("Craftables", "Professions") and method is None:
            method = "Professions"
            profession = next((PROFESSIONS.get(n.get("requireSkill") or n.get("professionID")) for n in reversed(nodes) if n.get("requireSkill") or n.get("professionID")), None)
            lines = [f"Craft {title}" + (f" with {profession}" if profession else " using its profession recipe") + "."]
            recipe = next((name("spell", n.get("recipeID") or n.get("spellID")) for n in reversed(parents) if n.get("recipeID") or n.get("spellID")), None)
            if recipe: lines.append(f"Learn the {recipe} recipe first.")
            if kind == "toys":
                lines = [f"Obtain the finished {title} from a player who crafts it with {profession or 'the matching profession'}. Search the Auction House for the exact toy name, buy it and use the item to add it to the Toy Box. You can also request a craft from a player who knows this recipe; learning the toy does not require taking the crafting profession yourself."]
        if method is None and kind == "pets" and info and info["kind"] == "Pet Battles":
            method = "Pet Battles"
            lines = [f"Find a wild {title} in {location(nodes)}, start a pet battle, reduce its health below 35%, and use your trap. Win the battle to keep the captured pet."]
        if method is None and vendor and info and info["kind"] == "Vendor" and info["npcID"]:
            seller = name("npc", info["npcID"])
            price = cost_text(item.get("cost"))
            if seller:
                method = "Vendor"
                place = info["location"] or info["mapName"]
                lines = [f"Buy {title} from {seller}" + (f" in {place}" if place else "") + (f" for {price}." if price else ".")]
        if method is None and category == "TradingPost":
            method = "Trading Post"
            price = cost_text(item.get("cost"))
            lines = [f"Buy {title}" + (f" for {price}" if price else "") + " from the Trading Post in Stormwind or Orgrimmar when it appears in the monthly inventory. Earn Trader's Tender through the Traveler's Log and claim it from the Collector's Cache."]
        if method is None and category == "Character":
            method, lines = "Character unlock", [clean(item.get("description"))]
        if any(n.get("headerID") == -476 for n in nodes):
            method = "Historical Reward"
            offer = next((o["path"][-1] for o in occurrences if o["path"][-1].get("cost")), item)
            price = cost_text(offer.get("cost"))
            ranks = [n["minReputation"][1] for o in occurrences for n in o["path"] if isinstance(n.get("minReputation"), list) and n["minReputation"][0] == 2593]
            lines = [f"Original Plunderstorm acquisition: play the Plunderstorm event from the character-selection screen, collect Plunder through matches and its daily quest, then buy {title}" + (f" for {price}" if price else "") + " in the Plunderstore."]
            if ranks: lines.append(f"The first event also awarded it at Renown {max(ranks)} with Keg Leg's Crew.")
            lines.append("This recorded event has ended. The item is an event reward, with no ordinary world drop or permanent gold vendor; another opportunity depends on its inclusion in a returning Plunderstorm event.")
        descriptions = [clean(n["description"]) for n in nodes if n.get("description")]
        # Preserve encounter, puzzle, event and container mechanics from the evidence.
        for text in descriptions:
            if text and text not in " ".join(lines): lines.append(text)
        if method == "Pet Battles" and any("backline" in text.lower() or "secondary" in text.lower() for text in descriptions):
            lines[0] = f"Start wild pet battles in {location(nodes)} and look for {title} in the opposing team's secondary slots. Reduce its health below 35%, trap it, and win the battle."
        reputations = list(dict.fromkeys(tuple(n["minReputation"]) for n in nodes if isinstance(n.get("minReputation"), list)))
        for faction, amount in reputations:
            label = FACTIONS.get(faction)
            if not label: continue
            if amount >= 9000:
                standing = {9000:"Honored", 21000:"Revered", 42000:"Exalted"}.get(amount, str(amount) + " reputation")
                lines.append(f"Requires {standing} with {label}.")
            elif faction == 2568: lines.append(f"Reach rank {amount} with {label} by completing daily snail training quests for Briggul in Glimmerogg.")
            else: lines.append(f"Requires Renown {amount} with {label}.")
        if any(n.get("headerID") == -104 for n in nodes): lines.append("Legion Remix reward: this acquisition required a Timerunner during the event, which has ended.")
        if any(n.get("headerID") == -105 for n in nodes): lines.append("Mists of Pandaria Remix reward: this acquisition required a Timerunner during the event, which has ended.")
        availability = catalog.GetCollectionAvailability(catalog, kind, target["patch"], entry)
        if availability and availability["reason"]: lines.append(availability["reason"])
        if method is None or not any(lines):
            missing.append(key + " " + title + " [" + category + "]")
            continue
        refs = [f"{REPOSITORY}/blob/{REVISION}/db/Standard/Categories/{category}.lua"]
        if item.get("itemID"): refs.append(f"https://www.wowhead.com/item={item['itemID']}")
        result.append({**target, "method": method, "text": "\n\n".join(dict.fromkeys(line for line in lines if line)), "references": refs})
    (ROOT / "Data/Sources/AcquisitionGuides.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"guides": len(result), "methods": dict(Counter(r["method"] for r in result)), "missing": missing}, ensure_ascii=False), flush=True)
    if missing: return
    lines = ["-- Generated by tools/build_acquisition_guides.py. Research stays outside the runtime.", "-- ATT-derived data: MIT; see Data/Sources/ATT-LICENSE.txt.", "local _, TDP = ...", "TDP.CollectionAcquisitionGuides = {"]
    for kind in ("mounts", "pets", "toys"):
        lines.append(f"    {kind} = {{")
        for row in sorted((r for r in result if r["type"] == kind), key=lambda r:r["id"]):
            lines.append(f"        [{row['id']}] = {json.dumps(row['text'], ensure_ascii=False)},")
        lines.append("    },")
    lines += ["}", ""]
    (ROOT / "Data/Sources/CollectionAcquisitionGuides.lua").write_text("\n".join(lines), encoding="utf-8")


if __name__ == "__main__": main()
