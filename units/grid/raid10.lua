local _, GW = ...

local function GW2_GridRaid10StyleRegister(self)
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
    --self.PrivateAuras = GW.Construct_PrivateAura(self)
    self.Range = GW.Construct_RangeIndicator(self)

    return self
end
GW.GW2_GridRaid10StyleRegister = GW2_GridRaid10StyleRegister

local function UpdateGridRaid10Frame(frame)
    -- set frame settings
    frame.useClassColor = GW.GetSetting("RAID_CLASS_COLOR_RAID10")
    frame.showResscoureBar = GW.GetSetting("RAID_POWER_BARS_RAID10")
    frame.healthStringFormat = GW.GetSetting("RAID_UNIT_HEALTH_RAID10")
    frame.showTargetmarker = GW.GetSetting("RAID_UNIT_MARKERS_RAID10")
    frame.unitWidth = tonumber(GW.GetSetting("RAID_WIDTH_RAID10"))
    frame.unitHeight = tonumber(GW.GetSetting("RAID_HEIGHT_RAID10"))
    frame.raidShowImportendInstanceDebuffs = GW.GetSetting("RAID_SHOW_IMPORTEND_RAID_INSTANCE_DEBUFF_RAID10")
    frame.showAllDebuffs = GW.GetSetting("RAID_SHOW_DEBUFFS_RAID10")
    frame.showOnlyDispelDebuffs = GW.GetSetting("RAID_ONLY_DISPELL_DEBUFFS_RAID10")
    frame.showAuraTooltipInCombat = GW.GetSetting("RAID_AURA_TOOLTIP_INCOMBAT_RAID10")
    frame.ignoredAuras = GW.FillTable({}, true, strsplit(",", (GW.GetSetting("AURAS_IGNORED"):trim():gsub("%s*,%s*", ","))))
    frame.missingAuras = GW.FillTable({}, true, strsplit(",", (GW.GetSetting("AURAS_MISSING"):trim():gsub("%s*,%s*", ","))))

    frame.raidIndicators = {}
    for _, pos in ipairs(GW.INDICATORS) do
        frame.raidIndicators[pos] = GW.GetSetting("INDICATOR_" .. pos)
    end
    frame.showRaidIndicatorIcon = GW.GetSetting("INDICATORS_ICON")
    frame.showRaidIndicatorTimer = GW.GetSetting("INDICATORS_TIME")
    frame.raidDebuffScale = GW.GetSetting("RAIDDEBUFFS_Scale")
    frame.raidDispelDebuffScale = GW.GetSetting("DISPELL_DEBUFFS_Scale")
    frame.showRoleIcon = GW.GetSetting("RAID_SHOW_ROLE_ICON_RAID10")
    frame.showTankIcon = GW.GetSetting("RAID_SHOW_TANK_ICON_RAID10")
    frame.showLeaderAssistIcon = GW.GetSetting("RAID_SHOW_LEADER_ICON_RAID10")

    if not InCombatLockdown() then
        frame:SetSize(frame.unitWidth, frame.unitHeight)
        frame:ClearAllPoints()

        if GW.GetSetting("RAID10_ENABLED") and not frame:IsEnabled() then
            frame:Enable()
        elseif not GW.GetSetting("RAID10_ENABLED") and frame:IsEnabled() then
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
    --GW.UpdatePrivateAurasSettings(frame)
    GW.Update_RangeIndicator(frame)

    frame:UpdateAllElements("Gw2_UpdateAllElements")
end
GW.UpdateGridRaid10Frame = UpdateGridRaid10Frame
