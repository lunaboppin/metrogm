METRO.Hud = METRO.Hud or {}
METRO.Hud.elements = METRO.Hud.elements or {}
METRO.Hud.hidden = METRO.Hud.hidden or {}

function METRO.Hud.Add(id, drawFunction)
	METRO.Hud.elements[id] = drawFunction
end

function METRO.Hud.Remove(id)
	METRO.Hud.elements[id] = nil
end

function METRO.Hud.SetHidden(name, hidden)
	METRO.Hud.hidden[name] = hidden and true or nil
end

function METRO.Hud.ShouldDraw(name)
	return METRO.Hud.hidden[name] ~= true
end

function METRO.Hud.DrawAll()
	for _, drawFunction in pairs(METRO.Hud.elements) do
		drawFunction()
	end
end

hook.Add("HUDPaint", "METRO_HudDrawAll", METRO.Hud.DrawAll)

function GM:HUDShouldDraw(name)
	return METRO.Hud.ShouldDraw(name)
end

local PANEL_X = 20
local PANEL_Y = 20
local PANEL_WIDTH = 260
local PANEL_HEIGHT = 70
local BAR_HEIGHT = 14

METRO.Hud.Add("metroProfile", function()
	local stats = METRO.Stats

	surface.SetDrawColor(20, 20, 20, 180)
	surface.DrawRect(PANEL_X, PANEL_Y, PANEL_WIDTH, PANEL_HEIGHT)

	if not stats then
		draw.SimpleText(
			METRO.LoadState == "error" and L("hudProfileError") or L("hudLoadingProfile"),
			"MetroHudLevel",
			PANEL_X + 10,
			PANEL_Y + 25,
			METRO.LoadState == "error" and Color(255, 90, 90) or Color(255, 255, 255),
			TEXT_ALIGN_LEFT,
			TEXT_ALIGN_CENTER
		)

		if METRO.LoadState == "error" and METRO.LoadError then
			draw.SimpleText(
				METRO.LoadError,
				"MetroHudLevel",
				PANEL_X + 10,
				PANEL_Y + 48,
				Color(255, 150, 150),
				TEXT_ALIGN_LEFT,
				TEXT_ALIGN_CENTER
			)
		end

		return
	end

	local level, _, _, fraction = METRO.Levels.Progress(tonumber(stats.xp) or 0)

	draw.SimpleText(
		L("hudMoneyFormat", METRO.Format.Money(stats.money)),
		"MetroHudMoney",
		PANEL_X + 10,
		PANEL_Y + 8,
		Color(120, 230, 140),
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_TOP
	)

	draw.SimpleText(
		L("hudLevelFormat", tostring(level)),
		"MetroHudLevel",
		PANEL_X + PANEL_WIDTH - 10,
		PANEL_Y + 12,
		Color(255, 255, 255),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_TOP
	)

	local barX, barY = PANEL_X + 10, PANEL_Y + 44
	local barWidth = PANEL_WIDTH - 20

	surface.SetDrawColor(0, 0, 0, 160)
	surface.DrawRect(barX, barY, barWidth, BAR_HEIGHT)

	surface.SetDrawColor(METRO.UI.GetAccentColor())
	surface.DrawRect(barX, barY, barWidth * METRO.Format.Clamp01(fraction), BAR_HEIGHT)

	surface.SetDrawColor(255, 255, 255, 60)
	surface.DrawOutlinedRect(barX, barY, barWidth, BAR_HEIGHT)
end)
