local _, GW = ...
local AddToAnimation = GW.AddToAnimation
local animations = GW.animations
local GetSetting = GW.GetSetting
local UpdatePowerData = GW.UpdatePowerData

local function powerCombo(self, event, ...)
    local pType = select(2, ...)
    if event ~= "CLASS_POWER_INIT" and pType ~= "COMBO_POINTS" then
        return
    end

    local pwrMax = UnitPowerMax(self.unit, Enum.PowerType.ComboPoints)
    local pwr = UnitPower(self.unit, Enum.PowerType.ComboPoints)
    local comboPoints = GetComboPoints(self.unit, "target")

    if self.unit == "vehicle" then
        if comboPoints == 0 then
            self.combopoints:Hide()
            return
        else
            self.combopoints:Show()
        end
    end

    local old_power = self.gwPower
    self.gwPower = pwr

    if pwr > 0 and not self:IsShown() and UnitExists("target") then
        self.combopoints:Show()
    end

    -- hide all not needed ones
    for i = pwrMax + 1, 9 do
        self.combopoints["runeTex" .. i]:Hide()
        self.combopoints["combo" .. i]:Hide()
    end

    for i = 1, pwrMax do
        if pwr >= i then
            self.combopoints["combo" .. i]:SetTexCoord(0.5, 1, 0.5, 0)
            self.combopoints["runeTex" .. i]:Show()
            self.combopoints["combo" .. i]:Show()
            self.combopoints.comboFlare:ClearAllPoints()
            self.combopoints.comboFlare:SetPoint("CENTER", self.combopoints["combo" .. i], "CENTER", 0, 0)
            if pwr > old_power then
                self.combopoints.comboFlare:Show()
                AddToAnimation(
                    "COMBOPOINTS_FLARE",
                    0,
                    5,
                    GetTime(),
                    0.5,
                    function()
                        local p = math.min(1, math.max(0, animations["COMBOPOINTS_FLARE"].progress))
                        self.combopoints.comboFlare:SetAlpha(p)
                    end,
                    nil,
                    function()
                        self.combopoints.comboFlare:Hide()
                    end
                )
            end
        else
            self.combopoints["combo" .. i]:Hide()
        end
    end
end

local function setComboBar(f)
    f.barType = "combo"
    f.background:SetTexture(nil)
    f.fill:SetTexture(nil)
    f:SetHeight(32)
    f.combopoints:Show()

    f:SetScript("OnEvent", powerCombo)
    powerCombo(f, "CLASS_POWER_INIT")
    f:RegisterEvent("UNIT_MAXPOWER")
    f:RegisterEvent("UNIT_POWER_UPDATE")
end

local function powerMana(self, event, ...)
    local ptype = select(2, ...)
    if event == "CLASS_POWER_INIT" or ptype == "MANA" then
        UpdatePowerData(self, 0, "MANA", "GwLittlePowerBar")
    end
end

local function setManaBar(f)
    f.barType = "combo"  -- we use this only for druid extra bar
    GwPlayerPowerBarExtra:Show()

    f:SetWidth(220)
    f:SetHeight(30)
    --f:Hide()

    GwPlayerPowerBarExtra:SetScript("OnEvent", powerMana)
    powerMana(GwPlayerPowerBarExtra, "CLASS_POWER_INIT")
    GwPlayerPowerBarExtra:RegisterUnitEvent("UNIT_MAXPOWER", "player")
    GwPlayerPowerBarExtra:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
end

-- ROGUE
local function setRogue(f)
    if GetSetting("target_HOOK_COMBOPOINTS") then return false end

    setComboBar(f)
    return true
end


-- DEATHKNIGHT
local RUNETYPE_BLOOD = 1
local RUNETYPE_FROST = 2
local RUNETYPE_UNHOLY = 3
local RUNETYPE_DEATH = 4

