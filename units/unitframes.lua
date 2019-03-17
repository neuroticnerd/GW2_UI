local _, GW = ...
local COLOR_FRIENDLY = GW.COLOR_FRIENDLY
local DEBUFF_COLOR = GW.DEBUFF_COLOR
local GetSetting = GW.GetSetting
local TimeCount = GW.TimeCount
local CommaValue = GW.CommaValue
local Diff = GW.Diff
local PowerBarColorCustom = GW.PowerBarColorCustom
local bloodSpark = GW.BLOOD_SPARK
local CLASS_COLORS_RAIDFRAME = GW.CLASS_COLORS_RAIDFRAME
local TARGET_FRAME_ART = GW.TARGET_FRAME_ART
local RegisterMovableFrame = GW.RegisterMovableFrame
local animations = GW.animations
local AddToAnimation = GW.AddToAnimation
local AddToClique = GW.AddToClique
local Debug = GW.Debug
local IsIn = GW.IsIn
local GetRealItemLevel = GW.GetRealItemLevel
local unitIlvls = {}

local function sortAuras(a, b)
    if a["caster"] == nil then
        a["caster"] = ""
    end
    if b["caster"] == nil then
        b["caster"] = ""
    end

    if a["caster"] == b["caster"] then
        return a["timeremaning"] < b["timeremaning"]
    end

    return (b["caster"] ~= "player" and a["caster"] == "player")
end
GW.AddForProfiling("unitframes", "sortAuras", sortAuras)

local function sortAuraList(auraList)
    table.sort(
        auraList,
        function(a, b)
            return sortAuras(a, b)
        end
    )

    return auraList
end
GW.AddForProfiling("unitframes", "sortAuraList", sortAuraList)

local function getBuffs(unit, filter)
    if filter == nil then
        filter = ""
    end
    local auraList = {}
    for i = 1, 40 do
        if UnitBuff(unit, i, filter) ~= nil then
            auraList[i] = {}
            auraList[i]["id"] = i

            auraList[i]["name"],
                auraList[i]["icon"],
                auraList[i]["count"],
                auraList[i]["dispelType"],
                auraList[i]["duration"],
                auraList[i]["expires"],
                auraList[i]["caster"],
                auraList[i]["isStealable"],
                auraList[i]["shouldConsolidate"],
                auraList[i]["spellID"] = UnitBuff(unit, i, filter)

            auraList[i]["timeremaning"] = auraList[i]["expires"] - GetTime()

            if auraList[i]["duration"] <= 0 then
                auraList[i]["timeremaning"] = 500001
            end
        end
    end

    return sortAuraList(auraList)
end
GW.AddForProfiling("unitframes", "getBuffs", getBuffs)

local function getDebuffs(unit, filter)
    local auraList = {}

    for i = 1, 40 do
        if UnitDebuff(unit, i, filter) ~= nil then
            auraList[i] = {}
            auraList[i]["id"] = i

            auraList[i]["name"],
                auraList[i]["icon"],
                auraList[i]["count"],
                auraList[i]["dispelType"],
                auraList[i]["duration"],
                auraList[i]["expires"],
                auraList[i]["caster"],
                auraList[i]["isStealable"],
                auraList[i]["shouldConsolidate"],
                auraList[i]["spellID"] = UnitDebuff(unit, i, filter)

            auraList[i]["timeremaning"] = auraList[i]["expires"] - GetTime()

            if auraList[i]["duration"] <= 0 then
                auraList[i]["timeremaning"] = 500001
            end
        end
    end

    return sortAuraList(auraList)
end
GW.AddForProfiling("unitframes", "getDebuffs", getDebuffs)

local function setAuraType(self, typeAura)
    if self.typeAura == typeAura then
        return
    end

    if typeAura == "smallbuff" then
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -1, 1)
        self.duration:SetFont(UNIT_NAME_FONT, 11)
        self.stacks:SetFont(UNIT_NAME_FONT, 12, "OUTLINED")
    end

    if typeAura == "bigBuff" then
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 3, -3)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3, 3)
        self.duration:SetFont(UNIT_NAME_FONT, 14)
        self.stacks:SetFont(UNIT_NAME_FONT, 14, "OUTLINED")
    end

    self.typeAura = typeAura
end
GW.AddForProfiling("unitframes", "setAuraType", setAuraType)

local function setBuffData(self, buffs, i, oldBuffs)
    if not self or not buffs then
        return false
    end
    local b = buffs[i]
    if b == nil or b["name"] == nil then
        return false
    end

    local stacks = ""
    local duration = ""

    if b["caster"] == "player" and (b["duration"] > 0 and b["duration"] < 120) then
        setAuraType(self, "bigBuff")

        self.cooldown:SetCooldown(b["expires"] - b["duration"], b["duration"])
    else
        setAuraType(self, "smallbuff")
    end

    if b["count"] ~= nil and b["count"] > 1 then
        stacks = b["count"]
    end
    if b["timeremaning"] ~= nil and b["timeremaning"] > 0 and b["timeremaning"] < 500000 then
        duration = TimeCount(b["timeremaning"])
    end

    if b["expires"] < 1 or b["timeremaning"] > 500000 then
        self.expires = nil
    else
        self.expires = b["expires"]
    end

    if self.auraType == "debuff" then
        if b["dispelType"] ~= nil then
            self.background:SetVertexColor(
                DEBUFF_COLOR[b["dispelType"]].r,
                DEBUFF_COLOR[b["dispelType"]].g,
                DEBUFF_COLOR[b["dispelType"]].b
            )
        else
            self.background:SetVertexColor(COLOR_FRIENDLY[2].r, COLOR_FRIENDLY[2].g, COLOR_FRIENDLY[2].b)
        end
    else
        if b["isStealable"] then
            self.background:SetVertexColor(1, 1, 1)
        else
            self.background:SetVertexColor(0, 0, 0)
        end
    end

    self.auraid = b["id"]
    self.duration:SetText(duration)
    self.stacks:SetText(stacks)
    self.icon:SetTexture(b["icon"])

    return true
end
GW.AddForProfiling("unitframes", "setBuffData", setBuffData)

