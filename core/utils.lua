local _, GW = ...

if UnitIsTapDenied == nil then
    function UnitIsTapDenied()
        if (UnitIsTapped("target")) and (not UnitIsTappedByPlayer("target")) then
            return true
        end
        return false
    end
end

local function IsIn(val, ...)
    for i = 1, select("#", ...) do
        if val == select(i, ...) then return true end
    end
    return false
end
GW.IsIn = IsIn

local function CountTable(T)
    local c = 0
    if T ~= nil and type(T) == "table" then
        for _ in pairs(T) do
            c = c + 1
        end
    end
    return c
end
GW.CountTable = CountTable

local function MapTable(T, fn, withKey)
    local t = {}
    for k,v in pairs(T) do
        if withKey then
            t[k] = fn(v, k)
        else
            t[k] = fn(v)
        end
    end
    return t
end
GW.MapTable = MapTable

local function FillTable(T, map, ...)
    wipe(T)
    for i=1,select("#", ...) do
        local v = select(i, ...)
        if map then
            T[v] = true
        else
            tinsert(T, v)
        end
    end
    return T
end
GW.FillTable = FillTable

local function TimeParts(ms)
    local nMS = tonumber(ms)
    local nSec, nMin, nHr
    if nMS == nil then
        nMS = 0
    end

    nHr = math.floor(nMS / 1440000)
    nMS = nMS - (nHr * 1440000)

    nMin = math.floor(nMS / 60000)
    nMS = nMS - (nMin * 60000)

    nSec = math.floor(nMS / 1000)
    nMS = nMS - (nSec * 1000)

    return nHr, nMin, nSec, nMS
end
GW.TimeParts = TimeParts

local function TimeCount(numSec, com)
    local nSeconds = tonumber(numSec)
    if nSeconds == nil then
        nSeconds = 0
    end
    if nSeconds == 0 then
        return "0"
    end

    local nHours = math.floor(nSeconds / 3600)
    if nHours > 0 then
        return nHours .. "h"
    end

    local nMins = math.floor(nSeconds / 60)
    if nMins > 0 then
        return nMins .. "m"
    end

    if com ~= nil then
        local nMilsecs = math.max(math.floor((nSeconds * 10 ^ 1) + 0.5) / (10 ^ 1), 0)
        return nMilsecs .. "s"
    end

    local nSecs = math.max(math.floor(nSeconds), 0)
    return nSecs .. "s"
end
GW.TimeCount = TimeCount

