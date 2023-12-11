local _, GW = ...
local L = GW.L

local function UpdateFramePositionForLayout(layout, layoutManager, updateDropdown, startUp)
    if updateDropdown then
        GwSmallSettingsContainer.layoutView.savedLayoutDropDown.button.string:SetText(layout.name)
        GwSmallSettingsContainer.layoutView.savedLayoutDropDown.button.layoutName = layout.name
        GwSmallSettingsContainer.layoutView.savedLayoutDropDown.button.selectedId = layout.id
        GwSmallSettingsContainer.layoutView.savedLayoutDropDown.button.setByUpdateFramePositionForLayout = true

        GwSmallSettingsContainer.layoutView.specsDropDown.container.contentScroll.update(GwSmallSettingsContainer.layoutView.specsDropDown.container.contentScroll)

        GwSmallSettingsContainer.layoutView.delete:SetEnabled(not layout.profileLayout)
        GwSmallSettingsContainer.layoutView.rename:SetEnabled(not layout.profileLayout)
    end

    for k, _ in pairs(layout.frames) do
        local frame = layout.frames[k]
        if frame and frame.settingName and _G["Gw_" .. frame.settingName] and frame.point and frame.point.point and frame.point.relativePoint and frame.point.xOfs and frame.point.yOfs then
            _G["Gw_" .. frame.settingName]:ClearAllPoints()
            _G["Gw_" .. frame.settingName]:SetPoint(frame.point.point, UIParent, frame.point.relativePoint, frame.point.xOfs, frame.point.yOfs)
            if not startUp then
                _G["Gw_" .. frame.settingName]:GetScript("OnDragStop")(_G["Gw_" .. frame.settingName])
            end
        end
    end

    if layoutManager then
        layoutManager:GetScript("OnEvent")(layoutManager)
    end
end

local function AssignLayoutToSpec(specwin, button, specId, layoutId, toSet)
    local allLayouts = GW.GetAllLayouts()
    local allPrivateLayouts = GW.GetAllPrivateLayouts()
    local privateLayoutSettings = GW.GetPrivateLayoutByLayoutId(layoutId)

    -- check if that check has already a layout assigned
    if toSet and privateLayoutSettings then
        for j = 0, #allPrivateLayouts do
            if allPrivateLayouts[j] and allPrivateLayouts[j].layoutId ~= privateLayoutSettings.layoutId then
                if allPrivateLayouts[j].assignedSpecs[specId] then
                    GW.Notice(L["Spec is already assigned to a layout!"])
                    button.checkbutton:SetChecked(false)
                    return
                end
            end
        end
    end

    button.checkbutton:SetChecked(toSet)

    if not privateLayoutSettings then
        local newIdx = #GW.GetAllPrivateLayouts() + 1
        GW.private.Layouts[newIdx] = {}
        GW.private.Layouts[newIdx].assignedSpecs = {}
        privateLayoutSettings = GW.private.Layouts[newIdx]
    end

    privateLayoutSettings.layoutName = allLayouts[layoutId].name
    privateLayoutSettings.layoutId = layoutId
    privateLayoutSettings.assignedSpecs[specId] = toSet

    if specwin.scrollContainer:IsShown() then
        specwin.scrollContainer:Hide()
    else
        specwin.scrollContainer:Show()
    end
end

local function loadSpecDropDown(specwin)
    local USED_DROPDOWN_HEIGHT

    local privateLayoutSettings = GW.GetAllPrivateLayouts()
    local privateLayoutToUse
    local offset = HybridScrollFrame_GetOffset(specwin)
    local specs = {}

    for index = 1, GetNumSpecializations() do
        local id, name, _, icon, role = GetSpecializationInfo(index)

        if id then
            specs[index] = {}
            specs[index].name = format("|T%s:14:14:0:0:64:64:4:60:4:60|t %s |cFF888888(%s)|r", icon, name, getglobal(role))
            specs[index].id = id
            specs[index].idx = index
        end
    end

    for i = 1, #specwin.buttons do
        local slot = specwin.buttons[i]

        local idx = i + offset
        if idx > #specs then
            -- empty row (blank starter row, final row, and any empty entries)
            slot:Hide()
            slot.specIdx = nil
        else
            privateLayoutToUse = nil
            slot.specIdx = specs[idx].idx

            slot.checkbutton:Show()
            slot.soundButton:Hide()

            slot.string:SetText(specs[idx].name)

            -- set the correct spec values
            for j = 0, #privateLayoutSettings do
                if privateLayoutSettings[j] and privateLayoutSettings[j].layoutId == specwin:GetParent():GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId then
                    privateLayoutToUse = privateLayoutSettings[j]
                    break
                end
            end
            if privateLayoutToUse then
                slot.checkbutton:SetChecked(privateLayoutToUse.assignedSpecs[slot.specIdx])
            else
                slot.checkbutton:SetChecked(false)
            end

            slot:Show()
        end
    end

    USED_DROPDOWN_HEIGHT = 20 * #specs
    HybridScrollFrame_Update(specwin, USED_DROPDOWN_HEIGHT, 120)
