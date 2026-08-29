METRO.UI = METRO.UI or {}
METRO.UI.accentColor = METRO.UI.accentColor or Color(80, 170, 255)

function derma.SkinFunc(name, panel, a, b, c, d, e, f, g)
	local skin = ispanel(panel) and IsValid(panel) and panel:GetSkin() or derma.GetDefaultSkin()

	if not skin or not skin[name] then
		return
	end

	return skin[name](skin, panel, a, b, c, d, e, f, g)
end

function METRO.UI.GetAccentColor()
	return METRO.UI.accentColor
end

function METRO.UI.SetAccentColor(color)
	METRO.UI.accentColor = color
	hook.Run("MetroColorSchemeChanged", color)
end

local SKIN = {}
derma.DefineSkin("metro", "The Metro gamemode skin.", SKIN)

SKIN.fontCategory = "MetroCategoryFont"
SKIN.fontSegmentedProgress = "MetroSegmentedProgressFont"

SKIN.Colours = table.Copy(derma.SkinList.Default.Colours)
SKIN.Colours.SegmentedProgress = {}
SKIN.Colours.SegmentedProgress.Bar = Color(64, 185, 85)
SKIN.Colours.SegmentedProgress.Text = color_white

function SKIN:DrawImportantBackground(x, y, width, height, color)
	surface.SetDrawColor(color or METRO.UI.GetAccentColor())
	surface.DrawRect(x, y, width, height)
end

function SKIN:PaintCategoryPanel(panel, text, color)
	text = text or ""
	color = color or METRO.UI.GetAccentColor()

	surface.SetFont(self.fontCategory)

	local textHeight = select(2, surface.GetTextSize(text)) + 6
	local width, height = panel:GetSize()

	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(0, textHeight, width, height - textHeight)

	self:DrawImportantBackground(0, 0, width, textHeight, color)

	surface.SetTextColor(color_white)
	surface.SetTextPos(4, 3)
	surface.DrawText(text)

	surface.SetDrawColor(color)
	surface.DrawOutlinedRect(0, 0, width, height)

	return 1, textHeight, 1, 1
end

function SKIN:PaintSegmentedProgressBackground(panel, width, height)
	surface.SetDrawColor(0, 0, 0, 160)
	surface.DrawRect(0, 0, width, height)
end

function SKIN:PaintSegmentedProgress(panel, width, height)
	local font = panel:GetFont() or self.fontSegmentedProgress
	local textColor = panel:GetTextColor() or self.Colours.SegmentedProgress.Text
	local barColor = panel:GetBarColor() or self.Colours.SegmentedProgress.Bar
	local segments = panel:GetSegments()
	local segmentHalfWidth = width / math.max(#segments, 1) * 0.5

	surface.SetDrawColor(barColor)
	surface.DrawRect(0, 0, panel:GetFraction() * width, height)

	surface.SetDrawColor(255, 255, 255, 60)
	surface.DrawOutlinedRect(0, 0, width, height)

	for i = 1, #segments do
		local text = segments[i]
		local x = (i - 1) / #segments * width + segmentHalfWidth
		local y = height * 0.5

		draw.SimpleText(text, font, x, y, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function SKIN:PaintMenuBackground(panel, width, height)
	surface.SetDrawColor(20, 20, 20, 235)
	surface.DrawRect(0, 0, width, height)

	surface.SetDrawColor(METRO.UI.GetAccentColor())
	surface.DrawOutlinedRect(0, 0, width, height)
end

function SKIN:PaintInfoBarBackground(panel, width, height)
	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawRect(0, 0, width, height)
end

function SKIN:PaintInfoBar(panel, width, height, color)
	color = color or METRO.UI.GetAccentColor()

	surface.SetDrawColor(color.r, color.g, color.b, 250)
	surface.DrawRect(0, 0, width, height)
end

derma.RefreshSkins()

local function LoadFonts()
	surface.CreateFont("MetroCategoryFont", {
		font = "Tahoma",
		size = ScreenScale(9),
		weight = 700,
		antialias = true,
	})

	surface.CreateFont("MetroSegmentedProgressFont", {
		font = "Tahoma",
		size = ScreenScale(8),
		weight = 500,
		antialias = true,
	})

	surface.CreateFont("MetroLabelFont", {
		font = "Tahoma",
		size = ScreenScale(9),
		weight = 500,
		antialias = true,
	})

	surface.CreateFont("MetroMenuButtonFont", {
		font = "Tahoma",
		size = ScreenScale(8),
		weight = 600,
		antialias = true,
	})

	surface.CreateFont("MetroNoticeFont", {
		font = "Tahoma",
		size = ScreenScale(8),
		weight = 500,
		antialias = true,
	})

	surface.CreateFont("MetroHudMoney", {
		font = "Tahoma",
		size = ScreenScale(11),
		weight = 700,
		antialias = true,
	})

	surface.CreateFont("MetroHudLevel", {
		font = "Tahoma",
		size = ScreenScale(8),
		weight = 500,
		antialias = true,
	})
end

METRO.UI.LoadFonts = LoadFonts
LoadFonts()

hook.Add("ScreenResolutionChanged", "METRO_ReloadFonts", function()
	LoadFonts()
end)

concommand.Add("metro_accentcolor", function(_, _, args)
	local r = tonumber(args[1])
	local g = tonumber(args[2])
	local b = tonumber(args[3])

	if not (r and g and b) then
		return
	end

	METRO.UI.SetAccentColor(Color(r, g, b))
end)
