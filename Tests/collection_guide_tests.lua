local root = arg and arg[1] or "."
local TDP = {}
assert(loadfile(root .. "/Tests/load_catalog.lua"))(root, TDP)
local catalog = TDP.PatchCatalog
local passed = 0
local function test(name, callback)
    callback()
    passed = passed + 1
    print("PASS: " .. name)
end
local function text(kind, patch, id)
    local field = ({ mounts = "spellId", pets = "speciesId", toys = "itemId" })[kind]
    for _, entry in ipairs(catalog:GetEntries(patch, kind)) do
        if entry[field] == id then return assert(catalog:GetCollectionAcquisitionText(kind, patch, entry)) end
    end
    error("Missing collection: " .. id)
end
local function contains(value, part) assert(value:find(part, 1, true), "Missing guide step: " .. part) end

test("secret guides explain the interactions rather than mislabeling a boss drop", function()
    local valiance = text("mounts", "10.1.5", 413922)
    contains(valiance, "Obedience Crystal")
    contains(valiance, "Razuvious")
    assert(not valiance:find("Defeat Valiance", 1, true))
    local jumpjets = text("mounts", "10.1.7", 424082)
    contains(jumpjets, "three players")
    contains(jumpjets, "Empowered Arcane Forge")
    contains(jumpjets, "Blasted Lands")
end)

test("vendors include names currency amounts and destinations", function()
    local guide = text("mounts", "10.1", 371176)
    contains(guide, "Saccratros")
    contains(guide, "100 Coveted Bauble")
    contains(guide, "Zaralek Cavern")
    local toy = text("toys", "10.1.5", 206565)
    contains(toy, "buy Plagued Grain")
    assert(not toy:find("Defeat Zackett", 1, true))
end)

test("random quest event rewards are not represented as guaranteed turn-ins", function()
    local guide = text("mounts", "10.1", 408651)
    contains(guide, "Researchers Under Fire")
    contains(guide, "chance reward")
    contains(guide, "47.5, 56.7")
end)

test("summoning reagents do not turn rare enemies into vendors", function()
    local alunira = text("mounts", "11.0", 447213)
    contains(alunira, "10 Crackling Shards")
    contains(alunira, "remove her Protective Stormshroud")
    local spyEye = text("mounts", "11.1", 466027)
    contains(spyEye, "Defeat Darkfuse Precipitant")
    assert(not spyEye:find("Buy Darkfuse Spy-Eye", 1, true))
end)

test("compiled guides preserve details access and do not overwrite shared peers", function()
    local first = catalog:GetEntries("10.1", "mounts")[1]
    local second = catalog:GetEntries("10.1", "mounts")[2]
    local firstDetails = catalog:GetMountDetails("10.1", first)
    local secondDetails = catalog:GetMountDetails("10.1", second)
    assert(firstDetails.acquisition == catalog:GetMountAcquisitionText("10.1", first))
    assert(secondDetails.acquisition == catalog:GetMountAcquisitionText("10.1", second))
    assert(firstDetails.acquisition ~= secondDetails.acquisition)
end)

test("crafting unlocks retain special requirements", function()
    contains(text("mounts", "11.1.5", 1218317), "Faceless Mask")
    contains(text("mounts", "11.1.5", 1218317), "Jewelcrafting 30")
    contains(text("mounts", "11.0", 448186), "1 Pummel Permit")
end)

test("unreleased and historical sources do not offer invented farming routes", function()
    contains(text("mounts", "11.2.7", 332482), "no confirmed obtainable version")
    contains(text("pets", "11.0.7", 4725), "removed from the collectible Pet Journal")
    contains(text("mounts", "10.2.7", 435044), "event, which has ended")
end)

test("guide reads do not call source builders or allocate destination payloads", function()
    local original = catalog.GetCollectionSourceInfo
    catalog.GetCollectionSourceInfo = function() error("Guide lookup must be a direct ID lookup") end
    for _ = 1, 200 do
        contains(text("mounts", "10.1.7", 424082), "booster parts")
        contains(text("pets", "11.0.7", 4726), "storm phase")
    end
    catalog.GetCollectionSourceInfo = original
    assert(catalog:GetCollectionGuideText("mounts", { spellId = -1 }) == nil)
end)
print(string.format("Collection guide tests: %d passed", passed))
