local TDP = { Constants = {} }
assert(loadfile("Tests/load_manifest.lua"))(".", TDP, "UI/Widgets/Widgets.xml")
assert(loadfile("Tests/load_manifest.lua"))(".", TDP, "UI/Collections/Shared.xml", "UI/Collections/Explorer/Explorer.xml")
assert(loadfile("Tests/load_manifest.lua"))(".", TDP, "UI/Collections/Favorites/Favorites.xml")

local cursorX, cursorY, heldButton = 100, 100, nil
GetCursorPosition = function() return cursorX, cursorY end
IsMouseButtonDown = function(button) return button == heldButton end

for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
    local model = { scripts = {} }
    function model:SetScript(event, handler) self.scripts[event] = handler end
    function model:GetEffectiveScale() return 0.5 end
    function model:SetCamDistanceScale(value) self.zoom = value end
    function model:SetFacing(value) self.facing = value end
    function model:SetViewTranslation(x, y) self.panX, self.panY = x, y end
    local owner = class:New({})
    owner.previewModel = model
    owner:ResetPreviewModelTransform("mount:1")
    TDP.Widgets:ConfigurePreviewModelDragging(model, owner)

    heldButton = "RightButton"
    model.scripts.OnMouseDown(model, heldButton)
    cursorX, cursorY = cursorX + 20, cursorY + 15
    model.scripts.OnUpdate(model)
    assert(model.panX == 40 and model.panY == 30, "Right drag must pan in UI units")
    assert(model.facing == 0.45, "Panning must preserve rotation")
    owner:AdjustPreviewModelZoom(-0.15)
    assert(model.panX == 40 and model.panY == 30, "Zoom must preserve panning")
    model.scripts.OnMouseUp(model, "LeftButton")
    assert(owner.previewModelDragButton == "RightButton", "Unrelated release must preserve drag")
    heldButton = nil
    model.scripts.OnUpdate(model)
    assert(owner.previewModelDragButton == nil, "Release outside viewer must stop drag")

    heldButton = "LeftButton"
    model.scripts.OnMouseDown(model, heldButton)
    cursorX, cursorY = cursorX + 10, cursorY - 10
    model.scripts.OnUpdate(model)
    assert(math.abs(model.facing - 0.65) < 0.00001, "Left drag must rotate")
    assert(model.panX == 40 and model.panY == 30, "Rotation must preserve panning")
    model.scripts.OnHide(model)
    assert(owner.previewModelDragButton == nil, "Hiding must stop drag")

    owner:ResetPreviewModelTransform("pet:2")
    assert(model.panX == 0 and model.panY == 0, "Reset or new selection must recenter")
    assert(model.zoom == 1.25 and model.facing == 0.45, "Reset must restore defaults")
    owner:AdjustPreviewModelZoom(-100)
    assert(model.zoom == 0.65, "Zoom-in limit")
    owner:AdjustPreviewModelZoom(100)
    assert(model.zoom == 3.25, "Zoom-out limit")

    owner:ResetPreviewModelTransform(nil)
    if class == TDP.CollectionExplorerWindow then
        assert(owner.previewModelRowKey == "pet:2", "Explorer reset without a key preserves its selection key")
    else
        assert(owner.previewModelRowKey == nil, "Favorites reset without a key clears its selection key")
    end
end
print("Preview model interaction tests passed for Collections and Favorites")
