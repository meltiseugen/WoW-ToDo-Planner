local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
TDP.PatchCatalog = { GetCollectionSourceAchievementId = function() end }
assert(loadfile(root .. "/Core/Constants.lua"))("TODO-Planner", TDP)
local function manifest(path)
    assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path)
end
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Collections/Shared.xml")
manifest("UI/Collections/Explorer/Explorer.xml")
manifest("UI/Collections/Favorites/Favorites.xml")

Enum = { ItemTryOnReason = { Success = 0, NotEquippable = 1 } }
local inventoryReads = 0
GetInventoryItemLink = function(unit, slot)
    assert(unit == "player")
    inventoryReads = inventoryReads + 1
    if slot == 16 then return "item:900" end
    if slot == 17 then return "item:901" end
end
local originalCreateFrame = CreateFrame
local createdModels = 0
CreateFrame = function(kind, ...)
    local frame = originalCreateFrame(kind, ...)
    if kind == "DressUpModel" then
        createdModels = createdModels + 1
        -- Geometry can still stream after SetUnit succeeds. TryOn queues its assets.
        frame.ready = false
        frame.worn = {}
        function frame:SetUnit(unit, blend)
            self.unit, self.blend = unit, blend
            self.setUnitCount = (self.setUnitCount or 0) + 1
            if self.rejectUnit then return false end
            self.worn = { [16] = "equipped weapon", [17] = "equipped off-hand" }
            return true
        end
        function frame:SetAutoDress(value) self.autoDress = value end
        function frame:SetKeepModelOnHide(value) self.keepModelOnHide = value end
        function frame:IsGeoReady() return self.ready end
        function frame:Dress()
            error("Automatic equipped-outfit dressing must not race cosmetic try-on")
        end
        function frame:Undress()
            self.undressCount = (self.undressCount or 0) + 1
            self.worn = {}
        end
        function frame:UndressSlot(slot)
            self.hiddenSlots[slot] = true
            self.worn[slot] = nil
        end
        function frame:TryOn(link)
            self.tryOnCount = (self.tryOnCount or 0) + 1
            self.lastLink = link
            if self.fail then error("Unavailable item") end
            if self.rejected then return Enum.ItemTryOnReason.NotEquippable end
            if link == "item:100" then self.worn[1] = "cosmetic head"
            elseif link == "item:200" then self.worn[5] = "cosmetic chest"
            elseif link == "item:300" then self.worn[1], self.worn[5] = "set head", "set chest"
            elseif link == "item:400" then self.worn[16] = "selected cosmetic weapon"
            elseif link == "item:401" then self.worn[17] = "selected cosmetic off-hand"
            elseif link == "item:900" then self.worn[16] = "equipped weapon"
            elseif link == "item:901" then self.worn[17] = "equipped off-hand" end
            return Enum.ItemTryOnReason.Success
        end
    end
    return frame
end

