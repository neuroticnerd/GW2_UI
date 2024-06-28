local _, GW = ...
local L = GW.L
local addOption = GW.AddOption
local addOptionSlider = GW.AddOptionSlider
local createCat = GW.CreateCat
local InitPanel = GW.InitPanel
local settingsMenuAddButton = GW.settingsMenuAddButton;

local function LoadTargetPanel(sWindow)
    local p = CreateFrame("Frame", nil, sWindow.panels, "GwSettingsPanelTmpl")
    p.header:Hide()
    p.sub:Hide()

    local pPlayerPet = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    pPlayerPet.header:SetFont(DAMAGE_TEXT_FONT, 20)
    pPlayerPet.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pPlayerPet.header:SetText(UNITFRAME_LABEL)
    pPlayerPet.sub:SetFont(UNIT_NAME_FONT, 12)
    pPlayerPet.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    pPlayerPet.sub:SetText(L["Modify the player pet frame settings."])
    pPlayerPet.header:SetWidth(pPlayerPet.header:GetStringWidth())
    pPlayerPet.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    pPlayerPet.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pPlayerPet.breadcrumb:SetText(PET)

    local p_target = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    p_target.header:SetFont(DAMAGE_TEXT_FONT, 20)
    p_target.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_target.header:SetText(UNITFRAME_LABEL)
    p_target.sub:SetFont(UNIT_NAME_FONT, 12)
    p_target.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    p_target.sub:SetText(L["Modify the target frame settings."])
    p_target.header:SetWidth(p_target.header:GetStringWidth())
    p_target.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    p_target.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_target.breadcrumb:SetText(TARGET)

    local pTargetOfTarget = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    pTargetOfTarget.header:SetFont(DAMAGE_TEXT_FONT, 20)
    pTargetOfTarget.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pTargetOfTarget.header:SetText(UNITFRAME_LABEL)
    pTargetOfTarget.sub:SetFont(UNIT_NAME_FONT, 12)
    pTargetOfTarget.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    pTargetOfTarget.sub:SetText(L["Modify the target of target frame settings."])
    pTargetOfTarget.header:SetWidth(pTargetOfTarget.header:GetStringWidth())
    pTargetOfTarget.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    pTargetOfTarget.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pTargetOfTarget.breadcrumb:SetText(SHOW_TARGET_OF_TARGET_TEXT)

    local p_focus = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    p_focus.header:SetFont(DAMAGE_TEXT_FONT, 20)
    p_focus.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_focus.header:SetText(UNITFRAME_LABEL)
    p_focus.sub:SetFont(UNIT_NAME_FONT, 12)
    p_focus.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    p_focus.sub:SetText(L["Modify the focus frame settings."])
    p_focus.header:SetWidth(p_focus.header:GetStringWidth())
    p_focus.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    p_focus.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    p_focus.breadcrumb:SetText(FOCUS)

    local pTargetOfFocus = CreateFrame("Frame", nil, p, "GwSettingsPanelScrollTmpl")
    pTargetOfFocus.header:SetFont(DAMAGE_TEXT_FONT, 20)
    pTargetOfFocus.header:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pTargetOfFocus.header:SetText(UNITFRAME_LABEL)
    pTargetOfFocus.sub:SetFont(UNIT_NAME_FONT, 12)
    pTargetOfFocus.sub:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    pTargetOfFocus.sub:SetText(L["Modify the target of target frame settings."])
    pTargetOfFocus.header:SetWidth(pTargetOfFocus.header:GetStringWidth())
    pTargetOfFocus.breadcrumb:SetFont(DAMAGE_TEXT_FONT, 12)
    pTargetOfFocus.breadcrumb:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    pTargetOfFocus.breadcrumb:SetText(SHOW_TARGET_OF_TARGET_TEXT)

    createCat(UNITFRAME_LABEL, L["Edit the target frame settings."], p, {pPlayerPet, p_target, pTargetOfTarget, p_focus, pTargetOfFocus})
    settingsMenuAddButton(UNITFRAME_LABEL, p, {pPlayerPet, p_target, pTargetOfTarget, p_focus, pTargetOfFocus})

    --PET
    addOption(pPlayerPet.scroll.scrollchild, L["Display Portrait Damage"], L["Display Portrait Damage on this frame"], "PET_FLOATING_COMBAT_TEXT", GW.TogglePetFrameCombatFeedback, nil, {["PETBAR_ENABLED"] = true})
    addOption(pPlayerPet.scroll.scrollchild, L["Show auras below"], nil, "PET_AURAS_UNDER", function() GW.TogglePetAuraPosition() end, nil, {["PETBAR_ENABLED"] = true})

