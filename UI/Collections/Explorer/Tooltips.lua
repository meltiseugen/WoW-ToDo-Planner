local _, TDP = ...
local CollectionExplorerWindow = TDP.CollectionExplorerWindow

function CollectionExplorerWindow:TryShowGameTooltip(methodName, ...)
    if not GameTooltip or type(GameTooltip[methodName]) ~= "function" then
        return false
    end

    GameTooltip:ClearLines()
    local ok = pcall(GameTooltip[methodName], GameTooltip, ...)
    return ok and (type(GameTooltip.NumLines) ~= "function" or GameTooltip:NumLines() > 0)
end

function CollectionExplorerWindow:TryShowGameTooltipLink(link)
    if not link or not GameTooltip or type(GameTooltip.SetHyperlink) ~= "function" then
        return false
    end

    GameTooltip:ClearLines()
    local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, link)
    return ok and (type(GameTooltip.NumLines) ~= "function" or GameTooltip:NumLines() > 0)
end

function CollectionExplorerWindow:GetBattlePetName(speciesId, row)
    if C_PetJournal and type(C_PetJournal.GetPetInfoBySpeciesID) == "function" and speciesId then
        local ok, name = pcall(C_PetJournal.GetPetInfoBySpeciesID, speciesId)
        if ok and name then
            return name
        end
    end
    return row and row.name
end

function CollectionExplorerWindow:TryShowBattlePetTooltip(owner, speciesId, row)
    speciesId = tonumber(speciesId)
    if not speciesId then
        return false
    end

    local tooltip = _G.FloatingBattlePetTooltip or _G.BattlePetTooltip
    if tooltip and type(tooltip.SetOwner) == "function" then
        tooltip:SetOwner(owner, "ANCHOR_RIGHT")
    end

    local showTooltip = _G.BattlePetTooltip_Show or _G.BattlePetToolTip_Show
    if type(showTooltip) == "function" then
        local ok = pcall(showTooltip, speciesId, 1, 3, 0, 0, 0, self:GetBattlePetName(speciesId, row))
        if ok then
            if GameTooltip then
                GameTooltip:Hide()
            end
            return "battlepet"
        end
    end

    return self:TryShowGameTooltipLink("battlepet:" .. tostring(speciesId) .. ":1:3:0:0:0:0")
end

function CollectionExplorerWindow:ShowFallbackTooltip(row)
    if not GameTooltip or not row then
        return
    end

    GameTooltip:ClearLines()
    GameTooltip:SetText(row.name or "Unknown", 1, 0.82, 0.18)
    GameTooltip:AddLine(self:GetTypeLabel(row.collectionType), 0.86, 0.88, 0.94)
    GameTooltip:AddLine(self:GetRowStatusLabel(row), row.collected and 0.28 or 0.92, row.collected and 0.82 or 0.72, row.collected and 0.42 or 0.28)
    local notes = self:GetRowNotes(row)
    if notes and notes ~= "" then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(notes, 0.86, 0.88, 0.94, true)
    end
    GameTooltip:Show()
end

function CollectionExplorerWindow:HideRowTooltip()
    if GameTooltip then
        GameTooltip:Hide()
    end

    local hideTooltip = _G.BattlePetTooltip_Hide or _G.BattlePetToolTip_Hide
    if type(hideTooltip) == "function" then
        pcall(hideTooltip)
    end

    if _G.FloatingBattlePetTooltip and _G.FloatingBattlePetTooltip.Hide then
        _G.FloatingBattlePetTooltip:Hide()
    end
    if _G.BattlePetTooltip and _G.BattlePetTooltip.Hide then
        _G.BattlePetTooltip:Hide()
    end
end

function CollectionExplorerWindow:ShowRowTooltip(owner, row)
    row = row or (owner and owner.rowData)
    if not row or not GameTooltip then
        return
    end

    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")

    local entry = row.entry
    local state = row.state or {}
    local itemId = type(entry) == "table" and tonumber(entry.itemId) or nil
    local spellId = type(entry) == "table" and tonumber(entry.spellId) or nil
    local speciesId = type(entry) == "table" and tonumber(entry.speciesId) or nil
    local achievementId = self:GetRowAchievementId(row)
    local shown = false

    if row.collectionType == "mounts" then
        shown = (itemId and self:TryShowGameTooltip("SetItemByID", itemId))
            or (spellId and self:TryShowGameTooltip("SetMountBySpellID", spellId))
            or (spellId and self:TryShowGameTooltip("SetSpellByID", spellId))
            or (itemId and self:TryShowGameTooltipLink("item:" .. tostring(itemId)))
            or (spellId and self:TryShowGameTooltipLink("spell:" .. tostring(spellId)))
    elseif row.collectionType == "pets" then
        shown = speciesId and self:TryShowBattlePetTooltip(owner, speciesId, row)
    elseif row.collectionType == "toys" then
        shown = (itemId and self:TryShowGameTooltip("SetToyByItemID", itemId))
            or (itemId and self:TryShowGameTooltip("SetItemByID", itemId))
            or (itemId and self:TryShowGameTooltipLink("item:" .. tostring(itemId)))
    elseif row.collectionType == "cosmetics" then
        shown = (itemId and self:TryShowGameTooltip("SetItemByID", itemId))
            or (itemId and self:TryShowGameTooltipLink("item:" .. tostring(itemId)))
    elseif row.collectionType == "achievements" then
        shown = (achievementId and self:TryShowGameTooltip("SetAchievementByID", achievementId))
    end

    if not shown and state.linkType and state.linkId then
        local linkType = tostring(state.linkType)
        if linkType == "battle-pet" or linkType == "battlepet" then
            shown = self:TryShowBattlePetTooltip(owner, state.linkId, row)
        else
            shown = self:TryShowGameTooltipLink(linkType .. ":" .. tostring(state.linkId))
        end
    end

    if shown and shown ~= "battlepet" then
        GameTooltip:Show()
    elseif shown == "battlepet" then
        return
    else
        self:ShowFallbackTooltip(row)
    end
end