local iconTextures = {}
iconTextures[RUNETYPE_BLOOD] = "Interface/AddOns/GW2_UI/textures/altpower/runes-blood"
iconTextures[RUNETYPE_FROST] = "Interface/AddOns/GW2_UI/textures/altpower/runes"
iconTextures[RUNETYPE_UNHOLY] = "Interface/AddOns/GW2_UI/textures/altpower/runes-unholy"
iconTextures[RUNETYPE_DEATH] = "Interface/AddOns/GW2_UI/textures/altpower/runes-death"
local RUNE_TIMER_ANIMATIONS = {}
RUNE_TIMER_ANIMATIONS[1] = 0
RUNE_TIMER_ANIMATIONS[2] = 0
RUNE_TIMER_ANIMATIONS[3] = 0
RUNE_TIMER_ANIMATIONS[4] = 0
RUNE_TIMER_ANIMATIONS[5] = 0
RUNE_TIMER_ANIMATIONS[6] = 0
local function powerRune(self)
    local f = self
    local fr = self.runeBar
    for i = 1, 6 do
        local rune_start, rune_duration, rune_ready = GetRuneCooldown(i)
        local runeType = GetRuneType(i)
        local fFill = fr["runeTexFill" .. i]
        local fTex = fr["runeTex" .. i]
        local animId = "RUNE_TIMER_ANIMATIONS" .. i

        if rune_start == nil then
            rune_start = GetTime()
            rune_duration = 0
        end

        if runeType then
            fFill:SetTexture(iconTextures[runeType])
            fTex:SetTexture(iconTextures[runeType])
        end

        if rune_ready and fFill then
            fFill:SetTexCoord(0.5, 1, 0, 1)
            fFill:SetHeight(32)
            fFill:SetVertexColor(1, 1, 1)
            if animations[animId] then
                animations[animId].completed = true
                animations[animId].duration = 0
            end
        else
            if rune_start == 0 then
                return
            end

            AddToAnimation(
                animId,
                RUNE_TIMER_ANIMATIONS[i],
                1,
                rune_start,
                rune_duration,
                function()
                    fFill:SetTexCoord(0.5, 1, 1 - animations[animId].progress, 1)
                    fFill:SetHeight(32 * animations[animId].progress)
                    fFill:SetVertexColor(0.6 * animations[animId].progress, 0.6 * animations[animId].progress, 0.6 * animations[animId].progress)
                end,
                "noease",
                function()
                    f.flare:ClearAllPoints()
                    f.flare:SetPoint("CENTER", fFill, "CENTER", 0, 0)
                    AddToAnimation(
                        "HOLY_POWER_FLARE_ANIMATION",
                        1,
                        0,
                        GetTime(),
                        0.5,
                        function()
                            f.flare:SetAlpha(math.min(1, math.max(0 ,animations["HOLY_POWER_FLARE_ANIMATION"].progress)))
                        end
                    )
                end
            )
            RUNE_TIMER_ANIMATIONS[i] = 0
        end
        fTex:SetTexCoord(0, 0.5, 0, 1)
    end
end

local function setDeathKnight(f)
    local fr = f.runeBar
    f.background:SetTexture(nil)
    f.fill:SetTexture(nil)
    f.flare:SetTexture("Interface/AddOns/GW2_UI/textures/altpower/runeflash")
    f.flare:SetWidth(256)
    f.flare:SetHeight(128)
    fr:Show()

    f:SetScript("OnEvent", powerRune)
    powerRune(f)
    f:RegisterEvent("RUNE_POWER_UPDATE")
    f:RegisterEvent("RUNE_TYPE_UPDATE")

    return true
end
GW.AddForProfiling("classpowers", "setDeathKnight", setDeathKnight)

-- DRUID
local function setDruid(f)
    local form = f.gwPlayerForm
    local barType = "none"

    if form == CAT_FORM then -- cat
        barType = "combo|little_mana"
    elseif form == BEAR_FORM or form == 8 then --bear
        barType = "little_mana"
    end

    if barType == "combo|little_mana" then
        setComboBar(f)
        if f.ourPowerBar then
            setManaBar(f)
        end
        return true
    elseif barType == "little_mana" and f.ourPowerBar then
        setManaBar(f)
        return false
    else
        f.barType = "none"
        return false
    end
end
GW.AddForProfiling("classpowers", "setDruid", setDruid)

--SHAMAN
local function setShaman(f)
    if not InCombatLockdown() then
        UIPARENT_MANAGED_FRAME_POSITIONS.MultiCastActionBarFrame = nil

        MultiCastActionBarFrame:SetParent(f)
        MultiCastActionBarFrame:ClearAllPoints()
        MultiCastActionBarFrame:SetAllPoints(f)

        f:ClearAllPoints()
        f:SetPoint("TOPLEFT", f.gwMover, "TOPLEFT", 0, 0)

    elseif InCombatLockdown() then
        f.Script:RegisterEvent("PLAYER_REGEN_ENABLED")
    end

    f.background:Hide()
    f.fill:Hide()

    return true
end

local function selectType(f)
    f:SetScript("OnEvent", nil)
    f:UnregisterAllEvents()

    f.combopoints:Hide()
    f.runeBar:Hide()

    if GwPlayerPowerBarExtra then
        GwPlayerPowerBarExtra:Hide()
    end
    f.gwPower = -1
    local showBar = false

    if f.unit == "vehicle" then
        showBar = false
    elseif GW.myClassID == 4 then
        showBar = setRogue(f)
    elseif GW.myClassID == 6 then
        showBar = setDeathKnight(f)
    elseif GW.myClassID == 7 then
        showBar = setShaman(f)
    elseif GW.myClassID == 11 then
        showBar = setDruid(f)
    end

    if showBar and not f:IsShown() then
        f:Show()
    elseif not showBar and f:IsShown() then
        f:Hide()
    end
