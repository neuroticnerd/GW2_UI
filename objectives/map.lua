local _, GW = ...
local L = GW.L
local GetSetting = GW.GetSetting
local SetSetting = GW.SetSetting
local RoundDec = GW.RoundDec

local MAP_FRAMES_HIDE = {}
MAP_FRAMES_HIDE[1] = MiniMapMailIcon
MAP_FRAMES_HIDE[2] = MiniMapVoiceChatFrame
MAP_FRAMES_HIDE[3] = MiniMapTrackingButton
MAP_FRAMES_HIDE[4] = MiniMapTracking

local M = CreateFrame("Frame")

local MAP_FRAMES_HOVER = {}

local function SetMinimapHover()
    local hoverSetting = GetSetting("MINIMAP_HOVER")

    wipe(MAP_FRAMES_HOVER)

    if hoverSetting == "NONE" then
        MAP_FRAMES_HOVER[1] = GwMapGradient
        MAP_FRAMES_HOVER[2] = Minimap.location
        MAP_FRAMES_HOVER[3] = GwMapTime
        MAP_FRAMES_HOVER[4] = GwMapCoords
    elseif hoverSetting == "CLOCK" then
        MAP_FRAMES_HOVER[1] = GwMapGradient
        MAP_FRAMES_HOVER[2] = Minimap.location
        MAP_FRAMES_HOVER[3] = GwMapCoords
    elseif hoverSetting == "ZONE" then
        MAP_FRAMES_HOVER[1] = GwMapTime
        MAP_FRAMES_HOVER[2] = GwMapCoords
    elseif hoverSetting == "COORDS" then
        MAP_FRAMES_HOVER[1] = GwMapGradient
        MAP_FRAMES_HOVER[2] = Minimap.location
        MAP_FRAMES_HOVER[3] = GwMapTime
    elseif hoverSetting == "CLOCKZONE" then
        MAP_FRAMES_HOVER[1] = GwMapCoords
    elseif hoverSetting == "CLOCKCOORDS" then
        MAP_FRAMES_HOVER[1] = GwMapGradient
        MAP_FRAMES_HOVER[2] = Minimap.location
    elseif hoverSetting == "ZONECOORDS" then
        MAP_FRAMES_HOVER[1] = GwMapTime
    end

    -- show all and hide not needes
    GwMapGradient:SetAlpha(1)
    Minimap.location:SetAlpha(1)
    GwMapTime:SetAlpha(1)
    GwMapCoords:SetAlpha(1)

    GW.hoverMiniMapOut()
end
GW.SetMinimapHover = SetMinimapHover

local function hideMiniMapIcons()
    for _, v in pairs(MAP_FRAMES_HIDE) do
        if v then
            v:Hide()
            v:SetScript(
                "OnShow",
                function(self)
                    self:Hide()
                end
            )
        end
    end
end
GW.AddForProfiling("map", "hideMiniMapIcons", hideMiniMapIcons)

local function MapCoordsMiniMap_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
    GameTooltip:AddLine(L["Map Coordinates"])
    GameTooltip:AddLine(L["Left Click to toggle higher precision coordinates."], 1, 1, 1, true)
    GameTooltip:SetMinimumWidth(100)
    GameTooltip:Show()
end
GW.AddForProfiling("map", "MapCoordsMiniMap_OnEnter", MapCoordsMiniMap_OnEnter)

local function mapCoordsMiniMap_setCoords(self)
    if GW.locationData.x and GW.locationData.y then
        self.Coords:SetText(RoundDec(GW.locationData.xText, self.MapCoordsMiniMapPrecision) .. ", " .. RoundDec(GW.locationData.yText, self.MapCoordsMiniMapPrecision))
    else
        self.Coords:SetText(NOT_APPLICABLE)
    end
end
GW.AddForProfiling("map", "mapCoordsMiniMap_setCoords", mapCoordsMiniMap_setCoords)

