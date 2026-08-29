local PANEL_X = 20
local PANEL_Y = 20
local PANEL_WIDTH = 260
local BAR_HEIGHT = 14

surface.CreateFont("MetroHudMoney", {
	font = "Tahoma",
	size = 22,
	weight = 700,
	antialias = true,
})

surface.CreateFont("MetroHudLevel", {
	font = "Tahoma",
	size = 16,
	weight = 500,
	antialias = true,
})

local function formatMoney(amount)
	amount = math.floor(tonumber(amount) or 0)

	local sign = ""
	if amount < 0 then
		sign = "-"
		amount = -amount
	end

	local digits = tostring(amount)
	local grouped = digits:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	return sign .. grouped
end

local function drawXpBar(x, y, width, height, fraction)
	surface.SetDrawColor(0, 0, 0, 160)
	surface.DrawRect(x, y, width, height)

	surface.SetDrawColor(80, 170, 255, 220)
	surface.DrawRect(x, y, math.Clamp(width * fraction, 0, width), height)

	surface.SetDrawColor(255, 255, 255, 60)
	surface.DrawOutlinedRect(x, y, width, height)
end

hook.Add("HUDPaint", "MetroHud", function()
	local stats = METRO.Stats

	surface.SetDrawColor(20, 20, 20, 180)
	surface.DrawRect(PANEL_X, PANEL_Y, PANEL_WIDTH, 70)

	if not stats then
		draw.SimpleText(
			METRO.LoadState == "error" and "Profile error" or "Loading profile...",
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
		"$" .. formatMoney(stats.money),
		"MetroHudMoney",
		PANEL_X + 10,
		PANEL_Y + 8,
		Color(120, 230, 140),
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_TOP
	)

	draw.SimpleText(
		"Lv " .. tostring(level),
		"MetroHudLevel",
		PANEL_X + PANEL_WIDTH - 10,
		PANEL_Y + 12,
		Color(255, 255, 255),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_TOP
	)

	drawXpBar(PANEL_X + 10, PANEL_Y + 44, PANEL_WIDTH - 20, BAR_HEIGHT, fraction)
end)