end

local function SetupSpecs(specwin)
    HybridScrollFrame_CreateButtons(specwin, "GwDropDownItemTmpl", 0, 0, "TOPLEFT", "TOPLEFT", 0, 0, "TOP", "BOTTOM")
    for i = 1, #specwin.buttons do
        local slot = specwin.buttons[i]
        slot:SetWidth(specwin:GetWidth())
        slot.string:SetFont(UNIT_NAME_FONT, 10)
        slot.hover:SetAlpha(0.5)
        if not slot.ScriptsHooked then
            slot:HookScript("OnClick", function()
                local toSet = true
                if slot.checkbutton:GetChecked() then
                    toSet = false
                end
                AssignLayoutToSpec(specwin, slot, slot.specIdx, specwin:GetParent():GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId, toSet)
            end)
            slot.checkbutton:HookScript("OnClick", function()
                local toSet = false
                if slot.checkbutton:GetChecked() then
                    toSet = true
                end
                AssignLayoutToSpec(specwin, slot, slot.specIdx, specwin:GetParent():GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId, toSet)
            end)
            slot:HookScript("OnEnter", function()
                slot.hover:Show()
            end)
            slot.checkbutton:HookScript("OnEnter", function()
                slot.hover:Show()
            end)
            slot:HookScript("OnLeave", function()
                slot.hover:Hide()
            end)
            slot.checkbutton:HookScript("OnLeave", function()
                slot.hover:Hide()
            end)

            slot.ScriptsHooked = true
        end
    end

    loadSpecDropDown(specwin)
end

local function loadLayoutDropDown(layoutwin)
    local USED_DROPDOWN_HEIGHT

    local offset = HybridScrollFrame_GetOffset(layoutwin)
    local savedLayouts = GW.GetAllLayouts()
    local layouts = {}
    local tableIndex = 1

    for k, _ in pairs(savedLayouts) do
        if savedLayouts[k] then
            layouts[tableIndex] = {}
            layouts[tableIndex].name = savedLayouts[k].name
            layouts[tableIndex].id = k
            layouts[tableIndex].isProfileLayout = savedLayouts[k].profileLayout
            tableIndex = tableIndex + 1
        end
    end

    table.sort(layouts, function(a, b)
        if a.isProfileLayout ~= b.isProfileLayout then
            return a.isProfileLayout
        elseif a.name and b.name then
            return a.name < b.name
        end
    end)

    for i = 1, #layoutwin.buttons do
        local slot = layoutwin.buttons[i]

        local idx = i + offset
        if idx > #layouts then
            -- empty row (blank starter row, final row, and any empty entries)
            slot:Hide()
            slot.id = nil
            slot.name = nil
        else
            slot.id = layouts[idx].id
            slot.name = layouts[idx].name

            slot.checkbutton:Hide()
            slot.string:ClearAllPoints()
            slot.string:SetPoint("LEFT", 5, 0)
            slot.soundButton:Hide()

            slot.string:SetText(slot.name)

            slot:Show()
        end
    end

    USED_DROPDOWN_HEIGHT = 20 * #layouts
    HybridScrollFrame_Update(layoutwin, USED_DROPDOWN_HEIGHT, 120)
end

local function SetupLayouts(layoutwin)
    HybridScrollFrame_CreateButtons(layoutwin, "GwDropDownItemTmpl", 0, 0, "TOPLEFT", "TOPLEFT", 0, 0, "TOP", "BOTTOM")
    for i = 1, #layoutwin.buttons do
        local slot = layoutwin.buttons[i]
        slot:SetWidth(layoutwin:GetWidth())
        slot.string:SetFont(UNIT_NAME_FONT, 10)
        slot.hover:SetAlpha(0.5)
        if not slot.ScriptsHooked then
            slot:HookScript("OnClick", function(self)
                layoutwin.displayButton.string:SetText(self.name)
                layoutwin.displayButton.layoutName = self.name
                layoutwin.displayButton.selectedId = self.id

                if layoutwin.scrollContainer:IsShown() then
                    layoutwin.scrollContainer:Hide()
                else
                    layoutwin.scrollContainer:Show()
                end
                loadSpecDropDown(layoutwin:GetParent():GetParent().specsDropDown.container.contentScroll)

                -- prevent profile layouts from deletion
                if self.id and GW.global.layouts[self.id] and GW.global.layouts[self.id].profileLayout then
                    GwSmallSettingsContainer.layoutView.delete:Disable()
                    GwSmallSettingsContainer.layoutView.rename:Disable()
                else
                    GwSmallSettingsContainer.layoutView.delete:Enable()
                    GwSmallSettingsContainer.layoutView.rename:Enable()
                end

                -- load layout
                UpdateFramePositionForLayout(GW.GetLayoutById(self.id))
            end)
            slot:HookScript("OnEnter", function()
                slot.hover:Show()
            end)
            slot.checkbutton:HookScript("OnEnter", function()
                slot.hover:Show()
            end)
            slot:HookScript("OnLeave", function()
                slot.hover:Hide()
            end)

            slot.ScriptsHooked = true
        end
    end

    loadLayoutDropDown(layoutwin)
