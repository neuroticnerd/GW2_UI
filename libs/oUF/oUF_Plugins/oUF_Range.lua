local _, ns = ...
local oUF = ns.oUF

local _FRAMES = {}
local OnRangeFrame

local UnitInRange, UnitIsConnected = UnitInRange, UnitIsConnected

local function Update(self, event)
	local element = self.customRange
	local unit = self.unit

	--[[ Callback: Range:PreUpdate()
	Called before the element has been updated.

	* self - the Range element
	--]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local inRange, checkedRange
	local connected = UnitIsConnected(unit)
	if(connected) then
		inRange, checkedRange = UnitInRange(unit)
		if(checkedRange and not inRange) or UnitPhaseReason(unit) then
			-- out of range
			local r, g, b = self.Health:GetStatusBarColor()
			self.Health:SetStatusBarColor(r * 0.3, g * 0.3, b * 0.3)
			self.MiddleIcon:SetAlpha(element.outsideAlpha)
		else
			self.MiddleIcon:SetAlpha(element.insideAlpha)
		end
	else
		self.MiddleIcon:SetAlpha(element.insideAlpha)
		self.Health.PostUpdateColor(self.Health, unit)
	end

	--[[ Callback: Range:PostUpdate(object, inRange, checkedRange, isConnected)
	Called after the element has been updated.

	* self         - the Range element
	* object       - the parent object
	* inRange      - indicates if the unit was within 40 yards of the player (boolean)
	* checkedRange - indicates if the range check was actually performed (boolean)
	* isConnected  - indicates if the unit is online (boolean)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(self, inRange, checkedRange, connected)
	end
end

local function Path(self, ...)
	--[[ Override: Range.Override(self, event)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	--]]
	return (self.Range.Override or Update) (self, ...)
end

-- Internal updating method
local timer = 0
local function OnRangeUpdate(_, elapsed)
	timer = timer + elapsed

	if(timer >= .20) then
		for _, object in next, _FRAMES do
			if(object:IsShown()) then
				Path(object, 'OnUpdate')
			end
		end

		timer = 0
	end
end

local function Enable(self)
	local element = self.customRange
	if(element) then
		element.__owner = self
		element.insideAlpha = element.insideAlpha or 1
		element.outsideAlpha = element.outsideAlpha or 0.4

		if(not OnRangeFrame) then
			OnRangeFrame = CreateFrame('Frame')
			OnRangeFrame:SetScript('OnUpdate', OnRangeUpdate)
		end

		table.insert(_FRAMES, self)
		OnRangeFrame:Show()

		return true
	end
end

local function Disable(self)
	local element = self.customRange
	if(element) then
		for index, frame in next, _FRAMES do
			if(frame == self) then
				table.remove(_FRAMES, index)
				break
			end
		end
		self.MiddleIcon:SetAlpha(element.insideAlpha)

		if(#_FRAMES == 0) then
			OnRangeFrame:Hide()
		end
	end
end

oUF:AddElement('GW2_Range', nil, Enable, Disable)
