local _, GW = ...

local skinLoaded = false
local libAhTab = LibStub:GetLibrary("LibAHTab-1-0", true)

local function AddTsmTab(_, tabId)
    if skinLoaded or tabId ~= "TSM_AH_TAB" then return end
    skinLoaded = true

    local tab = libAhTab:GetButton("TSM_AH_TAB")
    if not tab.isSkinned then
        GW.SkinAuctionsHouseFrameTab(tab, "addon_tsm", "TSM")
    end

    tab:ClearAllPoints()
    tab:SetPoint("TOPRIGHT", GwAuctionsHouseFrameLeftPanel, "TOPLEFT", 1, -32 + (-40 * GW.ActionHouseTabsAdded))
    tab:SetParent(GwAuctionsHouseFrameLeftPanel)
    tab:SetSize(64, 40)
    GW.ActionHouseTabsAdded = GW.ActionHouseTabsAdded + 1
end

local function LoadTSMAddonSkin()
    if not GW.settings.AuctionHouseSkinEnabled or not TSM_API then return end
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("AUCTION_HOUSE_SHOW")
    eventFrame:SetScript("OnEvent", function()
        hooksecurefunc(libAhTab, "CreateTab", AddTsmTab)
    end)
end
GW.LoadTSMAddonSkin = LoadTSMAddonSkin