--TARGET
    addOption(p_target.scroll.scrollchild, SHOW_ENEMY_CAST, nil, "target_SHOW_CASTBAR", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT, L["Show health as a numerical value."], "target_HEALTH_VALUE_ENABLED", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, RAID_HEALTH_TEXT_PERC, L["Display health as a percentage. Can be used as well as, or instead of Health Value."], "target_HEALTH_VALUE_TYPE", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, CLASS_COLORS, L["Display the class color as the health bar."], "target_CLASS_COLOR", function() GW.ToggleTargetFrameSettings(); GW.ToggleTargetTargetFrameSetting("Target") end, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, SHOW_DEBUFFS, L["Display the target's debuffs that you have inflicted."], "target_DEBUFFS", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Dungeon & Raid Debuffs"], L["Show important Dungeon & Raid debuffs"], "target_BUFFS_FILTER_IMPORTANT", GW.ToggleTargetFrameSetting, nil, {["TARGET_ENABLED"] = true, ["target_DEBUFFS"] = true})
    addOption(p_target.scroll.scrollchild, SHOW_ALL_ENEMY_DEBUFFS_TEXT, L["Display all of the target's debuffs."], "target_BUFFS_FILTER_ALL", GW.ToggleTargetFrameSetting, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, SHOW_BUFFS, L["Display the target's buffs."], "target_BUFFS", GW.ToggleTargetFrameSetting, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Display Average Item Level"], L["Display the average item level instead of prestige level for friendly units."], "target_SHOW_ILVL", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Show Threat"], L["Show Threat"], "target_THREAT_VALUE_ENABLED", GW.ToggleTargetFrameSetting, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Show Combo Points on Target"], L["Show combo points on target, below the health bar"], "target_HOOK_COMBOPOINTS", function() GW.ShowRlPopup = true end, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Advanced Casting Bar"], L["Enable or disable the advanced casting bar."], "target_CASTINGBAR_DATA", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, BUFFS_ON_TOP, nil, "target_AURAS_ON_TOP", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true, ["target_SHOW_CASTBAR"] = true})
    addOption(p_target.scroll.scrollchild, L["Display Portrait Damage"], L["Display Portrait Damage on this frame"], "target_FLOATING_COMBAT_TEXT", GW.ToggleTargetFrameCombatFeedback, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Invert target frame"], nil, "target_FRAME_INVERT", function() GW.ShowRlPopup = true end, nil, {["TARGET_ENABLED"] = true})
    addOption(p_target.scroll.scrollchild, L["Show alternative background texture"], nil, "target_FRAME_ALT_BACKGROUND", GW.ToggleTargetFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOptionSlider(
        p_target.scroll.scrollchild,
        L["Aura size"],
        nil,
        "target_ICON_SIZE",
        function()
            GW.UpdateBuffLayout(GwTargetUnitFrame, nil)
        end,
        16,
        60,
        nil,
        0,
        {["TARGET_ENABLED"] = true},
        2
    )

    --TARGET OF TARGET
    addOption(pTargetOfTarget.scroll.scrollchild, SHOW_TARGET_OF_TARGET_TEXT, L["Enable the target of target frame."], "target_TARGET_ENABLED", function() GW.ShowRlPopup = true end, nil, {["TARGET_ENABLED"] = true})
    addOption(pTargetOfTarget.scroll.scrollchild, SHOW_ENEMY_CAST, nil, "target_TARGET_SHOW_CASTBAR", function() GW.ToggleTargetTargetFrameSetting("Target") end, nil, {["TARGET_ENABLED"] = true, ["target_TARGET_ENABLED"] = true})

    --FOCUS
    addOption(p_focus.scroll.scrollchild, SHOW_ENEMY_CAST, nil, "focus_SHOW_CASTBAR", GW.ToggleFocusFrameSettings, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT, L["Show health as a numerical value."], "focus_HEALTH_VALUE_ENABLED", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, RAID_HEALTH_TEXT_PERC, L["Display health as a percentage. Can be used as well as, or instead of Health Value."], "focus_HEALTH_VALUE_TYPE", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, CLASS_COLORS, L["Display the class color as the health bar."], "focus_CLASS_COLOR", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, SHOW_DEBUFFS, L["Display the target's debuffs that you have inflicted."], "focus_DEBUFFS", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, L["Dungeon & Raid Debuffs"], L["Show important Dungeon & Raid debuffs"], "focus_BUFFS_FILTER_IMPORTANT", GW.ToggleTargetTargetFrameSetting, nil, {["TARGET_ENABLED"] = true, ["focus_DEBUFFS"] = true})
    addOption(p_focus.scroll.scrollchild, SHOW_ALL_ENEMY_DEBUFFS_TEXT, L["Display all of the target's debuffs."], "focus_BUFFS_FILTER_ALL", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true, ["focus_DEBUFFS"] = true})
    addOption(p_focus.scroll.scrollchild, SHOW_BUFFS, L["Display the target's buffs."], "focus_BUFFS", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, BUFFS_ON_TOP, nil, "focus_AURAS_ON_TOP", GW.ToggleFocusFrameSettings, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, L["Invert focus frame"], nil, "focus_FRAME_INVERT", function() GW.ShowRlPopup = true end, nil, {["FOCUS_ENABLED"] = true})
    addOption(p_focus.scroll.scrollchild, L["Show alternative background texture"], nil, "focus_FRAME_ALT_BACKGROUND", GW.ToggleFocusFrameSettings, nil, {["TARGET_ENABLED"] = true})
    addOptionSlider(
        p_focus.scroll.scrollchild,
        L["Aura size"],
        nil,
        "focus_ICON_SIZE",
        function()
            GW.UpdateBuffLayout(GwFocusUnitFrame, nil)
        end,
        16,
        60,
        nil,
        0,
        {["FOCUS_ENABLED"] = true},
        2
    )

    --TARGET OF FOCUS
    addOption(pTargetOfFocus.scroll.scrollchild, MINIMAP_TRACKING_FOCUS, L["Display the focus target frame."], "focus_TARGET_ENABLED", function() GW.ShowRlPopup = true end, nil, {["FOCUS_ENABLED"] = true})
    addOption(pTargetOfFocus.scroll.scrollchild, SHOW_ENEMY_CAST, nil, "focus_TARGET_SHOW_CASTBAR", GW.ToggleTargetTargetFrameSetting, nil, {["FOCUS_ENABLED"] = true, ["focus_TARGET_ENABLED"] = true})

    InitPanel(pPlayerPet, true)
    InitPanel(p_target, true)
    InitPanel(pTargetOfTarget, true)
    InitPanel(p_focus, true)
    InitPanel(pTargetOfFocus, true)
end
GW.LoadTargetPanel = LoadTargetPanel
