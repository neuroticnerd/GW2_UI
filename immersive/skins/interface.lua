local _, GW = ...
local constBackdropFrameBorder = GW.skins.constBackdropFrameBorder
local SkinButton = GW.skins.SkinButton
local SkinDropDownMenu = GW.skins.SkinDropDownMenu
local SkinCheckButton = GW.skins.SkinCheckButton
local SkinTab = GW.skins.SkinTab
local SkinSliderFrame = GW.skins.SkinSliderFrame

local function SkinInterfaceOptions()
    local OptionsFrames = {_G.InterfaceOptionsFrameCategories, _G.InterfaceOptionsFramePanelContainer, _G.InterfaceOptionsFrameAddOns}
    local InterfaceOptions = {
        _G.InterfaceOptionsFrame, 
        _G.InterfaceOptionsControlsPanel,
        _G.InterfaceOptionsCombatPanel,
        _G.InterfaceOptionsCombatPanelEnemyCastBars,
        _G.InterfaceOptionsCombatTextPanel,
        _G.InterfaceOptionsDisplayPanel,
        _G.InterfaceOptionsObjectivesPanel,
        _G.InterfaceOptionsSocialPanel,
        _G.InterfaceOptionsActionBarsPanel,
        _G.InterfaceOptionsNamesPanel,
        _G.InterfaceOptionsNamesPanelFriendly,
        _G.InterfaceOptionsNamesPanelEnemy,
        _G.InterfaceOptionsNamesPanelUnitNameplates,
        _G.InterfaceOptionsBattlenetPanel,
        _G.InterfaceOptionsCameraPanel,
        _G.InterfaceOptionsMousePanel,
        _G.InterfaceOptionsHelpPanel,
        _G.InterfaceOptionsAccessibilityPanel,
        _G.CompactUnitFrameProfiles,
        _G.CompactUnitFrameProfilesGeneralOptionsFrame,
        }

    local InterfaceOptionsFrame = _G.InterfaceOptionsFrame

    InterfaceOptionsFrame.Header.CenterBG:Hide()
    InterfaceOptionsFrame.Header.RightBG:Hide()
    InterfaceOptionsFrame.Header.LeftBG:Hide()
    InterfaceOptionsFrame.Header.Text:SetFont(DAMAGE_TEXT_FONT, 20, "OUTLINE")

    InterfaceOptionsFrame.Border:Hide()
    local tex = InterfaceOptionsFrame:CreateTexture("bg", "BACKGROUND")
    tex:SetPoint("TOP", InterfaceOptionsFrame, "TOP", 0, 25)
    tex:SetTexture("Interface/AddOns/GW2_UI/textures/party/manage-group-bg")
    local w, h = InterfaceOptionsFrame:GetSize()
    tex:SetSize(w + 50, h + 50)
    InterfaceOptionsFrame.tex = tex

    for _, Frame in pairs(OptionsFrames) do
		Frame:SetBackdrop(constBackdropFrameBorder)
    end

    for _, Panel in pairs(InterfaceOptions) do
		if Panel then
			for i = 1, Panel:GetNumChildren() do
				local Child = select(i, Panel:GetChildren())
				if Child:IsObjectType("CheckButton") then
                    SkinCheckButton(Child)
                    Child:SetSize(15, 15)
                elseif Child:IsObjectType("Button") then
                    if Child == InterfaceOptionsFrameTab1 or Child == InterfaceOptionsFrameTab2 then
                        SkinTab(Child)
                    else
                        SkinButton(Child, false, true)
                    end
				elseif Child:IsObjectType('Slider') then
					SkinSliderFrame(Child)
				elseif Child:IsObjectType("Tab") then
                    SkinTab(Child)
				elseif Child:IsObjectType("Frame") and Child.Left and Child.Middle and Child.Right then
					SkinDropDownMenu(Child)
				end
			end
		end
    end

    _G.AudioOptionsVoicePanel.TestInputDevice.ToggleTest.Texture:SetTexture()

    _G.AudioOptionsVoicePanel.TestInputDevice.ToggleTest:SetPushedTexture("Interface\\AddOns\\GW2_UI\\textures\\bubble_down")
    _G.AudioOptionsVoicePanel.TestInputDevice.ToggleTest:SetNormalTexture("Interface\\AddOns\\GW2_UI\\textures\\bubble_up")
    _G.AudioOptionsVoicePanel.TestInputDevice.ToggleTest:SetHighlightTexture("Interface\\AddOns\\GW2_UI\\textures\\bubble_down")

    --Create New Raid Profle
	local newProfileDialog = _G.CompactUnitFrameProfilesNewProfileDialog
	if newProfileDialog then
        local tex = newProfileDialog:CreateTexture("bg", "BACKGROUND")
        tex:SetPoint("TOP", newProfileDialog, "TOP", 0, 0)
        tex:SetSize(newProfileDialog:GetSize())
        tex:SetTexture("Interface/AddOns/GW2_UI/textures/party/manage-group-bg")
        newProfileDialog.tex = tex

        newProfileDialog.Border:Hide()

		SkinDropDownMenu(_G.CompactUnitFrameProfilesNewProfileDialogBaseProfileSelector)
		SkinButton(_G.CompactUnitFrameProfilesNewProfileDialogCreateButton, false, true)
		SkinButton(_G.CompactUnitFrameProfilesNewProfileDialogCancelButton, false, true)

        if newProfileDialog.editBox then
            _G[newProfileDialog.editBox:GetName() .. "Left"]:Hide()
            _G[newProfileDialog.editBox:GetName() .. "Right"]:Hide()
            _G[newProfileDialog.editBox:GetName() .. "Mid"]:SetTexture("Interface/AddOns/GW2_UI/textures/gwstatusbar-bg")
            _G[newProfileDialog.editBox:GetName() .. "Mid"]:ClearAllPoints()
            _G[newProfileDialog.editBox:GetName() .. "Mid"]:SetPoint("TOPLEFT", _G[newProfileDialog.editBox:GetName() .. "Left"], "BOTTOMRIGHT", -25, 3)
            _G[newProfileDialog.editBox:GetName() .. "Mid"]:SetPoint("BOTTOMRIGHT", _G[newProfileDialog.editBox:GetName() .. "Right"], "TOPLEFT", 25, -3)
		end
    end
    
    --Delete Raid Profile
	local deleteProfileDialog = _G.CompactUnitFrameProfilesDeleteProfileDialog
	if deleteProfileDialog then
		local tex = deleteProfileDialog:CreateTexture("bg", "BACKGROUND")
        tex:SetPoint("TOP", deleteProfileDialog, "TOP", 0, 0)
        tex:SetSize(deleteProfileDialog:GetSize())
        tex:SetTexture("Interface/AddOns/GW2_UI/textures/party/manage-group-bg")
        deleteProfileDialog.tex = tex

        deleteProfileDialog.Border:Hide()

		SkinButton(_G.CompactUnitFrameProfilesDeleteProfileDialogDeleteButton, false, true)
		SkinButton(_G.CompactUnitFrameProfilesDeleteProfileDialogCancelButton, false, true)
	end
end
GW.SkinInterfaceOptions = SkinInterfaceOptions