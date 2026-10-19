local _, TDP = ...
local FavoritesWindow = TDP.FavoritesWindow
local PatchCatalog = TDP.PatchCatalog

function FavoritesWindow:GetRowNotes(row)
    local lines = {}

    if row.collectionType == "mounts" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetMountSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetMountAcquisitionText(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
    elseif row.collectionType == "pets" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetPetSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetPetAcquisitionText(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
    elseif row.collectionType == "toys" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetToySourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetToyAcquisitionText(row.patchKey, row.entry)
        local effect = PatchCatalog and PatchCatalog:GetToyUseText(row.patchKey, row.entry)
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
        if effect then
            lines[#lines + 1] = "Effect: " .. effect
        end
    elseif row.collectionType == "cosmetics" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetCosmeticSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetCosmeticAcquisitionText(row.patchKey, row.entry)
        local subtype = type(row.entry) == "table" and row.entry.subtype or "appearance"
        lines[#lines + 1] = "Cosmetic Type: " .. tostring(subtype):gsub("^%l", string.upper)
        if row.state and (row.state.totalCount or 0) > 0 then
            lines[#lines + 1] = string.format("Appearance Progress: %d/%d", row.state.collectedCount or 0, row.state.totalCount)
        end
        if sourceSummary then
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
    elseif row.collectionType == "achievements" then
        local sourceSummary = PatchCatalog and PatchCatalog:GetAchievementSourceSummary(row.patchKey, row.entry)
        local acquisition = PatchCatalog and PatchCatalog:GetAchievementAcquisitionText(row.patchKey, row.entry)
        if row.achievementCategory then
            lines[#lines + 1] = "Achievement Type: " .. row.achievementCategory
        end
        if row.state and row.state.categoryName then
            lines[#lines + 1] = "WoW Category: " .. row.state.categoryName
        end
        if row.state and row.state.parentCategoryName then
            lines[#lines + 1] = "WoW Parent Category: " .. row.state.parentCategoryName
        end
        if row.state and row.state.description and row.state.description ~= "" then
            lines[#lines + 1] = ""
            lines[#lines + 1] = "Description: " .. row.state.description
        end
        if row.state and type(row.state.criteria) == "table" and #row.state.criteria > 0 then
            lines[#lines + 1] = ""
            lines[#lines + 1] = "Criteria:"
            for _, criterion in ipairs(row.state.criteria) do
                local marker = criterion.completed and "[Done] " or "[ ] "
                local progress = ""
                if criterion.quantityText and criterion.quantityText ~= "" then
                    progress = " (" .. criterion.quantityText .. ")"
                elseif criterion.requiredQuantity and criterion.requiredQuantity > 1 then
                    progress = string.format(" (%d/%d)", criterion.quantity or 0, criterion.requiredQuantity)
                end
                lines[#lines + 1] = marker .. criterion.text .. progress
            end
        end
        if sourceSummary then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "Source: " .. sourceSummary
        end
        if acquisition then
            if #lines > 0 then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "How to get: " .. acquisition
        end
    end

    local tips = PatchCatalog and PatchCatalog:GetCollectionTips(row.collectionType, row.patchKey, row.entry)
    if tips then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Tips: " .. tips
    end

    if row.reward then
        if #lines > 0 then
            lines[#lines + 1] = ""
        end
        lines[#lines + 1] = "Reward: " .. row.reward
    end

    return table.concat(lines, "\n")
end
