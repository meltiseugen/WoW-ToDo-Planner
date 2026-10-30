local root = arg and arg[1] or "."
assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = { PatchCatalog = {} }
local function manifest(path)
    assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path)
end
assert(loadfile(root .. "/Core/Constants.lua"))("TODO-Planner", TDP)
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Collections/Shared.xml")
manifest("UI/Collections/Explorer/Explorer.xml")
manifest("UI/Collections/Favorites/Favorites.xml")

local originalCreateFrame = CreateFrame
CreateFrame = function(kind, ...)
    local model = originalCreateFrame(kind, ...)
    if kind ~= "PlayerModel" then return model end
    model.loads = 0
    function model:SetKeepModelOnHide(keep) self.keep = keep end
    local hide = model.Hide
    function model:Hide()
        hide(self)
        if not self.keep then self.displayID = nil end
    end
    function model:SetDisplayInfo(id)
        if self.fail then error("Model data unavailable") end
        self.displayID = id
        self.loads = self.loads + 1
    end
    function model:SetCamDistanceScale(value) self.zoom = value end
    function model:SetFacing(value) self.facing = value end
    function model:SetViewTranslation(x, y) self.panX, self.panY = x, y end
    return model
end

for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
    TODOPlannerDB = { settings = {} }
    local owner = class:New({})
    owner:BuildPreviewPanel(CreateFrame("Frame"))
    function owner:GetRowKey(row) return row and row.key end
    local mount = { collectionType = "mounts", key = "mount:1", state = { modelId = 12345 } }
    local pet = { collectionType = "pets", key = "pet:1", state = { modelId = 67890 } }
    local model = owner.creaturePreviewModel
    local function render(row)
        owner.selectedRow = row
        owner:RenderPreviewVisual(row)
    end
    render(mount)
    assert(model.displayID == 12345 and model:IsShown() and owner.previewHasModel, "Mount uses its creature display")
    for _ = 1, 20 do render(mount) end
    assert(model.loads == 1, "Refresh must not restart the selected mount's asset load")

    owner.previewModelZoom, owner.previewModelFacing = 1.8, 0.9
    owner.previewModelPanX, owner.previewModelPanY = 8, -4
    model.zoom, model.facing, model.panX, model.panY = nil, nil, nil, nil
    local loaded = model:GetScript("OnModelLoaded")
    assert(loaded, "Creature asset completion must restore the camera")
    loaded(model)
    assert(model.zoom == 1.8 and model.facing == 0.9 and model.panX == 8 and model.panY == -4,
        "Late asset loading preserves the user's current transform")

    render({ collectionType = "toys", key = "toy:1" })
    assert(not model:IsShown() and owner.previewIcon:IsShown(), "Toy keeps its icon preview")
    render(mount)
    assert(model.displayID == 12345 and model.loads == 1, "Returning from an icon preserves native model assets")
    render(pet)
    assert(model.displayID == 67890 and model.loads == 2, "New creature loads its own display")
    assert(model.zoom == 1.25 and model.panX == 0 and model.panY == 0, "New selection resets the camera")

    -- A late event from the creature must not affect a different active viewer.
    owner.previewModel = CreateFrame("DressUpModel")
    model.zoom = nil
    loaded(model)
    assert(model.zoom == nil, "Inactive model completion cannot alter the active viewer")
    owner.previewModel = model

    model.fail = true
    render(mount)
    assert(not model:IsShown() and owner.previewIcon:IsShown() and not owner.previewHasModel,
        "A rejected creature load falls back to the icon")
    model.fail = false
    render(mount)
    assert(model.displayID == 12345 and model.loads == 3 and owner.previewHasModel, "Failed loads can recover")
    render({ collectionType = "mounts", key = "invalid", state = { modelId = 0 } })
    assert(not model:IsShown() and owner.previewIcon:IsShown(), "Invalid display IDs do not produce blank viewers")
    render(nil)
    assert(not model:IsShown() and not owner.previewHasModel, "Clearing selection hides the viewer")
end
print("Creature preview lifecycle passed for Collections and Favorites")