local function normalUnitFrame_OnEnter(self)
    if self.unit ~= nil then
        GameTooltip:ClearLines()
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
        GameTooltip:SetUnit(self.unit)
        GameTooltip:Show()
    end
end
GW.AddForProfiling("unitframes", "normalUnitFrame_OnEnter", normalUnitFrame_OnEnter)

local function createNormalUnitFrame(ftype)
    local f = CreateFrame("Button", ftype, UIParent, "GwNormalUnitFrame")

    f.healthString:SetFont(UNIT_NAME_FONT, 11)
    f.healthString:SetShadowOffset(1, -1)

    f.nameString:SetFont(UNIT_NAME_FONT, 14)
    f.nameString:SetShadowOffset(1, -1)

    f.levelString:SetFont(UNIT_NAME_FONT, 14)
    f.levelString:SetShadowOffset(1, -1)

    f.castingString:SetFont(UNIT_NAME_FONT, 12)
    f.castingString:SetShadowOffset(1, -1)

    f.prestigeString:SetFont(UNIT_NAME_FONT, 12, "OUTLINED")

    f.prestigebg:SetPoint("CENTER", f.prestigeString, "CENTER", -1, 1)

    f.portrait:SetMask("Textures\\MinimapMask")

    f.healthValue = 0

    f.barWidth = 212

    f:SetScript("OnEnter", normalUnitFrame_OnEnter)
    f:SetScript("OnLeave", GameTooltip_Hide)

    return f
end
GW.AddForProfiling("unitframes", "createNormalUnitFrame", createNormalUnitFrame)

local function createNormalUnitFrameSmall()
    local f = CreateFrame("Button", "GwTargetsTargetUnitFrame", UIParent, "GwNormalUnitFrameSmall")

    f.healthString:SetFont(UNIT_NAME_FONT, 11)
    f.healthString:SetShadowOffset(1, -1)

    f.nameString:SetFont(UNIT_NAME_FONT, 14)
    f.nameString:SetShadowOffset(1, -1)

    f.levelString:SetFont(UNIT_NAME_FONT, 14)
    f.levelString:SetShadowOffset(1, -1)

    f.castingString:SetFont(UNIT_NAME_FONT, 12)
    f.castingString:SetShadowOffset(1, -1)

    f.healthValue = 0

    f.barWidth = 146

    f:SetScript("OnEnter", normalUnitFrame_OnEnter)
    f:SetScript("OnLeave", GameTooltip_Hide)

    return f
end
GW.AddForProfiling("unitframes", "createNormalUnitFrameSmall", createNormalUnitFrameSmall)

local function updateHealthTextString(self, health, healthPrecentage)
    local healthString = ""

    if self.showHealthValue == true then
        healthString = CommaValue(health)
    end
    if self.showHealthValue == true and self.showHealthPrecentage == true then
        healthString = healthString .. " - "
    end

    if self.showHealthPrecentage == true then
        healthString = healthString .. CommaValue(healthPrecentage * 100) .. "%"
    end

    self.healthString:SetText(healthString)
end
GW.AddForProfiling("unitframes", "updateHealthTextString", updateHealthTextString)

local function updateHealthbarColor(self)
    if self.classColor == true and UnitIsPlayer(self.unit) then
        local _, _, classIndex = UnitClass(self.unit)
        self.healthbar:SetVertexColor(
            CLASS_COLORS_RAIDFRAME[classIndex].r,
            CLASS_COLORS_RAIDFRAME[classIndex].g,
            CLASS_COLORS_RAIDFRAME[classIndex].b,
            1
        )
        self.healthbarSpark:SetVertexColor(
            CLASS_COLORS_RAIDFRAME[classIndex].r,
            CLASS_COLORS_RAIDFRAME[classIndex].g,
            CLASS_COLORS_RAIDFRAME[classIndex].b,
            1
        )
        self.healthbarFlash:SetVertexColor(
            CLASS_COLORS_RAIDFRAME[classIndex].r,
            CLASS_COLORS_RAIDFRAME[classIndex].g,
            CLASS_COLORS_RAIDFRAME[classIndex].b,
            1
        )
        self.healthbarFlashSpark:SetVertexColor(
            CLASS_COLORS_RAIDFRAME[classIndex].r,
            CLASS_COLORS_RAIDFRAME[classIndex].g,
            CLASS_COLORS_RAIDFRAME[classIndex].b,
            1
        )

        self.nameString:SetTextColor(
            CLASS_COLORS_RAIDFRAME[classIndex].r,
            CLASS_COLORS_RAIDFRAME[classIndex].g,
            CLASS_COLORS_RAIDFRAME[classIndex].b,
            1
        )

        local r, g, b, _ = self.nameString:GetTextColor()
        self.nameString:SetTextColor(r + 0.3, g + 0.3, b + 0.3, 1)
    else
        local isFriend = UnitIsFriend("player", self.unit)
        local friendlyColor = COLOR_FRIENDLY[1]

        if isFriend ~= true then
            friendlyColor = COLOR_FRIENDLY[2]
        end
        if UnitIsTapDenied("player") then
            friendlyColor = COLOR_FRIENDLY[3]
        end

        self.healthbar:SetVertexColor(friendlyColor.r, friendlyColor.g, friendlyColor.b, 1)
        self.healthbarSpark:SetVertexColor(friendlyColor.r, friendlyColor.g, friendlyColor.b, 1)
        self.healthbarFlash:SetVertexColor(friendlyColor.r, friendlyColor.g, friendlyColor.b, 1)
        self.healthbarFlashSpark:SetVertexColor(friendlyColor.r, friendlyColor.g, friendlyColor.b, 1)
        self.nameString:SetTextColor(friendlyColor.r, friendlyColor.g, friendlyColor.b, 1)
    end

    if (UnitLevel(self.unit) - UnitLevel("player")) <= -5 then
        local r, g, b, _ = self.nameString:GetTextColor()
        self.nameString:SetTextColor(r + 0.5, g + 0.5, b + 0.5, 1)
    end
end
GW.AddForProfiling("unitframes", "updateHealthbarColor", updateHealthbarColor)

