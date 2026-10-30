local _, TDP = ...

-- Content modules register here; consumers keep using TDP.PatchCatalog.
local Catalog = {
    patches = {},
    mountDetails = {},
    petDetails = {},
    toyDetails = {},
    cosmeticDetails = {},
    achievementDetails = {},
    achievementCategories = {},
    collectionAvailability = { mounts = {}, pets = {}, toys = {}, cosmetics = {} },
    collectionAvailabilityReviewedAt = "2026-10-13",
}
local Registry = {}
local detailFields = {
    mounts = "mountDetails", pets = "petDetails", toys = "toyDetails",
    cosmetics = "cosmeticDetails", achievements = "achievementDetails",
}
local registeredCollections = {}
local guideIDFields = { mounts = "spellId", pets = "speciesId", toys = "itemId" }

function Registry:RegisterPatch(patchKey, metadata)
    assert(type(patchKey) == "string" and patchKey ~= "", "Patch key is required")
    assert(not Catalog.patches[patchKey], "Duplicate patch: " .. patchKey)
    assert(type(metadata) == "table" and metadata.label, "Patch metadata needs a label")
    metadata.mounts = {}
    metadata.pets = {}
    metadata.toys = {}
    metadata.cosmetics = {}
    metadata.achievements = { ids = {}, rewardHighlights = {} }
    Catalog.patches[patchKey] = metadata
    registeredCollections[patchKey] = {}
end

function Registry:RegisterCollection(patchKey, collectionType, data)
    local patch = assert(Catalog.patches[patchKey], "Register patch metadata before collections: " .. tostring(patchKey))
    local field = assert(detailFields[collectionType], "Unknown collection type: " .. tostring(collectionType))
    assert(not registeredCollections[patchKey][collectionType], "Duplicate collection: " .. patchKey .. "/" .. collectionType)
    assert(type(data) == "table" and type(data.entries) == "table", "Collection entries are required")
    registeredCollections[patchKey][collectionType] = true
    patch[collectionType] = data.entries
    Catalog[field][patchKey] = data.details
    local guides = TDP.CollectionAcquisitionGuides and TDP.CollectionAcquisitionGuides[collectionType]
    if guides and data.details then
        for _, entry in ipairs(data.entries) do
            local guide = guides[entry[guideIDFields[collectionType]]]
            local original = data.details[entry.name]
            if guide and original then
                -- Patch files share detail tables. Give each guide its own view
                -- once at load time so changing one reward cannot affect peers.
                local details = {}
                for key, value in pairs(original) do details[key] = value end
                details.acquisition = guide
                data.details[entry.name] = details
            end
        end
    end
    if collectionType == "achievements" then
        Catalog.achievementCategories[patchKey] = data.categories
    end
end

function Registry:RegisterAvailability(patchKey, records)
    assert(Catalog.patches[patchKey], "Register patch metadata before availability: " .. tostring(patchKey))
    for collectionType, entries in pairs(records) do
        local target = assert(Catalog.collectionAvailability[collectionType], "Unknown availability collection type")
        for id, record in pairs(entries) do
            assert(not target[id], "Duplicate collection availability ID: " .. tostring(id))
            target[id] = record
        end
    end
end

TDP.PatchCatalog = Catalog
TDP.CatalogRegistry = Registry
