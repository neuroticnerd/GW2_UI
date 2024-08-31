local _, GW = ...

local function SkinFilterButton(Button)
	Button:GwHandleDropDownBox(GW.BackdropTemplates.DopwDown, true)
	Button.ClearFiltersButton:GwSkinButton(true)
end

local function HandleSearchBarFrame(Frame)
	SkinFilterButton(Frame.FilterButton)

	Frame.SearchButton:GwSkinButton(false, true)
	GW.SkinTextBox(Frame.SearchBox.Middle, Frame.SearchBox.Left, Frame.SearchBox.Right)
	Frame.FavoritesSearchButton:GwSkinButton(false, true)
	Frame.FavoritesSearchButton.Icon:SetDesaturated(true)
	hooksecurefunc(Frame.FavoritesSearchButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end) --TODO
	Frame.FavoritesSearchButton:SetSize(22, 22)
end

local function HandleListIcon(frame)
	if not frame.tableBuilder then return end

	for i = 1, 22 do
		local row = frame.tableBuilder.rows[i]
		if row then
			for j = 1, 4 do
				local cell = row.cells and row.cells[j]
				if cell and cell.Icon then
					if not cell.IsSkinned then
						GW.HandleIcon(cell.Icon)

						if cell.IconBorder then
							cell.IconBorder:GwKill()
						end

						cell.IsSkinned = true
					end
				end
			end
		end
	end
end

local function SkinItemDisplay(frame)
	local ItemDisplay = frame.ItemDisplay
	ItemDisplay:GwStripTextures()
	ItemDisplay:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)
	ItemDisplay.backdrop:SetPoint("TOPLEFT", 3, -3)
	ItemDisplay.backdrop:SetPoint("BOTTOMRIGHT", -3, 0)

	local ItemButton = ItemDisplay.ItemButton
	ItemButton.CircleMask:Hide()

	GW.HandleIcon(ItemButton.Icon, true, GW.BackdropTemplates.ColorableBorderOnly)
	GW.HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop)
	ItemButton:GetHighlightTexture():Hide()
end

local function HandleHeaders(frame)
	local maxHeaders = frame.HeaderContainer:GetNumChildren()
	for i, header in next, { frame.HeaderContainer:GetChildren() } do
		if not header.IsSkinned then
			header:DisableDrawLayer("BACKGROUND")

			if not header.backdrop then
				header:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithColorableBorder, true)
				header.backdrop:SetBackdropBorderColor(1, 1, 1, 0.2)
			end

			header.IsSkinned = true
		end

		if header.backdrop then
			header.backdrop:SetPoint("BOTTOMRIGHT", i < maxHeaders and -5 or 0, -2)
		end
	end

	HandleListIcon(frame)
end

local function HandleTabs(arg1)
	if not arg1 or arg1 ~= AuctionHouseFrame then return end

	local lastTab = AuctionHouseFrameBuyTab
	for index, tab in next, AuctionHouseFrame.Tabs do
		if not tab.isSkinned then
			GW.HandleTabs(tab)
		end

		-- tab positions
		tab:ClearAllPoints()

		if index == 1 then
			tab:SetPoint("BOTTOMLEFT", AuctionHouseFrame, "BOTTOMLEFT", 0, -32)
		else -- skinned ones can be closer together
			tab:SetPoint("TOPLEFT", lastTab, "TOPRIGHT", (tab.backdrop or tab.Backdrop) and -5 or 0, 0)
		end

		lastTab = tab
	end
end

