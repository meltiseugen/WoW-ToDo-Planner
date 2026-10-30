local _, TDP = ...

local shared = {}
shared["Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Sto"] = {
    acquisition = "Obtain this mount from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge.",
    category = "Vendor",
    source = "Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge",
    sourceType = "Patch mount collection",
    tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
    waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
}

shared["Achievement: Two Sides to Every Tale"] = {
    acquisition = "Obtain this mount from the listed source: Achievement: Two Sides to Every Tale.",
    category = "Achievements",
    source = "Achievement: Two Sides to Every Tale",
    sourceType = "Patch mount collection",
    tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
}

TDP.CatalogRegistry:RegisterCollection("8.1.5", "mounts", {
    entries = {
        {
            acquisition = "Obtain this mount from the listed source: Achievement: Allied Races: Zandalari Troll.",
            category = "Achievements",
            name = "Zandalari Direhorn",
            source = "Achievement: Allied Races: Zandalari Troll",
            spellId = 263707,
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
        {
            acquisition = "Obtain this mount from the listed source: Achievement: Allied Races: Kul Tiran Human.",
            category = "Achievements",
            name = "Kul Tiran Charger",
            source = "Achievement: Allied Races: Kul Tiran Human",
            spellId = 282682,
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
        {
            acquisition = "Obtain this mount from the listed source: Quest: Complete the Brawler's Guild Questline.",
            category = "Quest Rewards",
            name = "Bruce",
            source = "Quest: Complete the Brawler's Guild Questline",
            spellId = 289639,
            tips = "Check the source prerequisite and loot lockout before starting the farm; use alts where the reward is character-lootable.",
        },
        {
            acquisition = "Unlock the Zandalari Troll allied race, then create a Zandalari Troll Paladin. Crusader's Direhorn is learned automatically at level 10 as that race and class mount.",
            category = "Other",
            name = "Crusader's Direhorn",
            source = "Zandalari Troll Paladin - automatic level 10 class ability",
            spellId = 290608,
            tips = "Only Zandalari Troll Paladins can summon this mount. No mount vendor, drop location or separate mount quest is required.",
            sourceType = "Automatic class mount",
            automaticUnlock = true,
            requirements = "Zandalari Troll Paladin, level 10",
        },
        {
            acquisition = "Obtain this mount from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge.",
            category = "Vendor",
            name = "Beastlord's Irontusk",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge",
            spellId = 294568,
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        {
            acquisition = "Obtain this mount from the listed source: Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge.",
            category = "Vendor",
            name = "Beastlord's Warwolf",
            source = "Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Stormshield / Cost: 5000Timewarped Badge",
            spellId = 294569,
            tips = "Confirm the reputation, currency, faction, and vendor phase before travelling; several Battle for Azeroth vendors have faction-equivalent locations.",
            waypoints = { "/way #624 65.0 62.0 Kronnus / Warlords Timewalking", "/way #622 37.0 72.0 Tempra / Warlords Timewalking" },
        },
        {
            acquisition = "Obtain this mount from the listed source: Achievement: Two Sides to Every Tale.",
            category = "Achievements",
            name = "Ironclad Frostclaw",
            source = "Achievement: Two Sides to Every Tale",
            spellId = 295386,
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
        {
            acquisition = "Obtain this mount from the listed source: Achievement: Two Sides to Every Tale.",
            category = "Achievements",
            name = "Bloodflank Charger",
            source = "Achievement: Two Sides to Every Tale",
            spellId = 295387,
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
    },
    details = {
        ["Beastlord's Irontusk"] = shared["Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Sto"],
        ["Beastlord's Warwolf"] = shared["Vendor: Kronnus / Zone: Warspear / Cost: 5000Timewarped Badge / Vendor: Tempra / Zone: Sto"],
        ["Bloodflank Charger"] = shared["Achievement: Two Sides to Every Tale"],
        Bruce = {
            acquisition = "Obtain this mount from the listed source: Quest: Complete the Brawler's Guild Questline.",
            category = "Quest Rewards",
            source = "Quest: Complete the Brawler's Guild Questline",
            sourceType = "Patch mount collection",
            tips = "Check the source prerequisite and loot lockout before starting the farm; use alts where the reward is character-lootable.",
        },
        ["Crusader's Direhorn"] = {
            acquisition = "Unlock the Zandalari Troll allied race, then create a Zandalari Troll Paladin. Crusader's Direhorn is learned automatically at level 10 as that race and class mount.",
            category = "Other",
            source = "Zandalari Troll Paladin - automatic level 10 class ability",
            sourceType = "Automatic class mount",
            tips = "Only Zandalari Troll Paladins can summon this mount. No mount vendor, drop location or separate mount quest is required.",
            automaticUnlock = true,
            requirements = "Zandalari Troll Paladin, level 10",
        },
        ["Ironclad Frostclaw"] = shared["Achievement: Two Sides to Every Tale"],
        ["Kul Tiran Charger"] = {
            acquisition = "Obtain this mount from the listed source: Achievement: Allied Races: Kul Tiran Human.",
            category = "Achievements",
            source = "Achievement: Allied Races: Kul Tiran Human",
            sourceType = "Patch mount collection",
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
        ["Zandalari Direhorn"] = {
            acquisition = "Obtain this mount from the listed source: Achievement: Allied Races: Zandalari Troll.",
            category = "Achievements",
            source = "Achievement: Allied Races: Zandalari Troll",
            sourceType = "Patch mount collection",
            tips = "Track the linked achievement criteria in advance; meta-achievements often combine faction, dungeon, raid, or collection requirements.",
        },
    },
})
