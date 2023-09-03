local _, GW = ...

local function Construct_HealtValueText(frame)
    local healthValue = GW.CreateRaisedText(frame.RaisedElementParent)

    healthValue:SetShadowOffset(-1, -1)
    healthValue:SetShadowColor(0, 0, 0, 1)
    healthValue:SetJustifyH("LEFT")
    healthValue:SetFont(UNIT_NAME_FONT, 11)

	healthValue:SetPoint('TOPLEFT', frame.Name, "TOPLEFT", 2, -14)

	return healthValue
end
GW.Construct_HealtValueText = Construct_HealtValueText

local function UpdateHealtValueTextSettings(frame)
    local name = frame.HealthValueText
    frame:Tag(name, ("[GW2_Grid:healtValue(%s)]"):format(frame.healthStringFormat))
end
GW.UpdateHealtValueTextSettings = UpdateHealtValueTextSettings