local function HandleSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay
	ItemDisplay:GwStripTextures()
	ItemDisplay:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)

	local ItemButton = ItemDisplay.ItemButton
	if ItemButton.IconMask then ItemButton.IconMask:Hide() end

	ItemButton.EmptyBackground:Hide()
	ItemButton:SetPushedTexture("Interface/AddOns/GW2_UI/textures/uistuff/actionbutton-pressed")
	ItemButton.Highlight:SetColorTexture(1, 1, 1, .25)
	ItemButton.Highlight:SetAllPoints(ItemButton.Icon)

	GW.HandleIcon(ItemButton.Icon, true, GW.BackdropTemplates.ColorableBorderOnly)
	GW.SkinTextBox(frame.QuantityInput.InputBox.Middle, frame.QuantityInput.InputBox.Left, frame.QuantityInput.InputBox.Right)
	frame.QuantityInput.MaxButton:GwSkinButton(false, true)
	GW.SkinTextBox(frame.PriceInput.MoneyInputFrame.GoldBox.Middle, frame.PriceInput.MoneyInputFrame.GoldBox.Left, frame.PriceInput.MoneyInputFrame.GoldBox.Right)
	GW.SkinTextBox(frame.PriceInput.MoneyInputFrame.SilverBox.Middle, frame.PriceInput.MoneyInputFrame.SilverBox.Left, frame.PriceInput.MoneyInputFrame.SilverBox.Right)

	if ItemButton.IconBorder then
		GW.HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop)
	end

	if frame.SecondaryPriceInput then
		GW.SkinTextBox(frame.SecondaryPriceInput.MoneyInputFrame.GoldBox.Middle, frame.SecondaryPriceInput.MoneyInputFrame.GoldBox.Left, frame.SecondaryPriceInput.MoneyInputFrame.GoldBox.Right)
		GW.SkinTextBox(frame.SecondaryPriceInput.MoneyInputFrame.SilverBox.Middle, frame.SecondaryPriceInput.MoneyInputFrame.SilverBox.Left, frame.SecondaryPriceInput.MoneyInputFrame.SilverBox.Right)
		frame.SecondaryPriceInput.Label:SetTextColor(1, 1, 1)
	end

	frame.Duration.Dropdown:GwHandleDropDownBox()
	frame.PostButton:GwSkinButton(false, true)

	frame.CreateAuctionLabel:Hide()

	if frame.BuyoutModeCheckButton then
		frame.BuyoutModeCheckButton:GwSkinCheckButton()
		frame.BuyoutModeCheckButton:SetSize(20, 20)
		frame.BuyoutModeCheckButton.Text:SetTextColor(1, 1, 1)
	end
	if frame.QuantityInput then
		frame.QuantityInput.Label:SetTextColor(1, 1, 1)
	end

	frame.PriceInput.Label:SetTextColor(1, 1, 1)
	hooksecurefunc(frame.PriceInput.Label, "SetTextColor", function(self, r, g, b) if r ~=1 or g ~= 1 or b ~= 1 then self:SetTextColor(1, 1, 1) end end)
	frame.Duration.Label:SetTextColor(1, 1, 1)
	frame.Deposit.Label:SetTextColor(1, 1, 1)
	frame.TotalPrice.Label:SetTextColor(1, 1, 1)
end

local function HandleAuctionButtons(button)
	button:GwSkinButton(false, true)
	button:SetSize(22, 22)
	hooksecurefunc(button.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end)
end

local function AddListItemChildHoverTexture(child)
	child.Background = child:CreateTexture(nil, "BACKGROUND", nil, 7)
	child.Background:SetTexture("Interface/AddOns/GW2_UI/textures/character/menu-bg")
	child.Background:ClearAllPoints()
	child.Background:SetPoint("TOPLEFT", child, "TOPLEFT", 0, 0)
	child.Background:SetPoint("BOTTOMRIGHT", child, "BOTTOMRIGHT", 0, 0)
	child.limitHoverStripAmount = 1 --limit that value to 0.75 because we do not use the default hover texture
	child.HighlightTexture:SetTexture("Interface/AddOns/GW2_UI/textures/character/menu-hover")

	child.HighlightTexture:SetVertexColor(0.8, 0.8, 0.8, 0.8)
	child.HighlightTexture:GwSetInside(child.Background)

	child:HookScript("OnEnter",function()
		GW.TriggerButtonHoverAnimation(child, child.HighlightTexture)
	end)
end