local function MapCoordsMiniMap_OnClick(self, button)
    if button == "LeftButton" then
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)

        if self.MapCoordsMiniMapPrecision == 0 then
            self.MapCoordsMiniMapPrecision = 2
        else
            self.MapCoordsMiniMapPrecision = 0
        end

        SetSetting("MINIMAP_COORDS_PRECISION", self.MapCoordsMiniMapPrecision)
        mapCoordsMiniMap_setCoords(self)
    end
end
GW.AddForProfiling("map", "MapCoordsMiniMap_OnClick", MapCoordsMiniMap_OnClick)

local function hoverMiniMap()
    for _, v in ipairs(MAP_FRAMES_HOVER) do
        if v then
            UIFrameFadeIn(v, 0.2, v:GetAlpha(), 1)
            if v == GwMapCoords then
                v.CoordsTimer = C_Timer.NewTicker(0.1, function() mapCoordsMiniMap_setCoords(v) end)
            end
        end
    end
end
GW.AddForProfiling("map", "hoverMiniMap", hoverMiniMap)

local function hoverMiniMapOut()
    for _, v in ipairs(MAP_FRAMES_HOVER) do
        if v then
            UIFrameFadeOut(v, 0.2, v:GetAlpha(), 0)
            if v == GwMapCoords then
                v:SetScript("OnUpdate", nil)
                if v.CoordsTimer then
                    v.CoordsTimer:Cancel()
                    v.CoordsTimer = nil
                end
            end
        end
    end
end
GW.hoverMiniMapOut = hoverMiniMapOut
GW.AddForProfiling("map", "hoverMiniMapOut", hoverMiniMapOut)

local function GetMinimapShape()
    return "SQUARE"
end

local function minimap_OnShow()
    if GwAddonToggle and GwAddonToggle.gw_Showing then
        GwAddonToggle:Show()
    end
    if GwMailButton and GwMailButton.gw_Showing then
        GwMailButton:Show()
    end
end
GW.AddForProfiling("map", "minimap_OnShow", minimap_OnShow)

local function minimap_OnHide()
    if GwAddonToggle then
        GwAddonToggle:Hide()
    end
    if GwMailButton then
        GwMailButton:Hide()
    end
end
GW.AddForProfiling("map", "minimap_OnHide", minimap_OnHide)

local function setMinimapButtons(side)
    local expButton = ExpansionLandingPageMinimapButton or GarrisonLandingPageMinimapButton
    QueueStatusButton:ClearAllPoints()
    GameTimeFrame:ClearAllPoints()
    expButton:ClearAllPoints()
    GwMailButton:ClearAllPoints()
    GwAddonToggle:ClearAllPoints()
    GwAddonToggle.container:ClearAllPoints()

    if side == "left" then
        GameTimeFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -5, -2)
        GwMailButton:SetPoint("TOP", GameTimeFrame, "BOTTOM", 0, 0)
        QueueStatusButton:SetPoint("TOP", GwMailButton, "BOTTOM", 0, 0)
        GwAddonToggle:SetPoint("TOP", QueueStatusButton, "BOTTOM", -3, 0)
        GwAddonToggle.container:SetPoint("RIGHT", GwAddonToggle, "LEFT")
        expButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", 0, -3)

        --flip GwAddonToggle icon

        GwAddonToggle:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
        GwAddonToggle:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
        GwAddonToggle:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
    else
        GameTimeFrame:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 5, -2)
        GwMailButton:SetPoint("TOP", GameTimeFrame, "BOTTOM", 0, 0)
        QueueStatusButton:SetPoint("TOP", GwMailButton, "BOTTOM", 0, 0)
        GwAddonToggle:SetPoint("TOP", QueueStatusButton, "BOTTOM", 3, 0)
        GwAddonToggle.container:SetPoint("LEFT", GwAddonToggle, "RIGHT")
        expButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMRIGHT", 2, -3)

        --flip GwAddonToggle icon

        GwAddonToggle:GetNormalTexture():SetTexCoord(1, 0, 0, 1)
        GwAddonToggle:GetHighlightTexture():SetTexCoord(1, 0, 0, 1)
        GwAddonToggle:GetPushedTexture():SetTexCoord(1, 0, 0, 1)

    end

    QueueStatusButton:SetParent(UIParent)
end
GW.setMinimapButtons = setMinimapButtons