for _, class in ipairs({ TDP.CollectionExplorerWindow, TDP.FavoritesWindow }) do
    TODOPlannerDB = { settings = { collectionPreviewHideArmour = false } }
    local owner = class:New({})
    function owner:GetRowKey(row) return row and (row.collectionType .. ":" .. row.entry.itemId) end
    if class == TDP.CollectionExplorerWindow then
        owner.previewPanel = CreateFrame("Frame")
        owner:BuildExplorerInspector(owner.previewPanel)
    else
        owner:BuildPreviewPanel(CreateFrame("Frame"))
    end
    owner:BindPreviewModelControls()
    owner.previewWowheadButton = CreateFrame("Button")
    owner.previewFavoriteButton = CreateFrame("Button")
    owner.previewRemoveButton = CreateFrame("Button")
    owner.previewMapButton = CreateFrame("Button")
    function owner:GetTypeLabel(collectionType) return collectionType end
    function owner:GetRowNotes() return "Cosmetic notes" end
    function owner:GetRowWowheadUrl() return "https://www.wowhead.com/item=100" end
    function owner:IsFavoriteRow() return false end
    function owner:IsCollectionMapRow() return false end
    local before = createdModels
    local function selectRow(itemID, subtype, collectionType)
        owner.selectedRow = { collectionType = collectionType or "cosmetics", entry = { itemId = itemID, subtype = subtype } }
        owner:RenderPreview()
    end

    selectRow(10, nil, "toys")
    assert(createdModels == before, "Browsing other collections must not create a character model")
    selectRow(100)
    local model = owner.cosmeticPreviewModel
    assert(model and model.unit == "player" and model == owner.previewModel and model:IsShown(), "Cosmetics must use the player's character try-on model")
    assert(not owner.previewIcon:IsShown() and not owner.creaturePreviewModel:IsShown(), "Only the character is visible")
    assert(model.worn[1] == "cosmetic head" and not model.worn[5], "Try-on hides equipped armour even with a legacy saved false preference")
    assert(not model.worn[16] and not model.worn[17], "Initial cosmetic preview must hide equipped weapons and off-hands")
    assert(owner.modelArmourButton == nil, "Cosmetic previews must not create an armour toggle")
    assert(model:GetScript("OnMouseDown") and model:GetScript("OnMouseWheel"), "Character retains drag and zoom controls")

    owner.previewModelPanX, owner.previewModelFacing = 20, 1.1
    owner:RenderPreview()
    assert(model.worn[1] == "cosmetic head" and not model.worn[5], "Hide armour must retain the selected cosmetic")
    assert(not model.worn[16] and not model.worn[17], "Refreshing an armour cosmetic must not restore equipped weapons")
    assert(owner.previewModelPanX == 20 and owner.previewModelFacing == 1.1, "Refreshing the same cosmetic preserves the camera")
    assert(model.setUnitCount == 1 and model.undressCount == 1, "Ordinary refreshes must not reload or undress the character")
    assert(model.autoDress == false and model.keepModelOnHide == true and model.blend == false, "Disable automatic outfit resets and preserve the model when hidden")
    local tryOnCount = model.tryOnCount
    for _ = 1, 12 do selectRow(100) end
    assert(model.setUnitCount == 1 and model.tryOnCount == tryOnCount, "Repeated collection refreshes must leave the current appearance intact")

    selectRow(400)
    assert(model.worn[16] == "selected cosmetic weapon" and not model.worn[17], "Only a selected weapon cosmetic is shown")
    selectRow(401)
    assert(not model.worn[16] and model.worn[17] == "selected cosmetic off-hand", "Selecting an off-hand clears the previous weapon")

    selectRow(200)
    assert(not model.worn[1] and model.worn[5] == "cosmetic chest", "New selection must remove the previous try-on")
    assert(not model.worn[16] and not model.worn[17], "Returning to armour clears the selected weapon and off-hand")
    assert(owner.previewModelPanX == 0 and owner.previewModelFacing == 0.45, "New selection resets the camera")
    selectRow(300, "ensemble")
    assert(model.lastLink == "item:300" and model.worn[1] == "set head" and model.worn[5] == "set chest", "Set tokens use native try-on")
    selectRow(500, "effect")
    assert(owner.previewModelMessage:IsShown(), "Non-equipment effects must explain why they cannot be tried on")

    model.ready = false
    selectRow(100)
    assert(model.worn[1] == "cosmetic head", "Try-on must queue while geometry is still loading")
    selectRow(200)
    local undressCount = model.undressCount
    model.ready = true
    model:GetScript("OnModelLoaded")()
    assert(model.lastLink == "item:200" and not model.worn[1], "Delayed character load uses the latest selection and keeps armour hidden")
    model:GetScript("OnModelLoaded")()
    assert(model.undressCount == undressCount, "Model-loaded callbacks must not strip or reapply the outfit")
    local unitCount = model.setUnitCount
    model:GetScript("OnEvent")(model, "UNIT_MODEL_CHANGED", "party1")
    assert(model.setUnitCount == unitCount, "Other unit changes must not reload the player preview")
    model:GetScript("OnEvent")(model, "UNIT_MODEL_CHANGED", "player")
    assert(model.setUnitCount == unitCount + 1 and model.worn[5] == "cosmetic chest", "A real player model change refreshes the character and selected outfit once")
    assert(not model.worn[16] and not model.worn[17], "Reloading the player model must not restore equipped weapons")

    model.rejected = true
    selectRow(100)
    assert(model:IsShown() and owner.previewModelMessage:IsShown(), "A rejected try-on must explain the missing appearance")
    model.rejected, model.fail = false, true
    selectRow(200)
    assert(owner.previewModelMessage:IsShown(), "API errors stay contained in the preview")
    model.fail = false
    selectRow(100)
    assert(not owner.previewModelMessage:IsShown(), "A supported cosmetic clears the unavailable message")

    owner.selectedRow = { collectionType = "mounts", entry = { itemId = 400 }, state = { modelId = 123 } }
    owner:RenderPreviewVisual(owner.selectedRow)
    assert(owner.previewModel == owner.creaturePreviewModel and owner.previewModel:IsShown())
    assert(not model:IsShown() and owner.modelArmourButton == nil, "Mounts retain their own viewer without armour controls")
    model:GetScript("OnModelLoaded")()
    assert(model.lastLink == "item:100", "Late character callbacks cannot replace a mount preview")
    selectRow(500, nil, "toys")
    assert(owner.previewIcon:IsShown() and not owner.previewModelControls:IsShown(), "Other collection types retain icon previews")
    owner.selectedRow = nil
    owner:RenderPreviewVisual(nil)
    assert(not owner.previewModel:IsShown() and owner.modelArmourButton == nil, "Clearing selection hides the model without an armour toggle")
    assert(createdModels == before + 1, "Reuse one character model per window")
