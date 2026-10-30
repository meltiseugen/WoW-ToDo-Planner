local _, TDP = ...

local shared = {}
shared["Special Event: Plunderstorm"] = { source = "Special Event: Plunderstorm", sourceType = "Pet Journal Source" }

TDP.CatalogRegistry:RegisterCollection("10.2.6", "pets", {
    entries = {
        { name = "Glamrok", npcId = 218647, source = "Special Event: Plunderstorm", speciesId = 4425 },
        { name = "Bubbles", npcId = 218646, source = "Special Event: Plunderstorm", speciesId = 4426 },
        { name = "Happy", npcId = 218977, source = "Special Event: Plunderstorm", speciesId = 4435 },
    },
    details = { Bubbles = shared["Special Event: Plunderstorm"], Glamrok = shared["Special Event: Plunderstorm"], Happy = shared["Special Event: Plunderstorm"] },
})
