local _, TDP = ...
local Widgets = getmetatable(TDP.Widgets)

-- IDs verified against https://nether.wowhead.com/tooltip/{currency|item}/{id}
-- on 2026-10-27. Barter items need item links, rather than currency links.
local RESOURCES = {
    { "currency", 3316, "Voidlight Marl" },
    { "currency", 2815, "Resonance Crystals" },
    { "currency", 2803, "Undercoin" },
    { "currency", 3090, "Flame-Blessed Iron" },
    { "currency", 3056, "Kej" },
    { "currency", 2003, "Dragon Isles Supplies", "supplies" },
    { "currency", 2118, "Elemental Overflow" },
    { "currency", 2657, "Mysterious Fragment", "Mysterious Fragments" },
    { "currency", 2594, "Paracausal Flakes", "flakes" },
    { "currency", 2123, "Bloody Tokens" },
    { "currency", 1508, "Veiled Argunite" },
    { "currency", 1979, "Cyphers of the First Ones" },
    { "currency", 1719, "Corrupted Mementos" },
    { "currency", 1728, "Phantasma" },
    { "currency", 3149, "Displaced Corrupted Mementos", "mementos" },
    { "currency", 3055, "Mereldar Derby Mark", "Mereldar Derby Marks", "marks" },
    { "item", 205188, "Barter Boulder", "Barter Boulders" },
    { "item", 202039, "Essence of the Storm" },
    { "item", 137642, "Mark of Honor", "Marks of Honor" },
    { "item", 211376, "Seedbloom" },
    { "item", 237578, "Counterfeit Dealer's Chip" },
    { "item", 203914, "Zandalar Bargaining Token", "Bargaining Tokens" },
    { "item", 190329, "Awakened Frost" },
    { "item", 223951, "Earth-Encrusted Gem" },
    { "item", 151564, "Empyrium" },
    { "item", 151718, "Argulite" },
    { "item", 151565, "Astral Glory" },
    { "item", 151566, "Fiendish Leather" },
    { "item", 151567, "Lightweave Cloth" },
    { "item", 151579, "Labradorite" },
    { "item", 151722, "Florid Malachite" },
    { "item", 193050, "Tattered Wildercloth" },
    { "item", 12800, "Azerothian Diamond" },
    { "item", 6037, "Truesilver Bar" },
    { "item", 21752, "Thorium Setting" },
    { "item", 19943, "Massive Mojo" },
}

local SHORT_NAMES = { supplies = true, flakes = true, mementos = true, marks = true }

local function call(api, ...)
    if type(api) ~= "function" then return nil end
    local ok, result = pcall(api, ...)
    if ok then return result end
end

local function resourceLink(resource, label, amount)
    local kind, id = resource[1], resource[2]
    local link
    if kind == "currency" then
        link = call(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyLink, id, amount)
    else
        link = call(C_Item and C_Item.GetItemLinkByID, id)
        if not link then
            local api = C_Item and C_Item.GetItemInfo or GetItemInfo
            if type(api) == "function" then
                local ok, _, itemLink = pcall(api, id)
                if ok then link = itemLink end
            end
        end
    end
    if type(link) == "string" and link:find("|H", 1, true) then
        -- Preserve Blizzard's link payload and quality color; include the cost in its label.
        return (link:gsub("|h.-|h", function() return "|h[" .. label .. "]|h" end, 1))
    end
    -- An uncached item is still hoverable; SetHyperlink requests its native tooltip.
    return "|cffffffff|H" .. kind .. ":" .. id .. (kind == "currency" and ":0" or "")
        .. "|h[" .. label .. "]|h|r"
end