local function healthBarAnimation(self, powerPrec)
    local powerBarWidth = self.barWidth
    local bit = powerBarWidth / 12
    local spark = bit * math.floor(12 * (powerPrec))
    local spark_current = (bit * (12 * (powerPrec)) - spark) / bit

    local bI = math.min(16, math.max(1, math.floor(17 - (16 * spark_current))))

    self.healthbarFlashSpark:SetTexCoord(
        bloodSpark[bI].left,
        bloodSpark[bI].right,
        bloodSpark[bI].top,
        bloodSpark[bI].bottom
    )
    self.healthbarFlashSpark:SetPoint(
        "LEFT",
        self.healthbarBackground,
        "LEFT",
        math.max(0, math.min(powerBarWidth - bit, math.floor(spark))),
        0
    )
    self.healthbarFlash:SetPoint(
        "RIGHT",
        self.healthbarBackground,
        "LEFT",
        math.max(0, math.min(powerBarWidth, spark)) + 1,
        0
    )
end
GW.AddForProfiling("unitframes", "healthBarAnimation", healthBarAnimation)

local function healthBarAnimationNormal(self, powerPrec)
    local powerBarWidth = self.barWidth
    local bit = powerBarWidth / 12
    local spark = bit * math.floor(12 * (powerPrec))
    local spark_current = (bit * (12 * (powerPrec)) - spark) / bit

    local bI = math.min(16, math.max(1, math.floor(17 - (16 * spark_current))))

    self.healthbarSpark:SetTexCoord(
        bloodSpark[bI].left,
        bloodSpark[bI].right,
        bloodSpark[bI].top,
        bloodSpark[bI].bottom
    )
    self.healthbarSpark:SetPoint(
        "LEFT",
        self.healthbarBackground,
        "LEFT",
        math.max(0, math.min(powerBarWidth - bit, math.floor(spark))),
        0
    )
    self.healthbar:SetPoint(
        "RIGHT",
        self.healthbarBackground,
        "LEFT",
        math.max(0, math.min(powerBarWidth, spark)) + 2,
        0
    )
end
GW.AddForProfiling("unitframes", "healthBarAnimationNormal", healthBarAnimationNormal)

local function setUnitPortraitFrame(self, event)
    if self.portrait == nil or self.background == nil then
        return
    end

    local txt = nil
    local border = "normal"

    local unitClassIfication = UnitClassification(self.unit)
    if TARGET_FRAME_ART[unitClassIfication] ~= nil then
        border = unitClassIfication
        if UnitLevel(self.unit) == -1 then
            border = "boss"
        end
    end

    if GetSetting(self.unit .. "_SHOW_ILVL") and CanInspect(self.unit) then
        local guid = UnitGUID(self.unit)
        if guid and unitIlvls[guid] then
            txt = unitIlvls[guid]
        end
    elseif (UnitHonorLevel(self.unit) ~= nil and UnitHonorLevel(self.unit) > 9)   then
        txt = UnitHonorLevel(self.unit)
    
        if txt > 199 then
			plvl = 4
		elseif txt > 99 then
            plvl = 3
        elseif txt > 49 then 
            plvl = 2
        elseif txt > 9 then
            plvl = 1
        end
        
        key = 'prestige'..plvl
        if TARGET_FRAME_ART[key]~=nil then
            border = key
        end
    end

    if txt then
        self.prestigebg:Show()
        self.prestigeString:Show()
        self.prestigeString:SetText(txt)
    else
        self.prestigebg:Hide()
        self.prestigeString:Hide()
    end

    self.background:SetTexture(TARGET_FRAME_ART[border])
end
GW.AddForProfiling("unitframes", "setUnitPortraitFrame", setUnitPortraitFrame)

local function updateAvgItemLevel(self, event, guid)
    if guid == UnitGUID(self.unit) and CanInspect(self.unit) then
        if UnitIsUnit(self.unit, "player") then
            unitIlvls[guid] = floor((GetAverageItemLevel()))
        else
            local ilvl, n, retry = 0, 0
            for i=INVSLOT_HEAD,INVSLOT_OFFHAND do
                if i ~= INVSLOT_BODY then
                    local tex = GetInventoryItemTexture(self.unit, i)
                    local link = tex and GetInventoryItemLink(self.unit, i)
                    local lvl =  link and GetRealItemLevel(link)
                    if lvl then
                        ilvl, n = ilvl + lvl, n + 1
                    elseif tex then
                        retry = true
                    end
                end
            end
    
            if retry and not unitIlvls[guid] then
                C_Timer.After(0, function () NotifyInspect(self.unit) end)
            elseif n > 0 then
                unitIlvls[guid] = floor(ilvl / n)
                ClearInspectPlayer()
                self:UnregisterEvent("INSPECT_READY")
            end
        end

        setUnitPortraitFrame(self, event)
    end
end
GW.AddForProfiling("unitframes", "updateAvgItemLevel", updateAvgItemLevel)

local function updateRaidMarkers(self, event)
    local i = GetRaidTargetIndex(self.unit)
    if i == nil then
        self.raidmarker:SetTexture(nil)
        return
    end
    self.raidmarker:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. i)
end
GW.AddForProfiling("unitframes", "updateRaidMarkers", updateRaidMarkers)

local function setUnitPortrait(self, event)
    if self.portrait == nil then
        return
    end
    SetPortraitTexture(self.portrait, self.unit)
    self.activePortrait = ""
end
GW.AddForProfiling("unitframes", "setUnitPortrait", setUnitPortrait)

local function unitFrameData(self, event)
    local level = UnitLevel(self.unit)
    if level == -1 then
        level = "??"
    end

    local name = UnitName(self.unit)

    if UnitIsGroupLeader(self.unit) then
        name = "|TInterface\\AddOns\\GW2_UI\\textures\\party\\icon-groupleader:18:18|t" .. name
    end

    self.nameString:SetText(name)
    self.levelString:SetText(level)

    updateHealthbarColor(self)

    setUnitPortraitFrame(self, event)
end
GW.AddForProfiling("unitframes", "unitFrameData", unitFrameData)

local function normalCastBarAnimation(self, powerPrec)
    local powerBarWidth = self.barWidth
    self.castingbarNormal:SetWidth(math.min(powerBarWidth, math.max(1, powerBarWidth * powerPrec)))
    self.castingbarNormal:SetTexCoord(0, powerPrec, 0.25, 0.5)
    self.castingbarNormalSpark:SetWidth(math.max(1, math.min(16, 16 * (powerPrec / 0.10))))