end

local function CreateProfileLayout()
    local savedLayouts = GW.GetAllLayouts()
    local profileName = GW.globalSettings:GetCurrentProfile()
    local needToCreate = true

    if profileName then
        for i = 0, #savedLayouts do
            if savedLayouts[i] then
                if savedLayouts[i].profileLayout == true and savedLayouts[i].profileName == profileName then
                    needToCreate = false
                    break
                end
            end
        end
    end

    if needToCreate and profileName then
        local newIdx = #savedLayouts + 1
        local newMoverFrameIndex = 0
        GW.global.layouts[newIdx] = {}
        GW.global.layouts[newIdx].name = L["Profiles"] .. " - " .. profileName
        GW.global.layouts[newIdx].frames = {}
        GW.global.layouts[newIdx].id = newIdx
        GW.global.layouts[newIdx].profileLayout = true
        GW.global.layouts[newIdx].profileName = profileName
        for _, moveableFrame in pairs(GW.MOVABLE_FRAMES) do
            GW.global.layouts[newIdx].frames[newMoverFrameIndex] = {}
            GW.global.layouts[newIdx].frames[newMoverFrameIndex].settingName = moveableFrame.setting
            GW.global.layouts[newIdx].frames[newMoverFrameIndex].point = moveableFrame.savedPoint

            newMoverFrameIndex = newMoverFrameIndex + 1
        end
    end
end

local function CreateNewLayout(self)
    GW.InputPrompt(
        L["New layout name:"],
        function()
            if GwWarningPrompt.input:GetText() == nil then return end

            local savedLayouts = GW.GetAllLayouts()
            local newIdx = #savedLayouts + 1
            local newMoverFrameIndex = 0
            GW.global.layouts[newIdx] = {}
            GW.global.layouts[newIdx].name = (GwWarningPrompt.input:GetText() or UNKNOWN)
            GW.global.layouts[newIdx].frames = {}
            GW.global.layouts[newIdx].id = newIdx
            GW.global.layouts[newIdx].profileLayout = false
            for _, moveableFrame in pairs(GW.MOVABLE_FRAMES) do
                GW.global.layouts[newIdx].frames[newMoverFrameIndex] = {}
                GW.global.layouts[newIdx].frames[newMoverFrameIndex].settingName = moveableFrame.setting
                GW.global.layouts[newIdx].frames[newMoverFrameIndex].point = moveableFrame.savedPoint

                newMoverFrameIndex = newMoverFrameIndex + 1
            end
            loadLayoutDropDown(self:GetParent().savedLayoutDropDown.container.contentScroll)

            GwWarningPrompt:Hide()
        end
    )
end

local function DeleteSelectedLayout(self)
    GW.WarningPrompt(
        L["Are you sure you want to delete the selected layout?"],
        function()
            GW.global.layouts[self:GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId] = nil
            --also delete the assing settings
            GW.DeletePrivateLayoutByLayoutId(self:GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId)
            loadLayoutDropDown(self:GetParent().savedLayoutDropDown.container.contentScroll)

            self:GetParent().savedLayoutDropDown.button.string:SetText("")
            self:GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId = nil

            GwWarningPrompt:Hide()
        end
    )
end

local function RenameSelectedLayout(self)
    GW.InputPrompt(
        L["Rename layout:"],
        function()
            if GwWarningPrompt.input:GetText() == nil then return end
            GW.global.layouts[self:GetParent().savedLayoutDropDown.container.contentScroll.displayButton.selectedId].name = (GwWarningPrompt.input:GetText() or UNKNOWN)

            loadLayoutDropDown(self:GetParent().savedLayoutDropDown.container.contentScroll)

            self:GetParent().savedLayoutDropDown.button.string:SetText(GwWarningPrompt.input:GetText() or UNKNOWN)

            GwWarningPrompt:Hide()
        end,
        self:GetParent().savedLayoutDropDown.button.string:GetText()
    )
