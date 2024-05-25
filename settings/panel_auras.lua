local _, GW = ...
local L = GW.L
local addOption = GW.AddOption
local addOptionDropdown = GW.AddOptionDropdown
local addOptionText = GW.AddOptionText
local addOptionSlider = GW.AddOptionSlider
local createCat = GW.CreateCat
local GetSetting = GW.GetSetting
local SetSetting = GW.SetSetting
local InitPanel = GW.InitPanel
local settingsMenuAddButton = GW.settingsMenuAddButton

local function LoadAurasPanel(sWindow)
    local p = CreateFrame("Frame", nil, sWindow.panels, "GwSettingsPanelTmpl")
    p.header:Hide()
    p.sub:Hide()

    local p_auras = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    p_auras.header:SetFont(DAMAGE_TEXT_FONT, 20)
    p_auras.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_auras.header:SetText(L["Raid Auras"])
    p_auras.sub:SetFont(UNIT_NAME_FONT, 12)
    p_auras.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    p_auras.sub:SetText(L["Edit which buffs and debuffs are shown."])

    p_auras.header:SetWidth(p_auras.header:GetStringWidth())
    p_auras.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    p_auras.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_auras.breadcrumb:SetText(GENERAL)

    local p_indicator = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")

    p_indicator.header:SetFont(DAMAGE_TEXT_FONT, 20)
    p_indicator.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_indicator.header:SetText(L["Raid Auras"])
    p_indicator.sub:SetFont(UNIT_NAME_FONT, 12)
    p_indicator.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    p_indicator.sub:SetText(L["Edit raid aura indicators."])

    p_indicator.header:SetWidth(p_indicator.header:GetStringWidth())
    p_indicator.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    p_indicator.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_indicator.breadcrumb:SetText(L["Raid Indicators"])


    createCat(L["Raid Auras"], L["Show or hide auras and edit raid aura indicators."], p, {p_auras, p_indicator})
    settingsMenuAddButton(L["Raid Auras"], p, {p_auras, p_indicator})

    addOptionText(p_auras.scroll.scrollchild, L["Ignored Auras"], L["A list of auras that should never be shown."], "AURAS_IGNORED", function() GW.UpdateGridSettings("ALL", false) end, nil, nil, {["RAID_FRAMES"] = true})
    addOptionText(p_auras.scroll.scrollchild, L["Missing Buffs"], L["A list of buffs that should only be shown when they are missing."], "AURAS_MISSING", function() GW.UpdateGridSettings("ALL", false) end, nil, nil, {["RAID_FRAMES"] = true})

    local raidDebuffKeys, raidDebuffVales = {}, {}
    local settingstable = GetSetting("RAIDDEBUFFS")
    for spellID, _ in pairs(GW.ImportendRaidDebuff) do

        if spellID and GetSpellInfo(spellID) then
            local name = format("%s |cFF888888(%d)|r", GetSpellInfo(spellID), spellID)
            tinsert(raidDebuffKeys, spellID)
            tinsert(raidDebuffVales, name)

            GW.ImportendRaidDebuff[spellID] = settingstable[spellID]
        end
    end
    addOptionDropdown(
        p_auras.scroll.scrollchild,
        L["Dungeon & Raid Debuffs"],
        L["Show important Dungeon & Raid debuffs"],
        "RAIDDEBUFFS",
        function(toSet, id)
            GW.ImportendRaidDebuff[id] = toSet
        end,
        raidDebuffKeys,
        raidDebuffVales,
        nil,
        nil,
        true,
        nil,
        "spell"
    )
    addOptionSlider(
        p_auras.scroll.scrollchild,
        L["Set important Dungeon & Raid debuff scale"],
        nil,
        "RAIDDEBUFFS_Scale",
        function()
            GW.UpdateGridSettings("ALL", false)
        end,
        0.5,
        2,
        nil,
        2
    )
    addOptionSlider(
        p_auras.scroll.scrollchild,
        L["Set dispellable debuff scale"],
        nil,
        "DISPELL_DEBUFFS_Scale",
        function()
            GW.UpdateGridSettings("ALL", false)
        end,
        0.5,
        2,
        nil,
        2
    )
    addOptionDropdown(
        p_auras.scroll.scrollchild,
        L["Important & dispellable debuff scale priority"],
        L["If both scales could apply to a debuff, which one should be used"],
        "RAIDDEBUFFS_DISPELLDEBUFF_SCALE_PRIO",
        nil,
        {"DISPELL", "IMPORTANT", "OFF"},
        {L["Dispell > Important"], L["Important > Dispell"]}
    )

    addOption(p_indicator.scroll.scrollchild, L["Show Spell Icons"], L["Show spell icons instead of monochrome squares."], "INDICATORS_ICON", function() GW.UpdateGridSettings("ALL", false) end, nil, {["RAID_FRAMES"] = true})
    addOption(p_indicator.scroll.scrollchild, L["Show Remaining Time"], L["Show the remaining aura time as an animated overlay."], "INDICATORS_TIME", function() GW.UpdateGridSettings("ALL", false) end, nil, {["RAID_FRAMES"] = true})

    local auraKeys, auraVals = {0}, {NONE_KEY}
    for spellID, _ in pairs(GW.AURAS_INDICATORS[GW.myclass]) do
        if GetSpellInfo(spellID) then
            local name = GetSpellInfo(spellID)
            tinsert(auraKeys, spellID)
            tinsert(auraVals, name)
            C_Spell.RequestLoadSpellData(spellID)
        end
    end

    for v, pos in ipairs(GW.INDICATORS) do
        local key = "INDICATOR_" .. pos
        local t = L[GW.indicatorsText[v]]
        addOptionDropdown(
            p_indicator.scroll.scrollchild,
            L["%s Indicator"]:format(t),
            L["Edit %s raid aura indicator."]:format(t),
            key,
            function()
                GW.settings[key] = tonumber(GW.settings[key])
                GW.UpdateGridSettings("ALL", false)
            end,
            auraKeys,
            auraVals,
            {perSpec = true},
            {["RAID_FRAMES"] = true},
            nil,
            nil,
            "spell"
        )
    end

    InitPanel(p_auras, true)
    InitPanel(p_indicator, true)
end
GW.LoadAurasPanel = LoadAurasPanel
