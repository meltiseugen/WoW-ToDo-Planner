local _, TDP = ...
local Window = TDP.CollectionExplorerWindow

function Window:GetRowNotes(row)
    if not row then return "" end
    local lines = {}
    if row.unobtainable and row.availability then
        lines[#lines + 1] = "Unobtainable: " .. row.availability.reason
    end
    lines[#lines + 1] = TDP.PatchCatalog:GetCollectionOverviewText(row.collectionType, row.patchKey, row.entry, row.state)
    if row.reward and not (row.state and row.state.reward) then
        lines[#lines + 1] = "Reward: " .. row.reward
    end
    return table.concat(lines, "\n\n")
end
