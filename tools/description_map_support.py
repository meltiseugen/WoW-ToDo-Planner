"""Offline character contexts and actual Collections/Favorites map actions."""
from itertools import product

from lupa.lua51 import lua_type

from catalog_support import ROOT, load_file, manifest_scripts


def load_context(lua):
    namespace = lua.table()
    for path in manifest_scripts(ROOT / "Data/Catalog.xml"):
        load_file(lua, namespace, path)
    namespace.CollectionPreview = lua.table()
    namespace.Widgets = lua.table()
    namespace.CollectionExplorerWindow = lua.table_from({"Config": lua.table()})
    namespace.FavoritesWindow = lua.table_from({"Config": lua.table()})
    load_file(lua, namespace, ROOT / "UI/Collections/PreviewPanel.lua")
    load_file(lua, namespace, ROOT / "UI/Collections/Explorer/Actions.lua")
    load_file(lua, namespace, ROOT / "UI/Collections/Favorites/Actions.lua")
    view = lua.eval("""function(methods, preview)
        return setmetatable({}, { __index = function(_, key) return methods[key] or preview[key] end })
    end""")
    return namespace, view(namespace.CollectionExplorerWindow, namespace.CollectionPreview), view(namespace.FavoritesWindow, namespace.CollectionPreview)


class CharacterContexts:
    def __init__(self, lua, namespace):
        self.catalog = namespace.PatchCatalog
        self.quests = namespace.CollectionSourceIndex.quests
        self.cache = {}
        self.apply = lua.eval("""function(catalog, faction, classID, raceID)
            UnitFactionGroup = faction and function() return faction end or nil
            UnitClass = classID and function() return "Audit", "AUDIT", classID end or nil
            UnitRace = raceID and function() return "Audit", "Audit", raceID end or nil
            catalog:ResetCollectionSourceCache()
        end""")

    def set(self, profile=None):
        self.apply(self.catalog, *(profile or (None, None, None)))

    def profiles(self, kind, patch, entry):
        restrictions, visited = set(), set()

        def record(value):
            if lua_type(value) != "table": return
            faction = value["faction"]
            classes = tuple(sorted(v for _, v in (value["classes"] or {}).items()))
            races = tuple(sorted(v for _, v in (value["races"] or {}).items()))
            if faction or classes or races: restrictions.add((faction or "", classes, races))
            for _, variant in (value["variants"] or {}).items(): record(variant)
            for key in ("questID", "progressQuestID", "unlockQuestID"):
                identity = value[key]
                if identity and identity not in visited:
                    visited.add(identity)
                    record(self.quests[identity])
            for key in ("sourceQuests", "altQuests"):
                for _, identity in (value[key] or {}).items():
                    if identity not in visited:
                        visited.add(identity)
                        record(self.quests[identity])

        for _, value in self.catalog.GetCollectionSourceRecords(self.catalog, kind, patch, entry).items(): record(value)
        key = tuple(sorted(restrictions))
        if key not in self.cache:
            classes = range(1, 14) if any(c for _, c, _ in key) else (1,)
            races = {1, 2} | {race for _, _, values in key for race in values}
            # Each representative exercises a distinct combination of eligible
            # source/quest branches. Both factions are always checked, including
            # classes and races which cannot acquire the item themselves.
            signatures, profiles = set(), []
            for faction, class_id, race_id in product(("Alliance", "Horde"), classes, sorted(races)):
                signature = (faction, tuple((not f or f == faction) and (not c or class_id in c)
                                            and (not r or race_id in r) for f, c, r in key))
                if signature in signatures: continue
                signatures.add(signature)
                profiles.append((faction, class_id, race_id))
            self.cache[key] = profiles
        return self.cache[key]