local function RoundDec(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end
GW.RoundDec = RoundDec

local function CommaValue(n)
    n = RoundDec(n)
    local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
    return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
end
GW.CommaValue = CommaValue

local function RoundInt(v)
    if v == nil then
        return 0
    end
    vf = math.floor(v)
    if (v - vf) > 0.5 then
        return vf + 1
    end
    return vf
end
GW.RoundInt = RoundInt

local function Diff(a, b)
    if a == nil then
        a = 0
    end
    if b == nil then
        b = 0
    end

    if a > b then
        return a - b
    else
        return b - a
    end
end
GW.Diff = Diff

local function lerp(v0, v1, t)
    if v0 == nil then
        v0 = 0
    end
    local p = (v1 - v0)
    return v0 + t * p
end
GW.lerp = lerp

local function Length(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end
GW.Length = Length

local function SplitString(inputstr, sep, sep2, sep3)
    if sep == nil then
        sep = "%s"
    end
    inputstr = inputstr:gsub("\n", "")
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "|" .. sep2 .. "|" .. sep3 .. "]+)") do
        st, en, cap1, cap2, cap3 = string.find(inputstr, str)
        if en ~= nil then
            s = string.sub(inputstr, en + 1, en + 1)
            if s ~= nil or s ~= "" then
                str = str .. s
            end
        end
        t[i] = str
        i = i + 1
    end
    return t
end
GW.SplitString = SplitString

local function FindInList(list, str, i, del)
    local del = "([^%s" .. (del or ",;") .. ")]?)"
    str = del .. "(%s*)(" .. str .. ")(%s*)" .. del
    i = i or 1
    while i do
        local s, e, a, b, m, c, d = list:find(str, i)
        if s and a == "" and d == "" then
            return s + #b, e - #c, m
        end
        i = e and e + 1
    end
end
GW.FindInList = FindInList

-- String upper and lower that are noops for locales without letter case
local function StrUpper(str, i, j)
    if not str or IsIn(GetLocale(), "koKR", "zhCN", "zhTW") then
        return str
    else
        return (i and str:sub(1, i - 1) or "") .. str:sub(i or 1, j):upper() .. (j and str:sub(j + 1) or "")
    end
end
GW.StrUpper = StrUpper
local function StrLower(str, i, j)
    if not str or IsIn(GetLocale(), "koKR", "zhCN", "zhTW") then
        return str
    else
        return (i and str:sub(1, i - 1) or "") .. str:sub(i or 1, j):lower() .. (j and str:sub(j + 1) or "")
    end
end
GW.StrLower = StrLower

local function IsNAN(n)
    return tostring(n) == "-1.#IND"
end
GW.IsNAN = IsNAN

local function IsFrameModified(f_name)
    if not MovAny then
        return false
    end
    return MovAny:IsModified(f_name)
end
GW.IsFrameModified = IsFrameModified

local function Notice(...)
    local msg_tab = _G["ChatFrame1"]
    if not msg_tab then
        return
    end
    local msg = ""
    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        msg = msg .. tostring(arg) .. " "
    end
    msg_tab:AddMessage("|cffC0C0F0GW2 UI|r: " .. msg)
end
GW.Notice = Notice

local function securePetAndOverride(f, stateType)
    if InCombatLockdown() then
        return false
    end
    GW.Debug("add secure petandoverride to", f:GetName(), stateType)
    f:SetAttribute("gw_WasShowing", f:IsShown())
    f:SetAttribute(
        "_onstate-petoverride",
        [=[
        if newstate == "show" then
            if self:GetAttribute("gw_WasShowing") then
                self:Show()
            end
        elseif newstate == "hide" then
            self:SetAttribute("gw_WasShowing", self:IsShown())
            self:Hide()
        end
    ]=]
    )
    if stateType == "petbattle" then
        RegisterStateDriver(f, "petoverride", "[petbattle] hide; show")
    elseif stateType == "override" then
        RegisterStateDriver(f, "petoverride", "[overridebar] hide; [vehicleui] hide; show")
    else
        RegisterStateDriver(f, "petoverride", "[overridebar] hide; [vehicleui] hide; [petbattle] hide; show")
    end
    return true
end

local function normPetAndOverride(f, stateType)
    GW.Debug("add norm petandoverride to", f:GetName(), stateType)
    local f_OnShow = function()
        f.gw_WasShowing = f:IsShown()
        f:Hide()
    end
    local f_OnHide = function()
        if f.gw_WasShowing then
            f:Show()
        end
    end

    if stateType ~= "petbattle" then
        OverrideActionBar:HookScript("OnShow", f_OnShow)
        OverrideActionBar:HookScript("OnHide", f_OnHide)
    end
    if stateType ~= "override" then
        PetBattleFrame:HookScript("OnShow", f_OnShow)
        PetBattleFrame:HookScript("OnHide", f_OnHide)
    end

    return true
end

local function MixinHideDuringPet(f)
    -- TODO: figure out how to do real mixins
    if f:IsProtected() then
        return securePetAndOverride(f, "petbattle")
    else
        return normPetAndOverride(f, "petbattle")
    end
end
GW.MixinHideDuringPet = MixinHideDuringPet

local function MixinHideDuringOverride(f)
    if f:IsProtected() then
        return securePetAndOverride(f, "override")
    else
        return normPetAndOverride(f, "override")
    end
end
GW.MixinHideDuringOverride = MixinHideDuringOverride

local function MixinHideDuringPetAndOverride(f)
    if f:IsProtected() then
        return securePetAndOverride(f)
    else
        return normPetAndOverride(f)
    end
end
GW.MixinHideDuringPetAndOverride = MixinHideDuringPetAndOverride

local PATTERN_ILVL = ITEM_LEVEL:gsub("%%d", "(%%d+)")
local PATTERN_ILVL_SCALED = ITEM_LEVEL_ALT:gsub("%(%%d%)", "%%((%%d)%%)"):gsub("%%d", "%%d+")

-- Get an item's real level, scanning the tooltip if necessary
local function GetRealItemLevel(link)
    local i, numBonusIds, linkLvl, upgradeLvl = 0, 0
    for v in link:gmatch(":(%-?%d*)") do
        i, v = i + 1, tonumber(v)
        if i == 9 then
            linkLvl = v
        elseif i == 13 then
            numBonusIds = v or 0
        elseif i == 14 + numBonusIds then
            upgradeLvl = v break
        end
    end

    if linkLvl and upgradeLvl and linkLvl ~= upgradeLvl then
        local tt = GWHiddenTooltip or CreateFrame("GameTooltip", "GWHiddenTooltip", nil, "GameTooltipTemplate")
        tt:SetOwner(UIParent, "ANCHOR_NONE")
        tt:ClearLines()
        tt:SetHyperlink(link)

        for i=2,min(3, tt:NumLines()) do
            local line = _G["GWHiddenTooltipTextLeft" .. i]:GetText()
            local lvl = line and tonumber(line:match(PATTERN_ILVL_SCALED) or line:match(PATTERN_ILVL))
            if lvl then return lvl end
        end
    end

    return (GetDetailedItemLevelInfo(link))
end
GW.GetRealItemLevel = GetRealItemLevel

--@debug@
local function AddForProfiling(unit, name, ...)
    if not Profiler then
        return
    end
    local gName = "GW_" .. unit
    if not _G[gName] then
        _G[gName] = {}
    end

    _G[gName][name] = ...
end

local function inDebug(tab, ...)
    local debug_tab = _G["ChatFrame" .. tab]
    if not debug_tab then
        return
    end
    local msg = ""
    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        msg = msg .. tostring(arg) .. " "
    end
    debug_tab:AddMessage(date("%H:%M:%S") .. " " .. msg)
end

local function Debug(...)
    if GW.dbgTab then
        inDebug(GW.dbgTab, ...)
    end
end

local function Trace()
    print("------------------------- Trace -------------------------")
    for i,v in ipairs({("\n"):split(debugstack(2))}) do
        if v ~= "" then
            print(i .. ": " .. v)
        end
    end
    print("---------------------------------------------------------")
end

--@end-debug@
--[===[@non-debug@
local function Debug()
    return
end
local function AddForProfiling()
    return
end
local function Trace()
    return
end
--@end-non-debug@]===]
GW.Debug = Debug
GW.Trace = Trace
GW.AddForProfiling = AddForProfiling