end
GW.AddForProfiling("unitframes", "normalCastBarAnimation", normalCastBarAnimation)

local function protectedCastAnimation(self, powerPrec)
    local powerBarWidth = self.barWidth
    local bit = powerBarWidth / 16
    local spark = bit * math.floor(16 * (powerPrec))
    local segment = math.floor(16 * (powerPrec))
    local sparkPoint = (powerBarWidth * powerPrec) - 20

    self.castingbarSpark:SetWidth(math.min(32, 32 * (powerPrec / 0.10)))
    self.castingbarSpark:SetPoint("LEFT", self.castingbar, "LEFT", math.max(0, sparkPoint), 0)

    self.castingbar:SetTexCoord(0, math.min(1, math.max(0, 0.0625 * segment)), 0, 1)
    self.castingbar:SetWidth(math.min(powerBarWidth, math.max(1, spark)))
end
GW.AddForProfiling("unitframes", "protectedCastAnimation", protectedCastAnimation)

local function hideCastBar(self, event)
    self.castingbarBackground:Hide()
    self.castingString:Hide()

    self.castingbar:Hide()
    self.castingbarSpark:Hide()

    self.castingbarNormal:Hide()
    self.castingbarNormalSpark:Hide()

    self.castingbarBackground:SetPoint("TOPLEFT", self.powerbarBackground, "BOTTOMLEFT", -2, 19)

    if self.portrait ~= nil then
        setUnitPortrait(self, event)
    end

    if animations["GwUnitFrame" .. self.unit .. "Cast"] ~= nil then
        animations["GwUnitFrame" .. self.unit .. "Cast"]["completed"] = true
        animations["GwUnitFrame" .. self.unit .. "Cast"]["duration"] = 0
    end
end
GW.AddForProfiling("unitframes", "hideCastBar", hideCastBar)

local function updateCastValues(self, event)
    local castType = 1

    local name, _, texture, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(self.unit)

    if name == nil then
        name, _, texture, startTime, endTime, _, notInterruptible = UnitChannelInfo(self.unit)
        castType = 0
    end

    if name == nil then
        hideCastBar(self, event)
        return
    end

    startTime = startTime / 1000
    endTime = endTime / 1000

    self.castingString:SetText(name)

    if texture ~= nil and self.portrait ~= nil and (self.activePortrait == nil or self.activePortrait ~= texture) then
        self.portrait:SetTexture(texture)
        self.activePortrait = texture
    end

    self.castingbarBackground:Show()
    self.castingbarBackground:SetPoint("TOPLEFT", self.powerbarBackground, "BOTTOMLEFT", -2, -1)
    self.castingString:Show()

    if notInterruptible then
        self.castingbarNormal:Hide()
        self.castingbarNormalSpark:Hide()

        self.castingbar:Show()
        self.castingbarSpark:Show()
    else
        self.castingbar:Hide()
        self.castingbarSpark:Hide()

        self.castingbarNormal:Show()
        self.castingbarNormalSpark:Show()
    end

    AddToAnimation(
        "GwUnitFrame" .. self.unit .. "Cast",
        0,
        1,
        startTime,
        endTime - startTime,
        function(step)
            if castType == 0 then
                step = 1 - step
            end
            if notInterruptible then
                protectedCastAnimation(self, step)
            else
                normalCastBarAnimation(self, step)
            end
        end,
        "noease"
    )
end
GW.AddForProfiling("unitframes", "updateCastValues", updateCastValues)

local function updatePowerValues(self, event)
    local powerType, powerToken, _ = UnitPowerType(self.unit)
    local power = UnitPower(self.unit, powerType)
    local powerMax = UnitPowerMax(self.unit, powerType)
    local powerPrecentage = 0

    if power > 0 and powerMax > 0 then
        powerPrecentage = power / powerMax
    end

    if power <= 0 then
        self.powerbarBackground:Hide()
        self.powerbar:Hide()
    else
        self.powerbarBackground:Show()
        self.powerbar:Show()
    end

    if PowerBarColorCustom[powerToken] then
        local pwcolor = PowerBarColorCustom[powerToken]
        self.powerbar:SetVertexColor(pwcolor.r, pwcolor.g, pwcolor.b)
    end

    self.powerbar:SetWidth(math.min(self.barWidth, math.max(1, self.barWidth * powerPrecentage)))
end
GW.AddForProfiling("unitframes", "updatePowerValues", updatePowerValues)

local function setAbsorbValue(self, absorb, absorbPrecentage, healthPrecentage, health, healthMax)
    local absorbAmount = healthPrecentage + absorbPrecentage
    local absorbAmount2 = absorbPrecentage - (1 - healthPrecentage)

    self.absorbbarbg:SetWidth(math.min(self.barWidth, math.max(1, self.barWidth * absorbAmount)))
    self.absorbbar:SetWidth(math.min(self.barWidth, math.max(1, self.barWidth * absorbAmount2)))

    self.absorbbarbg:SetTexCoord(0, math.min(1, 1 * absorbAmount), 0, 1)
    self.absorbbar:SetTexCoord(0, math.min(1, 1 * absorbAmount), 0, 1)

    self.absorbbarbg:SetAlpha(math.max(0, math.min(1, (1 * (absorbPrecentage / 0.1)))))
    self.absorbbar:SetAlpha(math.max(0, math.min(1, (1 * (absorbPrecentage / 0.1)))))
end
GW.AddForProfiling("unitframes", "setAbsorbValue", setAbsorbValue)

