local LOCKBOX_LEVELS = {
    [4632] = 100, -- Ornate Bronze Lockbox
    [4633] = 125, -- Heavy Bronze Lockbox
    [4634] = 150, -- Iron Lockbox
    [4636] = 175, -- Strong Iron Lockbox
    [4637] = 200, -- Steel Lockbox
    [4638] = 225, -- Reinforced Steel Lockbox
    [5758] = 250, -- Mithril Lockbox
    [5759] = 275, -- Thorium Lockbox
    [5760] = 300, -- Eternium Lockbox
}

local function AddLockboxInfo(tooltip, link)
    if not link then return end

    local itemID = string.match(link, "item:(%d+)")
    if not itemID then return end

    itemID = tonumber(itemID)

    local required = LOCKBOX_LEVELS[itemID]
    if not required then return end

    tooltip:AddLine(" ")
    tooltip:AddLine("Required Lockpicking: " .. required, 1, 0.82, 0)
    tooltip:Show()
end

-- Hook GameTooltip (bags, inventory, etc.)
local orig_GameTooltip_SetHyperlink = GameTooltip.SetHyperlink
GameTooltip.SetHyperlink = function(self, link)
    orig_GameTooltip_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

-- Hook ItemRefTooltip (chat links)
local orig_ItemRefTooltip_SetHyperlink = ItemRefTooltip.SetHyperlink
ItemRefTooltip.SetHyperlink = function(self, link)
    orig_ItemRefTooltip_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