local function MinimapPostDrag(self)
    MinimapBackdrop:ClearAllPoints()
    MinimapBackdrop:SetAllPoints(Minimap)

    local x = self.gwMover:GetCenter()
    local screenWidth = UIParent:GetRight()
    if x > (screenWidth / 2) then
        GW.setMinimapButtons("left")
    else
        GW.setMinimapButtons("right")
    end
end

local function ToogleMinimapCoorsLable()
    if GetSetting("MINIMAP_COORDS_TOGGLE") then
        GwMapCoords:Show()
        GwMapCoords:SetScript("OnEnter", MapCoordsMiniMap_OnEnter)
        GwMapCoords:SetScript("OnClick", MapCoordsMiniMap_OnClick)
        GwMapCoords:SetScript("OnLeave", GameTooltip_Hide)

        -- only set the coords updater here if they are showen always
        local hoverSetting = GetSetting("MINIMAP_HOVER")
        if hoverSetting == "COORDS" or hoverSetting == "CLOCKCOORDS" or hoverSetting == "ZONECOORDS" or hoverSetting == "ALL" then
            GwMapCoords.CoordsTimer = C_Timer.NewTicker(0.1, function() mapCoordsMiniMap_setCoords(GwMapCoords) end)
        end
    else
        GwMapCoords:Hide()
        GwMapCoords:SetScript("OnEnter", nil)
        GwMapCoords:SetScript("OnClick", nil)
        GwMapCoords:SetScript("OnLeave", nil)
        if GwMapCoords.CoordsTimer then
            GwMapCoords.CoordsTimer:Cancel()
            GwMapCoords.CoordsTimer = nil
        end
    end
end
GW.ToogleMinimapCoorsLable = ToogleMinimapCoorsLable

local function ToogleMinimapFpsLable()
    if GetSetting("MINIMAP_FPS") then
        GW.BuildAddonList()
        GwMapFPS:SetScript("OnEnter", GW.FpsOnEnter)
        GwMapFPS:SetScript("OnUpdate", GW.FpsOnUpdate)
        GwMapFPS:SetScript("OnLeave", GW.FpsOnLeave)
        GwMapFPS:SetScript("OnClick", GW.FpsOnClick)
        GwMapFPS:Show()
    else
        GwMapFPS:SetScript("OnEnter", nil)
        GwMapFPS:SetScript("OnUpdate", nil)
        GwMapFPS:SetScript("OnLeave", nil)
        GwMapFPS:SetScript("OnClick", nil)
        GwMapFPS:Hide()
    end
end
GW.ToogleMinimapFpsLable = ToogleMinimapFpsLable


local function Minimap_OnMouseDown(self, btn)
    if M.TrackingDropdown then
        HideDropDownMenu(1, nil, M.TrackingDropdown)
    end

    if btn == "RightButton" and M.TrackingDropdown then
        ToggleDropDownMenu(1, nil, M.TrackingDropdown, "cursor")
    else
        Minimap.OnClick(self)
    end
end

local function MapCanvas_OnMouseDown(_, btn)
    if M.TrackingDropdown then
        HideDropDownMenu(1, nil, M.TrackingDropdown)
    end

    if btn == "RightButton" and M.TrackingDropdown then
        ToggleDropDownMenu(1, nil, M.TrackingDropdown, "cursor")
    end
end

local function Minimap_OnMouseWheel(_, d)
    if d > 0 then
        Minimap.ZoomIn:Click()
    elseif d < 0 then
        Minimap.ZoomOut:Click()
    end
end

local function GetLocTextColor()
    local pvpType = GetZonePVPInfo()
    if pvpType == "arena" then
        return 0.84, 0.03, 0.03
    elseif pvpType == "friendly" then
        return 0.05, 0.85, 0.03
    elseif pvpType == "contested" then
        return 0.9, 0.85, 0.05
    elseif pvpType == "hostile" then
        return 0.84, 0.03, 0.03
    elseif pvpType == "sanctuary" then
        return 0.035, 0.58, 0.84
    elseif pvpType == "combat" then
        return 0.84, 0.03, 0.03
    else
        return 0.9, 0.85, 0.05
    end
