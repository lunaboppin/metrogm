local PANEL = {}

AccessorFunc(PANEL, "font", "Font", FORCE_STRING)
AccessorFunc(PANEL, "barColor", "BarColor")
AccessorFunc(PANEL, "textColor", "TextColor")
AccessorFunc(PANEL, "progress", "Progress", FORCE_NUMBER)
AccessorFunc(PANEL, "padding", "Padding", FORCE_NUMBER)

function PANEL:Init()
	self:SetSkin("metro")

	self.segments = {}
	self.fraction = 0
	self.progress = 0
	self.padding = 4
end

function PANEL:AddSegment(text)
	local id = #self.segments + 1

	self.segments[id] = text

	return id
end

function PANEL:AddSegments(...)
	local segments = {...}

	for i = 1, #segments do
		self:AddSegment(segments[i])
	end
end

function PANEL:GetSegments()
	return self.segments
end

function PANEL:SetProgress(segment)
	self.progress = math.Clamp(segment, 0, #self.segments)
	self.fraction = METRO.Format.SegmentFraction(self.progress, #self.segments)
end

function PANEL:SetFraction(fraction)
	self.fraction = METRO.Format.Clamp01(fraction)
end

function PANEL:GetFraction()
	return self.fraction
end

function PANEL:SizeToContents()
	self:SetTall(draw.GetFontHeight(self.font or "MetroSegmentedProgressFont") + self.padding)
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintSegmentedProgressBackground", self, width, height)
	derma.SkinFunc("PaintSegmentedProgress", self, width, height)
end

vgui.Register("metroSegmentedProgress", PANEL, "Panel")
