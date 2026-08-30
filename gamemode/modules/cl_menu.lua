METRO.Menu = METRO.Menu or {}

local menu
local sessionStarted = false
local sessionGate = false
local fleet = {}
local selectedTrainClass

local function addLabel(parent, text, font, color)
	local label = vgui.Create("DLabel", parent)
	label:SetFont(font or "MetroDashboardBody")
	label:SetTextColor(color or color_white)
	label:SetText(text)
	label:SetWrap(true)
	label:SetAutoStretchVertical(true)
	label:Dock(TOP)
	label:DockMargin(0, 0, 0, ScreenScale(4))
	return label
end

local function addButton(parent, text, callback)
	local button = vgui.Create("DButton", parent)
	button:SetText(text)
	button:SetFont("MetroDashboardButton")
	button:SetTextColor(color_white)
	button:Dock(TOP)
	button:SetTall(ScreenScale(17))
	button:DockMargin(0, 0, 0, ScreenScale(4))
	button.Paint = function(self, width, height)
		local accent = METRO.UI.GetAccentColor()
		surface.SetDrawColor(self:IsHovered() and Color(accent.r, accent.g, accent.b, 255) or Color(accent.r, accent.g, accent.b, 180))
		surface.DrawRect(0, 0, width, height)
	end
	button.DoClick = callback
	return button
end

local function addCard(parent)
	local card = vgui.Create("EditablePanel", parent)
	card:Dock(TOP)
	card:DockMargin(0, 0, 0, ScreenScale(5))
	card:DockPadding(ScreenScale(7), ScreenScale(7), ScreenScale(7), ScreenScale(7))
	card.Paint = function(_, width, height)
		surface.SetDrawColor(10, 16, 22, 235)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(METRO.UI.GetAccentColor())
		surface.DrawOutlinedRect(0, 0, width, height)
	end
	return card
end

local function buildProfile(container)
	local card = addCard(container)
	card:SetTall(ScreenScale(115))
	local name = addLabel(card, L("menuNameUnknown"), "MetroDashboardTitle")
	local money = addLabel(card, L("menuMoneyUnknown"))
	local level = addLabel(card, L("menuLevelUnknown"))
	local xp = addLabel(card, L("menuXpUnknown"))
	local playtime = addLabel(card, L("menuPlaytimeUnknown"))
	local firstSeen = addLabel(card, L("menuFirstSeenUnknown"))
	card.Refresh = function()
		local stats = METRO.Stats
		if not stats then return end
		local currentLevel, into, span = METRO.Levels.Progress(stats.xp or 0)
		name:SetText(L("menuNameFormat", tostring(stats.name or "-")))
		money:SetText(L("menuMoneyFormat", METRO.Format.Money(stats.money)))
		level:SetText(L("menuLevelFormat", tostring(stats.level or "-")))
		xp:SetText(currentLevel >= METRO.Levels.GetMaxLevel() and L("menuXpMaxLevel") or L("menuXpFormat", into, span))
		playtime:SetText(L("menuPlaytimeFormat", METRO.Format.Playtime(stats.playtime_seconds)))
		firstSeen:SetText(L("menuFirstSeenFormat", METRO.Format.FirstSeen(stats.first_seen, L("menuFirstSeenUnknownValue"))))
		card:InvalidateLayout(true)
	end
	card.Refresh()
	return card
end

local function buildGuide(container)
	local card = addCard(container)
	card:SetTall(ScreenScale(145))
	addLabel(card, L("dashboardGuideTitle"), "MetroDashboardTitle")
	addLabel(card, L("dashboardGuideService"))
	addLabel(card, L("dashboardGuideControls"))
	addLabel(card, L("dashboardGuideDriving"))
	addLabel(card, L("dashboardGuideDoors"))
	addLabel(card, L("dashboardGuideDepot"))
	return card
end