end

local function Update_ZoneText()
    Minimap.location:SetText(GetMinimapZoneText())
    Minimap.location:SetTextColor(GetLocTextColor())
end

local function CreateMinimapTrackingDropdown()
    local dropdown = CreateFrame("Frame", "GW2UIMiniMapTrackingDropDown", UIParent, "UIDropDownMenuTemplate")
    dropdown:SetID(1)
    dropdown:SetClampedToScreen(true)
    dropdown:Hide()

    UIDropDownMenu_Initialize(dropdown, MiniMapTrackingDropDown_Initialize, "MENU")
    dropdown.noResize = true

    return dropdown
end

local function HandleExpansionButton()
    local garrison = ExpansionLandingPageMinimapButton or GarrisonLandingPageMinimapButton
    if not garrison then return end

    garrison:GetHighlightTexture():SetBlendMode("BLEND")
    garrison:SetSize(43, 43)

    -- Handle Position
    local x = Minimap.gwMover:GetCenter()
    local screenWidth = UIParent:GetRight()

    garrison:ClearAllPoints()
    if x > (screenWidth / 2) then
        garrison:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", 0, -3)
    else
        garrison:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMRIGHT", 2, -3)
    end

    local garrisonType = C_Garrison.GetLandingPageGarrisonType()
    garrison.garrisonType = garrisonType

    if garrison.garrisonMode then
        if (garrisonType == Enum.GarrisonType.Type_6_0) then
            garrison.faction = UnitFactionGroup("player")
            garrison.title = GARRISON_LANDING_PAGE_TITLE;
            garrison.description = MINIMAP_GARRISON_LANDING_PAGE_TOOLTIP
        elseif (garrisonType == Enum.GarrisonType.Type_7_0) then
            garrison.title = ORDER_HALL_LANDING_PAGE_TITLE;
            garrison.description = MINIMAP_ORDER_HALL_LANDING_PAGE_TOOLTIP
        elseif (garrisonType == Enum.GarrisonType.Type_8_0) then
            garrison.title = GARRISON_TYPE_8_0_LANDING_PAGE_TITLE;
            garrison.description = GARRISON_TYPE_8_0_LANDING_PAGE_TOOLTIP
        elseif (garrisonType == Enum.GarrisonType.Type_9_0) then
            garrison.title = GARRISON_TYPE_9_0_LANDING_PAGE_TITLE;
            garrison.description = GARRISON_TYPE_9_0_LANDING_PAGE_TOOLTIP
        end
        garrison:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/garrison-up")
        garrison:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/garrison-down")
        garrison:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/garrison-down")
        garrison.LoopingGlow:SetTexture("Interface/AddOns/GW2_UI/textures/icons/garrison-up")
    else
        local minimapDisplayInfo = ExpansionLandingPage:GetOverlayMinimapDisplayInfo();
        if minimapDisplayInfo then
            garrison.title = minimapDisplayInfo.title;
            garrison.description = minimapDisplayInfo.description;
        end
        garrison:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/landingpage-dragon")
        garrison:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/landingpage-dragon")
        garrison:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/landingpage-dragon")
        garrison.LoopingGlow:SetTexture("Interface/AddOns/GW2_UI/textures/icons/landingpage-dragon")
    end
end

local function SetupHybridMinimap()
    local MapCanvas = HybridMinimap.MapCanvas
    --MapCanvas:SetMaskTexture(E.Media.Textures.White8x8)
    MapCanvas:SetScript("OnMouseWheel", Minimap_OnMouseWheel)
    MapCanvas:SetScript("OnMouseDown", MapCanvas_OnMouseDown)
    MapCanvas:SetScript("OnMouseUp", GW.NoOp)

    _G.HybridMinimap.CircleMask:StripTextures()
end

local function UpdateClusterPoint(self, _, anchor)
    if anchor ~= GW2UI_MinimapClusterHolder then
        MinimapCluster:ClearAllPoints()
        MinimapCluster:SetPoint("TOPRIGHT", GW2UI_MinimapClusterHolder, 0, 1)
    end
end