end

local function barChange_OnEvent(self, event, ...)
    local f = self:GetParent()
    if event == "UPDATE_SHAPESHIFT_FORM" then
        -- this event fires often when form hasn't changed; check old form against current form
        -- to prevent touching the bar unnecessarily (which causes annoying anim flickering)
        local results = GetShapeshiftFormID()
        if f.gwPlayerForm == results then
            return
        end
        f.gwPlayerForm = results
        selectType(f)
    elseif event == "PLAYER_TARGET_CHANGED" then
        if UnitExists("target") and UnitCanAttack(f.unit, "target") and f.barType == "combo" and not UnitIsDead("target") then
            f:Show()
        elseif f.barType == "combo" then
            f:Hide()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        selectType(f)
    elseif event == "UNIT_ENTERED_VEHICLE" then
        f.unit = "vehicle"
        selectType(f)
    elseif event == "UNIT_EXITED_VEHICLE" then
        f.unit = "player"
        selectType(f)
    end
end
--GWTEST = barChange_OnEvent
--/run GWTEST(GwPlayerClassPower.Script, "UNIT_ENTERED_VEHICLE")
--/run GWTEST(GwPlayerClassPower.Script, "UNIT_EXITED_VEHICLE")

local function LoadClassPowers()
    local cpf = CreateFrame("Frame", "GwPlayerClassPower", UIParent, "GwPlayerClassPower")

    GW.RegisterMovableFrame(cpf, GW.L["Class Power"], "ClasspowerBar_pos", ALL .. ",Unitframe,Power", {316, 32}, {"default", "scaleable"}, true)
    cpf:ClearAllPoints()
    cpf:SetPoint("TOPLEFT", cpf.gwMover)

    --GW.MixinHideDuringPetAndOverride(cpf)

    hooksecurefunc(cpf, "SetHeight", function() cpf.gwMover:SetHeight(cpf:GetHeight()) end)
    hooksecurefunc(cpf, "SetWidth", function() cpf.gwMover:SetWidth(cpf:GetWidth()) end)

    -- position mover
    if (not GetSetting("XPBAR_ENABLED") or GetSetting("PLAYER_AS_TARGET_FRAME")) and not cpf.isMoved  then
        local framePoint = GW.GetSetting("ClasspowerBar_pos")
        local yOff = not GetSetting("XPBAR_ENABLED") and 14 or 0
        local xOff = GetSetting("PLAYER_AS_TARGET_FRAME") and 52 or 0
        cpf.gwMover:ClearAllPoints()
        cpf.gwMover:SetPoint(framePoint.point, UIParent, framePoint.relativePoint, framePoint.xOfs + xOff, framePoint.yOfs - yOff)
    end

    cpf.ourPowerBar = GetSetting("POWERBAR_ENABLED")
    cpf.gwPlayerForm = GetShapeshiftFormID()

    -- create an extra mana power bar that is used sometimes (druid) only if our Powerbar is on
    if cpf.ourPowerBar then
        local anchorFrame = GetSetting("PLAYER_AS_TARGET_FRAME") and GwPlayerUnitFrame or GwPlayerPowerBar
        local barWidth = GetSetting("PLAYER_AS_TARGET_FRAME") and GwPlayerUnitFrame.powerbar:GetWidth() or GwPlayerPowerBar:GetWidth()
        local lmb = CreateFrame("Frame", "GwPlayerPowerBarExtra", anchorFrame, "GwPlayerPowerBar")
        GW.MixinHideDuringPetAndOverride(lmb)
        lmb.candy.spark:ClearAllPoints()

        lmb.bar:SetHeight(5)
        lmb.candy:SetHeight(5)
        lmb.candy.spark:SetHeight(5)
        lmb.statusBar:SetHeight(5)
        lmb:ClearAllPoints()
        if GetSetting("PLAYER_AS_TARGET_FRAME") then
            lmb:SetPoint("LEFT", anchorFrame.castingbarBackground, "LEFT", 2, 5)
            lmb:SetSize(barWidth + 2, 7)
            lmb.statusBar:SetWidth(barWidth - 2)
        else
            lmb:SetPoint("TOPLEFT", anchorFrame, "TOPLEFT", 0, 5)
            lmb:SetSize(barWidth, 7)
        end
        lmb:SetFrameStrata("MEDIUM")
        lmb.statusBar.label:SetFont(DAMAGE_TEXT_FONT, 8)
    end

    cpf.Script:SetScript("OnEvent", barChange_OnEvent)
    cpf.Script:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    cpf.Script:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	cpf.Script:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")

    cpf.unit = "player"

    selectType(cpf)
end
GW.LoadClassPowers = LoadClassPowers