local function buildHome(container, dashboard)
	local card = addCard(container)
	card:SetTall(ScreenScale(105))
	addLabel(card, L("dashboardHomeTitle"), "MetroDashboardTitle")
	addLabel(card, L("dashboardHomeService"))
	addLabel(card, L("dashboardHomeDescription"))
	addButton(card, sessionGate and L("dashboardStartService") or L("dashboardOpenFleet"), function()
		if sessionGate then
			net.Start("MetroServiceStart")
			net.SendToServer()
		else
			dashboard:SelectTab("dashboardFleetTab")
		end
	end)
	return card
end

local function trainStatus(train)
	if train.status == "available" then return L("dashboardTrainAvailable") end
	if train.status == "locked" then
		if train.reason == "trainLevelLocked" and train.requiredLevel > 0 then return L("dashboardTrainLockedLevel", train.requiredLevel) end
		return L(train.reason ~= "" and train.reason or "trainUnavailable")
	end
	return L("dashboardTrainComingSoon")
end

local function buildFleet(container)
	local scroll = vgui.Create("DScrollPanel", container)
	scroll:Dock(FILL)
	scroll:GetVBar():SetWide(ScreenScale(4))
	scroll.Refresh = function()
		scroll:Clear()
		if #fleet == 0 then
			addLabel(scroll, L("dashboardFleetLoading"))
			return
		end
		for _, train in ipairs(fleet) do
			local card = addCard(scroll)
			card:SetTall(ScreenScale(selectedTrainClass == train.className and 95 or 72))
			addLabel(card, train.displayName, "MetroDashboardTitle")
			addLabel(card, train.className, "MetroDashboardSmall", Color(170, 190, 205))
			addLabel(card, trainStatus(train))
			if train.status == "available" then
				if selectedTrainClass == train.className then
					addLabel(card, L("dashboardSpawnConfirm"), "MetroDashboardSmall")
					addButton(card, L("dashboardSpawnAtDepot"), function()
						net.Start("MetroServiceSpawn")
						net.WriteString(train.className)
						net.SendToServer()
					end)
				else
					addButton(card, L("dashboardSelectTrain"), function()
						selectedTrainClass = train.className
						scroll.Refresh()
					end)
				end
			end
			card:InvalidateLayout(true)
		end
	end
	scroll.Refresh()

	local function requestFleet()
		net.Start("MetroServiceFleetRequest")
		net.SendToServer()
	end

	requestFleet()
	timer.Create("MetroFleetRetry", 1, 8, function()
		if #fleet > 0 or not IsValid(scroll) then
			timer.Remove("MetroFleetRetry")
			return
		end
		requestFleet()
	end)

	return scroll
end

local PANEL = {}

function PANEL:Init()
	self.openTime = SysTime()
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:SetKeyboardInputEnabled(true)
	self:MakePopup()
	self.tabs = {}
	self.panels = {}
	local sidebar = self:Add("EditablePanel")
	sidebar:Dock(LEFT)
	sidebar:SetWide(math.Clamp(ScrW() * 0.22, 230, 360))
	sidebar:DockPadding(ScreenScale(8), ScreenScale(10), ScreenScale(8), ScreenScale(8))
	sidebar.Paint = function(_, width, height)
		surface.SetDrawColor(5, 10, 15, 245)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(METRO.UI.GetAccentColor())
		surface.DrawRect(width - 2, 0, 2, height)
	end
	addLabel(sidebar, L("dashboardBrand"), "MetroDashboardBrand", METRO.UI.GetAccentColor())
	addLabel(sidebar, L("dashboardSubtitle"), "MetroDashboardSmall", Color(170, 190, 205))
	self.content = self:Add("EditablePanel")
	self.content:Dock(FILL)
	self.content:DockPadding(ScreenScale(14), ScreenScale(14), ScreenScale(14), ScreenScale(14))
	self.errorLabel = addLabel(self.content, "", "MetroDashboardBody", Color(255, 120, 120))
	self.errorLabel:SetVisible(false)
	for _, key in ipairs({ "dashboardHomeTab", "dashboardFleetTab", "dashboardMapTab", "dashboardProfileTab", "dashboardGuideTab" }) do
		self.tabs[key] = addButton(sidebar, L(key), function() self:SelectTab(key) end)
	end
	if not sessionGate then
		local spacer = sidebar:Add("Panel")
		spacer:Dock(FILL)
		addButton(sidebar, L("dashboardClose"), function() self:Remove() end)
	end
	self:SelectTab("dashboardHomeTab")
