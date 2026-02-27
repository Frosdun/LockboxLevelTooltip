-- Addon: LockboxLevelTooltip v2.1
-- Purpose: Shows Lockpicking requirements on tooltips for Lockboxes and Junkboxes

local LOCKBOX_DATA = {
    -- Lockboxes (World Drops)
    [4632]  = { orange=1,   yellow=30,  green=55,  grey=100 }, -- Ornate Bronze
    [4633]  = { orange=25,  yellow=50,  green=75,  grey=125 }, -- Heavy Bronze
    [4634]  = { orange=70,  yellow=95,  green=120, grey=170 }, -- Iron Lockbox
    [4636]  = { orange=125, yellow=150, green=175, grey=225 }, -- Strong Iron
    [4637]  = { orange=175, yellow=200, green=225, grey=275 }, -- Steel Lockbox
    [4638]  = { orange=225, yellow=250, green=275, grey=325 }, -- Reinforced Steel
    [5758]  = { orange=225, yellow=250, green=275, grey=325 }, -- Mithril Lockbox
    [5759]  = { orange=225, yellow=250, green=275, grey=325 }, -- Thorium Lockbox
    [5760]  = { orange=225, yellow=265, green=320, grey=375 }, -- Eternium Lockbox

    -- Junkboxes (Pickpocketing)
    [16882] = { orange=1,   yellow=30,  green=75,  grey=105 }, -- Battered Junkbox
    [16883] = { orange=75,  yellow=100, green=125, grey=175 }, -- Worn Junkbox
    [16884] = { orange=175, yellow=200, green=225, grey=275 }, -- Sturdy Junkbox
    [16885] = { orange=250, yellow=275, green=300, grey=350 }, -- Heavy Junkbox

    -- Fishing Locked Chests
    [6354]  = { orange=1 },                                    -- Small Locked Chest
    [6355]  = { orange=70 },                                   -- Sturdy Locked Chest
    [13875] = { orange=175 },                                  -- Ironbound Locked Chest
    [13876] = { orange=250 },                                  -- Reinforced Locked Chest
}

local function AddLockboxInfo(tooltip, link)
    if not link then return end
    
    local _, _, itemID = string.find(link, "item:(%d+)")
    if not itemID then return end
    
    local data = LOCKBOX_DATA[tonumber(itemID)]
    if not data then return end

    tooltip:AddLine(" ") -- Spacer
    tooltip:AddLine("Lockpicking Difficulty:", 1, 0.82, 0) -- Gold title

	if data.orange then tooltip:AddLine(tostring(data.orange), 1, 0.5, 0) end
	if data.yellow then tooltip:AddLine(tostring(data.yellow), 1, 1, 0) end
	if data.green  then tooltip:AddLine(tostring(data.green),  0, 1, 0) end
	if data.grey   then tooltip:AddLine(tostring(data.grey),   0.6, 0.6, 0.6) end


    tooltip:Show()
end

-- HOOKS --

-- 1. Bags (Backpack/Bank Bags)
local orig_SetBagItem = GameTooltip.SetBagItem
GameTooltip.SetBagItem = function(self, container, slot)
    orig_SetBagItem(self, container, slot)
    local link = GetContainerItemLink(container, slot)
    AddLockboxInfo(self, link)
end

-- 2. Inventory (Equipped/Bank Main)
local orig_SetInventoryItem = GameTooltip.SetInventoryItem
GameTooltip.SetInventoryItem = function(self, unit, slot)
    orig_SetInventoryItem(self, unit, slot)
    local link = GetInventoryItemLink(unit, slot)
    AddLockboxInfo(self, link)
end

-- 3. Chat Hyperlinks (Hovering chat links)
local orig_SetHyperlink = GameTooltip.SetHyperlink
GameTooltip.SetHyperlink = function(self, link)
    orig_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

-- 4. Clicked Chat Hyperlinks (The pop-up window)
local orig_ItemRef_SetHyperlink = ItemRefTooltip.SetHyperlink
ItemRefTooltip.SetHyperlink = function(self, link)
    orig_ItemRef_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

