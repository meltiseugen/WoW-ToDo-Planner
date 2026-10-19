local _, TDP = ...

local shared = {}
shared["Patch 10.2.5: Seeds of Renewal"] = { acquisition = "Complete the achievement's listed criteria.", source = "Patch 10.2.5: Seeds of Renewal", sourceType = "Achievement" }

TDP.CatalogRegistry:RegisterCollection("10.2.5", "achievements", {
    entries = { ids = { 19685, 19719, 19720, 19786, 19787, 19788, 19789, 19790, 19791, 19792, 19793, 20206 }, rewardHighlights = {} },
    details = {
        [19685] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19719] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19720] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19786] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19787] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19788] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19789] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19790] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19791] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19792] = shared["Patch 10.2.5: Seeds of Renewal"],
        [19793] = shared["Patch 10.2.5: Seeds of Renewal"],
        [20206] = shared["Patch 10.2.5: Seeds of Renewal"],
    },
    categories = {
        [19685] = "Reputation",
        [19719] = "Questing",
        [19720] = "Questing",
        [19786] = "Questing",
        [19787] = "Questing",
        [19788] = "Questing",
        [19789] = "Questing",
        [19790] = "Questing",
        [19791] = "Questing",
        [19792] = "Questing",
        [19793] = "Questing",
        [20206] = "Questing",
    },
})
