-- Test-only adapter for WoW's ordered XML Script/Include loading.
local root, addon = ...
local function loadManifest(path)
    local file = assert(io.open(root .. "/" .. path, "r"))
    local source = file:read("*a")
    file:close()
    local directory = path:match("^(.*)/")
    for tag, relative in source:gmatch('<(%w+)%s+file="([^"]+)"') do
        local child = directory .. "/" .. relative
        if tag == "Include" then
            loadManifest(child)
        elseif tag == "Script" then
            assert(loadfile(root .. "/" .. child))("TODO-Planner", addon)
        end
    end
end
for index = 3, select("#", ...) do
    loadManifest(select(index, ...))
end
