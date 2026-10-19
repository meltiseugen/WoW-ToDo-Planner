local _, TDP = ...

local shared = {}
shared["Drop: Fyrakk Assault"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Drop: Fyrakk Assault", sourceType = "Pet Journal Source" }

shared["Quest: A Race To The Finish / Zone: Zaralek Cavern"] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Quest: A Race To The Finish / Zone: Zaralek Cavern",
    sourceType = "Pet Journal Source",
}

shared["Pet Battle: Zaralek Cavern"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Pet Battle: Zaralek Cavern", sourceType = "Pet Journal Source" }

shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"] = {
    acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
    source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 250",
    sourceType = "Pet Journal Source",
}

shared["Drop: Kob'rok / Zone: Zaralek Cavern"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Drop: Kob'rok / Zone: Zaralek Cavern", sourceType = "Pet Journal Source" }

TDP.CatalogRegistry:RegisterCollection("10.1", "pets", {
    entries = {
        { name = "Gerald", npcId = 189119, source = "Achievement: Family Battler of Zaralek Cavern / Category: Battle", speciesId = 3294 },
        { name = "Puddlehopper", npcId = 203287, source = "Pet Battle: Zaralek Cavern", speciesId = 3477 },
        { name = "Rock Martin", npcId = 203288, source = "Pet Battle: Zaralek Cavern", speciesId = 3478 },
        { name = "Yellabon", npcId = 203289, source = "Pet Battle: Zaralek Cavern", speciesId = 3479 },
        { name = "Endmite", npcId = 203292, source = "Pet Battle: Zaralek Cavern", speciesId = 3480 },
        { name = "Stonewhisker", npcId = 203308, source = "Pet Battle: Zaralek Cavern", speciesId = 3481 },
        { name = "Cobbleshell", npcId = 203310, source = "Pet Battle: Zaralek Cavern", speciesId = 3482 },
        { name = "Boulderfang", npcId = 203311, source = "Pet Battle: Zaralek Cavern", speciesId = 3483 },
        { name = "Slabwing", npcId = 203312, source = "Pet Battle: Zaralek Cavern", speciesId = 3484 },
        { name = "Hollow Moth", npcId = 203313, source = "Pet Battle: Zaralek Cavern", speciesId = 3485 },
        { name = "Lithengale", npcId = 203358, source = "Pet Battle: Zaralek Cavern", speciesId = 3486 },
        { name = "Scarlapod", npcId = 203364, source = "Pet Battle: Zaralek Cavern", speciesId = 3487 },
        { name = "Deepridger", npcId = 203367, source = "Pet Battle: Zaralek Cavern", speciesId = 3488 },
        { name = "Sunglow Cobra", npcId = 203372, source = "Pet Battle: Zaralek Cavern", speciesId = 3489 },
        { name = "Ebonwing Moth", npcId = 203377, source = "Pet Battle: Zaralek Cavern", speciesId = 3490 },
        { name = "Roland", npcId = 204036, source = "Achievement: The Gift of Cheese / Category: Cooking", speciesId = 3493 },
        { name = "Blaise", npcId = 204217, source = "Drop: Fyrakk Assault", speciesId = 3511 },
        { name = "Ambre", npcId = 204221, source = "Drop: Fyrakk Assault", speciesId = 3512 },
        { name = "Annuna", npcId = 204225, source = "Quest: A Scaly Pet / Zone: Valdrakken", speciesId = 3515 },
        {
            name = "Crimson Swoglet",
            npcId = 204226,
            source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 250",
            speciesId = 3516,
        },
        { name = "Lord Stantley", npcId = 204263, source = "Zone: Zaralek Cavern", speciesId = 3521 },
        {
            name = "Cheddar",
            npcId = 204268,
            source = "Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone: The Azure Span / Zone: Thaldraszus / Cost: 250",
            speciesId = 3523,
        },
        { name = "Devourer Lobstrok", npcId = 204269, source = "Drop: Researchers Under Fire / Zone: Zaralek Cavern", speciesId = 3524 },
        { name = "Paulie", npcId = 204286, source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 200", speciesId = 3528 },
        { name = "Rango", npcId = 204288, source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 150", speciesId = 3529 },
        { name = "Miloh", npcId = 204293, source = "Vendor: Explorer Bezzert / Zone: Zaralek Cavern / Cost: 2500 / Vendor: Patchu / Zone: The Azure Span / Cost: 2500", speciesId = 3530 },
        { name = "Brul", npcId = 204303, source = "Treasure: Chest of Massive Gains / Zone: Zaralek Cavern", speciesId = 3533 },
        { name = "Diamondshell", npcId = 204320, source = "Vendor: Saccratros / Zone: Zaralek Cavern / Cost: 50", speciesId = 3535 },
        { name = "Bashful", npcId = 204321, source = "Quest: A Race To The Finish / Zone: Zaralek Cavern", speciesId = 3536 },
        { name = "Thimblerig", npcId = 204323, source = "Vendor: Ponzo / Zone: Zaralek Cavern / Cost: 45", speciesId = 3537 },
        { name = "Tricky", npcId = 204324, source = "Quest: A Race To The Finish / Zone: Zaralek Cavern", speciesId = 3538 },
        { name = "Brulee", npcId = 204326, source = "Quest: A Race To The Finish / Zone: Zaralek Cavern", speciesId = 3540 },
        { name = "Ridged Shalewing", npcId = 204339, source = "Drop: Kob'rok / Zone: Zaralek Cavern", speciesId = 3541 },
        { name = "Salverun", npcId = 204343, source = "Treasure: Ouroboros Tablet and Kob'rok's Luminescent Scale", speciesId = 3545 },
        { name = "Skaarn", npcId = 204345, source = "Drop: Kob'rok / Zone: Zaralek Cavern", speciesId = 3546 },
        { name = "Aquapo", npcId = 204359, source = "Drop: Aquifon / Zone: Zaralek Cavern", speciesId = 3548 },
        { name = "Teardrop Moth", npcId = 204363, source = "Drop: Underlight Queen / Zone: Zaralek Cavern", speciesId = 3551 },
        { name = "Nelthara", npcId = 204367, source = "Quest: Augmenting a Dragon", speciesId = 3553 },
        { name = "Axel", npcId = 204369, source = "Achievement: Whelp, There It Is / Category: Collect", speciesId = 3555 },
        { name = "Roggy", npcId = 204621, source = "Achievement: Slow and Steady Wins the Race / Category: Dragon Isles", speciesId = 3557 },
        { name = "Newsy", npcId = 205359, source = "Quest: Signed, Sealed, Self-Delivered", speciesId = 3578 },
        { name = "Mote of Nasz'uro", npcId = 205649, source = "Treasure:Wayward Motes of Nasz'uro", speciesId = 3581 },
    },
    details = {
        Ambre = shared["Drop: Fyrakk Assault"],
        Annuna = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Quest: A Scaly Pet / Zone: Valdrakken", sourceType = "Pet Journal Source" },
        Aquapo = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Drop: Aquifon / Zone: Zaralek Cavern", sourceType = "Pet Journal Source" },
        Axel = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Whelp, There It Is / Category: Collect",
            sourceType = "Pet Journal Source",
        },
        Bashful = shared["Quest: A Race To The Finish / Zone: Zaralek Cavern"],
        Blaise = shared["Drop: Fyrakk Assault"],
        Boulderfang = shared["Pet Battle: Zaralek Cavern"],
        Brul = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Treasure: Chest of Massive Gains / Zone: Zaralek Cavern",
            sourceType = "Pet Journal Source",
        },
        Brulee = shared["Quest: A Race To The Finish / Zone: Zaralek Cavern"],
        Cheddar = shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"],
        Cobbleshell = shared["Pet Battle: Zaralek Cavern"],
        ["Crimson Swoglet"] = shared["Vendor: Celestine of the Harvest / Zone: The Waking Shores / Zone: Ohn'ahran Plains / Zone"],
        Deepridger = shared["Pet Battle: Zaralek Cavern"],
        ["Devourer Lobstrok"] = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Drop: Researchers Under Fire / Zone: Zaralek Cavern",
            sourceType = "Pet Journal Source",
        },
        Diamondshell = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Saccratros / Zone: Zaralek Cavern / Cost: 50",
            sourceType = "Pet Journal Source",
        },
        ["Ebonwing Moth"] = shared["Pet Battle: Zaralek Cavern"],
        Endmite = shared["Pet Battle: Zaralek Cavern"],
        Gerald = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Family Battler of Zaralek Cavern / Category: Battle",
            sourceType = "Pet Journal Source",
        },
        ["Hollow Moth"] = shared["Pet Battle: Zaralek Cavern"],
        Lithengale = shared["Pet Battle: Zaralek Cavern"],
        ["Lord Stantley"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Zone: Zaralek Cavern", sourceType = "Pet Journal Source" },
        Miloh = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Explorer Bezzert / Zone: Zaralek Cavern / Cost: 2500 / Vendor: Patchu / Zone: The Azure Span / Cost: 2500",
            sourceType = "Pet Journal Source",
        },
        ["Mote of Nasz'uro"] = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Treasure:Wayward Motes of Nasz'uro", sourceType = "Pet Journal Source" },
        Nelthara = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Quest: Augmenting a Dragon", sourceType = "Pet Journal Source" },
        Newsy = { acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.", source = "Quest: Signed, Sealed, Self-Delivered", sourceType = "Pet Journal Source" },
        Paulie = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 200",
            sourceType = "Pet Journal Source",
        },
        Puddlehopper = shared["Pet Battle: Zaralek Cavern"],
        Rango = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Harlowe Marl / Zone: Zaralek Cavern / Cost: 150",
            sourceType = "Pet Journal Source",
        },
        ["Ridged Shalewing"] = shared["Drop: Kob'rok / Zone: Zaralek Cavern"],
        ["Rock Martin"] = shared["Pet Battle: Zaralek Cavern"],
        Roggy = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: Slow and Steady Wins the Race / Category: Dragon Isles",
            sourceType = "Pet Journal Source",
        },
        Roland = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Achievement: The Gift of Cheese / Category: Cooking",
            sourceType = "Pet Journal Source",
        },
        Salverun = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Treasure: Ouroboros Tablet and Kob'rok's Luminescent Scale",
            sourceType = "Pet Journal Source",
        },
        Scarlapod = shared["Pet Battle: Zaralek Cavern"],
        Skaarn = shared["Drop: Kob'rok / Zone: Zaralek Cavern"],
        Slabwing = shared["Pet Battle: Zaralek Cavern"],
        Stonewhisker = shared["Pet Battle: Zaralek Cavern"],
        ["Sunglow Cobra"] = shared["Pet Battle: Zaralek Cavern"],
        ["Teardrop Moth"] = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Drop: Underlight Queen / Zone: Zaralek Cavern",
            sourceType = "Pet Journal Source",
        },
        Thimblerig = {
            acquisition = "Follow the in-game Pet Journal source for this permanent battle pet.",
            source = "Vendor: Ponzo / Zone: Zaralek Cavern / Cost: 45",
            sourceType = "Pet Journal Source",
        },
        Tricky = shared["Quest: A Race To The Finish / Zone: Zaralek Cavern"],
        Yellabon = shared["Pet Battle: Zaralek Cavern"],
    },
})