end

local function specSwitchHandlerOnEvent(self, event)
    local currentSpecIdx = GetSpecialization()

    if event == "PLAYER_SPECIALIZATION_CHANGED" and self.currentSpecIdx == currentSpecIdx then
        return
    end

    local privateLayoutSettings = GW.GetAllPrivateLayouts()
    local layoutIdToUse
    local layoutToUse

    self.currentSpecIdx = currentSpecIdx

    for i = 0, #privateLayoutSettings do
        if privateLayoutSettings[i] then
            if privateLayoutSettings[i].assignedSpecs[currentSpecIdx] ~= nil and privateLayoutSettings[i].assignedSpecs[currentSpecIdx] == true then
                layoutIdToUse = privateLayoutSettings[i].layoutId
                break
            end
        end
    end

    if layoutIdToUse then
        layoutToUse = GW.GetLayoutById(layoutIdToUse)
    end
    if layoutToUse then
        GW.Debug("Spec switch detected!", "Switch to Layout ID", layoutIdToUse, "With name:", layoutToUse.name)
    else
        local profileName = GW.globalSettings:GetCurrentProfile()
        local allLayouts = GW.GetAllLayouts()

        if profileName then
            for i = 0, #allLayouts do
                if allLayouts[i] then
                    if allLayouts[i].name == L["Profiles"] .. " - " .. profileName and allLayouts[i].profileLayout == true then
                        layoutToUse = allLayouts[i]
                        break
                    end
                end
            end

            if not layoutToUse then
                C_Timer.After(1, function() specSwitchHandlerOnEvent(self, event) end)
                return
            end

            GW.Debug("Spec switch detected!", "No assinged layout found! Switch to profile layout with name:", layoutToUse.name)
        else
            GW.Debug("Spec switch detected!", "No assinged layout found! No profile Layout found! Do nothing!")
        end
    end

    if layoutToUse and self.smallSettingsFrame.layoutView.savedLayoutDropDown.container.contentScroll.displayButton.selectedId ~= layoutToUse.id then
        UpdateFramePositionForLayout(layoutToUse, self.layoutManager, true, event == "PLAYER_ENTERING_WORLD")

        -- also do the migration here
        GW.Migration()
    end

    if event == "PLAYER_ENTERING_WORLD" then
        self:UnregisterEvent(event)
    end
end

