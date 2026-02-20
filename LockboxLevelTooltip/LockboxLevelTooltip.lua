--------------------------------------------------
-- LOCKPICKING TOOLTIP - TURTLE WOW
--------------------------------------------------

local ADDON_NAME = ...

local frame = CreateFrame("Frame")

--------------------------------------------------
-- LOCKBOX DATA (ITEMS)
--------------------------------------------------

local LOCKBOX_DATA = {

    ["Practice Lockbox"]        = {1, 30, 55, 100},
    ["Ornate Bronze Lockbox"]   = {25, 70, 125, 175},
    ["Strong Iron Lockbox"]     = {70, 125, 175, 225},
    ["Steel Lockbox"]           = {125, 175, 225, 275},
    ["Reinforced Steel Lockbox"]= {175, 225, 275, 325},
    ["Mithril Lockbox"]         = {225, 250, 275, 325},
    ["Thorium Lockbox"]         = {250, 275, 300, 350},
    ["Eternium Lockbox"]        = {300, 325, 350, 400},
}

--------------------------------------------------
-- FOOTLOCKER DATA (WORLD OBJECTS)
--------------------------------------------------

local FOOTLOCKER_DATA = {

    ["Battered Footlocker"]   = { orange=110, yellow=135, green=160, grey=170 },
    ["Waterlogged Footlocker"]= { orange=70,  yellow=95,  green=120, grey=150 },
    ["Dented Footlocker"]     = { orange=175, yellow=200, green=225 },
    ["Mossy Footlocker"]      = { orange=175, yellow=200, green=225, grey=250 },
    ["Scarlet Footlocker"]    = { orange=250, yellow=275, green=300 },
}

--------------------------------------------------
-- ADD LOCKPICK INFO (ITEM TOOLTIP)
--------------------------------------------------

local function AddLockpickInfo(tooltip, name)

    local data = LOCKBOX_DATA[name]
    if not data then return end

    for i=1, tooltip:NumLines() do
        local line = _G[tooltip:GetName().."TextLeft"..i]
        if line and line:GetText()
        and string.find(line:GetText(),"Lockpicking Difficulty") then
            return
        end
    end

    tooltip:AddLine(" ")
    tooltip:AddLine("Lockpicking Difficulty:")

    tooltip:AddLine(data[1],1,0.5,0)
    tooltip:AddLine(data[2],1,1,0)
    tooltip:AddLine(data[3],0,1,0)
    tooltip:AddLine(data[4],0.6,0.6,0.6)
end

--------------------------------------------------
-- ITEM TOOLTIP HOOKS
--------------------------------------------------

GameTooltip:HookScript("OnTooltipSetItem", function(self)

    local _, link = self:GetItem()
    if not link then return end

    local name = GetItemInfo(link)
    if not name then return end

    AddLockpickInfo(self, name)
    self:Show()
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function(self)

    local _, link = self:GetItem()
    if not link then return end

    local name = GetItemInfo(link)
    if not name then return end

    AddLockpickInfo(self, name)
    self:Show()
end)

--------------------------------------------------
-- FOOTLOCKER TOOLTIP FIX (WORLD OBJECTS)
--------------------------------------------------

local original_SetText = GameTooltip.SetText

GameTooltip.SetText = function(self, text, r, g, b, a, wrap)

    original_SetText(self, text, r, g, b, a, wrap)

    local data = FOOTLOCKER_DATA[text]
    if not data then return end

    for i=1, self:NumLines() do
        local line = _G[self:GetName().."TextLeft"..i]
        if line and line:GetText()
        and string.find(line:GetText(),"Lockpicking Difficulty") then
            return
        end
    end

    self:AddLine(" ")
    self:AddLine("Lockpicking Difficulty:")

    if data.orange then
        self:AddLine(data.orange,1,0.5,0)
    end
    if data.yellow then
        self:AddLine(data.yellow,1,1,0)
    end
    if data.green then
        self:AddLine(data.green,0,1,0)
    end
    if data.grey then
        self:AddLine(data.grey,0.6,0.6,0.6)
    end

    self:Show()
end
