local _, TDP = ...

local PatchCatalog = TDP.PatchCatalog
local CollectionScanner = TDP.CollectionScanner
local Tasks = TDP.Tasks

local SUPPORTED_COLLECTION_TYPES = {
    mounts = true,
    pets = true,
    toys = true,
}

local CollectionTaskProgress = {}
CollectionTaskProgress.__index = CollectionTaskProgress

function CollectionTaskProgress:New(addon)
    return setmetatable({
        addon = addon,
    }, self)
end

function CollectionTaskProgress:GetTaskCollection(task)
    if not task or task.sourceType ~= "patchCollection" then
        return nil
    end

    local patchKey, collectionType, entryId = tostring(task.sourceId or ""):match("^([^:]+):([^:]+):(.+)$")
    if not patchKey or not SUPPORTED_COLLECTION_TYPES[collectionType] then
        return nil
    end

    return patchKey, collectionType, entryId
end

function CollectionTaskProgress:FindCollectionEntry(patchKey, collectionType, entryId)
    if not PatchCatalog or not CollectionScanner then
        return nil
    end

    for _, entry in ipairs(PatchCatalog:GetEntries(patchKey, collectionType)) do
        if tostring(CollectionScanner:GetEntryKey(collectionType, entry) or "") == tostring(entryId or "") then
            return entry
        end
    end

    return nil
end

function CollectionTaskProgress:IsCollectionTaskComplete(task)
    local patchKey, collectionType, entryId = self:GetTaskCollection(task)
    if not patchKey then
        return false
    end

    local entry = self:FindCollectionEntry(patchKey, collectionType, entryId)
    if not entry then
        return false
    end

    local state = CollectionScanner:GetState(collectionType, entry)
    return state and state.collected == true
end

function CollectionTaskProgress:MarkTaskDone(task)
    local changed = false
    if Tasks:GetStatus(task) ~= "DONE" then
        Tasks:SetStatus(task, "DONE")
        changed = true
    end

    if Tasks:IsGlobalTask(task) and type(task.statusByBoard) == "table" then
        local boardKeys = {}
        for boardKey in pairs(task.statusByBoard) do
            boardKeys[#boardKeys + 1] = boardKey
        end

        for _, boardKey in ipairs(boardKeys) do
            if Tasks:GetStatus(task, boardKey) ~= "DONE" then
                Tasks:SetStatus(task, "DONE", boardKey)
                changed = true
            end
        end
    end

    return changed
end

function CollectionTaskProgress:AutoCompleteTask(task)
    if not task then
        return false
    end

    if task.sourceType == "achievement" and self.addon.Achievements then
        return self.addon.Achievements:AutoCompleteTask(task)
    end

    if Tasks:IsArchived(task) or not self:IsCollectionTaskComplete(task) then
        return false
    end

    return self:MarkTaskDone(task)
end

function CollectionTaskProgress:AutoCompleteTasks()
    if type(TODOPlannerDB) ~= "table" or type(TODOPlannerDB.tasks) ~= "table" then
        return false
    end

    local changed = false
    for _, task in ipairs(TODOPlannerDB.tasks) do
        if self:AutoCompleteTask(task) then
            changed = true
        end
    end

    if changed then
        Tasks:SortStable(TODOPlannerDB.tasks)
    end

    return changed
end

TDP.CollectionTaskProgress = CollectionTaskProgress:New(TDP)
