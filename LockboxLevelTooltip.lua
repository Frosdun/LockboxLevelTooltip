--------------------------------------------------
-- LOCKBOX DATA (BY NAME)
--------------------------------------------------

local LOCKBOX_NAMES = {

    ["Ornate Bronze Lockbox"] = {1,30,55,100},
    ["Heavy Bronze Lockbox"]  = {25,50,75,125},
    ["Iron Lockbox"]          = {70,95,120,170},
    ["Strong Iron Lockbox"]   = {125,150,175,225},
    ["Steel Lockbox"]         = {175,200,225,275},
    ["Reinforced Steel Lockbox"] = {225,250,275,325},
    ["Mithril Lockbox"]       = {225,250,275,325},
    ["Thorium Lockbox"]       = {225,250,275,325},
    ["Eternium Lockbox"]      = {225,265,320,375},

    ["Battered Junkbox"] = {1,30,75,105},
    ["Worn Junkbox"]     = {75,100,125,175},
    ["Sturdy Junkbox"]   = {175,200,225,275},
    ["Heavy Junkbox"]    = {250,275,300,350},
}

--------------------------------------------------
-- TOOLTIP SCANNER
--------------------------------------------------

GameTooltip:HookScript("OnUpdate", function(self)

    if not self:IsShown() then return end

    local title = _G["GameTooltipTextLeft1"]
    if not title then return end

    local name = title:GetText()
    if not name then return end

    local data = LOCKBOX_NAMES[name]
    if not data then return end

    -- prevent duplicate spam
    for i=1,self:NumLines() do
        local line = _G["GameTooltipTextLeft"..i]
        if line and line:GetText()
        and string.find(line:GetText(),"Lockpicking Difficulty") then
            return
        end
    end

    self:AddLine(" ")
    self:AddLine("Lockpicking Difficulty:",1,0.82,0)

    self:AddLine(data[1],1,0.5,0)
    self:AddLine(data[2],1,1,0)
    self:AddLine(data[3],0,1,0)
    self:AddLine(data[4],0.6,0.6,0.6)

    self:Show()

end)