local function LoadMinimap()
    -- https://wowwiki.wikia.com/wiki/USERAPI_GetMinimapShape
    GetMinimapShape = GetMinimapShape

    Minimap:SetMaskTexture(130937)
    Minimap:SetScale(1.2)

    local size = GetSetting("MINIMAP_SCALE")
    Minimap:SetSize(size, size)

    GW.RegisterMovableFrame(Minimap, MINIMAP_LABEL, "MinimapPos", "VerticalActionBarDummy", {Minimap:GetSize()}, {"default"}, nil, MinimapPostDrag)
    Minimap:ClearAllPoints()
    Minimap:SetPoint("CENTER", Minimap.gwMover)

    local GwMinimapShadow = CreateFrame("Frame", "GwMinimapShadow", Minimap, "GwMinimapShadow")
    local GwMapGradient = CreateFrame("Frame", "GwMapGradient", GwMinimapShadow, "GwMapGradient")
    GwMapGradient:SetParent(GwMinimapShadow)
    GwMapGradient:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
    GwMapGradient:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)

    local minimapLevel = Minimap:GetFrameLevel() + 2
    Minimap:SetFrameLevel(minimapLevel)

    MinimapCluster:SetFrameLevel(minimapLevel)
    MinimapCluster:SetFrameStrata("MEDIUM")
    Minimap:SetFrameStrata("LOW")

    if Minimap.backdrop then -- level to hybrid maps fixed values
        Minimap.backdrop:SetFrameLevel(99)
        Minimap.backdrop:SetFrameStrata("BACKGROUND")
        Minimap.backdrop:SetIgnoreParentScale(true)
        Minimap.backdrop:SetScale(1)
    end

    local clusterHolder = CreateFrame("Frame", "GW2UI_MinimapClusterHolder", MinimapCluster)
    local clusterBackdrop = CreateFrame("Frame", "GWUI_MinimapClusterBackdrop", MinimapCluster)
    clusterHolder:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -350, -3)

    clusterBackdrop:SetIgnoreParentScale(true)
    clusterBackdrop:SetScale(1)

    MinimapCluster:ClearAllPoints()
    MinimapCluster:SetScale(1)
    MinimapCluster:SetPoint("TOPRIGHT", clusterHolder, 0, 1)

    MinimapCluster:KillEditMode()

    local mcWidth = MinimapCluster:GetWidth()
    local height, width = 20, (mcWidth - 30)
    clusterBackdrop:ClearAllPoints()
    clusterBackdrop:SetPoint("TOPRIGHT", 0, -1)
    clusterBackdrop:SetSize(width, height)
    clusterHolder:SetSize(width, height)

    hooksecurefunc(MinimapCluster, "SetPoint", UpdateClusterPoint)

    MinimapCluster:EnableMouse(false)

    MinimapCluster.ZoneTextButton:Kill()
    TimeManagerClockButton:Kill()
    MinimapCluster.Tracking.Button:SetParent(GW.HiddenFrame)

    Minimap.location = Minimap:CreateFontString(nil, "OVERLAY", "GW_Standard_Button_Font_Small")
    Minimap.location:SetPoint("TOP", Minimap, "TOP", 0, -2)
    Minimap.location:SetJustifyH("CENTER")
    Minimap.location:SetJustifyV("MIDDLE")
    Minimap.location:SetIgnoreParentScale(true)
    Minimap.location:SetScale(1)

    local killFrames = {
        MinimapBorder,
        MinimapBorderTop,
        MinimapZoomIn,
        MinimapZoomOut,
        MinimapNorthTag,
        MinimapZoneTextButton,
        MiniMapWorldMapButton,
        MiniMapMailBorder,
        MiniMapTracking,
        Minimap.ZoomIn,
        Minimap.ZoomOut,
        MinimapCompassTexture
    }

    MinimapCluster.BorderTop:StripTextures()
    MinimapCluster.Tracking.Background:StripTextures()

    for _, frame in next, killFrames do
        frame:Kill()
    end

    if ExpansionLandingPageMinimapButton.UpdateIcon then
        hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIcon", HandleExpansionButton)
        ExpansionLandingPageMinimapButton:SetScript("OnEnter", GW.LandingButton_OnEnter)
    else
        hooksecurefunc("GarrisonLandingPageMinimapButton_UpdateIcon", HandleExpansionButton)
        GarrisonLandingPageMinimapButton:SetScript("OnEnter", GW.LandingButton_OnEnter)
    end
    HandleExpansionButton()

    --Hide the BlopRing on Minimap
    Minimap:SetArchBlobRingAlpha(0)
    Minimap:SetArchBlobRingScalar(0)
    Minimap:SetQuestBlobRingAlpha(0)
    Minimap:SetQuestBlobRingScalar(0)

    QueueStatusFrame:SetClampedToScreen(true)

    M.TrackingDropdown = CreateMinimapTrackingDropdown()

    if HybridMinimap then SetupHybridMinimap() end

    Minimap:EnableMouseWheel(true)
    Minimap:SetScript("OnMouseWheel", Minimap_OnMouseWheel)
    Minimap:SetScript("OnMouseDown", Minimap_OnMouseDown)
    Minimap:SetScript("OnMouseUp", GW.NoOp)

    M:RegisterEvent("ADDON_LOADED")
    M:RegisterEvent("PLAYER_ENTERING_WORLD")
    M:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    M:RegisterEvent("ZONE_CHANGED_INDOORS")
    M:RegisterEvent("ZONE_CHANGED")
    M:SetScript("OnEvent", function(_, event, ...)
        if event == "ADDON_LOADED" then
            local addon = ...
            if addon == "Blizzard_TimeManager" then
                TimeManagerClockButton:Kill()
            elseif addon == "Blizzard_FeedbackUI" then
                FeedbackUIButton:Kill()
            elseif addon == "Blizzard_HybridMinimap" then
                SetupHybridMinimap()
            elseif addon == "Blizzard_EncounterJournal" then
                -- Since the default non-quest map is full screen, it overrides the showing of the encounter journal
                hooksecurefunc("EJ_HideNonInstancePanels", function()
                    if InCombatLockdown() or not WorldMapFrame:IsShown() then return end

                    HideUIPanel(WorldMapFrame)
                end)
            end
        else
            Update_ZoneText()
        end
    end)

    --Time
    GwMapTime = CreateFrame("Button", "GwMapTime", Minimap, "GwMapTime")
    GwMapTime:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    GwMapTime.timeTimer = C_Timer.NewTicker(0.2, function()
        GwMapTime.Time:SetText(GameTime_GetTime(false))
    end)
    GwMapTime:RegisterEvent("UPDATE_INSTANCE_INFO")
    GwMapTime:SetScript("OnClick", GW.Time_OnClick)
    GwMapTime:SetScript("OnEnter", GW.Time_OnEnter)
    GwMapTime:SetScript("OnLeave", GW.Time_OnLeave)
    GwMapTime:SetScript("OnEvent", GW.Time_OnEvent)

    --coords
    GwMapCoords = CreateFrame("Button", "GwMapCoords", Minimap, "GwMapCoords")
    GwMapCoords.Coords:SetText(NOT_APPLICABLE)
    GwMapCoords.Coords:SetFont(STANDARD_TEXT_FONT, 12, "")
    GwMapCoords.MapCoordsMiniMapPrecision = GetSetting("MINIMAP_COORDS_PRECISION")
    ToogleMinimapCoorsLable()

    --FPS
    GwMapFPS = CreateFrame("Button", "GwMapFPS", Minimap, "GwMapFPS")
    GwMapFPS.fps:SetText(NOT_APPLICABLE)
    GwMapFPS.fps:SetFont(STANDARD_TEXT_FONT, 12)
    ToogleMinimapFpsLable()

    --CalenderIcon
    GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
    GameTimeFrame:SetSize(32, 32)

    hooksecurefunc("GameTimeFrame_SetDate", function()
        GameTimeFrame:StripTextures()
        GameTimeFrame:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/calendar")
        GameTimeFrame:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/calendar")
        GameTimeFrame:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/calendar")
        GameTimeFrame:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
        GameTimeFrame:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
        GameTimeFrame:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
    end)

    --Mail Button
    local GwMailButton = CreateFrame("Button", "GwMailButton", UIParent, "GwMailButton")
    local fnGwMailButton_OnEvent = function(self, event)
        if event == "UPDATE_PENDING_MAIL" then
            if (HasNewMail()) then
                if Minimap:IsShown() then
                    self:Show()
                end
                self.gw_Showing = true
                if (GameTooltip:IsOwned(self)) then
                    MinimapMailFrameUpdate()
                end
            else
                self:Hide()
                self.gw_Showing = false
            end
        end
    end
    local fnGwMailButton_OnEnter = function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, -55)
        if (GameTooltip:IsOwned(self)) then
            MinimapMailFrameUpdate()
        end
    end
    GwMailButton:SetScript("OnEvent", fnGwMailButton_OnEvent)
    GwMailButton:SetScript("OnEnter", fnGwMailButton_OnEnter)
    GwMailButton:SetScript("OnLeave", GameTooltip_Hide)
    GwMailButton.gw_Showing = false
    GwMailButton:RegisterEvent("UPDATE_PENDING_MAIL")
    GwMailButton:SetFrameLevel(GwMailButton:GetFrameLevel() + 1)

    -- Addon Icons
    GW.CreateMinimapButtonsSack()

    -- check on which side we need to set the buttons
    local x = Minimap:GetCenter()
    local screenWidth = UIParent:GetRight()
    if x > (screenWidth / 2) then
        setMinimapButtons("left")
    else
        setMinimapButtons("right")
    end

    Minimap:SetPlayerTexture("Interface/AddOns/GW2_UI/textures/icons/player_arrow")

    hideMiniMapIcons()

    Minimap:HookScript("OnEnter", hoverMiniMap)
    Minimap:HookScript("OnLeave", hoverMiniMapOut)

    Minimap:HookScript("OnShow", minimap_OnShow)
    Minimap:HookScript("OnHide", minimap_OnHide)

    SetMinimapHover()
    C_Timer.After(0.2, hoverMiniMapOut)

    --difficult icon
    --[[
    local difficulty = MinimapCluster.InstanceDifficulty
    local instance = difficulty.Instance
    local guild = difficulty.Guild
    local challenge = difficulty.ChallengeMode

    challenge:SetParent(Minimap)
    instance:SetParent(Minimap)
    guild:SetParent(Minimap)

    if challenge then
        challenge:ClearAllPoints()
        challenge:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 10, -10)
    end
    if instance then
        instance:ClearAllPoints()
        instance:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 10, -10)
    end
    if guild then
        guild:ClearAllPoints()
        guild:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 10, -10)
    end
    ]]
    GW.SkinMinimapInstanceDifficult()

    QueueStatusButton:SetSize(26, 26)
    QueueStatusButtonIcon:Kill()
    QueueStatusButtonIcon.texture:SetTexture(nil)
    QueueStatusButton:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton")
    QueueStatusButton:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton-Highlight")
    QueueStatusButton:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton-Highlight")
    local GwLfgQueueIcon = CreateFrame("Frame", "GwLfgQueueIcon", QueueStatusButton, "GwLfgQueueIcon")
    GwLfgQueueIcon:SetPoint("CENTER", QueueStatusButton, "CENTER", 0, 0)
    hooksecurefunc(QueueStatusButtonIcon, "PlayAnim", function()
        if not Minimap:IsShown() then return end
        QueueStatusButton:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/LFGAnimation-1")
        QueueStatusButton:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/LFGAnimation-1-Highlight")
        QueueStatusButton:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/LFGAnimation-1-Highlight")
        GwLfgQueueIcon.animation:Play()
    end)
    hooksecurefunc(QueueStatusButtonIcon, "StopAnimating", function()
        GwLfgQueueIcon.animation:Stop()
        QueueStatusButton:SetNormalTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton")
        QueueStatusButton:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton-Highlight")
        QueueStatusButton:SetPushedTexture("Interface/AddOns/GW2_UI/textures/icons/LFGMinimapButton-Highlight")
    end)
end
GW.LoadMinimap = LoadMinimap