local function LoadLayoutsFrame(smallSettingsFrame, layoutManager)
    smallSettingsFrame.layoutView = CreateFrame("Frame", nil, smallSettingsFrame, "GwLayoutView")
    smallSettingsFrame.layoutView.desc:SetFont(UNIT_NAME_FONT, 12)
    smallSettingsFrame.layoutView.desc:SetTextColor(181 / 255, 160 / 255, 128 / 255)
    smallSettingsFrame.layoutView.desc:SetText(L["Assign layouts to a spec. The layout will be automatically changed on a spec switch.\n\nLayouts has always priority for profile settings."])

    smallSettingsFrame.layoutView.savedLayoutDropDown.title:SetFont(DAMAGE_TEXT_FONT, 12)
    smallSettingsFrame.layoutView.savedLayoutDropDown.title:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    smallSettingsFrame.layoutView.savedLayoutDropDown.title:SetText("Layouts")

    smallSettingsFrame.layoutView.specsDropDown.title:SetFont(DAMAGE_TEXT_FONT, 12)
    smallSettingsFrame.layoutView.specsDropDown.title:SetTextColor(255 / 255, 241 / 255, 209 / 255)
    smallSettingsFrame.layoutView.specsDropDown.title:SetText(SPECIALIZATION)

    -- start with the current profile layout add it at the timer function in case this is the first login
    smallSettingsFrame.layoutView.specsDropDown.button.string:SetText(L["<Assign specializations>"])

    --create or get profile layout
    C_Timer.After(1, function()
        CreateProfileLayout()
        loadLayoutDropDown(smallSettingsFrame.layoutView.savedLayoutDropDown.container.contentScroll)
        if not smallSettingsFrame.layoutView.savedLayoutDropDown.button.setByUpdateFramePositionForLayout then
            -- get the current profile layout
            local allLayouts = GW.GetAllLayouts()
            local currentProfileName = GW.globalSettings:GetCurrentProfile()

            for i = 0, #allLayouts do
                if allLayouts[i] and allLayouts[i].profileName == currentProfileName then
                    smallSettingsFrame.layoutView.savedLayoutDropDown.button.string:SetText(allLayouts[i].name)
                    smallSettingsFrame.layoutView.savedLayoutDropDown.button.layoutName = allLayouts[i].name
                    smallSettingsFrame.layoutView.savedLayoutDropDown.button.selectedId = allLayouts[i].id

                    GwSmallSettingsContainer.layoutView.delete:Disable()
                    GwSmallSettingsContainer.layoutView.rename:Disable()
                    break
                end
            end
        end
    end)

    --load layout dropdown
    local layoutsScrollFrame = smallSettingsFrame.layoutView.savedLayoutDropDown.container.contentScroll
    layoutsScrollFrame.scrollBar.thumbTexture:SetSize(12, 30)
    layoutsScrollFrame.scrollBar:ClearAllPoints()
    layoutsScrollFrame.scrollBar:SetPoint("TOPRIGHT", -3, -12)
    layoutsScrollFrame.scrollBar:SetPoint("BOTTOMRIGHT", -3, 12)
    layoutsScrollFrame.scrollBar.scrollUp:SetPoint("TOPRIGHT", 0, 12)
    layoutsScrollFrame.scrollBar.scrollDown:SetPoint("BOTTOMRIGHT", 0, -12)
    layoutsScrollFrame.scrollBar:SetFrameLevel(layoutsScrollFrame:GetFrameLevel() + 5)
    layoutsScrollFrame.displayButton = smallSettingsFrame.layoutView.savedLayoutDropDown.button
    layoutsScrollFrame.scrollContainer = smallSettingsFrame.layoutView.savedLayoutDropDown.container
    layoutsScrollFrame:GetParent():SetParent(smallSettingsFrame.layoutView)

    layoutsScrollFrame.update = loadLayoutDropDown
    layoutsScrollFrame.scrollBar.doNotHide = false
    SetupLayouts(layoutsScrollFrame)

    smallSettingsFrame.layoutView.savedLayoutDropDown.button:SetScript("OnClick", function(self)
        local dd = self:GetParent()
        if dd.container:IsShown() then
            dd.container:Hide()
        else
            dd.container:Show()
        end
    end)

    --load spec dropdown
    local specScrollFrame = smallSettingsFrame.layoutView.specsDropDown.container.contentScroll
    specScrollFrame.scrollBar.thumbTexture:SetSize(12, 30)
    specScrollFrame.scrollBar:ClearAllPoints()
    specScrollFrame.scrollBar:SetPoint("TOPRIGHT", -3, -12)
    specScrollFrame.scrollBar:SetPoint("BOTTOMRIGHT", -3, 12)
    specScrollFrame.scrollBar.scrollUp:SetPoint("TOPRIGHT", 0, 12)
    specScrollFrame.scrollBar.scrollDown:SetPoint("BOTTOMRIGHT", 0, -12)
    specScrollFrame.scrollBar:SetFrameLevel(specScrollFrame:GetFrameLevel() + 5)
    specScrollFrame.displayButton = smallSettingsFrame.layoutView.specsDropDown.button
    specScrollFrame.scrollContainer = smallSettingsFrame.layoutView.specsDropDown.container
    specScrollFrame:GetParent():SetParent(smallSettingsFrame.layoutView)

    specScrollFrame.update = loadSpecDropDown
    specScrollFrame.scrollBar.doNotHide = false
    SetupSpecs(specScrollFrame)

    smallSettingsFrame.layoutView.specsDropDown.button:SetScript("OnClick", function(self)
        local dd = self:GetParent()
        if dd.container:IsShown() then
            dd.container:Hide()
        else
            dd.container:Show()
        end
    end)

    -- new, delete layout
    smallSettingsFrame.layoutView.new:SetScript("OnClick", CreateNewLayout)
    smallSettingsFrame.layoutView.delete:SetScript("OnClick", DeleteSelectedLayout)
    smallSettingsFrame.layoutView.rename:SetScript("OnClick", RenameSelectedLayout)

    -- specswitch detaction things
    local specSwitchHandler = CreateFrame("Frame")
    specSwitchHandler.currentSpecIdx = GetSpecialization() -- sometimes PLAYER_SPECIALIZATION_CHANGED fired twice, so we prevent a double call

    specSwitchHandler:RegisterEvent("PLAYER_ENTERING_WORLD") -- for start up
    specSwitchHandler:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    specSwitchHandler:SetScript("OnEvent", specSwitchHandlerOnEvent)
    specSwitchHandler.layoutManager = layoutManager
    specSwitchHandler.smallSettingsFrame = smallSettingsFrame
end
GW.LoadLayoutsFrame = LoadLayoutsFrame