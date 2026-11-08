-- Retail rated PvP, reviewed 2026-11-04. Each rank and victory page's comments
-- were read. Current achievement records explicitly allow Blitz for RATING
-- titles; 2026 comments still exclude Blitz from the old VICTORY counters.
local _,TDP=...
local guides=TDP.CollectionWalkthroughs.achievements
local function add(id,name,difficulty,reason,faction,steps,comments)
    local lines={"Difficulty: "..difficulty:gsub("^%l",string.upper).." - "..reason}
    local sources={}
    for i,s in ipairs(steps) do lines[#lines+1]=i..". "..s end
    for _,c in ipairs(comments or {}) do sources[#sources+1]=type(c)=="number" and ("https://www.wowhead.com/achievement="..id.."#comments:id="..c) or c end
    guides[id]={achievementId=id,name=name,category="PvP",sourceType="Achievement",source=name,
        faction=faction,difficulty=difficulty,difficultyReason=reason,stepCount=#steps,
        acquisition=table.concat(lines,"\n\n"),sources=sources,waypoints={},
        wowheadUrl="https://www.wowhead.com/achievement="..id,sourceURL="https://www.wowhead.com/achievement="..id.."#comments",
        tips="This is a queue-based competitive objective with no fixed world destination. An unrelated city or vendor pin would not identify its acquisition location."}
end

-- Factions were checked in the current Achievement table. Numeric ordering is
-- misleading: 5338 and 5342 are Horde; 5357 and 5359 are Alliance.
local ranks={
    {5330,"Private",1100,"Alliance"},{5331,"Corporal",1200,"Alliance"},
    {5332,"Sergeant",1300,"Alliance"},{5333,"Master Sergeant",1400,"Alliance"},
    {5334,"Sergeant Major",1500,"Alliance"},{5335,"Knight",1600,"Alliance"},
    {5336,"Knight-Lieutenant",1700,"Alliance"},{5337,"Knight-Captain",1800,"Alliance"},
    {5359,"Knight-Champion",1900,"Alliance"},{5339,"Lieutenant Commander",2000,"Alliance"},
    {5340,"Commander",2100,"Alliance"},{5341,"Marshal",2200,"Alliance"},
    {5357,"Field Marshal",2300,"Alliance"},{5343,"Grand Marshal",2400,"Alliance"},
    {5345,"Scout",1100,"Horde"},{5346,"Grunt",1200,"Horde"},
    {5347,"Sergeant",1300,"Horde"},{5348,"Senior Sergeant",1400,"Horde"},
    {5349,"First Sergeant",1500,"Horde"},{5350,"Stone Guard",1600,"Horde"},
    {5351,"Blood Guard",1700,"Horde"},{5352,"Legionnaire",1800,"Horde"},
    {5338,"Centurion",1900,"Horde"},{5353,"Champion",2000,"Horde"},
    {5354,"Lieutenant General",2100,"Horde"},{5355,"General",2200,"Horde"},
    {5342,"Warlord",2300,"Horde"},{5356,"High Warlord",2400,"Horde"},
}
for _,r in ipairs(ranks) do
    local difficulty=r[3]>=1800 and "hard" or "medium"
    add(r[1],r[2],difficulty,"Requires reaching "..r[3].." personal rating in a competitive battleground bracket.",r[4],{
        "Use an "..r[4].." character and track "..r[2]..". Prepare current PvP gear, a working PvP talent setup, interrupt and crowd-control keybinds, and the current rated-queue eligibility shown by the PvP panel. This is the Retail rated title, not the retired original Honor-rank feat.",
        "Choose either Rated Battlegrounds with an organized team or Rated Battleground Blitz through its rated queue. The CURRENT rating achievement accepts either bracket. Random battlegrounds, unranked brawls, skirmishes and arena rating do not provide this battleground title.",
        "Win objective-focused games until the selected bracket's PERSONAL rating reaches "..r[3]..". Call incoming attacks early, coordinate crowd control with your team and prioritize flags or bases over unrelated damage. Matchmaking rating, Honor level and Conquest currency totals are different values and do not replace the displayed personal rating.",
        "Check achievement credit as soon as "..r[3].." rating is reached, then select "..r[2].." in your character title list if desired. Do not wait for a Cataclysm-season ending: this rating title remains obtainable, while the removed Vicious/Ruthless/Cataclysmic season awards were separate achievements.",
    },r[1]==5330 and {2870876} or {})
end

local victories={
    {5268,"In Service of the Alliance",1,"Alliance",{5953717}},
    {5269,"In Service of the Horde",1,"Horde",{6105411}},
    {5322,"In Service of the Alliance",10,"Alliance",{}},
    {5323,"In Service of the Horde",10,"Horde",{1358504}},
    {5327,"In Service of the Alliance",25,"Alliance",{}},
    {5324,"In Service of the Horde",25,"Horde",{1358516}},
    {5328,"Veteran of the Alliance",75,"Alliance",{5954195,6366328}},
    {5325,"Veteran of the Horde",75,"Horde",{5444869,5916701,6261424}},
    {5823,"Veteran of the Alliance II",150,"Alliance",{2880723}},
    {5824,"Veteran of the Horde II",150,"Horde",{2572051}},
    {5329,"Warbound Veteran of the Alliance",300,"Alliance",{5907143,5998002,6051849}},
    {5326,"Warbringer of the Horde",300,"Horde",{6022238}},
}
for _,r in ipairs(victories) do
    local comments={}
    for _,c in ipairs(r[5]) do comments[#comments+1]=c end
    comments[#comments+1]="https://www.wowhead.com/achievement=5328#comments:id=6366328"
    add(r[1],r[2],r[3]>=75 and "hard" or "medium","Win "..r[3].." eligible organized rated battleground"..(r[3]==1 and "." or "s; long milestones require sustained team participation."),r[4],{
        "Choose an "..r[4].." character, track the "..r[3].."-victory version of "..r[2].." and note its current counter. Keep the character whose unfinished counter you are progressing; do not assume separate incomplete character counters combine.",
        "Join or form an organized Rated Battleground team and use the traditional rated battleground queue. The old victory achievements still have recent reports of NO credit from Rated Battleground Blitz, including June 2026 confirmations. Blitz eligibility for rating titles does not establish eligibility for these win counters.",
        "Complete and WIN matches, playing the map's objectives with the team. A loss, an ordinary random-battleground win or simply reaching a rating threshold does not add the required rated victory. After the first win, inspect the tracked counter to confirm you are in the correct mode before committing to the long milestone.",
        "Continue until "..r[3].." eligible victories are credited. There is no requirement to recreate an old Cataclysm season. For the 75-, 150- and 300-win rewards, inspect the actual achievement reward and mailbox afterward: later comments describe Vicious Saddles and occasional delivery bugs, so do not expect the old duplicate mount automatically in your bags.",
    },comments)
end