function Widgets:LinkifyPreviewCostText(text, context)
    text = tostring(text or "")
    context = tostring(context or text):lower()
    local function plainText(part)
        local lower, result, position = part:lower(), {}, 1
        while position <= #part do
            local first, last, chosen
            for _, resource in ipairs(RESOURCES) do
                for index = 3, #resource do
                    local alias = resource[index]:lower()
                    -- Short names only make sense when the notes identify their resource.
                    if not SHORT_NAMES[alias] or context:find(resource[3]:lower(), 1, true) then
                        local from = position
                        while from <= #part do
                            local startAt, endAt = lower:find(alias, from, true)
                            if not startAt then break end
                            if not lower:sub(startAt - 1, startAt - 1):match("[%a]")
                                and not lower:sub(endAt + 1, endAt + 1):match("[%a]") then
                                if not first or startAt < first or startAt == first and endAt > last then
                                    first, last, chosen = startAt, endAt, resource
                                end
                                break
                            end
                            from = endAt + 1
                        end
                    end
                end
            end
            if not first then
                result[#result + 1] = part:sub(position)
                break
            end
            local prefix = part:sub(position, first - 1)
            local amountText = prefix:match("(%d[%d,]*[ \t]*%-[ \t]*%d[%d,]*[ \t]+)$")
                or prefix:match("(%d[%d,]*[ \t]+)$")
            local amount = amountText and tonumber((amountText:gsub(",", ""))) or nil
            if amountText then first = first - #amountText end
            result[#result + 1] = part:sub(position, first - 1)
            result[#result + 1] = resourceLink(chosen, part:sub(first, last), amount)
            position = last + 1
        end
        return table.concat(result)
    end
    -- Leave existing Blizzard links intact, including links added by another addon.
    local result, position = {}, 1
    while position <= #text do
        local first, last = text:find("|H.-|h.-|h", position)
        if not first then result[#result + 1] = plainText(text:sub(position)); break end
        result[#result + 1] = plainText(text:sub(position, first - 1))
        result[#result + 1] = text:sub(first, last)
        position = last + 1
    end
    return table.concat(result)
end

local function displayCount(quantity)
    return call(BreakUpLargeNumbers, quantity) or tostring(quantity)
end

function Widgets:AddPreviewCostOwnedCount(tooltip, link)
    local kind, id = tostring(link or ""):match("^([%a]+):(%d+)")
    id = tonumber(id)
    if not id then return end
    if kind == "currency" then
        local info = call(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo, id)
        if info and type(info.quantity) == "number" then
            tooltip:AddLine("You have: " .. displayCount(info.quantity), 1, 0.82, 0)
        end
    elseif kind == "item" then
        local api = C_Item and C_Item.GetItemCount or GetItemCount
        local bags = call(api, id)
        local total = call(api, id, true, false, true, true)
        if type(bags) == "number" then
            tooltip:AddLine("You have: " .. displayCount(bags), 1, 0.82, 0)
        end
        if type(total) == "number" and type(bags) == "number" and total > bags then
            tooltip:AddLine("Including banks: " .. displayCount(total), 1, 0.82, 0)
        end
    end
end

function Widgets:ConfigurePreviewCostLinks(content)
    if content.previewCostLinksConfigured or not content.SetHyperlinksEnabled then return end
    content.previewCostLinksConfigured = true
    content:SetHyperlinksEnabled(true)
    content:EnableMouse(true)
    local function hideTooltip(target)
        if target.previewCostLink and GameTooltip then
            if not GameTooltip.GetOwner or GameTooltip:GetOwner() == target then GameTooltip:Hide() end
        end
        target.previewCostLink = nil
    end
    content:SetScript("OnHyperlinkEnter", function(target, link)
        if not GameTooltip or not tostring(link):match("^currency:%d+")
            and not tostring(link):match("^item:%d+") then return end
        GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
        local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, link)
        if not ok then GameTooltip:Hide(); return end
        target.previewCostLink = link
        self:AddPreviewCostOwnedCount(GameTooltip, link)
        GameTooltip:Show()
    end)
    content:SetScript("OnHyperlinkLeave", hideTooltip)
    content:SetScript("OnHide", hideTooltip)
    content:SetScript("OnHyperlinkClick", function(target, link, text, button)
        if not tostring(link):match("^currency:%d+") and not tostring(link):match("^item:%d+") then return end
        local label = tostring(text or "Resource"):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
            :gsub("^%[", ""):gsub("%]$", "")
        local fullLink = tostring(text or ""):find("|H", 1, true) and text or "|H" .. link .. "|h[" .. label .. "]|h"
        if call(HandleModifiedItemClick, fullLink) then return end
        if type(SetItemRef) == "function" then
            SetItemRef(link, fullLink, button, target)
            if ItemRefTooltip and ItemRefTooltip:IsShown() then
                self:AddPreviewCostOwnedCount(ItemRefTooltip, link)
                ItemRefTooltip:Show()
            end
        end
    end)
    content.HidePreviewCostTooltip = hideTooltip
end
