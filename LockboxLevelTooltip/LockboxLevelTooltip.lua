--------------------------------------------------
-- ITEM LOCKBOX DATA
--------------------------------------------------

local LOCKBOX_DATA = {

    -- Lockboxes
    [4632] = { yellow=1, green=86, grey=105 },
    [4633] = { orange=25, yellow=50, green=75, grey=125 },
    [4634] = { orange=70, yellow=95, green=120, grey=170 },
    [4636] = { orange=125, yellow=150, green=175, grey=225 },
    [4637] = { orange=175, yellow=205, green=225, grey=275 },
    [4638] = { orange=225, yellow=250, green=275 },
    [5758] = { orange=225, yellow=250, green=275 },
    [5759] = { orange=225, yellow=250, green=275 },
    [5760] = { orange=225, yellow=265, green=320 },

    -- Fishing Locked Chests
    [6354]  = { orange=1 },
    [6355]  = { orange=70 },
    [13875] = { orange=175 },
    [13876] = { orange=250, green=300 },
}

--------------------------------------------------
-- FOOTLOCKERS (ZONE BASED)
--------------------------------------------------

local FOOTLOCKER_ZONE_DATA = {

    ["Ashenvale"] = {
        ["Waterlogged Footlocker"] = { orange=70, yellow=95, green=120, grey=150 },
    },

    ["Azshara"] = {
        ["Mossy Footlocker"] = { orange=225, yellow=250 },
    },

    ["Badlands"] = {
        ["Dented Footlocker"] = { orange=175, yellow=200, green=225 },
    },

    ["Desolace"] = {
        ["Waterlogged Footlocker"] = { orange=150, yellow=175, green=200 },
        ["Mossy Footlocker"]       = { orange=175, yellow=200, green=225, grey=250 },
    },

    ["Eastern Plaguelands"] = {
        ["Scarlet Footlocker"] = { orange=250, yellow=275, green=300 },
    },

    ["Hillsbrad Foothills"] = {
        ["Battered Footlocker"] = { orange=110, yellow=135, green=160, grey=170 },
    },

    ["Redridge Mountains"] = {
        ["Practice Lockboxes"]     = { orange=1, yellow=30, green=55, grey=100 },
        ["Waterlogged Footlocker"] = { orange=70, yellow=95, green=120, grey=150 },
    },

    ["Searing Gorge"] = {
        ["Dented Footlocker"] = { orange=200, yellow=225, green=250, grey=300 },
    },

    ["Stonetalon Mountains"] = {
        ["Battered Footlocker"] = { orange=110, yellow=135, green=160 },
    },

    ["Swamp of Sorrows"] = {
        ["Mossy Footlocker"] = { orange=175, yellow=200, green=225 },
    },

    ["Tanaris"] = {
        ["Dented Footlocker"] = { orange=225, yellow=250, green=275 },
    },

    ["The Barrens"] = {
        ["Buccaneer's Strongbox"]    = { orange=1, yellow=30, green=55, grey=105 },
        ["The Jewel of the Southsea"] = { orange=25, yellow=82, green=75, grey=125 },
    },

    ["Wetlands"] = {
        ["Battered Footlocker"] = { orange=70, yellow=95, green=120, grey=170 },
    },
}

--------------------------------------------------
-- SHARED DISPLAY FUNCTION
--------------------------------------------------

local function AddDifficultyLines(tooltip, data)

    tooltip:AddLine(" ")
    tooltip:AddLine("Lockpicking Difficulty:")

    if data.orange then
        tooltip:AddLine(data.orange, 1, 0.5, 0)
    end
    if data.yellow then
        tooltip:AddLine(data.yellow, 1, 1, 0)
    end
    if data.green then
        tooltip:AddLine(data.green, 0, 1, 0)
    end
    if data.grey then
        tooltip:AddLine(data.grey, 0.6, 0.6, 0.6)
    end

    tooltip:Show()
end

--------------------------------------------------
-- ITEM TOOLTIP HANDLER
--------------------------------------------------

local function AddLockboxInfo(tooltip, link)
    if not link then return end

    local itemID = string.match(link, "item:(%d+)")
    if not itemID then return end

    itemID = tonumber(itemID)

    local data = LOCKBOX_DATA[itemID]
    if not data then return end

    AddDifficultyLines(tooltip, data)
end

--------------------------------------------------
-- GAMEOBJECT (FOOTLOCKER) HANDLER
--------------------------------------------------

GameTooltip:HookScript("OnShow", function(self)

    local name = self:GetText()
    if not name then return end

    local zone = GetRealZoneText()
    if not zone then return end

    local zoneData = FOOTLOCKER_ZONE_DATA[zone]
    if not zoneData then return end

    local data = zoneData[name]
    if not data then return end

    -- prevent duplicate lines
    for i = 1, self:NumLines() do
        local line = _G[self:GetName().."TextLeft"..i]
        if line and line:GetText() and string.find(line:GetText(), "Lockpicking Difficulty:") then
            return
        end
    end

    AddDifficultyLines(self, data)
end)

--------------------------------------------------
-- HOOK ITEM TOOLTIPS
--------------------------------------------------

local orig_GameTooltip_SetHyperlink = GameTooltip.SetHyperlink
GameTooltip.SetHyperlink = function(self, link)
    orig_GameTooltip_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

local orig_ItemRefTooltip_SetHyperlink = ItemRefTooltip.SetHyperlink
ItemRefTooltip.SetHyperlink = function(self, link)
    orig_ItemRefTooltip_SetHyperlink(self, link)
    AddLockboxInfo(self, link)
end

