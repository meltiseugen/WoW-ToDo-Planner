local root = arg and arg[1] or "."
local mock = assert(loadfile(root .. "/Tests/support/ui_mock.lua"))()
local TDP = {}
local function loadAddon(path) assert(loadfile(root .. "/" .. path))("TODO-Planner", TDP) end
local function manifest(path) assert(loadfile(root .. "/Tests/load_manifest.lua"))(root, TDP, path) end
loadAddon("Libs/JanisTheme-1.0/JanisTheme-1.0.lua")
loadAddon("Core/Constants.lua")
loadAddon("Core/Utils.lua")
loadAddon("Core/Theme.lua")
loadAddon("Data/Persistence/BoardManager.lua")
loadAddon("Data/Persistence/TaskRepository.lua")
loadAddon("Data/Persistence/Database.lua")
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
loadAddon("Data/Persistence/Favorites.lua")
loadAddon("Integrations/CollectionScanner.lua")
manifest("UI/Widgets/Widgets.xml")
manifest("UI/Windows.xml")
TDP.Database:Init()
TDP.Theme = TDP.ThemeManager:Create()
local widgets, catalog = TDP.Widgets, TDP.PatchCatalog
local passed = 0
local function test(name, callback)
    C_CurrencyInfo, C_Item, GetItemInfo, GetItemCount = nil, nil, nil, nil
    HandleModifiedItemClick, SetItemRef, ItemRefTooltip, GameTooltip = nil, nil, nil, nil
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function contains(text, part) assert(text:find(part, 1, true), "Missing " .. part .. " in " .. text) end
local function tooltip()
    return {
        lines = {}, shown = false,
        SetOwner = function(self, owner) self.owner = owner end,
        GetOwner = function(self) return self.owner end,
        SetHyperlink = function(self, link) self.link = link; self.lines = {} end,
        AddLine = function(self, line) self.lines[#self.lines + 1] = line end,
        Show = function(self) self.shown = true end,
        Hide = function(self) self.shown = false end,
        IsShown = function(self) return self.shown end,
    }
end

test("required amounts use Blizzard payloads and native quality colors", function()
    local amount
    C_CurrencyInfo = { GetCurrencyLink = function(id, needed)
        assert(id == 3316); amount = needed
        return "|cff0070dd|Hcurrency:3316:2500|h[Voidlight Marl]|h|r"
    end }
    local text = widgets:LinkifyPreviewCostText("2,500 Voidlight Marl.")
    assert(text == "|cff0070dd|Hcurrency:3316:2500|h[2,500 Voidlight Marl]|h|r.")
    assert(amount == 2500)
    C_Item = { GetItemInfo = function(id) return "Mark of Honor", "|cff1eff00|Hitem:" .. id .. ":0:0|h[Mark of Honor]|h|r" end }
    contains(widgets:LinkifyPreviewCostText("12 Marks of Honor"), "|cff1eff00|Hitem:137642:0:0|h[12 Marks of Honor]|h|r")
end)

test("mixed costs, alternatives, ranges, singular names and guide aliases remain readable", function()
    local text = widgets:LinkifyPreviewCostText("150 Essence of the Storm and 3,000 Elemental Overflow.")
    contains(text, "|Hitem:202039|h[150 Essence of the Storm]|h")
    contains(text, " and |cffffffff|Hcurrency:2118:0|h[3,000 Elemental Overflow]|h|r.")
    contains(widgets:LinkifyPreviewCostText("1,000-4,500 Flame-Blessed Iron per item."),
        "[1,000-4,500 Flame-Blessed Iron]|h|r per item.")
    contains(widgets:LinkifyPreviewCostText("1 Mysterious Fragment or 2 Seedbloom"), "|Hcurrency:2657:0|h[1 Mysterious Fragment]")
    contains(widgets:LinkifyPreviewCostText("1 Mysterious Fragment or 2 Seedbloom"), "|Hitem:211376|h[2 Seedbloom]")
    contains(widgets:LinkifyPreviewCostText("Wrists: 200 mementos", "Displaced Corrupted Mementos vendor"),
        "|Hcurrency:3149:0|h[200 mementos]")
    assert(widgets:LinkifyPreviewCostText("500 gold, 3 unknown tokens, 50 marks") == "500 gold, 3 unknown tokens, 50 marks")
end)

test("existing links are preserved and uncached API data retains working links", function()
    local native = "|cffa335ee|Hcurrency:3316:0|h[Voidlight Marl]|h|r"
    assert(widgets:LinkifyPreviewCostText(native) == native)
    C_CurrencyInfo = { GetCurrencyLink = function() error("Not loaded") end }
    C_Item = { GetItemInfo = function() return nil end }
    contains(widgets:LinkifyPreviewCostText("5 Marks of Honor"), "|Hitem:137642|")
    contains(widgets:LinkifyPreviewCostText("1,000 Voidlight Marl"), "|Hcurrency:3316:0|")
    contains(widgets:LinkifyPreviewCostText("1 Massive Mojo"), "|Hitem:19943|")
end)

test("hover reads currency balances live, including zero, and closes cleanly", function()
    local owned = 731
    C_CurrencyInfo = { GetCurrencyInfo = function(id) assert(id == 3316); return { quantity = owned } end }
    GameTooltip = tooltip()
    local content = CreateFrame("Frame", nil, UIParent)
    widgets:ConfigurePreviewCostLinks(content)
    local enter = content:GetScript("OnHyperlinkEnter")
    enter(content, "currency:3316:2500")
    assert(GameTooltip.link == "currency:3316:2500" and GameTooltip.shown)
    assert(GameTooltip.lines[1] == "You have: 731")
    owned = 0
    enter(content, "currency:3316:2500")
    assert(GameTooltip.lines[1] == "You have: 0")
    content:GetScript("OnHyperlinkLeave")(content)
    assert(not GameTooltip.shown)
    enter(content, "currency:3316:2500")
    content:GetScript("OnHide")(content)
    assert(not GameTooltip.shown)
end)

test("barter item tooltips distinguish bags from bank and Warband quantities", function()
    GameTooltip = tooltip()
    C_Item = { GetItemCount = function(id, bank, uses, reagent, account)
        assert(id == 137642)
        if bank then assert(not uses and reagent and account); return 28 end
        return 3
    end }
    local content = CreateFrame("Frame", nil, UIParent)
    widgets:ConfigurePreviewCostLinks(content)
    content:GetScript("OnHyperlinkEnter")(content, "item:137642")
    assert(GameTooltip.lines[1] == "You have: 3")
    assert(GameTooltip.lines[2] == "Including banks: 28")
    C_Item.GetItemCount = function() return nil end
    content:GetScript("OnHyperlinkEnter")(content, "item:137642")
    assert(#GameTooltip.lines == 0, "Unavailable counts must not become zero")
end)

test("normal clicks use native item references and modified clicks use native chat links", function()
    GameTooltip, ItemRefTooltip = tooltip(), tooltip()
    C_CurrencyInfo = { GetCurrencyInfo = function() return { quantity = 12 } end }
    local calls = 0
    SetItemRef = function(link, text, button, owner)
        assert(link == "currency:3316:0" and button == "LeftButton" and owner)
        calls = calls + 1
        ItemRefTooltip:SetHyperlink(link)
        ItemRefTooltip:Show()
    end
    local content = CreateFrame("Frame", nil, UIParent)
    widgets:ConfigurePreviewCostLinks(content)
    local click = content:GetScript("OnHyperlinkClick")
    local native = "|Hcurrency:3316:0|h[2,500 Voidlight Marl]|h"
    click(content, "currency:3316:0", native, "LeftButton")
    assert(calls == 1 and ItemRefTooltip.lines[1] == "You have: 12")
    HandleModifiedItemClick = function(link) assert(link == native); return true end
    click(content, "currency:3316:0", native, "LeftButton")
    assert(calls == 1)
    click(content, "currency:3316:0", "[2,500 Voidlight Marl]", "LeftButton")
    assert(calls == 1, "Plain display text retains its real cost label when linked to chat")
end)

test("Collections, Favorites and Collection Map share interactive detail links", function()
    GameTooltip = tooltip()
    local explorer = TDP.CollectionExplorerWindow:New()
    local favorites = TDP.FavoritesWindow:New()
    local row = { collectionType = "mounts", patchKey = "12.1.5", name = "Corrupted Swarmer",
        entry = catalog:GetEntries("12.1.5", "mounts")[1] }
    for _, window in ipairs({ explorer, favorites }) do
        window:Build()
        window.selectedRow = row
        window:RenderPreview()
        contains(window.previewDetails:GetText(), "|Hcurrency:3316:0|h[2,500 Voidlight Marl]")
        assert(window.previewDetailsContent:GetScript("OnHyperlinkEnter"))
        assert(window.previewDetailsContent:GetScript("OnHyperlinkClick"))
        assert(not window.previewDetails:GetScript("OnHyperlinkEnter"), "Handlers belong to the parent Frame")
    end
    local map = TDP.CollectionMapWindow:New()
    map:Build()
    map.cost = "12 Marks of Honor"
    map:RenderDetails()
    contains(map.detailText:GetText(), "|Hitem:137642|h[12 Marks of Honor]")
    assert(map.detailContent:GetScript("OnHyperlinkEnter"))
    local content = favorites.previewDetailsContent
    content:GetScript("OnHyperlinkEnter")(content, "currency:3316:0")
    widgets:UpdateScrollablePreviewText(favorites.previewDetailsScroll, content, favorites.previewDetails, "")
    assert(not GameTooltip.shown, "Changing selection closes an old cost tooltip")
end)
print("Cost link tests passed: " .. passed)
