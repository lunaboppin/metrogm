METRO.Menu = METRO.Menu or {}

local PANELS = {}

local function RegisterPanel(definition)
	table.insert(PANELS, definition)
end

local function FormatMoney(amount)
	amount = math.floor(tonumber(amount) or 0)
	local formatted = tostring(amount)
	while true do
		local replaced, count = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		formatted = replaced
		if count == 0 then
			break
		end
	end
	return formatted
end

local function FormatPlaytime(totalSeconds)
	totalSeconds = math.floor(tonumber(totalSeconds) or 0)

	if totalSeconds < 60 then
		return totalSeconds .. "s"
	end

	local days = math.floor(totalSeconds / 86400)
	local hours = math.floor((totalSeconds % 86400) / 3600)
	local minutes = math.floor((totalSeconds % 3600) / 60)

	local parts = {}
	if days > 0 then
		table.insert(parts, days .. "d")
	end
	if hours > 0 then
		table.insert(parts, hours .. "h")
	end
	if minutes > 0 and days == 0 then
		table.insert(parts, minutes .. "m")
	end

	return table.concat(parts, " ")
end

local function FormatFirstSeen(value)
	if isnumber(value) then
		return os.date("%Y-%m-%d", value)
	end

	if isstring(value) and value ~= "" then
		return value:match("^(%d%d%d%d%-%d%d%-%d%d)") or value
	end

	return "Unknown"
end

METRO.Menu.FormatMoney = FormatMoney
METRO.Menu.FormatPlaytime = FormatPlaytime
METRO.Menu.FormatFirstSeen = FormatFirstSeen

local function CreateField(parent, y, labelText)
	local label = vgui.Create("DLabel", parent)
	label:SetPos(12, y)
	label:SetSize(380, 20)
	label:SetFont("DermaDefault")
	label:SetText(labelText)
	return label
end

local function BuildProfilePanel(parent)
	local panel = vgui.Create("DPanel", parent)
	panel:Dock(FILL)
	panel.Paint = function() end

	local nameLabel = CreateField(panel, 12, "Name: -")
	local moneyLabel = CreateField(panel, 40, "Money: -")
	local levelLabel = CreateField(panel, 68, "Level: -")

	local xpBar = vgui.Create("DProgress", panel)
	xpBar:SetPos(12, 96)
	xpBar:SetSize(380, 18)
	xpBar:SetFraction(0)

	local xpLabel = CreateField(panel, 118, "XP: -")
	local playtimeLabel = CreateField(panel, 146, "Playtime: -")
	local firstSeenLabel = CreateField(panel, 174, "First seen: -")

	panel.Refresh = function()
		local stats = METRO.Stats

		if not stats then
			nameLabel:SetText("Name: -")
			moneyLabel:SetText("Money: -")
			levelLabel:SetText("Level: -")
			xpBar:SetFraction(0)
			xpLabel:SetText("XP: -")
			playtimeLabel:SetText("Playtime: -")
			firstSeenLabel:SetText("First seen: -")
			return
		end

		nameLabel:SetText("Name: " .. tostring(stats.name or "-"))
		moneyLabel:SetText("Money: $" .. FormatMoney(stats.money))
		levelLabel:SetText("Level: " .. tostring(stats.level or "-"))

		local maxLevel = METRO.Levels.GetMaxLevel()
		local level, into, span, fraction = METRO.Levels.Progress(stats.xp or 0)
		xpBar:SetFraction(fraction)

		if level >= maxLevel then
			xpLabel:SetText("XP: Max level reached")
		else
			xpLabel:SetText("XP: " .. into .. " / " .. span)
		end

		playtimeLabel:SetText("Playtime: " .. FormatPlaytime(stats.playtime_seconds))
		firstSeenLabel:SetText("First seen: " .. FormatFirstSeen(stats.first_seen))
	end

	panel.Refresh()

	return panel
end

RegisterPanel({
	Label = "Profile",
	Icon = "icon16/user.png",
	Build = BuildProfilePanel,
})

local FRAME_WIDTH = 420
local FRAME_HEIGHT = 280

local frame

local function CreateMenuFrame()
	if IsValid(frame) then
		return frame
	end

	local newFrame = vgui.Create("DFrame")
	newFrame:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	newFrame:Center()
	newFrame:SetTitle("Metro")
	newFrame:SetDeleteOnClose(true)
	newFrame:MakePopup()

	local sheet = vgui.Create("DPropertySheet", newFrame)
	sheet:Dock(FILL)

	local panels = {}
	for _, definition in ipairs(PANELS) do
		local builtPanel = definition.Build(sheet)
		sheet:AddSheet(definition.Label, builtPanel, definition.Icon)
		table.insert(panels, builtPanel)
	end

	newFrame.Panels = panels
	newFrame.OnClose = function()
		frame = nil
	end

	frame = newFrame
	return newFrame
end

local function ToggleMenu()
	if IsValid(frame) then
		frame:Close()
		return
	end

	CreateMenuFrame()
end

METRO.Menu.Toggle = ToggleMenu

hook.Add("PlayerBindPress", "METRO_MenuKeybind", function(ply, bind, pressed)
	if not pressed or bind ~= "gm_showspare2" or ply:IsTyping() then
		return
	end

	ToggleMenu()
	return true
end)

hook.Add("MetroStatsUpdated", "METRO_MenuRefresh", function()
	if not IsValid(frame) or not frame.Panels then
		return
	end

	for _, panel in ipairs(frame.Panels) do
		if IsValid(panel) and panel.Refresh then
			panel.Refresh()
		end
	end
end)

return
