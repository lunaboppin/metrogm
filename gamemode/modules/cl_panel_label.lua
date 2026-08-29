local PANEL = {}

AccessorFunc(PANEL, "text", "Text", FORCE_STRING)
AccessorFunc(PANEL, "color", "Color")
AccessorFunc(PANEL, "font", "Font", FORCE_STRING)
AccessorFunc(PANEL, "padding", "Padding", FORCE_NUMBER)

function PANEL:Init()
	self:SetSkin("metro")

	self.text = ""
	self.color = color_white
	self.font = "MetroLabelFont"
	self.padding = 4
end

function PANEL:SetText(text)
	self.text = text or ""
	self.contentSize = nil
end

function PANEL:GetContentSize()
	if not self.contentSize then
		surface.SetFont(self.font)
		self.contentSize = {surface.GetTextSize(self.text)}
	end

	return self.contentSize[1], self.contentSize[2]
end

function PANEL:SizeToContents()
	local contentWidth, contentHeight = self:GetContentSize()
	self:SetSize(contentWidth + self.padding * 2, contentHeight + self.padding * 2)
end

function PANEL:Paint(width, height)
	surface.SetFont(self.font)
	surface.SetTextColor(self.color)
	surface.SetTextPos(self.padding, self.padding)
	surface.DrawText(self.text)
end

vgui.Register("metroLabel", PANEL, "Panel")
