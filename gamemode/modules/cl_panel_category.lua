local PANEL = {}

AccessorFunc(PANEL, "text", "Text", FORCE_STRING)
AccessorFunc(PANEL, "color", "Color")

function PANEL:Init()
	self:SetSkin("metro")

	self.text = ""
	self.paddingTop = 32

	surface.SetFont("MetroCategoryFont")
	self.paddingTop = select(2, surface.GetTextSize("W")) + 6

	self:DockPadding(1, self.paddingTop, 1, 1)
end

function PANEL:SizeToContents()
	local height = self.paddingTop + 1

	for _, child in ipairs(self:GetChildren()) do
		if IsValid(child) and child:IsVisible() then
			local _, top, _, bottom = child:GetDockMargin()

			height = height + child:GetTall() + top + bottom
		end
	end

	self:SetTall(height)
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintCategoryPanel", self, self.text, self.color)
end

vgui.Register("metroCategory", PANEL, "EditablePanel")