local function HandleItemListScrollBoxHover(self)
	for _, child in next, { self.ScrollTarget:GetChildren() } do
		if not child.IsSkinned then
			AddListItemChildHoverTexture(child)

			child.IsSkinned = true
		end

		--zebra
		local zebra = child.GetOrderIndex and (child:GetOrderIndex() % 2) == 1 or false
		if zebra then
			child.Background:SetVertexColor(1, 1, 1, 1)
		else
			child.Background:SetVertexColor(0, 0, 0, 0)
		end

		if child.NormalTexture then
			child.NormalTexture:SetAlpha(0)
		end
		child.SelectedHighlight:SetColorTexture(0.5, 0.5, 0.5, .25)
	end
end

local function HookItemListScrollBoxHover(scrollBox)
	hooksecurefunc(scrollBox, "Update", HandleItemListScrollBoxHover)
end

local function HandleSummaryIcons(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if child.Icon then
			if not child.IsSkinned then
				GW.HandleIcon(child.Icon, true)

				child.Text:SetTextColor(255 / 255, 241 / 255, 209 / 255)

				if child.IconBorder then
					child.IconBorder:GwKill()
				end

				AddListItemChildHoverTexture(child)

				child.IsSkinned = true
			end
		end
	end
	HandleItemListScrollBoxHover(frame)
end

local function HandleTokenSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay
	ItemDisplay:GwStripTextures()
	ItemDisplay:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)

	local ItemButton = ItemDisplay.ItemButton
	if ItemButton.IconMask then ItemButton.IconMask:Hide() end

	ItemButton.EmptyBackground:Hide()
	ItemButton:SetPushedTexture("Interface/AddOns/GW2_UI/textures/uistuff/actionbutton-pressed")
	ItemButton.Highlight:SetColorTexture(1, 1, 1, .25)
	ItemButton.Highlight:SetAllPoints(ItemButton.Icon)

	GW.HandleIcon(ItemButton.Icon, true, GW.BackdropTemplates.ColorableBorderOnly)

	if ItemButton.IconBorder then
		GW.HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop)
	end

	frame.PostButton:GwSkinButton(false, true)
	HandleAuctionButtons(frame.DummyRefreshButton)

	frame.DummyItemList:GwStripTextures()
	frame.DummyItemList:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)
end

local function HandleSellList(frame, hasHeader, fitScrollBar)
	if frame.RefreshFrame then
		HandleAuctionButtons(frame.RefreshFrame.RefreshButton)
		frame.RefreshFrame.TotalQuantity:SetTextColor(1, 1, 1)
	end

	GW.HandleTrimScrollBar(frame.ScrollBar)
	GW.HandleScrollControls(frame)

	if frame.LoadingSpinner then
		frame.LoadingSpinner.SearchingText:SetTextColor(1, 1, 1)
	end

	if fitScrollBar then
		frame.ScrollBar:ClearAllPoints()
		frame.ScrollBar:SetPoint("TOPRIGHT", frame, -6, -16)
		frame.ScrollBar:SetPoint("BOTTOMRIGHT", frame, -6, 16)
	end

	if hasHeader then
		hooksecurefunc(frame, "RefreshScrollFrame", HandleHeaders)
		HookItemListScrollBoxHover(frame.ScrollBox)
	else
		hooksecurefunc(frame.ScrollBox, "Update", HandleSummaryIcons)
	end
end

