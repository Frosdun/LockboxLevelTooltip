--------------------------------------------------
-- LOCKBOX DATA
--------------------------------------------------

local LOCKBOX_DATA = {

    -- Lockboxes
    [4632]  = { orange=1, yellow=30, green=55, grey=100 },
    [4633]  = { orange=25, yellow=50, green=75, grey=125 },
    [4634]  = { orange=70, yellow=95, green=120, grey=170 },
    [4636]  = { orange=125, yellow=150, green=175, grey=225 },
    [4637]  = { orange=175, yellow=200, green=225, grey=275 },
    [4638]  = { orange=225, yellow=250, green=275, grey=325 },
    [5758]  = { orange=225, yellow=250, green=275, grey=325 },
    [5759]  = { orange=225, yellow=250, green=275, grey=325 },
    [5760]  = { orange=225, yellow=265, green=320, grey=375 },

    -- Junkboxes
    [16882] = { orange=1, yellow=30, green=75, grey=105 },
    [16883] = { orange=75, yellow=100, green=125, grey=175 },
    [16884] = { orange=175, yellow=200, green=225, grey=275 },
    [16885] = { orange=250, yellow=275, green=300, grey=350 },

    -- Fishing
    [6354]  = { orange=1 },
    [6355]  = { orange=70 },
    [13875] = { orange=175 },
    [13876] = { orange=250 },
}

--------------------------------------------------
-- ADD INFO
--------------------------------------------------

local function AddLockboxInfo(tooltip)

    local name, link = tooltip:GetItem()
    if not link then return end

    local itemID = tonumber(string.match(link,"item:(%d+)"))
    if not itemID then return end

    local data = LOCKBOX_DATA[itemID]
    if not data then return end

    -- prevent duplicates
    for i=1, tooltip:NumLines() do
        local line = _G["GameTooltipTextLeft"..i]
        if line and line:GetText()
        and string.find(line:GetText(),"Lockpicking Difficulty") then
            return
        end
    end

    tooltip:AddLine(" ")
    tooltip:AddLine("Lockpicking Difficulty:",1,0.82,0)

    if data.orange then tooltip:AddLine(data.orange,1,0.5,0) end
    if data.yellow then tooltip:AddLine(data.yellow,1,1,0) end
    if data.green then tooltip:AddLine(data.green,0,1,0) end
    if data.grey then tooltip:AddLine(data.grey,0.6,0.6,0.6) end

    tooltip:Show()
end

--------------------------------------------------
-- ✅ MODERN TURTLE WOW HOOK
--------------------------------------------------

GameTooltip:HookScript("OnTooltipSetItem", AddLockboxInfo)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddLockboxInfo)