local function updateHealthValues(self, event)
    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPrecentage = 0
    local absorb = UnitGetTotalAbsorbs(self.unit)
    local absorbPrecentage = 0

    if health > 0 and healthMax > 0 then
        healthPrecentage = health / healthMax
    end

    if absorb > 0 and healthMax > 0 then
        absorbPrecentage = absorb / healthMax
    end

    if self.healthTextThroth == nil then
        self.healthTextThroth = 0
    end

    local animationSpeed = Diff(self.healthValue, healthPrecentage)
    animationSpeed = math.min(1.00, math.max(0.2, 2.00 * animationSpeed))

    if event == "UNIT_TARGET_CHANGED" or event == "FOCUS_TARGET_CHANGED" or event == "PLAYER_TARGET_CHANGED" then
        animationSpeed = 0
    end

    setAbsorbValue(self, absorb, absorbPrecentage, healthPrecentage, health, healthMax)

    healthBarAnimationNormal(self, healthPrecentage)

    AddToAnimation(
        self:GetName() .. self.unit,
        self.healthValue,
        healthPrecentage,
        GetTime(),
        animationSpeed,
        function(step)
            healthBarAnimation(self, step)

            if self.healthTextThroth < GetTime() then
                self.healthTextThroth = GetTime() + 0.1
                updateHealthTextString(self, healthMax * step, step)
            end
            self.healthValue = step
        end,
        nil,
        function()
            updateHealthTextString(self, health, healthPrecentage)
        end
    )
end
GW.AddForProfiling("unitframes", "updateHealthValues", updateHealthValues)

local function auraAnimateIn(self)
    local endWidth = self:GetWidth()

    AddToAnimation(
        self:GetName(),
        endWidth * 2,
        endWidth,
        GetTime(),
        0.2,
        function(step)
            self:SetSize(step, step)
        end
    )
end
GW.AddForProfiling("unitframes", "auraAnimateIn", auraAnimateIn)