local function ApplyAuctionHouseSkin()
	if not GW.settings.AuctionHouseSkinEnabled then return end

	GW.HandlePortraitFrame(AuctionHouseFrame)

	AuctionHouseFrame.CategoriesList:GwStripTextures()
	AuctionHouseFrame.BrowseResultsFrame.ItemList:GwStripTextures()
	AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay:GwStripTextures()
	AuctionHouseFrame.CommoditiesBuyFrame.ItemList:GwStripTextures()
	AuctionHouseFrame.ItemBuyFrame.ItemList:GwStripTextures()
	AuctionHouseFrame.ItemSellFrame:GwStripTextures()
	AuctionHouseFrame.ItemSellList:GwStripTextures()
	AuctionHouseFrame.CommoditiesSellFrame:GwStripTextures()
	AuctionHouseFrame.CommoditiesSellList:GwStripTextures()
	AuctionHouseFrame.WoWTokenSellFrame:GwStripTextures()
	AuctionHouseFrameAuctionsFrame.CommoditiesList:GwStripTextures()
	AuctionHouseFrameAuctionsFrame.ItemList:GwStripTextures()
	AuctionHouseFrameAuctionsFrame.SummaryList:GwStripTextures()
	AuctionHouseFrameAuctionsFrame.AllAuctionsList:GwStripTextures()
	AuctionHouseFrameAuctionsFrame.BidsList:GwStripTextures()
	AuctionHouseFrame.WoWTokenResults:GwStripTextures()

	GW.CreateFrameHeaderWithBody(AuctionHouseFrame, AuctionHouseFrameTitleText, "Interface/AddOns/GW2_UI/textures/character/addon-window-icon", {AuctionHouseFrame.CategoriesList,
								AuctionHouseFrame.BrowseResultsFrame,
								AuctionHouseFrame.CommoditiesBuyFrame,
								AuctionHouseFrame.CommoditiesBuyFrame.ItemList,
								AuctionHouseFrame.ItemBuyFrame,
								AuctionHouseFrame.ItemBuyFrame.ItemList,
								AuctionHouseFrame.ItemSellFrame,
								AuctionHouseFrame.ItemSellList,
								AuctionHouseFrame.CommoditiesSellFrame,
								AuctionHouseFrame.CommoditiesSellList,
								AuctionHouseFrame.WoWTokenSellFrame,
								AuctionHouseFrameAuctionsFrame.CommoditiesList,
								AuctionHouseFrameAuctionsFrame.ItemList,
								AuctionHouseFrameAuctionsFrame.SummaryList,
								AuctionHouseFrameAuctionsFrame.AllAuctionsList,
								AuctionHouseFrameAuctionsFrame.BidsList,
								AuctionHouseFrame.WoWTokenResults,
								})
	AuctionHouseFrame:SetWidth(810)

	hooksecurefunc("PanelTemplates_SetNumTabs", HandleTabs)
	HandleTabs(AuctionHouseFrame) -- call it once to setup our tabs

	--SearchBar Frame
	HandleSearchBarFrame(AuctionHouseFrame.SearchBar)
	AuctionHouseFrame.MoneyFrameBorder:GwStripTextures()
	AuctionHouseFrame.MoneyFrameInset:GwStripTextures()

	--Categorie List
	local Categories = AuctionHouseFrame.CategoriesList
	Categories.NineSlice:GwSetInside(Categories)
	GW.HandleTrimScrollBar(Categories.ScrollBar)
	GW.HandleScrollControls(Categories)

	local loaded = false
	hooksecurefunc(Categories.ScrollBox, "Update", function()
		--wait for load
		if not loaded then
			loaded = true
			Categories.ScrollBox.view:SetElementExtent(28)
		end
	end)
	Categories.ScrollBox:Update()

	hooksecurefunc("AuctionHouseFilterButton_SetUp", function(button) --TODO
		local r, g, b = 0.5, 0.5, 0.5
		button:SetHeight(28)
		button.NormalTexture:SetAlpha(0)
		button.NormalTexture:SetHeight(28)
		button.SelectedTexture:SetHeight(28)
		button.HighlightTexture:SetHeight(28)
		button.SelectedTexture:SetColorTexture(r, g, b, .25)
		button.HighlightTexture:SetColorTexture(1, 1, 1, .1)
		button.Text:SetTextColor(255 / 255, 241 / 255, 209 / 255)
		if not button.IsSkinned then
			button.Background = button:CreateTexture(nil, "BACKGROUND", nil, 7)
			button.Background:SetTexture("Interface/AddOns/GW2_UI/textures/character/menu-bg")
			button.Background:ClearAllPoints()
			button.Background:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
			button.Background:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
			button.limitHoverStripAmount = 1 --limit that value to 0.75 because we do not use the default hover texture
			button.HighlightTexture:SetTexture("Interface/AddOns/GW2_UI/textures/character/menu-hover")

			button.HighlightTexture:SetVertexColor(0.8, 0.8, 0.8, 0.8)
			button.HighlightTexture:GwSetInside(button.Background)

			button:HookScript("OnEnter",function()
				GW.TriggerButtonHoverAnimation(button, button.HighlightTexture)
			end)

			button.IsSkinned = true
		end

		--zebra
		local zebra = (button:GetOrderIndex() % 2) == 1 or false
		if zebra then
			button.Background:SetVertexColor(1, 1, 1, 1)
		else
			button.Background:SetVertexColor(0, 0, 0, 0)
		end
	end)


	--Browse Frame
	local Browse = AuctionHouseFrame.BrowseResultsFrame

	local BrowseList = Browse.ItemList
	hooksecurefunc(BrowseList, "RefreshScrollFrame", HandleHeaders)
	GW.HandleTrimScrollBar(BrowseList.ScrollBar)
	GW.HandleScrollControls(BrowseList)
	HookItemListScrollBoxHover(BrowseList.ScrollBox)
	BrowseList.ScrollBar:ClearAllPoints()
	BrowseList.ScrollBar:SetPoint("TOPRIGHT", BrowseList, -6, -16)
	BrowseList.ScrollBar:SetPoint("BOTTOMRIGHT", BrowseList, -6, 16)

	BrowseList.LoadingSpinner.SearchingText:SetTextColor(1, 1, 1)

	--BuyOut Frame
	local CommoditiesBuyFrame = AuctionHouseFrame.CommoditiesBuyFrame
	CommoditiesBuyFrame.BackButton:GwSkinButton(false, true)

	local CommoditiesBuyList = AuctionHouseFrame.CommoditiesBuyFrame.ItemList
	CommoditiesBuyList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	CommoditiesBuyList.RefreshFrame.RefreshButton.Icon:SetDesaturated(true)
	hooksecurefunc(CommoditiesBuyList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end) --TODO
	GW.HandleTrimScrollBar(CommoditiesBuyList.ScrollBar)
	GW.HandleScrollControls(CommoditiesBuyList)
	HookItemListScrollBoxHover(CommoditiesBuyList.ScrollBox)
	CommoditiesBuyList.RefreshFrame.TotalQuantity:SetTextColor(1, 1, 1)
	CommoditiesBuyList.LoadingSpinner.SearchingText:SetTextColor(1, 1, 1)

	local BuyDisplay = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay
	GW.SkinTextBox(BuyDisplay.QuantityInput.InputBox.Middle, BuyDisplay.QuantityInput.InputBox.Left, BuyDisplay.QuantityInput.InputBox.Right)
	BuyDisplay.BuyButton:GwSkinButton(false, true)

	BuyDisplay.QuantityInput.Label:SetTextColor(1, 1, 1)
	BuyDisplay.UnitPrice.Label:SetTextColor(1, 1, 1)
	BuyDisplay.TotalPrice.Label:SetTextColor(1, 1, 1)

	SkinItemDisplay(BuyDisplay)

	--ItemBuyOut Frame
	local ItemBuyFrame = AuctionHouseFrame.ItemBuyFrame
	ItemBuyFrame.BackButton:GwSkinButton(false, true)
	ItemBuyFrame.BuyoutFrame.BuyoutButton:GwSkinButton(false, true)

	SkinItemDisplay(ItemBuyFrame)

	local ItemBuyList = ItemBuyFrame.ItemList
	GW.HandleTrimScrollBar(ItemBuyList.ScrollBar)
	GW.HandleScrollControls(ItemBuyList)
	HookItemListScrollBoxHover(ItemBuyList.ScrollBox)
	ItemBuyList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	hooksecurefunc(ItemBuyList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end) --TODO
	hooksecurefunc(ItemBuyList, "RefreshScrollFrame", HandleHeaders)
	ItemBuyList.RefreshFrame.TotalQuantity:SetTextColor(1, 1, 1)
	ItemBuyList.LoadingSpinner.SearchingText:SetTextColor(1, 1, 1)

	local EditBoxes = {
		AuctionHouseFrameGold,
		AuctionHouseFrameSilver,
	}

	for _, EditBox in pairs(EditBoxes) do
		GW.SkinTextBox(_G[EditBox:GetName() .. "Middle"], _G[EditBox:GetName() .. "Left"], _G[EditBox:GetName() .. "Right"])
	end

	ItemBuyFrame.BidFrame.BidButton:GwSkinButton(false, true)
	ItemBuyFrame.BidFrame.BidButton:ClearAllPoints()
	ItemBuyFrame.BidFrame.BidButton:SetPoint("LEFT", ItemBuyFrame.BidFrame.BidAmount, "RIGHT", 2, -2)

	--Item Sell Frame - TAB 2
	local SellFrame = AuctionHouseFrame.ItemSellFrame
	HandleSellFrame(SellFrame)

	local ItemSellList = AuctionHouseFrame.ItemSellList
	HandleSellList(ItemSellList, true, true)

	local CommoditiesSellFrame = AuctionHouseFrame.CommoditiesSellFrame
	HandleSellFrame(CommoditiesSellFrame)

	local CommoditiesSellList = AuctionHouseFrame.CommoditiesSellList
	HandleSellList(CommoditiesSellList, true)

	local TokenSellFrame = AuctionHouseFrame.WoWTokenSellFrame
	HandleTokenSellFrame(TokenSellFrame)

	--Auctions Frame - TAB 3
	SkinItemDisplay(AuctionHouseFrameAuctionsFrame)
	AuctionHouseFrameAuctionsFrame.BuyoutFrame.BuyoutButton:GwSkinButton(false, true)

	local CommoditiesList = AuctionHouseFrameAuctionsFrame.CommoditiesList
	HandleSellList(CommoditiesList, true)
	CommoditiesList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	hooksecurefunc(CommoditiesList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end)

	local AuctionsList = AuctionHouseFrameAuctionsFrame.ItemList
	HandleSellList(AuctionsList, true)
	AuctionsList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	hooksecurefunc(AuctionsList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end)

	local AuctionsFrameTabs = {
		AuctionHouseFrameAuctionsFrameAuctionsTab,
		AuctionHouseFrameAuctionsFrameBidsTab,
	}

	for _, tab in pairs(AuctionsFrameTabs) do
		if tab then
			GW.HandleTabs(tab, true)
		end
	end

	local SummaryList = AuctionHouseFrameAuctionsFrame.SummaryList
	HandleSellList(SummaryList)
	AuctionHouseFrameAuctionsFrame.CancelAuctionButton:GwSkinButton(false, true)

	SummaryList.ScrollBar:ClearAllPoints()
	SummaryList.ScrollBar:SetPoint("TOPRIGHT", SummaryList, -5, -20)
	SummaryList.ScrollBar:SetPoint("BOTTOMRIGHT", SummaryList, -5, 20)

	local AllAuctionsList = AuctionHouseFrameAuctionsFrame.AllAuctionsList
	HandleSellList(AllAuctionsList, true, true)
	AllAuctionsList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	hooksecurefunc(AllAuctionsList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end)
	AllAuctionsList.ResultsText:SetParent(AllAuctionsList.ScrollFrame)

	SummaryList:SetPoint("BOTTOM", AuctionHouseFrameAuctionsFrame, 0, 0) -- normally this is anchored to the cancel button.. ? lol
	AuctionHouseFrameAuctionsFrame.CancelAuctionButton:ClearAllPoints()
	AuctionHouseFrameAuctionsFrame.CancelAuctionButton:SetPoint("TOPRIGHT", AllAuctionsList, "BOTTOMRIGHT", -6, 1)

	local BidsList = AuctionHouseFrameAuctionsFrame.BidsList
	HandleSellList(BidsList, true, true)
	BidsList.ResultsText:SetParent(BidsList.ScrollFrame)
	BidsList.RefreshFrame.RefreshButton:GwSkinButton(false, true)
	hooksecurefunc(BidsList.RefreshFrame.RefreshButton.Icon, "SetDesaturated", function(self, value) if value == false then self:SetDesaturated(true) end end)

	EditBoxes = {
		AuctionHouseFrameAuctionsFrameGold,
		AuctionHouseFrameAuctionsFrameSilver,
	}

	for _, EditBox in pairs(EditBoxes) do
		GW.SkinTextBox(_G[EditBox:GetName() .. "Middle"], _G[EditBox:GetName() .. "Left"], _G[EditBox:GetName() .. "Right"])
	end

	AuctionHouseFrameAuctionsFrame.BidFrame.BidButton:GwSkinButton(false, true)

	--WoW Token Category
	local TokenFrame = AuctionHouseFrame.WoWTokenResults
	TokenFrame.Buyout:GwSkinButton(false, true)
	GW.HandleTrimScrollBar(TokenFrame.DummyScrollBar)
	GW.HandleScrollControls(TokenFrame, "DummyScrollBar")

	local Token = TokenFrame.TokenDisplay
	Token:GwStripTextures()
	Token:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)

	local ItemButton = Token.ItemButton
	GW.HandleIcon(ItemButton.Icon, true, GW.BackdropTemplates.ColorableBorderOnly)
	ItemButton.Icon.backdrop:SetBackdropBorderColor(0, .8, 1)
	ItemButton:GetHighlightTexture():Hide()
	ItemButton.CircleMask:Hide()
	ItemButton.IconBorder:GwKill()

	--WoW Token Tutorial Frame
	local WowTokenGameTimeTutorial = AuctionHouseFrame.WoWTokenResults.GameTimeTutorial
	WowTokenGameTimeTutorial.NineSlice:Hide()
	WowTokenGameTimeTutorial:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)
	WowTokenGameTimeTutorial.CloseButton:GwSkinButton(true)
	WowTokenGameTimeTutorial.RightDisplay.StoreButton:GwSkinButton(false, true)
	WowTokenGameTimeTutorial.Bg:SetAlpha(0)
	WowTokenGameTimeTutorial.LeftDisplay.Label:SetTextColor(1, 1, 1)
	WowTokenGameTimeTutorial.LeftDisplay.Tutorial1:SetTextColor(1, 0, 0)
	WowTokenGameTimeTutorial.RightDisplay.Label:SetTextColor(1, 1, 1)
	WowTokenGameTimeTutorial.RightDisplay.Tutorial1:SetTextColor(1, 0, 0)

	--Dialogs
	AuctionHouseFrame.BuyDialog:GwStripTextures()
	AuctionHouseFrame.BuyDialog:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)
	AuctionHouseFrame.BuyDialog.BuyNowButton:GwSkinButton(false, true)
	AuctionHouseFrame.BuyDialog.CancelButton:GwSkinButton(false, true)

	--Multisell
	local multisellFrame = AuctionHouseMultisellProgressFrame
	multisellFrame:GwStripTextures()
	multisellFrame:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder)

	local progressBar = multisellFrame.ProgressBar
	progressBar:GwStripTextures()
	progressBar:GwCreateBackdrop(GW.BackdropTemplates.DefaultWithSmallBorder, true)
	progressBar:SetStatusBarTexture("Interface/Addons/GW2_UI/textures/hud/castinbar-white")

	progressBar.Text:ClearAllPoints()
	progressBar.Text:SetPoint("BOTTOM", progressBar, "TOP", 0, 5)

	multisellFrame.CancelButton:GwSkinButton(true)
	GW.HandleIcon(progressBar.Icon, true, GW.BackdropTemplates.ColorableBorderOnly)
end

local function LoadAuctionHouseSkin()
	GW.RegisterLoadHook(ApplyAuctionHouseSkin, "Blizzard_AuctionHouseUI", AuctionHouseFrame)
end
GW.LoadAuctionHouseSkin = LoadAuctionHouseSkin
