local PANEL = {}

AccessorFunc(PANEL, "backgroundColor", "BackgroundColor")
AccessorFunc(PANEL, "backgroundAlpha", "BackgroundAlpha")

function PANEL:Init()
	self:SetSkin("metro")
	self:SetFont("MetroMenuButtonFont")
	self:SetTextColor(color_white)
	self:SetPaintBackground(false)
	self:SetContentAlignment(4)
	self:SetTextInset(8, 0)

	self.padding = {16, 8, 16, 8}
	self.backgroundColor = METRO.UI.GetAccentColor()
	self.backgroundAlpha = 128
	self.currentBackgroundAlpha = 0
end

function PANEL:SizeToContents()
	self:SetContentAlignment(4)
	surface.SetFont(self:GetFont())

	local width, height = surface.GetTextSize(self:GetText())
	self:SetSize(width + self.padding[1] + self.padding[3], height + self.padding[2] + self.padding[4])
end

function PANEL:PaintBackground(width, height)
	surface.SetDrawColor(ColorAlpha(self.backgroundColor, self.currentBackgroundAlpha))
	surface.DrawRect(0, 0, width, height)
end

function PANEL:Paint(width, height)
	self:PaintBackground(width, height)
end

function PANEL:OnCursorEntered()
	if self:GetDisabled() then
		return
	end

	self:CreateAnimation(0.15, {
		target = {currentBackgroundAlpha = self.backgroundAlpha}
	})
end

function PANEL:OnCursorExited()
	if self:GetDisabled() then
		return
	end

	self:CreateAnimation(0.15, {
		target = {currentBackgroundAlpha = 0}
	})
end

vgui.Register("metroMenuButton", PANEL, "DButton")

DEFINE_BASECLASS("metroMenuButton")
PANEL = {}

AccessorFunc(PANEL, "backgroundColor", "BackgroundColor")
AccessorFunc(PANEL, "selected", "Selected", FORCE_BOOL)
AccessorFunc(PANEL, "buttonList", "ButtonList")

function PANEL:Init()
	self.backgroundColor = METRO.UI.GetAccentColor()
	self.selected = false
	self.buttonList = {}
end

function PANEL:PaintBackground(width, height)
	local alpha = self.selected and 255 or self.currentBackgroundAlpha

	self:GetSkin():DrawImportantBackground(0, 0, width, height, ColorAlpha(self.backgroundColor, alpha))
end

function PANEL:SetSelected(value)
	self.selected = value

	if value then
		self:OnSelected()
	end
end

function PANEL:OnSelected()
end

function PANEL:SetButtonList(list, noAdd)
	if not noAdd then
		list[#list + 1] = self
	end

	self.buttonList = list
end

function PANEL:OnMousePressed(key)
	for _, button in pairs(self.buttonList) do
		if IsValid(button) and button ~= self then
			button:SetSelected(false)
		end
	end

	self:SetSelected(true)
	BaseClass.OnMousePressed(self, key)
end

vgui.Register("metroMenuSelectionButton", PANEL, "metroMenuButton")