end

-- Newly created windows hide armour without needing a saved preference.
TODOPlannerDB = { settings = {} }
local openWindows = { TDP.CollectionExplorerWindow:New({}), TDP.FavoritesWindow:New({}) }
for _, window in ipairs(openWindows) do
    function window:GetRowKey(row) return row.entry.itemId end
    window.frame = CreateFrame("Frame")
    window:BuildPreviewPanel(window.frame)
    window:BindPreviewModelControls()
    window.selectedRow = { collectionType = "cosmetics", entry = { itemId = 100 } }
    -- Only visual refresh is needed for this cross-window scenario.
    function window:RenderPreview() self:RenderPreviewVisual(self.selectedRow) end
    window:RenderPreview()
    assert(not window.cosmeticPreviewModel.worn[5], "New windows must hide armour by default")
    assert(not window.cosmeticPreviewModel.worn[16] and not window.cosmeticPreviewModel.worn[17], "New windows must hide equipped weapons by default")
    assert(window.modelArmourButton == nil, "New windows must not create an armour toggle")
end

local cached, requests = { [100] = false, [200] = true, [600] = false, [700] = false }, {}
C_Item = {
    IsItemDataCachedByID = function(id) return cached[id] ~= false end,
    RequestLoadItemDataByID = function(id)
        requests[id] = (requests[id] or 0) + 1
        if id == 700 then error("Item request failed") end
    end,
}
for _, window in ipairs(openWindows) do
    cached[100], requests[100] = false, 0
    local model = window.cosmeticPreviewModel
    window.cosmeticPreviewAppliedKey = nil
    window:RenderPreview()
    assert(window.previewModelMessage:GetText() == "Loading item..." and requests[100] == 1)
    local unitCount, undressCount = model.setUnitCount, model.undressCount
    for _ = 1, 12 do window:RenderPreview() end
    assert(requests[100] == 1 and model.undressCount == undressCount and window.previewModelMessage:IsShown(), "Cache refreshes must not restart pending item requests or erase their loading message")
    model:GetScript("OnEvent")(model, "ITEM_DATA_LOAD_RESULT", 999, true)
    assert(model.undressCount == undressCount, "Unrelated item loads leave the outfit intact")
    cached[100] = true
    model:GetScript("OnEvent")(model, "ITEM_DATA_LOAD_RESULT", 100, true)
    assert(model.worn[1] == "cosmetic head" and not window.previewModelMessage:IsShown(), "Selected item load must finish try-on")
    assert(model.setUnitCount == unitCount, "Item data arrival must not reload the character")

    window.selectedRow.entry.itemId = 600
    window:RenderPreview()
    window.selectedRow.entry.itemId = 200
    window:RenderPreview()
    local currentCount = model.undressCount
    model:GetScript("OnEvent")(model, "ITEM_DATA_LOAD_RESULT", 600, true)
    assert(model.worn[5] == "cosmetic chest" and model.undressCount == currentCount, "A stale item result must not replace the current selection")
    window.selectedRow.entry.itemId = 600
    window:RenderPreview()
    model:GetScript("OnEvent")(model, "ITEM_DATA_LOAD_RESULT", 600, false)
    assert(window.previewModelMessage:GetText() == "This cosmetic cannot be previewed.", "Failed item loads must leave the loading state")
    window.selectedRow.entry.itemId = 700
    window:RenderPreview()
    assert(window.cosmeticPreviewPendingItemID == nil and window.previewModelMessage:GetText() == "This cosmetic cannot be previewed.", "Request failures must not leave an endless loading message")
end

C_Item = nil
local window = TDP.FavoritesWindow:New({})
window:BuildPreviewPanel(CreateFrame("Frame"))
window.selectedRow = { collectionType = "cosmetics", entry = { itemId = 100 } }
function window:GetRowKey(row) return row.entry.itemId end
local model = window:GetCosmeticPreviewModel()
model.rejectUnit = true
window:RenderPreviewVisual(window.selectedRow)
window:RenderPreviewVisual(window.selectedRow)
assert(model.setUnitCount == 1 and not model:IsShown() and window.previewIcon:IsShown(), "A failed SetUnit must not be treated as a loaded model or retried on every refresh")
model.rejectUnit = false
model:GetScript("OnEvent")(model, "UNIT_MODEL_CHANGED", "player")
assert(model.setUnitCount == 2 and model.worn[1] == "cosmetic head", "Unit model availability retries a failed initialization")
assert(not model.worn[16] and not model.worn[17], "Retrying a failed initialization still hides equipped weapons")
assert(inventoryReads == 0, "Cosmetic previews must not copy equipped weapons from inventory")
print("Cosmetic character previews passed for Collections and Favorites")
