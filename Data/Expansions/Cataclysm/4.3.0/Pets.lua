-- Catalogue entries and complete Retail research for 4.3.0.
local _, TDP = ...

local walkthroughs = {
    [347] = {
        category = "Promotion",
        source = "Blizzard's World of Warcraft Shop - Soul of the Aspects",
        description = "An account-bound shop pet. The old Fangs of the Father guild-reward speculation was incorrect.",
        difficulty = "easy",
        difficultyReason = "A shop purchase and account delivery; no in-game grind or legendary quest is required.",
        requirements = "A compatible Retail WoW account in the shop region used for the purchase",
        cost = "Real money / supported Battle.net Balance; use the current regional shop price",
        tips = "The pet is not cageable. Guild vendors, Dragon Soul and the rogue legendary daggers do not award it. There is no physical acquisition NPC, so this guide intentionally has no map destination.",
        waypoints = {},
        itemId = 78916,
        name = "Soul of the Aspects",
        stepCount = 3,
        acquisition = "Difficulty: Easy - A shop purchase and account delivery; no in-game grind or legendary quest is required.\n\n1. Open the official World of Warcraft Shop on your Battle.net account or the in-game Shop, and find the Soul of the Aspects pet. Check that the product is for Retail WoW and the region/account on which you play.\n\n2. Review the current regional price and complete the purchase if you want this shop pet. No guild achievement, reputation or Fangs of the Father quest is part of the acquisition.\n\n3. Log into the purchased account's Retail region and search the Pet Journal for Soul of the Aspects, clearing filters if needed. Allow account delivery to finish and relog if it has not appeared yet; no trip to a guild vendor is necessary.",
        wowheadUrl = "https://www.wowhead.com/item=78916",
    },
}

TDP.CatalogRegistry:RegisterCollection("4.3.0", "pets", {
    entries = {
        {
            acquisition = "Obtain Soul of the Aspects from guild vendor after Fangs of the Father - Guild Edition.",
            category = "Guild Achievements",
            name = "Soul of the Aspects",
            source = "guild vendor after Fangs of the Father - Guild Edition",
            speciesId = 347,
            tips = "A guild must complete the legendary-dagger guild achievement before eligible members can purchase this pet.",
            waypoints = { "/way #84 67.4 72.8 Guild vendor", "/way #85 48.4 75.6 Guild vendor" },
            walkthrough = walkthroughs[347],
        },
    },
    details = {
        ["Soul of the Aspects"] = {
            acquisition = "Obtain Soul of the Aspects from guild vendor after Fangs of the Father - Guild Edition.",
            source = "guild vendor after Fangs of the Father - Guild Edition",
            sourceType = "Pet Journal Source",
            tips = "A guild must complete the legendary-dagger guild achievement before eligible members can purchase this pet.",
            waypoints = { "/way #84 67.4 72.8 Guild vendor", "/way #85 48.4 75.6 Guild vendor" },
        },
    },
})
