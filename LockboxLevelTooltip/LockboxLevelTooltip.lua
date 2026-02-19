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

    -- Fishing Chests
    [6354]  = { orange=1 },
    [6355]  = { orange=70 },
    [13875] = { orange=175 },
    [13876] = { orange=250, green=300 },

    -- Junkboxes (Pickpocket)
[16882] = { orange=1,   yellow=25,  green=50,  grey=75 },   -- Battered Junkbox
[16883] = { orange=70,  yellow=95,  green=120, grey=170 },  -- Worn Junkbox
[16884] = { orange=175, yellow=200, green=225, grey=275 },  -- Sturdy Junkbox
[16885] = { orange=250, yellow=275, green=300 },            -- Heavy Junkbox

}

--------------------------------------------------
-- FOOTLOCKERS (GAMEOBJECTS)
--------------------------------------------------

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
-- DISPLAY FUNCTION
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
-- ITEM HANDLER (UNCHANGED 2.0 CORE)
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
-- ORIGINAL SAFE HOOKS
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

--------------------------------------------------
-- FOOTLOCKER TOOLTIP HOOK (SAFE)
--------------------------------------------------

GameTooltip:HookScript("OnUpdate", function(self)

    if not self:IsShown() then return end

    local name = GameTooltipTextLeft1
    if not name then return end

    local text = name:GetText()
    if not text then return end

    local data = FOOTLOCKERS[text]
    if not data then return end

    -- prevent duplicates
    for i=1,self:NumLines() do
        local line=_G["GameTooltipTextLeft"..i]
        if line and line:GetText()
        and string.find(line:GetText(),"Lockpicking Difficulty") then
            return
        end
    end

    AddDifficultyLines(self, data)

end)