local function UpdateBuffLayout(self, event, anchorPos)
    local minIndex = 1
    local maxIndex = 80

    local isPlayer = false
    if anchorPos and anchorPos == "player" then
        isPlayer = true
    elseif anchorPos ~= "player" then
        if self.displayBuffs ~= true then
            minIndex = 40
        end
        if self.displayDebuffs ~= true then
            maxIndex = 40
        end
    end

    local marginX = 3
    local marginY = 20

    local usedWidth = 0
    local usedHeight = 0

    local smallSize
    local bigSize
    local maxSize

    if isPlayer then
        maxSize = self:GetWidth()
        smallSize = 28
        bigSize = 32
    else
        maxSize = self.auras:GetWidth()
        smallSize = 20
        bigSize = 28
    end

    local lineSize = smallSize

    local auraList = getBuffs(self.unit)
    local debuffList = getDebuffs(self.unit, self.debuffFilter)

    local saveAuras = {}

    saveAuras["buff"] = {}
    saveAuras["debuff"] = {}

    local fUnit
    if isPlayer then
        fUnit = "player"
    else
        fUnit = self.unit
    end

    for frameIndex = minIndex, maxIndex do
        local index
        if isPlayer then
            index = 41 - frameIndex
        else
            index = frameIndex
        end
        local list = auraList
        local newAura = true

        if frameIndex > 40 then
            if isPlayer then
                index = 41 - (frameIndex - 40)
            else
                index = frameIndex - 40
            end
        end

        local frame = _G["Gw" .. fUnit .. "buffFrame" .. index]

        if frameIndex > 40 then
            frame = _G["Gw" .. fUnit .. "debuffFrame" .. index]
            list = debuffList
        end

        if frameIndex == 41 then
            usedWidth = 0
            usedHeight = usedHeight + lineSize + marginY
            lineSize = smallSize
        end

        if setBuffData(frame, list, index) then
            if not frame:IsShown() then
                frame:Show()
            end

            local isBig = frame.typeAura == "bigBuff"

            local size = smallSize
            if isBig then
                size = bigSize
                lineSize = bigSize

                for k, v in pairs(self.saveAuras[frame.auraType]) do
                    if v == list[index]["name"] then
                        newAura = false
                    end
                end
                self.animating = false
                saveAuras[frame.auraType][#saveAuras[frame.auraType] + 1] = list[index]["name"]
            end

            local px = usedWidth + (size / 2)
            local py = usedHeight + (size / 2)
            if not anchorPos then
                frame:SetPoint("CENTER", self.auras, "TOPLEFT", px, -py)
            elseif anchorPos == "pet" then
                frame:SetPoint("CENTER", self.auras, "BOTTOMRIGHT", -px, py)
            elseif anchorPos == "player" then
                frame:SetPoint("CENTER", self, "BOTTOMRIGHT", -px, py)
            end

            frame:SetSize(size, size)
            if newAura and isBig and event == "UNIT_AURA" then
                auraAnimateIn(frame)
            end

            usedWidth = usedWidth + size + marginX
            if maxSize < usedWidth then
                usedWidth = 0
                usedHeight = usedHeight + lineSize + marginY
                lineSize = smallSize
            end
        elseif frame and frame:IsShown() then
            frame:Hide()
        end
    end

    self.saveAuras = saveAuras
end
GW.UpdateBuffLayout = UpdateBuffLayout

local function auraFrame_OnUpdate(self, elapsed)
    if self.throt < 0 and self.expires ~= nil and self:IsShown() then
        self.throt = 0.2
        self.duration:SetText(TimeCount(self.expires - GetTime()))
    else
        self.throt = self.throt - elapsed
    end
end
GW.AddForProfiling("unitframes", "auraFrame_OnUpdate", auraFrame_OnUpdate)

local function auraFrame_OnEnter(self)
    if self:IsShown() and self.auraid ~= nil and self.unit ~= nil then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:ClearLines()
        if self.auraType == "buff" then
            GameTooltip:SetUnitBuff(self.unit, self.auraid)
        else
            GameTooltip:SetUnitDebuff(self.unit, self.auraid, self.debuffFilter)
        end
        GameTooltip:Show()
    end
end
GW.AddForProfiling("unitframes", "auraFrame_OnEnter", auraFrame_OnEnter)

local function auraFrame_OnClick(self, button, down)
    if not InCombatLockdown() and self.auraType == "buff" and button == "RightButton" and self.unit == "player" then
        CancelUnitBuff("player", self.auraid)
    end
end
GW.AddForProfiling("unitframes", "auraFrame_OnClick", auraFrame_OnClick)

local function CreateAuraFrame(name, parent)
    local f = CreateFrame("Button", name, parent, "GwAuraFrame")
    local fs = f.status

    f.typeAura = "smallbuff"
    f.cooldown:SetDrawEdge(0)
    f.cooldown:SetDrawSwipe(1)
    f.cooldown:SetReverse(false)
    f.cooldown:SetHideCountdownNumbers(true)
    f.throt = -1

    fs.stacks:SetFont(UNIT_NAME_FONT, 11, "OUTLINED")
    fs.duration:SetFont(UNIT_NAME_FONT, 10)
    fs.duration:SetShadowOffset(1, -1)

    fs:GetParent().duration = fs.duration
    fs:GetParent().stacks = fs.stacks
    fs:GetParent().icon = fs.icon

    f:SetScript("OnUpdate", auraFrame_OnUpdate)
    f:SetScript("OnEnter", auraFrame_OnEnter)
    f:SetScript("OnLeave", GameTooltip_Hide)
    f:SetScript("OnClick", auraFrame_OnClick)
    --f:SetAttribute('type2', 'cancelaura')

    return f
end
GW.CreateAuraFrame = CreateAuraFrame

local function LoadAuras(f, a, u)
    local unit = u or f.unit
    for i = 1, 40 do
        local frame = CreateAuraFrame("Gw" .. unit .. "buffFrame" .. i, a)
        frame.unit = unit
        frame.auraType = "buff"
        frame = CreateAuraFrame("Gw" .. unit .. "debuffFrame" .. i, a)
        frame.unit = unit
        frame.auraType = "debuff"
    end
    f.saveAuras = {}
    f.saveAuras["buff"] = {}
    f.saveAuras["debuff"] = {}
end
GW.LoadAuras = LoadAuras

local function target_OnEvent(self, event, unit)
    if IsIn(event, "PLAYER_TARGET_CHANGED", "ZONE_CHANGED") then
        if event == "PLAYER_TARGET_CHANGED" and CanInspect(self.unit) and GetSetting("target_SHOW_ILVL") then
            local guid = UnitGUID(self.unit)
            if guid then
                if IsShiftKeyDown() then
                    unitIlvls[guid] = nil
                end
                if not unitIlvls[guid] then
                    self:RegisterEvent("INSPECT_READY")
                    NotifyInspect(self.unit)
                end
            end
        end

        self.stepOnUpdate = 0
        self:SetScript(
            "OnUpdate",
            function()
                self.stepOnUpdate = self.stepOnUpdate + 1

                if self.stepOnUpdate == 1 then
                    updateHealthValues(self, event)
                    return
                end
                if self.stepOnUpdate == 2 then
                    unitFrameData(self, event)
                    return
                end
                if self.stepOnUpdate == 3 then
                    updatePowerValues(self, event)
                    return
                end
                if self.stepOnUpdate == 4 then
                    updateCastValues(self, event)
                    return
                end
                if self.stepOnUpdate == 5 then
                    updateRaidMarkers(self, event)
                    return
                end
                if self.stepOnUpdate == 6 then
                    UpdateBuffLayout(self, event)
                    return
                end

                if self.stepOnUpdate == 7 then
                    self:SetScript("OnUpdate", nil)
                    return
                end
            end
        )
    elseif event == "PLAYER_ENTERING_WORLD" then
        wipe(unitIlvls)
    elseif event == "RAID_TARGET_UPDATE" then
        updateRaidMarkers(self, event)
    elseif event == "INSPECT_READY" then
        if not GetSetting("target_SHOW_ILVL") then
            self:UnregisterEvent("INSPECT_READY")
            ClearInspectPlayer()
        else
            updateAvgItemLevel(self, event, unit)
        end
    elseif unit == self.unit then
        if event == "UNIT_AURA" then
            UpdateBuffLayout(self, event)
        elseif IsIn(event, "UNIT_HEALTH", "UNIT_MAXHEALTH", "UNIT_ABSORB_AMOUNT_CHANGED", "UNIT_HEALTH_FREQUENT") then
            updateHealthValues(self, event)
        elseif IsIn(event, "UNIT_MAXPOWER", "UNIT_POWER_FREQUENT") then
            updatePowerValues(self, event)
        elseif IsIn(event, "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_CHANNEL_START") then
            updateCastValues(self, event)
        elseif IsIn(event, "UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_FAILED") then
            hideCastBar(self, event)
        end
    end
end
GW.AddForProfiling("unitframes", "target_OnEvent", target_OnEvent)

local function focus_OnEvent(self, event, unit)
    if event == "PLAYER_FOCUS_CHANGED" or event == "ZONE_CHANGED" then
        self.stepOnUpdate = 0
        self:SetScript(
            "OnUpdate",
            function()
                self.stepOnUpdate = self.stepOnUpdate + 1

                if self.stepOnUpdate == 1 then
                    updateHealthValues(self, event)
                    return
                end
                if self.stepOnUpdate == 2 then
                    unitFrameData(self, event)
                    return
                end
                if self.stepOnUpdate == 3 then
                    updatePowerValues(self, event)
                    return
                end
                if self.stepOnUpdate == 4 then
                    updateCastValues(self, event)
                    return
                end
                if self.stepOnUpdate == 5 then
                    updateRaidMarkers(self, event)
                    return
                end
                if self.stepOnUpdate == 6 then
                    UpdateBuffLayout(self, event)
                    return
                end

                if self.stepOnUpdate == 7 then
                    self:SetScript("OnUpdate", nil)
                    return
                end
            end
        )
        return
    end

    if
        (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_ABSORB_AMOUNT_CHANGED") and
            unit == self.unit
     then
        updateHealthValues(self, event)
        return
    end

    if (event == "UNIT_MAXPOWER" or event == "UNIT_POWER_FREQUENT") and unit == self.unit then
        updatePowerValues(self, event)
        return
    end

    if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START") and unit == self.unit then
        updateCastValues(self, event)
        return
    end

    if
        (event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_STOP" or
            event == "UNIT_SPELLCAST_INTERRUPTED" or
            event == "UNIT_SPELLCAST_FAILED") and
            unit == self.unit
     then
        hideCastBar(self, event)
        return
    end

    if event == "RAID_TARGET_UPDATE" then
        updateRaidMarkers(self, event)
    end

    if event == "UNIT_AURA" and unit == self.unit then
        UpdateBuffLayout(self, event)
    end
end
GW.AddForProfiling("unitframes", "focus_OnEvent", focus_OnEvent)

local function targettarget_OnEvent(self, event, unit, arg2)
    if not UnitExists(self.unit) then
        return
    end

    if (event == "UNIT_TARGET" and unit == "target") or event == "PLAYER_TARGET_CHANGED" or event == "ZONE_CHANGED" then
        self.stepOnUpdate = 0
        self:SetScript(
            "OnUpdate",
            function()
                self.stepOnUpdate = self.stepOnUpdate + 1

                if self.stepOnUpdate == 1 then
                    updateHealthValues(self, event)
                    return
                end
                if self.stepOnUpdate == 2 then
                    unitFrameData(self, event)
                    return
                end
                if self.stepOnUpdate == 3 then
                    updatePowerValues(self, event)
                    return
                end
                if self.stepOnUpdate == 4 then
                    updateCastValues(self, event)
                    return
                end
                if self.stepOnUpdate == 5 then
                    updateRaidMarkers(self, event)
                    return
                end

                if self.stepOnUpdate == 6 then
                    self:SetScript("OnUpdate", nil)
                    return
                end
            end
        )
        return
    end

    if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_ABSORB_AMOUNT_CHANGED") then
        updateHealthValues(self, event)
        return
    end

    if (event == "UNIT_MAXPOWER" or event == "UNIT_POWER_FREQUENT") then
        updatePowerValues(self, event)
        return
    end

    if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START") then
        updateCastValues(self, event)
        return
    end

    if
        (event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_STOP" or
            event == "UNIT_SPELLCAST_INTERRUPTED" or
            event == "UNIT_SPELLCAST_FAILED")
     then
        hideCastBar(self, event)
        return
    end

    if event == "RAID_TARGET_UPDATE" then
        updateRaidMarkers(self, event)
    end
end
GW.AddForProfiling("unitframes", "targettarget_OnEvent", targettarget_OnEvent)

local function focustarget_OnEvent(self, event, unit, arg2)
    if not UnitExists(self.unit) then
        return
    end

    if
        (event == "UNIT_TARGET" and unit == "focustarget") or event == "PLAYER_TARGET_CHANGED" or
            event == "PLAYER_FOCUS_CHANGED" or
            event == "ZONE_CHANGED"
     then
        self.stepOnUpdate = 0
        self:SetScript(
            "OnUpdate",
            function()
                self.stepOnUpdate = self.stepOnUpdate + 1

                if self.stepOnUpdate == 1 then
                    updateHealthValues(self, event)
                    return
                end
                if self.stepOnUpdate == 2 then
                    unitFrameData(self, event)
                    return
                end
                if self.stepOnUpdate == 3 then
                    updatePowerValues(self, event)
                    return
                end
                if self.stepOnUpdate == 4 then
                    updateCastValues(self, event)
                    return
                end
                if self.stepOnUpdate == 5 then
                    updateRaidMarkers(self, event)
                    return
                end

                if self.stepOnUpdate == 6 then
                    self:SetScript("OnUpdate", nil)
                    return
                end
            end
        )
        return
    end

    if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_ABSORB_AMOUNT_CHANGED") then
        updateHealthValues(self, event)
        return
    end

    if (event == "UNIT_MAXPOWER" or event == "UNIT_POWER_FREQUENT") then
        updatePowerValues(self, event)
        return
    end

    if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START") then
        updateCastValues(self, event)
        return
    end

    if
        (event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_STOP" or
            event == "UNIT_SPELLCAST_INTERRUPTED" or
            event == "UNIT_SPELLCAST_FAILED")
     then
        hideCastBar(self, event)
        return
    end

    if event == "RAID_TARGET_UPDATE" then
        updateRaidMarkers(self, event)
    end
end
GW.AddForProfiling("unitframes", "focustarget_OnEvent", focustarget_OnEvent)

local function LoadTarget()
    local NewUnitFrame = createNormalUnitFrame("GwTargetUnitFrame")
    NewUnitFrame.unit = "target"

    RegisterMovableFrame("targetframe", NewUnitFrame, "target_pos", "GwTargetFrameTemplateDummy")

    NewUnitFrame:ClearAllPoints()
    NewUnitFrame:SetPoint(
        GetSetting("target_pos")["point"],
        UIParent,
        GetSetting("target_pos")["relativePoint"],
        GetSetting("target_pos")["xOfs"],
        GetSetting("target_pos")["yOfs"]
    )

    NewUnitFrame:SetAttribute("unit", "target")

    NewUnitFrame:SetAttribute("*type1", "target")
    NewUnitFrame:SetAttribute("*type2", "togglemenu")
    NewUnitFrame:SetAttribute("unit", "target")
    RegisterUnitWatch(NewUnitFrame)
    NewUnitFrame:EnableMouse(true)
    NewUnitFrame:RegisterForClicks("AnyDown")

    local mask = UIParent:CreateMaskTexture()
    mask:SetPoint("CENTER", NewUnitFrame.portrait, "CENTER", 0, 0)

    mask:SetTexture("Textures\\MinimapMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetSize(58, 58)
    NewUnitFrame.portrait:AddMaskTexture(mask)

    AddToClique(NewUnitFrame)

    NewUnitFrame.classColor = GetSetting("target_CLASS_COLOR")

    NewUnitFrame.showHealthValue = GetSetting("target_HEALTH_VALUE_ENABLED")
    NewUnitFrame.showHealthPrecentage = GetSetting("target_HEALTH_VALUE_TYPE")

    NewUnitFrame.displayBuffs = GetSetting("target_BUFFS")
    NewUnitFrame.displayDebuffs = GetSetting("target_DEBUFFS")

    NewUnitFrame.debuffFilter = "player"

    if GetSetting("target_BUFFS_FILTER_ALL") == true then
        NewUnitFrame.debuffFilter = nil
    end

    NewUnitFrame:SetScript("OnEvent", target_OnEvent)

    NewUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    -- NewUnitFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
    NewUnitFrame:RegisterEvent("ZONE_CHANGED")
    NewUnitFrame:RegisterEvent("RAID_TARGET_UPDATE")
    NewUnitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXPOWER", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_AURA", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "target")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "target")

    LoadAuras(NewUnitFrame, NewUnitFrame.auras)

    TargetFrame:SetScript("OnEvent", nil)
    TargetFrame:Hide()
end
GW.LoadTarget = LoadTarget

local function LoadFocus()
    local NewUnitFrame = createNormalUnitFrame("GwFocusUnitFrame")
    NewUnitFrame.unit = "focus"

    RegisterMovableFrame("focusframe", NewUnitFrame, "focus_pos", "GwTargetFrameTemplateDummy")

    NewUnitFrame:ClearAllPoints()
    NewUnitFrame:SetPoint(
        GetSetting("focus_pos")["point"],
        UIParent,
        GetSetting("focus_pos")["relativePoint"],
        GetSetting("focus_pos")["xOfs"],
        GetSetting("focus_pos")["yOfs"]
    )

    local mask = UIParent:CreateMaskTexture()
    mask:SetPoint("CENTER", NewUnitFrame.portrait, "CENTER", 0, 0)

    mask:SetTexture("Textures\\MinimapMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetSize(58, 58)
    NewUnitFrame.portrait:AddMaskTexture(mask)

    NewUnitFrame:SetAttribute("*type1", "target")
    NewUnitFrame:SetAttribute("*type2", "togglemenu")
    NewUnitFrame:SetAttribute("unit", "focus")
    RegisterUnitWatch(NewUnitFrame)
    NewUnitFrame:EnableMouse(true)
    NewUnitFrame:RegisterForClicks("AnyDown")

    AddToClique(NewUnitFrame)

    NewUnitFrame.showHealthValue = GetSetting("focus_HEALTH_VALUE_ENABLED")
    NewUnitFrame.showHealthPrecentage = GetSetting("focus_HEALTH_VALUE_TYPE")

    NewUnitFrame.classColor = GetSetting("focus_CLASS_COLOR")

    NewUnitFrame.displayBuffs = GetSetting("focus_BUFFS")
    NewUnitFrame.displayDebuffs = GetSetting("focus_DEBUFFS")

    NewUnitFrame.debuffFilter = "player"
    if GetSetting("focus_BUFFS_FILTER_ALL") == true then
        NewUnitFrame.debuffFilter = nil
    end

    NewUnitFrame:SetScript("OnEvent", focus_OnEvent)

    NewUnitFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
    NewUnitFrame:RegisterEvent("ZONE_CHANGED")
    NewUnitFrame:RegisterEvent("RAID_TARGET_UPDATE")

    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXPOWER", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_AURA", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "focus")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "focus")

    LoadAuras(NewUnitFrame, NewUnitFrame.auras)

    FocusFrame:SetScript("OnEvent", nil)
    FocusFrame:Hide()
