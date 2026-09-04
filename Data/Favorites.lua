local _, TDP = ...

local PatchCatalog = TDP.PatchCatalog

local Favorites = {}
Favorites.__index = Favorites

function Favorites:New()
    return setmetatable({}, self)
end

function Favorites:EnsureStore()
    if type(TODOPlannerDB) ~= "table" then
        return nil
    end
    if type(TODOPlannerDB.favorites) ~= "table" then
        TODOPlannerDB.favorites = {}
    end
    return TODOPlannerDB.favorites
end

function Favorites:GetEntryId(collectionType, entry)
    if collectionType == "mounts" then
        return entry and (entry.spellId or entry.itemId)
    elseif collectionType == "pets" then
        return entry and entry.speciesId
    elseif collectionType == "toys" then
        return entry and entry.itemId
    elseif collectionType == "achievements" then
        return type(entry) == "table" and entry.achievementId or entry
    end

    return nil
end

function Favorites:GetKey(patchKey, collectionType, entryOrId)
    local entryId = type(entryOrId) == "table" and self:GetEntryId(collectionType, entryOrId) or entryOrId
    if not patchKey or not collectionType or not entryId then
        return nil
    end
    return string.format("%s:%s:%s", tostring(patchKey), tostring(collectionType), tostring(entryId))
end

function Favorites:IsFavorite(patchKey, collectionType, entryOrId)
    local store = self:EnsureStore()
    local key = self:GetKey(patchKey, collectionType, entryOrId)
    return store and key and store[key] ~= nil
end

function Favorites:Add(patchKey, collectionType, entryOrId)
    local store = self:EnsureStore()
    local entryId = type(entryOrId) == "table" and self:GetEntryId(collectionType, entryOrId) or entryOrId
    local key = self:GetKey(patchKey, collectionType, entryId)
    if not store or not key then
        return false
    end

    store[key] = store[key] or {
        key = key,
        patchKey = patchKey,
        collectionType = collectionType,
        entryId = entryId,
        addedAt = time(),
    }
    return true
end

function Favorites:Remove(patchKey, collectionType, entryOrId)
    local store = self:EnsureStore()
    local key = self:GetKey(patchKey, collectionType, entryOrId)
    if not store or not key or not store[key] then
        return false
    end

    store[key] = nil
    return true
end

function Favorites:Toggle(patchKey, collectionType, entryOrId)
    if self:IsFavorite(patchKey, collectionType, entryOrId) then
        return self:Remove(patchKey, collectionType, entryOrId), false
    end

    return self:Add(patchKey, collectionType, entryOrId), true
end

function Favorites:GetAll()
    local store = self:EnsureStore()
    local list = {}
    if not store then
        return list
    end

    for _, favorite in pairs(store) do
        list[#list + 1] = favorite
    end

    table.sort(list, function(a, b)
        return (a.addedAt or 0) > (b.addedAt or 0)
    end)

    return list
end

function Favorites:FindCatalogEntry(favorite)
    if not PatchCatalog or type(favorite) ~= "table" then
        return nil
    end

    local entryId = tostring(favorite.entryId or "")
    for _, entry in ipairs(PatchCatalog:GetEntries(favorite.patchKey, favorite.collectionType)) do
        if tostring(self:GetEntryId(favorite.collectionType, entry) or "") == entryId then
            return entry
        end
    end

    return nil
end

TDP.Favorites = Favorites:New()