end

function PANEL:SelectTab(key)
	if not self.panels[key] then
		if key == "dashboardHomeTab" then self.panels[key] = buildHome(self.content, self)
		elseif key == "dashboardFleetTab" then self.panels[key] = buildFleet(self.content)
		elseif key == "dashboardMapTab" then self.panels[key] = self.content:Add("metroRailmap")
		elseif key == "dashboardProfileTab" then self.panels[key] = buildProfile(self.content)
		else self.panels[key] = buildGuide(self.content) end
	end
	for panelKey, panel in pairs(self.panels) do panel:SetVisible(panelKey == key) end
	for tabKey, button in pairs(self.tabs) do button:SetTextColor(tabKey == key and color_white or Color(180, 195, 205)) end
end

function PANEL:SetError(message)
	self.errorLabel:SetText(message or "")
	self.errorLabel:SetVisible(message and message ~= "")
	self.content:InvalidateLayout(true)
end

function PANEL:Paint(width, height)
	Derma_DrawBackgroundBlur(self, self.openTime)
	surface.SetDrawColor(3, 8, 12, 210)
	surface.DrawRect(0, 0, width, height)
end

function PANEL:OnKeyCodePressed(key)
	if key == KEY_ESCAPE and not sessionGate then self:Remove() end
end

function PANEL:OnRemove()
	if menu == self then menu = nil end
end

vgui.Register("metroMenu", PANEL, "EditablePanel")

function METRO.Menu.Open()
	if not IsValid(menu) then menu = vgui.Create("metroMenu") end
	return menu
end

function METRO.Menu.Toggle()
	if IsValid(menu) then
		if not sessionGate then menu:Remove() end
		return
	end
	METRO.Menu.Open()
end

local function refreshMenu()
	if not IsValid(menu) then return end
	for _, panel in pairs(menu.panels) do if panel.Refresh then panel.Refresh() end end
end

hook.Add("MetroStatsUpdated", "MetroDashboardStats", function()
	if METRO.LoadState == "ready" and not sessionStarted then
		sessionGate = true
		METRO.Menu.Open()
	end
	refreshMenu()
end)

hook.Add("MetroLoadStateChanged", "MetroDashboardLoad", function(state)
	if state == "ready" and METRO.Stats and not sessionStarted then
		sessionGate = true
		METRO.Menu.Open()
	end
end)

hook.Add("PlayerBindPress", "MetroDashboardKeybind", function(ply, bind, pressed)
	if pressed and bind == "gm_showspare2" and not ply:IsTyping() then
		METRO.Menu.Toggle()
		return true
	end
end)

net.Receive("MetroServiceFleet", function()
	fleet = {}
	for _ = 1, net.ReadUInt(16) do
		table.insert(fleet, { className = net.ReadString(), displayName = net.ReadString(), status = net.ReadString(), reason = net.ReadString(), requiredLevel = net.ReadUInt(8) })
	end
	if IsValid(menu) and menu.panels.dashboardFleetTab and menu.panels.dashboardFleetTab.Refresh then menu.panels.dashboardFleetTab.Refresh() end
end)

net.Receive("MetroServiceResult", function()
	local action = net.ReadString()
	local success = net.ReadBool()
	local message = net.ReadString()
	net.ReadString()
	if action == "start" and success then
		sessionStarted = true
		sessionGate = false
		if IsValid(menu) then menu:Remove() end
		METRO.Menu.Open():SelectTab("dashboardFleetTab")
		return
	end
	if action == "spawn" and success then
		if IsValid(menu) then menu:Remove() end
		return
	end
	if message ~= "" then
		if IsValid(menu) then
			menu:SetError(L(message))
			menu:SelectTab("dashboardFleetTab")
		else
			chat.AddText(METRO.UI.GetAccentColor(), L(message))
		end
	end
end)