end
GW.LoadFocus = LoadFocus

local function LoadTargetOfTarget()
    local NewUnitFrame = createNormalUnitFrameSmall()
    NewUnitFrame.unit = "targettarget"

    RegisterMovableFrame("targettargetframe", NewUnitFrame, "targettarget_pos", "GwTargetFrameTemplateDummy")

    NewUnitFrame:ClearAllPoints()
    NewUnitFrame:SetPoint(
        GetSetting("targettarget_pos")["point"],
        UIParent,
        GetSetting("targettarget_pos")["relativePoint"],
        GetSetting("targettarget_pos")["xOfs"],
        GetSetting("targettarget_pos")["yOfs"]
    )

    NewUnitFrame:SetAttribute("unit", "targettarget")

    NewUnitFrame:SetAttribute("*type1", "target")
    NewUnitFrame:SetAttribute("*type2", "togglemenu")
    NewUnitFrame:SetAttribute("unit", "targettarget")
    RegisterUnitWatch(NewUnitFrame)
    NewUnitFrame:EnableMouse(true)
    NewUnitFrame:RegisterForClicks("AnyDown")

    AddToClique(NewUnitFrame)

    NewUnitFrame.showHealthValue = false
    NewUnitFrame.showHealthPrecentage = false

    NewUnitFrame.classColor = GetSetting("target_CLASS_COLOR")
    NewUnitFrame.debuffFilter = nil

    NewUnitFrame:SetScript("OnEvent", targettarget_OnEvent)

    NewUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    NewUnitFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
    NewUnitFrame:RegisterEvent("ZONE_CHANGED")
    NewUnitFrame:RegisterEvent("RAID_TARGET_UPDATE")

    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXPOWER", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_AURA", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "targettarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "targettarget")
