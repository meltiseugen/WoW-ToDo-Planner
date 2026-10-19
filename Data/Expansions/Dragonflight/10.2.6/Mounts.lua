local _, TDP = ...

local shared = {}
shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "Other",
    source = "Patch 10.2.6: Plunderstorm / Dragonflight Season 4",
    sourceType = "Patch mount collection",
}

shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 2"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    category = "PvP",
    source = "Patch 10.2.6: Plunderstorm / Dragonflight Season 4",
    sourceType = "Patch mount collection",
}

shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 3"] = {
    acquisition = "Follow the in-game Mount Journal source for this mount. This row records the patch in which the reward was introduced.",
    availability = "Limited-time reward; retained in its original patch catalog for historical collection tracking.",
    category = "Other",
    source = "Patch 10.2.6: Plunderstorm / Dragonflight Season 4",
    sourceType = "Patch mount collection",
}

TDP.CatalogRegistry:RegisterCollection("10.2.6", "mounts", {
    entries = {
        { name = "Bestowed Thunderspine Packleader", spellId = 351408 },
        { name = "Stormtouched Bruffalon", spellId = 373967 },
        { name = "Bestowed Sandskimmer", spellId = 374071 },
        { name = "Coralscale Salamanther", spellId = 374097 },
        { name = "Bestowed Trawling Mammoth", spellId = 374172 },
        { name = "Bestowed Ottuk Vanguard", spellId = 376898 },
        { name = "Bestowed Ohuna Spotter", spellId = 385260 },
        { name = "Calescent Shalewing", spellId = 408648 },
        { name = "Draconic Gladiator's Drake", spellId = 424539 },
        { name = "Taivan", spellId = 424607 },
        { name = "Infinite Armoredon", spellId = 434462 },
        { name = "Vicious Dreamtalon", spellId = 434470 },
        { name = "Vicious Dreamtalon", spellId = 434477 },
        { name = "Voyaging Wilderling", spellId = 439138 },
        { name = "Zovaal's Soul Eater", spellId = 440444 },
        { name = "Royal Seafeather", spellId = 254812 },
        { name = "Silver Tidestallion", spellId = 300154 },
        { name = "Polly Roger", spellId = 437162 },
    },
    details = {
        ["Bestowed Ohuna Spotter"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Bestowed Ottuk Vanguard"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Bestowed Sandskimmer"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Bestowed Thunderspine Packleader"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Bestowed Trawling Mammoth"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Calescent Shalewing"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Coralscale Salamanther"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Draconic Gladiator's Drake"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 2"],
        ["Infinite Armoredon"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Polly Roger"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 3"],
        ["Royal Seafeather"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 3"],
        ["Silver Tidestallion"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 3"],
        ["Stormtouched Bruffalon"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        Taivan = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Vicious Dreamtalon"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4 2"],
        ["Voyaging Wilderling"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
        ["Zovaal's Soul Eater"] = shared["Patch 10.2.6: Plunderstorm / Dragonflight Season 4"],
    },
})
