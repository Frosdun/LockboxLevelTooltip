-- LockboxLevelTooltip v2.6
-- Shows required lockpicking level for lockboxes

local LOCKBOX_DATA = {
    [4632]  = 1,    -- Ornate Bronze Lockbox
    [4633]  = 50,   -- Heavy Bronze Lockbox
    [4634]  = 70,   -- Iron Lockbox
    [4636]  = 125,  -- Strong Iron Lockbox
    [4637]  = 175,  -- Steel Lockbox
    [4638]  = 225,  -- Reinforced Steel Lockbox
    [5758]  = 250,  -- Mithril Lockbox
    [5759]  = 250,  -- Thorium Lockbox
    [5760]  = 275,  -- Eternium Lockbox
}

local function AddLockboxInfo(tooltip)
    local name, link = tooltip:GetItem()
    if not link then return end

    local itemID = tonumber(string.match(link, "item:(%d+)"))
    if not itemID then return end

    local req = LOCKBOX_DATA[itemID]
    if not req then return end

    tooltip:AddLine("Required Lockpicking: "..req, 1, 0.82, 0)
end

GameTooltip:HookScript("OnTooltipSetItem", function()
    AddLockboxInfo(GameTooltip)
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function()
    AddLockboxInfo(ItemRefTooltip)
end)
