local _, GW = ...

local function GW2_GridRaid25StyleRegister(self)
    self:RegisterForClicks('AnyUp')
    self:SetScript("OnLeave", function()
        GameTooltip_Hide()
    end)
    self:SetScript(
        "OnEnter",
        function(self)
            GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
            GameTooltip:SetUnit(self.unit)
            GameTooltip:Show()
        end
    )

    self.RaisedElementParent = GW.CreateRaisedElement(self)
	self.Health = GW.Construct_HealthBar(self, true)
    self.Name = GW.Construct_NameText(self)
    self.HealthValueText = GW.Construct_HealtValueText(self)
    self.Power = GW.Construct_PowerBar(self)
    self.MiddleIcon = GW.Construct_MiddleIcon(self)
    self.ThreatIndicator = GW.Construct_ThreathIndicator(self)
    self.ReadyCheckIndicator = GW.Construct_ReadyCheck(self)
    self.SummonIndicator = GW.Construct_SummonIcon(self)
    self.ResurrectIndicator = GW.Construct_ResurrectionIcon(self)
    GW.Construct_PredictionBar(self) -- creates only the function regestration
    self.Auras = GW.Construct_Auras(self)
    self.MissingBuffFrame = GW.Construct_MissingAuraIndicator(self)
    self.PrivateAuras = GW.Construct_PrivateAura(self)
    self.Range = GW.Construct_RangeIndicator(self)

    return self
end
GW.GW2_GridRaid25StyleRegister = GW2_GridRaid25StyleRegister

local function UpdateGridRaid25Frame(frame)
    -- set frame settings
    frame.useClassColor = GW.settings.RAID_CLASS_COLOR_RAID25
    frame.hideClassIcon = GW.settings.RAID_HIDE_CLASS_ICON_RAID25
    frame.showResscoureBar = GW.settings.RAID_POWER_BARS_RAID25
    frame.showRealmFlags = GW.settings.RAID_UNIT_FLAGS_RAID25
    frame.healthStringFormat = GW.settings.RAID_UNIT_HEALTH_RAID25
    frame.showTargetmarker = GW.settings.RAID_UNIT_MARKERS_RAID25
    frame.unitWidth = tonumber(GW.settings.RAID_WIDTH_RAID25)
    frame.unitHeight = tonumber(GW.settings.RAID_HEIGHT_RAID25)
    frame.raidShowImportendInstanceDebuffs = GW.settings.RAID_SHOW_IMPORTEND_RAID_INSTANCE_DEBUFF_RAID25
    frame.showAllDebuffs = GW.settings.RAID_SHOW_DEBUFFS_RAID25
    frame.showOnlyDispelDebuffs = GW.settings.RAID_ONLY_DISPELL_DEBUFFS_RAID25
    frame.showAuraTooltipInCombat = GW.settings.RAID_AURA_TOOLTIP_INCOMBAT_RAID25
    frame.ignoredAuras = GW.FillTable({}, true, strsplit(",", (GW.settings.AURAS_IGNORED:trim():gsub("%s*,%s*", ","))))
    frame.missingAuras = GW.FillTable({}, true, strsplit(",", (GW.settings.AURAS_MISSING:trim():gsub("%s*,%s*", ","))))
    frame.shortendHealthValue = GW.settings.RAID_SHORT_HEALTH_VALUES_RAID25

    frame.raidIndicators = {}
    for _, pos in ipairs(GW.INDICATORS) do
        frame.raidIndicators[pos] = GW.settings["INDICATOR_" .. pos]
    end
    frame.showRaidIndicatorIcon = GW.settings.INDICATORS_ICON
    frame.showRaidIndicatorTimer = GW.settings.INDICATORS_TIME
    frame.raidDebuffScale = GW.settings.RAIDDEBUFFS_Scale
    frame.raidDispelDebuffScale = GW.settings.DISPELL_DEBUFFS_Scale
    frame.showRoleIcon = GW.settings.RAID_SHOW_ROLE_ICON_RAID25
    frame.showTankIcon = GW.settings.RAID_SHOW_TANK_ICON_RAID25
    frame.showLeaderAssistIcon = GW.settings.RAID_SHOW_LEADER_ICON_RAID25

    if not InCombatLockdown() then
        frame:SetSize(frame.unitWidth, frame.unitHeight)
        frame:ClearAllPoints()

        if GW.settings.RAID25_ENABLED and not frame:IsEnabled() then
            frame:Enable()
        elseif not GW.settings.RAID25_ENABLED and frame:IsEnabled() then
            frame:Disable()
        end
    end

    GW.Update_Healtbar(frame)
    GW.Update_Powerbar(frame)
    GW.UpdateNameSettings(frame)
    GW.UpdateHealtValueTextSettings(frame)
    GW.UpdateMiddleIconSettings(frame)
    GW.UpdateThreathIndicatorSettings(frame)
    GW.UpdateReadyCheckSettings(frame)
    GW.UpdateSummonIconSettings(frame)
    GW.UpdateResurrectionIconSettings(frame)
    GW.Update_PredictionBars(frame)
    GW.UpdateAurasSettings(frame)
    GW.Update_MissingAuraIndicator(frame)
    GW.UpdatePrivateAurasSettings(frame)
    GW.Update_RangeIndicator(frame)

    frame:UpdateAllElements("Gw2_UpdateAllElements")
end
GW.UpdateGridRaid25Frame = UpdateGridRaid25Frame
