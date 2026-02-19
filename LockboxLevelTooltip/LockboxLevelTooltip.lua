local LOCKBOX_DATA = {

    -- Lockboxes
    [4632] = { yellow=1, green=86, grey=105 },                 -- Ornate Bronze Lockbox
    [4633] = { orange=25, yellow=50, green=75, grey=125 },     -- Heavy Bronze Lockbox
    [4634] = { orange=70, yellow=95, green=120, grey=170 },    -- Iron Lockbox
    [4636] = { orange=125, yellow=150, green=175, grey=225 },  -- Strong Iron Lockbox
    [4637] = { orange=175, yellow=205, green=225, grey=275 },  -- Steel Lockbox
    [4638] = { orange=225, yellow=250, green=275 },            -- Reinforced Steel Lockbox
    [5758] = { orange=225, yellow=250, green=275 },            -- Mithril Lockbox
    [5759] = { orange=225, yellow=250, green=275 },            -- Thorium Lockbox
    [5760] = { orange=225, yellow=265, green=320 },            -- Eternium Lockbox (Turtle)

    -- Fishing Locked Chests
    [6354]  = { orange=1 },                                    -- Small Locked Chest
    [6355]  = { orange=70 },                                   -- Sturdy Locked Chest
    [13875] = { orange=175 },                                  -- Ironbound Locked Chest
    [13876] = { orange=250, green=300 },                       -- Reinforced Locked Chest (verify ID if needed)
}

local function AddLockboxInfo(tooltip, link)
    if not link then return end

    local itemID = string.match(link, "item:(%d+)")
    if not itemID then return end

    itemID = tonumber(itemID)

    local data = LOCKBOX_DATA[itemID]
    if not data then return end

    tooltip:AddLine(" ")
    tooltip:AddLine("Lockpicking Difficulty:")

    if data.orange then
        tooltip:AddLine(data.orange, 1, 0.5, 0) -- orange
    end

    if data.yellow then
        tooltip:AddLine(data.yellow, 1, 1, 0) -- yellow
    end

    if data.green then
        tooltip:AddLine(data.green, 0, 1, 0) -- green
    end

    if data.grey then
        tooltip:AddLine(data.grey, 0.6, 0.6, 0.6) -- grey
    end

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