end
GW.LoadTargetOfTarget = LoadTargetOfTarget

local function LoadTargetOfFocus()
    local NewUnitFrame = createNormalUnitFrameSmall()
    NewUnitFrame.unit = "focustarget"

    RegisterMovableFrame("focustargetframe", NewUnitFrame, "focustarget_pos", "GwTargetFrameTemplateDummy")

    NewUnitFrame:ClearAllPoints()
    NewUnitFrame:SetPoint(
        GetSetting("focustarget_pos")["point"],
        UIParent,
        GetSetting("focustarget_pos")["relativePoint"],
        GetSetting("focustarget_pos")["xOfs"],
        GetSetting("focustarget_pos")["yOfs"]
    )

    NewUnitFrame:SetAttribute("unit", "focustarget")

    NewUnitFrame:SetAttribute("*type1", "target")
    NewUnitFrame:SetAttribute("*type2", "togglemenu")
    NewUnitFrame:SetAttribute("unit", "focustarget")
    RegisterUnitWatch(NewUnitFrame)
    NewUnitFrame:EnableMouse(true)
    NewUnitFrame:RegisterForClicks("AnyDown")

    AddToClique(NewUnitFrame)

    NewUnitFrame.showHealthValue = false
    NewUnitFrame.showHealthPrecentage = false

    NewUnitFrame.classColor = GetSetting("target_CLASS_COLOR")
    NewUnitFrame.debuffFilter = nil

    NewUnitFrame:SetScript("OnEvent", focustarget_OnEvent)

    NewUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    NewUnitFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
    NewUnitFrame:RegisterEvent("ZONE_CHANGED")
    NewUnitFrame:RegisterEvent("RAID_TARGET_UPDATE")

    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_TARGET", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_MAXPOWER", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_AURA", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "focustarget")
    NewUnitFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "focustarget")
end
GW.LoadTargetOfFocus = LoadTargetOfFocus
