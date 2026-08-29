METRO.Bar = METRO.Bar or {}
METRO.Bar.list = METRO.Bar.list or {}

local BAR_WIDTH = 220
local BAR_HEIGHT = 18
local BAR_LIFETIME = 5

function METRO.Bar.Get(identifier)
	for _, bar in ipairs(METRO.Bar.list) do
		if bar.identifier == identifier then
			return bar
		end
	end
end

function METRO.Bar.Remove(identifier)
	local bar = METRO.Bar.Get(identifier)

	if bar then
		table.remove(METRO.Bar.list, bar.index)

		if IsValid(METRO.Bar.manager) then
			METRO.Bar.manager:RemoveBar(bar)
		end
	end
end

function METRO.Bar.Add(getValue, color, priority, identifier)
	if identifier and METRO.Bar.Get(identifier) then
		METRO.Bar.Remove(identifier)
	end

	local index = #METRO.Bar.list + 1

	METRO.Bar.list[index] = {
		GetValue = getValue,
		color = color or METRO.UI.GetAccentColor(),
		priority = priority or index,
		identifier = identifier,
		index = index,
	}

	if IsValid(METRO.Bar.manager) then
		METRO.Bar.manager:AddBar(index)
	end

	return index
end

local PANEL = {}

AccessorFunc(PANEL, "padding", "Padding", FORCE_NUMBER)

function PANEL:Init()
	self:SetSkin("metro")
	self:SetSize(BAR_WIDTH, ScrH())
	self:SetPos(20, 20)
	self:ParentToHUD()

	self.bars = {}
	self.padding = 2

	for index in ipairs(METRO.Bar.list) do
		self:AddBar(index)
	end
end

function PANEL:AddBar(index)
	local panel = self:Add("metroInfoBar")
	panel:SetSize(self:GetWide(), BAR_HEIGHT)
	panel:SetVisible(false)
	panel:SetBarIndex(index)

	self.bars[#self.bars + 1] = panel

	return panel
end

function PANEL:RemoveBar(bar)
	for i, panel in ipairs(self.bars) do
		if panel:GetBarIndex() == bar.index then
			panel:Remove()
			table.remove(self.bars, i)
			break
		end
	end
end

function PANEL:Organize()
	local currentY = 0

	for _, panel in ipairs(self.bars) do
		if panel:IsVisible() then
			panel:SetPos(0, currentY)
			currentY = currentY + self.padding + panel:GetTall()
		end
	end

	self:SetTall(currentY)
end

function PANEL:UpdateBar(panel)
	local info = METRO.Bar.list[panel:GetBarIndex()]

	if not info then
		panel:SetVisible(false)
		return
	end

	local realValue, barText = info.GetValue()

	if realValue == false or realValue == nil then
		panel:SetVisible(false)
		return
	end

	local curTime = CurTime()

	if panel:GetTargetValue() ~= realValue then
		panel:SetLifetime(curTime + BAR_LIFETIME)
		panel:SetTargetValue(realValue)
	end

	if panel:GetLifetime() < curTime then
		panel:SetVisible(false)
		return
	end

	panel:SetVisible(true)
	panel:SetText(isstring(barText) and barText or "")
end

function PANEL:Think()
	for _, panel in ipairs(self.bars) do
		self:UpdateBar(panel)
	end

	self:Organize()
end

vgui.Register("metroInfoBarManager", PANEL, "Panel")

PANEL = {}

AccessorFunc(PANEL, "barIndex", "BarIndex", FORCE_NUMBER)
AccessorFunc(PANEL, "targetValue", "TargetValue", FORCE_NUMBER)
AccessorFunc(PANEL, "delta", "Delta", FORCE_NUMBER)
AccessorFunc(PANEL, "lifetime", "Lifetime", FORCE_NUMBER)

function PANEL:Init()
	self:SetSkin("metro")

	self.targetValue = 0
	self.delta = 0
	self.lifetime = 0

	self.label = self:Add("DLabel")
	self.label:SetFont("MetroSegmentedProgressFont")
	self.label:SetContentAlignment(5)
	self.label:SetTextColor(color_white)
	self.label:Dock(FILL)
end

function PANEL:SetText(text)
	self.label:SetText(text)
end

function PANEL:Think()
	self.delta = METRO.Format.Approach(self.delta, self.targetValue, FrameTime())
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintInfoBarBackground", self, width, height)

	local info = METRO.Bar.list[self.barIndex]
	local barWidth = width * METRO.Format.Clamp01(self.delta)

	derma.SkinFunc("PaintInfoBar", self, barWidth, height, info and info.color)
end

vgui.Register("metroInfoBar", PANEL, "Panel")

hook.Add("InitPostEntity", "METRO_CreateBarManager", function()
	if IsValid(METRO.Bar.manager) then
		METRO.Bar.manager:Remove()
	end

	METRO.Bar.manager = vgui.Create("metroInfoBarManager")
end)
