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

    -- Junkboxes
    [16882] = { orange=1, yellow=30, green=75, grey=105 },
    [16883] = { orange=75, yellow=100, green=125, grey=175 },
    [16884] = { orange=175, yellow=200, green=225, grey=275 },
    [16885] = { orange=250, yellow=275, green=300, grey=350 },
}

local function AddLockboxInfo()

    local name, link = GameTooltip:GetItem()
    if not link then return end

    local itemID = tonumber(string.match(link, "item:(%d+)"))
    if not itemID then return end

    local data = LOCKBOX_DATA[itemID]
    if not data then return end

    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Lockpicking Difficulty:")

    if data.orange then
        GameTooltip:AddLine(data.orange,1,0.5,0)
    end

    if data.yellow then
        GameTooltip:AddLine(data.yellow,1,1,0)
    end

    if data.green then
        GameTooltip:AddLine(data.green,0,1,0)
    end

    if data.grey then
        GameTooltip:AddLine(data.grey,0.6,0.6,0.6)
    end

    GameTooltip:Show()
end

--------------------------------------------------
-- Hook after login
--------------------------------------------------

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function()

    GameTooltip:HookScript("OnTooltipSetItem", AddLockboxInfo)

end)
