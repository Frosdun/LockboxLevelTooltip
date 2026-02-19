--------------------------------------------------
---------------- LOCKPICKING DATA ----------------
--------------------------------------------------
local LOCKBOX_DATA = {
    -- Lockboxes & Fishing Chests
    [4632] = { yellow=1, green=86, grey=105 },
    [4633] = { orange=25, yellow=50, green=75, grey=125 },
    [4634] = { orange=70, yellow=95, green=120, grey=170 },
    [4636] = { orange=125, yellow=150, green=175, grey=225 },
    [4637] = { orange=175, yellow=205, green=225, grey=275 },
    [4638] = { orange=225, yellow=250, green=275 },
    [5758] = { orange=225, yellow=250, green=275 },
    [5759] = { orange=225, yellow=250, green=275 },
    [5760] = { orange=225, yellow=265, green=320 },
    [6354]  = { orange=1 },
    [6355]  = { orange=70 },
    [13875] = { orange=175 },
    [13876] = { orange=250, green=300 },
    -- Junkboxes
    [16882] = { orange=1,   yellow=25,  green=50,  grey=75 },
    [16883] = { orange=70,  yellow=95,  green=120, grey=170 },
    [16884] = { orange=175, yellow=200, green=225, grey=275 },
    [16885] = { orange=250, yellow=275, green=300 },
}

local FOOTLOCKERS = {
    ["Battered Footlocker"] = { orange=110, yellow=135, green=160, grey=170 },
    ["Waterlogged Footlocker"] = { orange=70, yellow=95, green=120, grey=150 },
    ["Dented Footlocker"] = { orange=175, yellow=200, green=225 },
    ["Mossy Footlocker"] = { orange=175, yellow=200, green=225, grey=250 },
    ["Scarlet Footlocker"] = { orange=250, yellow=275, green=300 },
    ["Practice Lockbox"] = { orange=1, yellow=30, green=55, grey=100 },
    ["Buccaneer's Strongbox"] = { orange=1, yellow=30, green=55, grey=105 },
}

--------------------------------------------------
-- DISPLAY ENGINE
--------------------------------------------------
local function AddDifficultyLines(tooltip, data)
    -- Prevent duplicates
    for i = 1, tooltip:NumLines() do
        local line = _G[tooltip:GetName().."TextLeft"..i]
        if line and line:GetText() and string.find(line:GetText(), "Lockpicking") then return end
    end

    tooltip:AddLine(" ")
    tooltip:AddLine("Lockpicking Difficulty:", 1, 1, 1)
    if data.orange then tooltip:AddLine("Required: "..data.orange, 1, 0.5, 0) end
    if data.yellow then tooltip:AddLine("Yellow: "..data.yellow, 1, 1, 0) end
    if data.green  then tooltip:AddLine("Green: "..data.green, 0, 1, 0) end
    if data.grey   then tooltip:AddLine("Grey: "..data.grey, 0.6, 0.6, 0.6) end
    tooltip:Show()
end

--------------------------------------------------
-- HOOKS
--------------------------------------------------

-- Hook for all Items (Bags, Bank, Links)
GameTooltip:HookScript("OnTooltipSetItem", function(self)
    local _, link = self:GetItem()
    if not link then return end
    local itemID = tonumber(string.match(link, "item:(%d+)"))
    if itemID and LOCKBOX_DATA[itemID] then
        AddDifficultyLines(self, LOCKBOX_DATA[itemID])
    end
end)

-- Hook for World Objects (Footlockers)
GameTooltip:HookScript("OnUpdate", function(self)
    if not self:IsShown() then return end
    local nameLine = _G[self:GetName().."TextLeft1"]
    if not nameLine then return end
    local data = FOOTLOCKERS[nameLine:GetText()]
    if data then
        AddDifficultyLines(self, data)
    end
end)
