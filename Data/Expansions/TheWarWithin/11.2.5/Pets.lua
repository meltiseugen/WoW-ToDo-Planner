local _, TDP = ...

local shared = {}
shared["World Event: WoW Remix: Legion"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "World Event: WoW Remix: Legion", sourceType = "Pet Journal Source" }

TDP.CatalogRegistry:RegisterCollection("11.2.5", "pets", {
    entries = {
        { name = "Tidbit", npcId = 242176, source = "World Event: WoW Remix: Legion", speciesId = 4801 },
        { name = "Morsel", npcId = 242180, source = "World Event: WoW Remix: Legion", speciesId = 4802 },
        { name = "Fledgling Warden's Companion", npcId = 251889, source = "World Event: WoW Remix: Legion", speciesId = 4901 },
    },
    details = {
        ["Fledgling Warden's Companion"] = shared["World Event: WoW Remix: Legion"],
        Morsel = shared["World Event: WoW Remix: Legion"],
        Tidbit = shared["World Event: WoW Remix: Legion"],
    },
})
