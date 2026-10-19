local _, TDP = ...

local shared = {}
shared["Weapons o' the Dark Iron"] = {
    acquisition = "On a Dark Iron dwarf that has completed Heritage o' the Dark Iron, finish the Anvil-Thane questline in Blackrock Depths.",
    source = "Weapons o' the Dark Iron",
    sourceType = "Racial Questline",
}

shared["Blood Knight"] = {
    acquisition = "On a level-60 blood elf paladin exalted with Silvermoon City, complete Lady Liadrin's Ghostlands questline.",
    source = "Blood Knight",
    sourceType = "Racial and Class Questline",
    waypoints = { "/way #1670 42.5 27.2 Lady Liadrin / Oribos" },
}

shared["Return to Lordaeron / Outfitter Reynolds"] = {
    acquisition = "Complete Return to Lordaeron on a hunter, then buy the ensemble from Outfitter Reynolds in Trueshot Lodge.",
    cost = "1,000 gold.",
    source = "Return to Lordaeron / Outfitter Reynolds",
    sourceType = "Questline and Vendor",
}

TDP.CatalogRegistry:RegisterCollection("9.2.5", "cosmetics", {
    entries = {
        {
            detailKey = "lavaforgeArmaments",
            itemId = 184922,
            name = "Arsenal: Lavaforge Armaments",
            requirements = "Dark Iron dwarf; complete Heritage o' the Dark Iron",
            subtype = "arsenal",
        },
        {
            detailKey = "bloodKnightDedication",
            itemId = 191565,
            name = "Ensemble: Blood Knight's Dedication",
            requirements = "Blood elf paladin; level 60 and Exalted with Silvermoon City",
            subtype = "ensemble",
        },
        {
            detailKey = "darkRangerAttire",
            itemId = 191658,
            name = "Ensemble: Dark Ranger's Attire",
            requirements = "Hunter; complete the Return to Lordaeron questline on that hunter",
            subtype = "ensemble",
        },
    },
    details = {
        ["Arsenal: Lavaforge Armaments"] = shared["Weapons o' the Dark Iron"],
        ["Ensemble: Blood Knight's Dedication"] = shared["Blood Knight"],
        ["Ensemble: Dark Ranger's Attire"] = shared["Return to Lordaeron / Outfitter Reynolds"],
        bloodKnightDedication = shared["Blood Knight"],
        darkRangerAttire = shared["Return to Lordaeron / Outfitter Reynolds"],
        lavaforgeArmaments = shared["Weapons o' the Dark Iron"],
    },
})
