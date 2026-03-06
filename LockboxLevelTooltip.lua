-- LockboxLevelTooltip v2.6
-- Shows required lockpicking level for lockboxes

local LOCKBOX_DATA = {
    [4632] = 1,    -- Ornate Bronze Lockbox
    [4633] = 50,   -- Heavy Bronze Lockbox
    [4634] = 70,   -- Iron Lockbox
    [4636] = 125,  -- Strong Iron Lockbox
    [4637] = 175,  -- Steel Lockbox
    [4638] = 225,  -- Reinforced Steel Lockbox
    [5758] = 225,  -- Mithril Lockbox
    [5759] = 250,  -- Thorium Lockbox
    [5760] = 275,  -- Eternium Lockbox
}

local function AddLockboxInfo(self)
    if not self then return end

    local name, link = self:GetItem()
    if not link then return end

    local itemID = tonumber(string.match(link, "item:(%d+):"))
    if not itemID then return end

    local level = LOCKBOX_DATA[itemID]
    if not level then return end

    self:AddLine("Required Lockpicking: "..level, 1, 0.82, 0)
end

-- Safe hooking after UI loads
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function()

    if GameTooltip then
        GameTooltip:HookScript("OnTooltipSetItem", AddLockboxInfo)
    end

    if ItemRefTooltip then
        ItemRefTooltip:HookScript("OnTooltipSetItem", AddLockboxInfo)
    end

end)
